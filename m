Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF428C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B4F410E46B;
	Thu, 20 Oct 2022 15:48:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E8310E160
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbyZC+og1psg+LedUn8XYALTUK3n4yI9xjwH8f1sNFVd+bbHc+vtQlMUsEksXWG53bmvxbySyKTiXYiC7qjIyTAyYjVp8/lFlfVW5AWQA+heDgVqAJkxv5nwBv93lhRO0JnKg5s3wpiKu/kvb0b1f/XtoW2tmuoKkBalCPRDzA8G+kapVMJbDmHov/d6mjlKuayYXDZwJ+P+cPLGWe1HOcswpLNaBxwvM06jm5vF7hkAq/0q5bk9v1CUziVnN6k3lR6L7NBMGaDoLfpbbfxl5bPWuPohwm3qhh/lU+duJPOuQ3t1yPq5DiREbvecBv6YLMcdytmgV/nfrzqHjy5EEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwhVavwCkG6RGZBMx1DhQ/4guNoody1mbl2WAFp8APw=;
 b=NTB3ur/2LsCTlFHvJs7lvTV98iGyag9tPpNkSF+sgCDzk0IGZNL2m02PIRK14YPGFYV6HPgryIYwiHVjLBvAp+xyDXAbvlnoxqf3/NZL4KymmBTbJNyAut2+WpQN9Ji0Qb2G8fuiNXor4dK1vhubyUAD+0S01XILxmbM1zRtD4O1qxLVTpDctEukTnCjHf5K+Ac8nvZHy3X6nCmHNDlSqcNyErv+NRa+DcS+JvB5gfEydHKlZgcHemoDU7JTtW4jbtgMJAHE9tSSWgMJg6LoXgah5W6ktoFpgJnXPErauHPtEZv127dFvxVh/eEdDj9C5uVTGK89uMVeN+eVku3OBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwhVavwCkG6RGZBMx1DhQ/4guNoody1mbl2WAFp8APw=;
 b=OwdLRxqa3nkmwvNdysbByUXD4iu3vphan+hvBEpqzp6V1JfMP3yA9UZ5BYZboQw6WCuRI6T4xxvaGJNRQFBUXo7yNa3O9ZKl7KnqNO0G6LoHFcXoDy6zz+APcijUVRMaH56HhqwlTiOOFm6zpY3sipnjTrRqxYa/SFCJ4XlPUhQ=
Received: from DS7PR06CA0031.namprd06.prod.outlook.com (2603:10b6:8:54::11) by
 SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4c7::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.30; Thu, 20 Oct 2022 15:48:06 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::48) by DS7PR06CA0031.outlook.office365.com
 (2603:10b6:8:54::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Thu, 20 Oct 2022 15:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:48:06 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:48:01 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/33] drm/amd/display: Remove optimization for VRR updates
Date: Thu, 20 Oct 2022 11:46:49 -0400
Message-ID: <20221020154702.503934-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: ab35479e-356b-4336-18f3-08dab2b27ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RE7LJYBVOmLMhkI5NnByeJ0EC/Aa3Y7NbtFoWxoPn03Dn4/VPF1nwc16RhR1Md0g4gT+9eJtX6m7KAJ6mpR6x4gBib0V9YwFCodgYHEDST0AIPO2kPqzgJDcwDpqz+0ewVUch/+nDqBwLvUu/OyScdoWAtvrSIXk7vbr/Xb6GnHWNQuNKS0KiIckpOHpjs0o/Oya6z2W4Q2EpoNaWnEg/ID+fRFF/HdZWU1hULPQXZRZT2NNQLq8TVXvoWbqYCVCAj047e+y0N9h0QrGQ3EmZID2RVr0pM7UvVdDzDS4DZeDZapgPEO8/tPrxsOSGs0ulIm0L93DsLse+0umzb4jjfL+f0ntDvTg0+FD3tiU4ecdLYgdgYa1CQXItZxRIuB4joIyjl+7hn9hXhh7BU9gRpsmU5DGbcr5QDMRTKfWFrRaaPiBGd2WDr7kXHhq1JZodrECVvwyzZeaNbnAXkxpixQ2XYJCqf420/nxhphKrdoO0GgrhPOLisuTPMql1uhpH6bzcoLi3WsQx/7B04hGhkyy6nl/xUpOTA1XfhWNfM5rdayTSFg5KAAEJweHIpMI23tEy9XeEk1tcHLP1QPB7fvx68oSRgLnqyMWHZLZ1DiULoayUaYPOsklgLhJrH7iNgCrsOcyvLJDufu0QXQ0atYcTpY1XvMxusttnijd/UdbP1434G2O8KsF4FDZW4q3fctAS+TK+61+nqn9JeWvOasrCsLW3FJTabHN6uBmgOZcSgYMESUOfGQ0H9H6GneWZ070NT0hqXOZTug6XMCg3pxeSxTdxIqiD2wZSuoeqBGNn9kjiIsupBZPMsVE++PQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(5660300002)(2906002)(4744005)(70206006)(8676002)(36860700001)(7696005)(36756003)(478600001)(41300700001)(8936002)(6666004)(186003)(6916009)(83380400001)(40480700001)(26005)(70586007)(54906003)(316002)(47076005)(356005)(426003)(82310400005)(16526019)(4326008)(81166007)(1076003)(40460700003)(336012)(2616005)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:48:06.1413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab35479e-356b-4336-18f3-08dab2b27ae4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

Optimization caused unexpected regression, so remove for now.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 20c16ca935f7..f6776ccf7a0e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -401,9 +401,6 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 {
 	int i;
 
-	if (memcmp(adjust, &stream->adjust, sizeof(struct dc_crtc_timing_adjust)) == 0)
-		return true;
-
 	stream->adjust.v_total_max = adjust->v_total_max;
 	stream->adjust.v_total_mid = adjust->v_total_mid;
 	stream->adjust.v_total_mid_frame_num = adjust->v_total_mid_frame_num;
-- 
2.35.1

