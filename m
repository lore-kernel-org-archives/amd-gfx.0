Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F032FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Apr 2022 19:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5648610ECD6;
	Thu,  7 Apr 2022 19:50:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A27B910ECD6
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Apr 2022 19:50:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmuY7X1nCWadOQQb5msztg6oEnDm2ppxKZ5lOxkv6mPu7k6iyx7YoWpesdMVTixT1oHphU27wO4gh0qLbiyU+Hz+dcxGB/CH32y4fXIhaJOg1M/h143Mu/rh2lVIe1cNGzMES6mkA0SYPVvCQ+YmzvSUVPS2nlBaHXuVKaYqfM4pcaHuZpUZ3BXCut0/oj2sQlRdI2pNJpT5V5FaPu++gTpJHnFOFXAWXg8fC/mXFhK6OSCs1UsAC8JpbeMSLNYpi65O0aVnXN/dXWV0eUxTQhogZAPPHQv647rDQsASnP5st9T0VIzBCbtp1Bgg/BnmatsCS3/n4C1dNaXTKoCACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AugMG4JBPiNGvr54yRcL87kDIXpqZheFN88iOr6fUW0=;
 b=EA9zctUA4uWeKQKRGe29+dEoE26Kvntz3jbKKNO3FzJqCB9R23DhBrkikpUlhK4ZXIAJEGfPT1YW0XLmpl/ULkVC6f5Fs0N28aj2yf+2VSv3uv4RDa2XO+sHxVkfC/GtrZJDOdt2irEd12W31eyoFrtkI3td34KV3Kh+NHaOJKuk/ykPUYmcBwlyP+25x2lLuBlbleoXnrVnqBAqdZgLC/y/Z1EK1BqqIngTqnE1lq7y/+9PxxQBG8vPKIrL2KKwNyVF2Bs5HEAGdm8B5wUwXF9cJsuVAtsnzC83inkr4WhoOUohqQ0tgtpdtbb9QjZC1biIW1Q/dfLMbCw+20h63g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AugMG4JBPiNGvr54yRcL87kDIXpqZheFN88iOr6fUW0=;
 b=yCAio1vxG6GUc8DynMCHFYUoSSDgulDPyU0KlfKzWV0ZJfp63U+XyZIXjSj/DVzAtktJ0RQbd72mAqv3yEYnLlfImAuL1ym6KTf/zxJA0Tgs8z41AjwKNL7Gq8f+NXqqQnq4I7b9azw3K32FJUZtlwXxHkTJvclkLY7QQAGoLAk=
Received: from MW4PR03CA0036.namprd03.prod.outlook.com (2603:10b6:303:8e::11)
 by BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 19:50:43 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::30) by MW4PR03CA0036.outlook.office365.com
 (2603:10b6:303:8e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.23 via Frontend
 Transport; Thu, 7 Apr 2022 19:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Thu, 7 Apr 2022 19:50:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 14:50:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix 64 bit divide in freesync code
Date: Thu, 7 Apr 2022 15:50:29 -0400
Message-ID: <20220407195029.1581581-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b864e735-b55b-43f6-7647-08da18cfe6c0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5077:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5077E9208ACD30D19C221FF9F7E69@BL1PR12MB5077.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYJaM80C7PfBjHC0E15+ZDu6Dkfg+cae9Z3Atcd75tnGpmgQpQQJXdSsav2NwKIKOmP9EqiXMoMACdJNQTSBfpPdMeV8Q2UCQulNVMSRGPluS9lpfRqeVWDeEgOBO8VVG6rFpzzOb5y9JP8UATXfFQt2WJBo7eK1ER4tf2UXc9PDWeB20POVt5JFZGzIFjoih7+LvqpZCqfCwVxZ52ZA8l4fCerCiBtBxnxzQgrFgzRD83sdvFmYUgwGm7M9aIQevozRLNSyCLYESZYV6eyEQfBZMyp9Md385eNOo9VqogKBudnOGHKFdJ9bJJSEWJsuvt/kIXdRW0tBrblMTFpsg32q38/Fkr4pEuZLzA8ax7vDKxCUUZnAJitB0ze4vGuEhQq7D6LmCy3zz2CNhNUz83pNGxthfA6NnmIPfrkXBHkgaejOWOojiz/DXq9gD6HC8+VtkrqivxfNekXppfO6hF0+A07DHT7rGz8OO3YVqWWsgD/EIIFLzWQBLEIQC3kxrRQ5A0WPXw4Swz9hlB8RIr37ar6r/dUFjUCyIhdHLDbCYkerzsA5K55wa0WigeP/Tt1gcyBVk1iFlEHCFnadLYw8vViZxjhaZ+n4qPWoj6qKFeMCcFu26+BunPIR4ZTmGWkrOZqd7KYjXyGJqK3bSdisK45YezfpqfhVHVXtFoXrjY+yPCvtHqqZY6gvs5KlWXZ6qHzZS+VqnkNsmhXoPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(86362001)(40460700003)(508600001)(36860700001)(316002)(54906003)(7696005)(6666004)(6916009)(16526019)(26005)(82310400005)(426003)(8936002)(5660300002)(186003)(1076003)(336012)(70206006)(8676002)(81166007)(4326008)(2616005)(356005)(83380400001)(36756003)(70586007)(47076005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 19:50:43.2985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b864e735-b55b-43f6-7647-08da18cfe6c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, kernel test robot <lkp@intel.com>,
 Angus Wang <Angus.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use do_div() rather than a a 64 bit divide.

Fixes: 3fe5739db48843 ("drm/amd/display: Add flip interval workaround")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Angus Wang <Angus.Wang@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: Aric Cyr <Aric.Cyr@amd.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 0130f1879116..70f06fa8cc2b 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -1230,6 +1230,7 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
 {
 	struct core_freesync *core_freesync = NULL;
 	unsigned int cur_timestamp_in_us;
+	unsigned long long tmp;
 
 	if ((mod_freesync == NULL) || (stream == NULL) || (in_out_vrr == NULL))
 		return;
@@ -1239,7 +1240,9 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
 	if (in_out_vrr->supported == false)
 		return;
 
-	cur_timestamp_in_us = dm_get_timestamp(core_freesync->dc->ctx)/10;
+	tmp = dm_get_timestamp(core_freesync->dc->ctx);
+	do_div(tmp, 10);
+	cur_timestamp_in_us = tmp;
 
 	in_out_vrr->flip_interval.vsyncs_between_flip++;
 	in_out_vrr->flip_interval.v_update_timestamp_in_us = cur_timestamp_in_us;
-- 
2.35.1

