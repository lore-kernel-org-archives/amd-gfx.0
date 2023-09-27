Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2921E810BD
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 10:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 418C510E4CB;
	Wed, 27 Sep 2023 10:21:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF7610E4CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 10:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enZyLMNu6XJ9kvikqNTnBUg6nbnwrz2gnPNZqZeZAb1M4IIRqWWAF0U9sFCmSZsXLhN/DzrIp63HjdsdXN5rhD+QhmYYOWPB8TQucyP4213uaBk8asjEp4n9mb2mEC112UPR2JZ1pc4Qs1ITHAAGa0zUyxbh2Psq3l/H0q0TsASDeglWEKCGXCd438JtsZmvrtMwWQz0IaMNZ+nKgeH7Z8hNJ8fcRaMIMNX6AdTIVoyAYEYEtVFJ2igW3Fzi9UA1wQx1TOgkLJT4QFBr2D6b25b/JzSxoiX0vz0X2mt91en1MAN+sIP+x6jIXwh9JYVhRijqEr1t7JI2B9xzA6OfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQkMZDEs87qxyff0McSB78VYNIhDStGv9qdM+3XbDnI=;
 b=ZAt0LJnfOCeq5MLmE/fhzzOevylW9KVom53dJXp+ZJQ4nl2StmxAEDMMK3G6SKQWlc7bvh/jsMwaCeErOdHC7Bl/7Iq4pi5dpxovsDe6HC9mN+t9+i++6lkxVpTp+3LzJfGTj95KP+a0okyjmHDQ8eMHOZUMIAIVFmuqfB99u5OBDceBnVSZuFzny0wzpg6BE/T77qlpEqqQ8tSsC18uv+NgfmoUoAVSdBfe2Fyx6kExfxbDxZZlssMS/EBziD8EbBtjaEfEA3YqFlDlKQIUsU/7yFizc/tw4ekoySYwwrVIg0K6PduAPbxftPbguR6/ZQgYYhrlThLk68oo53aB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQkMZDEs87qxyff0McSB78VYNIhDStGv9qdM+3XbDnI=;
 b=2rZIID9U75tvTScMkZbFGlu9jX/sEj4IElkcWZNrs8ZPPOMjPw5Vn0DQZpWFuvdGiltlQKhW8mkxoG+QxnoiA34byJJrFU2ytuNMdKCkdslPDXRpjID2DUhQkvLQJ4AIGOTn5LhZLvwvICUsfTHyH6ZodBcG/CWLZw61Qh9A4bY=
Received: from MWH0EPF00056D1B.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:18) by MW4PR12MB7439.namprd12.prod.outlook.com
 (2603:10b6:303:22b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Wed, 27 Sep
 2023 10:21:19 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2a01:111:f403:f807::1) by MWH0EPF00056D1B.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.12 via Frontend
 Transport; Wed, 27 Sep 2023 10:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.9 via Frontend Transport; Wed, 27 Sep 2023 10:21:19 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 05:21:14 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: update retry times for psp vmbx wait
Date: Wed, 27 Sep 2023 18:20:23 +0800
Message-ID: <20230927102023.7736-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230927102023.7736-1-tao.zhou1@amd.com>
References: <20230927102023.7736-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|MW4PR12MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: af6ddc34-ba25-4525-88ca-08dbbf437dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: le7nQpG2xRFNNSCM9gQs024T9fj3C6RIYy8uM4nRW25F4RPNEkDmdSjQx6Ttn1rTgImdmiMkxbaeQ5PKD7jZzB5c4yM+6qcuC9RczAE9kpx31E9kWhtoftOMRBHRAxoc+p1L+uIA3mEbpqpQTTSE7k7STyD0FJzoY4OeAM4yD11NdjxFPvyhD1OdqFwAIPS8qtn8XnliG6Zb7JzclMLHREXIrNWbfTmrMKnYY5cBf5q00vJaEbUv0LnyRhGfrSQuq2XKI3DMNYaHAwlkTmGyVUDh+UXCGAciCReKQyX+JbXP5eO3xtapKCcPIKw9Zc85ewZxRLi+caC9dHCE8OPhN+8+oD61+4XMRBlLrxBw6UN3MnuXdxQeYpultiIUi1Tg5hFLTDgTW+9eELH1DMQjD1JJPsQdOEJyoBH60ldVMYFO/Jddw4VItAuMa90DAFZHtNORMAuqn1iCYb2zZsB0Fj49INZ0IwUCF2CAEUfDH99OiGF51OTsxVtyuw/Zu1tI3HaZSQPGpNorOpEUyHTS9H9bruH21OrClOuvHAfGGItwxWJfuVqIQYpLagivLEd+comyFeIJe3nVeu0O7k2WoSa0VC2/oiB9Y5nhwhNMEHqGiQFaKk5sHaW6x7tTk+xlwl6oFrhr4WKZLhFizb4BvxxRyAuAAx+27B4tPMPinO+P2w4BVcP4IYkkDKv/SGx0VxveY6NBh74T5w45IBwNsxaO2MwpPJ0qdTu5lonpFyRzGA3bqWZI2qN/ywpt4oikizZsCDay76uYeUFSAopSHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(2906002)(86362001)(36756003)(36860700001)(426003)(7696005)(40460700003)(8936002)(5660300002)(6916009)(40480700001)(70586007)(478600001)(16526019)(1076003)(336012)(41300700001)(316002)(70206006)(8676002)(6666004)(26005)(47076005)(83380400001)(4326008)(82740400003)(356005)(2616005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 10:21:19.6158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af6ddc34-ba25-4525-88ca-08dbbf437dd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Increase the retry loops and replace the constant number with macro.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 54008a8991fc..b7bc00d4c696 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -59,6 +59,9 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_0_ta.bin");
 /* Read USB-PD from LFB */
 #define GFX_CMD_USB_PD_USE_LFB 0x480
 
+/* Retry times for vmbx ready wait */
+#define PSP_VMBX_POLLING_LIMIT 20000
+
 /* VBIOS gfl defines */
 #define MBOX_READY_MASK 0x80000000
 #define MBOX_STATUS_MASK 0x0000FFFF
@@ -138,7 +141,7 @@ static int psp_v13_0_wait_for_vmbx_ready(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 	int retry_loop, ret;
 
-	for (retry_loop = 0; retry_loop < 70; retry_loop++) {
+	for (retry_loop = 0; retry_loop < PSP_VMBX_POLLING_LIMIT; retry_loop++) {
 		/* Wait for bootloader to signify that is
 		   ready having bit 31 of C2PMSG_33 set to 1 */
 		ret = psp_wait_for(
-- 
2.35.1

