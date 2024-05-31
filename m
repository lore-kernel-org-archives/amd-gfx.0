Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D4EC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C1110E0F9;
	Fri, 31 May 2024 16:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wmRnZ3IX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D9D10E0F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f24ep72psuD5Bh4rttd7IJK4vHTyyOieGsR3ZVsrP/KZP/44dhgOuPolMVbYDQncrCPPrSX8MTnIn/WAWtvCTIp29e+6zfsDrQ09+aEXpENAVIppSL2CNl/dDU5MaXL3ba3t/QV0g77+rRzy9ZH2TlEkuV/TZJVGmuaFBScG3Xl/1AMNur0Cf6XH6qr5kw3XrkYfbRNWdpvxQx92suXJ7XJCFefQRz1/eEBqFSfCf6ZkD8itgGe2CldaTkx2aYe58pMsdu7DuJ80iWHbDpLrUW/SF4+yXuLdMKa1D8bMhPkZEu5LqtZJKuS9jVakxRVWhC1ha0X0j4xipLm/krZyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJm7EojmeSu9smFo4JwwY0fGWcA7ZyN/36pSFyjmqoc=;
 b=Lw0YI3zNQjF99WVdzvwtpTcGA6H9DYLaroQ7KjHZNFSLkD6IpK0kdtR2SEKFlrkyap//gTId0Mor0DgU5fVrLH2XGX242p4QPM0UiD6VZBRvCAL56Ba2GaXhUJ+K4h3fS2mY6hLOTgAYTCUUkU3mEQdAAspno7dbaz8YqYB57TC2vs17c/C6AoxF8fevlcAwDav5rroD3T3zUTwHdITaXlre2ffj4ZcShLM+lSZ95GzGegpA0QQZOcXmSBDLt1C1rpN6uItmuvVSexV8QhjzbvMXO6riwW6MP7MCrGuY2lEw9yXP4+XrmIHI72p3qRD2BjiSdmSOoRs9et28RposdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJm7EojmeSu9smFo4JwwY0fGWcA7ZyN/36pSFyjmqoc=;
 b=wmRnZ3IX525RmIhcc5eULRPqoHL5hmR1vXinXR1ibTPwBBcTQ5Og1c7a4wFcHg+DNZniA7G7QYW0qj5riUuddcSgyt3v3EGsNURwO5Eno7V1HwYWLyELJ6rbPylhDBhU3lerpNjOtG6eC8FixjJGBCd4aDDKyi9ZOox8ERrJirg=
Received: from MW4PR03CA0047.namprd03.prod.outlook.com (2603:10b6:303:8e::22)
 by CY8PR12MB7266.namprd12.prod.outlook.com (2603:10b6:930:56::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 16:07:56 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::f) by MW4PR03CA0047.outlook.office365.com
 (2603:10b6:303:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Fri, 31 May 2024 16:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7656.0 via Frontend Transport; Fri, 31 May 2024 16:07:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:07:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: add additional VM bits
Date: Fri, 31 May 2024 12:07:33 -0400
Message-ID: <20240531160735.3547360-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531160735.3547360-1-alexander.deucher@amd.com>
References: <20240531160735.3547360-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CY8PR12MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0d13a2-786b-462c-c86c-08dc818bd589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MLeBGjLlUijBX4lSyDqtXAkGNqCnLS0K/oYN5Es1sS1a+tp5nSdGahFjR3Kp?=
 =?us-ascii?Q?4ztUG0JGT38Vz174HjjNMd28f6EVGnmimf0wiyuov4H1BIVwdyaHFCo1i0ck?=
 =?us-ascii?Q?VWtnogd4yuJH3RNZR72QyfKUtngPc9I0IHwP9yROGZ5+e5PEdDZoHWAl53OA?=
 =?us-ascii?Q?MWKQfKHRkgtCViPGhtSIo1S2l3Fw2flwgu+39CS2Ov6dHU9aqDzBmWrRes62?=
 =?us-ascii?Q?0jTu8pe7EzWoHYY/Na2TLlh004n6ipew6q2SoNWrWRreXoIhBHLQTmSQ35jE?=
 =?us-ascii?Q?tk7frYXv1wBVqXVYh0Qw3fqG2UKZVLMy4fg/X7sJ0j+MHOaB5lpktOe7jcjm?=
 =?us-ascii?Q?xkLX3KVp1gqdhHhoWRGMHZmxwwQFt+2gs/EZdIFkDQOlHwq+rNjDv3gunsVi?=
 =?us-ascii?Q?Xwuj/WJf9BRqsEItcVFkvtMZiCag4Jr5p6BHlZhTj8bk766We+Lb9le2E3HJ?=
 =?us-ascii?Q?Nb/PlJxvICt1+mRYoRNHRepZgpRdNfQV7wUHozyam9azw8tn8J/Bmv5CBl3f?=
 =?us-ascii?Q?zOySTXIsKmOtNw+3IOoG09VeMxlE7OC+Xs2D7EjgZQPAGpKyhMH0s+pBdHio?=
 =?us-ascii?Q?cM/nYfFcUploLSkmUbh4clw2yczw150xR2VW7FevjbBTvI4PzFtp1hPFcmxb?=
 =?us-ascii?Q?M2XmO6CBofMqmepzLgBqqNvDPBouE4RG1d1EqHXxtizK1m5UOVUj1vYSlhB9?=
 =?us-ascii?Q?rbAkWQ61SGmH7KtEXrFYogp10v95k/r6EeZLeTQ3m7M6qQ73ekfkUDKZm5E7?=
 =?us-ascii?Q?22z99ctN/jO/OjsVU7MZX05hRGa2xQp0yfJakXzGbqqUvyuwaibnYR6VcGWA?=
 =?us-ascii?Q?8ARJzWQ4T6Eax2bsFis5/r+houL/IQTDYxhUCVgcC/8nBddnw+D4Cs+ppBoz?=
 =?us-ascii?Q?E8NOEpLRZEa+EjpJM5jAABsyUpZiTzjzOI5rvYhowtgf7VUGi/lg/HRvwb0i?=
 =?us-ascii?Q?+5pp/kjhuFss/NGReq490UJgS4WvOQ5CHRGlD0wVdW51a/MODmbQtj14QlAd?=
 =?us-ascii?Q?SwMJNhQLJNuMX9VQtPk80+eVb69K7UElf4Ip/Urn+uDH4nUEZMEFt1fxJuip?=
 =?us-ascii?Q?9QHi1rnfOkFzt8X6QftJwEu2Z8G0qUkwjnOQmmEQuilYahwpfyuM0np7yII5?=
 =?us-ascii?Q?4/d1kbj7Nm2bNYLDQ7+/VXSaGSfKbGSsELm5db3bpWZ45HcalNCblDIRSb2n?=
 =?us-ascii?Q?zxrrQr8A+ffTgWCSjtZqkxj2Wl3YaAm50x5T/MIqjKyoDm8IjRDEPGyca4Bu?=
 =?us-ascii?Q?NjavkVjFHT4EartjJFi2nP2UAmg4Gy/d0zJypat+K3Gc2SwMczsvqaQgiFOG?=
 =?us-ascii?Q?79qZNB69G7kbibMP3WbS8+Ry6qMwJf5VCJ1ZFAPoEY8BwybClg2Q2xfrCHLj?=
 =?us-ascii?Q?NnsaqeKVfBSNfuIcpWhcZ6JvUBod?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:07:56.1375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0d13a2-786b-462c-c86c-08dc818bd589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7266
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

Add additional VM PTE bits.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index acd1b55b8b0e..a14cf93417c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -122,6 +122,7 @@ struct amdgpu_mem_stats;
 	(((uint64_t)(flags) & (~AMDGPU_PTE_MTYPE_GFX12_MASK)) |	\
 	  AMDGPU_PTE_MTYPE_GFX12_SHIFT(mtype))
 
+#define AMDGPU_PTE_DCC			(1ULL << 58)
 #define AMDGPU_PTE_IS_PTE		(1ULL << 63)
 
 /* PDE Block Fragment Size for gfx v12 */
-- 
2.45.1

