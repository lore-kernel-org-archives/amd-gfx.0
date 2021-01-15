Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399C0C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7693206D4
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7693206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3CD489718;
	Fri, 15 Jan 2021 17:31:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E64589718
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 17:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RojI/xqR5ruVT03Q3fpvsUq3/t9gl6d5CItQHtUD+b/2cRP9Qk0bLFaOVnUCqU+tVkhqZrq/lKMUAaPcwxg+qJLS9Uy9AniTGfg3LJgkyvea1uFEkfVzXLfpE5tED8LRfKocw9dNAlhYNqZk49HgsqL037hnZzDRDOoT3wGsfFZpWvyxY2r4cuEyi5tnbjcxby+38r9LXJxxFsVficf8Y6DzAg/mkdOpbuR7vzQd+Y7WL7RbwZMn5c//mDQT0lxhwe+ARw8XCnYzgs7Nxf6goqRBIn6MgAmERbkeYxS+XMNkpo2psEJElsuOBdZr0ZsfwGBBBkfotvB+hAgVkDkGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=up7ryVR5zrege6npaW3S1sHK8uSHj91wZkqVujQ6YN4=;
 b=ctWRh1nUzf67lsI8DJvh9MGECXcL850SZidtJwRLZcxyF9ZAdwgRMAA6mp32fYqdmOPMY+k3Unh7TQGMldAcs04IpboAWBvNWlF4oxJedD0YHsOOOFgPFjpg+glC3LP5rKL5zv+FzkjhiqyPCIgNoPTlzCVmGi9DTFFbB6WR0lNAKqsdSJWRu/sOB+SMSeto7gTISADpZ5MZ7VtBhUNGQovh5P5CGvsijc5Qjb71ESKogrooKg9pGwNEGZwkIDlrqzzYNGKNaEBJNg5dq8BnvqNAAJ0wfZ8R4QZ7KVh/g3Hq3S1WNvhzBECZAVo6N+LTGHnMk3dY1lKo/AfcKlGZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=up7ryVR5zrege6npaW3S1sHK8uSHj91wZkqVujQ6YN4=;
 b=K7errzNJ0fIJobJmBuilvKtF/6+tY1abhrkh+DwjNYDklMA3S3AqnECb7Q/yXr7UZWk+p5LYKWLjc6ax83fZItE5yOsuWAp/M3b4Nz42BNvmvF4kEtABqCet2zB9oCb4XoRUxqauMPHlM5LXW5a+ILnj9+VHSb/+4E5WTfUas2o=
Received: from DM6PR04CA0012.namprd04.prod.outlook.com (2603:10b6:5:334::17)
 by CY4PR12MB1191.namprd12.prod.outlook.com (2603:10b6:903:44::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Fri, 15 Jan
 2021 17:31:12 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::6a) by DM6PR04CA0012.outlook.office365.com
 (2603:10b6:5:334::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend
 Transport; Fri, 15 Jan 2021 17:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Fri, 15 Jan 2021 17:31:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:31:08 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:31:08 -0600
Received: from ajacob-ThinkPad-X250.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 15 Jan 2021 11:31:02 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/16] drm/amd/display: Fix reset sequence with driver direct
 DMCUB fw load
Date: Fri, 15 Jan 2021 12:27:10 -0500
Message-ID: <20210115172714.126866-9-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115172714.126866-1-Anson.Jacob@amd.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b74e6a2-c5b1-4872-0ddf-08d8b97b596d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1191:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1191A378D490EF4E1B741AF7EBA70@CY4PR12MB1191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlnTp4vY599jlVodV7kvw6OhTFxbjt2DK45Kv17vDo8wu/KJdHFwnbJ7DXzZR1RDnRiMSffdzu3JQxe7QsqFCap28ofst3dQbuGJNJs73RA2SW4YDgzo5i7H0AZha4A+yE28H+yoLeuqhMUT8rlAXH2mRljO3khicMAWTIphX82biH25wU/YGpQQR6aQXvknPky6/9TxNgNI2DZRvl85F/zmElTVxyN49vy5JRHDu/47GaX40pxq88DoOBkamFYrL5T9lcLFh8cHYGJ7+d0LX9DxayGIzsoK/VQ7PIApJbMo+pumJ1jthhiMdGTkpcKVmbeJfYsX4isvsWXMUKr5/n3/vl03htrT1VZJceT8IWFUbZzGlYtz/72gDOkvlNNMiyV0pHTi+ERXt+jXKZKZ/gv579zZXeJvPZSotf1rxmblU7CU36sr+OZXuTTQHqtjrM4btLchfvqHiJbEDVySCr7DiREgh79pEMUFqajRWteJVOTiUsqGxCSRzk8eNQ7F
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966006)(336012)(26005)(6666004)(1076003)(426003)(81166007)(186003)(2616005)(8676002)(478600001)(54906003)(70586007)(36756003)(86362001)(83380400001)(6916009)(5660300002)(4326008)(82740400003)(2906002)(8936002)(82310400003)(7696005)(34020700004)(356005)(70206006)(47076005)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:31:10.4380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b74e6a2-c5b1-4872-0ddf-08d8b97b596d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1191
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
Cc: Eric Yang <eric.yang2@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson Jacob <anson.jacob@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
DMCUB encounters a page fault/double exception with driver direct load
because DMCUB is not held in soft reset after releasing secure reset.

The clean shutdown sequence via GPINT is also not executed in this
sequence which leaves hardware behavior in an indeterminate state.

[How]
Move reset earlier in the sequence.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Anson Jacob <anson.jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index d2588b7cd325..61f64a295f06 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -406,6 +406,9 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	dmub->fb_offset = params->fb_offset;
 	dmub->psp_version = params->psp_version;
 
+	if (dmub->hw_funcs.reset)
+		dmub->hw_funcs.reset(dmub);
+
 	if (inst_fb && data_fb) {
 		cw0.offset.quad_part = inst_fb->gpu_addr;
 		cw0.region.base = DMUB_CW0_BASE;
@@ -427,9 +430,6 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 
 	}
 
-	if (dmub->hw_funcs.reset)
-		dmub->hw_funcs.reset(dmub);
-
 	if (inst_fb && data_fb && bios_fb && mail_fb && tracebuff_fb &&
 	    fw_state_fb && scratch_mem_fb) {
 		cw2.offset.quad_part = data_fb->gpu_addr;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
