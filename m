Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D89DC3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 07:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE80C10E03B;
	Thu, 15 Aug 2024 07:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ryUwYI7k";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAACF10E03B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 07:06:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rr8yi4H84uzOmlXqcAZ0DPfzF7ztoS3j9EwifOJhUAk0+WD3dUaZRJ9gGMM8O5oo5OkhUGjhcgXytOlbOyw/i1pM3gYPPwZorgMjlhZu4N8b4pnu+3MZwCi+wr9eRXnLoRMVnEQkGSHX0NM3FgYwfMpmTBQqwVjYw+Lk6ebIEhj5KvDKFp8fsDL1EtjQYf1cy+4wIe7smBmVpQ8aBhQ7lc5L/mfrWa1bV7AJ8nN87Lwomcf53AjoEpi92Vz3PUX3ms9TkJPN2z4ycs1SuXKoJDPPXIx93REn51YEgWs8QArLD8Mr2+wuezLGpRkYLoxc0vSGJ6dqqmKA2Zh9aUHmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/+4/doODTIXqamoDc0rWvX8JcczkSYGllgIIyA1F3c=;
 b=VatTp3ocfWJa21aWCg6dLmwlb0+hQeKZfakH9ss9N7CoSZtANdwkYJi0TWndGS/zwLZ90GSRCZZmfILjTIEgjsfB3bDWK40H7g8gQI7p2wkyiSZCp4h2lIkg/5YU5sis2sc1vofWVss1WjNabHJmrpmwsdNIjQsxB9lxlnU23Si6nQfYRqOWMi0aGfLBy0VE8ksOKgtjZtQmvOtFY/5Uv6qvoRsfOzyolUByeg/lAjYQuUqJ2ZZF8KwHEZ8agfVGMhTCV/ZydUpgLJ2UPNZ96Oe/wtNJejaew2BsV5ZH7ObBNYFSIC69i/9tTVYuQQUfDqyybS+gfuPxC1brvQIwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/+4/doODTIXqamoDc0rWvX8JcczkSYGllgIIyA1F3c=;
 b=ryUwYI7kD/mu/3ZpiNFcpcN/bjhvKoC+kGhwJkHX8zac9wYZiPpR08T7RLJLVeB+zZN3hxKFOQR6a7z5iwsSklzLLLGAdW8nLm1lM7x4AU6byQrf4qaNlKzSCZNUoKpQYk+HHM7EglQHPU5JLZjJ2yWZLexX864WTdI9jcYgmVw=
Received: from BN9PR03CA0350.namprd03.prod.outlook.com (2603:10b6:408:f6::25)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 15 Aug
 2024 07:06:38 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::68) by BN9PR03CA0350.outlook.office365.com
 (2603:10b6:408:f6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 07:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 07:06:37 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 02:06:36 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Validate TA binary size
Date: Thu, 15 Aug 2024 15:06:15 +0800
Message-ID: <20240815070615.1204540-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: dae03734-5186-4b32-ef94-08dcbcf8ce4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/lvGGUDbf/87EeQNlrl5vNSDBhO/bKckuXR9+EluHCjGtQBJu4jqL6E7VnEi?=
 =?us-ascii?Q?JZlc59JsUD+3NnIyzgmRIark1DpMapPy7y/FhvGwDQXy31gZksxcXoZkIoB2?=
 =?us-ascii?Q?Its3C0DLa6WTxXj19zWR+ekHnZ8H+6OEH/QbNJaSZt9dmL2iFxkEQCT68/zN?=
 =?us-ascii?Q?gsoVxkSZMmeGW4lLrqZF4fNLFyVCBVyVuILDpnQ/q6nzcvsfQgZihb/3JhLl?=
 =?us-ascii?Q?wRK0LO3ipOXfnYvd52rSMfbeQ//YRhhWTa8ZYxwr7teNsysjVVQJy6C6y8R7?=
 =?us-ascii?Q?4cfElYX9F0Jo5m8CkBUmpa4IOta+Gsr6vFM4mzHBS9/lfZ+duNKIpcBXyBis?=
 =?us-ascii?Q?5nR0sixNiyICDeoc/q0E7hf2jvB6dXCcJKzfsBOWSpN/a0I2G6FFF14Sic+f?=
 =?us-ascii?Q?VsB8hgeZH8bxIxZ3pWgDCX/X5mO3U9RVt/dTryZaPPWBwG0Kg/7qDRi3G9ZU?=
 =?us-ascii?Q?MSYSVyDs7ezA0muSE+qwwF6aALe7ut+5ufpKJlp6f9RLrjIETWlG1gcR5FHE?=
 =?us-ascii?Q?P9mTm1U8Xs1X68OqrhlqL8oczhq7qUmLnSVy+ea2bN2p7Y0cVya6bdsknOCD?=
 =?us-ascii?Q?hb61E3qlMBqIug7wcqt8RIpnIqJDqS58fWD2suaQsKEtlPhkhIK2pK3QgIlg?=
 =?us-ascii?Q?pRIXzMPJ/RKX4QjGykX96igfUl5nwAJbWEMexg7D5Jk8oj+DDRT5i490LprQ?=
 =?us-ascii?Q?lAGX3H+i5SyyGdL7obIqAtplR4trbyh+IZJ7WkTtbhxZiHN9sLRykgWqYbCR?=
 =?us-ascii?Q?vwCEGxlL/EKNZSGZUCWr+LjrQWty5Ft1qI7V2pBxuv0PqC08JExhYsLjj+VT?=
 =?us-ascii?Q?IFkXni0zdT+rqRx7/ejCLUqpyOzbN003cQH+lfVKXj9S4q8cbMzCswMZngtB?=
 =?us-ascii?Q?gInLw/pF6FrMiKuOWWqb05GArEQOlc1CVgUkuILCugFFOFUIH0PJGhQQNEVb?=
 =?us-ascii?Q?whwoz/I0BQurkyuyjO/mPe91oviDPm4OJLvZ3qoERW84qCKwbVW4P51jIbIl?=
 =?us-ascii?Q?Lbz1LKtOzpShriFBhm7hJITjShc63cRF4CrqTc0p2a1Goui0TmGSJNEY8Uya?=
 =?us-ascii?Q?uitX1GVwiqgebd719GGJl5y6PDhKp/0YtAt6EI8ncncx7qsITUeOSVtMKLx7?=
 =?us-ascii?Q?uAms54sfyyOCFMhsNnuWThS+JGpGyHYiIw+1XUT8PU5KmRwOsVY8ZroD4b3R?=
 =?us-ascii?Q?GUYJ1XVDMsrVsmYCVMRTzwXbtRqjDbK88JpOILMQTFaNJIrAC6BiErC6gsN7?=
 =?us-ascii?Q?02lzRNafekClxPOjCVC4S1bUEcWy5hCpPdafOZaKJj4pwzYqfbbPvzre8GWV?=
 =?us-ascii?Q?DK1m6HKYpsCve8iP0Mc1CYwvhNgd07Q5OEToAFTor5RQODpaTLoiwfPMO18t?=
 =?us-ascii?Q?DYkInn8DhCZjKNkWCzYT5mKUckakhajYOnXgpsXtg1nMbuKZCWAh2TH5+UvP?=
 =?us-ascii?Q?fmNzRY4XGccvIsW3Fc0Y9I+PiYczVamF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 07:06:37.8399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dae03734-5186-4b32-ef94-08dcbcf8ce4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728
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

Add TA binary size validation to avoid OOB write.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 0c856005df6b95..38face981c3e38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -166,6 +166,9 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
 	if (ret)
 		return -EFAULT;
 
+	if (ta_bin_len > PSP_1_MEG)
+		return -EINVAL;
+
 	copy_pos += sizeof(uint32_t);
 
 	ta_bin = kzalloc(ta_bin_len, GFP_KERNEL);
-- 
2.25.1

