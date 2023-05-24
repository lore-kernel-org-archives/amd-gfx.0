Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6D3C7EE29
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 01:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB6C10E562;
	Wed, 24 May 2023 01:18:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3DAB10E562
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 01:18:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RagTI3wNqbPZ578Plhu63VIzH250emk4vp6+wpsyX8T+LspUtSJySzwrIxeNKdJvX29tOBk9vPvcs0GTZ/o/vh39/2aiud6Hl+dsmU6cJHHzS5aiz1vRphDpEmyrgHH9soWm9Bxt5Ya+EykbQzw4ct3HAljpfU268tgihyg85c2oMprF/3RUm8Ht9DtwkPBw+AiEq4sA8qNJPSONhKSI9jPC2un5EnswkSEX9akd3B6NlCNhrnL/rg5/28ScKFs1B2ppdOZGjPDd2LoyWGl/BcgUB4RRvtMblnq1jGo0qErBH0zy/rCixJoCnV7G7cB+9A+4XfTgF88NK3qmaF32rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zpah4ZbxFOPguHnbUXYO+vuUa3y/WHG4mv0eyKL9r+Y=;
 b=Y5caGsoNe2C9sYjn17Go9Zx7kLeV+l/7D493B1mX7FUhDThB1NfWH0g9WCVwjeoTTwKOrLbgX2Ksj4Nppa57g/4GofC+etPJjy9hkXoloyiiqp4t4GbovhwM64kH800ApHm0RPJcR7O8w2UZADVfVlDZDUx8vbTRqGmLaPK5+I5ALrbdd2WBTYY6gHw3gEoj6UrgDz70H+HSrOfIRTMEIsPOKPTWZweWz8kLCimGYktVhTS3lvSAiZBy8tEQcqDTMaihv00AS7H8AUTW0vjgJ2HnYf1PzCJRM431VSDtVxLISFtrOiHnvzK5uM1p8GU4i/UEGlue6RMxmQnCU0J2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zpah4ZbxFOPguHnbUXYO+vuUa3y/WHG4mv0eyKL9r+Y=;
 b=JWBH4XuDl3GSZwfH3G4QPP292/tGoD1ehOHBQn2bLMn5LvA9EgSLgFRLq7DzZZXOkSBy8mlFRqnPuw40gqmfRHuNq05UV7FQ9wH170FNSzcIizMV2uLFV2JS6rgKWb5UA2ktrXw+Iojj+dqjeSA6rlBp9C5MrM9eWB3WYy3r3r4=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 PH0PR12MB7837.namprd12.prod.outlook.com (2603:10b6:510:282::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 01:18:13 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374%3]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 01:18:13 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Zhenneng Li <lizhenneng@kylinos.cn>
Subject: RE: [PATCH v3] drm/amdgpu: resove reboot exception for si oland
Thread-Topic: [PATCH v3] drm/amdgpu: resove reboot exception for si oland
Thread-Index: AQHZjdyNeh2G4JemgU6gZBqFPNCaSq9onuTQ
Date: Wed, 24 May 2023 01:18:13 +0000
Message-ID: <DM5PR12MB246982350373DA3B48E5FB51F1419@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230524010951.236634-1-lizhenneng@kylinos.cn>
 <20230524010951.236634-2-lizhenneng@kylinos.cn>
In-Reply-To: <20230524010951.236634-2-lizhenneng@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7f0594f8-360f-4ec2-a7ac-15f09f434cb8;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-24T01:17:24Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|PH0PR12MB7837:EE_
x-ms-office365-filtering-correlation-id: a2e3801c-efc6-4bd7-aec4-08db5bf4bec9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vNXxbYX13K+tuQYr0CLQz6Awfw4fzGwxYU+PzpY37SjVPWKIwCgoAkVSuhKGC1tZVxhgifjnn6EfNswX4yo6FLapeM2YeK0FwG9aacoc097Gr/HYv6UT5LZCmia4QegIaQCBP+Sq/ynmxM90DDt8ginDMuSRsUEpvoeTk/hau5Fe/Dxaup0S1Ifmo5rVcn/wQWex79PtANtAVOsg4qiC5f25Wu6Arsfi1Brex0FzbvradLrK+/kEIND98rRj691WFYnz3IdYWP39c++ZA77AxiJVlRsXLKHVPgAn21qEECN8OW6E3UnRJHO1iLF/9BajMz4iDp1+NMzhOR7t/PznnyXRMuAxNTPSBzhuVirYvXmswZaGmnkd1aIKxgeqjHKmR30ytBrfaeYoA2FpwK0ygG5wTghLpWs6js0JkoCsusjkltlgqT1NfatPhIQ2WWMX0kEesP6vOelnZbmWuAsloHg56234PL1jG52KsTQHS+/ARoV2qgLEe+k4wHcRHLLpUKQXIxARY3fCKrFFFCvFdBCPQ1N65fSg5iZgk8dijHnmb9DMFUf+3KAcrHTLs0P9xfD6L2ev0PkkExZ/siCpbLsRWLWaFPaYzWNlkdyXSlU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(122000001)(26005)(6506007)(33656002)(2906002)(186003)(53546011)(9686003)(38100700002)(66574015)(83380400001)(55016003)(316002)(71200400001)(64756008)(66446008)(86362001)(66556008)(66476007)(76116006)(66946007)(6916009)(4326008)(41300700001)(54906003)(7696005)(478600001)(38070700005)(8676002)(8936002)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NiY+OCVP3+DLIKuucq2rnGIb6t2ZAPmXB2KcPUAZ5tWqKR6VF5mtNId6JVTb?=
 =?us-ascii?Q?5QsgviXq+Xrnw13g5WUlZtB2YDTxUsYFgTReOY3hxHEce4Z/yUIewr2j16pc?=
 =?us-ascii?Q?JejkAYBhGIKA4j7MOUoeiDI8Asyk52bYjx4MjCEwP0k95eIaouCHJc3rE6sb?=
 =?us-ascii?Q?dah2BnXFDCPO61OvIwKKwsDw1df7M8gqrV6QQTD2r22QDi+WepgOTM1e3CUZ?=
 =?us-ascii?Q?YzWZ+vMiKs0Zal+3Xv5n+gBwdkuL/s1p17T+eYoDwML1NCkqCP5fGPbZpH/v?=
 =?us-ascii?Q?q6SpwZ+g3PBoNZlA3qamZo3dz5ZB9z3Xgcv3OuOsSd4nzy0CMiqJJWDTW6Il?=
 =?us-ascii?Q?SA0Sr/AV7VIEBZtGecXJCKyZwSuZo1aPVhVyQGYEaxBnHEYi/ujYVR4Ws2kJ?=
 =?us-ascii?Q?NB/JxDnkt4qAIMOkCY+d2e/LHGZDLi5Am/KN0g75WlG3CNdD2NKlM9YZWlNT?=
 =?us-ascii?Q?wPm7zyIq2+8IXmo2p1VlPc9mWKRKZiLprp1Ps7WmaPX6mnSGW0NDg94/0sQ1?=
 =?us-ascii?Q?Da8CsaEDeSocwMQaFSXX6/cRRA9knkO4Sv+7l5JiMq20wPYh48oMfO6ecl23?=
 =?us-ascii?Q?d88IcxO74OcZNnoZ2412YuUu1bTbK1dq1WGCTv8b/Ai2JbgMXQqptRXKq2ob?=
 =?us-ascii?Q?WOut1MsYM5uNogozYtNNUngga+G/mhfDgSwLv6XJVF7oUj0xKLKbGP1d3bsl?=
 =?us-ascii?Q?lcJuTEI8J7ATYhFg5EmS2cXe7k2G6eC22yQvAH/krZL9Hz+em7nRYGpyGLKT?=
 =?us-ascii?Q?SHTto1Xsi23oqyTqWmtQaz6hYUj/W5/PWsoed8IJJbG5I6+efYqpAk0S7c2b?=
 =?us-ascii?Q?u0EtHGQuOG6xhIHv7sdQJgbuTwAoOVh4X0rIvZjALC4C2LSGGUNa/ISVgAiM?=
 =?us-ascii?Q?P4YZENchl6xZ83V4dIfrhjWkcth+p0tn9qds0g7H0tJTYp4UJBOjElCemcy1?=
 =?us-ascii?Q?t0DtxPDGrMJln6gcvyzikRuxA7w2ya5vtkzEtu/U6y6HEivNeZGByIs2TG3p?=
 =?us-ascii?Q?UDWzD/Zm1GptM3fHt26S5JAbubipXtCia4kEiyjkoGfOgS4LYjhojupdfVRy?=
 =?us-ascii?Q?o+B2jTjtglbJzMlAkKB7e5CNq6qPuWfq9MK5B02Cjo29dISsEgbbTxv1h8qg?=
 =?us-ascii?Q?ShAE9uNBPhPY6bbZRFIcRxx1OsQMo6H9LEmVmL0H7Tkz/9ZYEOuZHNQDpcCu?=
 =?us-ascii?Q?2W7ol30eLgPPZWCdNki43wvJKfiZlxLar9cjlLjgr/mePjrN4sGdqxyDhbwi?=
 =?us-ascii?Q?sIBBra4s4Mr2pXfrdmtxM2812XZeRRls3Z41VMsYLEt2P2CQQ+x6z/R5y6VG?=
 =?us-ascii?Q?0627N7HXTWd0k19MehHngGH/kL+9c9YiZ5kvRZPTb2WGEFbmHyeej9Ac/979?=
 =?us-ascii?Q?9Vk5WnbVOJnfc4HzNs8ASPwmfZ0TY1tnz9koG5WlZ0E+9sLYnXRYWDa9Lgf0?=
 =?us-ascii?Q?HCg40GW9FXB4zu3YHjPD6hq1+sHsEwbjt29u+Z1MC7N/LxeZVUi0FEYBmbyc?=
 =?us-ascii?Q?gkIbWKxi6ZFN4z4iBoStxyikg5aBaV/ypv5F4mjaoNZdJd1SqFB/fcBuPOmA?=
 =?us-ascii?Q?e//9AOc+8tSBHD3FRwA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e3801c-efc6-4bd7-aec4-08db5bf4bec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 01:18:13.3970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJ5nLKR0ULrFx3bVVfb83HzMxlpMQtND3o/bhJASsOcc4/AfT3HI7APrUDhvSWFw/mU+BDpMwTodOYCAOPordw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7837
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

This patch did not land at all? Well, please add your SOB in commit message=
, and I will push it to amd-staging-drm-next branch with my RB.

Regards,
Guchun

> -----Original Message-----
> From: Zhenneng Li <lizhenneng@kylinos.cn>
> Sent: Wednesday, May 24, 2023 9:10 AM
> To: Chen, Guchun <Guchun.Chen@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
> Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; amd-
> gfx@lists.freedesktop.org; Zhenneng Li <lizhenneng@kylinos.cn>
> Subject: [PATCH v3] drm/amdgpu: resove reboot exception for si oland
>
> During reboot test on arm64 platform, it may failure on boot.
>
> The error message are as follows:
> [    1.706570][ 3] [  T273] [drm:si_thermal_enable_alert [amdgpu]] *ERROR=
*
> Could not enable thermal interrupts.
> [    1.716547][ 3] [  T273] [drm:amdgpu_device_ip_late_init [amdgpu]]
> *ERROR* late_init of IP block <si_dpm> failed -22
> [    1.727064][ 3] [  T273] amdgpu 0000:02:00.0: amdgpu_device_ip_late_in=
it
> failed
> [    1.734367][ 3] [  T273] amdgpu 0000:02:00.0: Fatal error during GPU i=
nit
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index d6d9e3b1b2c0..ca9bce895dbe 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7626,18 +7626,6 @@ static int si_dpm_process_interrupt(struct
> amdgpu_device *adev,
>
>  static int si_dpm_late_init(void *handle)  {
> -     int ret;
> -     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -     if (!adev->pm.dpm_enabled)
> -             return 0;
> -
> -     ret =3D si_set_temperature_range(adev);
> -     if (ret)
> -             return ret;
> -#if 0 //TODO ?
> -     si_dpm_powergate_uvd(adev, true);
> -#endif
>       return 0;
>  }
>
> --
> 2.25.1
>
>
> No virus found
>               Checked by Hillstone Network AntiVirus
