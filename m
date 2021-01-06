Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0422DC43381
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 01:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF8922D04
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 01:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF8922D04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA2E89FC0;
	Wed,  6 Jan 2021 01:36:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D533289FC0
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 01:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GULZLcIB6ZwGVHoCQL5nSQfWQIBoObjlIpK9dfuxNUEOMR1qVxm5GLl91TO9uPznacXMoARWAb1aRnz2oLLkiickJpMgBqhMkZnH7sdYNKyk7MD5JyUyLT7vYdiaBhkRQWgUDAkCPIbbM/ONM0OIE0DwPGkQBXja9IjcmMX3PwFyvZ0E7ol0NMUeOe+8Rx4kTf1ZrqT5wpYke/jxlrp1ZFC2+SmpUuD/yjeDu8+XPVuuuegUNi+0mlO/qRz91UNHK1G6K6ZjmtCxvY6pmod46FZThYHxJpvF+KICY2JzIO3rgi6boyeJogIJAef8zGmsXZ981J4vY4ZYUB4LpqnDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B54r5k0alTcxjByHSMckrPzcEKuEY2OtJJwy8wf/WI=;
 b=WZsPKuVNjYkqH6ImYG1qNVkP2XRkW5tpC+VpYrvPH5pzvZSqgZVDTcy0Ciz4s1O1xu5//4vhPbr8pFYyLtN0B6x4eidH4oi/Q3AWsw0LrioUeLSafwbueE9w2JOZANyuck/SZagyyppOkAdaxw49nGtGjTcMhnVtsDqoyq9EsCAtZIIpayKdQYhiw5NY9HJYGC4ctk8DmT4tUc0YHscrZvuFJyxqxLoVB9D03CCvwHtQA4SdyjIOM330Etl4IBKvFusC9nVHfM5RYX0zcK0Z9GyRmZdGTCi6nZRG/rMYFsAsMtkqIS+TS0aYKCDmSqjbxCFvXD7IdiGN/2Jynk5ikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B54r5k0alTcxjByHSMckrPzcEKuEY2OtJJwy8wf/WI=;
 b=BCnAs6GU6lMrnglCLFUl4ThFHdyejn4rpNFYi8C/ScNTGK9zwmdmTeZm0pXh0rODC4WEHDxmBPdHhEIlU0+4gOqUVi8HDNbiDypoFrbzKL2eJYyAHYuSLuMlrZQvkB3qxsUZWXtu2IIsBY6RYRFuvFdVLoTSR1Aa0QkoxwS7kos=
Received: from BN4PR12CA0023.namprd12.prod.outlook.com (2603:10b6:403:2::33)
 by MWHPR12MB1693.namprd12.prod.outlook.com (2603:10b6:301:10::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Wed, 6 Jan
 2021 01:36:36 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:2:cafe::5c) by BN4PR12CA0023.outlook.office365.com
 (2603:10b6:403:2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Wed, 6 Jan 2021 01:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3721.23 via Frontend Transport; Wed, 6 Jan 2021 01:36:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 5 Jan 2021
 19:36:33 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 5 Jan 2021
 19:36:33 -0600
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 5 Jan 2021 19:36:32 -0600
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu:Limit the resolution for virtual_display
Date: Wed, 6 Jan 2021 09:36:27 +0800
Message-ID: <20210106013627.486969-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1644b873-db25-44ce-fab3-08d8b1e38063
X-MS-TrafficTypeDiagnostic: MWHPR12MB1693:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1693C31EE325E2605CEDDB2B8FD00@MWHPR12MB1693.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHx87ikGCkcd/XY+4LIn7T6cq4y9VMz6yIT5RIgKXDc6LLqRKslJZAysi2ZC2PfjkrQkxNCBlkn6RxdF5teNR+mA6DOTMqxqPQXlz9zkT19CKmFQZri+R3O7EN09vDYVlZv/P+AtIY7IQW/ypJjjpIHXf+w3kYM6/paC/oUCpkd6uxSZJM0TVdRrxfikp17wO+WsI5OwVM5A3j5E574SBhq+658ZzZBuFp329+vG88cZYpRzLnXa8CvEGIFyFcIFzTcBPDslGEGjKlwgxhjiJAwKtDkcZb2Z+0XsuwvIoRM9JnyTe5APRCqSbBpCyIeuB7ZwzbTP+YlnUSqCAQfcTpXvWn3JdI+vFzBlMRqbt+eEEGEYCnz2vXATyXAZHb/nTpRLdrTAJL26YpS+x1YF2fSaTfvKd7SOcu+/kDEqULjx48cSLomUnO+S74sIJAdbFiQnij/1avPbYj/qF/V2anFUN7Oz9uI/V9GJRgCOg2msZe2UY2JYYOlF84voU8eI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(70586007)(81166007)(8936002)(6666004)(4326008)(8676002)(86362001)(82740400003)(478600001)(1076003)(316002)(6916009)(2906002)(70206006)(47076005)(7696005)(5660300002)(36756003)(82310400003)(186003)(2616005)(356005)(336012)(26005)(34070700002)(83380400001)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 01:36:34.2213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1644b873-db25-44ce-fab3-08d8b1e38063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1693
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

Limit the resolution not bigger than 16384, which means
dev->mode_info.num_crtc * common_modes[i].w not bigger than 16384.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 9810af712cc0..6fc864cfef61 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -289,6 +289,7 @@ dce_virtual_encoder(struct drm_connector *connector)
 static int dce_virtual_get_modes(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
+	struct amdgpu_device *adev = dev->dev_private;
 	struct drm_display_mode *mode = NULL;
 	unsigned i;
 	static const struct mode_size {
@@ -320,8 +321,10 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
 	};
 
 	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
-		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
-		drm_mode_probed_add(connector, mode);
+		if (adev->mode_info.num_crtc <= 4 ||  common_modes[i].w <= 2560) {
+			mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
+			drm_mode_probed_add(connector, mode);
+		}
 	}
 
 	return 0;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
