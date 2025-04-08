Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C40C3600C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 06:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D278610E1F6;
	Tue,  8 Apr 2025 06:32:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pcgcDr+m";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A4C10E1F6
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 06:32:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1PQUjaWS38Was97IbGoIJfmWaJrgxFnUjrn5V3VkwQlkNiqiUoQ9HIFLhESbkdM3/Cr0wvrm0QndyFTLof6EAhu/yFRvqYkK7Kl4z7YmkbeRmbp1uS6hbNXeQeM1BVWoNHOxlBuNicTg3iKa4MDAXLCiA0JF1GJBDDVypv3jcElsbdWrV+WZcBHFIDp46C80evO+fXsM222WmvtINS/4SFiRhWixQfZhe00VN5z72z4+lkl4bMf2HIp9cKEDISqCs6BzikR3de6nReyoGNUg8kN8kjYmGbZyW4eZvH/0TjxHWKcMzK3C62eISkUfvpkcUecvfMevdactDeMbsokcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CO8qAg+f38Gqfz3+oFHmGqNwOR8WCdY5nC++Epcd3MY=;
 b=HKKbpM8crEpTlX3daGGD1jRb76QILEDU/6bo8vdAgkUNZsmx26/AJn8fy7Sog+6mFEMrgEzChVXNShcjtBdeLW7qdMmnJFKxpEsAQphWM9n5T09jf7CPQpLuk9lNKJKhJ9WFvlxKX+pL5FPpATYIwNOcMA/y5c61TWYPDw8zL3/jFasjTBnoGUxx/vyWxAp9lfTOVlhUx8GZGLcN7B3x68dcukXImhkf8itAAQQqNwWk6clCtwRsJo1AJbfF5Ob+cJRQhkSi/p+7SdPTyZ3C69RLRyaoDn4hC8uUzkSDDkhgkwmuelqBzYLg2R5P5iA9mfWcTaKxZbzrqCXucmdOVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CO8qAg+f38Gqfz3+oFHmGqNwOR8WCdY5nC++Epcd3MY=;
 b=pcgcDr+mlSWLmFYcZKF2As4cqikHodRZbRV3cjAX6R6/txl4MZ8reVD6wvldUANR1f07E+kvpv7komEQKewqsWDgJ+AVofHxe2ydY/8KTLz7YSq+AryHL4kvtarocQ5lE4qT6+8Xw9jguFFbPDt55QDLdkYeLk1NFDnjcjiVkQo=
Received: from MW3PR06CA0006.namprd06.prod.outlook.com (2603:10b6:303:2a::11)
 by MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 06:32:54 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::9) by MW3PR06CA0006.outlook.office365.com
 (2603:10b6:303:2a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Tue,
 8 Apr 2025 06:32:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 06:32:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 01:32:52 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 8 Apr 2025 01:32:45 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, <lijo.lazar@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>, "Jesse . Zhang" <Jesse.zhang@amd.com>
Subject: [v2 1/2] drm/amdgpu: Enable per-queue reset for SDMA v4.4.2 on IP
 v9.5.0
Date: Tue, 8 Apr 2025 14:32:44 +0800
Message-ID: <20250408063245.2270202-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|MN0PR12MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 364256b7-2be4-49e3-0ae6-08dd7667312e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KKfDOERDDQn37BngLmxz83+9nb56vJGIU4G+t79Dq/ylBY0LSKQOie1h/JpM?=
 =?us-ascii?Q?HZzJ05NREalO6rmXsN5glsLCgqOBcblPP0QJVVQ2VbbCFakorQTZRFFH+jJd?=
 =?us-ascii?Q?obGjt2IbPZGHbhkFwzs5SGieK1cJ0Gmg3CqbJtUZ2RsRRHZ1Aasz5vnhUMb2?=
 =?us-ascii?Q?qdNv0Ere5vMpG4/Hvnk8o1go6r8qQX0WJ310nX+Gzop5Z8SBe6Xv+R3STQYk?=
 =?us-ascii?Q?O8BctNPIc8dgdp+kNouV1muevKmlwf8p693E79hQ/i+66ELnjWQsLxlM5Ezj?=
 =?us-ascii?Q?cRGwiHj5DjK3o+EZU/hixwhhwTqOqc85yYTGs7CaEkFM8SEvoRfKLKlb2d8U?=
 =?us-ascii?Q?X9lbaFd/Cbls2HbEgI2ut9zvJis4OsHy2JNGK+un9a2jFEgi5SiG7gT1PqNn?=
 =?us-ascii?Q?rTFOd3X/ZGmA1apMWjdRZgL1vJ8PIKlO3HsqS7KyElb8dGf/7Azpc2SXj8eO?=
 =?us-ascii?Q?sRgdThP+oS9I4yyPL4W0DcYP8keK4yG65CGqC/SsBCi06BEZn8uQaa6UDFxt?=
 =?us-ascii?Q?2z2lwDOKeI6Rh71HbGPOjcZCfz5nwFQ2O6DvlRzSxG/HG0/kPDAFTxvdl72j?=
 =?us-ascii?Q?GJHks2YJ7Aaas15jjtIWnyWNgBqpTWpA8GyvHBApSnMud4C9qEYrpWivIx1J?=
 =?us-ascii?Q?3XRDsMUzDt4kCvEK8gsemOJj9wpp/8c/wc+fKjMZ56MVFpPwi22XdpoJpC6W?=
 =?us-ascii?Q?ClEAn5SU1j+LF+wIFK9vKlcwlv7nlGy68lO5BBWwXtXu8E9aVPU/gznbmaM/?=
 =?us-ascii?Q?/6ycV2KJrv2qsdNwtXLNQlXNAjDUPn21qDAqdbaBBqTTu0k2XGc2hXhqkVYI?=
 =?us-ascii?Q?oBYc323SpcRuZm766BYik3f9tHRPHCV2ewFjVY7sFNWFepwHqkqfbuZPblqy?=
 =?us-ascii?Q?yxuatJe4TBjtz95qQLdtOeVGuV7znMwBf7ZC9SxC2/6lfF5jpKL0267PvZfE?=
 =?us-ascii?Q?EDZF0erGXeFOV7wJVSSHiJjOe26vrcVPCkvka0otewRnM31gi1fmrI6SljJ7?=
 =?us-ascii?Q?Iv5HsqacAVzjnq8I6tLQ/g8TOq0qneL3FI3XAHaiol5m94xMTuT815HYXGTh?=
 =?us-ascii?Q?cV/UGffBQgU0pwcnsmzM3jf1Xk71NkJlpajYGz5U6cpJUsPkGDYgEKs1xa4J?=
 =?us-ascii?Q?1WoU4adFqDxP09Ufea2u8mOyupAOtfKWOS/HbhNbWwCfsn3yjTYl/DlKD8tV?=
 =?us-ascii?Q?9PDN5QV73DBo4BzUQStnGX+2tgOqcz+XrYGNo+cHKQDflCthcTcAkG7ZwBO6?=
 =?us-ascii?Q?DVNzLkxeItWb45WVU2F0m/j9GpBnCRrHb91P+TeRDpEz20yNg2t1roMG8gdA?=
 =?us-ascii?Q?LWsQbra8Go+t+i/AZxLBEChUO4qr41J6gbvhcBOPO3JPqIW8Rm24MKZbU2Zl?=
 =?us-ascii?Q?2PZyPzgHj1l7rDImJ/FAJ9D3EciWYj3TyxHnFaqTVfJKlnziRAb62l5cy5Rd?=
 =?us-ascii?Q?wloKI7H7KArKB6hx17+D9hFdJuLefkYNeXDahT9StD50qKINjIgdcw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:32:53.3726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 364256b7-2be4-49e3-0ae6-08dd7667312e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860
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

Add support for per-queue reset on SDMA v4.4.2 when running with:
1. MEC firmware version 17 or later
2. DPM indicates SDMA reset is supported

v2: Fixed supported firmware versions  (Lijo)

Signed-off-by: Jesse.Zhang <Jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 688a720bbbbd..673ecd208c6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2373,7 +2373,9 @@ static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	case IP_VERSION(9, 5, 0):
-		/*TODO: enable the queue reset flag until fw supported */
+		if ((adev->gfx.mec_fw_version >= 0xf) && amdgpu_dpm_reset_sdma_is_supported(adev))
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

