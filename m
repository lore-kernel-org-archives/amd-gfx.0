Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FBACAC582
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 05:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7926F10E43A;
	Fri, 12 Sep 2025 05:55:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mtaU36H+";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5149C10E43A
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 05:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJ2JVwdnmL2btFIYlp0djxNuZIYvTB1OF01tzPB+1XXvRUgW6ms3hvLKqtdYOts9gM2sDDeWLMGA8P4/70uv+FmXXhlgn5WyTqGlaHio/Wy0EBuVp0Il9n1BbfUQS/TtzfTplt9DMmmNCbMk3Rm0HTRKGulqmu6gy3HLICy/PJgLLa5mpkhYXF7ZJ+cdFm0kRkGHea8UK8jdtPwxlR3OYmd+PeFlCO3xc/A5l8DoAaO6iIhUVyBciGZincjVZnriqV8ySwpJKrZDZ+2XoenIuz4NPPxyMhWIGA1GPAyfxWCeJDOJt1uFnqspoKLt+aGsTkgfQ4lUuzPFtKFjpjPh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ql64q1ThWRT3rinYn6xDCupUywWFT//C3BSqCNbji7k=;
 b=pGEArc6Xfppj0Lh4Ycl8rKKkrxH26dqeNelf7uFHLDS8u5xVKIiinJrwamh97f2UnmGKWhaKlmtydOEjrKzs/SEqUaLyXJI4VC06Iyp+4mz2p1CzET3GkMJjI9fqaEAdNekyrWrN7NC+TooRRgn275KG5TNNvlcrAThYkAqo1fTIEBaQrLRungGVSo+giJuMAQwWEC8ws4M9b+d6dBaeVuCmbSGMf4/ABqJ/VMsGRAbfgFjWncl/tTpuF0Tv65Q419NiKgsmsAHymfeaUrqtWsSg4+pj0xbKfD7hu+EwG//wSbj12NdMf+GJnWIdd/vVRgnUAD5yrWNkCtCQ0V0xtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ql64q1ThWRT3rinYn6xDCupUywWFT//C3BSqCNbji7k=;
 b=mtaU36H+5APGiaJlzX6cC1zKq3EzXBhnbSM1gSkODv7J2HCsmyqR9I/aeBGtb4KgwwFXhuN+/2a0efir7GveHwLlSPR8EvW7rVF48OfBcPbalf6WoQevpV3aJVu7V8P6IuhKxer9MPC96BXhoGro8niMcwQ5X8M7JekasLWyIeE=
Received: from BN0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:408:e4::19)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 05:55:31 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:e4:cafe::f0) by BN0PR02CA0014.outlook.office365.com
 (2603:10b6:408:e4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Fri,
 12 Sep 2025 05:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Fri, 12 Sep 2025 05:55:30 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 22:55:27 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 1/9] drm/amdgpu: add UAPI for user queue query status
Date: Fri, 12 Sep 2025 13:55:10 +0800
Message-ID: <20250912055518.2719533-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: e14bd7bb-1e5b-459c-6455-08ddf1c0fada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDZCY1BIak9iVnRVL0ZMMVBhZzJhUFM0NWo2dDJqN2lrQjcrbXZkaDhKUW5x?=
 =?utf-8?B?WlZwclFWNXErVmJRWTd2MXdUTFhac04vRC9MbmgvTHY4Ym15N29mRDRHczQz?=
 =?utf-8?B?ZXFxdWNKQXRRYW96NU9HUnJvKzNSaTgzUkswMFJqVjdRZHB2UE5WaFdTRU5Q?=
 =?utf-8?B?UUd3VFhnN3JyNytmd3ZCRkR5UDlTM095Ynp4YnhFdUExRll0ZFpKOUpNc09h?=
 =?utf-8?B?VUgzMEZYektlNmxaRExBbmVBdGljazl4OEN6UFhBWUo2c3JPMUs3VUFlVCtO?=
 =?utf-8?B?NEsyZkM2aWNTS0FXejFMZmorLzl0SDVzeGtPY1BOM3d5cFd5eXFDcXNCdmZJ?=
 =?utf-8?B?VzBzWHZOTG5PNFgxcGtrK25PYUt4QmFMSFBITTVoZmIyOXo0ZUErQTRvd0l6?=
 =?utf-8?B?ckE0TEUwSzZwNy9laWpEZC9tVklTWEE3WXJnNXJEYzFkaE5BM2QwUXR3ZXBn?=
 =?utf-8?B?eXk2UCs4M0pRRGtqcGhJQVFyLzk0YkFXK214R3VyYWk2aWVNbmRkZytWREdM?=
 =?utf-8?B?NDFnYTRaM3Z6c29WOTM3QUhLcmQ2c1JzWjh6NC9pRnZpM1RWejhMNHhMNmc4?=
 =?utf-8?B?SmJ3amR5NlMxN0JVOHF0c3NmUmNIWFltOGovMldEQ1ljRFNsSHJPbVlnOHVP?=
 =?utf-8?B?M3ZuQU1STlJiSldRSVY5Y0lJb3ptb0tVS0RPYnNyeEsvNWNIY2RhTUhSdXhv?=
 =?utf-8?B?ajJ1WTJMUFRrMVZUdUZ6OFhSKy81ZGRnMnVudzlrWnlzbFFCS1BpR3J4VjBt?=
 =?utf-8?B?THoybTd0MGx5WXdrVXp4b3BtQWFTZVNTT1hQd3pBQkZ0U2hOWWE0Zk5XR2hR?=
 =?utf-8?B?aGZ2cVFFUkl4dWg4MHltLzkveG92MDdNNWJiY0prOCtjRjRnTFIwRlg3RUcx?=
 =?utf-8?B?TTVGSnpUUjhVZksrYVpyVlh4MGlTUFhBZUUyaUNiUlBFZjFrdlg5bFJoaHpQ?=
 =?utf-8?B?R2k0YkYzMWlxS1k2UXR5QWtMWUxmVCtBZ1lTWEJuT1o2QWRQZUFLUE02YnRZ?=
 =?utf-8?B?NkErTmFaNHpndW1MZUVUb0ZqY3craDc0cmVkQ1pCY1E2YXhwV0FON216L1cr?=
 =?utf-8?B?TGNjL2o4UmZCWVdiNmJOayt6YTRZamdLbEJyRXBYWHpPWEoxT2l0WEFyOEtY?=
 =?utf-8?B?Z1FxRjhOSEV3cmJkWFlieVVsUk1zdlcveEdYZVZPUWUvUUhLSnRod25teFRa?=
 =?utf-8?B?TGl1d1d6RFF4UmJsZURRTm1GR0JEU0pabCtMMmUxdDZ3c3pieVRjUmI5ZTFE?=
 =?utf-8?B?Tm4xbmhvWS9nckliVXNqb1ZJaDY5NDlhOWx2TkJnMUdkZkJneFp4V1lyYmNa?=
 =?utf-8?B?UnQ5VHBaVWFnV1BHVjBRNnpCUzBUZncrNm1YOVVXL1RuNXZjNW9YWVpwNVdy?=
 =?utf-8?B?ME1VbTJ1YWw5S09jc2pETjNoWTZyTTVCZzFRdXZnRnl1R0ZnUUdRck1PNjFO?=
 =?utf-8?B?R2lBRi9kL3p0bDZITXpTYlNoYzlad2xyYnd2anNzOVVqSjBTY1c4blROcFEr?=
 =?utf-8?B?TlJSWWxJVDhqVGtaRXhWWXNkL0gvRFo0TURKTTlQV3NlUEFPektlU1Q5dXlr?=
 =?utf-8?B?b21KeTZBUDdjN1VCTm8zM3FkRmNja29ZaUUyM3dwL2M3cjIxSVJxUC8raldl?=
 =?utf-8?B?M2U0cU1XTmpCR1VRT2RIV1YvV1I4cWNkMzIzWStKRzRNbGhPYWVjVzlMQmZO?=
 =?utf-8?B?UGpSY1lVTkxnaXRWN09LU1pCdTA2V1VQN3UzRTdVWXZwZFF3ZUI1YWpmYURT?=
 =?utf-8?B?M3NCaURuYkhXOWttNUtYcDA0d1JpaTU2TVgwZFJSaitkRzBKbGgzQXJZVWJq?=
 =?utf-8?B?eXpWYmxxQkw3cGx0WlpiSmFTeUZ6TXI5ajhoM2syVGkwajR5emk3eFRMLzU0?=
 =?utf-8?B?KytTdGplWTFZa0dwM3E5MktQeGg5WmJLeXh4U1JHRzlHQVdTV3VTWEVHYXNV?=
 =?utf-8?B?bzVqQkJFVDA4b3ZNOHZnem1DcFF3SCtTN2htV29zT3VLOUNqVERiTHBvVERo?=
 =?utf-8?B?dW54cTlTeXpyQWlUelpsaFl0c0tBVVNuWFo4MkFhWVFSVlJESjIrNWZLa2R6?=
 =?utf-8?Q?xYbDhW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 05:55:30.0695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e14bd7bb-1e5b-459c-6455-08ddf1c0fada
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
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

From: Alex Deucher <alexander.deucher@amd.com>

Add an API to query queue status such as whether the
queue is hung or whether vram is lost.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9cebd072a042..ff183d239b21 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -330,6 +330,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_QUERY_STATUS	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -342,6 +343,12 @@ union drm_amdgpu_ctx {
 /* for queues that need access to protected content */
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
 
+
+/* the queue is hung */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
+/* indicate vram lost since queue was created */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
@@ -423,9 +430,16 @@ struct drm_amdgpu_userq_out {
 	__u32 _pad;
 };
 
+/* The structure to carry output of userqueue ops */
+struct drm_amdgpu_userq_out_query_state {
+	__u32 flags;
+	__u32 _pad;
+};
+
 union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_in in;
 	struct drm_amdgpu_userq_out out;
+	struct drm_amdgpu_userq_out_query_state out_qs;
 };
 
 /* GFX V11 IP specific MQD parameters */
-- 
2.34.1

