Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A142CC27C5F
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 17:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CBB810ECC8;
	Fri,  7 Jun 2024 17:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r6rO4GV4";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00F5A10ECC8
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 17:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je1tgVdV7/3xJuibNfFaVpvBoOkLlUDn1en37AxTPdAgKbPPPGIal9LDP11dbnN5/1yhyQGVeEsxESmoC5oVPAqO986S/uLdJUB9t/B9/Xs8K+OWQTOpMiuiCz9coGWJ67iXw9/h0SNuBTjBnnJdOHvSnplZV6dYN6ZnKuiUDHnzW0g4Arzu09N49ZDlwd2z0Gz/DUtO3ddOh/QkJeEkkafP7oPetrpahTYvy+f55Pw/lyMteoCNq1docxsCSHTB4TRaz5XxLV6UT31Jtz5CFCNINKYzhZOv1qpOHHsicu5RKjnJ2lk79/JUYjWm9IhqN7nfVWT7T42FAe7SeEVo+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXv7SRxVwgcZEjlVeoxP7U9iYvCpPaVA6q/7Kx206VM=;
 b=JBn/9PI5DWop4iTIK7pVJ57mIPJ3ibSmy31IZSq3EXT3DwdageArQYBRd2Nz3gEuiKaRoUaXDObZSIcJYdXvSm0QQokpITZ1gFSzyiVwTy9fmOV7Ym7w8HCBhYDh7u+jjNj4E527HYDhmpLA4Sx9aDgu27wuR60raKwrHRas2YnpsqWsSW92M+siCOPclWF9SeYCaiBBr+pX9OxD8v4Qu4evmbVn1gyRYFBfvNiFtTHe/qmq8w2UfNRSjChQRxT5qTdgKRK3Xols2tGqZxmxTxvIigDgB+5+hygSd9vqc1NIb71l+0pGRsNr+BRtMBfs8q39b39n6XlxZuTBt4SGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXv7SRxVwgcZEjlVeoxP7U9iYvCpPaVA6q/7Kx206VM=;
 b=r6rO4GV48vB6jTgRGctnWq49Dlnvy6Uy8XnU1nqZwZUlQxNkHBGDI6JIgG+HacIiSG+vS5kRpLiCiSWVvYH8ilYbA2qy3py6xlfNElReagdUxThF5aZAnN9GhEmT9eey/hy8wLo/Xoie5pChXNT8areS17zqDAlnlM02LO8u8MA=
Received: from CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Fri, 7 Jun
 2024 17:35:50 +0000
Received: from CY8PR12MB7415.namprd12.prod.outlook.com
 ([fe80::3f74:9380:7a3a:6929]) by CY8PR12MB7415.namprd12.prod.outlook.com
 ([fe80::3f74:9380:7a3a:6929%3]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 17:35:50 +0000
From: "Zhang, George" <George.Zhang@amd.com>
To: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Li, Sun peng
 (Leo)" <Sunpeng.Li@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Choi, Nicholas"
 <Nicholas.Choi@amd.com>, "alex.deucher@amd.com" <alex.deucher@amd.com>
Subject: RE: [PATCH 1/2] Revert "drm/amd/display: Add null check for 'afb' in
 amdgpu_dm_update_cursor"
Thread-Topic: [PATCH 1/2] Revert "drm/amd/display: Add null check for 'afb' in
 amdgpu_dm_update_cursor"
Thread-Index: AQHauPiKYPEj49VG5E6gprFD5RY8grG8kChA
Date: Fri, 7 Jun 2024 17:35:50 +0000
Message-ID: <CY8PR12MB7415A5C2B4CBD8194A1FF49594FB2@CY8PR12MB7415.namprd12.prod.outlook.com>
References: <20240607163359.18299-1-ivlipski@amd.com>
In-Reply-To: <20240607163359.18299-1-ivlipski@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b37cc8ce-083e-4f0f-a99a-3caeb605db43;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-07T17:35:11Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7415:EE_|CY8PR12MB7195:EE_
x-ms-office365-filtering-correlation-id: 3f1bc673-e1ba-4df5-4627-08dc87184616
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?m+nPgwSRB75xDGs6J4+f8vf93E+gE8XwbuIiAm5yiTIZ6c/4oLY2EGDzwbGt?=
 =?us-ascii?Q?yL9HYI61WwXVvYrl4XdE3PROsnE/rL8I7gJNRFJCNJ+Zc8tndHRsCywl96+C?=
 =?us-ascii?Q?e4+3EsPjtmaxYfp2uloXVv0QkeeRZ87cRO3oNT0TYmXyZDNRyPHNiZw15hH1?=
 =?us-ascii?Q?AjdG1DVLwcJM8C16I3Wij2VCn+O+/U3GZ+/aAgl9ikzkzcWkkZqjCcmbaRO5?=
 =?us-ascii?Q?uoOmHn4M2yDfPyc/RnJKboR8yxyHex+wvOb9rfTZsZNbM67h9Ldj1sEyUN60?=
 =?us-ascii?Q?sIdobQb1klED5YX2BmHtqKEYmsvuFvhYulc7/0o4XqKdtWo/geIovHzcMLNZ?=
 =?us-ascii?Q?tZFh1vGFs1YNhsOnzoF8aLgCDma1+YXd2TXXf51wAPMaKhOcwgnm9oCqiziP?=
 =?us-ascii?Q?1pSlR2A41wBacu/1i1/ZuEc/BjUzv24mQxmH6zsI6y8GopcPhobqaxJU6mOB?=
 =?us-ascii?Q?HproGN8w0IT74NRUy1P4T5JxtI9PNLt7rRF4Gz2xV1ZV8a3eVBbrmZ+c0Fc+?=
 =?us-ascii?Q?PnvEFscDWV0hUKY850dgt62bdCPRSVYtc+qrPn5zUXRl33qbWJJ6rR4tOILZ?=
 =?us-ascii?Q?38/s+q5ms0d5RM8BXTS6YKcX4pAknEaUJjzqoL8vjFIjFqkan8XfzR6/apQd?=
 =?us-ascii?Q?DlDukg3XVzRtuOXkGmbxmh2CHjIXSCoZMBfVR6OWfmrFiXqsoKtmtu5M3ytP?=
 =?us-ascii?Q?Aind1eOyVGbefVoN8xqPQ2HYV1JPNZW0Rd8UPUiUrtZY+61fgmKnMcj2tw0M?=
 =?us-ascii?Q?PQ5b1xoJ64Q71rC6JWXA6mqTeV7h8L1K0MplJBNMhCJveJsJKKD8Z6hRxgcJ?=
 =?us-ascii?Q?3sbhyGByKl4iOvbm65lxLT6+b7HbwI6WN78Fhq9slZ5qlLunpKH+LhFYDYgK?=
 =?us-ascii?Q?H4xG5RpHPIF+JDcK8MDcZvz3lUrINqP3bKkke1a/LmiW35CEDPHqKHwRcJ6G?=
 =?us-ascii?Q?3fsN7q12Zgb/Quo/OZCGPfRpFVsruEZW15nCb0qxw/wVN1KWNvixQl6kU0Am?=
 =?us-ascii?Q?PD8fVcQM+WoijU1q02fbCyCuY7erC7XQ4oUvpnoEdH+ayXxUk5lQ8vNAuYMP?=
 =?us-ascii?Q?p0fSbJ6RXIIbtSeqStMQgVZS9TeLEK0px/2CmgJNeXb+NkYBOZWBFruEckzB?=
 =?us-ascii?Q?I85c6CMaotQMixwMKxQjwCzErKI/Aq0x13EDD6Z/3x3mT/sUZ0PaIG3VMym9?=
 =?us-ascii?Q?0gxrvtw2L85xICwoTYlZ0Xu+FrJwGFyHdxLfWwTreQCFjDV/m3ZMESFUrxja?=
 =?us-ascii?Q?4KhNx+4Aw3mXJY+odinrRiIl4JumTqatJiu1ginDrBIvT3naNG/iUZWDw48/?=
 =?us-ascii?Q?YkmaM/R/tMsg0Pd6DtwLFLAYMvCWZ1Ztrlv7MWhC0+ZNozcVrDxl8cUY8Vz9?=
 =?us-ascii?Q?om9C088=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7415.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6SIsXz3c7uh7izb6hd/9wTMe+A7C4WQsIWYJiP2D5Kt9FRiIdzHEEizOJAWW?=
 =?us-ascii?Q?BeP21yabNt2tpi5F/82rAt5U+IGYJlvHGu5KxH4HE2K3mKCVCGc9qhtUdgbG?=
 =?us-ascii?Q?1Cak/R72rIAj93cqXNh/AzsKCO4NuddGfU5Vurp+qUcL6Hl27yx7RO7thEvs?=
 =?us-ascii?Q?RwrzE9bt98dTt6KJIW1X9o4P3bpreYJmG5/Z06QUK/43mt8hRWI7HjtYRzTP?=
 =?us-ascii?Q?rtxLqhEduB+6ciGqmwi4/osuFVmiQS9vxeDUw4dmTA3eXjvCngHta0c1Yvat?=
 =?us-ascii?Q?BkV+voIatt1hbqujcW4ZUm8Iqb8KHk86tEtUeEOgtdm9mmgNoa1nIL/jqy20?=
 =?us-ascii?Q?meOi5rj3wurkVXcu34Ucg/yMkGHolFV4a+yPeW7BkKplwLIxui4NJmoRl2fI?=
 =?us-ascii?Q?RJRpscUKSqYPZ8bi1Hv/w11EnoQQZ4al8rXktTYd2XzQboOOSLbaeyNGAwmn?=
 =?us-ascii?Q?nmfLT51G0vgTgDVN93UdG5bAOkiQNaoqDzpB6Ln6becFzWDOxRqV2lQ3A9m5?=
 =?us-ascii?Q?ASEA1w/rW08MI2qUmlwZfTxWpa0hnOduWvP4lonTH3yi/pnEIBMrzaUk4pDw?=
 =?us-ascii?Q?NptzuUntu8rmzZvien45NeccT8wEh6FbxyshgcbnxPbhenln1eIFC4Bima4f?=
 =?us-ascii?Q?sMawyAPfg2NOIj4SdoN7zm/CGrtZuOmulXR7gXMxwFZbvQHKPQjZmKTzhhWt?=
 =?us-ascii?Q?RV5uSss1TE4huqfWItXjh1E6ul2j9/RcGzB3EUB2D6awnsN2qjFPBIju0GZy?=
 =?us-ascii?Q?js7Tqx6yY011pmDZKLj9KKpmcfg22X7U0clTTaZz8ucLRHMOeCc1OE3UNxvB?=
 =?us-ascii?Q?08mnhYydZXy0VUfj8/3oCbBtXmJn56VxdAoi81zHaRBxA6KxBlKp5ZOyEDf0?=
 =?us-ascii?Q?FTTUNbVo2PCSJ3/QA3kkjx/w6MUa4ud7LY5gH71DGyTrpRy7zKa78QfmsGJD?=
 =?us-ascii?Q?BXxgDw8Jvbt7tW9a34QH9aDWZdq6GgumUxfVs86hsRaUETOeGD75CeykgtoB?=
 =?us-ascii?Q?iEudmRM7nZxyl0mY8tGwhKzw20ZiM0DOAdyN90MqB6Wen0WDIuFmXAK1Nvz7?=
 =?us-ascii?Q?1IBuRO8JJikQfrNsZ4QWt4Xln46AHMy44jFGeSVLls/ythwkkcPOlSAygaWO?=
 =?us-ascii?Q?3idWx+Z59dOr4/6FBHt6CD7wZ59Ke8Eo2DAyxdiLdtLYswG0/9X2YbFVXi3V?=
 =?us-ascii?Q?oW5wbKCtkO016Zsa1gNbE4eLs9GEKbILvNhfUXOLWGlRGrWgKTdRs476zQXt?=
 =?us-ascii?Q?5lMwQpS1EbOhjWZgmbRlUjdfzcByWHZxmwmHMi5/ueoe8UfL7jLnHG+cf+6+?=
 =?us-ascii?Q?tDcLLEVEcioNdBozAnTTflI1hoKHo7BHZaCuFy+X27lmKnU6tTAIpm+l29pQ?=
 =?us-ascii?Q?aTSgA36bQn2RzU0C8SH6NcQ+bxk/g0NCrv9/LbElngwI//f9J3aFSycbD4cp?=
 =?us-ascii?Q?Q6y2gQ37IhaKqgcngjKfG92bvMXrKN/NHhcUMm+FumxSrbTPUoZvnEkh8eNL?=
 =?us-ascii?Q?u/A6Wkp0OR02Lzm6tvfUmmlrMMkC6jbqgDKYdt0bXUkisazMT5RFDu3e1izR?=
 =?us-ascii?Q?BEDKx8c1bPcEnIwPr+c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7415.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1bc673-e1ba-4df5-4627-08dc87184616
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 17:35:50.4124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njz5LgC9Hs5kgzFdLukuQH9+qp+kN+EGNWIVrOJd6s5hfeSNqayRQn/nVVPJelzvAfOmk/HAoMrmDEAtKp+C3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

Tested-by: George Zhang <George.zhang@amd.com>

Thanks,
George

-----Original Message-----
From: LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
Sent: Friday, June 7, 2024 12:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Li, Sun peng (Leo=
) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Siqueira,=
 Rodrigo <Rodrigo.Siqueira@amd.com>; Choi, Nicholas <Nicholas.Choi@amd.com>=
; Zhang, George <George.Zhang@amd.com>; alex.deucher@amd.com; LIPSKI, IVAN =
<IVAN.LIPSKI@amd.com>
Subject: [PATCH 1/2] Revert "drm/amd/display: Add null check for 'afb' in a=
mdgpu_dm_update_cursor"

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
This commit introduced a regression with kms_plane_cursor IGT
tests, causing AMD Asics to fail these tests.

This reverts commit 14bcf29b706f8ef423b86c9b783055b5b0c2cd35.

Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 27acbe3ff57b..448932ac06fb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8637,22 +8637,14 @@ static void amdgpu_dm_update_cursor(struct drm_plan=
e *plane,
 {
        struct amdgpu_device *adev =3D drm_to_adev(plane->dev);
        struct amdgpu_framebuffer *afb =3D to_amdgpu_framebuffer(plane->sta=
te->fb);
-       struct drm_crtc *crtc;
-       struct dm_crtc_state *crtc_state;
-       struct amdgpu_crtc *amdgpu_crtc;
-       u64 address;
+       struct drm_crtc *crtc =3D afb ? plane->state->crtc : old_plane_stat=
e->crtc;
+       struct dm_crtc_state *crtc_state =3D crtc ? to_dm_crtc_state(crtc->=
state) : NULL;
+       struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
+       uint64_t address =3D afb ? afb->address : 0;
        struct dc_cursor_position position =3D {0};
        struct dc_cursor_attributes attributes;
        int ret;

-       if (!afb)
-               return;
-
-       crtc =3D plane->state->crtc ? plane->state->crtc : old_plane_state-=
>crtc;
-       crtc_state =3D crtc ? to_dm_crtc_state(crtc->state) : NULL;
-       amdgpu_crtc =3D to_amdgpu_crtc(crtc);
-       address =3D afb->address;
-
        if (!plane->state->fb && !old_plane_state->fb)
                return;

--
2.34.1

