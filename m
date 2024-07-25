Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110C0C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E76210E8A5;
	Thu, 25 Jul 2024 18:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bSx4EbAE";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D3D810E8A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQP1kEftgGEVT90bbB+T9yPrB3Ntlf6jqMKZVNGWFn+/ySvMMOcKEt4uTE9sHv4gmldxhsqn1T26tjdVb8DmGs3E0IuAC1iQc+FO3/FV2PKcmnTkZUTdxysdRaP768T8Uem5STYjgUs1bO9JNkIMoZkWdNbTwKb5rGi42JCIqqBuM2S6nrBMzuBuU8h4j/HO3t1RggtHLHe0FxHF2JIVostqd8wIJDCJVNH9W7Qt+Ty08B2/U53n9UlcSajpekI2E49iRVQ0nawVRF0ca4bjSQr0N0T+C5J4m8Rn6QxnPO4dD1tXHXYgE2TlKpntcPiuKNjStBn92ll//LH1ZsErQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UV0Cpj+sw1Pl5deCVjTaP1SkcwQkUwQjlqD5mhJ3/ck=;
 b=jxpBEI7N8bSVrNdbYShH09VjuoVYKrInWrjNZG644rHFdZPRJkXchX0CCQWom/Nsl+IWGl3kFeNEtY2X2wM2OZMtZK9prWnVMVaDTmVRzV3oucjcO3ml274nsUunv3ZqnyfK9vT2UosI1QEjBYbHTHW0ks5B/qHUxOz0B2xIHEIigqo1iIX9c62YvbIe3X1yawcpiesVNANLKs5nghUnmK3Ye4pVl61mcv2CyC4q4u8eHXBg0evAPmIrGDZQOO/3gddy2uWnAqPGFmr9a0Zqm0dBcFB1o1x120PjcCdl5vngIuPx9R4tYnoF8qlyucZC2DCeKUIDiQKBEY/6SOfc8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV0Cpj+sw1Pl5deCVjTaP1SkcwQkUwQjlqD5mhJ3/ck=;
 b=bSx4EbAEBXjZ267hKr1RXVLwh2iByr93381fFN8m9ufSh16HIS9geM1kbPsUrmRwL3DzYW8EuetegmuA44vPwrsz9lN5qiYrGqwOKf3fHGgJ3SM1IYyqq0pL1/yXYVgAMjg8UM4oyIIEx3iE6neXDobC8VoqOJgfzLEY7Agxqac=
Received: from CH2PR10CA0008.namprd10.prod.outlook.com (2603:10b6:610:4c::18)
 by DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 18:03:57 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::55) by CH2PR10CA0008.outlook.office365.com
 (2603:10b6:610:4c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 18:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:03:57 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:03:54 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>, Chris Park <chris.park@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 12/39] drm/amd/display: sync dmub output event type.
Date: Thu, 25 Jul 2024 12:00:56 -0600
Message-ID: <20240725180309.105968-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: f21b1e0d-eff6-4d2b-ee74-08dcacd4276c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FByPKh8k3Q8L44gsHxnZ3wWU00a8skA71gns4YI7mAtqFiJ2U3But76xKVu3?=
 =?us-ascii?Q?xzQc75PJ5AHhgnitCFHncAxwqmn/WAwhISuGs+JQycRUVHFCZEeQYWCuUkPM?=
 =?us-ascii?Q?Q3OmSJPxclIt47JUnEYP6+KZPTaSWZRPN2qf3buYeckfeLWXIJ+RpU9G8+uY?=
 =?us-ascii?Q?e3r5TrgsrdruajN3QdHvlKBb7a7YcPce/WHGBfgKmPLVxCGMMek+JDURxZGe?=
 =?us-ascii?Q?mhlMbi9M29nQ/M2epYGX/cSYQLH+1Ld84kLX5ry88CofRbnqJD7AlandKcA7?=
 =?us-ascii?Q?C4VE3G9yAOnr6CC3lpxqwzyXaTve017BPmygJntGxu0ZeSsmZGIwcZiQNddZ?=
 =?us-ascii?Q?iXwJthLxJ9nmM0UXc2eMkvtMnnyYbTXH7mVUqjQFpKTkJdw2UJi+ojEml+sG?=
 =?us-ascii?Q?1Lw8W39o1E/O40g1MW6lP5g2tD2MRjGGcGfERKEjFwsEYk6br+tRlZnWJDX2?=
 =?us-ascii?Q?ALgunqxLXQEvc5ggNzjEG/oCMEO+gtXDGd1Lhvtb7em+XuwpGwpU1liUSaHJ?=
 =?us-ascii?Q?FbPfgs+nDvuLpYNX0o12CF7DrJx7E+gJYYQz9ihgw6aHDlGBOfOQqHnhGkNf?=
 =?us-ascii?Q?YoMPzBstqxQgRmNXroWthyW2270psHZfVvxghG6dKitsg/oUfJpg0cLqF1Hf?=
 =?us-ascii?Q?JoV/SZheqs7MwM21Ai/Sa4gEL9NU3bv8eMG5CFra7x369QGChKpyzdw7L4Ci?=
 =?us-ascii?Q?/YIcXNpgEB151tIubv7J+0RW1Psg65ZZbgTjKjAaAAKvk5DxFuS44woRAN+g?=
 =?us-ascii?Q?QxJlw0i0LsZqoONJXrh818o3c7XfZ5aEgkIE2jo5QhWMyo8KSOId62IbzwJO?=
 =?us-ascii?Q?qMp4CnZfHpc8Vi0c1SBdvPqKVn5nRn9DXrUGut9zYMJ058XogV57TOjxtIBd?=
 =?us-ascii?Q?JKiq98LxsEGA7dNZQnaFkR19d0AERqG8H4DD91Nb6fcUgmW8J/UoGP/S4U5J?=
 =?us-ascii?Q?aHKcZ0OfbLh6e7U0xGugLhiEM0wQqPM66zF0jFvIQL5ZF2ZD4mOJj4PGfdnS?=
 =?us-ascii?Q?2/cShiJjiXs+I1fR0i3mI2yKkHAP7YoGbEukD7jINjW8JeJNjkzP5IDWy95O?=
 =?us-ascii?Q?u/XO2WqetTS8jEoVZ6OB8aX/jsup2idOCSPNkVwIqZijMvBwUUwgjKed8DzB?=
 =?us-ascii?Q?dvENxqenvyfbzbGe5XuugD/DhUSCcltRctIgwaXvKm8PrHqwN+z3WDdCr9HI?=
 =?us-ascii?Q?p6TS6CY0Jnjm2YFIlq0/iBPw4c6pEPQV+XiB9ZpvxOAbA56ihYo5BQ9zXQ2L?=
 =?us-ascii?Q?SEv/X69GQdaMUmbcNqMjnFOf7P/XFMYkE5rJOBjCRR6zVJd6bgGuGbitGXlW?=
 =?us-ascii?Q?mIxs7er63XM0ZiXuyd/CbBxaE1qla0wLS812Fw51p22q8VJrFOKGzYbZleEZ?=
 =?us-ascii?Q?+LN8KiU665rTRXW+c8k2r3faqpf1pfeid6okYDWAqDEIBSqHmX7t20IWo7WE?=
 =?us-ascii?Q?/AX2dNwk+xl39H2R7ijnIRnZJ91gqIEv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:03:57.2231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f21b1e0d-eff6-4d2b-ee74-08dcacd4276c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
dmubfw added a new event type, update amdgpu to avoid "notify type 6
invalid"

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 54e665227e8b..f2d5a180f293 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -877,6 +877,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 		"HPD_IRQ",
 		"SET_CONFIGC_REPLY",
 		"DPIA_NOTIFICATION",
+		"HPD_SENSE_NOTIFY",
 	};
 
 	do {
-- 
2.43.0

