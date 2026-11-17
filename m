Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3347606A323
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZW0gbhRB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 638CA10EA1A;
	Tue, 17 Nov 2026 07:24:50 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC9910EA1A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 07:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxxWyEf+E4bvSrhZjInJSqYyw3CB30F9QPkUCeL/t3OxfY9/atMAUA2i+zkkdVR7KOaVuJcY85KwL/z8YTjiU7hlwmwtb3OPjdZCW+oANEKezBdPGEUOGgRcN+4oDwJTXhKv0lawotz4qY5b91lkTiv3GYBj1kRDd62qroww+IB1wC97e1ZYVFI9D5JuY53GDOnNTclEMSbphkYOIfp1a+cGyn/oD8e9UsqWP/wCU4kZjdNznycXsVW2ZBMFBlg0wkbNIcxUgwUDbH7HAOJjwmNLb1sq1FyeqnN3xN6MsxE9JZkCAZD2GtxKUWFkk8y3fS+hmqXedVkkkao/W4mKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojsG61GDa/VzL5IAJJK8NlV7PJE6Z23LIMOYB0DnY7E=;
 b=d2onpH3vr6ZIoAbgLJtO4wkyVZLzFXxLzxqrGMsicSqxckCbDemD67MDgA4dLgp2hj58osFsbPJDJA2WfcDJ35RxB1pA5Rl4s4DSjZsp1izjHwp2mKJJ/aR7jHhMVPSbDHFJpYqjSWZYBwdQIzldCerLd1/J9NwyWYhxxvuAr8cVFsP/OKTgmBfdH4YIn1RbmmS1pGr0gfdFyP28hyMZe/tWoNPUVKwiGLTLeUx5KDpqe4DayGdKGJ8TfbWVAreVb1u0084vRLpV8JolWJwP8qUuNy+fJvl/lNerYsNpBBGI9Li7E8e+lB4Kipnh/cCXUtf7Mo5d+DUwzDPLpK4TIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojsG61GDa/VzL5IAJJK8NlV7PJE6Z23LIMOYB0DnY7E=;
 b=ZW0gbhRBm/u4Z4Hp/XkM1YPXfjQr/HTM+UuN6BTI+2QXWqAqNxIKZqdnauknRX21lVp7Nbl37xDesSr5JHUpJWMFryZiD6GRKt2SDlT9Fg6PltzoMCphEvMSaESy01SomPYxx9/JF7n/Vn1rcNDLxAF3pdpjuJeFrUX9VoKZU64=
Received: from CY5PR15CA0093.namprd15.prod.outlook.com (2603:10b6:930:7::21)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 07:24:10 +0000
Received: from PH2PEPF00048917.namprd05.prod.outlook.com
 (2603:10b6:930:7:cafe::44) by CY5PR15CA0093.outlook.office365.com
 (2603:10b6:930:7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Tue, 17
 Nov 2026 07:24:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH2PEPF00048917.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 07:24:10 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 01:24:06 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH RESEND 3/4] drm/amdgpu/userq: report invalid VA through the
 broken status flag
Date: Tue, 17 Nov 2026 15:23:52 +0800
Message-ID: <20261117072353.537506-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117072353.537506-1-Prike.Liang@amd.com>
References: <20261117072353.537506-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH2PEPF00048917:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 9564219b-2972-443b-ff9c-08df447bc628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|18002099003|22082099003|11063799006|10067099003|261026140227099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|56012099006|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: Myxe8HxzzMZAnJ1tMSl8NPdknc0kcVvPch5WJEr+nm5W06oQYvHSrXloV3MBZ5laHmfD/dLUzq1H3ILNarUWgW/mjVdNc/g49UppMZgcnmABIXUA3UKWge4DB7t2TU8DDFrwb1zdk/Ki9ZTBb8ZnWW5VoWol4Asg2Kbt0S2xZo1yiTYN0whtW1XsVIbDh39onnWpGnMPm06P56JJlml6fZI9Yu0zprdKPB2hidu/n0M9vmnyhCWRHGnDLUOWGk5PIMRNDIg+Nd4No+XjOQjsiAsFcLMvbps83/zfu7rkS84bxglrZ4BEmZjtLOWromkMXljX6OCZ8YZ65FnK5Ps0KrmkHY6I79VwFsrv3UyxASuimZzPDdFWWrznf51KUx7jIEV7NzcY/1U/4t/N5bh9ZAakE514v1rQV9yTJn3ziZUE0h0zCdhGqXmen5Jf4O/OnBpsxWYZ/XhLR+gZGsQH+t3K0nuedbvle5tfGts+mdJ+V8ZC+fEB5JcDG0FWxSeZLgmNYzoQ5MPpYhze8StCKMeSwA0gJio5B7aTQDPzCw0mfW4C/rHNAwofS+dCv29/pd3YqWoJP6gIupEXr/EN7eZVlSDdbFK/vIN+W5N3LGcyfUbx2CyC5UHKbOW+TRPI+jOuoG+TlyhW0wdfbF5wkoqLLyy3+xcX9Yh0WHeJFYMYZ5+qr1Nd5jIRKGRyz5rchnAUBdTtMJ7Mp5DDV/sQbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(10067099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o3S9Lh1sBB4YK7PJNwDHK1Z5Se43IFBvczbT7y1sK6pbaRce18SEDhkE6wUxlIRMgDMNMw5SMn4e211KA9LqC2KUbXmf6jeAPXfNWk6dFgSWD4iU9GPcyuOM/y1Cx2yu/smNJ9E2/RuMWWYYgCKYUb5RycerClH1vpcGNLKg+2fwFLH4zRP9oHK8voY+qlu6oIdOZ8GHRuerVqTPSRdWrbbr9dX9INm5EI7eyNEejzwhDLoUOx8eqyM215AFdLl8D1xzEBulqkjCV/MEIG+ouzRrFTa1zfifhtTTDqXzvb6Yk3zJW0nFwSX06Wcfu6d/PouQeFGKLDQhqXzBsKuwy3WfuP13M4aEI7vDtlZLrmB2daUwizd4gOo4mLBLPPgh+ncSngIBYNClMMZb0vutmY81BWgw00QLyIu1FzZ2UdobMqw0bD5lNxx98GX0xcb/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:24:10.5489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9564219b-2972-443b-ff9c-08df447bc628
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH2PEPF00048917.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708
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

Report a queue with an invalid virtual address as BROKEN, alongside hung
queues and queues whose VRAM has been lost. Use the existing BROKEN flag
instead of exposing a separate INVALID_VA status flag.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 +
 include/uapi/drm/amdgpu_drm.h             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 496137fca1f0..b48cf2a2118c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -837,6 +837,7 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	args->out_qs.flags = 0;
 	if (queue->state == AMDGPU_USERQ_STATE_HUNG ||
+	    queue->state == AMDGPU_USERQ_STATE_INVALID_VA ||
 	    queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN;
 	amdgpu_userq_put(queue);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index a1da2833610f..6c0992d06fcf 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -353,7 +353,7 @@ union drm_amdgpu_ctx {
 /* for queues that need access to protected content */
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
 
-/* the queue is broken because it is hung or VRAM was lost */
+/* the queue is broken because it is hung, has an invalid VA, or VRAM was lost */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN  (1 << 0)
 
 /*
-- 
2.34.1

