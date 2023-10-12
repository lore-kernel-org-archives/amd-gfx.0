Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7824ECDB483
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 13:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F186010E120;
	Thu, 12 Oct 2023 13:14:30 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F0C10E4C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 13:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dy4lFMT2n7js29a+fSXIZw5sZM3o//F5z0VtJ9fG+l+TOX2OeSlLlTX025sBgyVxDr+ICKtBoxfvHrBm3Pc7vpj8o0X7MAj5atnKSYw1KsYscyZRqnIndjiHLk07iPQzjBdYnHsza0JO5vjqx0JafKq0sHzKKwBwtzJz+0MTNbaL2nwfhoM5L8fDGQanEWVtaOMHDkLRPCZ6+xUixD+riHGhSf7B0gdR5n3+QfVIaxvnPnkuyyqrChmwaAY1iQR5OqfrcBc5hA38QMcrN53/Kcjpz8wm4XdP3bssjwNWuHfJEUrX5kIXo1757XJeBgx8ifqRp8MACiXD085ztlhkug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIMmC9gDmoFhpqf6t0h7jK0UURqkSi2a5w5D/fbOEPA=;
 b=VQ2C99Bkh4FlTLD36bSt4QpxQTE6GyBMGbCJik6RMkTccZ8vHQhBHn/41hJATNawjErb4GPGZbKNA79DUTMt/Z0NDIiQHrlHeZfvSzYNe7EVtmOdM3xxS77CmINLCO48rc6iur1A7Ipu8P8g4RSNVNLt6Ve8Ydu1UcO+p8kqFiz2K2hLZnwvHdLVEHYnq/2drLF5opwhSEVQN/+zS7UVIsTzIhTObjU+QKuE8Gie4ODf6XXZpENP1plcWZtVTUAFRrYJ9Y44/SCEvxtJ7AiTZcPZQXrYpj9nfwh1QFZ1rdPuLihCIg+NCJoTF3KaPJHpsdtpgSmOlrFNqFWPpWqKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIMmC9gDmoFhpqf6t0h7jK0UURqkSi2a5w5D/fbOEPA=;
 b=hJ18YaGeMknnXI/Ky4pxAAbDAWCIepv0kHwGKr7pSvUv9B/x+i6NK3ueKhKyqgLlBaoYsgl9LQNy+CLQWoUN3UJJGdIOCBgMvglDporANnlvaWb3CHME5DITjHrcfapdlRPl7hGyNdAKwUHQZea5UjVWoZ/AiEN97UnImQ9/lM4=
Received: from PH8PR22CA0011.namprd22.prod.outlook.com (2603:10b6:510:2d1::22)
 by DS0PR12MB7769.namprd12.prod.outlook.com (2603:10b6:8:138::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 13:14:25 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::c2) by PH8PR22CA0011.outlook.office365.com
 (2603:10b6:510:2d1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44 via Frontend
 Transport; Thu, 12 Oct 2023 13:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 13:14:24 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 08:14:22 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amdgpu: add RAS error info support for umc_v12_0
Date: Thu, 12 Oct 2023 21:14:03 +0800
Message-ID: <20231012131406.61101-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012131406.61101-1-kevinyang.wang@amd.com>
References: <20231012131406.61101-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DS0PR12MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0497e9-2aae-49a3-2d4a-08dbcb25281f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /KSFXWygbvx5DP0BBJBte5HvFmitoCDaCvagRFeQeIIvNnGZ2Fco8xIAmG8ewksD9Ph1KsVrQw4JDPED8PVUaidSmsIYOpgB35TD1dEKzmvBcns+KLn6O+FnyL7TmE4oJ5dsj/5mxuTR/U3j9bjqDbyVB1bJnSKNvLLOMFCFXKfWyMGmcG6jYVh9YR+/NtHTVV1EOdxwugAti44o1wvtMjZeIsAJZ6A6ris9HZzZOAq9svw9hkTrXYCca1RaHBXRN6PcdIJftb38WzI2Iw+mNYWgkUdSPqyI3eJeasAsJeF8p9E3V5fFjg2o/RX0LycGArESmzHqmJuWZ8N3TuMNThbEXW4NJv9qdOB6HVw6rMEdKCHr2ZGODXj7ugrx5XF8M4/nPSi8HkckYokwa23PYHm/eD3YG6oEc31WVs7OOIX/vBQ/lQo8KkpvRsIltQR+CnT3G1o2hWFxHRC1Hcp0avhtUflRI1tg7Yu0kZzTtKAMfgu5UmOCRvrabRfZgYtaGbGXFmhAODZ412lGEKVtvDoOpoSF9Kq3j/wGpSjiRkSf52bXRFYURuTz6EI6R2X1L9Y7/SrcHEu/PtYvDCArLdp6oDl1lTPhtfO6piXTsvA/mogPCmxqTm0cyRH+u0wxLjZ/qpwTCThs1g1AxZm6OaeEa5wjFdcwmXks19c9nyfrkCmp/gXqJxfnNvhlmULY9+7ati55rJl4jylzat8raU7qwZypH8C+gxt5W56xLvP5ITq+XX7OnZc/ihqqPIsFF+u44kKl6yXeAb0/x3bOow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(47076005)(36860700001)(7696005)(478600001)(83380400001)(40460700003)(16526019)(26005)(2616005)(426003)(336012)(40480700001)(86362001)(2906002)(41300700001)(5660300002)(8676002)(4326008)(8936002)(6666004)(81166007)(6916009)(316002)(70206006)(54906003)(70586007)(36756003)(356005)(82740400003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:14:24.9792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0497e9-2aae-49a3-2d4a-08dbcb25281f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7769
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add RAS error info support for umc_v12_0.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 7714c2ef2cdc..cc66d44211fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -137,15 +137,27 @@ static int umc_v12_0_query_error_count(struct amdgpu_device *adev,
 					uint32_t ch_inst, void *data)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)data;
+	unsigned long ue_count = 0, ce_count = 0;
+
+	/* NOTE: node_inst is converted by adev->umc.active_mask and the range is [0-3],
+	 * which can be used as die ID directly */
+	struct amdgpu_smuio_mcm_config_info mcm_info = {
+		.socket_id = adev->smuio.funcs->get_socket_id(adev),
+		.die_id = node_inst,
+	};
+
 	uint64_t umc_reg_offset =
 		get_umc_v12_0_reg_offset(adev, node_inst, umc_inst, ch_inst);
 
 	umc_v12_0_query_correctable_error_count(adev,
 					umc_reg_offset,
-					&(err_data->ce_count));
+					&ue_count);
 	umc_v12_0_query_uncorrectable_error_count(adev,
 					umc_reg_offset,
-					&(err_data->ue_count));
+					&ue_count);
+
+	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
+	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, ce_count);
 
 	return 0;
 }
-- 
2.34.1

