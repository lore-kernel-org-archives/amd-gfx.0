Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7E5C072A2
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 02:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0782610E242;
	Thu, 16 Nov 2023 02:47:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22CF110E242
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 02:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiu+bv6aL/Vhrj1u71pqI7Cq/3zdiuUWt6s1f/5OxQr+jZIGzX/7y7FrieSedb0/ZJaq9LSahcaE0qEj8OV+J8ypbFxf9M+ZQU+1ZLFwcQPoNFWF48ngY8WuBRXdGNj6ZSiDXXytbnhz9pU12ICgT1Zpp/5W+Ko3gRDigqjzuGn4Lqus5z7KugB3ORgYC6T8L85b4nJvn9rjYCAE3gOEEZQTpGgjlZR8sgnhq2Ah63z2kyVHnBT12hodYrXOI/erMD2dKHi4KtbMROeYXZhwLQX/57Vy01iQYu8UyyKqleLrutRzpTG/mRupzYPLjCSeM4gJJxVkw70vLLQRJ7GsCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQEo2gxb3Amuer8eCZ+8RboVh+5laHV2KPMYAQBJzxU=;
 b=IiaN1juXcM2YguiG8mXTKQfuTpj93sIK8fl0PEPtiFNOEZRWdlZsQ+Qfig2iulKFg2OtWFx+E60KEsa/hvfl5rc4FDAPh4wQUAgz2so9SYB0qC3ClwgIShu7+TjyB3/vtvI4ZopHzx+ysFRNdYsdsxeza00yA0bqDD8sI2eSSGjmnL1OdwbWUOUH0agMGRJQ3WZP06hmmA0eipsYMko0P87NcFWQvTl88iGFO9sBUb42a3sTGyp0IHTz6nfYdp5nc5LECK/e0S+5v6LbhDphkE70Lo/YldpePh08V8gcIG/WcNhSdZzz7TFCYXUNKmYgsdIBmTp1OKRLSs+mlkImJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQEo2gxb3Amuer8eCZ+8RboVh+5laHV2KPMYAQBJzxU=;
 b=JG/TtvaTu/7wjixq1XZhM5X177uKO60GnJjl4FbCwUrpwvdtR6ydqaa23NNqbEh7svVj0TahVdvapakFu0B/1TwjVl4z8jD7NJEwDOi7ODSk2uVUS4iCVGpR8XppKRg/3qy+gd1frTKarte+4ry6zRdVXNEvgP+ntgodjfwoNyQ=
Received: from CY5PR14CA0028.namprd14.prod.outlook.com (2603:10b6:930:2::29)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Thu, 16 Nov
 2023 02:47:43 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:2:cafe::36) by CY5PR14CA0028.outlook.office365.com
 (2603:10b6:930:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Thu, 16 Nov 2023 02:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 02:47:42 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 20:47:39 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amdgpu: add lsdma interrupt src id
Date: Thu, 16 Nov 2023 10:46:59 +0800
Message-ID: <20231116024703.2838690-3-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231116024703.2838690-1-yifan1.zhang@amd.com>
References: <20231116024703.2838690-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ee8a00-3a32-4d51-aed0-08dbe64e6803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfjXXaNOUXPo5HP96HMCFGhQaJhdE3kEkvvyrr5b4bp5XcrcYwfWViKvSq68aOIFHUgT2Fj1m50LMSrrpVL1U6LqesrJ6o3+yROK/G+glA9+3oDPVNjYlDmGQPenzo9q44DOui2HYnptgU+pBDCMq03bcLIybEcCRF6WMm80rISdB71s6KtK8yoP5+qJkH1e5Z+LRaqgnRnC6PcdpBSO6ktdGXJaelphzDC/S+ZB6YW5B2ET1kboujP8MAlKHt186WIi4oWXDp3LthjbRLFpM3cnk2D+EwKwzloStiFhLaoG7/yljTO8h7e10031h8RVpt4+Utvok7DR5tFKfYtv37BEybJ/ECdcBM6twP5QVq8P1se8MHZSN4UClelMtk8FB6kSyK++6jtRUY3JSVBMDI2qS3bro5WGJxPV4jlZyOo+I5nCflyCbFG7DGLY1kY2BwisSwo+BK8FCksfLDqW4gvnM+w7rfqmxQedITqMiPZlJbRkmuaazynY3gN5PxP9n9SNC9lc1JeMV9mEwCeCYZ3LXNv8hTEHkaitYk+xq9SV1r0DLSasXJQ2G3ai5C0ZTqA4BPmr1qgIKdyBIpECQbQglfuB00bBIYkFsxTGRmMD7Ym3xU1jRTYIteiZNqaAEbvPfYrEmdaG6SNglCw0QqhtFoRYQWsyhaHtZzM8RFBx4yYmypdLTAG9YeX+I18rCeUScFMoteUSTsTrdtgTHNoD3ExUhNx1dhlT2+VnR59SEw0vU9TA//oXK9IJmdoYX4rIE174g2u54FigefJtcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(2906002)(2616005)(4326008)(36756003)(16526019)(8936002)(8676002)(36860700001)(426003)(336012)(26005)(1076003)(40480700001)(6916009)(478600001)(86362001)(5660300002)(316002)(54906003)(70206006)(70586007)(82740400003)(40460700003)(356005)(83380400001)(81166007)(6666004)(41300700001)(7696005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 02:47:42.8716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ee8a00-3a32-4d51-aed0-08dbe64e6803
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194
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
Cc: Tim.Huang@amd.com, Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Alexander.Deucher@amd.com, Lang.Yu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to add lsdma interrupt src id.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
---
 .../include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h b/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h
index 3a4670bc4449..164ee784b987 100644
--- a/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h
+++ b/drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h
@@ -28,6 +28,26 @@
 #define GFX_11_0_0__SRCID__UTCL2_DATA_POISONING                 1       // UTCL2 for data poisoning
 
 #define GFX_11_0_0__SRCID__MEM_ACCES_MON		                10		// 0x0A EA memory access monitor interrupt
+																		//
+#define GFX_11_0_0__SRCID__LSDMA_ATOMIC_RTN_DONE                 48      // 0x30 SDMA atomic*_rtn ops complete
+#define GFX_11_0_0__SRCID__LSDMA_TRAP                            49      // 0x31 Trap
+#define GFX_11_0_0__SRCID__LSDMA_SRBMWRITE                       50      // 0x32 SRBM write Protection
+#define GFX_11_0_0__SRCID__LSDMA_CTXEMPTY                        51      // 0x33 Context Empty
+#define GFX_11_0_0__SRCID__LSDMA_FROZEN                          52      // 0x34 SDMA Frozen
+#define GFX_11_0_0__SRCID__LSDMA_PREEMPT                         53      // 0x34 SDMA New Run List
+#define GFX_11_0_0__SRCID__LSDMA_IB_PREEMPT                      54      // 0x35 sdma mid - command buffer preempt interrupt
+#define GFX_11_0_0__SRCID__LSDMA_ATOMIC_TIMEOUT                  55      // 0x38 SDMA atomic CMPSWAP loop timeout
+#define GFX_11_0_0__SRCID__LSDMA_POLL_TIMEOUT                    56      // 0x39 SRBM read poll timeout
+#define GFX_11_0_0__SRCID__LSDMA_VM_HOLE                         57      // 0x3D MC or SEM address in VM hole
+#define GFX_11_0_0__SRCID__LSDMA_NACK_GEN_ERR                    58      // 0x3D MC or SEM address in VM hole
+#define GFX_11_0_0__SRCID__LSDMA_NACK_PRT                        59      // 0x3D MC or SEM address in VM hole
+#define GFX_11_0_0__SRCID__LSDMA_ECC                             60      // 0x3E ECC Error
+#define GFX_11_0_0__SRCID__LSDMA_DOORBELL_INVALID                61      // 0x36 Doorbell BE invalid
+#define GFX_11_0_0__SRCID__LSDMA_PAGE_TIMEOUT                    62      // 0x3A Page retry  timeout after UTCL2 return nack = 1
+#define GFX_11_0_0__SRCID__LSDMA_PAGE_NULL                       63      // 0x3B Page Null from UTCL2 when nack = 2
+#define GFX_11_0_0__SRCID__LSDMA_PAGE_FAULT                      64      // 0x3C Page Fault Error from UTCL2 when nack = 3
+#define GFX_11_0_0__SRCID__LSDMA_SEM_INCOMPLETE_TIMEOUT          65      // 0x41 GPF(Sem incomplete timeout)
+#define GFX_11_0_0__SRCID__LSDMA_SEM_WAIT_FAIL_TIMEOUT           66      // 0x42 Semaphore wait fail timeout
 
 #define GFX_11_0_0__SRCID__SDMA_ATOMIC_RTN_DONE                 48      // 0x30 SDMA atomic*_rtn ops complete
 #define GFX_11_0_0__SRCID__SDMA_TRAP                            49      // 0x31 Trap
-- 
2.37.3

