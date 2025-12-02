Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE110CFD2F6
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 08:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60E3010E590;
	Tue,  2 Dec 2025 08:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N2LIZrh8";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010005.outbound.protection.outlook.com
 [40.93.198.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2DB710E590
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 08:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jq0jOPMAT/qXjd9FjOO7n0e5dQS1ugl4RbHcq+EeiMJP0IzmI88ndVZ91jNbdzPZcJve8POzsWsQ+iNriWCVsknuWKH5dp/Wg11L/Hb5Ed2L4yKXRaJz20LOYVDA99u3ln0Ym1uxVJIgjd5zvWWnR7+t/2tQcKJrCP8CszsdNh4+9tvqprNycuu6wu0AX1Jznr5Lpqr+VlJurM3cQzy8lFIAe8F3p5fOhj0TcrVYMJ8h/VyRpC5GyNEWsZ1KG/vTkQgK/Jp+ZBJk6O2mEV3PEK9Mfdalvoo5vsp6cLAQ+TIqOsGdOiQvJ5OdmaPvx8kPmsvFvDUnzHhqag9sEq64VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wze4WWkbqr0wdTnBw3j7ZTrIDPapUqBYN10S0QOhBu0=;
 b=GxZ2r9n6LO6SPiyP3OzL8bOnEdYRTMijTzcfXG/E9/VaeMINis4MB290xeG058fx1IzCZjqTw2hZHlS/8+GGdkjTzumcLVRDM093cv1afP6I78Pebgyi2ozwvhHxa90OgHTuPGxhIurWJVQPwd9/r76F9EXU9NDQ99061yNnAly+OQ5bHn01tWsh2yX06kBCHNsS+9M4rRTyo5H9KvFUE27BQokn0FXB1Rg5ALIPd2ks09M/qFT6BZv3CxdQdaiffFKVUG1PQQgNW1A7UkC+O1fzbfopAk0pU3yYHiwocbtgID8rgoEENhiGZp0PMv3IglsM9sKLGXzVz/NkM1Gz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wze4WWkbqr0wdTnBw3j7ZTrIDPapUqBYN10S0QOhBu0=;
 b=N2LIZrh8t+eYwLPoR+2OVdPoBrqRYxkkT85rQXT0vfWi/52U3d+yaYuUE0LV7f0uEz4nV4qv5voTFhn2y/uja/eiUjpXA4rjti8J9DANIrPSSL0GfOGHMNOQroEPmcaEZLPMX4fSRoe4reY3puIerLRzAMoTr86ZLsGv9gaCjjM=
Received: from SJ0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:a03:2ef::31)
 by DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 08:20:32 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::d0) by SJ0PR03CA0206.outlook.office365.com
 (2603:10b6:a03:2ef::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Tue,
 2 Dec 2025 08:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 08:20:32 +0000
Received: from jenkins-joe.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 02:20:30 -0600
From: Jinzhou Su <jinzhou.su@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <stanley.yang@amd.com>, <tao.zhou1@amd.com>,
 <yipeng.chai@amd.com>, Jinzhou Su <jinzhou.su@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add address check for uniras
Date: Tue, 2 Dec 2025 16:20:05 +0800
Message-ID: <20251202082005.1184954-2-jinzhou.su@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202082005.1184954-1-jinzhou.su@amd.com>
References: <20251202082005.1184954-1-jinzhou.su@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|DS7PR12MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc2c634-6366-4ce3-bffe-08de317ba937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mCdaH4/Bvhag2A/K02vD/dgUk8ZJyutpAeAAbtXslh8ItkVfa82ndROeiw6o?=
 =?us-ascii?Q?JN5tFf/ixK/K2g2SttrCAvvRLnhIWKFXjCc/JrEp1D/kV+Dd0ArF6HARuQOy?=
 =?us-ascii?Q?czzO1wnu4ew+9a61BFAL/46ClsMfLu0l+BBTyQGC+0vx9DZfOu0RUH5BcTLG?=
 =?us-ascii?Q?xWO98OR7495lXr65tAORCUEWFeKaellSJA5w9d5oiLfyK+IMcOky/3xwqhau?=
 =?us-ascii?Q?OwweVlIMf+vvWSgv/ugpwnLh++yQmF5jT1uhwhldpxA3jETJKiQZ5t5fbZd5?=
 =?us-ascii?Q?9ttxoG5Y2zniRb+M8poB4iq4NEQjPjrHITFZVxEGcxnvtdm6zoAg6Srm0NUO?=
 =?us-ascii?Q?67Nxz15BrwMh7uFG4N7t+4LIJASEMaI3sjCNzbbPBYl9iivNzjEo3lqPn9UW?=
 =?us-ascii?Q?0KnQ9MNqm233KfeqT1KqJMThr/c8CDMmuq9mjzdhjacVXvVFDxbt1idC0S75?=
 =?us-ascii?Q?XrYQLQZHKlBexzUfZEIqnw/v78cyHBVqlofist5cnVxajDYlaf5ZU/gCpMs2?=
 =?us-ascii?Q?iT5H5IDTSeG5q+3YTTtFFme6pTDOXZUiR6aNnW4ryA+Awr1YIIcjg6tRgOgV?=
 =?us-ascii?Q?k27G0wEpTu8qcJRTeOYJSvOh4HckW3TBX1Ynao35aGbtJq9wfJrzdpBneI/l?=
 =?us-ascii?Q?foOdzpGlByyZp7XL+m1YPF/e67eZGDXBn8rqzNI3ok81HCHGHfRshPQerV6y?=
 =?us-ascii?Q?eSQ8KrNZfnbg2DAGKTgRo3eC0bUUItyEQ4ti326J1E9HiWu/QSlcF8DKA2ar?=
 =?us-ascii?Q?Z7LTyDuwtS6l+8gkNwfEfo0lYfTJPokly3dVItk7Aaqdbh+VkmLPJY32Tnv5?=
 =?us-ascii?Q?R1blHlCaHBPkcY0S/GYGRDy7oW0SBua6mDmsCj6dQhaoPyBwIHXkItFE4JRb?=
 =?us-ascii?Q?Yz7/soAHeogDCGLSSnJ0jDoHqr5MP5L3HQZsu+/IE8fhhz12gi7hDJXZKvPa?=
 =?us-ascii?Q?K6E5aGhZWt2ojD0CSvuIgUMaqNaCHm5n/r3na6n/vhOXTOF8ASYCOiPqBC9j?=
 =?us-ascii?Q?LHQHHMdzjXWA79tVfGvSqwioDdx3eLyQN3HCJfeQIC0g8SpOW+pO67c9DVX/?=
 =?us-ascii?Q?c4qo0SI58qPB/xscL8bqbgn6s7WZmRtI/aeO70iMxpMC+2k473QfePL05Yoq?=
 =?us-ascii?Q?Q9pdv5ZHfAlgcamqyos2gmG9tVbiqRDfXsz4ns1KN1yP1Q/LsmT2tocX/2ap?=
 =?us-ascii?Q?r+Pw3wIbXVExPJLt1nBHVmPl9k9Z1WPuKCnf2+lG1SdEg9l0WakTOXz8tHFR?=
 =?us-ascii?Q?TV6byNNrQjtUVOLeOl9IInOfCeGkEA/s3glLRdKLYnir8hZXd68GJYSmUY60?=
 =?us-ascii?Q?ruS2Kov9XgStWHDIBhOADG+ij81XMBh3X/kK4VyXM+yqyuhtcX75spZrZsJK?=
 =?us-ascii?Q?nl4o5mdyWt6SDjl5rGC6we2Yv/Ly//Zt5G+uv/lq5Gmr9wONfE+KXCTFLAKW?=
 =?us-ascii?Q?jqVv0SJo+fvdLfUGPDCN9B1cBpUuYMQPj793aHQ6n48qGJyb0Ni8znPrzRe8?=
 =?us-ascii?Q?FEkALXs/IZeyFzFAlBpQ0JEka2pjZqt8wRRS8P9jqoYVkY31hnkXPpi+ag?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 08:20:32.1585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc2c634-6366-4ce3-bffe-08de317ba937
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081
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

Add address check for uniras

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 97eece7d8504..3271bbf75cd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -237,8 +237,13 @@ static int amdgpu_check_address_validity(struct amdgpu_device *adev,
 	    (address >= RAS_UMC_INJECT_ADDR_LIMIT))
 		return -EFAULT;
 
-	count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
+	if (amdgpu_uniras_enabled(adev))
+		count = amdgpu_ras_mgr_lookup_bad_pages_in_a_row(adev, address,
+			page_pfns, ARRAY_SIZE(page_pfns));
+	else
+		count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
 				address, page_pfns, ARRAY_SIZE(page_pfns));
+
 	if (count <= 0)
 		return -EPERM;
 
-- 
2.43.0

