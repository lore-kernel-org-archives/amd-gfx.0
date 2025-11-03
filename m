Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BDDCCFA03
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 22:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 156F710E4AE;
	Mon,  3 Nov 2025 22:21:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FMog/o1u";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDEF810E4AE
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 22:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUqFKvU1FB3KwrpEqUFnK354IqyBk9LrWw0Zei0XFbA6ZHUKASctOgvPFUB7u7U/0aE79Q7HD3G1ZvhSaYoXO5Y4uC14IJoErZgOpHnLsBvko3DUFmaTNxY1G3nVXedw3DSlbkmDE05Srra4Yh9KYesXg00lpgZ+g+fkZaBp9KuBSZTBYnMyyn3FdZG3G4zsHzzXsDjVyjENKe7FbAVwv8TFjuVaz+TisQK2DFJQ7ydKnnt6Lfk9NqpPpjkwdOKA9T7UOxap7jeA8RBrn2FqAim7KhtC7zbyHE46qfioRiUguTf4sFBAmRTSvoadAGM3G7suhLchIRp82Yms8/feRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXIp/ABgfO/TOkDFJhFle2Tnh1LIRVjfZ7wJAXFQWo0=;
 b=GQ4oIP9Fav2TDi1zBfn15d20ggm703ShZbLYas2rSVGBH8FzMOck93nKkSgB3zoUd0s2rst29gLYDVXjqwQnFPhFopoXA6gYSOmKk9wg2p7vsoQvbfM6u2RPHOsneUkd/sxo1wSzq9yOkobdMbTHyhmk8WszSAuPdVrrCyMyUW4H6Y7L0g27Dp7XIjljzd5TSpojcmGvlPaW1v3Uu66wcoyeIngcpAvj0c5qmCs0w1BknSOLlrASL6423oxwniIc8lvN4wtqEbJlCUgIWR68mPXaQjfQ6w5X9z6qWGp3yybdKvm3+L28QjuVV557VSBXOusVr1/lXdAR42R0UGvuxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXIp/ABgfO/TOkDFJhFle2Tnh1LIRVjfZ7wJAXFQWo0=;
 b=FMog/o1uph1uyHceLmrDV25I6DeCcs0HT2regcH/Qt0ypuUSh8KpFtIRlhld2Vgw3eYf27Gv6aA7k33ILqmM6LuFLnTvrl0hPPvVMW9SjyXjv69dfEDsqe7WxcozEfpB7ZtuV7yp2wXujOiNHWNSIxmNhptdazxoQA2tZiXRqjU=
Received: from BN9PR03CA0405.namprd03.prod.outlook.com (2603:10b6:408:111::20)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 22:21:43 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::35) by BN9PR03CA0405.outlook.office365.com
 (2603:10b6:408:111::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 22:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 22:21:43 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 3 Nov 2025 14:21:42 -0800
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH v3] drm/amdkfd: Fix GPU mappings for APU after prefetch
Date: Mon, 3 Nov 2025 17:21:27 -0500
Message-ID: <20251103222127.3095970-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 286698b5-36d7-4532-c2a1-08de1b275e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I1u6AhiV/punbbOqylFha8ICLGxLjufSetq46kEecrLgoMq0yW15PronojKz?=
 =?us-ascii?Q?wtOshCrwCf5DuLwCT0RI11dvxYVT1euM0dGNI6TZ3L/NfLdlkuqH0+6RL8Ie?=
 =?us-ascii?Q?NltOtjjEG0CiOGCpfg2lUADlBIh4H0PAmVN8mRfqyMShrK0SIWjNdV3V1W8/?=
 =?us-ascii?Q?aHnXHyDBeUmdFFlE1AxvlDgSCg2pq2w9vcjpy/c6KrgMxxa7cbeE1O0pyelL?=
 =?us-ascii?Q?BTdABmJLSWftirUrgSHkcwV1Dg1IXK9R+d2AQTyNeB1VyoTYMWP2L8oOAjoI?=
 =?us-ascii?Q?LOhVH1QRGx/UutWSjHl+P4qD5k/Q+MdHNDGWhWb3Jwkwq6Kh61+N34WvHEU2?=
 =?us-ascii?Q?DUPyZn07bnJ5nb5WjMmczGT9VVf4HNoktgFfRIVsSjqc9ir4W60xc3TWEscG?=
 =?us-ascii?Q?qiOwsUxP4iHfyNJPy3qNBWdO3+X8vPo3EvY3n2JoxxkIGdUlaRjCuUirjH2G?=
 =?us-ascii?Q?u+LEYeMiycTEASJ01HNX01VqnqCPQfq+q1zhUlIDAaKQglpfulAEljX3k4sW?=
 =?us-ascii?Q?1etaGnFP8HAPvffs9jilMiHb2IpHCct8jaz27Xw0OKlelxMZtVLmQefS+spo?=
 =?us-ascii?Q?f+f5R4Vxw5HlURKZB4V4Dv+q+tTfOAKZlzejA+t/OPUHnA/GzX1u5+ud12dk?=
 =?us-ascii?Q?9f8LIhcrfLFBq6fGO5n7nHfNy8ziYTFBvigpzFR+9Bt1Xe326nN7Sd6RoXJj?=
 =?us-ascii?Q?Ri2Rh8i/xwp9nYhFgne0N2dbc5fDFS8Iq5k8NoldrDVJIPM42Jz05LfGZWe5?=
 =?us-ascii?Q?MPecATvWcVbG+YZ9mL7IxYQlmHy3KH17MpBTODr9CJc86QLXqdNWUyrLqaIW?=
 =?us-ascii?Q?DxouXPIKLFl7PVfz7q9/HQpzRz3g/hK/pC+DpAvOKYg79U4LZTEbb/gwKeBC?=
 =?us-ascii?Q?zNSUJvcl+ZaWq9KPKT268KNRKNX3OYXPJSuvRg5yFOyrLWfhPmTavnY5qD1i?=
 =?us-ascii?Q?kVLtZH4lNqzGARt91AB1KgX4IunFiO7KGIXveuhg7Hw7le3UWH+EfNrr+ANH?=
 =?us-ascii?Q?RnouKocsQPQGmYWSnnWrS+oX8rJp8a1jGBWZDT4qa1FahrqVjsZ9EWNBz0xd?=
 =?us-ascii?Q?ScrXeAluZUrXyYHKoA72/WBMkf1Lup8adCeu3ibM/419dWvZtVjgwQqlmToz?=
 =?us-ascii?Q?4svetrdmy9i+4umVQa+AeUiGWKWlmFvkiBE6nxnijedSjNTp0s1zx2rhFjbQ?=
 =?us-ascii?Q?dH1e6nvME1SPuVisHGbsurud8FcT/pVHy2BNhKV+raZePK8ZeAQ6S8cOWCQC?=
 =?us-ascii?Q?ug3ktSBgnma1dT54fUTWbi4ACwTPLEn3kgoR32SY8kHfMDG6hWFV7ysZARY2?=
 =?us-ascii?Q?bnAF3Sou1u+WSxjrtfub/h9Dm9D6HB88ilb5eQ3i1xGxq6O8tvQukZtJw2Kz?=
 =?us-ascii?Q?FC5f4iXwiHR0571eR0vExE5A2/cioVm4vd1ZcAKQa/HcmmXhiMK2xVUnx91J?=
 =?us-ascii?Q?C1pZGfjrG60oPP6UGVXxOjqmIY1hJpzXbbQRSQUhPdIwSQaLP1FDg0Sdb28G?=
 =?us-ascii?Q?orntVwm4w/Bdr6og08UIj/woJcw3nNSzQreQdTyw56kwdySRo4tue01aR4gt?=
 =?us-ascii?Q?XwBUCQ2h3DwGp0aMmBM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 22:21:43.4224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 286698b5-36d7-4532-c2a1-08de1b275e66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
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

Fix the following corner case:-
 Consider a 2M huge page SVM allocation, followed by prefetch call for
the first 4K page. The whole range is initially mapped with single PTE.
After the prefetch, this range gets split to first page + rest of the
pages. Currently, the first page mapping is not updated on MI300A (APU)
since page hasn't migrated. However, after range split PTE mapping it not
valid.

Fix this by forcing page table update for the whole range when prefetch
is called.  Calling prefetch on APU doesn't improve performance. If all
it deteriotes. However, functionality has to be supported.

v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with carveout
VRAM

v3: Simplify by setting the flag for all ASICs as it doesn't affect dGPU

Suggested-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Philip Yang<Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c30dfb8ec236..26eac89c90a8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -768,6 +768,9 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 	int gpuidx;
 
 	for (i = 0; i < nattr; i++) {
+		if (!p->xnack_enabled)
+			*update_mapping = true;
+
 		switch (attrs[i].type) {
 		case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
 			prange->preferred_loc = attrs[i].value;
@@ -778,8 +781,6 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 		case KFD_IOCTL_SVM_ATTR_ACCESS:
 		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
 		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
-			if (!p->xnack_enabled)
-				*update_mapping = true;
 
 			gpuidx = kfd_process_gpuidx_from_gpuid(p,
 							       attrs[i].value);
-- 
2.34.1

