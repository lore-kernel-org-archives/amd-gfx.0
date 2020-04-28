Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D02C83003
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 02:31:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A0A206E2
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 02:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oW029+cr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A0A206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD4506E17F;
	Tue, 28 Apr 2020 02:31:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C126E143
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 02:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6A0fscClOqoNqpNk5ePlz71G9XVOmWrm/b0VrERfbdkTTpn51lZZiB6D44AWPO+WHEegs+B5VI+QssyIfBNZv7X8BogRJ45OWXttOV9LmcRCDM1oYPMFK3GHEdg2quqbsVDsUJNnAkGMMvE01OFpMHgCGym3IEyoEqy/Oat+78Ff4TmF/ohcQZfODjAtNChxIeb6QbwRlKBNgxqRxQqjD7PVXFLe16kbK8OyFBhHLPu/WVwmJeLKHrFo/HUk8KmX4WwUjhRvFcDzkI/3FqJ00OSifRs/7REE8trmRMpbUh3Zf6RK1AXE1xX8m95sjpGdzY0HxiEI3PH9IG9nesrog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9G2ZjOlFwZooWDp2kaEcW9jx/AmgNMN6F9L8azpeXe8=;
 b=JCvuHpNgWSY3IqipWxy2KIg+y27QsTJhohY8Y8BwQZkZ9UZudU3jR+w1mSacdd9Del7qf4eyw/OtGTda6GQMMUg5crulsWf9TjbVlBEZltJnfKicrh4Gixk6a6Tm89FKFvkzZCy6l9fnxsERlKv+gzFX1/Mi8uN5e6RF7GhZ0nrbKeiMmvSy+HUvy2jT6aHUHyxQsK8evxIsHc1OfUFJcfcVpZzgg2JBFtloSvzFHS157hq8Y3K/uLzHb5MAXfVbaJIeLJBcvwJ0kVQ9JCtWdXBKKFY0ePYPogdKViwu9qf+E8SrrHdlsQBqi1MU/TCTxY+Uy0FA0Tk+GJF7wHVMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9G2ZjOlFwZooWDp2kaEcW9jx/AmgNMN6F9L8azpeXe8=;
 b=oW029+cry4JlBbPnM87qOdVMSf8p6M4qZdQvIZwiTvwCJRTpng3kis6tuTM/4oBr6ijS2vhKIVO9JwvwEOXcnJtqSKHvmN8FjXmUM2q0pgANITI8F5HEtE9zNAJeCy+0zByVUB4b5wWObW1CbqrzIICr0XNhPkqMosyt3XTapdA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3723.namprd12.prod.outlook.com (2603:10b6:5:1c8::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13; Tue, 28 Apr 2020 02:31:12 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 02:31:12 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH] drm/amdgpu: address the static checker warnings
Thread-Topic: [PATCH] drm/amdgpu: address the static checker warnings
Thread-Index: AQHWGiTu7I5Scz2wt0yMwTzPRddleqiIG1QAgAKhFICAAxliwA==
Date: Tue, 28 Apr 2020 02:31:12 +0000
Message-ID: <DM6PR12MB261984ABA35E54EBFE1CA521E4AC0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200424104115.28738-1-evan.quan@amd.com>
 <20200424110214.GR2682@kadam>
 <DM6PR12MB2619DD18E7E97E62291C1585E4AE0@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619DD18E7E97E62291C1585E4AE0@DM6PR12MB2619.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 33ade8b8-c6df-4532-19bb-08d7eb1c37bc
x-ms-traffictypediagnostic: DM6PR12MB3723:|DM6PR12MB3723:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37236ABB630C88AD4E2E5D69E4AC0@DM6PR12MB3723.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(54906003)(52536014)(86362001)(5660300002)(2906002)(316002)(6916009)(7696005)(6506007)(53546011)(66446008)(8936002)(26005)(478600001)(64756008)(66556008)(71200400001)(4326008)(33656002)(9686003)(76116006)(186003)(66946007)(66476007)(55016002)(81156014)(8676002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IhcUtpTpzodzpNGalDB7+X/ng+RD94JMlfoKDDQtW3P4fCoTIRN88Og0uut9/TeOlFG8COZkD8DgJVYJ5Kz2FNzMo4VA0araj53fVcW/piVYKVLkHgBF0lVjDGOzhkD62Ptszv26p1hY5xaIIjkO4+lGjoagKZEbRlfroSmZ/fkUGkd2zD5l916iwCAETK6kx3ssc/hHTO1IO1QjBNWKX2ffcmfhgkn8xnDM+fYDrBjIIAEYe53pt4OHirDKN2hMAshcxll4+dTWYVCpYa+YeU7098q5nhU0CTCpJQu15L3MhTP0ed6bpj6COiqQicDR/O7kFUfbtsYyGFYPctTivJwwqJOPVJdQVEEyGqsNpncoOuQSMQGEmfku0G2R4oTZx08n85Bj3sUyNZPQQ3P8ifFiY4yUKtTc+Z6D3NPj765PMWf6aR+v42tkxzO44inG
x-ms-exchange-antispam-messagedata: 2eGh/o2JZmXsALgr4dcQkj0gL2tSJmPk86PEjl7VODCQm4gktsUxCNz1fLGEx9GYTXZevFM59D/qEUeTCL4l5OPDR6ULMIMSSBbGyaRPse88TkSOSkHKrNAcA6trrKBEZz/+zGnIGy71WycnXXgixHykDxmpBOT4CZVP/pFcN5PgI1yy5S7WsAkjiyKUSvmZ7FiSFs+5n96w1IJ5PIgGuIE+Baap+f/N/w6hsBh2HAMrMe7E+fogE9ADLVoSNHfekcFHkAKDjCz4dn+tj38rGDJ4Br+zA8l2swndH9TWj6myjlmO7DWZFixul0IwvdpyxEptN5D5Gngz3q20zzYfJ6Y01FAEhPH2ScJtw4xrhQIcz8UXbEWANlal3kHeWN3lFi7tvAvEW6rCiIon1zQdyy6sbMO1Eo7tVrJhEM+zm47okgwQGuhzz63V8ogjtdirzsOSIph1IG6MAHHzJ3BLG4/Az0RHxC7SS7YRl0DiYlpT5J3ZgJScDsixsxHcaDeeQGtPPNUGpVxKHEGXo9ksChN+r684SJW04oqtnfoausUTjlunGfN7dMbqGQfsc0taUY2Yv63ap1K8SRkZeTNcM6RwPSVFs05z5FF6VbbD7BQSwwfEhhkUBE9PM705iRyDFclXvVyoEYo3kDtscrSJlYWK6k+XqUpZhZvvGGF41l6D/4CQ5F5OBOcRLqBODZ9o2jzM1WEZG6o0Qas7GTJ67CdcXoXk5uI2nZhGfVUMcNeAc0CPqScSZq6R9WirOOGyVQkAiQEtSl60gUr5AyoBid+JD/B478B4pBmVu2AAnqc=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ade8b8-c6df-4532-19bb-08d7eb1c37bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 02:31:12.1318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LrcW4X0wpf7o7n9Ve1vHeOdQYis44ROeG0JQ+qL4fQnStF2EhRIjfFKDidJDDgSO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3723
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

Ping..

-----Original Message-----
From: Quan, Evan 
Sent: Sunday, April 26, 2020 11:19 AM
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: address the static checker warnings



-----Original Message-----
From: Dan Carpenter <dan.carpenter@oracle.com>
Sent: Friday, April 24, 2020 7:02 PM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: address the static checker warnings

On Fri, Apr 24, 2020 at 06:41:15PM +0800, Evan Quan wrote:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4199 
> amdgpu_device_gpu_recover()
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
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

In the current code, we know for a fact that "hive" is NULL at this point. 
[Evan] No, that's true for SGPU setup only. For XGMI setup(multiple dgpus interconnected with bridges), the "hive" here is not NULL.
Presumably this will be changed in the future?  Otherwise why not just delete the mutex_unlock() because it is dead code.

regards,
dan carpenter

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
