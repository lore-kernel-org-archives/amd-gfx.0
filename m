Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72F8C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFCF6509A
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFCF6509A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EB316EC3A;
	Fri,  5 Mar 2021 20:04:10 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760084.outbound.protection.outlook.com [40.107.76.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FC4D6EC3D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 20:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyXndLhx5T2dv7wOPBLTR/Yps7nn4AkSq0tgLca1n+H+p/2o4u/yF5q3AdRtkAn9GC3RNmbL1uUICYF3Yz30UeUCOaU+wwYJ1UR2/Y+AKLp/98l9zi5MVlS2GRfIncFNmg+KV+peetP+2TQoyDApptaHAtmsPn00bWDWaJ3H+5Tpvf7SMRQjDh0t0FeQ/gPDEtMgfq+vLhXdd1sBWhQh+3wpoTvjC+tOUVwty/5We21pXJwV4iNey5jBbhShAkq+zeRbnenQzGlTGUu9gOSNUNRMd+XhZurik3TfJdfJy9nXKO823Be0Dck5QZMIwXpI4BoYiergM6HVKlrgKLA/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEb1/zdmEVDuYAlg3H89xBNbgKZAyc9eFtWcP81ubtc=;
 b=gdEr1ojiTrgqgIQIlXZGjWpDLnAwij7JC/wFnfylYK++sxD5kPradEubwOySAqmJOxx9DwSmLOt9AeJzH1MMvvp9FR0hr7KVnsygPFKP+AwiUhq+NLDRMckBcb42NosPSty1JJfeYac5vlGTGSCRwfl3aPq60xW5CDjLVBIoXFLuKK9lA1buvbM6takbZHHBs82RZBxNHE5vOe82SYCvOIK7bcB4imyJnEUX1mviE6wqnopu7Rse02fOFRShg9vA1CicD+tcAyCQzjskmgJfDsgi//MuhU4csS0qLXWy7KdpEmK+tlOMq9ct9hprgOFm4dDPYVTIy9+yu6bzbpm9Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEb1/zdmEVDuYAlg3H89xBNbgKZAyc9eFtWcP81ubtc=;
 b=CxU8nKIOJYGb5Et1nx1x2XvjHm3KpvKc/R+/MaRZtUn2kRUI1fHLbk6gVa1qh/NzmGwz4SCv9/m7UmnXMwTwy3CtPf6aQdsPMfEI47kaO5YotQa7IHM12JNHupo92r7HJtV7KgBhbMgANdDjaRsiHEQTcz4T23vMzTkiRfQv25A=
Received: from MWHPR20CA0040.namprd20.prod.outlook.com (2603:10b6:300:ed::26)
 by CH2PR12MB4821.namprd12.prod.outlook.com (2603:10b6:610:c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.24; Fri, 5 Mar
 2021 20:04:06 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::83) by MWHPR20CA0040.outlook.office365.com
 (2603:10b6:300:ed::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 20:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 20:04:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:04:02 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:04:02 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 5 Mar 2021 14:03:56 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/14] drm/amd/display: Move define from internal header to
 dmub_cmd.h
Date: Fri, 5 Mar 2021 15:02:51 -0500
Message-ID: <20210305200301.17696-5-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305200301.17696-1-eryk.brol@amd.com>
References: <20210305200301.17696-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24dba9f7-b802-4bf3-92dc-08d8e011d38d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4821:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4821A8AFB14DF57546AA171FE5969@CH2PR12MB4821.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VW0IMnMWgscVhqHIC0OxiIg9K0d5ATqY+d8W6ofUY96DJdFOvAvBxSBSzZt7ufIqDCdZsx01ooyQWt+FnN2mwzXxXCYh8MI7XoKCcFsxjTmhT8H07ErKcqoYCsFlRP3gfdPKnq3EQEFq5GsLtmjNsqy+8Xqz6dMvhwMGcZJWH8ltzToeMWfkqWLm1AmV7TKlCQQbAeDasgbK8mcBcP2hkr6opFC2c6rJkdpAdQ01GDvlspL1EMcf46YtC+zbRQxCI7wzeiL+aH+psYb6wGal0vDAG0w8b43tufQiS3ySpVEwsptZsgyYOEOZXl1XK7QHDJd6gGV1iPfHm7aq1mrFneG3exxWv70BcViVCUUECB9dL9Y9HltV8mzVRuRWqnIGfWC5yIvGHNtSUx0SEmYCv75noNVQmYe7N1fulc42tYhspkZnrjt7ZCS6FbHFtCDYzFWu9ereC+ydp65AWG1cgEyhoXdg3/UQMHblNE4hEUsYA6QxcZs6GiMfMrlSv3M+PIh3LvKG1ZucLJnI2ZRhjCgCfyP7kE02urxX08n4APJm0WQgnxderWrOrC/koLJAk/dS9n4IUJG3VLhDPjmg2mLA0Izf7YZWp0IqSIULeSLL8/LQqactnhFV6uLQL1SxMJyL42g4gJpVsRpGPwA75atoQcFGyog57VXZ9UTeokHOWj49qtSJthYyx2QK8SIn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966006)(36840700001)(6916009)(82740400003)(6666004)(36756003)(47076005)(82310400003)(44832011)(86362001)(83380400001)(186003)(70586007)(26005)(356005)(81166007)(54906003)(2906002)(426003)(8936002)(336012)(8676002)(478600001)(2616005)(70206006)(5660300002)(4326008)(1076003)(316002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 20:04:03.9772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24dba9f7-b802-4bf3-92dc-08d8e011d38d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4821
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
Fix linux compile error

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 12 ++++++++++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c |  5 ++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 99356d0a048b..a9635b5abe55 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -172,6 +172,18 @@ union dmub_fw_meta {
 
 #pragma pack(pop)
 
+//==============================================================================
+//< DMUB Trace Buffer>================================================================
+//==============================================================================
+typedef uint32_t dmub_trace_code_t;
+
+struct dmcub_trace_buf_entry {
+	dmub_trace_code_t trace_code;
+	uint32_t tick_count;
+	uint32_t param0;
+	uint32_t param1;
+};
+
 //==============================================================================
 //< DMUB_STATUS>================================================================
 //==============================================================================
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index eb9bf4da088a..55ee27defd0f 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -31,7 +31,6 @@
 #include "dmub_dcn301.h"
 #include "dmub_dcn302.h"
 #include "os_types.h"
-#include "dmub_trace_buffer.h"
 /*
  * Note: the DMUB service is standalone. No additional headers should be
  * added below or above this line unless they reside within the DMUB
@@ -475,7 +474,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 		cw5.region.top = cw5.region.base + tracebuff_fb->size;
 
 		outbox0.base = DMUB_REGION5_BASE + TRACE_BUFFER_ENTRY_OFFSET;
-		outbox0.top = outbox0.base + sizeof(struct dmcub_trace_buf_entry) * PERF_TRACE_MAX_ENTRY;
+		outbox0.top = outbox0.base + tracebuff_fb->size - TRACE_BUFFER_ENTRY_OFFSET;
 
 
 		cw6.offset.quad_part = fw_state_fb->gpu_addr;
@@ -518,7 +517,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	dmub_memset(&outbox0_rb_params, 0, sizeof(outbox0_rb_params));
 	outbox0_rb_params.ctx = dmub;
 	outbox0_rb_params.base_address = (void *)((uint64_t)(tracebuff_fb->cpu_addr) + TRACE_BUFFER_ENTRY_OFFSET);
-	outbox0_rb_params.capacity = sizeof(struct dmcub_trace_buf_entry) * PERF_TRACE_MAX_ENTRY;
+	outbox0_rb_params.capacity = tracebuff_fb->size - TRACE_BUFFER_ENTRY_OFFSET;
 	dmub_rb_init(&dmub->outbox0_rb, &outbox0_rb_params);
 
 	if (dmub->hw_funcs.reset_release)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
