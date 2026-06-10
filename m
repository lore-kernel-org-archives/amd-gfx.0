Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A1ACD8C90
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 18:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B9A110E6D5;
	Wed, 10 Jun 2026 18:23:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xg8wNVqu";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013069.outbound.protection.outlook.com
 [40.107.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8CBC10E6EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 18:23:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQnnxQ2hrWXYhu+7EnbjxhYDskbttKzaQup3KYXwkYizWI8Sp6EYwdFYbtMeX/xMvZKccDTUQznIb7AW0o4v5+0y/y/kZtIbYX3l8p9ERnC8AeEkSF4NFiyByicXWsu+tmf1kxMRGpGVzlHpdgOprLMjMRk714Jeat+3s/JvOkAAQjwSv6iONpEnbrEACugwUrKFqF0bJhBxdMI/Svub/dWXdWKOnLhUFGXjswS1fGojNEYwb9GkcW4cFZUoMSAlr3dmZq8EP3aQyEqh/sMxg/TpdzEMZHdHHC4KxlbqB3/pr7b2YSK43EA2AxsyS1edRU39EQmKszCB6D3gJSjfhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HlV7clsavtkUG91LVjFLEbbazeEJNj/CIq4N7XdKHA=;
 b=M0yNpsvb8kRfQQ+c5l2lI79KGdAoHpeb7moI7bXx2lSLIrqgbEzbMZUFepAcsTtLEBzB3mIA0TiQBe591xMNNgcwfeQsalXnYDEZT0K6I+Hp4uk9ORz27HSPCWQYKOyinmQU3p4j7tC+D1+vqOnDQAyXm0Ha8znrqBvNp8vDD1ov1C3H9g1oSfgTI0a4R9651rRtKqPoNd/8OMw8vXvR7LC902I+cEw5kQdDN2EzbqCroI5PriQx9ovIx2bS2s81IImt14kiTgLbB/jOW/6xDhdHIBagTbzVx0ggBQuwL3rkKAzm0RzfQFsdbJvj7nASxTxnECrD4Ejfx2UOuDItZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HlV7clsavtkUG91LVjFLEbbazeEJNj/CIq4N7XdKHA=;
 b=xg8wNVqu0GVUGQ6jnaIhkF0a2GPKW3qw2rMnkQ+Pq1LOI9h5+rkXcsPmLSpTeLTT/uqi6bjR4LnM3aFGhq5wCE6h0FtS+81geZWplkV4CcRIpieL5M3402Ir9tMwRosu20IPeC3/bYieDAydt0kNb7OnZ4aGgHjJNf62dF/rHKo=
Received: from CH3P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::19)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Wed, 10 Jun 2026
 18:23:43 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::aa) by CH3P221CA0009.outlook.office365.com
 (2603:10b6:610:1e7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Wed,
 10 Jun 2026 18:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 18:23:43 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 13:23:42 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 13:23:40 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v2 2/4] drm/amd/pm: add IP_VERSION(11, 5,
 1) to vclk/dclk DPM sysfs whitelists
Date: Wed, 10 Jun 2026 23:53:31 +0530
Message-ID: <20260610182333.3922-3-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610182333.3922-1-Priya.Hosur@amd.com>
References: <20260610182333.3922-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 179ae269-c912-4161-55b7-08dec71d673e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|56012099006|18002099003|11063799006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: FQIBFiN/D/sZ7PRxYmYXC4jeeMh06bruGsEjrXLjajaSqbPVJPYJ0+lVwAlotzBF6u+piWbQCGh00bxSlTcF72b9tBfgxfHcwl3TUiN/vEyxAFh9/KST8UVa7vN5mNqotaVzraebWi63TWi6dWvEy+M+nFs+wNwEJNUUTm+RUjjDarc1slOVdVFGErZQmtqcZkUhSmSEMm5G0/cuGmDaz21xsXUwCKIfKMCFji8nY66oD0vzyNW7XFLCCjbz5mLjDhFEnsabhn3TbxZQZenZB0qCTdqFk602hf9QqXtYKUVraAsltsCilPD5A7eP8O+fNIE9mEgVON0eoLFPzlipCfpzAY/e7Pe1e3dRH9VnFSQSn+uHyPQnN0hs3M0agTMvkbxP8LbyUDWPm1C0sx9LdoqOm687hFvU1OpAvONoidf3VnuS5SI7hZbSChzPQC1YsOJfrmIDm0cxr/L1KqsjVNY86n1vHyeLhZVlcFRppjIW4RNbAMbvJHyMlYuM5enJLvZaQ9mRLA/flzam5XcaJlZGuDOgojRHRRB5Bz5o6mGidfmahjUuLWX6URTtKmK3AhPD4pk8wNSHGoHFXK2lHu55R9cdcbglTz8/sjGCs1yWHXr+iblp7hkvfF3qpfmmVRpeLxvS0gRBb3vjT/ir9dRW6kGzNef1+ZAin9ahm7reJxSAU1ASPHH8/Z49wEz0UQvH7eb7/B1iQleVpxU+XMR1f2MLARz867oMoWT0k9I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(56012099006)(18002099003)(11063799006)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v1IPB/5bk4gmDr0E5jjsEJh/z4kRwd0Jo6qocIgPk5yjTgYtWP2ZKG+GuZeaZcI0VuhCeQmjH1JIw7Ck7zuN3ay0jqy7AQAFlp5GkUjemhnFM6V7NsrU5E5K4nEAcq0F98gDEF+wfVb0nn51DSFwB+VugFLkRDbjBDjWS6wD30Itz+Bt0lA8I06jWbI+9j98Fya9Zz8Q0PKut41jG44zbxMksPkB8oLz1Ff+X41nivosxyP4BLCXQ+J3xrq7S0ssam2yWI3/XoatjotuHo8l4X0gD+XpzfiR4hNDAXWcu8ZoUU8srVlBVZ/PoOdP/+VFF+n1CgE0gn1zzdMZfYb72XHSvGt3l1/YarHg88HBtOBA+8Gn5hNVKQ//7LJR2HxkCzDQqVqikfQk07HSX2ySK05QqwdEHcrj10bRezukDwDDxaF3AcpKaaNr8HsXHGag
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 18:23:43.2776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 179ae269-c912-4161-55b7-08dec71d673e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836
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

Add IP_VERSION(11,5,1) to pp_dpm_vclk and pp_dpm_dclk visibility
whitelists so these sysfs entries are exposed on Strix Halo (GC
11.5.1). Add IP_VERSION(11,5,1) to pp_dpm_vclk1 and pp_dpm_dclk1
whitelists with the existing num_vcn_inst >= 2 guard since Strix
Halo has two VCN instances.

Without this, amd-smi reports N/A for VCLK0, VCLK1, DCLK0 and
DCLK1 clocks.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index dfebe67c164d..305852f5b153 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2027,6 +2027,7 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		      gc_ver == IP_VERSION(11, 0, 1) ||
 		      gc_ver == IP_VERSION(11, 0, 4) ||
 		      gc_ver == IP_VERSION(11, 5, 0) ||
+		      gc_ver == IP_VERSION(11, 5, 1) ||
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3) ||
 		      amdgpu_is_multi_aid(adev)))
@@ -2035,7 +2036,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
 		       gc_ver == IP_VERSION(10, 3, 0) ||
 		       gc_ver == IP_VERSION(11, 0, 2) ||
-		       gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
+		       gc_ver == IP_VERSION(11, 0, 3) ||
+		       gc_ver == IP_VERSION(11, 5, 1)) && adev->vcn.num_vcn_inst >= 2))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
@@ -2048,6 +2050,7 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		      gc_ver == IP_VERSION(11, 0, 1) ||
 		      gc_ver == IP_VERSION(11, 0, 4) ||
 		      gc_ver == IP_VERSION(11, 5, 0) ||
+		      gc_ver == IP_VERSION(11, 5, 1) ||
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3) ||
 		      amdgpu_is_multi_aid(adev)))
@@ -2056,7 +2059,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
 		       gc_ver == IP_VERSION(10, 3, 0) ||
 		       gc_ver == IP_VERSION(11, 0, 2) ||
-		       gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
+		       gc_ver == IP_VERSION(11, 0, 3) ||
+		       gc_ver == IP_VERSION(11, 5, 1)) && adev->vcn.num_vcn_inst >= 2))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
 		if (amdgpu_is_multi_aid(adev))
-- 
2.43.0

