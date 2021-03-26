Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB02DC433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 21:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818C0619F7
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 21:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818C0619F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BDCE6F4A0;
	Fri, 26 Mar 2021 21:24:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E7EF6F4A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 21:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCIyW2O623idRykMdjsDcNmbRu7DgJD7+32H0nCZHfmjWIpeoUBhA+dJEuSBgodmBjvue00R7mpNR2xwYKloC9/5y/CQq2OqP0BoZ4ssYcOFVfGrr5RciE/qOoNmgtXmY7J9n+xwyATFkTf3aUWhNWRoISy7A1HRh8J3RO5/pIkWqsudlP0jQE0vFnExZCrm+VaSTe2ej6rOvG3FZYiPtD3c6MbGYjXoqRReB4F7ah1ESaoYChlQAVZeT5aPWmCwDi3PYAcUtfBp0Ysb/HndVigEuwQN9aLm/Bu5DrvJwwKRisueuVyh65FVE4+tQLelu3cA5e1gcVEqmIo3BuSKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Us8nnCMka6O4yTG3+aeh9IrlJ3gHaTbQMF16TEL1XII=;
 b=gXDIIUloXbDQszoApOufFYw0CvHmhVRLHtbxWSHD0ZqDQ0oRWJH37TKAjzzc71qsNVZE1MCe1excvgjUKhpHuddfc4VRMl8F0RR9aNsgjndBYcl620f7LoW9AxxSadoUUKqClQb8SlGVrpjAuD7Ma/zQwfPxu3mrMmW/0cZWmECf33HgcAe2t4IzoW70k8MapM/mn42scignBYnfAIZofhrnXlzYzFySClUN4UEYpgwttWKF/1s2+ckMYPQWl/bJNfKPaxFZSlRMxHXhGMJFj61XY3ZKMUWCe9FMbqXiNsSt7BtjKlak6fy+5IgwXyhkfuS165/rE3eYe5uECn3Hxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Us8nnCMka6O4yTG3+aeh9IrlJ3gHaTbQMF16TEL1XII=;
 b=th1V/jn9K5cJei+CG3/ZVRv7gcByoIoVVFSYBejU8aAOzJ0XRzkigsiUHxvUlM3iLZsfJjjocf/iTedK9jbbUFWrGsr+jNR0KN63dJE+i3yl3j4OdogITWAJBXZqkZPEjoB7lKf5Q8vwGnhTGYqQD8QXXZt4fETXLoMbKhx1hsI=
Received: from DM6PR12MB2971.namprd12.prod.outlook.com (2603:10b6:5:118::28)
 by DM5PR12MB2373.namprd12.prod.outlook.com (2603:10b6:4:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 26 Mar
 2021 21:24:35 +0000
Received: from DM6PR12MB2971.namprd12.prod.outlook.com
 ([fe80::7d77:8839:4114:3bb1]) by DM6PR12MB2971.namprd12.prod.outlook.com
 ([fe80::7d77:8839:4114:3bb1%5]) with mapi id 15.20.3977.026; Fri, 26 Mar 2021
 21:24:34 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/vangogh: don't check for dpm in is_dpm_running
 when in suspend
Thread-Topic: [PATCH] drm/amdgpu/vangogh: don't check for dpm in
 is_dpm_running when in suspend
Thread-Index: AQHXIoLZnfXNp7Y4U0uPpPF2nhkAvaqWx2kg
Date: Fri, 26 Mar 2021 21:24:34 +0000
Message-ID: <DM6PR12MB29714D3EBD1B4FCE4E392C4D9E619@DM6PR12MB2971.namprd12.prod.outlook.com>
References: <20210326205735.1324461-1-alexander.deucher@amd.com>
In-Reply-To: <20210326205735.1324461-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=cd0d57fb-0128-484d-a13c-c85df1968bb1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-26T21:23:16Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0cf1db4f-d8c5-4a72-1a5e-08d8f09d8d99
x-ms-traffictypediagnostic: DM5PR12MB2373:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2373A15F20BC5D2AA13FC15D9E619@DM5PR12MB2373.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3g/k0knTGlvTcSTtTBbwytw+VEoaYPIbzs6eM843T3UuC2Y0e88VOVuNfkQt7jaA9pzp75FH+fdJM+RCQT71JZuSCWrPGk3sbIMJcqhHjyj+SdQPLHTVA8Rwr2yIm5OIT8mENDbTBpbWM+S0itRuI7n7yuunxKPJi3kcW3poTLxW8gHC5KxTfRqe/Bg9if5NMKlAHt6RNifClq+fyXZsvlU1IVOAq1zMBSkOMjo/MxKJxEg0nVIeFScfPjltFpxcJFKPv3YpTJVbOGqGJcaTZ+n4gE9lKLXjCO/urxQEKypW0dZ6mtH+PyqOWLpq64ce0OZ/wnBR6C9hd9adPox4CdoXSg0ea4aWLKvSrAnsJfKf8ZIZMB16Knc7fqhDvKxZHm+RQeGnf3SI4o8QskGpGfHAsheaEpnxMhVog1MvmUNeNCrEVrJ6qqM/L1UH5BgBhvef95m4RFd+pz6rhuOtrD/KjB+ejLgVTPX7ffQlnij8dF55nfigHQ8H8gBl1wzxuDa9bR7OxgzYpuq1OcEBnJaxVMAC790JaVRQ9UybKKPBIW486IlBCIxTRGMzoM9FpR+Got7AHOm86L7POj5Vl4UbiODMp8YL95fZkhIog+NJC7wyx0Lz2MptgABtXbXBX7PFftxio9Ztx1FToaU9Tg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2971.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(6506007)(53546011)(15650500001)(8936002)(8676002)(478600001)(38100700001)(71200400001)(7696005)(66476007)(66556008)(76116006)(52536014)(4326008)(54906003)(9686003)(66446008)(316002)(26005)(33656002)(86362001)(186003)(64756008)(66946007)(2906002)(83380400001)(5660300002)(55016002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dhhXixXRuYtgPbMgBY8GO36z5YkEv15qIGbaqe8u1+++0kyyW1igAyiuLRvm?=
 =?us-ascii?Q?pULd6sfix8jyQfti+hrOuGZCI6bX1dhW4MuidVm/ZSJs+yniHaapZ7PnzC5H?=
 =?us-ascii?Q?KVYkljE5L8u143WGhv/t1ArpEzU0igYBpyGB3dD/CJR06WqEmZS5f0ZBmLPd?=
 =?us-ascii?Q?+kVRiycpEFE7AHYqC8Fn4xCirDQie8jvhFnZzfhw0I/nFcOk6H26KgSxygF1?=
 =?us-ascii?Q?98x56XRt89Tk21oi4KcKU0U3RPvneywrpesyAoR8gVH6x8HDLueUjm8cZfBH?=
 =?us-ascii?Q?IO5DvU3/ErzEsiI/u/6IJFpgj3/Mt5NvwNUzA1CZN7I/U0d81/BO0fUGe3yd?=
 =?us-ascii?Q?W7tRUt8GRw0vZVvcRcna6XPHVNA9dbzjz+yOgqtuiT9kMqinJbmwzh9NsC2Z?=
 =?us-ascii?Q?t1IhIdTZU5ITWmtagSna5er0DDu+CygrepvJNY7mxeE1qvL9Yv9uW7KDeviX?=
 =?us-ascii?Q?OtzgvI3nPaYcZBuimR5RlgxkYSwR1SIj1HsThnk2397oUaA70vvM7a1fPPrF?=
 =?us-ascii?Q?Hy3rhYuF8y/Ad22krTa8jqMXZECtGiMBnQYGdNLqsqfHBErec6e2ijwoU3dd?=
 =?us-ascii?Q?nvrp7TlnhkjzlAZk8Bp981XnmFCxfltZMl+8rKbSBs2hFPGRvX3qeEqifgDC?=
 =?us-ascii?Q?29ue+jtbm32w8s/w/lH7rOuhOCZw4Gq+/j/yqeOTdjRIFgvOV/bBnd/9FGkn?=
 =?us-ascii?Q?7X8nDsPlA7ZsdHqbGFSmco2YM73KJj8NeCkbF9aR4ITk3+i6k3CGnPXycy8e?=
 =?us-ascii?Q?TRo7XSayvJpHDka9URhVXDO/qiFZaVw2PhLUJkDmZky6Nz99DeLm/fcEPc6t?=
 =?us-ascii?Q?A1OIATH6rREpgLTPZrzjsI+Pk5h3IGrK95kxnOlRIvbI2MYs4rW6qamaF/cH?=
 =?us-ascii?Q?4cLm5Gc+zHG+258lZpGVTYrVJGgR7wie6HIhFyF0lWDDyK/DTQO4RKffHRNY?=
 =?us-ascii?Q?kaD6NSTCGUPAsdeehm8ahfGRyonFzeHdHhv2nDM0XqgfSbHhux1F9nxC5cwB?=
 =?us-ascii?Q?txWLD2ADogWNO0+nfJj9R+1Ot5mqTO8x7CnXkmPGo3E7/A42Gwkak+/zQh0L?=
 =?us-ascii?Q?UwuvMAYP6ODHZmNEfn3D5i7jxbmm0xYNeCLhU/2Xb4EKs4BDK0V/dG6tyR/p?=
 =?us-ascii?Q?4Q8EFBBQvTn6hHzF/PTp/itAIocOh/QrAx5DC+ZGcFN/bSGngcL8qZ9fgSCU?=
 =?us-ascii?Q?PZxzgTZMpnAW8AalVpgMEShqARMn8mYvi5gqSyNBb0HLFooVFQ4S8mbDVhQm?=
 =?us-ascii?Q?4pTLSs7IMIBdVmy06JiUJgsL9hIdPCgcbE9LuNHYWFA5ah9+bCRqzw+O8hnB?=
 =?us-ascii?Q?FNocgew/oc3ZSpR5n3ukb8XS?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2971.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf1db4f-d8c5-4a72-1a5e-08d8f09d8d99
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 21:24:34.6869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okfsTfv/63xnMoV65FcYXQyAE3hQlOtmuTz0EEN/HOSt3IFaHRtXPFLWa1U56ZZB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2373
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sun,
 Charles" <Charles.Sun@amd.com>, "Wentland, 
 Harry" <Harry.Wentland@amd.com>, "Liu, Charlene" <Charlene.Liu@amd.com>,
 "Cornij, Nikola" <Nikola.Cornij@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: 2021/March/26, Friday 4:58 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/vangogh: don't check for dpm in
> is_dpm_running when in suspend
>
> Do the same thing we do for Renoir.  We can check, but since the sbios has
> started DPM, it will always return true which causes the driver to skip some
> of the SMU init when it shouldn't.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Zhan Liu <zhan.liu@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 2f502fec67d5..ed11e0ab8299 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -384,10 +384,15 @@ static int vangogh_dpm_set_jpeg_enable(struct
> smu_context *smu, bool enable)
>
>  static bool vangogh_is_dpm_running(struct smu_context *smu)  {
> +struct amdgpu_device *adev = smu->adev;
>  int ret = 0;
>  uint32_t feature_mask[2];
>  uint64_t feature_enabled;
>
> +/* we need to re-init after suspend so return false */
> +if (adev->in_suspend)
> +return false;
> +
>  ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
>
>  if (ret)
> --
> 2.30.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
