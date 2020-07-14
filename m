Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6E9C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 06:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA32F221E8
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 06:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c5wOhD9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA32F221E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E3366E8D3;
	Tue, 14 Jul 2020 06:55:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E1C6E8D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 06:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U80YEgl4Qms8wpty6q2J460k4MtxQF1Et4m+7jw7jihKQVWFgRGydH7QIPZR6jjeRJ00tOstGrujKbkL5LSi8MEaHI3my7yNC8hGHeWQPTsZKEc5Rkmu2cY9Si3YgPbN1wjU4Ug6sLrVSrnBmGd2ghuXvHZdbpNMD+D9eOiTgNu3Ju37LC1Y6mk/xX9pDHnkYavz8hkDaqL3KmVgY42KqntEB2hy5pr6vMpAX83wGftWDhcb7FORZwXgkyDEHkIFFoLMqyCCkI6Pg5jFXUBzFqoLLlhS7rg6XaHkf9z0YvK5fCAE/mrjfa/gD6uk0mo1AsbS+GkyOzSR22QZ1+nn4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cirIaA90ZeUjC89/PPv5UbAixwokZyyXtfQbyVHUGUg=;
 b=ZudnUMMY+ELl2mMprfyUwSaguXgToaunrpLUT0ewZZH3uPzlimyZSLAWwWXNauTLXn593rUOvag58yrEzuMD4EyQf3E0DvpBuZpocL2qfArg5r7+gI6dWV18XxrRDxhTYkQi6pa9tUwqqOoGRMg2shbJmGUosyRVVLQ448ENjTB1XN54mhHIXDg0pit8DSfwyg0eQFS1VkK5KYAq3NM4Hk7ocZo0zKoYqhTloor3bjyyAdMyvz1Hsr3GRw8lE7MH+GQoi09qub1CEIKfPm4YE3WfaGjcOSGSnhdT3MI5JY7BaJp9MuptMv6i5qZUbAFD1k+rLztgPC3Ej4sw+C34kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cirIaA90ZeUjC89/PPv5UbAixwokZyyXtfQbyVHUGUg=;
 b=c5wOhD9+TMZ00QH9eqkSmt+5GECIJNmpzj3kpKIp/sR1+58BobKujoX6ZBO5ZiaAyDlx/vaBnSKu6CHWKLYHqFvYxs1wCRaz8KM8xcYVEJApNa8WBXl0stJKvfGYWm2B0cL2BITn2I7yxN8dGD1+cXVh0YQMP76LgcAaUjM/Usw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1866.namprd12.prod.outlook.com (2603:10b6:3:10c::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.23; Tue, 14 Jul 2020 06:55:09 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 06:55:09 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 13/16] drm/amd/powerplay: apply gfxoff
 disablement/enablement for all SMU11 ASICs
Thread-Topic: [PATCH 13/16] drm/amd/powerplay: apply gfxoff
 disablement/enablement for all SMU11 ASICs
Thread-Index: AQHWVnVcbomrprovwU+8M7QtboCN56kE4CZQgAHKBwA=
Date: Tue, 14 Jul 2020 06:55:09 +0000
Message-ID: <DM6PR12MB26198351D67CF41C088FF4FCE4610@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200710044746.23538-1-evan.quan@amd.com>
 <20200710044746.23538-13-evan.quan@amd.com>
 <DM6PR12MB2619A21F1F0177201E615D10E4600@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619A21F1F0177201E615D10E4600@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=670bf73c-cf4f-48a4-84ac-000074a23f62;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-13T03:34:37Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b6a1db9-65c5-4865-b0a3-08d827c2d929
x-ms-traffictypediagnostic: DM5PR12MB1866:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB18669E5F5070C2FECBF1F5A4E4610@DM5PR12MB1866.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:549;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ecuezGj50IKiEJ7F2XOpao8+WueFHnPh6oMKzgE4F+dx/zZmwrLIfUCi4bH9CgEdbodVj0DYy5iVm10/3Evqgsh1K21534o9eAinaYq0CliwSFbzEcGwre44RLhGAufyiNkdYvI6SRIPWU511NUUgfRstAEOAj5E4zwLuAhmHWlv07DnfoGs/GX5RlpoJBBZihTgWXTIahcGGXy4rI+PsTqbOmLfRMlBm22dms7HTsfdC0U2oMUIY4oxH1zWolUB23BQ7urvevcryQsWHdbi8I+F0VqR+VyuH5k8DcWm68iLEdzn4ORN3ALYsPfqzWQS6onAuUpIvwEzZYgAXqmbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(53546011)(5660300002)(52536014)(83380400001)(6916009)(66946007)(66556008)(76116006)(4326008)(66476007)(71200400001)(66446008)(86362001)(64756008)(2906002)(316002)(8676002)(478600001)(8936002)(7696005)(55016002)(33656002)(9686003)(186003)(6506007)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: BZl28iAuTFKcxuhD9N13AYJa0yUbJvu10zSdr2GbweF7hqr0dOIelwN0wqqqbHCtqXP2i4oLYYPnYJ9fERTpj7M51qR366wWYtfsLN2rRWpMmxw+Zpr4UIeDo1O3gcmeGvl/wgvXiXSAHjOKHTjaySnTUP6EhKsdexfD8V4b+kgIJCiEA2bzkDV5WoC8zpg2+wwesdY8OdtYXD+3i7Q4xMXDcVdksvqzGVwuD+O/IYze4dAwtQtFVi+VEwrLNBKLBuYf7hqm8zZ1UgQUmN1xjh7nff9Da5bcuBJJ1fTAq5MxgRnm0HQh7GJxfACCJrvsS0XWdchUNLOxLcoeSZlfwx4pmFaxqStFQAAFyvhPwIoudnTqCt1ZGAlIMVzYitHBOPdA6ACz19T7S8PoBIW+vJ1RyFmWlMjTk04862TZAcqfACCfJ5HMe736mPOwlE00AvBg5ss/LirI3nJAucPz9I1Mf7rkxlr4l1DgbZPsjo2xob/igmphOFcruIdsFqWf
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6a1db9-65c5-4865-b0a3-08d827c2d929
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 06:55:09.2532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E0TNdqpZbp4uEHCuUpLZdWE6U0ZzrGwoW/NGlrDbzDjxLdaqabsOrx000VftPHja
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1866
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,

Can I have a RB for this patch also?

BR
Evan
-----Original Message-----
From: Quan, Evan
Sent: Monday, July 13, 2020 11:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 13/16] drm/amd/powerplay: apply gfxoff disablement/enablement for all SMU11 ASICs

Ping for this one and patch12, patch2 and patch3

BR
Evan
-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, July 10, 2020 12:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 13/16] drm/amd/powerplay: apply gfxoff disablement/enablement for all SMU11 ASICs

Before and after setting gfx clock soft max/min frequency.

Change-Id: I6f828da8de096ebc0ae27eaa89f988def2d547ec
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index c2779d0b51f6..33e0718f2635 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1758,8 +1758,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 if (clk_id < 0)
 return clk_id;

-if (clk_type == SMU_GFXCLK &&
-    adev->asic_type == CHIP_SIENNA_CICHLID)
+if (clk_type == SMU_GFXCLK)
 amdgpu_gfx_off_ctrl(adev, false);

 if (max > 0) {
@@ -1779,8 +1778,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 }

 out:
-if (clk_type == SMU_GFXCLK &&
-    adev->asic_type == CHIP_SIENNA_CICHLID)
+if (clk_type == SMU_GFXCLK)
 amdgpu_gfx_off_ctrl(adev, true);

 return ret;
--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
