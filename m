Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A55CC369D9
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 10:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F156710E1F6;
	Mon, 28 Apr 2025 10:50:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l7TjGLds";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7911410E3F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 10:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+fwz2gs+I7vsN+IQ5V5Fn2eZg4NobwE2y0kmZxOvicNX5Jx4ss5mAK4SaEaNiuhf0zQ5C4jnbcUdgmhYFT90MAAsCgupfVi15IMksI6n2xKzC25zBZ+4KLYB+jat6C2gxWSBlsOg3YT3ApJDVXiAzauy43n2owY/gOWkj3hlxRe9BKuuAzoqukXj5mVjxWpaJNeosRxsqu3DeKVxMDaMaFOTzqP4wJl3RVbrTb0svv+D33CeQIKFOhAa6KzO8i6yojRs5TENzzgctKzbJ/HZQr95H+IwA1tc+etNuEgfdXNxp9yLhIv/0tcItcp1CDjI13JGTqV7ADy4R2FAYxlcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjPVVojlx2CHRbt7RiRZwEOHMWawG/aznctgUyTNy+k=;
 b=lsdqdHICPt21pZUZYhkYb7gh9iXtfRllyhL5WtMY7EKr/VKNwGfKzLkm+BdhZKd6TPeViClul0+A1q+1wWRtTs3IFiaG9R2hIaMX2OxTdgwgJdf9/yC2FtEoe5qznVCIKIsPKVEA06gFITvK0fSqZ9+q0x5l2O6ycBoWywcPuH1sHX1AcJ6FB7PsDfMGi+0pMuXRadTGI7v0pFfQBa3E0NY0bK9gpH7abVkcj7MKlm0dlQySCZhQb9Dp4+3tDvQC/lUnDcu3pZOrUS9vqdkWYgU5LpaUIXKaGIhOnw0gjQBhumNqOg5vWSZdV1dq5YnZYTarapXMRTU7kncphMWPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjPVVojlx2CHRbt7RiRZwEOHMWawG/aznctgUyTNy+k=;
 b=l7TjGLdshHoopYtSmMAmaZKyGkmMMi5Tj+YiT4swl1AXHoT3YW8+4PHO0k+v5O4pmqUKlGJyc5yfJX/41Tp+RVo0XJ9xMqqubS5xycj+6LRHm+SbZceMF17npk1eYGUi4ezwEd+kk7Pu6phti6iMYa9hiu1BrzegbuYTTCco9gA=
Received: from CH0PR03CA0359.namprd03.prod.outlook.com (2603:10b6:610:11a::19)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 10:50:47 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::12) by CH0PR03CA0359.outlook.office365.com
 (2603:10b6:610:11a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Mon,
 28 Apr 2025 10:50:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 10:50:46 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Apr 2025 05:50:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Add Support for enforcing isolation without
 Cleaner Shader
Date: Mon, 28 Apr 2025 16:20:31 +0530
Message-ID: <20250428105031.1147636-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: fcaeb5fb-3611-492d-2faf-08dd8642883d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3BjOU5qbVpyRmx6bHg3eWlhY0Iwby81aEE1ZlRxR0hUbVNQcjEzbkVZeVRt?=
 =?utf-8?B?WldZSzZMSjNTalFtWmRYTi8wZ2hXZ2RkbG1JNzMyN0JuenlsdGYzR0NJOVlM?=
 =?utf-8?B?eHhYNFA2ZnpSZVdRQUpiaDhlVjdtdWVYWTA3cmdLcTFWZXlCQ2xLWm9HYUlJ?=
 =?utf-8?B?YmxkZ3A0cnhtYmlZTDhNd3M2UXJRalZGWUhOS3NrRFUrUnZhcU4xdjV1YUVj?=
 =?utf-8?B?U1lQMVEvOUg4WDE0RjdQSEZxTVpZaktYK1RwUUVsL3FFRjJndERacDI2eGVw?=
 =?utf-8?B?c09pR0dCS20vOSt4bnZyUFdkZkF3WVJWM0dKUE96bEpOV0w0dElhb2sya3k4?=
 =?utf-8?B?WFc2U0hrUlRHc2RQSmxqOG1KV0xLelJ0VDlRelVrM0wvZG9sb1c4UFp3YXBC?=
 =?utf-8?B?djRyektENlNGVW4yWkFIdk56KzJENHM4aENnOU1rZCtHRzYxN0pXVm1DclV2?=
 =?utf-8?B?TXYzRVc0d1l1Q3I5NGFUdldOSUM4MkZTUTlXWGdOKzhlVGltVElpaWZ0b1F6?=
 =?utf-8?B?OHcrOXhZS1ZjWWlTdngrWk16WUtwWXJNc3psNmt4Y0tkYXNGRHRYSnhuNTF2?=
 =?utf-8?B?emFPRjFoZ28yV0JSMms0eDJnc0VNSUxJV0FCVzJUVGxPOGpGZEFhcXA4emdl?=
 =?utf-8?B?b3RFK09kdFZLNHpLbjloa2FPdm1vczQ3TVZtSFFkdjY2QWJERVl3aHRIc0I5?=
 =?utf-8?B?NjJEK3VDWGVZREptYk5reTAyMUhOcWNDZkZ6UFd4WjgwWDNmRWpqdTRNcGwy?=
 =?utf-8?B?NTBQVWJtUDkyUmV0QXd2QkdNbWVQRitmN3hYWjFlRGR4NDJ0VFo2d25CejVW?=
 =?utf-8?B?OXhGN2tQNmhTb2N5OGVER1MreUFsY2phRkUxb2Y0UmcwdnJYNEgwZVI5MHI2?=
 =?utf-8?B?Wjh5bGVIdzB6MSs0N3VKMWE4TmI2K29SeGVscjZUQnlPUk1Db1BISXZWcGEw?=
 =?utf-8?B?UjVyUmo5bXFZWno1ZUlhY25OZlU4MittcmR4a1Y4bGRGbWhMY1JSL01CZ1A0?=
 =?utf-8?B?bTJMQXhyS2JJNVR0VThYai9nMVFwYWRxVEhzazFUb1ByeXUxWmN3NU1vYytL?=
 =?utf-8?B?MmRKZzIzaWtIZFN0ejFwNFdBSDJaZ3lST2w1WHcweW5ZZTR2MEZFVXV1UVhT?=
 =?utf-8?B?TlFTOU5KQnRzV1ovdW9zZ3dkRDlCTTRvZFhFNGV1M3lCSHdYSmFNQkRYd3kw?=
 =?utf-8?B?UVIwb2FvYmhmWFk5TC9XUHFSZE9GN2NSOW5ZZjNud2lCd1Y4UXlkN0c1N0ps?=
 =?utf-8?B?L2I5TGQ3MjFwSzIzVCs3cnZDUVBKTVFLa2FRNW4wRDJmYk9iREE2SnMrTWky?=
 =?utf-8?B?aWJvZUI1M2NLMjc2TndkMkNBRlFZd0p0Qm1lUFlaTVA3aDllVGF6bVZpRnN6?=
 =?utf-8?B?Um93dm9nYTNmaUpKSGtGYjdYMHBOdTB0YlVZN3NBN2gwd3liSHdmSy9YS2kx?=
 =?utf-8?B?WG9QQ2RkcWQwdWxPRHhBTWJvM1JaRzRzemtxS1VTMkJvcU9wNnh4NnRWZ2Vx?=
 =?utf-8?B?NWordjkzWHRZSHpiY2g4SS9meHFRdy9Remc5bkFSaG1PUG9oeDhwVy9IeVdp?=
 =?utf-8?B?ai9jNTlvcmNWQmx2akxTV0hJM1BUZ3czWjA5alEvRURKaERGcVNEbVo2Sk0r?=
 =?utf-8?B?STZzT0RUWTZzTmNkSG5IcTVUL3N6TndwUVpwaDhlYi94UVZMcmxJcXRuRVkx?=
 =?utf-8?B?QU0xcVlER2V6bTZ1WHZxU3dpNjVsK0U4cGE3bXMvUG1MS2xXeGdwbVdITXMz?=
 =?utf-8?B?ekcxYkZBK0tmUXY2WEJVQ0RMYVh4WFlOSnJFdi94bjB0NDNmME5qTWVnRG9Q?=
 =?utf-8?B?ZzM3Y3JCRHBDNFY1bXdRZVZTOEZsaU9kNjBERk9JeVhEU3FTRS9aQU9tVGQr?=
 =?utf-8?B?S3lkTG1IeE5xN3lFcGlZemFLa0RqTlAybUt3ZUFCQmtlZ0dXUEdMVUtXTmZC?=
 =?utf-8?B?bUJKUHZoT2ZRK2hwb0JCK292Q0cyWkV6TS9HN2lSVFhwN3htYVNaUGl3WG5E?=
 =?utf-8?B?M0NManVJN2hvYlNMNTkyanZSQis4YnpZazhnRGFyN3RFWE5SeHprTjVyMnZl?=
 =?utf-8?Q?Id3okc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:50:46.7490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaeb5fb-3611-492d-2faf-08dd8642883d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441
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

Adjusted the enforce isolation setting handling to include the ability
to disable the cleaner shader without affecting isolation between tasks.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 7 ++++++-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cc26cf1bd843..7e5ae8f1f0a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -878,6 +878,7 @@ enum amdgpu_enforce_isolation_mode {
 	AMDGPU_ENFORCE_ISOLATION_DISABLE = 0,
 	AMDGPU_ENFORCE_ISOLATION_ENABLE = 1,
 	AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY = 2,
+	AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
 };
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 0941b3495b2c..9ea0d9b71f48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -310,6 +310,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 			p->jobs[i]->enforce_isolation = true;
 			p->jobs[i]->run_cleaner_shader = false;
 			break;
+		case AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER:
+			p->jobs[i]->enforce_isolation = true;
+			p->jobs[i]->run_cleaner_shader = false;
+			break;
 		}
 	}
 	p->gang_leader = p->jobs[p->gang_leader_idx];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fe68ba9997ae..8330e30f0caf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2163,6 +2163,11 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 			adev->enforce_isolation[i] =
 				AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
 			break;
+		case 3:
+			/* enable only process isolation without submitting cleaner shader */
+			adev->enforce_isolation[i] =
+				AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER;
+			break;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 8f1a2f7b03c1..9d4396ca52ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1689,7 +1689,8 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 	for (i = 0; i < num_partitions; i++) {
 		if (partition_values[i] != 0 &&
 		    partition_values[i] != 1 &&
-		    partition_values[i] != 2)
+		    partition_values[i] != 2 &&
+		    partition_values[i] != 3)
 			return -EINVAL;
 	}
 
@@ -1708,6 +1709,10 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 			adev->enforce_isolation[i] =
 				AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
 			break;
+		case 3:
+			adev->enforce_isolation[i] =
+				AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER;
+			break;
 		}
 	}
 	mutex_unlock(&adev->enforce_isolation_mutex);
-- 
2.34.1

