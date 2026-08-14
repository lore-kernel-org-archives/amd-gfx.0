Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0D8C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 20:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C3710E1C2;
	Fri, 14 Aug 2026 20:17:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QB/j05LX";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1122A10E1C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 20:17:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qo8xONXPCQWyQPVCjaXLroGsdPhvIdwqfrwSpem3J1KTEaANdjJYXCM4qctg+i66ECPnAiAKkdRfvMjvVR9bH/0IQtRPnAWFJ+fVA2sL433aE8YCJI2AbSuEERi16cS1iDtmyGihBGCS0supt8/Tdv+smWqVDyeM6aHlYRIwUGJhOajOnXXMDX6NhkgCv/1w1aUXiuyXwJx4/Ui97JDzPGyQ1VqVVeCl/cVbVeJzorZ5djJHhjhfrZQ6WMPz8bysnF0DBviw3XuPusxgdRcbRynUbv9ccFjn5nsdmKai8yOLL+wTdT5GLvgXQSiPX0Ab5DS7m0iEQBkRDHMafEqhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SibMVReVbYVfiAEtniCeSJICPg8ygnrMo6qCta4Eg5k=;
 b=aIbJ7uITB5LMKsYZLg7L+Gv3+WsBuJeLpT8cICwQKVM1+kj2hpl1CuKYQ0CNDcfqzH6n4YgrlO8WjnzfCpPxMnddbsd6C0PNtUvyam/UFqvby7gtO0NC6y18sM8Ov6rAqh6dWykZr0TbIjLsKIA9AvRVmS0IUza8pGQ+FOtLctequ7/x4ZDMwu/YPWxLRC7bK8Qriw+1/VgGOUo39JHjVjX/KCd6vNL4zUbU7s1e8XDqO7bcBkLDHMHz+iXF2uz+AEp0TT6NtcO3F2PT3/CKuyBSyKT8sQ3HgZ5V4t2nXf83dfZvXlMKoEvyzrnoSSPzbL1NZuY3scmxG52pe6PCfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SibMVReVbYVfiAEtniCeSJICPg8ygnrMo6qCta4Eg5k=;
 b=QB/j05LXUoo4c3Ir7Q347+5RZpJmgycSojBze3rTL7mHF/2KVP9nKfou51WZajoG1faQNmSoU2HVyNnpP07iHlcHzcE77q9nW6S/R6N+HbhTqrc33cu8jrlmO/Kraubt7SwYPE9TxXKVN7wnNyjpsza6Qnrti0d70nzHYfVS6cU=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Fri, 14 Aug
 2026 20:17:48 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 20:17:47 +0000
From: "Francis, David" <David.Francis@amd.com>
To: Tvrtko Ursulin <Tvrtko.Ursulin@igalia.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
Thread-Index: AQHdKZtuwKL0j23ih0iEndBGSlFyNLabrb0AgAIfOx6AAASkR4AALqnZ
Date: Fri, 14 Aug 2026 20:17:47 +0000
Message-ID: <SA1PR12MB81442EF592A5CE95DB59DB97EFDA2@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260811141202.1633727-1-David.Francis@amd.com>
 <20260811141202.1633727-2-David.Francis@amd.com>
 <5ec5f320-d8d5-444e-8ed1-1412818ffd8b@igalia.com>
 <SA1PR12MB8144389F1595B105143C4913EFDA2@SA1PR12MB8144.namprd12.prod.outlook.com>
 <SA1PR12MB8144218D235CA976EB714EE5EFDA2@SA1PR12MB8144.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB8144218D235CA976EB714EE5EFDA2@SA1PR12MB8144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-14T20:17:46.452Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|SJ0PR12MB6926:EE_
x-ms-office365-filtering-correlation-id: 64ece428-65ad-40e9-5bd2-08defa411b7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|11063799006|5023799004|56012099006|3023799007|38070700021|4143699003|10067099003;
x-microsoft-antispam-message-info: /n7s3w+fKS20vLcnT2VIG6QeM2astLx53f6ZStbyYKlVdHLuI5N8uh/hTpCooCnveAe00hbLjHdkBOaBqyCXOqmQrdSJJjz5SB/tuxQCiucE4RkH1r012A9Vbx47HbOiSHoBGheHTCsLI/6xNTvKazCE0g4pFlZ1WttqmskqTo4AYY9N5DEr/IEu4+JBeqEoaluTkWah3FWJ/wVgRa6vcZKRUuphJx30aZ0NpUqKscv+zrfFXIZtmEt9Erhe1uwgmiX/kwRrZFPLQkvT9mNuEb6sOcQsnSssD/IygiPJEHaiQDdgJ3BmBug9WZOzJXdH/UfBTxTC97zt2TfhBpEWTcElYRXly42ljbGivlzeUJgr/iay23EnVZPrj3mCgT9T3roraeK8kxbmUraU/hfVYDk9m1PuKyCDQChLRtF5WrURjUgKGAQsht1Ra6RFanj/FGN+Oa5t+C7MyfqRn2O75NJSZnNTc/fuIuaUr1ge2hUe83URIGcX5AQbbUL+7dx1rktR27XO8EdurmwL/MAj1HxRg8h9yN03DwpB37NOw6HqaYVPO7CuKosNHsjmIpon7TCn8Q+PbIS1LBWBFAkFjRiMAXzKFaETKmnQXKa9lcWBQEK8QB9tC6bpkcqa5LSRg0U1ZpilG1MVcUJMjjhTNWHwVIIkZgjcwi81jlg/uaF12Pxhe+wNT4Tqqe+Bhq7nLKKQ820LzSbdwtJ3rqfX6tbx8HxuOVsdh5W9PkCNMiI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(3023799007)(38070700021)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5A7sYm9dl4aFIm577n+pc01KE5J7p/hbMWMSC5R0vAQ0eQFLXMOQk5c/BgPJ?=
 =?us-ascii?Q?1BZksFoPN0/xvUVn8+IhHPIpK5nUABEFIWhwdk9bEzg6S4JbRxsvo8a/DXxg?=
 =?us-ascii?Q?cITR4RV9b0u029Z0aWratLQFlDBOjmgX28i1WwKM8zwfpRJ5wlWrEpw4XFGJ?=
 =?us-ascii?Q?wNKjlP8gz4mcGSgUPYXv2SN8wNYTd1bMujdJGtzXZS2YUMxhmfzUmeYrvkap?=
 =?us-ascii?Q?nm05wA6k63mreOalHO3yROHmTvsxL4blc67mMHpQikZOGSoYPmNX5MIaWZNy?=
 =?us-ascii?Q?P+KTjBiZUffGIceDGNBmStlRTEY2PzztplIIhbhOiZixxQtsZj9CfWs3uTq2?=
 =?us-ascii?Q?nBhVjwkvExFt3xnXIvz2ev0s6OD0p6g+c5YJqDH4gqoqbVaf1I/hAIE/47KN?=
 =?us-ascii?Q?Z4/X4WUgpON+saWSuvCEuRZN5UUSVRZHOt0KsD0CwR+TcFsNo3fqubMp2wom?=
 =?us-ascii?Q?+GG0IE9Lomf1WdUpJdxOqMNtXnxRAU3y0xOBGqcqGg0wlXN1Qu+1x0HRbFl/?=
 =?us-ascii?Q?gbrp98ncn0+4Zv8vZA2ZlNheL3q74MLVd/LZqJ6RZcH+WVqMzWF2fTR0ACE+?=
 =?us-ascii?Q?w7BB4CsXJcBn1DJxXwB2L+4c59szlx+3kcJ/4gZ9t4HmWOPD6H4NFUuCgDR0?=
 =?us-ascii?Q?5QLvWcCqKJmw8I84Q+vGpOlfW/RY5jBfje6QnjOjtbr55NVHrl9kBNHlRDsG?=
 =?us-ascii?Q?aVlUhhYVygKjjWAZ4IGLn7qu53jDX/pGUfcizQKpMGccg3As7xgcaUR5xzo6?=
 =?us-ascii?Q?DI8lsTiNuvuBUGOR5QgHJuBkFsmZUPBC1fd9Ff+K4pyPS/MTOz4VjQ5/EbBr?=
 =?us-ascii?Q?zJ6INw3hDVLyGEXsK1oBdTFukj58l7DA2NPCejZQmTsEq5xWIUN4kD5W3mSw?=
 =?us-ascii?Q?MsUGDYNLoCyetXnURZTqTJJrDFtwavDaFBUbjX9a9LThXgOCy7eGoU/YJ174?=
 =?us-ascii?Q?tjrAuuwipxdh0aRGO+RLNImV1Okt9Cw12mSdx5fxnrHW6Lb7xLjdugllTMJt?=
 =?us-ascii?Q?yi4ptVC+7RD+bH3MUiP0Rx+QY7lxLbkUI+nt+V2JpZDL+srk3/vHPw4Ph04H?=
 =?us-ascii?Q?2P8hLKEcpYFHhWEU4BlJmQao59DZT+roYj2CyAGBP/kpmjo32n/TL4RYlcqU?=
 =?us-ascii?Q?HARSt12y/0iq0ac39ILOZaAj2PnMY6YoK5kp5s0/q2RQBtdWxY9f1OpIcE3b?=
 =?us-ascii?Q?1JAeM5pJlq4djz/SL/eUfoqVWDj85/kyX44p9Fp02GMv4+75FNq8+5LWR28u?=
 =?us-ascii?Q?bVLA3PyXgxcFT6tqalrLbHutBFrXSGIwjuJsGLJ/h8J9DyGktWoP0+nWB0HN?=
 =?us-ascii?Q?R1UyYdV6QE7Cl7HbuS5hXOJIXZrq625JQxHgaNLYYcSyVXbGsr19uIuEgxhX?=
 =?us-ascii?Q?K9IBHscZT7bCo5P+imeF+VoCntjF0IBzgFB0QmR2VeZpZHD0qGmc7fKSmmyo?=
 =?us-ascii?Q?h46ko0khq13Pp2ArYlmWTELG8A7H4Bq7LfS3EGrnHoRkjhMZ9HeWZ3f+ZpJp?=
 =?us-ascii?Q?INxA0YFAwpQX0LBa8GtRWL58zvwexg/7usVOzFu9Avjtnu5kVcTlZqyutgpF?=
 =?us-ascii?Q?5W3AkUV5MotdiZ7hNsSdX//wfmHW+wV8KKfzVrCZjwBSfIizULobCesgankr?=
 =?us-ascii?Q?+NOtjJdHrEqw0zIOzes6CjB/eW23++eC87TJTBPL87IENi8dhDeTAvViyRAo?=
 =?us-ascii?Q?uRRjX11CSDdyrGzcsYdc8aelwFBq3HWxe8tk0654tlW6aBp0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ece428-65ad-40e9-5bd2-08defa411b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 20:17:47.3768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2aVsKTJELIDp9dTxadDplJAhJBFqRBU4FbRX486q+lxwZjlDAu2ZUWjxjSgRNQUj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926
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

Right, it would be just doing the __xa_alloc with GFP_NOWAIT.
In that case, it can -ENOMEM, which I'd either need to retry or just fail
with -EBUSY or something.

I think that's still preferable to having to do the gem_change_handle dance

David

________________________________________
From: Francis, David <David.Francis@amd.com>
Sent: Friday, August 14, 2026 1:29 PM
To: Tvrtko Ursulin; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioct=
l

Wait, not idr_preload. Is there an xa_preload?

David

________________________________________
From: Francis, David <David.Francis@amd.com>
Sent: Friday, August 14, 2026 1:19 PM
To: Tvrtko Ursulin; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioct=
l

Thanks for the comments. Most of these are just mistakes on my part and wil=
l be fixed.

Regarding the locking,

on CHANGE,
> Same as for the list ioctl, GFP_KERNEL under the xa_lock will not work.
>
> You can have a look on how I've done it in "drm/amdgpu: Add context
> handle renaming operation" and see if you can punch some holes in my
> logic there?

I think the solution here is just to use idr_preload.
I'd rather hold the lock the whole time to avoid having to do the
dance from GEM_CHANGE_HANDLE.

in LIST
> GFP_KERNEL under xa_lock will not work.

This one is harder. I can shift around the allocations but the point
remains that if I don't hold the xa_lock the whole time
there's a chance that create / free / other modifications
of a queue's data will happen in the meantime.

I can avoid over-writing the end of the arrays / structs just by
re-checking that the array index never gets past the size of
the array, but that wouldn't protect about returning
corrupted data if LIST races another operation
(such as CHANGE_HANDLE).

I guess in that case it isn't a security risk and you could
say it's the user's fault for creating this race condition, but
I'd prefer that wasn't part of the interface.

Thanks,
David

________________________________________
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Sent: Thursday, August 13, 2026 4:48 AM
To: Francis, David; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioct=
l


On 11/08/2026 15:12, David Francis wrote:
> Add a new option to the USERQ ioctl, which is called with
> the queue_id of an existing user queue and an unused queue_id,
> and changes that queue's id to the new value.
>
> Calling with an invalid new handle will fail. Calling with new_handle
> =3Dhandle will succeed if that queue exists but not do anything.
>
> This operation holds userq_mutex and the userq_xa xa_lock for its
> entire duration.
>
> Performing this operation on a queue with signals or waits
> outstanding is fine, as those hold not the queue_id but a
> direct reference to the queue object.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 43 +++++++++++++++++++++++
>   include/uapi/drm/amdgpu_drm.h             | 17 +++++++--
>   2 files changed, 57 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 3c930425c1bb..b532ba0f4cef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -852,6 +852,11 @@ static int amdgpu_userq_input_args_validate(struct d=
rm_device *dev,
>               break;
>       case AMDGPU_USERQ_OP_LIST:
>               break;
> +     case AMDGPU_USERQ_OP_CHANGE_ID:
> +             if (!args->change_in.new_queue_id ||
> +                 args->change_in.new_queue_id > AMDGPU_MAX_USERQ_COUNT)
> +                     return -EINVAL;
> +             break;
>       default:
>               return -EINVAL;
>       }
> @@ -1012,6 +1017,41 @@ amdgpu_userq_list(struct drm_file *filp, union drm=
_amdgpu_userq *args)
>       return ret;
>   }
>
> +static int amdgpu_userq_change_id(struct drm_file *filp, union drm_amdgp=
u_userq *args)
> +{
> +     struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +     struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +     struct amdgpu_usermode_queue *queue;
> +     int ret =3D 0;
> +
> +     mutex_lock(&uq_mgr->userq_mutex);
> +     xa_lock(&uq_mgr->userq_xa);
> +
> +     queue =3D xa_load(&uq_mgr->userq_xa, args->change_in.queue_id);
> +     if (!queue) {
> +             ret =3D -ENOENT;
> +             goto unlock;
> +     }
> +
> +     if (args->change_in.new_queue_id =3D=3D args->change_in.queue_id) {

I would move this outside the lock or even consider returning -EINVAL.
Or you have a reason why returning success is handy? Probing what
exists? Why?

> +             ret =3D 0;
> +             goto unlock;
> +     }
> +
> +     ret =3D __xa_insert(&uq_mgr->userq_xa, args->change_in.new_queue_id=
, queue, GFP_KERNEL);

Same as for the list ioctl, GFP_KERNEL under the xa_lock will not work.

You can have a look on how I've done it in "drm/amdgpu: Add context
handle renaming operation" and see if you can punch some holes in my
logic there?

If that works question will be do you really need both the userq_mutext
and xa_lock or perhaps xa_lock would be enough throughout the series.

Regards,

Tvrtko

> +     if (ret) {
> +             ret =3D -EINVAL;
> +             goto unlock;
> +     }
> +
> +     __xa_erase(&uq_mgr->userq_xa, args->change_in.queue_id);
> +
> +unlock:
> +     xa_unlock(&uq_mgr->userq_xa);
> +     mutex_unlock(&uq_mgr->userq_mutex);
> +     return ret;
> +}
> +
>   bool amdgpu_userq_enabled(struct drm_device *dev)
>   {
>       struct amdgpu_device *adev =3D drm_to_adev(dev);
> @@ -1058,6 +1098,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void=
 *data,
>       case AMDGPU_USERQ_OP_LIST:
>               r =3D amdgpu_userq_list(filp, args);
>               break;
> +     case AMDGPU_USERQ_OP_CHANGE_ID:
> +             r =3D amdgpu_userq_change_id(filp, args);
> +             break;
>       default:
>               drm_dbg_driver(dev, "Invalid user queue op specified: %d\n"=
, args->in.op);
>               return -EINVAL;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 678f3d531df7..de9ae1296819 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -330,9 +330,10 @@ union drm_amdgpu_ctx {
>   };
>
>   /* user queue IOCTL operations */
> -#define AMDGPU_USERQ_OP_CREATE       1
> -#define AMDGPU_USERQ_OP_FREE 2
> -#define AMDGPU_USERQ_OP_LIST 3
> +#define AMDGPU_USERQ_OP_CREATE               1
> +#define AMDGPU_USERQ_OP_FREE         2
> +#define AMDGPU_USERQ_OP_LIST         3
> +#define AMDGPU_USERQ_OP_CHANGE_ID    4
>
>   /* queue priority levels */
>   /* low < normal low < normal high < high */
> @@ -463,10 +464,20 @@ struct drm_amdgpu_userq_list_in_out {
>       __u64   entries;
>   };
>
> +struct drm_amdgpu_userq_change_id_in {
> +     /** AMDGPU_USERQ_OP_CHANGE_ID */
> +     __u32   op;
> +     /** Queue id of some queue */
> +     __u32   queue_id;
> +     /** Queue id to change that queue to */
> +     __u32   new_queue_id;
> +};
> +
>   union drm_amdgpu_userq {
>       struct drm_amdgpu_userq_in in;
>       struct drm_amdgpu_userq_out out;
>       struct drm_amdgpu_userq_list_in_out list_in_out;
> +     struct drm_amdgpu_userq_change_id_in change_in;
>   };
>
>   /* GFX V11 IP specific MQD parameters */

