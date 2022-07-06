Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B53C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jul 2022 14:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF2FE11B3B0;
	Wed,  6 Jul 2022 14:09:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 461CC11B9DF
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jul 2022 14:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wet7peL7oHmcFh8AK3nCTuEa9tm0nEZZ1w7DVr1o3WdlcAoZxn+1lFq1he7uyGikfBkFaSHJZt/Qmc2HUSoX6tgmOayaAB7KQQshZgrl7rm1KObSOalGdVnbk/+QESGcV6PU5K6rUuYVLCO4x2c67DMqX/64WbbbihR4O90zC/lT/xJ/n5BtlrA7C4RgCToqQs8rYHBwSXC80H+8NbQugpyQ9oitRtpFDBnNkPNmMEsZJqbX4COefE9esbgwfgQV5mtWFt7Rl7zcz3bpNnpOZgwWYCLLTVOvPCUX/GNEyCvlBOoyGDJifkamyVRtl+xrOModn+K2WVGseW+BdSVIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MdgKnJP4jKfC+TIcuE16NA0OQBWGrbXFNwKRP67pgg=;
 b=m4ixsQZ3BI2PsqymmT2HMXjmCgzSTqHCo/CcWVUR8y+jFOPAlUIeS5qJ4jiivrxp+lRbtGqot0bjKIWrhG8AtCrdo9GebMCTddEjp4hWcVTEgUq88F56oP7OGx5/2x8HunkTxovTSYcVPncSXiqUwT+CVlYtcvcbZ4rG3dPPmeZr4vC0iWMWBU2P1QHinSFtFlpEqb/i/pofCNYY8RLLB5XsylrZ6yqvuTi5jU9Q/tydP+4iNvXEVVowvTvNSsHylnvRudU+ruU/Zv4Wr0hKbI4/5RvZN/1u2IFQcDoihT+L1Bpm1Fuy7xd16McFFFkwG9QjWh1cZxZTGCkdhP8cLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MdgKnJP4jKfC+TIcuE16NA0OQBWGrbXFNwKRP67pgg=;
 b=OwPp4TG+IhhLCNlzaB8Az4IoJBPzOGbQmka+XxVwUpm632Gg5n+lYJPonnJ4c2bUozIuk2/S8Yv8g4OdUiw3wjrlPieIfpqs8FbrbD69TNSAPeCnjmY3FRiwt+LXd5QbXyXu9WK3KaWWGbCamyZ7v6SsPC13QO0GoZJHHBPNer4=
Received: from BN9PR03CA0547.namprd03.prod.outlook.com (2603:10b6:408:138::12)
 by SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Wed, 6 Jul
 2022 14:09:00 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::cc) by BN9PR03CA0547.outlook.office365.com
 (2603:10b6:408:138::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Wed, 6 Jul 2022 14:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 14:09:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 09:08:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: make get_refresh_rate() static
Date: Wed, 6 Jul 2022 10:08:42 -0400
Message-ID: <20220706140842.116064-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220706140842.116064-1-alexander.deucher@amd.com>
References: <20220706140842.116064-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c608731d-e24b-419e-18a4-08da5f59132c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PI9JB/0uJ3QgzUsfIDY7vULDbBi4febc1VTDi7h5xnPKxMHqCd6crAHGAY9HW9gfkKk+D/xJCeFOAqQVrrdipV9EXL1WLOKFk4iMxcZPjgTLFz4k4s7LUx5d8mA+8o8GFRwHQQOcMLwIEkrgcI2QWBB8BniXUJr3gf4xVnD1DU9LhXuCuTMtKMArSndw/dTE+O9ax996NPmhTbbZaymOkWiQB/RD2V3AU4yhKWnKRq7qYD5L5NQ4fxT9Kzb2ij9Oaeqaxr3413/+h5ZumH9IVRRWOiGNKMW0IYvuS6fcgrJNWr0SSap81uUpb2krLk4GweHqn++oHZoYjEfFb3Qu77GHQbmB0BKWlu/Wy3CFvhY2XmuA5taDyYsYJbVTZLPW0NtNqjjL9c9MaeHR3yLOJIkMpjVhFm4K4m1KOM5v6fE5qtiJyDSHBc1NCSqVEPSf2oeeEoA6bYcw86NQRo2oBpqcAEEKeMmuTXiNwidKmEGoK5KjtC+KQCkn7NlEZtOdFhMaJ6aJ5TGqZzuhxkmvPfLMTUsjjqIOb5t/6qTPWhPzGigebE3DKlNm2oRZpq/CEaMOnFMYgcYa671PJs1zc7wOzL+V+MBzmoLl0aMXgxYJNIft9LW3QomZZJ3hDxfgAf4I0vjCiLDV5cmX+KNA8Paw4SkTIQCMmk/50Za+hSTenuuXEPs3a5iX4bVzjkqK52+w1tvJrvrelvebilwzVz4tgDzDfqH645Jhu9Yo0L+6XzBJO3lPQutmTRl8+r/LHtN9BnxgkvRBLKcTIcF04HTnT+0YCr5alrwDFzaIG5RgrvsDu/Tt0ATl2IDz4KEeJIHNX89KzfpWWncX36YGW/SC2HMbU2ZAh2Xn3eig3sH+MZpzy0TyYNbkRMLpY8ld
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(40470700004)(36840700001)(7696005)(36860700001)(40480700001)(8936002)(478600001)(5660300002)(34020700004)(81166007)(70586007)(2906002)(41300700001)(70206006)(82740400003)(356005)(4744005)(6666004)(4326008)(8676002)(82310400005)(36756003)(186003)(16526019)(6916009)(47076005)(336012)(54906003)(426003)(40460700003)(26005)(1076003)(2616005)(86362001)(316002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 14:09:00.3637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c608731d-e24b-419e-18a4-08da5f59132c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's not used outside of dcn30_resource.c.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 4f684235a413..7f01463942fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1899,7 +1899,7 @@ noinline bool dcn30_internal_validate_bw(
 	return out;
 }
 
-int get_refresh_rate(struct dc_state *context)
+static int get_refresh_rate(struct dc_state *context)
 {
 	int refresh_rate = 0;
 	int h_v_total = 0;
-- 
2.35.3

