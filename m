Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01CCC9830E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 13:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3971210FA90;
	Fri, 25 Sep 2026 13:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2pTfhFQD";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 261D710FAB9
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 13:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysC+DQQhaMWh0MxzcMyoVjOzu/mpHrXkpkbMQbdlSKZ4WbeYrFQzySZV+maG9oqdqRwA70gWMtLCue23/SWbzmjhPq0YSymP/SvW2V8S4b3aXjtwnicdLg0DR4Tgaj7koMM0OZHjNHXtRvsmQFdwc25zV8Gzhzuvu1+h2eeqS2tR2ju341gpLfYMRTX2PQ7L/zYre4wxQco5YJSF72GDV5Vqsf4EQus3nWZpvDva0Xd/WJaybDkD2cqmkXaCUXQJ+T1L8ocmmJgeqO8dhjdyIxv+OiC6AhIhYrXNigAPnPaLgm8xG4Zv0rsuZEC687iYfJb3HA1bR1GYjEGBr3Rt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YZMPgypLI27TY6Bkj+41Ze8JSxZX3aXmcSrtU+vnlM=;
 b=AXAXsWW42mjdtuYne501cam85pZXOW5F1bUzCe8R7zUnMauaaT/VCSAa7DjpvUS0f8MrVgw1K8nG8K9OC5cL3sIwKaM8AOg5PyECW7bZwruDqTM8lrWpn9qV0fjWnMZy5kCuy89+iiCFB6kvfPpPx/myElkIBZXb249LDWUYKVbVRkbXy/v+Oj3zufF5s0nLKIDChNfhfE21FYLDRq3rbJbHc1RS8mOI5z0E3HV2dwgHNXJfXzZSg7Ef/b4B+G2BASdBvLh43laC1UhW3sAloGjiZ12jRYye1ypaMNJyWryTkYwtHYs3XJMSaNM8KmBc9g+d5+K32O7MK6H0c2GL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YZMPgypLI27TY6Bkj+41Ze8JSxZX3aXmcSrtU+vnlM=;
 b=2pTfhFQD6GWtVOBkcmrqlE2UqPBDD2VkNXbrWmKeKjFI0m3hpguLW9tvO1AR7trtG50bGd8yLmYo+SpdVsBoy4c3xEyb8H8ZoJCzriLtvYl7zDwP4KEz6YuT9RyVMfEewUgWFnOeRAJZGtFnyghKn6p1G1phKceEnJ1XfuqVZH4=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:22:54 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:22:53 +0000
From: "Francis, David" <David.Francis@amd.com>
To: list amd-gfx <amd-gfx@lists.freedesktop.org>
Subject: Fw: [PATCH v4 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
Thread-Topic: [PATCH v4 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
Thread-Index: AQHdS5IO566v2GYddkyHE4idtouFCbbfL9iAgAAa6n0=
Date: Fri, 25 Sep 2026 13:22:53 +0000
Message-ID: <SA1PR12MB81442B9DDAD4ADF35107E9AAEF802@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260923193035.1148578-1-David.Francis@amd.com>
 <20260923193035.1148578-2-David.Francis@amd.com>
 <2c3e1ab8-cffb-4706-add4-fdfae29b36c6@igalia.com>
In-Reply-To: <2c3e1ab8-cffb-4706-add4-fdfae29b36c6@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-25T13:22:53.064Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|SA0PR12MB7004:EE_
x-ms-office365-filtering-correlation-id: 88d32252-0685-4c51-a427-08df1b081b23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|3023799007|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: 5EUov9sqXOZld7EaXT8xoOq4of3kz6GCuQqYwuUBzilv473Qhh2JXWdwbQsFpyH3wY3Qihd7un9c3uqQ721YxIDRUNTyGG4WbSCtOqj4x35ojt3LSZpmajO5S45Ms5nExoSc8Qh4vZReWzqMPRFXdNmrINEO88EQeWOp5PlGIMdF+TxDtyqry+Qnt46vZ9KPFRIG5b/35LbXfRsXQME9MqIV+umzHVvTt+7Kul+fl9idT9X8/B3KPwJc8nmnkeWrP5AElj42l3oaEi3tolUzpm5MtlIVY6Slusfs21NzJmN2WA0toHDiLlzonCiV5psm7HO+wvv2xjkdt27k0Bp0y1pKFMwv/cPiHZKCCCDxXjzVMwDRfGYYaGQgK3VZ2J1MPy3guMJOvz4Tr9P8DkccE0mQC8xqhJxeklpjRHtsn6r1QsQAj7SzzJr3M+aELi7Mnos23jMZM+PPeWuegIcaGA+OrFHTj3iSxmDBeRzImgEc335vmNxmLbrsf/oZFIfZjhkC9pVsifdtzJGIpdLizGeuw6wWGowTPxObWz7BC6ucBD8ByOayKyqgYeNY1d5evpAOKx1hBqpTYIkwrqCtTYHHaVd21Elib3oZhK9ljqOHXqo1W6kNsuoTKYTt1udZpl+rGAyhIdklUJ3ZgUeNhlLf1VVdS5UGQBMLO/Lv4+tacVzhd+C218IQkfDbs6KKENMc8Oh5lqF5Yl6H+pT3zg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?khC1I9r3Tv4/66+Qd8Cq1inaDsLIcGnF7+aMDCLSqa6qpKbmRUOIe0L4WU?=
 =?iso-8859-1?Q?UpwC6dauTSv+vtVetoQbCWXC07a0K2hNbJesVi3OX06jcoHJO7MLokRgEs?=
 =?iso-8859-1?Q?ChKgRkmkfgmQyq7GIQn4Jyr15FatdkwJ7uKB1tSC48hLMhLA/BHMK0N1JF?=
 =?iso-8859-1?Q?JNyCuUq0ij9+X1Rs91+87pdtGrVMUL90ECwtEMj1UpaHOrZmTOdjJ3P6QI?=
 =?iso-8859-1?Q?ubYzW2jf0C3JemeKliyeJ5nLpToxa0mp9BYpsveeEwJOLkIspn479sRMFq?=
 =?iso-8859-1?Q?c+6gsbMsJDf5rfdw25c0vEm64cX/KZQmpSYM12t9rS1cwH83fKTpGrI4Gn?=
 =?iso-8859-1?Q?yDtzy2tmx9I/GeurWB+l4W1sZSaGoIW//lVZKApMfzFLs+lMzRNBP2Qhuv?=
 =?iso-8859-1?Q?m9RPyFhPM64rfyvwb+UXJ600Wen+oQPdw46lFaqyclZjd1TlPrRHHsUiLk?=
 =?iso-8859-1?Q?XZ7yiGlzHCRYSNay0lY8VyxrUo7B/PFe+4NCCMrQYNuxOB8DlxjH4nloGG?=
 =?iso-8859-1?Q?bEBGWJR13JURF0YQFxjyGqOwr9O0d1JdLLHBJ2tnj3AfEAc4/4ge05v3ku?=
 =?iso-8859-1?Q?Z+GlM2p1tU3tSBrzL88pkiZmOGDc1OggM9qRe5Sji/hWRYqDlUcnMUvJtG?=
 =?iso-8859-1?Q?0LDGKE/tzywwhreGgrlaqIu1VxIOTDaNuttBNzzPIXEfUgme9Obp6FNX0/?=
 =?iso-8859-1?Q?++1JFqry3g/hLfYUWAkJUDMtKTbE0zUyYn8Mh5izVQNsxE1RqL64V7y+uK?=
 =?iso-8859-1?Q?QFcXRkBsSKcvp/tvLP6lqexH7/B+Pm80HAAypM3fbkyzVG8WDUQDHHYsb1?=
 =?iso-8859-1?Q?i8iUPO4zsJo7Dlm1DsxV3lpJQxfproPCCs5ETrprB+V/3FovjM3a8kxNEu?=
 =?iso-8859-1?Q?K/6rgLfabG8cujzST0cP5YRj0HjHty9qvCQdpMfMLBwRfVYUBM07zSD5kp?=
 =?iso-8859-1?Q?8sgIK+SZtBNFqGgQ7PmPd5Z6MVFRe4iExS3UILTrJ/Dyzuu5m2dkc0heZ4?=
 =?iso-8859-1?Q?G4Svfu73IjAd2kJ4fShvlsNwg3grd9a+84HDq1PJg0L3x++mzbG3gl7BGo?=
 =?iso-8859-1?Q?U/hLSCK2PwYvJ/lD9hCfYh6QNkmScKuIIg1+PsaOVxn1x8vToTbleeV1G7?=
 =?iso-8859-1?Q?CMoydNLxhN1qKzJRUWaBozo/hNne6GJ140XqZLnYpfIrDRQGuWh3+BM95N?=
 =?iso-8859-1?Q?DPIQCwx9/wzitm5W99SBr/NrGbbMICPpnubz7MTwJFjtRR03NpgsqpTjUz?=
 =?iso-8859-1?Q?RwL0mEsu8/ZmysVEevPSsgimZP+YBVIPwz9ECnjusFzLW54AL8DMu0JOaf?=
 =?iso-8859-1?Q?t2Sx81dA1UPmWQZDDUOMaukgT4jpuJ+ll2gjRgMk71t4XiuJB1R8LmtFTY?=
 =?iso-8859-1?Q?E9t3d3UwoKQs5h/whd2s78oHJUZXDPKxCEhIoKXU03X5vi/l2M4xhUnX8R?=
 =?iso-8859-1?Q?ypyX1YfJJtEJ8qNwlwdBzT1TRCJyfK35/gHjdemcDxMnKie1tXHLTsd9++?=
 =?iso-8859-1?Q?87lax53LYPZNxMF/k414u8UpSU2XgQzry+Semd6l2NdnsGBYEIHt5O4r8V?=
 =?iso-8859-1?Q?+0buur9e1BbktsAYLdloUhN/n8AicgLkDgtFYXxocB1+t2HQvSqhCf5/Mv?=
 =?iso-8859-1?Q?dhfXP2JCjl21PqL1HSWwsdqnRN/Ri/krWnKuhtXByiUWdWoUJgQ0k685op?=
 =?iso-8859-1?Q?3Dx+Ha62U3+5YQluhYo12J+2uNI4R4eJIVCft7HgCGtmXdlqmB9rrWXdbs?=
 =?iso-8859-1?Q?1hyoDb6iJzPgS+JP+BlXmuRMPwdslM3SpqDt+r/10l/91f?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d32252-0685-4c51-a427-08df1b081b23
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 13:22:53.8316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EuUpDUxacinJU3F/yPVEyr8xb9HxiS767fPFNc1fafBlbQ8PECzNscRCraQDMQf1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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

=0A=
(mistyped mailing list)=0A=
=0A=
________________________________________=0A=
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>=0A=
Sent: Friday, September 25, 2026 7:46 AM=0A=
To: Francis, David; amd-gfc@lists.freedesktop.org=0A=
Subject: Re: [PATCH v4 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioct=
l=0A=
=0A=
=0A=
[Side note - you mistyped the mailing list address in this round.]=0A=
=0A=
On 23/09/2026 20:30, David Francis wrote:=0A=
> Add a new option to the USERQ ioctl, which is called with=0A=
> the queue_id of an existing user queue and an unused queue_id,=0A=
> and changes that queue's id to the new value.=0A=
>=0A=
> Calling with an invalid new handle will fail. Calling with new_handle=0A=
> =3D handle will succeed if that queue exists but not do anything.=0A=
>=0A=
> Performing this operation on a queue with signals or waits=0A=
> outstanding is fine, as those hold not the queue_id but a=0A=
> direct reference to the queue object.=0A=
>=0A=
> v3: Poison queue and misc fixes=0A=
> v4: Using xas interface=0A=
>=0A=
> Signed-off-by: David Francis <David.Francis@amd.com>=0A=
> ---=0A=
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 49 +++++++++++++++++++++++=
=0A=
>   include/uapi/drm/amdgpu_drm.h             | 17 ++++++--=0A=
>   2 files changed, 63 insertions(+), 3 deletions(-)=0A=
>=0A=
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c=0A=
> index 9338f6f4cc5f..d2ac797dcb7f 100644=0A=
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c=0A=
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c=0A=
> @@ -852,6 +852,11 @@ static int amdgpu_userq_input_args_validate(struct d=
rm_device *dev,=0A=
>               break;=0A=
>       case AMDGPU_USERQ_OP_LIST:=0A=
>               break;=0A=
> +     case AMDGPU_USERQ_OP_CHANGE_ID:=0A=
> +             if (!args->change_in.new_queue_id ||=0A=
> +                 args->change_in.new_queue_id > AMDGPU_MAX_USERQ_COUNT)=
=0A=
> +                     return -EINVAL;=0A=
> +             break;=0A=
>       default:=0A=
>               return -EINVAL;=0A=
>       }=0A=
> @@ -995,6 +1000,47 @@ amdgpu_userq_list(struct drm_file *filp, union drm_=
amdgpu_userq *args)=0A=
>       return ret;=0A=
>   }=0A=
>=0A=
> +static int amdgpu_userq_change_id(struct drm_file *filp, union drm_amdgp=
u_userq *args)=0A=
> +{=0A=
> +     struct amdgpu_fpriv *fpriv =3D filp->driver_priv;=0A=
> +     struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;=0A=
> +     XA_STATE(xas, &uq_mgr->userq_xa, args->change_in.new_queue_id);=0A=
> +     struct amdgpu_usermode_queue *queue;=0A=
> +     int ret;=0A=
> +=0A=
> +     if (args->change_in.new_queue_id =3D=3D args->change_in.queue_id) {=
=0A=
> +             if (xa_load(&uq_mgr->userq_xa, args->change_in.queue_id))=
=0A=
=0A=
If you insist.=0A=
=0A=
> +                     return 0;=0A=
> +             return -ENOENT;=0A=
> +     }=0A=
> +=0A=
> +     do {=0A=
> +             xas_lock(&xas);=0A=
> +=0A=
> +             queue =3D xa_load(&uq_mgr->userq_xa, args->change_in.queue_=
id);=0A=
> +             if (!queue) {=0A=
> +                     ret =3D -EINVAL;=0A=
> +                     goto unlock;=0A=
> +             }=0A=
> +=0A=
> +             if (xas_load(&xas)) {=0A=
> +                     ret =3D -EBUSY;=0A=
> +                     goto unlock;=0A=
> +             }=0A=
> +=0A=
> +             xas_store(&xas, queue);=0A=
> +             ret =3D xas_error(&xas);=0A=
> +             if (ret)=0A=
> +                     goto unlock;=0A=
> +=0A=
> +             __xa_erase(&uq_mgr->userq_xa, args->change_in.queue_id);=0A=
> +     unlock:=0A=
=0A=
I think labels always go to column zero but please double check with=0A=
checkpatch.=0A=
=0A=
> +             xas_unlock(&xas);=0A=
> +     } while (xas_nomem(&xas, GFP_KERNEL));=0A=
=0A=
Yep - this loop should work accordinging to my understanding.=0A=
=0A=
> +=0A=
> +     return ret;=0A=
> +}=0A=
> +=0A=
>   bool amdgpu_userq_enabled(struct drm_device *dev)=0A=
>   {=0A=
>       struct amdgpu_device *adev =3D drm_to_adev(dev);=0A=
> @@ -1041,6 +1087,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void=
 *data,=0A=
>       case AMDGPU_USERQ_OP_LIST:=0A=
>               r =3D amdgpu_userq_list(filp, args);=0A=
>               break;=0A=
> +     case AMDGPU_USERQ_OP_CHANGE_ID:=0A=
> +             r =3D amdgpu_userq_change_id(filp, args);=0A=
> +             break;=0A=
>       default:=0A=
>               drm_dbg_driver(dev, "Invalid user queue op specified: %d\n"=
, args->in.op);=0A=
>               return -EINVAL;=0A=
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h=0A=
> index 92738d630eea..37d0efd1eda4 100644=0A=
> --- a/include/uapi/drm/amdgpu_drm.h=0A=
> +++ b/include/uapi/drm/amdgpu_drm.h=0A=
> @@ -330,9 +330,10 @@ union drm_amdgpu_ctx {=0A=
>   };=0A=
>=0A=
>   /* user queue IOCTL operations */=0A=
> -#define AMDGPU_USERQ_OP_CREATE       1=0A=
> -#define AMDGPU_USERQ_OP_FREE 2=0A=
> -#define AMDGPU_USERQ_OP_LIST 3=0A=
> +#define AMDGPU_USERQ_OP_CREATE               1=0A=
> +#define AMDGPU_USERQ_OP_FREE         2=0A=
> +#define AMDGPU_USERQ_OP_LIST         3=0A=
> +#define AMDGPU_USERQ_OP_CHANGE_ID    4=0A=
>=0A=
>   /* queue priority levels */=0A=
>   /* low < normal low < normal high < high */=0A=
> @@ -464,10 +465,20 @@ struct drm_amdgpu_userq_list_in_out {=0A=
>       __u64   entries;=0A=
>   };=0A=
>=0A=
> +struct drm_amdgpu_userq_change_id_in {=0A=
> +     /** AMDGPU_USERQ_OP_CHANGE_ID */=0A=
> +     __u32   op;=0A=
> +     /** Queue id of some queue */=0A=
> +     __u32   queue_id;=0A=
> +     /** Queue id to change that queue to */=0A=
> +     __u32   new_queue_id;=0A=
> +};=0A=
> +=0A=
>   union drm_amdgpu_userq {=0A=
>       struct drm_amdgpu_userq_in in;=0A=
>       struct drm_amdgpu_userq_out out;=0A=
>       struct drm_amdgpu_userq_list_in_out list_in_out;=0A=
> +     struct drm_amdgpu_userq_change_id_in change_in;=0A=
>   };=0A=
>=0A=
>   /* GFX V11 IP specific MQD parameters */=0A=
=0A=
Looks good to me, assuming checkpatch is either happy or fixed.=0A=
=0A=
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>=0A=
=0A=
We cannot merge it though without userspace and an IGT. Would you like=0A=
me to re-post my IGT series so you can add userq tests to it?=0A=
=0A=
It would also be cool to progress the reviews on my render node amdgpu,=0A=
IGT and CRIU patches.=0A=
=0A=
Regards,=0A=
=0A=
Tvrtko=0A=
=0A=
