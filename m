Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75E2C61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 21:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80ABB10E8E6;
	Fri,  3 Feb 2023 21:54:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36B010E8E6
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 21:54:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNoMF/FD6D/K4WZ1prDGtjaBhLI2xleuBKwQWt9SvitjbpFTWylOMYSRcXGvGL8quhfGMKFuOos773INk8uybhScT5CbeFPzSPmlMZqf8pEYQFmDRg+4yLzOo8PHR8Pwt4tXWXNeiZ5PR9CXujsHGK9BVfCNKbZnfse/ioCGxfLMpTe1ltG6C77a05SYQPuFcjZ7NPlTEiZbwoVnJbd3pd+JAdiQ9KmMVofi0TE0v97EKtZ2dhYy8PKj2+AMsbkeZa26xXYS4vaOeT2zWKOG0arCMrMfNbBU6TkECk/iSu3HAdFyTwaolynabv87Y2pA/O/7he2wm6SCzGZiaXdi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVDRhJzxnOge+4hw4BYsVDpBjwNLMTD1AjKBGPofGVg=;
 b=GH3dC9vSXyWiRc9Dk4LUi2EZBTwXo3A7eBT3aEkc6jCwtjoLSJv1JEMY727XblSLdy8dGB7kyDyNTPQun504qgmVYw4BT5HS4yApzdzBTHjPhpK5dzKGCcoLxx/KP636IeKYE0vZ0HaJhIS0IWvoCa2pbaEDAVI4vCKig3IAw8PfzZCIh0ARONemDWoGjtb0LRjKtrJgc6nr308GpYyIm1p5ZvslE/XHHW0muKhGdqqzoV7BuHTct+gwSekT3bJ+b0IYwxLTCExivvnAYM7eIaIBYGd2zBDh3R7GNH3cfhiMv5zFlUnJG60RV268JKqVIhyK6hZWXWsUh0vIEQyULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVDRhJzxnOge+4hw4BYsVDpBjwNLMTD1AjKBGPofGVg=;
 b=bpkba2SBdIhrdYZYQJOdwwWb3sxf/QkFSIOfVC8yatZ3AEvI49KCXUwLmKvcATXwHIVCuJvDSSeAv11JJq41e+BnmXUrXyBRnr5hHxM8f97xoqbilFnbDsOBHjl8lCO5TbKEkTg41mWQc849GTNlG9XZvCyOG2bmjewE95+r7gI=
Received: from CY5PR19CA0128.namprd19.prod.outlook.com (2603:10b6:930:64::28)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 21:54:36 +0000
Received: from CY4PEPF0000C977.namprd02.prod.outlook.com
 (2603:10b6:930:64:cafe::19) by CY5PR19CA0128.outlook.office365.com
 (2603:10b6:930:64::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29 via Frontend
 Transport; Fri, 3 Feb 2023 21:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C977.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.18 via Frontend Transport; Fri, 3 Feb 2023 21:54:34 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 15:54:32 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/8] AMDGPU usermode queues
Date: Fri, 3 Feb 2023 22:54:01 +0100
Message-ID: <20230203215409.2021-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C977:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c7e6dc-2cdc-49c8-569c-08db06313cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RdfYpUs8p630jb1vwf+LhuiuCyFessx7V6urHUYFkX29p7LN+0hUHFIRaxdcZupowniTgY7V0MIAkNwrQg7EG+BxJTWzJfE7kxBAByHq2NVfUvliKf7Yp/4YSTTDnF5Az0xb5h00KAQXIkA7fB4OKmnF0hfnG3ndKMPI7APRVtO/0J69OPhagwWDq7B9AWjaCP0OKFn8MPeAGJeDKSigSFTcRs4pSjYwe95uFaajko8SrmG/Y7R/HWudfyg4hHdQy5+GhAmJdEagInWT/H4MPRoXtq5vw5KzzGYzNwwHNP9I484fwY0yvtAPfLXDmp6SoUwErYI+szguwb4mQsr8pNhsVzbhP4i10Tyeno14fGPJjLIbPma7LLAHMWSHykGPLMgaKGWw7IDeqbJ3evhWRNKpC0vRZyK37O3zmccjjyQIiWvYY6g5hF5cBUpLI5pnTxDSWyFGVnyBxi30xwKntId8S/1Doz2JcTLkvw8YWpg3a8fSl9wmo8OR/9VihBFNNW9HGrO0TNHUhnh89ll/n1r22YpCCeOXg4WfDTn9shZh8H4nDM+8vtVijFTHKoRD+bC4QfP7xb6+dyByqDqbcMhbRuYEG6wDZN6tG5NDsi8r9MdLHZkdWVlYC8lASdoajztpdnXWXI1QiDowd9Bw4rAuhbbZQCVOWxvNEaoXmWH9BgjNipvxL4S5QLNnTIWh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199018)(36840700001)(46966006)(40470700004)(356005)(82310400005)(2906002)(70586007)(316002)(7696005)(81166007)(8936002)(5660300002)(82740400003)(8676002)(966005)(4326008)(478600001)(36860700001)(6916009)(40480700001)(83380400001)(86362001)(70206006)(26005)(41300700001)(186003)(336012)(426003)(6666004)(47076005)(44832011)(54906003)(2616005)(40460700003)(16526019)(36756003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 21:54:34.5020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c7e6dc-2cdc-49c8-569c-08db06313cca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C977.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch series introduces AMDGPU usermode graphics queues.
User queues is a method of GPU workload submission into the graphics
hardware without any interaction with kernel/DRM schedulers. In this
method, a userspace graphics application can create its own workqueue
and submit it directly in the GPU HW.

The general idea of how this is supposed to work:
- The application creates the following GPU objetcs:
  - A queue object to hold the workload packets.
  - A read pointer object.
  - A write pointer object.
  - A doorbell page.
- Kernel picks any 32-bit offset in the doorbell page for this queue.
- The application uses the usermode_queue_create IOCTL introduced in
  this patch, by passing the the GPU addresses of these objects (read
  ptr, write ptr, queue base address and doorbell address)
- The kernel creates the queue and maps it in the HW.
- The application can start submitting the data in the queue as soon as
  the kernel IOCTL returns.
- Once the data is filled in the queue, the app must write the number of
  dwords in the doorbell offset, and the GPU will start fetching the data.

libDRM changes for this series and a sample DRM test program can be found
in the MESA merge request here:
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287

The RFC patch series and previous discussion can be seen here:
https://patchwork.freedesktop.org/series/112214/

This patch series needs the doorbell re-design changes, which are being
reviewed here:
https://patchwork.freedesktop.org/series/113669/

In absence of the doorbell patches, this patch series uses a hack patch
to test the functionality. That hack patch is also published here at the
end of the series, just for reference.

Alex Deucher (1):
  drm/amdgpu: UAPI for user queue management

Arvind Yadav (1):
  drm/amdgpu: DO-NOT-MERGE add busy-waiting delay

Shashank Sharma (6):
  drm/amdgpu: add usermode queues
  drm/amdgpu: introduce userqueue MQD handlers
  drm/amdgpu: Add V11 graphics MQD functions
  drm/amdgpu: Create context for usermode queue
  drm/amdgpu: Map userqueue into HW
  drm/amdgpu: DO-NOT-MERGE doorbell hack

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 365 ++++++++++++++++++
 .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 300 ++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  93 +++++
 drivers/gpu/drm/amd/include/v11_structs.h     |  16 +-
 include/uapi/drm/amdgpu_drm.h                 |  59 +++
 9 files changed, 837 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h

-- 
2.34.1

