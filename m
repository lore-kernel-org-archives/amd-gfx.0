Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4F2C7618D
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 09:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D81F410E0E5;
	Thu,  6 Apr 2023 09:09:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45C1510E08B
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 09:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6eZItSZykCI/O741rbq0ElGvcTbFlS7JVLs2JnzhdUn20TNgl9gtz11rj9rv5tSzVxMEsBQwqOXbMIEKyktJn8CSL2r6V95qb56K5riOPBYePez5vcF5pSnq33aflPFdt4LOieElKqWnf5yMCjp3Clow5bw2YCOrzBLigca10OARtMsgPUunYd9RWeUFrFqWDwohFu3a/fSrGaDKZ49+PRjkNcSshDfkhC+nFo6I6//SCXjK/otdhszZQkmtR0a7ofGA3H8kfpoYPeHI1rlJ13NsnAt7+C4uMm5V8408ynlFowuvkPv0Rmd45k1t/B4Y+BtgJGfsslRGx8k8fb8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQ7J8amGMYQFLA4YyZMzLzfSFlHi6RVqZv/BjfeSVwc=;
 b=BZj13X/im42meMJXImawY3ycinZN7TFxT8ApxUA1eH8s2AdCWC6ZzFaSm1N3POUH46Ivg6PsA9QRI7lwUYideMoRgxJwM697QDDjprTtu+SimPv34IkVO6pi2MF7iJMJ/yfCSUq6Uu+YnGHfeRrFfHfBawdvwE4Mpk48vatrWt+FU2yd6TwpkHjyVOJho7hrSrXmuAzDemqjUJ7PMzRgw6BUCmek+1IE69aVKbXG44UIDtlAGFIQ2Xf2rEjCBgMcf65cZBg0AqUMeRKweqqImSf7ZCSkSbYslTA13H5y78mcjh94Z8pOT8sCGvnj9Ou4E+7uQbRJ2ARDqLp3Xd/pXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQ7J8amGMYQFLA4YyZMzLzfSFlHi6RVqZv/BjfeSVwc=;
 b=tVu4No+pIkWC2v4eNaTN4HAgQj9jVDd5enbdTlagZKruqJTAwQL+W00D5T620wNFOX8FvTqL//Gn5UpzHNjEuIhgsYOvL7Pcc233QERKHbzqqKsBGlsjN8Xei1xmBuX+pypmAhzxO3wOYXEPSELqVXdP+onZErp5vNxCei4GZp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 09:09:30 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 09:09:29 +0000
Content-Type: multipart/alternative;
 boundary="------------9b5Lz1x9KyCUIURady0pqF1k"
Message-ID: <8a98b160-5276-54f5-d166-e12a572892e9@amd.com>
Date: Thu, 6 Apr 2023 11:09:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 03/13] drm/amdgpu/UAPI: add new CS chunk for GFX shadow
 buffers
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-4-alexander.deucher@amd.com>
 <CAAxE2A7nvmXdUaXESi4g6HVBFxk+dooz7tZYQfjGE8O2fKFi-w@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAAxE2A7nvmXdUaXESi4g6HVBFxk+dooz7tZYQfjGE8O2fKFi-w@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 657bda6c-7a16-4e18-e5fe-08db367ea0f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Az5g2ogeO2BKuUOj3x0dfqaB9tec5+xRjUPS0v7CYQxdOKL89TTQ/urh0TEtZOo8yDwRTvC2qCyKYBODP+AMJeT8HsgZjyUYFLn33GBfLv6uMdzY7p+GX9QgwesQdLHmJmffnDIiS137qBBzmwHbMv18Bcg2M7bYzAIynsLQEihrP72ZGfMhyfllL/d0paJoZWz0ROTmKE/akZKXOC5tizaDi0DNqtFRBNULYGJmddLeO0wtgZBWayevw8sD5BrGqRUlkgORuOi4FWtDOE337rutYrsjTlTtedmRK2buHtHhyRAZTyD5+bUPNFZVFFaI1/9YJsddMH5alfTc3KWnXgVOU5Z8bQYXoTbU5/+5LWlqp8QToKLpDt72/R55qfCEvZhXGpota+7K1zKh37Wr13HJkKzVKxkh64WQtwv+WBP4+34YkYzGRIyw/WAr4w4pbRDrIsbXkJdTlIPmJvvgbJlE/B+KAwqRcD7dUPT0wbRQNnlgQz5/gTkn0ghD1anS6hi8DBBIoxseuHgBcaYb3BCy6g/ldf2zAcjqiPtre2oNE0COviGye686Sxc7hBqJuB26oMqMK8/gloQUrrdVDAJEXPiig+UGUqs1sCfAw0FBzsPBm/tXudQwI6e5ITGIjBXwfvgWpMLKtmc3wo7Ypg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(33964004)(86362001)(41300700001)(66556008)(6666004)(31696002)(316002)(66476007)(66946007)(36756003)(6486002)(4326008)(110136005)(6636002)(2616005)(5660300002)(8676002)(8936002)(2906002)(38100700002)(53546011)(186003)(6512007)(478600001)(66574015)(26005)(6506007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTRLLzBBMDcwUkFvWWY2b0NHYUcranNmaDRsWVFSOStyU0ZuNXd1TVhFc3V5?=
 =?utf-8?B?cEFSSnNzejRnSVJVcVhnUURBSzVkV0czZlBvTkNreDZCdzJnSlhXM24rREdv?=
 =?utf-8?B?dGFTWlk3anovRWgvaW9kWDJ5ZGZqcC9ZaHFFbllLdU9OOFJ3Sy94eEcrbXA0?=
 =?utf-8?B?Y0RWbG4zYmwwaktVRHhWb2RSS3dvV2RydEtSbEE3YmNPNEs1UnEyMmxyUTd4?=
 =?utf-8?B?UUJYRHlHblJycUQ0TTIvcHJmZi9GaWZoQWZUTnVoREp4OGdSYjA2RzNoZlA2?=
 =?utf-8?B?K0ZXNDFtUXIxaXJ1UkhmUXZZRE5DOFpMand3cVY0b1ZTMGhOakFlKzNKbVVY?=
 =?utf-8?B?RG9HMFM3MUNiZkx2SmpTYy93dTlJVjRLbUp5KzVIYnNNRXp3aUpFb2tXUlBO?=
 =?utf-8?B?d1UwdHREM0locmVmVkxoSmdIVnZ0VWV2OSs3ZGNxWW9OYzNoVnJLMDlxNW4y?=
 =?utf-8?B?MzJkdkd2NzJCOGV3UTRWM1ZSQWZjVlZYdHQzYmphK3ZkWXpJVUI3MGpibUI0?=
 =?utf-8?B?Z2tRYnZTR2RBQyttMExENS9DYjVnSjl6UEFrUVlxRVBMdVBUcGs4UXU1emlW?=
 =?utf-8?B?Z2RaNGRTcGdLeitYOWkxMVk4c3NLbFlmSjd0MmxHYVBhQUFlN1lQc3BWdEd0?=
 =?utf-8?B?cUk2NVljWGRXZkRlellNczl3Z1BsYzhQTENoUnVoSmYzV0xMekxZQ1hlYjJh?=
 =?utf-8?B?QlN0VTIvTzc5VW5nNXBxSGpZNE85d3pwMXpCdlh2UXdKYU0wVzZSbnFrSlJC?=
 =?utf-8?B?Uk84bzRpOW44dlk5Y2tyRGpweGE1M2hic21jWnFWMmhnbTJNNUZNRkdoRTJ5?=
 =?utf-8?B?dFBDZEh3eFdHTWxlZkdSVXVLcWZjSzBXd1N0MXhDbkkyL2kwT2RvWnFDRHlv?=
 =?utf-8?B?djQzSHhyUmdNMHlnNTZiNFp4T3FzRHkyVzJZamR3Q2t0eUs4T1pGZllNR3da?=
 =?utf-8?B?TFFJcVhYQWxHOVlteFFrQkxFTzF5SU9vb2FvVGlBTTJ1SnRYM3pEaTc3QkY3?=
 =?utf-8?B?YmEzNmhPeUFtRnF1dnJiaDFiZlVCekd4UTY2RVRBZVF1Q3pEODBWWmpYYU5F?=
 =?utf-8?B?eGxqcUJBcTRDS0dncDk4UFhzZ0pwcytTMm54NWRtSlVVL1dQVmtYN3lVeG43?=
 =?utf-8?B?S1ZOZFl4OUEyQkdiSWpRQTMwcjZ0STBpR3lScE4yWHAvbUdJVlo4UFVGMk9E?=
 =?utf-8?B?T211Nm1DbVU1TEpJTkZESlNULzEwTjJCYkJJeVczVE5yeUlJeWw5dVdIanZM?=
 =?utf-8?B?ckhoQWdsNGNiMXoxWkF0VUVyb1NvSDUrUWt4SUM5NDlpRXlkNDIzUHRubjQ4?=
 =?utf-8?B?RjFiOVFEaVlEdlRkR1hXT0toSURIaVRmcFp2bkVaWFRPLy9OcW9xeVU5UHM5?=
 =?utf-8?B?djdtaHVrelZ1MEFaazgwVDdiYlJ0VUlSMVBEMzdTVzBtZnJnWmxWS1pQWmFC?=
 =?utf-8?B?MzNoRUYzZHpKblJ1ZGIzWklPMkNLTEF4Vm5IRHQ2OG0rU2tkUlk0QXEwUytz?=
 =?utf-8?B?dGp0MVdUaSt4bFVrMzE5bFFEbndjRndSenp5SW5sTHNLUUgwUUpMa2lYWnFP?=
 =?utf-8?B?VE5kT3ZTTWp5TVRzdVo2ZllrWVoyb1U5MHYyYjk1UGJaVklxYWFramJoM1JO?=
 =?utf-8?B?VmE2Q0dhWXZ6T0pFb0g1UnhFbWtiZVZXcEZlaHFTYXdkNHF4Z1dmczMvR3FD?=
 =?utf-8?B?REpRbHpWMlU1OHZUa2J4MkZ4ejhvaWo2WjUvV0VWRUtmNUNTZVZFRkJUcnB2?=
 =?utf-8?B?S016RWNnTmk2SWl4YUM3dkFzbHp0Sm42MXJmREJlWHFJUkxTanNLdEY5WVdi?=
 =?utf-8?B?dThwbUVieTFVTzNjdEVzRStkNW92NU9Dc21NQXpTSXNEV3lZSXJLdm1BYjJI?=
 =?utf-8?B?YnRYMG1iSnh4T2dsRGlPaVRGaWNkZXA3bmNpdG9hTHp5b3VpbUhUMkFybm13?=
 =?utf-8?B?NFQzcUlGSUdxNGdZSVpWUUZMMnVuV0Q1WWljTkxNdFNCVnUzcVdwVkhZbkJH?=
 =?utf-8?B?Vk5TWFBkT0tGS3JWVmpUV3BkVnZpbUt2M2dsU3dlSFFoZEE5TzJPdldZbUlt?=
 =?utf-8?B?MjVneDg1K2JUT0FOMzlmZnNlTE10M1JZWWtkTHVWR1Rtek53NmJibnJUYS9q?=
 =?utf-8?Q?Akao=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657bda6c-7a16-4e18-e5fe-08db367ea0f4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 09:09:29.8498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvSfjXbG/tabfE7k6VA8n/ExVlhx+wXT+CKMvL62gjkvn3a83woOs8otBcAo4nu+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------9b5Lz1x9KyCUIURady0pqF1k
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Why that?

This is the save buffer for GDS, not the old style GDS BOs.

Christian.

Am 06.04.23 um 09:36 schrieb Marek Olšák:
> gds_va is unnecessary.
>
> Marek
>
> On Thu, Mar 30, 2023 at 3:18 PM Alex Deucher 
> <alexander.deucher@amd.com> wrote:
>
>     For GFX11, the UMD needs to allocate some shadow buffers
>     to be used for preemption.  The UMD allocates the buffers
>     and passes the GPU virtual address to the kernel since the
>     kernel will program the packet that specified these
>     addresses as part of its IB submission frame.
>
>     v2: UMD passes shadow init to tell kernel when to initialize
>         the shadow
>
>     Reviewed-by: Christian König <christian.koenig@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     ---
>      include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
>      1 file changed, 10 insertions(+)
>
>     diff --git a/include/uapi/drm/amdgpu_drm.h
>     b/include/uapi/drm/amdgpu_drm.h
>     index b6eb90df5d05..3d9474af6566 100644
>     --- a/include/uapi/drm/amdgpu_drm.h
>     +++ b/include/uapi/drm/amdgpu_drm.h
>     @@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {
>      #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07
>      #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
>      #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
>     +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
>
>      struct drm_amdgpu_cs_chunk {
>             __u32           chunk_id;
>     @@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {
>             };
>      };
>
>     +#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW    0x1
>     +
>     +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>     +       __u64 shadow_va;
>     +       __u64 csa_va;
>     +       __u64 gds_va;
>     +       __u64 flags;
>     +};
>     +
>      /*
>       *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
>       *
>     -- 
>     2.39.2
>

--------------9b5Lz1x9KyCUIURady0pqF1k
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Why that?<br>
    <br>
    This is the save buffer for GDS, not the old style GDS BOs.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 06.04.23 um 09:36 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite" cite="mid:CAAxE2A7nvmXdUaXESi4g6HVBFxk+dooz7tZYQfjGE8O2fKFi-w@mail.gmail.com">
      
      <div dir="ltr">
        <div>gds_va is unnecessary.</div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Thu, Mar 30, 2023 at
          3:18 PM Alex Deucher &lt;<a href="mailto:alexander.deucher@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">alexander.deucher@amd.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">For
          GFX11, the UMD needs to allocate some shadow buffers<br>
          to be used for preemption.&nbsp; The UMD allocates the buffers<br>
          and passes the GPU virtual address to the kernel since the<br>
          kernel will program the packet that specified these<br>
          addresses as part of its IB submission frame.<br>
          <br>
          v2: UMD passes shadow init to tell kernel when to initialize<br>
          &nbsp; &nbsp; the shadow<br>
          <br>
          Reviewed-by: Christian König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;<br>
          Signed-off-by: Alex Deucher &lt;<a href="mailto:alexander.deucher@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">alexander.deucher@amd.com</a>&gt;<br>
          ---<br>
          &nbsp;include/uapi/drm/amdgpu_drm.h | 10 ++++++++++<br>
          &nbsp;1 file changed, 10 insertions(+)<br>
          <br>
          diff --git a/include/uapi/drm/amdgpu_drm.h
          b/include/uapi/drm/amdgpu_drm.h<br>
          index b6eb90df5d05..3d9474af6566 100644<br>
          --- a/include/uapi/drm/amdgpu_drm.h<br>
          +++ b/include/uapi/drm/amdgpu_drm.h<br>
          @@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {<br>
          &nbsp;#define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07<br>
          &nbsp;#define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT&nbsp; &nbsp; 0x08<br>
          &nbsp;#define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL&nbsp; 0x09<br>
          +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW&nbsp; &nbsp;0x0a<br>
          <br>
          &nbsp;struct drm_amdgpu_cs_chunk {<br>
          &nbsp; &nbsp; &nbsp; &nbsp; __u32&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;chunk_id;<br>
          @@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {<br>
          &nbsp; &nbsp; &nbsp; &nbsp; };<br>
          &nbsp;};<br>
          <br>
          +#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW&nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp;0x1<br>
          +<br>
          +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {<br>
          +&nbsp; &nbsp; &nbsp; &nbsp;__u64 shadow_va;<br>
          +&nbsp; &nbsp; &nbsp; &nbsp;__u64 csa_va;<br>
          +&nbsp; &nbsp; &nbsp; &nbsp;__u64 gds_va;<br>
          +&nbsp; &nbsp; &nbsp; &nbsp;__u64 flags;<br>
          +};<br>
          +<br>
          &nbsp;/*<br>
          &nbsp; *&nbsp; Query h/w info: Flag that this is integrated (a.h.a.
          fusion) GPU<br>
          &nbsp; *<br>
          -- <br>
          2.39.2<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------9b5Lz1x9KyCUIURady0pqF1k--
