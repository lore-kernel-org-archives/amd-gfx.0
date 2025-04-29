Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187B8C3ABA9
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 09:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 975CE10E410;
	Tue, 29 Apr 2025 09:49:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PaFdxpSe";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A25710E42D
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 09:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2LQkg6gMZbiv86DvmFXpf5cEfZztXfKTtbO+oNkGW4gXvbbt/wiTvS5p7JxSrZx1huELDBldfLwrvx302yiNZ/ti/i7OSPhYFTI5osmu4ISWxiaUk7hdTw+LS8LbTf9eGhE6xnyaXM3was3uOjy57wr7m72o1my+9soRJjomgD9S3sUXJQD8bAHWPy0Jg1816FEkimFBEyKk74S80mbb338Gs9u5CM05oTZUwLWOuSkpIdMv+a+bhpJPphDdVEC/l1Z9J1OF/s410ZLc2u6wQu51tIURB9pvBUwFOEEJziOFy+jsdpVhfjotjhQh6F2953LOBO/mubOz2tyY1YjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRu1jeezsGROaWD87DpfGQGuIq6av7SMGrO7ERjRmes=;
 b=QWSFq0JDQVM9bcl2LcSQjRRS/UT0vHrH2SDkkeb9o28w5qdOjUXK2CxNeo5refUMJJugb7weKjO815OcjjKQdqYlDJQJXWlh7TGXDi5ZiWIpt7fZtAWbAE2mS+6+1Ka55MjeS7EiWW1sW5UEZRGyK6gENasoRmLKXjiftEYFjLYG+kNH9IsKDElT02AspRZqnb3g0uo5fXKL1qxOvPLcepT1rlt2Lq08Ny+Q5L1Z3JNxG3FJah/uaF1wZkj+wLtTjc0zWJhTaj2yknBz3ccuc15loxz5Y/Wg1gdt15JdLnbWjB1iXxBmepkbnk3MaltUS86ywn1TnCn1eq0LRs6IBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRu1jeezsGROaWD87DpfGQGuIq6av7SMGrO7ERjRmes=;
 b=PaFdxpSeDyq7pM+9/a7UBa+FBzwgHjXNcyzc/6hi7YATwfcPj0xlyPhTst28X0OC7TAqoj5kw32lYG4QN2MwzqYZUZTAPyjKnygIw1oWDxkbej9FYDO1EHbJIaLavP/Sba6gwcM7rQ/8eh8VyjclLh5rnbkwAT5muqH9j2VrMWE=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 09:49:23 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::e175:f839:8e2e:2885]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::e175:f839:8e2e:2885%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 09:49:23 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH 2/2] amd/amdkfd: Trigger segfault for early userptr
 unmmapping
Thread-Topic: [PATCH 2/2] amd/amdkfd: Trigger segfault for early userptr
 unmmapping
Thread-Index: AQHbtZMcy7wt5j1hfEuN6a2cHqXuELO6bJWA
Date: Tue, 29 Apr 2025 09:49:23 +0000
Message-ID: <DM4PR12MB5261106CD68F907970BDB66C9D802@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20250425033513.1535517-1-shane.xiao@amd.com>
 <20250425033513.1535517-2-shane.xiao@amd.com>
In-Reply-To: <20250425033513.1535517-2-shane.xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=1144e7af-d373-4f65-a0d9-1eb804d23d77;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-29T09:48:46Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|CY8PR12MB8412:EE_
x-ms-office365-filtering-correlation-id: 40078893-1b99-4737-4e1c-08dd87031f07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bOpBIh4/+MptzNuUPr3POlYBarVMUmoPCSbc+y3jEqhy4geeT13zB7GSqFCT?=
 =?us-ascii?Q?YkdWm5o/++tvGaoOiDp1VvdaNXIjTqyYcjq5aIb866eFaTwWjg2uMdthaZoM?=
 =?us-ascii?Q?pIelsnu3CSFWj/pPpA3kPacCg/YQpTEV5MSDDrlkMDAsg+9AXf8Ki0ZaDZWJ?=
 =?us-ascii?Q?XH7iTYu/7Irq9bJbHU78eZtxLLf4THlSmsAKluKh+UC2SbKJbUaQuvAI04OE?=
 =?us-ascii?Q?MEcoaF4pUJB9ZNW3/gJXia4dWOtwnSIhmbC+6KXuYKTbF9yDAOPea5dkD4t+?=
 =?us-ascii?Q?JJai2e75T37I8rkEzp4WcKsx99D1E/mJkRBmzcdbJzcSNep3tA8GqhRoBAOn?=
 =?us-ascii?Q?IYVhbhKwxE6QrevOi8EK9C/zNR5SuC8Jp2/5/wji8adBHjmX8LdhGkYvhzwC?=
 =?us-ascii?Q?9MLa39wRZQLbnLgU75efIAffOQ5B8uXTjgv0Gz6bfbnw8elYMVThuV3mmYYR?=
 =?us-ascii?Q?4FSec5e0bSbnYTj64KD0pT5bB5OkJ4GLK1RJDg+yWFTGD1Dj1CYKgsMJIpzU?=
 =?us-ascii?Q?qQC4Qmt4iAVD+UUh2IkKhMKTHiNHpxRW9zueEnpDIvvcopnvIXhDkzHbf9qD?=
 =?us-ascii?Q?3p8KtOsdcJfXhaY2lePULIKIhgUNiW9gQ4mdNmMvtyDzJ2PlB8NerShTTeD+?=
 =?us-ascii?Q?EmLALsNRj9gTgfOnxz1dGTfvRntqpj81+SqDVUFMpwMu/K8cfk+uzq2/PBFd?=
 =?us-ascii?Q?um8KUbvf4LXws2yF1x24CkJZleksF0v88RKHizKcNDZKvOIhJYrnBtSSh4UN?=
 =?us-ascii?Q?eNbzXYv0HmbnaCxnKNrhdbrvCvxQS5OA4pvF+w8NNBOMwyBifWzYVUCsnu4I?=
 =?us-ascii?Q?C2qa/w0G0xmofzJCFqjkcvJbeIYsnx0eD3ZUq8Z83fsrd/xv0CtKyT/6KRn2?=
 =?us-ascii?Q?aeLVWv3rwn/DkzMwTv2425NvTMl9WhleqL0FZIimdPWgNQDipsIuaMajwVoG?=
 =?us-ascii?Q?R9is3lp0iT+TCpZgicm/ZqX4iVSfTu8UGONzGkc3xurTvB5dUPDWOQduVAiw?=
 =?us-ascii?Q?yWEz7JvyR7jYOW+xGhxB2P2JMzNPo9ypzovwO9hbde6YA6IsvL4A+lZq5k7k?=
 =?us-ascii?Q?p4KNq2WAYR2RW4z7664KowfJ9h4AfR3N4oLYcYuMQMOP3XdYyzSdhknMq3rD?=
 =?us-ascii?Q?34bmaEyBEaOKaODiFXJgrn5u8vL4O1LHtLAFnIO2kVFMm4ZPOmEWeKUAkfpo?=
 =?us-ascii?Q?RDisTeKA12vmXIHKw0C2lCjmSrHwf4GlTKBwEwbEbSZOGIrp6ve6WEnjbIET?=
 =?us-ascii?Q?9Nskz0u5krcKIVbbHxg0CDZmrUR1zhvq7w28CQh4VS3qdgXylTl5ekttfuSk?=
 =?us-ascii?Q?a2e2ODY9Rs5B3QPw8FdCQKb9sJWjCtbd+h5LLYXMKd+IpC5VPzH7FhtwNHc2?=
 =?us-ascii?Q?mlq+nrHnmSZz6J1GRIlkEBryOo8IuPaviYInpWzSLepqBQUmcrErBDs5pPGP?=
 =?us-ascii?Q?0CL5XqOJ2Z03ob9CoILG8o9zD9gY9UC+B99BqjKEfFtHsJh+sfNpzKua/5/T?=
 =?us-ascii?Q?anDmZOelhDXJpJc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GPyNux1LNeWq8A49FFndb18f4dXz9qdZ2bW9PNBRcfiBqHmw1QIfaPBW4VZB?=
 =?us-ascii?Q?0lQl/q0dsVdgi1uOkG+69Y3MCYx6aXPkxC+xIuMOUIerlDOGrrY8eguKxuHs?=
 =?us-ascii?Q?3YZbFLxOJqAXMfVzyQ6OWgBXMWx0IHnwlkaTawYBxaxe1pC/GRvmK0do1BDi?=
 =?us-ascii?Q?Udl+3+OJU6JOdMXsmizpDDAAkQfipW2fbKph9N5S6/QI6fxPXeZFdyUHHu2B?=
 =?us-ascii?Q?GoYFmwviupEoSPJZ7gRuylnvZj41dgESTis6UkiW4Qj1w+SawHmDOnG88vyQ?=
 =?us-ascii?Q?IqlyHe6yBHhL2BIOr64UBwSCl0xRre8tVwNkjrP2ct9hZk3mZlC97mzj3rdX?=
 =?us-ascii?Q?sTEJrDXvuo+eYlOTRDdYEX1tuF8v5Fpie+Cm8cn/jJWQ6EUG+INs5XEHwKJR?=
 =?us-ascii?Q?85x3ZmpM1idVepP7y94J2jE9XN9X6HnYwr8Q/2TM7QgImHVuMYB82JPu5kXK?=
 =?us-ascii?Q?n8kjIkg3nFALVOw9U86naCtb93PUVIyZ00cQ6N2yK0sjcrsWIOg7ciQME5lL?=
 =?us-ascii?Q?k5/mYRmvGckPgp5PtGCkgJoVjmRdBGxD4z4nC6q1LJYn6KGCjDzPJy2bSJja?=
 =?us-ascii?Q?bqffeQfGg92IZ6m4ljpodqGYXf7awGKh3m7Vo76ltSpI7poeIbXRgVCvNh+F?=
 =?us-ascii?Q?wADy2oGANjlAvmhtXVs6sb6QtjWjpi0kDN7wDOuWmxqFSH7cQi0qh2ezUWZd?=
 =?us-ascii?Q?PaVQH8gwOCe9F+y7ddfpPiOeczh0RDS1XO0yXYF2HMxF6F0A21pDHElm3yNq?=
 =?us-ascii?Q?bCSR209g8iOaB+Uxp2tOKLeV8P6rMkLHp3sLUCKzdOUoukldv6ylkV6ZKJb+?=
 =?us-ascii?Q?BdEL4xO0E6xdK32vtDb2XAD7Tr8c4yQ9hgvw4DQtwbcrbYQuLpjzv21YCo9Z?=
 =?us-ascii?Q?BYHgwq6RlGiw2tM2MTH+nff6MvHgPG+Qt0eBtVhnI1iTBnTc27HO6HNoGqTe?=
 =?us-ascii?Q?32Iii7lU4MvFY0XxENP/FN71zkUG0u8giZpEavl1PZ1xrlc7AYDGZ/8oQitY?=
 =?us-ascii?Q?6pefRsIFfjpWiyuXKjs9iHiClNImxQ21WdgBwmMi52MojWFBWzmEoRmOlm8L?=
 =?us-ascii?Q?7ea+AL1g5ug5yTUMFgF1H/P+Z8mb3VYdWYF/RWpjG7e2zFr9q+0bkWP6O5VO?=
 =?us-ascii?Q?CC1weC0iMVhkhEnfQo3AnJfVd0JDgBsmgrUKANXSbBrBsXdkBbkHICXDxw67?=
 =?us-ascii?Q?rI1tI+C+2LppyMwZHy3MaKiiUs1wKw0Nd/aNvaYgdzEoP00cHaVlAXxhhqHY?=
 =?us-ascii?Q?xqOZ1CHN16dtrDxq0+oYAn0IHKy10eKUQXMBtQU5Z3djr34zjbopEpRenpfR?=
 =?us-ascii?Q?aoP2kMCd/K3Xw4Do1QzzBgLtufMoFcABGH66Nssrv5kdnRiEPhp/VYLE9SF+?=
 =?us-ascii?Q?M28VHokQQeerJVHszFPgK/codbQmGjUc3CYh2z9ORbTireKTeKf08GcKYAX6?=
 =?us-ascii?Q?cg+JJWakNl8MNef+YFPNNr0qPuoEHjplI85IAEJ1dWA/Oco5xKRR95wIGomW?=
 =?us-ascii?Q?9LLHRIDelqzVLs/w4ToUdB0y3CGQ5gALDw7hiU3fnPDRpsfZYYaMCd3MczTn?=
 =?us-ascii?Q?9hZFSkraD+OsnbICmtg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40078893-1b99-4737-4e1c-08dd87031f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 09:49:23.1136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1h+p/oOKFc83XgnaIEUxvNw/3dymcFxDZrpq1TC4zSVFSMPBp2sbqxSLbz5UceK15iJOrSCA6rmAQZgOGs2yBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412
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

Ping

> -----Original Message-----
> From: Xiao, Shane <shane.xiao@amd.com>
> Sent: Friday, April 25, 2025 11:35 AM
> To: amd-gfx@lists.freedesktop.org; Kuehling, Felix <Felix.Kuehling@amd.co=
m>;
> Koenig, Christian <Christian.Koenig@amd.com>; Yang, Philip
> <Philip.Yang@amd.com>
> Cc: Xiao, Shane <shane.xiao@amd.com>
> Subject: [PATCH 2/2] amd/amdkfd: Trigger segfault for early userptr
> unmmapping
>
> If applications unmap the memory before destroying the userptr, it needs
> trigger a segfault to notify user space to correct the free sequence in V=
M debug
> mode.
>
> v2: Send GPU access fault to user space
> v3: Report gpu address to user space, remove unnecessary params
>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 15 +++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c       | 19 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 ++
>  3 files changed, 36 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d2ec4130a316..61a698056fb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2496,6 +2496,7 @@ static int update_invalid_user_pages(struct
> amdkfd_process_info *process_info,
>       struct ttm_operation_ctx ctx =3D { false, false };
>       uint32_t invalid;
>       int ret =3D 0;
> +     uint64_t userptr =3D 0;
>
>       mutex_lock(&process_info->notifier_lock);
>
> @@ -2559,6 +2560,20 @@ static int update_invalid_user_pages(struct
> amdkfd_process_info *process_info,
>                       if (ret !=3D -EFAULT)
>                               return ret;
>
> +                     /* If applications unmap memory before destroying t=
he
> userptr
> +                      * from the KFD, trigger a segmentation fault in VM
> debug mode.
> +                      */
> +                     if (amdgpu_ttm_adev(bo->tbo.bdev)-
> >debug_vm_userptr) {
> +                             amdgpu_ttm_tt_get_userptr(&bo->tbo,
> &userptr);
> +                             pr_err("User space unmap memory before
> destroying a userptr that refers to it\n");
> +                             pr_err("The unmap userptr cpu address is
> 0x%llx, gpu address is 0x%llx\n",
> +                                                             userptr, me=
m-
> >va);
> +
> +                             // Send GPU VM fault to user space
> +
>       kfd_signal_vm_fault_event_with_userptr(kfd_lookup_process_by_pid(pr
> ocess_info->pid),
> +                                                             mem->va);
> +                     }
> +
>                       ret =3D 0;
>               }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index fecdb6794075..e54e708ed82d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -1177,6 +1177,25 @@ void kfd_signal_hw_exception_event(u32 pasid)
>       kfd_unref_process(p);
>  }
>
> +void kfd_signal_vm_fault_event_with_userptr(struct kfd_process *p,
> +uint64_t gpu_va) {
> +     struct kfd_process_device *pdd;
> +     struct kfd_hsa_memory_exception_data exception_data;
> +     int i;
> +
> +     memset(&exception_data, 0, sizeof(exception_data));
> +     exception_data.va =3D gpu_va;
> +     exception_data.failure.NotPresent =3D 1;
> +
> +     // Send VM seg fault to all kfd process device
> +     for (i =3D 0; i < p->n_pdds; i++) {
> +             pdd =3D p->pdds[i];
> +             exception_data.gpu_id =3D pdd->user_gpu_id;
> +             kfd_evict_process_device(pdd);
> +             kfd_signal_vm_fault_event(pdd, NULL, &exception_data);
> +     }
> +}
> +
>  void kfd_signal_vm_fault_event(struct kfd_process_device *pdd,
>                               struct kfd_vm_fault_info *info,
>                               struct kfd_hsa_memory_exception_data *data)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index f6aedf69c644..8703be8077b0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1507,6 +1507,8 @@ int kfd_event_create(struct file *devkfd, struct
> kfd_process *p,  int kfd_get_num_events(struct kfd_process *p);  int
> kfd_event_destroy(struct kfd_process *p, uint32_t event_id);
>
> +void kfd_signal_vm_fault_event_with_userptr(struct kfd_process *p,
> +uint64_t gpu_va);
> +
>  void kfd_signal_vm_fault_event(struct kfd_process_device *pdd,
>                               struct kfd_vm_fault_info *info,
>                               struct kfd_hsa_memory_exception_data
> *data);
> --
> 2.25.1

