Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F64C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 07:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E5261990
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 07:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E5261990
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B2636E85A;
	Tue, 30 Mar 2021 07:05:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB5AA6E85A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 07:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEjrxCm80y3xmdJeiP8f7YwHJD2obcLGGpj0S5UL9LQlYvVZszD9iJSV5RXDkToKtMw42hNGrfaVC6Ue8MReYu3HnDFkQ3ounT+uImklW36dQ+42h9PsRV2aanDaee7Uk2el9vPPt5EGXTOBBAj5bI/7Shcyk1M9HF4p+G0T1K0FYWdEelDzJFVMuNSHH/O9C45KGYSfZJTb2AiFmGKfN8cGJGRWgVRwvXNXCieVCVcPCx0jvPlxpdXFhfci+NGBytcXrRfYIPDixy+r+a2ZTY1jgmMZk13IrqPYQHO35RnuXKAl7aRV1wfmD+kT3YwPBc8FKhsYhtZD9zPLrGqA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAOvxmI7F/xi7qHYdKPEMJosvXPLVmsR9x5qLbiJf+0=;
 b=mINqbDeQnfg+gX+8dTMPSDj90924NR9gFZmDtEh101rvnTZUnU9nv67KiXllMhvg0SYSWTfeOkrG2AxtXvdfrZr/LiVuUr1I7RCqlXCgRgCEkfNq51U8rT2u20LeguaJRTYDb0tGyIh+mr+kVhC6ywZ+OPhObhKiyC43Y5IhnxqzG1MHPZG7cLP2LGjlh1+4KkqduflD5fFHdbR3PquFlSOXneI24Rg/ceI0gqllhAi+gGyujL+pyidCDvYQJ5Uerbi0J6MkJz00oAh68wi6b5dvO7axcQan7VIvZ0DUKA4xBXv/+SmahE1B0V7DSMm1nHTAq2M8nd8+OY2BjoKKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAOvxmI7F/xi7qHYdKPEMJosvXPLVmsR9x5qLbiJf+0=;
 b=0SlRCUG5/rg3rEdMHL8hBvuEIRSPLUoOw1xixmDs/Dd1FYQuJLjtfDqIW1h4UZJuami583mD63aLpfVG0+T3GD71RTPOPrQmhBBK6bpWgWqo7cr8b3mGzK1aQUprsu8SyN7DLUgFPR3T05OZMfVaAzoMbzmXeCOLhhKlLYOt7yw=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB3793.namprd12.prod.outlook.com (2603:10b6:a03:1ad::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Tue, 30 Mar
 2021 07:05:23 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 07:05:22 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
Thread-Topic: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
Thread-Index: AQHXJR8L/peRjH4zbEygsNZNCOiQ/KqcF2cAgAAD3/A=
Date: Tue, 30 Mar 2021 07:05:22 +0000
Message-ID: <BY5PR12MB4115A92F867D543FFF7444798F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
 <20210330044147.57802-6-Emily.Deng@amd.com>
 <BY5PR12MB48854A0C129A2F6BE99503E8EA7D9@BY5PR12MB4885.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB48854A0C129A2F6BE99503E8EA7D9@BY5PR12MB4885.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=94eb1d52-a1ed-4f72-a46f-4ffdcee5b90b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-30T06:37:04Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 703a23b5-c093-4172-de54-08d8f34a2fea
x-ms-traffictypediagnostic: BY5PR12MB3793:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3793EF29357EF8BFF77C3C978F7D9@BY5PR12MB3793.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JPSt1m8alvHsP8StAigT9qqiObEdOa+5ApQ4Ar3DzMpxJC7Fklm+eQkkOuJb9AxiJMfaI0uSyhmU+kAOhZRI7QyezTX3w3+a9iVJHVc4JL3F8UPqgrU5UTmNJKuI9N+6nXv2N1KMLrI4w696ONOFIazHyqTBFfb2dTbafHOn/0j/hsMZmBrgcjTPk9Ij0eEEYkpIwWwLWBtntwUbFjfxcQHscTlKQUnr67b/xCk5BMMjVV/IXlrJEgh4dCu+unL4vmMFnLwUUCxHb8mMzk4DkX16xNO7g+EmlYjgkvjrrEHepruGb0WYAS261itruP8qUwqTmal/5UtaerCYNoMrrlrWxipQx9P0uYLdR4507oX45j01EuCMF8AXHNBWa2YSoae0NehYJDD5TEjdgyNM6/8SCm0hO4AnbOglKwVJuJagLM719FtqQmmag4y8G3dMP3+9usfTF9o3+0xIquKkVfHZ1v/kLOagEuwYs1BKHW0aI/X/iPW8Y4akrSMFcYbXXFS74IiRfAc6vuygPnhJbVVdj7NwuRgG+XckpRxKhyQ6izMkfvZN0gpCOBUITHBCYByA/2tx6rOj7ydgWyQuetj/KjXKGhTBEALpEwBB3O/cUPb6LlaHxR7XMcNkfS2G+NaGCs1FlMpAqGRIgRxM8MFlHw3yxEaN5x8hbUKqjqbZkVN0Rj0Nr0zqCaXd3cXy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(33656002)(86362001)(45080400002)(55016002)(6506007)(71200400001)(478600001)(38100700001)(5660300002)(64756008)(52536014)(66476007)(9686003)(83380400001)(76116006)(110136005)(26005)(66556008)(316002)(186003)(7696005)(8936002)(2906002)(66946007)(8676002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: msFxU+65QkR82EudGQeqDK9QuoN4k+U+yZrJTUvC6QyJLJGWeknaBAkhcyp/n0wYtkWuQ/ef6qp2OydUShOSeaslwxagg99mmTWIpPHnHkUNrepuy5YQWwv29p8I0byhNSZTINJaPso0dR9fPP/CyWtbh0EHVS+gzVX8heNVxrF7ZLQpvZzqr1Ysn9b3qLjYC1GalWBplWUlDHqK7CFAMrAlrOodqSHk19EP2zY+vVhXmEBKWKUhAce0I5ovypo25E/A+UITklckZ/i/iULgmfA9rWNvpobirO7XazspOig3X5US2whbjznUfKOvj+i6lbyF9XVZMBZ8vYactpvp900Bdq/qYAUA/IgWxeYMizsCbPfPCK0BB34tLUbC65sPXDTt7UJSe0AW3Q/Ih+B/bvppf8ArQgj5OIID9ZmEL8D7DF4SFGbD2ue4ri7MGwPOYzv/Dg9R33Ma4ArDxM331AU9YxHQxOWETzLz94EvHbYXaBvkb+zIje1YfL8lL9sLixiHKwt5gXx48qBHoT+LPcgPRUl53Y4SiTlt6zZaeqApoA6lBgNIVSd3Rn0HlrodEnEvx4Igimhm5XyOeSIsnW3+ZDzvxvfB87z0Ac1pN2Bnk809kdpXyoCyY/w1Slrq/VsglFjIiqEtlD6+sCt9TOW5FawBgHMU7hFT5rrwcpFxhA+LARPNmcfNSNIYjIine1g9E/QGYZTN1Q4DSREEXIroYyH6P+GSv3wjYfdJNkLjN4Wa12eQ8LuGCFKJly1H
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703a23b5-c093-4172-de54-08d8f34a2fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 07:05:22.8353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gk7Otkc3zxegd9OKhXFALYM6WukDT3HBO4RHTfu2UzIKlss199UNd27kBLzWWVET
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3793
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Jiansong,
     It does happen,  maybe have the race condition?


Best wishes
Emily Deng



>-----Original Message-----
>From: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
>Sent: Tuesday, March 30, 2021 2:49 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: RE: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
>
>[AMD Official Use Only - Internal Distribution Only]
>
>I still wonder how the issue takes place? According to my humble knowledge
>in driver model, the reference count of the kobject for the device will not
>reach zero when there is still some device mem access, and shutdown should
>not happen.
>
>Regards,
>Jiansong
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily
>Deng
>Sent: Tuesday, March 30, 2021 12:42 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
>
>During driver unloading, don't need to copy mem, or it will introduce some
>call trace, such as when sa_manager is freed, it will introduce warn call trace
>in amdgpu_sa_bo_new.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>index e00263bcc88b..f0546a489e0d 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>@@ -317,6 +317,9 @@ int amdgpu_ttm_copy_mem_to_mem(struct
>amdgpu_device *adev,  struct dma_fence *fence = NULL;  int r = 0;
>
>+if (adev->shutdown)
>+return 0;
>+
> if (!adev->mman.buffer_funcs_enabled) {  DRM_ERROR("Trying to move
>memory with ring turned off.\n");  return -EINVAL;
>--
>2.25.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
>eedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7C1b4c71d7b96247
>6a367508d8f3362f40%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
>C637526761354532311%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
>MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat
>a=RxRnZW0fmwjKSGMN1nf6kIHRdAPVs9J5OBluDYhR6vQ%3D&amp;reserved
>=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
