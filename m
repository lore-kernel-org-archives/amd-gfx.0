Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8BCC27C6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jun 2024 17:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A8A410E23C;
	Fri, 14 Jun 2024 17:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EA37dC1R";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5634310E23C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 17:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bT8gVj4knlX9RoAlQlSIZwks3H0glE0bxlvzY522HjxoA0VUbq0Tl9C7d60SoLrafKeTxbLk9tuRygJB30q7vZtWkcnVYbm/cq0snUehUi4wXaVYb4RwVmMMwOxaldXyqODCQQrBhvDhP2EJxV/Xepf5wJd9myOEDiTJN2eqGC0D7DgjYjDzf0rQj3Z94jCI3WzH6Oq7O7/4k5G5e/TuN8FIRlwMBf6rWhyxmb2OAUlPOmd+ImIftaeMANIS/zpfC8z26hdml8Gej86ZiN8Rtvin/pjLKv1ljpworLQiSNVxdZYlTbA/0qb3Xxp/64l4+D0zPj1SXepNscW0F7yffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5O1jxAfGKppq8hM4DLzQvhLzkn41acOTOo/mxBqUBdI=;
 b=I4ohQM2SZL/glOd1D5lvC4LntpuzxRaFZRi2Gmc1wsOqzcjfA6zL/wgyBchb6U9bju3tDOFYVUAyiIjW33kO0PugMhr090L4bhF89JcVz21twujfnwOCoKoyY7DVL5HFuix/WjZdtsSkqLHXsaIxNkJRN1nTz1OQpTqCHpyACTFglrJoQCZXIrOoZbNarO652Eoqp6r4HBL3jBDmJ+Eb+8+Nxi2KGQgmKTOupW8YZtMje+2aEePB++il8u6eVrGq3cVizcJ84zLvqzmQOKui6ezoSVLqWi8HfXkvl1Ts33XOlxkS3j6StB9aBykVwMErRaCw7ng3odrioc73CiR51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5O1jxAfGKppq8hM4DLzQvhLzkn41acOTOo/mxBqUBdI=;
 b=EA37dC1RFb73rRf6oK8spShWPOAPoyW84qy6UuHWPkHcB3ddf0AKFtlRJB8LczP+YnC2c7bWzLfDwnZE7WqnuhSZwalNuko7qrn1JdgilUNWxPDr/jVJNef5POshOLGfpbEdkZZWec5lZ7W+uGVn9dOqipFc/kZUZ4wnug3JHGg=
Received: from BL0PR02CA0121.namprd02.prod.outlook.com (2603:10b6:208:35::26)
 by CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 17:55:19 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::1c) by BL0PR02CA0121.outlook.office365.com
 (2603:10b6:208:35::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Fri, 14 Jun 2024 17:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 17:55:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 12:55:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/atomfirmware: fix parsing of vram_info
Date: Fri, 14 Jun 2024 13:54:58 -0400
Message-ID: <20240614175458.459062-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CYYPR12MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8398b5-e6a0-4d90-21f9-08dc8c9b27bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MtGbGVYKgOe/ZtJAgMLs9CJzSupBelk8091MCAFQ6kC9xDwUSIeSg4WlbCV5?=
 =?us-ascii?Q?TrzV7YFYIeZFLnSbL0iIvO2Xh9Q6KWtri88QD83pdTYdJlGjCO5JH2niYK1+?=
 =?us-ascii?Q?NV5Fn8oaaBES+Gc0W0iW74FS12XfaWYXb4JisVkM54mhE5el1qFNprEdbuqj?=
 =?us-ascii?Q?Mt8sGdyyyWqhB4qr5svuespB5jeQk8z7fxtkWENqPy7ZRK6BxfLLbBEnX13t?=
 =?us-ascii?Q?1OzPcGW8szObFID+5xFrfFiGDHR4sqP9/TjZXTFsXlg1ASNzznjf+gI7AooD?=
 =?us-ascii?Q?ISNJEzhLDWLwuyKDwxF1j6AxfnO9lg+CVCs0jHzSK4NhRGE3bHlOgKgRy2Oy?=
 =?us-ascii?Q?n92FCEgurRWQm8HRLoXy5fKhgoB9RKmTvdKWgRq9G2+D0EiEhNZLSk5TD6pl?=
 =?us-ascii?Q?4sG/xOIv+Z/sbi5UzOkT65Ex6WKt+epKVqWI/QV9CNUX25QJUHvNBvSBk3qC?=
 =?us-ascii?Q?94zcpzmAX74mIBQ2LMX9FrmGLcbhhe43wt+2nA6IJ95M9NCkTEstkXlj6CMB?=
 =?us-ascii?Q?vY1QxgmGweUD55lWX9jlZ12mLPMr+KGSJEAHjsJ3/oEyrtWw6zyqzDmU0FDT?=
 =?us-ascii?Q?VOI2tGni10vpwMMSSwNt6bu+dnKjfjFI/PuOf8XbvdMIoIrs+dMjwgv65keX?=
 =?us-ascii?Q?AFF0FUctKnVJ0ltUZNAnexQeC310PMBxxbIl8CpI+6fqd9Rvf3Ayv1Ly5c3G?=
 =?us-ascii?Q?CJD6xbMOv500HwoT27Fike4An4ESUTRkjyQ/FpdvBozw8kEnYh7wXAUoIlAJ?=
 =?us-ascii?Q?j8cDB+rYyFcdYpu5qDvqNfQu+aPXY6JlCjdVLfka2EtZoVkeXKbg0SBDBeqe?=
 =?us-ascii?Q?t73p2lOYEa21HrPZstZgBnZx0k2d4yjZ9Zv79BE14P9cqy4dASgQa02Ly8jt?=
 =?us-ascii?Q?y0Umf6TProZLTaFHJZP2E1k0lf67q2KEtupINtjoRZ1sr8WAlRwjqNbbC+34?=
 =?us-ascii?Q?Z9AxWNcgClKn8rT1I3Kiy4LgLpyP9Tnbj6HbZXwv1LCTRRRxAWT6LiVYzN05?=
 =?us-ascii?Q?Tqnr4b03AjPvFI/EAC2UafeQQEASNAy2+oTi4IKFblf1m3bOnjW4dAf1UuV9?=
 =?us-ascii?Q?ff1sadYczy2qaOnXXJ85QW2jam/FcOWu/m9Bb8h/NMjo0eOUmGiD3RUmtbkp?=
 =?us-ascii?Q?Y/DF0S2RH2dbADDKBU9NmMNVPn7y1yXu0b6PHfJA70pS4CtLdG+rEvzp7ZTt?=
 =?us-ascii?Q?QzyAxZ+2BXgR3cMajmrKbP/I8ANroswxUhP5bbRmPd8Ruoka4UkCyjMsnOng?=
 =?us-ascii?Q?z7v9fatW+kE2lmRx2a2KjZMtTpVLOH/jo+e+84YgQ8zUKRjkeRD+6itjmF89?=
 =?us-ascii?Q?Pd/+n/jzZSCGFLBkLrnD0JfP/vvHxAJStTIs6y05iIWnRdATA6qbFPaqUMXS?=
 =?us-ascii?Q?BBZdh35zDXyW4UQVJ+qpSaKQE+Tm8sWPxa2AV/xa0b6l9kXKpw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 17:55:19.1768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8398b5-e6a0-4d90-21f9-08dc8c9b27bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8731
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

v3.x changed the how vram width was encoded.  The previous
implementation actually worked correctly for most boards.
Fix the implementation to work correctly everywhere.

This fixes the vram width reported in the kernel log on
some boards.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index f932bec6e534..f873dd3cae16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -433,7 +433,7 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 						mem_channel_number = vram_info->v30.channel_num;
 						mem_channel_width = vram_info->v30.channel_width;
 						if (vram_width)
-							*vram_width = mem_channel_number * (1 << mem_channel_width);
+							*vram_width = mem_channel_number * 16;
 						break;
 					default:
 						return -EINVAL;
-- 
2.45.1

