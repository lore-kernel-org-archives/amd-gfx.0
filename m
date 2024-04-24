Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3B5C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 09:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9879811396A;
	Wed, 24 Apr 2024 09:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OdgfNnJK";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A52D11396A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 09:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwyn8oAQUc3WWpHpmx8eY88UTiE7wZnhbRmjNNOKJZHAdzXRDsDGMptPP5DgXGaCdRejKtPY/52l32p6JDIZO0NDh2jE2opcDOXpNNywt1uIcGGHhg9MHpzSKwHQ7EefJiUKXHMJSe/vTDjrpBeyL75XmP90fH2lVHWI372KMJBmsx9DXa4FTzuWTSE9tPdG6cJu7sJWSuwWj3ttNLwAtbatshXcwi7jqBNCEYmBtChlq7pNOlmNV6QfjB1ql4GEYO5jcEib1DV/8McBBkqDPDjtHA3NYUbLXIgSBbrat6yBhsN3Dw+Sw/LgpYzY5CX7ztVeLp+3CRJ6Ck21n5Fnng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksIZwdlBtwj9l5w9Yq0KTF9xI0yDbSy+l6M89tLU1A0=;
 b=JMVFMe/qvuhSgCVDje9ribiQ8G/BUjsw/KUuYLpsFnz6C0CZ4kUIpqe6apt+7HtycpqsUSLPYjKwz05cDNTeH+JBaZKTqGxqEZC88G9r1GiHxokOsf4vekq4m4YfFaFgZyhh2Uuva/mmjg4aMpPr41LziThrpWUI4jCz2/Fys0beQLuV/i81jOk5ekd5s1q37hH/NmSZKRZWK2OyxUQsZbnrZEbxmeD/dR4UMmhcPMX7d3RAO4WaPczd9SAmhNvWNasUyx710REAwBB9cFuv3kS7m4Wcsl+x/lPklxieva2JzgIwzPKT1XqeZG+qk/XrD8dbh1uMAxp3mDaHbgiEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksIZwdlBtwj9l5w9Yq0KTF9xI0yDbSy+l6M89tLU1A0=;
 b=OdgfNnJKEKGe9VtCSP6eqf+vUAIn7Q61w0uNAgen6prUDP9QHJQX0UoGyG8dG3ZBmQje++OXlzijo92d2oAuGT84vI5oD+bKcjFN3DM2h/mXHU8MrmMxm80R+VCifJf5z6bmpbw2PoCgqF/i4uGSxtokuY9cuukS/Wao3pAkeuw=
Received: from CH0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:610:b0::21)
 by SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 09:04:47 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::f4) by CH0PR03CA0016.outlook.office365.com
 (2603:10b6:610:b0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Wed, 24 Apr 2024 09:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 24 Apr 2024 09:04:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 04:04:46 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 04:04:34 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <leo.liu@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH 4/4 V2] drm/amdgpu: Using uninitialized value *size when
 calling amdgpu_vce_cs_reloc
Date: Wed, 24 Apr 2024 17:04:28 +0800
Message-ID: <20240424090428.752136-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c450ea8-1d2c-4113-236f-08dc643d96f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2x1azJncm5DcXNDVjlvL2FHSjlra1VEQlVZb0NGQ2Y4REttcWJxaEJjUUZk?=
 =?utf-8?B?UW9uVGNVZmgwbjd3T3VjdlNmSjZtSHA3NEZHUU96TlFlenoyaE5wa3NtNnU1?=
 =?utf-8?B?QjJkQ2dscVh0SmFtK3p1OGJPb3o0dGtNRWhvZDVHMGJFK3phbi9NWFIvanMw?=
 =?utf-8?B?dmNoeGJDT1k5RGRFTFNuVVF1UDNBTjJrNndlTGlHbHJncGxCQ3JpVFdONnQw?=
 =?utf-8?B?Yk1tbHNjakQzYXFGcjkzZVVXdnJnbXFGTGZ1L3paT0lGN2dmVWVjUUs3YXM5?=
 =?utf-8?B?SHdvUEtVZ01weXV0WHpOUThuQmhCdkMrd1I4cUZrdk1GaWZ5cWlEdEZpRHBX?=
 =?utf-8?B?SjV6QzVNTGxUdUl2T3dEQUM2UTl6dmp0N3gvVjh5dysxSnhaUzNoYk9ZeTNa?=
 =?utf-8?B?djZkbmRuNTFJdDNsMjFpVm93Skd3eU0xUnRlOER4dExrV2s3VTRKYlp6UTJZ?=
 =?utf-8?B?bmUvUTloMjVhbDRtbmd6QjZTYk1TZWMrSHFCZVNlVE8vbmhtY0l5SmhaZVZm?=
 =?utf-8?B?aHZ5bU5iSy9kcHJtc0ZzR00rZkF1WWtJUDhTY0xkeDNqZ3o1b0QvN2pyWDlx?=
 =?utf-8?B?eTdIcDlIanJsN2tvbVRYd1FSWEpZZGpkYm8yTlRqZUV5dDhYRkRlMjFLS2FZ?=
 =?utf-8?B?eXpSUmVSNGtNcWVuTndmaG8zVGUxYWw1aWdiVThJWnY2SlJBb1RuT0FUNWdt?=
 =?utf-8?B?WkNmQ3JLdEpjaVpab0dnSnJFaCt4RGlVeHNxWDVxVFpXUFRROU50ZjE5RlN6?=
 =?utf-8?B?M1VwUENJYnI0WjRESXVlMjNkOFM2VDZxVjRVL0JDTEdqeE5KVGwyU0NpY2JH?=
 =?utf-8?B?RHVTclR0bmtSYjR5a0dKTnl2ak1UcGp0azJNZkZJRWNxQ0hSSHdLRjdscExL?=
 =?utf-8?B?Z00ya3U4eGNaOHlRcStTU3RyZFNaZG5tV1Vwem5SM2ZBMmpiakgwV0hCNFk5?=
 =?utf-8?B?Tzk0S0hUbC9ZOTRYU2NnY3pxZFZvYTdZMi9kbW1xMlZNT2tlRVFTbHpTZlV5?=
 =?utf-8?B?akRUYmZUQ2hyRG1DTTNaTmZUVURsWWN1b2oxTC9kRWYzaGZPdTMyU2FVVUJD?=
 =?utf-8?B?ZDVhQkFiZGVyQzBCWUFyNVdGcDl1M1FnMjR4K1ZtWDBTaGl6dm9TOEtrSi9z?=
 =?utf-8?B?NU1RMGJ0Q3BMS1JRNUxRUitiZTVMVm9QRnJML1MzT0w1bWhpblFZcG9MbzYr?=
 =?utf-8?B?aVQ4ZXN0Nk5WcTNBK3hPY2NwZHVzejgxV09oVVFjcDQwSFpZM3VERGMyYk0r?=
 =?utf-8?B?QXVyVGhkSW5jMEoxT1ZCWnQ2YWgzZGcyS202eUg1VzVvUG5RSjJNUnI5NmU4?=
 =?utf-8?B?cCtRQnhxdlp2RFI2aWZiUjdXVjVOeWcxRVdKKzk5SmloN2FaSXVQLy9BL1px?=
 =?utf-8?B?OTVBQUNXbGIwM3RHUVpjV09UVkVEN0MyVStjYTJnVUJ2bEFmWlZzV0E1K0di?=
 =?utf-8?B?Nkk0aXUwc0h1RmFwc0crcndEUDVsMDlnZ2xjb2loazBUblJ3ditSMzR6emlo?=
 =?utf-8?B?bnJiQlh3aEFVcXVscXFMN2tHcTRnMUtqUWRpNjFpZWw3aEl1TGtkYStkT0M3?=
 =?utf-8?B?TXhSOWdUMHBOeG52WVBXNUgyUDlPZGlNQkZHbW9WdFRMR3NsMit4WEpVcEwx?=
 =?utf-8?B?VTFRMmdYTGkralN5TW5PWHpNbk9wMWdCVmhObjI5UFM4QXlDYzhiOWhDNzJF?=
 =?utf-8?B?NUFtNWhRSHpFZDFENzNZOVVPNXR0Q0Q3MXZDeGdLdTM3WFo5L25NemhkZElu?=
 =?utf-8?B?enJSNkxDV2tybUR4SFJZdHBlVXdpZ2U5UFB5Y1o3UE9BVlhaZUtvdHphUnpZ?=
 =?utf-8?Q?w0T8MYTA9axyzBotJFqRF9T9/VVKj/RW9WXOw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 09:04:46.7769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c450ea8-1d2c-4113-236f-08dc643d96f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372
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

Initialize the size before calling amdgpu_vce_cs_reloc, such as case 0x03000001.
V2: To really improve the handling we would actually
   need to have a separate value of 0xffffffff.(Christian)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 59acf424a078..968ca2c84ef7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -743,7 +743,8 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 	uint32_t created = 0;
 	uint32_t allocated = 0;
 	uint32_t tmp, handle = 0;
-	uint32_t *size = &tmp;
+	uint32_t dummy = 0xffffffff;
+	uint32_t *size = &dummy;
 	unsigned int idx;
 	int i, r = 0;
 
-- 
2.25.1

