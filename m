Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEF5C5517A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 18:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DC720644
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 18:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HCt30N+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DC720644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5C7789286;
	Mon,  9 Nov 2020 18:12:45 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690057.outbound.protection.outlook.com [40.107.69.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 474FA89286
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 18:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoLDVsSYw6faboFuLiM+iEJ8g6fbFGDxYpTcEinoRREuND5KbvxbJwnlyMUJvZ+519VJL87isDrs8Xd+IKHMx4smSal1mFSih0UPr/iOeJmVcit7iA2ZsZHbOU84uWzW4wXBdk11MMtI6unFRoW7nG+rIs9IAy7Aul7et7FnO0Hb8o48PYReS+dtRO+goHLz/tNSSRCrLdL76ZQVD5bl4Sl4Mi8JfmMtP2OuNf7bny2y87UfB9e4zcAvBE9geLF/zeAEKQhiwMjoMlYV7kZ2j3u3U5re8R+0Ok9YP0x4jXQAmqed6RYMIJQKCvU4yry8t5oyWOzyyHT0reL3FVE2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSqrHSXLxhMmGBu6yyuGZcMddjnfBgyJjIOCVZfuKuw=;
 b=WofBCV1cSmi71WeBQfs3eMav+0SO6QVTWjVl/pYiG8ThCNVR+dePQGMuLXXx6Psvoyk9lW8QWJEDXvyZmCmFzpWSu4mizlyAYbadtFBfmwYuMEIwVWVwAU5zeGYHdikyGLsk28bOfZ1XWqMIGl/lZQuD6gP4HI4/5cG5iRSpyvVz4s9QtjAdv66isPIpB7z7z091NvDTdkPmPqMQkIBHSMSNKeMja/vbFC2SIwmJ/WH3X70DGHdVdZBtC12earqqH0aiN+9HBXteMALpcytkjVFKnJ3Mw5RrzJiGhamdwiwq+4r0jF9fRPmYBr6DG0w4DW84LduUBhjmZcsULY/fCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSqrHSXLxhMmGBu6yyuGZcMddjnfBgyJjIOCVZfuKuw=;
 b=HCt30N+YtSzOuT/155SQSpBW3gdJY/ztUQGlXvcEbVdANA+MIosp5jHwfXu/fjUZyrj01zxKVAooWO9bevkP4EKxLWglQTbdCciqwOnQY6MCuhMzQ9gJnn77ZBqll6QVfx8E5VON5YzO4VozVT2027oZSMMNhYWr81NNOIBiemE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 18:12:44 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 18:12:44 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: enable only one compute queue for raven
Date: Mon,  9 Nov 2020 19:12:14 +0100
Message-Id: <20201109181214.35540-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201109181214.35540-1-nirmoy.das@amd.com>
References: <20201109181214.35540-1-nirmoy.das@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR1201CA0024.namprd12.prod.outlook.com
 (2603:10b6:405:4c::34) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN6PR1201CA0024.namprd12.prod.outlook.com (2603:10b6:405:4c::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Mon, 9 Nov 2020 18:12:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e9b7b824-c421-453e-714d-08d884db0de7
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0090:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0090E4F047E82F0AEA71B9B18BEA0@DM5PR1201MB0090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n0z8I7b24J25nHvp5GOK3ejyuMXbVGFiSzAiPTOJCErNY7FdOQnIBerAHxPMvg7slxP3JFnRptrXWysCNhhnvIY6yxPTtnxMgvsUJe4/8t3t7hCf9AMhrW9ufx1klQx2hfV7mroqIQvZuFCW5pj3r1n8KCnAz1mFj0goJR2TpsTCyI4IlFAan7WcI3xhUPUQAsApU8WPAFQPIYh3+i5mQlRVrC0yF/UG6EmSc/bL+9JrR6C0nzmtGN1kMiFeXe5QJ/TlCla58qgQ2j6BZv6q/+AjJTU33qn7LakfmqogyfTa+xLhgA/dRO8MgjH5YU1L
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(6916009)(66556008)(1076003)(66476007)(66946007)(8676002)(86362001)(8936002)(26005)(52116002)(7696005)(5660300002)(316002)(2616005)(6666004)(956004)(186003)(16526019)(44832011)(2906002)(6486002)(36756003)(4326008)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cVpm+Jp1XH7A5X837oxLnKI2//YslIIQfPB62l8/a5k6U5hASOqMcoUSKwSX2LQd/BHI2ZnCF1XAHTsweRA3CN3C6YFO6MK4SsXiz+zxevzPgxMUxVNMGlLse/ZI0iHgm23qxNogjyC7IxDvWh9A1oD3arQsaItHPZSt4Thwb0Fn/KTt3XDEhnp2LiiPnQKOCHYyjuEusQbhvr5x/03/zGWVg5PqctQl16/4TTUlAA1rJhAPiYzy+W8H34q67EIIBp2WcvZky/jZ19karJHuV2Bz9uLAXv/LvbNqIu14GuzOZtWgN2EpyWlAPXoq0uGXZn4ceHCdWYvvRpU7eFdIPeR279dnGogSumX9tthoaQ3X/VulWY0oj6btuaAvBZTr0dpjjtQTF5MNuJ+6EpJaX9BxYhRBS9X4ZdWGJgbwFOgykL3dfsrEMSg8iQ3CYmPpW/V4UpXGzP4H5qWXOwN4AFzirZbI0Yi21OporIWIaW8lDxT4/P2bh41E643/QYO3DZM/Vtuc97W2DKtuHQegnwkvoToGsl0LzQknkLa0P320I+n1/LgF78vFWt5cSGzt7VhX0KsPLL0kZ59KVcoMZV0uIvfNmSwEaSHBjx68I++qzWYRPfjEthZixZmhBJFc3cuxyz8O9qPUaOlXVj5t06v7vMycH4z2+vDJJkRiHRFLXAcKHq3Q54iDFZ0Fysw9wLoKj82E1StnzggKW9Yy8hzy7yRYtw+WUb6MH+j+PqcW1/cCfq9J4YS+VnWZ0c8H9fZrVuf+zoPPQSgUX52XwH0tCTl8UNX8zj1HrV+pDnSVWp2sfba+fAivXVXn/DDkZQlI/ppmK8oOYxvTi1ZDH5q/plW+G7g2uxvEaR83GyrsIvxUUvTvz56r1ySLvStQvPRBDzvKObdtCkTAcKt/AQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b7b824-c421-453e-714d-08d884db0de7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 18:12:44.1589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9MWyumU0HchAzOPopa2c1BWw8c1Ju0lIx9bY8+QIhH9bZ4s4037NAyEJzoA0xz1vSBwEWqGsl8XQo7LYDnIwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0090
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
Cc: Guchun.Chen@amd.com, felix.kuehling@amd.com, Aaron.Liu@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, alexander.deucher@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Because of firmware bug, Raven asics can't handle jobs
scheduled to multiple compute queues. So enable only one
compute queue till we have a firmware fix.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 97a8f786cf85..9352fcb77fe9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -812,6 +812,13 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
 {
 	if (amdgpu_num_kcq == -1) {
+		/* raven firmware currently can not load balance jobs
+		 * among multiple compute queues. Enable only one
+		 * compute queue till we have a firmware fix.
+		 */
+		if (adev->asic_type == CHIP_RAVEN)
+			return 1;
+
 		return 8;
 	} else if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
 		dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid parameter provided by user\n");
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
