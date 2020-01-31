Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32535C35240
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066CC2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n45BNMik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066CC2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D366FC4F;
	Fri, 31 Jan 2020 22:17:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D8D6FC3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdcepnPwMVikadTGpCWy2sxlZPhc3t5bHoUND/+9WhzUQE/HSbp4to4874rhAt0k5Fijf+wldaU4Tm5M64kTlEa21utbZMtThnUiVyg+UMA6TiIGNHYb8lHr/Ze4xhZPF03fA2bIuFrNjAWRyYrfRCAQHG7a5vQ7qTv1/gmVbFWrpOp9N6F+nt5wGdKtqAzMw9me47nEQ0clj4OZpVp4CRg+Nv/8vqt9mIM3o3/xCD26bAXcbgYPlwSffna2EKoqD6ko0Ad/YLUPPX7D6qtrseABflJocaFWijN5Hoi61gM6VyqXFHbCS4B+OiD/ApfCWDQdiMJ6yWq7UW4JFAlGyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be4fu0VCL3wzRwUR9cdIZ0vRZsZNng7pelPGFXHsHu0=;
 b=Kx7JMB3GTDSdyXF1T//Us1Eo4s7QvAIMWtn5Wgck+TAd+YgpKyjT7KvaGnkoZ9cH04tePYQIQdJjEerdWNiaf3B2kvZY2WLonptUQEnkDgMlqhRTAqY8DgvoJ+m+iJGPpahix9xnmYdD1bFyMTEicFGo4v5mSPmwD6zeLv0z5yBD22qiKc5TIxKqAguy/Xz8IPgw7Xwsr3SDwGEL5QfNGQdNrCBYft9gK/V33h8iFoj1Sv0oU2cpWRddMOICvK2llQX7PEK40UT3GRwkMZ/vdpYemQtN5YGTpUf0suiANMLC1Apyrd9ZCVAuZO/VSaLGOTGXu0Hi3OAarFoxMCLAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be4fu0VCL3wzRwUR9cdIZ0vRZsZNng7pelPGFXHsHu0=;
 b=n45BNMikTVZJwN7AYtcrZSgDxvoZQYXhdZynNGIewchj6CCaWJhqOfifiIai2tl6uvoqBqzLKG0xr5hdCMhB5RvkdVPzMZ15jX4dzvhGIwz7A2+ggr6e7gW+LxTtD0tDE+hWbtNv6Is7zFVz6sAXjuZFLssfmlemnp+YMU8F6/Q=
Received: from SN1PR12CA0074.namprd12.prod.outlook.com (2603:10b6:802:20::45)
 by BN8PR12MB3171.namprd12.prod.outlook.com (2603:10b6:408:99::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27; Fri, 31 Jan
 2020 22:17:15 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::207) by SN1PR12CA0074.outlook.office365.com
 (2603:10b6:802:20::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:15 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:12 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:12 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:11 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/33] drm/amd/display: Use uint64_t logger_mask instead of
 uint32_t
Date: Fri, 31 Jan 2020 17:16:35 -0500
Message-ID: <20200131221643.10035-26-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(39860400002)(428003)(199004)(189003)(2616005)(36756003)(2906002)(426003)(8936002)(336012)(6916009)(70206006)(8676002)(54906003)(7696005)(316002)(70586007)(478600001)(6666004)(5660300002)(1076003)(356004)(4326008)(86362001)(81156014)(81166006)(26005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3171; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0dea1f9-0e3f-409b-747b-08d7a69b53ab
X-MS-TrafficTypeDiagnostic: BN8PR12MB3171:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3171D82550E8CCD9B2112567F9070@BN8PR12MB3171.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T3Njdan8eWth5vNM94s3kEDli4b2GwDv0f1rl0m6d+rmkcBPhQPzY/s6Isj0NMuwtZpXDn5Q54zyE98d5HlUhyN49NBouhY1vEGTZRZQRnLP7SrrIYUIobq8uyYtd+woMYxWv4p0eAEBVG2hAEs1q4ZwZZ+825r33Zou6ebATB3U3vxQTtguH+8fUSbC3YSSjYYZGhPAFYcxzg116h1GWbDe1/H6k5ZKSzFqNQA7MSRf/Uua/ZxkprEJhKhC9p1Mh5pdP/J+nQLwbMhoorshH42McKVNyqH7yX+gF7jyrhAXFSPg37TReMvsa2YKhVnA5dUSZ7C8Igg8EhlJHEPSjkHCkdMSQDvH1ViJxv0v+ofI4tTJXZ/xhCsmDGaKeNZUSouOi3c7JoyhjRfVbJkWQa/koZFsH0g5G6YKLXyssC5d9HFzMMBp5Qf8NhybgSKJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:14.9671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dea1f9-0e3f-409b-747b-08d7a69b53ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3171
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 David Galiffi <David.Galiffi@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[WHY]
enum dc_log_type has more than 32 entries. User cannot set larger entries,
like LOG_DSC. Logs from LOG_GAMMA_DEBUG where being printed even though
flag was not enabled, because dal_logger_should_log check erroneously
passed.

[HOW]
Change struct dal_logger.mask and struct dc_init_data.mask to uint64_t.

Signed-off-by: David Galiffi <David.Galiffi@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6f94906968b3..c489a863f108 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -566,7 +566,8 @@ struct dc_init_data {
 	struct dc_reg_helper_state *dmub_offload;
 
 	struct dc_config flags;
-	uint32_t log_mask;
+	uint64_t log_mask;
+
 	/**
 	 * gpu_info FW provided soc bounding box struct or 0 if not
 	 * available in FW
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
