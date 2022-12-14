Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883F6C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE0510E475;
	Wed, 14 Dec 2022 20:22:01 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC65210E471
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:21:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfHlLtEA/qTgd9FBu/yF8HKZgaaOLziuXoBOWgEfJbKAT3+ltXMBijoiAYWFHjhlHekNxT7F3CeoGihExXTcEsQypt73+ykOMYiC5IfJmHUSjijocNwKLdouKINC88XpqLEPTSmEzAsA6Vb0UxK70fGL3ak12DXJLTHzt+cw8XiRsXnaXdUb0eonHE5pFCkImR5K+jX1nIvAo+fUgCHTkdumGQ2FPecQcVbNaVhBrH4+JlQLQUloNO8khykm79bAENsDQW+yQy5ls6QNiwN49t29M83kLkKqdo6RMprVX1tG/JHYmn2R57W6cRNkiR8z4YfAonYCL0vk3CMxR4Bz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDUDNK8DAnYjj8uQ9LhJ6T4OmtqswEaqjPay5uYhzzE=;
 b=A4j52V4aMh96fWabgk47on4ea0M4UGzsRdyEL4nJb1AmXXljisMFRiW1KAW7OMY3vECcpBqInfUyK7Vy3jIoD23luVisQmJE4d0eeCCjX97hlJx6gd8n82hmLBRRG/t+dyFZ3/qjzoGJgnBKtUkaa+6GDNaImmqhwtuqrImWQZhktSHljZRpaWE9BgZ8qpYhgLKYg7Hi936+MYvAEhIJiBNR4JhrwH//nF+dq+JwDnHJhmgI1WdQnPnqcKZDW6zSq6zUIL/NIV/i9bEo3B+n9gJwZpsalZ6OnCNISExWWckJZSm5TxVYdzlN4dh9eYQQoWdZo/ZE4+h98WZcYFy+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDUDNK8DAnYjj8uQ9LhJ6T4OmtqswEaqjPay5uYhzzE=;
 b=ULCwUxINEvI8rr2QZakPkX33VZGoVSBypOSGaRFqdGvpzIvwh3jz/7DCff1iawNRCrxgfq8dZN2zDfwnyxbBheG9E1TiloEfTFUJ8hvB0jkfpJNRX4bCg9QQbaPN+LqbuIVshYMFAiOobCVuwTZOHhfymdLnp/BteFP1OjavYuE=
Received: from MW4PR02CA0007.namprd02.prod.outlook.com (2603:10b6:303:16d::33)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 20:21:48 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::ae) by MW4PR02CA0007.outlook.office365.com
 (2603:10b6:303:16d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 20:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:21:47 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:21:46 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 12:21:46 -0800
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:21:45 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/18] drm/amd/display: Uninitialized variables causing 4k60
 UCLK to stay at DPM1 and not DPM0
Date: Wed, 14 Dec 2022 15:21:26 -0500
Message-ID: <20221214202141.1721178-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 19bdf308-c521-4ef4-35be-08dade10d39c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r3poJbfHLDwGOMlIpDcpy6CwEEFab4y76nuWyhhjjV8j0XB5ghg09rjmMRiINPAwttZrNFrrWK+NnZX9sy4Trj0nNhLm/uHnS0WKggw1kxVHqMp9K8C5cxvKtwmM+NuLBvCjVk/uHzd3zqHJ62dq1lf4Lu3BnUXdSwFhrn1vz9Q+ON/VCaUNb6dK7g/tzIIRnrd/CceX7OKeAfnB9Z6JLcetmv84b38XED+CQ44iPrm6zUtecx4X/G+HQcO3heBwA4bVbztUCAPXj433k/6ue8/uK7gy3NK+hTqO1MXpO2nQO0ztMf73hIqCeYyxPs3gvhKYfGEXjtnG8iV0F858EvdD8usH2TfJ48vY1WI8x1izqs76I+jaEOVfRCmb1495tPSKHXx2jQhW2YpOpkqphfVomnNIfKSmH37N3Czg0OwDGK9gK1/1eu9aoio+3nZg7/vSBXQLTYPH5sPIzLa9qeoNXuQlov1dNqvGZlxrkoNzd+S1SELWnlDvGNZPVtz+ghFI07/e8+SLUMvLumQ2ujGE2PpVmODLWfU6B0OoxMZp78E2z4SBLhOn9wKZA6Smtzh+tOtDtzvenzM2g2Xjl5FdV5Wg2mDBdlFzcC7VEPESNYHPpSmhMLYuUT4z+qH3GM99D1dC3zeXM64lZ+CB5FN562Syi2m76wUXYNyg0OPNIkFgAFrh+jVPUycBHkqo4OMm5kemdqRnpZfEOmpgwN+tZfOyF6g4KU1bLqeI1hI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(478600001)(86362001)(316002)(6916009)(1076003)(54906003)(8936002)(40460700003)(356005)(81166007)(82740400003)(82310400005)(40480700001)(186003)(6666004)(2616005)(26005)(83380400001)(5660300002)(70586007)(44832011)(336012)(70206006)(7696005)(4326008)(2906002)(426003)(8676002)(47076005)(36860700001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:21:47.6013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bdf308-c521-4ef4-35be-08dade10d39c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <samson.tam@amd.com>

[Why]
SwathSizePerSurfaceY[] and SwathSizePerSurfaceC[] values are uninitialized
 because we are using += instead of = operator.

[How]
Assign values in loop with = operator.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 5af601cff1a0..b53feeaf5cf1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -6257,12 +6257,12 @@ bool dml32_CalculateDETSwathFillLatencyHiding(unsigned int NumberOfActiveSurface
 	double SwathSizePerSurfaceC[DC__NUM_DPP__MAX];
 	bool NotEnoughDETSwathFillLatencyHiding = false;
 
-	/* calculate sum of single swath size for all pipes in bytes*/
+	/* calculate sum of single swath size for all pipes in bytes */
 	for (k = 0; k < NumberOfActiveSurfaces; k++) {
-		SwathSizePerSurfaceY[k] += SwathHeightY[k] * SwathWidthY[k] * BytePerPixelInDETY[k] * NumOfDPP[k];
+		SwathSizePerSurfaceY[k] = SwathHeightY[k] * SwathWidthY[k] * BytePerPixelInDETY[k] * NumOfDPP[k];
 
 		if (SwathHeightC[k] != 0)
-			SwathSizePerSurfaceC[k] += SwathHeightC[k] * SwathWidthC[k] * BytePerPixelInDETC[k] * NumOfDPP[k];
+			SwathSizePerSurfaceC[k] = SwathHeightC[k] * SwathWidthC[k] * BytePerPixelInDETC[k] * NumOfDPP[k];
 		else
 			SwathSizePerSurfaceC[k] = 0;
 
-- 
2.39.0

