Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C112C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03ED72071C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yoaT61Jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03ED72071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC0C389BFE;
	Mon, 25 May 2020 18:13:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F177689BC2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLpuVOvjqBsbcch3YpckzkYroIFdhPo1Hct4Bf5Xnt/+gTD5WcGLkY0Jr6xr7DW+WDWZb3ZJJEn8tRvVCFSa/eGvW9UpyMgTWycUlzT5P+vKhcHlZSrD+pKAQPOZuzzTDXXt0dHu7auegPGVOhtKdreq7L6eQIsGw+i3sCKTVzdF3KXsXzYwpeavU+Bi8eF/WBOCer8lrb0JrAnN5aS9qVDbsJPgsBNlD35fkI239er2nFyuIArfDGYel7OsPZ1kEAbXv9CDl6ViWBKMbwdE+Hw7k0f5v6lrL+d+QR4Tr1craxnD+lJasP5HR177tpbYz+GCZTCn186JYyuW9PJN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ektete4msyDlpmW31jKgT/MRtwQUbR/WXv4qYPUvDIA=;
 b=K/DXLAt88AzloTj3yEF5prGoPE1gB7nOMiuOfmXSVVkho+yuKsNRWQs2Zu4ZrnmQ0H7vw4X2p4BqZGV2sjMwwyzykpv7Z0F3Drg2v8Y0siPBwPafRZj3d7HnJ+JNDQvHpV13vc0Fzjw3R3nfzvFynTSoqT0K11I6yqkqj9aBPyif6jtToGijGSUKogXJ8wyZquh1Dl9Y9JG7Ah2m2Jxbf5LnyJMUx8aGDPEvP7efJrnqjhz5aLJYrgWX9lbuG5jdWgu10LU5Lzb2UnrYvkSeOQaNZa+4JFhUSsXP+rLrtgImosnZZUdBVaPRc6Jhi50d6SE1N+LzYxzo2u+4thG95w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ektete4msyDlpmW31jKgT/MRtwQUbR/WXv4qYPUvDIA=;
 b=yoaT61Jhx6jxdN/mlQqAHSehVvbXqCTR38EhC16Gqu6FzEdfSDh5R7YqvGjQRlCK/h8g6wt6S3fPyXx/gqcJ4Zao+DS1JB2uylUlo8mpGi2yYRyyKjf9HJDEIVZK0d/ktljEh2EJ7VAkFUMVRVNBP2feHB3OUPuLzQjO1QLfZ8g=
Received: from DM6PR02CA0049.namprd02.prod.outlook.com (2603:10b6:5:177::26)
 by BYAPR12MB3463.namprd12.prod.outlook.com (2603:10b6:a03:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Mon, 25 May
 2020 18:13:12 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::92) by DM6PR02CA0049.outlook.office365.com
 (2603:10b6:5:177::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Mon, 25 May 2020 18:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 18:13:12 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:11 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 May 2020 13:13:11 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/16] drm/amd/display: Increase Default Sizes of FW State and
 Trace Buffer
Date: Mon, 25 May 2020 14:12:57 -0400
Message-ID: <20200525181306.3749-8-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525181306.3749-1-qingqing.zhuo@amd.com>
References: <20200525181306.3749-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966005)(4326008)(2616005)(426003)(44832011)(47076004)(6916009)(82740400003)(6666004)(356005)(26005)(86362001)(186003)(478600001)(36756003)(70586007)(70206006)(316002)(5660300002)(8936002)(8676002)(1076003)(54906003)(2906002)(82310400002)(336012)(81166007);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1b098af-c661-410d-5989-08d800d7497c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3463:
X-Microsoft-Antispam-PRVS: <BYAPR12MB346367C138F658812B4399F0FBB30@BYAPR12MB3463.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGW/VmHucLjZiPqAlsG6vUwRyBEv5aKdKPvMBCkqGgQ71HopIESSJFMVcarATgKBGzTB0f0OF/Ma9VlspMs950G2ug98auwMcDsAOMq22hJaJinpBDtWYBAJ3GbJFOnwO3o+z3OjjThTiMYN+rkQZpbeblvLAjpea5v0cjdB2p+FpOfl//vfzusCR4PKtBYyBzXSelxeb1mykTlDTCoZdv2UpGrnBSiLD7d21VV4zTHLsBeIQDIjLp9cwAklYD18cnRz+Wohp+qtA0x441BDftIvYpViTUCyHUTBZtv5Cr0wrqsvw9xt+LKlzGdG0ML1/2NxPXufJrELtAlKi42gooLt+uFkQ8gcMQMh0+ki1TXZy/ySQeE4H/dPWITnYCbuJBdEDLecqd9vyuzFTWNSYA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 18:13:12.2810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b098af-c661-410d-5989-08d800d7497c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3463
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
Cc: David Galiffi <David.Galiffi@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[WHY]
To facilitate DM removing the dependency between dc and the firmware
binary.

[HOW]
Setting the default values to match VBIOS: 64 KB. These values are only
used if meta is absent.

Signed-off-by: David Galiffi <David.Galiffi@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index d128b0639572..f50fc8a3344f 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -47,10 +47,10 @@
 #define DMUB_MAILBOX_SIZE (DMUB_RB_SIZE)
 
 /* Default state size if meta is absent. */
-#define DMUB_FW_STATE_SIZE (1024)
+#define DMUB_FW_STATE_SIZE (64 * 1024)
 
 /* Default tracebuffer size if meta is absent. */
-#define DMUB_TRACE_BUFFER_SIZE (1024)
+#define DMUB_TRACE_BUFFER_SIZE (64 * 1024)
 
 /* Default scratch mem size. */
 #define DMUB_SCRATCH_MEM_SIZE (256)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
