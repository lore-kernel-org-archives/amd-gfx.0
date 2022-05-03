Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EBAC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF14F10F011;
	Tue,  3 May 2022 20:29:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A88C10ED52
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XftEhIBgqYLhfGxgXQV6mmN7az5fhgtxt9fMOTt+WZQBPKbRj1nH4/CpG5M9A2bkZG9RqZ53t3QcPsIOm+609z7BnrTvYFJNS36BOpJT49osCGOeD4Xb0kHmzzmF4PXwjuYawc8M2sz3oKeOweg9vC34sIBh24AXG3selwQI4twALDVEUAPFQVkBEbb7k1zXSjteSnV64/eSnMHJIaggVWvj9G+o6TzzP1KPMeKGkGhfUmZXR3F4foihRm6zJRnt+yfU/8DbqIOTvJlThDUXcon2bza1EalbkDlm8/h2gcr7NmS3Chsllyq6rGXeIMjhpOxRWpCdRKEpgcof1Henxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpJOAKpN5EPoYltk0JnaKEMZD3mzl1LrP6WFgneckmA=;
 b=IVMgmbuDa+89D5GYyyQNYTCXxZEX6aqjBMlHR5q8YrX+jMeAi8kITXDI3jBw4X/U3DglUN2gkGBaRFg3euCElahcMYJ7fEBwcgPMjF3Do7K/Zsv5VN0fyzDCXmW3fcJaVWszEDIDjYqMy9msgvBkz5mjalvY5+idwwUCzCGo69x5GT1eyWph3hZ8W8S9oVw0Aqwmxq1783BGT1/pDgQ7Fep9ErmrV7iq6yevI12kKxT48lO+cpfB2DeE6FZW2Liursfsb4O6r5pWtvZVsx3Nn4RrQQ+ZEayuKtPklrpSvoMjsjvP2P3HPALVZg8bSvx/91MOYjUgCK2PK2Vt5tSz7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpJOAKpN5EPoYltk0JnaKEMZD3mzl1LrP6WFgneckmA=;
 b=oeCRyTWLBB1Xt7pQFzVHXH7NyDNJSPcLhlPxKIKOnbkylU8+MQv+GH3GgoJ1WZXm6Y+XuJwCvDtN1mOrp3Zlf3BRCdORx5egNnyFbhYXxXYHE4n9IQE4E12gfZ7y3Pj5aTwiF6EhXUDzNcWPdgy5+I9vU/vb+WJpMvfC6SaR8JI=
Received: from DM6PR13CA0028.namprd13.prod.outlook.com (2603:10b6:5:bc::41) by
 BN6PR12MB1842.namprd12.prod.outlook.com (2603:10b6:404:fb::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Tue, 3 May 2022 20:29:27 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::cb) by DM6PR13CA0028.outlook.office365.com
 (2603:10b6:5:bc::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.8 via Frontend
 Transport; Tue, 3 May 2022 20:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add gmc11 support for GC 11.0.2
Date: Tue, 3 May 2022 16:28:50 -0400
Message-ID: <20220503202912.1211009-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 103f2058-3e55-42b7-b6bb-08da2d439e3d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1842:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB18424C3AD8A10358C1B4702FF7C09@BN6PR12MB1842.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t85CEJDw2kFfzNkn/EcY9i7xs5jmE/RtudIsj6YRoufDp+nj2F5gE50iPGGmf3s7u9+QKJlDfFHKnCnLgyVk49xhmoddOovSAPc1b25fOFmZr8CHHIATzJt3iUFv80SjhsKtV+XiQ69Q50+atQKp4MQm+iMI5eQrKMA8PzpuTzkOfF/DSSPq3XFutZkBvhMPZKay+jTXHA2/G3GKg41+GNwFu2LYzEJKK4tXFXW/ZUtaffPp2r1uUYjrF0bvOlhwzsBn2kf1twW6vGffvmJVZMgCMW74Lyh1TNNGbuZbpc5LxnOydJx1b4rXzD2eY23aXmLIt3wYoC14PPdZZXO5AC8jxVtGBtwMW0NM5iCrJCaehICRDjaGicVzAJvyWgs2b+nh5qdmVnLPOfpOvdHPk0GqCQyKZI+lNz72L/iXPv0zV7BUoVnHB5kBbGZAjxz464zYhaHguQbKN6eQH8hLKoOWTGDrAm5qUiIDE1PbuRrmK09ZSAw21GeKzfZhKEDoCVTI2kWXlh6aTtXAszjbcuAn7EmB6L9FpzlIKfI83chySTYhcTuKPGw4PQsyGzrsBPxaky/gvOfKyp+sl6SLQokCnxpJcniozet4MkHQJUt35yc6FQpjFQaQ4whk3cAgwRcJINR89wsgId/3TKKLQTJlLmjhGaD6DLXXfx4LZTxXXNu9RixpiF6msQM7hE/MFITuV4gTOy0V+nPibL9CAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70206006)(81166007)(40460700003)(47076005)(336012)(426003)(82310400005)(8676002)(4326008)(83380400001)(70586007)(186003)(6916009)(2616005)(36860700001)(16526019)(316002)(1076003)(54906003)(86362001)(26005)(2906002)(36756003)(6666004)(356005)(5660300002)(4744005)(7696005)(508600001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:26.6312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 103f2058-3e55-42b7-b6bb-08da2d439e3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1842
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Flora Cui <flora.cui@amd.com>

Enable gmc11 support.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 02583b34b996..6771eb798de8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1521,6 +1521,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		break;
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
 		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
 		break;
 	default:
-- 
2.35.1

