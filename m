Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D789C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 18:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16932312D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 18:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16932312D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6014389D6C;
	Tue,  8 Dec 2020 18:35:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E67989D6C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 18:35:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZgc72sGlIqMvdRIm0ozobU9EYrm7CznmNF7sB0ltNKZxCFoqwYx+auzR6GDzQMRo38IuA4wr9hZ20O11FwQFKt1RaIEcaYm5d/XHpM4XeJ0kQSTIDSnK8ujuyCZm39kTzGnoeExFHDN3XVpoeg7yitYaBQqM8vmUC0E+sZxeS1ISe4Gd9cK5k6t/L0FjW4AGdUPYqPOGdmWnXD/1FpzJ2bSMMLhYm3Bl+/WsPwojFwSFBsdZrRgx5L6d9zDrWpnkAUuPgE7sP5VDrpPE6qOtvukjmtlM7CUPj0tgMxJopZ/2H/MMMj8kIe1EQlGhE9kL/iWHRXM6fVn5VhkRSU/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq9IvYxMlGC7jkLHtsret035aXITz2W/0IkSUgR65r8=;
 b=A0S8HYCsR01LmzlQDYelOkRF2jUE2izQ4BP/gut1MHfNLWrGqXxru/31S1wS7ESJeg7g6hghfTTZ1wU9INbDW3OsCkaxUs01Y33lFmUjoWsMWwf7tCs/53T0XoOBX1IuiImEkrLSD+feCM6mU6Rc9+DNUjitLXmuth6yQxVf0RL4D45mAHPDdV7ziENr7dusGUGDh0lpu7IfU9YKqCev4p3oB497B5XUiL4JiilPpDuwe902H0R+ETtVZ4btImx1d5A+qGmSBX9s8hC4d7f10hpVJMLKYqA1CcVqu3in8PDsNGmQSbruDRe4hc/i3yD5dJ2nKHBFdnrJQJUoDGOPcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq9IvYxMlGC7jkLHtsret035aXITz2W/0IkSUgR65r8=;
 b=Omb1Ou0Ywl1GGdH9my6L8jTy+wFoBgjWTLIpr0maAEvxm4bdELi7G6S4RZkNXM0SDu4+ETbuuLoQfy8Hkt82XJAEFvu2huvC/CO5tR+77ObZbaOh1nPcTLi5gVt+kC183PmBn6k/7efYMi32Gg3z7tw1ykVmiVjjnDA8iqbxXR0=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3820.namprd12.prod.outlook.com (2603:10b6:5:1c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 8 Dec
 2020 18:35:21 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e114:199a:693c:674c]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e114:199a:693c:674c%3]) with mapi id 15.20.3654.012; Tue, 8 Dec 2020
 18:35:21 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdkfd: Fix leak in dmabuf import
Thread-Topic: [PATCH 1/1] drm/amdkfd: Fix leak in dmabuf import
Thread-Index: AQHWzYf6Y17IkZf410WKGQVq5a4ruanthnvA
Date: Tue, 8 Dec 2020 18:35:21 +0000
Message-ID: <DM6PR12MB3721ECF613FD76949E024C0F85CD0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20201208173113.465-1-Felix.Kuehling@amd.com>
In-Reply-To: <20201208173113.465-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-08T18:35:17Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e5857e72-b9e5-4323-9c3a-00009b81c80d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-08T18:35:06Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: dacb437b-37c9-4f17-b298-0000240a20da
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-08T18:35:20Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 300b69eb-9792-4196-bd16-000002e16176
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5dc19a4e-9714-40ce-a09b-08d89ba8054c
x-ms-traffictypediagnostic: DM6PR12MB3820:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3820F56557E48B724C54C3AD85CD0@DM6PR12MB3820.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RWg+8XGwWpoViZ3oUVFuK9mxuDsCPggj4OQ2i3hGlivRa2fo927JfSVgNRj9VgYsPAOwsvOHfwhL9Oq6ptnUD/S/XprhzPOkeWJb7g+be/cGKU7COIs4o37n91O9RTxikNWbDX9Noz/9My1sIlBuNb41dANrgJfTZmJuDi4ZGtsJ8En+ri2VPIX9fNpYo5a0hiPFyJDJdCF/ywzM9KkePV3afejDi7JXyz/7jWNVdBeTK+Okfwq7lhkXSCyUbCyboCfwqPvMxdH6dcz8jxxHa6oY7rYtAdI+aL+jLFY+epfxl1w8HyagqDjZJsPEqpSb2S8scAgsgpRdQAVbWkNDCHPc/BIcZdoqw2QeRr86yDI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(2906002)(5660300002)(186003)(966005)(71200400001)(33656002)(8676002)(66446008)(7696005)(55016002)(66946007)(66476007)(9686003)(8936002)(86362001)(76116006)(26005)(64756008)(66556008)(45080400002)(83380400001)(53546011)(6506007)(52536014)(508600001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NTJaegZEcE+5PpOOFuftomNrZrikQFYeJ8mP76YJIFypjcnUEJqjNMKspS7u?=
 =?us-ascii?Q?pL1kCf2dgtSvEhWhUJbfczHO7nQFxOLUFfAIKIYUF6IRuJTFzLZLxOzsGq2C?=
 =?us-ascii?Q?YTfv83urbd/4NnB408PhhwD+Kgfq0FkyrhI57jGaBTQo2ubw0prrj8UB7rSG?=
 =?us-ascii?Q?W4I4VyKlTd/pu0Zw9RgrsNo7iIavjkYBeUiKkg7W76PZ2RyCqM0cDD67e1a3?=
 =?us-ascii?Q?mxVwNjNveJFW+/MgGFuAnwfdycT+78VjZiwB1NW4cqzxOYgJ7Rw9VTzgXAyU?=
 =?us-ascii?Q?B6ADWP0fMH1xvOzQQ/pN9YNEreRlCyYtdH17RoAp6HKEEaV5QfEzO79j0nv/?=
 =?us-ascii?Q?Vb0ClWwdx1zs16KqkoQHyhkCfoyiy7rHzMXUg8SNNr3OCXhnEh/RB+CuyhR5?=
 =?us-ascii?Q?V/gjN6VgFF7vxZdWTGp3AYXjQnPysOEFATq1iyJYmExbt18h06/WvO4a5N60?=
 =?us-ascii?Q?B4J5YctSmFIVasA446p22bHURfX5D8g20c9okmzeLzFLihexfy4mvEpsxW28?=
 =?us-ascii?Q?SHHMaSsUG03fTbt4yzRy+BHtj/OU2qmhgmx3B4GVbfDsGGx00Jqy7dfC3t38?=
 =?us-ascii?Q?8O6BC3gthiRlfZsAnXLWeUC0k8LDwh2TRi1pS1icWIt8pnVUFKGrCZX4PV4b?=
 =?us-ascii?Q?hUFfIT1UsZi3MjbXoGD6XnLV7VgWcontUEEa4T3LdE0UrI3vwF378l5Yemfw?=
 =?us-ascii?Q?obHyqnj9NrV5lNRLb/F6oTStiX10YOgDTwqUwmstMdAtcpmq/GLPKy0UwRA3?=
 =?us-ascii?Q?wWHj+Quda9K9z/fW7GwNbxD9d7ehuFDwxiwKsUEO+FCUtXyhS1amUZrNUqBY?=
 =?us-ascii?Q?LuP4vmFPvLTEkyuoPOoasuk192gvlOANcfXsrzs9CfX/fsLsPP7uAgy2Cx+U?=
 =?us-ascii?Q?BNXvIqzVDsUpLagj43qgXQzXsVcucpMMHKmF9QHS8zd+LEWhBHXLrWord/zb?=
 =?us-ascii?Q?47SwC+XM57YH+PT1LmWPBfkkNmxpjs04W3ZC6YeTJHw=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc19a4e-9714-40ce-a09b-08d89ba8054c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 18:35:21.7724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMSj2eZsbWhESBjTZ0oGDTM5e1adaVT7FYaw4/+Xu729BqLe1Xp7rs4bnDG8YDA+wa8TA6mdtuMj485JY147YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3820
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

[AMD Public Use]

Seems logical to me.
Reviewed-by: Kent Russell <kent.russell@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Kuehling
> Sent: Tuesday, December 8, 2020 12:31 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: [PATCH 1/1] drm/amdkfd: Fix leak in dmabuf import
> 
> Release dmabuf reference before returning from kfd_ioctl_import_dmabuf.
> amdgpu_amdkfd_gpuvm_import_dmabuf takes a reference to the underlying
> GEM BO and doesn't keep the reference to the dmabuf wrapper.
> 
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 222f1df1a6b6..8cc51cec988a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1736,6 +1736,7 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
>  	}
> 
>  	mutex_unlock(&p->mutex);
> +	dma_buf_put(dmabuf);
> 
>  	args->handle = MAKE_HANDLE(args->gpu_id, idr_handle);
> 
> @@ -1745,6 +1746,7 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
>  	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, (struct kgd_mem
> *)mem, NULL);
>  err_unlock:
>  	mutex_unlock(&p->mutex);
> +	dma_buf_put(dmabuf);
>  	return r;
>  }
> 
> --
> 2.29.2
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.or
> g%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Ckent.russell%40amd.com%7Cce3f82630f6649b4303408d89b9f1
> b2c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637430454956092554%7CUnk
> nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C1000&amp;sdata=WzPu3OlZKKBnTQKHqC7KczU5Z19%2BPhTUt2%2FdjKznM
> Ic%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
