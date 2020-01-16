Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E068C33CB8
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1502020663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kf0wYw7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1502020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E283C6E486;
	Thu, 16 Jan 2020 20:14:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2657C6E287
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQ6jC1XrsDzxa2ocSdJVPNqE5Wgr40gy89c0RNjTMei6hXvatJ9sHLv/Ht0DzVM2gZEEK5x4/GsXDP863tMgjb+yar6bOKNq30cGNvBCaQaDHDAwWZlRFsoKdbxxzYky+7wvVE8Fuw41jBHqWoiDQIbBjsc3SeIhIta/Cy2zGlCp9yHR4uqGnWrAkvhFlcK21yMdplIn3T9OzUUxycoOD6ucxe7UxBhW6Lv3ug0wdpoEzpw6EpaOYM7hspO0z1YniDMssVFl6MpyQhqG+9DjWOlZjEYFsgOJH6n2JC8wAWp6CKtDubPuQ/DDLYB6Z+28FGvFWkkeR/oivonzKAZ1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEzs9e+1GBs30kHxdP1Ykw2DHG3UtxOt8KJ0dSroYDw=;
 b=clgjuD01y92jpw2RozxGdphn5/k1tTK99DLpqXMrruXHf/s2oagPFxDOfjzozMPFAqqpvE1ElfqoWz7nbLmaSLuzzBChLkzJZCDwIceFXE1Lh9343ftJBNHJppVFo2FzZ/WvNHM8TX/i4wWM2l6UD7oDFdqWzxOWb0Pk1sKhElyQQwp+560wWbWU28f+6aHwBTsY1JjKNgiM8qXWZwnKxPQ1saSYn4kytgi/axwrO+VOhtIyC83e+/bgLmSuFtr3AtqwKIFM0Y99SnK9VwQOGgdTK9iTv9s7gfaMwYi0f28hZcjxmSmCMqID86I6Kww2TY++2+gJREI4oV8aohh9dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEzs9e+1GBs30kHxdP1Ykw2DHG3UtxOt8KJ0dSroYDw=;
 b=kf0wYw7AOLDUKlAIQ/fDa8LhvnGX3vcshhxjmm2pcPbFv738PTmI2/McEJWCPYMGIhgk7lhkiefoiTfRxyG9pe+gn/xJSx06rELL08feuB9FmCPwRadUdi2H3FaKJ4ot0zDqMAaO3hgM6e3nOf7bLsomsU/oXgSMdpsk5C8fKYE=
Received: from DM5PR12CA0010.namprd12.prod.outlook.com (2603:10b6:4:1::20) by
 SN1PR12MB2590.namprd12.prod.outlook.com (2603:10b6:802:2e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 20:14:36 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by DM5PR12CA0010.outlook.office365.com
 (2603:10b6:4:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:36 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:30 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:29 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:29 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/22] drm/amd/display: Add hardware reset interface for DMUB
 service
Date: Thu, 16 Jan 2020 15:14:11 -0500
Message-ID: <20200116201418.2254-16-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(428003)(189003)(199004)(356004)(8936002)(81156014)(86362001)(81166006)(2906002)(8676002)(36756003)(186003)(5660300002)(1076003)(26005)(70206006)(70586007)(478600001)(6916009)(336012)(316002)(54906003)(426003)(2616005)(6666004)(4326008)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2590; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a582b17-ed4e-4b83-e30e-08d79ac0b532
X-MS-TrafficTypeDiagnostic: SN1PR12MB2590:
X-Microsoft-Antispam-PRVS: <SN1PR12MB25906184DBD983C03749B846F9360@SN1PR12MB2590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvwkk2kaUZn7ycFLkn7SvhDx8WEe19TDgRidg/n30ozrNU3eHva3W+IchGhMKFh6VaJs6lQgNNK3fIfCr8+d+3hlSIETl/sXfdUj7POLAbZQHTE7QDVRCM64SjgFELq0LibigcUBbmaRlGcmIIyarsKkEIxNgCu9Sc2TQq521qH619WDp/6jKpFpZEkPSCyXLVF58ak74a3hi07OeKfreI8I9t5R3o2FO+0WRHvkdmb/VaBDfVXOSukqze9L5VG1+SabfXvqi2AjMs8LsEOvJR6GH/nIDGEoxF9fMN0ANZm5YqM+gvogv31h/HoKhyvFAAq2WYg8aGLQtfBKh8VDDrBsxOQhD9a9MNkBnX7jzq/wpXKwO+fUH3qSwSckiSbcoIpBUWIaNFdtS0A2AI7MXgAx2ylZLHCfnTvZrn4Pz3RBp3S6lr0kNdMdTPm4ZXOm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:35.9593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a582b17-ed4e-4b83-e30e-08d79ac0b532
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2590
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We'll need this to perform a clean shutdown before unloading the driver.

[How]
It will call reset internally and set hw_init to false. It won't do
anything if the hardware isn't initialized.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h | 15 +++++++++++++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 16 ++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
index 287fb9a36a64..f8917594036a 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
@@ -418,6 +418,21 @@ enum dmub_status dmub_srv_is_hw_init(struct dmub_srv *dmub, bool *is_hw_init);
 enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 				  const struct dmub_srv_hw_params *params);
 
+/**
+ * dmub_srv_hw_reset() - puts the DMUB hardware in reset state if initialized
+ * @dmub: the dmub service
+ *
+ * Before destroying the DMUB service or releasing the backing framebuffer
+ * memory we'll need to put the DMCUB into reset first.
+ *
+ * A subsequent call to dmub_srv_hw_init() will re-enable the DMCUB.
+ *
+ * Return:
+ *   DMUB_STATUS_OK - success
+ *   DMUB_STATUS_INVALID - unspecified error
+ */
+enum dmub_status dmub_srv_hw_reset(struct dmub_srv *dmub);
+
 /**
  * dmub_srv_cmd_queue() - queues a command to the DMUB
  * @dmub: the dmub service
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index dee676335d73..ea99d4cf34cc 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -415,6 +415,22 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	return DMUB_STATUS_OK;
 }
 
+enum dmub_status dmub_srv_hw_reset(struct dmub_srv *dmub)
+{
+	if (!dmub->sw_init)
+		return DMUB_STATUS_INVALID;
+
+	if (dmub->hw_init == false)
+		return DMUB_STATUS_OK;
+
+	if (dmub->hw_funcs.reset)
+		dmub->hw_funcs.reset(dmub);
+
+	dmub->hw_init = false;
+
+	return DMUB_STATUS_OK;
+}
+
 enum dmub_status dmub_srv_cmd_queue(struct dmub_srv *dmub,
 				    const struct dmub_cmd_header *cmd)
 {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
