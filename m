Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69317C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 14:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3C661052
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 14:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D3C661052
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B21796E996;
	Tue, 12 Oct 2021 14:11:14 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E13A6E996
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 14:11:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1Erxq2BHmxJ3+sbtlUUpKLc/beW74sSsvQaALJmrCSd8C6awc0mRw4bh/cQ6kcAOUil82BODimYNzva4DoWJtX9KIlAtluYgFe8aVLZ9dRpUYmA39BfPg5D8UGm0dnshyZwbNTqcYJYCKmU+pThs1S856qiJpUkinrUntyg0d2w8NVgcwiLK84uj754LxwFrV174zH/2UU1WmiwKqC9KlqV/TQYooSMdMY0JPdslfWyKUNwAO6NFiii2Ul3YExEOxDRm6HrwTKMpO95hQRVHV/slzUhq+1EzbWJDvdziY+38Nknt+GZHVnMO3eb8TkSPMDI7wACigAzEfqxtywSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXV0XKwizDVeM5ex4dcCGHmSQvr17Q6CJuM91Jo6Zew=;
 b=M2w/nTg8zwmGsCc8hnrGvnc92QGhRtjQC7Itt3FSMUFsbP5cZJvjHTYleLxhT6t5BZWUgO2Wz/GnJvarAPoQ+XcJCuaq9INslT5BmKJuNOSWd2t6LY+aV/VWpo3yqQ3Ufhx030DWB9wp07lT/+9uj76IkMwDifdswN8bn6rLN4WnctIP209kGLSyyDgWW2CrevFjGvJW3AFnPH9bB/QaipIj9Pte9R5mZfVbZ8eY+6mXjqE67BoEJSDsT/nXqpwJmWRN4kqq7J9XIE9KKkqy5guc69C+XIuhzYkvyhrABN/e3fv+XUHFtZH6s1msvB0wr7ebf30fnf1vr9meCnF0FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXV0XKwizDVeM5ex4dcCGHmSQvr17Q6CJuM91Jo6Zew=;
 b=rx4lDENeR1AgFhIXV4Xd07prEcxTX9s90kX5iXXtG2w8AFMDEg+PnGOgtX8uIEJpIe52sJ6tfhCIHNUS6DdNCSPdsMMis9ucyC6ST53WJNGznK+u0DFn9LXFTo4Rj6Eo2cgtPm40E8Jc6azDjhY3O4FRdVaexZ0l3V7R9UR36Cs=
Received: from BN6PR12CA0040.namprd12.prod.outlook.com (2603:10b6:405:70::26)
 by DM6PR12MB5022.namprd12.prod.outlook.com (2603:10b6:5:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Tue, 12 Oct
 2021 14:11:11 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::d0) by BN6PR12CA0040.outlook.office365.com
 (2603:10b6:405:70::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Tue, 12 Oct 2021 14:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 14:11:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 09:11:10 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Tue, 12 Oct 2021 09:11:10 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Bhawanpreet Lakha
 <bhawanpreet.lakha@amd.com>, Mikita Lipski <mikita.lipski@amd.com>, "Tom St
 Denis" <tom.stdenis@amd.com>
Subject: [PATCH] drm/amd/display: Fix surface optimization regression on
 Carrizo
Date: Tue, 12 Oct 2021 10:11:02 -0400
Message-ID: <20211012141102.4590-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a1975ca-8c38-40ad-0ccd-08d98d8a24e6
X-MS-TrafficTypeDiagnostic: DM6PR12MB5022:
X-Microsoft-Antispam-PRVS: <DM6PR12MB50222D1059034C63C6EAECD7ECB69@DM6PR12MB5022.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evtVydurLR0VbOmTNHDBHcEM52F9/7IUIE1QDGFB17icoVDhwXi3diioFteJcX7g3PZSf8apx/7nB8YtDfIpafXzOWvqSwm0KnSzDx6BMsvo0oMVxYgpK0fxCpnxuddqh0KH8AlbWVcroya7bviTyBjrz4caSEwWrKTmCYfX4dnD0Nvv3qjyiCSaZKAGdIVmXgrblYOYnm9T6+UlEsaBQCviTs2hDcfCm+JKEY3tKcTJsdvudwqvyzX9q42vLd6a3iZgESgO1MXSu02RRjv9d68I9zmPJ3LV27Ky+ih57UKKmW9ilYXGmr+6tzrXs4UexSuxfWoF42qjjbcA1fx8Pq8tuIg45O/SX2gs1NfkPOzuLOJDVNdTfDxSisb22m5fVyzGMm1U7Xj9m2Q7X7Z3wO7Qu8hAJ1a0DzsV3AUyz1nj/mh/KM38/j8wbyEVctxiwINitV+w1zWJBh00lQFdPjymWDfhmxr7JDun92cNGq5rMpjmR94EgrWFIpem2UNTQwQJgE4jdguJUChgAdItLffi6z7WxDUizY7EIKF+zmVGqklqQF9hZOT4iHLB7qgP7NlH96IuwY6HLcA8L0vGbRZePdDBqkBXIZ9CvAc3AhFDyxbHx5b/brHLJ+FN/tsAsjEWpO+wcWpOYfYJcne9npXxlVKuGHT9IMwbnjyK+QeMt5xliikZJCBB+6ceu706DhGYwT36zs1VH6/X1iP0OYsuQvMdmcb+Y1YiofKr+dA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(44832011)(8676002)(508600001)(4326008)(2616005)(83380400001)(6666004)(47076005)(70206006)(336012)(70586007)(356005)(2906002)(36756003)(426003)(54906003)(36860700001)(82310400003)(1076003)(86362001)(5660300002)(8936002)(26005)(6916009)(316002)(186003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 14:11:11.3255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1975ca-8c38-40ad-0ccd-08d98d8a24e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5022
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

[Why]
DCE legacy optimization path isn't well tested under new DC optimization
flow which can result in underflow occuring when initializing X11 on
Carrizo.

[How]
Retain the legacy optimization flow for DCE and keep the new one for DCN
to satisfy optimizations being correctly applied for ASIC that can
support it.

Fixes: ab37c6527bb1 ("drm/amd/display: Optimize bandwidth on following fast update")
Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Cc: Mikita Lipski <mikita.lipski@amd.com>
Reported-by: Tom St Denis <tom.stdenis@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index da942e9f5142..f9876e429f26 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3118,8 +3118,13 @@ void dc_commit_updates_for_stream(struct dc *dc,
 			if (new_pipe->plane_state && new_pipe->plane_state != old_pipe->plane_state)
 				new_pipe->plane_state->force_full_update = true;
 		}
-	} else if (update_type == UPDATE_TYPE_FAST) {
-		/* Previous frame finished and HW is ready for optimization. */
+	} else if (update_type == UPDATE_TYPE_FAST && dc_ctx->dce_version >= DCE_VERSION_MAX) {
+		/*
+		 * Previous frame finished and HW is ready for optimization.
+		 *
+		 * Only relevant for DCN behavior where we can guarantee the optimization
+		 * is safe to apply - retain the legacy behavior for DCE.
+		 */
 		dc_post_update_surfaces_to_stream(dc);
 	}
 
@@ -3178,6 +3183,12 @@ void dc_commit_updates_for_stream(struct dc *dc,
 		}
 	}
 
+	/* Legacy optimization path for DCE. */
+	if (update_type >= UPDATE_TYPE_FULL && dc_ctx->dce_version < DCE_VERSION_MAX) {
+		dc_post_update_surfaces_to_stream(dc);
+		TRACE_DCE_CLOCK_STATE(&context->bw_ctx.bw.dce);
+	}
+
 	return;
 
 }
-- 
2.25.1

