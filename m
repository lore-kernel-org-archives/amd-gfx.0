Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497ADC19F53
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EF3E10FF08;
	Mon, 29 Apr 2024 14:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sH9DBgJT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF0810F908
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keEEJ0/0lEDzuTN1gG69CXX2P+KvFtQFQ2gqAFyjXxMv2Tk/HGZGUvsbdhXzaJnGoYuFL370Kkzoj0FEBEOv5mnZ5AeGnIUi7Mnz6Knr5jsaoZzWaAEu2bqEwyawNzh/Iii2xPDX2qQGPdd+3gtuIDx52oi1vrzpTiHomwdMmJVabGh/yGbIDazcFo3IoxwO6CqnKfEcDTTtO+z/O/yx2tmpBqBpCtaZ4Z/ogaGsWoNfvlZXCglctZ0ef8c6LAoBrhN1N/JzBYHe/y/3mK0Phv79AJ3xyxobJGl9X/2WBS2mtWF1IzqLkS4ktHz8TnTdZnqSK2UUelZCCpPafkxS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKy1gwNpy8YIoRb7YhD/rjDD4OrcNE+eVbAQJOsdXvE=;
 b=eHDnDlOW9wTZzNJgkq/Us+sH2ExRxSb9ZPZNl+Mgs75qQ6sDt/Fr9tAGQkiWSz+Xighn/ewtOX7z8jVRzgTXKrHIPYzfeTwxYruCzhRg3MjH7EVxpdLSC0qVYmBAnw49wO60kqo3Qu2yRuM1qHeWcKkFPY05KSBqcwMkYKNwJm2n3UA/5adZdZNv61bRXzWO0xQCz1Ng5I4lGNbw3rFsokk0BZ+yQnyhiefx2WsSq19UoAQRCBC2/TXQ0Jd4+YuSJfSkjSnG7fm6rau07s7YHhceEEftIO+ncMKwlTXQh2RHhSmWqw61R5QzWybyQOMEv/iP0eG6a0y2GnSZisheWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKy1gwNpy8YIoRb7YhD/rjDD4OrcNE+eVbAQJOsdXvE=;
 b=sH9DBgJTFyf0KYg4iLHWiD2ZrvN+RX1j2g6gGfGF6LHF+sKbGZs9h5fBZRFH9COgvPRTc2/w3VLOXXSGYLYpFZpV9lZgkLcX+miSBzqzzFD3gFtIVX1T11FkEp4wFdAATLBv2UfJyKSZ8NwerTtcEZrshksJUzbmdmTzIMd+uz8=
Received: from BY5PR13CA0032.namprd13.prod.outlook.com (2603:10b6:a03:180::45)
 by IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:57:52 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::33) by BY5PR13CA0032.outlook.office365.com
 (2603:10b6:a03:180::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Mon, 29 Apr 2024 14:57:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:57:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:57:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Laurent Morichetti <laurent.morichetti@amd.com>, Lancelot Six
 <lancelot.six@amd.com>, Jonathan Kim <jonathan.kim@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 06/14] drm/amdkfd: enable missed single-step workaround for
 gfx12
Date: Mon, 29 Apr 2024 10:57:18 -0400
Message-ID: <20240429145726.3459450-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429145726.3459450-1-alexander.deucher@amd.com>
References: <20240429145726.3459450-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 7abe29e1-f4fd-4436-9e0a-08dc685cbe74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5iYQ3k5jqY3Jv+58gmk3GzhYht5dlhrovfrLAYXjwUDe4U+bVKlKpjJ1cHF3?=
 =?us-ascii?Q?XCIePT2IeWKxxZphpWsf55AjHenO6f/zWSK+BWKIrIuHgGu87GZ9WMhjpXWh?=
 =?us-ascii?Q?DdXv5o55aEdLjJQ9ibtP6hVaQUBfO1znxD1VxZK+pKeSumceJCjkCJQ2Qsd9?=
 =?us-ascii?Q?AWJz5j8fF4pBbqDD9dpoYZnycWXxRBKhkU0/XtiviI7d7s/m0Hf1h4TxfmB/?=
 =?us-ascii?Q?l8To2pvLW/NbCxrftRgdvFrg6LbPV+JYfLSQQTXQv5SKBRy1Xb5lNeHWlb8k?=
 =?us-ascii?Q?LzojednWKdqn6JMARObOEQHNtPe3RHhyJXiXyIT7L/sA6imqchQoy82dgK56?=
 =?us-ascii?Q?pMazxfwLUqp00uBIAV/0N8742xhLvpomV1ACYsh33rh4d6c+H9Hp1Bf+SBqX?=
 =?us-ascii?Q?3tOd97OPybp1Fk2v5x07kV7AjxzZmIbRYj7E9rfOvONT70ELBV/lQong7cQf?=
 =?us-ascii?Q?LcP4VLSEk+9b3KOwuxFFYClN9LPrvy6tMAihfXIpawh1u0h0iLt8i8Twxgjh?=
 =?us-ascii?Q?J5bb/UDK0+HAmHvSB6KFiIek32SEcIix0oYJgGM7XMPil+erAkj5tXiw9lEw?=
 =?us-ascii?Q?Oh24NlKvUHYGmaStdjVPYkhanV14cNZ0Gc5HuqfuHvygpbMWFhtCu2Tphzrn?=
 =?us-ascii?Q?d2WgtdaFrkvlNz/44MIEEkpOcz0FZ8+m10ge3I+jR6/+mS6eACDzv3TXfphD?=
 =?us-ascii?Q?2q78nFdimifDtmL5zjeTqLhM8cqewVoFP/MB2Uhr96gF5zv8QtS9/MpXpfb7?=
 =?us-ascii?Q?3T8xeKPVSYDFyZR5Cvn51lw7LfPNSa6fq16HQzcNDpvAnkQMXN6C2js4CzIN?=
 =?us-ascii?Q?wPalkYyuU6uvI3U+H3eMKtkq3zbJZn0O0cN7j3KD9mpuIbQNNc4wCaiDOSKt?=
 =?us-ascii?Q?+lKGI11ZPo9OA/SkZfXBo1bioz4+k5EzGxJ5sCqaHewYAAORl5m7DRNpTiz6?=
 =?us-ascii?Q?i6gap0Cl+nJ20scs7yw6db7IvDKHyb/81gH50/qooDjJbBqIYwY2NIQe2Grk?=
 =?us-ascii?Q?4a8cl3YQjmMtxtGzJgce1Kv6ig5fsFWSEcKMA1y3pJaq9Dj3Cx63gGTEDhcJ?=
 =?us-ascii?Q?Zrtn8HsnbJkfzXqmPNxFnq/aP1K7hBByLfaEIjY7BtjfKpTEGdAWr0qdq/eL?=
 =?us-ascii?Q?hT2mFFD8uI5bpz5YVlR/7QM+U22dzIoBNmL9KOc2SODYgyu9ULSRUJqvyedZ?=
 =?us-ascii?Q?DqWTtWg0HQ4N+RMPUulqReCTo8R9zQPcfIcoYu8H5QKBuijPPGWkNUjMO9rC?=
 =?us-ascii?Q?H0ODs/j3q8hPDAoV9QVG6bxNExNkLrmt7DuGus4t6ZPobFmp+CrZ/YJRyoAR?=
 =?us-ascii?Q?URmSIa+BfQA8RYvopYsnCYDhexp50Cfd52Dxjw4EaXKxQKLEt9cZe63jN78x?=
 =?us-ascii?Q?rm/Ui2Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:57:51.8080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abe29e1-f4fd-4436-9e0a-08dc685cbe74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433
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

From: Laurent Morichetti <laurent.morichetti@amd.com>

When trap_ctrl.trap_after_inst is set, it is possible for a wave to
enter the trap handler, after single-stepping an instruction and a
save_context is raised, with only save_context set in excp_flag_priv.

Because excp_flag_priv.trap_after_inst is not reliably set, we need to
use the missed single-step workaround for gfx12 as well.

Also add wave_start and wave_end as exceptions that should be handled
by the 2nd level trap handler.

Signed-off-by: Laurent Morichetti <laurent.morichetti@amd.com>
Tested-by: Lancelot Six <lancelot.six@amd.com>
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 783 +++++++++---------
 .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  20 +-
 2 files changed, 409 insertions(+), 394 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index b539ac814b867..73d3772cdb76b 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -3647,191 +3647,159 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx12_hex[] = {
-	0xbfa00001, 0xbfa00240,
+	0xbfa00001, 0xbfa00243,
 	0xb0804009, 0xb8f8f804,
 	0x9178ff78, 0x00008c00,
 	0xb8fbf811, 0x8b6eff78,
 	0x00004000, 0xbfa10008,
 	0x8b6eff7b, 0x00000080,
-	0xbfa20015, 0x8b6ea07b,
-	0xbfa2003e, 0xbf830010,
+	0xbfa20018, 0x8b6ea07b,
+	0xbfa20041, 0xbf830010,
 	0xb8fbf811, 0xbfa0fffb,
-	0x8b6eff7b, 0x00000050,
-	0xbfa2000d, 0xb8eef812,
+	0x8b6eff7b, 0x00000bd0,
+	0xbfa20010, 0xb8eef812,
 	0x8b6f8f7b, 0xbfa10002,
 	0x8c6eff6e, 0x00000080,
-	0xb8eff813, 0x8b6f6e6f,
-	0xbfa20005, 0x8b6eff6d,
-	0xf0000000, 0xbfa20002,
-	0x8b6ea07b, 0xbfa2002b,
-	0xbefa4d82, 0xbf89fc07,
-	0x84fa887a, 0xbf0d8f7b,
-	0xbfa10002, 0x8c7bff7b,
-	0xffff0000, 0xf4601bbd,
-	0xf8000010, 0xbf89fc07,
-	0x846e976e, 0x9177ff77,
-	0x00800000, 0x8c776e77,
-	0xf4603bbd, 0xf8000000,
-	0xbf89fc07, 0xf4603ebd,
-	0xf8000008, 0xbf89fc07,
-	0x8bee6e6e, 0xbfa10001,
-	0xbe80486e, 0x8b6eff6d,
-	0xf0000000, 0xbfa20009,
-	0xb8eef811, 0x8b6eff6e,
-	0x00000080, 0xbfa20007,
-	0x8c78ff78, 0x00004000,
-	0x80ec886c, 0x82ed806d,
-	0xbfa00002, 0x806c846c,
-	0x826d806d, 0x8b6dff6d,
-	0x0000ffff, 0x8bfe7e7e,
-	0x8bea6a6a, 0xb978f804,
-	0xbe804a6c, 0x8b6dff6d,
-	0x0000ffff, 0xbefa0080,
-	0xb97a0151, 0xbeee007e,
-	0xbeef007f, 0xbefe0180,
-	0xbefe4d84, 0xbf89fc07,
-	0x8b7aff7f, 0x04000000,
-	0x847a857a, 0x8c6d7a6d,
-	0xbefa007e, 0x8b7bff7f,
-	0x0000ffff, 0xbefe00c1,
-	0xbeff00c1, 0xee0a407a,
-	0x000c0000, 0x00000000,
-	0x7e000280, 0xbefe007a,
-	0xbeff007b, 0xb8fb0742,
-	0x847b997b, 0xb8fa3b05,
-	0x807a817a, 0xbf0d997b,
-	0xbfa20002, 0x847a897a,
-	0xbfa00001, 0x847a8a7a,
-	0xb8fb1e06, 0x847b8a7b,
-	0x807a7b7a, 0x8b7bff7f,
-	0x0000ffff, 0x807aff7a,
-	0x00000200, 0x807a7e7a,
-	0x827b807b, 0xd7610000,
-	0x00010870, 0xd7610000,
-	0x00010a71, 0xd7610000,
-	0x00010c72, 0xd7610000,
-	0x00010e73, 0xd7610000,
-	0x00011074, 0xd7610000,
-	0x00011275, 0xd7610000,
-	0x00011476, 0xd7610000,
-	0x00011677, 0xd7610000,
-	0x00011a79, 0xd7610000,
-	0x00011c7e, 0xd7610000,
-	0x00011e7f, 0xbefe00ff,
-	0x00003fff, 0xbeff0080,
+	0xb8eff813, 0x8b6e6e6f,
+	0xbfa20008, 0x8b6eff6d,
+	0xf0000000, 0xbfa20005,
+	0x8b6fff6f, 0x00000200,
+	0xbfa20002, 0x8b6ea07b,
+	0xbfa2002b, 0xbefa4d82,
+	0xbf89fc07, 0x84fa887a,
+	0xbf0d8f7b, 0xbfa10002,
+	0x8c7bff7b, 0xffff0000,
+	0xf4601bbd, 0xf8000010,
+	0xbf89fc07, 0x846e976e,
+	0x9177ff77, 0x00800000,
+	0x8c776e77, 0xf4603bbd,
+	0xf8000000, 0xbf89fc07,
+	0xf4603ebd, 0xf8000008,
+	0xbf89fc07, 0x8bee6e6e,
+	0xbfa10001, 0xbe80486e,
+	0x8b6eff6d, 0xf0000000,
+	0xbfa20009, 0xb8eef811,
+	0x8b6eff6e, 0x00000080,
+	0xbfa20007, 0x8c78ff78,
+	0x00004000, 0x80ec886c,
+	0x82ed806d, 0xbfa00002,
+	0x806c846c, 0x826d806d,
+	0x8b6dff6d, 0x0000ffff,
+	0x8bfe7e7e, 0x8bea6a6a,
+	0xb978f804, 0xbe804a6c,
+	0x8b6dff6d, 0x0000ffff,
+	0xbefa0080, 0xb97a0151,
+	0xbeee007e, 0xbeef007f,
+	0xbefe0180, 0xbefe4d84,
+	0xbf89fc07, 0x8b7aff7f,
+	0x04000000, 0x847a857a,
+	0x8c6d7a6d, 0xbefa007e,
+	0x8b7bff7f, 0x0000ffff,
+	0xbefe00c1, 0xbeff00c1,
 	0xee0a407a, 0x000c0000,
-	0x00004000, 0xd760007a,
-	0x00011d00, 0xd760007b,
-	0x00011f00, 0xbefe007a,
-	0xbeff007b, 0xbef4007e,
-	0x8b75ff7f, 0x0000ffff,
-	0x8c75ff75, 0x00040000,
-	0xbef60080, 0xbef700ff,
-	0x10807fac, 0xbef1007d,
-	0xbef00080, 0xb8f30742,
-	0x84739973, 0xbefe00c1,
-	0x857d9973, 0x8b7d817d,
-	0xbf06817d, 0xbfa20002,
-	0xbeff0080, 0xbfa00002,
-	0xbeff00c1, 0xbfa0000c,
-	0xbef600ff, 0x01000000,
-	0xc4068070, 0x008ce801,
-	0x00008000, 0xc4068070,
-	0x008ce802, 0x00010000,
-	0xc4068070, 0x008ce803,
-	0x00018000, 0xbfa0000b,
-	0xbef600ff, 0x01000000,
-	0xc4068070, 0x008ce801,
+	0x00000000, 0x7e000280,
+	0xbefe007a, 0xbeff007b,
+	0xb8fb0742, 0x847b997b,
+	0xb8fa3b05, 0x807a817a,
+	0xbf0d997b, 0xbfa20002,
+	0x847a897a, 0xbfa00001,
+	0x847a8a7a, 0xb8fb1e06,
+	0x847b8a7b, 0x807a7b7a,
+	0x8b7bff7f, 0x0000ffff,
+	0x807aff7a, 0x00000200,
+	0x807a7e7a, 0x827b807b,
+	0xd7610000, 0x00010870,
+	0xd7610000, 0x00010a71,
+	0xd7610000, 0x00010c72,
+	0xd7610000, 0x00010e73,
+	0xd7610000, 0x00011074,
+	0xd7610000, 0x00011275,
+	0xd7610000, 0x00011476,
+	0xd7610000, 0x00011677,
+	0xd7610000, 0x00011a79,
+	0xd7610000, 0x00011c7e,
+	0xd7610000, 0x00011e7f,
+	0xbefe00ff, 0x00003fff,
+	0xbeff0080, 0xee0a407a,
+	0x000c0000, 0x00004000,
+	0xd760007a, 0x00011d00,
+	0xd760007b, 0x00011f00,
+	0xbefe007a, 0xbeff007b,
+	0xbef4007e, 0x8b75ff7f,
+	0x0000ffff, 0x8c75ff75,
+	0x00040000, 0xbef60080,
+	0xbef700ff, 0x10807fac,
+	0xbef1007d, 0xbef00080,
+	0xb8f30742, 0x84739973,
+	0xbefe00c1, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20002, 0xbeff0080,
+	0xbfa00002, 0xbeff00c1,
+	0xbfa0000c, 0xbef600ff,
+	0x01000000, 0xc4068070,
+	0x008ce801, 0x00008000,
+	0xc4068070, 0x008ce802,
 	0x00010000, 0xc4068070,
-	0x008ce802, 0x00020000,
-	0xc4068070, 0x008ce803,
-	0x00030000, 0xb8f03b05,
-	0x80708170, 0xbf0d9973,
-	0xbfa20002, 0x84708970,
-	0xbfa00001, 0x84708a70,
-	0xb8fa1e06, 0x847a8a7a,
-	0x80707a70, 0x8070ff70,
-	0x00000200, 0xbef600ff,
-	0x01000000, 0x7e000280,
-	0x7e020280, 0x7e040280,
-	0xbefd0080, 0xbe804ec2,
-	0xbf94fffe, 0xd7610002,
-	0x0000fa71, 0x807d817d,
-	0xd7610002, 0x0000fa6c,
-	0x807d817d, 0x917aff6d,
-	0x80000000, 0xd7610002,
-	0x0000fa7a, 0x807d817d,
-	0xd7610002, 0x0000fa6e,
-	0x807d817d, 0xd7610002,
-	0x0000fa6f, 0x807d817d,
-	0xd7610002, 0x0000fa78,
-	0x807d817d, 0xb8faf811,
-	0xd7610002, 0x0000fa7a,
-	0x807d817d, 0xd7610002,
-	0x0000fa7b, 0x807d817d,
-	0xb8f1f801, 0xd7610002,
-	0x0000fa71, 0x807d817d,
-	0xb8f1f814, 0xd7610002,
-	0x0000fa71, 0x807d817d,
-	0xb8f1f815, 0xd7610002,
-	0x0000fa71, 0x807d817d,
-	0xb8f1f812, 0xd7610002,
-	0x0000fa71, 0x807d817d,
-	0xb8f1f813, 0xd7610002,
-	0x0000fa71, 0x807d817d,
-	0xb8faf802, 0xd7610002,
-	0x0000fa7a, 0x807d817d,
-	0xbefa50c1, 0xbfc70000,
-	0xd7610002, 0x0000fa7a,
-	0x807d817d, 0xbefe00ff,
-	0x0000ffff, 0xbeff0080,
+	0x008ce803, 0x00018000,
+	0xbfa0000b, 0xbef600ff,
+	0x01000000, 0xc4068070,
+	0x008ce801, 0x00010000,
 	0xc4068070, 0x008ce802,
-	0x00000000, 0xbefe00c1,
+	0x00020000, 0xc4068070,
+	0x008ce803, 0x00030000,
 	0xb8f03b05, 0x80708170,
 	0xbf0d9973, 0xbfa20002,
 	0x84708970, 0xbfa00001,
 	0x84708a70, 0xb8fa1e06,
 	0x847a8a7a, 0x80707a70,
+	0x8070ff70, 0x00000200,
 	0xbef600ff, 0x01000000,
-	0xbef90080, 0xbefd0080,
-	0xbf800000, 0xbe804100,
-	0xbe824102, 0xbe844104,
-	0xbe864106, 0xbe884108,
-	0xbe8a410a, 0xbe8c410c,
-	0xbe8e410e, 0xd7610002,
-	0x0000f200, 0x80798179,
-	0xd7610002, 0x0000f201,
-	0x80798179, 0xd7610002,
-	0x0000f202, 0x80798179,
-	0xd7610002, 0x0000f203,
-	0x80798179, 0xd7610002,
-	0x0000f204, 0x80798179,
-	0xd7610002, 0x0000f205,
-	0x80798179, 0xd7610002,
-	0x0000f206, 0x80798179,
-	0xd7610002, 0x0000f207,
-	0x80798179, 0xd7610002,
-	0x0000f208, 0x80798179,
-	0xd7610002, 0x0000f209,
-	0x80798179, 0xd7610002,
-	0x0000f20a, 0x80798179,
-	0xd7610002, 0x0000f20b,
-	0x80798179, 0xd7610002,
-	0x0000f20c, 0x80798179,
-	0xd7610002, 0x0000f20d,
-	0x80798179, 0xd7610002,
-	0x0000f20e, 0x80798179,
-	0xd7610002, 0x0000f20f,
-	0x80798179, 0xbf06a079,
-	0xbfa10007, 0xc4068070,
+	0x7e000280, 0x7e020280,
+	0x7e040280, 0xbefd0080,
+	0xbe804ec2, 0xbf94fffe,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xd7610002,
+	0x0000fa6c, 0x807d817d,
+	0x917aff6d, 0x80000000,
+	0xd7610002, 0x0000fa7a,
+	0x807d817d, 0xd7610002,
+	0x0000fa6e, 0x807d817d,
+	0xd7610002, 0x0000fa6f,
+	0x807d817d, 0xd7610002,
+	0x0000fa78, 0x807d817d,
+	0xb8faf811, 0xd7610002,
+	0x0000fa7a, 0x807d817d,
+	0xd7610002, 0x0000fa7b,
+	0x807d817d, 0xb8f1f801,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xb8f1f814,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xb8f1f815,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xb8f1f812,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xb8f1f813,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xb8faf802,
+	0xd7610002, 0x0000fa7a,
+	0x807d817d, 0xbefa50c1,
+	0xbfc70000, 0xd7610002,
+	0x0000fa7a, 0x807d817d,
+	0xbefe00ff, 0x0000ffff,
+	0xbeff0080, 0xc4068070,
 	0x008ce802, 0x00000000,
-	0x8070ff70, 0x00000080,
-	0xbef90080, 0x7e040280,
-	0x807d907d, 0xbf0aff7d,
-	0x00000060, 0xbfa2ffbb,
+	0xbefe00c1, 0xb8f03b05,
+	0x80708170, 0xbf0d9973,
+	0xbfa20002, 0x84708970,
+	0xbfa00001, 0x84708a70,
+	0xb8fa1e06, 0x847a8a7a,
+	0x80707a70, 0xbef600ff,
+	0x01000000, 0xbef90080,
+	0xbefd0080, 0xbf800000,
 	0xbe804100, 0xbe824102,
 	0xbe844104, 0xbe864106,
 	0xbe884108, 0xbe8a410a,
+	0xbe8c410c, 0xbe8e410e,
 	0xd7610002, 0x0000f200,
 	0x80798179, 0xd7610002,
 	0x0000f201, 0x80798179,
@@ -3850,275 +3818,308 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0xd7610002, 0x0000f20a,
 	0x80798179, 0xd7610002,
 	0x0000f20b, 0x80798179,
+	0xd7610002, 0x0000f20c,
+	0x80798179, 0xd7610002,
+	0x0000f20d, 0x80798179,
+	0xd7610002, 0x0000f20e,
+	0x80798179, 0xd7610002,
+	0x0000f20f, 0x80798179,
+	0xbf06a079, 0xbfa10007,
 	0xc4068070, 0x008ce802,
-	0x00000000, 0xbefe00c1,
-	0x857d9973, 0x8b7d817d,
-	0xbf06817d, 0xbfa20002,
-	0xbeff0080, 0xbfa00001,
-	0xbeff00c1, 0xb8fb4306,
-	0x8b7bc17b, 0xbfa10045,
-	0x8b7aff6d, 0x80000000,
-	0xbfa10042, 0x847b867b,
-	0x847b827b, 0xbef6007b,
-	0xb8f03b05, 0x80708170,
-	0xbf0d9973, 0xbfa20002,
-	0x84708970, 0xbfa00001,
-	0x84708a70, 0xb8fa1e06,
-	0x847a8a7a, 0x80707a70,
-	0x8070ff70, 0x00000200,
-	0x8070ff70, 0x00000080,
-	0xbef600ff, 0x01000000,
-	0xd71f0000, 0x000100c1,
-	0xd7200000, 0x000200c1,
-	0x16000084, 0x857d9973,
+	0x00000000, 0x8070ff70,
+	0x00000080, 0xbef90080,
+	0x7e040280, 0x807d907d,
+	0xbf0aff7d, 0x00000060,
+	0xbfa2ffbb, 0xbe804100,
+	0xbe824102, 0xbe844104,
+	0xbe864106, 0xbe884108,
+	0xbe8a410a, 0xd7610002,
+	0x0000f200, 0x80798179,
+	0xd7610002, 0x0000f201,
+	0x80798179, 0xd7610002,
+	0x0000f202, 0x80798179,
+	0xd7610002, 0x0000f203,
+	0x80798179, 0xd7610002,
+	0x0000f204, 0x80798179,
+	0xd7610002, 0x0000f205,
+	0x80798179, 0xd7610002,
+	0x0000f206, 0x80798179,
+	0xd7610002, 0x0000f207,
+	0x80798179, 0xd7610002,
+	0x0000f208, 0x80798179,
+	0xd7610002, 0x0000f209,
+	0x80798179, 0xd7610002,
+	0x0000f20a, 0x80798179,
+	0xd7610002, 0x0000f20b,
+	0x80798179, 0xc4068070,
+	0x008ce802, 0x00000000,
+	0xbefe00c1, 0x857d9973,
 	0x8b7d817d, 0xbf06817d,
-	0xbefd0080, 0xbfa20013,
-	0xbe8300ff, 0x00000080,
+	0xbfa20002, 0xbeff0080,
+	0xbfa00001, 0xbeff00c1,
+	0xb8fb4306, 0x8b7bc17b,
+	0xbfa10045, 0x8b7aff6d,
+	0x80000000, 0xbfa10042,
+	0x847b867b, 0x847b827b,
+	0xbef6007b, 0xb8f03b05,
+	0x80708170, 0xbf0d9973,
+	0xbfa20002, 0x84708970,
+	0xbfa00001, 0x84708a70,
+	0xb8fa1e06, 0x847a8a7a,
+	0x80707a70, 0x8070ff70,
+	0x00000200, 0x8070ff70,
+	0x00000080, 0xbef600ff,
+	0x01000000, 0xd71f0000,
+	0x000100c1, 0xd7200000,
+	0x000200c1, 0x16000084,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbefd0080,
+	0xbfa20013, 0xbe8300ff,
+	0x00000080, 0xbf800000,
+	0xbf800000, 0xbf800000,
+	0xd8d80000, 0x01000000,
+	0xbf890000, 0xc4068070,
+	0x008ce801, 0x00000000,
+	0x807d037d, 0x80700370,
+	0xd5250000, 0x0001ff00,
+	0x00000080, 0xbf0a7b7d,
+	0xbfa2fff3, 0xbfa00012,
+	0xbe8300ff, 0x00000100,
 	0xbf800000, 0xbf800000,
 	0xbf800000, 0xd8d80000,
 	0x01000000, 0xbf890000,
 	0xc4068070, 0x008ce801,
 	0x00000000, 0x807d037d,
 	0x80700370, 0xd5250000,
-	0x0001ff00, 0x00000080,
+	0x0001ff00, 0x00000100,
 	0xbf0a7b7d, 0xbfa2fff3,
-	0xbfa00012, 0xbe8300ff,
-	0x00000100, 0xbf800000,
-	0xbf800000, 0xbf800000,
-	0xd8d80000, 0x01000000,
-	0xbf890000, 0xc4068070,
-	0x008ce801, 0x00000000,
-	0x807d037d, 0x80700370,
-	0xd5250000, 0x0001ff00,
-	0x00000100, 0xbf0a7b7d,
-	0xbfa2fff3, 0xbefe00c1,
-	0x857d9973, 0x8b7d817d,
-	0xbf06817d, 0xbfa20004,
-	0xbef000ff, 0x00000200,
-	0xbeff0080, 0xbfa00003,
-	0xbef000ff, 0x00000400,
-	0xbeff00c1, 0xb8fb3b05,
-	0x807b817b, 0x847b827b,
-	0x857d9973, 0x8b7d817d,
-	0xbf06817d, 0xbfa2001b,
+	0xbefe00c1, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20004, 0xbef000ff,
+	0x00000200, 0xbeff0080,
+	0xbfa00003, 0xbef000ff,
+	0x00000400, 0xbeff00c1,
+	0xb8fb3b05, 0x807b817b,
+	0x847b827b, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa2001b, 0xbef600ff,
+	0x01000000, 0xbefd0084,
+	0xbf0a7b7d, 0xbfa10040,
+	0x7e008700, 0x7e028701,
+	0x7e048702, 0x7e068703,
+	0xc4068070, 0x008ce800,
+	0x00000000, 0xc4068070,
+	0x008ce801, 0x00008000,
+	0xc4068070, 0x008ce802,
+	0x00010000, 0xc4068070,
+	0x008ce803, 0x00018000,
+	0x807d847d, 0x8070ff70,
+	0x00000200, 0xbf0a7b7d,
+	0xbfa2ffeb, 0xbfa0002a,
 	0xbef600ff, 0x01000000,
 	0xbefd0084, 0xbf0a7b7d,
-	0xbfa10040, 0x7e008700,
+	0xbfa10015, 0x7e008700,
 	0x7e028701, 0x7e048702,
 	0x7e068703, 0xc4068070,
 	0x008ce800, 0x00000000,
 	0xc4068070, 0x008ce801,
-	0x00008000, 0xc4068070,
-	0x008ce802, 0x00010000,
+	0x00010000, 0xc4068070,
+	0x008ce802, 0x00020000,
 	0xc4068070, 0x008ce803,
-	0x00018000, 0x807d847d,
-	0x8070ff70, 0x00000200,
+	0x00030000, 0x807d847d,
+	0x8070ff70, 0x00000400,
 	0xbf0a7b7d, 0xbfa2ffeb,
-	0xbfa0002a, 0xbef600ff,
-	0x01000000, 0xbefd0084,
-	0xbf0a7b7d, 0xbfa10015,
-	0x7e008700, 0x7e028701,
-	0x7e048702, 0x7e068703,
+	0xb8fb1e06, 0x8b7bc17b,
+	0xbfa1000d, 0x847b837b,
+	0x807b7d7b, 0xbefe00c1,
+	0xbeff0080, 0x7e008700,
 	0xc4068070, 0x008ce800,
-	0x00000000, 0xc4068070,
-	0x008ce801, 0x00010000,
-	0xc4068070, 0x008ce802,
-	0x00020000, 0xc4068070,
-	0x008ce803, 0x00030000,
-	0x807d847d, 0x8070ff70,
-	0x00000400, 0xbf0a7b7d,
-	0xbfa2ffeb, 0xb8fb1e06,
-	0x8b7bc17b, 0xbfa1000d,
-	0x847b837b, 0x807b7d7b,
-	0xbefe00c1, 0xbeff0080,
-	0x7e008700, 0xc4068070,
-	0x008ce800, 0x00000000,
-	0x807d817d, 0x8070ff70,
-	0x00000080, 0xbf0a7b7d,
-	0xbfa2fff7, 0xbfa0016b,
-	0xbef4007e, 0x8b75ff7f,
-	0x0000ffff, 0x8c75ff75,
-	0x00040000, 0xbef60080,
-	0xbef700ff, 0x10807fac,
-	0xbef1007f, 0xb8f20742,
-	0x84729972, 0x8b6eff7f,
-	0x04000000, 0xbfa1003c,
+	0x00000000, 0x807d817d,
+	0x8070ff70, 0x00000080,
+	0xbf0a7b7d, 0xbfa2fff7,
+	0xbfa0016b, 0xbef4007e,
+	0x8b75ff7f, 0x0000ffff,
+	0x8c75ff75, 0x00040000,
+	0xbef60080, 0xbef700ff,
+	0x10807fac, 0xbef1007f,
+	0xb8f20742, 0x84729972,
+	0x8b6eff7f, 0x04000000,
+	0xbfa1003c, 0xbefe00c1,
+	0x857d9972, 0x8b7d817d,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00001,
+	0xbeff00c1, 0xb8ef4306,
+	0x8b6fc16f, 0xbfa10031,
+	0x846f866f, 0x846f826f,
+	0xbef6006f, 0xb8f83b05,
+	0x80788178, 0xbf0d9972,
+	0xbfa20002, 0x84788978,
+	0xbfa00001, 0x84788a78,
+	0xb8ee1e06, 0x846e8a6e,
+	0x80786e78, 0x8078ff78,
+	0x00000200, 0x8078ff78,
+	0x00000080, 0xbef600ff,
+	0x01000000, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbefd0080, 0xbfa2000d,
+	0xc4050078, 0x0080e800,
+	0x00000000, 0xbf8903f7,
+	0xdac00000, 0x00000000,
+	0x807dff7d, 0x00000080,
+	0x8078ff78, 0x00000080,
+	0xbf0a6f7d, 0xbfa2fff4,
+	0xbfa0000c, 0xc4050078,
+	0x0080e800, 0x00000000,
+	0xbf8903f7, 0xdac00000,
+	0x00000000, 0x807dff7d,
+	0x00000100, 0x8078ff78,
+	0x00000100, 0xbf0a6f7d,
+	0xbfa2fff4, 0xbef80080,
 	0xbefe00c1, 0x857d9972,
 	0x8b7d817d, 0xbf06817d,
 	0xbfa20002, 0xbeff0080,
 	0xbfa00001, 0xbeff00c1,
-	0xb8ef4306, 0x8b6fc16f,
-	0xbfa10031, 0x846f866f,
-	0x846f826f, 0xbef6006f,
+	0xb8ef3b05, 0x806f816f,
+	0x846f826f, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa2002c, 0xbef600ff,
+	0x01000000, 0xbeee0078,
+	0x8078ff78, 0x00000200,
+	0xbefd0084, 0xbf0a6f7d,
+	0xbfa10061, 0xc4050078,
+	0x008ce800, 0x00000000,
+	0xc4050078, 0x008ce801,
+	0x00008000, 0xc4050078,
+	0x008ce802, 0x00010000,
+	0xc4050078, 0x008ce803,
+	0x00018000, 0xbf8903f7,
+	0x7e008500, 0x7e028501,
+	0x7e048502, 0x7e068503,
+	0x807d847d, 0x8078ff78,
+	0x00000200, 0xbf0a6f7d,
+	0xbfa2ffea, 0xc405006e,
+	0x008ce800, 0x00000000,
+	0xc405006e, 0x008ce801,
+	0x00008000, 0xc405006e,
+	0x008ce802, 0x00010000,
+	0xc405006e, 0x008ce803,
+	0x00018000, 0xbf8903f7,
+	0xbfa0003d, 0xbef600ff,
+	0x01000000, 0xbeee0078,
+	0x8078ff78, 0x00000400,
+	0xbefd0084, 0xbf0a6f7d,
+	0xbfa10016, 0xc4050078,
+	0x008ce800, 0x00000000,
+	0xc4050078, 0x008ce801,
+	0x00010000, 0xc4050078,
+	0x008ce802, 0x00020000,
+	0xc4050078, 0x008ce803,
+	0x00030000, 0xbf8903f7,
+	0x7e008500, 0x7e028501,
+	0x7e048502, 0x7e068503,
+	0x807d847d, 0x8078ff78,
+	0x00000400, 0xbf0a6f7d,
+	0xbfa2ffea, 0xb8ef1e06,
+	0x8b6fc16f, 0xbfa1000f,
+	0x846f836f, 0x806f7d6f,
+	0xbefe00c1, 0xbeff0080,
+	0xc4050078, 0x008ce800,
+	0x00000000, 0xbf8903f7,
+	0x7e008500, 0x807d817d,
+	0x8078ff78, 0x00000080,
+	0xbf0a6f7d, 0xbfa2fff6,
+	0xbeff00c1, 0xc405006e,
+	0x008ce800, 0x00000000,
+	0xc405006e, 0x008ce801,
+	0x00010000, 0xc405006e,
+	0x008ce802, 0x00020000,
+	0xc405006e, 0x008ce803,
+	0x00030000, 0xbf8903f7,
 	0xb8f83b05, 0x80788178,
 	0xbf0d9972, 0xbfa20002,
 	0x84788978, 0xbfa00001,
 	0x84788a78, 0xb8ee1e06,
 	0x846e8a6e, 0x80786e78,
 	0x8078ff78, 0x00000200,
-	0x8078ff78, 0x00000080,
-	0xbef600ff, 0x01000000,
-	0x857d9972, 0x8b7d817d,
-	0xbf06817d, 0xbefd0080,
-	0xbfa2000d, 0xc4050078,
-	0x0080e800, 0x00000000,
-	0xbf8903f7, 0xdac00000,
-	0x00000000, 0x807dff7d,
-	0x00000080, 0x8078ff78,
-	0x00000080, 0xbf0a6f7d,
-	0xbfa2fff4, 0xbfa0000c,
-	0xc4050078, 0x0080e800,
-	0x00000000, 0xbf8903f7,
-	0xdac00000, 0x00000000,
-	0x807dff7d, 0x00000100,
-	0x8078ff78, 0x00000100,
-	0xbf0a6f7d, 0xbfa2fff4,
-	0xbef80080, 0xbefe00c1,
-	0x857d9972, 0x8b7d817d,
-	0xbf06817d, 0xbfa20002,
-	0xbeff0080, 0xbfa00001,
-	0xbeff00c1, 0xb8ef3b05,
-	0x806f816f, 0x846f826f,
-	0x857d9972, 0x8b7d817d,
-	0xbf06817d, 0xbfa2002c,
+	0x80f8ff78, 0x00000050,
 	0xbef600ff, 0x01000000,
-	0xbeee0078, 0x8078ff78,
-	0x00000200, 0xbefd0084,
-	0xbf0a6f7d, 0xbfa10061,
-	0xc4050078, 0x008ce800,
-	0x00000000, 0xc4050078,
-	0x008ce801, 0x00008000,
-	0xc4050078, 0x008ce802,
-	0x00010000, 0xc4050078,
-	0x008ce803, 0x00018000,
-	0xbf8903f7, 0x7e008500,
-	0x7e028501, 0x7e048502,
-	0x7e068503, 0x807d847d,
+	0xbefd00ff, 0x0000006c,
+	0x80f89078, 0xf462403a,
+	0xf0000000, 0xbf89fc07,
+	0x80fd847d, 0xbf800000,
+	0xbe804300, 0xbe824302,
+	0x80f8a078, 0xf462603a,
+	0xf0000000, 0xbf89fc07,
+	0x80fd887d, 0xbf800000,
+	0xbe804300, 0xbe824302,
+	0xbe844304, 0xbe864306,
+	0x80f8c078, 0xf462803a,
+	0xf0000000, 0xbf89fc07,
+	0x80fd907d, 0xbf800000,
+	0xbe804300, 0xbe824302,
+	0xbe844304, 0xbe864306,
+	0xbe884308, 0xbe8a430a,
+	0xbe8c430c, 0xbe8e430e,
+	0xbf06807d, 0xbfa1fff0,
+	0xb980f801, 0x00000000,
+	0xb8f83b05, 0x80788178,
+	0xbf0d9972, 0xbfa20002,
+	0x84788978, 0xbfa00001,
+	0x84788a78, 0xb8ee1e06,
+	0x846e8a6e, 0x80786e78,
 	0x8078ff78, 0x00000200,
-	0xbf0a6f7d, 0xbfa2ffea,
-	0xc405006e, 0x008ce800,
-	0x00000000, 0xc405006e,
-	0x008ce801, 0x00008000,
-	0xc405006e, 0x008ce802,
-	0x00010000, 0xc405006e,
-	0x008ce803, 0x00018000,
-	0xbf8903f7, 0xbfa0003d,
 	0xbef600ff, 0x01000000,
-	0xbeee0078, 0x8078ff78,
-	0x00000400, 0xbefd0084,
-	0xbf0a6f7d, 0xbfa10016,
-	0xc4050078, 0x008ce800,
-	0x00000000, 0xc4050078,
-	0x008ce801, 0x00010000,
-	0xc4050078, 0x008ce802,
-	0x00020000, 0xc4050078,
-	0x008ce803, 0x00030000,
-	0xbf8903f7, 0x7e008500,
-	0x7e028501, 0x7e048502,
-	0x7e068503, 0x807d847d,
-	0x8078ff78, 0x00000400,
-	0xbf0a6f7d, 0xbfa2ffea,
-	0xb8ef1e06, 0x8b6fc16f,
-	0xbfa1000f, 0x846f836f,
-	0x806f7d6f, 0xbefe00c1,
-	0xbeff0080, 0xc4050078,
-	0x008ce800, 0x00000000,
-	0xbf8903f7, 0x7e008500,
-	0x807d817d, 0x8078ff78,
-	0x00000080, 0xbf0a6f7d,
-	0xbfa2fff6, 0xbeff00c1,
-	0xc405006e, 0x008ce800,
-	0x00000000, 0xc405006e,
-	0x008ce801, 0x00010000,
-	0xc405006e, 0x008ce802,
-	0x00020000, 0xc405006e,
-	0x008ce803, 0x00030000,
-	0xbf8903f7, 0xb8f83b05,
-	0x80788178, 0xbf0d9972,
-	0xbfa20002, 0x84788978,
-	0xbfa00001, 0x84788a78,
-	0xb8ee1e06, 0x846e8a6e,
-	0x80786e78, 0x8078ff78,
-	0x00000200, 0x80f8ff78,
-	0x00000050, 0xbef600ff,
-	0x01000000, 0xbefd00ff,
-	0x0000006c, 0x80f89078,
-	0xf462403a, 0xf0000000,
-	0xbf89fc07, 0x80fd847d,
-	0xbf800000, 0xbe804300,
-	0xbe824302, 0x80f8a078,
-	0xf462603a, 0xf0000000,
-	0xbf89fc07, 0x80fd887d,
-	0xbf800000, 0xbe804300,
-	0xbe824302, 0xbe844304,
-	0xbe864306, 0x80f8c078,
-	0xf462803a, 0xf0000000,
-	0xbf89fc07, 0x80fd907d,
-	0xbf800000, 0xbe804300,
-	0xbe824302, 0xbe844304,
-	0xbe864306, 0xbe884308,
-	0xbe8a430a, 0xbe8c430c,
-	0xbe8e430e, 0xbf06807d,
-	0xbfa1fff0, 0xb980f801,
-	0x00000000, 0xb8f83b05,
-	0x80788178, 0xbf0d9972,
-	0xbfa20002, 0x84788978,
-	0xbfa00001, 0x84788a78,
-	0xb8ee1e06, 0x846e8a6e,
-	0x80786e78, 0x8078ff78,
-	0x00000200, 0xbef600ff,
-	0x01000000, 0xbeff0071,
-	0xf4621bfa, 0xf0000000,
-	0x80788478, 0xf4621b3a,
+	0xbeff0071, 0xf4621bfa,
 	0xf0000000, 0x80788478,
-	0xf4621b7a, 0xf0000000,
-	0x80788478, 0xf4621c3a,
+	0xf4621b3a, 0xf0000000,
+	0x80788478, 0xf4621b7a,
 	0xf0000000, 0x80788478,
-	0xf4621c7a, 0xf0000000,
-	0x80788478, 0xf4621eba,
+	0xf4621c3a, 0xf0000000,
+	0x80788478, 0xf4621c7a,
 	0xf0000000, 0x80788478,
-	0xf4621efa, 0xf0000000,
-	0x80788478, 0xf4621e7a,
+	0xf4621eba, 0xf0000000,
+	0x80788478, 0xf4621efa,
 	0xf0000000, 0x80788478,
-	0xf4621cfa, 0xf0000000,
-	0x80788478, 0xf4621bba,
+	0xf4621e7a, 0xf0000000,
+	0x80788478, 0xf4621cfa,
 	0xf0000000, 0x80788478,
-	0xbf89fc07, 0xb96ef814,
 	0xf4621bba, 0xf0000000,
 	0x80788478, 0xbf89fc07,
-	0xb96ef815, 0xf4621bba,
+	0xb96ef814, 0xf4621bba,
 	0xf0000000, 0x80788478,
-	0xbf89fc07, 0xb96ef812,
+	0xbf89fc07, 0xb96ef815,
 	0xf4621bba, 0xf0000000,
 	0x80788478, 0xbf89fc07,
-	0xb96ef813, 0x8b6eff7f,
-	0x04000000, 0xbfa1000d,
-	0x80788478, 0xf4621bba,
+	0xb96ef812, 0xf4621bba,
 	0xf0000000, 0x80788478,
-	0xbf89fc07, 0xbf0d806e,
-	0xbfa10006, 0x856e906e,
-	0x8b6e6e6e, 0xbfa10003,
-	0xbe804ec1, 0x816ec16e,
-	0xbfa0fffb, 0xbe804ec2,
-	0xbf94fffe, 0xbefd006f,
-	0xbefe0070, 0xbeff0071,
-	0xb97bf811, 0xb973f801,
-	0xb8ee3b05, 0x806e816e,
-	0xbf0d9972, 0xbfa20002,
-	0x846e896e, 0xbfa00001,
-	0x846e8a6e, 0xb8ef1e06,
-	0x846f8a6f, 0x806e6f6e,
-	0x806eff6e, 0x00000200,
-	0x806e746e, 0x826f8075,
-	0x8b6fff6f, 0x0000ffff,
-	0xf4605c37, 0xf8000050,
-	0xf4605d37, 0xf8000060,
-	0xf4601e77, 0xf8000074,
-	0xbf89fc07, 0x8b6dff6d,
-	0x0000ffff, 0x8bfe7e7e,
-	0x8bea6a6a, 0xb97af804,
-	0xbe804a6c, 0xbfb00000,
+	0xbf89fc07, 0xb96ef813,
+	0x8b6eff7f, 0x04000000,
+	0xbfa1000d, 0x80788478,
+	0xf4621bba, 0xf0000000,
+	0x80788478, 0xbf89fc07,
+	0xbf0d806e, 0xbfa10006,
+	0x856e906e, 0x8b6e6e6e,
+	0xbfa10003, 0xbe804ec1,
+	0x816ec16e, 0xbfa0fffb,
+	0xbe804ec2, 0xbf94fffe,
+	0xbefd006f, 0xbefe0070,
+	0xbeff0071, 0xb97bf811,
+	0xb973f801, 0xb8ee3b05,
+	0x806e816e, 0xbf0d9972,
+	0xbfa20002, 0x846e896e,
+	0xbfa00001, 0x846e8a6e,
+	0xb8ef1e06, 0x846f8a6f,
+	0x806e6f6e, 0x806eff6e,
+	0x00000200, 0x806e746e,
+	0x826f8075, 0x8b6fff6f,
+	0x0000ffff, 0xf4605c37,
+	0xf8000050, 0xf4605d37,
+	0xf8000060, 0xf4601e77,
+	0xf8000074, 0xbf89fc07,
+	0x8b6dff6d, 0x0000ffff,
+	0x8bfe7e7e, 0x8bea6a6a,
+	0xb97af804, 0xbe804a6c,
+	0xbfb00000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
-	0xbf9f0000, 0x00000000,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index 9af3b62120041..cb619e49228c7 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -50,7 +50,7 @@
 #define HAVE_BUFFER_LDS_LOAD (ASIC_FAMILY < CHIP_PLUM_BONITO)
 #define SW_SA_TRAP (ASIC_FAMILY >= CHIP_PLUM_BONITO && ASIC_FAMILY < CHIP_GFX12)
 #define SAVE_AFTER_XNACK_ERROR (HAVE_XNACK && !NO_SQC_STORE) // workaround for TCP store failure after XNACK error when ALLOW_REPLAY=0, for debugger
-#define SINGLE_STEP_MISSED_WORKAROUND (ASIC_FAMILY < CHIP_GFX12)	//workaround for lost MODE.DEBUG_EN exception when SAVECTX raised
+#define SINGLE_STEP_MISSED_WORKAROUND 1	//workaround for lost MODE.DEBUG_EN exception when SAVECTX raised
 
 #if ASIC_FAMILY < CHIP_GFX12
 #define S_COHERENCE glc:1
@@ -148,12 +148,21 @@ var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT	= 5
 var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK	= 0x20
 var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK	= 0x40
 var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK	= 0x80
+var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK	= 0x100
+var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK	= 0x200
+var SQ_WAVE_EXCP_FLAG_PRIV_TRAP_AFTER_INST_MASK	= 0x800
 var SQ_WAVE_TRAP_CTRL_ADDR_WATCH_MASK		= 0x80
+var SQ_WAVE_TRAP_CTRL_TRAP_AFTER_INST_MASK	= 0x200
 
 var S_TRAPSTS_HWREG				= HW_REG_WAVE_EXCP_FLAG_PRIV
 var S_TRAPSTS_SAVE_CONTEXT_MASK			= SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK
 var S_TRAPSTS_SAVE_CONTEXT_SHIFT		= SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT
-var S_TRAPSTS_NON_MASKABLE_EXCP_MASK		= SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK|SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK
+var S_TRAPSTS_NON_MASKABLE_EXCP_MASK		= SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK		|\
+						  SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK	|\
+						  SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK		|\
+						  SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK	|\
+						  SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK		|\
+						  SQ_WAVE_EXCP_FLAG_PRIV_TRAP_AFTER_INST_MASK
 var BARRIER_STATE_SIGNAL_OFFSET			= 16
 var BARRIER_STATE_VALID_OFFSET			= 0
 #endif
@@ -320,7 +329,7 @@ L_NOT_ADDR_WATCH:
 
 L_NOT_ADDR_WATCH:
 	s_getreg_b32	ttmp3, hwreg(HW_REG_WAVE_TRAP_CTRL)
-	s_and_b32	ttmp3, ttmp3, ttmp2
+	s_and_b32	ttmp2, ttmp3, ttmp2
 	s_cbranch_scc1	L_FETCH_2ND_TRAP
 #endif
 
@@ -332,8 +341,13 @@ L_CHECK_TRAP_ID:
 #if SINGLE_STEP_MISSED_WORKAROUND
 	// Prioritize single step exception over context save.
 	// Second-level trap will halt wave and RFE, re-entering for SAVECTX.
+#if ASIC_FAMILY < CHIP_GFX12
 	s_getreg_b32	ttmp2, hwreg(HW_REG_MODE)
 	s_and_b32	ttmp2, ttmp2, SQ_WAVE_MODE_DEBUG_EN_MASK
+#else
+	// WAVE_TRAP_CTRL is already in ttmp3.
+	s_and_b32	ttmp3, ttmp3, SQ_WAVE_TRAP_CTRL_TRAP_AFTER_INST_MASK
+#endif
 	s_cbranch_scc1	L_FETCH_2ND_TRAP
 #endif
 
-- 
2.44.0

