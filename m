Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBD7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67C9B10E124;
	Thu,  5 May 2022 14:23:51 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2040.outbound.protection.outlook.com [40.107.102.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F17D10E270
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:23:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTAbTRUR9GvjwaQ9PdCTlicCi3/sctKBkwLYhAGD9InJgvopf7KIE4uBB7fR+NgD2EjYlGYcMwSYCfN2x4LBjKcz7bGUrBJUPGNxjHFv7Lyl70+ekMy8It349gP7DQp91sRVGXvCGWR1ZP5AVMgs+4VC2+SdtzoPglJ8/FByHmZ/8lfmPWEPOlztpHJ3pgACbE80Fc1Pj0yplzYJr3u5NgrVy7AASsfnm2haZJqMhvwH0jjyf8PHJWhXRs39/CNu6PkDfFWdV/pD/4g7mTq2mAmvwxfHYbyWZvHa8wjclOYcA8Y6aWjvahvwhzZO1s2cSOZodI8mowob84X9sj8zJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dtv76hlIV2IUTnh2ykvtCJPLNelPT35kJNO4BEApYWM=;
 b=XbcZ6oYnkK9yaLi9NmcePqX8epe6kPdPfiBH6/1IoqeTeNb84tjvc/+v63vmcKH216mZoX5J32p4dcj0UV0qlQg5mfKlQcNFUotiYHr8tE7ZFMU+dfx7WkucDb+UMvkyKufsmmkpcNJGCupXk3UaJKKLfC+MVlIdMC8qdjzTUITKG29hGQUn/ap8/KET7pvBhbbGJtiCICNBaHxjxpcbVyVUycORrt6Fb14zBYs0LPbMWjbsMfehne0LdE0qrD1veS/ORKLjvUyWHxjKwFhhRegMvylvZ/cWWIwSgfdv6ogLE7pzND9XeJ28wYOFPKX/m7gKGxVOTaPeDOHTV1+oYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dtv76hlIV2IUTnh2ykvtCJPLNelPT35kJNO4BEApYWM=;
 b=Vj0K0k14o4NKfCQ6lM1vMXktm3ZTKArGgP0B+ryWkEjs85tY86Cq7JH5IgDQ9wjBefJHGA/FsxHsxmP4m+CAzrW9sEP0NXa8c2ma/tpVg7UHy2epdU+VHuA6zmFOZBHkcaIu/Pm3dEPgukur9Y9h9v6jmJV//++0P9/xVlFSRAY=
Received: from DM6PR03CA0030.namprd03.prod.outlook.com (2603:10b6:5:40::43) by
 CO6PR12MB5393.namprd12.prod.outlook.com (2603:10b6:5:356::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Thu, 5 May 2022 14:23:44 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::50) by DM6PR03CA0030.outlook.office365.com
 (2603:10b6:5:40::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 5 May 2022 14:23:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:23:44 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:23:42 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/17] drm/amd/display: update GSP1 generic info packet for
 PSRSU
Date: Thu, 5 May 2022 10:23:10 -0400
Message-ID: <20220505142323.2566949-5-dingchen.zhang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 66296edf-fdf3-44af-03c3-08da2ea2dc5a
X-MS-TrafficTypeDiagnostic: CO6PR12MB5393:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5393170A5D6AF82BF09B729D8DC29@CO6PR12MB5393.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QspmUc8msMqdnWiMu0pgaAXgPg09but1zG4zQ5TBSU4sz2DxC2ZGFK0+4Yv0uzAMfxXWIFhqWJ/sibU0+gbgNA8vsgMo2r3ao+P6K0TC5ewKIByLtQzuUp9kKd3IlVyCZX06Xbp1F+kVilyqI/k03T4bTtodDYTGPX2cVe20hKO894jCQEd0bUl8flQd9clQ375C/ALsCpHE8wX2uf9ZexA9HiyvBcgl7c3mMoxDPv/Qer+eAyQIm8nsnGU2x6kFFtRVdK/c62ToZdrJX6uqOFx9MK8jCUXjDoJ55iXN7gbrn5UJ3buT4ffZF5/aQBwN1/LsrH/oPt8jv9+aAp3DWOi7vcki+mHPmrjQeXvwjhTApIXo+qgVrfHFcDnJzcv0HTJosiX9ORm69OjOxcin+V72CgkjJbYaY9j14dKW6VsAQhgblN3S6gc9JNC88XcAIx41ub7ZPXaJkT9qQ5IVURXR61dHciKrJkN16gBo8oA6Lj7TZPOl6y1uvnfswDEAtfdGlqyyG7/S3S22SLViB6YcouJURD3poIN89SHxJM9eyyi58/XqZx1hisZTymYY/jO4dVheEdBsxdeg5dMzMHgAuGxoVp70Xt0I9v+GdFR14Xf2wh7d9D+mLLu1mIJLpQuEhGBs6o0etCftOR8uzW2hzqOMixrM+ht8SUKBevmnWelRQmLvE2lCtdbrfW1IsGk2FCCaXfVD75sA000kLY1Z0azK3q4yKZVkC6Fhekw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(40460700003)(1076003)(70206006)(70586007)(2906002)(83380400001)(15650500001)(8676002)(4326008)(2616005)(81166007)(82310400005)(36860700001)(54906003)(6916009)(36756003)(356005)(16526019)(26005)(186003)(7696005)(5660300002)(336012)(86362001)(508600001)(316002)(8936002)(47076005)(426003)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:23:44.1875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66296edf-fdf3-44af-03c3-08da2ea2dc5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5393
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
Based on PSRSU specification, every selective update frame need to use
two SDP to indicate the frame active range. So we occupy another GSP1
for PSRSU execution.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 .../display/dc/dcn30/dcn30_dio_stream_encoder.c   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
index a04ca4a98392..e40f01b596ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
@@ -419,6 +419,21 @@ static void enc3_stream_encoder_update_dp_info_packets(
 				&info_frame->vsc,
 				true);
 	}
+	/* TODO: VSC SDP at packetIndex 1 should be restricted only if PSR-SU on.
+	 * There should have another Infopacket type (e.g. vsc_psrsu) for PSR_SU.
+	 * In addition, currently the driver check the valid bit then update and
+	 * send the corresponding Infopacket. For PSR-SU, the SDP only be sent
+	 * while entering PSR-SU mode. So we need another parameter(e.g. send)
+	 * in dc_info_packet to indicate which infopacket should be enabled by
+	 * default here.
+	 */
+	if (info_frame->vsc.valid) {
+		enc->vpg->funcs->update_generic_info_packet(
+				enc->vpg,
+				1,  /* packetIndex */
+				&info_frame->vsc,
+				true);
+	}
 	if (info_frame->spd.valid) {
 		enc->vpg->funcs->update_generic_info_packet(
 				enc->vpg,
-- 
2.25.1

