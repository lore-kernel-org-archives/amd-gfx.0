Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50C5606A323
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=j3UlqZYa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D78E112235;
	Thu, 26 Nov 2026 09:35:15 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C27CA112229
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:35:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnTJDWR6GExiXrK1iQt9dcQBZXM5w84X07aY2P7t4n4MNp4CgubTiaBZGUUEokJKHIPBPCLBL4iIcJrJIQsYWVUDNgkh/BA3z7NqF0Wqi/aiE7RqbqkozKVzZsmXujBky6jBTfeKU5v0mdRe3ZaQliV9EOLOGs6QhhXvfT3MzYkRZnVwZznnRAB22nY1pScoY6NXhPJFfy4Xv2jHPGVX9+KHsfHAyd+utUSM3w+CRoJ7+f+ucbxt5D6sPsq4HRICSC2rTmFenpGZQp2w2lPD34cPtE16Pl0eMf1Wp8pbrVxQbHWdwcbsJECix0FnUZuxmqhtJ+nEM9bhiGpATtDPNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gK5EclliH5pmxK7mOR9LtpHIjyM4UpvtyYdRtrgasDM=;
 b=UKySvA/lkeGI/nQDTYYtc+kLHIwaH1YFLWxhIuQpr6LeM2DIOUXtX3Z0fiBWc5BjvmFekd1wz0NLncJJnD0qt0+p8G+dFfKn+e9Ecvk+lF3vitAaiyw23TPZiCS3qvxeJOXu3VvmduV2N+gAmjTprRdSnkG6179paS8HhXNaC1fFSNU4rtr2Av0mKdlgOq7lEBxg461HANuO14+BEig6301uLJHk0HJADNaXaF9A2ICMbVZ//IBfq5nu/iaoVqJkyYI9Rdh7BCaYpvJIZotih1CZTFzu0g0zbnv8tqopH8euchIbrZmkCfnZOWFqMBbyCipy9rXB/AyNvEkEedvxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gK5EclliH5pmxK7mOR9LtpHIjyM4UpvtyYdRtrgasDM=;
 b=j3UlqZYa9IMVb8ygdSQ1sLTmJh9s6R/XRNx5xtrT9exRF4vlUl3uz4v9NdwDT/apOIfJq/+8mPojyYXg4T0ESZrbbHsDH85btZXrInMGT5dNQbR0wRtOgWcEu5AH5pmrw6gZeDLyi00p7DyeLrKZzM3CvziD6j9q6hM9s/+ibtU=
Received: from BN0PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:e7::29)
 by IA0PPF44635DB8D.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 09:35:01 +0000
Received: from BN7PEPF0000009E.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::1) by BN0PR03CA0054.outlook.office365.com
 (2603:10b6:408:e7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 09:35:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009E.mail.protection.outlook.com (10.167.248.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 09:35:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 03:35:00 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 03:34:58 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v5 15/15] drm/amdgpu/gfx11: enable the gfx engine soft reset
Date: Thu, 26 Nov 2026 17:33:51 +0800
Message-ID: <20261126093417.192538-15-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126093417.192538-1-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009E:EE_|IA0PPF44635DB8D:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0e4b91-486e-44d8-a163-08df4ba08b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|10067099003|11063799006|56012099006|261021121427099003|261009223027099003|261102123227099003|261022075727099003|261022105027099003|261022113327099003|261026140227099003|261026121527099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nPQm8OWHcQ9RdUtXkgLr1kN1WXwNxlRDeFQPAKnKIRhHKcb4VvLJuicsUUa8/qotWvvfbL6F6hbFyDsW90xo0zaCxbDurBQQobX6W5l6q3vslHY7dcwuWbbvV9mzt8R7MvEnUAtlT3T2mG8Bp1unEdipx7gn7AtixC9tLTaVMbidHs0tfpbxLqWnSVzSTOBym+DooZj5OU/pmUIIV9ACSarNecIory+5pf2UVQiUl4tsDfvQYnO5SaXXnc0k+m8K2Qon8/VqVqqdA2zg1yltZynP5ajT6dHn4KX024n2sgJYaqNgVu66FCK3reHG96FhFpbaNfNjYfFFZZ2eLwME52P7qF+VdtGSgOL2Yb252/Q7Mni3u+4pCi95fdQ2UrVoYII2TRxIUfYNj3a0CVfLp82hNT5gy6ZvzaQ5M8uxny7ts8N/Di33mRkA229GyH3lwykiq/G3cLqvkvn+MbTCZe/kqXOzByXbbZvS1LqkLKdSibt2Is2s373HDxS2xaaAgtMedWQcHqe3w6n8f6f8TiSXunWJReKhw+TNpct5M/BIlAr6tjRtM+H9ulWDTByLVbCX8tM6PACgjr0X+pYABDovxntZJnKyIQDYSO/GVWvNyD7osy1FC2Xp9BCEJyDj0Y9neEMEGfKk2EyJRtW0ZqZ6XhFCfoasU0TEzyJTll8RRFYP+In1o2y/lZwpdhMEwUoEdK6jvzbQzvX+C9HNGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261022075727099003)(261022105027099003)(261022113327099003)(261026140227099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Hm+o7sZG6wxyNo4qpn4CBoZ4GsdJcY/FZEuIp+lA4ZcMjEKgwso96FZfoqzdUjjiS7LhQXq83xQAmt7/i90yE/1rcuxsYZKEi+vH+aJF/w2pkYchGDadkLLRvsoWH6JxPxjNB87q//ySQPoGcxkW1lRTSAuxBBTu4iwpkw0Y2NCUd3c6JyyWEhIxwMgugepEMlMAFVYMVfhuF3yxvZ0v9K7QVoaqd88Twcom6llsaMXtqa7a7fZpnD/v6ycMecP+nbun9OSabEEksKBi30iTPs0zY/2RzPHsuf6XtUYqMZVfjg/i0F1mGs3VKnVlxm0tB5GPfYt+xScCrYdKfauzd5j/oMQXp661acKpFPpwW8p5LWBvzBVdFfppPF4BSxwh+k+5sxA+XcEwi8dBngPOLhcC1yYkONrMscj3KJcThgbjGOczkszg2bxt2Jr2LC3X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:35:01.3943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0e4b91-486e-44d8-a163-08df4ba08b54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF44635DB8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Report AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET for the gfx rings with MES,
which the reset uses to map the kernel gfx queue again. Not on SR-IOV
VFs.

The kernel gfx queue and gfx user queue resets then fall back to a soft
reset of the gfx engine before a full reset. The IP block soft reset of
gfx11 only resets the gfx engine then; the whole IP block soft_reset()
isn't used.

Only on GC 11.5.1 (Strix Halo) and 11.5.3 (Krackan) for now, where the
reset was verified to leave running compute work alone. On GC 11.0.0
(Navi31) SOFT_RESET_GFX resets the compute wave crawlers of SPI while
the event/wave counters of CPC keep their value, and compute work that
was running stops making progress. On GC 11.0.1 and 11.0.4 (Phoenix) PFP
doesn't go idle after the reset. The other gfx11 IPs weren't tested.

v4: Not limited to the RS64 firmware anymore, the reset restarts the F32
    PFP and ME of the APUs too (Timur). The soft_reset_engine() callback
    is set by the patch that adds it. No async gfx ring check: they are
    always used now.
v6: Only enable it on GC 11.5.1 and 11.5.3.

Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 824d7914bece..a878aaee1b74 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1965,6 +1965,13 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
+	/* Only on the GC versions it was verified on */
+	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 1) ||
+	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 3)) &&
+	    !amdgpu_sriov_vf(adev) && adev->enable_mes &&
+	    !adev->debug_disable_ip_block_soft_reset)
+		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
+
 	if (!adev->enable_mes_kiq) {
 		r = amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE, 0);
 		if (r) {
-- 
2.50.1

