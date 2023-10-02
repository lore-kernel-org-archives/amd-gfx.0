Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DA9E74913
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 18:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F8F10E078;
	Mon,  2 Oct 2023 18:49:41 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A552610E078
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 18:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTQx/y+lBAGNNrVBl4Y/yt4XFeZrdQjZEEUenYEZBBBaY8D83dNG/4doFoCzTQXFP39cQfOnxDm74tbQGXdRE5otDf7EzDSxAHEZKkA2Z4KmkNkB6r+YbjCgKKG1yz20rPE39zifZo4bySm1dNLKCu300wVIW/l67m1W6GAF38+7elflSg8CjJupHbArl3Vcjn57bQ6DAyZ71PnvjUuBVn/Qs2yTTTzRAHA/LDiBMkufZoWOTYYOfrh8oJcqLJmRw3/7Qxfg8rWM5Fs3BHLV+yeIFwDfM2unT4jZMMTuNzcxwyzUeKMIWZq2aIRAS1C2bNzmNLA32dWKteH4P7ogNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDWIhdeYGtE+YAHk9mLKffIg4Clt3orO13bQC2zw9ns=;
 b=guO+TmI+BRJ4Sz097+pvNSR+7iBWMDOikWIVZlaIXvXn7w3O4KPNL49DERZv2dJVi6nxEtubY8PhqdXyw/Y+yXWgURsT4BScQNcO7HclDP4yca+odb5fCoKG7Q7XZQUBf4ePyQhmoJ0Qquhk8LeMPKXsT+cuLY3R3AxDigrYPQ5F18zsG3S2AYa/EfosqLG0ZrJJ+KGTnzR5SJcTYLuX2+Xk1/+HwQTI4ahLKX6K+ppDjkfR95/ePLaTc/xTRWI9uDBYcStN5yNPGBcOYtdwLrZeQosp2iQtBYHYYFBwS3LumRLTnaLVakDplAfm2eAVh3NOLbK6jTaSEBxvI4hvkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDWIhdeYGtE+YAHk9mLKffIg4Clt3orO13bQC2zw9ns=;
 b=VWB/s1y4ZPhp3F9anQwfi7BNNyqzG6wgE25ZD/vGmAC3i2IpU+OJWU73IQEOo7+nR7KIOPklxFrXNZLOMcwXOFJUlcJDCpCZ0g+owSOQJ/U/h78D2cIEGaK3Hs46EWf2+nT6peTxBhRZrvexBHihe6BjzR8RNIMpDAOqziKcKBE=
Received: from MN2PR11CA0013.namprd11.prod.outlook.com (2603:10b6:208:23b::18)
 by SA1PR12MB6895.namprd12.prod.outlook.com (2603:10b6:806:24e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Mon, 2 Oct
 2023 18:49:36 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::64) by MN2PR11CA0013.outlook.office365.com
 (2603:10b6:208:23b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Mon, 2 Oct 2023 18:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 18:49:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 13:49:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: add new INFO IOCTL query for input power
Date: Mon, 2 Oct 2023 14:49:19 -0400
Message-ID: <20231002184919.77753-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002184919.77753-1-alexander.deucher@amd.com>
References: <20231002184919.77753-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SA1PR12MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 24115c68-a8e9-4b98-89b1-08dbc3785340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UzWQu6ZA4jkCawNPPOh+ysdSGCa+N6N7yj2IOda/mBCj0O80/WHk/UshAEnYEDzU0//48He64EZ3BKtFqRet3ET16JnXDVf+IJmoRqUB7zHjMhPhGoxAr163H4K/AghvAJIb6KuYylAfmYMuV9p7Nnpj7xQxZnQuMaoFL4uSlcZNBVmjv+evEQRqx4JTOQevZ1J27r9q2rNI973Ac+OStbUZHmHrlu/+vA2JTDK8hox1bGUskde9nUzTySfAAfXgvpKZWxLV11O++HA+dMamnHSTRvvrkYA/J/TPcMRZFjdJXhQgyX4WDmO6RFkr1SH4tLQoOGYivTg2PuFPGZuvEFSfTZ2kstFlEKhfG5Gritf/pQhapYQ5Hyx9Wsh54JULBhZrWAfBobxve4TyvLLgMk0Lck4ziaV5X+xRApkodM6NpktANSeqQfWRavGyF7bBfrAv4IjJO0ljFjMkMODpwpt1B+Eeioo93SfDbFRTBBixOD/IlkvHSI4nXAzfqyRN7IZ7HjunrbvsAnmEp1/ll6uk4ofg/oe2/sQuVsEV2ltPWTpoEEpOTgGyELnk+CC0maM1GrGsQvjikeOfr0A7YMOzMYYkLkTZqeh2GGC/0edH7I90HzDUFO4VC/cgfgzf/ZC6QNyhFdlQAKnrB/JBSdnMmG7JFon3h8N/nBszf1BrYbgNIekgHnscKB89JT/9+BKb5YCDU0np/EqWXMqFgAVCsmPNdXE5bJCu4UzZZ1aVldiCTB1y/5y0ytjzfdqDbcJe6KK3P3JDx9P1Cejlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(4326008)(8936002)(8676002)(41300700001)(26005)(16526019)(1076003)(70206006)(70586007)(6916009)(40460700003)(316002)(478600001)(7696005)(83380400001)(81166007)(82740400003)(6666004)(36756003)(2616005)(426003)(336012)(40480700001)(36860700001)(47076005)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 18:49:36.2818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24115c68-a8e9-4b98-89b1-08dbc3785340
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6895
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++++++
 include/uapi/drm/amdgpu_drm.h           | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index ce71f853931a..fdf8af570af0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1086,6 +1086,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
index 984fc16577ca..4152123c3d86 100644
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

