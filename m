Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D20C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 14:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C706F10E828;
	Thu, 18 Jan 2024 14:34:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 069E410E81B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 14:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ixc4nRfAzufqtoKivg3zHbLeiI5icQuWyEinJu7r1p8ohntq18fD8I+4qNlh+f/r5hVuQqOdqkyHW8sPk/YS9OwShW+wArCWVAVyZRNylH1hNfwrGdx9PdjLqPl3A/HJpbKS8+h8631rjGExp6HcvuTs+5XVi0CjcUTR0AdaeaO8EL745Mh31nTxhpas+plpIowKfiIc4hRxWtBbpLGQ524zLHymM7v4xHiuMkosYiEqWv83/XGdF0LSmiisNDzW8MEMxceL2vzPQEvUgSmmsHcXj0FuKYjl2mB/IM9RJKLkMI4+oz4g5NmsoUo44cfVM5VHvaq/k2gnhbV3qSItMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVvJQ37yQhnPKKZXWm6ddbMqRlS9A5/jdACVjQmzVE4=;
 b=B24TXSaOHmQlRvq1nDQDhpan6MOLlXsKDCwsIuulYpu8DnXKlMHcwg/XGIk6bptdmWvPsNXbd1oQqoL7sGr1xcr8/nj9jfpYFx71yRCBzrn2Tgo6aR1c0OXZfEUzB5kNz/WNglDGs3PiUClOS5vVKWpeSPdEYneprsK/3MGKJd4Oen2X2egxpFrBIawn0q5M+J0kInWxjY/dYAAL7b14gcsiJSVHwUiG8aBPmam4XDF5Hkqm4PRdfdAOy4trrfm8NRu8Vkk9qPtJqT26mvNPqv3og0zPsub6fOQAe9uf6YqZxvvmfX1NyJQ3LcsaNZ80MamEa7ZsxdA8PE+5tKhZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVvJQ37yQhnPKKZXWm6ddbMqRlS9A5/jdACVjQmzVE4=;
 b=fLr3ZPEaxYgqSRbwPELY7nGZJtKxgk3m0j+i1TYag990C1OtSWRnVqTvwjfQ5iBTbPEvPh1ou4HkiVwpNodDyxDCNJZQJaV1uMSNIx0UtixrhpF0T3GGfQCuPMH0SPjaa2bmHXW2bk8ybjsAjVfl888zGdMy9pQk8TZLaYYQsrE=
Received: from SJ0PR03CA0384.namprd03.prod.outlook.com (2603:10b6:a03:3a1::29)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 14:34:46 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::35) by SJ0PR03CA0384.outlook.office365.com
 (2603:10b6:a03:3a1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 14:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 14:34:45 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:39 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 18 Jan
 2024 06:34:39 -0800
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 08:34:39 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/12] drm/amd/display: Promote DAL to 3.2.268
Date: Thu, 18 Jan 2024 09:33:50 -0500
Message-ID: <20240118143400.1001088-3-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118143400.1001088-1-Roman.Li@amd.com>
References: <20240118143400.1001088-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b343bb-0eab-4c6d-410a-08dc18329df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eowyLUwbNy9ZgqVcxFr7uim07pmKOySwOrPgSpzVWyTftXacEtdSWkoXRlAW0DtO19gLW86ke0aWAPAMiVEM8/HaP/eSC5Jp10RrXTN77N0ck88o3BjFCJqoTsh1g7WjYrb8eMR1k5/U/qddbYtN+05I6O9tkfLy2JGqk9YgJypd9AdVrmEIZnx+FRbLNNpVbcJs0Fb2rNpKHWPwr1xCFkowuem+9RIZmpNWdfHWWXScJjyYrAc96te/04pwXmAczH6/NC+LDSAqGFjvHd4xKJbTP4RueAl7ShXTrRfj4DB03E8vGJ0Bb6BrVAx86iEfvIerMDISAe7D15v+IHcy0IYURfUr9ydoSlD0qvVsLEI855MKGU+79t+IJgCoDCPTw1IjhHSFNXR7uDt8QJcHQj9+aNsnQE8dssa0pbXr2xLjNZxhMU8XYdgT2n0GzvQlAZ4qH8AfLdryq1Z1rexY8fwYX87FkKgaaQTfPLd3z3+tqcJyCPQZum5KcwsgAa4omQrWPd2F8N+qu1nl4fTgaLVlvazjcwoWOEKb8+KO/sASv2F/Z2fMq49232eiX8E5PyHQgoiDnUqEw/1xIesVM4RmRHoqNOYnAlll3VsW6OV3aEu577tHcQEuazv7cIbuo1IgISkYXxkY9Am4QclCbZ2hVMsZqcH5pleHmvkERaUB0sZSwckI0d40RGaD/xJtVnzCC9iDb9i4IhaplJwBD71CMpaWkaXI2TOQQsgYMabYsFrbL0l3utgyJE61McTfFOCZG93WX/8Z7JDBzsjVZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(36840700001)(46966006)(40470700004)(70206006)(70586007)(83380400001)(54906003)(6916009)(316002)(2906002)(36860700001)(36756003)(8936002)(8676002)(4326008)(86362001)(5660300002)(41300700001)(47076005)(82740400003)(4744005)(40480700001)(40460700003)(356005)(1076003)(81166007)(26005)(478600001)(426003)(336012)(7696005)(2616005)(6666004)(2876002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:34:45.5888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b343bb-0eab-4c6d-410a-08dc18329df5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456
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
Cc: Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1d052742d4c7..432ae08462e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -51,7 +51,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.267"
+#define DC_VER "3.2.268"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

