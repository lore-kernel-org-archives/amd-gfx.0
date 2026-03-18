Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D949103E189
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 405A310E82C;
	Wed, 18 Mar 2026 14:09:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Y46n5p5";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013052.outbound.protection.outlook.com
 [40.93.196.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C002410E826
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:09:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9aTQqpfddBX46WQyLoH39/CSP06jQfnW1LxMl+5kpja4AUs8CmU25kqwX2c+v3RX/sqGrtroJCy3qQIWK681CaqktwoHbx/aMvqU94v47kzOeAnlDe+rmk94xWUgjQ/t3gH44C5fvgYHy6TSRFfdAWdJRu6OTYGn+rSXkP/MbyrD8cjc+/IaoRan0imU0o/6wRQ96HeUpu9HYb19G2vd4vBDsUHdFNuwTu5GbfEwY3rwHXilxzA9UR1Iq47HnRuQeJDuouEtwLaYOY/3pkNDRsRVNE4VN/T/KoToF0OxcMQzD8F145u5Jv5BrcUh1NdotNllghTwy4wFjzyp4aW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vA+kI5RFlRRxU4/O7sV/xWt1y+IXoI8/CUuuv/2Op+E=;
 b=qUXtBZIlDsxRgA3+GBv9G1hxmwR9SL9HgSlcZHPigIPJW9QDmyVGgKeNU5/rSOYltHsin+p3Q6IzwN+DvupHa2JWf0kWrLHQLd+pwXNjI4geeReapKxX1zf9zRFKOkbpTt2Gq6iqNIOk23135kIDMpT0mq3fJ/cKWhG+jU6mhnADnilDDuAR85F8r5l221vGx90wJutp3PvVZQuNr90ndQTJf2AZ91dH2qIycJqVNNz2B4aJQ9plxKLhr9Eoa7ds9T/oS3b6VKZiezEXIDvkE0GSJuMrFNfFr1bwNtG63WVqb9sNAGfMpGttcP5aq8ATktm5AWuvnnHBTO3919ez2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vA+kI5RFlRRxU4/O7sV/xWt1y+IXoI8/CUuuv/2Op+E=;
 b=4Y46n5p5LhMg26ZqHY4wbEM6X7vlnglSqeOJKhshR2A7XT/8w6Qb4qs6MtxlaSl1WI13+JPuUFYk/F5l+hSI4JpXw2CZHxeofJ72x6Whb3J988qAM0JwXUuGdIr4igPTh1ACBNQGgn9XNS7YGgXQfksfGmILZqJnSpqPHuWlZKo=
Received: from BN0PR04CA0138.namprd04.prod.outlook.com (2603:10b6:408:ed::23)
 by DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 14:09:02 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::28) by BN0PR04CA0138.outlook.office365.com
 (2603:10b6:408:ed::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 14:09:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Mar
 2026 09:08:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Mar
 2026 09:08:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:08:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/16] drm/amdgpu/gfx11: align mqd settings with KFD
Date: Wed, 18 Mar 2026 10:08:27 -0400
Message-ID: <20260318140837.582776-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140837.582776-1-alexander.deucher@amd.com>
References: <20260318140837.582776-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DS0PR12MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a67bb2b-c79d-4c4b-d904-08de84f7e7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 22M84FghAwdoc3YlMGcWm04CU3/oSw4G43bTKLIq1ZUtw3fO5vq/46KmR/gNupL6mbu0gw7E8UHL8yr4G3Tg6hk/1bEuh9WvpcW8r9fZPh5Tklks3nLzBbJw3CTZOw/aB88CjS40AlzhdSNfiPK+hpXUs3NXix83RpZefYP376Lvf31vIBHR0EGpyUl0mgEVXNt5wS6lrt4JwcuEpqACCBIpHHpyYRGccIYSMsbhzvVl2MHNYeIEKRjSrKgyOXtsNvAL6Ms89SHPQ668JY2ln46beYZoaDAjfXTaKWtDqS8KFLGSCDhkiopOR4eIl9DI2BQNXVWWKCVUHt2t8jlBlXD/uzFWHzUb5f0Fl4ODGz6r3b/0LFF2OC8/TdAPHW1XClo6VZhCUl7Bl86zVxVTcJbzZVmg+2lOiEUWMaDERB1RjjOaXyl7+7iRXyZ7p5QP7s6Y69EAsO6iHtjjO+cGeBs39ghnOIAA5lGq/Ro0KPM0JhJ+zMw21etT19a4zT+eoddI4D/S0wGgQjVASdrOeBPLz6uTu5bLprQ6AFIMFO3qolsbhrIPZaV5dxw8NunlC6tRlDriyxyBus0SKXdZEKEkCqCTV27n7r+nSD6kJ6KZ4CVhJqmkLimtknZkWo2sGUmQdg7Po8CkKCZRvO80uLTwfdcOG7ZUifoZa6CqA8gROdmKy0zCb748W683wD8yr14JGnpQ5COt6nu0S7+7QH3lT8u+u4Fi9wpF/xKXgyulDBLG2fmBv7cV5SsPnGVdZB62AvV1Mcknhn41zo57og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r/E0UtZYlFhwXj4RyWXsrqan8Qw8EDCDWpKgzNuEopXcnw7Ru+ZuZpUGFIDzoCWbvmevbporISGc4maLmn/FiAaB0A+be9xWZ04C2q+cCpCbSm55mnfsTADzRQzi/RRxGbpx4ZnP9KRrzL9GkiFxLEXQaZWUP6p9bI7wDnM2ItH9vcY85JwCvcnB+NMWDxdRY8sLILizPCs035pRsCIRd/pH6OzdjN054WpgLG1iiQJzGzEaQ/5GlREQgltsDFNrmzUDzssN7PFTDy26PaxNnKzksxnElYWIpWf6xeVq+9TEKT1xHWfBbej+Hv4gYQOZ5i/S3k0OYQX7sHoVsd5irwch0a/WgcDpdcH9WJeWMSuAnNpVijkR5ZsbSdsZSyQULdOJ2miCE/qWso8dJZ45O9oST3pAjgpdvu91YJ/p8XRjRiKrpNx77f7WGjuMD7O4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:09:01.2635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a67bb2b-c79d-4c4b-d904-08de84f7e7bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778
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

Make sure to set the quantum bits in the compute MQD
for better fairness across queues of the same priority.

Reviewed-by：Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 78d1f3eb522ed..121290f8b4930 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4398,6 +4398,11 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_pipe_priority = prop->hqd_pipe_priority;
 	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
 
+	tmp = REG_SET_FIELD(0, CP_HQD_QUANTUM, QUANTUM_EN, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	mqd->cp_hqd_quantum = tmp;
+
 	mqd->cp_hqd_active = prop->hqd_active;
 
 	/* set UQ fenceaddress */
-- 
2.53.0

