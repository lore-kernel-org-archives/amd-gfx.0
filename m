Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A54CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2923B10E322;
	Thu,  5 May 2022 20:04:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 914EA10E222
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZR2F89YRMbER/0oGpzrVybyIHDhFuWbw8pFOg8BnV/Xv9V3EJVmO5jdtHTYa+gC3nwLOAc9OGhb4qW0nczLfoLBEITYIOe272tCxL8y6kLCoMCuK3sz7N9PiDSNOA4CyNL++e728aG1ZJwGWY+9IlRCm8cN2o2vuR9MGlwpV500sU9eyK9v4GDS9Tn9KQqsSfczS1qkeo9KYD0BJqJYSqcregN2iK6BD+fJOl0eQZ7pkxVa51l6rhSn7qeEQfRUP0uaPjNDqFfnE7C41X0jO7LkJDhcW8te3b4CkPkv1q+PtpE974+leV5a1lXhtVavU9PsrIQOPy6XYF3S8ifSlhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DHOvfEklBeOiSvXRMEZpBBr5snN850ufrmVcSO3q1g=;
 b=d3OZgzXDUgqvGrnLi5BPFAIQ/HQykkgssyvRVQ1jfati9lQ/rnZamVQAstO9jxWXUPFyF88dXHqXM0crzJzG7Rl1hd4mYEur1v2kirz+hJTEcKFmtWVWhEwMl2FXbIxrg1+3N4iqAucmCS6yBpWZVXjl7RaKXIZDrPsJ5wNnYU0zMMgftemvw2420RoyPtqqBsMzfQ1XsrSM9GNOEztU8bTG3KKQAH+QLBW2Onja+BxP/hzJMgr3dY8+AD2W+h9aREHp/PNfADiznhd+rUquOn+CUnwmqicoTbOntiSkBE54LH8cpgGw81t19Sw9FEI6wrE+vbAzQGXMONifJiFUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DHOvfEklBeOiSvXRMEZpBBr5snN850ufrmVcSO3q1g=;
 b=j/2lf0toJ6K1Dr/KeDQW2QLBA2GkWtLAC2movKU9LkR+37a9WcmRDgPx1iYPwzJbCNObjC/sUAempmZZXnS5r5F/ZpmklhZ4gdaYtFStUOlEm9kbiXTkaMgnOgAzeaN4FVGPEfcNUgrK8c9bR5RmybzG0JNxQxfgVB2NyPtE0X4=
Received: from DM6PR07CA0048.namprd07.prod.outlook.com (2603:10b6:5:74::25) by
 DM6PR12MB4026.namprd12.prod.outlook.com (2603:10b6:5:1cc::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Thu, 5 May 2022 20:04:20 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::c1) by DM6PR07CA0048.outlook.office365.com
 (2603:10b6:5:74::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Thu, 5 May 2022 20:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:04:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:04:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/8] LSDMA support
Date: Thu, 5 May 2022 16:03:59 -0400
Message-ID: <20220505200406.1293467-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ed85eca-2180-4e02-4c0c-08da2ed27117
X-MS-TrafficTypeDiagnostic: DM6PR12MB4026:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB40264E585EE1BCD7D968C823F7C29@DM6PR12MB4026.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gY7888He8KmbruJ19z5SwafrnAtFzBULHp+IP14aqu8dBuR50rNBdpQM3U0/EhSHhNwjMUx0FAQ8Rl7rZJf1MWjYfHfVZtwvUySgF62QW+dxSG8afz+qLhtoUD3cvYXOhvGy+xehXk/WAQRJbEW2Z89B74D8qh6QQdeAH1AfO3dTCjRr8mFWuxLf0oj+/nY/LfGVEa79G+9s/u+O7SMuEtuPhT2PSju4vLXaOvA2Gvr97dX++FasiF8t1j5E6p+1GsBCGr0eaDwsHcF1a9jFkUq9J5pIbFinXDQXmCLBpYOoFV725xIycOSYQtY6cFx+UMm1wr3173vQaJqyELPDgZwkBqAe1AChvkEZo6wQm9p67A2YzE/V+R+Bs2b3bLDAUpd53L7lzKN+ps+pJRoDuTK5AveTd/D2klE4Bsa0zR+8dTu+hBg0jR1E43Utd9tE62QCJVOhNBWTgerZALIIIr3H488KeOsG/IeUrPZl0gfARJKuKA0tnQ61zHChxH7H5rrlyKPJzUB/lfiBc4iUDgwkAb4G9yXUOakpypzzu+Akr7ARXdJaQzTRiclS74hglBW5JCM1q7Smx09WIQkJj+Jy/2bpGPyk5StylTBZe31/hTvYTJbxzr1I4fIji6J1hor+bQAVm3y++Apme6RJDnIHE/KNtSAYlGXj+KFO8Mt/q1zx3/9lec3CqguLMKP4Y1GiTwaiT4wTvrbtZNN9Dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(83380400001)(86362001)(356005)(4326008)(40460700003)(81166007)(82310400005)(8676002)(70206006)(7696005)(6666004)(2906002)(70586007)(36756003)(8936002)(5660300002)(508600001)(1076003)(186003)(16526019)(47076005)(2616005)(6916009)(336012)(426003)(316002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:04:20.0614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed85eca-2180-4e02-4c0c-08da2ed27117
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4026
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Light SDMA (LSDMA) is a supplimental SDMA block on SDMA 6.x
for use by the kernel driver.  Patch 1 adds large header
updates so was not sent to the list.

Hawking Zhang (1):
  drm/amdgpu: add lsdma v6_0_0 ip headers

Likun Gao (7):
  drm/amdgpu: add lsdma block
  drm/amdgpu: support mem copy for LSDMA
  drm/amdgpu: support fill mem for LSDMA
  drm/amdgpu: add LSDMA block for LSDMA v6.0.0
  drm/amdgpu: add LSDMA block for LSDMA v6.0.2
  drm/amdgpu: support memory power gating for lsdma
  drm/amdgpu: support memory power gating for lsdma 6.0.2

 drivers/gpu/drm/amd/amdgpu/Makefile           |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   12 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c     |   91 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h     |   47 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c       |  121 ++
 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.h       |   31 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            |   13 +-
 .../asic_reg/lsdma/lsdma_6_0_0_offset.h       |  391 +++++
 .../asic_reg/lsdma/lsdma_6_0_0_sh_mask.h      | 1439 +++++++++++++++++
 drivers/gpu/drm/amd/include/soc15_hw_ip.h     |    1 +
 11 files changed, 2152 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_6_0_0_sh_mask.h

-- 
2.35.1

