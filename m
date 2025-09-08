Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AD3CA1013
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 08:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B4210E48C;
	Mon,  8 Sep 2025 08:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OMo/pCFV";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9984A10E47C
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 08:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ue7b2e+s/vGEU1+lQ1/Yz87y9dF02sPyYyp1HjA4FJLSiowre/SbzBTSEPB/tGj0RTDpEXJHvmYyHzvE5FucZMWgffYU/Xo7DFBc8t3JEH7WmES3olaU+sBBD3o4HxyHtekM0zUxo8851+r3oF5EJMB1ezCBkxEuqdx1Rqza2es6n5N7Zau0E+5uSWj4PSeDs8DoAmrjOXgAP5f5PfxD7pDLvm/n1q4GkuzISAWHTsHxijiRdL7qnf+jkO2PY+PJfk+OHrkzDlm8xRKBaMyoqVESag31WfqGFYu7kE1l6/ol+BdD9t+kQ4TMXQtIIou80jb7Zt6hVGBgHl36TfxPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1fk7IvWDpjA4DYQ4bAb8CBPHtlxFvXxgh/8ppQqu/o=;
 b=D/EyYcGQ3hVvbJ+hffkU86dNlCNB4TXPGN0bvhK9nXYfPnAS+lmQdSyTlDA6ePKXwD0jIZcTJKYZwJMlE+3qKCmWy9SHb2XMriEhm/QvE3eIwfsEKrGTDvIo4LmGeAHtH6M8G7Ojy/K3oankBIfUVF45rkBuVHG7y677p1bTBBc/uveEW6LR0QDzaXxzit7tWBEKX4Qy4pG6oXMStEEls6WzJ7xMl/Lgzx/WAVlXmVtBIRKVZhhIWlywUKd98KDO04CEDY1Tn6R/aYoIEJGm/w2Z0eTaMja4Pm0LbAHxEwL/tFQ77uhUxdJ9PvlXbLl7BzYjpax+ofgpq1sLlGhfuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1fk7IvWDpjA4DYQ4bAb8CBPHtlxFvXxgh/8ppQqu/o=;
 b=OMo/pCFVVkRt6cp5GkA9LTknSAlZ1uR69KMB2qqdrYjMWIXCoPzsuU31a6ALzSviaO8aWF9XMTIopyXTlO7O/tYOmV83obbNZSGiI3wx0mQZRsitte5grWE7CWEd9MgIUtf0WMdbo7JruR/l6b3WWfMY9X3TDnAX5IZ/bXpbI04=
Received: from SJ0PR03CA0230.namprd03.prod.outlook.com (2603:10b6:a03:39f::25)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 08:49:13 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::c1) by SJ0PR03CA0230.outlook.office365.com
 (2603:10b6:a03:39f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 08:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 08:49:13 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 01:49:02 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v10 03/14] drm/amdgpu: add UAPI for user queue query status
Date: Mon, 8 Sep 2025 16:48:35 +0800
Message-ID: <20250908084846.1873894-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908084846.1873894-1-Prike.Liang@amd.com>
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: dac5e972-2def-4169-ebb0-08ddeeb495cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3Z5U0NCY2xTQ21SblNnT1pZUCt2ZDVDVkFuY1VHcEtTWkZMMXVJcmhGRXl6?=
 =?utf-8?B?OFJWTk00VXNpS3UrakI3bVdWRytObWpWTmk1VCtJR045VDQxUU1rdmhPK2JW?=
 =?utf-8?B?Zll2NS94VHUrZjRIS2JMZG9lMzNHWklZVWl3aTU2S3hUeExhUXR1dlpZcHZX?=
 =?utf-8?B?RXRmY1RXUkNyQ0o3UHUzcmtLLzkrVkY2UDFiVFBqQXp6RURuU0o4U0xwNWRZ?=
 =?utf-8?B?dkxGYWxjUmdvdGVDWmJXcWNBamM3aXBxNGRmblFveVlvNkpuK3dJTG5BVy9q?=
 =?utf-8?B?QXpoVkhIdVpPSTh1V2FJbCtxVFd5TzZ0ZkRyREN6SGVLYmYyQjdadVVoQ0J2?=
 =?utf-8?B?YWJ0RXRHdDRZTlJWWHdrbC9zcDlEaE1Rd2ZWdnpNMjNSK3cwaWI5cTFwUzNF?=
 =?utf-8?B?VzZHZkpENzg0TFlaSFRjYW42SzlsTmVneDVzdXU0SUdKb2hXRHlxbXJBN2pj?=
 =?utf-8?B?ZDJXWmxKcTdYUWVicnJhajVLczl2bVFGeDlEYlNBQktORlFWTWpDcUthNVlC?=
 =?utf-8?B?MUZiS3ZiTU1GZkJEWkdUSU9LSURmVjJkdnVxd3V1RThDdktsOXJmSENqTkVa?=
 =?utf-8?B?cmlwYVpKUktHQ211QmlTVFJEeVcxTERtWEFVNmhIWVp4b3VnbVFVTm1nVTRW?=
 =?utf-8?B?WU5ReHE2Q2I1NHVrQW9UcTJpMHlrcEJxTW5vZ1RENk96SGxCR1BQaTFzcnln?=
 =?utf-8?B?UXlOczh6bWV0aFZVNEt1RVMzWGJlM3dkOEQ3bUpMVm1aclgyb2QxVTI2b2cv?=
 =?utf-8?B?N0lVWmtLM2tWTEtRRnJZK1JQWnhSaXdxMGlIR1dzblN4MkhNazlkc28wZUJ1?=
 =?utf-8?B?SEt1YlhyN2RnQWhNalhmazVVTzAzczlPTUM3d1QrckdrZStRcXJZZDZvMk5u?=
 =?utf-8?B?aVJuUTBXd3ZXeG9Za2srczZKRGJwRlB5SWxnM01WSVRKTjBuZU10bENubjda?=
 =?utf-8?B?cE5qVzdlYmo3T21MV3NibE16Ylc4c0Y0OWc3OEJJQkFyTGFSdUlKdUJpTEli?=
 =?utf-8?B?aWwwcjhDQkcrSVB4dmNzNE5WSVZwMHJ0WG5zNEJSNFFDeUlsOGx3cjAxbm1K?=
 =?utf-8?B?bktRcEc5YjRRajBodnpsMitGYTE2cXRSbEdsSjFydHVNcUtVZjU5anpBcWRN?=
 =?utf-8?B?bXdXOGp2NU9CWjRjRU55Yy9nbi9odDVFVHg0OWtnYTdxamRLTUhQenFuSVh2?=
 =?utf-8?B?a1N4S2I1cnY4UHoxMFFJdHRYMUFLYm1UdlVsR0FFSW9Mb3QzaHlUYU9LUGcr?=
 =?utf-8?B?eG0xRW5ER1J4MU5IZGVianNrem9MOHZSNmpUY1BWczZhN2VlVHRnY21wSE0w?=
 =?utf-8?B?K0JGaXVkSkgwakRDRDNmMzBPNkU5Snc1UVRXbnZXNkVyY1I0aCtKVjl1SnJB?=
 =?utf-8?B?aU05WXVjWmtldklpMzJzUDBBRVNFaFd1cGJ3V21TcVFoWUozYklDOW1MUGFo?=
 =?utf-8?B?SEN1NTMvOFhWeTRMaVV4S002WWxFYkdVelYvaHNVa1F3dm5nc2YvWWZXVVFQ?=
 =?utf-8?B?dkFheVcvYVYrd3gxOEd4OGRGVVk1Nm9aakIzQ0pzYkp0dzRPQURHd3c3VFNm?=
 =?utf-8?B?cXd4aGpFTWh4ZFlwWTY1a3F4RHdLNU9xMEltQzNRdkVrNDl0RVY2VG5ZVHZt?=
 =?utf-8?B?OTYrSzcwak9mTmRzOTdoUXVrZ2N5dWJVK0N6QVVBajg1RnBtMnNteEptc2hD?=
 =?utf-8?B?a0tLcURLRFpRV3JqWnhNa0dYZFVINkFtMzNOZnVtSDNmRkllNERxYWh6OW1H?=
 =?utf-8?B?ekExMStUb2tveVdRNytWVXhEK3VCZUZZZnA4eXEvTGpxaVVveGlWSGxpKzNU?=
 =?utf-8?B?UHp4bWhoRjIyQmhESDB3OW5sZk9PdDZHRGRTS1lLUVBYcXM0bUJCT3I5YzR3?=
 =?utf-8?B?aFZaNEtuOG94TmtYYmEzM1BlejRkUmpTQUdZa0I4UG5FbjJEbk9Vd1pXcWQx?=
 =?utf-8?B?Y2NaR1d6UHdmdTVRWUZXWklyOFUwNFk4WUh4eDA2UWdjYmR1cGdsRWMvcWhW?=
 =?utf-8?B?ckpJdi9ldUJVdE5OSFk1Mm5GSUI4VE9TWVdlZnROQWJNM0x5QzcyRmRLY2Zp?=
 =?utf-8?Q?pX5Rzu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:49:13.0297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dac5e972-2def-4169-ebb0-08ddeeb495cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
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
---
 include/uapi/drm/amdgpu_drm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 66c4a03ac9f9..efd0d2356077 100644
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
2.34.1

