Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A6FC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 15:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E06D210F153;
	Wed,  8 Jul 2026 15:27:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2MCIqoLW";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B15D10F153
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 15:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4NoV7rmHcrKjhdywonIqNeTDOTw03ZleA5AGc6kFRsUKTi3T4dozh1MaXTEWxqjspRECwfD+ze9lDO2ul8jV5vWxq77Pvs0SMSeXKvQDl0Dp7dCvekqnqUNWku34wD9ThsHP/zcvahr8CYOIT1+bkrKxgz//bSCoKrq8oA9n1jK1MMDVno2iY9/hltleZVq67DGk6eaAOxDO34KnGxpdf5hMbrwUaiuoiOpP7ttQAcBX+awRDGOJBSVxaMv4+Rfbl20CdSXQAldIiBOXYsmyTok4AlS2+ZvQOpKsMuwBdA1bLLXT4iVHRpgQJuGp8H33DwL5xc3T3ZKCZTiwj4K4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZzEffPLUO1vHnaZlye+UjKgtF3hpTTU4RUpKsijJNs=;
 b=rFNPAl/oFAfm1361z3UwnCol+tRJEf/vcRRkCas5kaEQ6voYKRwOuTyQOV1iDfQ+wBxMjw2zEkmnKjz5O8reU41GwRKLPbOeWtCR8w2YMqFvV46CG8wPsq0yRXeWchwlJckkgjnz3StBfttEKtAg52zzsJ+BFAaeTDpLCqdNr/2yPl/goi7wQfl1eMI5VGUqanJn57cOOTlvhEWNd6m+evr/pK0NvNRmlBlR4uVU0oQT4dK2drFkuFaaCpBsHimtkSoM/WID8YrJqWbMh68JirvhCgxSG4wd78/x4r67/pB2Bvp5LeP/g4g2wBrbim/IqekULlHlEgJyUVAInbOm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZzEffPLUO1vHnaZlye+UjKgtF3hpTTU4RUpKsijJNs=;
 b=2MCIqoLW9/C0W9+ouWVl2RyLcz6M0UqJyhRartywKdV4JaoVqTpjIJY0VhQauEFUuyATMgaiWLTdLnRUe24TvCyRwtTsc9y9S3l9sAed9igMXJ6M7YFEQDdX3bK9iZ2eE+suOSHjlp7pux97nQx5bb9HmMrVkiC5PwKoM0wTEUw=
Received: from BN9PR03CA0432.namprd03.prod.outlook.com (2603:10b6:408:113::17)
 by SJ5PPFABE38415D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 15:27:47 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::86) by BN9PR03CA0432.outlook.office365.com
 (2603:10b6:408:113::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Wed, 8
 Jul 2026 15:27:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 15:27:46 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 8 Jul 2026 10:27:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 0/3] Add PASID to fpriv lookup infrastructure
Date: Wed, 8 Jul 2026 20:57:26 +0530
Message-ID: <20260708152729.3209550-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SJ5PPFABE38415D:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7b870c-a872-49c6-228f-08dedd057683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: fzqlg0OX58/f0khohZkdGbICklDBV3mUoiIdQSuomj6QogXGS46y1ceovlDD/pkkPE2crvf0VoeJ6K8EuMjIJX7mciOiABs2EUvKOGbp6fjaJkHOUVLT3oqnbCM8rPlyhtawVUR5TQHEXo3f4/Ls42yeS5CJFmoYOHw3lI6W0E/Ilpz6FpnfG6f5N+l6C+t/1A0OsNZ6f7UdTEGp/Y2CXLym+Ck3Vz2nAS9VQqsw4E3RnfoH/Af+SYvXJH5v4QTYME/Yhpp6fHZtcGoxWNBP32UiYCkxO841bkLP/sZJnBtKUJrEXuWbO7qGYEfaDJEOCvGEVbMeJjYiMTl4WwyYxWNu4YozpW8pEEiKVwfv8n5+0iuRVbuDCLQG3N7yeqGQGb8MSLbL7mPLY4nBpg7heHENa3NDsaiT94aYcMsv0hR3MlCc8rd030Hl7t04BY/AKJ8/jmbraHcz0OwTfeyRKvl5Xr/sLRrRqaaRkcFw9u58SSJ02j5GLpjslbQB/jVpQbgk+a0O0Z7ZdwvM5dolepWCUozq6lJJ/KIdK1cLbJPdv3ij6snLy7WCKJivPkKiy/ls/eKaEasc9NQd5e3Reub1slx6iYW6ov0HZf8hRItFa8tZvQrg/652nLzBilevVeorSHlFQhafTh9DA3IXHjJXCbhWrNSUxM5p/PYvio11DfkKH/LKScDqCc/Eth2fP/E9ZTVKWyypFVDmNFNzJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6YNYy4BaaYdtpUM1wmIm7oaa4DmrUx/qQNz4tnxW7S4fDtaxbFyc8NvvaUZFU6apiWYvGQlHxihYskkoykyt3+lWpCEQclvhKjajxitpwUqTadyUCvumBhupJASin0qmbY6Po30OFktt1bDGZOfZEz18eKnD7MMoLeX9Xc1o3CiHvGkxVRzGPp8MRc6b5xcUCWIY/hCNxWYQn6Ztb5aX6bWPN5bwC8hYzYeNpIwq5p/7c6CyTFid/96Z82bD6x6ae+4jsDYmteSJGQGgTBYC+zTDoGTk9uBXPlaAO1aOUsx9h19Srq5/VK8VUhzmhVb+jZ5vRT4Q77IrEP2jvyW1bgdJhEp/NRppVSx6DyaXPiDjEwq9LXAhII1+hnhmxnVcnOhoT1Z7NwHzpSvzBD9wcM0TfVWcUoiweqtb6FK2OLbdwwk9z6MmndJ0bazSvcHj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:27:46.5629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7b870c-a872-49c6-228f-08dedd057683
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFABE38415D
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

v5:
- Store NULL instead of xa_mk_value(0) for ownerless PASIDs.
- Simplify PASID owner clearing by unconditionally storing NULL.
- Delay DRM PASID allocation until after VM initialization so PASIDs
  are not published before the VM is fully initialized.
- Update documentation and commit messages to reflect the NULL owner
  semantics.

Only compilation tested.

Srinivasan Shanmugam (3):
  drm/amdgpu: Allow PASID allocator to store fpriv owner
  drm/amdgpu: Resolve VM through DRM PASID ownership
  drm/amdgpu: Drop vm_manager PASID to VM mapping

 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 69 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  6 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 21 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 65 ++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  4 --
 5 files changed, 109 insertions(+), 56 deletions(-)

-- 
2.34.1

