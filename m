Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83952C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 06:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F41B16E83E;
	Fri, 26 Nov 2021 06:43:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 527EA6E83E
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 06:43:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsFUJdLnjSP4S0Co6mdKXHfttzqbn0mcPXQ8p3JLFUmKxFap9JbwF/vB9eBePuehvx0UMbQwCe3ZoNLEnmDqi3lyT0eTDJVlmr6LIx99P+CGW7+EuQTDCtgjpikShiLTWCiFqw49+AT+9vkbx+Av4J6fxHNMaTCwDaj+ZgRxam28Q/pF2tBldCPQBUhXGsTWcGOyPiiLnm9dvaNLyTqAh1GOm+SRGB5/trIou55uB9GM72fs0Iy/wq3hRuxJoW/VNlnwagtTEJ64mNTVt8Lp9rNmBKGmZC2mnIwXIFbtO/nHgvhmx7Q3wS2SrcvVFIyF9JxoQJIEa/+R/Dn4eMZGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Yv0+c4OZPyqhFkS3aXf47Z2TrjdxmP4kDUCStX1PSc=;
 b=aynmQT+Db5ZsnPboJ2dZGyoW3TvN5yVGUX/sd08fZGDrZtaNHmz/3OGi/AS8Xik5fzpuA6vT4q9n3YfFeLD66WMvxhun5pPwI2ZXpKtogYZ9Zvq0rDxAwBVu0GB1xMwPBjNUVLWIgCsexcRGPcf8Pd5nN8AxayA2Dlj0M9cVEfSgelk2vbrMCaozk3liqu9YHCFWqI9QjvAOHgvFv1zbMkofmAwOf2cXcg5jLXlPUCEwfmTy26ts9CrVA2ixhKPW0Udr/Qwvd5nWINTvgRftMMXq5ENBBcxS8wEFg5dGsBsu74yG+yi4QQRb7w2wwPfOoZ+G3gTKy62t97/HPm6PhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Yv0+c4OZPyqhFkS3aXf47Z2TrjdxmP4kDUCStX1PSc=;
 b=UWiQZTqljN5xpSMCXw1zGp5GqAbOI3VlROmGq+gCm+ItXy1e3flEuyKURYZZZubaTguDB5GI1IYg4g2Qn7aVBx6QvfBcLRa0RIyw8u6PYzCPiry7oi3pAmrmxYeWIhYlvTsfUArOUBzJwJxMA5+3tfrt9jttiIcIV++XDzMwLeM=
Received: from MW4PR03CA0062.namprd03.prod.outlook.com (2603:10b6:303:b6::7)
 by BN8PR12MB3427.namprd12.prod.outlook.com (2603:10b6:408:62::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Fri, 26 Nov
 2021 06:43:25 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::fe) by MW4PR03CA0062.outlook.office365.com
 (2603:10b6:303:b6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Fri, 26 Nov 2021 06:43:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 06:43:24 +0000
Received: from lijo-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 00:43:22 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Use MAX_HWIP instead of HW_ID_MAX
Date: Fri, 26 Nov 2021 14:43:05 +0800
Message-ID: <20211126064305.141948-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b24e9c1-4f71-4368-ed9a-08d9b0a80b80
X-MS-TrafficTypeDiagnostic: BN8PR12MB3427:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3427AED90E2754C1A1E7621197639@BN8PR12MB3427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PP31tgM8pIUS/5adrRql7ExMceEDsqElOk0atamNTkuDAfgPKu1ymrdCCKdBhLmjdGdFA6yQuiB3+3QRkzJRg+e+nTSYRPFiJRZWyCtRTPr/a6uKrMZIedgXjsLafoVvzlna6dAadDY2kxZNWEzCuoLEwrEG7D3adyPzlYs8mIsZ5L7JOYrPKj+GMd2woGVo5neTfOq7Ndtpko3HRbdfTbAz1+bInEibK0o6jeUoEQ+GzzaBnmSTZW7frjz3ITprrsIfas1pGYg4NmEGzwiLN80xLr6dOHdQQT/VywNE/fJ1Z6+cjGNWBvOstgcERjcLb8qJZT7BusuhNC/0GKF6cHsVeXlgGHUVOdMWv6fT0/1tvqf1hrPyAajiAVmtRqwT2KsIG43Wwfxx/+O0muKPeXVEcx02U2N4NgE8rrdNeOZSh56oLwMgeI3XQYo0sSj9jktaxe1uAY1/fniPe+QcZBdz5jnHSbWW6vaoy3lXHfWj5txghBpomjTdAy1mnM6wUoLYSIFNv2+6ySmdxLlSo/PnWc5Z/GvSpBUEW2l6HpFUmHUihF1+6qZlkcqfnGqZHPYLWAaIeAn/Di4kr3KiZFriTQ8Z3AfeVYN3T5GnoY4jNHpoxTkHJxSWk8WtJgoGsc12ho5ZFbMbOAu+vAFZ7p2sTtCfbwcohjdhI/7iC3qk4/BNbZ6QVFq2zNYtJRSFUTlpoqLrlZWXOMxpBIuB2o2EvrtpWF89slYCiNdQwW4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(5660300002)(26005)(86362001)(6666004)(508600001)(186003)(336012)(70206006)(70586007)(4326008)(316002)(36860700001)(54906003)(82310400004)(16526019)(8676002)(8936002)(2616005)(36756003)(2906002)(4744005)(356005)(47076005)(81166007)(44832011)(1076003)(6916009)(7696005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 06:43:24.2046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b24e9c1-4f71-4368-ed9a-08d9b0a80b80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3427
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

HW_ID_MAX considers HWID of all IPs, far more than what amdgpu uses.
amdgpu tracks only the IPs defined by amd_hw_ip_block_type whose max
is MAX_HWIP.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b85b67a88a3d..c5cfe2926ca1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1096,7 +1096,7 @@ struct amdgpu_device {
 	pci_channel_state_t		pci_channel_state;
 
 	struct amdgpu_reset_control     *reset_cntl;
-	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
+	uint32_t                        ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
-- 
2.25.1

