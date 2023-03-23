Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7039C6FD1C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 03:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A1CC10E43B;
	Thu, 23 Mar 2023 03:24:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 823C710E43B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 03:24:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USVniz8Ygh+/JTb/JJOgFjRpAkSmCF5M14PNVStPzEfeJxpkQIowZGyCz9n5H8pSVjGMsSXQSpVxmQ8PASlEaQdpSNJRtxgK95kg0IOk3z0jRuVVUM9mdHrmEk0JMkMZ1PWxIsiGR1UaPV+N78aQaqX23Z0oNXHx1rnvUrScq6zm5gJXKbZq+qX6VczEvW1KyR1SQbrYIl18XXEORd+907teAkmT13k4P+lIheP3o+OE+HGygPmGUXl3JJecsfLOE5czwLDRefnoYryLSSwFHQV77K9Z3faTCnd1AjDKNSQAL2+p8ZIhl60r50Yx1Z6qOIj5aaWRejP2DFM7Su7FBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJZXYnt/9bRvG5UjqBUuHJXTN+wEJF4iNWQUUVKJogQ=;
 b=cx3GGms5Us8OiRQ1UZrFLkcSFDMLUoNOtWafV4lHGWUkjP92bfjNxst48hdu7TLKxUvCW2D1mJ5S+i0S78EyDM815NN+GiG92t9C4pirGXu3KEvKm3FPUtrUGffdupeRvx51mbYpppreeu7CvyEiddelEyOpDuMUZMqTiB6M+Nlml5kRzIhNceDrbDpBcI2nWQ36qTnMTU+fLNvvPDH9BO6psGQCo67VLnC14ONSSLJU6S/ipRIaNzC0RJQa+GjrzDErdnKblI4clsRIctFN8s5132HAdbqLEUkXofJ7XBAQhVvnr9FT/4+1I/sn7GimSIgG8/oqlU9ImDhNIyIzmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJZXYnt/9bRvG5UjqBUuHJXTN+wEJF4iNWQUUVKJogQ=;
 b=uyCrWs7SObXmaLQxsqD9yKvibEFvzJ/V88ymhUi0MfLbS5XhDH3o63rORdZ1w29ZRcdJsbUd/84pd8TeVrdIS57Bl+xwwZXlNoAK5gd6//dmKmTUfUzOakv7zSyn7RQGcvDyD1HEZp505h6R7BXvHAM7v3vp2KwdvnmtUdk1Fx0=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by PH7PR12MB5618.namprd12.prod.outlook.com (2603:10b6:510:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 03:24:42 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92%9]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 03:24:42 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add fatal error handling in nbio v4_3
Thread-Topic: [PATCH] drm/amdgpu: Add fatal error handling in nbio v4_3
Thread-Index: AQHZXS6LXq0bgz4vtUizMmvhjDQJ5q8Hs53g
Date: Thu, 23 Mar 2023 03:24:42 +0000
Message-ID: <DM5PR12MB177068AF5364FE12E22E1C4EB0879@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230323022344.7533-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230323022344.7533-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-23T03:24:38Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=14e157a2-5b79-4966-9ad5-dd4bb375820a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-23T03:24:38Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 6e6ae536-6bf6-4d6a-8232-2507372cf96c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|PH7PR12MB5618:EE_
x-ms-office365-filtering-correlation-id: 76765c63-f198-4484-1f3b-08db2b4e24a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Oftk5jtnDF+Qp25aBlwlriRCTGXkws2uNf0PFHCz6xYyprQLqJ5GL4cUCblJBHEboKSS36MYTKPPTeeJ0FbQefQ5UNZdkhIqJz00hQoqQJhr2axnjLa4IbCY4tHEz51IDAV8g5znhf78nglOYijyozcgBhw9jbw0A+dAcniOO9690EmVt1oG3Z4GJB9tGapJElwCI8YLAs8l19nuL32gYvhJ3IsCkfyZzCuguic9BTnuEJ3nO5wk0LnSz10I0j9KXFVwPFl2wsfIZU+q6xBEIgbrAxUJQNwhgZkEeqHNsyL6M+LgCRbcc27Utqg9R5kTSE+kNQWOF4e4zRxm4nSHMiRgyB0kP+5Vo3CHJO3TZki3A3xahP67PGBxpPFSa5AV0PaywCtlcRhl09xf6+CaIlV883U9WrALpnNyb39TKHIE3pR3BEXJVul9S4Ku15NrKzeh03n6OyfMmxzpwfV92eBu/1svtOOkMFjzDalnWaqBADxyzZDLXy51YK4KjJTdP+0Plw5xvAvT3m/BAw7k2ZlxzX5aPP7H0opa0kkcqXfS8cPOfJdrPEu9V2zKznTnrdZqXa3AmPZeYT4HAgnHRvq12/fjgshEbuxlwmV9M6+yuNiRJqINgn7qHQrhvi+/c9OtQTOBRSHHQGawHkFzSPdCPAXjnLtEDrh1pj9jr8o65eDjCU+Y/NUsuo3FIPsS/F7+uEYmyvAiV33+25AVA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199018)(6506007)(110136005)(53546011)(9686003)(66556008)(26005)(83380400001)(8676002)(316002)(52536014)(6636002)(64756008)(66476007)(66446008)(66946007)(186003)(5660300002)(478600001)(2906002)(122000001)(41300700001)(8936002)(38100700002)(7696005)(76116006)(71200400001)(38070700005)(86362001)(55016003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?noKv3J+PQ+hRFw/CdXGHxKAXBCGE9wA5BuGk1I/XE2TsS9TWZfnaxDqyFeQu?=
 =?us-ascii?Q?PArY68B6NJFYRRY2zYdZgFa3Ywg3kSzIuwus5At2dsM1venINgYdp/VNso//?=
 =?us-ascii?Q?90wiAcfvadNMPe44r8QFpaI1dB1PF7CP+9uuc5w/nPOz9n6JFg3qUzuoP82k?=
 =?us-ascii?Q?a1K8wgCIlppkkTv0JbrZp3mXrbHuL/fIJTHW11BEBNtpJn/VfMIhn2jL1H6R?=
 =?us-ascii?Q?FFoLgnnqRcnIamJoHbBoY4tdvqlhtG4rzIgDxaGHhv+l71hQlBn9YfZAE7rH?=
 =?us-ascii?Q?xH0yyFsyfiJ/iCNFdm4lWvNGOhiBITa9WisrPbapX4F819s4wYakZenYjTHF?=
 =?us-ascii?Q?cOT9h3Lg5zGA+PYJSxbYO/2K743iiCFp53KBdM5IUkSH38fBZBJhUiiu1QmE?=
 =?us-ascii?Q?PsYOfCEU6BRDWCyj37LyzpiKuG/TFuEY+MWI2gWOb1FAfAlL5bsUlR9II4S7?=
 =?us-ascii?Q?3/I01AgEjapxMw0ZI8jmiLOVhy9aN3LLJAwv27gJKme4P/r134b5KqzzwRd6?=
 =?us-ascii?Q?6VcyklxBlmcGZJkhckShf8+5+ymIyrT4d73LWhO5v+JgjG2z4FTcnZrnm49h?=
 =?us-ascii?Q?/YOQ4rWTqP7p7oyd65qAscMmrEXYoH1Z/QtvbL17Ka9dvhP7hYeyjCRbfvhh?=
 =?us-ascii?Q?6kDgA7thvcVWdDYjI3bvAjDOLD+UBmxkOlQBQQcvETI/cgHSoZ1CwSBOB3J3?=
 =?us-ascii?Q?E77NdSV2ZB4t5zI9dXfNx0HgSdKkBuZch51LbEZHPxc09Vmqn2ei5Is6weHg?=
 =?us-ascii?Q?GuWE/raPbIQQz9D/HIo5nXDkOC8vj3SRwoB5ChWgxK8zB7purRj0ue9nEH2J?=
 =?us-ascii?Q?e44ksax9hKqf4RzDyGrQ7+1JMgN/0izHWizgPjlYUMfuHoUNJpTdfTbEkm7v?=
 =?us-ascii?Q?tiGJrFXEV3tkfCVPQ3B0IG+fmmfsKCWLIZcOpo4ybiPiUyntV7vDyPM6bTKq?=
 =?us-ascii?Q?Az12s9nNCcvCozpdSv6mqfKJvmklmXpHaThTUJFFN0owaNpdXqfwZAOKgUjn?=
 =?us-ascii?Q?r7eHTIn3NQ1dMixPiXpLqh9drq9keKB5dzaWBR//MuxOP/RRx9oG+k8qUtgQ?=
 =?us-ascii?Q?5Lwl1vu3iwZLy6bvqm+UU80YYFLOhzoSQz7boFiokEi/fohdKeXDOSQDwQmM?=
 =?us-ascii?Q?L8SmlCrlFmpStIFUivgiAHuyfAL82pDgyME0s1DXegsTi2hMxZsV1pxGx0IK?=
 =?us-ascii?Q?yNsawTVOeQaMb12eIhJidNooWH9j46xWGedAqYtY00FA9aNh3JPL/TfPSMA3?=
 =?us-ascii?Q?PAyYgQ/g8lLyLcRQAV78EQvVOMsLJO29ojyL2OPBif5x45t0KIaq2iTwb+xh?=
 =?us-ascii?Q?6q7avZpfcS3XkmkefncmFulC+ikfg5RAixdTJ0LhRfrNVkcFtfUf0/TFoDVf?=
 =?us-ascii?Q?onanWM9EK4DSz/Cbm999CivyACK1yWZE3JF6LKBFB4oWBMjomlYT9j0rjQ/v?=
 =?us-ascii?Q?F2VqXPN5z+A1WrALsxoChN4KIUiebjmFu2amtaZsp6UFFi+wfTCp0cAgW4Gj?=
 =?us-ascii?Q?wjpvKNGmmF/vUr56SNLK0vxuXSRONQ2wq+gZ/B1K1qmHnCArDiCTpUCo2Yy9?=
 =?us-ascii?Q?V9E2AWx7HmlPUe/Ferc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76765c63-f198-4484-1f3b-08db2b4e24a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 03:24:42.5251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XaoPmFZYrwXHTqr8JE3oOrniIfmuOYGn0CgaqjsTRctSz+VO2Ra2Eqiay+rzNu23
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5618
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

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Thursday, March 23, 2023 10:24 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Add fatal error handling in nbio v4_3
>=20
> GPU will stop working once fatal error is detected.
> it will inform driver to do reset to recover from the fatal error.
>=20
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 ++++
> drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c  | 79 +++++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h  |  1 +
>  drivers/gpu/drm/amd/amdgpu/soc21.c      | 15 ++++-
>  4 files changed, 105 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index c6dc3cd2a9de..5b1779021881 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -34,6 +34,7 @@
>  #include "amdgpu_atomfirmware.h"
>  #include "amdgpu_xgmi.h"
>  #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
> +#include "nbio_v4_3.h"
>  #include "atom.h"
>  #include "amdgpu_reset.h"
>=20
> @@ -2562,6 +2563,16 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>  		if (!adev->gmc.xgmi.connected_to_cpu)
>  			adev->nbio.ras =3D &nbio_v7_4_ras;
>  		break;
> +	case IP_VERSION(4, 3, 0):
> +		if (adev->ras_hw_enabled | AMDGPU_RAS_BLOCK__DF)
> +			/* unlike other generation of nbio ras,
> +			 * nbio v4_3 only support fatal error interrupt
> +			 * to inform software that DF is freezed due to
> +			 * system fatal error event. driver should not
> +			 * enable nbio ras in such case. Instead,
> +			 * check DF RAS */
> +			adev->nbio.ras =3D &nbio_v4_3_ras;
> +		break;
>  	default:
>  		/* nbio ras is not available */
>  		break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> index 09fdcd20cb91..d5ed9e0e1a5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> @@ -26,6 +26,7 @@
>=20
>  #include "nbio/nbio_4_3_0_offset.h"
>  #include "nbio/nbio_4_3_0_sh_mask.h"
> +#include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
>  #include <uapi/linux/kfd_ioctl.h>
>=20
>  static void nbio_v4_3_remap_hdp_registers(struct amdgpu_device *adev) @@=
 -
> 538,3 +539,81 @@ const struct amdgpu_nbio_funcs nbio_v4_3_sriov_funcs =3D=
 {
>  	.remap_hdp_registers =3D nbio_v4_3_remap_hdp_registers,
>  	.get_rom_offset =3D nbio_v4_3_get_rom_offset,  };
> +
> +static int nbio_v4_3_set_ras_err_event_athub_irq_state(struct amdgpu_dev=
ice
> *adev,
> +						       struct amdgpu_irq_src *src,
> +						       unsigned type,
> +						       enum
> amdgpu_interrupt_state state) {
> +	/* The ras_controller_irq enablement should be done in psp bl when it
> +	 * tries to enable ras feature. Driver only need to set the correct
> interrupt
> +	 * vector for bare-metal and sriov use case respectively
> +	 */
> +	uint32_t bif_doorbell_int_cntl;
> +
> +	bif_doorbell_int_cntl =3D RREG32_SOC15(NBIO, 0,
> regBIF_BX0_BIF_DOORBELL_INT_CNTL);
> +	bif_doorbell_int_cntl =3D REG_SET_FIELD(bif_doorbell_int_cntl,
> +					      BIF_BX0_BIF_DOORBELL_INT_CNTL,
> +
> RAS_ATHUB_ERR_EVENT_INTERRUPT_DISABLE,
> +					      (state =3D=3D
> AMDGPU_IRQ_STATE_ENABLE) ? 0 : 1);
> +	WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL,
> +bif_doorbell_int_cntl);
> +
> +	return 0;
> +}
> +
> +static int nbio_v4_3_process_err_event_athub_irq(struct amdgpu_device
> *adev,
> +						 struct amdgpu_irq_src
> *source,
> +						 struct amdgpu_iv_entry *entry)
> +{
> +	/* By design, the ih cookie for err_event_athub_irq should be written
> +	 * to bif ring. since bif ring is not enabled, just leave process callb=
ack
> +	 * as a dummy one.
> +	 */
> +	return 0;
> +}
> +
> +static const struct amdgpu_irq_src_funcs
> nbio_v4_3_ras_err_event_athub_irq_funcs =3D {
> +	.set =3D nbio_v4_3_set_ras_err_event_athub_irq_state,
> +	.process =3D nbio_v4_3_process_err_event_athub_irq,
> +};
> +
> +static void nbio_v4_3_handle_ras_err_event_athub_intr_no_bifring(struct
> +amdgpu_device *adev) {
> +	uint32_t bif_doorbell_int_cntl;
> +
> +	bif_doorbell_int_cntl =3D RREG32_SOC15(NBIO, 0,
> regBIF_BX0_BIF_DOORBELL_INT_CNTL);
> +	if (REG_GET_FIELD(bif_doorbell_int_cntl,
> +			  BIF_DOORBELL_INT_CNTL,
> +			  RAS_ATHUB_ERR_EVENT_INTERRUPT_STATUS)) {
> +		/* driver has to clear the interrupt status when bif ring is
> disabled */
> +		bif_doorbell_int_cntl =3D REG_SET_FIELD(bif_doorbell_int_cntl,
> +						BIF_DOORBELL_INT_CNTL,
> +
> 	RAS_ATHUB_ERR_EVENT_INTERRUPT_CLEAR, 1);
> +		WREG32_SOC15(NBIO, 0,
> regBIF_BX0_BIF_DOORBELL_INT_CNTL, bif_doorbell_int_cntl);
> +		amdgpu_ras_global_ras_isr(adev);
> +	}
> +}
> +
> +static int nbio_v4_3_init_ras_err_event_athub_interrupt(struct
> +amdgpu_device *adev) {
> +
> +	int r;
> +
> +	/* init the irq funcs */
> +	adev->nbio.ras_err_event_athub_irq.funcs =3D
> +		&nbio_v4_3_ras_err_event_athub_irq_funcs;
> +	adev->nbio.ras_err_event_athub_irq.num_types =3D 1;
> +
> +	/* register ras err event athub interrupt
> +	 * nbio v4_3 uses the same irq source as nbio v7_4 */
> +	r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_BIF,
> +			      NBIF_7_4__SRCID__ERREVENT_ATHUB_INTERRUPT,
> +			      &adev->nbio.ras_err_event_athub_irq);
> +
> +	return r;
> +}
> +
> +struct amdgpu_nbio_ras nbio_v4_3_ras =3D {
> +	.handle_ras_err_event_athub_intr_no_bifring =3D
> nbio_v4_3_handle_ras_err_event_athub_intr_no_bifring,
> +	.init_ras_err_event_athub_interrupt =3D
> +nbio_v4_3_init_ras_err_event_athub_interrupt,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
> b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
> index 711999ceedf4..399037cdf4fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
> @@ -29,5 +29,6 @@
>  extern const struct nbio_hdp_flush_reg nbio_v4_3_hdp_flush_reg;  extern =
const
> struct amdgpu_nbio_funcs nbio_v4_3_funcs;  extern const struct
> amdgpu_nbio_funcs nbio_v4_3_sriov_funcs;
> +extern struct amdgpu_nbio_ras nbio_v4_3_ras;
>=20
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c
> b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 67580761b44d..514bfc705d5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -754,6 +754,14 @@ static int soc21_common_late_init(void *handle)
>=20
> sriov_vcn_4_0_0_video_codecs_decode_array_vcn0,
>=20
> ARRAY_SIZE(sriov_vcn_4_0_0_video_codecs_decode_array_vcn0));
>  		}
> +	} else {
> +		if (adev->nbio.ras &&
> +		    adev->nbio.ras_err_event_athub_irq.funcs)
> +			/* don't need to fail gpu late init
> +			 * if enabling athub_err_event interrupt failed
> +			 * nbio v4_3 only support fatal error hanlding
> +			 * just enable the interrupt directly */
> +			amdgpu_irq_get(adev, &adev-
> >nbio.ras_err_event_athub_irq, 0);
>  	}
>=20
>  	return 0;
> @@ -801,8 +809,13 @@ static int soc21_common_hw_fini(void *handle)
>  	/* disable the doorbell aperture */
>  	soc21_enable_doorbell_aperture(adev, false);
>=20
> -	if (amdgpu_sriov_vf(adev))
> +	if (amdgpu_sriov_vf(adev)) {
>  		xgpu_nv_mailbox_put_irq(adev);
> +	} else {
> +		if (adev->nbio.ras &&
> +		    adev->nbio.ras_err_event_athub_irq.funcs)
> +			amdgpu_irq_put(adev, &adev-
> >nbio.ras_err_event_athub_irq, 0);
> +	}
>=20
>  	return 0;
>  }
> --
> 2.17.1
