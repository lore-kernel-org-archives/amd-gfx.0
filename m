Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED26C19F2D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 04:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B6DF11ADC7;
	Thu, 11 Aug 2022 04:59:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B885111243D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 04:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZL/x0v+3AkurNFK+8W3gbVPgl0/Xrz/b9wuHvL5/uG80aLF0jMxQkMzfh3dEbGZBcd3iIKZQgWAeubZ5gELZMtnpaOu9KAteQoXca8DYsEcX16nsWxA6dWRaMjJ92uTJLznkUcJ9nGNtPTi8fXrfhALmFXis/koivT4yh2QyZLWpwojxOCNLau3oU6xkeHwfVHw3A7joUrsYVjrT/avFoQqGx+ltZJp25nKVj0oba871HDVMDzme5JYDgS7YnKwhbQ1FzHtOk1mNsOP1rjCXd9YBZfyoN1gVfdHYCAYK7AvRaSXxfNSZq1MTA+FlxNloqnfECVXGziJmhLF5U9o5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWCaUuZVgsoLkYZjrUXnpaDyl6drVzglvxEt8c3UDkQ=;
 b=MwLtc3Khac2zSo6cxyrY2MctrzKyeym3dwV+6ZH4vneV+9wo2umEjsgw3hUNBJvRJR6OymbIwTayBBv6rDEHMFjqJ5Ts+EXYyGugvIqJr5YU4qxnZCuiYo0vuN+NlPZ19XHRdcOmLqw2kUNi6bmap4K7n2mQ4uQI74iq3H+wSNd5wYCo7xXv5sXyHSDWW0KdvePUQM03gZqHSrQl+8oIKY5gwiL9HvkbabvrppGR0/GtAlryQiUcaxOrk47skT+rZfCiXP8NL3zLhyc/Q3xG4ADUEBx9L0JiasciG1xP4xEe0WZau5Er/a1OYPRovk85r2Efs/4OeSdcCbEB/iYSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWCaUuZVgsoLkYZjrUXnpaDyl6drVzglvxEt8c3UDkQ=;
 b=zbTX9dkhE6zmqjaq2NY2p5wH5IZusYI3fbG3GVk6toLSeYagm7+J/cG7k1jAavB/56IV6snF4/3AGkXy8n4XWlsEiprXIxGvcQsZnFO7+BwMEFUoD/f9rpwviZ5a0lSg3tMGTbVSURdv52+ysZnN5VaV8rJGitwy8WJWCOdDK1o=
Received: from MW4PR03CA0338.namprd03.prod.outlook.com (2603:10b6:303:dc::13)
 by BN8PR12MB4770.namprd12.prod.outlook.com (2603:10b6:408:a1::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 04:58:52 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::b2) by MW4PR03CA0338.outlook.office365.com
 (2603:10b6:303:dc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Thu, 11 Aug 2022 04:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 04:58:51 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 10 Aug
 2022 23:58:48 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amdgpu: enable ATHUB IP v3.0.1 Clock Gating
Date: Thu, 11 Aug 2022 12:58:04 +0800
Message-ID: <20220811045804.3750344-7-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811045804.3750344-1-tim.huang@amd.com>
References: <20220811045804.3750344-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f39c937d-fe04-49b2-d089-08da7b562f1d
X-MS-TrafficTypeDiagnostic: BN8PR12MB4770:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WUJnphOjTWXc2VvYQyw7MMGCDoqN2wIm9dRXcHYlnadfMbJ4PH7NwDp5i9XlKN16YHxQwlrxXauwdVxBjFXfHWrhW9n+sJUQQFThxKLDfwJ6AT9PUoYplGd3iUSUuQVobGyLg4D6Vk4q3boRrgw+0ZiT3l9pREigDNFNuk/k5J7K8mrNW1hoSIk8BP1KQnrr1ZgpijjaK7ChCnjI70SVq/YbvB/vyruimZDGGcBuSvJtHGUs5gWeEnMQWKYnB1T1IGQargfGgKjRA+2dC07MIYh+OJeHwKz5I8BymAS8n6BrkdLNz77R1vo11sJ81JBCkfWphCnCqKufZGwvT7GfDkRnapmxv/lciuRkDesY2oGWZ3b9bmmRoQsHY44UDiKiR0ts6bZUh8BFjB5iRYH8upFlvR/1LkBZBuG/WZDiB8svSr875xZRY2/DMBNAIS8+qEiNmoTFdi/U79CpXjTIk37lkwYEpQmW5HpBGLFQ53M9fkCd19e1JqM7tL6jXPUk8OwNPPtU38xlKfHMYPEBqTXTWTzcJgod73ITGU8K7kff54qC0CTuOfPIItjN/JNlWe72lYgxGq3OpOHvTcu7oRgC91sjJ6Yh20Wuort+SZvCa5Hdudre0ZWYj33Pqy02nx06jHjrl26JH+Ew8taF0+v9pvpbbV5gsaL7/JKszswPtHATzQ1O+8JBEIyJ3BTiUuwxnaat7HSQ6KmWfbKuEpyb74bsR6+NEKHqEACrgZ5qomsclQEEFikUDJteRhV0UsDLY290g9rzk6etNsfL2O4EAigCo7kM6y7bx5iiw8Zt4w1TLZsUiAEDIbCCo0EfU2wouUvkBhGlTXjdgjHKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(40470700004)(36840700001)(40480700001)(36860700001)(8676002)(54906003)(6916009)(4326008)(36756003)(426003)(47076005)(40460700003)(70206006)(70586007)(316002)(8936002)(5660300002)(2616005)(86362001)(41300700001)(4744005)(1076003)(336012)(44832011)(16526019)(186003)(478600001)(6666004)(2906002)(356005)(81166007)(82740400003)(7696005)(26005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 04:58:51.2514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f39c937d-fe04-49b2-d089-08da7b562f1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4770
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable AMD_CG_SUPPORT_ATHUB_MGCG and AMD_CG_SUPPORT_ATHUB_LS support.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index d9e5bae82e83..6c3440e7ed3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -600,6 +600,8 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_MC_LS |
 			AMD_CG_SUPPORT_HDP_MGCG |
 			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
-- 
2.25.1

