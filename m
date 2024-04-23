Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB944C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 15:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2660010F741;
	Tue, 23 Apr 2024 15:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h1rnoLtE";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B4E510F741
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 15:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahzEU5NjTXyIt9FBcIcRN8GWaAu++OYG2s0IPJvVsq3uVEFHhFXF4X9RlLiuTBoCdZfnL3FuqoSyToYkNVr63p+OQt57vxzh39Tt1niS4OmD8m7UWWF0lok2BNV5azB74yjvL2pLTCdPW5Mrn2yQ4XeBGs70WRWBnnWP5kJ9xestTHIXPgYOH9TFL0nj9v+WYWVQUE3jc+CVv/PIszWkQ4R2p9ajvSJZ8tf2ytCNOxs5R0rAd5TaoSI8PNakaxOdCAgoXkSrrYDxHema1kARKvFq/ko0fAmYL+CgZ81YD1PjZaFsEsP3bAKKaLDq8jWMStr0EExCkNDYabKIA1z8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eh1z+V4tZ+6V2JdKMzmc+o1OpqE8IFMwFNSn5B0Pa80=;
 b=VWmpZb7K/Zp+OG9ei54cJD/3TFWPz9ZNlR2x7BfBUKwox/y6erOcBRWM0baeNf8/p4b7m65GgerEDw6iLslEiXzhjPelMSBtjuUuqGCa1DKC8vAY4OEqtad+9myioiD4VNjxucOC2s4yGLdQS+UqgyHo7XUjhmn6ScoxdlALjtSb1pCgUaTeY2/Cf7baajfPwX7gNFnOeI5xNRFMFJ1/10BmegUWQBaCmZyXchIv9myMuoSGDxVlrSwJOupyUXFFKlhgQyArzbK5PobtFY1160vhXqxUvVFoUZJp26zzYz0DQOo5g9LysvOpuHo9HQfOaFDRTOzQZmCmEpAKUwLswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh1z+V4tZ+6V2JdKMzmc+o1OpqE8IFMwFNSn5B0Pa80=;
 b=h1rnoLtEAQCPAMMVj2o6Kd+wC1iuglzIf5s5KLAWYGykWy6Qy6O3qvP/v1ozSGI35tIJ9tFPWFakDhSeMAhSEE3HvriWVeFAFhwQeZRFvu1CWmDp2H9ufxfnYtJXYqfUGvcWLPp0w5ixXPObvHpLhMCHXwtdbnWv8XanYXA1WrY=
Received: from BYAPR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:40::27)
 by DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:29:33 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::f3) by BYAPR04CA0014.outlook.office365.com
 (2603:10b6:a03:40::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 15:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 15:29:32 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 10:29:25 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v5 0/6] Best effort contiguous VRAM allocation
Date: Tue, 23 Apr 2024 11:28:54 -0400
Message-ID: <20240423152900.533-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DM3PR12MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f92bde-06ac-427a-3c8a-08dc63aa2c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PACHFDK+XivxLzl5cEq3Cg9vmfAErFk46mC6CwULgy5n+CDB3iLmgOJ9ZIK9?=
 =?us-ascii?Q?rjbUI3Uh8UG+XaYlo1ZOiCMtMRnJmX5HQd1MwEfjE4yX+Jd1mDELSUSKAIef?=
 =?us-ascii?Q?omay1Toa/TxiFhhGcQ2Ox8iCvfwyHHVunGuXL8A3HYjwmvm9R52NeZGPTRaq?=
 =?us-ascii?Q?WgQoJKUJV0CfGXv6q5f4G4I8uGeaR7e/vFZtQqmFiWVV/lXntqrInIF+stvS?=
 =?us-ascii?Q?xRLjP8aE8h35G5ZsoTQRnkSRhn6Zdhwc22d6vWipMHV4NWVp1f6f3l9egxBz?=
 =?us-ascii?Q?EgtYxe1SO0mVe1X+I1Sc5VWkMP0a0ewMgec43IIbR5VYd26CTZ48dM9dFKCo?=
 =?us-ascii?Q?foAQ0mFuzKr0ET5RzRAKLw4gT4vDWz9fQCDAfjBukm8XXpmW6yY7Vym0kqmP?=
 =?us-ascii?Q?+4NGx+CIp1om2kNL/yFEB2c1a/Q5ZaTSAInFE75IoKlwrFXF2WHhW5sYI88X?=
 =?us-ascii?Q?V46gOY4JP0JO6ckQfBfxa0oHSyLIJseCh6QtSJo3EBZSAdSijnEN2GtXfT1y?=
 =?us-ascii?Q?xNuOcATr+S7tS51rGjmZH/bnLEdGxJX7EfuozhxrmxEH3UsdgVTmb1lVky0i?=
 =?us-ascii?Q?H5/rmEswbq4eZ16BIkQ8+twKbx8NXiyTjMa8oLfUhKiLcvUPy6erQqwBCGMU?=
 =?us-ascii?Q?vElQxTpRUcTvB6nqEXe0qMA718SvkDX+4MQgJwKSUn3DC576RywfGEz1huww?=
 =?us-ascii?Q?3rLAGSNkRWRevhkFNiDRTqIjTnIEYyNNOxUkn2nkZmKGdp4aTYtsI8tptf2R?=
 =?us-ascii?Q?jB7QYAFWtdIZKCoD3Cyl1ECOOSo7DlfCffYXMH+o2mSoLmSj1Adw3u5UA5+L?=
 =?us-ascii?Q?PIzd9UYXsEeOl9vPtiXTWk/j8TFK7JOtz4WoZLytMJlDNluGbzO8ceXCrqrg?=
 =?us-ascii?Q?4QKcTBXUCUsYiLUYnBRpHuiHu25/LCOR5SAmGeDtR0SaXwTsh+jjk5VvKcyn?=
 =?us-ascii?Q?VU0aEZ/k2Rfx88WBWp4b2wESde3qRoY/RlVah6XH7c1CSKdBzHjW0wJB0mG/?=
 =?us-ascii?Q?1iNjI88YnA9zmQE1aIEPZrUMp+zIXMQTVwrUPYp5zpfBXlKZVF4fRPa7+5LX?=
 =?us-ascii?Q?y8NmpDuCPro+RghG8c//pBU/Ev55uLvWxtMMBgn2lUEtWhFUSB9l873CIHat?=
 =?us-ascii?Q?K+o2vMPzjnzZr8STPQvYS+AJjNQ9hzY1OZV98SbEP3Gl5lBOzYmuJECsflSg?=
 =?us-ascii?Q?wo1FkVQYVyKECc4TkH1Ks85C3wAneXPdFyouqFlcz8L4CNHtIo8BjQT8fuj5?=
 =?us-ascii?Q?cXLtsyZ2e2LnYCWo+E2NGLFnRTsEYBetIwZWCKWNTRihBMLLaPOTZypAK68k?=
 =?us-ascii?Q?31uxqcv8JUgrJpYPWSC9vBGzq2lU8sgz7rTt9wk2jqH3ZZXDWaTVR+aZ/+Ye?=
 =?us-ascii?Q?QJA6QR5aU4djOJA7Sd4vrXdfBCFd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 15:29:32.2060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f92bde-06ac-427a-3c8a-08dc63aa2c97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch series implement new KFD memory alloc flag for best effort contiguous
VRAM allocation, to support peer direct access RDMA device with limited scatter-gather
dma capability.

v2: rebase on patch ("drm/amdgpu: Modify the contiguous flags behaviour")
    to avoid adding the new GEM flag

v3: add patch 2 to handle sg segment size limit (Christian)

v4: remove the buddy block size limit from vram mgr because sg table creation already
    remove the limit, and resource uses u64 to handle block start, size (Christian)

v5: remove patch 7 which is not for upstream, add AMDGPU prefix to the macro name.

Philip Yang (6):
  drm/amdgpu: Support contiguous VRAM allocation
  drm/amdgpu: Handle sg size limit for contiguous allocation
  drm/amdgpu: Evict BOs from same process for contiguous allocation
  drm/amdkfd: Evict BO itself for contiguous allocation
  drm/amdkfd: Increase KFD bo restore wait time
  drm/amdkfd: Bump kfd version for contiguous VRAM allocation

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 20 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  | 12 +++++------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 include/uapi/linux/kfd_ioctl.h                |  4 +++-
 5 files changed, 31 insertions(+), 10 deletions(-)

-- 
2.43.2

