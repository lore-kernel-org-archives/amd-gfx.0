Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC7FE77184
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 22:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9171910E347;
	Thu, 12 Dec 2024 22:09:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zfnWByRj";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF9F810E2E9
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 22:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtqUUVIOinMQSdMp4A0+DmRkWs0ZsgGgezEwJGpxiSHXJ1LtGcUm3iT3sOPu+PyVBOgRsWFiif8Ql8T79sIpuiKpMoLA95YJa9ODZm7gFbCXbEPoq5IbfYfhJDI6KRHIV+rEQBCJl0f+1yMoT0Qp/Ck4drAB0+Sj78/P59t9TNa85QKxeFPqx1EbDmV1CQIZjR+ZVA8RX8rx3Wh6tu+BSjVa4sQf5rWfAkeP98s9SOH2g0MTgsysnWClGI9fBsiWeVJrV5WtaUse9O759q+OCbn1uEws8uSYYqWdFs1fjkteuRERWy0Qo4XUw4EfJy5vZnLXx9uG7KXPbK224y7Brg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eChDwTj/XTU+H0JMlp45TSg5aWHJDI7qPgYwTjW1+08=;
 b=tZbWVx9CBVwN/0Sld74o1pDPBIoeG7jqo0+1Sqz7wArCXZsjxZDNTLRGbLSf9lUd9cGOeCVy3RDsmlWzuFJjz4gr+xbGX+W6aFDjbLZ8/mQvvap01XVik5IdARoHEB9qRnN/TmP4KkpCRvGZopt4Klgq8Mo/O0HafEOPL62BD37ij2n4U+UALqyeKIuQ+wNyqo2Sn+h0j/RJzRNHg1Byv8VzAhzR8Yd+wqpHNl+vSdXIl76O3jJRfF405NR53ntCPAJytt/9ylqWNsgjQuMCo6e7lYJUw9DH6ZM5v/hHGmLFItCxbf/IAUeNrmXbmyjf8DCxxakrEVNgVDUPSSuoIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eChDwTj/XTU+H0JMlp45TSg5aWHJDI7qPgYwTjW1+08=;
 b=zfnWByRjxQbLr95fBUpimPmRMSM+/WwI2OxuwQVy1/MwL0F5Isj5jSpcqupaCFrfpcbm+UEuy0+ZA1EWpRnc66nKInKvE7/HBQUw8bketsMNVRYUiFRtgvatL5bjl9vl409O33+qLY+ZO2EDBLEkDTpkvIBu5hqc2C7NSTJGizM=
Received: from BL1PR13CA0260.namprd13.prod.outlook.com (2603:10b6:208:2ba::25)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 22:09:12 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::d7) by BL1PR13CA0260.outlook.office365.com
 (2603:10b6:208:2ba::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 22:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 22:09:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 16:09:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu/nbio7.0: fix IP version check
Date: Thu, 12 Dec 2024 17:08:51 -0500
Message-ID: <20241212220855.790502-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212220855.790502-1-alexander.deucher@amd.com>
References: <20241212220855.790502-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: 760784a3-f192-474a-e4ef-08dd1af99bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+/qMc41IvN+tnwBldalFrSzTAVTbsh/QMlgru2NGEI6u/3eK4PJj/gky5uU1?=
 =?us-ascii?Q?uZphm99fra3MpQdzTZICv6oNzzoP52Tg4CQ+lOoxa+hQlh3u4L4rqAR5T0Pf?=
 =?us-ascii?Q?VnXEVH/Vj4A4nwSMy9z62pnsmkIQxlNo45DrmsFHKYHtnirUX7YVDkeUDCZU?=
 =?us-ascii?Q?u5Y4J7/9qbAcAe5EJ6pQfg57SaRGET2NHYFwxvolkki8yzrO3Qp7U3+QtEh8?=
 =?us-ascii?Q?Qc7EIsMAXvsbSNVxr+9r8/PDbaP24RZPYKOusTxnF3u8cipPnzdqRiSIJRY8?=
 =?us-ascii?Q?pEYHxOssNE8G4SLRBpj2vy5Prmc+iwLejOXPV+ayLhk623CrZBxp2I65bR02?=
 =?us-ascii?Q?I9YZ94eg4seGqXUeF7V6TNPG4Ha4ejBHURfNamgzkCS8I5YOniyXkfL0QizH?=
 =?us-ascii?Q?JY2w38ycSPdWN8h1AejpuMSu3xhZ8NOrx7d1NV9WhLlcsc70nOzIKZEvulG5?=
 =?us-ascii?Q?jlhMoh/G246imJvtVnY+iPAmsgfAnPzzs+otjJ801+XF915gUrafuETl44Mu?=
 =?us-ascii?Q?/I4sQVCwxX4Cb4jItQbRaMBM9A856qGjtpq7FG5Sq3WGjbsejvx4C01B4Dhf?=
 =?us-ascii?Q?RzDIrgtB6YhSC9enPgYFoSa0V0vT+Njz7PULHG1hUkzNvqsht01MuoMVlR3D?=
 =?us-ascii?Q?67n1MVgfdRwQjqYFczKRu78mpbRByqTDuyYaU35xLr6Z8M5zYn+5RO5DhmqP?=
 =?us-ascii?Q?tidfyNrrPGbkyDILqh0/DdWWGSzLpdH1MaPZK6244wi5JrsIgFLLoxDtOzRi?=
 =?us-ascii?Q?ycsRHHkXysdLGddC5AxGs6uCrPv0pEy3xoCNnaCxZ6/9JcB3bJgG3yZ32bE1?=
 =?us-ascii?Q?DJfOKlGlx/7WatZ1Fr4mYLd2eUbJ9h9L3UCszW92d+CHMqkueVz2msK3Faog?=
 =?us-ascii?Q?cjCtExwCFItrdj6JT3xW35+Ab7LjjKgla4qEc4BDoj34Rd0OYpOt/8UeDhz0?=
 =?us-ascii?Q?6jle5OTcfP2mh4QFE+U6rigP8t63fJKGrnCm5OEbm07cniTTq2MvEbbVj6JJ?=
 =?us-ascii?Q?Lrt0hYvqB96Teun5/tAdv2IQQYgVBCpd1M6N/YUgxD6fF/6LujSW+eoW4ZEM?=
 =?us-ascii?Q?ADXNIpYvsmyr2wGet0YxuOBfvN74DrqTkhyjP0X3fId4geKdpUc3G0ABPaqs?=
 =?us-ascii?Q?s2Gj0bozOE5HBDf4yDlOfXkRvNNQkqVjsmSAuhDrAFxkG11zviLX9AqxXLZM?=
 =?us-ascii?Q?k+E9k8t6U8NXr2UJL8Is97tB8c4HXNjg1pKPs8y1VYsmhKFAuavjW3yjOY8X?=
 =?us-ascii?Q?DNccbetETnkVxdp84G9XuoPW89ozz2bYpQ9Cf8Ws3JccdYEynEahjjlgPegc?=
 =?us-ascii?Q?5nOCJ5d4W9Fj3fDfySfxLZ76zqXEV3JM+bLYyMHHIH5zb7aAExbpcTyRk4bi?=
 =?us-ascii?Q?tLfHpGnoN1qWaDXK3pg5DlWGKNRIp3NqHpjxyDUkpF8BchSwzI4mH06xBpYV?=
 =?us-ascii?Q?eizjq5lb+yDAnnJdyoeK96Chn6vlXI+F?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:09:11.8969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 760784a3-f192-474a-e4ef-08dd1af99bcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359
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

Use the helper function rather than reading it directly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
index 49e953f86ced4..d1032e9992b49 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
@@ -278,7 +278,7 @@ static void nbio_v7_0_init_registers(struct amdgpu_device *adev)
 {
 	uint32_t data;
 
-	switch (adev->ip_versions[NBIO_HWIP][0]) {
+	switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
 	case IP_VERSION(2, 5, 0):
 		data = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF6_STRAP4) & ~BIT(23);
 		WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF6_STRAP4, data);
-- 
2.47.1

