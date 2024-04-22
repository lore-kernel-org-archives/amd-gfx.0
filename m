Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82355C07E8F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 09:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D7BA112952;
	Mon, 22 Apr 2024 09:49:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wZt1pWI8";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6543C112954
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 09:49:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPfJ1ZdENebHZrc+8OXQwEmd45iDKx6Y1tBdaAS9APIjWfayq2WocHWZu2U/sianPlS1VKgC/F6KtF5rD5HYa/D2oK/vtMqC4lcSUU30x5EQOKleHY0TEt0pXWJXh77ViuAwEj2wDBRpeDXqBDnoM0Zis3ZSKTKlvXvA0SKnm7FNcJ7WWVOBd+ciTiY3xihroEMoBD7A1XhSQPjvetma86CThJlhX9/OP7wHOBCyxEr/8oSaxgAKMO2QGU9lAyv2dAe7GGHL8gv6WPF//66XDEb2Ei2ENFSabW4SfWldnyfk8H/XZcF6gbfjlBilav+T039sWh1cgJtWijZWd1jKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA6gAQ0IZ3J3XwFNGO8ZkJAWN/fc9YnU9wML4erS/p8=;
 b=G67b/lLTk5tp+/1Qol1KxaxG0hK+basX91XLGVEKBkoBnzRZuM+bzGN1eNvEtg+xH+HtM3jB2rr/IPkxfor6EnOA/syS8DnrzTj3euzCKfuLm79N681oO2Srj4D7zcFvimt9yMydWTp6nCku8KLExqa7ynSiEPXMSjLrBlFV+37S2dKYDWPkrWX59ddwgKnWdBwWhvJm42FODQATTOCxSMN6hXsWdmrP9/VDWO6m87bg7Q/VIYKg5qApSTdAV5IIrmj0nuy6ciTlwHo/WPy02uJQJy8tfIhVbXiXDLYaubv0yATAPTcmKw8hD3te7Q0iZsey07yX2PrShLrrLsaLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA6gAQ0IZ3J3XwFNGO8ZkJAWN/fc9YnU9wML4erS/p8=;
 b=wZt1pWI8TV6v6ZVrSPJrJ3nQnq0M6xeel7fma1z6W2LQOuQwq/Ompx6o997C8JxmPJPVredOPRnp+vZBBToo3GA0oKHAfUEdYCFWTx+nJ/ltUFiLYUOxxc2rVleL/p8P1LiIaJcic2mf0Wapc9mVX7M2pVscm9Polx8ZZaZU7MI=
Received: from DM6PR08CA0010.namprd08.prod.outlook.com (2603:10b6:5:80::23) by
 DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 09:49:24 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::13) by DM6PR08CA0010.outlook.office365.com
 (2603:10b6:5:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 09:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 09:49:24 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 04:49:22 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Fix uninitialized variable warnings
Date: Mon, 22 Apr 2024 17:49:07 +0800
Message-ID: <20240422094908.537208-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422094908.537208-1-Jun.Ma2@amd.com>
References: <20240422094908.537208-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 869449f4-3227-450d-92fe-08dc62b17e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IPuy3KHDPVzh4F/UKPQ/cjOME/YxgpFww0kbY8zwggo/RYW4xlAQdpC/3TVn?=
 =?us-ascii?Q?r/lyErUi7KCPJ/fh4QDY/UuuyML7GAaPwH1RGCSNKvZ+d5KyPVcRV/UZQ6dT?=
 =?us-ascii?Q?dsGfnzR/4a6oIPZtPxpgcLWL16vuatmf4MF1PGUG9qzaofX5eipEJ3xPeMTd?=
 =?us-ascii?Q?tcDsYj6OKD7PMbpFdLPX33SV9sMxH/XAqh1N+UkSNzee1YTPA79AYBUJZxgv?=
 =?us-ascii?Q?iK/IZw7FELlzfSjYfCmgDKqsK8eMO0pGY3s+VzfJ8Pmg0fSPSaBbAflVfPV7?=
 =?us-ascii?Q?C6UmZ61n1qovzvLyFiZ4Xbv8GqHu6ulzpBPOr6Twpp4QDh6MiGi612pcKG2u?=
 =?us-ascii?Q?SXUmqx7YdH1FlujKBlNF0ux9N1ix1Pae16H7KtDmni0dZfpjG3l0IjfON49C?=
 =?us-ascii?Q?dbc+CPuVbUsTeI30daxaahvU3qElW16UWUbljzY2hDFRB7wjVYOYjanrQfbr?=
 =?us-ascii?Q?baJzpmfp5Ik8ian5m15q9GR9snAjjHVzt4gOMV+1KZVA6O6CVbTwGeEbdCPQ?=
 =?us-ascii?Q?clfKPzLcsfRiaXeZ7IgaH40Gaml0nTgINQd9NT9JK2gBpBkbs+6PAjhp/VVz?=
 =?us-ascii?Q?o1K8+M22E47AAsbRD7YIvZGMZezgO1CboqjQKKl9YlHJuBaDukjfLl9fzFrh?=
 =?us-ascii?Q?URyRV0GVKU8gGmhn1umTJtA+qSkN0X5NbybQQ+dV1ZW32UfMRUx5z/YwCjAp?=
 =?us-ascii?Q?78aBEvYsKyAhHCf3wWVAWR0F20l/oxAeGHbd1ItcQcyNe66OraXaD8UBL8GO?=
 =?us-ascii?Q?Bv8+lpRaFOZL8DYguTgd9cGXQrdK9RaxkbU/uhBSgjwZeAzEMbcJgGBdkEVJ?=
 =?us-ascii?Q?jeSR9IL7+fN+z2xeAszA1xieDkCl25MeZioahEGc+b5aA2FFhFi5Lyub3RG+?=
 =?us-ascii?Q?9RzT+jix9F3ALVtztOFunBMdA7iRlL5UtxocXjWHehy9NsdVS13X47so2+T6?=
 =?us-ascii?Q?i585qBEsjB7QgrkhPOBc4Yj1LN+9UWVlu95zzABj9HZVXccOTQYJZjPO51CL?=
 =?us-ascii?Q?KApdrANq4ZISazYhLIM2dYGocbuVCtuu5S8BklYhpGsotxC6iMlYpiFXnIPA?=
 =?us-ascii?Q?a15nBcYTBvfgITDszMdOUX6NOVccRve9fjzIFKyLI5NBIvA6p7UqLcFpTqhl?=
 =?us-ascii?Q?/YO4PJ2WYo9t32FRiJtcsg79n3WseZPOIF4niN1t4s6z/At0mbQ04BvQ0+Uw?=
 =?us-ascii?Q?DPGNgGczxiIqSAnYH2ZpxQw9XC/b636O/jAsuj8dtV3niGEZwc76uhNExMt2?=
 =?us-ascii?Q?HHMgq8egmAbx3XSL1vXSVzwbuxMgpKV7Ncb9GFcMVbddYIJE0Lwx3btFxWsL?=
 =?us-ascii?Q?0fW9r1L7UOdJMJGMEOTMuWB9dNxfiQRKyMXYyC6hRo+svkpzZ/K/3R8PLO1S?=
 =?us-ascii?Q?IcSDNKKDxKVpl7QaTnajFLya0QZv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:49:24.2145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 869449f4-3227-450d-92fe-08dc62b17e07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767
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

return 0 to avoid returning an uninitialized variable r

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index 576067d66bb9..d0a8da67dc2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -97,7 +97,7 @@ static int aldebaran_mode2_suspend_ip(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.hw = false;
 	}
 
-	return r;
+	return 0;
 }
 
 static int
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 93f6772d1b24..481217c32d85 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -92,7 +92,7 @@ static int sienna_cichlid_mode2_suspend_ip(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.hw = false;
 	}
 
-	return r;
+	return 0;
 }
 
 static int
-- 
2.34.1

