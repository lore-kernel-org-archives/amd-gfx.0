Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC94C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 08:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680FC6EC1F;
	Wed,  8 Dec 2021 08:26:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D52A6EA30
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 08:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUOyh9UGrsAl3G0SrldIb507lz7vfsNqwSyPifdFPtYPu4//tpIwBN9KmeF2SjG5FtRicu+o0xElGBECwU3vDxoyQlnEwOY6Yhcjg4iup/0RdlsVtYooI4ZF7TemKufht6XWZcBmnoshEDjEZVy8BeldN5ZnAphBMAbCD2/Da3AU9CCfcKIjfVNHX9EP2fZVnsOoGMaCuIHv8b88DQr4frMwiSUapsz7FoCFNKuhrSVDn/4PM/e3zlX1YFMmjMMbKI0tEKVDT9l53haEQi1+DKkrmVRd9WqsO0P1fl085EgiBvHxH+lYRP9TFbWz4z82RN8YUaCqh39vM0c6nlZuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNidHmJrAwjlF9nYtpLpuWJ6GSroe+g/kmoIhqtpdZ0=;
 b=CwiwVYdlODnwX5g56Via2a3zmdw1PkeWTmY/B/NGsCESIOR+qDLJUGsnhUsxT5i6QBVrMEKqXG4B4hT88GlCN0H87IPT6am118BbZMKc9DceWYJEnRrxrNsbuABLg9WuZ4nHe6H2xuE1FWBSU5Vz11llQsY8gF2UdhnhbY75nqK4Uuhp+0Cf1B90rRjZLXn3znMmJC+6lOdjhsF/ayNsUGAZzDsksy9JCDbYbTlOJZ9+b6Wu5dJHfRrJXqdZyzip+swHvBKv7q73oTTf03xvTCJUCd6cvFjSSzPmZm4HarzAoaauIPsGQgcUZInfZC+J6nIY+3gbQe88k6yVXzQ8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNidHmJrAwjlF9nYtpLpuWJ6GSroe+g/kmoIhqtpdZ0=;
 b=VYXOr5AK26OXNziSW/hfaGtPF/GiVJAHt+yZ30VfYQ/D5y8N57GGDNsSglYEV1UDuagWUUkFNfHuv16bDiwNw9nxttT8KarogqqyQWniK56VlOy/50VLVLoAGKk3/BJLssAC8eXM/nq4V5DWdErXa+GHCSvKtOAW0i7aRnkZ8P8=
Received: from BN9P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::9)
 by BN6PR12MB1650.namprd12.prod.outlook.com (2603:10b6:405:3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 8 Dec
 2021 08:26:00 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::1d) by BN9P221CA0002.outlook.office365.com
 (2603:10b6:408:10a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Wed, 8 Dec 2021 08:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 08:26:00 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 02:25:59 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: Fix DQM asserts on Hawaii
Date: Wed, 8 Dec 2021 03:25:30 -0500
Message-ID: <20211208082531.918062-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 496a302b-79f3-4b51-3917-08d9ba245dd0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1650:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB16505F805EDA5B246904193E926F9@BN6PR12MB1650.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /P10ypvcvIFZAku/siZztOHdBirdPDqICjMHwOKaw+9FZePKC6L1VtrPo4ghlx0R7uB9ZFuU39prUMfSN5wzvMmbiPhNfK5Scw5gjDYpBSDcc+TTopuSgreNClDlShQ8V3gRAuhSIGqDd9FgyPF01fgJaFqvl5lNQ5omezvkyUP9Zi/lJAPFMI2WtjWCLGflklfr6hx2Zh9D9n/vDQLVfbia2bD/2kcoesqFqjHeaYRXLe0Ucsihsqgv6X1oJ1NAl5VYNLF0sSTl+A+QXbNogHVczvFudpXXE2DsnDFugV8sZ0xoxuN+76b2NxofOWMXrXac+7OPinlORBug3Xf2GM8sy3QvLHv3JS3al/ff8LdiVI3wpvKDCdXJg2sOERvD7vpzcO3QBLZChl4ZKdnZCJSW7lKz+275Nm7U0IkIEsDMU/yRk6gSkk8hzyfAlMT/IuVczIEBiWVZizf7pFbxT/7nBw7ViFFo8nuk74asPhzwffHP3k+5drMZK4R/cUl65VCPm28Wal7Gy5/MyM2OOhVNswovTkJ3NeYKuh7Yjjo3ej/NQ578IGoRajAba0mjgd5maoKetbKC9rNQhJEkpb4Jph1Ko22SSBJ9ZRLvPrZ2jgpF2ZARHDc+jOgKTluVb7LiZYy1LkD1k1MKysW8QX936k21YftCJMKD3BhK/EadsptZwzTljoWHGaBbUbwOkdjxYPlA0HMZixXLQncUVlBRqofolwWaXS+GKElfqk52lcMBP9llFK2BT8fm8hUA8c28Mh1twMIiA68SVz2dgFqEWyVkwqDv/GrHaGRIGq3erpcJJDqNXFRIdIXayeYts6oG4l/R/v/Azbxb6UXHY9nOXR31YT3AxJ8zpNl/3ljKzbZ82PThzwNbu+MWZLuy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(16526019)(2616005)(36756003)(426003)(6916009)(6666004)(356005)(82310400004)(40460700001)(26005)(81166007)(7696005)(86362001)(83380400001)(186003)(336012)(47076005)(36860700001)(508600001)(8676002)(966005)(2906002)(1076003)(70206006)(70586007)(8936002)(5660300002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 08:26:00.4839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 496a302b-79f3-4b51-3917-08d9ba245dd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1650
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

start_nocpsch would never set dqm->sched_running on Hawaii due to an
early return statement. This would trigger asserts in other functions
and end up in inconsistent states.

Bug: https://github.com/RadeonOpenCompute/ROCm/issues/1624
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index dd0b952f0173..104b70e61ba0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1004,14 +1004,17 @@ static void uninitialize(struct device_queue_manager *dqm)
 
 static int start_nocpsch(struct device_queue_manager *dqm)
 {
+	int r = 0;
+
 	pr_info("SW scheduler is used");
 	init_interrupts(dqm);
 	
 	if (dqm->dev->adev->asic_type == CHIP_HAWAII)
-		return pm_init(&dqm->packet_mgr, dqm);
-	dqm->sched_running = true;
+		r = pm_init(&dqm->packet_mgr, dqm);
+	if (!r)
+		dqm->sched_running = true;
 
-	return 0;
+	return r;
 }
 
 static int stop_nocpsch(struct device_queue_manager *dqm)
-- 
2.32.0

