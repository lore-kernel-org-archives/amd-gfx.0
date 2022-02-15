Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2643C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 21:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1053410E55F;
	Tue, 15 Feb 2022 21:45:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D792510E55F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 21:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZ/I/O40e5YYo8L0ZKxmT+1LP+hIk2pX6qz1dI3b6D7ujHwo85il2M1A5BIGrRHSskN/S1wNh0ObjbnnC6M6ETNhQ8+iW4ubA8rHL+B+hstOhGGoeCHZEHyjMH01mzP8gbhGzfKh/5SWL9AW5nmhhFsKuG9JhXT6KKobkjbJkNPQI5kDnYXM/D66jXUqdS6uv2iF+o1yaupS0rQ09EFnRmq+um5XineBUoSfGXRzWyTnFDQ7kfK3ejxqQA026Hx2umnxhAYU+HvHULhEZJfld7URGIZQYpleZZYXhcsnxP3d3mZZD1CwlCjdSVtWMcR+FHmQFdtxsJSw+fxv7pvGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjGKVtrz8XqyY3vZM54Nib1qaxBuwhev5W3DE3DmJN8=;
 b=P0fjjvhoxFh+GbC0jfbLdsC/Whs3NMQoH9EjAU5E9f53gtLxOfaLWtMnleX2jlC24ZMm8JfxjPqeBx4wp26Dz3HUL4JuM4jndEuHBuzQjBOy1qpvCOGXWnb42als5H5L6d/RYUUi84CBYdeO9u5Zx7aVVOceoz2FLBNhp+e3NdkJ4Yqr8lhcRjXD4XegKT6GN8/AoKBvTQJSHYYAHD6QDmG80gI8mtyGkzv9OEMX5vyG0gF8r+ub722+25e+alvoZPVJ83EzHvHULwXo9wks4oZbFYpsSxf7BeoIM6M51rIE8n8ko05dV7Bk4z2ILh3Daqenh/ZAy4TCgMYUMxBu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjGKVtrz8XqyY3vZM54Nib1qaxBuwhev5W3DE3DmJN8=;
 b=i1hxSIgKr1pkwitdP7SPrvGRtODnpveCzDC3WUfc/Nyuuo+RE4nAZT65bPEg0NytjRHzvmOcfCf/anaHuTqwVH+edl7p0uWt5vjNMA4n5AD7UzDeguwvWLgE9xgYj/l56VLhbCTUsZFA3rZl08dYe66bBlwtVfSV2OGh0FhCQJM=
Received: from BN9PR03CA0263.namprd03.prod.outlook.com (2603:10b6:408:ff::28)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 21:45:11 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::9f) by BN9PR03CA0263.outlook.office365.com
 (2603:10b6:408:ff::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 15 Feb 2022 21:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:45:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 15:45:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amdgpu/discovery: Add sw DM function for 3.1.6 DCE
Date: Tue, 15 Feb 2022 16:44:47 -0500
Message-ID: <20220215214447.2234978-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215214447.2234978-1-alexander.deucher@amd.com>
References: <20220215214447.2234978-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bf60dd4-031e-49a1-b914-08d9f0cc711d
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5744820B7036807335FED1E5F7349@DS7PR12MB5744.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChIosMbaIwtZB9YP8YeqNu5zjEgtZFkWupsEye5hBuQnRF3YK1oYOYqMpmG3BIF0rU7KflMLxuziunRlS9DTapolD698AoGmvJDMH7DEHAUZOer3OVMylId2Y1LoS9pMAUtcfwK6oAR8HQv6OXHI6OTC3Q7v1VV7PZ6l6yu1mlUndLbkFKMZ0o3YCvstwFSYCDyeS8HZCIuxjZJh1IWgw03FzIbgd9Us13OKFkpputPY6Qritkkrt7F1oZyw3iOjVepzSecC97Op33fcq5f649LMqzb1h3iAjJo/dd1GO8cM+87FNYKULSbFORj2JlVZfmV6hUeXNX6s+2FrRxamyNHsJA8DhuiGXGNv3r1/d6h1AyFBFZZBdziP9/fx6iDWDKa0/yLzY/ZoYJPMXN1ZJtFLVk5BlTfYOH61v/wGlOBsMD3hd7R+9dgG9GwafTtOYmB2eXHrqU81BhdIXH3kUsTnG7eHQUxy22QOXUuzSLgjMfapifj8mOjLEdREfQPhY96h1JOwQGD8l6KJp5m0WTCpmlXz89txwZ18y/CLuSoDTvk4sJbTSZJviy1gq93ynOrBwuFJekTOZVh6IcpQQQMJSRqFjzDW+04VXDlpZv3Tz476ozg2/PPdD/QUJvRCkjpFVmsV0pUDdI0byRTm42OAkRq0Zf2uWwivXBz6Fl/qTwbPeYlkSugy3McsB6eQ8eE297oW38gADZgxv+07uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(47076005)(1076003)(186003)(26005)(16526019)(7696005)(316002)(336012)(54906003)(6916009)(6666004)(2616005)(426003)(82310400004)(83380400001)(70206006)(5660300002)(8936002)(40460700003)(86362001)(81166007)(4326008)(356005)(508600001)(36756003)(2906002)(4744005)(70586007)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:45:11.1091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf60dd4-031e-49a1-b914-08d9f0cc711d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Add 3.1.6 DCE IP and assign relevant sw DM function for the new DCE.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index babc0ab3208e..8fa3cf8dad48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1366,6 +1366,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
+		case IP_VERSION(3, 1, 6):
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
 		default:
-- 
2.34.1

