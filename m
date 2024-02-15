Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D47C4829E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 20:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D165210E05E;
	Thu, 15 Feb 2024 20:26:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bnJMjTBv";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D19B10E05E
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 20:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5vn66G/I86a5AxAQPfevWimbH93W1oFrTtJ0L/kTPJvN2RdnajyhGxya1tn1gsAN8y7CCaQIXC5rvotB15AcDLvwZ08Db3VZN1iGU9gB2WGHMsdDKqR6MIgwJMe9hCsKt9QYGey9fWBd3AQP/kB/jfKlda7h1t4WRmjcYA332c4GQZqk4P4zDIAvpH+CYS7jNBbWYX6ABgHEYI03Py6nDgmFSPPrg7wAFpg6/eg7LuwPfSsFn3mfMI3o8zZ0yCTo+LECY7VuojZ4tONVO3tD+OGEZuBJgMqACSfF8HE7shc6nCHRt4sCvyBV+jEUB7t1uVKJ2jRh6SGWgIaW1/vHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+663f89AbePubcAOluqndryavTD5laEFu4gXzA6ajEg=;
 b=SKOGQ6AuCEhbpxga+MBkRg8A66JcLOm7QlKJc+e9tYUWipdNk74/7OMrYKJ2wOuK9tMOl+dBYMmCk4jAvPtY5Xqvk2N5jVCLwciPjBXcXGPf3wuQFYVRp8T30MNGjnqJlmTYs6Tx5mm2QsJNu1LpMpkABW68g0AIT4+MQIIV5S5PslvvNXEGn06X9RTJnhhtTefty3URn6rTMiaztmyusCeoLc+tgY4v2vCWeDABNX5fqK5jEq53NJhYoVI1JSUYjgdHLQk/ddFRCL8wUalnwZzidJDDgrUht2gCZrdMQFpc4QFw1JghB+wlzQKcSKmeCf4ifN4N9lWeL1hZ5vB+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+663f89AbePubcAOluqndryavTD5laEFu4gXzA6ajEg=;
 b=bnJMjTBv6eXc02hcOR/mO3tA/8XnG0ZWhnf/WlWvl4E710OUvaAQ6hSG89SZqX+pK9fSjiZPFWwnqXoYAhWkcGmaDJyRRzj4xm3N6XE2KGGS5KFQpmJvLUO7nCZGH8cpe77gSy57iakDhMjEH3qHAuHfTESM5ePbBV2CV0nvUF0=
Received: from CY8PR11CA0024.namprd11.prod.outlook.com (2603:10b6:930:48::24)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Thu, 15 Feb
 2024 20:26:08 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::7b) by CY8PR11CA0024.outlook.office365.com
 (2603:10b6:930:48::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 20:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 20:26:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 14:26:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: enable gmc11 discovery support for GC 11.5.1
Date: Thu, 15 Feb 2024 15:25:48 -0500
Message-ID: <20240215202548.415025-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240215202548.415025-1-alexander.deucher@amd.com>
References: <20240215202548.415025-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CY5PR12MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 916e34ba-4c0d-4db2-040f-08dc2e6457fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbkUfFvhsdlRosjXcebLnPBNU79ml27Kx2Wt1a8lLqRXK3za2Nw+DLZ8cg2sxfuY4EKzgSqspjZdrL+El7LUSj0qty/GkzyRGGv0TY663WUF8dhMOdQ9R0Iq1DR3YcEb8UGUXoC8jdZGSHx5lJaK0hZ9dZ2WaMqHqTEoqMu8sKphE37f5o4+U+y1wBxmp40viNC8twwpEQlYhpL9PxaniG7zpOqZzOTCZdCzaLtR1Iottzjv7qtpFtK+AAloEaLKhKn/30Iw54kqmKxd8WRGgtKt0vg1KKK/iCkhcNPKI9cVJllbNLQs8pZS+d57ZPgXbxcm1LmjGG223yfajq1GQ43d4T1d1lslDsO/auatRbgMETT0v7PaOYGqywHLQ78+Gs/bT3U68K4fRmSgkZ87gUp1AOQvQw77mSWtyVP6n0ILDFmx2v5O062Ot7l5URpvH1xz2qyHm35G6d90jHtCVYiB8DSzscJHlIFwA+3KUiVkLCLOnbqD4HJs6mrfdzqf13s0MN4BUDO+VNb245DHt6ehAkyr7lPr5Zy4R+IkERQD7my2Qgg15MJ3HzyVRH/dAuh3r2yZK++Cf4gggv2lG42clqwzCdK0EYazb6WvY0kr6IP6WX4w+/Q77eGkiIVANqzmr9hHLAB1eICgg2UbhwohL+tj+xreDTlnVeC8O/4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(186009)(36860700004)(64100799003)(82310400011)(1800799012)(451199024)(46966006)(40470700004)(36756003)(86362001)(4326008)(6916009)(8676002)(8936002)(70206006)(70586007)(5660300002)(2906002)(4744005)(83380400001)(81166007)(356005)(82740400003)(41300700001)(2616005)(6666004)(54906003)(316002)(26005)(336012)(16526019)(426003)(1076003)(478600001)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:26:08.6505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 916e34ba-4c0d-4db2-040f-08dc2e6457fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622
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

This patch to enable gmc11 for GC 11.5.1

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 3bd47d882205..ace5e924f279 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1730,6 +1730,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
 		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
 		break;
 	default:
-- 
2.42.0

