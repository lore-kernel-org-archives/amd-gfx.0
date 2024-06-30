Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA820C27C4F
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38BD810E25B;
	Sun, 30 Jun 2024 14:59:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="miqS+Y7V";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B5D10E25B
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:59:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3cTae3ZUp+jWFjl1/JWCdYweh/HZNLPvIxjRttAHMvOwxwiTwGgcwP0UzZACNiE8B2QTJIBJrxZELPYZwK3rGWxs1XN+1wTT7WLgALHAxgPNcGhRPyXaMqjCpGqRmj0iVoK7p2SZ8U2V9tNm6tPm49o2WmxrnepGbg3uDgPy2VWsMXLdx8N5U/5+DkzzplLWuwvm2E8c/NjG6UcHfZp41NlihZ021Ehbjr/b6m/TR/uYe78xDlUrPW+KugEZxFkG4XdYD5czPQt/8JxWAP/HEYRTUSwBfTKUWoWwOez+qpOmzkQRIhjmC6a4sscvunJeuLzTjIN6AszIa6JWOBn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqH8pesA2Irkx5Kd2AC4MIZaAx7OegQHdPYPgpDoigk=;
 b=KyERvLV8p5rqWyoULmjXjVVNey0AVeAVWeMP3ywpQyLdg/RZWRVw5PLKIUxI+qK/Nrn+n5tTSZoGk+MuOhQbN2Bkeomy1unQAP9YosrbDofX+fGdJzfNvfttgep8LjFOg8cBDjnF++ITb2DFXg1dtsPun3nLE/UlwFOgHseFnJTcAocdAocgEJ1XyPE4QuT9vupVqyqtuwxbzlnt2p8iWo5JERQ4FZAoGi0TLKpacu8dg0YxiY5rTnXkHtJRLPJ7Wy5NbYJGKwjwAji2xDcbM++9HL4xhOqhAgP358WxdJ3DdTOpLp/P/pfMDeq0AEu0MwDck2uCWlDkW/wYQStMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqH8pesA2Irkx5Kd2AC4MIZaAx7OegQHdPYPgpDoigk=;
 b=miqS+Y7Vm7mmKq4LEiZQeInuIQzczAu07tcKVVtZaCUfF7VPGlKlmT0miPGuvvjPQdEBVlJc1N3a7bbDBvNrxhVyUJkSaMI75NnO41Cdfy9yeC/JtuKevFwdS4cz8f4IrVC+3mljZWuBdgv9e9QPMaxfvOIg04CJnYM+u/MU43E=
Received: from BYAPR11CA0085.namprd11.prod.outlook.com (2603:10b6:a03:f4::26)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 14:59:23 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::f9) by BYAPR11CA0085.outlook.office365.com
 (2603:10b6:a03:f4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 14:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Sun, 30 Jun 2024 14:59:22 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:59:20 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: add PSP IP v14.0.4 support
Date: Sun, 30 Jun 2024 22:58:25 +0800
Message-ID: <20240630145831.2023399-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: d4696533-d66d-4019-cc7a-08dc99153a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/R8D47VosVAdV9ov773L8gwXxBfAwONyDMQaR1PCupduKTFfI0Wto4LlqMCJ?=
 =?us-ascii?Q?4AAgLkPtdC+z4QZNomPOD/TnDLvRM/HSt8PkHI2U2u2MIGBOQLNg1jOPqV0J?=
 =?us-ascii?Q?7FX5SZMq/zn4abGBh3rG37vUzycOAJBni6rOCXH6Za+bduXAeDAEGRZQbVnu?=
 =?us-ascii?Q?g5SWnzyiW3ggGKRwkeftBiGlTAZdUmWlChhhvRfZntbQfcM7OiVYbpRJ3FkD?=
 =?us-ascii?Q?cjeujrQQ3CEHDXDF9OBjidxGKGmWFwTdomveeg4e25rKrIXvAzn5JAAGUf1B?=
 =?us-ascii?Q?X3nG85fvez1n3M7tbH+Lq969YJNsOOjR0xcYPV69D1w5zQW6UpYeb7047WTR?=
 =?us-ascii?Q?O9oa0n6mnhwOv6wuAg1T4B1ynp6l9jXWvAfk3O1kFSBCqQnEJEeMXKQvMI2/?=
 =?us-ascii?Q?MyupMNuvgiy/uCS0AceH7ooNjn/7NP8foSmjizFqeE5axLEQgUQRCvcMB0K8?=
 =?us-ascii?Q?vmv9vanY0T30CpDg1Oo4k2sAV9+nosdP8FceUxgk/e91TH/HDAUqO7nUNerm?=
 =?us-ascii?Q?q4QAZEBkkEHSRNF9rwnyvYU+QDvrYauAQWBjMAiuslQmMyI7s5cy91BEsB1a?=
 =?us-ascii?Q?Jcpj1XTTZq2v8nHwl2cWoICpXJzQRVV33DhfuhohoJWpVpoVvyDO5K0PrX3G?=
 =?us-ascii?Q?E/121v+P0i/Ph6MPWoFRQ+MSWkT4Tj29yqtB/aGT3HxHpvIRzYD2s7eVJpy7?=
 =?us-ascii?Q?MbLDPhvCX1he712gNKHz4R6Ts6VwpTNI5U5BBDfeJEc4w62tCmXqrP+JlFDs?=
 =?us-ascii?Q?wyKJEDb05c4MWnuj/GB4xjsHpUZZNf/nRb9hGGJNcHYLkVAFFxgose/GjsCN?=
 =?us-ascii?Q?RrFHTqmw0W0yQOvgurTnn3pGhrHaf7BSFcQdBiJMxCmGnbVrB2390V9cwf7e?=
 =?us-ascii?Q?3FE/mwKw3R5CaAW2cZOOT9vV7+vVL6JmSh1DY42f98w069BBjovunZVDfpfm?=
 =?us-ascii?Q?P+zQMRMhRvDH5/1YgVTmo+9ErKMTWGDnSDw0pVog9/S5AW1gXwVwTCb2o31D?=
 =?us-ascii?Q?ac6ayT4mCYRLTWENcmfkgeEx1lbSGLgxn0dGzLm6L7NUHtWSzhkLnmDR4QJa?=
 =?us-ascii?Q?Few/DrZXu8AuIU1gdkNbO+6peMuqV8CjX35gwDWtjRIWdh60d1m22YVC/8DU?=
 =?us-ascii?Q?QdpYfYUn9OhJPUS9UmfWGKwRTAMSu9i5SOgHkRh9ktcuswpDu6h6i2HVRaH5?=
 =?us-ascii?Q?7hgm8Gux1+0G1PaJav87TMtZ3fRUUusKo8r6fa3n7aS2ZyiuCpEVqpQUh2Ue?=
 =?us-ascii?Q?RH2VDrZNOA0BRpdv4qeNUZ8oA1U6asibYOxakWkLqfawSzIUSjzcY8EoBbeY?=
 =?us-ascii?Q?0DcgELsfvKNhEcPNxLUTOLqSWPifZ6jNCUDW5f69yMvpySxqyobDan57ipAX?=
 =?us-ascii?Q?u3SpFADpQTKA3pcQOxr+8cYSGgIO5B3iUqKBDne5rgGOBsQ/RDhH+xQc5TIT?=
 =?us-ascii?Q?r1RwPfseWy6Xu6XHRh9ETsyCxlqq84X2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:59:22.6705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4696533-d66d-4019-cc7a-08dc99153a21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682
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

This patch is to add PSP 14.0.4 support.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e15814d9ca17..800cc7a148b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -219,6 +219,7 @@ static int psp_early_init(void *handle)
 	case IP_VERSION(13, 0, 11):
 	case IP_VERSION(14, 0, 0):
 	case IP_VERSION(14, 0, 1):
+	case IP_VERSION(14, 0, 4):
 		psp_v13_0_set_psp_funcs(psp);
 		psp->boot_time_tmr = false;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index b52e15e2dcc7..407477b895d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -106,6 +106,7 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(13, 0, 11):
 	case IP_VERSION(14, 0, 0):
 	case IP_VERSION(14, 0, 1):
+	case IP_VERSION(14, 0, 4):
 		err = psp_init_toc_microcode(psp, ucode_prefix);
 		if (err)
 			return err;
-- 
2.43.0

