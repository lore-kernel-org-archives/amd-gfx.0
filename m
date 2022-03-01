Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE366C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 15:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A8110E4DD;
	Tue,  1 Mar 2022 15:02:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE92210E4A8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 15:02:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpa6GGkAT7UPolJtIb81yjKRIax3N51fceUhm9TluBfiC/Ym4jp+0selK+wmqlOgCltriKkdi2RbpwmXPjd0tARdFVo4pS4YmkNMAUOxTSGUzZsnQCgjez9kHt7b2LmBtWAhu71xnN+wWQo8aa3pwf68R4GZAAYyIVf4sw4U/+ER5yh5IP2hSV08KsQORVFS+65s1l1qQlEnIgPI/wr4O835Dm8RUANSu9lgSVZ2IfggqylXQEwCGVA0vsOOFXHOW8d5Zv8Fpcz2gaQPhGY1jKwgWqUYM/fBhXq7M6tsgGg72cdhKwFhPG5gXamyrmYNaWKjLn+2cLqgfkJCj0BBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixKpqCsr8eoEoVUnDXjif35kr36TqTel50QUZg7J1lI=;
 b=j2RBS+SvtyUcYUQm8QGJ9mOMDYbSA0yVGyxkCx9vXp1unYb02rL6iBNim2/7hyDXfSt5SJ9nPoOFUOTwPNolhBmj57Zg/hxtkaxwSjnx5QBZ/cNXwlTwSbWhbWfTJ3giBBNEpHqcXRnn53kYk+lNnts2bi7vi2gfDsbddNrC2oYgWQWp7UEj8E3AyC7rjnxyCk3dVn4OHY/wPFPpw/pJvpeE5oIpLfu9YrW3VmV5WkGSkuyleh5pJMN88kWbjSbonpiXgde6DQP+foiVaCn5Y7I96byMi2Gb3UytKkU+NzbJ2EXGV0dx93GSJXA9WmvMqIpErF2FEMWE7gBmb752XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixKpqCsr8eoEoVUnDXjif35kr36TqTel50QUZg7J1lI=;
 b=qId20KLPpdtfJGO1BFu0ZDZ0lpPK2BVLX1AJ5BN9vW2L4YxOPlFiFjZ3igAqD9Uf/dM3pl9s/CpiCvDpiIcCz97SD1uwvQCMFGO3u9LD892MpD0IM8g2pegCVJrLmRhXSRRtNxMXz+vaKEkPEByErX4Y0XcI5ocqszErZ2mbr3c=
Received: from MWHPR19CA0020.namprd19.prod.outlook.com (2603:10b6:300:d4::30)
 by BN6PR1201MB2497.namprd12.prod.outlook.com (2603:10b6:404:b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 15:02:10 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::f4) by MWHPR19CA0020.outlook.office365.com
 (2603:10b6:300:d4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 1 Mar 2022 15:02:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 15:02:07 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 09:02:05 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amdgpu: set noretry=1 for gc 10.3.6
Date: Tue, 1 Mar 2022 23:01:21 +0800
Message-ID: <20220301150121.3785743-3-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301150121.3785743-1-yifan1.zhang@amd.com>
References: <20220301150121.3785743-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b0fcf79-830c-4762-6410-08d9fb9474a5
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2497:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB249771AEAE40AB82C07A02C2C1029@BN6PR1201MB2497.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9pHT+VIZ8b16khkDiT1lHgOY1Ml9L2X5TkDbJNCJ9RmVbE6m83ZHNiHkeyBIcIUgjNZncyLcyfWFeElN/7LOPMxuVogMdyvK1jO6PsotA8zPZwEkNrz04ZQYoYRl1EKt5G0CveJ63rjaYD+jPvkoheQiqRfpDRfrGpF8sz7DOaD7I26v+5IAB+WyyHZAG2TfWIt7hcnDSbVwM5122/t4lYMC3ic+evrwQFKO63+gqutsuK81UqWfGYYmEi6FLOHTohyY/V7v0Aju9SkBOeYrsM6RKhV27fK+zE03eb2C1vDML40oV1w40nklupZ3dpTHEqtLmh6o93n58paqeHsn5Cg1wkVnV7BXyGcRAHfg9gDiqlSeZGmQPzLMxdCqLbAMLB1m5RrhiYiSleb1kEAIOe1zipPpdBRwNKOdBHfNjwrbMeG0RI2tbkqPOBQOhUiCiIQQEY0PobJbxfkvWD7H+9tnq4LX1+Xyatf69gt9kbqPX5OIg/6WViDs2w2HUfqRLr1UXYnPHbwB09H4ztM9nny+EG7cGCbdWnf7XRixNx1EvnkfYFitIkEFXQyvNfyTsPPGLjPfgNoaLFUfEt62EVl0g+osJsRvnki/AHTI9l4/Nl3Yue+nzhF/nQ79xqNUjokPEZQx6krdqY2U7H3bTUH7bRbsy4Zkugpi2TKQMVSXBP/ndhRJooF+/SHHPo3ZvD1n1lhQoAmcCw+qXIorkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(2616005)(70206006)(336012)(426003)(16526019)(36756003)(8676002)(47076005)(4326008)(186003)(26005)(70586007)(316002)(1076003)(81166007)(82310400004)(356005)(508600001)(36860700001)(7696005)(8936002)(54906003)(40460700003)(6916009)(5660300002)(6666004)(2906002)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 15:02:07.8488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0fcf79-830c-4762-6410-08d9fb9474a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2497
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Ray.Huang@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

this patch to set noretry=1 for gc 10.3.6.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index fbc22b7b6315..7c2a9555b7cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -567,6 +567,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 5):
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(9, 3, 0):
+	case IP_VERSION(10, 3, 6):
 		/*
 		 * noretry = 0 will cause kfd page fault tests fail
 		 * for some ASICs, so set default to 1 for these ASICs.
-- 
2.25.1

