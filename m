Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CE4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 23:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 205E910E7C7;
	Thu, 20 Jan 2022 23:13:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C6310E7C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 23:13:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPnHM2nl01yr92o45oEqBbNkGSg1TiaoXg7OtR2G+cKYhyYkg9Vg00DrXaDtKlswNcynvW38hJutoehXtXnZaJwjl4MsC9o79nkbZtNqIe38EbrvYYIs2cc2kj17rPrUcrUv1uOOjwjsbsBeKyX8vx9UGY01Ck5s9ydKfgoXn80zt+mhR41iJAH7fIpH/hgCfjLkDMShheIX2wQf/PKw/2IwLeIdNZCSgEfru6QBcTapWdZcAvUIfCRfQxkgJzR3kEG0FHLWMZWaqrPXed/WRpTtasFNwzECGaLU6+yQ9v8dwelqa4hBR3l2zZvF1hkiGgoGCsAuzu9lu0EJ7gn+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DozZXbHYLu2JDbTVMZAEDpxCJrxv+y53erOrGpwPHSg=;
 b=fbtLX6QVXcbeiT78JwxV5BTT97jFBglnt3ROFRn1Qt+lsFevSgjaZKS/Hu9g93HpwGYQGQCyHzXM+szBjluc6JjBUlBonNZXgh6qzX08WhtGaUBCfvAHFTM+PqXU7JFiPsyDKTZgfBIdv0lXHSWDaNdETCL8GN1wfE5Q+LoNkC72Ve2ZxMjoX0if3jFVWgQEDK3FHtyXom/YlHsqZWSSs0pMJJN5DBDQuBqTysTqG+9bada0LTj5cms+5iOdywjAkUEEqMUVzVzYaFM4h9hWrFeyxZiS0FE68GriUZIsgw6U9xih/2SlWMqF0gC3biwSwf3x5o7UG8eSjhzlSphcjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DozZXbHYLu2JDbTVMZAEDpxCJrxv+y53erOrGpwPHSg=;
 b=M1PBqesTBBjNih1XjMTqICvvciOCgk5nbX2pce7CaJmY0N43vRW3qzNHs16d/v+wXuZJZ/6gCwHCE+JBQPltq5kxfGYK544A5VQM+KesHyy0qgObTJ3kixjQ+8Veaouerlalrk+pdwDJhDW7OsgkjDjbI6IjBiTMpuHOKt9oGIU=
Received: from MWHPR19CA0091.namprd19.prod.outlook.com (2603:10b6:320:1f::29)
 by BN6PR1201MB0226.namprd12.prod.outlook.com (2603:10b6:405:56::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 20 Jan
 2022 23:13:37 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::e5) by MWHPR19CA0091.outlook.office365.com
 (2603:10b6:320:1f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12 via Frontend
 Transport; Thu, 20 Jan 2022 23:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 23:13:36 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 17:13:35 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/8] HMM profiler interface
Date: Thu, 20 Jan 2022 18:13:14 -0500
Message-ID: <20220120231322.10321-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 696fc834-6803-49d1-044d-08d9dc6a7c86
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0226:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB022681965E107640649B077BE65A9@BN6PR1201MB0226.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEqxMMmQA6huijPPOiQQrbdIkWSsV/GrbEEuZAXMFKxvr9169xFQcEcEE1hSRaIsFr2GLEL8gAUl6GW6GmY/Nm86ucnIcf3qwep2gyGr6vIMsZsBpU47mDPGKEnh5OJUyEnXrBMbmsrCU1TVczlabPNp1fpEGU0J2YD9DkpMw2K66XaqrgFLx4e/EySAOvOaxWdelf8Mgjw2fiOI5w/qiPWkSw3WPzGPhUCSQEy0EjgB/k62279Vp2NpbVy5Ol8T3ys6jhqJVvKpBJiJgvMlw/EzlYQp8gKLd30PG0UJgINMWKtCsyOGemn3la/f4EN4p9RAJgxWeFzTXFOLMCKSTGY0n0rxUW5lkHup1ffaAlWY4bgaZoyQoZBedtcQLuzCgu7/mXJKetKTTs+l/A1SNzWN+wypAe9Wb3Uw6lBQnmF2AlsCrTxVYP7MWSYTnlJUTZdK88LtZ7xy3Dn3Y7giSq3HiOnyFnM0tHJkeZxyse1hLc7UuIcFQlMqZpwjuYz3FEbqma6BBSy4y4pS+ItyHjway3/oPfJIuEoVFRf9/3xNtkAIs0ttCEi3zdnfaWeeBua4tzOJu+EMeM971gsGHLwyJ7HVwvYcJ5Shxmn1fs5GFFFKiBUinx/jzvlWtdNSnPe9oYFiTqvvsWcD4uXdltGj5ndY5TWMFKhZHUNd0HvtQoqolPi93ETu41aDjTzcTsOBWptuLt6GxAA/6ljMnnku8+FHsjuikQOEKXB86AuvpxPEkQi6GKkq7BvlAAge+2zskZW4KtFk6et0YHDkcTwLArMqIqu708R54d5v4Ps=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(16526019)(6666004)(86362001)(186003)(7696005)(54906003)(26005)(508600001)(426003)(36756003)(336012)(5660300002)(316002)(47076005)(2906002)(6916009)(8936002)(2616005)(8676002)(40460700001)(1076003)(36860700001)(356005)(82310400004)(81166007)(83380400001)(70586007)(4326008)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 23:13:36.1875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696fc834-6803-49d1-044d-08d9dc6a7c86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0226
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

The ROCm profiler would expose the data from KFD profiling APIs to
application developers to tune the applications based on how the address
range attributes affect the behavior and performance.

Per process event log use the existing SMI (system management interface)
event API. Each event log is one line of text with the event specific
information.

v2:
 * Keep existing events behaviour
 * Use ktime_get_boottime_ns() as timestamp to correlate with other APIs
 * Use compact message layout, stick with existing message convention
 * Add unmap from GPU event

Philip Yang (8):
  drm/amdkfd: Correct SMI event read size
  drm/amdkfd: Add KFD SMI event IDs and triggers
  drm/amdkfd: Enable per process SMI event
  drm/amdkfd: Add GPU recoverable fault SMI event
  drm/amdkfd: add migration SMI event
  drm/amdkfd: Add user queue eviction restore SMI event
  drm/amdkfd: Add unmap from GPU SMI event
  drm/amdkfd: Bump KFD API version for SMI profiling event

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   7 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  11 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  67 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h      |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  37 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 163 +++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  19 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  63 +++++--
 include/uapi/linux/kfd_ioctl.h                |  30 +++-
 11 files changed, 343 insertions(+), 65 deletions(-)

-- 
2.17.1

