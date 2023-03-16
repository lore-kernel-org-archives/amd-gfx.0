Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A51C6FD19
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Mar 2023 08:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E4D10EC7E;
	Thu, 16 Mar 2023 08:36:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 099FF10EC7E
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Mar 2023 08:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzWhtzPOXX4dDd0Pwr094ssUdNXGOv8pdTv5xYxO7nIdkrTizohwhkqy8qC0l08XTEK5hX6pA5KRO9D+knoAMHy6saKxHsB4/y7ob5KhMvgKsIJTEr/DjXimZzCWLgDMw6BE+TEtoVhBEB2CttTYUTbT+piQ9kyrr7Sh3KuUTko9WCmI1pRYYakEhQViWA4m7eXRRAKUkcnlHUDWxi8NMTohsVYPPBM3narMzmYCflWjubElokGYkZeHGY9FP2+c+2aa66uNyRdYINoBJ44C9i3lApsGHqdZNKf07fVNQBxAFEMCCJiC+avRnU8ZZb+t4Lo4zAqw4Q8/Ms/WWLOrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw83IkhCH31ghyCYWD4PpO4IjGHtrK4Eqdcv2Oygt94=;
 b=Tv5iLy92WjQMKa3iOs/5TYZ5v63/PZJjIViJmCk1AEBrROlq/5HsmjzgvjVBetZqFADKX0cRK8Vfb5+HFAJXbmrjpFRIkU/JAURlocC4nP2QFi+S+fPMzCmVHZPbi8FVFSH0DkDVpw9ZN1sJCtL4CeKcMBtf7Eeyvmxm5i1GcfirJodq1MNGcRnpk4MmDjmB4k/l3cOBLQQHjrNwUwB7ZuK0mTb2184w9z9ZL1NBZ2UGd6UYbxh62eJUCbKVacusy+xkTHnRy+6OLQ9BMBn6PYrI4sYrNUdmVcnVFNvdkn8VnnuPRa5paCxvvuF0pfsA6BQUghq0V2szO2BVFGSwrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw83IkhCH31ghyCYWD4PpO4IjGHtrK4Eqdcv2Oygt94=;
 b=1xbsczYRMBtGG4yICT23QzVYx6yoIbPXT/Efps3NuT6eDd8WYfIezmPfbx3YPcYbJ6rkPeMSe8Pt0T9+MTKUTaZAZCWnM8euS0FCElhYk2UmPXwzJuXPb9n3T5z/tQjA2dI+MaaGA59X5IwIEMBDTb2ARLBP4V1W/VUe8fgTOMw=
Received: from MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11)
 by DM6PR12MB5022.namprd12.prod.outlook.com (2603:10b6:5:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 08:36:50 +0000
Received: from CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::30) by MW4PR03CA0306.outlook.office365.com
 (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26 via Frontend
 Transport; Thu, 16 Mar 2023 08:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT095.mail.protection.outlook.com (10.13.174.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.18 via Frontend Transport; Thu, 16 Mar 2023 08:36:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Mar
 2023 03:36:48 -0500
Received: from bliu-X10DRi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 16 Mar 2023 03:36:46 -0500
From: Bill Liu <Bill.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Adding CAP firmware initialization
Date: Thu, 16 Mar 2023 16:36:27 +0800
Message-ID: <20230316083626.248647-1-Bill.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|DM6PR12MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: 166defd6-6a87-4e7b-a099-08db25f99636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dFfFN9IT9OQabhYkALfCbZWhioMZX74oHdHXNuK0QChvmHAkEHB6HK4ShBJb4Z+exRMW2fpeknHKPG6jkZDOEx3PS/zFLnaF5hLmMyhMQ8xao3t1kOxmFHU2yhDKTMYWsp0fIHK9IB2yRq1fHrJMGs5hVnQj15SrWDpkG2UHlaVY3wvSNiGQLk+leXeW+sG7u7tBJsEZ2L3yceOx3qbNSWMAVZZW5tHflstq0/e9oB+Ygcy7gZMwYzc4YoeKMwPwhI8lFr7/x3kq8mBWosLcvhgdnSXvHtuAvv0rmOVJ6oCfyvY1sXpIyVwQ/r+e+UwEU4kkSDNOMgxgYuAjEWEk64AtTyjtHewGCOarooqInMRKtyxJh4o/wc18HB0AmcSh14OdDHW3g3Kj8DemQaIH85TZ1y+KP4nAplaNy/Cm1COSSUzUZBvCq/t5nIuTol2ORzTuMvS+ub/oegVjhDS1QtmkGOL+ALzVX+P8V3IHHioCHMH6xpZILyVd6m5+sMdVqpo8K26SHHzw7X1J0DVFPauM3GOPgs/hVPxjIIH8rt7/90kmLIQtm42e34ID9yTeliuCtWhsK16+yJPrOWdQDML90v+MFLxjA/ckoEVgof69cdLO8J9HSudfg6EICcS4xO7TlJZ1iCoZItSz3xaqjtdiNOd2MvK2xjiifI4wJFIaA79Pzp6jDk6XfakHT0d3xrLrNbiuqXJD0mTGQiRhl30VNfORu94vsI7/4rhN+SULD09BF+gCOmvYgtnbxWEY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(81166007)(36756003)(5660300002)(426003)(82310400005)(478600001)(7696005)(47076005)(1076003)(2616005)(6666004)(26005)(336012)(54906003)(41300700001)(70206006)(8936002)(8676002)(40480700001)(70586007)(82740400003)(356005)(110136005)(316002)(6636002)(186003)(86362001)(4326008)(36860700001)(2906002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 08:36:49.8741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 166defd6-6a87-4e7b-a099-08db25f99636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5022
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
Cc: Horace.Chen@amd.com, Bill Liu <Bill.Liu@amd.com>, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Added CAP firmware initialization for PSP v13.0.10 under psp_init_sriov_microcode

Signed-off-by: Bill Liu <Bill.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 02f948adae72..0b9e99c35a05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -148,6 +148,7 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 		break;
 	case IP_VERSION(13, 0, 10):
 		adev->virt.autoload_ucode_id = AMDGPU_UCODE_ID_CP_MES1_DATA;
+		ret = psp_init_cap_microcode(psp, ucode_prefix);
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 380b89114341..b59c92037375 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -669,6 +669,8 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
 		return "VCN1_RAM";
 	case AMDGPU_UCODE_ID_DMCUB:
 		return "DMCUB";
+	case AMDGPU_UCODE_ID_CAP:
+		return "CAP";
 	default:
 		return "UNKNOWN UCODE";
 	}
-- 
2.34.1

