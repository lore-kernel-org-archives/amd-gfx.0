Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDD7C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E85210EFBC;
	Thu, 30 Mar 2023 19:18:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89BC510EFB9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:18:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsWg6+T0L909OJ9uAVjEJCQmmjX6s23qDMr7EhUnPWG5vKNfCNKzSLwfflOgDZnYa9NLlnokcvCbBNIikC1Lqaa2/6J2oQOc1MPHl6dMjnDOYRgLED6vR0IpnFXe1BTVQqGj0QM9azNrKT/KAPVezdtwSYcqvoo8hjh1RmwUg+g2o3c9xJ7jdgRM95ZTy04z3dfQKyNzOeLZZnflY8QVIiwtz1gl6164DnJKyljn1hGNNcu6I9dP8w9P7SfjYu1v0gotQvYcvDs1G57FpXXsmG/DBM781kfd3VP8Q3nW20fGQdYcIYhXcE1cDQ/GlCs5toPnTB9HpdbLbtAaO2iqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOlxoABgz9GDmYj9v8tfEwidZU8qCYNRSAeftkCdNVY=;
 b=CyvsO7PZ9/RpQ0liHPlrhTk6B+JolSb3ZY7p2qjV6FxIC+8ju/v621SBkehtMDwTBKbQVf4/JkV//6MQR8fADiWwIQ9GoOSiLW71gQjfjwv/wItyjT4+UzPUfu7mEYyOxWIsaiT1cXtJIN+NAsESsB3716bQAoeiUcuiVsdrECQ+xli8gwepS1cPj9MRdcumj0wadVUtV0u8m1E20tKiGy0GxvOD3f6YeYd7vyqdk1+DO7Z+01ORHYGZ2yDooJPoAoCv5Ib7PrBCdA7+j0DyDwBthAoVRvaJ6LQ2cY7KufSB9Xa3hrAMS63xEHpzncYGq/nKsS8SllTwUzdZuRIS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOlxoABgz9GDmYj9v8tfEwidZU8qCYNRSAeftkCdNVY=;
 b=xzdt4m6aoTE0UE/vA6wmUziCju02w3ZFvpPZgHGb0IzLbkD2TqD6cCDkS5nWsoy8PvTEmEL769ZOgxZadJmOms9W9IDdqOw0DrtrL0Eza4I8SCcw9NYRMDV7tMb50nH2NsRv70zzhmT4wIZE7aPUYH7tQperfddGsrKY5xi9j8M=
Received: from BN9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::7)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:18:07 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::89) by BN9P223CA0002.outlook.office365.com
 (2603:10b6:408:10b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:18:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:18:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/13] drm/amdgpu: add UAPI to query GFX shadow sizes
Date: Thu, 30 Mar 2023 15:17:44 -0400
Message-ID: <20230330191750.1134210-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330191750.1134210-1-alexander.deucher@amd.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 89daf573-10b4-4ae4-87c9-08db31537e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mas+EZMGYSqiTfyWnkVXwExA42BbeU7psS4sahKW+48FiRHGhrkDloCMRvo3ceZYKfMvO+Xf5ja9SMcB0teAHJ+CQDXbdzNQiXZUUvYL7G9U3vi6bLwxq7PQ2qVN+JCFxEwUtDf9rK8sxPoLmdJOr8c6iVemu/JGPKlTLj85RqjOgY9Ov0YSyCYvSZrRRwnUvyaiwFUzIdjmQntd7+b9hTV+jdmnCLSIWj9bSqt0dc+yOjhvvOCturP7Jy5lunoLHPalKx1wleGShvEzRPNf1lZPJ5OCtkQSBuv7yULMYPJFqV6VBaQ77S3sJnb4Ofm+wKp74dhXHNZ0vuHOm+YBRbbPlNYTxrg9dOBnDiaKN39FbMHtLFzDIhbHe34fG6ZGny6gyk6hVe49sPP2TGgFgIes9FgcEXFaPuPtxwClUQXQEp3wUdaxI/VPIDZuYDKgylKmwpTWYC0gEdi7H8i68TgK9HxJzXm3ithOUN/g/ecujvtubDK0rLS+s7pX/kqo7SNQm0jIxqx3c2fHXCUmCnuZfmQtu9Ka145OxIx17FI7njrmS2RqhfEGKKTIyeCOJRon5/pPAafFBhMEn3fnN33xQsSWANPDKs7CwdtBZVoFpavjDI3y0GXA29ZMbyeC9DG/EhYnuOjlQ0UoWeSKkNkUI0agq/+1C2HTbbz0CMl7yQshVR9HRR61qW9YYm9dCerZhA1o4J4X9MEeRW/LQDVjo50qOwG9Qnf0UNfZ/Iw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(8936002)(356005)(82740400003)(41300700001)(81166007)(5660300002)(82310400005)(36756003)(86362001)(40480700001)(7696005)(336012)(47076005)(478600001)(54906003)(36860700001)(186003)(16526019)(426003)(1076003)(26005)(6666004)(2616005)(70586007)(83380400001)(70206006)(8676002)(4326008)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:18:07.1285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89daf573-10b4-4ae4-87c9-08db31537e29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add UAPI to query the GFX shadow buffer requirements
for preemption on GFX11.  UMDs need to specify the shadow
areas for preemption.

v2: move into existing asic info query
    drop GDS as its use is determined by the UMD (Marek)
v3: Update comments to note that alignment is base
    virtual alignment (Alex)

Reviewed-by: Marek Olšák <marek.olsak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 3d9474af6566..72041a51cc27 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1136,6 +1136,14 @@ struct drm_amdgpu_info_device {
 	__u64 mall_size;            /* AKA infinity cache */
 	/* high 32 bits of the rb pipes mask */
 	__u32 enabled_rb_pipes_mask_hi;
+	/* shadow area size for gfx11 */
+	__u32 shadow_size;
+	/* shadow area base virtual alignment for gfx11 */
+	__u32 shadow_alignment;
+	/* context save area size for gfx11 */
+	__u32 csa_size;
+	/* context save area base virtual alignment for gfx11 */
+	__u32 csa_alignment;
 };
 
 struct drm_amdgpu_info_hw_ip {
-- 
2.39.2

