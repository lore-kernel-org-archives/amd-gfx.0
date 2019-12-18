Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8151CC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 10:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430D52176D
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 10:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rU7zcine"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430D52176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E160B6E2A9;
	Wed, 18 Dec 2019 10:15:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B77C06E2A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 10:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndCuEMPcK2v/WYVylqI8Sk1Si9+nyO0up0UeqKa/rrUSj8l0nm+79vk4oT8lAQ9QARic1hTs0IxnG2zr4c1cdLt56kE2AIsUN1XwhowEmGXwr3OfKdsbdJylE4vMYS3V589Y5NqUhFgcfYpwCHel9+1TU7K5ItL5HWgmenxQmpUerMNy9+3QoLk8F2lan82WAl/zvgU5tiErHAfS8bxaUdwphUizvx6KovLJPM2kW1SblaSRgnGB4kesYhBGucWdf8xXtuJ1A4nmzzeTQGUj8f11tAY5pMvJpBgAL5SmFdjlGfaUUpvhaD87H/DGtTGzDlMqpogzzWr2xYkaboj8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vI8Vio4s4bwAfnaIYHTLF+P5/r4Uy3AKudPB11MB2Jw=;
 b=QEHzOJ+x2ztFgPo8hN/UiZr/rRr2eg7BOBhJSKlSpMpIID16RNsYFzqljjvc7E8Op7jWFQS0ck+SBQthEmF2Cn4WjDDn5YbcSTtwbApdUCWZN8Zon53iKd6FvOWj6vtQOYJFZ7IzJM66DrsLJYhZjBrbdNIGF99Bw92T9LmN/fHw3TDzI9v4mkgINbVTF3JgXsEXFzLRfdgV6mMlyMQ7Uyt1eAiYqHAF7qqwCQIbmVeZTOhWP3lVcx9AjDWtU+L8x4HscIUi1g8huqN0Aqo626FfzBW5x+X4y0cAYuBz4UfbUlITCASu638cZo58A9ENGpeKYohlC9Jw0TwnJ/rVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vI8Vio4s4bwAfnaIYHTLF+P5/r4Uy3AKudPB11MB2Jw=;
 b=rU7zcineN87fbQctVUOFuDaIBtaGFlUAXPyA6J3WCQmLvol17Yopqn3vFS40/eJHngPjMhEyz2eSsFRGOajHhFt9XmfDNlUh5eqcyQJ/M2gAeXroBxhE9TlMshf8gxZUtdJs/t2oFe54+b131HCyYEpy62YRTpnnt5fQJfwT86Q=
Received: from MN2PR12CA0024.namprd12.prod.outlook.com (2603:10b6:208:a8::37)
 by MWHPR12MB1935.namprd12.prod.outlook.com (2603:10b6:300:113::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Wed, 18 Dec
 2019 10:15:27 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by MN2PR12CA0024.outlook.office365.com
 (2603:10b6:208:a8::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16 via Frontend
 Transport; Wed, 18 Dec 2019 10:15:27 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Wed, 18 Dec 2019 10:15:26 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 18 Dec
 2019 04:15:25 -0600
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 18 Dec 2019 04:15:24 -0600
From: Yintian Tao <yttao@amd.com>
To: <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/powerplay: skip disable dynamic state management
Date: Wed, 18 Dec 2019 18:15:15 +0800
Message-ID: <20191218101515.22327-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(428003)(199004)(189003)(6636002)(7696005)(4326008)(6862004)(4744005)(36756003)(478600001)(81166006)(8936002)(81156014)(8676002)(426003)(316002)(1076003)(336012)(2616005)(2906002)(37006003)(5660300002)(6666004)(26005)(186003)(356004)(70206006)(54906003)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1935; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b99adbf-4d7f-44a7-0fd1-08d783a333f5
X-MS-TrafficTypeDiagnostic: MWHPR12MB1935:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1935393F6C5D9E8CEFD82D88E5530@MWHPR12MB1935.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 0255DF69B9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfcedvbTZjht/Hcdk2K56OjYM6oucSjrsWVOhww3NWfmX8XQYfNExqAdUiEOnYKJZ+6W399VNbQdzYc0eTX8WJ/LsKwNo1XMVJ3JZr6gVbBlvNYbr9djT3P7GwPfADnH52RxxfN53MNHkrZnoKLe/IEooU3GOTpwjreE4KewFhhPinVbFYOtwh1KvtJaMkZbgR4xsLRyj8fJOp6GCcTBzXEgvcn1nI2snDFYCgS1WZPKscZxM6gpkiLxPhPzR66stp/yVdKHw0Bc2dM3NTZjFEaUl1GI1HKKoTrir5BzUBtzXUaRNQdHMKOsO+96gaNYyB/PNOuAMef8LLQv1rAtvrJqcVJDc6p2V9JjQt1czWqAbSp5Wu1z5M/cIp/6CTS4uFNds0/CVMXTzX1mW0IgvdbpyzFgGYMDDtjl9Pg771i4LkGPb2xSnhKIGiydIYyL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 10:15:26.9239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b99adbf-4d7f-44a7-0fd1-08d783a333f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1935
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Under sriov, the disable operation is no allowed.

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
index 253860d30b20..9454ab50f9a1 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
@@ -99,6 +99,9 @@ int phm_disable_dynamic_state_management(struct pp_hwmgr *hwmgr)
 
 	PHM_FUNC_CHECK(hwmgr);
 
+	if (!hwmgr->not_vf)
+		return 0;
+
 	if (!smum_is_dpm_running(hwmgr)) {
 		pr_info("dpm has been disabled\n");
 		return 0;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
