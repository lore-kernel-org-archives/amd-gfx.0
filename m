Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52812C54E8E
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 14:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2778F20673
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 14:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j6OYrI1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2778F20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C24986E92F;
	Tue, 12 May 2020 14:26:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED84F6E92C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 14:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzMxxMwXs1+csW5luCe09YT6nNxUd9zQVVIoZwlistfxuVuwMdc6r6DPXeljRRFJr/0AdyeJ04NnfRh/ZTfSfORvpBwhTKWkjZSyac2pfMm6Z/r5iD+jXHS7Jm7xsu29nMDo5OxD4QjQ9VRHc49JREchh3N/PBlAF5E7KRGRI62uA1cfWIQUawjsU+gfa5A0WLT8D+xuAhQNvd9fWs5kTo1cuo3rzZO/7HnEah/C1TrHW05jZbuRM9KGkWQXm8/RjmZQ7sCBsNbb6Qyk+mk0+TdrjYPb/ltNFhIQl5BbW6cEc0mg2kXDzIQkh46uZV/79pjvxIU3bKj90iBtOTsoTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok18b5kK9pWusdjmdTHsOtTBpzahTsvbh4VkYizHUCo=;
 b=JbwKlz26SsKOpnBf2nTIySLN4mQ2yHnzaF4m6WDIzlvVVJx/9v4mDqx9FBZhRNSi/S6NSE0svbJVHpNgZ+y+5Rb2f63exH1AJBv5rVOnIHl6ChaQEW9jfP/WGjjb14lrEJ/CZQhj0cGDO1VFolzD4TuNabwfdieT7TVkiTW4517Z9CDF0CNsug6Y5MtPpQKe/Owg61tobSwWIRXYTsPiqs0nwBhMEHoRXXNxzr5JwzPDGonUSF2EM3r9UHkpYh3zJJq39ig1d2yaoREfSKtFhEFnvCLIUvArRIZ+fq1u8FtMvoeO31Fp8aKlFFBgbZH/JbV/kSoHki0zNApncdEBOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok18b5kK9pWusdjmdTHsOtTBpzahTsvbh4VkYizHUCo=;
 b=j6OYrI1blMrIzg17Zymon/LGRVQtWWUPEjKiV65mN/Cz60D9Sh0lNq2VNwR98rPI5bd0uXCaqoFLtQx7LNwHRWe/mzRYqRTef9ZfxhWYppLmsSd4gQu0vDvkgcXBotC+iQ5YI//gCFyMhjGLkK9qnuwoiR1ptR6s9xnj21YdLTg=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4568.namprd12.prod.outlook.com (2603:10b6:208:260::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Tue, 12 May
 2020 14:26:12 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%5]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 14:26:12 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Tao, Yintian" <Yintian.Tao@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: turn back rlcg write for gfx_v10
Thread-Topic: [PATCH] drm/amdgpu: turn back rlcg write for gfx_v10
Thread-Index: AQHWKEaPDIcTRT9yLU6pLzkLPLylfaikgfGz
Date: Tue, 12 May 2020 14:26:12 +0000
Message-ID: <MN2PR12MB44883BAFB8242994F2BAF857F7BE0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200512101721.12164-1-yttao@amd.com>
In-Reply-To: <20200512101721.12164-1-yttao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-12T14:26:11.901Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.37.167]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88d678b2-e863-41ed-e5b7-08d7f6806c4a
x-ms-traffictypediagnostic: MN2PR12MB4568:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB45687251F4672B8CB07F5B6EF7BE0@MN2PR12MB4568.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tNJOBzq2hf1CFJhRfSb5aQZR7hzBOG7itIKT5qslV9Dd1fMdKyutZpdDUsZPmYZBTUN9oATtoTR6L4ZGcv+KA6BtS7pX8EDPr6H+si0pFVmjuX0MzsQVEjCt15DUjiuSKX3lP8S3SWwyjobBHnXGX0Xrfd0VGEzZgUKPZe4/X+05JGTQjGyt+X8fTGByv/s8XsNa9myaScATfQ43MwArfDARKFELmRTBL52P2iCP8N1iyJRbcMBpdCkJjlzrBydm+cvmvQQeCFC2Zk3qm4JE8EtRj3Ey1Dm3nQ+HyCFzcJyXCx3drb42hdQ/4CXv+/NS0ctIrgVIlV/i3YHoQz+wtOavJcNmyqiZi+7U357PzTcaAt0TXLc8VICiuQC7MkhU2JlCDU+An1JJqG+QhsFLfDXviBI4ibp2vlguVKiUIO3ror8AgBv1VUE/P0pSfE78ukd7GKbgVdYRIzO4jfDqBSXtMvs6ThWoef/2bZRv3tqXUjeIcHEiGwtjnRqUSsEbXlwVvAIq45oaMuokwiiUug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(33430700001)(71200400001)(186003)(478600001)(9686003)(7696005)(8936002)(6506007)(26005)(53546011)(4326008)(54906003)(52536014)(33656002)(33440700001)(316002)(19627405001)(76116006)(2906002)(55016002)(110136005)(66946007)(64756008)(66476007)(86362001)(5660300002)(8676002)(66446008)(6636002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: itz8YOxzRy5D4jMhK/VekBQNlin88mt42Zdzl6OEe/2wh3Xk//zcEq61eblC/mwoF1oo/+mLLgwULIBxglrOSv0faNzQWSW+qrfwhAYQAcdlrxzJwp8wRzxyzm6woQOZAMWriWdQG95I1vlvxyPPsoE7nOU5i/bdMyHxYBOfx3AGkKwDkBoJA5wxUZISccDpqq5A1/IBVvcUviIA5tMLBLtmHqFCgv2lIvh5qK2VktaFieQrLKJ2CtpmVh3gehWTF2kk88LiL3Oh6FGTVwr32TY2bxraiAJixrGsZK0iYYP9Tv85BollKdNdYvPmc7a0K2WiZd4jeG281pMjw/gyFcxUZrsasYuntElBQUk7zG9KL+whTI2Bq1Z6VfGZL2pCPH2y+eM7YEvyOSARIe54HKemGG9eihXe7CWbFh6hASc904jzwJ7dAxMJUHuxJc+yz7o9axY+HZbx+78rddWhf44zuvHQuhROQE57YIrHjT/i8nhRVeOujIIVi9k93AfY
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d678b2-e863-41ed-e5b7-08d7f6806c4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 14:26:12.6790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0oF6jVC+Oc0FPEfSJvpevu/ZbBVxCNYa99iPsB0FIbIh5tbt2OlT3CKwXjiOhI9oiXTx1CSUhtqXKRs2DUMVXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4568
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
Cc: "Tao, Yintian" <Yintian.Tao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1113911991=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1113911991==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44883BAFB8242994F2BAF857F7BE0MN2PR12MB4488namp_"

--_000_MN2PR12MB44883BAFB8242994F2BAF857F7BE0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Yintian Tao <yttao@amd.com>
Sent: Tuesday, May 12, 2020 6:17 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk <Monk.Liu@amd=
.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Tao, Yin=
tian <Yintian.Tao@amd.com>
Subject: [PATCH] drm/amdgpu: turn back rlcg write for gfx_v10

There is no need to use amdgpu_mm_wreg_mmio_rlc()
during initialization time because this interface
is only designed for debugfs case to access the
registers which are only permitted by RLCG during
run-time. Therefore, turn back rlcg write for gfx_v10.
If we not turn back it, it will raise amdgpu load failure.
[   54.904333] amdgpu: SMU driver if version not matched
[   54.904393] amdgpu: SMU is initialized successfully!
[   54.905971] [drm] kiq ring mec 2 pipe 1 q 0
[   55.115416] amdgpu 0000:00:06.0: [drm:amdgpu_ring_test_helper [amdgpu]] =
*ERROR* ring gfx_0.0.0 test failed (-110)
[   55.118877] [drm:amdgpu_device_init [amdgpu]] *ERROR* hw_init of IP bloc=
k <gfx_v10_0> failed -110
[   55.126587] amdgpu 0000:00:06.0: amdgpu_device_ip_init failed
[   55.133466] amdgpu 0000:00:06.0: Fatal error during GPU init

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 449408cfd018..bd5dd4f64311 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4577,13 +4577,11 @@ static int gfx_v10_0_init_csb(struct amdgpu_device =
*adev)
         adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);

         /* csib */
-       /* amdgpu_mm_wreg_mmio_rlc will fall back to mmio if doesn't suppor=
t rlcg_write */
-       amdgpu_mm_wreg_mmio_rlc(adev, SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_AD=
DR_HI),
-                                adev->gfx.rlc.clear_state_gpu_addr >> 32, =
0);
-       amdgpu_mm_wreg_mmio_rlc(adev, SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_AD=
DR_LO),
-                                adev->gfx.rlc.clear_state_gpu_addr & 0xfff=
ffffc, 0);
-       amdgpu_mm_wreg_mmio_rlc(adev, SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_LE=
NGTH),
-                                adev->gfx.rlc.clear_state_size, 0);
+       WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_HI,
+                        adev->gfx.rlc.clear_state_gpu_addr >> 32);
+       WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_LO,
+                        adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
+       WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.clear_stat=
e_size);

         return 0;
 }
@@ -5192,7 +5190,7 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_devi=
ce *adev, bool enable)
         tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, enable ? 0 : 1);
         tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);
         tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT, enable ? 0 : 1);
-       amdgpu_mm_wreg_mmio_rlc(adev, SOC15_REG_OFFSET(GC, 0, mmCP_ME_CNTL)=
, tmp, 0);
+       WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);

         for (i =3D 0; i < adev->usec_timeout; i++) {
                 if (RREG32_SOC15(GC, 0, mmCP_STAT) =3D=3D 0)
--
2.17.1


--_000_MN2PR12MB44883BAFB8242994F2BAF857F7BE0MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yintian Tao &lt;yttao=
@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 12, 2020 6:17 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Liu, Monk =
&lt;Monk.Liu@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Tao, Yintian &lt;Yintian.Tao@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: turn back rlcg write for gfx_v10</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">There is no need to use amdgpu_mm_wreg_mmio_rlc()<=
br>
during initialization time because this interface<br>
is only designed for debugfs case to access the<br>
registers which are only permitted by RLCG during<br>
run-time. Therefore, turn back rlcg write for gfx_v10.<br>
If we not turn back it, it will raise amdgpu load failure.<br>
[&nbsp;&nbsp; 54.904333] amdgpu: SMU driver if version not matched<br>
[&nbsp;&nbsp; 54.904393] amdgpu: SMU is initialized successfully!<br>
[&nbsp;&nbsp; 54.905971] [drm] kiq ring mec 2 pipe 1 q 0<br>
[&nbsp;&nbsp; 55.115416] amdgpu 0000:00:06.0: [drm:amdgpu_ring_test_helper =
[amdgpu]] *ERROR* ring gfx_0.0.0 test failed (-110)<br>
[&nbsp;&nbsp; 55.118877] [drm:amdgpu_device_init [amdgpu]] *ERROR* hw_init =
of IP block &lt;gfx_v10_0&gt; failed -110<br>
[&nbsp;&nbsp; 55.126587] amdgpu 0000:00:06.0: amdgpu_device_ip_init failed<=
br>
[&nbsp;&nbsp; 55.133466] amdgpu 0000:00:06.0: Fatal error during GPU init<b=
r>
<br>
Signed-off-by: Yintian Tao &lt;yttao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 14 &#43;&#43;&#43;&#43;&#43;=
&#43;--------<br>
&nbsp;1 file changed, 6 insertions(&#43;), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 449408cfd018..bd5dd4f64311 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -4577,13 &#43;4577,11 @@ static int gfx_v10_0_init_csb(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt=
;get_csb_buffer(adev, adev-&gt;gfx.rlc.cs_ptr);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* csib */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* amdgpu_mm_wreg_mmio_rlc will fall =
back to mmio if doesn't support rlcg_write */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mm_wreg_mmio_rlc(adev, SOC15_R=
EG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_HI),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.clear_state_gpu_addr=
 &gt;&gt; 32, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mm_wreg_mmio_rlc(adev, SOC15_R=
EG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_LO),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.clear_state_gpu_addr=
 &amp; 0xfffffffc, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mm_wreg_mmio_rlc(adev, SOC15_R=
EG_OFFSET(GC, 0, mmRLC_CSIB_LENGTH),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.clear_state_size, 0)=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CSI=
B_ADDR_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&=
gt;gfx.rlc.clear_state_gpu_addr &gt;&gt; 32);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CSI=
B_ADDR_LO,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&=
gt;gfx.rlc.clear_state_gpu_addr &amp; 0xfffffffc);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CSI=
B_LENGTH, adev-&gt;gfx.rlc.clear_state_size);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -5192,7 &#43;5190,7 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_=
device *adev, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 CP_ME_CNTL, ME_HALT, enable ? 0 : 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 CP_ME_CNTL, CE_HALT, enable ? 0 : 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mm_wreg_mmio_rlc(adev, SOC15_R=
EG_OFFSET(GC, 0, mmCP_ME_CNTL), tmp, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmCP_ME_C=
NTL, tmp);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;usec_timeout; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (RREG32_SOC15(GC, 0, mmCP_STAT) =3D=3D 0)<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44883BAFB8242994F2BAF857F7BE0MN2PR12MB4488namp_--

--===============1113911991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1113911991==--
