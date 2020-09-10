Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB108C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E75421D81
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PAzggzM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E75421D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BB736E954;
	Thu, 10 Sep 2020 13:47:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E571E6E945
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnoSsc785urB4XqoYggJeDxW5UW+er4QU0dvClIkjAT0VfkFwmJ8zVuGqWVO0elS2l/nV94wlJhqJoF/tgIa5uHEMRxSwF5xgviZ+0Xf3Op+GUutoICSsatZlxeBgoArYP107nRdABS9+DTxrcQRDUfnwox8wZXbosSahF3Ypi4OaA4M8Cif0ux+mhvzJH8RDLmuKKRwbSZrLYwSIRYtk5SZ1DmGT3+bxZthAVAqatJe5Dbp8cwA+npXTEEJhk6AZ581FywVtBLjh775HuH/e7RWCqn/2WB3UXdt0qfgI3soqiki/+oF9CahNhwzIFMBvRnvFu5vwAlghc5UiLlNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0NtUGHi71aUELqMWG/e1DF+PEqAh6ydcoYGw9Nozn8=;
 b=WrAWWf2Gxb3hK+xt80bYqSs6bpYQeUUlTrohUintyFEqn+P2FSPSws9bXCPY7xWyt8uhcNEo5rjdcdnUD3exmTPZ1p2rx2bMIXDV5thAErvq8UCb+VWZc3kq71DKfp4OBFqByWRSZLF10vWt0WVljCOW1tLDdtYmBPDKrcKCmMbuvyNOTH06c1cTVz78zI4142hwIZf7BwkeMctsc+9aFmiNqWoX+vBfQN8u2ZXT8h9Fwok4Ea/Ox90+4bF3RMW46QzV6jW+xeXwZbFGe9mymfkxTwnMhDQ9/gQbYFCrVZNqcyT2nDmz6w1DvxVTzszhVXDvDb4ArZ5MIwk3mz4VsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0NtUGHi71aUELqMWG/e1DF+PEqAh6ydcoYGw9Nozn8=;
 b=PAzggzM2NVgQ/w0MUfIn48ogbLTVZDqUnAjaAdVFhdloTW7+D02xz9qtg92RtmFhSJb9h1aDIJmI3q5PuyzMhiQleoywKkDcITEEvdGQ8fdKkf3nZxQnTsAPqfw5M91bBOSwkWXsIbVCbz9FlL2LY5Y2XkBASU/yx2V0uuHXlTg=
Received: from BN6PR2001CA0045.namprd20.prod.outlook.com
 (2603:10b6:405:16::31) by CY4PR1201MB2471.namprd12.prod.outlook.com
 (2603:10b6:903:d0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:38 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::5c) by BN6PR2001CA0045.outlook.office365.com
 (2603:10b6:405:16::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:37 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:37 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:36 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:36 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/42] drm/amd/display: remove early return from dm_late_init
Date: Thu, 10 Sep 2020 09:47:00 -0400
Message-ID: <20200910134723.27410-20-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5d2882e-e089-46db-ad71-08d855901462
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2471:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2471AEC22B31FF5F2D62D7C78B270@CY4PR1201MB2471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKqb70ZctC09zolbpsncW5yBq/vP+v/4Rr57PaNR1DDzbvik9LNsicY9DgZRKv2g6JKRA0C+ecM3lF47nNzBRQeqO+33FIyCZHzoWnWKeJQjHDEKV1HxF2RCko3bvXs2DFWRvYqqMgOW1IYjWj/uRmjKWUZXHdGNIPeLlvKkLfkZEbM9m6lp4IQA8n3XtiOWRNZXDTGjodXn7ln/ZvI0IOs7IteLQEMliQp2V3xpoJ5oj5c/9d2+3vIlOCUTxOrY2cRHQcw7n9p+n/i7k0MMhLgrZpJ8qjjolgdJsvjMDVJzE+RVekoY3Yzoqfa9Nkrysa14AFxcHHIaWOJrkSP4HQMByFvMQdRzY8HNkKZk58IVAUp3d0mQtHFUEjYoEsweye+lLC+W5Z+Ks7S9XnZ8cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966005)(70206006)(1076003)(356005)(82310400003)(8676002)(186003)(81166007)(26005)(336012)(86362001)(7696005)(83380400001)(478600001)(47076004)(54906003)(316002)(82740400003)(4326008)(44832011)(70586007)(426003)(2616005)(36756003)(6666004)(6916009)(2906002)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:37.8138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d2882e-e089-46db-ad71-08d855901462
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2471
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <roman.li@amd.com>,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
ABM feature initialization was not executed due to early return.

dm_late_init() had an early return in case if DMCU is not used.
With the implementation of ABM on DMUB, DMCU can be disabled
but ABM still needs to be initialized.

[How]
Remove verification for DMCU from the top of the function.
The existing logic will handle the case when DMCU is not used.

Signed-off-by: Roman Li <roman.li@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a7f08a8199e7..9fb0dca839a5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1389,9 +1389,6 @@ static int dm_late_init(void *handle)
 	struct dmcu *dmcu = NULL;
 	bool ret = true;
 
-	if (!adev->dm.fw_dmcu && !adev->dm.dmub_fw)
-		return detect_mst_link_for_all_connectors(adev_to_drm(adev));
-
 	dmcu = adev->dm.dc->res_pool->dmcu;
 
 	for (i = 0; i < 16; i++)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
