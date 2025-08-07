Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3163C87FCF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 20:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5300910E888;
	Thu,  7 Aug 2025 20:23:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X9RpjCVC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1AF10E48F
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 20:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObEtVSG3iTBoUEAEtnhc+ITRvzsFOLyF3Ut4x+1LLFYJKU2wFn2j4Mxa1k4RWap2tG2cB7GodxN2P/YFonnlJyOpQqWoeckFDoq8sul8gHdUp6UnZf/pJ2F2GkUkisSHsqaa4GeQwdbk/DmfedkTj8RP/yF1EwK+J1dq+Yh2ctZob+6JWNp+AlvVNVB71rDh0Nycs6Nqda92U2d/V6cYC5brx1BEe6b50Vc46+up1EvBWoB4tWv7CQzcWjQMvV2MJIsDadE93HSB9H9vS7WI+l5mtUlZuU6H/SNL0zbgl7h6KLyX2FbehmF5M8lma/u6h7Mnaz65BWx+3UE/HYD8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNwtEsxj6l/tgLpVAYjhf8yRSWDgsrpZCAh9++qajCE=;
 b=Foo7xgk69RSIHCo6cvBtiBXRnL1pjNP144ZgcG9SqcRT6TOhRmMIm4cjrdStH/a9Ib6YeEJw30Mjh81hP9VXG1OdH6zPoVKDaUewhnJZRot39T89U2ZsIqsCr8GnGsxIiGJ3f1s0fWA3LdDEl+nCem6adE2mKfQFcnAJpwMMg6Df8Er01U+wK+Lw5oRo2oOXPkqIWeX3bVe9OuKPFyaXN1e2TZSPoUhIIGr+jzyjqdShu19/heTcAJlK9UwA/GH/f9GZzp/o8UUb2vVOeEEiZiR7sOEUhuME9zw/qkaVRQgloMW1g4gPyYRzPlQY5x+L19p02rYCkcodDRUoRwRw/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNwtEsxj6l/tgLpVAYjhf8yRSWDgsrpZCAh9++qajCE=;
 b=X9RpjCVCr6D08himRWulTkd9CQcuk2rlDmXvyBwoHS9YQzzigZG1XW3dkfxUuMbA2Bdl0ssVQ3gtCHPLR3fbkBx7X+8/ITnHUkuylame2qhGEagqzwJba5XVSQKpadQPrTBP50vs5u4FWIHTyvgMSkY6f9X7XnPG3Rz3FqcogF4=
Received: from BN9PR03CA0440.namprd03.prod.outlook.com (2603:10b6:408:113::25)
 by BL4PR12MB9484.namprd12.prod.outlook.com (2603:10b6:208:58e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 20:23:13 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::bc) by BN9PR03CA0440.outlook.office365.com
 (2603:10b6:408:113::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Thu,
 7 Aug 2025 20:23:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 20:23:12 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 15:23:11 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v11 3/3] drm/amdgpu: Allow kfd CRIU with no buffer objects
Date: Thu, 7 Aug 2025 16:22:45 -0400
Message-ID: <20250807202245.2970262-4-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807202245.2970262-1-David.Francis@amd.com>
References: <20250807202245.2970262-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|BL4PR12MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: eecd6528-8f92-4cba-6f2a-08ddd5f03bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?42OHMInSRvQBTEJkXPoZxZne+CBV7T9werSyWxh4CJEx+LcZUInmgZG0pN3g?=
 =?us-ascii?Q?oBr1kMwjJdQEMylU9oG2hPykPukL/EQIez9DMSQJQvSc2xn7lvj1C6Zg5xV0?=
 =?us-ascii?Q?aGbQEhe+6IAcoDAwBJXdSKY+Ta7+uqrHtSis9HE/uVIg3DpabHo7wUgsgnAS?=
 =?us-ascii?Q?VN8SgGS6oTVpGUUDiAM48BBTBNSgijnGhxlI1zA4taneJTb0s1Khy+M3GHXx?=
 =?us-ascii?Q?NBH8GjxyOLNuvlrXUGT0zRGiyvqD1IW1/EYlCaX3z0D7GBv6IKyVrMCuCArH?=
 =?us-ascii?Q?IVAQe+a0UP38O4HGgdvKKjuvZQnUEGRfBhYqgGb/IIBzP85NYjU5pCf1LZmN?=
 =?us-ascii?Q?uqW8fsAezUMWoibsQCCncMGbAVrmkL3Uw4MFjRmf0mEWmE+YKMB1c+mvn/nA?=
 =?us-ascii?Q?Z+acDORFJVQgLO3Kg7if72hfUZqGkadrcX98vD5xmSo/xL5OuwGwnGYgL7ZX?=
 =?us-ascii?Q?wtUnnpbxTmy8qfpLRM98z9/bJ3Z5MYJl9amI0gPSXmWTBRfqRA2jCFSzch9R?=
 =?us-ascii?Q?15qy00lcrWxuUXO9ovzlYDjjU/yO+pAH8OmVUyHNN7QRow/ellIVDxmIYaMg?=
 =?us-ascii?Q?UUT7g015u526N7Gr9Z1IxI7tXYU9U1cQeFRpYeoBnKMlwUkzr60JOyyHEqlp?=
 =?us-ascii?Q?RL2rNsX+Gq1SB7yxJ6LfCcVzqh7nUiepcq/PQFaNbR4ya2XjlBa9QSSgZGWD?=
 =?us-ascii?Q?a0fx4cXIibEl/AJlEM4foTT2GooIF09A6XL4xq17NTenEe++O00N/dbGaV18?=
 =?us-ascii?Q?HIO2jVNRdxqN4Sb1h1U+qFhfecmjedyMwI86/71CQRRSqG+v6dyR2eOipkEX?=
 =?us-ascii?Q?Lvh1FGQclPR0hQXXk3Z+aLDtQ+HOPT483XfGZFyWMCSlP37cOHkX2f6dJZnF?=
 =?us-ascii?Q?wJmeGdArDfEuL6yT4Bw0UmuyQ4BvLNkEGkrhxzQ7dSxLHke2GN4JM3y9F660?=
 =?us-ascii?Q?hrlCdjZVIDyQChlG6fc9x3ZGu2NetYUMGFitFYdo63StWh1+VzF+DQRYeQvv?=
 =?us-ascii?Q?fHHDmuLpBj0pq9s78WTtuIFaW/o7QlRhG3Kbm0h8jrspplEolkWXGN+6Dyuw?=
 =?us-ascii?Q?DC5tNMDyKydMBQedghh9QPh9IXdYYyxecIYtrqnH2RVY7FlcGvht66OpDuir?=
 =?us-ascii?Q?l5YkPBqnVg77iYKVOIGvFm/dmEyLzryD7lpih+KBCya1gdcOiaAB7NukXs/1?=
 =?us-ascii?Q?jqyvD0TOeupKV+KONVjJc6rKzRdx9qNroTw09Rmf0y6Ck7Xq1pyrJ2NPSrIn?=
 =?us-ascii?Q?BnR7KVPgTLzGLrH8GahqkzcfXJlFr8hULtbK8X53p3Kcpao1LUAnIeCPNP/R?=
 =?us-ascii?Q?Jj/Ooa4CipK5TWMmSFGRFYMD/9ueGeY25LTCAa6TOxXjMRHmbdKlSEyKtjni?=
 =?us-ascii?Q?KmM2dk4+ulRLWI2lFuvAHrH/uuVhY7nEAxY+KBR7Sa3By8hDAkojXsVGK0Iu?=
 =?us-ascii?Q?3MQT+XvsekDDxSL0kn2EvtRmjIHj6n5lx6/a46NRtbWawdTZBVsGnGU676ck?=
 =?us-ascii?Q?Y3inr9uwwggUaSqhyxPMzo+aSTYhpnz0uMO3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 20:23:12.7832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eecd6528-8f92-4cba-6f2a-08ddd5f03bc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9484
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

The kfd CRIU checkpoint ioctl would return an error if trying
to checkpoint a process with no kfd buffer objects.

This is a normal case and should not be an error.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 828a9ceef1e7..f7f34b710d3e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2566,8 +2566,8 @@ static int criu_restore(struct file *filep,
 	pr_debug("CRIU restore (num_devices:%u num_bos:%u num_objects:%u priv_data_size:%llu)\n",
 		 args->num_devices, args->num_bos, args->num_objects, args->priv_data_size);
 
-	if (!args->bos || !args->devices || !args->priv_data || !args->priv_data_size ||
-	    !args->num_devices || !args->num_bos)
+	if ((args->num_bos > 0 && !args->bos) || !args->devices || !args->priv_data ||
+	    !args->priv_data_size || !args->num_devices)
 		return -EINVAL;
 
 	mutex_lock(&p->mutex);
-- 
2.34.1

