Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EF9C2BA1A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 07:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19DBE10EE5F;
	Fri, 21 Jun 2024 07:56:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B9NunzCy";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B392C10EE5F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 07:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAg/u0pm5iRehddVctXPK24R8dStdFM1HXJMMEgQXAPDXpWyHix6zBQThj9lLyVT2RB6wtI2i86JTwbQNhZTKUFOD+2knbig1fk0sRHKIffC5t9AWAUS+4wkOhjL/TumYGR0MIDAOl6HbwMMWiIe5bjPbzgCvzVRyVBsV8Dmze/wFr9Icl1DT6c9EmHLNkeuxjVE9ACK7QLySaKpUAkUXErYCWJ7GAp6CAvcXVlTziFJ1mVbBZ+nJgnoAnqVJchMUgUghbUf1/J0zITVX67jOj9m9XC65vSrNaihEupdV75Z/N1HS9XQHrwjVs2kNtuSga186OCFSSABIphQAGQL6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9hEFFG6Z+qbYs1UuMUkHKdKYVt3USyHkALrwtLoojI=;
 b=fa45TQKJb58cz03kEY8J5uyJZ9VOlmf9yiliN0Ixb669s/puAM21f3fSB4D3vvshd1W4jGwXS3BbMGeTpKINdsbRly1fWHrDdeDeC7LqaS3Sc+jj4tXu1HbjFRG2jaebQQEw2RwPrSviPPgwbLRCuaFI8ues5Mli7n/ahwNO91c/+/n7kKsOc6RCzqU3u9kybYvN51JZ28qk0wVIKf0kpionwexKzbnKESBe6uvSlIRLf8kJ0sfXRXiC0xxI1U9/OpXCDoxgbsN59q9iaoQJLnRr6YaIchxskcVevuy61jVrLCi4pMi2A/n0K8pMmg35sCJO4l8dhz9QEWkhZ8jtqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9hEFFG6Z+qbYs1UuMUkHKdKYVt3USyHkALrwtLoojI=;
 b=B9NunzCyk5KhSbY7Ez76D6Y94Jca0DQipI10uzerkC4fSxJG7AvZjbpv3CXid9D/PUZJFb7cYxvKhXDTMDzTvCMCg9Tm64ecM9YKkuHCzzt3XjXkZ2J4mZrY6j4bw5U8YVvweiyWVI2fbF3hqzJuyqs1T/UyEYGuKSPx9sXM/sM=
Received: from SJ0PR03CA0355.namprd03.prod.outlook.com (2603:10b6:a03:39c::30)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 07:56:37 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::da) by SJ0PR03CA0355.outlook.office365.com
 (2603:10b6:a03:39c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Fri, 21 Jun 2024 07:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 07:56:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 02:56:35 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 02:56:34
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, Frank Min
 <Frank.Min@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix smatch static checker warning
Date: Fri, 21 Jun 2024 15:56:29 +0800
Message-ID: <20240621075629.27060-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Hawking.Zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: b7adef21-5a74-4e9e-ee5e-08dc91c7ad28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r85+pgMK5Q/Uyshe0zBGglTbhnytIO5k4qu/g/VmVosouW8K/o/+l7DX1qDZ?=
 =?us-ascii?Q?mpCg5pa6JvkXT6p/0K+XCwmMYPI5UuAwQ07VMpXINSQdKknjGJTJ8jy9iAiS?=
 =?us-ascii?Q?mk9HXdLLSuMGCvGc7JFIeZoSiqgyDp1nywzbCrVsNLniCgTpvpuhQavkYfxZ?=
 =?us-ascii?Q?8PQqCXWuuEhk0ijRZyvdSa/awpxbAWTpGQqamb1o0JtM1q04Vt3u3SgBS4Mn?=
 =?us-ascii?Q?2hMC8mhW0yTgBQTJDOainM2BwY09zZs5mNt2Ip2ATO0pfeFO4gH0ZqX5f0hc?=
 =?us-ascii?Q?yB1/xQAdJ0YazbuscUjtMaI3Zi8IBNYZrGmKt1GmiMh/ORDAON417crw1sCV?=
 =?us-ascii?Q?ZzhDYc2pjn51B70k+aTyOOrfdwDf9Gr9N0pitFhTTTOPOn8FWG42xMn+Q0yv?=
 =?us-ascii?Q?rjHccreaOKvvuCAyPj15QA/gUxzQLh0jnrfeC+2BpiZTV8RnzqpnBTBIsIG0?=
 =?us-ascii?Q?QIKSVJIIMRgdV3nKcCgT0QIKgUFariM5BJL5hoD49WFgqXLumAZFFUvu4r1r?=
 =?us-ascii?Q?WfRxnXH8o9tKD6ad4bo2HYW2ppibKD4sFYrw+h6hn4PvAeE2wiuEct7zzmxw?=
 =?us-ascii?Q?OEGUGYA8rlQ4Pf4uQeTqvs2SiTIHjSmwPHNH8Iic7WOb8u/8+LefIRIBig9Y?=
 =?us-ascii?Q?IEfdKkz5pxsY4U+h4WlE0KcUc0VMsgs0nGYP3U/poJ8up4AkWwoPny1aVrHr?=
 =?us-ascii?Q?2+2lpfQP91LPW1Tqll1UAM82ZMV+FfgOhukfQUtF7V6IFAPef6PGpJK+gi8l?=
 =?us-ascii?Q?ngimHxkrPh35/4kUkNuFkbk19+0lIjaxJHgEQidtwaDCx/MLYMIQh5aU6ocx?=
 =?us-ascii?Q?PWeaixh2P6wqlWREfY4Bzy3l0fvK4Vyx8pzxfwho1/NTls/cdBzEiFi3jQDp?=
 =?us-ascii?Q?ycwf9XOAaVtjHedbqrN7xy049CA7ZuLEP09J+mHfK6b0C/OJOEWhdO7MvrXF?=
 =?us-ascii?Q?GM1M9UfXed5e9tIynzW9tT2kiAvtuovAbq8AeZy2pRBt9HjwIljwMvkuH2Ip?=
 =?us-ascii?Q?V5WHmHLbiHppXN9HhW5bswRsQimEnVI4urtboV45mHpyUVUB/91W+5hBmHZU?=
 =?us-ascii?Q?oipRkuGbvQP2+wjcj7MwJeQMYsaDPPXtowVTvhB8TbNdeSkKe7nyIy785kbK?=
 =?us-ascii?Q?wvvo5hg2MrUMyCgpsOK4hbTRjLDtUe7s4WOxzLzG6UZk2XjPMT1ScXqA1VC5?=
 =?us-ascii?Q?GjuHTdp9gnMTNSulQzJ64HQdVi1gcIT3D4Q+Qp/GDZNTUxrbsAFz9Z2zCOj+?=
 =?us-ascii?Q?KL8E7TL/BC+r1GIVr80kXiTQ+nKDlG6pH1A9nAqY7xcCWeoKbdW9RsBhOCMD?=
 =?us-ascii?Q?bMmCJCrfLXuzyQv8GlGjAhHQA4EOUzy5fYE9XowkE57DE+s+xNOvDbwqfpjM?=
 =?us-ascii?Q?AfaLLDSrNWamuusSSagPZ1GV7W2dmDQwkYfkiNMWBh1RzO3yug=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:56:36.7709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7adef21-5a74-4e9e-ee5e-08dc91c7ad28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708
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

adev->gfx.imu.funcs could be NULL.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index b4575765d7a8..5c17409439f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4498,11 +4498,11 @@ static int gfx_v11_0_hw_init(void *handle)
 			/* RLC autoload sequence 1: Program rlc ram */
 			if (adev->gfx.imu.funcs->program_rlc_ram)
 				adev->gfx.imu.funcs->program_rlc_ram(adev);
+			/* rlc autoload firmware */
+			r = gfx_v11_0_rlc_backdoor_autoload_enable(adev);
+			if (r)
+				return r;
 		}
-		/* rlc autoload firmware */
-		r = gfx_v11_0_rlc_backdoor_autoload_enable(adev);
-		if (r)
-			return r;
 	} else {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 			if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 460bf33a22b1..16fc5c5b15f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3258,11 +3258,11 @@ static int gfx_v12_0_hw_init(void *handle)
 			/* RLC autoload sequence 1: Program rlc ram */
 			if (adev->gfx.imu.funcs->program_rlc_ram)
 				adev->gfx.imu.funcs->program_rlc_ram(adev);
+			/* rlc autoload firmware */
+			r = gfx_v12_0_rlc_backdoor_autoload_enable(adev);
+			if (r)
+				return r;
 		}
-		/* rlc autoload firmware */
-		r = gfx_v12_0_rlc_backdoor_autoload_enable(adev);
-		if (r)
-			return r;
 	} else {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 			if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
-- 
2.17.1

