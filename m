Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20458C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 03:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D88512BCCA;
	Mon, 18 Jul 2022 03:36:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F37212BCA1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 03:35:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx1fIuWTDym28Telg4zElc3GxYeItFvkwk+Xz12jHZNO6lIilTFuTkyIxWFhYvz0dpfRdZBIYgnS8DCRNZN0GBqSmqkxBn9zzdjfjikhHcENe0TfEGKvH+Zx86juQREf4Mp4NrJLZ52lVB9BeIUhKk6PMgZhRGHAliQ+UNaK7TA+iTgAKXEjHZgFqnj+yffXQSFE9Oqo7nuMCdnXtEedipd0iLRjxEJzDzo6y6EyuEeyhLfqQ7TNpAiWrAdoIpXBNPmVOahplA8cID+PURyF9uutDdBXeA807511wi5OsrVioCTlkhN7r8l7MtJVoaJCd1uFMLRIml0b2xnC3cd+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZobmwoeVlSxT1ARVB6+JkMxviOlW6VS95jPXj5uJ5k=;
 b=nlTc9rTgXXHGEGCGFm7+C5GXni5RTxf4WTADwFNoRO5AfHtoHosUVyIBsu53K1HnVk1a0bnLzxI5Lzp9LXthvXqFuR6DWeJ3IQYLkjjmlrNwnidyBimKKZqCanptCR5Th3s+3cl3sZYyfeeqwSiZTwXQ/GcwivDX+dKQrBiHGY/pXwU+KDz+e+T+A+sYXvatYXqi0b6tdrOQvcsdXbBgQx8xEwvp2Sg5IXrPqHp4mbtZSwWbfUHzRSknd2sCCVPxe1Zp5a0S0wDb2ykeqUc7eVwfz3SlolrswgFFJjDRFMXrJDHIHIiUC8flB9C+BqK3b/9pLwdedPD04MDjkYkJ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZobmwoeVlSxT1ARVB6+JkMxviOlW6VS95jPXj5uJ5k=;
 b=3XGOJnVvCIOI42ZvQc9IcUVaoGnanmKMePbn2Qb4T5fgGW3FlWLK+VeDECOJth/W83IgWWSifZYj2jgLAVupx7RDy/yVt+Mzi0eoctJFuNBquKtQKgKwkKby5t4aGi62RwzOLbQDCTn4oSAOKHhpK30xJuspAKHwWgB6v1FNcb4=
Received: from DM6PR11CA0039.namprd11.prod.outlook.com (2603:10b6:5:14c::16)
 by BN6PR1201MB0257.namprd12.prod.outlook.com (2603:10b6:405:4e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 03:35:55 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::23) by DM6PR11CA0039.outlook.office365.com
 (2603:10b6:5:14c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Mon, 18 Jul 2022 03:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Mon, 18 Jul 2022 03:35:54 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 17 Jul 2022 22:35:52 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <john.clements@amd.com>
Subject: [PATCH] drm/amdgpu: correct the PSP_BL_CMD enum
Date: Mon, 18 Jul 2022 11:35:05 +0800
Message-ID: <20220718033505.9635-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1b9fb61-6027-48e5-9dc6-08da686e9eed
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0257:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6KRubi13GOODvVydsCCMi2PiFniJwRGC8XHxcPWZ9D9BTvsuTkaWU+Vfn5My6l79AhYSud3P5E7d2tk+NHmdwu6vEC//ZPc/UFnIkPaeYuNZnwK1QZkpKY1+bb86dllIZq/4Nlt0JjJt99diAHN+Gfco4kFgJlAJC7QuC1z0wA8Uzf15ceRLacCB0F3kVnnzwI77yeU5KaB/tGa4Pw7eXiseVrqWuydIW10bP04jRwwCSzaEa5kwbGuoDaKxPHNqzcvbm+weaJRXtIiVkzBE1TdcBqzOy2tYUDxIycQCKUKMZMmSKNgxJkxU8YGslSsxabzjZttFrAFvhjdWGlO5WFy7+s4zI9+7OdAhKJ3/B04arETH1e7gy4e6EGF9oZNH3tPvvzPMlGiA3nhFWPVhsPv/PqXcewzKPhPu7Kb5iR+UbDFzayX+9hXYaK5n3tCJHRvRKTRsNHgwUyQr0L1rYsVoll7I3IUmiYH+kffQyfFRnl8x2LKY2agql0mrO/SfXlaPtFEeY4CDr0gr2cMG8YqEQgAV9HvBagxdA/gydnQ/Co3NKMGdweAgTxUsFMHpkR23fjFl9nrqZiIpYk2zE1KmAmuAN61NxGPa/LUUWpVXGtEss7U8pG6NC5uiQUHqqYv8dc+ZpUFhLI5+JNRbIeKvjBa06vJnSNE8/JFRK/vOs7zRs21a+Jefqp6Dl/KOS1atC+2Ha1fZdMJcO4Cr/VYvEahVnty6x0Vq/FB/yCpGFN5g+BgI4sFiYslywQ4d9tDQ4UUnBbHvL9/67sQwRiqjhMRzgGYURphTEk1rorcgIEI0Aq6iLuJwjE9Rb2tN/R4Y6zJzLqGUlgiQgJiSv3ESKcx6wMW3rV4mNfAK5c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(36840700001)(40470700004)(46966006)(36860700001)(47076005)(336012)(40460700003)(426003)(40480700001)(83380400001)(81166007)(16526019)(186003)(70206006)(110136005)(70586007)(36756003)(316002)(8676002)(6636002)(478600001)(6666004)(41300700001)(7696005)(8936002)(2906002)(5660300002)(2616005)(86362001)(1076003)(356005)(4744005)(82310400005)(82740400003)(26005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 03:35:54.7316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b9fb61-6027-48e5-9dc6-08da686e9eed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0257
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To match with the enum defined in trusted os

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index e431f4994931..180634616b0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -69,8 +69,8 @@ enum psp_bootloader_cmd {
 	PSP_BL__LOAD_SOSDRV		= 0x20000,
 	PSP_BL__LOAD_KEY_DATABASE	= 0x80000,
 	PSP_BL__LOAD_SOCDRV             = 0xB0000,
-	PSP_BL__LOAD_INTFDRV            = 0xC0000,
-	PSP_BL__LOAD_DBGDRV             = 0xD0000,
+	PSP_BL__LOAD_DBGDRV             = 0xC0000,
+	PSP_BL__LOAD_INTFDRV		= 0xD0000,
 	PSP_BL__DRAM_LONG_TRAIN		= 0x100000,
 	PSP_BL__DRAM_SHORT_TRAIN	= 0x200000,
 	PSP_BL__LOAD_TOS_SPL_TABLE	= 0x10000000,
-- 
2.17.1

