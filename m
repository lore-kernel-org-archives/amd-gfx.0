Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05AFC4829E
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACEEF112CA5;
	Tue,  6 Feb 2024 15:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z7BvWxKq";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D03112717
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvYAReZX8X6Qjge+au71AT5RmZh8tbIvNcSfk4Fi3Oh8gFalfr3OPNomFdg68vsTBC6DxE9wqIj3QW06b2Zw4i45j/VR1XcOyBZD4f8NEYg+3Z7lArqeiM2IjWb3FYoR5wt5eMr20/moJa5WT3F972X8NFgSSGtvERfvAWiB0ry+2CA7x1a5j+8OFPxBG34FAKJeHrHRLRQ3Xg4Tb0wOF6Wo0oroeSBE/M4cK1nJ6WxPkVxGW90qcF25Dz9dFhZzJZzlBsMJY4hxHcZKpBHlsl7yEd86Ma+L2xPilJGxC9pfSXYwnpKLOt/uu+C2b8t6noBbm5AMnx6+1sCg95TmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgojr0h4P4OHfJGMQ6bG9erwEY6N5HH46ssXU/nsPz8=;
 b=GZQEZdUUOTIdOGYwyXCaC6gmlWzlpXjexxbT6X2vBlobgebR0CC9MZaf3wJzmzF7RSk0qerhj+WLQf+yRiW9zLTw6/qPzSvwdWAW7JD3QRoxYuOLv0nPYMxVQJ1b2BdNRJgUU9KMHcKfpqsZeWvp/z8F6gac1zbCyJrBIIZooAvQtPofeUcn7371sg6jXLhaJK/24b1+h56ZrRctwojlGTkkijh/br8dKqeAsTnY6L3m5E6+zYG3D03BhRaaBqWzAJ0QAlDy5PTY4aFvIDrhIfSYWGZsErs3OaTrTr9bpzAC2pZDTMu8bo2w+bqzuo/jJjpaY5gKQ1FFoZsI4a+/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgojr0h4P4OHfJGMQ6bG9erwEY6N5HH46ssXU/nsPz8=;
 b=z7BvWxKqes9waVJiFbCTqamdmGa7k4A/fkX8lC9AnKM7iWyWMey8tJx5MwdexHwATs5oFntvq1J3gky3Yga1KGRS1/wVLrp94tomFdQenb1sk//mhcyaH/kQ9rfS7t6D72r/al/+ohCTmKgTQkaI7gH3omq1FQb28UE/WUl/KJk=
Received: from SJ0PR03CA0213.namprd03.prod.outlook.com (2603:10b6:a03:39f::8)
 by PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 15:59:45 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::e7) by SJ0PR03CA0213.outlook.office365.com
 (2603:10b6:a03:39f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:44 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:41 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 20/24] drm/amdkfd: enable pc sampling start
Date: Tue, 6 Feb 2024 10:59:16 -0500
Message-ID: <20240206155920.3171418-21-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|PH0PR12MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 65780b39-93a9-4de9-6322-08dc272ca325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m6Iy8VZ0D+JaT2zN6OCLs/Wzyig8ie4drOjVLQT7QT+CGYcafFHJD7O+FXpEHLRVowrde6FAYnNVkI7NuV3rSDzFlda40Pv6ZTvHxvUMGuahjW29R4wfGEHzM51DeOYpTO5paPp7INmw4gOINlMm3FkanUCcpF0TjIbBF1ITT4z/D85HsxT3Zm3YlX3T269MQfaQSxN2HN/xo7vET6zSJpRfj0y3nx21WdfR5zKKXn6C2tsg/bueb7DUaMNjc1MWRwo7mh9bPbylFoysL6dW8UGXnOzYpDiOmvv3yurpcq1jIGGpfk7I0GXNTb3RAtrj0bNby9NTEtO9oR6eVZjx7PQW/T+gpzqSrXlr+gHs659GKLOhIlPnhtJaqc3EYCckfcVt9UB2XnSifwN39tfuPMxmv9+suAJN2V7I+PgDM3nmj4P8TVG4nZl6ksVZkH/EORbCMKn1fpS3toR0seEa4wRqMeHB/IX/xuqBxUXsAkwqJhJEUiYJpMyWDkxgtnaJPA8h1hJsHQ3DZcPlGtkXBK587VR3UX2JAtoLwUnNbkiVDhTBxYmuEz6lKNpMWZ2pSb1BxKpShStd6XE+hoMIr/Q4sQ4YSncQuMvtmi1n/kPqrrKHDAU/ga07jF55iUbdksgRos+XBTTGqEF4kHc6PmckC+wGOC+FYkyGp5yQ6vxGvt7QgYUAQABVvWFXBEWIf8BNe5DUM9s2Y5iUXAKOOKEHWlFn/x4mWgnh/47p7WPnJ2/BHbL0E+ebvAWxtQEOwyYr3l8SqAvpghvEPP0CUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(16526019)(26005)(356005)(81166007)(47076005)(82740400003)(41300700001)(2616005)(426003)(6666004)(54906003)(7696005)(8936002)(4326008)(5660300002)(70206006)(2906002)(8676002)(36860700001)(316002)(6916009)(336012)(70586007)(478600001)(83380400001)(86362001)(1076003)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:44.7698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65780b39-93a9-4de9-6322-08dc272ca325
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981
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

Enable pc sampling start.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 27 +++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index df2f4bfd0cda..6f50ba1f8989 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -95,9 +95,30 @@ static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
 	return 0;
 }
 
-static int kfd_pc_sample_start(struct kfd_process_device *pdd)
+static int kfd_pc_sample_start(struct kfd_process_device *pdd,
+					struct pc_sampling_entry *pcs_entry)
 {
-	return -EINVAL;
+	bool pc_sampling_start = false;
+
+	pcs_entry->enabled = true;
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+
+	kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
+		pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, true);
+
+	if (!pdd->dev->pcs_data.hosttrap_entry.base.active_count)
+		pc_sampling_start = true;
+	pdd->dev->pcs_data.hosttrap_entry.base.active_count++;
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
+
+	while (pc_sampling_start) {
+		if (READ_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable))
+			usleep_range(1000, 2000);
+		else
+			break;
+	}
+
+	return 0;
 }
 
 static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
@@ -269,7 +290,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 		if (pcs_entry->enabled)
 			return -EALREADY;
 		else
-			return kfd_pc_sample_start(pdd);
+			return kfd_pc_sample_start(pdd, pcs_entry);
 
 	case KFD_IOCTL_PCS_OP_STOP:
 		if (!pcs_entry->enabled)
-- 
2.25.1

