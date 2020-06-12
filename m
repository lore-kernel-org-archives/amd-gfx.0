Return-Path: <SRS0=wil9=7Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE144C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 09:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C9D82068E
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 09:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v/jOXKw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9D82068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027826E88A;
	Fri, 12 Jun 2020 09:30:55 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690067.outbound.protection.outlook.com [40.107.69.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48DF66E88A
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2020 09:30:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZDeD4pUpRGBcZaB7FdgH1dC7SpMK3ECeNVruSP2KB30auGFAMI5275rLiyTwJGtAykGyShcgrvr5f0FGlzEm2IzBUoZWje/Di4YIbkhQiElwfw9Cxp4uiH88xIm67HHCvTUttWgEZjIcyGrmueeYQEHgTy1t+4zcABd19K/8KrQn1s+KAVIZ8H0Lnid2W+ADHBz66jzqwcOw5Eq0yFghu12iw1+ZhdJOq5q7s15WubA23fCf+fghphnq0QX29mnBQT7pkLE2fFGjVQsV+N0P9sdPxLUcpyvye2cRU8HeALgbdMzNyaCflMPZ4M027bP0NluzphSQGKPCq/hjeL+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nP40Mltebyj9bTzW2UyhtDWIMPhfDxgskO7aNOJn5yI=;
 b=jgd24nR0rw0Sho+mbtBati6anjG1F1cd+1oT8GLWUm3wmgEtwogK8R+XHs+FAEEzLY8dIHjPxeKKzWl2GXYllgcgE2hzCuIDvPVYmJqh0zOwo7zX4riS6sd+Gid/gpsiYR7fdELgJQAWsYiG6jaqed4Pw3cil7Qg/koxXCEy+aO50YLclbnLNGf2kdN+Oq4cErNH1MQVzJUWAKP+dyrkDHh3lUXWYiwOhAVh3TI6PmvSROFrzYHcxynDIWqq1rMeCYPQ8hi26jlrlyd4VaYPqHkO0i61qbGFnL5dHCm2pcmA72kVys8TLrIYlWp0rdbJ7CGMGZV6AFtForZ0+jx7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nP40Mltebyj9bTzW2UyhtDWIMPhfDxgskO7aNOJn5yI=;
 b=v/jOXKw3gW/DhBcp6YJ9d1/HvrR/CxIjIqeFdkvUUjlEQTj1hGajW8ZlQ8kGGNywv8e2ZuLa3yN80hirNHVpLTAag5fl3lTMzwFEvBK12UCOhXRpF5vKITi7mmiItKhwPqmhwNszqueDJ3kPkrrlW7CHSdQxKsgt9DORLuhlMiY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Fri, 12 Jun
 2020 09:30:48 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3088.021; Fri, 12 Jun 2020
 09:30:48 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: remove perf level dpm in one-VF
Date: Fri, 12 Jun 2020 17:30:34 +0800
Message-Id: <20200612093034.19799-1-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:203:b0::13) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.245) by
 HK0PR03CA0097.apcprd03.prod.outlook.com (2603:1096:203:b0::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Fri, 12 Jun 2020 09:30:47 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47addc02-a263-4803-a972-08d80eb34a86
X-MS-TrafficTypeDiagnostic: CH2PR12MB4248:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4248EAB09F5057246782B4618C810@CH2PR12MB4248.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-Forefront-PRVS: 0432A04947
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRkkgvQAnw9NHhK+BHp0UO8P51LUxznbUQU2qrEuownGENP0ilp1A8Azby8YsF66aFtO4syusAzIF/mX0h9CKDa7900mAa02zvZi4Md5y4GW40b/O1sILM39e6uU6RnQ6CSHriuCKBV4PNhkMEkuhLxsVLmp2lyn0oBFlGtPtRvErj+rN49nBW6teUTxmHJS0Z0wUmAGOLZZogAejg5xUQcRvWJxZRwUDPQyh31ZmSt5JZG+/BGs+AJZIVwvdtp/3Jl+ACAC2IRPxtoAKOyk2d/kvPA4iP1QsMjLBuethtec5sWWC5nsn3GNbLyE3rLi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(86362001)(316002)(6486002)(8936002)(8676002)(478600001)(66946007)(66476007)(186003)(6916009)(26005)(66556008)(83380400001)(36756003)(16526019)(52116002)(7696005)(2906002)(4326008)(2616005)(5660300002)(1076003)(6666004)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: yCilYxGrgoK3HHq9YbIiApp3ImjEZuQUbknz5gAV6Mw6eN/2oYgraAsnEyDk/k0L5dL04o0T6xP1ZUo2zcQU3UVj5n4DFun8FSsDVh7fzZqeu4iV3kMAy6+HGXZRyI+l7BCc46How1oBfR56MEbxZHy3vGRr4nHO8Q7jgDdOI12Fy1RQiJBU/WIqfuM8B35/Z+TGRdo6GSXWT47z76ymYVCBZaIxkRgn62GR5unzFqy7pT8IvVvmMxd91HtcAsBVDiOIBQ1X438eMSEEAMs9tcZaWWy/H0bgUOeeFAZ9Aeeqmihdw4vSPkxLPBQb8ovtUVRS5biIR5PZdTg6PT0ZlXWGVxPkWfkmFfk42cqBFqgs7SQBzFvBNHEIpAbKCXYZxgtGlvB9VTqPCkBRvQntUN+K/6aQpqbIdnvv9HIIVrzqW9R7SB/y0MH3Rt7FMI3lim1gzh63umTulSft2yE8H+fLEtKI2czErPxxdImv/Tm7bBUyn5KmZn/x2qO1LIAm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47addc02-a263-4803-a972-08d80eb34a86
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2020 09:30:48.8375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMo02G9qPN6jrZTb5JOOa+R59cSr6ZKTN0b3Cr2LUWHXqQZrUma0y04+r0zFNfKPa23JgmDxqRsM2/pgRAsE6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
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
Cc: Wenhui Sheng <Wenhui.Sheng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Navi12 platform, node power_dpm_force_performance_level
doesn't work correctly in one-VF mode.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 395ddbe2461c..4e7b579afe0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1877,7 +1877,7 @@ static ssize_t amdgpu_set_thermal_throttling_logging(struct device *dev,
 
 static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
