Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9087C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 21:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64DFC10E9DE;
	Mon, 15 Apr 2024 21:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w8JvjEpO";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 948BC1127FD
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 21:25:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImZ+5CfAC9ekA5VMsBQvOAibQUUyy07J/AkAFnRn3Rnd3nkFqk205h0roHZjjtJ8m0FPnbePA5t5PdhDzeDNe1wM6DhIds8CiFxFul2BcBLIfNioKFb1aWj1UMsHiOH8bpPQ9+hCB12mYDM5f09FgvMZvgXVwAD8mD4OCRU6M0V7yJf1h6KuH2NZpqqRfcE9PtljJX7xhbeyVHJov7sYoxI0UwGm1WukWGFsfzsbRZ6zUM7hG6kpAkKp0Bu+iE1XXsBplyCeXbKHZBdWoYDy/zCkqLnGBtRZbyg8+6d0tKFu3wb9k/JSLBi3QBgEmuXsD+2ysJeUeb3IIU6sMVRT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdEHqjpZ5ET8+pZ8IIm3ewq96MKpIXoiCoxz+yPGguI=;
 b=k+9NK1GjC+xT6vsCdm3FHroLCISIT+K9Xcyw5AB6OKmMUM5m1xJJxVgf9GF+Jr/b1ITtIXm/hSStQPK67DeziPXUw3LrLgMtWbrCUn8Whvm+qMZaqtH4QBKrN4zI7Uao1mErusYeUm/RmDx6TzS1hCJYkVoQOgEClG+OiMcISzqDtM/C9Mcq8G1yk98x6x44dpGSJbIiw0StAAqEDeCm90eLafTm1KF3+PLVuosq/CszYkquqVY9r95Cf6l6M1DJDAFo/wqZV9dkq3gSuTp/yWrOmkq3Vt3vcgcbPsHK6pfkG/yw+uVQTWaqFBM3wIygXGeFJkTX3txY/l9G8HRDnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdEHqjpZ5ET8+pZ8IIm3ewq96MKpIXoiCoxz+yPGguI=;
 b=w8JvjEpO4XHEssIWQqwc+B3d+a2DW5FWnuN/9KbZusQdvHzObV5oa8NIPLtDLaZVaKIEKJ1mHC+jZSW5c59XnrVj/XXufoqDD3/KiCW+GS2Nb7jFq7+vU9VwWwJ4hHOxawIqGqaQrirUVuICiOF4JUOrepoPhbIKQ3rkjHJ4LS0=
Received: from PH0PR07CA0069.namprd07.prod.outlook.com (2603:10b6:510:f::14)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 21:25:23 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::fa) by PH0PR07CA0069.outlook.office365.com
 (2603:10b6:510:f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 21:25:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 21:25:23 +0000
Received: from sonny-B650.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 16:25:23 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonjiang@amd.com>, Sonny Jiang <sonny.jiang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: IB test encode test package change for VCN5
Date: Mon, 15 Apr 2024 17:25:00 -0400
Message-ID: <20240415212500.1097164-2-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240415212500.1097164-1-sonny.jiang@amd.com>
References: <20240415212500.1097164-1-sonny.jiang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a2e451-19fc-42a0-708f-08dc5d928fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ival6y99NnPZ8GDSN9qc3lWPbEMCvmwB1LsuYAtMqym7vKKHabFajk4Fw2377XX1VUKao2wB5311ObaWYHeyP70RXVPeantLjGB5iyttd9r7+Y576RXcOl5aKuJ4KWzNkX/gH6SOxTvmZqotI1JKS4/vlmrJFmdcoIxffS2ArJmNanhB6nYrFJVIX8RReh14uXfXVJuDpjLFJN4nYh9CDcERZVJ41wYgVnOUC5prmHM4jmFU+tchqQyeJQE2TGralnOhRYb2SY3X1cKxjPL7qa1n9xKfd/w+7KTgeUBKP4IVgg8lDpF0YUSYDzAVPZyXYJ2vo75NvCsViO3JpbPqzFouWLlc0PNRdDZ10QP8yllRI7fthBIafsKiYJVrzX95GzWKMqApVS130ivJ21tA6A4SMulvEDkwjfZcXRtO8mkvnbOjQgAeit4x3BPdFrGrvQOQSXply73gRfAe8ysd40SlL77uE1oiw9wa7dgrkZ/3iIxEYipHkp6uBGonVIgbt+3KYA1Iu9Lg/poiIX70hPnBbs80eYgXpJhDKZaJW1qvQMY+JUedAeMqJ4u4RnAj/pPKd2DuiuCedkVhbAid2LW80S2cLcBC8mEnl2Jbd/WCu5a/cfNIjeKznqyo/1S0R5GU4QxIQvF5fwkRR43JJNu7zFB82Hl6x22zFJ+5ZLpHUK981Scs3MiQEgSabC7Uz1dBBu/QVuIRvKC3xk4xU4y+HbMbfgyaMstytDIqGrrStR/7owkCHnWEXhF+MwQN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 21:25:23.5800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a2e451-19fc-42a0-708f-08dc5d928fa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384
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

From: Sonny Jiang <sonjiang@amd.com>

VCN5 session info package interface changed

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 7d176046498f..e08aacacc43e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -882,7 +882,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	ib->ptr[ib->length_dw++] = handle;
 	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
 	ib->ptr[ib->length_dw++] = addr;
-	ib->ptr[ib->length_dw++] = 0x0000000b;
+	ib->ptr[ib->length_dw++] = 0x00000000;
 
 	ib->ptr[ib->length_dw++] = 0x00000014;
 	ib->ptr[ib->length_dw++] = 0x00000002; /* task info */
@@ -949,7 +949,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	ib->ptr[ib->length_dw++] = handle;
 	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
 	ib->ptr[ib->length_dw++] = addr;
-	ib->ptr[ib->length_dw++] = 0x0000000b;
+	ib->ptr[ib->length_dw++] = 0x00000000;
 
 	ib->ptr[ib->length_dw++] = 0x00000014;
 	ib->ptr[ib->length_dw++] = 0x00000002;
-- 
2.43.2

