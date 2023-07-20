Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF376EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 19:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53FA510E119;
	Thu, 20 Jul 2023 19:20:39 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F5F110E119
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 19:20:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKyEHlAf4XVdYVGsPAgPGPf9SR9tbIJLnxdV/Ml54rALWo5DyiU4xZFM/pQhLoLxOqvp30Gtrm8RGf+cerZiixiHDnvbo+UKL0Zcry9790xkds8cZtDpda8G5vM2QgL4nWaWJcqFo8HCXimNUyiixRJ5jKdZVh5T3L+JBUHLGxK/Q43FECK/3VK8Mkd3f4OP+riqZj4kKdREj/StHYAS2fmCLKghQpvVEcGSbZBLpBu7nKSTs5nFCIFeIASjqexqU+AYJGlMZojtY7wt2UzBsTbAAg1zUpUVRZKjIh3LGCxoxzqXKkzhSKpbtJxhaD1PSt0F2GahUcPBtWR36Puxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mxk8joNoi+AjOiSqmyXfuq/FfyqBLcwTvtX03DgCEUA=;
 b=RTTM+UHAcMto3dpImNFT/eGFm4qY6tNnR+jn7ja1JCQJcI5Qu46jHgjzSqW+Y2VIeCCNA+1GwWsGakyDjNSwo1SGOTFzfrnq+GA8YpwQ27IKk9mcUSRxC8U7OD8XVLb0fJ9bTr6lET5Gcu9zYJ8ef5S+8kUU1gfpgnwweow0BaTcLu1l9QHHyIHhszO5tMaYgUPBiX5IS5vTTisLAQgUAVfK5lkPaDvNxzRtQNxbKrH2349A7iks0mRTGDQV1JqiiOYveZldO2lJ+lDDUdiV0u88UQk4XV5Mzlu8vTp4sikm+5UVslxnvI5D0PFgxjTOmvIR5TX9R1rTw+RNJCTIZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mxk8joNoi+AjOiSqmyXfuq/FfyqBLcwTvtX03DgCEUA=;
 b=zmoWAlot/TpVTEVafSBbCwQauPbwsAwGHRoXP44o0vM3U+N2iPa9gG8QXc56TIsN7JJU0hBeTnqMPA6RreG+1SCRqhx5LHp6YtRwN2k55tmxH/kxUWc4uDwXG5Rup8zf+1R909N9AuF2V3+3z64APpX+yRpAJ9wewlb1Clqy3Cw=
Received: from DS7PR03CA0274.namprd03.prod.outlook.com (2603:10b6:5:3ad::9) by
 BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Thu, 20 Jul
 2023 19:20:31 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::ad) by DS7PR03CA0274.outlook.office365.com
 (2603:10b6:5:3ad::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Thu, 20 Jul 2023 19:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.35 via Frontend Transport; Thu, 20 Jul 2023 19:20:29 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Jul 2023 14:20:28 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amdgpu/vcn: change end doorbell index for vcn_v4_0_3
Date: Thu, 20 Jul 2023 15:19:40 -0400
Message-ID: <20230720191940.780187-7-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720191940.780187-1-samir.dhume@amd.com>
References: <20230720191940.780187-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|BY5PR12MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: 4534925f-3f87-40ef-bc24-08db89566149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P02wkh2rcyUpv+z922/zYlVcPKIipOgs96QeerX78zpdbnbqbtis2mlGnSpJdYs72ad7j4eL8vAb4IjcTnKufscYTAtkOHBniN6NnwnGN9/XxpetTunOoPcT66UEE3UP1nSD0vIibhv3EhgYbT2bfvzxZJC6ittlJYCO1qwmRP9XOE9vOjyRWCGs3+XIIdQrz21Ma6d3JDDDQrcqwvJs34dkd0ghITm8z75cMhEdAWNoCKWTa1jeGRplZ6pmpIakjYElYsD1hzGzer0tSv7i3bdQrz5NVOrFcj+4g+V5v0niQwCI+ukE40Pd5Y9/zXE7RENFTNPMj0RcX9PdAPaWukSVbKCEBYXreia8jBgo1YzZQwLGlaCNjYhADEQfLvESotRR/yJQyZBw29WLjTyni4CfMLLwzdSUIal34qFKFWlXr/vABcs06uvhyNdbdL8jvlwZzrmtJbUAn5SJUw9nSQp0RXAoC6BcSom4G8coeLs9lIwY91zX6khoTfp37zXoqbG3BI9cmqvHDWOakFBrJaYrvHyuJesyTD4t4jNu8AVc30k1sJyWH8UOUYlpBvAId83vh9aARHJkxBM4NJbhlGdJrtElF7eaYLLthjycgRTr6i6mgsrgBF6nZW4RMrvBsbBbFMvtNVtd2sTC7eDSEOEYMFxY+t2DmXBhO0llwuWj8i5oP09tiQonWYOM36BSX6wUlVeobuzGjrrzb+6JERC5ECYI209uVbjaDt/mP/swsRWOk9Wlpmgg+81Ruq8LjdVZX2Jjdlh8ZQhfW0xvSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(356005)(70586007)(82740400003)(86362001)(81166007)(2906002)(36756003)(47076005)(426003)(8936002)(8676002)(2616005)(36860700001)(478600001)(40460700003)(63370400001)(63350400001)(83380400001)(1076003)(5660300002)(186003)(336012)(26005)(6666004)(7696005)(16526019)(44832011)(54906003)(6916009)(4326008)(41300700001)(316002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 19:20:29.4690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4534925f-3f87-40ef-bc24-08db89566149
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4885
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
 lijo.lazar@amd.com, Samir Dhume <samir.dhume@amd.com>, hawking.zhang@amd.com
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

