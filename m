Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FF3C4167D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 22:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22CA010E404;
	Thu,  9 Nov 2023 22:14:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E2EC10E403
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 22:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTTXZgbr3M9SBv1xs02IxfQDZBVFFvLeLxXz00eIvADKTRv8mi6Ij7rDHEYGOzmf7cY4KpSLvoyY0oJMGhXpR4bEElDVcbNKRji69PRQXvkBadKUxOJiRKmcA/QawpzSwZ3z9ZrpFKL57UO2thw21v0EBc4OOEu0z71S0bekScoIR6zZfCzZHBGjX6b/v786gfhF6pQXsKSiBpAitUUN6qfCV+Rh5ywti/+zOBpxL0qfQppBTVqRKzU3k5GDQm4CjW5UrWxLdf0SQGS3ejfuVTO0+jjmmYXZWPsHiuFmPPJr0S6FF6qQi5uFSAATPwvzZyeQ/0FfzFW9r+e2ppJliQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DaW8ph2OJFXoY0uShmj05/gDaLAEZ2/B8DIgS7wiFM=;
 b=Q7RwVrNi1UsrGsAhfyYoNiQJsod/gl2Apw1pJb5mjGvaDXCHxmIwg+Q01gE+TJEcCFHzwFf4OfFheIx1xjQtvpn1JYylNxPcTWJ1a/eNAVYJYtmDFF/2+QxHOSx77nQxhvSH44v+KbNzxMIvABoTW/9weCzIOgPC4hh6g3RkrhRbZtXgNzXvhY4wCQC3ljI58PyZxCJfMhVrxNeXn5ldkyl7aYnuQfhqHlB60Xuzwjo8kKNIoZ3CGyUT4NcbgjT+IbIsjw0cgDa8ZwU98gjnLp+waAyLGb6WSR8MKmuVo3sWVDNU+1E8Wb4UaMymhw9x/cQoSl3xAdlwFq/+EGoAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DaW8ph2OJFXoY0uShmj05/gDaLAEZ2/B8DIgS7wiFM=;
 b=kr5nvGLkM5ubHRfFYSUXZ48PYixpFHsKR/vNqX230sci1hYPVHgk7ryP22GkOrLDz4fz6CKMvFs45qAX3jqwlNOE4x2MjoEToRlmnEbFETsomdtY7vutwN9aFfaMBucklgRsRPAsVkUo3fk6HPk+7W+hDVh0zMVB24kUuYYd90E=
Received: from CH0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:b0::6)
 by MW3PR12MB4505.namprd12.prod.outlook.com (2603:10b6:303:5a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 22:14:16 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::c5) by CH0PR03CA0001.outlook.office365.com
 (2603:10b6:610:b0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 22:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 22:14:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 16:14:14 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: add new INFO IOCTL query for input power
Date: Thu, 9 Nov 2023 17:14:00 -0500
Message-ID: <20231109221400.936847-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109221400.936847-1-alexander.deucher@amd.com>
References: <20231109221400.936847-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|MW3PR12MB4505:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f0494f-66bd-4965-eba7-08dbe171365d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4w5DTdQnOc1a0aHJ50ql/nnsHEAYG8IckMV6rMbR1j6bC+xcQt48QIoKGLKNObCMtQR5HzhYTAWPNHJ72jg/pT3dVY66LTt0CcmpWQF9KB0Xp2p+ZA+2/tPwmTOh1XmJFHwRxh5qQiF2bjo3PoTiPDD0/xTHJtTs3ZA+eYAxN7JmVhAfHePKTV+a6lQIwtvRgUEAPRXsiNVkfiB7mfMRHOtmPNShz/9ipcSQRIckUIzxs1/jKg9vtkV+U1npDD9JpWEdw6a631yPa9xo2Uw6PCawtNAqTNZrPxc71R43t44dPu0vIde67lCFB5WOALRBxI+frKWYvmJnAe5E7SOC1zDS2E0QTYVOED5xUuXY6BwXZFSEYFu38pAdCFEJkCxXtMjeB+tUOq2drq4i2X7xAHWZjah4hDOR6JIp+9imUTlqYfNn4Bb6w4T+61RZHM6jo7jvsHG+G7GstTahJwAsZ4OFyeK57nSBqRm6Rz/duBHhdXziwUhumTsZT+Tsw27UVoat+2KxAeR5uNFsWsTX5YBr2xEtJnDfQvRTeRP0dkteUn/SpLyDewsNsOUJZLc42VvETBOTb9i2T+JHnPTWg0gabYhroL+xuo2X0HdEZpoG/YC4PRzeAAmekFpLU270t9GTCKdhl3hJTyGFvdfdknGCzUOBI5BERM2R3FiOyYWr8qqL6eOvopPyBryZ18UYrxjjpKHVYWNYDJG4AdkFsOpmlPFE+vv4NWxuSTjizuQ2VYCL5quylVwInyzEpRL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(1800799009)(82310400011)(64100799003)(186009)(451199024)(46966006)(36840700001)(40470700004)(7696005)(966005)(6666004)(2616005)(478600001)(336012)(83380400001)(16526019)(1076003)(70586007)(2906002)(70206006)(316002)(4326008)(6916009)(426003)(8936002)(8676002)(5660300002)(47076005)(36756003)(41300700001)(81166007)(36860700001)(356005)(86362001)(82740400003)(26005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 22:14:16.1954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f0494f-66bd-4965-eba7-08dbe171365d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4505
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some chips provide both average and input power.  Previously
we just exposed average power, add a new query for input
power.

Example userspace:
https://github.com/Umio-Yasuno/libdrm-amdgpu-sys-rs/tree/input_power

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++++++
 include/uapi/drm/amdgpu_drm.h           | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index bf4f48fe438d..48496bb585c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1114,6 +1114,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			}
 			ui32 >>= 8;
 			break;
+		case AMDGPU_INFO_SENSOR_GPU_INPUT_POWER:
+			/* get input GPU power */
+			if (amdgpu_dpm_read_sensor(adev,
+						   AMDGPU_PP_SENSOR_GPU_INPUT_POWER,
+						   (void *)&ui32, &ui32_size)) {
+				return -EINVAL;
+			}
+			ui32 >>= 8;
+			break;
 		case AMDGPU_INFO_SENSOR_VDDNB:
 			/* get VDDNB in millivolts */
 			if (amdgpu_dpm_read_sensor(adev,
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ad21c613fec8..96e32dafd4f0 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -865,6 +865,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 	#define AMDGPU_INFO_SENSOR_PEAK_PSTATE_GFX_SCLK			0xa
 	/* Subquery id: Query GPU peak pstate memory clock */
 	#define AMDGPU_INFO_SENSOR_PEAK_PSTATE_GFX_MCLK			0xb
+	/* Subquery id: Query input GPU power	*/
+	#define AMDGPU_INFO_SENSOR_GPU_INPUT_POWER	0xc
 /* Number of VRAM page faults on CPU access. */
 #define AMDGPU_INFO_NUM_VRAM_CPU_PAGE_FAULTS	0x1E
 #define AMDGPU_INFO_VRAM_LOST_COUNTER		0x1F
-- 
2.41.0

