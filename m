Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC7EC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 03:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36AAD11A9D6;
	Fri, 26 Apr 2024 03:59:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IKddBzET";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9442411A9D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 03:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn7k5BQAAS+wAXpGE6P0DmwbthV/+d8427/4E4rENSm2OVxF8kLemAMtUiRvoWzFlbwWCtUTVQ81XyXYPw5E3CFb89mPH5XsHoKeiD+CXyb2UWu/ca2AGaGoQHqw2qfYx6MW2cdryZhOKO5CAIQcIweMEHKR24ueW5Y3j9uPjmKJtD1bAGN+en5HQbxCid5unNasuaXS8qZqxsDXP82YPSwdLUzIbBetYjYOSpq3fV6uApeyJ9QLFCKq8iMnGeb7mFPWIS6L2TT83SISZQtFPKt4/eGg2CZowCDnAfrLptDjyYg7QKVvWIuI5ZNE5aSDC8iEB3blj5L+IPwMXwcWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz8ZdjFICKoqPTGg5ARkY3UJvJMjvHMKjq4f3f1ecWk=;
 b=I2Xnc4JdTJmcrX2Zk5/2/S4xUNxlDQ/6X6V276Odt37OLFfGT4aoyZkmbnx2gqWDJ62A5c9L/T4SoCTbRbZIIQaNBZxbLTKN0J+MG65cvMAdhi121FNj/6XubPIeESiyihX8nVzWhCvallca3ZXQ1D4Cvz8x5e+LWb+jwmAL+fk/x7RKn2+4a7QioNccljwqlPzmnytvkpPvTQsTr0EpClqgzqyDNaoNFkFpufFOVAQecc5p3WtMDGUp0mTAnwbh2gx+lLk5XNycXBh3/Hi4DbdzbWyed0UIQmiO1ic3+k/dtZIUlkGZuKq3LwzdYdQxfJCSWlISnYpyPaaIOZix6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vz8ZdjFICKoqPTGg5ARkY3UJvJMjvHMKjq4f3f1ecWk=;
 b=IKddBzETbvc5WUNjDiEi+EfFyqzNkCZY6KYifOtzbJml3/WwULlnEUgTuITDGO9EPa7MPXdpBNvdmGKiNj9gyE9B1dmD3aOdvwzncpOkeB12fQd5uosbBxh0Arb19HHPy0z7fq49FHqBkduP7xkBGis62GApv0TQd1m3HgCL+6s=
Received: from BN1PR12CA0014.namprd12.prod.outlook.com (2603:10b6:408:e1::19)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 03:59:08 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:e1:cafe::9e) by BN1PR12CA0014.outlook.office365.com
 (2603:10b6:408:e1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.31 via Frontend
 Transport; Fri, 26 Apr 2024 03:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Fri, 26 Apr 2024 03:59:07 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 22:59:07 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, <felix.kuehling@amd.com>, <emily.deng@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Move ras resume into SRIOV function
Date: Thu, 25 Apr 2024 23:57:42 -0400
Message-ID: <20240426035742.90560-4-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426035742.90560-1-Yunxiang.Li@amd.com>
References: <20240426035742.90560-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 8522ef2a-dd26-451c-8d9e-08dc65a53902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hSiaIIROIlhahNprmsk0xu+4jaEqo7PTbAyAJN54I7a3TdbeIiCYWTZ3f/29?=
 =?us-ascii?Q?YIMmU0FCQAgSq3rHfiUEfZ5F7dgnDg0GOpVbhNOENJBNKSeoPz4SXCicG6g0?=
 =?us-ascii?Q?GSplZU0ncYI83P34j11BSHl7DgHijiw9p0xmOnapveNWpSq3cN9DR5ql/h2l?=
 =?us-ascii?Q?2Kkmy24rcUKQIQ8bqV9tMvxejM3olXvjlZNloNT+LmXwAGoRbD+QZTivSaWc?=
 =?us-ascii?Q?Tk38+G9oC4kpAqNvSeG+QzUAKocfQnLUJngbRNBM5tpq4Xq2Ga4xViC6VUV3?=
 =?us-ascii?Q?cMKxsqTEoehXU07sMzrnGQPC5+WzY+prySdC2DPgBjFVhImoEJKcdQshwsk9?=
 =?us-ascii?Q?8uFCm1vSydhGYapfL9YzwE1xCneqBdBDChQHsww06LLawuHs/JrijqlvyYIS?=
 =?us-ascii?Q?BZ2KvfKarQ5X5Uay7F92FutAMcdmd2eIQV5CZzchFa9pOZZ4R+0GxiEgclms?=
 =?us-ascii?Q?QxcU1cOQEF4mAZtTUrUYY3nPvVbKW1wy5ltVB0njtEzU39KZ+dMt1pxkgJrE?=
 =?us-ascii?Q?hyYwuvvqS668FKOpTyNZ8ASSHRIXNDRbL16Yc/JoH+rjnGrSkwUSlGPj7wh0?=
 =?us-ascii?Q?qT8YCA4GCoPsAqoQbj0bdm8073lb0LjHCpr0kflnPfce2NXaNmFsdYMMZBLr?=
 =?us-ascii?Q?ZvyXT0wCPusUqfftyl7PdykNnUN2Wesiv2CBNQ0sDHGpoTOME0LhrrMg0Bfo?=
 =?us-ascii?Q?7dX3jzPdl6Ne2B8NBlE8J9sF1AWi+BxfB2jn9XbzIZF6x4fp/VOZcqm5C9ZH?=
 =?us-ascii?Q?cFC7MNq9qf+fXFSCMax8VkeD4OW7GrbB5M8dc+7B6UtC1KIuII4y9wwg7yr5?=
 =?us-ascii?Q?k/Aip9v5vfVu6eGuBCBqXrwJ+UeLrJNz1nMbb5/QlE+NiOkdh7TntL8QkIWb?=
 =?us-ascii?Q?q1vKrF8luysjbMtBs+09s27/BvKa1aDM9uN4B7y2SJK9ixuDoFOZPzyRD4JJ?=
 =?us-ascii?Q?+zNfR2fVdFcC+u2zfitfl5RB5sHEvbyicuB4CUp8KvJxaGkCJmVShBRE/8xz?=
 =?us-ascii?Q?E2Clgumw+sCJYPuvyMwU+/Wxb0e4Vme3icNXIkH3ziWWUbLAEGnWDNBcLPX+?=
 =?us-ascii?Q?jN1xXpgEP1ttor/NKUrkMzJFscJtp1zp/BVd9rG7ve7/n2F/zacpljT4GI5s?=
 =?us-ascii?Q?yNP5ekKg+/tTd8BfpXq7DwFTu7JVrV18wNh+ItFb6luOg7bcwAX2jcwK1wNC?=
 =?us-ascii?Q?u67ozsGOE9Vg+S4bbZEZ/U9blrsneX1TC9ckXdRLQZAmYKvsxBWNrvuo5N73?=
 =?us-ascii?Q?vaUSlEPXw7/WrmZZ3emoOATCGXHcNlOiC/FPlfyXd1LXXD6edaAHLNTQuz9p?=
 =?us-ascii?Q?WUVNaxPrJXdIBa9WIu9A4tXluZxjSFcgcCjb7j6UKQvQsHFwztcjl5Gr1TDp?=
 =?us-ascii?Q?3jc85zf28a93s2Qf1zV4m04z6KDE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 03:59:07.9776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8522ef2a-dd26-451c-8d9e-08dc65a53902
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287
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

This is part of the reset, move it into the reset function.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3c4755f3c116..8f2c1f71ed9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5119,6 +5119,11 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	amdgpu_amdkfd_post_reset(adev);
 	amdgpu_virt_release_full_gpu(adev, true);
 
+	/* Aldebaran and gfx_11_0_3 support ras in SRIOV, so need resume ras during reset */
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 3))
+		amdgpu_ras_resume(adev);
 	return 0;
 }
 
@@ -5823,13 +5828,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			goto retry;
 		if (r)
 			adev->asic_reset_res = r;
-
-		/* Aldebaran and gfx_11_0_3 support ras in SRIOV, so need resume ras during reset */
-		if (amdgpu_ip_version(adev, GC_HWIP, 0) ==
-			    IP_VERSION(9, 4, 2) ||
-		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 3))
-			amdgpu_ras_resume(adev);
 	} else {
 		r = amdgpu_do_asic_reset(device_list_handle, reset_context);
 		if (r && r == -EAGAIN)
-- 
2.34.1

