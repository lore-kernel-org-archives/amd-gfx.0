Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C202C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 09:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244366124B
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 09:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244366124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6BAE6F5F8;
	Fri,  4 Jun 2021 09:59:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF1916F5F8
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 09:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/4P048D1aWCnFPJkoHsb80hoy2GAAQKdIAWoBFVsVzI7o0WewXzgVsgM6cCukr5Lcgs+JnBmRSPTHglf8vFw3eS8sGJ2mWWtNueZXcdULR6Fz0dmIiQY2Ps0plkEPxoD8yu6obZZY3ynQuDlD0Y2Reb1MlUU/PAy/zuSvQjrF6/2YhouYrnP3sYK3kGqL26w2rF6Ct0bEcwd6Fu2YHYHqz8EAV4xN07tqi/VloJi+KGJwuzlj5Uo9+Xfjm0qSzCvOIaO7eeV8o2WG3W8+IqIXrGPCsR9R4qWD6FzujSZJtbJRAN2GN8Ocmo5PAd9qmXDaikmyr4RGyitHvLnFrAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XgvWSjQaYTrn3Q/MThdL5xnbQtW8SqU3qhRxesig3o=;
 b=m/6HW4+UdzkGgFJ7DN3QdryCQp4mCMtCnxle0YQQLRx/oYhPxdIEwRcQCWC9zzsSNTu2+HbvV/T31qx+ikP3vmV5tpQgrkdxQnPna6BtSc4FQu71PH3Iqg67eQ1ql5CjUI3UKAFA1bZzuIQhvdJWjhxMpqG4VL9cszdox245aFE4NUFxrLxuOp8v76FniFvQPJsg1bgvuh8wQ2J+uJcm0Ol2uqDEIdWaa7nSb9Fl2PgsaJDm+f7NExpXTkihND1THlaclUFPZ747BW+/db/kbbg63deZKVSN7H0PQdM4vMgxVmw8S0Bu+CXXg3oKL4dYuje8lv7zpSHAyvAJbAnGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XgvWSjQaYTrn3Q/MThdL5xnbQtW8SqU3qhRxesig3o=;
 b=B9q1Rq8znUS44KEdfmomRs4J74zvjq632eqBQ3YRljsmw1CfAmIyPLoGJihL2KYvnekhiAvhq9YEKvZGlvr9oZGZ9j0X73T93eoJfeVkIAoiYCJXB0CHBPrScPbV6NX9Uw72YjwdaSKc0t179ZF6xHHniyXR++ZGzSPpJjKvMuk=
Received: from BN9PR03CA0106.namprd03.prod.outlook.com (2603:10b6:408:fd::21)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 09:59:26 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::42) by BN9PR03CA0106.outlook.office365.com
 (2603:10b6:408:fd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Fri, 4 Jun 2021 09:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 09:59:26 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 4 Jun 2021
 04:59:25 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 5/5] drm/amd/pm: correct the dpm features disablement for
 Navi1x
Date: Fri, 4 Jun 2021 17:58:23 +0800
Message-ID: <20210604095823.1403271-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210604095823.1403271-1-evan.quan@amd.com>
References: <20210604095823.1403271-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7454cf4-44a6-4d07-94fe-08d9273f702c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4341:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4341E39F58D30B34E7747836E43B9@MN2PR12MB4341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZN9I0nugTYSC3gd/gHo8Qkctapck9p0DXAuvEjQ4GO8knvfUUz8r1MCBgtI/sDMhGr9xXXrlYFZGi0qsW0Pp1jQ2xjz0I8+cujq07eCxDYDRZCEqdk7AN7cen1aTFU7yVJSb5Bqg2wu7jAuQ3b5SF0/2747j7uQ1HxoNZvOp8IOro4MSrHg1CpUSHowyDtAIFgpnrAD4thF+3mdTS/jTm9eFTe4ZrYnQpooFKwmDo5PFMpgzIZpOylfBMrrAOrV5halEAuc2jPMlrC4ReTP82HqeTvj+fdK4/4T7t/BPIUJ+01SQhO4u6xYSjdWoYpvsiexSGWewfJMjcEXYRw7H5aSVBX0RXJAhSVVGJYGid77indFUs0WF0QExmuAhKUakUS9gJNlCpjDmHNpT7KnmONatgEe8KYixpci9dt1nl6/GUoM8WbEShyifIyec1tr3R+qhJ6oZKvIC3CZpQWBZ0k6HR2X5jGmr6t3PbYvtHC6GR1I4jveoe+AB72KBo44L1o5T44XQnUewnIxnFr20yEzThSCuWIfMIdNggs7NhvCUUITDwZzss6WJO+f5TXDZMOGpHyveTNgInnIGREOm7DtsNL752auaKb++m/51547pzZCiPEZsQ2rX8q7WfMyoqvzgyD8lA6IOAjluN5Kzc+CzFMrKfxHZbrclUp0B5s6AE57RHWU3cb6FDh4awpMErBhhIheQEUKdiFkAme6PDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(136003)(396003)(376002)(46966006)(36840700001)(8936002)(316002)(26005)(47076005)(336012)(2906002)(81166007)(478600001)(86362001)(2616005)(8676002)(82310400003)(6916009)(36756003)(4326008)(44832011)(426003)(7696005)(70586007)(70206006)(5660300002)(1076003)(16526019)(186003)(54906003)(82740400003)(36860700001)(83380400001)(356005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 09:59:26.7588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7454cf4-44a6-4d07-94fe-08d9273f702c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For BACO scenario, PMFW will handle the dpm features disablement
and interaction with RLC properly. Driver involvement is unnecessary
and error prone.

Change-Id: I19363fc08568be4b7d3f2ec6eba21ccf8fff6c37
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index aba475d06507..0fac45012e16 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1393,7 +1393,8 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 * For Sienna_Cichlid, PMFW will handle the features disablement properly
 	 * on BACO in. Driver involvement is unnecessary.
 	 */
-	if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+	if (((adev->asic_type == CHIP_SIENNA_CICHLID) ||
+	     ((adev->asic_type >= CHIP_NAVI10) && (adev->asic_type <= CHIP_NAVI12))) &&
 	     use_baco) {
 		smu_clear_cached_dpm_feature_status_with_exception(smu,
 								   SMU_FEATURE_BACO_BIT);
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
