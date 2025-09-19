Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EE1CAC592
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 06:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7722610E228;
	Fri, 19 Sep 2025 06:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lEX+9+hC";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C406210E228
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 06:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTwnJKOk/+FLTs2q53rdAFBOaPRzneCF5EpjEk6yZ9X5f/SGdGkqe8o85MsIQpAwkjIhG7CkdAKwg13ehXq1liObtl6dAiePGlRfuXolDpoewWQhxAM7OzUZgYtit/KYE0FgnZW/XF5UZ2ab6PzoCLOQroFMLez7S7FDgTGM/CLorEezbhiBxK/yATWo5+B3KPPEaT5JFQvj+6gTm46Ns2AvsBV+QRKYiKFZ49YA2TyuN2etoTRofBqNzNQ0FTYVI6//dE+dwdvF5yukBZfjmAj9ecEqouVjnblvcm9ssQjRbOoURPDsd3uK1jdKFY55JYg+Y0P6VT0Sbn5d1TKArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMfM48fZiUp5KvsQPWJ9+ddkrjVVCmHeLfxTPM1yTmM=;
 b=DA9m9C0NhiGNBNyiQXPqj4vlgEcj1YS1qLWXyZlvrrzy1S14Sxtu1lPdGQGPJiib5BHkRjg6xfMch7C/9LvIEOuOlghDR+hHUFTgjUhyyvIpBBVZpyrgyokewaeJUUF4QCpbDFWXvmihl6fLdBUyc1nDJ2Ji6k/jMpcCX4TP2Te2c9jmOlxxZDQ50ODrodVLflVYMlwKGXdX76dsdAvEZjH4Kd2571udJvMGy28hadBJ4G9tSSk5kNj6RROV9Aljaz4RV79xmnqqXBqPowKoKWtVagUwYGIBt+22ZZbn65wwZLW7ImuQgUsRoYw3AxFN1ETaBFtvrTV664zd4B0hNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMfM48fZiUp5KvsQPWJ9+ddkrjVVCmHeLfxTPM1yTmM=;
 b=lEX+9+hCh0Jw5oMy4KuC+bmNZ75Oomgl4dHCl4pNs9DerU1azH5JtSV9n+n9qtqV1uZCHkqWN+m0wyNz3ntj2zO4uRmIpH/JEt5MlY1CWp0Yr7NcU9OkArL6Z0z12ugOmz+z2QzfIjGd4j65HLir3jGpxCEbHy7pRFmcX0F7daw=
Received: from MW2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:907:1::17)
 by PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 06:46:28 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::40) by MW2PR16CA0040.outlook.office365.com
 (2603:10b6:907:1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Fri,
 19 Sep 2025 06:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 06:46:26 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 23:46:23 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: assign an error code for invalid userq va
Date: Fri, 19 Sep 2025 14:46:13 +0800
Message-ID: <20250919064613.2786008-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 168af04c-ccb5-4baf-f9ce-08ddf74841d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f9vcsEr9VqqpV6LI0U5NUMsfo2LTFQf1WAAMLrm1LoOnIQvxHNRiUq8wu7Jx?=
 =?us-ascii?Q?BolYUdIiEtEiiul3/cqZgLm5RWe8EyzG3QFL7SndCFjoHxLiBsJ/H//D6GJO?=
 =?us-ascii?Q?ji42P0m46qN2xLSDUDVp2ysqzLWOVQvG9qOJdfEpIXJEdVgAYIX0QhFkzs5M?=
 =?us-ascii?Q?KCpPG2ht8/QSnx8FYztCGVwZieerLmPW1fDQuTlrkYa6TFArcpLrN4ek6KdE?=
 =?us-ascii?Q?POSIrkgm1XAepJuOI2EZtlupsZo90eUjz907If14qy2IaIHPiiaimt7kItuh?=
 =?us-ascii?Q?YF1dYhNgK9jp/q863Au877hpBLJNxdiz9raEQsCO2bu3E/MA0ieO2IRzW6sE?=
 =?us-ascii?Q?80Pu290UMt74JNDFJxoJFL9GwZYvpV1Ed0CB3z6aJeLi/vQy0+DvSylKpcdr?=
 =?us-ascii?Q?x/tGYU4+FguyjI5H3oMenI1uSpYJDvt/TUNpCxguGhA8BgsdJDdcRpMfMR27?=
 =?us-ascii?Q?vSb+8YDkkbpKKb7A+VP6/VUXMh7pKZ4iPmtsd/JOvIDEWJ8MtKB6zhn4ZHMP?=
 =?us-ascii?Q?VMA/NegxcsWxWSzfJ6AP/nnw+cI/Ikd/98wsTWPfcXYGNAX8L1pQI3Cv6cvi?=
 =?us-ascii?Q?E1VVDrrYLzBqqpZm0oJMWteBwFwm0ooH1pVppdXliBc/+sRnl4mSz0Dcptf3?=
 =?us-ascii?Q?Cn7RlRdlAIWoIHEcgMxMrotUw9RSquIl8S9rxmnuYH8KQuUkST6Sxmw4lwVj?=
 =?us-ascii?Q?SbLis/xQtraIxdk16fQadaKyikF2jyRMgA7fPht3alBrKd+eG9RoT1dXFS7O?=
 =?us-ascii?Q?PfElslVvdxlrMC0rLLEd8myEZeY5YGd4NCizo2lYgqc952fATChs3v8tNa12?=
 =?us-ascii?Q?OKY7MeeGdLoILY771i0b0znZ0K/fJbmRx4PZHu/+lWtpNm1gJXo4oFjt6Iso?=
 =?us-ascii?Q?EeJyHbLKtkRvUtYGoBjqY2217GD95OmeO3Kd27YsRLvRCei1mcNrYKzUhEkX?=
 =?us-ascii?Q?74ItSvCy70CqJP8QKru3UkI86o6/jIoOkh2kKlP5ImYhOK3tO0eC6QsBoi8I?=
 =?us-ascii?Q?clDq82GZzjLYivphT+vtN7WZuT9F/xcoEa0qSxViAtbh+5+0EIESPtJQWxTt?=
 =?us-ascii?Q?b50IjP0OUMSiJ+tC1vQ9HzpCGB9morw0xt3X3hNwt/mKIwhbf8fU9dMLiu/H?=
 =?us-ascii?Q?yj7X2PHUGLvrxrYg4aOpVzGNxv7ZQat9kTle8v3xX88+zKPEo02zMeC7z1ch?=
 =?us-ascii?Q?RzmaF5bDkFK1fb9HTXwRFHSX6xqPuC7Q2PdFn1+O/ZxrHNRWuXS/fbU1gaGh?=
 =?us-ascii?Q?cyjbr9C8+g0CsdrommJ8v1TTDUfgGrwPtrve/cu/y0/1FGwl7T850pPNtZ5h?=
 =?us-ascii?Q?Mdwdiqj89fEcO7fi1eGFyuBNRuGiBaE5SGksqz36ztKL2fYnH+mO6zCvofEV?=
 =?us-ascii?Q?G0z58nAnNjuXX+SUQ3gI2jmd4hCB5bxzmjYHY17kYuPq33ixRKjSIUVLAM+H?=
 =?us-ascii?Q?oNj1XaUOrwVVrMtR85bUHIjXHJJw+z31bCQHmnGPw6v/DWAJ1SZZJCU9OdOt?=
 =?us-ascii?Q?muwhbk+HfDTeizYVSbi5sNDb6na2mqRIfZNd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 06:46:26.9377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 168af04c-ccb5-4baf-f9ce-08ddf74841d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648
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

It should return an error code if userq VA validation fails.

Fixes: 9e46b8bb0539 ("drm/amdgpu: validate userq buffer virtual
address and size")

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 5ab4ee26b825..3bbe1001fda1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -71,6 +71,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 		return 0;
 	}
 
+	r = -EINVAL;
 out_err:
 	amdgpu_bo_unreserve(vm->root.bo);
 	return r;
@@ -508,6 +509,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, args->in.queue_size) ||
 	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
 	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
+		r = -EINVAL;
 		kfree(queue);
 		goto unlock;
 	}
-- 
2.34.1

