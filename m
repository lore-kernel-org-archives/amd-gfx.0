Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC87C32771
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 15:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A387A10E324;
	Mon, 26 Sep 2022 15:03:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0778310E47C
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 15:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JI9xM25doY1EouvzH2ncOAysFyM29PMQoG2yhl531iYn4B5aexzCJKHDIRbGWKK21WotRipFTl04th2gybjtAJzW++0/mGKd+WjZY6tKC0vyPfwnpL1ei+BuCievgJNlFeryBZjsVbjCd6UFDRGsxpN7jhNT2Yc6DuJlt29uR3H/PNkMH22EPkc5KAvywZxucVT56L91ZzyTg8uVU46PvnxEZ3JlPP9CRJyLI7JCrrF+y8DcM+unK9NvigMSjDGAYc7rjIeAUsJNKW4NN12duqcmzQJbgQsB2+Caxz5KVEDMg/4FH73z3MFDNF9KIcdaFwsp3OA4BYXviCtX0JTK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mw1qOClxQjarJXuBpuEGNefeJivihyaCGvUFC9/JT/k=;
 b=dXYo0qLEjawXSoFWx7bM95pIiB8uRGl1jntrAqKNLsh0thCRDgW8puH/ZMuhBSb+ldwZ0fh9QT2cMlBgFerjo0pj/kBlpBIX/RhDJLxvS3RJPd7kxbZHPv4+q+ErDlh4fGv3RkERdNl5kvrqqxwMFdNKHV+ht3WATVf+TwkKLAH27vYGoUQByGiSNr2qg8u9ufhSuAd+uHKtNGsMe11jCMeZdX4L2tZfXrWMvMxYILAhWJ57NXSGTpEYhtsgXQhjwiL6oFkl5cGlB5CGOnYoSzE0VNS1VbtPchOiudkSc1UWd6U4p7BrzrXuUjcZKfWmjCbSY/XGEjyr0YiT/KllvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mw1qOClxQjarJXuBpuEGNefeJivihyaCGvUFC9/JT/k=;
 b=mclgPxgZQYKxqalKrCg1i9AhchIw1tZyCW0cjUUtO3vC+uBjLTYQupGThJSmSdw5UCWsdQMUufOHLTBx45FOiQOuaR5GarfAFKup+ERkVoKkZ3RdqnBGhgMgKyl6EXQFd/B3nrvDaa+uLdNYp87jGxy33rzS1Ma3z7ecuM1uVSA=
Received: from MW4PR04CA0231.namprd04.prod.outlook.com (2603:10b6:303:87::26)
 by BY5PR12MB4920.namprd12.prod.outlook.com (2603:10b6:a03:1d3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 15:03:09 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::9) by MW4PR04CA0231.outlook.office365.com
 (2603:10b6:303:87::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Mon, 26 Sep 2022 15:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 15:03:09 +0000
Received: from shashanks-target.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 10:03:07 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/5] GPU workload hints for better performance
Date: Mon, 26 Sep 2022 17:02:47 +0200
Message-ID: <20220926150252.18635-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT038:EE_|BY5PR12MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: 49609574-8f3d-4929-03fe-08da9fd03979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pa/AcGmXnDRtiAkyDNUKVLiylpatY3+s+ud/iJqPysAa1snLxJs/zhmtb14WetTURF3Bi4Q+aSHaIjiGLBO7oXr78t0fzv6lmsaSGLe5G5p3nmqsLYApeSqkQh/gMtAW4hxKvTOptNkSQUGx5GwYAXNDhXtFHzUulNSIwejxhfPLEy/ueh9ALevbguQGOmM/L510aPCyplWed+VkU6g80MxcQrgkL2b3n1Ecd9ljUq4D8XFaOy8mwCqCjD9BDGosTIx2/mn8TnUvFAtU79upjEC5LJ5XDgDbKvKQNJyM1Cv+5Q7qQRf/4Md4Av25KmwoSYAWEh+TbQvih4SdZVeBmnKPOiUDoo2fWiLzflUuJTO+Z7znbKL4tY9Xs0OzqmeHra9CUtId49scKitt4FyM5ys5q4NzjhEltCD5eC18AbGcNvH48fdxFox0RUq0U0Xvi0P7jcgWI3H+FlqEBzhG5hvEA5n1eZcwwJTpw/4LzqrAVBw9xJ58QdtNtL2+bnbGhb+mVj/Eu0XwJu0+FiwIHYKbJMeX0T0qDubD/Zelsg2vsoXDJG1KxLthy8T2EI3m3r7OJZF8/PnAkMe9XykBY4BLP8JUQo6yvAOGx9t4IdS+dUTtrFoDVMgSo2CB9vxlH201gMe2RfiRUBO3sde+VHKYNHT4akMskVVVpMT16hJxVNQIhDy5hzXRU8ytVV2+IPcmKcdCnhLDIbL+moY8zXqvKpqUQDIyC4Go1QTxQV6gE2fJfsxIDuFiCrAP6yLBiF75t0mgTSaLoJYyif3VC/YEZAE1+lLwvtmaSzq994vtt09a0T9cUi3GEZod2zC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(2616005)(47076005)(16526019)(83380400001)(336012)(426003)(186003)(81166007)(356005)(1076003)(82740400003)(36860700001)(5660300002)(2906002)(8936002)(40480700001)(40460700003)(82310400005)(478600001)(41300700001)(26005)(6666004)(4326008)(44832011)(7696005)(8676002)(70586007)(70206006)(316002)(6916009)(54906003)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 15:03:09.0717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49609574-8f3d-4929-03fe-08da9fd03979
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4920
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
Cc: amaranath.somalapuram@amd.com, christian.koenig@amd.com, Shashank
 Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMDGPU SOCs supports dynamic workload based power profiles, which can
provide fine-tuned performance for a particular type of workload.
This patch series adds an interface to set/reset these power profiles
based on the workload type hints. A user can set a hint of workload
type being submistted to GPU, and the driver can dynamically switch
the power profiles which is best suited to this kind of workload. 

Currently supported workload profiles are:
"None", "3D", "Video", "VR", "Compute"

V2: This version addresses the review comment from Christian about
chaning the design to set workload mode in a more dynamic method
than during the context creation.

Shashank Sharma (5):
  drm/amdgpu: add UAPI for workload hints to ctx ioctl
  drm/amdgpu: add new functions to set GPU power profile
  drm/amdgpu: set GPU workload via ctx IOCTL
  drm/amdgpu: switch GPU workload profile
  drm/amdgpu: switch workload context to/from compute

 drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 14 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       | 56 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 93 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       | 15 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h       |  3 +
 .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 +++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
 include/uapi/drm/amdgpu_drm.h                 | 18 ++++
 12 files changed, 258 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h

-- 
2.34.1

