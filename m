Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F1CC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 02:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B7EB10E289;
	Wed, 19 Jan 2022 02:57:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD5510E3FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 02:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz4YTWHEigP/dlGJROniNDfeySeaA67/Gif104sTPibAr3o6XUAiJFETTDD0JMY/o67zFd2F5c7bVjfo6rfChcsciFlknxbivJUBcFukL+O/xVTlwRtcqc4w2c6B6LkT1yoSCWLmnbQ4JRa7e7D/bMJd51KuR6tbUVfc2kci7aR/RVcH11XmutZ86LjKwTU9FFJn9ygYuOXFJ33Gdhc059a7Z3sd/2WH5W09ok7tjw3Pb8QNKepWQ2lPKNxhz2vK3FOgTdSlR8kjqEGUGwe4tjI5PpxdovYIYXcW9r1WchuLyG35qT+KpoFdNc0Bw1XwerwMKriQ9ewmuYEK2Gytow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmaW8z3dwXe+uJ39DAzoswaAZP44IbOf05eZrAcd8jE=;
 b=PtG50NlcPyX7na3B3CKHrWCRu9lW/132rG9H3AkWTtHu5/NsYdPWWFTCBky1Q9t+t1DP5pQe1ohmWVg12LnVKtIV9uOfWBFtWSS0GzEvGM0Jbs6Ctekq87wXrAsENb+oxvUiU3CycSaiV4G8ykHhGacMu+IxhmJ9/DkUrzLPvzYk3aEIZT9M1eUHzHg9004stia32XChXV09d3MAZsar7zL+I2hgSZETHpt+qivg+V2QH2SKYOSZgN1GKpX0Bi3/zPyH5aoydMhAzXT5clwmCUU9kjRlrFblzkcjxtbOW4nxqOJvqZVUTkwage23wEiCOqiBChfPYJvsWenWnL8/Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmaW8z3dwXe+uJ39DAzoswaAZP44IbOf05eZrAcd8jE=;
 b=TMOpVMBAvxBZzl727V9APefPUYmMs9VL8gMyOrupUm+nnOuwmbkWsAU9hjww66kNL3Yr3oI+NKWCCSRg7Dvs1y2mTnd1fTjPdWCpME5FhhFDujf9lDeHD1qFfqMNaXKxWfHn8mlTz41oNwrDEW/pnMzWEnpPl2Xfexjzp7CNQi4=
Received: from MW4PR04CA0257.namprd04.prod.outlook.com (2603:10b6:303:88::22)
 by BYAPR12MB3013.namprd12.prod.outlook.com (2603:10b6:a03:a9::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 02:56:57 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::29) by MW4PR04CA0257.outlook.office365.com
 (2603:10b6:303:88::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Wed, 19 Jan 2022 02:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 02:56:56 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 20:56:53 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: Remove redundant code in gmc v10
Date: Wed, 19 Jan 2022 10:55:55 +0800
Message-ID: <20220119025555.197467-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119025555.197467-1-YiPeng.Chai@amd.com>
References: <20220119025555.197467-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61dfa3ef-dd16-430f-a743-08d9daf75b13
X-MS-TrafficTypeDiagnostic: BYAPR12MB3013:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3013A9784A5D66D3C9098E32FC599@BYAPR12MB3013.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQQTK8dTEDCYHTW2YWnyNPnXYg/6DCSdp9E2+/1fQSEFTVIsakOkm2fBDpvNcdY3tNQrTX7rRamvPoaEQ72ewajGgFPafWAP6f6cOqJ8UkmPPpLqbpUsuxJPsYeKNqIgNPlGDNw84n2/rbazUC7x/mt5DLWqTCVWcYylCFb4LDT3miwgXN3VdUhvDSYfnQ85Z802A2wZelSGVTnKdTeNsXLO+Ogrusi+xE6BGJ5rFIYh22LqB3/nwgsM/PmYSFFv+aeyPkReMgMMus6I3j2oXD2Gzi6RXVTHDM9sipwF28l1drNx3G/oolVR16aLmLe39NKl4VtlqRu6jL+pnwIpDBenPVGJtpoV9uqgqQ6cpF30qaWjx+YRlp6R9zfOYJy0nP3n4Otqv7uUkj4gmP2+cmioYtYsKvZmPvHULYFRzRLEGUUDKT9n4wzy6H26Qi1Zqyhr7F108ZsoT92Bl/5fLYBa6AwLCQtYpEBmm1EoaJF+M8x2F0ufGxZvBDZ+BYTWCsySwzf1MIzOGx+h+8970mya5DHj80gykFTObwRTGPKj66xa4SMEBWmhIbwVZX6xsnNaO+DZ/MMsh8sGA5H1XVMz9wfjIImUjGBMWgiODi/psIIwjRpFv4mlO2u8dZpFMXxBe+xC8hdxUgeufJ15/rQIDmMjrQooi/SzDHyxn5j9/QucduN2OglUkPsIySx3vh8cZhnmBwft3scEi+cGh6yZjwHhkUAwhmj+QnYSV5wrKMF6SdNud375LRZlAG8lfCy5XGLZ4D32crT++jEfBhCs7/h0k++VIBIGvuVMiDnV4nYS+RmXLNgcHR72wEH6lF5turWf1CJHXStMJy6uNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(40460700001)(36756003)(426003)(47076005)(5660300002)(8676002)(186003)(26005)(356005)(2906002)(508600001)(7696005)(1076003)(83380400001)(54906003)(8936002)(36860700001)(82310400004)(6916009)(4326008)(81166007)(70586007)(2616005)(70206006)(336012)(16526019)(86362001)(316002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 02:56:56.7709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dfa3ef-dd16-430f-a743-08d9daf75b13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3013
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Gmc v10 doesn't support ras function, remove redundant code in it.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 5f9f82091000..a833ef130495 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -664,25 +664,10 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.umc_inst_num = UMC_V8_7_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V8_7_PER_CHANNEL_OFFSET_SIENNA;
 		adev->umc.channel_idx_tbl = &umc_v8_7_channel_idx_tbl[0][0];
-		adev->umc.ras = &umc_v8_7_ras;
 		break;
 	default:
 		break;
 	}
-	if (adev->umc.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
-
-		strcpy(adev->umc.ras->ras_block.name, "umc");
-		adev->umc.ras->ras_block.block = AMDGPU_RAS_BLOCK__UMC;
-
-		/* If don't define special ras_late_init function, use default ras_late_init */
-		if (!adev->umc.ras->ras_block.ras_late_init)
-				adev->umc.ras->ras_block.ras_late_init = amdgpu_umc_ras_late_init;
-
-		/* If don't define special ras_fini function, use default ras_fini */
-		if (!adev->umc.ras->ras_block.ras_fini)
-				adev->umc.ras->ras_block.ras_fini = amdgpu_umc_ras_fini;
-	}
 }
 
 
@@ -745,10 +730,6 @@ static int gmc_v10_0_late_init(void *handle)
 	if (r)
 		return r;
 
-	r = amdgpu_gmc_ras_late_init(adev);
-	if (r)
-		return r;
-
 	return amdgpu_irq_get(adev, &adev->gmc.vm_fault, 0);
 }
 
-- 
2.25.1

