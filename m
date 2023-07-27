Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23F5C0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 18:11:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8113C10E5DF;
	Thu, 27 Jul 2023 18:11:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FACF10E5DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 18:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeNpQPpjfNzzQzO7SvlPknJ1+8W2vb6+M0o9y18wAFRekfTJykM1HPmP3jczByN0hwAw0db0dNjuxmxd9XE0eJJkjJLpRqfR+rPZeak99zF32L6Xao0E46qsC6hR1Om4ci0/XhBmVhp4aZY4JKu0Kl19fuxX4t96z+xHTFy3qxFwcaIrjFpj5y86mPjW7VHDn9DXfTj9SYFk2mBFmTswJlh04jSCzhjX1h/xPXJxbXqDQl/SqusInH9hUTqmYB8B6EYDPczsH31iOybRZ8kn76cDxMzuCyPqAH0FSz4z3ujARmwAYaJh6HP0wElHVbf4VTyk4Mb+q+5nZ8qZSXqQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAweF72OjZxX59/K38XsD4/iDF35v7UgZkFGt62C9Y0=;
 b=DYMVD4eR/fDfWeEPQ9j8cdJfrRYQMs31lecdiGHMiYm1HXyhxWB4jE8senMYmZBJLXs+i1LxxrC6w4cW22e1VAstpzKAHZ5B1CmixfpFDr36wtuPY+TRfcR1XHNIhsovtvxPPDun2nfeM3DdBxStakgj+SV/tI07aYcRfvHzGMcJYjK7Pz01BbahxVpK+vxGTaZcjF+CVnVOaPOL01MvdixWCsnubHnOg1Y106wYmQj5ZGiXO6vNEq0vFqN0ly4Ckk3xvzJ9AX04z8RmFGcvXykUHAb7PzkWayVCvzW9coxA5c6nIXocX/NJ+paKNV1caMBhR0UBayNlFfkvmqXHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAweF72OjZxX59/K38XsD4/iDF35v7UgZkFGt62C9Y0=;
 b=wgv4a52ECku7/WecmIAvroYYiCKEJf7VJaGjKQ7jxQvvs/dR38o4ukDg6069oKeVUwdYE4M+9Sgbgg2emf3njmD0teFRR0oEbqNZAbEF2smo24uRr/7FvL4EAqp2yXIkEXUhK2zvqgIc9qwMGR2QEhhHfLsU+T+CouQk8HU6KPA=
Received: from BN0PR04CA0087.namprd04.prod.outlook.com (2603:10b6:408:ea::32)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 18:11:19 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::90) by BN0PR04CA0087.outlook.office365.com
 (2603:10b6:408:ea::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 18:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 18:11:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 13:11:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 0/4] Add GPU page fault query interface
Date: Thu, 27 Jul 2023 14:10:44 -0400
Message-ID: <20230727181048.1222388-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e74d9e-c773-4c59-1ef1-08db8ecce001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGrf1zLzgTeV18ndZpDeeUrMriA8f4G7H/b1ExDHR+n8aHl7+rUn4Fxrw/XKt1axByt+MzPFdJ6TcEqew7bJn+eUvJznr/No8Fqj9PFCxLqdtksMgQHmVZsm2xxxFx5ENtUI56qC+Sj3E+2PWxTcrBhoOELm56TruaniUQeOxsW8kIokPAgzEBVI0i+6gGYcza8VFEs6IX04WMf3r1DsQbinUG+67UDaH9mWCZsJdnJpSaCVGirsK45vfqSyRASnQRUk8Fpp3PtrR1rWCQCAUQTQZz/JzUMnYhfMSGonjmJT5JaigLr1MVf4m3MZhydB+aRjIJL3/B7KZgvFsFHWkp6XFXjmbxWNMOXfhmOj8+Ba33rLJSLZV4WWR/gBGCi1ZL4VXaxLMbBI691kyjDSVZ1khBYmp91z/bePWHnJBi+hSMGJXARonACtbU/I1IskCVDWIY4uy+o4wnONlwU1/Z2yiz3klcrQoA4XK2P8GvkptvpAKUMnafbirLlM9KF2OyfS1IMhDhYs2rINwi+Mr63AEQhdHhmNlobs+i9QpY/TRxhzoQYjM7UIetQuylUTNljk8/STV2sYoDMSFlULBlOSFk4YMwC9Spx1xZhlCEDBjkwMmaW2vvMc3YG+Fn5/nHJm+956P8TH7X83mjPpgva6yrm5R8bT6ap7pu7vRqU802ASjSH0ls3xv1GgXRIXFWBjzC7RRveHQgcROZjBGPJLVmuevOe0saBmiEA59cFMxmm9wWTyvkG6PkfZG0HFF0fn5TheYhT5td8l92Y7V9N1uj+ya5WDTrHHgA+qgiU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(966005)(40480700001)(7696005)(478600001)(6666004)(86362001)(2616005)(426003)(8676002)(16526019)(5660300002)(54906003)(8936002)(41300700001)(26005)(1076003)(186003)(2906002)(336012)(356005)(82740400003)(81166007)(36756003)(4326008)(6916009)(70586007)(47076005)(70206006)(316002)(40460700003)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 18:11:18.5230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e74d9e-c773-4c59-1ef1-08db8ecce001
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
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
Cc: Alex Deucher <alexander.deucher@amd.com>, samuel.pitoiset@gmail.com
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
v3:
- Add locking in IOCTL query
- Only update cache if fault status is valid

Alex Deucher (4):
  drm/amdgpu: add cached GPU fault structure to vm struct
  drm/amdgpu: cache gpuvm fault information for gmc7+
  drm/amdgpu: add new INFO ioctl query for the last GPU page fault
  drm/amdgpu: refine fault cache updates

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 20 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 50 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 31 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 11 ++++--
 include/uapi/drm/amdgpu_drm.h           | 16 ++++++++
 10 files changed, 135 insertions(+), 8 deletions(-)

-- 
2.41.0

