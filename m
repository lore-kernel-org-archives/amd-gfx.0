Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87021C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 09:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF6B214D8
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 09:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zKMNsH7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF6B214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC626E874;
	Wed, 17 Jun 2020 09:23:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F7C6E874
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 09:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ff8v+qOz4i9ulvlYMWBMPB6lOfxpjvsM7hidSBlQWuCn8QHyRYAdt8x7xwd+2VjaV6hRF6AS+7gRzrv+5j1000+PxOWWQF1xB3VYhDrUwKYo3S9aFabuZiTT59GPTmmzVj4FhKF4CYfxEONWAzj01Km5QeSKF7K5o4BHaGZd8j3kzK78flpCPKwgFyekwrP1gqDHrkbGOA4lwOAzXlFBGs763a1teMWJPrfrzluwVcGp37sJQGJON23wEf9gof4Kq6apvVdXkFZ6tJNmtN1FqajcCH/hWD1P9g05lYavSWH1IQus+cTJQFB8Qa2xFcCrLxWeKC8NeKEu1IWaZs8gXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTise9AKAbv3O7t7xZlig5y3V8YcXzX/20fvBwEBmzA=;
 b=k9RQ4P8UvlgjbzmwKPxnGzWc8deQEo1ULKyXYF4nSpK6wYueMhkYMtsiAn1aQ+yeLKUOv7S3O+2dT2YK4UpErBSxHPOzOGQZIn1XyX8BEUtmjP0C0A4CyKn3cgfJxuu0M+JGFAoY8PeDAYmgVgfK7YNOtUs+Q17yh+Z7zU2o7YP3D8XwF/FCgBRut5xuLXY6p6By6gdkts54ebpUtQVfUA7iUX9i3DtD171AuODX78t4xKHPjiVJ113n3fSwObgngFEArkbn7n/3Aj8yS8O81gFpvcTC8DP93Ps0Mrt05Nmp3ed5oP2L9brExCXE4+JmJv9t5gOF4Aa+Qtil3tpIsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTise9AKAbv3O7t7xZlig5y3V8YcXzX/20fvBwEBmzA=;
 b=zKMNsH7KjfaSvzFBy4erEhpjcODugcpwHbIlNorJBn0uJiios5ZT9k6f3VF+4/lIe/19ToeotZomI5UqRNHAlJDjiify1c57alu0X+V+ccQyQJjqQgV73ECBNRZOMHVGtly49/EtAmkpsiicfgQLgp9TNBIIERU7Cg/FrP6lHM4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2505.namprd12.prod.outlook.com (2603:10b6:3:ea::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21; Wed, 17 Jun 2020 09:23:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 09:23:19 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Warn about disabled DPM
Thread-Topic: [PATCH] drm/amdgpu: Warn about disabled DPM
Thread-Index: AQHWRHnHCjq2NFMjPUCTa9njFvgePqjciNgQ
Date: Wed, 17 Jun 2020 09:23:19 +0000
Message-ID: <DM6PR12MB2619E77DEE868AC1C140E800E49A0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200617071631.7274-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20200617071631.7274-1-pmenzel@molgen.mpg.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=96ae9a66-7dc6-46ff-9976-00000422ccbc;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-17T09:23:03Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5385bd12-ebd8-4beb-f0fb-08d812a01325
x-ms-traffictypediagnostic: DM5PR1201MB2505:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB25052B223B2F1597415364EFE49A0@DM5PR1201MB2505.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sNK7TjfvENK8hpq0W3VxHt55MEhsKUSyJkh0fogaGrOrTJOGb8oycS4NPCAfR1OKm8QHcjZuRPAAPA9GRreuAT+jLPj0owp6fxIS8COI/kDnzR2yYfWa1RypYMyu8UFkBMly1jHXVR+MVId717VHlTlV7SRepZK0TeYT8XAEkGg1n5O1phhGLzEjoxWpwM0jSBro0dbpMJMZOidIP8TuQkuZUXMpD82WQDcPiUaywDaA2/6QYGhycTUUFG+QdfGtbcN4s3hMLi4xbPH4A2fkdE29Wx0rnQC5nl723Rwwcl4CD51FlV/1PBQxJKzuZLZ6mAIZ/M5n/OV9r+ou5vlz1BvdNkm/aVL4UMmjN86xqCY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(66476007)(66946007)(64756008)(66446008)(5660300002)(45080400002)(66556008)(86362001)(76116006)(7696005)(55016002)(6636002)(9686003)(2906002)(8676002)(33656002)(186003)(6506007)(4326008)(71200400001)(26005)(83380400001)(966005)(8936002)(110136005)(316002)(52536014)(478600001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: uoMtGGPdq9keAQpZDQj2dhLA/nB/pMehAot4QyleMDmLywxw36b2FqwAoMASUOZsAAd5O57awhtFMNJm0NtTWvUbt/EFgkEkEiQfdgJFPqDBcgDRtwOP3MOhmos5XZrAn8BCeP5IPF3KvvPfhs2hyPRzdpQ2B9Pzjus6QnPzNMx+vs4W/Smv5CRnOFqYH38cBsB9nlsa4WZtMKkteeNaSMOsaPNg5Z5Ot6pbTXO1LGmQUgRVlkGKUsB5M03BqNtxpj+QfmAiVinqOfsU6pRG+fYfM2HW4lx9bMoQuTiCE7EYEZMkvE3EnXA6DyUdooTDLScgsX8N56HM5BMjE9a1US9wyalf/xPFappkaQx5ifveUzIm+hFEfWRtsvIAgsQTsmYS2ndBXf1t+50/rwWVdpG3K93W/K5kVbXKa1iGFdjeQKCynT/ROlCw8gW6lD4FGnSTPvCLmTSU7DkgY26WmLPgmJFceC5NmU/Mjh/4Z+wCQdD3GpyDEPdqkc4VYnfl
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5385bd12-ebd8-4beb-f0fb-08d812a01325
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 09:23:19.6487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wAG4vJNSRA8uc+zAbdkDKlNRcTZtxweeP9M/yFtpF5aZ7cLdu2v6GyTcW0eeSZ38
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2505
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Paul Menzel
Sent: Wednesday, June 17, 2020 3:17 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>; amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Warn about disabled DPM

Currently, besides there is no explicit message, that DPM is disabled.
The user would need to know, that the missing success line is an indicator.

    [drm] amdgpu: dpm initialized

So, add an explicit message, and make it log level warning, as disabling dpm is not the default.

Resolves: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1173&amp;data=02%7C01%7Cevan.quan%40amd.com%7C4ba79bb63487426f074d08d81290e615%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637279760886452253&amp;sdata=if2K3qoBopyK%2FLqycejyBac7JuifQk%2F6O576wubDSDA%3D&amp;reserved=0
Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c | 4 +++-  drivers/gpu/drm/amd/amdgpu/si_dpm.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c b/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
index 4b3faaccecb9..071215e8039a 100644
--- a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
@@ -3014,8 +3014,10 @@ static int kv_dpm_sw_init(void *handle)
 adev->pm.current_mclk = adev->clock.default_mclk;
 adev->pm.int_thermal_type = THERMAL_TYPE_NONE;

-if (amdgpu_dpm == 0)
+if (amdgpu_dpm == 0) {
+DRM_WARN("amdgpu: dpm disabled\n");
 return 0;
+}

 INIT_WORK(&adev->pm.dpm.thermal.work, amdgpu_dpm_thermal_work_handler);
 mutex_lock(&adev->pm.mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
index c00ba4b23c9a..6af89587f80c 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -7687,8 +7687,10 @@ static int si_dpm_sw_init(void *handle)
 adev->pm.current_mclk = adev->clock.default_mclk;
 adev->pm.int_thermal_type = THERMAL_TYPE_NONE;

-if (amdgpu_dpm == 0)
+if (amdgpu_dpm == 0) {
+DRM_INFO("amdgpu: dpm disabled\n");
 return 0;
+}

 ret = si_dpm_init_microcode(adev);
 if (ret)
--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C4ba79bb63487426f074d08d81290e615%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637279760886452253&amp;sdata=xJ1ZELqsAMby6w%2Fj5e9N1ytLe%2FOYPRn6e4C8wX7%2BCCg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
