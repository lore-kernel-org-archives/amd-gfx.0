Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF43C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA25610FC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA25610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC0516EB84;
	Fri, 16 Apr 2021 14:34:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD8A26EB82
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXBYGYS62eg0J5mjy9PW/PbKCPAqmH8cxp1Hbf7nZ11K/ILX4C8GIsQrjPD6kZ8jwVUN67aDq+rE5QEz2Virm3szk5gYrdUnB+pkZza5b2x6cH0EGYyFxtq+aZOc0eoBBrYyrFyxYOQ0EGmpLtvdZeCBenORfeuGRi4IUYsbwopFDcTWgbdEbTF0/rEG8vov3PDZ4z/oNhoE1YIPFE770giiAcsWGLgXkFn3KQhabYobZZ5Cz7E5DA8JXi2h0uQv1oOQjoD9c/GcTolSRsQFjpgxiS0Gpr5q3xGI5TqIZ/YvjpT6qtjZFZbc+3PzIwt8ue+qsj9uUmogc/Fw7gIByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMUStAVmC3tDgqBxMsmiDamlqgrvPtl8eOwL2YZOvlk=;
 b=Pz1I9S8eUwem6ps+0Vr9UNncNKN/LHq9cqHg1Ul/h4jkAPYkpz7Px9VBdbnNqkX3WHxNU0FE1d3wTQtNuOda3Qcmtde3/NqBpVnx7d/EzH0qtAFEFsiNYDpiGhYdpa+vm15WpeuPGRvt7TkqfpkY9sKnSeNkA53380N4B1ZcAI3XU7mzp2LZoAp09m8qGAMb0wJTYkhElVTZaZhKjpagov7wyFhRgooNF65R5L7gviaUO5AEX9dKJS9dyokenK2RFq7ZVPCq7lp4jtR4Ikfl/+FLABBigaciyMHgdb21qkzb7A2vwFX/PYyvbOrRxAdQsEt0WLSZxZ+r2ush/o66ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMUStAVmC3tDgqBxMsmiDamlqgrvPtl8eOwL2YZOvlk=;
 b=HL0PWUoGpmoIy36zee5bG81AKoLpWgvj4wgWfrC+/P/OEzr1Ec+QdK30rR6tQV+FjFEsTNygrqMl7Jp/dDf3Wsq5ZXUNiWyLsUdnOSYczkTPI0NZs1nmOkAuAV7HZ8NvTpqgYdpmuDc9gu8JlJDFSi4HV19VNVr1eetYctVeUIM=
Received: from DM5PR12CA0016.namprd12.prod.outlook.com (2603:10b6:4:1::26) by
 MWHPR12MB1392.namprd12.prod.outlook.com (2603:10b6:300:14::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21; Fri, 16 Apr 2021 14:34:25 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::c3) by DM5PR12CA0016.outlook.office365.com
 (2603:10b6:4:1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:25 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:24 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/19] drm/amd/display: Add DSC check to seamless boot
 validation
Date: Fri, 16 Apr 2021 10:34:00 -0400
Message-ID: <20210416143417.611019-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4f2c51c-9e8b-434d-1ef1-08d900e4bc1b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1392:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1392F6AC4D70EB4C146D4D658B4C9@MWHPR12MB1392.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5GQm9CM1j2ATTFVfKKq9yRuHI/3hr5wkHQWQx9UMFSYPQpcP23j66nE3fMbwcN9Ez2akLMQDpTJdhdIeJdxNc8nCvntnCw5VZQhqRGr4TrnKQdhOPF2xxkptTN4ZWYRF+GKZI6eQHSJoQsQ7+LCnL0D95YJSsJf0oy8fTeJyJMd7FBxP1hOA7Iyp21zK4tL//xdFGC9yQB6Vux/bJfALKIAtbVTqQURSu3RnSpseZOML3HIf8ralKWHa72HdVrIfC3SAe1smBrvBWO/a+jzUf0n+ddZNJDX4oH2QHBx5NL9gI7erxV+jOfhWU3psL/6kCL+z2GFMnCwgOLmk8v6xstEYrvAXynJ3yAuIngupfHwD5vFMxkgiOTjK/l8jmfCM3cxfelHFXlEOhmsTOTFBTXWYvoLMh0tuBpP6vq4MfYySsF/iyXzVS70fyCOpF8atS6symVOh0AlTmWCMN0wq0u9c4/hHl0OmkaWNf8VJRnRpS36aoKM1VSOpUYXDAM3/WYPefysI97OwlOCycdGUOzyWa1tIq4Tbb0dqB/xeFL7rx+MaVrDjaKH1QpwZcOA1esQ8dRT3i7nSx8iRiNVFi283oai/pY8d7kL/UQKoQ5NEbpnKeoSzRNRHoitJ+UgPtRh6ek7LfHFO4/2V/6Hk7cFEkNOl+ygJN/rJ7PNVg2lgYNT55WnvEPTBqnlDDZf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(46966006)(36840700001)(6916009)(8676002)(70586007)(186003)(70206006)(36756003)(7696005)(336012)(8936002)(316002)(44832011)(5660300002)(478600001)(36860700001)(1076003)(54906003)(81166007)(2906002)(86362001)(2616005)(47076005)(426003)(4326008)(26005)(6666004)(83380400001)(82310400003)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:25.7023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f2c51c-9e8b-434d-1ef1-08d900e4bc1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1392
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
 Qingqing.Zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Anthony Wang <anthony1.wang@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Wang <anthony1.wang@amd.com>

[Why & How]
We want to immediately fail seamless boot validation if DSC is active,
as VBIOS currently does not support DSC timings. Add a check for
the relevant flag in dc_validate_seamless_boot_timing.

Signed-off-by: Anthony Wang <anthony1.wang@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 757820a3f068..724ddce8aa41 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1400,6 +1400,10 @@ bool dc_validate_seamless_boot_timing(const struct dc *dc,
 	if (crtc_timing->v_sync_width != hw_crtc_timing.v_sync_width)
 		return false;
 
+	/* block DSC for now, as VBIOS does not currently support DSC timings */
+	if (crtc_timing->flags.DSC)
+		return false;
+
 	if (dc_is_dp_signal(link->connector_signal)) {
 		unsigned int pix_clk_100hz;
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
