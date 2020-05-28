Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657DCC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 02:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B46A2078C
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 02:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aZ760Si0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B46A2078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C71C6E149;
	Thu, 28 May 2020 02:35:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8831A6E149
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 02:35:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMqIjVReYacga9PUB4KIBhRovtXv+FNnhimsNfOJ/+hfjvaTnjp062Fc/p2N1bgsE0qFtfL3gvdCggOfJqHILH7fYF5fGR0pEbOE+Xrs3yeL+qTYwWbGIU4Tr77ydDRDMaAzaWZandfzlXdmFraKj2Nt0tbp7uyTMsATXNZ0b6F1No+vl6zrLvf/vQlZulsZXE7MM8UIzZIzjDizrJFCpGqPJA484t9xBUap08TKoK3Hni8XgZrqfXGGbs2qulgyrqGalAzb+1qiisDQPmgB7/8jHSYqekomDjcNjsr+PpOqs2L+cJ6pH+BUE4dqdfzeC8j7+6EdGhMwkMMTeF6XgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Af2jXDXGYVg/fU9z/o9YDkTYBt4tYnPEODci1KJeYA=;
 b=HQ9Atw5xVNh2FzS0DDnKghyXllcNh/2iNnUyYCaP+LaVfGsdjozxBMvn9cHG7JnfJKh+L7kAm6DG5mN8mKkjZDnH1tAXfIjDD11irdLoC61o950yQBneIh2O5RmM4zWCA5xkwJBSq2hlY1uSPqIFMa5REgSDwPSNJDv6a+Q3R+iH0wnldLGwy7yCIyyVu39Yz8rflRfDyIycYSSqb9R1vTpMoXx+XcjtRSayGOsiscOD2SDhSOHjfYTZNGLpQ1ZQK3+Equ0kHFPYyOkXc7A8y/xojhC+JD0a++qLww1S3Hnw7MZnBTsRahK6boIWrFAvrMZV+9E0XFmTAIpUuYePfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Af2jXDXGYVg/fU9z/o9YDkTYBt4tYnPEODci1KJeYA=;
 b=aZ760Si0KT3/W87CR4qTGyOjQKE7mdIA0vPUSHjXTnOwrUlPiYwHQNNCue08Hi4EVOBFw81mC4DuscofqiiM+0a/HAnNSYAgKkRTRDiz+yL1vHS88PcXD8YH1rBkORlAQYcnutizTf3dNuCLGA4rPoIAknPfvkrezfUHrTPfjnw=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2731.namprd12.prod.outlook.com (2603:10b6:5:45::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17; Thu, 28 May 2020 02:35:24 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 02:35:24 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gmc10: program the smallK fragment size
Thread-Topic: [PATCH] drm/amdgpu/gmc10: program the smallK fragment size
Thread-Index: AQHWMIbQFRYfXl79zUudZNoT86PjX6i8afwAgABltVA=
Date: Thu, 28 May 2020 02:35:24 +0000
Message-ID: <DM6PR12MB40759E5DDDAADDEA9D6A9147FC8E0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200522221728.808568-1-alexander.deucher@amd.com>
 <CADnq5_Nr-xOhM25cApQ5m8kYkk4A_U++riJcL3bCCoJWKpANXQ@mail.gmail.com>
In-Reply-To: <CADnq5_Nr-xOhM25cApQ5m8kYkk4A_U++riJcL3bCCoJWKpANXQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-28T02:35:21Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d6472af0-67a9-48b8-bfd3-0000142f9f46;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-28T02:35:21Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 88cdcd6c-07a7-4df4-ad02-0000760fb09f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7db90d45-29d9-4599-53cc-08d802afc692
x-ms-traffictypediagnostic: DM6PR12MB2731:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2731639C346E4882C76AC1CEFC8E0@DM6PR12MB2731.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /pXX0vYRcHI9tlbzXlOMUkryVTV6cnuKho1EaJGzUa1XWVheUUWuC3Og3WHerGK6WnOKsvqv06mN0tyROVD2mvdOL0rWzFy4QidOrKP+eGi3sTiRL/JFPs/1dRQSD6vCClcUqHcG8ux77fVXCt+17zkcqpVtLV4SOWiNsNgot9WVU1HlN0K22bvWU3I89W+qH4Gc6+7TQKKSDbuiQ1IF3BRCg0s0fqf/9+lEMIBhUy5v6wJXcLagV8XAlutSrqVVx+RQ0avWMhtWzTt5BBSVqTFrdiQR/zBWd91MVM8D9p7lrFRfETuoX8+FPW+intlw4N0iDx2IXc3vPkzXIYfE1p0NOjh2LMSshhi1jSMH//4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(86362001)(83380400001)(9686003)(71200400001)(55016002)(2906002)(45080400002)(66476007)(66446008)(66946007)(76116006)(66556008)(64756008)(52536014)(8676002)(8936002)(5660300002)(4326008)(110136005)(33656002)(316002)(966005)(186003)(478600001)(7696005)(6506007)(53546011)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: n0WJFZ7fJQ27LHsbkQGN7WPAAPZv+YhnEl0e+osTxjxSx5NFOkeGld7YeEUKX4A6xdMScdNTXXpTNro20Ga4X5vtcnr6mIIks5cuQtZSikN1ovTYE9jwoZIyTsJAqFU1tqOuzSjTRu1Nivkpjqt9ZQsgOEjLTLSvwkk2R1zixsDBThPzs9jvCtbWsygrSiEgDueZTctDWsudeOIUeSn+t6AREVaFsnN/pJkpsblwTsKd0KQP8BxEohdY5bliPfTk0asndM+fHlSZ4hjfEJqNLM4JsmzpUFEWj9gw2fIH9YDvQ1eyzaLoEbkeJgejjvmj1AtThgfN/as/ooz1Yx/RfWubUq97xV9vrNPaX7Klgx3cxPql6d6EHiXdQS/TgDrIW1o8I7XNWxPsl5y3EKZ+KjMLAfywUCJXW7mhVVhmMS1PmFTbGxjBBTNa8iwD/+KTfjCy1Vp2BrGUw+SVOSyHDrsVYoblgFVAs/Or1xvQvPRkvdp9BWeDJxUSdisV6eAv
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db90d45-29d9-4599-53cc-08d802afc692
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 02:35:24.5771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a91VSXghvX4HCPkd7ky7oeaYH5W5Rs+vmtYVxeA8CP4NZ6QQZJ/M+5ZYI7xu3zoD8h7OJdQ/Opjtv2/zgqlIOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2731
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, May 28, 2020 04:29
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/gmc10: program the smallK fragment size

Ping?

On Fri, May 22, 2020 at 6:17 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Explicitly set the smallk size to 0 (4k).  This is the hw default, but 
> set it anyway just in case something else changed it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 4 ++++  
> drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> index cc866c367939..6939edfc5232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -181,6 +181,10 @@ static void gfxhub_v2_0_init_cache_regs(struct amdgpu_device *adev)
>         tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
>         tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
>         WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL4, tmp);
> +
> +       tmp = mmGCVM_L2_CNTL5_DEFAULT;
> +       tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL5, L2_CACHE_SMALLK_FRAGMENT_SIZE, 0);
> +       WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL5, tmp);
>  }
>
>  static void gfxhub_v2_0_enable_system_domain(struct amdgpu_device 
> *adev) diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c 
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> index fb3f228458e5..616309e85d6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> @@ -164,6 +164,10 @@ static void mmhub_v2_0_init_cache_regs(struct amdgpu_device *adev)
>         tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
>         tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
>         WREG32_SOC15(MMHUB, 0, mmMMVM_L2_CNTL4, tmp);
> +
> +       tmp = mmMMVM_L2_CNTL5_DEFAULT;
> +       tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL5, L2_CACHE_SMALLK_FRAGMENT_SIZE, 0);
> +       WREG32_SOC15(GC, 0, mmMMVM_L2_CNTL5, tmp);
>  }
>
>  static void mmhub_v2_0_enable_system_domain(struct amdgpu_device 
> *adev)
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C15145b8fc17c4f7b412d08d8027cb12c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637262081875240018&amp;sdata=79%2ByW9LaK1bgmZueFC68qhWvJGbSg%2FVf8OnW1B7bwTg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
