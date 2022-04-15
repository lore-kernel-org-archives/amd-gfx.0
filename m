Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24487C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Apr 2022 08:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E93410EAA8;
	Fri, 15 Apr 2022 08:04:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DBEB10E929
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 08:04:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxfGAG6L8A5qJAntDsEV5iUdhxTM36VpX8Ss2HAGuprzULlkW0Lz+kzOgQVUAUzhvJrjlJ8jvQNUEhbwbaPeB2Pb/vNSpe5tcmOB+uFjOMDiSEWcUMViG+Rrc54mWhbtjL9Wck78AYOmCopPLLJrLKQTWVLdhH5FeJXmU8zKdAiJb6wnPrZ20OHSKXIeiIdAD8vQblzdE4ZRlnEKb1BugJqflwXPVG9wx6wy++B1Wf8+qOgftfVoNrHqxYRqUZJQUkjjs5DM+blubmBZDFV5HyiU6reLc3hOV7ZWf9PyXXwINVCVH55f4GAavIh26vvASs6W6aJMQ/YmDdfp69GeHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwhJdiCRozjBCztJLrnIjcRKbRjAsEwSn8RuO4jDXww=;
 b=hP4Yj0V1xusJVPVugK3zTZVjpEFiDf6/ryozmJPXMObjA46dWGVKCfkDc/meg3rxrhxIVSa43iDcLjdRPpNP4wCgbr6mPj4FlrJxAkBa3PwBmjVt3GVWlEs8/1EkGjHzOuoemU8aU+0uwxANBja+hS9so5k3OZViIqcdqtnufKuhFsIFpH9cJ1f92o6qFW51e0rWtpeDUcuhm1ptpO+XjwBqr9/7bMj1a8IawSyc/7ioAaxVrRxwh6H+TCZjkiEUg74oa+S2AqgMBocrcLlHuNMYumyp/Eh8TE6gd3pKdyTdL6uX/O0cUHEHNyuvs3lYcqRO9oCVTjMYFxN5egw49g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwhJdiCRozjBCztJLrnIjcRKbRjAsEwSn8RuO4jDXww=;
 b=lXLWMroOfD39dtPsyGPP3HUx8ZuBludiji8iZxM4faBT+l7uOI6BTB65JuA2cHw0Cl7UXkE5M46AZa3rmFb5bro9j+B9SBEC9w8ZlmEyy3IUhb2fI6laoIDYc/mI4gtDBPIAwG35j+pB9WgSm1P5oth6u4KenP58mObF+fgQ3fA=
Received: from DM6PR07CA0101.namprd07.prod.outlook.com (2603:10b6:5:337::34)
 by BN8PR12MB3283.namprd12.prod.outlook.com (2603:10b6:408:9f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 08:04:32 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::70) by DM6PR07CA0101.outlook.office365.com
 (2603:10b6:5:337::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.21 via Frontend
 Transport; Fri, 15 Apr 2022 08:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Fri, 15 Apr 2022 08:04:30 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 15 Apr
 2022 03:04:28 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: only allow heavy-weight TLB flush on some
 ASICs for SVM too
Date: Fri, 15 Apr 2022 16:04:12 +0800
Message-ID: <20220415080412.844980-2-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415080412.844980-1-Lang.Yu@amd.com>
References: <20220415080412.844980-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03f6e4ca-7dc5-488a-308d-08da1eb691ea
X-MS-TrafficTypeDiagnostic: BN8PR12MB3283:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3283D1DE3375BE47C82FEF24FBEE9@BN8PR12MB3283.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fUaLnKV3NQc86EOutEIzkvx1TSySI1qVAn1wtcsUNnuckTDGwYYJ+xiQbV0LUkWlsxzuAaqyEDigfTvNmq1YatOo7XPI5c5e4nkSsMN788fb9W5/y7qpenSZNSc3wQXVt9NaPUPtXXFt2zMQuMU+xVUIsTnBuS1Bf7UtDmhMnfd6GdJxJOoiszb5abL5OYqGfclpysF2bpBt7E46kT/PCOrtM33cJ+3u2W50Sgx1jiMdsv3HcVHi5fotPzlUdJMv2CFcvDYP6lgnT6ZnQmDOFsCJXJDS7WzvK9lEgf0SnsQLvZgX09lBshmFTJpaqzceqP4fJ/dYJXPBc33d8F7KcQMsqv1Ms+D9pNbckmSLBjetB36sCWLjwkeWTsX7VFM08RyFqu6Rt8IeD44FP2i8r+X/k7J51uqQ0VD/fW2Dh08QULIL+D79MMV7Oh33lfzqJOUBAKFF/wvimPBH2y7yNxWtVfyZSy7R/LLUNxuY1MTe7aO665U71Y+sCp3MPeKBwV8uVciIuV0f/IdzlAs5wZqfCjhypZyEw9qYx8/gJFEPI6saSHbgKabcjc5ortIdtKfTAGBKmQJdUSsOnLzruxccUtoWsJgYKgDGU933P0wXCKI1agN15XPbUGASphkwaIoQH/iE0nKADTYb2MsNHCzyJrmbHIW9LkL94a/9J4VTEU5c4wff5UBMCqIpGLJAvBUG2M1epU8rUgYv+2vgpXm9I/9IwEE+genEFx7EN20qWUIt95gMWIgZ+5iuKBGb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(356005)(81166007)(83380400001)(36860700001)(40460700003)(36756003)(70206006)(70586007)(82310400005)(4326008)(6916009)(8676002)(47076005)(54906003)(5660300002)(2906002)(8936002)(26005)(316002)(6666004)(2616005)(508600001)(186003)(426003)(1076003)(7696005)(336012)(16526019)(16393002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 08:04:30.6178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f6e4ca-7dc5-488a-308d-08da1eb691ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3283
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
Cc: Eric Huang <jinhuieric.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang
 Rui <ray.huang@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The idea is from commit a50fe7078035 ("drm/amdkfd: Only apply heavy-weight
TLB flush on Aldebaran") and commit f61c40c0757a ("drm/amdkfd: enable
heavy-weight TLB flush on Arcturus").

At the moment, heavy-weight TLB could cause problems on ASICs except
Aldebaran and Arcturus.

A simple hipMallocManaged/hipFree program could trigger this issue.

[   97.787657] amdgpu 0000:01:00.0: amdgpu: wait for kiq fence error: 0.
[  106.868758] amdgpu: qcm fence wait loop timeout expired
[  106.868966] amdgpu: The cp might be in an unrecoverable state due to an unsuccessful queues preemption
[  106.869203] amdgpu: Failed to evict process queues
[  106.869261] amdgpu: Failed to quiesce KFD

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 459fa07a3bcc..5afe216cf099 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1229,7 +1229,9 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			if (r)
 				break;
 		}
-		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
+
+		if (kfd_flush_tlb_after_unmap(pdd->dev))
+			kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
 	}
 
 	return r;
-- 
2.25.1

