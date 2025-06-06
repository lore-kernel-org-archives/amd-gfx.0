Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE8EC5B559
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5F4210E910;
	Fri,  6 Jun 2025 06:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eMpphcqa";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E8410E935
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Prg7B1lp5M0uicP2f2OxYJ6tJhyCDPlkv2XnmJrVfVSjDSTAtzMkFpTPhqw9RVeF2XK0ugVjwf9eNWX3ajFdWaoeU2szEzx6RXx/8fSyytzi+fiMFdoLVGFMVEKEByHprZCsfJJMcMWzjPeF6TI4/swWunH5CDZQuZIs+65wM1R773toxdzTd0+mvabVorEBlcy+B1JzW/KXG1jW6tJd74i6Y+oy03kTB8jUT/NJUO7UQMrCsh5zjsHDUzaKE17euAY7Vk6FDu6wCV/zCYoCMUS7sXgyRKeqGCoocvoBzhL66h33FH6t1eCfsBAPUIt3+gD7UntRJtxZdQVGgEcPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1Dc+fkIxW5eh9kZKhZN6IpJvT7C9jqqHv86xtphXJA=;
 b=OWKq8IDuMYmURA1izFQ6+tVSztzQPnPAr5I8AqwFpHkFybOhQYKoBfWtKSUwTi1whBlJ8Mj5P83xKm+1QLT1hIvDU2uV52dA+BscaRgJud++PxxOBVaNdXAeTxjAWbnG+wufuBfrd6aoYmjEguf3Qz4OejO6EaEONrd/dcOtD01fFsj5QLlAJ6AGhaqtkGjrKZKeCGaW4Zao+xm6wFk/WV8ia/aG94gUeqlhyngS1QqJoMR+NyfBX0bquDGHM32k6uG6La7OFyUWydoafxXO8CCI562VM7/3+3yoRsW84fxv4vnpqeKhc8f5W1mHEJ9BnfC8fdGK2vK9990i1HUEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1Dc+fkIxW5eh9kZKhZN6IpJvT7C9jqqHv86xtphXJA=;
 b=eMpphcqamf5fqKO6iC/nf2lsM5j8p90SOCx9gZIKgVYACGhzfzaxLv4XKXHUQFbigXHcsc7EuT9Ox83ror12Ub2iu87tldvIEAIAMlTGfNO5ByNeCWX26Vyd8qAaaF4bc8251s1bBh+PX+VJ6F6iIuHNhg1LmTUFnk7NyU9kJLU=
Received: from SJ0PR05CA0072.namprd05.prod.outlook.com (2603:10b6:a03:332::17)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 06:44:23 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::8b) by SJ0PR05CA0072.outlook.office365.com
 (2603:10b6:a03:332::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.14 via Frontend Transport; Fri,
 6 Jun 2025 06:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/29] drm/amdgpu/jpeg2: re-emit unprocessed state on ring
 reset
Date: Fri, 6 Jun 2025 02:43:43 -0400
Message-ID: <20250606064354.5858-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: 5138f43a-e495-4258-1dcb-08dda4c591c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yPofYOHM9ktXF1svDq08hd7yOvzfYMAuvMdOrjPFqEtW73R4zoDmkCw8yODr?=
 =?us-ascii?Q?v8wtCNzu91Uyl3NXHnMYdhl4i+h02ZDd38AEnDAR0jCUfR1tCpe2T605sJKY?=
 =?us-ascii?Q?6zUxh6It9LBDurWpq+0N8SJFBN1iAxbadzcWg6rj1YSjSsudQoGNbBBHkNcE?=
 =?us-ascii?Q?lK3Zd9pym5ev+XDhOZRANwjDePT+IMFTNLVPffPrRK8QYdiIKpbG1Cr88m/5?=
 =?us-ascii?Q?F9g/mbTNgefudzBpuYMUAHgCQf8MQs5YwoDkjVEt8xzcSe5EQFmhXh5JLM0K?=
 =?us-ascii?Q?tSBcWpqlFF3T3rdUSwAeBj/oQsBLhlbh/qsBTDgqwfZhF9HkPAJ0RIIjXCYV?=
 =?us-ascii?Q?/U/OZkID4+7ndG0vRjlWQGhrakTLAeffAXBz6flOxkqSnrOPNONOifnKob8r?=
 =?us-ascii?Q?KXikbFGD/vwg8Rng0AqznwgAqphmUob7MqziBh2LVVq4MKPOBtoaay9XdiTu?=
 =?us-ascii?Q?gQM4mLOjAyH9ZdUlKveFOcjnvG9QKnfEba6PxX42XxaOl8uxkASb8NMOYxPb?=
 =?us-ascii?Q?Zrtlth6indE/0X6TX9HTcWdEaIsPO1L+8PYvgpAm5cwXBe5LXUVQFqqcxjrG?=
 =?us-ascii?Q?jGrCYiD0zRmRT86onsDVqdnfoQWGksskTRbUiUYWRRLDmpmLOanFKoCzLrXO?=
 =?us-ascii?Q?0IoiPGSCU7rOsg8ZAJtIsVSG2uggeKWHCn/nG66c8loz5Iw32q+wSISHeheN?=
 =?us-ascii?Q?Hfu4YMEJ5BD0yIznD0bfgaKujbrRwB9Pt3D2P3M4nln2t16o28gMqHKvqJQZ?=
 =?us-ascii?Q?e2wq+cteFpMAoN9R6kuRN3l//M0Ejc+3nWtM4YwiheRxKgK0medrtzTGOyeE?=
 =?us-ascii?Q?c+I1YnM7FTbl1HEA6oyZ21bWiZVahPUDX5aV/8uINevJiYHjJ1vex1zO6ttM?=
 =?us-ascii?Q?u1jcq55279/QJDhvnckA8iwT0xIqECtuStds7316HPMZpNfF4f1tNAThRSYx?=
 =?us-ascii?Q?X4MQYwi8td0tkmKOCMTV/iP449yvMQ25qFRJnRvRWlUImyyEPMpiaygT4C2X?=
 =?us-ascii?Q?Nyos7VL21sk3ARWyvQPHjv6w9Wg8nArFM/2IgB9xSfqneiQwXq1QY+iVKiTM?=
 =?us-ascii?Q?TUZpBRB8DKc10JPeo6JU78IKe5Roag8erTFYty9P6aVOfT8Y4K+YuiIOGowf?=
 =?us-ascii?Q?mAgHg6zOEScTVUM/bOWLR1rrHFjZ/MlKiLDPdfIb8GH1e1EvUxO6UanuwuJi?=
 =?us-ascii?Q?tQLhcEYL/UVrS/cOkSXas1iJXC6+fyV7HkCXETgXOxwfTjAHH3SjgCkC6+Dr?=
 =?us-ascii?Q?0g5hnOFhT6qw7IXMienA5XI3J7D6a3CY6UdJtsq5XaqO1agixjCSLjpa3XAU?=
 =?us-ascii?Q?qNg6d16npYisTCghiCqaOphiXjLflxJ1si8I9XxzKBeZe/d2az2rN/zV0bEY?=
 =?us-ascii?Q?F6HtAivn7okb7whh2Wv/NSCed3V47njPJUYZJN8V4vwZKQBAZ4ppR9KvJAyt?=
 =?us-ascii?Q?CSDyZgMWGiW78VXKolYLzTfJWyRj+Zl8o5EJ/iNOtms2NsBFoi37G0gWuiF5?=
 =?us-ascii?Q?AnVgxJD1Ae8c+zqUAg28OUfDI4jqXfPGZgwS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:21.6193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5138f43a-e495-4258-1dcb-08dda4c591c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index f2058f263cc05..a4e10a54d7b5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -769,14 +769,22 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+
 	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
-	amdgpu_fence_driver_force_completion(ring);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

