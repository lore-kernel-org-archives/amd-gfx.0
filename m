Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7964FCDE00E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 20:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1815510F367;
	Thu, 25 Jun 2026 20:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wpNLMhdY";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D50310F367
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 20:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4Bqi/VEXo8UBR8oKoexSrmUr0XUEpSi5JWZDdk49AmbGROkcz37Ke0nOLuzXqI0Mt4KcLfyZR231tkZzpcSeP9sIUSMVJdd+xUkXafVq1Pvd27fbdtoe+1npr19QVR6XRMqWZmlUm+/6U1RckC8K2DtjfAKs0ogWPi9PayHOOqAEcQjP17yaML4t7fxB4/KLUpYxOmpFYSi4QXAwVFEr3tM2W6TNyQnGSSbPmqAj5nyB/TmCJSlai3G2p9brIhU2bNlLDvWf2M8ASynNwkZtlWnUDPmrx+iZX8/ZXHOoO3QJUXbgf8Wxa8xn+3yZ/aZF/BFyCyrC0ZGIQT90Y1Dvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAmVdNfuRUYG6zAa6RSod1IfNwMMD2uT5X6xuirydAo=;
 b=ovvIPlw2nMRkQkRsdWceJtkg90b7ywaba5JGeTcDYoilInZUKW6/k+mmr9e28PnEvNg1Zg9Xjk4oldSF6dXZBZgN86gjtq3PNqxrJODeXH9tYHO8xun981XhtB6Eh5aKJIeOsBi39r7ATyu0bK/N3Y7GaKj5wd9ZlMCLL3r7QD5qoUylO+f5WtLOxd2EOmHuYnrSDbO7bUk7x/kf65/rYPW57LJ7dPrAC7LAE+Uz/IrzIWhM1p0y1+mdmNGs8BSe8RuSlaAYA5nlMdTFvQvFmULCDPUbMXgtHIpNmfpyiMrSvtkngWkH5Fy6c6MwRh68//+lmzPeSQn0eoitxt7wkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAmVdNfuRUYG6zAa6RSod1IfNwMMD2uT5X6xuirydAo=;
 b=wpNLMhdYbNAgBlRPg8pU1y0vBdB8Acu5OabD8kLZq2lWsY5vlbSCWEGFv7YDNvkisklNnyuNQuS7FnhE7OW+Q8/1z24W1TqsavXZmyFJWO6V4qYCdF8W80eUoah+1eD20VNXYLrLEQXoLTwlrCi0UuOFLaclVZhGLv2kBCWcPfI=
Received: from BN9PR03CA0194.namprd03.prod.outlook.com (2603:10b6:408:f9::19)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 25 Jun
 2026 20:58:05 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:f9:cafe::a1) by BN9PR03CA0194.outlook.office365.com
 (2603:10b6:408:f9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 20:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 20:58:04 +0000
Received: from bokun-linux (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 15:58:04 -0500
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Bokun Zhang <Bokun.Zhang@amd.com>
Subject: [PATCH 2/4] drm/amd/amdgpu: prevent PF-controlled record_length past
 buffer end
Date: Thu, 25 Jun 2026 20:57:46 +0000
Message-ID: <20260625205746.125043-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0d6006-b999-4c00-56d2-08ded2fc739a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: CNvB23ronvUt/fvoldeAplO4SK3JqJCper2Bct8JK/3w8o7ELdBJ0NpOfonsGsWC8ZaD2xdrSdI345EJ4AWT1QcXcQZiUV+NG7bVSbXXoamgK6YMtJsj7kikMOrdNk014Ru5MXQIO8U9II2H++4OuqQxbYqJJunAfz3hFhewueJAtYMbo+dXGpp/b1uXCmYrjOmRdWJCHrzFyM4XRkeWxIkIYwsI4UYdHHKVHTY0Hr87ar4mFjxbHmQs3jF8wVd+exkj6QsyVRZFDrsJ6SlorF/aIIDmZyIRFpxvfVYVXHpHm4K/pv4dKC7ONzWWYkUaHL/TY1FY2PAWnFPG++CHPgewbnVlhHBcxbpttf6ulE9Z42Dj2/YTxxXuemz8nzvols5vAdx6J28jMTp0LgcsmrH6gGxu7rUrua7x9D1xV2r4S7BC9Nz5A74CIgwHcaY4eO1Feo04DgfRo4VheItUNXvYyv3w2nfH2FhDlenX+u8JR4HGFE9d+P773HZDT8CgBO+hgAPxAhjPrVyqspN+RyJO0P9Gr7QHN/ZgVMIQtC9xK3SxwuTDxx70QwslYJqH2ezmbtFXojI+YaKF93+TxxzWwFfld+gHsLI32eWYeUeAQdQnasT6gHZzaZ+BqTeoZy3AfuwDfLzlm8CWY4FLLAoyASxxGxp1DSL6p0SXKzqJNp3+PSsDB8toGFZAifL3qwEslGXs010a+Q5JhKYy0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NU5SJzO0IwmpySIQwF35mLor99f+Eckz9DiJUERw96ZgDswB4VvdZH8SqZ1ltLFf2bbEKD9fjdNeJ59OJ+bRWhHW2FhceNlu4EY2dPVP79DNcfCF5Om83uWbU5AyC5eK4inewH93iJviW4rvIoIHpEtBvh+C6zOEtYTk5D0MqPrT5xblMMxunNRzKky/do3HiMIn2OXdqfH8RA1GqvpCqWEJi3mTpXY5TIGgXVUEW/8w48+RE0ddeDe90f9vCzSCqeGgOmqsPBf3LwdWky/B0pscJPRFS263rCnSwwhXmm1WqnLCNsl6wIxs5P78V8+GX+B2Inj6lQytHKSmCFfB9TcVVt9/9+Rczdbmtsx95ZxEWVE9VvBTsnfERy0ggSo5WU8d9QzFRjfZnolOaE2HYXF9i/sFiAJSZDBLKovYASuBP7flRFXNFLX/vtuhDrji
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 20:58:04.5832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0d6006-b999-4c00-56d2-08ded2fc739a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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

- There is a latent bug that the PF may size a giant CPER record
  length and corrupt the VF's kernel memory.

- We must check if the pointer goes more than the buffer boundary

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 6974b1c5b56c..f77709586115 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1797,6 +1797,7 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,
 {
 	struct amd_sriov_ras_cper_dump *cper_dump = NULL;
 	struct cper_hdr *entry = NULL;
+	uint32_t record_length = 0;
 	struct amdgpu_ring *ring = &adev->cper.ring_buf;
 	uint32_t checksum, used_size, i;
 	int ret = 0;
@@ -1831,6 +1832,13 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,
 	entry = (struct cper_hdr *)&cper_dump->buf[0];
 
 	for (i = 0; i < cper_dump->count; i++) {
+		record_length = entry->record_length;
+		if (((char *)entry + record_length) > ((char *)cper_dump + used_size)) {
+			dev_warn(adev->dev, "PF sends corrupted CEPR entry\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
 		amdgpu_cper_ring_write(ring, entry, entry->record_length);
 		entry = (struct cper_hdr *)((char *)entry +
 					    entry->record_length);
-- 
2.51.0

