Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472F2EB64D0
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 15:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C3F210E3A8;
	Tue, 13 Jun 2023 15:07:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F0C610E26F
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 15:07:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfdOMi3kw2F9N1R1R6XdDF7/NB9ieKiqR8v1Vcx0GAjpGvUS72v72/4pKD6UMpdf+SZBLXSSN5khknnuvGci1nXcejUYOYLKprNkhojFX9wjjznG4TE2AfVoGPw48fa2s1dV3EeFPqoYmjxUYmOPcwFB+tfb6m/XL0OrgF08ag3YLrslkLB53LgNhZ4qDMLY86dMHT21eR/X6bZdSlTYNWBhwTKqp/jnSVPbTCqFkejktRweUQyE+444aDpaxRvE03k7qDXgNmNpestRhvLuylCF6DUvmrpqUNsCgvEpiOLH9vizvWCDMNqAQMhltkxfKbkOP452AGINYTI0JqDs0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuWvlh8/0+l7cPEIl8wTMumZn7X1TqlSloNyvabJFug=;
 b=eSn8gje3IMPbAWXn41ghB4swjdpmcLsvdx1bLkmg11i3qNyqFfxo6CV282L830jUX62gEIBrK4mnDklZhn4Y4vmqP1/QW0CPGqPeMLi1XEZ28UcCRNEpkYOiPXjq0q7zAVXoSPzKhIcP1MpS4toLMy/qddeF6Mr2BJVyqPkCDnGTJRq4fiH55lLtFUcrckLBdxlM9BmlGNuOwzleSzWES0XB7ccNDK5cq2iKFB6MdqUVM35Y3eotAKXl4mNiUMvkppRd7ZAHgpHBF8LyodVIwc9ooO7G17zzsgOarNJ7uUXW2r+RhCso7k3qq3KTRuANZp7hXGolitUxCRSk40gM7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuWvlh8/0+l7cPEIl8wTMumZn7X1TqlSloNyvabJFug=;
 b=jAktiI7Do2RchmhCwnT6L8/t4YZIsgoLzjjFeQLXGssZ/EauKQW0FHfHpEXGkgBJvWfZgWB4NMLMa4biyMo0oXzC2G5J6rheCG6WrJYP6yoa813OblwTYwiZ2sR20McOjHggvPbWz9CnpwXNrpl380yT6Fj7CfceunISUhXezgw=
Received: from BN9PR03CA0748.namprd03.prod.outlook.com (2603:10b6:408:110::33)
 by DS7PR12MB6216.namprd12.prod.outlook.com (2603:10b6:8:94::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Tue, 13 Jun 2023 15:07:45 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::35) by BN9PR03CA0748.outlook.office365.com
 (2603:10b6:408:110::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Tue, 13 Jun 2023 15:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 15:07:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 10:07:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/3] Add GPU page fault query interface
Date: Tue, 13 Jun 2023 11:07:09 -0400
Message-ID: <20230613150712.1703987-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|DS7PR12MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: beca94f7-5b36-4806-74e0-08db6c1ff184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gw0CMU90ZKzSQPtg0VzMK8+RKnfy82YevDUg5bjgCJds7cjOva21lGOauAYOT6HuS73Q1bSj11/YrwP1axpRDtrVOFsB8uHc/OtU4/2IjNAgtGcFi7SReiWNlxJuWE1OeoYDzi5BRdSOgXBSrrzl+RSz5k1XkP9KkRDS6zepTTYBtmB/Jmd/bO/R3IKihEBRn5xeSSeEVGLDciptR2bZp8Y1sMod/y3+UUzWltS5WantdY8aQgqcgxHqnj1e8pE9ZcJqZKJ8evk9QC5IJegZxFZaGq4YlMlj/J+h/p2Dy70CW7wU8iwni2qv1NNa82lLX16qmWEQSY5VjMu4tgqwi7eacctGZb2M1S7jy7jQYvCMP+1wesBYxbuvFl651SF2GO81b3CULtsliGdB+dzQYqJRcRKz1WN5SW4gBslN1FBeKkTM9lzjhhZlGeqc75Wn7xh9oLt3siYjrD1mqg7wqaez3ruw67g6DbiIdVNomDAySbg1AK1zeAGU0tO+q0D5bEI4zM/bCw1raWz1y1/aGsc6tgnzy7R2L7I7xdENw1NVjTQLXMzaru/Yn4UjRS316DlHkAZKsETrAXzdD39nJV+/qucXxX+g7Q9bi/WjSHGIIwo1pkXDRKVCf62IZYRH9jSjvG7UjjkgDzAYZIQxmdayLVyHdaI4RquC03N76ijTASuf8FITOCqcRIeVRNwGhrASnt2gJySZbqunAYKK4gsDMrh7qRP4QD2z9yOIpyE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(47076005)(6916009)(426003)(70206006)(70586007)(4326008)(336012)(36756003)(186003)(16526019)(478600001)(2616005)(2906002)(8676002)(316002)(966005)(41300700001)(82310400005)(86362001)(40460700003)(7696005)(6666004)(36860700001)(356005)(1076003)(8936002)(83380400001)(82740400003)(26005)(5660300002)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:07:45.4364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beca94f7-5b36-4806-74e0-08db6c1ff184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6216
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

This patch set adds support for an application to query GPU
page faults.  It's useful for debugging and there are
vulkan extensions that could make use of this.  Preliminary
user space code which uses this can be found here:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23238
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/298

Note, that I made a small change to the vmhub definition to
decouple it from how the kernel tracks vmhubs so that we have
a consistent user view even if we decide to add more vmhubs
like we recently did for gfx 9.4.3.

I've also pushed the changed to:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/gpu_fault_info_ioctl

Open question, currently we just expose the raw GPU fault status
register value for each GPU so UMDs need GPU specific knowlege to decode
it, although it's largely the same across generations.  One option would be to
translate to a generic GPU independent fault status.  Opinions?

v2:
- Fix spelling typos noted by Guchun

Alex Deucher (3):
  drm/amdgpu: add cached GPU fault structure to vm struct
  drm/amdgpu: cache gpuvm fault information for gmc7+
  drm/amdgpu: add new INFO ioctl query for the last GPU page fault

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 16 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 45 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 31 +++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 11 +++---
 include/uapi/drm/amdgpu_drm.h           | 16 +++++++++
 10 files changed, 126 insertions(+), 8 deletions(-)

-- 
2.40.1

