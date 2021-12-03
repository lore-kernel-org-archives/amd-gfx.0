Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63968C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 22:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4E2973941;
	Fri,  3 Dec 2021 22:58:35 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26F0F73941
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 22:58:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuAMlcuETjEyhZfmjWF8pLlo5O47E3Obve2a7skLnq0aVqtsK0eBsUZzRhJ8PSGmdUHKAoaakofFC2vmy/VmnfJXv9kmaKY695u8JRZfcAy+SwTQynISmN9DSxJAESydiT55YtlxZhaKvs70SGI3S7h87H7GDxiOQiLjIyMxNvgwsr4g9/Wnh+wPKd4o+clXsVyw/mNwoQ+NNlHYYX+o5RXnwf4YhXXU9HM5b0Hssr59bs98REpUTILimNXcvalYETvBB2aLGQ1vXK78w0ywI9zQIiwqp/ByFk2BUcS5ExDqRmdeMFYzI34h7cCZu/V1dkabrc/RyQPOmr/CMtPQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTtWUULR3yfwJY+gjcDMgSF2H0i64BisRO65xFHcanc=;
 b=c3CDkoMu/UCC0ZbBO37YnQJ2FDCIF6RGBYTFUtHFIo/M9psRXhnqbTuVD2ohEdvmONgaLrHKJhAC99P6YFsyOWwjB7uMWFNP2JUkvr3y6O1Xdgxzi5UubGUjTQyEig3IYe/Wm2BQJSN+CpU/IwVVCNaajHBbbNO4wVyTqU8UEkFl+0L8oBanwvoROSqkK428Lu4fu19N8KzUPuhSjPs6x4oUi5ETmdG4rLOMrvVYdNgz6HOP/UPEVa7hwaQRxtGfPIjTE4vVbtLBdXK2l03tgKsMKHR68YZ3OkRAHskKpkp7bY5dxXkuLHV43BnxwnJNBzdHgDuiL4bGv4JgzE3qpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTtWUULR3yfwJY+gjcDMgSF2H0i64BisRO65xFHcanc=;
 b=zLAN0BQHeAnpRO9pLE6bH1RPjGSYFQs44VG4lzZct2FhdR2R/0PP4bq6QdPWURof8eP/4uOSTy4zaCcYNhCRgrQWYk0QjLyOYRK1ba+sv84DTafMPlTciAHcx54ur2yAywz2qJHCTWDY10at2/zN1TZYwMKE9dcqIPX0Mei9Ffc=
Received: from BN9PR03CA0957.namprd03.prod.outlook.com (2603:10b6:408:108::32)
 by BN6PR1201MB0145.namprd12.prod.outlook.com (2603:10b6:405:4d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 22:58:31 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::7e) by BN9PR03CA0957.outlook.office365.com
 (2603:10b6:408:108::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend
 Transport; Fri, 3 Dec 2021 22:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 22:58:30 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 16:58:27 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: DC Patches January 10, 2020 3.2.165
Date: Fri, 3 Dec 2021 14:57:47 -0800
Message-ID: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a71ddb2-9363-444a-ffb3-08d9b6b06cfd
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0145:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0145951D3A2230F6E2030A1AFC6A9@BN6PR1201MB0145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CjUJSsgL5mY7dRDR/EXCcu9kgE9br/m7yffV6ZNiBrLpArwN2QAQzWxcTG8CSpME4x4KR9wpA3SOOGHts1Ixixdh0Cf3/kGlzF4RiLy53MWMNVAZEBMEWmgIyCRKPvaN61GDs8kAp4w6q1HUZhByuuVqZtOfuJc63A64DsLlIDpe5LqrGg6/D7Oy3GjOlXKQJXdrU+n4tRF6NTLwl69BlR7UmNZKq9QB9kEhehMtgm3gASDJrVJGs3WRKlWi3kMIPM85YbNKUboCkEoymy7XmB4IaqAhVON6A0KNeeDivpAXW53YaVuSP2kZCWcrLafP69yS+dMhq8JGN9n3COWP819wEf5YnYXz8Mbls7zh4GTE0N1gF5L5g5aNLLDpVZtR2xtqcEtKjlwUKwBLtEOrjiAhCIJ6e26B+KkLIz1ngJ0UPrTEdiqTZYMe4rB3c0+G+souyDQZtZ8b19loqSly66PCa9w3chXWq+XlfEryHW+QwUtzaQ2Tb67l42P6ujXkzW84uk7bd476dxovqC+TIeZJlLKcWfrCZ6E4q98KLoFam+8hVWbbGcCGKoBwRTvwHa4dntrO+J2URigNH0NNqyT0bDnn69Kk91B6Tk20fBxHaQq76mQj3uf7mwlLPZfUU0Mu+Eia4SKA/0eI4I+IcytAzKLptxSFw93kjtx06P1/JcPgOd1rZlkDNElVtV5PK0sx9sIBQE4QfGdKZNEjWW3PhIxcJ1Mo/Tna05nmahB8ncei6005yX4odedJbP61iN7pMyuhk20XBxCSY7HE/gAX+fAkA8f5/2VBvUU+Jkk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(316002)(82310400004)(8936002)(40460700001)(26005)(1076003)(7696005)(336012)(8676002)(356005)(5660300002)(6916009)(2906002)(2616005)(47076005)(558084003)(6666004)(70586007)(81166007)(70206006)(86362001)(54906003)(16526019)(186003)(36756003)(508600001)(426003)(36860700001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:58:30.7722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a71ddb2-9363-444a-ffb3-08d9b6b06cfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0145
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This new DC version brings improvements in the following areas:
    - Improvements for USB4;
    - Isolate FPU code for DCN20, DCN301, and DSC;
    - Fixes on Linking training;
    - Refactoring some parts of the code, such as PSR;









