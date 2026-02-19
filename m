Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AA7E9A03B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 16:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E2CD10E707;
	Thu, 19 Feb 2026 16:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4DqVXhNJ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013031.outbound.protection.outlook.com
 [40.107.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A13310E707
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 16:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrnJ24Jt6g0oM0gYpjunYUnJ0UgwAYytFIuCDovJA3fowq1ewq9vTLMet4wBGtkQ7Jk7kqVpQRhLmChwaAk+lRFVZKwbREt/YL/XELsmAooUO5kSAWo7TXLTRx5Uc09f6QIfC/qYHxLMtXjsppeIx9ig1uaUXuhHBnClly9ufT34tIIh+m/pjSFE056gi2GasBqJAsp3Tyi6bc4IjDB2f97qLDWezrvckX5POUj4+E7/BSrEN1C86SEGcvSLh7ok/ykkeAfpiuBa3yO3Dizpm+wrQpxXZq2gnOfQ4+xtoL+LsftvD0eZUTIgPZCwWqJq0K5XxO64JBwDpKBW2RAqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Din0485YVQ+LwPWwKEiaIlih5gLge7bDTJHWl0hxojA=;
 b=sEJtZORI2kDtLFI4HPPnH+rlrsD9QXlmtP58nhw4553zCYSrui8xIlkgOSu6hz1GmWYYew3bnigfHO6PEAusbSlzPf/4AcpD9bej2btKZSC6JgwoMRw9pdMkip4mOz6W+VpryK5m2eGOQat1XZa6L9wNqAuiO7ZlPvvGwBoSLq8tnwqG1FbkcvOYaRSqHqcY5vwOY1ixpJowRAHf1ifzHH8u/01U2+dxSft/dNK4dTOiGbkCpRA8HPg27q4Z1ZOvVFq0ZCqdEReWg59NM0onkRvxZrzMmDtDQfxFsfeGqdIHn5luzT5ik510dG0RA2SsKuLPA0/K3RslDKd4iDqd+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Din0485YVQ+LwPWwKEiaIlih5gLge7bDTJHWl0hxojA=;
 b=4DqVXhNJTkiwPIuu6kVlMNzksn+ItzE9vcQDcXCqJiaVdiqqxxidHL32YE1GH8xrdcEp2t1N2S5ndXFENrWAPQF7kl/ip8SzNHVSr45/Tev4eZuwjSLmqXf1gZKJc7U6AG/zEj/AyNKqv7e3nCDQ453Wf1lR6/XJHan4FFcPCkk=
Received: from DS7PR06CA0021.namprd06.prod.outlook.com (2603:10b6:8:2a::23) by
 SN7PR12MB7155.namprd12.prod.outlook.com (2603:10b6:806:2a6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.14; Thu, 19 Feb 2026 16:07:39 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::b0) by DS7PR06CA0021.outlook.office365.com
 (2603:10b6:8:2a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Thu,
 19 Feb 2026 16:07:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 16:07:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 19 Feb
 2026 10:02:38 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Feb
 2026 10:02:38 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Feb 2026 10:02:37 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>
Subject: [PATCH 2/7] drm/amdgpu/sdma4.4: adjust SDMA limits
Date: Thu, 19 Feb 2026 11:02:19 -0500
Message-ID: <20260219160224.1976043-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219160224.1976043-1-alexander.deucher@amd.com>
References: <20260219160224.1976043-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SN7PR12MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd6aa2b-a54d-4162-ab9b-08de6fd10129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wbih4SwYFx6xXJTqTPem44l6qEuBFkmep3oJv83+4t/SF67p2FPllgY6RKXT?=
 =?us-ascii?Q?iMzDDHRyh2LwPMg0vHHP8+ASOUmmhxNiNeLl8c8s1T9Kg6P/wCGkeq/0IYCN?=
 =?us-ascii?Q?uecFi333khqNozNDIwYC5tRo+OSdKjr6GoaIe9nO0+dXdPQzNHGV//5hGY5H?=
 =?us-ascii?Q?d+bjMl4gjy9xX9Mvm/GiSNn/Sw9o0+Lqw789sG4ZGbZeR2OVAxi89yQrnLU0?=
 =?us-ascii?Q?t1rtlz/y5iAldmzvkvu6T3WCuan+sAczKAzC49jQA/fzEdFaM9npBI5OIpT2?=
 =?us-ascii?Q?0p5i8tYUoNdkm2zc74vG46QQKhP+dBvOFNZ6W9YAidWkZUxUMrPguFYJ1BRb?=
 =?us-ascii?Q?tiYDG8gSkJIiA514V45+BhSp9IsD8dB9nLCAilbg0vaKShjEOnPisFIPYn0Q?=
 =?us-ascii?Q?7jkI1GP1l2S3EXOkxeO7y6JBfT5du/lcLLmD+2bkfVOEGRKrrvbumyfX+PaY?=
 =?us-ascii?Q?qWbeseJDCi83df8bzaW+DaZ1Z61QWgBgL9PNqlYXvpzx+/HWMRsN3sLpC8Zr?=
 =?us-ascii?Q?WY0Eu1h4SRS8phPcRhv95vgH941MwsgqXF30PeBTi4kKzSI0LXY7b41s1vMB?=
 =?us-ascii?Q?N+tXYrUXMFUWHU65RA6SyhZz/H+MQtUsibxrUlIiFA4Dk/ys6iQke9t1ehr9?=
 =?us-ascii?Q?88pPGT6zcgl7eakQKMvbTgajmzNKtp91B0+VB8o44qvU3AZi4jWWwbxI4RJD?=
 =?us-ascii?Q?Qy52ubIhIRZRsfdfEPGBLQe6XQAQN1QebfgBxAWKCUlbIOssBYaQCBEkc0dT?=
 =?us-ascii?Q?8ZibIACr/GI+2M+8iVsbzoqjT0dE8uJB4ExJo1nO5v8Dh9mJ9+AX9H0RldUu?=
 =?us-ascii?Q?jvPixnoLNfyrMTPyLu+Tphh23phuKQmaYpIlnlkPVB4j89NCS5R1/OZu+d+1?=
 =?us-ascii?Q?biuQzFA1peLojN3CyBhXJ9dQbW85M+x6il77/CrJU5CLURvkkIX25t0wFUxI?=
 =?us-ascii?Q?QWEroP7i/XmIGkt3uOL9SooDds69zBlhqGKrYbYIvOKe6W8y41pj/LjrIbx5?=
 =?us-ascii?Q?xOD1D6SH3nbFnK0GulqA0er0wvqes9zRVzKXzclgheIujUSPmcV9ApN2ImyO?=
 =?us-ascii?Q?7aA2huT0HZXkZIdhAbVrTabUr8dZKWXEJGBdQ+o/G3V+bUHdV4J8XM+xiOl6?=
 =?us-ascii?Q?ljxPmT6mn0aSZ3l3ec7DS9FPIX0UVVOwn1WFsldAx7M9J+B4XYHiYADw1cRj?=
 =?us-ascii?Q?VwFS0SmT+SZSjyJl7Zse34VSupYB64bG9JICoJIzWtV1nuGP980CdRE4nMu7?=
 =?us-ascii?Q?Oef1cR03xfc50lR5W8Ja7C3f9ks1O5d3N1c4lbdX5sau6cLqQsWnPBAlE3JA?=
 =?us-ascii?Q?GLKKw2CtNIed52X4jJIKx1qbHzHFaoMb4TyKCiSyFw/LfRY/2OccBMjndi9W?=
 =?us-ascii?Q?cm4DfGxLD4XCJtX0IY+JPUmkHVP1x9yGAK2oNMeXmipRqLMV/jNpjSmuhmOE?=
 =?us-ascii?Q?hR4vPBIjlZILDUQcaZomNeIFiI3dNS4JPtb6xF8CpYT28kRRnBeaP8UcR0Zv?=
 =?us-ascii?Q?7pMWYYb5migbILZqZP9T3m54TJwZ0teSMTQEj1VwOfgcDnRLp/Swj00znFhL?=
 =?us-ascii?Q?kG9OxnPKFLISGXm4wxHpE+gqKdyY0i7WqhczOQOSw1/YhH3sb1HlPiKU9qaz?=
 =?us-ascii?Q?KZs4tsrI1zIfOKNClUWLW2e81UQ/5r8RmVuCdAstuXc8keAIv2GN5yA48irS?=
 =?us-ascii?Q?88HwjA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Njzf+e22zJQEA2f72O8p1q2Vi6LuWS8w+AM/6Zq9qE9f33tXLYVAaGXGIIXrnZdTq43aGFmdVAqIwgY3F9NT0IsWgAIitQ7ffx216RkjShsr/BdaD8LQkWV/FgTsT5xbeQ6TVajvIHzm8sZd7zW7qDlJY0ebXkrs8epsfncHqM8rHo3Ah2n5URAD1YVrMJvV74J74fLYB1oxlnRqSjibWuupBfNfkmwm5SgjyH3hLH8hoYFq/bxTAx2XgOCjPoIy/nnuj9kJ3sY56WkUwdXq6WB9cB93evKr9E854yjBwOboLk+FBZRCv6uh1XpY66mtTHlq97NdYMkrKIWZNg7vfxIxvcIxq8OW5/57mLpG2kdJaIeEEV+7nCSsbdsvDLFRUnVTGNMP7MV/rUI7dx0Htaw8MYLR7vJT3GlyN//UzpFZwJiQndwVjgT7P1xMB+JS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 16:07:39.0808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd6aa2b-a54d-4162-ab9b-08de6fd10129
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7155
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

SDMA 4.4.x has increased transfer limits.

v2: fix harder, use shifts to make it more obvious

Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 7f77367848d43..78bdfed0a7fd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2305,11 +2305,11 @@ static void sdma_v4_4_2_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v4_4_2_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v4_4_2_emit_copy_buffer,
 
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v4_4_2_emit_fill_buffer,
 };
-- 
2.53.0

