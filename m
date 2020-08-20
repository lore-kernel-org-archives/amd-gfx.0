Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D79C433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 10:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74FE2075E
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 10:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K39iwEKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74FE2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10B826E92B;
	Thu, 20 Aug 2020 10:05:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3963C6E92B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 10:05:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmocuvVWfBjjnXfE8PHvR5PEbN91RqCxVki1zn2FZY9vI7iqa0yJFHAS+EOOYp3itb7u3E0d6dnBpy43sLQq7HNabFHc/Yy3EHO+3GrcfMHchldFd67uQjSMJkTQcw3mLTK+lx1X1GoPIoJAAoLY8xUTdWtjE97hdewKXk/JbQuoDHBRae0G8hep2bX4+zDWa59f5QX0g0AFFTpzbFFh8nYEYh4HN4ifu/f6jFUhx/RLGfEXgpBk3VSjzh89+dKCN3pdDJny3mAUnJmgfZJOcAfSIMteuisuM6oGXteu/q86d1F/iQ353/I2IOBC3D8mhN1SXNHreGn0hHfKcOpG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjU+R318o0UPAIqWC2i9iijyj6b9GgbhnxAIzG8m5mM=;
 b=ncwKaOePhqvW8HTkixaunNM9QwvWZP4pESYMkv57s8sQLy5k/F/oqjRCsG9BkZLCX1/omaCH9pGVosSCLClhcZNldeooc4gnC/c0gLVEJmlJtm6ANaAU/zxlvgLUJuihKW1LMLlyq9JYrqjTIoRhCGPkEHMynR1+A49cU20Bqyb3QXrt2rolKm7nf2AFe+++/xB+bHacPwxoMReVMEYIZ3uAJpXf7m/q28fYYrgVoqyv0h3Lm7+NpGOXypmZox4N6lGn+gUsmM4JjkA1w8/r6tUmsdKpLFV+F8AhxQ8ZFHoQ2P1UeYSZ+hwC73dVqezqLFDf2W3Rt8B0OjhKf0bjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjU+R318o0UPAIqWC2i9iijyj6b9GgbhnxAIzG8m5mM=;
 b=K39iwEKHvkfeUPzkt5X8Bk90Gc3DrQDleQRVzE38SMjK3MFFuOn3PD5NJ/u7q1VjjsiZ4YkwzpWknivz1lLob2bsdY+8mApVdbb0w/oA1qM3i9EJGx5Sy8Maj0EErzApi5l0NFirJaoscOYC8MasrHYZBK8cq5UvUu5Sn6mMto4=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Thu, 20 Aug 2020 10:05:36 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 10:05:36 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix the nullptr issue when reenter GPU
 recovery
Thread-Topic: [PATCH] drm/amdgpu: fix the nullptr issue when reenter GPU
 recovery
Thread-Index: AQHWdpiINOJr0YJm9UWBlrzA+75TsqlAqRpAgAAE0ICAABcJcA==
Date: Thu, 20 Aug 2020 10:05:36 +0000
Message-ID: <DM6PR12MB40757BC38540F8E74D652DA2FC5A0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200820022041.19161-1-Dennis.Li@amd.com>
 <DM6PR12MB407534C794E66240356AFAD1FC5A0@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM5PR12MB2533F50DFC7A07A94EAFEABCED5A0@DM5PR12MB2533.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2533F50DFC7A07A94EAFEABCED5A0@DM5PR12MB2533.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-20T08:24:17Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a031eed9-41e0-4d28-965a-00003ecc9751;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-20T10:05:33Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 212c2f67-c9c4-4714-b995-00001e49b18c
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 092a948e-efb5-471a-e81e-08d844f095b6
x-ms-traffictypediagnostic: DM6PR12MB4217:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4217FFB5C55DA3A45A8A5977FC5A0@DM6PR12MB4217.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LRsKqgm9ra6WMHuVzCkuyvWh+f273haNFDSUvPRV60NbhwVPpUIcvRupWUdSXRYgs+NXcOomZA7Z5u3avySU7NgVeTHJHaRPQxUmKxNegf9232bjXsrD9O3v36Z9zzQnrwBtnPTXnB8tEYCG0mq3AqMPrHBSYqzIAqJP2jHyE2lXVGnT+MZn10v01WFwRbnqYmK65eqJVHOV5oXJ50mLsL0QR58F1iuslsPGkyf/2q//EiMh5y1WhAzECiH95R6SnTTbHnSlKBSALGlLWxeti6784YpH0iZSoyus7jrJE6CesHCyWVtMgafQGNO2JmOI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(316002)(110136005)(8676002)(6636002)(71200400001)(5660300002)(8936002)(6506007)(66476007)(66446008)(66946007)(478600001)(53546011)(2906002)(66556008)(83380400001)(64756008)(76116006)(33656002)(86362001)(52536014)(7696005)(186003)(55016002)(9686003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 79UDTvB8a6oU9QK6mXlCwcKkP+aog5QCDzNT4bAv4NkvoV9VT1YubNkjSzjGKoxxmMkMUmpwKIVpUUqzb0zgEh0gJxckyF/zmTkfisi/uwylQIkJEfrKd/prLE0Ngt+r4+6HgCHYPtCkIeYFWrqmzJ1MklNhA13tR4azrqRhdHcrRZxm7Svx1xJ7B+cBn9RIVu4qTuOfZledxpq6uMIhcAmFfmcy1W1pCTW/7xEx7JgUQHZKP4ijtRAjP98+MYgz5kL2xYQhmoi1eNwvwUWkURLt3RQ5/TCqptCZpBkkvXt16Qlo0SjYretWGcluN1XekFnScMh4amsy1lcoE/BVTdMXN/B+StlT9lGZgwbCUzA99q+4AynAWzk9m71Ru6DbLIdxh0/6VjyS3kXez4S+vHBp2AVbrCpfvE+GWI4sggi7ByT4ERobGIdvHDAKEbd/zZkyfr7kZo7melHyBzSveizjP98q2wteMKBkcTbNtQozfSeTl0H9gVVZYzeNiNHfqMJNQtiC6lgfa/gj9IO56wh0vBdMrlC1sGIpMpMLcI9TwsP3J2OML6g7VwSYUOP1iBXaHb7et44fkXoXGPAcbSxvsnZFt5a0DG8JqSCQJzTllZ/vnE139+3fQLMHQcUiF+wnF192xBK3gJaZXSuvdw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092a948e-efb5-471a-e81e-08d844f095b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 10:05:36.5137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAT3JsDWTAEtHGXQ35nm6IKXZHz2uj35lOX6AShjA6xXZCxgkSjnW0V9m+StAQwp0Y86JZ0RIoB3wmMaB9g24w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Thanks Dennis. Yes, that's valid case. skipping the reset and scheduler resume sound reasonable to me.

The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Li, Dennis <Dennis.Li@amd.com> 
Sent: Thursday, August 20, 2020 16:40
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix the nullptr issue when reenter GPU recovery

[AMD Public Use]

Hi, Hawking,
      When RAS uncorrectable error happens, RAS interrupt will trigger a GPU recovery.  At the same time, if a GFX or compute job is timeout, driver will trigger a new one. 

Best Regards
Dennis Li
-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Thursday, August 20, 2020 4:24 PM
To: Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix the nullptr issue when reenter GPU recovery

[AMD Public Use]

Hi Dennis,

Can you elaborate the case that driver re-enter GPU recovery in sGPU system? I'm wondering whether this is a valid case or we shall prevent this from the beginning.

Regards,
Hawking

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Thursday, August 20, 2020 10:21
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: fix the nullptr issue when reenter GPU recovery

in single gpu system, if driver reenter gpu recovery, amdgpu_device_lock_adev will return false, but hive is nullptr now.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 82242e2f5658..81b1d9a1dca0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4371,8 +4371,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (!amdgpu_device_lock_adev(tmp_adev)) {
 			DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
 				  job ? job->base.id : -1);
-			mutex_unlock(&hive->hive_lock);
-			return 0;
+			r = 0;
+			goto skip_recovery;
 		}
 
 		/*
@@ -4505,6 +4505,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		amdgpu_device_unlock_adev(tmp_adev);
 	}
 
+skip_recovery:
 	if (hive) {
 		atomic_set(&hive->in_reset, 0);
 		mutex_unlock(&hive->hive_lock);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
