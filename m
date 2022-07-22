Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC188C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 365C593A2F;
	Fri, 22 Jul 2022 20:40:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC2093974
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K27P7kovMl56PJR137NpaSg342/pnI/bQk0thMvpk59sN/ckU2q6FWYX9sC3q5gzk7dAPMJQ1qOdm4USQwu0VDiG1G06WwyYDZxncM4wtwELCaiXZBhhDYwkmZJtY1NZIqXL2RfoWLBT7t61nfodXdlNeUimdGicDOoDyadh8kGqxcdO+cwLX4rr/NJgA9jP6LJPkQd5rAqF1/Rj8aNcFd6Pfq0JDZWd62GCgsYi5Q3XI3TJHT1kWYszYSo5+OxZcIhjacv/yG5/mhOHYTCaB9CKMelYKGo2WyzYFpEmZFiY2ZCFOME9z/7k6e+6kMbY4HjcL0zvP3OKRR2pE7hwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flRmyrzqb2YLnUqqi4XGKfKCm7AoFEiat2XA/2e7ouY=;
 b=iToNWpEiW8cvATvVJMjGdFTdyDwDTOkygoO3Tn0MZ+6GOa0i0i0V9IN6qBhQ/Zdr+AAauzGGpSob3dS5FNGjF9cxS8KTtpAuyQiIKGbtsmtLSMTnb9ZREI+7R1ZI1CUPMxPB22dHqclNzIPC3mIfTmFEA3OdcZMuL6oP/Og15ABbfAwXHOP3Ae+uVBVUXM0YJQNAvfch6UUK32/yC8XFhwnyeaD5FfsNAHe9UY3Y7ArRJoLFapdou27DXTHB7jrUOhd8u4kNQDQoQI20RqVgC2jEACsFopqr+Sf7/dJmQkap2/YFH15UlB50gfTnoeXi/pZLGPL/gpdgmbyvM+2kHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flRmyrzqb2YLnUqqi4XGKfKCm7AoFEiat2XA/2e7ouY=;
 b=KryGNqt+2oF4oXRkrtU9Tj4nOPpj11asWmt6xkSm7u6tCoRWAfQxELpb+dAYkjykbi4D68xtz3+UWdBZUU4eA79R6G65GJZcJBkLQji63DGn27CBFuG/u6sK8LHl5xz8M3WnQC9qTgzQQfBBbMOx8GZTyk/0GXd4xFS+TSIOpec=
Received: from MW4PR04CA0054.namprd04.prod.outlook.com (2603:10b6:303:6a::29)
 by BYAPR12MB3159.namprd12.prod.outlook.com (2603:10b6:a03:134::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Fri, 22 Jul
 2022 20:39:56 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::9d) by MW4PR04CA0054.outlook.office365.com
 (2603:10b6:303:6a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14 via Frontend
 Transport; Fri, 22 Jul 2022 20:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:39:55 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:39:51 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/31] drm/amd/display: Fallback to SW cursor if SubVP +
 cursor too big
Date: Fri, 22 Jul 2022 14:31:17 -0600
Message-ID: <20220722203137.4043516-12-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d277e358-ed60-43c7-deeb-08da6c22566a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3159:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UnvBDTMOsZLZ5lUBZkrWyvZ+X63ClJ3UMqZqlbchxMUYXlpjasps2Pz18/Ztksm711mVneHWkcd5xRIHXrKzoWEzk4VML9gcMqy16YPCIkpX35UWlDS8VWksARQdCQmLQLtLhecKyWL2sSOASu3oswDFAoTItwd7iwocw4HnMRyBxmXXPuwmbTKMQ0ipy1W5411YtAFoPkr7Hg9Qho1Acp7lCVCHW4fHGJoubGCZ8PJjPOrZAJNBNtgfhYxbTnOu3qAcF1MgZgkF0shpwJ2ZWSWZGpdjj4kRxUtqxTy0p4eOeTMe4ljziwwgvwBlf0KuX977NuBhdaIrm4OsSYFOjXdygxGDK4aU8WZZ8Pbt9Ow1YsQyNscZs/zlasi/uouZ+chVYCXkfli0MvQLAeiCoWxT5r7XzJWiOwnuNfQxYfvzkbi3rAoX7by4qG9sBRfi6Pl3JNN+KhM8MIWgEsV3N7Y6ucirpTnI5sQHAl/CPYI91EZ7l90tyLNPnoM7A4F/nyf8pN35K/5vV5oweXCxsclAyknLrO0H+/eWyZLmhbe3qOp88e24PNuPHjRBWGtQt2yNcw27+Bts5wgy27cRhzjmUlTBLETOzXJMaxbAscLVdgUMZlqWNOI5jMeod0tJqRWSxsr0B1sEmZtna25a9WGSG2r0Z9pntGug4QGJGO3MSdRGD2WdrO02bYnCg0jBxPwDhI5oQDzouCgRt0Brb/89QoDiUY4sLyEizP1Z1s9MQDqLDpoSJvGFlMh7TCWAj2Nw2tyoAmk9hlNrO8HQsE7AifKF2OyQci54qkpC9j+CYjC6AIiCyIO6Y0BkBlEQ+mE5N7/wSe35ya7DmSLssA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966006)(40470700004)(36840700001)(2616005)(336012)(81166007)(426003)(82740400003)(36860700001)(2906002)(47076005)(70206006)(186003)(356005)(36756003)(70586007)(40480700001)(83380400001)(16526019)(4326008)(478600001)(8676002)(26005)(316002)(86362001)(82310400005)(41300700001)(44832011)(5660300002)(7696005)(1076003)(40460700003)(54906003)(6666004)(8936002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:39:55.9003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d277e358-ed60-43c7-deeb-08da6c22566a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3159
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- For SubVP cursor cannot be cached in MALL, therefore
we will switch to SW cursor if the cursor size exceeds
what can fit in the local DCN buffers (64x64x4)
- Returning false / failure for set_cursor_attributes will
fallback to SW cursor

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 6752ca44e6e0..f62d50901d92 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -328,6 +328,11 @@ bool dc_stream_set_cursor_attributes(
 	}
 
 	dc = stream->ctx->dc;
+
+	if (attributes->height * attributes->width * 4 > 16384)
+		if (stream->mall_stream_config.type == SUBVP_MAIN)
+			return false;
+
 	stream->cursor_attributes = *attributes;
 
 	dc_z10_restore(dc);
-- 
2.37.1

