Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4178FC74A5B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 17:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7991E10E3DD;
	Fri, 17 Mar 2023 17:18:12 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C78510E116
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 17:18:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W32AEeUKP9x++avxU18OgYnDXOwSDr0+erQCIhnhBQxDaF1ooTJaRcII3s2Zcz8mEjN73MN/GGJWGC8yPN5dGjKjRsct0oN+UU2d/WdSiFjrBt6KrnYBTlnryftFf1eeJ2741Wig76ObRAutxCBkxVr0yiOrBmlj0IaFnReGMdxYKj5hG1BxT/0KmYsjlO/PxxnZIIBz2yEDuCtgCDAkJsjuWJVepSouiDK7njXp/4YKPtFrumKTaEm46L95eiyAEuVJ0GpC5pznN1nUlsRWqily52VuJ1Zt1TN9inzxXIuC0NWrqznrj9beASJmtUmcAmBAfF76SIt1qBXnEBz7Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h46I9ui8q7MOwY+jpa3aSXw8FTsnmhn6Zv2NH0EaUNk=;
 b=AVZhGpR1dJJjqdiahF8+EEAOV0oSWSq+tMYbJBG0YufUrU62xPwgWIl5mhWEYU817/pATBJ6uV+YFNUd325Baon4TLKjUXo+oSq+ixB3d9kl4yb8vurT0dE0KbjajMnm1zE8ncfXiQtOg91tLeP03tXFID7hp8r1WKzVeUTuxD0HabkE40WW3E0DCpwwXbb7ldQgPeZl/cwSxwA/BxGlL49ToQcFwLj9QsqpurHfDpYV3AQ2HzbPOMpfCtE95IaJ9+h5B1+HhT2sxk0MEjjTyYZxz0qupvzclr7CJK6R69qDS1WhnbPnre5OqE1Qouk1/ms5lnevsz9DMUYVCZaGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h46I9ui8q7MOwY+jpa3aSXw8FTsnmhn6Zv2NH0EaUNk=;
 b=tlNLu/R0uE04NX5oF6hmue2m+K9w+mgnD/UmLJfhy5NHTgQDIBZL3+55TBv1/+XMIVNPbRry8WsFHYJxl0vozu/uNJFUYjrcXcrGIHNqfXbF91ru4UKimSKAIba6lrmCUnel/slw5I/tdMlXB3vMa0Hi9IgsoibKZFg565wPd8w=
Received: from DM6PR06CA0050.namprd06.prod.outlook.com (2603:10b6:5:54::27) by
 DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.26; Fri, 17 Mar 2023 17:18:05 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::e8) by DM6PR06CA0050.outlook.office365.com
 (2603:10b6:5:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Fri, 17 Mar 2023 17:18:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.20 via Frontend Transport; Fri, 17 Mar 2023 17:18:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 12:18:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/10] drm/amdgpu/UAPI: add new CS chunk for GFX shadow buffers
Date: Fri, 17 Mar 2023 13:17:40 -0400
Message-ID: <20230317171748.682691-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317171748.682691-1-alexander.deucher@amd.com>
References: <20230317171748.682691-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: d96142c5-f9a2-4f8f-7636-08db270b9212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UnCgB2t+zzxE0EwaXhraH8FVwanSifHfJuPQ8yuyvsBJJWZY8d49t7oKw77CLGIAml5yzgx039E4gG1ocSkd7vZw+ggBDyBeqZI/n58dqppVJQ9PY62H+fkOqDy0pegy1lg+Khov8YKX49bbZLPZ0RZhNs/+Ubq8zZypQ2Tw9nKiBbBeiPCbsEg4joJQRLTJuxc9bNZcDZWndjz86Y5WRiLkjGZYjAWLYLxrGHp2Hf+xsaOUkVAgvjZ6yPArSSOOvRVbvKrkn9sxzh4DJTSGvpJP0HgMKwsV389FJszlktbDrRNOfMi6T7cJF6L/BcQ2NUaI1FFOnynSsgbfOJG5w6SOQ4Ni6vQJp6sHjw4hoonG4xnCHXpRjW3Xietm+TyudnfIolmlZ0v0AcmNa8WFubZM+fH61vjTezZ9rywRLdP1vThubSZGzARKTY4ECu7GQ9CTjjh4v1uh7PfQit0xPSUkc7Cc4m7f8oFv0doFecX6aderzL3upJ0vnqOTCE/FIkNsWeNxJJ8Nhxhyg+ciHyt3FLtqZP38Ck4p4BY8gaYJJd15bPVIUG1yZNClfZsbHbNzpU/MIuteM2ETdsPI7F9Y/lSdsY2hzvjz3nbKD4IQZ+OBIyukKJX0cw/ueyQtmVSynSOE2t09E3YWes9LTTXjkuk0kHYm44v9Qozu4od2afsWlNVN7HLEP3tHvvu4OuEvtygZO9R1jjeKgFQdA3xFHf+NzKbwdM5gIuvmzKo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199018)(36840700001)(46966006)(40470700004)(2906002)(8936002)(36756003)(26005)(1076003)(7696005)(6666004)(40480700001)(40460700003)(5660300002)(2616005)(316002)(47076005)(16526019)(186003)(426003)(86362001)(41300700001)(336012)(82310400005)(356005)(6916009)(36860700001)(70206006)(81166007)(82740400003)(8676002)(4326008)(478600001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 17:18:05.1082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d96142c5-f9a2-4f8f-7636-08db270b9212
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For GFX11, the UMD needs to allocate some shadow buffers
to be used for preemption.  The UMD allocates the buffers
and passes the GPU virtual address to the kernel since the
kernel will program the packet that specified these
addresses as part of its IB submission frame.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index cb22bb78c373..be43d5f96534 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES	0x07
 #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
 #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
+#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
 
 struct drm_amdgpu_cs_chunk {
 	__u32		chunk_id;
@@ -708,6 +709,12 @@ struct drm_amdgpu_cs_chunk_data {
 	};
 };
 
+struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
+       __u64 shadow_va;
+       __u64 csa_va;
+       __u64 gds_va;
+};
+
 /*
  *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
  *
-- 
2.39.2

