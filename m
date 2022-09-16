Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63331ECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 15:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5E0810ED70;
	Fri, 16 Sep 2022 15:05:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51F2510ED70
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 15:05:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yir9j9o3XkFVMM37B2JrRdpaOKBlgll+cNCJQ/0yRo0q9EDtzo9U0WpB5IClqIXaZoPKsgjJJwl41Yze5iomzSb8Njx/WQwzn+Z1OhHQWUtOKApkjM0QPI7jLgSDTUckBS0OykI47TlQwPb/BzBUwrL1P8t5A9OCDA4m8qRAuVmN8N2VaCCC7W86TxRWMCO8/sy11mCI4IHoBlWQhc1X1dTx1HTCbtJvkOXU/uNmoM12HJJwxERHE0IJEHw5sKnI0PO/9o1bcpgCFLmnHoskiWS+pdYZj2DClsuhRaehf+lzn+uS5fO6tWlurmNQ9SCm31jSEu7rEo7N3CQ7q6OpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0GB6ARtQui7rCqU4IJD/o3MXsMdMF6ootnvgggeq7Q=;
 b=ad+KjUE1HE/gMWO//E7tSgmnPih9JhxMwJL7/7u764vOFUEGbjRUNQ8HOA5gDpvrUuDNDMLtPe4W75eHtSVQhBqyWGMSGYZ+eNSEOpU0Og5p/y12NZgteNOllA7O99BCm5wFgMpBiCy8qfkc+AeMi0dSa/cAzho9IrFOvOYxumIAKKtc0EdyHiSxunP0O+RWplLtBKMwvAwCKrvq/1Sehn0/CnP1oV65falThecFm47dJg5gqeDf5zo5mBZgpM748e4ZSuZxKiPeEUQLGUOZ+fOHvux0r69ginIdMNn1/XVvPWWr4Cv2QqDC6sYhDU9rcWxBKCZAtKo932fxVLWdzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0GB6ARtQui7rCqU4IJD/o3MXsMdMF6ootnvgggeq7Q=;
 b=Z87v+GYWEIXeJkG2LFNN3NUIZCZ5XHrnMsnMXBP/Y7UnFxo5gdb9cbqzcXltozBzc+lRMxnNTZdtD0mILBRW3RkGNg/BiXZ8wJKAdRLYqtGhw45iyHPs/a6Oa7T28bTBktsafz7QE4Di3w/woCVYwa1WqkDdRUKpADsy+2vUqtY=
Received: from BN9PR03CA0051.namprd03.prod.outlook.com (2603:10b6:408:fb::26)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 15:05:23 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::46) by BN9PR03CA0051.outlook.office365.com
 (2603:10b6:408:fb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17 via Frontend
 Transport; Fri, 16 Sep 2022 15:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Fri, 16 Sep 2022 15:05:23 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 10:05:22 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/7] Fix amdgpu_vm_pt_free warning
Date: Fri, 16 Sep 2022 11:05:03 -0400
Message-ID: <20220916150510.31321-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|BL1PR12MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 7847a23e-48dd-4ea5-69f7-08da97f4e122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gw9pfaOycCOe2j3v+9k9TYyf44e/qLdB3RMAq56Lvp5Z3aACDSlHe043/vHfcmA30FppK1Tg0di9OgM6Fu8HVVl53KsMYdLD73HgQzQPlR6pW6sBrBXvM9smPg9LyDJ/xWnCs7L0Lh67VQbn61hzBrZJFLEUPImeoOQISMucJiCiwqIlL8AzO+CmXIAg7VOD5dPEeS8XzNT0FwuYctJUKf3quRGC7em/os6NDXyo9jQu35sJOuuFsZlfafxggW2BU3bLZMXouKheqqJ+JWusLXEsKQ9PLYzWDUoCS+vAyqRPMb2qU5b2003ODDUoLTYcT37P3bBc5CnMZPL6HQP+Va+MavP3Emq7nC/RaZ4mP7T9gCjA89+zj9WgdIdYJT1rquFuBaywLkffbSx4CUY3BMqROK/jz5A23ilYJJ2mAeJwtj95qzb3NUeIw9GAk/vrxSaQVxaCZTp0acozr3zjTvH8VAQnUHny2DoijU76oRY0WVtPUjw+qJ7ND9EZ2G1OSXMaUTZ+Rdiil2pni7ZC7zkD45b+Dc08a++9DjchVF9c9LO3MSnGjk9degJyhzmTFuJXIP5AzyXjp9EL7+4lN1FvBIxm+ek/6aCg6s+wbbt0JvZdaTPEROfmWOe/jLdFS2OpMJBI0in7Pzx/RIpPelLPbly+1FMY/RtLZ/Xb7nq8hM+88mRN0HAtI1KYo6K5v6NFp39QSs9dxjNUerikp+Z3Vc3Bn7Jb0z8dFZEObo6i+6+OMDT36s10PXljH1jOyYzRl4OO2fP1BM+bYpEsSrgstlmybN4q2vtVcfZ1lG4JDFfW0E+FW7i7ZMpncLlg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(81166007)(82740400003)(86362001)(356005)(36756003)(83380400001)(36860700001)(26005)(40460700003)(40480700001)(82310400005)(2906002)(478600001)(186003)(41300700001)(1076003)(7696005)(6666004)(2616005)(16526019)(336012)(426003)(47076005)(6916009)(316002)(70586007)(70206006)(54906003)(8676002)(4326008)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:05:23.0508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7847a23e-48dd-4ea5-69f7-08da97f4e122
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When SVM range is unmapped from CPU, the mmu notifier callback update 
GPU page table to unmap the SVM range from GPU, this is the unlocked 
page table update context as we cannot take vm reservation lock. If 
unmapping from GPU free pt bo, this cause warning as vm reservation lock 
is not hold.

To fix the warning/race issue, we schedule pt_free_work to free pt bo. 
This has another race to remove vm_bo entry from vm status lists. Some 
of the vm status lists are protected by vm invalidate lock and the rest 
of lists are protected by vm reservation lock.

The purpose of this patch series is to use one vm status_lock to protect 
all vm status lists, and use it in pt_free_work to fix the race and 
remove the warning.

Philip Yang (7):
  drm/amdgpu: Rename vm invalidate lock to status_lock
  drm/amdgpu: Use vm status_lock to protect relocated list
  drm/amdgpu: Use vm status_lock to protect vm idle list
  drm/amdgpu: Use vm status_lock to protect vm moved list
  drm/amdgpu: Use vm status_lock to protect vm evicted list
  drm/amdgpu: Use vm status_lock to protect pt free
  drm/amdgpu: Fix amdgpu_vm_pt_free warning

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 97 ++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 44 +++++++++-
 3 files changed, 117 insertions(+), 33 deletions(-)

-- 
2.35.1

