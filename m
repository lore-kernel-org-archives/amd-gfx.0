Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B5FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80C9110E842;
	Tue, 10 May 2022 20:45:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73EC510E842
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:45:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0Usr3+1/UV/+T57MWC/7hWaa0dmsZZZ8FtgDR4pnkNTosASYFZBl4MOeMHt7Fkb/PUyLFG0lm6ZEMox8x/5RIQMkS3nnJWGHw74feyHhMBGbos6MS6CYFvWFDPF/pRuP/bJEwu4+I6r9KxaDd7AY5trltXffRNm3vPCpiRt+6vHk7NZEr//L3IiuyG0FkhcL4st4yp5tRKvjGqUcwp3M+NueN7mtL4xOVMq5JNXij6euKH3jZyCo1dqglWGZ0GAo5G6UtvS7evuYHYjtqetk6V0ubH+T+CadcUxlCVPOfHsP6Ek8R4H4B4o522EGPFKfV51FfXlwc7ZTQwpYAdKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcsCzu5KTJmQ3gpNWHpdUQCcnyjsE4hN+Z9s3BL1SZg=;
 b=hwh62g4E+Otp/IRsjqEsjlHAYqzGCRJ9P3WVdwC/34AtdnUbynj9cZXFGszcUqKRy7JpRp/A2eCzLcLAfhG3XgH62Rg8vA5j+n9q8K0yE34ixQ8GUegTm7TeZoDes2v2NW/EQUwuWb/L2pWn3BEnU8R7r2+7D3ns1g9BENlH+9OwaPyTK0hIIyt7ObIV870Yd+dg+4hNszTXSri767a20GvqZ2qHGtdDY1Let8tb6+HRMoURvVjDOCEMWOOhRMX5GXL32QBMTEd9M6YMouzvyKgMK86G7CyrPjcvCW7RVjZ+lzC1PkX4m31PLK2D3hobYf7a02UgKtarIM5rfJcMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcsCzu5KTJmQ3gpNWHpdUQCcnyjsE4hN+Z9s3BL1SZg=;
 b=d0JF8Yn78bE8DC+BicO7zTU4UQa3F/mmYEC8y1z/8BAjr9LjgsyHsdFB5+Opig7FulajPgoKCgOvGS+bJ3voW70BXk0FepdBz3cAHRTxSmk+vbTk4AXucJvca7H82cDjFC04/QVYSGIDFOVtDxvhrGc+WhruEJGChHnan0D7gcU=
Received: from BN9PR03CA0912.namprd03.prod.outlook.com (2603:10b6:408:107::17)
 by CY5PR12MB6324.namprd12.prod.outlook.com (2603:10b6:930:f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 20:45:44 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::c7) by BN9PR03CA0912.outlook.office365.com
 (2603:10b6:408:107::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Tue, 10 May 2022 20:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 10 May 2022 20:45:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:45:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:45:42 -0500
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:45:39 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 05/19] drm/amd/display: revise Start/End SDP data
Date: Tue, 10 May 2022 16:44:54 -0400
Message-ID: <20220510204508.506089-6-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6703de7-e9ec-476a-1a03-08da32c60d8a
X-MS-TrafficTypeDiagnostic: CY5PR12MB6324:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6324B446D0951A60F4514EEB8DC99@CY5PR12MB6324.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cp/kWdiCWK6xdpa4gjnRSJXhtfM5Zqq4aKnSbLujJLzXzMj+UrKEg9cVT0xo28qztGbG66Ml2zNibda7XY+cxK/T6L1wL+4ol/t/8SQoka3tkstTyW9DUq4CJdJbfKvLGaOcEb+I0P8e0C7k0hty4QuDz2g75KnIzKS5a0q3zOUgca8nDtccoknoWe5zMHfpqZ/O70/z0ZyQ4vizxYqBdUMayC4HVvJYPY2/nFlcR2Ma8vxy808UA27dlRqXiBvPnkyRiA/nrE6NziC+b+b3RdHQP1ox7fb7ZIjMZ8sywxn4UlaBS5K2OT5/lkbHrUkfhfo5t9t0GoBHbGoma/B/xyf7bqat/ixKtvki8pA0Unl1DNRcYseivMlFdETQghN3zHiGEjPAGPCrc4NGGpt1VJdVY8DjzyjaqeoI5qdO6DFWaV1YWGcC8xUz5ny4LN7Ab0sV1vrxC7SGsOjWE7j5vfX/nw5/ZPuy/K0dpihb906nRZ1OPdaaROzDoGEvqDbG5vPQtfRHw+Bvz6vCY6/XDUhGHya/TeFdnM+9nsbYHOI30IeT9TBdqDIZPRye01gXnPUy1QcKOTnsK9jVxxmT3DrcUFMkFjenXdpRa1++m+GKgHtn7Fos/CaFDmqKghoJgXTi7eYpJGy4cF0qPQMRqKfAb2OTWdEPwLBfi8rs1Sk9RpFQi/E1RM2FsHl+F0IhNffmZrzdk6aTZa/Te7wYzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(316002)(8936002)(54906003)(36860700001)(6916009)(356005)(4326008)(86362001)(8676002)(70206006)(70586007)(81166007)(2906002)(26005)(40460700003)(6666004)(83380400001)(7696005)(1076003)(2616005)(186003)(336012)(426003)(82310400005)(47076005)(5660300002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:45:43.7789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6703de7-e9ec-476a-1a03-08da32c60d8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6324
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why & how]
We need to implement the VSC packet rev4 that is required by PSRSU.

Follow the eDP 1.5 spec pg. 257

changes in v2:
-------------------
- set vsc packet rev2 for PSR1

Cc: Chandan Vurdigerenataraj <chandan.vurdigerenataraj@amd.com>

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 .../display/modules/info_packet/info_packet.c | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 79bc207415bc..27ceba9d6d65 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -145,8 +145,10 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		stereo3dSupport = true;
 	}
 
-	/*VSC packet set to 2 when DP revision >= 1.2*/
-	if (stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED)
+	/* VSC packet set to 4 for PSR-SU, or 2 for PSR1 */
+	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
+		vsc_packet_revision = vsc_packet_rev4;
+	else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
 		vsc_packet_revision = vsc_packet_rev2;
 
 	/* Update to revision 5 for extended colorimetry support */
@@ -159,6 +161,29 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 	if (vsc_packet_revision == vsc_packet_undefined)
 		return;
 
+	if (vsc_packet_revision == vsc_packet_rev4) {
+		/* Secondary-data Packet ID = 0*/
+		info_packet->hb0 = 0x00;
+		/* 07h - Packet Type Value indicating Video
+		 * Stream Configuration packet
+		 */
+		info_packet->hb1 = 0x07;
+		/* 04h = VSC SDP supporting 3D stereo + PSR/PSR2 + Y-coordinate
+		 * (applies to eDP v1.4 or higher).
+		 */
+		info_packet->hb2 = 0x04;
+		/* 0Eh = VSC SDP supporting 3D stereo + PSR2
+		 * (HB2 = 04h), with Y-coordinate of first scan
+		 * line of the SU region
+		 */
+		info_packet->hb3 = 0x0E;
+
+		for (i = 0; i < 28; i++)
+			info_packet->sb[i] = 0;
+
+		info_packet->valid = true;
+	}
+
 	if (vsc_packet_revision == vsc_packet_rev2) {
 		/* Secondary-data Packet ID = 0*/
 		info_packet->hb0 = 0x00;
-- 
2.25.1

