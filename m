Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842E5C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8195810EA68;
	Fri, 15 Dec 2023 16:00:49 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A9810EA40
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMdlJw+oc8TK5nSAKFpm2N6Nk+lTaRNkJ5d+4XTYxZocswEL6lGlElzMbF7TGuiyGnujROHvPOB+0zxXDmDAhirEpNyhwF7vzF/yI1oH9BbBy1BFWjyPzgprfVvXQtRYN/m1Wepzw6qhT+B6Z1/xIFAv+j0RWXsJTLPqOdob3XezhKVB+oaRccrmqj1LUczX9H++Rz87MITlD0/E9EfUiRNT82EvcPzQNGeLnMFfLIqeFhMgW2p4ticJx/ByLVY9idnRNfbIe9AuQLG87J5dXJHNTmtsE30DzDvyMgkZrlZxy1ln2ujkxB4ji2yvAI7ZtqvM2WBlZVEc1hJVkCYr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXvDw49j8UE4zlSf8AOXneaWRU2ZQu0Q9vqc08/BZJE=;
 b=n9vB+X4MdwdbVQcZjFWdD0SqV8RT5wDSuEy8VAaZK/aX5qlNRMUPpbJIpWMgQH9dmFQwRDuMyAJkbzOOXJpQa466rU9QLGEGmC70rGMcuOFIvDQp2QkefbCi9v1HObLA0UcqyMxEDFkYMsyokS0fPSwO5Ykl8YPa287qhV29uKMKbsODeU2UdWHPoYjj94S5dyZbVkVI0BVebDDgc57bvjSQenngOVG02chlQJKbEYLB5POVpUqyzrokM8mcRL1ry++3Jz/bQalwhSYIUCJxJXoIYbviywjyzScH79+FbrJiz/oXzvgTF2pfxyhx+KrH0KN+npOoQoqBi30UMVsGqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXvDw49j8UE4zlSf8AOXneaWRU2ZQu0Q9vqc08/BZJE=;
 b=M+4loMFdbn/djqf5WJdagBqv7D37gGo4x3uU0exLPegTpmAGG1LrSan5B0etzYNChVL5rxuRUAeSlFZdVKe7GEReUY1uTCNEbOKx7GQVfUuUsAzVB22b48s0XDOB7yimW+gyfAH/p2L0n+nGy/to7FKn8wogc96uucBz3SwS9lI=
Received: from SA9P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::9) by
 DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.31; Fri, 15 Dec 2023 16:00:44 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::1e) by SA9P223CA0004.outlook.office365.com
 (2603:10b6:806:26::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:44 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:39 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 09/24] drm/amdkfd: add interface to trigger pc sampling trap
Date: Fri, 15 Dec 2023 10:59:36 -0500
Message-ID: <20231215155951.811884-10-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a370046-22bb-4dc5-d7cb-08dbfd86fead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IasEAX8lU7d4kEhDJ8h4ztWpKqkGyT41LWtUX2xLBZLSECpkdisiPgyvsDRGEQujdrcY4FQQr5154d7OlTf3+GhySwWmJgbjFhl0jGrFCTg/NRo882IBgeEUeoNG+N+CAQ0EOamWUMIger+6+/7HtncRSRTF+Nr0nRsCR4JoRMreAH6V3o4QMN8WsXXwCG+NJ8mNZ06uMoxqbU/ORflciuyYWAhA8fs/e/I9T8KFEgqBG60v2uI+G0TEEYv5XPDC9APtj2n+DpKEdOJBXFQysFoMJVSClCbzQssYr+Vn4SkwDaW2hfMHvIZd7+QbfjWJt0MuBJnIuI6UBEAWd4WJGCVCohcJ+OGi38y9TZsQqSVo+/4J4Gg2l31Cjwz/J97EwJlB3gsdJtp9MXHmP4szMBVtp8BQLB/m258QRIHAOkqYHyZ6W/GGbVy4sJoFNHunEKaBTxTCByEkNLlyulFLjT8OfIwiuD4YLpOIf8UjwMzui0PCJoWPYVahFHtBWQBcFe9dwUooqyhxmnuWBIxyRONTLUyohZmQ/bVbm4MhiPgMHu/DXDsVfQj5rnrRdUhc7AY5mmKMwk3YvxAks12PnhV9eWDcipN8n2nOY393eTndvBce0/IKCODbsuMHrn6kRasqU1lC10L8H2EMaxla9gXGFHBibdmRuUFLYzTziWs5vAHnDnt3BMICq6GwhPLaoiJ0RJxMpleJhdUKg3p4SyGe2y4w/iCz3xGp02DZM4E/DDhWbGLlKi/X0rnZ2Vw1CsBRenmoyzF8mx1SN0zHAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(16526019)(26005)(426003)(336012)(7696005)(2616005)(1076003)(356005)(82740400003)(86362001)(36756003)(81166007)(47076005)(5660300002)(4326008)(36860700001)(6666004)(70586007)(6916009)(316002)(70206006)(8676002)(8936002)(54906003)(2906002)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:44.2682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a370046-22bb-4dc5-d7cb-08dbfd86fead
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add interface to trigger pc sampling trap.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 6d094cf3587d..05b0255aca37 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -33,6 +33,7 @@
 #include <linux/dma-fence.h>
 #include "amdgpu_irq.h"
 #include "amdgpu_gfx.h"
+#include <uapi/linux/kfd_ioctl.h>
 
 struct pci_dev;
 struct amdgpu_device;
@@ -318,6 +319,11 @@ struct kfd2kgd_calls {
 	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
 			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
 			uint32_t inst);
+	uint32_t (*trigger_pc_sample_trap)(struct amdgpu_device *adev,
+					uint32_t vmid,
+					uint32_t *target_simd,
+					uint32_t *target_wave_slot,
+					enum kfd_ioctl_pc_sample_method method);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.25.1

