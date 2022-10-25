Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434C9C04A95
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 13:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 709C710E393;
	Tue, 25 Oct 2022 13:42:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F29610E393
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 13:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9wwYw3O6kTE9/Fws2qMN+mc8lW594R8eZajwE1NagAT0Z/6Kfcd+DteYlyeo2ExyDUvIsHtW4HCJs+PBrmfQP4SBiMUM7JR/XijV5qo6BnMlGISpeksmorMfpm3CGqX1Y8vD0QVC4AenFKZmGh/njQ7tx7bfJcKUg7fijEXOT4upUpK5ykca8e76pTFREBDao/4OuVjUFxG9GBmhDndHalTYVEqYgALtL2TgJ28vFsDBX73Lec3ccXhGcCCkkFSEN3E1YZNdCqKq3QgjB6XnR+xmT1s+5owAmtkmWqjSIhycQEiB6S7S+Y04Wy/+lTIpkW5mzmyjLl+Ov0qCr9eyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2AtGbIjWoyDKDYT8cj4/zT0UiDWzfzMiYSxYwRI/1A=;
 b=gGjSk16u2ZKGieq6QArSkDD5O/w+D5yA/ZBL7+drj4JEz7hpVHZcsSuq4Pqsz8DZBcJee1QcIry0SH1Ty6YhTYal6qc3KtI6Ay3qvW+2MmhSy1vfOAbDdHnYR7n1h2uMtyMJ5Zg+MlklLVI5PodDBALBniXFAYNZOOM1jahGqN+NsjN3m4ciyBjRZCqFhUZQeiR1aQ/xHeyZNrPTQ7uyI2AqGy0nNm7koDBZBxvC92dAFC7eMP/g9WnSo9KxXe4dmYNaQRTAr3YXPUCA/JuH5uE8Rv4QTURmrCrhtdSxhTqnKToslEfFdglJ0kgLTBE3k4ggl1YILRJPYhkApzqy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2AtGbIjWoyDKDYT8cj4/zT0UiDWzfzMiYSxYwRI/1A=;
 b=47k1GZdHH3MM+Bsv70uzhGjTa4TBTPmut1vAWtgTGPTkP9iQy/HMvIWtC2ZQoGeFB9y3WW7fViecjjx+N900h6b/87Yjf7YQHACmio9UpN5KeudkhRPzMVDWQAROOc81/8ocKprfDsEdmT+mCDMvY83iIqB8kFBXXvgVDeaog0Y=
Received: from DM6PR21CA0026.namprd21.prod.outlook.com (2603:10b6:5:174::36)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 13:42:37 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::46) by DM6PR21CA0026.outlook.office365.com
 (2603:10b6:5:174::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.8 via Frontend
 Transport; Tue, 25 Oct 2022 13:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 13:42:36 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 08:42:36 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: extend halt_if_hws_hang to MES
Date: Tue, 25 Oct 2022 09:42:22 -0400
Message-ID: <20221025134222.510152-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: f339faf8-2312-48f1-97b4-08dab68ec727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJlv3OjNF3LCowyQJNMLtMwfLJ62Cf+9qcIJ5FYqAOQ6Fprw4FgYWULv+fEbIPc9vdxF1RFoXFEiV04S3AjtpbujRQrQ0UOAxFqjURJUcwHjCNAuEbit0UlTKLn9rCp3MJwOoF7tIWc8e5bVPgSyjWX9spwUCDDDsbMFDOrEVfuRMi7cvyy1qE9kMStD3MYaskqdkcW5TWBtXmSpPTl1e8EiNh/Dgo3yliSHWhqlMDGSKZlcaAyAwPEWPKvAELJb9amA11XIPojtpWd7AaZ4DaDIzvNk7e/jMz7Qcrzo9zEuayWGKkIZmp9Pf8PNmyEMEsz32DYc2BsGzXBkq4Le17d6TVvV3ap7Dn+oOZXIfXnsBT6/x/2saNvkWonN7tbYREPBZtWdd6oKvIe7COwRVhu9uffFGHWWQY7FUdxaAf9l70QAxhv+1lsv/QqYkIt1q3loQNmtcz5Mw5gAGgt379QaxrxZvD3QDr0EcuKa3C75Ufz2mz2+DjcTLbjJx97UgTR8iSLDFdOwUgWz4H2EcgkQyxiZGTaE88mHTsk/tEbPxLLBEjP6aNBZziTg6mwOmXCtm55Cp5lcXeq0FfMzuoF8ZhuCM+UylEq/ObwQEEAt4aVS8L1gQvNxW01JVWDFOO/A/q5khaVBa+C4VuDpZg9rxjsG6riev2hi58BLUt88j+fh65vIvBO7N0yE4NOLFucsnZrDhIlDFv2kQdXKE9xFJbfuDyBUVT+0pJV2HZKADmrMIkJNRvk9T2GtgzqGLrRReJddVxRt74lFP/8uN3K0RCI/lSPw1ltMwyRiZQIJioL0AYwZrYij3MYmCdax
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(6916009)(5660300002)(8936002)(54906003)(70586007)(8676002)(26005)(316002)(70206006)(4326008)(6666004)(41300700001)(7696005)(36756003)(81166007)(82740400003)(356005)(82310400005)(16526019)(47076005)(426003)(336012)(40480700001)(2906002)(40460700003)(36860700001)(2616005)(1076003)(83380400001)(86362001)(478600001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 13:42:36.8437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f339faf8-2312-48f1-97b4-08dab68ec727
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576
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
Cc: Felix.Kuehling@amd.com, Graham Sider <Graham.Sider@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hang on MES timeout if halt_if_hws_hang is set to 1.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h    | 2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0e6ddf05c23c..9999c18e7d8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -219,10 +219,12 @@ extern int amdgpu_use_xgmi_p2p;
 extern int sched_policy;
 extern bool debug_evictions;
 extern bool no_system_mem_limit;
+extern int halt_if_hws_hang;
 #else
 static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;
 static const bool __maybe_unused debug_evictions; /* = false */
 static const bool __maybe_unused no_system_mem_limit;
+static const int __maybe_unused halt_if_hws_hang;
 #endif
 #ifdef CONFIG_HSA_AMD_P2P
 extern bool pcie_p2p;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e14f314902b1..d09f92d38ad1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -129,6 +129,10 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	if (r < 1) {
 		DRM_ERROR("MES failed to response msg=%d\n",
 			  x_pkt->header.opcode);
+
+		while (halt_if_hws_hang)
+			schedule();
+
 		return -ETIMEDOUT;
 	}
 
-- 
2.25.1

