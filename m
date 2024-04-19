Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7C9C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 09:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 792C110E75D;
	Fri, 19 Apr 2024 09:30:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="or0bRTUT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAFC710E75D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 09:30:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQM7OdrUaLP8KES70i06wDik6MBsF0XT0ZWolQ/j9DNCgIYAnq8AWGwjp2hYv9GRRIpV1ZDi7dLuXRLztkm6Hj5DS1kSxUgErGtOsyWrDSsVGuYVgRD1R+Fst73/nzgzlAj9zFupIc1E4s+ucY1tVrEIJd3bmJ3qh1/EaXxZliiwMOVjacgNFzbXFea5pZSl55t64wvOx9nuA4PiqOFiIzFb2uX2RYckmKuD9YtVpTdfav8XwcxbVyQCZKo2OgpqeUmNncWqQt6Z+LeBnChM1jxV0g8i+kVYimr+5IdDstTv5W/8gDNMmPZXbkYdmYeny6S0U12FmBSODRs1y9a0uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP+nZa7CDeq9dA96AIIQ9lYMKK+WYPl4ZIPP+NAGOuw=;
 b=ZUcAQq6lsymSmtnts7PsIB4JlGtgq5an0XqEQd36F9TQg1wg77wz7dvf7AiwzWGlkUJS8AYE4yo2lv6FnfV5Ly2DRieUyr0rlk0WB+CFzODZpsI0f46wwZtAX3gbSryCqa1FlOjq9TJI+LIcsRKQ2dn0vws5TNaEuiR6BIjtw96B+C9q/c5sMzRNhvYkGBOY9Zu50AjrtQPQHLjQYzWM8zJED0+Er/q3/Mm/sN5Sm9UY3KL6IXa4gnhIyL+OJ9kH1wfQJMk7jaBhHd5uD4pHA+zoBRrWslskK0ENjsuph7YcINMO4WqSX1wqFXxgq81qefuNdNQ/QJjob3P3sCZilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP+nZa7CDeq9dA96AIIQ9lYMKK+WYPl4ZIPP+NAGOuw=;
 b=or0bRTUTF0W44eja/E7q4YJ4qK6yg3ucTpW7v87iq+ggDKQKsw31yON4iNA4gwbGdxlas9ULc7hAedYgLCUQemV6KFyTB9ZUCmasXhY7tfDz8iC56NX1zpUFMrCzgVjjHvXd0U4g9faEAFKnxyIZByLRdnZADwu7ITk3fhsrZCo=
Received: from SA1PR04CA0004.namprd04.prod.outlook.com (2603:10b6:806:2ce::9)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 09:30:27 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::75) by SA1PR04CA0004.outlook.office365.com
 (2603:10b6:806:2ce::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.30 via Frontend
 Transport; Fri, 19 Apr 2024 09:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 09:30:27 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 04:30:24 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Li Ma <li.ma@amd.com>, Likun Gao
 <Likun.Gao@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix snprintf buffer size in
 smu_v14_0_init_microcode
Date: Fri, 19 Apr 2024 15:00:08 +0530
Message-ID: <20240419093008.101710-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419092524.98737-1-srinivasan.shanmugam@amd.com>
References: <20240419092524.98737-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa5a0cc-43ba-4807-5818-08dc60535901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3thBikJdsDY645pbE/+84fG8uZx39vZgbJV0TmnAnJkTbwJ9wzWb2s+GGFnfQzi4fEDguCYTevPojGoDMeql5r93wWK8MJl7O9a34bzLhsrf+5st2ssL06XigD6BLHs88DVimBhjvD29kbjWOXoXVbr3vNbSGenOYyCi/8MHdsILiIrDvvClqExZlEiR3rra5CRE5GII0QdxAgozl5JTNWviDsUxHPiWqAgO7ksVjbIpuHk/o6xSnnD2P3U068s+T6mUD1PL0Rj1xCY32KlSqqS51q4b1Gc+pQlty6DeVDgmhD+uAB5RONHFuM228pFOjpWCeIwUAXRM+6K5CYWCqWFcLeefyMR90lhEm9XLQYkt0x4wPOq//2drPQQ38n4AuFJmezoKJFmEFYQx9ZkqGW7I8CXKFkV4nP96UjukQrWCH5bwKfMYjHuhSAHo8qW5L7jR0MEj9vA4tRay4W/NNtasIliv/BJawvInV2uFcIu4x4wh1/ezCe5x3QEbTqYbhOWyYYKMZA05gHSzFzsloUwuwSdSpxwoIR+ly1yc+AqkmjtMMY2n1gUPNw1NjFJ54Z9Im8NFC7RSnCVwpo+szsqyRGb8snEdsJZYxjphL2Acpjgw/RAg7yjxBQeSSs8t6n6b/jX2LupcZkc43CaYTF75zvNO693bQ51fgITZuMJx+DT9HrMrsTs6hoe/Spew5mmngQyYu4xG6tC3/F4FZSwgwSi5PlycyBVuqs5oNEfiF9ud7iuA4rZOgxZIMPn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 09:30:27.0173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa5a0cc-43ba-4807-5818-08dc60535901
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
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

This commit addresses buffer overflow in the smu_v14_0_init_microcode
function. The issue was about the snprintf function writing more bytes
into the fw_name buffer than it can hold.

The line of code is:

snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);

Here, snprintf is used to write a formatted string into fw_name. The
format is "amdgpu/%s.bin", where %s is a placeholder for the string
ucode_prefix. The sizeof(fw_name) argument tells snprintf the maximum
number of bytes it can write into fw_name, including the
null-terminating character. In the original code, fw_name is an array of
30 characters.

The string "amdgpu/%s.bin" could be up to 41 bytes long, which exceeds
the 30 bytes allocated for fw_name. This is because %s could be replaced
by ucode_prefix, which can be up to 29 characters long. Adding the 12
characters from "amdgpu/" and ".bin", the total length could be 41
characters.

To address this, the size of fw_name has been increased to 50
characters.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu14/smu_v14_0.c: In function ‘smu_v14_0_init_microcode’:
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu14/smu_v14_0.c:80:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
   80 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |                                                    ^~       ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu14/smu_v14_0.c:80:9: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 30
   80 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: fe6cd9152464 ("drm/amd/swsmu: add smu14 ip support")
Cc: Li Ma <li.ma@amd.com>
Cc: Likun Gao <Likun.Gao@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
- Updated commit message

 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 7d2055b9d19f..5d9335cb8530 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -64,7 +64,7 @@ MODULE_FIRMWARE("amdgpu/smu_14_0_3.bin");
 int smu_v14_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	char fw_name[30];
+	char fw_name[50];
 	char ucode_prefix[30];
 	int err = 0;
 	const struct smc_firmware_header_v1_0 *hdr;
-- 
2.34.1

