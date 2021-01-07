Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F64EC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 02:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E842222D75
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 02:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E842222D75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 714E76E3DB;
	Thu,  7 Jan 2021 02:50:07 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750041.outbound.protection.outlook.com [40.107.75.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E85A6E3DB
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 02:50:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhkuzOuU7bzQT0NjVrWxZFQZaTL1H3mNK2fa0aH/hQh0z2xov5CPeV5RkUs0a8+SwocdOLfD3pmq3on5uyFpQl/8o5UOuLrmZtkUsxUyO3l1g5xLBX6VaGAeXvJX+E59cJOtJuKQ5C8T6C+QnjrOsjNlne6RM494bYZWeKAlw0S1bBcwTS7AY8cJVz1pmui634pVlcAaCfSdZBHotZxjsK1BeGsxguFdbevIbfhd30p0HeTgqVm1NFPhD84ik43lauhK++o996+fKvuaYZqG7sFExEgOqUXRVIIz9ezq5SWR4GCU7vDl6v2C2QGTEsrsykLFPkdvZM1dv+vrzRRr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NH/Ztqy0vZuQ4ddGeLmwxZot+v9ykXvh5RzFfMBuVro=;
 b=a/5UWnuK5Cn+zFJGv6h80TsBatgbDkFHx6DgkQHhK/Sd9GEMqT+vdWX11Mk/fDum8n27btgV/9lo7KNYie7eM6/Gq6Vwu7QWCqWpf7aQPyikl3YUd6wCi5+MPr1pbRGTWTrtMTLxJApSYMAYXYny9QPx1WruqzaSTuBYdfFN+6JgflX5Qr10LSyXnZZCmj56B09xlbfi8ak1CkWghkj3TGbMEhhcSm7ABrY2HkDIXFGtGfzgDo3MrR2SYv4wzBNmRybM7HE7rrlFkdVPiitBAh3o5CqdQFpsHPqHrbCARAaE1HsP4lZZ6IdY9IiU8pz9rYKYHkwXzhQItTnB7ohTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NH/Ztqy0vZuQ4ddGeLmwxZot+v9ykXvh5RzFfMBuVro=;
 b=bxNguyLRX1OBKfqmRqB12qCNf3f+7zaVq4kH1uCRaeQkEjdVTOwU+R5EtVFVtt26ridY+VjgJiz3IDnaBRaBTsG7Nn294hy/UI30BBykGFGqH3TbqXuBLzfKNJsfOEMIldSE2VHWrMNyQU6n07fZTPut+9PTm+SsUn4He3r8ojQ=
Received: from DM6PR05CA0044.namprd05.prod.outlook.com (2603:10b6:5:335::13)
 by CY4PR1201MB2470.namprd12.prod.outlook.com (2603:10b6:903:d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Thu, 7 Jan
 2021 02:50:04 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::c5) by DM6PR05CA0044.outlook.office365.com
 (2603:10b6:5:335::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2 via Frontend
 Transport; Thu, 7 Jan 2021 02:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 02:50:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 6 Jan 2021
 20:50:02 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 6 Jan 2021
 20:50:02 -0600
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 6 Jan 2021 20:50:01 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Decrease compute timeout to 10 s for sriov
 multiple VF
Date: Thu, 7 Jan 2021 10:49:58 +0800
Message-ID: <20210107024958.605344-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7d182c7-1aea-4b94-50e8-08d8b2b6eea1
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2470:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB247050C19C749C32A9E4203F8FAF0@CY4PR1201MB2470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jTQdlKxMJbtplcJ/vFbYNtcRNnD42X1R5uk1RfIqKXZhiletq/PK6sSI35/EEeN3crLYBw2J3nnu/vNLHQgAAPdqDTydLUrJVXZnq0HBeyEnl7wBOg7YPP5LTicOCWBHBgyDvxGGMhs9VwhDTZcLjkT0zyp1NxnwmMGjfjDSO7+8mR5RXvnX70vgeDln0gMJGKzDwtOp1lkIbaio6Ve6y3TFDRndL+pFw4aH6LzWHRn4G/3jjFCVkbMOrgrZeVvwtHtKlythbr90TbPutPG/ibqbENoS0/6dPZdPrMdFvVtfhXVtGTjwsxPQGYDiY9b4DZbnUe9y54XE0pCGlS/vmgrGjl2ySe0ehMJjaQfbStezYCx23gBUmLBkk/gaJYvTserkeUkd53iB5SqwdaLtd2Gx2xiGQO2TEW959LhGDHaPoR6G7I7Y+F82kL2twTEd6s6LdbYDkPX5CPRH83RhMwyYBJbIwSMbuveqTtrg1DoxvjhVh/vRD7QSFI/c04UR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(46966006)(26005)(6916009)(6666004)(8936002)(70206006)(8676002)(4326008)(86362001)(70586007)(47076005)(36756003)(5660300002)(478600001)(426003)(186003)(1076003)(7696005)(2616005)(83380400001)(356005)(82310400003)(82740400003)(336012)(316002)(81166007)(2906002)(34020700004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 02:50:02.9397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d182c7-1aea-4b94-50e8-08d8b2b6eea1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2470
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

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5527c549db82..ce07b9b975ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3133,7 +3133,10 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	 */
 	adev->gfx_timeout = msecs_to_jiffies(10000);
 	adev->sdma_timeout = adev->video_timeout = adev->gfx_timeout;
-	if (amdgpu_sriov_vf(adev) || amdgpu_passthrough(adev))
+	if (amdgpu_sriov_vf(adev))
+		adev->compute_timeout = amdgpu_sriov_is_pp_one_vf(adev) ?
+					msecs_to_jiffies(60000) : msecs_to_jiffies(10000)
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
