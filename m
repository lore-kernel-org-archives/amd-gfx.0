Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5446D12D52
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 02:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6339510E412;
	Mon, 11 Nov 2024 02:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GHdNppEZ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EFE10E412
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 02:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZJ1jzk/871ZonZ6moQhbqgVhxcSSstdY/M99ZAP28sPVPByj38mZXHcGLScukiRkY44MsifGtQFHwQN6zo6XxlePORylYhYpPaIkN3/+70pUku/VCA9FLd1k++mLHsPiH0rD7QRb4oPlrirxfviuhLAgAWOJbh/R/kQu1D24Jx4d8BmM9smFusdpu18h32MX+57vP5HpuKXz8XeH/j808nbqkJK6KCooMAYnQKphShA+8Cbw+QU61uBOk0Zol1Qxa4fMNdIhByN7hErv/nJ/OiEGfKU8mCXbuQpwgP1rS91V6P4YfAylOJEdS2UhuEnXoFcyP87pc19IwcG1YtfwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRA0wMPx20lhZlKPJatTU7WOJSwW0j42BKlZUNYbmPA=;
 b=TYNiLUQZKTOq35AcAKE01rEkDDakhylyhqCuLeT+1uSat9oWg7KmEQp52Zks/sv2S6EU7DlwNr/mAHOEnZVPymjRL6SY0xWhY1pKwQyIh5k47TfkKvTw0JshIEscpCJYhOtRdoj++R4NrXowZcebTeHiOJ8CjvfB5xWFoCdbX2AqpPJwMW+v0jKb4qbGRzcdtlk76LwEBAsLlUhxDlY9bOOEt4wGEh/6CmMPP504iBxSPnnD7g6CkZ9jWVBreZpgvu+Np/6L4kMlCyLglgku0+2lZaAETQ6/CgDzyNvWLlu3dTdJcuJpzeZCNuxRcu8QzoETtg7dwCTSbc1fKTesNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRA0wMPx20lhZlKPJatTU7WOJSwW0j42BKlZUNYbmPA=;
 b=GHdNppEZoqycbTjiYRYnLcswr750kAEhuFXMOBdVQZXJPMhhqdX1Nan8WRJ0VyfQfn8qCbAt9r3WU4ns2bKzfZWTUxkSyiSf5mNkIIAzx8Jrt4X1kgMufeWRE1p/I5+5N8cSHaSTJ1bfjDFI166EScZJbkjnOVdXQzX/9GkEm3k=
Received: from SN4PR0501CA0127.namprd05.prod.outlook.com
 (2603:10b6:803:42::44) by CY5PR12MB6408.namprd12.prod.outlook.com
 (2603:10b6:930:3b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 02:46:27 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:803:42:cafe::4) by SN4PR0501CA0127.outlook.office365.com
 (2603:10b6:803:42::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.12 via Frontend
 Transport; Mon, 11 Nov 2024 02:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 02:46:27 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 10 Nov 2024 20:46:25 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: Add missing 'inst' parameter to VCN v4.0.5
 function interfaces
Date: Mon, 11 Nov 2024 08:16:10 +0530
Message-ID: <20241111024612.1881727-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111024612.1881727-1-srinivasan.shanmugam@amd.com>
References: <20241111024612.1881727-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf524c1-d282-4449-d9f8-08dd01fb0a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UElJZGZVUkdqWHdNaWdVbERQcVlNK0tyMWJjakV2azViL1hhczEyd0J1NmxS?=
 =?utf-8?B?cmZhUEFZUEdQR29IWm14NUMyS1FKZCs4ajBjK3hUT3V1S0dWMEVvQWpQcWRM?=
 =?utf-8?B?UWI5LzBzYm5LYzd3K2RjWElwYXQzVUc3RUxHMGU3Rkc0TVVzcGNVQk5tYS9E?=
 =?utf-8?B?OTlBQksyaVU4VUplUTBPNEhhRk04WmhNN2tqTWN3ZWYveFRNREtlNGJWdVhB?=
 =?utf-8?B?YTU5THZoTGZTcHZyVStPZHZVeUtaN1NoVlhGb2Z0R1VFQUhxTFpOS2hsaE0w?=
 =?utf-8?B?dFA0aVVOUGhCZ2ZDNzVjRFhFWkNDNGJUY1dkelhKVVVuUG1rMWNwbHd0ZzZt?=
 =?utf-8?B?a2h0TEE2SC9IclhWQ1JhZURDS1gycCtVM1R0aHZ6bW5YSm5vLytoMUg0V0tW?=
 =?utf-8?B?c1d5R2RVNGNXYVczbFUyeGt5MG9FVGIxb0N0eThMQlhKS0FEN1N2YTdENHJ4?=
 =?utf-8?B?MUdVSlZVNUV2Y0VGYURsYWd5L1hHSDFyYUN2MDhiOHVFRGVDbUhObWp1OHl1?=
 =?utf-8?B?ZWdRRkd2S0FReWh2bkhRQVFQVFJUUnY4dnhMRi9lZStWNUhrbVE2d3JuV0Zq?=
 =?utf-8?B?R2FzU3VPSGYybWpIamZkNllyc2ZYM0o4cWJFY05VL00wM1hUSWRwa2Q5eThS?=
 =?utf-8?B?VEMybGV4a21qTFdLRk9jWmdkSjY0alNjOTE3OGwycE1DbU1CNEZad0Fjd3Vs?=
 =?utf-8?B?enpFZTNYa1Q5VWhiOTBVQkdmTy92QXNOOCs2c0t4SmhFOGJQUi9qNnh2dlQz?=
 =?utf-8?B?bjRRTnBqNWFuS3dUNnZkZkJBakJKK0pvcDlLd2ppVnYzd3VuMkF2UVRQOGhE?=
 =?utf-8?B?N3hCYmhRWFQxYTQrQ2h5bTFQMHhOSjBiRDFzV0N3WUxVYStERFo0ZU9TUWU3?=
 =?utf-8?B?djlMb3N4K01NWHBjMzd2MlFSaVN5RlNSR2ZDU0hTZ2NsQjNzM0NEU0RRakZC?=
 =?utf-8?B?ZWZpdkc0L01yVUx4SDg4c1R3aXpDZWxIa1dFMTdPd0IxckU1Nm1nNkZEWUQ0?=
 =?utf-8?B?dDF4VVJuWitJaHN6TDFOSnV3U0lBVEZJT3RkRkM2Qjc0ZUxxL1B3RjU2bUla?=
 =?utf-8?B?L2tDOThKUE9rQllhREJGR2ZkNG53Z2orajJrSDZQdnlyZ2RjY3pxREpld25S?=
 =?utf-8?B?TTdNT1VNclVEZDJXQWNSQlFKSDBwQnVQU2pOdkZxYld2UmtyODhLcklqQ1ly?=
 =?utf-8?B?OS9SdjBvOEl4SG9zdXRvQ0xKd1lBMzRJOUI0bFFZRWpLQkZBZDg3WmczQ3Nr?=
 =?utf-8?B?U3ZReEdsTE1MeGFqY2tUMjh6blNCMnBCbFNiWCtIR2lvVUp6K1JhTzFjTWE5?=
 =?utf-8?B?cHlGaFZGNG9mZm85N0NtajFZNzI1S0ZZNjJ1L0M3a3lFSjhSZFZWbUkwdHZU?=
 =?utf-8?B?cXlyaldudVJTRjAzZm53V3pjZUhYL2VjSWJIbVI4UUNtSGpKamhpSWNvTUJG?=
 =?utf-8?B?RW5kb0VxSUo4V2NDV2U4MVRTc3cxR2pNZmZpYVVtL1hOdXk5OE1OM0VHQUhD?=
 =?utf-8?B?Nm9MRDZyTnBicTZieXNRaFJCbE1oVVVNK3pSL012Qmo4SmVyZWt1VFRsalhq?=
 =?utf-8?B?SnpXaHJlWFpidkpvNmNFRmlKU1NBN0p4dVhsbmhFa214SmhlVDJ2NXJ5L09n?=
 =?utf-8?B?NlBUSnNqR1RJb0VVUUNFeUNXUS9DcUdVMDZOSnJrNWNTeFVvdnBrUTM2ZGtm?=
 =?utf-8?B?RDY2cW91SU5pVFU4ZGhHa0t6VEIvRGEvbFhOUk11cytBcXV5NVBvd252bmdj?=
 =?utf-8?B?RXA5KzcvZDYwMEF3ZUpQQjhNa0cxRGs0eVZ3TkVNaDN3bjZ0VU1zQWRJbFAv?=
 =?utf-8?B?amlLQ2FHVDY3OXZRcytmM2NCK1psb3pNOVFFWGxtS1lYYzBLZ1BuQUlKNDhO?=
 =?utf-8?B?aGNVV2FGVnp1c05CT0pZVFJ1cGR3TzZlUXZvZGFYTTdNK0E9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:46:27.6597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf524c1-d282-4449-d9f8-08dd01fb0a47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408
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

This patch adds the missing parameter descriptors to the functions
v4_0_5 _start, _stop, _set_unified_ring_funcs, and _set_irq_funcs.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:996: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_5_start'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1205: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_5_stop'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1428: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_5_set_unified_ring_funcs'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1594: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_5_set_irq_funcs'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 4e7da56a9f34..e487b68cecdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -989,6 +989,7 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
  * vcn_v4_0_5_start - VCN start
  *
  * @adev: amdgpu_device pointer
+ * @inst: VCN instance index to be started
  *
  * Start VCN block
  */
@@ -1198,6 +1199,7 @@ static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  * vcn_v4_0_5_stop - VCN stop
  *
  * @adev: amdgpu_device pointer
+ * @inst: VCN instance index to be stopped
  *
  * Stop VCN block
  */
@@ -1421,6 +1423,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
  * vcn_v4_0_5_set_unified_ring_funcs - set unified ring functions
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block for which to set the ring functions
  *
  * Set unified ring functions
  */
@@ -1587,6 +1590,7 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_5_irq_funcs = {
  * vcn_v4_0_5_set_irq_funcs - set VCN block interrupt irq functions
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block for which to set the IRQ functions
  *
  * Set VCN block interrupt irq functions
  */
-- 
2.34.1

