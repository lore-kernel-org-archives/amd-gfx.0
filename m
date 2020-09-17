Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71B3C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 09:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2652076D
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 09:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tSN8ZpaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2652076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A686EB1C;
	Thu, 17 Sep 2020 09:17:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 800366EB1C
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 09:17:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0ipvxXe1/exw/Dx3fniGLtzUYL/4P7YPbnV8FW5SYQx13lgKfWVYNVadjLmTADNNUB7d86WT2CmpVWg9pqUXhQQDqhZgA/uhB3QuYufJc/3+Hw74wTsgu0ZacMU3IZmKk19tGatZkAEd1MDrc4CfdksLpSi2Z19KrlKwvn8uEClVVP1HNL7v3R1CLd8vTVpYQWcBN1Alnh4a58X69e/7M5O61tKbY/3y4JXSTUQzU3vxonfkPWEPKJaTIhE3IjiFPaR+vpTvEoEGY8JgUGBrIu4TOTTYLw4F0PKGKVfwK0mnaJOczz6bCy00V40hkYllbGb4NTfR9pewGMHayeduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwtuuO3HBXNHMOHQmXWWrSKjuZDqkmHqJ5r9aTazos8=;
 b=eM6MpnxVwGc5n+Siq9hgJet3WP2QYEQRSWFFAToWKC5Bxz0ssjdrLlciN1GQ6qcpgp56YV7hGkNPNtFIkV6rnDzniWQetFoyB3RVBweN2/MxxTEskI251NZm9CBs6D3kRuWnwbib3lgrTwcyhMtuXsEcMjM8nOI3bVrS7PLmpYRH4NIedoVYbuht6VVWdkpCglyELMT62hGl7jYEqJlV/Crj3DJv7u8MNXe39dCK5aUtGo2t4C+SLg+/ZuWhfolRNJ6JLdDlI8Fwo0kE1FMQzSgwuE4b1HQ6u24/O4kziHMmOxwe1V2aAJEz2h01gt2slYK1pP73PLF2127Ywn6cQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwtuuO3HBXNHMOHQmXWWrSKjuZDqkmHqJ5r9aTazos8=;
 b=tSN8ZpaHMaQbFtEHz5swCiQtKSNL+MvjZZ3VJTfOAI54kMdVD6HCr+GCOLDk5Y7CFMFaPOtN6TWeuO5wzuxIBa/rnkvN2pyGr+pwVezbT3po1mOCEp8zigYo+7dQ8JxAOsFi80IbDXfxJha/neCAzWEf9vQ+SBiTYh2ZHOCao70=
Received: from BN6PR11CA0029.namprd11.prod.outlook.com (2603:10b6:404:4b::15)
 by DM6PR12MB3195.namprd12.prod.outlook.com (2603:10b6:5:183::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 09:17:16 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4b:cafe::b5) by BN6PR11CA0029.outlook.office365.com
 (2603:10b6:404:4b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Thu, 17 Sep 2020 09:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Thu, 17 Sep 2020 09:17:16 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 17 Sep
 2020 04:17:15 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 17 Sep 2020 04:17:15 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
Date: Thu, 17 Sep 2020 17:16:55 +0800
Message-ID: <20200917091654.1045366-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 156677f6-f9e6-4bbc-698e-08d85aea789c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3195:
X-Microsoft-Antispam-PRVS: <DM6PR12MB319556C3D097DD3E6F8C4D12B73E0@DM6PR12MB3195.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+9AU5C7UIxFzSP4Aj2GNHlVSLebPkTvjta42Wm0MkFhaApzsU1+bP46R2eGKJzBNdige+hwRNhm+UKVfizUYw10BlSMs3pr1rM6T+vNNDMnmM/4puHd4T3oZWHhgWigA9HZh+nPw1IBQgNxGkvwBy9CQ6rvwtk5JACveipz0HB/mMXm04w5XD8vuGQOjtWSluKtfa2CxoDq8Tv/Aiux8ZbQIkowxS5gMUZt4ROP/hSh7IkrbDrxPwh0xBKMI5izaLRkqFaXU87Jnbna6569WM94vPf7r+PhT40qeB0dfi8RAws10FKvop0N1tMczVLhy6YjM+qS+YQxH5VyZbp/pzaoUwJWTDh/fyCB1X4QRQCwyFIOobLcZvqoNj+mfmGBAp69nDeYSAo3r7JwvsYViw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966005)(478600001)(7696005)(70586007)(47076004)(70206006)(86362001)(5660300002)(316002)(2616005)(186003)(81166007)(4326008)(2906002)(336012)(36756003)(1076003)(426003)(4744005)(6916009)(6666004)(26005)(356005)(82740400003)(8676002)(8936002)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 09:17:16.4849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 156677f6-f9e6-4bbc-698e-08d85aea789c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3195
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

smu_post_init needs to enable SMU feature, while this require
virtualization off. Skip it since this feature is not used in SRIOV.

v2: move the check to the early stage of smu_post_init.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index a027c7fdad56..a950f009c794 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2631,6 +2631,9 @@ static int navi10_post_smu_init(struct smu_context *smu)
 	uint64_t feature_mask = 0;
 	int ret = 0;
 
+	if (!amdgpu_sriov_vf(adev))
+		return 0;
+
 	/* For Naiv1x, enable these features only after DAL initialization */
 	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
 		feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
