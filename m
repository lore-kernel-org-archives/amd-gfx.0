Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB42C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 19:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E60207DD
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 19:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iNTP5yL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E60207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF9E26EBC0;
	Thu, 18 Jun 2020 19:49:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC4196EBC0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 19:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zzy1bsQVX5Vsups04TxRSk2Wwm+MOYmcC+597zM/aUhZgoy87KvexkdNOTHszkzKlkkOGmgZstvP2bPd69/ftoxIQEbG5eIjFB2+sshio0EWTAV1jBeBUIb5AM9ZwaeSQjE/kDW5CYLlDOxXHS3OnOPji9PjV1DG5Phd7E95PnGJDC3nNBFecDWqgGXjptO0qSypZDJjZP6ag01UcX8uLUolWOFc7LwdfsrUWYnqghbVRPmD/8QopYMiRtfgW/c4yAM3h7Rk5E65v8MDZxQa5L0B5pwv8ZKswmAJ82EZy1Qw2zS5BN/klG5nRapwbvlaMTAR+bgxYrbozIaPBW3fhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3aZbXuwfkjuBOK6L+jv9F4N6Rdx+Wc5EWMJJ1nb7AU=;
 b=cn35mbhtDmRTq97NM2ugH4tuGK/zMMF/c67Gw7+G6hVisSPC7QNGGLb76ExQzkP5jyvf33ePHrZk/ZQpb/He1aSXgFS9qlT0iD9TMqh2L0+Xd0W5XvORKEq2RuzF8ZMgTa26MNWig6LN6aNryZIlneqheMoIg+mWWTOiH+sIhzBy94DNuZq4s1j5QCeECbqOe/HXfOGmICJqYMg687jPhoQBgR2W8N54u1GyUp7bpgqgLv1HfRycpGw1KfUZsPrkqmBPtkbmKNJNlLhn2aF9E2/UQOi6JrEdPS4oBzrg77Nkp43Slj/1ncXRvZq0WF4vBkp4WJmv3eCmUzz3dKvYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3aZbXuwfkjuBOK6L+jv9F4N6Rdx+Wc5EWMJJ1nb7AU=;
 b=iNTP5yL9fZy94eCZyOSUMb0YKdFbF1Hgc3yLJ5aEUj9EmzfrauFlEgP9dt/qaj5YTpIwm3At+EtOSQbC/zj9i3ER8ULP4xxVqJOpgoAvqaB10ZK5Sw3b9LJuhshbyVBZavA2Q0Ss+6dvp4/nD7T2pCi79O0xMS4keHWH7JOjR/s=
Received: from MWHPR04CA0030.namprd04.prod.outlook.com (2603:10b6:300:ee::16)
 by DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Thu, 18 Jun
 2020 19:49:39 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::42) by MWHPR04CA0030.outlook.office365.com
 (2603:10b6:300:ee::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend
 Transport; Thu, 18 Jun 2020 19:49:39 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 19:49:39 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 18 Jun
 2020 14:49:37 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 18 Jun 2020 14:49:37 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amd/display: fix compilation error on allmodconfig
Date: Thu, 18 Jun 2020 15:49:36 -0400
Message-ID: <20200618194936.9158-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618194936.9158-1-qingqing.zhuo@amd.com>
References: <20200618194936.9158-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966005)(70586007)(70206006)(86362001)(81166007)(5660300002)(44832011)(2616005)(4326008)(6916009)(336012)(36756003)(356005)(426003)(82740400003)(478600001)(82310400002)(47076004)(2906002)(186003)(26005)(316002)(8676002)(8936002)(1076003)(83380400001)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9917fa1-b52e-4093-de50-08d813c0bccc
X-MS-TrafficTypeDiagnostic: DM5PR12MB2376:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2376042FDF137D12C3F7C6CDFB9B0@DM5PR12MB2376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGQrFAe6ZpoyYwe43E6Rs7sbQb9sw/CUjRPIP9W2jjes9yskcZDMojhEt50dqRdGaSUVeRAQWSwB96PnYPofYbFzG2w4ymls0iQ7AOY1CfgD6BIr4dEoWzNxowaesGfd8GJAVi+bq/xmIsJ6t62xxPPpJYV2wvSoVg7m9UUW3BkTTtQvgOk9RfM2kSsV0puJ0hbM7TG1LJBpbVl0v3GJ154lOyn8hkUWQ8Dy4CUtU00TAtMgJ+tRhq2Gq+UqU+MDwF3jpFgxuxEndnLts/jOpVtpbYctdGncfWeOaTHjl7TyVQQlGJP5nvUgguRyhcuvCJC9gqTODmoD+ADEG6lvygXbmGZz6watvxbVaysi1vYHtcqm1MLGTpRqK0KlWrvPWUuMYj0GRpi0rdDPugCcxg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 19:49:39.3497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9917fa1-b52e-4093-de50-08d813c0bccc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2376
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
Cc: Lewis.Huang@amd.com, Aric.Cyr@amd.com, sfr@canb.auug.org.au,
 Harry.Wentland@amd.com, Harry
 Wentland <hwentlan@amd.com>, Alexander.Deucher@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas.Kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

when compiled with allmodconfig option, there are error
messages as below:

ERROR: modpost:
"mod_color_is_table_init"
[drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost:
"mod_color_get_table"
[drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost:
"mod_color_set_table_init_state"
[drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

To fix the issue, this commits removes
CONFIG_DRM_AMD_DC_DCN guard in color/makefile.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
CC: Lewis Huang <Lewis.Huang@amd.com>
CC: Aric Cyr <Aric.Cyr@amd.com>
CC: Alexander Deucher <Alexander.Deucher@amd.com>
CC: Harry Wentland <hwentlan@amd.com>
CC: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
CC: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/display/modules/color/Makefile | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/Makefile b/drivers/gpu/drm/amd/display/modules/color/Makefile
index 3ee7f27ff93b..e66c19a840c2 100644
--- a/drivers/gpu/drm/amd/display/modules/color/Makefile
+++ b/drivers/gpu/drm/amd/display/modules/color/Makefile
@@ -23,11 +23,7 @@
 # Makefile for the color sub-module of DAL.
 #
 
-MOD_COLOR = color_gamma.o
-
-ifdef CONFIG_DRM_AMD_DC_DCN
-MOD_COLOR += color_table.o
-endif
+MOD_COLOR = color_gamma.o color_table.o
 
 AMD_DAL_MOD_COLOR = $(addprefix $(AMDDALPATH)/modules/color/,$(MOD_COLOR))
 #$(info ************  DAL COLOR MODULE MAKEFILE ************)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
