Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7764ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 23:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 115AA10E9A1;
	Wed, 21 Sep 2022 23:18:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C539E10E980
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 23:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dz/rxf1qAiQjT7qklUYc7dmFBTcjVHlszwbdepkV1NEk5NmPhAF/PzYAOOOm6iAO8OQtrCe4IXrk03UtodtRmShaeZOFJsuq0F4Q4W7by7t1qzx4YI/pEmEICJzvuUZ71HZWLIBWhd6C4g5bVMuxD9K9MNXqECu64FLF7SQoJ9kzRNamhfiHPYWMZQVVfAOLHdhqKHz6C40Ndm768E1cLADULbrY756mJUv+3DedZp+Zm3zKJwD2JRWCSXUwsEgtqwFFksKDgnK3neBnVmCw1WIIFhh8fFoDeqX52gl0dw6mLsdGiywHqaZG0dPZ4tLpcgwRUgFkVoKyYmSLY8IDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5S4pK7saS1hGfcGInCTdzYPquTtR9cSHmAZj/3jGllI=;
 b=J7OVFpGP7eETAVKZEe2wuhD2n8sw980LwJ/rV21vd5hzGkJ/SMrL+AobOS10IZ44baxo4/gHA+V6oD8EB8COHKitK2frxDUIHYa4wrqogfKvO4l61DCedahUBW73jCQUjTmazjKPrJwYVTcH/HQz+AQSndBagGkp4xTzK+gTqclpaSC/qpgVBa1iqTtZGC7KNYghXP8SzgbqAvJCgQU3ME/gzggw9yRErzJr2mjcIDWjRVG9qqErnmJI9fe5hpWzEmVcSs+rGALwe3b68IuVOu2PCIRDyhJUiA07DJMuYd27uSPM1X0tR7lTe3A8HRlqqeY/+pvN0M64vSBhrdu62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S4pK7saS1hGfcGInCTdzYPquTtR9cSHmAZj/3jGllI=;
 b=G6H5uj9tI9b1ffCh2jpz4FBNP3EcgDSp9rXfCkvDOQGwMsrZuUE6VTWn2N3yea7L5su7JUoyVuu9/JdxVlPH/JItme5FANAeZ3y8PB4uz//mQjhWaqq8GhcPkAfBNryF4Bi+q/O3PmOaCnjc4VZj4u/842TLEOkYrmjI2gbh5VE=
Received: from MW4PR04CA0307.namprd04.prod.outlook.com (2603:10b6:303:82::12)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Wed, 21 Sep
 2022 23:17:46 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::95) by MW4PR04CA0307.outlook.office365.com
 (2603:10b6:303:82::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Wed, 21 Sep 2022 23:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 23:17:45 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 18:17:43 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/31] drm/amd/display: Change EDID fallback condition
Date: Wed, 21 Sep 2022 19:16:52 -0400
Message-ID: <20220921231714.303727-10-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921231714.303727-1-jdhillon@amd.com>
References: <20220921231714.303727-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f6a9551-490a-419f-42df-08da9c277dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rcZTFSa9/jUmXDwwvXo4LDNRmJGSSOYQUehJp6LrVnUozNaunZU/Zb5SvXiUUenxi9QcHLjIJSBf0H0AnbxPbIg4QXcKsneVxuo3nOUex6raloWza/BV8Agl0fOUJdkmB6gVuGsFMy0lxJaafDjUJeUSqU5sOAJjcgZPG4NcVZIHtDRl9D5WAThYBU1G+d72Ak8hp110hfTDB+H9Bq/G95nwXeFZM6Cyh1KvE4xcFofQKenHXEYvh19dfnrnvL29WnuXhwxmKb13LPSFhMqg1Uqr2vSpJF/OEKtNJmP5zXy7E7H+ADDZtx6cMsHNZGboNCZ6wB7gqnQlXoW8caVTquJ3mMMQebkSnich2NVSxnAM/mKZ1hKfL17D3W3jbEnd74+a9SbFNxUMhwAbatjpBeCmu6UYrL1dwguqyjrkV6WSX1gy3nl8l8lePRoFZq6JLZsW9UuJzdZso/Ux7Wm6R6wOME5Ko+KOJEmdUKStFH2JIf6Tt07rioXzWuCU5zAEkMg5fVKwrLb3EsQ0FzSFQvPMgBEmpR0OsVqO73g8N7QkxE+kJUoRrV52pGFBkbtjHnCGrFZoWi9CV76UlVcgMUL2Xi1icvro9YVZblNCZ2bIfkGHP3AwlRQtDG3MeZHi9ctkrrJJCTuIaU46QRgQXjhfre5qy27LEwI2T3/eI4gMv5inB0bM43Jw/TfCNNa/QLOUFkt07gE36Y/58FZK0gXXqEzGfMRjBYGEx8kPO7PWfp1y1T0l0zvPlciSlesJoYyO1T/etFMZ7LdJoBKiI+ETB6Yrg2vL+PJwMrJryDdv0w9xYbjhRXUNuqtaNH2l
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(5660300002)(2906002)(70586007)(8936002)(478600001)(6666004)(40460700003)(6916009)(316002)(70206006)(8676002)(4326008)(54906003)(82740400003)(81166007)(40480700001)(356005)(41300700001)(36756003)(82310400005)(83380400001)(186003)(16526019)(1076003)(47076005)(336012)(426003)(36860700001)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 23:17:45.2667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6a9551-490a-419f-42df-08da9c277dcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
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
Cc: stylon.wang@amd.com, Ilya Bakoulin <Ilya.Bakoulin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why]
Partially valid EDIDs on MST sinks are treated the same way as broken
EDIDs or read failures and result in a fallback EDID being used instead.

[How]
If edid_status is EDID_PARTIAL_VALID, prefer to use the valid EDID
blocks instead of using a fallback EDID.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d93393cc66c0..351888fe9b72 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4061,7 +4061,7 @@ struct dc_sink *dc_link_add_remote_sink(
 	 * Treat device as no EDID device if EDID
 	 * parsing fails
 	 */
-	if (edid_status != EDID_OK) {
+	if (edid_status != EDID_OK && edid_status != EDID_PARTIAL_VALID) {
 		dc_sink->dc_edid.length = 0;
 		dm_error("Bad EDID, status%d!\n", edid_status);
 	}
-- 
2.25.1

