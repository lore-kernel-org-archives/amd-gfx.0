Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC11C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 20:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A7B10F84F;
	Fri, 12 Apr 2024 20:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oC2Owi/N";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B8010F851
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 20:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/dWwFOjsdzav4snEiaz/Y+9U0VJLdQK1M2mWejI/ZX9f3rtzyvPDABv3OG36VLTDa5hltlJrvfzMIoxGER5AqUccY7bmJd45iGBxoYDuVTG6btmfphn+sqBNjmuG2oiC4y1mG9D6nOWjy+wc1Op5lyubkalmzU0JchL9KbTXfzuXP4PTZfHw0s8K4W+RBqvghUFJG3iXCXA3zrIrvjMm32K3E+Pphxq88sfCDGZFtEE7jXYNa6XkVkfa6hj77TwH0SZIFdCVr0YHyiFiTO9aZSRvKi5UoQR68epHlA5eKD3Z4TjM5TPy31i5wNOGDRXxNYypZOYRqxLhrkJplfEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHeH5v/BfvbWUywyd1Irv2fzuXiKXtF/VG3+Ikd6htw=;
 b=B+Sh+O9dmIUSsqu/d+BfukLKq+B59nPaq3SxoNigHp6VDE0krtDClDKpvR010l1D+6eFW+K4Nh6erEX9NyllqgK/ag9CPsaIiKMPPqeXSh+Z0HLQazrN06zgTvNAzWWyLlhugizQBR8aL83FrTWivYVvjAZz6eEW9PvgccdymuDfu/vMFSr67Hrz/VSZfNiHNKu1T+dl+PsqshuXsf4gJAcqoYGUXq7lkDiMjW0msrct01yuh948Hb+RdTRu5pTR1CSjUILGU4ZTvw0U6wBZUk5ClSUbjlgWvqRgze4mfWdKib26P0jpR2Hl6KmM1e53W3pxE+dKadMAEmCZc9ZZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHeH5v/BfvbWUywyd1Irv2fzuXiKXtF/VG3+Ikd6htw=;
 b=oC2Owi/NIIiJAZSfKZIZBW09H/lOorlMdWc0+jugh5YQ2eTGq8bZzlYpUs4uXs+8eOHV6SHs6/kwWSDQkOGJc0tJmHG7se4lULxrL3sblYWIWuQ9gWzspms6yaq0sXslZdUstVTjwN85dG06Ell0ACjLG81NF8BghYjVQ4Kw0Nw=
Received: from BY5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:1d0::29)
 by MW6PR12MB9017.namprd12.prod.outlook.com (2603:10b6:303:23b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 20:13:47 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::dc) by BY5PR04CA0019.outlook.office365.com
 (2603:10b6:a03:1d0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 20:13:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 20:13:47 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 15:13:40 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 6/6] drm/amdkfd: Bump kfd version for contiguous VRAM
 allocation
Date: Fri, 12 Apr 2024 16:13:01 -0400
Message-ID: <20240412201301.14154-7-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240412201301.14154-1-Philip.Yang@amd.com>
References: <20240412201301.14154-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|MW6PR12MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa6673d-2a7b-4231-5266-08dc5b2d0fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4bzXRXV7dA4CbwABVSQ2CfF6wpQuxhIg/GP5vbKhxbRPnsZ85JSAeo3m52Xl9tf103g62WFiRVIJrYjJBZ/wRgPDzIeZXb6FdC6CXWTEJ66YVj1q97XZhOWHNnWy9jal42UBm8rV+u4bTpgY1ab4nd+8DIuknbMr4NOXKoMRUtOSoGK7toKLYXnEdRGMrn0+A7+SLiDyujqNEThcDMKDiPH1F7BmI02bNCLDTkPsxktstjhXIAKBRqnTWXaxHGH4loG5lgx+Xl8PaTTkIbsI1kOdUug/VuxVCO/Qkua7U6H5jc5dobLOsjYg+j26IPPtIxP+dUn0BwNW083ixlwRDDZoVxstAEkT4jfXeKLN0pdwkRXwnMacy8XO6AzaOeiJnRY5rLmwk7mZxhs23mX8M++iVWLPk30u1MHwWTH1ADnXGnIEikwuluHas30tZZ7w+nwu1KZMQDHOMQhxP3ug/NNutRVDiZEK0jIJFOKTzUKc1l9ew85RytzuH3K7Y5z726899/pHkal1iXmmOXMbBn0cGnnh3xWStXOpZZGdDGGkEd2nxV26W8NioDbOJrnK23XMh/yb8W/3ZSYuk90xupIx8D5wZVSLIHw5ouXER65icl5ZuMDqdZUXBMsNtIMfUPP9pnYJupy7BQXTzLK6HBDAaeR1AIybyjssza7G/EXKEA9k6PpvwRYZg3TJOdFjQx27ZO4x3bQiDUK4aSatX0hFyKoEm6mBWHfn9GZILFfGfmWJxQvziFLXx2PP8NJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 20:13:47.5328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa6673d-2a7b-4231-5266-08dc5b2d0fd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9017
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

Bump the kfd ioctl minor version to delcare the contiguous VRAM
allocation flag support.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index c1394c162d4e..a0af2ef696ea 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -41,9 +41,10 @@
  * - 1.13 - Add debugger API
  * - 1.14 - Update kfd_event_data
  * - 1.15 - Enable managing mappings in compute VMs with GEM_VA ioctl
+ * - 1.16 - Add contiguous VRAM allocation flag for RDMA
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 15
+#define KFD_IOCTL_MINOR_VERSION 16
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.43.2

