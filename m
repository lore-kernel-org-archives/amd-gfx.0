Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F07CA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 20:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF92910E4C6;
	Mon, 18 Aug 2025 20:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OuHc6z6v";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4856F10E4C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 20:05:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6y/cx7mgUZOUKzx8tUViQIb+tmR1AOf4wAvHNPy84vfubVxOfvl3RUWvzk0fCYMK+/yDUcElE8GuhyUskZKTvljjyMFpiofAW1KktzRozvpXDza1LBw4h4dJ6Z+R7byvLoKUThTzCMKb4w1OkEBeFyFxEYEqXoK5yzYj6oo8ccbCphiMLsmWvcz1u8Nxfr+yuWFX2d0p59QAvkp5/b1iA0r0/toXaRVHpek4yK5p3B+zjs8HLtanGeXTzwxsz5rHfU8vAfoeSQJluCzQX0CoCstr4ZRaSyRg94JairzdUtVPc0Dj0jEPo2NTtQ3d7z58SvNwP9MPTfukuFJiFrcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLRYhOhfchZEy2hMKjd+PcRuJV6aAzChOyeoDZ0ucoY=;
 b=tg8sFS9J4vT1FbweoGxVl77vn5tszYEwv+LMibD7PsShs7ZKooSHhDfbZOtg4z0f25pQr/pxBowNxuVhCv3gru7Osl6ohwpT4psZ/fqlV9IrlqITFQrOT6lJa26ezvxBWK/0F0pJeJ00LU7+LSZcs8E3xn52JGmf6pCuFas+Dyg2I5jMBPF2o5TXPkl2iuf3grJcaawqQXSDpp7+Qu7i1YcDMg25IaVbI1BEKDNFCDVzDeiiVEeGhAExzZd7q93dBMzLfotj8qMMR7yXeiM/l7DPRKeYBcXQVTiH7qqK3BHp96rXkw+vac2YvMiFREWpDxs75YqyHqrOCwR1FW/7Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLRYhOhfchZEy2hMKjd+PcRuJV6aAzChOyeoDZ0ucoY=;
 b=OuHc6z6vN7WtptrMFjrmK0UpH+st8Z+0TpyFAaJupUbohER//Qjwso+ivbgyR9gNPOnnpdz6h1ey1vBEMrIswybEBqxXON9s0/84PVQ39AQz4E7DoTjJfrDngn0EStTe86Qp2LEXBUt16D8Yz10uPYC8NstN7ZEJH9yGehm9ZNg=
Received: from SJ0PR05CA0181.namprd05.prod.outlook.com (2603:10b6:a03:330::6)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 20:05:09 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::52) by SJ0PR05CA0181.outlook.office365.com
 (2603:10b6:a03:330::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.12 via Frontend Transport; Mon,
 18 Aug 2025 20:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 20:05:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 15:05:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: add support for cyan skillfish without IP
 discovery
Date: Mon, 18 Aug 2025 16:04:43 -0400
Message-ID: <20250818200445.437007-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818200445.437007-1-alexander.deucher@amd.com>
References: <20250818200445.437007-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc1ea0a-4686-44d8-8503-08ddde92878f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r2CMxukqABcakuETPXUmnHqaaPm8lT2pql/t3T68oFSx7VJUX4VjUc/WLi9x?=
 =?us-ascii?Q?ubzIsrS35P4A/z+k0HoisoObZcDaukXysiJAd327WCy26m7qqAlOURCcbQqB?=
 =?us-ascii?Q?pFwmSAw2dNou/zQNUpDtmzy0L1Bc5KKpkfcpNDbiZzaZsCOX1UI5uqb/LN+P?=
 =?us-ascii?Q?GIl9kbV9MAxXOuA1/m3hK+1g6AB7tnF9OfRVIQoh0477DpUxOSYWH0LgXUnI?=
 =?us-ascii?Q?JejQDpEqi75V7vkT0kxPCu/kUKic/NzM8Q7kUs/zNYRKdruVhrzQo/CeTJaP?=
 =?us-ascii?Q?VwX629yDaO5RHPc1pU1HFpNRlFQAZvXdxiaJi4R/ZZgeYv5dBuuuHe0rqTuv?=
 =?us-ascii?Q?8ZmOr+ugg2MSGUdhiegYrisM6uCpbk2FMkwUuEOr2Qrp7/ZZsCAhEPYzIlMN?=
 =?us-ascii?Q?MGjIxgSmKzjtlyZ4kF0uL4WPDjJzMAxIMn9Rmt3W8YwPIfyDFknmM5O3uHMq?=
 =?us-ascii?Q?5o1/OQ5vOad4EIoXemGRU63jeUk6vLbBtstOzr2Jp61nK28ph/smiRR7kckS?=
 =?us-ascii?Q?pdI9gx1eJ5IF7c2/e8XeQNqdzlMPnnROTv/kgZkZdrWGJexZh7/UgcZYqBXK?=
 =?us-ascii?Q?eHWu/w4a2eZBMp1te8v6JRsfbJTsOct22ZzuT8sqwHrnDdd9OWfZSwZnvpbn?=
 =?us-ascii?Q?ZvxZz4VZX3se63Mrru54s2Gq7SaIHXdjfQvBxHkt6p3fLl9v25tyeM0q5Ysj?=
 =?us-ascii?Q?h7F12cxpFMKwoLQMXJMONZn5XT3aJHVvafdPnlQ5hPXqAoFW0gphn6fk9qpZ?=
 =?us-ascii?Q?axxAP2AMYtbcu+LulkwA0c1XIEXLPFmmH9JXmDYplzYPoP7fpcKtLaBU30V8?=
 =?us-ascii?Q?yUimtKlcVP9jYMk0Lk9nOoARZ0TNN194XnCvTY2rpZ/gsb9U5vLvYjjU94pt?=
 =?us-ascii?Q?uizydIJ+gWF1bKoASg9rngTiidNTznOiWQoMhTlNVR7YdyvC304yYFlGcNk4?=
 =?us-ascii?Q?E+lps4eUdPR3bWV4qxyUKYpWzhUbJ0fPTfz/pPv8sZGS/bsTu+bH5dendOvZ?=
 =?us-ascii?Q?RWTbmDX8r/pMyKzMg85/KC+lKn+1eFahUCu1HMB/n9rw9oUsGLASzf0Hj9P+?=
 =?us-ascii?Q?5IGaroQ1cCTLfwayCEQnEGCkUgH36h5V4gUhAzGkrAJHriOlQQtGOC8oxBjV?=
 =?us-ascii?Q?o/nbx/Xd904otZUiRhScEJgrmbvt7oAo4i1RLlAMjVhEyGV3FORqRnf2vwRN?=
 =?us-ascii?Q?PSogmmjGlx540mAwVevcujsa3+CSw5QBWMXtHYHKItvMMuw7Lea13O7HXulT?=
 =?us-ascii?Q?qFoTqKN77rR/eJzRNLlm847C/dzY6zCjUdfCZEBY36KArJQJkiRWu2E4yjqb?=
 =?us-ascii?Q?BbBF8jUREKCLQEzonyusT1F5Rt1ztigFK/PR6HTNjvpi7QAkoh6sEr7EcATJ?=
 =?us-ascii?Q?Lc6VcekUiOF4hylA0gcULSmattqwJAKvg6aLEYgjHgS7fi0oPQj8RkSWH4xH?=
 =?us-ascii?Q?n1y76GfNe5R4OIvsuYk908VM6s6OHxfLFknyWjY+l0fYfWdhxyp0NgrV6Mjz?=
 =?us-ascii?Q?KKb8bvbuarvAVH1NreK5AI/LQaUo9QQWG9pm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:05:07.6067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc1ea0a-4686-44d8-8503-08ddde92878f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106
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

For platforms without an IP discovery table.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index efe0058b48ca8..38c4ebc063db2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2746,6 +2746,36 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[UVD_HWIP][1] = IP_VERSION(2, 6, 0);
 		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 1, 0);
 		break;
+	case CHIP_CYAN_SKILLFISH:
+		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2) {
+			r = amdgpu_discovery_reg_base_init(adev);
+			if (r)
+				return -EINVAL;
+
+			amdgpu_discovery_harvest_ip(adev);
+			amdgpu_discovery_get_gfx_info(adev);
+			amdgpu_discovery_get_mall_info(adev);
+			amdgpu_discovery_get_vcn_info(adev);
+		} else {
+			cyan_skillfish_reg_base_init(adev);
+			adev->sdma.num_instances = 2;
+			adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(2, 0, 3);
+			adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(2, 0, 3);
+			adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(5, 0, 1);
+			adev->ip_versions[HDP_HWIP][0] = IP_VERSION(5, 0, 1);
+			adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(5, 0, 1);
+			adev->ip_versions[SDMA1_HWIP][1] = IP_VERSION(5, 0, 1);
+			adev->ip_versions[DF_HWIP][0] = IP_VERSION(3, 5, 0);
+			adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(2, 1, 1);
+			adev->ip_versions[UMC_HWIP][0] = IP_VERSION(8, 1, 1);
+			adev->ip_versions[MP0_HWIP][0] = IP_VERSION(11, 0, 8);
+			adev->ip_versions[MP1_HWIP][0] = IP_VERSION(11, 0, 8);
+			adev->ip_versions[THM_HWIP][0] = IP_VERSION(11, 0, 1);
+			adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(11, 0, 8);
+			adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 1, 3);
+			adev->ip_versions[UVD_HWIP][0] = IP_VERSION(2, 0, 3);
+		}
+		break;
 	default:
 		r = amdgpu_discovery_reg_base_init(adev);
 		if (r) {
-- 
2.50.1

