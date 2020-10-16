Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD2AC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 12:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9627207DE
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 12:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dq7MMStf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9627207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C2486EDD7;
	Fri, 16 Oct 2020 12:51:13 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam04lp2050.outbound.protection.outlook.com [104.47.46.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC806EDD7
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 12:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsDse0zvordqSPEn5YGj6FDj33iz7esXndRsgNmVCtkSnrMUqVzgmdxLz0+6IsQLMNvqrAkeWw1lrzEeURKtH2qvmOLolDs4c5ZKJBDbXUivYOzS+lA1FOHIcezzEf+saVQNvmzsDsjuwzHKPgBfrF9rY1UeRA4hMeTYukKpsz0oPwBPuSW1KMHd3CBS1IA+r1KSh41ngWh3x4w+eiHaBBpB/shk4zNfm5fIcGNfuJZ3MI2woZ3iw7vcp68Z5+ymRxVKEQIfv1vCU23pXUfXlvNgKijugD3eWLPjnIUtpZpqr6xXFggxVaNeerKHdfHfcpFny0CiKkYy+re6Iqu5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtJEKoW2lfv3nuUCMw7IVEQn18SDhixPoMZu39jK0ts=;
 b=MuyzcaSZC0dWyDMC58Xf1mjJFnXf/zSFhqpyPmA2f2dX9XUdsoPTVreRznGiopgTI4JeQpVrnmhwRJDvj3mN6bbprhVIK1FnZodsDDzhtf3vGFRsjanmeqOxdUMXZlPDaY/cIZuBNuceqUZPwPrF10hbfbm3g7QC3h9lZ1chlw+4GVNS3AvSkGopF7PNo+PvQKJ5qhyS10fRnd7hIbdfJvtLa3CZKsB+WLS5i1W0IE5XJ0DIb4fcW/eCWnNtKh449y7SvSdkc9VLknfZhjtJm9AA7BhYxDsuKuOUwVlHGf5Js7iZPpzp91GWFDCCS4GRRcf+b1uZwE4jmLP2bwNReg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtJEKoW2lfv3nuUCMw7IVEQn18SDhixPoMZu39jK0ts=;
 b=dq7MMStfKsajiPn8JJq68WG6jWZsjkMvZyOrSchFjS134QBp/JfUkvQEmfEzDqkwRNRLfXTfwoAgRn0N8Ehqt3HQprFfWRgMzZHMlZw32uOBuyYiR8OstORkxnNEaZguFp4Uw+5ze409Eu1BCYhLbyLyXEt489yMi5/faPMxGHI=
Received: from DM6PR11CA0064.namprd11.prod.outlook.com (2603:10b6:5:14c::41)
 by MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Fri, 16 Oct
 2020 12:51:06 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::7a) by DM6PR11CA0064.outlook.office365.com
 (2603:10b6:5:14c::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend
 Transport; Fri, 16 Oct 2020 12:51:06 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 12:51:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 16 Oct
 2020 07:51:06 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 16 Oct
 2020 07:51:05 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 16 Oct 2020 07:51:04 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: drop navy_flounder hardcode of using soft pptable
Date: Fri, 16 Oct 2020 20:50:55 +0800
Message-ID: <20201016125055.3578-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25602940-f26a-403f-939b-08d871d225f0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:
X-Microsoft-Antispam-PRVS: <MN2PR12MB36134861AA4DDB87186D8448EA030@MN2PR12MB3613.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jt7nOunWOw2OVBC1eNRKi0AgTo0jUw6+/Kd5YSuX4U8SBRSsDUQCHHAXUC/gJ3kl7iurxpdazxpSf+vjLsJWvmK4d71nOActKmPqWlJvityOI/Xc1tbzcP8eHYacn9sTOsP2AHyaAG1An7fTu2MfU66evn0qgfbkZqa7ab4IU5uhlO6qPUr+JLe7gSikFeM7ILo3xRlb23iabVu1SHVZD8lCNkD+psS44i7uib4ERCbEnanC4B9ta7abUjtu/av7Skx9/WjLsy/7lxKPXEC0CQyMUzbvG095yhszqCWy3RS3l+YbU5OX45WP8ef2Punx17gXuToEdlGn60B7jnoswpWAUKoTgG4+0QIO3yPd8TMstvNIkMCGm+aDJ/TiwVqnsi76kGeGVnUn7D/JBRrEEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966005)(356005)(36756003)(6916009)(82310400003)(4326008)(7696005)(8676002)(83380400001)(478600001)(8936002)(1076003)(47076004)(316002)(54906003)(81166007)(82740400003)(6666004)(2906002)(186003)(5660300002)(26005)(70586007)(70206006)(336012)(426003)(86362001)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 12:51:06.5590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25602940-f26a-403f-939b-08d871d225f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3613
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
Cc: Jiansong Chen <Jiansong.Chen@amd.com>, tao.zhou1@amd.com,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Drop navy_flounder hardcode of using soft pptable, so that it
can use pptable from vbios when available.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I33436b023d03ae77a1b92da5a8062e8466e80110
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index c2a6eb93d93c..fff1d2522463 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -337,7 +337,6 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
 		version_major = le16_to_cpu(hdr->header.header_version_major);
 		version_minor = le16_to_cpu(hdr->header.header_version_minor);
 		if ((version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) ||
-		    adev->asic_type == CHIP_NAVY_FLOUNDER ||
 		    adev->asic_type == CHIP_DIMGREY_CAVEFISH) {
 			dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
 			switch (version_minor) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
