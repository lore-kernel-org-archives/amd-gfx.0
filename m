Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B6CC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 18:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA01310EA51;
	Mon,  6 Jul 2026 18:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ioWrmID";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012035.outbound.protection.outlook.com
 [40.93.195.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87C4310EA52
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 18:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Al72EtcxcA+uL1DdydYRDnEiOkQCGvfDGEx7jLbS8jY4Gsqo9S8TeFDTljsOKHGF5EYU2HoFn64w7BplwxsU1G8sCVCElY0D9HbKxOSQVHLcm1HnHNnt3EomP9n56WV1yrRE+zzo4hRc5SycOPKURV7Vd/cEeBUUmYVkvpKIZRV2Rd07dN5VxPqWOLoZZOM6NlTMAYYnvqt4w91XQgCl/tjk8uS0DV7nOwf3Vna21cd3a8NRdUx1jIMh5Vd+ZojBstM8r2Df21AnPmY6PYaNrK9gFboV4TkIGtsuAe/7syuB/W2MhqprYpED3TexGIKaWUMm4IpMIqe6z2Zz8OFbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ho+nGY8MwUkfclwl3YRWoQmPB0PbeZq92qdTqNeKxLk=;
 b=uLOv3y/BGfI5/YrJXcNg3D0RNxtQu/LbvTyrvoPVv63eKGkWzO+iIQTTyu4XLSpx0rtkTMoYdjbWKu984+Yt3+hFCX34QDw87zKvPWJOHd1mEZbD+pKedEaHFHs+xbLNvu+3bOpF01wEEuVVWNIh3gRPDIsS5yuDsN9I5u4Y3X7beAa1YPeYyG6i0KNqxbwCYco3A23aUXyoWUEGWayjrZtpKEksC91fxhsnxow+IE9PO9gCA5DPwWpPnGy/J/oZX9RySGDq0X4bQMkMTlZbPNyK0cIhQqDv4krxWGO5TAaGLFsu6KrejrEfp/RrJ4AlD6a3Ml9OEjvIH2J+gZbOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ho+nGY8MwUkfclwl3YRWoQmPB0PbeZq92qdTqNeKxLk=;
 b=4ioWrmIDle0PuqQpq7s597mmjBmNvkJoj8TYymZAT7Fyh17sK4C9ybHmPk4xRhbuVAJFwlbAIeDMsWA/IEMTqCgtpJvLzQJn9+cYi5NXJZjlCcr1lby3OHwsRRZs4L3D+kAChAHdjIhG6da+vtxq573i52cElEkZ26WuB6olLo8=
Received: from SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Mon, 6 Jul 2026
 18:32:16 +0000
Received: from SA0PR12MB4397.namprd12.prod.outlook.com
 ([fe80::9524:b7ca:358d:4bdc]) by SA0PR12MB4397.namprd12.prod.outlook.com
 ([fe80::9524:b7ca:358d:4bdc%6]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 18:32:16 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Russell, Kent" <Kent.Russell@amd.com>, "Francis, David"
 <David.Francis@amd.com>
Subject: RE: [PATCH v3] drm/amdkfd: Check bounds on CRIU restore event id
Thread-Topic: [PATCH v3] drm/amdkfd: Check bounds on CRIU restore event id
Thread-Index: AQHdA+A58VvTjjw5/0mxEzxv5LEn8LZg4kJg
Date: Mon, 6 Jul 2026 18:32:16 +0000
Message-ID: <SA0PR12MB4397FDFB78D0E4FAAE67D36195F12@SA0PR12MB4397.namprd12.prod.outlook.com>
References: <20260624134822.1646363-1-David.Francis@amd.com>
In-Reply-To: <20260624134822.1646363-1-David.Francis@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-06T18:26:47.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB4397:EE_|SA1PR12MB8117:EE_
x-ms-office365-filtering-correlation-id: b34f0a39-93f4-4f6f-c5bd-08dedb8ce7c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: RxVWMZm2OkUBXhi30BsDn21SrHhRWvvk1xlBge2Ls64mQtH1tv9TkHbJNgcqaxg53NJLsULNSKu2WsGRIhSnaFlteGiOCzk+etsNaMLSzqwwHxHxon7HLf6K1fWiEB9xLdg1lqNBwllCVrUT9sTm6V2lHrZYo+oWn+kLHm1wa5lMM5SvOQR/LFpwMUYQFKYNSSGBpzoBAH7hWM3tIo0dglP58m/yGHSiWtC8N7knJ91OGc5JVgS1Eo8IZnnPWosA+w4EXbjKjLtiNUACrooXJ7aYq2RvwwBSkU/Wir0xIOhuyHIJ+I87UeTPPyqEMAV4k+/eJ3jhi4TKnH7KSyS9fxlLW3zmMxWxBVeRgGFlJWY9IBVgHEiJTIBkQI0kGtji7qY9tHmltPBKs8FL9TThT3769+e+q19Bx2lQy57DziJC8i0dRd0dMFkpjzvGpH7bPBmd4lz2VGlQO+zQVFJwwv6GDqE6FKWyKkUHwIIJZ0jjhcTLc+LuO4zRpa9HPYNsYIXRpWxOT8HcABbJPI/Bm8itZ8tZ14NpgfnSMvnuU9shSKHoM/iuuU49ZJujhgT6vZUsrRWznaxfZQjo8gogeLOJBPSg3eiu5UU3gT93TuBvRw+ujoJbei8G43AQDffHlEPD7TxoOQOFay3cLfx5i1vQwdrHMOddZ1W/sae6ajQDDy/n5qdGtYJNLGynjuQb3zUGeg4JvpoEKG9yopMzzUOSoyU60RqQXyZOvbYBvgU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4397.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(22082099003)(38070700021)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BHyE/zdYAtH7woeTeFw67Qnje5hDbExwXjPCxoMQrSlGtQ+UakneF192Ynab?=
 =?us-ascii?Q?P86L5VFpVne1ldxxWs1R+9zFpHUcdSK65Vcv5FWQFW6KsGGpfyT7CG23vUcm?=
 =?us-ascii?Q?grtUJD5//IWhB+KIqFLNT3M/0h/wOOkk1m5gvSG2H+WX5hZ1BMj/3o5DZx3o?=
 =?us-ascii?Q?bCVtj5Nf8R0tnlvCSBDVPgQTbZ+sEZRMvDOBI2yn443GZ58gWF00CS0K5m6s?=
 =?us-ascii?Q?BvihSlCA7FI8SfWNFr1nmR7tDfhY4EoNnYr4MhKuCSWwAYmj3DMt0oeSvVSp?=
 =?us-ascii?Q?YJcwODTh+LfNLfOKxEZU7bhyDjqX9uy83lVdoSwO2bdFAyxovhpQAmAD0eui?=
 =?us-ascii?Q?LPqrNRskT3V+9SfDBJig7TLMF1Wda++KzMC4Yl4PUXMZxsvkR56RmrcxLBin?=
 =?us-ascii?Q?cHhAaiN6+EW18dQCYJeHqxYfOSwKifOf9oQp14tEnsKVONGSf5HSk7HaT3xP?=
 =?us-ascii?Q?5N6hn709hcTkxx9HHYJGk+FGoTWGloyc7mBrBg0705CdFGRiDbQdvoQl8wbM?=
 =?us-ascii?Q?mWA0Ifgi6XKiA2m438rbdBpgyyLnAOKyJbRgB6qcSlwe0tK4CeR3rM+by+GY?=
 =?us-ascii?Q?Jw+f0PdKFLd7uAdfN82+xdLXviLbejNpr0Q2zU9eQxU2JnNLfHzVp49PoWOz?=
 =?us-ascii?Q?a6afKE5ILnq5fS0HEl/bgaxQz2KaqDHLd6sjE6MGJ5Sx61peXy8+uhpH5DkE?=
 =?us-ascii?Q?K0DJ4xzXU/9GmbQn4sYBfen8CvTLJrGNjVYvBSD0y2H3mFhf2S3955GKwWVT?=
 =?us-ascii?Q?4YGaRP5+uwTQapaLbeGB+Fd9EBEzIsKoxd5q1xOEO5eB5aJrn5QqpHl4o+Bb?=
 =?us-ascii?Q?uMAg6OA+dnVIP7ZNR/OKAD3x0SkLV4Ak2k1AuO0DFnDWRqdQMnIfD0hPW3kC?=
 =?us-ascii?Q?LB9SAp6BvyT1y1RV2T3mlsLwHzeW2ge+zcjTOzxDPkoMc/2q0NIFmtZ+/y7G?=
 =?us-ascii?Q?uakbZMR3JkEh/MvOOCMJbNDtA1GE5r9TdXdfForDwj92yC7naMDhxdfvl/tW?=
 =?us-ascii?Q?7uQDSYOCRSqlAHt3IW6YMYa0FH1g0dY5nHaGydMQyPZlHvxaSBd+ZOLiJlAh?=
 =?us-ascii?Q?Xk0Z+26zB7gHCupknT9GybNGlocnTyRrgkPOzrqBc1UfD3vRLpgXudPZovH4?=
 =?us-ascii?Q?pZefXo5AWqYJCSbcypKjlGQXp+GjB6lL/YEVJI7PBuKVEz6f9An9CMJL/kfl?=
 =?us-ascii?Q?1/DpmS0PXV1CUJJrN8PadVwhoPHOJIqieRjJKIPrBvgksw/ikQdl9ij+JvzO?=
 =?us-ascii?Q?IQdzvhB3SyDF33jP/ebSVG+9S3pisYityCz4Qe+lsFzXb0IyulrNPbrFKXPM?=
 =?us-ascii?Q?0Q3rW9r+mYuJ71mpZa+IQgjPPayZLnFBU8QgKAcEb6dFHomxEWqBhgPOt8NA?=
 =?us-ascii?Q?Y5YQYOPN04NphHzqWhCkCumheSbmzWjAJcM6GA7C2yxMddfiameWfMG0Qxgp?=
 =?us-ascii?Q?aFnFczVJq0wo9gcE8UghQKfqaLsYBuZZFBsi6InD57cJ7S0/rxmH8F08cGY5?=
 =?us-ascii?Q?rL6EsoS3ooHBnCNnvXda4OdhfYlfltuVwbZOlePoaP7dAXwLwgbtTj6XGA8T?=
 =?us-ascii?Q?BHJePxf6U3IqmdIjzpTJCtOgUBzSulrAfU6JoD+Rl0hgqe/Z6YOiANotJLg5?=
 =?us-ascii?Q?LqHscU/xOHGCIUFEDY+ovjLc5vh4LfBvt0GMn5A0i6+qMs3Lct2C5bBpgU0o?=
 =?us-ascii?Q?lQxhQLp0f88O2wMDs/Cxi4IzGFqb7+KqK5ZQivHofAonHPB6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4397.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34f0a39-93f4-4f6f-c5bd-08dedb8ce7c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 18:32:16.3004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADkEJfP03diwrinagKexvym7UloANNX0VW3bateFnbxE2l+RJvnjAuqoY0TMTOzignPvzb22QVqSPFnZnCBPgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117
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

AMD General

Reviewed-by: "David Yat Sin <david.yatsin@amd.com>"

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David
> Francis
> Sent: Wednesday, June 24, 2026 9:48 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>; Francis, David
> <David.Francis@amd.com>
> Subject: [PATCH v3] drm/amdkfd: Check bounds on CRIU restore event id
>
> The valid amdkfd event ids go from 0 to KFD_SIGNAL_EVENT_LIMIT - 1.
>
> During CRIU restore, ensure that the provided event ids are in that range=
.
>
> v2: No need for lower bound check since idr_alloc rejects negative inputs
>
> v3: Also change error message to reflect new error condition
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index e9be798c0a2b..52347726c6b0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -107,6 +107,9 @@ static int allocate_event_notification_slot(struct
> kfd_process *p,
>       }
>
>       if (restore_id) {
> +             if (*restore_id >=3D KFD_SIGNAL_EVENT_LIMIT)
> +                     return -EINVAL;
> +
>               id =3D idr_alloc(&p->event_idr, ev, *restore_id, *restore_i=
d + 1,
>                               GFP_KERNEL);
>       } else {
> @@ -204,7 +207,7 @@ static int create_signal_event(struct file *devkfd, s=
truct
> kfd_process *p,
>
>       ret =3D allocate_event_notification_slot(p, ev, restore_id);
>       if (ret) {
> -             pr_warn("Signal event wasn't created because out of kernel
> memory\n");
> +             pr_warn("Failed to create signal event notification slot\n"=
);
>               return ret;
>       }
>
> --
> 2.34.1

