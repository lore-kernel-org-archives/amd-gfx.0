Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B984C25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2E6110E32D;
	Mon,  3 Jun 2024 08:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LdpR2qCa";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C56310E32D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/tEtZ9zHBJbORR+7pv5TijA9a7S2WakZvgePqMiNdsGqMcjjb30WqWqATTQsbnRPJSM+Rp2xA80NK+/17Mh8e+IfRa2LNNeYaSwBSuIwrYBj9dcdcro3rfFIpyyk4cNwhlls74BNkAu0LCbKVW+FdGOJQdypMl8odXbKLZfRUvHWry407k8q7eyFWfMxOFWrEA5QOT5O4S1OrjU4jS0hjjC9PU/i4stkPIWnYizRCCm4SxA5OxtmSh2U5cl+NEKV0QO7OzBy5Ja0cCjgjjTlyh8l8m/+JVnSosqOlghBwx6ssjvKC0Tf9aaumUDn0XMk7D82dr8H/vursqXIiMBTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaWlSc5yYEO8zrh30p4ikc4vw8jy+bFymzSj5QtPYiA=;
 b=al1h2Krby9MRIV+GuKZlcokxg8lrCkmv7rNnVVxDtNTIxiCOST+W4qwE0DtdJUbI5fE1hYu7Yre7XNqCcaH3781ddCIiTekLVCUTOgr2FlXZnqvw+Dj2VoHohkkgvUMfFsT8WmjzStG7mYATMheE+5wJneRu2kV5r26Pu15eUwjXwISKt8VabeZTbeyin2kkxWF2DLhdMnz0YMJ3LfKzMoKAASOD9qFoz66RN1aevsiMkXtfQFqauo9Wzg2uDNKoGuvAtkCQa58kbFj523SDwxPpHI22VAOqMS59tNIn3moUql6pRfXibE8urS/nuw1dWYMl0b8CAj7JUkTxMtmX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaWlSc5yYEO8zrh30p4ikc4vw8jy+bFymzSj5QtPYiA=;
 b=LdpR2qCaKMd6F3IYdH4+EEgYNfRRTzyuNOtMc578uQB/gNbVa9pXLQoy8iNHjdIPPwFPLQT/h1ky0apms1vtDQaHeJ7uY4hTYLOgzcDoS201WW/vSlZ1dC4qwoyQ3zkJPxwR8H2Jv4P5ATJWKRs6zIERmN7idAsNhwKX3kcp6eE=
Received: from BL1PR13CA0414.namprd13.prod.outlook.com (2603:10b6:208:2c2::29)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 08:49:10 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::a6) by BL1PR13CA0414.outlook.office365.com
 (2603:10b6:208:2c2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.14 via Frontend
 Transport; Mon, 3 Jun 2024 08:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 08:49:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:49:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:49:09 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 03:49:01 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <Tim.Huang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 09/12] [PATCH 28/28] drm/amdgpu: remove dead code in
 cik_program_aspm
Date: Mon, 3 Jun 2024 16:49:00 +0800
Message-ID: <20240603084900.2570182-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: bb04d12f-c3c6-4039-f58d-08dc83aa0920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QiW58outzo0+NqSsjPwdEvr/IkRY5WjE1hHfWzZ3VcOy1eOz+gRVEyWlsDE/?=
 =?us-ascii?Q?l16rOJuHjpzx29poIgwP0b7rP6vUAgosZ2SRvDe6HDyzwATs4duGztXcZRtZ?=
 =?us-ascii?Q?bmdNBJHBjlpBYCDMZAvQN3josm3utnW9WJzSyGjJHKOgMGb3nExvxDUhgb1G?=
 =?us-ascii?Q?MIGCHYD4i7LyBoi9znW9qSprJ2U6AGB5gdHPYxoOnQAeo911Kq10gRDknR4L?=
 =?us-ascii?Q?PtZMiu+G3xAmpRGzn5wbn/gXugEJu0uSleKL5dxfDyXWW7P5A/1UZsn2AhRs?=
 =?us-ascii?Q?f2GDiMt6zZDgrQ7ccFtWi6w8jDcXJ88z2MSnWEqS/07CUoUGBCXUZAbhTHtq?=
 =?us-ascii?Q?+y4u5oGvH69LD7srKybQN0ZvI5K69kKrak9t53Owq5RMCMYT0VLGcssRT1TN?=
 =?us-ascii?Q?++2CzlOUf/Q7El37BMDWiofG9vt7bSmon0BHt0+CJsdRWRBq+W2P1gRQKxEp?=
 =?us-ascii?Q?fGEofenaTmVPdqKf5k1YDbPHQbCDHomWiwOLKTxB5k826QN9BfdTVV0nlwG4?=
 =?us-ascii?Q?452uKYBxX8c0fQtEBdMQ+Ply3DQgm/elNYJke4wE5DquA95sN6NDT68+U/w/?=
 =?us-ascii?Q?+97BYUqdPzFgqglrgm7UoCPQAx7J9NfcHoaWwlmRRRLGVaSiUN8rZDxQn+Fb?=
 =?us-ascii?Q?OfYSkw7tn3cfaxvUwZXRux60TWtO6U/PlhyRIGmt09bpXUZqWjDdF71ao9fr?=
 =?us-ascii?Q?U2HzqWIfCW97XNkDKSMf4JjSsAEROyNzDvI1JPVVapEqY7diHtIYCXlr58Pu?=
 =?us-ascii?Q?J3RGWywdofyvSdwxrya9tDnWU33RA5G7FlaeGLZYIUj5Xq6MYuvF5JLogz0P?=
 =?us-ascii?Q?4hreHYa5w+q1NQMktXZRKs16qm1Ec/3UWZuHupbW8/owUC07YHWzzeDzcVC3?=
 =?us-ascii?Q?+P98z+/E7j9LXHDjEkwxO1LndNK8VTJCxgttthUGQlyAhbjEmYWtncvhyBj7?=
 =?us-ascii?Q?8RyM1GD5jRF8s0JnDDAHicDkA7LqonDXF/Oc9TO9b5jdkflkXNIbTrglDEvK?=
 =?us-ascii?Q?kcG8SqjzCeQ7ZO7jwpdMaedmCe4cmdApOhK9b9fx8yBSF39KETHbfbtxcf8m?=
 =?us-ascii?Q?xirGZocRUOCh/4WCnDDG4esPEWSwbnQbFEjK/USJIPrk4FuQWDhcnvB3gcUb?=
 =?us-ascii?Q?IfQtSs9ODRRaaQF3z1ig1PNyZK8MM+Ug8Mxv8+dJSJAB91FBd/MVxVT1Os3B?=
 =?us-ascii?Q?EB4BfEAV/Rsb7AnBx1nhEPgFgeENmPEIK/9k37+gToQGZNoiRzbq4axLbX97?=
 =?us-ascii?Q?ritm4eyi7pYPwnbpi9j2N7TQORTjHYqf/I86/ZH/74PSAnY4cNhd6MSeajkb?=
 =?us-ascii?Q?Im9P6zZzLDDTGFH4GOnQ/iCr4QhoyDMrPb8uVcik9KDuR+dqYeCNFyea27lq?=
 =?us-ascii?Q?pxapaIrLOLCEe4nVemxNT7NJ2BjN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:49:10.0289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb04d12f-c3c6-4039-f58d-08dc83aa0920
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
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

Since disable_l1 is false, the else branch cannot be reached.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 5428fd4071b8..0ad736e775db 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1819,9 +1819,6 @@ static void cik_program_aspm(struct amdgpu_device *adev)
 					WREG32_SMC(ixMPLL_BYPASSCLK_SEL, data);
 			}
 		}
-	} else {
-		if (orig != data)
-			WREG32_PCIE(ixPCIE_LC_CNTL, data);
 	}
 
 	orig = data = RREG32_PCIE(ixPCIE_CNTL2);
-- 
2.25.1

