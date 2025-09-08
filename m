Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E276CAC582
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 08:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D964710E496;
	Mon,  8 Sep 2025 08:49:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NrPYl9Md";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7172110E495
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 08:49:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUFfXUpF3ToWdMJ6H5jm1vUaNB8lqgIdDbLsBm4hSBI/WURU5Ngiu+N00MZmq1wLYKWn43ZEkuG0vbe1Xif56xoW78KM0Nzf55ROBYsBUPBqLGAuQ9tJEoyz9pCtD10aS1ikanFP+IpiIHOLEvp/KcV6rF5EtTczacan0tM1xfWftwXbfcP48Tlw5pWddT/zt1CYzIuTdhpJFNJi1glNN9tDQ+xR+NsadvyBbXHMFAK0Ge2tLNj/2EF4+u9MQLvYakQQBQbYQfdu6/BfC1yzS3uYk6m2iPQWBixANE9ykhXPib4kAoOk9lkYBiEDM8AFk6VeJg+EBkB+yEMcXPl9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EiQFTg58LD+WrbPLuwrcrB8YWsusa4ibPE1D81Wjnw=;
 b=lVZ1V05x6Qeb2/pBEduCbpkBhC9Mq1oUs5oIzTuepbrSkoxYDtMVmeoP3QJlbil8eZHtiRC07WVaCIYPbNiD1ZOr1G+eRVEKrwSaVu8eFWpQ2V/hr1IKX7H3eePEeCJHv5BCScs0R1fDYM7Vjd1LM+zwhwFXvNMiQPvAjcG49GlcU1jSh12q67arAg8Q8IFhj3xsbOivAb5JnVvH9uSy9rL6OJXthPM+G8ZHpQpxE7KUmlwRT4KIbKp3OvwCrJ4FbWL51dRjukVLyfIq+cmJSFpvOTADWS8SgIMamKSezc79A/rPJNvAVnRoosc2VBmvu2Xg6/C0q+/h+JEnt5dNRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EiQFTg58LD+WrbPLuwrcrB8YWsusa4ibPE1D81Wjnw=;
 b=NrPYl9MdoLhsUje1Sgeh14qgizU136BF1g/d70xT58915SiSHClQocaIYft1QR91XAk14ztACYRayMwGavxWViwBwVYUHrddr4C7n0zuCPWvLyROtg3xIkm0nyeTwAMdEXxARn72m8RUPnJxRPID5bmj+14Zufy6Zw4qTcpnYgU=
Received: from SJ0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:a03:39f::31)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 08:49:25 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::a6) by SJ0PR03CA0236.outlook.office365.com
 (2603:10b6:a03:39f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 08:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 08:49:24 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 01:49:14 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v10 10/14] drm/amdgpu: validate the userq va before destroying
Date: Mon, 8 Sep 2025 16:48:42 +0800
Message-ID: <20250908084846.1873894-10-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908084846.1873894-1-Prike.Liang@amd.com>
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c3788b-7443-4cd3-d767-08ddeeb49c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8KjEHhIKojH0Y4hXNNdQIJDGsn7pifVWGBVqS8xd7dnITuEr9mOQc6nBcWh4?=
 =?us-ascii?Q?0MzvTY1tqi3oo7ji8jj127BlRQHZTvtnYNF+6iQh662slLnICje6XVsZwwCe?=
 =?us-ascii?Q?T+McdUF9GgDD7C6L4mtKia/dwTT+tMMnhn8BsrDtcQo1MbFrkf0gZwcRDPwM?=
 =?us-ascii?Q?r4FrB/utgffZqih3vTz+FF/a/q6+PWI+mzerKH6lZzgl88AwXl/1ZWJYXa9V?=
 =?us-ascii?Q?ELUUZM1wZRsQi8M0NtFOXRg/Vrb5CSIyfDAO+YM3yCAdBF0Lis553l9TRA9K?=
 =?us-ascii?Q?okFi662e/DprFIPCmN4Vrwqf2riteyWuFhJaZAZuAFeqrY9X2+n3EiJdE+CB?=
 =?us-ascii?Q?5aPKmufggwepSMSR9PQnFLb0Ytb3+0nppaT9yUA+rOlygF6zw5zVRZ3J6EAA?=
 =?us-ascii?Q?eMxz/ebCMc7K1w1uERsmgLmHzs6XlwXf9mrZNbnO+3A/m2CUbpHJpdZzXeEU?=
 =?us-ascii?Q?80gkow2yKp556dTIvO6F20Hcxfbhhitzr7t+S/sehBin6FkA/xaJQiAMtLSI?=
 =?us-ascii?Q?235s3cXAzpkxQ7/qbdIb3TG+6/pPiq/qJQtHOeetmCX0oy5h10DYzIYJsA0n?=
 =?us-ascii?Q?tTiL+62lYMP9tYqD2HXEisy/hhF4QvhoHFKWEF2k07C2H3R3i+jzY1FlfHyK?=
 =?us-ascii?Q?I/boeg5TcFnGLiroZYZfyWXCKrywB/W4JLEjRXXLYaqF/9eNkAy4TjZW+TTl?=
 =?us-ascii?Q?FUJCrD77rB5UR/7bcnf50jNKy8PZy5H3n+IZR3zVmUzHLbIoW9WJgWGrdBMT?=
 =?us-ascii?Q?Gid0Sdzkm8CexyP9QPGo4fSFO9EG7HhPxz91vqCcEqQmHsGZx3r2tXLOXw88?=
 =?us-ascii?Q?SsoQnALJhXsl7BwLxv4CQS4F2sEsziDutaMpXiskE9I85VIU17y+VdJS7fU4?=
 =?us-ascii?Q?Yttwlhw1XjJ60+FKPxCUonuY9HpRxsVmMbYHTsGlDIA4IQ5Cr6YEef+DrnHS?=
 =?us-ascii?Q?rtsJtyrWYy9aCyyqXViPtJJ0x0B1MgrMa5axjovRuwQbFRWFlrtfK4ItfVHK?=
 =?us-ascii?Q?0ZC0c3zqzCeowJPImvPyPswZf5oNH2SrdPvAYF3++JZhLKWNkL5g69hY/koF?=
 =?us-ascii?Q?GwqAgAPqHK6JGZhcQwBQeOHjqdXV80ozN4hkuDQMiGF0Ivo6kYrknNLSX9nc?=
 =?us-ascii?Q?zs9MR33gVZ0ZOBupgB9N2NFqw29qNBYARJcdBzaj9YjLvdZlh1Q69zcxt0hU?=
 =?us-ascii?Q?tj1FcWOUFFjPz4i3Vpn+GoNyWfgQ/xN6nnjcSWV8VZWphZGFNT59P+0L56fS?=
 =?us-ascii?Q?6Z2h1zlRE+Hr2rm22qqhnoivqOXuhl/p4gkgVhGFycycjVEA7A/BpYE8mFhO?=
 =?us-ascii?Q?woJOm+AWTqUVjjdTg5KA/GZaBJ7l90eWVKI8HAq5pU4jeLeMdVM5PJ74PjMa?=
 =?us-ascii?Q?L4J0EDq2KEVJAPKomC1pVWBgv+nLazuD/OioScpljD8agJrphK67ehAxh4A+?=
 =?us-ascii?Q?5bcNnScjQhfNTZydLfqjPG7u4MawcmR3U5Z9hG285wOd4qPwfaeGLQOSvd2H?=
 =?us-ascii?Q?qZWzKgrUyY0b8X+rDavaeck/u1XwBGKchN5H?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:49:24.3665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c3788b-7443-4cd3-d767-08ddeeb49c8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073
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

The user queue object destroy requires ensuring its
VA keeps mapping prior to the queue being destroyed.
Otherwise, it seems a bug in the user space or VA
freed wrongly, and the kernel driver should report an
invalidated state to the user IOCTL request.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 85df04e9ec3d..98b6b3761a0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -520,6 +520,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
+	/*
+	 * At this point the userq obj va should be mapped,
+	 * otherwise will return error to user.
+	 */
+	if (!amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue))
+		queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	/*TODO: It requires a reset for userq hw unmap error*/
 	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
-- 
2.34.1

