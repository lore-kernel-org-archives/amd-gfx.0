Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F58C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 11:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6A4206E2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 11:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qz2e8j4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6A4206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C3DB6E1A4;
	Tue,  2 Jun 2020 11:52:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C35AA6E1AA
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 11:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaTEtmdLHqLTzy/9q0GCgXVcC7QA6DoSHx4O7avzFDg108TS8AQl2rYCaHUTiRsc/7iMCxIsvqZrZbe3yY9ny3OCjywDaZL3hDIJK/pZaQ7DvR/8d1NAcYt04+DsJ6UW0tydMOyQnCtfUnITrNPlDrj9lW6KP8Oeb7kZEIx5+1Ib0YYJ6lq/fEHcoq6PZcr4nX3eQKUpWfzuPJoObgz+I7SKlNW5KpGmx2CqKV0aycZQweJu7RfNrPWPLVezijp/7mU10MUYQn8msT4yhT039RXKCiiwDPw39gVPSwcbFJxx0Sord3IVqfLBjJQMLg8IVe6NgHfMcMVodbS9atkf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gk+WIk063tRwSykr+pMSDVd5Kqrmk4Yb4oCbAszUg7c=;
 b=PegAxtg8WuIYKTRSH6VcRHLpQd4ye3KcdBLI+vET/3E1yHrHx3ftFe284gVNu1QZSAfWjAwcps9ZafugPACML0fWcBIa1w/yllBOeQU2sY8dRRO44E78qARLkphjZjCa7IMrvb56NndCCHp++P/+b6Br7pIgRWdWZS38WMoPVWdQBmZr9ENKsXk6Zlnicknuf7xu4/FNADbtExtdy2QoAxWXJAGgEFmoTbFIgjza26w3g9uXykEZP5pGqoGR2E4be6IrqP/16N/izCvPgdpla+5N+MbCigMjgdJcKuuB2ePkEO94f00XxII1pTECLTfHM+Jm35ufzYwzfs0KLG3lPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gk+WIk063tRwSykr+pMSDVd5Kqrmk4Yb4oCbAszUg7c=;
 b=qz2e8j4N3Fg0IkMdUZltMwX4GYcP250eAwe0oxWhL6nVqKwFU0WSBd//wonZ/Zw2iMzTAWH3ApJcO+e2/bEXlACNvO4EwLpzanpYGkm0XmG5N4wga0C5eYmlJyF3ltMMJh4FQpeOe6Pl6RJFhhoFKrx+y0eoTOjdbViU5J5wwVU=
Received: from DM3PR12CA0084.namprd12.prod.outlook.com (2603:10b6:0:57::28) by
 DM6PR12MB3419.namprd12.prod.outlook.com (2603:10b6:5:3c::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17; Tue, 2 Jun 2020 11:52:22 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::ad) by DM3PR12CA0084.outlook.office365.com
 (2603:10b6:0:57::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Tue, 2 Jun 2020 11:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3045.22 via Frontend Transport; Tue, 2 Jun 2020 11:52:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 2 Jun 2020
 06:52:20 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 2 Jun 2020
 06:52:20 -0500
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 2 Jun 2020 06:52:19 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
Date: Tue, 2 Jun 2020 19:53:42 +0800
Message-ID: <1591098822-12353-1-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966005)(6666004)(478600001)(426003)(2616005)(6916009)(26005)(7696005)(70586007)(2906002)(186003)(4744005)(86362001)(5660300002)(70206006)(82310400002)(82740400003)(81166007)(356005)(336012)(8936002)(8676002)(316002)(47076004)(4326008)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 288555c3-6cab-4532-029a-08d806eb689e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3419:
X-Microsoft-Antispam-PRVS: <DM6PR12MB341968B9E44CC698BFDF259D8F8B0@DM6PR12MB3419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFVQrdLexSugo0H9Smp6k9xJ13FwPEApPlvbMcsabOrqBPAJ2RPOM7R9S0lwaZt0Vrk2VIKROF/ZKFp5NQilvaJrMoBQCvOkxcLuH3iCi3AScdJu9AWejvQv0tgegk6tMJ5MxSovLYelMQjoCAM6xInYuFF/Ymmg9iI8gyF3Pfq3NKoEBvG6Kwo7nzjn2JYGairah2PcIkhMTT+xl6qs+kQ8SEN06lPxMWOYp9od4nzZruuRsJ6KCzozs0OK3hPe4CNI9dkC/PiY70Ta9NWkqoLSf98QmXxGua/FGARPVyHfzNlPzlWq30E+1zaa9D8/Ireow3GX3w0ixhLjQ11DXm97e5TUPFeC57TvwPZX5/afQypMnDehpyj5bH9lOYqNtdDYsnZJlvNKvDtAscPDuw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 11:52:21.4352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 288555c3-6cab-4532-029a-08d806eb689e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3419
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change-Id: Ic010440ef625f6f29e91f267a6f284f9b6554e1f
Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b6331712..fcbd875 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2004,6 +2004,9 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_init_data_exchange(adev);
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		adev->smu.pm_enabled = 0;
+
 	r = amdgpu_ib_pool_init(adev);
 	if (r) {
 		dev_err(adev->dev, "IB initialization failed (%d).\n", r);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
