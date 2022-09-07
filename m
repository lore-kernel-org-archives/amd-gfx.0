Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BE4C38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 11:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF3A10E5A5;
	Wed,  7 Sep 2022 11:25:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89DE410E5A5
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 11:25:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jailc3HezNPvu2GkmdYSH9fvmttFcBVtXZgPToSBgH7ecOPvGVyOEnVH1zImTGuBvot/ZTgqC02UKzr9TzDKQYScoytPqLl1RRQXGQfDf0Mg3mR+UAV77qmyKyFxHgtkqhB3v+lQU9Q0auV4TAVSKnjhnfijG8TvSoYVkUmU0XoS9jV/sPiT2gSyrUXILFf/013sB4ReGUpVxFDvPEgQa5g0Sz3A4r2lZInmc7c/P/K4kV84ytFosljrqtYQQflfax7YHr++J4CMEPtWOh+F1AgYcZFUUxFgKDEjhlcpzqbDO0235QCuXGXrzfgGWoL/yIPsWehbs7fD4EjEUWWEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myNCKFlhMSFOewtwUJGwSgt2uM6Y0mBqh2ORzaTYR7I=;
 b=TFToPUjFYtPHIDWL82Tbiq67nglZx54ThcWWpAqiehe+aGzSZvVLD04Is0LofR/0jD9B92W8Mo60trxrVOOBLrobYI2mUKyZY8LNmY9wIgvYWqY9jzzrJsGiv1VtUbNLurhV9XKQsjf97EAQI8dU9/MIBtr2FQ6OyUH+0/FC5HjAN+cGjfwjSJyLz5775B2QDapiW0vRg+GzfbmDw9BamSlsIDkrjRi9EwSH7CIXqH5Z/cZcB3TJBih6OVL53pZBdmY8MVCIw/3a6yu2AMp8dcTfnOUelwxoDG1wJpS1FFE0NQ1HNha5qJnu/Q5I1i8d5YpZuaBu3sdafIoiVrdLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myNCKFlhMSFOewtwUJGwSgt2uM6Y0mBqh2ORzaTYR7I=;
 b=YTpFXuMlNo0KHGohMEzvKVpoGb3KSjBNjT7eD1VGy5/QLWpO5NUL/2zaxL3YpmRUHQDhZK5ZLL5IjqJ4QyhiPKyNwrbFzoKe/vI8AxDbwsWBbRd02f5qajlHLr4ULoLDnvKAmTmSzf79bM3mxrCCiitJv240axDBJWlkSqw/cwQ=
Received: from BN9PR03CA0445.namprd03.prod.outlook.com (2603:10b6:408:113::30)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 11:25:03 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::e8) by BN9PR03CA0445.outlook.office365.com
 (2603:10b6:408:113::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 11:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 11:25:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 06:24:59 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 7 Sep 2022 06:24:57 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix a gsl leak on dcn20
Date: Wed, 7 Sep 2022 19:24:53 +0800
Message-ID: <20220907112453.2617635-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5f4243-a466-4e30-477d-08da90c39bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMRglPNPQiZZ+RoV1J6iB//dLedGDSy/zYT86PAEc+CzWIDpfkStEwN1NFPsB+Wl+O/ti0WrSN8/KuavKWBPHhFqIVjFmqz3n/IjP7XboMvTnu9OOvAXoONfTU2aIJlkt+Liq4LcWF8tz2MqbOcpZKi/5JvZaIRq98fe+iPWxCf232XyH0IvXqmcamqNPNLWJMpIn/8q0Q7DjDKJzq7B1e60OWEkqJ6Dv59hXNVUIMjgf/E8Ke/4xZBhaB4IuhYnmFOyJcKbY1kzQB/p8U0wlBYJ4ofkZWkXy7VQXlESDWm7TMAjtIVMOTSRrZOoD30eMRJ96oZYjbOdCIwCJdwv70w62nCw4kA/2t1YZ+X8Bd8HeeZoBBfBarORGdflqlF+RqpdbfiqgYgRsIG/fiVZIh30dh1xLi1Ph3haGqhhoNWUJQ5SuDzonT0TPidrL95Kci1GyDuxHVCGwyy1nm+l9Qn99Nsgp/yNNLO+7dyni+zLTXYeSyQlC3lyEdYriUyeeNxMEtAbS79Lkl5I04fAPJ4EhrGLkSplx5Iy102G13sZXQh4vNxyxsAL5GnOJ/x4cGk6QfLbh5K8BRSDQAVxrmAaLzKiCXK11/bR5aAmvacMqj6NuvAAIdApfCKBCO1Wgo3CbuXLjlMt72xSdNhZ3t7z+2VDq2DStSIct0WZhV+T5elDu/wzN0Lr8l0Tpf2L1gI/7IibcFWcs3KuX63bBT5DVB/sftiDLKlWJYqYOHxryO6UYIlHPcPfc45joVUGtD5uKzg+Zl6tAqckN1NYFJjW9era7DFhhFV6Iysisr6bWJHQSWZrhGq8t02Nb0db
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(346002)(36840700001)(46966006)(40470700004)(36860700001)(356005)(40460700003)(81166007)(82740400003)(6916009)(316002)(54906003)(5660300002)(44832011)(8936002)(70586007)(70206006)(8676002)(4326008)(2906002)(1076003)(186003)(336012)(2616005)(47076005)(426003)(41300700001)(83380400001)(40480700001)(478600001)(6666004)(82310400005)(7696005)(26005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 11:25:03.3452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5f4243-a466-4e30-477d-08da90c39bd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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
Cc: Guchun Chen <guchun.chen@amd.com>, Zhuo
 Qingqing <qingqing.zhuo@amd.com>, Tianci
 Yin <tianci.yin@amd.com>, Wang Yu <yu.wang4@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Deucher Alexander <Alexander.Deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: tiancyin <tianci.yin@amd.com>

[why]
When the new pipe_ctx holds a valid gsl_group, the old code logic will
overwrite it unconditionally, this cause the new pipe_ctx's gsl_group
have no chance to be released, i.e. the gsl_group leaked.

[how]
Don't overwrite the new pipe_ctx's gsl_group, if it holds a valid
gsl_group, meantime release the old_pipe_ctx's gsl_group.

Signed-off-by: tiancyin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index cf439ed270de..92ef58068b4b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1720,8 +1720,12 @@ void dcn20_program_front_end_for_ctx(
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 		struct pipe_ctx *old_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
 
-		if (pipe_ctx->stream == old_pipe_ctx->stream)
-			pipe_ctx->stream_res.gsl_group = old_pipe_ctx->stream_res.gsl_group;
+		if (pipe_ctx->stream == old_pipe_ctx->stream) {
+			if (pipe_ctx->stream_res.gsl_group == 0)
+				pipe_ctx->stream_res.gsl_group = old_pipe_ctx->stream_res.gsl_group;
+			else if (old_pipe_ctx->stream_res.gsl_group >0)
+				dcn20_setup_gsl_group_as_lock(dc, old_pipe_ctx, false);
+		}
 	}
 
 	if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
-- 
2.25.1

