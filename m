Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDE5EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 04:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A111210E3B7;
	Thu, 29 Jun 2023 04:47:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D9EA10E3B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 04:47:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cz7U2OaTf+HJvtIetKQhiWQGipdAmIn9Fav77QKpQ5SEDuQds1MEjmS824ABhE0Ge5ujAow+5DpQ42C7Mx7uiIXm/DtlSxuKeqjW5qJqdEZ+LjVJPnYx3UykbBN0fxV1T8o3Ac/UVUz2AF5T5BG79jeqIH390FNS8g3fGHPyrHiFjWZ1JXJS+vLIccHv/ddyCHRHkQ04eHr5QXVhA+t0cfXlVhtcgshMLYd6hfyuHubwqEf0jTuBL+WpOQRpfawSKGqYqaU5ZQUO9q2Lkp7222mTc2UWQgngN3BCc45ZPRHGUPAfhNDAwstbNHYUuOQkHWiJGiOmo0Akv49Jg9QzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7lErXXSLebLyiY72TF8yauhbRsVpbc2nfhS7gIhrdk=;
 b=dWtIV0wPVJ0nZBNrQHSiOhPZBlc2RGiyavN538i2yQ0ZD7Hu8A4aBn7guUQDP4tiZ/ZeIrakf5fi582zlZNhF1PAQOcDmQ56XqLIrISYcfN1KY73MxVBEsVgZQjoGbzI10LAy42LYufFveZLf26pZlYQ9XCaLgELXony0X1PD2OTQ4H5guCBkn8lW0vxWkPZWVC1qkP8imtgJs35KejdGneMbMPTcoZLdpwBp/KSjddDYfyY8b7j1AM3iCBY5RP1BuvrrcDP7NY3MmNp+Jhs6lYnWIw3VRba5Vbze8aLPeBVwCpaSRUh+0aAkdaKN3OC4gXq67rGuYqIeOyoJOZytQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7lErXXSLebLyiY72TF8yauhbRsVpbc2nfhS7gIhrdk=;
 b=OQmSNlW/EX7ARSEnrDnK1i2evTHrx/IN2vuY4MOVX6FdWARwvhVfJqPeQD/+hOeq6kjqOj3ZBLEvFbmT5MEoQeVfwgdONqummBvg0uJGoHLWvi8gW1NeK3pkm2t389KxElL7wXIuxFzGeVu6I6EIlUeOJeHTt2SGrdu7gmiLBYQ=
Received: from BN9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::7)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 04:47:06 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::2) by BN9P223CA0002.outlook.office365.com
 (2603:10b6:408:10b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 04:47:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Thu, 29 Jun 2023 04:47:06 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 23:47:04 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 5/6] drm/amd/display: Clean up warnings in amdgpu_dm
 _mst_types, _plane, _psr.c
Date: Thu, 29 Jun 2023 10:16:34 +0530
Message-ID: <20230629044635.2266729-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
References: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT052:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: e3701354-e2d3-4f18-9d94-08db785be421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GKIADkdBTdq0h/UhemS9tCRS0Mt0sM1244bnN7aX4F3pEPU1ykqJH7qV/Kgi5TMIkVarXi8eoD3bq8jktwY0lP3BYQVp8NZdkQn1D2oPyZvsDT4rHZudt4tJyjoIP4rgWkwEpPpUX+uyho1z+SdNr8AXkEH40NQ8gdrtLIoeuV+0YiYqSq06doEha/UTUeJ/yDpD55tzInNaYtjywTC+Kw9arYOxaDtlGA3wmR5rhdMqXar9vb4pgwa96Y7ypRA1Az/c0qesqbmZB+hAF0eEApUHrCTHADKY+uohMnKiC1iWNzZNBO91JMz3/K2pJYzWvX1bu4mDRGSQZuWsNiq5sxiKXXYKVLsGi3X5E8jdsi8a4vpz5iq2LSA4Xt9tzqEAvjVJApxV0QbPA0SovYi+wk4dRQdexgj+OXHaorTznO5PSyTv5SSrgHsmazg5EUyQdn+x0udYwHwR3eo21CsYPMdoOyXzZIYHBWEldWAFypfXZq4skchVm4110bT7YUrn7ms82DU4Lom+C3ELa+bi4i3VFmL6YNnhSIQEsyaxJ+Zy0MtlQJSD7fRxp/pXWyVaBSHjAnbZIrKvjKls6LchVlzvbahFU88cfiMbfJqGoaNX/SzN0yQ0rH1zz0DUmesn4FmotKIT/XanMwD4KwQ8VcZ5zYfZOACJoe25pJGQyk558dTPHvB9H+0cKgLrB0B5ljQ/JmfVejRe9TB5RqkbbxyaxAYTFsJoiZyTB1edGjsThAMPp1mp88sv/ruCphd718tG6gtoxJgSpAXKgqOvEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(26005)(82310400005)(4326008)(47076005)(82740400003)(44832011)(40460700003)(70206006)(86362001)(8936002)(41300700001)(316002)(8676002)(6636002)(5660300002)(40480700001)(81166007)(70586007)(356005)(110136005)(36756003)(186003)(2906002)(6666004)(83380400001)(54906003)(1076003)(16526019)(7696005)(478600001)(426003)(2616005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 04:47:06.7353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3701354-e2d3-4f18-9d94-08db785be421
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following warnings reported by checkpatch:

WARNING: Missing a blank line after declarations
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c     | 4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c       | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 46d0a8f57e55..95eefa6b4f2f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -296,6 +296,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 
 	if (!aconnector->edid) {
 		struct edid *edid;
+
 		edid = drm_dp_mst_get_edid(connector, &aconnector->mst_root->mst_mgr, aconnector->mst_output_port);
 
 		if (!edid) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 322668973747..de1c7026ffcd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -164,7 +164,7 @@ static bool modifier_has_dcc(uint64_t modifier)
 	return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
 }
 
-static unsigned modifier_gfx9_swizzle_mode(uint64_t modifier)
+static unsigned int modifier_gfx9_swizzle_mode(uint64_t modifier)
 {
 	if (modifier == DRM_FORMAT_MOD_LINEAR)
 		return 0;
@@ -581,7 +581,7 @@ static void add_gfx11_modifiers(struct amdgpu_device *adev,
 	int pkrs = 0;
 	u32 gb_addr_config;
 	u8 i = 0;
-	unsigned swizzle_r_x;
+	unsigned int swizzle_r_x;
 	uint64_t modifier_r_x;
 	uint64_t modifier_dcc_best;
 	uint64_t modifier_dcc_4k;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 4f61d4f257cd..08ce3bb8f640 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -166,6 +166,7 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 	 */
 	if (vsync_rate_hz != 0) {
 		unsigned int frame_time_microsec = 1000000 / vsync_rate_hz;
+
 		num_frames_static = (30000 / frame_time_microsec) + 1;
 	}
 
-- 
2.25.1

