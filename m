Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB42C0219B
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 07:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCBEF10E4B1;
	Mon, 10 Feb 2025 07:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5E47tcnT";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6CC810E4B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 07:01:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPMgX+4JsGTMnV6b/9Oy2FYmbcX6IhL/FueYla2ukcQd1xhXUQLx2/70qJJwkZtNsldoVoW0KNzPOQPX+8P4Kcx8mULRovsId9Y3KCBcSseujsriQV/SXQwlZ5cvz++8+WzoY7TNLKzLK6ykg6n6iWnQoCoGctMR8nJC3P35cC6IkfN8Gmij/YygTDJE3MPNWs0ju9QCVQH5TxnKs8xQXWpXzYjY69KFoWUDjy7QoSh1N/5lxQtDR8OixjdJBcucUOwU5BcdN9cDi90mTsq2J+mMN+TDQU6hFdRKwE/5FQZn17IH2hA4lKRNMTBAYKGcSDvUnxDOraYTSxdToBLE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3GWMW5e4QjiHumFJ9ZRjuhued15XjW3OFq++Dmti+s=;
 b=SoZyF+taRVDW+tYNE66/8P+XTrPGaljHR7FK7ai+mT3lo3HJXnl3RoFUhWY25l77+GGoSMRTbto++wTnYPvlZ11zVjAN2gw4OY3eO8ZTLbi7a4v/5rhKJOgobgvtrSyhWOR7kvybKCpVAyAp2KPRJMHB/r/Vw3gpAqqnclDMyI8g+DDTjBh5w5C2qyeVlyq4cJGv6f69nK04vT6X2hV5wQRNUOu6bgWlW3gf4chFVXQjhsoIM34eu+1IplhGhouv2sGiE/zapDvaNhTk+SHw6PXiq1TVwGAk0rlI14lw92pKb/3EIS8YDxzqwrHbxfeuXR/qfxMPywo11Jt6A0wmjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3GWMW5e4QjiHumFJ9ZRjuhued15XjW3OFq++Dmti+s=;
 b=5E47tcnT/GUqFN752f3jIM0wxVwzRYFyFj258DPeVAJzsZsrgcisuUl9M9m31o4bgJ4Ic+vXuveoDXuZhwEo3FLH2grC7Q4M9fqiJs8+C/7EJAXe1Yhs93w/JGAwBcawCIjVvNO1RqFjOny/MA6JYVUxAW77FgVcE5wSRuSQ8lw=
Received: from BL1PR13CA0078.namprd13.prod.outlook.com (2603:10b6:208:2b8::23)
 by IA1PR12MB6482.namprd12.prod.outlook.com (2603:10b6:208:3a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 07:00:57 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::e1) by BL1PR13CA0078.outlook.office365.com
 (2603:10b6:208:2b8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10 via Frontend Transport; Mon,
 10 Feb 2025 07:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 07:00:57 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 01:00:55 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Jonathan.Kim@amd.com>
Subject: [PATCH v2 4/4] drm/amdgpu: Use xgmi APIs for init and bandwidth
Date: Mon, 10 Feb 2025 12:30:34 +0530
Message-ID: <20250210070034.1998011-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210070034.1998011-1-lijo.lazar@amd.com>
References: <20250210070034.1998011-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|IA1PR12MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: 3793b7ba-b252-4a03-1b93-08dd49a0ab2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KRNPX+1J8kTZ8USis33mTTpUdKXAl0pxK6dtO/0TYxEQj7Bnv1J20yPcloo1?=
 =?us-ascii?Q?rp+VTIchkaoHu0s3oZ1oD4QsAsH2yF6YozthmLPl/UB5Ki9teDS/bjd1PjSB?=
 =?us-ascii?Q?reo0Fd9K75j2wwMP9HW5rV1s1ctz+X6Q9Kp1THm559YgEliCEfIQL/GFpss0?=
 =?us-ascii?Q?kMGGZXSa9fZZwEJtbJ8Rz4OAUd17/EraKyubsT8EidonK/ji6nC+0Wk2g/BZ?=
 =?us-ascii?Q?uilY/WfaLddEgz0ls2ycBP5ihDAAVq+0UsuM+3poTuQOD1PiUaak9aHXKn/e?=
 =?us-ascii?Q?QuyljCWzB5m8Ri+3NBb81i6ObH/eFCS5kyyttsWJ98V/J2gQDAqjOU3t1GWD?=
 =?us-ascii?Q?TcSGXxNBOGt9IuDQA2rxyjXpB7YtvCy7uY+KD4T6ZYZOOCtRf4b82gpOKKOT?=
 =?us-ascii?Q?ATdw3vdc0NjeYRKtUbapJdOCYjymPbZhMHYfMYEx8v/bAtgY3LYoheE8rfff?=
 =?us-ascii?Q?Gf6EX9maUZU1McwfZ7oJWhj2MrQXol+slFZLRYsJF/j+5tcw5A57M2DBT3Q6?=
 =?us-ascii?Q?k4qk+ue6zGH/cIqHvXiKjCOWvrOW+zOs7NE/+/Vc7aIS9JWXDrgCXSPW9Pfk?=
 =?us-ascii?Q?cmUM0vu4DAv9X5HQG2WbBTeJa63OKA0wYQR9isgYiP7Nbv67BBNfR6v8Ph4j?=
 =?us-ascii?Q?7l3sGNddThAQWrfGxz/y9SkVI7Z34IWK7YUdZPCFZy7k1ZlBHwydgbEXRNWD?=
 =?us-ascii?Q?JfuUZgqzDpbF8VKWrUoV2rEyDbK96T2QU055I5egg0wZiYvvFA3L7EjaejaO?=
 =?us-ascii?Q?MS/XgpQ7HyeoqOVoEvcP9oW5vHTPMpqI2/tTVhgzZPTauWSfNMNo2cAc/nc8?=
 =?us-ascii?Q?lbydMoRm4CYpn3p82DPtyijSf4udHeIZy0mbwHtvpPpPYZPDrpjPnJOyWZrA?=
 =?us-ascii?Q?Tmuxv1aGJ92ahTaq2FYH0XHOT8684jqqlSy/ZM+XQyfKb1f9H6mYsBi85f0O?=
 =?us-ascii?Q?EQklQMsCueVAnEyF6XSxr3kHWtk35Pdk3lheZdRH9yyWRk8Zg8oEo8ECJSYU?=
 =?us-ascii?Q?gkd3XRDDt3ZNzq9fTltjVC/dYMuR0BPuSdpGvsGUSeC5HhpO1BRog7Ku6iJW?=
 =?us-ascii?Q?yVPMEHt/UdOCkrig5L6WlbvOrlztV6ba3AIx9VkPkIVoaQqWyNpybGnaXc7P?=
 =?us-ascii?Q?MPjXNHhma3AQfjCU5fgf4EnIBHL46tvivTgF9duzpKnyUTRHowNf9RWmqRIv?=
 =?us-ascii?Q?8a3k9OividXTO+hPlyv65DiH8pMd+td9BvU+F0oi1z1ERm7UN7xQd2BbdkE4?=
 =?us-ascii?Q?+97EtNxTKfkPqvCQM+Utg751EJyKwBF2SqHkXRjhEmKm95Z9IElr9kSS02r7?=
 =?us-ascii?Q?jIcyZQSgaKbrK0PORdU4FYD/HysEb96fCURsEFw/7o1z0LSbRqz++kLjMrtS?=
 =?us-ascii?Q?rEifuHPCfL+5neEjR41gLhGaYBq41VlDfpOtRycV/HxCPEyljPIi2q+7dzSL?=
 =?us-ascii?Q?JJIT+VdINLBB6GqWpCzBavnxBKluIdNH0VPwkm+wIEVLeT4oCKUJsEOmkt1s?=
 =?us-ascii?Q?AnibtFkmIuBmn3M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 07:00:57.1374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3793b7ba-b252-4a03-1b93-08dd49a0ab2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6482
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

Initialize xgmi related static information during early_init. Use xgmi
API to get max bandwidth details.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2:
	Move XGMI info init to early init phase (Jon)

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 2c1b38c5cfc6..e6bc70fb1eb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -576,6 +576,7 @@ int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
 					    bool is_min)
 {
 	struct amdgpu_device *adev = dst, *peer_adev;
+	uint32_t link_max_bandwidth;
 	int num_links;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2))
@@ -593,8 +594,9 @@ int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
 		num_links = 0;
 	}
 
-	/* Aldebaran xGMI DPM is defeatured so assume x16 x 25Gbps for bandwidth. */
-	return (num_links * 16 * 25000)/BITS_PER_BYTE;
+	link_max_bandwidth = amdgpu_xgmi_get_max_bandwidth(adev);
+
+	return (num_links * link_max_bandwidth)/BITS_PER_BYTE;
 }
 
 int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 315ab2d6717a..09aac4542ed7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2749,6 +2749,9 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	if (!total)
 		return -ENODEV;
 
+	if (adev->gmc.xgmi.supported)
+		amdgpu_xgmi_early_init(adev);
+
 	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
 	if (ip_block->status.valid != false)
 		amdgpu_amdkfd_device_probe(adev);
-- 
2.25.1

