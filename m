Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7708EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 27 May 2022 09:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EA5710EF96;
	Fri, 27 May 2022 09:46:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CD410E72E
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 May 2022 09:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJaY9E1i0L051IAvjEkQuFIkEFPwzXdkG/TmN86WFV3wrHOzZJzKpTEobflRnwUv8EcL5RdRIwKwQ4qGdbZuPfhprSKHa4bHEGAGLxlyjI3OLhElJriR8+/RoA6DRFYoOai2d7ALvrLlShxgCKquMDrKwGsE9ujpwWhM1iv5BN0Sa8Ewo0SRuCh1V9TNqXxFJidt1ZCGNCOV1QP6zysgytFiMOUVaXTRaawFPHZPpsRRRNaJ9exwNJJWxjCsQ0QAgFvsokILhRohY2lPVfmSw43ZSo1nf5r7xwWjJvE9v+Ps6W4Ll45UQNiWYRDiVv07hVtXjLBa2lGMv+0Q6n35/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgcrkiuqSx3Ef8f4LRhaWVo1FZ8a7n6UtasbcCbHHQo=;
 b=US0GK6SMFxIzf0BggKO7gHn1jut0NqonWhgotnNNqiq71VeVqeBng33a1lGHFUmg/6F/6rGPEVQrvachS/ShjAy6SkK829bA9PCk0gJdJlp0a6aRLfXtoH/F8TP1ER/O/SArfmBdvPTUJmxuB+KXj31Z9BTP+sEa8mzyZD0zrEybQbZjllhMfbexR1TnpZNyyrm2E7/3Gqw4Ej6vYVfSwJFEaFSnTtCZ9pD9JXwrg++CtfxsNNQxBEcDafcRPkAwMZOTviO4Q+EfAT9aHmFcFYxyFL857dt7DNazp5fvWJ4lXxkBiA4m7JbDK/m1lgfZGv9bsm27/I2D2Xtc+caJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgcrkiuqSx3Ef8f4LRhaWVo1FZ8a7n6UtasbcCbHHQo=;
 b=FSXrFqiU0m+XECFFEBpRzNngCaXGNgFr+sEUh/XVvmZLeWCE+a7u14yBeKcLBQr12xJzD/JRGTwLg+Gk8doYkUOaK2ybP7gECtRgTIf9Zp0pBnVR8Yw6xcUXZio8HEFhjtgw6UYOrdMbqg/skt9sxbvDQtxqHk5qz6wiZazddeg=
Received: from BN9PR03CA0461.namprd03.prod.outlook.com (2603:10b6:408:139::16)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Fri, 27 May
 2022 09:46:25 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::15) by BN9PR03CA0461.outlook.office365.com
 (2603:10b6:408:139::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Fri, 27 May 2022 09:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Fri, 27 May 2022 09:46:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 27 May
 2022 04:46:24 -0500
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24 via
 Frontend Transport; Fri, 27 May 2022 04:46:23 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: align the cg and pg settings
Date: Fri, 27 May 2022 17:46:20 +0800
Message-ID: <20220527094620.3064524-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9d380e7-a596-41b3-0b74-08da3fc5c3e2
X-MS-TrafficTypeDiagnostic: DS7PR12MB5982:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5982A0DFA7AB9CFB90D3CE398ED89@DS7PR12MB5982.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hz5exitXli2qt+FOlPcUFZTQfHNGg+feYxqodFzSUUMykvkcVq8zXZCA7H496QsbRXTwiyQPftFc0lhLW3cnuYB9XOFgjFaX5osXAdokEZTTJXz9foooPNyZ+dC69V5k8p5QiU+A8Bg4X+nCigbu/9GCW74kPefYqpYlzzb2LsPPcT/+31bWylNpMUfrQMBfQJ/EFiist7mLLKV0YsD7v5PBKS6l7qRzjB9eASLZ7cuunUuJRkr5Z3AqjPmrw4PynXSfuSQdJoKD+B1KpN+mPbmQSkw6bq3zeu4q5SzutBpNvLQOSFsPDeuTMVYjbHAhMP3M1qud4zqZZJu+lLouT2KSyAsgPOp1+MDtwkhK+pVjMEjdn1aNZi5UnYwIwY5HV/he+Jn1TPIOk301jZxhoSPsnbeDsZXptQTXcacT9fDBf8XUw/sfGos3sxxHDROfwx6xqD7BKBMDEdsohRxAm1cAKPzW5HrUO3Qa9NCLqC62pILN9xlQDVV5+ElrGytp4deF8axsv/dBg63u6gF2V+FBWgBz54LJy3dfatrCJo20u76Jlr/Or7HkphTU0nBaEeRRXy2PMCJxGgw2gB8NtB91AhJJc5tmldSojyzbSP68+Ewi0gT9F7eDQTT/dZepeuIb4EtJRUQPV6x6jfW1rcO4vgNB1LzaLBTkTKqnsbOX5YCRskyrIJ8IzHkVAMb/5Do3HqakqtBdf52OGwCJGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(26005)(1076003)(7696005)(82310400005)(8676002)(5660300002)(8936002)(40460700003)(44832011)(2906002)(36756003)(70586007)(4744005)(2616005)(70206006)(4326008)(83380400001)(508600001)(356005)(336012)(47076005)(426003)(186003)(36860700001)(86362001)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 09:46:25.3199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d380e7-a596-41b3-0b74-08da3fc5c3e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

align the cg and pg settings between gc_v11_0 and gc_v11_2

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 5566ddbfd188..26fda7a170da 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -546,12 +546,17 @@ static int soc21_common_early_init(void *handle)
 		adev->cg_flags =
 			AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_REPEATER_FGCG |
 			AMD_CG_SUPPORT_VCN_MGCG |
-			AMD_CG_SUPPORT_JPEG_MGCG;
+			AMD_CG_SUPPORT_JPEG_MGCG |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS;
 		adev->pg_flags =
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
-			AMD_PG_SUPPORT_JPEG;
+			AMD_PG_SUPPORT_JPEG |
+			AMD_PG_SUPPORT_ATHUB |
+			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x10;
 		break;
 	default:
-- 
2.25.1

