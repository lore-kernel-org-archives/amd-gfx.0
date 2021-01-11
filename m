Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C77C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 04:07:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126A42247F
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 04:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126A42247F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69B86899A7;
	Mon, 11 Jan 2021 04:07:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7563A899AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 04:07:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxP1C/GzI01ddRAmIOYs0Lj93xr2+YhXYnDK9BripdaLuEX5ziVHXLAJe2khck+okdWLBwQe8D8+VSF6kl7OKu9qbbIPna4cBj2ZehbprW4eNhECSoKXwNxLHCBMfKrIl/e0kchL+54cCu7NUx9A2sYknXNHPMb6PkLmNdogYPY1sYKgzX16jh13lYJsLqDBzxGGRoJV6TBgdwE7BihsTFehj1bI+exVETwcgjcN3rJFmPHvgHcPlquTAeuuQUQIhKfBtERKzD2uWSmw6kmBVFYD93x2rtOZnFqI2AJh5Ryu7lY1GxXAPG/M5rmN0uJYWySEMSk+ztHWLd3Bvq/tYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJVJ/j1jMqoMIt+yUYHRdBLB5LF2LXOkT9ExFzjo+yk=;
 b=MZhhbzZTXo60vVfG4iq295fnE+mquq41jNP7Rdyl9TdwbBGXM14+7qFHjBjcw+pUJtqFsCd9PqHfal9Lopn55ul4TNuy1W+tqkxlrivtzMBUglXj0BmE320q5/jChdsXFthqiP3bEMEHbYG7JIDK2af3gm9iVzeAzd0ncZDelEcpRXq3ABwclHwrG9NucW2/6AiXY5cjEsiAynBeBaqbfnnYBFVjOecYBvCp8cR0/e5ACxHeYWwtJlKT2eg2FOh+plVp6RiAkIzc7Ocq/oQ+Mln2aXAojALVmNkqyv660772vtEqqyDgwDdRRkp2fFhQeKpb00TYKZ4uQukY3eEn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJVJ/j1jMqoMIt+yUYHRdBLB5LF2LXOkT9ExFzjo+yk=;
 b=l3iXYuKCnL3sjA2Ekc7nSgp4jaY6KiAVeF5UQeW7q3FX+QEIPrCyVNzienmayEX9CbkeC73GOH+1KQmeJBH/TnIicfjc4t0O4yXigJihY43UqEZD2vB/s/cSfgMtJLkUm1OabcFrp+TvC/VKZhRWprzKlcAPrkXsZnpB+d/MQnk=
Received: from BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29)
 by BYAPR12MB2774.namprd12.prod.outlook.com (2603:10b6:a03:71::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Mon, 11 Jan
 2021 04:07:43 +0000
Received: from BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::886a:6185:379a:c41c]) by BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::886a:6185:379a:c41c%6]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 04:07:43 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "Chen, Horace"
 <Horace.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix issue when 2 ring job timeout
Thread-Topic: [PATCH] drm/amdgpu: fix issue when 2 ring job timeout
Thread-Index: AQHW5Cl9cazjK7DmB0apGn+wE1/EF6odltAAgAQ+UFA=
Date: Mon, 11 Jan 2021 04:07:43 +0000
Message-ID: <BYAPR12MB2615965BC711BDB28671302EE4AB0@BYAPR12MB2615.namprd12.prod.outlook.com>
References: <20210106124258.31129-1-horace.chen@amd.com>
 <CY4PR12MB1573ED17C8D9078A8F1A4D65E1AE0@CY4PR12MB1573.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1573ED17C8D9078A8F1A4D65E1AE0@CY4PR12MB1573.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-08T11:34:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fc04de37-7944-44aa-a785-87f1fade6dc2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb781b3e-07e1-4ad9-caee-08d8b5e67211
x-ms-traffictypediagnostic: BYAPR12MB2774:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2774922A9D8EB42D1240083FE4AB0@BYAPR12MB2774.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FtQG1LWFS5VL47nqDNctY0Zl1Pg5cpsUpVzGbhTeDdqEyDAkd3/YpAzUrNhMHprztAgNhRyYdIuXjBD6eEZCpK+/meWyxf4xoDLCVTF+tzGE+coDZas1HQ5wYtWSsueLvNozr2uTlMjxp/2GzxtcuOR+Wsmfft0tYZ9NeBhD+LSx+kpiJU6bHvTp+TY8oS2tPYlrAl7+tj8BOAkz3YoEaZ91WuT2pyTEGq8XH8RuWeZOJvDyE+LhIkRedsIrM/MXwFmjKgKbpjgkYkliyHaeMoMMx3lTVu+FxkAq89czDVVKAFNqdMNcQbJgxOKKaH7x3k90GOgNrW6KwTmdsMvlmAQ9fkk/tsbQuXKO0TbHkKqqQONIhRytsyAHKrKjCPsrzOiv9p7PBF5rNBrgfru2AMKCP0QqZdyqSzXT8xiCoBs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(478600001)(8936002)(53546011)(66446008)(66556008)(64756008)(5660300002)(316002)(52536014)(83380400001)(66476007)(966005)(71200400001)(55016002)(110136005)(45080400002)(2906002)(8676002)(9686003)(86362001)(6506007)(76116006)(26005)(66946007)(4326008)(7696005)(54906003)(33656002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rMYI10BiR3vwbHeHPSF2BFwchotsV2R8NsG32bsG3aixWEKiIjECIr3wL2hl?=
 =?us-ascii?Q?tWcFCafNVzr/raXbhq04fK/6jP7IfS1LCEYTk0VOspDyWphGhyYFNz7o7/55?=
 =?us-ascii?Q?cV1YUbD8UXVrPi8y3upm3KMHswMAFgmurV3i/xDurd8QKv4Z3kdrpFnIiUjm?=
 =?us-ascii?Q?Ru2PLiW0XS+tPsJFxPSecF5xW0riL3canvIUlopHigndmvM6Hjk17bC9tQMX?=
 =?us-ascii?Q?WSJKlJbSv9XSwRK5v/eppN69iG3DnPwRHjI2wvffQMb/M02fHQa8JlmCA4HL?=
 =?us-ascii?Q?MFN5RPjJffLwJQ9KXleHqNzKHrYG/prOVC5pzlFw48kpo9YoQ0KDzpZ1411/?=
 =?us-ascii?Q?qMr3xs6+ieSL59ktj48lVxaX8JVpzx8ZR+1ss1CvxeII+wCmbB/uScqi4IT3?=
 =?us-ascii?Q?mYthwuRCzDBHfskKc37V/k0SahfUTBpQAra8jfsCyaGcD5l+3Dzu7B75B7mY?=
 =?us-ascii?Q?cCOKo2rCIUWuFaHUy+cgxgbDT/pwc6CUdJWwP5u+JWXqNqWPCGRF9pIaDpDf?=
 =?us-ascii?Q?tJgZJ8n4zvtXFrChBxVqv4OMsbKv7kKIKUdP7otdCMUQpS61On0SWC/jyTod?=
 =?us-ascii?Q?bxwehqP17fXWYbFhSSWQMLjZvQudZJlJn2hh1Z0j8rJgM2lMj9gn2Boncj6n?=
 =?us-ascii?Q?H9rMTjgTbB/iI0185HQOLnDFAyPPVcOuYHPSZBwlYbCFE1W4tVOAT06vHEA4?=
 =?us-ascii?Q?kAdLOmGTwnU4gQ8smQRuZQUYDe0f6/6bHFkacOl1dVhLyzkdW0BvRv2UPFRv?=
 =?us-ascii?Q?jlzIPayxj0MgWEXWUzqZxQv5iHcfilJ8XMX5fMNIXsG+0XJ7JYvnAqNNSgQ/?=
 =?us-ascii?Q?0CXZHO8s5y+IqjzFUVwCqqaovEMNqg564Yu6u/nBcVNJ4F6KYaJKlSFaEoF3?=
 =?us-ascii?Q?o9peJx6LzCsn1SBvo8l2qiODQh2OGuLRdy+8ngV7JQZktODMhyTJHrlJzTO1?=
 =?us-ascii?Q?AZP8y3fVhYyPJFFOYf+9bRsA+rB+9NBTpUhWwUkTEL0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb781b3e-07e1-4ad9-caee-08d8b5e67211
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 04:07:43.2740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3b9VLCXvmFQRcWQH3TpGxhageGBd4f6pNRvynYo7vXj8/oYoJAyXrgkhLCj83igE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2774
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Horace,

The XGMI part should be already well protected by hive->hive_lock. So, I think you need the non-XGMI part only.
Also, it seems better to place the modifications within the hive check.
        /*
         * Here we trylock to avoid chain of resets executing from
         * either trigger by jobs on different adevs in XGMI hive or jobs on
         * different schedulers for same device while this TO handler is running.
         * We always reset all schedulers for device and all devices for XGMI
         * hive so that should take care of them too.
         */
        hive = amdgpu_get_xgmi_hive(adev);
        if (hive) {
                if (atomic_cmpxchg(&hive->in_reset, 0, 1) != 0) {
                        DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
                                job ? job->base.id : -1, hive->hive_id);
                        amdgpu_put_xgmi_hive(hive);
                        return 0;
                }
                mutex_lock(&hive->hive_lock);
        } else {
+		/* if current dev is already in reset, skip adding list to prevent race issue */
+		if (!amdgpu_device_lock_adev(adev, hive)) {
+			dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
+					job ? job->base.id : -1);
+			r = 0;
+			goto skip_recovery;
+		}
}

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, Horace
Sent: Friday, January 8, 2021 7:35 PM
To: Chen, Horace <Horace.Chen@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Xiao, Jack <Jack.Xiao@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix issue when 2 ring job timeout

[AMD Public Use]

Hi Christian,

Can you help review this change?

This issue happens when 2 jobs on 2 schedulers time out at the same time. Which will lead 2 threads to enter amdgpu_device_gpu_recover() at the same time. The problem is that if device is not an XGMI node, the adev->gmc.xgmi.head will be added to device_list which is a stack variable. 
So the first thread will get the device in to its device list and start to iterate, meanwhile the second thread may rob the device away from the first thread and add to its own device list. This will cause the first thread get in to a bad state in its iteration.

The solution is to lock the device earily, before we add device to the local device list.

Thanks & Regards,
Horace.

-----Original Message-----
From: Horace Chen <horace.chen@amd.com> 
Sent: Wednesday, January 6, 2021 8:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Xiaojie Yuan <xiaojie.yuan@amd.com>
Subject: [PATCH] drm/amdgpu: fix issue when 2 ring job timeout

Fix a racing issue when 2 rings job timeout simultaneously.

If 2 rings timed out at the same time, the
amdgpu_device_gpu_recover will be reentered. Then the
adev->gmc.xgmi.head will be grabbed by 2 local linked list,
which may cause wild pointer issue in iterating.

lock the device earily to prevent the node be added to 2
different lists.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9a3cb98d03be..233dae27c8eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4620,23 +4620,34 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
 		if (!hive)
 			return -ENODEV;
+
+		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
+			if (!amdgpu_device_lock_adev(tmp_adev, hive)) {
+				dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
+						job ? job->base.id : -1);
+				r = 0;
+				goto skip_recovery;
+			}
+		}
+
 		if (!list_is_first(&adev->gmc.xgmi.head, &hive->device_list))
 			list_rotate_to_front(&adev->gmc.xgmi.head, &hive->device_list);
 		device_list_handle = &hive->device_list;
 	} else {
+		/* if current dev is already in reset, skip adding list to prevent race issue */
+		if (!amdgpu_device_lock_adev(adev, hive)) {
+			dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
+					job ? job->base.id : -1);
+			r = 0;
+			goto skip_recovery;
+		}
+
 		list_add_tail(&adev->gmc.xgmi.head, &device_list);
 		device_list_handle = &device_list;
 	}
 
 	/* block all schedulers and reset given job's ring */
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
-		if (!amdgpu_device_lock_adev(tmp_adev, hive)) {
-			dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
-				  job ? job->base.id : -1);
-			r = 0;
-			goto skip_recovery;
-		}
-
 		/*
 		 * Try to put the audio codec into suspend state
 		 * before gpu reset started.
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Ceaa1c2da82ed436ce1d308d8b3c9657d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637457025191663857%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=XJGrL9%2B4Fs9sNpdqXdEpBqgaUfQ46BUxKvQfdcuDwVs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
