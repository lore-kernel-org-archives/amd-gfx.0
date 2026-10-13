Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A62CC6B1C
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 19:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D44010EA30;
	Tue, 13 Oct 2026 19:47:44 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010064.outbound.protection.outlook.com
 [40.93.198.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1106510E921
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 19:47:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pf0lHsr4/ucBJS5jj5s597jTI2u4g+LrxUvcAhXWQHVS0IUGuyTX7jNjl0MTIQne8cz+dB+26qiKNPmObGImRvgUsrqjGCmSxvLM1PWGvqqV3oTqUd0gPMLUDv38fKEusjuzJWoiD8FsMsS/hWekVPqnkPyvfGOuCUAXHXNCkJ76fsWXt72CorHp3cnf8iiT14OFLbUI4xnhDot2jctl7fBFFsmUfuRMW636ytyYKAOkx5YKutkds8RGorBftO3t+Tffzpj7N2pChXRRJ1AoNw3+CS45VL+/DqBXBFwnN5JhREuSrsYCDjdwl6axYvDwTCGzgkKWGPc0CN6BUxI5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XK3QTxH0C7NjUR/rZBUjNa6dktDg6IGxJrLX9E2OGcY=;
 b=LqLNiWTHxJKGzrDgn0GRaBLh82TYh/KPINeq3MT3wcprjkKnx5+leU8t/HLt9fRq8Zb9azfeurDjp2xtIbVbuxj5ejoRC+YRcREK8jSbSpvFHAqQLdzpsLGRYyVCpaGrWOa/ZuCcory3UzUqMLZvoZSwpTHHsDadIwHRM+47x+/+/CHAvOMt9fAotxsxhrfP5Y4+d0EEdPtTuYcEQHnk+ilTHVN4cMFKlfjt9kWZlXDD9m4PInG4Fti1sKJ0xwUIcmBhQG1RsmJyVy88+j5OEUYthQ539mr2rUDlzbK8QeuL97btFcQRCoyHBb9Ku7LEe0tG8bdqdx8pMClfCdwOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XK3QTxH0C7NjUR/rZBUjNa6dktDg6IGxJrLX9E2OGcY=;
 b=HBfrlcNDFqyQFTW+JIpULzry2Exh6Ah5S3NPJtC+D9rdX4wlHY8USxnkVLFBgJQzwZPeHJIrmn/oXfwmWnH3DHHLeAgOAM8HTObHc4ODZ5iXTeEcO7n9wKmgFTqzqlX3eiL7QxU7/bNCt6D9IJ6DuNi2MtdyL34bN3e0+ZHT9JQ=
Received: from MN0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:52f::7)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 19:47:26 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::8a) by MN0PR03CA0010.outlook.office365.com
 (2603:10b6:208:52f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 19:47:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 19:47:26 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 14:47:20 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <William.Palacek@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 0/4] drm/amdkfd: Validate CRIU queue restore sizes and wave
 state
Date: Tue, 13 Oct 2026 15:47:01 -0400
Message-ID: <20261013194705.3687960-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8e42cb-bcac-47ed-101e-08df2962cedc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: vb1zXW5UbZqd0GizV73VcAuE4f2DWSq96b7hmyhQij+x0nUtGKBG5s8o1OeNNVj7VGcbB6ezLx31lBjVoQJkbSwzKYc92JM933v0vfWZZajHIDkZwVWGhIoAEPamO0Ewb+i+2Dx65pk52MJWwYri6CRSg63m2x91s/xUMYp5krAP6QewLh6LFxvWhdN/84hCSJ3fj7E58rooFyaDuEm0O1cNpwztDXZiy7TA0EwRUXDD+9hDcbyZvL6UDKUc+d8wYEVJ2MLD+NIsyvxt1sT4eeg0gMdfEHQyNZYfpIou2UEef5ZpGckzRsrZJlAqkv25HIuk25qKd8P0QWX3D3XlziT7cAnHhSqtL8ylSNHvMzXmFCmU03c2vL7In/UFgSHzFBp8sLGKZB5Ke6y8/1SCQbb14wguFH24jqKf2ZBqP/qST39t8Q8JhkJM9gMEYzgsFajnFsgyrCimLulVOG3sI1r3g4yADCnwy9DiviKkZlfJZJtuIGe6kRbEzaPO4YZu9HsHUIQDTCv7dY8jSomXd1G826BIOTOCHBQIbitSRFb0j/OZ8j/AmPu+5nNpHSzHWVJ8tvRDyTtr0EFxvZyeFGq88LQCOYJ3nLQNwNfoXMcP3ed5ftip9GF5Ua9k/3jLlCFO+EPw5PjGNB9X/tq5PWFSWRJg1q5YM/DkYutQtcuvfb15wzaZHQSMlBpINACG8WQMwIpcZILQHGEmVw/o3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Rye9gTgs06RUzVbTNsERP28o8lATx55qQ9mFw1cmod0LgpXus004QG0HxxdHDW+qdHChuunIPK+D+s+SLiKeLs1enJa55OBOA1hQloVtn1uWXll+AGkdZngLkObR/VOZZo+AtIwfUwe73axBaRgHRi9pPWKzTq1Suz0aArUJLqrFLgmaL1+OFgkcUI2mk+QSGzKC1lwJf+51JNVirdn+QCFTzq8eGmb2TTMAmfki0/cQ3X+glAycGkXHNfQK+afNVlmt7iU+uU7FOvxwsGsLGG2NRyLdXPFz213rk1P1EAZSA966nXVsp6e5X+2T47CQpK6nknkQJW17yE6Hmme7nqtNWqfsxIDAZcJWeW/JHiAcmYWxPm3sY8wZNXrgJX2aztaei+0BPa83LNOsI7fODJJyLMTOUZ8S+ltgFtfj5vEUSR6FyXa6FF1sPShUFFzj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 19:47:26.3525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8e42cb-bcac-47ed-101e-08df2962cedc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
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

The control stack and MQD sizes of a CRIU restored queue come from the
checkpoint image, and get_wave_state() builds its returned sizes and the
user header from raw MQD fields. This series bounds both.

1. Size the restored control stack from topology, as create-queue does,
   reject images that carry more, and keep the gfx9 MQD control stack
   size and offset within the allocation.
2. Fix the gfx9 checkpoint control stack bound, which stayed 0 because
   the MQD manager is created before the node is in topology.
3. Derive the wave state header and used sizes from clamped values on
   gfx8 through gfx12.1, so none of them can wrap.
4. Accept the one-MQD-per-XCC image that checkpoint writes on multi-XCC
   nodes, restore the MQD stride of the new allocation, and only restore
   MQD types that can be checkpointed.

Tested on gfx942 (8 XCC) and gfx1036 with synthetic restore images:
out-of-range sizes are rejected with -EINVAL, inconsistent MQD fields
give a consistent header, and a driver-written 8-XCC checkpoint (control
stack 98304 bytes, was 0) restores in a fresh process with each XCC's
MQD in place.

William Palacek (4):
  drm/amdkfd: Size restored queues from topology
  drm/amdkfd: Set the v9 checkpoint control stack bound after topology
  drm/amdkfd: Report only clamped wave state sizes in get_wave_state()
  drm/amdkfd: Expect one MQD per XCC when restoring a queue

 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 15 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  | 16 +++++++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 19 +++-----
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 18 +++-----
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  | 14 ++----
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    | 23 +++-------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 45 ++++++-------------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  9 ++--
 .../amd/amdkfd/kfd_process_queue_manager.c    | 33 ++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  4 ++
 10 files changed, 94 insertions(+), 102 deletions(-)

-- 
2.43.0

