Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC4DEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 18:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4497B10E497;
	Thu,  6 Jul 2023 18:19:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D69CF10E497
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 18:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoXzYEHwD2CBnQn/bgPrrb+7iAHmoqBMXFKkqY0gHAFHL6Itqc58kpi6YY3O8UrlyIpMaQwcJQeKnK+3saKGQfOVkp1Qaf0upXynz0AQIksj4DKk3aku/eJ81Us5uV3V29B+nwvtdyZ5h2lmsMhy6WGQ9FkffL7nRqoomdLWngglS1o8BKypi4tcWIRvPAVHnWHeUuzsQRPZaHQYfs5Wc9od7KZvLQ9/One1CjRqvvRXh7Im6HpjsIcWfYlXpWqofmQRFgkw6FVk/JqMf73R+cv4hcj2P664SFkhBWPGvh9FPq6eheI3V1aiKaf522yKO6LnFZS48z89x7S9VPNhEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkLOen1n61eeCWupyUBnSqVg0/6BM6I3ErtCDPuSRBs=;
 b=Kp3Rl8u3SWrT5i0072XI3jusvxuz5HNwmSxK9gF6Bmdrzakxi0gVkJlLDoTXbiAMP7kifg44HHWAQEMylECHOvx7NWyubdBuzW2HVcyBPGRRp2Xnw/SeExQvbw1zn92FQ9I1Kx2fMcgjYa4wW/5jMZiEloYa1KgJG0091bQfM7GiZYCDfsdNtgc818Lhz6zDzKzGov4QlHjWJ3qfFS/0/shYkfe0dcwTxnsAG3I2CdFSlcp9Em9HfwrdW14jX+TX6n7hJl5czIINqUyG4ISArfhSIOb//Hc3MVcPZQcW62m0HMO5nb3Ot0PmxNns7DEyLcYW4e9sTv15PtH3/Q8pfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkLOen1n61eeCWupyUBnSqVg0/6BM6I3ErtCDPuSRBs=;
 b=CSLLIKY/W2lp8cI4zkyBDZzt4Jhdec6sNdiNqteNMqSA/KQmTVpI7EK+baeDIS6CkGGQYrYt5t5ex0lJhlw9+9tFdBFY+S376NCDofzams3JtlxCQh3+SkX8f8MW8/u+l1bYMEUCHuFFa5k2PsfJXoP+xOnT3bQGxGer9EFEKMc=
Received: from MW4PR04CA0331.namprd04.prod.outlook.com (2603:10b6:303:8a::6)
 by CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Thu, 6 Jul
 2023 18:19:41 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::cc) by MW4PR04CA0331.outlook.office365.com
 (2603:10b6:303:8a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 18:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 18:19:40 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 6 Jul 2023 13:19:39 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amdkfd: add multi-process debugging support for GC
 v9.4.3
Date: Thu, 6 Jul 2023 14:19:18 -0400
Message-ID: <20230706181918.189722-7-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706181918.189722-1-jinhuieric.huang@amd.com>
References: <20230706181918.189722-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|CH0PR12MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: 595d748d-1b92-4070-c301-08db7e4d90c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d4yYyTpOJu6D3VP+fgzQQ7w+VdwkB5QOoVbPvgBj84WRAj1iks2zcOaYXaD6iKIW6jyA2Bl2C9XDodLAgDvki/cFruN3+9ljsMbqYSv5MZJdzqFfgqoHjvEnr7KhSj8reJD/SQd8FFxvx2X6OGcjW5IjkfXsRFFAre07HD7RZbmnYGAKOiub/olxGVwqHE7psqxU18bqwU6piWxjSB+3AS5ZdHMPwJl7QkdJ1JfZpIg/o9L5CKqnPgATt4Bln9VjxxRGzKr+/OyIBCYoYFj8yckeBivupXynNbfZNtUyVKuvusp2nXzmmhPgzIh9Xi1ixtYQUs0UAGr3VA+UTRIcx4mmIzkTGKV1+o/zaQuGspPDkyzph01ki1w5jYIwCWF65VhAJwJ+MxZwN1ootmMym33AoTgx7sHr1F8nBNNM2Kx9uHTOvkKmE/usu+K3+MpHfsYPZ8REkRsfGf3ntxi0jOEXD9taUS6lm0pGa/y6Dn3J05ZIAR5xkAfN55nxNYuZrU4yG5nq1aVnKFpyNguYaWZcnQ/p25a3xwkMQJTdQPSxpypIZu2FALv0Sp5SBWukT8LCuMubjv90lUEka8xZY0cs7i3KPD51B5a91GucWRCR3go69+XetIIWBS6KZ0MkO8Myzs7wDAvCTab3dF35zt5mAILH2iF47pG2eysLQiR6naxEHAe+bau6tlxcAWvR0riPeF5eutS4VNd3r4Rjg4GEoeNeP0T3kZqdauRmj6RBvFcWIFeIZyI2RiQ3qczKyiEAvNN/uH+y0NC9ViP1lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(26005)(1076003)(426003)(316002)(41300700001)(83380400001)(186003)(336012)(47076005)(16526019)(2616005)(40460700003)(478600001)(82740400003)(356005)(81166007)(54906003)(6666004)(7696005)(70586007)(70206006)(4326008)(6916009)(40480700001)(5660300002)(86362001)(82310400005)(8676002)(8936002)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 18:19:40.8087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 595d748d-1b92-4070-c301-08db7e4d90c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Felix
 Kuehling <felix.kuehling@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

Similar to GC v9.4.2, GC v9.4.3 should use the 5-Dword extended
MAP_PROCESS packet to support multi-process debugging.  Update the
mutli-process debug support list so that the KFD updates the runlist
on debug mode setting and that it allocates enough GTT memory during
KFD device initialization.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index a289e59ceb79..a0afc6a7b6c4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -76,8 +76,9 @@ int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
 
 static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_node *dev)
 {
-	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
-	       KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0);
+	return (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	        KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
+	        KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0));
 }
 
 void debug_event_write_work_handler(struct work_struct *work);
-- 
2.34.1

