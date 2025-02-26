Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD09C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 06:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E4C910E84A;
	Wed, 26 Feb 2025 06:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QvytbXZc";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 958D210E84A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 06:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shZTOH7Qk41buWPXfYzNKRnqauE7eP+/9tw/WztZdtcnUEgECZRQMD8mCNJHGit8I57VsbReOluXF/N2RO9GB9f6PwW21FZGDLwdawiX2+xVQGCt3b48H53MglLhZqMsFh/vqmOJ+BZLsOEFozO/Hs9E8eAS/YorXEEAuMhHanh6ln5ZgqBTTsXyLL5ERxmOTsFDtAgZFL/oaasdXEYYMCI3diehXZs2zOQc2xnrJK+CfRrI4pX+SWPl7LlLw5+VJJh8E3IPQIaU1HMNivU2lLR5XKtWOc4zCNUk5yFai0/TXal+8wHFwtS+qHgB/jUIwYyezfr2llW0T7H1+v5EMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVxB2Ej82a05jVcC/slyrIYw7GhAPW+xAqa8opIppuo=;
 b=JcgWjQ+c8952GaP7P+L8T/vikSFKbIk+j01pnqVqZSvh11W6rpY3kvLpfdZjwHmzTNZo9gq6mJ8l47cXzF4eedPFT+12kGXERe9GbYJNbAOyqxY4bQt9Ux7wn9ek/UgydStzljxOIJbDXE7I1TmXPNgiEeJa3xA25+Brta1pyKNiGhQ8ZJ2WugHVbnqXbOql0T2o5EHPfLf+Js3P7z20YvGLzxPe3LKMjIK3B3XFrz9FLXw/57tPIJVMycTYfL7+FSY/1R7i9b6YX25OUDHUHS6rfJjI5G9B4jNy0mhGKJLUSsBMHHoisKd6OtgW+UQ56+vDBIq5Ngvx5iSQ0VB4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVxB2Ej82a05jVcC/slyrIYw7GhAPW+xAqa8opIppuo=;
 b=QvytbXZcawKWMgbKoi2xpd1DRDX/ynpeHWdDGLG7yI8ET+54+dLLm6M2EBz1HaI5SFrOuO3CEhOAorTDQ9Z28SockaASfxFam0jIJEsK12kbkxs6ybQ1SlQztEbatZQ0ChPo23aBOJ+gXsDiRPG6wWn8OG43gX2DWGPnl7GYkVs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 06:11:15 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 06:11:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Decode deferred error type in aca bank parser
Thread-Topic: [PATCH] drm/amdgpu: Decode deferred error type in aca bank parser
Thread-Index: AQHbiAGA6aPEs4i8GE6w+80d2rWWpbNZGUug
Date: Wed, 26 Feb 2025 06:11:15 +0000
Message-ID: <BN9PR12MB5257C759A177593EEE98298BFCC22@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250226034929.48207-1-xiang.liu@amd.com>
In-Reply-To: <20250226034929.48207-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6c76da46-e72e-489a-ba5e-e43f9c3422d1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-26T06:07:02Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB5877:EE_
x-ms-office365-filtering-correlation-id: c1d8f4f5-3952-404b-712a-08dd562c60ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7dLdkjLIJVEPpFXFcsIJlj3pHRMABV76ZwJwKlja9ahqNHlGJjq8FN0PCEJF?=
 =?us-ascii?Q?dwiwmCwLwu+KHMe/fbuuZOCigOOC8d+sk9xGTJ0BFBKa2bdtr7dqIr6de1BX?=
 =?us-ascii?Q?+zVTTcbV2ZXiHdgJLh+zDoEbnkTgp3WNb4ONL+B+idFcscnPJRk7HWZkSXGw?=
 =?us-ascii?Q?dIVR8w4ymBVFc3FLD590MkyfuyZqntinoU7jhm8msHl6JAnqJB5iRqrDILVQ?=
 =?us-ascii?Q?XRURa54W+xUKFoSrC1fHK/ApHEa4vs1ZK6P1STL/5USYizQQB2KChHs8iTR0?=
 =?us-ascii?Q?lxBaMUSuGtG4VYTaGw6ozQvTKyh5yCLCk23403EuBWfMgOs6aOf/8LDmnutR?=
 =?us-ascii?Q?iD4IIX+4P5ivO3H2exSrTJ+yFSMVBHkIyhqmXZ8EApiHqnlEwyI7eet6sxaF?=
 =?us-ascii?Q?jsAqv01FvogV0cbt+4bBQe6R7OYdOBocY4Haq8J9UDv6H485i2Yu1Ses1nBw?=
 =?us-ascii?Q?I3LTqHoP0kx3lE/EmDQUTfNSoO/OOQUpkh4o1dbuhyvDAct+sT69Pb/7fpf1?=
 =?us-ascii?Q?wHgc27G5DbZW7Fwxv9webKh/8f0MBwuSbaaT6f3TOV89v9P/Ber69fgmF60j?=
 =?us-ascii?Q?wrx9SYGbQlVLxfaHhVXEezoYpUiVaC7YaFHt5Qir2tq4kIirdCbWoaTYCZ0c?=
 =?us-ascii?Q?NczN2GYBKLAGGjQoPF39ryOy7RQFHT9tGB/lRxukyVJB5ejjVb9D56stba2V?=
 =?us-ascii?Q?J9limnnz3h5Qz4JpgOd7eaY016ltOttwz0CsCTsyTWLQFpNsAQQw+FLFqxeJ?=
 =?us-ascii?Q?CvetktRJ8PpNLZ5EbHhLJCa/AJ3CPsm41I4UuLBb4VDUL+9vZyb4vpsdH9XT?=
 =?us-ascii?Q?1WfU3+3Y+oL+1wz2qRgPvr6PKSdbvqetr0N8gNgbe1QcMFjPrDsDwuFYtoCp?=
 =?us-ascii?Q?jkvAEfLfFuwj8iAvcANtVVXVrT8oU5shpn0BOvY3KfrF84EtRsnbP/9w7+y7?=
 =?us-ascii?Q?s/nKtmyGCdd6dRT0ftXNQ4xHtxJlzB1EhkWY4w4O/A2e9Cclly0n/UD57Z7r?=
 =?us-ascii?Q?D4Ty2WDcTUw9go1wLowO4CCL6d5xpbVbRzq9C6DyCan8ydE/k0tKuxywRjLr?=
 =?us-ascii?Q?yTy5U3JE54keJ8nwkAvRm9/vunzhBs5CRyUUZ6og5ySeHUgmqOidDP5gaKnT?=
 =?us-ascii?Q?yA7SoDvSeah5sGAMwu353wW4nlljictayKCNm0WTXDXSth/bJGH4i2+yV1Cl?=
 =?us-ascii?Q?bwLjWeSYk1J73UI84umtf17IXIUDl+gs4ktET6QE8IeW9MI3Kyy8cFOxzTH9?=
 =?us-ascii?Q?A93NKvhOOKvThZslp3fe2r0/tEa14RShfYIA99lU3hOlLys07Q8ppEafOfbw?=
 =?us-ascii?Q?UjmJUECaUWNVXAYCM8gZQBosJWQV60AE26lD9LJRws4SF3vgE2THGUT5sIX7?=
 =?us-ascii?Q?CpWeGTD++lzE6SZAMFM8r2zXnI+6CkVuRaBrC66eDGYmMFsCgmmA/2UyyJCL?=
 =?us-ascii?Q?aVG/q9FdN1irafj87b3j0NkDMwVxkcsQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2zaUXFAtKwxelXoc/cVY7bC/BkD+l49BDZlgKFs82jCr3yO46mHCRChQahYS?=
 =?us-ascii?Q?u73PrpwJUfnWpmxtD4o9GeuOXDsknOicdgZtu1dwgUnNt0b4Ps1XbGIlX+7f?=
 =?us-ascii?Q?BbwJMhV/1eVzc3ScEfZT8nh36LFw1ZzkfuYLH1PT48o9mYuVxWVVtBMqiuZE?=
 =?us-ascii?Q?6lT2+vzvbD27gWYuGYIxofi9qvrUm4YbWntJlDQTM/lZagWphrEt3RS5V14x?=
 =?us-ascii?Q?FcicCDoYnILJyyFn5u8yvqckvZ53yR4H0RMYGjhMeNfJTwLOv4C8nDzGYMRw?=
 =?us-ascii?Q?sq1rsyChdLkMcj140hS/mzmmFy86cjwoQFQar5ldxEBgBSyoVbCYU6SF0hNG?=
 =?us-ascii?Q?bmjZhH36lHPf7V3xsEy5wgf3MZMyDNyzMchpaARFWFcrrTRc52uGrS6MvSm1?=
 =?us-ascii?Q?R6qq7baTqvCTfs96bw7I4zkl9UIbjKKK/34o7OOwkRyKcQr2LuEzhqyWDc0J?=
 =?us-ascii?Q?lJ9pIBmQ+nSJoeoL5Tw1HSZFNKBCEY/XTBry1BoXlYGUdrYkOTMGq2OkeANj?=
 =?us-ascii?Q?C9a8+kc+kYGdUQ1+c+yEAT0JdhQuaY3TuGYpvWgQtSM3qqndyrLo4o+NxNTY?=
 =?us-ascii?Q?qnUsBqV2/qreXGxrTdDqpDbIS5JYLWFzOwwoQ10NafUHZWsOGErFk3Sv63I4?=
 =?us-ascii?Q?c0q5JKNTGhHWHJoKriIlwNwzLOf2F2yQOQis6F4TXU/l++T9RJzaLvhZNuK+?=
 =?us-ascii?Q?w7mE1vLfJi9iHTzIMKMtuJRXU6YTh3t0ukd8P9TY2EDMu0TIqg/L3/tFtm41?=
 =?us-ascii?Q?zdYB/ZAxYMZ5q4d0NaF6nnUv8SSJjf8SRwRVhne6/oyfDat5FzwiF07NeoUz?=
 =?us-ascii?Q?ko5ivk4PD1Exui9zKWju7NA3/aFo0QCFCbYahyoFanCFTuc0I2OrzlKAR/I4?=
 =?us-ascii?Q?a8b8EQnRHjM4Tg6TqG4zZAIk/v2xiRltcZE8Iu/xKL521Zp63/lwkT4ioSAT?=
 =?us-ascii?Q?hDcKdJyp22PnUmbOoGS/IPf2CpN1XbUULodU/HfrnIrBznhuDAzVLcq3Q6Iz?=
 =?us-ascii?Q?TmU0MI47Me185Q5XUTTJYZZ77FlCEq2lHhKuubo9vBh+C62ue/j/NS/kRmsi?=
 =?us-ascii?Q?ikqED1+P59Q1xT271/XfT2xQi54aSEN0+TEJK2Rl0Gc0HF8o9idS8Z7p4pIE?=
 =?us-ascii?Q?p73X+Bv6N5fOvlvy5FZMlBP0KrtijU5BJlUKEiAcXoXIboAzoGvyGac5jOLO?=
 =?us-ascii?Q?FIr1NhZCshP3TkpPjy5AlEFq1Uv4HcxL+226HTEir6N8VfJ/3qtE7OjLhNof?=
 =?us-ascii?Q?GvtPWUCWCyimYjp7LA9+pi0iExKNyKfpUZVR2U0V8PFIpsnEi0eBEK5Kd5iz?=
 =?us-ascii?Q?7kuFgk7mnghSF2cTKUYonfmmSELm9bCnHNLjXJIzdPx9aEZz47sVApBRzB6a?=
 =?us-ascii?Q?lrBPcALFXfbrVbjDxWag162UNPTqzWl97hLIZm8zGtpeVR89pjBZ/VyGdNnC?=
 =?us-ascii?Q?h6iJNR5EFEcK8YwdGf/F4R5bP28/LPR7QOgKxEW/ilIHizHQjP88k7jZMDD/?=
 =?us-ascii?Q?g/24wiux1MU1bdyU/u5TUyJkjrKfktOmF19RNoQ4AUk3p/wX9K8AgkPqrw9S?=
 =?us-ascii?Q?RXuiM3Yxu5WO2TD54LZdT131MM47xchk6F9SI+o7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d8f4f5-3952-404b-712a-08dd562c60ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 06:11:15.6324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mHVsJie80uiyCwToJUf+cr/a+5G8BlEocQoIHBkWzHjIc+9LKdIWQe0h6VGV3X01lx2y4DdX3CX1ftP9evZnqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877
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

Shall we check (deferred || poison) bit to identify deferred errors during =
either poison creation or poison consumption events, and differentiate them=
 from CE?

Regards,
Hawking

-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Wednesday, February 26, 2025 11:49
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Decode deferred error type in aca bank parser

In the case of poison consumption's inband log, the error type need to be s=
pecified by checking the poison bit of status register.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h  | 5 +++++  drivers/gpu/drm/amd/am=
dgpu/amdgpu_xgmi.c | 4 ++--  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 5 +=
++--  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 4 ++--  drivers/gpu/drm/am=
d/amdgpu/mmhub_v1_8.c  | 4 ++--  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |=
 4 ++--  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 4 ++--
 7 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.h
index b84a3489b116..a8c8457e4160 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -76,6 +76,11 @@ struct ras_query_context;
 #define mmSMNAID_XCD1_MCA_SMU          0x38430400      /* SMN AID XCD1 */
 #define mmSMNXCD_XCD0_MCA_SMU          0x40430400      /* SMN XCD XCD0 */

+#define ACA_BANK_ERR_CE_DE_DECODE(bank)                              \
+       (ACA_REG__STATUS__POISON((bank)->regs[ACA_REG_IDX_STATUS]) ? \
+               ACA_ERROR_TYPE_DEFERRED :                            \
+               ACA_ERROR_TYPE_CE)
+
 enum aca_reg_idx {
        ACA_REG_IDX_CTL                 =3D 0,
        ACA_REG_IDX_STATUS              =3D 1,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 49da137d42c9..c313c2cf6969 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1169,8 +1169,8 @@ static int xgmi_v6_4_0_aca_bank_parser(struct aca_han=
dle *handle, struct aca_ban
                break;
        case ACA_SMU_TYPE_CE:
                count =3D ext_error_code =3D=3D 6 ? count : 0ULL;
-               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
-               ret =3D aca_error_cache_log_bank_error(handle, &info, ACA_E=
RROR_TYPE_CE, count);
+               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
+               ret =3D aca_error_cache_log_bank_error(handle, &info,
+bank->aca_err_type, count);
                break;
        default:
                return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 50eb856249d5..87add6274b98 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -883,9 +883,10 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handl=
e *handle,
                                                     ACA_ERROR_TYPE_UE, 1UL=
L);
                break;
        case ACA_SMU_TYPE_CE:
-               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
+               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
                ret =3D aca_error_cache_log_bank_error(handle, &info,
-                                                    ACA_ERROR_TYPE_CE, ACA=
_REG__MISC0__ERRCNT(misc0));
+                                                    bank->aca_err_type,
+                                                    ACA_REG__MISC0__ERRCNT=
(misc0));
                break;
        default:
                return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0_3.c
index b8f06e9c9e62..1fcab0ef21c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1332,8 +1332,8 @@ static int jpeg_v4_0_3_aca_bank_parser(struct aca_han=
dle *handle, struct aca_ban
                                                     1ULL);
                break;
        case ACA_SMU_TYPE_CE:
-               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
-               ret =3D aca_error_cache_log_bank_error(handle, &info, ACA_E=
RROR_TYPE_CE,
+               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
+               ret =3D aca_error_cache_log_bank_error(handle, &info,
+bank->aca_err_type,
                                                     ACA_REG__MISC0__ERRCNT=
(misc0));
                break;
        default:
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_8.c
index 58d22f0d5a68..a54e7b929295 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -751,8 +751,8 @@ static int mmhub_v1_8_aca_bank_parser(struct aca_handle=
 *handle, struct aca_bank
                                                     1ULL);
                break;
        case ACA_SMU_TYPE_CE:
-               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
-               ret =3D aca_error_cache_log_bank_error(handle, &info, ACA_E=
RROR_TYPE_CE,
+               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
+               ret =3D aca_error_cache_log_bank_error(handle, &info,
+bank->aca_err_type,
                                                     ACA_REG__MISC0__ERRCNT=
(misc0));
                break;
        default:
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 4fa688e00f5e..d5d3298adfb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2494,8 +2494,8 @@ static int sdma_v4_4_2_aca_bank_parser(struct aca_han=
dle *handle, struct aca_ban
                                                     1ULL);
                break;
        case ACA_SMU_TYPE_CE:
-               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
-               ret =3D aca_error_cache_log_bank_error(handle, &info, ACA_E=
RROR_TYPE_CE,
+               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
+               ret =3D aca_error_cache_log_bank_error(handle, &info,
+bank->aca_err_type,
                                                     ACA_REG__MISC0__ERRCNT=
(misc0));
                break;
        default:
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0_3.c
index dda5ee187948..5971715495a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1930,8 +1930,8 @@ static int vcn_v4_0_3_aca_bank_parser(struct aca_hand=
le *handle, struct aca_bank
                                                     1ULL);
                break;
        case ACA_SMU_TYPE_CE:
-               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
-               ret =3D aca_error_cache_log_bank_error(handle, &info, ACA_E=
RROR_TYPE_CE,
+               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
+               ret =3D aca_error_cache_log_bank_error(handle, &info,
+bank->aca_err_type,
                                                     ACA_REG__MISC0__ERRCNT=
(misc0));
                break;
        default:
--
2.34.1

