Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20A606A322
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nrnbMVoT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 082C310EA00;
	Mon, 16 Nov 2026 19:31:22 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013004.outbound.protection.outlook.com
 [40.107.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E51AC10EA00
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 19:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtcBTR7AXrNu0nEviRR9WCHTJraO+pRUXCMfyqBzW1g27dqAsxFF96OUCdT7L7d0nyoQtiyICSsWttOeAAtH737vcrYvTN1uA0F8x0K5vc2CSLpNuB3i7Qbdm1QfMT8ssti9SdULnpn9gpR0TFTBYb6WjHCscZRN7tbq88mmiXyo0eUcA4KCFuoGDdbi1EaCt+rmFAj8petu3J4r+P6zySFU5q6h1wH4O/i8vSUY44XdtwsV20oZc8Q8KRMCcFdHqWreLf94mwqZtbwpYd4uE0k3AY/bdDCoP+HLW+vFbvfkQO6frOP1z++ZfUYBuZT4x5hNEq+SFj1FOUxjcnKOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAz6N5zysT5ZDDRasW6vTYrgMgJnRnkMc33QKjIznhs=;
 b=PlifNbQUhdi8eNG2p+Wa2fouxrRcfdo6zCy1cwm6jVfmfWf5V1+OmBWZChaKyn5CVt3iCXZHcmNeNpltABIhEXr2zdhRm7ORJFr51vYh5uJEOqeJj2N+kRfv5wpemALt8o4BtS7g9a2nu5YCs7XPE6qmdciszGHFA++8DkrGEFj4wvyRiECRXlqkJYl1ifO9frYze1WkF1vRWS8+qZN3rXzLvGRQYJLD5D77sHTW7uPEFp5kN6M0iyNpUAJNEAFQ87lcHB6DoQyxDYVgm/vMg2fUaHwJyGYtesqs+F+Lf6kBWZVyzapXm1H11jBc1obSAKi/J/OOcM1EeveLHdzwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAz6N5zysT5ZDDRasW6vTYrgMgJnRnkMc33QKjIznhs=;
 b=nrnbMVoTPXG3gJcrGJPvikDznL6BaZiBZ7hH7trFvGwN62eESQVBFHzIpjKp3ez3LpK0UNnucF4DoqFJLAffjDHPB3QyZZSm4kmxWI4VU3n9GBw77KcK4+rHXQp+nuWm+5X6dsaYg1DgzlccRR8GBAdTIz6FaztGzVvPLWXHl80=
Received: from MW3PR05CA0027.namprd05.prod.outlook.com (2603:10b6:303:2b::32)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 19:29:09 +0000
Received: from MWH0EPF000DD30A.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::8f) by MW3PR05CA0027.outlook.office365.com
 (2603:10b6:303:2b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Mon, 16
 Nov 2026 19:29:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000DD30A.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 19:29:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 13:29:07 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 13:29:07 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Mon, 16 Nov 2026 13:29:06 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Harry Wentland <Harry.Wentland@amd.com>, James Lin
 <PingLei.Lin@amd.com>
Subject: [PATCH 0/2] drm/amd/display: sync blend mode property fixes from
 drm-next
Date: Mon, 16 Nov 2026 07:59:09 +0800
Message-ID: <20261116001326.2360302-1-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000DD30A:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7b303e-3f63-4207-1ba3-08df4417e290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|261021123027099003|10067099003|11063799006|56012099006|261009223027099003|261102123227099003|261021121427099003|18002099003;
X-Microsoft-Antispam-Message-Info: ePiiur9d4HaaGR0rfoJPxnyf30Uk8KXTMfyKMI+4FTzlvDs+RohdAELmRzBZvAUZKjQ6H8bTXQ/EdvQrydpcMkfW6w5IIJtI5AZcl7miN4VcZQ8uJUtFIG1QnyvoolalLJeThSq85RfYAkLov+CvKPB8oofk6xVGizZiklNwkF0Puzn8d5Ykg04idOp63CnEkZs0qk55RbWfMdZR8+mKj3bTTAR1TPpPu0tE7AIeCxeya5i83ejO9PTR9WIy+K+0SsI3L4RtXJYrKEJG73bmFWOTxh+PwQ9AF+6sXq7WDaMimQV0YBpBGg9IzyBMk4EZUS3CX5VSBBKflQYv2zwtg7dKK3yUg6VttYjRsN93iJJqphnUX8EkYKhP+gFaLuttwQVH2G5joGXAMkr2Hfd/+uEqCbNcj6P01eUishU447EwrsKOiRk9/jaAH3oJ3MY6Gcrdo3Jb1wQw2ryeW0niwsYPvCCzc9Rjnh91+fO0MpBl+9op6iUYIRpbsnDIXHUGWH6KEmMdZ+E7T9T30I+VW3wjSH9s2g6J9XIL8UBgIRUiWko9nsSOstwmKkDBd6QukD1YXEvTKbLS+4VO1ogr9oBLQiboTlUe519i9RjJxowyFc48QN24vgYn727ai3+RdY0BmWPo6ooyBI8uJEKFFGLfKuUX6SiXm5FumRWHvHLDb3UD2PLbxQmle710nIYzWppNx+m1xlF22p2dLGxygw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(261021123027099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(261102123227099003)(261021121427099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yAIAJwdtnzv1TwsLNmxxMVdiiC37M9iET9wGVZrz8fG02JUW+i3FOyqbqdC0C/FQdRJniqKnQv915A9ZQEmRIFCPrSBAGBOOBIgtWN30jDjTnd//qGJoDzeHTrx8lbfq7kfChJlJaYkL55DRustrc5sJb42a1FkZLC9+WXEdcNWNH0fcBzVWwDAIyTuK9QFfpCk4S7X+P3+TY4ewsrCyKIXGSIWSp5a7W4xVHG5tNfeNtbtL7jvARc9DNJ7oZFEnm0eoGy3pTKM6JpfA7qyYzc+HipOLUbFbQFiGxNQ3PYcQM3sLhV1xf6qJS16PDrkagvSQfnmKae0oLNxxYPvlWBL2EtFd1ne2gWmRTbATP2Z+/bhDxnm48OTwUoaqZKbARW3DqwbQGL0/nrWc4/5ePQeR3toFZraUIC+Lri9nqVG4ndBRiAV9jsXhnN1wGJyW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:29:08.4860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7b303e-3f63-4207-1ba3-08df4417e290
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000DD30A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sync two blend mode property fixes from drm-next to amd-staging-drm-next:

- drm/amd/display: fix missing blend-mode-prop warning for DCN
  (drm-next: f0c75da0a6b4)
- drm/amd/display: advertise PIXEL_NONE and PREMULTI blend mode for DCE
  (drm-next: 332ad707e38f)

Both patches are cherry-picked from drm-next without code changes.

Melissa Wen (2):
  drm/amd/display: fix missing blend-mode-prop warning for DCN
  drm/amd/display: advertise PIXEL_NONE and PREMULTI blend mode for DCE

 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 31 +++++++++++++++++--
 1 file changed, 28 insertions(+), 3 deletions(-)

-- 
2.43.0

