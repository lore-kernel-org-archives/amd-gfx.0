Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3452AC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 03:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B366D11A047;
	Thu, 25 Apr 2024 03:36:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p731hHKz";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6220F11A047
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 03:36:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnnKs3AL+8pV7b8M8RIh16s2qL/agLVatFipw7+kT75oeIejuTMKE2A+jFE5frxCb8tCCtw+F7CJ+9fyo+EECY7tJk2p6/Kg1j1hgHvhN/k21xeUl2887Ovi9enp7QZgvyKWlqEMzEn2SsGVIh0Q84r3f+I9Fo63Y30JO6kekk5kIa8Pq49pBqYGeUFrmgsxh5w5kn6YGcbLFuvTBK/QgxB8AiNXZDGCYxiQIAe4kbrYfBgaWw/srDAkqLBdtH4hLtCy3RHIgCAEhTmWfaXRK3bUBnupMzm2pAosIUw10GyWzb0IZuaZBV5rbNLGGVXi1r1WTrElJBx7EuWLmajeWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHfUq51YDgcChB/AYIbcOJm2dc3hDeDzdPvBiOFZVP8=;
 b=Wvn7NyhetGWKnQCOmoN7u0a6GF2vqcZ46AFK/5KxjpRbTQPlwb8CtVNuLQfjHdPgcOQSU7ZuFEg+hmKNqLDi1A1McqGvxzIKo3TXD9YJDay1Ul3T6clcsXJCZSpDT3tThSyo9xL+gkW8+WJ0wvnfCoQMTaxSFmDcepBbA4De3eY+68Wg3b4806tRFFqCUlEmxe5g0lkU7lYyH8Rrv8Nag14O2FeCFASGg8rBZFNAqENq8+VOZzUh9PZwd1YmrEyiDdBArVCbhzRg3/H+2FTuJLdKNtbkeM7ixccBbslfgyfN+85ti8D6Mu48dzes2QeDesVDHtQjkMGsNbWj+UJLJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHfUq51YDgcChB/AYIbcOJm2dc3hDeDzdPvBiOFZVP8=;
 b=p731hHKzkc6VznkNfzawTmOKzOlwo6DWf5IVdanBMiuD4nt+pNml6D7uxIXggP2U01AGKmDuH3S5jd4ZCwr+ntiR9bzq78C8v+cxzjVqCEdSE43SFVmj+LWpiA3x1UlW1BLS1kBmgN8n57h7dSnA+jE9x8dY5lNC9DBh8QGKlqY=
Received: from BYAPR08CA0009.namprd08.prod.outlook.com (2603:10b6:a03:100::22)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 03:36:20 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::85) by BYAPR08CA0009.outlook.office365.com
 (2603:10b6:a03:100::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Thu, 25 Apr 2024 03:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 03:36:20 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 22:36:15 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: fix potential resource leak warning
Date: Thu, 25 Apr 2024 11:33:25 +0800
Message-ID: <20240425033325.1307714-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 220db43d-bc31-435a-a11e-08dc64d8df7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X8GSNGq3XVxrsWiV2FM0zzqXweBPQDskzRsxb2z+I3NbJ29mRSLAhp2Y7lhe?=
 =?us-ascii?Q?l8cU1RqNuJWvawi/Xz2TJlxbaP2rkf2v3/zYyq49Ub2U+HIz6ldnaNDLC+Nt?=
 =?us-ascii?Q?ETbQN01IatfsmH9SgreLi/BlEyRc3S3CjHNq0SP+pPQFCUKUgCZCjk1UwF6K?=
 =?us-ascii?Q?KcweZteSoMKXzblf/2YCNPDyRe9wu7+UsEM0e/lxG741F+e6zVM8Yc68Bldg?=
 =?us-ascii?Q?OKywyPIwwf2bLr7L9D/wz2M9ARf6kHoaLCVMDpzVm3wfEPpc2+HSJ/uq9cXY?=
 =?us-ascii?Q?JG4n5X/SEHHQhZIYVx5Q3ZsxK/zzqwE/RyQNoFtLhz930hTLYTnLJoB+XLFo?=
 =?us-ascii?Q?OUH6Vd05dskMp7NnAVP0EaxxOQ+ohksJ+rn30xQ0oAW0VM5exZOXSPYazVt3?=
 =?us-ascii?Q?gEiZFlHMAZlqz1zgDCpEURGCj6HgRcxFJOeJ9AC+PxLh7l8jQABSgD71nhQP?=
 =?us-ascii?Q?nCaeaCs4T8ED/Tw+E9i/ff0AZ8EvbSc5h+bdJ9h2rVCfm9UIS6WOLRrzYY0m?=
 =?us-ascii?Q?YWCXUm+eEpJuPEM7AaElzLVOh0yomtQxvivPcOjIDHLw/+eOyYSa4/cT/+20?=
 =?us-ascii?Q?vBmtpGEtQ9jntDZNAi5uIaXqPnOuL6PGU+JiZAysEHaHuvU+mGrx7s9ymS60?=
 =?us-ascii?Q?mmZa+KcIEmJvTxnpApSwgeNJRaVOQt64pCvuLy1NEDUYZ907LPGuZiA97cw0?=
 =?us-ascii?Q?xFgBqP43tnslYD1wgcF/jO897rPM///TqC24Hs2yng/4kW81y2iEH/7Y/Csv?=
 =?us-ascii?Q?WQmExyjqhD6hc1BvMYY+Xe/W3zDmpRB6fk+eRom99XupMb3QRVgEk2y9SseI?=
 =?us-ascii?Q?km5W7WwpMzv0lXo+u6vtcO+9CMJPPD8sTdruVPr8Z7UFu85yTGaluEDYjmpW?=
 =?us-ascii?Q?+kQTL5e6JhcvdrssYKuImKzu8AxWpKn+AoNEtENNV/NiJSqe8FWXw8uCaOXB?=
 =?us-ascii?Q?Wu+fsNSJYHZ+pm8vU4vl1KGMko0GKJRr1CbwvZZStds12fMNNBmEbfEt/Zaz?=
 =?us-ascii?Q?Zarop6ynzrq3by47VGWsW6nvCJacK/T8LJl/5QsRt3CfPwFU6A6YjmCl3w70?=
 =?us-ascii?Q?VZp4tOOjlOQ1x2DpTdfmlbCeLVQ6YRMPSTMm5eWvFpjF35zliFwAVwsCEaa5?=
 =?us-ascii?Q?hVu8upJMbO4ssJsjckYO8ikb1wgR5lhgkPFiADksdqcTua9/+JYtMaobsNMy?=
 =?us-ascii?Q?RrmfpUSxh/gCO/HbJE0uVkQpF9M5w2F1wwkA/5CIcrt3f7Wo7lfjNHrnaQWF?=
 =?us-ascii?Q?pN481pi9+bjko1Gs/aKlEnPwKj8QsBKvsBlSMgfZQnRSDDBP3hur1QudnlYC?=
 =?us-ascii?Q?+v+b+gBct6DrTQOrOa07SHaJgts21a6SuYy1GWF3Yx60GfYbLMBY18zUMuyh?=
 =?us-ascii?Q?j2cf92JjFw1q4K0DBfyVqJp8NMXJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 03:36:20.3536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 220db43d-bc31-435a-a11e-08dc64d8df7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480
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

From: Tim Huang <Tim.Huang@amd.com>

Clear resource leak warning that when the prepare fails,
the allocated amdgpu job object will never be released.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 66e8a016126b..9b748d7058b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -102,6 +102,11 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
 	if (!r)
 		r = amdgpu_sync_push_to_job(&sync, p->job);
 	amdgpu_sync_free(&sync);
+
+	if (r) {
+		p->num_dw_left = 0;
+		amdgpu_job_free(p->job);
+	}
 	return r;
 }
 
-- 
2.39.2

