Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB49C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 13:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208B22076D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 13:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="szrH1/wT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208B22076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C47D16EAAE;
	Wed, 14 Oct 2020 13:53:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B087A6EA9F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 13:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/B0WwrEwebwasM14RxxgEMuRktC9wAfBlEjkZa2iDIDDUOobv0StBfn/Ctq0KAh/AjrIcX0ZcU0YVthCoSBhLf8PPLDVE2vC7qOGNKv7s0O+fl8lvh6l8GRE8amb29KEVj51sHTODezxAdllfl1zUlJJAD4crud156EJNOSZ+VqmroF54/e3Lli3wo+R5K45zg9XHipeIqOgk0yr6TewdxkLF+TtGD1xL5x8DAk1qDMUmzWhEZZB9Uh5q92nF95U6+61kquIezNEcd2FcYdYmEKBcCh/x/fxW4EHx9x4cnUzABWIt4SsSM5gPo1Jo9YTeFohuEmLEk5QPeSif+N5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHS/88PnEBhMBAaqecLSt9TeL8b1fhWZHj5S+Bg/Owc=;
 b=nI5EqI2/g8J72hPKrpCOrUKzmGXPtAH6dH8/dVZPjFDlngFNuoNs5z9WaUTt8CXOddtO+PyilMnxos28DKX0MzWPEhVNkH26i6OPX6v7aaSo5mqDcv4Uu4amk9GaYbxaVUC9oK/bIPKNYtWsoisNHrwuTs1hYDsZ04kIJf575TOmXrKf/tMMCnD4C+ZvhKflg3pCJXak8xDo1Jp1C+MIllIeKuLgogVYPVc83t4//2nQkdIpofWhvBNk0LjLn7VOOcbPMDBQY8NMF4w5SN8HTG1wcYhikJi9ytpGBsDoceaqTBFfve6Uus/paLOgsNRwNJxUIfpcolyjeA1AgngGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHS/88PnEBhMBAaqecLSt9TeL8b1fhWZHj5S+Bg/Owc=;
 b=szrH1/wT3HfcJziaNNeUdd8vLHR96x5f1N3pXvka4M7eu3UDTDIu3emwutZvCecJhPtvC5b2Ca4Uz3nQySb/vGffjd8IxIXBcHVlCdaaqUemad4tKNR0m3ZKjm7vvVJyA/R0hmN1rcEPBzTKt4PEGPsN7u9UPU/zUZB0WRcMrzI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Wed, 14 Oct
 2020 13:53:07 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 13:53:07 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: enable only one compute queue for raven
Date: Wed, 14 Oct 2020 15:52:42 +0200
Message-Id: <20201014135242.24619-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014135242.24619-1-nirmoy.das@amd.com>
References: <20201014135242.24619-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.103.243]
X-ClientProxiedBy: AM0PR05CA0083.eurprd05.prod.outlook.com
 (2603:10a6:208:136::23) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.103.243) by
 AM0PR05CA0083.eurprd05.prod.outlook.com (2603:10a6:208:136::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend
 Transport; Wed, 14 Oct 2020 13:53:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 803911ea-40ca-4842-625a-08d870487a5f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB316306543AD0A356FF6D18B08B050@DM6PR12MB3163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMfL6M5R35K/KP7e+EiJJW04xghyRfbyhmLVPBqDI1FFysqkM5RGYije+mnl7idgAEzvh4xS1XbSp8Nn6TzmgH6/F9eKjV114LjZIMKBXnN6ZMvbg27d1ucG5hhyZcAM3kBW5eG1cPLUi5UoMgNXxlureRMQqT1IEgNF/qT48BoYnfrLCayI2t4DxCzK7WoNnFFYNTAy4Q5U/o+8mjCPyOt8YLaR52Cw1g/IIhoLEhXyFsMY7TWngHCItnVSSzSV9mfA7pVZeY8n+nS7VRBIAo2wsWnIbl4m01WcFjoLHL2SLfJ30vvODwJFoX9Kw/g5qv2XyEi8mcvf2LNZaIDaYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(52116002)(6506007)(186003)(16526019)(6512007)(2616005)(2906002)(316002)(8936002)(6486002)(26005)(8676002)(1076003)(478600001)(6916009)(956004)(4326008)(66946007)(83380400001)(6666004)(44832011)(66556008)(86362001)(36756003)(5660300002)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZDEjUymggsHaNlUv7R7/s+Jc1Z2be7f53JUSoUJ23QILvEIn6o+y7rZHpJtjVqF4YZYfF1M1AVCn/MLndfhiznjal16m0USJ6sDZLaaizPKBAY/5/7TN1foPrq5XD/ZVxnhZJHhhPOrSefxXNJXODkALNWrSapByYEI5TN0EH+V4dYRqkiVbYDcwHPCRvrTT8n6ladHxQO6T4pCZQ27DxbbBaHt7HATJdEjjpALgOJoWX/9XuD4+xVcGLWTeegM32tkeqYerOd0I5lMX3hBK7gXB60fNp7LGjsqMqKeiU9qIEfP96g8cVxibrFJvcm336JtnaW2cCYT++I+In2Y7Im14lmZMlwtfVOZoWMran8Yfi4ZHZ4oxlqVRhjucQcuj6jSC7hW9TbPANp9DfSV9Nezb23S2lZxseRh9Z5j7q/iDdff/KLDG5Jscd5PJglD2Up8XvYe+nvqUX+CBPjbeXEkVI7NSUgICAxu32tcOpJOokH/uxUdLHw1DgkW0RpBv2K5aP2MXyKL4vg5aWMCEh3sClGmyMUgBIRmPNDpEKL5RgcPQMSarZS0MSSSpHSwlurjRthKfjFHMfckblHwy+G5jbxmA4A4dQzOtZLXKmFJONQowUz3+NQNz0VgVgMRdrKDQ8AEhUdOPMpL/8jTyRQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803911ea-40ca-4842-625a-08d870487a5f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 13:53:06.8561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFq6OehiZV2teEqdJ8Mr82Yqcgu1NX5B8Vcv0AXMtSO6uXV9SuEfmp9gOpqF4Ya+2PCTr2v1F8DI1e8fi9SIwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3163
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com, Guchun.Chen@amd.com, Aaron.Liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Because of firmware bug, Raven asics can't handle jobs
scheduled to multiple compute queues. So enable only one
compute queue till we have a firmware fix.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 11 ++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 8c9bacfdbc30..ca2ac985b300 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -195,6 +195,10 @@ static bool amdgpu_gfx_is_multipipe_capable(struct amdgpu_device *adev)
 bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
 					       int queue)
 {
+	/* We only enable one compute queue for Raven */
+	if (adev->asic_type == CHIP_RAVEN)
+		return false;
+
 	/* Policy: make queue 0 of each pipe as high priority compute queue */
 	return (queue == 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 0d8e203b10ef..f3fc9ad8bc20 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4633,7 +4633,16 @@ static int gfx_v9_0_early_init(void *handle)
 		adev->gfx.num_gfx_rings = 0;
 	else
 		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
-	adev->gfx.num_compute_rings = amdgpu_num_kcq;
+
+	/* raven firmware currently can not load balance jobs
+	 * among multiple compute queues. Enable only one
+	 * compute queue till we have a firmware fix.
+	 */
+	if (adev->asic_type == CHIP_RAVEN)
+		adev->gfx.num_compute_rings = 1;
+	else
+		adev->gfx.num_compute_rings = amdgpu_num_kcq;
+
 	gfx_v9_0_set_kiq_pm4_funcs(adev);
 	gfx_v9_0_set_ring_funcs(adev);
 	gfx_v9_0_set_irq_funcs(adev);
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
