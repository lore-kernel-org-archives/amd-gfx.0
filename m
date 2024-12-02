Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DC4D10DA3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 06:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1897010E1B8;
	Mon,  2 Dec 2024 06:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YUDJfqcD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D6D310E1B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 06:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0ioZ/Du2lanS6ASDL/NiPYaTXGI5OR76CBsFkTBXerY/X4fNV+LsOFIlWeNEmMhKX//J3KnnAq2Aygvg2Qvxdwq/a6eB8CTZrCuo0aHFJ5/Lkzmh1R0IfE2mbmKH61Kjz7wxv5MqZjww5ENXvN8/IEtubOFQD4vhiaPQ61Bi2fRCp5hHiBd0oMnlfm0GjEMUrsyauCq4rF2Yb+HtTJxLJ9dUhA342X18ND89Cgt8d3y0iYOvBK/OGarcb0fV+6m9toYGNRtf2f9tUpSBzPNOSwkUvsmvYNXgY01VqJF8vrT+klv7fZAjUUP7yW5VUlPVY9lrI7Rzn5MUnxx7UQg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nTrNvvfsO1KY4KZsh+wrZ/36cUY6ZEdpZ1aMBaoFVY=;
 b=d736WVvGJvmYtWK7ARcTPlFUu6X6WNUjduSq/dz5LUZFCw9KZrSvPryNpZyhyEeya3vWCKbWSvjFEiBeeDFFxe4mMuXPrA5jAd5BMJaO6IyOGZAxkz9MaJwvAutn8MFuuHonRgHC3XpuB+9USbnB/vnTyIvf45p4eU2NVenjmG/5aq7l/PcVgHJUoWF5ujLJi3LodUKvGh0E+L54u6Ja0mrJhJx/u9FfkyFNf4a0ZwFspL4cqRyRxO1MLlQ8v2lmaDmuDi93EwngKOJ17qAVrn66oT87pvyBUDndQ6mt+gO7E2y/ui+J3h03nnTIm3GaVcBeH65L5/KZ7uTObaOIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nTrNvvfsO1KY4KZsh+wrZ/36cUY6ZEdpZ1aMBaoFVY=;
 b=YUDJfqcDWcMXt1Y1q3PL9ck3gQj2zMIZJFSyxweBBeKgAiWWjVhNES+MUjikqCPesu8Fj3Hb/q+McFCgv1aQh0Sewb3SkpfTWKx+y+hyHFFaaDw8X+p7xEABkqq+Ni3AuMeAdIi3AUsBTVepPUxx9Prkv+vfm79zIeIV+0lz1Zs=
Received: from CH0PR03CA0042.namprd03.prod.outlook.com (2603:10b6:610:b3::17)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Mon, 2 Dec
 2024 06:46:28 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::f8) by CH0PR03CA0042.outlook.office365.com
 (2603:10b6:610:b3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend Transport; Mon,
 2 Dec 2024 06:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 06:46:27 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 00:46:24 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: Avoid to release the FW twice in the validated
 error
Date: Mon, 2 Dec 2024 14:46:15 +0800
Message-ID: <20241202064615.516559-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: f1811c7d-54a3-42cd-5b9a-08dd129d0bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cnmSZniH8Cow0OeKA9g1l9cHPjJwpB4mqAocc3EAUJcj0hqv9m7KuO3ouTnp?=
 =?us-ascii?Q?S/8uES+CHXFI8YmMEeA5bWN/ldFKHIXE5uSLD1ehYE3CP+Lz1aJZ+745X8Rv?=
 =?us-ascii?Q?TbFSr4WRPp2zTNR1gDdYYsezUPU9DVn3gXV7p10q5EaYmib21RmjQYEp6cBT?=
 =?us-ascii?Q?Cb2AkCUWGjvnEKzyPuRI5YSzFfem+vF8nqtXQbxya8TgmiY3YTKS/vBANeBT?=
 =?us-ascii?Q?m023oNT8ZJrK7FjzmoKD4wpS8tCu0bAEZZiUtzPc6wGEmgra10NWMnNxtoim?=
 =?us-ascii?Q?9tDGy86HaV+LC3OMbX3aD6trMAV/tfL+x+J5+BSyeCo2KqG0T6gP68qOHW6x?=
 =?us-ascii?Q?R5d/D00PckDZkgshke6VRHjKm87YzR6epMnvAW//KWR0WkOXPLUg3Ks8Bvdl?=
 =?us-ascii?Q?DDgWfKSnp55WcbGkDVE7ZAxPU2HoJXNHcHsQJbZFOpnsnfssgzjHig54PvTH?=
 =?us-ascii?Q?ax3LE3ai5GU5D7TLqUXdyAQCX8s5IJTBnXJZvvfiw1GKYrn7TbdYLT4bPt5u?=
 =?us-ascii?Q?8ydK7mbJ99f3qg1FnV3pzZIBM0ZoEVeXuetqp0gAPWHVktHzSXEUKtcLLk81?=
 =?us-ascii?Q?Z5/BbD07ln/YuauZ4Yh6oc8P/L0teKnHJdDM/jQvIkbNKudieBNc1Ftz6RXP?=
 =?us-ascii?Q?jWoscclkSUMC1M4nl4YGkO+s6f6D2d4w6WXx8P+luGhJwggX6W0Li8748oIO?=
 =?us-ascii?Q?UrzbskJjeFu8Lw+0k9xditJXkRyEaGvjHRzEyWUl5yP8MsPTulzykCKAFiZt?=
 =?us-ascii?Q?b5QGRchbgIdZ18SVAimSkQQkZsDw0hzJyp9zkaZlcoDOqmGOn5CdMyWsBNZw?=
 =?us-ascii?Q?VgLCJNxW/8CKcC2wcqNCnIIr9fE3OyumHaUWpL6bomAIhCT9QRuhHx0CKbLE?=
 =?us-ascii?Q?KMippXoBJQ7pRD9Mb12jwun/4w4FZw4DEPfvPAAVgtrhReieEtPtMJ66dRtZ?=
 =?us-ascii?Q?KDncFme3y68VpkeCMuq89n9q0+dUC9JKZh1a+xtnNn+QaFIA201UmPkimFkT?=
 =?us-ascii?Q?vUVVdPk3aFtptQZamaH06BQYwnsHiv2RZ0UVHrpKBLplWxIsuTAMJVah//p3?=
 =?us-ascii?Q?9A2no67yuW2+ExHSY4Emzvk76Fy9rlfsd2T3jweVLODv5XjxPLXocfeu2Bn8?=
 =?us-ascii?Q?gPVoTVTwEUhbVuodck/61vqCn9DAHsBu/qtOtEjSLqZ8u6Ib0+FQUmOxY6X0?=
 =?us-ascii?Q?x/M7mAvrCfqntJ9iRMBzGLAt2z4NkfPND/bOTgTkHg55ceLmjyCTRc83XmIx?=
 =?us-ascii?Q?y9eBf9GSV1f65RHWo3xOE18xzVT+jDegUg9qJQGVfJ3RML4NZKgtuynb+iow?=
 =?us-ascii?Q?uoad+Ngs0nU3CyiESlD8rbRlElkKd5pjLYdBtyqMd3V5f511R+WiyJmWLFbB?=
 =?us-ascii?Q?i1dNWswwnlHaj1Sd/40VHE33PhTwjQBJB/U/PWB/qQ925I/donDmqQ2tGon4?=
 =?us-ascii?Q?8FiGgfVQkHs/lHOCNefMM+EKsHMz38Mn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 06:46:27.3525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1811c7d-54a3-42cd-5b9a-08dd129d0bd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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

There will to release the FW twice when the FW validated error.
Even if the release_firmware() will further validate the FW whether
is empty, but that will be redundant and inefficient.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 4c7b53648a50..e7f50415926c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1461,11 +1461,8 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
 		return -ENODEV;
 
 	r = amdgpu_ucode_validate(*fw);
-	if (r) {
+	if (r)
 		dev_dbg(adev->dev, "\"%s\" failed to validate\n", fname);
-		release_firmware(*fw);
-		*fw = NULL;
-	}
 
 	return r;
 }
-- 
2.34.1

