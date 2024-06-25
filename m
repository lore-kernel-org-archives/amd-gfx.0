Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9ADC2BBCA
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jun 2024 14:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60DA310E66B;
	Tue, 25 Jun 2024 14:25:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1i+xIwRL";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C145410E66B
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jun 2024 14:25:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbIxPy6jMA92Nrt/LfHVnbXEpjGqbZIyMlcqOZDtjkySRD3E4yJtZQAW2tVtp2siNv3H2Yk4HhSL4Yfc5AeZ2kwpVb1ejwlkBGIwrb6Kct4/vUbzinCjhxCP6CEAOlCcSBAjx/0K7ykEWrajAWc/2vVwxgYoMf+dcrZMnMK+hQBTMyTmBajSCu1q+25+DFgOmv0U6qAmkdwq+uLjyfEYdWdqSWIfcQ0X0a7jOqeEX1XZjMrXgAKuyNh7p9D9lQYjz+VpYoMAYtQWot4SevMnVMew10K7N6JneeBj18YGIPTh6T6/DgTrXwn+C8KqyXYX92o21iHnxSNiAc5eousL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2Avj7O3U2h1Jfqt/sVRvtjd56VVDY0qObz6VnpACoA=;
 b=kZv2Yr9jLhkUz2MHtl/XFu+KUiofD0Ycwi1zDS3xOGuAl9dida+Yb6FB5/5bH1+Ob50T9f31xWQQvGLEVsHgvwuYHPnSNRsn9L3mJcbxQOjO/bkNhQWKT34KiQxrmLqMi0NHhv7VCfANA8DUDqpR6JvtqZvX0QAyD4XuFS4aAuM49q5bfJPF7riDCEodhturoBvhgrtsbblqM0aEO/j9eD8ceYtocgKZi6oVlKUEhN+MaaZN1ECoWMNlW7jGw5qc/cBHyb4QN+CCY4Rug6Fx5Te6id/fZc1TjN3ayBaDzSM9IUiAG3q/DNVsCs+Y7gx7kK+Of4lN0RpRbGP1ew37rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2Avj7O3U2h1Jfqt/sVRvtjd56VVDY0qObz6VnpACoA=;
 b=1i+xIwRLH7OeRLxxf9+gXNblVwOa5D6KY8UdHbKJ1DM/ov7gIXEtXl3Dc6OsCHmekANvsGZl7TphbEwvCY8kpk8t25hGVPt8pZtT5OJ3ddYbMQEm90uVZOdgIspE4MyIL8qm/FpiWoT7/GaTwrr2jpx8yS1XpKhoy761PQpWtUo=
Received: from SN7PR18CA0015.namprd18.prod.outlook.com (2603:10b6:806:f3::6)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 25 Jun
 2024 14:24:54 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::76) by SN7PR18CA0015.outlook.office365.com
 (2603:10b6:806:f3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 14:24:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 14:24:54 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 09:24:49 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v2] drm/radeon: check bo_va->bo is non-NULL before using it
Date: Tue, 25 Jun 2024 16:22:33 +0200
Message-ID: <20240625142418.156810-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e44fd4-bb47-4d61-fd87-08dc95229539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?63zaxQuIhmCvZdd9lah/UbIReWQdAI2HRgLEQFaGhGx7F54AY6YYphtKxuQK?=
 =?us-ascii?Q?+x0JQkpHdpm0L5zDiloWdjkFb/l28p5JbCnClV38mlu0ZBceQrbjtzNVuCgx?=
 =?us-ascii?Q?ORn+RHW1BlIytGBHiDN2bq/YjmKyxdvBRqd8AkGFjER72HPJEvrCUM8mU1nG?=
 =?us-ascii?Q?InwikFgIT94YZP/4KXqiC/NQ9vclfo64sPO7V/cSdLS6hDK0xwibLygIMVhs?=
 =?us-ascii?Q?4OBjL0NKG3JEpUzdIDrClbcDS9aCtXFAkHfT9JtS4p1DIYTYIu9gcvo3TaMe?=
 =?us-ascii?Q?9XlR15QsmlGQR9JfNRntqEPw+VEqjq+9v9MAv6ecIdr3fhGnKd3///RXoT2d?=
 =?us-ascii?Q?JUVXQNb+g76PmBtZ57TJEctenfQJtvSBgvPygMnCvbNp9aUYJGo0/x3D/Yb1?=
 =?us-ascii?Q?7jjpx2EX6Rh3JG0kTi/A4Z/TPv96Eo0Dc03ZWrnV+PXm9lbLIsjY8dFOMSM7?=
 =?us-ascii?Q?WsLnfmDerlwEAy8IH+8PdoVnNU22xhklJW0l941hVh0ntsX+76gcL9sIT1Ip?=
 =?us-ascii?Q?h796dhhKLCrBsU+wq7Pt56fRb5qnlMH3DQrhjr230yJL+ZWWtVBWU7VtBInO?=
 =?us-ascii?Q?pHQZ4m1ohrLHnf55DoegO3uoSYU9c898eyr/ta0Edj1fX+f12cjs4sUkX1N4?=
 =?us-ascii?Q?D2dICuzFouznoT6nAV6zOVovmz5X3rxV0+jqdNXwsxlwj6FALvmqz+NjqAFs?=
 =?us-ascii?Q?egAuq9XHB3N6gPhexU1SVd1g6GjCsAzPharVhDozJeKeG8CAFlYgAGfeB4eS?=
 =?us-ascii?Q?TuSxo0lpBFrbN2NkXZWjdNdRf+0L5YrdAYoCMzKL1exetVjwB1u65FAVpqUn?=
 =?us-ascii?Q?6vdbDb1FETdGvI+IfxgWGp7iXWHGn8USzq6nkRueRVQNGVTXkNYGQ1/JuRTM?=
 =?us-ascii?Q?lxIyNxUvBD9cVM3ab+8hWGr0HcqUnb4fkBwo7PK09unBROCMYS5R47d3XpyV?=
 =?us-ascii?Q?Us0qT533INZW8P+gJ+hz0EQ0CYFKCi6lhf33S0lmaWhkpxiZXvqdSXfbbH7F?=
 =?us-ascii?Q?LWXv6tCT4cp3MrSPq1VvLlEM6SebwlrcI8oFyS9AQe8AiJegYOFCyXAZQXaS?=
 =?us-ascii?Q?mjiCQMO3ZkealuCxeU/gauCA1X8C7VZ8xOcBcfSyDsmKgaZ/FKCVq8hx3k1n?=
 =?us-ascii?Q?iH25UNqkVfEyGnknN3Tbh51Fznp6TOxfjszI9wnwlndYioKQkJoFlg4CM1Nq?=
 =?us-ascii?Q?I+AyRPHZcTpsQwFxZHN5u/xudbVP5avlD58Nynsm/j1R9lWl1hx/id0f/w9g?=
 =?us-ascii?Q?A0OE7XG7eO2BQNbmcpgd7/biIr+sQbFLd183OYwoAW5oJdIMF26DPu/cxlPc?=
 =?us-ascii?Q?qMue7PPXA7cyE++AAEsRcD18vYLVwkUrqpdNfWc+iVf1SNfH0lHiUHjNE3r3?=
 =?us-ascii?Q?qGc6fR7TNZPIXhP1TCyN7zb/rqYu+qhCi+cVpoMC383YDZ1ngw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 14:24:54.3862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e44fd4-bb47-4d61-fd87-08dc95229539
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
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

The call to radeon_vm_clear_freed might clear bo_va->bo, so
we have to check it before dereferencing it.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/radeon/radeon_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 3fec3acdaf28..27225d1fe8d2 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -641,7 +641,7 @@ static void radeon_gem_va_update_vm(struct radeon_device *rdev,
 	if (r)
 		goto error_unlock;
 
-	if (bo_va->it.start)
+	if (bo_va->it.start && bo_va->bo)
 		r = radeon_vm_bo_update(rdev, bo_va, bo_va->bo->tbo.resource);
 
 error_unlock:
-- 
2.45.2

