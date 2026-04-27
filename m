Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A77FF8860
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 16:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E131010E801;
	Mon, 27 Apr 2026 16:00:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dIsvjmmW";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D1AF10E7FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 16:00:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKDS3RKNfHC9oaptQgiqc8PStqNhL+cE0HUiXAjXffnOYY4Hjzt9/xZ6L/lIlsyDzMUIKbnMU5NfTPjpOj27lCMEI9KWnWRpb2HDsVxdG4KRezAeEflNbFrbuLueSV80lWMXky2naTi1pha1o2anQHQ2E28qJEaLr9M8cmB0Zm0vsZcTuLcMOHQ1B7Wkww7vPKiCDgGn2xbQ/YwgLYtCvXhJateXX3cneIpCnmrJzC5CtzmWeR8dCqhRvLokcrbKjq7kdbo+5JQz+lUgIZVHaXnUjg/ZMyNkEZvl46/pUfpcsfAk3cF989womxFQQPDAifDWby8vKq9gl2EHKBFY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ydrwT8SqnIIK5N/OmgxUHz9cIDpM5lo6xna5XljEs0=;
 b=c+1FqkJTzUkIN9m0F7TRR3eIw/oGzseZXUCwFXCCLc6B+Cu53obsOcfutUHx79aaWwvCVVtZWSbcsntIKEyFHBzzlCWqg5lervLof0b1LCK9hD03Xm7WRyNK/z1shSZLKcZsMNUzdCOisb0RgCRYTSfs8nj1gs0zWUMFpdPyVfpsx254kB9t6hgpOwFnNF9q0fBrbAtL/vVwhiBjQ9N5tAVy41Dljj1QlHP7Tl4uu+Ppvo8XmHM2UkmsBmQVgZmTkn5DzDQtasBPh3E6wiY3qmDbSK8jNKZnrqPKnz56PzMSxz+4FSLRKRuqh3gWT+K5vWSdA0+eA/0YY6hKatJXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ydrwT8SqnIIK5N/OmgxUHz9cIDpM5lo6xna5XljEs0=;
 b=dIsvjmmWHrgoYPsMoo+0PLxKro4IyTDmE5iz6YkBNkDE0NYqlkvKHVnFyiruH3SGsIWmLybY2fz8QhsvgIVvnm5TjefPWYcTh6B/5QGxmyOP7hukYBZ0HpcNvKEbJCDNftitL7Q3/JdDDN4fvN9LLe0cd6jLJy7fnIDZlPQA/vo=
Received: from BN9PR03CA0757.namprd03.prod.outlook.com (2603:10b6:408:13a::12)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Mon, 27 Apr
 2026 16:00:03 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::50) by BN9PR03CA0757.outlook.office365.com
 (2603:10b6:408:13a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 16:00:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 16:00:03 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:59:56 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 14/19] drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0.3
 ring
Date: Mon, 27 Apr 2026 11:58:52 -0400
Message-ID: <20260427155857.1370151-14-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155857.1370151-1-yinjie.yao@amd.com>
References: <CADnq5_MPJG=S+B4kg6v64xD+8pDEbG5z1Q7j-2A+CfStmuejTg@mail.gmail.com>
 <20260427155857.1370151-1-yinjie.yao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: e28ba79c-0240-451b-4431-08dea4760b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Ah/3Bjvo2g8pNoGds+An13l705WZV1waF1RhOY2gMKCrXFKtprPubBgzo+RHZbCPZwMO6/arl+yh4pzvjU9V9pOJtzPH487FdeUPw8re2BajOsREtAnA5qrDUuMilfO8UFG6WacjcIWqnlun14KFA9OPRbqgSzABszW9YMk5k2bCdMdFPL/euRA0iXzte1iMW0LFIGdgA60OYtY8/3gPYff0bINl3SwDciHg2INa3RHm8B3Z2m2NIm+JibWN5OFweYVB3xKe29t6pqNv0Nok6ZORjiDwsJEQhCSHang2XzFQWYAhAdX7WRAhRlIC+AUSolL8BHKgKJYkngn0dEnrUh8z3mbmMBa8Tz4Vdwz0G5t79ovKEi2ubKm+HIgDH2wVTuCeOX0rihwTVD70jLY4IRIxrPg5bsTm1TaTG1fNa5rMhpPr+tx38HZ9e1NNhtBJMdlXSexyjFsp1jO3zGuNIn0TD0DhGQiiUkt4P04pp5goKjeYivAySAuyrXfEyqaSk0pyqvnoWdvURfGkQ2H5EcRvUFR9/OyvQDci0Wp8NSotQTl9Yo0wCevzU/Am2SUykfC3GA/S0+9rLjFsPP2VRMfvk79gCWDnqSOZ1rAP82tXewGBFS5U1ooSBimf8IIuPZlZetmOa8uXfLVmAVx9STWKslHgMY6r7sV8dLBO60Wx/3yh7NOAFhoKAJ1zJKeMEggrhV3/IQ8dtfKC3w1Xoo8C2L8GjMcxlANFqxQs2l7EvlgaOzkIf1L4imum8UjLDzK62nRhe6bVnhHrJ/kpuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sM9i6QeW8rH3NE5TTWlnB+26tNUEr2QhOTQmXDLveTTPP1r1MB0i8rrttJ9zMQjlJwV8mVA8ydu4Jiu7a+9pdecV1O5pTdaLuuou908uihpeJeo5PDEyXymEgVbmflMmiJ3vB57C6z5sVvvpcKiXluAwnOP3onASujqN7b0/2XhgYBrS2hhD42sL0QtwmALJVo2EgPYI4tqJRIJW/9GiNGBv10zGi0pXxcwXR1qqeMbbxRAXsDJgcA17Xecuh2CFrH4zd4qXGAdVEGJxf3kn5HZsgUORwD1Uw0OTIUJzIF/uUsic/7xk7AS1p/FqXowWuR6ew3Z9r3hRQTTsxsTYlnm1wEaymx4U6x2mkAfGgWFCVShcK/21/2HZcQGsNuasRMUo9Lf70aD29JDCJHnfFIDigieeXd41fKmRXq9rkjF0p803nA0RhCg0rguaMCdD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:00:03.1494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e28ba79c-0240-451b-4431-08dea4760b11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696
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

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: e684e654eba9 ("drm/amdgpu/jpeg: add jpeg support for VCN4_0_3")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 82abe181c730..0c746580de11 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1219,6 +1219,7 @@ static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v4_0_3_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_3_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_3_dec_ring_set_wptr,
-- 
2.43.0

