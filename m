Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65C8C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 05:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A158B611C8
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 05:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A158B611C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5252A89DC9;
	Tue, 24 Aug 2021 05:53:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5877F89DC9
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 05:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E48fvzpsMVXszqaq1CeUJXTotNvHaSk6+o4lQfeAgu20GXTzJX4JOMGAwApE1ZwEyHiCJc7dOPa7ziHnltpLFTbi7VwjlpdwtJMMQGUzrNC3mkGR6wWr5WElVoS4BAQ0KZZXHPBRgoO5OIV7oIU3nYRw3PSrj3qBlYm6KtinTsaZXpRKWae/drGh9V8sxqbFfPYMipTjKW3UTGZ1SOlWzBsmrQG97IlJSQ+et1HadgRSPSvClfdMSq2GUpKBtlfOnWOYYcf7Lu7VtVhcVz0b75GMrXsQ9X1cvb4Wge5vyi5gifok6GMwmZpTmFafK7xWydVTdT8v2rbf7twYatdOow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqlfLaI7nF/QCNk6p+hRGwq1vgQLtWe/mAzATBnF1lA=;
 b=jNGH/x75kuFwhfJMRiliN8117etkRRPkHYfNqm1HIqLJzh++fSTCBr8Z22K0ktM/yh13Ikpg2hsI3FkjgXIy3o7vjK1gWm62Dl9QqA3P72dm2WBUaKPVWKIkZD4JnZ4Gow5PajOf3D05uR0WWvNzE0OB3a+0n+qQLiPoeNyp3ndI1mEUD/mFC/nUX87gCeIphZPVn8pOV2qSVodDJo9EOlHvzr58eYke2ga+8fcbISDvNHrl2lKUCFPSpbAbeRstOERRKNOTEkfxc5q0lLeTZSSJANUv/VFkvBaaOq0ojHVQGDpcGLL/BCubSRhwTLPBGPe4rOLkz2J8wrde/uCXpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqlfLaI7nF/QCNk6p+hRGwq1vgQLtWe/mAzATBnF1lA=;
 b=bBwQmJX5k14omObVYBSnpLyzYw9S/61LY3YjGuBdYHzDm1uMgc812Fh51rBUtOJtL5a/sYgLp5wc42TOW6JNjuUlg3PGe26uf2vHaIOqn89kyBJh40UTzmKlVyqKviwk89CPhBiDauyjdTj1zuRVBYA7ZwKlRyWt3lkWLVubd/g=
Received: from DM6PR13CA0021.namprd13.prod.outlook.com (2603:10b6:5:bc::34) by
 DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Tue, 24 Aug 2021 05:53:26 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::85) by DM6PR13CA0021.outlook.office365.com
 (2603:10b6:5:bc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.8 via Frontend
 Transport; Tue, 24 Aug 2021 05:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 05:53:25 +0000
Received: from amd-Celadon-CZN.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 00:53:22 -0500
From: Satyajit Sahu <satyajit.sahu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <Alexander.Deucer@amd.com>, <christian.koenig@amd.com>, 
 <shashank.sharma@amd.com>, <nirmoy.das@amd.com>, Satyajit Sahu
 <satyajit.sahu@amd.com>
Subject: [PATCH 1/5] drm/sched:add new priority level
Date: Tue, 24 Aug 2021 11:22:43 +0530
Message-ID: <20210824055247.1189130-1-satyajit.sahu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5b85b38-cbe8-4935-d66d-08d966c37d4f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1850:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1850C27C71DDBAA05FA4DABBF5C59@DM5PR12MB1850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oyQVNgbXuG81BsvxFHh9+Tu0klPTQnIyuQvFp0HvsWVQREi8XqtHgjpNrWO9VKofulykP7XidiBV9fv1tMKI26/4F7/2w5V8F++MDVndcK4Y1WX3s9DUcWbk4stsYFDvrFPBfLR1VUi76DbsIjB5sHhsOaH41Q4fZpDzGEJ8aV0+C/Jt6H6A+lcvqyyZwujPg7x0wz3ltscHF6V+rWMja5Qj1PG5YFRE9/AsN3gUsXg893H2sjvgXbXKpu6npOyGjjbur92wMoqd+ffcGS/M2x+Hmze6S0n+8N4VbNxmwbBb8BV+UF6Krzi+MvqE5OyWpAqz2iCcgYk5KqaW6KQSaURHECLQjkUv/yW3fyNbGpbssAU0NAdMy+0F9K8fDPlH11+DmjSgGRJtXmMKjeckoo2QxKAIvyDO5xV5cZk26mOK9VLeNos3SjloUnE8eAorbT0NWs+X8vcf/0vzXxNS4/Oxg0YWF22Ad1Nr72CsXViui07o5dUzalQJ5BogrIUfUmmeRJpbg3RLdrkDmrubKQ/Ju35Q8Qtd8PhgdfQO83PUHIPLQuWXmOJdc1vxOyBmBPVn3Nax0SIVGSJSxnuqh6Znfyvn9wAHAFt26RRWSUF+8H5dbH0cePAVV7eb3aRtOL2jTR7n9dnyOPDd89EkU9pZGEmkwY9e25Bvh41fPOxdF4XcTDKdVngzTxffqr5um44TpvMRCrf/miBCBsCaE+cA9QL+Pm1PZSr5GiMb6ldO2g8s//ZUtsT7Crnn4+q8T6YmBjJiJ7sVPjQa43E2+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7696005)(44832011)(34020700004)(36756003)(356005)(2906002)(2616005)(1076003)(5660300002)(82310400003)(26005)(6666004)(6916009)(336012)(47076005)(86362001)(8676002)(508600001)(186003)(70206006)(16526019)(70586007)(54906003)(36860700001)(4744005)(8936002)(426003)(4326008)(316002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 05:53:25.5736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b85b38-cbe8-4935-d66d-08d966c37d4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1850
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

Adding a new priority level DRM_SCHED_PRIORITY_VERY_HIGH

Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
---
 include/drm/gpu_scheduler.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index d18af49fd009..d0e5e234da5f 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -40,6 +40,7 @@ enum drm_sched_priority {
 	DRM_SCHED_PRIORITY_MIN,
 	DRM_SCHED_PRIORITY_NORMAL,
 	DRM_SCHED_PRIORITY_HIGH,
+	DRM_SCHED_PRIORITY_VERY_HIGH,
 	DRM_SCHED_PRIORITY_KERNEL,
 
 	DRM_SCHED_PRIORITY_COUNT,
-- 
2.25.1

