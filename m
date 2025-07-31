Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A49C87FCA
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 07:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D936E10E70E;
	Thu, 31 Jul 2025 07:19:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l+j0lcPP";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF19610E70E
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 07:19:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsI5s7ET4hjUEXDee1dCWVhpHKM9Ovw1yd9PDY5kCXe+JJP5xzkjm4djYrXSOVVDD3rIgiajBfgJ/UctWfCQciy0nFDegrFIhQs7QgK1pvwETfdK1roeRDV/t6FEmc50S99UZe/tqlnyRQFIN/JUcFiv8AtWnJo0M10WZJDvC70J4wvS1balYnuGUUcXL4b+VuU3in6ypO8gzy0LGq3hYpXqpP4Q9QrdrWWAFNrfc3P266myy8i0SZm+49tIHtFeEXaW5HWZKFPcdsfe6kjCMUyY1Kfzx21RqYOuYmkclET/jcc8w5Moof0yDK6uIYCBhlZj1drvnTdk8X4SbZhdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkZ+58+PRqJzaoqY7EQ3Io+vKj4POBUDqYX5GcjKHtE=;
 b=TJSbVtSbwV4IURw10PzScoZ4O4vuZBYGJB7+pUgVsUXgC92tyK7Qzq4gjSwVq90P+JD9HZhU4ykAtcxj+DTWdl9vm23lNv6CipF80iAmZtLCFqZU4zBthrB/yqphtNpL3YtGKJjpqBamCbrEoZawEKSKg6koI/cMPMF65JyXC+C1eWt+qXZBz028qxY/AJRzK7aIHB1r52qy0pXurPqPUq8ZzFQ+/0H+R7jNLeizFpFUNPHdTj1q5xENyEsrLwtmn65d/p4EVvX4bulrxrlZj19Ospod1MSXPGQvPUSb1Bt6RgDnKQVgCRdKfRLGRsAo8F4e92tM7Up5MKeWQMtGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkZ+58+PRqJzaoqY7EQ3Io+vKj4POBUDqYX5GcjKHtE=;
 b=l+j0lcPP+kt66Xu/gPpACMv3ELAKP/6UOALg5yvL4GmWQjn1MyfK+wwk3+SbIOSf86cUtsuJVU15UZyi+ALr8moeIifNagDO8QeLc3oNzFgME7gjWTYp9Q3qrxI+M6v9iPmbe800LqXtzwoFRMw4D4IKNRuMJ0UlwEgAeq6mDE8=
Received: from BY3PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:39a::21)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 07:19:00 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::62) by BY3PR03CA0016.outlook.office365.com
 (2603:10b6:a03:39a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Thu,
 31 Jul 2025 07:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Thu, 31 Jul 2025 07:18:59 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 02:18:55 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Stanley.Yang@amd.com>, Xiang Liu
 <xiang.liu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Fix vcn v4.0.3 poison irq call trace on sriov
 guest
Date: Thu, 31 Jul 2025 15:18:37 +0800
Message-ID: <20250731071837.77141-2-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250731071837.77141-1-xiang.liu@amd.com>
References: <20250731071837.77141-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2db195-ac11-4e01-ea1c-08ddd0028525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y+QbD/bSXqMoXaDyVgsNT2tQSFeQYD7Dsi4NwEKXknEthrLlhV262vWqtNjd?=
 =?us-ascii?Q?b2fqWj/HnvU0aBA0e78qVNTnNslypw1MOs9CR+mWFt4lEMo1AWC2sWKhQil/?=
 =?us-ascii?Q?m1YXHhH1vuO+0d5rOwtjBSTXNqogHT6beRTkk23T5ajHu2ZeA9Q0vt6pDg/p?=
 =?us-ascii?Q?JDMmMgKmC+m6cDH26HUqYl80WlqrXIutZckTPGZUBJpiH5sstMipEkFQbUbF?=
 =?us-ascii?Q?9oqsXzXPBgx2FQMPer+9PlsjmBMDToOB/RxGKMMUFQQsQQLDgOYbdb3RzJNR?=
 =?us-ascii?Q?zzGeCp3EsqF/VyiPKkuJlejggWWXkPqHLcpbu92pUBb+WRfd56axuY2FMvxC?=
 =?us-ascii?Q?8vGtI2gV1l4VtSGk4gZc/mvK7SZ212tNyCkUkc7Ry8rIYesNYpinnjJz+EI2?=
 =?us-ascii?Q?BiTWjAlTsqzfvnHlYVw9MUbwZ0Mms+544hDEzvQJ78stSSeJCpZ7ZR59MFch?=
 =?us-ascii?Q?fWM+5uIdX6oDzpIW6eahlh3asJMC6Sglc6qtxQhCXJz7h/08CFsJyz1uPjbn?=
 =?us-ascii?Q?tEiJHWhTCs+eEfRHy/ZKZ2EkQVKGrlxcoIn66lkZpJMd+Bv88PAk8a4tgeM+?=
 =?us-ascii?Q?4g8g76yXSL9bJosst5ixW8UwWJbpwd4eq2FbL1+6DOtLsT0im9cJKCw0lDcJ?=
 =?us-ascii?Q?ONqtSOONIVpuGpVRZBAuUDtvghbel7k3csGORZ37/JQPt6lgBS4B85M4pyfz?=
 =?us-ascii?Q?doghF0UEKncQHAWy4YJYUv5mJHt4K//XsXVwPdztbPK+Tn2w/9z8cRbGCVVo?=
 =?us-ascii?Q?mOoUK0wETwMqMlZKt5BDH4IRRyp+K/mscs3cbJgv9URUXJXW3Ma0Q3DHO88/?=
 =?us-ascii?Q?CnoaPJKzPqU1xKQvwvz/qaaWLfQDozzNUjZ5D2dl7hLVCd+HDI/exr1bpmtm?=
 =?us-ascii?Q?trKLCEiZYw+/IOHBRAFW3dxr+gQz4DsjIja264nuLnx41ZR3Hs7VzsfsNqAf?=
 =?us-ascii?Q?IIAVX012Ntt9KbvPHGbOLtod21/lzQeuNp9gdMUVt3x8vEEl3dVK26tOR5xq?=
 =?us-ascii?Q?JTroqE186G+myEK3QVbhUbdgJMki8+i8Wmt6KzYk3jD/G9itIjkF3z9Ljrsr?=
 =?us-ascii?Q?u+sg3+mN4vEte43aVjKpnGMXtLxMf9N+LNwqfAP+yrF+g9wwEHcsoWEZ04DR?=
 =?us-ascii?Q?tOo5aY/toeubZGpwPL5W1g/8s8hA5utGyYufru8u5jyUN4ZQ5Ahi++IRAm2H?=
 =?us-ascii?Q?KFmB1cwob8CFQv0yxt7XWmpBnS5UDIqG4yaDnnGVHjm0HVvPcMZnqH3fh9R7?=
 =?us-ascii?Q?vkeSO29eRCZVQw76FvVN0hXIVoJ3JFJdZshKafqYZn5P2dReFpJpuGaK2Er0?=
 =?us-ascii?Q?JdMrbq2acu66g8EZQl4uizi7XmlUW2pxZKxagsqa/FJbmPa3mpHPxM4wId35?=
 =?us-ascii?Q?KXFk843V6wkC269OVrrn5NlkqpYIEoZBlro1bLPZJ5GKhhu5NtcDZsEl8AWg?=
 =?us-ascii?Q?kU2VJg7YNioJc9hQlKu+RBIEFXER/WRqTA15XxzZjL5ziujRatsNPl3HBvwY?=
 =?us-ascii?Q?NTZQJ13sS7x08tbrO/9IIV5PBRM/ig+XnHZp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 07:18:59.7505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2db195-ac11-4e01-ea1c-08ddd0028525
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573
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

Sriov guest side doesn't init ras feature hence the poison irq shouldn't
be put during hw fini.

Fixes: d260e486d34d ("drm/amdgpu: Register aqua vanjaram vcn poison irq")

[25209.468816] Call Trace:
[25209.468817]  <TASK>
[25209.468818]  ? srso_alias_return_thunk+0x5/0x7f
[25209.468820]  ? show_trace_log_lvl+0x28e/0x2ea
[25209.468822]  ? show_trace_log_lvl+0x28e/0x2ea
[25209.468825]  ? vcn_v4_0_3_hw_fini+0xaf/0xe0 [amdgpu]
[25209.468936]  ? show_regs.part.0+0x23/0x29
[25209.468939]  ? show_regs.cold+0x8/0xd
[25209.468940]  ? amdgpu_irq_put+0x9e/0xc0 [amdgpu]
[25209.469038]  ? __warn+0x8c/0x100
[25209.469040]  ? amdgpu_irq_put+0x9e/0xc0 [amdgpu]
[25209.469135]  ? report_bug+0xa4/0xd0
[25209.469138]  ? handle_bug+0x39/0x90
[25209.469140]  ? exc_invalid_op+0x19/0x70
[25209.469142]  ? asm_exc_invalid_op+0x1b/0x20
[25209.469146]  ? amdgpu_irq_put+0x9e/0xc0 [amdgpu]
[25209.469241]  vcn_v4_0_3_hw_fini+0xaf/0xe0 [amdgpu]
[25209.469343]  amdgpu_ip_block_hw_fini+0x34/0x61 [amdgpu]
[25209.469511]  amdgpu_device_fini_hw+0x3b3/0x467 [amdgpu]

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index c51dc401226a..c6450ed65c12 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -384,7 +384,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
 
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN) && !amdgpu_sriov_vf(adev))
 		amdgpu_irq_put(adev, &adev->vcn.inst->ras_poison_irq, 0);
 
 	return 0;
-- 
2.34.1

