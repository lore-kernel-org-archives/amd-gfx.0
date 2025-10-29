Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A59CCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F4C110E217;
	Wed, 29 Oct 2025 17:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aYrCmzOw";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F5410E803
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6E0YXWSIrTJ2n6xu3KqtnkDyeJdFTlmuf1XR/dAaBIZDzc0pc3DZcWoyW1e1sptp4gVbJDY4DAhgAlYsVIG9BelynSJ8u9GvCWrcjJBI23wclBwMlfugs5/ahnuYFs7Ck9ZBFWHRXMxOYZttBIzOjnufskILXQXIWpgEXUHJLSQG36AWbROkTFE/YIJtE1JidXptYPIqdTZFCOLhADJgw5WuiAO42wW9u8QaQkWUXD1RCvmhi2aB22h0+sjI0SO0XVXAkWeqEaosgSlAjCnFeoZFjBct1GsfEM6v+nNPkfkGNcsCK0ZG0BODGYEPlaKRMdNaG91dy92GccHjcRuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EspoueF/liI8hejUSJeiIpvWFVyqtvEa5M+E+Cpmav4=;
 b=q6kWKfv4KAVFYMR/0xxhmNBqqsgbL5G6c6B8+8LtOI3qtHlrG98AbJY9TfKu24SeRKr/ziHu8kP8gKirs2KFar3lMrm4aImS0pEZFozpXtzPMrkUzBa6SH74Di2Sqgk0jyCewNjHpK3+yLTiM5L6NXBkTkhzzzqjkf1WQ4Q0hD6JOEChDayemHTppm2kbAgmwbxP9SYk2vb2nlNdlGXKrjXC9+cHLy+7owdPAmrOtOC0b9TUUEMybzJ9WVYK6t3+tD9aja2IqKdQWvhhHilH74b5ZgPh7kPQnqvXRPFz4Ohn+aoeibsvEB1DvW2F8kiTqLNpq4fWb2JbtPEx1QxdFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EspoueF/liI8hejUSJeiIpvWFVyqtvEa5M+E+Cpmav4=;
 b=aYrCmzOwDKxTuM7wLYTURTuOqgA9b+OehM6/r9Liqi3WVK1SWc9thbYlUn/oO52L6nA0+prhOHW/rPyblgJqxoFKB8NbeOltvhfa66jp4tFcr/3QN4NhhcXzotpR/m3op7pMbAjwiFadhbxq5C+pg76xBJOJkldx4NnvIE68GEA=
Received: from BN0PR08CA0003.namprd08.prod.outlook.com (2603:10b6:408:142::19)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:51:58 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::fc) by BN0PR08CA0003.outlook.office365.com
 (2603:10b6:408:142::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 17:51:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:51:58 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:51:56 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add PCIe atomics bit in PTE
Date: Wed, 29 Oct 2025 13:51:30 -0400
Message-ID: <20251029175137.2861556-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175137.2861556-1-alexander.deucher@amd.com>
References: <20251029175137.2861556-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 691add55-df78-4e13-8793-08de1713db33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qd+VSjuzQj7oD/P4JPmLUSQDOKp/1d83T65lvSzCnn0wrT9uGHyXqGxR6lAV?=
 =?us-ascii?Q?hhh6ru/DePLIJjXj1XlaKzOUNVVxg7JPrTCNe/7XHOrRtMRpcP87eRzuEsDG?=
 =?us-ascii?Q?f4oKMo2KgxZcU/7fiiw/brQ+5KhcTcGCwqSkXaPVTAbO3RhiQ3hePt5PD/8R?=
 =?us-ascii?Q?CZ4aBWc3Oi6CkqAoWPpfPXi7XSSyQudutACEuK+vTl8FeXFyukp8c5x5aFc1?=
 =?us-ascii?Q?YnrBum1UfoGc/QBl8+XI4cbXr0Sb7i5STeslCkNfawW5jpensSd1dAwTYrn/?=
 =?us-ascii?Q?+DfvAl8ajiJhtRsRuPw8TohuymJLIUtCr5Uw9pKoL3HPfTO8KL7Qv8dmUgUT?=
 =?us-ascii?Q?657rXNYb1ex6eisApcJi11Pg99F8y9/4FC3UwPw2VHvwk/bO26vCbDVRv77r?=
 =?us-ascii?Q?a4dEcoJsm+Phhu8BKZ/2jFRzBcXfdovM+J94+OQHf5vDDdq0sI+VJ5vR6BhF?=
 =?us-ascii?Q?RBDbXJs0l+/3D4dVWsuABpUCXSJcKZCklwg5e0yCPPIuOyoRTpjsdSH2avQV?=
 =?us-ascii?Q?bTN7cnKNwFDFt4jOhcHDSlXrEjRuKQK0gaV4KDt++ssWibtgRNnX5Glhe2JM?=
 =?us-ascii?Q?mfPZkjIjY98WNF759VF9GSYjpgtz+DxYM6ch2muYKbHsb+GibY2thbyWwneZ?=
 =?us-ascii?Q?d5d/SPxXANWnqI5MA5NscjTqgylTCqJamkzGypZRkqaS6NSDK3StkRvzjJgz?=
 =?us-ascii?Q?J2uBoCmXKzhR9gne80s+bo9ajsO/pJfQoxNv6ao37i+ioAmND0L5rA3xT+K/?=
 =?us-ascii?Q?fWfEUnISW/mOLDVrwizySzTo/Kvq+d80frBZoRTiIXdJk/QzfhJC9Pa4Xpes?=
 =?us-ascii?Q?I5QEwDplgLGG6S+5Qo4mqGb82I/LOxraVFqf6peJmRra2nvLp8Hpwns687L9?=
 =?us-ascii?Q?k9GKc5gYwx2f+JANcZI0hkuedPILcbe99e4zcCmobxr5aXowOeAK29i0DyTQ?=
 =?us-ascii?Q?qm7B3gZhN3anWTZqwWODdVwJXgXsQCdXVEvVH9VyPJx146JtvAdjuyLijrlz?=
 =?us-ascii?Q?NESXgihtsrgHw4iepEM791laC3HnXFynkdQDPHBocG4lC4skF6O78uPBER6n?=
 =?us-ascii?Q?eHO+YGoR0fDh5N9W3ADwwu1YirxitmJp9n3RddEB6aQXxrU2mjy1jIIOu0vw?=
 =?us-ascii?Q?R5gqo68rM83M0kvkK23Aib6LjVZmA4vga6njB8hu9WAiP5r49teaw6WqJp7r?=
 =?us-ascii?Q?p1TG+Cymq8y7PKnZe3IXk9+QtBxhKydeqOtaI5T5vRh3fbDx2q/NsZ7b9VRy?=
 =?us-ascii?Q?AoU1JCa3ozQBQ2dVJH+0fE9hQsnVeOhhyboGaQcvrh91N12wPvj7cgfs+njo?=
 =?us-ascii?Q?ZONAim54plcQTnYvd7wdDBxbM/XaegLZ0QmnfwgwhsBVLnjNHBT2BnwfDmn1?=
 =?us-ascii?Q?yKEGV4q2dKMbDh4Df/aKchoZfnnMAvV5A7q1FBj0qN83zUJ8H/fCI+C5lMNK?=
 =?us-ascii?Q?H10fEL/yui0aZLRW5mQQyYXN0gLsGSAqXazsfmU4uRJfp+8X7txxlCsNu0Qm?=
 =?us-ascii?Q?Ll4lhWY9wmQAskHCQRldsyGweMGXOvlSHPk6akUaZbh0em9S2x2LT2TyhXeL?=
 =?us-ascii?Q?nZS1Vr1L5Ftg108M3Xg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:51:58.2093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 691add55-df78-4e13-8793-08de1713db33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086
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

From: Mukul Joshi <mukul.joshi@amd.com>

To enable atomic access to memory, setup the new PCIe atomics bit
in PTE.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 77207f4e448ea..78129cea7cee3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -129,6 +129,7 @@ struct amdgpu_bo_vm;
 	  AMDGPU_PTE_MTYPE_GFX12_SHIFT(mtype))
 
 #define AMDGPU_PTE_DCC			(1ULL << 58)
+#define AMDGPU_PTE_BUS_ATOMICS		(1ULL << 59)
 #define AMDGPU_PTE_IS_PTE		(1ULL << 63)
 
 /* PDE Block Fragment Size for gfx v12 */
-- 
2.51.0

