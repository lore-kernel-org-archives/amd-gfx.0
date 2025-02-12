Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5588C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 17:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F69810E94D;
	Wed, 12 Feb 2025 17:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uwKEcmY1";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0447110E94B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 17:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owpN8dt5qfDJqtTqqDRz0DUzC3W/thrS41CGOkDB8DAWq9d+q4fnyWfrJEfVCegxSQVEXMgBxWGB5pUcSDVEvBcVN1W+LB4UWzpnT6W1WMmCueLtYWOfMgYPl3qT4QOD+13higFSTz32IgZewOdSbrX2MEk9G7cpvWXwbLLkRnA/UJUvpReszrEDv3EU/U5mi+CVw4Ck6Oe2cFAfIQL83vwH4C3+rQUHVJKiQoXttaaN7yoYiyjVf6dsULQ/oZdnUqHi7X0WaFR76lD9kwYKtqVcDUxR/L/PRvsr2Km4Omj0gVMUyAKZEb5awbx4CXFoSCSviWkVsDjD4G0Kp31LbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGF3H6nN3G/HY3q/bzZS/0+jk0TcFttqXp0k2U7K07c=;
 b=NvoB4+jSqXuLtZu7FJszU5vpG1cj4CRgxXf5Z1BVuZ984M6UyUzQXc80iquh11miEQbLBTEqpLKyE20+kgdqruqYDmbCHw9dVuRZ8d5gLBULsqExnpQUoT0VUL1IQfrk/BYE7h1cccKBuguqxw8pEGPMIlopFnfSuq+EDUaNejdPCvAKo1kKpju1flDmeDiKUCmW3HULmaHvZjKNWjox3mMhRDA376XOnbatOgJ8vDsutCZUvmnufTYrJk6kFvr15T8gtH9bCQN07fgyoGXcPDY+eEkIZiKdxQWUFt44BQHhGlEKpzUJm+mMNIWbdHpNj/O4rnM1Z0hqyTB7GrBi3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGF3H6nN3G/HY3q/bzZS/0+jk0TcFttqXp0k2U7K07c=;
 b=uwKEcmY1x/d5N6Jog6DrRY8GbNTOprguSo6/7rXPUs8aGZjEDKjZb6JJZeuh/jVsnzQa+VCu879JTRykVQQcOjbvKHtz3Qt6loEe6WcscHWzHLESWMOrW0lQ3s1mHIn0UJ4aJN3uScCgZ3P60y0C0uLE23JcIWL0+3wIytFPzPk=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 17:53:50 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::b62f:95b3:3fa5:d345]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::b62f:95b3:3fa5:d345%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 17:53:50 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdkfd: Uninitialized and Unused variables
Thread-Topic: [PATCH v3] drm/amdkfd: Uninitialized and Unused variables
Thread-Index: AQHbYfk+ks1ilL81B0iOFKNs7bw/SbMZpXQAgCqCTMA=
Date: Wed, 12 Feb 2025 17:53:50 +0000
Message-ID: <SJ0PR12MB81384CAFE5F236BB1577EF20F5FC2@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20250108181435.2244038-1-Andrew.Martin@amd.com>
 <BL1PR12MB589868A4E88F2C0234A5AD88851A2@BL1PR12MB5898.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB589868A4E88F2C0234A5AD88851A2@BL1PR12MB5898.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Kent.Russell@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=fe487654-b811-4f5e-bfea-18e7b7aed5ad;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-16T16:34:22Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|MW4PR12MB7263:EE_
x-ms-office365-filtering-correlation-id: 10401199-3121-462d-5043-08dd4b8e3500
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5k4IcRXu7vcbN+QPNiD6Ry1wEzbKcg/qPaSC5XBHkpQNrp3u8VGbZibMnoa7?=
 =?us-ascii?Q?JxKX2fvCvj7tVIDoHIJQCJ+pCcbAxZ01YEXhKX0pyFH9VMJfAov/p5TRg2mI?=
 =?us-ascii?Q?JlgyxJCRKRZYXB6BhciCkj6U1ZIZTPpFKIG3hQg0j3vdl9I372g7dn8Avryk?=
 =?us-ascii?Q?x9vJlwNwrwgaG4cYd6WxcA4RL8BqQsWw0pncuaKmHWXTNPvQPyZIZfcqbKob?=
 =?us-ascii?Q?PFlb5pWEgh3XjOOfdjr7R6TwkzArf0/aC6CgHvuB2dFmmj6zCYD4bNPWR3cG?=
 =?us-ascii?Q?8ius5m0Jp70vRW947DZPXrSq/9whxkBYWyx1VudEwSbmZdtXbd7FvnDk0IAB?=
 =?us-ascii?Q?SkmsEHGB2c26Q61N2mgT7v2XGUYnN9DeUCF7x5eEGVPCRWD0gn8R+p6fMeXB?=
 =?us-ascii?Q?YfVJZyFL17DxFvkdRztXyGO/rUXmVuSSn5QLhfnrawW81S8Dd/ZTBxxaqt72?=
 =?us-ascii?Q?0Wdp9/J2E95ECijNW3r0U3bHcJgpDIUV+7qD8QCPXotjvxo4mo3AmjKvs4qD?=
 =?us-ascii?Q?OS9fQdp5Jej8nDNKYllbKrJbL0osjHWu7bDV7PLd0Uv0s8t+nDOK0LkPqPzG?=
 =?us-ascii?Q?x7A8PuaBa1boyfnMjJO9nloLnraIf12kYNCTu1+abiPntNiOgwRcTGyBZuih?=
 =?us-ascii?Q?sMwibHKcEgazXHGZK6krJXpgpjQblp8N74s/F6U3Z7fxppMe3x3gXdFSby0S?=
 =?us-ascii?Q?K63oCWtVksDoqm5PaCRHWbVNjnHuMNTj+MsdZqrTGxmyzA2YWp7df+T3lK34?=
 =?us-ascii?Q?SXHnStIzkccHoqUGUPbHrO3+zD+dNDuf3LFukupT13g42042c/pOBJte81DN?=
 =?us-ascii?Q?5UWX0Hay/vd8axL352iB8BepXOnAQRRfSjIoTkmL+IJf3p5UhdB11GDieOVl?=
 =?us-ascii?Q?bE6vZCtrTNy/xwTMnzyladfbiFEYwgyzViM5hlqBo/ZsCBur+oSfAiLHZaty?=
 =?us-ascii?Q?sP8jxbm/A7QPkPBMzThAGTNDcc8Axi7IEL6WW0V9DEDImwHLJqLEqMrmW2jw?=
 =?us-ascii?Q?6AhJeWJXQmg8Kxp/LspYDTqCtCXR/LodCEvO3c6ySmNj76OO/jWgM3n15HST?=
 =?us-ascii?Q?Jnz6yyPViij8hJEhhDqwn08vfV5cQMSZbVbZrjD3cwmdp9s8issxjPuVY/Up?=
 =?us-ascii?Q?tjMqVajMm73h5Np0mjkm8umRQ+pTYbA0Hqxz+D6VzDYi+l5fiO3iFwm9Ye90?=
 =?us-ascii?Q?oC8iV7Lz04zIbpgu8udaW+X/GINx/+AuFPMlkLUm/EliwYSKvtYgjzHcKkoo?=
 =?us-ascii?Q?xgPnSdn/IIP4IX8l95yULFGEF6S6fQhI4VT0ODNZ+I2VCOJ3oDwj4Hzz6mRE?=
 =?us-ascii?Q?IelKHOmwzzZVLzpGsv/DoWzNIMiqKbo0w2NkpldP/SVkyVc7HraWJKPdSO3f?=
 =?us-ascii?Q?JbIFFqGHE1ngwN2aEAD6HxHOJqG4PwJlI4vvy3EIeeZjG36ECtyAMdIldQMe?=
 =?us-ascii?Q?JAV9xbdaKEhITPkp5UUe80163gJVP2+c?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oDesi0ZhOmKHQlIwWXvNq8Mvi/fEX++GXglaCUn41pgHFM3cqpEgkehWMey9?=
 =?us-ascii?Q?HTKEoMJSBILRyUuIMH2ou21+R/bYWxv/l0b8tjRgVR1+7CyZhMrNk9EuxTcL?=
 =?us-ascii?Q?qHHfePMPfa97NAJPj8MC4/eXpT0fZTfVZwLJwbpeXSSMMpRiPiSUZIf+TayV?=
 =?us-ascii?Q?4P5MHup2iau+9rDDO6/mXCLtjh0NjGWUG+vPWfbek9rVV5KCKwDTVartkzmn?=
 =?us-ascii?Q?+VrR1rSnKMYOaXB6dkLkN7Y1u1NN15raOIFGmooAXAwGQ/7gbIdZ5YVR8vV7?=
 =?us-ascii?Q?N1RwLheaSybmyK8j3M8w6qM088bDL1zUE/MJsXFUzHuUlzVJ5j3NKlTqqYyT?=
 =?us-ascii?Q?0YEBJ6kn+xkHGWLEUoc7o6ktQGMHfKNyvYMZq0G5aj63obHO67XYj8XNK0Wo?=
 =?us-ascii?Q?n8iTQJihXIYTroSWomyMHe4ePLYIIrG0DUT71GAOmNjG6U69r5L+FihUhoFD?=
 =?us-ascii?Q?zW+NbRoZPitihapHaAGRmfLr26udI4sLQQxs9FLQJxOf1u930rggROkQeLpd?=
 =?us-ascii?Q?bWlkZAAR3f/3Akenqx7ptc7qaGN3Q47IR887qqxQzKaWN9U+Min4os5SfvGd?=
 =?us-ascii?Q?4tGpyvoLYx6PK5wgqVfjoYOVArEP40U7bkhblJZBYFX1dtnKzCvlDsGyTb7v?=
 =?us-ascii?Q?tg5LnVhw12uu20whzq5egnzAUjYB3Qe2lUzBVNWN45q/fNWdDuXeeF3ueItv?=
 =?us-ascii?Q?cggTPm4kbkni3mzjX8aoBhgA4UtuSfG4y5o6BY+2o+U0KQgaPOKaPh3+2HAB?=
 =?us-ascii?Q?E9KKwdVNALMQOVzWF+ONzkeSooQ1e6YkxTFyQZ/lMKzo/IPvkStaPwPejL0D?=
 =?us-ascii?Q?5UbQkbirruBXEO7y3LKqhOV4rMfCQlprEykQcpj1xJZ5qsH9JxZLGXNYBJIZ?=
 =?us-ascii?Q?9UlrcXs3uJ2s8Te5aPVjT87jHZk6rkELW0g1wN9rXklY81BhiqlNP91yuKfU?=
 =?us-ascii?Q?GPLHK17bfibJGr5XcwiS5kfZws0zJNXDk23ScKJ9kLTQDNr5cq6cQZMut3nG?=
 =?us-ascii?Q?39r+W6Ly8skWRtPH5pc0G+jX3rXC9/LNKl3jy+tmfoDAskqyRPFmtUeZGXqD?=
 =?us-ascii?Q?SNqBiZGhfFnm1uUYVv1DrCo2Yg85YB13612FJWYDUXrFFQ+6qC1lhrVJIK0O?=
 =?us-ascii?Q?jxy77S1ZBDa/ed4uTL2w/p5xHsdnfFarrUeSatKtFmmAUJVjFww5GG0b7yVc?=
 =?us-ascii?Q?tF+o1X3alt7y50JbORvZY4INdsxHTwL5K7NBQtoN93D+k3wLYIPrgoymGI+k?=
 =?us-ascii?Q?Udrv0GfBrtYP7fYZ4NFz3IckzpfrcB+3kjnzokH54s1fZmUOLbG2UBIv0QFu?=
 =?us-ascii?Q?8q6mCUZqq9RMiBi6gVw/sTXNwHjuZSDj8yQY6nEq1Zc01YLbgLoyynJxIFhu?=
 =?us-ascii?Q?rXEhsXjvkpyzW975V5CQyCvSRur+GAUUIQ7vzfr2zIgUzk/UBV8WNX/Nsff0?=
 =?us-ascii?Q?hQLM5OZWlz0FH3OCpbUXltdB1pNUza2XCiabPRQCzJ0SaxgizzH2ejletaNm?=
 =?us-ascii?Q?A3peTIrftj91CaK7klPuMAqvD3fXDZEkPAyApHUtPXD+c938T+s1BtC66KyK?=
 =?us-ascii?Q?8jLCxzSut8+YfYmko4I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10401199-3121-462d-5043-08dd4b8e3500
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 17:53:50.2919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8MjaxBVS+qf2rdpJo2Bp6wtjEKvC8tbV4w+0Tk22hqywZ9sQN3KTgOubHjp+RgTSFi7d5F5r3fPkpRTjJLOhXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263
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

Greetings, sending peace.

Still seeking a review on this.  These changes are simple and should not ta=
ke much of your time, so please send me a "Reviewed By:" or your comments.

@Russell, Kent, for the record Coverity in only flagging variable as Uninit=
ialized if and only if that are sent into function.  The argument here is t=
hat this variable could be dereferenced or otherwise used with a bogus valu=
e.

One love!
> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Thursday, January 16, 2025 11:36 AM
> To: Martin, Andrew <Andrew.Martin@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH v3] drm/amdkfd: Uninitialized and Unused variables
>
> [Public]
>
> Asking for some advice here.
>
> Coverity throws uninitialized errors (covered below), but at least the fi=
rst two
> (commented below) are explicitly set in the various function calls. Shoul=
d we be
> initializing them anyways, or should we only be doing that for the variab=
les where
> there's some possible flow where they can be accessed uninitialized? Than=
ks!
>
>  Kent
>
> > -----Original Message-----
> > From: Martin, Andrew <Andrew.Martin@amd.com>
> > Sent: Wednesday, January 8, 2025 1:15 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Russell, Kent <Kent.Russell@amd.com>; Martin, Andrew
> > <Andrew.Martin@amd.com>
> > Subject: [PATCH v3] drm/amdkfd: Uninitialized and Unused variables
> >
> > This patch initialized key variables and removed unused ones.
> >
> > Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
> > ---
> >  .../gpu/drm/amd/amdkfd/cik_event_interrupt.c  |  2 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 24 +++++------
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  2 +-
> >  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 42 ++++++++-----------
> >  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  8 ++--
> >  .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  1 -
> >  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 14 +++----
> >  .../amd/amdkfd/kfd_process_queue_manager.c    |  6 +--
> >  8 files changed, 43 insertions(+), 56 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> > b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> > index 795382b55e0a..9767f6483871 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> > @@ -35,7 +35,7 @@ static bool cik_event_interrupt_isr(struct kfd_node *=
dev,
> >                       (const struct cik_ih_ring_entry *)ih_ring_entry;
> >       const struct kfd2kgd_calls *f2g =3D dev->kfd2kgd;
> >       unsigned int vmid;
> > -     uint16_t pasid;
> > +     uint16_t pasid =3D 0;
>
> This one isn't needed. It's initialized in one of the
> get_atc_vmid_pasid_mapping_info calls, or below.
>
> >       bool ret;
> >
> >       /* This workaround is due to HW/FW limitation on Hawaii that
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > index 065d87841459..306ea5a8a747 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -923,7 +923,7 @@ static int kfd_ioctl_get_tile_config(struct file
> > *filep,  {
> >       struct kfd_ioctl_get_tile_config_args *args =3D data;
> >       struct kfd_process_device *pdd;
> > -     struct tile_config config;
> > +     struct tile_config config =3D {0};
>
> Same with this one, it's set in amdgpu_amdkfd_get_tile_config
>
> >       int err =3D 0;
> >
> >       mutex_lock(&p->mutex);
> > @@ -1042,7 +1042,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct
> > file *filep,  {
> >       struct kfd_ioctl_alloc_memory_of_gpu_args *args =3D data;
> >       struct kfd_process_device *pdd;
> > -     void *mem;
> > +     void *mem =3D NULL;
> >       struct kfd_node *dev;
> >       int idr_handle;
> >       long err;
> > @@ -1496,12 +1496,12 @@ static int kfd_ioctl_get_dmabuf_info(struct
> > file *filep,  {
> >       struct kfd_ioctl_get_dmabuf_info_args *args =3D data;
> >       struct kfd_node *dev =3D NULL;
> > -     struct amdgpu_device *dmabuf_adev;
> > +     struct amdgpu_device *dmabuf_adev =3D NULL;
> >       void *metadata_buffer =3D NULL;
> > -     uint32_t flags;
> > -     int8_t xcp_id;
> > +     uint32_t flags =3D 0;
> > +     int8_t xcp_id =3D 0;
> >       unsigned int i;
> > -     int r;
> > +     int r =3D 0;
> >
> >       /* Find a KFD GPU device that supports the get_dmabuf_info query =
*/
> >       for (i =3D 0; kfd_topology_enum_kfd_devices(i, &dev) =3D=3D 0; i+=
+) @@
> > -1551,7 +1551,7 @@ static int kfd_ioctl_import_dmabuf(struct file *file=
p,
> >       struct kfd_process_device *pdd;
> >       int idr_handle;
> >       uint64_t size;
> > -     void *mem;
> > +     void *mem =3D NULL;
> >       int r;
> >
> >       mutex_lock(&p->mutex);
> > @@ -1837,10 +1837,8 @@ static int criu_get_prime_handle(struct kgd_mem
> *mem,
> >                                int flags, u32 *shared_fd,
> >                                struct file **file)  {
> > -     struct dma_buf *dmabuf;
> > -     int ret;
> > -
> > -     ret =3D amdgpu_amdkfd_gpuvm_export_dmabuf(mem, &dmabuf);
> > +     struct dma_buf *dmabuf =3D NULL;
> > +     int ret =3D amdgpu_amdkfd_gpuvm_export_dmabuf(mem, &dmabuf);
> >       if (ret) {
> >               pr_err("dmabuf export failed for the BO\n");
> >               return ret;
> > @@ -2291,7 +2289,7 @@ static int criu_restore_memory_of_gpu(struct
> > kfd_process_device *pdd,
> >       int idr_handle;
> >       int ret;
> >       const bool criu_resume =3D true;
> > -     u64 offset;
> > +     u64 offset =3D 0;
> >
> >       if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) {
> >               if (bo_bucket->size !=3D
> > @@ -2358,7 +2356,7 @@ static int criu_restore_bo(struct kfd_process *p,
> >                          struct file **file)  {
> >       struct kfd_process_device *pdd;
> > -     struct kgd_mem *kgd_mem;
> > +     struct kgd_mem *kgd_mem =3D NULL;
> >       int ret;
> >       int j;
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > index a29374c86405..5af5b9baa894 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > @@ -1038,7 +1038,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool
> > run_pm)
> >
> >  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)  {
> > -     int ret, i;
> > +     int ret =3D 0, i;
> >
> >       if (!kfd->init_complete)
> >               return 0;
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > index 1405e8affd48..d4a346ac1167 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > @@ -199,7 +199,7 @@ static int add_queue_mes(struct
> device_queue_manager
> > *dqm, struct queue *q,
> >       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->=
adev;
> >       struct kfd_process_device *pdd =3D qpd_to_pdd(qpd);
> >       struct mes_add_queue_input queue_input;
> > -     int r, queue_type;
> > +     int r =3D 0, queue_type;
> >       uint64_t wptr_addr_off;
> >
> >       if (!dqm->sched_running || dqm->sched_halt)
> > @@ -284,7 +284,7 @@ static int remove_queue_mes(struct
> > device_queue_manager *dqm, struct queue *q,
> >                       struct qcm_process_device *qpd)
> >  {
> >       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->=
adev;
> > -     int r;
> > +     int r =3D 0;
> >       struct mes_remove_queue_input queue_input;
> >
> >       if (!dqm->sched_running || dqm->sched_halt)
> > @@ -634,7 +634,7 @@ static int create_queue_nocpsch(struct
> > device_queue_manager *dqm,
> >                               const void *restore_mqd, const void
> > *restore_ctl_stack)
> >  {
> >       struct mqd_manager *mqd_mgr;
> > -     int retval;
> > +     int retval =3D 0;
> >
> >       dqm_lock(dqm);
> >
> > @@ -795,7 +795,7 @@ static int dbgdev_wave_reset_wavefronts(struct
> kfd_node
> > *dev, struct kfd_process
> >  {
> >       int status =3D 0;
> >       unsigned int vmid;
> > -     uint16_t queried_pasid;
> > +     uint16_t queried_pasid =3D 0;
> >       union SQ_CMD_BITS reg_sq_cmd;
> >       union GRBM_GFX_INDEX_BITS reg_gfx_index;
> >       struct kfd_process_device *pdd;
> > @@ -862,11 +862,9 @@ static int destroy_queue_nocpsch_locked(struct
> > device_queue_manager *dqm,
> >                               struct qcm_process_device *qpd,
> >                               struct queue *q)
> >  {
> > -     int retval;
> > -     struct mqd_manager *mqd_mgr;
> > -
> > -     mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
> > -                     q->properties.type)];
> > +     int retval =3D 0;
> > +     struct mqd_manager *mqd_mgr =3D
> > +       dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)]=
;
> >
> >       if (q->properties.type =3D=3D KFD_QUEUE_TYPE_COMPUTE)
> >               deallocate_hqd(dqm, q);
> > @@ -921,7 +919,7 @@ static int destroy_queue_nocpsch(struct
> > device_queue_manager *dqm,
> >                               struct qcm_process_device *qpd,
> >                               struct queue *q)
> >  {
> > -     int retval;
> > +     int retval =3D 0;
> >       uint64_t sdma_val =3D 0;
> >       struct device *dev =3D dqm->dev->adev->dev;
> >       struct kfd_process_device *pdd =3D qpd_to_pdd(qpd);
> > @@ -1150,7 +1148,7 @@ static int evict_process_queues_nocpsch(struct
> > device_queue_manager *dqm,
> >       struct queue *q;
> >       struct mqd_manager *mqd_mgr;
> >       struct kfd_process_device *pdd;
> > -     int retval, ret =3D 0;
> > +     int retval =3D 0, ret =3D 0;
> >
> >       dqm_lock(dqm);
> >       if (qpd->evicted++ > 0) /* already evicted, do nothing */
> > @@ -1260,7 +1258,7 @@ static int restore_process_queues_nocpsch(struct
> > device_queue_manager *dqm,
> >       struct kfd_process_device *pdd;
> >       uint64_t pd_base;
> >       uint64_t eviction_duration;
> > -     int retval, ret =3D 0;
> > +     int retval =3D 0, ret =3D 0;
> >
> >       pdd =3D qpd_to_pdd(qpd);
> >       /* Retrieve PD base */
> > @@ -1437,13 +1435,12 @@ static int register_process(struct
> > device_queue_manager *dqm,
> >  static int unregister_process(struct device_queue_manager *dqm,
> >                                       struct qcm_process_device *qpd)
> >  {
> > -     int retval;
> > +     int retval =3D 0;
> >       struct device_process_node *cur, *next;
> >
> >       pr_debug("qpd->queues_list is %s\n",
> >                       list_empty(&qpd->queues_list) ? "empty" : "not em=
pty");
> >
> > -     retval =3D 0;
> >       dqm_lock(dqm);
> >
> >       list_for_each_entry_safe(cur, next, &dqm->queues, list) {
> > @@ -1473,7 +1470,7 @@ set_pasid_vmid_mapping(struct
> device_queue_manager
> > *dqm, u32 pasid,
> >                       unsigned int vmid)
> >  {
> >       uint32_t xcc_mask =3D dqm->dev->xcc_mask;
> > -     int xcc_id, ret;
> > +     int xcc_id, ret =3D 0;
> >
> >       for_each_inst(xcc_id, xcc_mask) {
> >               ret =3D dqm->dev->kfd2kgd->set_pasid_vmid_mapping(
> > @@ -1827,8 +1824,6 @@ static int start_cpsch(struct device_queue_manage=
r
> > *dqm)
> >       struct device *dev =3D dqm->dev->adev->dev;
> >       int retval, num_hw_queue_slots;
> >
> > -     retval =3D 0;
> > -
> >       dqm_lock(dqm);
> >
> >       if (!dqm->dev->kfd->shared_resources.enable_mes) {
> > @@ -1988,7 +1983,7 @@ static int create_queue_cpsch(struct
> > device_queue_manager *dqm, struct queue *q,
> >                       const struct kfd_criu_queue_priv_data *qd,
> >                       const void *restore_mqd, const void *restore_ctl_=
stack)
> >  {
> > -     int retval;
> > +     int retval =3D 0;
> >       struct mqd_manager *mqd_mgr;
> >
> >       if (dqm->total_queue_count >=3D max_num_of_queues_per_device) {
> > @@ -2282,8 +2277,8 @@ static int unmap_queues_cpsch(struct
> > device_queue_manager *dqm,
> >                               bool reset)
> >  {
> >       struct device *dev =3D dqm->dev->adev->dev;
> > -     struct mqd_manager *mqd_mgr;
> > -     int retval;
> > +     struct mqd_manager *mqd_mgr =3D NULL;
> > +     int retval =3D 0;
> >
> >       if (!dqm->sched_running)
> >               return 0;
> > @@ -2705,7 +2700,7 @@ static int checkpoint_mqd(struct
> device_queue_manager
> > *dqm,
> >  static int process_termination_cpsch(struct device_queue_manager *dqm,
> >               struct qcm_process_device *qpd)
> >  {
> > -     int retval;
> > +     int retval =3D 0;
> >       struct queue *q;
> >       struct device *dev =3D dqm->dev->adev->dev;
> >       struct kernel_queue *kq, *kq_next;
> > @@ -2715,8 +2710,6 @@ static int process_termination_cpsch(struct
> > device_queue_manager *dqm,
> >               KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES;
> >       bool found =3D false;
> >
> > -     retval =3D 0;
> > -
> >       dqm_lock(dqm);
> >
> >       /* Clean all kernel queues */
> > @@ -3439,7 +3432,6 @@ int suspend_queues(struct kfd_process *p,
> >                                       else
> >                                               per_device_suspended++;
> >                               } else if (err !=3D -EBUSY) {
> > -                                     r =3D err;
> >                                       queue_ids[q_idx] |=3D
> > KFD_DBG_QUEUE_ERROR_MASK;
> >                                       break;
> >                               }
> > @@ -3647,7 +3639,7 @@ int dqm_debugfs_hqds(struct seq_file *m, void
> *data)
> >  {
> >       struct device_queue_manager *dqm =3D data;
> >       uint32_t xcc_mask =3D dqm->dev->xcc_mask;
> > -     uint32_t (*dump)[2], n_regs;
> > +     uint32_t (*dump)[2] =3D {}, n_regs =3D 0;
> >       int pipe, queue;
> >       int r =3D 0, xcc_id;
> >       uint32_t sdma_engine_start;
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> > index ff417d5361c4..55fc98358999 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> > @@ -571,7 +571,7 @@ static int hiq_load_mqd_kiq_v9_4_3(struct
> mqd_manager
> > *mm, void *mqd,
> >                       struct queue_properties *p, struct mm_struct *mms=
)
> >  {
> >       uint32_t xcc_mask =3D mm->dev->xcc_mask;
> > -     int xcc_id, err, inst =3D 0;
> > +     int xcc_id, err =3D 0, inst =3D 0;
> >       void *xcc_mqd;
> >       uint64_t hiq_mqd_size =3D kfd_hiq_mqd_stride(mm->dev);
> >
> > @@ -595,7 +595,7 @@ static int destroy_hiq_mqd_v9_4_3(struct
> mqd_manager
> > *mm, void *mqd,
> >                       uint32_t pipe_id, uint32_t queue_id)
> >  {
> >       uint32_t xcc_mask =3D mm->dev->xcc_mask;
> > -     int xcc_id, err, inst =3D 0;
> > +     int xcc_id, err =3D 0, inst =3D 0;
> >       uint64_t hiq_mqd_size =3D kfd_hiq_mqd_stride(mm->dev);
> >       struct v9_mqd *m;
> >       u32 doorbell_off;
> > @@ -751,7 +751,7 @@ static int destroy_mqd_v9_4_3(struct mqd_manager
> *mm,
> > void *mqd,
> >                  uint32_t pipe_id, uint32_t queue_id)
> >  {
> >       uint32_t xcc_mask =3D mm->dev->xcc_mask;
> > -     int xcc_id, err, inst =3D 0;
> > +     int xcc_id, err =3D 0, inst =3D 0;
> >       void *xcc_mqd;
> >       struct v9_mqd *m;
> >       uint64_t mqd_offset;
> > @@ -781,7 +781,7 @@ static int load_mqd_v9_4_3(struct mqd_manager
> *mm, void
> > *mqd,
> >       /* AQL write pointer counts in 64B packets, PM4/CP counts in dwor=
ds. */
> >       uint32_t wptr_shift =3D (p->format =3D=3D KFD_QUEUE_FORMAT_AQL ? =
4 : 0);
> >       uint32_t xcc_mask =3D mm->dev->xcc_mask;
> > -     int xcc_id, err, inst =3D 0;
> > +     int xcc_id, err =3D 0, inst =3D 0;
> >       void *xcc_mqd;
> >       uint64_t mqd_stride_size =3D mm->mqd_stride(mm, p);
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> > index c1199d06d131..cf803aed5069 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> > @@ -173,7 +173,6 @@ static int pm_map_queues_vi(struct packet_manager
> *pm,
> > uint32_t *buffer,
> >       case KFD_QUEUE_TYPE_SDMA_XGMI:
> >               packet->bitfields2.engine_sel =3D q->properties.sdma_engi=
ne_id +
> >                               engine_sel__mes_map_queues__sdma0_vi;
> > -             use_static =3D false; /* no static queues under SDMA */
> >               break;
> >       default:
> >               WARN(1, "queue type %d", q->properties.type);
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > index 083f83c94531..a6188c06c7a1 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > @@ -272,7 +272,7 @@ static int kfd_get_cu_occupancy(struct attribute *a=
ttr,
> char
> > *buffer)
> >       struct kfd_process_device *pdd =3D NULL;
> >       int i;
> >       struct kfd_cu_occupancy *cu_occupancy;
> > -     u32 queue_format;
> > +     u32 queue_format =3D 0;
> >
> >       pdd =3D container_of(attr, struct kfd_process_device, attr_cu_occ=
upancy);
> >       dev =3D pdd->dev;
> > @@ -743,9 +743,7 @@ static int kfd_process_alloc_gpuvm(struct
> > kfd_process_device *pdd,
> >                                  uint32_t flags, struct kgd_mem **mem, =
void **kptr)
> >  {
> >       struct kfd_node *kdev =3D pdd->dev;
> > -     int err;
> > -
> > -     err =3D amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(kdev->adev, gpu_v=
a,
> > size,
> > +     int err =3D amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(kdev->adev,
> > gpu_va, size,
> >                                                pdd->drm_priv, mem, NULL=
,
> >                                                flags, false);
> >       if (err)
> > @@ -798,8 +796,8 @@ static int kfd_process_device_reserve_ib_mem(struct
> > kfd_process_device *pdd)
> >                       KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE |
> >                       KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE |
> >                       KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
> > -     struct kgd_mem *mem;
> > -     void *kaddr;
> > +     struct kgd_mem *mem =3D NULL;
> > +     void *kaddr =3D NULL;
> >       int ret;
> >
> >       if (qpd->ib_kaddr || !qpd->ib_base)
> > @@ -1369,8 +1367,8 @@ static int kfd_process_device_init_cwsr_dgpu(stru=
ct
> > kfd_process_device *pdd)
> >       uint32_t flags =3D KFD_IOC_ALLOC_MEM_FLAGS_GTT
> >                       | KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
> >                       | KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
> > -     struct kgd_mem *mem;
> > -     void *kaddr;
> > +     struct kgd_mem *mem =3D NULL;
> > +     void *kaddr =3D NULL;
> >       int ret;
> >
> >       if (!dev->kfd->cwsr_enabled || qpd->cwsr_kaddr || !qpd->cwsr_base=
)
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > index 9df56f8e09f9..06fbb107f303 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > @@ -769,7 +769,7 @@ int kfd_process_get_queue_info(struct kfd_process *=
p,
> >                       if (q->properties.type =3D=3D KFD_QUEUE_TYPE_COMP=
UTE ||
> >                               q->properties.type =3D=3D KFD_QUEUE_TYPE_=
SDMA ||
> >                               q->properties.type =3D=3D
> > KFD_QUEUE_TYPE_SDMA_XGMI) {
> > -                             uint32_t mqd_size, ctl_stack_size;
> > +                             uint32_t mqd_size =3D 0, ctl_stack_size =
=3D 0;
> >
> >                               *num_queues =3D *num_queues + 1;
> >
> > @@ -872,8 +872,8 @@ static int criu_checkpoint_queues_device(struct
> > kfd_process_device *pdd,
> >       list_for_each_entry(q, &pdd->qpd.queues_list, list) {
> >               struct kfd_criu_queue_priv_data *q_data;
> >               uint64_t q_data_size;
> > -             uint32_t mqd_size;
> > -             uint32_t ctl_stack_size;
> > +             uint32_t mqd_size =3D 0;
> > +             uint32_t ctl_stack_size =3D 0;
> >
> >               if (q->properties.type !=3D KFD_QUEUE_TYPE_COMPUTE &&
> >                       q->properties.type !=3D KFD_QUEUE_TYPE_SDMA &&
> > --
> > 2.43.0
>

