Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D671C4829E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 20:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9EE510E15C;
	Thu, 15 Feb 2024 20:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r7xHqI67";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7225A10E409
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 20:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgSn3FEUDY47SQYUvjr9jBBjQx+az0i1tNGfhlyPXS9ff/Im20sJzoeBpe8ybeq6uvZ8e4VwPXHq7GF19XBzy16vnrBykAoxRKkzCLwK+XnIMJeAGRrY4tqqUnXE5n97tEJ2gI+5EFD7jkw/xGb+NRJ/yhbZhGFHeDs1t+cysipjZey9lCbCTJ3no2b5Z23YK/skioDWHa2TUdBR8cG/MfzNws6YYShw91twtucNO6oauB3ZB1bsJ/cK1pgLz26qDETU5FWCiUMTYfGAl5asZ3RjU/rAkxsfadyaJDsMAPDgI/iNDiFr82KR38i8wqKuo8lB/q43fpwXx39gtpsvtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBniWUl2gUhE0qsuQgLofWLnE7hEGpDu0rb1jahl8n0=;
 b=BjPE3H5hOEsIyWcYEFwJ+6tNgVnXEoclHb65/L7L8VfbMJKQl3NRMPrz4tzgwEm8uQr7V7vuMWfMUS66rVF7I5wNyNwzZ9hTsXA0LYkxjSWGMuSn9pi32KArl5TpdpP70Z5l9982kJ5PnU32xYINoMq+pN9QFeeeYjyPmYCRKe5YuQwakuXsKGohwW0dLZoPSpDmqX+X3lurYpZts99B2NImmhEM+u5DYaBce+KbaBaaJu24ifRJC4NAAErcsrdPwGrwyoNmd6gWt05MSV5WES9Uz01mAPViRlXI1sW18hut47KZOnA7JJctdC3QyMYpyaUJwLBBpnpulCfOP6lVHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBniWUl2gUhE0qsuQgLofWLnE7hEGpDu0rb1jahl8n0=;
 b=r7xHqI67Y7VqXMi9/gTX4yd8+KLBx6hcu+0488IVA449QzzMGcEU9HZ9AQhn86dTJIpax3nBWLtsf0TMtUx12/GqkBrxhQaRtr92zBcA2phT1TM5aHh2crTqTt04hKPR7xqyco9LcgKfjwZcSqpvAXpz9M+B5id13vUf3/cVaiY=
Received: from CY5PR19CA0002.namprd19.prod.outlook.com (2603:10b6:930:15::8)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 20:27:34 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:15:cafe::5) by CY5PR19CA0002.outlook.office365.com
 (2603:10b6:930:15::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29 via Frontend
 Transport; Thu, 15 Feb 2024 20:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 20:27:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 14:27:32 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: enable soc21 discovery support for GC 11.5.1
Date: Thu, 15 Feb 2024 15:27:15 -0500
Message-ID: <20240215202715.415164-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240215202715.415164-1-alexander.deucher@amd.com>
References: <20240215202715.415164-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: b95ec4d1-53e0-40c3-9082-08dc2e648b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEhU/6fHyTcuWyDqSeNg7kn0cGBdnT/YnhSPTHDWSVINGIdC0dlWM4ODL8pYfF6KCvOyf4YqwbgNY9NZiLmbHcPk7uEhYQ9tveNAfbbdk/RID+gCrvfJjgHm8ZFUfuMxiCtk8RPvv8L9DpQlwfbUHAizZFZnjXv1cPV+Jvd7gutXS6cMzheUiVQteoOXvzktJcs3vtfnedOP/K0juZCzsGesrd3rNhohKRiXz+gySi7/vnIRFnFi7+gfvYQDFP0agZm5F8pX/nTt/UwxuVLGHPprjVQkSxI5681QvK+FOtnUAv75dRmzQz83EM72SJ5VpAVbZfdLIwdJlUM/OoNzmO9FNX5L98LxwWQ52ucTqr8Z4WluMUNurJhhKoLOaTsn2wHv91lUH/Qc/3KfLvNrw7IZAruxdaF1gpcPp4L25ObNNSRy8PqK71ntoB1fUi6LU3xR1P4tkFcgwvAAaezjwC1WENjHLqodrfDXgk4TSwnS034JZM+E271IKtVre2F/XZXRclBKiMU5XBlGBZouODJYT+NkZ+5vdN3SxSDejxe3xIoqFp6PUP+61uJ5mwxnND5Z8pqY3KXHXk3muIiKC7LK7SClRlwZMnxQNgD/is+GOYmw1GB4/NntZZ5jhlE6L8KtGepoT40PsidZas9vM3NrCssMt7mDv80XAmTr3KA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(36860700004)(40470700004)(46966006)(2906002)(41300700001)(8676002)(4326008)(8936002)(4744005)(5660300002)(356005)(86362001)(83380400001)(82740400003)(81166007)(6916009)(36756003)(426003)(70586007)(7696005)(2616005)(1076003)(316002)(336012)(6666004)(16526019)(70206006)(478600001)(54906003)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:27:34.1257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b95ec4d1-53e0-40c3-9082-08dc2e648b00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
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

This patch to enable soc21 support for GC 11.5.1

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ace5e924f279..6a63145beaf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1683,6 +1683,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
 		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
 		break;
 	default:
-- 
2.42.0

