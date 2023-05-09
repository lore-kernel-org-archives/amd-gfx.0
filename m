Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D137C7EE26
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9164110E404;
	Tue,  9 May 2023 22:10:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5D8510E404
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1cTE6im5ZdGGEhsiUnkUKeaFGAqTJhLMVAWtrx3cCc16rIFdvaafiSiJtNT5E2oC7L3CUYcqitlmBH4vsv0RbW9248uxTQ64PsxNQ7/46hAwgBW+Q7YaA3B4jOWPemLU87mFKUN3eo+P1JJMHdn6a7ssSYyifn0070O/JLj+Y+bIRwxYwdRFwEj4vOgaGbx4yCMW0oRmnrK/ca49/LV13KP4718TdZ4++3jFyNe7Qf+mHyAilcBB4L05NhRM+ckF65bp9sfm51KpLFvAn6XAKB0zlcSi6s1Xn06dPkmkM7cJyCAQftDOPyiWvWsBmIXwrxGjKyKJmYtL/BJAfmtiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RcuLi91Zfz0sqXdAW7S9RovLHBEUAgkB2JonlFYbKQ=;
 b=Na7M1bWAF4TjddBcqCnfrbqKSVJ0kG2rRKu+OTMJDEDEL/Lixn9WRo92ucidEJmeum0H9ujZbdJE0cqjhbIxLQ+SIXon50xR3d072F/017SHpGGpzLKLHNZmJCJkrC3I7iDVXZXrlVFsWd5S+eFubgAmXCh6mxCPrr3ZjpQcFkKdX5WdRqRYQGaG6LRw5mdCxKk9y1u4sf1H2GHSfFYduboahpgHSwc3mh6r0frnzcDsv/9dt24+vJSmrbfAhK2PY7HTgyLNDLN01xmWY3I548YfleQDE63LNU/1OXsjiKNYSmQ/avLWIhcmsBaTC2K/3ivt7BcHeHTQD3c5hzTZMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RcuLi91Zfz0sqXdAW7S9RovLHBEUAgkB2JonlFYbKQ=;
 b=rWk0eAjbrmsGWBDJpyCPpo7Y9Ho7mfRHqplw08dSSxMOVj4i7yOUy9PswF4dp8U+CpG0ZQCxK7PxNDOqyzDXuT4W5FBLM8R05IkECUfYXO64tQJ8fyWsujHmYMxdKmeOrqCsrIHdN/9YaaeOjqddyIbtRnJimso37SPcgDH7b2g=
Received: from BN1PR10CA0029.namprd10.prod.outlook.com (2603:10b6:408:e0::34)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Tue, 9 May
 2023 22:10:19 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::ab) by BN1PR10CA0029.outlook.office365.com
 (2603:10b6:408:e0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:10:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:10:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amdkfd: Flush TLB after unmapping for GFX v9.4.3
Date: Tue, 9 May 2023 18:10:01 -0400
Message-ID: <20230509221003.475858-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221003.475858-1-alexander.deucher@amd.com>
References: <20230509221003.475858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT033:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f387f0-f58a-428f-33c1-08db50da2d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SiP5hzvClMGE5rgrcACEUCgNEEA6jPL/M5cMlODsc85wNKdWUoE+Bz/Nt6MqTpvNHMHQuxrp7PTRAoG7FSNL3ILlnXNIBXxDJRt1uNZJqLZBaKQn0KycB7Z3TnLdra/V+94t4hEPrNwvNbJsnZ+Mo6OpucvxJiuL+hGqrV74G6pV3sCUoKpXh4qoppO8bnX7/RVYdpjfndnImQQxVI2zv/3oOQhgyE0myxAYu4mdOaTxNQqVTt8JSCRXWfIFeLz5cTwq4CtiXQNlRO9Lf3FEOb0O5elV4HrRMHOKTus8mBW9qGFqcSrW+hSCZRynx7tW7roiPZvhlI1O2AVUlXaQDf0RYNsaZ6/9ZEewI8G4GHugJGx9w47PGSuLE/Qhv0CpYaiWonL+mkgB46mN8KFoBqDzAzoZguDh8N7CILdRRIgIiq2/l+cbtjWmSFosDZzf+KWajfphQYmFUQUMrw+WlGYGZZPprEuGVv08VJbH5Z70ZV9mlkikTe9T3tl1/llf0x859qVXuv4hnBRVmCxzjHWkU7dxsgvUWu+B/J1G6LYS52H6VqV8NR9GlWxxCTA8xP955p0K6aX6j428meZ53Crnjx+ISZ2MmMG91Qe2Moxn600OCBJU/RVNKQroZ0HwJQC9243l7eb1CP85AxZXVWJRO1fv2UlQmH9Yl5UdzfN6h+cJOgDbtoHxIJdBn4+WqljBrjItrYDe029KI0PCD1LuGg+/Ut5xV0Ezu55mab0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(316002)(47076005)(356005)(478600001)(82740400003)(81166007)(8676002)(2906002)(54906003)(426003)(41300700001)(336012)(7696005)(82310400005)(6666004)(86362001)(5660300002)(36860700001)(83380400001)(70206006)(4326008)(6916009)(70586007)(8936002)(2616005)(26005)(36756003)(1076003)(186003)(40460700003)(16526019)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:10:19.3184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f387f0-f58a-428f-33c1-08db50da2d24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

kfd_flush_tlb_after_unmap should return true for GFX v9.4.3, to do TLB
heavyweight flush after unmapping from GPU to guarantee that the GPU
will not access pages after they have been unmapped. This also helps
improve the mapping to GPU performance.

Without this, KFD accidently flush TLB after mapping to GPU because the
vm update sequence number is increased by previous unmapping.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index fb3cf2c51da8..6e1c15682c28 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1405,9 +1405,9 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
 
 static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
 {
-	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
-	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
-	       dev->adev->sdma.instance[0].fw_version >= 18) ||
+	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
+	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) && dev->sdma_fw_version >= 18) ||
 	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
 }
 
-- 
2.40.1

