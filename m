Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DDAC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A8F61CDE
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A8F61CDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA6866E99B;
	Mon, 17 May 2021 14:39:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 510926E9A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 14:39:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/uvbMzh3x8/rOcXNsZorn0uJv6AQ3eBkLSXgn/UUxjQ7v8Nd2XxLxHxBrzFe9j3LtlCB8zUPybRn27tq5j2mywsKJvG/7In17IyVJPu0xhWuwgQm3NLUAPHC4HV0UWRgfnNa27pkS/ypYNPL4kXSIGB+GCMTVCmhYW0exRjtm3HscCNk6PLuO5157AL8p1daD2S6ydRd50M65fUijve9E6heQMZe6FDaFm7NlhjiTTHOdYk6T+NA9Ge2uTunpxd1kvV9J33orvn/uY+PwfrkYAow7fUXhb9MflGSKmOxgADAieGJ10rd3zKO4XVhsl6z7LY64tM9jHJiOq5aguhFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8GX94v/EOWA6Zqt65agMICdiL0LsAl9pz2nFQfiyps=;
 b=MvcCDhEtvstJE6V3SzmgfkbPkpRT2VTfhVPEl1WF4oFHYrcW0qeQxfAnRt1EG8wqarhW/aALZ/o8ewd0cihqq7AIC2TnvT6piEid3CyB+Ru+q2GqFFIz0LimTQNbJGzr8vhSFlxmWJP+vlFp58poz+m56Sm8OF9qGbI6Vni0xmhTdp6ZP/GVAnfUs6t7+KQn+gNpzQXFIUEt/7R2senQYbbaDJ71p5Vf6NSL8fx0jxwfMnxSjJUpm7sKovKbwfV3glXwQrhYmQIzfsUtUPmNPIajf5VSqhuB5slYalxqmJZasUSxIEnPS8y+FVkVnWLm7xmS6hr9dQKWtrU2O9vuxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8GX94v/EOWA6Zqt65agMICdiL0LsAl9pz2nFQfiyps=;
 b=4/1hw0e+fjDG/QmddpTwMu507il0Kt/6BjQ7c6DV72yb7XJShZXyueShnGHTvxwlSBPh2l4VgNeE9b1h4wRfSm8ilnNotYdQl3KcEOcFmBNgtukOQ3ECTPyGL18/zLNdzPOn7OQAx4IxEeUh0wu73BoviN5lvJz8GY/THxAG5I0=
Received: from DM6PR04CA0011.namprd04.prod.outlook.com (2603:10b6:5:334::16)
 by BL0PR12MB4658.namprd12.prod.outlook.com (2603:10b6:207:32::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 14:39:25 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::a) by DM6PR04CA0011.outlook.office365.com
 (2603:10b6:5:334::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 14:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 14:39:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 09:39:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 09:39:24 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Mon, 17 May 2021 09:39:23 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 06/10] drm/amdgpu: Modify GC register access from MMIO to
 RLCG in file nv.c
Date: Mon, 17 May 2021 22:39:06 +0800
Message-ID: <20210517143910.2125-6-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517143910.2125-1-PengJu.Zhou@amd.com>
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02c16bb7-fbf1-47b9-164e-08d9194191a8
X-MS-TrafficTypeDiagnostic: BL0PR12MB4658:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4658FA673754839A0D41EA75F82D9@BL0PR12MB4658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ml97wVnPvL31NFO5nwbCgsyJy3ZZGD4/xXaI7xn+OMKo2OZhRymTJ1t1wiSyOUhmRzdJJDZIIa3ADkmQILmGfKUZGJLdXYBeBe5b/sD5KpNCowocQvfOGpjUSGE5Ghu/xz/YZ0zjDuj5WuDRrz9lXMLG8fweqAklpcRsclb0kPp5wStHkWDLSE5FXq0ND2amVjeasgeZq8J8+O/6+0rnVHypPWtHeKqnRxb9t8awtkjwGl8blQLPKotRmzgAnTHS2MOAavSkVpn34jNc4N/+xmsaeAcNXHO+au/SdJv32Z+K+0ixOd5z0A+apDyp2bQG9Za+8KOWU8ReD15ep8MfAlwNN6BK3BHFq3SblUYoo25BHIh556opmfv1OyoOKvn1GPUFf0+fd9cdyxb9Z3Iu5mJ3Rp6nQ0vjevzQhywVOFvlzp+by49x2cGJsOT6eXqXrpJiLSFxmWWwWLtuI8VRnFJ0fa8pfnawV6Tt7r0uUvhDvIg6ACyrG4ygjT9LZ0C8zQrstfLsIt4u5r/Ht4Lk86e4hUmUYKZhN9tWpTZtwnoQJVswVyOUEezbdrX4HNGzjtev1eEfja6FFrwIy/cvR92upuo2EKxHOJ5q0r0EdGLMS3aSGfVysch07e1aucq/XfRMTO3+b1kt173ex2LoueKhSZAGMgDr+q41HFQBaCS2tvrHc75HMvoSNRgNwyR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39850400004)(396003)(376002)(46966006)(36840700001)(336012)(26005)(426003)(6666004)(47076005)(82740400003)(81166007)(36860700001)(7696005)(1076003)(186003)(4326008)(8936002)(4744005)(8676002)(356005)(2906002)(83380400001)(5660300002)(316002)(6916009)(86362001)(478600001)(70206006)(36756003)(2616005)(82310400003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:39:25.5947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c16bb7-fbf1-47b9-164e-08d9194191a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4658
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 32c34470404c..a9ad28fb55b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -466,7 +466,7 @@ void nv_grbm_select(struct amdgpu_device *adev,
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, VMID, vmid);
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, QUEUEID, queue);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL), grbm_gfx_cntl);
+	WREG32_SOC15(GC, 0, mmGRBM_GFX_CNTL, grbm_gfx_cntl);
 }
 
 static void nv_vga_set_state(struct amdgpu_device *adev, bool state)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
