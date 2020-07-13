Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FABC433E5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 13:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3BB206F0
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 13:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mTHoXJJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3BB206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE7456E4F4;
	Mon, 13 Jul 2020 13:34:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 142326E4F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 13:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kx2YmecKSZAXSrFACV1ElytYbZt7gX0Rd0y1OwD/je2L0/zeAdj/Sikr6mznvBpE+/Xub6RRfUFX4gt/z9SsT0ARUKy7hiT0BEzqkvN3qlufkRiwldTGD0JmtcNr1jANqlCJA6JxxG7Nv+jhJQ7dBF3fgBbW5j4jdbnMZSUB1raXpLPAoxHEBxvGPVDX2dX7/+QEL2HbIUrLxOBPjuR0udWKk0ldZp2j83JFCgK/hnCbebApEPJFVKMBtMJED9CMESkHh1eDep8sY99L1E8qqEH2+4eHIXbV7J+Hgh1jCUDVtcXdtyGAgAwH+WhjRRS5OiuV49zeTiSaPzz7BIENCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nfcue/1Y1pSZFoIOnEMmtd+TN8xudOuAIfImQ6omHU0=;
 b=dgF84ECtHK8HLbxvgBxMfxN8WS1uvgIqWR6bHQK9rMgbZAhRpF0+AWLEuCx2EVPP5ACyioalplueSCqRlj/sy4Atm9zntyvq+piqcSor5M4WxMrxMOGlnYyG+DQTN3EqA39pb2S2HIJbC4QQ+xu/qhDcnU7vfNfCcR7ed60DmfWIzGOrPHuiPsccMaXOUFDsiL0HpGOUHrZMFvd0GLO3rmzeN4m0W7qxYshM4jB8amFisLvYp/JYi8g9ymNs5w8nEfFvn8Rs1XG7XLWvKYizDj4++ySXFrOrOY8KJtwWd7n1DffvnsKmAKePypAhBg/aeWS0IoNP78aMg1O1nmH+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nfcue/1Y1pSZFoIOnEMmtd+TN8xudOuAIfImQ6omHU0=;
 b=mTHoXJJMcMIGHeLl5rf2H7l3xYMMrnS8Ett2dqfmlzoYXTzKwyRJDWrcSrQSfXV1Nax0tPSCOkXb/yhxPvPw809/ugmz9Xhxe7oAMWs7tnPSGLl+qOSMA1kVBqh50RxiQa6a9aaNFvlNMMhHUnfQNGl6Nt8HaGNbeX1AIw3YtoQ=
Received: from MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21)
 by MWHPR12MB1662.namprd12.prod.outlook.com (2603:10b6:301:11::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Mon, 13 Jul
 2020 13:34:47 +0000
Received: from MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::693d:7e71:3a0d:b6d4]) by MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::693d:7e71:3a0d:b6d4%7]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 13:34:46 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: use ARRAY_SIZE() to add amdgpu debugfs files
Thread-Topic: [PATCH] drm/amdgpu: use ARRAY_SIZE() to add amdgpu debugfs files
Thread-Index: AQHWWNrgtvMs6eyt3UezmCynZQGsSakFME4AgABI0FE=
Date: Mon, 13 Jul 2020 13:34:46 +0000
Message-ID: <MW2PR12MB2586787CBB596190ECDF754789600@MW2PR12MB2586.namprd12.prod.outlook.com>
References: <20200713055950.19611-1-xiaojie.yuan@amd.com>,
 <59e9b843-ee3f-2b70-f9eb-f96289be3a9a@gmail.com>
In-Reply-To: <59e9b843-ee3f-2b70-f9eb-f96289be3a9a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-13T13:34:44.416Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [198.199.113.192]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0786421d-83f3-4fbf-d34c-08d82731827f
x-ms-traffictypediagnostic: MWHPR12MB1662:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1662FC9342B6740B2453116E89600@MWHPR12MB1662.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jla/PmE56/IgrEdlI7uj/MZEo4a4N+IkZJ+Dxzdr2UqxwH6/pyQycDB9vdUVe1/dsmIF7pJuWNQymj57yxZkXwPhggA6BDoEWFrH0QuTqcU4pqKYUbqKlOjqCknrzAwLR7OIKQvdNRRBtWYVunvjqLIn7/8+9qF7JqsZki52Zth62Z9VoF60VqPP47CcmXCYHg/skpiZVDoAJaRg/VBB8ovkRyOhq/xhYIW5I0uClARNvIZeBRSPcHNMPeK5Jlix33ACSEx4PGeiiGhN1Hi5caE4IfCcX+tZe1pzoyCR2i7YNlhRqeBlVMudAcaNkjcR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2586.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(26005)(2906002)(55016002)(9686003)(33656002)(7696005)(86362001)(186003)(55236004)(478600001)(53546011)(6506007)(66446008)(66946007)(8936002)(66476007)(66556008)(64756008)(76116006)(91956017)(5660300002)(316002)(110136005)(6636002)(8676002)(71200400001)(52536014)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 26vhtxHTKLpSw01dqIh+BAz1oZbs6WcIdhBRFIQqX3x8WYYfaULMea9tE259T5l6WD+CfGypg4JRd7LJjw9UZ6HpFUqFsSW2yLDFB9crK17LsDB3AqbvZgO4TAV6aGcCDWUjaETvgSQ+eh09NQRt1mDyZFpZiDwfwdUCaPRVNdfG3sn1/lNygr4Nz/uxKbIHM7saA5mY0Yu8LaBhAiT7bqdjxL8u6p4BkCE6M61B2TCsn592M1sBWDQiu6ouXo/a/63J4Ffg+/RcrxHzkyiLbHcBfbyMGMFhVa7pd/PjZjCIsfgDkR/obZDgLb/bK+LWoa6VBR4JN6T+DTllr6QcJOFpAumSZjtgNsdFv5AkvhMaj130J6ZfCv/QLGvwthiScmWsm77Pas0WvJTBIValmo7eKeRmdd6PLPEY07vQ3t7hBHvYYiX6+QWi4XFUEQE/ZLFPsEE92xdmLf2gJ1NHraCjpNsqFUH22nweNb/VISK1MiOXdiYrMM8jmrZ5WZiw
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2586.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0786421d-83f3-4fbf-d34c-08d82731827f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 13:34:46.7012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AtECRMgUmXppvebshgR6NsCZm9jCz5wMcqvZiZf1724JhKSnZ/75nlQlYAGRcnBj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1662
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Chris,

This was observed when I was trying to add a new debugfs file. Some similar
occurrences using ARRAY_SIZE() are:

- amdgpu_kms.c :: amdgpu_firmware_info_list
- amdgpu_pm.c :: amdgpu_debugfs_pm_info
- amdgpu_ttm.c :: amdgpu_ttm_debugfs_list
- amdgpu_dm_debugfs.c :: amdgpu_dm_debugfs_list

This patch simply unified the usage of amdgpu_debugfs_add_files().

BTW, do you intended to use:
debugfs_create_file() - need to call debugfs_remove() explicitly
or the drm helper
drm_debugfs_create_files() - debugfs files will be removed automatically

If so, we need a separate patch to cleanup them in a batch.

BR,
Xiaojie

________________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Monday, July 13, 2020 4:38 PM
To: Yuan, Xiaojie; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: use ARRAY_SIZE() to add amdgpu debugfs fil=
es

Am 13.07.20 um 07:59 schrieb Xiaojie Yuan:
> to easily add new debugfs file w/o changing the hardcoded list count.

In general a good idea, but I would rather like to see
amdgpu_debugfs_add_files() completely removed and debugfs_create_file()
used directly instead.

Christian.

>
> Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c   | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 3 ++-
>   3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index b8ce43c28116..58d4c219178a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -781,8 +781,10 @@ int amdgpu_debugfs_fence_init(struct amdgpu_device *=
adev)
>   {
>   #if defined(CONFIG_DEBUG_FS)
>       if (amdgpu_sriov_vf(adev))
> -             return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_=
list_sriov, 1);
> -     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list, 2);
> +             return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_=
list_sriov,
> +                                             ARRAY_SIZE(amdgpu_debugfs_f=
ence_list_sriov));
> +     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list,
> +                                     ARRAY_SIZE(amdgpu_debugfs_fence_lis=
t));
>   #else
>       return 0;
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 77d988a0033f..8c64d8d6cb82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -928,7 +928,8 @@ static const struct drm_info_list amdgpu_debugfs_gem_=
list[] =3D {
>   int amdgpu_debugfs_gem_init(struct amdgpu_device *adev)
>   {
>   #if defined(CONFIG_DEBUG_FS)
> -     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_gem_list, 1);
> +     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_gem_list,
> +                                     ARRAY_SIZE(amdgpu_debugfs_gem_list)=
);
>   #endif
>       return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index 4ffc32b78745..dcd492170598 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -468,7 +468,8 @@ static const struct drm_info_list amdgpu_debugfs_sa_l=
ist[] =3D {
>   int amdgpu_debugfs_sa_init(struct amdgpu_device *adev)
>   {
>   #if defined(CONFIG_DEBUG_FS)
> -     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_sa_list, 1);
> +     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_sa_list,
> +                                     ARRAY_SIZE(amdgpu_debugfs_sa_list));
>   #else
>       return 0;
>   #endif

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
