Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43147606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bLuSu8ap
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 794CB112366;
	Thu, 26 Nov 2026 11:35:56 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D42D112366
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 11:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2iHb1uXwnN9gESWpSM2n7KTFx3+AGs78qCyB+s2T3g3IHxW0Cl7WfUISvF4yvybIbWc+cyHONG3Za/YIUkbIg7chSF0qlF2lRa24EsMd2AZkt3IXec65/OizXruAUDpoMwGlh9KXYVvlIiUt/v7wsEznN8O2kP2u4oHxJc7wwqIkkiGng7gmaEjznpvcqtSD4oYCH7qVkrj1XQZzmmMQLoTN4RDVko/J4W4fqbc47Y5r69VowcdCQ/EAWMye75YX8+kOdmxSWeED5lnbfsT2y8S+VB9bW92gJmI7wgn4TLFcAbT8bQtTrj/I+oha7xA1OmLjRRoLq0WCbbumZ9/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EI2VPbw5jyOh3MoIgqM4Cscg7AV9xFVq/VmI/c6DyPU=;
 b=umjmA8KRAIw8wzkfu8UdNecJDKz1BbP4sEcB5Avco+NNPtAeOq8InFoYNWR8FqeA4+jhAcFVd9KwbnUFkj1/g9Gk/8NBhbGHDXLmfOT/sJJ7e+fefn1GHe/bg8Hc3Di1U7Axx9yh62Wim8nZy36o9sSjQ/vPDJxuS6ok5svq6eaDQRgj/ptzOQIQTTYGldal7mpiN7hO83AjY8DoMHiK2EAIJ7fqVCF114SXtS/Aq790iHVaBEyT7Bw9/42XF2UWlbyz00mSJ3MiYQNAWcp5w3TtetADJs6gA52+7ZuMEUNn7MDl0P1pIfc9gAyZbORLDHq+RE7JWRBe9IlObnih6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EI2VPbw5jyOh3MoIgqM4Cscg7AV9xFVq/VmI/c6DyPU=;
 b=bLuSu8aprulNdasAYKwvextYmJqSSFzjlLaavdOgGlwE2/yauXgXmnBn+lY85+NqOH/oT8Yy1H8aB3l+cCP+eCddmUzeB/Pd9nNfOl9s12KOJr017h8pjgRWAPuQAWFAKINjJEudEvUex7ZurTwgTuQquVeTSvroznjuh7ACKqo=
Received: from CH2PR10CA0021.namprd10.prod.outlook.com (2603:10b6:610:4c::31)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 11:35:45 +0000
Received: from CH1PEPF0005BD61.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::62) by CH2PR10CA0021.outlook.office365.com
 (2603:10b6:610:4c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 26
 Nov 2026 11:35:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0005BD61.mail.protection.outlook.com (10.167.244.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 11:35:45 +0000
Received: from satya-SPLINTER.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 05:35:42 -0600
From: Satyanarayana Yandapalli <Satyanarayana.Yandapalli@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Lijo.Lazar@amd.com>, <Kevin.Wang@amd.com>, <Christian.Koenig@amd.com>,
 <Satyanarayana.Yandapalli@amd.com>
CC: <Priya.Hosur@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH v1 0/1] drm/amd/pm: return -EOPNOTSUPP for pp_dpm_fclk on SMU
 v13.0.5
Date: Thu, 26 Nov 2026 17:05:16 +0530
Message-ID: <cover.1795606828.git.Satyanarayana.Yandapalli@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0005BD61:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: b6566678-c195-40f9-2f79-08df4bb16923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261021121427099003|261102123227099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: suQdK75TvftBCGlq2HZP5q3rpInMEIypKwCLerGcd/NIGHV8xYGw9LoDjMjG+FMKlcJM/JTUH5H8jXnbgFB40yKXPBSA9TQzWz1VUiEWUP0y3px4Gxpd0tLbnnJYmGmpystpdfDzvr9yG8b2peebAmP5A7EqlzdHSsRlBhEOWMOTSmtw5OGWTPgRQWICfnvdhZkhjXAxvRxSiu4Xuav0UsyOI2s1CTaHZNaWQGJHWHEBAlJkxvbI7aSf2gLBF36NwbzzzJTugAkRiL7HzuR8lXT2CpejeVDnbY6vMqb6Iju3X7v/jbGZHU8nm8N1Hy9k5quQuX1dRFxcQrfMKZtoHxFAaRjM5cbrswrRCq3+ozkQ9khdtO5GjcWMYi5wrBZzR/SNA78t5c+2ZkVPAmwsB6wUCFfmx4t6zqVopEKR50CvnOc+75CjGwQ56vPjdFKt6Rw1A84Z5R43neEKxys5nJmYKMz4CTVic2vRFcN6CTgPCEvO/3/TV9xvJB3mKeawXOj2MsIsB5L7Sua+5JBPb/cMGkO5nEeQgprzT6+/4qdRv0oZ0P4Ge2/zFFCxZg0aSQkALF4Qg+UF1rnWqqsZPBic8rcFuWKlrR3JYKsUopOL+KxcMDYeFhPwVLC6+QvaW2vxX0YQS0HB8w7tWvjqrn2dqu+8lhAuf4BlSBMEIWlcBVwPapQDYmWd3WBIk5XsvSoQ0ewBmIxiWC+cxvI26g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 27nBD4hGah193KqopjhiYA0v8j2FdDNu9PTHmwbLc1zBE3mPO4GYnLS/161pSVHEsswjhCCrW262jhAuEdkz5ei1ZQcm5g7TavF2++7dBE6B1iThZ1sM7PI+mzVi1+ORrhyEfU11rrVcAadtpEtDteTqY7+Qj+zJsrc5wj29xxBp/t9giFzeIvp2ju8QRvFO8zMWuHFPOLR4WcQAHAFyvsmfptsUN+a73aNISNUR6a2mN7TPmiDpJ0Dw43i9Ta0nnOFDEfUNmJif78yeZ4mDrqeHl0sb2oV7LnEN3SCRYdk7JGN/6iPSSUYAYWCnSm2Aq+Xv6PyLhD2BVuBgJRUpTe7DIuoaAeRcV5lX1WA6aP5zsiNPYjnWwlcDZuP2LGv3PMUGdMke4RHfGGk/zSehrFWRH19MxS9ftFFnyHiuC0Cnfv764drUQG+kCDCdv9m5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 11:35:45.4572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6566678-c195-40f9-2f79-08df4bb16923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0005BD61.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The pp_dpm_fclk sysfs node is expected to expose FCLK DPM information
when supported by the underlying SMU implementation.

On devices using SMU v13.0.5, FCLK information is not exposed through
SmuMetrics. As a result, the driver cannot retrieve a valid FCLK value
for userspace.

Before this change, reading pp_dpm_fclk returned an empty file, which
does not clearly indicate that the functionality is unsupported on the
platform.

Add explicit handling for SMU_FCLK in emit_clk_levels() and return
-EOPNOTSUPP when FCLK data is unavailable from firmware. This provides
a proper error notification to userspace instead of silently returning
an empty result.

Before:
  $ wc -c < /sys/bus/pci/devices/0000:06:00.0/pp_dpm_fclk
  1

  $ od -An -tx1 /sys/bus/pci/devices/0000:06:00.0/pp_dpm_fclk
   0a

After:
  $ wc -c < /sys/bus/pci/devices/0000:06:00.0/pp_dpm_fclk
  wc: 'standard input': Operation not supported

  $ od -An -tx1 /sys/bus/pci/devices/0000:06:00.0/pp_dpm_fclk
  od: '/sys/bus/pci/devices/0000:06:00.0/pp_dpm_fclk': Operation not supported

Satyanarayana Yandapalli (1):
  drm/amd/pm: return -EOPNOTSUPP for pp_dpm_fclk on SMU v13.0.5

 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.53.0

