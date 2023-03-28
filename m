Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54925C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FEE410E8FB;
	Tue, 28 Mar 2023 15:14:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26B4310E290
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yd0de3a4946MWuOfSc/7PJyHmswWLz49smEYg3vUyplGmHutZS1Cwclh2jhc0KwmU3mRLj7hJhMEn3BI9zqKuSLuEXt4rR0YoT3fxKoSBzRvi0eUTJK7AnIXIoNLsiEbDrnZsHgq2+NptDarILp8F4SboGbZ2W9CGaxBERqiMY3TLus0jsk40n0dtCEptbAa8BCOYC1IgIVdMBm3sp1Tl7vIj+qQd1JFDi3ejYAxJ0VFk2BmxCi4th4OMIWii78epk4oOx9esQdNswzfAsYx2ENxTnZDdB2wKR3syTeo0hpbAHalg/IGIFuiW3XP/1l7TljlcOWLQ9JhMSjQwcaY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjr3P/o4NJTSl6OziC/fn2EEgaMXfyMqvEQXs/93mw4=;
 b=QomfKsBss+lapkwai1Z6ZdiJIsRhREpy3A99hhq6Vx3zuy7SFu6i1XH+0upux9Det0D8P5NPUi+E1WVArfmAnEDOC97a5pgmqGpET4AunyOk8VJJGyK+9/6bBrwJKSDntr3HMJAFdNCZYtreecLGUHDjQBSs/seLqJfY+j+EoMeGSm3OTw8lu79M61cS01d6XhDxQ4ujCDFlODsS6Tk7XxEheVciiQ1Ylmw1fF6GxoAvTOgIxcMBeNEd43cE2i7nnnmuTYTJ1+Ihz1my+MBFRTzFBRMFSfCzTWzVGh4QZ+NOlwbQy0eY+d603dt0x4RWp6jr82LcHKM+f1CJYwBT8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjr3P/o4NJTSl6OziC/fn2EEgaMXfyMqvEQXs/93mw4=;
 b=IraW9udr6ewOSFbOb4LrlTSL0nsLfyKJjOQ/7iz0PiSQDhMeIqwdyfXehkpLHBYK0NRRhCyynfPCwM0BzRtQur9gfSKl8k9hDZ/o0VoCuaksiEX2Wi/2OYixl232xlvjwKzyN3qIlBa7QZTu+YqKejQUEMmTtyujxxbN/xb5nPo=
Received: from BN9PR03CA0078.namprd03.prod.outlook.com (2603:10b6:408:fc::23)
 by DM8PR12MB5477.namprd12.prod.outlook.com (2603:10b6:8:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 15:14:11 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::2b) by BN9PR03CA0078.outlook.office365.com
 (2603:10b6:408:fc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.9 via Frontend Transport; Tue, 28 Mar 2023 15:14:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/32] drm/amdgpu: Add some XCC programming
Date: Tue, 28 Mar 2023 11:13:16 -0400
Message-ID: <20230328151344.1934291-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|DM8PR12MB5477:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e6a595-70f1-47ec-9d18-08db2f9f15a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZIitHCD0/Ba7UzXSubLhFD93ABmV/Vyrh+5QQ0QwuhwQabap0vbKsMsPGxzlfHK4lNv3PsM7FRFTuq8iiudeiCUwyN/QzSmR7iIRWg1L/ceiTjthAsb676VC22erOptj8ps6AtOCD1OQntHKqRxPJJ7fUWG+E4rsxPYPI+DLudlZAcmIuEZW9J1NCoul3sH/lNIKHjN4ecYUSI1sGhARRvaLes/Q+CWiUe3S+g29Emp5raFfU9p96ySqL0rAPPSDckiP8181q/BqqZ7yXVpNcj6WFG5WbESRoxRzHQ/rKpgSSM7Mz8Uo6vnEsx8lhAHJ7bRGgaUgIOzAnbMvDTc68Vg9TVcQzDBA3wFresQnvVgnjGipWNQfFLk/IUGhh+ik5tpUtVo3TGAxBK/0iQS+OJxBG3uDQrqZKsXDiLNDAQbvl4d+ioiKwVelAHAodvfS08PtwIoYyC6GR7sWNDLAlf+PY6fTcW9xQLiL1UrKPd6B3zDJ8NQKrmW3C2wKTpWZIDrq+x1POwQdD2FmjNEQiJFHHZrR5aNk9g/vA+C1Ck6eVMZsJUZPJeGecAkfHnozt4hcB5f1xbCp5sdx9PULkEGCW6BsJyhSdl+JgahEuF6DkKfx8o1KMBpjZY0mlI0M9WGXLouuDknKiPAy2e6rMQOwFV1i3cDWU2spYL8xth6JIACy9lE+O+wLrrQvokSupJAo3dUp+c3W/69MVOvqemfW2OkJt+IbvH/QiPZa5ZM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(2906002)(6666004)(41300700001)(40480700001)(26005)(1076003)(186003)(16526019)(40460700003)(82740400003)(356005)(478600001)(6916009)(8936002)(8676002)(426003)(82310400005)(4326008)(2616005)(316002)(54906003)(336012)(36860700001)(5660300002)(70586007)(86362001)(81166007)(36756003)(70206006)(7696005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:11.2265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e6a595-70f1-47ec-9d18-08db2f9f15a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5477
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

Add additional XCC programming sequences.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 3682b0a64200..7b589f279ece 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1155,6 +1155,29 @@ void gfx_v9_4_3_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id)
 	WREG32_SOC15(GC, xcc_id, regCPC_PSP_DEBUG, data);
 }
 
+static void gfx_v9_4_3_program_xcc_id(struct amdgpu_device *adev, int xcc_id)
+{
+	uint32_t tmp = 0;
+
+	switch (adev->gfx.num_xcd) {
+	/* directly config VIRTUAL_XCC_ID to 0 for 1-XCC */
+	case 1:
+		WREG32_SOC15(GC, xcc_id, regCP_HYP_XCP_CTL, 0x8);
+		break;
+	case 2:
+		tmp = (xcc_id % adev->gfx.num_xcc_per_xcp) << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, VIRTUAL_XCC_ID);
+		tmp = tmp | (adev->gfx.num_xcd << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, NUM_XCC_IN_XCP));
+		WREG32_SOC15(GC, xcc_id, regCP_HYP_XCP_CTL, tmp);
+
+		tmp = xcc_id << REG_FIELD_SHIFT(CP_PSP_XCP_CTL, PHYSICAL_XCC_ID);
+		tmp = tmp | (xcc_id << REG_FIELD_SHIFT(CP_PSP_XCP_CTL, XCC_DIE_ID));
+		WREG32_SOC15(GC, xcc_id, regCP_PSP_XCP_CTL, tmp);
+		break;
+	default:
+		break;
+	}
+}
+
 static bool gfx_v9_4_3_is_rlc_enabled(struct amdgpu_device *adev)
 {
 	uint32_t rlc_setting;
@@ -1954,6 +1977,9 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 				return r;
 		}
 
+		/* set the virtual and physical id based on partition_mode */
+		gfx_v9_4_3_program_xcc_id(adev, i);
+
 		r = gfx_v9_4_3_kiq_resume(adev, i);
 		if (r)
 			return r;
-- 
2.39.2

