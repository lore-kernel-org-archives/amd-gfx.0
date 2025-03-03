Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AC3C282C5
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 09:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CEAD10E3A0;
	Mon,  3 Mar 2025 09:34:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lZgXRn4x";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B133010E3A0
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 09:34:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2GCDq2AdIAfAAOMJqwY2nvWlmbBZkq5Ri8rqkpfFyWOjVXKJFR12f+XwPFwIhR8ncJBYS37R5oJz1rWFzqP8C1BmsUQLAOX+eCjdKix9lWw2yt8wiBxS2fYAhCsloHgtXKpWJfB+8HTUeWbqZ8ZGHU8eTiGdZw4QurhoC+PE3mCAJ0AeCEuykRs3d47GBHtiJrFMVfwrj1ZZv4GjnFxTsb6nFZPOf89ebS+niQOJiGSBjxmi7kqjw3w2+4liqlr6uFISU/adA6Ohc6C6suVwcC0F8qJLa+ReQ4r9Pi0ncVDXEYqt9tiVIHc4Y6E8S36NPd3J77GNJYwDP7XUt6qhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q21j4/JjQWaaZWQ8K6eUpkJgRLYPk4fJSDYWJEKASdI=;
 b=IueRx461NX23MeWOnIEpFsGFtTZGi73iXM72/WpKiD9E7QhhVAr4yg8ngpEK4hu1lTdRHsGd//pgcFvUuxqFiVvRAcYJQ4OecPiyWMhSJGwbXACCA6Jr2Qx87X23gchPPkbUlFdeIDN2zFyj9ZIAGx82x7YXF/0BVbOeqeBwxu5SF+jkA6ToeUWXkh+9alwmMtDUaihoMvTNLc9+9J0aQHpNqc9tA52ys5UWU+dtW49vlwrb1zXZlsKI/qk9l3912ptC4OGme+HHxXMhBPtKyMxKpRYPcbwDOgQRly3mCkmXhHNq6tUQg7QEmKi552u4U81+u6A0XNmOmsQFdgo3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q21j4/JjQWaaZWQ8K6eUpkJgRLYPk4fJSDYWJEKASdI=;
 b=lZgXRn4xv6KbuQuDhO9Zm1P3/x+RTAmLU5rV1b1B+k1JTmwaYpCuTzXgjVNZmJPBSzDVfmUs9zWCWSWVknpW8kmCj4r5RWs5NBqcn0BCSl4WXyfKfaerXMvIheWVg72hA6SKF9zS+V7F1+mM4IW57lgd26wnl4mS99RrNv+hrVU=
Received: from DS7PR05CA0064.namprd05.prod.outlook.com (2603:10b6:8:57::26) by
 PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 3 Mar
 2025 09:34:53 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::63) by DS7PR05CA0064.outlook.office365.com
 (2603:10b6:8:57::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.14 via Frontend Transport; Mon,
 3 Mar 2025 09:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 09:34:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 03:34:51 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 03:34:51 -0600
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 3 Mar 2025 03:34:50 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu: Fix missing drain retry fault the last entry
Date: Mon, 3 Mar 2025 17:34:48 +0800
Message-ID: <20250303093448.3190674-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b065561-c876-4e52-ea9d-08dd5a36a660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zCe0jOaplwaZ6fzW4+qTbzfqPAU8Qn/GuFvHhsc17UJAi7ibGLtSC8HrdmE3?=
 =?us-ascii?Q?gUulllREzsxL22IEK4aYhwSRoWxEir3ug8vppAimFUCpkftUUhV8sFHEXAvO?=
 =?us-ascii?Q?NYq6mGJbAVEb9u3rNhl+qUSmCfyNWLptN1W3tBuSBsqe09ZscqCb6u+oVeU6?=
 =?us-ascii?Q?K0gj2YGYVQAdpKXSRu/ivQE9dFWTrbitG11lmHm2uxd7Yi23G4aAhasd76N2?=
 =?us-ascii?Q?aztmqoGo4aislQcVC1ZEhOgeFVsmcLHXnBfd8+hUbGny8FSxwjjtJTDpd13W?=
 =?us-ascii?Q?Hbt/TE7WECFGx9mBShiUI7slzr0mCLQptJhmRGh2GrQAP8Bt3fsWf0UucOcv?=
 =?us-ascii?Q?ZeCkCf0uT/MMvy0+Y+VlYf//qp7xNpy49N70rQ2SJPkqg3cNJto1+mXqr4/t?=
 =?us-ascii?Q?pxTZwQtbOpMkSIasVfRjfEobccpNF4FZaaFYnpTKvcMBaFcBmpMGrTgt7ciC?=
 =?us-ascii?Q?JwSbARGn2JS1QXsAnNFrf6ARAQGnVdUUqwhyJUAVEKhMF71a/qdU2j9Rd/EL?=
 =?us-ascii?Q?dnoonOGwRPVBkMBxFnBHnHl6TMXIRXm2Kz4EwWuWIS+QtxcHqtuc/SeFXb5+?=
 =?us-ascii?Q?2JpQco/hIFz4qA0stLvy66Kb9kMtT96B4YFQku5i3JFyG9UtcaQsz/OIfhtl?=
 =?us-ascii?Q?ILyQEaKHG+VjF39hhQxn/gypLHteG5P4yMBh1o0ofQKwM8F9NG+Uq/OC4WiB?=
 =?us-ascii?Q?FK+3Vu1mE+im3WOctNdFLegTtzOFEHWFGMazCJ83hBbzr+ZocVR2Vt4BY3KU?=
 =?us-ascii?Q?vKsOg7j3BqE/b4CNN+qICod+gKdIF3hrHgcKS0w0k0QwvV3lf0CKPYsnM9C0?=
 =?us-ascii?Q?pSP1QFpfHQd2KForzSYG+HrVtPlFJWevAzKx+6RKY/BMR8PFyiNWOtG9pXM8?=
 =?us-ascii?Q?wWcdHcZdvw8ZBeCfp0qrNyHMZFL2ilrbj1NG4mIVBF7L5sVgN7MTpkcc9Tn4?=
 =?us-ascii?Q?HwbjyTjTx9BwXMS40u3TszZg+f86nmCeC3vumWnJvb3+GKuxrH1bVwtL3ABc?=
 =?us-ascii?Q?SODJ9chgHQ0SZk5H2Di9IIV/6tKflOx7IncgE8oOdDRXlrpqVYGELrEnHM5r?=
 =?us-ascii?Q?7QZPBK6MBJjUv129bXjYlYzuGFz1nAJiNbB7C+ZtuXY4S3Mavi9Mnr2Fapo0?=
 =?us-ascii?Q?zXZXL+2dipVioFfb77PXutEVSFvAM2guHLV8AE1PbVvS5c/mRp99oepiLzW3?=
 =?us-ascii?Q?5ndF4QWDvE2eb1CGm1Nd5OZbEENP2QvirqtBVGOI88h9uurX4CvqMF81JPBi?=
 =?us-ascii?Q?YovdE2bYPIiyu3H0oobzABln96ypKEkn35210p9ZJWh+bkqzT2MYU+Ga2FFl?=
 =?us-ascii?Q?T3EPTdi2goASROu9GWPqS1aFuYXwr5FMQWJ+gc6gu8rnNa64ITVGpE3ZQJ3a?=
 =?us-ascii?Q?GwZoo1g8knaQV+GsdSgC5PcY0Vkpdq9enDzh00G1dmk9PVumzUQNraGBSUSy?=
 =?us-ascii?Q?UEtIXDiJRzP/z6mgz8RGXCu5o+7WC0IKnGjmLphSKI59T4KlPs7nTQxy8EOS?=
 =?us-ascii?Q?cN8zmpRpokOMJnQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:34:52.1644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b065561-c876-4e52-ea9d-08dd5a36a660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774
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

For equal case, it also need to be dropped.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 7d4395a5d8ac..73b8bcb54734 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -76,7 +76,7 @@ struct amdgpu_ih_ring {
 
 /* return true if time stamp t2 is after t1 with 48bit wrap around */
 #define amdgpu_ih_ts_after(t1, t2) \
-		(((int64_t)((t2) << 16) - (int64_t)((t1) << 16)) > 0LL)
+		(((int64_t)((t2) << 16) - (int64_t)((t1) << 16)) >= 0LL)
 
 /* provided by the ih block */
 struct amdgpu_ih_funcs {
-- 
2.34.1

