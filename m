Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B4B606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DXfjWh6O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049E010F8CC;
	Tue, 17 Nov 2026 19:24:56 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 469D910F8CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 19:24:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXbBEUFLcwghZZXDufbeXMzbHjAj9Uj3hAPswCubqhgYidbkh+X6z37xEq7O6+HdeFIFJVHqq/7QCDD4vG2fRHM2SWaKathJAdChRj7ASYwTr2HcN8mR4Jcrno/Aoq8wm95HOzRjrtUTnys7Ooj0BQpxadR4zXx3DUEc+dDxlsAGhFuxmj+++OkRo/9PRcZLvVosD/tNbzuqj2gpHygPmicAsrZxI8I8CQKbT8Z2elE5G2jiFMyP5R1p4cTda6d9dbWJrmlHZKZwP5mURpnf2rqwQds7xzch4zPVEOK2LL9bfwhDoR87JzIUYGDIzYQqZf2Yx845m+f6e1o/+/XX3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1D/OQbZVQCGt4gPZ9QqGuaYqJpCfo6fZlk0fP4Ch844=;
 b=hVikkoqh4IkDwLGxYomX07l3yj7S/O859moj7OGbO5qz/9QqNAAnyvsjy5WhQ0V50UBDVUPySLF1Jz9pRgz8HQWC/sLg3KYjAlnHB0BdhVtP6g8DcbDRTCQvESkKHEg8m0r+obALGsEwfEcsRMryeYZBuGEWoFlzJfue7DAX16L/6kOZubhmpjmhtM7HcTqisT9O4hVhjxZJy6Bhx/V78kFEk/S5zH3iqofYhZ3a1+7Qt6RHcdqc46SdCKB+m2WL88KQOSKv312lmqxG4uwhD+7dHMloIwLTrQ/5dY+YHJbj5jSAvs1Ca/VPOaGAMe8hSuiTzRpSASWHJiCYvgaEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1D/OQbZVQCGt4gPZ9QqGuaYqJpCfo6fZlk0fP4Ch844=;
 b=DXfjWh6OutdRt+YUO/QvBPMocc9fFZiBhVx25E1p0+w/8V8JVP7bSDvbBJsuI2wkEPb1DMgePXmbKUvmL+mwiNTcANoJkBWuxuyX97WfLCkWZ3xjNxHHo+JHLlYGTS37gAP3OX7CJVZioZrpYM3yFEdNG5SbInYvI/ZmLVjNEFA=
Received: from MN0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::24)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:24:33 +0000
Received: from BN7PEPF00000094.namprd03.prod.outlook.com
 (2603:10b6:208:52e:cafe::2a) by MN0P220CA0030.outlook.office365.com
 (2603:10b6:208:52e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:24:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000094.mail.protection.outlook.com (10.167.245.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:24:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 13:24:30 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 13:24:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 8/9] drm/amdgpu: add UAPI to create user queue gangs
Date: Tue, 17 Nov 2026 14:24:14 -0500
Message-ID: <20261117192415.810117-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117192415.810117-1-alexander.deucher@amd.com>
References: <20261117192415.810117-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000094:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: a61f7474-0457-419e-42d0-08df44e068e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|261009223027099003|3023799007|11063799006|56012099006|261102123227099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info: 95Si8PLa0CUrcWsHCmG2jmFZaj7dhhQKaPcGSlLfxzz6za+IqbezMmlDTEWyD4CSjwTDGR/433MzVOMoBi8xuxgzxX7OZmH9smN4DX2bZ+Pnxng5QxSN16o9dK/vK/lpVw9I4eqGO4jAvf5mqikBNap4pvC9NNpf73ZBnOgB+FTEQ4hvx7d1yqkUmy+mzmXGTr5Hf97EK+d/ClGqhGgzK+7Je+xhuD55tAVYOIObVph9mVR2JZ+ON7khaFXRn/zMbc5TycHJeu9BS7RLy1jVgVMHsIeEjgs+kMxvKSv09sNOmFWTLlI88brkvXZrWJCnoePynLaMIWmUHa4i7od7CNIz4suRsDj1jJvblK2IqI7Mnu79X4ZGCeED3dM/R6nKof8RajwprZGPKsv3W1T73/8a2jrQN/tWP6LFP49HGQnBoBV01MEtlLiYgVG1leidLrGCa47y8gT0gZXZkmrKAm5jI6YInL/MzdMRcDIfIGq591OrOJePff5kmbatGsNccaJsNbZaVavIJKuC/x+7Iqi4n7NWchzLL4MZv8KKq0lTd03diz3FvNWH1dSTnrGnyVD9zQo/hdeOzggnMU7ffZCkhvugvH9ttJNlzyh70tDf3jSvZ/PajkjJ5CqpLLc/WoI0ujWEMJJWZiEe6RukWBXK+326QWhMmxBhpp48ZMettRchObJRQZENYl/9r63p7ggAgtPa73y7RNmFtWy6EQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(261102123227099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sokNDKjDW5dOk52XedD1CdUxbmVRgeBtA5H+YBVgQ6RPLbuQvQ3/6arh5hCdMHG+lVsalcsCH8BdXmYjGoe/nsOQ5GdLQ26R712gZ99OcLPqbIFWfP8+z0VnRsQ1oj4/+HykY2UrqDiMW0TN29P5oygdpftR+ITf2HbQL7m00hmjuPo4dc+YQaO0vtqsiv8o5apDm5xWlK9s95j0/bqJNoDgdDbtsrQZK3OIiVCQMjNJWoNa9e0Ty3kqf1hwj+q76pvIb08e1Kf/+kiQyjWSPs6GSFxlpYjdRFjFj+G5s7Fad4WhiBx1faajb9QzrIpqghBvoXpZoH9whEWxKN7aieKit4p7tXL1An7bQnIJbGM1NbF6aey7DezNNM+XRyU/L1p8NBSeqpxlUV6VUfMtpIMovYbtxiJg7b9O7byNSSq7prlxekGziYYfMZkgAAq8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:24:33.2630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a61f7474-0457-419e-42d0-08df44e068e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Queues in a gang will schedule together.

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 86d42a5d683c0..bfb982f1d1757 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -340,6 +340,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_CREATE_GANG	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -422,6 +423,15 @@ struct drm_amdgpu_userq_in {
 	__u64 mqd_size;
 };
 
+struct drm_amdgpu_userq_in_create_gang {
+	/** AMDGPU_USERQ_OP_* */
+	__u32	op;
+	__u32	pad;
+	/** Queue ids passed for operation USERQ_OP_CREATE_GANG */
+	__u32	primary_queue_id;
+	__u32	secondary_queue_id;
+};
+
 /* The structure to carry output of userqueue ops */
 struct drm_amdgpu_userq_out {
 	/**
@@ -435,6 +445,7 @@ struct drm_amdgpu_userq_out {
 
 union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_in in;
+	struct drm_amdgpu_userq_in_create_gang in_cg;
 	struct drm_amdgpu_userq_out out;
 };
 
-- 
2.56.1

