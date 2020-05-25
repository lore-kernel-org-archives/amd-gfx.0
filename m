Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B431C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183762071C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="17jxUfpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183762071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D852B6E113;
	Mon, 25 May 2020 18:13:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E27D6E10B
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:13:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwzmeEcBjR5WVWBX8+/xctB3E9Z8KJ4g7I6WlVVhtAexam+VbK0OUNPbQjpwzfTKFse60TTQrumWPM7W5spqdaaGkmBMFJGZgNi+VmtaN9NxLNQVsQXOZ2IgH/ZLGB94FLQLMZbigr71MenBu1tNB7zXh3NQkJNUbgOO706SJS+bUcf7DFw5gNXvriANaH6b+7o5Zh10U0/IMIXYOWe47BaoVweXZ1M85gVuyrCpqGgBxDrKGP0O/PkRzLC1LBobDfkaJW9wx6BHJvNYp2RguaQL18mhONNbOFf3Q71V9jvUo5E1qljy5VQVd/n/ar+1HwykO35nRJHgWoVg9qSTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBD1G5ZZ0q3cNd8nD4024mQbtxAkAPGxwrhZg6YCo2g=;
 b=W56+xZMy91SgBMiMQaF0tfZgwkJXGP9JJA2irDGZpTyc1JsRypPDMVyuSMPB7PgHbVJ0TmVbqx4+8lvC15rNSlURTq2CdJrFz6pxZQ15Uun0wIxYgSdnOJCD3RSJ7PpJBIMWXNUGH70bGE6RmDst2pHh9LKp+qvLc9sP/v9QKqx1MMimNoNu01FHqdd6leOdmdSVdKDk91KPy1MIJPOwkDcpB/OKqhjg38d3EqIY5yieQw5jgVuN5w+jbm2cXqiqO6HF+apjr3Vu6O6uKPkzaHMZRzBLQI0w7+TT7XcvyeL6Hgyb8T0trLkF7t7S7QbUnVkQ7r1M5w7HWMnwN+Lv0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBD1G5ZZ0q3cNd8nD4024mQbtxAkAPGxwrhZg6YCo2g=;
 b=17jxUfpYGNxotrVE19JP8zjVXHBi+AKqFX3nRWlHVRq86uF987FFKGwBZzWTg/svSalE5Af9pUgr+03k2FcqBlY9WH5m49liLeLo00y60KDYlWVSiwKrpFpTBGW+zHtCgHS8u8/oLHjjmKPJhjO7Lv4frSA0g4mq6xiStJsckGc=
Received: from MWHPR21CA0052.namprd21.prod.outlook.com (2603:10b6:300:db::14)
 by MW3PR12MB4539.namprd12.prod.outlook.com (2603:10b6:303:59::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Mon, 25 May
 2020 18:13:20 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::2f) by MWHPR21CA0052.outlook.office365.com
 (2603:10b6:300:db::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.2 via Frontend
 Transport; Mon, 25 May 2020 18:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 18:13:19 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:16 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 May 2020 13:13:16 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/16] drm/amd/display: Don't compare same stream for
 synchronized vblank
Date: Mon, 25 May 2020 14:13:05 -0400
Message-ID: <20200525181306.3749-16-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525181306.3749-1-qingqing.zhuo@amd.com>
References: <20200525181306.3749-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(46966005)(2616005)(336012)(54906003)(478600001)(426003)(186003)(8676002)(5660300002)(1076003)(44832011)(8936002)(316002)(6666004)(82740400003)(47076004)(2906002)(36756003)(26005)(81166007)(356005)(82310400002)(86362001)(6916009)(4326008)(70206006)(70586007);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e3078af-9dc8-4454-558f-08d800d74e1f
X-MS-TrafficTypeDiagnostic: MW3PR12MB4539:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB453932D39AC95010A3B9BD5EFBB30@MW3PR12MB4539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dCsi7gCm2iBNT4H8C1YDaZOSJdGp/DA2iJgP3tUVIl3M5xBXinE02arlQJ9DjsmficdIAzRqLdduNdecPH3Z7OHZciIiODuGkRNp6NrC+3mboNcktpShCIZLkxK3f5vQA+oaFXeraZkVCEpYyzwZBuut2XwwirXEMDzmXdAQC4wF9kLB2eGaZDqcp+BE4MCB/XOSrudU3h0jamXi2u2D4cYhvporgaCQqgBlzffVbDJ2kRU5qdD82ypOV87QeejPQtVNi0tbsZury6dTjLQPYZt0yz4GCIIrgjJcSjeOHfDQCfWzSRoEkl5YiOB1KPDky3UOz9lVU0M0bb7YUieI+S4weJq/2DK926Vd7yZhXTPMOGaRGjdfqVEhYdfBQ7taf9qx2NAc98osN2OwFQBesA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 18:13:19.9981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3078af-9dc8-4454-558f-08d800d74e1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4539
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
When determining synchronzied vblank we don't need to compare the stream
with itself

[How]
If comparing same stream, continue to next iteration

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 4ffdbcbcdfd4..8bf7c5bc946c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2015,6 +2015,10 @@ int dcn20_populate_dml_pipes_from_context(
 			pipe_cnt = i;
 			continue;
 		}
+
+		if (res_ctx->pipe_ctx[pipe_cnt].stream == res_ctx->pipe_ctx[i].stream)
+			continue;
+
 		if (dc->debug.disable_timing_sync || !resource_are_streams_timing_synchronizable(
 				res_ctx->pipe_ctx[pipe_cnt].stream,
 				res_ctx->pipe_ctx[i].stream)) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
