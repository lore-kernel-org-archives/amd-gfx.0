Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E9EC4829E
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 17:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9FD10EE71;
	Mon, 12 Feb 2024 17:59:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bwRXKC2e";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D82110EE41
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 17:59:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9fTZh7lj0qnqTiwwrosyRYBulq9l6ZJ3mRfTLjcfhMw1DosW7SjRFCj1e+mnlI8wkxwZnGd1NDJO2bAP07J4nS/j+e8iXbJwfm7nTnnrKlC/SHvgpzu7rzM49GE1d1k6TfWT3ndRqXRg+owbkXMnNTto7QEDcmtrqvOJPy9LtY2eeuYvZsvC1vBA9V7SN4k4zmmC/Nv6l+iiS+JuDcJIp1mapTFKB0b64Fd7ekHPCNIXq+NTPuYc84IFOrtLavA97hTl0D0MIXpZMHSP+WoBAfhZyAJoSBMyETjiLP60jN8Po0w5pR/iscH45G2LbS4mrRU0tp+8UeWrzaATQlmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6OgAyqLw24t/97xD1ockVyx0WYArPo2/6Ru5wHhp68=;
 b=kyYcUud1N3sWYI8so1uVhVwntgEPdYSQsfRFtIXebgSZrIHjkUYS+tkGFd9h2okKiUu+eaQBaaYscJYICQYcPOBZMjp4e0but4TUem0l/fhjYtejYEA806rfP+FZc+6Q9/s31uvAKLbMZ1wjm3psu+MC7bjW1wxZd7z6pWZDPFQSPJ/MlIseMlAveYcLjw0pJkQcOn6aULPjCkBg/diHcxhVMVuWaKDaQFJT4Dir0MftH5oJqjEpLNdfgQ/2ZG9mHWno3jzcYyiUpVwOlFHd1ky8PlXUi3xyqlrSBNNlB1c0tmuuH2/l59JhjEEoDh41pGwMPpYhyfw51rpmPM0yeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6OgAyqLw24t/97xD1ockVyx0WYArPo2/6Ru5wHhp68=;
 b=bwRXKC2eBRxI9Zr7T3pB/0hNfIgaJYNVFJDaTvH27tQniee3UpOWlxsieiRDdRpUpPPudN1iraQdf+gvRlr9iAjKVclSmrmtuxJNMRZYAkbkGUKbIayxKZLT5BWmo34eh7iqxUqesxkEIefe3xQdO4sUsQpyFAMGz/LE7eA0SKs=
Received: from DM6PR06CA0057.namprd06.prod.outlook.com (2603:10b6:5:54::34) by
 MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.21; Mon, 12 Feb 2024 17:59:04 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::38) by DM6PR06CA0057.outlook.office365.com
 (2603:10b6:5:54::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38 via Frontend
 Transport; Mon, 12 Feb 2024 17:59:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 17:59:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 11:59:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/9] PSP 14.0 support
Date: Mon, 12 Feb 2024 12:58:41 -0500
Message-ID: <20240212175849.433812-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 45640035-4253-4e14-f0a4-08dc2bf44d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dNRrZxXpK3ivC8cGuHcuu7c5Roxvd7j9eJp6AXQ5mtilwAXG/agO7E+VmBOsEplVWEf3Ox2RXnV1ULt1NLUyKU9lzb2EeZU0ymW9MpOkAzLl3vCJRoLNm2KsefxVMFIGnBmVS4MBX3sMpb6UnAgN07tYynpnPBabe3uzcbsV+uPZUFYb0pus8jn8WXH9DuMhnocqJeAfQ22dGkR436cfQOT3bsJREi20ssQIw13ERJZm9FJ8ReDdmaSe6tJgEl1gZdfy40f1lFoIUIj9X7REVIPo4XLRjVsBodOt6Hvk+MOfFuHrYi33XlpvM7557nLXLgO/jX6xkSeSSkljmk2H6/Vzai75tfYSRoLqhA08sn3CaO/vS/nfGLITD9wufH1SxAiaUpaL5BsxdtWITiTx8ugF8f+ix1kYPm+NjB0sUSqVwpfeHLSyzg42+Sxs+yZQsU6noKgu5yWtSBE8WlGVN+0NaYENkYr3gsvUvMnk3T05I4GEWcpu4xpjIwebABA8fffBDefcvBKDt79wOWWuP4XeE8FC0eXsA4F7E90l+ziFwG0PX14ZPjH6f9WHYrB64RlxMnDorGV5pzz9e6dbISDob7mz8yICAg/NPJ9WKzc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(478600001)(41300700001)(4326008)(8676002)(8936002)(5660300002)(2906002)(70206006)(7696005)(6666004)(316002)(6916009)(70586007)(2616005)(83380400001)(336012)(426003)(16526019)(81166007)(356005)(86362001)(1076003)(26005)(82740400003)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:59:04.6815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45640035-4253-4e14-f0a4-08dc2bf44d3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001
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

This set adds support for PSP 14.0.x.  PSP handles firmware
validation and various low level asic initialization.

The first patch adds register headers and is large so it has
been omitted.

Hawking Zhang (2):
  drm/amdgpu: Add mp v14_0_2 ip headers (v5)
  drm/amdgpu: Add psp v14_0 ip block support

Likun Gao (7):
  drm/amdgpu: use spirom update wait_for helper for psp v14
  drm/amdgpu: support psp ip block for psp v14
  drm/amdgpu/psp: set autoload support by default
  drm/amdgpu/psp: handle TMR type via flag
  drm/amdgpu/psp: set boot_time_tmr flag
  drm/amdgpu: add psp_timeout to limit PSP related operation
  drm/amdgpu: support psp ip block discovery for psp v14

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  55 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   3 +
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c        | 672 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.h        |  32 +
 .../include/asic_reg/mp/mp_14_0_2_offset.h    | 468 ++++++++++++
 .../include/asic_reg/mp/mp_14_0_2_sh_mask.h   | 692 ++++++++++++++++++
 9 files changed, 1907 insertions(+), 23 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v14_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_14_0_2_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_14_0_2_sh_mask.h

-- 
2.42.0

