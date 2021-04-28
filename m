Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98363C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 01:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453DA61026
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 01:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453DA61026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E98D16E057;
	Wed, 28 Apr 2021 01:43:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18DC56E04A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 01:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C47o4JNgyy2mZ2i8QVEKuVdG3lWj6C/EuWRwHtCfhRnyfzIhoQFhFozgEudOwFp7/cV9FBVl8t/xiQrb2nfhJYeANTiamTvdlmb4CrGy5PErnF/VREKW101s+x3jqsehFbGm07a/nZ/BjqyAL1E5PxBbgXOSBuL33Ur5ox+NSmN3PRMl/fb+hqfMia/puZgr/H/iR/KBbRG9U8Wj83DDLmRo58E9q+C8N9WR+WBgiM1M7wzoAerj9gDFle/ZAlZRiU0C76Rm4HsMKGHur1l8BryfXmWkC+W999T3UktCdFqN4ruDi4iLUfvm8cLD1ITyx0tnW6CVUK5GoEF01MaPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XH2C3NMF3WEN32v1o8g6rQlEjb2UGe4t+6uPqxr6+aU=;
 b=GTNRV6NjjCc2IId7hCdey9W+sjBu7rDvfoCEkcFRfGnPIcHr1auuwET6/WKyysmwdWf6mtOAXKTV0iE+Uq6Zk2Tsl+7ZzlM7sRarkU4wV5ZO9RutX3cPIbLBEht3LwfIV6sokLlmJ0Dikk5eEsuumR2JP34X+XraODrcG+aFbLQtTg3aCp0SZDKshmArgDno2YVFO+1xv9mN2XtzwMOJGlATbf61E3F2YW+tmdwjgPwsXV36iQnpJujoJPy0cq0cYmLWPKAO3wdoHAs7cWRQ2vD304yoWPJMQ4blVJv+NqErru9WetEZOSrOVYBf93nRamf5anBFfyxLgLkBo87ZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XH2C3NMF3WEN32v1o8g6rQlEjb2UGe4t+6uPqxr6+aU=;
 b=jvYdoeZT9M0aBYCjB4PSvOTzK7BOfRmSq/BZtNfk+HOjJB2n10LkxA0y4rWNDNj3UKy5Fpzs7e+DhwZJSu6+YHALT3GFKeo8KJVb+MgNwkhyb+CwBPIhX+XEKtP5SMFDUBoajswN9eHLMlZTSth5pDXBBSgDg0DGSt1UR1o2Jh8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22; Wed, 28 Apr 2021 01:43:30 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 01:43:30 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: expose pmfw attached timestamp on Aldebaran
Date: Wed, 28 Apr 2021 09:43:05 +0800
Message-Id: <20210428014305.1736511-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210428014305.1736511-1-evan.quan@amd.com>
References: <20210428014305.1736511-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0302CA0015.apcprd03.prod.outlook.com (2603:1096:202::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.16 via Frontend Transport; Wed, 28 Apr 2021 01:43:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11063cd2-868a-456b-58db-08d909e706b5
X-MS-TrafficTypeDiagnostic: DM5PR12MB2502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25022CACFDD5081017134377E4409@DM5PR12MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iu9rdPEiu/LP/hLE+Cr1T6iDSwzUVtu8Rsofecr7Z6e6MYjyAFW33tzpj4E483pdG2/m/p1yGn4Q87SRyTSkggaryZsf+2hcbsIvvhDe5W1kku4IlTElgcE5nZss99mjmYmIsnsGT6xDMN78jV4MevsoHkfvyKCeKd6+96F43uwQpXLtKbrbDAF8CKYqZQ9ytbFVMx/ouAYc/zqPJx+pPz5VWfoZnKINvzx5CYCggjy6z9FnFMvGMMrRvsYHTpDKiFrRngg4lSKZdtvCAvPSY7xO+5hGL0uHpLKRTzLPXY9qlDR01DJGlxREaA4ufdfhshA+nPAvWq+cGhHTRsfn1XQ/OUSvIQD2Fx+OtD0O9xs1R4cLGHY4kkmkeGpxe4ke9WiixJUGfrMSuIc3LtP7mbC/bSiCoEzjCHaCPnAB1/sOXPiQ5NKYjB7T6Q5MAe8rJoDoHvPH//DDgvSQ4E/Fi2+/yoi8AoUV7uTM4cLvUaB0vEzJ9wBp0ssjmyiJtMWqRTqbHrfrVQLcAAlwmCe6H4S1AgaLGCinhzkSmA7etP/+VRHMD9A40hHVcKLgw/wpzN0TISEaBEq/LmTJwgcAZGbO0BcRPGmkNnJDVCljSipu+nKYG51eSIEsa72DOv4RX8gNm1b/G4txLrZpOLHaBm4GP6pPq7vDFl++8U4cXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(6916009)(316002)(44832011)(2906002)(478600001)(16526019)(5660300002)(26005)(8676002)(52116002)(7696005)(66946007)(66556008)(66476007)(36756003)(38100700002)(8936002)(1076003)(956004)(6486002)(83380400001)(186003)(4326008)(6666004)(38350700002)(2616005)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?I0xqIsS/+HSyK2+ZK9tGm8mozG/pjaRwhtb5F6ePP+MjMnS9Akn6oQMgH8wC?=
 =?us-ascii?Q?QG+4H4I9UBpVOQZKIqiUxpli95fcs0xSPGoLpzfMhMRuSYxQg9Ud1GCOvoi7?=
 =?us-ascii?Q?x9PpJun9Yn7ieDRgIPnD+goh4YQePk2nDFRYwJb6m1B+fx3JIzMCSX2fVuUT?=
 =?us-ascii?Q?hpFSw1yNgSKYFSocqCIFElMvnZRyvBF6cQ9AWBAXW4YoEBfFbBdnk8RpJX7E?=
 =?us-ascii?Q?Xk3zFlVOY0tmzfGGN9d4VWg4NgQEnu5i7qhC4n+rmuKGsTXB/iORRfFQZAbs?=
 =?us-ascii?Q?+f6C8L79CnNbiPNozkhjrLz4611vxsoovY5txXg9G1dY7DTKHDsbWbMU5UbU?=
 =?us-ascii?Q?K/rgXASxLly53gRCV/cFJEKvqY7HuzwHl6GI2CPee9/i6wO+okEV5ezREZVb?=
 =?us-ascii?Q?irIi0YZEmyjmYKmyNMCmoThpj2xL5wbcKyfsOV/a08kd7qJ6sdcQHmI17AoP?=
 =?us-ascii?Q?irs5VuqLMUgxOfY1Yw7JteJM9caxw9WvlrZ2uMnCBuJRsXtL9wyW3miK/WVl?=
 =?us-ascii?Q?7XlZBhxWfbpaNBStGxaZEVPF1SDZhOCsdTESnXA27P2kpYkJq07KgY/hTOlS?=
 =?us-ascii?Q?MOUqNnEJG5sZ6nFaLfc4LLLfeCFB1GGypry1pXw9USlVTdrMnLE6shlXQYB7?=
 =?us-ascii?Q?1O8bLpvnkeqgZflNGXozddva8K6p4hHEZdIlguZzF80FO3B1HbSp0tdFrFEY?=
 =?us-ascii?Q?1X2bE3RpiVBYHB589fh8TfifBJF3cQG+K57Nw+ZF4nzIwbOIUGPOpPxVYPV/?=
 =?us-ascii?Q?sMUlhNvOLZv1wRpDt+ErpLaTnWA78Y0s+N+LSyd6Nev7iN/CPJoMKxSRVJpw?=
 =?us-ascii?Q?FL1ZaR6qIEaANJ6Oob4aLjrcdtVs7ruUh8LEyo97NNo7g6WmTaG4ypfDOIba?=
 =?us-ascii?Q?Vqlf7rq5EOp7LPEC/ckRtr/22H0mD3bdewxktm/CSoQv629zle5e91Lo5LD1?=
 =?us-ascii?Q?n+DEZWOP7KGEb9l1qYF6qCFg4X3fWE2c4KddRN+JliyfpTmWomiMXhLGY9rr?=
 =?us-ascii?Q?IV5gr5PbfPhcEWfBzbAXfgku7YW8m1sMDXz6EL5+cMS1JUJGtpvCbL8glhbd?=
 =?us-ascii?Q?8Ieo+vNjNuPE/Iatc0v7bh/Crn9tA9MWdD2RxUz8GV0UnxCWBEeVu6Ua+xBo?=
 =?us-ascii?Q?ZwbfKDtRryk75qk+Cix2YKW+drlPox6oOBpCr4ggyevcu1T0DHvqWscdnBM4?=
 =?us-ascii?Q?FoRdTrgsWkAy1oY7T1ntGcSzyeKsiPRwKVJsfd5V/gukOF+iGwVP6lN7IQmZ?=
 =?us-ascii?Q?ga4G8SQWNQk/9e/3YF/NN2gGlYArkkQLE+lpkbPO42+NIaiJKZRk/CQuyQUR?=
 =?us-ascii?Q?Yvm/XJbR5pfOrZ+Zf8u5rpgr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11063cd2-868a-456b-58db-08d909e706b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 01:43:30.5838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Op5OpGzlyHfgIpeFROsBbzfZRTnlpUfxp+x2KeQPbkUGPUyybjdHBY1OeJ+jSotW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Harish.Kasiviswanathan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Available with 68.18.0 and later PMFWs.

Change-Id: I0d7e61875101b476ab50f74ade6dc2aaf1e0bc24
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 13 ++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  3 +++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 771e2f0acdd3..5d04a1dfdfd8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -209,7 +209,7 @@ static int aldebaran_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_2);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
 		kfree(smu_table->metrics_table);
@@ -1632,8 +1632,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 					 void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_2 *gpu_metrics =
+		(struct gpu_metrics_v1_2 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int i, ret = 0;
 
@@ -1643,7 +1643,7 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 2);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -1690,9 +1690,12 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	for (i = 0; i < NUM_HBM_INSTANCES; i++)
 		gpu_metrics->temperature_hbm[i] = metrics.TemperatureAllHBM[i];
 
+	gpu_metrics->firmware_timestamp = ((uint64_t)metrics.TimeStampHigh << 32) |
+					metrics.TimeStampLow;
+
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_2);
 }
 
 static int aldebaran_mode2_reset(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 9240461ed1ef..fd0bc1a79574 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -763,6 +763,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(1, 1):
 		structure_size = sizeof(struct gpu_metrics_v1_1);
 		break;
+	case METRICS_VERSION(1, 2):
+		structure_size = sizeof(struct gpu_metrics_v1_2);
+		break;
 	case METRICS_VERSION(2, 0):
 		structure_size = sizeof(struct gpu_metrics_v2_0);
 		break;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
