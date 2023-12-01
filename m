Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013FDC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A508710E89E;
	Fri,  1 Dec 2023 13:29:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 259C910E892
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjWKeJIHOFajJ8KCyAJKdQ1nqZ49xK7xxVGOylhltw7yuSQK/YrPwOiryIcYTO/TvYDXsAaxy6Ycjr7B7Yoxb0Cube3GIZl5PHLu+fdcvtqmrd+Q+ldIkhIFXF18wpMaL3EB4dz20zhKFVqQcCINdHlqU/wd0tmi9NkpjomRlmMhQzpZYqxfBYx8F7lSG43zsPI3D7f9614VayzQIz7EFa/ck7ZLHbsBg6JrmsFTM+/a2GKBBGSia3piuIprqVVN7/I7Qqg9VoS29JcULSxoQGD3zt1euxZEpMNqRcKh3hyTEOehlODAbje6bNBvcHjLp3Xj2VV6eTujOQx76XpDLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si5YcsadWIsyDYIxSUM0AQ80WmCjL4s3XO43zhqROK8=;
 b=mNNTk8YBjHoqfZeaSifcseE5IhtRG6X5CWrDoCA0klK5cBzuQrecp04Gmnbxd7U6uPiBABZI9Oqtjl5RG3ykbbzzgKx8aieTM8PebTchk/mqxlIP/KmR95098WfQImdCQHht92w81ZxMcGxsSmOnXv4cUQyOhBrjnV/ueZ81Y9PUk+XDBNCaqlMcJ80pqgf42j64R0ljw7Nz6K1eqaF2WYZ1PSeIWDdjhdijTI6rkq2+198F1nTcIH7w5GxOM+HMgUmaIgPF1R8VAIG0WUeCAf0EgXEmcleapMNLCBV8eZZvlOSu2t4AZ4Bvp6YYt4qLyF4BxUWmoMXV60fo74pbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si5YcsadWIsyDYIxSUM0AQ80WmCjL4s3XO43zhqROK8=;
 b=igOs+y70ky8QpfetbRHRms4aEct6TO0cdvuveZ/R7xpZ7Xwij7EUojDbQ5nyc/zGh8bmIoWEr/NblRjFOlSs6KfRiWzFmtLQfpTGB95Led8jH6HFKmbGXg3SzkuMtMUEbJx4PhMpBp4Uq6qwGUlF8aD7S9aEOXXyj0Z0/InNllk=
Received: from DS7PR07CA0020.namprd07.prod.outlook.com (2603:10b6:5:3af::12)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:29:32 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::dc) by DS7PR07CA0020.outlook.office365.com
 (2603:10b6:5:3af::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:32 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:29 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 41/47] drm/amd/display: Setup for mmhubbub3_warmup_mcif with
 big buffer
Date: Fri, 1 Dec 2023 06:25:37 -0700
Message-ID: <20231201132731.2354141-42-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c77f16f-0cc3-4b02-49a5-08dbf2718d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uy9AMwqPFZ5LNhtf6nOgsYpc/S8RZQ3cWhBo7CbPbEI8cdrspRfS3hRYzA3PGdaPL3CbrB8KPXvKha9Btzijl+nHp8wV7I2jdGpq4T6qewQ5G4M/GC/dew9zIRcRNLDd5Hl28YP/QIf7ik0Ka/gb8frFJKC/Qxs+9hS99WKajZkKoi9aPXZMgpDEm1YSs+aseSyeY2b3NAKaJJKATmFCcj4MfI55xDqrprXoGJzVeyqiA77sTQSRBlmK0FZf/Bvw3HDPHJ1iblNrbmTgpkgNKKwjRI2TltKxI6wG6VS1FY6qhg9tI2YYmY/zKJ3y8UKLnrXxYWKJt3t3Hws7S0xXXtdGOidJC1S1xz4Cj5ug+ehWjmIbOnO6fwR39CrB64sW5ap9h41Cd8HmMapZNZY3bOl6MFfVsl1y/YjpE2ixNMJwV1XzZWWWsLB7Ssq5HYA11hu4yCd+r9d4QkUUwQfzedzIItV1XjhlQGU6yBtmbdqO8f2LKnzu8IeXSLU7uBYna1W5WMr7ExEah9pO9lpmkNJHj19AT7Cc5St5+0F1sAa/S/g9qGwcw3jml6FRuVqbA+udVwEOT6hzOfqyIU/xcAma80J2xxBlSMA7ZrtmLz9i3ttbfX//3H+lFu5TVjwV2/G7oIG6/swgGB3ACY2/+havIC1aMkYy3OvI91p9x+g5uAg5lnt4++Q03L0FAyqy9bJwxadyo3P6S+aHTB+gb+zDGVNQPKqhNFA6gsq3CBhWLfcP0CE8sLHIegoVcVQQgmJ6HEHESh83LH1E6uk/aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(36860700001)(47076005)(81166007)(356005)(36756003)(2906002)(41300700001)(5660300002)(82740400003)(6666004)(336012)(426003)(1076003)(26005)(16526019)(2616005)(478600001)(70586007)(4326008)(86362001)(70206006)(8676002)(8936002)(316002)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:32.0529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c77f16f-0cc3-4b02-49a5-08dbf2718d76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHY]
Hardware may require different warmup approaches - big buffer or
individual buffers.

[HOW]
Setup warmup for big buffer when it is required by specific hardware.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ac9369b40191..9c4fbcb8ff95 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8824,6 +8824,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 			      struct drm_connector_state *new_con_state)
 {
 	struct drm_writeback_connector *wb_conn = drm_connector_to_writeback(connector);
+	struct amdgpu_device *adev = dm->adev;
 	struct amdgpu_crtc *acrtc;
 	struct dc_writeback_info *wb_info;
 	struct pipe_ctx *pipe = NULL;
@@ -8899,6 +8900,11 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 	}
 
 	wb_info->mcif_buf_params.p_vmid = 1;
+	if (adev->ip_versions[DCE_HWIP][0] >= IP_VERSION(3, 0, 0)) {
+		wb_info->mcif_warmup_params.start_address.quad_part = afb->address;
+		wb_info->mcif_warmup_params.region_size =
+			wb_info->mcif_buf_params.luma_pitch * wb_info->dwb_params.dest_height;
+	}
 	wb_info->mcif_warmup_params.p_vmid = 1;
 	wb_info->writeback_source_plane = pipe->plane_state;
 
-- 
2.42.0

