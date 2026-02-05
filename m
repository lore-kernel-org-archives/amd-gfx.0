Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1706E9126D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CBEA10E260;
	Thu,  5 Feb 2026 06:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oCaX/Z0N";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C7D10E260
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8WH9aDi2zHKVwDR07euYuixpeW76WaGX/DvA/vS3QYx8c1h+4R5PNPRlyNFzE0ZQHMZ+DtqJw7V4eCTa1TZidNUGldTnVdr5JnlCYLQaIGr0TsPR9L0Gq8hbSDjCkLOHBGxggaQudGjnZQN72nJiQE/2cePwvpZtLYo8iK09wA6qHEV8pRZIimgPVZvRHhHR3CT9iEwEQI39Qfs5K8mebW06eWmZG4vAF3e5+tqcNj6RjpYzCscJ3keJJgFh6ICNscWPTw2H6QVZfqIUeeWHBmKOfnG1e5/RyfyA1n7nURk+d+ZjX3Mh8dgwbn7aRiJilVlJYmVOA7umhdsqmd3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLn2VuoEoAUK9NZBryKxRls4g0rucqxgeNbwzxpqDbg=;
 b=poaL2knhpIDdT0v+wi52uGSAMZKTXg6boGmQ+UCSQSqjaQ37h9CXqC2C/sDBgokMO0bDbwB+ZE8BilslLLI+JmytfrAHk0X4y9id+enZXlI3TfMuj/Z9jW1x2vAxQ0jyFHfmLOU7hajluhuqj8rBJnTN4pOiOUQ+Ir8K3Q01TgVo4xioOO5Xlyk7KMVFRNgh7v+8NxL4PInc9ZvOvXFwr8MsZPVlY+OCLyqbwM1wKp4lHjwhLwVcEdC4ohIQRozHHMGbFkWxj4E85INxQc2PfAHkR+I44CPLKIODIt+bg1GJa8DR2QRBOR0XN/n2ZXacwtpTnDmCOCHv1OI2xPfhlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLn2VuoEoAUK9NZBryKxRls4g0rucqxgeNbwzxpqDbg=;
 b=oCaX/Z0NKucw1AvO0wcvufvmasfp5iCez+BP+EW4MT/BDsZ9u5vfRn6Dgedh6KmeeA+8CPgVDOkL9wg9ytm1lET3AW3Mo7MCtK/RWuxdEwswlD/Ga0y/wdM+97U8oNy9Dmc4/pFYLOWo6OdqeMia44qLRLLnU5SQMTUs/7zL0ug=
Received: from PH7P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::31)
 by DS0PR12MB8020.namprd12.prod.outlook.com (2603:10b6:8:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 06:51:57 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::3a) by PH7P221CA0043.outlook.office365.com
 (2603:10b6:510:33c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Thu,
 5 Feb 2026 06:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:51:56 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:51:54 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 12/22] drm/amdkfd: suspend scheduler during PTL re-enabling
Date: Thu, 5 Feb 2026 14:51:20 +0800
Message-ID: <20260205065130.654921-12-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DS0PR12MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: b54cf6c0-b21e-498c-4940-08de64830db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CekvcJ8cQWT5LVgRuxlpRey05VgQ3QRPT5TkgVFlA0bn38FFwbYuwWzN8A+r?=
 =?us-ascii?Q?WWPqqqs1tOwMiipNG9VBUAzXwOyodtsiRMS/CsgZQAGmDjGMhxWKj1W+9PHU?=
 =?us-ascii?Q?S9yzsOFgmwSjJmGrSm5XVDHlDIju8fOYyDa32hz61SIhukNC6D47k/6Fxui7?=
 =?us-ascii?Q?x/Wix1QSUnJEuhTVenUOvrHrdCs/+83NFrZwaQq//mtWtWDTW1ZscZ+YC8yQ?=
 =?us-ascii?Q?Zj3+KSch83PQc/LcZ97K1xKf0eKTVa/63cvh9LBpsAqhW2j6wQXN3p2vJCI/?=
 =?us-ascii?Q?X96pCEN7/CC8T90HtcNqA5pr/6tZL5br+pbD3KT/fZpYK3IHZH3IbJsFsbLq?=
 =?us-ascii?Q?CLG/LGcQ1Dh4du+dRO0K1FJpFwuz/ugvDTBGmIgHjzmpXffbvFweF5WVgS4J?=
 =?us-ascii?Q?SyCX45mfNofH4i8cAXA8glCoVyhOaj3NQ0PR2fj8FQWiGdvz1ric1Ngm6C/V?=
 =?us-ascii?Q?nbMPJfn/DiNF3xDvPTe0NE8BeXbbPzQRyZdZ/rw2tIHRQCWJZuAPRvp6X5ZL?=
 =?us-ascii?Q?eS1I9ojxXSe7gRpqJjHKrTU/wt6VvhN9UzsiMyVAfs3UweEcE8Tlb0T/zgmy?=
 =?us-ascii?Q?Hu9N961WnuUhGKmhw3AJi40/4pwZt3IUGR9gEZwrHp/sek+vBU2xP1ZgqvK0?=
 =?us-ascii?Q?LNPLtkiGjqvZ01c2xO/GEILqsTM7m8J/sel6cK3DIbIAqlBbJNDUO9qWtGPg?=
 =?us-ascii?Q?fgEe9UXuyLmsW1/iRkBU89gdHlGbKfN0alJKfbwPe/V2CB+pEv6Njk/8oyXt?=
 =?us-ascii?Q?v7PS/aF767j6jW/YZB7+Z/LDjfZhWRsHR2UYK+Jtk14tmrwQhclsnD2fY0jn?=
 =?us-ascii?Q?f+U7IXMxT+7xmpmEgmA4AMzaGBqZSPms5eGsV0FR+waTieiQLQwwLV9LZPkv?=
 =?us-ascii?Q?P3s2Aqw6rDU02E+Nf6pDp83YzYOIUJwYleeqoXz7KnQj7zWogSw/rRVT1esh?=
 =?us-ascii?Q?M5lfpnQWOmpJlsxxuZj1e454QZvSz3LU2/a5Qnk6pW6lCGq3R5KCwSASAK8e?=
 =?us-ascii?Q?Dirzu5IYEiyzJ2wlJKZf5aOH8ELSo7WrMf3mkX4v15WBLkMpjsZB7yi/msdb?=
 =?us-ascii?Q?vSbUq8+tkIhNKsv5yRzLTbY28FexDYMOpWdfxH32M1dxLwKHEIQWdjcjA07a?=
 =?us-ascii?Q?YwuFJgarYc8Kn2VK3BkVYTWS7F4JVTVObn+5s2/3S5PLW6NNcxcswJnUI0wG?=
 =?us-ascii?Q?+VDxjx7kRv7PXVfV2ng/2rsk6ySLLnW29zZVAq5yN2L0Z/rbJH9at6Tt3nTI?=
 =?us-ascii?Q?4Sl2Ej2b6KL4lsuhpMOjHiZEfTXOjlxHni8h5HEqDORrWN7Rrt7XavDh5Wo/?=
 =?us-ascii?Q?/Oow0MAxxM3ZuOt8KNq7hMMLqXNJqe3CsQeNrsj4bZNShjTh1rNM06zJYBhG?=
 =?us-ascii?Q?OO/4GfAGPTOSX0ERtWZFo4QGoXjGGcYBJfJnFzxPA8N6egG7mgXKp01/KWy7?=
 =?us-ascii?Q?gScLm1e7zAixpSGPIYkqc1zOSujAX31+QZA+bUM5iLljJIfGL+S+64/gQGTF?=
 =?us-ascii?Q?WLFOnotlXBTQfbgEzFiarc66qd4X17UKr+c3jkJtqzNrGs3fY5VjKkAfuw/M?=
 =?us-ascii?Q?z3/mTubZZ9m1gYs2WY67UwtnAG0riN/a4Hk+lAf+MhHgHH1KVRvSL5HhJCZj?=
 =?us-ascii?Q?iHzF4rjdjLpgdu+9DQ0lhfczjBamrseedScecbryyjoL4KbA+mV4rcOivRc3?=
 =?us-ascii?Q?MOH2Ig=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FvlyJkSXWHccxuMxrQWfjft+3xiOJ95iItM0qXDdYORFgNeNAUdWwS3POtq7lK8vUK2i8vVSoU2KeHGU+S6EptSdR2CZlZTpeZJBiQmTCJ2wJxxWbXzcxa4ZiZOiiaRHLRy44x0Pw9Rd9o0sds5FyWXvTAc7dVVS2LdTsWJntP9st0D/blf6EUWABDIx0kKdx6owVAN3WMCg9lyO1orXCoNMeCoc/ZBUzH+zpl5DVzk9dhprtKfI/3EUcjcOd53y142Txum9kcOwbljDkOSx9qsQe43LasFzPszbe+s6y63n9A/9F5ZrdfMSp591RTAiQCKMWK7cUgiCiF0UO/9V0+4sJjzqzB5fBDSdGbyooz0yuCmplKujutl1syqKaHCMMmHNTj81XA9Ru+Ohwi/gPuu2wGbb+ir/BWUfgGPc5yy8tPXRWPdFwovlHN+1MxjH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:51:56.5992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b54cf6c0-b21e-498c-4940-08de64830db8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8020
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

Stop the scheduler before releasing the PTL disable request to ensure
the GPU is quiescent during the PTL state transition. This prevents
potential queue preemption failures and GPU resets caused by modifying
PTL state while waves are executing

v1->v2:
only stop/start the scheduler when the PTL state actually needs to transition(Yifan)

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 6457c5703f99..6fa8cff55a32 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1831,7 +1831,11 @@ int kfd_ptl_disable_release(struct kfd_process_device *pdd,
 		goto out;
 
 	if (atomic_dec_return(&adev->psp.ptl_disable_ref) == 0) {
+		if (adev->kfd.init_complete)
+			amdgpu_amdkfd_stop_sched(adev, pdd->dev->node_id);
 		ret = kfd_ptl_control(pdd, true);
+		if (adev->kfd.init_complete)
+			amdgpu_amdkfd_start_sched(adev, pdd->dev->node_id);
 		if (ret) {
 			atomic_inc(&adev->psp.ptl_disable_ref);
 			dev_warn(pdd->dev->adev->dev,
@@ -1839,6 +1843,7 @@ int kfd_ptl_disable_release(struct kfd_process_device *pdd,
 			goto out;
 		}
 	}
+
 	pdd->ptl_disable_req = false;
 
 out:
-- 
2.34.1

