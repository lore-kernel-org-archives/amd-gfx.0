Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D10C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 20:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BDEE10E8C6;
	Mon, 18 Mar 2024 20:43:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lkfkFe0p";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E9810E5B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 20:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Thf9I+B9kPLB8Dt8fHlcDW99Fih1YCrnBhqwSLTjMYtC6EyKjvtfX4RMIm2djW23FO53RVJ332W9s0uqeAgR/cH+/B8cKmex8Ug/hjDylis6ZYzrBNzT5axKPo5Iq57/mNHUi9i95fAELK+jFPvAly75ULwWyqbp1xo9ZoHkFkgJw2FfYiH7/HE5gdsYghS/EvImKfUbSW/2ir5d/5792KBkxlvwz7OdseZzZdqz1KSALkFGLrHQv6pcabl71pRrW5KKGP9H21SzIzQp0GxzaPmnsEQpH8x5CJIBy/E5nxNxSdJSIKOQFm4pNBZHwHrh5mD8Of553AWzBheFby8KNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+NSxiCWHgDzEJHT1UhVxi+xePb4fx8hJM+3nzBgypw=;
 b=DDZicD/0lLdQ+FlN4bBo5xj/0j1bMTRN82v9hpeACvJwzjGgV2PYEbZkMs1jWpWZkjb7T3H6dmZ0GsE94gSnNvIdvoa+cXR4bnBlGmwpHYf5zhsCgho+xNNLh+a43AQBjgv2yBYujF7HzTozrrOrCK7HAoThP4pn8fqCeqT0/qu+e0LBRdABI1SsMUc0PJX0yzwx6T5KLY3OHvyOcamxzIc3M9kUYq1pMRUCW9Q3RNj9vZ4feUCb0MofEI22jt/UoNekBRjdLOF8YJtu0nzdo3qXVVq5mtsFNRnItrO/ODvwVVIf4rNLD8JqIlOfLtc3gtuzIStr1HC2SjWnBNn1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+NSxiCWHgDzEJHT1UhVxi+xePb4fx8hJM+3nzBgypw=;
 b=lkfkFe0pobkEk+Zb8JkLvuCrMNE7pEtY+wOWeHOgnuopb4uNRckkOQOgHmrcwGo9WkZWHNocc8YIOs0l6RFgXVsMzqS00CEHJNbdEY03akW9CJ24I3LEaai9t6tcf759R1r74CbkFdVYpJ9Kjvaxcnvsh0MbOtnwxTBROVlGq8k=
Received: from BN9PR03CA0212.namprd03.prod.outlook.com (2603:10b6:408:f8::7)
 by PH8PR12MB7134.namprd12.prod.outlook.com (2603:10b6:510:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 20:43:13 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::aa) by BN9PR03CA0212.outlook.office365.com
 (2603:10b6:408:f8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 20:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 20:43:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 15:43:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/4] Add SMUIO 14.0.2 support
Date: Mon, 18 Mar 2024 16:42:49 -0400
Message-ID: <20240318204252.144624-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|PH8PR12MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a33255-0e47-493b-82df-08dc478c0769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GmZirqUrfCVd9vjlI/T46aVtCJNvOAslldEvx63JiChgLu3LmxEpFHaYZ1bq28rKNaxtuwy2i1XvbNqfGNrWQ3Nk8WMQHaQJvEUTI8X5ESUCvLm+l5YaaZzz/fFtNWMNBDsbkzippDnm8kFjdyX029Kw8gAzvdOieksXYKmzFTWfPTVPTRM96cyBHA5qiIFswIAGE+9Bl236HxGBSYG4lioCUNbtaC/Sd1ErOoCTouISvrhIa6ziQvs2Y6nOnuCcPoFsWTFyyO7+oz44MnAQNQWnPB9jSAt/11YR1odK4mQhvgtPR6PrH/eKHdTBmvGHjR2ydMVsTPtoPY+qfHV4qrlKJFJ0duDocU1jFnMUcaqtebhM7D53TZOxBgEc0euquFLuZ378W19hlKXXqlmcnxB67VCQXVVRDZ7gAcvKOjCLUtYgZykJPH9ACf6tk9MQjz10+YZIKyGP5QSnPbegT9Y4e8UWmRAUrp+uy2IYXQil5IGdTPRYwTAK53kywInekatCz/xm0nlKEpMdXq5NW6EcBhJm/7fSrrB+7TZvYkV1NDXHppNReHiF7/Af6DJGdKeLsg2ja4/1efcSW8btIQy4o+4cfBg1ObwNRODewZT4VquKTiXo2hqR6BEJvO/E08vbgW0oNbY4M6AZhJNMTm7PipiBEAD1Koja8dHNaa7FXVX8pC0UBDLu8wRkalPLmA66oeCQEmOJ6xqmPCDYGewxLK2TeXxPUXAp3gGkGSj1mTUTGCk+KDgHh4Y+Vs2l
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 20:43:12.3866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a33255-0e47-493b-82df-08dc478c0769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7134
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

SMUIO is the IO subset of the SMU block.  It handles a variety
of functionality on the GPU including reading the ROM image and
accessing the GPU clock counter.  This adds support for SMUIO
14.0.2.

Note that patch 1 adds register headers and is very large so it
has been omitted.

Hawking Zhang (4):
  drm/amdgpu: Add smuio v14_0_2 ip headers (v4)
  drm/amdgpu: Add smuio v14_0_2 ip block support
  drm/amdgpu: Add smuio callback to get gpu clk counter
  drm/amdgpu: Enable smuio v14_0_2 callbacks

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h     |    1 +
 drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.c    |   62 +
 drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.h    |   30 +
 .../asic_reg/smuio/smuio_14_0_2_offset.h      |  511 ++++++++
 .../asic_reg/smuio/smuio_14_0_2_sh_mask.h     | 1106 +++++++++++++++++
 7 files changed, 1716 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_14_0_2_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_14_0_2_sh_mask.h

-- 
2.44.0

