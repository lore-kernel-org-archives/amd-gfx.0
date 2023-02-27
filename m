Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5EAC64ED6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 13:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB2D5898A7;
	Mon, 27 Feb 2023 13:35:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF4410E14E
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 13:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDQBUiEqCC/hlqk4hgeO/w3jTpQyDKA4xgp0tQU59lWtHPzg9l543ljePEWzTdI2dCLLKH3YpzBjH1TxivSqB1cudXs/hgnTK90ihH0DTOWPxAocwbLBgo/ohX2QUbfxhQIqRdrVfFO7euUNNDPEcGjNRH6RKf901x8+noywC/KyqxrAqkVl0E3/tWuXEs7cFydfYCTdcrWSFMMsfg0TvHE1/9aM7kMoP9NlhFOrpOnpWrZkS5kW9ogkuraYOupTJs+ZhsFbwLneFVPnF4H92WZ7xX0wMQSpKTkFwao+DXBPGSigjgfTRqnELQz03mxxZ+oqZK9OpXMxjGgf8rvAAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXdWxE939ckNaPr7sNoHmFwMLDYdQLZsftWxneqIX7s=;
 b=U/BxZeQZ/0PHdrRTAZIio1OYKvIKPdjazu66iU3F/Fsk0omSzcpIOxLv+H8uyhj9/Wg4qXHTfF+KwfWqquao3fmhJonU4KflpEzBF+Zx1cTtFu+O0vcft3krcR2dhLb3Ru/LTtUoXEMqD1lI6cY7cZ+JQ0hlX+n+Ry8tLHJxgxccs22gAqqg/P1GB4RDdINYxAJnE8AYDSO76oKPauyy7hAzm3CVwJGRBEcNlghL7qrEE7iVxbmWJTwN5/Rv71RXRIxR8fRf1ufOfX4/FDLS+6y5t8Sujc+X1eoLOfFJPi+Y+mlyrktMXdm8skX2Ci6wIUU519GjLrukUHOO8Lvhsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXdWxE939ckNaPr7sNoHmFwMLDYdQLZsftWxneqIX7s=;
 b=QUWDdWqwOH1m5hqmzAa1Y2DTnP/AfhW7jQpseLW41NAWcHdF2zUGAjuwe0lik2m4Et/D53a5r+g0PA3N9KxbQaQVJY58K9If7SYG4WpXhiCjpijViBZPIzIQxVCXrpxIDKNwNPn+WkTJ23b/yakgb1Fe/VlaJMGF0G80GtaES5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 13:35:44 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::b64d:8d0e:8e08:d979]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::b64d:8d0e:8e08:d979%4]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 13:35:43 +0000
Message-ID: <a621b630-4e03-6bb3-fc5e-9cd60765072d@amd.com>
Date: Mon, 27 Feb 2023 19:05:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 5/6] drm/amdgpu: Implement userqueue signal/wait IOCTL
 functions
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
 <20230226165435.41641-6-Arunpravin.PaneerSelvam@amd.com>
 <62177dac-97b0-2d85-fdff-92b7f1851ac8@amd.com>
 <4a76b004-6ce2-e540-8d14-cc0653cea421@amd.com>
 <cd379750-a977-4ecd-af47-8f72c40b44c1@amd.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <cd379750-a977-4ecd-af47-8f72c40b44c1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::17) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d22256-dedf-414f-dbd3-08db18c7865d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbms7I24US6YuL+L+Ta4Z6v0di7dwIhghACQCfj1J+2aVb3eEtyNvRaP17gDacQC3qD22dv+2H6n71buVIR8+J3NdtWNanMz1JdCRj/2CToC0Rwy2gG9jYq8HAGWPXly7wzaDB4Fc+qrvyeydX0VSt8lV9dUpEqQLmnqzgoH2mdTbSziPDtKkJkyLiWgtZRQMgn1MWq6Gki/C/XUyi1472+Fk0lGMX0sQ+5KOb9iT/9hjQFAhUrYtrIdKMCQzcWEcPOU4mR5c3NPvrRUlrI8BlAoAZiiWM0DYxMp40q3nn4lRzb9FVcAEfrUMvVQKE+E+HkGi4Rea3kmghG16VNLgjWFfPuFHAtVexGJWrhzeyzJfyvv8wCDqmV/vxNBHZ6eHTKfoavwP7oSSD3nLFYi05NREQ6hxNKz0aDiS3ASr+Xq3y424BOL4W8OJQ+HJd5s0w/uUYPd0jAbwwJG4qqyscxV70/6gXbjdLStIAeP038MVVF9xEU7NqcpdSOiFzst2fFc+wmmOslJ6v6Fr592COP7lFF+SoXTuDISpZ/+/eUSqbXpwNOv4DPy9U8nYcCM6OVNk/hJsFksyEazLDoQAPIoQrHGDboS3EJXUrthBnNmH7tqSDIDwYzfcejku2/hGtysDObn0OcDkSwicR9uBmhXtpJlHZ6BS5VrljAboqqsQf6Uer2Johqjur/Sivw3n+pyu3k4c1M3A/LsgkgOe4j7IH3I947aZQhvH3vnC80=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199018)(66574015)(31696002)(86362001)(36756003)(38100700002)(83380400001)(8936002)(2906002)(5660300002)(30864003)(66946007)(66556008)(4326008)(66476007)(8676002)(31686004)(41300700001)(316002)(26005)(186003)(6512007)(2616005)(6486002)(478600001)(6506007)(53546011)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVc2NlE0M3MyNWJpR0NZa3hraEZDM3c1SXJKbk1ZbDh2NGdpbWRBQWFIek1O?=
 =?utf-8?B?bSt5QUVrS056Z0F3VGQ4V0RBd3ZDOVFhUDlOU0FJcTdBWWt4YktiYlJXUUZL?=
 =?utf-8?B?SUlzQ2NGdU4zR2VIL0htajZwSXpic0VnME9KT2RLeXNoL1NZbThVQkwxUk9E?=
 =?utf-8?B?SUJPRzlVSi9IMGdKVmhGZnV5QVNRSkFQOEx4VGlDZVA4NGpmc1pxREFyejBw?=
 =?utf-8?B?VldnQkJCZWdKNUxjeTkrUFhnZnhrZjJKS3A3YXg2NDJCeURrWDBmZ2pBcmRP?=
 =?utf-8?B?T1lISmkyNDRrMncwbGFGVzR4UXNuMEZwYWZEbFdzbHp6MWlobXlIWk5JdnNU?=
 =?utf-8?B?WmpYRm5BSDE4aGZzVU9rQ0JLSDlmZDhXQktwR0luQUliRS80aWtjSkN0VGts?=
 =?utf-8?B?Zi9kS3hiN04zOFdOdW5Lb21GV1FWdmZ3STJjRXRKcllzRzJPOVZWOWdOWHls?=
 =?utf-8?B?czRGZU1RSGJWMWRwTnJaY2NtS21NdUdML2xwaytMSncxdEV3WFRpRzA0U0VI?=
 =?utf-8?B?UzFSSDFWRklPeDBNaUF1a1NhV2ZxZ0FJYWV4UFUyelN0UFRhWVZrQWRxYXJH?=
 =?utf-8?B?TjB3a1FtbER3ZE1mZlp5SXhRRGU5ck1ieTVoYWdHTzFEdlJEdTFONnYzSUxm?=
 =?utf-8?B?UDUvVnRHcDN5clo5OFdjMGJLSWMvS3hnamI1KytvWEdCdWJDNGVCblVuVnNX?=
 =?utf-8?B?RU5xbUkvU1hGdFlCYk9GTzRQZkMxQkFvMHBZLzgvcjA0M2I0a1czTXRZRHpV?=
 =?utf-8?B?bmM2NnRWUGZMekhSV1ArbVM1dm5BZ1k3V1NMV0l4c25IaUJ3YXkwY01yYzlx?=
 =?utf-8?B?TTgrbStiNkdsdlhFNVptM1U1TnhtQk1YWGVnZ3VpN1pUZHFlOTY4RW5TQWdL?=
 =?utf-8?B?TE5WTm9QTXVyckl4SkNGR0lreDR6Wmp1Z2hianJBOVIrSHRmd3VhNnZJWFM4?=
 =?utf-8?B?R092dHdLQUdMZUo3Y252NU1YYWswK2FCaXZBYkE2Mk1GU3RWQVNkcGpYTWlJ?=
 =?utf-8?B?Q094cGs1UVZvU0thWXNnWjB1blFjYWNqR3A1WkpCc0Iyem9waTd3SExnS0VG?=
 =?utf-8?B?SitFaFFRLzNIWjI1TEpPeUFjN3FDTHY4Skg3dzZwM0l1eGM1OGpWM1p1Wk44?=
 =?utf-8?B?L2x3cDJjeHNpUzRNZS9lY2NQRi9oeCs0Znp1YVNDczh5elVWYkJGaXZ5cmxu?=
 =?utf-8?B?aDRKYXV6d01CdnBUM3ZPdXhQWE5iV2JyMnloRldGRW9NUEw2bFdhenl3TlNk?=
 =?utf-8?B?TW16L1FNVG9IZ09sMnM5ZkltUmFTbTZNdkpBaFlPL0hxVVQyUzFLUTlMRUdH?=
 =?utf-8?B?d08vb3p5UWdZOStsa0xBT3pDZ2hqejFrMDkyRkF2OTl4WU54aXEyM3JhYzNi?=
 =?utf-8?B?QlFGOU4vV1A0ZGlWMUJUL3FuOGt1WHNRVU5VZ3Z3YkhXWEhjbTVlZCtvV0J2?=
 =?utf-8?B?Vkh5aUYrYnJFWmdFSW9TSUdYZ0tyaW9CUThTd1IxQmZ0N01EZmM5ajJ5YkhH?=
 =?utf-8?B?VFVGK25aN2xzVmtJNU5iV09OVllVZFQzZWNLVUkxNWZhTlJsZklhK3JoYkxl?=
 =?utf-8?B?RHY3VVRoZWU3SS9Lc2U4VmI3NGpLcVBreWNYLzdlbk5JTGxjWHM0a0FwTEg1?=
 =?utf-8?B?YUp0V1ZRYzlYZkpRc2NVLy9mM0VweVpvZUdjbHpCeEs0YWl2MU5oL2Nsc0pn?=
 =?utf-8?B?WlZSOW1HSzMzeTNZb2UzNTFSdk5XRDV6cENnVFU2WVJTRGlwVjY3eEhUMEd1?=
 =?utf-8?B?OHBIc1NpVHVVdDZmaXBoM1cvR1BuQ0F6b0tFclluSnAyNTJkLzF6cVl1UUJa?=
 =?utf-8?B?Qjc0WFhNaDNtc2FyVmtjUWNsR2pvTERORVJZdXNiN1FrVjBSUVBCOEdBOU52?=
 =?utf-8?B?eFZsQVdsYkViemRjbXVNR3pHdnZyVE9ZY3BwMUswUWpsWDZLeWZuemNLb2NS?=
 =?utf-8?B?MDlhWFBYUWEzY2xxR280Tm45Zzk2YmVDNTlBMEV1MWVWbk1hT2JsQk9CNC9t?=
 =?utf-8?B?bGxvVkdDdlpzaXV5c2hSK3lQR2s3OTA1Q1ZQMkkvUksydnE4b21nVHRwdE1X?=
 =?utf-8?B?QzZqako0bWNhYUJNRXFDR3FpSWYwRG9ONVJ6L05sNmc5bFdwdjE4RGpHeDN0?=
 =?utf-8?Q?IfF8N8dS5wmpZbulhxjMZP5rP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d22256-dedf-414f-dbd3-08db18c7865d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 13:35:43.8506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMh03m9GGsoWvFtGsvId56yMu0U+ICCquVeID7xi6rudAiPJRr/BiwSAw/nUjAN0nd6QyZM7w4pteQ6tyOCc1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/27/2023 6:53 PM, Christian König wrote:
> Hi Arun,
>
> Am 27.02.23 um 14:20 schrieb Arunpravin Paneer Selvam:
>> Hi Christian,
>>
>>
>> On 2/27/2023 6:29 PM, Christian König wrote:
>>> Am 26.02.23 um 17:54 schrieb Arunpravin Paneer Selvam:
>>>> This patch introduces new IOCTL for userqueue secure semaphore.
>>>>
>>>> The signal IOCTL called from userspace application creates a drm
>>>> syncobj and array of bo GEM handles and passed in as parameter to
>>>> the driver to install the fence into it.
>>>>
>>>> The wait IOCTL gets an array of drm syncobjs, finds the fences
>>>> attached to the drm syncobjs and obtain the array of
>>>> memory_address/fence_value combintion which are returned to
>>>> userspace.
>>>>
>>>> v2: Worked on review comments from Christian for the following
>>>>      modifications
>>>>
>>>>      - Install fence into GEM BO object.
>>>>      - Lock all BO's using the dma resv subsystem
>>>>      - Reorder the sequence in signal IOCTL function.
>>>>      - Get write pointer from the shadow wptr
>>>>      - use userq_fence to fetch the va/value in wait IOCTL.
>>>>
>>>> Signed-off-by: Arunpravin Paneer Selvam 
>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   3 +
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 258 
>>>> ++++++++++++++++++
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   6 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |   1 +
>>>>   5 files changed, 270 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index 1c3eba2d0390..255d73795493 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -964,6 +964,8 @@ struct amdgpu_device {
>>>>       struct amdgpu_mes               mes;
>>>>       struct amdgpu_mqd mqds[AMDGPU_HW_IP_NUM];
>>>>   +    struct amdgpu_userq_mgr         *userq_mgr;
>>>> +
>>>>       /* df */
>>>>       struct amdgpu_df                df;
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index 6b7ac1ebd04c..66a7304fabe3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -2752,6 +2752,9 @@ const struct drm_ioctl_desc 
>>>> amdgpu_ioctls_kms[] = {
>>>>       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, 
>>>> amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>>       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, 
>>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>>       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_DOORBELL_RING, 
>>>> amdgpu_userq_doorbell_ring_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>> +    DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, 
>>>> amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>> +    DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, 
>>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>> +
>>>>   };
>>>>     static const struct drm_driver amdgpu_kms_driver = {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> index 609a7328e9a6..26fd1d4f758a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> @@ -249,3 +249,261 @@ static const struct dma_fence_ops 
>>>> amdgpu_userq_fence_ops = {
>>>>       .signaled = amdgpu_userq_fence_signaled,
>>>>       .release = amdgpu_userq_fence_release,
>>>>   };
>>>> +
>>>> +static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
>>>> +                    struct amdgpu_usermode_queue *queue,
>>>> +                    u64 *wptr)
>>>> +{
>>>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>> +    struct amdgpu_bo_va_mapping *mapping;
>>>> +    struct amdgpu_vm *vm = &fpriv->vm;
>>>> +    struct amdgpu_bo *bo;
>>>> +    u64 *ptr;
>>>> +    int r;
>>>> +
>>>> +    mapping = amdgpu_vm_bo_lookup_mapping(vm, queue->wptr_gpu_addr 
>>>> >> PAGE_SHIFT);
>>>> +    if (!mapping)
>>>> +        return -EINVAL;
>>>> +
>>>> +    bo = mapping->bo_va->base.bo;
>>>> +    r = amdgpu_bo_kmap(bo, (void **)&ptr);
>>>
>>> Oh, that's not something you can do that easily.
>>>
>>> The BO must be reserved (locked) first if you want to call 
>>> amdgpu_bo_kmap() on it.
>> sure, I will take care
>>>
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed mapping the userqueue wptr bo");
>>>> +        return r;
>>>> +    }
>>>> +
>>>> +    *wptr = le64_to_cpu(*ptr);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>> +                  struct drm_file *filp)
>>>> +{
>>>> +    struct drm_amdgpu_userq_signal *args = data;
>>>> +    struct amdgpu_device *adev = drm_to_adev(dev);
>>>> +    struct amdgpu_userq_mgr *userq_mgr = adev->userq_mgr;
>>>> +    struct amdgpu_usermode_queue *queue;
>>>> +    struct drm_syncobj *syncobj = NULL;
>>>> +    struct drm_gem_object **gobj;
>>>> +    u64 num_bo_handles, wptr;
>>>> +    struct dma_fence *fence;
>>>> +    u32 *bo_handles;
>>>> +    bool shared;
>>>> +    int r, i;
>>>> +
>>>> +    /* Retrieve the user queue */
>>>> +    queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
>>>> +    if (!queue)
>>>> +        return -ENOENT;
>>>> +
>>>> +    r = amdgpu_userq_fence_read_wptr(filp, queue, &wptr);
>>>> +    if (r)
>>>> +        return -EINVAL;
>>>> +
>>>> +    /* Find Syncobj if any */
>>>> +    syncobj = drm_syncobj_find(filp, args->handle);
>>>> +
>>>> +    /* Array of bo handles */
>>>> +    num_bo_handles = args->num_bo_handles;
>>>> +    bo_handles = kmalloc_array(num_bo_handles, 
>>>> sizeof(*bo_handles), GFP_KERNEL);
>>>> +    if (bo_handles == NULL)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    if (copy_from_user(bo_handles, 
>>>> u64_to_user_ptr(args->bo_handles_array),
>>>> +               sizeof(u32) * num_bo_handles)) {
>>>> +        r = -EFAULT;
>>>> +        goto err_free_handles;
>>>> +    }
>>>> +
>>>> +    /* Array of GEM object handles */
>>>> +    gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>>>> +    if (gobj == NULL) {
>>>> +        r = -ENOMEM;
>>>> +        goto err_free_handles;
>>>> +    }
>>>> +
>>>> +    for (i = 0; i < num_bo_handles; i++) {
>>>> +        /* Retrieve GEM object */
>>>> +        gobj[i] = drm_gem_object_lookup(filp, bo_handles[i]);
>>>> +        if (!gobj[i]) {
>>>> +            r = -ENOENT;
>>>> +            goto err_put_gobj;
>>>> +        }
>>>> +
>>>> +        dma_resv_lock(gobj[i]->resv, NULL);
>>>> +        r = dma_resv_reserve_fences(gobj[i]->resv, 1);
>> I am reserving place for each BO here, should we move this down?
>
> See below.
>
>>
>> Thanks,
>> Arun
>>>> +        if (r) {
>>>> +            dma_resv_unlock(gobj[i]->resv);
>>>> +            goto err_put_gobj;
>>>> +        }
>>>> +        dma_resv_unlock(gobj[i]->resv);
>
> The problem is here. You can't unlock the BO after you reserved the 
> fence slot or the reservation is dropped again. What you need to do is 
> to lock all BOs first and then reserve the fence slot.
>
> I've coded together a drm_exec helper to make that simple a while ago, 
> but never found the time to upstream it. Give me a day or so to rebase 
> the code.
sure, I will work on other comments.
>
> Regards,
> Christian.
>
>>>> +    }
>>>> +
>>>> +    /* Create a new fence */
>>>> +    r = amdgpu_userq_fence_create(queue, wptr, &fence);
>>>> +    if (!fence)
>>>> +        goto err_put_gobj;
>>>> +
>>>> +    /* Add the created fence to syncobj/BO's */
>>>> +    if (syncobj)
>>>> +        drm_syncobj_replace_fence(syncobj, fence);
>>>> +
>>>> +    shared = args->bo_flags & AMDGPU_USERQ_BO_READ;
>>>> +    for (i = 0; i < num_bo_handles; i++) {
>>>> +        dma_resv_lock(gobj[i]->resv, NULL);
>>>> +        dma_resv_add_fence(gobj[i]->resv, fence, shared ?
>>>> +                   DMA_RESV_USAGE_READ :
>>>> +                   DMA_RESV_USAGE_WRITE);
>>>> +        dma_resv_unlock(gobj[i]->resv);
>>>> +    }
>>>
>>> That will still not work correctly. You've forgotten to call 
>>> dma_resv_reserve_fences().
>>>
>>> The tricky part is that you need to do this for all BOs at the same 
>>> time.
>>>
>>> I will work on my drm_exec() patch set once more. That one should 
>>> make this job much easier.
>>>
>>> Similar applies to the _wait function, but let's get _signal working 
>>> first.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> +
>>>> +    for (i = 0; i < num_bo_handles; i++)
>>>> +        drm_gem_object_put(gobj[i]);
>>>> +
>>>> +    dma_fence_put(fence);
>>>> +
>>>> +    /* Free all handles */
>>>> +    kfree(bo_handles);
>>>> +    kfree(gobj);
>>>> +
>>>> +    return 0;
>>>> +
>>>> +err_put_gobj:
>>>> +    while (i-- > 0)
>>>> +        drm_gem_object_put(gobj[i]);
>>>> +    kfree(gobj);
>>>> +err_free_handles:
>>>> +    kfree(bo_handles);
>>>> +
>>>> +    return r;
>>>> +}
>>>> +
>>>> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>> +                struct drm_file *filp)
>>>> +{
>>>> +    struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>>>> +    struct drm_amdgpu_userq_wait *args = data;
>>>> +    struct amdgpu_userq_fence *userq_fence;
>>>> +    u32 *syncobj_handles, *bo_handles;
>>>> +    u64 num_syncobj, num_bo_handles;
>>>> +    struct drm_gem_object **gobj;
>>>> +    struct dma_fence *fence;
>>>> +    bool wait_flag;
>>>> +    int r, i, tmp;
>>>> +
>>>> +    /* Array of Syncobj handles */
>>>> +    num_syncobj = args->count_handles;
>>>> +    syncobj_handles = kmalloc_array(num_syncobj, 
>>>> sizeof(*syncobj_handles), GFP_KERNEL);
>>>> +    if (!syncobj_handles)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    if (copy_from_user(syncobj_handles, 
>>>> u64_to_user_ptr(args->handles),
>>>> +               sizeof(u32) * num_syncobj)) {
>>>> +        r = -EFAULT;
>>>> +        goto err_free_syncobj_handles;
>>>> +    }
>>>> +
>>>> +    /* Array of bo handles */
>>>> +    num_bo_handles = args->num_bo_handles;
>>>> +    bo_handles = kmalloc_array(num_bo_handles, 
>>>> sizeof(*bo_handles), GFP_KERNEL);
>>>> +    if (!bo_handles)
>>>> +        goto err_free_syncobj_handles;
>>>> +
>>>> +    if (copy_from_user(bo_handles, 
>>>> u64_to_user_ptr(args->bo_handles_array),
>>>> +               sizeof(u32) * num_bo_handles)) {
>>>> +        r = -EFAULT;
>>>> +        goto err_free_bo_handles;
>>>> +    }
>>>> +
>>>> +    /* Array of fence gpu address */
>>>> +    fence_info = kmalloc_array(num_syncobj + num_bo_handles, 
>>>> sizeof(*fence_info), GFP_KERNEL);
>>>> +    if (!fence_info) {
>>>> +        r = -ENOMEM;
>>>> +        goto err_free_bo_handles;
>>>> +    }
>>>> +
>>>> +    /* Retrieve syncobj's fence */
>>>> +    for (i = 0; i < num_syncobj; i++) {
>>>> +        r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0, 0, 
>>>> &fence);
>>>> +        if (r) {
>>>> +            DRM_ERROR("syncobj %u failed to find the fence!\n", 
>>>> syncobj_handles[i]);
>>>> +            r = -ENOENT;
>>>> +            goto err_free_fence_info;
>>>> +        }
>>>> +
>>>> +        /* Store drm syncobj's gpu va address and value */
>>>> +        userq_fence = to_amdgpu_userq_fence(fence);
>>>> +        fence_info[i].va = userq_fence->fence_drv->gpu_addr;
>>>> +        fence_info[i].value = fence->seqno;
>>>> +        dma_fence_put(fence);
>>>> +    }
>>>> +
>>>> +    tmp = i;
>>>> +
>>>> +    /* Array of GEM object handles */
>>>> +    gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>>>> +    if (gobj == NULL) {
>>>> +        r = -ENOMEM;
>>>> +        goto err_free_fence_info;
>>>> +    }
>>>> +
>>>> +    /* Retrieve GEM objects's fence */
>>>> +    wait_flag = args->bo_wait_flags & AMDGPU_USERQ_BO_READ;
>>>> +    for (i = 0; i < num_bo_handles; i++, tmp++) {
>>>> +        struct dma_fence *bo_fence;
>>>> +
>>>> +        gobj[i] = drm_gem_object_lookup(filp, bo_handles[i]);
>>>> +        if (!gobj[i]) {
>>>> +            r = -ENOENT;
>>>> +            goto err_put_gobj;
>>>> +        }
>>>> +
>>>> +        dma_resv_lock(gobj[i]->resv, NULL);
>>>> +        r = dma_resv_get_singleton(gobj[i]->resv,
>>>> +                       wait_flag ?
>>>> +                       DMA_RESV_USAGE_READ :
>>>> +                       DMA_RESV_USAGE_WRITE,
>>>> +                       &bo_fence);
>>>> +        if (r) {
>>>> +            dma_resv_unlock(gobj[i]->resv);
>>>> +            goto err_put_gobj;
>>>> +        }
>>>> +        dma_resv_unlock(gobj[i]->resv);
>>>> +        drm_gem_object_put(gobj[i]);
>>>> +
>>>> +        /* Store GEM objects's gpu va address and value */
>>>> +        userq_fence = to_amdgpu_userq_fence(bo_fence);
>>>> +        fence_info[tmp].va = userq_fence->fence_drv->gpu_addr;
>>>> +        fence_info[tmp].value = bo_fence->seqno;
>>>> +        dma_fence_put(bo_fence);
>>>> +    }
>>>> +
>>>> +    if (copy_to_user(u64_to_user_ptr(args->userq_fence_info),
>>>> +        fence_info, sizeof(fence_info))) {
>>>> +        r = -EFAULT;
>>>> +        goto err_free_gobj;
>>>> +    }
>>>> +
>>>> +    /* Free all handles */
>>>> +    kfree(syncobj_handles);
>>>> +    kfree(bo_handles);
>>>> +    kfree(fence_info);
>>>> +    kfree(gobj);
>>>> +
>>>> +    return 0;
>>>> +
>>>> +err_put_gobj:
>>>> +    while (i-- > 0)
>>>> +        drm_gem_object_put(gobj[i]);
>>>> +err_free_gobj:
>>>> +    kfree(gobj);
>>>> +err_free_fence_info:
>>>> +    kfree(fence_info);
>>>> +err_free_bo_handles:
>>>> +    kfree(bo_handles);
>>>> +err_free_syncobj_handles:
>>>> +    kfree(syncobj_handles);
>>>> +
>>>> +    return r;
>>>> +}
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>>> index 230dd54b4cd3..999d1e2baff5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>>> @@ -27,6 +27,8 @@
>>>>     #include <linux/types.h>
>>>>   +#define AMDGPU_USERQ_BO_READ    0x1
>>>> +
>>>>   struct amdgpu_userq_fence {
>>>>       struct dma_fence base;
>>>>       /* userq fence lock */
>>>> @@ -57,5 +59,9 @@ int amdgpu_userq_fence_create(struct 
>>>> amdgpu_usermode_queue *userq,
>>>>                     u64 seq, struct dma_fence **f);
>>>>   bool amdgpu_userq_fence_process(struct amdgpu_userq_fence_driver 
>>>> *fence_drv);
>>>>   void amdgpu_userq_fence_driver_destroy(struct kref *ref);
>>>> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>> +                  struct drm_file *filp);
>>>> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>> +                struct drm_file *filp);
>>>>     #endif
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> index d4317b0f6487..4d3d6777a178 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> @@ -457,6 +457,7 @@ int amdgpu_userq_mgr_init(struct 
>>>> amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>>>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>>>       INIT_LIST_HEAD(&userq_mgr->userq_list);
>>>>       userq_mgr->adev = adev;
>>>> +    adev->userq_mgr = userq_mgr;
>>>>         r = amdgpu_userqueue_setup_mqd_funcs(userq_mgr);
>>>>       if (r) {
>>>
>>
>

