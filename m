Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B7FC5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 17:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B762C10F6E3;
	Fri, 14 Aug 2026 17:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RbXP64CV";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9401E10F6CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 17:19:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QiJlaJXqyQQNkT3j8zsxUqQdKdPFXW1pC85NaCKjRGB9mVMofm5nOumDalrce9TENzfFBdk6bGWFhGgykNNaiqBJqJd/8/ReORWHFmXpaWIRfswUGU3nnVodF74z13Jlgf+WCyXtM5Se1bAoLh/Ga4C+yXvxKwYf6AYpTijOJ5zG4owMU/BnWm/8MlbXIKwfXfXqw2Nel6oeSOOD2CHxmkzPrUtRwbBeKO+JzSNFUMGEFAsNLLO8QG3dDn0YpdHa4MSmyvoiI4WDpxvTLKc/6I9o8sEJfaQDYs1APopbdcQOZOpaJw5ZI5nHFPb/VpIJf5ZDlB4Sle53YyFwdpDsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SiyvOydZhcS92QQ3dLu1TF38V0ywNM5sRjCoSR0jCU=;
 b=pxyXCMp0QBa7EDNIgB2Djv3XO9LIsKiOsEKb8J7G5WjwwXl64d2sX7tgW+rV/+IlljkQWBzh8GndNzEd97HRu4WW00Im93sO2ezBRW5JB1sVBvHxVKiFWmny8aZySa/Fsxpk+pPx35hhNT3gHPCdEnr08ti3SqKHqs2EyMdJwYwcpTI6Je/wWJH5seVyjB3rniEdJD7qQKf3bMWZie5zHXCqD07QBqvGcVL0Jss7Luq5HBlbcb1QoouxmyNDJA7gdCUFjZUhl79N0/ISM1kmarbY//5o1+ZRSS4Xm+DxHMpaajdt6/JvrY4g59zoJwJi8JE5Xqs+Rz+guDPhbsI7WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SiyvOydZhcS92QQ3dLu1TF38V0ywNM5sRjCoSR0jCU=;
 b=RbXP64CVnexj0N2CFSaH8dW4C8gR7CSJzA0XebSf+omlI23FrhigTdetVdpV7/4iyjxCskvZC7scipuBrccJl5ZdoZNGxWlmc4G5AZ90M7fWDg5eNouFlHiFQknAEoj59ES7/3N/SqVdV5wzHsJxEI0TAgahh901lm2n10fiGLA=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 17:19:46 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 17:19:46 +0000
From: "Francis, David" <David.Francis@amd.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
Thread-Index: AQHdKZtuwKL0j23ih0iEndBGSlFyNLabrb0AgAIfOx4=
Date: Fri, 14 Aug 2026 17:19:46 +0000
Message-ID: <SA1PR12MB8144389F1595B105143C4913EFDA2@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260811141202.1633727-1-David.Francis@amd.com>
 <20260811141202.1633727-2-David.Francis@amd.com>
 <5ec5f320-d8d5-444e-8ed1-1412818ffd8b@igalia.com>
In-Reply-To: <5ec5f320-d8d5-444e-8ed1-1412818ffd8b@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-14T17:19:45.131Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|SJ2PR12MB8881:EE_
x-ms-office365-filtering-correlation-id: 2e750672-6a91-4f3c-020a-08defa283ced
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|3023799007|56012099006|10067099003|5023799004|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: NcL0XhYjolijkULMrV9BBziSaDuAgYWAY3A/kMwu2UGh8wTD75F3tTXChaWofoU2NsX+gKiKM8QbKLPfS+u3N6N6oWRZ2cE0M9cK6fy9NtK3ICJ+ruSHLsQZJvs6FHjOJHQr1UszxsGzDo6byH4lWNFr5R0j2M0UfVxa4K9R7/gA9vXIg4U/tfFQKZnMUdSuhI6Rx8P4/bRQCN3AwhW2N36s99OBF6ZH7qjTXTqNEzkn7sCHjF3p69pWZQf8GYYBEEgIp3xUxmxaRM82jaR6jKX0GHIB+7aGrDjG/uAwadjjvXSFxRA1vFlgjkPJybLC66n1GteKhkLelfEbNXjIWnGkZJ6QmwuxF9e/AfyHYDHnH9q/f7NY+oR+TjqOGjdzQlHkSCQUkFYKoUzsvBWYGvFEZkIug3RSHrYfqWhPlZZg/1cn3WyexKanLzQSFxfW0Nc9InAnnyM1pK+9OYPIGlamcM3Oh+bt2/jVNJZToVOZGD2fa7FV8O//oHIGtF8Q8NmL64s1RuK7cKAh9owMMPH+sO3EQsH/OGSr2JSajsjb1iD6Ixk3qxuhKkN6oBNoL8/hWWkKicLH26EqgPzrUi/qCvg7kH2IxgnK5zWBro/gZOmgsW92mdX/Q+31+n0EO1AfYttymZRxD0dyCVzzrg9cYJyyGQJFOAdvYQ/QCi4BfgLmGfWEqpYxvf9jA7EcBEIzJVLnfXeBjuJctBJKBjf+g6ED8QaZM145nPNxkUY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(3023799007)(56012099006)(10067099003)(5023799004)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p6p3ONSmXtj2/EtJypbqwF8MLVnqKW0CiL0Jbzi9ymvh5Gat8hS2EaaMjERO?=
 =?us-ascii?Q?c5Q/q1cH8bACO35ZwD3ufD0WOT5I1eHBXhAIL1lM3myKjOGVOUfbUCC6duFM?=
 =?us-ascii?Q?kytWe9BTyASG2N4GYkeFs4SflaRSMJqGH0NzRUzPb1wK1CTxrKwUN2zkiz59?=
 =?us-ascii?Q?SqFYfDWKT2GKHoWdo9ry3lWFYROPoyi8hWqgoX80aTL95NSzggKzGkgSTHOt?=
 =?us-ascii?Q?ZPUxi3O7JkfDqKgw607CNzc4o/Nb6THLU7wZHJzrLAd5cKzamxGeE9n4anhD?=
 =?us-ascii?Q?wRkbJ/z2x0fL6xGGwehySlK6CO5IARd/yOhAMGNEVU6HZb3eX8Lun1Qx86ur?=
 =?us-ascii?Q?5+Jiz/ZX5iBxLGY4n6WP58bQD1bdfdweEzLODDkkPNDUy6MPqcoMhNxEQcMJ?=
 =?us-ascii?Q?sIXkEKPZfLR+yPMZDAAwAkDNKNAv+Uklo26LoG18MD/FlHhbKgJwo89ORcA/?=
 =?us-ascii?Q?jPOL2OreCjvanWW101iTJwOr2AgVT7eivmie8d6ztUIMhl+iCjTDxXh0c9HM?=
 =?us-ascii?Q?x2tTwbcdRb4PCBj2gFSWjoBoWVQ4Q/7bEyG/rRPkr5GNzR9Q1OrutYyPnTaJ?=
 =?us-ascii?Q?t3tuDyT/5mIrU/zjkFLZoP90p1BD7WzPrBbMIwSerngdM+yZaqoHvcx16NMH?=
 =?us-ascii?Q?FCrJmzqpVh7potJtBlPY8sjl6NvHfqeXrjSDctP9hkUhmZZSPIawkNbRB/kN?=
 =?us-ascii?Q?XOorInA5uNNJPAeW7bqJTPsWI1hfj40oCWPLA3w3aVzkVlDxKKplIpupJobn?=
 =?us-ascii?Q?W0i++yDmeZG4/fm4LNdPFo4f5iL6FUY8zTNl3kQodDiWa+dKPLgXlemNmrg3?=
 =?us-ascii?Q?cHSi8gdxRAQscgAYGDF/Y3++8Jp6CHpT42W/7LdcPAyzpavyGs7t7LfNQf0E?=
 =?us-ascii?Q?UU3eo4amDLijgFGJaxyrs+hFSLgG9u8P3gCg30u2HRd8B4PhhMDa2f+x8uMU?=
 =?us-ascii?Q?aWY7nGvgoR6l11KKhcagbkkITDjfhuZ82giy6HzkYDO5egHaL/keuAsubnlN?=
 =?us-ascii?Q?Y21DgCtPo6filqpxPpLkdkVQb+yaUnzX8/aBFJ/6cMXObXBJ0okDTBzBHPuB?=
 =?us-ascii?Q?yv3CXGjgjAJ0T9NQ5fPecm1YqppIFLIw7CWrQ1Ok4rW6eSbGcmEnEmCIYb56?=
 =?us-ascii?Q?8sFNBm9zzsjJ6kpufqLQ6vzefT8kZK1UkexQHqTKB5FKxEHZzqmkeG/osGL4?=
 =?us-ascii?Q?XdkuN3GYS2dCyRhmAlhCJPeaW2j/y52ulbE/qV/6KvXS//kkvQcl5ZJ0fdf6?=
 =?us-ascii?Q?jgsGqXAHhP89HaQ+iUkFYL67a8909R+KDorlY/hDJKs1wdz7BWxwNSrdkzD9?=
 =?us-ascii?Q?tkecvYEiSRW0jQfDY/KE/PhAMQbHZa1LnAqfoCh6gziQq4c5AsaFdgZ+FjYs?=
 =?us-ascii?Q?PI09NHVwnTdVvGO+XbitJ2yHKGICtRPH44F601S50CrBMeItsPfX4A2TwHpE?=
 =?us-ascii?Q?1xpNUxWJ8rV0kZ40C703Or2DsknJHwqksav2oEumHCGpPKxn66C6eidfQcTA?=
 =?us-ascii?Q?/Zpm2BxdFtaTuJh2DnA1Vcl59bAfoNIH9v0UyqwVdcMJF0KKEY+YfI9b4iGE?=
 =?us-ascii?Q?El4j1Wl9P6zbPLAftPQbOPLfEEy26yy8jioLFgeldgpOJUcV43cbkeQZJst9?=
 =?us-ascii?Q?9cp6eCbRA0HQpCQP8Zl8SzfS4qm5AbGi2FG8pQPsbWFy+feELyPaVNn55rrC?=
 =?us-ascii?Q?5S2lxn/n4Rw+6rA82SpBMWRoEfZUIxUvRISAW56DZI0TZ/ZD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e750672-6a91-4f3c-020a-08defa283ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 17:19:46.0496 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RUnimNTtANHEqEjwRfmIDDqTpNeUj9oB0W5ElQxxjvKS30KiBqaxIf/lA5cAz1k3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
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

