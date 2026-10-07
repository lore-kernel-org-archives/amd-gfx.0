Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CB5CA6002
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 22:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C89C10E6BF;
	Wed,  7 Oct 2026 22:16:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BD8zjOeO";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7542810E6BF
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 22:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHDdHgvfKZ8aZrJMEAAtoU/tfJ88RJshLBs754Twa0SgaTNQIultlY/C+iNL3UypqmeTbt1HwDQkIASZG5pB6O9FudX5wew+pWTZh2KVhElCtYuWrn+bk+W6NWUdu/YE5dV5TFuo5Kzh+5MQMBcZnOX4QpaBYlcIYEEPh0lIGdyCfSMWThKP3KbcEn63wzWgNRzOu1B9hVrF3oEf+GgNB63XOZau6HI/pr/8gQQZ3HdPhxb2hYY9D88oOrhdKZB3zR6wkGapNZqK8A1WR/RWEaToudiFlXZ0ZAdPNPPsFAHnq9+2e6fz6D/hPSIwcmLVa813/utbbEyg1M+UmNQN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Az9ZEEazCM9YNJHu7UauHoL9Rcmr/IQN3L1yFgcbhtI=;
 b=Wd1hIlt6EK0FSIqnxGbM7lbVqaNnKkblPwQ6ZCYPn6m6HJIqmPW+GTVY3jCLifIwW1+SYkOsBf++1L2My1agxGklXjImWWmVb0hfXGQAnkJiT/90hCsEs/jNGb1AvQ/f7SI0hDhNrPUyOP68+kRAPGj9IwrJciF8DcANdbrWzJCketkulaOHkvJWqpNMUoJhIrEnd5kp9ER3Nsv6SONO6FH6BKMc6COR4x/nlBxjr0hd+aZFXajAf0vGoHR+0mlKLmgqwQ0bIzt3Uo1kJ5cipAWA6eetvyMUy+ENZG/ohB/flnJuVbWAj9UOF7EcgzPlaSJVKitHrfPRfFDWrnBRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Az9ZEEazCM9YNJHu7UauHoL9Rcmr/IQN3L1yFgcbhtI=;
 b=BD8zjOeO2LnvoL/z8axV+o2nBqZco3J9Hbs9omp484t9/pYlqn7X1Pf6RUAfJFxScU7cj4+iX4oxKBAvdQN5A2TV6CvgQ/OdkgeIqT406R/4au1CXF7BAj9VZ1r9fw12m0gdhhS+4aV4/EeNMvaWBdhFDwqtmtCxRPIIsNKv7u4=
Received: from DS1P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::11) by
 CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.16; Wed, 7 Oct 2026 22:15:44 +0000
Received: from CY7PEPF000000F0.namprd05.prod.outlook.com
 (2603:10b6:8:455:cafe::97) by DS1P220CA0002.outlook.office365.com
 (2603:10b6:8:455::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 22:15:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F0.mail.protection.outlook.com (10.167.247.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 22:15:43 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 17:15:42 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH 0/2] drm/amdgpu: rework amdgpu open() path to function in
 sleep state
Date: Wed, 7 Oct 2026 18:15:28 -0400
Message-ID: <20261007221530.389925-1-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F0:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffc47de-acfe-4d36-b98f-08df24c087be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: pXb1evL6sFoCc49heMZxv0ls6UAv9+YbKm6LyPU4yPE72H2VEAlY2FRz5eIiCsPIwzJxuOUxxw4wMd5WRFegdMieW0w6kG8uoeROuqjokSnOZzxot7GQaPeyGmWN/E0epMzNRM9BXFw/61QBEjCCLlMuoPGmvSrL0gPaPKgWE1cPr28LUwBZYd0MjuysFPC3dTW50CNEQQDC3ISLw0JnEN6fJ7jRc95PGz1aTHJY4GanrGLJnZzX8VOWSAJX46Fby1r7DOUKCu+vWEtEv9g6akQIIbRynfn/xwIpVYLIolw2kYjH3XEgWzrV+JMxarcl2qsS7CNELVjPa2L1swnpnbFHiRRCEOS4IDfajEoaZisAHV83OE86cB0sGxd4MY4dR9eAX8NcwC5sHk+qefjWJyVIGHNNeELX88jaW8I9WVL2Y06YhCbpIHbjVwGqjkBVDy3ZzzfF2KGmTeqaQo/N+RaMBjNH92jkVkROa7Tm6sSa4p7VRFmOIMv2kuliSumHlOlJG/Dkti8SgYUqDxCSMpsNOSR2D+wYMZawdjyIIsE6chAl1Spn9Xfpu8dDGkVzmre2gbtZg0bPkftyfxteD0Fd4b/YK/PoEderDEhn+NFC6L9p46rDYbjQlRJk3c1MH8Wi/oFBL69TrEWS0DKMT6YTw1GzohU8Ac6VuPO1G1sW+JCsMeAWvZckhxMwPQcrvissEBAZ9mIH4f0r0xo10Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9LsEuNp2WsCE/ztFxqiKLZfukWOOZp9iGzo5xt5Zk82/EnWtzD3baB7pTk/XAz6vtNs/xn/BMKby30p3W6ROoRnoBm5Ze4++rMfpGNqi3lxORW7VQqQrZ5SKZvp98J7FZfYruGuG2gMjCs2grKWX+8WZs8O5e5mkMtX5RhIhchsbmdQ4EAKA2EAAtk5hbSOChk3UkOI6c5iCAeVET7J5XKs7KuU37Ndnm30fvHVkmdGqo1et4QASW65ooNrpTzyaIE6oNOLhia53f+KlDa8wELlqZKGysiE4kXwL051z3kwIgo3N52uExLpUJ1kV+nu1hzjmQ67SzmmHlt2ORkaBxXHHnfY4eLgJ1GwvTUdibCrMOigBLwwxddCxG48pP4OkWy3KZcFt9yPGhtNY9F0O0zCqqj+eMEMQijUIn0Z8Aa/IawShtlVyeIk2SdoqPMPi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 22:15:43.8771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffc47de-acfe-4d36-b98f-08df24c087be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252
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

This patch series reworks the amdgpu Open, VM, CS, and Validation
functionality to allow for access of the GPU's CPU sided bookkeeping
data without waking up the GPU from idle.

The overhaul will allow a few tools such as AMD-SMI to function without
waking up the GPU, which can improve power efficiency within relevant
domains, and can hopefully be expanded on later to adapt for useful
utilities.

Shahyan Soltani (2):
  drm/amdgpu: move amdgpu_vm_bo_update() call into correct location
  drm/amdgpu: defer GPU resume from open/close to first use

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 16 +++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c  |  7 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 19 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  |  7 ++++++-
 7 files changed, 46 insertions(+), 26 deletions(-)

-- 
2.55.0

