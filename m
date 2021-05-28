Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32216C47087
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 23:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E114261132
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 23:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E114261132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 890AC6F635;
	Fri, 28 May 2021 23:06:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 735F26F635
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 23:06:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B40EUMYk/F2KHWu/VH6Pf1bxYPd/Z8ZCq+Pa8b1+u/PDExoIl10r4zFPoqfa81ANKbf+G8OXcFTV0FX+MwqL/I3/vXZ8RO/B5vWItgPbkRCE5vcHSyDWL2wY8Mu+SpAsMV2iE6DNyCYwhpnI+6SZx1zFd/MRnT1t1jnCVqdVgXypJ9SXP8EwwXMjhgWSaVZYLDNWP2Xq67d4gj7r8If5j9HkOE8pfeiwXQg35OKytA89cvFlZ5nQprPJDZetseccn5jkFhvMXCPsHF2ghStyKTJ/P330NwQA4tWOqX/erMcQWp+VwsTjxei6K/0Nr79xnZ22sPeVH7Pk1lKHXyfGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvcQ0AnrCUi5UGdiJ3FEl7eec03v8D2TEBVghxBpCaU=;
 b=DgyqarM0qiuLklT9TzNGwMiqBX7c6e2SmoD8PsQKZqhlAfLyLWlStfnAOZEQ81SG2n9ct+FfLbmI2AVAQZnVCBNtV0moQOippTkSrRrCJ2DzbCI6WDgKouAyWHWv/i1V/y1OJg01JHRfN8spG+0jaDVSoHNlO2neLXWW9mmRYy+MZ5pr4dBxfItgmS+fgyICSZiLFvpJcwvDr/CmTVmu4LvUg0co26GfribVKmSUG+vMUxgZrBBg0tVHmEoaOulRwUw2io0RjXGDHMd8sHA1DTgyRLLxMYcoQTRMsjpG+fZYUsBskXvK+dhwYvF5tUN1RnZgYYU1+oLIkwMNZ6tiKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvcQ0AnrCUi5UGdiJ3FEl7eec03v8D2TEBVghxBpCaU=;
 b=ESxTkcrM7ld4cUjGCG+12E9MQJa/5PVsy+FgJPiyBdTWBaPe1m6ZUfCIZgU6jJb/zSgSswMyCO0mtjFY0XdJkljibByLvPqrWZTWblF4FhReGDvN11E7+yE7Y201OcferRRNvYcJMeogObwA12KtjG5cjQ5ytcfQ/J44SUI5QCs=
Received: from MWHPR04CA0052.namprd04.prod.outlook.com (2603:10b6:300:6c::14)
 by BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Fri, 28 May
 2021 23:06:42 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::72) by MWHPR04CA0052.outlook.office365.com
 (2603:10b6:300:6c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 23:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 23:06:42 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 28 May 2021 18:06:39 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] amdgpu/pm: add kernel documentation for
 smu_get_power_limit
Date: Fri, 28 May 2021 19:06:21 -0400
Message-ID: <20210528230621.16468-7-darren.powell@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528230621.16468-1-darren.powell@amd.com>
References: <20210528230621.16468-1-darren.powell@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a33501e-1c7e-4e07-5b4e-08d9222d41ee
X-MS-TrafficTypeDiagnostic: BN9PR12MB5130:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5130E118CBE9A4338B2F34DDF0229@BN9PR12MB5130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhqNyMIw/e+Qh4wytPjTDVLMnFd8eu5PZsbDGRnaE1Lf8B2YtOeT0wTsZN94wQn0Ni+me7tTO9zH5MaOhngbqzbINRJ32vVf6A1TQem97KcDY94ubZPwI9eFBPOYVKtBLL9BFTV29C2WXB95pbsexg5ICL/zx+ePgK5FRrkpLLAKUDAeOpahrdsGnSbO5JyCnDWinkcw8HNuWmIFCZic9eRM+DYxws9F2B7z/WagEOQlaDNe/xZNjb06g9cMRAz7cInDSOYxYI70Z34X00twgz7ZHnwgIYDfyIKj0HG5Ut7HhgIgOj2MMEsOK2SVRHYI499sI2+98A0L1skqBVJUtsAZme1itoFiOBkJu4EvXBGIpNRNRI+a2AQUffbE6/n0laD4gw/QO0DbhdbWbEXGo5easgyyHUcGEDFqqLwv9W07OnehRcKJ8CeTebMVaZQl5c0o+iMODmKim9MVdXKGtb/oqMDmqMxFbAAnh+u1KiVkPQIodQ5AtKzocjumI/XVHWv3rWe+9TRj2ZZonYW8BGh+hydkcLSlbOcy3k3Kz42Q9OPzdBZsSHdeTve6uBy2C+ZRxhD6zAN/2ME0/6cauW6U77LqC8VSe/ffjOc/OVFHrrT5+AC65gpxhHEJ/a/iRy8V7Wp2PgJ/FVtAmszSoyIyXN5dax90Q/1vS/IPGDmbcITrAPSRDpGc5jWg4Efu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966006)(36840700001)(47076005)(426003)(36756003)(6666004)(2906002)(356005)(44832011)(2616005)(86362001)(6916009)(7696005)(83380400001)(81166007)(82740400003)(70206006)(70586007)(336012)(5660300002)(8936002)(26005)(316002)(186003)(16526019)(8676002)(478600001)(4326008)(82310400003)(1076003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 23:06:42.2999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a33501e-1c7e-4e07-5b4e-08d9222d41ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 added doc tag "amdgpu_pp_power" with description
 added tags for enums  pp_power_limit_level, pp_power_sample_window
 added tag for function smu_get_power_limit

Test:
* Temporary insertion into Documentation/gpu/amdgpu.rst
------------START------------
Power Limit
-----------
.. kernel-doc:: drivers/gpu/drm/amd/include/kgd_pp_interface.h
   :doc: amdgpu_pp_power

.. kernel-doc:: drivers/gpu/drm/amd/include/kgd_pp_interface.h
   :identifiers: pp_power_limit_level

.. kernel-doc:: drivers/gpu/drm/amd/include/kgd_pp_interface.h
   :identifiers: pp_power_sample_window

.. kernel-doc:: drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
   :identifiers: smu_get_power_limit
-------------END-------------

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 30 ++++++++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 +++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 369a72f03e92..46d2fc434e24 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -192,6 +192,26 @@ enum pp_df_cstate {
 	DF_CSTATE_ALLOW,
 };
 
+/**
+ * DOC: amdgpu_pp_power
+ *
+ * APU power is managed to system-level requirements through the PPT
+ * (package power tracking) feature. PPT is intended to limit power to the
+ * requirements of the power source and could be dynamically updated to
+ * maximize APU performance within the system power budget.
+ *
+ * Two windows of power measurement can be requested, where supported, with
+ * :c:type:`enum pp_power_sample_window <pp_power_sample_window>`.
+ */
+
+/**
+ * enum pp_power_limit_level - Used to query the power limits
+ *
+ * @PP_PWR_LIMIT_MIN: Minimum Power Limit
+ * @PP_PWR_LIMIT_CURRENT: Current Power Limit
+ * @PP_PWR_LIMIT_DEFAULT: Default Power Limit
+ * @PP_PWR_LIMIT_MAX: Maximum Power Limit
+ */
 enum pp_power_limit_level
 {
 	PP_PWR_LIMIT_MIN = -1,
@@ -200,7 +220,15 @@ enum pp_power_limit_level
 	PP_PWR_LIMIT_MAX,
 };
 
- enum pp_power_sample_window
+/**
+ * enum pp_power_sample_window - Used to specify the window size of the requested power
+ *
+ * @PP_PWR_WINDOW_DEFAULT: manages the configurable, thermally significant
+ * moving average of APU power (default ~5000 ms).
+ * @PP_PWR_WINDOW_FAST: manages the ~10 ms moving average of APU power,
+ * where supported.
+ */
+enum pp_power_sample_window
 {
 	PP_PWR_WINDOW_DEFAULT,
 	PP_PWR_WINDOW_FAST,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5671abd58bcf..b7a9037a2dbc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2166,6 +2166,16 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	return ret;
 }
 
+/**
+ * smu_get_power_limit - Request one of the SMU Power Limits
+ *
+ * @handle: pointer to smu context
+ * @limit: requested limit is written back to this variable
+ * @pp_limit_level: &pp_power_limit_level which power limit to return
+ * @sample_window: &pp_power_sample_window measurement window
+ * Return:  0 on success, <0 on error
+ *
+ */
 int smu_get_power_limit(void *handle,
 			uint32_t *limit,
 			enum pp_power_limit_level pp_limit_level,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
