Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E295AE77173
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 09:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9408110E3E4;
	Fri,  6 Dec 2024 09:05:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x4OudMlP";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B49810E3E4
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 09:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxsQa5TsrLsKr++yz9fbQAwI2uYkFeadDSnPmg/0/X3x6/XR0jIRF8CjpDkj6lIF0YvoVK3pgyx4SFoCvwBd+DiOlLAA8WW0LyeahtT+mtRwVs7CxGnfb3+EeUln5q2Ii/qHVQPDbTRBqBbWXl6e6BwhhUI/2GFiLItciAj5M8SfMhPQ4aySHcD6+F8y7iM7OeHbMczu77+XzzPdvOGHN0xXbOq4eXmu8xEQndhdCC+Ukp6T97D3EKTuPnSnZnudaLfZuf7hUnLNB8U1mzbUPEcm+fX9C5fzUmyeJk1AxhSNyiLvUKsoBqP4StqaENuaUuourq88Iz5LpltzXXlvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Enpxl5FrOvatr3ZaGAUp1sALjTT+6hi6WQ4dEMCIlC8=;
 b=x/pBAWQLs0lO3s5jiCX5RM1mhexV/nHAQut3WUJs3fGmfg+NLB9bD5shQIprGSU/lPdcgizqD/AIP9WJqxZBbucFOJr+RB1IpvpTnC7TAhzNFz10BoW9+9L6Q3ELeiy6/+HH1Ow7CgP6zv9k1lD27/9HEw1wL5U+IaL4x3wxjPNMw5tGdkvTtTQRmeNUezUfJODxLmZ9ox9O/gASyJ9Ut5glt1VZnGOvk3ZuIz1Mm7gQsydrna4EntUZqjBfw6vL8blfZpszEotp8bF+4bRuvq3pvZ5+R5QicOPntysnCHIOh/XyPY+TS0z2s+5eZ8VLs2+A0dWUYicn1Vt518y3wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Enpxl5FrOvatr3ZaGAUp1sALjTT+6hi6WQ4dEMCIlC8=;
 b=x4OudMlPB9hN1WyKKgNww/VwQHMceGNcqyLV0THHPejH987TdqitStUrewEdRoxsawEWW3UIMYABqGIHYoDY6Lr/nLh9sr2paPMR2DRNOcKH1V6+iMZ6aT6eDDOui6KTKRPXhKOtOVDBj9wHDft6nChohEccguXLHxfKF9ZxhfU=
Received: from PH7P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::18)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 09:05:21 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::f2) by PH7P223CA0027.outlook.office365.com
 (2603:10b6:510:338::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Fri,
 6 Dec 2024 09:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 09:05:20 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 03:05:17 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Add psp v14_0_3 ras support
Date: Fri, 6 Dec 2024 17:04:52 +0800
Message-ID: <20241206090455.182520-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ecae11d-a053-433c-30f4-08dd15d51c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1JYDDnZ66sxyDOonKdML1oaG2PLzF76TvbK0VFXXGyN/rKaKwP8BbIJxx9cI?=
 =?us-ascii?Q?IBrX1cJm50qOP8JsYr1d4R7wTT+Y0JkUyb8PDLfk5KLwQqBCWBW5aw9NYas9?=
 =?us-ascii?Q?j2gg7zKNm1Flvg5iJ6k0f7J+NaTB1NYUHZOKvaC6qoMjm7x67O8mdXmFK2op?=
 =?us-ascii?Q?dfEKqjzzi36oQ3Y46xATnmP8ZeWGdVVvwgiosa4RoZFvETlTMdkKKZGBs2EI?=
 =?us-ascii?Q?FvEJGDWLZb6dSEKoRWidUvxIBm25jqjCObJIqcnjj+eLyZ7HJ6m8S2knISxF?=
 =?us-ascii?Q?3qi2IHzKjlJdSO2WHqc1MXjfOEi8abcNedj1cAfNko/0v42Gp02p6NUJWcUo?=
 =?us-ascii?Q?Ru5vUOVgeMy3OEUeuhNrCLVQzv1/ZlmFN2k4EUuXOns0YbJrRp47f9zsSUdP?=
 =?us-ascii?Q?AfET6ojHZFAsax/WklPR1CYGEwqP15qRDRjIGLOaOwEQ53o6fNTc7MBySyY+?=
 =?us-ascii?Q?SNf4yZ437IYeQxZ1rOyGbBu/yjSqpQTf/mH1VQViE3YELdZVwzg39IxI1E4W?=
 =?us-ascii?Q?o8RpgNLVQwAuc09BiCuifzxUMCGb8C9KMO/GawIFIaaNIA8tK47s2RDP1cHH?=
 =?us-ascii?Q?EEGPqhx2C4IUSbHIS2d8S+fW3+8EsKWrKQrDUW2b/xMD2BqZYinfPx2VBbDn?=
 =?us-ascii?Q?lYcmbTf+hoWyj6qU9xUeZJL16oBt4FPEyntwq4niCI+j/c21IUWVyr5Ca5Ns?=
 =?us-ascii?Q?GEeb10n9UB0+3B4Hyt2b1nmwZdecO+0bWDXNB/PBQ55bLkpmGV+uRbi0ZlHt?=
 =?us-ascii?Q?hvpKPW9LP+anc88YLuCzpiLGMEcqmIFPLjpjhAV4hCH//kAC/szPRT5OTlpI?=
 =?us-ascii?Q?2x2yqgTvCu1+HjckT+l0vpiUSi4ePArVTnfoQ4njassh2PAac2Ii4x3Ihhu/?=
 =?us-ascii?Q?cOuWlfnLVS7nDSR7VsBXdCHHJkYqla2jUpEuNFL9JPq5LEmrUM9kA8gXp+yO?=
 =?us-ascii?Q?gNhKHyacoT0YIC3ADKl1wIQI8mtXYhwQPAUa67JwmyU+QkH3VqqAqQl0W97c?=
 =?us-ascii?Q?S0HuTe4FqqmYsu8IRzka8bOOCIykv87RewXP1ZEClDFJt1Hkt7s/szUfm1dZ?=
 =?us-ascii?Q?8Hhxh7b2mhgQgoL7fccu47fiB2NQHBpv1ZYVgkUKoYVXgyZvPdZo+gzRD6h8?=
 =?us-ascii?Q?CP3ECMtgC0ylToEyrhPHnvFZ67tI3SLkEnWNOYuFDNCYuK5GCmi4moKzR6uH?=
 =?us-ascii?Q?t4x86v4rCgkmiLtj2iSg7A6K4dSvNlvL4n0+6MrC/HAp+BLKaye31A6uldWi?=
 =?us-ascii?Q?IgAKE9rob/LllMLAscqA1XE603nFHOodCaZifsetVio5oXEvBjTAV555D/YY?=
 =?us-ascii?Q?qzjCkS5waAsk87ln9m66kAQuwx1guNNjR5y/LOrij1fzSJaGssyChRNuXyHV?=
 =?us-ascii?Q?U1UcSOVvggaYhxD+T3fSmNBLyjA7pKXTCbv7GnRmeb/u1yGTbt5qI0uuHj6g?=
 =?us-ascii?Q?YP/SgFMh9HKn6Z7h2QPobqQzT4BFT3DL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 09:05:20.2846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecae11d-a053-433c-30f4-08dd15d51c5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427
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

Add psp v14_0_3 ras support.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9961ff6c29f668..623ae9b3880037 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3571,6 +3571,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 		case IP_VERSION(13, 0, 6):
 		case IP_VERSION(13, 0, 12):
 		case IP_VERSION(13, 0, 14):
+		case IP_VERSION(14, 0, 3):
 			return true;
 		default:
 			return false;
-- 
2.25.1

