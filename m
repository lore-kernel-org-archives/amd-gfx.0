Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78AEC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 17:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A26360524
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 17:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A26360524
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45AEE6E1B4;
	Thu, 29 Jul 2021 17:37:24 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 617A26E1B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 17:37:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeCgq+K0lCjzuOQoiBxitvbL7eg2EeJIbT+pLh8ujnJJDr6arMDYFYrtA2dhKJJa4DfWKM9sXqK5ml+a0uiTmTkCDCjlCqg8Bh++3WkEbUMud7/nVZZ66zx7B8ef8WrsbgOWPSOnxRxTKOLQtviAY6Fo8W5ZqpnmwBPdouLAl2ufGc3ViWNA9Z4E/Tqf6LYFR6v0U+e+E8LXzvo5wsldHn/8kagIGOJyNqbPI8/rAyqv9yU8UPjGYAiF1FLGUBF/JMsB1cNn2/W3vVAqif4Qj3srdHAC96Iyig2kSYbwqFdFdSMwLZOEmD5WOl81AZuizgkp2baebgApSs4xGqMGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Roc7UfAJbxSZPHt+PgnfD8rKZ2AkczZ7qbT09uK0Idc=;
 b=ZC68hoiPR8okBg5fIg/misWDBiLRksqeE9apHXAsanxSzyVk6WvX2RuwKdywDEC1n04aEk1t5e0HpN0ePxieUa/8TgT6nYU8PeP6zNjdDXxE8o3TZxH1Ytc0VQw4hf/YkFCqONpMo7MtJw7hvTuAwk7Wyc+fVwEictQzzdpi204TmPf3lXeWOkUOL06Ao4jzf9gGSCmXR6lDKicEGEmPv3goAYy42xusHTJwPX+ed1Zq5BpQOkelJ0dhLJeGFEyXbxwxc6EzJv4UpEcTxUi68WbMOw0KmSO8e9NJ219rSWLJOjg4HFSNm7QqFR+Hvq3DWwY+3AK+dJdpMPU8eOI17g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Roc7UfAJbxSZPHt+PgnfD8rKZ2AkczZ7qbT09uK0Idc=;
 b=2OWv6eIfCnWoSeGcnYrbbXNtDaZ7+37/F9LNuSAP6WUCpIUFcEPp3RXQPEI5a9WfYNKQyu4XJF4EFubMd4j1UAR5cDWxiTcfbYm8nUxrNslnPMfuOHJPXCy+fhIJpBlHsM5zUN4LYJcfDNAD7be8pb+YIY650ogWJHbjx64nlkc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL0PR12MB5523.namprd12.prod.outlook.com (2603:10b6:208:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 29 Jul
 2021 17:37:20 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4373.022; Thu, 29 Jul 2021
 17:37:20 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v4] drm/amdgpu: fix the doorbell missing when in CGPG
 issue for renoir.
Thread-Topic: [PATCH v4] drm/amdgpu: fix the doorbell missing when in CGPG
 issue for renoir.
Thread-Index: AQHXhF6fNYcsai2soUyK4q4SNi2ZAKtaN+vv
Date: Thu, 29 Jul 2021 17:37:20 +0000
Message-ID: <BL1PR12MB5144E1A5AC03BAE5E932CEB6F7EB9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210729094627.2595196-1-yifan1.zhang@amd.com>
In-Reply-To: <20210729094627.2595196-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-29T17:37:19.670Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77ecad46-e5c8-493a-e5e5-08d952b7847a
x-ms-traffictypediagnostic: BL0PR12MB5523:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB5523C7526C9E7393B9243F42F7EB9@BL0PR12MB5523.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EEpkvTdwYDaLERtdongZlmMpoRakf+pXS0SOlUwg3QUgsDmaJc0ewaGfVvdH099xxDspl4lC/cBmswS4H9wg4akAaz5HGCaeTq/MDojvF2V8kovgovrDOF8TdBR0Lb5HUgybcZVHNqcu7O1cXMC44neWdNQZiWGxy6qaUSTPjoIqFCAwF7hjTwzVLv0bBs/LXh0MUbwU1QG/K2rBSNOEbVB5jnd+c4D0TUyXXlF49kOzUQDujfsxmBwL7gjta9WtPT/Zezyb0WUjKR0Kyd8QNnruQ6J+jzJjwPsY89+RtH32kiWpv/bMjHgRgQ/DHfGPza0zG+mE6OSsCaEF+GDZiR4agvkLKNpttRWCY2kTYhPaWhyZEOt8c2XtAeWtpvJq8kA8ZgCRtJmIm8T+kk47F+yzSbOCgrTLSWG70sWP37JSxmyQixJHxcVPZBHX3709ybybzk9q4ReOvFz4lqjuVh2ISLvOunN69SVp5l/eguhst7/74yM+/5Hj9gGiEA2YH9F5bsjaO23yim8TNgOWVgQtxOsc/t+LaEcKlG1/HvZCi5jBLMeFqN6Ft80VSuFXccpvkmOqdSKUjvdDg1BnV5lVnYZ4W2dhkTRVvNo5LetO7WsllZEShKzlZX2P0RMY1QFZ8AVvQXTpjwKLKMXvDISVAG28VjJarIquby6K1VBVEem5zAVzEA5vmUEBPX1tYU2WPcNfNCnZvE25oGInXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(2906002)(38100700002)(166002)(122000001)(76116006)(66556008)(19627405001)(66446008)(64756008)(45080400002)(66476007)(71200400001)(33656002)(55016002)(52536014)(5660300002)(9686003)(66946007)(6506007)(83380400001)(53546011)(966005)(8676002)(8936002)(316002)(186003)(86362001)(26005)(110136005)(7696005)(38070700005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X3Mr84E33j6C5DambqwYhtDMw+0GEyJBESo4wFLVnreg1d9X1os3W830bxWb?=
 =?us-ascii?Q?RnGc5CRMkyAcaL3TtQhfQatnQZlhdvRldtx/CVaxGtbEFymfr728pp5lrFIr?=
 =?us-ascii?Q?vnB18Dx9MaLW33WU2bqUvdl0Teb+fLJ7QTm7VhbwJT2VoWro5t1g+nHffQAW?=
 =?us-ascii?Q?nsbdFebCc0ZADuXoz9PDcYPeyxOWX/JgTQoGASbkRu27j4QnaT3mMMxoGKXS?=
 =?us-ascii?Q?blbm8GJlq757EfImUO9+hHevnmuPyaSOxspNPR2OWoAimAuWHMVrQN5Eu7xh?=
 =?us-ascii?Q?UyUc7v8gZNkixy2HWG1Cw52jRw5IulK72AJ/3Eu/8vXFiyCrLkWZv0XCHthL?=
 =?us-ascii?Q?3UW+8yF+lkqunp5Wqq5ATwlAngDmnRVJ1UMUl4b9pAOJnkLRhjTnuNoMeh/Y?=
 =?us-ascii?Q?53QV0xkuNvH18G/NF91UhFZGGCWST++s1sFBtKY8nCrP2+JpKwHalUbkPKWZ?=
 =?us-ascii?Q?/sa1EMqnoNkUFToxfyvMR8rag6CI49VaGPRvnYAxKMy7q1/MSS+PAQMZsvDo?=
 =?us-ascii?Q?qLggYokaVxdhRs94FWCAAnO1vRyDynfUp4uPl4E9K6qObyUSYp08RoFsreYC?=
 =?us-ascii?Q?+SgU30ZP+2HBIqi/MWkIw7ms9iG21q3x5T+0Oim5W86ALrx3q25ea3oZfJcJ?=
 =?us-ascii?Q?ufCoSrsu8PCGCDyQ7irW7iZa8qmZsIgnMqcJRe3A1OkdC2XbPH64h41zEWpx?=
 =?us-ascii?Q?Ea3yXF8DCTNRNj+U00nTl7pElcv0INRYkUzg1vTreFwZ7jX04Muu+Uet0Ymd?=
 =?us-ascii?Q?aJ7JVVrVDkpkyfxi/NlPZsIhRXH0Z/LsgqV6orLKVcZSEiTAFwx3M8kdi2gD?=
 =?us-ascii?Q?jJZkyRkBk5tp8H6fhAU3nDLRQXRn3IqYTbG0ZD6hxeV76P1EVcEFQqb+zucH?=
 =?us-ascii?Q?Hx7Kekv9NVfZLtNRZBUR0MOMPV5c/Ew96vE9aTBPRBw0zxEbk6YE5ygz06VY?=
 =?us-ascii?Q?DmNxZceRHG/m/XYncraQa8EevAehEq3o0hJ4EKA9k+1hGvGgsYZutczaofme?=
 =?us-ascii?Q?lDnT8bn/85WsxvjiJxLLCn0FjgPZl3fgsLc8tfi4HZ9EhbI7auDuJ/J6JNBz?=
 =?us-ascii?Q?xETNX30vDS6monftOWU1WrNamkNQmZrC2t3tfeFyAKFJimwfWfsT3R+AUO/x?=
 =?us-ascii?Q?BM7XydGgMM7HmW93Dkj8qxa+I1inoHLTKsyUI9a/ll73+hPSWUwILuPjZoev?=
 =?us-ascii?Q?/NYKiUQz1cV949kr5O2HgDx66LzTFtJxcTYVt+qeP5pbf4YlH74YAClrx42r?=
 =?us-ascii?Q?sCV12l/6ciO26QJ8dIsJMAWdksAKApSG7tiCzQq3Y7w9ZuQ5chShtedxGtaW?=
 =?us-ascii?Q?w7bnoQ3h30q4Ycj69BGcsbSI?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ecad46-e5c8-493a-e5e5-08d952b7847a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 17:37:20.2266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzrXqZPSaG0PNYwqBF706MiFR8veK+Qo0ro5WXY3KiFlVi+uiAdy6+qKkTaoUX4dTEtBFUyml/S6+ql+gzRBCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5523
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
Content-Type: multipart/mixed; boundary="===============1846811987=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1846811987==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB5144E1A5AC03BAE5E932CEB6F7EB9BL1PR12MB5144namp_"

--_000_BL1PR12MB5144E1A5AC03BAE5E932CEB6F7EB9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yifan Zh=
ang <yifan1.zhang@amd.com>
Sent: Thursday, July 29, 2021 5:46 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH v4] drm/amdgpu: fix the doorbell missing when in CGPG issue=
 for renoir.

If GC has entered CGPG, ringing doorbell > first page doesn't wakeup GC.
Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround this issue.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 03acc777adf7..ab79ca770dcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1295,6 +1295,16 @@ static bool is_raven_kicker(struct amdgpu_device *ad=
ev)
                 return false;
 }

+static bool check_if_enlarge_doorbell_range(struct amdgpu_device *adev)
+{
+       if ((adev->asic_type =3D=3D CHIP_RENOIR) &&
+           (adev->gfx.me_fw_version >=3D 0x000000a5) &&
+           (adev->gfx.me_feature_version >=3D 52))
+               return true;
+       else
+               return false;
+}
+
 static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 {
         if (gfx_v9_0_should_disable_gfxoff(adev->pdev))
@@ -3675,7 +3685,16 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_=
ring *ring)
         if (ring->use_doorbell) {
                 WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
                                         (adev->doorbell_index.kiq * 2) << =
2);
-               WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
+               /* If GC has entered CGPG, ringing doorbell > first page
+                * doesn't wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER t=
o
+                * workaround this issue. And this change has to align with=
 firmware
+                * update.
+                */
+               if (check_if_enlarge_doorbell_range(adev))
+                       WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
+                                       (adev->doorbell.size - 4));
+               else
+                       WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
                                         (adev->doorbell_index.userqueue_en=
d * 2) << 2);
         }

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Cc3367e51b7f7457dd02d08d95275c11f%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637631487971875543%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DSlwGsspm4%2BGSekdb%2F9Tl1rvDhaH%2BJHBDv5%2BgoazxabY%3D&amp;reserved=3D0

--_000_BL1PR12MB5144E1A5AC03BAE5E932CEB6F7EB9BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yifan Zhang &lt;yifan1.zhang@=
amd.com&gt;<br>
<b>Sent:</b> Thursday, July 29, 2021 5:46 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH v4] drm/amdgpu: fix the doorbell missing when in CGP=
G issue for renoir.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">If GC has entered CGPG, ringing doorbell &gt; firs=
t page doesn't wakeup GC.<br>
Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround this issue.<br>
<br>
Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 21 ++++++++++++++++++++-<br>
&nbsp;1 file changed, 20 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 03acc777adf7..ab79ca770dcd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -1295,6 +1295,16 @@ static bool is_raven_kicker(struct amdgpu_device *ad=
ev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;}<br>
&nbsp;<br>
+static bool check_if_enlarge_doorbell_range(struct amdgpu_device *adev)<br=
>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type =3D=3D CHIP_R=
ENOIR) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gfx=
.me_fw_version &gt;=3D 0x000000a5) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gfx=
.me_feature_version &gt;=3D 52))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+}<br>
+<br>
&nbsp;static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)=
<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gfx_v9_0_should_disabl=
e_gfxoff(adev-&gt;pdev))<br>
@@ -3675,7 +3685,16 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_=
ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;use_doorbell)=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (adev-&gt;doorbell_index.kiq * 2) &lt;&lt; 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* If GC has entered CGPG, ringing doorbell &gt; first page<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * doesn't wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER t=
o<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * workaround this issue. And this change has to align with=
 firmware<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * update.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (check_if_enlarge_doorbell_range(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC,=
 0, mmCP_MEC_DOORBELL_RANGE_UPPER,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (adev-&gt;doorbell.size - 4));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC,=
 0, mmCP_MEC_DOORBELL_RANGE_UPPER,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (adev-&gt;doorbell_index.userqueue_end * 2) &lt;&lt; 2);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Cc3367e51b7f7457dd02d08d95275c11f%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637631487971875543%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DSlwGsspm4%2BGSekdb%2F9Tl1rvDhaH%2BJHBDv5%2BgoazxabY%=
3D&amp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?ur=
l=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;=
amp;data=3D04%7C01%7Calexander.deucher%40amd.com%7Cc3367e51b7f7457dd02d08d9=
5275c11f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637631487971875543%7C=
Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL=
CJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DSlwGsspm4%2BGSekdb%2F9Tl1rvDhaH%2BJHBD=
v5%2BgoazxabY%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144E1A5AC03BAE5E932CEB6F7EB9BL1PR12MB5144namp_--

--===============1846811987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1846811987==--
