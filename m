Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FF2CD128D
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B02FC112558;
	Thu, 28 Mar 2024 19:52:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oXfpRPai";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E0B2112546
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dchV74xSrUWFT1MSVrnhkpP+JLN2oumiPI/knf/TNdPGnugCKnI6HH50KybXNxK1GujlFiLxVQ/6sUUdzJMMBvG75lTNpLtodwpXNFVkQjzJ0f58QTGigzvlw0MjA67vyucSA3hoHypbtrcWYwl+3LtDt5dL+4GsAxHWSjKuYbEAq4K1cdh8iAFMp0/rnM74RycXhsrD9wUAoCQqAx+eg6PmSVEl/M2e6JkJmwYkg+KCI3IY2DQDsjTfRrNoXSVV++OAm5g8EvDYSWkrGkWDbv2qbV4f+ti9Q/6uGDdK+Oa0UEIinpWb6H/Y3hxLGL9oeVHKe3fcLnc85IU5ZgHzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpXYSh9H3BQkDJaq5W8k39EA3L6/xUtkMgSqvBDMdpw=;
 b=m9ginF5V4OgYk86xdU7sqGUtVe8UCZeXZmB7IiBKTPDqAyIjj/IwK8FpqcAOL/yEL+rBE2xqyhIVB9kBAPgD0qHx9dPJ2IP5oW6efUhRQDNlE05jN/l0sLuYtiv7fh7Mb715CEtidSP7TYtFZBFfSpbMpXJQ773soAf2ZNjr4DMiGVCmok90b8OIvt7I3tJEz75Eb98WqNSqTD+j5x/OIeD/W19EFrFm7/gALL0tzlkmOPC7+Fj+PKxx9PAWt43KPWNfCMtZNFQXiyE6veUHH4YbMQLDoHldPLOeySzJ6JnuvkvYAXupVy1Njqh0sy4yj/JxsxCSdveusgHHZiqQVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpXYSh9H3BQkDJaq5W8k39EA3L6/xUtkMgSqvBDMdpw=;
 b=oXfpRPaiB4zGjAxb4oB673nBNJ+FWdry5d3AYsBcMLKeJsKJ8We0FecLkdytooQIoqVMfm38UskbD/eD5xxu8OY487hb9HmYbLS1XBinZndFcu6+3wuKX6he4EaKMy+cPJa0w8VWkgfvSTA90pbsAQo5kjw63G+c0ugDUWGY6Tk=
Received: from SJ0PR13CA0213.namprd13.prod.outlook.com (2603:10b6:a03:2c1::8)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 19:52:08 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::29) by SJ0PR13CA0213.outlook.office365.com
 (2603:10b6:a03:2c1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:05 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:52:05 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>
Subject: [PATCH 32/43] drm/amd/display: Update DSC compute parameter
 calculation
Date: Thu, 28 Mar 2024 15:50:36 -0400
Message-ID: <20240328195047.2843715-33-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7b1f56-0040-4cdf-3863-08dc4f608d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1gna5cKyDKj1yGmmiZuVPE4pJbqkCIyVx3OIEJEHOTxsUWXuVt4+gCtdJp/PtN3q4bgTYbcdrfrR5bEczx0n2QwQPeu2wkmVuJZHA9viw+rfdHMHqMj3qqpWedgal9srnQHgfi8ZaH1wgY9Z84uWHb8CrylWguLEG9vlUo31/rvdKfmhpXxNr47klwvsjZSIBGVzHbG1hbjCFdRK2/nJJ23880e5492lGgc7dBF4YNFsip5mSC7UTbfR8U1fcoJEmZJ8hkIIT8e6XG0qIIi/xYCiM11KjkSkDpcXVA6WjUZh89VZMR6mMJ7TXHRxXhCu4Xgm7rNLRMVQeskY5Ia8//gSTG8nls8nwALuSMz6xnqCH0UUYO9/RFDvy35I8Nwg6k2m44+2ys9pYAd3MDcsL/geP9lqR5MlzdCQKqOyyML2NYCGse5rDzKL/MirdXBUY8DSkwmDuOPtZA3rvWphMN6dEWQRLHzW+lDtjNU5Wx3xQ5iNOhLzqJdxXYWI+3E4NyO+IcTdcLDD5tHcaR0g9gd8GRW+tQV3xgbD9sJYqE4x8zXT8u9v6TOTIM/kbE0gehpWe1wO3yMv07IIN05J7atSOiziIQ9wz0TLVkZGJiY5F9amX+/uU1bfv7W+04CzptzeuCEC2cxQEpiBcowpSN+CrJQhyJfak6ozoNbCd/WW+F/pGjoAwu2BjcrM48hi2Ymw1RmFRlKo/leaJMsuNuuMIE0AMRxKi8HdtnjYM9jaXUrF34MPk9cVfPQyelGt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:08.1666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7b1f56-0040-4cdf-3863-08dc4f608d33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Adjust bytes per pixel calculation to use div_u64.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
index 36d6c1646a51..59864130cf83 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
@@ -101,7 +101,6 @@ int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps,
 {
 	int              ret;
 	struct drm_dsc_config   dsc_cfg;
-	unsigned long long tmp;
 
 	dsc_params->pps = *pps;
 	dsc_params->pps.initial_scale_value = 8 * rc->rc_model_size / (rc->rc_model_size - rc->initial_fullness_offset);
@@ -112,9 +111,9 @@ int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps,
 	dsc_cfg.mux_word_size = dsc_params->pps.bits_per_component <= 10 ? 48 : 64;
 
 	ret = drm_dsc_compute_rc_parameters(&dsc_cfg);
-	tmp = (unsigned long long)dsc_cfg.slice_chunk_size * 0x10000000 + (dsc_cfg.slice_width - 1);
-	do_div(tmp, (uint32_t)dsc_cfg.slice_width);  //ROUND-UP
-	dsc_params->bytes_per_pixel = (uint32_t)tmp;
+	dsc_params->bytes_per_pixel =
+			(uint32_t)(div_u64(((uint64_t)dsc_cfg.slice_chunk_size * 0x10000000 + (dsc_cfg.slice_width - 1)),
+							(uint32_t)dsc_cfg.slice_width));  /* Round-up */
 
 	copy_pps_fields(&dsc_params->pps, &dsc_cfg);
 	dsc_params->rc_buffer_model_size = dsc_cfg.rc_bits;
-- 
2.34.1

