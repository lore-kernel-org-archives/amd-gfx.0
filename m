Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975C9C28B28
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 01:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 383FC10E7E1;
	Thu, 13 Mar 2025 01:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mug9+Ayw";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6409E10E7E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 01:41:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIlVawY6Dru+9cVvDHZrOdVuTNJeBVkTskDazAud2MxA1KYmkOjzRwPGvSMfd/QS9NYKi785bxXpJ1qDlN16y27Hl1h9KNMLLixu0Dy8R1C2VYqOmXZnWiuUomW5MdpTjL1DPftW+9gmYNca6k3uMKITnaxs0fU1HuwdLoAWELb7rkr24fyEgKbyA2LUpAhn/ajut15r6/TU2MLufiF6dq7T5KQXMFN+22Aneu4R6WWZkFiZGWOjrLgCJ3oIOt+l26dkNSjb8KqZxi1RxdAfsV5MSkhrJ2c2AhaYcbcXx8iRqm4m0Dkf4wJvSEmr/PWpzbe/HET0pJQRaP4ThcJMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dnv29onbz+z3Ng1ZMFHAMyjnWKmgXARBr9ZNfqx08V4=;
 b=nTt5y0YVvyVIDNj1NAUo0iUi+Ul5Caqz4S+hBXyx9y/AFYAvMcbDHa9/GOk3ZNnBuWiLQd1cbDCTm4DJNSdeiqObGhA3JnbJlF1RaXT0/wgtDmetAhDj+g6ORppWPyW+EBdM4Hiubxl+kYBGqhAg+cIBJBE0LkbKJUf4plfm1YW8VOjEBDrEjj/o7+ixlziD1w3m982Nx3AzgvAfq7aupfvBas/bCzmjkj7cqWR7FpKTgZQPBLx/l1ZCtdI49Tn+VZ483LWaQzvnP8AksJYki6VfdWKzOus7cNcgtsrGoEtb+VgXKNu4oe/827Ap57RsDS5w1LoM9oBQ/lSeO025XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dnv29onbz+z3Ng1ZMFHAMyjnWKmgXARBr9ZNfqx08V4=;
 b=Mug9+Ayw9YyrPRVFOqvQoffJ7MQsreVCjJisGQtWLruj2uvUvKIav9pESztB4+pyKu+9MZBQNlC8RHqtQYGD18f9KCnSZss9+WG9hMjxY5uzGaZ3M3L4y0vDB/R1pmJ0f1bD2gLfFusNvnavgmlHBrro+RLWxWtrsGiWV8Ngk08=
Received: from BN9PR03CA0407.namprd03.prod.outlook.com (2603:10b6:408:111::22)
 by SJ0PR12MB7066.namprd12.prod.outlook.com (2603:10b6:a03:4ae::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 01:41:44 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::47) by BN9PR03CA0407.outlook.office365.com
 (2603:10b6:408:111::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Thu,
 13 Mar 2025 01:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 01:41:42 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 20:41:40 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tom.stdenis@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] add mes type in mes ring dump.
Date: Thu, 13 Mar 2025 09:40:21 +0800
Message-ID: <20250313014021.4163200-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|SJ0PR12MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 99baec4a-1788-4234-e5fe-08dd61d034f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uVSVUu2xgskxd8qQvtqZ/8q55ei9H2ZJfTB3mbvmTY/Z6rcAclXEWDhXvz8t?=
 =?us-ascii?Q?UyDMJMh/p9yAxvQdpnHMn6EF+hWLYAC8dusYqJn+ORgY3YB+lFHtC//Zxur+?=
 =?us-ascii?Q?TSVFlm5LxYRSCMtJV5GYj/rXDSdkH/IYRBCatpUV2FZAzKaYCGqsxAYGbvNm?=
 =?us-ascii?Q?jbio+Op880Fipk5IrJJWk6rksz+S06FO31UhzecaBAucB5YNkkP2gxcoN50U?=
 =?us-ascii?Q?anJ7JQsOVDa1PTDDrueGte5vJ4Wc0p8y67xPme19JenYtqcXBMyavM8xbUna?=
 =?us-ascii?Q?7hGwPSYLoMYIlIk5T/+sZNtKiFq4+2acnts/97aHZbah/W15SMF4IMJ9KRV8?=
 =?us-ascii?Q?EIxAitN6gawgQJHUW5tkcMlf1xNB5IorRoarCsY7MkIiNaoOlq42tKBArv9+?=
 =?us-ascii?Q?sNL5cmxx8NMPl2U1lKpO5/qEkDhGk7JaS4p75nNlC9W/GKud2spzTJHyHiyk?=
 =?us-ascii?Q?H05UTqBE/CPbL608d2ZgYTjH9PMb35iRQ38wqOFH2CvEM9tjURgsN7Wd6Lhh?=
 =?us-ascii?Q?v96gJAmC1qSbrOmYsFxaKR9+uv21cdMR6Flb+OW6o5bMjD9uBjgOZBTWsT0s?=
 =?us-ascii?Q?/ynmWZn7UVcUz809O3rKYWU3SEAVVSiWUt0+ial22rayEfr+QUYr8u0+mzys?=
 =?us-ascii?Q?PMPivkFbEnYW/SJf2QHco9ubCB4SHfHY8dRDvfiyIPwaRI+6nnGJfsh36zXj?=
 =?us-ascii?Q?5jWcSUdb5OHAhTCSlyumdPI47EXQAPe75zYiS6zQhjPt5nCK3jKjoJtIEbxX?=
 =?us-ascii?Q?I5fYkXTk59itR1rHnG3Dv/qNJzM0htH+kDsC3uhmejlXvUHW7DG6YEXqM1Oa?=
 =?us-ascii?Q?MkxXgziSTHPlPdTOnSvayO0gx5sZ64MwOwmNv4MmaW8PVfuyLOQS4ViMOW5k?=
 =?us-ascii?Q?rgZ0Is0GXvbTlXwjmz51WB9Y9uirFm+ouBc8U4mRI2dXvGBx8NA5kCGeblBb?=
 =?us-ascii?Q?v57HwbZI/CbVG5pCIDEly9By3DI5qFmzdSXDZHl54AjE5DlFI0SGN+3Qhuj+?=
 =?us-ascii?Q?RH484/9gUzU1kXtYpVD12vUPmfZeil7S4ztr9gxG53ZUY9PKuDLxk1kuhN1j?=
 =?us-ascii?Q?YdhjSnPp2Qw9btBdKVFCmQtgTIT5G4oJSK39uqS1Dp+F7lUgF0ww2CqRHhA3?=
 =?us-ascii?Q?QVSA2y9g8rY76uPrPAyJpSQNLTBZEZ+IaTOPpjAARCe41FgdhGrEuei5GZVa?=
 =?us-ascii?Q?LZC5Z5/Fa2FLC6Ngxy+1gfcZu2YVimufrVzd8N0mJW9Y2R8GWstwBJvAoFQI?=
 =?us-ascii?Q?sHaLXux459e4R9SbXdQeR8Iqqa4kQurmRUf5E23ZOdFDc6dX0kMMUusx3zFI?=
 =?us-ascii?Q?xT0RSkf9Q1elxIWBjVSteNzVn1tYoErU5jNTOBBoK7+Uo37xci47VpICUwxv?=
 =?us-ascii?Q?3f9Md6eQ2Yo+hQkwkqV4T8GjmUidcLXyCsUXIKEpnuqNslFnnPcXjELlyTeo?=
 =?us-ascii?Q?95eqE30OwhcN5qDtxNZCEszDMEXbMhzXkWa/ZftuTFZ53RGiciKa1g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 01:41:42.5566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99baec4a-1788-4234-e5fe-08dd61d034f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7066
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

According to MES API spec, type 0 means invald. Pass mes type in ring
dump function to avoid confusion like below:

[0x0@0x00000000 + 0x7200]       [        0x000400e1]    Opcode 0xe [MES_SCH_API_MISC] (64 words, type: 0, hdr: 0x400e1)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 src/lib/read_mes_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/lib/read_mes_stream.c b/src/lib/read_mes_stream.c
index 6146fd3b..b92ad9fc 100644
--- a/src/lib/read_mes_stream.c
+++ b/src/lib/read_mes_stream.c
@@ -295,7 +295,7 @@ struct umr_mes_stream *umr_mes_decode_stream_opcodes(struct umr_asic *asic, stru
 	ui->start_ib(ui, ib_addr, ib_vmid, 0, 0, 0, 0);
 	while (stream && opcodes-- && stream->nwords) {
 		opcode_name = STR_LOOKUP(mes_v10_opcodes, stream->opcode, "MES_UNK");
-		ui->start_opcode(ui, ib_addr, ib_vmid, 0, stream->opcode, 0, stream->nwords, opcode_name, stream->header, stream->words);
+		ui->start_opcode(ui, ib_addr, ib_vmid, stream->type, stream->opcode, 0, stream->nwords, opcode_name, stream->header, stream->words);
 
 		i = 0;
 		ib_addr += 4; // skip over header
-- 
2.43.0

