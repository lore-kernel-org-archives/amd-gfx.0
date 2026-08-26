Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB35C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ED5710EE43;
	Wed, 26 Aug 2026 23:22:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rXsd3OV1";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012043.outbound.protection.outlook.com
 [40.107.200.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E962A10EE43
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaHSaBwF4wHzxHogPgKVrZSTw8k/Cvh+ahZ1YVs+MCBX1I31Fz80NC17XIPh6TWh7G+xb8z6C4vnky/37Z798g/cjBAoty6LHl9+1i93N/h7eu43dgRKa5j/+h5SACdhWQt7KNAsyWmKlpkdYO1TzID8EVoQwKOdLL5F78s8vjDldsdtVUbXA9neAQgBqTApdRwbQADfLc4TfDlQf8/rwo6zJYiQk/Njbd921cqa70AA4995+s0glS5P8DV4NtZE+R0X+mchdOsQPu6aioOFeUoUig6RUANFvv9HLkyvw2b7zdDqskS7LcQcZHPztZpedpoFznLARTqS6TubsDSjbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HSmekYFUJ1DgbHkAcMxt32P3Dp6hP0iCokMvSfHhnA=;
 b=XdgcPbU+EU9JAR7ZhpNkIaaFu4mDB9EfT6xli30TkmqdxZX8GdK/iehbqgvmfe6/1mSTwwNxyVsxbOTH+omShXWrcfX0RfHaQ8JQBe4F77zyicsP9m5YX0/zzjg0+1pT+61Nfj/q5+7ttamjGFM6h5CGR1fr1GR9NHvCUdT8Q2wUXYVkNFCa6a/mU0eMxFAD4MLAyMGjfuyaOeCBPbQZ8tQmTC8Z8Ay4S8d2oyxq9YjeAWv5kyyMJqTUH9xIVkulmtOrGlBIbVTSXJLdw5qfKHqt1a1JEMOEmhpHbSvAYddVPuf7EaVxhsCnVIHZo2B9wQ816ZK69lZLT56BixOo5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HSmekYFUJ1DgbHkAcMxt32P3Dp6hP0iCokMvSfHhnA=;
 b=rXsd3OV1pKs3WcynFXo0kjMHF6Kf59GcyTjypDIpoG88dvbM5m/inxjbkeuFcGBkb8oxCVkfP+j6DEgD4rsoO2hK2RDwCLo6/VklK17357UYdDHpfehhliiQow4gqEaO6Fwd0LAh4NWewtGK6n7zSENtgB2P+kjEcV0hXdl1EDc=
Received: from SN7PR04CA0221.namprd04.prod.outlook.com (2603:10b6:806:127::16)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 23:22:30 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::9) by SN7PR04CA0221.outlook.office365.com
 (2603:10b6:806:127::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:22:29 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:22:24 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 20/59] drm/amd/display: Remove const Qualifier From
 Non-Pointer Fields
Date: Wed, 26 Aug 2026 17:04:51 -0600
Message-ID: <20260826231519.881949-21-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: bbeb4db4-e807-49f7-42c4-08df03c8e618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|30052699003|82310400026|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oyptSfZYP1j4M1Far71o/U0++id11jUzRsgOvX4T60RLkfytXbIl5SLov7K2JRrI55Gw0uoD8m2y5gcBA05QXg3Ty0W8/v0TPYvUUZeipB3Y1iSHLza6k7uapEgx5vWLqIZs2VqVgsciYT/MF/ysftBIsURuVZUp4xe/7uMNfqjhjTffzBKtKXoNMe3KuuZsdERn+qZxYZbsofRk+qkEPhn6mdta8650iX0oVD2gqrbMy8eq9ExFSLyRqWRn5F/pQYLDZZDl1401OlfFdQ+H6cGYoj0f4OfwTDw+CoxwETJMZfkNNxkh3GGVfsZ4kSEp3p6kP4Qzf4kXOA9VYq3hjJVUOWqngcEuQN7McqJGfdZWxO7HA2axeVpBexC5RdzMi6oUJVkFc+WC2Dm+S1E/vxIS+8jemimEVN5X2UX5QPCxqL2mOrj7coCdrbMIL0WNecJoXhm8CCeArtD9k1Y0IrCcTNZuFJLCXgzCArjcrYL9ve7mgbAbv61DKCVQtuLfqJWb498B1QtgdZJaeX2hhHpXDiOPmh5y87FajtI+89f59+4UExMcU9RCimobvJ9eKHwLmxBbSD1LxQuhTkHOwSGbDO30v3JZhOl3wNbkBFWQgiLk3iwjgCAVMnHZDKQGbzn0FhAYR362r1h8OUk48IrTD54Qosorx0GsxrdwZ/Mfz9JesZnsK1xc3OannDDByzd1d+HY6isF7/noQaoVNg==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(30052699003)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sRDUqGKPnmR3LcEAOETeHMns1OP30IAytqfJi5vnYwGlRWCNUZ3R/WNvTgjHFggQ5b7ca4O2qJ42LVLggLrvKJk8YUuUozdO0l2zlU68Jqkd8XV7OsuIszRtKd2488WuAYnGPQVzOoLqtqFcLj2U9tf21p1PfEWDSA6cl3NftQoVRvUFQyloDGo9anZC7icNY3ic5n68cikPjpmqJFyaUw+WNspZ98haKngac/y3XTa8tUyK79s/Do8+XALbuejAbt3owp65sBWN39XTS/d2y6N+TYDkUUUEd+Zy/HptkS+dURZ2ENKP5581CzFgcEBFWgasZTjvweK3//5MRwsiNcH9sXtiA2+NRy4VXEJMf/PfKQLP/+YfBhd63x1Aq8BRTijCVnfYoVxqbdjEKRSMetsjSPZCEjRh9A5+CmfLAi94/aCc3hSC4BcgcMF3Kwac
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:22:29.7375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbeb4db4-e807-49f7-42c4-08df03c8e618
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
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

From: Austin Zheng <Austin.Zheng@amd.com>

[WHY/HOW]
Integer values for
dml2_core_calcs_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_params
should not have the const qualifier.
This prevents using different values of the inputs when the
function is called again.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index 36250f3d83aa..df552eac0006 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -1823,8 +1823,8 @@ struct dml2_core_calcs_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_param
 	bool UnboundedRequestEnabled;
 	unsigned int CompressedBufferSizeInkByte;
 	bool max_outstanding_when_urgent_expected;
-	const unsigned int max_outstanding_requests;
-	const unsigned int max_request_size_bytes;
+	unsigned int max_outstanding_requests;
+	unsigned int max_request_size_bytes;
 	const unsigned int *meta_row_height_l;
 	const unsigned int *meta_row_height_c;
 	const enum dml2_pstate_method *uclk_pstate_switch_modes;
-- 
2.43.0

