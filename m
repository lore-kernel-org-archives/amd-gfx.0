Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80331C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 14:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4186760E74
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 14:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4186760E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD69689B38;
	Tue, 26 Oct 2021 14:45:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CDA089B38
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 14:45:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEH+0ybp5jOFijqCXc/frVqNJD/957e/X07bqILy7YuIycfpYQsh+nOR9wIb65Mgw4BBbCCj7SH+woMh9KMmY7ow3q/VlinWGb988R2ZADlmRj3LCC/tlxwH1X5ZsHppP87wWaPbCzl2G7thenf2dC6nrxry6PRhKSWwIan8rN6M8qBjMJ3f3yY05x8+mkA5n4IB504YEHLM0IGVsIVtLq8TjuaajlpXmFNdzhSzBZ0NZuLqrLTa4AcH8m6fmyYZoiJJNOzh10vbUmXGOSwnGvm6xzU0lASuPI6TyqIMSx8XNnGYvUsxn2pp4J/PMFciP3jufYRovoY7fMoEnr2G2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIQjceFBMQ8Xb1IGDGrzS0Gz1b1scIScdXLLbEsluXI=;
 b=U59d/vZY6ZzJ/OHnEbKMrVAId8w/H2Yt45CS2+FnK4sOzDmKjSyRJiKykD6xhuwOQ7Q8U6UGPyr+6uU4A0pmV5fa0OCRvXHIx3u8t1kriWzkMCrj/9sKcyKvaBndBeho3IsHZ3lVVdG+/NqLUqmD9gYIwVVO3QWPmjAZAibytbQgX+GsehDc/kB/40oRiVkt3qKxHfRAP58K+00D1yWWIoP/4hIQpuqUikfRnL/iqaYgiE1/amb/7XJV1rxiFEEAoXron9DevucHuSxSFVA2QZZ5Q5fPcU5D1obYnHcVmOEvFOTaJOoRT1ZfsOyEZ2FsStmnLzSCR3nENOSo2OegTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIQjceFBMQ8Xb1IGDGrzS0Gz1b1scIScdXLLbEsluXI=;
 b=sIRMuaFM3hUb60Jtvutf6+axvnXcli70fkHNkWJxKcqXUvZ30HG3YCHqV2OqsvrfqAZnl4aTzfBrKttFKiJJp4HF7hxGDNZH8/t0xj2vQBGKqO1PB2j98hVuaN3BZLFqOBLYGtpjLVhDVz8Z0nsFkpJaF4x3JQfpMr4xe3+8D2s=
Received: from BN9PR03CA0737.namprd03.prod.outlook.com (2603:10b6:408:110::22)
 by BN8PR12MB3251.namprd12.prod.outlook.com (2603:10b6:408:9b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 26 Oct
 2021 14:45:50 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::e) by BN9PR03CA0737.outlook.office365.com
 (2603:10b6:408:110::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Tue, 26 Oct 2021 14:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 14:45:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 09:45:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/discovery: add SDMA IP instance info for soc15
 parts
Date: Tue, 26 Oct 2021 10:45:35 -0400
Message-ID: <20211026144535.191727-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026144535.191727-1-alexander.deucher@amd.com>
References: <20211026144535.191727-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 509a1d5f-f312-4d53-3a9e-08d9988f4e04
X-MS-TrafficTypeDiagnostic: BN8PR12MB3251:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3251547611B76766A186EC76F7849@BN8PR12MB3251.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12eAKHiOvX5wxmDZe+7tkYHlPk25sH0L8el0xMktCevK7Ys8xODRf20tcJzKrRF0+heC9wTRJcD0tnHTZSvpWNSmBVckcvDC4sWhQANT2MNUugVPArmoOMT9XzEBvdvOUmm7+3OulaYy0gaPEdk1xGpPZwufF3+k3/eMS0Y8aI8LdZcblfW1raUP/VyBg2WU8MEX2iChDFjIOBwX9KPQkefZqJN2gOCY7PB6WpdeKj4C6nSevYSjzyVr4IpkDKn752+Jf86uLM1a4EnDGBmHZ9NbtWTDpt/36FknnYSUbFGXhibhGQP9aM5t+paPsoyyu6sIU4CkCkEL0rfiGnTQu7dndMP6AmCKKa7jI235kUQtyG21SPcpCNsvwGOdzdxNZAnI/GdNDVXYmRhTyJiFjiktDa8JINwO+j15/AwsW2XW3pa6VZILS06tnzD/1sOWngiJP6ixBzVJKX8ZSdRAH3EQ4vyWNmNFHfr+u3GjcS1Ty7Q2WUWGjinDHWkLgQMViHWkaH985BL6/01BlIKw6owqVuB4EXBvTFgado0acScMcweDNP92IJxohvzxerTaPhGLdblw5PEnyy/d5CfCkRWsodRF8kzkaTNSeCn7RDIh6amZXL7jH/+v2CKia+B5uEhcBLXPEViym1y6yZZLUhlii9oRZjkP/L92NrkQit/AJy5OahweX8KGsPDE5rCsPq7erdQCssqTlZvvkJeqNWeQNpQ7Lfiz1rfPmcuMAzk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6916009)(356005)(186003)(336012)(83380400001)(2616005)(1076003)(4326008)(8676002)(36756003)(16526019)(8936002)(26005)(7696005)(2906002)(82310400003)(70586007)(47076005)(5660300002)(36860700001)(86362001)(81166007)(316002)(6666004)(70206006)(508600001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 14:45:50.5861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 509a1d5f-f312-4d53-3a9e-08d9988f4e04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3251
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add secondary instance version info for soc15 parts.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 44b0821b6ca3..d7c8d9e3c203 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -931,6 +931,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 0, 0);
 		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 0, 0);
 		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 0, 0);
+		adev->ip_versions[SDMA1_HWIP][0] = IP_VERSION(4, 0, 0);
 		adev->ip_versions[DF_HWIP][0] = IP_VERSION(2, 1, 0);
 		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(6, 1, 0);
 		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 0, 0);
@@ -951,6 +952,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 0, 1);
 		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 0, 1);
 		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 0, 1);
+		adev->ip_versions[SDMA1_HWIP][0] = IP_VERSION(4, 0, 1);
 		adev->ip_versions[DF_HWIP][0] = IP_VERSION(2, 5, 0);
 		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(6, 2, 0);
 		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 1, 0);
@@ -1009,6 +1011,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 2, 0);
 		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 2, 0);
 		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 2, 0);
+		adev->ip_versions[SDMA1_HWIP][0] = IP_VERSION(4, 2, 0);
 		adev->ip_versions[DF_HWIP][0] = IP_VERSION(3, 6, 0);
 		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(7, 4, 0);
 		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 1, 1);
@@ -1031,6 +1034,13 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 2, 1);
 		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 2, 1);
 		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 2, 2);
+		adev->ip_versions[SDMA1_HWIP][0] = IP_VERSION(4, 2, 2);
+		adev->ip_versions[SDMA1_HWIP][1] = IP_VERSION(4, 2, 2);
+		adev->ip_versions[SDMA1_HWIP][2] = IP_VERSION(4, 2, 2);
+		adev->ip_versions[SDMA1_HWIP][3] = IP_VERSION(4, 2, 2);
+		adev->ip_versions[SDMA1_HWIP][4] = IP_VERSION(4, 2, 2);
+		adev->ip_versions[SDMA1_HWIP][5] = IP_VERSION(4, 2, 2);
+		adev->ip_versions[SDMA1_HWIP][6] = IP_VERSION(4, 2, 2);
 		adev->ip_versions[DF_HWIP][0] = IP_VERSION(3, 6, 1);
 		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(7, 4, 1);
 		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 1, 2);
@@ -1051,6 +1061,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 4, 0);
 		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 4, 0);
 		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 4, 0);
+		adev->ip_versions[SDMA0_HWIP][1] = IP_VERSION(4, 4, 0);
+		adev->ip_versions[SDMA0_HWIP][2] = IP_VERSION(4, 4, 0);
+		adev->ip_versions[SDMA0_HWIP][3] = IP_VERSION(4, 4, 0);
+		adev->ip_versions[SDMA0_HWIP][4] = IP_VERSION(4, 4, 0);
 		adev->ip_versions[DF_HWIP][0] = IP_VERSION(3, 6, 2);
 		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(7, 4, 4);
 		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 7, 0);
-- 
2.31.1

