Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAADCCA479
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 08:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24EE610E434;
	Mon, 20 Jun 2022 08:48:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 489A610E3FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 08:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3ZEj3o8ZV7r9JrU2lMwkKBpxd76q+TQMpIThL9HCSIeTl5luDdioFx3QAagMHpKxTN762D12JO9c3+EE4K7hGcTpwWa29gOVUn5H6E/e35dXAA89K24Chn8UJFGgLeYeOJyuG1/4+Wd4JfqBIqrkjukmdQ/VqSIukeplr1/qRsxD7RLDcG+PJYL/W6f1dTy7o/usMAfQN8GRp70IukAQNnq0iRC/mopHgJL7Ang2Oy6SZoAwhs/Zb3op2sX3RAejwkqk06IOe/anwwstiRtPjfmFYW/lP6vxMILvbRMaOh6X9n+Wl1HujmnBvi0PFcika3p7ZZp7gR2uzl56197GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uE4Mt1EMzgJiqTqALCoYc2ECPRo782aaI95YkbAoh+M=;
 b=GqAKasLfdnz82f9LOmP/TV4CeFQXhysaE2fr25x0Gakpx+LdyJMDc/br7wClOyGqOlLIaOpjzgpmOKbVsf3ZRJAkmZ9tyxpd0RefHpuQrmxO4GlOFQWd7VaokwW4kanbdg/iyoH2G6JfUZXd9RZtJxXv4OogIQkmaApaBXc6huPxNFHheTcPXLCRcZoxz4PlOF2CfTUY/7aN6f0q5T0X6DtqwluFZYqMzzbZ9Nr3DPU9sNc1nKYimcZ2rt3GStt0GuymM60DFjUicNlXliazykwgBhTbSUy6LSspNe//i13SvGFW8lkkoW9JR9dMIMzBwDk38QCQrA5w8BHr3bqfHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE4Mt1EMzgJiqTqALCoYc2ECPRo782aaI95YkbAoh+M=;
 b=etVZFaBpPKWAYmNgl4pfLxfDTETZ0OTphNr+6857GetgD6DuZQZOdNwUbP81TjLqNG2Cavqv2mBYbrmt39V9SS3RrfkmGhR7hr5cpaQRfIUlbY8p+GCX58NhNkhSi5l6RIkvKNKl3aYq6xTv6PYADTLTEypRwQCc0r9hEU//d40=
Received: from BN0PR04CA0046.namprd04.prod.outlook.com (2603:10b6:408:e8::21)
 by CH2PR12MB3992.namprd12.prod.outlook.com (2603:10b6:610:29::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Mon, 20 Jun
 2022 08:48:00 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::5d) by BN0PR04CA0046.outlook.office365.com
 (2603:10b6:408:e8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17 via Frontend
 Transport; Mon, 20 Jun 2022 08:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 08:48:00 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 20 Jun
 2022 03:47:58 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: correct sdma queue number of sdma 6.0.1
Date: Mon, 20 Jun 2022 16:41:56 +0800
Message-ID: <20220620084156.2295093-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4ea4e66-cfef-4437-d836-08da529994ca
X-MS-TrafficTypeDiagnostic: CH2PR12MB3992:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB399204AEF784DE4CBFB60362C1B09@CH2PR12MB3992.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RuT3Hn3rrBykJebAvdCOQughSSliTgdAYX+LZQnGUvFM60EJqXSHwGI0cDsJKmeS0ebsQhQve7HcIeCO7OnQ/69L3vl+o+8Yc6gUKdDsTeirpUEy4n122gcB7//MEKoR1bqgGA+R5Z//aGNot0g1wYFaA2CCXbSDtSBSU7c6A40F9dpa9TlZTvJRqa6a52Dkj8D+chCR49rlq91G7K+LlVUOTtNwnR0dAP6BJbGZA8jay5ICX9nNxm6t7yg18AhaBFdTkPY6cSY4YR8MoSU4pNhsD9AMq+eLb52MO1HNO4I90CAl3YiKtHFTu3qL9CqshFR5w+zIXZ99WbrsQDjHyAlQUgqiJK6YPWC7Ny3NCUhyfH2qM9YXoCqjcR6tN+XQnkMQPtHXARy938vf+oKDDZtnJmxTQ2bNrvu5dlM9v522HG9tjOojXIwzFvd3BvG55yhXR+rJPiumwzbpyIl/TkWw4BdVCNr2Q2TLPf+S0Ws36bpGWb5l8tbceNcLuM/FlC9z5dtsKIM0FQ6yaCBej1XlvnxNW5qPzA/PYxx6RFz7rURii6nn0dXK0/ttTmfIuKA3JlKpgagkLLhveAGn7W85BV6aZhnEVsmptSzg1W3CcsgkO6tn00UbwT+Lc7DaW59BVmCTxwJpNiv88r9clZQulFD4CgrQnAXCNZQjps3nDFkDNX3e5x0ih4QDZjhQnra4UmDRhz06jIclq6hRu2DtzpiIA3nOtpv2uORwLkqoeZM7IC1tj9sTbZCuLrzl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(396003)(40470700004)(36840700001)(46966006)(5660300002)(70586007)(40460700003)(81166007)(54906003)(4326008)(316002)(82740400003)(36860700001)(356005)(82310400005)(70206006)(26005)(7696005)(36756003)(478600001)(6916009)(8676002)(41300700001)(8936002)(83380400001)(16526019)(426003)(86362001)(336012)(186003)(47076005)(2906002)(40480700001)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 08:48:00.5517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ea4e66-cfef-4437-d836-08da529994ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3992
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Ray.Huang@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sdma 6.0.1 has 8 queues instead of 2.

Fixes: 2f68559102cb (drm/amdkfd: add GC 11.0.1 KFD support)
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index bf4200457772..c8fee0dbfdcb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -75,7 +75,6 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
 	case IP_VERSION(5, 2, 6):/* GC 10.3.6 */
 	case IP_VERSION(5, 2, 7):/* GC 10.3.7 */
-	case IP_VERSION(6, 0, 1):
 		kfd->device_info.num_sdma_queues_per_engine = 2;
 		break;
 	case IP_VERSION(4, 2, 0):/* VEGA20 */
@@ -90,6 +89,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
 	case IP_VERSION(5, 2, 5):/* BEIGE_GOBY */
 	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 0, 2):
 		kfd->device_info.num_sdma_queues_per_engine = 8;
 		break;
-- 
2.35.1

