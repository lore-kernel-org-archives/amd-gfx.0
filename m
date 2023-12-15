Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2E7C46CA2
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 19:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D639010EA80;
	Fri, 15 Dec 2023 19:56:24 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAE4610EA80
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 19:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9kJ3N4HByz6VzulMgnrDi3Hr60LN6m41502iQd8KSL7Jam5LnGnfCa3b0ySQj40pZtBHDGRJAIoJu4E/Dsv8rS3F6GL47GQVnU/VgMFoSPJ8J/+zJSG29jW4JRCt9y0hKI8XGTGKpz2DVXI7WtJAWrueFoUQFRP/hPZni+Lp10taFa7tDMUqkXsFt2blwWrlUFlx57RDIZzChghkQAI7zfX2UrG+5fMwahG0rD+n7E76kkT8BXtkCvId7lSLgpEuD+WyEBUU4vWEqSx1husTl6cpzMptdg5geugRMDKGx3QK1Ck6pbjukuuMzvSl3nrzgZBXEsFD7ecKTDAsV27kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hn8L9ImTT/rsdRs/ratyKvrP0KlOmUDKc1JeJbOTFzw=;
 b=fMLlTnbN42A+nkcuXNiwsypFPp97a2Zz6DIVb/HcxYpe3TQA8mUe9NnA6899j4+1LnFBJDyR1Q8DoQPhQ4WdT1Ls7ImMhZ+uazvpSWnGFY7rbVlSUi3t80Q2DreT4Jh2MB1M7rmKUV1K0ExBZn1CBRiakKwuT5q5IMEF3t8ilP17U+2tC+rgefOPvOJ5OYhkd4eXJ/9Dwm0N0+13ZfLMJik0u/66ZamLZxrbWYaFlVyvVkF7wYA7duEf8+0QzWqmEoDxbgSX9h2OoDBIHz6OGrfx/dAt0aU66XFizurfPsiChRuspOGus2fEWM2yqsnkSA5O8wuh/0yfl0ZDxKThAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn8L9ImTT/rsdRs/ratyKvrP0KlOmUDKc1JeJbOTFzw=;
 b=oeGTd7F5j65tbnDmAC/I4nK2MJFSUTo81QvTFJShQhY1xh4tu/L7zJ+deKfzAY8uDxTUDNsj+y/qtxvNjowYK/neMjz5tTX+4RzbNT7DSw9ZNeICdwc857Tl+unPesWbcOYEDl394+WAFoBab8l9Vb34yydbw7IHicgo2QeRmcc=
Received: from MN2PR18CA0021.namprd18.prod.outlook.com (2603:10b6:208:23c::26)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 19:56:19 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::1) by MN2PR18CA0021.outlook.office365.com
 (2603:10b6:208:23c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Fri, 15 Dec 2023 19:56:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 19:56:18 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 13:55:48 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/3] drm/amd: Retry delayed work handler if sensor is busy
Date: Fri, 15 Dec 2023 13:55:36 -0600
Message-ID: <20231215195536.20401-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215195536.20401-1-mario.limonciello@amd.com>
References: <20231215195536.20401-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 74255a70-c9f5-41ce-32d8-08dbfda7e798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQn5aqM6VmIin7CTK8bwZ6XpIJZaAr00DRNsHRzSYSdayR4lNzwTyOil41hvIm31D4YgKT+BdT+bgbHcBKn9sP7MVmWvtRa1h3TuqqU6Kjf0VRDE9tVLRj8whvyoXN6SZV6uE45rdk95n2lCbN1SUV2BaQ7BZZk4RYvyo+CUZ5aNTzuKGDTt+H1hJxIdHnM+QdOIRll8u0KqY/NG05d8xXA/5+tLLG7DiebuEoj4AAWHp7n4VnsWgodLnm9jdANjqt9n7YExPfwuW7sGtdJpu4zKs0Vfzzb+a7fyNk1wJ2s8/vq/WP1opPOsYGzqRMO/YxQam02CdihFY827FG89Hck+w4o92fvOkuFN6KjDt1nVGXBcFnIA1SOqfuidu4bwyZ4pjBHWVDBIkGVlpvO7/MEhXiDRaugMhLryQ2EcbruAWdWTtut+9ZS0ITdjiRI1OWnmwoiV08FrSeNhtyzJIBKWAQW4G8X5FhmVjNk3UYOR5a8HyOsS/nbDNEvgvUCDznkZLYfMMAFRYc1aq+n/jnezb+OUEfuC33NyQHXcOuZ1DbxK/h6lSieXKyuIgvjGH5ED4uQJ2T5UCGm7SqqVbkZBGF8pgRwTWfyLuiacSMTn+aeTTOTNRC7XYRhPsKPd38yGpG9OD9EUdxNIwk1V29d45RrH+k/zvgz8TPWLf5fWwnO0yDUwez/BJ4za6Js8zdB6SdPE9K/1zXirZ/654tWlqeZW6YP/rb6iXADh5K/9IytBG+MT+CJ8aW/EUt3R+Z3UqsUz4XCC+GaEoAhTDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(6916009)(316002)(8676002)(8936002)(4326008)(1076003)(16526019)(336012)(426003)(47076005)(70206006)(7696005)(6666004)(45080400002)(478600001)(26005)(2616005)(44832011)(70586007)(5660300002)(2906002)(41300700001)(36756003)(81166007)(356005)(36860700001)(82740400003)(86362001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 19:56:18.9465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74255a70-c9f5-41ce-32d8-08dbfda7e798
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The SW CTF delayed work handler triggers a shutdown if a sensor
read failed for any reason.

The specific circumstance of a busy sensor should be retried
however to ensure that a good value can be returned.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 963cf6e76935..5eb46b6bad43 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1182,6 +1182,12 @@ static void smu_swctf_delayed_work_handler(struct work_struct *work)
 			if (hotspot_tmp / 1000 < range->software_shutdown_temp)
 				return;
 			break;
+		case -EBUSY:
+			dev_warn(adev->dev, "Unable to read hotspot sensor, retrying in %d ms\n",
+				 AMDGPU_SWCTF_EXTRA_DELAY);
+			schedule_delayed_work(&smu->swctf_delayed_work,
+					      msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
+			return;
 		default:
 			dev_err(adev->dev, "Failed to read hotspot temperature: %d\n", r);
 		}
-- 
2.34.1

