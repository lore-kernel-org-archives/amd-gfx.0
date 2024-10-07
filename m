Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F1ACFB440
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 09:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E5610E331;
	Mon,  7 Oct 2024 09:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NJcUko3w";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1624010E331
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Oct 2024 09:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWqQJzDFAoWYxzKlCQpD0HzjHwug0ht45qK1938SdEppwt33ozcEEj6ygCmsOpQ2dcim2k/ghQkNxADMwqVZP1J7aExJ0izxocyP9axlc5vmd2kppE0vSNU2UwRHFMJh6bmy+2Sb64gmRfsZpmnnpyggXuaMUisFBBWRSK6qc89x7bkHV2xZ5HNnrulDy6G6TMR0bsNM4V8PzNnavs8AFNkgMskLNAuHoT+NQ8Bl+y7BBFdy5R/+kBdaNX9ywqdojDHyQPZ7W6fuqC5EFoZ2Zl2g1dpv/BXPHZXCLlRm3dfuquD4+Jv3y3P/E5RiOtLoMiJiAZU2g/MDHJKgfxPb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApTHcpIFCsPneQO8lxNFPmP2gMc2QhBPufEBGuQ3T5U=;
 b=GBy03W4zH8+yzizv6SIQJSMTfzifXlVDnjNqEf5r9Lp+Wi3UMTQXEGj9AhmD/nvkEixlHb5p4LWZ84Aabw1cEkV3hVnPLtLUQCtYcUSookSNrUALyuZJOM1F3uU+pQ/aZU7tRdMJ1tu+xv35dN1BdXG6hbL+dWbGYulK11aFK3mNaviG0fdxxrV5E8m8ofJbV4n17OMAsgn+a2VnI9Uutic0k0hlqes858p66g7iNgIJX2ebvtqAE2m9LFk4faQM2Y7z5aO+8mDyrxbq6iVvDXNixL3rhdr2QOmuYYko3sy859jeRSb0TayYId2vwxay4/aXUeGajbGoMr+xp5e67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApTHcpIFCsPneQO8lxNFPmP2gMc2QhBPufEBGuQ3T5U=;
 b=NJcUko3wlWj2fBe3jMlayrz0U1Nt8sn/OQQs0rJyurmT8GAKajDm5nkUeP22zQNsD+a/fD7uZMdPx0jv+7thdp0X4JDjcsjOr/EsJPgSIyEv/A15nayAMSMrx/d0rnPm6MgUc4LUo38i0+epaPZR4VHywFLSaLlx4iqFXfMHtX8=
Received: from BYAPR07CA0062.namprd07.prod.outlook.com (2603:10b6:a03:60::39)
 by DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 09:33:22 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::14) by BYAPR07CA0062.outlook.office365.com
 (2603:10b6:a03:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Mon, 7 Oct 2024 09:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 09:33:22 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 04:33:19 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <rajneesh.bhardwaj@amd.com>, <Ramesh.Errabolu@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: Wait for reset on init completion
Date: Mon, 7 Oct 2024 15:03:02 +0530
Message-ID: <20241007093302.2962223-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DM4PR12MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0dc26c-206a-418c-acdc-08dce6b315fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CWjjx6gYpqLHfmVUlqm1Q4gb0VeOSsm36EcSwU0mZKF+9nBEhVBNxTJ0j83w?=
 =?us-ascii?Q?iwYkyj+1IrKiJxOS6uBaJYaKjjNLTwDVFVieY/rlU2AxjhwhsfntmUm8NuAY?=
 =?us-ascii?Q?LWw+fk3AiOcPEmJld/Bw1ABD5wYe8UFkyL8hMDHTOice5hQnKJyhlv7CQZpZ?=
 =?us-ascii?Q?aZqqrJNjUhc1UqQrsBxZjlnMnd6u38nDY4SDa+w2OpQRAVtXrQgK4t62Pdr8?=
 =?us-ascii?Q?1+GBUtyOF6q+I0jQl1+8axGpYRzvktqPt6fHzTLR2quJ95voxIiohcbBE0A9?=
 =?us-ascii?Q?g8EW68rWTskGOxhBdS3M4y+NNGnwvNI3UyYuz1RwjIdJW1s965iwFoqfjDnQ?=
 =?us-ascii?Q?F4Dpn5j2FeA7slggbWD7W2Z35MUG9IzUITr/VLuUJKdSBzsaAgzBxMAfso8E?=
 =?us-ascii?Q?VPlwP/jEcIEeqtLgg5l3BKtmeBcSHg4H8JDMMcimDhzLZseEiDRm9DfUt5GU?=
 =?us-ascii?Q?dlTHtK1H6Vc/Th5U+rnuLb0HLcz0Z/RDSVHrsS+wIKmK5g3FMTKQ2aY4FxZ/?=
 =?us-ascii?Q?rLGDnjrH9yX7lgoV2ofrA5HruG9HkMwg35SghIUIrrDdcZmwVdBSRE0PUCkE?=
 =?us-ascii?Q?tFUY20O6i0u6+X6dR+2hpjlqetpljkwsJWsoMKF/xWJwgeX5ebVo1DzjpMaS?=
 =?us-ascii?Q?4vErWxMhJoRv9TI110BPIB3BgDqFHP0PhncnAz7K0basbG/CloXY81bdHaEl?=
 =?us-ascii?Q?X1NUCmbP2x1/NWv4MDOzi8RytyEYQY01cCvbCs/52h55BZF/f0S3oMzOhZcZ?=
 =?us-ascii?Q?M2EU7PucPheELzoOMYSEudjqaSF0AjAWM92HUkJk5bLqHqh0OG8IybVZGlOA?=
 =?us-ascii?Q?Hn6BC6tTmGb80uORQiBRm9qDqw4sq8My24WHYUOLdZSpCeMGfek4OAdB9qgU?=
 =?us-ascii?Q?Kk4mZEGbaHLB2fOe+NMpTaxeJdvUdDAG0fbQnak0YyRtbQykynPkf3F5Lfkv?=
 =?us-ascii?Q?pOQx5dm70PX/efvyQ47qlbmMlUJlIY9FweGpQZ37oQdiU1Yik/bZHx1YVwj5?=
 =?us-ascii?Q?9sExsARcmwPxnJ0ZinfMD79kmmjqhh9v7Idz2KKQYj5I/qeioZOu0253btpq?=
 =?us-ascii?Q?cRo4yVt44A4RiSjlUjFYnqtPJqpDAkFTR79W7t08+fcd0/zPxDy6rbk33RhP?=
 =?us-ascii?Q?wf9Tb9AkGfRS0jXCl1/mGv9bt9a2E9JSWDdbm/vLyE1/FX0GCBU9jfpxYLDm?=
 =?us-ascii?Q?1RApOdACiZmg9nqZiW5pzs+3wtvNgFnY2XZNqenkfZug4POCi8OU6uO8ZBX5?=
 =?us-ascii?Q?wiRlFRnHkJWwU4dON4toFd0nqCosVTE4T4N9ThHd7FsCz90YnWbL/ccEg+BR?=
 =?us-ascii?Q?nZlEvTuGCOeymV5xokLcZ8gE4CgQS9RlmGMkPVR+sdYVIovRD/Et1AgA+II/?=
 =?us-ascii?Q?IyiTIKqjNUOsAKlmiuOlM9cD6pT6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 09:33:22.0398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0dc26c-206a-418c-acdc-08dce6b315fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621
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

When reset on initialization is requested, wait for the reset to finish.
In cases where module is loaded after boot, this makes sure all
initialization work is done after a successful return of modprobe.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 6532b7530a5c..8e697273d2ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1554,6 +1554,7 @@ static void amdgpu_xgmi_schedule_reset_on_init(struct amdgpu_hive_info *hive)
 int amdgpu_xgmi_reset_on_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_hive_info *hive;
+	bool reset_scheduled;
 	int num_devs;
 
 	hive = amdgpu_get_xgmi_hive(adev);
@@ -1562,12 +1563,18 @@ int amdgpu_xgmi_reset_on_init(struct amdgpu_device *adev)
 
 	mutex_lock(&hive->hive_lock);
 	num_devs = atomic_read(&hive->number_devices);
-	if (num_devs == adev->gmc.xgmi.num_physical_nodes)
+	reset_scheduled = false;
+	if (num_devs == adev->gmc.xgmi.num_physical_nodes) {
 		amdgpu_xgmi_schedule_reset_on_init(hive);
+		reset_scheduled = true;
+	}
 
 	mutex_unlock(&hive->hive_lock);
 	amdgpu_put_xgmi_hive(hive);
 
+	if (reset_scheduled)
+		flush_work(&hive->reset_on_init_work);
+
 	return 0;
 }
 
-- 
2.25.1

