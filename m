Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1149C021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 05:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A02E10E1E2;
	Wed, 19 Feb 2025 05:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UAcQWCNY";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8923910E1E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 05:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0MjzasWtrIIpQHYhU6em2SviBPZBiV4O/O3WaP8UAwbS9q/p0z/xctna7cR6DShEkteLoytMzOERcemmdWyXScW979IwNBLkuiJYe5guqfIf0A1anff93J/+41WnphtIBAFLxLHrxlyboE2Uk2TRngEinmk3bMk7FYvpQNJdbiIpJCaFXBjVlLpxWXhNn+uzshGDIlALhkd9tD/HWIbbiXYGP6KKM/eCV//yhbVBJN5dXGrrtNKgtR+eSJ+3z14ZKjogO9jlG75q7Vl9zsLDEH0d4yKZPo4ZntJq+Bkp/vLkGzJQPJTuSb98S5USPG1hlAfyz8ezF1+2NjWZ6VOiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4WpSrZA9WgMPfJxwOqnnt1Hh2xm25cKn4fg9453gh8=;
 b=Y1FshIuq1l0z2H6t+4trJLPdRTaX+IhCuS7WX/SQnIqHeWrhtSMS+a4kipBMClMvc33v1+Q7OFJe6pdLqeqQAfYhA1AtBqEGqQw4xYYMSETSoO7zSJoEFf7jsXGUCKb/ArZceOINdpWjknePd1ILGYZER0WusUYBT6BlGKCJYPUKmYiNyN2Gsj7o4UzraJAw4Zi0meQXHo5Bstvw79V02lAjEyk/FQAmtF7omf4D8fIidxJ5DmsMtUnK96JFe0+tyXWeFm0PWQmgtS7QJ2jFQPPIL/MOaelblplGFkF4oEioQuBrAz5y5fX2WhhWnlmzNZeOKvwCchZWc20Ol4Swbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4WpSrZA9WgMPfJxwOqnnt1Hh2xm25cKn4fg9453gh8=;
 b=UAcQWCNYniJ+pnVxty8eIYtxTQFxTW1yg2jf04iGOZWTlrbJhEqyteTSsksOYyX+Kw2hdCbdATICioEVI/T6a/QCj8RHTT6wgazUCHwtxxqBYZ32YVyFo0aWggQYFTzlFJDFSkes13poEQe7VH/oPYfnQZiCJ8WXYadss0VcAS8=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Wed, 19 Feb
 2025 05:03:26 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%6]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 05:03:26 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "kees@ijzerbout.nl" <kees@ijzerbout.nl>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Liu, Xiang(Dean)"
 <Xiang.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Remove redundant check of adev
Thread-Topic: [PATCH] drm/amdgpu: Remove redundant check of adev
Thread-Index: AQHbgogiQO+Pjwb2EkeW9BEPq+HoI7NOEhPA
Date: Wed, 19 Feb 2025 05:03:26 +0000
Message-ID: <PH7PR12MB599737F3EECE2DA9E4EDB61182C52@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250219043724.717663-1-xiang.liu@amd.com>
In-Reply-To: <20250219043724.717663-1-xiang.liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7b554a48-98a6-4a66-8087-0ab446eee9b8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-19T05:03:09Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MN2PR12MB4256:EE_
x-ms-office365-filtering-correlation-id: ed635b64-4246-4c0b-12b6-08dd50a2be51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MGwHC6XxRhb6824oouEr4SK+1saPcL0wZvtL345c42yH+QXdettXZq9gW+rN?=
 =?us-ascii?Q?f5nNDSU1eeUebjoR4Dx6ArYORWtSg7G0vxgZ3dWZbUm8jrAvd9XlwyOQGa8D?=
 =?us-ascii?Q?2tH3WyMHpiqW9PU8C5wSlYnV4gLnntHBGChuyWKRM73q2M46JQKxxaPVP3hh?=
 =?us-ascii?Q?Gq/i6dC7tpraTTaxHNMXAHP0IodpvE/aHkHUBWCsR6IIyPqMCiQ42Zqv0tQi?=
 =?us-ascii?Q?omld6KLsLU9/QCm7OgQUHTTUDjXhSgUpRvvEMx8qMsX1//PwAnUPOz9LYAvM?=
 =?us-ascii?Q?ehIW8d9FEa1prRjZEhW6dMw19JYlw1N2E858NUTCUqDmDvDJ539Rxi6OgmOO?=
 =?us-ascii?Q?l7XOaGW0DRCDt9DoogQ5LTFekMptYSUD9zJJRMSSdlA6S3Dnhq9L7Y7rbHVa?=
 =?us-ascii?Q?d5hJlmfcwDqQY54D6HRWPU6/VddjiI8YHyURPbJisNf2KKSwnEILP3JQDbU1?=
 =?us-ascii?Q?NOgg6f84hVPHN1dPe38MMTqga2NEOILxxJ/xAUFnxHY9FWbeyo0FhfZeBfaW?=
 =?us-ascii?Q?kf0MJH9bryNKm7elC0h+Q9j1x1p1NdcUS4ukRBRkNmeI5dSywI9HURdNrx7q?=
 =?us-ascii?Q?sweCxfbTAcIe2zQ5lQnkktinIPnU4xNCSBDc80OhHNWyWcptIbbd1APNkl7h?=
 =?us-ascii?Q?o507L2IAmV1z8BVIK1EuSaGt53wPsWA2/ojvqQ3/O33rdPJMpQygFZRj7esL?=
 =?us-ascii?Q?Py/vVOe92UoChTKZXbqrI0V/LLf9slBa7WxzoEp5FclSqHcMtsymjh+VCEfx?=
 =?us-ascii?Q?DfPjxKRAGzJj4dTdTUIt1ILPB2OhoP3Ae55g7RqHvt+V3T8lsefmANMBzVt7?=
 =?us-ascii?Q?HblnbYMj5RIPqYbdjbLkhgV6rF4oPJjpg+x809aVTqyz/BGhGl26a9qq4MPP?=
 =?us-ascii?Q?vGX/+x3gXHFY+y5DtQoJG0O+3wJF7Nj1184tz/wqEPaEu3nvym/dwd+X8cph?=
 =?us-ascii?Q?Pa4hg5jD9PNp2ULTmkiPmtT4gGlLLutBnUT+HSw6Ou9mN1h435ser6jR5K+f?=
 =?us-ascii?Q?ZBfjP/aeLn4lIU2cakAa4kdIaeTkA74gFvl7W2qKPUFd0iQieS4boueE15vT?=
 =?us-ascii?Q?mUaHikQs3nVsn+wmtWyziPTmPb2hMNS3ZW+V+RVVYEyWyXpdRAiNI7GkrYy7?=
 =?us-ascii?Q?OuOVOtdaKPTPMEPHIiTwoumsKqw8Nt9Vf5Ri06OkvJjPKuPwOnjpKKzWD+Pw?=
 =?us-ascii?Q?oOI1skDsUV/oOb/4CtZZ9Pk/ynkzV3xtvVt+LnlxaYhpQFU8aBmVf+ZesmMb?=
 =?us-ascii?Q?94aEhkyC2zl1cLUz+ee7Pi+Grpf9DdZeBNo1AdmppxfRMVqMBXPIc4Sf6VpP?=
 =?us-ascii?Q?QnYvPKX+GAoDdLNf2xYw791HQxbBbZUkpdMmW+BH1KePtwLnndJCXD5KVzri?=
 =?us-ascii?Q?qdGfTGFBlR574FMRPJXw01DvCGa7w2jYip3jxZWK0j0IedZG1la5K66kb9Wu?=
 =?us-ascii?Q?jUzyYDRQ/ABGTOBOPI37HvjAuaZ+dfTz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BIQgmHjyvxjrM8s3Xgvkx1Bc4Cm24v5rqcWhO6/KNubWsN8HXDHvOneJYlcz?=
 =?us-ascii?Q?enNcbCkUYC05oHHQnTNFXsA1hmHE24eaYSlgG/YO8sj2PTYYNLKoN6VmTZ51?=
 =?us-ascii?Q?kRST9+zvuWq/1KKzxUG1MrCU8XsXPTxoo+rEI8gdy40Eiu0tlIrOOsTwpjpz?=
 =?us-ascii?Q?WxPONc3H0rh0qMuT7Tt8PqQ3OdkxKokqz8eqMy60Nohb2XzfKlvB1f2HjoVi?=
 =?us-ascii?Q?fuIgw/HPdaZIrT5WpPqEHzUmZpxvadY1kYdivt1CMy/XzZRQlY8s3Wy6kWMZ?=
 =?us-ascii?Q?Dzf9Qf1jtNH4WmdpCveeMiJScYMOIQcG1eLAd8qE71Zm2mFJLgUGIPo8U63z?=
 =?us-ascii?Q?oIqJTaa8GKo9RNjD9a8lzs8+LQKNfpjqN/iWdGKyHEodg6FwRvQPJKyILkiF?=
 =?us-ascii?Q?/MSukj0HA2Xay4LHBJO0D02z14Z8zF4ugf8mY/WYONIuJc9FmaFjXtTYp2fE?=
 =?us-ascii?Q?W/frYvLp4cG8i22kaM3uZQiveO8/zOCzazrnxw7R9ZDZIRtU5iQgNEInNyxe?=
 =?us-ascii?Q?MktBFxY3TFyYQXKAdl8JL+GxnuNfqQdk2EulcIfR9zqR0JiccJ13z/OzkWi6?=
 =?us-ascii?Q?ROajyYfBR0Sr9FAuAZxoR0ur8EerUnM7L8zgwTTHbEFww8hf/kpji+VGQy8e?=
 =?us-ascii?Q?xomwAVpoXMETh/Kj45985NrCoV17yqFlqPzmSbnz9NL0o0NogCjiUEsS2YZZ?=
 =?us-ascii?Q?8gXljtrYumRAgsnYc4fVRFAqgYPnZVLx4kZM8Vzs8JrUecXhpBSYWR3JaZ4Y?=
 =?us-ascii?Q?9eYyxfLEdxBOqVUHerDFWQq3Z4qDMkOkzzjv+x1KAfKNtQenNqjEjNRKJs3I?=
 =?us-ascii?Q?yD6hR9x8Rt8b8JAL0Ga8oy+8FITOmSHVpDGdWKIPplHoiYuUE0PJW3lfaA/U?=
 =?us-ascii?Q?RQPkthKGlwz1AfdLk2AFeQT5pSDGmJhVl2UlBsomtWSEawoT48oy1bJc5CI8?=
 =?us-ascii?Q?7+iCYLCNKQfSmRJSNHEA86XeoCVhQm5176Ifj7VJDjJ6Y1aAPFCtqIDLf3sy?=
 =?us-ascii?Q?O4NXESukrItIzH5cMqJ+gUwdXrcmgWo1fxJwhRqd/59X9bNrmcLo2qDeQh4D?=
 =?us-ascii?Q?TuOBbFIPF31N5OXiKW+09cAbf6JVHe3OPBCkRuLtJN3H2TYgnFNV4oivNqAf?=
 =?us-ascii?Q?BRo03RUop9UI3/qTpX9UoepTxcBWpg+HiN7woTxhEcz5q7SwlWDgHnyXGLr+?=
 =?us-ascii?Q?HVxx41UDgdJf6/i1kYwbpBLu/QWxTjO6WwBGCIRuGCazQTMUyeFO6UXNdfUc?=
 =?us-ascii?Q?FmXjprlY8A0NG1THevE2e/mNkTK4ySYSCP/LM9J3mc8XMBJn356k8kKiR79n?=
 =?us-ascii?Q?SM/ytXrcbXDIUldMI7SUJ5sJpMGQoltyFvoeb1FyDer440LznvdJFfc19PaN?=
 =?us-ascii?Q?kx4JA4ihGoMXJsBcgtlwoov3aJKdt64jtKmWjlRj9UQjIxMjcVGhn7p9MiNA?=
 =?us-ascii?Q?sqFk+Pmw/1zHnlKt+V9pc9qaQ2J5tLGBsSZ6CYxZW0oEUqhLr7S1auln32lB?=
 =?us-ascii?Q?ppq7LfsklF75fcGELlTKZPMV5FlzlaIcfIVh7DsFFmnrPUwL0xM/cJn06JDC?=
 =?us-ascii?Q?7L9cUMQWGdNYUO2PMzc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed635b64-4246-4c0b-12b6-08dd50a2be51
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 05:03:26.3944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t8TZ6i6YaNy9NKXo0xTkLV6cDNqFZiOOaJScPsDyClsRU65HLjJNMZRt3rfi2TxI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Xiang Li=
u
Sent: Wednesday, February 19, 2025 12:37
To: amd-gfx@lists.freedesktop.org
Cc: kees@ijzerbout.nl; Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <=
Tao.Zhou1@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Remove redundant check of adev

There is no need to check adev for sure.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index c0da9096a7fa..d11593cd1922 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -392,7 +392,7 @@ static void aca_banks_generate_cper(struct amdgpu_devic=
e *adev,
        struct aca_bank_node *node;
        struct aca_bank *bank;

-       if (!adev || !banks || !count) {
+       if (!banks || !count) {
                dev_warn(adev->dev, "fail to generate cper records\n");
                return;
        }
--
2.34.1

