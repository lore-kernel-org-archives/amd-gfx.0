Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F41C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 00:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A4F2067B
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 00:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S2rFwQn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A4F2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A79F6E49F;
	Wed,  3 Jun 2020 00:53:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A84566E49F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 00:53:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L82QpdMI+8SRyiMVb1o8imuw92fZxiUOtC1LAbKnAB0KV2vFqR567rhvLxh7T8hFc8tBg1135qUb/Lsq4fzKKhXRh6IGzxC2eEulL47D2Kx94o8P51xn8dyt/F2vhA9jpre6v4yWVhrnEesRO0wmMBlWFIP7qfFEH68UUHNv3FbiwkE3Kn47PHilp1LYZMuzDw15G1hvM69FVvrKwhY2CYgEvqS0gP0ZnIseJ3OkC9cfwkboYXdCHlxWM03RjJZPYc2UBN/7L60lYPGbfBsVN5IRygPW8DHEDSbGvxt59Wqtp7ydrO8te3rvl7j1Nyx7UKkKN57hsY4MMOspy1IOrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRMkH2hFb6D5GNE5OK38yznXdZXLU3GzauI08uY81jc=;
 b=IX3W6tpEQea39Ppg7MkaBbQ/M220grQZinu2dEPjzAqMA3KKC2hWGsQOdiDjWuzftygldivoqzsSpG99kU7qtJnEhqhDZu7KFbToqo7Dppys3MNfA2Pcw2u5jXQP5mdGAVBKRvXy9YD4Ehq9Nw29kXQlOynOJRMs18zDhrSYXNhFyf1Ume9NlIG6MLIB/rgLuHiKttKN7Ya4MYwqZMiGVQEQNjLUbncxHZG68QMTni5kFkOntyfOehP6lwLOMzBoBLTVnxtXJGFdn1dwG0zC1LsdDOeioFmfTKWpTtA/rhzu+A8vUHXpDNim7ZIyaC5pJTAxO+ZMtShxvJV5z+7tFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRMkH2hFb6D5GNE5OK38yznXdZXLU3GzauI08uY81jc=;
 b=S2rFwQn2frUXw/8ooKxQG3Az+sjj0Iu1vUYpuo8YUmsloGh/69ikUYViGFvhowgYhKMi57d0+EJcJKqEOKZFuiQccFf2cJy2ZcBphEmPqTO2sZhb44R5tn4PJ+WRlXqO1+1qS3V1WYgt33FabrcS7NkaRPrhGxFOhDCZ2ZPGn5U=
Received: from MWHPR21CA0068.namprd21.prod.outlook.com (2603:10b6:300:db::30)
 by MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Wed, 3 Jun
 2020 00:53:46 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::a6) by MWHPR21CA0068.outlook.office365.com
 (2603:10b6:300:db::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.3 via Frontend
 Transport; Wed, 3 Jun 2020 00:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3045.22 via Frontend Transport; Wed, 3 Jun 2020 00:53:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 2 Jun 2020
 19:53:44 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 2 Jun 2020
 19:53:44 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 2 Jun 2020 19:53:43 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Revalidate bandwidth before commiting DC
 updates
Date: Tue, 2 Jun 2020 20:53:36 -0400
Message-ID: <20200603005336.32196-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(46966005)(426003)(186003)(336012)(6916009)(70206006)(8936002)(47076004)(70586007)(26005)(6666004)(498600001)(82310400002)(15650500001)(86362001)(4326008)(8676002)(83380400001)(2906002)(44832011)(36756003)(2616005)(1076003)(81166007)(356005)(5660300002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26a9fe1d-a323-48e2-1538-08d8075891c4
X-MS-TrafficTypeDiagnostic: MWHPR12MB1453:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1453B4E9E4EE852B306032BAEC880@MWHPR12MB1453.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGWGud76eAiQaS8c3tM5hxCPEdkd6eIB+qIvpS1GQayO6pIiR7NBqsibJKEQ1rM+PPHSS5gNqIvVnPLiP2uRi47C3xWgYXf8cJC/eN1Gwj2JI3YlEeHefbiOzp0XWJLQPJsQEZAGnwwQcdPSehqdhG7GgtBlG/JYYmeqMoftUlvekt5VfqGtYZWhYy6unRwh8j2zrYUaR0Dq3uX2iK6iYmSpxfaWA0y2sjtM2QcoL2UhBaYnryT2kHM6b2yws4Qm6THOyWDdluXFUYSDAmix0DesXdhWeK0mVG2ldsVPZNfPgEhgzXOdPaxLzDI9fjhkkNZQIvtJzZVomyhut7H/lBO6NLyVygChWvpKy0+e4BDEweNPcteBzdDVrXDNTkjaQif5O9Q8XikouD01z/6hhA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 00:53:45.4939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a9fe1d-a323-48e2-1538-08d8075891c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1453
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
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Whenever we switch between tiled formats without also switching pixel
formats or doing anything else that recreates the DC plane state we
can run into underflow or hangs since we're not updating the
DML parameters before committing to the hardware.

[How]
If the update type is FULL then call validate_bandwidth again to update
the DML parmeters before committing the state.

This is basically just a workaround and protective measure against
update types being added DC where we could run into this issue in
the future.

We can only fully validate the state in advance before applying it to
the hardware if we recreate all the plane and stream states since
we can't modify what's currently in use.

The next step is to update DM to ensure that we're creating the plane
and stream states for whatever could potentially be a full update in
DC to pre-emptively recreate the state for DC global validation.

The workaround can stay until this has been fixed in DM.

Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 04c3d9f7e323..00a4f679759f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2523,6 +2523,12 @@ void dc_commit_updates_for_stream(struct dc *dc,
 
 	copy_stream_update_to_stream(dc, context, stream, stream_update);
 
+	if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
+		DC_ERROR("Mode validation failed for stream update!\n");
+		dc_release_state(context);
+		return;
+	}
+
 	commit_planes_for_stream(
 				dc,
 				srf_updates,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
