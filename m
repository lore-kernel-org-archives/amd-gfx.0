Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135BAC25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 15:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B02710E3FC;
	Tue, 28 May 2024 15:24:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ULCxYhrd";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CFD310E3FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 15:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMAwUssqp/0N49QzHlea1sO9Xk5P3EoHdnmq0EDt16KG3gO4PH/yTq1p/bbaRRK8bomnxY2BmEtfX7bCde4+r7Lt1RvfAPJIsrso5TXZcP6AsnG4zfqIQfsBrw+6djdjcdwJ4DqsiQJmgbGtSqnlSE7ILLA0l8hf1JQyNxiaXZtgTH7C0JCDhQZQ3lNn3IFr0euHKaPIULmXI5fTJmLoLL/lVif84F7QTUW0ji/Wsfv6NIuQUML5nH3QbYJpOhCwFESiYKKQ3COqzI5prbuuDwQdVzwIxMwcttguHJ3/CjfGEfy2NesSuxVtkyfH8ITfNY/3QoF76e+f6jycUPcsog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iH+/qyq3fHQKfKgrFFcPUT86CAotVifWdpZeYKWq2tw=;
 b=It7rQOdI0R9w+EcFjoynXqyaFILXRikC/y6tim/iq1RB0oTcpgSjPJ1vgkvNgXyjG8DUI3m/yYiEOl1ro+lZxjAtWheTJFOC/aFlEkD19J6G2T+K47kogGPfXirzum7Tthyw9wYmcamF2d4OUOvf5hasMSsh9EimpsEmLAc13FS8C7N3y6NOQefIq1gyYMys271v/C+HLAiUOKsM9quwgdhVbkt6VrUHk7E4frjOhMSFHOx/taBkeHy+V28DNiLuvl97T4oSEv4ArEjgdAgi8IbDCiccTkUoKGO/u0z8WLZcb6PKv4SWUVRSiQDq9O7EeiUeHiCGxZ92sh8dCIwE9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH+/qyq3fHQKfKgrFFcPUT86CAotVifWdpZeYKWq2tw=;
 b=ULCxYhrdpAKh09k76dZzSwhVZCucrkprEVf+npnF2Q5u8KBDudP11T93CJ8dPkqYHZHMUP/WlBNO+0D61tOiix2lcJp9ILCWN1rGg3BGGyx5L+pUGrJLZ8dtrZnq9Yrsdb8lU1TusPXzzzns6VRZRLb8esJPNsUW/JigP+usZiw=
Received: from BYAPR11CA0106.namprd11.prod.outlook.com (2603:10b6:a03:f4::47)
 by CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 15:24:26 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::6b) by BYAPR11CA0106.outlook.office365.com
 (2603:10b6:a03:f4::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Tue, 28 May 2024 15:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 15:24:25 +0000
Received: from birman-stx1-09-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 10:24:23 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <mlimonci@amd.com>, <benjamin.chan@amd.com>, <king.li@amd.com>,
 <bin.du@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix 'snprintf' output truncation warning
Date: Tue, 28 May 2024 11:24:06 -0400
Message-ID: <20240528152406.25208-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: d86dfc1d-b28f-44fb-7ff0-08dc7f2a4239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rUWk91sJqEtPqpRXxqBg7jcHVl36Jf9u30SYSdOhGJ/HSH+xS0EPtnBt4dLF?=
 =?us-ascii?Q?WqCTbtJwsvZdV9REHNX7tJntcK0nlqS7N3ce7+1o5iwxOSLcbV65wcfDtdvE?=
 =?us-ascii?Q?n7/uZ609M5xvTkMZJZydC4Hpmj4gMtYihntPliih5szziYHQw2RhgasZMi6z?=
 =?us-ascii?Q?IOe9FrVFuaeUw1w4b8E77W5JYMzTMFV0fPWUXZb8CR16LLIfgt2FZc+P2caP?=
 =?us-ascii?Q?spF3CUo/Q3TrljiHX/nyfLF5tBU8otH3Uojx4c8vWKJdsHAZE4x1tDUYbBwd?=
 =?us-ascii?Q?Aj+jXVJDj06qLScvzxZagssC3dUg6ug8lMijx4gMtvp4PAhfP3LoF0eWje8+?=
 =?us-ascii?Q?suyZbXDQOXTIJ060Y/jo8+PEmRgsF0UqnhYaRXF/SXcenghAKZFhdR0DRbg+?=
 =?us-ascii?Q?T1cbBEdP7DeMYRK6v+mk2ZuIv/5XdQzpJ0UWfH2dOotTJnoymPfNfDPSVKCH?=
 =?us-ascii?Q?yixd1oQNjBqoxRvPnWYSW94U2iuRMHZIDc8WWHNtkXrgzUwg+rXtyo3eLjL0?=
 =?us-ascii?Q?JA8pwmP6MiimBrH95LTubbzt8TwKleLSFpiJ8j+RgnL5BqTJAHv1vshynxNr?=
 =?us-ascii?Q?3MUy8DQppRAJ2DtGGSutXsXZozpeOE1umckHH3RdZFFiIfVgb7hT1CMRJ39V?=
 =?us-ascii?Q?6TtzNVI5KEl0k0ccUykk9xmKLNqEYr4268Qoj7dm2J/UsuARLJ3xSJR2KDYV?=
 =?us-ascii?Q?UP72IkyiUJXQWI5q7CPPophmAx9RmusbE6hvDTxEGTE1Dz7WcejXXXIy6xte?=
 =?us-ascii?Q?HiM2IfMK7cILKMDwqpAXezXsDYoOfRLApPZQNombvbYPOkl6B2v6blX8SL6d?=
 =?us-ascii?Q?WD6Nu7r5ncorvt5dUMLXXYUYkFCKn5kpkgJ5/UAwr0thGckXrVFDqH+X6rDR?=
 =?us-ascii?Q?TQXdwKVMoU0qDh1T2GyEZH9fUNpRas9VsHEJ+7HlhrpMrmwwG9uoQTk8g6rs?=
 =?us-ascii?Q?bYQJz9RUzQ+H+fVj/NeC6ifNBbGvi0/A1nLC+b1bgLK+NieanBz/oKp7U+LM?=
 =?us-ascii?Q?xekuretPHe5b1R5onQWfRz0aF2c3qXusQUa0vsEJgZtF7NaCQ4KIR3ywOQRJ?=
 =?us-ascii?Q?wcZgE2Qs5gRmF+gi5xfs4pXWmeGldwmDaRETWlpIW0IsinSju16hrYv3eLYz?=
 =?us-ascii?Q?/Xt5wp+V0hxgFByyzP0+ofV64ZPWl5LmmxPK/DELqGd9QQC+lw8jU2YymSOb?=
 =?us-ascii?Q?nZNAkFmltpPVxRYMtrKG4yFDOb32zK3sZPhiYPprMdxcYzuvjG8qgsHkJlEs?=
 =?us-ascii?Q?vvfc/wKlvFvZwmXGAdfL+TAgQVD8mFG7o9x1pe2uANLHuBPXSIcj2eCPd+72?=
 =?us-ascii?Q?nq/VGGRKVkTT0qm1p6G41BWwKtyjjiIejvJr1s6LnxLzBmUl2DHOHTgy6Yrn?=
 =?us-ascii?Q?gdATswQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 15:24:25.4467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86dfc1d-b28f-44fb-7ff0-08dc7f2a4239
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283
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

snprintf can truncate the output fw filename if the isp ucode_prefix
exceeds 29 characters. Knowing ISP ucode_prefix is in the format
isp_x_x_x, limiting the size of ucode_prefix[] to 10 characters
to fix the warning.

Fixes the below warning:

   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c: In function 'isp_early_init':
   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c:192:58: warning: 'snprintf'
   output may be truncated before the last format character
   [-Wformat-truncation=]
     192 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
         |                                                          ^
   In function 'isp_load_fw_by_psp',
       inlined from 'isp_early_init' at drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c:218:8:
   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c:192:9: note: 'snprintf' output between 12 and 41 bytes into a destination of size 40
     192 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 240408486d6b..2a3f4668cb9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -96,7 +96,7 @@ static int isp_resume(void *handle)
 static int isp_load_fw_by_psp(struct amdgpu_device *adev)
 {
 	const struct common_firmware_header *hdr;
-	char ucode_prefix[30];
+	char ucode_prefix[10];
 	char fw_name[40];
 	int r = 0;
 
-- 
2.34.1

