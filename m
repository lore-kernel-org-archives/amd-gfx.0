Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C95C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 18:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204E120578
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 18:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Uo1Epe1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204E120578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D696E47E;
	Mon, 30 Mar 2020 18:00:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E3E56E47E
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 18:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpDbsd8sk7GfroAeF8uoqOtFjZydkuutaqvtK28jZY9z/BVxD8aDEGAH8VGFGc1Svov3JCZRWwo4DXi2KFEJpPNvECK3f/EvuytB7y+pioOPUCvpvdwVp8fISgTlZ+jKO7joHMbzXsvA3cqGHFhKwWkx0sE2mPSNPpygE2eYJLh1J6KXUo/QwG3VmN+iGQlNQcY5ORrzKyoGUo6cXcPzoRZYR5aeEs0oDo+/+itkJPqBg6aytN0FjZitKSSBWUaLVuWBfkYt40ktrm0G52wjYIf27UP+Jbf7PkvGrW6jq/LiVkzr1lmrbuoXh0hPZXLFCyC7vM+8NNP6XoAkPxY1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DrrlyMMfwq/SCa5GnlEk9mRvrwahynw9suR00rWwyo=;
 b=QpSworIzDFbk2C4QpmLCHOYgWXhPT1yH1Ym0fkZeCO1rcGyxJD9UuPKFtCVy9X1nlZtG/BzL5XvTYUHQWdjdQU7GoH8GPOMgR5tPsCMoUlk7q70fXl7yIVbCAcHt1FFrjoUUHUy3w1tbiEiLQagMKglxDvMpWd030v8gaNesZbdMk14FMHcZcpYlvpe35ahVACjboLaThwFHIbXklYIo28W7CASCG8XlMinWY/5N5yEBLbqKOuehgpKAWjoyO+A6vBsfVSplbsgFyO3UDsiP5MXhRoyF9kjqKM556xF/tzcmRpZECXZXFUN09ov79xrT5qJ3cESt1uXUeoLY73azug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DrrlyMMfwq/SCa5GnlEk9mRvrwahynw9suR00rWwyo=;
 b=Uo1Epe1D33Wuwy8OSqcDW1qjR42iQ7M+pyoTcHiDzKe+MVXqbq5SULz2xCcEUtz+2DlKFoDBz9Yt8mIfu3JE3jrYlfUgrEYE0zSm6q4ETudrTvynrNEpaBK48QUYLrLCW5Y6VfJjL+zRCmO6W/e7W54bGjSTAWEh3X5ENaREWxM=
Received: from BN6PR17CA0007.namprd17.prod.outlook.com (2603:10b6:404:65::17)
 by SN6PR12MB2701.namprd12.prod.outlook.com (2603:10b6:805:6f::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 18:00:52 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::43) by BN6PR17CA0007.outlook.office365.com
 (2603:10b6:404:65::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Mon, 30 Mar 2020 18:00:52 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2856.19 via Frontend Transport; Mon, 30 Mar 2020 18:00:52 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 30 Mar
 2020 13:00:52 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 30 Mar 2020 13:00:51 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd/display: Don't try hdcp1.4 when content_type is
 set to type1
Date: Mon, 30 Mar 2020 14:00:23 -0400
Message-ID: <20200330180025.21433-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(428003)(46966005)(70586007)(36756003)(82740400003)(47076004)(478600001)(2906002)(81166006)(8676002)(316002)(86362001)(81156014)(7696005)(70206006)(54906003)(110136005)(5660300002)(426003)(8936002)(186003)(336012)(4326008)(1076003)(356004)(2616005)(26005)(6666004)(2101003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69bebf70-0b9b-410b-91d4-08d7d4d4497a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2701:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2701817350E7235B188ADEA9F9CB0@SN6PR12MB2701.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0358535363
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z9CtuzoHXlsqXchuLlnydezC9PZ2E1KyW9/8PoSPDxYGcJAp16JqhODKVmlAVhE41Ny2GZywz797csaPjoBnQzmJTG8hL+ME/G3smuI+4T8jEvUirUw51Bj1MuFYiG6NC8ILyI0WUBbj3EsXhH8gR6bm87pNdSJByyomhWyiucdVVeDFgH0X3XoCk4SDfM43TAEzGkWaWl1lOAVAevSOc4TX65aMaOpZviRD2yaf2O0Q/Ea9WO359zLolHDoy3UO+9nyCp17E2E87LLrch34ClFY1OQPYoaGEW/Z/hpcj+0Yg9yi4sLxZlya3XUWLgFth5MVF0Uq9iwcHg1YLCUJYUou96HKODq8kgb9tLyRVPXD7y27Hhqsm98G9QNq41AhbvVHROsWWa1zW8JlFLQVjnMaOu8jC6s6MJUamdTcoJc8qIuzvbxPYbMh/FaxDjzmwemdCn7B8n0azDv92MucpOMZbaCAW4VYph0PnmEEbAxoS0FwY4eAoltyby20W8BWz5Wy6m7kCMihkbbUAj83oLwXS7y1WrzdLJMz76TQ1D0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 18:00:52.6709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bebf70-0b9b-410b-91d4-08d7d4d4497a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2701
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
When content type property is set to 1. We should enable hdcp2.2 and if we cant
then stop. Currently the way it works in DC is that if we fail hdcp2, we will
try hdcp1 after.

[How]
Use link config to force disable hdcp1.4 when type1 is set.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 5b70ed3cdb88..41fd1f5acff4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -192,10 +192,13 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 					    &hdcp_work->srm_version);
 
 			display->adjust.disable = 0;
-			if (content_type == DRM_MODE_HDCP_CONTENT_TYPE0)
+			if (content_type == DRM_MODE_HDCP_CONTENT_TYPE0) {
+				hdcp_w->link.adjust.hdcp1.disable = 0;
 				hdcp_w->link.adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_0;
-			else if (content_type == DRM_MODE_HDCP_CONTENT_TYPE1)
+			} else if (content_type == DRM_MODE_HDCP_CONTENT_TYPE1) {
+				hdcp_w->link.adjust.hdcp1.disable = 1;
 				hdcp_w->link.adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_1;
+			}
 
 			schedule_delayed_work(&hdcp_w->property_validate_dwork,
 					      msecs_to_jiffies(DRM_HDCP_CHECK_PERIOD_MS));
@@ -415,6 +418,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->dp.mst_supported = config->mst_supported;
 	display->adjust.disable = 1;
 	link->adjust.auth_delay = 2;
+	link->adjust.hdcp1.disable = 0;
 
 	hdcp_update_display(hdcp_work, link_index, aconnector, DRM_MODE_HDCP_CONTENT_TYPE0, false);
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
