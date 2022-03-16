Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C07C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 09:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D075D10E3CF;
	Wed, 16 Mar 2022 09:26:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EDEC10E51B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 09:26:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8PLX1MLZt1Cj2n/B/3wEf/4BDL4qJeY0EHzWaOWhGqBtok9sPaL0Q2VvpnOSFzoye/Ry1zNKXl4EJSuaEikD9A0husXuLINreC2a/lSVrEc32izy7iEhOuKPFaxyckLgpWaV1IexN1VE1nECDtZ5sSVPFfLQdVwM1aKpUeEDx39vG07qTXnFVt4Cdr7hHeKrmFSy7K0/ozHD68x+CNgpaPHfQL6HA2ALeLqyS6yw80FSgxjwvUOfbpAII4ozWSGkaDbqDKnxyUFS+OEjB664dRYchW0S7XZCv9lwkiCOSqfTCX5VOPIfACU4LlKLVkvGySSxwyBFz0r84lDv6uHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISzKlp3chH0eLey/7xsz2tfWk1UR3/KNBRmNzDo7I7I=;
 b=MqZTlH86M7hVY/Gkb+0jXwjfkYQiKPsdTAg1Alt2RcezYt2eZvBOzR1eu2t8U1w9hT8kZsmWzFpXHrFLM9O1PYQ2fsLYarlrxFfc1vgWZy4JFdexna4lZ7HwMI6qIpP0is+mBvzf1C3Ek+59EzuAEbgfYbGUdAYxHcveh85mkC6UFckyWNahDJ9dattNf4pZyV8M5ISYXiNklWT4jElLFtbtDBZIjPI6lT1zyik2vs61QdtnFfIbPgdIZrybCg7kPAXWSJ0Az118fgInjIIUC9/fOKaEIgVPLgHm6G/ldiggPSoMZxRhG4ovpd6j5936tMD4Gq3MXsULYodg1zcROw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISzKlp3chH0eLey/7xsz2tfWk1UR3/KNBRmNzDo7I7I=;
 b=PPJY+SZ4nN5RAu1fvB3BgYZm+itZejm96nX8bD+yLrkEyiFZPypVXy69ufp78QIXQVMAmugvvo/NjR8gN+PAdAykJZxORyR/qH9gmRwZn7ON5G+dHnfa60KfUpYfwO9CEQJjlIDW3PzYDx6ACGNP6ifGbOUyNg3SLMHONBcCZaI=
Received: from DM3PR12CA0093.namprd12.prod.outlook.com (2603:10b6:0:55::13) by
 DM6PR12MB3164.namprd12.prod.outlook.com (2603:10b6:5:188::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.24; Wed, 16 Mar 2022 09:26:45 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::78) by DM3PR12CA0093.outlook.office365.com
 (2603:10b6:0:55::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14 via Frontend
 Transport; Wed, 16 Mar 2022 09:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 09:26:45 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 16 Mar
 2022 04:26:42 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Felix.Kuehling@amd.com>, <stanley.yang@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 4/4] drm/amdkfd: add RAS poison consumption handling for UTCL2
 (v2)
Date: Wed, 16 Mar 2022 17:26:27 +0800
Message-ID: <20220316092627.17359-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316092627.17359-1-tao.zhou1@amd.com>
References: <20220316092627.17359-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 309f3d73-9f69-4f38-e1e0-08da072f16ca
X-MS-TrafficTypeDiagnostic: DM6PR12MB3164:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB316408B1CF44C8FE8014B6D0B0119@DM6PR12MB3164.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jwbfalmokQmoWLZa6y7JCdanzKCNb7xS9cIWVt1BbZBqy8uelosrJSHEY7BlxQYzj8eqLNj5wf1clxnjhUzxoEVCrMD4SePeaRzCmPfOY4MyOcJOtJk593zn9XfyOVSDK2COoxBTlJ8h7lClxkGNteaHFqtYsrXg4knpJgrAgoAypnpDfzS0igqWDKwmemJ+koN11A4hQ/lVjZiI63vDcOsWJ1e28anLtzTysBzr/hJVJwYmsHcAx9tVzimWezRN4VIXR5lxnfmbi/kXmwGB6+OUCMyyEWSiWEMi3KaqBFdeJkGhmPfB3hIL20fycYnGbxvZqbQIWTAnQd2lzpoCKE/pPt/tKpnFIgvsmkRXs2OjgRUYj1L5w9XtlkDK/8Rj3B5onVA9cDQyNX0AXth85iRF19sQqj6T+hrUKgJYci97q+3DBvPRo6J205Dv5zaSrNIwYwC3mn5FtvsrPGtHJTrveKD6sHXHwO49FaMjkbdXOXx/IE8FRKgP9F18Q1QR2h/Nw1bREHUU7LC1/7ejzHYooP9NT5MZ8CgC370n8Gn8ICrZvkEb7c+SB3yTR5ZCXINlMZholyTE8ueidWSGbDK00T5CJOzUAlKrESRpS6CKpmsE4KR4GT0MPGr/44m+WWQoYYFJnsi25MU1djC4HZX9Gy1Veq2s/m8Yo2G9DO4MU2546hzhFY6kICmgD3D3QmtAaiVQmmPUGTQjjD4J1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(8676002)(356005)(81166007)(26005)(186003)(40460700003)(86362001)(16526019)(1076003)(6666004)(2616005)(7696005)(336012)(426003)(47076005)(70586007)(70206006)(36756003)(508600001)(82310400004)(36860700001)(6636002)(316002)(110136005)(2906002)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 09:26:45.2505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 309f3d73-9f69-4f38-e1e0-08da072f16ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3164
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do RAS page retirement and use gpu reset as fallback in UTCL2 fault
handler.

v2: replace vm fault event with posion consumed event in UTCL2
poison consumption.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index e5f03f79546f..55ee062a8496 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -312,6 +312,12 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		struct kfd_vm_fault_info info = {0};
 		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
 
+		if (client_id == SOC15_IH_CLIENTID_UTCL2 &&
+		    amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev)) {
+			event_interrupt_poison_consumption(dev, pasid, client_id);
+			return;
+		}
+
 		info.vmid = vmid;
 		info.mc_id = client_id;
 		info.page_addr = ih_ring_entry[4] |
-- 
2.35.1

