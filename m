Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCDEC33CB7
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02DF2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="imu0By3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02DF2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F7A6FC3F;
	Fri, 31 Jan 2020 22:17:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED63C6FC34
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXhPZmTQRZDebU6tNca3rcs5Auq3BGm/PGE+RYAnQAS40yMHvnkA8VfymicMNdrEzEAnssRz8Gbtg6TWpQMbFPInq4XbS/UnIX1lvV+xfmb8Tp0BHzTufrkzhcseNg3mVAWRlkLA/8iw4cluZ92A0xkMfd7ci2BioGaPbZKFe0W+UADpn/kD/Tl3RCFzikdXF29hHyAZnMRgtgF3HRwHPMktR7jZM5nI1kQOxkkZtNtg5wQHGPyztVYgP14Yww/ep807WkvabnoVQRee1YcQr3Cl3Wm4CTmyTfP/tiP87a3ZJASBQX9eDVZrCe56sz1TdUDMlq3Z7QmrOIiBW7rWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmYJFc9eeFBMHcBvI2x94bg9uIp8paRq2Wwux2soD6A=;
 b=HLEehMZzwqnNZU2gCdHV3ybSWB9M+EEmYPXm6eUO4o2rdhBc9J/B7gpHkzGkdB6WkEvohJE2LRwVG9p0mvc0pZ6VBwJPKEXU1jOt+kKeb9jRkZr0MmHGBLQCJ9PIzaE2kka81XBkMSNHZpOJuIMQVUaepnNn9ZHh7FYWHFlo35HE+LW58t3zfBpU3CxrIg1wy8u/npB65wTEXqzgAO+m/nJKJZynIcKkgpvkGSG91CTo71RYjmk1dnNt1KiGTJ3Oc8PP07gM1iDhMVD/id+69PeMLpSCPqgDWrpgYCdDLWNISk+eHf5aGlttikF4hAGbluJ8lccKUPInJmSTSA50CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmYJFc9eeFBMHcBvI2x94bg9uIp8paRq2Wwux2soD6A=;
 b=imu0By3BVTAnLg4W47O5Ay/4uGcW2A92PPJJSTK7+Bhqc3liWwO6WrHuSY4SbEYrXDUmuAzTQGz+6ERDo2YNjmwou5qvzzM1QOeQgcUiZCYnYMcafbLbp5a8J/yAOqUZ4XavDpdnJ5vgElJ8mTfL+WVLnOisxbRzXYS+fbFumzs=
Received: from SN1PR12CA0098.namprd12.prod.outlook.com (2603:10b6:802:21::33)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.26; Fri, 31 Jan
 2020 22:17:05 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by SN1PR12CA0098.outlook.office365.com
 (2603:10b6:802:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:04 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:04 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:01 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:01 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/33] drm/amd/display: Fix psr static frames calculation
Date: Fri, 31 Jan 2020 17:16:14 -0500
Message-ID: <20200131221643.10035-5-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(428003)(189003)(199004)(6916009)(54906003)(478600001)(70206006)(26005)(70586007)(8936002)(81166006)(8676002)(81156014)(86362001)(7696005)(6666004)(316002)(1076003)(356004)(5660300002)(2906002)(186003)(4326008)(2616005)(426003)(36756003)(336012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4268; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92263978-3cfd-4968-771b-08d7a69b4d56
X-MS-TrafficTypeDiagnostic: DM6PR12MB4268:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42684DD0FEE0647CF5BB3A42F9070@DM6PR12MB4268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hw5xaIdzpKxuuOSuJ5j7mXMh6qJ3QfrWS0E2wwmClsaDsqKjR6ZkyJiu5KNg44M+50/SwUWWrxSqwgyIQv23lZRtyvtsf72p2+xmMulLT1aovf1qUX/RgFFyk9eYYSshPTOlJaViy50ZjKOfjTzmyhq0ZyNwEN3Ej1P4zl2VIyss+A0tDvi5wFYTwgufFvaYo2LdpxEhr77+lT5GP6OnQUwjukvLBiEEFdlOR5vltMNSKxsnEOiQ2tCJF+46Bn8ZoOtNIsVk9k6WmAh2mTqxqxcnlCRpslVPxFLEQB6u7P1skSivWBMbgNTGhDPkMjmm6mIrDzSruKzXcQ4gHl4ZPFR/E5G8usBa9fR5hxqIqKe13EN62D6mgz4ccQjenAHpQBLdSWJR3RPER/VBRq2p5m5tRtH55txxuvz+YqwNcpWRM4nHHtu3AjnnASWRQ1Jv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:04.2237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92263978-3cfd-4968-771b-08d7a69b4d56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
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
 Roman Li <roman.li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
Driver crash with psr feature enabled due to divide-by-zero error.
This is a regression after rework to calculate static screen frame
number entry time.

[How]
Correct order of operations to avoid divide-by-zero.

Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7f6d3b0f9efc..6786d34f7d04 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8497,7 +8497,6 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 	/* Calculate number of static frames before generating interrupt to
 	 * enter PSR.
 	 */
-	unsigned int frame_time_microsec = 1000000 / vsync_rate_hz;
 	// Init fail safe of 2 frames static
 	unsigned int num_frames_static = 2;
 
@@ -8512,8 +8511,10 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 	 * Calculate number of frames such that at least 30 ms of time has
 	 * passed.
 	 */
-	if (vsync_rate_hz != 0)
+	if (vsync_rate_hz != 0) {
+		unsigned int frame_time_microsec = 1000000 / vsync_rate_hz;
 		num_frames_static = (30000 / frame_time_microsec) + 1;
+	}
 
 	params.triggers.cursor_update = true;
 	params.triggers.overlay_update = true;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
