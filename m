Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07DFC33C9E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 01:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7DD206ED
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 01:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yFwI+j1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7DD206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B896E378;
	Thu,  9 Jan 2020 01:54:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798C26E378
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 01:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ53t2wg/sZ8aGT5rhvWc2r1wi901WpDFyYYB+iLzp8dIxAcHhqPChVi/Tz9EtDjOOSPfdVo3B4LQwDFGLzI7zg6ykLulHazVyhD7qZ0GcFiBIqAIblNONG1uY1AIzcsP6VD5GFELKa3F7Nu8yzFNuKrhl9CEVKR6rh8f3nMT/YQr/jMJnokFM0UX52qdK1D8BjByKrrs0AkOuq6D84Jgalx09jkQG0uNi08zEZfLsEhA9Pw+2bC4sqaHsbKWkNBkMRoDy//SUKrL8S9ApHcR5scfKXygTXuXa6vrmiHzLTwfSTC6AukwtqCudLaEXtKJBlFaMmW20cXldwdyt8bzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RG1nx7NmcqGo+grgP9+4zBwUH/JvcY76P93uvJA7j74=;
 b=LLaZhjuNLeLR19V/aRR0IHYk4CgT9YIUvOAbXP5/yZVznDXjw1LdpSXrjHKraFRAUDQaaH/KJBFOLqjhH8IGestuiBYJUks0vyf1pLLcSEIyX1u5h6CzRvlo2SX/D0YvfTi7X9xE+8xPgtXVgUrWa8m4xVSQV7SpAe7opJ6fDYDXWeWyBdqYMyduXIYMSGzsY4dutdlUD7sT6+0dqDKz26WryPfq0mTyxa/CoMZ8nT/V4TrDFAGFwbDqFEtr/zN6rgYgXzBcK32JouOkFeEQyaA8/DP1enEEm32AqRTaqqQHDPr1s7eW6CtA2CRgR3VrYPgWQUqUEUbwhTSJ3e9U1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RG1nx7NmcqGo+grgP9+4zBwUH/JvcY76P93uvJA7j74=;
 b=yFwI+j1TaT+dxvD9SJ7J1fpBM9J1fATNcJtdAVQfm/ZlzQsUDeeBWprfk5fsKoAhiALgAScCFTNiOvPIYCU0WbTZ//krBWo5q8MFhuabG58c+zeI6nhenkMNJjGVAELIa4X9yhKIvDRuGw3+tJUj2DFFgXazbXg1h4ck5+gMsaA=
Received: from DM3PR12CA0116.namprd12.prod.outlook.com (2603:10b6:0:51::12) by
 BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Thu, 9 Jan 2020 01:53:57 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::201) by DM3PR12CA0116.outlook.office365.com
 (2603:10b6:0:51::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Thu, 9 Jan 2020 01:53:57 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Thu, 9 Jan 2020 01:53:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jan 2020
 19:53:56 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jan 2020
 19:53:56 -0600
Received: from lnx-kenneth.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 8 Jan 2020 19:53:55 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: sw ctf for arcturus
Date: Thu, 9 Jan 2020 09:53:50 +0800
Message-ID: <1578534830-24419-1-git-send-email-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(428003)(199004)(189003)(26005)(336012)(186003)(426003)(6916009)(4326008)(2616005)(316002)(54906003)(7696005)(478600001)(81166006)(8676002)(44832011)(5660300002)(81156014)(8936002)(2906002)(86362001)(36756003)(70206006)(356004)(6666004)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1187; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51c6bafe-7318-4d46-5bd3-08d794a6ca13
X-MS-TrafficTypeDiagnostic: BN6PR12MB1187:
X-Microsoft-Antispam-PRVS: <BN6PR12MB11877868BAF7E6D059493D078E390@BN6PR12MB1187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-Forefront-PRVS: 02778BF158
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Bb+yVFDoOieZsrN+Gmf6MZOTB6Zc0aHFNHffBys7cZoZecT6ZfHph2cGFURSfWciEr8MwzTWt/KMNTyZxcoXRLN7SYRmSxIh2vL/W69hqFYkYBlzMy8h1Wrcl8ktGCaAsOpo/13PFvObz8B+Vd0j6mWT0YWh7xAfcfJV5bd12SVm/XsD2N3qIquIxKDK/M6I93Z1JBQoGBHKawA6uAC9RYZRQxIi0+2c/0NXojn5yY6v0M6hKF/HVv3AkzGeZOB0IRWWk33p9GL44kdX02b4eVFeY7KtPUjGM84fjz3b8Fvssp+Cmv0KwlbYbpoL5RhdaWK1ze8xLJ4opUDr2ewMIbfuKmNuxmdbiGl6UvmGY4PAbg6RJ5qvCEAgh8wEOBCMY98fIt2AH+JGgEFeRiyeQ+8NgIGRcEqZdCvkOw0cibPrzccy8pBN4EEXPS1v84R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 01:53:57.1052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c6bafe-7318-4d46-5bd3-08d794a6ca13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
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
Cc: evan.quan@amd.com, Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

software ctf implementation on arcturs.
has been verified on the system by setting a fake software ctf
temperature limit like 40 degrees centigrade.
then the interrupt is triggered from ih ring and
the warning can be observed from dmesg.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 50b317f..330d5f4 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -846,11 +846,13 @@ static int arcturus_get_thermal_temperature_range(struct smu_context *smu,
 						struct smu_temperature_range *range)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	struct smu_table_context *table_context = &smu->smu_table;
+	struct smu_11_0_powerplay_table *powerplay_table = table_context->power_play_table;
 
-	if (!range)
+	if (!range || !powerplay_table)
 		return -EINVAL;
 
-	range->max = pptable->TedgeLimit *
+	range->max = powerplay_table->software_shutdown_temp *
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	range->edge_emergency_max = (pptable->TedgeLimit + CTF_OFFSET_EDGE) *
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
