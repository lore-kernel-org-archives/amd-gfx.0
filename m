Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEFCC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 15:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF4D310E148;
	Wed, 24 May 2023 15:22:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D4C910E148
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 15:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9sb+G4j4Dza7TmbZxDVh/8riJlI4cZV5TXAV6LFUSPRwuJsKED1YxMhSJJJXjMPNKbnKrv08P6Vv7jXdQbH1XrglcgNm9WwvjXMhALoqyxsSgJCPtjNPMyP373xamMEwB0lO7Ctwx1w9WAxJS6huiM48k8qFbzvXqraL9YRsz2IHQCIzZ9byMsYMBqwEkGjAYjUcWxA7uCNYkd9O6c+8qxi4x11CTTpegS9/piIS2sn5Wz+abh+kklr1ED4S+H2wIXXDv0gw2o83/loZzOqnbvpdRb+S4M0gPiTY9r1OQfAOsLeoFBElNFSc5Ol9oARhVsSgecuO/ca1eb5LPK3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwInVZq8uMchMFUyGjBt3xwnXZSBruVWQtqQJWaOne0=;
 b=ZUCme0ovwdBoElFj4rfya1xqQ3YmeOMVeqRiRGuU3r/QtoM0CNzlq9h82rx1PjJB2xTelut+lnDP8/0cDsJ9ucqnd9AVuUeOOK6FCs+UnsgttKGT3WjjJc211CpgqrFVFF63KBIqMZqvuwxZl32a0IKbVfljbSND0MXa09NHiTlC+80Xffv8F7KEBFMV9/tS00NvW0zHg5P2F+nc1osoC4YN87q6+BP4z76Y/qhZgOp5GmhULAHf1P6gElPG6xzzDhYDb4xLnqbrPcWp6pu1LEKAowiHDevT9oyU6pp5UHmnz0QewKcZwhpsGuM0KFvaUQ+NyC3L5W8RYkoNDRA2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwInVZq8uMchMFUyGjBt3xwnXZSBruVWQtqQJWaOne0=;
 b=R61KgFkPrfTrqUIb6iAlFZ8/3EnvavdIlGKp3zfWSZcVvm/Ew9LsxUV7vX4fRQ5tEaTSWuz3VIQ0FMv0Tm1qOEnE3nBxQ8Xe7jBFqtX74vyCmWi2bq/FfPblLHi0T1fAREymyt5VMsp/4NNFEHu/GaerOgM+l+eXDZ6j+nlkLl8=
Received: from CYXPR02CA0026.namprd02.prod.outlook.com (2603:10b6:930:cc::9)
 by MW4PR12MB7143.namprd12.prod.outlook.com (2603:10b6:303:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 15:22:20 +0000
Received: from CY4PEPF0000C96D.namprd02.prod.outlook.com
 (2603:10b6:930:cc:cafe::bc) by CYXPR02CA0026.outlook.office365.com
 (2603:10b6:930:cc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14 via Frontend
 Transport; Wed, 24 May 2023 15:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C96D.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.8 via Frontend Transport; Wed, 24 May 2023 15:22:19 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 24 May
 2023 10:22:12 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix defined but not used gfx9_cs_data in
 gfx_v9_4_3.c
Date: Wed, 24 May 2023 20:51:38 +0530
Message-ID: <20230524152138.3631037-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96D:EE_|MW4PR12MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb1076f-5d40-4a89-d626-08db5c6aaa6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jugkzGr3muTSp09vvYxJYAEgJ7SMLASberRgkSL+niaNIAFz4xpYg/Kz+EIN96x6Fecwmux4eQYdQQEkbOkQ3Vnaq4r3DLxg5FOFKhfjXSoyozTHHiS77KIr2Tu7JoUIuESj2BaLCN2FaxfZrj1+x0ZLjWuYycnrFiM/BG9ScDfRZC6G7go2ubFfRtMiEH9llP3sMWnUPCSE7Z3nTsybLo4XrCLD2Foidk/3lT9Y8vOLhXfhw3TFYkkN8V+jHSMsUS8DYqScCsQLCYyglXW6rk4/VO3XtEdWYl0/k7l5hhAzdjsUB5RMFVWDO5XC5p6EHPkBE1WYdILZSTeHzInPW8M9K9VvkWKuF4ZzKZ+ACVXgBRTCttHNnRjVVZ2kMzZ/pS7VEhENrk/7ncsx3VHDPhG+UVPcgyCmIREcCM0h5Kf9b9ii4ZToS4M0iq3QNc3Emw2O/cVNc0pUxCWM3mR+BoW9/oWIj890sSHrcBFtGUQZd8qO8zUPoCBv1FV91WPaUl6wk2VlrFjOdm7QvrpKLDeZ9E1+5iLit4BM6vOKXZcyQx+1c3jNt/a1XhRMm6Sc5z5cavygLFo/gmIwb+L20czZhF4I2zlmutNaTlvt0nPKujdUXsdCrKegjjTtM+Pe6oyvMTlsfjKqBF1V41ce3aXo3A1zrfkGxaB3xVGFQ2K5EzUOGBaBQMwYWnBK+EzYfwNZ6SwPOONw6jkvUEqed+QxQGtGLhi/htVf2M5lpCy8qLgnwOV0VgXG3WjI5+bREU8nhxap7US5lYgF7o25uQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(110136005)(54906003)(81166007)(82740400003)(70586007)(70206006)(82310400005)(478600001)(86362001)(6636002)(4326008)(316002)(36860700001)(6666004)(336012)(7696005)(47076005)(66574015)(83380400001)(41300700001)(426003)(356005)(2616005)(36756003)(16526019)(186003)(44832011)(2906002)(4744005)(40460700003)(26005)(1076003)(5660300002)(40480700001)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 15:22:19.7199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb1076f-5d40-4a89-d626-08db5c6aaa6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7143
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gcc with W=1
In file included from drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:33:
drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h:939:36: warning: ‘gfx9_cs_data’ defined but not used [-Wunused-const-variable=]
  939 | static const struct cs_section_def gfx9_cs_data[] = {
      |

gfx9_cs_data is not used in gfx_v9_4_3.c, hence remove its
include in gfx_v9_4_3.c

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ed41a7862d9f..bdaea50cafe7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -29,7 +29,6 @@
 #include "soc15_common.h"
 #include "vega10_enum.h"
 
-#include "clearstate_gfx9.h"
 #include "v9_structs.h"
 
 #include "ivsrcid/gfx/irqsrcs_gfx_9_0.h"
-- 
2.25.1

