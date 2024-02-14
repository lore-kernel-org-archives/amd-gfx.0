Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E195C48BC3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 21:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66E610E172;
	Wed, 14 Feb 2024 21:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0TKC8Ysr";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE98410E172
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 21:34:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJmQyBOqMvCPDi2TSnfMpxmMVY+3FHiFsC13D3AHvPWmH0yknMQ+ryr09qOqK9ousj0bKvnmkfmA84aG2VWv17qUepRbYmgUNRLj4H/Cgm+8v4hWAMc1lz0RcxQJ3q6psHe+Bt7OSqvw1YDNEN9IFb0DpfnkRQ74qFMoKpgx1P9ru8vLool79mlFo1mxpH4gZNLo1IcgWvlQUBJg8AtykEGUniX4bgjrr808ZC1QDbd6kulEwbkKdPdcRdVbsaJyhGcyQBtqCi3fav0roo6ABz5pnYN1u/4ZMErhTJMYfL8bCIMC8Ulv9vwEgTMOUSO4qQTGCZ8txq0JhlVsdlSjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WZnKdPayT1XbsauqarQ+z+gCkPwROgctUSWNKkkv90=;
 b=gawVhqRb7uBphA35zUQOHXJU+sIBP5GgUm0V4MTJFA7prLAqiUCw/z7CUz6xaG75rMsTbhskwa+k023iwiu9SZWKytVpZOkI8Z73sAJnINGFO9xmyrYdG5L9CVn/LrQV3P0WcFZCMxK8+eKOv2XpGJqkkmXrVMn61oombG7+NeNeezp+Dq+PJLp8ruzPhfWmSLMmFSN1VH0EMhy+UfkVDDi/YnXnqN1JOHTY5KvqbjLIY8a+YP66kvo6oiwe37GGC4nAFhDfQ1SQirqOnC3189Wj0KEwq6K2AjmIMyw4iC3RGv6g71cWhAYlaIln9cJ30TIwfumZnzDg4fSw+QV2Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WZnKdPayT1XbsauqarQ+z+gCkPwROgctUSWNKkkv90=;
 b=0TKC8YsrtvZ/b144bAFYRVOzGqO4IFz9Gehz9vpu/+B45abp8XVO7O5Kgvfb7leke9cNkR6vktiY2v+bqGAlcgmh9DYlLyRtS4HEwd2ckbJKBZITAJTbDuyAyTGsLQ9BzL2TQH0qnQy0qkMcUQR5q7LLepgZgxFNVCfnfq1prRc=
Received: from DS7PR03CA0331.namprd03.prod.outlook.com (2603:10b6:8:55::26) by
 DM8PR12MB5493.namprd12.prod.outlook.com (2603:10b6:8:3d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.26; Wed, 14 Feb 2024 21:34:31 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::b5) by DS7PR03CA0331.outlook.office365.com
 (2603:10b6:8:55::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 21:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 21:34:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 15:34:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add psp 14.0.1 discovery support
Date: Wed, 14 Feb 2024 16:34:13 -0500
Message-ID: <20240214213413.2592186-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240214213413.2592186-1-alexander.deucher@amd.com>
References: <20240214213413.2592186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DM8PR12MB5493:EE_
X-MS-Office365-Filtering-Correlation-Id: eeec1463-c55a-42be-2306-08dc2da4bb1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Idpp1QOp4R7z+nSOtRoC9klvOPhzJFn0MX/WZ8ZyAI5/SUTs5tgSZsISQvn6eEhR43LkOVkRVqMgolyJmRb1AQKR1CLk+gDWtesXIpkWNuGQjX5aETZOpciphgXHxme1zkWcpO5wltIYyLQAH/zVCOm5YvN1f9a476Gb2EsVbUgaWMjXJkHHbMo4x5foK0SIDz5WY28zuGcD62/VylDBassE5gT0SMZ2lDeCSoUs5eV68bZrblxppVtEbizn9iSLVFpaoG/ayhsZ63WIYj76xLE3gtQMI7tEgUsFCme0XPA4NgkG4AXvq4oMsybznImmmrOMa3GmmAiJ7HZDQcBtG4O4Jk5B5UXFRukLrb9h+Dw3SEoEPwNO4FelaIxJ64NjB+xtpzkTZdaL0TkJayohlW4cieBKfj7qnCsFEW2ogbgoEQSLjFngq/lfmgMIRFUmXpebLcYALi0eDbbR/8jPjIy5yIvniMWjVCvhY5KxTpU5eubws1dI4pybQKB4022D4AWwBF74Y61I/uJ9bTFtseZwyjWRKTAhRTSqls+EE2gCX7ttZfqUBcPa46J7jila1ZsvsloRCaM7/0+qwnqQMisRzyljz9Dlx8j8Zk649Mo/7BhPHCMf3l0uzkzogd8Nv/LofBeLosAyMIroREFMxwKwsaousUEGST5y6HlgOk4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(64100799003)(36860700004)(1800799012)(451199024)(82310400011)(186009)(40470700004)(46966006)(2906002)(5660300002)(4744005)(7696005)(478600001)(86362001)(41300700001)(426003)(36756003)(83380400001)(336012)(1076003)(26005)(2616005)(4326008)(16526019)(54906003)(8936002)(8676002)(6666004)(70586007)(70206006)(6916009)(316002)(82740400003)(356005)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 21:34:31.6031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeec1463-c55a-42be-2306-08dc2da4bb1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
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

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch to add psp 14.0.1 support.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 196446ca7275..ea4ca1e6d7b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1824,6 +1824,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 10):
 	case IP_VERSION(13, 0, 11):
 	case IP_VERSION(14, 0, 0):
+	case IP_VERSION(14, 0, 1):
 		amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
 		break;
 	case IP_VERSION(13, 0, 4):
-- 
2.42.0

