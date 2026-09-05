Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27564C624D3
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 10:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5227810E281;
	Sat,  5 Sep 2026 10:06:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RPTSSJ49";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD2B510E281
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 10:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwsWQOVglLPM0/7x4fTkPRB6FAYs3tmtsEYnzfWUAuxQmx4wpYmv2eqN5wuZHC6gDO+xkY1RDlDKwbbSRTrSXCLQYrWQZxzxaThualF0cZfsa1vsiokaTz9L2PDoqXQQmmulx4jh5ITfbp9O3XfkITcIPfV60FeBq+QfR0cD6gh82iFQDEyPnh6Vcx33InLybSQLEExtaFYeVOcYYCI1z5LJK+wyrWlZdIoecN+HnMpfGAeS/Wu7Qyd4rdLg9t2DEuTQI94WOFgXvP3DSNt0dj7DAh33KFENcWV7yaxPa0DOb072e3WOl/JF6Q7Sz2PziCGN5f+FXmCheqdaMTDhVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnYUPw7xdWoOPpPxrpUPw7pI0qydTj46Jm74P7HIurU=;
 b=YA4dmfuJ76u4AuIMJTCHou+GVBWJNFOzXnS6AZL0e2AJV03zzuwaStsU8glTprDBHmZ+d7zitblxAzFUaQD0U0JDlEcUJoDtRFHADMWN55Vyd0MJ6mAZoY+8BNbzVvwsBZEuYAUAurdkyh0ndmzFVzkBp0LNssXQqAgAS27MZ6mxug8cClzDFgPtshhRZxbYSrEvpnbxMS7CnUQDFpmLg1fzzrxTdX0B0OBe9AzKjNnOCP2/8MvUOPlwwbAg9Utky05t6+vE5++upYtBmUtX9uNUyAXhf2m78dXz4h/rTQIsxqbAZb6wBvBBUFDw6wEcXFrZ08lJRe8qW8O0irz4eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnYUPw7xdWoOPpPxrpUPw7pI0qydTj46Jm74P7HIurU=;
 b=RPTSSJ49JVXRjRi7rkh8fyPrpDlpy+Q41/MRnJRuz/f3Co2FgpNGeFTU7+Qgby1bGOINiMU0TnNwhhFVEfR7SnaB4tS3AWC3uIPm9BtZuxEbH1Y49nO9wook3mOeJYGszMjvVMUobL+cFIWse4eOL8BsHLnN8iylPXNl62shJWc=
Received: from DS1PR02CA0024.namprd02.prod.outlook.com (2603:10b6:8:44a::10)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 10:05:57 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:8:44a:cafe::80) by DS1PR02CA0024.outlook.office365.com
 (2603:10b6:8:44a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 10:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 10:05:57 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 05:05:55 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 00/13] drm/amdgpu: Simplify nbio doorbell range programming
Date: Sat, 5 Sep 2026 18:05:25 +0800
Message-ID: <20260905100538.12877-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b508fe-79c6-44ea-bad4-08df0b35478e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: v3nVBWHasGMyRbh2ijXA/SsZkFc8Na5Va/5nD30EckFw0q+ea5ZLddzc1yLYx0A2iBQktPTccD/CZXgeZs8iskIjpyAYg5+HNJr5CuGZQk2IUw5tJ+tsfDyVlOWcKkU1/xCcWYbRkeXxqdip/OB8epL3WRulk4xSxXRWGdyV9q4byr7SlwTpwz1MzCHIVBWwnXZry/wjrOazSl3a5kp1bEMQrXa4r4viXBBePWx2zWU2Ukpb5Rtiq1aF3nfToR57EkVVYYPguGfjz2n97//E9DBujhcIabOzCITk+H6/9ft8a+9WIx+ICn7oagAWZBxFXevZXnBNGhYBAA9xjcudRQZSw7Z2T7kq72BI4M485a/yU1ethjn1vemIdNuSdRAFQXUkrcSsGKkw5OgceXfOKtfhvOX1s1bE6n12m9/T4JaeBCfWorwwg5IpLygYZrj47gy6Yhsem47d/IsaH//zhlkqrWogD0vTYXo/ez95yrANV6FQ1jPE9v6E7K44V7tmf/Ejr+H/N94X6OL8DksA2sBiKXsIZqK1rye4asZR7O+5ZRQJP3v7X2XoRU3sI+b35tvZ9k89AXtNnZLQ9TmKBZ2zAhrdy4L1Sdazzxt/WahelQQWQ388ZNL3ugk4L+eAYDqWQ/hMPbymFhQHRjF/elTGLxvVXToJyOgv85FelBTn1lPKIJ1qvdplzHMERZReYk6ZdMBMDQ23ns6WV+Vr1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WdWJry7pzLRNGlqlLIXxzrh1fmwK6V9eNCMTib8rB6jpcFzmmZ9iXaQp4G5JzFQIHhmE8BGmSkUA/5LYakxvxBHeqTW46s75s00qDBzb26nWe+gipZX6PN+6TFuIGCNDMSRvTNuBUD+RYSAo0JIfsyZb44cugLA8CcEu7RUpG2xKKfWQPrh8vlAbNAq8SzcZz+csCa5DOzxUVigVKZcQn7kRG7Zn2bQfpVFpEF/uV/24jyxqdWtjpPk8Zowh5UpxLnSh4XlXDuQrO+hEQd8hXlFxmtVdB4iCY3QmAnZ5kB7y7AYAp+m+K9SFWNhtSuOfhPH+77RSVRJvKxkqmKXY1jvT6pcMPqvm5c3QpgvDWNDUTsKKgfTCJl3mmoGcCZ/5cXHt9oPiEAdq7VVd367FIzGHtHew+fxJhBVQcu5Y3vXkusQ4r7dRQ6adVRk+wELY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:05:57.1127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b508fe-79c6-44ea-bad4-08df0b35478e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
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

Introduce common nbio helpers to build s2a doorbell entry values from
per-generation field layouts and program them through either mmio or
global SMN addresses.

Convert the nbio v4_3, v6_3_1, v6_3_2, v7_9, v7_11_4, v7_11_5 implementations

This removes duplicated register-field construction and access logic from
the individual IP implementations. Future NBIO generations using the same
s2a programming model can provide their field layout and client-to-port
mapping while reusing the common validation and programming paths.

Hawking Zhang (13):
  drm/amdgpu: Add common NBIO doorbell entry helpers
  drm/amdgpu: Add nbio v6_3_2 doorbell layout
  drm/amdgpu: Use common doorbell helpers in nbio v6_3_2
  drm/amdgpu: Add nbio v4_3 doorbell layout
  drm/amdgpu: Use common doorbell helpers in nbio v4_3
  drm/amdgpu: Support doorbell range programming through smn
  drm/amdgpu: Use common doorbell helpers in nbio v7_9
  drm/amdgpu: Use common doorbell helpers in nbio v7_11_5
  drm/amdgpu: Add nbif v4_10_0 ip headers
  drm/amdgpu: Add nbio v7_11_4 support
  drm/amdgpu: Drop nbio v7_11_x support from nbif v6_3_1
  drm/amdgpu: Use common doorbell helpers in nbio v7_11_4
  drm/amdgpu: Use common doorbell helpers in nbif v6_3_1

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c      | 150 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |  88 +++
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c      | 384 ++++++------
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c        | 265 +++++---
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c      | 324 +++++-----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.c     | 452 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.h     |  32 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c     | 256 +++++---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        | 377 ++++++------
 .../asic_reg/nbif/nbif_4_10_0_offset.h        | 103 ++++
 .../asic_reg/nbif/nbif_4_10_0_sh_mask.h       | 573 ++++++++++++++++++
 13 files changed, 2307 insertions(+), 706 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_4_10_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_4_10_0_sh_mask.h

-- 
2.17.1
