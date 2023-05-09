Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFAAC77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 07:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32EAA10E33A;
	Tue,  9 May 2023 07:13:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C13D710E32D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 07:13:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leLajBjP6ow7Z8XQuzx/AO6vpgvdIooTSbKtb7yBCt29thGz+jGueTG/+41qb6eLFZvMJvaLJewqJaEzk7ygxQceR5o8A5Guaj6CnanuO1+NBu51H+i/m3HER3Cm+0XoQKbBmrJYXrBQ/kxZmGxzpK8OCMeuMB6X7lxHeOpgOGNvP41Y61yJlu+coy7gNhKPpIqtytGg0DU8/bOPD5kx8FO/QgM3YycxWEcTvZdxHVgVPc5WJeBUrFiBKIB+m7ax94Otzo3t7xnMVGUvP7pvuu82UOfOFCqZzeSKQjmSMx4tAtK9IPBWCzU/MEyAa3ZMyBSbeRbYoc9yk2QcAMYopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYBV1AJTX6yglmAawdmwPLtWlT4sLzQ+iZrnTtE1SCE=;
 b=XSV3vM4r0uCD+0LXsxBZtvyjXP0JVYtvyc7XHqLXSQUbRvRPpBU++sjoBRLq4mB2K6pCs9QRXerQV3smuCr12T5xx6QmrmE7o6Vsmm4tz+RJkbY7N3WfzaNDUE9SYQYUh17awEtNp3+nlShaTkp4s4ZAiLCqNXwSQJsVBGRaobZjMEpsL3aFhguOzFiRCdFBRJBaUSIhgtX8FxZnwmavyWffNWTrya4nEFxNnI2umdQL1iflVxKZAqz8ocNEkJVKSzPPtc1Wk5sKfcvW5ZjytuZMBt8VX6/K3SP/U7FkEv5RtsqULUQWbNu8FW1vQcKXTrIQ+YHCGXkrIz7SQJqZlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYBV1AJTX6yglmAawdmwPLtWlT4sLzQ+iZrnTtE1SCE=;
 b=QTY7z8KwRhro2Sr7y3SL151dSZ5M4iOZaVYZeKtRZGZ7HQ6sqmTuL8R4LUM12wbmhn8HhxdCNBZU9rXUPcpk0+0mXZoxZJU+rTl4ZKPSTBuGfMKqQSHGk70SA/9A2VLmh02kL0qFOoc3sjDvnNUM1L/yJKrPrMadr9CkPtRlXOI=
Received: from BN8PR04CA0021.namprd04.prod.outlook.com (2603:10b6:408:70::34)
 by PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.31; Tue, 9 May
 2023 07:13:12 +0000
Received: from BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::be) by BN8PR04CA0021.outlook.office365.com
 (2603:10b6:408:70::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 07:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT069.mail.protection.outlook.com (10.13.176.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 07:13:12 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 02:13:10 -0500
From: YuanShang <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Remove IMU ucode in vf2pf
Date: Tue, 9 May 2023 15:12:12 +0800
Message-ID: <20230509071212.957510-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT069:EE_|PH7PR12MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 0943d5d6-2019-41bd-18d9-08db505cd9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pB6xvRwGimjG1ZxQ1lvpqVXckc3UmWNunL+qc1MsLzqJfXvVUv1VJND5mlaD8SB2Vd64z9IpxHvzgNknQG3NZ8hKulGRnl3iBLQ2g0bG2bBQx3XzXJAVW59qPOylDGJhIXnlDbLlfHcCbusr382z5pTd8gN0egbmG4zd7bbJ+LKgLpLe0zMesi57TtA9T7IOc8H4I8gcVkJXaY/74DJ+zAcCOQjcwXUY/OxZgt8PhrXV8JHDLgnimjDrrP8AVm67jd+VQUxH6OSXG/ZQUA0PHABbSXj9iRdY8dfle84J8I7gxy/LLEZFlVSuAfGAdSN8oQLMSz9QOtWFl4pCgobsfmjaUpAiFMS+jOmqA7yJPb9fxRKW7lgweAMGg9Ia73S6AFHvk92rY5jpcb0FtC2tlw8nGMOZHvFHI+kqvghYfrhEUXvTyIrRo4whEbmN6uLnNkMUwU9RbmUl0oebhjjejw8s5b+Tor+H4smigHZUs9ABqWQk1rBUQD8Qk/MaSJ20SDbQ440rtFMgIHvifp/jyh5X7wRhJUb88/xRKS0HbeTwAa3BZJXOnpAnI+4IXeFW2GZlqk2y4f6SzGpR5pWh23URR44VQmWBTT7QHcLyFLowBeDLAXw+koZlx0EYj92hYelOaXuO33Skm/tuj4tZaY0oeh8PJ4L/fwUp8A9qTcxl+ln7GJZTn3r8h19i+sSOe6CHJcIDA7qYmHAiak2TIyQB+jvWDcEKAXxuRZapp0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(86362001)(36756003)(426003)(336012)(54906003)(316002)(70206006)(7696005)(6916009)(4326008)(478600001)(70586007)(2906002)(82310400005)(40480700001)(5660300002)(8676002)(41300700001)(8936002)(186003)(356005)(82740400003)(81166007)(16526019)(1076003)(36860700001)(26005)(47076005)(83380400001)(2616005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 07:13:12.2719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0943d5d6-2019-41bd-18d9-08db505cd9bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6696
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
Cc: yuansmao@amd.com, YuanShang <YuanShang.Mao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove IMU in vf2pf ucode id enum to align with host's definition.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 1311e42ab8e9..0af871735a74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -557,7 +557,6 @@ static void amdgpu_virt_populate_vf2pf_ucode_info(struct amdgpu_device *adev)
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLS, adev->gfx.rlc_srls_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC,      adev->gfx.mec_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC2,     adev->gfx.mec2_fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_IMU,      adev->gfx.imu_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,      adev->psp.sos.fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,
 			    adev->psp.asd_context.bin_desc.fw_version);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 24d42d24e6a0..104a5ad8397d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -70,7 +70,6 @@ enum amd_sriov_ucode_engine_id {
 	AMD_SRIOV_UCODE_ID_RLC_SRLS,
 	AMD_SRIOV_UCODE_ID_MEC,
 	AMD_SRIOV_UCODE_ID_MEC2,
-	AMD_SRIOV_UCODE_ID_IMU,
 	AMD_SRIOV_UCODE_ID_SOS,
 	AMD_SRIOV_UCODE_ID_ASD,
 	AMD_SRIOV_UCODE_ID_TA_RAS,
-- 
2.25.1

