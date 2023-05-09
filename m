Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46418C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75F210E403;
	Tue,  9 May 2023 22:10:22 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF0E10E3E9
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbKGdHs4jV1k3eaCdY4+zLbmgWtvxMg03UysuHcR3LWccGEmhp3o+hQKoSf51amRiKdqoc3BkYw195LUzNfngSNThHAQOKI2K0jiyjb12cNNieqeFp3KcQtpNnwqgCWtFSY2YKNBxK2DY0GHpSKjs6aMPLmSMht9wi2nsW+FPXQgsLpKyn2yRGvME049gKJH31yHkd/+aI8TaGSv5D9OdeO2YdA8QNKIbe7mOKHg++3MwOakVdrTaiNWu+dpfcssejvjs1Y4O/8gD2RObbfBeLce13+Ch4v1fSge+EacKbrejL71ot46gnqtoIEMhQxSPMRESh4ZU6un7UhGEg+Xww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSQrE9kPr01z4cbN3cb2Ann069rC5lzwwFZPrw0LOnQ=;
 b=FYnUIzrdvIUFOoeUk1ZOAjuRX8GBXeRZNlqwNBzryu7WV+0AScNdr2AuU09eR2yzi7nPtjvlXoCzJf0GqXPgLX1KKLyyPOgYkKr6JBECpeXKV+dkC1CreRTmRJUAEfIMJcB8qndQzbft0ISK6oTRNl2Nw8S4S77yzwO4dIuCvUYiGpysb6KH/iOsNeoJpYrb9iFZCzu2a6bxZw4itBtXZH6Vv6oR/WBHPU15KAOYj6XBuxEfVB1fnNStU0FM7iKfSkxjLqMpK3YaNdTFFYG3HwWqifJlonAwY97rEq0ODYA+7R3pYnVtEPKqykNNoKeVsTTA5JjsM0g7Da/e1h2nAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSQrE9kPr01z4cbN3cb2Ann069rC5lzwwFZPrw0LOnQ=;
 b=GJ9W+VHJQ6dOSCZxT+Zw9eyA2goJj8jyFYUO6UD0mqSvlejsDGAUmp6pFX6W3wxi1Ck+XquTKuCNiPxCI2f3jgflpIttCUBpEqLodbiP/gMg3D+xMM0JbFJzEspC7FdhP27CwUAkuVgaNBPvIGF9qOJwdH1nXH4Y2nVzFzVMf8M=
Received: from BN1PR10CA0026.namprd10.prod.outlook.com (2603:10b6:408:e0::31)
 by DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:10:19 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::2a) by BN1PR10CA0026.outlook.office365.com
 (2603:10b6:408:e0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:10:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:10:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:10:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amdgpu: Add fallback path for discovery info
Date: Tue, 9 May 2023 18:10:00 -0400
Message-ID: <20230509221003.475858-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221003.475858-1-alexander.deucher@amd.com>
References: <20230509221003.475858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT033:EE_|DM4PR12MB5311:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d951c48-c837-4de4-e9b6-08db50da2cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oA7j6nIF7LnRhMg/CBE5JwpHz0DNYRu9Lu4xx5WycKtKer7cX8rsBFF2NluVR9VjjhwcIe2bIy7FIQ84C2GJH1uxVXkE2CE4utwINePIhGVw/Inwv/JolUko5d5Vn8cvt2VBoqsOwl5utyUF1cagZIon5YbngpI+5PnbIMS8DPpoTPBnRBnaypuRvpc6xOKHG2JEkOhPBqEfQxiThCUTlVAbCjtMGikCN/TmFDELZns2bPKHuh1y/hH0wNJ68kG5+orKdNgSoZiZTeSQsZUhkyOMM+GC6Bgreh4TpuNFdW+0vQI/c5uQwcMf7LjSX5Umc5j9TkTMyfhfQDf3pWQNcl4PkobDiK7Bt3pCtrnN+83zz6qhq5UN9NdKKYYDcwAd3eMe4380N0oVG9/EVMdYQiXtvJpNnSQyPmK77AgNwlZ+u1I0gNSh/1boHPLVqxeoMvcUS9ZE9fvgiMXZ8GFhNWsvvG2vL+UOsZro7m/NYTQ1v6HKXnc80pe3NYVsy3Ns5H3OWeiPaYh1F7AQ097J/eQILNUw+V7QUw/nITjZBOlBhSsBEGUi4PXXGaC9GVI5KIl7SXlGKdFmngIoHGPG9zcLiKVOT7RpbdI7OZs+6iyE8xjIc0nz7sjIQ8lO5clurq1rXhFJ6dQXOU1owmMBITRCwBkuE/Ih7PHw3fBN3G7wDElyCu1FNMurSuWkO5NFDKJKu9aTJ9SKZFiDCskQnZfYDP9HP2c8if7zIoBDSC4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(36756003)(82310400005)(2906002)(70586007)(40480700001)(8936002)(40460700003)(316002)(86362001)(8676002)(5660300002)(70206006)(4326008)(41300700001)(356005)(6916009)(81166007)(426003)(47076005)(336012)(83380400001)(186003)(16526019)(1076003)(26005)(6666004)(2616005)(478600001)(7696005)(82740400003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:10:18.8184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d951c48-c837-4de4-e9b6-08db50da2cd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

If SOC doesn't expose dedicated vram, discovery region may be
available through system memory. Rename the existing interface to
generic read_binary_from_mem and add a fallback path to read from system
memory.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 246070938c41..01b21988c1ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -226,13 +226,21 @@ static int amdgpu_discovery_read_binary_from_sysmem(struct amdgpu_device *adev,
 	return -ENOENT;
 }
 
-static void amdgpu_discovery_read_binary_from_vram(struct amdgpu_device *adev, uint8_t *binary)
+static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
+						 uint8_t *binary)
 {
 	uint64_t vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
-	uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
+	int ret = 0;
 
-	amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
-				  adev->mman.discovery_tmr_size, false);
+	if (vram_size) {
+		uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
+		amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
+					  adev->mman.discovery_tmr_size, false);
+	} else {
+		ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
+	}
+
+	return ret;
 }
 
 static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev, uint8_t *binary)
@@ -338,7 +346,10 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		}
 
 	} else {
-		amdgpu_discovery_read_binary_from_vram(adev, adev->mman.discovery_bin);
+		r = amdgpu_discovery_read_binary_from_mem(
+			adev, adev->mman.discovery_bin);
+		if (r)
+			goto out;
 	}
 
 	/* check the ip discovery binary signature */
-- 
2.40.1

