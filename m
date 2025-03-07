Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD1AC282DE
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 15:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83BCF10EBC7;
	Fri,  7 Mar 2025 15:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5iDP5G6a";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D185D10EBC7
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 15:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKFYzY5mvICflJ2UoCchvPUpQUHxBMb7hr1YZK6EUKQAuue1wLZOWKK8ZBXyyBokjX4Rt/YeksSqCm5yBfLgP0FjEj3fwVXhaPCJK63gTCn+bBp/AIUoONMh9Dw19RAZ42vmW23NsEb7QK60aVSgFvNTQ6s86AIrtU1Fluc+M45wGQU56FMQw7ZeiMIVa/6HDsUOClYQeDWYQ6bCkDOdnkEogNtkQIFlrJW+CMaMZCg5Oyfz/oxdDxRVAWczkTsSVGQPEWjzdSYYBuDlPi3MU8pOt9HOPVsNpgRVF6ok6Su+xl1Wur0S4/pkhqKWKw17uoRe+SBHcssFNUt6zLpfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbaYU7IlE/GSP/bte0JFi/JOBCo3X4cyCNO1jtQdE6g=;
 b=EOTmZSPnKcl0vosqRP7mrjf2IDN/uUMVrAqM1E+XCGWVcalCZ9vdifrcN6X/6bFhbfgsARBorZfyl1gEdUATv/jiFpZxB5BdSESPhgcUQnTehxGERMc72Em5kht+PBr/6wbhnregdq/20CLbGU2/oKvhEYQ1x2UlrTieKSOW8ieyKQQPrGowrqfdoYMmo3LLmkjRpYe6ZLbRIu1rllcgGod8eGsVaSguS3D3a/2iORacQKl5Y/a42Xi7D6QJdHHD0Rtidu8fFcK2LUeEHbJwm+Xw2EnBAu7Itzd6ZvIHhonlNRIlpiy3qF0phGge+a1aWt1D698ZUYvIdIm6yrbL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbaYU7IlE/GSP/bte0JFi/JOBCo3X4cyCNO1jtQdE6g=;
 b=5iDP5G6arpGA4bTJLhCzlEWR8tSGDR2Lp9tjTOZsRhMZiyG5HtY91R8IBQpkFKh2Rj9GE24f7GnhBl/zudKbe+2FLTsQo/ayzmDNJgpHWL8ijgQCGDiuWwV/zLckjiWZtNT1ltd5Imp/v3I+veM80M7OFijALob8yqOG3KZXkPQ=
Received: from DS7PR07CA0003.namprd07.prod.outlook.com (2603:10b6:5:3af::11)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.23; Fri, 7 Mar
 2025 15:16:19 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::ec) by DS7PR07CA0003.outlook.office365.com
 (2603:10b6:5:3af::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 15:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 15:16:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 09:16:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V3 00/11] Add disable kernel queue support
Date: Fri, 7 Mar 2025 10:15:54 -0500
Message-ID: <20250307151605.946109-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 304fbbcc-ca0b-49a2-3280-08dd5d8b0317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Im+c2k4mthp/SrG+CNRFcLil3guDgE4aDZoZyWs6qI2BF002RuVIY61NUxdh?=
 =?us-ascii?Q?/sLWhAygEqVeYH+P+G59NRhVLHRZ3K+80fuiQNk1qFgqZzZYLPsxTY1XtUWx?=
 =?us-ascii?Q?dgbwmCnYl2qCk3nGqoVtjYFJo4O05YDltCPUtX1wYf8HIzIVrcSVpf4wsnkS?=
 =?us-ascii?Q?+gtoiLmK3CgJRukh80I9sA8eM47SZCNq8lzjJ0gUFn8p1QlgOPA4yGTqj+W3?=
 =?us-ascii?Q?rtRP8ca6cpgyCbCST9rRRrOWrGdbUYNeJUPid55INmrIKC3EfNM7U+JMaU8Q?=
 =?us-ascii?Q?byCTP+Pqf7e1F/rs+n6y1vyqMH39Pqp1ibzo9obvWWNBfKp1MmvUcwpV2Rup?=
 =?us-ascii?Q?NIM6TWeMBjaUvEWSyeeRy9tDHSRZNe6vaB02oJCeycezudjyN65AHeK37Qb3?=
 =?us-ascii?Q?agOInzJ2CVvw1toUGy7+/yqS0vDHYPoTespjQWZrxvHsc862EYG+rXJVvTkw?=
 =?us-ascii?Q?djp8NCBVHBm5UBpwVvwJvKPTwroDCJ8m5h6A+RE4EPbl263EAThEVir04q6G?=
 =?us-ascii?Q?dMtyd3jYaPwfdNGuhFVuw6khVJdonW3oRgHjC+mdYWIEL+56o2bnVM14cxw5?=
 =?us-ascii?Q?WlJDFqhYWBVl+Te/c90+gSHDnjuUp+6Q7tzoazZvCl+wiEkj4MfSKLXej1nO?=
 =?us-ascii?Q?r5zSzU3tcaT36ANv4uh5z93iBDMWVwAtRLtf1yDNROwfdAsuDkT8QC4S/DN8?=
 =?us-ascii?Q?sUWv1SOArCMXS1Ec7SGwmbWo5gCcYt7rwYv0PJUHkUdRxpcg6RYDLCHYt1ux?=
 =?us-ascii?Q?iyA70YEulOhAAWR/mAIZm5U/S3EnfGgAowBCuntVWqIUCzWADy/fIBFKoZ+b?=
 =?us-ascii?Q?mFfRYgwjahYs4Hnl0qMggZlO37IfGlWRfXan45ehHzAxf4eJBQ/GZSOIrTdh?=
 =?us-ascii?Q?RA8Tog9hA0/I0jdXaVxZFC+i8+6V5eVRpwjSIeCah6LeLAM9ctc9ttGvsJHf?=
 =?us-ascii?Q?BEOeh7MbU6D7iWeKHg7RRdZwlhaccrBp8iA70cRRcts+yTSxSRE2xwceBGAu?=
 =?us-ascii?Q?azxsChn4wkEOFGzB/jSg+u2HAhPvlFDYf7xo8O5KEzwWOPZ5EicYHokg+TTb?=
 =?us-ascii?Q?Hnk/7pF2l14FH4sUpuTdzf9tF1/3cZesKjxk8IulGk+ZBb7UHjWFrF6Wc4/W?=
 =?us-ascii?Q?6doMl7r+f99Ndgbt9RBBZKwAFtmdBdtWiYdX13S9ni3qPUue5TVdICJtD+yc?=
 =?us-ascii?Q?dAMmqIak9i7yO1XZtKPiKcij1xUMvvmYFglWcveWsqT38fYKVfnUScxzeYge?=
 =?us-ascii?Q?jf99XSBxWXijVhloMN4JrgV8y1IuFbugwwiBWVTYJlv5AjVjjtEEXYeCA4PT?=
 =?us-ascii?Q?CMdF7Byqzwt+NTYnB4iBsJUBpAl+frlaouJpeLXBUWEMjUEg7na0tDJJqsOu?=
 =?us-ascii?Q?rhTfO8ylD3wG4ElSCQMtTqwB1X3p3lteP92UAcM1gvWEG3IBwS2vQ1J1bmQo?=
 =?us-ascii?Q?K4KcZddGdA3K4/ahz9JFixz2XUWr7W3xHlGXGkrTLzQB1+rzCSwJI85UrF8Q?=
 =?us-ascii?Q?XMi6mD/HfdEFVl4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:16:18.9073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 304fbbcc-ca0b-49a2-3280-08dd5d8b0317
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
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

To better evaluate user queues, add a module parameter
to disable kernel queues.  With this set kernel queues
are disabled and only user queues are available.  This
frees up hardware resources for use in user queues which
would otherwise be used by kernel queues and provides
a way to validate user queues without the presence
of kernel queues.

v2: use num_gfx_rings and num_compute_rings per
    Felix suggestion
v3: include num_gfx_rings fix in amdgpu_gfx.c

Alex Deucher (11):
  drm/amdgpu: add parameter to disable kernel queues
  drm/amdgpu: add ring flag for no user submissions
  drm/amdgpu/gfx: add generic handling for disable_kq
  drm/amdgpu/mes: centralize gfx_hqd mask management
  drm/amdgpu/mes: update hqd masks when disable_kq is set
  drm/amdgpu/mes: make more vmids available when disable_kq=1
  drm/amdgpu/gfx11: add support for disable_kq
  drm/amdgpu/gfx12: add support for disable_kq
  drm/amdgpu/sdma: add flag for tracking disable_kq
  drm/amdgpu/sdma6: add support for disable_kq
  drm/amdgpu/sdma7: add support for disable_kq

 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  9 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 30 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  | 26 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 99 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 96 ++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   | 16 +---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   | 15 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  4 +
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  4 +
 17 files changed, 207 insertions(+), 114 deletions(-)

-- 
2.48.1

