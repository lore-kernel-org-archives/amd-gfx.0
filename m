Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D27DC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E156610A5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E156610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A3B6E513;
	Fri, 13 Aug 2021 06:35:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C740B6E513
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 06:35:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KK+NWRMsDgXIcpMcDXLZg/gc5R2O6XVJwaeBqWW2karhNx0MlCxDMrJNWKFvBFyX8vG+P/z5fHvuHm/Zwjc6n+S2VpVWTeC5DQgKogbwEC3ydzFaMQKJO2ny/3DtiDLqeBrMrFh5ezj7QIJ0WYgzYKm1VANL2+ltRZSPaJmN/aEYIMAL0AQz3PQ2meo7g+/RApqPigQncwrZCuoZTcI0GUZZZcM99rQeXU7je6mhpS4ztwIBeedim20eeYTTm0mGcIgXBNnW5KE10u+W6BxT14jCmAaEcJZY5nBbmkGhDIX8zuODZerKh9SqWKCwq7JiG7FiJbCasX/1iCftUetXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygo6P3mh2mEI7syFe2kpvoJyLUXN/PNCa+uY/aaKmPI=;
 b=EgVlsu9XDE3PTPfDCLOqGowkt5PhNEz2Ixggp1SX4CYYt75pxudd0JzydqlaPAzy+3hhr+OQcWWNbC4f12XpfbL87+LJBTC00gfyl5FbzhxL9UbHCKxy47HnKxAJFmDiDNwZ6AGRb8g+tjUUDD+eSmr9QUya2sv9coQXZwt7BRlo/iKKspFVQrazu9VqfoEwCvOc1FmbxuniiV0pcChsMHFyYy7+hplph3c46kk8GLFEhnCL+S1q4Xk1BdkE17x1EPhhp+qbN4kdZHFXj/+Gc7HRqmZe+Iw+Mq1z/op5bi1c2Ad3Z8J5m2pNhWFBhrX3gLQG5odmg/AtXt+WRvpmFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygo6P3mh2mEI7syFe2kpvoJyLUXN/PNCa+uY/aaKmPI=;
 b=yzzHhABBoOx9meaZWMil1mWG76sVa2/oP+rUkoKvFICF3Qzr0C4BB/snp5PQCeBun+Bjm04zwQ+s9IrNV5AGIsvZYbh8JqfxBPhFR4026mC70foBDhTPAOw7I+AqJoXvL4s4pKSeXVkVWWYNRO21yI7xf9GV19zh8ufpS0Zx1GQ=
Received: from BN8PR16CA0005.namprd16.prod.outlook.com (2603:10b6:408:4c::18)
 by BN6PR12MB1186.namprd12.prod.outlook.com (2603:10b6:404:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 06:35:23 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::66) by BN8PR16CA0005.outlook.office365.com
 (2603:10b6:408:4c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Fri, 13 Aug 2021 06:35:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 06:35:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 13 Aug
 2021 01:35:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 13 Aug
 2021 01:35:22 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Fri, 13 Aug 2021 01:35:14 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <bindu.r@amd.com>,
 <Anson.Jacob@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Wayne Lin <wayne.lin@amd.com>
Subject: [PATCH 1/7] drm/amd/display: Create dc_sink when EDID fail
Date: Fri, 13 Aug 2021 14:34:56 +0800
Message-ID: <20210813063502.3106309-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813063502.3106309-1-Wayne.Lin@amd.com>
References: <20210813063502.3106309-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0807b3b1-2c20-4a37-e948-08d95e24876f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1186:
X-Microsoft-Antispam-PRVS: <BN6PR12MB118604D21EDA953BDC9C4EB5FCFA9@BN6PR12MB1186.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGR3pTkovVcBbO94tDqPBODuNGOUH+cRj2wc8AMagoNmEbHGrEA3ZLQhPtSkj0L3taTyfE/OHSUT16Za3sb6SpBVIvhVA464gdV1m53LF5OFJPSQk3oyPKQavYvxSZ0utvoKR5ygSDaCl2DtED+4+Kv03UJ1bG0aftmtXDSiF9JQlunucsEbw62i94p2z53gTez7jzPRFYC3bFuSMRkPAJsc+bvagE6ciMgdYfo3GGe3Xusb+fqsPH1AY4nIsBoRJxrQkH6GXKWwahKrZ6v7v/x4m0ymiZDOKaZ0XNdwwobSd31huTPY3xJBmw8IJHDqDGLaTp6gRW7AiDd3kBbBto/kqccP3lcY3D9RgZq2A/nY5ACUA20gVeoMenHUQ3tBhjzrqlndxNSlxLoIFAo5yeaGAZdVgXA8rXgHrfhs+JCoHD8l/yo9ULC7YXzN4ZKtKAxVteZHXV1JEv28Qr5DG4weXSJnko/PSrPZUSLdQBrWSTo0HWuuu9Ytx9lR5npS5INjZaP0sDr9cv8mDDoXrMVgQ1QYjLWfw9yNGIzyyGTd36sRk0bCFnvIZdqe6mw/dtq+7Doe8/gD6f1cImo8QwgTziAgRWIauU8fwvEyUiaP5IywPl/xgnIfBhNoELX9pX2mF5c/8GBoMs6YNc+IsTXJgtp04ju3dpMzwvTL1sdihDHksdDXuUStAAXGyPNTep5v91wREJ1l/wFoyw8RHn8I0Oy16G0U7w7iEIYX5dq98Q45l9LOITvHXDrMPRChL/ggHtSBD9Ix1GOdgX5b3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(83380400001)(336012)(70586007)(36860700001)(47076005)(186003)(1076003)(4326008)(86362001)(70206006)(2906002)(316002)(2616005)(34020700004)(54906003)(356005)(7696005)(8936002)(6916009)(6666004)(82310400003)(8676002)(5660300002)(26005)(426003)(508600001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 06:35:23.3298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0807b3b1-2c20-4a37-e948-08d95e24876f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1186
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

[Why]
While reading remote EDID via Startech 1-to-4 hub, occasionally we
won't get response in time and won't light up corresponding monitor.

Ideally, we can still add generic modes for userspace to choose to try
to light up the monitor and which is done in
drm_helper_probe_single_connector_modes(). So the main problem here is
that we fail .mode_valid since we don't create remote dc_sink for this
case.

[How]
Also add default dc_sink if we can't get the EDID.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 5568d4e518e6..1bcba6943fd7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -213,6 +213,29 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 			drm_connector_update_edid_property(
 				&aconnector->base,
 				NULL);
+
+			DRM_DEBUG_KMS("Can't get EDID of %s. Add default remote sink.", connector->name);
+			if (!aconnector->dc_sink) {
+				struct dc_sink *dc_sink;
+				struct dc_sink_init_data init_params = {
+					.link = aconnector->dc_link,
+					.sink_signal = SIGNAL_TYPE_DISPLAY_PORT_MST };
+
+				dc_sink = dc_link_add_remote_sink(
+					aconnector->dc_link,
+					NULL,
+					0,
+					&init_params);
+
+				if (!dc_sink) {
+					DRM_ERROR("Unable to add a remote sink\n");
+					return 0;
+				}
+
+				dc_sink->priv = aconnector;
+				aconnector->dc_sink = dc_sink;
+			}
+
 			return ret;
 		}
 
-- 
2.25.1

