Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D57C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 19:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD0B10E108;
	Fri, 22 Apr 2022 19:02:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4424B10E108
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 19:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB2D/fGI8TW3WAwxt1Tedd6H/swJ92d3uht/599SAyX1mjGU/fDkQYXmUP61+b9C3laYB5YNlya5OSiRN6GJqcHcBkb28ABlzGkYBbcWjdj26IMMXgegXMjSR+uiIM0R9oHeBsZ3pl7kzyCwmqEYqzBaS4DZZXQlU/K61WRYkKodmEBZKXKCHrpYh28VSSaCiPQN8z4SFsQBu2wjMj8iR6Sq+cnZgn6QYMp4hesHGhULRpX1Dd9h+JqA6vor80DQkEsDcNmL27FUgxV/1UxAb4jCwMDj3JErfAtLgt/23bsDuo2nOLvSbectzYrltZXkZy/i8CFMSz7HJbWuHh1opg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lvPZvAHdRjRl0XBqGaLwqKtIh3nZyirYaSIBQ+0dsg=;
 b=EHfzs9rq4g0rRE5IgbuUx+ekgAK9fTa4C3htlDI8Ni/yHNJl0lpUSnRGDTSgEd6tEEs4xAtRDf40sViSbYWxG7b2/Xn55funEqmeORuaAzlqDsBeMnTEjCyQWYh7BfLRhawfIUFiNeoT4VWC6h32UPlia8Y5hIBNUel06JV+G85gRO+j22ZOTcoU9HeiiyGNfpcTZzuKXD/h7WtyV8rZWQhxsvYNWiwRVkka1roxjGqNk9gC5g4zgzdDN4lQ6nBkpN4RKVXm+WmIT0ZwMqkO7D1nRTzLuJaaPaLfsZAnylKyNg58ByqLHXFm7TnZeYD2F9DSrIbqNrxB30Jqr8Fe2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lvPZvAHdRjRl0XBqGaLwqKtIh3nZyirYaSIBQ+0dsg=;
 b=ABFP77Pzvyux5ZmrZg2/wb8yB54/9xGB4Key4YDw1Ggk+uBVwnbcjAvwYaWd93BT6SvtHkvWmLx+Ou0pOiStjPcD6VzyqP0Y1KfOsJG6e9wwu1bXkhuiYwMiI59lgtXQLZkPXFmtMynno7QRXuiFhMYGTc92ubqn0CWfpf7F5o0=
Received: from DM6PR11CA0053.namprd11.prod.outlook.com (2603:10b6:5:14c::30)
 by MN2PR12MB3855.namprd12.prod.outlook.com (2603:10b6:208:167::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 19:02:46 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::2b) by DM6PR11CA0053.outlook.office365.com
 (2603:10b6:5:14c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Fri, 22 Apr 2022 19:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 19:02:45 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 14:02:44 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: Fix updating IO links during device removal
Date: Fri, 22 Apr 2022 15:02:31 -0400
Message-ID: <20220422190232.2505589-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2f81795-4c98-45cc-3f17-08da2492afc2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3855:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3855B697C2D6D7E1121B9C03EEF79@MN2PR12MB3855.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YSXnQ6J39GOwBpJcncLoT47KFEm0hp1y7NIwBKjT6P9sx16YvMdf4IOWtHpuWPNMJm+MR3LaN54KHtrz5O9W4zkSRNQ2/cLBm4pkj3+/naoKELB2ntaFG74XnrCyA6ldatRVBTVzUvY5qL65XSakZzWwtThiKwKFu8bcMXF7IrlI+xNTIcltKYfaGd0FS2R6M7i81r3OOsCgy/ZbCrMfIuBE1HrnyrBG1idyFwB6dt00TSkuCy459Kh2Q6I6O5yMQ2eHSvCDWA5kNtRdejkWkP8WGIht+sOlhdiCboKB5sE6PHV7FnjZ3m4maGzxZiY1cWRi7n3SKCcpx1Y+q0TSvLQtLt4C2B881K3e6K4N85iAGNDysZ3g0WCTYXXy2r/7zEoXmNObOLMxhVkBfAsOQ0Yv2hrXQF3eAKeDYuunTcUi8SH+rJtGqys3mSxBLnuT38qDNIN/t3bVpea+mcYqT+lUcS3JEL6xTyjOyg7BWHQ62gojnkmjhq+m2DbYlIegKMQQLauQGJSANUxkE5QpYNKuCXzfY0rYkVlEDNutY3cZ/vc0PmCW5ToaVGS1u8LKxE6Nf6XN10F487wjzDJlTOz4i2tupoZqj0vlWvZ7mqV+BvlJjKQSd60Nnl+NxOp6AQ2sEiwslXetFUgnsrjdkYdTiUXUjvBFiVSbNqYQx+ctfBqscmE7TIYY2eE64SHNRyICiz+PKUh4XoN4i9EK2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(1076003)(26005)(54906003)(4326008)(336012)(16526019)(186003)(82310400005)(81166007)(6916009)(83380400001)(47076005)(426003)(2616005)(86362001)(36860700001)(316002)(2906002)(40460700003)(44832011)(36756003)(8936002)(5660300002)(356005)(70206006)(7696005)(70586007)(508600001)(6666004)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 19:02:45.7820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f81795-4c98-45cc-3f17-08da2492afc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3855
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The logic to update the IO links when a KFD device
is removed was not correct as it would miss updating
the proximity domain values for some nodes where the
node_from and node_to both were greater values than the
proximity domain value of the KFD device being removed
from topology.

Fixes: 9be62cbcc62f ("drm/amdkfd: Cleanup IO links during KFD device removal")
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 8b7710b4d3ed..4283afd60fa5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1534,13 +1534,13 @@ static void kfd_topology_update_io_links(int proximity_domain)
 				list_del(&iolink->list);
 				dev->io_link_count--;
 				dev->node_props.io_links_count--;
-			} else if (iolink->node_from > proximity_domain) {
-				iolink->node_from--;
-			} else if (iolink->node_to > proximity_domain) {
-				iolink->node_to--;
+			} else {
+				if (iolink->node_from > proximity_domain)
+					iolink->node_from--;
+				if (iolink->node_to > proximity_domain)
+					iolink->node_to--;
 			}
 		}
-
 	}
 }
 
-- 
2.35.1

