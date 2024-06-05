Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C526C25B78
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 01:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DCB610E675;
	Wed,  5 Jun 2024 01:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uzcIoLGv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC2C510E670
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 01:33:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/iwk4OXuEUlCaQKpKLQ9GGJgwlJ1euoQYLGaAHeiIshUItZhGxvrvHMy6b3kKSekSJ4NWWf9FSuNV7HP/Pm6rmbjVAgHQiDAGyeWU6dpeI0wYnl5WRkFUNLgjRurlpF5O8R6KFwZvT0dnzvOAjWo3OPZlMGhbboe0FfLAoSJQvyYBbD3nK6XMj5J0HW/ICTB1ReGr6DfLqgWpSzNHmYEiJRM6V130scdU+EvbecQfKgBf6jUta80EtZ4E9sBMDC2Clr2sZQ4tTRP+tVZbYtqt8bjRObhRpskeLygi9iYNEZH0QtLHHEnMBUZoH4Wp2z1zk9aApOoL6EO6mSl1iQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlgqjIdJ0+IjyKWEH01MTHoYWJgZTd9CVlHOC0BD1ng=;
 b=OkbEW7oPFimHR5Budnfg9cMpbn0AQxNj93rHQ5pKKoAt9vmL/cXaYOb3MbMQZiNThEPCWYUAmNtkNLGQ5E7H2Lc/0p9FnUrp/AAtBIuLXzYni5Cy1tW6LmofDw0EtZkCudKr9D6Wt/se1N+PmB/hXAtadO5cuB/1XxEih7XmjuhC/V6lOSDAjTThk/zsDBxyXurA1RjFO4x9wt9HHlq9mQyUpHNWB9S+9EOcqYkkCdScwXUMucZteN1qn6OlHEcb/5LDSsE0p0YeKEPGFeCpCOchyLfdNIUqWJlviVF/uOJ//DME8NctLDRcnJXNCalfp34fJK0B81cKnBQJnzA/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlgqjIdJ0+IjyKWEH01MTHoYWJgZTd9CVlHOC0BD1ng=;
 b=uzcIoLGvx9M+MWiFxZnhtJ/kmNdPlDoto7+L1UHge+KfIX8eagvW43MQ2bp6raN5MzcrzvvD+C7BTI+6d1BxNZmpq35vjsqFQnoTT2k9yfcxHtDTP+zqL2gvXBJSQAkC0cjcl/XCjVlHeX0dcK9MbeaHDinVkrSzQPwX6ZAzoTE=
Received: from BN0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:408:e6::19)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Wed, 5 Jun
 2024 01:33:52 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::b5) by BN0PR03CA0014.outlook.office365.com
 (2603:10b6:408:e6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27 via Frontend
 Transport; Wed, 5 Jun 2024 01:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 01:33:51 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 20:33:48 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v4 4/9] drm/amdgpu: remove tlb flush in amdgpu_gtt_mgr_recover
Date: Tue, 4 Jun 2024 21:33:13 -0400
Message-ID: <20240605013318.11260-5-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605013318.11260-1-Yunxiang.Li@amd.com>
References: <20240605013318.11260-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: ba39d065-542f-467f-7e65-08dc84ff8e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YW11eEdmT2NTb0VXcGlpbmd1TWZya2JwYlJ5VzJrK21YYzBJVGVPd0NpYlJT?=
 =?utf-8?B?VHJnMXR3enA1OTVxVGhKUVV4Wkgvc1ZoYnROUnVDYk1lbUpabkJyaWU1dW5k?=
 =?utf-8?B?QnNPM2ZIMGhkaUhJbVVXYTlNb2I2SENyUXpjL3Y2OVorOUJLTVpjYWtwMW5K?=
 =?utf-8?B?K2w1bFpBQzdWc0dJeHhXWnFUZDVjOGM2dnZFS1FDQWtBdHU0MmFQdm5ramhy?=
 =?utf-8?B?UnlvWDkvUWxvenByVjR0dUdnTHlUVWp1a2xmVk1qMFVCbmU0dXJZd1dMOUxD?=
 =?utf-8?B?Q1pReHlycVhyR3ZZcytiaXlRaWdrY2FQUnk3L05RREZobDdES2pjb3BTcS9S?=
 =?utf-8?B?dkQ4aS9RL1lkRU5GMGI4Z2QzUU1tTE94SDVRT1M5ZWxvTDJOT2tobHpYdFFq?=
 =?utf-8?B?T255ZSsxRktlTEpUaVZNdmk2cVM1UTc5bzBmTWxlbkNEMDlmQW5LZ1VEK3B2?=
 =?utf-8?B?NC9CbHh0NnlSWlZzZWFXMGM0TFhUMi84Q0tPQStkVkEwdFFoY05vR3YrMTdR?=
 =?utf-8?B?SGc0SWhueFNmR1ZIRXdjOUppUmsxaWFYQWZTQXFic0U2UkRNVWZITFdYeFA2?=
 =?utf-8?B?L0ZyNTI2bjgvQUZkdlJiekF3N2t4aWxySVF1Wm9RSXFBWFFrbFNCQzdxRWJ3?=
 =?utf-8?B?UCsxVXBtUU1ZeWFyV3VQYlZacDdHeVlvbUVkUElsbEVhbWwwWEdGWDlrcFlh?=
 =?utf-8?B?Q2Z5YXpjYUtWT0hHcExDZ1NJRFVSYXpieTdEUUl4Mm93cWVxaVZNTi80VHNO?=
 =?utf-8?B?S3dwVFJydEpzN0M0djlHaHFreUtROCs1cGNycjJsekNobUVXMGd3WmZBMnNI?=
 =?utf-8?B?VWc1dVA3SlZvV0g0TjUzMmNhOGpBNlAreHJJTlA2ckUvb09CaTJvNnlDYzhw?=
 =?utf-8?B?MlV1ZlNVSEwzZDlFV2wwcTQxbGMyY2V1MHJOSWlvaWNsekJacTk5UGdSQW1r?=
 =?utf-8?B?eUV4ZmlmcVVlNDlSZ24wMS9oVitRWnBHTXRpMmNQSmFoamE2azNaL2xEb3ZI?=
 =?utf-8?B?bVRvVGpHSkFrNVNRSFkzY3k1dFFLeEUzOWJmV1U1K2VsVEkzeUFBaXE5VC84?=
 =?utf-8?B?SnV1WjlIZER1LzYxaWdnWjhCRVF4ekhsTWlBU1RyMlA3L0NMOXhsSkwrZWNo?=
 =?utf-8?B?UnFxYTlhZ0h5T3llRWxCOGkxOFh6eEl3bnorR0VPajRmUlFtaXREUGgyWWpq?=
 =?utf-8?B?cjBpc3FZcU11YUtSUXgvb2o5bG56cXlmS2Y3TUtIbzF4QjF1QXhBMzFiOVhr?=
 =?utf-8?B?K1NBVk5OVlNWZ0VtWWlSbGNaK3NBSUI0alJibVBqZXRhTFlTeVd0dXAybGsw?=
 =?utf-8?B?c0hFcTluT2hHOXhCeGVjcytMRmJZL1FOWitHZVVkeUVhRU5iTFlCQ3U5M2VW?=
 =?utf-8?B?dFhBSW9wbjMyeVNqb0hJSEUvdTB5SEdZekFwSkl4RzRFLy84c3ZkZ1lUeVJp?=
 =?utf-8?B?dldEQks0Q3VlK3d4TE42aDJIS1U4dk1JbUJpbksraDZ2K0oweEVQK3Myb2JZ?=
 =?utf-8?B?RE9GQzlCTXp1UzRJQklSNmt3OWl0R1g4cmd6RVJ0N1BmRXdaYXhBa1hOdzB6?=
 =?utf-8?B?QndYTVN2WkNTajBIUHlDVE83djVRcURqK216Z29SdmNEUTF4N1V2UkhPcXFY?=
 =?utf-8?B?a05EMEhqc0N0STlrNU16azEvT3lzdThSdHFzZS9XYXM3YUNmamdGbkx2TWRp?=
 =?utf-8?B?YWkvRytTVGJOVlpOUXNUYWZWVDRBc2VIV2h3STB5UEVaYUthbjJheWFVNW9I?=
 =?utf-8?B?OUhkSzZSS0Y1anl3aXRka3U2dW9BZkVrc1JqWFlXUFRFWWxKTlExaFFub3Bt?=
 =?utf-8?B?UG14d3pseW1HbEF0UE1GRHJyTG14N21SRWQvYW5najBHenIvOWRkK2tmVkhx?=
 =?utf-8?Q?wIVoxriR5qZN8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 01:33:51.9267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba39d065-542f-467f-7e65-08dc84ff8e61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574
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

At this point the gart is not set up, there's no point to invalidate tlb
here and it could even be harmful.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 44367f03316f..0760e70402ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -200,8 +200,6 @@ void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
 		amdgpu_ttm_recover_gart(node->base.bo);
 	}
 	spin_unlock(&mgr->lock);
-
-	amdgpu_gart_invalidate_tlb(adev);
 }
 
 /**
-- 
2.34.1

