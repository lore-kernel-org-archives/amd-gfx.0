Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD93CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A93E10E4ED;
	Thu, 19 Oct 2023 13:34:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B35A10E4ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:34:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3knysPCIfLIO2ePJCB/0Bv16ZzYMsow8iSmrWF0gY1oKbaItRFox90FNdRq5WKxYth7079oghOoiZIeT5f/bVxMxMNRQn3kGlHiSyA5Y58ZFQO4pwVatG5yAFgqm64pQ10i+yW9Vog9u11N8e2x+E9uf7Zjo/iJzYkHz17/BIcbH6cHJwRzS7y0Y+a+S03bvJ76s5wRyi/Li+G2GbImaa67E8YfDRT4QjFAgrurZLkzy3bltR5RBW/Tbh3xDb3VkvfEQg5X40wSS4LA8x6bjsoYNjdI+HnknngvnptAezS7jXPlohqiy+UnHKE1KJ+XRcaIqbXq57+KBNgNWm+G6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9FHnfze21lOv6nyGGXsP6gdqDxB1K7bmal6JujAnWQ=;
 b=afjPOIIX1qchWzp4zkeXpCgaQC9JSueTgAGARS+GKnb8IBs26R3NWNcgnlVvkhjT+cPklb5wrCK1rpd3sRONckb+g4qpdYwRuDjccKmcLtzxkRARvXVM2V06rubcV8kGx6pn7TpJRgOay9kC6UyA8FXLshl9uoVFFdcqdTqQ7MUc5E5CdXhIS7ZQFaqWRHRUSoRiY8u9zgJXLN3AENgYQXuQjDB8l5XVZz/lYPPFcO9LWJYdC1RiV0jPWKIzm7M6gMslXSXF6yAxXOZnW1QrPoNa6MDS+EvEbvO7cHrJgCNLotqe+QyOyNg6lx3Qq5mRbwH+xwe/unUHixfCx5P4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9FHnfze21lOv6nyGGXsP6gdqDxB1K7bmal6JujAnWQ=;
 b=Fuy3SeTjeex1JU9YMtsP40fSYKEg9ulk1p+BfMySOkBGXNa6oHP0ZWUzfubQG6FDF+ddvm3gjY7M6zywmE3Vwhhy8xR4U7gWCTupD3LtT3DkD0ntSUM/XiIUMpSNIgcW6xfBDWmjY6iIMxR0J6LlhL2/iv2lcMLQXynOn3awWXM=
Received: from BYAPR02CA0021.namprd02.prod.outlook.com (2603:10b6:a02:ee::34)
 by PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 13:34:06 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a02:ee:cafe::7f) by BYAPR02CA0021.outlook.office365.com
 (2603:10b6:a02:ee::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Thu, 19 Oct 2023 13:34:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Thu, 19 Oct 2023 13:34:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:33:22 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:33:11 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 14/24] drm/amd/display: Correct enum typo
Date: Thu, 19 Oct 2023 09:32:12 -0400
Message-ID: <20231019133222.1633077-15-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 3efad155-2f23-431e-0bb7-08dbd0a810e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jpBiIU4gKZlI+J5wwWXHRYO8e9ACb2c6059MNME8H6jfkoa/iXOuKCA0Dx8H4ELIYWzHRFie1y+tSWOtEnq7SYTlrHVjwgTxb3Rjqf5dp1T6VrbF3S212lZj1+zv7jBraSj+k+QCDwJPbvtmvK1kmb1uSzyIB0rub/0ZgMucFzw/EA2MziVOOE8QZYF777NHOm+Gpjbdc7k2lf5O33YykeRrnieDwwkgEHySHjUxCWX7w032uOp453Yz57HxP9huy+tG+2Ta45yDkyIVRx1d8LJJx7bmkDLiKs6oK+4z8xH91npzc+T/XGAfvIGJByTKNm6AhHN37rVSQQjUZ0ApH/T6Xz5B19FG8bgjddKBpjSG+OAS5EkXkEkMl/1p02hHczdNVc1a2dbTKbyYRl+cqcftQf0H3kGXILggQEKxeYrncAnDuU9dWea3NNHvrnxneQ0aqkosUlib0Q8Ld6q+0QY5tayg5F86KLZwwg0RFccaQ1O4EJVM7jRh4+SRyX643FjctsjOzWqqCIbvHUx3sEQFb3vIqfLnLG+xCmtUQ/N8NYqW7bQOfsktkbr4iG54LGo1LKIblLBJDn2RG4GuV7w5LNsFAJcGmgl3L1Wjo4/k+TTLTa/82Fm8+DCCqu69lwdnjacfv1pO7iPDFNDQaHT7m4f4qtATS5bFLzoP4VlL7xZZXDBIIbmsEOx3h/1JHffMbJtKzACJG+PS1N8yt6G+Tu2MIrtpv9L4cuFHN8CZQVuo7TJVmPyOhqqnXG9qjOE/LbO4cSr0caLTHLoT3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(36756003)(40480700001)(316002)(40460700003)(70586007)(6916009)(26005)(86362001)(70206006)(81166007)(82740400003)(356005)(54906003)(36860700001)(83380400001)(7696005)(1076003)(2616005)(426003)(336012)(2876002)(2906002)(478600001)(41300700001)(8936002)(4326008)(5660300002)(8676002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:34:05.7504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efad155-2f23-431e-0bb7-08dbd0a810e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

This commit just replaces dc_interrupt_po*r*larity with its correct
name, which is dc_interrupt_polarity.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq_types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq_types.h b/drivers/gpu/drm/amd/display/dc/irq_types.h
index 530c2578db40..93354bff456a 100644
--- a/drivers/gpu/drm/amd/display/dc/irq_types.h
+++ b/drivers/gpu/drm/amd/display/dc/irq_types.h
@@ -178,7 +178,7 @@ enum dc_interrupt_context {
 	INTERRUPT_CONTEXT_NUMBER
 };
 
-enum dc_interrupt_porlarity {
+enum dc_interrupt_polarity {
 	INTERRUPT_POLARITY_DEFAULT = 0,
 	INTERRUPT_POLARITY_LOW = INTERRUPT_POLARITY_DEFAULT,
 	INTERRUPT_POLARITY_HIGH,
@@ -199,12 +199,12 @@ struct dc_interrupt_params {
 	/* The polarity *change* which will trigger an interrupt.
 	 * If 'requested_polarity == INTERRUPT_POLARITY_BOTH', then
 	 * 'current_polarity' must be initialised. */
-	enum dc_interrupt_porlarity requested_polarity;
+	enum dc_interrupt_polarity requested_polarity;
 	/* If 'requested_polarity == INTERRUPT_POLARITY_BOTH',
 	 * 'current_polarity' should contain the current state, which means
 	 * the interrupt will be triggered when state changes from what is,
 	 * in 'current_polarity'. */
-	enum dc_interrupt_porlarity current_polarity;
+	enum dc_interrupt_polarity current_polarity;
 	enum dc_irq_source irq_source;
 	enum dc_interrupt_context int_context;
 };
-- 
2.34.1

