Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC6AD2595A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 07:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B651110E189;
	Tue, 27 Jan 2026 07:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="peTzbl6a";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED1110E189
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 07:39:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNruuiqSeMABR8FWMxDPHgYmQMM83087EWrDqz6+fU8VZceqcpM5YIQ03r2Snumdfm9C2voSAJipQ3EZnI93Nij/GPYF01SVqSoDQFneRXOtBYuX8qpOy7VDl4e2aVbtY81syR4oLzZoG6FVmx4k4SUb8E2yWq3eNVqauvMBZD9i9qTAfXGlrb+iu8s29mHCwO0czXerTtiEo+PiQ2JofL7QRCit87UX9JX1+6GlS0RnreB4I6kXo+ThyYIc4qpI/uupcAg25i1iTL4XUVoIHMiW/ngI2y2qnlx9WaJB/MHQ38lz9nzPXHjXVSoq4eBaFoT3cy7uvhsnahNkR9+fIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXAetpXA8lVimX7hXfi6UoaoE+lvRaiR6/N78WoPCpk=;
 b=cwX9m7bEI/oBbERiNHGWKU/gri4mvx5ktUaMRR+gzs/dD8vcY+C/810N1uiMmMvxUoaN85GiE8wqWsNIoJ05nUeAEWWE/axlb27XdThD7I84xAHt33rBRyzMkXSlnPAVwHXvp9IB9QMfL8NmDeaL2nNHBCU6xZnNVLXKf93LSLtHiKisZ+0Ie6vAXuIs5ow8C19GHDrsmV88bmSgDl++bpGez26/PTWRNq+yZdzKFoQNhieYDndOgC2bIz9TEm8R5LqEj6NbMKTeunH8ZCycbbjWbfhjJIb6nC2usYPgFwDKVUWqkOlABd1T2zbnxV7j6hGMPwum4k7Pa/WNPyh2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXAetpXA8lVimX7hXfi6UoaoE+lvRaiR6/N78WoPCpk=;
 b=peTzbl6aLcqvVwmLGDlUQiw4+RvTXo1dQPbbv64t712vQ6Q/e5qKDk0N7QEFjr8kOQ0RKcwEVk/zztBUJ8ZBjgV6o0FmCt4zty1IrSjZ+3c0npFwwZpSLRjIVeXT9gIusd8mCvwZKeE3u7R1HOOca3c//f8nchWAZOGoH11QNvs=
Received: from SJ0PR13CA0017.namprd13.prod.outlook.com (2603:10b6:a03:2c0::22)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 07:39:31 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::89) by SJ0PR13CA0017.outlook.office365.com
 (2603:10b6:a03:2c0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 07:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 07:39:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 27 Jan
 2026 01:39:31 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Jan
 2026 01:39:30 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 26 Jan 2026 23:39:24 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix jpeg ring test order in vcn_v4_0_3
Date: Tue, 27 Jan 2026 15:39:11 +0800
Message-ID: <20260127073918.2415931-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 43762564-7f79-44c7-9ebb-08de5d7735a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Neo08Di/JswE7ZUSM3nJaH/FO/RtgNwQnFfzk1Nxkwjod/qvpbRipvho1eYt?=
 =?us-ascii?Q?duyGFeiUqyuN9TBndjNSWSRyqeMUK4vdSuaFWgZFlIsIapWZwVmHImhxD9C0?=
 =?us-ascii?Q?CxgTsMM/xvhTpaV+6g6QSQY0Jr/D7h1YmZnhQUlurg9qCe83n7fFYfcAtNpV?=
 =?us-ascii?Q?JHGnWK9DX+IAxkX7UF/4LggwXx5a3cwkbhzfdA6zlZLMvRjQGH6LvHS2sk/n?=
 =?us-ascii?Q?zNSqY0hi4LLr9K2zg+mGPk95Aw2SUHrDpq0bKPhmDBTEDQ2d9vBwfiXFJJiR?=
 =?us-ascii?Q?DaSQym9eRTIXRT6l/qlRGoxHLRAd2nDV/aJy7cRexHnlsyuwqXWQc52oMF2z?=
 =?us-ascii?Q?RKf6hA6Gp3Mt8sMhN1W8BpfHc0fgKBU3iYouLewt7RnrELwg3mRfASRSkH5p?=
 =?us-ascii?Q?xP6pwSLSLVJXv8h2r+QgVmMfpdYugmrkYrWhTXTumNZq1Q44RE17P8JPxq+Q?=
 =?us-ascii?Q?RB/qeh7m6GX+2Wi1G/1pWFwZVuqSi/KHxzz7+vn9f8QldEK5QH3LBFzVnEAC?=
 =?us-ascii?Q?FDN7q0otgkjJaOzOMnNo8Nb2qeo9NLlGqDomA/B8xNgEhe1Alyg+bXgwdZT/?=
 =?us-ascii?Q?i/n3BvyWbYJvUlu4OxBBTlebJ778lCWfCGAeAGKq1RgmuStoDITxOxy+FBYP?=
 =?us-ascii?Q?Xe+/fimUrXbnGtF5N6RYRHQ4ILivCOfPpTbGDcmYCxjc/W2q3Hk8jqOD5bYL?=
 =?us-ascii?Q?wmIbobe5AzOFdwCJPAMlkiS9sEwIxVc4QHTaml1bIsjZ+OzmY5GzTHxtWfkT?=
 =?us-ascii?Q?qRe9tWL1ODR/rZPn1QuvApiWYMn+MK7mH9r0eoE+CmTW592JFWbKAVl44It9?=
 =?us-ascii?Q?Ix7Uxgh+czQPVbe3nRkxfGtT1ipwQOgdrQ3WAn/Vr7dnj5k8G/ERYimflsuX?=
 =?us-ascii?Q?dlPo0ld4XvqB4zjJ5bzcGJUqqTpFSeWhAU6kkEvzZO8PhQcZd18GYou8mUGG?=
 =?us-ascii?Q?io50Pt0yqztf+tyyGyY0ULHTT9IEZVuTzEnYSDTODFRxigCJrtXpAZ7/5ZzC?=
 =?us-ascii?Q?LF5Q/QD9c99JY7btJ7FCXZv0IpEuVQtYM1JvYh8HIBdxuYmzqJ8PELoCqIPq?=
 =?us-ascii?Q?iQ2F/Vs5Uc25qbvOBCpFPZtnjvonFVILUze7m6gRyT0NJW+hlp1ufKE6i6UZ?=
 =?us-ascii?Q?EugaEUycWASCBJtArGYBVF+YiyX/Sw+j9SIhLsp3T6VWb6WQcV22ypkkf26r?=
 =?us-ascii?Q?6snizhSobm2Dnd37o7C9KqWJaP0BDD5Tp8b16fHJUnYhCZs/hXvnknyWo9Y+?=
 =?us-ascii?Q?YZupTItunLXcuBOuCV7nVLkvyYjOJpLOD15WW6hyMQgGIAB8/H99qmJUa0s5?=
 =?us-ascii?Q?FDEsh0+qnDo/O+occWBtOo4TzMLiKMsqGWuyrhCGFeDOtk04aE68cqbUdWEl?=
 =?us-ascii?Q?pwp+dp14KYL8emZRJ2s8n6t5MFAIKaHAqrX31aF8Bi4CB1bNUg7Kv9PUaiJh?=
 =?us-ascii?Q?bKv/V31Q9t5kQciEXCbOjjIDPx/WeC0M8dlI+stU89gZPuqFp8Nu+yqwCvpn?=
 =?us-ascii?Q?HznR1/4POB48wo1OU4Ly+LlIDuNgSWINpu5iJmUs79F5Klb9RW8lnE3o2Y9m?=
 =?us-ascii?Q?5UTcbhJoQouu3Cfs/EnActlonuz8cE8uOO9Ze+yB789yrOwDglVUAy25pxxR?=
 =?us-ascii?Q?+bFbqDwNAttfFovUe5Chvu3wZjBfUzo38dVmXFR2PMZR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 07:39:31.4623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43762564-7f79-44c7-9ebb-08de5d7735a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720
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

Fix the vcn reset sequence in vcn_v4_0_3_ring_reset() to restore
JPEG power state and unlock the JPEG powergating mutex before
running the JPEG ring post-reset helper.

Fixes: c50beca39115 ("drm/amdgpu/vcn4.0.3: rework reset handling")

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index dd247abce1ab..e78526a4e521 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1742,11 +1742,11 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 		goto unlock;
 	}
 
-	r = vcn_v4_0_3_reset_jpeg_post_helper(adev, ring->me);
 	if (pg_state)
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
 						       AMD_PG_STATE_GATE);
 	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
+	r = vcn_v4_0_3_reset_jpeg_post_helper(adev, ring->me);
 
 unlock:
 	mutex_unlock(&vinst->engine_reset_mutex);
-- 
2.49.0

