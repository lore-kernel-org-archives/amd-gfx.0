Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C9CCA5FAD
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 03:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2789810EC8E;
	Tue, 29 Sep 2026 03:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i/hBBhxt";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E2CA10EC84
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 03:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3mLEIq9GigaP24bkb7+V5yhO6+9M1CqpkdvoeZzlcGfd6WQl9sBuKdWyDu4RGSvZggkTjelDSLG0w47vZ3io5Ns075cCqD67iYwst2sMrWV5XJcYLAbs0kLKT0BYfGPOJd2LBrs4jPSwJV3PZQIWOmaG00+3VuD3IWMPmTxnxNBkdnICObg/13Uzs5sgcbY+3GFg9xbq6xp2UOPpaZ8h8TBWIRSQmLnKuqivgM5yF0bhz3WdBr//IiIIeAS0hiixxvBbLdtoiIDYbXwE9ueJUHhBeQsVA1fQvAk4YlxerxUKgicOeCbpGXVt+TT0StMq7Oqe1ZaFBvJjjrKihjfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaM8J8SeWzR9qaoK15PYC5/xnYP+v1J7pEJAPExTRRE=;
 b=ttBuh817scfYzriLeFnG7Xp5rUCXUSo/dnvmP5d5SnTeXML7/O3NUyrpc6xWhe95qenUZ3GjLC4zmc2fEA0FwCOC3oPhHIBSxGdsA/b0srDDcjp42KZGAvzrJJ077WeFLlPQlLgPzc/pp/BbMNhnsVwRmBXF3rdev9OEWqnrUVeCp2bNSi/Z4Iu1Vqdp9ySXFB7DqBDZCPum2Qs4GGidw2EFyzqpDaMt+nIZhkMlu6GTJCGkOIpBElEBOM1mV6D6rbf4kKx1Alyv1lliE81GXaR7jBquNlROHhdzorzubGBqYol8BqyfhPLt2iTp8yXr8J52LKjgvQpRPf8yqbbqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaM8J8SeWzR9qaoK15PYC5/xnYP+v1J7pEJAPExTRRE=;
 b=i/hBBhxtnLUaAo3nZ9jFAqu3CgVJdRQTDNufmxQg27+1krvTJ/6OesRWUV8YTSKEAwO6vgoW2zbDdtdPa2C5TCz5s0zclsonduk+zOM/1+cz4HvrBQa40VFiD6VJgWWlmC5lxonlYaYR/FaQ74/lEuk/Mh/vShYUKapyvAW1uEk=
Received: from CH2PR18CA0013.namprd18.prod.outlook.com (2603:10b6:610:4f::23)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 03:47:16 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::62) by CH2PR18CA0013.outlook.office365.com
 (2603:10b6:610:4f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 03:47:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 03:47:15 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 22:47:12 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across GPU
 reset
Date: Tue, 29 Sep 2026 11:46:45 +0800
Message-ID: <20260929034650.2393125-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929034650.2393125-1-Prike.Liang@amd.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|PH0PR12MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec22f67-c692-43a7-0146-08df1ddc5a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|11063799006|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zL8gOqLpE3mA6zLRSCOmCJFms9E10srNVoNcnd8dkDR0ZjOI0mHZ4apgMFuGIf5/cwJkpI7IFFJ7neXwqd/IWROs7qVkQLOF5bfWWv3ARCUxznY3cuI9pWF+C5VQ4FXJs+iJARMo6xZFwAWdLnPBDQs9KM5Xamd+4m69+hXgjo9jfm6+8yHhl3SRyUQ9Bd9Uf4/rIEMhBKbPmKyr6K8bBY7s5n+2elJ4BJXYzKW+Qs3fklHlsVYtW/WtaU5I2fMp23mSxHN5hwYJg9XRay5jY5GSj2IucoM1m18dgewXpJ1tFYprP/VLZGask0AISXpOKIWJSQervn5ay0CvkjsJr77ap5N9c6ocOJ9wTsAcBbH91ssNF0EU5gsb5YWR36HHw2ZkUQEAYirXh4zHCpscdvtOS9xphqnn7xqvS+auTVkP6tDaEJWq1VRslPlGw8boIvc/9Mazx2CnTePM+ukPHoACNGmUz5Xsk/OAwwB6iX9502S+ck5WF8fP6CKYSzI4X3P3Xmns2SV8BOjXIAUOpLjJWFYZFfr10qEpol/keVEDguneux7o1StWux5Ll4DcLYxdqwJ9C/kolZPM++UFPVNziWo4ZrtLFeh6XaRWG7XDSkowQ+SHL6cHYucTjIXFCYMZaN9BJ2O1sgjhfijY8Um64hInhkIa2v+LkwVl5M3D8MYybRg8qIQi8/PTiZKqH12JdJ95V2yCD5v1lLipQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(11063799006)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 67ty+29tCCzcZ8iqzqkurRXkCI8QEFf9itc5By9igahrGeFhACr+WZo6qpi/8jGDcpSxW7HzP78Z+4u6Nr4oLZaXT4m3GnPpnUqsAQaonGM2L4c1iAqJ8mbkqPpuKxK5JMl0s/e9r+jKpD4raw/oTh8t0jVnR0Y0dk+rYUW9ql5UyfX0eIqRCygz/Y/KMH9Qgft/jed8DAhXtlhG2U+PmuXrwJNmQEfngRMvGH97kd+tebvt/DNdp8HrTG6CesjuAx8tZrn2mJn7nBMz9RLl92TuuFzbdyWRdlh9E+oMeex5CE7JEEXuPfsRYPHiPChLHpdzIsebpn02fIKRTXcruEd//cYF+ibnwaUrKitVxfvOeQpxhDD7GpzyjY2kOyK/BOuQEF9yCUzlRr20Bk56wMQys9F62sXjZsqm2n928Ig6PXJhj7a0nw1G6IhpRh/r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 03:47:15.5032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec22f67-c692-43a7-0146-08df1ddc5a55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005
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

Protect media idle workers with a reset-domain read trylock. On contention,
requeue the idle timeout and return without hardware access. Keep the
ordinary end-use scheduling event, including from reset-time ring tests,
so otherwise idle engines eventually power down and VCN drops its profile.

A blocking read acquisition would deadlock with reset-time synchronous
cancellation of these workers, so the workers must only try the lock.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 9887a4f99aed..7b10260ad0d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -114,6 +114,12 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 	unsigned int fences = 0;
 	unsigned int i, j;
 
+	/* Reset may cancel this worker synchronously while holding the writer. */
+	if (!down_read_trylock(&adev->reset_domain->sem)) {
+		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
+		return;
+	}
+
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1U << i))
 			continue;
@@ -129,6 +135,7 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 	} else
 		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
+	up_read(&adev->reset_domain->sem);
 }
 
 void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 17db7264269e..f851a6ecea1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -470,6 +470,12 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	if (adev->vcn.harvest_config & (1 << i))
 		return;
 
+	/* Reset may cancel this worker synchronously while holding the writer. */
+	if (!down_read_trylock(&adev->reset_domain->sem)) {
+		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
+		return;
+	}
+
 	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
 		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
 
@@ -499,6 +505,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	} else {
 		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
 	}
+	up_read(&adev->reset_domain->sem);
 }
 
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
-- 
2.34.1

