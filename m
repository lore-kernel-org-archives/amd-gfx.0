Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04603C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E3F64E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E3F64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48DBD6EB9B;
	Wed, 24 Feb 2021 22:22:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 588136EB98
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3LsANZq0iLSvdnTpcF1exDSi1i0hWGd7vd5QVu6apjw/fda+6Yhvd3ek3YlMc6b7B71aKhjOXiOOVKg8l0tkLrYVnbga+a3CeDI/ucFjm6hsjb2Kr7TcwE9QTpSrNXSCzY5NRgpZmf0Hf488IdHW/fVz10BkeANuSkb2zjq925jwsbo+ChaS7S8PASqw4k8pAzYAwhrDV22LrpkfHVutATqlswu94srabDGu6o+YTiciNctuOE+pK6TFeUtwvXBGMnBfAVmrGd/D+RoB27VsXC55jW4fio3djEgGrSYr6a2iu3emyhfaolmbTNjA33+yNq6F9y6KHG6aEBSB+b+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9pshtxCWe3WLobP5rPnbPzkZZoxeZaOftRGYSl3+Zo=;
 b=V2iqG6QlcfpveVjgG3sDg+dWYjDCDd8ft7h5jyWS+EMIGFnKYOEh7Fk4INMX4d2j8etv8ibQpSjEmLRUzHYyPFYzA0z7i/ZekY8OvFAgjcPv1fdKtYRPj1Alyi6OApZCR/FMkAF0X1Rv6TRFudaCQHqT3bDVWb3BRgeYmq7LRjvTqWeUqHBqJcZDlRG7AVw2GA0sDvbf68LMhq9VtsoMu9TDiE139s5yMRW+rnIjDDnNpY3w+mV4b4/2IimlBKxFcYyrmbpZqkab00Nq0ThMFju9EYfw4uU1HnBBTC8UYPE0al3/xHzLm5uwkmwBxdpjNZy+JNDfI0PmXBVGMbocJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9pshtxCWe3WLobP5rPnbPzkZZoxeZaOftRGYSl3+Zo=;
 b=ur2P/GexvSju0E6ikpX12UJIW6X4IwbHJdKqWjgKROjJYi1OLgfQyQaYXKRK4MwGA4BMLZT6gE0fymvMc8ZadiS8mkgSVkfWaX0PWGOTaU5Pn+Pwkm7aia46z1R1aQNzJzGh+VUdavc9WCc0nUlAmSlTjau7GV1UH3A2IVCSnTQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 22:22:28 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:28 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 133/159] drm/amdgpu: Set up vmid0 PDB0
Date: Wed, 24 Feb 2021 17:18:33 -0500
Message-Id: <20210224221859.3068810-126-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 465d688d-9656-42ea-dee9-08d8d91272c0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45039181E3A205FF6E505045F79F9@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7oY3j01JcnEi3exOybOXsz8CAvHo3Zn30Qqasf4DMxYk9W5pq1e9ZaydeXqPICyo11RIy0+uRhSI2ymb3UuwSSzvpr5NVf7dSm6+p0cxxwxSv0sG4ku6iYVNMzN5PHSzNnsPBVR2F+EJHJBkL/xY3LDq6XkL3khmqf5Z/eavSrFYXflG9Sx2xtMe0/mAJkyUMqi3+RCN/mmd69uZfdWRKenqHQjk1fFZkYu/frVUxxlZ5p9p1pqdydU+TQm3jXt0owGK/R8jlWTECTHk3W1JcVxdjbDvXGH+Ph3ILnQt+TWgV6mECTalYtwoH1PageQNTmFAES6dEzHyV0rHiZHV9fO4XLQpucSHgzSlGPpY9yFp3dlK/WLQJEWfTigUI4Z+vbkIWehkmsTJsgimdftZIT1L2vU0tjsMDN0mC0je4A9832bDNSLW5bvTr7TcxAGR/Bibc5WVpAGwjI8ZPxksnzRj1zMkWSel3kWW1Lta8XV+p13WWEasXMRZKMDCjrJAoVSaIZdbevPFYhaMlWNR/g6PGFvJ86UZzbR+92FvMcQ4WMkhoEYtWtehdPD7cw80xMf8ZVF9WXKKfCkDFIksOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(6916009)(52116002)(478600001)(5660300002)(1076003)(4326008)(36756003)(54906003)(6506007)(6486002)(6512007)(66556008)(6666004)(83380400001)(186003)(26005)(66476007)(8676002)(8936002)(2616005)(316002)(956004)(2906002)(86362001)(66946007)(69590400012)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oqYGv6W4vHw1lR20etfF7djQ7yh32H9jx5+t1m4tw8kkniKua9wILUCE0NEl?=
 =?us-ascii?Q?Kgyk4curdsI0DQRPRXhr5eK8A3zGrJha41tFY15pn1gY+91L8yxI+DPHI+Lp?=
 =?us-ascii?Q?IJ6D0r0kAssG0VUvSMN3w+goagGHTi/swlIashprvHqWgM7mVJ87YbI3fPle?=
 =?us-ascii?Q?RCTqSAk4+lwLzM3D6AfGgd9Q1/mQi1wOfNO8CX3dRMOdOlLbqp0BwhosxTl6?=
 =?us-ascii?Q?b3oSx0SeUMXXp1kubzWI3grIbUsdmmgpfYD2gmlgvFrf7kgpkbCh7uU8fIue?=
 =?us-ascii?Q?f+p1s+OZ3WCWF4IUnzdYH2IO2KvJ3PF2sJP+BMOtaQy19j6geJiOpsjfBUkg?=
 =?us-ascii?Q?J4xeSVlL2nPMNYihfEWszkgxeTo1bAHedJq9K/wFWIbfJaKzZpiD6gcK8rZi?=
 =?us-ascii?Q?nNOIQs2V7IZdtpdyCos4VVXfV7QTgJgZL/+TyuvLzQGzLsLgQY3nwj8In1LW?=
 =?us-ascii?Q?vFZcxR6AUGWNANIuMKwTZy5rhSNHroewInad1klzpQiv8OQvXPmxLiwXe/5g?=
 =?us-ascii?Q?tB9z0u6nkZqQN4RSrXGPdlhpL4aRYpZX1h+g9+Et7POxywrOwsQV227ZytB3?=
 =?us-ascii?Q?xv4DSZsi/uUzg/3yu2fCWOmW5mdvVE6iBse93BrkX+V09JPHCx3LLS7kHv4R?=
 =?us-ascii?Q?rmr8Op0AlnBuq5KNSJPZNiRGzn1RglC2+f2LaDXVP6I+NsF7faJ7OT8q+9We?=
 =?us-ascii?Q?LJvBGn0HnMHUt9gYTlPrAZ3txjjesoVqISgkhyVnGLWsj1ZgliOscZ+jaKc8?=
 =?us-ascii?Q?JBo+IBNpMRDA7KYcQhHlf7Fhmq57gisH/5ahRNjfU9UMpDETcEjAysnZ+jkI?=
 =?us-ascii?Q?+sJ/efg5j68W4tuYsFwW0TPR3v30R5+1hJaUzOiQ+k4taH+NpzffU7huFi2a?=
 =?us-ascii?Q?4Z0St9qzrhI2k8JknuMjJe/W0aegmlfjkJjpIS7fzsECaLqIsswgbD10kqo7?=
 =?us-ascii?Q?nYpV7XB3Xg84oab/iPaHmDos6iq7MVW0O5BeDp+SD0sNtTpnPqTcV6ehxIIx?=
 =?us-ascii?Q?zyk8QJ0MqL1s3QrKJwvB9yt24mC971XFc8Oc6lAq52Mdbrv6/3ctYw/49jwV?=
 =?us-ascii?Q?46FIi6y5FYswW/iFyEK5c+YfgruS1TqNSiuXB+tnIKsBvocPFBq2tCv6AqVD?=
 =?us-ascii?Q?QoHGfv2vz7QocnIVwwE35B6hYqesAJ0DUEI/FgSPg6fYFnJrufCbRNQ6QM8j?=
 =?us-ascii?Q?h+LgAYl1h7emu92/hKuxdQtDyF7z1QFFrSp7vYtoobNUdYkqS+KbRgt22lFj?=
 =?us-ascii?Q?LtBzISk5ZR/yLEEm/9TxHYz/0QDb5HC3l/tVUQDSfiXZ1PWyPlMh3TgfhChE?=
 =?us-ascii?Q?UYjE9XeYkSZ0q6fEgNxw9Kij?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465d688d-9656-42ea-dee9-08d8d91272c0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:53.2718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7C1sPGDzkrxVR0Uw3FMmPEQ3GMJKqiP7NN4+y2SavS8n/7do5okfN8WC0aDGA8l9l6EfAB43/BrHmCVhY+Uwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Christian Konig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

If use gart for FB translation, allocate and fill
PDB0.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Christian Konig <christian.koenig@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 28 +++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 96052dc114cd..adc910a6dd19 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1379,7 +1379,16 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 	adev->gart.table_size = adev->gart.num_gpu_pages * 8;
 	adev->gart.gart_pte_flags = AMDGPU_PTE_MTYPE_VG10(MTYPE_UC) |
 				 AMDGPU_PTE_EXECUTABLE;
-	return amdgpu_gart_table_vram_alloc(adev);
+
+	r = amdgpu_gart_table_vram_alloc(adev);
+	if (r)
+		return r;
+
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		r = amdgpu_gmc_pdb0_alloc(adev);
+	}
+
+	return r;
 }
 
 /**
@@ -1566,6 +1575,8 @@ static int gmc_v9_0_sw_fini(void *handle)
 	amdgpu_gart_table_vram_free(adev);
 	amdgpu_bo_fini(adev);
 	amdgpu_gart_fini(adev);
+	if (adev->gmc.pdb0_bo)
+		amdgpu_bo_unref(&adev->gmc.pdb0_bo);
 
 	return 0;
 }
@@ -1624,10 +1635,14 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 {
 	int r;
 
+	if (adev->gmc.xgmi.connected_to_cpu)
+		amdgpu_gmc_init_pdb0(adev);
+
 	if (adev->gart.bo == NULL) {
 		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
 	}
+
 	r = amdgpu_gart_table_vram_pin(adev);
 	if (r)
 		return r;
@@ -1640,9 +1655,14 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
-		 (unsigned)(adev->gmc.gart_size >> 20),
-		 (unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
+	DRM_INFO("PCIE GART of %uM enabled.\n",
+		 (unsigned)(adev->gmc.gart_size >> 20));
+	if (adev->gmc.pdb0_bo)
+		DRM_INFO("PDB0 located at 0x%016llX\n",
+				(unsigned long long)amdgpu_bo_gpu_offset(adev->gmc.pdb0_bo));
+	DRM_INFO("PTB located at 0x%016llX\n",
+			(unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
+
 	adev->gart.ready = true;
 	return 0;
 }
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
