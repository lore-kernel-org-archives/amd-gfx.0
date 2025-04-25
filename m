Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AA4C369D7
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99B510E98F;
	Fri, 25 Apr 2025 18:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JZPT3gUW";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E94510E98D
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m23SNPUoxqnKqn/GrGBGjmAczVBFgkaQu9ONw4PutViYdEhFEW71S77pSu+lnmEqZ8ObpttkSPK3A34AD9wLTy3G1pw+7MtaZ+iuJyNt871tlR9BXv2l9wpksaTO2z4QvWSX+KQgs0a7VTRSQH1dyOV/LipKdowwNHS+AvlrQdrBBnexO2AdOslQkrCxBEiWYBKNlVMnkfuboNx7KU6CPVUTtH3Radpu+jWvShYGrtkmzNz8ROxEG+8M3nxlt2EOoyxYlPPUn8LNagOFzvkC2cGURy3aFzqZRJaGZAwiB2Q4+3ohIuZWVsA8D3AhP+Dm6Xp9gfbeG1NO9Tjjo7Lsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUrvWji1W64fBixDid9LVOjPyf/BSd9lQpA8/pix8TY=;
 b=Xsx8ieHFTIHJXaKSVvp0TR8lT8K5aEfwnXRn1AS0e7kpJhGUD9Uxbv4pkqqukYHURxlYnkyV3LZYHtNfN8wC+thgHaaOe/jsxpTnQa+ltm3XSRL3/KLsJjWCYZT62UIjpmDaW9AUjZbRXtP2C/+Q566WBhf2JCQWgFjwvwUyiyTnvwjUeGSHHhMI/3cxBBES7nP4j38wdffAd1gMAE2pHk2dCexivSVODNTt9ulDDYFq414XcZpEeMLtFKkrxM3JxozR0lDqzAvkcSFjoIzLk3RhlGu7AZfMLYLkEW7qa0XYOEB1YzMydAATXMMNnM5CDePqBfhLp8D/ZTLjy2F0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUrvWji1W64fBixDid9LVOjPyf/BSd9lQpA8/pix8TY=;
 b=JZPT3gUWGZuHw0HeKsXuUgGaoTia+HYNh5aoG++0FBPk63xIfJD0tN7HhiW5epjgUghj4DJafvkkFionAET6OpPCuZqTZWod+gKldrtu3S9CNEMW7eK98ccQy26wJCGNxmytUgfNXTZUucKDXjxyrrnmdDiqM/woNke4yjDS4y0=
Received: from DM6PR11CA0068.namprd11.prod.outlook.com (2603:10b6:5:14c::45)
 by SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 18:41:44 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::75) by DM6PR11CA0068.outlook.office365.com
 (2603:10b6:5:14c::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Fri,
 25 Apr 2025 18:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:41:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:41:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang submit
Date: Fri, 25 Apr 2025 14:41:22 -0400
Message-ID: <20250425184125.166270-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425184125.166270-1-alexander.deucher@amd.com>
References: <20250425184125.166270-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SA3PR12MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc223d8-e72b-4cbe-4940-08dd8428d384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YVQRnxhPmVIojdULMxxZZ1BOmqWoU2aUhp3rWQl0gAxFt14fiShpS2dkPP6E?=
 =?us-ascii?Q?EihVhQ1PpCi/8MMCSuIA/Sp10M5BghGMaNKLnGLaH3/CkfQGd4MVprE2/CAg?=
 =?us-ascii?Q?L6v2NJStTOytbPf+MEB/LVKEMMK4lmxRzbfeQt6ylbU0PIpgoHRxrOnAPdPa?=
 =?us-ascii?Q?pkIxzV1cSUBIb4mtFfBfnEmCqeQrAuLAyXliCnibc0mgKR1tn/tKw6JFHWVD?=
 =?us-ascii?Q?1tqvML9E+XQQSK6GZn4G9D+ufGWeruknWJG+f1aFdWNJd5yolhCRRc/Ampdi?=
 =?us-ascii?Q?y/pxbGHR5AqI6dyfnHfWUJdyAvoJ8jeKlgVIEZopKOoObuxlbX0olrosN7AW?=
 =?us-ascii?Q?x9bGwYtv4XTVxMv7fU6knhLk7mfTHu3/QrV5/Vme0tGqReyxWu9EGr6P02W4?=
 =?us-ascii?Q?eOEzDh9e1ZThjKAQKIdcxvwTDhJil91FJhUVX+hZku/5scgzLvbEFlWVFcHQ?=
 =?us-ascii?Q?IoBaziZu66Z3aezVZP4ti/E/pibGGQSI45cZk8TSTVjwtpezFDdP5mvGGw6Z?=
 =?us-ascii?Q?aCPf5437jl1D67CsmqPrGrz/8gC+jH5EaLg4KhuUFYcv6YTeXdy60+D4D2+U?=
 =?us-ascii?Q?HJ8cmWiil847CmlQoYhj4923ZkqCGOAlWrF8axdHDZONs5P5vOO46FGd/q6q?=
 =?us-ascii?Q?yEVIREhEpUGRXEHi2sV8/zSJnjR8RvCtCNmKZVBLHW9Ri/oXdQuV4NBoTTLQ?=
 =?us-ascii?Q?u3OtCkNx36pEtqbNiS38EMYWnsP/QR/DgP90dZwHoPQzRnSiPnnt97yNegt1?=
 =?us-ascii?Q?1b9WhDKS/0w12qAsDacqML15Ljar1/HhD1SjBhHzzquJxNSe4XgfAteo2WW8?=
 =?us-ascii?Q?q6Vj+TLzM/kpOdch+gf3e84hd7KQnXGV7z1ABpjUt4yNPjIBJ3tNGdOm6isp?=
 =?us-ascii?Q?bfPM1h5uEip+LSxsHlthHpq71jcC+qn9MAX3M0/aQEluh/cpq9WxqQ8sk9iC?=
 =?us-ascii?Q?4Q6SZsH8KEAw82qzZE2XIZY3wzZtYLXfKyk0/rZKWfPa69BuSCxu6trY6C6X?=
 =?us-ascii?Q?vS/6z8KnnfvUVzJqngzvgxeoRg/UDnkU1+8ltpGw4Vg00l+n7TxPJUhvvHfj?=
 =?us-ascii?Q?ELTdRan35rD+a9Ggh2XP/NcaVC/7MeaJiWgAR3/AhO+eC+1MiyGINgVLQ7xU?=
 =?us-ascii?Q?4X6wByQI8DN11fExodKCvUVHLK8pJNal/XNy8UPwnO2G+kdXhvMHEks9VPCF?=
 =?us-ascii?Q?9E7WwNOFZNoB43vdCdRe6jzB89gMSkPQzkPBm5K9etXgFx9Jsp7ZMXa0k+Y4?=
 =?us-ascii?Q?w5rwjDe9vc25g1Z8Qkv9keDiGdkfN4kJSuEiR6uk5yQODa7jw4S6zbGZgBVy?=
 =?us-ascii?Q?evRRSI25QvhfDEBZw2I7z2yfazyLuvN94eqxKSFOwYFHFmIaYETEP3VpKyez?=
 =?us-ascii?Q?miy9PCG98zpDPeHuoA4TGZKCuf1wGihU3SwsL40QB+k1IYLbdWS2vMSSnP+2?=
 =?us-ascii?Q?o6mIii78p37/plHJ/xEIhNfI58jXF0jCY5JqrJbPUiYniBh33eRpeyV/Cy5B?=
 =?us-ascii?Q?LJnyrUjN6tSpa94pJ94Jt2WiaHY2ywh8hoUR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:41:43.7761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc223d8-e72b-4cbe-4940-08dd8428d384
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7901
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

Enable a primary and secondary queue that schedule together.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index f9f2fbc0a7166..e5eb4b923f24e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -879,6 +879,33 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v12_0_set_gang_submit(struct amdgpu_mes *mes,
+				     struct mes_set_gang_submit_input *input)
+{
+	union MESAPI__SET_GANG_SUBMIT mes_gang_submit_pkt;
+	int pipe;
+
+	memset(&mes_gang_submit_pkt, 0, sizeof(mes_gang_submit_pkt));
+
+	mes_gang_submit_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_gang_submit_pkt.header.opcode = MES_SCH_API_SET_GANG_SUBMIT;
+	mes_gang_submit_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_gang_submit_pkt.set_gang_submit.gang_context_addr =
+		input->primary_gang_context_addr;
+	mes_gang_submit_pkt.set_gang_submit.slave_gang_context_addr =
+		input->secondary_gang_context_addr;
+
+	if (mes->adev->enable_uni_mes)
+		pipe = AMDGPU_MES_KIQ_PIPE;
+	else
+		pipe = AMDGPU_MES_SCHED_PIPE;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
+			&mes_gang_submit_pkt, sizeof(mes_gang_submit_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -888,6 +915,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
 	.reset_hw_queue = mes_v12_0_reset_hw_queue,
+	.set_gang_submit = mes_v12_0_set_gang_submit,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.49.0

