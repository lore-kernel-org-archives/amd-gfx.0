Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AB1C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 18:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58ADD60EBB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 18:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 58ADD60EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F6006E321;
	Mon,  1 Nov 2021 18:45:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3754F6E30D
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 18:45:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeFFme+jKkvHQ5GrTJHn0mOhlMDf9BMoVHzVt1g2SZYa+BlOVJfKmrSBpqOVXSmsFtq9Y+gh2VshNgvVwoEEfF269G+Ek3O5WFrYJ+dUTLwXfkVSkno9c8CT86/rNydxnzlQDLW+FnqUZmJQ7GdV0jty0E+JpmH5hIgVKOWhrJ1zh+CtZp4fVcllYXRmjgKMBpofYY7h0CagtRWOXy9JiimQcHt0sVNYQbdSfrD4QTuiB6C7leCSgF4jvX1yxDquTBSERGrcpFefjEZ4DLU6lbLbknxgr8Yxx1E9dJOTzs29xFyxzDVyrfLLt/w5IHN+7e/ARjD3YNjbNJhqMfZH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFJuZ8gAKCys7A99erwGRcxebgrBMBAVrof1JSst+Z0=;
 b=QoNg9kbSvp122wnjNCgGt0XG6KMMk9tZYdEj6PGRyeYanGgIDkjDvHbmWr2MGylbVnPy/xVdMrJ5deTIjf8k1zZF+BKYwqDNY/B2J4vE5urSz04+aqF6yexA0+gr/jfp8gSCt71fVTko7rVRHunBEVdULos6KL/2EQocbS90jHFZJP5NX0155efVg+s/s1PT/VUOXblHGX9R8whmRkG4fpQKoPW2W94sOZTUWFRt01QDq+b/bUA1dUhbBGLPJ+3OeTIfAC55W7oPTYXjvHEXpWvaCum2tZEYYC0ztUvyrdxH7EUR0fYWi6XfuxoQPtqAY588eqqNextNuVtZQxPaZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFJuZ8gAKCys7A99erwGRcxebgrBMBAVrof1JSst+Z0=;
 b=Ra/RgrKLDXnDSU6hwCXK9sRCRRBrkevroRf8C+lD+8qKvtZ2O96r07gCKU6P3lY64UbIWN1mpQiKO7Pe0NvFvPdmgu1+1nbmaEEx1Vy+8B38I5BW5myXKXsum9uFXiZqhGGBxa2/lCPye/p1N/kwkRZ2cEbuIg6m/k0vW2xp6qI=
Received: from CO2PR04CA0160.namprd04.prod.outlook.com (2603:10b6:104:4::14)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 18:45:48 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::5e) by CO2PR04CA0160.outlook.office365.com
 (2603:10b6:104:4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Mon, 1 Nov 2021 18:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 18:45:48 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 13:45:47 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21.40 2/2] drm/amdgpu: Temporary exclude GTT BOs from KFD
 memory attachment
Date: Mon, 1 Nov 2021 14:45:21 -0400
Message-ID: <20211101184521.1689060-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211101184521.1689060-1-kent.russell@amd.com>
References: <20211101184521.1689060-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3509280f-938a-4035-6763-08d99d67d21a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4281:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42818EA5C35812F39762197D858A9@DM6PR12MB4281.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vgI3h8MKsiOpncRvajouVshpg0kRteFIDeXL3oKwRV9j+eRQLE+G/P8EEpkS3xNbn3Rh4q9zls9vrbWvcgV/kvtOqlm7mNElee6X3628+SomUGn+SrSTn/d1ZISWN/3Mk2V1Oz87ImQAX2iMo6tC4fBkV+ZctU+hXRlcg+JJhfCjbH1zX7/J+PGdy5NEP5yQTolL85JeAWbze2RoHs2ug+m73Vzqxk8ZAtX7mu8FZn6GdIZ6LUlc2LSMpn95Lx0NV5vU5XES5Tm+lcUitno5ciI3I/k/NnBgdUgHlKECMU6nnF2FqNi13Uiw+pRP4mlgRlLKug09VZkSthMkJWdkDVRzqcvIfNcKU5OB7A4v0McJ/d3XOigiPeDmobUDbRJoQyfqeM6Z4gtayVso/sX54a2bpeFgYuJCa9tCYFvzqs8Aiz6RXSR3k/nYzmK5WTKUNL8sPFduutbcIjnhqyz0zK1mjLj+KBnfpOPzkR+l0xvNl4teo3NrZzHLOXN2gaMJBdT8YvdxdzNnXzVXWdhfy7Y0S4jo33Sb345gy22LJoteBcTZ51JJWeVdIErJWcseOxBnZQIHGzmAspaK/dv6whVEyJwCorA9hGzNcQUT1MXEyFqam6oFIF2poVvyJtaBlEWU+dGjxrmIcjzr6/+uXWM+C0xTGfuNrLePIBZ5uGI5+f1vzl2UTHRChn9Geh7e28Tz7B0S7lWQ/fSWxDqDnqMWQUYeVdyE8+OHWFBjEs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(82310400003)(316002)(8936002)(44832011)(5660300002)(86362001)(36860700001)(26005)(6916009)(1076003)(16526019)(8676002)(508600001)(47076005)(4326008)(36756003)(336012)(81166007)(7696005)(426003)(6666004)(356005)(70206006)(2616005)(70586007)(2906002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 18:45:48.0204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3509280f-938a-4035-6763-08d99d67d21a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

kfd_mem_attach is not sharing GTT BOs correctly between processes. This
can cause kernel panics due to NULL pointers depending on which
processes hold references to specific GTT BOs. Temporarily disable this
functionality for now while a proper code refactor and proper fix is
done.

Note that since we don't fully support IOMMU in device-isolation mode at
this time, this temporary workaround won't break anything that isn't
already broken.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 8d30ccd70800..13b80934d119 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -769,6 +769,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 			ret = kfd_mem_attach_userptr(adev, mem, &bo[i]);
 			if (ret)
 				goto unwind;
+#if 0
 #ifdef AMDKCL_AMDGPU_DMABUF_OPS
 		} else if (mem->domain == AMDGPU_GEM_DOMAIN_GTT &&
 			   mem->bo->tbo.type != ttm_bo_type_sg) {
@@ -780,6 +781,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 			ret = kfd_mem_attach_dmabuf(adev, mem, &bo[i]);
 			if (ret)
 				goto unwind;
+#endif
 #endif
 		/* Enable peer acces to VRAM BO's */
 		} else if (mem->domain == AMDGPU_GEM_DOMAIN_VRAM &&
-- 
2.25.1

