Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18206CD98E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 21:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9184410E729;
	Mon, 15 Jun 2026 21:17:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SDdWpxgu";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011009.outbound.protection.outlook.com [52.101.57.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A2ED10E722
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 21:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wu1D3HzWg+Nu3YdlVd+H4OnnUVZDQBse7aetcnI/y5pjNR2qBv62TebEXTfmpLqQnnek1LNrmWxk5BItbwFY05hTNw1i9Z1l51rdtljU+dr6AC9NdghHEaUZTe2nxh2rm6oEwk3du+dBgOUUm65ks2WxSOJRM3225Do4yuRvKuuzoXPCyXaI5KzKZ89pf657pNvL70HTkNpf1fH97pH+V0qajeHtUB5gX8cmjzO7Xu+SLtpuh/xigjLHfoCv10/mzIxTdbqXK/vXjoOr1uGJvhzPP4HXP37qrai99EHhuNBiZB0ZVZJI9CmGGd4OLujAXeiTaqwvo2t6AHiQR4B9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7R/dsLVyw77NuAF9vhYxIb5lYMAHaRJSgfJ20SE0KA=;
 b=qfwCO5uUUBlQzV2QnnYtd0EKTNlsKnas4LMH8rcmFQfh0k2XhONApyLXxYiN6pT35SBkWZY8OxorLpjVTwz2gJ8jtrwCasBwVEznetAoPCaQwHtjm+PBwLr8WfgIL9ZyfmN8PysG3ebpo8htgvxYNX5a0zZ0/3TXpk3Aip50afGYMqbAQLLq599azhJDC/J/UwzNMGk+ljeBgg0BgP7mQUdiT2bpxdaeZ4kEbSWjNvqauZfHKH6SHPzlhiUxSP+g6JE0lVm6VMpbwYg80P7w7F89geNiFsHjKf5nhUB5/CEb+w3CyKhjH7MqKFtH5KIBeCvFt3dQ3qNcgRBIpuqJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7R/dsLVyw77NuAF9vhYxIb5lYMAHaRJSgfJ20SE0KA=;
 b=SDdWpxguVnlQdEctDpyKSHkr89HWpYDtzknh1U+TTkTOPIA3fR5fvYWQRE9K69X+Ev+Dk1BFHwoYuVRft7BXz+utEEWNW0rvC2QDe35qiZba2XSkJIJS4DWPuYLSya7jk4EyEfqmhj8vFTc2orRTRAyfqVh/Ty8absfTIS5c33Q=
Received: from CH0PR03CA0244.namprd03.prod.outlook.com (2603:10b6:610:e5::9)
 by SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Mon, 15 Jun
 2026 21:17:10 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::2e) by CH0PR03CA0244.outlook.office365.com
 (2603:10b6:610:e5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 21:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 21:17:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:17:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:17:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 16:17:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kent.Russell@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/9] drm/amdgpu/vcn: add flags for disabling KQs/UQs
Date: Mon, 15 Jun 2026 17:16:49 -0400
Message-ID: <20260615211654.676386-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615211654.676386-1-alexander.deucher@amd.com>
References: <20260615211654.676386-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|SA0PR12MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 3946a6ab-2de2-4d13-7283-08decb23760f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 4JU54DATl7STjccILd8+/TLSn2B3nAhj4/gBUJxFEKuAKPp7AU6epuOEv7f2xbAffbknJ/iEYTPO5AUJ1ejnsVoK4wkNQQ4e0hex084DU/ekPjnWtL25zwbsFdhca7CJwlvILC4nXKtlYPEbnmgJcouypbTY6DBzdxYvtzlHUhmzBkCGLO/Y9LVykY7Df4jTzxA3STIg2vjcYQr1wDrvojbmE5uhCeh0yXbhRK2XaSvHJcCLj6jvJLbjpFlnK8YItHuOt3+NUo48Ze+sHmrg0eSk0q6FQVgyj3hrRbt6gccyxqRGGsS/BP4Pee/b3KOQNptbMzVtquMilbTthl5FG11LfJou09jNnhsna05c6Ue4utAe9frtjRd77Agw051SwGNMx3StEa38CVnYfmllTkXokipVKdDabAZ5tnFbNFPiqDkWF+hNZdpaqWHb9irnnLW1up1mbvn+TxaA2PMrrGFs9SkNczMNUmav/WIJ/Ujxa7uyeDm9wq7G8WwdEll6HUxC8cZ5R1Z/DxFrKmUyaDrFGqooc+b14MP2oQKgCTYCd0eMYnS1mPFBtiFsSy0ZzObcEz+wKYJU4KykPrwGBuYaevFTkqYIohforJTH61fpVG6AnHGuL8+rxunPLET28PO3GEgV6Wl1xyPR64W50aK/mg88JkP7OxESgIrCfiWUGpT3Mxp6iKdECRSrfX7wFsOEMjYMt5JYdwORGohSd6CgpsltNWkQSJN4SMlNUkk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D++OVboUQXH6iQzbiMILvTcz3e8nIft8ydVjgxowbCdb2/kHZawq8f9vC4UVBp/0LtBn0b6DsWfz1w6H8I7t0ztIg3oAO9rVNEE100gkB0YZvErCpJFAilfuwxBkwRwnaxQ8wPgWZnqSd5UgJKIz59gAFpgeng76oVVQB++8f4z7cTuYNcUx2QDinu5ZR4dqq9N/UXAX/6t6VdWuHBd/PQIIf4g6RtfbxCMfUKNDTdx2AgYMPsbq7jvEmIe/E1+GLgfXr5iuT6YsTVKiV9uDFv2TQBoQuMaGHfIMb0Ay+iG21Z2F2rMg8jhxsSF3z3Hmhn0Kb3fdq97iP72/YETTtfrqtIpuAMZMnONBQEXjp073h5sgs/OiZFvkj+lfIeqlh0PX8HqHgxsN1jws/hGkLwFthEg/tpyAZWZ5xf7OppKrf0xJE5JgYik6iv6SkCHb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 21:17:09.7455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3946a6ab-2de2-4d13-7283-08decb23760f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461
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

Add flags for handling disabling of kernel queues or
user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 82624b44e661a..bea95307fd42b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -368,6 +368,9 @@ struct amdgpu_vcn {
 	struct mutex            workload_profile_mutex;
 	u32 reg_count;
 	const struct amdgpu_hwip_reg_entry *reg_list;
+
+	bool			disable_uq;
+	bool			disable_kq;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
-- 
2.54.0

