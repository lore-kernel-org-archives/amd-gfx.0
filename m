Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F17C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 08:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349F46054E
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 08:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 349F46054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CED089B67;
	Mon, 25 Oct 2021 08:56:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 337E989B67
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 08:56:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUOMw7xjyZXcWDuaWDoaFAy+noODouUUIIzhXhTq8s0xkZlqxQNdndWBqucg+I/2R9oHI+48IcVNCOxBvwN37r9q0kXIVhq4oLOAzzmhJoGVNQDoodqEyHm8fQISAYB0yMWV3/InlnAziwTlEIb5iUwJKKDL8qc6uPP1HWikA4ulfdNRlJ6/0cR3PSPXo2TGCUl6iNFGi5PbyuDC9BhYqKhYkQgNZpp5P+Ux4m+b+0Fi3C8RjTMT68Ym4I4R4SBvJgVTLbLcTlwPrXQmqqLeYsLX6jmgD8lTCV/8ab3REFyGb892z18UgyNB0u7Yll45heOG+QfTRogjeRDki9j8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bx7wCZgYtwTWbGR6hm2ux/7W+ceW6/dqiw2wePR4l5w=;
 b=e8RDQRiaWGRGGcSRL+nxjE9kwxM2oDPXHVByc73aGhIV3bKIeJshyBFxwTDmH8X9FX8TRGEf/MaQ43T3zzfWO/xN8tuJUI72oo20GIG8q6WTmYLCPk/VZJzTa6RAipgY7TDxxlFiLls0e3yax7FrDlYp5W+8+5WrR/Fz2R5LS/rqterYTxHrTr4F0XOn5qE/AnkG/phqdwsPiBpCyxnKV1BU2C7mmqlADBd7iMP1fPgR2gg+yOWFSpclf+2hg4bZBrPmnGrPtAI9yDOindc/jFXYLWnhzeX0OLSJqDFnR5mgRxv7y6bjYuRITyMzoSLIcE/ZDFCtNxSN6Ai5JZaVXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bx7wCZgYtwTWbGR6hm2ux/7W+ceW6/dqiw2wePR4l5w=;
 b=ah4/A6FP3N3HGgTKVYJQYJmoiiKiugTycr9wbVLOqiXL1KHX4WHhi1Fzf0q+sZcqzwd5uOnpU2K5LtQGIpZDn1AcOHqMOZZPXoNcUAFsR6kdEYjit9KLm0tDU+M5blOvpzXThspF8ByuIk9KaNEMdxq77RZmyvO5qlaO8AlYTfE=
Received: from MW4PR03CA0351.namprd03.prod.outlook.com (2603:10b6:303:dc::26)
 by MN2PR12MB3936.namprd12.prod.outlook.com (2603:10b6:208:16a::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 08:56:03 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::f6) by MW4PR03CA0351.outlook.office365.com
 (2603:10b6:303:dc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 08:56:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 08:56:03 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 03:55:59 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: skip GPRs init for some CU settings on ALDEBARAN
Date: Mon, 25 Oct 2021 16:55:50 +0800
Message-ID: <20211025085550.5846-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94165392-1131-4c74-2508-08d997954641
X-MS-TrafficTypeDiagnostic: MN2PR12MB3936:
X-Microsoft-Antispam-PRVS: <MN2PR12MB39361442D0FB0448B953D6C1B0839@MN2PR12MB3936.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z10hMn5/Dx56k/xG0iAtsBgJmyw5tk6VQZB8mtzHjTTzAMjEx+sl+gyTMTJR3iqRYLqBhK8mkYWSfShfbmeZLVdOmRvNqMK8NDV0On1YQhNLi9ppDADCwqAL8AbeuGXasa34RNdJXk8aN3iPE2yb4JtZkaYBGLX/CjtcE75MmtwGNI3lBI83ItKxgiaoQJwUK5yeDtVZX024EiwhlfVZJ/KjNPfW2BAX+LTtWTzF3m/VgHAMbKzv6NeLT93f+INznmR0v8sQ+n3uO11cMGMW/c4nJ5KVPzPtk+XcxZXy8uN8ioj/ll2qzcl6avC5/JaGALh6uu1eUHll2YFPc+N/oCngiBPp7NCF0FWPVvGqS5ZXp58iRcynBUWABmm5dlJ9QqEzmstDF/D1jws3cMCJVwNRM7oOzAJFDBu9gg+ihHlgoC44KTr9DTsotBd9S882cfV3L99l+pOIe5ZH9bWqon3yIxZg0fcyRz/5Dd0iqtVF3jJ9eF92IZIl7hiohjYDq//TBaIwPPOIbtipvyGgyXTvyuSJHWRHFJ5lIIr5mE/DPVG9mSlv6Q/Zy4u3MeY5KtLKKzT0rubZ+vuZIYvIe91LO2scPY2CeIsHnkxa22m96jUKKbgl7EHiNBIFiPMWtP4jhYn+BSOeNw7clhD9VXy9sAwUvL+psjmeOwy8WOJDynVgz6dsAVMTxvvCp31EeoqOWMKH6Mg+BoJDJ43/GyuIrkTFXfUWwfFoKGjccEQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(83380400001)(426003)(4744005)(336012)(86362001)(356005)(6666004)(5660300002)(186003)(2906002)(2616005)(1076003)(36756003)(26005)(70206006)(70586007)(8936002)(81166007)(8676002)(82310400003)(36860700001)(508600001)(7696005)(110136005)(4326008)(6636002)(47076005)(16526019)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 08:56:03.2672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94165392-1131-4c74-2508-08d997954641
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3936
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

Skip GPRs init in specific condition since current GPRs init algorithm only works for some CU settings.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 00a2b36a24b3..a1f424e2ff5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -706,6 +706,10 @@ int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return 0;
 
+	/* workaround for some CU settings, skip GPRs init */
+	if (adev->gfx.cu_info.bitmap[1][1] == 0x3f7f)
+		return 0;
+
 	gfx_v9_4_2_do_sgprs_init(adev);
 
 	gfx_v9_4_2_do_vgprs_init(adev);
-- 
2.17.1

