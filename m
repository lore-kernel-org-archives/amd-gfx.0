Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46353C38A2D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 03:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3315D10E0F8;
	Wed, 26 Oct 2022 03:14:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A8C610E0F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 03:14:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvmRje5fEiROByspvW36W9v/FvN3rT78+YGp96Sm98EklXciMdM17vqjbMDekBwdPDB+OSN5mMv/LQTAk0KzmfLxuwYMkTPDmjqpeFSFSjbZ2g/YxEoSIfSxIOQwxg5Uu8QVdnGibg+atWiUYnDfy+PzzwAhdyakr0t0hBY0wANIYQYz4TUNQ4vZX3grwLZv5xH8eafhOeWGUCZG7QAihC5Dnj9Evm4pj+gTCFIS7HbalJNZC9uWyVd2NbvAAkdWfBCtkTMLk0jEB7KiMkAZLYrIhaIIGA2okHpN63LJLxonqbtU8suJNS4CD3IQ4o/nUa9KIQ9yURVaCpoWT4DrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFLO9lfcHgrKnMNJaLa8/M7KQdtc2gl5shpMPIC39OU=;
 b=ndXMJXiWOiowZZ2JPoaM6/fP/jMhIlKlia3Oynz2a3zsrS1PoO4fEjCJJLRUTLE2q944fvf+Rlmezn2Chb7d++t+JHJbQ8aSZnsagzTi9aZGwjdjcLupmJLiuEOwrYZ/wdFYCLzPwpoDeI/desu+PEaOd0xa/mJ9QQNLSCFAk0sTro6g1FoUzwZIT8eTEyM62Tb6KGIBCgpUPwC4fbg1JWLt1d5qbnyMwE0g3rgly4N46cdQ+ylLElGcBVoGqrTaqGTNZq3NWBH9wnPlfJC+Sm2X9QNKt+wrHafHLhclBxwDoQ72Rc0kKt9HqOPxdbUvIVJXbnjk5siOMlhg+z8aLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFLO9lfcHgrKnMNJaLa8/M7KQdtc2gl5shpMPIC39OU=;
 b=TS53h0sCKMtiNrh3nfWYNvF2gYV0Vj6mWRRh50sF2DAf0fILoLf9whtbaCLmHhKIDzGcSTSKv4zXp4jljOmhEZmqLpazgMdfoofVqt1EJuVKNMF6fI/vhzEt7UUmw/d/xhiGIpd2YG50YgBDBobbJI4RqJ5ttkGWO08wBMZBKRc=
Received: from BN7PR06CA0058.namprd06.prod.outlook.com (2603:10b6:408:34::35)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 26 Oct
 2022 03:14:49 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::35) by BN7PR06CA0058.outlook.office365.com
 (2603:10b6:408:34::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Wed, 26 Oct 2022 03:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 26 Oct 2022 03:14:49 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 22:14:14 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: force read discovery file if set discovery=2
Date: Wed, 26 Oct 2022 11:13:54 +0800
Message-ID: <20221026031354.3230715-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f06e01-13ca-4e58-7793-08dab7003e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bfCI0yx9Su5uX+A4NCrfHn/zayFxU/Cvi9Wl6RiF6vIcOtA4nzt005Mj6i8+g+eUzRcka9EY7lvgzTSQoQlOhBPEzDTQBkHUzSSxF5tBVla2ElW/UgcNGWgPJV+TKgRL7jKqMmZOX1ZFwshsMZvWC3MQKrNSjj9XZ/qJoUTo8aWpL8UWuT9WReGPQYbL7rAzYekUl6notCGzwGgf7l1+Trz4jlOKKWo2jbHphGNuyXTFCFJwoJBc4m62+eUWElq4XGgnkoOdIoqT5YHLj1d6qZ2eK1S45pDRgaxonRw4GkW8Qp99SHLCQMkQGveiO3+owcPCwCBobh8AdrkPXN7PMjQAMGQjBPari2Cso02o62YJ1kHQva8pzR/6ADISpfWOeqCbnwb3tcnXyuwziBzzib+Bljh/pIODB3u2kUxjJxhztDZWKYxzBkVRlv69pRwrhyPpa/2dNA7EQo+rHkejvXerDSE2dwDLQhv63ukjEcpP5pO8yyV2MylQAwbPDfBCI+iwoVyOe8Wa4uqWd6v2Yk+nu7uJCD2iC0CJwr2Mae0Ex+Ae2pIF47wQE2PKI2N+WcrMxQ/3guXo4A50hdZrW5bFVBAczhx2QxcfJGwKE6UN+aKRCdc5w635KW4FLf/HDw1scweaEE0VjM9C/n1Oz+9Ki9vqQsqmO9+kIz1LbDTn/2W1oeHtipD4GvAw2KZtiNOr8l59WcQWva/+jFUPqC2qp9bhwr9RhRtNmVml9WjuVRTz7l5Ra4m0oyFjTxgskylsqx/FhouV17Q1BLzx/KfWyU3mzVM44n3FfNeT2wUcBj+P7enbwJ5xqtgDMS6t
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(7696005)(6666004)(36756003)(82310400005)(316002)(26005)(40460700003)(478600001)(336012)(40480700001)(426003)(47076005)(86362001)(8936002)(83380400001)(2906002)(2616005)(54906003)(1076003)(36860700001)(6916009)(70586007)(41300700001)(356005)(16526019)(5660300002)(82740400003)(4326008)(70206006)(186003)(81166007)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 03:14:49.5092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f06e01-13ca-4e58-7793-08dab7003e11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Aaron.Liu@amd.com,
 Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If discovery is set to 2 in module parameters explicitly, the
intention is to use the discovery file in FW rather than the one in
BIOS, usually because the latter is incorrect. This patch to force
read discovery file if set discovery=2.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 3993e6134914..5ea9afaaf4f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -305,8 +305,13 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		goto out;
 	}
 
-	if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
-		dev_warn(adev->dev, "get invalid ip discovery binary signature from vram\n");
+	if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin) || amdgpu_discovery == 2) {
+		/* ignore the discovery binary from vram if discovery=2 in kernel module parameter */
+		if (amdgpu_discovery == 2)
+			dev_info(adev->dev,"force read ip discovery binary from file");
+		else
+			dev_warn(adev->dev, "get invalid ip discovery binary signature from vram\n");
+
 		/* retry read ip discovery binary from file */
 		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin);
 		if (r) {
-- 
2.37.3

