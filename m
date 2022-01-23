Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D887C4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A284410E851;
	Sun, 23 Jan 2022 18:21:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA09C10E438
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHsdv/tNi2Oi4g6JQ5zvo+PQMF2VwjK4El/tqoYGYxb4vw2lTsVpPPESVoi0ZyISCC+hip/Ue9j1iSSNobMfp5UobSCDX5zkFXDNV+Fqek7FipiB5wgU1xVM4zGjdeAzCIvFiRQh3z1dmZojyolW7/ebmDJfNtbn32isXTNGwRDDci6SG7Xl8Wjz7YR/BDLs3L4oNkhUaHv9z891Dr6OlX3hQFois6hEOxMz34M2Fyd15Z+J/xpayKwfyCMfgMR8qDlY9f7GMndem9uJLk7qcu154QyHUGzCtkUKU9m+nwqvFBfXxd9yaR6UCK4NRkxoajWJPVk1ZABGVoWoY0wXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksUdBmoOgaRVoe3hKcGuSIHp5rMRUGtpoglnEDYMzfE=;
 b=LgB5Fthb5IPxutA72sOu2ucm2xNqfOB7Wf5e/XECdvIwitT9nJbhWbA/4a//M/bJy3FmFrWK1RCbnHLPCso7L4Z4vsIBDifQiiyxXJxhLNsMmFDYNONPntTTe8k17SyomdrdqeOGWPbU+22wJInp0x75geI0p4rnVITwGPuzMFmVxojT0jzHMFZJsxr3nPDO67a6gDXNF/UhzoPUpZ0AYW8QXEObqooi/NGlEEbWSbLqTpUKGpgGOwmKtXprcmx3QRTk/TvAIxChTqCA536cRM4iB5kw3UJaZ6TVgecLKIfSOrQGAZQ+eZryuU3T6O9aqPLO1zFKQAeOSKH4CqaVvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksUdBmoOgaRVoe3hKcGuSIHp5rMRUGtpoglnEDYMzfE=;
 b=OlTe40c1OIl0KVywj799RgmiGBmSU0yC6rbg0ODWEWRA03/gIFkLrlJnRyrTN4SuamboAKBq7jrkt0T04yIYBodiZvq6SHjtr81kr/uBAtT1UC5NiD+0PGtpSbWrABEElrcT8GvkzFiyDrIdxFLCy5Fra0Zi6BCQHRexWA2dqH4=
Received: from BN6PR13CA0059.namprd13.prod.outlook.com (2603:10b6:404:11::21)
 by BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Sun, 23 Jan
 2022 18:21:05 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::e4) by BN6PR13CA0059.outlook.office365.com
 (2603:10b6:404:11::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.14 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:04 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:21:02 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/24] drm/amd/display: Retrieve MST Downstream Port Status
Date: Sun, 23 Jan 2022 13:20:07 -0500
Message-ID: <20220123182021.4154032-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56c119de-cd57-40ce-aadb-08d9de9d1e02
X-MS-TrafficTypeDiagnostic: BYAPR12MB2822:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2822A51DBFD6DED0B3E0DB25985D9@BYAPR12MB2822.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILmYk4+zC0+CsPh4ufKa3pmZAYLwz7UVGXmArI5x2VRTWmolIX6+bXOXgr7cLsv9hA7U9Uc9JZRv7ZtkdOg3VbABHHBRSHntKMtsv17mW6SyLWnxVmftIxU28ovkRr+RiCvsEBvfe49FIs3HTwZyt/vmIK75jVnNwpwdKrNx50QUXk6DTrXqkK5VDJb2zJ9nV6yTy55sq7o0vzqpVvpbFRxqzakf9/FHOkxUdiVmJjJ5Zc7eCq8U+/Zd3pj2wl5iwfCMJeTEOcJXNqk1QVktNTlqj1cfzXxiq0rwfbT/W4zj22dUWbfwOGsIQZpe2BVwN/VEHVXFZl/xScV2MT85KHUUwSLQbO8rLLnlQX0VxR7ATv0cfS8xEpvdvSspA1TBpOnLgjygfiwt2uDC+VQJzTYG3v6il4prT9+u2BchSJZbuodgN0qeRagzdfBVEAcQNEb80kuJXv96OdyepgsW0Aq6MrPSLyMhDitT6EQVmsOCKkVYzj6xnWfpuuglKVq3dGnsOgPmuE+FpQwfOX52N99chWqIdgOE2CW+8lWtCcRhw+7aEOdaOrpHGo3VrRIzFFCfMj+KQxvMUF8lBVFoVlpyOjWCof2jdG3BgQoqfIZDjut1d3ks6ktCpdfo3NhfuO++jzPCmOtk/4kRtuOG5QdZEKTRlY0KTWjHXkZuE7zNW5kXlJNebC1beld2D490HlMBHIv7Reddrh7jIEUnCsuXz4Je2yjU4YpOWXSSGqSXxcSygG0ER3uE6jng9bxnDAQfhi8FS32ddCEKs9/5qgcFmpC6Grs6/NRTffXQgh8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700004)(82310400004)(316002)(4326008)(1076003)(6916009)(83380400001)(47076005)(70206006)(36756003)(40460700003)(54906003)(8676002)(8936002)(16526019)(26005)(336012)(36860700001)(2906002)(5660300002)(2616005)(508600001)(426003)(70586007)(186003)(356005)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:04.3890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c119de-cd57-40ce-aadb-08d9de9d1e02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2822
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
 solomon.chiu@amd.com, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo.Pillai@amd.com, Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Determine if DFP present and the type of downstream device
based on dsc_aux

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 23 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index b9a69b0cef23..e35977fda5c1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -604,6 +604,7 @@ struct amdgpu_dm_connector {
 #endif
 	bool force_yuv420_output;
 	struct dsc_preferred_settings dsc_settings;
+	union dp_downstream_port_present mst_downstream_port_present;
 	/* Cached display modes */
 	struct drm_display_mode freesync_vid_base;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 23cc6a6fe70e..8e97d21bdf5c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -209,6 +209,25 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
 
 	return true;
 }
+
+bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector)
+{
+	union dp_downstream_port_present ds_port_present;
+
+	if (!aconnector->dsc_aux)
+		return false;
+
+	if (drm_dp_dpcd_read(aconnector->dsc_aux, DP_DOWNSTREAMPORT_PRESENT, &ds_port_present, 1) < 0) {
+		DRM_INFO("Failed to read downstream_port_present 0x05 from DFP of branch device\n");
+		return false;
+	}
+
+	aconnector->mst_downstream_port_present = ds_port_present;
+	DRM_INFO("Downstream port present %d, type %d\n",
+			ds_port_present.fields.PORT_PRESENT, ds_port_present.fields.PORT_TYPE);
+
+	return true;
+}
 #endif
 
 static int dm_dp_mst_get_modes(struct drm_connector *connector)
@@ -289,6 +308,10 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 			if (!validate_dsc_caps_on_connector(aconnector))
 				memset(&aconnector->dc_sink->dsc_caps,
 				       0, sizeof(aconnector->dc_sink->dsc_caps));
+
+			if (!retrieve_downstream_port_device(aconnector))
+				memset(&aconnector->mst_downstream_port_present,
+					0, sizeof(aconnector->mst_downstream_port_present));
 #endif
 		}
 	}
-- 
2.25.1

