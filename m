Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F30CCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A73410E78B;
	Wed, 29 Oct 2025 10:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jutxZPIH";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A04910E78B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:38:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqDgtCR/gg7TMX9kTKYumQiugKDqlP45jbZcIOx/u1w0QLw2chHvb/bOxiZJqmLKbfHMUTi5l4oLxwkEVce1kWqniB4+zA7e8aDmxyggSzUDe9un01MCAuxGYeSdCoqujvIVU1mQspEXwI/mdpYNWC+ICPH9AX1ljRInlU/vN92bzkPkWZLH0z4RWrW4Q+zcf7Rug+pA4YHI1PXL5HNQfllB7v2IJQp/wSyKsj1/rqBgeYsYuSPR2G6a3DoSzFrmHA5+BtdfwWg82lbTqZwnxq64Z66k0S2+py/j0W/kNb2W2lpzTW+FhAvrh2ZGO/VhIYaWQVsxGhoBlff6uv8DEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPsCeJEs3c7WU1r+oJgUXta0tXkXTklzjLTeWcrQYvQ=;
 b=Bc5F/WuMvclk8kHTWd4lF+Q0prgwhXG/LLONpAW0u17tqloeFyTRUOSPmYSTbQehCRnCYb4I1euOPNA+vWnUKXaereeCMbrbOXKJ2Ax9dUCZ+lu93VrwmDFhMOOAerFSS5knXxcW0kL0z10vsGIrRA4UMO8ujQkCImR9y10vtqRPWP8YI0a9chw6PRoD06Iwp2gQCbuLqKzLpUU1cMsw8g7ZnHtYjt2UdU+g7nCgNJe53W/0qac+zqjwR1aWI1kY3lkYWU+SpMdvZNjthKfek538TE3VpH5rUyV1pVKHirqFXw9pJSrJARfT277VTNzPuq4f1jLnqUY9iqlszlNTww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPsCeJEs3c7WU1r+oJgUXta0tXkXTklzjLTeWcrQYvQ=;
 b=jutxZPIHAPOQdAaHt7Wa2ezwgmHOGGIVknZz1tFb6e33I83l4nclDvuqtr0p09iDXeFzikr0I2hfIM09cVz19L92i3YvgKGcEY7Z6YCb5PaEFhXG03Pp9Ll4MMfoQr0mkrAd/Ten4orZY/v/NQtcr1X33l/iySWCQkt8DmH/3Ys=
Received: from MN2PR15CA0045.namprd15.prod.outlook.com (2603:10b6:208:237::14)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 10:38:19 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::b2) by MN2PR15CA0045.outlook.office365.com
 (2603:10b6:208:237::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 10:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 10:38:19 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 03:38:17 -0700
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 7/8] drm/amdgpu: try for more times if RAS bad page number is
 not updated
Date: Wed, 29 Oct 2025 18:38:01 +0800
Message-ID: <20251029103802.1402199-7-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029103802.1402199-1-tao.zhou1@amd.com>
References: <20251029103802.1402199-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab31222-ddb4-4b22-1710-08de16d74692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BTge01Krmqu5vEc+2QFD2B9JQ5W2S1VRJ28no4b/fzDB0o1/IHSjJmbuP+lK?=
 =?us-ascii?Q?zvYYxw1kvJ7YrH8NPH0P3Pb6LhNfJB1P0Zl83k9H148dr+MaDgrf4S5Ib7wf?=
 =?us-ascii?Q?Y1pvX1Wk/xf9xbTtsEeEMog3kz/Ip1chjuSXvufAarLl/Jr+tDrg0Js/HIX7?=
 =?us-ascii?Q?gTjWe+qWF1Xy1LPyQu8Sa3isr/ZZqX7sg7xjGRSBqQXxdjZQedaeFSbvhNVv?=
 =?us-ascii?Q?W+4xXfMGy4kHdGbwusrtZAfWE8vFNq4txZjL+ayZOlvfPi0av6E7hDGVKUzg?=
 =?us-ascii?Q?ZrMLjNE72c3oYL1qZuOaaYimY0yjyaUG9H6fktsLLU67qsJ+FeIrTdeu9GnW?=
 =?us-ascii?Q?ntk8EYvCdvnhkvyeEWSoQoSb2SRIGsMTRkv6/Z7e7JtJPn+LM6cojemdE9ZS?=
 =?us-ascii?Q?i8brLPxGkZW49mzV2tPNWAzPyZSx1KQuI9tfVKyOA/MSMkcDTeuEjF7dczGg?=
 =?us-ascii?Q?mwWgxOx/9dPsdjrvreODNPS4fMKqHSwZXn3gKWDVdSrPqyFjz6kqORFEbD1H?=
 =?us-ascii?Q?XYjYtcKtPFRxAjyMsbUvgddixBGKDQPEetomLoQCHc6hoaUmpHDxnvyYSeO9?=
 =?us-ascii?Q?0di66WhDiVq3MsNrPyh7dKyFlOWBbbEGpz+A0nbmRCk/0VN6vix61OlhQcA2?=
 =?us-ascii?Q?A10R88cW4BIQg/phLE0zqBt6YfnoDGEK+xUE/QmjjcHup6VnUHDbJ2Fb6Gf3?=
 =?us-ascii?Q?eU5uB8Tm1jgHU9qJQM6tAQuBSWmFeMcsp4Cnglkl/6YqSgk3kILFRJF4xGiP?=
 =?us-ascii?Q?mfeDXZ6uYR/Fd2RdOtVwdwE6d3BAAMRF/qpubxuKGoquMHGMIf6DkTMWGREp?=
 =?us-ascii?Q?QuC4dvSqpU93k+3nSkqeMhnCVPIV/D+0nbPfAPxzyucazk73shxBei21KlpD?=
 =?us-ascii?Q?1Kl4Ud80A04bZGkEcJhZnKbTAsnAP7icIVC1HXTZhIRc1wDlsQPcecJWhxt4?=
 =?us-ascii?Q?1MmaGCpAViON0jJtjllLjAqgDfCA/NtBakc/no5KFqeceu57aF/aaXRvdQ3v?=
 =?us-ascii?Q?YclGj3U7wjpTcLY6I2wETXbRqo7wxQ3Vqs5fva7dMSqXUsBmwMpPFPIBDwxF?=
 =?us-ascii?Q?I5AtaLGmztLi7+X7myIcTCPd2QJRvU2XEPY5hZ9p659ffo6QqjJ2jtFGNLp6?=
 =?us-ascii?Q?2FH+o/RNbL9a/R9elchQKt3Zn9AkRgt8h0RqnZL0IFaaaOxlnXETkGcVUSWj?=
 =?us-ascii?Q?cPEI1cbxvgTdjLcvmn45Lx7+RGRmo6F/XhtEIWL3wWO4rnQNegR20EqmlwXg?=
 =?us-ascii?Q?mpuGUpn3N162/agQS9wx/niLK7nPwY8NNfVBedjchmgplBzU4ZrQf/hpr1G7?=
 =?us-ascii?Q?JFLbvGN7Z4+hz0bWeA034nr2NlETdezqSqqbuXAFFQ2IFPvvUs5DHfS8eNVv?=
 =?us-ascii?Q?16o4eO8ksbzgwJhwy2B58x8cZInkMo1zakTyGZippB5JINFIIqc6Nmbd91JF?=
 =?us-ascii?Q?jn8lCF4FPMyGivj+RiT3oj8vzkVmK5lNv3Zirq7TjDro3W1pWO+P+RXgWJ4W?=
 =?us-ascii?Q?Y60xcXgzpZbGFAy8zx3xRN+5Z0iKO0F//vzqSjSBP/oAAk1lUvCTU/CM5ZrZ?=
 =?us-ascii?Q?YKvwkHVLm6LQr2zIAEQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:38:19.0531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab31222-ddb4-4b22-1710-08de16d74692
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5
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

RAS info update in PMFW is time cost, wait for it.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 511c5882b37e..de7b268a9862 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -867,13 +867,33 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
+	int ret, timeout = 1000;
 
 	if (!amdgpu_ras_smu_eeprom_supported(adev))
 		return 0;
 
 	control->ras_num_recs_old = control->ras_num_recs;
-	return amdgpu_ras_smu_get_badpage_count(adev,
+
+	do {
+		ret = amdgpu_ras_smu_get_badpage_count(adev,
 			&(control->ras_num_recs), 12);
+		if (!ret &&
+		    (control->ras_num_recs_old == control->ras_num_recs)) {
+			/* record number update in PMFW needs some time */
+			msleep(50);
+			timeout -= 50;
+		} else {
+			break;
+		}
+	} while (timeout);
+
+	/* no update of record number is not a real failure,
+	 * don't print warning here
+	 */
+	if (!ret && (control->ras_num_recs_old == control->ras_num_recs))
+		ret = -EINVAL;
+
+	return ret;
 }
 
 /**
-- 
2.34.1

