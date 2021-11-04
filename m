Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6E7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 09:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF8D6109F
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 09:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1EF8D6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 888EC6EDC3;
	Thu,  4 Nov 2021 09:40:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114F66EDC3
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 09:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vw83O96zc2jBo+yctAtmpJGi1YUKfpi0En52Wt3IvtRwhCHv+nHwoYBGU8K7iCJtD/zKtRyTXON2wcSqHKKgVbLSKGItVINScsuNWch+Rj/ZtN2hDQBtUsXBqlMwuB/14cklFRO+7MTNHE2JbHszZ36wtzQTy1sqTssq7sRm8Q7wgXejVhN4iFAMaADecetCtyJivFxxoP+XSMRBND6zNJY3xJpZUWsTiOFVypP3V/EqDIb3M2v1dY3dumHsig6HKe6aDBxNOGGjDHfJkxB/jQpbficvsuVBQ+y3cf9YSBD1vyrPsRo1flSGQY+LPLLzcW9OPC+X9TGZ6TclzYpV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3OtJcRPNWmO9/BeOXTpfbqkPoI/uMny+WEyLztrP64=;
 b=JhXtFBx39chLKmz4GGfQt4tD42uOMcKNe51gGbqmhoWuo0NlLclOX6yXVqWHRKrtZBptGxYHptkbvTI9pBWE55BtbfB3bZ48pEAxM0hNkuBL2gbLGzCmB7HI3sDDjghndyYvn8IaS1xf1UmL2ROqPYEyU8upsawkHPAYaK4JYJKhmUaCEU8fRKpc9t9jmUrznL6Mju2MNUA/MOg5Plg44yWTSdS4ZAmj83/FmeV0Y3gpLSXSYIE3BE1jMXv8ZD8LJxzznvZnC2ia4XkQGZhtGvTMTkzWgc2brXPsQ8k8SdStHgUR1Xo8mRaLTtRsdiaDvAgt+5EL2LEY3bFC91Q6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3OtJcRPNWmO9/BeOXTpfbqkPoI/uMny+WEyLztrP64=;
 b=wu6wIFTWYo17LHN0qSPFmvHKQ4jJLrGM/dCGLcDKYpWQHGS1mWr7t+OD1z+9ed6GHyJrsdKXtNTIM080+T4rbmt1vnCLhYBHcypQcueC8uucLiU0ZZIql4LiMHFWmUIMYoPGbaKflgYcCMWiMMrvhgvUVB3gtNKrE0/jmcjifeM=
Received: from MW4PR03CA0045.namprd03.prod.outlook.com (2603:10b6:303:8e::20)
 by DM6PR12MB4944.namprd12.prod.outlook.com (2603:10b6:5:1ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 09:40:49 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::cc) by MW4PR03CA0045.outlook.office365.com
 (2603:10b6:303:8e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 09:40:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 09:40:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 04:40:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 04:40:46 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15
 via Frontend Transport; Thu, 4 Nov 2021 04:40:43 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Fix csb.bo pin_count leak on gfx 9
Date: Thu, 4 Nov 2021 17:40:21 +0800
Message-ID: <20211104094021.1311552-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4524d8e0-aacd-46c3-d0dd-08d99f772ee5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4944:
X-Microsoft-Antispam-PRVS: <DM6PR12MB49442FDCBBA452EC0FFDCA9DE58D9@DM6PR12MB4944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v0FpOUVtqKm6pzz89E7C/X91CVvCzg3PtjsNouqPEk5mJbdFAVCHghbezfgUPg2K2HYG+GBoJj9IJtTLVofG+Xlc89gPsYeSLuBa71k9qOAAteIvIbCrx0P96ILxGSLcBuv6/irKqCEBIlbR8EKP+3eT+jLh1KqGkWRNGXTeKzx1Vc4vTIH+XnT1d1Adyy52aDGM2gJnbL7zUAMyF5kCJ40+3uO2xHIptEUb3OtZNxfgWy0yVLwv0QMa64Mpj1D26Vfy4aPo4gKrcC4bXeRlj+45/oGQP6p6seFZ3tK5H6Tq6PS+Gifku9Jg6gGDeOoBSkzhQ6iX2Afpy/PPXqZ/lhp06m3PU+He8I7SO1+soMEkDPNETzEFDbqeIXNTWE0CeWX4nvRoSsiioNxBwrGaoZXv5vdtm7MD+ypWzBjyLT2xu9z9hGthYANnpnBeADRQfXSri5mAvXflsTU2Ig9ptLuv2eJAbh60neUYN+IS8Pb4Aq8+v/pWaOJaVtVLbENDBt4qotlyQA8oKePcQ7LEYA9V6OmmoMZA+skAVn8Jn40khcR+TqDd7N7SrfHdIU3998wDEidXqkvvb7YMXlLyQsSure1Mb6G7Z41IPcMZiB/y+rFITXY3E0hNZRAXN2JD7y38ZmgeKj93Q+k5DFEx6xvlpgvGpujAAWbpGP6QY8HDRE0RbRbBU5qUNlU5ilaGlw3SkazIkJHQ/fpNDgtHpyLKSdE1p9tpYM3Wf6qHdpc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(81166007)(426003)(508600001)(36860700001)(6916009)(336012)(86362001)(5660300002)(83380400001)(8936002)(8676002)(2616005)(54906003)(4326008)(26005)(36756003)(7696005)(70586007)(70206006)(186003)(47076005)(2906002)(316002)(6666004)(1076003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 09:40:48.4754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4524d8e0-aacd-46c3-d0dd-08d99f772ee5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4944
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
csb bo is not unpinned in gfx 9. It will lead to pin_count leak on
driver unload.

[How]
Call bo_free_kernel corresponding to bo_create_kernel in
gfx_rlc_init_csb. This will also unify the code path with other gfx
versions.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7f944bb11298..be803ebd543c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2462,7 +2462,9 @@ static int gfx_v9_0_sw_fini(void *handle)
 	amdgpu_gfx_kiq_fini(adev);
 
 	gfx_v9_0_mec_fini(adev);
-	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
+	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
+				&adev->gfx.rlc.clear_state_gpu_addr,
+				(void **)&adev->gfx.rlc.cs_ptr);
 	if (adev->flags & AMD_IS_APU) {
 		amdgpu_bo_free_kernel(&adev->gfx.rlc.cp_table_obj,
 				&adev->gfx.rlc.cp_table_gpu_addr,
-- 
2.25.1

