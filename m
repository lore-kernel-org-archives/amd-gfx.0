Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497FDC33CB7
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB8020CC7
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qh9GQpAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB8020CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB196FC50;
	Fri, 31 Jan 2020 22:17:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 804666FC43
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCMo9KLVYUHCDRzn9G95kh8SI3nYFGvhO158wjNP3NUPq32VnNRx5XAesqaLMqWCz+g1polbBu0MOVC55yuTEpBct7eW9rhd/5UrLXu9UNj3PzeJXKdOyEgW4Lt2JEb7ELSN5O+MJuiPo6B0xzzYmxPr7TMz+c14x0+u257V15qs7teFQN/zoFReWcn85BxPlm7B4Esd16WNDWnMfarkBncuiw0TM4T9e5JtBOef9RmikUOxYvDYDHv1e+DB11sCr6ItSl5tBzmBraM4zwH4PKji1VafG/+qRw2W0hvRWaD6vHDlJz/pKi0qOH5HzVYHjEiGUuayQ5FCroC4OTeZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtjDgswu1T2DEyYr8+IQdwsE+mBe3CBubUHFY/yJlxg=;
 b=TbGx0C7XzeZgAJk9H+bA7QX/Bbz7HeQis7GguxQctXbZSf4rToNNFqNi49FgthVKs0Q6P0x5em2AYF74p0Vf6OYJgLZC6IpGNUZerfdvBh3UcN25dEOcYVtHoVzowrFX7JpenDSOn5y2O3GKJLG1ZERjXAfCkA7KbP/GuP95odJjW93+YiL15dF5lZPU0tD3B9v1SgrcBwnrCkZM3AoYRLkR1U3dGBmCI+aYwgRgMJf5HuzKbdWsnaGuQHJocIUSpOHE2lCyx75TJ9pvQzkPxYUXR2nJXWN0jZJ/ggVp57C2mHxNtSXSURNXOCoALLBjFtYUUcWS/Zi1RmBAFB/tng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtjDgswu1T2DEyYr8+IQdwsE+mBe3CBubUHFY/yJlxg=;
 b=qh9GQpAnj6ddtI1hpaOfp1XLLYWJi5WTcTqOUCt/oH/4D3jHmHc9dGE6IycUYbpphcOy54F36lbNKR2BB5noMkGCXLcFGuRGQVmHfV+up5kXr+98J6iHFBc4dTtsQpj4ivOZ7DTfcoe9p5LzTge6VmgRkGVSNTvmAoUDiusW3o4=
Received: from DM3PR12CA0084.namprd12.prod.outlook.com (2603:10b6:0:57::28) by
 DM6PR12MB2715.namprd12.prod.outlook.com (2603:10b6:5:4a::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Fri, 31 Jan 2020 22:17:22 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by DM3PR12CA0084.outlook.office365.com
 (2603:10b6:0:57::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:22 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:11 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:11 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:10 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/33] drm/amd/display: Check hyperV flag in DC.
Date: Fri, 31 Jan 2020 17:16:33 -0500
Message-ID: <20200131221643.10035-24-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(428003)(199004)(189003)(36756003)(2906002)(6916009)(86362001)(7696005)(1076003)(336012)(4326008)(26005)(2616005)(426003)(186003)(8936002)(356004)(6666004)(54906003)(478600001)(8676002)(81166006)(316002)(70206006)(5660300002)(81156014)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2715; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9d1614f-e6eb-4c9a-5124-08d7a69b578b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2715:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2715C460A99AC63B6405A6F7F9070@DM6PR12MB2715.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KzyGe22EBauItrzdX57b+puk9zBMv9CK98fOMtE/1AuUVVVY853xWFdL/MSpDuMHBAqyXVt33O4fA/VGHewafigaQtQ5syU85AtgtbCpxH78QLN5h457hHpk+1fV3xD0RRRDsNI7F5kUPTAO+7LMEXL8nHmonDbsjGGNNF4kOpEZeDqSo1we7eragnGZpQcM+GEbduBQ3EAs5yjnbRPV3DtQg+PFFeRyGbHniaO0aPpqNW/Ku1uvv3ToRYpry336z60gZMm4AE22gasHUmWmirC6jHD4ayOFx9cRSHzYK36Sk0r7+KvsNmTs3AiLHvIS3E+mwliVcNWyyEk5WlJKHBF/Ut0/nhPOJXa5xXzJedKDx7hEZ7yvvL7voj6E/8TJJDD5qurVDiRl2L/KqkMvNwm4LuRkBjD9i879gqSN8ef676pALF3U9k+6P9S0Ctyq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:21.3493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d1614f-e6eb-4c9a-5124-08d7a69b578b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2715
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
hyperV flag should be passed from dm to DC, and override the
nv12 flip workaround flag.

[How]
Add flag to phy address config struct and pass the value in dm.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dc.h                | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
index f2b39ec35c89..64cf24a9ab08 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
@@ -47,6 +47,9 @@ int dc_setup_system_context(struct dc *dc, struct dc_phy_addr_space_config *pa_c
 		 */
 		memcpy(&dc->vm_pa_config, pa_config, sizeof(struct dc_phy_addr_space_config));
 		dc->vm_pa_config.valid = true;
+
+		if (pa_config->is_hvm_enabled == 0)
+			dc->debug.nv12_iflip_vm_wa = false;
 	}
 
 	return num_vmids;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7be2023f1a66..6f94906968b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -453,6 +453,7 @@ struct dc_phy_addr_space_config {
 	} gart_config;
 
 	bool valid;
+	bool is_hvm_enabled;
 	uint64_t page_table_default_page_addr;
 };
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
