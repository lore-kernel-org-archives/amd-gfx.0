Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9041EC4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 01:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F214A60F9C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 01:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F214A60F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A83D36E231;
	Tue,  3 Aug 2021 01:56:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA2EB6E226
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 01:56:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyKhrZc/da2zH8pnCxK74wsCFhXzZWQMDxokFSNO5bEsA0Vbgu1reSJO4YzTDkI2FL+83MNqLFqpswe2FAzNtwS+8PkvfDLfInr2yGn1OFoJMzp4Xnmdh20e8VWIKoc/f6BvPtdcIDCsDJT3CG2eKqQOZgdHhN0U9wKxWV6nl+uP0vPe7SG7A1yH9WWB5NwJso8i3zgC4K5mB4qrKWkBxSYrqaRosGZcVdB8QkhLTx28kFsWFh5u7g82I0Gp5N/eSjBhQ4VWuRLq0DD/n4jGJqrNXJXw+jII8Cw7y7Pq+ra02ciyNG09nKq3IlpNwrsPmwGdswIxW6E/ljtrzfNf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jIX5Sw7OB32EFqXXL6Rwus7GbigyKiR9EPOHMNFq8k=;
 b=RrfQr+nynEys4EEAOKqw8E07oELHqq1m+NFhUtb+ZdWOIbNPoXQmbnln72+RoyFXN6xpCWcq7s/WjrWeXGNIX92hjHTjbjBW+NAiWKaj2kY6pRjcEUp6frowuRKWVX8yZAPzauRffgOHEchhprH0ES17AcWJKgkdqkLWRAa0s0LryrIPKrL1Hm4efkfDZUDHbn/o9VFkua8spNnkkWpUsJvk3dE/R+gMGF0+EctGIDY8CJt0bR+gwZk6VGCXx5RoA0uvyBOFyLkfeU0xLZfLhqQ29t3WnVg+mDxmXWtFTniSVHMu0IMuV6E++yuhkEBFqyROEQNRO4OJuaee9+QJUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jIX5Sw7OB32EFqXXL6Rwus7GbigyKiR9EPOHMNFq8k=;
 b=RsJu5HgvE9K1V75oT9+t542GWs5jI6nFZ6Xe7e89wNK0RkwLQrk9xJ0YojIKJwO9I/bXmQkj49eTFq3W9Uawrs2AjNudlWuzJZ/c4HEUqC7vt0gg9EZy5sAHqd1hw5Zg+xMOunDwKgw1mp8oNRl7Jiua4e39BXuA2A9Z21TMTnU=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3770.namprd12.prod.outlook.com (2603:10b6:5:1c4::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Tue, 3 Aug 2021 01:56:32 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 01:56:32 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Gao, Likun"
 <Likun.Gao@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test (v2)
Thread-Topic: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test (v2)
Thread-Index: AQHXh12IB96Cm6kAd0+4i+qoX2BuqKtfyE6AgAAXjgCAAFfjgIAAzsVg
Date: Tue, 3 Aug 2021 01:56:32 +0000
Message-ID: <DM5PR12MB2469AD07423359B8EC3EE763F1F09@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210802051602.23822-1-guchun.chen@amd.com>
 <b7218d98-9eb1-2d41-157a-bc417ef496ab@gmail.com>
 <DM5PR12MB2469A94D544647D893DA0FAAF1EF9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <CADnq5_N_56yTXq4W8N3GG2kNsyEaCD1-xF8Mip8=26q0oRw39A@mail.gmail.com>
In-Reply-To: <CADnq5_N_56yTXq4W8N3GG2kNsyEaCD1-xF8Mip8=26q0oRw39A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-03T01:56:29Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d9475bda-7fa6-4b9b-bde5-51ac0dcc2480;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 440a9f03-ddef-469f-451d-08d95621eae6
x-ms-traffictypediagnostic: DM6PR12MB3770:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37705A8743ACAFC32E6B7BF7F1F09@DM6PR12MB3770.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ohCibQVokekwQkvdAFwRQiZaOMXDOLXUjXLU0ipdvCConS9p2dXbZmCndLv5Q2hBYd86ltMEh/aCiqDRyBrdK16M9EjZu2en1eHD2pIA84BHalF2Z4Vb96wKDRbMhFmY5fiKhgeF0AkUSLVL6K4MHV+wF1pwDnNVj86sT07Xe/2g12A4s3FfODgPZAYivFqIRcGOv8PmgrW69hhk7s27PrHGroA2jftrCXwlMA3KJ30EggZBHHl4d5d7ATiQ44Igp/CAuYW1Jgw1Fq6lrnrWJob9n1Moqnq24cDpnL0QxtwLyL3SyNZH/3APMW5qISDTFqIrb66dUwnMTKMOpKdRrCEzscBBYv5RojWhny5FBERDg1qhrb0Ndaqxx3Yjr8wFVFfeSIj0/Pp36njPb5QFuY+Tz0p2mg1xk4V9z4Rs7tUbmY7pY1efyX8Bs6oZOQhJhyGyzRv5GzJNwl5m02PfnHyBGcyHo7r7LXKFT1gEAiQhlQ4g0dI9npVA2pIwhDSynfNuVL1I5EWcaCVYKx5XnWWUi7SFwTbJuSzOivuPO/I0b6lANJFQkWf3yX69fZtXgLjfhThOE1MESIeU0u4jRBvN814ax3bBn+edQYuC3kVjygZn07c4fHzmS7qr2jDg3RpreTrnZzcmgZUWITifgO4kZ37xilV0lM2CvtQ7fK6R2LZS4HjcaiJMjgB0DwBbnXgfADYkLE4k3lYZpWiDdg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(53546011)(38100700002)(66446008)(64756008)(71200400001)(6506007)(66946007)(6916009)(66556008)(4326008)(66476007)(122000001)(76116006)(38070700005)(52536014)(26005)(7696005)(83380400001)(186003)(966005)(86362001)(66574015)(8676002)(33656002)(478600001)(8936002)(45080400002)(316002)(54906003)(5660300002)(55016002)(9686003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fta/6nrCTCDjr6E9Ol+to9O5hFPujYfENM2bMY/rf44R9pVnBQ0qxaLGio?=
 =?iso-8859-1?Q?Aw0+fN8EXoR21BzV0yV/SVB4Akoab9qaASWKDr6NmJU2xXO/VT7zC8Z3rl?=
 =?iso-8859-1?Q?cVfA8TfRmpk8pz/VXieDA0oGALV4CAm5kbql8aoBilkkLlqwIsHzKK1efK?=
 =?iso-8859-1?Q?BOz9qiVpLOtxK3DNhJUkqZaaZM7pwG0m5ZSREj+1HGgV00/QwbO9zy9DOB?=
 =?iso-8859-1?Q?eoPVj/3CTUOTnY9n08bKbFuWvb7QuueSSvxW6qftTRywAkvYiX00IsWCah?=
 =?iso-8859-1?Q?rcg0j375a7Vl8+CeHIyQ1yNEWAqVn+OZGB0ore7C4282A7GFK5VjSlsTSJ?=
 =?iso-8859-1?Q?UlztxcgXgcB6e3rWApHUHV+H858iyHJXid6fMZC7sHnnxoJOcJ6GWVsRzg?=
 =?iso-8859-1?Q?mMGG5/YOTiaQzaDzocBerr9SxoneeTHIQnKX7g0mTC0CwxXqdQC8HdD2/4?=
 =?iso-8859-1?Q?nZSzpc4IjzE/6ic1aBU2aKFge2wIwpHRGW4gCK4p0IdxdIWvEAOyCG6WR8?=
 =?iso-8859-1?Q?fqQt8DafA6S0zCMT43l55JT0Kct4zEe1qs5D8D6rywsry5eNAlYohX095M?=
 =?iso-8859-1?Q?ZIxxkh2rrtbWvEm1IslOErtXUDnZrtpnqEwP2QoxCFD4O5oTh5HWVNFYE+?=
 =?iso-8859-1?Q?ebUdDIriohKiyCnW7xanbRipIHEMMAvoKSAWvezd5grL8QAOQvxlAbd+j/?=
 =?iso-8859-1?Q?cYYHiyeQ3vlaNgTbSuOkEriBuCFFyX6Q8EXMaNEre0bi9n+olrJrErcUVo?=
 =?iso-8859-1?Q?j4HujABxHXRDhEF0dXdzZXFWY74/6BVYRwHegNHIDcUxk5MDiWsQFpEYlU?=
 =?iso-8859-1?Q?J3qV5CP7de+3+M/UDzf0xqXOi3Kq7kn4llILO+3bLT9i6TjnGiwPm6ln3n?=
 =?iso-8859-1?Q?ymOU6ycAR2QSoFj2aCJeocHU5E0GIhyr9JVhlAb9F/L6+a0iH2d+Js4azC?=
 =?iso-8859-1?Q?eZgyIppKmk14QKGN09/ww1sBwH9FsAvA9A2XGfIdoMBVZRIbUpVMiTzMLv?=
 =?iso-8859-1?Q?mazVittTMeCCZ9N7Ef1/mioqziktUJ/z2RV2+JehYrH8AnXe+Zx0goy8R3?=
 =?iso-8859-1?Q?taoNSYteqjEqUZWM0hRv2bcYpnKBUxDP1qCKJN5vkIgWZn15HmFX99cuj6?=
 =?iso-8859-1?Q?NzYok/b2ZsaHNPNKFluhFXvfsgCrP5rdS6EcGtNVeIc7Vl7JfgcZj6pOch?=
 =?iso-8859-1?Q?Gei/Lg4R+To6ci451VXhNq+yxLUjNevKdphLlWatHlrUpJFC2JgHqbi6dX?=
 =?iso-8859-1?Q?L/ek09T93/e66ONBzDrShZmXJfUjdiZ/LMZLBJ3MnZvGSl4xdGh/IiMrjv?=
 =?iso-8859-1?Q?RrgOd8q2xJl0opyUAYhNfIMQw51HebTSZH6gNyuGGTB8N/Xx2YYNTuVQPn?=
 =?iso-8859-1?Q?DK4snANvav?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440a9f03-ddef-469f-451d-08d95621eae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 01:56:32.2725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /KbNqVZRHN1Pt1K+VSx2fdnpll85e9EE2JqSu3yKoUBM3kAo0jpVa1fHPHGsIwqabSr7w7RKRJ+e9TkFhIc/Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3770
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

Hi Alex,

I submitted the patch before your message, I will take care of this next ti=
me.

Regards,
Guchun

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>=20
Sent: Monday, August 2, 2021 9:35 PM
To: Chen, Guchun <Guchun.Chen@amd.com>
Cc: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.fre=
edesktop.org; Gao, Likun <Likun.Gao@amd.com>; Koenig, Christian <Christian.=
Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in =
s3 test (v2)

On Mon, Aug 2, 2021 at 4:23 AM Chen, Guchun <Guchun.Chen@amd.com> wrote:
>
> [Public]
>
> Thank you, Christian.
>
> Regarding fence_drv.initialized, it looks to a bit redundant, anyway let =
me look into this more.

Does this patch fix this bug?
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.=
freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1668&amp;data=3D04%7C01%7CGuchun=
.Chen%40amd.com%7C2bf8bebf5b424751572408d955ba66e8%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637635081353279181%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D=
FuAo44Ws5SnuCxt45A%2Fqmu%2B3OfEkat1G%2BixO8G9uDVc%3D&amp;reserved=3D0

If so, please add:
Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1668&amp;data=3D04%7C01%7CG=
uchun.Chen%40amd.com%7C2bf8bebf5b424751572408d955ba66e8%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637635081353279181%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda=
ta=3DFuAo44Ws5SnuCxt45A%2Fqmu%2B3OfEkat1G%2BixO8G9uDVc%3D&amp;reserved=3D0
to the commit message.

Alex

>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
> Sent: Monday, August 2, 2021 2:56 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org;=20
> Gao, Likun <Likun.Gao@amd.com>; Koenig, Christian=20
> <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=20
> Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver=20
> fini in s3 test (v2)
>
> Am 02.08.21 um 07:16 schrieb Guchun Chen:
> > In amdgpu_fence_driver_hw_fini, no need to call drm_sched_fini to=20
> > stop scheduler in s3 test, otherwise, fence related failure will=20
> > arrive after resume. To fix this and for a better clean up, move=20
> > drm_sched_fini from fence_hw_fini to fence_sw_fini, as it's part of=20
> > driver shutdown, and should never be called in hw_fini.
> >
> > v2: rename amdgpu_fence_driver_init to amdgpu_fence_driver_sw_init,=20
> > to keep sw_init and sw_fini paired.
> >
> > Fixes: cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence
> > Suggested-by: Christian K=F6nig <christian.koenig@amd.com>
> > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>
> It's a bit ambiguous now what fence_drv.initialized means, but I think we=
 can live with that for now.
>
> Patch is Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>.
>
> Regards,
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 ++---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 12 +++++++-----
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  4 ++--
> >   3 files changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index b1d2dc39e8be..9e53ff851496 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3646,9 +3646,9 @@ int amdgpu_device_init(struct amdgpu_device=20
> > *adev,
> >
> >   fence_driver_init:
> >       /* Fence driver */
> > -     r =3D amdgpu_fence_driver_init(adev);
> > +     r =3D amdgpu_fence_driver_sw_init(adev);
> >       if (r) {
> > -             dev_err(adev->dev, "amdgpu_fence_driver_init failed\n");
> > +             dev_err(adev->dev, "amdgpu_fence_driver_sw_init=20
> > + failed\n");
> >               amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_FENCE_INIT_FAIL=
, 0, 0);
> >               goto failed;
> >       }
> > @@ -3988,7 +3988,6 @@ int amdgpu_device_resume(struct drm_device *dev, =
bool fbcon)
> >       }
> >       amdgpu_fence_driver_hw_init(adev);
> >
> > -
> >       r =3D amdgpu_device_ip_late_init(adev);
> >       if (r)
> >               return r;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > index 49c5c7331c53..7495911516c2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -498,7 +498,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_rin=
g *ring,
> >   }
> >
> >   /**
> > - * amdgpu_fence_driver_init - init the fence driver
> > + * amdgpu_fence_driver_sw_init - init the fence driver
> >    * for all possible rings.
> >    *
> >    * @adev: amdgpu device pointer
> > @@ -509,13 +509,13 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_r=
ing *ring,
> >    * amdgpu_fence_driver_start_ring().
> >    * Returns 0 for success.
> >    */
> > -int amdgpu_fence_driver_init(struct amdgpu_device *adev)
> > +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev)
> >   {
> >       return 0;
> >   }
> >
> >   /**
> > - * amdgpu_fence_driver_fini - tear down the fence driver
> > + * amdgpu_fence_driver_hw_fini - tear down the fence driver
> >    * for all possible rings.
> >    *
> >    * @adev: amdgpu device pointer
> > @@ -531,8 +531,7 @@ void amdgpu_fence_driver_hw_fini(struct
> > amdgpu_device *adev)
> >
> >               if (!ring || !ring->fence_drv.initialized)
> >                       continue;
> > -             if (!ring->no_scheduler)
> > -                     drm_sched_fini(&ring->sched);
> > +
> >               /* You can't wait for HW to signal if it's gone */
> >               if (!drm_dev_is_unplugged(&adev->ddev))
> >                       r =3D amdgpu_fence_wait_empty(ring); @@ -560,6=20
> > +559,9 @@ void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev)
> >               if (!ring || !ring->fence_drv.initialized)
> >                       continue;
> >
> > +             if (!ring->no_scheduler)
> > +                     drm_sched_fini(&ring->sched);
> > +
> >               for (j =3D 0; j <=3D ring->fence_drv.num_fences_mask; ++j=
)
> >                       dma_fence_put(ring->fence_drv.fences[j]);
> >               kfree(ring->fence_drv.fences); diff --git=20
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index 27adffa7658d..9c11ced4312c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -106,7 +106,6 @@ struct amdgpu_fence_driver {
> >       struct dma_fence                **fences;
> >   };
> >
> > -int amdgpu_fence_driver_init(struct amdgpu_device *adev);
> >   void amdgpu_fence_driver_force_completion(struct amdgpu_ring=20
> > *ring);
> >
> >   int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring, @@
> > -115,9 +114,10 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring =
*ring,
> >   int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> >                                  struct amdgpu_irq_src *irq_src,
> >                                  unsigned irq_type);
> > +void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
> >   void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
> > +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
> >   void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);=20
> > -void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
> >   int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fe=
nce,
> >                     unsigned flags);
> >   int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
