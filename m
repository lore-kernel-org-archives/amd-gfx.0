Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCC2C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F8210E9D0;
	Fri,  3 Nov 2023 13:12:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41A5210E9C8
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m049mGxzNAKCP0Wbr0tkVtog/hgdJMrHrMNK946kOJT9DJGKX78OSYbpLWQfRrIk9kkc+qcLv1M/mWT/F+bXyenXmBXl6AxozebjJigKUIt/Kj0+HCDV53K6P6WpCL1Xxy4Zwm1kNT3uRJltWWzSpHaA8Mj0wmXxFWhFAxzHSbpoGdzg7RgarnmJpmueAgYzd0dJ55ODetXK3UC3lBVP3vb4SdfsvZnJ5jjUDhVK+ZvOCVpNLoehnTLB0EKPsW10Oja1jmahydU3KonIAHNATkRm2PsRYrFaN/WxUL8zMDQbX3rkTfxt1YYS2o4EHFqz+l8dkPp3arJcDMEgJ+tw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeqmOF0zcDqnbAoWUdOBDBNHzzm4m/Z/J6Fg9QeuK5s=;
 b=ZcAZLKfKz6g8tnMRV5Ybd/Vts3BojLA+dE4DmyvXvs9rW4Ki+xA3ZE2yJ07Mvcf/D/JdurrXbvf4Jo9f8Dm4uYxSdlPe1PQneu+YZAiqIEtFkR9d0zzPdGktKai1m2Cs+Ig3v7pU3GLxSejH9NMvb9DUKQTue0AM35mvNBHe7bCg4etphZ2VFlWYACJPBffjVZORGhrYZVTgQdqogWMt3MQvxc82cLG1j4BuZIUdwlMTZUEtXiQ+n/NNcxSAhb25WMLNWYHSad9qE7yDuDDVsP9P5wIc2NKJteSBII3HwwBivHLJwzQ2nqI2yojPazyGt/bNKesxbPrJAxBXSI2CWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeqmOF0zcDqnbAoWUdOBDBNHzzm4m/Z/J6Fg9QeuK5s=;
 b=oW+4qyxpu/Z5CpZVo4RL/sW83tR7mBCip1mun6ZfhZd7Kmio50wbLUTNIoTCzQaN0IXCecA0PxR8BBxS7g+0I6oBsKy9y/e0+iMyNFh5hNTZuYSzLngW/fgjpH3ZR+oVFPBIxaGky563Lv+X2IVr0BXfXohKgnngakRgh4Jry4g=
Received: from DS7PR03CA0102.namprd03.prod.outlook.com (2603:10b6:5:3b7::17)
 by CY8PR12MB8337.namprd12.prod.outlook.com (2603:10b6:930:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 13:12:09 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::f3) by DS7PR03CA0102.outlook.office365.com
 (2603:10b6:5:3b7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:09 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:05 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/24] drm/amdkfd: use bit operation set debug trap
Date: Fri, 3 Nov 2023 09:11:31 -0400
Message-ID: <20231103131139.766920-17-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|CY8PR12MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 1227f512-3608-4d9b-f86c-08dbdc6e7c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkqAZEYhPXhjf7lz49ythE6wL9353o2xWhb37lALJoHBuV4LcwpvqyykZ0XpvsN3MUqFUUrpTOWiaOh037IcJ80u0cyzKLa2fnhJsIhEaAX2MbP/nQOE0CgikD2x5S+0KjCMIHFGtloEB4JOZT6+X9dFM9OgwSyrEbo29Z4HOEB/D8CXRYfusISSK22Lu7p9OATsCmNLx64r1Z1+xBgqEHQYAnM53M4ssg0iacOewhbhNJ/JKQjVex9owB6zSuN2IDr/WgAG6lNmeBufGvZfiUd5DrfI9gKs3RPgEYo8aI0RAePurGVwAn7unA77hYUaTsTSgiBB3OEGyXddqQXBVla9TbxgmC5rPoWhUJXDSQRHWV7ivYO5xuTTaF1/8tP2ruX0EAf7o6BqptiXr5PoPXi9GnHEr5h0VIv91FdpZjEi+If14ahqY1FsudBqsvGhxzowEWBRxhJdFGqOn3ZT5mbDOq6HSQ7kxi7K9rmLeBofcac6Cy/Zze810/wTtgT+lociY6EaoSe3EwFTGd7LvyH6L3nxWDRBIppWZYCTdyxRCZ4lRaNcP2ed0b1JjzMG8kLYNX8BlGnDz/n9k6VLLGrP1+FMdy6Rjv33mIGNEdg6FGhO2JMctQl7Hgt/gJfsspVk4qhn8rN3omHCgH0yGMiqtcuKUTPlce8TiKvVblyEWosD9gP2/5i8PnR0CjenAfroyfjzlcthE1slTEVSGbAORTopBnP8MvKZhsxnd78KPRps34uwcxnrud8i1acB6nS5eF+AiOu8azUnnjkvvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(54906003)(5660300002)(70206006)(70586007)(316002)(6916009)(8676002)(4326008)(2906002)(8936002)(6666004)(478600001)(40480700001)(2616005)(1076003)(40460700003)(41300700001)(26005)(16526019)(7696005)(36860700001)(83380400001)(336012)(426003)(47076005)(82740400003)(36756003)(86362001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:09.0141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1227f512-3608-4d9b-f86c-08dbdc6e7c36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8337
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1st level TMA's 2nd byte which used for trap type setting,
to use bit operation to change selected bit only.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index fbf053001af9..a0b729c65a7c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1434,13 +1434,23 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
 	return true;
 }
 
+/* bit offset in 1st-level TMA's 2nd byte which used for KFD_TRAP_TYPE_BIT */
+enum KFD_TRAP_TYPE_BIT {
+	KFD_TRAP_TYPE_DEBUG = 0,		/* bit 0 for debug trap */
+	KFD_TRAP_TYPE_HOST,
+	KFD_TRAP_TYPE_STOCHASTIC,
+};
+
 void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
 				     bool enabled)
 {
 	if (qpd->cwsr_kaddr) {
-		uint64_t *tma =
-			(uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
-		tma[2] = enabled;
+		volatile unsigned long *tma =
+			(volatile unsigned long *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
+		if (enabled)
+			set_bit(KFD_TRAP_TYPE_DEBUG, &tma[2]);
+		else
+			clear_bit(KFD_TRAP_TYPE_DEBUG, &tma[2]);
 	}
 }
 
-- 
2.25.1

