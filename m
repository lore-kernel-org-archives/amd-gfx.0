Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA040C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 06:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40A9C112495;
	Thu,  6 Jan 2022 06:17:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DECD5112496
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 06:16:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yuw2CZZVCw+FZmUuctZreq8BIo44uQsovh3L6JT2u9JL13YO0BWhtJ/YITlxM16W8YG/C2OcsNz7+VQR4ZMEEEBSequjGW1bIwhKgqSQwmyzEo3C8MerNOdf9HQXY8w7Z1RGee9zi7CXwBjHq1bPh/5++nlZvtMFvAHq+ze+uduOcJ6jqZfhzeakFmItAPXI3HpFOxe1+WYASIoIFDdTaTueWGf4B3T99YPLlwzwsgRNYz2ptueU75tUNGWLseZ1q/F5YiJgCXi5w0x2ktMToW/2ihH51IvJx88FF+livGT7ODLOrSlawZRiFjOxKCEaEPrpCcpnqrCGgR5vzpEw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZXn+Ox2v3CLIDpju4uw/Kg6w1k1Tg8afShXK2zUP98=;
 b=jeaLHOW9rSxnNvgo+vkBNmTjQULZRcQlbM7uy+K9uSXkPvbysHBPEU4T3W/zEjYWJxwceQRkuvaB550gCnxnee8nSrNd+T5IOhue21iq7y0hQv9AxwrHu1o5owPEvBS3tN5u73Bxpomf9ANhmUdxjCoYjeEtTxSddgLSQoGsqRlzPTg3Ft00QZFux8a96vggOsLjVgqrRcUC0H7Ro+SnO96vRrWZxogi4LrzAPYUhTLzkLr2n5EpA+nq26m7DyeEyh2quhvFvdFdGnfGPl7pEOldkN/UJEms3Wq4GJ4U0crOqqyEH1fwSsgzpIr64Mnj6aL35u7mrhdpJZLMe+1dyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZXn+Ox2v3CLIDpju4uw/Kg6w1k1Tg8afShXK2zUP98=;
 b=k/9DuPvCOM9J2zmBIBLNNDTu+kgSU97lJ8bLbE3R6D6cLkerQZUb1u2LP25fhy0KcFpAQ5iJ6OZPTj8vXWktd1PhI0Dit3C5m6AET6OWTdvSuBO6xmxgJZjYSPrd2JKd5bnvSoxBoHd3D8WK4EP+CdqdfC3ext69DzvMfJWA0UI=
Received: from DM6PR06CA0063.namprd06.prod.outlook.com (2603:10b6:5:54::40) by
 MN2PR12MB3837.namprd12.prod.outlook.com (2603:10b6:208:166::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 6 Jan
 2022 06:16:57 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::9d) by DM6PR06CA0063.outlook.office365.com
 (2603:10b6:5:54::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 06:16:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Thu, 6 Jan 2022 06:16:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 6 Jan
 2022 00:16:56 -0600
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 6 Jan 2022 00:16:55 -0600
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable second VCN for certain Navi2x.
Date: Thu, 6 Jan 2022 14:16:45 +0800
Message-ID: <20220106061645.14653-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca89b62e-1c37-481a-7e0c-08d9d0dc246a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3837:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB383767B13C67ACFA9A7024CEF84C9@MN2PR12MB3837.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FukuqIqy+N/c+kV7nn53AnVsYsN86888+R0SlSeJ8lUOkI4FLl+a9Y/Hp8irfNJyTluL4q8qdX5XOwDUZ1llhOzJhQ5VuTos1Nybei+3LR2qEqQ3juR1sj6X31TFJYs+Y7UFz8dmTtZmGw5YXVvPFtnjzXefAVMGHMNONBJG+mufjAOo17Yfr1CU0eMdsWRqE8NB6uZUJyb1W+/Ed+O2k6eMdrKEik8pvFInJ+XDHAj94PoCyH2URZJqU8LhWNAB+fxb2YoMVXl+3Jt0nrlNTjM2ryIPMLdAauF0sne/ctvMjV33pzG29lm2Owq0SNn3Hv5TGjmkHj7UfdWri2xYelpUmPSNb2JK1kEA8017VuX9cdfFh0Ped+9gnx40BnEs5FftX6ccIQjQpRryWfv/LM618GaDciRr4DzY2W9GbER+raEJarfWEgIViPC7ePEaP7yW9ivsCp2cJbtDiIgE6rSWaukjtwRmkyvNxSTH7/MjI6oI1jrlK2w47CahuIrAyo7ALPobUEDaK+3uEo6Bs5lQ28iErNsitpBqxDrXv9//R2aGPp/oEax5NFj2hrSDzRvZb+XawVMzPQcHZb4mOEbjf1kTDGJHGpdpEQgRzgL/C6heJHoWzB0v4+qchBxWcYs0jNuljcxpnrz2uJ0l9i5ed7rkXkRBwNDV14oscCjFYTCJ2MV1Joh7Wo+BXiCrVHSzMXsPki2JUnJl2kHxzTKFB9DQ7YEySf4A9sDmJp+dp+SfcbewQu5RsDr9pVjY6h6O1KvfAzS6MfAuY/1kp+0z+CmgsVnt1W1cQBZ+uIM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(8936002)(4744005)(70206006)(86362001)(508600001)(4326008)(1076003)(426003)(356005)(7696005)(5660300002)(83380400001)(70586007)(81166007)(40460700001)(336012)(6916009)(8676002)(316002)(186003)(6666004)(26005)(36756003)(47076005)(82310400004)(36860700001)(2906002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 06:16:57.1196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca89b62e-1c37-481a-7e0c-08d9d0dc246a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3837
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

Certain navi2x cards have 2 VCNs, enable it.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 580a5b387122..57e001d73ec9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -550,7 +550,8 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 	}
 	/* some IP discovery tables on Navy Flounder don't have this set correctly */
 	if ((adev->ip_versions[UVD_HWIP][1] == IP_VERSION(3, 0, 1)) &&
-	    (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 2)))
+	    (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 2)) &&
+	    (adev->pdev->revision != 0xFF))
 		adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN1;
 	if (vcn_harvest_count == adev->vcn.num_vcn_inst) {
 		adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
-- 
2.33.1

