Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D829C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 541B760F6C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 541B760F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EB3E6EE86;
	Fri, 17 Sep 2021 19:26:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADFF06EE81
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICPgXI5gKarIBbN/QxWVXmC/U188HVZ2+YbUX9fTryWfdHnXLhUPWmhGrzjTqaxC/vO4+LJ9x216Kbga7t1lAS8H5w7PZeiXwXUp70gahAY+lMSHrcjPwGl0eVyiJOPec5Cv98K72hwjTOOgOUvj7tcuEMBqqEeU55z9CGKcQQlsYziHd0C+XP98Q7yhtTRx1xSHw7yetbYC4sYg9KJHRx7iwPMTqgqv4JjQRtXJLqiOZr6oPV/Ukid69Rm7NerQc/0EJm0yLcxT4QfXlCWJloteCPd5jgKwT4yQziqD32r2c8YjbU8jRUq7NO0ySe+LEKN+6PryhYtu5omyn3EBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=u4ZXUKuZL9aWlI/TPsKh1pZq4xFcQlzwqOt0xEj9cVs=;
 b=QnKQwqYewEG1lE7r9cNmw7ZX5+7n4K5iQDTNAk/+BIPdJbCLCZTxbhZJoMHbQ2igPc+0TEg4FvmuEeebBr4q4dUmGc6jLnj/+mA09dt5g+Fa2KqrNOr2qxH5UozxEg31tWmjHdCUBc5OTkQS2ELxj+cj/e6glsvI7WV+NJff2jEfJ95hD1vMtA/ry/baxBPJ8qbbW5lDSndPrgBj5Gfd+k6eMtz22ilg3Jq5VCds2Muw4YIaZRTt6yTwUnlzMqNt+LrdC1U9y/QWhAc2XsZnzi3G8NZwmLVVC528ItDdRN5D05hVGUgZ9wgoJ4LqfqD4j4l81Q288xV17kh9cGZE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4ZXUKuZL9aWlI/TPsKh1pZq4xFcQlzwqOt0xEj9cVs=;
 b=394h7e4Wl/fIiiwgMvES6DKXs/UJV4tyxSl3zoLYhZg33QMxb53ZEYaiInAzQhpW/VcItAxKve9t8SEjg5o0Gdm4VtNAMqLXf6njsOME87M8J4RLnBaqo4bbf/9QikjEAtJTAQ/s1/QPJx0b/Ud21/4jceqdsbrO2CNiUSiF8yw=
Received: from BN9PR03CA0084.namprd03.prod.outlook.com (2603:10b6:408:fc::29)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 19:26:03 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::a6) by BN9PR03CA0084.outlook.office365.com
 (2603:10b6:408:fc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:26:03 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:26:01 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Anthony Koo
 <Anthony.Koo@amd.com>
Subject: [PATCH 16/18] drm/amd/display: [FW Promotion] Release 0.0.84
Date: Fri, 17 Sep 2021 15:25:22 -0400
Message-ID: <20210917192524.3020276-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
References: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0c47ed9-bf9c-431e-a52b-08d97a10fd19
X-MS-TrafficTypeDiagnostic: DM6PR12MB4468:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4468BC8040A7E7328A38F62598DD9@DM6PR12MB4468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UoYy+PIqvD5akug+0LXOW5htH9/weYY4Fs9epVCgYRBtLcKw0fuYSqMmKppAkIuHiQlvr8LlHb4JFSbgBvie402gRsm4R6xcWYFkcCO1WdUXoCIEoB5ZUEHvCeVrT9bjh/UOxfvC2bqOGcMnXuGR+fbBXkCFzAzHLY8NptIBMCatB05IsJjZUcBaR4ZTt9FSqmjPazVTIO7N+oZI9RzCoJPOgrLdO2LQggHxtP8BNW/OoQHsMvIFcF8w2WvhBQhLq4xcvxlA2J+I2W9fvqTms8xIdtnEcoLJJ73THnSBOCpiOpmcZQLKJ85jUAth+YkxsCTKhUZ0nWFlk7Yd4HOKdnrxTxjEYbkwUaXKP0EGm6KkF1XIwiw9py8ScVkqFnWC7vrA0jHd4J5ZwMO9XCMrY2TAi3MCxs85OGxLFRvewCkRW9RMt/2amvZ9MSfbUXDBy1wOKMuof+zdpRne/JG9M4KrhhBAgjeioTp+3MphyKaLbZ3Q636vqKF5xuT+jb2fp+msWFGixJYgWaj2N0y30IcmyO8v19s2FwXZLd6j+djFr7tvTwayxe5R8RwkYqXfcWpu6MDNPPsdMVaGYrPSZ2jbyFCRnAnsP61WqiDNYaBNjXvNnIHHIGvV1/akhBCHctWnrxyE18+J40GZew9Ppj7o6TCm0uwJqtEcMuag8Io2RyAdyNvffRMnkWl5T+5MNirCVEi0CIL1HqvzvO1bEpTIxTsGygJUs4sGo4fu5eo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2906002)(83380400001)(6916009)(4326008)(186003)(16526019)(47076005)(36756003)(8676002)(86362001)(4744005)(2616005)(8936002)(26005)(82310400003)(5660300002)(36860700001)(6666004)(508600001)(54906003)(336012)(70586007)(426003)(356005)(70206006)(1076003)(81166007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:26:03.3577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c47ed9-bf9c-431e-a52b-08d97a10fd19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
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

From: Anthony Koo <Anthony.Koo@amd.com>

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 1b377364ace7..359f091e37f1 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xb24cbe3d
+#define DMUB_FW_VERSION_GIT_HASH 0x607c9623
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 83
+#define DMUB_FW_VERSION_REVISION 84
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

