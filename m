Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A30C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 02:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E600C206A4
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 02:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Wf+BT9Li"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E600C206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 676736E112;
	Thu, 11 Jun 2020 02:06:39 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770082.outbound.protection.outlook.com [40.107.77.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA276E112
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 02:06:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgpDdrn0h7CDROFu+Wpbfi14PrIiSglgpiXOIJvB6hcy1VcChiQU0cJ7U/cwL64qOjam6EvjkbJeGQe+wEU5xyenV36AygBWl+oyercXXvzuTnQZSTDj5QdliWtDg+KZKybjKLc1+IWYDWWa8yVZYOQffSTvI6SEhyfISNKV9WIcMZzptMmgRLkQbd+RbxylkBCg4zXDjF/RCHhIPyXZiXh22aYSRNFYOXP+EZn4cXTZhv7fyhW+ZMFxnpAAgrB3EaBiq5CrfPPnd6CWvjxXEEohhwewfz+1LVMqgyjT9O2Qxm2OTQC9gyTBrRtLGkhkvVZv2enzZVoqWGe9JdDiZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ1I9FumVFYX4YSoLJV6h4gCXwhjRJUgL+wzdW/ij1U=;
 b=Q5oascKcLjAIQnUZjyMYRsY8T2IGyEaAxLxbZnQ+MzrCMeu7iZ9KUN8AouilyIXWIfF+qDH0Bymd10VT4lGR1ZIrVycP+AgRFevw2/2IjjfA79CI0xngPek2vJy04oJFHzNGJwHSUPeustBZkbT3ztYlCELk+w/+XZdy7Jhx7hF19FDC1x8k6wk/pFTvyLfEYS6RJ/0j5nV8+ElojDYamN7EGRoSGmgF0YbAUchMH5NOWlKm5ACU3GotWQiCh/qcVr9X0Ys0XohUka/eQ0wTy9OYgzgbqNFDHv1xS/1Ux7y6oKOqbK/zldIzPgwku5qeiXs9HKkBdF41hktse3BMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ1I9FumVFYX4YSoLJV6h4gCXwhjRJUgL+wzdW/ij1U=;
 b=Wf+BT9LiO/7vVUwN9ramqkdDzFuNnv96vGi0kyKbD/EJcgy3oIuTW+6LpcL/OvPIm/RtE4BxQjdEokb9o8dlg3/rus604EQjkpLGWs/vXgOnBj4I63UQtiIFco1JVvOOTLwUYkPvP0wPTGJXSWdKO/kb65tsF8ptEl/Oq8ilwYI=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2599.namprd12.prod.outlook.com (2603:10b6:a03:6b::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Thu, 11 Jun
 2020 02:06:37 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::c4c1:ff62:fa6c:18b8]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::c4c1:ff62:fa6c:18b8%8]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 02:06:37 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
Thread-Topic: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
Thread-Index: AQHWONrACdpiuH6q1kS1r7FJKcyr/qjRuwVAgAD881A=
Date: Thu, 11 Jun 2020 02:06:36 +0000
Message-ID: <BY5PR12MB411517EA5E137690BCACBF4B8F800@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <1591101603-21219-1-git-send-email-Emily.Deng@amd.com>
 <BY5PR12MB41153A34A6E46E77BFE56ADF8F830@BY5PR12MB4115.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB41153A34A6E46E77BFE56ADF8F830@BY5PR12MB4115.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=973d09d6-d4cf-4e29-bd41-00001b18b1e4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-10T11:00:35Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02d7760e-1297-40ba-fc06-08d80dac12af
x-ms-traffictypediagnostic: BYAPR12MB2599:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2599784D15281A17F5C5E8C68F800@BYAPR12MB2599.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yA72MrSFkuaGb2LXcCnuANm2CDX+cVqqwbwKO16pvr4vH0DOwKh5Cbkh+7pZqA3E3euuoLDB+L7Ti6QvVG6zYZBH5bhnTMbEdbsfBSoaeweV6mqstCcDLLhtXnU7FfcAVoksDO1JDwRx/AX3MXpPSYxPJUrqAOsfGpTcESyPMzoQEgZgXp+eRwF+LtOZw/rCj8XkZjjC+MeOM2e6ojIZCk2tvPGuwiXueHEpURpo54mP247hgDnIPGvwPUjmwNg8R4d8nKqa+G4ntYlTWUtKuVcCVmH5jd8WGwPnVYsOhFqsd1YJAZZ8G+EK5du7my0CQDE3tkgKUaY1HaMBIoinIA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(8936002)(186003)(83380400001)(64756008)(66446008)(6916009)(33656002)(2906002)(26005)(86362001)(71200400001)(478600001)(66556008)(66946007)(6506007)(8676002)(9686003)(5660300002)(316002)(7696005)(66476007)(76116006)(52536014)(4326008)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 5s7gXTiVlBNF0y9FyYKboSL4Rir9pzkMzc5dCdSoqfb1zwOYiXb7jgVAiULQJysnduR69hNUmibuldzfGLXoqUbk/NqHHWkFLVX7jbpPABhcc5rL/Llnkr6H9x0Mdr7ef8JkOKwjCspN7HfnqgT4GPbFvmC9EeOiOCnLQ1/GjWTziK6tLJW/wFUM8Jt5qAl6Fb5SoIXDtJSGBtKNP0aVu8MIeIEEd6IExZLxz7JeG/Vzpz75btaRqRHq0y8AkVmvxp4T5eadSjVx7rMyrvjWcZiN5tevEJb/Q0w7xi9+y3/Xr78E8+a2Xa64pbsXwWtXGVNCIY8kpx4BSzKBDw8P+RPqg4q7slwp67B9PLXBlxhE4BgEXCezXubm60nRt+kTLA/IngdAPmJx4rO2yglgoPaO6tjiIYzh5r6R/QjTkQ3TGLO5eD+FNPNMoHyPZCxuKhUQrB2P9zFYMZ1/9juBNHNwtIQyJWnM74iYkR/ji+IrPwuWcMOoaftwMkOlFGdN
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d7760e-1297-40ba-fc06-08d80dac12af
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 02:06:37.0899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXuHq5TquuY+HqlNu5zhQ9Cnq2jRxyfptC101zldtuTl7IM3zA8pjeg8sF1L9xaf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2599
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Monk,
    Could you help to review this patch for multiple vf?

Best wishes
Emily Deng



>-----Original Message-----
>From: Deng, Emily <Emily.Deng@amd.com>
>Sent: Wednesday, June 10, 2020 7:01 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Min, Frank <Frank.Min@amd.com>
>Subject: RE: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
>
>[AMD Official Use Only - Internal Distribution Only]
>
>>-----Original Message-----
>>From: Emily Deng <Emily.Deng@amd.com>
>>Sent: Tuesday, June 2, 2020 8:40 PM
>>To: amd-gfx@lists.freedesktop.org
>>Cc: Deng, Emily <Emily.Deng@amd.com>
>>Subject: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
>>
>>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>---
>> drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>
>>diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>>b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>>index 5294aa7..8ed6c90 100644
>>--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>>+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>>@@ -1311,8 +1311,10 @@ static int smu_hw_init(void *handle)  struct
>>amdgpu_device *adev = (struct amdgpu_device *)handle;  struct
>>smu_context *smu = &adev->smu;
>>
>>-if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>>+if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
>>+smu->pm_enabled = false;
>> return 0;
>>+}
>>
>> ret = smu_start_smc_engine(smu);
>> if (ret) {
>>--
>>2.7.4
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
