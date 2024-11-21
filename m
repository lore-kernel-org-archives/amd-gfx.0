Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837C3D6ED2F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB3810E408;
	Thu, 21 Nov 2024 13:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZQOwrDet";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3445510E408
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPOgdnd6EO+gmIStaI7V35fuPTcz5W+4urswGyC3S/HCsF0Frsna/9I4G6VLbv675rwNlBJSbQsNa1D+nsEa/hWS2Jpo4BFhdIMpF1iZLo3Ap4gv09/lcf92IuJiEIqV73t9V859RhBDscECaL1B8Zgw0JdlqDKWxX/0IsZrHFoQ7Q4oEfbYPH90P1qXWkxW3qYECPvQZ6b93h4B2SHk0mMlMdrrlwsxKo+my3s4FVNzYZxjODMfFraI5FAO+D2n9yBZPu1oBdrf6/YNvWT1aeDyLuHAm3/KBb1UGN1H/7APwJQokiJ7iroVYruCPwFzlhD6VL18tv+5EN7fVsga8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUEjE9YrQEJDYRIyVfpAhZJe6ZJRPiPHVUxAgyE7cmQ=;
 b=IsiXegEy3cW80CrQLrdKkgWBUftpKU1qWfSV1eZnkpYkkadkyBOaaeM8p07BSxscSTpYGZ151AS+rdbM7xS0PfcH8llwOw3LUFqeQeALXwkFlpDh/kIBPg/s5BNXqIsqmdz4saiPEsI2fV6sMNgqN6ZzdFcAvSuw4xQVbkHMov8iDdjtqFCVadLN1kpGjgBjdlAmckd8ADb/Gc6S3kTJAW9RPzkZBzIwxAbH6We2xLX2Yybb3ZmAXc5YK7OtPbnFxjGpJkR/G0QHYkVf/0ICKX5rv3ovwPwLtuRYATrCEwav8Kt4GOD5RRYlgFVVdlqYFzxcxBtdeulkddlFRkVZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUEjE9YrQEJDYRIyVfpAhZJe6ZJRPiPHVUxAgyE7cmQ=;
 b=ZQOwrDet8eaCq3+bpAlA6crvvLbP12r0IC6QuCf2RAxe0sFAEF0NkcQU9OWF7s0v16RaiRfnqmJcJhdXX0oWGgiZuKx1KxqSHJF43ZqTctzhB+mHCN/WJ5zKJcCQ7hinVMZSlpOKKsqZppNlc8Es9/FH1ju5gdlCnrtoY4ej81Y=
Received: from MN2PR15CA0006.namprd15.prod.outlook.com (2603:10b6:208:1b4::19)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Thu, 21 Nov
 2024 13:33:31 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:1b4:cafe::af) by MN2PR15CA0006.outlook.office365.com
 (2603:10b6:208:1b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Thu, 21 Nov 2024 13:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:33:30 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:33:29 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>
Subject: [PATCH 0/9] AMDGPU Usermode queue support for GFX12
Date: Thu, 21 Nov 2024 14:32:58 +0100
Message-ID: <20241121133307.594-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: beff6497-7120-4b5a-665b-08dd0a3116c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OcvWuyfr1EPukNBlAql2QBVQDmmAF19lNo6nj12UrfmnFEhUlfQbnlETE7qR?=
 =?us-ascii?Q?SfTt4sMOaCihageTNto0dOxXrQQMf1pIKoMw8ybwnIsOsg372hXkj4JQJH9+?=
 =?us-ascii?Q?uUa8gzKUJv9lnKj/sOMKdyCe/QAq6JtyBPLtSLqYi7A1BPGnaxNn95XRdKba?=
 =?us-ascii?Q?RLVrpYwcgZskrgNKFVe7DheFE2bh7YDKB1N93BvkJgD+nskMHP75AHEMb5l9?=
 =?us-ascii?Q?iXbgW9tfTrQXphr98Sqgj1P7qwYSj+0NQTp5lPnd20VhkBDYmx7vTYqtn5NE?=
 =?us-ascii?Q?dC2ddhjxj40Y6Uq98TAz/bfMotZjrG627tHY1+aJBm81gTxiB6iL7iX7l9wE?=
 =?us-ascii?Q?Ij37AHKCS0g0qetFXdvaxOIYgu0QsR7pOGsHcujsB0imSTmp5RtMIWNpfpQ4?=
 =?us-ascii?Q?GtaXy2nfaWDHE+G3P7/Sf7AoMXhtfuuZDznk0ouUmPuTZ+RbJKxKvmOAoI/S?=
 =?us-ascii?Q?SFCRHC590XDbNIVqSVAbkOL6IxJJJM+cQGJ0ybwUK7zR6RG9A4Mh583+k/3T?=
 =?us-ascii?Q?3Crry5GrxmZbHsWNQ4xuV8RWREKaQ0mcv9px+P/tEbOvGmRYZOw/SMqbS6Lz?=
 =?us-ascii?Q?nmtKYHxEF56IjeRI/t4uGgPQeX+j2u12fW9KXY8DPrZRP0+ZT/d5iwUed89O?=
 =?us-ascii?Q?BRPxmCLFEvrR7dwXeD/39HnBP8ii7+C3AMCophdtayZysureOFBNTCZpS0IE?=
 =?us-ascii?Q?TvVZV34J4y+pkNrs5FXuXpUdv5ezEgWYKOxb+4M4dXVxbVt1OOoNNy2kpPgY?=
 =?us-ascii?Q?1xMZ+NVoRZPejDc9+euzsTYaeDyWRIutPZn+AZ+yO+kK9KU/ksGMlGP5AIUH?=
 =?us-ascii?Q?Q996uMkYepxfaftnzKLPUMTwQtE8kYrnC+AGVdtI99D0jG+O7qIxyjM214VQ?=
 =?us-ascii?Q?ixeqxP13WTYHH9YDwD6EA4Vd2dVfQj8Buraj1Dc2kF8yWo+/bth7T+CwVY8E?=
 =?us-ascii?Q?2Wf8UD+mrcaQ61b3n9006aDu+I425JDRWMilccpY3cm20gDjhdV1hdl9g0yE?=
 =?us-ascii?Q?HQ/Mhg66gRvcnfVr+mVhtpFtLlfZv2SBf9Yw5eXNJZc+pQBBvcaeSyhqXYJb?=
 =?us-ascii?Q?ZVsDPHjNogXGO8DcsUNgt0IKS8adbxIX/tBRLnRGCE1qiBKnfwA/G6SORjxO?=
 =?us-ascii?Q?hYDqvhU1ObTWn/JH/egmjA1HRYt8A/biuYvcdigVw0DNuPPFmyjenSZtnFMm?=
 =?us-ascii?Q?0S+sXcFoueHqEsxPFJKx0elj84rhSSXMpl3840lJvbIGtNift+hlWoW18BKR?=
 =?us-ascii?Q?rMNuH5QAkDMBS5gvE4tUMY72vFqTkt6K3zZUI3Lr3bzjnPhfLEn+fJ+r4GE4?=
 =?us-ascii?Q?71ls6m3Uwchi5diMLgXszKO9hJYEWbvgdgmdTo0YikbQKzlKVPbLlTaTBLvf?=
 =?us-ascii?Q?KIsBYsFUJOwonICd897x+gzW4cMzUxT10mDTIY9TCGLzkM9OHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:33:30.7342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beff6497-7120-4b5a-665b-08dd0a3116c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780
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

This patch series adds code to support Usermode queue on GFX12.
Most of the base usermode queue code (for Navi 3X) is already merged
into amd-staging-drm-next, this patch series does some clean-up to make
this code generic and reuse the existing framework for GFX12 as well. 

Alex Deucher (7):
  drm/amdgpu: add some additional members to amdgpu_mqd_prop
  drm/amdgpu/gfx11: update mqd init for UQ
  drm/amdgpu/gfx12: update mqd init for UQ
  drm/amdgpu/sdma6: update mqd init for UQ
  drm/amdgpu/sdma7: update mqd init for UQ
  drm/amdgpu/uq: remove gfx11 specifics from UQ setup
  drm/amdgpu/uq: make MES UQ setup generic

Arunpravin Paneer Selvam (1):
  drm/amdgpu: enable userqueue secure semaphore for GFX 12

Somalapuram Amaranath (1):
  drm/amdgpu: enable userqueue support for GFX12

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  20 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  38 +++--
 ...{mes_v11_0_userqueue.c => mes_userqueue.c} | 143 ++++++++----------
 ...{mes_v11_0_userqueue.h => mes_userqueue.h} |   6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   7 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |   9 ++
 drivers/gpu/drm/amd/include/v12_structs.h     |   4 +-
 9 files changed, 126 insertions(+), 107 deletions(-)
 rename drivers/gpu/drm/amd/amdgpu/{mes_v11_0_userqueue.c => mes_userqueue.c} (78%)
 rename drivers/gpu/drm/amd/amdgpu/{mes_v11_0_userqueue.h => mes_userqueue.h} (91%)

-- 
2.46.2

