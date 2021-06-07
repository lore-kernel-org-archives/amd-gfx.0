Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10103C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE5E60FE5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE5E60FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC026E928;
	Mon,  7 Jun 2021 16:48:41 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB1816E928
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:48:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKPO6iwSy2acmnRLPccdJRIWCPa12tSUAhH30Fv57RY/ZyFSN3JIGAEr+ZhItWGBJUFjDRS7CWfxm4zX55knDz4m6eTA4zYA9y3d4D2hf/P7verAxj5iwznxZzCwCedKrGWp+2zEDqc6FdgCofpb0GTr4NOqvqiITGPFag+lnyJolu2Os9IHqeSl7WWEcumsgn780EkNLKfxA+WfbsrAgsEKJkHAjKcWij9UHTH8uPj3mhi/VsN8f7ocn+LHbj2RZ0D4EpE3ubwS0bhOBiGRlgK7i+3SMaRTrlMo3kFZWOOsKypdQla+e3BX2A9KoFEUYHO5uRH7HMCiZjjBq6Wq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzRwlP0IfVfQR8sp6qIfQ6Y453zmk65r93Md7NVA0DA=;
 b=PVW5B1Pxw7fcgrIq9ZbT4CyKYzfZcwIlqJu9eve4J3uAdaAd5j9lJFoiVrYo+lZIhBMoIpkH+zThz1PtzMBKS6iG3Ktx/N9N95HfrRvWOod2BuRghcGqPlfehKOEwY90D5yTKNUY2nGBRrKwMzlzgOy2lw3YK317nXcsx5+RTNzvrja8laG0B2xRO68Boqjugl1+5wmArfkHvBwEt7tS9TLUjwRfk7l1BfdOQB9E4KtSihY5VfsSCZQeCqI2kf+djFl5Aek/8btJf8Ec9cFO1HMGmHMHfBeu57IUG1SkYeBInqnTdTT28T5xH+duBsJbuaz11MdF6PENIw3Vufk8OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzRwlP0IfVfQR8sp6qIfQ6Y453zmk65r93Md7NVA0DA=;
 b=lTSMdl8A7O45WSiyM4Uos/4tVgg9AVX2JMPCuLep562UEGDhE7TqtXAw6LoYBt1chp3jaEz/Thdtbj9AaQqHOyWV7QMIkmvI8fCdJc5YgvhyJtCp9yYt193PIky1PQJmAuTKey6uJpfRkqwfQD+BCCp7WrvUOmiftDFC+eAoYFQ=
Received: from BN6PR2001CA0032.namprd20.prod.outlook.com
 (2603:10b6:405:16::18) by BYAPR12MB2695.namprd12.prod.outlook.com
 (2603:10b6:a03:71::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.26; Mon, 7 Jun
 2021 16:48:37 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::80) by BN6PR2001CA0032.outlook.office365.com
 (2603:10b6:405:16::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:37 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:48:33 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/30] drm/amd/display: Release MST resources on switch from
 MST to SST
Date: Tue, 8 Jun 2021 00:46:59 +0800
Message-ID: <20210607164714.311325-16-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bc1fe7a-0935-432f-c83c-08d929d418a1
X-MS-TrafficTypeDiagnostic: BYAPR12MB2695:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2695679BA8313EA736332202FF389@BYAPR12MB2695.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umBAPjxNMcfu3NfToiwbqCfB8lQe4pO4Awt3NB56IPi/d9Maq7ijeOy0IL2z30TbrHogGqcm4zoa2Kt/UDdbZruEaLe7LALwn2/Up5XX/h6U9QTLvhtpVeTj08HTS34ce+RcCrHp1KixTgtqGp0ubLkc9qKpjBoen6dnt10uGRKy+MoMAS7Gu4+NARWqIKUQrXj+tlduW93otcB4EMom8onE7t473tX2rqWbQkisD1YqgTzqi1Q82HP6vPDC38068tct/n1N9Y96ww/KxN6D5N7SJLJ8M5SLw11HUzi7zT7LLiZR1s43Sh+P/fGknM9RSxmuvzLfWUhjZszk5lyh2A7ytnvLWV6QbKCIoBpG113NSus9WYYJYnHEPZxyQgfCUrZOrf4MjpARJ+JZWbDpb74F4S6LuMUZpYpvDRhoM70Nep//Jf8CbuH623+8hPhNVEZywefLriAo6trSq1ud5pF4UoYlBIWsruY1jKJ8S66bCjLt/3SEDyKPQ2R4xO56CFc7JdcQ3oXiXkc1q37bHoE3/NmjltlUyYrp6P7iXXCVQQuxsCAYP0IM//JTVx0oLwuvlnuZhf4cz765JLukIcRHegGPryNVCNbu8yoU65969sAxbRlYT2gQcXOFOScp4Szng0/hZEVlRt/k8zdLS+dSywi1AGymm0+bxioEwSYfhJ+nTP6Pj0I9cBm0qq/K
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966006)(36840700001)(16526019)(7696005)(316002)(54906003)(186003)(36756003)(26005)(478600001)(70206006)(44832011)(8936002)(6916009)(5660300002)(47076005)(86362001)(426003)(336012)(82740400003)(1076003)(82310400003)(2906002)(4326008)(36860700001)(8676002)(6666004)(356005)(81166007)(70586007)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:37.2267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc1fe7a-0935-432f-c83c-08d929d418a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2695
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
Cc: Vladimir Stempen <vladimir.stempen@amd.com>,
 Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vladimir Stempen <vladimir.stempen@amd.com>

[why]
When OS overrides training link training parameters
for MST device to SST mode, MST resources are not
released and leak of the resource may result crash and
incorrect MST discovery during following hot plugs.

[how]
Retaining sink object to be reused by SST link and
releasing MST  resources.

Signed-off-by: Vladimir Stempen <vladimir.stempen@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 87f955820c0f..919c94de2a20 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1917,6 +1917,8 @@ static void set_dp_mst_mode(struct dc_link *link, bool mst_enable)
 		link->type = dc_connection_single;
 		link->local_sink = link->remote_sinks[0];
 		link->local_sink->sink_signal = SIGNAL_TYPE_DISPLAY_PORT;
+		dc_sink_retain(link->local_sink);
+		dm_helpers_dp_mst_stop_top_mgr(link->ctx, link);
 	} else if (mst_enable == true &&
 			link->type == dc_connection_single &&
 			link->remote_sinks[0] != NULL) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
