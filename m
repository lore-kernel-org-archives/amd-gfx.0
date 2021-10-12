Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2460BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 16:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCEF461050
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 16:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BCEF461050
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3510A89CF8;
	Tue, 12 Oct 2021 16:40:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF0189CF8
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 16:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2cUmPlCZbT0IUgfOHl0XZ3hr9mm7TDZ62Ip+VnvOTVOagLuybQ+LQfVU7BBKfkslA5Uu0hqbkTfBu8bbHaCbFz2MGVLXp42+gU2uIQE+5491ju0LCsAbWTkRQ/IC87HMnzzBxHho9+EXD8wk9HrJ2RTPPW4sdnawqLg1VuGJQLTCbJy/3kAN3gGzaT3EQJF5fcg9AX5wOr9P6Y7Hcp1LR93Aj8vdJ6CtIme0MBZQ0IAv6L56P4D7fjl+JNAmURolzF+FtQq5BEmicL6mVsfjuiTX6zZNz0CN6zsWiguksrlrKN1ltoLybSOU6moXN+BuXZ374wcDEQGOz58lq1ARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2Ef0QqZlNeFLkWM1QA2oN4XOjU28NuzJn1AMxUi1is=;
 b=JKfHEpwCfY4gf+1bpR9R+Dn6Y2DVSXNKT/APAGwaVCNtBRsZdKqhhOQdgvN88T8sqXu+696eKEsnf+SAvLV/pvs7CN1vFDt2D8jA/NNV9gmX9SLC21+kqkcDdYDYe4yuzBwALgiqxBJV4cI2T3Vl7hWdUwJ3+xLRiyJPbNMpeQnTiKnR7dpurhtct+vhgnlccVF7VheKMyKh6s5DY3ZMTaGkgZr67lkbi+o2gsQqoDiyxIXXgXkcK4Ku6uBRuPGydW2XicHz83RmoJQKvzOFMz0zY24LBuAi23IFYud+2lkxe7zwZh79ECAtYbFPhWDqXdBPcx+ANDALmJaFmA0QDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2Ef0QqZlNeFLkWM1QA2oN4XOjU28NuzJn1AMxUi1is=;
 b=cPBT+ndKJNeVZiQ8yFz/SrhX2n4XvcYks+da0Tm6IAlZL0jpQxDR0VSXfBTIHk1WQC03yoRhT0UYFa7F3tPaSrrlM/EKTMQ3HJqeZiOsP7My4ZjcBPcatyVoyEBBfT4siJiUG5wA/4hUCpZE7ITLTcJTKOzpCuE+78HVY7zoyGE=
Received: from DM5PR12CA0008.namprd12.prod.outlook.com (2603:10b6:4:1::18) by
 CH2PR12MB5515.namprd12.prod.outlook.com (2603:10b6:610:34::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18; Tue, 12 Oct 2021 16:40:27 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::f) by DM5PR12CA0008.outlook.office365.com
 (2603:10b6:4:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 12 Oct 2021 16:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 16:40:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 11:40:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx10: fix typo in
 gfx_v10_0_update_gfx_clock_gating()
Date: Tue, 12 Oct 2021 12:40:03 -0400
Message-ID: <20211012164003.1073534-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 206d8ee9-dcf8-42d2-d116-08d98d9efe9c
X-MS-TrafficTypeDiagnostic: CH2PR12MB5515:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5515D74CFFD10E7E9B3E3D25F7B69@CH2PR12MB5515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iNbgvLDcGXRyInxRMZUs9XulD2qZ6WWVln8FqgOorXzALrS47cFqRczSAhLk/MNkv2TFwwFVUXG5TtqNH/udbLIqI3o6YvKise+SCUuXbtMNcOLkDh+tOxMCL83WcdvRHB2Iv7zWH4Ha+ulvbaNo3gFg7Yqqe/aXCFP9hznlPe1b1M+1L4nWW2wxW8b/x2CBLkNbtZ/YXt3FHCdlX3D6NWSYwHhoGUJVztKJKge5M89YMjuI5mzcLlhxuJ2/ud8wRYvMN3FTNp4Koa2CxyHPpWF6W+nLJK7AAU2Mm7FNimersyDzRCTbCcBlh5EXIK3lIDRCdGRxDa4zlc4At69B6sOUutGmaxLGnmrPcKdCP603QcKAU3wt7F6JYIkf1I4vNX9NgpFPcV50rbK4WAaxD70NrQB4L9j4kuzSicGFbfF/mSZA8M04l1NJrDgjDlpNadmomGCfRDG1U/dkWTKSeknzpLAIxSD5GRqU+QoqGQXIYUdc6dq/0s4sATlpO0ALaXU/QlXjjcFojJAiqAkCZPsW80BqRqSpicDBp1VHm7p5rANRdNMt1jWWKP30RNwb+cSfP2BkGDBvREkODlcXYc4VdYEbzQS5TJ6AtTsF0evBwVQv3CiOKOcmS8oOKmqZAMVMq5X2+z33ETGXZOeyrOia0m/qmk89DuGIE+SFj9DHcsQQB5BbhTI+hK4NfOxYIOFPoAPKS3QBZncHA2a8HnLAqlRmN43XLRoF47swSm4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(36756003)(26005)(508600001)(6666004)(426003)(316002)(7696005)(336012)(36860700001)(2906002)(8676002)(356005)(82310400003)(186003)(70206006)(70586007)(86362001)(16526019)(1076003)(6916009)(8936002)(4326008)(47076005)(83380400001)(2616005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 16:40:26.4795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 206d8ee9-dcf8-42d2-d116-08d98d9efe9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5515
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

Check was incorrectly converted to IP version checking.

Fixes: 4b0ad8425498ba ("drm/amdgpu/gfx10: convert to IP version checking")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 71bb3c0dc1da..8cec03949835 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8238,8 +8238,9 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 		/* ===  CGCG + CGLS === */
 		gfx_v10_0_update_coarse_grain_clock_gating(adev, enable);
 
-		if ((adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 1, 10)) &&
-		     (adev->ip_versions[GC_HWIP][0] <= IP_VERSION(10, 1, 2)))
+		if ((adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 10)) ||
+		    (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 1)) ||
+		    (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 2)))
 			gfx_v10_0_apply_medium_grain_clock_gating_workaround(adev);
 	} else {
 		/* CGCG/CGLS should be disabled before MGCG/MGLS
-- 
2.31.1

