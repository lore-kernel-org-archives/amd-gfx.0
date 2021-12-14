Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E14C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 08:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6443510EA0D;
	Tue, 14 Dec 2021 08:07:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD9B10EA0D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 08:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEc6Glhz/mUbwoZtZVPKXwBW7gfQe7ObETI297LoNnQQ+oQQxBO4O3p5YqBBNTgnPTu6UseVKCwvSCWOXAmlwolngtf0U2A24JdHx2KyQ7Oan9hz4e189QHJjODnJxbpfyXMfSJnh8/2EKjoOMnTJQsdSBbN5yaCEhAWvo0hAuGYCYFo5CmwXLIdE6R1BUEeRWupiuJisbieres13b3xd/YagMgzUil4R1Pgxg5BUvMWfjHAmCHUIomF6LCxnUBfvdlmjlp4NzEVYQaJ6sJzKyc0ld7v1Iid1h8GZrCWOYdp/NHAUE8GYmfl1x0Ot9RSv7hTxsmWu6+gjCqOjMXGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tviPMwPnEK1sAir2JpBiywxASHC7IWl+OK7XIi+hiCk=;
 b=e4zRaRlNEi8gM3EobtQ8ZTXmvDi3Zi/eAKXlngHhm3dhqxoLZaRjQJQWJfjMwHI/r8Hii4PSC5GR6r76ciBxjQVQTGc3OFXLzOlX0Xs5xUrLrfy3yA+wJjcMiSdRGgTOFBK87JtCCfdHDZqL6et22vw876ld/Y/bcWG4G5P8tyr7SYGhoxs2aHMiB7iPOhuBorRiUlnnaRq/D4KcgAqmdw2yBDAshgK6xsZnMs6UndK6cyJa7Gp67dflAF9Rj6gCUZkcr9WhynIePFVDTlRMIm2Y2WEuXPB1aHZWdiAUXQLSZn91D9xrCQfoKYM3BcBc6Ph3+Hr52DrfXpfujp4GBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tviPMwPnEK1sAir2JpBiywxASHC7IWl+OK7XIi+hiCk=;
 b=UeDelaaFOJjYhY+u29JIUM2uKi5MuJ3plypIl/BScRophoY9hsXhhEKLk0vj+/ky9UVTbAliFkSg8c/ZeXkek2c9vrqIo7T1UZuKbsT0aRNSv4NJmc1AFe0QL8drv2jstDFr0n6Yn1bzMQnyZOL9z4aeIrqYWNrfbEsCx86+aGM=
Received: from MW2PR16CA0065.namprd16.prod.outlook.com (2603:10b6:907:1::42)
 by BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 08:06:56 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::fd) by MW2PR16CA0065.outlook.office365.com
 (2603:10b6:907:1::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Tue, 14 Dec 2021 08:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.16 via Frontend Transport; Tue, 14 Dec 2021 08:06:56 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 14 Dec
 2021 02:06:53 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix a potential gpu_metrics_table memory leak
Date: Tue, 14 Dec 2021 16:06:33 +0800
Message-ID: <20211214080633.335789-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93da4ce1-2463-4d36-8517-08d9bed8b26f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3238:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3238EBE4C5C775EF79E238C8FB759@BYAPR12MB3238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dF4m6s3o3oX8wcE14cC2qWIkQOlymB9hy4aI3XoD0r/PstcXWMvHjI09EXp75OoLvVmJ+8GYFLPaf30YY5Q5HcV95qZ5+f6bHBL4fkNCzsCMCLCJc2OUQ7mU9JfHs0OGKzJJHA6kKlcdYv5Y53p9IewbHQGTi4S/nNWqnhhFDiHlHZSbk4t7EYbJ4GlJerexWJyXOSUeROsxKwYcWT/VluNsUEdjw1X/BmLdnUyN9/aUcEcG1UguMsBGksq22LprXslaAues+mKxSmN9R4+dewqi9VRar0Nrl3mfhEgl2SyqA9613XrHmlc0IpUVbKCoRUPEYx2WP0JIvPYc0D+jT7aTjJG9pEOQrf8TKhQgCg37D2rgcbaFI995aN88GvdaIM+8001hnYNvsmBTyesRQWtX22cZyhtC7Pr11bWg55LRyX2FpcuSuPgEh+8dtiU7VzjScWxCEdHbdqQhc+pKX4dZcZ7simk9YNglxwNiWW69SYEoUb0yYUmR4nw27Ob1zjXB7SdDxfaWdgLghcct4zLLo2RZz4enVzfJsEsBird3IzoFxnymz4lga5MPqxgAjj5X8Qh5IVvTSPylf2RY7XkIZ6I2Jso2zcIR5yHtDN1jNHanGxlElT2S+lCvK8Ba0JhA2x6yR/+HlzqhFcq3xkNqdZyRNjkf8dmbILs0FzIL//EL5dJ4zV3+7XtQGdEwRDNnchwCh252lE/ICtLUcH6+zy6fvDiE6LGwBaGsaV6MhS4ebWE2Sd5aPDyPhk4k4iTeVBYs0oP6Vrjwe/qlmI0s2+HaJyxRF7TyJKgPOM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(36860700001)(426003)(6916009)(2906002)(47076005)(54906003)(316002)(7696005)(336012)(2616005)(4326008)(86362001)(44832011)(6666004)(40460700001)(1076003)(36756003)(16526019)(82310400004)(26005)(4744005)(8936002)(81166007)(70206006)(8676002)(5660300002)(356005)(508600001)(70586007)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 08:06:56.3985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93da4ce1-2463-4d36-8517-08d9bed8b26f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3238
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Evan Quan <evan.quan@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <lang.yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Memory is allocated for gpu_metrics_table in renoir_init_smc_tables(),
but not freed in int smu_v12_0_fini_smc_tables(). Free it!

Fixes: 95868b85764a ("drm/amd/powerplay: add Renoir support for gpu metrics export")

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index d60b8c5e8715..43028f2cd28b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -191,6 +191,9 @@ int smu_v12_0_fini_smc_tables(struct smu_context *smu)
 	kfree(smu_table->watermarks_table);
 	smu_table->watermarks_table = NULL;
 
+	kfree(smu_table->gpu_metrics_table);
+	smu_table->gpu_metrics_table = NULL;
+
 	return 0;
 }
 
-- 
2.25.1

