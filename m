Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D3F606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=R20UlyOf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E30810E3AA;
	Tue, 20 Oct 2026 19:48:44 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 454CE10E3AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 19:48:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onMVJkXi/q91QdZo3gPcURsTjGePIePyle9+mPXvySTwzNZp0OlG3RepyQ3SK5d4G4YQYJjP2CW9JedyMQ72VvDJQ5hAwOz1k/neSuIAohx1ZxHXii//Wy5xao5u9EckjDSsnzWAYCfA+03lts+N0ElWzNRIJrZrjLT/AYvI1X2dTu0Prfmyv95DAhslQJh7PMsPICo+Ul40P8g754mdti6x3RBHS/Qg9OB5YO9yKlaSoc9dgQK8PgqWOxfPxch/DnvOAWFAO7Py254zG448WV3+O6bt0oMVzO5MRuRWk62CiH5wpyzqTqNSmSlvKc+E4DNXJsaBtrBWo4/iJfvzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDFwfzJ/QELtxY/Le7mqqB3o/KaSr++TRNMpndPcjrw=;
 b=MTXv1Loe/KLJL3BDDuKyFG02Ull5aQS4dYoMA9VMTx4AL/MlGtPDt7bices3nvjqf/vGiW9WzSBhshnil/KncoZmsIq4yKSIUlNt2KEecuTtyQjEH3tA40N5AKfVGXd+3drYiWXQqz/67pXLIcGfFZJYj67pS+i1bBR2/C5IkM3WHZOWfI8n24OsXwum13fN0BhIpy7/xplOKOtHHNL25soKf3WOXVECWeJoQMMQnsk1nRPaihdUj6BiYOL788OozqoGCSQauZL+wNmCLr2/B1MZWh0OFB7Gdo/5bsqDXu70zoW/rCrIbR0aD3jl2aCWl/rYt5JPbvLcsQsuIi04Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDFwfzJ/QELtxY/Le7mqqB3o/KaSr++TRNMpndPcjrw=;
 b=R20UlyOfnyDbSAo0S2GKHbNpsSpGVJSC+T5dv6lxJI8mvHmpoalSBPXKDZsZHwfXmfK3oq/flHiwkmlSQdCaQPZ5Vxfb3iY6GsO1UUNaEIKSBCt9/Bz4YpbDpEnzXmNMGpAfMbcLdePwXXd6DxZ99VUnvRTxtDKodqHV/rHY5Yw=
Received: from CH5P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::15)
 by SACPR12MB439974.namprd12.prod.outlook.com (2603:10b6:806:540::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 19:48:15 +0000
Received: from CH01EPF000BE94F.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::48) by CH5P221CA0007.outlook.office365.com
 (2603:10b6:610:1f2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 19:48:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE94F.mail.protection.outlook.com (10.167.244.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 19:48:15 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 14:48:14 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tvrtko.Ursulin@igalia.com>
Subject: drm/amdgpu: v5 of LIST and CHANGE options for amdgpu userq 
Date: Tue, 20 Oct 2026 15:47:59 -0400
Message-ID: <20261020194801.506382-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94F:EE_|SACPR12MB439974:EE_
X-MS-Office365-Filtering-Correlation-Id: e35bbfad-ea6a-4c24-7fb3-08df2ee314fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|261009223027099003|10067099003|56012099006|18002099003|13003099007|11063799006;
X-Microsoft-Antispam-Message-Info: Ikk9XT0I1u/Mj/KiiSCl7HJaI3ich7eSL8h23738ZL3WBJSmjCBfWEEuFsGxTCmZPjbQv7TA4eZ01/76tMWXVnUTLITcDb/Z481T5VZa5QttGOGOKB5b5aJGU9z6ZmDkdTBC+3td9qFex1YQRpb1kPdKxeuV8Thk0l9Y0eebAwKFS0aOa/PQqddQqHxl1K6FZJHBE3fdOWhKTPpsi4ApKwX2vBNn90uiLX1c9xzl97UU517KABX7gM4zzJMC+W+Z+XnnOqKxC1rfiM9WxAi7q9ENZ/TfMDQQgn+ehKvyMCn/qwiZwS0dE5bw2UL4WJ7Ka/65sixtGwUF9zFKWvRJAl6XvgPNm1+xJtGdBeUriOa0pClBvoxbirdPPFrc35BhvphCC9dDCvF/q29IAc0oB7lTxsxGHyzreCusV2m9aYKvWobmFJTmbUZlRtsrIYc7vr/veNCdCOHL+bq6gdB0j0LuZTbL/heOMUVDuuz1cByEUoWleZJyAQSajG8CYvv11MTNhf95+nnL32uF12KJS1OhScpyzkGKhYGaMsuM1IxzAZr9vihCVYW4uuo3rV6sY43icPHHxUMr+XKP15R87F9ZTZSvE1ApadQv+6/9ZGljR3PyewOdPftzTlAVW2uudD4Xd+DDgGVnA7g7HpS8nFKLd38lXsyQW7qfrDZxCDFdo45DwDXVolUZWSLobcWyEXoRbqpfV9yQFcbEEb/rLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(261009223027099003)(10067099003)(56012099006)(18002099003)(13003099007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jgRwB+zypzYfvjHssTnSyqLSsdfu+l3QGWjqT64SuYxlWa8Kjq0bjzwhVCd5zi+mEKYgrSx1UY0pv8hsrnYUkStWWMw2ekQO03HaVk34ZM8alY+XWyCrV6bQNtmL1EwkfBYfTeYXH5V00lborz+d4Q343IH8g3Mkdo2npAAcwBzwDB2zkrqfgHcEePMHAGfhGrRsDZRfW2XLcGZ9s98pImjF96AQNLF0AwT1q77apd4HUxTu3V7HqLKLOAKc0N8y5YqAztgJ5wMnT0bmFmO+sFjg1RQhRz3pF0lppQS6mbM/fRd5gKEqZgu5Sl6KgiQk3uNozDFUj0nEp3HigorNCzwdsV6yXhkqANoIGNqI1zjK12X41Z+NblUOfOVXd4CeZGmvEnhvt4YYJKXaZKHsCfj4OIc3ssN1wo+p+0E7dBkLvoiWi5oPrrUAmIMnV8oK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 19:48:15.3256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e35bbfad-ea6a-4c24-7fb3-08df2ee314fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE94F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SACPR12MB439974
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

All comments on v4 have been addressed. In addition, there
are now igt tests 
(tests/amdgpu: tests for amdgpu userq list and change)
on igt-dev, and CRIU changes
(https://github.com/fdavid-amd/criu/tree/amdgpu-userq)
accompanying these changes


