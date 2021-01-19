Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400ADC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 09:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F6123100
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 09:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F6123100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F98B89BE8;
	Tue, 19 Jan 2021 09:07:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5C1789BE8
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 09:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCDnZwZ4+LrmfBjQNDykTVx3BWhZ42rl+8cJvJi3QXrGY6oziUcEETNM/ZT71m0ND+2kzHvKFx9rWFi2YlOtK37GzULNZvwX+Alv89D5LrCu5cG5flLQcdbtSH8Aw1noFG4LrWCf17sokwNckCwlY7q0aj1VcyOvcH1vKNFo66ayS91QoahehHfiYkBvf98EoCADCTfAQ1oxgZyCFs4w7/8IQ7ARJSfn4Vp8mnDhRySprhRaQOH6LT0h0sWSOVPNm0PsiercTgYbGDYDrKNAmge0An2Ih4FwMmpOAyPasqXix0ZJQyNdFR7ACGJyvJdXQ6gyYJMpzOxPJkgsaZQ5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhwRW1HTLJ6+J8WpdI4wlBJ6w3nYnfSz0JS6qit80zw=;
 b=mduw4nd2NT+SB1bpoxVEQ6gK+qXfMcU9N9/A4BcIKStVuZkYKmL0v7gbtZzCexdUsl9HZJfqrkvg6Dcrd5TcvAfviO9A+dtqUq102tr+4Dzk0wdBr6NIATdUnhdDkjI3NtFF3CQik5m3WR+3OxVdHEs1dmcZT5WuYFTPWEVzoGWNQakPC49iUuA+6DPPgg3s+kZDoKxf+iR4r4Us1TDizzIyvtHujF7BRWp1m71V0RjlbwierQ7NINopj3iTj3RLazbVnUfEKr+G9QsRh4l6+0/aDgb8CQpX1pzg8jNAi1Y9OGCbdSNRJqnH6JuG1WzTble7KpUkeepGDFnNkXkQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhwRW1HTLJ6+J8WpdI4wlBJ6w3nYnfSz0JS6qit80zw=;
 b=yE0cWCDmqHF/5ylaezTPkLdTroLWhQlm386gVirUNcG2FTbjh8dHC+NHtmPn0TW27rY7IlkvplYzmgb3siANxiIGuv9hci5Cxfem4aNSyT67CSdwmbjgP/pjmN9mwoCZEMDHqSSk/KDCdFTE7NHW//eBKTKAxPp845Hj0JpI2mg=
Received: from BN0PR04CA0097.namprd04.prod.outlook.com (2603:10b6:408:ec::12)
 by CH2PR12MB3862.namprd12.prod.outlook.com (2603:10b6:610:21::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Tue, 19 Jan
 2021 09:06:57 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::b1) by BN0PR04CA0097.outlook.office365.com
 (2603:10b6:408:ec::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11 via Frontend
 Transport; Tue, 19 Jan 2021 09:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Tue, 19 Jan 2021 09:06:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 19 Jan
 2021 03:06:53 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 19 Jan
 2021 03:06:52 -0600
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 19 Jan 2021 03:06:46 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: add error handling to
 amdgpu_virt_read_pf2vf_data
Date: Tue, 19 Jan 2021 17:06:42 +0800
Message-ID: <20210119090642.3311634-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a1dfc7b-40d5-45b6-2a85-08d8bc5991ba
X-MS-TrafficTypeDiagnostic: CH2PR12MB3862:
X-Microsoft-Antispam-PRVS: <CH2PR12MB38620DAF030ED8F77A887647B7A30@CH2PR12MB3862.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55DDZl55KODdhEdHgxC/bwzuBAtc1zRw9CZUGl6sZJzfRyDOzyKZODmZ1pioDBRuNDgFoA5gtn2crhqMXdztUlg0wbb51sulBSdkT7Hj9/JzAxXjVNpnJT0/70YphwXP2rDYonPetKvkHXxtQ0mygZoYn7Hy/tRfIaQBcjFq8QrJzrQCoQkiwim61DyDSBfwFaGHjhruEtnzLeh8HnRUeOFgbTKavA8ZIVHEfg3tcIeBTenC/c6wOL1ZFTcs7M6G29NUYZL1Pjj0DcZ2eY5zgyu8cCU+IaVzS9OM9auCEP8+0fioQEaI9zPGgN3PUkK/R3FPJ67tRHjkecmMmQ4U39PG4ltKAaLyUSqosYY/SuV/fGdj7EnweRhxdZGrsmRqs4wL7AGY0kVdoF/Mp+MQI+W9esoLetyvJ7fggE4toiEJHaH07T6SF4TrdhoIZ+tyfJPNtyTF4pGUsHEzrh7nOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(426003)(478600001)(356005)(47076005)(8936002)(82310400003)(2906002)(54906003)(6916009)(316002)(70586007)(70206006)(6666004)(336012)(36756003)(8676002)(1076003)(82740400003)(86362001)(4326008)(26005)(5660300002)(83380400001)(7696005)(81166007)(186003)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 09:06:55.5493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1dfc7b-40d5-45b6-2a85-08d8bc5991ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3862
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
when vram lost happened in guest, try to write vram can lead to
kernel stuck.

[How]
When the readback data is invalid, don't do write work, directly
reschedule a new work.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index c649944e49da..3dd7eec52344 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -558,10 +558,14 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 {
 	struct amdgpu_device *adev = container_of(work, struct amdgpu_device, virt.vf2pf_work.work);
+	int ret;
 
-	amdgpu_virt_read_pf2vf_data(adev);
+	ret = amdgpu_virt_read_pf2vf_data(adev);
+	if (ret)
+		goto out;
 	amdgpu_virt_write_vf2pf_data(adev);
 
+out:
 	schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_interval_ms);
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
