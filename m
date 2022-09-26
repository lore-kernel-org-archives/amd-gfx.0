Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CACC07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 21:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE0810E7BC;
	Mon, 26 Sep 2022 21:40:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DFBB10E7B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 21:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GF5eAdazA4YA8USCu2T5ruBkCVFImDgNIlnePOoOyZIPzZMmGG21JCCnRDhL7fNutoMQ3A54LME7Kkct1ZcAQlqrF7Oc3zMRITva3KzT9d2LaHoAS7VHaJ8945Ll4oLiHMXFRCCRr6/gPTlU9iCCeF6Ly/S7GuR2kG0aR283QarkVkroz4L0xKXoJbEAfPMAeGS8U5X7C3cUrj1HAsJXJCaSh03pg/+9Pxwx8OxYicfD9y9GqDC51s005xx6xiYdfUg3A/BD//26selpzXJLv+bF8kmKEyLGXH0b2mjYnl/DX5P1Xh7luKQMliOV/pxfJC78UvwpqCRYSPw2xv6E1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9DCkk2ESxc36KOrJ3TGmjCeN+tLV/E/uqzQOnWnFKU=;
 b=KYvP/4+h2ElZ7/OCzD86mS1JcafVTUTjeCtAbF8AT/7SJk45mCFye/h2cnicr1jOmD8qOwx9LsSeegFW5oULxYCH6pyKFdkpNlJF/tY44A+sAZoW1pg6vIYOMTdLc1Pns2uBhMqJc3JSAaRTiOXH32d+Umh1DCVQaAfJ46fNmShSwQsUPc0vuIelThKcIqfgBsswUmU4Wz0x9zCXoi24D5bTljjHKNlXyBw79xHoFA0qGbY2i+trIXOpVvg1f1AFQIC+86VgLERevUOqUzMLjZqeWl7m9WfLHwxV9Hum0fkY2WlxYtVDUWscTw3wNd9ogzz8USFCaw+0pHtx/EAmpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9DCkk2ESxc36KOrJ3TGmjCeN+tLV/E/uqzQOnWnFKU=;
 b=1yQnX+ZCtyc+uEA9GPl0AyWR1RiNP51KILir2F1PEGo88/jk7XC5zo00kt3pYNy4MU/CmArlI9Q0d/cspR1qqFmz1hwLSuTduFsduCSMYU4X+rQuK5aM6pSzkpgI5cZQTkkGYu1/+F++Y+fP2NtbWqKjreWDnDR6YY/X14IJQEQ=
Received: from DM6PR21CA0001.namprd21.prod.outlook.com (2603:10b6:5:174::11)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 21:40:43 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::2c) by DM6PR21CA0001.outlook.office365.com
 (2603:10b6:5:174::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.14 via Frontend
 Transport; Mon, 26 Sep 2022 21:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 21:40:42 +0000
Received: from shashanks-target.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 16:40:37 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 0/5] GPU workload hints for better performance
Date: Mon, 26 Sep 2022 23:40:09 +0200
Message-ID: <20220926214014.5450-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 4853b53f-c947-4e8d-2cb6-08daa007c36c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWmk46dTnGukmmQTrRW06h3H7KvyF5oVBu0bKAQFNu+4+3vOilnBKsjW8lnk2QtKSt/IatTdVO5oz7FC8GZA3gGeb/vyJTDS+pJmLLhFd4L8JWCjHTt5ci35hvSoEpnY3szz5/2D7oGKlWF4mg8ZUxeVk+SR78X1HXLJ2YtGBcEfpbV3kmIM1NevosSuNWF18k1yaJNz3JEb16H7vR8iSJrNAkCvtCWaM1iaKZTvCNzbvfLUJrDUIBphI8X8IsnfHvdm4zZGxUUakopBog0oW5Lc2v1zn8xd4R+HN/1PdHOipgwhdr/ct3za7wV3q6tDVvJWlgwhoB6TgS99RkaoSvw6zm8Cu7dyx1UzG4cqgy9xwaFOjGi15Vmw6NKB2DT27BD97bSAY6zSxPoFcNOUfvmE7KmE5GwIgYFNggMznHxaexnzsOeYBZoRbV852RCXE7WsQFqb1YR2hsMLmIW5LRx9tHnv0zg4VtDoghAGGiLDQgX0qnxF9gZOugYuFPOajeGqfPjI9BjkINMwTRnqXE5vXF2w83u3fRy0ejigwuzZ0tHq8vxWz+hNKsYnSqMspXEFtaNiPy6oPPAf0/UHKGXo6V67+oBvfRxNyQ2EuH33aM0QReHZMBOckEaRJF3HKLNB7GL0PPw1DdkgFxoPQp3E9tHtzgyqOheJ/G3EJjfNJ9+RRMexb7th6Owot33i9FIG8lpfUIR4gD6Jq9yP75J7gn1bSnN+Sgyyn6ebJiD/ZLCOH4Q6R0FPDhiqMfKo/O7zAPY0ovw8ots1iTw7P9a3sOKT4EpeAw2k0TK0bqqEQZxvK2DEHIRQ69bPM5zp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(2616005)(36756003)(2906002)(186003)(86362001)(44832011)(1076003)(336012)(8936002)(16526019)(47076005)(426003)(41300700001)(81166007)(26005)(40480700001)(4326008)(8676002)(356005)(70206006)(70586007)(5660300002)(82740400003)(40460700003)(36860700001)(83380400001)(316002)(7696005)(54906003)(6916009)(6666004)(478600001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 21:40:42.8958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4853b53f-c947-4e8d-2cb6-08daa007c36c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com, Shashank Sharma <shashank.sharma@amd.com>
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

V3: Addressed review comment from Christian, Removed the get_workload()
    calls from UAPI, keeping only the set_workload() call.

Shashank Sharma (5):
  drm/amdgpu: add UAPI for workload hints to ctx ioctl
  drm/amdgpu: add new functions to set GPU power profile
  drm/amdgpu: set GPU workload via ctx IOCTL
  drm/amdgpu: switch GPU workload profile
  drm/amdgpu: switch workload context to/from compute

 drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 14 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       | 42 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 93 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       | 15 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h       |  3 +
 .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 +++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
 include/uapi/drm/amdgpu_drm.h                 | 17 ++++
 12 files changed, 243 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h

-- 
2.34.1

