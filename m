Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409BDC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E01B710E06F;
	Thu,  5 May 2022 14:23:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 894C710E158
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:23:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aY+v1nYT2gEWJWuxlhLFmbt0CrcH0HXL92tQCrd4ETSOfGztPviwemZpYg0fO5FJ+GIBs/9+tsG2AkHtm+kh+h/ras3qDhzGknmHuSKo0nCU//vO6oJNkAOn6k9n0nc+u0WkLcBx/2257OyXVifaTFg/cwJtScwYyNUGll6/Rrs17olEQanNA3zu20s7oMy+X3Qceuey2z5mhq3uRGp9xup1Z2RnchEDWRSf+eFeqrGCR7VIj0wm6wPsf4Xjew5XbYb+GxIiqjDoQXRBYUEK6oQM3QXlaWtV3BE4dc+y3j5HsK0NfixTS5WPTbgPcVDCcw73alFLVQVtTLwDisPPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8lsKLKewYQvcveG7SXUPh+MwcJbwhgyeSdthTxM43w=;
 b=FEyIY6NL07MuBQuQk9XqrcJC+6YX83VxSBHWfPktQdOO/Dxl/D4sNXDuy42WNpfPZ2QWOr2SDiNzSFnWKwBv+HfUsxEVjtsnTJsZNrmAU7+OPawTFymYQk72RethwckB31At0S2wquGkPr2pWOsRnDVN0R99MndZWBksL0asPkUg+I6bbLvywz7HNGEjvEWo8+7kbMdVEGX/gXaXJLPNMhelFIqrLF5FPR00+6Qed4OtTJ5vXeDsTiJoWn3ZVWt6rM6/k+4CfFm6IlsEhyNGlJBikbA53PeE8Nkdrofr0676Yw6nFMpt/E+jkMs6JDeIzRXcu/MEa30698jRMOLcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8lsKLKewYQvcveG7SXUPh+MwcJbwhgyeSdthTxM43w=;
 b=Mxr8v6Y/yMJ31aUaN+Nmxiud4slaTUAFXojxKxK3KZ/u3aZWS+C78biz/rbXM5eMnRL5xUScnF5o/e3y13l5sOzbJO/WjoYNrmT2AWnBmGjSJJdxOmhOPWlaQRcz9Q9FtzjVs1Jv+s1s1YhlHx4eVn6EQ9EDKegoU/Ha1O5OEPk=
Received: from DM6PR03CA0010.namprd03.prod.outlook.com (2603:10b6:5:40::23) by
 MWHPR12MB1631.namprd12.prod.outlook.com (2603:10b6:301:f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.23; Thu, 5 May 2022 14:23:46 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::74) by DM6PR03CA0010.outlook.office365.com
 (2603:10b6:5:40::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 5 May 2022 14:23:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:23:46 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:23:43 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/17] drm/amd/display: revise Start/End SDP data
Date: Thu, 5 May 2022 10:23:11 -0400
Message-ID: <20220505142323.2566949-6-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505142323.2566949-1-dingchen.zhang@amd.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13afb604-976e-44fb-8bd0-08da2ea2ddac
X-MS-TrafficTypeDiagnostic: MWHPR12MB1631:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB163164C11077F78030E0CC898DC29@MWHPR12MB1631.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GaF6bOF9c5lp334kr+oCf0twUTnxFG95QplOXTkf+ErKim5VnA5MJU1Ew4mX1usb9BNxSxCJXT2W5nPbYVcssnNpACq+3cXXAepuNjv8Xar+c8IRNAJLQ2npdF7WubSnSSMbC0FOQmMaS48q9UulT/wSFLuPSqkqOKUtgJL+udAEOcfmsQm8JkkTb1ECr+LbfJgNirjVLVX/NKKSkud6d44Ox4uKM8EjscGMB3D/dulrg3YKGB4IYyh5q9VNZcJaI0UCMArgN1I8/Td3fH34o2VjgcSHBOl8rhsTAq9aOTO0usZFxILCZ023Eh9I73qoCuW2jlcOvZdgAyGw0ta0MIsgshIVMYDFnla0Pl7tDHmUwJaXwz1IxHt/34ez0+5aTee3h/BRGVuWCoEBOcfVQHV2R0yxcJK2loFvdqp0V4NxMN5tdpa+2kdSC92acQNrMH3/eK8qhugMNfMWZh3nID8JGrRB5nGdbimMLEhhTINPnCFFzIO6LJ2khIaZtY5wQqwc1iUPC+S2tEVXdKq6avLH47I/YvSz/hjiGqJUBZYw5lf3qY6kve4vo4kGa8W+I7mFIaRVzdlqOjKgQNTuyd2QwVle4c+pwQBa4xcLL+rdcbc3I3iDHBC1ZOQxE0HaswqgL5BGG4BMZFWQNr296+8eXgbH7Rkn3AGcFnPH8WPG5APS8iKm1/SU6rU3qclgwShQW79u9a60rvPopNPRdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(7696005)(5660300002)(8936002)(6916009)(508600001)(2906002)(81166007)(83380400001)(356005)(36860700001)(86362001)(26005)(2616005)(40460700003)(1076003)(426003)(47076005)(186003)(336012)(16526019)(8676002)(4326008)(82310400005)(70206006)(36756003)(70586007)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:23:46.3905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13afb604-976e-44fb-8bd0-08da2ea2ddac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1631
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why & how]
We need to implement the VSC packet rev4 that is required by PSRSU.

Follow the eDP 1.5 spec pg. 257

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 .../display/modules/info_packet/info_packet.c | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 79bc207415bc..c7d1b48c0478 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -145,8 +145,10 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		stereo3dSupport = true;
 	}
 
-	/*VSC packet set to 2 when DP revision >= 1.2*/
-	if (stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED)
+	/*VSC packet set to 4 for PSR-SU, or 2 for all other PSR support cases*/
+	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
+		vsc_packet_revision = vsc_packet_rev4;
+	else if (stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED)
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

