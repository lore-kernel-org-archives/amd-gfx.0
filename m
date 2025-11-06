Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD35CCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 08:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DA510E859;
	Thu,  6 Nov 2025 08:51:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PK3KYUSE";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012070.outbound.protection.outlook.com
 [40.93.195.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B0F10E84F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 08:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSdT9+bSuGkshdhERe07Z9Cqa1JUlLiCWyOMQRzKgxi+YnrpT6OggkNI/FOAJBco3JqyGVoPWYeMZ/qGo4VLwWwedhCOiUGMlzkVODeIHruFxOfCE7Ih5nG4aUgc5cFa9AMODj9dtFKB2Q19BY/u9BMgX1lvkjhi1mFFLbwPp3ZePUE4Zjg9592BcWf732FND3IGataa3hMKHUNb71HvYDYo4WuhFoz+U+64YfhTiX3zwe5fV5lv1b3tvLj+mYFDbSWgcz4BpSf4FL7HYRGUrOS4opmte5fcMC3962INRGWzn8wo2gnwYom95ZmxCqsxdiLdh9iD5VCblZwBV242vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx5wH9NstwfJ6VkxbTwhV6jfTpRA4iOLW5OGt/hdSHM=;
 b=SB/8ECVT8B5ARSo8nEmAAUYcjQI9Ihi6A8GgMoyWTZQCzQ+3SXE3ytoNdKJm3sN5AAbwg1Oe9rs1DmbD1aicNMctMRfsv2LEpl4o7TDUfI93sRERlL5W6+F9oYdWkdX2VXYoPHhnXlhN3edXF0xK3L/XWmEX8/fve4f7lVL3aJO4ORu7IkggW6kc1SvDYRgABIns79dT1evi49KWfMtHIvB+yMsWyNR/DupIyhRmaRmez9CzQJ6SzSOmLkcNCbAZpVqGCYkioSbvjV8GcMA1CkRDroGvQmpnxYGkV8NRVHAzavdKJ/lt0DlbXuFphh5qXu4sdePk5HzbvUfBMeB+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx5wH9NstwfJ6VkxbTwhV6jfTpRA4iOLW5OGt/hdSHM=;
 b=PK3KYUSERWSUgtfUOTDzC2wFfn1P2o4aI6VFHrdwBCwEQRvUKD4+fNkuE4pgd9ENMVd3XBXzWkyAvwREbZRtVn3TzrZM7nLAmPMaFTbn3M9KCFUIjSBeEKXv+xYbH4JLUm1q4gHc/U8LHZunXx31T1LcN1KesEU9EoNhxPwvo64=
Received: from BN9PR03CA0511.namprd03.prod.outlook.com (2603:10b6:408:131::6)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 08:51:49 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::e3) by BN9PR03CA0511.outlook.office365.com
 (2603:10b6:408:131::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Thu,
 6 Nov 2025 08:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 08:51:49 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 6 Nov 2025 00:51:47 -0800
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH] drm/amd/pm: remove unnecessary prints for smu busy
Date: Thu, 6 Nov 2025 16:51:25 +0800
Message-ID: <20251106085125.1949875-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: d42e27d0-cf83-482b-c0c4-08de1d11b94d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?McCpGuo04cWm0ftZRydWKVU4bRHsas2V61a68UwJImfebiU6489zj/uvyABA?=
 =?us-ascii?Q?WB2IMWevzZ5ancFMNcaHfEU2NduwzhAjjXszEmuCWOgDaTDMjPXHaS4pOf7b?=
 =?us-ascii?Q?3ti/1k8B9Ygty4vY3DqhFLlIfEoPn98ykkXlhmJbvwVzx8zuC1URp2/qWU7I?=
 =?us-ascii?Q?Y+Qti7N8pFD+5V9wPHSU6wZ3NX/YM7HBa3/JvAwiYR8IACPQekL0UZrohk3H?=
 =?us-ascii?Q?5kTwVH66068ETIR1EtM8JKFEgI8nRMmFWzjvv5ap4Ag0Ht9XRHN1T2I+Qjkb?=
 =?us-ascii?Q?miGG+RxfmiCn82JjV3JfsKnbnkg7r7Bh7U8ftvoJXoUEIx0rgLpGZhNti/XB?=
 =?us-ascii?Q?0O8HJSKrfmIQRPYM7Qe0lxszGQ3Yf/I0DoMC0wEnLanJc1I1U/45dZDddnHD?=
 =?us-ascii?Q?NGpRpb0Uq5TK3QQBRo2fYP+p1f2RdogXGYFNbjO3ytgEuSeMd2FMgg6c12WT?=
 =?us-ascii?Q?GMzpxNJBZASc+lHALqlFe7WQ05ari/2gQCT/YjdBfPxOGg+F8GwkAgIQqGrO?=
 =?us-ascii?Q?qmNG2lTea0VL5f35J2Vnm0TKFhtcf2MX8M9bp84DQ/QXuSJubrvq9v04Mj/N?=
 =?us-ascii?Q?bNLeDUTXJfHeDmk53yR3bYPq1lL79u7ILlze9VcLmlwBSxkARnY6K8+aDikb?=
 =?us-ascii?Q?AxuVyDKqLI9SBsCpMHRU+CIwumnsRoNQGu9etc9Nmza43N2C3632vPFViGpf?=
 =?us-ascii?Q?COhf0dRuwu23vL2sOD0Es9aHfUz5X4b8wk40qYN530u86eosv9pBPGGktJJ9?=
 =?us-ascii?Q?dwnlaPjYD9wodFZHFPivP1GYve9WI5ychXv0GZC90Doxj2G0r9yupUuiVnYe?=
 =?us-ascii?Q?9gDvTkvStMkW7k+CwNNkdCQU4gEDeqie5OREwLcayZcpiLcXD2Pu4WIY6euP?=
 =?us-ascii?Q?htXyWsTwcZICF6ErlcJ90r9CEgL0A9S2o7BFtyc/qPX/lgOwB/8vbxTzkyv6?=
 =?us-ascii?Q?GywHXZjf1WowjmI8WRW+OsK7A9q1QKg+87PDEJ0fnQut/jH4O574dYoMb8dk?=
 =?us-ascii?Q?WYmv7K2CKSIOTouqVgIIdG6SMS4YNn5bgAxlZufCP74uKeH027yhqfNod0yJ?=
 =?us-ascii?Q?XRw27WqEq8Kb0YV4wZg+vYo3Ost6O4x0KDVfWv7xxet6WOrEcvT2XMFCfYlT?=
 =?us-ascii?Q?fX+laalWufj71mnHt1k52/4/Y+iq6GiiwiO1xJyitHQTVPrjSV7FgxydjR5n?=
 =?us-ascii?Q?2udmncdARL90ovr1HRhL/4SxA/E/fQ/Kn5mmrHlq8UGVNcQtLn3On3EfQPMt?=
 =?us-ascii?Q?sED5A9D4THzv2lnwqo2phKdXX9Lk3jd9TKqxnFMB+ApLkaxTf/lROUeNG4b8?=
 =?us-ascii?Q?C5mo0SkHOf/KzbjDRtNFSSBnKhYSvldXHVmN8phLhuDm6VyRS9qNm3DnICw/?=
 =?us-ascii?Q?94zyzPnDT+JWcqejOKUFC7nuCuYFB0t0oKr8H/H9xU0ptwfRpgLhxBh5yMAy?=
 =?us-ascii?Q?Q4t4zkjUx1AaozAaIyEmF/0b4OJ4VJl7uvAcWwjwYJr9OArhZ/2aU7LcoHWL?=
 =?us-ascii?Q?jsoctxW8KDWmS33NFfoSJT8186SslJMX1hNGN82+p4TWZllOjWwk/Ow28How?=
 =?us-ascii?Q?xkYQMBROYoBGvbgSdv0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 08:51:49.3296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d42e27d0-cf83-482b-c0c4-08de1d11b94d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884
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

smu busy is a normal case when calling SMU_MSG_GetBadPageCount, so no need
to print error status at each time.Instead, only print error status when
timeout given by user is reached.

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                | 10 +++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 0ce8cff27bf9..fc580800609c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -956,6 +956,8 @@ static int smu_v13_0_12_get_badpage_count(struct amdgpu_device *adev, uint32_t *
 		now = (uint64_t)ktime_to_ms(ktime_get());
 	} while (now < end);
 
+	dev_err(adev->dev,
+			 "smu get bad page count timeout!\n");
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 3b98065dac1d..4040ff926544 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -164,9 +164,13 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
 				    msg_index, param, message);
 		break;
 	case SMU_RESP_BUSY_OTHER:
-		dev_err_ratelimited(adev->dev,
-				    "SMU: I'm very busy for your command: index:%d param:0x%08X message:%s",
-				    msg_index, param, message);
+		/* It is normal for SMU_MSG_GetBadPageCount to return busy
+		 * so don't print error at this case.
+		 */
+		if (msg != SMU_MSG_GetBadPageCount)
+			dev_err_ratelimited(adev->dev,
+						"SMU: I'm very busy for your command: index:%d param:0x%08X message:%s",
+						msg_index, param, message);
 		break;
 	case SMU_RESP_DEBUG_END:
 		dev_err_ratelimited(adev->dev,
-- 
2.34.1

