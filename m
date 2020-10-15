Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0A9C433E7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 05:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3E022247
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 05:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F21J5dZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3E022247
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7A7F6EC1B;
	Thu, 15 Oct 2020 05:04:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB8376EC1B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 05:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jb+qXiRBnjGR5bKn1MElqRbziSeepUOJ7NrU40zy0edHZttfbCBrqVRW4SGPT0mjUMylHfd3+Gd/iePOwdzPBzUM2A8WRL9Yrj4NEBqFY/lisis8+HLlImM3faQwfpgI+5dNZY/nPnJCO0dZl/UpF2Vg7Xx3LZFugW6EWNzjVFceeLlu5A6QCNZcf9XsRMiDNXBBdZCFUkpK4hqgQc1CzPvuCG0vDdbmlEozsPLqeEeWjh6G3QgF4ojUpQnLuTzuX7HX1t417pXgh6sPtiU2ePRcvsnNsXU/aiMSg+cRcZAGFROz7BxSYTS9hyur2IRvPNo7CJfcVqj0ZeQwtjkHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73yHx29e3si/bldJx+der23kNJGiwKfZNtNe7dAu0S8=;
 b=Zy0z76nmqKIixIXGrnzIzxeNpYLVTY8pCaHLkO6iV6j1BwHna+HpqVb/xBICDtT9j7CVBFzbcBvxSR6cFO3vdjoIuLXsRADKOYp7CHqEy2rmKRdmXg0zj6m71WV2m5XPErrM1mQID1S8Rlmi3EoNWDrVnidS5vEUIGZqtMZb+mca+kfHbtMwwSX+pzq+by++m1eFmjS3yZjy3UvxwldtPzXfFBHVZ2zidFS3Mthv/oMDabX3WxOLug51ItxtWTKw8dXNbh3TKVgucmi9SjFh47oNTLV9L+6sgdM/MyGCHbinTkzG4yD/ZvF32Y4ny2a/vJWXexlwSht8YmRgvZRiiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73yHx29e3si/bldJx+der23kNJGiwKfZNtNe7dAu0S8=;
 b=F21J5dZ6xN/6mVxdYbj3QMRNI9fXn6RRVNANXYGPseS/iMiesOHa8COfJ2XJJoXR+pF2c0Ju/4FU4/KrB64Fyc5H6R6vgLQST+qqjJf2eE5qZDNhDQNgbUMkxu4a4blh7S4XHltCrKly5RXGnUAeOLSqpxwj4s90z8pFvrZbma4=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3517.namprd12.prod.outlook.com (2603:10b6:208:ab::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Thu, 15 Oct
 2020 05:04:30 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362%4]) with mapi id 15.20.3477.023; Thu, 15 Oct 2020
 05:04:29 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add function to program pbb mode for sienna
 cichlid
Thread-Topic: [PATCH] drm/amdgpu: add function to program pbb mode for sienna
 cichlid
Thread-Index: AQHWoqhJSBYXcU+9iEG1zcfRqSml76mYGWSF
Date: Thu, 15 Oct 2020 05:04:29 +0000
Message-ID: <MN2PR12MB302263758050B41BBF04FB13A2020@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20201015040340.143379-1-likun.gao@amd.com>
In-Reply-To: <20201015040340.143379-1-likun.gao@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-15T05:04:29.081Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24a6b7b2-f187-4e9e-8c0a-08d870c7cc20
x-ms-traffictypediagnostic: MN2PR12MB3517:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB35170EF82B2C9130F9D47721A2020@MN2PR12MB3517.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X++QrZPI9cRFSB6IJ1EOuI6zIu5QRfLq64phKiDRLoXbSR3FEnq0VkslDKXPyw4Fd2HOIjJ5uMRV2/ksSEbzPI5Ih4LZVCn4umMyfBfaxhp5eJBinZYF0hEALJ24yv6xNl0AnlLHwudGs+creKHZhG4HzZVYuIbM01254b5MLvaWfycqMfcrztDwMYvdUa3YEKuKvXZcXDkOGiEvxTYRlApTnzKCPqvqwPz/9jPCpB7mIjh9i8lGN9eTX1p/gzlxOJBhCupd24vD8MDHNLjcwUzlKvy39NjoLXpJAZeBrbF9BFBZyuRN6zdSVd6lTYnrcar5HwkQ+742sFRhtYFOgyk2roiCkMkq5B30JQvAC/c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(33656002)(66476007)(91956017)(66556008)(66446008)(64756008)(76116006)(66946007)(83380400001)(8936002)(5660300002)(19627405001)(166002)(7696005)(45080400002)(52536014)(8676002)(6506007)(86362001)(966005)(53546011)(316002)(9686003)(110136005)(26005)(71200400001)(186003)(55016002)(2906002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: i+Qmv7BIok51KH/KXy22cIWz7p7wO0J6hRsrZKWorr7j2LDAmyF9TmlSs0UNR1NSXv1Ba5s4AOFirgdRl1IrrAyroQBnIdLLlHc4hrMDRPZRu6l+QVTLoxIKbMgB8SVsmFDXXC79KFC/vsXaU9RCMYmUxDgwIpUMUFoxu4I+a3uzJi0wwNcUc1zJGP8X19f7DJuaBL5cHv/YZdgcufgVND331FgHmP/6KkSWq/sFBPQ8kZhh+IaQWMWics+GuZL80yrHo7QMUiCOrcwzVr4hM08y5+R5HUcr2K91KiP51R0MVJ9krQUsFS1co3An5r/Q5Inwch0Ylrl3yRmeBeSrvXr6N25VECRGNmOA+EHbaICfXVYliJjoCIXg83OEFQWuLqCF2C0bWHYuwSjctEHfCqJGA9q9ISCj0CbJzgBELPAdOMdMMINiOhwinCNlzm9lkaTgZtgHGkQFnB68O/pFvrHGz1BIH5/VIja7NFE1Ow4jlt/E94nBeIdZIqgJ8jVMFBJkCHKbehHMWnVgVpVfnzIkrLe/Vp35p1pYmASZbf1T/X9b6K0ElLqsjVCa9TNZXJ0kWerHWPivhxVZodC1V/XICP/v+yujUiVBoJ8l+tTaD2AyBz6402TIYAo4MCaD4XDk6XjAnNiMYZtCRtu4Lg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a6b7b2-f187-4e9e-8c0a-08d870c7cc20
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 05:04:29.6753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gn9mWD7Twy1qonIKiSubN/cV66rLuNjyBffVazUOLW+KcPb5/c6ZHh2IJw1HOYgE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3517
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
Content-Type: multipart/mixed; boundary="===============0867327517=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0867327517==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB302263758050B41BBF04FB13A2020MN2PR12MB3022namp_"

--_000_MN2PR12MB302263758050B41BBF04FB13A2020MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]



________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Likun Ga=
o <likun.gao@amd.com>
Sent: Thursday, October 15, 2020 12:03 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: add function to program pbb mode for sienna ci=
chlid

From: Likun Gao <Likun.Gao@amd.com>

Add function for sienna_cichlid to force PBB workload mode to zero by
checking whether there have SE been harvested.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I3bf2fe0b976affe26c829ac67bee176018f13fe9
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 65804137b7f8..aa48eab85c7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -112,6 +112,22 @@
 #define mmCP_HYP_ME_UCODE_DATA                  0x5817
 #define mmCP_HYP_ME_UCODE_DATA_BASE_IDX         1

+//CC_GC_SA_UNIT_DISABLE
+#define mmCC_GC_SA_UNIT_DISABLE                 0x0fe9
+#define mmCC_GC_SA_UNIT_DISABLE_BASE_IDX        0
+#define CC_GC_SA_UNIT_DISABLE__SA_DISABLE__SHIFT       0x8
+#define CC_GC_SA_UNIT_DISABLE__SA_DISABLE_MASK         0x0000FF00L
+//GC_USER_SA_UNIT_DISABLE
+#define mmGC_USER_SA_UNIT_DISABLE               0x0fea
+#define mmGC_USER_SA_UNIT_DISABLE_BASE_IDX      0
+#define GC_USER_SA_UNIT_DISABLE__SA_DISABLE__SHIFT     0x8
+#define GC_USER_SA_UNIT_DISABLE__SA_DISABLE_MASK       0x0000FF00L
+//PA_SC_ENHANCE_3
+#define mmPA_SC_ENHANCE_3                       0x1085
+#define mmPA_SC_ENHANCE_3_BASE_IDX              0
+#define PA_SC_ENHANCE_3__FORCE_PBB_WORKLOAD_MODE_TO_ZERO__SHIFT 0x3
+#define PA_SC_ENHANCE_3__FORCE_PBB_WORKLOAD_MODE_TO_ZERO_MASK   0x00000008=
L
+
 MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
 MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
 MODULE_FIRMWARE("amdgpu/navi10_me.bin");
@@ -3188,6 +3204,8 @@ static int gfx_v10_0_wait_for_rlc_autoload_complete(s=
truct amdgpu_device *adev);
 static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool res=
ume);
 static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool res=
ume);
 static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool =
start, bool secure);
+static u32 gfx_v10_3_get_disabled_sa(struct amdgpu_device *adev);
+static void gfx_v10_3_program_pbb_mode(struct amdgpu_device *adev);

 static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t=
 queue_mask)
 {
@@ -6990,6 +7008,9 @@ static int gfx_v10_0_hw_init(void *handle)
         if (r)
                 return r;

+       if (adev->asic_type =3D=3D CHIP_SIENNA_CICHLID)
+               gfx_v10_3_program_pbb_mode(adev);
+
         return r;
 }

@@ -8841,6 +8862,47 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_devic=
e *adev,
         return 0;
 }

+static u32 gfx_v10_3_get_disabled_sa(struct amdgpu_device *adev)
+{
+       uint32_t efuse_setting, vbios_setting, disabled_sa, max_sa_mask;
+
+       efuse_setting =3D RREG32_SOC15(GC, 0, mmCC_GC_SA_UNIT_DISABLE);
+       efuse_setting &=3D CC_GC_SA_UNIT_DISABLE__SA_DISABLE_MASK;
+       efuse_setting >>=3D CC_GC_SA_UNIT_DISABLE__SA_DISABLE__SHIFT;
+
+       vbios_setting =3D RREG32_SOC15(GC, 0, mmGC_USER_SA_UNIT_DISABLE);
+       vbios_setting &=3D GC_USER_SA_UNIT_DISABLE__SA_DISABLE_MASK;
+       vbios_setting >>=3D GC_USER_SA_UNIT_DISABLE__SA_DISABLE__SHIFT;

[kevin]:
the above codes can be replaced with helper macro of "REG_GET_FIELD".
#define REG_GET_FIELD(value, reg, field)                                \
        (((value) & REG_FIELD_MASK(reg, field)) >> REG_FIELD_SHIFT(reg, fie=
ld))
+
+       max_sa_mask =3D amdgpu_gfx_create_bitmask(adev->gfx.config.max_sh_p=
er_se *
+                                               adev->gfx.config.max_shader=
_engines);
+       disabled_sa =3D efuse_setting | vbios_setting;
+       disabled_sa &=3D max_sa_mask;
+
+       return disabled_sa;
+}
+
+static void gfx_v10_3_program_pbb_mode(struct amdgpu_device *adev)
+{
+       uint32_t max_sa_per_se, max_sa_per_se_mask, max_shader_engines;
+       uint32_t disabled_sa_mask, se_index, disabled_sa_per_se;
+
+       disabled_sa_mask =3D gfx_v10_3_get_disabled_sa(adev);
+
+       max_sa_per_se =3D adev->gfx.config.max_sh_per_se;
+       max_sa_per_se_mask =3D (1 << max_sa_per_se) - 1;
+       max_shader_engines =3D adev->gfx.config.max_shader_engines;
+
+       for (se_index =3D 0; max_shader_engines > se_index; se_index++) {
+               disabled_sa_per_se =3D disabled_sa_mask >> (se_index * max_=
sa_per_se);
+               disabled_sa_per_se &=3D max_sa_per_se_mask;
+               if (disabled_sa_per_se =3D=3D max_sa_per_se_mask) {
+                       WREG32_FIELD15(GC, 0, PA_SC_ENHANCE_3, FORCE_PBB_WO=
RKLOAD_MODE_TO_ZERO, 1);
+                       break;
+               }
+       }
+}
+
 const struct amdgpu_ip_block_version gfx_v10_0_ip_block =3D
 {
         .type =3D AMD_IP_BLOCK_TYPE_GFX,
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7Caa2f838b492e41b2b35c08d870bf6a6b%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637383314725026504&amp;sdata=3D63CLPN9Dw6NsIk2qXyRepfGpL=
XbCznLVu%2BegsnJq%2BPg%3D&amp;reserved=3D0

--_000_MN2PR12MB302263758050B41BBF04FB13A2020MN2PR12MB3022namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Likun Gao &lt;likun.gao@amd.c=
om&gt;<br>
<b>Sent:</b> Thursday, October 15, 2020 12:03 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Gao, Likun &lt;Likun.Gao@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add function to program pbb mode for si=
enna cichlid</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: Likun Gao &lt;Likun.Gao@amd.com&gt;<br>
<br>
Add function for sienna_cichlid to force PBB workload mode to zero by<br>
checking whether there have SE been harvested.<br>
<br>
Signed-off-by: Likun Gao &lt;Likun.Gao@amd.com&gt;<br>
Change-Id: I3bf2fe0b976affe26c829ac67bee176018f13fe9<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 62 +++++++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 62 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 65804137b7f8..aa48eab85c7a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -112,6 +112,22 @@<br>
&nbsp;#define mmCP_HYP_ME_UCODE_DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x5817<br>
&nbsp;#define mmCP_HYP_ME_UCODE_DATA_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 1<br>
&nbsp;<br>
+//CC_GC_SA_UNIT_DISABLE<br>
+#define mmCC_GC_SA_UNIT_DISABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0fe9<br>
+#define mmCC_GC_SA_UNIT_DISABLE_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0<br>
+#define CC_GC_SA_UNIT_DISABLE__SA_DISABLE__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x8<br>
+#define CC_GC_SA_UNIT_DISABLE__SA_DISABLE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x0000FF00L<br>
+//GC_USER_SA_UNIT_DISABLE<br>
+#define mmGC_USER_SA_UNIT_DISABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0fea<br>
+#define mmGC_USER_SA_UNIT_DISABLE_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
<br>
+#define GC_USER_SA_UNIT_DISABLE__SA_DISABLE__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;=
 0x8<br>
+#define GC_USER_SA_UNIT_DISABLE__SA_DISABLE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x0000FF00L<br>
+//PA_SC_ENHANCE_3<br>
+#define mmPA_SC_ENHANCE_3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0x1085<br>
+#define mmPA_SC_ENHANCE_3_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+#define PA_SC_ENHANCE_3__FORCE_PBB_WORKLOAD_MODE_TO_ZERO__SHIFT 0x3<br>
+#define PA_SC_ENHANCE_3__FORCE_PBB_WORKLOAD_MODE_TO_ZERO_MASK&nbsp;&nbsp; =
0x00000008L<br>
+<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/navi10_ce.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/navi10_pfp.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/navi10_me.bin&quot;);<br>
@@ -3188,6 +3204,8 @@ static int gfx_v10_0_wait_for_rlc_autoload_complete(s=
truct amdgpu_device *adev);<br>
&nbsp;static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, boo=
l resume);<br>
&nbsp;static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, boo=
l resume);<br>
&nbsp;static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, =
bool start, bool secure);<br>
+static u32 gfx_v10_3_get_disabled_sa(struct amdgpu_device *adev);<br>
+static void gfx_v10_3_program_pbb_mode(struct amdgpu_device *adev);<br>
&nbsp;<br>
&nbsp;static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uin=
t64_t queue_mask)<br>
&nbsp;{<br>
@@ -6990,6 +7008,9 @@ static int gfx_v10_0_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_SI=
ENNA_CICHLID)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gfx_v10_3_program_pbb_mode(adev);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -8841,6 +8862,47 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static u32 gfx_v10_3_get_disabled_sa(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t efuse_setting, vbios_setting=
, disabled_sa, max_sa_mask;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; efuse_setting =3D RREG32_SOC15(GC, 0,=
 mmCC_GC_SA_UNIT_DISABLE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; efuse_setting &amp;=3D CC_GC_SA_UNIT_=
DISABLE__SA_DISABLE_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; efuse_setting &gt;&gt;=3D CC_GC_SA_UN=
IT_DISABLE__SA_DISABLE__SHIFT;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_setting =3D RREG32_SOC15(GC, 0,=
 mmGC_USER_SA_UNIT_DISABLE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_setting &amp;=3D GC_USER_SA_UNI=
T_DISABLE__SA_DISABLE_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_setting &gt;&gt;=3D GC_USER_SA_=
UNIT_DISABLE__SA_DISABLE__SHIFT;</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">the above codes can be replaced with helper macro =
of &quot;REG_GET_FIELD&quot;.</div>
<div class=3D"PlainText">#define REG_GET_FIELD(value, reg, field) &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;\</div>
<div class=3D"PlainText">&nbsp; &nbsp; &nbsp; &nbsp; (((value) &amp; REG_FI=
ELD_MASK(reg, field)) &gt;&gt; REG_FIELD_SHIFT(reg, field))<br>
</div>
<div class=3D"PlainText">+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_sa_mask =3D amdgpu_gfx_create_bit=
mask(adev-&gt;gfx.config.max_sh_per_se *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.ma=
x_shader_engines);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disabled_sa =3D efuse_setting | vbios=
_setting;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disabled_sa &amp;=3D max_sa_mask;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return disabled_sa;<br>
+}<br>
+<br>
+static void gfx_v10_3_program_pbb_mode(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_sa_per_se, max_sa_per_se=
_mask, max_shader_engines;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t disabled_sa_mask, se_index, =
disabled_sa_per_se;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disabled_sa_mask =3D gfx_v10_3_get_di=
sabled_sa(adev);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_sa_per_se =3D adev-&gt;gfx.config=
.max_sh_per_se;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_sa_per_se_mask =3D (1 &lt;&lt; ma=
x_sa_per_se) - 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_shader_engines =3D adev-&gt;gfx.c=
onfig.max_shader_engines;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (se_index =3D 0; max_shader_engin=
es &gt; se_index; se_index++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; disabled_sa_per_se =3D disabled_sa_mask &gt;&gt; (se_index * max=
_sa_per_se);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; disabled_sa_per_se &amp;=3D max_sa_per_se_mask;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (disabled_sa_per_se =3D=3D max_sa_per_se_mask) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15(G=
C, 0, PA_SC_ENHANCE_3, FORCE_PBB_WORKLOAD_MODE_TO_ZERO, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}<br>
+<br>
&nbsp;const struct amdgpu_ip_block_version gfx_v10_0_ip_block =3D<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .type =3D AMD_IP_BLOCK_TYP=
E_GFX,<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7Caa2f838b492e41b2b35c08d870bf6a6b%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637383314725026504&amp;amp;sdata=3D63CLPN=
9Dw6NsIk2qXyRepfGpLXbCznLVu%2BegsnJq%2BPg%3D&amp;amp;reserved=3D0">https://=
nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedeskt=
op.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%=
40amd.com%7Caa2f838b492e41b2b35c08d870bf6a6b%7C3dd8961fe4884e608e11a82d994e=
183d%7C0%7C0%7C637383314725026504&amp;amp;sdata=3D63CLPN9Dw6NsIk2qXyRepfGpL=
XbCznLVu%2BegsnJq%2BPg%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB302263758050B41BBF04FB13A2020MN2PR12MB3022namp_--

--===============0867327517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0867327517==--
