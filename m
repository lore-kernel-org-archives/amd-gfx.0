Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98872C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 19:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1717010E780;
	Fri, 28 Jul 2023 19:16:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52B4810E780
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 19:16:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHBsJesa9OdUUul3GYlmFZK8pM/zQzOWiTp3oKXcy+0Dbr0dhq/On8UwdYgTXqNcK8E+GD7dxPGRrCJ6g8asPSTSurcGzeTvKsNnpOu5X0L10bk+Ml7sO1KLwsW2ZPxAffHaSyNZlN9ajgPosjMKgL+dCEq/fBMEnyvR+905UhpjdKPVELgYpoyJLZ8oyGHrKeT328ZFv2goLBfRrcYuM1AunZDzp/vwWm4/4aGpD/BlNY/0poN2pYyFApKouT3VdkuqlEwnMXyxdTJuKkxpRKKHK/LOkYCA31u+sYt6jlmkrKrwh/ZSpCh7L8wG7vv4CtqSfClyqVIfdVKp7p7Kmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mxk8joNoi+AjOiSqmyXfuq/FfyqBLcwTvtX03DgCEUA=;
 b=Dfg8MrlY0Ghmuq06YjN6uP0w9IH6xnC2qeDoPm1dFNQV8mVRIYDGkJzQIhYGP7dNRjU718j3U3vztRuK5liij5RAsuNEe0IWJXCdkSCwhjf33WjwMhw+X/gvC9pr45ss4BrmVaucvafL3auqBoUzQwhAcj13IvvMR2wWs3ovwCIR3OEFFwTMFuzyE3zQncGA/hQ+bvIGNeMWsmmH3qoIrvwwIMZ982WBv1G/KYfVoOsmCuSE/iFr+oWwkTh2s4HQQtPCul2fa3OuYr67SMUkEvlxdzV0r/xThxdf/proiU5ZEIfTTxzdv5Y56Jz4aV5fiCRG5/ZwEV3yIfWtcEeQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mxk8joNoi+AjOiSqmyXfuq/FfyqBLcwTvtX03DgCEUA=;
 b=oNBZsItrxRLfZ12WnZXDB0ufRSCgGoquRSgrobU6sIVhnBShxDhrJvTblMTS9qtS98YKsjPGHD4npWmA6wB99PuzBqumsuWfRy9bvMuM0YrWzWOlkvunDuqv+yCkags+eZY6rMmg/TRDtoZtFT/YxM/JXpnxPm3rBIMILkZ1G5o=
Received: from BY3PR10CA0014.namprd10.prod.outlook.com (2603:10b6:a03:255::19)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 19:16:19 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:255:cafe::4b) by BY3PR10CA0014.outlook.office365.com
 (2603:10b6:a03:255::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 19:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 19:16:18 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 14:16:16 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 7/7] drm/amdgpu/vcn: change end doorbell index for
 vcn_v4_0_3
Date: Fri, 28 Jul 2023 15:15:41 -0400
Message-ID: <20230728191541.1778424-7-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728191541.1778424-1-samir.dhume@amd.com>
References: <20230728191541.1778424-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ce4bc1-ff82-4b64-8a18-08db8f9f1eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjPXTE7vxDHQeKTOPD17VJ3YzujEkC8NBs0Juh9FgTzQAEKqSvm/tcbGXboUw8w7d3LBkOI0iYiG66UWwS8c4U0MlD3Hj9MNLxtkWfWpi5UYChm/qqJw6jZbfP2AyzAADhlfDo/eb19ck2xaQOqfaMcW+s4mbHf0eYHlSY9cW4K6KKa6S/vW8/3NWiZ02wH9Iye7VkfuzEVOBdd1cpnX7unDD0B9yYEy+CLUQYSFL1BmM1r4l4W2yj52nVtEp4ajolKT2+LQeWJhCR5apgyZP0AF6842rXhwSQwlewtdhhk4TV3mMMiU7Vs8WK42SmfIOCRyoWjxHbm+f9LL0SpzKg2dXI/PHr5RBwq33KUOUeSSEAHhiCq/sBEhXo8hXX7BjLNuJmuUGMu25njENtsozADaVVy4WbamYSuMJYbPHRqXC4wHMjrh0HpWulLGl3HWAokgLPjPDwciYpLkR9N4Gq7P2Y+SnWdbNGjuXzLYY5g/3K6kYnNn0eu0B+ftbDPi63i1ztwpM2tvxor/1MqJ1/2wxdhoYvoaerP0kyfysjhpaSVrFv0t/3rbsMONbUimfyJ3iPPXQsHewKzJ2YwUwSjINnza8/4JKS1hxJKYuS8nKGzG+gjdX0fGKqd1bUBVkpdz/PRBOmB3v4pmXMfs6Zqz0VkZuAeXUga7sxLlNT76ADuNI/kbYjyMY96GJ3DmDUgH5lVSnJQ9qYDhT5ju3zDNZ+0emmXoUPuBeoI7Rt52WlfXaNxsH4zh/DLulHyx2EPdlsdeFyqySTOOexXdog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(41300700001)(336012)(26005)(36860700001)(86362001)(478600001)(36756003)(4326008)(6916009)(8936002)(8676002)(16526019)(70206006)(81166007)(70586007)(82740400003)(316002)(186003)(40460700003)(2906002)(47076005)(2616005)(356005)(44832011)(83380400001)(54906003)(426003)(7696005)(1076003)(40480700001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 19:16:18.2330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ce4bc1-ff82-4b64-8a18-08db8f9f1eda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
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
Cc: zhigang.luo@amd.com, guchun.chen@amd.com, gavin.wan@amd.com,
 lijo.lazar@amd.com, Samir Dhume <samir.dhume@amd.com>, frank.min@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For sriov, doorbell index for vcn0 for AID needs to be on
32 byte boundary so we need to move the vcn end doorbell

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index f637574644c0..4a279960cd21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -330,14 +330,14 @@ typedef enum _AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1 {
 	AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_END		= 0x19F,
 	/* IH: 0x1A0 ~ 0x1AF */
 	AMDGPU_DOORBELL_LAYOUT1_IH                      = 0x1A0,
-	/* VCN: 0x1B0 ~ 0x1D4 */
+	/* VCN: 0x1B0 ~ 0x1E8 */
 	AMDGPU_DOORBELL_LAYOUT1_VCN_START               = 0x1B0,
-	AMDGPU_DOORBELL_LAYOUT1_VCN_END                 = 0x1D4,
+	AMDGPU_DOORBELL_LAYOUT1_VCN_END                 = 0x1E8,
 
 	AMDGPU_DOORBELL_LAYOUT1_FIRST_NON_CP		= AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_START,
 	AMDGPU_DOORBELL_LAYOUT1_LAST_NON_CP		= AMDGPU_DOORBELL_LAYOUT1_VCN_END,
 
-	AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT          = 0x1D4,
+	AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT          = 0x1E8,
 	AMDGPU_DOORBELL_LAYOUT1_INVALID                 = 0xFFFF
 } AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1;
 
-- 
2.34.1

