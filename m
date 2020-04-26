Return-Path: <SRS0=pLrr=6K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7DEC55185
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 03:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 379992064C
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 03:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zlWiX1fY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379992064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3A0D6E216;
	Sun, 26 Apr 2020 03:18:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5ECD6E216
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2020 03:18:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7Q92MlrT244kSsGRI3DXSHrWqZhXxnrq1FaerT0gIgWn3yIEU65ukxg77fT+z8zSjzIeON2lndb8hEAQG/gRhYuILM3xn/VJjOx+EI+Sdn5N9PYrmMcrIzajwFuOjcd9JjulG5KsKuhwSmm7rtXkcEKCXfF3T1RBBurwfJTDxDkqD/cdbhJF/9K8BxeyKA5pDwpXo8ztyxfOyNXWOYjtRib7sQXj8WHPZNC6fGos0ePphKLcZVkNmih8IWhkA3Mvbt4SU77CZCB43i/5ODX7l+EzS8MkGma+OZ0LUbecsfvJI1AftbH3N3QhBAc7BoMrAvP4qbD5bDKITcOdpUI+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DowJqbCruU7X/1rv6/qjm1VlqbDHSDCw+WQitBjEugI=;
 b=h5D95FE+LTkaMABNmwjzAU5SFeHQ1yWi9c6zSO9HlcMmt5L7gjluUhKz+VYhKYz7CVnKvG/VadQ54ao4WT4/3rD1bdZ2HcofbmSj+7SZb9Xczb1FXryt1PbwFph8SHA7GcdOTZtn5LBBJxivvpOKIbUqzN9I0/3VeomxNErRYDfa/rb++yVZLtUY8UXFQ4l4hkRLDd0fWXjYXcKsUYKQLl3vuQwPvZ3jXepqDbeqsIJDCBRndB3h0luvaKkENZR7LTIISAAxfb2pKiHYX9tmfWoR/UpA55QAqz9vYfbhWGiM9fE4SO9ALkk2u1a9RAVoFrQ37B3WKyW7iag67F50hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DowJqbCruU7X/1rv6/qjm1VlqbDHSDCw+WQitBjEugI=;
 b=zlWiX1fYANoN6t7is1ETWPvm2DTQv2IWo2iCNQ3zrfhUGvRhihhoQnkT673emF2Fefg+IWpn0i/QiHt5JQ13uYzK5gN+7xj5bsTfhAan7nl6A51vWkvjz2Jle+ys026S1cVCSZUqugx94SEjwuk7tNrkDcxwXAOY5C+g+QdAdUs=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2649.namprd12.prod.outlook.com (2603:10b6:5:49::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.30; Sun, 26 Apr 2020 03:18:50 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.030; Sun, 26 Apr 2020
 03:18:50 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH] drm/amdgpu: address the static checker warnings
Thread-Topic: [PATCH] drm/amdgpu: address the static checker warnings
Thread-Index: AQHWGiTu7I5Scz2wt0yMwTzPRddleqiIG1QAgAKhFIA=
Date: Sun, 26 Apr 2020 03:18:50 +0000
Message-ID: <DM6PR12MB2619DD18E7E97E62291C1585E4AE0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200424104115.28738-1-evan.quan@amd.com>
 <20200424110214.GR2682@kadam>
In-Reply-To: <20200424110214.GR2682@kadam>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=352956c3-b0ee-4d0e-8502-0000e791ed0e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-26T03:11:16Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65a29cc8-7a58-40c1-1fde-08d7e9908ab5
x-ms-traffictypediagnostic: DM6PR12MB2649:|DM6PR12MB2649:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2649084E1204E28D335F02EDE4AE0@DM6PR12MB2649.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03853D523D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(5660300002)(478600001)(186003)(71200400001)(2906002)(86362001)(4326008)(53546011)(66476007)(6506007)(26005)(9686003)(66446008)(64756008)(7696005)(33656002)(66556008)(66946007)(55016002)(76116006)(52536014)(6916009)(8676002)(8936002)(54906003)(316002)(81156014);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vd0zIPQ0t43g1yBZ56k/Qh4XMYaJwofynH9PIOnkKEJgBn2IdsiEQL63zk4PE9wb9V66VQRw5XbsIufeQhld/AHlK1/Qi1K1wmuBPgEz71SfK9Y1zzIRtKecf3yv2UXyl1sQ/JLK9dAaBGEr0GCXm62GoCE5En9T1CjMFlYd944NpJB5ZvNZxoRuVQUQIMDaTqAjhE40iP4edcaA9R5erC2L4jS/8bVN9Ryw5Wmo9mHBK6fQ57qihe9vlVqMZ6lXmsr2YOM1WUUKfzV+neRszg2iqPvpgU/J9zgObN6A/jvv+7B1voiimvVXBGlnOS9Cf75nNl7cuLIUO4Ecjft3iKMI2eQfg/L0WuB9qAh9GJHsUpZh2x1Ap7i/65d8sVdGeqbpoMTFqBYTs38WID34aDM9CQOnFZmbFUOGOySr5PpCaOSAeiauCHZuhx37qPb5
x-ms-exchange-antispam-messagedata: wKIOnPkQHvsntHe6WTOv9FGMdk+ohH/NQhQlZc9QUR6OfK4yJOL0bdb+/ttuBmBbBBnnKt0TLLJ4FbmudRPHyUVrAtKoyFQ92PpGVuZfZNDr6PVdm5KA2T8Troa/RdJcWz2bTPJy8FvXsH4vN6OeC2JG+C4/vOLM1JF/YLqNmUlTnGhOvuA/i2j7nAU5nsaSZ1t+9FDoXwFYGtBkXFc1SOukN+xe1/PCl8Cvnhgc/5XBcky7ESeIWbWaLzsrjJhq4GjHW3WfunonJLSpUMtPYWr4exJe0urDafpTXUdGX5XKvwGw8MHLcxJjE1RZyd4vU8TBGuGUcSy6OZA8ni862w1BtUhTRDLVdSBQ8UBwWp4rFN8J/jrWrNSCuDdrrF0+cNkBpvF3Q72HZxIg7f8UzLMGyM1Xpbw+kTCrgeUKzsyTZg6yD00sukQPMsOC7VAsKThuk7X2M4KQj6HpSS+zZpoYrecwgOe0wtLfIVewzmmDSdHH/wF2RDizo52bEWxHaMe3XnlLWK4HfdzZ72ebRsda6yJvdBd8QwfwdRB8hVk+7IrFvoSwP/cudhIwhJcH6mf5VRpmOO16Wpw1Ip00ZRUZQrPr+u2kr5p9ghK6O359vKkoZO2rSbX6mcsMNSyNQsAyFv95RnaOvs3lJC/5Z+h2A5G6nHObBQFsYc7FabOqcqju3JzZEl5n5JnFVHD4fWBPrYXTDcsHIaoou/dNT3705GfNs+4zNfFvOq4GGIDQUXCqXHKTzI88dHAcBCa6gUKBi/zbaE6EImoUjdy6AQHMoi+adXdY7UKL/TNnyUc=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a29cc8-7a58-40c1-1fde-08d7e9908ab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2020 03:18:50.7283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJ1kPjtQDPSXfQ4QYoUVuDjb80Qc+SdtxpvpOh0/Lnkc5/vutaniIjItg8tnaRE4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2649
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



-----Original Message-----
From: Dan Carpenter <dan.carpenter@oracle.com> 
Sent: Friday, April 24, 2020 7:02 PM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: address the static checker warnings

On Fri, Apr 24, 2020 at 06:41:15PM +0800, Evan Quan wrote:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4199 amdgpu_device_gpu_recover()
> error: we previously assumed 'hive' could be null (see line 4196)
> 
> This is introduced by "drm/amdgpu: optimize the gpu reset for XGMI setup V2".
> 
> Change-Id: I9c22b57abc9f512114112f93fb035f1fecf26beb
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 71278942f9f0..898338dc9605 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4274,7 +4274,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  		if (!amdgpu_device_lock_adev(tmp_adev, !hive)) {
>  			DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
>  				  job ? job->base.id : -1);
> -			mutex_unlock(&hive->hive_lock);
> +			if (hive)
> +				mutex_unlock(&hive->hive_lock);

In the current code, we know for a fact that "hive" is NULL at this
point. 
[Evan] No, that's true for SGPU setup only. For XGMI setup(multiple dgpus interconnected with bridges), the "hive" here is not NULL.
Presumably this will be changed in the future?  Otherwise why
not just delete the mutex_unlock() because it is dead code.

regards,
dan carpenter

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
