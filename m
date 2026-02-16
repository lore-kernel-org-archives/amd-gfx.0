Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC9EEF5871
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 09:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BBA610E1C4;
	Mon, 16 Feb 2026 09:45:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YyljH383";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013016.outbound.protection.outlook.com
 [40.93.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 285CF10E1C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 09:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccFR8/R0OC6BUNmhsOoTkuv3Qiyz9KQxu2ErBI7zsX6VD6aQHC7OPb9lt8GyZOyWoc7aDbsOiR/uK4JnspP3hU0XMKWSDP/wrfMA8NonjTW1pQk1f0oQU9oUVqoy9EIes5njbFxthg3fehOCFE6BT8iCwXw9eWcJe8UIIVwlcug3iYVqD6SOstYouyMqeJxtZyRgDj3wtzkpE8JBwISoWXyB1utILUiV8U1bhMMSFI/BXqODGqKmoptGAbktzr9adjvuUlLI9xaLHJR7Z9kuURmwUWCIL7uns/Q7T8E1HnGLKDTVdZ3s8ZfqA3mwFKWk4Ln8QmdcT1bf4YFiRatDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDExWVnTrePbCIZFaIZnbeJhFgbEhP9I6G0l6lQVOAc=;
 b=ikhAxtJOmLvUa1ZuspHqon3/IgU1FYNV25stQCR/fTOrTTGesRXZdoBbEkcVLg6Rt1mAYDaP75ThZI+XenKk5p0XuHcD5c7G+EyfWE5JL+qi5BG1iQ2LCvZxafS6sP2SVicRnIBA//i6kT3s1W9lWQI+3Z1JmzeWpR0awc05F1fk9MxPP5fSTa3totFQlBD6iyFLiQqcLy7Rw+Vn1drlroozEQzill/CdCa4+gk2mAnpi+ZF4+ynWt6l0vkQUC2dTuyK5voHpgSE0KIsQsy0QApSgxY6yXoXVndNEi0i/7ROACsoLHdUjpBc2MazwL+iy1ZeB0x+OnnktFS3N2TOyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDExWVnTrePbCIZFaIZnbeJhFgbEhP9I6G0l6lQVOAc=;
 b=YyljH383MpmJgegujBzHzbxlQjYe/dUswOZtLjEH9ehsLKiAiWbw3McETN3RhQMiQWGhPzwyfjvLoSS3lrKdGdKr0FFbBZr5S0OluwUCAe+OoG9a/8NbKSRVWLuBK0D8ZljSvWao/ehB6Jchlosv5mnYFvKcsb7I7ZvITCDKNi8=
Received: from MN0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:52c::14)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 09:45:32 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:52c:cafe::8e) by MN0PR05CA0023.outlook.office365.com
 (2603:10b6:208:52c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 09:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 09:45:31 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 16 Feb 2026 03:45:29 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/uapi: Add EVENTFD bind/unbind ioctls for
 render node
Date: Mon, 16 Feb 2026 15:14:44 +0530
Message-ID: <20260216094447.1581407-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216094447.1581407-1-srinivasan.shanmugam@amd.com>
References: <20260216094447.1581407-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a174a1-8809-4eaf-3fe3-08de6d40202d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anZBVm1iVWhpMnVMSXFNcWFkNks4ZzZuR1BWemtZKzI0Ly9IL0dRSldtSWdn?=
 =?utf-8?B?cUJnZGJyMzBHQUQxeStLTktIL1VNK1oxSEVRdjRoOXcxWkpNaDRnUEpZektq?=
 =?utf-8?B?ckJLYk5SV2hITVhHakplUENsTHhwc1JtdGwxVHhvbGgvYVJYbm94d3dzU0pE?=
 =?utf-8?B?NG15U2s1OWxoQktvWCtaeWNEbmZjOGJKMkRLcE9FZms2aG5nR3U0L2NiNUZ2?=
 =?utf-8?B?andsV1hQQXRvUmFRS081RldKaTR0RWVHWlpFbUsrbFU2K21USWgyOThqTk1k?=
 =?utf-8?B?SzF1R3k1Vlo4bTBsYnFyNjRRQWk1WmlBWkc5cCs1QWVPVkpySWxobTk3MWxF?=
 =?utf-8?B?QmppcTF5NHlVeVczUHU1amRJSUJXNkhZelp4QlloT0ltRkMvVVhlZTIvRWxG?=
 =?utf-8?B?U1ZNdzNzNU53ZnVva2VuOXN1MEJJSXV3UEZ5RDBaZFZOYzJJQlF6azlRQXdI?=
 =?utf-8?B?TXZrODFHZmJTazhFbU93MmYxWUVrcFBDMXRXcW8rcHVYYllDRG1RbVQwUFVP?=
 =?utf-8?B?ZzRNVlpONE5zZlA3ZitYZ21rMHBIYUtmZ3VhUjgrRERyUGcxQzJBeFNtSlNK?=
 =?utf-8?B?UkNUaCsxRTZOdGtiQlJwbVE4TUtzNTBYRzRxTVU5ZHpaa2Q4K01ORjFKYUhJ?=
 =?utf-8?B?THhDTm9hcUFJVGh1U1Jla3NuL2dJUzltMmFtcHM5UnRCU0FHdnhtUUViUHI2?=
 =?utf-8?B?K0JtY2x1c1JYNWpSTjBqOWExK1pyQVlIbmhRWTc5SE95dS9LV1hwMVRXdnBy?=
 =?utf-8?B?eEN6K3QrK2RWdStRV1h1dDVueEZISkxRanFLY1lHckZEWVNxWDUvT1FQMUov?=
 =?utf-8?B?UHV3Wng4YkEzWGptMjViWGZ6YThCTmdBL3hRMldhWEVFNEt5d2R6WEhBa3gz?=
 =?utf-8?B?eXVxR0kxb1Ntb3dzUUg5S0hZWTVWa1VLVFIybGowd1VTcC93RVN1ekZSZ2VK?=
 =?utf-8?B?NURiQURTUE93dXk5dzcrOWl3SXkzeHJUSTUxVGVhWm5qMEtSU2VZMW1oa3hJ?=
 =?utf-8?B?OGI0THB5UWd6Q0U4VWdqODFENkgxQUlsWWc2ZzVIemZUdzVrQ1dHRzc2d1dr?=
 =?utf-8?B?b1pmQkVvNllCRWpBVzBWdkROR2dlc0ZPK29UVlhVQXlyZmp6ZUlKcmxxck9R?=
 =?utf-8?B?UkdNdWZHQS9YcjdOTGFBYnlJd25PaDRVa3lSbEFHME5McVlXL2Zna1dQNktz?=
 =?utf-8?B?S3B0a1BkTVJQZUxaUWhtVmFJSGZ5R05HQU82eUthQmpXZ2RXaWw1YkhnTXVu?=
 =?utf-8?B?MDcwWVlFbFhJQk1hRHg1aVg3WHI5MUJSWlJQQ3lnYm03ZTh5TzdHRVZmRnIr?=
 =?utf-8?B?Um9paFcvSzZhSzk5a0xSYXNHb2tRMk1ZOS9YNG5XSEFQaEM5elNpbEwvOERo?=
 =?utf-8?B?YkFsNTZvVFUvZG5WcDBvU3hlTTBXQUtBNzdvVEtTUWRFY05IaUo4K0dXVzNR?=
 =?utf-8?B?WkVEWW1aZFU4TzJnYzBUZlMzRi9TSkN0ZnFid0FTQTM5WjJjZnlIN2Vja25j?=
 =?utf-8?B?UFRGMXhQR0tKMEhwRi9QSUJCMFdiVnZtM3pMc3FZVWlsWXIyUkx2aFF3M3Fy?=
 =?utf-8?B?QjBNUktHWUZZMVFoTjhjLzB3dzBEcGd1UE1uTTY2dUFGa0hDZnhzZEEvakd4?=
 =?utf-8?B?b3ovQU16MGZxU3JVTWN6S3ZuR0Rjd2VvVW9tU0lHb3ZmNjJWTzRWYTFBQUFu?=
 =?utf-8?B?S0tLUnMya2o4MGxKZGZwK2dUQ3dJNENDUUc1bUJId2w3a1RLbTg1NTF4VWZQ?=
 =?utf-8?B?TzdyMzNmU1FEckk0K3pac0xwczZqajRRYWRCcktXWHRWNnNBV1B3WTFKZk1m?=
 =?utf-8?B?TEttMTJGWUFMd1hMYSs1T1pCdWZmcDlkaWoxT1diYXJ0SzB6dkRuRkoycjlG?=
 =?utf-8?B?UW1nTnRkYWoxZnBLVStEZG1JMERHWDNjcDV2K3BDcU1VL0c4c3V6VFVLR1Iz?=
 =?utf-8?B?R2V0aEt3T0pRSFppN0VKUEJHYzlGVWwzbXBzbjdqQ2lBdnBNWGQ1YmJ5OWd1?=
 =?utf-8?B?aW8vT0FxYVRRQ1luMUlWSHdYK011YmRlNTBqVmhMdFdXZnBZR3U5bUhzMys5?=
 =?utf-8?B?ZTNEVjErd2lTYzVJT1VFUGE1WUdGLzFUSk5QT1FSTGJNVDQxSWp3NFVrMVRo?=
 =?utf-8?B?TnFiUmlHdGxZQjRXUVZFOVR3MktvbG0xb3pxMERXYjg1c2Ztd2FuWlFjbU8v?=
 =?utf-8?B?dVlpMkhRdDZSbG5xSUc1K3liSHJzbzFMZDVmL3JGcGNsZDhiU1crc3YzTlZm?=
 =?utf-8?B?KzhrOVVoZWgzMjRqWEJEQmN1YUN3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C3ZXyffVDyok0+UGlk/PW8XaL+Dqf40x0pXdaGqNKOkd7x6m+Lnv2Hh3q0P7kkkgssnT+YGBYMCy+vZ0nf0O2d9nsHdtUA4CaUhoD7QigXqf7mNIXHQ2CLpeP/4rN38qoQz3OipcSH/DhFar/ebdP4qRdcLcE/Bjugn+XEe5WzUpFhv3MhgsjL74USg6WCvU0afCq5W1riCrubF30+Gt3CJZgtkXR2fqGKOp3Xw9FuGSGosr2kwly78UrX87quEC9/h+SwIaqIozziWxPxD6Zn7O42GsHWKC7zGHb7qbm9uWfoHsARAmSbOLdsdJylZBubyRGO3Odi91+pDIKS1OUm9F0YCo/moDBBMh8nCwK1JDGjv1wOMgJtNhFb8EdaOcRSTOkBboGuUh/OYW3CbiOkfLSsakwtiGguYsmHspzjQ2LTjGd/Ik8Rxw0osm2Vtj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 09:45:31.7923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a174a1-8809-4eaf-3fe3-08de6d40202d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442
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

Introduce two new UAPI ioctls to allow userspace to bind and unbind
an eventfd to a userspace-defined event_id on the render node.

    DRM_AMDGPU_EVENTFD_BIND
    DRM_AMDGPU_EVENTFD_UNBIND

The bind ioctl associates an eventfd file descriptor with an event_id
within the context of a drm_file (i.e., per-process / per-PASID).
When a matching interrupt or driver event occurs, the kernel can
signal the corresponding eventfd, allowing userspace to use poll/epoll
for event notification.

The unbind ioctl removes the association.

Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I02faa7404c10c40d74c9aa2d4a367c226b8b23fd
---
 include/uapi/drm/amdgpu_drm.h | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 33e8738ce91f..4b367352bebb 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -39,6 +39,8 @@ extern "C" {
 #endif
 
 #define DRM_AMDGPU_GEM_CREATE		0x00
+#define DRM_AMDGPU_EVENTFD_BIND		0x1A   /* render-node eventfd bind */
+#define DRM_AMDGPU_EVENTFD_UNBIND	0x1B   /* render-node eventfd unbind */
 #define DRM_AMDGPU_GEM_MMAP		0x01
 #define DRM_AMDGPU_CTX			0x02
 #define DRM_AMDGPU_BO_LIST		0x03
@@ -79,7 +81,12 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
-
+#define DRM_IOCTL_AMDGPU_EVENTFD_BIND \
+	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_EVENTFD_BIND, \
+		struct drm_amdgpu_eventfd_bind)
+#define DRM_IOCTL_AMDGPU_EVENTFD_UNBIND \
+	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_EVENTFD_UNBIND, \
+		struct drm_amdgpu_eventfd_unbind)
 /**
  * DOC: memory domains
  *
@@ -204,6 +211,32 @@ union drm_amdgpu_gem_create {
 	struct drm_amdgpu_gem_create_out	out;
 };
 
+/**
+ * struct drm_amdgpu_eventfd_bind - bind an eventfd to an event_id
+ * @event_id: userspace-defined event id (e.g., HSA signal event id)
+ * @eventfd:  userspace eventfd file descriptor to signal
+ * @flags:    reserved for future use, must be 0
+ *
+ * Semantics:
+ *  - bind is per drm_file (per process / per PASID context)
+ *  - multiple GPUs: userspace repeats bind on each render node
+ */
+struct drm_amdgpu_eventfd_bind {
+	__u32 event_id;
+	__s32 eventfd;
+	__u32 flags;
+};
+
+/**
+ * struct drm_amdgpu_eventfd_unbind - unbind an eventfd from an event_id
+ * @event_id: event id to unbind
+ * @flags:    reserved for future use, must be 0
+ */
+struct drm_amdgpu_eventfd_unbind {
+	__u32 event_id;
+	__u32 flags;
+};
+
 /** Opcode to create new residency list.  */
 #define AMDGPU_BO_LIST_OP_CREATE	0
 /** Opcode to destroy previously created residency list */
-- 
2.34.1

