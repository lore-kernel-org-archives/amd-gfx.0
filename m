Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843EAC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 14:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5518E2070B
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 14:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5518E2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 217876EA64;
	Wed, 20 Nov 2019 14:27:57 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790074.outbound.protection.outlook.com [40.107.79.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 796166EA60
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 14:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zz49UjAMtOr2llaI/vs9DxMZwgKoAy9CRvztzeBZ+sOVNnPNo5oxQmGxlKoov/3hPvhHgAn8xDYgyISkcRq2lhZcTnGTJAXDeNi3zTQgHpeqDqvRIWsquii711ISGu+aFQof8KVf6LtpyHFv9mhXAdoJOepg12qoEn6xQvfRb6x5R3pBtCW/R6n2Co7K8PN3BT6SVRf3INC+Zht5s5wtAYkbQTEOlWQIp9LgpfRGPSnFhN6+pAmhTxlVezJX/pqYTMD75OqysDB2/1HKA3n+xx+e4R3s9pzUna/GKeOMI0scna9M+Vm1XtPlY+FXehTLU35QDE7Jy7zz+iFUJRmhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1YRwnBXoV/PpzGPESwhSTrSsjtInKDBVTuvTT9aXWg=;
 b=CBluztIreV0nUblAomUWYQ+/2iaQFwBcV5KC4Ihyd+P/Gutk17iZddJhIs0go5PWxPOD6ZOmB8cVAm3rJ1zvbEvh4K/EtMSRebgxnzCqzr9ocOg6Itb0aStKZiYf4pJ1fTwdPJ62nOt2gT0RD0VFqAP4wES9HEtF8GbHzvVytfP64NtMxK+vcsbHKMYCVdvKdaPS79KrXutq41KL7KA30HQtA3PcTI1vh7KibJrJFZBXDsvi0q10RfUr6Nfxhc+YBf5JuWJoftJXqUFgRukjfto7qfsX7FpJzXbeJji2vipkSYtLlKAr8+0iCdc0nZBLwpiP+z5HI7OXpyIF/PisWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1813.namprd12.prod.outlook.com (10.175.80.21) by
 CY4PR12MB1432.namprd12.prod.outlook.com (10.168.170.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 14:27:53 +0000
Received: from CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc]) by CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc%4]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 14:27:53 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: Re: [PATCH v2 1/3] drm/amdgpu: define soc15_ras_field_entry for reuse
Thread-Topic: [PATCH v2 1/3] drm/amdgpu: define soc15_ras_field_entry for reuse
Thread-Index: AQHVn5A922jqmfM1Z0q/ca+Cmm0FKqeUHi1o
Date: Wed, 20 Nov 2019 14:27:53 +0000
Message-ID:
 <CY4PR12MB1813C8B5B9072C875E0DFD6AF74F0@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <20191120104932.16257-1-Dennis.Li@amd.com>,
 <20191120104932.16257-2-Dennis.Li@amd.com>
In-Reply-To: <20191120104932.16257-2-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 207dbe74-e8e2-4c9a-1e0e-08d76dc5d425
x-ms-traffictypediagnostic: CY4PR12MB1432:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1432EFA880F3F271459FB327F74F0@CY4PR12MB1432.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:565;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(199004)(189003)(55016002)(33656002)(5660300002)(53546011)(76176011)(476003)(105004)(6246003)(6636002)(446003)(478600001)(2906002)(66476007)(81156014)(229853002)(81166006)(9686003)(54896002)(25786009)(6116002)(3846002)(6436002)(8676002)(14454004)(186003)(76116006)(7736002)(7696005)(6506007)(26005)(102836004)(11346002)(486006)(8936002)(99286004)(52536014)(110136005)(66446008)(66556008)(74316002)(64756008)(256004)(66946007)(2501003)(71190400001)(316002)(19627405001)(71200400001)(66066001)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1432;
 H:CY4PR12MB1813.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bIAgD0LBH2XYHFjqYf/aFJA36zOeIwAfKqppWjGAnv0IX2mDt5PA0SdoWH11BCHNcWO9ttKtoGWfjvqSxTvcD2Pg/ZTxr2PRHj+N7dDP2d/5dXwLnqjmoKFcajQD7nHTwtbH35MkvQekP5se2bla4c4xmX0LDKNy4n76pwXP6hKsJ/Zp/JlBuTRkRga+lUr+LnidzQIzM7DD+z3Jt5YyOGhptIYSveATb/MRal+Jeg5xA5CCE2YFhZQUKaCE7UW3xwtbHv1r34cR6snLGT0TwORRc7LVw9gAGK9fmEaAAjP7pmZO65qf94z6aruefKbn9Wn54fG+so6uJfmOb/DWxBH8Jk71la1534AF/B/VITnledtX+MjjSzBxboM3UMdb+GfUBFSJe6WrnkYru73n7IXlHHYkvZLB3WCXkLK0rl7Pfl99LcFpioAcz+JtGD9a
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207dbe74-e8e2-4c9a-1e0e-08d76dc5d425
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 14:27:53.0582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cSOlOl9x2IajaJxAcJ/1PamHm3IOVGF53akFUHrstyX0WmsHNCxnneO09SW0YXaq6/h2ECK/UW3IrQmiY3MMlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1432
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1YRwnBXoV/PpzGPESwhSTrSsjtInKDBVTuvTT9aXWg=;
 b=fU1xbhEHfLHKvXW1F5rbRnM+eOU6xA0NWT4LBPAoclIKOmmZB2NlEnXmr5E/uXPKGC6Cn9zqInRX/DJXHvTAWiyvfnt7SE4W7Bo0O3snUKOpEjO+zTf8+6+h+gYuCN1lszfOuGkTq60l2j4Hq6I4H3c6FEAmHwd2cqgb0sVr7Yk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0903227820=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120142753.k6QfnshjgAe7lsjrGaxKHuPT_GZf4R81aHxXta1PDUg@z>

--===============0903227820==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1813C8B5B9072C875E0DFD6AF74F0CY4PR12MB1813namp_"

--_000_CY4PR12MB1813C8B5B9072C875E0DFD6AF74F0CY4PR12MB1813namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Dennis Li <Dennis.Li@amd.com>
Sent: Wednesday, November 20, 2019 5:49 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zha=
ng, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>; Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu: define soc15_ras_field_entry for reuse

The struct soc15_ras_field_entry will be reused by
other IPs, such as mmhub and gc

v2: rename ras_subblock_regs to gc_ras_fields_vg20,
because the future asic maybe have a different table.

Change-Id: I6c3388a09b5fbf927ad90fcd626baa448d1681a6
Signed-off-by: Dennis Li <dennis.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 34 +++++++++------------------
 drivers/gpu/drm/amd/amdgpu/soc15.h    | 12 ++++++++++
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index c7ae685d6f74..8073fcd4720e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -131,18 +131,6 @@ MODULE_FIRMWARE("amdgpu/renoir_rlc.bin");
 #define mmTCP_CHAN_STEER_5_ARCT                                           =
              0x0b0c
 #define mmTCP_CHAN_STEER_5_ARCT_BASE_IDX                                  =
                      0

-struct ras_gfx_subblock_reg {
-       const char *name;
-       uint32_t hwip;
-       uint32_t inst;
-       uint32_t seg;
-       uint32_t reg_offset;
-       uint32_t sec_count_mask;
-       uint32_t sec_count_shift;
-       uint32_t ded_count_mask;
-       uint32_t ded_count_shift;
-};
-
 enum ta_ras_gfx_subblock {
         /*CPC*/
         TA_RAS_BLOCK__GFX_CPC_INDEX_START =3D 0,
@@ -5487,7 +5475,7 @@ static int gfx_v9_0_priv_inst_irq(struct amdgpu_devic=
e *adev,
 }


-static const struct ras_gfx_subblock_reg ras_subblock_regs[] =3D {
+static const struct soc15_ras_field_entry gc_ras_fields_vg20[] =3D {
         { "CPC_SCRATCH", SOC15_REG_ENTRY(GC, 0, mmCPC_EDC_SCRATCH_CNT),
           SOC15_REG_FIELD(CPC_EDC_SCRATCH_CNT, SEC_COUNT),
           SOC15_REG_FIELD(CPC_EDC_SCRATCH_CNT, DED_COUNT)
@@ -6146,29 +6134,29 @@ static int __get_ras_error_count(const struct soc15=
_reg_entry *reg,
         uint32_t i;
         uint32_t sec_cnt, ded_cnt;

-       for (i =3D 0; i < ARRAY_SIZE(ras_subblock_regs); i++) {
-               if(ras_subblock_regs[i].reg_offset !=3D reg->reg_offset ||
-                       ras_subblock_regs[i].seg !=3D reg->seg ||
-                       ras_subblock_regs[i].inst !=3D reg->inst)
+       for (i =3D 0; i < ARRAY_SIZE(gc_ras_fields_vg20); i++) {
+               if(gc_ras_fields_vg20[i].reg_offset !=3D reg->reg_offset ||
+                       gc_ras_fields_vg20[i].seg !=3D reg->seg ||
+                       gc_ras_fields_vg20[i].inst !=3D reg->inst)
                         continue;

                 sec_cnt =3D (value &
-                               ras_subblock_regs[i].sec_count_mask) >>
-                               ras_subblock_regs[i].sec_count_shift;
+                               gc_ras_fields_vg20[i].sec_count_mask) >>
+                               gc_ras_fields_vg20[i].sec_count_shift;
                 if (sec_cnt) {
                         DRM_INFO("GFX SubBlock %s, Instance[%d][%d], SEC %=
d\n",
-                               ras_subblock_regs[i].name,
+                               gc_ras_fields_vg20[i].name,
                                 se_id, inst_id,
                                 sec_cnt);
                         *sec_count +=3D sec_cnt;
                 }

                 ded_cnt =3D (value &
-                               ras_subblock_regs[i].ded_count_mask) >>
-                               ras_subblock_regs[i].ded_count_shift;
+                               gc_ras_fields_vg20[i].ded_count_mask) >>
+                               gc_ras_fields_vg20[i].ded_count_shift;
                 if (ded_cnt) {
                         DRM_INFO("GFX SubBlock %s, Instance[%d][%d], DED %=
d\n",
-                               ras_subblock_regs[i].name,
+                               gc_ras_fields_vg20[i].name,
                                 se_id, inst_id,
                                 ded_cnt);
                         *ded_count +=3D ded_cnt;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgp=
u/soc15.h
index 9af6c6ffbfa2..344280b869c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -60,6 +60,18 @@ struct soc15_allowed_register_entry {
         bool grbm_indexed;
 };

+struct soc15_ras_field_entry {
+       const char *name;
+       uint32_t hwip;
+       uint32_t inst;
+       uint32_t seg;
+       uint32_t reg_offset;
+       uint32_t sec_count_mask;
+       uint32_t sec_count_shift;
+       uint32_t ded_count_mask;
+       uint32_t ded_count_shift;
+};
+
 #define SOC15_REG_ENTRY(ip, inst, reg)  ip##_HWIP, inst, reg##_BASE_IDX, r=
eg

 #define SOC15_REG_ENTRY_OFFSET(entry)   (adev->reg_offset[entry.hwip][entr=
y.inst][entry.seg] + entry.reg_offset)
--
2.17.1


--_000_CY4PR12MB1813C8B5B9072C875E0DFD6AF74F0CY4PR12MB1813namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dennis Li &lt;Dennis.=
Li@amd.com&gt;<br>
<b>Sent:</b> Wednesday, November 20, 2019 5:49 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhou1, Tao &lt;T=
ao.Zhou1@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Chen, G=
uchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Cc:</b> Li, Dennis &lt;Dennis.Li@amd.com&gt;; Li, Dennis &lt;Dennis.Li@a=
md.com&gt;<br>
<b>Subject:</b> [PATCH v2 1/3] drm/amdgpu: define soc15_ras_field_entry for=
 reuse</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The struct soc15_ras_field_entry will be reused by=
<br>
other IPs, such as mmhub and gc<br>
<br>
v2: rename ras_subblock_regs to gc_ras_fields_vg20,<br>
because the future asic maybe have a different table.<br>
<br>
Change-Id: I6c3388a09b5fbf927ad90fcd626baa448d1681a6<br>
Signed-off-by: Dennis Li &lt;dennis.li@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 34 &#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;------------------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.h&nbsp;&nbsp;&nbsp; | 12 &#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;2 files changed, 23 insertions(&#43;), 23 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index c7ae685d6f74..8073fcd4720e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -131,18 &#43;131,6 @@ MODULE_FIRMWARE(&quot;amdgpu/renoir_rlc.bin&quot;)=
;<br>
&nbsp;#define mmTCP_CHAN_STEER_5_ARCT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
x0b0c<br>
&nbsp;#define mmTCP_CHAN_STEER_5_ARCT_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0<br>
&nbsp;<br>
-struct ras_gfx_subblock_reg {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *name;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hwip;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t seg;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg_offset;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sec_count_mask;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sec_count_shift;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ded_count_mask;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ded_count_shift;<br>
-};<br>
-<br>
&nbsp;enum ta_ras_gfx_subblock {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*CPC*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_RAS_BLOCK__GFX_CPC_INDE=
X_START =3D 0,<br>
@@ -5487,7 &#43;5475,7 @@ static int gfx_v9_0_priv_inst_irq(struct amdgpu_d=
evice *adev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;<br>
-static const struct ras_gfx_subblock_reg ras_subblock_regs[] =3D {<br>
&#43;static const struct soc15_ras_field_entry gc_ras_fields_vg20[] =3D {<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { &quot;CPC_SCRATCH&quot;,=
 SOC15_REG_ENTRY(GC, 0, mmCPC_EDC_SCRATCH_CNT),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_FIEL=
D(CPC_EDC_SCRATCH_CNT, SEC_COUNT),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_FIEL=
D(CPC_EDC_SCRATCH_CNT, DED_COUNT)<br>
@@ -6146,29 &#43;6134,29 @@ static int __get_ras_error_count(const struct s=
oc15_reg_entry *reg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sec_cnt, ded_cnt;=
<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(ras_s=
ubblock_regs); i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if(ras_subblock_regs[i].reg_offset !=3D reg-&gt;reg_offset ||<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_subblock_reg=
s[i].seg !=3D reg-&gt;seg ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_subblock_reg=
s[i].inst !=3D reg-&gt;inst)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(g=
c_ras_fields_vg20); i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if(gc_ras_fields_vg20[i].reg_offset !=3D reg-&gt;reg_offset =
||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ras_field=
s_vg20[i].seg !=3D reg-&gt;seg ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ras_field=
s_vg20[i].inst !=3D reg-&gt;inst)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sec_cnt =3D (value &amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_subblock_regs[i].sec_count_mask) &gt;&g=
t;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_subblock_regs[i].sec_count_shift;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ras_fields_vg20[i].sec_count_mask) &=
gt;&gt;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ras_fields_vg20[i].sec_count_shift;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (sec_cnt) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_I=
NFO(&quot;GFX SubBlock %s, Instance[%d][%d], SEC %d\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_subblock_regs[i].name,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ras_fields_vg20[i].name,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se_id, inst_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sec_cnt);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *sec_=
count &#43;=3D sec_cnt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ded_cnt =3D (value &amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_subblock_regs[i].ded_count_mask) &gt;&g=
t;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_subblock_regs[i].ded_count_shift;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ras_fields_vg20[i].ded_count_mask) &=
gt;&gt;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ras_fields_vg20[i].ded_count_shift;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ded_cnt) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_I=
NFO(&quot;GFX SubBlock %s, Instance[%d][%d], DED %d\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_subblock_regs[i].name,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ras_fields_vg20[i].name,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se_id, inst_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ded_cnt);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ded_=
count &#43;=3D ded_cnt;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgp=
u/soc15.h<br>
index 9af6c6ffbfa2..344280b869c4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.h<br>
@@ -60,6 &#43;60,18 @@ struct soc15_allowed_register_entry {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool grbm_indexed;<br>
&nbsp;};<br>
&nbsp;<br>
&#43;struct soc15_ras_field_entry {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *name;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hwip;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t seg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg_offset;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sec_count_mask;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sec_count_shift;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ded_count_mask;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ded_count_shift;<br>
&#43;};<br>
&#43;<br>
&nbsp;#define SOC15_REG_ENTRY(ip, inst, reg)&nbsp; ip##_HWIP, inst, reg##_B=
ASE_IDX, reg<br>
&nbsp;<br>
&nbsp;#define SOC15_REG_ENTRY_OFFSET(entry)&nbsp;&nbsp; (adev-&gt;reg_offse=
t[entry.hwip][entry.inst][entry.seg] &#43; entry.reg_offset)<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1813C8B5B9072C875E0DFD6AF74F0CY4PR12MB1813namp_--

--===============0903227820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0903227820==--
