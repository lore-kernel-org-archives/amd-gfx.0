Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FD3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 22:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8619910E16F;
	Fri, 25 Mar 2022 22:55:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE08D10E16F
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 22:55:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z99AoCF58mqcf+3hqzhGR9zY8YERlechatM7Ilre31rxCUPHgzmowhan+TsF+aFwSzOzyLvDJQKwVoAlidz/KUGDH2fuJ1go6dk/z0TBA65N9w1g7IVkYTb+VhoxeguD9+RJ1l9Krbmn+vB1a/cSKQx6dmEtrLZqhcBhfGgQ/5GROuGxWDYWkQIegXSx0PSZakWMKmO0fK9sXZJioUXmn0SKpK2IAw2UuvN6Zxkj7sf1mB88LHj0P5CNQ0fo/VDFLr8CdVWGTTHGwZHz2NrhjRa/1g71YxW3usrDmkPVqHLFVt7YbfeG7no26u/om0kMdDMLehYg5zLScE11CEo+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlO4G59RmigI4z6Kq1UKdTP2kBhWWQnPd6gZplB6Doc=;
 b=bLknFQsfSqtDSO1jLeY6Avak8C7ca0HuKAjn082aN1I+w+nXZI4FnN779F6RGcJImutboBmOa91ZpDJCr/KaF+HZftFzF1afo3gyhh1f51SAI0wHDHEOsJOCUCNKgN9K+d98/Cl7/Ji48HvPEq/O95a6OXbLPmOvlluKL0sfJmFh2dxcVbrhbxJW/Y9izoxxCKBUsO3BLCl07BM4GmRzmyuiZoPC8bsUC0ed/kDx9Fz/AzU4BfFBn+pwJYIZCvh97aTDU2xkj98tZer7K+Bky9xMIF6FWV4/aoZCGLKiMbeXT/tD37Yr0yL4vX95LEjWLOKwcRkhPUBGMBIHrGBUIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlO4G59RmigI4z6Kq1UKdTP2kBhWWQnPd6gZplB6Doc=;
 b=zHgScfz9RO8UKYo4abfQ1lAgRQEe4C9/36I6m/Ya/sg6P7SfFRZAvtjVJyY/7M1MOfwVS7QFEVj0fwkhT+XTVAZyM+kFyDcCJvD69JCtitwOd17EIFWFuV+w/bsfHhtZz3YtNauARvwvZwnkfwU44hLmnLv+WHP4hXraB/+TEo8=
Received: from MW4PR03CA0166.namprd03.prod.outlook.com (2603:10b6:303:8d::21)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 22:54:58 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::fa) by MW4PR03CA0166.outlook.office365.com
 (2603:10b6:303:8d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 22:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 22:54:58 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 17:54:55 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/16] drm/amd/display: Create underflow interrupt IRQ type
Date: Fri, 25 Mar 2022 16:53:47 -0600
Message-ID: <20220325225402.469841-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325225402.469841-1-alex.hung@amd.com>
References: <20220325225402.469841-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae6ced99-0903-42f7-9b6f-08da0eb27cc1
X-MS-TrafficTypeDiagnostic: PH7PR12MB5784:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB57843548102886A796C45A17F71A9@PH7PR12MB5784.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rf17NMLTLjajH0D3cIZD1wlP2HOVBr7RfKJ2FWAE3zWlYRqa5o2yy27p2nfDdFYy9uqtUo7GBE2ZR42+WdcE3dxxva5vOTACedOFXRmF9z5HUdM5UkBTLX8wb5snS1H/9+wO3jAGfOoFecHYV9wLGYYzlJPv8ni8JIkSDMAKMQZZAOTvXBLqcIoVFqcBrvczuqxR9SPpo76SYCcIj5xMPPefLrqegP81ditYN1rDi0WdLP6cx41eqFyY80t/xUgwRoxZedWS/ZlLpGW+pQshL+dtEnDafMdPn1gFL4pqlQwAfTFEIEud6dRWAMsV2m8ubwn/W2faMW74LcyVgq74JIrkOKIIvOcLbgUiEpBi7CUWHKjHS8MYUBEYFFbecWgtEQZuVhw/3ivYWGMCkzs1QlBU6XDKj62J+fY9wkkZHO6ENQ9qm3q/lRMKgHN6t7B+YHdrCbpO2mq/k/xwfBcH024xkmQPZ3NgccF/BhGyLcdb6PZYjdKrZsyPWuXxdQEo+HVvoyUnJU2d0azCXJD3pCMBxS8y+Uk4+chbPZEzOuM+xeX01AQRru2iEV7SXYn9NzzJY97pCQ0bf4XHyXzWv41hb1DhZI3u7HdvO49f9CVW0205wUEAIFkcVCuPKY2TWrEZvxfVLr/t9bHd31qI46Eg/N5A9smsUnNVW78WL9yIIBjgeN6Fr0nhjPz425miQ+2nni9xSjQOWa5Iu09AqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(2906002)(336012)(7696005)(16526019)(2616005)(186003)(82310400004)(356005)(426003)(44832011)(86362001)(40460700003)(1076003)(54906003)(4744005)(26005)(81166007)(316002)(47076005)(5660300002)(36860700001)(508600001)(4326008)(6916009)(36756003)(8936002)(8676002)(70206006)(6666004)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:54:58.4658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6ced99-0903-42f7-9b6f-08da0eb27cc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Angus Wang <Angus.Wang@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Angus Wang <Angus.Wang@amd.com>

[WHY]
We want another entry in IRQ type that can be used to
help find the underflow interrupt source.

[HOW]
Added another mapping in IRQ type enum.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Angus Wang <Angus.Wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/irq_types.h b/drivers/gpu/drm/amd/display/dc/irq_types.h
index 530c2578db40..36d8243cfbff 100644
--- a/drivers/gpu/drm/amd/display/dc/irq_types.h
+++ b/drivers/gpu/drm/amd/display/dc/irq_types.h
@@ -162,6 +162,7 @@ enum irq_type
 	IRQ_TYPE_VUPDATE = DC_IRQ_SOURCE_VUPDATE1,
 	IRQ_TYPE_VBLANK = DC_IRQ_SOURCE_VBLANK1,
 	IRQ_TYPE_VLINE0 = DC_IRQ_SOURCE_DC1_VLINE0,
+	IRQ_TYPE_DCUNDERFLOW = DC_IRQ_SOURCE_DC1UNDERFLOW,
 };
 
 #define DAL_VALID_IRQ_SRC_NUM(src) \
-- 
2.35.1

