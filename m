Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899DEC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 13:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F10E81125A7;
	Mon, 15 Apr 2024 13:38:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="stalS16h";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 325431125B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 13:38:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvXnK7t8ytze1iGrDJmlC2JwHV9EJ3ZbEm+FmttKxq4O9elP0rU7bH6fbNQXvokItsy/b1O/ybolM0+rQ58+aw7rWJ0K/21lwnzGaUSckv92BFooAO2Qw/Ryjg+SMDHc+3766TvTzD8DTDogh0sOOUda/3LXtfCXJEQlYxVv/8pczg9hp/YPCMs5svIaNbTJ03lhu+FAgDKUHzqdz3Yh7A8/diu47qTjN3szs8ol+AYH3aAxLqhkpCRfnYWgx86bh0eSMMy1UXl+4b7idHVN2VRHeMEymW3jJs1TjdW2YPSIDzOD8x+seD6DhXJz0eKYmvA5gh9pBJIlbKBXrCXEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IWUfasPZFFzQxQik0i9hz+LIfXq2DYDVDPEfjqQ7F4=;
 b=Iad3SZCjJ8XOwVOXxM4gidkEX1vnAaVwtCnOjRVhSZwXP64hO7TMUa0Du152qStB5E+YunpjwU/0vdMMNXhkBQIvYrLyhkE+XrTln/dMjMPsM7D4SHES88P4st8pYXRmD0Vgd6gJ/XB2Mr+Od5nI35vT+mLUlH6BPsNwppb9ansjE+YcP18ljOFoKgSL4RFjDyPuOL5ojDGWjmEMjQWIKg0aOsHn9bzAxzPvAZqH9u2rhc3LHJboFiXoaSOg6xHz5oa5c0nhAKALQnxTkGF6X1V7SJZn6qOG/gU092L/85gFxGDukXpbJnW6iTHhAMpJ+fUv1b/H9q5OXfV5x+bxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IWUfasPZFFzQxQik0i9hz+LIfXq2DYDVDPEfjqQ7F4=;
 b=stalS16hMBt5htc1kt9fsxbaApYG6mXq4FudZL9xYujUxOB+fH/YTzW2DrXyVkY5wJJ0lUMmTFZHFrGEBCWc0T1XNqiAF7mTOPYFrxxjNf66soYgIdQo7/4eeDfCXk2eYZdw+vLGSMHKckOa4HddMt1NZy4cflhMghmKE5G9rDs=
Received: from BN8PR04CA0012.namprd04.prod.outlook.com (2603:10b6:408:70::25)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 13:38:33 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:70:cafe::5e) by BN8PR04CA0012.outlook.office365.com
 (2603:10b6:408:70::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 13:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 13:38:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 08:38:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Kees Cook <keescook@chromium.org>
Subject: [PATCH] drm/radeon: make -fstrict-flex-arrays=3 happy
Date: Mon, 15 Apr 2024 09:38:16 -0400
Message-ID: <20240415133816.1053794-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f391709-013f-4284-eec0-08dc5d515842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvsIDFXv+pPsVaWWXjG1mm3SMYB30587gOeQRJtJqB1pJdnoX6B2vilYn1AJstd0k5BvZSqEuCK469/su0KossclviA3bluEKbBGQLR33V7hgP7nqosImAMC6i7UuRxkh+mJnWffhii0Xdngll5l+IwcgiX7hAMYa4LiXLw1rBIKXaeVQ7QpX7wXo/0oPXlWUaymTDoFW5hgK5dX6Hq/dEI5wJvIXQqcgrzo8Mja+ZZPsJkkDL/Jiuzohba2OZvv3s4keKr7lcke9e6CynA8BcaU2jSsWi9Z9k/j6HuLsSKD8JLu0TSl4IkuDuzzBjd0mzTNZPmEcxmY3quxNpp3rWw9z6vJHZTwgijTu+JHkacTZd9AY2+Vm9gHjcj4jJJfoDPxA0V00JqRwqdWJRN9KVfFlIe5PhEjOJGnHiMlwAXOUqvEFBflazrnZBeIS3UPDyJA0QIClMZGpI78J55xBkrT43QOfF8RL4igeASmzkT5jzI7Pxwxg/dptybMqj0wSa5+R5FAJxexKMs6It1LnK9+tFiCJi4DraWYYWllEVV89lIGZAQC0HKNDlOLDLWaBvb+08yXd9U/Ks0O/9wUDi2ly7In2uAe2mqRyEVQnVKRpu8fEUoRg07+3f6GDdOhurVKYq5xOoYHrfgooLjivPCaKn1DyRYiJlZMGgRyx0o2hmQJ4+KP23T+FgQcp1JBMNvZX5knd7vJItTrRISwRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 13:38:33.3970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f391709-013f-4284-eec0-08dc5d515842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
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

The driver parses a union where the layout up through the first
array is the same, however, the array has different sizes
depending on the elements in the union.  Be explicit to
fix the UBSAN checker.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3323
Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/radeon/radeon_atombios.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index bb1f0a3371ab5..10793a433bf58 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -923,8 +923,12 @@ bool radeon_get_atom_connector_info_from_supported_devices_table(struct
 		max_device = ATOM_MAX_SUPPORTED_DEVICE_INFO;
 
 	for (i = 0; i < max_device; i++) {
-		ATOM_CONNECTOR_INFO_I2C ci =
-		    supported_devices->info.asConnInfo[i];
+		ATOM_CONNECTOR_INFO_I2C ci;
+
+		if (frev > 1)
+			ci = supported_devices->info_2d1.asConnInfo[i];
+		else
+			ci = supported_devices->info.asConnInfo[i];
 
 		bios_connectors[i].valid = false;
 
-- 
2.44.0

