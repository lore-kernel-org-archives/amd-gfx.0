Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDA2C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 06:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54B210ECC2;
	Thu, 10 Mar 2022 06:12:01 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B65B10ECC2
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 06:12:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRpbbc3UvPs3UWga5pDL/uX4MHvgb5cJaJn6USbuJ6piwDXumM7/9K9jyQZ5YXy8pADEglpm0T/BoaMY0Dy9NhHBjEy/JZDflBJDBoS48yO51TtwSsA9M1oLP7Z+zRYX2MFUofW2PghIYL0I0Dhmf58Me5RvJ2pFiAKfu/1yi9DjKtbB1C0yJFGhyWwaMFoZPZ8/1qzQEiCZE7XB+wRhSFjawCfSi/jcwqvTYxMVUY/4R1xQu7u5OATdQXVm2XiiJ05SG638BFLKoFTRTwqsI3ZxZdYfiumhghzd+KeSWcoZuyfVSsjHGw1NxAYiDjRV4K/GrAvWa0Kd2zvIaaszXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDBdOxu5X7770PiqNKLAM7yvcPU4I8vOTjZqEtHVQkU=;
 b=m+ZA8DE7drsS75AgPlk72fbfieSkIc+yM2x10vlkTg4C58oA251Cj0fMF3yZ6Gm80KqKroBp8DYAsH9WQhsc9MCJqtbxIB4waiitw7z3RVMzcJ46G/UVJ8YoCVaTiI9cRqUZJMjjxdcOwNGCr4Eqz7bP+3XTLHpZAPnhaGMv9rGiYtRv0X4zqEIiaYZMPGmvDRYyJA8R+p6S/IAYsUeSS80GnlMGfOJ4LWPBW1LVTLhsyyBU+rMen12YH9a4EpGVYvZ2XLkWRqE1E0239Qezx2quimQ3qSqNP7TlTk1s9iL95u50VgYgq0Mgz2E3Mp2NHfMCCNOHZuQkrH9ItzVDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDBdOxu5X7770PiqNKLAM7yvcPU4I8vOTjZqEtHVQkU=;
 b=PdzJCUkh8PaDa2ndx516Tj62OT0IiOPV0G9b/45uRQOHCnyeq0zMmHT45DzCg+QmFACRKQr4y0ErUuyluKoiI4rzUaINHxyhAMCUL593tiqC/Svnr8JrxvZOQyOICFOeYbsJ56Vr8ACvdf6aKvrS6/Xvtbbatmg3BbV3Hb5Bzrs=
Received: from DM5PR10CA0003.namprd10.prod.outlook.com (2603:10b6:4:2::13) by
 DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.21; Thu, 10 Mar 2022 06:11:59 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::a2) by DM5PR10CA0003.outlook.office365.com
 (2603:10b6:4:2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Thu, 10 Mar 2022 06:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 10 Mar 2022 06:11:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 00:11:57 -0600
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 10 Mar 2022 00:11:56 -0600
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Patchset to enable soft reset
Date: Thu, 10 Mar 2022 14:11:51 +0800
Message-ID: <20220310061155.39292-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54185af6-4760-4836-1006-08da025ce277
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB440151B26A2EC57EAF5CFB8BFA0B9@DM6PR12MB4401.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JhlpqxykHnkG0wzYznaqGKOeS5kAQjKooSeCLRqRCGPy05HYKyf2sM1FxANJk6ersIQsx8Josx3U5lDQCxTNYxYkHPgaR9n70yQLcUFAlAIntGlVfuCLm/G+Y4qUEtOUhVeY8NMr25f0LmTV6U/GLtPsiTQZ+8+hLQpgVSr8fXuQ3oCgsD5lHwjUay0ujIherstzAkYJfdmmGI+aDaMZdRtH5rdjhHTnoJAZhQXmTxXKZam+5ZfLL0vw77FvuTZCvhHgLVAjbrjKWrH1a7vsftf7ze/CQkMAWnrXSUa+OW+TO1VYVfAHyu+zQMt1U4XZTzOJo09tJS8brsNUVhCHbcs8+f+84sOUVkgKTwMev/QIeSfY7ow0TV7YpKre5biBgtF82h/vvGX0L7k+ZeFp+vEz/ehCnBni5xhWDxP2Ro/fje/CToqB6HsmW4QQ7zzq9z/ng3GP3UvHwNZSmL+dGPpGUXfRBTZQKP66nCSwve/ZpdJmm8D2uTtCiGGRom4aJZCElCSLi+r1kz9+3l7jBMYKsl49BLDrJNJBj5bzdAsxNzR44ifqf6lLh2vi9xRuxdlKvfwsI0fY06bDmouDCqKrMSKsb4YJ0dDdN86n7vfGoUKIvlBMUHcShAbSJe1EmJm5RMV4/dJoAI1vHyOh0qxT62xoL/1qyg0zTtAQTghd3fWHSe0KDsGvYSUm8qs4TilhJa8JIHxYIqaGtMoVsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(2906002)(356005)(7696005)(6916009)(508600001)(316002)(47076005)(54906003)(36756003)(6666004)(86362001)(8936002)(426003)(26005)(83380400001)(186003)(1076003)(336012)(2616005)(4326008)(82310400004)(8676002)(5660300002)(36860700001)(40460700003)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 06:11:58.4953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54185af6-4760-4836-1006-08da025ce277
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
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
Cc: emily.deng@amd.com, Victor Zhao <Victor.Zhao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch set is to enable soft reset on Sienna Cichlid on sdma and
vcn. Sequence is enabled to satisfy the request of a faster and soft
solution for multi-container environment. In order to get a more accurate
engine hang detection, get hang from timeout job instead of register
status. In order to maintain the previous reset logic, add a module
parameter to control soft reset.

Victor Zhao (4):
  drm/amdgpu: add param soft_reset_enable
  drm/amdgpu: pass job to check soft reset
  drm/amdgpu: add sdma v5_2 soft reset
  drm/amdgpu: add vcn v3_0 soft reset

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 18 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |  5 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        | 79 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 87 ++++++++++++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 drivers/gpu/drm/amd/include/amd_shared.h      |  2 +-
 21 files changed, 204 insertions(+), 27 deletions(-)

-- 
2.25.1

