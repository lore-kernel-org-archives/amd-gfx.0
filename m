Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826EFC5DF81
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD0D10E867;
	Mon, 24 Aug 2026 22:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U1XF8fUy";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F7510E86F
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nD223tLCIA1mYTG5BSLW/24B5215+ybxuqY0Ko5boWaBVAtLEty/ZzqsWVjwCPsOjOpnomaxIXdljFtwpC/7yKc6iVv3THwNE2bNFhfgeq9uDDQw+y13CDFc2hG3KniV+k4c5kk0rhqne29vo73NdSZqaNu+fbLlpinzW50vE9mGvuF0cZSArzMve1PNm9MkpyTAQadhMiKRHIuhGm1DOTpTdosdNdNN0cHQ3flP5rrq4E5iXXJA+OgLkYiXYpjoMauN4dlDsY7LIV0PfAfy1T9cR+AEg0eECsa8PFlPY4XohyueDdSp3V9dQtN4vCDzUEP2CvKPmE8e1cvCaKYn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3io5ULk7CTslPpzZsn1U4nW9/c8SlJ39WvO2KGUoRPs=;
 b=slZlMc/aajVATRV9WicdWNYER+wp17I9RJ8dus4QWS0ecMlQVASLhYtS8CcwJz2zg6N87IUMK5OYerttb4gTD3xqpBqZOEJsCOMEPj3nWKDZpSZIdSVCYtyoVDG35uBNtTRR2o9wO1p5ydI0ZxcQ/zWQkx7iXvKAyFdIlaAV+OZ6X7/oDsYcx9bScHTPnlcplWJI2G436gKCx52OBsNh+02RD1lX/8LH8DLz/orweNN7m/Okv3PzNiZHaeYz0m7NBgNWhhYkPCFS6aaEOF3fDOFwAs1nOg3FWJPzDbECn9traCoaeBpH6c8vLFrcTgELotGyI5ZXuqo/shlLuru0FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3io5ULk7CTslPpzZsn1U4nW9/c8SlJ39WvO2KGUoRPs=;
 b=U1XF8fUyTha3HW/2elAikT3klq3xJrgEMGh82KLbmOYYg/eDV0bas08Ncf8tWxnmoSniBfGWMXmgZ2ND15s7CMCrz8TpiNRW1xA/RYPgIyeEwIDiGykqmamB5Ool9iC3OXer/ABa7y2MENkxWPMNNO3OirGVRXd6IKSKHh+W8w4=
Received: from DS7P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::8) by
 PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Mon, 24 Aug
 2026 22:14:26 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:8:223:cafe::84) by DS7P220CA0016.outlook.office365.com
 (2603:10b6:8:223::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:25 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:19 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/30] drm/amdgpu/gmc11: use SDMA for pasid TLB invalidation
Date: Mon, 24 Aug 2026 18:13:49 -0400
Message-ID: <20260824221352.1793542-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH8PR12MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 04fcb2c9-6a55-4f32-f947-08df022d0eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8cswFY4fMlnhIEV48wpGdYqi6xJ7kIJCeqEKMIHTVV5hQ3Lk6OTx/hGixxPzlAjMD4dEfw5ON++++pwO5g0jWKPtT3cV8iPX3zw9bRGFZZnaDu+/GBXeCJqbqipn4pgz8r3ubJdAyGexGQa/f98CZIZ2eFKD11Ws65PjVCDy2uTHsDaqFCzwMW87szZSPkaLiqWhZpDqwwdc8Fsgk5mT/ZB29aXUU0L8ocYVmyxto5TzFGlPQoHRuydXO7Ftrbk0lHX4CtOoIxrx/LPHxKLWZ19IZ086vARoGpvRocuQWL/ry7ihjkbE9fVXXwYaAndbz8iau/d6KC7mfQY1do49p4acXBtlvkrxc384Epi7Ep9j/am2btfNqlAavm9u70Uw7TJzL1+4y7TOEWDBU9SqHx+q4u1THzLAr0RTQeP+x3FreJkVo9oNu6ZxLyOYg7/6d/puU/IQDoOg+AmFexz4y6GF1q6TM+BMBHhSytyced1rQZ4RSD1C9qS9Inn41nU6r9U+zU0kecltjoA9a9Y0JpbfvGTeLnWHhYal3h5ZH2HuvhsZAdwZS+VYxsXMZ9f0fduI2T85RtTzb3GkFcV7vUQCCu2E5IHlDkzK4buJ/7xMEi0MzIDPmWjCn08jaEkL63F8zjtQDEOXaCTQXKF36Ll1Owc23GEO58s48v6PQDfIM8WlujwZNSnMtWfIFX4s55vbPiAaxIRn2YpJjJARuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O3EjLGzNkqtva0cVK11zQHpIU8dzBfD/cD2FJb2kxT0J14BRlnVWSzvpQuMyIisJuXV7aaY3LZAH0TWL61KoORJMvY9N2XHeMKvHax1DqyJcA6JDrrd1QDUv/jvzsPRnhgWJIPbpBi3aOhFBYL53AH3oETrZIi9pXYWcbDFpxMd4o3CXecWyJrE8uLkUMp/P+msCYNrIf8sCS7a/pF354MfPe5J9F42KqggWuqcZPFfjjdLus+rrAglHq/2oi0ZOj0SkzJBQBKxs1iWzca0lJv6EfZLQYeyXO9dFPN5F8JnpSAqiOXrN6f1BLobh0GZxbJJUr0rQ2lsdNP8C85dl0By6Ot+vsY3eYqxpTt7l7+VvsIsi4k1jZkStPATViUW+khA/n+V9nQMJ1JBvw3l8Kdtc6YOrQmP7Wc0XacOhmZIz7iK//hoU3fvZWWW6Nxln
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:25.3026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fcb2c9-6a55-4f32-f947-08df022d0eb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987
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

Use SDMA rather than MMIO.  The avoids the need to
disallow gfxoff when invalidating.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 46e98fe66dd3e..8b95a1281886b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -950,8 +950,7 @@ static int gmc_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
-	if (adev->gmc.flush_pasid_uses_kiq)
-		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
+	adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 
 	/* The sequence of these two function calls matters.*/
-- 
2.55.0

