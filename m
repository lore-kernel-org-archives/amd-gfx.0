Return-Path: <SRS0=OkES=DI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E95C4727C
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 13:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7662206B2
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 13:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QyiI69Zs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7662206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 789996E158;
	Thu,  1 Oct 2020 13:35:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0CE76E158
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2020 13:35:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcpjkwGbIRbocjILrOoml0gL/JLyk6OSb5m0D8Zvq3TGDC/+bPAywiLPTmA5W7v9a+m+gnyHUhxniSnh89gMaYMz+Z1WksPozlaxA/lCoIKd14UlXTH+bF3beVIa4lW4qCgwU++K9pY1cmdhFQLB0Ea2QhwWBIGhELiU4T21ZhBtKcL1QvvPgx1hyesS4j2efz7smBCdvU4t6uT8IEYp2nX5rLKRunEOsrKTu5ZrqXvZGEWCbIx64lyfj1x1aNBiAEcE4rgra+RbZ0LdwFs3JLp5sV/Coa2pBJh0VHHhXsBL0dfmt1c7Q/VqTdB+C8E47Uk9ysoIhN1h5cTs5y4tKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pK+aZU4h3gtmpuKnsyHA59zAQDKr6O/FDrYYe9QIp9U=;
 b=ilCrRwqqeQw19cCs5QWwusDhXZ6cKNFeqRgoTjFJqUHqou61kq5OVKTMDs12DiiL2RKB98jMgxKeRvEf7lnt/Jtv7RmodFAFUtuaTs9EFB4v54dL7Uu/gysAJ0ImIH2DHWjN7Wv4MCkmAb6N27KIZA33KL2Wf0w3me6jBYr0lf8daW6Qksb8NLx813M0Ok46zfdEuYQgUWl7GnVtG9AHWm/GwovnK3b+HknpEQvX0FMMLHLzF8bxtArYaLMZvQzDmdkmTVXCsj130ycnN1kxyeZRahsEdLK8RDyZ8rRJslKTVfRGmVp1FS3ue8YwhSYuj82SP0eexlyga8mlVTuA3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pK+aZU4h3gtmpuKnsyHA59zAQDKr6O/FDrYYe9QIp9U=;
 b=QyiI69ZsZogsVMiKj9r3GqSZXeyTMC/1dIuZlAB8nH8K8GpkP9Q66BLb15CqXs9A/joE5CKcVXHOutGon71vr15wN4kbRvVmgFTxC6Z4eG2X35pSKAZLd6MqcCr/+C5VNhFhgGc65Cn1ldNTq65ej87TvIDPhtL3RXIC0O/z9Xk=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1353.namprd12.prod.outlook.com (2603:10b6:3:76::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.25; Thu, 1 Oct 2020 13:35:28 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%8]) with mapi id 15.20.3433.034; Thu, 1 Oct 2020
 13:35:26 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/swsmu: add interrupt work handler for
 smu11 parts
Thread-Topic: [PATCH 2/2] drm/amdgpu/swsmu: add interrupt work handler for
 smu11 parts
Thread-Index: AQHWl/U2ByXQ5iygr02ueEL4Sdq2OamCu3+w
Date: Thu, 1 Oct 2020 13:35:26 +0000
Message-ID: <DM6PR12MB407567CB0D83C05E780AA69EFC300@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201001131711.279333-1-alexander.deucher@amd.com>
 <20201001131711.279333-2-alexander.deucher@amd.com>
In-Reply-To: <20201001131711.279333-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-01T13:35:23Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=96bf54bc-e4ce-49e2-9dd2-0000a10576bf;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-01T13:35:19Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: caff599e-919e-4c9e-b65d-0000f3a680b1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-01T13:35:24Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: cfc409a6-0d61-438f-8792-0000acad3d66
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c81de42d-dfd5-4e9f-08b6-08d8660edb6a
x-ms-traffictypediagnostic: DM5PR12MB1353:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB13535C0FA6C56989C8BFAD69FC300@DM5PR12MB1353.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jia5mfWD7THZGTh65iN6G4YSp7ywfFPbUylTnRWPDcsQXistnPyXJ6G/VQy3sRuUBk/vgtGTCw6ybTQ5RjNBEMaExkIOZ9/+pcgxFLytqAxRv+bvz8V16DRp2aFZg7zzFHOK9LqL1PNNlOCJs4S7GSCGKYkOhKBXOLptVZoOqT5ld3utufrMFt6mKUPOK7brlLLKpgi2W0iElQOPbP7jzDjgASGxkOSL/xJfYhtt+5eeSx5PNUfYcUZBh1RuQqa8HJ2Jt/4ryhFtA86P+FKx1dScU5JT8gy3s9geuJ/f9TCkf1cN2Z2rE3Jb3jyoUE0aAUjRoDNIkbdB66Fli/uNi8xzG3dy0IgxiNnki4/0dnfbk+PWX1UfZ852E7ba+bo5f5tlyhXl2Hrpcj6Kw/jW5zdp/FqQHBOADMU0aTNwK8U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(8936002)(478600001)(316002)(86362001)(66556008)(66946007)(45080400002)(33656002)(110136005)(71200400001)(66476007)(66446008)(76116006)(4326008)(5660300002)(2906002)(52536014)(64756008)(83380400001)(8676002)(6506007)(966005)(26005)(53546011)(9686003)(55016002)(186003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: zndjZ/rHWWNXESjhCIviffchYSf845maQzsz0RdwqNXY/q/rsrKCr2uHd5+b4ChwmSubTVpHBVAXwAGNTMJCzM+jghU4qH1gVCg6Q0zisNNlLGdFpEmwD2mVYivgnv6wyPvO95JoiI5k+VNiyRT+RscLNhL5LIvi32Xwy6h+HBKrbC+hwf04I6oBrefM5AY6FSGlWoQyvCpyRNiuHlU2AxZXVWXmRM2s2UsaOcbPitToCGudwX2sHuzfcGRNnD72MXVdJoGtUZb8XQG6nz4RNUTU9sUEK7+6oNnDFsI7ufnOe4/D4qpQ6PwXJOLSSyA/Sy3UTbrhlpLNqqKw7DD1srAVcU+RZ7/pZN91NZwdR6RqwoiYyI117XlDmACiDNGs+psNTNcA6v3u7+HuHV8iLgUc0Kx37QzSphzkFAowHuyCnkBROCaZvW5pkeRqaZbsgVjm3k2twtQNPeqbVQ8m8Yj6lxPyErpGGdwbwmYP5eN/a2sLT6HPeS0GKSgMvpnRtchc1uBVnR3ZYbuVh1sCrXKV1FSoLzNb3JumU6sYROEfA9PCjl7s0PcYnEKu3rDxDxHjB7GFymyDz63nKgqpz2S5iptfkV0oQP5No6O6WxxijW+eC8uL3o81bsTsnEe30abQzimMiG+2UyGG8Udnpw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81de42d-dfd5-4e9f-08b6-08d8660edb6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 13:35:26.8136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JSWU35oXUHHfoJtWOvA9M0FJS1LroclIr0jwf75YPpq0mDfLMqFncoKeY1HITbtt6bxv8w86Yi5rSQMOm0OuFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1353
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

@@ -2388,6 +2388,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
 	.deep_sleep_control = smu_v11_0_deep_sleep_control,
 	.get_fan_parameters = arcturus_get_fan_parameters,
+	.interrupt_work = smu_v11_0_interrupt_work,
 };

I doubt Arcturus MP1 really supports ACDC switch and probably even doesn't have smc message to ack the interrupt as well. If so, the interrupt_work function shall not be necessary for Arcturus. Other than that

Series is
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, October 1, 2020 21:17
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/swsmu: add interrupt work handler for smu11 parts

We need to schedule the smu AC/DC interrupt ack to avoid potentially sleeping if the smu message mutex is contended.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h                 |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c      |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c        |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c         | 10 ++++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c       |  1 +
 6 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index f57dc586649a..8885bde3ea3d 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -281,5 +281,7 @@ int smu_v11_0_gfx_ulv_control(struct smu_context *smu,  int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 				 bool enablement);
 
+void smu_v11_0_interrupt_work(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index d298fa65274d..fc376281e629 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2388,6 +2388,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
 	.deep_sleep_control = smu_v11_0_deep_sleep_control,
 	.get_fan_parameters = arcturus_get_fan_parameters,
+	.interrupt_work = smu_v11_0_interrupt_work,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index be44cb941e73..3f1377f28493 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2755,6 +2755,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.deep_sleep_control = smu_v11_0_deep_sleep_control,
 	.get_fan_parameters = navi10_get_fan_parameters,
 	.post_init = navi10_post_smu_init,
+	.interrupt_work = smu_v11_0_interrupt_work,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index a2cb831ce8aa..3c8732f34b1f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2784,6 +2784,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
 	.deep_sleep_control = smu_v11_0_deep_sleep_control,
 	.get_fan_parameters = sienna_cichlid_get_fan_parameters,
+	.interrupt_work = smu_v11_0_interrupt_work,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index effa4391b577..3e949e53cdc3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -958,6 +958,12 @@ static int smu_v11_0_process_pending_interrupt(struct smu_context *smu)
 	return ret;
 }
 
+void smu_v11_0_interrupt_work(struct smu_context *smu) {
+	if (smu_v11_0_ack_ac_dc_interrupt(smu))
+		dev_err(smu->adev->dev, "Ack AC/DC interrupt Failed!\n"); }
+
 int smu_v11_0_enable_thermal_alert(struct smu_context *smu)  {
 	int ret = 0;
@@ -1323,11 +1329,11 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 			switch (ctxid) {
 			case 0x3:
 				dev_dbg(adev->dev, "Switched to AC mode!\n");
-				smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
+				schedule_work(&smu->interrupt_work);
 				break;
 			case 0x4:
 				dev_dbg(adev->dev, "Switched to DC mode!\n");
-				smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
+				schedule_work(&smu->interrupt_work);
 				break;
 			case 0x7:
 				/*
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index d6759de40503..145712a24b80 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -341,6 +341,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
+	.interrupt_work = smu_v11_0_interrupt_work,
 };
 
 void vangogh_set_ppt_funcs(struct smu_context *smu)
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C83deb1c80e614081cb9a08d8660c56ad%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637371550481303648&amp;sdata=58V1WjAucW4EGNh9PKOoZ%2BqC5bapiWOGR83pnAxLIxk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
