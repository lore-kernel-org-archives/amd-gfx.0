Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E588EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 18:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F4B210E59F;
	Thu, 22 Jun 2023 18:25:34 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8558B10E597
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 18:25:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPU9Pi/OVlkcX4z19lMIkLc+Lm/4tNIf5MjAP4azevH7GyZ/Z8PJ4jXp7SH0bRvYU7CTUWTd9tbhrCDtOQFZ8GxY2ieYW8B2Nst86NIQ/YTuqaN6b7qmyuQn7PJsnRKcRQFtUGiSggnqHZB3vuPRXvIiMFKDRqTOFT1e+q28Huo93eojzbw2DtbVkQlcPZwcyW/HM/MymNWXSQZ4VzzCGl2Julyx/9TKJ4t/YvL58bZE+gv+/6cHcxdwujnDjVl5DuurDjomZy1YezpsFxHFYFtYnohWo4TXGfmuA8lBNfbplyWmGaaPcbW9buiiyCt3LtjrcSVW72hmy2UEzNxHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3ZkAGjOA1itYmpoJtlGt8110aPDZhIR6cv6HJy73vI=;
 b=JmRyKvTgW5KmV34g8czL5YOehj015yN0o5WvQw2Ztq7oH1bqIdTb8mI1z9aD5kkVEh8K1t617F5Cd1UinTCvYkm3SimXw5cxiL9Eu2Dg8tvukFVh0dODQIblAFfqIo/6E/LeLwCYS0S7OxBPuygnYas3Fd5UGufUmYTOlA1J2iHTjHFUQXrUdS+ug+AKJ7jEwoL0bLqprU3L9NvP9jR+mpfDUvBGr61IKQlEVzHBt4eGda4ScQTOEzx1Kl23PMr2To9WXUVTEoQfhmJU5Tx8n6yAN/r+0epCwkJjP/05c4RDHmQ6ppG750PudO3ec7KW7JegSWiaRNuwNrDQjFBLbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3ZkAGjOA1itYmpoJtlGt8110aPDZhIR6cv6HJy73vI=;
 b=l76PD4ezc4BQWXN4Bu3Sb8dM7i1cQIEGWozQSRTu1CQX2TneLNE72WbUmx2pUwfjd5n+JBMqCKaD/aE+xx09idzJuERfOx2A0KxrgZXXcdu9HC5U+kYVh/dOi1yNtJPFAylMHpJDYKoMz+J+JELsj3m30YG6YX2oqBwWc/mnbLc=
Received: from MW4PR03CA0321.namprd03.prod.outlook.com (2603:10b6:303:dd::26)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 22 Jun
 2023 18:25:25 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::e5) by MW4PR03CA0321.outlook.office365.com
 (2603:10b6:303:dd::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 18:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 18:25:25 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 13:25:23 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] Revert "drm/amd: Disable PSR-SU on Parade 0803 TCON"
Date: Thu, 22 Jun 2023 13:25:07 -0500
Message-ID: <20230622182507.25531-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622182507.25531-1-mario.limonciello@amd.com>
References: <20230622182507.25531-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a40dfd-4458-4ac5-462b-08db734e0c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JvXUdAsNWIhwYeAFEGRQbqWLjGjjUuIs4FL9uZkUQ74sjFBVs7OLsocYQUeYfwh/Ws3ogELkpCPWjKbbh0ImrdCCUMeYV4E73cA4Y/0QIHvJVOkByIf11eKryJGU2cwCmB7FgAixec3SgNqZIke589cSN3xLLJJXKvbxLNI3FLExPNgPs6UDACya/7W9pkfPo6ZU+Bx7V+JKkS75eJS0/DxDPcEoq/awhkN+58ImuD4TVYcivjy0erlyu5t8hgx8HBvCgDljXqn6u86zjg0mPpWjGhdDeC7zbsxyp8OpEEhelAuHCgpqf8QrJnBNk4+z9z2DlYbdDte+ju9uK7pN0AKONcjYvDyR7GCaIPQabkT0NxW3XCzvBSIqtInUu1PMBSDYggSHAdDr7+7bWkDsqsvdhapoSOi4QeqoVpHRPZOTfXfR/mZpPnIUYDXRc+vCwDeC/gex+1+nzZa+7sJ4VSPsfJfuAx+1RsOqID/8whWdD38Xk3KqaFwHY9pAIZiIelQPXlA2d9E7uxkRx8Og+iJVuY2vZDE1UuOHhfr1r3X4rzYCDdGP7d42lbKMw7+gpdrhs0+QXrR+V6GN7ypPv1K0ZlPE+L4Dvs2pzeY13//NoHZTgTHoJ6MLZvVIHXLQcOp5Q49gkaFwmOVUANN4vUGmMuVFgcurO3qoa9SxDQ1s4PhGTnp831h1WcmF/7Sa5yG2y0qj6E+5e1e0s+GkMyQmVRFxYyzQyrzzzmx+2DEhIjtc6d8FoS/Sbh53XMLCf3ApdKdT+bbwR+QyORXnJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(36860700001)(478600001)(1076003)(47076005)(6666004)(41300700001)(336012)(7696005)(83380400001)(54906003)(186003)(2616005)(2906002)(16526019)(26005)(44832011)(5660300002)(40460700003)(36756003)(70206006)(6916009)(356005)(81166007)(70586007)(4326008)(82740400003)(40480700001)(86362001)(8936002)(316002)(8676002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 18:25:25.2044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a40dfd-4458-4ac5-462b-08db734e0c48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422
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
Cc: Tsung-hua Lin <Tsung-hua.Lin@amd.com>, Marc Rossi <Marc.Rossi@amd.com>,
 Sean Wang <sean.ns.wang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 33eec907ce0eb50a56dca621aa7310f7fa904b93.
This is no longer necessary when using newer DMUB F/W.

Cc: Sean Wang <sean.ns.wang@amd.com>
Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index b9e78451a3d5..30349881a283 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -839,8 +839,6 @@ bool is_psr_su_specific_panel(struct dc_link *link)
 				((dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x08) ||
 				(dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x07)))
 				isPSRSUSupported = false;
-			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
-				isPSRSUSupported = false;
 			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
 				isPSRSUSupported = true;
 		}
-- 
2.34.1

