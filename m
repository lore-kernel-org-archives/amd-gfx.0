Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF3BC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 22:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F111B206C3
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 22:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C3OY/yHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F111B206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D05B89E35;
	Mon, 29 Jun 2020 22:01:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 903B489E35
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 22:01:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co+fEttsMPgj3wf5osV6FDaPhyeYvNRBbF9pa0Nx8+MB1gJXi2SKWBxW0ULtG+ifkSjFzSn+i6ulqH+pqtUCLx4QMMeBep+VxcUICyQIyCDMADOxmFlBlst5sXdCFWcbV2qVGNe3jTlsYEnp54BeL7tKiGD7zVS+aPAaVB1vp76w3/2XzGBFUMX3VC6e/PfSskFplMOv4tuwgWxqUAuk70goUOZTsTy0w/Uhe0+rR4XETP4S3tKcq9UlrUeboHO30AvXCDn6g7DMVuV7VUdx806BpbT/nk+LIqPc49fSH3FqnBBpzIsdp3stwmA6YqvYbGuCW7Z5X3jjvoWQokOhQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7ifJitJtKbDrdsJUmnSfjenF6aa3p8Z1RwGcUE7rsM=;
 b=odY904WC+SyqevmEYkgi2HsODChDUVMtucbQLcrebg9E/J2ZCMivIIBaduxq3eXUqerac5MGuaL7hvYRaWVM0RaKpaG5vHcvojwi7lDM9DtnKXn0rFcNYWk6uPSIZCGlXwSiJZc9vvaiOFWE4GAJAmVlOoye95NMUeVz/em1d9DorSF0RMeC3GjnDdOPDr8K1ReS9qg81S/xJOB0p+t1tZ/idvO/mSEL05l1XWomeMQ7UvuiHEkHdfUqBGZMt0Is4Xzsf1r0q3zdD3m9yjz5yfXI1eTdZKkrds4YmZowWyxReYZc8SpffYLRswVj6A1csd8ef+NqS59CDdQ1REALzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7ifJitJtKbDrdsJUmnSfjenF6aa3p8Z1RwGcUE7rsM=;
 b=C3OY/yHi6vW1jsU8ptlTC4BeUsLPZzLKBip5r2U21sSvLpXYyydya13PYiX6Zk6gZoDtzgyMmSP+C8WEjMCiJUo+StUHiwx8dPcQ7hJVe6U4i+FYiDXNALEfS7TK0jr1N1VlDavy2pEnYKOmqfNyeKFbn0C4GjfVykA2zLfXyOI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 by SA0PR12MB4528.namprd12.prod.outlook.com (2603:10b6:806:9e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Mon, 29 Jun
 2020 22:01:02 +0000
Received: from SN1PR12MB2382.namprd12.prod.outlook.com
 ([fe80::8cbd:c948:840b:3a69]) by SN1PR12MB2382.namprd12.prod.outlook.com
 ([fe80::8cbd:c948:840b:3a69%3]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 22:01:02 +0000
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Update hardware scheduling time quanta
Date: Mon, 29 Jun 2020 17:00:44 -0500
Message-Id: <20200629220044.179230-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: DM5PR19CA0004.namprd19.prod.outlook.com
 (2603:10b6:3:151::14) To SN1PR12MB2382.namprd12.prod.outlook.com
 (2603:10b6:802:2e::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rocm-perf01.amd.com (165.204.78.2) by
 DM5PR19CA0004.namprd19.prod.outlook.com (2603:10b6:3:151::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Mon, 29 Jun 2020 22:01:01 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 387646c2-736b-4b1a-b517-08d81c77e9b8
X-MS-TrafficTypeDiagnostic: SA0PR12MB4528:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB452803069543B311931A90EEF96E0@SA0PR12MB4528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8ltARk9Gk3W9GPPvVIcIhh+g4Nl9yL1NNtoZa2HyUGQ8KXVgDXk0PrUkvkzaWKdIg4Vo6lQB4xd3EY3RI5NGgRugPSEbPXxYshWA7tG6HmyaVbUMzQHomdP9eO2E+fC6bwAJq2UGQ3GpZnGPCBmKwLkBtIQwSiWOD2CcX7lb9sacgg39aiE4+2YgaEZlPGSSzgjsKWhaRTP5jtFRiXfxRlFnLsIALgBTHKvuhx3vuk6rjHYuL/vBM2ZwbGOoIc8nPNus5n3Fmdb06bHu240Eu2UoYKhhWzhtNmJXQ3/HozPah6Tg4gVx2rkZZJ+IpZn1c9EDUWVGp3MjWN6CEEScQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2382.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(186003)(16526019)(26005)(956004)(2616005)(15650500001)(7696005)(52116002)(2906002)(8676002)(6916009)(6666004)(8936002)(478600001)(5660300002)(66556008)(66476007)(36756003)(66946007)(83380400001)(4326008)(6486002)(86362001)(1076003)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EGJULgahygzKUOve0CZ6/W3CNsznuWkO8GLQhDDyVqmN5Nr06NLbuhZazEYyQ1DZqCxbo4XNRUQp6H0F85WojssmsztsVfBZXl8Ppn/x9PvCHEs5lJGlJrz0J6N1IkyB7l3d4/AHGirv1/zEcIJhIymj7E8GWdrQHcuAfeb+uYGIW/k4nKHCjV70OAkoBg9itjMDoWqkqusFp58ayTuPQShb3Pg8tf7FgcXgtKSLHJBSesohqq1gqJOU4fd2sRrIz4aF16otqe6YMQtaLnwIQxXHvn0+nXhpQwlQUDQjNFPCshpDolFF9D4uCu82UaSyHGpW+BdO7plBS0hKcZiJ3BHAupAXxHsbAPZrC7fh+9yF09I5HxPxypQHFdhdyPQjfk6jfQUp94dxl4ycYaP5MJa3oDaY3Waik/qUhXejKASXWGnnyoWlqW72NmLAAd54VJIRE02stUn825ziiQZeC3TnxMkVE1h8N2Wvqfuq1Tw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387646c2-736b-4b1a-b517-08d81c77e9b8
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2382.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 22:01:02.4655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dJYzOnMrpYhcVZVdOGNyXifDbhMwvbDP/biPtBnRUidNDGrrCEUK6zMEG39hJ9hVGoabcuIxvA9zAzJrwilyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4528
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
Cc: Joseph Greathouse <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update PROCESS_QUANTUM, the time the hardware scheduler allows
processes to run before switching to other processes when it becomes
over-subscribed. Increase this to 10ms, to allow processes to better
amortize their task switch times.

Update HQD Quantum, the amount of time that an active queue stays
attached to the CP before we forcibly switch it for another active
queue for fairness.

Setting these so that HQD < PROCESS makes it easier to ensure that
we get fairness when we have multiple active queues on the device.
Otherwise we may start process-swapping before we get to all the
queues in a CP.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
Change-Id: I5f46d268a82eb08e75bfaf0aed5333c3341b64bd
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index d1d68a51bfb8..18e08d82d978 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -113,7 +113,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 
 	m->cp_hqd_quantum = 1 << CP_HQD_QUANTUM__QUANTUM_EN__SHIFT |
 			1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
-			10 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
+			1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
 
 	if (q->format == KFD_QUEUE_FORMAT_AQL) {
 		m->cp_hqd_aql_control =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 48cda3073b70..3b6f5963180d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -160,7 +160,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 
 	m->cp_hqd_quantum = 1 << CP_HQD_QUANTUM__QUANTUM_EN__SHIFT |
 			1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
-			10 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
+			1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
 
 	if (q->format == KFD_QUEUE_FORMAT_AQL) {
 		m->cp_hqd_aql_control =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index a5e8ff1e5945..31799e5f3b3c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -117,7 +117,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 
 	m->cp_hqd_quantum = 1 << CP_HQD_QUANTUM__QUANTUM_EN__SHIFT |
 			1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
-			10 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
+			1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
 
 	set_priority(m, q);
 	m->cp_hqd_eop_rptr = 1 << CP_HQD_EOP_RPTR__INIT_FETCHER__SHIFT;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index bdca9dc5f118..dfaf771a42e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -39,7 +39,7 @@ static int pm_map_process_v9(struct packet_manager *pm,
 	packet->header.u32All = pm_build_pm4_header(IT_MAP_PROCESS,
 					sizeof(struct pm4_mes_map_process));
 	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
-	packet->bitfields2.process_quantum = 1;
+	packet->bitfields2.process_quantum = 10;
 	packet->bitfields2.pasid = qpd->pqm->process->pasid;
 	packet->bitfields14.gds_size = qpd->gds_size & 0x3F;
 	packet->bitfields14.gds_size_hi = (qpd->gds_size >> 6) & 0xF;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
index bed4d0ccb6b1..a852e0d7d804 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
@@ -50,7 +50,7 @@ static int pm_map_process_vi(struct packet_manager *pm, uint32_t *buffer,
 	packet->header.u32All = pm_build_pm4_header(IT_MAP_PROCESS,
 					sizeof(struct pm4_mes_map_process));
 	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
-	packet->bitfields2.process_quantum = 1;
+	packet->bitfields2.process_quantum = 10;
 	packet->bitfields2.pasid = qpd->pqm->process->pasid;
 	packet->bitfields3.page_table_base = qpd->page_table_base;
 	packet->bitfields10.gds_size = qpd->gds_size;
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
