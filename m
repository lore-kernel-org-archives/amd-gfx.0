Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD77C4320A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 02:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7887761208
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 02:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7887761208
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A87716E7D1;
	Fri,  6 Aug 2021 02:36:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C876E7D1
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 02:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVnuWpqDebPcONxgcz0sL6Vi9UyQrAFpjkqDXQx9m4E/awLpp9d920JFICbuD3hSKaVo9hXx9tnKPALx4iQfsIvSCxpq6gLZUTEWafNJ+JpY38q2m3zktXO5lUbV/0+7YUo9EOUa3ddzHVhU5vQJjizkInDn7Wn6q8ASE9Vc/UoLD0A6+L98rYdC3OXEiY1R1DDPHR+IVtsynXu9BX8ogPOdyiyczpm1e58igsZZ52gAeKN07IZ+tc68xSoYfrU8HX+TGXiXjN++COwOO+JcQMVnFclG+PLxRxfVSNLTZpbL7DD2ZKxEXrgp8LIdbV7EQ/AVSdAXZkFWVTTYWSsyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o06htdDaEHpfyOFzljvqirjVzDQYVYWqqqN8S6THHAY=;
 b=nq9cLQPguXcEn39czIr65AJ0dxY6dxzAbN5J8TeMm6B8/3E5/eyrFrhEVYphzNpTKAIrOrldhD5m17zkqU8XzyASn5URMGvbL8lYWUgg5gduyTTd6U2oivh+mRdmgu5HuYTlyFZh0Er3UjMF2VYVU7+0dysc9EvO3Njh4gpqh8f/IPJqPl5syKNemyVSwFZ/l8vQZa4Hif+uRKeG1teeWXm9pCXkslkpLzhmqdGeNcV//MC4IE4HXKQUghYZbjMT4RuNfSyjQhnc+nSRtmvKrT5OtlAlM9EuSUNGGBdxh4ijANmvkPkkQZ1FU+SyR8aPaZMgwvNh4U9xXIiSWTEjBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o06htdDaEHpfyOFzljvqirjVzDQYVYWqqqN8S6THHAY=;
 b=M23lEY4Go1xHJS3y+PrOcXAyeQgvKmZUeKI9Bd4jPNUDGosn5D1BJ62YAj83IEU2sFc36lr0EptMGrl+12rfRlr44FYgtB+ICkMFmasRYN5Pf8qTTxm1QBQMrSLx0h1Uq9PWjeM2t89wyLyHsPDCZREdEdHezLHLptxwBZS7irQ=
Received: from CO2PR05CA0101.namprd05.prod.outlook.com (2603:10b6:104:1::27)
 by BN7PR12MB2705.namprd12.prod.outlook.com (2603:10b6:408:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.26; Fri, 6 Aug
 2021 02:36:47 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::6) by CO2PR05CA0101.outlook.office365.com
 (2603:10b6:104:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend
 Transport; Fri, 6 Aug 2021 02:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 02:36:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 5 Aug
 2021 21:36:45 -0500
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Thu, 5 Aug 2021 21:36:44 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jack.Gui@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: bug fix for the runtime pm BACO
Date: Fri, 6 Aug 2021 10:35:23 +0800
Message-ID: <20210806023523.29078-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee6ee191-be07-4673-0fb8-08d95883096a
X-MS-TrafficTypeDiagnostic: BN7PR12MB2705:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2705D4DB0F0EBCADA545F8368EF39@BN7PR12MB2705.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nV2KjgawF148Sem4piR3EvzcqmEsHbDJvJFJ1Z7l49TQfw8GrexmZb7Gi60tgGhkI9Zp25Cx/asSiNVwoxjYey46+heu5oo1O0VEfvIc+gAB9uMeU2OI+ltCVr+Ng6/LLJPRH3dQmMg//iW1hgqR1qyHdzUg25dL/qz1SDrwmeN2pxaKow7PvAEqJlEsrtjW2HEnMQ3ZfnBXClSgmjK29E54oVI4tWT+kvoZwcIfK5IsuOWYmJEYWCsP25CK03I12t1noUapnPuLpxk7XSwvK0IxGhzNFORdJDdVqcmkizsupkqFT30Wnv4cKuuR5sf9IEl1l7ZQsM66FoTzOLU2h+B2acXoWB74t9hMkKY4vY3wCjrThDi1M4wcj3rXjmWZi6g1aw4HeetBvgYYDANHxBaqDQ51VNaYoJGRV5OHkNxt5vKCCDEqfz6DPRhPRu5Im3xMa8kdL2Zr4Sa+RAzzA9xM+hBRn8rFf+wKAsorPovzcmh3ZAg195uXltDcZr9yEOHdfABxSw0wBjGq2FCrFNwvKd7+DytvZdkSafyI0uxR3LFbC8oe6uFHmoN7eRfBFv/R7KppFoSN99W7lwTSzO4+3c5QJDV+5ORAvdHh1dUQN45D6AKByBC3yVRM3LOfPLyW2Ii0k9wGuPRXnva0K71MXF8JrXbD/Uq/8tcVnkRT6tWItmPlMepQKnWnj0NIKpzRC5rDOk3qK458G+LLWZtcm5W9ZY5jYAQC4WvQ+4A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(36840700001)(46966006)(336012)(36860700001)(1076003)(5660300002)(8936002)(478600001)(47076005)(2906002)(186003)(26005)(70586007)(83380400001)(6916009)(70206006)(44832011)(81166007)(2616005)(82310400003)(316002)(8676002)(6666004)(82740400003)(86362001)(426003)(356005)(4326008)(7696005)(54906003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 02:36:46.9992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6ee191-be07-4673-0fb8-08d95883096a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2705
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

In some systems only MACO is supported. This is to fix the prolbem
that runtime pm is enabled but BACO is not supported. MACO will be
handled seperately.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 90e40aacb8f6..261ef8ca862e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -353,8 +353,7 @@ static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t val;
 
-	if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_BACO ||
-	    powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_MACO) {
+	if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_CAP_BACO) {
 		val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
 		smu_baco->platform_support =
 			(val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true :
-- 
2.17.1

