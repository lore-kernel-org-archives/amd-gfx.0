Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5F8CD1284
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 06:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A182710FA84;
	Tue,  2 Apr 2024 06:37:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3kAre4yX";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29E1610FA84
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 06:37:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlLe5CoixeOpZpw/iXDwkeX/XC9nShrtECeLXNjfavuRCa27e6raseWDZBzMPC90iSqVI4ccWCXzdqCGtL9uj7MFN+yqMe/oMbFp0G/ruXdJn3GcEFG1MTI96GpcrjISFnbHyqbSgtx3cmKIuse56MjqHrLF/67f/6nUu2sITGlXrlJcqJZGJvGHqkRmkyC1fV6TYjlrAaZ7FFfVd9hrQpYqBiQEShjuqDgWhUnjFlsNk5sXuRpPa+INfbkeIzVVL1tKtFlz17YbUzBV3MUMwFu8SA84roLfCkGrMibTnQqa4OI5dGL4tO+XL7OQIPhBRdpaO/NTMQHMscivyrIXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tv9MRdn2qCkUHEgKua6eJu6VNCGZ7cJ1VsNNdLgin6o=;
 b=ZcOqYdk3gHUCzouk+bj5IgJcnA7Eaxnz2pG22952sqyqBybHPVsbu9Sg14AignFib0/qVFsetKHNLNvZ4bBcRGxePfLhTsu78HY9K7Cksq2wB4RQUpy/1jiOV/pLCXiZyVzHoqWa8YrxdQIjBKctyuNur6tCSxRiyBQye4MA7lXXwqhLJhkqBnGw1R/IZfbYnc3077jaOdo7RrlS72kCccgaThalgAEjSTat2Z9OohcVm0ILDX4nnJ6H2JqlwJh5J9QUaUFO3tWy+hJ18Q5i8nqX3g4g4RvMBYJmP/iYEiAU1oXCTa3EKrRL31S5ehyRfFMEm8dZr9iz5MUHhHE4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv9MRdn2qCkUHEgKua6eJu6VNCGZ7cJ1VsNNdLgin6o=;
 b=3kAre4yXTp1Ky6sFr4p8HXqkRVe0v8r6/yGLU/C8I/IBq8mTUsfE3OtggIKSyjMItlifFD6xdkiVIhwFCNQmKt1wQHGCENuu6JK2otNJDtvMxapKfNYX2JFQ/SUXGdQXp8el+4rCgs2n9fit3FNYH+gVufHt+U3sOW2XfbxCwik=
Received: from DS7PR03CA0302.namprd03.prod.outlook.com (2603:10b6:8:2b::11) by
 IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 06:37:49 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::67) by DS7PR03CA0302.outlook.office365.com
 (2603:10b6:8:2b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 06:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 06:37:48 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Apr
 2024 01:37:46 -0500
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, ZhenGuo Yin
 <zhenguo.yin@amd.com>
Subject: [PATCH] drm/amdgpu: clear set_q_mode_offs when VM changed
Date: Tue, 2 Apr 2024 14:37:37 +0800
Message-ID: <20240402063737.2935698-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 492c2ad6-9124-44f4-90c5-08dc52df69f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5h/ycnZSVzaIX01dAugdMl3gmnIsjKtmSfpJAc/Q4UgClPqGr1L4pHIr8Kh1clSy48801IQ4jeemd733HBa0wftA3IF3uGZM4Of7JR/LLOs2k0POgRXQkrsmATb/WfeiOmLmBn+rjqgxYXtpnp/Ld+PcnrRpq11U3Mq9nKXjqrQNTyaN5HKiMxHMLtOUwyITtt4XzWqPv/7sX8v8DlRBZYmmx07hXVrfHVgqB4R+mh349mRZYQOl0RyCoHnZuvkWXhCkIfWLxZvRJPdEWKgwv7YSzgI3rvnjPqnPxuB458R3fmR7p7bzm3ZLk/VuNoNKq6Vg5nflK7+6/e3E0HfZ6dmVgxHZu4jzQHsDfIe+f1dXAhpiLiF8chFkfTTGbIC6dkZSZe0bBW2l+IG9mN3IVZ7ImYm0WuU2CTurkiBEqcsoan4rqt1tt3v0UPt1Ne07m495uOhPC1OhKJjGlT8cHLCUeVTUCUTilXgTE0cj9ZEBYZSUC9rAv0nTF7euOcJTZSMgpOfxmJ4oOXwf7pxZi7otI3+XuG/BH/OoyRpympRXREzwg4+UO4vKDouztx7yDYc2YedP9aOh7sNxyFLxRWe0sXyaXRv5vjdIb3X4damY6o10RtsI0S7L7D0mwE/7ls4DJIItZVc/qAckF9kW65OLfUov6eP5dTdgqiKoe3jnpgUgEPl9dNGI3y87PEtLp2dv0/KlUYq5FIXX2wKbKv2apUq1WxExWsoYP/OE891cyQajcRgV4DpWcOHfM2qM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 06:37:48.7650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 492c2ad6-9124-44f4-90c5-08dc52df69f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613
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

[Why]
set_q_mode_offs don't get cleared after GPU reset, nexting SET_Q_MODE
packet to init shadow memory will be skiped, hence there has a page fault.

[How]
VM flush is needed after GPU reset, clear set_q_mode_offs when
emitting VM flush.

Fixes: 8dad9c062355 ("drm/amdgpu: workaround to avoid SET_Q_MODE packets v2")
Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7a906318e451..c11c6299711e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5465,6 +5465,7 @@ static void gfx_v11_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	/* Make sure that we can't skip the SET_Q_MODE packets when the VM
 	 * changed in any way.
 	 */
+	ring->set_q_mode_offs = 0;
 	ring->set_q_mode_ptr = NULL;
 }
 
-- 
2.35.1

