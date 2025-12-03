Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139DDD12D5C
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 13:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 894A510E793;
	Wed,  3 Dec 2025 13:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PQGMHGAr";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010034.outbound.protection.outlook.com
 [52.101.193.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED9810E793
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 13:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIBOJBkzsAllC+NP9JU18VR8uicZJYa6ra5ImdcLWjvOOBR095xLgYChZW9UjiUjs8TijZD1xOfkAH3WyyeqSjMj7jgAwCi/sxWn4+ZyDZlRhkAMTrmh9iCvGhScqHk1tQn8fm/LGei7qfDezeUpKODdbWuExB1fSGOkiMQ5piCERfi0ru0kEWeyYmYvBU71Zk9/yNMDftCw8pIaPFCbYKCa7/XmI1PD9onN3gblak5bGXgAB9IvTuBO6v4QIKlSWiIHf4gYrM+MtgvgwYU87T0C812JJXPXQmrPs4e03vcjmbbY+QOTGh921O3RPMFiO1cGxIFTdk994vwMnhfPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWWmQAQLNx51zOI2at9/2VU8c6mHSUOKwQVsfVSkt9k=;
 b=q6XBi5xrxHefA2idFgUJlIfQH0mfHx4snSCd0qXdURJOLbeCvRS2t/OheOLxxgxFFfvPzO9DqMfWNZVFs3DmiQh19vHKmQH4uuGb6BvUS9lLfua2WxpJLEluL7wehtJw+4Ob1dVFRXGXt9ikBr7vzATUAh37P3+P0C7UPlP0y+lvcOgmPT30niywQUp3mXzcVvz0fvvQZC24C5jSttHOyhVPn0sopxIM6opYbNb76tkTYdlop9uyxySeonmlntGr4hcJbOydq1ffiZVvn+sVMG0Uh1pR9h2hxKSvDLNyYtQx112ZKaLP3wZ5Fmn5fXce5qufgeT9stsk8zJAuAurnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWWmQAQLNx51zOI2at9/2VU8c6mHSUOKwQVsfVSkt9k=;
 b=PQGMHGArHLL14oFIaFFLMhEvITb1PGmfgXlf65fcu+TNSjnyn6/LdlXlwndYOdzkiA15YJkTmvy0pcvG3yXlr6AJEDe1uSc0HnxwupbKAWnHdiSHpWXhmDCQ0WB/pdI5tjK1oV7Wkfs0AwAg01WXh7JHm8tKSm9AcdPtfAnX42s=
Received: from BN9PR03CA0170.namprd03.prod.outlook.com (2603:10b6:408:f4::25)
 by PH7PR12MB6666.namprd12.prod.outlook.com (2603:10b6:510:1a8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 13:05:01 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f4:cafe::57) by BN9PR03CA0170.outlook.office365.com
 (2603:10b6:408:f4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 13:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Wed, 3 Dec 2025 13:05:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 07:05:00 -0600
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 05:04:58 -0800
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [RFC PATCH v3 01/10] drm/amdgpu: Add helper function to get xcc count
Date: Wed, 3 Dec 2025 18:24:52 +0530
Message-ID: <20251203130436.745633-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251203130436.745633-1-lijo.lazar@amd.com>
References: <20251203130436.745633-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|PH7PR12MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4cea57-d7a8-47f2-d3bb-08de326c9172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l43xjyX0MaJpeLJKswuAeRrHpHM159S075N4gS+cHJdgWDnybym8OK834VrY?=
 =?us-ascii?Q?4gduIE6rPG5JBLuLoMdBrS4kqzefb8oTsNgPO86C5c39nAmMevNrITkIyIXG?=
 =?us-ascii?Q?oW9vVBl2fVzY1oaSGRo/pjpvrRfOfoUG7BuYSVtn1nBcmHPNpJ78BYtfdLDT?=
 =?us-ascii?Q?2ju/se2djqyvcNFNQdohnGKr9LJ6OIR40Z9pDD8z28IXqk8pA8emfXlWF6Sp?=
 =?us-ascii?Q?moMiNN8V5TONoJuqPXBuPpHSMJ2rDNsdEECIkThE5KB7wcPpisDrj6ybRT69?=
 =?us-ascii?Q?VyIcx4VA1IFkEi6gPh8d9HhsR0Q1iUA+T0zaUj0zY4earN086aJMpxoEyLxQ?=
 =?us-ascii?Q?VcXuTseH8PRB13zZPrbqxDoF4Ot3cpvnmvFsnpmcA55nL7BugII8KnJYnAko?=
 =?us-ascii?Q?CNSfmARwU/OhecDi0IYEMOxVYer7fCzqFtWFqajRHSNIgY/5x4jHvgBv+y90?=
 =?us-ascii?Q?hS2TjTiuW4Px38X0ZR3WnMTHNdmtfadAxJjq69yIb7H2H7V+KWjt790uSQrY?=
 =?us-ascii?Q?yjDtT4ghC/tUadfe4M3p/xGajZvEown//vLVfM98sKDZiWJ37psg55sOnmC0?=
 =?us-ascii?Q?RpJgOl897UmyFXSvOsBt1Mo333o4dsqK11m9+h01Lcf21+mnSHMQBwkDgfdN?=
 =?us-ascii?Q?UTbOCS72yLzYSou+/RoWZW/OXtdMWy1+aaKCjxK7kb9jU6Q0U4iO9zLbGEfk?=
 =?us-ascii?Q?9SK4C3/+faUGAF0errT/B70F11uxivFhOcak5CdMpHRxPRBHDh1wkLOuUpBW?=
 =?us-ascii?Q?CYnoPz0bs6l7XodKRZ0/ggNRsQ1ydMUKeP+jHXUze20cyTMg3A+BsgqlMmuV?=
 =?us-ascii?Q?huUUVR9nv0QtJO7mo1ua2BiFqifETAoDqNNhmghfgjJOBK14hD6xVTlskPWx?=
 =?us-ascii?Q?wkBmuUHC73kLLsOf3x9KvfWvPP4ePvcweePE25iKAauhL8R1rpZk758YFgHu?=
 =?us-ascii?Q?jmcwgqGWf5A+p7me9J8VfsCHdeB/vpbarQqg08+TM7BPCtpNTo/h2uKrOYeT?=
 =?us-ascii?Q?8QNnUuuMnC1uHucohB5Xh5bmS4OXnW5wJVQzyRXlZtnqSc5sMjRNKPBleQmC?=
 =?us-ascii?Q?H2c5b5V9z/H7ZCuSyoi5044J3wlz2O/iNaoP5bZAkMBuZHZ5QS+P1t1LgmhM?=
 =?us-ascii?Q?ypFEJweaKgBX96/53GZSC4WGgwyTDojwap0WcNUISxpnlGI/MOyz7B+1dnCK?=
 =?us-ascii?Q?GSgo3MU/97kpaKIQQdwZ+tkCo5POBzhznNo6zJsWBugjYADOxYo5X0V3fiBl?=
 =?us-ascii?Q?y52Bg1Dy96nyMpREnJI6DbvnuD1e8u6YhHDHnHYRuSfXA7alUiXJwbBrkk8Q?=
 =?us-ascii?Q?GnlSgj6dclMshFElv+IHmn2ZGOnlKAxGQdl8kjWqbfKHOTH/rgr55OQhdrZu?=
 =?us-ascii?Q?7rRy4loiTIHodACWx8EYkgYra2yu0XLenDfh4YBqOzMAY2USTtFkbTVv1rIC?=
 =?us-ascii?Q?MUlMrt9nchxYR6fy6nFjB0bbSeW21LphDdA/fO323/JFBaZEvIB9JmXK5Qa0?=
 =?us-ascii?Q?n2sNJpaePiNr0jiR4qGTjbDAE5j2lHW8d3oErNUy+xtRR1yj268H0wf+hs0n?=
 =?us-ascii?Q?MLz9ougpz2ocMf9WDGo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 13:05:01.0837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4cea57-d7a8-47f2-d3bb-08de326c9172
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6666
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

Add a helper function to get the number of XCCs given a parition id. If
there is no partition manager, return 1 as default.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 8058e8f35d41..b780c12b07e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -217,4 +217,26 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr *xcp_mgr, int *from)
 	for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
 	     ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
 
+static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_xcp_mgr *xcp_mgr,
+					 int xcp_id)
+{
+	struct amdgpu_xcp *xcp;
+	uint32_t xcc_mask;
+	int i, r;
+
+	if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
+		return 1;
+	for_each_xcp(xcp_mgr, xcp, i) {
+		if (xcp->id == xcp_id) {
+			r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
+							&xcc_mask);
+			if (unlikely(r))
+				return 1;
+			else
+				return hweight32(xcc_mask);
+		}
+	}
+
+	return 1;
+}
 #endif
-- 
2.49.0

