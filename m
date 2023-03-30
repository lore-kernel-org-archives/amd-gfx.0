Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D953EC77B62
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 316B910EFB6;
	Thu, 30 Mar 2023 19:18:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E6CE10EFB5
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:18:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJok1jml74DmMm/ERuzslO5v8eLF01pvGjYPorSCduIRCU9ohLJ0JsmALwEp6rKsiYMOwVXtmra+O97BTsArEoYF+OBssjvn6Buo70pQK1UrLFJYQmavIjkRzoaLNZl4RiorAD96utmtDQoA5RdOJKIzfGzlLpHQOfPOf/wlRPZfLwaaATQPUgJQql9gD8txB+yOwnbr19LTVT8gDFj4dSNCGPyZpp0rSGqtl4ThQnJInq0EjnxpkVVzVisyeXwe0uFWQgFRYK6HUDGixcCvvmGLIm4GXbSmAnBpZRC5N3Th+MRtVPRh/tfiJoehTm3L2+I5jisCS0FMsXH/tE6yog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fh5Ig/lU3Hspq6IAuP+QtPnMiovc+pikmnM/fizQbbo=;
 b=T0hTAADtpCfOE098P+TN9TEqtaUZU71YGr+K58FX1EpfBPoTdwzLMpfdv83IrOwrtVhcTSook836O7djXInVF5CqKN2koC3SFwdGo/rCPKQfJQIrRIwtQZ7/uBVgdpSPLQngxwBBQKggkViEiTNiAEULIBnX20zO7rDPdbb/0NYutji5MABbyHRgCjC/2XDu5d92eRN1zT1r9Mv6A5YyS4+eWX16hwARcCeCsHdcXpKkeDgXTPb7oR21YJoWU+3sz0eUY0idnXrYK4M0eQ7AFd87URLtl1XN0cWGLe/ZxWDS3AFfPR3FET76c+T1YEjB3AhsZkvmA7M4J1u953PmEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh5Ig/lU3Hspq6IAuP+QtPnMiovc+pikmnM/fizQbbo=;
 b=UbBzq47qMGK6JXpU7rcfCovfnrrBlRjkv+utC0MjBKafhZAltR98xW9ilzQz0lQKNbPx9oVMWR3O+ki043h1MnlDAAMdk21lbe8pWlN1LQHp33FINdXHXbMXz/pk0iIEl03hhTNTK3afccZS/QSHf4wJipJTkoEZUIp+22paVFU=
Received: from BN6PR17CA0042.namprd17.prod.outlook.com (2603:10b6:405:75::31)
 by CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:18:03 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::a9) by BN6PR17CA0042.outlook.office365.com
 (2603:10b6:405:75::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:18:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:18:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V4 00/13] Enable FW assisted shadowing for GFX11
Date: Thu, 30 Mar 2023 15:17:37 -0400
Message-ID: <20230330191750.1134210-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|CY8PR12MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd97cc0-2df6-441a-fe05-08db31537bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbEcaxQSa2rCzHSBMFWTYauJ+ZOpsWBNtmXbhDsWJJX+//41x0ljiRlA2s7a76FJq7bh69wPA1tJ8VQXx+kj+Bpormfj6SE5UmTPrnwdsYIUFPHa7J9J+A579kbP95eyDKmvAWMje/aJZ0a+GJ6fLbN3yLG1limrCflUjKsFatJVbsRgeNq6bFrGUAs8n5sQ9MQcyTw5K6rL2XrACCaLcpdsla0dDPIv17vq+2KCzks8XMeXZKXvE0ZtP5MoXKiQnBb8TAw8HpFn9Bx432zdnPrl8ztx+U6wXqzuf2kpK1tEANWC6YJFVlo84ZmYOsulaXpdwmLQeKW4gf7PaWu/bHHf2RBn4ZkpvrczGg83gQOLok2nPeou3O3byKQU8xdsrJJCmU2xccHSgbYDqKILMrifMuwpiBHWCtQXuECRVNzjCTdsqjnrePBz2xbpRFeDLDpRzOgkkqhKZb0ZTW1Fd1NDnh4FUTATwK6dR/JzeBSyZhlUO87FV26sOaXn9tLbsqs+7gldbR/zIlba3+zbypEMgTVpxPRimoi7UNPM4n8REktFzwsO9U1OdtyWMViuNwoLdPtwufmlSUCJn0RskLGywf4SFyIVjSZfVA9AVdxDxMpwMg7NEI41Md0XD9cGGcI92fRmRpNJdpYfx0LIfkjYzN1gnji4B3+nignmRAvkDIWk7+T7PP19C+MGyfZ4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(2906002)(8936002)(41300700001)(5660300002)(70586007)(8676002)(70206006)(6916009)(4326008)(40460700003)(81166007)(316002)(82310400005)(478600001)(7696005)(40480700001)(36756003)(66574015)(426003)(2616005)(336012)(966005)(47076005)(26005)(83380400001)(186003)(16526019)(1076003)(36860700001)(356005)(6666004)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:18:03.1888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd97cc0-2df6-441a-fe05-08db31537bcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267
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

v2: Integrate feedback from V1.  UMDs now need to specify init_shadow
    on first use.
v3: switch back to legacy mode before fence signalling, fix debugfs
    subsequent MQD access.
v4: Minor code cleanups

Alex Deucher (11):
  drm/amdgpu/gfx11: add FW version check for new CP GFX shadow feature
  drm/amdgpu/gfx11: check the CP FW version CP GFX shadow support
  drm/amdgpu/UAPI: add new CS chunk for GFX shadow buffers
  drm/amdgpu: don't require a job for cond_exec and shadow
  drm/amdgpu: add UAPI to query GFX shadow sizes
  drm/amdgpu: add gfx shadow callback
  drm/amdgpu: add get_gfx_shadow_info callback for gfx11
  drm/amdgpu: add support for new GFX shadow size query
  drm/amdgpu: bump driver version number for CP GFX shadow
  drm/amdgpu: track MQD size for gfx and compute
  drm/amdgpu: add debugfs interface for reading MQDs

Christian König (2):
  drm/amdgpu: add gfx shadow CS IOCTL support
  drm/amdgpu: add gfx11 emit shadow callback

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 26 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 12 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 31 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 13 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 60 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 69 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nvd.h         |  5 +-
 include/uapi/drm/amdgpu_drm.h            | 18 +++++++
 12 files changed, 244 insertions(+), 5 deletions(-)

-- 
2.39.2

