Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB2DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 21:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4882910E3F6;
	Tue, 12 Apr 2022 21:03:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33A4010E82B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 21:03:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSAij7duevChk5AVQfRH4Vg8CAFx4KzV3jIKlDYur4KXuxuwHvwPWzTmOJ9y0gn26nDdIS9iaefirlOnVd3GwFJ8Lh+hN9oUXYLdD7Kuq3ShZJdhbFOC2CI28hZGIrzOz0t6ACVrRAbp3zO96pbYqhTlpd4jntVfExfa9dGz+GrwnBcD8udCaC4ynpozJcj6XSv1OI7mdivQruGQVl/LynhZyS3OHsVDODXoklwGJmxGpI/+hxCQcjSDuSlnQtcxtqw1FvhzUpdJC8w7+7CCYn1HSuAXpLQBEUoODu66cg6opDXAxZV0MHtynCc5+8g87qk05xHLPdOiVXsQhjfd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9DWNpPiLVumac6hCgyNB0hRj8FnN2SS+gutmZysY24=;
 b=DyY6VTGUs0ZslrJnCAqek0iUukNR3ELIHzySfLviOC0+MSSJ2/D32LJg8GJnoXO7ZpyNo1x6syUzr/HNW4rxE9T9+78bq9TqB6nsqthVYlQfqkR+h5rPYeRRdSsTvG3nHL5eRZ+4qbYmnAoTrHwwT8P4BVROwBHv336w98wyA96OjFfdbVjo43b3HSB7d6sJFNUhFdk1iRCrUBBGrsnbFC06Ubb355xhtsEBZ3VJ3kq5+Qtqs0qRaR8cIaDghiDZx+g9Zq0WlRFlqLsn6HZsP5/hjcQ8ISMHTkpHVzkxAVAlgqFbdrMiXoTTaq+svCE1RkAIfH/i/sL+W4Sr2CEF9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9DWNpPiLVumac6hCgyNB0hRj8FnN2SS+gutmZysY24=;
 b=yoVbKu2O44zvUqhJl2z3s1C9HDvLg6b8C/VgCm4HgJSY7vjKfGKS44jQpZmsDde5VxIV8QyqV76y292XmaVFqqfyF75fxuINT/19aeMrqjqSFkr3/LbrmyQXOVf9oU+6lFlQpLafj6tP7EHrP2Tt4/8/uT3Y5fIAO5+VCxhXqrI=
Received: from DM6PR07CA0131.namprd07.prod.outlook.com (2603:10b6:5:330::19)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 21:03:41 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::c7) by DM6PR07CA0131.outlook.office365.com
 (2603:10b6:5:330::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Tue, 12 Apr 2022 21:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Tue, 12 Apr 2022 21:03:40 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 16:03:39 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] Revert "drm/amd/display: Pass HostVM enable flag into
 DCN3.1 DML"
Date: Tue, 12 Apr 2022 17:03:17 -0400
Message-ID: <20220412210317.638308-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 941c14ab-3c3b-4223-42a2-08da1cc7ebfc
X-MS-TrafficTypeDiagnostic: MW3PR12MB4476:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4476E7F2AFAE99C26394CAF698ED9@MW3PR12MB4476.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3OEx70JEVZjnLGPj0hq0x9N7yX65RlAUkcNeNoe7YU74RgT412kDr7WwpQwvmwY9kof2gpE/NAscZMMBtXU/6imeKID+apieg4Ho29gTR5/5UDt6msrDKxARdtnT2Rd7pnvVtmaEpXVZgEX9LsmUKKmCObReWq70QgKWS2DIcxDvEF990SLo7RgNiTDtqdT9X9+KZ39MByG0w18jExOmOjLBzHAdmAiR4+JLabkWToh/fxh17hDt0FdK4QuTL5ADxm2hNHe6Bn+u4AfylaBFFivKcqDnW1tMv3hv5p21c7T5sPNODBYfPTKO3psRPq2XdvheALcHRPMGLjv4SUrHZUKPAoOt/ymD55C32Xx0s8Yp6396hg1YIP3J7y3OFExssxyr3W3UpNvB327EcTFVb0V5A8U6v7F68tPZYSlptn1Kg647yLLBApv6Dk5bq4TPep6oBvdsw7lF03FpnZOQsC1BRsUyVAvpSMVKvXw/G+yzxVf1DDWY613qDlH/V6KQPOaGKPoA8/HTtJOC0/pwTnIDIMRvRRSwL2Z5mHPDqRDYenq/kFViNK+iwyQA8xz9ShXgeomFEi+WYSNSaUF2apc8ewVjWLKe5JTv4sCbDljxzjpWl56dLlcnP8if5ZFifaoPY6bhmlWrlLpFem4osfYulpjbxfEq4z2hhhS1+QtBn2gnKQrG4ZAtHkNIePEhtFZHLs8ck6ycJeZQjMqhRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70586007)(316002)(86362001)(54906003)(426003)(83380400001)(508600001)(81166007)(6916009)(6666004)(356005)(7696005)(2616005)(4326008)(1076003)(8676002)(70206006)(8936002)(36756003)(2906002)(40460700003)(36860700001)(5660300002)(82310400005)(26005)(47076005)(16526019)(186003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 21:03:40.8500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 941c14ab-3c3b-4223-42a2-08da1cc7ebfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
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
Cc: pmenzel@molgen.mpg.de, Mark
 Broadworth <Mark.Broadworth@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Michael Strauss <michael.strauss@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 367b3e934f578f6c0d5d8ca5987dc6ac4cd6831d.

While we were testing DCN3.1 with a hub, we noticed that only one of 2
connected displays lights up when using some specific display
resolution. In summary, this was the setup:

1. Displays:
 * Sharp LQ156M1JW26 (eDP): 1080@240
 * BENQ SW320 (DP): 4k@60
 * BENQ EX3203R (DP): 4k@60
2. Hub: Club3D CSV-7300
3. ASIC: DCN3.1

After bisecting this issue, we figured out the commit mentioned above
introduced this issue. We are investigating why this patch introduced
this regression, but we need to revert it for now.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Mark Broadworth <Mark.Broadworth@amd.com>
Cc: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 6cc580be7c79..5b3f0c2dfb55 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1668,7 +1668,6 @@ int dcn31_populate_dml_pipes_from_context(
 		pipes[pipe_cnt].pipe.src.immediate_flip = true;
 
 		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
-		pipes[pipe_cnt].pipe.src.hostvm = dc->res_pool->hubbub->riommu_active;
 		pipes[pipe_cnt].pipe.src.gpuvm = true;
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
-- 
2.25.1

