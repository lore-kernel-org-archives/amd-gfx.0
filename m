Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1873C55ABD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1424E2224A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m1or5VHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1424E2224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85DEB6E83B;
	Fri, 13 Nov 2020 20:58:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 342066E83C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2WATmOZJNtg0CuB5BoMRFF4+cEsQBaYfbyg2qtManwHY+F84xkZYTiy4R46ei0yes9VwTNeszh39yfRvWwtjNkxIxdvPEv0jCn0i1crHdDJz/U8NDC5c6YgzvoTswJiJJrR6v9kcwih1JtqEqP365qB4P9LlUQJbk7M2963D/tzfOkH/MEGj8XgoC8rY2pHWE2V3XPSQuNfNhcfgPl66kSTlNqhXf8jrnC7Ih1uPmdv9bAho/ndJeiEevpaXf+svLnsmo4q7QK7SDI+KFFBB+Nhi0vyE0gcooODOOsfgWo+YvQ4oBop7sb4OxadjG0+gAgldh71r1CBxFKNvcW0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnEqoI01lXPKmXsRj4dMFlPUl3xaSGPUMoI+ZvPSlUo=;
 b=E6SG1+MLojAPhpg8gtSP3ciyaDJB3EI12Iq6zMhnE4WTR5UVbhW6++wGF6jwnMZEaGLee7RUlpnpqLzl+9Q3I24e2iTI9SiY2qlDUxOvtpmMLsqXtgdoY5Kj2jByyhHAkyDNOGDCOx2k5cGizgork/AMFBXnRf7te3Efq+Bzp101jPb0YosuNoZ2iq34VsBOqwE4i/VPJq9Rhm8ztoB9oosNV85Sbj2JZO+mUyaN7JEpqA8GGbI21T4QH90H1BYeGZe1LokY7OudHO2lerEq8Ab/Xz9L/1WQGAX3HaMuBG9KBKYoaWOZFH75uj4qulVKCq5b1S3K1GxSX/h8gHnSNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnEqoI01lXPKmXsRj4dMFlPUl3xaSGPUMoI+ZvPSlUo=;
 b=m1or5VHqaRVpcxqRaodYn7QWm6BzplymdgpJD+n9Iw9vlUcH4/qKc3mNVtuBjuETjf0D5H/RTBCfBRjzvVLeXBO5QJSm9/Hr2XSkCW+lpk9iWmSFoUXaiX24IfEbRy2sqFd0LQIbJWoEhogDpVJU2lqEaN95eJ8wGd1nSBpRii4=
Received: from MWHPR14CA0071.namprd14.prod.outlook.com (2603:10b6:300:81::33)
 by MWHPR1201MB2542.namprd12.prod.outlook.com (2603:10b6:300:e8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Fri, 13 Nov
 2020 20:57:58 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::1c) by MWHPR14CA0071.outlook.office365.com
 (2603:10b6:300:81::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25 via Frontend
 Transport; Fri, 13 Nov 2020 20:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:57:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:57:56 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:57:56 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 13 Nov 2020 14:57:55 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/17] drm/amd/display: Populate hostvm parameter before DML
 calculation
Date: Fri, 13 Nov 2020 15:56:31 -0500
Message-ID: <20201113205645.640981-4-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113205645.640981-1-bindu.r@amd.com>
References: <20201113205645.640981-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c4c35d4-f4ed-4041-ff1b-08d88816cc8d
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2542:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2542124C12530BE69AB08F36F5E60@MWHPR1201MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JDfkMIwUBC66xE2iPiqpH3kcfibqyAz5nFMz3lzqqqO0OPSSqqvA6adWS8/33HtOuaeRJt8DXfHPo8c9NFA6C6OCbeRKHtn1oh+hTQnEzX/UUp7PGvk7xhbS1lhMg1ghVbtkzIIx4mOrAlkQerusJTlEZ5D3kzZdxq+ENPdgAH5ujeAi2ja4dqx12VbmP7hckIeOyb5rbdaecgRyzUHD0ak2SfBTpexnV4xR5KTCIJCUWdEhWRx/G7+dCvF8XXJNzzktNErVLDK03z2EMRK/LJDtR9dSTymhS/51Bob/SHxJbnUwOAXzglgvYgysyCpeeiTpi9SnINKGYTk58UDPDwe5Y4ZeinTw86f3ZG/TF2eZf4zUUrcnYpH75z+Ysn8S3pOY9ErhMZnKPN8E7tIp6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966005)(86362001)(336012)(2616005)(6916009)(1076003)(54906003)(8936002)(478600001)(36756003)(26005)(7696005)(426003)(2906002)(70206006)(186003)(6666004)(5660300002)(83380400001)(82310400003)(81166007)(70586007)(47076004)(82740400003)(356005)(8676002)(4326008)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:57:57.3772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4c35d4-f4ed-4041-ff1b-08d88816cc8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2542
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
Cc: Sung Lee <sung.lee@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[Why]
If the system does not have hostvm enabled, disabling it for
DML validation will allow more modes to pass at lower voltage
levels.

[How]
When initializing HostVM save state to hubbub and read back
when populating DML pipes from context.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h      | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
index 129f0b62f751..42fbb5e6d505 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
@@ -99,6 +99,8 @@ void dcn21_dchvm_init(struct hubbub *hubbub)
 
 		//Poll until HOSTVM_PREFETCH_DONE = 1
 		REG_WAIT(DCHVM_RIOMMU_STAT0, HOSTVM_PREFETCH_DONE, 1, 5, 100);
+
+		hubbub->riommu_active = true;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index ed3f62535301..1c88d2edd381 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1886,7 +1886,7 @@ static int dcn21_populate_dml_pipes_from_context(
 
 	for (i = 0; i < pipe_cnt; i++) {
 
-		pipes[i].pipe.src.hostvm = 1;
+		pipes[i].pipe.src.hostvm = dc->res_pool->hubbub->riommu_active;
 		pipes[i].pipe.src.gpuvm = 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 5425e92efcb8..d9fd28b34f2a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -157,6 +157,7 @@ struct hubbub_funcs {
 struct hubbub {
 	const struct hubbub_funcs *funcs;
 	struct dc_context *ctx;
+	bool riommu_active;
 };
 
 #endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
