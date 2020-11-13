Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D5CC63697
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55ADC2224A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nAvHNhz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55ADC2224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0DF76E83E;
	Fri, 13 Nov 2020 20:58:06 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F076E83C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHzyIBVNi+d8ja29t/bfD3lnoeaANN1TO7xKIvfl27QURIwptgfuTRZWCis3/4AM1GbelbMQ+VA/rpZYgA6y0cDq+YvOfsc78JoKuRgMOqVGJZGHTLJhHGGU9blddlM5E1kqh+tUhiIPH608VsZo84tvsf+Sh9HIKnLbyAWK3KKxkTMT7E7QecYfp/wMIpMWvmFEKT918hUXNerLAkji/0zBCHeUjaxOlnBvN2uPd2hF62PIlQNdHLcmbwVzp3yZ1Ou39FAk6KJoV5Ek7fiMk6hTN9GoxnnT8PNeJ1meeY+Sz5qQi2kzkLt1anzRwDPsT05rq1ijk9R9yb0h6vZy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qGiI6nnU+0R5vK3pdR+xs5Q6yIDZCulbc382/3kJo0=;
 b=f/mqA3Ce+AzMBAUvP1HsdZGZWjg8D/uCK77BsK0AET5dWwiJdd+mXwtdtGhqoTVJrq9Gab+DIQl64bCh+/jlpftDhw1lpggEIQ/OnSCH4NAYC67MXLbNOIZ5XJPC1Jjzfry3KynI+Dh4PIhShRczkflw//sugfeEB3DV1Bshyedy6Q7IuiK9V2M8ycvtTaXlMMXA7++vgq4bJk2/oOf1f+32Uf9Uz3OgsViunppTwF9Mn7naMq3G6yAxaeSZKxrSkRkkOooN69YpaWgQ4xzvJZObmo3CpnOQgSxQzE4Pl86Iu6bs+1Qfj18UYVB1ghgFQXjxho5SZJU5R7IXUf9Lbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qGiI6nnU+0R5vK3pdR+xs5Q6yIDZCulbc382/3kJo0=;
 b=nAvHNhz3gXdMreFnSVVtP37yIXDKI+exqFRCeF7Yi6ggLTrNoOCV7cU2iWzAn+IcAK5uoKhyZclwTDSmrZyLsCRysMhGLGPez8S37SVEePyKwczahPWt7AYonHANTNjebeXdUuyNdMdfSQD2KsBX/loTwFYVrPRWJ6t02Xb4XVo=
Received: from MWHPR02CA0023.namprd02.prod.outlook.com (2603:10b6:300:4b::33)
 by DM5PR12MB1722.namprd12.prod.outlook.com (2603:10b6:3:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 20:58:02 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::65) by MWHPR02CA0023.outlook.office365.com
 (2603:10b6:300:4b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 20:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:58:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:01 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:00 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 13 Nov 2020 14:57:59 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/17] drm/amd/display: minor restructuring of pbn calculation
 functions
Date: Fri, 13 Nov 2020 15:56:35 -0500
Message-ID: <20201113205645.640981-8-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113205645.640981-1-bindu.r@amd.com>
References: <20201113205645.640981-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8ccfab9-6cb1-4c83-7c37-08d88816cf4f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1722:
X-Microsoft-Antispam-PRVS: <DM5PR12MB17229CF75B283949E6B72D90F5E60@DM5PR12MB1722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGfcFNeQlA8DnRRS64WxhTVTQs8K3CTDgCybZUP2Q04xlOA5LijoLW9tmf7PvBjWuZ5aB/BGI7YjHqlXoqSQ7Sh3cBXaeHxQQLmYGGGW3tz60mLRpOLy7Ecwya4jm6yahV2CRF1muzlQ0uMT6huYcdCHTa1jD5+9V9Ir9QEGo/q8//WOgc7VPbt1gV7XsHLAVn2VCLxeJm0uPZip5K5v14xp1qZPcSnWn7ZHgY9qUHlaprlNm99iUMYpYolj29lIJXrtuFlF4f76vedvxnbc7AUTMljo+EHq+XBMg+jLmxpaKgcNmsaQRRApQUf//3OQ/c2OwsZUb4m4/RywQvi6Jb4VaSdVpAWWMl76dWZ2a3CDoXx1PJUN772NFIM6CYyluNBSeP2J/xsCjBR6tau7Ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966005)(316002)(336012)(8676002)(6916009)(36756003)(1076003)(54906003)(5660300002)(26005)(82740400003)(70586007)(47076004)(186003)(4326008)(82310400003)(2616005)(7696005)(8936002)(81166007)(356005)(2906002)(83380400001)(70206006)(86362001)(478600001)(6666004)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:58:02.0066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ccfab9-6cb1-4c83-7c37-08d88816cf4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1722
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 858acd3df2bc..165fd2f3c80b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2818,15 +2818,12 @@ static struct fixed31_32 get_pbn_per_slot(struct dc_stream_state *stream)
 	return dc_fixpt_div_int(mbytes_per_sec, 54);
 }
 
-static struct fixed31_32 get_pbn_from_timing(struct pipe_ctx *pipe_ctx)
+static struct fixed31_32 get_pbn_from_bw_in_kbps(uint64_t kbps)
 {
-	uint64_t kbps;
 	struct fixed31_32 peak_kbps;
 	uint32_t numerator;
 	uint32_t denominator;
 
-	kbps = dc_bandwidth_in_kbps_from_timing(&pipe_ctx->stream->timing);
-
 	/*
 	 * margin 5300ppm + 300ppm ~ 0.6% as per spec, factor is 1.006
 	 * The unit of 54/64Mbytes/sec is an arbitrary unit chosen based on
@@ -2846,6 +2843,14 @@ static struct fixed31_32 get_pbn_from_timing(struct pipe_ctx *pipe_ctx)
 	return peak_kbps;
 }
 
+static struct fixed31_32 get_pbn_from_timing(struct pipe_ctx *pipe_ctx)
+{
+	uint64_t kbps;
+
+	kbps = dc_bandwidth_in_kbps_from_timing(&pipe_ctx->stream->timing);
+	return get_pbn_from_bw_in_kbps(kbps);
+}
+
 static void update_mst_stream_alloc_table(
 	struct dc_link *link,
 	struct stream_encoder *stream_enc,
@@ -2873,6 +2878,7 @@ static void update_mst_stream_alloc_table(
 				proposed_table->stream_allocations[i].vcp_id) {
 
 				work_table[i] = *dc_alloc;
+				work_table[i].slot_count = proposed_table->stream_allocations[i].slot_count;
 				break; /* exit j loop */
 			}
 		}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
