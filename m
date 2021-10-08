Return-Path: <SRS0=CorL=O4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB311C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 16:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B73B261029
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 16:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B73B261029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34AE06EB8D;
	Fri,  8 Oct 2021 16:10:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FAD76EB8D
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Oct 2021 16:10:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaZXELtP2xjecRPiKDrUPYiTNwOkasM3xoSmj57xAAZPJ1ookqexF+5dZ+hu5dnbaAoHzyH3Z1070F4cK/mXgOKqPRFUxkadwhEJ1hVrm59rCRmyAbQh+JqCYjZX0wd/3q9flqMTfDC9b12rsXhgLpk0fU25JAka1E+iqRv8ZkdNP2H8CWI838kM5blxr9VjxntjuhjzOQ9Jg6J2aHf7svNguDMHPljqquUbD2UiljihPVSHqzfpFLDpFmZVXBkNC+w+F9ERN2x5rKlJn3ogFjEVDKpdye33OQTDWumaQPZ6jG2lHyAveEOIlIJJ8BoQq25x6ich8ZDAUxpi3PLwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfOm5Mi9+m8EoJkvgPnVz9fOFZ68ymOZ5ebEBDhWVs0=;
 b=L2y9OARLTymfTZp+yHX5nYf+6d6Hs1uv8OLGxAeLEpJN0dv02sWS1wh02A2uNZEdr9wMmq+XLxDhvHeuqEEfnUgqEXh6ZB1gte1lDk0nZs6dsJhqGGpF7pRMg1Y24kuqKdtZ6GKpMaAOav4mWHgBgN39QJ8PphqzVFwFXhS82ALi4PEspDb5XF1RFwehE+PEkT/KOKZslQDrNCZDJ7ps/KOR3ygRAv/h6r2qKXioQ2zuZBlO92JTppXdM05kPcRBqLY5znYeosQ0sx0FWZynzi9nkCIGQKSTOW7qqfsAW2v6PIlNjB8WC7+kaMqwAIY3styMzKimwzHJrMxPlKtgAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfOm5Mi9+m8EoJkvgPnVz9fOFZ68ymOZ5ebEBDhWVs0=;
 b=Fnut0dMEAl4eMryAl27fAu9bOImYr8U2yWH19yNsQ80d1AxrLZLJUMKe4QNKR9c1wccCP/iXKR+eYLcMOyEeDmqj0Q0rldvZ9GJ3LJLYzNlccwaWxuCHnRMp5wRBXQccRe6ndL5AbyqH51FwX6kBgzkQPopBDaOUPvE5pwUzeBY=
Received: from BN6PR13CA0037.namprd13.prod.outlook.com (2603:10b6:404:13e::23)
 by DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Fri, 8 Oct
 2021 16:10:35 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::1b) by BN6PR13CA0037.outlook.office365.com
 (2603:10b6:404:13e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend
 Transport; Fri, 8 Oct 2021 16:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 16:10:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 11:10:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/nbio2.3: don't use GPU_HDP_FLUSH bit 12
Date: Fri, 8 Oct 2021 12:10:21 -0400
Message-ID: <20211008161021.1922011-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008161021.1922011-1-alexander.deucher@amd.com>
References: <20211008161021.1922011-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a98084ed-e73f-4607-2156-08d98a7628de
X-MS-TrafficTypeDiagnostic: DM6PR12MB5021:
X-Microsoft-Antispam-PRVS: <DM6PR12MB502140070B6ACFFB353BDA5DF7B29@DM6PR12MB5021.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQCD0y/ScwAbS1vk7kD+VqTIWjb+8KqhmB4BkNhy++4CD5seBRw3J1TCpt9ppOC9BONKR2hKYYtMszInXP+Yqr8o8O+eg8VQ8v3TIEiCWITj7mdZZTxGebQR6NlfxMJ+qVrvdjHduPHsMSRMkaO5Wsus6ayL5RoObxd11kHWzdEOOLc0cIbQAwsue8lSw6ihtFhXjhTcF+mbtuXJeLlExRXqupXfwentps4OLWJ71nC3IC7Q0mdAzYaSvCrZqPZwamG6REydHyYXJLLwSxZdd1vKYYMFgjGISute2jeY/IICR15hxVZ3QJbNlxJUxILfTw2v7YeupCj9oJZmdxWPaYXSWFn2OAtc8fB4dgCnjEXriXFS8/cZN+PTKh+4i0CMsVF5ZslpVeccSG3KCN+pQO7ZBpAl8+7LajtiT3TxiLZn95tdMT/SFJ+Ci2GIIRJoOI3zmqrtYvj+E7cOEHoVND+iObB1EniZlW4280pBPCRuS5jjjf3Klr3CKMdKHG9Xi6zzmuj7LPubUdPPf2v2b6EWz1uFUdDOtDxowlVMbubhrFQporgCnGGcETbBSUKg1WBoJVRGcnI43/H0CrMPyGNyyyil8SrzNTLfHmrJMpGDET+zP4V6ZZBzR4UNvRqKdlWAmRXgzt33V8HmK01VYyLaDIlAdvWN24fiFQCbod+yl8W9BaRytkmHQAmcb7JDsZiQ1/dQ4kBO9pZNqvRL9ebllRPMQUzNTpFt5CNypi0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(426003)(4326008)(81166007)(508600001)(70206006)(2906002)(1076003)(47076005)(356005)(86362001)(36860700001)(36756003)(2616005)(70586007)(5660300002)(83380400001)(316002)(186003)(26005)(16526019)(336012)(8676002)(7696005)(8936002)(6666004)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 16:10:34.5616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a98084ed-e73f-4607-2156-08d98a7628de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5021
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

It's used internally by firmware.  Using it in the driver
could conflict with firmware.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index b184b656b9b6..79bf6b381862 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -53,6 +53,16 @@
 
 #define smnPCIE_LC_LINK_WIDTH_CNTL		0x11140288
 
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG0_MASK	0x00001000L /* Don't use.  Firmware uses this bit internally */
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK	0x00002000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK	0x00004000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK	0x00008000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK	0x00010000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK	0x00020000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG6_MASK	0x00040000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG7_MASK	0x00080000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG8_MASK	0x00100000L
+
 static void nbio_v2_3_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, mmREMAP_HDP_MEM_FLUSH_CNTL,
@@ -314,8 +324,14 @@ const struct nbio_hdp_flush_reg nbio_v2_3_hdp_flush_reg = {
 	.ref_and_mask_cp7 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP7_MASK,
 	.ref_and_mask_cp8 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP8_MASK,
 	.ref_and_mask_cp9 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP9_MASK,
-	.ref_and_mask_sdma0 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__SDMA0_MASK,
-	.ref_and_mask_sdma1 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__SDMA1_MASK,
+	.ref_and_mask_sdma0 = GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK,
+	.ref_and_mask_sdma1 = GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK,
+	.ref_and_mask_sdma2 = GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK,
+	.ref_and_mask_sdma3 = GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK,
+	.ref_and_mask_sdma4 = GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK,
+	.ref_and_mask_sdma5 = GPU_HDP_FLUSH_DONE__RSVD_ENG6_MASK,
+	.ref_and_mask_sdma6 = GPU_HDP_FLUSH_DONE__RSVD_ENG7_MASK,
+	.ref_and_mask_sdma7 = GPU_HDP_FLUSH_DONE__RSVD_ENG8_MASK,
 };
 
 static void nbio_v2_3_init_registers(struct amdgpu_device *adev)
-- 
2.31.1

