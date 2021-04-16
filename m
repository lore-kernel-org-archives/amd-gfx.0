Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA092C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89BBA610CB
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BBA610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F3D6EB9B;
	Fri, 16 Apr 2021 14:34:52 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750052.outbound.protection.outlook.com [40.107.75.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A626EB90
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYl3MeroZUOpR4bEiIyl+0B8Ff0oJUFPi2HiMbIqAiXL0vYRQ/N1dJc+dS0vbMUuUmJGIAlMNTIeAMdYPJsiMt3QIVOTxrjnNSLqf+YrQF3UPhqXmjT0NxHQ/zxt4DpW9E2z1yOCefjkfQt4lgMKSYqvFVFuC9FaalH1ntdBXyuVWPxIzF5MzBE9ApJ9/eeh25FR4nE41epgDdJtCDqPh1rws+D9OF6zQQKEtXJAOtAh5SdhjZthF3a8dJ/0Epe13oKrpHWWZ4P+mrWvWvpBbVO7U+0qJ0qS1UDB0Vh4ooY2JKqwrv70f3mvm68R5y+0WV9vaVBzAEpuGfXTeCvxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++ioLyaiHOfc4TUWNkplCani3mVLhQ/bITdcLLAPDAU=;
 b=Wjtr467WFvfTIFklogMlDUZ/J84dEkb1Lap7g8PN/esHYR6zMq3ER/oqnhPeJN7sPGvex/h2bQvSLdYnzWkaYENLS3pQzuNmPg+x4BKRB1DWF5abxB2aH0UtDO34IloqNadt8wcAEjBv/pNeWczKvCKsdyy5hF+2qHjiY9XhclYmHxN9xKy3DzRU/uYeXHt1RepSuZHX+8h4z7GXJqT5TWFUOu+OICtsbSim7lwJzkzFeN5t+Qqh1NKpEBFJ5+sGlsTDzt9Zju6+utBEzcdmWzZShW2qAREeWFm2m1uqR6/VkFYAOH1PSGY+JfpR5M/aBaCUfR1gqIYsKqeInttr+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++ioLyaiHOfc4TUWNkplCani3mVLhQ/bITdcLLAPDAU=;
 b=m/Bkyaz3EsNFh13G40zuhfE61Pp6EuiD86jENlU90f0vALOMiBAm4tmImvG5uRGunhlbSV319LFhL8N4SdfqIEXoKWzebHh7QqPscVHbXXqQXwXHUMYwyZTUfmgh0/iMUO+auYXYezoHFjOnYqNulLZPCIKfQWb/zZohTUxSkCg=
Received: from DS7PR03CA0230.namprd03.prod.outlook.com (2603:10b6:5:3ba::25)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 14:34:46 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::4d) by DS7PR03CA0230.outlook.office365.com
 (2603:10b6:5:3ba::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:45 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:45 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/19] drm/amd/display: Fix call to pass bpp in 16ths of a bit
Date: Fri, 16 Apr 2021 10:34:13 -0400
Message-ID: <20210416143417.611019-16-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ab9cbf5-81c8-48a0-1905-08d900e4c857
X-MS-TrafficTypeDiagnostic: MN2PR12MB4439:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4439BE4178289F2389AC110D8B4C9@MN2PR12MB4439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8iUdrtq2MqolJ5LzuOViOrKOjpt9MZXe0z+9+P0biOPwYb9WFExL0lJ5cRXpQCK47X8CuGg+21rENjJiyIEICl0CeOiEw+2f2OVHB5XPnh8AV3THqxTD0QyLsARKjCcRK6T0+fjjIiKFlAb/6d3xhcFzWTNSIiB96G4HnGoChB4bpiXkBbtIernBubmHy7VNF3R7BB19X16UlfQyYWgorRnywVWBMM1x7iShPOzKTcVvFTR/esqgrKcBEEaUMd6wRArlfDPsiCsWHHK9kVJMgyEftU9JYo1NMiQOpSQil0jVu0PLwpsmCcRHt4AwUqFMHTk2V8v3YbE9z+J0g2ClH7bDRa+Bv1TX6QnRJmHRXnqLPBjopdZ5BHRxdOQMA/YqMjFuKjQ2F1Y0HqMPTUsPkpOxt7dCQGqq1tS/D2IXYoHpbrR+wV4oDwrJAz2mytVZxWCQCQA00MdSzU8P1Jh31pxwq/gfJIFQivNRS4OQEfvJfTY7YLAOu1dBdDNnYVGmtD3Ea9/SDTURuSaY2SidAntZOpBYV3NdSJHrinMr4P4KW6Jtf0owXKGZGgigAb+oyxzuiUqBt0wfV0dGT4gmFkjLUJGrbXOV1edvUTRXmUn8oiQFgcBMNzbb3qKD/Wua8cfUne5Bi7Q5eEyAd1kqPaiKbj++0EzUH6nlBtVUNbp0MjSiqgzO7m1nFs7l9Gh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(36840700001)(5660300002)(70206006)(70586007)(83380400001)(2906002)(36860700001)(356005)(426003)(336012)(1076003)(186003)(44832011)(81166007)(82310400003)(26005)(7696005)(6666004)(82740400003)(54906003)(6916009)(478600001)(8936002)(4326008)(8676002)(2616005)(86362001)(316002)(36756003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:46.2391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab9cbf5-81c8-48a0-1905-08d900e4c857
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
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
Cc: Dillon Varone <dillon.varone@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[Why & How?]
Call to dc_dsc_compute_bandwidth_range should have min and max bpp
in 16ths of a bit.  Multiply min and max bpp from policy.

Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Eryk Brol <Eryk.Brol@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 73cdb9fe981a..b23f7d6a1409 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -745,8 +745,8 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		if (!dc_dsc_compute_bandwidth_range(
 				stream->sink->ctx->dc->res_pool->dscs[0],
 				stream->sink->ctx->dc->debug.dsc_min_slice_height_override,
-				dsc_policy.min_target_bpp,
-				dsc_policy.max_target_bpp,
+				dsc_policy.min_target_bpp * 16,
+				dsc_policy.max_target_bpp * 16,
 				&stream->sink->dsc_caps.dsc_dec_caps,
 				&stream->timing, &params[count].bw_range))
 			params[count].bw_range.stream_kbps = dc_bandwidth_in_kbps_from_timing(&stream->timing);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
