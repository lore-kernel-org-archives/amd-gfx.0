Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8C6CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 08:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC2C410EA9E;
	Fri, 22 Aug 2025 08:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4gESMkJi";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66CD210EA9E
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 08:55:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rg9j21KKSMCOoAuBtYYRu2+p7+aR4o9nDUxRFRImj7RHmfSPgY+SzM3QGy+7z4NQKK1FRdMbA1ay4L66RTxoajdq/NpciBfC6eI7Ey1P+x2mo4jna2zO9vf+b/nzcf4AaN9CLKdxqVzQmM2h7ZaGRRLDihYQhnveSFO6eWS5Bqhp62JAZv9zsPItqmSthiDjmdeGufXK26xCCEq/3z55Gi/zCb7e/DXjJZv96R5Xblr6rXgZi5DZoYHEBTgCIWXloZt9GlWT3/fqoLxQwU26Ub6Y0lKGVjzJQyvt05ScxpL5NAuFaFUAgkwkiw2BVMnIEMfWjVYl9mc1+Uqj2nQVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/V5/pMeu1Uv5JmKufrRU7/BhvtRuLEfxzjo8UUtxMs=;
 b=ixw0bhedeF960/fKQNzW5Ag5ppVKoB54IwybyDDzMM0Y8FY15QBLWAe32BKHPq0yYERQ6b6TBLdLy+6iUJCBTRO42c9yOKBbucVEaJBXm7NZCAxqtNBHhf7cp6TxPpMrIgo5z6uVs/CL7KUsJ5zLZNVwxkFDSgyABcWbsOUAQB0ipfl4rdMiWmZCJQj4bPYDPKEOHv34LQ3ACDvaWt8jZEq7K1s5fCB2EFsaqBZfemWZrYIYpQNBvhGiWYoabFJIq3+eXFj2+h4rUnmgYcYFjZ/mPGIjhQjoRb9+rPcV7I7KH7Zv+mtgDvyXzRgI5w8QeLFVVy562WZTcfZZzM+LEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/V5/pMeu1Uv5JmKufrRU7/BhvtRuLEfxzjo8UUtxMs=;
 b=4gESMkJiBnGF6V9hr03GeE9Bjr64KqRn1Fj6rM37bE3t728tlv5VquqK74BlNJYWN3tAeW6fmAj1B5x25W8b3S0yu6vTvOFkBA6C1t73iazf22XfFwKhLeiANgh/EinlxQc/XWdVlrSHIB7jPOnkdi5ZFmp3Pd5ycCPYstZHDCA=
Received: from MW3PR05CA0016.namprd05.prod.outlook.com (2603:10b6:303:2b::21)
 by DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 08:55:23 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:303:2b:cafe::f1) by MW3PR05CA0016.outlook.office365.com
 (2603:10b6:303:2b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.9 via Frontend Transport; Fri,
 22 Aug 2025 08:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 08:55:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 03:55:22 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 03:55:15 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [v10 07/11] drm/amdgpu: add user queue reset source
Date: Fri, 22 Aug 2025 16:51:10 +0800
Message-ID: <20250822085434.970798-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250822085434.970798-1-Jesse.Zhang@amd.com>
References: <20250822085434.970798-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5e6efc-aa08-4dc2-e9d2-08dde159a11d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjF3bTVZZUZXR3NQdlFUSFhkNDV0ZlNaSFprL28wcjN4R1FWOG1aTmRTbEJP?=
 =?utf-8?B?WVdEQ2RzWnBPeThnelBwQ2V6bTJRdzlrbkgvQUdJV1BQSktPVllFNGFvbGc5?=
 =?utf-8?B?Rkp6VUJuNjVvbytQS0RUY0xMazZuTjZXUk12a1QvRERoTm9IdmMycmZpUG5n?=
 =?utf-8?B?azVMS2xxeUtINkpqdkhXODRScUhueGJMcVhWdWY4NndxQ1ZwSW5KQ2ZoQ21k?=
 =?utf-8?B?WWsvL2FkSm5iVHJsQ3JzRlpqQ1FoZTFwSzFIYTdvcjZwNkJMSjFXMmljZ25o?=
 =?utf-8?B?ZWJHUnA0T2JJbzB4bXYyNkVWenlVR2pVQTAyOFYvb1I3SzRsN0diVGlYZW41?=
 =?utf-8?B?WDRrY3dLK1pITGdMTGEwdDFBZktKNFl6TUdzd0NWaE9vZzIxM0x6VDNCZUNL?=
 =?utf-8?B?UDJwekFWMUtYQVY4MmExMTZOa28wS2IyaWREenRzSzNtL3gzcGZTSG5EalVp?=
 =?utf-8?B?eU1vcTZER1hiWlBCWHE3UWI1RXo4MkRXcC81OExlY0pzUlhRN0Y3b2J3SUZl?=
 =?utf-8?B?RjVaU3h3ZWx3SXBESitVRXZsa0N2bXFRaHFnaExQYkVTSlZQbm9pbXc0SWdJ?=
 =?utf-8?B?TnAvejlQaWMzbG8zTTg2bUNMeHQ5Yjh2dm5TS3l0ZkYxRllNSUxQKzhxL3FV?=
 =?utf-8?B?enhuTW0zVzZ4ZER1UW81bkxvR3Q5ZlZaYko1OE4xR0JxK3hhTEdKb21JVEhL?=
 =?utf-8?B?NzVwWnVXRytWaEN4cStIVVNyK0xFNmx1YUZYSU14blR5WXpmOXA4ckUvZHZs?=
 =?utf-8?B?SUFKN1FnSkJHWjdNaTdnOTF1OXdIZVVKSEFNZExWSzE5RVRtS0JwY0Z0RWIy?=
 =?utf-8?B?RDFmdWdRNmdabU5DU3dJamZTMld0MFZIV1JjcFErL0lscXBsSjA4S1gwMG5J?=
 =?utf-8?B?bFE3MXNNT3dHMzBuVlVIM2hobkQ4cUUvYVJTVElMS0RzdGlBZFcyc0VqN3dO?=
 =?utf-8?B?WXE4RU1nTW8xa0VSamx6aHp1VENUb0pxMXVlNG41UjhRam5Jb0tjY1F4YXVI?=
 =?utf-8?B?ZThHY2RSTi8vQlliZjU3amlZZ0xFbVgrZWs0bUo0Yy9pWWJaTm9hNlVtMURE?=
 =?utf-8?B?YUFYM0tjNWowR3puNUlSTDVoYjg1MHRQajFuemdMY1NNbVZ4d3VTWmtvemVq?=
 =?utf-8?B?TmY4RUc2OStXTCtLcU9UM1VNYlpPS3lWcGN5TlJraStMYW5xSUpNYVB6UklF?=
 =?utf-8?B?L0tjNElQbHVwUkQ0eW9CK2U3SU5DaEgvaElTRFhuNFJvMCtTUzZTVUhFU2NH?=
 =?utf-8?B?d0p6RVlqRWR4S3RJSS93NWsrRmM3aUlIQWhoWTJLWUpSRVFSNG9SVU1tYlcr?=
 =?utf-8?B?VnJpN29vVDVWOHBMWmQ1MEYyczZjaVRJRnBVUUgxRndWdXBONDVobldzcjFX?=
 =?utf-8?B?V2lnekJhY21DVzNYUm8vRkMwcVcvRms5VGNkR3RkNGRBc3JJeTZLYzM5aE1I?=
 =?utf-8?B?WDNSSm5lam96eHI3MitMVVk5b0d4akovY0JXMHJEbFY5ZXB3WnZsbUVmN1ZX?=
 =?utf-8?B?VFdic1dNYmVURnFoNC9vNzQyaTRwakdyUlA3OVhDZ083VFZtU1A0SWRwZjN5?=
 =?utf-8?B?L2dWMTY3SkJWQTVEQ1VuUjY1RXdIdGJCRy8zU0t1RCtqcjloN0U2bUZrakgx?=
 =?utf-8?B?UjBRMU16bEVvQ2lUTkltZTFDL2prTEoxYi9JUDdyM29XNDhSZFprWDUvZHdq?=
 =?utf-8?B?akpoMlRMaUJtN3lrWmtuQzM0T3JLWFR0ZkpVeTlYSVUwLytxakRjNG5PNGts?=
 =?utf-8?B?bXVrclpmMjVOR3YrMkdSSmUvV3VIWTBIZWQzWDFnYWZ1MTMyKzFYODMyeFQ3?=
 =?utf-8?B?djVWcEU3ZU1TeW10OWJDZE1Bd0ZsWEpYTnhTeGVmM0x6TGRRdG5CbWc2SmxE?=
 =?utf-8?B?YzJQcTJRTTFWVFBCWStESmY1MUpQdHUxRE1GdnhEaXBIZkMzbFVYNzVPRjc0?=
 =?utf-8?B?eCtVOWZBTm9QUkRiQjNPdHpVQ04rMUxYSDYrWllSTFZXZCtYVVdOWTJCVnN0?=
 =?utf-8?B?RGNyaW9SM2E3RTlFMVZMa0kxWWtGZUErczBLMXJMNkFIcERDOFpUV0RwOUEw?=
 =?utf-8?Q?mgvq56?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 08:55:22.6635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5e6efc-aa08-4dc2-e9d2-08dde159a11d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018
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

Track resets from user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index dabfbdf6f1ce..28c4ad62f50e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -340,6 +340,9 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 	case AMDGPU_RESET_SRC_USER:
 		strscpy(buf, "user trigger", len);
 		break;
+	case AMDGPU_RESET_SRC_USERQ:
+		strscpy(buf, "user queue trigger", len);
+		break;
 	default:
 		strscpy(buf, "unknown", len);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4d9b9701139b..ebcea44dd743 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,7 @@ enum AMDGPU_RESET_SRCS {
 	AMDGPU_RESET_SRC_MES,
 	AMDGPU_RESET_SRC_HWS,
 	AMDGPU_RESET_SRC_USER,
+	AMDGPU_RESET_SRC_USERQ,
 };
 
 struct amdgpu_reset_context {
-- 
2.49.0

