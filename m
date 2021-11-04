Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CE8C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3034F61106
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3034F61106
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F7E873874;
	Thu,  4 Nov 2021 20:53:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 696AB73873
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:53:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuWz3s4umPHl/TuvJvRd/FWevd6MAOk0M/ggVr/1PPUMwn+VoByqULhqzTaUSCLBrqEXO7lqzwUCtS/XQq1FvuDFbPTi9LG1n7d+vbATJYKaORsNZwiL34IO0r3Ok/6bkonMfYU6+i6mXjxBwkNVuaXKsqpMYXDRes2td4+4pCoDx5qRAzyAFlAYjd1Lz+s1P5Jh9Tq9nqZ5vzkSmzRw/RML1XekD8Vt7BDrAOUo2CGVIDXsGTSD0YCID5YxzcHXLEpGhruVez/82PsF5XKhXCr8mcYRtc60/NIdxnMh/uQ/73u07vMuEO6lCflY3vVBT/DR4dim+8wQpV3HromrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvfHgmnGDphePRIl8Q6iUfBGiJ4tQ1cBWt+WBywBcRE=;
 b=mx9zyjyMo4XsuE5s86BN+XKN60HV20p6Zf+GGcCxvNF3RD2wz84LhmXALmkHmlMZM50TEZ8apKr6GYuGoAaCq6YeEyUE+ji1nVDHXU17tocwOvkBJ3E4Uj4+hlBjL7YLt3pnNtN50tqoyqA2gmgRVgGchUzRBuAX1zUT5tzggRrP0D1gSSSlacJRQxkPq/7m9atzEnZjPaiPkas1gEzyl6AVxCkUvkSkKMKsI007jEtvGvqzz6QzuYMfNsv16pvSsdp3wbsB93jlmUCdalGKjuYUKVZV3rxHhm23ijyKS5VctdkmJpcm0k0BnEFjgLENxbMcv7PM6XiISETucI1y9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvfHgmnGDphePRIl8Q6iUfBGiJ4tQ1cBWt+WBywBcRE=;
 b=LmSuH76nwz5d08vFapIfnQqOK2lxCgEDQ8j/YTcMQ4ZW58cvs9vxyBtf6lilSyXdqtZGvmOt9UGVf7nXgX2L8brmHrnsc6bkWpUfNnz29MUv9wDzUkQM/6RUD+baOQ+W94bVaN+Icblr8IItijcrx2jwvPSvSqLc6u2DhTR6/yo=
Received: from DM6PR12CA0018.namprd12.prod.outlook.com (2603:10b6:5:1c0::31)
 by BYAPR12MB3639.namprd12.prod.outlook.com (2603:10b6:a03:db::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 20:53:05 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::b7) by DM6PR12CA0018.outlook.office365.com
 (2603:10b6:5:1c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 20:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:53:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:53 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:52 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/22] drm/amd/display: Query all entries in assignment table
 during updates.
Date: Thu, 4 Nov 2021 16:52:13 -0400
Message-ID: <20211104205215.1125899-21-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b2bcd5a-b9e7-4e9b-cf0c-08d99fd519ac
X-MS-TrafficTypeDiagnostic: BYAPR12MB3639:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3639504EA8264AA5FDBF3F3FEB8D9@BYAPR12MB3639.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jSA+xPFlZ05zxwRwsgerie8/BCBemAVT7yF6rlqYxtdoY6VuY+3/cnavfXRmXH738hpjlob7ScEp3xmEC/v2HFYtcMRQbEoABlncKW8X2neWHPDrXMaVVCFipZDN7XtJ3Su4n7qu7nW849J+A5c1rzF0UAJhWExNhJUqSWoBv1qx84PV1WyM3kK5FryrLPz/fnA6R8t2sJdME6Q2WXIIVGxkj3RBpZ9QIj+8zK18DnKCFSLFmgwGqN3f1+M0FsSpAY+TpPotdQt2JxmjgM/AM/kb+qOJZJtBDldUAUHjnedylEQ4t2dmwCFrH/iOcfy8BKgcU1++gTgfe9oO6f7fu9jtLgiRy6xunfquK7XO4uTSxj8aiGR/HoAGkO1lvfmazJV0OtaGRU/xUVsd+vCf9QIV0HVC2zkw12V3gHWfe0Uy3qKuWirwkTEuY+B5sU3OzgwoJP7M27t7Rf/XaVmewOndjp7aCS4hLTe0ghTLfUdkYuuUoswriKCATFihOpknYlClRuzEkWmoBtBqT0XsNQ2JO8eLWjkLKNNTvHyDSabj/yGuIlXSs7Fbk2ig5aH5FSeOdPldVD9D3yi6r4qfogxtN5LAoHqueXuoZijYPqOubmuTDfnmxdpwhgyv09h1369dAbKi3jkEB/xi0b54QGkC8o9hiblmYnAZTEQMEKuewepUCWEo4fd7Jv4BhUbUrlnEiHtDQV1j95udQvOjfThQ6IIBO85qaVfu46NZIOU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(36860700001)(6916009)(81166007)(83380400001)(47076005)(356005)(7696005)(1076003)(70206006)(70586007)(54906003)(508600001)(316002)(82310400003)(4326008)(8676002)(186003)(5660300002)(2906002)(26005)(2616005)(36756003)(336012)(426003)(8936002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:53:05.6442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2bcd5a-b9e7-4e9b-cf0c-08d99fd519ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3639
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jimmy Kizito <Jimmy.Kizito@amd.com>,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Stream ordering and count can vary from one state to the next. Only
checking a subset of entries in the encoder assignment table can lead to
invalid encoder assignments.

[How]
Check all entries in encoder assignment table when querying it.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c   | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index b96e301f64f2..787aaa661a29 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -232,7 +232,7 @@ static struct link_encoder *get_link_enc_used_by_link(
 		.link_id = link->link_id,
 		.ep_type = link->ep_type};
 
-	for (i = 0; i < state->stream_count; i++) {
+	for (i = 0; i < MAX_PIPES; i++) {
 		struct link_enc_assignment assignment = state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
 
 		if (assignment.valid == true && are_ep_ids_equal(&assignment.ep_id, &ep_id))
@@ -538,6 +538,7 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state)
 	uint8_t dig_stream_count = 0;
 	int matching_stream_ptrs = 0;
 	int eng_ids_per_ep_id[MAX_PIPES] = {0};
+	int valid_bitmap = 0;
 
 	/* (1) No. valid entries same as stream count. */
 	for (i = 0; i < MAX_PIPES; i++) {
@@ -619,5 +620,15 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state)
 	is_valid = valid_entries && valid_stream_ptrs && valid_uniqueness && valid_avail && valid_streams;
 	ASSERT(is_valid);
 
+	if (is_valid == false) {
+		valid_bitmap =
+			(valid_entries & 0x1) |
+			((valid_stream_ptrs & 0x1) << 1) |
+			((valid_uniqueness & 0x1) << 2) |
+			((valid_avail & 0x1) << 3) |
+			((valid_streams & 0x1) << 4);
+		dm_error("Invalid link encoder assignments: 0x%x\n", valid_bitmap);
+	}
+
 	return is_valid;
 }
-- 
2.25.1

