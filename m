Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C44E94607
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 21:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3101B10E376;
	Mon,  9 Feb 2026 21:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EXkLctlj";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012012.outbound.protection.outlook.com
 [40.93.195.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB6CD10E376
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 21:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCzKbSKMzmzhZu5KZY7MNVFFIkpoA2LhHB3UvZrFz+1qXf+HktPLAMfiKyhnd98mYs6Q19GL2TPftrdG9Gu/QfLbMBxSCZxyWVMNb6KA1XW6miOOSWEMRRWBR+y5gRHZrlOhk3FEIx6ZKDnYB1CFqSQwTGCUnml5qlv/hoOfxGWuF/A64jmKaGn+ZNcWMxwC7Cw8lFkb4G9ZQBX90jU4KbuVZtZMX+pvok+k59CuRHVIV4bFRQhjnQGlVke9FNgppnioElWeKaLsNOmSPri7cr+R5PIF6bjgImakkbXbjFN1Uk/a+4r6t1no7eat5x/liIg5clTZuu9E2KT7hyRTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upbfkJibc1X+UXHk5QqSppLwdMi8z/bLegUr1xOhpME=;
 b=cJYDQmwrZMhlwNsNT6qObIZ8+BstEt0LH+SWbI+l3otCyeXw+U8XWtDAxzX8sUZL60O/eALlJr24ccX03Gq7ObgO2iZPWfNQSw3wAiUAam/UCfnkdx8TmrqyxWmVG0Bg1pDZ/seaYCRyjcwjEVjAozXy+6pysktV+vyMVK/mZXfdE3hGbF+TMX7ckgSr5u/mBQp30RiFTpRgg2hVNptBsqOIjKG0tzC4FO+CfMWdDof9l0V9UnfVjyDhN8LZPS4CxI/DRWnKzWW0FtUc/GXzG63Q54D94bG0NDFaifcoenSUwEh21S/42cSmM23VUqG2Tt6OGIxzXhx+UVrjiXoaDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upbfkJibc1X+UXHk5QqSppLwdMi8z/bLegUr1xOhpME=;
 b=EXkLctlj/N9bCEVzPliRe4CdDGHd2HnAnwizNGeuQoSnCMvK9iBrcrVMfAThgCWeE5SDFDfdLOAmhLz0f5X08IaEMJ6gQpj26lsYmUeUWRHSAZ/bJdpBViJP38XaEKwv0HEHnhzoZo/b61YbhlyqEfTRQsNhFrs2e0jkrTftljQ=
Received: from MN2PR18CA0023.namprd18.prod.outlook.com (2603:10b6:208:23c::28)
 by BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 21:27:36 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::d9) by MN2PR18CA0023.outlook.office365.com
 (2603:10b6:208:23c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 21:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 21:27:35 +0000
Received: from siweihe2-Desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 15:27:32 -0600
From: Siwei He <siwei.he@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <harish.kasiviswanathan@amd.com>, Siwei He
 <siwei.he@amd.com>
Subject: [PATCH] drm/amdkfd: Fix APU to use GTT, not VRAM for MQD
Date: Mon, 9 Feb 2026 16:27:02 -0500
Message-ID: <20260209212702.561630-1-siwei.he@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|BY5PR12MB4034:EE_
X-MS-Office365-Filtering-Correlation-Id: c2724f20-641e-4d06-d541-08de68220ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hieEwMHjllLird9BhaWkIZo2pxgtRFrwHewFimiORvm3gWuU8Dl9PW90FHbJ?=
 =?us-ascii?Q?6MaVW0oECgbNeDnL8RQCtVlUd9h8eemmVKhogV0KQVOQvBP6LxOtg6cZmAi/?=
 =?us-ascii?Q?Mtaaed5UrmgO4FPkmzDNhHx9ZFwlZ8ACitQVS5HbodUfHAYonZdWTS8liMcr?=
 =?us-ascii?Q?EvqGBTxIjQB3/NgkfOkTiUchxCwKOpMmIQtVMrsqZK+UQHRnQ0EpeWWkyfTm?=
 =?us-ascii?Q?oJN/hc+9neoNwnpVFBUbqoLIbtz6qBBlAp+Nkcf2Jb1cUKSyVSG9osWp63HF?=
 =?us-ascii?Q?sQ10Idyu+9AElB3KdMY9JyWwN+Ube1bc2u+R+4oWFOrQeRDdSU7gMcX7qwjr?=
 =?us-ascii?Q?qOnF21J769cmJQqZQoou7HFsMQ6x4qp+cBHO0gP3JKV0V6EHjIk0gYBNMfj3?=
 =?us-ascii?Q?blgFTlBNDpGFi+kexbDAKvCO41cMQiX5xVNSE4G2w4gski6EyMnxqSa9HJdr?=
 =?us-ascii?Q?nfFGBBik4a9IP/mECIUtLl0vOVViTNbXO1Bf0U4lo1vFQMGP03UNpDQz0u1E?=
 =?us-ascii?Q?OvQ6L+iu344L/V6W+sXQS7EhyPJP5d/CBxV6BuMtc5lTyCwEknrdo09lRgBm?=
 =?us-ascii?Q?wp6p/Mgu3zKWklvd/muKapitCxypDOKuJvnMlXcGjaBYmeinWBW+xwVzBSg4?=
 =?us-ascii?Q?sAYXpGWU6Lv2AEUUD1yevM1Mgo06bmGr0rvkInSFzpKXrvtb1jrycYAJkPWO?=
 =?us-ascii?Q?95a9bEvieiz+IinH85U7o4jHZauhr7wfafXlXuAQlRMuUaAYXw4Y/6SZlge1?=
 =?us-ascii?Q?a4F9riuDRi9cNhto5UnhPrvcB9Vi/D2pq30r29/ZtptuQANALBwI/kU3gRk1?=
 =?us-ascii?Q?2qOoXNXggusdNW5pJ0BRKN2KPPQ+hou5/kZ9y1N9EdvMhYwKnFcYyTsPp9uf?=
 =?us-ascii?Q?ZxfkLQVtILqeV94UefvNcmbCSWqnensaw4OWDD+cGBMR15eYTStV6Y33MXwm?=
 =?us-ascii?Q?bik6qpYtJ9sjxr6KDEpyo8CesfucMD3jKjdMcqi+8/yoZn1de3c4K6cBPrO+?=
 =?us-ascii?Q?qUMTovzJHgdrACsrVgoatB4lpN2DipcxFsipzp26dSYs80weC7v7jW6f6t3J?=
 =?us-ascii?Q?Y8Txn+Q7Vzj1p7jyHrrfVkg6UJqnud3r2Ml0/ZWu9IWikj1TlLoOF+TVNZzI?=
 =?us-ascii?Q?1YZ8h2diUrH5zOKUX9AoqR9EUEKgRb/WRPVf7kHmggQE5AYAFpctyvHSD8wI?=
 =?us-ascii?Q?XLhlnB/rUZZW+lPBCRqtjwXP0X8e0OsrBUVb/2FUEkfli73iiHK83n/rMr+P?=
 =?us-ascii?Q?YNy3oMdVCBmyF/ldn6g8VexAOOH2wVYvE650rZ0K4MXWVjRTv9LmLN6uKbIc?=
 =?us-ascii?Q?KtOhfFB+gjyPeE2K5lrPRe1qkoIEEZnuKRvFMzBa3a2gkpAgIqMAuycTp0Ai?=
 =?us-ascii?Q?SOjFO6DM344aRT3Anj32u7HHpYRHds8EKMgVKntuXNweEKyQCjZNJVuuiM+C?=
 =?us-ascii?Q?sER9isNjbO6p2ne9mcG4s0vmYv+RGHU0GimwBL1kbWkIxSsulMitjYOcYPje?=
 =?us-ascii?Q?p8rq4XVePSlrtzq0uMxskfpDuFx6jrRbZ6m1ql3KNi5WM+QbtxYpQsiYHBSQ?=
 =?us-ascii?Q?7i+ubCA/TtUmiZQ+tFdtVfVzz2UwTmmo2d9yARS40ENnWvKNAPJmFcRCWoJd?=
 =?us-ascii?Q?K0+/pExi4H8L8wNJj/nJfz1Gm+/+KtG/NmYO8dLAVCvJJ6bwyniHoESQCIFH?=
 =?us-ascii?Q?OB001g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +d+YvPQoE13g0foFemjr6EhZYVXvHxbpR9x+n0KZZLvVbs7ID0MCibinVRWQst347b/ejgVfrf00DLodvwzDcU3UZ/n0p+GeuJRf7NqFJUtdahIf+mog25jhWMVMuO7PxgDAVlS4sVMDqNd1cATsYfV9C8Ty8w4XxKBxTFosqA7NvrdYqtDsqbMsaMyfw91ronnQaAanpQzuWrBTgVOOF3UgZbUlt3OB7Nc1xicfZAFSD4yJyP8cc+NYu6G6++MZVMI8oJPygEn2ili5YD4+dF+mg4cRRJXIKPsPPe5ePAnwUdQXSJWbcEz4T3heMy74gJa2lw03BRWWLnok5N4hTMerJS3yUtmBZSroo+sVnUq7UzhvtvzmeK4+RuTITPTWZLcCv/2aEZATjTt3vAf5SRYHVqabCnndT/tpPYi7GMyNwcd+UmabA7TZ4TwKcq2b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 21:27:35.2358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2724f20-641e-4d06-d541-08de68220ad0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4034
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

Add a check in mqd_on_vram. If the device prefers GTT, it returns false

Signed-off-by: Siwei He <siwei.he@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index d4659a438be5..80e428f70725 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -111,6 +111,9 @@ static void set_priority(struct v9_mqd *m, struct queue_properties *q)
 
 static bool mqd_on_vram(struct amdgpu_device *adev)
 {
+	if (adev->gmc.apu_prefer_gtt)
+		return false;
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 5, 0):
-- 
2.43.0

