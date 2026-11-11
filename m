Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDBF606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=R0vEjJVU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61A1610F8E6;
	Wed, 11 Nov 2026 01:43:24 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4697910F8DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCh0ZWbYkm5DHrQDKiKNYVrQp58EHeQT/IIHglco0yVcR2/SGzMu8MGoxK1jrLBQuC69vpnXRMZTxIXVmMm73AyurFh9GPtubPDyNaW3F97HxtyMl7+6eexekriWSaNfxkU3pDBIoiJYgveSnHj4GCXa9sqarll0KSoIHKJmO901rud+utSGLNETT3Q4180oiC4/NSmV3q0/L21/+gD3VjRLrJaDgQtBLmQDPi2GA5WMB42/PTL6FpJbf16QplXKvd2omY44u6hczHph5ZnWggnvw7OLVp8Q9czes8Q6oEMgQwPgWL/C68DJzW6HQk1elffB5HNJnLZDf8Kp/3l4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJLfGAKcxBV9wgU80NymTVvFivPqiwngIX9DGrOFZTU=;
 b=yaISnmrnHTMVY3chfYMrk3N4e8pJkFmPRPYQa85ojCq6YUVSrtOmUOxq9ZgbJGyOD1MatqZeh/1qfB2BAEcJgJ7m4JNLSxpqH78agpKj/ykJMu9ak7i/mxVkiodMTFbFrD3/eSDAtMN2v87GtS8TOd5ldmqkmGPFCH8IZShwmQPeMuU6aSv5sFHhmriAhkdnmVmLUxVnbNl7P4lC1QW0X6/jznWwvGknv9GtuLLpAwgIyBX1WHhGRKMWnKQnMK5JQWEdlIhKAb1TavWOATBVV0w2HBHkY4BGGkM+HmDXCv6nU/BSfY+a07dPlZWcW4jc2Al3DixiPEsx5YIZN6wVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJLfGAKcxBV9wgU80NymTVvFivPqiwngIX9DGrOFZTU=;
 b=R0vEjJVUPMe0dwzvQwgwRXnNV2FOMfEubnHCwBkPl67RjcHVrjFSb4jBOGzexjoCvJAG4okDcQVSUF1oy+Zojl2AJ9XlzHG6W/ejaqvwh3dG700B6oP1FWBUlZU3CBN/ekef1d0eP4V13feMfohjHJhGy5lck+1d9NhFz0sVc4I=
Received: from SJ0PR03CA0200.namprd03.prod.outlook.com (2603:10b6:a03:2ef::25)
 by DS6PR12MB934327.namprd12.prod.outlook.com (2603:10b6:8:4c5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:43:13 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::3c) by SJ0PR03CA0200.outlook.office365.com
 (2603:10b6:a03:2ef::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Wed,
 11 Nov 2026 01:43:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:43:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:11 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:43:08 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 43/74] drm/amd/display: Promote DC to 3.2.406
Date: Wed, 11 Nov 2026 09:28:49 +0800
Message-ID: <20261111014100.3596072-44-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|DS6PR12MB934327:EE_
X-MS-Office365-Filtering-Correlation-Id: 5708cd2f-64e4-405f-adfa-08df3f9525c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|261009223027099003|10067099003|3023799007|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OcwR1TjBYBRwmqHgmWmQViVPCH811/w8SuXQjaxatx2SmGoLYsd6rYPvaClZ0ytGvsX4YDMFLJeTyMKlAND8IzYum6G8RfKXzQHLCypmPLIOAk1ZsESjV3fFrZ/U5ZERMccOtISOaS13uXfgzjgwH1eW1vZaipTuOyC8Inyfn+9mP8PNBHCkH30I8QvzFBlc0diuWS8GcuT7Pzdra2Svjyrdw7mQAQE8DRn5f8S2Y+NCwGJ3YDkEPVX5VfFrPb3ccaP1DuDxuXwr7eExdhOcev541oHdIatmRd4nLKe69u+ThNwqTFRr5SJr9BP20eBkWfErWXDf8rjoFCyfQM/o9D8HrpX+7bEZ0ddG58eTW+Tx2igQpUy4B6KpvjilpJcw/ub/4WG0ZvuLqnItafKILQUfhf9OB061tF2cNci+ooOqCjdqxnZTbzcL073mrPhadsO/YXUijqZUdi4yC++eQTFtnKPEeW4vheD66coMfs7ljjnG0isnOiwbqZH4hnahhTsihDGLPMTO8XkDG6+sN08vqKRq9t28UBWgs9bjwj9ezRSQu6+5cFwy3LnXrRBaqrVsh1TY90Qtx7xD1KpOQlhSiocVICdt5PZPoBXR7HPs6a02vYMn16W530G/8wXxClWedsetaQ78bETMBVuvq7tLdN3k+ROGFuXf39IBmjqHlSBWUqTNw/KQnksi8uUljoKXvj5b4B+1KEgXZzKi9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(261009223027099003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 19ZxwtYXYB5AttHo1FVXQuUYQ1ZGcq4Os2xjlUC205HKfFTwGBOHI8MaY/olxrHOQeiwiGHOCEktLxbHmF302okMWNPseoF7X2jQ78+VirVe9NcmwRqz7Rh2cAC3Gfxhrkm5OdnQi5TFEtjbdU+E79RhTq27C5cBTWU+nDma/q0yy73gSfwl0MCwc8xAH+1XyMYWd5+rzWwAxJdjX8UL7AV4uWOj6eGwBI0oZcyMQ0EL9f6jQ1ZSeZ0Q3/IZzrzFqY50vqLo+3G1AkpPEw2u5bCGAHOetGsNToYIzBJXjUAOelLoUtwEfcbaX56cMMIBOfh2A5rtWGl/qyBeptXYb94Nzgc5R1HUQ7gilUOVmyRcCOlOdjHKoeR4ZNL9qwM2ULIQTD3G58bCM/M+lpimBQfuqrjr/wHpG7Grt2Rc5lFI1c25wzasRdT8jEhrzfCC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:43:12.5017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5708cd2f-64e4-405f-adfa-08df3f9525c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB934327
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:
 - Build DCN401 virtual commits and seamless plane updates in DC2, and
   dispatch the hardware span of a commit through dc2_funcs.
 - Add the leaf block-sequence entries a virtual commit needs, and read
   the accelerated-mode bit through a query builder.
 - Resolve watermark policy and the DPP, DTBCLK and DCN401 DENTIST
   targets when the sequence is built.
 - Fix DSC teardown gating in the post-unlock sequence.
 - Move HDMI FRL status polling outside dc_lock and stop it on fini.
 - Relax stutter constraints for DRR streams, including ramless idle,
   track static-screen idle, and enable the relaxation on DCN42. Raise
   the DCN42 DDR5 stutter latency.
 - Let DC_PSR_MASK enable PSR without a DMUB PSR cap.
 - Enable HDCP on DCN6 and the DF C-state vote on DCN42B.
 - Enable SST PCON FRL DSC passthrough and program the correct DP HPO
   APG instance.
 - Exit IPS before checking flip pending, and keep the HPD IRQ reset
   path from taking dc_lock.
 - Skip UPSP programming when the registers are absent, and skip
   visual confirm color programming when firmware owns it.
 - Align DCN42B with DCN42 and extend the IOMMU mismatch workaround to
   DCN42B. Restore the missing DCN6 vtotal cap and vstartup assignment.
 - Update the DMUB interface to 0.1.83.0 with an extended SoC bounding
   box, RAMLESS_LOBF commands, and a seamless-boot eDP request.
 - Initialize the DMUB LSDMA ring, accept a 1932-byte PSP footer, and
   update the default VCO frequency.
 - Fix the FFE link-rate change path and the p-state enable sequence.
   Commit the validated target when a minimal transition cannot be
   built.
 - Various cleanups.

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 916fa87d0dbc..2dff1b271416 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -69,7 +69,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.405"
+#define DC_VER "3.2.406"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

