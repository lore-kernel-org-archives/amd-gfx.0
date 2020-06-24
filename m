Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81484C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AD12072E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="07K3vIlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AD12072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A1D89DC1;
	Wed, 24 Jun 2020 14:23:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4786C89DC1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 14:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0O30b1yBSwdY/ZldcTXUdv573+nkqPzmJnhKpvPv5v+VlB3bP+4UveFef+bTR6d+uwezDQbe3Ivvq3pAKVvdrAypVKpi4ZWiSYzbRfY5LGtp5+zHlUwislCzmQr9Zj0QlsHAOatmD8N52XdBI4fRwlfS+IFiSoV/dSDHgtbu1KVEQ4h50p+9w8bwHeiy1bC3iih5nyCpGQoEOOq2u2LWSnFBghYq48utfm3O5fmPUmyUM71UZUVHkn5jtZvSFUfHRMTAMJuWvwJa8hU3sGCr3HgiX6mNdjv0bMyuGQEve2waEUJOazvJGQ/Rxwc8O/S0MLm6SFPJTd7UojVF+ZS+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60/dUZS0aXytv+1HtNvILTa5SrMX2DAfIjZFcw3cjbM=;
 b=h6I7a6mCjw0RAXpIZvTlYd0haE46milFORa69Pw3uVPS2BE69zEKsZOV+SPuxrPPBrTtM0F8QTeQqwApZdgAZNAGOUiGRko5EWxTI7Vc9mmgcH4C8LFSfNRTCythdn1al7WxbHAPYZJ1WOzZx3/UNTfRC6ouvJ4kB2Ucdi+J8VxCNRTVqmBvPw1jWU7ONlfHrhrxDotnZkvh7D8E6RZral1fqX70dY0wWMQR6y01USToC/ifsHLQhRme+Ekfs+cYBoTQEiPHbpGqntCKD8eSWkf/3uzdLdkLB+W4Dw2doNqCa86YdCpYw/aV3XNOUjbTRiR8ivGGXn3ZjpRJG79xoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60/dUZS0aXytv+1HtNvILTa5SrMX2DAfIjZFcw3cjbM=;
 b=07K3vIlqTYmBLZOBVHb7bl/bCEEKmjSs/shEF2hbDo5SwhPqaittR7IFE8+trjyHEuoVv/w2soD33HbyL53YrenA7g91WgZc9rKB7XT6zv17yoGh5xVqQ1gKNvtGIE/yoHZ13NJmsAiptvMJIGI5yDerkw6ql6nMyUwPKbbzN5k=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3867.namprd12.prod.outlook.com (2603:10b6:5:1cf::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Wed, 24 Jun 2020 14:23:42 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb%8]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 14:23:42 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: make sure to reserve tmr region on all asics
 which support it
Thread-Topic: [PATCH] drm/amdgpu: make sure to reserve tmr region on all asics
 which support it
Thread-Index: AQHWSN4E+GcAEi6VxEmnkCS7+X7rXqjn004AgAAA8NA=
Date: Wed, 24 Jun 2020 14:23:42 +0000
Message-ID: <DM6PR12MB4075A113EB49D60B55C1A56AFC950@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200622214113.969491-1-alexander.deucher@amd.com>
 <CADnq5_O3hjmavJMVTCv==hMn-k3v=fiDKx7AjN3bts9Aj+=gSA@mail.gmail.com>
In-Reply-To: <CADnq5_O3hjmavJMVTCv==hMn-k3v=fiDKx7AjN3bts9Aj+=gSA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-24T14:23:37Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8df2712e-7155-42c3-9f73-0000d7305548;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-24T14:23:28Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f027998d-6d40-48dc-8ccf-0000cb49fddb
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-24T14:23:39Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 28f2fd2b-3c59-48ea-b3bd-0000324624b0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0797da08-08e6-406c-63b6-08d8184a3255
x-ms-traffictypediagnostic: DM6PR12MB3867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB386796EE7D9EA8946B4E2101FC950@DM6PR12MB3867.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZLgSErjdzTOUc5pQXzvbQdsSCHVbY9ckWAk/8yB8NFJZw1uXDwhDX2aBtE85b/BXrP/+3UWK03kMjMIqoDxbOq10tMNhgN3jgQw6JyKZZXjVvfXFC1v7j7Cfi9rPgozoMsPBJ/E8TkcJd4A1y2efey1JOKcJbv0uGkvy48KE9jGDnGZz9HZ96H47QWCot0YAfwJrSv+t00Kf890GUAG6PmdweaTzpuluDbmWC17UICSaTovQ9AIBiLjY77hw4srFQGqH1zo7fPvz/Gd1ePbJzHRKO98gVFtmqZqJrcoS4dRODQj5RgLUmhhHXYULdl2s2/32WQzr0V6VmwvfgA8q4Q6ROCKSO6Q4d9mMNnmFHf8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(2906002)(966005)(86362001)(8676002)(110136005)(8936002)(316002)(186003)(71200400001)(52536014)(53546011)(478600001)(66446008)(76116006)(64756008)(5660300002)(26005)(45080400002)(66476007)(7696005)(66946007)(33656002)(6506007)(66556008)(83380400001)(4326008)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: TIPwiPSQ8lpFOHt6ucogMQPjh6G7d5IfWgDHHDfP4VCJEodR58/FWUZH8biqipT7jcC2qgb0I2jRGSFQT+xwL3xxnUOxR5fTPGrnCGMq9Q97v5YtWL4fXH1hUM28jD0xXMCY9IF9ZnFT6rvBu0zWG7KFsV/cFW5Oq6gYuKWdQWN+onhPLB3cdw6xMBQ73ubzPpwYet56lXNwtPwKLZfPXxozi2SOUY/rvXMDlXF/01wwoKX8j9ArG3h99IX9MmovqdtGyms335CWPva6DBCs+248jBsl0Q2YIjBbWtTuY5YDhAtl2gX9cRQcySo+X14s+EuC6zd3QTkdVbLycM6Bsr5lWDLsi/W1vU/rCJbxdwC7jf+EHBob1ELU/rlNBsOVAPTYKY88ZQArtZVB/Jzd1IW/aeT8BmAMdoMw9hOziCwaKOZGFQI15D1vPwfSkUDBwj5WfsykUc73wKZGjhvJAZp2tnDNhDo0KUlMQPA1dX8ua/+v1O1bWSFqNYRYGnzM
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0797da08-08e6-406c-63b6-08d8184a3255
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 14:23:42.3371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JOe34yHr/OH0bZwOuXgFoFxOpFJ851V9+K6WORxeEEVtK9ePSVNCJApjQXQxE42+0NFMM160Vk1wPNlLNEC7ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3867
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

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, June 24, 2020 22:20
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: make sure to reserve tmr region on all asics which support it

Ping?

Alex

On Mon, Jun 22, 2020 at 5:41 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> This includes older APUs like renoir.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index f1855a8323b2..7d51768684dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1974,7 +1974,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>          * If IP discovery enabled, a block of memory should be
>          * reserved for IP discovey.
>          */
> -       if (adev->asic_type >= CHIP_NAVI10 && amdgpu_discovery) {
> +       if (adev->discovery_bin) {
>                 r = amdgpu_ttm_reserve_tmr(adev);
>                 if (r)
>                         return r;
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C58a9357a7ff248f908ba08d81849b141%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637286052091665855&amp;sdata=7qVY5igW%2FWn0jt8NUpS1ZfbbP3%2B%2FgYPazigVBIzQqnk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
