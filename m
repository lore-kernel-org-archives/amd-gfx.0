Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D465FC072A2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 06:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DEAA10E10D;
	Wed, 22 Nov 2023 06:59:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E307510E10D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 06:59:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rnyy7Ydphzaql2+rS1CkgJGOnj2vRzTfHoPyawZFzGFMVm44l2b+gAnBjcGqh63yvB5gfmiceFrykLiIKybBMzVe/Sur4VSuGX35WTZ2b46hz6ao31j2fm+VuYMcT5evsCUxaTp8eGQi53bvciN0OaYIWQKXUy6WRMXXe5U/RsTRIJn7xtFcxCJVYWQjyPgvs6Z4HBSXTVrmuKvZuY4PlfGQj0Q0xnjMreEjBIDuyjUNeiBx/q8FiGMBXUebJB23lK7sOmhiHoqBHZI6sY0USZr4R0IyInOFzqDA/3ksDPsWVwOK2DsI3RwXahDgXz+bOSU3uFEwP3awKrEtmojkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnSg4E5Lw0m/WG9RPdrHXAP+CMepuo3i6kQI7HTgVSs=;
 b=MRcLqVuMuschD1PEE/n7MgWeQ/YLkAiEaXrHlhy/n8d6py/fcc0wG+kXqWiQiDshN+rzDvqOb/Q/QpKY2yE7mFS9uN3sg+KSmBVy4rUf5uetQno+tScv0aanNefyECDYz/IKngEXC8/C+AIAPzT9vTHzryH2UbOmrAJOoo2ahthrjKHI6YeprjOjfSdLquW5HK6jjWI3UY5jn1NDlVKlLce868Yf40OBNRJfoMcA/ZGeM5Q7rUHWUBkUu5uVrImTePW+qbbm+dVyCNy+fZ8g9d+jpp35XujDQVJczJMqsqFA7OoDetDHT9L4VAX7YOmTocW7Nu1vJkxG4k6YNm5sug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnSg4E5Lw0m/WG9RPdrHXAP+CMepuo3i6kQI7HTgVSs=;
 b=1Rw/zzEq1sPt9rMlvKCdDckgz6o+Q7KuoDyw1YFHn+OeKtfCv/Md5WKOo05GlgqqitgglZlRiXC9F4WITZCTWCYIgrsyw0/wsBOUCgcrhu/aVdU/3ZgRaIys0mtcZurABTnDr+J0LT/orYt+UGH3PP87C8Z9Mmceds3Ak3lWBj0=
Received: from CYXPR03CA0017.namprd03.prod.outlook.com (2603:10b6:930:d0::15)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 06:59:25 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:d0:cafe::98) by CYXPR03CA0017.outlook.office365.com
 (2603:10b6:930:d0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19 via Frontend
 Transport; Wed, 22 Nov 2023 06:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 06:59:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 00:59:24 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 00:59:23 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 22 Nov 2023 00:59:17 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amd/display: block dcn315 dynamic crb allocation when
 unintended
Date: Wed, 22 Nov 2023 14:58:36 +0800
Message-ID: <20231122065841.2267110-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122065841.2267110-1-chiahsuan.chung@amd.com>
References: <20231122065841.2267110-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: a654f40e-fb3d-479a-bd15-08dbeb288ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CYGOZLTuBR1TFSSkNWWvqjdTYgQ8sIxwn4OMvxytM5I43uQa38z7RVVvyyN4V9Njyw890aXHqfTWrhoYVZlBf7kPkL885N67V0DIC5mLaMB0KGmeGn0HenAYEPaHaM5QWaoAA8Hrt1bXHDG6sykrRFAoO3Fj711fYzloy5qcFcYP9GnoqfWqsDhqgUhqr7rkzo8hB4S9xHdJzHrXSYxTy1NPXOtuMHID9xWAKbWwc4LDSM30N2CKAqvEMnEbhqGrXg/ysh+PxB387DUqBWvrG1rI6n3zBOZbbvZKHVdeYsadlC8+gK+/j26VBvyTKcocToFAk7Dz5JBvGDJekiSgboMt66J5gsEkrALCOCXz+O743koRMb8YczPUhynMmtXz6fRBU3Ft3LGEvIzQMKcWczFtpCCYc2kZJM+GRv8PprvvdicM3GYu+cQAS2Bv/muk9YwA5P09ZYquW+xiOhX0pufKSh+T7iJaJXcDfVHTQcKYN3irVuDXIDODzz3ySk3aqXVlwYCt+wjX09lQ9zUuL7qjeWsn2TNyEdqxkeR0UIIJ/VftTwfi/ce126PeejnpgeFUIbk7flgD5dbKdrKRY7ak3oWnH4YIMDRtQXNiJg+3jX4KbO8xurivWz9dLggvD0oXRj6c7+OvboIuolrN+YWgYjt6EErx/ZbO1ZvVsWLg5LXlJ/S14CJuDkeRTkR7zK1hfbYw8HOg5lEoxGSOiPYz035zRsklPrwQu2KwzcOzGq/ywjqG/DnMAjShCcbZGInX0p/xOVi472peijZqYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(40460700003)(70206006)(70586007)(6916009)(316002)(54906003)(36756003)(7696005)(2616005)(6666004)(426003)(336012)(26005)(1076003)(478600001)(82740400003)(81166007)(356005)(83380400001)(36860700001)(86362001)(47076005)(5660300002)(2906002)(40480700001)(8676002)(8936002)(4326008)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 06:59:24.8363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a654f40e-fb3d-479a-bd15-08dbeb288ff4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

[WHY/HOW]
Limit the dynamic crb to dual stream configs that include eDP

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
---
 .../drm/amd/display/dc/resource/dcn315/dcn315_resource.c    | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index cb8024eee8e4..515ba435f759 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1631,8 +1631,10 @@ static bool allow_pixel_rate_crb(struct dc *dc, struct dc_state *context)
 	int i;
 	struct resource_context *res_ctx = &context->res_ctx;
 
-	/*Don't apply for single stream*/
-	if (context->stream_count < 2)
+	/* Only apply for dual stream scenarios with edp*/
+	if (context->stream_count != 2)
+		return false;
+	if (context->streams[0]->signal != SIGNAL_TYPE_EDP && context->streams[1]->signal != SIGNAL_TYPE_EDP)
 		return false;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-- 
2.25.1

