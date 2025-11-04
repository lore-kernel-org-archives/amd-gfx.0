Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D17CCFA00
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 06:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2596610E52C;
	Tue,  4 Nov 2025 06:58:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="46vg/IjO";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 577B510E526
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 06:58:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKfCiY2Q+0+iuWEk8MlfTVGjhDk9clU/IKP+OVKTCMThN/bcm4qugQchIG0mVZRm2mNmQcmFR8ZDoqjTtXuxEEa4/V6gUq4B7EHiuTHf41nwb+NvpSHd2aZ9qy2p1huVjk9gbQbha+QO6saWj/IyAzTNrjGoQi2GkV/HJd6mx8xdADviaOgUlpT0gz4EK3qqimLjb1FykmOxhUi+Qbz6quNcVPRlP2PiXfsMslO0vy19iDIaFjkr8iU7vN992gaiCZsmWume1hXUqf6wNTNKKq2aax2JbVC8BxKRV2/Ae5kn4HEw0D/iVXWRIW4gTlOpZUJY7tZDeLPUQBiY0CPERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdPmjIPHHlPt4bnSJV8Ps/e5tYqaWzWbez+NgRe/MfI=;
 b=GjcbtBlUVZNZD3opwZ0eG2SJdeGYpiWYBIGoPwkRYkXYvCARhTfBi0jP1PyWthQjNx+Eo8Wb+3OnRF53J/GDacRvHO+v9q0RiWCAqBqyDjBLd8NhUFutZtaqiE+cLrZ09oAqoeLEEg3red/f7YDCEqaodpSGqfTXP5ZjS/HhQSOjI59cs9LU/VEuH7PPp6xzZHJK7MQWTz7BIVZLieZHDyNvRDaphm4XLcFgZWGIXTGszyjRGCW/5wEfEyNDA5WnP8UC/QdEE1kquAc6xd6iC+I0+MY2kH0Wd3J9P+urBvxc3t5m1AS1tNyAIeF9bo3Xf2K5novkbcV8pug9OOY/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdPmjIPHHlPt4bnSJV8Ps/e5tYqaWzWbez+NgRe/MfI=;
 b=46vg/IjOYStGefymWqfV8PnXWx4cNkKOq7dGpyxVbr1OwuF10cgHzoOUXvXZf0Durwe1kDZjTcMswFhVnvY49h+IKMGnVFcOko0mJkv/klnpdRANU2JCxl+LRC1TOkaQR2NMnMJJtToj+gyIrVcDdwClV3KcN4Ib6JZ1jG2FQBI=
Received: from BLAP220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::34)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 06:58:30 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::28) by BLAP220CA0029.outlook.office365.com
 (2603:10b6:208:32c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 06:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 06:58:30 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 3 Nov 2025 22:58:29 -0800
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 10/10] drm/amdgpu: initialize max record count after table
 reset
Date: Tue, 4 Nov 2025 14:57:45 +0800
Message-ID: <20251104065745.1737050-10-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104065745.1737050-1-ganglxie@amd.com>
References: <20251104065745.1737050-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 6296b88c-5f85-462b-7bf0-08de1b6f9024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8mUHPQhki5QA+pjEPdNVy2UV0ShdgPb2BNQ5W/s6EB5+31Hor1eqmBoytbUl?=
 =?us-ascii?Q?LI3fFwWUsVcSnh2qFp7h4cnqOOqRVJuNqAitwyH6sVAy9pt1ZoKC3V9tJOZU?=
 =?us-ascii?Q?qbZpvRkV3hdY7iWtC3afhrRa+WqE6oZY8h05PcK31d7EDlh+5vF6qsrBcvGN?=
 =?us-ascii?Q?AE+vqTSXCw37ZWdFsWtdJx70cPZqNdX++vdINn6C8RTkHxRXNUva70WCtJ56?=
 =?us-ascii?Q?Q60nZY2yvPE3FTzYLEQwawOp/yM4PrwhzxZY98YElCIQkZM7XU2WJcxjR5H3?=
 =?us-ascii?Q?WVhqa5X4yEoPKNqzwttO6EtvanG/fV4j0ZAi/bs18swrm24kHCd38eu9xYhM?=
 =?us-ascii?Q?8u8+cCQl196HcoSExKhjzx4KZlX8AmOZVnrcyfGpguF5DOmLQ2qPnYuMHa7X?=
 =?us-ascii?Q?ue3hGYrkUi4MslnswtqLtMhqZdNA0x+i9zGFh2nshInigSnJ05bt8BZ7SqRi?=
 =?us-ascii?Q?+jcA8pyUkuCTZdJ+SaaMuS5rns8Gk7fVpNhZVsUde4UP5kn/xWKs90I8qqXI?=
 =?us-ascii?Q?HG6HLQQm2AAaX4AsBq8RUPVnCoq7uzPc1KXGtYqgBBxTprrMFrWzCgqacCt1?=
 =?us-ascii?Q?GSL6R2IfZEQiaybODnfmQa0lWEundEf/cs6Z2h9+povqLiztXvDLX+72UBsU?=
 =?us-ascii?Q?CKIOULwSpGX6c+7YqwEUfDfPJaYuAzl4pp3Kis5bpDv2+0PjgZJCC9MCg2Gx?=
 =?us-ascii?Q?nJAJD6c5YqO3gSQQSg/9T7TKTbTmtLOIrvozCzGcqxDDuDN/jnA59f1cE9MH?=
 =?us-ascii?Q?UU3/bHTymlgVhl9rcXLf8/VPiD41QAZhItr/j+ydJ3d1FnjIkO0woTa3Tk7W?=
 =?us-ascii?Q?fBgcAaKwq8/AsQY70nqC7H8vf2uAeg7gburvr+k+6CDh12dtPnnC5IAY7CVw?=
 =?us-ascii?Q?1Btj9xM3wPPamS4z39x1Xby6y51AMdnw4Yk7IkHxL7NIP4MXm+GXMk2CLb+f?=
 =?us-ascii?Q?RVIYksAj6XGRyRcDP16uOP1JnsSsQ/GhMt5y9eNWtDYQ39BBoMz2WzuMc+Hb?=
 =?us-ascii?Q?E5afZFLQg89ydqTg+NC4Al1EQhCo2kTqDOaIeerEeVR8RrpiYeAr+ckDYuas?=
 =?us-ascii?Q?N8KSBDwfZkuQt9PaWQQnCdRr+F7YRU2AIlJpQz3SVM35dW9Rb3f/UdsMl9et?=
 =?us-ascii?Q?GR4BU+P0XnPjQnEXxkjgZgG+8nVdoD3LoJBseoTnA0LbBxbrURmcoLwhyEbw?=
 =?us-ascii?Q?/HzObaX6hZVZQfz0ezsMQ6ue05JufrDBGg9zmtYrOEMTi4yYsm+e5uZjk/IT?=
 =?us-ascii?Q?ZO9qjKeqe9JtFTKvGFsQux+h054PEyb46w+MXBVNPYEI1lat0gjS+2kdZcyf?=
 =?us-ascii?Q?gzN4iB4htauOpq1R9qHpebCv1EGKEQMKGrOLtg37XMiffICz09JBfakdPxbY?=
 =?us-ascii?Q?iFpmKxNT993u749F/ogQAggma/ehkVYnX4R9t5YgJX7M2GcD9WCaoCx0Gw8T?=
 =?us-ascii?Q?7W2tWr6phwakkdYdXpyLquWTaY0Yt3VF4RDQs96GwelfJS6CURzPriKx05bZ?=
 =?us-ascii?Q?LfNjoipS8aILgNS638qD+I+gdRxNC3HvcPeDxT196D6rHEZICJHopoyqaA1L?=
 =?us-ascii?Q?uNzuHgqshMO0p6AQWz0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:58:30.6390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6296b88c-5f85-462b-7bf0-08de1b6f9024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
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

initialize max record count and record offset after table reset

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 3c646d9dad77..d7e2a81bc274 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -459,6 +459,9 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 			hdr->tbl_size = RAS_TABLE_HEADER_SIZE +
 					RAS_TABLE_V2_1_INFO_SIZE;
 			rai->rma_status = GPU_HEALTH_USABLE;
+
+			control->ras_record_offset = RAS_RECORD_START_V2_1;
+			control->ras_max_record_count = RAS_MAX_RECORD_COUNT_V2_1;
 			/**
 			 * GPU health represented as a percentage.
 			 * 0 means worst health, 100 means fully health.
@@ -469,6 +472,9 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 		} else {
 			hdr->first_rec_offset = RAS_RECORD_START;
 			hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
+
+			control->ras_record_offset = RAS_RECORD_START;
+			control->ras_max_record_count = RAS_MAX_RECORD_COUNT;
 		}
 
 		csum = __calc_hdr_byte_sum(control);
-- 
2.34.1

