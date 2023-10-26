Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481E9C25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01E510E81F;
	Thu, 26 Oct 2023 14:21:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78F1310E812
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:20:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqJcdr2zAsa3gUuWgMI4G7iHRIWdsrOT1k9l1myCMGSzdd/vM/B4SrsTwG+TEoDIK5LFIM4tOE6djVnhqIClfTz71nN9WB4QtpDvVCLx5rs48TrHFwhqZ4ACv4EWgw7c9mI+hiB8lJKUHAN7FlzqptaFEGCOnm4IY+sXPTFfWbvDEg78kWuXd4F+nyUHSGUJWjwHG71AVbYmf3FaqowR/uk7c6ozjHL4qPN+0CTLEY5TSD/6YmUAWRw/ek5rWKhjz/MyIvgppEq7Tjt8NRWQIuY/7BjV9SFoj0HqLjV64wcVCa+S4yG/Ch1CasAX5b6NWmULN1CtCb3ibnVrxKjuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5mwHl9NO1B8xAZSoKv0l8OdeoFomgFCe9Xa1jwzLnk=;
 b=Q7rQmkHj2OCJLyiiBh3FSQbnHs9rf0ZPsMp+NsNAEY0lsHq/PrNui3zjAuSd1JsxCquSkvDtQenTi7rU9mWvz1Qa+1vk5r/W5QbQvnAtMGIPhix+pcG9MhLBDjK2W/n0nspr0lLro2E0zPz66QnOZ4CQfebAVO/KTyUpATOvUOn4I3u1cmvEXZ7FZZYWV2QY8ua8jmzDbgnhvdyPd/dpvRUVx68oCOP/s6oasEXLx0LTKa1FlEkCQJmuAcf54M5s/WSDLvPax62TQVi2tHxUQAdgFEB2YElhfXNHlaMhDm7kxQU59LsRZuJrxa1agpbIrVGujgOePSrwoIVndZlf3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5mwHl9NO1B8xAZSoKv0l8OdeoFomgFCe9Xa1jwzLnk=;
 b=oQsO83mEvwgvsocx6B5WYzbkdv3Qs49aJDNmVvvVTnTLTx83Dn3BXpuGRS9OhaYD/eM/gGLxME2M2UWTZQVwoNWwM+EoE9OY9GhHcVYWxCbXtM/+OG2XZo5WSEBS3+v5mOj/zYIfYTFCO7jRX+zA/k0O+XEYAlde4Y4Cf2avQLk=
Received: from DM6PR13CA0047.namprd13.prod.outlook.com (2603:10b6:5:134::24)
 by DM6PR12MB4909.namprd12.prod.outlook.com (2603:10b6:5:1ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 14:20:45 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::4f) by DM6PR13CA0047.outlook.office365.com
 (2603:10b6:5:134::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:44 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:43 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/25] drm/amd/display: Allow 16 max_slices for DP2 DSC
Date: Thu, 26 Oct 2023 10:20:09 -0400
Message-ID: <20231026142020.67861-15-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM6PR12MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ec485f-cea1-4e16-53ae-08dbd62ebe95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFcAf0VDUqKAo3eFfiJVhsfKFO2OdyPV4uwri6gHiD1mQF8wvQo3d0Er9outtSp4JUaSdPYyjf89avXlR0JTCQfA0thgkleGwE5jn9trNpiO4vkfk3pHicB8OhnitHTMBOJEZ/bL4kKcrYv0xAyomhJdOXD5TOWYX9dBO4YtQYWoGfLZouCcAOswJnxbG0PobLl8sWXQENuaWDG4bALPO0t6SzQhvTvpRcN0kEFx1ql6VW08uPQrotsVyKBJzIH9Dn9ZwQ7+Ej49SwXA3bfc9helI9aGc9sRbN0HYE6Jgsj9ae31+K/F4z99uofFw7gPjh+0mwK2G82+yunjXI5x/pnILiVj9q1xWRpDAdEW+CBeZl6DY+XbuTyBTnd9U35EiwOisnsw+W7Xi3ZXqx9Muf6g1ttST7Z4Zlkx8OK/ejKtNVk7RhBLV2tCsg26ao8Iw3Si/7AIMSO4Cxsn3okT2FRWZ2+JNfJKLeiWFKTwBq4g0rul/9uZqGwDiw3lkDe9ESjkFq2dQBHywyvSguw+EJx+rUmTXHGosKN8zBTkv4Sj9cXZuhNYSOLthCc5X02PRpEqGg85FHPxM3aeyvtORponRbdzrhUmfxbjpnVwA9NkJstsYrUq0nlQ60t6MCjkzj0oLt8jx+xvASly0dmife82HFAAK06N8jBP30SzPMK4zB4uz2+KOTXLKS+0oJcDFTN72WCVZvizkig3+M+ikd6Z/XoiQopscH3+2ahYhmIQGi8Mi+1KAcu4qSTl3Tl0r7afZsUfj4kND7NVapqBGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(6666004)(8676002)(8936002)(41300700001)(36756003)(5660300002)(2906002)(4326008)(86362001)(40480700001)(478600001)(54906003)(2616005)(70206006)(6916009)(70586007)(36860700001)(316002)(1076003)(336012)(356005)(426003)(26005)(83380400001)(47076005)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:45.5791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ec485f-cea1-4e16-53ae-08dbd62ebe95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4909
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <jerry.zuo@amd.com>

Enable 12 and 16 max_slices for DP2 DSC

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c | 10 +++++++++-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c      | 11 +++++++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h      |  2 ++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
index 5eebe7f03ddc..c9ae2d8f0096 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
@@ -137,7 +137,15 @@ void dsc2_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz)
 		dsc_enc_caps->max_total_throughput_mps = DCN20_MAX_DISPLAY_CLOCK_Mhz * 2;
 	}
 
-	// TODO DSC: This is actually image width limitation, not a slice width. This should be added to the criteria to use ODM.
+	/* For pixel clock bigger than a single-pipe limit needing four engines ODM 4:1, which then quardruples our
+	 * throughput and number of slices
+	 */
+	if (pixel_clock_100Hz > DCN20_MAX_PIXEL_CLOCK_Mhz*10000*2) {
+		dsc_enc_caps->slice_caps.bits.NUM_SLICES_12 = 1;
+		dsc_enc_caps->slice_caps.bits.NUM_SLICES_16 = 1;
+		dsc_enc_caps->max_total_throughput_mps = DCN20_MAX_DISPLAY_CLOCK_Mhz * 4;
+	}
+
 	dsc_enc_caps->max_slice_width = 5184; /* (including 64 overlap pixels for eDP MSO mode) */
 	dsc_enc_caps->bpp_increment_div = 16; /* 1/16th of a bit */
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 3966845c7694..e8b5f17beb96 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -512,6 +512,11 @@ static bool intersect_dsc_caps(
 		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_4 && dsc_enc_caps->slice_caps.bits.NUM_SLICES_4;
 	dsc_common_caps->slice_caps.bits.NUM_SLICES_8 =
 		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_8 && dsc_enc_caps->slice_caps.bits.NUM_SLICES_8;
+	dsc_common_caps->slice_caps.bits.NUM_SLICES_12 =
+		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_12 && dsc_enc_caps->slice_caps.bits.NUM_SLICES_12;
+	dsc_common_caps->slice_caps.bits.NUM_SLICES_16 =
+		dsc_sink_caps->slice_caps2.bits.NUM_SLICES_16 && dsc_enc_caps->slice_caps.bits.NUM_SLICES_16;
+
 	if (!dsc_common_caps->slice_caps.raw)
 		return false;
 
@@ -703,6 +708,12 @@ static int get_available_dsc_slices(union dsc_enc_slice_caps slice_caps, int *av
 	if (slice_caps.bits.NUM_SLICES_8)
 		available_slices[idx++] = 8;
 
+	if (slice_caps.bits.NUM_SLICES_12)
+		available_slices[idx++] = 12;
+
+	if (slice_caps.bits.NUM_SLICES_16)
+		available_slices[idx++] = 16;
+
 	return idx;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
index d7b8d586b523..4b27f29d0d80 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
@@ -76,6 +76,8 @@ union dsc_enc_slice_caps {
 		uint8_t NUM_SLICES_3 : 1; /* This one is not per DSC spec, but our encoder supports it */
 		uint8_t NUM_SLICES_4 : 1;
 		uint8_t NUM_SLICES_8 : 1;
+		uint8_t NUM_SLICES_12 : 1;
+		uint8_t NUM_SLICES_16 : 1;
 	} bits;
 	uint8_t raw;
 };
-- 
2.25.1

