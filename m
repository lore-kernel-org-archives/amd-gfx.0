Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F63CCD1BB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 12:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D0C610E76F;
	Wed, 22 Oct 2025 12:47:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XI3eaKH1";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C818A10E76F
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 12:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpSFK9kTzl5QY6APKADi9nhTgS3ZDrpxsdYQ88Ib1as+/Mlfp3ywQAs0z3URPkhsnBUnIhkTUxa4EpchNZBLdhauSxtXtZI64IgVIRs/ZeDwAmS2FK5vJdzX8v+I48M+bV5OJaJTnldos1RfEv1j7cqhl4AzILGiAAKnAgooTYTM/+p+qvPdh8CMTTXSGUMyH6StNQJTIAs5jt28RQdr/QyCr66XgRhY4byhDdNyif3fIm2gZ8SBqPr5q8pPHelEB51aRh638WUehG8G93ihYYO6whS9FfVUFGujbLID0cpCIDeYcEcrYwDtU3N4ksdRsAcrHGkRpcRoseXq/VvPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXQ078H8IvWx5pF2VBRrY6B/mX+RMyHjJGglgn/vbbA=;
 b=fQ6VIhGfiAOJeyi5MLqL43Y8DfFMmOn3cM1ofxZsGnUpp1epfTuwjJsnt4LGyhYQS83BaG+iIDCHtTjuGQqWKOM1zW7mCfGJynG8yXFOx3obt7kdRJya0WG6sKENo1kZCu2gyLOkhWFI823nSrR1cslkKuVSjyy9zxK6tzDmyORhIEz8PrOIUcFzU+eFCwr+WZr87lNdCNDTa0wd7gcw/RmvzL3sm9KETIIukPmS9TAH0R1jiMCdec0kv+vbbNXhQLGXi5fgGKsFbBgSXa2T6wHhFlico4J6Dau4rWQ8e599ml0yTi0fPGw4CE2GEKk/NxWSjAByqKbf05w1DZweqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXQ078H8IvWx5pF2VBRrY6B/mX+RMyHjJGglgn/vbbA=;
 b=XI3eaKH102xDEqc1UFO/tJm9tynNc3VZ+hxH7lWAqSZH/4U6DdO2h845WV3q/bHMtg85QzK1E/Om3AxwlzUBqGgU7Snwlcs4BjN1XiJrCNnuMRSMg1MhSDEdhoZZh4qBWaxCxq0/dydKawFKaJh5oNw6XUhcTvfFi9fApdLT0Ww=
Received: from SJ0PR03CA0371.namprd03.prod.outlook.com (2603:10b6:a03:3a1::16)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 12:47:51 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::b1) by SJ0PR03CA0371.outlook.office365.com
 (2603:10b6:a03:3a1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.18 via Frontend Transport; Wed,
 22 Oct 2025 12:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 12:47:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 22 Oct 2025 05:47:47 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/ras: Fix NULL deref in
 ras_core_ras_interrupt_detected()
Date: Wed, 22 Oct 2025 18:16:51 +0530
Message-ID: <20251022124651.237996-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d68e79-c39a-4ab4-3243-08de116935e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTBDaWJUTnlGdVFVR2hDNXNxSjNtcC83clB0eVB4U0ZMVU5BOXNGeE1XQU5E?=
 =?utf-8?B?V1UrWFJhTXh4RW5Dd0Z6bUtrdlNyYVpOTW1wSVFBMTd4Sy9LdHc4SUFnWG5r?=
 =?utf-8?B?aEIzN1kya0UwaTNNU1RMVWFyQStubUpuV0NWWkJmcXhuSUREejB4L0RMS0Fp?=
 =?utf-8?B?WHZ2eGY2eGFyd0NqZXhvbklYb0dJU3lhbHM4REZJZy9NeUNzZGpwNnZlT3Vv?=
 =?utf-8?B?WEgxck9GS0J4dDNrTnNBcDdNVWZPSkRCbDNrT1ZJVUNseHlmZ005cXUvMkla?=
 =?utf-8?B?UU5SVUdXU203Q1lUSStLQ1ZGalExRzZuWEs3cDkwNW5aMDF6QWs3VklpTDls?=
 =?utf-8?B?aHpSclhOUWQ2cGFMMnJOMHYzU09HWElLLzI3UXJlSjFKZ2d0Wmw3VnMrYmNO?=
 =?utf-8?B?UnZLbWxsRE5JWElHK3JWYUJSNmxPc1YwNXJuZGhIbGRYRWNQWERScjZjbDNT?=
 =?utf-8?B?M1RJVHo3TmN6TEdCTkpFYVczUW9OcTI5QjEyTGJVbGlZb3p2c2NENVF3d0xZ?=
 =?utf-8?B?bjV3NWMyQTczMzhaeEVLZ0pxRE9zdGJ0Vnh2RDVaRFlpMzdDSGtDNFdTZStZ?=
 =?utf-8?B?S1ZzMERBLzYyZjQzRUZyRU92NWlYdVBtOE5JU29TeXJ1eFZaT2p2dWV1cTlX?=
 =?utf-8?B?SDYxRXZMTHBONnpGNy9XVnR3dytUMmNvTlEwS2JBMTlNNEl2SU1CaDA5SzV5?=
 =?utf-8?B?bWNEalEyWmxzalM1OWVZUERsVEwwekZJMzdnUzh4dU1mbnc3OVkrZ3Z5V2Fi?=
 =?utf-8?B?VnYzem5lZGgzbXJjdWN1cjBpNGd2c3NhN0NYQytBZG9DZy9BWk5QUE03Y2ls?=
 =?utf-8?B?MWxFM1hYY1p2U1BBVWxZYTcwTHlUdVltaHJnUG9xSE82ZVgrU21CeWw2SkJm?=
 =?utf-8?B?bjNyTEZoN2Jud2Iwd0U1QkMzdW80ZEh6eXpuMjlUSW1IK1ZGcGN5OVRrelBF?=
 =?utf-8?B?M2hoSnZHZDloVDJmUHVLb3dxLy9wNUNTVU5NTWtWWU1uM1lpajRDa3lYRGlV?=
 =?utf-8?B?eTFtaUVUOWs0OGx1M0htSnhsbS9YMXlWM05SR0NiYmd4bDBic0dpKytYVWV5?=
 =?utf-8?B?Ukw4S25NT2ZqaG96VTVSOG9EVTBxVkMrUXJQL2NKRXh1YVZxNlVLVEpzc1pa?=
 =?utf-8?B?UlZzMTUybzEyVC9nQ2daakNNVWd4c25ESzFFSCtkcGYybzEwVk9mNUtGS2ZH?=
 =?utf-8?B?a3hWODNIY0dJMVdzM2p1djBobnkwbThmZG1aRWxhdm1PY3l2S3hXRkp4bWRx?=
 =?utf-8?B?YytTUE1aRjFiSlhGb3IwcEN0NDg3WGNmbVZJMEMwTGFwZnZsU3RBWWkvNVhm?=
 =?utf-8?B?ZFNxVE9QVHhyZ2wxeHFYN0dpQnhmcU5obTY4R0JHeU85RHVhQ2NvS09OVEVL?=
 =?utf-8?B?dDBneTNkbWpweVRJNmw5aDF4SUdFWmV3SEVNSy95NnRVRXJSeFlXNGxiZXlU?=
 =?utf-8?B?elhnZ2RrVXc5Y3phVWpFOVd4T2o2ZXlPSzFVWk5JdHNWN3FCanlPTnB0Wm9E?=
 =?utf-8?B?N3NXREU5cGJHcTIwZ1dKd3lqYUFqL0tYR1QxbkI3alEvdjM2a2hGYTlNNm05?=
 =?utf-8?B?VFFxS25YMGRIUjNYYkQ3NTJLRmZRQy9FSmRJazgxZkQ5YUY3YXlsdnFSZ0Qw?=
 =?utf-8?B?MHg0dHp6YWF0a1czSjlCSDNXRFNmQ2hZcU95WDdBUG5hZ2R3M3BlanhtMlFS?=
 =?utf-8?B?blB1UHNYeFpKUUkvWWNhTXhhZHRUSWVic0IycTQvTDBEeGN5RDQwU2ZtaXp3?=
 =?utf-8?B?cjAxQWxiYzNvS0hGUUlka2pyNVh0by9lcUJTK09YTkVRVW9jZmphZFEvRFpT?=
 =?utf-8?B?OWU4cUhHaEk4bWh0akJoeFlVeGxqelN0SXZESFlqTkdFNURPTE5lbzAvMFF0?=
 =?utf-8?B?SWI4TlhPeGwwdTNLbUVzd0NqZmJXZWFBTHZycUpyU3VuY1ZQVlFCVmtGMnRM?=
 =?utf-8?B?aWRmeFYyUkd1UVB5OC9nMDRsWWUxdk9GNE5rckx2U1NvUU5WakNwMDdFTGhh?=
 =?utf-8?B?aS80dGVxL3RlOXgvc2xsRHVzU1h0TmhScUZsUWZkZzFjZTAwMlVsRERGSE9z?=
 =?utf-8?B?RDVrUFdURW1NSUE0ZnNXUHQ0ME5haVcxRmttdW1GQmlUVHhNbVYrdytUUjVw?=
 =?utf-8?Q?v1OQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 12:47:50.5037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d68e79-c39a-4ab4-3243-08de116935e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357
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

Fixes a NULL pointer dereference when ras_core is NULL and ras_core->dev
is accessed in the error path.

Fixes: 2ebcf78447ca ("drm/amd/ras: Add rascore unified interface function")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 01122b55c98a..5da355e9a3b2 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -528,7 +528,9 @@ bool ras_core_ras_interrupt_detected(struct ras_core_context *ras_core)
 		ras_core->sys_fn->detect_ras_interrupt)
 		return ras_core->sys_fn->detect_ras_interrupt(ras_core);
 
-	RAS_DEV_ERR(ras_core->dev, "Failed to detect ras interrupt!\n");
+	if (ras_core && ras_core->dev)
+		RAS_DEV_ERR(ras_core->dev, "Failed to detect ras interrupt!\n");
+
 	return false;
 }
 
-- 
2.34.1

