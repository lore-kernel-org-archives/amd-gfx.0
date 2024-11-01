Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56974E6F06C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 16:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E472410E2F9;
	Fri,  1 Nov 2024 16:27:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1SHgJjc2";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3484810E2F9
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 16:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bN5UZoAKfsEB1v9zkiwt3UX6yb+xqVC00ppFaTMjSC8ZpfTcdRz5mUfExgCd39Wikeb9f3xIRkFR0M0+eF+J3fykOMS1fUuNTDGXeiXSnO/bBN9UbjHXHtZftfoPXNaF+jY6gA+TunR5X26fTfI2Egyekbd4cJTeYFEc5X77URocf9j6fnRETX68EqgVMLx+slkyBM54BjKvIr8mH72Yw7cuQuA6qDCxsdG+P6/7NS2xF6enHDcadDSmc0nWztbBmC8YPvZwuGP2gWEkbNLV3NpS3RhK0se+qwEw4pQYnEIGpIxwuy2hM6B9lkx3owTXplmyMELraGK4vu6uNsy94Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIPslmXEtnMocSR5cSlb+KF98aSKdQQu9mS6dPJwiU4=;
 b=JyaU82BK9ohiW+cj7cx1Rv+qrzVrfNifztfaPLhLEgHupnTdALBvzJUnNQHkhdpKxPz45x53VlMDc9dJhB0f2C4sFKCD7VFt5+tP6kO/Wu/fONlkfBMMAiHBphwBVk+5yIuEb2b7iV3tplh3jT/E+03JWVJSPh/BmUJbSkms1vmcQEtQaR48uiE+cKycoPKmvfkBiFFOmfyOLtM153BuFbiZGoCDcyvi4cJon4TiNedx5h5rC63Y2dRbw1adwmBjdtL+qKKibERsTwu2utV+Ka2WfJRLrUrYBMMXt/nFVugyn1iTELvt8jZIt8Ude6ZDvJtNgEgRsyul5DAHyP+whQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIPslmXEtnMocSR5cSlb+KF98aSKdQQu9mS6dPJwiU4=;
 b=1SHgJjc2yHlsypaUZim8dc9n5Au5+aNZOXqjkG5z/C7k3rkeRUwE0zYkkoDsMJdWgvvLwZc5f0s77DAqbwDJHaL9XhTPXjOzklRsvdDvASi9P3DSpkpCmdGsDvCALMrQoUVrUam5Nc5/G2E1l5oxXoam+GtbqE4Lpi5hjMMHJvA=
Received: from CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Fri, 1 Nov 2024 16:27:08 +0000
Received: from CYYPR12MB8962.namprd12.prod.outlook.com
 ([fe80::1526:ce9:82c4:5ecb]) by CYYPR12MB8962.namprd12.prod.outlook.com
 ([fe80::1526:ce9:82c4:5ecb%2]) with mapi id 15.20.8114.028; Fri, 1 Nov 2024
 16:27:05 +0000
From: "Varone, Dillon" <Dillon.Varone@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Subject: RE: [PATCH] drm/amd/display: Add a missing DCN401 reg definition
Thread-Topic: [PATCH] drm/amd/display: Add a missing DCN401 reg definition
Thread-Index: AQHbLHp8H6gaOSGvwkyMHvSqF5SRgbKinLIA
Date: Fri, 1 Nov 2024 16:27:05 +0000
Message-ID: <CYYPR12MB89628AAE6A0C859145DF8F98FE562@CYYPR12MB8962.namprd12.prod.outlook.com>
References: <20241101162404.47741-1-aurabindo.pillai@amd.com>
In-Reply-To: <20241101162404.47741-1-aurabindo.pillai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=d7ed073d-540c-4990-82cc-9638690185e6;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-01T16:26:52Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8962:EE_|DM4PR12MB6010:EE_
x-ms-office365-filtering-correlation-id: e7af0ded-238c-4974-5212-08dcfa920640
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GO7UNBIjpNSnZE26rvPpzFk4bRX3OWpCwP486bi/mrr/XytgEArCaw5wUUl9?=
 =?us-ascii?Q?7/Tdd6QMJBNfWH3mju5bqreqUOLy5xR5DLKQ0z67YZrFbbcRyS1elZBch+iM?=
 =?us-ascii?Q?bZzlEm6a96SO7t9JgYOgmWnv9vKxHT3b6hxbRiagcODpBtRNfZ+fcOGI1raO?=
 =?us-ascii?Q?RbE4ngufrocBPm6sjZurrK6v/CJp7XnV05liNomG/Neh/kGKDGzJwSZYSzXY?=
 =?us-ascii?Q?hHrY0TOKfbE85GrF2cnokOmCUf2k9ToAYx4JUtfsYweJLgi1yTNbYaV4AYa4?=
 =?us-ascii?Q?djGMFrFWjjOps3dlhf/qXgzYpFpCrcV/e3QwWblNHEnuXbD6GDKXSjYNlbwO?=
 =?us-ascii?Q?PZfxS0yX7l9EXhReIBbAS9TAzkT+ASPJV1XwT27Jkbu9PY3iAt1x2cMc2XI8?=
 =?us-ascii?Q?5tUGXPfw9cukk3OAY9GT6ZjoINe9YRrAx1hw8liL3gxMiT9Meh02UfLuRs0R?=
 =?us-ascii?Q?SqI+LTZTCI6ninD0+xPTcTJ73y9Gje+NP6zyykjx/4k1KIFjuXDivcbbAisB?=
 =?us-ascii?Q?2T2wwR/IYuPyIdZBl18yUmzLdD7MJ2gjGbWco/IhGdHYJXHTGimlL20jfY6J?=
 =?us-ascii?Q?snB1RDmJ647aZhtMv8DohCX/d7fSV1Z1lSOGZH66L+zfLeyaO1XpWZ63dV1f?=
 =?us-ascii?Q?DPqgocK2IDVpTynDB02ZGLT+qdPN/vSjBMvxtOB9zjztWCIX5XDuGOM9rm3d?=
 =?us-ascii?Q?aZL6aWHluhBBLwVGSkCyTXyt+4plJUMAdR9BGkZ+u97vRwEmAMZdL4CA75Sf?=
 =?us-ascii?Q?A/Oy+9iz5rCoFq0fLmvRGVf1c+oF8QYVrXpQtZ2Mt20SQa0McRrjhwNZ7ohN?=
 =?us-ascii?Q?vTlSU/zrFYXosgexgBdhqd+22UT5pmnzOq31s+eLIVJaNQgISyfE4DqtMJYQ?=
 =?us-ascii?Q?uX1A2UR2CHkt5qETPY5PhMaWsjezZGoturJBOSLI73Dd5/1gBEKrV6L0Wlbx?=
 =?us-ascii?Q?Mq5nkwDl0sJSWlstO/QZ7lJHgWqYp07y8ehS7MLpjkIkdlMMjFGzJb2MxCqi?=
 =?us-ascii?Q?2fGG24NogpBtHcnA9hUAbqmjp1feWe4XPqEIE/DPzcXnj2rGGwo5auIh/qjR?=
 =?us-ascii?Q?2BuUrX2P60f+AYo/s3jBbNXuprCx7+OB5J041rN2x9JBGHLQSF4YQ0cDevpk?=
 =?us-ascii?Q?U/t4ehDka61P7nGJbAjm4oiwoNuunls0hYO+0cAg6zjkswtGcvAOyPync1Ad?=
 =?us-ascii?Q?YAOcg5ncucTRdRLHEa7xBDMHNvQkZ1ILruID3lJXXicHZ7QXjzLJViixFtlF?=
 =?us-ascii?Q?eqLHyKu0Ow9r8rx0B8jvoV1txYL1kq9G2HBXuSTLkF1RIgNlksfM0ImmNzRi?=
 =?us-ascii?Q?SfIiywH3kjcu4CJN+BnY3X7jkg4WQkiRLVzIHzmkAxyAhMlHoqWG1XQtgC2Z?=
 =?us-ascii?Q?r9kjrt0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wzfbz7/aAMGl5fn/grd0JJAUK7pfOPKxbMLrn7eqDDEJ4jY8aVXKXq5dI+CW?=
 =?us-ascii?Q?lBXyGSXBp0n/0/wYxp3bDPeRJKeZuOlBR6Bx5ICeMIJI/rfbN4sOxvrnBtPg?=
 =?us-ascii?Q?I89TXRrndTVRmVwPT4P/nzjiT5udfbza+NAfn5HD+AyBgHUK2S+7oG2HR1Li?=
 =?us-ascii?Q?6p7EAeB976bqXgjVUi7i6NbO0s9ec0Eme7LYo2oTNfD7kyw2sAuRxLkr+Fuu?=
 =?us-ascii?Q?axrYn72ktr4M81BEqJi5vjS+VW1adE+PjzVApgSVBZRDohk+/RqdU+Zg/2z2?=
 =?us-ascii?Q?Rdwmk2pTAulUb1UtZFTUvnGAiYdTDhnz3YSze0pNcCG2bRyKg+3lWnUQFox9?=
 =?us-ascii?Q?lZmMwYf/4Gcc+CpkE9Ou2yeT7IA6NtuvvCxQSuBAa53J2NV14XS3hleI9XGz?=
 =?us-ascii?Q?grLyO4kFJPtkK6ezjL8N/5/OAmJQtB4C2bDCIVg8ST0oW6vkZUduBU3iloWO?=
 =?us-ascii?Q?lOMCdYAzMKhjT1iSOw8j3bXaehxE6gKU98HBhkGj+vPT5AjVDaNJz5b3DEzp?=
 =?us-ascii?Q?fHAMc2IHuNpzsAxfXBScLYioiL0Ag7G1aceacWRUIcXVyfalDPHqeKpDTcuA?=
 =?us-ascii?Q?mXFxytTls7Qcwhih77DbfAj8CXTEfIVFzoJN1zOSEjz5bsU1xWsQ4uS7pW1x?=
 =?us-ascii?Q?Mx9vDMDxm8cBQl+5tA4ReDLak23ra+kGtJQv+aT8czxZaBzxRCJn8NbvOAyF?=
 =?us-ascii?Q?zHhJrgysWYbjWK4DyYpYoVt7g8YMv94AtKSVU7rD3lsuVZiJEhotJvSf51PF?=
 =?us-ascii?Q?17dQ5q7utkBd1bFvtxBp75u3RnP1L0x1NnXT8b7n24JJetgYCSazHy2EuqFk?=
 =?us-ascii?Q?rBKcQiufpH09NAe62ZETiUcBraL9Njj2KEIP1kFSRWWyZv/C7MrdvVetk9jP?=
 =?us-ascii?Q?J7tg44MTXL6l5f56H+5Bthfurf0wyDovnAjZhnF0L3RdOp9Tuk06PHq6MLBJ?=
 =?us-ascii?Q?P/e+8xNc7e6N35sqqqg7hotL0wujdiLFvzmfEnjy+mv+Wmyf/rxOGKVzE8Og?=
 =?us-ascii?Q?XQq6wqbE6ywPvUFbs6N4mEJdV+lQwLr4DDF+2Idk0if8D/B8ot1Lus+TJWmT?=
 =?us-ascii?Q?8AMz6/Vr4XGVG8e8XmE4bX2X4Ql6OZZgeGdT8lroH1MjXJ6IbkAzQrLobogC?=
 =?us-ascii?Q?qo8CDi7awHIs9IMiZYP7jjtNNokD2/13JtSjOEOFbXlt/DaYsX1kzQROn0O7?=
 =?us-ascii?Q?o9TIyvutxP28dD6m7kPfFImLhz9UU/oD5Ulaztq2rZjZ+CXvOjxvL0YrBKMN?=
 =?us-ascii?Q?RgJd4U04sGHktIw5eb5iB0X9qz3b6oeldXd9vLSvGt5tO49+FSSFoeATtntr?=
 =?us-ascii?Q?9OQs9ngjPUCscf3qAmMnchsY/sddqPRGe/WAvKgMbv3E2/+dlZcrv33PFf2/?=
 =?us-ascii?Q?O0LX5dbzYFnailfDiPlcplfYH1VpcYffIPD5o3JxFwKEJF7Hmh0W1+qerwVO?=
 =?us-ascii?Q?f59XGTb1gra2i1kuVyYdZ5gDiyD+ackj0Nyq2xlleVRLaVFiOpaEbLPLnMjF?=
 =?us-ascii?Q?2Whvtvl/eg6ZSZc1EUk1re16ndeO+C+8JnuY0xWKCdzLUvPnqoYcnV2h9wci?=
 =?us-ascii?Q?XOkfVn66FjoYq3N1vGA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7af0ded-238c-4974-5212-08dcfa920640
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 16:27:05.6181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00iaak1URSZvwy9ixVAKD73HwjLgL+cq/YpZl7FoPtRL3a6EAoLM/3uG6qXFTfNXdo0PHZP4fD0akQHY35zsRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010
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

[Public]

Reviewed-by: Dillon Varone <dillon.varone@amd.com>

-----Original Message-----
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Sent: Friday, November 1, 2024 12:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Siqueira, Rodrigo <Rodrigo.Si=
queira@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Varone, Dillon <D=
illon.Varone@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>
Subject: [PATCH] drm/amd/display: Add a missing DCN401 reg definition

Add a mising reg field to the autogenerated header for future use

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h b=
/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h
index f42a276499cd..5d9d5fea6e06 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h
@@ -6199,10 +6199,12 @@
 #define DCHUBBUB_CTRL_STATUS__ROB_UNDERFLOW_STATUS__SHIFT                 =
                                    0x1
 #define DCHUBBUB_CTRL_STATUS__ROB_OVERFLOW_STATUS__SHIFT                  =
                                    0x2
 #define DCHUBBUB_CTRL_STATUS__ROB_OVERFLOW_CLEAR__SHIFT                   =
                                    0x3
+#define DCHUBBUB_CTRL_STATUS__DCHUBBUB_HW_DEBUG__SHIFT                    =
                                    0x4
 #define DCHUBBUB_CTRL_STATUS__CSTATE_SWATH_CHK_GOOD_MODE__SHIFT           =
                                    0x1f
 #define DCHUBBUB_CTRL_STATUS__ROB_UNDERFLOW_STATUS_MASK                   =
                                    0x00000002L
 #define DCHUBBUB_CTRL_STATUS__ROB_OVERFLOW_STATUS_MASK                    =
                                    0x00000004L
 #define DCHUBBUB_CTRL_STATUS__ROB_OVERFLOW_CLEAR_MASK                     =
                                    0x00000008L
+#define DCHUBBUB_CTRL_STATUS__DCHUBBUB_HW_DEBUG_MASK                      =
                                    0x3FFFFFF0L
 #define DCHUBBUB_CTRL_STATUS__CSTATE_SWATH_CHK_GOOD_MODE_MASK             =
                                    0x80000000L
 //DCHUBBUB_TIMEOUT_DETECTION_CTRL1
 #define DCHUBBUB_TIMEOUT_DETECTION_CTRL1__DCHUBBUB_TIMEOUT_ERROR_STATUS__S=
HIFT                                0x0
--
2.39.5

