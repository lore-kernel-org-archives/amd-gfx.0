Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4C1C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 22:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C935010E05B;
	Fri, 21 Jun 2024 22:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OpMITPwN";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4D010E05B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 22:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gib7/lkyRPkW6OwVoNfGTShU+1m1qdefyk/ZsZWst4Sf2XnJYKS9hcLVSRc2I5LGhSJj5SfGXLlDd4we7tiYYg2b89THW71+qVrpXaBqIAu/fezhKAdxJ1PR7T86k0E1uinyhbSx6HQTgLBGbT800xTzntM6KcZzRSfeoaReo1OsKR/epZaEkFXxsE7HYYgl+HUHBIS95SQiZOZybc+Oa6V0yGWvOq81Zm13XU14Q1N7fCVvppwvVl+hzaW8v4BxhPZkb1ZZTUPfcGxzoosvuxvP7A64bN0VPtzbaPBiqwrhQjPRNwbvTWRfeS9Gnu0MGiZVeTZvy4QMo7QOLHiOFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB8hEH+X5pFUPPEZlJqfYL4XgTV1ENE+ufc+TaD6C3M=;
 b=ZQTvjfXmK3m+CB5E8MFCLDjFVOXd4G/zmei91Go5YKPiZL46srWO+Xi14FclhmB/uvgaz2LuRtfZd22m4eJ9U4/mRFGT1zVq3gMJctlXGzLTrpsNdcSDQ1DD9WbjDx4OIUGFhWj3Racdw9S4W1NWLCXObWCXRF2FS8N7xdmiOi8BiiK1TMkrQEMAAXeRO8nrbcxW7bl+JMu8mbf0fvxhNOblu/XdFre8U4SsWJcLRmF6htHe3NcBpSd98usDKM3dt9jZHQzrPllok0WanoaLDZkY24t28aS9MBX/aiIaKCEZlFz98y0AKW2b6+mnf8BuFyFsyGrtPgig4WM7K/Fyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB8hEH+X5pFUPPEZlJqfYL4XgTV1ENE+ufc+TaD6C3M=;
 b=OpMITPwN5J6b6GYVNb/oONPoH+lA1rkyzM5xS8az+fE34aV4gUBrkM+Im/WxrzeSHO2DbagqBIGudStmIy9O9AL0Bz4KxaGWxNwVo3h1CN3Fmh8zFu2bd6l7DgWgqYA5rAtvgu2si6R5OaUCJW8GEYmH24F6PFsQihTIBGcAq4A=
Received: from CH0PR04CA0090.namprd04.prod.outlook.com (2603:10b6:610:74::35)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 22:04:19 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::a0) by CH0PR04CA0090.outlook.office365.com
 (2603:10b6:610:74::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Fri, 21 Jun 2024 22:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 22:04:18 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 17:04:18 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>,
 <lijo.lazar@amd.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Don't warn for compute mode switch under SRIOV
Date: Fri, 21 Jun 2024 18:04:02 -0400
Message-ID: <20240621220402.578671-2-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621220402.578671-1-rajneesh.bhardwaj@amd.com>
References: <20240621220402.578671-1-rajneesh.bhardwaj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b0260b-2bc8-4fed-2439-08dc923e1958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|376011|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CcK5Da2MjT0vqiZ9ae+TLcE5KAzPhnNJawA+h6iLlEA9E4XNxvKFi7lFWca1?=
 =?us-ascii?Q?x7o3uOoo0eIGLiJad0Qm/3zCZeTxMuSPIAUIAqaOnWVh/uliwTwZ4I6Gwg6p?=
 =?us-ascii?Q?3t6CsGp4Qd1E/bB76b+l189++fGrJRyAX2QfnEaXeUhatfGEhguN0k0lXi1f?=
 =?us-ascii?Q?9EM5PSzVxSk8Ig6HEWh1vxqBICiKS8EnFVbmrQoGuQHExzHHcdYlzO/EwR37?=
 =?us-ascii?Q?e6WdM8V6oaSG3My3zAqJPK03DyiMzvIDFT4sP4aFx7D60xmcUR5gS0JAGhjw?=
 =?us-ascii?Q?a0/VqVHGSw5ZO7CKPc3YGHconEMxZMhB0RKL0f1iQYzbF5JT76vp96N+N1Rn?=
 =?us-ascii?Q?emI1u2FkBzxYP4YIS4TdE+e9gIOZ/UIV/mVzdmztEtmL3In9X4e/CPCUX5hW?=
 =?us-ascii?Q?9ANbZTsdAvaujEColIO6IRH0hQhr9tpJ/lFjuagKB+lPLbktNwLO+3dMxB5J?=
 =?us-ascii?Q?uHOWkdnxUuPH5u6dPZcz6dZwu06U831EUkGEE7Q3U39Xgp5yAKQ5Orz/1/cC?=
 =?us-ascii?Q?a8E2GDYW8Q8ZNecZUeEFMQEtlJ7+J7UmgzL4cO45roP8d0yscDXUKoAH5bKM?=
 =?us-ascii?Q?aCviBlp+YCTpv7wDTuwqAcmDHZyuiEU2Q06oBIN86tDMpHd9lFiReV/j/Tza?=
 =?us-ascii?Q?kyvTVjodTP4p/6gDB7o6g2vgXsbvTNfha0ie6q/dNVgTxc4a5WSPd5My7E7z?=
 =?us-ascii?Q?/6MeSc3sBthpXuippcTeIF/pgcI/U0RtTcSB7Geo1StPMiO9fRq5svI47xGO?=
 =?us-ascii?Q?dFjOmfsFSQV/l/kPBEMQN7D3Q2bGeHRfUqmX5K9dYcve4XaVpvBYZxulaSzI?=
 =?us-ascii?Q?oomVyXvs7pZWxDbUBdibczKU8Ip99wkV65vrpGrEQcS/nm4QnnavCnA5+RnP?=
 =?us-ascii?Q?UgdQrhvwRH6XSUsJGf7ewrpqZpMS5f8lTk1UoB0DhhhvJ7DjeMB51t5nJ4Bg?=
 =?us-ascii?Q?gEEr22RFZ2/Qz5dfImdZNmUESsRXquAib4MkaWfHNkCg80hRl63bJ+hTAl1c?=
 =?us-ascii?Q?d5On+7hG8mS8bZei6Y8x0A2+ZwxqfYsLmsOAKHKosdU3Qv4kCFMbobhW9A1w?=
 =?us-ascii?Q?PAIhLZgzAptzXSMSo6hv2VMIS3QAcKs+f/w6ZX7bGp3C/rk2gv0kJ6aRiJ1u?=
 =?us-ascii?Q?LUlzBzxiwnkUwQQU4UnSvcKviEOrqtPTR/ad+7cAGmrE5Dj5gDgmhAecczd7?=
 =?us-ascii?Q?56+ER71oCFGwAEalssBhPT0k5C9JmG9aPw6Ad2NuGDmKZMEAYzVpRxwH71in?=
 =?us-ascii?Q?/+mpQgCmOMNhx6bq5Z0wlTXlqgXPdMF5I5RiomnGB0govCq6y8nEn1IrxZ3Y?=
 =?us-ascii?Q?y5cpVrgT6NoK2K1AUdPV+U+ASqlOro35YuxKfSpdcQlaIdnGNjde4p+vtGcz?=
 =?us-ascii?Q?wgH53GCRoVUKpJmt6UrEN2140frSPSdwd2qyuV48Uo0YcjjpeA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 22:04:18.9508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b0260b-2bc8-4fed-2439-08dc923e1958
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139
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

Under SRIOV environment, the compute partition mode is setup by the
host driver so state machine cached copy might be different when doing
the transition for the first time.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 2b99eed5ba19..c4a9669bceb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -228,7 +228,8 @@ int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
 	if (!(flags & AMDGPU_XCP_FL_LOCKED))
 		mutex_lock(&xcp_mgr->xcp_lock);
 	mode = xcp_mgr->funcs->query_partition_mode(xcp_mgr);
-	if (xcp_mgr->mode != AMDGPU_XCP_MODE_TRANS && mode != xcp_mgr->mode)
+	if (xcp_mgr->mode != AMDGPU_XCP_MODE_TRANS && mode != xcp_mgr->mode
+	    && !amdgpu_sriov_vf(xcp_mgr->adev))
 		dev_WARN(
 			xcp_mgr->adev->dev,
 			"Cached partition mode %d not matching with device mode %d",
-- 
2.34.1

