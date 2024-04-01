Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9854FCD1283
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 07:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CA2A10E26D;
	Mon,  1 Apr 2024 07:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AgR9e2k+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2135.outbound.protection.outlook.com [40.107.237.135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B50510E26D
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 07:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iby3zwpV0peneradaCg42N5hROFO9KHPmSLzCZKIFuX6ik8Q8RtFmGV1OlT1I8/L13tw5UiqqSYy5jObQrAHCHpYIojzKo9Zwv5NHlFAeWFDE8aKdFq61ahr05pJmAXxRVMxsBzxqzgIeJZK0cTCqxf592gGE4Wv2HoPQJNiWDX6WsiDMOCYLtq/0ecaqD67J314e+/AO6eVVFjxwNbSYiNI/0E04DT3dA01gu+UF5AS6latX8WtCm/+W/4sT3SO+mS65kgCCAk1hLOrULAjtzWaTLbnWOL5lU3Gsk1EaJsJ0sZkw6LFmATa1xoRENQpAjjvSUAxbUBc/riO0RvQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxO7M72L3P4WtxgE02YRwDhleWnYsarJpC6ObxydEo8=;
 b=MZOIfBVv75igHIar1a+y+oZlCEPXNKto1AzJx/0e15267SaoBeIBKRymrTKTiAZUFCciOttBcj/7w5sNEDNRinwiZfPjdauiXGd0sNyaGms0OXGkOrRJmF9KOV7RlSyNlidIFWZ45OlHhJSsCMxPdcExptHlBoKA1QVz5oQMEmDng0eEV7wSOpY9RI4TqjxjS1XmXiHuG/NbP7d7YMRsf4BvYpQXFbCWSiQ+xV1woEdl5NfK2g898k3i+xzNFsTDz6K68GNY3yMrRhyZ2sKN2MUrhEK2y5aeSTWDgM1cVxQkR9mVCFmUj0nBVaEkYmZp97O4KnIzLkVE4qjkMFJ8mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxO7M72L3P4WtxgE02YRwDhleWnYsarJpC6ObxydEo8=;
 b=AgR9e2k+dfH0hD87Sg3nnUy8CAPogm18tuCfJR0lMsyfo2dS/Qv61xrsykFAJmWG8IQSAwGOZ1zPtyp2aujIsBsUgDHuib/2c/bAU+fPxITC+gZZbpxEAQH56qdeLK3eUk+jkEQS6vX3vnwuKp164NARvKtGcmdHNFtvbKazDPQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 07:14:46 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 07:14:46 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amd/pm: update XGMI RAS UE criteria for sum v13.0.6
Thread-Topic: [PATCH] drm/amd/pm: update XGMI RAS UE criteria for sum v13.0.6
Thread-Index: AQHag/1O/K3fTvZqckGvnCPr97TLpLFTAHGA
Date: Mon, 1 Apr 2024 07:14:46 +0000
Message-ID: <BN9PR12MB5257388E5BD6F83BB0D773B1FC3F2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240401062427.369821-1-tao.zhou1@amd.com>
In-Reply-To: <20240401062427.369821-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6950cee1-687e-4423-a944-c31a342f6b56;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-01T07:14:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB7690:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UcDN5Viar538zemVca5nUuAQzmDbqywscESyPIYw+KvJaRwDRX1wNgHdZcvXBa0goRQks8+bajlZkP0huRIxIiYG0nQ89fGcrYpehmJEmShVu6EA+qg0PW1H+B4cfYD6ITMRp1alaSL7kPGKZmu8azuAa4NzRnWStsqEa6Dar7p97Jtrc6aE+7VQIfKvq769fIFXdKzte/MqK3JPEKrPWAi++lmtsQL9rr1rpcEjA6RpHC7781TK0OsbvCRawVhMAqp3ELnubZ+a31OacOeLCeQv2epjg4ZlhIbHUGHGwcvNnNilYU9VFoPvRCI0a4csicxw3F9w9RqSjM5vHYSFBUQk6naeFTr6uo17GkLlDwaJ1QyIu8tpOEEntrkGZmLyCmJSvi14rdvp+CETwkkKc1TN10Gpm6UMwZcmtYg6WKBYGNLCFhRjpiZXuP+oZyWGf+F2FybrWehpGdniM7obTpdK5EEicOqvn4g4BCKqe36BiFUjd0WojU+UXZkpWSXQQziLepD3xJ+/02m/FLvNr26u289J4+kbnZcI6FjaeY+RdwXE4ssEAxLmfEodrPjmtIJkCFiCy+gMCNnW5A4Be14oi9sTHYc/aEUGO8m5TzIPkpEA7DyPLmOmNP7KtpzaX1k+ldSrKHiD+4D1b7shwV5lmp7v2zkPeiWp1NBc2F8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kE7KAsCyxM2+KjQKIPaUh5Qcwk1njxjhQ4r4ZQEA3l+A2AFSxkHngJj/T85u?=
 =?us-ascii?Q?8GSVdqSdqff5LvEbxRDA/ZBtw1S2vj3boCuIXEkpzU/KyXsV9z5wKJF5l8AW?=
 =?us-ascii?Q?WzimrQnj+srr0bZCfaPRpM50m14m8/4PdTrjzQmQHbPD0ByHrXlnTq+1Uy/7?=
 =?us-ascii?Q?osghEJ0JO45HYpahJZZwcYbeZnPSKpYxZCPS8jvWyT78NibhcDviPafd8AqH?=
 =?us-ascii?Q?+Y4D/lIF56xjInJXFCCloEGHKlZvpNmolOdV2yvCg2PIVRofDIgWQi8/dsLT?=
 =?us-ascii?Q?1grdQMQgsZYoTFWLCH5+QvqtA14eOsftJTiQ7fhDQ2hte4G2UgrfBAhsEGCF?=
 =?us-ascii?Q?8N+Oyl+TMNkhiZXPofY1V4I9290g0NN3VHXDFFOkpvXdnt88WJxHzN7oQXOm?=
 =?us-ascii?Q?kyYLiQj8hdrPaLVOQBpYWp/W/Ls92ElhXEGIc1Bls5SpWDQ0VUdlJhvDxy21?=
 =?us-ascii?Q?QfGo1AN1tjSjwkYtCBi9fE+EpcfKn9zUiJYGU0MztKIrExSYGQTq6V9KFeZo?=
 =?us-ascii?Q?PxJakwwvoF0oYGyRjC9FqfqTpLIIAMB3Gci5OcU9mayz7G67gckftRiOr2JS?=
 =?us-ascii?Q?gKD+xRSY3GrwHHjg/CumZwiUrSp35i04LOmZ4vXwYdTASBiiBDD8CXRfu+kA?=
 =?us-ascii?Q?/OJdcsI5lrC37i2gxRfcrEeG2Vv0Iqw+BJYaoqKlhd2NFVuvTozr7AwVLSsc?=
 =?us-ascii?Q?z8otqyIUeAafESoKpTqZX2mfqMJl6kOkJeTp+q4iM8qtHsGYQKH0L5AXEQL1?=
 =?us-ascii?Q?1rTedfxbcK7+YrcA7XuV0iu2EfOmAhZD6AM+6BzFtWW4hi/q4/l3xid4apHQ?=
 =?us-ascii?Q?5j/sY670mznQmwPTwQ9GiZvLzdmjbiguqFnDcv117HumcQ56hAs89zJy/ArW?=
 =?us-ascii?Q?0REJPXODTNru+JzxhdCPvAYy/N1jUbNxxB/eMUyqxiv/uLrMIV0fkST/Le/J?=
 =?us-ascii?Q?/3mgZgFf+BZohF2clWbdjApk3xAIerNK72ANIQOInyqXxg2Lr6ir0qC7CJxl?=
 =?us-ascii?Q?qiHbVCtMlEVojrsTiyyQCsGJTRf4Ml1HKl04Uk5K6arFfYnMLhEOX19Pd6ol?=
 =?us-ascii?Q?WVx2Z5JcpC8hBHLnb89Zma2KvPGi74Ttbfcu2eeKgcARKtRV11RUeF7j0TNa?=
 =?us-ascii?Q?f+Q1e7VCEGsxYCp/MWnn3ckqN0khYlWQN+ugGvDQQTgMK7DwOe/uTwDRgv6q?=
 =?us-ascii?Q?Gv/6kq1f82XRPKImmIm4/W00rN72213FqRGdfmYJFe5smrnw9twkDvfYEOP2?=
 =?us-ascii?Q?uv9vGRI8hMfuL24lyg9pYLWjSXcQO8K1E8ofCp5oGbh9JNtcXGsrtLw48yOp?=
 =?us-ascii?Q?r31wl9EqKi5onBgY8a8j1ALOVlpcP9IaQ0kziPL7G0Z250l1ups3HTei7xvZ?=
 =?us-ascii?Q?R9Gy21FrC+ghdiE2G4kMy8E1R6+i07KCoTERcx7ILdufao6wekMmHw/yu7TR?=
 =?us-ascii?Q?qsZGANrRM+85ffuPW6ISZLfVQswcDB7IiXMxrRo4HtzJtCrnJXg+m/jRA4e6?=
 =?us-ascii?Q?FCZFdpD2LUwHkRKogue0IaylTcHvtp97fTa53ui572lTPTlj10cpdJpeyQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c9368b-be4b-4d75-d289-08dc521b6922
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 07:14:46.0719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6nTMgNoZ2oI3Ip4XtanDTEWFKRbwHBJDz5fnSWEJqSsve7rT/aOqK5MX97b8E2J67FqZYrBH8tkDF2EP24YTdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Monday, April 1, 2024 14:24
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amd/pm: update XGMI RAS UE criteria for sum v13.0.6

Add more possible ext error code.

v2: still use ext error code instead of UC bit.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 443233563a52..7a7c7f4b7de3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2694,7 +2694,8 @@ static int mca_pcs_xgmi_mca_get_err_count(const struc=
t mca_ras_info *mca_ras, st
        ext_error_code =3D MCA_REG__STATUS__ERRORCODEEXT(entry->regs[MCA_RE=
G_IDX_STATUS]);
        err_cnt =3D MCA_REG__MISC0__ERRCNT(entry->regs[MCA_REG_IDX_MISC0]);

-       if (type =3D=3D AMDGPU_MCA_ERROR_TYPE_UE && ext_error_code =3D=3D 0=
)
+       if (type =3D=3D AMDGPU_MCA_ERROR_TYPE_UE &&
+           (ext_error_code =3D=3D 0 || ext_error_code =3D=3D 9))
                *count =3D err_cnt;
        else if (type =3D=3D AMDGPU_MCA_ERROR_TYPE_CE && ext_error_code =3D=
=3D 6)
                *count =3D err_cnt;
--
2.34.1

