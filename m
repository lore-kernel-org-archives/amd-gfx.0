Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3B8C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Nov 2021 16:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A06926E4DD;
	Tue, 23 Nov 2021 16:04:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A194899B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Nov 2021 16:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPFq1xz1VeI+cVtgC4N2nAa3EW07+akrqlC1rhrIiR1qVLhdHn36xmRcoH3h889bzgV92x75iVduJWIoKXmr7MJdAc63SOKnpIbQLPrfCYP+mlKWz4W4o6WXKQpJ8g0o4o2v7nlDWdjvZe+NJbCuQtC37CntTQPkW8itGxK6iJSEgo4oHMNtTd/RGkJ7H3ava7ncUKH3OWJJbhroE24fpjuBeaN4gGTxhh9vpEX6d04/p0ccHpkUarsmkLf3/A9WbAshdS22wXh9ug46AvLgH0rmbgyUcGXkgp30OFUhoNL0DoaRX3i5C4LoAbvJku7/dv4UXmImQ9bAzviRgoKh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFqr3Qfgf5HErmPxCL9g38PmqiIk2C+tNW7xgyJcHTA=;
 b=bNN7KuMC4iYQUUqJwCulL9cianMEtdt+v8kOBWIIuAtr8sL2l2Fczz1u/BP1N9QVQUELlKjzy3hrwFAP7cvJ3KB+BjwjSo6K7WJ+o6LjYYomHJxz+XhO/JbIPOOU2NtRTV3GlC1ANdMA1FB76PpKLOeqhHweXtFwnxHfP6571/RbbsS6iy1S0lQJ8Jr1OY3/875CnjF/3mKAdL7InDHJrnvk3aGLLMvCe/0ZTlXsSRqW8L0c93Zxsa7W6FpQrOaEOCFjy7/e1288VjXhLHsYnSk9BSvxGMUmR9V4DcyEslgPgt5RAjTokEOdVzSujM/uZF1WRiyDbm1BnnVCFL3n6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFqr3Qfgf5HErmPxCL9g38PmqiIk2C+tNW7xgyJcHTA=;
 b=0O5Woe7LzWorKDkjS9NRGhfyNLUJEXdhSZcd44K/93Nx1HhL2zYK+rYpsgaNf9ZErae3nZtKldSKLhoGZYit2/Ht8D8QSeDSvlYbF0daStnJfFr4gLJB4ZLKkNNdu/6GlJlaG3oEv29JoHS/SHhMLEvbJDf+/owiedyn+9N/8do=
Received: from DM3PR14CA0141.namprd14.prod.outlook.com (2603:10b6:0:53::25) by
 DM5PR12MB1290.namprd12.prod.outlook.com (2603:10b6:3:74::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.24; Tue, 23 Nov 2021 16:04:10 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::1c) by DM3PR14CA0141.outlook.office365.com
 (2603:10b6:0:53::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Tue, 23 Nov 2021 16:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Tue, 23 Nov 2021 16:04:09 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 10:04:06 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: enable Navi 48-bit IH timestamp counter
Date: Tue, 23 Nov 2021 11:03:51 -0500
Message-ID: <20211123160352.21228-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d069990-775c-4c5c-f113-08d9ae9ae285
X-MS-TrafficTypeDiagnostic: DM5PR12MB1290:
X-Microsoft-Antispam-PRVS: <DM5PR12MB129054A50BAACF3ACC2DC8FFE6609@DM5PR12MB1290.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: coOhNACvVw1cCVTVqLdUH2c3ZqiykkD9L/3w5xFA7q0tJDVFyrnr136tBfzmSQIDQdgJwcGza3GRxOTL0W0dXWuyA05p/D4tjj1dsPusD/MV93Kep2vCIXsYDrS5jM4bunmSRepu8XpcKN+fnhY6/0+E393sXF/llKKRohhLZsCVplq12Psm2tyiIKCNcfSRHwzRX3+kilvhscPuuXjx2SeDUMIIfwHlI3FnRfZk1CpT88ULaxUT1CYc4VoWQyX3YVEk471XuYTCzAurPJwzQL+CmEORJZBfzbE748D+tROcao4OTfZ4CBX7CZV9M1e/+W2j47Rm+7UUgl1HRGRkoRQODVEbs4cKOyckIGU3XGaaL0juaN5WonjlEq1R00J6DovIDuZJyRTEVcq8vZfsBlJhHp5oWz+zrDHiWuKb11u0ojXi5taNH1hL8bk0NS79ffEwd8RxwpVSFOArMXM4BZImgK0FZ/P13eZydeXCeaHteXl+VNbusaGXtkXs+b4oys0IOtMRhIcKvN9uDaPoD2RfOsOyfPpaymnI3NMgTTTYdZ/DprS7XpcSraEaNsZkep9VqgKFNxNb+id4cZivj8sg1MTos4ZUHcFrMN4yjbF7oRstLhE54pfN3jsdxVnR5Tsgr769I1uXHAkxee7tE3FgurNvf8t+rXnX2lJEPPUwgU0ba7LXpkvrgLSpLnLNUrTxr98HyCeUgE5Y4clR/dfaDMZ9X+Vc+GLnj3qXuws=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(36860700001)(508600001)(6666004)(36756003)(26005)(5660300002)(4744005)(4326008)(86362001)(8676002)(336012)(316002)(6916009)(186003)(81166007)(70206006)(426003)(356005)(70586007)(16526019)(47076005)(54906003)(2616005)(82310400004)(2906002)(7696005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 16:04:09.7431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d069990-775c-4c5c-f113-08d9ae9ae285
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1290
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
Cc: alex.sierra@amd.com, Philip Yang <Philip.Yang@amd.com>,
 Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By default this timestamp is 32 bit counter. It gets overflowed in
around 10 minutes.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 1d8414c3fadb..dafad6030947 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -160,6 +160,7 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 
 	tmp = RREG32(ih_regs->ih_rb_cntl);
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0));
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_GPU_TS_ENABLE, 1);
 	/* enable_intr field is only valid in ring0 */
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
-- 
2.17.1

