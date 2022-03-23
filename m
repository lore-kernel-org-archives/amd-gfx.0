Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E69C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 16:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0860010E75A;
	Wed, 23 Mar 2022 16:01:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B131610E745
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 16:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBuDZf87erYxLRxzHzhONR/hrsWzPwOmrgmimdCO8UtHi/8cJdo3QWx1a9FpSjeyXBCWBm+eoJ/8rh+nUY45Uqn+muEQTRZvj0E+GOd8LYEGj4vyd1vtzMZv04U9jlNywjWUl8j7nBvxHvdetyFl/uP8uZaS3xklo9NTMlbklL+oNVMqyqp+t39yuqFw3l+OEvWvTSe3BZvrf6asd5L8ZenxAQUI0FQSnYeYtZRqqnpJ9fACdWoSxJG6DNEQhgUsQHxOVLel+iHFXUTbJyJF+eFRIdxd3198DkYf4bd6HNVR92OitTnqHkDLAkdy2KpAUKeLpjs2kq3NIe23mzFlrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz2c+fCVo2qr3bcTLejg/OBBN2dwSst8TE6Vz9/npcg=;
 b=jPrLQM2jY8SivHUQMwdy57tEOWReqNw+rbt90YERtUBAbSL+UPyl0+t+CTFOgmbirIzS69pm/CU8wnSE5lg+To1rGiAmKuBUN55gfknz6B0RehGFoaF4w/WpWLXRkRBRMsF7gdtDe7t5+907yzW5xEx4jFUM4DbStFXE1RL5Afx0LQz3isbasTwqc0ypesQx7GPO6oj9jfN64I+n/Y4B+fRna9DB1ZH53ud5Wnjr98i4M3o2Yh/3keYd2zqhB+qq/Nao7E2fiCNuFED/356gQFcbqlT5URn0W7xgUcQBGA68wqECbxTaPfnaFGIH7XOEUV/njw/Qj+hW6y6eFyggtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz2c+fCVo2qr3bcTLejg/OBBN2dwSst8TE6Vz9/npcg=;
 b=Cnywu4EAccFNmQKeZKZnT+hxrtrHS1ef4a/98WAdsdkajsWicZ0jPvVXp0OBdYISBT2OwGZ6qUU3NQkphrWA+w+xhnTWmAzaId0EX0o26e6zTjJSFL35cKn4iVQSCNfzjAqh01iejhB+2Z7qWcs+UPaFmqpfBVveEQsUDjJU0cA=
Received: from BN6PR22CA0072.namprd22.prod.outlook.com (2603:10b6:404:ca::34)
 by BN6PR1201MB0180.namprd12.prod.outlook.com (2603:10b6:405:56::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 16:01:27 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::e0) by BN6PR22CA0072.outlook.office365.com
 (2603:10b6:404:ca::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Wed, 23 Mar 2022 16:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Wed, 23 Mar 2022 16:01:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 23 Mar
 2022 11:01:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 23 Mar
 2022 11:01:19 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 23 Mar 2022 11:01:17 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vcn: improve vcn dpg stop procedure
Date: Thu, 24 Mar 2022 00:01:09 +0800
Message-ID: <20220323160109.1327592-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 922d6ec6-2cf6-4b67-33b6-08da0ce662f2
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0180:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0180C84B3AA6AA3C0825D1D195189@BN6PR1201MB0180.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c5/ltixjcP1hNWCDlymamunNL8w+T1difNAPo4WJOs7Dd81jY9QV8NzDKti0hr7JZsuQvrOo5OXTzRMkO7NUkaN+MQ0x/cVlGxz/6bWKqlTttWqnFlxrpj/nAE7tWj1ysxvpCucKZrQh6+EIE08Btec5QDMOB85nm95EwgXfoKMBEqj9T51HO46AZgORhiQRx6ggT5OUSMOyXSnrr7PNJ78HlOqlJkytHlkI3Mvwf3UZroZZwLHtegMbY/36Te01CaELsTA8kxkRMGw5mXUN+dxfGtSxDqx8eNRX6mSW9OECxQgaVs+WcTn4Dj5GY+43ckWINpKjlRIuUeEEM0qKzhdqfaWMKt9utPiovLaD25ahpa2nRiABLCdVI6x1RQWDX2SuIniV4siV6D7yfmFhWwt4GO/w40eBXL8FXnHsOy8+hHJrcR5fxGf24+25lexQdkX4zpUv1AMtn/L42c0f1qddndLgcbIBCGg1olJPlWvdCPl/bt6Aw+rXoF+XRIvWKjTQv/fjdLFkzZMj+mYIYeZuEi1puLCLSZsSXNqUGfU1cxf/i7GEAbjRjDHi/MmF5omTMei2radZFk7x7F14kUDX4+hRRNeVok5R+y9aysrzoQkrydO2nrsiRlPGAIGcL7vTqOSKkB+D7rYqfh+SDyfEJSAtScF1KAOXRUw0ziA+DF77FDeAxozxaKLCbMu/j+TY8nJJmxxSeFaGEbUZEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(40460700003)(8936002)(81166007)(2906002)(70586007)(36756003)(2616005)(336012)(426003)(7696005)(26005)(44832011)(4744005)(5660300002)(186003)(1076003)(508600001)(54906003)(8676002)(4326008)(36860700001)(70206006)(316002)(6916009)(86362001)(6666004)(82310400004)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 16:01:26.7304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 922d6ec6-2cf6-4b67-33b6-08da0ce662f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0180
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
Cc: Wang Yu <yu.wang4@amd.com>, Zhu James <james.zhu@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prior to disabling dpg, VCN need unpausing dpg mode, or VCN will hang in
S3 resuming.

Signed-off-by: Tianci Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index b16c56aa2d22..0d590183328f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1480,8 +1480,11 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 
 static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 {
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
+	vcn_v3_0_pause_dpg_mode(adev, 0, &state);
+
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
 		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
-- 
2.25.1

