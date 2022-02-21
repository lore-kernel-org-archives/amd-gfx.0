Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383EFC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 10:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B53710F266;
	Mon, 21 Feb 2022 10:17:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2801C10F262
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 10:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNdlOJRt6yZXmzaq23p+UW169XwUtaWNwUnNIuBKfJWYZw3P7P9nFHmYMq3nhK6nNRSZi23Co3VWw9YMN/++Qh2noscRAR93Ex1NAP/szIBToNsFUx6dETVBBOCoFHwT6GK7xbb2QEvQ15RbjaqXhyOeXQTj0s+vZhIn/IphyhOd/fE8eF4rHzhgzrrDcc5i1ph8Jzfzeod+3CUb0Qr2bSCOmljvPxo9pNj4O/zsV21kGY+OMt5nLcLx3kmq8AckG1ZvZp/3m+FcV+lKuTmOO08v1IE0JXywJ1wDkQKXCzrKEI4cpU0FvNmITue6N24F6p8gjPz/pLs981iW6gwECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KriS3J7PcGLr44NuWXGaK1Fg01FTxr92MAnmyeTUTcw=;
 b=JV5bRrPvePjA/oat0nkq1lmCAStWzafig6sd3HNQvxvoctZYBMdBvJzP7LJdbuVe7X1ejZuwXAG7qDntSsDq990alCVd9sm+9e8kl1vncPojo1t5f8eEKDdSQ3IiyXlJcgOg+CE/cvpgS9j2Ds8zQfT0SgJsHYPn0SVDoVXqgKrWiqdyIO9SuGu1YRYerYLQ65elJ0h52yngPWzJX1WsLDbWXTbxjpxS+OMDpjfiUePsZHl3/psn66/P1JtBGzzVq6+X4mKxuy6GBv7VBvlg5ExYkXpHfGFXpPefw1JYDrBuX49ba2tXm4b7WmUjIMFjTP5YSJyO17jTo1Gk/mEGMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KriS3J7PcGLr44NuWXGaK1Fg01FTxr92MAnmyeTUTcw=;
 b=qORnBVpGKzoT92WSScnekDdgHARJiENsGm3kLDKpnEcU6/r0Tn6uXG+zwJSSTzh6rPBGh2t3td5F88qbDAUb8mtCX17v+sOipq9LMzSUR6/xEL3yLGE5oq5Z/+f0JMS53hQO6LkgArCRi/K6TyIMdpy5ST78AR/pRWuCY7KXz50=
Received: from DM5PR07CA0037.namprd07.prod.outlook.com (2603:10b6:3:16::23) by
 BN6PR12MB1731.namprd12.prod.outlook.com (2603:10b6:404:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 10:17:05 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::8b) by DM5PR07CA0037.outlook.office365.com
 (2603:10b6:3:16::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Mon, 21 Feb 2022 10:17:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 10:17:05 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 04:17:01 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/12] drm/amdgpu: Remove redundant calls of
 amdgpu_ras_block_late_fini in mmhub ras block
Date: Mon, 21 Feb 2022 18:16:13 +0800
Message-ID: <20220221101620.3269611-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
References: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d5e1191-4c87-404e-d59c-08d9f5234f5b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1731:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB173128212F40B066A1ABECDFFC3A9@BN6PR12MB1731.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRh1fj2m/dW90cDYalSmwxZrfbXMXFJCuaoXFc0O9HysJVWhJdvIQ2xY3yTk6i6r3ApPT5trb1PwB9Zw8YKrbYfl4uT1NvKWJ8GRnpMjQjeYR1Gj23JuhX7n0AZPRmJ97bfMYwXi6lGHa1/ILQppOM8I7W8V23ov0sEp4dE+whXwlYNse154QmTdqbYgZIj+s+ITbor1XE7Whw7zdAp6iVCRXE1Pac5Djcxi+YJg5+VbUd6u3uQR6X2sn0x1lg3H0HEJhmdkXc7W4Ku5+rLIG9YYkCXSZAh5lkU6PRp70YDR3fsm30yZOF7to4KYIc4Jxc7DGB1tSei+FWhLC5sS+XLXu2IXHCg1OFSuyF1ZiCHd6sMw4cAEItdka9rRHq5RbnJbBjhcudL+46KHYn0r1C7iElwcJ6Fou7iYTeb/Hjpd1Z0V1+UXmclhX7JGoWsdb0vGslr60afADTHyy2wxGJYm01WNufpfiNLe/E0ycqJUsd61jG1FGOL1Sc5k56LCqzFgb6L4xUj1UZPtU3R3Wt/JUHGg+tpVxMvwlOl2/d/cifnjw9K6gj7YjIsdC7gIz9lqUMc25iII+m+4hZTU0LrNv+ujnC/hFj+QxZB8fciiyz4S6NXjFy5xUwmjupDHvX7GtL948Kq4MP1D94xY5jrMzWTU6Hw+B+YXPHmdhImaFc49KJG8vA1kZ0OmzO0XdXT1OvmImPgGSGuGtm780PUmj1/vWw9HM3qfuHctWsE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(26005)(86362001)(40460700003)(7696005)(81166007)(2906002)(6666004)(356005)(36860700001)(36756003)(47076005)(16526019)(70206006)(6916009)(316002)(508600001)(54906003)(8676002)(4326008)(70586007)(8936002)(1076003)(2616005)(82310400004)(336012)(5660300002)(426003)(83380400001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:17:05.2621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5e1191-4c87-404e-d59c-08d9f5234f5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1731
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove redundant calls of amdgpu_ras_block_late_fini in mmhub ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h | 1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
index e7c3b8fff868..8f2fa247d605 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
@@ -26,7 +26,5 @@
 
 void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB) &&
-			ras_block)
-		amdgpu_ras_block_late_fini(adev, ras_block);
+
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 253f047379cf..9f1540f0ebf9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -47,6 +47,5 @@ struct amdgpu_mmhub {
 	struct amdgpu_mmhub_ras  *ras;
 };
 
-void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 412e44af1608..2f1b092c53b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1293,7 +1293,7 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 
 		/* If don't define special ras_fini function, use default ras_fini */
 		if (!adev->mmhub.ras->ras_block.ras_fini)
-			adev->mmhub.ras->ras_block.ras_fini = amdgpu_mmhub_ras_fini;
+			adev->mmhub.ras->ras_block.ras_fini = amdgpu_ras_block_late_fini;
 	}
 }
 
-- 
2.25.1

