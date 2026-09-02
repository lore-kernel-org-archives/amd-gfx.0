Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094DFC624D7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ECA610F1B4;
	Wed,  2 Sep 2026 12:50:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XdjGJ8Rc";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B5A10E407
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7oYBy8WO/vP7jw6IVVrzkVuWtBOSPKfEWOXvEP23lqiW/z4GZozDB49JDfofQhnGZIihn2o/fPRYk/wh8+3u63O6DTr/DqZMn8ZkG2WV5uIEBa+Xb+CVuDkSX9FzvpTdnlcM0snPISism4Mz47zom6LzIcns/qic0FY2eZm50I4WFZ6Fae1SXqI152CgE6Lj8wM4Vf+IOR9vKrYa8B1jifhyH1a1OBFW4aNjT5uvsKuQWjPmEpkVwFqnDupq/fnXmGoSIpPh9LbQxnIb4v6cEFrRpS3gp7D7w563ee4HOuNMgU9mToH37k4CGqUC22t5R256FcjrjBO5UWiMHKUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35DBEFVV83bybryveffM5ZJkjHM97WHwWP3hVCnvJds=;
 b=fQqza1QRgzo6NXcNkt+/rJFXRe0WrpHaC2Jr9FuKcIgKC5YeqxrSQeqn1T7lMnfQmmKcjLhU73Dqa6BSfscETdu83s5UowdSGgdhLwVEcntuVUeERdkwsR7fiDaLT16PRb0GmBJ51yfjCxHW0iEFKXeuBlJCGm47aH1cBJPG1PuK/HIOHwmsroUApaLewNaw18BiKreHLW1IbAeXBNvoQWAgJ6/i7zIYj0zmAXKinF80ezqm+Qfks7cC/x5ADF4zWrM7t2oU3SwmIhcT4aCdrhg6wfGVgOC7m0+gnN3z8UTqvrP3cNgfTAFtu7J8VLRX0dEoL8+QTFfJE4xasdOz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35DBEFVV83bybryveffM5ZJkjHM97WHwWP3hVCnvJds=;
 b=XdjGJ8RcFi9YFhM6mnm9108ZfWJKYvoEwB6uq8r+ajeyxITarQ2sufl2U5mXrKvomy3vxCSpEBGLh9ZprXvGn4ZV+PbqMDn8mpI/xHBhP3CvZbfEuas9t4GMaIoRo8AMYxlQBWVAr3JfkgWWiRdmFCyYJQHnB5C4m67+sdCGWSI=
Received: from SJ0PR03CA0196.namprd03.prod.outlook.com (2603:10b6:a03:2ef::21)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 12:50:27 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::8b) by SJ0PR03CA0196.outlook.office365.com
 (2603:10b6:a03:2ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 12:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:26 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:24 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 09/18] drm/amdgpu/userq: complete the hang userq fence
Date: Wed, 2 Sep 2026 20:49:52 +0800
Message-ID: <20260902125001.621629-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902125001.621629-1-Prike.Liang@amd.com>
References: <20260902125001.621629-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5517d9-d2bd-4f7b-b41b-08df08f0c323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: rushMIogJ3VaavDuwWhD6V7Q3uNGVUpFoghYs1c55KZWp84vwfuy4ZVrlQH4cxfml+vu9zC+2eCxNasnmz3EqCcyer6Sd2C9D9I3CqV9LU6Jw84jRcr4Sm3hz/yx1rPOS20usy1y5Jl6+41QM4BJdBNnUtgye/GpsS3bVUKeKaybwnesOxpxV/b/2szGOD6Ozf0AszYm5i1+RgXFRh5iXjKrwpmJt3x5ghHj/lGlCJozj9286+yVDSWm+9y9nBS9jvhWL3uTbUCPuKptuDyVEdGITxCKTZsDCEg7WKPsE7yDW/M2IxjMidiJknBL1vgT1xn7HtcctxHaEXMsc6RCD6VH/9EhaiW1Pra8u0aSxCyz9gDW5MzlOz6vJBPTZU6ZDX1eVEJqs13FKXCs5TzElXOxI7PuKZlcUZpu/FSgL9qrUZbpF1XRXOSdGztH+MDsm80pGM8RdGZM8lxMjFWRoeOcrTztYH0nwQusmy1qUC+l381Ci1rqNciSZaJX+UwnfbLQz+8WhCUayPsfzPAQWNTOKQVOIjFwuKE8fpVd2gdKuJMiukvQ0GyzXRwjgOg+32lyHbTbx4QM2ReseznMYtAPnln+ILHRshqlc+yfu6oCqZz2f6QMlN/lNJlseeSA8NBDs75el/t/6QfDuEKwKGBRvoV+7S3uDUF51YqbhXjhA+c8gX4bng+D0k3ah9Fhts4eThIXksxg1xsxvwB/0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AWyCahjQD2PQjw3yFSA3arwuciYeL4REsragrg0E0BuNjPZWhT+7pGXo1W6/brBtu2IOLUjlK7X0rCKUMsAsH66JiknxPEXV3e12YtJS+Vm837N0my0t9gk1MPWB3ql/LOvnUAqcL/kqf/bU/M6b9DLPJU74vN8hrD8RvZ3P6vjxdiJ8C5pyauWgXW/lA2cBf8pwg9/8CY39Qvf5TLk7hlyS+fEbTEVlXzwFKgHyM6sjtoXYYA1r9YmRrGKTthrWtV/hZCLVj5vUNKoYeM626LrTJYmJVoFgBaIVgos1z3Ah9F05928UkZGT4uSngo1BJ19JUaPd4T94UEzs28ZABIyKI63tV+Y9ykva32LFx0gDu/wMKg6cBIyvtoyL/NLxvA/Gn6eydcjkFjoNZp+NEO4f3jcxxeMCar+eS28sdxwqPSDgBZrHTG6R0udTCNfh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:26.7949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5517d9-d2bd-4f7b-b41b-08df08f0c323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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

Complete the hang user queue fence unconditionally, including
the case where queue reset fails. Without this fix, a failed
reset leaves the fence unsignaled, causing waiters to block
indefinitely.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 83a438d8e117..2bb5f231f133 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -255,12 +255,10 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
 					r = amdgpu_mes_reset_queue_mmio(adev, queue_type, 0, 1, pipe, queue, 0);
 				else
 					r = amdgpu_mes_reset_user_queue(adev, queue_type, db, 0);
-				if (r)
-					return r;
-				r = mes_userq_unmap(uq);
-				if (r)
-					return r;
+				if (!r)
+					r = mes_userq_unmap(uq);
 				amdgpu_userq_fence_driver_force_completion(uq);
+				return r;
 				break;
 			}
 		}
-- 
2.34.1

