Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6176DC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 18:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28CBF206F6
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 18:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y/krn6Mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CBF206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E54C46EA24;
	Fri, 22 May 2020 18:20:00 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680060.outbound.protection.outlook.com [40.107.68.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF4D6EA24
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 18:19:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+vdYeKzy76hd3apAqnV4YKGkXRHqKVOW08eOPvK2X3yeEyPgRDfo0/Pc9v0eV7EwQ51acoJmCMPYBCxYqCwsOGpzpKxOVVIe3OTXmhCO21fBGYLHcn+CzM8ZqRUAxGpgW7DZVe+nXgmJYRyR9YpHN39UT0o7hPouY3eeIp/v6r/+qbEGWe8CKd8KbK+grYXP0VExPe9jyXgNh9hEX+OgMOIks+5XH7r2oF3ciJ5LIXp9BMgC7VIVn6khieqkfoCSXEjl0OLnACRlL/6jJo1C7L64deUfEMP33HcL9g9Byve4M2eLXae9d4bBYA1egRK8ATndzo81Q873JJaSQiTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofRXhNXmHFEVNqKWwbgu3HNFGlfwqrAovmGtUYXNg1I=;
 b=LtYymsY6L/uCTrfy0jSn4M7B5tYL+SLLINvtvdhHUc7Oi6Xjyrnd4wXaQ9DTGquOXfFkWNrVDDrr0OEU5LK/950aYuTo15M98qLves2cr8MlPhdkczRxjCm6TVPoKUxSDU47UuJH47PganmP0XXFHaUj2fSM/ByHD+smPG9IRwU/+vgRjpeBwUWtpUtQTv5I2afjRe41YkVxt/gjzq78tV6BV546VY+5VUCUXK9DYJJkoJrw9tT1EpWKuU5+TmCD2bPHPja8WjMZB8x24NNM3tkFydz/tOPa8oZ0unFKSRQxDmzw9fRqRwW8zTOvaSAfugmOs+4ddOqTJ2t224txuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofRXhNXmHFEVNqKWwbgu3HNFGlfwqrAovmGtUYXNg1I=;
 b=y/krn6Mrw3GGo+9h/2AHyNabT06k8zZBjkG8B4Hv/m4bbwPZpUs5k8EjC2lw15fqZUtNa2xNMZTOJyYbyYGvjdrmqFX3nrlf/dXSiwYs3xsxTZbcGXShld/viu8CBalbMlcjEwcTrJ7jTe+rcQ3Xx2yCp2t0bTmEuxpzY4VE0l0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14)
 by DM6PR12MB3482.namprd12.prod.outlook.com (2603:10b6:5:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Fri, 22 May
 2020 18:19:56 +0000
Received: from DM6PR12MB4121.namprd12.prod.outlook.com
 ([fe80::21db:6afc:4193:872c]) by DM6PR12MB4121.namprd12.prod.outlook.com
 ([fe80::21db:6afc:4193:872c%8]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 18:19:56 +0000
From: Gavin Wan <Gavin.Wan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.
Date: Fri, 22 May 2020 18:19:31 +0000
Message-Id: <20200522181931.277182-1-Gavin.Wan@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::31) To DM6PR12MB4121.namprd12.prod.outlook.com
 (2603:10b6:5:220::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Gavin-Ubuntu-00.amd.com (165.204.55.250) by
 YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Fri, 22 May 2020 18:19:56 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 26540aeb-25c7-493a-bdc8-08d7fe7cbb22
X-MS-TrafficTypeDiagnostic: DM6PR12MB3482:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34825D0630F24C471979B19EFCB40@DM6PR12MB3482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BVhck1jckYmMMS+Pu18k0DwBvL3w3TGEipw6uglqyheVfDlEB1cc/0DR7UuLprpG+5aBMFgZZa7MLinJ/cVGgLzqtV130KBAz+4AIM0XuatRp5kukmvZLVnVF1VP4sSqC0U51JJS2WwmpqQQ5GBJ0BIn2pKjLp0N95+Gq4MpytU7L0L4qcRhnqvGxkBIPuXSy1cPYHOYMjoK5IODHyIiFQ6TxIqqP7IMl/5mmEAtx1N66urScDt4biO+Oq7ucIdGrymEGvPhOniOzALcofR5LRnkK5tDdPHXVhEUiuLQJNulm4yKLLZrcErVOS+Qsl8G/mgSOFN1FTnfGN/AHyPOJSbSjCxloeX5BU4RjaHRnv/UpDa349B3fIYenedi0u+vJlm+6Bg5PMNsqFfdX358GQJUhHRiaonNTfE3+k6kf6PJVZtqPgxK1bbZ+hYlwO9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4121.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(478600001)(66476007)(66946007)(316002)(956004)(2616005)(6486002)(4326008)(8936002)(66556008)(6916009)(86362001)(8676002)(4744005)(6666004)(36756003)(26005)(1076003)(16526019)(5660300002)(2906002)(7696005)(186003)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Z0Mgbbzwp9C2/OvPfauXypUIIyV+KjN/0780BaH20GXz5pbh9XBeuaMkEdk6Z3jmRDu7lKgoCWUu+7s5YLDbOtvjixUQtaQolbvTPox195V4UQij0t7jJTW/m7IpUHCkUjCZzoPZSYcWzWSyFAscJq54W9OfwNnTAmTgPxZ3GrBYMnz0domgySyYxHY7MYWELmrCDQLiMiu2KMCPbadyQWXPJ8RqBpxn6ICkT7hxF6i4wXpirWHkrAd+bM390o2ID17PSYzlo6Xd7CoZCFxkVojhxyH8Zt1dLxz7mxT5CenjONR7Boy5b7ZSo0DUz7SAenqOZlh4dc+uKhulJGdNqRy4Ku0Tw4KR5HjJYGrt2UDYTJoSpWQAR/eiAUwicpPrafM93CPHnz/4qesiXWKDOiPJpc+d1ElxGqrX2Ej+M6wqc0/q4sv6cO7roZw20W79kKYvB9ISGgN7BUPDPMeVjXcHoVXU0RkKvdEjZbR9is4WvdEyEZJCqVk8IHwV+VMg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26540aeb-25c7-493a-bdc8-08d7fe7cbb22
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 18:19:56.7022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDoOp3D9eu9dXNaxKE+9N65U/XKdpLBt4ZYc9/o5dsA6r4h0TC28GuinvqQypK4d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3482
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
Cc: Gavin Wan <Gavin.Wan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For SRIOV, since the CP_INT_CNTL_RING0 is programed on host side.
The Guest should not program CP_INT_CNTL_RING0 again.

Change-Id: Ic336fab3b23b8371c9e9e192182a3ba14a8db8e1
Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index bd5dd4f64311..39275bf79448 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4558,6 +4558,9 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
 static void gfx_v10_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 					       bool enable)
 {
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	u32 tmp = RREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0);
 
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
