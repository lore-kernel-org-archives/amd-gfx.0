Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA336C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 108E410EADE;
	Thu,  6 Jun 2024 21:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NN1ZWJJ4";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C43F10EADD
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLFLkwkN6ehZc61FWK/IIiYVvTSeW/PnPsXBPHAvspYJZDHCMd/0ixPVE4mInr+GVZVK1vOLbCkWCwcI59Lsi4L2BlHdKs2HawHRzK+RbOUBoEhcR05erkEKfH35pNDb9FtWAKYp94uFLNA14hLnMLgEUUxeJPl7KTceKqb8yWFWqwATBClh8VFbzyjUVScB0zPzVaM8icYcwtZuk5UdK+EFOxziGuWntrf25UJ+TzL/Q4Z8O4VAxF7CnZullHiLjFtdIVdpJBVIIqtYwbUyt8Sl9zNiBROxdqqUy4DCnWRCtUNm4fjIebOxPDEnh5gr1mlFnOIy4+wKFaVdMG8w5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRdIDBRb2SZfo2m0/ZfQJTIWZpNayzBy1HeQ273R85c=;
 b=V/qVvyTzWnnWncVEstPKPKsGyds2Q4bGLcmNMY6/QSCJ/fyN/KKTLEEfn++f2IkXlw+iu2aoZ8niMMcSp3275drIkbHsORYQ4Dn2Iw9KkglHoY5w0opyoRKTX1+7RSj/pCpInZmpKJgzRXWmGl+3W40oPuQu9Binf59wGFaWeFiTCLumJp6qFOKVOQTlNw3U2gF8ajDkuP2fXgW1jdetldbEKqPSIcfskgP3MoUi5Zle0oQLVIIPbT47/35ZIwxMrfcaKzem1q5PLU/q9onMn5FXo3itQu908IEI5om+nRT6VONfrJSOoL+N9sOcROgDJ8xvTnj3QVzDT14EV07MzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRdIDBRb2SZfo2m0/ZfQJTIWZpNayzBy1HeQ273R85c=;
 b=NN1ZWJJ45JQTvDslp4hsKpPHhUZHfoneA59pg0EtHD5HRGWZu5jVcsTdbjCdy+4h0qXpY2QMQqsCEomKgyvMle+bWM7E3ZXx5HEfaRo1V+ZJm0RryBJul1tg8WQqJKpdBM82JGod+JbgdNsvVPrB3fy/DoD6Xh/dhF7pNMTrpX4=
Received: from MN2PR15CA0063.namprd15.prod.outlook.com (2603:10b6:208:237::32)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:57:18 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::ca) by MN2PR15CA0063.outlook.office365.com
 (2603:10b6:208:237::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:18 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:16 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 19/67] drm/amd/display: Ignore phantom DTBCLK requirement
Date: Thu, 6 Jun 2024 17:55:44 -0400
Message-ID: <20240606215632.4061204-20-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: b4615b51-a416-49f0-ef30-08dc8673a251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hS95TxtPx99L2Q8CCB7bkm+pPbVioT3KIaL0GzS7ueBUQh/VTsBQ0F1K3CYu?=
 =?us-ascii?Q?anT9jbZhvCg4BAP0Pb/ghtQsPqde17M87VxZZEqelyXpDySeYRCZS6WZ5f1o?=
 =?us-ascii?Q?KTJxD8lE9ZTt39CK0GSD5cn+RD6Omxew5Cr5BxKfsjw5A95h4zZCmcBraJgF?=
 =?us-ascii?Q?cIz18e3nJMBnYf7E+BCK5m0mIr8i9vTaxeKbO58StU/czYhHl+fxVh5ZNnfi?=
 =?us-ascii?Q?cn5CE34Stuj+KWqECrFQUDYmZf1ZUWAnW9Gjx4W1vDyLTXAa6bY6pSml7T/i?=
 =?us-ascii?Q?ZBqERNEtsXaSMN5lu7e0/x/1WYorQSLrl71vn83cHSqPGxq8dn9uHESfsmXx?=
 =?us-ascii?Q?22yQNamvGaI0fUlPULCsPj4fd1y+32X3U7dg1Jk0ud9iIAi7cendQrMTUJrI?=
 =?us-ascii?Q?ci8ujodDF9Z9sY0BsWZkHnJZuz8uFWF+mBBtz/6GFdUGZZtnnt6idvEypZYA?=
 =?us-ascii?Q?9T0bpR+e21eyZyBDyyBszoIbiK+J9E4wK8gGMAJFreQV4o14DS9V8sk413F8?=
 =?us-ascii?Q?49vOnUx29GnBINiEdLx6zblSXr+1m8u7GJB8caNrT4lGNyWK8FX3MaqbfpWl?=
 =?us-ascii?Q?6DeN6Uwcw+RwfIdIWagRFckizRo6i4Cfq5gt9Q0J0md78KjWR1kVjo4Chtmd?=
 =?us-ascii?Q?rU7n6OWFxXKWsUNvKVFeQACmPpRvRzlyzP/6WFqx2sTql1FxdWMcteRqa/lh?=
 =?us-ascii?Q?i9EEiyTYiDrrvtjtRnjYEZaFRScA7oq92rJatu0SK3A5lm/eqQvnv9moT3O7?=
 =?us-ascii?Q?T4+cB7GufPopMHjZfsP9mc8zQGRf+Ozle9sQqo01haJmJhljuw8VCzNY5jlm?=
 =?us-ascii?Q?yP7is7DDai+ysuqsX9T2q4v4PTf/KtRyUCdMz8dLkidJ5Mll4GIUyygmZ0vq?=
 =?us-ascii?Q?CJ8/Lu6Tbtu4Nx0UpAvMikjq32rmJPVb30xGE3zmQPx3WAXmWPO+DpJQHSGq?=
 =?us-ascii?Q?TYeys6mdm4jawagSakbooTCy6F6kLYGEyjKyS5ihMjHGIKv9L8wpdofR4jG2?=
 =?us-ascii?Q?EXFj5Pwdi5aR46yzGLWKpXNvti6M0RYNaTTjAn87n3qeAwwF5dbjvFvaTs6I?=
 =?us-ascii?Q?aqv8DhL4eFiQ/rMY0O3Bc66zSys0J5D0j6CkytO2zLnyUpR4MCA/t/D/Dlgs?=
 =?us-ascii?Q?Tl1Ad/G5mIok6gl65NATCVAjXQBc+7m512zno2gO2d10+ap1FBKuUSEWJYrf?=
 =?us-ascii?Q?/5vS5S8lH3gR9p1wf+sofrxTvL972xOqQZuIPM7TGmzBZ8prlKf/S/DFX0PE?=
 =?us-ascii?Q?RA4Ss4pKJgRg9CHjQqhYpQjVoa4scQGuR639qx89/F9c1BgXfWKMUvgrIMMb?=
 =?us-ascii?Q?C3jYaPQOGQ3pc/AGGD4+G/BhOopXF73e0R3KSkaxiSj/y2JQCyHLU8fSlzX3?=
 =?us-ascii?Q?wc9FeAyxna5TXgoriCm2lWYVL2VOF6H0TP0Ted4ltyiMWPwdQQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:18.1782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4615b51-a416-49f0-ef30-08dc8673a251
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304
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

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Phantom DTBCLK can be calculated different from main because phantom
has no DSC and thus will have a different output BPP. Ignore phantom
DTBCLK requirement and only consider non-phantom DTBCLK requirements.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 85eee5ab5443..2b240a30d2ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -7713,7 +7713,8 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 
 	mode_lib->ms.support.DTBCLKRequiredMoreThanSupported = false;
 	for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
-		if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].output.output_encoder == dml2_hdmifrl) {
+		if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].output.output_encoder == dml2_hdmifrl &&
+				!dml_is_phantom_pipe(&display_cfg->plane_descriptors[k])) {
 			mode_lib->ms.RequiredDTBCLK[k] = RequiredDTBCLK(
 				mode_lib->ms.RequiresDSC[k],
 				s->PixelClockBackEnd[k],
@@ -7728,6 +7729,13 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 			if (mode_lib->ms.RequiredDTBCLK[k] > ((double)min_clk_table->max_clocks_khz.dtbclk / 1000)) {
 				mode_lib->ms.support.DTBCLKRequiredMoreThanSupported = true;
 			}
+		} else {
+			/* Phantom DTBCLK can be calculated different from main because phantom has no DSC and thus
+			 * will have a different output BPP. Ignore phantom DTBCLK requirement and only consider
+			 * non-phantom DTBCLK requirements. In map_mode_to_soc_dpm we choose the highest DTBCLK
+			 * required - by setting phantom dtbclk to 0 we ignore it.
+			 */
+			mode_lib->ms.RequiredDTBCLK[k] = 0;
 		}
 	}
 
-- 
2.34.1

