Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C01FC10F16
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 10:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B674E10E985;
	Wed, 24 Apr 2024 10:04:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eT74GXJN";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BE6C10E8DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 10:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K253MUyIS2ThIsoAKkQsVTfOgnfrEiru50WEoH2bU+Mhc2YLYMmNUTSB/4XedlYcF0jbGTsfcWnnBJ6v/7mkxpzRCaJZxMUqXjqoxpeeCLQSxlKNUgA/sddQCNbwk+aEj15PuCBkIeMnS8JrxDImzY4iHF745Qvox+q/Jtv9YNA2lBufLlPj1vFbT3w8ko72lw85ZRkOpIFmoPfxdcbmznsoh8IafByd820xgE+3vpdRyeBzmb9od52issBKXB81jU3WJ1aeBKjl3zuXT4xTjRCUCMQNzh6bnW02AYQNwCaPteyDcUJFS5teuYkiOHZtMc3KHVsIXCRxamJUPM5Fow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWnExuzPXypFIKqxJ3NZchFJy2a+RBiED7Xfi5RfTdU=;
 b=mbiWpRcdqe6J25aoQZ+o32+W8x92IUC7NQw25eqENqDmLryJULPoDC1zGtaVNV6wBdZII/QPlZeybzldIjXFzTSOEinkcS1Fa+zDBmjvoRGwZsFNJ3BjFYYqwGI9CYkDzVQ0IiVubhZN5zaQpCHa6HiGk47nU0+r4HSFyqFsdbJStnyzlwXgxIJDp9R9/OJo6jHRtCZ17jSiImF6bGje8RKzjzu+hl1Od5GKcG2bL3yipYOtomErIyF7o5Cehq72LwrzD2+twi1+Fy04ftCbmlWMwU1DlNcPH0s0UIaGFvi6HgU8bARVX1HjsUBzwVXaEbk90HKsXbl1kMMQU47WsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWnExuzPXypFIKqxJ3NZchFJy2a+RBiED7Xfi5RfTdU=;
 b=eT74GXJN2bT5lvASqm12vaSRv1Mj66iMY+dRYQQ6PUzImbzoNArzA4Nv9FSimvYWktkyHKaC0tt+eoUnolR444wxDEdpqRppgxZ8M5UdDneL5R6sss6mNdgoSosFBYdFj5FPWbSkM8/4VUigoDIXRkRcvh63+BxVCl/WIWcpqtA=
Received: from MN2PR13CA0016.namprd13.prod.outlook.com (2603:10b6:208:160::29)
 by CH3PR12MB8534.namprd12.prod.outlook.com (2603:10b6:610:15a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 10:04:04 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::37) by MN2PR13CA0016.outlook.office365.com
 (2603:10b6:208:160::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 10:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 10:04:03 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 05:04:01 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Fix the uninitialized variable warning
Date: Wed, 24 Apr 2024 18:03:43 +0800
Message-ID: <20240424100343.608218-3-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424100343.608218-1-Jun.Ma2@amd.com>
References: <20240424100343.608218-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CH3PR12MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfba686-2ef7-4237-fa33-08dc6445df0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9yGGL6L6LrKpKPfqUz77IuDhjIrOjJP1w1GJdqGofMp9b+TdAcQw8rAT2GST?=
 =?us-ascii?Q?jH91OOwhrr2A3G7qHCJA5bPfEBGtl7pHVYJjm6+BPE1bhqklk4aaqCp7iWb5?=
 =?us-ascii?Q?3/bRtwG5cMuFPncErB8LbdyYJATfZtgzJyxBhCzrUUNOv9J2PGBJbU8ZXwE3?=
 =?us-ascii?Q?MEpDoo3SxsNj6N1pxL2iVWW2gkkTQsE/K4x3T7UMbAtvbENhpXek12Az0XKj?=
 =?us-ascii?Q?g8uVRurahE3eqdAxUZl5wzy7Q1sgxMciHwudj1stmc0MXHrhLLQojwenUb+W?=
 =?us-ascii?Q?5+ZwZ/E5tfDhjj7vZmVUqpeJAuTRaMg9LAwcD+PV8gciAYVN6JXR4csoOJjz?=
 =?us-ascii?Q?T02L8ErPPw+Bz46lDoiBFwwdUDQ7G+lhvY+X2Uy9D0aN4+4R7/WGT3CNZCTl?=
 =?us-ascii?Q?0EDuOr0ZF2jJepxZGdeMj+UMW2KC13u4LCixtBEMflLeK+d+pgVaYX1hs3ms?=
 =?us-ascii?Q?BLZ2MXCXOROvVnZZMQZnDyVIIo8mVRYeCsjOxtzZKEfpn5+nyl79n6F+jR7m?=
 =?us-ascii?Q?osliJnFocINehnGAVgc6lAvJBC1c6X7eGVscs9T85KUlDHTvpSUSm7hJuT4z?=
 =?us-ascii?Q?kK1Ji1J+5dfORTu4W2T8Yotpmgm+v4jOVeS7QzHOQpWrjOsKobwb+PfwnHk8?=
 =?us-ascii?Q?SbN5P2DS9CAwlARAeMeNc9oHoQRXsBW5taXnmcIl/hCOoDn3Gl+RT4Qvx7RA?=
 =?us-ascii?Q?+rtJP//Nn3Gy+P4t/JWjSMFC90idQCLlJBpzffksjNCk4eoUKUH9M6NzUwGM?=
 =?us-ascii?Q?lCPTAEHx2IzDazOGIiENVgUBvz7KgUJwHLurBXC2PRvaCW5pZVADYrKhXAwy?=
 =?us-ascii?Q?WXbYmtEvN1aeYvVNyTzV5YY9KCKMoa8iP2vOX6O2Bx+MdFUylccjjUcp3JHH?=
 =?us-ascii?Q?LpzI/Qe0pXY5gypN3neEiz7dfdPlXcwxL6mZj+056zLkm3WQnZshof7XkZxI?=
 =?us-ascii?Q?+TojB/KH9uipQJMENzCiirgI9iyiIjSMqvdobWouAWhwjKlwm/95dPSfzS+2?=
 =?us-ascii?Q?wGpofRsOrw3IwsVm//siPAlJdKwvGsQ68l/eS2WrZ+apX4LjheopOjmtWGMp?=
 =?us-ascii?Q?0N2bd+Fom6CPu+Ea7J4kgihB4KP/cCsmKABntBSO/NM5v8Bvaa1Zo5d6Iszc?=
 =?us-ascii?Q?rppoShfjmCb8VZKkqER5gCJRVRKA0R8OErzVy957PGEglWqhdypJzwmcEPjg?=
 =?us-ascii?Q?ZTrzAkX/8wi298Qt01NgtCtNYTbSFX1i62dkIySeFzzjamyXoUs76cLMT39m?=
 =?us-ascii?Q?KVoqR7qe/GZ2A+dEeu83J6vuht937IJt6kbAcS8Rt87sq6KnTxLgPKdhIpBr?=
 =?us-ascii?Q?kZUJKnGt7qo33JBHe2nK/+P+GpslU95qw+11ow/vf4ehPCjLtJu58E0EGfsD?=
 =?us-ascii?Q?hp8ujTIjXpHviyqzJYVrtb06jEYH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 10:04:03.7120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfba686-2ef7-4237-fa33-08dc6445df0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8534
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

Initialize the phy_id to 0 to fix the warning of
"Using uninitialized value phy_id"

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 8ed0e073656f..df81078aa26d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -95,7 +95,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 	struct psp_context *psp = &adev->psp;
 	struct ta_securedisplay_cmd *securedisplay_cmd;
 	struct drm_device *dev = adev_to_drm(adev);
-	uint32_t phy_id;
+	uint32_t phy_id = 0;
 	uint32_t op;
 	char str[64];
 	int ret;
-- 
2.34.1

