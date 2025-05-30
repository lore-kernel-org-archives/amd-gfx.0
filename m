Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F47C5B549
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 09:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB2210E802;
	Fri, 30 May 2025 09:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uWvqN25E";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44FE610E81C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 09:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crcHQcfyyvFOO3/jwebAjwcGLWYLhXRknOqzeEU7FJOO76CRZXKAHt8+o7r3Z7jCBFzOE9S1dDwJSzJcIAOVTGFJnardCEqQquIvJvdHz6LNNGk2+K/bbw3lMnq/gAHTQz3VVv1hfsageZHaw36MQgFtvoixqfN26d9+xx8giFe4Tj4zXLBA7QW+h0EL77VPVda5IZjFaEgsXho0m/4pA90zq8uMqirTy1spfIhD1UqCxxJu3dhAQwxOtiW3MKeIWn3WSG/l7QjsD3Qb9uyTKKJw0kISVWhwhMYrSRFC+c1hQcK4mnmqbJGntp5IwfNP1GpiI+OOj2iQ9d0Sq1T7LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNspSp7ZRRKrgYXRUAv6IYJaDKHE3yUMLtdOlRoUCEk=;
 b=ZSrzC71IEYBw6ttyq+moCCHN57ofl5gm2EGKyq7hha9JtfY+cqxg+F3mA7pmF3iwM0wp9A82ZDHLaC0BoK5lwMQUAlQSqbIpNGr0PSMPoS8nbo/VKsl7BBToEw+BuQ448nWUDM6y6hw8IJquHsQVzaFNNRpqnd9NB+W0vP+a+eHN7v4ht4Jb3l7Z4qjOlhoTtWKa0c91nwQNVuk33W+jYZAAUydkDCyqCLqhoBsg88mS2gEazDaQyP30Ot9JMYwNFNNBkjprftQLNh5rM9N4bCUPLIUFcK3L/y56/K43o/kOB0YctbpLx5nUvIHau9FFLjauRJZDO1EWPDdMHaPSfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNspSp7ZRRKrgYXRUAv6IYJaDKHE3yUMLtdOlRoUCEk=;
 b=uWvqN25EO5ghXoc5e/mh0H22BzYwcUd1EIUmV/xvNnG5S8dYLviHa5WndSTDOa4/BiA/VmF7ohi9DbtkriN6LpJ8kbIC6GBJ6SLmPLqjmROw0njFaboz9twcn7zbb/N02bbHNmXO8q2LNpIoc4Drk/de5Bi4/hjqvd2gaPuMp3Q=
Received: from CH0PR04CA0071.namprd04.prod.outlook.com (2603:10b6:610:74::16)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Fri, 30 May
 2025 09:04:06 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::87) by CH0PR04CA0071.outlook.office365.com
 (2603:10b6:610:74::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Fri,
 30 May 2025 09:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 09:04:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:04:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:04:03 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 30 May 2025 04:03:57 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 06/14] drm/amdgpu: add UAPI for user queue query status
Date: Fri, 30 May 2025 17:00:07 +0800
Message-ID: <20250530090322.3589364-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
References: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b69977a-2072-4830-add5-08dd9f58ee48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGM4UlFzUTIxbTl4dW42eDRDNUh1Vk56a0dwYTd0U3VBTDg0UnpzbHdSSits?=
 =?utf-8?B?anlyVGUva3ZYa2tIUHl3Q2x0RzZnaWZHT1JhYUExOE1meURoanhiWS80RExv?=
 =?utf-8?B?L1ZMVXBweDF6ekV3bGF1TjVoVTFFa3N6VkNKc0RldXV0SElTTmF0Q1JtOFMx?=
 =?utf-8?B?YXV2aWVtazFTVU1IOHh2UmM5TE9GOFhBU3BBeUtxNVpYV1JteDJHMXhLdTZw?=
 =?utf-8?B?ZkxJMjdzRGgzSGJFNDVjczBKZDVVN05yZUtzWk5ZWWdncHh2NDY5RFAwQ2Nj?=
 =?utf-8?B?T0JSbDg5SHl0dit0QnZ4TE5Ya05BRTdCUG0vd2lGNzBHaUVkcmVlUGtEUVZo?=
 =?utf-8?B?M2I1OHBPRE9Vc1RjRHZ3UFo3NjhoRDlZcTFGVXJscTU1UGVScDM0TjJjd0lm?=
 =?utf-8?B?eXdXN01relVLbjNNU0N4UXdPMGRhNU8xbCtuUXI1dGhIQUhqMGxIT3AxVTJP?=
 =?utf-8?B?Zi9FWVdwU3JBOXBmS2R1QkNMdG92ZUwxeHczMlo3WHB2RjFDVTM1OU1BZGg3?=
 =?utf-8?B?M0JEMWF5cnU3cWpXM2JJS2c1SWFBODJVUFhFZXhuL1JMbE9jc1hYY2liUXdT?=
 =?utf-8?B?SnkrNXdvNXJ5dzd1blg4ald1VFAwdGMzQUF2SXc1RzZRci9XUWpLc2FrcmhQ?=
 =?utf-8?B?UGpYMDZXVTBmME1MMEZWYlg3RnlBM3NoUXVEbGsyaU5rcFRHMUx5cnJ1NG9l?=
 =?utf-8?B?Q3FsWEdVSHRxSXdLcXJNeDlsb0FuUDltWVJrUFhFQzhGOXhPOEFjRTgxa29x?=
 =?utf-8?B?NEVBZXU4VkhxMk9TTllidzJua1d0djY0MVA1b3NEcm5RQVhzL3Nra081MjVl?=
 =?utf-8?B?RWZRZ2E1Z1p1QUxYWDM1SzcwVVVMeU1KMVppOVl6NnBKTVJnbG5JL2FEem9Z?=
 =?utf-8?B?NUhMYWdPdnpDQk4wb1ZCbTFHazFhUDF6QTlhaXRKMUZENTNlRHhONXB1Rno2?=
 =?utf-8?B?TFJuNHRKbDlCSFNabldvU1I1RjRnNzhUUDMvL1pURVdxTC9XRkZoNngxQm1a?=
 =?utf-8?B?cTRDaVpOdVVEUk9ZZmU0d0F6ckZ0aHhwZU9sMmRRR1NzeWc0MUxnMmtRNEdm?=
 =?utf-8?B?QlhzeGdIbUVweU1UUTEwblNMclBvZFpsc25jMU8yTFhHLy9HMVNiQTE3dk1O?=
 =?utf-8?B?L0ZRakVpVTZPSnYzUVJMNGkzWGZDMk56aTd2a1dKSEpjbTgvOTAvYlhUT3Zl?=
 =?utf-8?B?cEo0SFRiM1cvTkVGKzZyTW5RTjU4TDQvTXVjTE1QdzBOTmk0cmI0ZDVLU2ov?=
 =?utf-8?B?akNwV090cFJCb2hHckhuY0xJWHlpNlNlOXdjUENZbHgwcWRKakw3Z0NrbDBp?=
 =?utf-8?B?NkRhYTFrdm1hTkZiNDhvVGdrU0Y5MENLZWlnVlhnVStoUjF5dTZaMnJCdVQx?=
 =?utf-8?B?RVBNb1VZTXhVelFpMXhlK3FzdWFiQXZ2WnFoLzJaSTZtMG1pMnVNTXRGSTMr?=
 =?utf-8?B?dXZLSWtrMXdNREpJQ3R0aHpoWnIzUE8xMnJFUmJTMi85WHYxbERhYk81QUQz?=
 =?utf-8?B?aFQ4bHFOKzFZOWFaWWJDdnpOSzFTenVuUFVoTjBvdVJmZmlMNC9QWVcxZVdH?=
 =?utf-8?B?Kzk1bXlvcDhtcmxoQzVtV1JsNk0rQmdTN0VmNExDYlJrWmdwd3h0VVlycXhC?=
 =?utf-8?B?cFJIMUhUbEFEd293eVdJNGppN0x1OTVJMTAwdDI4dFVXZllobyt0d3F4R0c5?=
 =?utf-8?B?V0hzekV1c0RmUXFXU1lzMFJFYmNpVXhqd2JmN2ZYdkZsb3E0OENSLzNWYmkx?=
 =?utf-8?B?T1NTOW4zUVpxckxHQVJRYXZya3JJNW5mL1VEUzY5ZGNKU1pIdndHbWsvcmdy?=
 =?utf-8?B?K3ZuYkVrdVJJSVVyMGpCS3oxY2lYMnpIQmd0VDA1SkxDQUkvb1FCejZONDlI?=
 =?utf-8?B?UkMzMVlYUzVHRjljaTRrQWdhVGkyV1VjdHlJMittR0p1Q01VcnVzR29hU1pP?=
 =?utf-8?B?RzZpK2tyVTVGeVp2VVJvTER0aG5uaUNDNkV4S08reTNEZkxYNEp1S0plNXlV?=
 =?utf-8?B?ZW9wSHBxTEdxMkh3Y3BRRE9nOE5WakxGUC9qN2h3eVh3bmVBa09qZG9GRWdD?=
 =?utf-8?Q?AXa5fx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:04:05.9601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b69977a-2072-4830-add5-08dd9f58ee48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949
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

Add an API to query queue status such as whether the queue is hung or whether vram is lost.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 45c4fa13499c..62e3152bfdc7 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -328,6 +328,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_QUERY_STATUS	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -340,6 +341,12 @@ union drm_amdgpu_ctx {
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
@@ -421,9 +428,16 @@ struct drm_amdgpu_userq_out {
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
2.49.0

