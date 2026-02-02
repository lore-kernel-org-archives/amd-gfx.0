Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49701E7DF19
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 18:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D822D10E547;
	Mon,  2 Feb 2026 18:26:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EYpodK9s";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010059.outbound.protection.outlook.com
 [40.93.198.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 767CF10E548
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 18:26:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEw8JGj5VNibyz63+sLwFdIq2xOfAqUxf7BzqUZA28B9R3PDO3dygN1qk+75lo7s94H9T9MLE/qTS4aP/RtMxVWB4XgsiexK58vppcIhlwnk+eBSafqQyWmgxEn9eBVWqFXtbRFdQBDcO73iBFALhD4c3uIrwCw63eZPq6PWSw2fUjK9qJIHH/AIGj+iKLCQ+LMITQYk6nT1X3AAKfQOuZz05ZcWIDEi1Ben4XcvuNEeJNZED5n29qUfVES3JFuB21Yb/jDi2hQEoyvYpHN3lp2K7YYu63G+1Zc17IxqWY2wdJYNMCqM35LZ7u73WPXyJoDRmLUHju83trEqWsSjPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lW0HMZ9V6xGsSKccuEYePkFcipvJDjwiB5G9Iq3EZI=;
 b=XGbU+T7AqKhQDKJjP6PeZ3r8KvT9WiHnarl2eh502u1Lg5/5TMoirJ4/vOGEeB9UpLWmjaXk25WGBK2Uj8XGXzpvyE28KtctPtl7AdXVkQ3bvz94106KAz85SLCv5Vy9A4VTjOd+uLCTg71gvbQXFkx9p6s9Z517l9UCJwI4clsR4MKOflkxGJ33XLabbwvED50OaYLvKX3UWJcs3gonnuJdd55JFGeK6/6DhOAh9/jDqiHVJily6UkVfjY8IXrGUwHR/cZbgVeVc11tINF48q8V4eHOFicR7qIx04BUOaBp8VgyG4E1rfEGVHWCPGzd2l7p5SuM0Xdb5GLFERkuPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lW0HMZ9V6xGsSKccuEYePkFcipvJDjwiB5G9Iq3EZI=;
 b=EYpodK9sEo9cTcbk/u7JxFV0C3SZIDbneI2XBiDdet/3juH0sHFNwvdgfCTl+caLfsLDlFFftcYdrTfHnKXv8UzSna8/j7UPbZf767pfecK/Ei018hIthfQBfIvoK1mCEy8Q9mmR/xoFrHIRV9mFarV0mRqjmU4QCcZzBPyLTzQ=
Received: from CY5PR22CA0030.namprd22.prod.outlook.com (2603:10b6:930:16::14)
 by IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 18:26:51 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:16:cafe::85) by CY5PR22CA0030.outlook.office365.com
 (2603:10b6:930:16::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 18:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 18:26:49 +0000
Received: from sclement-ThinkStation-P8.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Feb 2026 12:26:48 -0600
From: Sunday Clement <Sunday.Clement@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <Felix.Kuehling@amd.com>, Sunday Clement <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Fix out-of-bounds write in kfd_event_page_set()
Date: Mon, 2 Feb 2026 13:26:19 -0500
Message-ID: <20260202182619.586640-1-Sunday.Clement@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: cfdee1bd-e5e6-43ca-6614-08de6288a129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GJSMAgK93EuP5uUJBaUMpbOg2GhYfh2QOGOqCMKGYVZMz5h+xlzjDUJ5ZGue?=
 =?us-ascii?Q?CdkdbGzNmqilz8Q0Exhn75Qcrz35mY7joXZWPC5trzT8Q0Eb6ey3CCNJ/Un5?=
 =?us-ascii?Q?okTWjvsOhzPIsFFbXV0KbWSvSsF8hO/Udqxjew5oVMnWfal5PA+02XdQA4Wt?=
 =?us-ascii?Q?3TViW/sxctumaafelpjOnBAQBOThoJuJj7igUGVO88yGFTkPaKxjs2MOyTuH?=
 =?us-ascii?Q?1jZyyV8TCHSbI5C7K7X5MvLFgneIjRD/Nyz5zs9/UAJIFw8srsXipAfBW1hw?=
 =?us-ascii?Q?KPXoIzu+lyFp0F7/5CHjATHxHtfSI1guQzMb1g/nB7dKO34TXLSeL0sCzNXE?=
 =?us-ascii?Q?3x65Qnk/vL57V0P5opDYUmIl7pZO5Z7NBid1vADABnKqoiy0QbQaPM6AXx7d?=
 =?us-ascii?Q?3ChrlDsYljoqgCRUCJVkpJ0jluAvHdMv1qzHXLlqq2RdMHHkfcOek0oHyyHF?=
 =?us-ascii?Q?KpZybouqUgtdkjsK5b+CeOxMX9yYnP/nN6gHzRVVaN5V1PmGTMfg2c6vpXjH?=
 =?us-ascii?Q?N1Egim3rpzFETewGejl7nJ0P0NP9OHjd2iGj5pq1vfzF7r1IGORWNbOfMVfF?=
 =?us-ascii?Q?4CjLBa6HobmpmvynBRSHQvdotWwPf8l9wTxJJag5QUFF9hE01Q9PZSO+/1TF?=
 =?us-ascii?Q?Q2tl8bC1F72aQqt7o7y0znywPEzdgONLcH6ip6OuNZfr00L6f+zhS+DKy4eZ?=
 =?us-ascii?Q?0l7dHgTqiSK6804yuC8unxRYt464uAtwrltbqrMZFoaJZJjukr/FNYOTPbV2?=
 =?us-ascii?Q?jE2vi0SkX+20YoyXJeEZPpQbxPdWmc4T6Vyhz1ZI9x9Dn0wreB8uyrZDDFE4?=
 =?us-ascii?Q?4hBAt6SROX0vtB9b3pOg4Tp+nwdKDed9HZRi0UAh11831scjhlj81ESRncKx?=
 =?us-ascii?Q?puwnFDURrs7VjCKrYQYPx1zTm47r7cAxMJ5T0I9cwaBYpy7FhjP5GlCRNGqu?=
 =?us-ascii?Q?3QHg4izTSNaAenta0BY8gxlzswJBjeycacpLcAlWDnpNj8QyGqFgsycdGbip?=
 =?us-ascii?Q?eZlNsrliu7oK8a0d/kGPbcKgTiswbefcmWmIZNcSG9YEqQ3OSAKm56BnAx/X?=
 =?us-ascii?Q?CSiumTtKj9QYdewQ7djLPTWaVfyZ9yBKFBEg8J49Nen7qLEKYwvmRLLgvPKM?=
 =?us-ascii?Q?vztVFrziUOeUkHGH02VBOIhNi0Yw+dpCLxykcm80rJtBmgMcD/qVrNF7glM2?=
 =?us-ascii?Q?/WboevKIYoDAvrwbXVBBvjZ8HeXrjIb87mkHiCUlGowFI9fAUFzXcJsf1ZJO?=
 =?us-ascii?Q?vA94SuNmmtefGtAU8O12ujqVrsRpWfvAJSjD9o7S3D33PjrJ7lzc9OrvOMW3?=
 =?us-ascii?Q?os1gFPNpscfGP0b74ZngbaEGnjSOeYx1yBBr7KAFOxM+JmRfpvYOt0PYk4KD?=
 =?us-ascii?Q?ELLrWhcscOWrrk2nrVyPTMK9/gRNi/LBWFF7T8F6HAlqz8vd2Pfcepk6ZtBu?=
 =?us-ascii?Q?bo4QJQS4saROgugojdVXUA4MUCqBeJ1pYGKgGe4DJ/SmRibqIdLdD6Q8ms5S?=
 =?us-ascii?Q?mI/pDM667jOjZQILpuWtmo+6XklTa+lTcTbMW7KJZUxnxB/sNy+g+leJnV2v?=
 =?us-ascii?Q?wr8CjsvqFgs/qi6/98kdxT1lQXtbfNTMVgJ0AupOw6JvFAql2m0HQ8797acW?=
 =?us-ascii?Q?gKuFfHY2CdxxXOoiF/RNIKk8NAoX34F8olsMQs2QbOwoJ2srPx+YIJsDcQmB?=
 =?us-ascii?Q?cKxUDw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UjEcUc2FKXLejvAY2sGkCq8j6yiqf+ed8nsF1rzlw+5VAZoMK5EyFYsxqagN5Lmght+r4VywnGFqlQmD6sP/qZbEsGCbR/u3eqYV3XMOpSdVrX+opoja22kuXGnHYzLrtVOJuiAwP6KGqrpz5K29e7kOQX/Ez1RL/Rkv8X3dLNelqT5zjKKWgRTGXCTkzt4w/ZYlX+zBTnDGXD4GCUAt559lfj46OY1PcRKqE5/d09DaF7Ba8SiIbXjy2s7lLrCdcC3zNT5IfWfDWXK84fEptt/KXUrCfJpM8eXhijWXHp4/+WIUPnmHRyVzczGCMEjXojOyoproVdL3hEIVR94C0ZiwkYsPDt61RJyznBRiWPyRWh0zPe5iPtimZguTCCpgKtZE0GiMEaeuvGE7tv/ZoSiXGI2ZZ8n6weXBEQUnZSFTEHD3de/O+QiVKLr1GhZA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 18:26:49.1242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdee1bd-e5e6-43ca-6614-08de6288a129
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140
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

The kfd_event_page_set() function writes KFD_SIGNAL_EVENT_LIMIT * 8
bytes via memset without checking the buffer size parameter. This allows
unprivileged userspace to trigger an out-of bounds kernel memory write
by passing a small buffer, leading to  potential privilege
escalation.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 1ad312af8ff0..bd93a28f1026 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -331,6 +331,12 @@ static int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
 	if (p->signal_page)
 		return -EBUSY;
 
+	if(size < KFD_SIGNAL_EVENT_LIMIT * 8) {
+        pr_err("Event page size %llu is too small, need at least %lu bytes\n",
+               size, KFD_SIGNAL_EVENT_LIMIT * 8);
+        return -EINVAL;
+	}
+
 	page = kzalloc(sizeof(*page), GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
-- 
2.43.0

