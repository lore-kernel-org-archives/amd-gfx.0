Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E16C5516D
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 13:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2E8C10E21A;
	Fri, 31 Jul 2026 13:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FPiL+S0W";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B4510E21A
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 13:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDUP+iAB/vhtbtkmlke2sRs/8paFoiKf5aSAtK7NyjXNlFJ04J2E6V1ptkr9KfDxhANReRVOqFaabiqoJi6dhchh7nrpk+Uwn3QuXCGJ05MgpQSYVZmI8XyuOJlmvmUGDs0E0T40QNGtr2SQI1ZjHEqpPsZmPgzho7V0vV3qjXTpR6jhQw4BJkhXoyycgDsrlcIPRSLvHKBy2rt5gKB7XjF6JR5boJFsxAHsy4WrevYOIlIantz/NtyOE/rSJCfChAHHc8cDbS7za1BayCcREbTuRRdRG2LyxeNyeVNaZZsUIfhRpJL4ATkNo5Ku3konhVRq7Qfn0n0FAyShTWpLEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xXNpZnvlIeFYUyFkjgbYVCzHoOztpGxncMZCtB0gq0=;
 b=dPjN/BKV/LB8C1kXB81LSxnvB7BGnNjXUz8IcozrmODEU934Ee5ASiirNcVmpTUJwQToKOkFqGUchxhxxuMCqAtGEJn9VXr/xxuWbDzUpso+mUy4yrj7iIzPlB+vCsbhL7Sq5DzB7fFuVgjMxQojNh/AbMBWGCIzR/KIs++dOota91gBmI53shVSuFkPCnZ2txXH8qH/le8VvN4ttioyOfdzvGm9vaF4SvnMKbCCpMLfRndOTpY49SbiTjryLSx2EnAvAN1qxRAj/y+p9Sk5jJiE4X5GaurtVba7e0qa6ADBoOBwVktucmYvJWDkINWOMoFOpBqiGVh2gpMbMfE3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xXNpZnvlIeFYUyFkjgbYVCzHoOztpGxncMZCtB0gq0=;
 b=FPiL+S0W7EnskUeDyKfE6g9XOfZwkF/L21B0u+Js56JqfGfJFwY18wIaKCF5WSgiqG1GpFpZfl7uGdw2cVTyPqTPhFa3YLrahnJGwvgohMzaDRKpwnE062hLf3kf69R8Ts67yEkYM0NZZKRxnGdLX5ZRkctBUbKW4JkMuFKDX3k=
Received: from CY8PR12MB9035.namprd12.prod.outlook.com (2603:10b6:930:77::11)
 by DS0PR12MB999265.namprd12.prod.outlook.com (2603:10b6:8:432::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 13:06:31 +0000
Received: from CY8PR12MB9035.namprd12.prod.outlook.com
 ([fe80::dd3f:35ac:ef0a:723f]) by CY8PR12MB9035.namprd12.prod.outlook.com
 ([fe80::dd3f:35ac:ef0a:723f%4]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 13:06:31 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: simplify cper ring fini condition
Thread-Topic: [PATCH] drm/amdgpu: simplify cper ring fini condition
Thread-Index: AQHdIM7bYktibrTJmUK1inbRGl5Ea7aHmCcw
Date: Fri, 31 Jul 2026 13:06:31 +0000
Message-ID: <CY8PR12MB9035FE1E766825D7FADD11D2E9C82@CY8PR12MB9035.namprd12.prod.outlook.com>
References: <20260731092705.995916-1-Frank.Min@amd.com>
In-Reply-To: <20260731092705.995916-1-Frank.Min@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-31T13:02:47.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB9035:EE_|DS0PR12MB999265:EE_
x-ms-office365-filtering-correlation-id: 16a05edc-56da-42d7-2f3a-08deef048a6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|22082099003|18002099003|56012099006|10067099003|38070700021;
x-microsoft-antispam-message-info: KMkdMIN5x9Lnm6Er6SNZFQhtoCR+ra8BTx4CVby+FVVekkcVvowgIQpDkS11jTF1Shib9Ehj2unojLurjrniNmVD1/Bqi+fndkQTvPOmMQicPvy5HQ3qSsjUamN4t0vR/wQ6sX3/T+7qxDG1dZ8QPmi9cO3hxjp/xaz53zVQYpS3dUR+2JtKWcNY6n7vm1k5WNcK4njBxsZM8SqAQgEd6v1Vg4RnnWf58A6lHyRqHKlSNgpBUvD8bD2d455fDT1tRreDAtf6lmAVuyryQAJnIHrDR7YhXFHGSXT7ndnZcawkvHdCO9K6z6iuqC4kKv1LEuMmbyITVgcKBUJse2sgm5wH5IpIi9L9Z0A+ZWXPOuOGIVxmJxa7Z6RVYQwGNQSdScPf/0APSpIjkbP4GpLArDnoCS68OKhNICt3w6G/nBx7N8pDkvlUA2XiLeMmmvOsDFy/61I253lGua4mNzeUawfqAw+oTOJsWa/IzgJb5MHHqMWA1WmIVA2N5rPOy7yVbti2mwJ6novkJHBNZOMym3sce4jiuWG+SK7Wd74WpcojK8SPonDOgRemhxmalJk8r7qKK8Tlf35KwBJTpA75rFkCv5lXgGB9hMVpDRXrPtcRHoWuOLPRlZjOulMLzIbqprTJ+8hqK4kDg1Rb74x6Mg+bYA3/xGoc9fY73g2TyWzCxcu6nayvTCMf1UUTtIiUkU39sh6OOjBAo7ZV7ZJd+y+78uTLKmysufGauy5I8Ak=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB9035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(22082099003)(18002099003)(56012099006)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ktuy2rIDtKpE9rL6vDLqXredCJQ1Y6CkkCUJzTYmojp993f1c+AtUAdQgO3A?=
 =?us-ascii?Q?2/eKOrElNaWv4QX7lTxBF8ai58hF1gBTh3gs6P3g5I8ARAMncJ2MvQ1FhuT7?=
 =?us-ascii?Q?bhIDMXnZObvwWKxjfrQHkAUgn0g7H+alz3alhOC2OcyAlrrdSMDZ/NzgjBvs?=
 =?us-ascii?Q?IRxipT6zyRRzhp+PHagUHHFmH+4BACzSGgMH/pbdjdYe5gmJKDM/ft9D/119?=
 =?us-ascii?Q?duQeCpiUxts5G/VG2NQEuo1ZVf6znAWZ6EYIrqFlNdHdjMgxbovSZrUXvj3e?=
 =?us-ascii?Q?MZri/XcIvzb+6Q/92hdZyNJjbML9VkyAFn9OLSlZYbeVdACa/qcaV3nObVLX?=
 =?us-ascii?Q?FbYTGT0E0HG/vF8N1ZaWf//3VDF7KmAcIdu+KWVHgP7InzdH5nl9TNt1f8Dz?=
 =?us-ascii?Q?YdrRjle0sjRQxL/Qg05tGMdilkshFoOgA6eDFy+bcsn8mQaoq93inW4MgOlR?=
 =?us-ascii?Q?G841HP0gqwD58CLK7vFkL/3ynt3t14kw+pPzK6HukRUMWMtTaJhMES8a76h2?=
 =?us-ascii?Q?TqVmhZFqZ+OeVwPPkRjCOskj2Etw98H2QMZlRS8/0zN04FF9wkjPhCm+Er1I?=
 =?us-ascii?Q?5HbHa3AH2lC0OAnfaNZf4T0umUBh0gXQwDSg78cTbgmoKvT2F3+G+drmwnTh?=
 =?us-ascii?Q?lmCS9ZqxwNnwz4pdnL71+L+AclBvrFn1+4/rg5gj5pCmZYOta1zU2Sz9o/38?=
 =?us-ascii?Q?7HkfiBtvkNqy89dx1evcYkDDQUUNQzfSZ1Jr8bivX+omxd05tmACe/lnCsDF?=
 =?us-ascii?Q?0y/IyLfM/gSNQvr5UEHdq/aKhkUha/n/VnyqxY1WH5hkdIcF0zhN55XjJWpo?=
 =?us-ascii?Q?YGcdOw7thLxlIXXAWB3A9wdvm0QNCTGENVnnJQreVAOcagX1rLa33M3/6rTB?=
 =?us-ascii?Q?dGrbzVc9hJ1ghAIrqX6Od7BBck7N8bgdH1CER3EltCAKUO7v4lgeUwKgfjX8?=
 =?us-ascii?Q?HMAqZvC5M03Vnn8F2rsETFAkmjm/d3wrFSPZ2NXQnEec41SFh8ELhW1VpdfH?=
 =?us-ascii?Q?I5aj5Ha6l0yxrOFBvn932W1eZlVTdsuio70ocZgULZTSbjxuYhH3b4AIsmAF?=
 =?us-ascii?Q?77sRI8Ljo24dhC8u1UyGSWa3jz5faSGmE8znMJZepL5ld2NnGvz7PMdOsIWx?=
 =?us-ascii?Q?JyC7zA0MFZO8mkgt/726qNvUT4/UQBZyKqhmrlMXs2i8qeVHsUo1VOw76RBn?=
 =?us-ascii?Q?0g+vSU9lZTq4+v5dmf26vkXb+BwnbAnzjXb4svpGTHASTtIWuprvF4nsSaSS?=
 =?us-ascii?Q?+C1PrKnIbPmuM1J2alX+K5h/KfDC7I84/VOmKh1Pm514kOi/iuQYe/eBeARR?=
 =?us-ascii?Q?ev6dvPPL25XmQhPqmoE0N5ACyPQ4o/A04fUB/i8g/S2k9AL4ZmlXls0u7vUQ?=
 =?us-ascii?Q?15Meawg9vt28OzLuACofC81dpIK9JvoMFPmf0z98rufCoJxpi3GS4P0c+3R/?=
 =?us-ascii?Q?m485DnTqnoEoF0Rf/pgTMRY/IDI8v0Bmm7Nxo/qq7ZGIGjBn8kDBMyaJfTde?=
 =?us-ascii?Q?TtyJ4ClJnZ+u+VacyS/DcmEOlm/Bc25ByGhDzj1wrqLggtCO9p99GANqllTC?=
 =?us-ascii?Q?4kmE8oQJYcGJydDhIge89mDRRBfMp/R48v03AAne6gBSc3mBwFwJoXNbVZXt?=
 =?us-ascii?Q?+qJO543bmZAEVgAog5cstXwSlY/7RFAf0H1+ppXZYnqT+DAQStyhElYlk/Mw?=
 =?us-ascii?Q?o8LGdiBPwleCe1cL2iC0RW7zIUA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB9035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a05edc-56da-42d7-2f3a-08deef048a6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 13:06:31.3764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmpvJ5GI+4+sNXpopz9V0WR6ZFwvB+OYHUs4uZvcZoCy1fv/Fq3vd8AmsXK006BN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999265
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

AMD General

From: Frank Min <Frank.Min@amd.com>

To avoid cper ring init and fini with different condition and causing kerne=
l memory leak.

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cper.c
index d5e59c24d907d..e94862f90cc7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -612,7 +612,7 @@ int amdgpu_cper_init(struct amdgpu_device *adev)

 int amdgpu_cper_fini(struct amdgpu_device *adev)  {
-       if (!amdgpu_aca_is_enabled(adev) && !amdgpu_sriov_ras_cper_en(adev)=
)
+       if (!adev->cper.enabled)
                return 0;

        adev->cper.enabled =3D false;
--
2.43.0

