Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20C6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 18:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC2610E901;
	Fri, 25 Feb 2022 18:06:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C223710E901
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 18:06:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXh3c9I+cm5ADx9w7zuz0K16jsc9ADRFfDbUz31/+NMu9LUWqkPx4nR3FiYI/AY5mU2rjcWdmHyIHkAJsPGpcnXCfrFk73pKoISV74phJD49eCrTEqrKo54xFQCVfX95lncmLSPDIx6OU1cgQwQejZWjxaYGp97huFvf+0iupkjphwpJitUS+yorBGu5FZmQY3/ijo+AicdnVITfW7lV5v/AlYbQvUqBP0jUghEr8yNMlpK9+pI1ctdAFqAqDfQRMt140rbfzu1kOvwz0w3vacNrDOLZRGsiC+RCAP7KaVacP0G/tVYTaOvfcoXqAad0mxliHvacpCcpfpXv+6ESCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=573AxfXQF/KNPQiBUfNMghD6hhRcK1w+0UJKJwcXquA=;
 b=TWJa1IaSgz5AUVgGrJ/Ue1wyNqq86VDYBj1d8X96xHDIodj1D1W8eoKpwbfFPBqzv3KUGydL037E3qTftzsulHo+VzJFc/VGf/jRA6LyBjSeZjWPV5ACK+xwgyC5IjtvIwBoXDUpxD47Zv4JWFR4xdT8P4jEsWsRFkGDUTL7j4vZ7rX7Zr8hTxosBoBbVwUJQdCoD/yui2Dkr+abZChLK0VqLGhV5lNdIybUykZDvi5bYM7pkjpJzsqbEMzJb3WHGhG079Nf44l6MbjLw84tNrQfYDvz+CDy5XZ3COuxwYv1A51778xXQWMrufaUDX8Se51LACt+D6St2RWgv4ZqWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=573AxfXQF/KNPQiBUfNMghD6hhRcK1w+0UJKJwcXquA=;
 b=wvuNKd+rSfP4nHEjtWckbhEYOXQaresnuwFtbiRx4T2dftcAdkgNYPqdywu6qYEMMlrixhdJ77am36akV011ET3zvoVwxTGaLbU+NyOAcWWzOnZ++RVhiqyT3qHNUwoCRwVwurK8jxtpcpTI9vVMLv1k+ySburhMiDwk2Dxqe4A=
Received: from BN0PR10CA0003.namprd10.prod.outlook.com (2603:10b6:408:143::35)
 by MWHPR12MB1773.namprd12.prod.outlook.com (2603:10b6:300:10d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 18:06:34 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::99) by BN0PR10CA0003.outlook.office365.com
 (2603:10b6:408:143::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Fri, 25 Feb 2022 18:06:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 18:06:33 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 12:06:33 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 0/9] HMM profiler interface
Date: Fri, 25 Feb 2022 13:06:10 -0500
Message-ID: <20220225180619.21732-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7469fbc9-9817-49c6-d3b0-08d9f8898ed4
X-MS-TrafficTypeDiagnostic: MWHPR12MB1773:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB17735EE41B7ADD24BC87487BE63E9@MWHPR12MB1773.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6FsqupYnRo4pJjgQIvC1S8+JZ0Mzs26eAtY80HmkRklfH6Wne5cv692TZZXMHHQIo5++4B2nl1Tpr/g/NbtuO5J7xOm1W/h0UDbmrkySDfCSaqH7SE84DcVfXzgWjYETqaUR4bBWbat757pROqqfPd3Nn4WqbX6ya0041eCHRZpvCvVhCYCRs7BD2n3KeUT6CMS7AL+tgQ549kswpSZ/lLBfmwrgftq6bUxP61oGnIrsKPKDek6K6WeXeitVC8XkgovBgx3gKWrtGIdH5+DQUbZ8rLyMxezxFKRxOsASGJjrf2AqeNrF/Cs7AAv7gxoKfYN048hJrydGl5e+GbhGtpZDWnACkQznnufZMxoV9sLd0GI0Gw5eamued75icmeSwHpUdbi73PQBJkJZXpA48jeUeuNtrK3/FpH0xfnFK4sAqkfmkp3CLUq/NvnGk63v3ZKUgdW2PpdxvSr3D13LSXZWuVxdP+Sd16qoiln+z4JDqigYFpvUpRZ8ZZ+436M1Fkdjwc+exBnR2R1JPmR3RbhymlBq89CyZUviYs/IGD1xq0T7g/RcRmQ0ZGomgVsCgb8r4tRujCaNAi2vJVW1jQ4phdyxDUzya8FJRSzPsqqs3SzZdKkCqnIklOBMsCrWf7M+DJ9mSB1wr01IixcnZ/c1P4so2Feef5TaSbTB5OcIRnwEmw9P0r1ayWypRdIaCe5PiZGjYeSSvqL3esAb3AM62Yz3NPAl2i4kXjFeauySCctbGsD0XPAA6u8/h7Fq6ai7SYMmzHLipe3u95QT4qlWCjoLD/cUc3LtFlLIJY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(8676002)(2616005)(8936002)(86362001)(70586007)(426003)(83380400001)(508600001)(70206006)(966005)(4326008)(81166007)(1076003)(36860700001)(316002)(2906002)(82310400004)(16526019)(54906003)(356005)(26005)(186003)(336012)(36756003)(7696005)(5660300002)(6666004)(6916009)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 18:06:33.9062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7469fbc9-9817-49c6-d3b0-08d9f8898ed4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1773
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This implements KFD profiling APIs to expose HMM migration and 
recoverable page fault profiling data. The ROCm profiler will shared 
link with application, to collect and expose the profiling data to 
application developers to tune the applications based on how the address 
range attributes affect the behavior and performance. Kernel perf and 
ftrace requires superuser permission to collect data, it is not suitable 
for ROCm profiler.

The profiling data is per process per device event uses the existing SMI 
(system management interface) event API. Each event log is one line of 
text with the event specific information.

User space usage example for rocm-smi lib and tools under review:
https://github.com/RadeonOpenCompute/rocm_smi_lib/pull/96

v4:
 * Add event helper function
 * Rebase to 5.16 kernel

v3:
 * Changes from Felix's review

v2:
 * Keep existing events behaviour
 * Use ktime_get_boottime_ns() as timestamp to correlate with other APIs
 * Use compact message layout, stick with existing message convention
 * Add unmap from GPU event

Philip Yang (9):
  drm/amdkfd: Correct SMI event read size
  drm/amdkfd: Enable per process SMI event
  drm/amdkfd: Add SMI add event helper
  drm/amdkfd: Add KFD SMI event IDs and triggers
  drm/amdkfd: Add GPU recoverable fault SMI event
  drm/amdkfd: Add migration SMI event
  drm/amdkfd: Add user queue eviction restore SMI event
  drm/amdkfd: Add unmap from GPU SMI event
  drm/amdkfd: Bump KFD API version for SMI profiling event

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  53 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h      |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  15 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 177 +++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  21 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  68 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |   2 +-
 include/uapi/linux/kfd_ioctl.h                |  41 +++-
 13 files changed, 303 insertions(+), 103 deletions(-)

-- 
2.17.1

