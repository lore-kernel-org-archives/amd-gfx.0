Return-Path: <SRS0=AYlF=LA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDECC4743E
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jun 2021 05:00:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E101E61420
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jun 2021 05:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E101E61420
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A74676E52D;
	Sun,  6 Jun 2021 05:00:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07656E52D
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Jun 2021 05:00:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pr/8Jc3xzfFIGGDw9ZfF1+/O7X5VNSAEXTnnwly3GQKtiqFftomAUIOCMh1w+WIhoF8iMZZgv6KrUs4YA9n8Oj6keSuJwtga9mMRIM8pcTQ+RnvgR5ZFzBqbXjUiZ91sI0NEvCGXXnzyS2nvT4C2AslIi0dVYYv/yU/7NlFsGmTLcyZf+wmiTurbwRPJ79x8duDSF8qc/zbaDFL/Ft8BCZdk4OeltfNKZeyNTYVOr4oDF20GzTZhXiABzelGLLJUitqsjiijU0HkW9yIKtg0sv0LDXXlt7B6eE76Do0jLPJgKhZZ0EDho/DTfsC1aU1rUBsCCbacTw0gnHef/CLQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vo7cEEREoFFIL0MpmKew+aPle199Aih6dUDU67rFrwo=;
 b=FlYkfR60u9ZhCFg5KjXfK3sKgolNpH11za3UmNFdG+dscoZsKWS+1C2kMh0tJjydX1Ql+kmgt78XTH8i2g0qc9I9REx4aPQTpUUNvYqkTQxZDBUTj7o/jI+amQYOB2cOWWPziUj3BKusnS2vRPY7nH3WCSd7m54SUu97hwsnX1+5LEi2ck8e0i2leDTJcKMsjxenY6w1g45EYOlaZbNNESHF/83UO8yWq8YLgFugrwtKYkczd6NH3ivAzn8LS3286OpQFBM+rjrlqBgDK7jHXeqvOh9eSV/rYMOeu4UUf8//yaMBPG8vq4vpzz92r+KIfwfrKz8ASePuuscGgQC8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vo7cEEREoFFIL0MpmKew+aPle199Aih6dUDU67rFrwo=;
 b=iMeFBffqb99NQc2+hwBrp1eKyPWShOBKKvhbwP1cLE85cbRSK47r+SUr5cDPhaMXGrVEto0fkS1bTqFpgLyO/4tZh82Qvh6nISw8ISN6EU0OWV8eM0pmKxd1M2Kx/oLUtQwsyHcMQxVxOW/5+f2/pS3rHreD35TonuVJwYktesI=
Received: from MW4PR03CA0312.namprd03.prod.outlook.com (2603:10b6:303:dd::17)
 by BYAPR12MB3303.namprd12.prod.outlook.com (2603:10b6:a03:131::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Sun, 6 Jun
 2021 05:00:48 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::ab) by MW4PR03CA0312.outlook.office365.com
 (2603:10b6:303:dd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Sun, 6 Jun 2021 05:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 05:00:47 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 6 Jun 2021 00:00:44 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] amdgpu/pm: add kernel documentation for
 smu_get_power_limit
Date: Sun, 6 Jun 2021 01:00:23 -0400
Message-ID: <20210606050023.4124-7-darren.powell@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210606050023.4124-1-darren.powell@amd.com>
References: <20210606050023.4124-1-darren.powell@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20767f6a-4a0a-47fb-8045-08d928a80ca7
X-MS-TrafficTypeDiagnostic: BYAPR12MB3303:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3303F74C34E733D33F9AB007F0399@BYAPR12MB3303.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsaPOiAP1X3ufKfjPuslFA76fzm2/1eRvnP46jfZTc28xP3a1ce08/AFISr3zdnkkESt6dNdezV1BbpW4zIGd31U+u14pJLKg2CKQU5YPGi9ypVkPp9/DOQ5rSkxRmo3n7L/Gxb2WF+459lBXQlHoRsRUTklk7/hBAduN2j7bNZYonQxX1MTs1meu7j83NzW2Xyvdp4dOpoePct1PSxObm4eh/ogHQz1v4/+5hwO9uMJd0NjYPD6FdAof2w8WTYrGubltgLEWu04Z6MT4lAUjGd8M3tZRTBjUg+gVHBj6SkI0BfsHHZZ2VW6WD+vMrG4sCSfONV9mU+Yey9uJxs/BSSGUX+xGtFLr3jI+pLZAskhOrD7GJNxAz6qJK2esGxb0wkxEC4N/2s3+QN1pOhCAjpWHErqGx+gh5zQC5gTx5c2ziv3zefRcd4DkpryIV+POublpx9BznpFNk1KLKr5iyYamoq+rt6ndyK2rp0NZvxPtno8YXHndFMgCmAZ6izMwUTQ3aqkNd2JkO0dNY4diqaRiO9n7hIBycw65/Ib9tjtaKX36XuqUc9axEDhIzxVOgcEEa7ocxUKBUzrka+1BwBIj/Bn384LeNIBm45qR1oamDgkVnVAqEgwgTtPqLoEc1KuknuBjCvVgyVbFTrVTLwHY7eqzA39BTg2zR1px1rGYOz+JMY/HF1vkLLF87xI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(36840700001)(70586007)(316002)(47076005)(186003)(26005)(16526019)(7696005)(1076003)(2906002)(36860700001)(44832011)(336012)(4326008)(2616005)(36756003)(8676002)(8936002)(426003)(82740400003)(81166007)(356005)(82310400003)(83380400001)(70206006)(478600001)(6916009)(86362001)(6666004)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 05:00:47.9957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20767f6a-4a0a-47fb-8045-08d928a80ca7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3303
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
 added tags for enums  pp_power_limit_level, pp_power_type
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
   :identifiers: pp_power_type

.. kernel-doc:: drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
   :identifiers: smu_get_power_limit
-------------END-------------

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 28 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 +++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 62559723bcb9..9f73a2f586d8 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -194,6 +194,26 @@ enum pp_df_cstate {
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
+ * Two types of power measurement can be requested, where supported, with
+ * :c:type:`enum pp_power_type <pp_power_type>`.
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
@@ -202,6 +222,14 @@ enum pp_power_limit_level
 	PP_PWR_LIMIT_MAX,
 };
 
+/**
+ * enum pp_power_type - Used to specify the type of the requested power
+ *
+ * @PP_PWR_TYPE_SUSTAINED: manages the configurable, thermally significant
+ * moving average of APU power (default ~5000 ms).
+ * @PP_PWR_TYPE_FAST: manages the ~10 ms moving average of APU power,
+ * where supported.
+ */
 enum pp_power_type
 {
 	PP_PWR_TYPE_SUSTAINED,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c9b921cd48cd..b4ea8b233240 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2173,6 +2173,16 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	return ret;
 }
 
+/**
+ * smu_get_power_limit - Request one of the SMU Power Limits
+ *
+ * @handle: pointer to smu context
+ * @limit: requested limit is written back to this variable
+ * @pp_limit_level: &pp_power_limit_level which limit of the power to return
+ * @pp_power_type: &pp_power_type type of power
+ * Return:  0 on success, <0 on error
+ *
+ */
 int smu_get_power_limit(void *handle,
 			uint32_t *limit,
 			enum pp_power_limit_level pp_limit_level,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
