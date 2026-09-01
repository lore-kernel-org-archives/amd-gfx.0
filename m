Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82466C61DD6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAB2310EECB;
	Tue,  1 Sep 2026 20:10:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s47e3cgZ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D706510EECC
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:10:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+EXYqze/YRciyjCq33iLb8ralOrX+rR4XFURHU1rF9lhrBey0d0TMHAVuEx0BWRvp3hFDaviZK7egjsnxsxLXfYDHEO8UIfkzMWo3tof80d67QBNCRrJpgqoF7UWuzKgfBwU8lcGPojixVeHIQrnaCFNaVhJ3zLLgn4uKpUHMyiq8LU4BhQA6xLFKYIoSeP9BUZ6gQHb5VPTHQr4+ur3cdvKKbASzO+i1RQLOnPmAsXoQLa5zKC/r/na2mC4Hu4zsWg4pQjAiqXw9vDXmuCJQLhT7v/5Z43CMyeARECCLhOnYuH9ND7ZBv0xq/WtAdlEJiBdRomMg51UkQwK5OEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qkg0lbSPv2HEvqLZ4lHdIw6vHo50gqSieep5eOyOPX8=;
 b=SJ4t33W2uixdBWja3onON2U9Qp/ZQrJJhS04eWL4wt6tcpwwnBx8YsmWuWkajzmsOGb+okGvf1q2iObJndkUNyZa6m+TGhtT3jQ4eWWjnHAziCKAPpR6rPzY1vhgw3WvhKIH0awN76ZqtWAna4k+XpZeN35IH+RHfwne8ntZkLTjOxKFGrlvM7Bi8yg9kjKSnqGdFPdV3LFCsozVN+epM2LXm3S+zYjoccJ8mTq1S1SoxyZYN21LEMHCjRxO9zfaGjx6tJUf4GRPPJ1JGMmTPexaYFd8M0zrbC+XeY58/Tr32kSSAt2v68v8v9Hc8qHOqs+EOOCP1PHQUBDjq133ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qkg0lbSPv2HEvqLZ4lHdIw6vHo50gqSieep5eOyOPX8=;
 b=s47e3cgZb06YqjCeuHNeCoRpeMyIiMey66svA14PZCl7bMUSAb32PgTct2pA5FJzw9m7qFoQsRdIqpqu9nGYUPMgrqwtBw51WkJFStI7dS50BEQ8qudigdrzf4oyb7UecJ4gwG/6+GbejTNzSWtzI0LVNLOSckgx415R5H7UjSY=
Received: from CH0PR13CA0033.namprd13.prod.outlook.com (2603:10b6:610:b2::8)
 by CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:10:50 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::59) by CH0PR13CA0033.outlook.office365.com
 (2603:10b6:610:b2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:10:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:10:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:48 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/31] drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
Date: Tue, 1 Sep 2026 16:10:04 -0400
Message-ID: <20260901201034.2960437-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|CH2PR12MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: 4418e3b4-30c4-41cb-a189-08df08651e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0lxMdD934hcnBotBEBMChplXuK6PqwtPfhGfpByOkoNsfHO67fkkZ8HYntxp2vawf4DlnHtdGfTdFbhFGoW2kpNCEUSvVkchl9aL46iDUamTmcEmgl7iPwry8UlG+0l+fQrDhMB5NszNPblh6w0BCfIwYYGR9m/DS+IJrjw+uV5sxqFK8Tw0hab2ydPt4Gq8pbWxSqDfAZn0oIqJvtqUHdLU5DDTg1STz9RMymj9xc5TOoJdXb0WNI03oI3nxe45x0PHbjNLUVhaMFaC/f7iPKuGXwqDNmuS0sJY0jgPMfNFNV28s9667G7u7Vka+MDSv3MfP2/FMwF0Dmi5m1GZ66cmzmij5OT977hb+/txMDSKFvBx0ePirIs4M1HtBNqa5c7daTsel7Z5S+Ko2alt4lCOBcFE3Z3nE2xH5DPGOKR4bPYDzLQm99eksmdZZtJw4JE66UhTPCHdc+u/YCMX6jq2XY6lUhuWaIYKyOGve3B3PYbXPacHhpW/6dfzqYDejxgA+n57fvIic7FrTBisDH3FtvocGTZ2eRuI9Ost7ma7uEqfCjezWnEk3YYIcOIjIwmZLyBuINjhEl3HENhh6Dws81GKMfyX31ilvGrk1cpV2cqPvkk6CeyuesBJ6F+7tGB9yp/BoN1grevG28ZL8kVQNacSMbGNXAeULlVobfMY6or1tmXzt67HKYIxQtZfOqTf8NxUomvooyqidZCKuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cvr0eb/t9Ma5ldFQy5l8XaaYTb2iBXUfI7uza9/1UtX90HU+JJwnJ8/Bajc8Hh07FYJy1zJ8gkJP+HLrG4t/EhsAiQEAchTbUijBAplDht4jnvdPlv3WPffgVllo4jmZWvkiEau//tz9BXfOifd0ubfZKKpEqJQCLGwi0YpD80zCz0OSTmtBgIKSkAMJIbyQQGg5ZiMz1QExVz5opDWVm1Mka1wOkMTVKM4zwx47ua6cVRWVdhAKFbY00eAWmlZJyOMp7uIczfwyFM918497mThrOUEFfQJG9BSiO3DiTKxfabB1vUUjh1RrACz+5Efu4sdbKyRBq+HNLQiIORU54dx4zxmn22JqqxPHixoOG6lSOXdjpakCzHoKnbZSk/YJ9QX3ly/RgV7rFbpKmi0YS3kN9qqZcf5dexWH+g+XWPdMJha1rNmluNvymCcgFFnO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:10:49.8657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4418e3b4-30c4-41cb-a189-08df08651e11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262
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

We need to disallow gfxoff if we touch GC MMIO registers.
At the moment we use KIQ or MES for TLB flushes so
no intended functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b46b87291c512..80f1cf1f21736 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -808,6 +808,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 	}
 
+	/* disabllow gfxoff when we invalidate */
+	if (vmhub < AMDGPU_MMHUB0(0))
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	/* This path is needed before KIQ/MES/GFXOFF are set up */
 	spin_lock(&adev->gmc.invalidate_lock);
 
@@ -873,6 +877,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
+	if (vmhub < AMDGPU_MMHUB0(0))
+		amdgpu_gfx_off_ctrl(adev, true);
+
 	if (j < adev->usec_timeout)
 		return;
 
-- 
2.55.0

