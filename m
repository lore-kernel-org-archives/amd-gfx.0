Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA8BE81A3A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 15:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 353E510E3A0;
	Mon, 16 Feb 2026 15:50:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kyDxpIfc";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F1210E3A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 15:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jg2U3Y/HcTaiZTZk2FO+yZT891xypJnt06aWmBWeIbaD/jc1omrOsm6SFGHLZPGuPxiNw/shIHjzt7O9dam/Kb2T0AMDErbcAuUfdzYsza376MjpVUVmCAVohhskjdJyDbpF1XOiqU6pJADRcBKKO2TH/zrWesxXgOHyvE5oVvjAZVot0nHcDiJSy/+kTN3Wy6WEu5KcRNUV0jCO1aR4MtjIQJ5L1sjmnkxNYzE2IpnObXtJGBxcUIyGS8yUB/fELhKHK8/t0qXQ+BC6+1IrI7Jf/rlmbm6gB3KoNr1vd8LiwKzRGy8O5qTToh7lmy8m1m4cTrg3tAFn7mzi6FvGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDExWVnTrePbCIZFaIZnbeJhFgbEhP9I6G0l6lQVOAc=;
 b=IwmCFtPUePQUra1ZNPG3xnrtoE1N27kcM98yLs81QIyUqPKaxUrPnJpYhYtft3qCD1WuuCcz+2m8Gp0rpVW2+cLqqGYcoOO5X3ULDnUkp/Ydo9ZFjuzwK9+EkX8fIsEUOjhT8dQTAwZb9hBql7OX4VCxGpeKQeywGP8PBkwGiT3Yt3YXT6XfZLGq2ZSXNrR0jT2X4mpvbuyxW+iIRktCH9qDwGIlIgQFymS1o0hNmgEi+cyisLegwjNcJEU/JUJt5jKJ9gA5Ao5QoLDz9oH5u4dsLEvin4bJ6KrZVIUMB7sa91mq2h8yWt5oWFsBkcA/05RGHe41y6NEY1X2dgyg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDExWVnTrePbCIZFaIZnbeJhFgbEhP9I6G0l6lQVOAc=;
 b=kyDxpIfcAW42qF1mOdYJJWVZNj3Fs17/k4JyBPbJT3J9FmcUVJoG7DgZxNIqc5aW0/1d77Kawzu3fhmbLWovYbHQvbpAlaVrCi+BIeAutUHIW7Bw3yf1XcILRhHnQ71V/prftpretxTTHMWm8NhyByHWVscfc1qIzfp6iy8H7sY=
Received: from BYAPR07CA0092.namprd07.prod.outlook.com (2603:10b6:a03:12b::33)
 by IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 15:50:08 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::b2) by BYAPR07CA0092.outlook.office365.com
 (2603:10b6:a03:12b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 15:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 15:50:07 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 16 Feb 2026 09:50:01 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v2 1/8] drm/amdgpu/uapi: Add EVENTFD bind/unbind ioctls for
 render node
Date: Mon, 16 Feb 2026 21:19:36 +0530
Message-ID: <20260216154943.1582412-2-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 75aa2b27-ba33-4b77-2581-08de6d730f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cU1DNzdLYnVidm5FeWtZU2dHbU1KSTVBMUlpa2twZGt1MS9USmlSTXUzaW9a?=
 =?utf-8?B?NGdoY1ZjQ29GY3FETUloTGtRUDZEdDhqcVBPMTVncHg3STMxUkpqMXV5bEJY?=
 =?utf-8?B?UGFoRHF1eldhWUVLMWl0bTNhd0xMbGoxRk1HTUg5OFI4ZnBreDAyQzJGbTV0?=
 =?utf-8?B?Wk5VRmQ0ZkFPcUtxajUzdXNna3FMS0R1aDgzbitzWU0yRnRUNGRxcFR6bmhK?=
 =?utf-8?B?dUdtaG92T0l2VGU1WFAzOTR1U1hBNTZtT1RkcXhTT3NqbllST050VjY3RVl6?=
 =?utf-8?B?YzJkaGZPMU9jRk80M2F5Q3BTbzdJM3ltTDZjZkRVYU5rcnQvVXdkWndxUWFL?=
 =?utf-8?B?TWxydC9mdnYzeVFvNEkzNXFEd1FTRUZGa1Rta1VibUZSaitTN3dzKzd4R0pt?=
 =?utf-8?B?Vy9CblVxNGd4NitjWTlPYktQUzhYU0NXeEpLT1BSUk13ZmRVS1gydS9EL2FC?=
 =?utf-8?B?T28wS3JOQTFrSzdmR0ZqRUo4LzloU3hHak1jc0JaL3NLeTBaYkJNZkl1SUU1?=
 =?utf-8?B?cXR2Zk1NNldrK0x3V3Awd2JGMDdyTUdHa3p2YVpucHJneUlVa3I4cjk1R0hY?=
 =?utf-8?B?czJiTmJRNE9hZHArOGNWRE5tcWQ0SHJ6b21Id3N4Qkgzclc2Q1VHNjVnM2hI?=
 =?utf-8?B?aEVpYm80a2orSktEbXczRC9tUU1iMDJVVG1heCt6Y1hCanpYck44eUhkY1Q0?=
 =?utf-8?B?RCswOWRTOUhnbElMY0o2WDdrS3BKRkdWNDFESzI4V01FMjFGNzlTV1dDY0pP?=
 =?utf-8?B?Ri85b2ZELzc1R0crZGxnMXhxb2JybTcwbDhWbVZ3c2xhMndMMlNOb0dXNEJC?=
 =?utf-8?B?MzdOMFpKMkwyZ21iUGRFMWVMN2hqZXdiMXVQQmxxcjdaNHVOei96OE4wZUpq?=
 =?utf-8?B?UmtoRXNpR0dVeG0xQVpidUNmN256dlpBNjJ0ZEhncDBzcVh2UytrN2VBOUcy?=
 =?utf-8?B?UlJ6TlFuMTdoUDNhdkJMeHR5VDMzSkJUbjFCSU5OSGdhclF0WlhuVHVZZyto?=
 =?utf-8?B?THpMVE1ybzdpZzU3dnMrVTJLb1BUcUVrT1premRxNzZmWkJTUDVqT1NVUC9C?=
 =?utf-8?B?U2lpM1RkcmtuL09KMUloY3N1Uk9pOVJ6ZDZiMlNnNFVtVGhRYTRWUktrS1NG?=
 =?utf-8?B?NVRmN1oxNDY4ZHVtVzM5OWVSNnFzc2lRQjBBeGJkNE9PZ1lKUWlucHIwdzJz?=
 =?utf-8?B?Zy9pY0pDZ3ArRWpZMDNXUXpWZkkzai9pclNKaTdyT0QwbkFCcHdQR0dIYm5L?=
 =?utf-8?B?bHlNaHptaFBvdEdHQlcyYmswRG9KMGMreUFvWjBBUGdWNDVZWDVwekRkK2pK?=
 =?utf-8?B?M0dNV2JWbVZkakxXeVBzQWhYNDR4Nzk2cDVSaWk5ZTU5dnIxcDBLZ2l2K0U3?=
 =?utf-8?B?VDgyWjB5NDM5d2lGUDZUanpIaTFUM01RZkFySWRYTFVYR3ZmVC8yTVdhU2py?=
 =?utf-8?B?OHhRR3ViWldVeEx2VGRmMHdUZFRqNnQzVzlmZG1Fb0cwY2FwR01KUkxYZ3hK?=
 =?utf-8?B?N2hqd2QxUDhzMlNrd3AvWVJpV2pPUGk1NU5rWEhaRGk5UHBRd29XQmdPUlRB?=
 =?utf-8?B?RFZwRlpxNVlMSHBjcXhVWlFDZEZSSTV6M2M3czd3OGlYK2kzaHQwbzhud3l2?=
 =?utf-8?B?RU1PYmFnNVJIVEY3MTFra3NNeEVJbGs4d2NwRDlRUzhKbzBHWXFNcEdFeFhI?=
 =?utf-8?B?OHJ5dFJJdGk4RXF3bEF4NC96N01DMTlRZzE0N2VYSXNDUVVmT3ptM1BZWXJG?=
 =?utf-8?B?bkg2R0wvZEVOU2ZQTS9lcCtTSVkyMWhJMXBTNHpCRDlEaS8zaTJzTEJhK1hN?=
 =?utf-8?B?MFU3RkpDU081VTFXVi8wNTZpL3V6TUJlSlc5SmFEMitpdU5xRjdSOXZHRmZ6?=
 =?utf-8?B?a1FuREtNUGdVTXlVR1FqOVQzd2I0Q0dPa0N4aER4SmFrYTBiK3F3NjVIN05S?=
 =?utf-8?B?dk1ZWCtBemFRT0wzaDFvcWRjdFV0Y2cxSUxSSGVrUllCcWlYcU5pbkNOdnpK?=
 =?utf-8?B?NlNBZ2xCSWg5dHQzbUdxekp3a3RZaUlGQ3EyeUZwKzExY0U3MnBETzBGTWxr?=
 =?utf-8?B?KzVNd082RG9ZMWNOUFVkbEpJL0JtOFhZZFhsTE9VbFBWZGljemFBakx0OHZk?=
 =?utf-8?B?cHc1TnJsYlJLUUJVWG9PNlIrZHBxaTQrZUZYb3REdm1vL2xNRWpySnJuUHl0?=
 =?utf-8?B?dnVmU1ZHUWNKY1JMVUxweGdCK3NjUmxvZHIzNmh6Y05UUGI4YU03ZWQ1R1Q1?=
 =?utf-8?B?eERMVUhxdkhTdnlmakZoNU1nU3pRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 82iz8jX49YU1bnHqt8/Ji694/CIIydwYl+jGv/NnTC7E0EH56Yd909e6emt4Rj/4RSQH7Kap9hQ4fTOe0VQhlLxOwOH269zHIVScyixxAuX6RwGD/4uhV+s03iyInxcoDMbXq1zhZ2EPnT1eNiJSMK2CnD7S84yIXlna4tj7ZvtE7COV5K/Y4YZ1Q3aO/4BTFrpXKNnir5VDS48hp6dwdrRHYzXuUwxpAK+FrtWNqJgzge+f/MFPXzcUwScfdK9z+bAkh8YWvT4xH7SsGkr35Zjv1ffsuwW02NgepRH15dX3xHmuRvjRrEqvYqWmlGulVzXrYHRRYI1IfO7lWpRZaO3cTLLTPDQZds1qAYHIyLyqBWeVQe82Mvy+/JU4cusN/hVNLn8pMo4gtDuCcNrkNXA1l9eiSVx16K7QlPrYTMmkc4A+y0Q4w8TMevH/blNp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:50:07.3767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75aa2b27-ba33-4b77-2581-08de6d730f0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716
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

