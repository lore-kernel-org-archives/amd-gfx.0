Return-Path: <SRS0=jcLq=QA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0321C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Nov 2021 00:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69145610E6
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Nov 2021 00:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69145610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8776E158;
	Sat, 13 Nov 2021 00:05:29 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 873F489FF6
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Nov 2021 00:05:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtVgk3HPzw2WF48kmqBE7QtP7ffgdH4VQ2+NwzCJm4endp4IM3mq6mY++4J0Quc9hYzJuJoxzmkG5i6Ftf6vrqNzoHckKw4hnGhJskzzXO2SxHcJ79P+Sz9E3xzAqMvejILu4lsTBXV4QRr7sVLEH1QFFbQ3VyuKLj89PQ9zZL0WHUhNMtSe9xeLFeUa/heLL8YalqXRT5QuMzb6BVWgeYV1Djf7X6f2+fMUIQSmhvjuYN+4V21oeai21FrMEfLP9GzjsRIjf7M9LG79GK0xR0RO4aywR55Kt+0WetQlz5/oIr+UopqBEN+cfmdLBgc6T2Qj+NkiXl2Jwlkm5Nnrqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnTrp9ffsiorPTPiHMe197Mz46N3bf2siz37bEiOi/k=;
 b=FatXRueosx/Cscx5roSfQQsSqU2eJlHZI6RzFXajst95D1vXEDilhYD8bylEW9tAB70EuqFgEzJ54GXiwDEKk0bC6zOEwk+YmlUq8geFQW6MeGuoisVY7y00qQFrlh21rPODc7SYSdg3ieHUWxSypEt/WO6qW4UOkGvJW46A44B8bmF4qokUP0dXwulO3V2Gpqh3pFerkZDcqI85YTOkDQpkrtXhsHi2+mKardKg5kuPFNSr91KlnsD/VP6mc4INaPfx9R7DPcyn9q/amvYECCh60NKGeYZDZu+DLr01N0ADtfCGo9ORzV9PPDhaJELDKUXWgG8Kz17wgAv7IadWZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnTrp9ffsiorPTPiHMe197Mz46N3bf2siz37bEiOi/k=;
 b=VgaFtTZGOnLoPaAzzLmbEhRz2/7OL/PccH739R6uSGZ8HWoFDwM0dOOFICgOIobwEGPN2XI72CHwv37LuiXs5SIMgb8aKGs34/cRlZo5Cgd2yqJK1c/Mgjrbt5TzsN+S5Z9k8mdX5OjRk8Q/VwYTigvtnyDzqwMpc4554d2Sf1Y=
Received: from CO1PR15CA0103.namprd15.prod.outlook.com (2603:10b6:101:21::23)
 by MN2PR12MB3039.namprd12.prod.outlook.com (2603:10b6:208:c9::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.17; Sat, 13 Nov
 2021 00:05:24 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::5c) by CO1PR15CA0103.outlook.office365.com
 (2603:10b6:101:21::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18 via Frontend
 Transport; Sat, 13 Nov 2021 00:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Sat, 13 Nov 2021 00:05:23 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 12 Nov
 2021 18:05:22 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: IH process reset count when restart
Date: Fri, 12 Nov 2021 19:05:08 -0500
Message-ID: <20211113000509.21407-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40cda20e-d0db-4c0a-e348-08d9a6394a52
X-MS-TrafficTypeDiagnostic: MN2PR12MB3039:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3039DDC1087284FDD20890C0E6969@MN2PR12MB3039.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LG19LIhEKPcwQ/3sEKfvZbk861pamPLbWcSIaoFIsR/ZhdeB1p4ene6+uyOwVhN1Pnbqf3vjhQOGKbCq7+uO31yMWHIv5njIAXaHbB+VluHUTGL2U9OCrtTbc07mjW9tbFcNwhpTx+auYJuHu7NRskxLadsfTiwgZ/NwfNO9Mizc0IFyyFtesJW1SH6TjOTz6QSHLm858AHTzxXVQoIHiE5u66plRBT6REFZnNeLsB2quuiGOxbnTFdPvoeU5bnJ8SzXgQ2kH4+YBysnjg6EKVh+IDsn3y1RtueQYlWBrV1m/yHwtERp0FOVGbAHPsGbABKd7TKE/MnFee77L6XONlRKTXs0vzdbaYOT6vZt/Bq9xHJnJr8rBcawYf4vhjuUZv0PRw2ovZuP/5pxNkxNxfNXLwBq77nsqP6siV0cMzip5X6Zj0Q/LOFq3szXWMp1KiyopjupUtLtJB8u1y+DMmbm9XpkHw/OVjpjZFs2C0Lt2Dr+TW62mkVkt+Wx8dHdUdkAchDtl7NOEHa92xjHdBkpklj04UXMXM5tJ26/EK4T8TZYt9btA8btoNxzJiFJic0U1s6gH5xYTyHNV86CaCQuhRu9f48y4ZfvR5TM/hazlkuNEV7GPG9NzN83xFKNaPHVQRw6wEfC4M1ji2x2ozRplNA92FQoglPNlgMRsNpXxiIxhD/URhtZ1Lf6U/YNKoLccMYSlHxIbERMQHWHTmZcMx89USCOcECY5IhrHDo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(426003)(5660300002)(70586007)(36860700001)(70206006)(1076003)(336012)(54906003)(6916009)(8936002)(82310400003)(2906002)(7696005)(508600001)(83380400001)(8676002)(36756003)(4326008)(16526019)(186003)(81166007)(6666004)(86362001)(316002)(47076005)(26005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2021 00:05:23.8209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cda20e-d0db-4c0a-e348-08d9a6394a52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3039
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
Cc: ckoenig.leichtzumerken@gmail.com, Felix.Kuehling@amd.com,
 Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise when IH process restart, count is zero, the loop will
not exit to wake_up_all after processing AMDGPU_IH_MAX_NUM_IVS
interrupts.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index f3d62e196901..0c7963dfacad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -223,7 +223,7 @@ int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
  */
 int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
 {
-	unsigned int count = AMDGPU_IH_MAX_NUM_IVS;
+	unsigned int count;
 	u32 wptr;
 
 	if (!ih->enabled || adev->shutdown)
@@ -232,6 +232,7 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
 	wptr = amdgpu_ih_get_wptr(adev, ih);
 
 restart_ih:
+	count  = AMDGPU_IH_MAX_NUM_IVS;
 	DRM_DEBUG("%s: rptr %d, wptr %d\n", __func__, ih->rptr, wptr);
 
 	/* Order reading of wptr vs. reading of IH ring data */
-- 
2.17.1

