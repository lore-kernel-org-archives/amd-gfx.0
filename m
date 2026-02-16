Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24B6E81A3A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 15:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4644D10E3A8;
	Mon, 16 Feb 2026 15:50:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jTxz/zSG";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012058.outbound.protection.outlook.com
 [40.93.195.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCDCA10E3A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 15:50:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiNZU52c7AiakAXCMfv/+Jl8xmITHF/846kxug2CCQw3wfyLksAMmky1l5MmOBjjgSfgF3+skawNheSPXjywZ0u+t8MlqEuLn+piJN6LHJFe9sLMx3e2UaeYGMYNTFQHkQ5i1nXYxCatSb01cjoQR349c7pOgnBVAA2DL6MAy58DaUT+Y37iIm3KSQWQYXMC7hacUB25zmh7mYWzcgAjwiQwXmsS6KxkjUaKKkoZH3TLOmVaii0SfG7ZZ/m1Qo48qE2jO4cBfnj7pFf7CHqtQtRtzZ+/xqbAQj6J4viosszzl7gk753m8R6p1GwFqGBUR47npZ8JLwrkacQi2Xt6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoWXw4rnETf63ymrrsAAntegLWTAy6rlMjsjQCt6VZI=;
 b=SR1Fb+WMl6jpxGdmq1023yenqJBulrGHhatHtJkuRRIm0HYTn+hobdjCT0wHJeugiIX6un6bM3PKCWfPKsJv2BvcKEB1jtnbDUxj5lgANWHGBPb6lAqGyke266XgzqnodDiBPEPEzp8wHkgj9rzYpbpTgfcrStJnOeMQQkDOjrWN3TyhledvNbcYQfg6h+xuEmXmjr7PoCkA/FD5/WdOGoRxkLOa9aUqLv9dUmUr4SbUiM9lvU7IY1IUldf98azDlXa3mn8cAv4UR9OEZg0J7m6TdiOp7Yfkwp/peA7tNTprYwGwwIFRCWcI3GZANUmgoTSxHXb6ZUQ/9dkGyinRLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoWXw4rnETf63ymrrsAAntegLWTAy6rlMjsjQCt6VZI=;
 b=jTxz/zSGjg/MjKqq8GqXdUAj8xaN7KbWYRx6KoQ2JKV7OXPe7NYRh09bJ7SdkuGT90/7203mij7p+MsEzLW7t2qXg6qeHBdOsaM81Gbu6M++rl4ZnGpzhWfCNhUMcTOwz6lCuuS637fPn8oQZJm0HGk6unobX1A8HLrPnJXFE1Y=
Received: from BY3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:254::31)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 15:50:11 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::25) by BY3PR05CA0026.outlook.office365.com
 (2603:10b6:a03:254::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 15:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 15:50:10 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 16 Feb 2026 09:50:05 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v2 3/8] drm/amdgpu: Add IRQ-safe eventfd signal helper
Date: Mon, 16 Feb 2026 21:19:38 +0530
Message-ID: <20260216154943.1582412-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
References: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 16146af4-f0d5-4224-7217-08de6d731138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ay8rRnN4ZkFFMlBJdytaTHpPT1dibjd0WGZvb1dDQjVIdEJXakZWdUNKRzZL?=
 =?utf-8?B?aHVhTzl0ajdwbC9qbWNGclk2aE84b2tkQmlQaHNKeVc4d0dWWmQrYk9lNXFx?=
 =?utf-8?B?a0VObjhuRlBOb0RBNUd3OEJDQTVKT0Npd0QyZlhKRFhLVFc3aDZKQWZ5dGNF?=
 =?utf-8?B?NThPNmFCT3BkNW9xdU5JZFBpMG9GRmtBbElkVXc3WEVJRk9lOWFxMExKZmJa?=
 =?utf-8?B?WkF5WGtSMVhHSFVWZXV3NUtOUk1HNENENUl1cEFlQ3J4M2JQazJZSzViK0c0?=
 =?utf-8?B?cmQ0bDZsbmtqcjhxNHJDc053MDJmbGZPSHVYMmdwV2cyaDFGZ1VtdXE2cXFt?=
 =?utf-8?B?VkdWUTN4MFlsZXR4dnpyWWhXMjNNZnpjMjE0QVN6V05RcTVUNUZTMnQwYnBB?=
 =?utf-8?B?VEw4ODdFZE9zcmdqQXc3Um1paS81ZnFYWGpCaE5XTElkM0YwNWx2THlaZC82?=
 =?utf-8?B?TkJYV0lpRSsrNG9IaHJhMlZMendobUZPeW4wdkliU0I5SHViaVRmRWF1Z29u?=
 =?utf-8?B?WVhOcmRpNlZWUDZLZ0hWcjdNZHhRZlhnS3loQWE2TmlhRGF6WTdwQ0xqb20y?=
 =?utf-8?B?WkJHVk1pN1g1NmNseWlxMCt2NncvVmIyQmFvNTl2U3NrY096WXZwWUphM2xB?=
 =?utf-8?B?cGN5bTdrdU5hMXIvSUdySmdUMU5MaG5rM2duM3pOd1gzNXNycWd3Nmt0cmRm?=
 =?utf-8?B?VWNJbjJJb2xsanNDTjFJK1NMNTcvK1hKaERHTzVuVTlNTGlVQW12ZzE4Mkxn?=
 =?utf-8?B?Q1I3UVAvbUhPSzdmSUh1Qko4MjJqUnNZL3RHdlVMWmlpOXgrUGRIZENLejlj?=
 =?utf-8?B?UDVEaVIwK0lObTlrR3poeXNldmxCNFFERmtUaG1xK054Q2xqU1RSMGRjY2Rk?=
 =?utf-8?B?VFBvWHh0TkNOd2xYZUVTMG9MZW1obk5NNWdwNCtwcmV4ZFVBUFROemdldkhC?=
 =?utf-8?B?UFM1WDRuaHpvanNpRkdKOVorWjBESFFFaWNMWDZFMnR0THczK0VqOGxBRjBU?=
 =?utf-8?B?WHlBd0hoakU2Q1MrYTYxRCtsZUxDZVJEbUh0cDJQRmxld1M2TlRTajJOWVRF?=
 =?utf-8?B?OFI5SVpWTUJoWU1lbDRpcHBuZjFsSDRTS3VCYWM5akVsSHZjWmNRM1gzZitj?=
 =?utf-8?B?TXNnVGNJejAvZWpmbk1PbUhkNGtNZXQrMU15a2orQkNNTHpicGpHOTZYdGJo?=
 =?utf-8?B?S1I1d1VtbXl4YVFYVGxuUFp3cENTZHFxWEdSREpvYmx4VUsvUytwOU9qMGRC?=
 =?utf-8?B?bG9wWVpxQ3VUWHBIWXNBQXJlb1ZDUUZKS1B2ell0by9yWTdHVW51bU8xZDR0?=
 =?utf-8?B?SnZQNXhmbFpwS1BEZlJvaWIxeWxiamxzT1B5cm13OWphTVpmZlFCVHAxdWg1?=
 =?utf-8?B?SUxMSmt2M2pnNlZObVM0RFpnWG9pRmpmMFlwRkM2QVUrc3NVcUJRcmhRNTFm?=
 =?utf-8?B?UmpLZVRnM2luM2ZGWGhhbStERGx2K3g4dnNQcTlRYktORnN2NFU4c0pSb3lk?=
 =?utf-8?B?MjJ6RExNVXpvZksrSjdkekN4dWxWbHY2R25UdlgvZkdzUmJJOUNtQ2c4OGIz?=
 =?utf-8?B?UHBpS25nWEZGRUJ5M255dVpuT2Y0dm1IQWFDY2kyZDV5dEY4emZVUkwyeTc0?=
 =?utf-8?B?SVR4QnlaV2JDQisrdE1GbXZuWTQycnk2eTV4UnFnTnBhK0FHZTlsQ3UvZnIz?=
 =?utf-8?B?TTJUdGRiUWZWRFIzYVIycG9aZGV2Q0IrVGRPTUdJV05MVGZ3R3AzS2F4SlBY?=
 =?utf-8?B?WnJJWk1PZm5zUHNJQkszdlBWQjNqQ2twc255SklLLzUyaXdIN0IzT1kvMm91?=
 =?utf-8?B?OXNXTFErL0pyeld5eFZkclNBQnAxQ0pORjEvcGp5dWNpbnZoQ2Z0Rk9CeUFH?=
 =?utf-8?B?V1NjdElJY1VhaXkyUzlOUUNTTUd6STZuZFl6U0dQYng5a2srcmRETkI4NmF6?=
 =?utf-8?B?VFJ1Z2RrMUFwbWxLNlhuK0VRdXVaOFE4eWU3WmVwY1J5dlI4d1V0M3Fad2hY?=
 =?utf-8?B?djlkcEN0NXRvUWxqV2hyODZERTFmamgyRGdvbXhmU3pmZXdFcFU1UGlMd2Rp?=
 =?utf-8?B?cXV5Vy9xZks3Y1RxKzA1ZGMvT05VQkdxL0M3ay9CWGJEMHVGM3p6STUxTTdI?=
 =?utf-8?B?L3VqaktKdGtGSWpuVVlQS2FVVUlrT3dYZmx6N2VIUVhmazR4TC8wdUM2MGg3?=
 =?utf-8?B?Tk1hditYMDgyUjg4Szc0OGxROFZIUXQydHd2QmV5M1pUeUp3WGliMXJxWHJG?=
 =?utf-8?B?SVR0UEN4ZlE3WGE2NWFtV1RXZFNRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QG1408TWf8A80EHVh+r2R7M3LMte4L5yoqVWuz1PQtAJ3zoqdmRTALmvT801St2fjbXl+cShKlWXgc1mHy5SvMUgCXEZZO5h+KgwcC8pX4vGFCHNKK0gzA14zdl5I22+YzRrR6DkAcW8Q7oY3uRsPkKql6lkB4Oa1hKIvfs4KyV/luUERKPUEZTqBTI3CF4PRzSlwtADSy7QNxWJSOQrMACXeJBcZ/9KhZI5hTK8OYNcrC1uzy+s/PTBFd5BwblTy79bvovw0+a0h8boZ/RhTETAj6GcDCnYfmaZ2+C70buj9VcYR11No+mXRUFWd9KkAZaNmROsd3wLrEKj1q+DQWL8nzO87LHhXxzFWcCWk4kfURBY2j+hSHaqfUtpLPKNOOj1gNFcOxAyQQNSd3H6SUIbCMkQYmhwmhgJX9FstgMmeiVMXSLE6w+MyTmJmX0I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:50:10.9681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16146af4-f0d5-4224-7217-08de6d731138
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
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

Add amdgpu_eventfd_signal(), a helper to signal an eventfd previously
bound to an event_id for the given drm_file (amdgpu_fpriv).

The helper is IRQ-safe: it uses RCU read-side protection and lockless
xa_load() to find the mapping. Bind/unbind and final teardown already
use call_rcu() + synchronize_rcu(), ensuring safe lifetime of entries.

Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2baeb0b20df1..b0e9b7ff2f80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -473,6 +473,7 @@ int amdgpu_eventfd_bind_ioctl(struct drm_device *dev, void *data,
 int amdgpu_eventfd_unbind_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file_priv);
 void amdgpu_eventfd_registry_fini(struct amdgpu_fpriv *fpriv);
+void amdgpu_eventfd_signal(struct amdgpu_fpriv *fpriv, u32 event_id, u64 count);
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 43da5bc36b7c..66e2ae8b7c8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -745,6 +745,27 @@ int amdgpu_eventfd_unbind_ioctl(struct drm_device *dev, void *data,
 	return 0;
 }
 
+void amdgpu_eventfd_signal(struct amdgpu_fpriv *fpriv, u32 event_id, u64 count)
+{
+	struct amdgpu_eventfd_entry *e;
+	struct eventfd_ctx *ctx;
+
+	if (!fpriv || !count)
+		return;
+
+	/*
+	 * IRQ-side: lockless lookup. Lifetime is protected by:
+	 *  - bind/unbind freeing entries via call_rcu()
+	 *  - registry_fini() calling synchronize_rcu() before xa_destroy()
+	 */
+	rcu_read_lock();
+	e = xa_load(&fpriv->eventfd_xa, event_id);
+	ctx = e ? READ_ONCE(e->ctx) : NULL;
+	if (ctx)
+		eventfd_signal(ctx);
+	rcu_read_unlock();
+}
+
 /*
  * Userspace get information ioctl
  */
-- 
2.34.1

