Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2772FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E835D61373
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E835D61373
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C2776EA01;
	Mon,  4 Oct 2021 14:42:51 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2040.outbound.protection.outlook.com [40.107.102.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 323C56EA01
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:42:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+irwtbDwSmgGaxuqjO74z9c49YSN/woXx6BVo9pyADzcugfsq688imKOHr0cfkq0l7Eu9Ht5SEJ8x9pF/TEKFS+99Z/Hg8E3FWdcPzTUSHSuUf1Drg0vb00y++j68FaLTCr6eCfkcoy+2tqtXbqQ/EF3VTnMaqYq68inskUjeYpEMD1lpSBp6mMu5HpIABgzPlbmI6DmOSuVh3r0sD44jN0n818pbGuR9fSj/Mt4Pp+SIhdyNj1PHyOye8gBn0ClKte9ohiaKmDjwFUwxnSWPUHbuyGM8mgRF5A2Pd/bIY8An1ieISdeXkmg4OVvxeBPr6b1S+FHvrjoNQx48S3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vZx7pr0vxSXMCsTAI8ytWGdAiGWfCvhiZx5RBeOw6g=;
 b=Rc7mMbsZPyE1CxM0lRryGa+SUcPCSMPGfZ+vitoG7B9uIeCzVK5PUv/MB92MmiiVSR9T3967fMQYPEYUnm1i6tGt1w+br2JsRuuNI6ZIytuEulIn2tOb1QHmWUDBRBSlFn3pQaqxiWqnrRb63o9D8s74nTYXw5bZ2ekx5JS+zgY5tnV2RbhOL/yT3L64IW/Skm0PxR6d7U/MnUJcF9oXQNvhdDbR+V1tQ8j9cAWKsbuFDu1puCkoUCpSHF/p2AMxZnpxJfnog+BOK/WdOvvLpaGPJW3awKjg9B0K9z+EVP1lMP/0WToB0Uk9Mq3nRhtsZ0WHwlDkaw97JN9FGklZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vZx7pr0vxSXMCsTAI8ytWGdAiGWfCvhiZx5RBeOw6g=;
 b=hRQmyWDy8FtvJoouzKUsUCqGW5xsBA5lfnw7zqYPGFNAeOAzc3F0T5EPgd5jb1C2s1cbqfWd/TN0SVMCw609CjZsN/1can7KCUGJjWB7G5/xvXiS2sRD4yYnUKsgJn/UK9DgX3KbuUCb2AOsfG6oJcTm/nv1qXcSPvavTEzHQ8s=
Received: from BN6PR1201CA0003.namprd12.prod.outlook.com
 (2603:10b6:405:4c::13) by SN6PR12MB2781.namprd12.prod.outlook.com
 (2603:10b6:805:67::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.20; Mon, 4 Oct
 2021 14:42:43 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::fc) by BN6PR1201CA0003.outlook.office365.com
 (2603:10b6:405:4c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Mon, 4 Oct 2021 14:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:42:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:42:42 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:42:29 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 07/23] drm/amd/display: Update training parameters for DPIA
 links
Date: Mon, 4 Oct 2021 22:40:34 +0800
Message-ID: <20211004144050.3425351-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f163be67-59bd-4e17-a983-08d98745396a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2781:
X-Microsoft-Antispam-PRVS: <SN6PR12MB27814D6D4BCFD2F10E38D0BAFCAE9@SN6PR12MB2781.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0LCAieiQQcwj7owsQhEqYrIJrDKSlXUcTMxn5SMDoS0HYCSDzirIG1pK2nNNzwfhIYefTx55R5+Jo51n+f4GOYRI7jjAwx5RLO6EOsNNwXqR1hPPukZXZ94oJ7hScAUHwfrHnI5s6UC5kkamTI4NvKG01NSmn/tI1Ng4mLDa6dCpxqx/o9QFLsIduCU+Ea9IZGiY70KKzO8O//udIhVyCJ7is+179ZJi7SiP5wT0Bal7SDq1pmIY9wt2W0JtXPN+/dPkyMRZbVx1iqcyCgJVtPENLtXxMj3F1x24veuBDGykHuGyklH4nsezprIGLeOORl1EEv4AoHO+d/YqvExhPqhK2wTABitCL6I9lwuezsF0Fl+2cQnUrEwT/bErXi6Rk40Ol0NR5YHmY88OfyqHgw7GLvNZypl9iPiWk2Imx71f0s6DRp88RRHKzWN2JlZK/3LDRiw+kLOgeg+pHDq7CrGqUHNvo/f77oXN8KKjdjmCe+tNe3H2kJ/s+sbAc8GJY+zsEdLUnys971Vc+zk3bGy7MMuapI/ld3Vomi4aOk0kb24E92z44NYmjP/aF067Q8/WTC2A4CDNp4TF75wmux79kU/f9+8kWWYE/T28+1kuopmsd9Rx/REN87SvMFr8xlc7Ohdf5JaOIOkgfPlpBJU+FS+Js62q5lbjSDeYnbkL3nEY71QhzGdLPpfsl6zXDxZLUqDgWE3hhH+bLU+fxFmYcp32+chpr8GC41d8A3A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(426003)(26005)(5660300002)(1076003)(336012)(186003)(47076005)(6666004)(15650500001)(8936002)(8676002)(36860700001)(36756003)(83380400001)(81166007)(54906003)(70586007)(4326008)(316002)(82310400003)(356005)(86362001)(7696005)(508600001)(2906002)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:42:43.4990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f163be67-59bd-4e17-a983-08d98745396a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2781
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[why & how]
Add codes for commit "ede4f6dac99e drm/amd/display: Update
setting of DP training parameters." to support USB4 DP tunneling
feature

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 9bc5f49ea2ec..dd1d0262ba40 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1777,6 +1777,13 @@ static enum dc_status configure_lttpr_mode_non_transparent(
 
 		if (encoding == DP_8b_10b_ENCODING) {
 			repeater_cnt = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+
+			/* Driver does not need to train the first hop. Skip DPCD read and clear
+			 * AUX_RD_INTERVAL for DPTX-to-DPIA hop.
+			 */
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+				link->dpcd_caps.lttpr_caps.aux_rd_interval[--repeater_cnt] = 0;
+
 			for (repeater_id = repeater_cnt; repeater_id > 0; repeater_id--) {
 				aux_interval_address = DP_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1 +
 							((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (repeater_id - 1));
-- 
2.25.1

