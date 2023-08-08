Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FB6C001DB
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 16:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F1510E3B7;
	Tue,  8 Aug 2023 16:27:16 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72DF310E3B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 16:27:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsQNOITVKnM7sGunKybdBcAdAm4kQsTwuuPgINpUuwantnSA63/ZsrD/f3ZuACQ+HzXpES0X7DhN8z60IDrKzAaY0WjGgKTzUGcmKSB3EbICs5x5mhPvfy5u89hn01x1GBCbPfMSPrin9O57Ze6ojPvRk+doeGlM0uLU5lGCsPOjv8jjeiG974371wOggQx7v7tpeNeafUgXDS/J6I336Cbj5iUYuCQeq9/0QhOx4F6nozthv2bEEy1fqLjx3H7wXkuSh42guk763bm9P8oxvfczhCKHMKthgjjv2dqf1Tdn4E0AacyHHNKlBDR8GQuTmj5NpU+ireBeTVEEWIdhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mxk8joNoi+AjOiSqmyXfuq/FfyqBLcwTvtX03DgCEUA=;
 b=R8wAqI8O2Cq5Pv02hgvksHCRr90d7UWaj88tb5rWXC20ORQxYvC4LMo9NamYNI0cRspHZHgNAvQolYjHZly7NYXnDXo15++7tFu6UX712UvX5R5Ofwj3ufc29UCCMZFgyw6OSaWBzmGd7p19XtYt8O2xPo1m9DGV3zPv5X94UKIHaJqr5EQPShxeS5h5sT4QKDbVfsNnmlOxk+oO9FblbQasM/C6EaZt9q4krDHQcNZcIglFf70rkKuDr18BEh1iwHNUlrg42NuKhzodlMUV559+rrHXpU3/iawjV/+tEFnIUpKJuvrRCl1ZE0+wSdMx+hMWTP97yZnEdwEqXEMnwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mxk8joNoi+AjOiSqmyXfuq/FfyqBLcwTvtX03DgCEUA=;
 b=RkwjaAtwriWjRYdyiHwotmJLJfXDxZEt0T2L4uVMSufwR+EqLCIMuRfT35YEqsbXig25RzLnb8vtuTfj90sy+CGSVa/fdSmxuHe5k64l4at9pXAyGcgUjkgzczsvDr8e5763HarL3R+PpP8wIXFiUkC38UbfEcpm69+K+B1SRpc=
Received: from SA9PR13CA0116.namprd13.prod.outlook.com (2603:10b6:806:24::31)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 16:27:09 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::65) by SA9PR13CA0116.outlook.office365.com
 (2603:10b6:806:24::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.17 via Frontend
 Transport; Tue, 8 Aug 2023 16:27:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 16:27:09 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 11:27:08 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 7/7] drm/amdgpu/vcn: change end doorbell index for
 vcn_v4_0_3
Date: Tue, 8 Aug 2023 12:26:22 -0400
Message-ID: <20230808162622.74937-7-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808162622.74937-1-samir.dhume@amd.com>
References: <20230808162622.74937-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: aceb275f-c859-4b62-3a4f-08db982c5065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qt/6gOpupJJ1Vu1HYAIFOnicjJ0XpAJBs4dI1095jdN5Uhgu20AQod4orafC2f4BXwMe+hacVirP/0rbg7JK6nkgPqIOrjnch6hQe/i9o01dsRSgQ5UrOOGSkXjBBjZW8JDj3pBSRCKkuhvsjnzrD2juK2kaCYpau7qFnT6NDuN87Fl2CSFJnbBiJZFeHipv+oNlx2L3xdjz8iDRvTaJg8ZQ7RmCHQkP/4LtrRCVphiPelrPRVqjAYzmCw9H3LNFz7AeVoF0NWNHmwGFjXWl7rUyeb3t+GikmFlUW+pepPiBuPomTkLAgjebywHrE4zFbFi2l4Kih24fdXsm+WHBBnBBguRORI3e0VBKZdU0VTMiVEoGNvyBTPJmhQ6+ogJ98Fq2AcPwqDpJUP9zreN7MqbbozbwUGuUo5oBAmXMRpr/dkl+bvrluKzeEWJXmf7KSczprALGRzRtwSAC3u0bw57EMiMbKzhHL6WZLkKKtlwUVMfrZ1DQEVLqi9SArkGB7HQNin12xEBGx1uWn78h/3oo6d13ZiXWvnyxcgRfKYE5UqEj9H2rzaAoVjEt3faSfLwjH+Qdyri8ihT6Y3TeeTcLz1Sro9IDCKcQrjwU7af1xac/evvLk471/4El9uANvMvfBrMePO1vIfUF/vil9Rz5nrRGu/z2D3+QP2UswWdUJypRUeFNKUZKNs/0jE2ZN1l51PaiJPJWMzb6Bh8K5tuAUTP4EPWSdPOnZ/s809BenVmC4pnpddOZyvwlkT1sbzSXBKQARBLbEee4Heo4mQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(82310400008)(186006)(1800799003)(46966006)(36840700001)(40470700004)(44832011)(8676002)(8936002)(5660300002)(4326008)(41300700001)(426003)(316002)(47076005)(83380400001)(40480700001)(86362001)(40460700003)(36860700001)(2906002)(6916009)(336012)(6666004)(7696005)(2616005)(1076003)(26005)(36756003)(16526019)(70586007)(70206006)(356005)(81166007)(478600001)(82740400003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 16:27:09.7070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aceb275f-c859-4b62-3a4f-08db982c5065
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
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
Cc: zhigang.luo@amd.com, guchun.chen@amd.com, gavin.wan@amd.com,
 lijo.lazar@amd.com, emily.deng@amd.com, frank.min@amd.com,
 alexander.deucher@amd.com, Samir
 Dhume <samir.dhume@amd.com>, leo.liu@amd.com, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For sriov, doorbell index for vcn0 for AID needs to be on
32 byte boundary so we need to move the vcn end doorbell

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index f637574644c0..4a279960cd21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -330,14 +330,14 @@ typedef enum _AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1 {
 	AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_END		= 0x19F,
 	/* IH: 0x1A0 ~ 0x1AF */
 	AMDGPU_DOORBELL_LAYOUT1_IH                      = 0x1A0,
-	/* VCN: 0x1B0 ~ 0x1D4 */
+	/* VCN: 0x1B0 ~ 0x1E8 */
 	AMDGPU_DOORBELL_LAYOUT1_VCN_START               = 0x1B0,
-	AMDGPU_DOORBELL_LAYOUT1_VCN_END                 = 0x1D4,
+	AMDGPU_DOORBELL_LAYOUT1_VCN_END                 = 0x1E8,
 
 	AMDGPU_DOORBELL_LAYOUT1_FIRST_NON_CP		= AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_START,
 	AMDGPU_DOORBELL_LAYOUT1_LAST_NON_CP		= AMDGPU_DOORBELL_LAYOUT1_VCN_END,
 
-	AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT          = 0x1D4,
+	AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT          = 0x1E8,
 	AMDGPU_DOORBELL_LAYOUT1_INVALID                 = 0xFFFF
 } AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1;
 
-- 
2.34.1

