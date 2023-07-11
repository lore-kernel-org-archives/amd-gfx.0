Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A9CEB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 15:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B23E910E04B;
	Tue, 11 Jul 2023 15:07:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A48D10E04B
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 15:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbwPbApA7J7Av8oFlzWMePMaYRHZ5OeLagmPW3kDZ2GkG23swdoXd8LsR87vqb1+z+94Iw3elYKe2GXQB0frrfSLbrkNWJy522tyIDWml5jd+inHsAsymEhnFjYLXBjxUxnIKtYCXQHDr9wp6MJqSLurMc1+MBbGHeAnFLoDnLxrrIssYKyZxn3tCNkrBTUEZ7xqrvQ6HfbuBV2NcFhuo7/jmSik0YN8+OFvkDxHZflO3RB9HnbDqcJ2MrOMn8E2alvEPb0uNNEbAJWJ0Qrpr8uHxLL/C4wDJS4jddvnkHB7ZCXXqSjxG2AMwlggbBi4eOC5OgvV+qMBMyOQwi/vaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ww6RiZo9RfyDzzOPfZkLirecpYaphsse4GNLoTd7TTQ=;
 b=WhWCI1dXdfNwGBGkcNxCYymP+35Fk71k9ydCmT9wVtKN9Y3gaDd+a+hw8R+nMHT53xBCLRv+tJXNp7LTT1mMsYOoMTvMlgCjh8MDxKVNDm8MgyrfNNkSpz8YnwnyhEIKwJFkHWBHm4Ap/Iun4OqSzZ/LB+ZYMd5dePvDZII1iqBsxUFgjbv2c9Q65H0TwuzV7rtCyHxgZuwmHdZE/lPqt+zHbd5oH18qXXlquhuYW3yiFRvDkEdap2wXCpXajD5huRDY2ztvzSXzgqeds+0cjXTKXKxje7I0UxHJ4j3WCdylAZMRkVWKGK5sxGv6lJmIuhvXLOs1Wofq7ic88ZT4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ww6RiZo9RfyDzzOPfZkLirecpYaphsse4GNLoTd7TTQ=;
 b=KcRdLGVxmfqjyqK/zXsycTzsZg9DcDMXrtdYF50sdyAGfOblvpg8/qwQ92YCV89b+a5XIHdO6nuKb5Zx0drhQ8y5aM1Ny0QPSGhLjOFTbvxjZ8AKDxQ3PKlSVAJezSmgPhZOgiO2jh8LQrCFZvuLkjZRIv+iIAt3+SkhW4fH0pE=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 15:06:30 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 15:06:30 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: enable grace period for xcp instance
Thread-Topic: [PATCH] drm/amdkfd: enable grace period for xcp instance
Thread-Index: AQHZtAP1HejcMRSnx0yDyAXr5vv6o6+0pkcg
Date: Tue, 11 Jul 2023 15:06:30 +0000
Message-ID: <CY8PR12MB743548321824F4109FC59BB78531A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230711142807.68327-1-jinhuieric.huang@amd.com>
In-Reply-To: <20230711142807.68327-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3fd869ab-314a-46ac-b712-fd995862fbba;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-11T15:06:23Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|CY8PR12MB8313:EE_
x-ms-office365-filtering-correlation-id: 186bee57-f5ab-426d-fabe-08db82206829
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6aP62xDqUk7U2mCM6AUwP3pmb35tfcRKJBp4AhqPQuSlguQ0SsYBC4uLDv+x35TgUVBMSmNYEnwGdd2mXpfB/7UseWlh/3h/q/Mw4VPePMqvWoZLu8513i5VUSJ1IZ1j8Up8wnByD+xXJ4mNyl86uIAWAYEusCWiby/l3DNTpCJuASfU9zbgJsWTU7sP9Y/0V+UYRZscgfbPC/UHLbGQT4njXXfJYRxXoW5x+CG/4uGjOqscaMPRl3V9KFVMTZoxdjoAAKpOwHoZY5XG7zpiXoQ/XcaklzoU2sQ4Dhk82vrAuzW/NySWScJ+nyeVpk/HN4VdtEUA2CTlZDUNHmuq9bSni198gG4SuV+5KjfAM2GvvgDboG02Q9vdPhT2xzLeDJw+oDQTYuaH+jDIXUWUsHz41ACkQlpnrBm6nRQO0q/SflxIKDQVhI1Ju95ieKK666JRAJs8r30tlKuad0chd+fDmwjTX81IVkI4834HPr3NM3CgN3Vsh7gZqsprMhUzgC0yffOttCaG83ZCoEIcxrK3d4KzpwCmBirxDAXFfq1cWAXd39O0n9ccSJG9FuMGSyH88XhcfQ9Ld+Bzltxo6+t5fDwg+0Rd23VNENWPa0+D+7U3Xgi9xvw96OVUtfi7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199021)(8676002)(8936002)(5660300002)(52536014)(83380400001)(186003)(53546011)(6506007)(33656002)(86362001)(41300700001)(7696005)(71200400001)(316002)(9686003)(110136005)(66556008)(64756008)(66476007)(66446008)(2906002)(66946007)(55016003)(76116006)(122000001)(478600001)(38100700002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nVSTGe4vaOjnUuGciyocENkP/SM/DLkX+JpddnKnMpsg2TQOcYq2PfgEBuTO?=
 =?us-ascii?Q?PQRwqj1yLIXg8Ak0oYgnmcX1Bx3/zzLaETZSrw6JFbHpoB5GZEU7iBE9huzN?=
 =?us-ascii?Q?XgsDrSVJQcC3oaLLlQmjbhfQf9JS6ybztKmFqGYgqMNaa30Rf2yS6mCj62cd?=
 =?us-ascii?Q?iITbqyCEULwUZMCZs47Wh7YjhHzL/4yr2V2CT9Deoyy5kvslIM3+63uyMb9m?=
 =?us-ascii?Q?U6mSLrVLB8skIzd76ft/97tWReMyL7EDT7zcuDA4eqfdAxgtNRND2bpwBxjP?=
 =?us-ascii?Q?UqnSicUQn9Cjb3yJiD0AGlAELc47gWlQws5F8GdsaJin+lCVnPXJ/J8+qi3D?=
 =?us-ascii?Q?F4A8mZCW/4F/M1+XVqABzrWEva8WkXWq0Gmw8Q9NFCxnn8vVbsx/t4YrEu6n?=
 =?us-ascii?Q?vW6X2+leRQN3JEJxpu6HNKsNZgPFLd1TSvcq1VPBe8T61gV5RSQFof8qFBEY?=
 =?us-ascii?Q?yxn0f0cW1X67+aEHb3Tf6AJ26R/lf3mBnp+/Eppkbn2YNncQU/DFL+ahtsPj?=
 =?us-ascii?Q?8T4qO7WsXBEFjx+8dNCIVvnMMb66dXkzS8RndOFOgfYxgCEO2I+X746RrzOT?=
 =?us-ascii?Q?EtPKJ022jEG/vY/IyZYuQQBCtoMql5cB6SBKmbVG6m1e36onZtkb2rYBJ+go?=
 =?us-ascii?Q?YpPOdG9vW64KyCttcthco7E/aUAOnhx2IcZhOwn2Fj44TOGw22B4xJfrTF2C?=
 =?us-ascii?Q?1xFHmKLu5jCGIXTXUeQVH6IqvvhIP5yWH9lHx6/tYQJEcSe6l6LHhq96VBzG?=
 =?us-ascii?Q?dPHlF190iKVpRBaAkGCTBtiFDgrIlawBBSip2qHde0x8hTMwDR17meVBsTPs?=
 =?us-ascii?Q?BJWmMgl6XixQpeuQ/SSmiwgokxNXi5uuQxISrNiCD0R/9t6KXu3S86qAVMl8?=
 =?us-ascii?Q?onUEG1MKk8V0vQU+ax8GdDM9HCsmVnL8o1BS5aTDDCCVOdlEXXlPGPzCiLFB?=
 =?us-ascii?Q?m+kJFFAuV4duAbnEMCV9poo8ReZ6cLodlaIIR9hHyzPKkfsumq6dCMBpSRTZ?=
 =?us-ascii?Q?GYcAy0nuoPlKI8KTFEy3D8xlu2hMirjIfDkrgEAF8XID+jOTpPZwqvKBB+UT?=
 =?us-ascii?Q?wbCRLapfclvKgMw83M9YptBe0ABqCfVdwYYIxfGSuVD95R4uOK8ZgUMHyaMs?=
 =?us-ascii?Q?DkBQ84GSJeLITL2xPxBvxSAKiTLcpeZ2tOs+FsgagktjtOcKNPhN5y4mGhV0?=
 =?us-ascii?Q?V7LkvmSVqOPKXVDOF4y8U8YzPdoQTJOYeJoVRYDhOwBRAjafMpeh4OJ4gNz4?=
 =?us-ascii?Q?+2/sNNZ2YC4f82Tbr2L/UGNw7yKoepVzduQsadqcCq+mBIjVKWHxxgsboOm5?=
 =?us-ascii?Q?IlPQcYWztYhYQ96tfsv3hnW323NhckfL2dgxkrGJgcBIZKpRTroAwRB9zkOF?=
 =?us-ascii?Q?B/1QnYmOy2Eb1dmiLqh71vIZLmbNF0KT78ZkGuplylk36pvR74ZjRBa1oXiq?=
 =?us-ascii?Q?Qu4ZGNxLQBXoDoeOrrICInFOQGfmIXpTQUiJKKka++jmlSA+EX/xjvn7jRse?=
 =?us-ascii?Q?KLxQfbS8RlVqBXp3W8224WcOJuUOgdnGNJqm3BWz1oh+dUly9P+qmtq1pzmS?=
 =?us-ascii?Q?4pcIn99z3hpyKnBa5PD9W+VT3IQPWqgn9daT74iVkAN6Oku2L5hhHv9qUwgX?=
 =?us-ascii?Q?9I+Sbd9NZzEoTh3escjKCN0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186bee57-f5ab-426d-fabe-08db82206829
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 15:06:30.0745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ik609QYBk0y5kvwQJZq0z1YQrcDB7QcNfdDG60crjwP6Q1b3omLVo4askL815z6o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Isn't a KFD node already mapped as a partition?
The xcc instance mask should already be a unique offset per node so I think=
 the LSB set position offset by 1 should work fine as an instance ID here:

Snip:
#define XCP_INST_MASK(num_inst, xcp_id)                                    =
    \
        (num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0)

Thanks,

Jon

> -----Original Message-----
> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Sent: Tuesday, July 11, 2023 10:28 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Huang, JinHuiEric
> <JinHuiEric.Huang@amd.com>
> Subject: [PATCH] drm/amdkfd: enable grace period for xcp instance
>
> Read/write grace period from/to first xcc instance of
> xcp in kfd node.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 21 ++++++++++++-------
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +-
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  8 ++++---
>  3 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 31cac1fd0d58..9000c4b778fd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1619,10 +1619,14 @@ static int initialize_cpsch(struct
> device_queue_manager *dqm)
>
>       init_sdma_bitmaps(dqm);
>
> -     if (dqm->dev->kfd2kgd->get_iq_wait_times)
> +     if (dqm->dev->kfd2kgd->get_iq_wait_times) {
> +             u32 first_inst =3D dqm->dev->xcp->id *
> +                              dqm->dev->adev->gfx.num_xcc_per_xcp;
>               dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
> -                                     &dqm->wait_times,
> -                                     ffs(dqm->dev->xcc_mask) - 1);
> +                                     &dqm->wait_times[first_inst],
> +                                     first_inst);
> +     }
> +
>       return 0;
>  }
>
> @@ -1675,13 +1679,16 @@ static int start_cpsch(struct
> device_queue_manager *dqm)
>                                               grace_period);
>               if (retval)
>                       pr_err("Setting grace timeout failed\n");
> -             else if (dqm->dev->kfd2kgd-
> >build_grace_period_packet_info)
> +             else if (dqm->dev->kfd2kgd-
> >build_grace_period_packet_info) {
> +                     u32 first_inst =3D dqm->dev->xcp->id *
> +                                      dqm->dev->adev-
> >gfx.num_xcc_per_xcp;
>                       /* Update dqm->wait_times maintained in software
> */
>                       dqm->dev->kfd2kgd-
> >build_grace_period_packet_info(
> -                                     dqm->dev->adev, dqm-
> >wait_times,
> +                                     dqm->dev->adev, dqm-
> >wait_times[first_inst],
>                                       grace_period, &reg_offset,
> -                                     &dqm->wait_times,
> -                                     ffs(dqm->dev->xcc_mask) - 1);
> +                                     &dqm->wait_times[first_inst],
> +                                     first_inst);
> +             }
>       }
>
>       dqm_unlock(dqm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 7dd4b177219d..45959c33b944 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -262,7 +262,7 @@ struct device_queue_manager {
>       /* used for GFX 9.4.3 only */
>       uint32_t                current_logical_xcc_start;
>
> -     uint32_t                wait_times;
> +     uint32_t                wait_times[MAX_XCP];
>
>       wait_queue_head_t       destroy_wait;
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 8fda16e6fee6..960404a6379b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -292,17 +292,19 @@ static int pm_set_grace_period_v9(struct
> packet_manager *pm,
>       struct pm4_mec_write_data_mmio *packet;
>       uint32_t reg_offset =3D 0;
>       uint32_t reg_data =3D 0;
> +     uint32_t first_inst =3D pm->dqm->dev->xcp->id *
> +                           pm->dqm->dev->adev->gfx.num_xcc_per_xcp;
>
>       pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
>                       pm->dqm->dev->adev,
> -                     pm->dqm->wait_times,
> +                     pm->dqm->wait_times[first_inst],
>                       grace_period,
>                       &reg_offset,
>                       &reg_data,
> -                     0);
> +                     first_inst);
>
>       if (grace_period =3D=3D USE_DEFAULT_GRACE_PERIOD)
> -             reg_data =3D pm->dqm->wait_times;
> +             reg_data =3D pm->dqm->wait_times[first_inst];
>
>       packet =3D (struct pm4_mec_write_data_mmio *)buffer;
>       memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));
> --
> 2.34.1

