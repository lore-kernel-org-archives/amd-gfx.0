Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B19E77188
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2024 19:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70AA110E37B;
	Mon, 30 Dec 2024 19:09:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q7zfhMJq";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E342210E37B
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2024 19:09:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJot9cMsuL1yoyJKG8NWTM4HRAN2DaX0jbe03Ltv4gFsbpSr5bfc/nr/brv/IqHCgkgsLqqj9cp9PEfpm/j86mh8Ti5IblJCnl4bQ/+yeTT13g2PNc7YMRGu7X40KGH0IpltDrrDrhVCwjKunkRKPGzgKUpKjXYYaLe1ipOItShsa4mCBvACj4+D9bfIUqtkKb2eywioU+WnhPFX6luvMwTNIFgyTr+EeDMe3dPPFMBbD6aDCCfOYxt4I4h4REk0930HzxE638VXAUgJKLJmOZ7EN6arCbFFjHyNY4yU66rvfPPm0PX+xv29y75+spOv4ceXVnIYdnwX3hF2jZOCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORaYENBp7i/9r7yiULwv8KsE+a2VKVccjwxs0Uw8v4I=;
 b=mjR5xIxBgZmun1/MV3S/SPTGciNeehHzpPR9FJJb+6P1pZnvfHGqJef2AwG5gSB0LweLdl/MtrdDMj0l9y50B/lMbO+dHDGWwixCqL3y1lnOIYDYShHQPWY+ZnSJkVkAGuxZzkcNUsuHd8PJp0fvmi1SGzYpwKgrQUbUEy0GwhVDngf5m2jMn56MkRkXlHOuqXRP8Wjm8bW8JArQGqoTMunXhOIwXdKQfn9h/H8B7sG7eNeWPaQaU5aRjZPBWsG5g97xJf7QLeJHNPS6oOYF6BV5PAv/yZH82uJJRzCC6FNj90iaVuKzFqwS8gFix3SF05Es9Gi3wCpHz273mIFOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORaYENBp7i/9r7yiULwv8KsE+a2VKVccjwxs0Uw8v4I=;
 b=Q7zfhMJqqypE9M8f1I4TBHBLRJASTczCCpxFV3MoMs6dXiBPXjFgLKKqs4lm2RkkcZDvZHBOpqZYJtXewUSdW8hpwYbS/at1sy2Ps8STj+nZA5Raw/CVW7QKdNMsEetf3eCurSLE4SRw5Fk+98Pknvo5qmje4U+iVNo8+g5QRdE=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by SA3PR12MB9200.namprd12.prod.outlook.com (2603:10b6:806:39c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 19:09:31 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::b62f:95b3:3fa5:d345]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::b62f:95b3:3fa5:d345%4]) with mapi id 15.20.8293.000; Mon, 30 Dec 2024
 19:09:31 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Ignored various return code
Thread-Topic: [PATCH v2] drm/amdkfd: Ignored various return code
Thread-Index: AQHbWtzVwZL9Z8SLhUG/oG7mXIfKgrL/DyMAgAACV4CAAAxygIAACJ+A
Date: Mon, 30 Dec 2024 19:09:31 +0000
Message-ID: <SJ0PR12MB8138722885AD1BB9C0BEE7E8F5092@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20241230170223.574547-1-Andrew.Martin@amd.com>
 <BL1PR12MB5898B926B9A6FFF7D66E306285092@BL1PR12MB5898.namprd12.prod.outlook.com>
 <SJ0PR12MB8138C3B22C551491933825A2F5092@SJ0PR12MB8138.namprd12.prod.outlook.com>
 <BL1PR12MB5898C219584BBCB336BD214E85092@BL1PR12MB5898.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5898C219584BBCB336BD214E85092@BL1PR12MB5898.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Kent.Russell@amd.com
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
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|SA3PR12MB9200:EE_
x-ms-office365-filtering-correlation-id: e1f1e95a-37b3-4a8c-b085-08dd29057d8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?2vuVLMgljL2GE8+tSKP4YzvGBK/A/wysv1xYdM/vAC1zoJ/PydeWYCdW7yw4?=
 =?us-ascii?Q?Ozr72Ue7xoZysWC2YUDU/3rwT4IDBTmdsa4jK2moGfRgyt31TJixf1giEp87?=
 =?us-ascii?Q?VoUNJQ842SLB04RBRRyH2iAwaCC590rohqOvpJpfo2HFqxWuOudxDwMGG3EY?=
 =?us-ascii?Q?MttJGAkMCvHYuUD0XV0FnJDaqDrDgC16CHwvUkdLGDfAnIgnkRSK+QqH2YCR?=
 =?us-ascii?Q?itIJWhViteFi1+JYlbW8kKBLUcdTZLXYP5XJgIE6DB39alypj0Jg8P+1vhh6?=
 =?us-ascii?Q?djOkC71pjMHkeng3B0Ncv+XNDbwynNE1HHXWyRU/TG5YvnBDOSLw/314BELG?=
 =?us-ascii?Q?Xh0rC9f2soQrMxDIGdjhQk/Lyd9RPvFaHJBJXi/Xn1zLzA6Q6ivRqTm44vut?=
 =?us-ascii?Q?K01NsY1JE24/gFha0n2Kd9Ueq1RnnffjrzBT8pHB7WnJogGVGvBuu9Dcg+EC?=
 =?us-ascii?Q?a0chFdTK9Mc9H7Hpv93Di6YJUEHGDD4gX25DCeAhz2OlFgPBktUzbAjj/uN4?=
 =?us-ascii?Q?+FfkmSbABWmpTzDZd/S0EaF81iiaCVCPsVS2/n3uAsQZIYGij2ngwdnhGcly?=
 =?us-ascii?Q?sF7Hdb87/rXLjCvZqrOuxyoa/TiEbThVRUw490QdyYzt/IEYIMeSmRmj/G/8?=
 =?us-ascii?Q?FNAMwyP457OKP8h1F7KazAefaknbnzeXP90jYcLY9DMZcHukVmf4XZhW8J3n?=
 =?us-ascii?Q?UB2LV01mHlyZdcVvSFEnyqdOUXE9YgvWG1Fa8f4gf8RluO/xwi6O7Xiv2+Ib?=
 =?us-ascii?Q?sxLqoZw0A1Z5JxG7E98DcByFkwFfWDNMq8RsCeCdvzh1uIeQCrdBMzF7WxLl?=
 =?us-ascii?Q?R1cfgHiCB29G1gW9nPWkYJGRCJSB/vSgIKPh/rcGKitUvsIpcLDB856JdUQW?=
 =?us-ascii?Q?+KhNk6+LnGEbBfhJj/joCT6iyvbaGHg5G4cqh0uM3kh5v1onqi53jjIK+5Zi?=
 =?us-ascii?Q?nIXr/fpac9GXrG/LUenTnX69dQp4awqQeHYj9L9dck9gn1a2xZ5G7ASt+p4M?=
 =?us-ascii?Q?ykzfaaCJZ+/6HEvHXbZjj76Z3e9DOFlhDAnZbX5sl2eu56h3VavvRMPNYz4B?=
 =?us-ascii?Q?Qd9Qys8tF2pMjed69Y+dcpeBYX1bBe5FvljGuUuuq4v8Pi2+dj+ZnjG7Jq7I?=
 =?us-ascii?Q?+l+HsWcb2798Zn+A4zMa7fdAQ4A127VIbnetv4rW62Q2fOS/9OIw+mCkXu9+?=
 =?us-ascii?Q?J2MpD0W16I/y8HsSpoxrykztN/L870pksOC3IV2PtQ8D0hxhUVFGEx2U8HMY?=
 =?us-ascii?Q?gc463YDZxGvvhdfEeMKdoMH6ymyn07xsYM2VmbWfL482y04N6nVKMLUqCfGq?=
 =?us-ascii?Q?pu0/HBFkPaW5mDJ8EfT4aqUs8lrGg/XNI+mwiV0+zEwQUoKjj0hJvMiOQrbH?=
 =?us-ascii?Q?q8qxtRAju550bMU+nUp2eA5bYncearNKzfbULUP5fxM22/AP0hF/czfMECe9?=
 =?us-ascii?Q?nUhit8/aXobpFc5zrvkYpRKrLCW4utRa?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AXRC5gOyCpyT+sZ4LUmLsQ5CmiDcE4s3qQxBRwidEjMVjCH/edv5rnl5iGex?=
 =?us-ascii?Q?UNhqnWPWYte27BakATLvWLzNirSohuKrYDyzlbma+v54cTzDTlYqjN5w2zQj?=
 =?us-ascii?Q?Iyk6d0bJwatQoUc7e61HI4MirjqawdbWq15yoVT/UUM1aEuz8wNMdpeRMHPe?=
 =?us-ascii?Q?3GuhKwtYB14iByeAoy6w65lOA2wg+hsprXwjOR5pAGVdYoNI+weFCxlBphE2?=
 =?us-ascii?Q?DxDrik47DzC6el8urG7fc9GBHl0zM1SkTAq6VwxCduDVVoAeZnrYaCqZlvT8?=
 =?us-ascii?Q?2JYDo+7qxZWD2PO4keOh8BMPS1+4z125WHc5Br0FpFSU+FAZznnluyrAYNwC?=
 =?us-ascii?Q?IyLNbGF3vDhoQKS4VInH5emQvXC5E6d2UJphpseK9zM0F544b9oCmXENXf1m?=
 =?us-ascii?Q?9UCkt2ItxqtitPM7dROF8hzwbZItbcvtf94r4E1NoWJwexffrF/DGwx/2y01?=
 =?us-ascii?Q?zHEvIZ0cmzt0U5SbUO/4W0DxykMOgf0VMHipynHFmEwOoGKIzgyKlbUuozFE?=
 =?us-ascii?Q?LWla9PWMPs5ZF77D46TY+FlO3CB77ZgA+Uzr8Tm2EIjyDGPa8KTNQXNdpLOU?=
 =?us-ascii?Q?0BaXXOFUjabfWFCbCHxqVxXdu1LdR7nsLXaXcnQLY6Aaadup8ysKo4Vm1FpF?=
 =?us-ascii?Q?2ZnPNt3XLRExHRSLhFQQB/NH3uiET6soRt/wuvnd5xxR6WhEFmXo098szQ0x?=
 =?us-ascii?Q?Iha+xHgAF9W+CNDUvhY8DXcTngxW92PivFZLYip6fddWCtejLfvS4C3CHfvO?=
 =?us-ascii?Q?dUlCsWo9rV24h44bfJIfs7f1QmqA7eHrLjeEiq1ieCrDy07GfYcBf0h3eX/W?=
 =?us-ascii?Q?bebBmHFAbjbYbTDmM5oW0WZS/T6W7isI+HIEyEm2ebZ492mq/I+NHlVPKuzq?=
 =?us-ascii?Q?IJpIsFaf400XmNBslEUj/8SeI7U5VHYVDkduzhjn0u1SyDwJi5n9trk5spWr?=
 =?us-ascii?Q?yuEBm0BL+4B34xKpo81OnGbeOaiBIs9FnaQ+UPDLVfEN6Ask7BgtEdBBfDh0?=
 =?us-ascii?Q?MXx67ZYtypktmJrePtbnxMQAvZqwlTyqeuw7mq3GTwqaMSEG4yjgrkadGYWA?=
 =?us-ascii?Q?G7xFpkN8u5gWoPjqgPVkIzM5LmAs9V+p+u5tdZ+yJiB8wbMkHNuSxm0KRJmx?=
 =?us-ascii?Q?5FCmnVb7wawj5YwP6O9qpAdxtEfyc6cGUaGxUJaGGm1rIDSEf108UP+/wPHV?=
 =?us-ascii?Q?+V/8oUqV7bVfn6JQ5whHPivstf2PHajJmKwcl0NIQ3R8pzaUCUYS+VppU6ph?=
 =?us-ascii?Q?qF3fIGNVS7OKIFNGEITOtsx8I7fAi3pIvhQWzhrakHHFBZjWBlsS6CkFXDa8?=
 =?us-ascii?Q?C5372V8QjTaqXlpFgx7A1owucVGQ2NcKTLhbFzUQLNswYQS2XPQx05O1H9CD?=
 =?us-ascii?Q?VC9E6Nsf+lXjsQh3AGOperxPeys0Bfu85HahjCmFkfirbkfWY9frW7GPGu5a?=
 =?us-ascii?Q?xXBs8gQQJBq3CBN+Nm4hqSGkt7xavZB9wrbv+kFEyDmZ2o+Rv4nZ6P5cLQZV?=
 =?us-ascii?Q?71XTITuwpoZ2f2fBf+opad0EvK5ikkCTOFLzgNpOyaZd4otzwd7a1KCNpUGt?=
 =?us-ascii?Q?oU9HAveGEPueqUEFrfo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f1e95a-37b3-4a8c-b085-08dd29057d8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2024 19:09:31.4230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BHPyBrPOUir3ObHYat7YEN8npdm7iiopCcNrZYR2TcVoHPYxMbIXkv/CrYADsP42tw38Smfg9E55OLCjIwn4IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9200
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

@Russell, Kent

Thanks, I will send out the next version soon!

> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Monday, December 30, 2024 1:37 PM
> To: Martin, Andrew <Andrew.Martin@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: RE: [PATCH v2] drm/amdkfd: Ignored various return code
>
> [Public]
>
> > -----Original Message-----
> > From: Martin, Andrew <Andrew.Martin@amd.com>
> > Sent: Monday, December 30, 2024 1:15 PM
> > To: Russell, Kent <Kent.Russell@amd.com>;
> > amd-gfx@lists.freedesktop.org
> > Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
> > Subject: RE: [PATCH v2] drm/amdkfd: Ignored various return code
> >
> > [Public]
> >
> > > -----Original Message-----
> > > From: Russell, Kent <Kent.Russell@amd.com>
> > > Sent: Monday, December 30, 2024 12:44 PM
> > > To: Martin, Andrew <Andrew.Martin@amd.com>; amd-
> > > gfx@lists.freedesktop.org
> > > Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Martin, Andrew
> > > <Andrew.Martin@amd.com>
> > > Subject: RE: [PATCH v2] drm/amdkfd: Ignored various return code
> > >
> > > [Public]
> > >
> > > Might be worth changing the commit headline to what the patch does,
> > > something like Don't ignore return codes Or Various return code
> > > cleanup
> > >
> > > Otherwise it sounds like your patch is intentionally ignoring return
> > > codes, which is the opposite of what you're doing. Also 2 comments
> below.
> >
> > Thanks, will do!, Please see response to your 2 comments also!
> >
> > >
> > > > -----Original Message-----
> > > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > > Andrew Martin
> > > > Sent: Monday, December 30, 2024 12:02 PM
> > > > To: amd-gfx@lists.freedesktop.org
> > > > Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Russell, Kent
> > > > <Kent.Russell@amd.com>; Martin, Andrew
> <Andrew.Martin@amd.com>
> > > > Subject: [PATCH v2] drm/amdkfd: Ignored various return code
> > > >
> > > > This patch checks and handles the return code of the called functio=
n.
> > > >
> > > > Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
> > > >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 ++
> > > >  drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 19 ++++++++++++++-=
--
> --
> > > >  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 11 ++++++-----
> > > >  4 files changed, 23 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > > > b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > > > index 065d87841459..52a11dc01422 100644
> > > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > > > @@ -2864,7 +2864,7 @@ static int runtime_disable(struct
> > > > kfd_process *p)
> > > >
> > > > pdd->dev->vm_info.last_vmid_kfd);
> > > >
> > > >                       if (!pdd->dev->kfd->shared_resources.enable_m=
es)
> > > > -                             debug_refresh_runlist(pdd->dev->dqm);
> > > > +
> > > > + (void)debug_refresh_runlist(pdd->dev->dqm);
> > > >                       else
> > > >                               kfd_dbg_set_mes_debug_mode(pdd,
> > > >
> > > > !kfd_dbg_has_cwsr_workaround(pdd->dev));
> > > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > > > b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > > > index 693469c18c60..f335ed9e0b3a 100644
> > > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > > > @@ -2351,6 +2351,8 @@ static int kfd_create_vcrat_image_gpu(void
> > > *pcrat_image,
> > > >       if (kdev->kfd->hive_id) {
> > > >               for (nid =3D 0; nid < proximity_domain; ++nid) {
> > > >                       peer_dev =3D
> > > > kfd_topology_device_by_proximity_domain_no_lock(nid);
> > > > +                     if (!peer_dev)
> > > > +                             return -ENODEV;
> > > >                       if (!peer_dev->gpu)
> > > >                               continue;
> > > >                       if (peer_dev->gpu->kfd->hive_id !=3D
> > > > kdev->kfd->hive_id) diff --git
> > > > a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > > > b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > > > index a8abc3091801..b4db409d90a1 100644
> > > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > > > @@ -518,6 +518,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process
> > > > *target, uint32_t *flags)
> > > >       for (i =3D 0; i < target->n_pdds; i++) {
> > > >               struct kfd_topology_device *topo_dev =3D
> > > >
> > > > kfd_topology_device_by_id(target->pdds[i]->dev->id);
> > > > +             if (!topo_dev)
> > > > +                     return -EINVAL;
> > > > +
> > > >               uint32_t caps =3D topo_dev->node_props.capability;
> > > >
> > > >               if (!(caps &
> > > >
> > HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED)
> > > > &&
> > > > @@ -565,9 +568,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process
> > > > *target, uint32_t *flags)
> > > >                               continue;
> > > >
> > > >                       if (!pdd->dev->kfd->shared_resources.enable_m=
es)
> > > > -                             debug_refresh_runlist(pdd->dev->dqm);
> > > > +
> > > > + (void)debug_refresh_runlist(pdd->dev->dqm);
> > > >                       else
> > > > -                             kfd_dbg_set_mes_debug_mode(pdd, true)=
;
> > > > +
> > > > + (void)kfd_dbg_set_mes_debug_mode(pdd,
> > > > + true);
> > > >               }
> > > >       }
> > > >
> > > > @@ -584,8 +587,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process
> > > > *target, uint32_t *flags)
> > > >   */
> > > >  void kfd_dbg_trap_deactivate(struct kfd_process *target, bool
> > > > unwind, int
> > > > unwind_count)
> > > >  {
> > > > -     int i;
> > > >
> > > > +     int i, r =3D 0;
> > > >       if (!unwind) {
> > > >               uint32_t flags =3D 0;
> > > >               int resume_count =3D resume_queues(target, 0, NULL);
> > > > @@
> > > > -627,9 +630,11 @@ void kfd_dbg_trap_deactivate(struct kfd_process
> > > > *target, bool unwind, int unwind
> > > >                       pr_err("Failed to release debug vmid on
> > > > [%i]\n",
> > > > pdd->dev-
> > > > >id);
> > > >
> > > >               if (!pdd->dev->kfd->shared_resources.enable_mes)
> > > > -                     debug_refresh_runlist(pdd->dev->dqm);
> > > > +                     r =3D debug_refresh_runlist(pdd->dev->dqm);
> > > >               else
> > > > -                     kfd_dbg_set_mes_debug_mode(pdd,
> > > > !kfd_dbg_has_cwsr_workaround(pdd->dev));
> > > > +                     r =3D kfd_dbg_set_mes_debug_mode(pdd,
> > > > !kfd_dbg_has_cwsr_workaround(pdd->dev));
> > > > +             if (r)
> > > > +                     break;
> > > >       }
> > > >
> > > >       kfd_dbg_set_workaround(target, false); @@ -1071,6 +1076,10
> > > > @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
> > > >       for (i =3D 0; i < tmp_num_devices; i++) {
> > > >               struct kfd_process_device *pdd =3D target->pdds[i];
> > > >               struct kfd_topology_device *topo_dev =3D
> > > > kfd_topology_device_by_id(pdd->dev->id);
> > > > +             if (!topo_dev) {
> > > > +                     r =3D EINVAL;
> > > > +                     break;
> > > > +             }
> > > >
> > > >               device_info.gpu_id =3D pdd->dev->id;
> > > >               device_info.exception_status =3D
> > > > pdd->exception_status; diff --git
> > > > a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > > > b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > > > index 1405e8affd48..250aa43a39c8 100644
> > > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > > > @@ -1907,16 +1907,18 @@ static int start_cpsch(struct
> > > > device_queue_manager
> > > > *dqm)
> > > >
> > > >  static int stop_cpsch(struct device_queue_manager *dqm)  {
> > > > +     int ret =3D 0;
> > > >       dqm_lock(dqm);
> > > >       if (!dqm->sched_running) {
> > > >               dqm_unlock(dqm);
> > > > -             return 0;
> > > > +             return ret;
> >
> > I can agree with this one, since it minimizes the changes, but it does =
flow
> the same.
> >
> > >
> > > I think it's cleaner to just leave the "return 0" . e.g. If the code
> > > gets refactored and new stuff gets added above, then this might flow
> differently.
> > >
> > >
> > > >       }
> > > >
> > > >       if (!dqm->dev->kfd->shared_resources.enable_mes)
> > > > -             unmap_queues_cpsch(dqm,
> > > > KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
> > > USE_DEFAULT_GRACE_PERIOD,
> > > > false);
> > > > +             ret =3D unmap_queues_cpsch(dqm,
> > > > KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES,
> > > > +                                      0,
> > > > + USE_DEFAULT_GRACE_PERIOD, false);
> > > >       else
> > > > -             remove_all_kfd_queues_mes(dqm);
> > > > +             ret =3D remove_all_kfd_queues_mes(dqm);
> > > >
> > > >       dqm->sched_running =3D false;
> > > >
> > > > @@ -1930,7 +1932,7 @@ static int stop_cpsch(struct
> > > > device_queue_manager
> > > > *dqm)
> > > >       dqm->detect_hang_info =3D NULL;
> > > >       dqm_unlock(dqm);
> > > >
> > > > -     return 0;
> > > > +     return ret;
> > >
> > > Same here
> > >
> >
> > If I change this back to "return 0 ;" then I would have lost the
> > return value from "unmap_queues_cpsch()" or
> > "remove_all_kfd_queues_mes()" which was the whole point of touching
> > this function.  But since we in the "stop_cpch()" perhaps it is a more
> > optimal solution is to ignore the return code with ...
> > (void)unmap_queues_cpsch()
> > else
> > (void)remove_all_kfd_queues_mes()
> > ...
> >
> > Which would be the only change here. Otherwise, I would need to
> > introduce a 3rd return statement.  So do let me know which path
> complements the design more.
> >
> Good point, I missed that it would drop the one from above. That's fine t=
o
> leave in then.
>
>  Kent
>
> > >  Kent
> > >
> > > >  }
> > > >
> > > >  static int create_kernel_queue_cpsch(struct device_queue_manager
> > > > *dqm, @@ -3439,7 +3441,6 @@ int suspend_queues(struct kfd_process
> *p,
> > > >                                       else
> > > >                                               per_device_suspended+=
+;
> > > >                               } else if (err !=3D -EBUSY) {
> > > > -                                     r =3D err;
> > > >                                       queue_ids[q_idx] |=3D
> > > > KFD_DBG_QUEUE_ERROR_MASK;
> > > >                                       break;
> > > >                               }
> > > > --
> > > > 2.43.0
> > >
> >
>

