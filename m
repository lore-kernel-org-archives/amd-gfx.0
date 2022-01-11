Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59419C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 07:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4AD312BCD8;
	Tue, 11 Jan 2022 07:45:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99BEE12BCD4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 07:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNZ92FIZCbJFCzcNlDIZkrKX6cxeViIbldUXOxxTI27QesYRciQ9aq/IT9VyDeMRsd/G4yvXdPh/K7m8SnWSt2AvAtwgG6vRrsVlPQs5ywwXwKzmBOi15gkF7hzlFa4BEfK3kU+gMpREAlmNd5A/UotlI9Y65VHCfo2rCQ9OU2CHpRs+9yFh10F3JykcGc/m2f5mjkwcnyW1CQuRu7/75unm7A2aUt5UnsvtrAFnklhK+dBw9WRpodvZdNnOCiolVhoL3/5PDiQvdBsOF3j+P789Py91Tzl1b8NbXKJy1HJXVXVUQb/tp2UEUqtEQayqp3irnoc1RJ2ewPYIk5KJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKzmmUbusyDaaKsKW+GFITSTvLBodhI+70pswcRDkR8=;
 b=cgZ3sl92W0TEoWOqmJedjEQEWzAV3Xo38lBtlVQRgmzYq+KkmAymYPYOtrRw0Fm/Ufa+d5rmgBvQZ96uFb6Pfv7kRWqQdzy98VqxP1XWsrbNbIURV6yYvsGAkjUhA1V8/LEui0/WlYs/M5AG6VxgP+Muna3ysaskoh7QYF6fisZyI84Ln55GJBMSbiVZ6r2dNmW/USdei1DWTxtl5f7Nj1EqobRjv0EBRsLVVLTzZ7VkHzzq3YZWQMU7+eag5MBh5fOd6WcjkHjt/LLZzIUtMpzfWupZi2IL+HN64FwRa5doyGU6y1hoPQh/OYwmxfi+q5o9HwkwAVR4lmGQvCJ+vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKzmmUbusyDaaKsKW+GFITSTvLBodhI+70pswcRDkR8=;
 b=2EQBb14SGkG/22Pvg7JpdGNzs7MSg9skzYoQaue5comsVbWu98KTWWmSTnmZz4a/IUmD1xsBVPOe1TsZxg8cJ0Hx8zNtmbAVEHbRzXJ4SsiWsQknuLYmhYL+PgxFvMh5gR73iWo2Q/DDy7MExF+vF4ZE465AsvNY6BJPoBZWsNE=
Received: from DM5PR16CA0013.namprd16.prod.outlook.com (2603:10b6:3:c0::23) by
 DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Tue, 11 Jan 2022 07:45:19 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::7c) by DM5PR16CA0013.outlook.office365.com
 (2603:10b6:3:c0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Tue, 11 Jan 2022 07:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Tue, 11 Jan 2022 07:45:19 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 11 Jan
 2022 01:45:17 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Evan.Quan@amd.com>, <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amd/pm: only send GmiPwrDnControl msg on master die (v3)
Date: Tue, 11 Jan 2022 15:45:08 +0800
Message-ID: <20220111074508.27385-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a9c84e6-0bbb-4e0b-88ee-08d9d4d650fd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4315:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB431566D2A71EF6B02466E9B8B0519@DM6PR12MB4315.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UT31QbRGDCWYLO1KIREdGsvSQGWJStTmLOrG6cfaUdxMtrI5tmKBTdo1BYu7eiuSapZENyuxVeZAjNHFUOSDIOXKJXi//Lyvfbqo47tPmHlcAqsqv+sQE2SXIojEp+zJ23yd9BzNep9TP5zg7qP83xQKLdxsN1K1sc+vTEnTre4wATfcKdFpZ5R9mHVIZN5IKro7DUvrctIbssRgwu0JidSsBgMh3iAB+uMMHyEwionmDaz01XYXSwLfZVKUfMqTqgkPSPokEvC5rOXq6Dqb/WwZ89wPpAXhwzUdnY+HZaYpr3KtpQkuy5GoyliGEDYmPIjjQ6dGlLjv3VgqUOvIoeHjlXnBzXVxHKE3mnwn2OGxFLiFuk9pQ19eRNPOL6FV97bj8RjnxzlJAyTmuACR5R9zx7yzVkxrDy+Peydo3TAYup9/H/YeBE4Q5UE6yaCesE+E1SfEOsFZbLC1xMvm3KMnX4wXk/UaJCFgMPn1JTL8JNWbLkZ3Qcno6jLmQK0kr//x6U4t3pPun8cu7r7c3zUqZJj5S9AYZ2jXQHqGJ86Zp55c4HvucgbI9YLdebWwPKC384ZepGNrtE+8HedWvYyEocPxq3unAunMK5hjxnoLl0ivY4wf8mcsXYt5hH3iYQhGBZPZYOW62r5N/x/tCA0s5Vo+x/ag9Xcs8errmazSKeUh2z61+QdEfS1XqdnOWGtlSq8mVSDfa0wkZfC0YDoHa/lmTZJDNfAT8YAhorthAX2C99xcbmaqmHtsd9m0eio5Ci+eO4RRijfibC+KdP0htagg1NPSZ978qrWyy9I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(6029001)(4636009)(36840700001)(40470700002)(46966006)(26005)(316002)(186003)(70586007)(2616005)(86362001)(1076003)(47076005)(356005)(36756003)(70206006)(7696005)(83380400001)(508600001)(110136005)(81166007)(6636002)(16526019)(40460700001)(36860700001)(5660300002)(426003)(336012)(8676002)(8936002)(4326008)(6666004)(82310400004)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:45:19.5424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9c84e6-0bbb-4e0b-88ee-08d9d4d650fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
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

PMFW only returns 0 on master die and sends NACK back on other dies for
the message.

v2: only send GmiPwrDnControl msg on master die instead of all
dies.
v3: remove the pointer check for get_socket_id and get_die_id as they
should be present on Aldebaran.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 261892977654..ac8ba5e0e697 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1625,10 +1625,18 @@ static int aldebaran_set_df_cstate(struct smu_context *smu,
 
 static int aldebaran_allow_xgmi_power_down(struct smu_context *smu, bool en)
 {
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_GmiPwrDnControl,
-					       en ? 0 : 1,
-					       NULL);
+	struct amdgpu_device *adev = smu->adev;
+
+	/* The message only works on master die and NACK will be sent
+	   back for other dies, only send it on master die */
+	if (!adev->smuio.funcs->get_socket_id(adev) &&
+	    !adev->smuio.funcs->get_die_id(adev))
+		return smu_cmn_send_smc_msg_with_param(smu,
+				   SMU_MSG_GmiPwrDnControl,
+				   en ? 0 : 1,
+				   NULL);
+	else
+		return 0;
 }
 
 static const struct throttling_logging_label {
-- 
2.17.1

