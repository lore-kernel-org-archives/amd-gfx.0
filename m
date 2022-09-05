Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75139ECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Sep 2022 06:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0A8410E15A;
	Mon,  5 Sep 2022 06:09:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 625F910E15A
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Sep 2022 06:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJK4cvGMcxtA7fifRD63jdpLUPg8YSQ9TqF6qpW3GzF1+kjLgymOmLkvxN3VtrGkHXSnqCEAxgWAlMXM7803bU9fPjDK3O8He0NpTJGdhWS/GsHkv0DnFUmyEd/yhhrTh22zRJHyLTyskEnuCKHyouvzTAeSy5XiBy63V6hPViDqPfFu11ArujbKi+pNqhRPHx+ldOY9yL6Rt5Hhu9Wo9mxfpBov+ldqkelf85YOh/aTiPzj9PER7y84KRUsTtrpWOJR1+pYRxMv3yU9adFcopwnvosUxhTKSGIEh58XVXJy1x7gPMLXF8xxCitZBX5sVWzLk6+89mNpIr1vfIdJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwtwDqNH1xdRl2izOozATYLCVox46IQ7THNYyMFXJeI=;
 b=OE5RAPPeyqTdoWBwAGDU9v2HU3oBbShbWIKNfMFEB89AMNR1Bgny/g1CraZUkXDvJO/gdBkYfnhgnYQfB6ivWg3q9raj6BV78IyWH67uMk7F4hbBiKxCed8eZm+A26ugSzVYDQXkju3+m3DAGFHPJE+wSiijm5QHDgA8hwuA2A574CUkW0wMpMp4h+RcURRNfllDvQm8P/G2tSTfGQW0q7FNBe0hTl7ijGLjqGnbDPsXAnIk8mY502Fci0rqzFnXGa1M+kGAgqIEhCGiztJk1EB76F8VgWIBQRU3eHafcNA6s69/6TsAXw4Sq3Xto/mvIKLQlCt07hMDd6Qhk96s9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwtwDqNH1xdRl2izOozATYLCVox46IQ7THNYyMFXJeI=;
 b=MpBiiokb0pmQV5IowyNEomdFJ2kFUrYpLw1N8tYiiXsgkzggzsEK7f1W4zs5ldMMfyqilAdQ6i7qDbn45QMy1/zdRXzQAfNZEuxhKQEb4F7NX9qsOAyFttKEXJfmbBhTniiNgfky9beFChOpJl5S60AylmDMxJwHW0Xo5SO0iAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 06:09:43 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94%7]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 06:09:43 +0000
Message-ID: <bbc275fc-4704-417d-3e63-403a6846febb@amd.com>
Date: Mon, 5 Sep 2022 08:09:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 10/11] drm/amdgpu: add gang submit frontend v4
Content-Language: en-US
To: "Huang, Trigger" <Trigger.Huang@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Dong, Ruijing" <Ruijing.Dong@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220829131821.2049-1-christian.koenig@amd.com>
 <20220829131821.2049-11-christian.koenig@amd.com>
 <CY4PR12MB1784D344FE266655A79311CEFE7F9@CY4PR12MB1784.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CY4PR12MB1784D344FE266655A79311CEFE7F9@CY4PR12MB1784.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 886b35cd-075b-4d66-d7bf-08da8f053943
X-MS-TrafficTypeDiagnostic: DM6PR12MB4515:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFFeZrB8i2e8lS1Y8dpQltus0hTeyAfPs5vaI921+fdKzV9QBYfGrOHRE4VN+OpFkOGUE/yoyxHsr6YO+hqBM+p476HCSLxch/RxE+69ALvXprBa9xxytt2O4VXS0/3hVBc8VJhRfNS0UL9HHQebFHLdGNXtHeZHL2/2lvbuMkEUP2WUgkYMHzU7kjgBCSM5Z0VrH3ts6lGreH2qXnEySk4yLRYCLo5noyixQNK9tyuBu7xDA2+TV+xkGgFejXscMh9WJjb+c1U4uvM1cHNPLAuZpCK3DdZIfBEl1K2g86T2AqY8+BN5ZuSdscbCAqxDk8WWZsxm6nDA4yaRnGFjEkyiwJIXu4tByyEHy2a6yEJSCZAOA6KYloF1msr0GSx4HH0xF3hXII4mqezYB080RsZI+s+MgT/WcYq+MoiclQ1wsJJseRbQl1XOM/CMpaYHLSQExdCE+xeMZimMU7EaEKmtz2nzs6dMbcI1zCLwida9r1zyX41shwkVwUJ9uKLpjo6HBQIiPLvRmswLVGUeJ6IPCAz12sQSoynzsrWUPre/PNNauAyrzgRTzJWbNio4mEgxZj0RG7UHAShmkte50Jo0CRb+3krVIhXuCXOaeC8BXCKMauURCIsw9tvfcbffAY4JVwxOyOs/uCcbpYdG4MZTS62NvGw/fxx7xKLY6VRoJaA4I9P5ocIC8X1LU4EliE+XxnmNcRAn/yEXQn99f+GBHQPdSITjIJ/F6f9Dciq7ARf+lBcux2qVQ+MaVjVu6AuruBxXpIAh1CZUuO1ZqHMNoV7ygo1u7bn1T65Jmes=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(31686004)(186003)(66574015)(110136005)(83380400001)(316002)(2616005)(6486002)(26005)(2906002)(5660300002)(8936002)(36756003)(6512007)(41300700001)(53546011)(8676002)(31696002)(6506007)(38100700002)(478600001)(30864003)(66946007)(66556008)(86362001)(66476007)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SitzZ1RITXQ3clkyRWZNUlNxRCtPYkUvcjNwdTlpbnViVUk5QTB4RkVRRHRB?=
 =?utf-8?B?R0NOZVJoTEhHa0FBK3NPalkzWWFJOG45anV4L0xaeFpoWUd3bUxtUys0Y1A2?=
 =?utf-8?B?THo0blVpejVZTkhvTWNHMlhKalFqQVdRTzg0d29PWnFTbWVabDJkdXFLcjV0?=
 =?utf-8?B?WURwbFYzNmdmTURNRWFWVUJST3JaV29wTmQzcjdXcjBlbDhzajFGTWJpVGVk?=
 =?utf-8?B?bzk1aFB6NStlMEsvOGtpL1ljYnhvYnRvbXp0ZjQ2VEFqaXBpaVNIQzRBQlRY?=
 =?utf-8?B?ZEZIYmRtMzA5SUoyYnVpdU1qR08rdWhqMFp2YVIwTzR6VkNKVGlvQjRPQjhk?=
 =?utf-8?B?N2htc2U1NXlBNnVEcUhiR1hHbUJBL2FueEtUKzg5RTNRQURKbkJrRi9MMmQx?=
 =?utf-8?B?eHFyR1pDWEk2NWZENElBN2xvVWhCSXd3OXM5YkNiOElBK1h5cjZTOWJTN3NN?=
 =?utf-8?B?dGlpMGxzdDVOdDcwRUhtT2h5M2VxYy9RSlhWdjJ3dmpyeC8zSThMbXRIVFh3?=
 =?utf-8?B?cmE3cDlXbUJxTjllOU9KWk5XS1pVcUVEYVdLWHp2RURRcE54RnRBWTl4OHVM?=
 =?utf-8?B?aE1iTVhkZ1QwanBQSXJvVE41T2xCYkEvZGtDRDVTNDVkM3p0enlvdnlnM1JZ?=
 =?utf-8?B?bTdKbUpvdEFBTUd2ZGdBWUZ6bHZGQ24rb1owRzRIMXZWZXhFbFV5K0R2bjZk?=
 =?utf-8?B?K0w3Q0p3K0M4MksvR1FHb1lVYk43QTJmY2Y3S0FobkJwRUE3UjRkcmVNL2Nr?=
 =?utf-8?B?WEsvU1p0VjJWSmJyN2lUR2NXbDQ0alRvWm1Sc0Q0VlBETi9sNXBzMlptSUcw?=
 =?utf-8?B?QndoL0ptTUN1U0lTR0hxRXlDSXpjcGlDckVJdVhRVW1oc2trMUkzcWlnUFNO?=
 =?utf-8?B?dmdobE5HR0dWMUJ0NXpVS3RLQTdvdTBqamxONTZZRVA5ckxLS3ZoTFFNemI0?=
 =?utf-8?B?dE1LWEFGTFRnbzN5TDBrTEREdU1PTDlGWm40WmlrckNDZkduTXZOOHJWVVFF?=
 =?utf-8?B?YngrdDJkY09LYS9ySXdwRXd2M0hrWFRCcXVHQnFLRk51L0ExUWI5R1lacDJj?=
 =?utf-8?B?R1dwaUNXS2VFS1NJNHhpRVFXNFZTM3ZqQlRuWUVQOFgzNUUwRlNEUDZIaGVK?=
 =?utf-8?B?aXVhZmluMDMzTG4rQy8rTGlwUzBpTGhyTElscFdiK3FrbEJqczlDVm43SE4x?=
 =?utf-8?B?UmIrQ1JtRWd0ZjFCMjU2cFZRYzBUTy9MK0xyN3M0QzgrQldtYTlISUlDUFpE?=
 =?utf-8?B?amJ2ajBHc1FVdVd6WUorZytUdVM5anJrdFdGSXdBY2RZY0s3YXVUVXpiL3FL?=
 =?utf-8?B?RmlUenYrTEdKTWpxTTJyNGxDRDRXREN0V0p3amlsVjBqcHgrcFlIdHM1ZDIy?=
 =?utf-8?B?YThabEFUTnlKbGMrS25oWGtNK3g3eG92M0VJc2hhZUo1NkMySWx0T1RBWm1l?=
 =?utf-8?B?M2ZXVHVZMzNtekU5YzNLRGp2TEZVaktmUXZKS0NWa2kvdHpjdEhRNVpGaDRL?=
 =?utf-8?B?anlvcTVsa2JiaXJuRzVSWWJlUi9sMXFlRURudWFtZ2tnM1RqSFN3UVZYOC9Y?=
 =?utf-8?B?cDNlZVJoQzhId2R1T2VkRnVwWkx5TG44Rjd5czJheWJaWlJyYVlBOEVMVWtH?=
 =?utf-8?B?YUJIZVVHYVZ6S3Z5RkhJb1QxR3lKWEZCbERvdzN6aHZ4UzhEOU5LZWpRd0Z5?=
 =?utf-8?B?WDVkKzQ5Ri9FSmlvNTVBOVFRT3hjS2dXMjJ6eGEwa1pzU0d1VTE0Z3VRQ3h2?=
 =?utf-8?B?YWpIN1NiYkNVQ1FkUjZMbHJ4UW44Zy9CZXZPSVJ3eUNaYjlJcVJxdW1iR0hZ?=
 =?utf-8?B?dUUyVHAwV1BHZnN5M0p1OWZiMmt6ZnV4bVJ4aE8wUGZuOE5QZlB5WGNmSWpC?=
 =?utf-8?B?bmkrK3pyejY5SFYvNi9uQXV3djZuVzNvRm9yZmNWbUpxYkF3MGpaZmxlM3Rn?=
 =?utf-8?B?SVJqZXdIRGJCbk1nK1dCMHRPdDVXRkR6ZXZBVlFqbVVEc203QXJkb0JyZDNl?=
 =?utf-8?B?OEpjazNhdlRpek1ZSzM3TlUzT2psdzc4VXlMWXFFK2ZtcWhqb3QrNWY3QklJ?=
 =?utf-8?B?SllQeDF5NlJTVXZqeDNOL3dSenZUWFkzbGFsRlB0cVo3TjViUTRldFhXVkR6?=
 =?utf-8?Q?RDQIkcmyGG/iTd8p24VD4G2lA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 886b35cd-075b-4d66-d7bf-08da8f053943
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 06:09:43.3295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsyiozE3ThUVX3hweigOt89d0t5CO5KpzBO45vrnfj0kIHrRlcPV2a6+pX2PcwXB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
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

When we have it fully tested and ready I'm going to increase the DRM 
minor number to indicate support for it.

Regards,
Christian.

Am 05.09.22 um 04:30 schrieb Huang, Trigger:
> [AMD Official Use Only - General]
>
> Before we finally add the gang submission frontend, is there any interface/flag for user mode driver to detect if gang submission is supported by kernel?
>
> Regards,
> Trigger
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Christian K?nig
> Sent: 2022年8月29日 21:18
> To: Dong, Ruijing <Ruijing.Dong@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>
> Subject: [PATCH 10/11] drm/amdgpu: add gang submit frontend v4
>
> Allows submitting jobs as gang which needs to run on multiple engines at the same time.
>
> All members of the gang get the same implicit, explicit and VM dependencies. So no gang member will start running until everything else is ready.
>
> The last job is considered the gang leader (usually a submission to the GFX
> ring) and used for signaling output dependencies.
>
> Each job is remembered individually as user of a buffer object, so there is no joining of work at the end.
>
> v2: rebase and fix review comments from Andrey and Yogesh
> v3: use READ instead of BOOKKEEP for now because of VM unmaps, set gang
>      leader only when necessary
> v4: fix order of pushing jobs and adding fences found by Trigger.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c    | 259 ++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h    |  10 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h |  12 +-
>   3 files changed, 184 insertions(+), 97 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 9821299dfb49..a6e50ad5e306 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -69,6 +69,7 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
>                             unsigned int *num_ibs)
>   {
>          struct drm_sched_entity *entity;
> +       unsigned int i;
>          int r;
>
>          r = amdgpu_ctx_get_entity(p->ctx, chunk_ib->ip_type, @@ -77,17 +78,28 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
>          if (r)
>                  return r;
>
> -       /* Abort if there is no run queue associated with this entity.
> -        * Possibly because of disabled HW IP*/
> +       /*
> +        * Abort if there is no run queue associated with this entity.
> +        * Possibly because of disabled HW IP.
> +        */
>          if (entity->rq == NULL)
>                  return -EINVAL;
>
> -       /* Currently we don't support submitting to multiple entities */
> -       if (p->entity && p->entity != entity)
> +       /* Check if we can add this IB to some existing job */
> +       for (i = 0; i < p->gang_size; ++i) {
> +               if (p->entities[i] == entity)
> +                       goto found;
> +       }
> +
> +       /* If not increase the gang size if possible */
> +       if (i == AMDGPU_CS_GANG_SIZE)
>                  return -EINVAL;
>
> -       p->entity = entity;
> -       ++(*num_ibs);
> +       p->entities[i] = entity;
> +       p->gang_size = i + 1;
> +
> +found:
> +       ++(num_ibs[i]);
>          return 0;
>   }
>
> @@ -161,11 +173,12 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>                             union drm_amdgpu_cs *cs)
>   {
>          struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> +       unsigned int num_ibs[AMDGPU_CS_GANG_SIZE] = { };
>          struct amdgpu_vm *vm = &fpriv->vm;
>          uint64_t *chunk_array_user;
>          uint64_t *chunk_array;
> -       unsigned size, num_ibs = 0;
>          uint32_t uf_offset = 0;
> +       unsigned int size;
>          int ret;
>          int i;
>
> @@ -231,7 +244,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>                          if (size < sizeof(struct drm_amdgpu_cs_chunk_ib))
>                                  goto free_partial_kdata;
>
> -                       ret = amdgpu_cs_p1_ib(p, p->chunks[i].kdata, &num_ibs);
> +                       ret = amdgpu_cs_p1_ib(p, p->chunks[i].kdata, num_ibs);
>                          if (ret)
>                                  goto free_partial_kdata;
>                          break;
> @@ -268,21 +281,28 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>                  }
>          }
>
> -       ret = amdgpu_job_alloc(p->adev, num_ibs, &p->job, vm);
> -       if (ret)
> -               goto free_all_kdata;
> +       if (!p->gang_size)
> +               return -EINVAL;
>
> -       ret = drm_sched_job_init(&p->job->base, p->entity, &fpriv->vm);
> -       if (ret)
> -               goto free_all_kdata;
> +       for (i = 0; i < p->gang_size; ++i) {
> +               ret = amdgpu_job_alloc(p->adev, num_ibs[i], &p->jobs[i], vm);
> +               if (ret)
> +                       goto free_all_kdata;
> +
> +               ret = drm_sched_job_init(&p->jobs[i]->base, p->entities[i],
> +                                        &fpriv->vm);
> +               if (ret)
> +                       goto free_all_kdata;
> +       }
> +       p->gang_leader = p->jobs[p->gang_size - 1];
>
> -       if (p->ctx->vram_lost_counter != p->job->vram_lost_counter) {
> +       if (p->ctx->vram_lost_counter != p->gang_leader->vram_lost_counter) {
>                  ret = -ECANCELED;
>                  goto free_all_kdata;
>          }
>
>          if (p->uf_entry.tv.bo)
> -               p->job->uf_addr = uf_offset;
> +               p->gang_leader->uf_addr = uf_offset;
>          kvfree(chunk_array);
>
>          /* Use this opportunity to fill in task info for the vm */ @@ -304,22 +324,18 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>          return ret;
>   }
>
> -static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
> -                          struct amdgpu_cs_chunk *chunk,
> -                          unsigned int *num_ibs,
> -                          unsigned int *ce_preempt,
> -                          unsigned int *de_preempt)
> +static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
> +                          struct amdgpu_ib *ib, struct amdgpu_cs_chunk *chunk,
> +                          unsigned int *ce_preempt, unsigned int *de_preempt)
>   {
>          struct drm_amdgpu_cs_chunk_ib *chunk_ib = chunk->kdata;
>          struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> -       struct amdgpu_ring *ring = amdgpu_job_ring(p->job);
> -       struct amdgpu_ib *ib = &p->job->ibs[*num_ibs];
> +       struct amdgpu_ring *ring = amdgpu_job_ring(job);
>          struct amdgpu_vm *vm = &fpriv->vm;
>          int r;
>
> -
>          /* MM engine doesn't support user fences */
> -       if (p->job->uf_addr && ring->funcs->no_user_fence)
> +       if (job->uf_addr && ring->funcs->no_user_fence)
>                  return -EINVAL;
>
>          if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX && @@ -336,7 +352,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
>          }
>
>          if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
> -               p->job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
> +               job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
>
>          r =  amdgpu_ib_get(p->adev, vm, ring->funcs->parse_cs ?
>                             chunk_ib->ib_bytes : 0,
> @@ -349,8 +365,6 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
>          ib->gpu_addr = chunk_ib->va_start;
>          ib->length_dw = chunk_ib->ib_bytes / 4;
>          ib->flags = chunk_ib->flags;
> -
> -       (*num_ibs)++;
>          return 0;
>   }
>
> @@ -399,7 +413,7 @@ static int amdgpu_cs_p2_dependencies(struct amdgpu_cs_parser *p,
>                          dma_fence_put(old);
>                  }
>
> -               r = amdgpu_sync_fence(&p->job->sync, fence);
> +               r = amdgpu_sync_fence(&p->gang_leader->sync, fence);
>                  dma_fence_put(fence);
>                  if (r)
>                          return r;
> @@ -421,7 +435,7 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
>                  return r;
>          }
>
> -       r = amdgpu_sync_fence(&p->job->sync, fence);
> +       r = amdgpu_sync_fence(&p->gang_leader->sync, fence);
>          dma_fence_put(fence);
>
>          return r;
> @@ -544,20 +558,30 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(struct amdgpu_cs_parser *p,
>
>   static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)  {
> -       unsigned int num_ibs = 0, ce_preempt = 0, de_preempt = 0;
> +       unsigned int ce_preempt = 0, de_preempt = 0;
> +       unsigned int job_idx = 0, ib_idx = 0;
>          int i, r;
>
>          for (i = 0; i < p->nchunks; ++i) {
>                  struct amdgpu_cs_chunk *chunk;
> +               struct amdgpu_job *job;
>
>                  chunk = &p->chunks[i];
>
>                  switch (chunk->chunk_id) {
>                  case AMDGPU_CHUNK_ID_IB:
> -                       r = amdgpu_cs_p2_ib(p, chunk, &num_ibs,
> +                       job = p->jobs[job_idx];
> +                       r = amdgpu_cs_p2_ib(p, job, &job->ibs[ib_idx], chunk,
>                                              &ce_preempt, &de_preempt);
>                          if (r)
>                                  return r;
> +
> +                       if (++ib_idx == job->num_ibs) {
> +                               ++job_idx;
> +                               ib_idx = 0;
> +                               ce_preempt = 0;
> +                               de_preempt = 0;
> +                       }
>                          break;
>                  case AMDGPU_CHUNK_ID_DEPENDENCIES:
>                  case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
> @@ -828,6 +852,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>          struct amdgpu_vm *vm = &fpriv->vm;
>          struct amdgpu_bo_list_entry *e;
>          struct list_head duplicates;
> +       unsigned int i;
>          int r;
>
>          INIT_LIST_HEAD(&p->validated);
> @@ -911,16 +936,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>                  e->bo_va = amdgpu_vm_bo_find(vm, bo);
>          }
>
> -       /* Move fence waiting after getting reservation lock of
> -        * PD root. Then there is no need on a ctx mutex lock.
> -        */
> -       r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entity);
> -       if (unlikely(r != 0)) {
> -               if (r != -ERESTARTSYS)
> -                       DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
> -               goto error_validate;
> -       }
> -
>          amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
>                                            &p->bytes_moved_vis_threshold);
>          p->bytes_moved = 0;
> @@ -944,8 +959,10 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>          amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
>                                       p->bytes_moved_vis);
>
> -       amdgpu_job_set_resources(p->job, p->bo_list->gds_obj,
> -                                p->bo_list->gws_obj, p->bo_list->oa_obj);
> +       for (i = 0; i < p->gang_size; ++i)
> +               amdgpu_job_set_resources(p->jobs[i], p->bo_list->gds_obj,
> +                                        p->bo_list->gws_obj,
> +                                        p->bo_list->oa_obj);
>
>          if (p->uf_entry.tv.bo) {
>                  struct amdgpu_bo *uf = ttm_to_amdgpu_bo(p->uf_entry.tv.bo);
> @@ -954,7 +971,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>                  if (r)
>                          goto error_validate;
>
> -               p->job->uf_addr += amdgpu_bo_gpu_offset(uf);
> +               p->gang_leader->uf_addr += amdgpu_bo_gpu_offset(uf);
>          }
>          return 0;
>
> @@ -975,20 +992,24 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>          return r;
>   }
>
> -static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *parser)
> +static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *p)
>   {
> -       int i;
> +       int i, j;
>
>          if (!trace_amdgpu_cs_enabled())
>                  return;
>
> -       for (i = 0; i < parser->job->num_ibs; i++)
> -               trace_amdgpu_cs(parser, i);
> +       for (i = 0; i < p->gang_size; ++i) {
> +               struct amdgpu_job *job = p->jobs[i];
> +
> +               for (j = 0; j < job->num_ibs; ++j)
> +                       trace_amdgpu_cs(p, job, &job->ibs[j]);
> +       }
>   }
>
> -static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
> +static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
> +                              struct amdgpu_job *job)
>   {
> -       struct amdgpu_job *job = p->job;
>          struct amdgpu_ring *ring = amdgpu_job_ring(job);
>          unsigned int i;
>          int r;
> @@ -1029,12 +1050,12 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
>                          memcpy(ib->ptr, kptr, ib->length_dw * 4);
>                          amdgpu_bo_kunmap(aobj);
>
> -                       r = amdgpu_ring_parse_cs(ring, p, p->job, ib);
> +                       r = amdgpu_ring_parse_cs(ring, p, job, ib);
>                          if (r)
>                                  return r;
>                  } else {
>                          ib->ptr = (uint32_t *)kptr;
> -                       r = amdgpu_ring_patch_cs_in_place(ring, p, p->job, ib);
> +                       r = amdgpu_ring_patch_cs_in_place(ring, p, job, ib);
>                          amdgpu_bo_kunmap(aobj);
>                          if (r)
>                                  return r;
> @@ -1044,14 +1065,29 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
>          return 0;
>   }
>
> +static int amdgpu_cs_patch_jobs(struct amdgpu_cs_parser *p) {
> +       unsigned int i;
> +       int r;
> +
> +       for (i = 0; i < p->gang_size; ++i) {
> +               r = amdgpu_cs_patch_ibs(p, p->jobs[i]);
> +               if (r)
> +                       return r;
> +       }
> +       return 0;
> +}
> +
>   static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)  {
>          struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> +       struct amdgpu_job *job = p->gang_leader;
>          struct amdgpu_device *adev = p->adev;
>          struct amdgpu_vm *vm = &fpriv->vm;
>          struct amdgpu_bo_list_entry *e;
>          struct amdgpu_bo_va *bo_va;
>          struct amdgpu_bo *bo;
> +       unsigned int i;
>          int r;
>
>          r = amdgpu_vm_clear_freed(adev, vm, NULL); @@ -1062,7 +1098,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>          if (r)
>                  return r;
>
> -       r = amdgpu_sync_fence(&p->job->sync, fpriv->prt_va->last_pt_update);
> +       r = amdgpu_sync_fence(&job->sync, fpriv->prt_va->last_pt_update);
>          if (r)
>                  return r;
>
> @@ -1072,7 +1108,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>                  if (r)
>                          return r;
>
> -               r = amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_update);
> +               r = amdgpu_sync_fence(&job->sync, bo_va->last_pt_update);
>                  if (r)
>                          return r;
>          }
> @@ -1091,7 +1127,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>                  if (r)
>                          return r;
>
> -               r = amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_update);
> +               r = amdgpu_sync_fence(&job->sync, bo_va->last_pt_update);
>                  if (r)
>                          return r;
>          }
> @@ -1104,11 +1140,18 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>          if (r)
>                  return r;
>
> -       r = amdgpu_sync_fence(&p->job->sync, vm->last_update);
> +       r = amdgpu_sync_fence(&job->sync, vm->last_update);
>          if (r)
>                  return r;
>
> -       p->job->vm_pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
> +       for (i = 0; i < p->gang_size; ++i) {
> +               job = p->jobs[i];
> +
> +               if (!job->vm)
> +                       continue;
> +
> +               job->vm_pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
> +       }
>
>          if (amdgpu_vm_debug) {
>                  /* Invalidate all BOs to test for userspace bugs */ @@ -1129,7 +1172,9 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)  static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)  {
>          struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> +       struct amdgpu_job *leader = p->gang_leader;
>          struct amdgpu_bo_list_entry *e;
> +       unsigned int i;
>          int r;
>
>          list_for_each_entry(e, &p->validated, tv.head) { @@ -1139,12 +1184,23 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>
>                  sync_mode = amdgpu_bo_explicit_sync(bo) ?
>                          AMDGPU_SYNC_EXPLICIT : AMDGPU_SYNC_NE_OWNER;
> -               r = amdgpu_sync_resv(p->adev, &p->job->sync, resv, sync_mode,
> +               r = amdgpu_sync_resv(p->adev, &leader->sync, resv, sync_mode,
>                                       &fpriv->vm);
>                  if (r)
>                          return r;
>          }
> -       return 0;
> +
> +       for (i = 0; i < p->gang_size - 1; ++i) {
> +               r = amdgpu_sync_clone(&leader->sync, &p->jobs[i]->sync);
> +               if (r)
> +                       return r;
> +       }
> +
> +       r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_size - 1]);
> +       if (r && r != -ERESTARTSYS)
> +               DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
> +
> +       return r;
>   }
>
>   static void amdgpu_cs_post_dependencies(struct amdgpu_cs_parser *p) @@ -1168,16 +1224,28 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>                              union drm_amdgpu_cs *cs)
>   {
>          struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> -       struct drm_sched_entity *entity = p->entity;
> +       struct amdgpu_job *leader = p->gang_leader;
>          struct amdgpu_bo_list_entry *e;
> -       struct amdgpu_job *job;
> +       unsigned int i;
>          uint64_t seq;
>          int r;
>
> -       job = p->job;
> -       p->job = NULL;
> +       for (i = 0; i < p->gang_size; ++i)
> +               drm_sched_job_arm(&p->jobs[i]->base);
> +
> +       for (i = 0; i < (p->gang_size - 1); ++i) {
> +               struct dma_fence *fence;
> +
> +               fence = &p->jobs[i]->base.s_fence->scheduled;
> +               r = amdgpu_sync_fence(&leader->sync, fence);
> +               if (r)
> +                       goto error_cleanup;
> +       }
>
> -       drm_sched_job_arm(&job->base);
> +       if (p->gang_size > 1) {
> +               for (i = 0; i < p->gang_size; ++i)
> +                       amdgpu_job_set_gang_leader(p->jobs[i], leader);
> +       }
>
>          /* No memory allocation is allowed while holding the notifier lock.
>           * The lock is held until amdgpu_cs_submit is finished and fence is @@ -1195,45 +1263,57 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>          }
>          if (r) {
>                  r = -EAGAIN;
> -               goto error_abort;
> +               goto error_unlock;
>          }
>
> -       p->fence = dma_fence_get(&job->base.s_fence->finished);
> +       p->fence = dma_fence_get(&leader->base.s_fence->finished);
> +       list_for_each_entry(e, &p->validated, tv.head) {
>
> -       seq = amdgpu_ctx_add_fence(p->ctx, entity, p->fence);
> +               /* Everybody except for the gang leader uses READ */
> +               for (i = 0; i < (p->gang_size - 1); ++i) {
> +                       dma_resv_add_fence(e->tv.bo->base.resv,
> +                                          &p->jobs[i]->base.s_fence->finished,
> +                                          DMA_RESV_USAGE_READ);
> +               }
> +
> +               /* The gang leader as remembered as writer */
> +               e->tv.num_shared = 0;
> +       }
> +
> +       seq = amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_size - 1],
> +                                  p->fence);
>          amdgpu_cs_post_dependencies(p);
>
> -       if ((job->preamble_status & AMDGPU_PREAMBLE_IB_PRESENT) &&
> +       if ((leader->preamble_status & AMDGPU_PREAMBLE_IB_PRESENT) &&
>              !p->ctx->preamble_presented) {
> -               job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT_FIRST;
> +               leader->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT_FIRST;
>                  p->ctx->preamble_presented = true;
>          }
>
>          cs->out.handle = seq;
> -       job->uf_sequence = seq;
> +       leader->uf_sequence = seq;
>
> -       amdgpu_job_free_resources(job);
> -
> -       trace_amdgpu_cs_ioctl(job);
>          amdgpu_vm_bo_trace_cs(&fpriv->vm, &p->ticket);
> -       drm_sched_entity_push_job(&job->base);
> +       for (i = 0; i < p->gang_size; ++i) {
> +               amdgpu_job_free_resources(p->jobs[i]);
> +               trace_amdgpu_cs_ioctl(p->jobs[i]);
> +               drm_sched_entity_push_job(&p->jobs[i]->base);
> +               p->jobs[i] = NULL;
> +       }
>
>          amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
> -
> -       /* Make sure all BOs are remembered as writers */
> -       amdgpu_bo_list_for_each_entry(e, p->bo_list)
> -               e->tv.num_shared = 0;
> -
>          ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
> +
>          mutex_unlock(&p->adev->notifier_lock);
>          mutex_unlock(&p->bo_list->bo_list_mutex);
> -
>          return 0;
>
> -error_abort:
> -       drm_sched_job_cleanup(&job->base);
> +error_unlock:
>          mutex_unlock(&p->adev->notifier_lock);
> -       amdgpu_job_free(job);
> +
> +error_cleanup:
> +       for (i = 0; i < p->gang_size; ++i)
> +               drm_sched_job_cleanup(&p->jobs[i]->base);
>          return r;
>   }
>
> @@ -1250,17 +1330,18 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
>
>          dma_fence_put(parser->fence);
>
> -       if (parser->ctx) {
> +       if (parser->ctx)
>                  amdgpu_ctx_put(parser->ctx);
> -       }
>          if (parser->bo_list)
>                  amdgpu_bo_list_put(parser->bo_list);
>
>          for (i = 0; i < parser->nchunks; i++)
>                  kvfree(parser->chunks[i].kdata);
>          kvfree(parser->chunks);
> -       if (parser->job)
> -               amdgpu_job_free(parser->job);
> +       for (i = 0; i < parser->gang_size; ++i) {
> +               if (parser->jobs[i])
> +                       amdgpu_job_free(parser->jobs[i]);
> +       }
>          if (parser->uf_entry.tv.bo) {
>                  struct amdgpu_bo *uf = ttm_to_amdgpu_bo(parser->uf_entry.tv.bo);
>
> @@ -1304,7 +1385,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>                  goto error_fini;
>          }
>
> -       r = amdgpu_cs_patch_ibs(&parser);
> +       r = amdgpu_cs_patch_jobs(&parser);
>          if (r)
>                  goto error_backoff;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> index 652b5593499f..cbaa19b2b8a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> @@ -27,6 +27,8 @@
>   #include "amdgpu_bo_list.h"
>   #include "amdgpu_ring.h"
>
> +#define AMDGPU_CS_GANG_SIZE    4
> +
>   struct amdgpu_bo_va_mapping;
>
>   struct amdgpu_cs_chunk {
> @@ -50,9 +52,11 @@ struct amdgpu_cs_parser {
>          unsigned                nchunks;
>          struct amdgpu_cs_chunk  *chunks;
>
> -       /* scheduler job object */
> -       struct drm_sched_entity *entity;
> -       struct amdgpu_job       *job;
> +       /* scheduler job objects */
> +       unsigned int            gang_size;
> +       struct drm_sched_entity *entities[AMDGPU_CS_GANG_SIZE];
> +       struct amdgpu_job       *jobs[AMDGPU_CS_GANG_SIZE];
> +       struct amdgpu_job       *gang_leader;
>
>          /* buffer objects */
>          struct ww_acquire_ctx           ticket;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index 06dfcf297a8d..5e6ddc7e101c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -140,8 +140,10 @@ TRACE_EVENT(amdgpu_bo_create,  );
>
>   TRACE_EVENT(amdgpu_cs,
> -           TP_PROTO(struct amdgpu_cs_parser *p, int i),
> -           TP_ARGS(p, i),
> +           TP_PROTO(struct amdgpu_cs_parser *p,
> +                    struct amdgpu_job *job,
> +                    struct amdgpu_ib *ib),
> +           TP_ARGS(p, job, ib),
>              TP_STRUCT__entry(
>                               __field(struct amdgpu_bo_list *, bo_list)
>                               __field(u32, ring)
> @@ -151,10 +153,10 @@ TRACE_EVENT(amdgpu_cs,
>
>              TP_fast_assign(
>                             __entry->bo_list = p->bo_list;
> -                          __entry->ring = to_amdgpu_ring(p->entity->rq->sched)->idx;
> -                          __entry->dw = p->job->ibs[i].length_dw;
> +                          __entry->ring = to_amdgpu_ring(job->base.sched)->idx;
> +                          __entry->dw = ib->length_dw;
>                             __entry->fences = amdgpu_fence_count_emitted(
> -                               to_amdgpu_ring(p->entity->rq->sched));
> +                               to_amdgpu_ring(job->base.sched));
>                             ),
>              TP_printk("bo_list=%p, ring=%u, dw=%u, fences=%u",
>                        __entry->bo_list, __entry->ring, __entry->dw,
> --
> 2.25.1
>

