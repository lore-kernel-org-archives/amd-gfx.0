Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3478C0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 15:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F77C10E488;
	Wed, 26 Jul 2023 15:15:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E42810E488
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 15:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtbBeDqbf/vTytUgCflPIol3FkAgpc9RRdHpaFhk1JurfqSDFL1vnrsG1sF0H8NS40m9uqAyM3GB0BxJeUIT/IpSPHl5VYiW9I3GNART+JWyTgYHRhjXrY0LQQB9/uPsCjDYUw8OiMQnCgdVwT+qYDAUECWGf8TZdAnkcxZZjt2foxi3dIKvVIumk1MH+ZE1P7QujnkG8RovWyQC/ZP0mSToSlqLFiKjcN5LCXewlUTSv3cDbFrfZhwgxrClfdpqkpqpEwK6lsPQGdTNx0IfQ7BHwnxNhYaZcvCiYHboeU8iu2ME3WhUNUOIwv1p93rCIyT2EV6tGLjJ26Am/klyEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KT/axlcP4wiUZoxr7W3v3yRpRh638IMLu1+J51dd/p4=;
 b=V4WPaTt8oCrK1nwaQWmyUsgDdVcLcWicHpkacDDPk8AvhSgGBKmAguwbKBJ48GLUv5H2jdwO26NtdMujthZQ/z9kxwetqo1GAoB8GIVuk0gTzUzVKRqIaXhN8+u0G8VyWf1CgVkhrxxXM7f/K0C5MWJpU65nPArrPkmiNWjj8FI5to8QfVTPqRJ24Y4M3/SxvPRobKtIi5ZwuUFmKbAUtEANVwjFoFAoSwyyWJJZb79LlxVwqoepMWqeeReZFSMtpAW2TxWL37+UqpSV/L7uCvjtPYEcjFFWIVsuO+7Cf8PChnXMc4C1FoOBpcHHbhWUaGOcGfWiAhElYsYkzR2aoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KT/axlcP4wiUZoxr7W3v3yRpRh638IMLu1+J51dd/p4=;
 b=5AK7HpCZN47dF+ekcbUcwDvxsjM5FwCwLtUPfQ8QOIYf1ZvLvhCqnSvgY7YyxRZdIq5u3+QZ5iLNWlt64a/4AtjDeFbyThqQl/wJ0f/VFLxKEzMfJO/nCK+X07dAC2fe/7E3RpG9qqwHZgZDQHIRRdtHR9MymtEbpjP2gqdzzCM=
Received: from BY3PR04CA0009.namprd04.prod.outlook.com (2603:10b6:a03:217::14)
 by DM6PR12MB4927.namprd12.prod.outlook.com (2603:10b6:5:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 15:15:16 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:217:cafe::a3) by BY3PR04CA0009.outlook.office365.com
 (2603:10b6:a03:217::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 15:15:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 15:15:15 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 10:15:13 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdgpu: Use parentheses for sizeof *numa_info in
 'amdgpu_acpi_get_numa_info'
Date: Wed, 26 Jul 2023 20:44:59 +0530
Message-ID: <20230726151459.2490598-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|DM6PR12MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: 118f0aa8-32e4-4e67-547c-08db8deb1dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4zQql5BGJkXCK048IXqQF0oo5fp4EuWbdkbTy3bRz3H0GcdSiPCkCtRKCPde7ypZzS3wVvI17W58UDcDnyRsbj01n1Kq5UHf+uoJeorZBJMZQobuHGvR6lfkOOX+0lB7kv4bwzvVqgyH9mrmHFinC0sW2F4s5Hr86kEIIdxgvpc8rWR4uEg5WLhXUmeudO+ZlcunAkgdzezyV12sJD5O1x8kG3KFZkEyHDS/uxvQiCfxX211nTl8N+UsQ1NIJapBF5GetTNHDAUTtOz82F26lm8lLPHpiaO/xn/pmXANSM9sjt28zd+M8E1YVsAW9np9+e4kbELlenrhxDYKw+EwPhSd/3Uc9qpBiEIbvBbWvVygqIlWUHdVRAvoDbCYkrXCw8zxzUZP0DEL++UXLYXqgnTIkiVgV6GLtqM7khwpmg1kv1Tx7BwIXU9SPFjfY711zSZAJurysKtiU8bD9eUIGMOH5J7W/GkZIzVCT1LUuueCY3MJ1ijT8A5ZoDnc4ooS6RJZpPCvqK4Fn9fLt65lt8Z6D71XflxQAXXVzO/sWI2KYgj6ShVGEhoxjgnT+Ia68ESpqaIEbeVZAB2z7+lUMjOcRsLCVugEuA4OnCBI4fo/ENWC0yS/5gd+MxoHWUhPDpK0Qo2ZFu0ZmIQKwRux/XR9D2lExDuSzplJI/qoR7M4NnJOpzyIILgBKn0jsLz1cvJ/AVBrU7JFywNKfdJ4mYeX7ctnS66eBXcs2/J8Dh5jz7vqHVdQuRifuKv2GBmmbPgjb2FCY7U3x5gp+dkNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(36756003)(16526019)(336012)(7696005)(110136005)(6666004)(1076003)(186003)(26005)(54906003)(478600001)(83380400001)(4744005)(2906002)(5660300002)(44832011)(8676002)(6636002)(8936002)(81166007)(356005)(70586007)(41300700001)(70206006)(4326008)(316002)(82740400003)(86362001)(426003)(66574015)(47076005)(2616005)(36860700001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 15:15:15.8971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 118f0aa8-32e4-4e67-547c-08db8deb1dcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4927
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:

WARNING: sizeof *numa_info should be sizeof(*numa_info)

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 385c6acb5728..a5a2b06c6588 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -868,7 +868,7 @@ static struct amdgpu_numa_info *amdgpu_acpi_get_numa_info(uint32_t pxm)
 	if (!numa_info) {
 		struct sysinfo info;
 
-		numa_info = kzalloc(sizeof *numa_info, GFP_KERNEL);
+		numa_info = kzalloc(sizeof(*numa_info), GFP_KERNEL);
 		if (!numa_info)
 			return NULL;
 
-- 
2.25.1

