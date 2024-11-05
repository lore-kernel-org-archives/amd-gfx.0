Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843CED2B92E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 14:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32BB110E5B5;
	Tue,  5 Nov 2024 14:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wrFZM4Uq";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A5610E5B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 14:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFf/ZfGWEuFbE8wAuzYWjHVTSVvmPizqwu8hA43XbSxTSNSxZLhkeS0LfcSN4tG6uNz+SNqbYof8R3LTaagPDFd7ev6pP0vgi/yJFRe6X9biV31OkWLvfk+jTKgNX9kxZIqzQSDG/XAlMHRFXnDJZQSXs2a5UCgkfz1qxVR3PMrdhbaBl5zgxTVo7O5nKLrizFjq92fzqJRvQJYeTL8UaTPg8VqChXsP9g/O+wvgT6hhoweZ32daabBuT9fPBFBC1cxK9BhX/6mS9QZTzD1Uk/x55ry6nXxgUE5cgDvqxDPz4mRWHagN+hBvi7Tk0uhwB/twE5DAB+LMS60JXwPsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDHgoWisC9Jl/8RpGlb677ko5AqOfXQ3D7f0kYjMYu4=;
 b=Fl1TVVgL7S6D2afxV2WO5fcHxEsJ+fwDtsah/QQNQ9C1Jv4Vky60orjag82wTwOexLTvNRy+h6ZZB4ltFXZv1gsjt7EA6cGC1ze98rMwaesWv6OarY5nyNZuc1OfazFidmL/9OAtp9Szul3ZxQTS5iUhht5i+Dpl/1JiNN26gMRuOpA364VN7yx+swBHC0x+UgIukbHie4ukWEwcNX9sntxFKL7ImgVnf5Oi32L0TFEJhQY+sbOGCvTw/+0x2xLx5o+cyj67AfB1GK7mqFcaP1oVME7HVNLjZYN3qjjg9rwhbdShreSPHSYg6PCSZ3cr4RDwGyd5Np5BV7rRCcqy8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDHgoWisC9Jl/8RpGlb677ko5AqOfXQ3D7f0kYjMYu4=;
 b=wrFZM4UqkgGcKpdG4vOla0MrEKn/mN/hh4udqzOzJNGkezGBuSugm9z1zfWsdzoGk7AhmOoQWDqZt9OZ890L10QNDdWljnN6hb4LUwl3raZYuhkj6QModl0w0+tVexvWojKIcKXUVWfi9Nye6JRSkz2BuX9mfhN0AZZNT6USJrA=
Received: from MW4PR04CA0336.namprd04.prod.outlook.com (2603:10b6:303:8a::11)
 by DS7PR12MB6334.namprd12.prod.outlook.com (2603:10b6:8:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 14:06:41 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::1b) by MW4PR04CA0336.outlook.office365.com
 (2603:10b6:303:8a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 14:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 14:06:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 08:06:39 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH V3 0/5] Add panic support for all DCE/DCN
Date: Tue, 5 Nov 2024 09:06:19 -0500
Message-ID: <20241105140624.2897662-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DS7PR12MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ca392e-8b2f-42b4-e95c-08dcfda31260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IsXJVbYHJq8ncF8x07ZKg0wedU7IbK/LC/HctUgol+Do/zgDeaDsW4/Dz6i2?=
 =?us-ascii?Q?GUfcXxzbmQ2U2QPYNesZkeimrBxsECwZsRBgsk3K2PFL7pMgRDFvobBxLfKQ?=
 =?us-ascii?Q?cWL1nDKbQzKnlFsomc6Hb/SgA7YEs7xe4yMseiOwxqYy47XlsrX5Z5zLsgZ8?=
 =?us-ascii?Q?PYNYJIoAZ/4TdRFjD7ODaGeNHrX2h5dwvWbMQ9GslQ75D+Ttv+bcITP3sxb1?=
 =?us-ascii?Q?06oBlKEfqpJTtMzn603GCIl86ZbT7FKXnROSzn21mblB669xCNG5VzIX7mWu?=
 =?us-ascii?Q?ZcVcsgAcbWLFh0qT+QXzIzQSrYrPPTis0arDegO/31Tr0H+JmEUUUwknNrwE?=
 =?us-ascii?Q?jNycrH1CEEJwZff7PEyFrLxt+nOAtM4OWSs779uDfbFrBVIDDLJkP3tmJum2?=
 =?us-ascii?Q?TDx7OI0asCT1ewJUU+RZLLebZ9qRBUCUNwDp8jB5kTS3ZerALyrPQM1fSaTb?=
 =?us-ascii?Q?+jBwcFMvZmj+ypfNUHfU7O9HUo+FuTj+m8I9WvqHA5clxqhUFbXxZGnMStra?=
 =?us-ascii?Q?KVQbh6zoMAy4n9vGqiksMU1p4km/Fdm/dtWwwdoig6F7TmQQut+IV2B6SEds?=
 =?us-ascii?Q?/XL7OOWuzWT9b7lu7d67vv/Xzf6OKaYJfl9fmaoCDDqvDOTuu052oaIiiZ8j?=
 =?us-ascii?Q?8pwhEFky0GK7epYxg/sNkNkJi6CAO3HP0eqdMSxhVGXExKY6xGpE9oVfL13N?=
 =?us-ascii?Q?I7XA3cYTer2VPh7XQpk+Uzts7xcLvWlJbaJULzlQXsjHtIxRdq5FAtAV7Lxw?=
 =?us-ascii?Q?glnmenmood/uFAWl63yTZ662+xUYwpUwLew6YCzj/7K+No4/l9cbknGXrM6r?=
 =?us-ascii?Q?ct/CxHys9gNowoYLGEbNdf6JigMynAxUzDeKix2vQ1gXII4+Lb2SjiinhFy3?=
 =?us-ascii?Q?jvHv0OGtAj24dMQ6X5ez7TK88KIkHsQ6MAfriEGauCexTXbu6gmqcWbBTtLI?=
 =?us-ascii?Q?TcdtGXiVzapyErnuy6cVEjxbQfeone3/0gkxScnZ5S64TBZ7AR0J1ROQI0qN?=
 =?us-ascii?Q?R7QzIEZxgzhx05ucUweIkU9UE9/0eKlfMzwDhCT4m2GugXGC0mNWHZO3nZvT?=
 =?us-ascii?Q?Yr2IAr4fdrSZIWulfrYdFbKTSKgHjtJgZ8fuiwAI3FYSODTkKZ/68hmHVLFs?=
 =?us-ascii?Q?+wvFZYOyEFs5fctUQ8wQ1HAl0lW1OyO0jTXIhWP2m6V1UkaVPrOdgtMLNboH?=
 =?us-ascii?Q?nXxQ3e/ZQGJXlPVILptNfi7DHx4pH70tHCcQG+3XEb0ZcCGUb39/sJ8NjJ9D?=
 =?us-ascii?Q?FHN36ENbpIChQTxF71zrHSuALStpjr6y2KQQrzWBAUpt8X3V3MQXtUUoAvG+?=
 =?us-ascii?Q?UfKSL3kWxC9ylzEmFVeTjxWtR7JrF/wuyc2f2zMukla3DRxsF508PCJrLLvT?=
 =?us-ascii?Q?ZjI8+JTsHy1D3L+fUQ2K7Qqn8BuCSIISIKsxk7oVxUZzOUwrIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 14:06:40.8042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ca392e-8b2f-42b4-e95c-08dcfda31260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6334
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

This builds on the patches from Lu and Jocelyn to fill in
panic support for all DCE/DCN variants and code pathes.

v2: refactor to provide cleaner history and share more
code to provide a more consistent experience across
DC and non-DC.

v3: resend with the missing first patch

Alex Deucher (4):
  drm/amdgpu: add generic display panic helper code
  drm/amd/display: add clear_tiling hubp callbacks
  drm/amd/display: add clear_tiling mi callbacks
  drm/amd/display: add non-DC drm_panic support

Jocelyn Falempe (1):
  drm/amd/display: add DC drm_panic support

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  80 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |   5 +
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  27 +++++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  27 +++++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  27 +++++
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  26 +++++
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 103 +++++++++++++++++-
 .../drm/amd/display/dc/dce/dce_mem_input.c    |  34 +++++-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |  15 +++
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |   2 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |  15 +++
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |   2 +
 .../amd/display/dc/hubp/dcn201/dcn201_hubp.c  |   1 +
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |   1 +
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |  17 +++
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |   2 +
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |   1 +
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |   3 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |   1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  15 ++-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |   2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |   2 +
 23 files changed, 401 insertions(+), 8 deletions(-)

-- 
2.47.0

