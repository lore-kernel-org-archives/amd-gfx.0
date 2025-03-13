Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDDEC282DE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 14:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A510010E8E0;
	Thu, 13 Mar 2025 14:42:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wbjqfaw4";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C644A10E8C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 14:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eg+m4K0sQ043bTnRKvMp7QZNY6FWZpLxtxf4Q0UW9LvC2Wkn1lsMdAtaHaY3uZWribVhY5a9s3GrHgRQvBTfQb2YiUlj9uoXXPZ0OHX/ZKQy7apAD+r1hrDBIrtDJho3tEXlPhBs3TQmPYDDi9DzKLU1aFBl32W+U2AEETGXXLfNk+lk8Oumb0OBvHmjVj1O+EH2tdY/ZI4MMG4nBiSnvZ+armUVG0cOvbmhSL6vNJwfPEbnAuWeSxPXSibAGYNAJ8kofdiF3LdTHx3ZhvNv/kF1Ez4bb09XIwWojltez0XeVeIjYrmfndYM9p7NGFnsrrN/O8iIh7xUKvyWeRtZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+4znT6orinGyNDxnLfRxsY41IB6XUfdLP1dYb7kozU=;
 b=P5snnyKOYmlN7MxAmmhRCvd7yxo5LrThrtFAgxeKM/Yaa/qxNjwUrEM+IRgtTFfqST5yDziqA4KwMMLyK60Nz9ZZP1CasdJBow2hSRKRwsb+4XL0sLyt+UK6H8xdviyBgA0Jh7vVCKnr7VeCcy+o5mGH+eUHc+JLY6M04Aksf27pjlNynJ2NFDmZPp806+8vequMq2bdquicqVUntLs6rVkVK2F8gEeips4fAY6llMqxAO8EZXWDjcGSgYY4hWwBkam4FjVrxKHt/JxfuWvCH2Jz2zNsQoF07yU/IejKJAOonIYF76u8aDGDUkK2PW9E2zyxK/SfaNE3sLxK0nLOdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+4znT6orinGyNDxnLfRxsY41IB6XUfdLP1dYb7kozU=;
 b=Wbjqfaw42wpEczh1+GkWAZ31JV4CpFwP0iiuDcijGcjz8Ut7dZtiBWgtfFreF0PQ/ENlkldN8sElzJDCf87MqDFmaKdIASTQ49LO8zPrxTqwDxG5yDUnOMmLQOtmjW20BXYtG66m3QyojySb00eJ9psol09FwzQ+7mhyBu/2Big=
Received: from BL1PR13CA0353.namprd13.prod.outlook.com (2603:10b6:208:2c6::28)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 14:42:00 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::1a) by BL1PR13CA0353.outlook.office365.com
 (2603:10b6:208:2c6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.23 via Frontend Transport; Thu,
 13 Mar 2025 14:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Thu, 13 Mar 2025 14:42:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 09:41:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 11/11] drm/amdgpu/sdma7: add support for disable_kq
Date: Thu, 13 Mar 2025 10:41:36 -0400
Message-ID: <20250313144136.1117072-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313144136.1117072-1-alexander.deucher@amd.com>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe76786-f590-4e88-ec92-08dd623d3657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FIPS5ynszEy/EkeSPaWF4y6shEoQbGXGnN9vxtJ1QTznLcTyeYHVbAAf12CS?=
 =?us-ascii?Q?k1SHisoA1SYeqUfZpSs9EmiwrcK84O8mfpRE6QFBJPk9BVUydbTr5AoKIHPs?=
 =?us-ascii?Q?AgKJAkU3RlaD1E/xTVyuF9HP4XsSNSXiaPXo+hb6dA/cUqL+tkTKqPok9VhF?=
 =?us-ascii?Q?M7Mybrn/YtDLoUyDcNI+uBLioUhDYE1GbgZJsLtz1SNCKPAKTGd5zS+tAOSb?=
 =?us-ascii?Q?+Kgpki1N75WPZFGM8Z5VTnVtoLKMDIhC8JNKUqfMTkFHXgwPAzzRK4iQ3fh9?=
 =?us-ascii?Q?vIT4nf8nUxvBS8x/e6S0FCBa5vd1r0JTSN9eVLsQNI+OQFHTRtcxbLb7p4eM?=
 =?us-ascii?Q?pIzP4Hej4E0ifUfIptel2Lj0J5mf1wU7vLEKjcP519qHm/FCJnD2rzxL5/6D?=
 =?us-ascii?Q?Z0lFB+dJLSi0SlRpZRjHP/Fberj1aTEeeCuNAdMAR7F7HjviKlHGheOVibLe?=
 =?us-ascii?Q?gLGVs3jnYCA6/DSM3JXESUyIQfJIqC2nHT+xL6wbx12G11H8AWGhW+aGK8eY?=
 =?us-ascii?Q?KfrEvmpJgsHiKepz26MpUrH+Dv6AAX5HAelC81FfAqvJEv0SDxchXSKfzxLE?=
 =?us-ascii?Q?00W7TFK9a9cHeIT8TVJfazPQigKEMUV6seisCY8MOhFEBIYdaR9kotcIBff/?=
 =?us-ascii?Q?YtDBVWhpPD2kWNJJBpnscB0u5kWL+RE+bx1yc4OVvMDrOWbtWT9aB72jwpLJ?=
 =?us-ascii?Q?L44uunVmObD1tAI1m9P0BeimiM26lufTpPGvWQbq3ghhDUyx4AyxH09fkuhd?=
 =?us-ascii?Q?fvzkQoPqvvWcylgd4rFG0mRhyk5BJfGX2fJl4L5Wxb5B/5cGMCFzaGjSNFe0?=
 =?us-ascii?Q?bX2noOMhwa1FXhm36RGDEfetOdYjBAWeJ+iBEQO7OCAqR9TbJ7yiweRJOBC4?=
 =?us-ascii?Q?I9i0YFzolwbcI8Vqn0V/q9G/cpDyjGcTRup2d6LnVNFoxgZijbbDsy8HEDHc?=
 =?us-ascii?Q?0fkYZlARqv2FKF00iXJbQcaFNFFuHEotLLhdETpUYp54RfJvg+IlUIBbaKkQ?=
 =?us-ascii?Q?5HMbzyDQ8PBGVsLULda4lLeKTAYn0hh8Xs3IQuCCNvQ33niS9ajDk0GE19P7?=
 =?us-ascii?Q?2HQigzkAI0Xv8VoILKlST6vQZ46S5WHMv1ULZxTM09KBw/VOVZ3Il8jg8Eik?=
 =?us-ascii?Q?P7HuBjdhTBzX3ay5NOVYD4KdUNQaRNc8HRS/qnpXV9ErA59albQbQFPQohWd?=
 =?us-ascii?Q?r5xcFvoNw9+foAEqrGrmcAvB1dfzRJLyTiJ9GRyCOdZ8xrdS79HalkWw8R98?=
 =?us-ascii?Q?UK/NyllWk+rNTxMiYNsTZlVeg2vCXLJq5C+oerj+dKrCJ636BkoZuX06zDh/?=
 =?us-ascii?Q?RvpoGy6W5QuhlwG3/obgv2IH9oMJgMmrPo1CmvEbThvnPkBxh4QEpVIIZ3kF?=
 =?us-ascii?Q?e2jR0Ay+aO03SCSt3i2OZgBpLboPcCTzWHRqxpAAl6TWqgkt5lGV8RrJMRXl?=
 =?us-ascii?Q?VXp+zpLE78q3w6Q6PGj7EWL80ZUw8JJLLGPdK73KYxmcuvk4OM65kQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:42:00.0424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe76786-f590-4e88-ec92-08dd623d3657
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
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

When the parameter is set, disable user submissions
to kernel queues.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 92a79296708ae..40d45f738c0a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1316,6 +1316,9 @@ static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	if (amdgpu_disable_kq == 1)
+		adev->sdma.no_user_submission = true;
+
 	r = amdgpu_sdma_init_microcode(adev, 0, true);
 	if (r) {
 		DRM_ERROR("Failed to init sdma firmware!\n");
@@ -1351,6 +1354,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
+		ring->no_user_submission = adev->sdma.no_user_submission;
 
 		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
 				ring->use_doorbell?"true":"false");
-- 
2.48.1

