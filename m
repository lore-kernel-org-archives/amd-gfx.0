Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83582C5CFE7
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 13:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0525A10EBED;
	Tue, 11 Aug 2026 13:48:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mjBh7J2h";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 699C910EBED
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 13:48:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3UuQDvOJ4HVgW+zrxuDIXiNtkxzWfs5+s6ARteAIkQRCY0Z64Qg2cxthOx8mamASbino/DSSqvzPjRyvPmzjkUnadaw6WNRnOJe045Wlst65CQFOHoGNSeRjP+x+lDO2lijBhji4XiXKtk+lyTkSS4xBy3VsQhl9EEaEBq95X0ZwRsD7sdzP9CFUpJ4Xlw1oDnLwy1xHazNY3kxUmkTMweMtXENPo9qoQbdfMehlwnrplxdJoa1vExrcQDiqaMHOCdvvL3ZmEVJMJrwaOE+rpKSDlvovaop1uz3/dH7ZwwhBgh/SNWDhRFXzFYjQJQLPFsswsFrs6PbVB/2VRqJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqmu7eaBNBP23y0+KFAVQB2+sp7mjX/ubMX/umNeZkM=;
 b=DaANQQifo4z+URq3duwmXXruww4uGbsBvbEBSHCCannyme/TtRwY912NjA23anPKIHqNJSzwXupfV4WFhveMSyxSlDGSUUcMkDLnVwG8fwUqwsAG5SxFD9KHwcaqEEOgXjMSuqWBL3Hd5T2ocN7eie5IdS0C+lGWVTGRztnjxJHaBHhl6BfuBllSD5gVBgORX9B5m57Kzsw+HDwInOnjwCRw99xTRw8iS9iqe/rcHKJMLHW8zK+wJuwr43+FZ94u3qdQwmSHbSFV79OMZwf2axU95uzk98NYAnfXMHgmmJRf2BUGSaltJtmRbMIU7oGs+ttr6Y/pv8L8xSgKkDZDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqmu7eaBNBP23y0+KFAVQB2+sp7mjX/ubMX/umNeZkM=;
 b=mjBh7J2h1ZCsOU1C1MjuP6yHaOonWebRkhxd0IDFWV6ZR86qIDqCMsKw/0sautIp+HyEirP6+qTCXrr6FWe6emZqJmvrbfpEiloZ5FUx9GENlMDvWkbhg51PDYNlijguYAJsWgrTqcSPR6+RhH4RE3mWHLSXHludJA5GWV9CTyk=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Tue, 11 Aug
 2026 13:48:33 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%4]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 13:48:33 +0000
From: "Francis, David" <David.Francis@amd.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: Add LIST option to USERQ ioctl
Thread-Topic: [PATCH 2/3] drm/amdgpu: Add LIST option to USERQ ioctl
Thread-Index: AQHdGtQ8Iy38kwkjD0uvlKBT9lJi9baPkuCAgAlnoVE=
Date: Tue, 11 Aug 2026 13:48:33 +0000
Message-ID: <SA1PR12MB814499D60E2B7E676785FC1EEFDD2@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260723185046.1239011-1-David.Francis@amd.com>
 <20260723185046.1239011-3-David.Francis@amd.com>
 <2cc4d324-e9a8-4044-b462-488b2647131f@igalia.com>
In-Reply-To: <2cc4d324-e9a8-4044-b462-488b2647131f@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-11T13:48:32.427Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|PH7PR12MB8055:EE_
x-ms-office365-filtering-correlation-id: 55eefcd0-9394-4d30-8ff6-08def7af3c08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|10067099003|6133799003|18002099003|22082099003|3023799007|4143699003|38070700021;
x-microsoft-antispam-message-info: g+CVV6XcKZbGHyhVoZvFBDHxUhy2l0Q8ie+tHz87l3Yno7xvsVyHel4MFNTjYASjRe+kLtia7esdYf0/0+ySWD8xZjquXtBx6NOAEDrT5CU/xXAUEIOg4AlaIvoRE0s1jjIvmggPtQ5P1G7kfsVzlO6mtFEKzIWxkMT8IkIo/9+SQV4FIxiTABixxr07XXCz7zOLwZE+TcZxZARUObbx6t6n77GtZsJaUtJt1RCiZk85V2M7BYL9R8gGQ14O+bVm82QYsoJ+j85QO/S17l+IMpSe1BRhRVJjlWPJrp04kpiZxmkJoNqH1FGxCIab3anmGppK+riAUAN6S09L6qrgNbNxWDNIb2wLuKWGO5mC0eDEKUsaOfhB5pPZcxCf+6gG/2gTVGZzAvLPtgrB5Pvchnohl3mX/HjphvCGOCDgCWk8PbQJllqYKUcv1C73RFBuSa2f5HP/CzGQ3/MruRNqzQVnPGo8qXJYgToSigZrWVqjotRh2wKdvhkqx8Hwc4m9vesrYg2XhI1fvIid5Ja+bS9aOz3hcsQyhPSOAbBNMVcNyzQiSVNIPPLsFzDET7Rlg6gmXLrXhXKgbb15DYkAUsiTw8TzRGgZ+FDy6LkTTcFJK5/g+B+jbPshv0BW2QfKyqqRzZUE2kNn2tgin8m697UaWyB3hnZrp32oaZ7DN3ezokpgu/kjw2qspGpLk2uIaNSp0mZhTKMkhJuqMNTOc6einjeaHFDW4e7CvqAmWlY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003)(3023799007)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sSyzlddhwhATQJamfqy4YJ6FAtdK9bjNRwicbTswGgUx+lkq4TsXv4MjFhOR?=
 =?us-ascii?Q?HlNvoEbnGaQniMfCrL0jLP4ZmCx/1fgic3CgoewVghJm+VXZ5mhB7/MFMUus?=
 =?us-ascii?Q?H7+VZdc3KXG2j/ggXupIi4+W/SBouKzWT/Pqped6wW82+1pqS+AiSm4zbmpm?=
 =?us-ascii?Q?22Ch3+pvb4K8TylnvTT9dulIm+7Hy0GKY+a76es8NMwUDkGBSFLVgvuzYv+H?=
 =?us-ascii?Q?xt+ZZuqyTFD5cNT0yEYfJ05efoyVM52tlcPezWYWS60gIy6Z1C5EuVg+cyxV?=
 =?us-ascii?Q?Xpk3Q4kj8LclFf5yQFJwzzw+6Lv6m0nqyLvo06GATFTKaSepQVh0pj/HFrHv?=
 =?us-ascii?Q?ihiY5J8deNxvz2h1Vhunewuo9Wa5Pr6m7EgBdnbv2dFHwrT500HWSM6Q1e4C?=
 =?us-ascii?Q?wRtXkMKQYVHBu7Th8AdsyOD87YWcJ05wup+WBMaO0O5PaYGvn0adoVL8njdP?=
 =?us-ascii?Q?YWshb2+1UgbtAnvDTOlkLmssZz/VYOvLcKw2uaJrs8lYLbQf45vzeQ5c+D14?=
 =?us-ascii?Q?U1zhbceAK07Z6d1uqNygZ3CuHCgPJavmWoNhusHDZMaHcHQDk7tk03gTcBtT?=
 =?us-ascii?Q?ihIQOZvBChXDn365qA+DPZmSZRjIq/SDJMkbngQY2r9hV3oYIUqlVkhcPbAc?=
 =?us-ascii?Q?/yVVaX69MN54xaM77+U+P61vHNs41+GiGbmR20KAHSNCayXCvHgS6GeVugFF?=
 =?us-ascii?Q?U5pil3UHAAx9JEQ+2pvz+0yDV8JJmmcPTHnSWb2j6d6zR4UXAi6KL8W1/hbs?=
 =?us-ascii?Q?kc2MS9pSPArlyA4mUi/d/YZCvRrM9I4mpk7qmZsZp12Qt2E3iwyeScU6J5Zy?=
 =?us-ascii?Q?zercYiBceRng2+R8IeGDiHpy0cSAlZUPLJ1g3OE4YMxZsQtkNyq2hjr0JebF?=
 =?us-ascii?Q?dU27jlOgkfCmJ4ECzhFdyKt7Ii3oK5TkL4WEmMz/nDq+Qqc8oWR3ElkUFFmh?=
 =?us-ascii?Q?QUazO9cDZOJCK5m10IJ73SLD4J3SbDWczzA6rGvwJVJZ/WOPs+s6sLdMbocO?=
 =?us-ascii?Q?ugoOB8CgxoIhQfo3yZah/CGdX+WWxnQ5Ff9ghc/9QnzEiQztSjkx4PzoE78r?=
 =?us-ascii?Q?BA5TWvltZI+gz3uqb4e7Qi4AKdR/xwdyrExtzfqScPPdrFlvvQlEnr+h1nSQ?=
 =?us-ascii?Q?c1sPKjVM1nAynmHm/IS3wLLvkrA2krA9zBJ7wWOr1ZSauhWUPP9wlYVSqk2s?=
 =?us-ascii?Q?PM/qJwQOKeE26seHYR3afLB0KuIQpAuszzmD5ZWw9vRyiZeSt+ynOifpWJcq?=
 =?us-ascii?Q?jk6/qkbPDQlmmysYtgPvf28uCXfCT9HAMY9kkz20+RwCtkOj1PkWd7L9fyqs?=
 =?us-ascii?Q?+mvE0S44cnw0J9v5jkBUiQVhTm+0RKhLRaSYfXaDxqUjLz8s27zeFbYUJ+vl?=
 =?us-ascii?Q?sM/Xeot6B8SLG96KC3hgTBCt5uYAw1iipmKyEH5/uedu5WjQmmmGYWas++NE?=
 =?us-ascii?Q?/NpAN+Al+AuaWtWQ+m/NypoqiAvZ4dORiz2nmTZc2Cm5GoplEtddSQ8ddB9F?=
 =?us-ascii?Q?L4NPV8a3ZSGEkg+zV1ptQFELmfiiiTbQmq7I2dy16SglrfBn6ER6r8hvOkNh?=
 =?us-ascii?Q?DcQKofJhK0NFmQ1/8XFOZ5EtC7LOB64FheRBgp7VdtnYoe6/ooG7guEgbRaV?=
 =?us-ascii?Q?PtULYl61UXzjZVFLRgLe/lGtYUawecnH4ZOhpGSy4kbF3KmZv7gda7YW9EgI?=
 =?us-ascii?Q?XDIPIki3oaINAaLUi6nkl3l1j+tX4AWJlkeXHBLP7tONTq+4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55eefcd0-9394-4d30-8ff6-08def7af3c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 13:48:33.1673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: atsXgUGP3kyTNsRiKguQsPPhVw8KaPkeuPQV983fifHhLaCwJfjWBHt8Yvy89TaR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055
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

>> +     size_t mqd_size;
>> +     uint32_t num_queues =3D 0;
>> +     int ret =3D 0;
>> +     int i =3D 0;

> On a glance ret does not need to be initialized and i would potentially
> be better done so above the first block which uses it, in order to match
> the pattern of the second user.

Thanks, fixed

>> +
>> +     mutex_lock(&uq_mgr->userq_mutex);

> Design question is whether there is any benefit from the mutex.
> Alternative could be to simply abort the attempt if the number of queues
> changed between counting to filling the data. For CRIU that's fine since
> everything will be idled. And for non-CRIU it doesn't matter since the
> by the time the query returns the data may be stale anyway.

> In which case not extending the scope of the mutex would simplify the
> previous patch and this one.

On reconsideration, I'm having both LIST and CHANGE_IF hold the
xa_lock for their entire duration, to avoid any shenanigans with
things being removed or created under them.

I am also having them hold the userq_mutex. I don't think this is
strictly necessary since a userq cannot be freed while it is in the
xa_array but no reason not to.

>> +             mutex_unlock(&uq_mgr->userq_mutex);
>> +             if (args->list_in_out.num_entries =3D=3D 0)
>> +                     return 0;
>> +             return -EINVAL;

> Why -EINVAL? It differs from the established practice from
> amdgpu_gem_list_handles_ioctl for example.

Thanks, Fixed.

>> +     entries =3D kvmalloc_array(num_queues, sizeof(*entries), GFP_KERNE=
L);

> kvmalloc_objs is preferred these days.

Thanks, fixed

>> +     ret =3D copy_from_user(entries, u64_to_user_ptr(args->list_in_out.=
entries),
>> +                          num_queues * sizeof(*entries));

> Multiplication can overflow on 32-bit so best would be to use
> check_mul_oveflow and stash the total size into a size_t local.

Thanks, fixed

>> +     xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>> +             mqd_size =3D 0;

> Move to else?
> ...
> Emit a warning and fail if unknown queue type is encountered?
> ...
> Why not break out?
>
> Or could you even merge this into the main xa_for_each below? Simply
> walk it and branch between good and bad mqd_sizes, each filling their
> respecive block.

I think there's enough shared handling for two ifs, but definitely close
Making invalid mqd type an error.

>> +             if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE)
>> +                     mqd_size =3D sizeof(struct drm_amdgpu_userq_mqd_co=
mpute_gfx11);

> Mention of gfx11 feels a bit out of place - how will this work for
future extensions?

Despite the names these are currently the structs for both gfx11 and gfx12
If gfx13 is different this will need to check for it somehow.

>> +                     ret =3D -EFAULT;
>> +             goto exit;

> So userspace gets a success but entries[] has only been partially
> filled? How is userspace expected to detect and handle that? By looking
> if any entry mqd_size returned different than the one it passed in?

Reconsidering this interface. Now, each entry is handled independently.
Some might have correct mqd and get filled while others have incorrect
mqd size and get just the size.

Seems the most consistent way.

>> +                     (queue->doorbell_index - amdgpu_bo_gpu_offset_no_c=
heck(queue->db_obj.obj) / sizeof(u32))
>> +                      / DIV_ROUND_UP(sizeof(u64), 4);

> What is the point of DIV_ROUND_UP here?

Whoops, fixed (and made this comment clearer)

>> +             if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
>> +                     struct drm_amdgpu_userq_mqd_compute_gfx11 compute_=
mqd =3D {0};

> =3D {} is preferred I think, or maybe better, all initializers in this
> blow and the ones below can be made at declaration time which would be a
> bit more compact.

Near as I can tell amdgpu uses {0}. They're the same thing in C as far as I=
 know.

>> +                     if (ret) {
>> +                             ret =3D -EFAULT;
>> +                             goto exit;
>> +                     }

> if (ret) etc block could be moved to a single one after the if-elseif-
ladder.

Thanks, fixed

>> +             if (r)
>> +                     drm_file_err(filp, "Failed to get list of usermode=
 queues\n");

> Drop this - we don't want to allow naughty userspace spam the kernel log
at will.

Thanks, fixed.

>> +     /** AMDGPU_USERQ_OP_LIST */
>> +     __u32   op;

> At first I wanted to ask what is this for, that it seems unused, but
> then I realized it is for..

> .. the union! And that the list_in_out.op is needed to match the exact
> position of in.op. A bit evil but I guess it works.

Agreed that this is slightly evil but it's what needs to be done.

________________________________________
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Sent: Wednesday, August 5, 2026 10:11 AM
To: Francis, David; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/amdgpu: Add LIST option to USERQ ioctl


On 23/07/2026 19:50, David Francis wrote:
> Add a new option to ioctl USERQ which provides information
> to a process about their own user queues on the queried
> device.
>
> The returned data is in the same format as that used to
> create the queue in the first place.
>
> The interface uses retries; the user first sends a request with
> num_entries 0, then receives the right number of entries.
> The same is done for the mqd sizes of each entry.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 159 ++++++++++++++++++++++
>   include/uapi/drm/amdgpu_drm.h             |  39 ++++++
>   2 files changed, 198 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index cfee7466ef44..b13ed7f8be7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -850,6 +850,8 @@ static int amdgpu_userq_input_args_validate(struct dr=
m_device *dev,
>                   args->in.mqd_size)
>                       return -EINVAL;
>               break;
> +     case AMDGPU_USERQ_OP_LIST:
> +             break;
>       default:
>               return -EINVAL;
>       }
> @@ -857,6 +859,158 @@ static int amdgpu_userq_input_args_validate(struct =
drm_device *dev,
>       return 0;
>   }
>
> +static int
> +amdgpu_userq_list(struct drm_file *filp, union drm_amdgpu_userq *args)
> +{
> +     struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +     struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +     struct drm_amdgpu_userq_list_entry *entries;
> +     struct amdgpu_usermode_queue *queue;
> +     bool mqd_sizes_correct =3D true;
> +     unsigned long queue_id;
> +     size_t mqd_size;
> +     uint32_t num_queues =3D 0;
> +     int ret =3D 0;
> +     int i =3D 0;

On a glance ret does not need to be initialized and i would potentially
be better done so above the first block which uses it, in order to match
the pattern of the second user.

> +
> +     mutex_lock(&uq_mgr->userq_mutex);

Design question is whether there is any benefit from the mutex.
Alternative could be to simply abort the attempt if the number of queues
changed between counting to filling the data. For CRIU that's fine since
everything will be idled. And for non-CRIU it doesn't matter since the
by the time the query returns the data may be stale anyway.

In which case not extending the scope of the mutex would simplify the
previous patch and this one.

> +
> +     xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +             num_queues +=3D 1;
> +     }
> +
> +     if (num_queues !=3D args->list_in_out.num_entries) {
> +             /**
> +              * If the num_entries is not the number of queues,
> +              * return the correct number. User should
> +              * try again with the right space allocated.
> +              */
> +             args->list_in_out.num_entries =3D num_queues;
> +             mutex_unlock(&uq_mgr->userq_mutex);
> +             if (args->list_in_out.num_entries =3D=3D 0)
> +                     return 0;
> +             return -EINVAL;

Why -EINVAL? It differs from the established practice from
amdgpu_gem_list_handles_ioctl for example.

> +     }
> +     if (num_queues =3D=3D 0) {
> +             mutex_unlock(&uq_mgr->userq_mutex);
> +             return 0;
> +     }
> +
> +     entries =3D kvmalloc_array(num_queues, sizeof(*entries), GFP_KERNEL=
);

kvmalloc_objs is preferred these days.

> +
> +     if (!entries) {
> +             mutex_unlock(&uq_mgr->userq_mutex);
> +             return -ENOMEM;
> +     }
> +
> +     ret =3D copy_from_user(entries, u64_to_user_ptr(args->list_in_out.e=
ntries),
> +                          num_queues * sizeof(*entries));

Multiplication can overflow on 32-bit so best would be to use
check_mul_oveflow and stash the total size into a size_t local.

> +
> +     if (ret) {
> +             ret =3D -EFAULT;
> +             goto exit;
> +     }
> +
> +     xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +             mqd_size =3D 0;

Move to else?

> +             /**
> +              * Check mqd size. As with num_entries, return the right si=
zes
> +              * if they are not correct. These sizes also serve as
> +              * versioning for the mqd.
> +              */
> +             if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE)
> +                     mqd_size =3D sizeof(struct drm_amdgpu_userq_mqd_com=
pute_gfx11);

Mention of gfx11 feels a bit out of place - how will this work for
future extensions?

> +             else if (queue->queue_type =3D=3D AMDGPU_HW_IP_GFX)
> +                     mqd_size =3D sizeof(struct drm_amdgpu_userq_mqd_gfx=
11);
> +             else if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA)
> +                     mqd_size =3D sizeof(struct drm_amdgpu_userq_mqd_sdm=
a_gfx11);

Emit a warning and fail if unknown queue type is encountered?

> +
> +             if (mqd_size !=3D entries[i].mqd_size) {
> +                     mqd_sizes_correct =3D false;
> +                     entries[i].mqd_size =3D mqd_size;
> +                     entries[i].ip_type =3D queue->queue_type;

Why not break out?

Or could you even merge this into the main xa_for_each below? Simply
walk it and branch between good and bad mqd_sizes, each filling their
respecive block.

> +             }
> +             i +=3D 1;
> +     }
> +     if (!mqd_sizes_correct) {
> +             ret =3D copy_to_user(u64_to_user_ptr(args->list_in_out.entr=
ies), entries,
> +                                num_queues * sizeof(*entries));
> +             if (ret)
> +                     ret =3D -EFAULT;
> +             goto exit;

So userspace gets a success but entries[] has only been partially
filled? How is userspace expected to detect and handle that? By looking
if any entry mqd_size returned different than the one it passed in?

> +     }
> +     i =3D 0;
> +     xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +             entries[i].queue_id =3D queue_id;
> +             entries[i].ip_type =3D queue->queue_type;
> +             /* userq prop handling */
> +             entries[i].queue_va =3D queue->userq_prop->hqd_base_gpu_add=
r;
> +             entries[i].queue_size =3D queue->userq_prop->queue_size;
> +             entries[i].rptr_va =3D queue->userq_prop->rptr_gpu_addr;
> +             entries[i].wptr_va =3D queue->userq_prop->wptr_gpu_addr;
> +             /* flag handling (AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_=
MASK is the only flag in use) */
> +             entries[i].flags =3D (queue->priority << AMDGPU_USERQ_CREAT=
E_FLAGS_QUEUE_PRIORITY_SHIFT)
> +                     & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK;
> +             /* doorbell handling */
> +             entries[i].doorbell_handle =3D queue->doorbell_handle;
> +             /* This is the inverse of the calculation used in amdgpu_us=
erq_get_doorbell_index */
> +             entries[i].doorbell_offset =3D
> +                     (queue->doorbell_index - amdgpu_bo_gpu_offset_no_ch=
eck(queue->db_obj.obj) / sizeof(u32))
> +                      / DIV_ROUND_UP(sizeof(u64), 4);

What is the point of DIV_ROUND_UP here?

> +
> +             if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
> +                     struct drm_amdgpu_userq_mqd_compute_gfx11 compute_m=
qd =3D {0};

=3D {} is preferred I think, or maybe better, all initializers in this
blow and the ones below can be made at declaration time which would be a
bit more compact.

> +
> +                     compute_mqd.eop_va =3D queue->userq_prop->eop_gpu_a=
ddr;
> +
> +                     ret =3D copy_to_user(u64_to_user_ptr(entries[i].mqd=
_data),
> +                                        &compute_mqd,
> +                                        entries[i].mqd_size);
> +
> +                     if (ret) {
> +                             ret =3D -EFAULT;
> +                             goto exit;
> +                     }

if (ret) etc block could be moved to a single one after the if-elseif-
ladder.

> +             } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) {
> +                     struct drm_amdgpu_userq_mqd_gfx11 mqd_gfx_v11 =3D {=
0};
> +
> +                     mqd_gfx_v11.shadow_va =3D queue->userq_prop->shadow=
_addr;
> +                     mqd_gfx_v11.csa_va =3D queue->userq_prop->csa_addr;
> +
> +                     ret =3D copy_to_user(u64_to_user_ptr(entries[i].mqd=
_data),
> +                                        &mqd_gfx_v11,
> +                                        entries[i].mqd_size);
> +                     if (ret) {
> +                             ret =3D -EFAULT;
> +                             goto exit;
> +                     }
> +             } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA) {
> +                     struct drm_amdgpu_userq_mqd_sdma_gfx11 mqd_sdma_v11=
 =3D {0};
> +
> +                     mqd_sdma_v11.csa_va =3D queue->userq_prop->csa_addr=
;
> +
> +                     ret =3D copy_to_user(u64_to_user_ptr(entries[i].mqd=
_data),
> +                                        &mqd_sdma_v11,
> +                                        entries[i].mqd_size);
> +                     if (ret) {
> +                             ret =3D -EFAULT;
> +                             goto exit;
> +                     }
> +             }
> +             i +=3D 1;
> +     }
> +     ret =3D copy_to_user(u64_to_user_ptr(args->list_in_out.entries), en=
tries,
> +                        num_queues * sizeof(*entries));
> +     if (ret) {
> +             ret =3D -EFAULT;
> +             goto exit;
> +     }
> +exit:
> +     mutex_unlock(&uq_mgr->userq_mutex);
> +     kvfree(entries);
> +     return ret;
> +}
> +
>   bool amdgpu_userq_enabled(struct drm_device *dev)
>   {
>       struct amdgpu_device *adev =3D drm_to_adev(dev);
> @@ -901,6 +1055,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void=
 *data,
>
>               amdgpu_userq_put(queue);
>               break;
> +     case AMDGPU_USERQ_OP_LIST:
> +             r =3D amdgpu_userq_list(filp, args);
> +             if (r)
> +                     drm_file_err(filp, "Failed to get list of usermode =
queues\n");

Drop this - we don't want to allow naughty userspace spam the kernel log
at will.

> +             break;
>       default:
>               drm_dbg_driver(dev, "Invalid user queue op specified: %d\n"=
, args->in.op);
>               return -EINVAL;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index b32c72a662b6..678f3d531df7 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -332,6 +332,7 @@ union drm_amdgpu_ctx {
>   /* user queue IOCTL operations */
>   #define AMDGPU_USERQ_OP_CREATE      1
>   #define AMDGPU_USERQ_OP_FREE        2
> +#define AMDGPU_USERQ_OP_LIST 3
>
>   /* queue priority levels */
>   /* low < normal low < normal high < high */
> @@ -425,9 +426,47 @@ struct drm_amdgpu_userq_out {
>       __u32 _pad;
>   };
>
> +struct drm_amdgpu_userq_list_entry {
> +     /** Definitions same as drm_amdgpu_userq_in */
> +     __u32   queue_id;
> +     __u32   ip_type;
> +     __u32   doorbell_handle;
> +     __u32   doorbell_offset;
> +     __u32   flags;
> +     __u64   queue_va;
> +     __u64   queue_size;
> +     __u64   rptr_va;
> +     __u64   wptr_va;
> +     /** Userspace pointer to buffer holding mqd */
> +     __u64   mqd_data;
> +     /**
> +      *  In: Size of mqd_data user-allocated buffer.
> +      *  Out: If mqd_data was insufficiently large, the
> +      * size it needs to be.
> +      */
> +     __u64   mqd_size;
> +};
> +
> +struct drm_amdgpu_userq_list_in_out {
> +     /**
> +      * For operation AMDGPU_USERQ_OP_LIST: User will provide a buffer, =
which the
> +      * driver will fill with information about all of that process's qu=
eues on this device.
> +      */
> +     /** AMDGPU_USERQ_OP_LIST */
> +     __u32   op;

At first I wanted to ask what is this for, that it seems unused, but
then I realized it is for..

> +     /**
> +      * Size of entries buffer / Number of handles in process
> +      * (if larger than size of buffer, must retry)
> +      */
> +     __u32   num_entries;
> +     /* User pointer to array of drm_amdgpu_userq_list_entry */
> +     __u64   entries;
> +};
> +
>   union drm_amdgpu_userq {
>       struct drm_amdgpu_userq_in in;
>       struct drm_amdgpu_userq_out out;
> +     struct drm_amdgpu_userq_list_in_out list_in_out;

.. the union! And that the list_in_out.op is needed to match the exact
position of in.op. A bit evil but I guess it works.

Regards,

Tvrtko

>   };
>
>   /* GFX V11 IP specific MQD parameters */

