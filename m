Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B503606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HBhnwgR/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C390112A33;
	Fri, 23 Oct 2026 09:09:10 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06E9D112A33
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:09:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnTRG1iZ4fD7RFp1jwXpK37/JTtyz28PUz5XdtvFlc6ufdQLo1WzQxeHWxDtNREMdpuAhCFSrgTM7vwoGJER9SEG8K8Rob+N+kI/gCvArG6zAkt6STQR3pDgrzWWYY8+UV+oatEu24ZL7iCMtDLR0q4TWYHXH5vS2omFoypnM1qx1cxDDNTrvy+W0xoMhVHyNtAD0HVazV+KLjBc0Gs9ZinVeoQKJGo28zdfxA568Wi0c/ij2zPXU/lSH2PLQkSp/fcHZKI8z52cldl1gwNNRMqhFWmnwTu0uC6zSLcNSOI0hG9FZSixAKoo3ro46qD5GKEOeqR3ZVwdn3nU/8FZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5ipuQVBR7+/iEDc79yOTjVxs0xEqoEUlP+Yq3sYb4w=;
 b=SJShUqo1L+rFCL+sW05vNvN2XZqS2qPIfSVdqZ1yki3xLazxPoNrpjHmVz3rYUbn9jYJJ1z4iMcGQ/7f67q6MaaKhst8LoY0HFlqdfqh1OJ1aZnGf/mqETD73XedC35iAzUJtXmwUxrolW3/H8dEbYnbhgTG+O6W6lKrtCfQcFqxbYZAf3FQTRveIgM2+1ZPV8pW0r+eRKcK9bZCemfrc9UN7YlMN1ZFuqnkeP480bgqfx9PHlbmmQmCHOvYz61WLeZPtg21omNs/z/C6lbsktbw2Md3CI/NryesY4GhN6Tn85XCZ2XRx7tW02KEKGKwV9i8fDLhXNpRYrx6r92Rww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5ipuQVBR7+/iEDc79yOTjVxs0xEqoEUlP+Yq3sYb4w=;
 b=HBhnwgR/DXxijdwdFU5oc8yTSFDyJ8hshA+Z/D3SK0yg3lZqOYUq7deVWzqwOubA9cbTt3KWE6TkWXK49nKm/8Z7zyhU13PsGd5BK4n+5tnX7ANA+KZR55z0jMoRoN8CSTTJq8YU28H09A9Yt176AflP6c7vS3J1WmT6la0SaxA=
Received: from MN0P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::11)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 09:08:58 +0000
Received: from IA0PEPF00000046.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::1b) by MN0P221CA0004.outlook.office365.com
 (2603:10b6:208:52a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 09:08:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000046.mail.protection.outlook.com (10.167.249.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 09:08:58 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 04:08:56 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH v2 10/13] drm/amdgpu/gfx12: set pmc_supported for GFX12 family
Date: Fri, 23 Oct 2026 17:08:42 +0800
Message-ID: <20261023090845.670581-11-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023090845.670581-1-lingshan.zhu@amd.com>
References: <20261023090845.670581-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000046:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: da6fce65-bb87-42b7-8261-08df30e54589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|261021123027099003|5023799004|261022075727099003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 0E62pIfja1I1sDnzJR/nJLQ4bG1YR2vCDQhLXi2bm3ERHoeSsnvJTD6zATo7+3HsIAeXOLLZlZb39h9jGGSx797OrcFXPWm2zjCCqTcf8XIg+2bHz3MFxzXpg+WjV6JBjjWjKmt1KwUE/OMVXP5LkwHiAecnHgV5SIPeXnoBHzT3KFgnYbNTSTUnofTU7uU4aRdIKilny0XOVbMe66fXvphuItFtteTKsfIkL7ABnTChVcFR/o5F6BGtmVu8Yk6h8uFKwWuJpW54ag8FLuzguTtvo5cJ5F2gtfP4QbAaJbdxn9HX69I5nqUqWWismQfBu2e0aL4u3mfHGeZD9CUjpMkGvLYP/rDkG1m9A1D5LVsukzffXfU+GX45HySvm+qPrCk7E02jWu7u8diPm8+5GIZnK9OFyQgYqRUtp8c3vIjUA8s4QjiYST1t4DfU7kSXeLXOSnwrDPm57CTYLdQZblgRPvKcK5tDO4fc4ETT8nQ/pkh5PSD8iDGQh85CUnAabtm2txmsATnWN/X+JUsFa1nn9dedobqpEI9qTg01ANyiePZvNjL/3Zvu7OnWPWTrzlzpVbXpMOHZRzzhAHOCiu9E07iO8e99ZXqfL9wyKrdMFMOGDlKLjHeKJMCuN0qcGBCj+pum5K7IqKn3k+2cBLtSyn2FtewqWpVb+YOz4JruH33LYhXrOQhDjEUD5xv9A58BrTvPN3z/v6z2IznE5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(261021123027099003)(5023799004)(261022075727099003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aS0h76kgDIKAJ262cswzsJiovX8DaIGfHxA8e+6PiZWO1//HnvR0DzCK0IMpjRWsf62xJVUY6Og1NEibZq2qwg185gxDdVRNLDux3j6vESrrmCK1IfdTMgwLOVBuK6UU3DMc/PmVyflitglWxuvzFtfYfMZE28A9zsce5R4LV7G1+thORj6J8AtwltqWOfQ7tD7hk+P+fV1xYEtSwH8bJhGvhUoGlI2+IBwP5VOEsGUKK6BfoxmO3JsQsbfGesrJvGV4EFy9219syhhn7cMsHIZU4fX2177wTH55qnAYs0mn3GP7coczY3cPJj/ZUGatmBh30zOLpBfPQZEz4opZiPxuZCsaLeh1xEA9K0cZ5hB1/UgaCRnE9LpIsQRTtFzifC2CB2v6HWOXES/I7BBYsZ7rSA/hZNh3Xd/A1LVxdKpiCTJrrtSQEMZKtwc+nZ7B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:08:58.1835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da6fce65-bb87-42b7-8261-08df30e54589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000046.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some GFX12 models are capable of user queues and have
mqd->compute_perfcount_enable, therefore they
support PMC.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 655b1784860d..fe6e9ac7b170 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1439,6 +1439,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		    adev->mes.fw_version[0] >= 123) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
+			adev->pmc_profiler.supported = true;
 		}
 		break;
 	default:
-- 
2.53.0

