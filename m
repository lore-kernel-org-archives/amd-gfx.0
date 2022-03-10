Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE82BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 00:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D8A10E23F;
	Thu, 10 Mar 2022 00:42:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 942C610E23F
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 00:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enbXhIyBPuC2wI24mu8ojYWF/tU/UvZb66yBTq4N1O0deHn4orkZE5D3NvwFkWSL3Vzn7DI7Tv7h/kwFtwQgeOPfnxd7HLaajBn/JGNPrHvr1twphB7DwFEhTihMsggtRK/bMIOE8QcQpiT2VotZVwOjRZIs/plqVuZypAQC46EdHNbnnjsrqWVOI06xIUMrzBSaT+LUq0Ubw1ICTl77KSzdq6eVyVuGxWAFE720eowUqWnb++RyX+lkynpE7Wvr7XcinFKaQ/KiiMS+mWXamUlKZJsXjmVuyBb+YaFx4va0O8OpZKwK/LRN5xr0mfPrbNsE/poNigSKqV95hycqag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg/nwy6Z/Lia9HY1IeVm9W+ozqs5H84RDhho2k5vBrI=;
 b=GJOKnZDpzcAM5uW1RaLSx3uEUYi0aShsVKUcZ0zI99oeWlI8qBbvql8AhGVmy3vdZKRt/Cm5hdqg3FswZ5vYdZgaphuisBxzyz0Hkm3ZROoRt1Bu4OP0hAUVJjiK6W9spF8ur0edtxSz+UHP4L5QXy9RCTQpkauhMzzn9p3OVMu2t1QuqE2ivqtyohNMSfFlNMFK9zuXhl/OcvoW/zaquAFnRec5ovcXn9OuZKF/6LtwX1l2iC2r6N1z/wqM84e7PNMvV+XTufIPt/ZRSzXHcXloFRnS4L7tYBcQlygrk4r+gkRqBRHiaEdPD9ic7Fe4T+kw5XKjLNObrnkORmY/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg/nwy6Z/Lia9HY1IeVm9W+ozqs5H84RDhho2k5vBrI=;
 b=3amqMCQZq59AF29dI2gYzXnHVTV7zuV3kwgHtEmmSQy2/6miqALD9x8dTYUce/BhGLbYFgQN6IYyxW1WmErbrfnUl5qXjB64vBO3VxWdd7rZ6vH706UdMPBxo7KgDcGZUr0H5k04yICUgq3Wi1C2xrs4ltO00TVQZH9MILI+HDw=
Received: from CO2PR05CA0072.namprd05.prod.outlook.com (2603:10b6:102:2::40)
 by CH0PR12MB5220.namprd12.prod.outlook.com (2603:10b6:610:d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 00:42:50 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::29) by CO2PR05CA0072.outlook.office365.com
 (2603:10b6:102:2::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.17 via Frontend
 Transport; Thu, 10 Mar 2022 00:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 10 Mar 2022 00:42:49 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 9 Mar
 2022 18:42:48 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] umr: Print errors to stderr
Date: Wed, 9 Mar 2022 19:42:23 -0500
Message-ID: <20220310004226.50895-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.291.gdab1b7905d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8abee925-ca36-432f-c865-08da022ee769
X-MS-TrafficTypeDiagnostic: CH0PR12MB5220:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB522020DE42A1548D8726A27B990B9@CH0PR12MB5220.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bBJNVG5FeHC2VkF2TxGLdC9VhZ8HhAdLdIGMEK9cq4Yu8J9PZf49/2eddtwatd07l4nNZT+GTsOiooOB5fIMU0fen1GtEcDRFIu0/g964Jrm+rs7iO5YVY33I7Y914AMSOTo2FYT8XvMfSK1XM55X+PAcFrn92lPi15sJQPD7Y7tiR1f3bKiQCW1+3+/Ncn/lpN8AEcS167XH2PAUJAspldIyAo9Rsq7biWp3W2OtHZQ6Xd2a95Ked9vuNrwA5HZ86kH8rqYN1/uJDCGhX0LYKnIbBdCkBGC0ybJD1pWnBzYNDs+evt05GOJRb/wJdPOJW3L6rZi0V1r+RaSOhF88bKx4uozoRU2w/xNgPfcEl2JEbf06Xd2/qkpDe4oxi/dLZxKDJhj/ZJvbi5NmhZPuTZMsIE4N9I0UzxRQ/ivBkLq14UyFhb4mNv4u2zQFRTxlV7Kov5+DReTOs98T0Wu6+AhRJQ9xd6JaSUwhC9J8UPIhO3k1NzTa5p6I0G6mYCWGpFBk200DnmuVpSQRP9ooQKOTQRImnWf+MoNUHGW/jSMgvJ2QUZznM9+wfXH6j2BavCCVXU0l6iaW5aNbyAuK/GG4kM4skhVOrEpg1OTNGGKwvryn8gTORMpxjEPUKwCtuioADVh8D9LJ8XvcD9VKaAzJhJWI28bp0ch5Ufpldggpocycy0xVe3d1w+qKmXtQjFixSuAsvwMZKVkSixbfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(86362001)(316002)(7696005)(54906003)(508600001)(47076005)(1076003)(6666004)(2616005)(426003)(336012)(16526019)(186003)(36756003)(26005)(83380400001)(82310400004)(4326008)(356005)(70206006)(8676002)(70586007)(2906002)(8936002)(6916009)(5660300002)(81166007)(40460700003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 00:42:49.8692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abee925-ca36-432f-c865-08da022ee769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5220
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Tom StDenis <tom.stdenis@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Print the following error message,
   Invalid gca config data header
to stderr, since printing it to stdout,
confuses parser scripts.

Also modify this message to be clearer. For instance,
   Invalid or unknown GCA config data header version:4

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 src/lib/scan_config.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/lib/scan_config.c b/src/lib/scan_config.c
index c7f4e9d3c69faa..3503bbd92a104a 100644
--- a/src/lib/scan_config.c
+++ b/src/lib/scan_config.c
@@ -122,7 +122,7 @@ static uint64_t read_int_drm(int cardno, char *fname)
 }
 
 /**
- * umr_scan_config - Scan the debugfs confiruration data
+ * umr_scan_config - Scan the debugfs configuration data
  */
 int umr_scan_config(struct umr_asic *asic, int xgmi_scan)
 {
@@ -246,7 +246,9 @@ gca_config:
 		case 4: parse_rev4(asic, data, &r);
 			break;
 		default:
-			printf("Invalid gca config data header\n");
+			fprintf(stderr,
+				"Invalid or unknown GCA config data header version:%d\n",
+				data[0]);
 			return -1;
 	}
 

base-commit: 818bb1e8f1b5a26fda0e3d7abfc1e68605ebad28
-- 
2.35.1.291.gdab1b7905d

