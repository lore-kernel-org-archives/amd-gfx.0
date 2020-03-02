Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5718FC3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 15:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2E221556
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 15:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ysiEvmXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2E221556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BCA3891D4;
	Mon,  2 Mar 2020 15:46:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A39891D4
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 15:46:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSF97Sc0heE8OMLwY9KlQiDMmwtlNgEh4n7uQSgeg54UZ/vMpzcLnpVMc6CMJ9q83AXX94D/PCnI1QQkY7F9pHZC4nmDq3Sj7f8T3pod4VUXGVrwzhKy47pEh21XC+npcgaUskjafGX0AYbn4U3vRxF4buifMKQcp2fq8bGJb8MZe0BjuStFHcrpYtCImxcRM2yenJqoSI7ivjXKfYY4fWlKQ7BUfjsjXXZ5NFrvgFQEFB1YrZv47jdztZjkI7V8tYEllP9aBEQsfMy3Eg86f2ZMmkxSpheAtQjDBdVBQz/0qYhTsOdBoRLcpUraot2SXh3zQaL6FvhAybhlSKH/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMPQtJQ4U23bQdhXL7MAsxQPq5Q8XB1qRuTsZtUvJRg=;
 b=mOcg6ErsGpkBA9z9Ynx4ZOk3FIzBB+IoKc52AAUVooRNM7nZziXWtf3GacqcL/7754NOOsAADlqSEwYeaYi+fUPdoYhqLv3JgprbYvlEa8lrO8iPaYVui6Bj2E4A0HMZj19awGVpTnpLYH54YH+YT0mIL/PRABhulPqErt0bwZztjpYMMpB8YepcrqXAwcz24pIYuQfIIzPus6P5GJapkoSDaC1asS38Nc+3g1iyRwXn9sPXY7jnWpRTxYuaJTZQGNVzSBgtFWCnGu0Xp8FQD1utpygbJJYqcGePU84pWfBY2TAu4FxR7g/MVLTCnu/YXwHy12CCNxqZkrZn67044A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMPQtJQ4U23bQdhXL7MAsxQPq5Q8XB1qRuTsZtUvJRg=;
 b=ysiEvmXOOXa4A5qD95dZklMxMP3keu+bk2zPXsnPivhKiYNeAx7BdIq4OK7i24ppZgXFLJKNYSusAlrKODGTh9pZ/7Z3WkK3WuXaKURur3SuNQOU4226EGzkvdU0CHsIFIpkA2oelgPg+NMEU0SjHk3N3EondO/7cMiaKZib6lQ=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22)
 by CH2PR12MB3800.namprd12.prod.outlook.com (2603:10b6:610:2d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 15:46:11 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 15:46:11 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>, 
 "Li, Dennis" <Dennis.Li@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: add reset_ras_error_count function for HDP
Thread-Topic: [PATCH 4/4] drm/amdgpu: add reset_ras_error_count function for
 HDP
Thread-Index: AQHV8H4uPrcvTwJWAEissJOx6+/mk6g1ckhF
Date: Mon, 2 Mar 2020 15:46:10 +0000
Message-ID: <CH2PR12MB391233C0FB6A888334004711F7E70@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <20200302103339.31723-1-Hawking.Zhang@amd.com>,
 <20200302103339.31723-5-Hawking.Zhang@amd.com>
In-Reply-To: <20200302103339.31723-5-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-02T15:46:10.608Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e95b7dde-1ab8-41e1-45e3-08d7bec0d4de
x-ms-traffictypediagnostic: CH2PR12MB3800:|CH2PR12MB3800:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3800F89ECB4BBDE2D9F6AB47F7E70@CH2PR12MB3800.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:525;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(189003)(199004)(66476007)(478600001)(6506007)(76116006)(5660300002)(9686003)(55016002)(66946007)(316002)(66446008)(66556008)(64756008)(19627405001)(53546011)(26005)(52536014)(110136005)(86362001)(6636002)(7696005)(81166006)(8676002)(2906002)(81156014)(186003)(71200400001)(8936002)(33656002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3800;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4U+TZs1U3QLeXQDmwNy4sdIwTDw1S7DVLdT21HC1EmgriiU3qmfVavF1o9uIZHZFwPELYnoSbvb1BDeHtT7Mvh/HSw9sU3ToHrvpHaXp9f6kKg/fQWRTKLUw+qOx1Et5tUWUt3k7j079q7W+ByB7ELEtmU9EGM3rH8QgpZk02FQkUKglwDR8m38BRxgebWBwxmXcr318GQW4weIQFvS6TFpXEZdq4LcLoNwVqN7HMRfE4idAsa7rJruw649P1Mi2BCBArSpCXUNjTPHDVQvpZReVZptNdaguJdrm4QOoksdrvf7+YUG075XxlEk26A5W23c3Vi0V7LvqMxDtZysfbke9YWgRDla7Q7wvWFmD8ISEiwHNtUdAfwbaAaVjPdLJ055wCtXqgY294W6LC4uRWp+AN+YiDJjs2dYn81YM7KD2RezHIRHSsxo1DYjBG1m4E2z5TBiiK1GBxw3DfxD0X6y2WcytsbP9Thza1C/c5W7ri5P56/YLLF2f9RfkOmy/
x-ms-exchange-antispam-messagedata: Sgn15CQbIbMgotlk+GhA2yrCq+wFYuc3HwIwG3zPss8yjXHqpwqZ1y/C/obuUmaf9EHIFSJiLxOgR9XOuS0aCDUinbUF62NFWGAas7WSzajndhfcEGIZ4LLYy6KhDoPtwtJ7E+tMy6zq3MDiTLo4jA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95b7dde-1ab8-41e1-45e3-08d7bec0d4de
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 15:46:10.9729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vAzv1Ey11HV6IjH44zz3sOMgYIGGQA5uNNchRw1WV4KwaPomOI9Tbr0awnXRF0TGAgKO+w3mPx8i9iqP7ailNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3800
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
Content-Type: multipart/mixed; boundary="===============2022281514=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2022281514==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB391233C0FB6A888334004711F7E70CH2PR12MB3912namp_"

--_000_CH2PR12MB391233C0FB6A888334004711F7E70CH2PR12MB3912namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Monday, March 2, 2020 5:33 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Clements=
, John <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Chen, Guchu=
n <Guchun.Chen@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: add reset_ras_error_count function for HDP

HDP ras error counters are dirty ones after cold reboot
Read operation is needed to reset them to 0

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c |  1 -
 drivers/gpu/drm/amd/amdgpu/soc15.c    | 14 ++++++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index a58b0cf9da51..b735e20888a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -595,6 +595,7 @@ struct amdgpu_asic_funcs {
         /* invalidate hdp read cache */
         void (*invalidate_hdp)(struct amdgpu_device *adev,
                                struct amdgpu_ring *ring);
+       void (*reset_hdp_ras_error_count)(struct amdgpu_device *adev);
         /* check if the asic needs a full reset of if soft reset will work=
 */
         bool (*need_full_reset)(struct amdgpu_device *adev);
         /* initialize doorbell layout for specific asic*/
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index b746f26f933c..efd52bcf8785 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4149,7 +4149,6 @@ static const struct soc15_reg_entry gfx_v9_0_edc_coun=
ter_regs[] =3D {
    { SOC15_REG_ENTRY(GC, 0, mmTCC_EDC_CNT2), 0, 1, 16},
    { SOC15_REG_ENTRY(GC, 0, mmTCA_EDC_CNT), 0, 1, 2},
    { SOC15_REG_ENTRY(GC, 0, mmSQC_EDC_CNT3), 0, 4, 6},
-   { SOC15_REG_ENTRY(HDP, 0, mmHDP_EDC_CNT), 0, 1, 1},
 };

 static int gfx_v9_0_do_edc_gds_workarounds(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 4aa5b9c8e43b..6b717691d554 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -827,6 +827,15 @@ static bool soc15_need_full_reset(struct amdgpu_device=
 *adev)
         /* change this when we implement soft reset */
         return true;
 }
+
+static void vega20_reset_hdp_ras_error_count(struct amdgpu_device *adev)
+{
+       if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
+               return;
+       /*read back hdp ras counter to reset it to 0 */
+       RREG32_SOC15(HDP, 0, mmHDP_EDC_CNT);
+}
+
 static void soc15_get_pcie_usage(struct amdgpu_device *adev, uint64_t *cou=
nt0,
                                  uint64_t *count1)
 {
@@ -994,6 +1003,7 @@ static const struct amdgpu_asic_funcs vega20_asic_func=
s =3D
         .get_config_memsize =3D &soc15_get_config_memsize,
         .flush_hdp =3D &soc15_flush_hdp,
         .invalidate_hdp =3D &soc15_invalidate_hdp,
+       .reset_hdp_ras_error_count =3D &vega20_reset_hdp_ras_error_count,
         .need_full_reset =3D &soc15_need_full_reset,
         .init_doorbell_index =3D &vega20_doorbell_index_init,
         .get_pcie_usage =3D &vega20_get_pcie_usage,
@@ -1239,6 +1249,10 @@ static int soc15_common_late_init(void *handle)
         if (amdgpu_sriov_vf(adev))
                 xgpu_ai_mailbox_get_irq(adev);

+       if (adev->asic_funcs &&
+           adev->asic_funcs->reset_hdp_ras_error_count)
+               adev->asic_funcs->reset_hdp_ras_error_count(adev);
+
         if (adev->nbio.funcs->ras_late_init)
                 r =3D adev->nbio.funcs->ras_late_init(adev);

--
2.17.1


--_000_CH2PR12MB391233C0FB6A888334004711F7E70CH2PR12MB3912namp_
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
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Hawking Zhang &lt;Haw=
king.Zhang@amd.com&gt;<br>
<b>Sent:</b> Monday, March 2, 2020 5:33 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Clements, John &lt;John.Clements@amd.com&gt;; Li, Dennis &lt;Dennis.Li=
@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Zhou1, Tao &lt;Tao.=
Zhou1@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 4/4] drm/amdgpu: add reset_ras_error_count function =
for HDP</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">HDP ras error counters are dirty ones after cold r=
eboot<br>
Read operation is needed to reset them to 0<br>
<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp; |&nbsp; 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c |&nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp; | 14 &#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;3 files changed, 15 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index a58b0cf9da51..b735e20888a7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -595,6 &#43;595,7 @@ struct amdgpu_asic_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* invalidate hdp read cac=
he */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*invalidate_hdp)(str=
uct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*reset_hdp_ras_error_count)=
(struct amdgpu_device *adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check if the asic needs=
 a full reset of if soft reset will work */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*need_full_reset)(st=
ruct amdgpu_device *adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* initialize doorbell lay=
out for specific asic*/<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index b746f26f933c..efd52bcf8785 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -4149,7 &#43;4149,6 @@ static const struct soc15_reg_entry gfx_v9_0_edc_=
counter_regs[] =3D {<br>
&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmTCC_EDC_CNT2), 0, 1, 16},<br>
&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmTCA_EDC_CNT), 0, 1, 2},<br>
&nbsp;&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, mmSQC_EDC_CNT3), 0, 4, 6},<br>
-&nbsp;&nbsp; { SOC15_REG_ENTRY(HDP, 0, mmHDP_EDC_CNT), 0, 1, 1},<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static int gfx_v9_0_do_edc_gds_workarounds(struct amdgpu_device *adev=
)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index 4aa5b9c8e43b..6b717691d554 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -827,6 &#43;827,15 @@ static bool soc15_need_full_reset(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* change this when we imp=
lement soft reset */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;}<br>
&#43;<br>
&#43;static void vega20_reset_hdp_ras_error_count(struct amdgpu_device *ade=
v)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_is_supported(adev=
, AMDGPU_RAS_BLOCK__HDP))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*read back hdp ras counter to re=
set it to 0 */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32_SOC15(HDP, 0, mmHDP_EDC_CN=
T);<br>
&#43;}<br>
&#43;<br>
&nbsp;static void soc15_get_pcie_usage(struct amdgpu_device *adev, uint64_t=
 *count0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *count1)<br>
&nbsp;{<br>
@@ -994,6 &#43;1003,7 @@ static const struct amdgpu_asic_funcs vega20_asic_=
funcs =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_config_memsize =3D &a=
mp;soc15_get_config_memsize,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flush_hdp =3D &amp;soc15_=
flush_hdp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .invalidate_hdp =3D &amp;s=
oc15_invalidate_hdp,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset_hdp_ras_error_count =3D &a=
mp;vega20_reset_hdp_ras_error_count,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .need_full_reset =3D &amp;=
soc15_need_full_reset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_doorbell_index =3D &=
amp;vega20_doorbell_index_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pcie_usage =3D &amp;v=
ega20_get_pcie_usage,<br>
@@ -1239,6 &#43;1249,10 @@ static int soc15_common_late_init(void *handle)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; xgpu_ai_mailbox_get_irq(adev);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_funcs &amp;&amp=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;=
asic_funcs-&gt;reset_hdp_ras_error_count)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;asic_funcs-&gt;reset_hdp_ras_error_count(adev);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.funcs-&g=
t;ras_late_init)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;nbio.funcs-&gt;ras_late_init(adev);<br=
>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB391233C0FB6A888334004711F7E70CH2PR12MB3912namp_--

--===============2022281514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2022281514==--
