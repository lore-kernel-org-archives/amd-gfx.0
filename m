Return-Path: <SRS0=CorL=O4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D61C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 21:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCDC60F92
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 21:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1DCDC60F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD3AC6E51C;
	Fri,  8 Oct 2021 21:21:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F76B6E51C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Oct 2021 21:21:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiT1nfHFK2bdl/ySrmJau9MglhFGdiZcknoXtFjbIvhB4WT6D7ScWxBvH19+9xUjSNx1I9FzE/FZw/JCYDDGjkSikLBDX7qLo5aoYZVGjOYJVl2lUIgqIIgviBeE28lSU+EH3CDpOsFrt9dmVMcszu1JsROKmeseUpXRpe2UZkfyUlytyjZHPECy6qAY4u38q7TiniPnmRECf1XNP4fxvODOFwCpJ0gEAtSFCJ5Dfd7am0lOM/kpkpA/pbcVpUJrkFpOU2nlir1rbveol/bIjTLW1LJqQImIb365d026nZ3RC/EJbT5cg6bpCiAH0X7qlSSGofMhhFDfcnx75NHFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMuGlIg3FtqkaSwb4sj27a+gPZqmIBCoTtAkunfOuLg=;
 b=ohBabf33OE2jQ8DsGdrv9wkK6FS3H92eFKZKmnEHif+eKtLdTV0j4+tmFTYHQwsz9sIqRj4hwGJFEDI1leOX80bISNm3adNRo5LbLiKfjFHBl4CIOmkbFAoSTeC31d+tEc8bdUDuceskO5VHIkvbQDRjRN54YkuAcrKgWfHa6j8oqkFu1SokM1aJes4JLbi9BVKpd3NqQlQFf3Ebm3SBzs/kIGu8hIy1Lyzj30nqML8xXJLDRpoDrUaiQO0MvTpWsl7XEnhyhfwjIaaPDZQLP+743JjgLcCzSsrnzod8t/zszGB3y9SSLnZMuQ/XsO5k9YYvvkq79usqLZV1d49Kog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMuGlIg3FtqkaSwb4sj27a+gPZqmIBCoTtAkunfOuLg=;
 b=EaEkVkTRiLLP6DpNreYyV251Cc2703Gwu0t/rbnLx85aGXCFREBLJpDiaVEO7CcOIULYmcoF7CsCQjndgEoEekZProQkao4sjy9JrEjMLR3kRxT4RJIt5T+kZDn9aV9WIGsQ/j5l4beRw1/rsHfYhk78u34dFZgJyzYlSxFkKw0=
Received: from BN9P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::27)
 by DM6PR12MB3978.namprd12.prod.outlook.com (2603:10b6:5:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Fri, 8 Oct
 2021 21:21:33 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::e2) by BN9P222CA0022.outlook.office365.com
 (2603:10b6:408:10c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 21:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 21:21:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 16:21:32 -0500
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 8 Oct 2021 16:21:32 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <rodrigo.siqueira@amd.com>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] MAINTAINERS: Add Siqueira for AMD DC
Date: Fri, 8 Oct 2021 17:21:22 -0400
Message-ID: <20211008212122.230566-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 789bd8ed-d7fe-408b-f7a2-08d98aa19a4a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3978:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3978F7F61A367148C342D2258CB29@DM6PR12MB3978.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQHZ8rJxPYsXQcY1at+jnetl0oqw9ezhDVD9+81h9wZNYPz4XJF++pIVxipjZxGDEMA/XFohXt6HJOGdBYlNrOzx3ZnGs/4hXlHJzvl+sUs2L3Mli3xMVTei44ptxqdOqIUzIN7+YJcqU1J2q/e9lIJXSrqykARh1onW/soIVeYhANc73K+KNQ7zJwPbcdxUmgRrA+9J8RxPZGnAEGjHT7360ynrnNA4eyWNDY8PtV2EIW2gokmIQZs2WPXx+ymPEAPeq0tXHsH3OQEOsy/bpgiY+PUcrpaBnGs71KueTzI3E4qWf1whjFevt6uUtHslAFpgvvEXZGjyeF6DkVjBbGibl1kZJHEWwyrfDEH3GQOkwubsyiu45tHeZ+EGQaIEyzpiORVBX6qCJnFxP5HzzHehcwXqZgPy1RnDyNWsQXU/fkD9KlZFcch/RILwl7EfceW8vTY3HmWZKloUpX7kIFIsPtb73CDlZjZ87RUBciAtYhmh9L9NaKlTQcVmWvSHaaZKYsq8Np2sateZR1mIXaPl1ccg7uF5VJsCrGspawIS12jbOU03QBFV2K6uNFmuoqNFRXlEx3xl+CvHoqcm4eGKitj/UBQZpNzyO/Ls755L7T2OXtjdRp3+KzkYZEXydvsiNw9lJvqeL53jgCUePilDSTDoRAGzqX8cmor1UqnDcab21QeXO8WJwDzHve5gNrteoYbvPCSYF4jog+jSAaWda3gT0zlo9jvXg9kFu5g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(336012)(186003)(6666004)(82310400003)(70586007)(70206006)(316002)(110136005)(44832011)(356005)(47076005)(7696005)(966005)(1076003)(81166007)(508600001)(8676002)(4744005)(6636002)(36756003)(86362001)(8936002)(36860700001)(4326008)(2906002)(2616005)(5660300002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 21:21:33.2178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 789bd8ed-d7fe-408b-f7a2-08d98aa19a4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3978
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

He's been helping maintain it for quite a while now. Make
it official.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 24d520c4b157..b107ddb306de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -876,6 +876,7 @@ F:	include/uapi/linux/psp-sev.h
 AMD DISPLAY CORE
 M:	Harry Wentland <harry.wentland@amd.com>
 M:	Leo Li <sunpeng.li@amd.com>
+M:	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
 L:	amd-gfx@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/agd5f/linux.git
-- 
2.33.0

