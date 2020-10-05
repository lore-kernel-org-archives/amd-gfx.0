Return-Path: <SRS0=m9pB=DM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F06EC4363A
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2020 18:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980F120853
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2020 18:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V6IWCSOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980F120853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 585B98982C;
	Mon,  5 Oct 2020 18:10:46 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700050.outbound.protection.outlook.com [40.107.70.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5DD28982C
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2020 18:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y14AgCPR9vFIkrGKpzTal9XlJEamWX/mE8NB2NyiP7a9CjxHBnYNGIHktC7DHGKI1Q1A/Xvyq7ItFLYitQ55P9VMeod86dh4kH80uW8VuUP4Pou/u5hfmSn9QIVIN1y6vuwprTGoalUyPK1qk6lyKVfCBSbyWlK4KEfXtzNqISvt1a7nYtaWbpubUJA+mPLJVdYc6asaWmSkmN2nqXfREqFEqarmbRa36QQ0bwyPoI9BM+VhJUVVUoErRMLOBqGdruOWUxlmx6+XZHI9Jrf8RKZO1+sfaGinaO16mq5sT2eZj5rOmvn6TEnX2lH//iTDXihU53gZ5ckqYRU7sZWiqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6iVC4gZONNRWxApJen4uh5aVyQXrmuMXXn3fvzhd7Q=;
 b=QqOFQFdONGTMZ5ieoNa9iRZHV6jYdi15JSKAzn+0ZM07B78Lcu1UHWBKByk92BB6+6WqMaLUXzN/wrSnOFzrlIj2TjSp7KGE4JIhyISbk9mbCsmWgoDtVVXI+YjB43affGqM99Nkp++a+rqCaKefmZI0mJ3+bWcvUiS4CU5bboHpQhMw/6849Oa3QJj2WGN2OJiSOabfHcWMMH39xue4LDsc/IS68FC5izckZf2HiNlYbsJdO0nYYvepBSavvCk39U2pu3K7YQ96yayAmkX2LmGxvBd72sasfWYfgBui+nZa/oCrdmhlNIcJpgZLB6PsYuygXZ6XFQIBOMkmxUy3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6iVC4gZONNRWxApJen4uh5aVyQXrmuMXXn3fvzhd7Q=;
 b=V6IWCSOhZvQTq8QC4Kypu+hFQcCmv2mYamFpbRooWujz1zjdSu6Bk1sJbgSwAJZVdXsdZ4+mBF/kjh8/jNapSJbLUfNRaSzsHaiN9mAg2wd6EKOYj2uvKZoPKEQk3PZKd8gtDhz4XT3wFaCA7o1Ur3bGUWsCNEkrefYpXvq6jNY=
Received: from DM3PR12CA0123.namprd12.prod.outlook.com (2603:10b6:0:51::19) by
 MWHPR12MB1725.namprd12.prod.outlook.com (2603:10b6:300:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Mon, 5 Oct
 2020 18:10:42 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::8) by DM3PR12CA0123.outlook.office365.com
 (2603:10b6:0:51::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend
 Transport; Mon, 5 Oct 2020 18:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Mon, 5 Oct 2020 18:10:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 5 Oct 2020
 13:10:37 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 5 Oct 2020
 13:10:37 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 5 Oct 2020 13:10:36 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Add missing function pointers for dcn3
Date: Mon, 5 Oct 2020 14:10:33 -0400
Message-ID: <20201005181033.1267385-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cd2953e-88f7-484a-0f7e-08d86959f8cb
X-MS-TrafficTypeDiagnostic: MWHPR12MB1725:
X-Microsoft-Antispam-PRVS: <MWHPR12MB172597B9E8C9E952721ABDEAF90C0@MWHPR12MB1725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:230;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Gj6FekdxYJCmMuALzYzEz6Et3n7Z1piZkLoTYtImmIqUeIJT0TKL9+Hqy73H7Ub7aCVonvIwq/AY2q0NnuDBy3/YxvWvMeLz9c9zOHc3JT0dqLVF+AN/J/sOmFfG8ZA0k64KbF5FEFEhpKeeDGrVF08mZKZtjMIEv0s+KN9eqi2fBs8R537fyvCAgRK2+/JU6c6bABqb5Oj9DoGY5kZ1BEq+fAgF0zyogzUAujRrcnddMaWYeywSZcxZQofC6aqr0muIj7mE2THnfiJAJTVVjTfLqrUg8ax4kVNCXZ3ZKjOn3JHyhX6X5WLl1i0UYlO08yXJLgZ908UkghSkmMpZua/EwK4iEspx1FQwkkZiSW0+vPlJ8HNSALjl3bLIDxFxd6dLJGunXiOUL9VgTgg8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966005)(8676002)(6666004)(8936002)(478600001)(426003)(336012)(186003)(26005)(2906002)(82310400003)(1076003)(83380400001)(82740400003)(6636002)(2616005)(316002)(5660300002)(54906003)(81166007)(36756003)(110136005)(86362001)(47076004)(356005)(70206006)(70586007)(4326008)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 18:10:41.9078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd2953e-88f7-484a-0f7e-08d86959f8cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1725
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
Cc: rodrigo.siqOFueira@amd.com, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These function pointers are missing from dcn30_init

.calc_vupdate_position
.set_pipe

So add them

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 7c90c2222506..dc312d4172af 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -90,9 +90,11 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.init_vm_ctx = dcn20_init_vm_ctx,
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
+	.calc_vupdate_position = dcn10_calc_vupdate_position,
 	.apply_idle_power_optimizations = dcn30_apply_idle_power_optimizations,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
+	.set_pipe = dcn21_set_pipe,
 };
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
