Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A1EC6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 21:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0FAC10EC7F;
	Fri, 24 Mar 2023 21:52:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC2A10EC7F
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 21:52:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8GvOU5XjMLZXmSXcuXyAKCcAQzjJhvRQDICQAv5LaQN/w7gKRsIjBzZPKfIj/dtuLdUvsoyqRGMs1ACg6QcfcTBngycl+E/7HWgOGbWxTbo0n9Ropd7eE+t0X9nee8O7spTt4esB3AbWiqMrLL6Uc2TUs5CbqzY1vAJx3F5zMlI2HZjdHeCNeKO8thC2NKoXaXSuc6+o+mBjcIcCI0q7pT/lncIy5nZBy3nlhUtbrwVAys/A8DWZ/rLXfJUICEaW3g09hU11CXeij860fkGhQXMjSQkedqM9y25V6BfMFsXeE/fhMcrz7PINC8usp98KPSth8yfdshdZL7p6ie4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WWu0qAGq+yc2XiGua0B/9MvoQ/sCH/ix+I6pSydS/g=;
 b=Iq7SYCBfMldyh1XEam5R4PRnGUyeikZ8XgY2Z9QFI2un5sKFN4lD9BNW80UfSFIpB5CE5eWKcsJDQU79hjGGhgzFoJFdhLQliLlGNqEGYflW3pRUA+rylWAzdNkXVuxtPrlwrQpWTPA8QJkmauA21UvxhosZx6HE+Es8kCv81IU3kyEeg42HVQunv0+GfgpozwL9TCws366wFMUVyTcxLUhLAhnGqZLmRoL972hlqcVaQgYDN2xR9tmhmZ4VCeMl5EMtbxjnoEm20YNkU3x2H+6x3cF7yedJwtaPO3hULnKCgYIVO9odiStyoQ/qR03qh+21v58TkdVmpfv55M+HAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WWu0qAGq+yc2XiGua0B/9MvoQ/sCH/ix+I6pSydS/g=;
 b=Eg0YqmQSFeUZubzc8a2sypbmCn2dpzQDmIIxOPygRW7lBf02gow6ZHeUzH5FYYzgRAOIrQUhS53XxZYNd+tSCvfzWnWFM3LmEf/m2ddtztreOHQsNjSnQJ+QJYevPbpHZscIG5kYFx+TNdWsdX261c9GWJR9z7/EWbsyoJ9vI3U=
Received: from MW3PR06CA0029.namprd06.prod.outlook.com (2603:10b6:303:2a::34)
 by DM4PR12MB5277.namprd12.prod.outlook.com (2603:10b6:5:390::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.39; Fri, 24 Mar
 2023 21:52:55 +0000
Received: from CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::1f) by MW3PR06CA0029.outlook.office365.com
 (2603:10b6:303:2a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 21:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT108.mail.protection.outlook.com (10.13.175.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.9 via Frontend Transport; Fri, 24 Mar 2023 21:52:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 16:52:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Set family for GC 9.4.3
Date: Fri, 24 Mar 2023 17:52:37 -0400
Message-ID: <20230324215237.2560126-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT108:EE_|DM4PR12MB5277:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf9cbb9-aa83-4454-f24d-08db2cb21f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0sdmfkMYqq69TP7nB/KCbvql4bAZzeijeqWx569u4tfQFDEJmGOmCuX3DegImIDZsVJDdzLWhOns43N2WwaUp8EdxNpqE7j/bW6C6m1fsGSSNtSM0bQBcxEjukyRic1enI8TC2mSqpp0EX4R+K/crvo8IzdmjziKoferUAsM5rjHJSxKFYkFoYM8u0a4jOMPjfXbI8I/8ECzTLos/27AZSlVHgqOuWGwodthYTDTXTRc9DqeV6XR6QF3yGRl+EUlp5kwukTdSYEMQA/1hcRKuo+KpxwADE1xQmC9bZxbTBn2zeLQ2721BmvnauMUEhuDuxEIJnB280wD6LPQ6nYPzPdA7XcwIhF3yaqDKZ8Mh1mDC1friFztkeKcv1ef3zCHo8y4OQQV6lt9DzQJSaTl2tra9cZt6eqTO6zfkPEN6LnWsRCDkSIgtGJakzXA3Gg70Hbw/om3YbPNiPgd4yYv2R2SUSmSxHgWd8wUcFq4lwRxzsidOdx6dZDRvgwEw3Wfab+ZyYhTUNws1PKVJ10c7TcDM7avWpHPS8BbKxK8HnJ+4w3HnEciNReKxFZa0uT5d+ni2TuAc7BQUr/gejp5Slym2CiWMxC2TkXLzpFGy4bhDUMl7jzTTCGIbDx3BBrtP51nUJQpLNFrbJ8O175/THA6KFf6HQFhrKnNfft/CP/56aiS53X1JoAnuX0rQs2djZMT4CryslG3vg+XH1o7AZIrnwROJXZe1zasgKbaYM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(70586007)(70206006)(86362001)(36860700001)(8676002)(36756003)(2906002)(40480700001)(316002)(40460700003)(478600001)(7696005)(356005)(54906003)(83380400001)(26005)(186003)(6666004)(82310400005)(82740400003)(8936002)(6916009)(4744005)(41300700001)(4326008)(81166007)(336012)(16526019)(47076005)(426003)(1076003)(5660300002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 21:52:54.7568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf9cbb9-aa83-4454-f24d-08db2cb21f98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5277
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Set family for GC 9.4.3

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 738ac5d902a5..eeb8636af3c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2181,6 +2181,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 0):
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
+	case IP_VERSION(9, 4, 3):
 		adev->family = AMDGPU_FAMILY_AI;
 		break;
 	case IP_VERSION(9, 1, 0):
-- 
2.39.2

