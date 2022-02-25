Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A211C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 05:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0EFB10E251;
	Fri, 25 Feb 2022 05:46:36 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 108F010E251
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 05:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4b0iPZZP4Y1lsRKbmnJciWxRp7tdSzyJgzC4c8BB+qd+UaAtlHw8sVaX0/12mxdEL7RgG5wvglCKEaFA0/x1T6Mize8Q/HkgEPO48yYoaDaE8JVqsQ8aUK28Iq1A1YxO9VWgOPSe6d/XvAwGQIKW/8q2ZmXYYuTEae/VOGWQYRdzJQBDfuZ+hSiywnfMDvceioOVlVBKWsXEWTdXV6joTfSP7aTG2TDNgoAnj4OeGdI5lxqHpm78X5rwAudygMF2tud+SNapoe+rK8BtVim92M7MN45dv5V3BAsKCgByrCkrLRxlhEZIEingTqR8F6ViF9V/pxhTbzvv7SlxPke2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvDOeg2k6TNH+eWEV+NYtJi+q2QtdR2NVWuXzyXiiqM=;
 b=KxKfX8woOhOw9H0G8DFJElW76zhQbzdskB9SZauk98Yxy8csZN6lGg7bhbiQpiQJMX2lQ0cd6UfndGFg0CFrq759FL3IbMOsNMlsBjoH8LBaqgxbHP7035ZbzgKVa3XTERiSOra+FXfp+yVAFKno92BPSIW6U52Xug9NgV3IAlXU3Hur97Wa4YJVa0kdXjahoTTZmGnWldEBxcrq1YcGcUcRZZzDhOnz8qtvc+D0mvdaTmkiYdUENxO/mFdJokkXXUC//avhI1QjjV4sNrKgP/FsiuCQRVlCjTLMHxhxcwtwpX60fSMsr97KNL0IWcIhcZ2KdKzzp6QYk4g6S4O6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvDOeg2k6TNH+eWEV+NYtJi+q2QtdR2NVWuXzyXiiqM=;
 b=rhNCYgfnZuqL38fi7vBtEjurZzCQGw2Jcf1dTsGn1gIfgm9YyZ4B5U5X764eSvzWluVLikQAaxv/fDlC+6Ay+MVh7yYwYzlxReuyxuzi2n/sCDJj5UmRnTqwrOO2JxDoPnBp8f0pBPQS5mcdSVMoGKiHtZCtSh9ouwxWyiE6dP4=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL0PR12MB2337.namprd12.prod.outlook.com (2603:10b6:207:45::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 25 Feb
 2022 05:46:32 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.5017.022; Fri, 25 Feb 2022
 05:46:32 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
Thread-Topic: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
Thread-Index: AQHYKf9MmA5oi8W9akOczJGxHmUWGayjv1wAgAAB40A=
Date: Fri, 25 Feb 2022 05:46:31 +0000
Message-ID: <BYAPR12MB4614577C233FED50C0EFC80C973E9@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20220225042156.676421-1-lijo.lazar@amd.com>
 <DM6PR12MB2619202956D5AF431734D5C8E43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619202956D5AF431734D5C8E43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-25T05:36:44Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b109171f-1a1d-47be-8559-ddfee2a8b805;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-25T05:46:27Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 31ddd703-3541-4e48-8f87-8f93b7a5ce22
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 326e15d8-1894-4f36-4ebc-08d9f8222d51
x-ms-traffictypediagnostic: BL0PR12MB2337:EE_
x-microsoft-antispam-prvs: <BL0PR12MB2337CAC914E34CBE49037600973E9@BL0PR12MB2337.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2QEa9FirksrmS85KvMtIbhBZdKltEdT8L/VKv3UvzCGWdVhL1ipQz/7Mb+l7S5KqcrZUbsHf/0d2g5l8rKthHKiTY+79Z7JxaktcynzDoZ+47E8z+KUi2SAL+Izg8acNt7P42CaXVCUdoM6yhwtb3+xOfELU2umdgPZ3cTBnecaorDPDuCOU/HI1xr9gFdNxS+dqBZGW38KABU/xffN5GvoISVEJJsHtP6fA/siC9uuZboOz0ukSzTKnILik6D7Fk/RAY1ntC68akXsnbqI3gxxmKy1GuMVqI4mmg83ITON21C9Xat9ziu9aTyd3qbOJV9Qe1iGhuerZ1vYV3rBYuRGvfXEtB3atjPjGsUC4fAVB33G1T5bBG5VgDs/TI9F3rktnxoF/Pbcv7xQrSZ1PxiyNbL/71Yo89WOu5KQ2Td3Jbo+JCBEGsjK91UyJypo5Cw35j5MyfyDAvKgIbkZuliNbKH6WIL081/p9ohZT78C4CMet4TEg1nYr0fjNOCIQrXcxHA9wQJ0eB3kNmiCPnhuZGH++gcwV/Z2ZYzprQ2fBpy/FvvtqmDWy53vKru5waHQiHzlWr8LqcFMw0PEb+qyVmPtMTrzaUbbhorkzBAQiOQFwBx4CeJeGzx/o8FJVvTrcUtfOdmT5sKXxYq4kzlispTtOL4Bl/NAHO/uUFAjbaKXQQbC/AEluQ+ubK1yVd9IpkwC4uOb92fcGNWXm5Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(8676002)(4326008)(66446008)(33656002)(26005)(186003)(2906002)(55016003)(15650500001)(66476007)(8936002)(508600001)(64756008)(316002)(38070700005)(86362001)(122000001)(38100700002)(52536014)(5660300002)(53546011)(66946007)(66556008)(6506007)(71200400001)(76116006)(7696005)(9686003)(54906003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lLsqdjJ/G2zz65G/2ZjwBLzPTjdzRzPXeik1QoEGEsABok4bDFLYny511YlM?=
 =?us-ascii?Q?iRrfEb+CWUC8acwuTsEGfuayMg2s66IJF45MRR+v1fyrSPugzXB5teZBctjg?=
 =?us-ascii?Q?Aq88WxKsit22AFarYyape7TiFCsawIy4hzMk+oQgO2ebU9EdJQIhQmgJ4gRW?=
 =?us-ascii?Q?ljyCYm/3nuO9k8ljWHHv4QbWM2EMaTQkLvzomcbJA2xkaiWcOBU5LfDazRrV?=
 =?us-ascii?Q?+SfBO28QXI5XMY5n1DoOT+379fO7o0yOR7t88LRmAC2avd3EAuElWA58+TD6?=
 =?us-ascii?Q?AqhF+VAf75nKxsWFK8HBMypLLOaTUHkk7/zXzrsQuCQ2EmpwhkOJ41CYKBxo?=
 =?us-ascii?Q?xNNoJmsDDanIi1yukXS20hFsrB8BQOexVDSzC8/25Mo67JyAFcbxcUiIvXmp?=
 =?us-ascii?Q?ardIudTy+scpO5MEBHklDOBmSdTuK2UC6IgoNz5lu8xFzQUL0yN6ShN6CsAx?=
 =?us-ascii?Q?OGmVGq6Ja41Icz/u9JOdR7fBQFVPD+BuMGpkhXisWKagSnPcAe5REevqBzjW?=
 =?us-ascii?Q?yhVlpy5LGpj/jPQsNOUHTIHG+7z+CgmtxAUEi1Bh4Gq2uXevzF1INvv53OEp?=
 =?us-ascii?Q?IHRUifZd8+vP/CgEgyA4RPBByfZNGAleFg0ua4YfXtEhW2mKpM9riB+zeF/9?=
 =?us-ascii?Q?x6tpFm30IGVnv/mKAtxPoPHO5ZvKXGcm0yWaS3r1drstPwCCoVlYedp5oOI0?=
 =?us-ascii?Q?EEzmuutmAGREfT7mR7wffDJllmcl8lsUm3/8PlevRKhck4Udi24hvdsQIfRy?=
 =?us-ascii?Q?g07vtpdWsy6Qz4DLs/StTPlHwblysR+DUyFFmI3H7/LofEwFXWnsPosAn/0n?=
 =?us-ascii?Q?RmcTPdW8AQwHGPVQfj5a/RMuSJbmFZZPS3nYximcQwgAG0jsgQN8NtE4oqNr?=
 =?us-ascii?Q?vYaPm26kEqjvPBqWPIqMn9iqgEVA70QHFPehpYVfhY1LpS90pGANlfhCc1NX?=
 =?us-ascii?Q?BMfgMKXa0Shm5W+6TJ4lEbFRuPJgy2cfND1R+WPhBewKFZmYbE+P2yzl/1kl?=
 =?us-ascii?Q?w3HHfx6nzsc6ww9UVFxXNntNEl/WlfDV7Ytz78GWSxLk87zZ9nZeWaQXlizv?=
 =?us-ascii?Q?j0Ln6mw5eaiAY1MsoltVxfmu9VcmvBsrhqe20l+y7osnDd1V/qwfyvMHZGpO?=
 =?us-ascii?Q?rEOEgk12Oa+MsZfYheNzmldS2AhRpmC2FMK0VdH0Aq1pvY8IVvjGhSD2ApTD?=
 =?us-ascii?Q?iO5XIxdrl/HRu1Jrpn/0NvmtlyQdvU88/3q55PZCGgoAAyg20Nbq/D3Xq/jy?=
 =?us-ascii?Q?bfl2kU16bGk1w4yCYWvcvYUAShQHdzV+ROvAjbsQna4T73nLl+aGm1VT0lDU?=
 =?us-ascii?Q?f/PiWHAZugQMj5tq7FZ8V3jnnK5h1vwOzIwfDc8snI5NN/+CtjQq2JgYKSyN?=
 =?us-ascii?Q?7rzHzT5C6dgh2GXHG17/KzDamBxnmuhOOkaQFw0+TbQmKQ9hyMVACmacfbTa?=
 =?us-ascii?Q?j/Qc6RbXudF6erkCVe/eaRmH+YTzwQbwqyxw90TixyE01XgcW0Kd45dIN8tp?=
 =?us-ascii?Q?WMNNSQlzXYlDwxwEQztAFIpOnvpNZwpbeVtcEXYanJn+reOzqiqPHi6GTODc?=
 =?us-ascii?Q?3tMa41cPZ0LbaigqMeY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326e15d8-1894-4f36-4ebc-08d9f8222d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 05:46:31.8297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlQ3/9LZBeZ6NdEwNYqTxO5z/XXGAW+Abed4f8IA9Brv5KHA47zLNckkHA4TxH2C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2337
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

> That is the caller can perform something like issuing the same message ag=
ain without prerequisites check on PMFW busy=20

This patch expects this method. Caller may try to resend message again. As =
part of message sending, driver first checks response register. Current log=
ic blocks sending any message if it sees 0xFC in response register, this pa=
tch is to address that.=20

Thanks,
Lijo

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>=20
Sent: Friday, February 25, 2022 11:07 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Send message when resp status is 0xFC

[AMD Official Use Only]

This may introduce some problems for two callers scenarios. That is the 2nd=
 one will still proceed even if the 1st one was already blocked.
Maybe the logics here should be performed by the caller. That is the caller=
 can perform something like issuing the same message again without prerequi=
sites check on PMFW busy.
Or we can just update the smu_cmn_send_smc_msg APIs to give it another try =
on PMFW busy.

BR
Evan
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, February 25, 2022 12:22 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander=20
> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)=20
> <KevinYang.Wang@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
>=20
> When PMFW is really busy, it will respond with 0xFC. However, it=20
> doesn't change the response register state when it becomes free.=20
> Driver should retry and proceed to send message if the response status is=
 0xFC.
>=20
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 590a6ed12d54..92161b9d8c1a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -297,7 +297,6 @@ int smu_cmn_send_msg_without_waiting(struct
> smu_context *smu,
>  	reg =3D __smu_cmn_poll_stat(smu);
>  	res =3D __smu_cmn_reg2errno(smu, reg);
>  	if (reg =3D=3D SMU_RESP_NONE ||
> -	    reg =3D=3D SMU_RESP_BUSY_OTHER ||
>  	    res =3D=3D -EREMOTEIO)
>  		goto Out;
>  	__smu_cmn_send_msg(smu, msg_index, param); @@ -391,7 +390,6 @@ int=20
> smu_cmn_send_smc_msg_with_param(struct
> smu_context *smu,
>  	reg =3D __smu_cmn_poll_stat(smu);
>  	res =3D __smu_cmn_reg2errno(smu, reg);
>  	if (reg =3D=3D SMU_RESP_NONE ||
> -	    reg =3D=3D SMU_RESP_BUSY_OTHER ||
>  	    res =3D=3D -EREMOTEIO) {
>  		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>  		goto Out;
> --
> 2.25.1
