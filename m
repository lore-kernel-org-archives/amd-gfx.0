Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA152CA0EE0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Aug 2025 04:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A0210E960;
	Fri, 15 Aug 2025 04:09:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YSHMNpRn";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A83DC10E956
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Aug 2025 04:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5i4m2Gn2rPrGXN+OHC3bqbuP6zo7cYJlDB5lPZ54uNtxwRbLFXNVPRImvd7Szk1WwPyOLjVbfMAngG5aeRHa0irlUrn/SN8B8whQJRhAKBjyYxBdCKbOENT7TOYDyD1tJAGHeDfHGfXhJuyI/VgPvZ/6wIml5cZkQAWUvghwVwWRqjhelG0PCk3w1EDZuD/+tgOUp28qFZIu8+Bn4Nmg8waeQP0FyECrq2RNcblje2gjIhDLxRZjXvsolrbWW3khEtX18IWF9lzSEmbrJVQAoLbaN8BJNnZNsfYF4DKD9o3mnYFJ+McE9xA8XyhDFX0ueRPi7Cfer9jS7aJ79QtbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UB2OrUGagddj7XD0uVyaJCo4AiBSsZtTV+uH6YSIa4o=;
 b=opClslXYcHd4iM4Y86sCaEQOq/DIGZo1zw8tya+GJBQVpNSrgT4RbsVu2R2KffWg0E8Dj7F++z16JmaaUDkoIYxtsoDs5d48SoDOjkF0s+jSUNAROvOxHXQTipVRaEIIApEHkFogkqmWNiHGH9IMnIb+cCM4IFpO/i7kkw1w/IpPojd4j3ig+G2J5653K18RbmQ9KiAZEZy+3GSK5nbYUHCtcQQUR05sv+44lZW73MtMgdRhHJa6E8S1vVP7tSwnUoG1xxxCDZFaBxHQ9avoYEFVr92+W1qFtedYpodNuIll2g6fMfF4L3U+d3xGqRNaZFbnOnd0R2Ogviby9+YB6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UB2OrUGagddj7XD0uVyaJCo4AiBSsZtTV+uH6YSIa4o=;
 b=YSHMNpRnOuuhYJloCV1EoQ57OkdQUA9YNticojvgtwuKsHdoTMUeX/t/ZF25BxP+E8912Mwscc6thkNi3K4HhZEpsmEBuAQvLEvQgIBfeLAgyMQoG+ohNXOLYOuWbKPk18RrrEr6bTO3R+fw2uDbHHfTruedOCbQW7qNRgaCagM=
Received: from BY5PR13CA0036.namprd13.prod.outlook.com (2603:10b6:a03:180::49)
 by SA5PPFD911547FB.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Fri, 15 Aug
 2025 04:09:30 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::3e) by BY5PR13CA0036.outlook.office365.com
 (2603:10b6:a03:180::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.7 via Frontend Transport; Fri,
 15 Aug 2025 04:09:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 04:09:30 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 23:09:27 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, <Hawking.Zhang@amd.com>,
 <kevinyang.wang@amd.com>, <YiPeng.Chai@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Correct the counts of nr_banks and nr_errors
Date: Fri, 15 Aug 2025 12:09:18 +0800
Message-ID: <20250815040918.300906-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SA5PPFD911547FB:EE_
X-MS-Office365-Filtering-Correlation-Id: 846e439f-441c-4a48-7870-08dddbb18875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dd0o0q/OZMPHa3QP2x104fOpl41EiAAquWciyeqW54rMxUzwRhPvSdB6eWwU?=
 =?us-ascii?Q?Dapw/UA/SEcdB2NuGc5YMHkYWGxQIKydpzZ92ZWOOPnMYsADoDrXk20Lzrse?=
 =?us-ascii?Q?h7EgabXcjICwvCWaHn72v0PVQOTcqZG4hfU5PoiV4SgtZm5CfutN264qjn0J?=
 =?us-ascii?Q?9ZEvQRRryAi7oiqmxVQEZSkrlv41LJsxdi+uETztcMSMyX1HzUFV/ptB/znV?=
 =?us-ascii?Q?PiYc2U/4rRQYsPxD9hJaTSyHurNnrWIHJlINrOh52IkuIdPxrMu9vAB/EqCO?=
 =?us-ascii?Q?KXnvPAmdqtUFfO05tJRjtoRGOztFA34OPVClUdHXBShB6LEnEpdmRmV1iAxC?=
 =?us-ascii?Q?FVBkinZhXbmVzHpGS5p4cQAczVwD26BfIzR+H6MXHtfTy7aLjI48/BqYS8mf?=
 =?us-ascii?Q?pJHwetPQjvGlUd8e62Bb/QedhtFA9MbGyyutUIdUNWZSdSaRenCoN0PIWHft?=
 =?us-ascii?Q?xQ3Y9qLQSmY0/SI7hfduYTpaxc9P51mhH4QQbFIdUyh4Wkc/ZkPybgvGfuBx?=
 =?us-ascii?Q?AooqXQcoKIanvzjcqVa0OgywmSNdz2Mz3jAUle5ePBP5mOCuSZOLTL51XI7T?=
 =?us-ascii?Q?RAp7VddbMzgfgo0l0wuOJFM9AxZfRvDv3Ndb5UaRBfSfyjo3uihlah1W/LWU?=
 =?us-ascii?Q?0IluQcDxDkWJugvr/YqObhPbzs07Ao+ZVEJevei4C68wgJWUDJbMWlU8D1wj?=
 =?us-ascii?Q?IBEtFICqldkaXqgEOEyasNsq/paMCuVNxOFfq4PclhszSfyD69EfY/CbuLn8?=
 =?us-ascii?Q?SV0cVMwRBpFEsvLQEHSDS7NkgCR4H0zUL+iYVNi9XwjM9Osd6GKPAiQQAt9t?=
 =?us-ascii?Q?qs4pLNne3xR/4Rddat/k+UpoBAE5yEpIw+Sx8cBSYGACWcjBSCRU6Dsi9uFa?=
 =?us-ascii?Q?IUpKIw0uyKKqnWGQJ9rBTMOxwhnX+VoY5XaSwL4iMsWGVB8hJvU+O5ILBEPt?=
 =?us-ascii?Q?1Rz52wLi6kvLPXzfvscWgbIqiVJGE2yngEF/1O+Od1+at8nqEtZdwtEiKUmj?=
 =?us-ascii?Q?Mt0pggXwwY/awIjM7uE7hO1hH55i0qes6Y7Zg9TXFpkYLNdda4MZs03IA4ER?=
 =?us-ascii?Q?CepjisG9t1MzDtk1GWc8tRULAiyw3fcvx5fK9O873WycWdO70OtUVU/RoniG?=
 =?us-ascii?Q?ir5LNUIIcZtUXAx1SCNNKRxsKnneHUeyiXVxyiYlbHQgaVINuOXvrZEfHRMg?=
 =?us-ascii?Q?ROtovzKGSCgAx1nDxmkSdXmxsiONYUJyOZ6UlMfRGguLH9tjFyXHUkvsruvZ?=
 =?us-ascii?Q?znLPY8IesfskLuRiNdMmfmWNoZTDB4BT1kaad0IjTbhgbXe6Lalv+u8Z5atv?=
 =?us-ascii?Q?YLaMcjvu1kLHUVOf1FcBTpbAYWGSY6rVeQ8j3uCxanMYS80VGe5eGqTKm2gL?=
 =?us-ascii?Q?VUNeGwQM6aTTcA1btPfmrg4LaIR1ERdKDsGwFWBVQzydEUswpvVRBEzDo7j4?=
 =?us-ascii?Q?nZEKpvxmsWvu1n8TKcGbnmNNX3yjjS8MSQkwvfzU8ZMKOL4GWgmmFWoBXpqR?=
 =?us-ascii?Q?GK1GmaExi2BDVADCbatVSP3NuOtxnEzOLsf7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 04:09:30.0223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 846e439f-441c-4a48-7870-08dddbb18875
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD911547FB
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

Correct the counts of nr_banks and nr_errors

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index cbc40cad581b..090bf6cf1b91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -76,6 +76,7 @@ static void aca_banks_release(struct aca_banks *banks)
 	list_for_each_entry_safe(node, tmp, &banks->list, node) {
 		list_del(&node->node);
 		kvfree(node);
+		banks->nr_banks--;
 	}
 }
 
@@ -229,6 +230,7 @@ static struct aca_bank_error *new_bank_error(struct aca_error *aerr, struct aca_
 
 	mutex_lock(&aerr->lock);
 	list_add_tail(&bank_error->node, &aerr->list);
+	aerr->nr_errors++;
 	mutex_unlock(&aerr->lock);
 
 	return bank_error;
-- 
2.34.1

