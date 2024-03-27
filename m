Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6A8C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 08:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA25410F916;
	Wed, 27 Mar 2024 08:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YUh01ynn";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F27D710F916
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 08:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQ0E+LOLfWsr+c9B3Rx93uwSr7hcCQ9gQQ1iKiKfmkXHcogNJoj+ULwHv4UzxaU8zVLtiyUkyBy2fY0pQKdeSZplfW4+0ASnIeUNNBCE2kdVq999fLjy6Dv4HjbTqPzQ1aT6XPpJ7UCmvJ3fZpZ3GAAm86ODlT4M+jSo1xLtCh3JN2GXa0AHCXEaCowL6DUqFUFWCUoS7ijN+wHUJOgiO+GdmCsVwSGO0i9P7TJB+d814GuePFuTfJp4WlsyId0/UScdeAmBbNzkMoYUbDU69BProEz3ENblp9cjuFHNz1nOsJwhEeb97qkh8ASxosYcv1VpaY1SoOAnfRI1O3VHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U64rxFg9bCX1pRwJPhUBvFU1svYzO6nOZBfaPLURv6w=;
 b=liQjN0wIDaSZwdv61RUMifvahc78Tj9dmV58ykhCwlo9mi6pqtc18JNUuedQoa4fhvB4Yoz/hOamdD0vMpmAyscuMt394ZdtyFpzYQyavqmqZSTevn14rjKVagZtu7b/2TLSt3TA/ysxCDAJ5lZymikLMrAnH7PwiTOCMdGBvuFeG0iDCTOSLinFlMNPGRaXVX/9n+wONrI+c67Kweldul+2nJTQiGz0V1y/MsHo+QsRPdJpmNTB7XLBIQSxE/6Lckbm5UBPs9uI4Otr28ofgKGrSfLW3CNXOYHRH3fn/5JwB2dZg66+TtsZ1IfSgic7qfwakJeQ9djAz/xpd+KSPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U64rxFg9bCX1pRwJPhUBvFU1svYzO6nOZBfaPLURv6w=;
 b=YUh01ynng7F3SQq/8L1LA+QO9kOw2p2lJ5daRGnbriexIMeG/a9zCwBjqRsmKeIMTIgHYgXTKnSIdojirw0nj9NRIFK9zkPqUGBRsrL0XGIPPZ6YN08CGQ7Yo55Yt25ym6X3HXdQmjOYNQsqbaR+AlZ6YhpX/Yilr1Kyc5B1gWg=
Received: from CH2PR17CA0016.namprd17.prod.outlook.com (2603:10b6:610:53::26)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 08:03:19 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::f4) by CH2PR17CA0016.outlook.office365.com
 (2603:10b6:610:53::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 08:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 08:03:18 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 03:03:16 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v2 1/5] drm/amdgpu: Add a new runtime mode definition
Date: Wed, 27 Mar 2024 16:02:55 +0800
Message-ID: <20240327080259.2947891-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: d08d0e6c-d55f-4703-91aa-08dc4e345d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sLtr9HsDQyMpH0YsCZYCeJi1/HcfQNmJFxN9hyQakRHCXzE0Mm0ChS7VYaQiwcE0w7OInk17R3ad655VXDZctfp7lZyot9Anx2jiWpJjjKsdkDg2Ff1hTv/MoCpRICC7WvMF4TyMOeF3L4PwcU8Et/Uc9hMZq2oWDRzReZ1qdjlop1T7/Nb9fOqC99+/liGui7oOcMUbwobx/gSFpHC7xRgVT+p5HZ/aGoD5pYThLNa0OkTNj/fBfybr2o6B4NRpodu4GFDG2o9slE707LaNCNEhq+9b3G1S1qJbcBUdgT475OVRFyQEwKQUV14ZiUhkm1EuJ7MjEZksUPdUh7ZNCKkcWN9omwtcS/C7IETRxMpfEh6sjIEN0b+NO+KhhO5BDCDFaG46jM5h43lAOFSU+I0YL84Y3tshpa8TcGZcSdlJyUtMI01hrKIGU6oBJQg+oO57KEOnwp/WymkyTCOw89BaYkd7Vcxi/gEDUKk8RmNbyomVdRDLLoXnKl10jyhDYHD3HvcDQGyXULWXJ6dMVQg4hqc/5VUjxh0C549xDAyFT80WYvzqDQzfNrLTZCwWJ4wMvBc8P0/w+s7EKRCv9B1mrEDCUdgau103WmegbHYPdhcgX/5amiBMOWqMB+saOJ9NdBlKEbaCY+FmEVjORnlMoLNrw9c9DsCpbI3FvewKBK8IbvxbmVzlOaOZ+CzEX/wXZ6nlqczfZHrrbCYnlplQAopNO1eZOWYQPm3qIPK05CMjI1O2OvdfV2AndZ3i
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 08:03:18.9838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d08d0e6c-d55f-4703-91aa-08dc4e345d4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
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

Add a new runtime pm mode AMDGPU_RUNPM_BAMACO
and related macro definition

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 621200e0823f..e6cad9f7aaeb 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -50,8 +50,12 @@ enum amdgpu_runpm_mode {
 	AMDGPU_RUNPM_PX,
 	AMDGPU_RUNPM_BOCO,
 	AMDGPU_RUNPM_BACO,
+	AMDGPU_RUNPM_BAMACO,
 };
 
+#define BACO_SUPPORT (1<<0)
+#define MACO_SUPPORT (1<<1)
+
 struct amdgpu_ps {
 	u32 caps; /* vbios flags */
 	u32 class; /* vbios flags */
-- 
2.34.1

