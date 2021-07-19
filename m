Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EDDC07E95
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 15:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6559A61242
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 15:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6559A61242
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7FB6E160;
	Mon, 19 Jul 2021 15:19:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F8B6E160
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 15:19:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWut52jZfCMBk8jgRmiKeXwQ7xuhzp/1r9LyigH9v2L0aAc3pmCF73x5mseqmcv4q5bl9QnykbiKejYriQrEFnvJ5q8SaYnlENSv1THuFCUWTN8uA0x0Kyz9tT71ET5i22ECJfm5QyD/TexB3tZYof/4uumrYCxB6Hdiov9g+Fv9C9fjdM/IuzhX5SIu3Ep9DeZH8PlGvrKk4QKKjLj5UXd0tKw1/Mod/pXgZ4i+C6tEl9HH/D3lxoa5k7175ft+HCXcSZLpY2YShATh0eAzG8a2UfMktV/9m4pdVMW7qtS90vMXKiSLEXq2SbUWGdv+wm/AAxTpiuUuMF3T6Ms/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP+EAcp1dQoSW/mORraZRNWVF3GJWHvwwC22UGLXL3A=;
 b=RK+qEdwsw2FwOa73kgs8W+KnFmKgteyxVzAF6sg3TzPAaETrgg2PlYxrYxN5oeNa3ds0r49ent5I2x7CmBX3VtaD3Jf53TmRPvdXlLd78bJBQ/bzdCI2R6q1WX16pjkkaQ0DPSotUXdotwmTEoJDlqTX4XkZgmgm2bE/WHmSbu7NKJ7VaPwUqVKdi4GJppxBRz+pgWe7M2rFTkMX9tY2BbPWWyK6zT/TLFK2Q14yQakEUNII4MBKaKYpWaVDc9JVmw9WeKNTwMyQFIAR82DtUfGHnbNj4l1bBvDUjGIpPgv4Sl0/sqOk/OwMeEHQhPGW6iLmWwQRVYm1rPdXaOXv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP+EAcp1dQoSW/mORraZRNWVF3GJWHvwwC22UGLXL3A=;
 b=l+Av4TXjYMCW5uGt+dflDhXujujV3b2VVbGvep65u+ypcj+sKtz+INxvUljGauKeyYKLvPspZxdpptnz15xARLhEpvoYSlE0CUPpWikP01PTBv+/Og4YChu9Cmq2GdF2bm+VaWVaoBjdHQqilXno1uI0dPugfz1OXuH1rHy3Hig=
Received: from DM5PR07CA0097.namprd07.prod.outlook.com (2603:10b6:4:ae::26) by
 BY5PR12MB3937.namprd12.prod.outlook.com (2603:10b6:a03:194::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 19 Jul
 2021 15:19:11 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::d0) by DM5PR07CA0097.outlook.office365.com
 (2603:10b6:4:ae::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29 via Frontend
 Transport; Mon, 19 Jul 2021 15:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 15:19:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 10:19:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 10:19:09 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 19 Jul 2021 10:19:09 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix documentaion for amdgpu_bo_add_to_shadow_list
Date: Mon, 19 Jul 2021 11:19:06 -0400
Message-ID: <20210719151906.215302-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e96e334-d9f5-4932-1acc-08d94ac88f45
X-MS-TrafficTypeDiagnostic: BY5PR12MB3937:
X-Microsoft-Antispam-PRVS: <BY5PR12MB39377F9C5C1B9AF4A7364298EBE19@BY5PR12MB3937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pGuRFYaQzjGB4qAgl9k1b3bzyhYbA7Jc/5YiuXJUmkUvSWcvJ08B4FcWugIKMVEhUbjVga9lJ1XI+S5zwWjxxBWFzQ0xeR/pHSVZ7NYtVWgVFBaVhKakg700B3Z0LVfTcApthsttZOPxCPhnuYQKQAAdWtlrBIb2iizpcN9zt/Ietb1lI9cGF/rk/865mfL7Pzo9IO9jiH7FOoLEcNWwq7JnzGYy4u/Or+hDEushWIpyajkCJ6MzxSLxpAr2sFShJglU5nV4Hu42caj4WZ+lQQw5ryQyY7s4UMylVwv8LwtJREl/NWCtjetmvSDkjMh8YIn8qyjL3nPAVp/1kOoDDkBwCFn4VLYJvm52LYGSU3+IKMTrUKnltLtQr0azatJlvzdS3jT073ucn8xBNBfAV1E1/e4xrBDMaPWXP+eZWLJASkX0laL3DMUSTklC06nFiuMkIjWrLu67gEbbhi2HlfC6a/9SztdvpTL293k/bcObrMwaZsd2xS63yM/t9K8bQI53HauSEBkAXGAiFXP9Al/R8IOc6y3DaIBxGlX1Pv+hreR/zIO4dFzrhOS80xgMSix5lVC/DebERSvejVfSYeodvNKZAj3SllEcXNy+oCNvFT6WS5X0pkl40IXZjDMwLy601tj93CgD+8U4nA23QFgsgXyaVcloBI/uvt+rm/3dBMfBXq0IRlxhgU6MLBMpUnqcfUfKcugGLgILRr6t0noIJDog92N+BueccpAyEJI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966006)(36840700001)(316002)(47076005)(70206006)(2616005)(426003)(336012)(70586007)(8676002)(2906002)(82310400003)(478600001)(8936002)(6916009)(36756003)(4326008)(81166007)(36860700001)(83380400001)(1076003)(82740400003)(186003)(356005)(86362001)(6666004)(7696005)(5660300002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 15:19:10.6261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e96e334-d9f5-4932-1acc-08d94ac88f45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3937
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
Cc: Anson Jacob <Anson.Jacob@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

make htmldocs complaints about parameter for amdgpu_bo_add_to_shadow_list

./drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:739: warning: Excess function parameter 'bo' description in 'amdgpu_bo_add_to_shadow_list'
./drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:739: warning: Function parameter or member 'vmbo' not described in 'amdgpu_bo_add_to_shadow_list'
./drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:739: warning: Excess function parameter 'bo' description in 'amdgpu_bo_add_to_shadow_list'

Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ea339eaac399..4e2c0270208f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -755,7 +755,7 @@ int amdgpu_bo_validate(struct amdgpu_bo *bo)
 /**
  * amdgpu_bo_add_to_shadow_list - add a BO to the shadow list
  *
- * @bo: BO that will be inserted into the shadow list
+ * @vmbo: BO that will be inserted into the shadow list
  *
  * Insert a BO to the shadow list.
  */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
