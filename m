Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D21C04A94
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 03:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D91310E631;
	Fri, 11 Aug 2023 03:40:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B39710E630
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 03:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZm151rBuG7EJSWZPAC/qBMeW47iRs0KKQtL46ijPyfjgS/LmPT1+Q/TAootwynOsprh71/KClLZOopqpL4/T96rOvPmmtlE+U0EwIcPFBFHVm4yrTilVlc38hivZw3Ic8zlWbixC50ySnxMB9h+Hr/dat4gldCiFe1gqD/16fSSLCrUOPvTVnlnRTTBRrKaivYONHlFi9A9RaJLmg5obTBZ+0xBYMc0IQCiZfDxUk5ljKdzKF87MJ3m/YlNZuNvJiq8v2EgJ4L4FU5BvTzPAuZQqiQV9wTTnddEvoetp9jHa0bjWf8pLtwoco+w+3WH4UG0IitFzUZy0QOnMBDhPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMNNmYgmaa2x6uwAF/l/MsJ7jLcZMXKDkamhy+lQvyA=;
 b=GMiV9YAodbVBMMc5sP+ixUD8cbsxsvhQ8kgomWPYm6IyFZSq04Igf6aLsXemP1qHRxyRVHr2xCsYoOTk2oCqC1bTBhRe1WkSxOOrpq/oXs4euhxwnAxiHatfF5Y/l1n4vXka/FF8F/M9ufxywd6FlZYadoN3m72B6C2/j+DbiMRiDhxS0XEYNUVZHDDFxoX+VrkjMlljKy/RDEMdtuxSwnYJEtElhnT59orTR4qZ0zF44ENG5XNafFE0sAFBPN/Rjk73JXdH74Ow2GZwvZVD/3/olu8OEIkHzeWsrrqxjx8SAKkdQS7IvyD4DT8Gi6R6tyXWcGgJMSE0YFb8rxCxYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMNNmYgmaa2x6uwAF/l/MsJ7jLcZMXKDkamhy+lQvyA=;
 b=P3DJAGYVTIXGWjF7Ri7rt4KVnFptS1MPshpDBqyXxsOpmgS1nBKCP+Lkl0gpYsz8omdcC9HhQFZ+AJspOpH/uyO7jFT21D5H3rMCsZoq+CrA76Yk12nzbiEivuFWWhF7FWz7PfbWcJenGxZvKdlAG7nFx3Luc+9Bs7m8mwUUSqQ=
Received: from MW4PR03CA0243.namprd03.prod.outlook.com (2603:10b6:303:b4::8)
 by CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 03:40:47 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::1d) by MW4PR03CA0243.outlook.office365.com
 (2603:10b6:303:b4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 03:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 03:40:46 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 22:40:11 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/9] drm/amd: Fix the return for average power on aldebaran
Date: Thu, 10 Aug 2023 05:31:59 -0500
Message-ID: <20230810103202.141225-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810103202.141225-1-mario.limonciello@amd.com>
References: <20230810103202.141225-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CH0PR12MB5089:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d6778a-3049-4371-6303-08db9a1cbfb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: laVG7aIkx4MSUdRFC6DvZI+hRUGeHpl/XeFsI9VAv2JMAfjt/0XLzokjzUCF3fH5pvEZcLBQrj3I9nSH8hg9YMNFGQbNWYu+wKsfe4f8nwHV2s5nDbqj7SPUn+31wqQT5ZBqlId0Tsbg+drajMvn6Jp/cOub8ADtYK5eZjjHEp5IOd5dgnRCAxWhyc5lbqV+MK9WyrLJ6YkZbq3wGu31tdRlmQp0LRanfrUXvOprf5ri3JS6vpX4TkSbDG5fPhNaUiaeM3gqZJy4lA7Fhj25mgx8tOF4tz+IQsWjGr2TzGZmL0yjK/c5oPU/SVXNMoidwjLOBSmqMO/pluYiPjZTm3fgBTMEE5IolcI0GE6EhUNzWQc9SHTt72aW8WUEr3awtm5q8MjHxyXCB6XAeps2Nzwm1VjeLE0/N+t3IwEpdjrejYzXMzsCaJX5jnB8HIj6cGB1FVnE0ffH2olVpSF8NUngc7wk6GY1ySIerTVy+WW9E0JmnCM4V1OkViq091resXF0Ag8985gKOH2sNNsU89OYG+oNnGBtytZ3+xOUPjFrh7GKuYb/T2Fro8PMq/KmPWXzi4HvGNEqY4CnPdhs2xrlSsjhse4OyN4D7kgSpJKfqPznJlc7m3A+HOe3dqQks7Z1peCZNn+5yI9RW/9nXZQHk+1sIqq7Aoa4HR021SN7KmqTEq2AYlV05ERsApp0MSQl9G3ggxr5E0kFzY8ADQK0J0OXBAQWC9WWXzaFmq042V6A00DvNOH9tG6KCARFPev7n634GEMciy2q14pZ5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(186006)(451199021)(1800799006)(82310400008)(36840700001)(40470700004)(46966006)(6666004)(16526019)(36860700001)(2906002)(336012)(47076005)(7696005)(82740400003)(2616005)(83380400001)(26005)(1076003)(81166007)(356005)(426003)(478600001)(316002)(70206006)(4326008)(6916009)(41300700001)(70586007)(40460700003)(8676002)(8936002)(5660300002)(40480700001)(44832011)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 03:40:46.7632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d6778a-3049-4371-6303-08db9a1cbfb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5089
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Aldebaran can only return average socket power for the first die.
The other dies return 0.  Instead of returning a bad value, return
-EOPNOTSUPP so that the attribute will be hidden.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 0dbb1a1c25d24..1341363ab01a8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -625,9 +625,10 @@ static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
 		/* Valid power data is available only from primary die */
-		*value = aldebaran_is_primary(smu) ?
-				 metrics->AverageSocketPower << 8 :
-				 0;
+		if (aldebaran_is_primary(smu))
+			*value = metrics->AverageSocketPower << 8;
+		else
+			ret = -EOPNOTSUPP;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->TemperatureEdge *
-- 
2.34.1

