Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05472C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 08:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 911E4112E50;
	Tue, 30 Jan 2024 08:44:33 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798F7112E50
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 08:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0RkS1v5VWmIeHgVJFbNvofiFfmtVOQl8XlR8MC+EijGllwVDA5nW2rL9TCrEFVTWUMIc387lBiusxxo/VTXIlyFszGS3MlfLCgON25EeXNLLb24rynWqHfVxd3+vDEDOHEWIVP3kl7lQDwmaHgoHI3A8eQCGWFQS763iCYI0pzmcXhVZnwscOBnV42i/QeP1HgqLSugpF21d5gD1FIIz3N15geiEdI9xVfdvoK7w+fB3urPndykUb2CxVkndoHcA5atmQnhDO3bQXmpO0mV0fiy/4N4cZRONXGqGCjeoR3tRNVOWqC8sSDCVIZTeZb2huLsvjGqcWxr887V1P0sLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXZzjZqQqvkL1V4dgNys9FOb1XDgzP9o1iCaIx8xxG8=;
 b=egMJWa5/ZZw+8iiuDFIRm/o5y4QTDaPsXYlcbfPO5wgl1Kro2H5Cdbvt1tKvkqyz6dZ0QtrvZiue61IXkWWp0hi5r3k2BefDq8v91G8O2FboxBjpmb9efiXSZGBvJv/t/qTKIwmcB2D5RBJ9xnSQDsMWVbGJz3jMnQNY+OvkRtMtBRRtKgLdsV05vAul0UL2R4qIQ7+5HEb+AE5wa9gLfLx8R53yLbDhsF3pbt9a6RhF/nxYWTSJtHdCAUYG8767sNEY/7T8hdjkMlF1T8cmlH3/dGQmdc1/69xQyZfYQ0yrGPkcaEZ9PyDHPa/CFcu9dajNsmzKDLbYl/Sz4P8fxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXZzjZqQqvkL1V4dgNys9FOb1XDgzP9o1iCaIx8xxG8=;
 b=dtkQllyKhoclpOBF5ymt/emq4plesqISF6cQ7gOcwvkS7mju0PK4/Dc6H/trpp+AWwo/K65pJxLVEbBufDbD2RZ9qS2sb2TjDFXFFiFPqGzOksWKa9N3l7kCr0tl7lOHUfY3qqVCBXQveTkVAOfGGTS8s7jPCP0Fj7Kzm85+y0M=
Received: from CY5PR22CA0042.namprd22.prod.outlook.com (2603:10b6:930:1d::35)
 by CH3PR12MB9169.namprd12.prod.outlook.com (2603:10b6:610:1a0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 08:44:30 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:1d:cafe::81) by CY5PR22CA0042.outlook.office365.com
 (2603:10b6:930:1d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 08:44:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 08:44:30 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 30 Jan 2024 02:44:27 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Add NULL check for kzalloc in
 'amdgpu_dm_atomic_commit_tail()'
Date: Tue, 30 Jan 2024 14:11:56 +0530
Message-ID: <20240130084156.404153-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CH3PR12MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e68e0e0-50d2-4209-92cd-08dc216facc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMpMyQD6CDvjbfH7eB/7deoFIo6i8aO62KrB4/PkE0H0UhYs+tVvyygxtUtVgvZKY9ifLjOryF/rQc8WiDdK5EOTm7WERyIKWHUbCAInKT+Xxk1e6CU1Kcci5u1btu27SfcH9ntel5AXSKxaMdX6RJtc3y0ItvmhNngzJ/oB4t5JhqHgNWsIRRTBgidZznqm68bWpISM1QJWbmZp9CK6X3yoCAHCakiUTVZRV672V+Ihu+gwNqLKctHQFijzaciJJPVL9opVorDRkYnr7yStT56STHaXt/Sm+6j1Bt9qFVv+WC0vkmVf76q6WAuy3R8Tr9b1Ji6//OWOX9NkJM5ueC+6Lk845tAAHZ/XCpGSELTC0AcLjzg2QdmaUjRlrhaKdBUO/N5KLEabiuiGI5YUEvfqCyUkzGOK88ptEt+F0J1tADCKU7NVlthSruueq/5Vtwowvh9YtaLGcZ/XN33WlABd3rBOaosIXeTqYA6pyFtgGldYjjJtDsXjF9dco7bMwQkkodb0xH/ZJLNSu9ddqAw1x7nO117D/dvwBfe2mZ6rZrMmw3T0GwMyxd5+YdUsMv9sjZQAY68JxacMQm5eZ0IwdTrKP+huYabUutVx+VWUr/L87sGh8Bx9b4gGcTzrpHDarYxbVaY1pIPECYd/LEjun5Y0LnKVIBQiLaYujLF5MFnhfJXjk9teoLfPSUDY5tF8UDEhvFFi+jm0kt01RsQFmBvxV/FyONaAM+ZMaI5kOv3k+Pfi5PlvW8AXT+6PIRpkN9A/0O7OM1F+qrWkcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799012)(46966006)(36840700001)(40470700004)(41300700001)(82740400003)(81166007)(356005)(40460700003)(40480700001)(8936002)(36860700001)(110136005)(86362001)(70586007)(316002)(6636002)(54906003)(70206006)(8676002)(2906002)(47076005)(44832011)(426003)(336012)(2616005)(5660300002)(7696005)(478600001)(4326008)(1076003)(6666004)(26005)(16526019)(83380400001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 08:44:30.2677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e68e0e0-50d2-4209-92cd-08dc216facc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169
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
 Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, Julia Lawall <julia.lawall@inria.fr>,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a NULL check for the kzalloc call that allocates memory for
dummy_updates in the amdgpu_dm_atomic_commit_tail function. Previously,
if kzalloc failed to allocate memory and returned NULL, the code would
attempt to use the NULL pointer.

The fix is to check if kzalloc returns NULL, and if so, log an error
message and skip the rest of the current loop iteration with the
continue statement.  This prevents the code from attempting to use the
NULL pointer.

Cc: Julia Lawall <julia.lawall@inria.fr>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0bf1bc7ced7d..8590c9f1dda6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9236,6 +9236,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		 * To fix this, DC should permit updating only stream properties.
 		 */
 		dummy_updates = kzalloc(sizeof(struct dc_surface_update) * MAX_SURFACES, GFP_ATOMIC);
+		if (!dummy_updates) {
+			DRM_ERROR("Failed to allocate memory for dummy_updates.\n");
+			continue;
+		}
 		for (j = 0; j < status->plane_count; j++)
 			dummy_updates[j].surface = status->plane_states[0];
 
-- 
2.34.1

