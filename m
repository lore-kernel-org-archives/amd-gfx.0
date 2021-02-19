Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2631DC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87CE60C3E
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87CE60C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E57C6EC39;
	Fri, 19 Feb 2021 22:16:52 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8E76EC39
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 22:16:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEfDeo2uZSr2YK7/VTv5YxxEiOV4vonQyIED3HVsZtp5XNGzDyvKae62rFFB6bs1JkF+qXohwGlx+URr4S+UT+45xh0LCfpjlc9ZgzMTEBBP/NFnDathOZh/Hcp7niX+JpZk/FqT/y9SEucGCVnTtZ6qmGgt6zM2Zb2sMqypYZp5RX1pDXQXtRWvRBpp8p9HUnt0NrZ7Ykgmv9ntXZnfYg2rVulZsWDznEHyLWJ0z1m/Al/NzSCfWHkrNgV8Mn3N4vtqTOhnftud0deeCHx1D+S2ou6CH0lPH3vNOJhjqPBNUkJsyqGjck9Yu7k77yhDiK3kSbuDI5PyfGOniNxNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTTv/5Tw8XTe7LfzkPoz76/PKtOfH5sNzRojiGAbfQA=;
 b=aqHslMHjuWPTTwpvGSg6CCVtDhwBwiov2h8svUkaQz+cQsRz+QA2opO/SMlZnm7KUMp9QY9bNe180R4lU09SdGOocn1MCukUEiYe7m2RxPc9Dnu7wyVXsbzxbsIQqp+ITUKxL4+IbBZ3wPrdYlb+IwetQosABGmSW1fIhHibhbGdeP6sdWDqh1dIzjfP49IcFA1KgQy9visLZRKZ48sCVne0VnclA8+MTpe9RBPCawCjy2ACvPA99S8870/20+2vwz4nRPCeiIbyJgLECfFM3J7gIXL5ukT6d51XY7nxqZv1BORfjzxCyGw6s+DUZGAUzxFduFFGoujCTAsk0hmlEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTTv/5Tw8XTe7LfzkPoz76/PKtOfH5sNzRojiGAbfQA=;
 b=0ufXsG4KfT3MEvbPLQkksT7hx6IOPUcLnp4WOQ9dWZ7HaxS5H7Wg1q96NqoumrfVVfEaONnGLUg6BU500LafAeUeopz0M7Oj8Rzcp26ddrgukauaT9/25yZMQz6ScG9hIi0SHGpJ18+6a6DV3vQ1bPWRp5EUoCtD3tsGGBRZvus=
Received: from BN6PR1401CA0023.namprd14.prod.outlook.com
 (2603:10b6:405:4b::33) by MN2PR12MB4640.namprd12.prod.outlook.com
 (2603:10b6:208:38::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Fri, 19 Feb
 2021 22:16:49 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::3b) by BN6PR1401CA0023.outlook.office365.com
 (2603:10b6:405:4b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Fri, 19 Feb 2021 22:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 22:16:48 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:47 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 19 Feb 2021 16:16:41 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/13] drm/amd/display: Check for DSC support instead of ASIC
 revision
Date: Fri, 19 Feb 2021 17:16:05 -0500
Message-ID: <20210219221612.1713328-7-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219221612.1713328-1-bindu.r@amd.com>
References: <20210219221612.1713328-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c019e31-96e3-49cc-4bdd-08d8d5240cb5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4640:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4640FB8E06EA14EBDCDD81BDF5849@MN2PR12MB4640.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: olCgWDJiQ1OI2/3kGHc0DLql2mz+gEVaeru4sL6x1QAZouaO9i6TSCq5I5WP1zzr1ywk6dS2SYrBbfisjjVivpQtyhYEFK/9m1WJmi11Hg2fpUqnsUrGMUFF37CIWx1+W8XYAQg0N510d7KBa+oUUEiaXv77xprMZCIZgtqgte8tBA/6s/o7U4o6Jhi0BdKr4TgLV5P2PfOodmX980yeTM2B7UuHfwrCcvfdvxYY5lxfcnEMfM4M0DvmY7cVubdRxnRVbXGQxw7CGF8WxD3mjNQio9esDNEi9VBKTYc16BNY0XhQUNIrNlkbieMYMNo/FoBruhz6CGah8pKUXBFHID/QFqNSFmbVqzhNm/UrQDg4Jnf2+yUA9hcLFv6dMPjZ88aBShk/SwozGGgQ67/SBu/dTuHHv+KXnibMlQUadi0aT3pCk5q9hZCqXiILk4UKlED0T1s3o7exbTO9jU4zreVTUI8FXeR9zY2qI3kk1E6qr51svu4gnTFrxxWmMIGlsiYbOKkAmD1Yl4RWAekO62wLw/3eetJ5vaJxVFOElVwAk2OZk+A33Ogd3mMA+NL7xPB6DecZ0ZhZ0Pw/3v8yxgsSEJ9mvKrBf8JXtjeoH30ScGJLQhQ6GWF7tmsPcW78wEe+dMisK1BC21hBmtH5kxgajVsPigGL3O4xBieqdvYWqO2YHq+iP57PCpYomxxW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(36840700001)(46966006)(70206006)(316002)(478600001)(8936002)(81166007)(8676002)(426003)(1076003)(47076005)(83380400001)(70586007)(2616005)(356005)(6666004)(54906003)(2906002)(186003)(6916009)(82310400003)(36756003)(4326008)(26005)(82740400003)(86362001)(336012)(7696005)(36860700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 22:16:48.1242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c019e31-96e3-49cc-4bdd-08d8d5240cb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4640
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eryk Brol <eryk.brol@amd.com>

[why]
This check for ASIC revision is no longer useful and causes
lightup issues after a topology change in MST DSC scenario.
In this case, DSC configs should be recalculated for the new
topology. This check prevented that from happening on certain
ASICs that do, in fact, support DSC.

[how]
Change the ASIC revision to instead check if DSC is supported.

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cf3ee268ea4f..0970d9c14889 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9419,7 +9419,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	}
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	if (adev->asic_type >= CHIP_NAVI10) {
+	if (dc_resource_is_dsc_encoding_supported(dc)) {
 		for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 			if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
 				ret = add_affected_mst_dsc_crtcs(state, crtc);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
