Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74631C98302
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 16:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1548E10E64E;
	Tue, 22 Sep 2026 16:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gJWQlln7";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 004C710E64E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 16:21:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Om0a88WruB4m39uAdRO1R+WBmEwwUml8unOKBXLg0JgUOjNY9FJpEQhOelMsbMupmGaKwGvfevmqjZEDJd405XqBIcQ3q+LlYfO+8TkbbRvpYjg46nrwVCIeyLcB+eo0TH0p3DF837QrNEY514qN6J6MB5sNcRbqA6+9iwPbKWma2pco1Yyh2EGDDEB+VsJ8K9ZQv26T4M4pRWPzfT/OvA1N/Xlwul1+OCjMXmA0AXUdGfG280TgaU+Kjs0fE3pTDq70A2CEaxNQCtbgestjqeUQaurpv0K7ipZHp0DQKuw6CmWKe5kdUsmQ8QcswI2UNYgoUcMNSpS+OctoR3zo4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hg7lIu46lPYSTb4w5gbeHheFjzLVUqwu+SGp+J20uRc=;
 b=oPd2XATCHiihqoJeBzpwckSFofBw6rNuSRVLgcE5znhS0ciBl1IBTd/jb7PAlNt/5h/O8MleWhRsId83wyXfuXtXQjdF5UqEIMuB+bOubOqTHFR/8XBZndWJS5qcux7+34W23MLMmFiUM3d3oEA5cPBpfXnuK+RFA0mrFk4qETsot+ou+0coXgtI7PbgWyDXmlsac0jHM5Vl1xhsAVXMCzzvVGzh86+R2tBdxdCU8CRXYJ8xpvk0mpm/wlHM8PNkXrQyz2UuJEgdVC79v/JQK/Fb3lXgTJtf6RdNyxbrCv71qby9sZv6SDPGvbnxIqiNMgpihGvpJB3OvlBgDUvvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hg7lIu46lPYSTb4w5gbeHheFjzLVUqwu+SGp+J20uRc=;
 b=gJWQlln7lgxhhjYNX2xv5sW79wqVqUR69y07c0G67YMo34eQEVbsneuCV8kj3c58A9Xka/B7gErGjb3940mf9S5iMVLP2cTl5qBofRPikSZnO0vuOXCb+5c00hSavaWXyu75iZSO5rb76/4QQcVQp76lrWzYdWF7WB4lnWSMxgA=
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) by DSAPR12MB024644.namprd12.prod.outlook.com
 (2603:10b6:8:51b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 16:20:59 +0000
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6]) by BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 16:20:59 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Horatio"
 <Hongkun.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop userq callback assignment for sdma 7.1
Thread-Topic: [PATCH] drm/amdgpu: drop userq callback assignment for sdma 7.1
Thread-Index: AQHdSq2mYpEWsH03YE+4yjcWqUN01bbaxz/A
Date: Tue, 22 Sep 2026 16:20:59 +0000
Message-ID: <BN7PPFFF39339DDE55A619EF4BF106D952BFC832@BN7PPFFF39339DD.namprd12.prod.outlook.com>
References: <20260922161529.2179060-1-alexander.deucher@amd.com>
In-Reply-To: <20260922161529.2179060-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-22T16:20:37.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PPFFF39339DD:EE_|DSAPR12MB024644:EE_
x-ms-office365-filtering-correlation-id: ce5dae6d-63e9-4b4f-4d4d-08df18c57cfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|7136999003|11062099010|22082099003|18002099003|38070700021|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info: r1xkpkuTxVZi+aCovgw91ZCVUsKTiJttJGn4KLVCfO5FW/EQrPV5/LNZyuwyGB7ePdOSalr+LeT6WZzg5/L2UhHBY12kRz3Y5vXzfy4Bgzh5/lv0Qs2vaGayyRdXZJZtv4/d2Jw0SfB+95U71Y5wyy1mgtnEiJxCy6PVKo8vrI5ZXMFakJXUk3RvHnI3RSR13IPx5vZt8/8kgpCpxY2nt498NJ6/zucUnFx4DtT93DXElFzJjq8UE19+Y2ENm39N1dNz9+HJ0TdmtTjbxkMDJ0Pt/r5gFvr8gAmp906qiYZRGgBe49zK58CiR71Sbn2e0yjmhmno10zKoQ4iqL3kn+uA7E5G73IWRn+Ngq5a3vKi2MolEcsFhIXLeT0nM8oApXYJxNVkHuxyX0nQBnp3KPK0tcQx7ZWYu0fmNqnEtrzHSwnMxQl/d66rR0Egc5CkbBexIy2sCNkAITAyqc2LH+OIAwtsm2u8ZCKTRnoPEzwApYnG2CVHI7odj4Eh49ncIujTHBsByCQBktEmYUm5x+dvsCTDg8X03jzKpBjiP77s8E8siHkIdc8ysAzx0R206EH+QL8d7/wil09eZeXfapWXvOL0l7HmgVTjS9C6G8+5/Y6VOrtDywBWIXXEwkrLuHMWHcNTGCMqVFfWaa/id6pzNB1j8bs3QQIXIg2REPO7Nvzqwm9dMWf5HvUlZEPuOd84lFBFLQDU5kMoUKsUoP1tXEfrRHJ4dd233kjnMP4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPFFF39339DD.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(7136999003)(11062099010)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6hWJ0+BaBiQI4vNL6f6ES3whwfoUr89nFIyRr2eTKsjtdYth5QHc4WZg2TRB?=
 =?us-ascii?Q?qsy0sh4kNfygE1CdBTAbIyoF2sfMvHVXtYW9xqgwZlDPsKIfTr45MI7PcsD9?=
 =?us-ascii?Q?72lfSvRN+zi33bJhWxy3LIWVhjozhR4bypFJywMVcmqiUqPfHr/wzJ2lzh0A?=
 =?us-ascii?Q?urdXu0YpksYM7mdEQJdNmkHss99sdF92s6pwwZ2tntS+Ngy640ZJVkMf+cn9?=
 =?us-ascii?Q?/qulXIdUpMJiU8MW7BmZfcSSnsAYzzPhkZhIPanJqjQLdCQv/FI6lcZkOQTo?=
 =?us-ascii?Q?83fd9dSInl8LucfMaOMe/JveHPcU41/MsyGE6QgIfN+7TPPlyOfqzLepSyLS?=
 =?us-ascii?Q?YUUlrXaJS6hsdmtkXWWtOX/tEWXuyQfy0xmy/vmGFTaOZDQkPboXf7LVr69x?=
 =?us-ascii?Q?BtfXQ266RRQRSqKfF4AJsHhcYppaRhRIxAZxHQnx8A78bEm2JSwfRaRGnIqo?=
 =?us-ascii?Q?/nkiGTHz5FhekDf0/5LwwG3W+ttimb+orM6evG/qeb9SQ9zm17cOdBo3Tz5b?=
 =?us-ascii?Q?mkAZ3h+dLF+6hUuVJsUrK54nwWRL5EHVsa1S3YVpQq79utDBF8GHPEbDzU+l?=
 =?us-ascii?Q?MkvU/bAqH84huGaCtDncQM8skYf/WcGho5tecvjov24z2gxKWCP0Bp8BEXr4?=
 =?us-ascii?Q?01mvuUP55CxxYngBdOb8BcZYK+8CZr3qAHd5zekDa/HhCdL/NQX4O6gKnlrd?=
 =?us-ascii?Q?efMe1tyG5pZKL1F1XABROh4TXXSjewBk+MASYJUTw6+IJdmBD819dVCt69DL?=
 =?us-ascii?Q?3tA0Ty1G9QsiBL2lEz6ALMf3nkwG2UluKgeEz7VUh7m342HE3kh7lVdO2olR?=
 =?us-ascii?Q?n3PCugL0ojSI+fMUA2F1wpH2xmJylBwbZgGuNWrX/n9AkrXZ0Ql3j95M6p6x?=
 =?us-ascii?Q?AAWS9mdZNS13ZykTRyq+M4n565TNgKkaMkX4BcH/Q8VXTHkVYG6DgsgMeShY?=
 =?us-ascii?Q?cUQPU6MbJKcgQ0hlhyI3Ssp80y6VxMSeaI1bCq6OYIUXcN2UWyYPOEE9nf0r?=
 =?us-ascii?Q?GZfkoBpEbv5P2lxJrV+phc797+6wfic3fsy6bwLJx/kC8dsjWYsXre4DUzlD?=
 =?us-ascii?Q?5sPuB5H2U4IU154eo6lVJwBs6YFG8KC53fJUxEYeav50p8TaPBbyhN3Xq/qQ?=
 =?us-ascii?Q?hF8QPMF/Qpa9CwkwZQPJglb1uYd7IHL1y36bXTJnlNvyk+ouqym0IYQh/EHc?=
 =?us-ascii?Q?Pn8M7O/pToXJrM9KRPYDzWdxDO3iuDcjYmq+kl3f/B4mjJ0naIXrY/LSC+N1?=
 =?us-ascii?Q?11+qYqoseNVzfrfMXMq2rYdliIZKrDw75VqIXUdf+1eeGxuT9RYvwbpQsLJd?=
 =?us-ascii?Q?m9BWArjcUdD8rSQS5o6Xxk0+sSvl/sKGUrkOQaXEMUzNbcOj87AurYFMdL15?=
 =?us-ascii?Q?WI8tburuMmxvYMH01+OEzBJ5c0qcH5CBlEvqPm4mHuZOGbO8s9OiUpbjOaqU?=
 =?us-ascii?Q?dTFwYcGB6ap9vDHN8AGpeAxU9WXs5A47Zg8dLwVJpPQeG1TmBufZ9iVrGWIP?=
 =?us-ascii?Q?vRU473StdBABymyTIW4+jmxdtQeRyHo8uWpLw4jWPbYmu25954xog5h8088j?=
 =?us-ascii?Q?HdRWHXv0AVowtJZJIKH4xoZ480tJKBmQyDFmDdDluNVTDN3VjLEYs0Ag3jKh?=
 =?us-ascii?Q?pGleIaAfKKSOr/ZeFQ2E25FK1M1MRCl5kQlkTsxDiFAT9BlFHvzdKT+5rrSB?=
 =?us-ascii?Q?JEJJpoqts73kA0+YM1InbJ8hc4ONBSwCGqxj+TYtFfXhCb82?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PPFFF39339DD.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5dae6d-63e9-4b4f-4d4d-08df18c57cfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 16:20:59.4142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1dCptTcdGmtdVqv8saamb9SLUYPrGp1luY9/w8A9XechT32wfc3+EfXMcdm+i9TNtXj3GiGACdWDptBHkx+UGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSAPR12MB024644
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Alex Deucher <alexander.deucher@amd.com>
Sent: Tuesday, September 22, 2026 12:15 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Horatio <Hongkun=
.Zhang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: drop userq callback assignment for sdma 7.1

Not enabled in 7.1 so drop the assignment.

Cc: Horatio Zhang <hongkun.zhang@amd.com>
Cc: Hawking.Zhang@amd.com
Fixes: 4ed5116aacf6 ("drm/amdgpu: Add sdma v7_1_0 support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v7_1.c
index fcbab7f05d08c..4a4382f2b7562 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -1347,10 +1347,6 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block =
*ip_block)
        else
                DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");

-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
-       adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_funcs;
-#endif
-
        return r;
 }

--
2.55.0

