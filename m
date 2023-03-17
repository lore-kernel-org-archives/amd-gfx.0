Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0621C6FD1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 17:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0125210E115;
	Fri, 17 Mar 2023 17:18:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4372410E10E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 17:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccdwZssrCwZCGmiYKt1/IotGR7PLQ0jgzLujM86HwuNmZjtx94Y5eVhknZ5IKj10eN7KgxoNY9BkNFA2vmBNd9S4I3ip9DgGv56Cm2Uv7k492osmVUrNfeaMckUev631RqVhEhNuRnQT20rdWE5JwrV7ruup5lm7pt8AKCT1Vy3MXX8O1epDPDdMccDSTFZ6z2kBULLAKnmgAXbt/NDujU4Wzl9SqSfPHgFR6zi/EBDc+v5szun1kzeZk3dRaYML4slKKan4yXPV5KyU937w8Zu42M9iRvKJvL4ZO3W1JsPOi/NRLghrAp+A39IwJeKfQ4iPbRdqWmOytxfHIBE8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTHmd5hL2KnxmRf+cAxiriJ/7uFkSF38COk3zmvbadM=;
 b=h92CuwLHuIUq0muvwyR0C/eXSBiyLuX1ohiWiV3wqCqW7jAjnZbd1HBr6LVknEwhF/jp1XxnZEaWAXqrscsArqpb5xJKKnuOGsN/OqPZxw4CtMJlUDs6SqRKfGSw+MC4dnZB5Ga2xJAkQSVaYBoxHhvXVv2nl04T8XN/ZbpaUTwcNxSG65AI2k64O0gf3XxS53PXK6BecgYLYfxv1Ok5AMeoThxepmFT61uBIs95doaKWdsETvBN9iJ57UdbHtl12Jm6OVRCy1GypL83j99OzCAZnnV7kP2AZMB4020ArRrUvvADK4aGlZdZBAr441OpABeAhMunzpGwL0jbt+RuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTHmd5hL2KnxmRf+cAxiriJ/7uFkSF38COk3zmvbadM=;
 b=X+goXEEA9vcIX6H977pO8TP+5iwvkgtCO1Vb8yfhe2vouaq5oh9eDDSExgSdsmExdF6bVYr7ep0eKn9ml2TjKtBc4xc19chJF4PDjMciGUddKZFwyj07b1VMhGPXnAkjzgeWakP3BrzjZYozDxGdUH2+ufa9JpMWmkQ1Xos0FOE=
Received: from DS7PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:3b8::29)
 by SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Fri, 17 Mar
 2023 17:18:03 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::6b) by DS7PR03CA0024.outlook.office365.com
 (2603:10b6:5:3b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Fri, 17 Mar 2023 17:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.16 via Frontend Transport; Fri, 17 Mar 2023 17:18:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 12:18:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/10] Enable FW assisted shadowing for GFX11
Date: Fri, 17 Mar 2023 13:17:38 -0400
Message-ID: <20230317171748.682691-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT095:EE_|SJ1PR12MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: e1db884e-bacc-4174-8c6f-08db270b9103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cKIHjFftm7o2Mb/XIK5l02YRi+EPK5uQrFSFJjLTgvk+spOPcJ0tW0DMQsdLi+uvCJUgqifPU73eBl1jDVuzlwM1soCYQCcrs7/AWKL3RiP3fYGD9sbJoqqxNmiin+ythC+WdYxbj6I9SBIvVru8rx2rbf8XCEUBCuREg3ObWouvbN1hmeDsk3StnfgWKJWdcNRnPOSaZYm+cKlVQy8LtlxbqhmVSTksKejCbry+d5rsAy2CqHCmsCmURuRf0xAMA5S5UQGkFskqYmXeZsL3hMkTpBOwHAv2SvrE5nlNiBMAnmOnlfx3uSpde5SbTBCj2OPI962VZX3sXtqRXOtT7A//IVMksz8OVUp4W+rfoiImJPHTZHXHKezkiCyHvDgSGemGWgVn22SQilzpHxKnWh1YmQlwDRNwPVcc8/TsgL8jkgyXWG5nj0GWswJdxlZkTlWYIHzMMMEJhr6OqrCJnz+nhZl96C91BnUUKdYhlnPV4HdoE2YNxJpledjwnFYIzAc4e5z907AhIsZmFO6lfoIQpVotuQdxyeDwpxJpW8FWcpd2GrbE/+U0zKIDfjU12uysXaHcNvL1tHUMdTS2QSmYcmeYnWTxxruErk8pk2s8PyMvu+5gHr9S0yaVBA4wS7y6RHeo8IFvATxNUWM7gl0ihQqzQg1Casn6O1F9XuI9N850jYAwRlXfowmMvd4a
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(336012)(6666004)(186003)(83380400001)(966005)(478600001)(26005)(2616005)(16526019)(316002)(70206006)(70586007)(8676002)(426003)(1076003)(47076005)(66574015)(7696005)(36860700001)(41300700001)(6916009)(8936002)(5660300002)(81166007)(40460700003)(4326008)(82740400003)(2906002)(356005)(36756003)(86362001)(82310400005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 17:18:03.3328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1db884e-bacc-4174-8c6f-08db270b9103
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6194
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

This patch set allows for FW assisted shadowing on supported
platforms.  A new enough CP FW is required.  This feature is
required for mid command buffer preemption and proper SR-IOV
support.  This also simplifies the UMDs by allowing persistent
hardware state when the command submission executes.  UMDs
that use this will have their state retained across command
submissions.

The mesa MR to implement the user mode side of this is:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21986

Alex Deucher (8):
  drm/amdgpu: add UAPI to query GFX shadow sizes
  drm/amdgpu/UAPI: add new CS chunk for GFX shadow buffers
  drm/amdgpu/gfx11: make job optional in emit_gfx_shadow
  drm/amdgpu: don't require a job for cond_exec and shadow
  drm/amdgpu: add gfx shadow callback
  drm/amdgpu: add get_gfx_shadow_info callback for gfx11
  drm/amdgpu: add support for new GFX shadow size query
  drm/amdgpu: bump driver version number for CP GFX shadow

Christian König (2):
  drm/amdgpu: add gfx shadow CS IOCTL support
  drm/amdgpu: add gfx11 emit shadow callback

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 24 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 14 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 26 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 85 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nvd.h         |  5 +-
 include/uapi/drm/amdgpu_drm.h            | 17 +++++
 11 files changed, 186 insertions(+), 3 deletions(-)

-- 
2.39.2

