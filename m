Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC1AC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 15:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F481113459;
	Tue, 23 Apr 2024 15:29:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zN3SWzuz";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 735D4113459
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 15:29:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzPldoUQsKZdHQg5bzM/fpCk3J+Woy8DLXD6ie48A52+xNJinqbL4XWiWsXv5eje7+lZ1+lBzZqRKfv9Sm1YLEHhPcr8mBcVQJAQqd2/Srfk678cQkPWpnllL6r6KTTNr849/4F5kWKoxdBkmFNFf1hiafEbVuIRXU+j8TvX/S/1CK4nHWKjQLfSek+iqqgn1e0etKUqoTZk9WdwiJVwpd4rim70MWzTcdXA8ttmZ4CzcCgj0C38Dm/wCmo41b4wDiX7deJ5eh06d0xx3WtADYvNaZLPTnrM07I0hVcewue0GBpxMuQ9K6VK6vosT43fB5iSCaPk3rnDtuMbUVeiUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihOHjrIX6J7gtqiEtbuyb+wURe+2oQhDrzT/T9fjFkg=;
 b=aKl6zLkFFeKIAlFXJ/9nBP6z5A3mSW1hdKHo3iOYRIr5UroNuuuB6FvM/NP25nRSRi2k94X7XSfgH+HVYh1eQyZ5gnYIx0LQsKAGmIs83sL5RJd/GvUMkB4Xl9cSkNzbsCmeRUburHc5Z7Gzkjxaf4OUukd6Unam813cEkXFTPqv5VlwxI9Pt8YO2Nahzghs49UWWkKP31mNRTr2XD9SaVWH4HXeR7xrLzhqzFfufNKej/sxqBZvg6ptDFjXJuHkwC4OBxq77O3c8JXOgeZBNDdRD5R9+2b9zgcbEFMyGZBUWK3LFhDeZ9h4alvWUfzmkOTEAmPBmARIbK6FuwwSeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihOHjrIX6J7gtqiEtbuyb+wURe+2oQhDrzT/T9fjFkg=;
 b=zN3SWzuzf3gLoP1J/qzNYoKbLXPlSFx5umRMQ7mS0jx/yPpvdudbQt+PjukHX2hDPew1FERQzflYxeUnMMdfpC7PUcaxmGxHMhQoZSBkcxI4XqtrhN3ghWqV0HuV61JNC0kUBbDU8cdQVuwxX2Rg1jp+ZFqYEyKtbz9zyfZJHQo=
Received: from BYAPR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:40::20)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:29:36 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::e6) by BYAPR04CA0007.outlook.office365.com
 (2603:10b6:a03:40::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Tue, 23 Apr 2024 15:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 15:29:35 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 10:29:27 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v5 5/6] drm/amdkfd: Increase KFD bo restore wait time
Date: Tue, 23 Apr 2024 11:28:59 -0400
Message-ID: <20240423152900.533-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423152900.533-1-Philip.Yang@amd.com>
References: <20240423152900.533-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d07c0c9-edd8-4230-2578-08dc63aa2ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P6zs3/qDbSC3fJO/+t2N/FVYKCt3Ht0Pn5taRWnxvZ38vhYH84vBuOXwcJPV?=
 =?us-ascii?Q?oYwBt7GJ6/P6uoDyRen+j8b9a2N4RG+mYL8XbeWS1GfMlsL5EEr868MKgZG8?=
 =?us-ascii?Q?6HMAMNWSvYZh76oIPpuborWFCUaWTEZFa4S8JStF8H7FpOmUh0oHXZQDLHJw?=
 =?us-ascii?Q?+0lzCoFFoUt4aTjYtlUBma2GOEOt2kDF0kL4N4rWlvNKY0U6ZhXNkgQAWHiq?=
 =?us-ascii?Q?UtHi+nwvPTapnEHqnbjE+pDXWCYDbHQk1gf4lkSCDN3NiLipxhst/KG2QSgW?=
 =?us-ascii?Q?7ElL8mvxGUOMvHVPJ+TLKOOkY13qo7czTAtu69rEYNYTBKjHOMgtqQNmXOR6?=
 =?us-ascii?Q?KcRE4ycvMrDgHl7Y3jsGdXz3P55v9yKDjYOHLvKuobYBjgs/3sTmE0ZxCuPm?=
 =?us-ascii?Q?Kv0druidhtnyKAUdg0Bak0HfZe/ns6nFvvZ7kW1B23LEfYhpV3/DE6GEMqxi?=
 =?us-ascii?Q?2Lq3+VEA+wTKUe3oVu2Zbc5ztjPOH52oQhLGaUTvwVq1nkhgwGYivkIbUHjn?=
 =?us-ascii?Q?D0vrEpo66CmAmJbCofE8KgiK2JD3lhXfJzw0uJSO29JO9H6Yy+yqCNifc9qn?=
 =?us-ascii?Q?mQoZgmiFYOhTRkSWFKJtKy6c2Fa/yCeBwgAuQr5aUyyRnDu3KMOQYUU/UATB?=
 =?us-ascii?Q?jkaiOlmWpheqQ59Lf/fFFUmX8hBtwJ/wzarlBgSWptu22VIdwrJEVhYBuQ9+?=
 =?us-ascii?Q?yiR+CJo8rEukGFq8STMEcFkpqTtcoQjFOVi886oOVlXBz4KYkBH1/aHiqGpu?=
 =?us-ascii?Q?lqSch8CGKm6UJ903i+obh6Z0UEN9cnk6H+f9UfkY0FdzuTQje7FliQ2w82Cw?=
 =?us-ascii?Q?jzB9vSHFyoJPKdot8oDy6yDD33YSIo0UN9F6y7l4gkddKBrKUahfGq/1gYdd?=
 =?us-ascii?Q?OV5VGvGGU+YzUDmrRWQ2er0vS3VLCqkoswg1JH0uGQWMU245Bvoc/3kfgkLi?=
 =?us-ascii?Q?P+3Teyy1ZQjlAaVxtMuL7qy29VvG854KpXevPhEORZheSu6FLZtLuqiI60bz?=
 =?us-ascii?Q?KcXvXJf4881SBziTh9qMGr7/fP/QN4rzieOOdLTFWbi+3d6Bko1y7PJEO9/t?=
 =?us-ascii?Q?HZ8gQuRk6IINXzAJh5NC6x81jv6U+tnM+Z3/fwE1ngGak9W5+7s6ifCAm+ei?=
 =?us-ascii?Q?h60A/35jbYtwXg+757Dh5FG70808rsZGw8/V531oc7vWAIZBmqWIiH2I9J0x?=
 =?us-ascii?Q?RkS4rtsHLRWwme4+8FT7oHB8HV4szo2WBh88Fgt2hCELhc5N4I2+Kpey44jv?=
 =?us-ascii?Q?16t8cCrZwFaRsjF3rERtHd86Ay1r/KjyjWfQJnb0EXbdC8o213t5fkeNwcNN?=
 =?us-ascii?Q?1EoBeg9MLq7MrC6Q1NIRa5gfRD52WD+8YanB5vxN+iA+pehYKRSRvqGFFUqs?=
 =?us-ascii?Q?HOEZspiHvt5w4Ve4oCCPL7iwHsSg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 15:29:35.6592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d07c0c9-edd8-4230-2578-08dc63aa2ea6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328
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

TTM allocate contiguous VRAM may takes more than 1 second to evict BOs
for larger size RDMA buffer. Because KFD restore bo worker reserves all
KFD BOs, then TTM cannot hold the remainning KFD BOs lock to evict them,
this causes TTM failed to alloc contiguous VRAM.

Increase the KFD restore BO wait time to 2 seconds, long enough for RDMA
pin BO to alloc the contiguous VRAM.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a81ef232fdef..c205e2d3acf9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -698,7 +698,7 @@ struct qcm_process_device {
 /* KFD Memory Eviction */
 
 /* Approx. wait time before attempting to restore evicted BOs */
-#define PROCESS_RESTORE_TIME_MS 100
+#define PROCESS_RESTORE_TIME_MS 2000
 /* Approx. back off time if restore fails due to lack of memory */
 #define PROCESS_BACK_OFF_TIME_MS 100
 /* Approx. time before evicting the process again */
-- 
2.43.2

