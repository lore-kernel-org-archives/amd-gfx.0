Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCAEC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 14:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 938F410E0CB;
	Wed,  7 Jun 2023 14:39:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8371410E0CB
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 14:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFQ6/4zXupPgl7Es4PwPJc3mYZKq6u6lnMWzTldZcbIdtgbpv+CJ5BeWUNL+7F+bHObRVuAQo8u+egyGyrHM6iEObkeR1mhSZomktmnMcTbvztnbQwQWWMqLaj5Ru8j6m8RX02N2aBxcattuYlqeU9QlMEMlksV9LcmfOJ9whsmWF/VgBBWAhPaq9zukp05RacwWrpN6u6JjWqrlKXgAX4jsdamk74d2YNBhVYQEFiaNstWj2jhiNdxEAXIU4SNVNsAoQfvhG4WtkhCwiX+QHSJdoGM5xVgKygYz5WHEUUcx4yInQdgd03ghKyUthbXD97IUB7Xw0dSdfbvz0dZaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUU46zT1W7Iz0EcxJBgZlb92eWsoi/Vh3UMOxwrpn4E=;
 b=PD5cilYov94lM6aT5QSp1qPLujiSQ25yTrLv32+UiH9Bwn5QI2QR3cxbcj25TcCe42SgHFSImVsb6ERO+L73BDm4TriOHfure7kK/kPnHbRdDHBuJUc91+XE/S+ySa4Fcl1FwZuSNlDoUW2Ex3E9Kg1wBAY1P9Lg2hQXLzM2ZNphHpErDERqLqmBR1Fif3Y5kwVnYGPAPUVgToXpCNHmID0RsxJK2/qvP/WgyPIw9ZD3L990p1mJ5DacbY3JRDA1gnaSvmuIWJoNNYIQTx4TXqpdS8YpPI0EouqB2pqFCydhAQQjaxVea0RENiXtw5Ar0bsq27qFK8vBNfChXkRtzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUU46zT1W7Iz0EcxJBgZlb92eWsoi/Vh3UMOxwrpn4E=;
 b=Tngfdr7YUWhesaUbvSA19IUJ7QiYr7xEPdqZOL38949kyRWz2cnCwT+45sXBHGhjk+95cMOMU4gyGHBgsgRzkYnDEeGYbYChy8NfBK9rp9IlmvW10aSVSzm9nvhjAplQcrprl6HkApZD9xmSGbrxtF23hN30IFGMLtEbl7dnhKU=
Received: from MW4PR03CA0207.namprd03.prod.outlook.com (2603:10b6:303:b8::32)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 14:39:09 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::8b) by MW4PR03CA0207.outlook.office365.com
 (2603:10b6:303:b8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 14:39:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 14:39:07 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 09:39:06 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix vmfault signalling with additional data.
Date: Wed, 7 Jun 2023 10:38:52 -0400
Message-ID: <20230607143852.1672039-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c117b2-3565-467c-255c-08db6764f312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMW+ba8C8RmLd3gsT02bXNbQAkFb05drNmRVy9+to8IHtQ1qKWLcsguYlMxhUuUBXzLK5kGtrG+JGDb1oq5H6QoCqnrRRNBoyFHtmePwXktdURlvsWxoAnJQDCs+jxsKgM1Qmt3fAyBnADSrOp0a9/p1HDgHWDQLLckWyI/bLw9zBdFQ1DDJOtl8ZoCnhulCHuMZ5ZWjNX2jtlndWhyvwgvcBTBuGiToyshmBVnThwlORAy7SRv1+2llY1EoQoS6sgL3kiQwkQuR3QlrlGFbSlR7vLjTHtIX9t+cYZ2oGLcAyVRTlp7t+52AUXFcCYyIDR6W701llJZXXt7bvwYjs69C6vYRuvlCh+aqHWwlQXsVmeZRkaf/2HbOyR4RjuVOtx8B5BAxVvYfVPjQBSGRTvea8hUYkt+RB+YXaeiHVH/zTQvpcGOewvNuSIuIDhw4lGRdXIHEt+RxNrJke/wtuZ9bsw5tIcT7iXFa6yT9OxLa1erfZ/8Vkmvn4q/YJrnYG0tiMKvqAh8wAUjJtncbv57hCMcDxcIymUHU+xNbPRE2WNAMhmDEJFVSc0cgz+nKk3ftn9f739r2RAtEc5jmUdR5kqw7VZH9N6WMO3EP1IKY1sqsfZzMzufBl75LcXwdKcISqPXzAFy/uIRwhDdClZVTLXFaDhvWyUcX+6LZzkSbbnoNGLXhdtcVj9/K/E/RNs/PvMVywy5r91qKz/JroW5/WMCWtjRa5nVpFfbf0ndl5YDCc2H0cs2enoxN+00LKGyspfCcs8ZgyI5PbR1Z8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(47076005)(82310400005)(83380400001)(336012)(426003)(478600001)(82740400003)(44832011)(40480700001)(8936002)(8676002)(356005)(316002)(70586007)(70206006)(81166007)(4326008)(6916009)(5660300002)(40460700003)(86362001)(41300700001)(6666004)(7696005)(2906002)(54906003)(36756003)(36860700001)(16526019)(186003)(1076003)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 14:39:07.3156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c117b2-3565-467c-255c-08db6764f312
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com,
 Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Exception handling for vmfaults should be raised with additional data.

Reported-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 34 +++++++++++++++----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 7ff5c4e1b7e2..c069ef77daa5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1240,19 +1240,24 @@ void kfd_signal_vm_fault_event(struct kfd_node *dev, u32 pasid,
 		return;
 	}
 
-	memset(&memory_exception_data, 0, sizeof(memory_exception_data));
-	memory_exception_data.gpu_id = user_gpu_id;
-	memory_exception_data.failure.imprecise = true;
-	/* Set failure reason */
-	if (info) {
-		memory_exception_data.va = (info->page_addr) << PAGE_SHIFT;
-		memory_exception_data.failure.NotPresent =
-			info->prot_valid ? 1 : 0;
-		memory_exception_data.failure.NoExecute =
-			info->prot_exec ? 1 : 0;
-		memory_exception_data.failure.ReadOnly =
-			info->prot_write ? 1 : 0;
-		memory_exception_data.failure.imprecise = 0;
+	/* SoC15 chips and onwards will pass in data from now on. */
+	if (!data) {
+		memset(&memory_exception_data, 0, sizeof(memory_exception_data));
+		memory_exception_data.gpu_id = user_gpu_id;
+		memory_exception_data.failure.imprecise = true;
+
+		/* Set failure reason */
+		if (info) {
+			memory_exception_data.va = (info->page_addr) <<
+								PAGE_SHIFT;
+			memory_exception_data.failure.NotPresent =
+				info->prot_valid ? 1 : 0;
+			memory_exception_data.failure.NoExecute =
+				info->prot_exec ? 1 : 0;
+			memory_exception_data.failure.ReadOnly =
+				info->prot_write ? 1 : 0;
+			memory_exception_data.failure.imprecise = 0;
+		}
 	}
 
 	rcu_read_lock();
@@ -1261,7 +1266,8 @@ void kfd_signal_vm_fault_event(struct kfd_node *dev, u32 pasid,
 	idr_for_each_entry_continue(&p->event_idr, ev, id)
 		if (ev->type == KFD_EVENT_TYPE_MEMORY) {
 			spin_lock(&ev->lock);
-			ev->memory_exception_data = memory_exception_data;
+			ev->memory_exception_data = data ? *data :
+							memory_exception_data;
 			set_event(ev);
 			spin_unlock(&ev->lock);
 		}
-- 
2.25.1

