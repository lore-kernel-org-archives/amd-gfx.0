Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C78FD88E1
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 02:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A09810E298;
	Wed, 11 Mar 2026 02:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="utJzy+LM";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010024.outbound.protection.outlook.com
 [40.93.198.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7762310E7BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 02:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lexj6Rvby7JCH7yCW4rskU5uxFCrfAMTlIVP1M1xsTJRqz5KT0/N0eyU7lcLLaZ/Bo8+m8QB/GZehWGi1D5/nUfUM5XtvASUSyEfeCTYK9WFt4ovsAin5+WXMHSjaWErwi29CHK98sc5XyF4BMxjZ2HG0qqWJM8VuZBokBYfW7kA6jh93V9K0Plb/Cj8I6Y+crzMDkqbRmOPY47aG8Jmin2UuiBJ5O4HfVAZv8STc5dJEgOoJdiZ5JFEsTNlN3MMEa8SrVa6uls7QdmJOC/xgzIKLI0mFzyaJdE3UIVQ0JY1jNij6cNUpNwxGS14yP3OtOwfnfN7uVpXRav2f3HrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkoFOUx/HUhFvnlBAM10/P0MOwGxP9j43+RdFOSGD5c=;
 b=Ckg82f59SC7js4ZIPJgXzVKrdMA3LQZXf8MaCrgrX8vXyjsxBUhFaE3hetChgTK3k7K+Digq6nNA4KRGwojIm+m+7WfbiC8FSOxGZVzeJAKAyJG1g/LBxZ1Saw31P/GtGesWPypNKdl47pW6d3aYZHAqKFg+ILm+JHqa7uRSg2YzS2Eho4ZpkookJr6WggNr7ccFyufpB06oEGUc99AlqXYCli/fow8DkB1jUe7vb+MaGtPQtqpqYeoOrAdJ2zwJBVyIruAI65wfWkgfSOjngYM31JYDEKWNmwEKoyv4vr0k7lraeAEwM+x0vzGAQBZBXZ6ReifLFYMcp0lbBPUIiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkoFOUx/HUhFvnlBAM10/P0MOwGxP9j43+RdFOSGD5c=;
 b=utJzy+LMpz19jm1I45x2SYnnXj+OvInWw3J/pscObPSq4PLEk3hIHwCSwkwTSKpFjUAsbqeAJva3xvSXRLR2SI1hTTu1Bfs97Xhdgy3VRPI3lX6Bjf1WY7D+SqIS1OYSZDTUAnlQu29oJxtzl7h8ZLlkmH6ljLQFRvb0Rq5jpHs=
Received: from BY5PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:180::41)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 02:46:13 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::3) by BY5PR13CA0028.outlook.office365.com
 (2603:10b6:a03:180::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 02:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 02:46:13 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 21:46:03 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Chuanyu Tseng
 <chuanyu.tseng@amd.com>
Subject: [PATCH 9/9] drm/amd/display: Promote DC to 3.2.374
Date: Wed, 11 Mar 2026 10:40:41 +0800
Message-ID: <20260311024652.2668570-10-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311024652.2668570-1-ChuanYu.Tseng@amd.com>
References: <20260311024652.2668570-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 393693de-0e5d-4565-9dc8-08de7f185c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: o/SIhjBZm7R2ZXVKXFYQyyp2DjS/cVZNth0z0VEHLSOs1C23Y+EVjUgTPmuJZJuFIZ5Z/EDs5qHaySqvw+HRPBv77b7Wc7ghpKm3Uyi6QAMdvscxDoq2sIgFbFlSxArkED3rFi8yO8giChqkUSa1RSI9xvMi9jnKy7QfM/GEfnJvXwBp1c+M6Ba1AJ5UhKXv8HpNw3DNNJTHoYD0HOYNoWBI7yD9sGtSj895MaqHnttVqgBJC30ftRfnDsQfm3N+5RfSMk4e2SaAuep/D7jcT8zeZt5JhkPr3FVkz/Ro66SttpZf9gLlWoeGPrVKsbZIb4KvNuc9zsdRNkwVNARg8tiv4okbqeQG8c6m2zfl8ETDkGojYks28Exql6uRNMf83b4PO6pJmf15oRvQFoFowBxZqdakc4s75+4Yy2sl5nWeRupwifpcXndnoBa6J6GsXj2fcI8cD2RsV9Q+XrYKt7TOxYjIECGjftlf/QLMm4yIYSvCP9L0TRzzXPWVvTNGQjSJxD9u6cObCJq40GN0LLnAZzcl7UrXjNk8OJwdZn7KQ9qo4FsMNcZLPqK/hL6UTLmLClBmIenGSc9Ym1A0rmXWH6oYj+/ucRLW8MtyymbGfFAFpqd+c6op+2T6WuI7MltgGvS/DzzGsVE7qoAduEOHcO62KL2UT8Ld5o9oR9VVksnoj0wmozD6SeU1xbl5RNxqz8XpLZyF10nctIMM69dfFGaV1lxMm9jGFsaHgT2W1LldZwGlFy7VwgfbezP9gKZzQBZVxix34lzGXldmJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VLSnbbpWUyibTLwh0ho4Id1MesNiR+z8iKIDu3gSX7Yf5zNNhU1a4ERd4ZPwXFu8a7e570EStGREfkgzuEW7XnjnnKbjk86jMPIkIMGgbijvtFgeNqdvnOGzJ126M0Nv7i8hhPXMuPBoem2tKVjf8hEHuqJl9OwzxM013StKhNvuXBJwCdsxQR5y0yL2LUy6QUsgHnKUosuUPbYAOeXLXDWmKHMrYSh6MptFveJ3crpgU8sjgcFPkwrjEHwpeRmL1KkzWFm+CEukpOUzSeCmYuhv5QOL3uCx36P6nQtyBMO1OGe29CRpNPEZ6gUFLn7g+VvQPWlqb9vRSsjkgKZnl1heudlGQYUz5o1Ot3W1EZ6FX70lQ0k7AJnxO3nf6JeeVGrYv/UzNCHNbTIwUmC51VEEDapoXPWf/+1lgmEAz/anohYd764ixXhrf4Ixh0vF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 02:46:13.1693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 393693de-0e5d-4565-9dc8-08de7f185c06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:

- Clamp dc_cursor_position x_hotspot to prevent integer overflow
- Query DC for gfx handling when setting linear tiling
- Add a buffer for boot time crc
- Silence C6001 warnings
- Plumb MRQ programming out of DML for dml2_1
- Add dcn_mrq_present Field
- Fix number of opp
- Add debugfs to disallow eDP Replay entry

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b232de04a797..02db1a197d83 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.373"
+#define DC_VER "3.2.374"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

