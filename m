Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8B2C433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 09:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874C820757
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 09:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="okswRji4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874C820757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 060236EA32;
	Wed, 14 Oct 2020 09:51:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CA206EA32
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 09:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAnPs4MxT6DNeSjNpHHDUl67C+JMV41g365k8K43nNsYEawG0uLNPjlwd5xg9ACkBBfmuFr9DftVO0PMc5TAaRgsokAgNSMXmn0PpmP/69riixfUJLWnWiDYZc2xymV3JmZSW9UsxUX284nva2Kdz92MIEHhl61LseDsUNQPkJXyehMuSN07/xREKLPE6HAi6Ri/3VUDlJmA1y+jaR0SY8JBtugt61oPI5Awjd5UXkGrnNguQ2SUt4ktZ44cC4ZfY8IyiTAsQo5wrUOZYK3w1yS/YnJA/6sqjd170VuSsSbm5+kt31zGuGu/1nRf3qt5rfkUHzl7AenhftJNgNGLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz9abfqLH419BFsjIUbydtWUpwZQlgcDUG4xE0QdFFw=;
 b=a6r1cW24uKNEMETXcD87mH0U5GqTUdZ8xX18A7eft8zzu8wUts+VbDW4gHb+efdjGIClaNHGIviG5MHPROORRNbbDCr5QgrRiPO9apT51Xlnqg9Rx4XXBqr4r+ctj4307oyyDowQFRzMWp302ZCGqBZarnXUFShrHEYP0k9W+Cs6FcRl+e3GG0GAvMamLrAIG27V+06l8xQOq+N9b0/kxLBjHQmr7GRuLlSAEWGY4QPpNzcWRGe0FKc0F2aIBvmgTuqJXQxWmuTY4v3uZ93s9oNkkfu3ojsuosSPfFOK6fQ8LqbvPu5vikzS6tKdWsrkmwWmYCMjKgjQOluqZ1eMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz9abfqLH419BFsjIUbydtWUpwZQlgcDUG4xE0QdFFw=;
 b=okswRji4rlF26qV22Vv7XkIMnFx6pfUh4O55J1/hB6MdfhERlWqgke/draBOvSGRPP3kl3Racz9inrKl6g/keeTYqDi8Aew0uCSULtLM3WkX5McawMxVOx30388pn4OZj8iWEDeov486BWNnNy+xVzjWDViE9lzaUuDEfeC1N9w=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.27; Wed, 14 Oct 2020 09:51:38 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3477.021; Wed, 14 Oct 2020
 09:51:38 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: protect eeprom update from GPU reset
Thread-Topic: [PATCH] drm/amdgpu: protect eeprom update from GPU reset
Thread-Index: AQHWog4Xt+9c3dBTtUW0gqTw8uzmsKmW2ZSw
Date: Wed, 14 Oct 2020 09:51:38 +0000
Message-ID: <DM6PR12MB4075AC679F9E58AEBDD7F211FC050@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201014094031.22448-1-Dennis.Li@amd.com>
In-Reply-To: <20201014094031.22448-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-14T09:51:33Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c89e326c-9e72-4b26-aed5-0000f972b55a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-14T09:51:25Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 99047d32-4e9c-4bab-b6ec-00007fd66ad6
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-14T09:51:35Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 5cab4dbe-eb3d-468e-8c91-00004c0c3543
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99e49271-a992-4f73-2a55-08d87026bec3
x-ms-traffictypediagnostic: DM6PR12MB3082:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB308239A072C7F8F0ABB2D5BCFC050@DM6PR12MB3082.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iuWG8iUX4/h14P+Kf/8XA3MLRj0oYwYx6m4ocCj7wbWx9g8MRR/9shj1WVc6gzttKA353I4VAKx2kluyRpPPTY+fhI7IjbvmZhJKjKrUb0h6A67WRUI+7bUQqbXyUzSpplbFGks3x/NgWUiUqqRFRwVZIlPs8usJy6MQ93YmwmfN++tbddSik9nOPenh5XIUVu5a5FIAIUTWiKQ3Z7rO1G3VGTye4ev6NPEOsCl6/RqNVsfCz6VfbFxeyvWf1N1Prg1YOx+c6I2iI9X1QGgFUBCCBvqoAPwuNEP4QKWRjq8zwFLCn5qLNzVQDbN834+c
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(4326008)(7696005)(15650500001)(83380400001)(186003)(26005)(6506007)(9686003)(53546011)(6636002)(110136005)(316002)(71200400001)(55016002)(52536014)(66446008)(8936002)(66946007)(66476007)(76116006)(2906002)(5660300002)(8676002)(478600001)(66556008)(64756008)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: kl5v6H2jPFLX5IMyUt4CodeOwa+FMu2OeJTrSqxv4kcL2iu8Nh97B2k1fjZ6F/00JP/m8p+KK2B8v8Bn7JMvVE1JH5oR0mgvSRrw5PGybWslz4T0TkfcRq1F+HsD/Fdb5w0UizM1R21QHxQ7dNIZ21O6IdGRnTP3T5wrSfpDhLua8+461WkjrsIT451D6CoZggusrN045XelCUyM7VcmVsM8f2OQe5j6WC6ScU9qOQlKg3GBWsk/jLZxpBsiggn3q41xIxXBHS80JxHOpnGnxEGYyI94QkV1G6mQs/AjGlCRSgRWMwM+H1DgcY8DrdNMfvB0DY54cZb70oFQ3RIPYAKGejQ41Y8uXrp+vo9OEqtJ59Zhp2ifgfME19FVsSxZL5JIBsrWmPnAmc28YveoRGUs8g0iDltbl66cwQBtmv3GNj3vkWDLrue2NlfiBi5XWie9X/6Lyu8qWRyFynSo4AkN+cYffBhfS9dcNMUSlDo6dvEPoYkJDYxrty5TM/6EMUZjM6QoAZKdK05WNmj7I6jTFvmdkYhhDZSLgvopLeklinSIn6VAvHADgkHXITtmMfPtbUT0Hnj1kaJQsEg7gPssXHfS1UFbsKqXwVMP9UA99jA7ay05nCJEuZS/81/rCLmJ9rTqmH08rKh58cYIgA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e49271-a992-4f73-2a55-08d87026bec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 09:51:38.3469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NhMTMdXkWOpR69OpKl/jdvhvNFKr5EQxg4ItbXvdEMbxlnzvW5I0mLi6hUoNxZfJHuCPQZX/CxGU+LIHXChgqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3082
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hmm, I think bad page record update is done ahead of scheduling gpu reset work. For mGPU case, shall we walk through all the nodes in a hive before issue gpu reset work?

Regards,
Hawking

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Wednesday, October 14, 2020 17:41
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: protect eeprom update from GPU reset

because i2c is unstable in GPU reset, driver need protect eeprom update from GPU reset, to not miss any bad page record.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 0e64c39a2372..695bcfc5c983 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -149,7 +149,11 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
 
 	msg.addr = control->i2c_address;
 
+	/* i2c may be unstable in gpu reset */
+	down_read(&adev->reset_sem);
 	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
+	up_read(&adev->reset_sem);
+
 	if (ret < 1)
 		DRM_ERROR("Failed to write EEPROM table header, ret:%d", ret);
 
@@ -557,7 +561,11 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 		control->next_addr += EEPROM_TABLE_RECORD_SIZE;
 	}
 
+	/* i2c may be unstable in gpu reset */
+	down_read(&adev->reset_sem);
 	ret = i2c_transfer(&adev->pm.smu_i2c, msgs, num);
+	up_read(&adev->reset_sem);
+
 	if (ret < 1) {
 		DRM_ERROR("Failed to process EEPROM table records, ret:%d", ret);
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
