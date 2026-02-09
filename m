Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D218EF070A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 04:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0781A10E2C8;
	Mon,  9 Feb 2026 04:57:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e1lcANxK";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D3910E29A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 04:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q21w/p5BP8cYw46hjxAR4MW+byViqbWQbVT6OZQRHXunMzA8BISuVIaVOeBSCp+V6RkNcKw2VlzjvoIWoxHv3PHRGLkLwoVsyvhje22mkUqoh/g/3ztNwm7F9T1M/8RbIauXwKKQLKj2mWygZdihHv6wJj2gy8FTnqSUHpapeef0+w0acn6EFdfwNZ2XEEKLsZ29qnlZmri2Km5n1ViBR+mKFaCS7M/HM23QLgOMRDv1pBoFOZ/X4ieTLaAehxsQuz6MnGLp+3y24bBkB5zp5nGDIVOoZx201QD0RK9F4qsRn9QxYKcAwcXdwog5pTszE71F7tUbeHLOkdYpzhDqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZnBZNXbu4Z4m+2NG9+kB2+tP2plt7/K+VfbDu5MgOw=;
 b=jyShBRnkbVEwwrEBGrGKdrZRlNvT5X8Bhiy1RKNfcf+IjAr34EYUXewHNSRXjj6XWZMLgZff9mTanWqKehh5JiLPGPXvFLc+rRXK8bYJIFhv7fTKwPpPzK+ZKVBt3uFm5GtYfCOEE7cfMtWn46QQ0n/ikvILy3+4wwk+0ShWJBx5SuQiHic4mLHyiJ9VNrM/oA6okK7nKWUbO/NY2TkNDyBgPWNk+GjgHZ1ZSKQGGMz81/3kbJ3TfatGMUOAsS7AHb/oQXTj5FRe3fEd0JJQ0IJzDQ2/YvD7ozW/OCQlt2imyglPTQemuuU10N+RH+I6hozWJS0QYE4XNlaXoHNZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZnBZNXbu4Z4m+2NG9+kB2+tP2plt7/K+VfbDu5MgOw=;
 b=e1lcANxKCqZQlTZSU6EByAPfxnz0TeLqIefsYvXoyYJS2jhWAJvDwhm6RP2URHbnHbfZjuyzlNGCFxyjTnoXcPkAGCvvU15mfSxOVgDbLbtMA9tChuz9FkSYjhsvKrdA0H+4mG3xDfaSTIXdaT0bcMbYl/Tj/oaVzzM1jRfhyIg=
Received: from CH2PR07CA0039.namprd07.prod.outlook.com (2603:10b6:610:5b::13)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 04:57:26 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::9b) by CH2PR07CA0039.outlook.office365.com
 (2603:10b6:610:5b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 04:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 04:57:25 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 8 Feb
 2026 22:57:22 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v6 09/11] drm/amdgpu: enable mode2 reset for SMU IP v15.0.0
Date: Mon, 9 Feb 2026 04:56:47 +0000
Message-ID: <20260209045649.59979-9-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
References: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bae3ff-3cb3-4b04-f913-08de6797b79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hJ36jGx5nNWocDj6sJVRiJdnuuiXVJ3jzvSa5+X93s117a6OPd1Ei8JHEJs+?=
 =?us-ascii?Q?XT/dUXmEto4qR16r9YANyJlbBtj7cRR0hBXdfXdkOHGCrfKHaVgNdqYL593K?=
 =?us-ascii?Q?QXPoyDZVisXQ06ZNZ8PN+7nphzkJDnBkfYKuXM0nuGOhwJ19TF1Ty4AoFaJy?=
 =?us-ascii?Q?UWbXKAlOhFxgcI8WUhOBanzzGWE8XVtbovS5b3NnyqMcpW5XEZbGb6yjSFcA?=
 =?us-ascii?Q?2WfikVZaJiUpRNNQSNfH46/YSMPeY0vM14587GVl0ts7UPcYLq7dpiKLXIvc?=
 =?us-ascii?Q?eDcrXw1bJFzRuHbciRT6AM3nV+FzHRzGIMgA7tdkYnx4m449wMIJMEwZ31ob?=
 =?us-ascii?Q?/A/kWJv1lDadg8yLBNvRs+xsZnNftHcmbyPpllKWGdQpyxq//B9K7t71ZuSZ?=
 =?us-ascii?Q?cAhGG7L7SyaABmYDrkLK1NmyuvoAF917TGkFTt3qSKfueBunnlX4cE1YFuRk?=
 =?us-ascii?Q?BPiRoNHLhhX5Og+tpNg246D02hb2xf1I+p0/QC9jA2HqajR7UAcpTssn0m6i?=
 =?us-ascii?Q?4lEzqKosUk6pFAokZLIfvO96C/He3difOvUx6GQu5xSPDWn7Y/DGl+euYOHl?=
 =?us-ascii?Q?P8TtkFrKdcVHky/DZ6XLceObVYxR/HRLOzfHKs7I85AhJp2TENgMlOGEDPyc?=
 =?us-ascii?Q?CYIZf9ade158C8cdSCkhIQ7FqFeTwWtW/QIfCwgzCsVXbPBKqUbWHeQKMTuV?=
 =?us-ascii?Q?tFWi7HKI7MOPaACziOLqUshQKLjSpLRtYvCBHlGtA8vrmUgNIxxaEwxEOJ0/?=
 =?us-ascii?Q?cyb77tq/NflHi5X3V+RwoKYi9SK2wa1SSAmdVYE5mXB5Rw72Bx39Xc9XfU9K?=
 =?us-ascii?Q?BO5HfHsR4n8Mi7HTAzVuf1YN1NOWi8fX4/MH5lCT664QEryKt6rOEotADR8e?=
 =?us-ascii?Q?vD8/1QnKpbvFmv0Ny1I39eA/sGGXYnqpx6elyMiwI35C7+k/cq6uDREr5YLp?=
 =?us-ascii?Q?FN9ky76uN78/LbzIVPQh+vfLagsEprUMbm5ba+0fT3XVeHtee+Y9oD2jWTNV?=
 =?us-ascii?Q?5++NdDSNms/PRF7FcCPyK7s3tXWnI3ioILFfX9l0UTCBiX+pgahDY4zqW02P?=
 =?us-ascii?Q?BCB5s0ZVOe1EWI/qU2i4DFw1ARGM+GIt/XSFmBGBjQoIe8rns9fuoIxwCIha?=
 =?us-ascii?Q?gMztHRm03r0BmY2ILWzmV4OEZEFDtFEclof/nnsL+q1MSD9JLqEBZs1keXkP?=
 =?us-ascii?Q?qw3YtvoK5oQaJOy4gMBnIrL8OXGEKMkWfhTalGoBLX7OrrCr/YQm/SqEP7jR?=
 =?us-ascii?Q?P7L0NTpPWGAqWsDFCIUnELT71frX07rlr8q5g/FKnYVjDoq14OVkiQtDT84S?=
 =?us-ascii?Q?on/WecGuYIOde7a6zrE7qUJcj/+dHYHXC3gvSNicVVE+OvgTUOrGrPlDE8S6?=
 =?us-ascii?Q?/JATc4Lm9uR3dPTv52+QQlUznzc99jyoQap/ZuOlVEE5Va1Hy+AQQPFs6PPn?=
 =?us-ascii?Q?iuiXPR1DFzdqjIFASlySZvuHJ2lZhMzdTqXNTLnSNHmc6xIsQEsjmocdL0oc?=
 =?us-ascii?Q?I3+OXU/P4CbIv2PsFaclfrc/xFyLnaM1ucsA4pQX0oFAowEK/K88RjBCbaBJ?=
 =?us-ascii?Q?KbUnSLuhhxrnGyCxQ6imFgTYBJSADQkJTQqGRW6EfknpSxbWPOnss9Pzq8To?=
 =?us-ascii?Q?NqqrLWkRwvWdnJmQtWuPC7DdEDpbJgyfn/6o/BTaEsF++meJyVh7w5RUeqM3?=
 =?us-ascii?Q?qSpb2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7HCS4j86WWDOczEQ6/2XB99/g6pbvGN0TBPn7U4u6ueZP1u7XbQXwxLP5cy7QLmwBDtpL5HxlqBW0PmvgoncOc0+e0zGOIZwHDfcieMcdoJrDFs3WVGfwtglNDyWUjgaL0rgFOUxWydQkqSUSSzTaMs6KSQ/BR8kH7WidQ0+vY2n3BFXbZ9T4RW205hPsORX41HoK5fUYGOCTdY0NmHKei52ccchfPUT2k2If1srquBM3G2155gdr6zzeT5fS33CVTLdmQMAC6HX4RMi/3UpMl3zURdPwWxuJfh/oGsFjN9biRJ4uQmFNHCWujzfa5JJx5C7VCM37FcmsE/9S6D5Xfp4Lmmfhz3oGPsXeWG6+495OK2ZRBtTuXSIOeSF67h460gd1AfoFdOj4zb6a3d8r23t5N4qeSwdR7ZuUJBk1EdPHnZy4iS0nnneH9s6i/Di
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 04:57:25.0886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bae3ff-3cb3-4b04-f913-08de6797b79c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
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

Set the default reset method to mode2 for SMU 15.0.0.

Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index d9cc649d81ad..79d132fc8ca9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -422,6 +422,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 1):
 	case IP_VERSION(14, 0, 4):
 	case IP_VERSION(14, 0, 5):
+	case IP_VERSION(15, 0, 0):
 		return AMD_RESET_METHOD_MODE2;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
-- 
2.43.0

