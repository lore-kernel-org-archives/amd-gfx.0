Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D578EC83F1B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 21:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79C8910EAC2;
	Fri, 11 Jul 2025 21:51:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dr2xUjf6";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6304410EABF
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 21:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tM32CR+hm2NYcH220e2X0j3jwWC8PX7rKY76neVqW5xNb/ZwQSpOjlC1/+uJm6cWfCRcUnIEA5nVdKOfiXhT+s9tVuR3rKAVIO1oFSrIVm1cbwtDPFCQkWiH6doQRhIxNiEpQ5Zg3Jr4nUXbTgJggGZlxKxFaAsQIp1VzWPZ1MVTlQvjXmJlfaXebGyzifaWMzQq7JP4wsyfBpif3ezD++SG7hdjc1c9Ne52f1rVOFnaeqP0AlHweo7CRMmisd6jSq4h/OzokxlQB/gb/gY64mFS6yzDKUCdgK5X1viZ36d33uWBqDMM0wunRl6311ZJTCG+jRZPl08zjcK9TpnWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CorwccQkvnX4/BQElah1OTkA/SfM77IFNGSN7Zd/DVg=;
 b=YgB7a6aZfKryecCGfZSnwSHORhhqNBjZbw4mBELNEKYYSQh3rQ7bDwPzewkwWPnUICcOdNIkVM9Hxv+XH4vC5cUJgPDlnsV/fYzsJWorJTM9HP6A+bTWc99JeKg/2KCbsoyHtHT3f9d6ekMi/YmnzKyyr5Z+5IuaTOOg6feHZRqypTmMOcdMVhsbHLv1Nc4zmbf3RU0yuB6kmzhuTpofdkE84KfTn+7Pu9D+3VruLdFd87lvszBMulVypEMfe32ysz5xrGz2dWfJaRQAz8TEMA8hxpww85K9J/9SFZAfKMV8ttAPtIHApfc9HwlDFah/fiiv4NCmpckFDvxywl21FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CorwccQkvnX4/BQElah1OTkA/SfM77IFNGSN7Zd/DVg=;
 b=Dr2xUjf6OmSpbl60jaVPR5H2qYsjzsUyfPlbQT654zLeMd5gnGUf/89K7VES2M7vM2M6c+PeJv9minTnnx0w8eDAkkhOTaYTCYrNMZZlV/P/GuV/333XVbOyNVPVi+w+/zwSvgLYq9I/cxAz6G6biQ8vDJbsEo5/cnAduMKwdqw=
Received: from MW2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:907:1::18)
 by IA1PR12MB8406.namprd12.prod.outlook.com (2603:10b6:208:3da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 21:51:37 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::c8) by MW2PR16CA0041.outlook.office365.com
 (2603:10b6:907:1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 21:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 21:51:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 16:51:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for queue priv
Date: Fri, 11 Jul 2025 17:51:21 -0400
Message-ID: <20250711215122.23288-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711215122.23288-1-alexander.deucher@amd.com>
References: <20250711215122.23288-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|IA1PR12MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 6123d7fa-8ca6-4119-3d97-08ddc0c51c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXhLcExEL3BsbFNFdjNuNndhTi9wdmZra1JvcXJFaDVVTnpEcDExTEdERW5S?=
 =?utf-8?B?Ym14NjRjaTdZWkFpT0NUNHBIbTJPNkhwL1ZocGN5T2M0Q0hkMGxVUFFueDV5?=
 =?utf-8?B?WGZoSk03NHYvd0FKZmhiQklqSGxVU1YvTkFKZmQ2MjFLQzgwbVRLS0IwVHMw?=
 =?utf-8?B?ZjhPNDRqQjRmMHlhL1NBK2p0cmU1Um02V2EycVdrV0F4VmFHSkpqUXVIb01T?=
 =?utf-8?B?RXFkT3NqODdiOGpIbkZ1bGhCTFh5S3lyeHlMdzFxWUEvY3F2ekcyNW50L25h?=
 =?utf-8?B?TVpDMFcxeXA5SGZaVEZXdEdhRGNGWEpXU1oyWFhTZEFwYlN3RzV2ZFVPNmQ3?=
 =?utf-8?B?RkNCSGErN0tEcnlwclhRQ3lYbWpjK00zUnltM2pDRnhnVWd2QXN0b0FnbnhH?=
 =?utf-8?B?WHBRT2gwU0dqMW0rNUViS29XaTluTE95cjJpMkE3NCtBcTYwcFE5aG0raXJy?=
 =?utf-8?B?VnVFWWlwK2RMOGZ2VHBFeWhrZ0tDM2JtMU1xMkd0QzBhT05aUzRVMnl5eXZP?=
 =?utf-8?B?MGx2aFVrTU5jNU5rLzJxYUFCUDBLVHpraEFEb2RGNmJpRjhoTlhHQldxM0Y2?=
 =?utf-8?B?MUhQVjZLT0pXSW1SR0ZmY28xTmhENjgrak1wK3JJTUJ1MXRLNTd3eWtJVUpu?=
 =?utf-8?B?L3YwZE5MMnJCbzhRbFp2ODAxV0xodDZJVVA1RS9KQlZLR1Zrb0JwY3kwSFk0?=
 =?utf-8?B?ajVSNGN3OFpSSHN0YUFRLzFWY3RmWVRzaWFGNnBsQ25Pa0ZzNm9hdzZQbzVM?=
 =?utf-8?B?SmZ4VldBeUpJOTBJbHFpZldwbTJ1VlBGVG9mWG1iZzc1OEdUYmF2MFk5NHF3?=
 =?utf-8?B?WGYzbFFDNlNiRHF1QVNJRG8rdGNNRk1neDNDd2h6U21FUjhyc2dwWG9TQTVZ?=
 =?utf-8?B?ODE5bUVsM1RUdXl1bDcxTnNPdnF4WnIxbzkrU2xnR3RncnNudEtocjVqRFc2?=
 =?utf-8?B?T2VxR1dTdlB0b0dGaHRxYkNtWnpQM0J4V28xTERxSVA2ZnNXWnp6eUh0cEVT?=
 =?utf-8?B?a1RYbFd6THY4bDJZN1ZxWXVHU3FIUHJONjh1R0VJV0l1MGc1SHJHeHZaSVJl?=
 =?utf-8?B?cGJiODRTVHFNckpDcUFERnhQZzZQazhBVEVMTXdSNGtPajVLMTFKOHhOUzQw?=
 =?utf-8?B?Z3hqNTFHYUp3bmY0dnprNTF5TVlYdkpJRFkxK05oVGYreFFPZ3JsMEZFV3JG?=
 =?utf-8?B?NVdOMWs1a29SL25VN1NsRXVMKzhRL3ljM1I3R1dGUGMxdXFMOVlVTXFqMHZP?=
 =?utf-8?B?a1RpbDVIVSs1K3ZQMXkyVXlqa2JRMUlaY3RLY2xmLzFVckRzVjZ5bjZqV3hJ?=
 =?utf-8?B?SHl6L3g1ZUNWTCtFNWJ5YnFNMjY3ay9vVHRWZm4rRkFFdis3SXkzZjRmVmhH?=
 =?utf-8?B?RldiTFhES0hWVnFVTTE2WUY5YnZDM0RKenE4SVVNMHlnTCt3MktzbFd0enhB?=
 =?utf-8?B?aFF4V1UyR01Hcnpqbmx3NUNMV1NMWUZCc3JodWc0T2xVMC8vcDZSZzF3QmRH?=
 =?utf-8?B?UWIzWlFSaGduMDd1TXFJZXpSUDV0bzNCWFJWdGs4Tk93TjVGbm5RTlRIajFi?=
 =?utf-8?B?VkM4YnZSdlBXNHpqeWU2d2tGNzQ2RGZEZUxqakV4VTlDQTZGeENZdzRzTlpG?=
 =?utf-8?B?SDlETzUwZlVmL3hZUlFDYi93WWxlNG15djhWVWwvV09SODY0ck55dW1Yc2NQ?=
 =?utf-8?B?aFRMdGt1aWRmQzYzZVV4OVdDM3F3TE94TEVhQzlPeWRaUzI5aGIxMU5WVFRs?=
 =?utf-8?B?ZXZSY2ZvTmtOejJoTHE2SHQ1RzVsUHFnbTVMWkUyWHJvSnZpZk9HQnhDSXg3?=
 =?utf-8?B?U3YwcVIxM050aDFUNW51MjZFV0pXSlgrQVJmS0hWWDVPVlI5Ykc1Z2ZGUE1F?=
 =?utf-8?B?OHhUM3VHTjhwVkd3M1dibjJrV1YzbC9HZmN4c2NuZWdCKytmK05OZTh1cUNC?=
 =?utf-8?B?T0pDWVJGT29oU3owUmp0eWdRdlRQY1U0aUpTMG5wM1VEakJoZWYrZUN2V3Ey?=
 =?utf-8?B?ZjBncEVJY0dqNFdab0pFeCsvaS9FanVwbFJvbE1XbXY5dDJhREdPa2V1SHZo?=
 =?utf-8?Q?k9B9G/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 21:51:37.4861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6123d7fa-8ca6-4119-3d97-08ddc0c51c87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8406
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

Set the MQD as appropriate for the queue priv state.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 37dcec2d07841..b9ba8b22a1073 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4124,6 +4124,8 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 #endif
 	if (prop->tmz_queue)
 		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_MATCH, 1);
+	if (!prop->priv_queue)
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_NON_PRIV, 1);
 	mqd->cp_gfx_hqd_cntl = tmp;
 
 	/* set up cp_doorbell_control */
@@ -4276,8 +4278,10 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
 			    prop->allow_tunneling);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
+	if (prop->priv_queue) {
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
+	}
 	if (prop->tmz_queue)
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
 	mqd->cp_hqd_pq_control = tmp;
-- 
2.50.0

