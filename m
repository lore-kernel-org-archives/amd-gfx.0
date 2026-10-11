Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EC8CA9EC7
	for <amd-gfx@archiver.kernel.org>; Sun, 11 Oct 2026 12:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 562BE10E012;
	Sun, 11 Oct 2026 12:53:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SDqmgpsw";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010062.outbound.protection.outlook.com
 [52.101.193.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B3F710E012
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Oct 2026 12:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiNWayxY5REeOdV+0SsvUaGnU8vuoqAaceNT2oDd5GxFFBeT7N8qu4L1VIb9aDZCc4ntm5wnHFA3rGrmmbzw0QHzj3sBa8rXN33fOnq/s53sOK1W7jcZ0LOuU8NITM2ijVD7sWuKA50xbbA044PwJ57pSydszgaKiv1EofdsLdRQwCtAixbnkAWu5OXBkmc3klg/kckuaiM3YmizCaMt3zq4RXE6KrSOgylBEX0Kdm+cTIn8sdd4tMu90FyCM0llSbYh38OHIJQuie+ZhvVNEMQ7VO6EULpngHtnRreJxZTCwY0POg1I9Ex9ID2BJnRP2U1MSL3xx4qz57acyLzD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5on3dk11BhPFX1szZxyvV+HHlp6Mdx0t1MhI6uyatpI=;
 b=SKFXyI5BYBMVU+njhn3sGJSjpm5Vka8q0JyJl4V7jrYjXQzaiUBsb0vIFRjRl8XVDithRLn4W3SDlFj+cxk4mPD8YJoil95ZT7+YjZAwcQ74zyKB3vbS0rwX3/Adsrfj6aHUbJRGoWTO47/m412GnSybreSs45+NFubH//3pP3t7EBFOpDlCKqoVQ3zqDN2EWyGffehHRF0o/YWqjtCGABid2/W6X627BFLdvxg/Cv2dunwiNReutimh2Dcgjgnj1x697QB/oTHbWEslgpKLb5yiDnC+Gobm1xAqUFXZXsqciIyJSGz9obcIn0NRbfY4/Faz0AcYopRAPJstYZFuQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5on3dk11BhPFX1szZxyvV+HHlp6Mdx0t1MhI6uyatpI=;
 b=SDqmgpswyZSKsBbgIqxN+MkafUetdwbsEook5G18Zl2oTf2bRJcUUVkjs0aNdFSsdIfwyycnTMxHCC7NgxauzDhAbyF99yJ906vfAcU8a/8EcWUNQ/8gAnyFHI0OZ7Vor+gVi9S4cz5dzVaM9mxYOOWOfltRFYpLSxtc+tfKBmM=
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) by DS2PR12MB9821.namprd12.prod.outlook.com
 (2603:10b6:8:270::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 12:52:03 +0000
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6]) by BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6%4]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 12:52:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: move smu_feature_init to smu_early_init
Thread-Topic: [PATCH] drm/amd/pm: move smu_feature_init to smu_early_init
Thread-Index: AQHdWMliRu/XFpcEWU2fvW+KBqDtUrb4TPLg
Date: Sun, 11 Oct 2026 12:52:03 +0000
Message-ID: <BN7PPFFF39339DDDB83D00AC9581002ECE3FC902@BN7PPFFF39339DD.namprd12.prod.outlook.com>
References: <20261010150930.212730-1-cesun102@amd.com>
In-Reply-To: <20261010150930.212730-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-11T12:51:40.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PPFFF39339DD:EE_|DS2PR12MB9821:EE_
x-ms-office365-filtering-correlation-id: 29362710-3de5-4be4-79bf-08df279672f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|38070700021|11063799006|261009223027099003|56012099006;
x-microsoft-antispam-message-info: fQ3HT0/3ElylNW2liEYaSeXtHdJfdMWmtd3Kh/2S0p4xp7vtsl/7pHXU6nHSKEhEkZ7dchwx6pNAVYAWPnaFxJHi1IAlX7+ImsA8EbLPtKJgtzTRXL9Z80kgUHIWqH/CCj4YU++bvJ6KjUsJK11P2qkfXNCeUnQe2hT6ZX7hkSXft/umM4s6DdPQBiNE9PxSDTrwmiP+0AGLryGDiNcnaL0aFfUXtaawthkO0NNcxw3WKnsCdeUBAbV/r0J0S/bqfmwhnjn87dezEMcpKrbGQsQuY4P/35BM6NFEXrw24ckxyLjp9lW/vSUtV8MP/PdK+hqmL0rzk/dqiBPeLGqpyBs7smnu7HFANdg9TB7OHlMl5TJqMNpTQbjVdQqntLd8GadC+Vg0zN6GMx4cpt49Tds7yMgJH4ulfTyMElIhkiQBhQASBmG2LVKkyFPOmRdKojSnaaNP4/V320FgTpbxvV+wipVp1oU60M1qO5SMxJP/nGO1xsQSKO1H2W5ya8Fm+zGAnC8MvySvQ3lqpDpY88pZTWkRGRgPjGA+llhs4eqON3QmTXErwxM3v4DxwVbNs1URM58LSBJ9WN4XXtPyrX4hmpb4vnoSZwknLcemBpdKSfTZ4YVJOwgS+XIuA8U3xn36gkJeaHcdUSZMMHeyaPt6fPQLOjDB3VfMUiqAvmKvBkl1MeWiP71/uXlq3df4kjHbWnyICbE0Jb8Rzd9mPs0Sf21b8yPNwr4tZCj/ThI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPFFF39339DD.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(38070700021)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JqkM4gP6cnRlX3FuWFHQQ2w1pipVvBb93gwRIrdXduu3ys6Ojc5H6K5aiBb2?=
 =?us-ascii?Q?mA68s2uWpwHgIFoSsWOrQcxCB8GrachqsrCGKVKgVa0ghYI+lAJm4QvuZywW?=
 =?us-ascii?Q?Os3hZ/p0+A5jixbw07gPB+AnMe0YtIOaVcVyg0nXQ4/PjxoqOnoGxukvsXvo?=
 =?us-ascii?Q?qarWMWRSGvfYqUKkL2u2kiS/v8wHrfw9cHXKiP8V4atoDxai3aG/M4o750ek?=
 =?us-ascii?Q?PEm2ci6OeEm3npwBroiBDpP0UWtD7ZtsOuPYOP5Qu4h+XYQtHhED3Yz4o5kR?=
 =?us-ascii?Q?bNq11+htzJWocZYIRHT4JS55ntYbfpQHjC57E9Q/uxGDUVkIo3VpbBcqDGRx?=
 =?us-ascii?Q?8JOiB7XMYlxNdrXQTjwHTS95ianwUzHtLDoe3M+H7QO9bGxFPN7gSuo+XncM?=
 =?us-ascii?Q?ECwdSizVv18izZcPbrKhFB0hCX1izBn+grPKEfMPm56tFvar9AR8OukgBvf1?=
 =?us-ascii?Q?yJfJKJ/DX5uHGe+9fzxEzh7uFD/BEc60j9Hp1yHFfoNblmVBrDVIT2/RE7NT?=
 =?us-ascii?Q?+0wOX6FwhToCKH64kXboof55KqzefuJnZkV3CdKPeNNsxtIkfJVOLrBJEqOD?=
 =?us-ascii?Q?Xf6iseVzYCPWvW4vKJkKAEcvKVmZ/lvACCro/5bOAenkfKHvd86fCGYN0y9L?=
 =?us-ascii?Q?PwCqcaUnkAhbmb4GpmZTm7cStYInMqNiljzpBdf4I/kV+wYGUZpvjvTwvv5g?=
 =?us-ascii?Q?jDKYoibRylfmvmZbj1imvHrd7IStlODrUltVL5pgx/tl5ZocF4Me09E9edYI?=
 =?us-ascii?Q?RsU9pZiWBKamA8IiJlzsBVMLoKnEH1p6e+J63mBbf2PK3Nxbz2DP7jxzvUpL?=
 =?us-ascii?Q?wBxWBs1ypwGFlVzsaITBbSMV23v0DvUF0BMLhReRZKSXbbVHOGZm1lm+iyHw?=
 =?us-ascii?Q?k4OhijOIs3+UnrV95TUsVoH32kW9fFvWlSGPc098KanTxvVmewpNr13QODpR?=
 =?us-ascii?Q?Plgj94hc1TaxiydJPgqu7YBFQHSjpnqpbExlmCP88m1QlTpCDtv1wutGxJmP?=
 =?us-ascii?Q?dHsjxOlHApDXjFgQsjrlUTW1QrnnKFz9FdSVn7joPxXUg9heSOn2SHKf2JKW?=
 =?us-ascii?Q?aVwkUARoBRzqQGuGWEIaDuqlOIfujcM1SqgcFefHXAEtV4aWhnLLjcxE9qkb?=
 =?us-ascii?Q?cDDpOF/mmKeQB+2YO9Lh09spS5NGp14+wtkBieU5xz+D7H8z1iLePErWvWZt?=
 =?us-ascii?Q?X0aDsHSWaR2ayRXBD4qI0leC+N1DxVVqkPvAJV/7sppTqFcnsOOBCW4dx66A?=
 =?us-ascii?Q?C5xThVCBVPnT8dlvV9gvs9U6Q1fCAzCSbS3j71htLL7XMS65mnf2f8Dr11Mb?=
 =?us-ascii?Q?zVJtY5TYnYLRtxRNvXDphROVtsPhV1iTcBDZ7FaLoZrPvvGHQmQDcW43LJdY?=
 =?us-ascii?Q?yBz9ZMOa98sFsWtjz21/M9/CrYqLX7/QeTVvJ55zF815Mxjv4Sw3hZFq94Zg?=
 =?us-ascii?Q?/PjJXBExA3Mqf8PsWp3Z8hZwrOy/FkRRvEegBiZujgFWerUq7kqie8J2S10V?=
 =?us-ascii?Q?243lw+8lAnEzNZjsGl6hY5kgza5TcZruvLoSIkXHcKovWIhRgAgBwoJZv+qL?=
 =?us-ascii?Q?K7z/FpPGVYae9h8/K+yiCfOfDMObyFjiI+9rdAKcWNHFywTvngakRnLABgVq?=
 =?us-ascii?Q?t6U1SUW3ML1yU03KdLV11fjjSeF45f+JOqOa5MB6Z0YZa3yQfFJYpqxvoM5a?=
 =?us-ascii?Q?XT7ghBr09WvVB1kglMWR8djhIcAT1fDvDuTO9g511HA2ISrX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PPFFF39339DD.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29362710-3de5-4be4-79bf-08df279672f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2026 12:52:03.7200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sfdtyZfakL3DSBSGDr5cGRvwlmEfegFKt8Yh7fyvnu8+hcDs/iKq2JqJJZurRbOxFPTHeKTF/76sTYM9gMG1NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9821
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
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Saturday, October 10, 2026 11:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amd/pm: move smu_feature_init to smu_early_init

RAS early init executes prior to smu_sw_init, leaving feature_num as 0 and =
triggering invalid bitmap operations.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 44b2e8d8b956..9e9c1621b21e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -884,6 +884,9 @@ static int smu_early_init(struct amdgpu_ip_block *ip_bl=
ock)
        r =3D smu_set_funcs(adev);
        if (r)
                return r;
+
+       smu_feature_init(smu, SMU_FEATURE_NUM_DEFAULT);
+
        return smu_init_microcode(smu);
 }

@@ -1417,7 +1420,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_blo=
ck)
        int i, ret;

        smu->pool_size =3D adev->pm.smu_prv_buffer_size;
-       smu_feature_init(smu, SMU_FEATURE_NUM_DEFAULT);

        INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_wor=
k_fn);
        INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
--
2.34.1

