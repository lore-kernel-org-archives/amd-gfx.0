Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D91FCD128A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 605AA1126D1;
	Wed, 10 Apr 2024 21:28:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YH7sWRp2";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D29FF10FD4F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcNWhAXjF7/YQ2dr9yu26GB1c/W3ePMTyTnttsjp5oG6jZ6oFKcfAZ34u+7Fc7fokkSCTqQOtLlmMbNjtT1ZbFkXasCd5H3xAmO7HlDDy5pzWJ2mft5FCb4dOR0hyV6fyB2IUEebxN64QyeBQ+UoFUez9Kv+MKnOC+6o4AD/KEL/hdXnlUoJI4W/uVPLrrIYGAtfaenzewJ0H2jXnAykcKygOgKhU1oT7tXJDuGqhZpWm83aAnrRimYb20DwmJyuX1fQ2nxfzv2jytTnS1Ce4l7RWnE1bRaBUDbSLcB10LPaFn6r2K/COZTaOafhTUgznyMOz5PV6gNMW7qByPpVaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh4ByptC5thaMNGd3SMGeXB+Cd/CuE8QdD5NkOSzKuo=;
 b=Vr95F9vkPu1WMtQTOPQDhSCspc7iOww9EeNuhsxJrLO1VNdytEa+7bjw1rVR+CSfWUwPGko0ZFR6qCS6RHO1FXqT2tCUwCVnOXQNBhyvY2Ec7UMoxvN3P4FpbsmkFfJFQeP0/dMZo0MA9f0mekfOWkirvDdSCPnFNuz5v+QJr0cjE0CE7Hd7guRo+I/qLg+WEc1YqAuvYkIkwWcCDDTI4zy+9qZX9Tz6P6MA2dBgXek/+WCJ3gmTN2JHNRYMQeJanVfTSSdbdc4jFOpyGUVWv9qVT4dJDM+C9bHpHUQhtr0VXsTPSLIMdf3Y4EPT6ep2AnaiLMXzokAxpyuGBfwgGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh4ByptC5thaMNGd3SMGeXB+Cd/CuE8QdD5NkOSzKuo=;
 b=YH7sWRp2lanWcyGCnHH+DT5q+J79HkgdTdERRyuoSo0iuDNVu56ta67fwJMeSvEp1LHAbkk4Gqh/RpcE8hpJzXZA2E7rBmAsaVMzvpnmJeu023+R/xSFpPGMsw2ID8CtxHC9ckiMuSDNCRzyC9n09twlGNCqrp1LKGkMmaGsel4=
Received: from BN9PR03CA0036.namprd03.prod.outlook.com (2603:10b6:408:fb::11)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:28:30 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::af) by BN9PR03CA0036.outlook.office365.com
 (2603:10b6:408:fb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:30 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:27 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 25/25] drm/amd/display: 3.2.281
Date: Wed, 10 Apr 2024 15:26:14 -0600
Message-ID: <20240410212726.1312989-26-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: a6eae7ac-f6ba-496e-4c2d-08dc59a52ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Px17W5UgBasr/3HRFTIgINTGw74r7dHWOp4wzhwpSfQ6zlbLvBPs9E701p8iinzQG7CQCzv7XPQZ+ckFiJhB5PdJ0Cuk7AuWUqEi1lHgcSuJABibiiGc9KQkBcrG048mmNG43GgVNmK9jkE8pvcry748QPkL70itraEqsTHCTysBnES032J4f0v9rLnTPYhZZwVxR3ZtRw0q9jlfxTHVhlW042wfZUSsOvNdEd7rVmA+LaV18nIrNK6/1DSdhTqudatwULn8d1l8FLT7C+exL2zXKbSj1qshgwdzzxOGasgrewHUXUTU9C1FmA9SX0voBL0bpEvqFdzqZEvtH+FAJ2EUX5pEHXfW8VtRuX2yHc41lLVIgbK69s4J1FpCV6yaQK8njY8FJPrpPR9maNdBYrzwYUoBswhVAG0+fyCnrYo9jurkjbdb8PMVBLnbyxnD8LW+BfOsqaaYfNTa+/6R6xoAC+84uE2IR+z2AcjX+3aB39umuAje9/jsm35PCckVwALMjUBpTWY5xeypgcwPjD86gqsuYEaiT9/PlEIHlCmcpVcjudQ5aI7HP1Lbf0Wei2YcMFva2cc7waox5pAKeZ67HlbFNLZDmGw11fuQdCEMZXt1vdadGrVZ/k+4RpaWXjZmiZKiX0oTpyh4S8u/evMn7Vu3mW58YtNPw2wj9RjYu5H6yQivkNxNIP1COWx3VaqRnBCAUtIpSYoA90F7OYCFRQNkALamdj6Eni93Gbwet9xhqaIQARb9oc1O/zN2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:30.0687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6eae7ac-f6ba-496e-4c2d-08dc59a52ace
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:

* Expand dmub_cmd operations.
* Update DVI configuration.
* Modify power sequence.
* Enable Z10 flag for IPS.
* Multiple code cleanups.

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6a88423b7188..3c33c3bcbe2c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -53,7 +53,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.279"
+#define DC_VER "3.2.281"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.43.0

