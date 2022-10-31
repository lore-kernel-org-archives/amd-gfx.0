Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBA6FA3743
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF4410E2EF;
	Mon, 31 Oct 2022 16:24:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F91410E2E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jo49ngm3tr1oTzwpZhFt249AkvuG1p6Kl3UGBTqwu3QGb7DQVr8T1sRPnrJ6E+UneIDmEZTWRSMzmtjIdWxNzQcqOesW5kr0IFxrvd6NYpFpzXWll/W64dY2ANpDuiQD/n6fLY/q9jjqHlTDja+/eoio7grX8wXVTVmc7lSAIasPw9whWfHGS1GPGecEGz+2r8HFkY7qMMbw7wPjpXRH2DuZb7cHKo/gunzVJztNy8nsN5ybBD4zAfwDpnZUW8pKi5+uJB0Ey+IpV9GQQQ7efbW/HHZeIlfRat6XsdkL60rxCfyl++F/BkwxO1pk3jS+DSVT8E+2w29OpjntpQ8g1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4R4WBNFz8DZ0ka0LClZHCqTuSf8QkY4ZkqsnmNYSQrk=;
 b=ge2eJJIlrARCBV+Nkz0Jh7lbMOAMD5MNrytLLeMkksmf1aE7FXhoURy7GDEZnnnxhlBedIBK3jbyr2qgAhOwzemA+thhDd8FDMduKtzfUOjlDml0UaaBVLGDuNqoRV0r+7La8CLDWjs45tGWX5S/eU2FNYoU3K1cwwt5jPn6ore7RY8aRLsfkA1PwJkMUVnlxvRu4kpbNsz2o2+/EjNcCIp4Zd6TmghwAQuzZGtnU9Q+qEfW0A6r72ffTALJ3OwTEmu5GOtPBIDOfJBLnh82kCbXofe4Sj38uZ0GN7VpULl4/T7z6/hDUJxVrlI1WvaVgaQQz1xcc8IW57LnV4EWoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R4WBNFz8DZ0ka0LClZHCqTuSf8QkY4ZkqsnmNYSQrk=;
 b=S+KA4ZC2QdVGIhORMRU8pfwpbdQgDnt3aJ2R9cueZzalM/HSdenmugV3++d+kppWlXzu+ZPa3hvVsSVvAPRK3hoTs6KYjp6Xs1E5BX5ZNaN+ZG5RrnB0EuERKEQ2c/DKqZmBagpc2e+KpI008sSIgl2+HV54zoF+33Ic7z/phbA=
Received: from MW4PR04CA0106.namprd04.prod.outlook.com (2603:10b6:303:83::21)
 by SA3PR12MB8024.namprd12.prod.outlook.com (2603:10b6:806:312::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 16:24:26 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::99) by MW4PR04CA0106.outlook.office365.com
 (2603:10b6:303:83::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 16:24:25 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:23 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/29] drm/amdgpu: add kgd hw debug mode setting interface
Date: Mon, 31 Oct 2022 12:23:34 -0400
Message-ID: <20221031162359.445805-4-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031162359.445805-1-jonathan.kim@amd.com>
References: <20221031162359.445805-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|SA3PR12MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d6ee4d-256e-44c6-9849-08dabb5c6060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R1igsuoybqBgIkU7FQ6llWweeJTWKCa2kCC2FkHTrVcTrb32DFU18DlD79xJQhoKGAtaS6cNNnpBSOPdGNcr2b+5aFverqBWcexoWL7jm40wG8lcNL9AcKwjS0oVMdfBn0uHmeIuNqEA+DVLmBg9IFZXrAAV7hitjldCJdHN34f2lYCcCfhyrIyN0adtftq7wmNNEVwgWZOUrHQNbDNr3CAGphQhdCcsLFecFXD2U+CKrpHH0tmR3qxc05UxApV5IaMbAf8a0+JwgqunEC6kZ4CXhCG7LqPSSJRcvFRn4bc4+Vh4JTTfL4V8y9Cauo2PbZzhi+1Q+bn4N41FoJFS7ZWs2QhFzlJAoiIR4OUBYbQiqw1AqHW4MdxsGc2NNNvLb1cXwc5hT++F84HEs1tqYkWy70YRiTrnbYG0PICN7L7y4o7pvoJ2dQ3Cm+jehNDDlhTORlldg8BT4sPGBO/tHmDEBrp+NC6xtI0FF5ZGYNEgRbsp3kchvRJj06Hy2d9WlH8Uhx2YBbfGomIq58nzosBX5y+n2uRietEJII+bnDzNZuuHK/u3CiE8cZpVRdFZEotSk/9qr7qyCK/xjtlvtgKAXsjp8vsxo88w3xLUITjormiU15Bdl54FKbdLfw2I0GaDs7AWVdYxq7rrAYi+npswBImig0exm8QAea8RuXfeX2rGwqIIQ+FbQuL1UTtGALTfJQU/PGPYYAdSbnOEPmxxTRq/KZk4U91wgI4b+kWHPlIBHTuEVRxTq11S8A/gs4t3jFCpCDIqqgtXZsrnFjG7GcN3rAgot/9nGDWVXP/z8KLILZBEbMfW0qu+Fli8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(40480700001)(316002)(6916009)(478600001)(26005)(426003)(336012)(44832011)(7696005)(4326008)(8676002)(2616005)(70206006)(16526019)(70586007)(8936002)(6666004)(47076005)(1076003)(36756003)(186003)(5660300002)(2906002)(81166007)(356005)(83380400001)(40460700003)(82740400003)(36860700001)(41300700001)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:25.3268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d6ee4d-256e-44c6-9849-08dabb5c6060
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8024
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Introduce the require KGD debug calls that will execute hardware debug
mode setting.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../gpu/drm/amd/include/kgd_kfd_interface.h   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 5cb3e8634739..15e7a5c920a0 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -289,6 +289,40 @@ struct kfd2kgd_calls {
 			uint32_t vmid, uint64_t page_table_base);
 	uint32_t (*read_vmid_from_vmfault_reg)(struct amdgpu_device *adev);
 
+	uint32_t (*enable_debug_trap)(struct amdgpu_device *adev,
+					bool restore_dbg_registers,
+					uint32_t vmid);
+	uint32_t (*disable_debug_trap)(struct amdgpu_device *adev,
+					bool keep_trap_enabled,
+					uint32_t vmid);
+	int (*validate_trap_override_request)(struct amdgpu_device *adev,
+					uint32_t trap_override,
+					uint32_t *trap_mask_supported);
+	uint32_t (*set_wave_launch_trap_override)(struct amdgpu_device *adev,
+					     uint32_t vmid,
+					     uint32_t trap_override,
+					     uint32_t trap_mask_bits,
+					     uint32_t trap_mask_request,
+					     uint32_t *trap_mask_prev,
+					     uint32_t kfd_dbg_trap_cntl_prev);
+	uint32_t (*set_wave_launch_mode)(struct amdgpu_device *adev,
+					uint8_t wave_launch_mode,
+					uint32_t vmid);
+	uint32_t (*set_address_watch)(struct amdgpu_device *adev,
+					uint64_t watch_address,
+					uint32_t watch_address_mask,
+					uint32_t watch_id,
+					uint32_t watch_mode,
+					uint32_t debug_vmid);
+	uint32_t (*clear_address_watch)(struct amdgpu_device *adev,
+			uint32_t watch_id);
+	void (*get_iq_wait_times)(struct amdgpu_device *adev,
+			uint32_t *wait_times);
+	void (*build_grace_period_packet_info)(struct amdgpu_device *adev,
+			uint32_t wait_times,
+			uint32_t grace_period,
+			uint32_t *reg_offset,
+			uint32_t *reg_data);
 	void (*get_cu_occupancy)(struct amdgpu_device *adev, int pasid,
 			int *wave_cnt, int *max_waves_per_cu);
 	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
-- 
2.25.1

