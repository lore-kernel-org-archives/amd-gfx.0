Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3131C433E6
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 02:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C7922D75
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 02:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C7922D75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04BC86E3DB;
	Thu,  7 Jan 2021 02:51:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 054CE6E3DB
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 02:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fl9niooFe3bxr9cHTGEgZ2uw7jgVGTQReNk6eja1VXuVsQkvnJySDGV11+enar5rgOnVKk+lx01ciAKmL0+l0SUEIT3PNA2VnD4TeCsDSltAAqf28FbLoPQwf1EPBqcixIFzS1sXnlI44u7CI2Lq8vcoSLn3x+/9NMLhIg0q2O1xd1plZ+/jG8KEKtapFvZYXpFOLLxtsbvgHqzWUzzetyY2eSWBvIWo2XiFquRiWA3/OHEzwm6xgSg5JCvH9fqF5JWEAh9yTkFje/JtNWI9Gp/SqMkP2D9vuO2Gh9iBIzCqcg3gmXPyylQ55td8ogBxJANdTkUFRHNy5LBOkRQEaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UIim6b2smR0vC+nSic5YMlRW97FDRXVlV7AjgSZkJM=;
 b=XEk/dWSu2POA7hWy17nkA4ZiaG9Bn10+9Gs/yVYJN4qCcQHd1wLxiq7XTZq0WHvIGiDxBwvHHGYktwSGOfUiel4uzDkIytjVwYn9DAXuojzmVGiiObSDZG4VLMQIYTAyG1JI5diyqpJSSj6+xiYfXGY0TSllWUvT0LdJvy/UW+QyLxtGj/Jf3Sq77U61WbgQBaq0Z0WcHOkDwejVQ/SzNjfk9v3isyGdXtC+duJtFMxckQIy9twUfGNz1UTKJrk/LxhUMnSK673tRztnzbWRma8lAJ3XaGt4mUVOm3lHSnHRskciS3rtCIIpkYvFL96jF07dPETlAL+TYn74qBi14Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UIim6b2smR0vC+nSic5YMlRW97FDRXVlV7AjgSZkJM=;
 b=TtjPDiiniooVzPbXwD1AAklZUondD+GjIlMvzjHFRr3ZebdaEZNMJKfQPskcDYH5ZL8XRXeC+8ww71kv+gTXOFGhaXXFKc3UqwjItAHGT2j5DQ4hocAeM9L8QT6DisEfpLmqzuCHneGsT/AKdubtRnxeMbV9xIkBES/br3IewMA=
Received: from DM5PR08CA0043.namprd08.prod.outlook.com (2603:10b6:4:60::32) by
 CY4PR1201MB0245.namprd12.prod.outlook.com (2603:10b6:910:1e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.23; Thu, 7 Jan
 2021 02:51:14 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::72) by DM5PR08CA0043.outlook.office365.com
 (2603:10b6:4:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Thu, 7 Jan 2021 02:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 02:51:13 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 6 Jan 2021
 20:51:12 -0600
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 6 Jan 2021 20:51:11 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Decrease compute timeout to 10 s for sriov
 multiple VF
Date: Thu, 7 Jan 2021 10:51:09 +0800
Message-ID: <20210107025109.605633-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db6f4b95-cd6e-4727-6d09-08d8b2b71894
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0245:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02452A9FCD0FB7E35078A6688FAF0@CY4PR1201MB0245.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCkBSHlpfRW9q4kjuoILM16AmCLS5D2h5rCXHdJiKYtrjqHJlJ1vIWkExPuVU9+ctRmMcFX+MN990FB2WSXImvuLek4uJEqpvUPBZ9MVerKycYG/QwDGmkYAme5UFTYJvuz61kDz0WQxIfRoes7rFJ42ksIOOjH7ndfAmh/CpeChsZcuRNUEjPU3g3oyrWecyDugBCBTqlbXB8aHPNUvKTSBSWvyX6g5eHIApb/cKmZ6iqV7vrXaLCijD6DH9LypUF3lqqGiXr56LgZeQ9lfpycWavPom8VaaYeZDCdU30VSvlMzMqmU6aw5gIzNSIo55QFLzgMBxlyBynk+VXV+hyMJbvtem/Zs27EPmqBVC2MBKZwmac0vifSYeDa3CzsSYNJRPpYHrR3ANTCMYkq8DZ5Z1FjHB3SoNSh/SGsk3bbVaFS48irLJ5JatogVXAMbDnTbNMsuXxqq0RTsIg7fmZmgUPxQMccrRXR7qG6Wpq1/brXhuKJeR/wjktDKqNvm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(2906002)(83380400001)(4326008)(426003)(47076005)(6916009)(5660300002)(34020700004)(82310400003)(70206006)(86362001)(2616005)(316002)(36756003)(26005)(82740400003)(478600001)(70586007)(1076003)(356005)(8936002)(336012)(8676002)(81166007)(186003)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 02:51:13.2305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6f4b95-cd6e-4727-6d09-08d8b2b71894
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0245
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Emily.Deng" <Emily.Deng@amd.com>

For multiple VF, after engine hang,as host driver will first
encounter FLR, so has no meanning to set compute to 60s.

v2:
   Refine the patch and comment

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5527c549db82..35edf58c825d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3133,7 +3133,10 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	 */
 	adev->gfx_timeout = msecs_to_jiffies(10000);
 	adev->sdma_timeout = adev->video_timeout = adev->gfx_timeout;
-	if (amdgpu_sriov_vf(adev) || amdgpu_passthrough(adev))
+	if (amdgpu_sriov_vf(adev))
+		adev->compute_timeout = amdgpu_sriov_is_pp_one_vf(adev) ?
+					msecs_to_jiffies(60000) : msecs_to_jiffies(10000);
+	else if (amdgpu_passthrough(adev))
 		adev->compute_timeout =  msecs_to_jiffies(60000);
 	else
 		adev->compute_timeout = MAX_SCHEDULE_TIMEOUT;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
