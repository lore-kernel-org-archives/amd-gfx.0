Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF625C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 21:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65AFA10E87E;
	Wed, 13 Dec 2023 21:27:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE73210E81F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 21:27:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOVPVwZHOZvmS3qaRNncgwMckKvCrphSVW2Ud5I91ytXvVhgZjvnFJ5SE6UH00g08WxwdjX9+GAiI/+xjeonMPMJyJlQxJOU/W2utiJfIDGV3US1Nd56xcQLCB/dWPIUEDkg6qQo0jrvlKOlWQImDWJs6oZQZUbPhmKzXypTekCV8ngx4MgUlphwxgmQk2/mlEnk10fchNXMsmLgfms26txKwdPUJiI1qZ6nIKBFCUXoLvVLkrHr61EKXpQ/9QffV906v7JhHGCM+E5c3XNe72/C+F+r9UIh5gKIxRIiNi1aMsdmC3lEs+4jqbTkXFx4OUvwWLO+6WHxxsUlvNLYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyALNXo1banNm9NjGJtObpu/SWHz7AOucOvZRvmDQx8=;
 b=ZIR0Fr3iCcLm7bvfmbJecC25oDYb9cFqQmgNf5thpXI3UgZarTdN4Zlozl/iztwEq9Loy/EWyPEWaP21VzftIY1EjTykVsilM1/bV/DeURS6sYcrpivI/dkBEsFeTCpJfeoGfZmmRijyYhS5+YA1a/ziTbMmTV9VNwY3275GSfc+eBXLLnXCNa3ToTfeZFvxc3SMQ5p1wXlK1W6mwtakMnZJG6+P1TuQwSbynHY5/37aSag0RWOtu8N4uH0/d1HWUeTaronZdCWRhY93AVUvwGsju5ZwBlv9nICVCDJQK1o1TCQzTxZgGrCZuk/T42LMsIDALAFksCHTDb30F5vSmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyALNXo1banNm9NjGJtObpu/SWHz7AOucOvZRvmDQx8=;
 b=O6SNy/V5UJTQSf3+IY0J19M4OCB0NATCJUJoMuRrCymUMVoawdjkHq+ScDJ+ALQ4Z07edQ47NfJ2EfRCJtVZFU2/lOkgnXnGiE1X4mAC2gIrHhoILM323ERVtSybWdcrfKhJIWG5zLmxu56DxVyTuL9c+hih8X5JnCKxPXfbAQs=
Received: from CY5PR15CA0107.namprd15.prod.outlook.com (2603:10b6:930:7::16)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Wed, 13 Dec
 2023 21:27:45 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::40) by CY5PR15CA0107.outlook.office365.com
 (2603:10b6:930:7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 21:27:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 21:27:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 15:27:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: add new INFO IOCTL query for input power
Date: Wed, 13 Dec 2023 16:27:28 -0500
Message-ID: <20231213212729.1965153-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213212729.1965153-1-alexander.deucher@amd.com>
References: <20231213212729.1965153-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 973e70a0-f02f-4bfe-2b4e-08dbfc2258af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HbEMJQqhUsVt4J/AaYrQ4VFdMzdJ2S8eJWRrz9pB+i4WFZ5he55fCqKocTTmuyHyXFldWuQimde2tLPgH2DPYTL4te7wMOKEXcfM8hmWl/VGSeNL4HoLIpZuxx1Bb02qi81oTfkRP+T583KjEdpxMFySgpCyVzjrqNavG4xDFYSHB3y7BxW7n1X2iNCnl5SKiNqk/QJbeW4CXDq11xKbyl2bEShaLp3PqNWQPf1P0pPxyDFGXh2EHjXu5U7KtzqwsuvXdDX+rLQGDzlca7E9IdL87AH2U2ohEPxAKnYdxIexDFF/IjEdRIfRmWfvXL4fkVJgpax85VZizeK4bs+/ODW1Kxt3IfsirWvr6hag7ERoz0RrFktqbUzSP3au5OKuFmR8va3di/jY7RgO6UQMNfn8oBn/2Rlvxq0Fye09mn5Tpkz2Z4vSGQBQhLn0wG5a/Pzg5RyRzAexQlsBEmFF6JHSGBLhr4Tz+FBYXbbgIkQrXAErncH3NON+2oFagsavGBy6o8hyRkIbt4dIyyV4ddDb2M4+gfpMlqFm6rlBbnrL2r9m74Ke1QTcLm2ZRfs0wFZn7EPfOKR4W4DyZ+IYehTrPm7J/2vCQt8IzVYokatiGlwObsPpZfV3V7l7mCfqmdai+82JIzVwONk8V2mwputFHf/SS7RPldyY0o4HI8+zsOcg5sPDxq6WgXOA1Z/5l5+0CGhTYy35nAJ39MIW10YVgh5fWFhvkmGnX+URAP2CxXgLAB9HVhb69mJ3OoT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(86362001)(4326008)(8676002)(8936002)(316002)(5660300002)(41300700001)(36756003)(966005)(478600001)(36860700001)(426003)(16526019)(40480700001)(2616005)(336012)(26005)(1076003)(6666004)(356005)(47076005)(82740400003)(81166007)(7696005)(83380400001)(70206006)(6916009)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:27:44.8925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 973e70a0-f02f-4bfe-2b4e-08dbfc2258af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804
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
2.42.0

