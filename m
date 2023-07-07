Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00337EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 14:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62EEA10E5A8;
	Fri,  7 Jul 2023 14:39:06 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D7A310E5A8
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 14:39:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ev8Q9h5Nw9p2XE1Kg24Nu+d10NEtd6zuNNauJVdieibPLL/CRajHA+SZQ+3HrtDN1jJXgqobzs5B/mBG2saLAsygEXMq56In/B1hVZf7qLkeihd60OASxD25RNpMzhk1yilXRoqcs/mT9U2VVfF5HOD22de/YPr1TX0UuwaD0VHccFwj+BOJ+DEVMJSB0AUbgUiak1cEAtQavaGcGQs5QIt8k9pEkAHsEIKrw8g/AHNCNKsCRlXXNjMX6kBrR3U3jPmxe6mhlw3gmtct7gdhUjq7kKW9CBgTbXk3FdG2eBc/0D9LoQRmmO728V44m6vmgSHDkcLMKnL5FTbOBm/Cdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVrHrWQhhCj9tqacxw8W0F+2BCPGXD6yQNxmhthtKWk=;
 b=RlqmZQPlyymxwqSwR4IY5ug2EY65PoViKp3sdQMA9fg1mCQduav9fxtJA5g2d9css2jtsqIUKF+pf9Zgc72nh1boFXIwalaeN9GfhgXpNdIULvhw3QONdZ+2hrPiJmbIgaBIOMrWfooha4aT46cNsZshIy27TA7PXyQH++oc0YsUWR40TpAORRWtvZJ+ISagQLYkbp//NOEm2LDK9rLcJke+kuW5cjHbIJKRJfSoNrY/kcpdoFKDgo2oTSF49PUXDibkGEXkahEImcWJo0dFuV+LB80v0sY27amfF8Miayr9CrqF7SaZTRYIlvyEdxU0v3lEXB36652weG40a8jfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVrHrWQhhCj9tqacxw8W0F+2BCPGXD6yQNxmhthtKWk=;
 b=E1Si3amqWiMxtl8tfsc7udd6H9W3pjW5qD7fj+NuSrjBSx2L7Spjvpt5CXQS5UUuSaiSvOopObM13QrxHEyck/rmgHSx1TlNmllknsvZto7J/NVPeUXNXCvEOBxpPx7VhtdYLtL8wISiqe6s0/Qyd2wgeJ8RlQqzUGB0nYuGYf8=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 14:39:01 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e%3]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 14:39:01 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/6] drm/amdkfd: always keep trap enabled for GC v9.4.3
Thread-Topic: [PATCH 5/6] drm/amdkfd: always keep trap enabled for GC v9.4.3
Thread-Index: AQHZsDZyPzgU2v2EJ0SKw9JLQbN6A6+uYKbA
Date: Fri, 7 Jul 2023 14:39:01 +0000
Message-ID: <CY8PR12MB743564658E11A48E4D57AF9D852DA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230706181918.189722-1-jinhuieric.huang@amd.com>
 <20230706181918.189722-6-jinhuieric.huang@amd.com>
In-Reply-To: <20230706181918.189722-6-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=44f917ac-ec60-49f7-855e-dbe38b487a40;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-07T14:37:27Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|PH7PR12MB6956:EE_
x-ms-office365-filtering-correlation-id: 4c021d36-bea4-4cf4-141d-08db7ef7e7fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rnb1XkvBpzFRzF+eg+B83ERJSFzxTMo/8qi48D/M3FyCApEg6D7TFqqrIuzHqeYZ7CsvSJ1XWcNN2H1IEmm2EbgkmobxGmq1fQwld23sgmemh9GOwjhxeSBqMXZaN55sCthKvbtej+nqocIMxMTkVHQ5GgIw+64LSvgJzNOqxgfplmGaX7KAlTWiMjxqKaBbF+x2scHDR5pjnjgOsuWb9ElovtJJF5+B6dcc9dvs2Ka90MfB+P9WMY+k1K85H4ap7PNVI0DeBeSkR0s+QrUTE92fbVBxuJac2mUC8UNsJ/G/PxmvPnWiQkoCsx23CymZ8lxBSdBl3zMJrtW29H5H/U6c6lUIMjdBw6py5sOOnjPO6PeiVBatBOzFJ2eyUsifre2QCnaHj9yUWKKvoId07HARiY1DobBWTM1Sx80NmOZ2eSb1j0VD1PoLS+1RtJZeE1h/SXxlcxNI2nSNXF0EVVuD1buwNE4tefudpPe+zQJIheWQzsPGJ/n+87vFin/sn26fJqJJuWHJKKHmkMcnnQpWSlQETs8/IWczUUkK28PeJjMq6TAi5TXiIcKsqxlyWvf+vhHd6lfOiHVt9G3xVJsQ7isy/p8IHu4+kMgCMGY8Td+kca0r2hSMWUNvtrwp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(52536014)(41300700001)(5660300002)(110136005)(7696005)(55016003)(8676002)(8936002)(2906002)(316002)(71200400001)(64756008)(66446008)(66476007)(76116006)(66946007)(66556008)(33656002)(9686003)(478600001)(186003)(86362001)(38100700002)(122000001)(83380400001)(53546011)(6506007)(26005)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AsoV222o7glgo/oDV9E387L94stgZPsm5bkDtAlguoPrSSwV2EePiofypN8e?=
 =?us-ascii?Q?bLg+PVRt830tZ0U9Q7JsAMWe8ZOx4/BnRmQHUeIY9ZtJj2q6CFl9PoOj9Rqm?=
 =?us-ascii?Q?jg8uFY/XpgfX2GnfpRcm8N/uKoveV3DQWAGrE0FxPV3DGogpMoYXZgSq2ODU?=
 =?us-ascii?Q?SsK53IMpX+QmZk+sCwHldGyohkui7Q9t/uIdPAuVu1izqxC7/ccIY3RHDJ4P?=
 =?us-ascii?Q?COXOA1Wk/gMSulI7xee1NKWzuMnDU650NzLDcza/xYx79OrHfiLZx0fQg4ZK?=
 =?us-ascii?Q?CvEDigSlTWVLZIKRXxwpI9XYRxGLxWb18LXFhhDPRJNx+x3Zp+hHZ9Wwi3sp?=
 =?us-ascii?Q?HyvFf0drN/ta7F+t5N7sYcdWxzxUs2mcifLKTlaZ8NqfoxxoBJunTB/3obMk?=
 =?us-ascii?Q?O8rRGuRa8yDKzQIIeAIIuL9mhXXObDQI7V4Do33bvYTRCmGam9orPcKAtEV3?=
 =?us-ascii?Q?o9WGgPcG9628JjoFya+SY+hGnHKSze4Y2irQc25Q8F1hsPAq67+Jhhm2QsfX?=
 =?us-ascii?Q?Qr+XgNnme8RkfelnpNj3ItVO9k8kfqYVsLfEvU7N2tAg4nJUfFtFbzLfCAds?=
 =?us-ascii?Q?S45LBPhkssqba6IZWRuh0d6Pr05dV57Hl+81I3pW2Pq37CcIFrxY7MTyrhgX?=
 =?us-ascii?Q?ky+keNBDzk4pT7SKLOsbPDs6lcJjlkGWmcjG5LZ8TVUyseGrdi/JjCsfunIZ?=
 =?us-ascii?Q?/ReEV3wUUDG+/jDnUcH29bja0Fr9yYKFnwXRuN0rflNowVaEH0MmS+Un53tZ?=
 =?us-ascii?Q?iHSbDhc3/8o/0JPfJ88ZxdtMi492CU0aWUbMJKH+ueZm8lkzK9wQvRva14rR?=
 =?us-ascii?Q?xMPLj/lMV9mWYfbiBoLb2lMKmT5GsN99m2nMQnLuP15O0X6U0HnZvBny8J4s?=
 =?us-ascii?Q?OR6X6hpIWynj5Em5bPDqHne3PkehYYEJ7Zz2YgZoVvPPGTfCpk49n0NkPh5S?=
 =?us-ascii?Q?TTNUNgBbqrpLob0jrjXR80ABiVJ4Rr2mN/bIY2QPqBCNlnbTe5ap00sUXaR3?=
 =?us-ascii?Q?YoAsp5xy8POmqJWo0xB2qKNgNOqOaTTbTfIkCo0nx3W1FEsQhZPw4b3Ldc3I?=
 =?us-ascii?Q?wg/Q6aqLNxk9h15LuRMku671FVQU4sX2jDlikT30/Em3wPKOJsBwIeEmik8x?=
 =?us-ascii?Q?2FORVroEWkZ4htZcylauOugjIW9KFVdvHjQGwNnCAcyx9cYJBrqdrgCCMVIM?=
 =?us-ascii?Q?SiFnjagbXpzcccWQds3mX+Vh0DPos1JaVG9BkSfXGHrWMdxr5HjebE4XxIVu?=
 =?us-ascii?Q?BgJbXlSs904maZd+hWtf2ZjD3orcLtXrag0WIou3Gn1J8vFFzTBRB5nOXmV/?=
 =?us-ascii?Q?LWEISWGZHq2jOTa3X/Mpl4YKQEZIOd5w8xHz0esWAoXQqX20Of2cuRL2aQk3?=
 =?us-ascii?Q?EKpscrb0z2F5EkqJEUPv8DHnPC1mAF1kvBJRqAfulVfQHBS8QkQhRlBSZYTz?=
 =?us-ascii?Q?XnT755RhBt2wTJE8Syg3P3fEYZ/i7bEEYXLQe6HUXf60VL3YEhLI0IxfNgXx?=
 =?us-ascii?Q?/Pafhmrb3RYpWbTbEY3Gcd0p9FddbbT7+FCOSgFsqBWzEevODJS5laHTS3eT?=
 =?us-ascii?Q?20SCQn1Ye1MKF6TLaR0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c021d36-bea4-4cf4-141d-08db7ef7e7fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 14:39:01.6515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOhztVN8UNLXgvGyFHt3NeKJiCvZ92TqQVdLQmG+IUA8SIXnZhdF/somqBMeTnDw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956
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

If we implement this in the GC 9.4.3 KGD disable call in patch 1 (see comme=
nts for that one), then it will look less awkward and we can drop this.

Thanks,

Jon

> -----Original Message-----
> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Sent: Thursday, July 6, 2023 2:19 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Huang, JinHuiEric
> <JinHuiEric.Huang@amd.com>
> Subject: [PATCH 5/6] drm/amdkfd: always keep trap enabled for GC v9.4.3
>
> To set TTMP setup on by default.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 3 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 6 +++---
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index cf1db0ab3471..47c5d16677d6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2842,7 +2842,7 @@ static int runtime_disable(struct kfd_process *p)
>                       pdd->spi_dbg_override =3D
>                                       pdd->dev->kfd2kgd-
> >disable_debug_trap(
>                                       pdd->dev->adev,
> -                                     false,
> +                                     KFD_GC_VERSION(pdd->dev) =3D=3D
> IP_VERSION(9, 4, 3),
>                                       pdd->dev->vm_info.last_vmid_kfd);
>
>                       if (!pdd->dev->kfd->shared_resources.enable_mes)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 190b03efe5ff..4cb9b3b18065 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -591,7 +591,8 @@ void kfd_dbg_trap_deactivate(struct kfd_process
> *target, bool unwind, int unwind
>               pdd->spi_dbg_override =3D
>                               pdd->dev->kfd2kgd->disable_debug_trap(
>                               pdd->dev->adev,
> -                             target->runtime_info.ttmp_setup,
> +                             KFD_GC_VERSION(pdd->dev) =3D=3D
> IP_VERSION(9, 4, 3) ?
> +                                     true : target-
> >runtime_info.ttmp_setup,
>                               pdd->dev->vm_info.last_vmid_kfd);
>               amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index ba04a4baecf2..91ae9121e2bf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1644,9 +1644,9 @@ struct kfd_process_device
> *kfd_create_process_device_data(struct kfd_node *dev,
>       p->pdds[p->n_pdds++] =3D pdd;
>       if (kfd_dbg_is_per_vmid_supported(pdd->dev))
>               pdd->spi_dbg_override =3D pdd->dev->kfd2kgd-
> >disable_debug_trap(
> -                                                     pdd->dev->adev,
> -                                                     false,
> -                                                     0);
> +                             pdd->dev->adev,
> +                             KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4,
> 3),
> +                             0);
>
>       /* Init idr used for memory handle translation */
>       idr_init(&pdd->alloc_idr);
> --
> 2.34.1

