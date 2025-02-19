Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBAFC021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 09:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50A510E24C;
	Wed, 19 Feb 2025 09:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wtqujUYN";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9248210E24C
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 09:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arPk0SOtnjzekq3QDK5isbjsxjVyz8eei0sNhpWR8IAZjAYUf1ECfXam9Zii+A2PN9L5meWvntvlLu+8GL/zFjnr160ol3HxqVL8DRV7tCy5farMYO9CqOknoT/y71ubM6MiYM3Snn55bdenN9WGeY0JVGOXkE6XYSEfgfuEICKVqsI2uJJ0WmtfVEBjHQiqOGiDm5xPfuElVjcOe3MNT0j7D8+C+6pRqGu4x3HZRLhhTpgPYtOwYuYLP8n6Fuo1zIF+p2eUpD/o7p9Uq4WCi7x7EI8T20mjsN1KU/ogIoKPM30K+Wcq21/OdapzuYbxvo5q+i5HjjcgmI2FKaZAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42QWLPq70Rp2vUwXfUiXmTSfUtQt8hXowm7a+9OC/68=;
 b=izFGsT1e6EnsCy/FzzSStqDlCxlNPULulUv+m1f8CafgeQi4ImffvxQjb7YENanfq83tqE57qJfxvgVB/doGwd4etQ6qtSWMRu9DhzsEL/L/FEOze5RZuuG9Qcf9dG6IbQeM8QJc6nkyM6jLbX45qdRkqC00SEnQjD7voKEaXdO0T/PKU2Z8xvLq0fnUhGfUBGjhxZRsIwV0DpZ47HcS2alzPTqnyJkQfcaf9mFeUNaKEAcCY19rxn4nq/Pk/7V6hUFpBe4u34Ykdgq+G7xnxqDPzT7LldlHwYHeuf2DDDidD3uhzZU9vFFohF5dk7Jxxy2mxC1kkjBdgQcnRNZ9Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42QWLPq70Rp2vUwXfUiXmTSfUtQt8hXowm7a+9OC/68=;
 b=wtqujUYN0r09XBa+nZdUfjyG8CGAm9D0TmCXYvCjNSM2q4Ypy1mKTkCaaXVAGAamOtLmRGK+kQ37y2MqHzg3AU197kU7Tnhr5dsd8qVbEOCgRfZVUwh0bgo+yq3elg61kV8Rmm3Q0mUIw/VO0UucGhOV4GJiIR1c6+UuFCipHbk=
Received: from MW4PR04CA0310.namprd04.prod.outlook.com (2603:10b6:303:82::15)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Wed, 19 Feb
 2025 09:03:54 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:303:82:cafe::c3) by MW4PR04CA0310.outlook.office365.com
 (2603:10b6:303:82::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 09:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 09:03:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 03:03:53 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 03:03:53 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Feb 2025 03:03:51 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH v3 1/2] drm/amd/amdgpu: Increase max rings to enable SDMA page
 ring
Date: Wed, 19 Feb 2025 17:03:50 +0800
Message-ID: <20250219090350.3558953-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: a275fbff-1eb2-43ae-b48e-08dd50c455e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vWhkdSJXZc4k4g9xw2F4i9C6lza2JEEmpVc/QVloPtJyf7Ku3wFAqoUIV+S2?=
 =?us-ascii?Q?VCyfWGqdmVfDt7xgkgixV7poj2l7LidW+ZjmK7sivnBlfPU9MRfj8Foc0KhG?=
 =?us-ascii?Q?v26Wj476ItxViUMP2gPkQZOqxMp1LLgYOB2tD8QSF+5zcqjdWMLOuDaGBDbv?=
 =?us-ascii?Q?wQXvEHvTPB1NJgaDQZj79qxsNolGDBNlmP4XSYHGHIM7gJX+ygOiSCz6yxwP?=
 =?us-ascii?Q?Rq8qVp/YbFRnet3/n4NScJSdt8mehQ8LrB3cbdfArKpjj+gA/GVlWMtGIPX8?=
 =?us-ascii?Q?1+ia6ZnU7T+OMbZ9iy7uPOTUVWj45Gz89DyYBdEDyta+ZCb0UYWbspbPGUsr?=
 =?us-ascii?Q?nzOTGIFWDNbptuxs0mPI/yP4kCpu78Bt+eD2JQVg2Vn7K95xAGgSjNdtJSGz?=
 =?us-ascii?Q?ws0ROzMqi8e2uloJpJf0U5Cn04siJc8Om+/8NlgR3JSVcuPUtuzuvjjvXfzb?=
 =?us-ascii?Q?4Rfyldw81W7pUbK69gj6Px2ZWbuD4r+j16CewFFQCq6vu+YL9H9MGtYOqOhZ?=
 =?us-ascii?Q?mNdI7FLnXOfeUG3XQ32YFkDZLYFuOnUbEeF7TziKxDP13d4gRgRVlgq7TUgU?=
 =?us-ascii?Q?9nDAMMetlAPmEe5O9Tr62RReUa7kEkzZN08g6zUZqUYtm8eNkEAQi4aDGPyy?=
 =?us-ascii?Q?YzDT6Em8gkGseNHZgOjTywDy9SNXT3zhBKaeGnK8hMpbwVTK6nf9eWk7KXl5?=
 =?us-ascii?Q?+RgAiySS4ZE1hBzUJcEcUYC+XyPaurmxSdLiI3FKr2JQpGTXB3fIMQiPLlit?=
 =?us-ascii?Q?16niWkuYdlyi7fx17rS+UZemy23Ypb9IMtbL+PRQ0hSyVhLjqecc437S7xFV?=
 =?us-ascii?Q?XCQbSzDJiAMmEM/9NondSQSqaRdlFgzIGIl1lUxSEPMDlP2sh906rRUrYaFX?=
 =?us-ascii?Q?8NXfbJ1tpxuphd+me3NpTfAYqVVwuCMY3hOEipu/HnwKNsQYtnWmBOq7CFtb?=
 =?us-ascii?Q?sPKNPEuCO8JQCmszSWpSOFwKFKaRWDJeLXOJ36NanP3/Ta+plr5uOdzYcKZg?=
 =?us-ascii?Q?nYF6xGggw5Bc2M44gbrh5z52JYrNojX3Tr+0mS3hE6T7hL6Jlzs3Oq/kxGIX?=
 =?us-ascii?Q?Yskv3hWWblgdjVrob5IfEdN9GwgsUIufgbMfKW0aX24Ht93q5NdhLA3UBaet?=
 =?us-ascii?Q?3OHdRXjeMmoedFU3/Aicek0NzZhBOpqN7KkkJHZA1JUM/TOLws0SkLpgdBlx?=
 =?us-ascii?Q?KUjTh4/LfZdwrnoJ9Egb9QajTySH63QT7TxQ2iSDVVih0jfTZuIKNEYjV3eU?=
 =?us-ascii?Q?UhXpwrujbBbcPIRxUNxzo/DHU8DTq6kvmlUCoXD0wZ0f2kHC/tRUrqHtGD8Z?=
 =?us-ascii?Q?CX59n24f/QTFX5vjt4Et7Hu5bTud7JxMM4kxzfqjXKumVOXTt0RcWgsKsP4Y?=
 =?us-ascii?Q?I0rNw4VDE9Tnou6rrkKoE06vvV7eeqvYURaQpapa1GJUxbgleB214Yegx5Mt?=
 =?us-ascii?Q?GVLMjcRWQ1iS8jRNbX1slELK7WxMP+GZYRcyfxwKB8CUbpihagMrcUGbXMqd?=
 =?us-ascii?Q?Rxk447wx2ZSmDac=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 09:03:54.0041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a275fbff-1eb2-43ae-b48e-08dd50c455e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
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

From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>

Increase the maximum number of rings supported by the AMDGPU driver from 132 to 148.
This change is necessary to enable support for the SDMA page ring.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 182aa535d395..ae1dd7d16048 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -37,7 +37,7 @@ struct amdgpu_job;
 struct amdgpu_vm;
 
 /* max number of rings */
-#define AMDGPU_MAX_RINGS		132
+#define AMDGPU_MAX_RINGS		148
 #define AMDGPU_MAX_HWIP_RINGS		64
 #define AMDGPU_MAX_GFX_RINGS		2
 #define AMDGPU_MAX_SW_GFX_RINGS         2
-- 
2.25.1

