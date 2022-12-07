Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDE8C352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 10:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 577E210E389;
	Wed,  7 Dec 2022 10:04:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8886610E381
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 10:04:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKKO+VvWuD2lhYKSQmfOlCabNANbUWghOdNRtzG0WxBbZxPRARFAPrqbPOjxAwtlgYKalBYQRrZqcsShpXmtmb2Wf9z39wBY26vzzWJp38FYY2MnEOX2aux2NYC+dexPViYMfJ3lDAQjVrAluNynamuFTcBl0/y/Ck2gT7dh61b8Z4AYSMeKSA81S4VIYVtkxSVRIgqtYSm8QAZWevIPdDYfFyJUb0iPLSKH4o2gfEWNI1FKVV+qiKwnt0QKD5WPj/FcjUcgoPzZY4yX1u6EzK8D5UYilF2gxY2qT6lJklFVQQchJhdY/p2hXiIYD11pH8lhHtRuxabtU+ECN6/XEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8LiNaAvhNjNZOcISpnz1EXPKlnQskXNWUgZQArj/2s=;
 b=JjnqsNYZnDx10wBYFWkMskbX15mrxgZSlR2qK5RYKV7RmOMvmnh+GOgaVb//ptGP29gqbHzKRnZAEJ7cDpUZA8rX9jZwsoBDArc3r1JkF0qEm+gUi/hKoqxwxSoE9Wdvt/mDQYzYcnLZtq1eK2Ap5KtYE3+nqRdfunzpTRcvEar0BAjChIeUIvtll3/3bxu56b/SMvv35saE4JZL1DPp9O8JJSqsIq2CzlC/d/4ltkGOPkPdaoaTmbQOXlxk/bcCxSCDQwm36HBYq28K/IEpepYwS9HxfRnfsasqnk5O8BpR97s61L4nw3+kOUvdypH7q1DR8pDr0cDfe1+0O7jXjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8LiNaAvhNjNZOcISpnz1EXPKlnQskXNWUgZQArj/2s=;
 b=Jag/nN1g4sIRe4QEbE8FqHIP5ODtQ0u/5RThb/Z6RU/DjZzCslK2uadF8sP3dhopefoP9n3zVxGuWDpjfyazcq7QUlUZMG2mEFB0BcD1HjjyK20QYKfUBCnqPCjOW6aTOB/zkWZs6XSqrTkD1rXzw5IiJNsnSchPu3T1dG7dN50=
Received: from DM6PR11CA0002.namprd11.prod.outlook.com (2603:10b6:5:190::15)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 10:03:58 +0000
Received: from DS1PEPF0000E62F.namprd02.prod.outlook.com
 (2603:10b6:5:190:cafe::90) by DM6PR11CA0002.outlook.office365.com
 (2603:10b6:5:190::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 10:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E62F.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Wed, 7 Dec 2022 10:03:57 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 04:03:55 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Gavin.Wan@amd.com>, <Vignesh.Chander@amd.com>,
 <david.yu@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: add VCN poison consumption handler for SRIOV
Date: Wed, 7 Dec 2022 18:03:38 +0800
Message-ID: <20221207100341.15356-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221207100341.15356-1-tao.zhou1@amd.com>
References: <20221207100341.15356-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62F:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b72d532-2d81-4069-beca-08dad83a5b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWt8qS77vd/FIEWIo31jGWIVazX5HQIIJSmEpIO/E/9cFYJRaG2TlOJOthqWgmwxSPaYg1xN6WSfAi7s68ebl4ZPQeo08ktnn7UKZ0Ja6owczIMmgk3MXIMaxzk5+DnfGp9txRPQmOwgtye3BN0AEkn9UsNavYUfcSanLb01117YCj2iP6tJ2eaGI2zGjWWa5oxEEZtJFYWf8K5do+RfipetIN594bdoZCsj/hn3CvQbDeUal3RHfO1W7hiizBrqTHV8RaaBHof+1T2fjHmd/86nGpZVacVD5r7VbNkK8Hajt8XOUJllIAKmZYby8hxbDmsUC/BKZHxJ6GXr6v7IT5IM2KAZpjxd+wXLzI3S04V1fsDc3ZWLELTVrisXxh9IR6tzAc2AFiFwoSsOaFaJrVC4WMgoLWEnF+Z92Vbfrf7llmcTOpXCegruhQWYIPUybQ5/sLBTSNcEG/JfpHaJhlctyCQIgiPeTvvWjK5sn4VRSFUMrwmwYMTnMYJy2FinpNvpg8c++Nlg/XJuTYIx6cGTEljl07opsgnbqDKnybVxRVTm+ZOoJmwxU6AcDTj/W8yJTJLOmDNK/qHwwwe4xduk7Axk4Gxv9iCf9QV8rhJO9WHKWbnaLGmRrGRxYwsf6LdVig0PApGcg3ryrOsxhCHpIHc+D7YTiPfm9zV0XwHhd+ARCX8fwNWHpXg8/HwjgtGcaNynj2FVBYWZuZ9CV5S8QBXOExOouc0sioQbLww=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(4326008)(86362001)(70586007)(8936002)(356005)(81166007)(2906002)(4744005)(70206006)(478600001)(41300700001)(8676002)(83380400001)(36860700001)(40460700003)(110136005)(6636002)(316002)(2616005)(5660300002)(82740400003)(1076003)(82310400005)(40480700001)(186003)(336012)(16526019)(47076005)(426003)(26005)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 10:03:57.7220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b72d532-2d81-4069-beca-08dad83a5b4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Inform host and let host handle consumption interrupt.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 72fa14ff862f..a23e26b272b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1246,8 +1246,16 @@ int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 	if (!ras_if)
 		return 0;
 
-	ih_data.head = *ras_if;
-	amdgpu_ras_interrupt_dispatch(adev, &ih_data);
+	if (!amdgpu_sriov_vf(adev)) {
+		ih_data.head = *ras_if;
+		amdgpu_ras_interrupt_dispatch(adev, &ih_data);
+	} else {
+		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
+			adev->virt.ops->ras_poison_handler(adev);
+		else
+			dev_warn(adev->dev,
+				"No ras_poison_handler interface in SRIOV for VCN!\n");
+	}
 
 	return 0;
 }
-- 
2.35.1

