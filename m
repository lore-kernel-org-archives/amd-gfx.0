Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058BDC43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 10:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93232467F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 10:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VVsmQ9ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93232467F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 900A66EC00;
	Fri, 20 Dec 2019 10:09:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFF046EC00
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 10:09:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifPLOcD68yW2YK4V7aDPPoBlQWgwvsKl+/1Etft1Y1sX2B+NLGd+TtnCMEfMrYRHL25omogWUNBUZ1u8Z0VNqEMHbeDX3ZFyRIeTaNBPbqsxdL8GF7ltAwbT7yWYekh/oUvsWJAGQ7X5bbW76AsVbqqpIvT+2rIsR6aKBkJfyx8n5+Ui1AXbqZO5QC3MFDrgEP1GZOfEJBEwsRwIBqgN+HJXp5tRiKmzLN6CCSbJvJjUsNtw50mBo+JTYF65f7z6t1SWqSVGQqDJWQ8Y/y83N9G9d3sdjmQKAsTiTMGuW+VLPi7FrDmOBno6rqORJd0fjDFBjQ0rKednDvOezkyU1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Um5EAT/5SmbFBRHT3207pqwfJvj/b3TGGG0dwYdx+44=;
 b=LmdwLxUnmbWR0p40Np6ynt0YeZVLHCx9CVDeChsOeCjd0Iz/r21yPQnAgKvWEXz9rH24RLwJzb9Sm8E/QMfUWWHCyuZK2yvhKAHGBNKrtnSn5FweIk/7lMn3nTLkvBvpxLeRMXYgAKjv0FVzUpUIMcSusvW4PDdxva3c8kR2niD/f21MCQ4nA5bR2twis9oiYogdLzDQyyK8HGCqJwjyvWGbadzlpc1gi19FxUDp/bTKZNJJWI2KpeUG5jvinc6xi0P/YIgfKXhYpLX3IJWz3rW99P61AZavBM3cx6wzV43FGlaRr0+WkGzYDn87fPnIaTyheXqlfjMW40VebQtyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Um5EAT/5SmbFBRHT3207pqwfJvj/b3TGGG0dwYdx+44=;
 b=VVsmQ9owkdYWhVXJhaSSxXQ0HGV6mSEhxLNN++4c/nX+u5hmfGt8EzWDb3xT4LoS6bJtmsgxxCcxhwcMw9qof4GUGQrBnAW0wtLegPyD1byi7z1M+BryKOYxk0d2Foicg9wABZdoIlx3p8k+U4KjiGgY14pFGoTt8JTwmgk86w4=
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (20.178.243.142) by
 MN2PR12MB3359.namprd12.prod.outlook.com (20.178.243.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Fri, 20 Dec 2019 10:09:32 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::851c:eebf:b936:20fd]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::851c:eebf:b936:20fd%4]) with mapi id 15.20.2538.019; Fri, 20 Dec 2019
 10:09:32 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Min, Frank" <Frank.Min@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: remove FB location config for sriov
Thread-Topic: [PATCH 1/2] drm/amdgpu: remove FB location config for sriov
Thread-Index: AQHVtmGpS4OVilwNnka1mame0Q/hcqfCziGA
Date: Fri, 20 Dec 2019 10:09:32 +0000
Message-ID: <MN2PR12MB2975285402E5898B893812168F2D0@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <20191219114335.22528-1-Frank.Min@amd.com>
In-Reply-To: <20191219114335.22528-1-Frank.Min@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-20T10:09:29Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=131fd898-9c2a-47cb-8e7f-000030f20c62;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-20T10:09:29Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b970a81f-39b7-44ef-a6e3-0000d8404a4a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c982b486-e9e6-42b9-9957-08d78534b59e
x-ms-traffictypediagnostic: MN2PR12MB3359:|MN2PR12MB3359:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3359A3379DB39BEF678FB27B8F2D0@MN2PR12MB3359.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(13464003)(189003)(199004)(5660300002)(86362001)(186003)(64756008)(26005)(2906002)(81156014)(45080400002)(33656002)(66476007)(66556008)(81166006)(66446008)(316002)(110136005)(8676002)(7696005)(9686003)(55016002)(478600001)(71200400001)(4326008)(6506007)(8936002)(76116006)(66946007)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3359;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jc2QzpJ4EXhRrNP86q6VRZhSLyNLlx5suJ21yRuaRGA4DdcAnMwdRCKR8urSkRcLoiUQhbFIBMHjFVi5NXaG70ntrKO5V8S1Z1afFRN1daQkEXb0I/vf0ct4dDksRUPvt/enZ6XL9ZZESXrnXfnKuX4GlgvPOrkjMWrgeGy2uwC4clmkuRuhI0mxw4tEOYCU5JmHt6tfVA/ETHaS8O3AR7Q33sRmEY/ARnYLRUlxXAm0gzz6qgEmTRqKpuIUb+LPkVK5YtqG90kf8PaLHsJ40mHvty0B0o7y0zw2u2OsIPDQN3tO8NVTBa1TM67/b/RV8JlPabXcAqbOyJzEOOZ4QXFJoTZAdqs051H6EruadCqdP9LR8WHRmovc03cxor9mU1k2GxX2Emq6nJXSt8x3lGPi78C53FMQ1U34xq3LmNXNtAMBtYN+6rITjXjorBKRkiEx7LicfHEUPmoSP3l4Px+N+nFR5k0Woj99GySocsYiXpn3rRyA+NTgOGwoBSwvG9Vc4xuwUK0z+GviIxsQ61ID7RtaiNe0Oc0WU08a5Vc=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c982b486-e9e6-42b9-9957-08d78534b59e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 10:09:32.6838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F7VA3vb16UeVqoB+7Tx/k7WAo7j5R8hZmjedKzfzWv79/46dPuT+2eBlWz4TJSUd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3359
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
Cc: "Min, Frank" <Frank.Min@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

Best wishes
Emily Deng



>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>Frank.Min
>Sent: Thursday, December 19, 2019 7:44 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Min, Frank <Frank.Min@amd.com>
>Subject: [PATCH 1/2] drm/amdgpu: remove FB location config for sriov
>
>FB location is already programmed by HV driver for arcutus so remove this part
>
>Change-Id: Ia357ae716bfc3084a4dd277ade219e57092f9b42
>Signed-off-by: Frank.Min <Frank.Min@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c |  2 +-
>drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  | 16 ----------------
> 2 files changed, 1 insertion(+), 17 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
>b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
>index e91bd7945777..e9a9d24c2b7f 100644
>--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
>@@ -264,7 +264,7 @@ static void gfxhub_v1_0_program_invalidation(struct
>amdgpu_device *adev)
>
> int gfxhub_v1_0_gart_enable(struct amdgpu_device *adev)  {
>-	if (amdgpu_sriov_vf(adev)) {
>+	if (amdgpu_sriov_vf(adev) && adev->asic_type != CHIP_ARCTURUS) {
> 		/*
> 		 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase
>they are
> 		 * VF copy registers so vbios post doesn't program them, for diff
>--git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
>b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
>index d9301e80522a..ac61206c4ce6 100644
>--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
>+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
>@@ -368,22 +368,6 @@ int mmhub_v9_4_gart_enable(struct amdgpu_device
>*adev)
> 	int i;
>
> 	for (i = 0; i < MMHUB_NUM_INSTANCES; i++) {
>-		if (amdgpu_sriov_vf(adev)) {
>-			/*
>-			 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF,
>becuase
>-			 * they are VF copy registers so vbios post doesn't
>-			 * program them, for SRIOV driver need to program
>them
>-			 */
>-			WREG32_SOC15_OFFSET(MMHUB, 0,
>-
>mmVMSHAREDVC0_MC_VM_FB_LOCATION_BASE,
>-				     i * MMHUB_INSTANCE_REGISTER_OFFSET,
>-				     adev->gmc.vram_start >> 24);
>-			WREG32_SOC15_OFFSET(MMHUB, 0,
>-
>mmVMSHAREDVC0_MC_VM_FB_LOCATION_TOP,
>-				     i * MMHUB_INSTANCE_REGISTER_OFFSET,
>-				     adev->gmc.vram_end >> 24);
>-		}
>-
> 		/* GART Enable. */
> 		mmhub_v9_4_init_gart_aperture_regs(adev, i);
> 		mmhub_v9_4_init_system_aperture_regs(adev, i);
>--
>2.17.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=02%7C01%7CEmily.Deng%40amd.com%7C564215fe64b245954
>97408d78478b687%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
>637123526651355885&amp;sdata=Aeag0%2FF6lQHe70aot5ZzB5UP1rZxsEZO2
>WfLyJv1njg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
