Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469E2C74A5B
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 21:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E2210EB32;
	Thu, 23 Mar 2023 21:40:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B127510EB32
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 21:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLVRs5lfPXXESJm93CulZHiwSirT3nL/nUNmHtVgFRjU+WYhYp6WyWZiPEd3KgfLAk3QJVZk8gM2ej3pJESZnwZt2OokbJER6bsj8D32OvInPxP2v8UQh3Gr8YX5xcyYoBzf67cT0IQZ7Iuk6zKGuGE9AE4RydWqEmrXXfoZq5SdjPoTu+XQId49eZxMrNp5buB5JtsTE4P8/1T2O8Hp/ZldfMFFmp1FmGDYRwiTS2AhYVUmN/SJsd4eDKFITb9L/nzDOL2GYo61iAj+guBNqY+MF1Lr20FYT5nytyU8HlgBlWqmLupqHg3BtOdUIPnOPVtnGjvndFP7290zIHaW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4kP9Y9mKdrtSqONAU7L0ozwTP9pEEY+utkuiCXvmTc=;
 b=ajk5PG7FeLnS7nyxqe9386zgGL+jV7ZUYEv84bTohVjin0o1CZmSm4Kk0R0kMOU0wtidXPztvZ1wsrfSK7KU16Lo1WYnvTc2r2dhvJKwS/3832c3GBU9sCHx5vq7Ab3CuTs9+S0vfEzEgBmTR+z8MKa+GBVo3D7zZ37gu55uCNuhPYPzTO61qXSspG/12Wpr6zrJJGgm7CsTIsqHJ9XjHIL1rMsw/PNS+e3jhGtew/kzZZa6CYT5Lnv7zSmuApvY3sSil1uO+AJnG0A+gXa84qDNDEWUE36uz0aLA12Z1H4FwXsfDifCpXYLaAY27wz39kCSltPoxkSLCAHFK0lKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4kP9Y9mKdrtSqONAU7L0ozwTP9pEEY+utkuiCXvmTc=;
 b=45aLVzpi1P9V5kzkE23lOgdbGmORQ2nA4QfJpnb5xGtz9h3n1hBPVgNqzx0J/UjFGwubTahksL7Tr8rG3cOlMu44Px7ANyoGwYL3K56kzESYkHG2a3sKKLlWhkH2mH5gzRWkm0jYAKuJClq/VvrQKUlyNf6ckqpf90jyO6Vg3Yw=
Received: from DM6PR06CA0097.namprd06.prod.outlook.com (2603:10b6:5:336::30)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Thu, 23 Mar 2023 21:40:49 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::70) by DM6PR06CA0097.outlook.office365.com
 (2603:10b6:5:336::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:40:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 21:40:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:40:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 00/13] Enable FW assisted shadowing for GFX11
Date: Thu, 23 Mar 2023 17:40:21 -0400
Message-ID: <20230323214034.1169310-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 153d6f55-c371-4470-7864-08db2be74492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6h89nYu1kfUlZbohgb6CQ2XFY2JqAAhpBGwliVti1wS9H7vqFA0FhgwR1xF5evrmGpERryI4yb+y9y+Cu12ane6wcBZKEIFSsvNuBOrv7O8t82ihFArug4ehitzhyAF9SuSTHP+1RQ0q5AjmADDRuNQGVQeEj6tRgKVJ5W/7bBXtcKSoTmcqSLkcEEsgwN1ao5ROERHcSkSsRF8OBKVSrX9nfiMTddygCYR20cxLCykzaLWwyM7a6Ge38jMxmHPYFG5ckY1Lp/xHquZdscLNM45mA55M0cX6oNpCI+ypo8d1wdjBOcQRkohNHo2YsxO/DawYjlD+ABLjhp04O3JmnKAIIHQIKHX2HEUDW1rc/ZugsvhMgA/ePr8qm9k0vC6Ps9MSmtF2+yx5utrYhE8qrBnbH9loCsH3av9ZM86aOlVJD3rTQTQQJ/HGGpLK8JNVoczVNd3/fgFimvmKkhz42OH/RVHLkgRfwLaqnWByiojPmfKbb3T/gTeS0DqHF+r/nnaQLwyaRomjTGOzmggnnNQWf4LhjaXS41ecA9Y0fUepKJ6FXxzrPj/9DWc0nZZ+jtqL3LmHSAFoQivDQ6yCEVWfCr7jL9BdHaWcUqMRvsP6HegLotIhQ/WODY+Nu8lklFcAqmhcso9q0rN/T6aU24sT+TreOuL/KzIji9IdbqK5d/TjQPxcN5l/t41ldGSN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199018)(46966006)(36840700001)(40470700004)(82740400003)(5660300002)(8936002)(81166007)(2906002)(41300700001)(36860700001)(86362001)(40480700001)(36756003)(82310400005)(40460700003)(356005)(7696005)(966005)(66574015)(47076005)(426003)(478600001)(83380400001)(336012)(2616005)(186003)(16526019)(6666004)(26005)(1076003)(70586007)(70206006)(6916009)(8676002)(4326008)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:40:49.0165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 153d6f55-c371-4470-7864-08db2be74492
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069
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
v3: Integrate feedback from V2.  Drop GDS query, move query into
    dev info.  Add MQD dumping for debug.

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 12 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 19 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 14 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 60 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 72 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nvd.h         |  5 +-
 include/uapi/drm/amdgpu_drm.h            | 18 ++++++
 12 files changed, 236 insertions(+), 5 deletions(-)

-- 
2.39.2

