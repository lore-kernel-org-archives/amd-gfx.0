Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4438C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 03:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D234B20792
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 03:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K1eqx5QW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D234B20792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE856E419;
	Tue,  4 Aug 2020 03:44:51 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690051.outbound.protection.outlook.com [40.107.69.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 851B56E419
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 03:44:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leiqHw/2I9APfCWHPTDnayMYCLOS/3+cEMuVut3Aid79Ye0AMawg72YHO0qWWbDW4F/Xh07Ije3owzoONO9a2qHwnG9+NELO2EUa9BpV/N+QgoGjQfM2i+u2/JFAwjKGm+/Ch8FpHROAePzp/8zDxcj1l1v9C4Zq0XHw4p4uRkKyq1V2Yr+sNF2wWjcLD+j4MXCbjMSuPYxXWUroXT3NqaRb4Lnb3zbrhNjFhvacwLkgCrBPEsMcSsNtuY7iHBkNiw3UbvJQRyv4+g34hMahKUmZKdH6prS4iNQCOvNrPo3XsMcenAQjZy5YUQqLt3xfzCHDKnAz13wXb168lxlR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChqsSY+Xo3aCna0wEQZEQHrpRR5oQ1KmmhXbqclNXTI=;
 b=e42r5XxFFelSaBK4TOGBPpBPm7yK4XqsyGI7MKh16oK5Vi2LWOvsth5rinr70Pdg1FEluMDa45X7N5Z2SyOYtHhPehq3RZJ5cioE5n3rDxJPdUW4GwqiGPT8UYjM6mKBjCC571sU1b4Cd5t1ubRaZX5yZ7jbHhbiFq6As4FXNYTQcZWRRKmloObpDE0ySg5Ac1zT0vim8RYTF3AfrbQtmDoTmN4xrUQePeyfRJH7mo3zY7IzETCMf3GbbxfaQ4zp64KrDeWniaLgS2qm3vCp2czxhOOJ9zbAF5uCGP3nhIkGu+CYdMRv7ssANutFPnvANglDY+uBTcpyo3XD6OKe7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChqsSY+Xo3aCna0wEQZEQHrpRR5oQ1KmmhXbqclNXTI=;
 b=K1eqx5QWGSPIOiPMVZM4RSL+5vPdMi8hKqJLOI0QsO52F3CUiVc8Bl5qcFZDhsMvMPvefvBKdjacIg45w2F3OFPKGKz0B9NqePBu5j3UVxwtkyhfP07BVXA2ujLCqsBdDrdPqwMxJyVOQW49wZqcmsfNuNdnDBjw2fyq517FbJ8=
Received: from DM5PR07CA0162.namprd07.prod.outlook.com (2603:10b6:3:ee::28) by
 SN1PR12MB2351.namprd12.prod.outlook.com (2603:10b6:802:2b::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Tue, 4 Aug 2020 03:44:49 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::6) by DM5PR07CA0162.outlook.office365.com
 (2603:10b6:3:ee::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Tue, 4 Aug 2020 03:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.17 via Frontend Transport; Tue, 4 Aug 2020 03:44:48 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 3 Aug 2020
 22:44:48 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 3 Aug 2020 22:44:46 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/dc: Read from DP_SINK_COUNT_ESI for DPDC r1.2 or
 higher
Date: Tue, 4 Aug 2020 11:42:18 +0800
Message-ID: <20200804034218.612-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3da745e0-f3c9-41ed-2b8f-08d83828bcb6
X-MS-TrafficTypeDiagnostic: SN1PR12MB2351:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23516C4710D117B42348F25BFC4A0@SN1PR12MB2351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dkAiR04ZTvCDncKqmloFQWKktkUv6U8N6Bql7QFCO7vaPCaR583rOcU/UCllQ83TY4ugUAZDQcoJco2MP1/r95r58aCY20QpV8P7FqVEFKBcBGyQruo+A1WsDRL+4EP/tfEG0Ir0/Oldyt3blPLJom+38t6nqdjXiSHA1QMmRD4Wde3PFOQ6bDEdXerGXtlXgduZ7EHA9ZrwgZwc0QL05nwi8VgNv5V21PmDXv3ezVZ62P+tY61oTu5KwYmyVF+J9G0IVpmYIRnKX3hGUtipyIxitUOKZX/1YyqsSbmiCJ8ijKmW5fap6RkOT8f8TONqyCeFC/qAUxCsM63pdKBPUBrzviKjVVvIvMuWb9qP6S2zrMsg1OcolzZBFRGKFbzpxummaIpqQIZ/vkCj1PDXVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966005)(5660300002)(6916009)(82740400003)(81166007)(356005)(47076004)(82310400002)(4326008)(83380400001)(26005)(8936002)(336012)(426003)(478600001)(6666004)(316002)(186003)(8676002)(54906003)(36756003)(7696005)(70586007)(70206006)(86362001)(2616005)(2906002)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 03:44:48.7988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da745e0-f3c9-41ed-2b8f-08d83828bcb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2351
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
Cc: Rodrigo.Siqueira@amd.com, jerry.zuo@amd.com, aurabindo.pillai@amd.com,
 hersenxs.wu@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Nicholas.Kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
According to DP spec, DPRX with DPCD r1.2 or higher shall have the
same Link/Sink Device Status field registers at DPCD Addresses 00200h
through 00205h to the corresponding DPRX Event Status Indicator
registers at DPCD Addresses 02002h through 0200Fh. We now only read from
02002h when DPCD revision number is r1.4 or higher while handling short
HPD. Need to correct that.

[How]
Set to read from 02002h when DPCD is r1.2 or higher

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 2bfa4e35c2cf..9fb1543b4c73 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1834,9 +1834,9 @@ static enum dc_status read_hpd_rx_irq_data(
 	 * fail, so we now explicitly read 6 bytes which is
 	 * the req from the above mentioned test cases.
 	 *
-	 * For DP 1.4 we need to read those from 2002h range.
+	 * For DPCD r1.2 or higher, we need to read those from 2002h range.
 	 */
-	if (link->dpcd_caps.dpcd_rev.raw < DPCD_REV_14)
+	if (link->dpcd_caps.dpcd_rev.raw < DPCD_REV_12)
 		retval = core_link_read_dpcd(
 			link,
 			DP_SINK_COUNT,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
