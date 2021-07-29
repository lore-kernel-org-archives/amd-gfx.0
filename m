Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DEFC4320A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D9660F46
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 35D9660F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DED776EE5F;
	Thu, 29 Jul 2021 20:37:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 568826EE5E
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 20:37:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqI7FBrVHElh9zSHNGF01XqHwym02CemTnw4iCcXTJmtkZvvZpU/puoSXjHBdliHZuxzayAvjIfhuKQC4vF6D9dzk7j0DkVUevifeNjRtc5tle3gkfFw/DbLpoV85kSsy1ULWjnWuJHf4ZXz6d+B5/Cg8+/7JHzKd/JiaRBggpIEZcR0SHjOG0jbpxk4Tj52eVaJaGdAOvdrczoHA4yNIoKiWoZMSCJR9WC95hlMG4MsxvKyuxQCi+li3hihdzG6Xu6TL+X0EkWkmYdo/RbU5/N3miis2CG4zJH7P3M4EVxT7PnGgrLYkLd35WtkPGUVvwqp1ERD4o6GGwPrhG+upw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DanYyiZAl/VgYfFXSBh3ygV2vizv2+KmYYvKLwxXNkw=;
 b=D43v+v7WuZ9qtPLYkmYZ5WBHhSfdQs+Fcd5HSdf6vFwroXt7KR5YZJXaWBxYMGdXpHPzaasLHCXmq4bivAOgealWma9HSYKCMvBA5uW54n1ILenSn3lCUtJDHVmGMmopYunM3bJSeYXj/ftIF+hEWMj8ESPcce6Rp8Pwrdrvd6c/jVF7B+OcYIFcnvvqyTXLqXvGdwbvh95b0TXzWD7NqIt64AOtD8LDa0RITGYHf/cGk7wEqc+vSix4yVZ+8madAErdKJ84abB5qNcWKx5VN2SSnyWl1RYYBZBgVrdxOzTqlOV2SxyfrRmuwrOqxxRB5K/aXidRjuVAF5Soib4S+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DanYyiZAl/VgYfFXSBh3ygV2vizv2+KmYYvKLwxXNkw=;
 b=JfjGb8tHd2qK4mlbQ63JP6S6iigzjHFJGMNnO4EuPkNnIg1Q+6rHdovBdUcqWok5hAcLSz1kvyD00uh3oDP33L7xgS5UBSvU6RjKTc1xGqmhvGkBgu/DxnYgk1iQkO+3PbRtTVojyjAb4IyX0yOysi8xUvIoQ0ShpN9kySL4OBo=
Received: from BN9PR03CA0202.namprd03.prod.outlook.com (2603:10b6:408:f9::27)
 by DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 20:37:23 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::d3) by BN9PR03CA0202.outlook.office365.com
 (2603:10b6:408:f9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend
 Transport; Thu, 29 Jul 2021 20:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 20:37:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:37:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:37:22 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Thu, 29 Jul 2021 15:37:21 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/9] drm/amd/display: Fix resetting DCN3.1 HW when resuming
 from S4
Date: Thu, 29 Jul 2021 16:37:08 -0400
Message-ID: <20210729203712.1566129-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
References: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7be0b9f8-5a86-415e-f166-08d952d0ab7c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4075:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4075465B5753216F6C3D49398BEB9@DM6PR12MB4075.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: koM0iJ5UBnu1XU9YcP+GdLyrxQ2ulGKFzq7f+zaXfTHiaug0uX68Au+Fah5LNLj2w7FyzOqlyWv74KUWnwJeMyJLQKPMxxlBHFXHm7nwvgEeIhi5j+EoraBXAzX0JFL9R3gFsMNuq5+larXyb72/JK53fctzO827YtETLila8f51Z0FzdngE/YB4FkcqLGXFF2M8ZXAk2g/ezy4MZ8gWeXcDIlirOYyz+lSYbx3xSnjqjgQCZaXux4PdDCvqjzI3RdzKTkDca0/A3Z6iDrpOWsVjCAdi/kAJTiWsV1Ia5+cbRv6TeMSijhbLcZMrjrvf6FEiaPV5Xd3Pq5NgBVdT+C1w+R5c1O5mZiz6AYcjQmL4GMnQpgXyJa6J7ltMx+rZmylG3aA8ya0RIFQICIm859tpWKdOyNyY/vXfWn4N1P4wgVmNd+zpejuP8Gr3wvsHbKPBuJOvXMirfGPILirwF/VdAASr0bav0F3SSw8SOYzdc66gIgaMtybpiaoq6rTR31w8HYhfGkGcaG9gP4aWlOhlHVkWQyPTWMwsWoV1A1NYzZpA1D263qpzHyUgn6GRZ52iEtkxuf1rO8bLapMr63AZxFCChqW3p9UzwGmDH1VO/7l+pB3dLp47zX5IqkgKMtrzT89RYMnlcXnTOJxCuS8lcdLG+KwetDqMPgqNR1TwBPax0ULgSkATz8QUm1XjV2y2qaUxDUQR52nAWvuFGRTmnEhn5LvHbZDgXlZgG54=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(4326008)(81166007)(70586007)(36860700001)(6666004)(426003)(26005)(8936002)(2616005)(86362001)(356005)(2906002)(316002)(8676002)(82740400003)(70206006)(1076003)(186003)(83380400001)(44832011)(82310400003)(336012)(6916009)(36756003)(47076005)(54906003)(5660300002)(7696005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 20:37:23.2953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be0b9f8-5a86-415e-f166-08d952d0ab7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jude Shih <jude.shih@amd.com>,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jude Shih <jude.shih@amd.com>

[Why] On S4 resume we also need to fix detection of when to reload DMCUB
firmware because we're currently using the VBIOS version which isn't
compatible with the driver version.

[How] Update the hardware init check for DCN31 since it's the ASIC that
has this issue.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Jude Shih <jude.shih@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 61446170056e..6820012e3b6e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -270,11 +270,13 @@ void dmub_dcn31_set_outbox1_rptr(struct dmub_srv *dmub, uint32_t rptr_offset)
 
 bool dmub_dcn31_is_hw_init(struct dmub_srv *dmub)
 {
-	uint32_t is_hw_init;
+	union dmub_fw_boot_status status;
+	uint32_t is_enable;
 
-	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_hw_init);
+	status.all = REG_READ(DMCUB_SCRATCH0);
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_enable);
 
-	return is_hw_init != 0;
+	return is_enable != 0 && status.bits.dal_fw;
 }
 
 bool dmub_dcn31_is_supported(struct dmub_srv *dmub)
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
