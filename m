Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E237FC83F25
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 06:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE4910E0A8;
	Wed, 23 Jul 2025 06:41:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H/WVope3";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD16710E0A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 06:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqldsqC/rde9ztocERVVCWj+ZoHt22XokkgZYNeFzxRVEu2q/xQDuqsC6ogWf57VMSz20yujkxIp73PRZUJIcBw5ac1qPKaMIBGiF/17O+Kv9a3Iqlg2nl17Q9/VzcXp3axbvMBqxrbCjMSs1n2OVgl8wXTmw04YK+vP4TdJKy3QDsijFseGlSbIqqDitKonZOlcaD8GI00+7ALdnlhgJt4YQgKgyR0CCpkMfb1lzYPu/T3DxlWx9e2KeLP+FryQZtDhvcUYB99KNd6ogMj3f1I8wHrMVc786PkRablGmDZHXJYUlkyybdlqtgRSIUn8fmUH12FQia6PuWzkSgMs6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MuAvJxM8nYRIqqWFvB8XoGhtOR1AYRcSzKIkDqSQDc=;
 b=m5AnalLZ1zrKHESRlEFApGfxeAYvosPWKj5SBYVYVXs5hrW6k1uhyVhfZl1e348YHV8KK9RcT8N2JPM3rPaysHUQ+URa8+mddpeyKzRrW0lEtmNDKA1lmtVoD3cpONtpdFUaF/RFVnJppHlKO68aeUS76q/zOlIqiaJIF7C9ZmjVjOY4x8gsV4NfL7aUGJ73PaHleW5xU2ywmQhwwoN1VWRpawK9XRjp9W2HAXTHyiqHhhh/gspGcoBdsXSeccQy04hLzLqd7PK5QI2RVbUZXnBAmrL6foeRaIF0B1SRX6xCgBbeDMpOZDcIKasUmulLwG63V5MPoU0aU9MZkKP8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MuAvJxM8nYRIqqWFvB8XoGhtOR1AYRcSzKIkDqSQDc=;
 b=H/WVope3yvL3M73qGqsqJCIAAnQEpct46YzsYlSEMXuUqg6gjJjlh+bVxKJsdeT678AOKYmsO5Y/2Lcc/lpK9Fcw83sAmZO8Ogrf4OC8f/fFpEDXggD9usjyjUnQWG2xyKXn13G8TzbQmV77cZ7kTWkkv80xNwWA7heo0VPf2xw=
Received: from MW4PR03CA0351.namprd03.prod.outlook.com (2603:10b6:303:dc::26)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Wed, 23 Jul
 2025 06:41:05 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::96) by MW4PR03CA0351.outlook.office365.com
 (2603:10b6:303:dc::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 06:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 06:41:05 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 01:41:02 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Update IPID value for bad page threshold CPER
Date: Wed, 23 Jul 2025 14:40:40 +0800
Message-ID: <20250723064040.10231-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2801f8-656c-48f8-6d59-08ddc9b3e633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?26Zl5RtpkJEGv8zT+fhn9o0LewguuSueuwKS5Iv5GTEFY/tkNVSKpJVRknRI?=
 =?us-ascii?Q?vfrv+vCnounCFzStPEhCLTpMMGwXWoGkd/6hPBZqL9t98LDhDUjOn3XyUpC8?=
 =?us-ascii?Q?tNjER/mt44RXhXVAS9ezS6HzACeowlye0jReGleVIhBuG9vOLBFZ99SbfUmf?=
 =?us-ascii?Q?385y1/wxQ2BDe3YgiPpL09sqTr+orfe6uAXubg/SlGE5HlCBhf7wlb/fzbPL?=
 =?us-ascii?Q?twz9Q2S3mH98B4Dwp5rRC2X87shM4IwiJIDx8Dcu1lY6HhpBLSFU+ZPJy6fk?=
 =?us-ascii?Q?Rf5Pt4qDyKJ7rbyeAh/dViIyYM2Dnc9AaDFiTjloUeERva1MehV7RyNTG2yn?=
 =?us-ascii?Q?CUfWylYao8xKg3MVEa26MgKDtpIDGB6gRpBlTH11BIctB+rPqRR2b0ZwKTLf?=
 =?us-ascii?Q?pUkOQnOub2+1Vhx7Qo8yc9xZZhdsM0CJLX9fYOCLk7rCEZubCon3EjoAlqQa?=
 =?us-ascii?Q?EeJfS/bVGgimx2Fr3Rl3Z8w4vyUtv7hawS7e+g1OxkezIvS9XRmelx0Z/HSS?=
 =?us-ascii?Q?5WWiNiKUSr7nad4ef5STm55DWZUYlTXJK+4MvTBZApptAbKNXFlqy06IouVZ?=
 =?us-ascii?Q?7lG/NIowMX6WqmIeOnt6gxrFCi/jPx9F22u/unGBQhfI9Skj3DJ5rvjKDAU3?=
 =?us-ascii?Q?0EcGuAzJZVmoVZDElATMVVs+Qug9vEq8YzPxP3/yWjlcv+Ny63q3oClWZDpC?=
 =?us-ascii?Q?R9+d2CVz/Wcy4NQo05FUMvCiQ1cfyWn6M0nGR7Pkmyk1qHG3SE9KnMtXW8ky?=
 =?us-ascii?Q?lCVgpRXTiXANsGVmCKgrvPYfRohayc4zimsrtLdnerSt5Ax1Nw5tsehMH4tA?=
 =?us-ascii?Q?irOgbkTqU0CMNbgo0Y7Lv3Tt+nzLoVk+o4kHs7ytH5256RHPyVR4LjqLEjpr?=
 =?us-ascii?Q?pHdYcgz3hKr8jzRlDwDJ4zn6eGQ2N31CeyUtAgpDjTH3s1AZnb5aYsm4aP8D?=
 =?us-ascii?Q?TVFFwpzp0af2hWBjHY49VI5zyXQU8PGhS2igTfZd3kStTQm1NyEq/eSUcpQ0?=
 =?us-ascii?Q?CMEyw3Cwwsr244HhIp0x3VQCN0dQ7LB1opWyqu3aA5l8joKEnKGYK5f1xbZH?=
 =?us-ascii?Q?FGtPd4Bi1oWoxfUfkR9FwGE9cHzr+90u5/NWRBMt4lmedHeLtvPMkM3k0dNE?=
 =?us-ascii?Q?vqkytL2v0TnrxkqF28IeSLU9W7+GZDrYTHA9rwgVjtnDDyThLNb7eW82AFqc?=
 =?us-ascii?Q?9f7bxENl5PuquS/G98eQ2+GUsvO9mNd6usdbWTFibnhDm+hR7702KZi1ecul?=
 =?us-ascii?Q?HgvW9EnM/TrTSlxEQJ+7+gm68gLRTiYWhiHQtJQEy/Rr+IIF4DPIaWW/Rcqj?=
 =?us-ascii?Q?x/2+TfTJYqjqNS+ipAVsNxSSb7K+OqaJRNK1U/Qthr0p9hRmDbOLW4ZB0y40?=
 =?us-ascii?Q?g1+AVvn1s6G+pPQA88+PVkk34GwnhWfVOE6Pn4GbtwOqDva/fhefouy0hTAG?=
 =?us-ascii?Q?L3YOIdBAQV4+s2sN78HTLNbTLfq/wA+BTeJLMb4kjGMqUNkwECDMlKJ/I3GO?=
 =?us-ascii?Q?WYhtqMqfGSk+mLxC5TwHOGH/M78i2rN9Db+r?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 06:41:05.3583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2801f8-656c-48f8-6d59-08ddc9b3e633
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755
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

Update the IPID register value for bad page threshold CPER according to
the latest definition.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 15dde1f50328..d16267868adb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -206,6 +206,7 @@ int amdgpu_cper_entry_fill_bad_page_threshold_section(struct amdgpu_device *adev
 {
 	struct cper_sec_desc *section_desc;
 	struct cper_sec_nonstd_err *section;
+	uint32_t socket_id;
 
 	section_desc = (struct cper_sec_desc *)((uint8_t *)hdr + SEC_DESC_OFFSET(idx));
 	section = (struct cper_sec_nonstd_err *)((uint8_t *)hdr +
@@ -224,6 +225,9 @@ int amdgpu_cper_entry_fill_bad_page_threshold_section(struct amdgpu_device *adev
 	section->ctx.reg_arr_size = sizeof(section->ctx.reg_dump);
 
 	/* Hardcoded Reg dump for bad page threshold CPER */
+	socket_id = (adev->smuio.funcs && adev->smuio.funcs->get_socket_id) ?
+				adev->smuio.funcs->get_socket_id(adev) :
+				0;
 	section->ctx.reg_dump[CPER_ACA_REG_CTL_LO]    = 0x1;
 	section->ctx.reg_dump[CPER_ACA_REG_CTL_HI]    = 0x0;
 	section->ctx.reg_dump[CPER_ACA_REG_STATUS_LO] = 0x137;
@@ -234,8 +238,8 @@ int amdgpu_cper_entry_fill_bad_page_threshold_section(struct amdgpu_device *adev
 	section->ctx.reg_dump[CPER_ACA_REG_MISC0_HI]  = 0x0;
 	section->ctx.reg_dump[CPER_ACA_REG_CONFIG_LO] = 0x2;
 	section->ctx.reg_dump[CPER_ACA_REG_CONFIG_HI] = 0x1ff;
-	section->ctx.reg_dump[CPER_ACA_REG_IPID_LO]   = 0x0;
-	section->ctx.reg_dump[CPER_ACA_REG_IPID_HI]   = 0x96;
+	section->ctx.reg_dump[CPER_ACA_REG_IPID_LO]   = (socket_id / 4) & 0x01;
+	section->ctx.reg_dump[CPER_ACA_REG_IPID_HI]   = 0x096 | (((socket_id % 4) & 0x3) << 12);
 	section->ctx.reg_dump[CPER_ACA_REG_SYND_LO]   = 0x0;
 	section->ctx.reg_dump[CPER_ACA_REG_SYND_HI]   = 0x0;
 
-- 
2.34.1

