Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50083C54E58
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Mar 2024 21:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B266510E654;
	Sat, 23 Mar 2024 21:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gs7u71dI";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF6710E654
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Mar 2024 21:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fx1t3wheCtuRXplSLM6PIR+ZVWR2zjT1GGo0vdkzRDHCsScfI/N1Erb39krOz4DId0k1XoIDKOUOI7iTTwxDMmaxpDMjkpL4HitbOl+BkL/mjNaQTsohnhwayHDMSP7xLGQ1v61jVL+CA6rGGDhIlWXTP9pGeWGPzdl3OUpjim9NOmlr1e5owxF4VSil4tlUBB1EzZPsvsT2YiHsGj0IsVQYheUan03rlP4KElrezfsc0C4fVqIG0KAGDk+ekVe09A/4x2X4J31fOb1ikWAkPsxAwxod8HbqABGiJiIZxO+WQaR4XPFmMs9mnhKat55JXaJbDiR4H5E8ascQO7w5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0frEz3tIcFTKxAWjRuLYRzOuLPSJogu9KlkJ8SQtT8=;
 b=Jgwjjc9ify8wsZhnQDuU5l5xh8dWkVQY8rdPwQlpiDgt73x1tL9tlXJRFl6h5WwQG2GpVBO4JC4H+JGMNOA0i6NhiRcQLwsl6gSlDxvxZoSr0k9MFNKcj86coUhFVwthCUAX6gvHkGCoaHyfDV4jBLXfRx4zcxT9gMeh0Xrd3ErLUr35XYb9XlLoqalh5jYaFC4dP/IHAjkbJ/qqoT7ZzecXWssRdEdQKVzTyK3X6pS2gM7rITgxK5XzTFEJ/MU30LZ6/L9wAkhfUx2OskrjmPEkhX3Luw3EAYmML6WR44jiK7xFOwpKCMAo8XWrZ8asn49J4ZZJjaBzYfvcLmkxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0frEz3tIcFTKxAWjRuLYRzOuLPSJogu9KlkJ8SQtT8=;
 b=gs7u71dI81WaSrzT+OUy8HQpl/KpfcZzHFTtkyDdLvjBypev35Z8DoIEgoRQrA81so7+H7u2vWc8uGU1v9zWuU8332uCN69l5+suTe44Sh5f1Io7mg+cL6E2w/BIHbG/WLieWL08UnFe6HJFLWo3CgFL2CxuxLRDepZXeNZLcuo=
Received: from CY5P221CA0131.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::15)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Sat, 23 Mar
 2024 21:39:28 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:1f:cafe::a6) by CY5P221CA0131.outlook.office365.com
 (2603:10b6:930:1f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Sat, 23 Mar 2024 21:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Sat, 23 Mar 2024 21:39:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 23 Mar
 2024 16:39:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/radeon: silence UBSAN warning
Date: Sat, 23 Mar 2024 17:39:01 -0400
Message-ID: <20240323213901.2638700-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: b23aa1da-5ef3-4279-6a0b-08dc4b81b719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJDtuBEIovjTjjV/VszOAKrhaF94oYqbfcxeP6fg5nUTlihx/l66AeOyEERevbqsvHF9Dbo5c1eMB/IDcOX3F/gAQg0sB3t6A31o+30JyToCAOBjxLbnaeVQk+LkH1jMjTtSEolvw6e0N8GfE0FbMxNYyet8PA1LfjQvUUEuy5gftJAZaH8zyWha5a2FxIv9yOGRmDzFD2tIt2BORiT3abRfVRyLCwMbKSqfmM0afSj2tfAi52ZhWgFG+8SM3MLw5/q32sn1lfG5tcmAMu0MzEnGQzOdknhM8yxilRx2JYD8B3P7lZLexHUf2rtDG9hQHfJfmKUAm87Ox7mHipI6wUf7KScHmH5by//bMhyWaqUF0q4KtLcA9s4q+W76XBA8Og+SdWlgB6y52SwGpQCZZm8EqdNKXxC7I1Y5N6K9Kjufx/KQFg7TBpAIEXosGGrdZvniPyKmDSDo65jysU/X2RfOKT6VVxxaj7jbBDIikqi4MOllehXkT8f55MHV21SPj8f5vO/uVyzUPxgBSLbYFpi4t8POxrEWKepJ5AvM1xEmC8bfL6pxZ7veUVASgq0PmoGq4PsRarveYOZvRbsk9Hed5tMg3FZJkgspD5CF03MC73Jrtpc7YA1VoYoUT0olAKEVUV/0EyiDfPAsF/7LshYFQFcotP4FZwS0FLGVD03LMwy5FIvFkicwjqjgx0TVSkx670Yh9cYqxaHONog8RaRfLSL1OaGCG2DNPIAeXNa/dbLn7lQ0wapLxFTfyxWb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2024 21:39:27.3434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b23aa1da-5ef3-4279-6a0b-08dc4b81b719
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
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

Convert a variable sized array from [1] to [].

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/radeon/pptable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/radeon/pptable.h
index 94947229888b..a7f9553b648b 100644
--- a/drivers/gpu/drm/radeon/pptable.h
+++ b/drivers/gpu/drm/radeon/pptable.h
@@ -432,7 +432,7 @@ typedef struct _ATOM_PPLIB_STATE_V2
       /**
       * Driver will read the first ucNumDPMLevels in this array
       */
-      UCHAR clockInfoIndex[1];
+      UCHAR clockInfoIndex[];
 } ATOM_PPLIB_STATE_V2;
 
 typedef struct _StateArray{
-- 
2.44.0

