Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D61C6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 17:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D0D010E604;
	Mon, 20 Mar 2023 17:38:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64F2910E614
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 17:38:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFOsp85Wt3cngmsIrDA9R4l7v7WhXWTgVrPsK9a8lj2+2C9ktuR26uj/GumtSRYY1fDdpC/DT+HwWntiSe7drwfd35w528QIYF6Ke7aeo9KhsaAPlqAmgIufYHgYU7bT/e0qPJCdowf6poJyPHadx98+4GBf8TaGGO55kIrELB5ZROu3/UPsWMkZt6MhqmEUli28/v+S+Lv4Y6XI6DaNmRLmfFQWwcWkRTCxSHiZ0xo6jqudS4iQF9Zs1HP51HH/WevNcP+Mbe2l8AEvzyx9XVggLgTGHmXRWPn2tPye5CqfS+LHfcgD0C3/ARWB+0pcYZ81jojHgmg/znvIrAsPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SQTD/1wUu8asJrcZCgc+oMZ79UgVBEUV6frkppYBFM=;
 b=mBVrPLWbESLprPmzN+UupmFnqL1RLo3eAkGT/s3LJI/t5qXEHGZzlP+KSoXEASK/iQgLp9Oe5MFbSvsYrTCtXL5RwrhJHk4DxQ1U/wjWwKYNCQfHVppe+fZEnkhTCn1iHWBx1jxXeu9QlP4Bed0d85kv5qOOsxznck3e2FXOT9JTG3Pq6phgxXnGZlvIR1vzoyFE5aL1IymTQZ1jJnWt6N+eliC3mryh7qwglcmETEWRfgLUzgoMPcePvVnN4o4B6lzkgTWhmCnF5XSF1Wqd9WCve0QwfIVWT6x4susztYVFo4GF/lyu8OnPFDZouA7cZK7woXtE9GpeEsOCwjJDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SQTD/1wUu8asJrcZCgc+oMZ79UgVBEUV6frkppYBFM=;
 b=zVHinGJAFAQnGrmedafVLqNA1Lbh3RDqJx9GKBwxHcnCcFsY3rzDAyxMBBLDVaZds3Jh3g9ZB1M+YEIPmKcu7ukiOLjid/OsXzcng+fx3N8bpbtSn4tDvgpuMi8bPO9QpsJiIB6CaNCwPj1Q9lpO6Lia6pc/j4dFdrZ2MBa7DAg=
Received: from MW4PR03CA0155.namprd03.prod.outlook.com (2603:10b6:303:8d::10)
 by SJ0PR12MB6965.namprd12.prod.outlook.com (2603:10b6:a03:448::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:38:25 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::68) by MW4PR03CA0155.outlook.office365.com
 (2603:10b6:303:8d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 17:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 17:38:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 12:38:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 00/11] Enable FW assisted shadowing for GFX11
Date: Mon, 20 Mar 2023 13:37:59 -0400
Message-ID: <20230320173810.250835-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|SJ0PR12MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 476fdd1b-2fc6-4cac-e762-08db2969e873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/bAgPfr0DjWhoOv02/4p5lCdYUC6hbdMEGuXnnv2NcAj3GlcHiiT2Wfuch8LVPC1wV1W0yFCe1rcQkY5pPiJbqzvTpg6pqg99IEu4bvSJzFhaSY05u2/GEQ/uhhI0WHY225b4IRlt+C0lkkomSt+CasykHhbhymk8T7vu0hKHErf9AK4E31L4pAwn9EOGOA/BqUfM1FNG8tJP5CHX+PawcaEZRI7jsjzgjd7chbm13W6Rd0jj3lLdLCqEauKIiLrMlAAMGtzmSzmjILWdT+uwugpuiDI31e+IC5kHTBBg76pKEle5t5gA0Zi83Z8tQhR6Zg1rXPnaSqvL/1f/FzBHDYPjqrL/G/YDxiw54nWosGUazsjZqgAv+U6mZMLzxbpItcy/Dc+A3VCOJLkFggwSgqv4LCEvxa+60lfYThJNQ6BWLybuQ6mRYTUa5jQFGStLaqXmPlUZ3KytUzwRGnxxdt2Ese5CvVoZ9gJH9BI52TWE9+COjGl4uQmH5FNy35ul55Qj0MPNB8L2vVBusFpozE2SgBnjtQXU+1YRReZzU+YhMVHZbtdRvOEd/N18TmnrGS/geFh6zF3PJLHSJ27QMp7q35EypY+HJm3VTJWIPkiJikb8Tsyo9j9tFvETxzAoAY9IaO17zDctjSlbn1Xs/Rl/oOOBF8AUmVyHiFhPyXlN/+kXop8vLSJTRwWIM6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199018)(36840700001)(40470700004)(46966006)(86362001)(316002)(83380400001)(8936002)(16526019)(336012)(40480700001)(36756003)(1076003)(41300700001)(186003)(26005)(2906002)(426003)(66574015)(8676002)(6916009)(70586007)(40460700003)(4326008)(70206006)(6666004)(47076005)(82310400005)(2616005)(81166007)(82740400003)(966005)(7696005)(36860700001)(5660300002)(356005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:38:24.9709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 476fdd1b-2fc6-4cac-e762-08db2969e873
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6965
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

Alex Deucher (9):
  drm/amdgpu/gfx11: add FW version check for new CP GFX shadow feature
  drm/amdgpu/gfx11: check the CP FW version CP GFX shadow support
  drm/amdgpu/UAPI: add new CS chunk for GFX shadow buffers
  drm/amdgpu: don't require a job for cond_exec and shadow
  drm/amdgpu: add UAPI to query GFX shadow sizes
  drm/amdgpu: add gfx shadow callback
  drm/amdgpu: add get_gfx_shadow_info callback for gfx11
  drm/amdgpu: add support for new GFX shadow size query
  drm/amdgpu: bump driver version number for CP GFX shadow

Christian König (2):
  drm/amdgpu: add gfx shadow CS IOCTL support
  drm/amdgpu: add gfx11 emit shadow callback

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 26 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 14 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 19 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 26 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 74 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nvd.h         |  5 +-
 include/uapi/drm/amdgpu_drm.h            | 20 +++++++
 10 files changed, 192 insertions(+), 4 deletions(-)

-- 
2.39.2

