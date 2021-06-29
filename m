Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF74C11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 08:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65EF861DE4
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 08:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EF861DE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1118289D63;
	Tue, 29 Jun 2021 08:38:58 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFA0689D60
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 08:38:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hU68vBC7kH2v+IaSJu3b2XO7DveIAfDUneDSL9xd8wSzZht+cHmvUonmZcWSKVAZNR7mYge1QdKCvxP3STK/1GVwb/p/0kldK7xLcvPVKdQQbuUIsvik9UYBYKZL79R0ht76eFDmoVlG4+IhTUgRiRKCJ9R4XSsH1aCntkk34357z19liX5xv5ZyJ+tXpoKRJXaJZcLCzDSxt2M/Q8TVKcZJLNeUpSAzvkPCeLwd6NeEgj2YGewolk2a2XfKeM54zjYvns6CLYasuPnfdBjPhgSPpmHmApsQQvsY9am7lZt6SbBeeuJZtNJIt3/2dsWRPPSX5aLfsEJON3L0Gv92Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rcsvy6FrkUE7/2nP46dyYs2KiPGA5+xs6UeYCywwQIE=;
 b=LfLQqKoFE1nmDQ+6++zhtqDcJ/H3+2ZNqQR2hYYUbccvtVaNRi9WaK/K8a3jF4yoNbVhSMAKNIpBTVzqugJjIjfqXZ45iJwzF/wJE/UlGm3n/IPG1mpZimymdRfok0IqgeNx5A364e9sQpYU8e/nqE0pF5B8IPjF+LFKhRFW5LnxdPGW0sz21bsZTmGbXQXOaIKUHD0FNEBZodA4Hg0m995qBCm+yw66v7ZmQZZQir6F5xXKhCWR4vwN7DMfzWNcad3DZ5JSxb5Ohi7n8yqRe6CxXjLjdMnOHloptl6tgSVjodJCTFUQ9P3dHszzD5mBYHCpngfEQHgYnxvS0+y2wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rcsvy6FrkUE7/2nP46dyYs2KiPGA5+xs6UeYCywwQIE=;
 b=Gg1MZkZ50SwzS5sFtLfQcTQvAfeNgJ0shEedVa514WjvAEdeiFDWdkmStAroxqK6533Q6XVkT0APFtwmRbjyaS/kdLtoIM5pVVXP92C4NNoChPYkyB3/hCqsOxbHFiE+729H3cC2cXKqRSzoYqWMNpZHgJj2tPCuha/N4ZUunYQ=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0006.namprd12.prod.outlook.com (2603:10b6:903:d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 08:38:53 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::2cb6:690b:e6a0:d008]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::2cb6:690b:e6a0:d008%3]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 08:38:53 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: bump DRIVER_IF_VERSION for Sienna Cichlid
Thread-Topic: [PATCH 2/2] drm/amd/pm: bump DRIVER_IF_VERSION for Sienna Cichlid
Thread-Index: AQHXaZnx3Bu+GFJygUKtGK4agR6Seasqoe0AgAAPJHA=
Date: Tue, 29 Jun 2021 08:38:53 +0000
Message-ID: <CY4PR12MB12873401A19140F1C89B9AABF1029@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210625081243.978059-2-evan.quan@amd.com>
 <DM6PR12MB261941925DE288EAC3C2A204E4029@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261941925DE288EAC3C2A204E4029@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-29T08:38:51Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=771a40a4-db70-43d7-8b25-b6f451cb16ec;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53465443-bdd1-40c1-efd5-08d93ad953ba
x-ms-traffictypediagnostic: CY4PR1201MB0006:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0006CB2D76E32B341CE3E1DAF1029@CY4PR1201MB0006.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9uoIYUSfyCjEZzhWfg2CYecry7B0IzIsW9OJCUwc4aDiHwABpIpTxtdLiGO200WggwmXBrtireM2W99GEmM/ouMZ6tZ1qxHIaFbPTCPFhPexXnGtAKwLteU7p1PTpQe/N4ZnNukaTzZtqaveeEmzfQFWZg9/5plwnxM6MzE0A3T8MFiqtui3FNyDD1A7o5qQ0/qi2nrr44ZmMT/KHjzQ5M4tOE3BkFhhvLF+VLIq8uLzRSVv2ZGZ9G4ai7UHb2YK1x99j1AzCJ/4QLaNt+aNuk91lH5KY5GIOYJUMW4BvF63dombL/YiBJqkOewDOXcTBc29W4wEvZB3hz1YVRsathVy17MGxYvWrvEG/sdRozco0Xr+5M2hDuBBsNHqjAPPDdZUlXVLbO5npp1mUS77Nm8cflnT8t+Xhoks63tzbIF6W0OhCLjZxstgsWHHTp1XHbNesW7wxyOuDZnu62/sIDBq+vA9m9wMHkUW0ZeL/HN9lTwNnV7A5FdITtpKF7zx/PMR3c4TMVl3RPVo303Ilk1Yls4ggJh8h63qm26QDf4D5faUDU6fKZXPqiCA+XridVVjS1Dy+EW+fdub1EnO0Lw+XHEuQ4OchBE/n8xe7jDwhOBo6SSmIsE7ezqWnuD3wuei0w30YRtLlDFrTetwO5O5KrFKDwS1dw0DWj2xZ1lSwZL7mxi33gC62aFL/Vx0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(478600001)(66446008)(26005)(83380400001)(53546011)(52536014)(6506007)(45080400002)(966005)(66556008)(5660300002)(66476007)(38100700002)(66946007)(64756008)(2906002)(122000001)(8676002)(33656002)(7696005)(110136005)(4326008)(186003)(76116006)(8936002)(55016002)(86362001)(71200400001)(9686003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zz+v37PDTHsK4ZEsEBZ44ikHVOT6T3IhrQS5gnYR/pY/g2/VFxkntA3MT0Er?=
 =?us-ascii?Q?HDaaD5ucsxpBWNhLqi7rOSxMMmrD8gEzdV9eZjDecX/bCzWCTmPox2OCTqxP?=
 =?us-ascii?Q?SHLaHhN5W7vomN/yxejGCaHeJf43k17okHJyRU33OXUg7CB6STyRd1KsQ+v4?=
 =?us-ascii?Q?C+Zasg60J9a0wm9Qs08lqhj+9Ndlpgw7jUD0RKBqgnGFgOJYOrAJv3aL7mli?=
 =?us-ascii?Q?PLn+eWJgyxZCnuvrSdZpNXdiYQ7z6KGRM7SDyWZYsyf723bX8NNvbD9Tly3n?=
 =?us-ascii?Q?8KlJoRP/nfunhIAu7Z5qiOv0tmWJ7ldhatfDTYtU0XKKnFTXuX/l0kaQrYuM?=
 =?us-ascii?Q?SnyKGcKGakx3Z4BZ5906izMy3mtKOYEx9SvAjA2AkGk8rtwd+m/j1YyBbafG?=
 =?us-ascii?Q?XrBeUdhF1TB498NeTK78/KDfn5ghcuFIcSOhd4CfNGo/mnZ8bz2LBWZIvoSx?=
 =?us-ascii?Q?BpRi4hStZjuUsbdKqSVVtDe9iQsreCqn2kHC3R3VHzWVTU2c6pu8HnujwYCA?=
 =?us-ascii?Q?0hze3A1FKt5UxF2XS7dEenmv7gaykNzYlIlh/7+cuWnq6dhhnjEmP9+4Gtop?=
 =?us-ascii?Q?NaMk89utWooDRYF9Y7hw9QnibzT8n8kdcWBBg+kmpe3SmzenU0bwVb8MSS3K?=
 =?us-ascii?Q?Wn4mndIN8u86ILRU6wsXlLEC/f/vAwWjONkWdZwOMm21xh+obxaEpPeA9EXF?=
 =?us-ascii?Q?PADHeoq27W/O9kgb6VoJ3ENr1064MK+vpnlft632FkFWsA72rUORgYwoNcF6?=
 =?us-ascii?Q?7rhstSLI07gegBUVciFJnU4efnwXRDMiQ5h2lBedOIW3NiO7XqON7IoVPLbd?=
 =?us-ascii?Q?mDebi3nV3KojTGKcrPRe5Tp6tnGgHVjpNosZ9LwDa2sdXYqbNZIvYjoWb0g2?=
 =?us-ascii?Q?RNqy2ZK+x9g/9XPeFBnehNsKIxyEQTrVJ4LqETQZWgH3wuFg7TVvhaOIn6hO?=
 =?us-ascii?Q?fo+URulPqNr3+Koc2ETLNmSG4MvDxQ+CMlpCFNf3hyzXkOlJTkHSJ1dT+haN?=
 =?us-ascii?Q?7fwxQFbwKKtO4bARj+OhLAoMXE5bBXACymsFuyRRWCoqAQRKhjvIACfOKumC?=
 =?us-ascii?Q?3Z/ZxCSJyUJgOkchPyy1qJrUPCVYjzLvFHflPdlam9cVlMJUuI5kvj55UCJn?=
 =?us-ascii?Q?gcrXJARA3G0g04PI6Qp1oyx5Ps5QRTvLzsQXnj2S7ZFezuDEOeJM/yjYJTFe?=
 =?us-ascii?Q?eQvBfYeU7E1FEg2Mr3mK+6Uh8wI17qTbmbduV6nI/1eVQDHVc644Ku2Pjqx8?=
 =?us-ascii?Q?TViYiyHxzf20q/QulThAp8Y4fir3Hmn1sJ5Dh59VFl9vKLWHdtLAD8UY/hXH?=
 =?us-ascii?Q?YiNdKXrGt2YhVciJr7MhzXTh?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53465443-bdd1-40c1-efd5-08d93ad953ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 08:38:53.5550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdDXJe22YM88vKO8gl+mXAHzo0ue+pIdIESbi3zPXUBhzBMOVMjOqZ3BXs4jjoR4trPqiQMuhV18DFBwC793Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0006
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

[Public]

Acked-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Quan, Evan
Sent: Tuesday, June 29, 2021 3:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: bump DRIVER_IF_VERSION for Sienna Cichlid

[AMD Official Use Only]

Ping..

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Friday, June 25, 2021 4:13 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan 
> <Evan.Quan@amd.com>
> Subject: [PATCH 2/2] drm/amd/pm: bump DRIVER_IF_VERSION for Sienna 
> Cichlid
> 
> To suppress the annoying warning about version mismatch.
> 
> Change-Id: I7dae1ef90ea3b09e1b378f96136b6ae61cc90696
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h | 2 +-
>  drivers/gpu/drm/amd/pm/inc/smu_v11_0.h                      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git 
> a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> index 0b916a1933df..63b8701fd466 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> @@ -131,7 +131,7 @@
>  #define FEATURE_GFX_EDC_BIT             49
>  #define FEATURE_GFX_PER_PART_VMIN_BIT   50
>  #define FEATURE_SMART_SHIFT_BIT         51
> -#define FEATURE_SPARE_52_BIT            52
> +#define FEATURE_APT_BIT                 52
>  #define FEATURE_SPARE_53_BIT            53
>  #define FEATURE_SPARE_54_BIT            54
>  #define FEATURE_SPARE_55_BIT            55
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index 1962a5877191..b89e7dca8906 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -30,7 +30,7 @@
>  #define SMU11_DRIVER_IF_VERSION_NV10 0x37  #define
> SMU11_DRIVER_IF_VERSION_NV12 0x38  #define
> SMU11_DRIVER_IF_VERSION_NV14 0x38 -#define 
> SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3D
> +#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x40
>  #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xE  #define 
> SMU11_DRIVER_IF_VERSION_VANGOGH 0x03  #define 
> SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
> --
> 2.29.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C33f80d6d546b4906776508d93ad1b51f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637605494641978023%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=0tpSQem2mcNJc9yJc772R5AVlXRvD9qUKribzqIyqbc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
