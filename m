Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D3DCCD185
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Oct 2025 17:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49BB110E82E;
	Thu,  2 Oct 2025 17:44:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bz3oGDIk";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06FC310E82B
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Oct 2025 17:44:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzjFkdxBtEEoIudQhl30wue9LQH73bFJNQ/DTpjJmKOz2seu3EVRAmpQfHz4sRTfDQ98ag3i9AN8ENeyqgFyGxS3SpcKi+Sc8m0ncWvMUWsSF7AfXFIniu1KXwr61Z7aC4IaJI0JiARun2pcK03LVNMZL1lspKHRX273ZUkqx1UlHsp1rt0S1rNo1FOF5g5A40Qh3jjtcawcmKSjEU6vbqGsdLc0qo1QFH0Ar206Gnuj/xAlzsaEfhVx5z1zHE5x1X0IMG6aPvF/AFOBAHTzOpYAgPzrpZe/34x8gfUAYNzwnwTNpvslowXPk/4sO582scq4r+5w+klcvUDO/bk+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnAyb6wmyjnGX5JLI3IPzoHTUkSk+FAzKm8/d8RjdkM=;
 b=e3pS+c2CgIWvD5RAQYGb4m8tUIDaKB7LhnSfmZ9YedGkz6XOYF50HMzI2Uo3dZoMvWKd1QClDApKQlciT0XgYRc84W+PNPzk+PTkXWjYGV02VIyQ4YfHL9PZ1gSjrgPXWL1C40Kb/bVIjYziemBLUCobe+LCJPBcCbXtapKJoq88sJ3m/zCw9JRxCziXj1k5UYc6GbHYZggGWCjDN2qT8tfSNnYabMamq0YKR3bzO437Ys5Y+udZdyWLRaJVMS1JQdTXgwQw7EH9k2cDI+yT4c4hbcaoW1dsQsLEd6yi+HZqha1DskYyulnkGlXr1e0nkHhUX5QZ7hrkTwuBU58Paw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnAyb6wmyjnGX5JLI3IPzoHTUkSk+FAzKm8/d8RjdkM=;
 b=bz3oGDIklU20ohdLRt6wMdEyo7thlMvgmFLyu3yhHitJV+kW7fAYOoncQb5niS1TZpzkdAfxO5gwXC1SW8s5Tn2joc5qDDwyduEEMfppbnIVB2rwWXFvKE91QBGZIvLKV0UDOIrA/UGR4iV08eoSEyGvlQ+MFkGzuVBbo1LWILo=
Received: from SJ0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:a03:39f::31)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Thu, 2 Oct
 2025 17:43:57 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::66) by SJ0PR03CA0236.outlook.office365.com
 (2603:10b6:a03:39f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Thu,
 2 Oct 2025 17:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:43:57 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Oct 2025 10:43:50 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amd: Pass userq suspend failures up to caller
Date: Thu, 2 Oct 2025 12:42:45 -0500
Message-ID: <20251002174245.1691343-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002174245.1691343-1-mario.limonciello@amd.com>
References: <20251002174245.1691343-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CH2PR12MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d4808b-ce54-4b41-0d7d-08de01db435f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EftJM3EkNhTfvvxl6DyUH/qZnBGvsgehf0kUBZfyF7lB5JqzgfctemObVkSH?=
 =?us-ascii?Q?lpopWm5v5E5GlgIODIum+NsZPVnw+krUq4d9BNuhEsX/gdEMdeGJJbXmff5y?=
 =?us-ascii?Q?Q3ezawzkojMIo0W34Aeyu9NsS4DT9vdsutcWjASG1BDpbBnMgBhQPqUipfRi?=
 =?us-ascii?Q?VfIxPAKXD/r0eCr13issXcx4DWfW7/tOzLfAOJhzjHL75mJu7BLkHnwqVv/c?=
 =?us-ascii?Q?OMGj00n1UItNaf2M5qd9AoSo1VGMYWT4Ae/AgChv12TqDiG4+FyJ/NOFz+Ru?=
 =?us-ascii?Q?kU3SM22TtknFpRSKP9ujBFKRbllrbouT2seF4mjvn24yh4CUJlQDtpLPn1jk?=
 =?us-ascii?Q?9hqT1D0KnOZmkyekkv0xumYs/tQyjveRrEUPlv9allpeisXs/lwGDYCMfRAA?=
 =?us-ascii?Q?FgPzoUVnh3igGM6r0MtzmfhAdZqdAl2er/m4AMJIuXbeld99mQl3Ub3ewSu6?=
 =?us-ascii?Q?KiewHpzEQ75tpfYC+1nwuKM2XjtKYtFmJZ9sFCBMiQyDiNALNVJMg2u4KvEb?=
 =?us-ascii?Q?UTI0QNZzq3RK9GgzeXauPZZOtw01A+p0Ev7JuHuRVpACeB+8xkwI14Aco+o4?=
 =?us-ascii?Q?j4Q3MDzt/brPqgpiQ66T5pLd5te2kD79jH6LbyT3nWuKX+fA2MKQQ9/kJ5zA?=
 =?us-ascii?Q?dRkM+JOLEUy4KX+d25SqjI081Y4J+9bVnU/mUYNU65DvdDDDpQ5OlSxLKYv1?=
 =?us-ascii?Q?tvaq4+7+kZ17rsR4w8UZ1kU8pjffF/dwcuews064v2eNMq9SZEO0OAYTEnL3?=
 =?us-ascii?Q?UrStX/DPs3kLmONEBCjUa/ABP/eTcFjlJbyW9H1AR+vO/0RxWoTjD+GDT8qa?=
 =?us-ascii?Q?tju/sFRnhQpo3gJsabHquTNyVSYBHua0YHTJHyAra9AKFbvqSiLtxiVia/0H?=
 =?us-ascii?Q?/sW13rdGXYdXtP37SKFZvduVifFcqQ9dNuwHJ65hU9+LGlh/M+W02DA49RSo?=
 =?us-ascii?Q?l2Vwbfqr4A0sZLzA8gr4/ubAs0K8Fvi/elTV9roGnT/d3Qv9OlIc9IbTYuWm?=
 =?us-ascii?Q?TBj/CZe3Cys/HjHumL6iORJa3YFtzKo2B8ttQT9wmYRKCKCLuqLbGkihkOhp?=
 =?us-ascii?Q?bPVZG+VDZJ7jVOrHVv496dwa2pPMtvWoVlQ3L428lqP53BYRkRpVD7t+iaDg?=
 =?us-ascii?Q?ycOKWv+DZeEPnyQ7iJXGYZ3MxDkZ2rjo7zHcx5MdNPSz2tJuuRBa2E8aOSWF?=
 =?us-ascii?Q?6ezk0VRwDL9CQGxxnluEenR8mYMG1NYYoMSyuxZ16pIESBESIzv0TlXuISlm?=
 =?us-ascii?Q?VwidS35a4RVThX5PzkEpHk7qeUst7ataE6WXlp0uc1g8CAPzL/vtOxm/tNtq?=
 =?us-ascii?Q?Fld9ClgzEX6vTeAcaQpMHolRkzbftZiolzF8DkYjvW201sp6FbfQZfIKt0BE?=
 =?us-ascii?Q?K5p5vUJ1VwUlFXg6olTVXDjsc+SQTKbijLIFq+1Igxk4WsPRVfc4x6mKLtam?=
 =?us-ascii?Q?XD683+qXsqPRjxbfDjqlbe+JMulrCvnA6+3QEvDKWCU0AabG6dBJ50ZEKt11?=
 =?us-ascii?Q?cixqFCNlMEPSJ5w7DXWvH99bLlBbsvm+zgXAuZtV/4u4aYM2Yaskd1CQCwh2?=
 =?us-ascii?Q?tgAsjX7VthwqWhTqTUM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:43:57.1597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d4808b-ce54-4b41-0d7d-08de01db435f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150
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

If a userq failed to suspend the rest of the suspend sequence may
have problems.  Pass the error code up to the caller for a decision
on what to do.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e16cf64dddba..4ae12ebc0d7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5222,7 +5222,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 		return r;
 
 	amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
-	amdgpu_userq_suspend(adev);
+	r = amdgpu_userq_suspend(adev);
+	if (r)
+		return r;
 
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
-- 
2.51.0

