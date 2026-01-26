Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23417CF65D5
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 10:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B766A10E3F2;
	Mon, 26 Jan 2026 10:25:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GJtFESxl";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4305F10E3F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 10:25:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xf6z/WKXFZiUGXc5s4CCU4F/CoI2g6NCel1ML5RpeyQYlhlD+i/ckGSy8FtFttlmBObnDjTM5QG/7EiSclDL9fBYBbzw75GVceib497bMJrszTVnuncfg3URZ1P3Y3tyn54Wzwb9E5XctOVhCIJFhkLqv/dkHOrjYmIaTlPOX22xEyXF91LtkTOEi5xkNsnkWp7HDZw7HD52eYmn5SdTWDIQsJ3tcy8yo2wEiVTknVZoq5jxpK9NBoA+T0O05tT5cTis1RXv42dHyZ9SavbJ4Wf0UT196xtNkOeAO44NOs25nD0RBZfTUJSlFLRhcqQLS/FGyPijDb8KMqi2jkIRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXttuzHQS3t0wWt9wXlS4X4XDSFZZ21kkJWFBvbLal4=;
 b=BFF8FUurDZI5LH7H7qhMSxLZKQjjabg3l9YOpAMd0tZIYPttTNHKml+00fUSZWohANu+IWYYQriO4H0LxNl/3j8ydy17roiLdFDul4TCERVemLSH6na6JBI6wY9yczHNlj+5AeNAKyIoni/NL6qRm68O4Pk8tyyj+8ejqNJDfCCK8uLyzg6mwFo5wNjfiV4hx5JndBXoAW2P2sW9CK4D1YIwFlbdIa9jnPjKA2UKq1iJg++OQtzzxeq06BKIqI4uedaI2lWMLVlQYU7lu8QN1gtChuRMs4aPYq3b82Z7/9Fk3ow5XV05s9Nj+s5enZ/fsDn2wTcswjGuM+nIEDEspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXttuzHQS3t0wWt9wXlS4X4XDSFZZ21kkJWFBvbLal4=;
 b=GJtFESxlht5fwq/IlbFAFeCd9Z5z+8yLiO7Z79tbqNjKizJ4oe63wCLQNJGc5SIFhDvr9/y4JBpUe9yPRlZQOpGneBFWO1Dic2unH5K/I4iRpUPa7fD9nRy+e2/PufU9njW7RUGYuQ7aV+B2gBLZC5C6dpOXKvSmT5fldWHM0j0=
Received: from MN2PR08CA0002.namprd08.prod.outlook.com (2603:10b6:208:239::7)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Mon, 26 Jan
 2026 10:25:50 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:239:cafe::6) by MN2PR08CA0002.outlook.office365.com
 (2603:10b6:208:239::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 10:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:25:49 +0000
Received: from lang-cezanne.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 04:25:47 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, "David
 Belanger" <david.belanger@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Add a helper macro to align mqd size
Date: Mon, 26 Jan 2026 18:25:11 +0800
Message-ID: <20260126102514.273891-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf0cb8b-365b-490a-8176-08de5cc546c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wx9oLUvHGlR0vfZhvDSPdbPwgl96ambeU/q6cBi9H1Tp71VB2Vzvh6MtuGx2?=
 =?us-ascii?Q?NztWW3jpE64W++uPLhNtA1tQBWCYBKWFQmxHKzAq0l9/j1BXytdBZDnByjEn?=
 =?us-ascii?Q?piL+zAX5nApDAXryGfXJ+0zYalN7vlYIw8sX+H48aphSGqYCozlpc66nLLkx?=
 =?us-ascii?Q?ayxGxzVEWetWRMmM2eSsO/amQbDdcq5qckr6QnV7dTjI/gvVrmb+A+PFxg54?=
 =?us-ascii?Q?4KQLPXzrZGKozQV39vTzryjkQwFwq/i5mZkFqYWvBw4S0bZ7DN1p3OzQw87e?=
 =?us-ascii?Q?Y+7Nje0DsSEMc1DJeRvJ2UKPQzwa7vFi/vb1MbWs2nAt/DQbptnW+XYL2Rbp?=
 =?us-ascii?Q?sEnWB9nfEAzqm7+wf7Um85FpbVoOnFgzxEc3glzG8bDCzyOKPhPz+ABfYqVn?=
 =?us-ascii?Q?l7hgHCNN/41kenrFie3y71a8AysThNFnB5qk0BL4RcFTnHc4uQRx8usEv/uo?=
 =?us-ascii?Q?dVXQDG2UnPQJ63TWgpdhBcx25GcdYvcmuYrBvPuqVjg9TE7G9RYPcmN1bgTV?=
 =?us-ascii?Q?8Jzms54p8JHjFmPJzcMVLeA7l1YZWZIn2TVxblBCnNpkGQWOcjZoB995kKl3?=
 =?us-ascii?Q?1j8iHTf3678zsLDcR+nKOmNznOmQNHxnaAxs0EbgjHAW5ZOtTBviLQhiuc2c?=
 =?us-ascii?Q?RmCMewQfGm7O59H9A/FiOzYUXzlnXalP+YnaVsoDe8fPYb/9KmurvzXQXshK?=
 =?us-ascii?Q?GD86pIZg3g1/TnOPhJe2XvMcHl0kIjDbOLLEmwdby7HQWY2mHPyy79IkRgfW?=
 =?us-ascii?Q?lEnZY9dbhjv2njiFEdOqqqVjADMKsVgkF8W0q3YxbRaiysKEuRB85Lx+4xxB?=
 =?us-ascii?Q?17L8KWIOCaIkuNe5/nXbhcHaOH0N49lR7st+KSVGGLEJ2VRr5pLWmt6HxXRv?=
 =?us-ascii?Q?jztXE4HTufDuY4yvh6GCWFuiNlKGJnQLVFZ/Ed4SSrxRTIuqsKvEpilw/SLj?=
 =?us-ascii?Q?Cv81s1SqW9Tr7LYp8hwSllkm5wh/F9QujaHtbRXcga3GYQGVto/QEqtT05Gz?=
 =?us-ascii?Q?i4xvurYdUF5XyRWwqJ7P1NGqxMc4GKLxzb5wG9M817YzmNP73YqBihwus3uW?=
 =?us-ascii?Q?x3KMPY24/JnrYlZxTmBZ6BYJgDOToU+RyuKDXvrt8H1JyZqkh2Fk58+OBv6a?=
 =?us-ascii?Q?tLjJ/+O3YDVVYgokWP3dYsxzkMPUweYOZ/ztpUKiWjzPcaKfJ/PpfTxcZJIG?=
 =?us-ascii?Q?Xs0n9RPgsiJ7590jdJgZDFgkHYAw6yXvXmWX8tU3MlPCwPpmsmxae+lLuZqp?=
 =?us-ascii?Q?R1wZN4ZQhSHzXD1TdFrn6+hjZGaxkcZiiMWAHFo08K+UXfqQCxrOo6mL2ICi?=
 =?us-ascii?Q?PXtbU2xAq5eQYedb+5YjBHBUW0Xq+JBFLvZzcryZsrnrgRuDkw2JCNU93hKC?=
 =?us-ascii?Q?v7OivOtH+QlJfycaZp1vID7EaFUX2SoHxUcyQuujODlkqLMTxR4CfjN4IXP/?=
 =?us-ascii?Q?KUUwSvFQYn2B3unomNR9I3LKRwKoUl9o0+d/CJDuuEt/MtH9nRKXd/xz7q2T?=
 =?us-ascii?Q?PdCm6WzeBGcoKGDUdF/iYK0MBzZYFZ0WFKnIlvXNc23KVLOnnjsHYG2+bi/g?=
 =?us-ascii?Q?wzwbTz9pmZURtgrB5u+Czavd2Pr24cVTycwmPjjtaCKbzBY92H0dk7tC4Zjf?=
 =?us-ascii?Q?AhIaezeournygI/RvJfzc77gbtQ6cqf5akYpZ7NRLLK05L3WRqRtfbgwd/i3?=
 =?us-ascii?Q?Be68NQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:25:49.8273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf0cb8b-365b-490a-8176-08de5cc546c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257
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

MES FW uses addr(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t))
as fence address and writes a 32 bit fence value to this address.

Driver needs to allocate some extra memory(at least 4 DWs) in addition to
sizeof(struct mqd) as mqd memory.

For gfx11/12, sizeof(struct mqd) < PAGE_SIZE, allocate mqd memory with
PAGE_SIZE aligned works. For gfx12.1, sizeof(struct mqd) == PAGE_SIZE,
it doesn't work.

KFD mqd manager hardcodes mqd size to PAGE_SIZE/MQD_SIZE.

Let's use AMDGPU_MQD_SIZE_ALIGN to avoid hardcoding in differnet place
and across different IP version. It is used in two place.
1. mqd memory alloction
2. mqd stride initialization

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9c11535c44c6..41f32ed39113 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1239,6 +1239,11 @@ struct amdgpu_device {
 	struct amdgpu_kfd_dev		kfd;
 };
 
+/*
+ * MES will use memory beyond struct MQD size, 5 DWs currently
+ */
+#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) ALIGN(((mqd_size) + 20), PAGE_SIZE)
+
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
 					 uint8_t ip, uint8_t inst)
 {
-- 
2.34.1

