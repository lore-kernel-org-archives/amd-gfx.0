Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E707C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 16:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08FA910E5AC;
	Mon, 10 Feb 2025 16:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rwniadYy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 711F610E5AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 16:24:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQu6ucjH7dg8JlrZ2WcuZiLjwXuKaEi3dETS/bEjMaUMP7ONTLX4Dd8BztzzNSsDMd7ci0btc/6hBUh4qGhgmSw19hzfiLD15wVMJ4PsvOA+KnmBI3vRqZRxr1uqnKC6lXvg86WwTRfPBlXiRT2g/aOLvEGozLFn+lbOoGTnRCRuLPziKy55mv7EdwjGZTQuKNomvzlzBAsIld922OWHqdHxBMWIUexaKn/PpYSWU/RR01XSUdijHf0UPxQrxqqxU9PRskVmKlBD1l7AYqzyG9agaRx6kaa1T7ULtjrwIKLemKMQFPpD/x79FS0I8NTHahQvhHW0BsSfS68rCJ1DRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOmky1I+gjcJFXU4IBPxxM/UiDbTEZpAoO2OEHEVO8A=;
 b=KPoFxargxg4TgDqNdZIXu/oX9yr53DDVp7RSoHtJX8EPbT3v+yuDa+jOhVd2N9bVJlwPz13glt/lNlb1yrqaHzQodiK5zJuqjYzKHaTv3B2f5u84eK/NPXjhnb00rLK9wnKB2/oyhsCl7JfMui+RY20aIJKaWpd5CoYQbmlyA1Z7agJaQ+NhS6LPVFYeZBOmWYhgQ3PTlR+oj/7VW2YMvusdaD9O3KOrEqA13egWyryoxMac/GM1sE/naPDAUz8Uyhbut0AaCKWzmopZCpixS0KcYe3O33Q5PoT9RPFYMJ3E3PvBltcwHjyT9JO4Lv8coKIF1+YoFy5XMWEUllENsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOmky1I+gjcJFXU4IBPxxM/UiDbTEZpAoO2OEHEVO8A=;
 b=rwniadYy/bVTfcXR4oqKJ3Zx6IiO6ge1xqodizo8aDSrHSUCDyx/Os+UfiqzK6a2PhaRbedEF09SXQI/F+y1GNkBHtK+CdKPU7DrIHtbW0Z7IPUJ5sCLpb7YUGT7jivgPEs4jnRLXZnFMpp5ko/NsE0jy4Rb6oLVX4J3hotvWAQ=
Received: from MN2PR01CA0044.prod.exchangelabs.com (2603:10b6:208:23f::13) by
 SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.16; Mon, 10 Feb 2025 16:24:00 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::74) by MN2PR01CA0044.outlook.office365.com
 (2603:10b6:208:23f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 16:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 16:24:00 +0000
Received: from saleem-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 10:23:55 -0600
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <alexander.deucher@amd.com>, <Christian.Koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <veerabadhran.gopalakrishnan@amd.com>,
 <leo.liu@amd.com>, <Pavan.Ramayanam@amd.com>, <Pandiyaraj.D@amd.com>,
 <RaghavendraPrasad.Mallela@amd.com>, <VikneshVelavan.V@amd.com>,
 <Devangnayanbhai.Vyas@amd.com>, <Devaraj.Rangasamy@amd.com>
CC: <Shimmer.Huang@amd.com>, <PhaniMadhav.Chamarty@amd.com>,
 <Boyuan.Zhang@amd.com>, <UdayKiran.Pichika@amd.com>, <David.Rosca@amd.com>,
 <Li.Ma@amd.com>, Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Subject: [PATCH] drm/amdgou/vcn: enable TMZ support for vcn 4_0_5
Date: Mon, 10 Feb 2025 21:53:39 +0530
Message-ID: <20250210162339.3583506-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8bea75-f205-4238-99dc-08dd49ef5398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0FgiBfF3rfgwrRdQc4nr1TGgXI1YH1C9/+2fRpebDRa6rHRzLYdCEwyPDPDm?=
 =?us-ascii?Q?GNYw5Vr1nUT1dRQ6rXGPITzIQAHF/f1rbk73+Zy8iJ2dmex/BqHhdJwLsJqU?=
 =?us-ascii?Q?Rphn4FsnwMI4omioyNt9Epra/0Leh38Ane0sD2tPZjelleelg1UF797ouoFL?=
 =?us-ascii?Q?+xzF/Xs/xlhnfOiWflq7PGvMaV3MDcGQPJOt+wWNHM0TKpVGapQuehavMb6H?=
 =?us-ascii?Q?UGI+oeFnFuwXLQGJLRTvjdVpmqLRIQ7IYeD+MpRAL/x7ufAttYtQM8JpCM/U?=
 =?us-ascii?Q?JsWt/2OAt9TW4wXknKUnRk2djnbd+Gh05q5wx4+yBtxs8jcGjqjHEkVMrIK7?=
 =?us-ascii?Q?DmcDsKqDru7LDKFmFr5Uj8sYMf0/LW2NJRM1SiykAM9E69MLpdU7gKIVuq8D?=
 =?us-ascii?Q?uwfhlkpKU4KjprNZrARBwg1EqoWaIShsDRWvGiGVfkXXRjGZ7ZM4cJ51PenN?=
 =?us-ascii?Q?YYsyf3u/ijhXI99DxKVZTmijvbK9CTACdKGtoO0MF+tn1qxeqkeWbsWVlYRS?=
 =?us-ascii?Q?Rvg/kcAqQkjqVJd0WpUfUVtO2eAyWV9g4PGPKo+pwEJth4mIC7B+QgddWl+P?=
 =?us-ascii?Q?9b+6n5/tssXeBe50/6k1gP7O+YvusJfuv9pr5xXptEf76NoHbNH4SVN9h0mu?=
 =?us-ascii?Q?3sF4VtrcXETzrzNPjMkdCYxUF7ud4cBCtfjMO1To/qrT1JI/+nV2HohnpHvl?=
 =?us-ascii?Q?Fjw2jBWjyQZ8CKubFKNLGnmSXPINtCcns6frd1N8eCz/RkPlym+oRI/vEFfc?=
 =?us-ascii?Q?e671wWVLOIqT86vWxoGsaU0dJA9/EwDvXv1NDKdh+3RPqrIvYKrzsV6qq+kd?=
 =?us-ascii?Q?ERm6E1rPmVw7NF+gC5iqwfdX1s1nUVjxvFpDlxpSeqfjAtwE+wZEMkiaJyZA?=
 =?us-ascii?Q?gjCSwLmtWr7mrTQ3By0si/t4tNKXnhtcfbJDIJOiq8r635feB4TUdC5ySkJ7?=
 =?us-ascii?Q?kpWAY58e92c/5o/9tznFBYzr88r0W1PncEfYUUGLkkWwpIXlO0gOgngvPVFO?=
 =?us-ascii?Q?vSBfv8zattYiBhepLRNNwxB/zVZvzUbUh7YVCXjI4JwHFxgwypZf+teC56UT?=
 =?us-ascii?Q?EmoGqlEEDgUUKfVkLN4iXCP5JFzc/6T5U6kVEq9MUthfYtcnFfwl+QYqDmKj?=
 =?us-ascii?Q?ozoW1necjO1pvN+GiSBLYrqX1CZeMUNenK3vYsQ8lcXmzDDOaYCEGxg22Gdf?=
 =?us-ascii?Q?uLBnkKglusQkq/12vtNVt0jbt1EGjZvcGSkmRynjM5Jo2Dgi2KW0QDc0juwE?=
 =?us-ascii?Q?kSKTrOZhJW3csRd8gvohwL71+Uh0lFY2VveJ+LVZSLj16AkUbDHf1BeHKkqP?=
 =?us-ascii?Q?Kv2aaG5g/YTj3dVETm9oyoCbJi66GSex33Wgl7fhaQ7IYRGbL+QpbnxhLUl1?=
 =?us-ascii?Q?XXpOhlfShXBi1rcTVaAxCWyzbP2lsh/vpaND+TK0uxr53ZOX98JNJZdVTa+u?=
 =?us-ascii?Q?PFJxXUgLM7SbhrU00VRKDVf8YRqAfJOKvfjLEyFpwW1IPs99uKX78CXeQqvj?=
 =?us-ascii?Q?7TpKcSQ4kpBtX2I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 16:24:00.4218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8bea75-f205-4238-99dc-08dd49ef5398
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829
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

TMZ support is enabled for vcn on GC IP 11_5_0

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 8c9a9017320e..eb29b67ec807 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1405,7 +1405,7 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static const struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
+static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
@@ -1449,6 +1449,9 @@ static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
+		if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 5))
+			vcn_v4_0_5_unified_ring_vm_funcs.secure_submission_supported = true;
+
 		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v4_0_5_unified_ring_vm_funcs;
 		adev->vcn.inst[i].ring_enc[0].me = i;
 	}
-- 
2.34.1

