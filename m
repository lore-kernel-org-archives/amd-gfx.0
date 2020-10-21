Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FAAC55178
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEACE2224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PO0Ra6Hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEACE2224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 533C26EDCA;
	Wed, 21 Oct 2020 14:23:23 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700083.outbound.protection.outlook.com [40.107.70.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FDB46EDC7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWIHgzyVwUs680cgo/7kDltxCjVSl3OJVT2oyNOtElo053rRCYgjCxHaaELKbdDMv+XWgK3KfiU5ELtrpI8tBhxAhkBB2GlR7OO/2yTXjqgUSlb56L7eJsCLxA26P7MOpA6pBzqDP30RSNg8PBcw9Rs1Xi7nHPYB/KzK1L6uFbrQactKQrDMKDYjC2kR/YphiuLfwOBkf9UdSxqY7ZjiwPUt4pCxq3xUsegX7qn8Rd8Hk60p0iBDhjfRzoIDdErTZ4zMxIq1UOTfvQUE8hY432qOt9yZlbNyHm+K1GcqHXe84Mie+GzFFgHHrftgmmzSQWZBd00cy9fg4MNDJJMaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOgrf9Hq4sXE3rxm25Dq1Q+0TkZoglTk9fw7imLVDP0=;
 b=FLn1ilU8hW3L1MGZWAwXfs2D3Yf2eCd4EdKbE99cF2ZDlIhrI0DYzUeN0YYQ/XuPh5S0vxE5gUiegPodHLRMvZ9KY5eAKg4nque7tNTrZAD2tAmmP1P3Rgy+x05ALGodv4YDpmNTg1IGoi4TTBSV2sfSQ/caw5SfmtZXe4Tzkphk72ywCUUQKGtOybk5oCw2CxwKCoTNXC8gypygh948SAiQXHzMjL89fYrV19Un03QpA+CfrDZw7tC97wQqhlbHK3AVUhGwUZ5KiD62qBN2qyXcHGbuwjZZcKMtoePYATJrEO2J3deTQl1BbDRUaHw1Hu9hrL7lumWjUHf6zdbiNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOgrf9Hq4sXE3rxm25Dq1Q+0TkZoglTk9fw7imLVDP0=;
 b=PO0Ra6HpKduufrhXjxpzpWwizZWUhav75nhwIU95PheV1ifo3rAq46rFC+F9uZMMM5TDlpyaAIBINE+Iao7iRFhyrQh0LLjhnsohtBKy3RfbH5FxCQxmkI6AnMrtg5RsUIwAs8EBDdjG8lMH5nkMuhCP/0lEMMc6zdlGOkfTGmY=
Received: from DM5PR21CA0019.namprd21.prod.outlook.com (2603:10b6:3:ac::29) by
 MW2PR12MB2474.namprd12.prod.outlook.com (2603:10b6:907:9::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.27; Wed, 21 Oct 2020 14:23:16 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::c9) by DM5PR21CA0019.outlook.office365.com
 (2603:10b6:3:ac::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.3 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:16 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:14 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:13 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/33] drm/amd/display: adding reading OEM init_data to dcn3
Date: Wed, 21 Oct 2020 10:22:37 -0400
Message-ID: <20201021142257.190969-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1432b243-b0fd-4601-e5b6-08d875ccd9e8
X-MS-TrafficTypeDiagnostic: MW2PR12MB2474:
X-Microsoft-Antispam-PRVS: <MW2PR12MB247460F54497DC10229902848B1C0@MW2PR12MB2474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:257;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DzKQ/6aVcF7d0PweBYibwVlOWN2gpvlKLdZ1D16qPaal1BVbC6Y8HkxI7tVGFVlflxTEJMaN8VsbErf3ZA8tVX4dWJRB5hd1nGevJ+vbF9zomEUOgE/8V0hQ6/6+q6cqRgLM+nU6dRM7+ae7q7VRt/SgoaPHeAM8/mOcehc4+m/7Rk+WT98kXOAULldTCqwwUIgAC8LTwR2PBAECQgzErNEW28/R6h6H5Aq62rjC7jytrpaQqIYFZ6CPQdo1w3bxUznPWcLc40FK/Uh3q0Baxb7L7N7ybzhVdnkTLtqMHwMTxCrHBmQ39o5R1DkCBO49oBn1Oo101HmSn/uTjvuLqxaeTj9NUt/6vFpWiZLXDj62p06qZeLD/fofOLjDWB6y+n3YrOEkTYp4Vo3oarGbhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(478600001)(70206006)(81166007)(70586007)(356005)(1076003)(82740400003)(5660300002)(8936002)(2906002)(4326008)(6916009)(47076004)(8676002)(2616005)(6666004)(426003)(82310400003)(26005)(36756003)(44832011)(7696005)(186003)(54906003)(336012)(86362001)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:16.1682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1432b243-b0fd-4601-e5b6-08d875ccd9e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2474
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Martin Leung <martin.leung@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

why:
missing OEM data to control graphics card functions

how:
load it into init_data. copied over from dcn2 implementation.
copied destruction sequence as well.

Signed-off-by: Martin Leung <martin.leung@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 8a4eb8e1386c..ec04d55d87f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -60,6 +60,7 @@
 #include "dml/display_mode_vba.h"
 #include "dcn30/dcn30_dccg.h"
 #include "dcn10/dcn10_resource.h"
+#include "dc_link_ddc.h"
 #include "dce/dce_panel_cntl.h"
 
 #include "dcn30/dcn30_dwb.h"
@@ -1321,6 +1322,9 @@ static void dcn30_resource_destruct(struct dcn30_resource_pool *pool)
 
 	if (pool->base.dccg != NULL)
 		dcn_dccg_destroy(&pool->base.dccg);
+
+	if (pool->base.oem_device != NULL)
+		dal_ddc_service_destroy(&pool->base.oem_device);
 }
 
 static struct hubp *dcn30_hubp_create(
@@ -2589,6 +2593,7 @@ static bool dcn30_resource_construct(
 	int i;
 	struct dc_context *ctx = dc->ctx;
 	struct irq_service_init_data init_data;
+	struct ddc_service_init_data ddc_init_data;
 
 	ctx->dc_bios->regs = &bios_regs;
 
@@ -2856,6 +2861,17 @@ static bool dcn30_resource_construct(
 
 	dc->cap_funcs = cap_funcs;
 
+	if (dc->ctx->dc_bios->fw_info.oem_i2c_present) {
+		ddc_init_data.ctx = dc->ctx;
+		ddc_init_data.link = NULL;
+		ddc_init_data.id.id = dc->ctx->dc_bios->fw_info.oem_i2c_obj_id;
+		ddc_init_data.id.enum_id = 0;
+		ddc_init_data.id.type = OBJECT_TYPE_GENERIC;
+		pool->base.oem_device = dal_ddc_service_create(&ddc_init_data);
+	} else {
+		pool->base.oem_device = NULL;
+	}
+
 	return true;
 
 create_fail:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
