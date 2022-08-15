Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578DEC00140
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Aug 2022 19:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 832AAD3553;
	Mon, 15 Aug 2022 19:26:35 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 826ADD3521
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 19:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZFdBezjwzK3CzvyObu5jkj0LiSXGavOWlqNG9WNE4tVX4to62drOwRE6kvHCwAIj8/4a2m7zFpvJcqQr9x+hXJ+tGg8/Ez2mpnfRrRDbg9r5EHWyby0pIdEzZK9pSdFriEvieyOuAcilTnKjVxq821cOHZm/g+7h0hyq6vvW1EQvww4U+UbWcfkOu78/GwKo7wN5FMg+iCCvITzp6LyeDxPQpV2R2w141V6XU3zNraWqli8v2A4uLpdJZ6QklzO1KeqsPFHwtId3b+Yum3hgROKGxplOQuMZChaSMy1frOqGZ7DClUKrQbeTZdWPbeSABzacUq1JNT9jv4PifFDkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzWsDUfuU+1IG+FA5paJMCxQo4kw6dWcqANfRrG7BgA=;
 b=WATLTTMrHKCNHy8LwnKBC6sH4tTTGCE3dhwZl1N1PK035+wHNPN4ZcmOvaFod0dFIVgFDsg/Yk6sVMEhF9CQlcNdGHCv9Z2Bh+uNJ0zRLwjpwJNZk5JM3s+J/4drpa637SBLxdCcSSYYB/O3w1klLWIX7Wi5dtUC5LcEGECeP7irJ+s6Max6OYbuqYbQpJI9LRnRcz6M4Yz9owaetjrxh5wmpUBS4/IBBd6Ny3HsO7DGppP81zXboe3/iRu9CmAxpwWTT+LlnFrC+1QzXcVlrzk3HjtfQE3/hr7FrjLApmWvsitGcWmMspoC68UcLPzvCeYZFc3ICO4n77hAlnMmmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzWsDUfuU+1IG+FA5paJMCxQo4kw6dWcqANfRrG7BgA=;
 b=3jCY0aynsgqzGd6WGpIoiLvFowd12BdNbOoP3S8iqNxflG5ucmlrbdhcM5P3rgA5G1hXF7NqpAVXed/q/2hazAgWUcZu/4LYufSTg38FEOoPmVwnJwsw7ljqxaH51Z5H+lFfj7ep4Pf9EpHakprKJuukVo/4TZhW1dl52xtrzig=
Received: from DS7PR05CA0016.namprd05.prod.outlook.com (2603:10b6:5:3b9::21)
 by BN6PR12MB1252.namprd12.prod.outlook.com (2603:10b6:404:15::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 19:26:12 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::d6) by DS7PR05CA0016.outlook.office365.com
 (2603:10b6:5:3b9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.10 via Frontend
 Transport; Mon, 15 Aug 2022 19:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 19:26:11 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 15 Aug
 2022 14:26:11 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCHv2] drm/amdgpu: Fix interrupt handling on ih_soft ring
Date: Mon, 15 Aug 2022 15:25:57 -0400
Message-ID: <20220815192557.3348828-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc89692d-c3c6-4dba-c461-08da7ef40358
X-MS-TrafficTypeDiagnostic: BN6PR12MB1252:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3mn6okNcUPXW/dHIQDwNSrf7mgeWAkm56HlgkYQW2ND59/rtvkJzjgSf+1lv9nHf3WcAqxOCr+EoQvU+9O/ZcLtTYaCl5iSeJj+Ang/cvgbhra/HmnesDiN+I19QgHK9N+ubZMzUWJd4mrPYd3B43dTlZw+HcoxV12DdBgmZ/F1/MW6M/esvX1daQMr3GcyiL9sETJ+Xi6HLHD875hh7Jg2Rinu1d5upvrvybzLYngZht6hzYs5bkkY61VACu0MooxV7S4BhGecsFLIOzFo59IzqgG7cGeGe9TDJfWrY239hcr/4wqXeXpBvwP68BTFKwhfoVH8OaATzXN/UYLIe363VsmjZ0iZvmEWieKoDvoBLL5gnEioXVl37p+cVlG+Ta2B1tfcGksomgVv54AE3cy68zP4T9bEt1bqVjIEi/bqXlaf8gfVK5tI/XsYOWnON58sKp9OrHWo6lW66jGwYpG7NQP+JjSjE8MYRibXioP6pFAAWoLK1d0rh4uySS63Cm3MbLCYBgo0aijbupooXm7XxYjDv8cR/d6b6PfUax6EhKIApGLvqlU2yzCSaDCoy+w6rEb8RsMqbydCMJfVFrjvs0L3XKui/37n47WN5tF7lLkZHB92pQy002I3tCg9Jo87V8k0h2+ibd+oKejfvrVAZ3yCP2WeN7KrmpyBxwR/sTh74YIKUhsTp89ipSxcuIu/96h2u8PRnW+Kl6+bM1vMGXMEDCPyvH3NkSF201ytafRXo0wQRCKDkTNKVK/fZvCSLxAQb+0pU25ZXDdpSEo63o4EU4f02uZxC+8rVS2BwycdcecLywv13fgQp3WDcuhPGmjpW8yjteRe3mXa4g73ogT0EtvG5/NMAfeZdVs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(36840700001)(40470700004)(46966006)(336012)(7696005)(36756003)(6666004)(186003)(86362001)(16526019)(47076005)(41300700001)(1076003)(83380400001)(478600001)(426003)(2616005)(26005)(40460700003)(316002)(8676002)(36860700001)(70206006)(54906003)(70586007)(40480700001)(4326008)(5660300002)(356005)(6916009)(81166007)(82310400005)(8936002)(44832011)(2906002)(82740400003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 19:26:11.8678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc89692d-c3c6-4dba-c461-08da7ef40358
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1252
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are no backing hardware registers for ih_soft ring.
As a result, don't try to access hardware registers for read
and write pointers when processing interrupts on the IH soft
ring.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 7 ++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 4b5396d3e60f..eec13cb5bf75 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -409,9 +409,11 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
 	u32 wptr, tmp;
 	struct amdgpu_ih_regs *ih_regs;
 
-	if (ih == &adev->irq.ih) {
+	if (ih == &adev->irq.ih || ih == &adev->irq.ih_soft) {
 		/* Only ring0 supports writeback. On other rings fall back
 		 * to register-based code with overflow checking below.
+		 * ih_soft ring doesn't have any backing hardware registers,
+		 * update wptr and return.
 		 */
 		wptr = le32_to_cpu(*ih->wptr_cpu);
 
@@ -483,6 +485,9 @@ static void navi10_ih_set_rptr(struct amdgpu_device *adev,
 {
 	struct amdgpu_ih_regs *ih_regs;
 
+	if (ih == &adev->irq.ih_soft)
+		return;
+
 	if (ih->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
 		*ih->rptr_cpu = ih->rptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index cdd599a08125..03b7066471f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -334,9 +334,11 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
 	u32 wptr, tmp;
 	struct amdgpu_ih_regs *ih_regs;
 
-	if (ih == &adev->irq.ih) {
+	if (ih == &adev->irq.ih || ih == &adev->irq.ih_soft) {
 		/* Only ring0 supports writeback. On other rings fall back
 		 * to register-based code with overflow checking below.
+		 * ih_soft ring doesn't have any backing hardware registers,
+		 * update wptr and return.
 		 */
 		wptr = le32_to_cpu(*ih->wptr_cpu);
 
@@ -409,6 +411,9 @@ static void vega10_ih_set_rptr(struct amdgpu_device *adev,
 {
 	struct amdgpu_ih_regs *ih_regs;
 
+	if (ih == &adev->irq.ih_soft)
+		return;
+
 	if (ih->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
 		*ih->rptr_cpu = ih->rptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 3b4eb8285943..2022ffbb8dba 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -385,9 +385,11 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
 	u32 wptr, tmp;
 	struct amdgpu_ih_regs *ih_regs;
 
-	if (ih == &adev->irq.ih) {
+	if (ih == &adev->irq.ih || ih == &adev->irq.ih_soft) {
 		/* Only ring0 supports writeback. On other rings fall back
 		 * to register-based code with overflow checking below.
+		 * ih_soft ring doesn't have any backing hardware registers,
+		 * update wptr and return.
 		 */
 		wptr = le32_to_cpu(*ih->wptr_cpu);
 
@@ -461,6 +463,9 @@ static void vega20_ih_set_rptr(struct amdgpu_device *adev,
 {
 	struct amdgpu_ih_regs *ih_regs;
 
+	if (ih == &adev->irq.ih_soft)
+		return;
+
 	if (ih->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
 		*ih->rptr_cpu = ih->rptr;
-- 
2.35.1

