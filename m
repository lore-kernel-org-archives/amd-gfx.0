Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32117C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B352067C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QWnWNmOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B352067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C22CD6EC22;
	Fri, 21 Aug 2020 22:58:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21A506EC22
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 22:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0MRTDPcRi2ZlV6S7jMHfJHTDrzZcn4Rm1Oz5zm8aGI5yw9sG96UoaOvTSdWcg0bl5ClZl/kqURl3ZZ+F5BM8faQH3qlnqJf4ji98MVhbB+DDqqIXn1xRcC/1vq47vTIEqElCdpisPpYdBeWgdPb7xbQtEZTQMahANp86tUFns/MXxYmwz22h1RPuozRxImxaWK0AjD/eDBGTVCSPig6KUejsZLj+mmYWaOxbexgmea3yIeumFazlyK+UeJmKjSg7qf/At0kEcOWgbHfnn0s5SM8OiOCpteljkDh/LMcjtsNJUkUJAUsTdMwz3Cg5Ee8BIVvRPpBIPWvJCZmmg9m3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lc+nttfKHNaqi5OiZKRS8AxBmNszdywa7wL23m90cCM=;
 b=VMDfzHPYJjkMU9J5VTftPqG9eY61USY0NFvpdHwT8yXMECTzMpX6tVUK64ZVnccQsT+/r0qRcoY+h/sQVi9djxfWq9QCrJbIWtdBKvAfoS1m5KDHrTXcnIoBmoHlk64PA2uIhFU5cndrMu2aSSk1j0LjkB9YsD+ipeqd01xyYCKEao/KAQ5NTBtXmGDR5ACBp7yLq9P4pDjZB8UJezP2a6HtX2yrTeq6ZSX0ULT35aqtw71gxYoJvxnATvFIOIa+JNBGhjtRkilHGHFXrs2OR7ZL/1/4hMeDdgVhhebBo35NWLJzEq+sKBFYxsyek8ODuBDAF73BEuSGGvXh0ZpU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lc+nttfKHNaqi5OiZKRS8AxBmNszdywa7wL23m90cCM=;
 b=QWnWNmOyk5xoe4EA8ERhqpISXKMOiWmR2vFlI1nsHiuz3bvdatBG4kNSQjiUlmBbbNw2B7ePOMjwiUtH0MEnbqz8Y/EcviardFIqAkI+PX6tGOtlPlUjEcXhor6uU1ouA2gJDKz+Vb6XJpRPSjuLwFoNJ7Ci5rfUpc+IzjXItlo=
Received: from DM5PR21CA0026.namprd21.prod.outlook.com (2603:10b6:3:ed::12) by
 SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Fri, 21 Aug 2020 22:58:07 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::80) by DM5PR21CA0026.outlook.office365.com
 (2603:10b6:3:ed::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.3 via Frontend
 Transport; Fri, 21 Aug 2020 22:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 22:58:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 17:58:06 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 17:58:06 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 21 Aug 2020 17:58:00 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/9] drm/amd/display: Revert HDCP disable sequence change
Date: Fri, 21 Aug 2020 18:57:04 -0400
Message-ID: <20200821225709.136571-5-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821225709.136571-1-eryk.brol@amd.com>
References: <20200821225709.136571-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 926dae59-8959-415d-c5ed-08d84625ab59
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:
X-Microsoft-Antispam-PRVS: <SA0PR12MB44470E6E8A3FCA9D3F252A87E55B0@SA0PR12MB4447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MIXg3pFGCor058VzbBfXwPjDb8tVhXNGJpHvRuMEkRaodmSi1Jhfwq3bEkrQ62qOonJDHILwUS6CrVbYqBIiac5auze4VZMGTZp4vbIOIUptWHh9/eHxjzbrATySs+e44YTL5E8o0aDMo/Dz+agjyh0vVrtlfY8nZdMPB5X436IjajMHCTQFpTwdOmvqoNOtWtlbuuJI3efREPJOZihIK4VG1vSPEgdg7nn53vf+v75Nh0RyJkrlaXDnQH8hWcBHM6NzOrh0yOOCxRqaH9R5g4+wkOS2fWCiKbfAxt5hnWCvUfK4x547g6huwhEgwRm1gzTReSrlL6l1JVhTblUV9z+pb0K7aCUkBnocqi3Xe+y4p3GPfNgBnMHwBQE13RLnlNnWVKsu2hK6PQYUiY7Bqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966005)(86362001)(478600001)(316002)(336012)(36756003)(186003)(26005)(44832011)(2616005)(1076003)(54906003)(81166007)(6916009)(4326008)(5660300002)(70206006)(82310400002)(82740400003)(83380400001)(8936002)(8676002)(2906002)(70586007)(356005)(426003)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:58:07.4617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 926dae59-8959-415d-c5ed-08d84625ab59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
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
Cc: Eryk Brol <eryk.brol@amd.com>, Jaehyun Chung <jaehyun.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jaehyun Chung <jaehyun.chung@amd.com>

[Why]
Revert HDCP disable sequence change that blanks stream before
disabling HDCP. PSP and HW teams are currently investigating the
root cause of why HDCP cannot be disabled before stream blank,
which is expected to work without issues.

Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 117d8aaf2a9b..405452b736e1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3286,10 +3286,10 @@ void core_link_disable_stream(struct pipe_ctx *pipe_ctx)
 		core_link_set_avmute(pipe_ctx, true);
 	}
 
-	dc->hwss.blank_stream(pipe_ctx);
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
 	update_psp_stream_config(pipe_ctx, true);
 #endif
+	dc->hwss.blank_stream(pipe_ctx);
 
 	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 		deallocate_mst_payload(pipe_ctx);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
