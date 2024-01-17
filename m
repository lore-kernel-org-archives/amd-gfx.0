Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10717C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 09:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16D9910E667;
	Wed, 17 Jan 2024 09:14:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 121B710E655
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 09:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LO/quvsH+207t3JqmRrvh/ewW+X2QmMC43U7itKMMquSazLjJ9cg9AeQ2WvFqRR0M3ec7S9wvS28sO3PeOsrLktbHOYF+o+NcYRca5Cf67qIwbg0hucQBHZ0lq4N4HGP2ZVibuz2+hNjzksYsvF3CAInVye60hEmZw/W0WPej2zTthA10ZDKqY3zypRdFIY2tcJ5XcRyEdjUqEBTD7N4v1YP2tNLfsV7Zm+gc+srEo3/NTbNGp0L7A4qsB2v5CveYOBlF0RSCeUlyNz2akIiM9fvQhJuRJu8gcO+Qwm1uxqEW/MJNOCXCFluZo+g7jkNc1PMPgFofObGooTzdbiwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grb3YIaQc+h+q1R4g0rtsajS/t8taW2BDGa9M6WYMI8=;
 b=DbZbJWP3VHBuJg1OWUfY7eoPovf3TubJSuqidEATEU1MheUgcCmzeq0Pf1iOHHCZ7Y0JHdDi1XFmeNsYXZcRubnaKSy5r6K46DkZ8buKEmkD2r36TtvtCQCNj4wIyUTb501NBB0sJ6Ex6TpEgRcol8Dtv1R/6Ei0sNfMwTHtkSlBxRklUZ6UDPtG1ntj1iSdPDD/oOjSS9yh74rHdgkXYp8eQLexvW5vIFBhgYfPm5thh0PzkhfAXJzOxg/2/Foi7EJD1I64npicuJhcwFDCPxYnM3pO+ku6fLwFCgsVZwYotet1mNsX7qx4VW0fFPpyhNCg7E7pdFJVK3xhgoUJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grb3YIaQc+h+q1R4g0rtsajS/t8taW2BDGa9M6WYMI8=;
 b=x8hcWpLAXJPrYzVDq/EckwKhI2u+TkvSg3PoXS3vDGxtfNj2GP/a8Aykkb0CFmI27Tmd+dFt/XNeSR8XSuXUFnVBZf5Uro1QvuLhoin/INr+GbpJacqVxvITtW86dI5YKbmRz0v1WxOSywLjBny/qeIApg1QL/O0Z9KGO9s7nXM=
Received: from CY5PR15CA0171.namprd15.prod.outlook.com (2603:10b6:930:81::17)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Wed, 17 Jan
 2024 09:14:51 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::20) by CY5PR15CA0171.outlook.office365.com
 (2603:10b6:930:81::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 09:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 17 Jan 2024 09:14:51 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 17 Jan
 2024 03:14:49 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] update error condition check for
 umc_v12_0_query_error_address
Date: Wed, 17 Jan 2024 17:14:29 +0800
Message-ID: <20240117091430.29140-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b35c78-7314-4479-9fea-08dc173cc2c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzzWcE84WJaANasN2Dfw7dKV8Kq+kWZbzePMHoC6jaIhg8quORTh5knzINUzLiML9y2OkT3UkYIai02hn/7Bnp2MQcwFqt49qsvM4AYmEuHdZq2wDYQbJrIlw5PPUWQ7xVZzr9ww15nUOP/myyjxYavcpERytpIupGmIaF1OSTInoudhgVBEhOq/EmIbmtucubAEe2RbFAIjnFzypTfkBaKcdgeQ1RC8ONntiRKYHRmCSkSJFopkeDGU/v/Y8XbhHRkIFFkuutjdbqG9RlAfSKxzOv4Jx/8LmOwNl8YZndgt4CgQSBDy4WA9yBmkQqTmskcp47F2t9cOmPzN+eJSnQweNjHBn1GZvQmJk7L+CLQAaZLEH9Wgx55T+fWzWQa+6llFSk3mO6KaIQseqEHdbGdZqYaGkf8rcwG1ZfpKu9CpNSWTaL2li0YOc1Ym0cwMGGeaXtCYrTZbTtGdjDgGn0tW1/4t5vDW1dQmtG2SYs1KiA2hGQ2WR/pCL8TlBBX+UYE64BMwULnJTCTjrYgHnWj+DW65akXHcVm2VeIRqOOAu+LA0Nf+xnYcUPGscQv+lStqIEgyj0+pkR5Prc5kwRU8ebrEF+Hds/GRdEx5qbxz9bJyikrUE3187s+SnwEeJm5T/i25taPFap4YOejbDPP6GeyKHl9Jr2X36gnMmfryKliXdT0Q+T2KWEdPK/f3s2AlI4v2/370OTgwU9ZeX6oolIL1tAg7CUZcpiIsXbvicOMZYLJPjHzz/CElpzfpfzomgxMg409oVCYwob5sKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(6666004)(16526019)(426003)(83380400001)(478600001)(5660300002)(4326008)(15650500001)(336012)(70586007)(316002)(8936002)(6916009)(70206006)(26005)(1076003)(2616005)(8676002)(36860700001)(82740400003)(81166007)(356005)(4744005)(7696005)(2906002)(41300700001)(86362001)(47076005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 09:14:51.1554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b35c78-7314-4479-9fea-08dc173cc2c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Deferred error is also taken into account.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 10edf818acf5..2e0bd4312f2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -337,10 +337,7 @@ static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
 	}
 
 	/* calculate error address if ue error is detected */
-	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, AddrV) == 1 &&
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 1) {
-
+	if (umc_v12_0_is_uncorrectable_error(adev, mc_umc_status)) {
 		mc_umc_addrt0 =
 			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);
 
-- 
2.35.1

