Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424CEE77188
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2024 18:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF1110E574;
	Mon, 30 Dec 2024 18:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="loSKAM6a";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A751610E574
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2024 18:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f65gG0aZ5bWKZGSUegf3aNPa8pIaocKkkGx5dFleslkjhFZ00d3mPEQJPwzTgZTplZ72GdnZczCQmX+HXCRURyjyDzQS9SPCqJeozVK+Q1nr5u5xC2TA89ZLtlC7qEemK4HR8BcHLtyhcFNTzW7brDerWJa6CJPxpbnTO9NhjRcRpd6M/haG/POWNYSuMM62zVTgjn31AXIfQHdRKa6O1t2F5X0FfwM7Asv2UjvZVQCqioIt67BW0nwtSONI7SNiLbSbt4CdxRaKGV35SKPo2ApuC3VGu9Z/r/0SDaS90n+1Utw1EWbaDgRvG6vMmfUZIWKEQ0BaxuDggRCrSU5uEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5C57C/trzxcXFo/JlEjRwdP5ADtq0O5Xszh1rFEfVGE=;
 b=F0tv7/v/l9t8+CNWExPtS6MS0cfnNR+MVyt9gnPn8K6GHX+MgkLnLlAkmbRZTunMU8GGOiQ2BkK04VaJ6vZtQK/gi+5TdQeHEffvKZpZDV7aIPhsZZL87RMQ8mjxIqt1QrecHPQxSRpP4NAFJdbySvd9JtANq63woUN6o+cC0I4L+uImTcOBN9ri7YPfpih/z1dK9zttHJD0QccgO1EzM35qBmb478PttnJsC0PL3oN/xK2L/BcDR9wSz1na+QQiztkMS8KD7YrV4xUZCMFmcT8Ezi2CfEqbQlCdw3tN1GGfh0PgiFXFA9vn2aXMgYNuJgEeg2UQ81P7rb6gqJAgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5C57C/trzxcXFo/JlEjRwdP5ADtq0O5Xszh1rFEfVGE=;
 b=loSKAM6aeAgwg0XNExLHMGBxipmFIw2tXjruNFgoOI8XRoq7ENKF7wDpsDkkL7UmzR6UF25hLkhOMFIPUp6X2Y8/cP1ydIq9YDw/t/jzOeMOa2+tolfLHFxvfLFzDflnjLmTTn4G0j+JYsjphwfdDPO7AIRkp4o3mNtjyyYE02E=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.20; Mon, 30 Dec
 2024 18:37:05 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%5]) with mapi id 15.20.8293.020; Mon, 30 Dec 2024
 18:37:05 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Martin, Andrew" <Andrew.Martin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Ignored various return code
Thread-Topic: [PATCH v2] drm/amdkfd: Ignored various return code
Thread-Index: AQHbWtzXVboHpBTF8kmiZt7l2RD/WrL/DKdggAALGoCAAAYLoA==
Date: Mon, 30 Dec 2024 18:37:05 +0000
Message-ID: <BL1PR12MB5898C219584BBCB336BD214E85092@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20241230170223.574547-1-Andrew.Martin@amd.com>
 <BL1PR12MB5898B926B9A6FFF7D66E306285092@BL1PR12MB5898.namprd12.prod.outlook.com>
 <SJ0PR12MB8138C3B22C551491933825A2F5092@SJ0PR12MB8138.namprd12.prod.outlook.com>
In-Reply-To: <SJ0PR12MB8138C3B22C551491933825A2F5092@SJ0PR12MB8138.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=875e0fdb-fd47-4e84-b2c6-d64d1f1c1207;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-30T17:35:23Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|BL3PR12MB6377:EE_
x-ms-office365-filtering-correlation-id: 40a927be-2771-4d11-729a-08dd2900f5c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lJq2ATYFQY3ioa1KPmfSOq3iJ7imCuQ7TOsYvawMgWx00CXGfm5jkPy8GkSQ?=
 =?us-ascii?Q?SXZMhmdXRWyVm4q9drrmtUWltra7xlRwGBY0a9eNrS8qqaaqrHoQWgCOkaIk?=
 =?us-ascii?Q?0me2Lv42FsCYEwJoBQ8HX7OKFW8kZwXKIJ8Fwxw7GHhL3QnLkrL97Q8PT896?=
 =?us-ascii?Q?xnZSmXwFsmJNxXJliHUQmsKR8k2anvbApfbStKpDMgnjWCacwQb400q8NTnd?=
 =?us-ascii?Q?APBFK4y1yvvSTfFxh82ELzT2rUerycluEhMGUeUrJZc6TtIZxUTDOGI5yRMq?=
 =?us-ascii?Q?YB4CVoTkmhDwDp1tDDyTsokoNuHHgGVr23LMz94nRgTUcZ4/VmeTkEBXRmGf?=
 =?us-ascii?Q?puochp7rsFi3pYGVleXv+kpGwO9/LkRWQA7RtQtZp899W+sEgW6WybRTzhKl?=
 =?us-ascii?Q?IK6FATA+cGV4tVNcbncNrkQ5w98X1NbZ+6E6hd0/okjNgrBYPmm0MRv1jbMC?=
 =?us-ascii?Q?l4SV6sg9T9U1dNKxNMpCXigixCPUIr4ETxfzDLGAMhxvRpEaK0PGe9W33Lak?=
 =?us-ascii?Q?2X0a29c6Am8FImY5YzvcTxT0Ps7g49TGh1C0z+SwsxYWumV8QSneTaVSEYws?=
 =?us-ascii?Q?fM3NOeeCnkhrWznlqEOKLYEG+7mm/f5ljhIGwq4Dm6qRvFXmGJvNzqG+ES5y?=
 =?us-ascii?Q?E5GVQHjSCgzRijRjL0rczsUczxGrbTS8qWN2/TV+ZkSWWgqdwrxKaROJ2xuS?=
 =?us-ascii?Q?SkUnG+x5YgNEwuhlVhMAaejvvS9tQ6teGG4M5vAYlL9Dy4FvXXScYJzaaGxZ?=
 =?us-ascii?Q?0CQjCUUu7ymYoCybDmRW2vtNruIMTiXzMv7+vdgkwWPLJd/17xEp4e1l2GDD?=
 =?us-ascii?Q?zcW69SLJFbtiL8tgE1HjFoHlFJMIwRi2ShWI+9o/9rSGE9BGiLjhdsu3qwXa?=
 =?us-ascii?Q?ou6Dl0pFIP79spN2WuA/tTLCDSJ5eufIVit26HFO5kSdl3AjF0f6V9ooh05C?=
 =?us-ascii?Q?Dk7Hx4mg3Md5B15l/cwW2O88TxNywWKcej90NjOxK5JLxAWD69VH2y4Mot/t?=
 =?us-ascii?Q?UegCQFK0fgKCXsovaUJoO9hrzMGS0UDk19/1UHm9UwzxaMZABUkYUxP0iqRA?=
 =?us-ascii?Q?Una/chtVIV0XZC1WOrmEQzbDgWGStKJD2O3UMjl6oYK8L0uIMTH20mif7dTS?=
 =?us-ascii?Q?yFRAbpChgYLlRhbs32nTXZmJ1diVE4ikJ39NeTOKspezLsy4zrmRQar7yqkj?=
 =?us-ascii?Q?aiS3T/PTdlfsMULDCyK87lNwqZp1x76u0pRtN1EiD3gY/gEqFi0b8dyOr1rx?=
 =?us-ascii?Q?wjYMUgktx+7X2YsHsOTwFUpbds/m19RbBwUa37HOQvuI1Pn6Os0f6J0rTN4q?=
 =?us-ascii?Q?xLOmFIX92ORv9jtqtVLuYR6+q0YZMWs7ywCaHSjtg2Wg4gDbNSWcrr51BRO7?=
 =?us-ascii?Q?56q3D02/cexRqSrmPXg4OWM8ZYrmdUH56+oWqQgEWKgyn1NCt5IX26+pJg/4?=
 =?us-ascii?Q?D4fkTJf5YHAATdaVchC9rRWSzuW4LaCk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kldshbOz5k1VhKO9PCx/Q3O0OTdT/mdZwR5HxviINJ+U3aqwf0eP5Scs5OjM?=
 =?us-ascii?Q?cERPXmrMpW+AqoRZhQSvp280/aswHUxC4v3Z/tPI8bBuXJSBDnsfia14kHpI?=
 =?us-ascii?Q?en37ve0rZA6mE/7IvAudUoRQ5XP6imQuzNbPCfqH9Qf2vsIC5C+cQ2qa9yup?=
 =?us-ascii?Q?T/pmDqFJ5xFF25uybL8KHZd7v+ABjaqwkyw1FxQ5NscX85XOkNPYH/Fbyr+4?=
 =?us-ascii?Q?3KEZ85jRjZDTBI+qg+aPHNayg/4S20cmFd9PESQEis1kgl2zKBMfhsbhA3QG?=
 =?us-ascii?Q?H+QyiWMmbOixxzmIKQcjh07S52TrFrNb1ACJ/lyYxlOF1P6UPVRAPkmUO8EG?=
 =?us-ascii?Q?8EJORVRtUHHpOOo2IS7DYSmBYPAzch5F7bcB3GjiqE83GTeyB8QQcVqOjZOU?=
 =?us-ascii?Q?uCQM5nqvgLLYKfaJNKYWX0bBw6i6N8dWGObQ6Tgl9T9oUcGFUqryzrS5dS8o?=
 =?us-ascii?Q?5nFP8pPyg7gDOnnTMxWMn1Wdl8ET+qRDR2JdgFAfhbdJAoiW4QbNngPdCh/C?=
 =?us-ascii?Q?W8nxRVxZ3Fuf3QQ7fYIuVkd1FBlgI8BlhOKf2/R3p4C2EyEf06GhEWZC9GmC?=
 =?us-ascii?Q?67772J82TRd1Vuoe6AZyH3CoNt68ck9send46qLl/njG8d4lr3Bs6YJOFjGR?=
 =?us-ascii?Q?L5SpyCOsgQ0oHj+qqXTJf+h76x4rAnbdQALNUsAUZOdiyMxb92pAyH21Tiec?=
 =?us-ascii?Q?xtnqoe5iG+b+BaR6tQai+vREUW4nsK7SOAK3ogQctcpFbc6T95UErjH5fOhb?=
 =?us-ascii?Q?7LrusoGLAWgoBLKm95ALIfGsyKi94chOCaZvu+ktlvU8P01Idfsj7OROlFNb?=
 =?us-ascii?Q?+vWMO2fgJaan5ZgpVsg5MTpuWY1wnN5FiqHZCfniRJI8a1jMr7mQdIFW11gX?=
 =?us-ascii?Q?aHxFfNG4T3rbfA/vdFWszGZKFyZYA3QSyJcnBUkGIWPpqhGnAIYFvv2hmK04?=
 =?us-ascii?Q?6QOIUzMV6C4R4Ut1awMbs8mgCSc42fek8bZYcCRDjGCc6L4e2K5AJC+Wndty?=
 =?us-ascii?Q?I0o2NCmqxd+SFBg/9PNyaW3P4E7gSB+hNhkmk0QWE10fjEV5tjDHIqAG440V?=
 =?us-ascii?Q?D4/V8NnBySVZuzFWx+Vzefb4tDmwt1VyEe656ekxMwYjxH3Uz//BzD/qXgou?=
 =?us-ascii?Q?NazIKspdAXMHi64NnQHxm9ACCby3eehfvQhb9QcX1+gYJkkS+cKC8Hc5K59b?=
 =?us-ascii?Q?2ob7qmKwMqsuLNV9zUvc97DT5zWMG6w/1OuyaFU4lqS3gDmDmBSCpl4ggXIx?=
 =?us-ascii?Q?vcBfVLSelJz6ApQ1KMiYWVCOsmtMnb3uFo+abWCB0h0DWA7if63TmGAiz0RZ?=
 =?us-ascii?Q?plm+ovlaQuO9gEmAqfTlmDu5qkSpY1ZjZSu2em51fQkXSKaKH153dyX1GFE2?=
 =?us-ascii?Q?l3jNV2ncMUJBtka+h472UbHyWBUHyvXaYmV17bFNcQwMiTsBP5+r+HQunKEc?=
 =?us-ascii?Q?WZCiAXLeOsJd8LQcf4Ima72bUHXvT+2IDIo0VWXDuARGGQI7k+2CoZ2ahlhS?=
 =?us-ascii?Q?ZEB50OSyR8tWMjLJx9y6YrohLEC1hx5pMaSb3f7kGfVc2N/81FOz5YWDSta2?=
 =?us-ascii?Q?GMya9nn8UQc2wA+MQMo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a927be-2771-4d11-729a-08dd2900f5c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2024 18:37:05.6425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZtJrmoc14kqCYufGbSuxndC8lvJ9XZuM/uATgMhw8n/vLHUp9g3iOLY5tcc/zJ3voHNE9ZaejIAErDKP9oCIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377
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

> -----Original Message-----
> From: Martin, Andrew <Andrew.Martin@amd.com>
> Sent: Monday, December 30, 2024 1:15 PM
> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: RE: [PATCH v2] drm/amdkfd: Ignored various return code
>
> [Public]
>
> > -----Original Message-----
> > From: Russell, Kent <Kent.Russell@amd.com>
> > Sent: Monday, December 30, 2024 12:44 PM
> > To: Martin, Andrew <Andrew.Martin@amd.com>; amd-
> > gfx@lists.freedesktop.org
> > Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Martin, Andrew
> > <Andrew.Martin@amd.com>
> > Subject: RE: [PATCH v2] drm/amdkfd: Ignored various return code
> >
> > [Public]
> >
> > Might be worth changing the commit headline to what the patch does,
> > something like Don't ignore return codes Or Various return code cleanup
> >
> > Otherwise it sounds like your patch is intentionally ignoring return co=
des,
> > which is the opposite of what you're doing. Also 2 comments below.
>
> Thanks, will do!, Please see response to your 2 comments also!
>
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > Andrew Martin
> > > Sent: Monday, December 30, 2024 12:02 PM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Russell, Kent
> > > <Kent.Russell@amd.com>; Martin, Andrew <Andrew.Martin@amd.com>
> > > Subject: [PATCH v2] drm/amdkfd: Ignored various return code
> > >
> > > This patch checks and handles the return code of the called function.
> > >
> > > Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
> > >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 ++
> > >  drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 19 ++++++++++++++---=
--
> > >  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 11 ++++++-----
> > >  4 files changed, 23 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > > b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > > index 065d87841459..52a11dc01422 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > > @@ -2864,7 +2864,7 @@ static int runtime_disable(struct kfd_process *=
p)
> > >
> > > pdd->dev->vm_info.last_vmid_kfd);
> > >
> > >                       if (!pdd->dev->kfd->shared_resources.enable_mes=
)
> > > -                             debug_refresh_runlist(pdd->dev->dqm);
> > > +
> > > + (void)debug_refresh_runlist(pdd->dev->dqm);
> > >                       else
> > >                               kfd_dbg_set_mes_debug_mode(pdd,
> > >
> > > !kfd_dbg_has_cwsr_workaround(pdd->dev));
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > > b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > > index 693469c18c60..f335ed9e0b3a 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > > @@ -2351,6 +2351,8 @@ static int kfd_create_vcrat_image_gpu(void
> > *pcrat_image,
> > >       if (kdev->kfd->hive_id) {
> > >               for (nid =3D 0; nid < proximity_domain; ++nid) {
> > >                       peer_dev =3D
> > > kfd_topology_device_by_proximity_domain_no_lock(nid);
> > > +                     if (!peer_dev)
> > > +                             return -ENODEV;
> > >                       if (!peer_dev->gpu)
> > >                               continue;
> > >                       if (peer_dev->gpu->kfd->hive_id !=3D
> > > kdev->kfd->hive_id) diff --git
> > > a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > > b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > > index a8abc3091801..b4db409d90a1 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > > @@ -518,6 +518,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process
> > > *target, uint32_t *flags)
> > >       for (i =3D 0; i < target->n_pdds; i++) {
> > >               struct kfd_topology_device *topo_dev =3D
> > >
> > > kfd_topology_device_by_id(target->pdds[i]->dev->id);
> > > +             if (!topo_dev)
> > > +                     return -EINVAL;
> > > +
> > >               uint32_t caps =3D topo_dev->node_props.capability;
> > >
> > >               if (!(caps &
> > >
> HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED)
> > > &&
> > > @@ -565,9 +568,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process
> > > *target, uint32_t *flags)
> > >                               continue;
> > >
> > >                       if (!pdd->dev->kfd->shared_resources.enable_mes=
)
> > > -                             debug_refresh_runlist(pdd->dev->dqm);
> > > +
> > > + (void)debug_refresh_runlist(pdd->dev->dqm);
> > >                       else
> > > -                             kfd_dbg_set_mes_debug_mode(pdd, true);
> > > +                             (void)kfd_dbg_set_mes_debug_mode(pdd,
> > > + true);
> > >               }
> > >       }
> > >
> > > @@ -584,8 +587,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process
> > > *target, uint32_t *flags)
> > >   */
> > >  void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind=
,
> > > int
> > > unwind_count)
> > >  {
> > > -     int i;
> > >
> > > +     int i, r =3D 0;
> > >       if (!unwind) {
> > >               uint32_t flags =3D 0;
> > >               int resume_count =3D resume_queues(target, 0, NULL); @@
> > > -627,9 +630,11 @@ void kfd_dbg_trap_deactivate(struct kfd_process
> > > *target, bool unwind, int unwind
> > >                       pr_err("Failed to release debug vmid on [%i]\n"=
,
> > > pdd->dev-
> > > >id);
> > >
> > >               if (!pdd->dev->kfd->shared_resources.enable_mes)
> > > -                     debug_refresh_runlist(pdd->dev->dqm);
> > > +                     r =3D debug_refresh_runlist(pdd->dev->dqm);
> > >               else
> > > -                     kfd_dbg_set_mes_debug_mode(pdd,
> > > !kfd_dbg_has_cwsr_workaround(pdd->dev));
> > > +                     r =3D kfd_dbg_set_mes_debug_mode(pdd,
> > > !kfd_dbg_has_cwsr_workaround(pdd->dev));
> > > +             if (r)
> > > +                     break;
> > >       }
> > >
> > >       kfd_dbg_set_workaround(target, false); @@ -1071,6 +1076,10 @@
> > > int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
> > >       for (i =3D 0; i < tmp_num_devices; i++) {
> > >               struct kfd_process_device *pdd =3D target->pdds[i];
> > >               struct kfd_topology_device *topo_dev =3D
> > > kfd_topology_device_by_id(pdd->dev->id);
> > > +             if (!topo_dev) {
> > > +                     r =3D EINVAL;
> > > +                     break;
> > > +             }
> > >
> > >               device_info.gpu_id =3D pdd->dev->id;
> > >               device_info.exception_status =3D pdd->exception_status;
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > > b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > > index 1405e8affd48..250aa43a39c8 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > > @@ -1907,16 +1907,18 @@ static int start_cpsch(struct
> > > device_queue_manager
> > > *dqm)
> > >
> > >  static int stop_cpsch(struct device_queue_manager *dqm)  {
> > > +     int ret =3D 0;
> > >       dqm_lock(dqm);
> > >       if (!dqm->sched_running) {
> > >               dqm_unlock(dqm);
> > > -             return 0;
> > > +             return ret;
>
> I can agree with this one, since it minimizes the changes, but it does fl=
ow the same.
>
> >
> > I think it's cleaner to just leave the "return 0" . e.g. If the code ge=
ts refactored
> > and new stuff gets added above, then this might flow differently.
> >
> >
> > >       }
> > >
> > >       if (!dqm->dev->kfd->shared_resources.enable_mes)
> > > -             unmap_queues_cpsch(dqm,
> > > KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
> > USE_DEFAULT_GRACE_PERIOD,
> > > false);
> > > +             ret =3D unmap_queues_cpsch(dqm,
> > > KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES,
> > > +                                      0, USE_DEFAULT_GRACE_PERIOD,
> > > + false);
> > >       else
> > > -             remove_all_kfd_queues_mes(dqm);
> > > +             ret =3D remove_all_kfd_queues_mes(dqm);
> > >
> > >       dqm->sched_running =3D false;
> > >
> > > @@ -1930,7 +1932,7 @@ static int stop_cpsch(struct
> > > device_queue_manager
> > > *dqm)
> > >       dqm->detect_hang_info =3D NULL;
> > >       dqm_unlock(dqm);
> > >
> > > -     return 0;
> > > +     return ret;
> >
> > Same here
> >
>
> If I change this back to "return 0 ;" then I would have lost the return v=
alue from
> "unmap_queues_cpsch()" or  "remove_all_kfd_queues_mes()" which was the wh=
ole
> point of touching this function.  But since we in the "stop_cpch()" perha=
ps it is a more
> optimal solution is to ignore the return code with
> ...
> (void)unmap_queues_cpsch()
> else
> (void)remove_all_kfd_queues_mes()
> ...
>
> Which would be the only change here. Otherwise, I would need to introduce=
 a 3rd
> return statement.  So do let me know which path complements the design mo=
re.
>
Good point, I missed that it would drop the one from above. That's fine to =
leave in then.

 Kent

> >  Kent
> >
> > >  }
> > >
> > >  static int create_kernel_queue_cpsch(struct device_queue_manager
> > > *dqm, @@ -3439,7 +3441,6 @@ int suspend_queues(struct kfd_process *p,
> > >                                       else
> > >                                               per_device_suspended++;
> > >                               } else if (err !=3D -EBUSY) {
> > > -                                     r =3D err;
> > >                                       queue_ids[q_idx] |=3D
> > > KFD_DBG_QUEUE_ERROR_MASK;
> > >                                       break;
> > >                               }
> > > --
> > > 2.43.0
> >
>

