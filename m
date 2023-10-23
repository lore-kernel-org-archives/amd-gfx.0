Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC81C001E0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 14:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA4F210E0CB;
	Mon, 23 Oct 2023 14:21:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3D3C10E0CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 14:21:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTaEQX5opmfLnKZFcpZwavt7TuL5Cc/NpddsCYfhDrYXW3SayNxASUtjLljJUaeWDW2BvqIPnUdawoBRT//ZjVuxxldZ8dKHOT8qzv6acEQ3o5d4r+PTXyAn3XxUDwroAeKXaCdwhGAgDPHWEryiRosZICSP4JwWRQnBjyfPzZv9GCyev3WPiwKXkLQamROL3JTw66DMe660oqMW2dtH4UM7qLmMEw5KK3XBGo6bWz82nMQbhGk5bm613XVvW6oKWu0qvVDXlWVB2kXPiklgaX+h61+4moqtp3sl2HwmvqnZc+dMq1DuM8rd/oDf8zlIWR7e+6olnnSNIEvoAKYO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gJ34LIeDa1M8EwuatIUmRksjMUAZsmFjfH781pd4hE=;
 b=AiJL2ZT2fFgeY47vnsU2yJyiFHZQnNpxPqpqORuj55W3NdhK8HHhshCbiWIqgOhCu6Rwb2ftjnNHcOdfamdze+bkRh6QHGEy8999dOllsHU51hbbUg6BmwH+CtiY4GhpKuVWqjyHZj+tN1Uvi26Pk8Y3ymTOUXaqYtQlM8PAoTZlwiVnEnMRiKMethyt/AYJWRC8jYpv6q4SZAHkIs6kxDgxq/eZk7LI6/71vUCmi57UQloMJCPWZjBufgiTAxqV8aDkXEzVBCOa/IRB0SzEwa6pd9/5/6HwUfGytkDa4Lv71DLXrLgpFLF+uRyycghv+KoIoyUb4tuhX56qf1JN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gJ34LIeDa1M8EwuatIUmRksjMUAZsmFjfH781pd4hE=;
 b=ItcLGaMPcTPV8mi9uDSkFDP0BCpOtd6gbC3wM65rgrLzsx/w/NVSuUxTXveM6rjZOG4/TZ4sV/nvPQwSDdLNFexZDYmOdz0yl0cClXiUy9WnVWl2LgJzL24fkEkLArDWcZ5IL+LUO7eBWBUX34xBjmvBwRIr87osah6v6s/CJcw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 14:21:37 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a990:2836:75d1:148]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a990:2836:75d1:148%3]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 14:21:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: Disable ASPM for VI w/ all Intel systems
Thread-Topic: [PATCH] drm/amd: Disable ASPM for VI w/ all Intel systems
Thread-Index: AQHaBbdqH2JqfoQquk22vcbSXDTaZbBXa1Fg
Date: Mon, 23 Oct 2023 14:21:37 +0000
Message-ID: <BL1PR12MB5144924B8B61F0EF0891C344F7D8A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231023134514.144863-1-mario.limonciello@amd.com>
In-Reply-To: <20231023134514.144863-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=444c7aa3-b335-4eaa-8924-b44bad3e3880;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-23T14:15:53Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CYYPR12MB9013:EE_
x-ms-office365-filtering-correlation-id: 44f2b231-e5f3-42bf-56f1-08dbd3d35dfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i4mSbWZzxizvLmRbhUFj+GBn0jhAuXqcIG/ux9wUCU7cq2x6+hJRifUvaB4ZA4PiMd1TQH7FfVvNgN9PgV1JkLQzj7LvWcKh4Zp7fHiCWHECSWf45N3UdTVM1269Ddr/vJTt8Ex1FClaEQaN88jG4tZXrXhJsrkwuYMhbyb34IVHuPUuC7Yae138fn+QpEkMCtDyPhlzZu7ywcmCQn+kBJCfdwRcsVu1k5yE7E6QezSMb2FE3h4yl7csNgxmoqxagAcXp7zUolfKJCX52dkhDe0XjQlZVwlTdULktHj5GBOeWKwGgtSZrXDxgl9V2cpSzy6ZDVIddh3s90nIpcgymg2GwByBDB2R4Nq8Sy6/i+mv1JVTsUoqkgiZNJokctROBgSmKKsTCVX/5Glbz4eGp4nSqCUJHja/tS64l4ZYe0kLqkR9jTkvc/nMYdSpD8gfSmM+4U49CJ4FYZMhBA0mXy4nNV/iJ0KRAzEatpee3cL2ysD39RTVH7nZ4t15lZGCSuG8jdJQ+xBonOnIyeiZw9BspzobRntZDseeFyhriBal4+P2mWcUaAJKCrJ8kQv152XaaH1TfZI4NLIwH7wPDagLRSsEZ70ic3CZJtT10UU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(33656002)(55016003)(316002)(66946007)(110136005)(54906003)(64756008)(66556008)(66446008)(66476007)(76116006)(86362001)(38070700009)(38100700002)(122000001)(53546011)(83380400001)(26005)(9686003)(6506007)(7696005)(71200400001)(2906002)(8936002)(966005)(478600001)(5660300002)(8676002)(41300700001)(4326008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DZCpphpkhJole7ayRhWEDrSXIInUwPGyM/niofy+iuoFzFfGUeO5vwYHHJXO?=
 =?us-ascii?Q?A0agHgxpVGu7l4vKRQzDFX5F/NJbbyIMWH6GalozNFFsdXK6JbJDeFNjxIug?=
 =?us-ascii?Q?/SvF2XOJKH/HtD503FWtWq8WP1Hxcn1gUK94PHGHshpO7GwHyGk+HMRVw7yw?=
 =?us-ascii?Q?DbWj/cfXVEYWLSgCPwuEPTZnQcMcWM1duFTH9b9TkldeMNQi9TjnkLTSdUS3?=
 =?us-ascii?Q?JBVI3sgeAuyfj9CibLLAcHX5KMuhCCVqobWdhW0DmvADz7CTJ+y6y8TGEoAE?=
 =?us-ascii?Q?pPiJ0YlYpDJAkTVCb65HKdU3wyeskCdMuJEgT3feVKiVeIwIOGfrtE99TItk?=
 =?us-ascii?Q?GVr8luNeV4s7uNNrslCqY4/KWmDP2LoDP94hMLjb48ax4mIWtARJ+Zwd4Ti6?=
 =?us-ascii?Q?xbPyB1+0RVs0HRXdQzUbpexOYtiv1gTjIkiQv3Har2kWt2ZInFZEbEbYQpI/?=
 =?us-ascii?Q?jbq6QHK8i8C6SRBBT2v1JkemZp4tu5K94YSAb/dCn+EUi1Nqq+mJAARKjFZf?=
 =?us-ascii?Q?zus22d/nfjzYCG8PEvGEP9YUl6vLuPWOV6RCyKWb6GQt70ktDgAWKJO/G/ln?=
 =?us-ascii?Q?4TW+ywzV6DZAcLeFxQgoiKwMGVmSQwvrBhgqXs6HTuX7uV0Vuuo5MnV4hH1Q?=
 =?us-ascii?Q?MBKmfhNB5IP9pTJQmSRWp+6hpMKDMkzGZHQXaZqvjirZvmVBB23oXtVTU4x0?=
 =?us-ascii?Q?bdsWt4TWg4x2ny4VfkSnKZ7dmbvW8/rlb2PvY78DUFYgAOH9kA9i/Mse3dJ4?=
 =?us-ascii?Q?qhZtWhp2+I1+UwkOWe8VKNa6V2si8spvkNnyioM6bHApnyRmMFt8XIkh50iL?=
 =?us-ascii?Q?70aH1SyjIXXiK8bAxrB9SLWpibMJNNTnGw1z+mIHYfRix9tp1diRraP0uBMh?=
 =?us-ascii?Q?tZdVVwOXXg4a2d3rvqHwPtX95Tw9oggK4uujLN7eb9UCY9yy3cWBJ5/l5nUb?=
 =?us-ascii?Q?JjXz/i17PrDbI2YxgjNNHGZMCZeu8wNWJvMZIKOKiQaiwkp9DUYTTWVWC2aJ?=
 =?us-ascii?Q?r8Y6fFegKayDLKXI2GpeHVsbh/mwdt4Xv5JTnPJ5YPXbd4h1Q75VFgMeZni9?=
 =?us-ascii?Q?+5PuYxHFGEhU9WUYYhi+0QefXnLMrhYhtE7heVwvDgzbN1otrflhfSdePx9z?=
 =?us-ascii?Q?EhfdIqeTCs42KwczzagFVTr6pQAXEYOtZAkAu2jujWF+53qYemiJ4ZB52r5e?=
 =?us-ascii?Q?O/k/QjMUzB5GrlFhitYoljC1u5l3LNsgvCSxs368zIAYY7NnZNT5WiBMJjOK?=
 =?us-ascii?Q?PhpDvZxUF2yheZh395IcWyHMwvLKoii5Hc4Nwu4gbMVcOQQGypYBhVHXIKMf?=
 =?us-ascii?Q?nhE/0sUEuUuI6sMeBAlVv11/Ci4SHdPDHSD6poBL6p6Yjk3tO1ehabxwdkst?=
 =?us-ascii?Q?ArSGots/Dsu6TZ8dHkVEy1MmoXEpJLaPo8y2hP264ByMvDzo4XQkM/6lN0Wm?=
 =?us-ascii?Q?ViVclQk8IO+vPf5jR5c0jxJYlzHQYU/bvVdIUOvvx8dhfyKEoOC1NLmclewn?=
 =?us-ascii?Q?c3XX7hodtxzeJ7JOJQhy+ZTPC2qoGOJgUWYNZwTB5LIq5GTQUWEMDp1nygi4?=
 =?us-ascii?Q?lvl3Egjlh2dAf6Z+Y/0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f2b231-e5f3-42bf-56f1-08dbd3d35dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 14:21:37.0848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Stkei2HgO7dgYajbHxhINSlKKyZh1j05WMiZvLfVmcyDtjlmbiDz5Sv/qTCpQrA291f0GsaR4jyf9OTnSit1Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013
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
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "paolo.gentili@canonical.com" <paolo.gentili@canonical.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello
> Sent: Monday, October 23, 2023 9:45 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>;
> paolo.gentili@canonical.com
> Subject: [PATCH] drm/amd: Disable ASPM for VI w/ all Intel systems
>
> Originally we were quirking ASPM disabled specifically for VI when used w=
ith
> Alder Lake, but it appears to have problems with Rocket Lake as well.
>
> Like we've done in the case of dpm for newer platforms, disable ASPM for =
all
> Intel systems.
>
> Cc: stable@vger.kernel.org # 5.15+
> Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> Reported-and-tested-by: Paolo Gentili <paolo.gentili@canonical.com>
> Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2036742
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

As a follow on, we probably want to apply this to all of the program_aspm()=
 functions for each asic family.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/vi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> b/drivers/gpu/drm/amd/amdgpu/vi.c index 6a8494f98d3e..fe8ba9e9837b
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1124,7 +1124,7 @@ static void vi_program_aspm(struct
> amdgpu_device *adev)
>       bool bL1SS =3D false;
>       bool bClkReqSupport =3D true;
>
> -     if (!amdgpu_device_should_use_aspm(adev) ||
> !amdgpu_device_aspm_support_quirk())
> +     if (!amdgpu_device_should_use_aspm(adev) ||
> +!amdgpu_device_pcie_dynamic_switching_supported())
>               return;
>
>       if (adev->flags & AMD_IS_APU ||
> --
> 2.34.1

