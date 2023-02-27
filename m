Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C2CC6FA8E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 02:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 537F310E138;
	Mon, 27 Feb 2023 02:33:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF85C10E138
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 02:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5yLvfNFlInPjJ0bG4N2+O08FCzrikftjwefjThYpbUCIWvFVKHhtt5NjX3nbIpGB5WgybtiUU7/zlcMPl/PbjodGqrNgvZPOoTtVIWiIX6gHrVzo1m3oxzOLhQfeluBx7ASzqWQo/jchm4pLhyvQpZ3LsZ765acfRwgiIke2AvtJ11/t57rPlk69bwgoz+dwKj+/h+UOgkmmo2RMvmCBAzTNxS0HfKVH+lYXZTkpvHA4YPZzuiB2h+b2ATAg1uDceQ78C2p0zTx0rlLgHkKmkHBEZAwexZekgS75wmjbFweYIgPcbduyz+EqEOrZvIapfslejRxdLVbA1Ti4v9mcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYz9sG0WkEdHQ9hUcWgzpPa9MYYXe9Ia7aCeQt2BM04=;
 b=b0HCN6U0ACS9Vk2I1deZcl/n6vP8CtFyhAM5mA+Iy6rpj8f2xu9wNMv/XWPhdJgV1pPS24Enzqz2R8OKjW9zIOh02aoCEqWuNoPrOZ1JfEDLfMexq9CwEc61KjawLkr1VYWDW74lP/DgKcBLicuBOeZsr8+XF/5WoH+rheA+OIHoJVP+tKfyyYlGQCSRzEwAv7S8aRGQYWiywYDfcAfcsccyD+qtAx77k6p9kJvsipHJEH74Js0aKoZmx/xlHAeagxqE40kTPL1LhoDHt6pvMvmVsoZeNzwo7F6Pe8fuU74DxPxoMl8Bc4rkm447Wj/sMfNqWFUh09GCsp5rfgAiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYz9sG0WkEdHQ9hUcWgzpPa9MYYXe9Ia7aCeQt2BM04=;
 b=EAJjEhAJYAs3Rbi6MuqivatTEqiGXaTAEiWbBxnaG8pCadL4E6WPfLidZj3EsnZKxxKHYPFp0kx1OsWvU2QSaOfNZDsMGsON9E2RcDFP1rGYASYmvz1mPKRp4jZT/9pxlN/J2plwN4oGphVSHtccugAZ3UxrGWtKVMy1rdGhwEM=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Mon, 27 Feb
 2023 02:33:05 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103%7]) with mapi id 15.20.6111.019; Mon, 27 Feb 2023
 02:33:04 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix ttm_bo calltrace warning in psp_hw_fini
Thread-Topic: [PATCH] drm/amdgpu: fix ttm_bo calltrace warning in psp_hw_fini
Thread-Index: AQHZSlErA0wY+krKFUKjXZz7a/p+na7iEvFA
Date: Mon, 27 Feb 2023 02:33:04 +0000
Message-ID: <DM5PR12MB2469DC9ADEC6F91F473449D5F1AF9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230227021356.881572-1-Hongkun.Zhang@amd.com>
In-Reply-To: <20230227021356.881572-1-Hongkun.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|BL3PR12MB6545:EE_
x-ms-office365-filtering-correlation-id: f387391d-4a68-4bf2-b947-08db186af439
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4kizWgPNqPXQESt4jXNqd5io1BEAFx/4/Bli+RXa4SJhzw/ctE6/nqYrNZtfUROu+YkKboSfIY38R8VbSXBM710TWR2GdzS3ccqIoUREQScfHazwYdEJ/Y699SmdWFD9AJxjXhPeN41IZ+YAaMuHmpqkZeGMi32Rs0pg+I26BPOAhBpbRmD3dWHNE0I8yOFnaF/nbKGWqzTwA2rWobtjMIWNVZhy6SgukfvfxXkMGWrlp2pk0bg11wQ+kV4h0GsmVmqT6dlmb10UVX2ByzETEYha8j1uwXNgeIIMx9qlR6L3k5nwUT6+UHz4zqOJWRtd1ykbt+Z/3LMfUB1hA2eBpSTn6LPMgul4sCJMBwm+NpngQbqZGHcrPH3eAVl6hwa8V7p8nzy9Zqp0tb7Tx3FmLML5Yx2Zm8AYw/tada/KjIrWTGafA+m0H0jLRXDOdj4R1TKeH8nd3ZHYI26iBPD/IH96Z9Z2UOAUT+zS5LlA6zU92tAFz0Jzh42JBqTTSuLTlGtZ+u7q+tOPQb0DdpDZgAjpb+j1AyfiantRHfHTd5QsRwcW6M0A47P8m+yfh0AHdnorP17rB+Em4smIksO8SGlLqmQkDea+2kAjuJWzax2nfHBIj+yxVl/5nfcUJPG17ftOWi1eNwQwKT6qiuu1Cx0VpnAM70gK1Ad6ZsxcA7eGppXEDB4se0zn9Xxfkyw5KOphoyM/uEEsmTW8Nra64g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199018)(71200400001)(110136005)(478600001)(7696005)(66476007)(66446008)(64756008)(66946007)(4326008)(8676002)(76116006)(66556008)(41300700001)(52536014)(8936002)(55016003)(33656002)(86362001)(38070700005)(26005)(6506007)(186003)(53546011)(9686003)(38100700002)(122000001)(2906002)(316002)(54906003)(5660300002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?foDctE7NgbUdLMKDfC0SItDnSEkrQ6yKHJELED9WW/zZzjJ41W2AhfWz2Zfa?=
 =?us-ascii?Q?52hEKGwO7se9/eRRuFQakpvQ00kPKoUlwXswoHFgaITbb4hAwhzufNyLfE3D?=
 =?us-ascii?Q?Viq7eDs/ADEuioA09GkfusWRhFHkn3u2s5gBzrEawi/CuUQuwGivyYGj/9yh?=
 =?us-ascii?Q?+HoO++BANEiYy10nhAHDngkp3/l+9ZKFEDnyKpjeawb8Vu3XZa03o6s5O7sx?=
 =?us-ascii?Q?FKPNBQFn/jPx6adB0neg9vA/DXYiV00puaeLJRNr8OHL45uT3nT8bPZfNGj4?=
 =?us-ascii?Q?NeltE2tzvSpW57/dDNxV0QJeGeWOJT7zo4Qw86iHOUuAFt69u2zpjF31A3Hi?=
 =?us-ascii?Q?2d54a1kfDhm+aW+btRo4/roebtuex5mHDQtIS+UkAEwEVY8QqK4KnwnKwy9s?=
 =?us-ascii?Q?0sdO5P76c4/Apz7XbVEcvl8+bXY/HGfIPSHrPsW5U+5IaYduYfKtJBdUbw5X?=
 =?us-ascii?Q?UmNHn90sLwMv2Xv3Q7M6Y8fsLiYP9y07LQu/JqLpZJ7VxdVjQ7qv8qsfnAVj?=
 =?us-ascii?Q?7oep2A+PHAUCZ/j9HI/KOEfwenwA0l8SDk7UTTtav2B45GM1Qh0rnbikWcYG?=
 =?us-ascii?Q?Whhk2m68aWTUTTfRU3Nfqk5+tox3ylbbAFiNJkRCHqPzFilujLe7rZ7ttRIx?=
 =?us-ascii?Q?lJplXp6/rQiS2DO8zrEaPI8o28CMKP21kjCJMuwSz9Kc21pZ3oCYaQXozEI2?=
 =?us-ascii?Q?fHhXB4OZuj/fdny0XZanMk6POUtrnogD+edkRCsO+PC+BooIPXMeJwmgkkw1?=
 =?us-ascii?Q?iKlyi3pa8Sszq8jH0g90XhbNXCLN1VdltWd6J/I+oJg6IRlWtO5xc4x5gQ0E?=
 =?us-ascii?Q?unNinRB5csTxzDo+qkk82GT3Me/WBx13jr/PJ6Xg8MEKPctMw1zT9tFVPVhV?=
 =?us-ascii?Q?sxFLzznKsqVwLlu7PieLWFgaGj2RcBZCrr4CBzT5VajIewzczbgxwsGG4QKt?=
 =?us-ascii?Q?lsf0DMdrPNoj1uDYr+W50JtxoZqCqkgo9IFO5X1s8nL4A8B/XrhQpvP3g8M7?=
 =?us-ascii?Q?3tTXW/GUvmWT3lGE5k3ifzrtSXarDhFFYUTJVNx2lsDMdn6HehwXOWQHOeYB?=
 =?us-ascii?Q?KhX2wAjzrFDxXBUg6QVAdmjx2QKSLfpudbFxksunKdWScMCyjHSIeFeb0E3R?=
 =?us-ascii?Q?Yi82OJsdEHAsd4a6H9Vs+JjAo+7EVAzRBaDmRo8jwKrzOnKPi9QdZmMaeFNM?=
 =?us-ascii?Q?+rVprwDIGeR46R6f/IeJSre/16eAqrPEz+XRlbqf2KWcVipr/i2pBgQ0yL1U?=
 =?us-ascii?Q?XvhDateaD+non8SUq1An9zt1w00h4melFHvmZzHFrnXRdG9izrPKkiaVs12Q?=
 =?us-ascii?Q?RbTyKqUARiPPUPL8cNPK7qYlHjMcjmM4lj8zBT9my9lIUXBlvWART8rb1Kh5?=
 =?us-ascii?Q?VkZFlAV9aRBIJPmEtLLO3VHYr0aCwQYJ2ShSxm1XzTuYUU2UPFU/5APNRXTv?=
 =?us-ascii?Q?q9jowwRJDi1SLOUZhOz6Ddogd3wndljt/rC0GdBpuIjgfXw0ngcAWalrV5O3?=
 =?us-ascii?Q?U4ZBU79lbHUOAcIMY4LeUYoD1uFBWrWrk2rFCX7SSI4jk9spz54C6/s172ah?=
 =?us-ascii?Q?MPiSNipaT4GxGF21ZzuS+WTY5jVtG0hdIXQD3UD8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f387391d-4a68-4bf2-b947-08db186af439
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 02:33:04.5924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tud387MaPh3bR9h1y42QwD0F95dJ9a450W123eNWLQyJN4eQgYL5pNvkIX5SsUrT4kuKbukJUvCBslvw+hyepQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545
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
Cc: "Yao, Longlong" <Longlong.Yao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Zhang, Horatio" <Hongkun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Horatio Zhang <Hongkun.Zhang@amd.com>=20
Sent: Monday, February 27, 2023 10:14 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yao=
, Longlong <Longlong.Yao@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.com>; =
Yao, Longlong <Longlong.Yao@amd.com>
Subject: [PATCH] drm/amdgpu: fix ttm_bo calltrace warning in psp_hw_fini

The call trace occurs when the amdgpu is removed after the mode1 reset. Dur=
ing mode1 reset, from suspend to resume, there is no need to reinitialize t=
he ta firmware buffer which caused the bo pin_count increase redundantly.

[  489.885525] Call Trace:
[  489.885525]  <TASK>
[  489.885526]  amdttm_bo_put+0x34/0x50 [amdttm] [  489.885529]  amdgpu_bo_=
free_kernel+0xe8/0x130 [amdgpu] [  489.885620]  psp_free_shared_bufs+0xb7/0=
x150 [amdgpu] [  489.885720]  psp_hw_fini+0xce/0x170 [amdgpu] [  489.885815=
]  amdgpu_device_fini_hw+0x2ff/0x413 [amdgpu] [  489.885960]  ? blocking_no=
tifier_chain_unregister+0x56/0xb0
[  489.885962]  amdgpu_driver_unload_kms+0x51/0x60 [amdgpu] [  489.886049] =
 amdgpu_pci_remove+0x5a/0x140 [amdgpu] [  489.886132]  ? __pm_runtime_resum=
e+0x60/0x90 [  489.886134]  pci_device_remove+0x3e/0xb0 [  489.886135]  __d=
evice_release_driver+0x1ab/0x2a0
[  489.886137]  driver_detach+0xf3/0x140 [  489.886138]  bus_remove_driver+=
0x6c/0xf0 [  489.886140]  driver_unregister+0x31/0x60 [  489.886141]  pci_u=
nregister_driver+0x40/0x90 [  489.886142]  amdgpu_exit+0x15/0x451 [amdgpu]

Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
Signed-off-by: longlyao <Longlong.Yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 15e601f09648..28fe6d941054 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1683,7 +1683,7 @@ static int psp_hdcp_initialize(struct psp_context *ps=
p)
 	psp->hdcp_context.context.mem_context.shared_mem_size =3D PSP_HDCP_SHARED=
_MEM_SIZE;
 	psp->hdcp_context.context.ta_load_type =3D GFX_CMD_ID_LOAD_TA;
=20
-	if (!psp->hdcp_context.context.initialized) {
+	if (!psp->hdcp_context.context.mem_context.shared_buf) {
 		ret =3D psp_ta_init_shared_buf(psp, &psp->hdcp_context.context.mem_conte=
xt);
 		if (ret)
 			return ret;
@@ -1750,7 +1750,7 @@ static int psp_dtm_initialize(struct psp_context *psp=
)
 	psp->dtm_context.context.mem_context.shared_mem_size =3D PSP_DTM_SHARED_M=
EM_SIZE;
 	psp->dtm_context.context.ta_load_type =3D GFX_CMD_ID_LOAD_TA;
=20
-	if (!psp->dtm_context.context.initialized) {
+	if (!psp->dtm_context.context.mem_context.shared_buf) {
 		ret =3D psp_ta_init_shared_buf(psp, &psp->dtm_context.context.mem_contex=
t);
 		if (ret)
 			return ret;
@@ -1818,7 +1818,7 @@ static int psp_rap_initialize(struct psp_context *psp=
)
 	psp->rap_context.context.mem_context.shared_mem_size =3D PSP_RAP_SHARED_M=
EM_SIZE;
 	psp->rap_context.context.ta_load_type =3D GFX_CMD_ID_LOAD_TA;
=20
-	if (!psp->rap_context.context.initialized) {
+	if (!psp->rap_context.context.mem_context.shared_buf) {
 		ret =3D psp_ta_init_shared_buf(psp, &psp->rap_context.context.mem_contex=
t);
 		if (ret)
 			return ret;
--
2.34.1

