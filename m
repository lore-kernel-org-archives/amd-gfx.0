Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF0CD70DE8
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 18:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC28210E138;
	Thu, 28 Nov 2024 18:20:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L5pKYZF0";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C311310E138
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 18:20:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3onl4Llrb3hZ7UPmRETAOsTtUaFkOYZN3yTNPupskRJzKaB8fwWxMiAydfjfwda8cHAbZMyy4PQbdnS1OLku8nhSBxnZN+Ih2qR20h0ia3YyEC4lhsFMXLxwHLK8HrvCpXW0Xclr6mGvtkAuD33QmbZq5i6M3gLPKDQ9BfIdBEjiFRvul7hCv+STZeLuURp9U6nUVBd2WE5oJwN7m9AKMP3pJNFRxy5GTNr/TihJWdbB1sebII4hfjKMBTuy+uajAqPpa4EMh174yZxFvvIrDAU4jaFVtfLTutJB8cqZvaFgqrzEVWpx4vqNgUWY/mQuXffsCwXjOuR2d/OD45oQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=om7pR1O1dMcdP28cnMfBpz2ZifEqwu8ivi/HkbuE0U0=;
 b=OMrNw+xgv6fqOmesbOxX9+KL6eCFzU2zUU3DEFDhXdSYUjluCVHe03QhEpCvBzZQO+ez42io7TwS9Nkvg+DAucgYagRkUxGpSFLtZWoS49X96tA+pYlUKlqEcx84pAH1K5yngcDsQ/txk7uiDuwrVnV2Md5xJbgnoDQ+NEu6qcfMT0RncykAuMuYUy2+PGdktrsz6ZFuL3DaUV96kqdWcNr57iFvhb1SPcBL4DK6HIlPyaUQVYmQxgqJK4yqbHWeWvD2Od5VRQnR2bJiZdAmlc2oPy8p7ZpojwORW9mYQiaAGxhXkn3UEXI7QYSTnnVX9Rrx1+M8BqrSv1OZDeuxyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=om7pR1O1dMcdP28cnMfBpz2ZifEqwu8ivi/HkbuE0U0=;
 b=L5pKYZF01/1OXui1z99pS2N0mzXZQ/LjJVmvq81Sad6P/OQWq8/CCSp/ZYz/UyovZIHFoHh7FvhbDb3g/pFCpwHqNUk8MqL6PCqJOYOlOsMii2FKMcj650XmEd2RwmZHVMzfE/80eZJsLTFNqKQgDLN1SD7yJbebCC6LKsKaBEc=
Received: from BN7PR02CA0036.namprd02.prod.outlook.com (2603:10b6:408:20::49)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 18:20:13 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:408:20:cafe::b2) by BN7PR02CA0036.outlook.office365.com
 (2603:10b6:408:20::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Thu,
 28 Nov 2024 18:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 18:20:12 +0000
Received: from ssomasek-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 12:20:12 -0600
From: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
Subject: [PATCH] drm/amdkfd: add MEC version that supports no PCIe atomics for
 GFX12
Date: Thu, 28 Nov 2024 13:19:37 -0500
Message-ID: <20241128181937.158956-1-sreekant.somasekharan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c25c098-4b62-41f1-4fd4-08dd0fd94ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zWvMmRPWGJ9Jji2Ui5bk2x7tdRLu12K15CuBMZhy5E6OxSy1ObxiOahj+3Wa?=
 =?us-ascii?Q?qPXNEerSlLopRMMh8dIZnyqzFYOCjP7srtY1kfVOkFRIAszwcDYsGlJkwEBR?=
 =?us-ascii?Q?x6Uc3b5te4ks9+unNfTWjhMezDbThcEvb6hAO2H/6bB/aGxpF4FxigIZnc4o?=
 =?us-ascii?Q?LIKuQHyHxgALwdDArZCmCiN+mRxQ/2HcKjL3Uh+pFpzD/o8gnNTtF++xQelE?=
 =?us-ascii?Q?Hnox3YmDuWXNqx87XCgVRFaj/OmtM9WZ16vHvXaH/DoXIKslvlcqHyFmYeG0?=
 =?us-ascii?Q?P0mAFsyGasFuKRJFUT29laJKTX+nuWRnmc1f6OaSOt+JuU97akR/9Ppjb7sJ?=
 =?us-ascii?Q?SswIkHpMYgzduYhdp+kTcDGqtOvw4xl00kGtHOr9sh+L/hl4PvFdHYGad5QW?=
 =?us-ascii?Q?1YUtSHv30wpQWYounospHHoAbFI4PqBBJujB0lMJ1eGsp5MxmwSvxQ/25RGa?=
 =?us-ascii?Q?EZa1kfXhUdQ2LShzOeZFpIyibXNnP3HGsRiLj/B/EXiEG75zNaJHOGijz6O+?=
 =?us-ascii?Q?AFrpOTQdNwu7vwmlYIOdW3KJEUtfIrSqF24JmSHPxjZITaACnEDzfHyLrGnA?=
 =?us-ascii?Q?IISx8zdUyCDXx7uM9AKxMu1CpLH9HURjv1p7m1/0zDsq8IDLnyAdbj5+eIuh?=
 =?us-ascii?Q?dyM8Pi0MzcH3XvJB5GtGlWnsUGiLETx4vKz4tK90EY6LWKsF7tUCZv1TTmrw?=
 =?us-ascii?Q?8lzcGNr26ObSpxsSTHUlOEG00xfnX2z8Sg+HwNdgaKLcJWdmOJY+9fc3eyia?=
 =?us-ascii?Q?MO9sIVfWT+X5r3G8Uiap/QwKxK+oKfAUOVZQes7KBlhtkZSbN3KAkVMNKMuk?=
 =?us-ascii?Q?UHHd3A/dobb1uYQyF08Oiwff+wPA7ez+Xrr8nNkbj0hxkzV7DtJI3C/g/xOb?=
 =?us-ascii?Q?hnDx8GdCtbD2R3BtnlSKwBhqAqdPnK+egOc99zcWf0yo3l6sj49RTmDUcfhs?=
 =?us-ascii?Q?qOYinHLnmbuLGDQ1SrJAKh/6uHLYQduuz//sIZ/QyIS4NMeZkCQHfPwDQPrQ?=
 =?us-ascii?Q?jkCR/PdlJ0IFYqdzcCiCATDy3A/IDQGlvrQrbWBGpDNHiEEzTdnU+EWI2fjV?=
 =?us-ascii?Q?fR673k/6YcXOQeRZPYUO/eRitfyumcC0oTl0Rc+9tNfylSM4EcFzBcW0GtBd?=
 =?us-ascii?Q?MY2RpoG4FNQuABTkqhQ+II3gLd854D7g+XHs4Mc+VDzQdRif8hajRutPQMGV?=
 =?us-ascii?Q?/2b5EzWBC+nDOk4TBxb1R3qq5GxqEF2GgIVqefqYGi9pJU/sVJv/cMBAb3ij?=
 =?us-ascii?Q?0YfacZogOgF2Qi9ax5FOYvtJW4q/lN5hhTY7U8ONDYNWRIx9oGyra8LWW9o3?=
 =?us-ascii?Q?REMt4l4Us7Hp7+u7WjLNVNQOOCe4J7TZrdD2oz64DS7x2cZQP02J9XYvQBW8?=
 =?us-ascii?Q?bU8OiJiLZpSu9vMDJcOvBD2xCd5Nhx7SqPYGe2z/TRizaLa5utlvwRqaxF3l?=
 =?us-ascii?Q?xboZV6UhDBZ7KuV0KrwbAmAAjg8kT1dT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 18:20:12.8663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c25c098-4b62-41f1-4fd4-08dd0fd94ceb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506
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

Add MEC version from which alternate support for no PCIe atomics
is provided so that device is not skipped during KFD device init in
GFX1200/GFX1201.

Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 956198da7859..891ce1d0dbbe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -237,6 +237,7 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
 			kfd->device_info.no_atomic_fw_version = kfd->adev->gfx.rs64_enable ? 509 : 0;
 		} else {
 			kfd->device_info.needs_pci_atomics = true;
+			kfd->device_info.no_atomic_fw_version = 2090;
 		}
 	} else {
 		kfd->device_info.doorbell_size = 4;
-- 
2.34.1

