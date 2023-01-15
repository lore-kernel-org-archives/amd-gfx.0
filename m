Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3023EC3DA78
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Jan 2023 19:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91A6610E120;
	Sun, 15 Jan 2023 19:22:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6872810E08D
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Jan 2023 19:22:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsF4Zy+pGekC/LlytxSYXP/A4ihND65WW0q68jpzhXk3yar568tGIIIj2HzK5QjB0+1rYi0shv+kBXwvAj4UwIE9QPXZLlhKxr0Ld8bwvWOgK49haLGlQzexUQPnBY7tR03pfMHIAT+MZI+t3C558WhuIq3wW4D5PxCFE9VRY3sLhov1dmaEtQiIQJHfd/WHazqmyTM/DS4DMFSdv9dDnU/DDf2CAnuGD/4wgWNMjGABqkTT4YaZcbrbnN0s6LOkq4yCkIQJ6x/vA71H94T04Vb8Cjc0teZtIrnqE38XJiaPkjrQpl9HCdPHcieF4sI8skcCBwGYTXQFXajfu4QcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4DsibvojgYJskJnfW5AofSdLPUuoAsl2sgGYh/8V0Y=;
 b=JzwCdFBYGLazrHATvAzFz9GVKFv8aCV6xXCsGleMet646Eaw1Da0L7OE6Qns4ZzgMywt2mIHBUeJypvoRi2z+iQRFO0oDviyShG1SfE0GjPmLcjNkf6qNYeVgyfqB1KDxi3eEm+2T8rK42yJmdD3ImkuOwLLvTW+LprDfOhojJPJ97DGLMN3qEro799uKnGyC/I1rVitD8lVSRQPYjdTbb5zce7KzuhsDEit4nR8MNSvgLM91qBZYiGWwEC2+BMtzguCDdE6ai9IvmYr6FPyrDr16BrI4460pe1/KrLcRV5smFoOs8mLLNL475+oa1Er1LfXtUUGCkSMmR8RymDNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4DsibvojgYJskJnfW5AofSdLPUuoAsl2sgGYh/8V0Y=;
 b=DURh6rsayVOE3TUYB+wMgkPQ1W7bcUos6sP0W+DOBDcgK6N/UPSIISLMrIfLGXdPXJ66JPZ0jBYbL+yXIM1XWadhChYBBiM0UVLyjPhfsa27oqliBvNcB7VZ/k0nxkWhZbv2o3zbJuQYfDRD9iIe7DgrrCRVbDiKHtG0oU/HRVs=
Received: from DS7PR03CA0333.namprd03.prod.outlook.com (2603:10b6:8:55::15) by
 PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Sun, 15 Jan
 2023 19:22:07 +0000
Received: from DS1PEPF0000E650.namprd02.prod.outlook.com
 (2603:10b6:8:55:cafe::30) by DS7PR03CA0333.outlook.office365.com
 (2603:10b6:8:55::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Sun, 15 Jan 2023 19:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E650.mail.protection.outlook.com (10.167.18.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Sun, 15 Jan 2023 19:22:07 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 15 Jan
 2023 13:22:06 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd: Remove needless break for legacy IP discovery
 MP0 9.0.0
Date: Sun, 15 Jan 2023 13:21:43 -0600
Message-ID: <20230115192144.4566-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230115192144.4566-1-mario.limonciello@amd.com>
References: <20230115192144.4566-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E650:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: e8cd8938-77b4-4629-9918-08daf72dcacd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFNMIlsYIuidv9MZYYb+rYgor0q8i3KtjnSdOG4bmIPeWF11eNtGe0eacSzVQyxuCa+9RW9jmAP39NFGRYmiATwyeE1MltdXyNxf38P9qv02aglE0ESpCgyAbA4Fr23Sp4TYq7YN2f6dS+C1Wyy36qKrxQKNrNkhxb2c4jyCruB9Wwr5UEJlW9dlIkYRKIT84ilJv0BjoQUyuSZMzJnVoF6dyyhsspxqX8s2lQfqM9BDpb/CWpvnOWgoVAe4JbYoWgRueAJ5Z7DXf4RwbGQLZTX8OnnmdAy1akWRNEpxQ4bwUNvES/35hawOf6+cJRDO9kYH0LTQghx8+lV+MW5sftrz9kyjHIvjs0EY9I71Fq3ohBRyhgv7GVN6IPUhLqZ1SkUvwK/xqW8Qb1qrjIUCGDuUHGkNIqm6tUFfBjWSahJ0EhVvW7Hiy4Ai9mEM9k9qghhJO1OBLPs9mmNA1WY0ZVblrY1NWIMf8k3TiW51ZHsftEBEG7O334hDqxtfngoQkAAIeeE18/1FE3wAa+GvpkWd/RqDAWbIBtvnDTGbYU4s77cOXb4L5krMKr0a2xH3moxzfTodAmAK4Z0+eYJnhXesrVAUDVpHZVVVPykTszD5gVn4MTTfMeA9n4U0A5k0Cd6OuCIMJ4bypjVrSVxU6VKo5CQF2Ru5OkySOq8xrPIeLUI4cY8OjjKt5A4WFVs3DiakdnLC1dnJgZjl5DXcJ1jv+Zwb1nPNOJ+qWTeMlC0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(5660300002)(8936002)(4744005)(41300700001)(44832011)(2906002)(36756003)(316002)(70206006)(36860700001)(1076003)(7696005)(6666004)(8676002)(478600001)(4326008)(70586007)(6916009)(83380400001)(336012)(40460700003)(426003)(2616005)(40480700001)(81166007)(82310400005)(47076005)(26005)(82740400003)(186003)(16526019)(356005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 19:22:07.3625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cd8938-77b4-4629-9918-08daf72dcacd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E650.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is already a "default" case in the switch block, so there is
no need to have a break after the switch block.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 0d950ae14b27c..26cc529d4fde9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1072,7 +1072,6 @@ static const char *amdgpu_ucode_legacy_naming(struct amdgpu_device *adev, int bl
 			default:
 				return NULL;
 			}
-			break;
 		case IP_VERSION(10, 0, 0):
 			if (adev->apu_flags & AMD_APU_IS_PICASSO)
 				return "picasso";
-- 
2.25.1

