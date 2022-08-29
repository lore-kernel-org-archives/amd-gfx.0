Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05673ECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4980410F324;
	Mon, 29 Aug 2022 14:30:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC4810F2F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:30:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1x7ZRZgfx7VLmo3+HQp6orgp8MnoY21Yrqi6e2CRLi6n2grzBc/UcqlYjSQRpAYjtcTxbActj9Se3mA2loGSaSe7d7vLJ5ONz2KVHB0AE/ArOcGbsyAS0kiZ8eoSXUcDuiVankFA9LAy5ZGenVOJfXUy2Qz+H3IMfJQfnLDfkT59XWyk5E0TV6/ENutZG85I4MWWzJ1mfDpONtrCHw0nf3RRHLQuUXyV3dIasjLCPdssgRgNPR+UcmkwpUVN9wQwx3dNOxOw7uUP990dzjL1162KRggXQy+OtQG9Sl2NXriMhewLhrXW/833NjiHlgjQyjFmVYl892VzyMpMf8a3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2N01Ma47p/EjnPosqssiKGrRsE4dksI3EHeqtpl4yU=;
 b=ckf6mr1f68fJzhL4oXr+XIRF6EHK+2GO3H60RDqpuKBIqrwLXF781APr8BHbTLIM3JNJqad6hEEuY5mxEZUy2d0g9bbQZ65Oy0z6wHiwtDargVjcBaNUv1TEdbJFRwq8pTSKIeVW6bfwikbuhbhvCorA67ur1TbrYbstyM4FEbGjvGljSR+kUFFqoFy4PlW+dL/XTH9639F++ZAwe2RuZN67IcTRZfJdfXJzkvoVbcd8eqQuIdn9OkrCWWCizhxTzujPZVSmBKP/Hq+iIJQVTrFcTaIjshBdbD8cuK6ixJaA+xzFBHLUtbEPzXsw26cSUnHujnXd0d5DGxo+AllHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2N01Ma47p/EjnPosqssiKGrRsE4dksI3EHeqtpl4yU=;
 b=UkE1knrPzHggwz0rXnlDgCrWZ7S5YeTFb0mo91jYbkj1i8F2VYqaTE+9HFL8/o2ufWYYTKomO36KupZalX7Nd/3OUWd6sfdc2L5ewW8EbCYWA/Pros1kLVEfFSSoDF3NqbMhbJpCVN2R04nGbF5+p/xcXSm48A6PRHBmQxJOU+g=
Received: from MW4PR04CA0114.namprd04.prod.outlook.com (2603:10b6:303:83::29)
 by CY4PR1201MB0214.namprd12.prod.outlook.com (2603:10b6:910:25::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 14:30:46 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::db) by MW4PR04CA0114.outlook.office365.com
 (2603:10b6:303:83::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Mon, 29 Aug 2022 14:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:30:45 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:42 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/29] drm/amdgpu: add kgd hw debug mode setting interface
Date: Mon, 29 Aug 2022 10:30:01 -0400
Message-ID: <20220829143026.1509027-5-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829143026.1509027-1-jonathan.kim@amd.com>
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3fc2603-2819-4295-6de6-08da89cb0f9a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0214:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rlzd07jnvKpzKA/nAEswWvw9viu3MThBVUq0t6uPDnZHE57XvHJVfFkz9WBGriP3LNa70Q5AyzMsfnfB8fQGwuh65P7oz5dgCc1hVbTPE5vkpMCvvO2I3nlBw3zVUsqjvYDHQ5K3JOc6e4lIOUsk/kTwIs/yX5VY5zKBU4qwnFDoJVJ6gZhUwwx/fAinTsE3Ma1A38WSDgDARyAXsX+Dtj+nGXZs2xaijADwwgpxee98Buxn5Q8Ly12+g53Iu/ylYcTnPneZCRpTa9QpGnoC0XPukHGE52oh3nLug3vwA/o1gXR1rdnG81iDOXsjExMJzbLoqaZsdxCskCEhd6iDG1KnXFmpibvzz47dlIhNJvHPmLKZfKq7r4zhx1rupUubD97vjffvbgyOmtf+T0o4KZvldBcd2NcZbWCRno5eHaSzpmsPKIhZ8vsX9uJmra9DamNsZvceHqTrwRh7jWSih78SxK56NERZ4YUL7lPDCh8vhCRgdlsdYEXNNyN0bcMaEScTEwoOTnw/QSziA/FPxFLvbIStfr+TxeqaGS/dwAL7bC/JQTMigGZs6TYor/q8EZ/bcnq0y2/90g3tQFqAa93mO4pltbcTg0SWBFobOGYp14CciSaKPAUytdTQYOZeNXsiDNPlDclnzg1UI6+uxKdrFxWecb9Kg+cFFPolj/HaDiEocIOAPEqJW8BuTvLx3BTYvSAwGeMcsqI5V91wsUZWwwaa3F94peIzWc8kQTRICm1D0/DUsxoeSXSDXz/+wja0qwgtsAcYBkX0GR1b5DZj1+DjcnTJ2kK5xTFOKueZTB4ySPF4b5TlTaEda/ld
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(39860400002)(36840700001)(46966006)(40470700004)(316002)(54906003)(81166007)(6916009)(8676002)(86362001)(4326008)(70586007)(40460700003)(70206006)(5660300002)(478600001)(36756003)(356005)(8936002)(41300700001)(44832011)(2616005)(6666004)(82740400003)(1076003)(7696005)(82310400005)(2906002)(426003)(16526019)(36860700001)(40480700001)(47076005)(336012)(83380400001)(26005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:30:45.7616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fc2603-2819-4295-6de6-08da89cb0f9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0214
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
Cc: Felix.Kuehling@amd.com, Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Introduce the require KGD debug calls that will execute hardware debug
mode setting.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../gpu/drm/amd/include/kgd_kfd_interface.h   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index e85364dff4e0..a673e071ba6f 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -288,6 +288,40 @@ struct kfd2kgd_calls {
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

