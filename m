Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECDDC4167D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DC3210E9CB;
	Fri,  3 Nov 2023 13:12:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B578E10E9C7
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmOcScXZTtoDV1E+ZERD0bxoVnle/oGiqBNxyaPEcoO2QrBfUzDgwNlVwlrQruyAbg9oJS/HktvrDtlRS4/ben3TGzwHIBw9X/Yd9jfILI+ynLidVcQBz/H5ebXm9v5uz8rPm//d9Ohm6VbaY6bqO/QqS2soHWJttQIAyeBQTBHf5xH8PYnEOMldg+FpaPuVuNsqPaIjFFzHIh0uJxpOsqw83B6W2qo2I0Ak5DStQnxlG+TUZQvjiYmd1CWOwyL2t8ErDr0Jdp606tI57TLG2OM97ETTFs/YPsmNosS1WbZSxJTg9Z2+5TA0R5QNuc7R9f/gGr8D89eltJcvnmyPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0K3tOVvhKOaCSl7YE4CIGTCJBk64gdDG9AHrOX7uKA=;
 b=bnokUjyMmmsp06Fg+eZTnLayhVWPqhf38/vWZcpo5YYn1udVoI0tcA0Dqg8AsbikX6g5+TbnfX+OQa8h1N7wJyvoocsW5jU+leGKscGdFSrk7ZC41j41XxIixJLoVWfSOmIHqSk3GNBpWslYCmrlarp3AvvTNEd7/cgCdClPLndSnTYL+1pxA3A+DcXiRdB2sza+aHoNMGCl5zMsvUhdCw1sU6R22kIW6P1IYmrziqMYCGEgeIayoHD9TUL0e3PsO2lZ2MnF+sCSoymJGCexFXWCjh9CFU1BJmg7l6+fo04S+t3FKDXyHpmgmaosov16Tem/gInMOgCkoi3iz88VNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0K3tOVvhKOaCSl7YE4CIGTCJBk64gdDG9AHrOX7uKA=;
 b=jQGezxaXbeinDqWd4yah48M4jdzwT7p4tq+2aTjnEtWTwsjCm1oqsIdNR+dKBmaVIizR2/Sm2psEGL9XG1sYLfLv8s94ThJ2cWVmBllPXObhahOW7+IHHmbhKOvghqMFu3e5kAF2Fdy7g2GpOx6227kVSol0qTgIDFncasmYXQA=
Received: from DS7PR03CA0105.namprd03.prod.outlook.com (2603:10b6:5:3b7::20)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 13:12:08 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::9d) by DS7PR03CA0105.outlook.office365.com
 (2603:10b6:5:3b7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:08 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:04 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/24] drm/amdkfd: trigger pc sampling trap for arcturus
Date: Fri, 3 Nov 2023 09:11:29 -0400
Message-ID: <20231103131139.766920-15-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 59eec3b3-4d60-4e74-e891-08dbdc6e7be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7me1Z8Dg2ZrscejWkrsoqQuwxi3oKih1gF+aGTbqeJ7b7ECU2COqkU9XeK5/J5fpncPePPAB1LH+Tt3Bqz81hmTdP+IQWqDezhd39CqjT3aUec3zzly0HTTkIrHwLYu4L1t5HKlUzYXY3murPf41b7cyq6IHli8+8BuCxT+W60Oazns7JTJpc+xtVw0nH8YqkW85mDvhXWV3L33ZyPcSCWBnhHpzidKkeO+rKtJs4em5DSdBpXx9RUIUqB7Rfag5RV1lU+95LrFgA2NcGR01U5d74A9kQ9JZEXb+Ey6Fy9Ctmy/HHVs3PT9Y/8nWB+3jFgnH4rwNRDLDPsLxqXLGH/TKioNELJRZGypzF8iF5LSeoYeqCA+hoTTghcvPNU3sWi7QAnAe0vzm2OiyynBiEedxBMPGIG40RDmTMKaKkj7QB2Qoz/9pfUiyVKm6j12iZ8LlUKzmwsUnvL9No0ZSva9GPAwqCAOCPpTBoV7WVNIRqePTXOuH1v/omKMcVy+WYdrR+FafBB5LmdTtMtO2eKL7EAs5qxDkhp6GSkz74q6fbw53kaD2GwyyMxNA3wlWs4steIBjjmjl+A7z+FYCb4Ev2fawWEPtRNB9k2n97mB5Bi8h7FBwy12Be6QmjKHppr0Vd+klp+uMtKvRiYx/DjFftW9Vldh91rULfcVxi3oCAvBnkPtR/1kqR60g+/SF/lk7b4SP8jwFzPWeA0apN3R3P/2/RNyO+IZRxPt5ZqP1sPYTVhAQojTUDcahPdRRvx4rCVXY3YkcnUPRdtCmhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(2616005)(1076003)(82740400003)(16526019)(336012)(426003)(54906003)(6916009)(70586007)(70206006)(316002)(4326008)(8936002)(8676002)(6666004)(7696005)(478600001)(36860700001)(83380400001)(81166007)(47076005)(356005)(41300700001)(2906002)(26005)(86362001)(36756003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:08.4516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59eec3b3-4d60-4e74-e891-08dbdc6e7be5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement trigger pc sampling trap for arcturus.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 625db444df1c..f3d89a469b51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -390,6 +390,17 @@ static uint32_t kgd_arcturus_disable_debug_trap(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+static uint32_t kgd_arcturus_trigger_pc_sample_trap(struct amdgpu_device *adev,
+					    uint32_t vmid,
+					    uint32_t *target_simd,
+					    uint32_t *target_wave_slot,
+					    enum kfd_ioctl_pc_sample_method method)
+{
+	return kgd_gfx_v9_trigger_pc_sample_trap(adev, vmid, 10, 4,
+					target_simd, target_wave_slot, method);
+}
+
 const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -418,5 +429,6 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
-	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
+	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
+	.trigger_pc_sample_trap = kgd_arcturus_trigger_pc_sample_trap
 };
-- 
2.25.1

