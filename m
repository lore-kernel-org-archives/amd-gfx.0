Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7934DCCD195
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 14:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C02FF10EC3B;
	Fri, 17 Oct 2025 14:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pk90GAM7";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 573BD10EC20
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 14:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cl3DyKQQcnQDuElRO+068L8HxJTQH8vDXU2F7Ty3R1jFXaikfBVy7r63qODXktWkkdl2cmrhapjlVw34iPJGHlzd0TRJwz8hbTpaycH7/XxBRm2tFuw/kAJuAs+2aig2xIg6VVxuB2QiJ3El7MswBg/SQsE0bB+AJm6kuzd9ROWAJI1RJT9/8zrklT9xOsIZ4XPAjcKTsJhAgIrlLpA4RKCHqiFMNaV0Hnu0FQDOwzqFUp+ttTa95TxP9Hy16w0zGkiJA01yneyZ5pgic9cVhSowL/DQgmtNFsHFXXhwyljRDu+WLLruajs4/ylzca7x2ssoh8k5dnEPq6fSeaXxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IR6rOgZ0Mwb3ALVJgFi8n+/UrYSX0Ycaaj/eCCO76Us=;
 b=r/3UeeVdqILY0Jt7hQ37TTbUzgnxY1nIu1sdua8qr9vMEo9+lWywxE9oaW+j9ag/e8D06bIFIpTQygogqiOvfHXogVyMXdTNZdgLdPeRvquoOHC08igkdk9SA8BAtErb/6keQP/FQrGdNX4tGaoZT8B5WkOvK9PJW1CFr1OEaNW4rbfZtZ9sC/vC411xip2jdN7YRhqKOvNH1J/reNKmWrsX+da0/XXuEdbtx7oiK0Vwx2fXoQmf+ChJXGXa+nAMVAQhmd3Z/+TZuouFepuFIwSlXC/LMK9302Wemi6ymwGabSRldZFAVwYTzEUKK+pjY0R5MhzsI24kGy+fVL32zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IR6rOgZ0Mwb3ALVJgFi8n+/UrYSX0Ycaaj/eCCO76Us=;
 b=Pk90GAM7H3FdtBgRgnDCMdd9pX2AdAFLr3hGD3vYW++clAX/Ee8MjwpS9S/D7nSGUhDqkJaovGKgVwv9s9qzaidw+S1HSyjMZQBwQGaa5IsYB6ePVVzAM3EJGfcbVblZ6NfY3Emsk/S1Mv1riFJC+qnGBwCtpwMr87yh4G2YbVc=
Received: from PH7P220CA0178.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::17)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 14:04:26 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::65) by PH7P220CA0178.outlook.office365.com
 (2603:10b6:510:33b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 14:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 14:04:26 +0000
Received: from Devmachine.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 07:04:24 -0700
From: Gang Ba <Gang.Ba@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix VM entities killed before KFD process wq
 release.
Date: Fri, 17 Oct 2025 10:04:11 -0400
Message-ID: <20251017140412.2173002-1-Gang.Ba@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ffdd18-000c-400e-efd1-08de0d8614ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/nbbAJAmGJXx0rkC2xAaN6tGBz6VV+pKBq/XaOyDgd61juQpvK6Ut0MTAmqX?=
 =?us-ascii?Q?aLR5LfwFg7pIW32u+ZErVnS9kfSXkKvR6oJayRMUbpjZ2asQezFFXZtTWsJs?=
 =?us-ascii?Q?+5Qbz3MUH81awGrtpJfrOlSNyv8C1fjyGK7fwzVJZrwSc4oFQcRoNLaIdWGD?=
 =?us-ascii?Q?R8wA2jsOOxrJYO8mco/pU+ynKcUfar5ih/ZKYU6EY8Xzbzi5Bgb1fAlCdz/m?=
 =?us-ascii?Q?CJGF2ajXQ7NQvhM7wPnDgxMywIiNLHa34xQi8qh+49MXEU3Ucb7EK3BNhFAf?=
 =?us-ascii?Q?zm8kVn0Xkjq+cJqo7B/TGnpyYz2GaZ9NbrRZCkALHgvDMnE1ph/ygXN/MOSQ?=
 =?us-ascii?Q?5MnQyoaPge3RHokBkBZCDJabbgvltd4u1IGvTbHRYU3WeoIKaT/i/ikSEbkd?=
 =?us-ascii?Q?Pm2S06wscx/t/PV0+KcMNaCYhy32lXoIyFzH9OTiJUbZ9cNIYFIuOaW7ywD6?=
 =?us-ascii?Q?voRCui4VvhpOIuGSp3g7sb3WTVh3tXJSLc12+pcZY02Dp5H9dLyu7Q29C/x+?=
 =?us-ascii?Q?vt68IcvqLs92tgmgNFiCYLjZmIObv6WEPa/MrcTc+WhMwfIbTZ16sGd5IFLm?=
 =?us-ascii?Q?DQl+kdoWSH3C8sEcshOQO02NTiwAmagalHWoc4JDHDXFaAnM/OMciZ5t5Mmb?=
 =?us-ascii?Q?qaswNwewgGxNpImf1F1XIpmiKXM4GXiX2PrdEyDGDdbmcrdKcfObUrrA+Sar?=
 =?us-ascii?Q?fVcRBeOCD9G40SLnrIzCqXUpJ1jZca/7mL372boutL95F5td0CfZuHofnGYf?=
 =?us-ascii?Q?HIAtI4JyAj0lpHbg91F9ngWSaL+qekK/HwAXzJ8CFSA/wKmjZkZWBrG4D2UE?=
 =?us-ascii?Q?jcFUuhoJs81SdN4J0aG7K0K2eCS+zromRd3whz/eToZjs5aAgtKx/bY2yRh4?=
 =?us-ascii?Q?8Kt4BytagY5f/nRVXcr124mRz/OA4UFYc2QF9gyiBh1Se/lRzFoaC1i9MRvu?=
 =?us-ascii?Q?dQQGTCdYHQuIJ7C88GRi19addx2dYdID23H7Lk/B5Wea2maEPEWOzV2UAYBs?=
 =?us-ascii?Q?aMNHdPV6cht+uoiaiHo9ks1OTHuCLHSg2o7kNUZwNCOEAiHDc+WuW38m9qvI?=
 =?us-ascii?Q?r98N7vZwMOGXR+HpRuyN6nPYFIisc1VfK1PZkeOwqj2KFcUwoXWeTambfDMm?=
 =?us-ascii?Q?HQKaEaUTreMAy6ltYTiZSh4Xa15GrbiYf1lDDtXlUs0/x5F4+TAU60ztSkft?=
 =?us-ascii?Q?7cna5D/bL54ji/HODDewTHJmPcdljb7yEKm7A+tE3miVXKfGhtm55Mw0EWIf?=
 =?us-ascii?Q?Kd960yi2HX/Uh5ayHqqkTBykhtDfR3ctRgw8xR+BDH4Tbt2qsCOTfdBcUcMM?=
 =?us-ascii?Q?UaSV/6tmTkaGjwqxrALt0cz3QRlXIfpMNIcyEw8TZy1/5BE6HUPka2RDuQdd?=
 =?us-ascii?Q?lcFNt2kF8O/o1vQgUI21mv/qE6JvTj7GUedqYs8ZP+rMbifMnUw3hlA7Bogo?=
 =?us-ascii?Q?nlxmvo2YV4oWtJ2X5uZOvVhp6QBVoYdLXmjMu/YAC05LSmsu0oxkg6SDHc/e?=
 =?us-ascii?Q?qrr9Qa6jp/ODk9GM22o/ritvh5GQGIbrL9bkPmfgPT/yL7afsOwwYGT8vess?=
 =?us-ascii?Q?5WymX6q0mrbBp6saD90=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:04:26.0036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ffdd18-000c-400e-efd1-08de0d8614ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221
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

drm_sched_entity_flush() may kill the VM entities under certain condition.
then KFD need to issue kfd_process_wq_release to release associated
resources, it cam cause following job submissions of process failed.

[ 3976.788183] [drm:amddrm_sched_entity_push_job [amd_sched]] *ERROR* Trying to push to a killed entity
Or
[  129.600916] [drm:amdgpu_job_submit [amdgpu]] *ERROR* Trying to push to a killed entity

Signed-off-by: Gang Ba <Gang.Ba@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index bebf2ebc4f34..2361c09ddc77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2997,6 +2997,9 @@ static int amdgpu_flush(struct file *f, fl_owner_t id)
 	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
 	long timeout = MAX_WAIT_SCHED_ENTITY_Q_EMPTY;
 
+	if (fpriv->vm.is_compute_context)
+		return 0;
+
 	timeout = amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr, timeout);
 	timeout = amdgpu_vm_wait_idle(&fpriv->vm, timeout);
 
-- 
2.34.1

