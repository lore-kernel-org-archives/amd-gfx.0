Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799D6C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 09:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FCA710E518;
	Tue, 11 Apr 2023 09:23:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5485210E518
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 09:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XK/ezlg/TV6D1zIOZzBAo20E1KcG+U52WvxiiUYOL835/Orp+zyqX+0/nMmHXEM5QJIu55gXqwcx3Isale2/xzF5J85MK647GyTHuooaiaxNfPFvSDooDMiUlMu8YxdluU4RzQXK/LwtRc2H06CCS2/zw/qSZuMncktIg1G8hg2OL2s6Uwo3PqJeifEn3aJFzlZ6Qd15LZDvMv+zuYola4NRYYExa9qdGXx/2ycxvVvgXki/sVY8uWdEPN961m/pcnyiHgjKgHfi7qd7CKAQnq/JCpk06VnTGXbZbVqYYUm3ohnbxj6C/4JEZPsc3mGxEtBsMdYemOJF+nhWf48QgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbww4Kv+EDmf6qLX8YPQsJeoGgwWKGjL99GKTX/+zKk=;
 b=iGZSJnRGRCGJgvlNDvvJzY14fntkp2zn3WwIpug3AvoFP4YAqmHrL6gCzfyAslyFXIubFU6MBgkzhf8wOCf6EBfHK7hWMyr7+2/nyVLN8isQvqLGLGYJypyceUl1QTldMqYdrNy7TQF2N49Ml4KzZK4X0/c6yeSmYUBF4309jw5xT5IUduROnoFh638v9319zENxcI2XDU4dPVspkpwF8x+VxTKnQ6ET5J6nQSUmCjfKl7uEuGErMprxHMOGFBZhX9er6+5eu+2lBDQzGbC70lZqtn+/MONDDa7A+pDu2ZR2FLJnczhhJuAYweF5cLUBzvUgTz9T6hxJHifg2RiYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbww4Kv+EDmf6qLX8YPQsJeoGgwWKGjL99GKTX/+zKk=;
 b=OpgqpEzvgeSxwBbGxFPFTvOE7IwWSfrBzlQ8nhyvsZ6VISCrfH17kNAAY4NOAxK5qV0rHd9RdduwZtMeeZ+aT8O9jK650b8+uL4TDynPntRXuRPDmp+DLDaOGt/ATz+XtDtR0Rp0ukVIcgUl30Bc7H4zAzSlkU6I7SAXUEYfU2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 09:23:04 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 09:23:03 +0000
Content-Type: multipart/alternative;
 boundary="------------iQn8oTQyEK4sVy1qTWD8sFIi"
Message-ID: <7804aefb-bc7d-78ae-92b6-f361df2d8da2@amd.com>
Date: Tue, 11 Apr 2023 11:22:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/3] drm/amdgpu: Add support for querying the max ibs
 in a submission. (v2)
Content-Language: en-US
To: =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20230409185956.725016-1-bas@basnieuwenhuizen.nl>
 <20230409185956.725016-3-bas@basnieuwenhuizen.nl>
 <698f4bbc-6253-2b61-ba82-68f6e7164ef6@amd.com>
 <CAP+8YyHKxEPYqr2NwnGZ3vEf_+7NeFH7FPXCvSwdzOLrUGgdDw@mail.gmail.com>
 <CAFF-SiXXvAHYGet9MQ1-UXvpX-O4ncDPRdKuOppyFsw8ESeXdw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAFF-SiXXvAHYGet9MQ1-UXvpX-O4ncDPRdKuOppyFsw8ESeXdw@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 599120e5-50b3-4353-f740-08db3a6e5a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hnTSi931VvI6O39NPjeX/j87LVGVEtYReq+6HOYtAhop+1LnfUVywalu6RqlgK/UTZjwtNtzd9/jan4oB7rAAh6Hh7KK+4x/xAQANi0UCzh7TckC94vkmdlUhMsTxjp5RXp/MrZxPb4qhecoV40pfXeiz9Gzfl5ShDRso+gcuCCMgvlu2dkSvt+r5A8eA+vwMNarvcWtMdOL2GHPJzioT9FYgmKuRnKH2VwsggWx0M8z2P7A90QSRlmsaRvE2NnFD/hdNT54MW5thwyVaHtFLRz2dis4ckhBjPsP8EsgzxtLWOW3FnRycpgesa707i/FTRGry+eZ0vkohqhXjLRS0XT7QF3PIiw6SCX0CEVQljL4uGE2JjaV0kaZfa+cSbZ8xQ4lrzfb95w2D+revV9xnPc8kSgOL7OvfPU18Sxv2W4bG6kSqGwykET6Iy0PQfDKLdmTg6mfAttNGlG3IvDTyz/S+nxfbQ9/KJjuplMqggL1MPoLAyEfSIGlXoKChA07pcscRWEguiCxKckPchzKnUitEmpmPGPsbPoiF28ebSG5MC+Qsu2iy1W0bi5FlF/D4J/8/f+jz8KSIWAMNk5vYvuXKGf7MPT0H8aJg8Tnqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(478600001)(6506007)(316002)(54906003)(110136005)(53546011)(33964004)(6512007)(26005)(186003)(966005)(30864003)(6666004)(6486002)(2906002)(66556008)(66946007)(4326008)(41300700001)(5660300002)(166002)(8676002)(66476007)(8936002)(38100700002)(66574015)(31696002)(36756003)(83380400001)(2616005)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aURicTJDNjVVZjNhaGRBbHdXTUxvd0U5QmY0eDMxMjIwZDhEN01nTGtZQzhI?=
 =?utf-8?B?cHB6NFZpL0JBMGlZS2FaTnJOQW5Sd1lYSU82Y0VDN3NNRVlBSk1XbS9lK0hy?=
 =?utf-8?B?MUFEb3lycG5maXk1Y2E2bHFuaGZseTVzZCtlSDJFMjNVS3haMHExZmtWbS9K?=
 =?utf-8?B?S09QbFNFenZZN21BWnRCT0E2WE9MQ0xXeVZyUVk3R3J4aythbTQ2a0MxL2Ur?=
 =?utf-8?B?TWFrZlViT09uRG1aVWlzbWQ0SDNldEcvYTB5eHBLdTdBQUF3U3RNSGRqT0lu?=
 =?utf-8?B?VWVudU9nSmxnQ0Z3VFVxMEVlYVFnUTRkbXJsTlBYWHZrRnFPSDcvYTdtdXVM?=
 =?utf-8?B?RGxOekcxcVRMQXY3d0Z2RmhkVEttKzh5YmkvTEdkeWlBYzI3cGpkWVV5dTU0?=
 =?utf-8?B?OStGTmRjeGllUHFRY2UvV1RoWjlaZkdQUDR1NnpNaDZXRmtKOXZRbXVydko4?=
 =?utf-8?B?NWZrdnEyQS9wUUxVMkJ5U29qdXcwMDJtd0U3WTNWYU4wbHNoTVdDczZ2V0l0?=
 =?utf-8?B?Z0dNTy8yZlhBRXVBcEEvRSs3OW5qd1VVRzZFK0w1Y2NUMjMzdEJOSkpLcmpk?=
 =?utf-8?B?UVBHK2pINzQzNjVvRDZRQURsTlN1UVFOWm12YlRBUUlxL3hQQ1hudDQ0WXZO?=
 =?utf-8?B?RVd3Mzh6dGNWVTJaTWhDRUZlSEZLMlRBTzQ3Wk1XeDlGR2pLbDEveGZveVZp?=
 =?utf-8?B?cldnb29oOFV4SlJCcXBRb2szOE4wdExMS1hGUEM5MXNZbEdVSGpOTm5kQis4?=
 =?utf-8?B?NHJmZFcvZXgvbWVJek4vL1g1S09WTjlxRmRWZUozMkNGeHpIQ2VnWnVHellC?=
 =?utf-8?B?RXJGbzYvd0dGaTU2aHdrTGY5eXBWNXNaWFJ3UUxob3Z5V3dTRjNOdHN0Vndi?=
 =?utf-8?B?UEpiMWpKUjNDa1lKVy9IcnA2WGR1K3VOM2xERnNac0wrVzdqbUFPdEV4VWhO?=
 =?utf-8?B?T0tKMHYrZWdYQWlWMm5ENEVPLzhaZ2V2eGEyVDF0S0ZoWXp0dURKMnZrdFQ3?=
 =?utf-8?B?dHY0K04zK2U1QjlFSEloMmtaNDVlak9qbFp3VndxWlhoZ1k4T21ZOTJsVk4x?=
 =?utf-8?B?T2lzcG9KbUozdGxmSjBic0pROSt4YjcrS2ZId01oUlo1VXc2UHIvRkhaUVhL?=
 =?utf-8?B?L3A5QVVhMmJNL2VMMWkveHJmT0VML2Yza0h6R2NHYXpYQ09ENXZobXhpandY?=
 =?utf-8?B?YUQ0cUtsRzRtaHRkM1RVTXJaUEtPeHp1UTdnWTVoTzVUYXpFcXJ6QXV2US9q?=
 =?utf-8?B?b0hjc21sNnRxYU1KTUloR0NKdG43aUprTVA0Ly9EcTZwRTlFTmNnRlM4VTFN?=
 =?utf-8?B?QmNmcWlya0NwcXA4NWJialhEMDIyMkxvaC85eUxYYnYzNG9CeFU1OXZIejZj?=
 =?utf-8?B?ci9JKzhzTmQ0Z2ZidWg4elpOcDc2SkVoYnFhUmlxMGJHS2NCRjdxc1FndEIx?=
 =?utf-8?B?UzdCK1RKaGZlczJjYm1aemRTTHdKSnlHN1pBZ205R1ZmZGFiakJpcmJwelFo?=
 =?utf-8?B?VHl3MEs1QVpVTGF5enkzWnZqeTBUbFh4WVd5blltM3o0RGVpNXh6SGtnVERY?=
 =?utf-8?B?RnlZUk5mek5ZMVpIS0NsMWJmVjMyV213VUp5K3RlTXQ5TUw1T1p1TUVxQS9N?=
 =?utf-8?B?eXZSeDFCMmlEeG95R1FHRk90MTRtRnhNaW1lWVlhMStXN2FyQlNRRHZNUWxI?=
 =?utf-8?B?R003RHVkVkNPRC9wUlRReGdWdFFvVVFlZUtkbmE3K0daNE01bG0yMnFwd0Zj?=
 =?utf-8?B?eW9NVUlhQkN2SmF4SnRWaFlyc1JqS3RFZlFIVXR2aHdUc3ZudjNiQ2wrS21i?=
 =?utf-8?B?SmM3QmV6SE1xWGptUEp1STlIcDdPNHFJUzNwdGNBeVlDS01WT3g2NVN4b3BW?=
 =?utf-8?B?dFhTSVhqMExHa2E0M2NEWEtlRENHTlJWRG1Td1BZcEJsNmRjQmtwbTFsSlpt?=
 =?utf-8?B?RHAvME9CZmJNTENPU0RoQ2dieXMyYlN1ZVFFQ3pNTVNDUDIraGhmNCtUQW1N?=
 =?utf-8?B?TU5LRDkreEVGVlQwYkREZ1pkNWZMenZLZW1OQkVyOUFoMzZaNUVCVzh0UWtX?=
 =?utf-8?B?T0F6N0VXUTlHbldaLzBZUWh1YWVET2wyL3lsdDExdG9EZ3V4aWwwejFPV2Zr?=
 =?utf-8?Q?QDo3NywRKgkvW23LCNSDsfe+e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599120e5-50b3-4353-f740-08db3a6e5a10
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 09:23:03.8341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfcYl7s6g3kf14q3EzcOCDbcnew6/ZG0wyH8NJyQOdm2FiQA6E08nrugtNbv7JMk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Pelloux-prayer,
 Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------iQn8oTQyEK4sVy1qTWD8sFIi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 11.04.23 um 11:06 schrieb Timur Kristóf:
>
>
> Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl> ezt írta (időpont: 2023. 
> ápr. 11., Ke 10:25):
>
>     On Tue, Apr 11, 2023 at 10:10 AM Christian König
>     <christian.koenig@amd.com> wrote:
>     >
>     > Am 09.04.23 um 20:59 schrieb Bas Nieuwenhuizen:
>     > > We need to introduce a new version of the info struct because
>     > > libdrm_amdgpu forgot any versioning info in
>     amdgpu_query_hw_ip_info
>     > > so the mesa<->libdrm_amdgpu interface can't handle increasing the
>     > > size.
>     > >
>     > > This info would be used by radv to figure out when we need to
>     > > split a submission into multiple submissions. radv currently has
>     > > a limit of 192 which seems to work for most gfx submissions, but
>     > > is way too high for e.g. compute or sdma.
>     >
>     > Why do you need so many IBs in the first place?
>     >
>     > You can use sub-IBs since R600 and newer hw even supports a JUMP
>     command
>     > to chain IBs together IIRC.
>
>     Couple of reasons:
>
>     1) We can't reliably use sub-IBs (both because on GFX6-7 there are
>     indirect draw commands that cannot be used in sub-IBs and because the
>     Vulkan API exposes sub-IBs, so we can have the primary IBs be sub-IBs
>     already)
>
>
> Furthermore, only the GFX queue supports the "IB2" packet that is used 
> to implement sub-IBs.
>
> (The same packet hangs the compute queue and is documented as not 
> working in the PAL source code. Other queues don't seem to have a 
> packet for this purpose.)
>
>     2) We believed GFX6 may not support chaining. (Then again, it turns
>     out the GFX7+ packet may just work on GFX6?
>     https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/22406)
>
>
> I was actually quite surprised when I found this out. Mesa developers 
> seem to have believed that this is not possible on GFX6. I'd love to 
> get some more context on this, did it always work or was it added in a 
> FW update?
>
>     3) Chaining doesn't work if the IB may be in flight multiple times in
>     a different sequence.
>
>
> Additionally, chaining also doesn't work on any queue other than GFX 
> and compute. As far as we know, SDMA and the various encoder/decoder 
> queues don't have a packet for chaining.
>
> Christian, please let us know if we are wrong about this.

I'm not an expert for this either. Marek and Pierre-eric know more about 
that stuff than me. On the other hand I could ping the firmware people 
as well if our UMD guys can't answer that.

It's just that last time we discussed this internally somebody from the 
PAL team commented that this isn't an issue any more because we don't 
need that many IBs any more.

libdrm defined that you shouldn't use more than 4 IBs in a CS, on the 
other hand we dropped checking that long ago and exposing the numbers of 
IBs the UMD can use is just good design.

Bas what do you think of adding an AMDGPU_INFO_MAX_IBS query instead of 
extending the drm_amdgpu_info_hw_ip structure?

Background is that the drm_amdgpu_info_hw_ip structure is actually not 
meant to be used for sw parameters (which the maximum number of IBs is) 
and we wouldn't need to dance around issues with query size parameters 
because that function takes the size as parameter.

Regards,
Christian.

>
>
> Best regards,
> Timur
>
>
>
>
>     We try to chain when we can but (2) and (3) are cases where we
>     fallback to submitting multiple IBs.
>
>     >
>     > For the kernel UAPI you only need separate IBs if you have separate
>     > properties on them, E.g. preamble or submitting to a different
>     engine.
>     >
>     > Everything else just needs additional CPU overhead in the IOCTL.
>     >
>     > Regards,
>     > Christian.
>     >
>     > >
>     > > Because the kernel handling is just fine we can just use the v2
>     > > everywhere and have the return_size do the versioning for us,
>     > > with userspace interpreting 0 as unknown.
>     > >
>     > > Userspace implementation:
>     > >
>     https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-rejection
>     > >
>     https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/ib-rejection
>     > >
>     > > v2: Use base member in the new struct.
>     > >
>     > > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
>     > > Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>     > > Cc: David Airlie <airlied@gmail.com>
>     > > ---
>     > >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 31
>     ++++++++++++++-----------
>     > >   include/uapi/drm/amdgpu_drm.h           | 14 +++++++++++
>     > >   2 files changed, 31 insertions(+), 14 deletions(-)
>     > >
>     > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>     > > index 89689b940493..5b575e1aef1a 100644
>     > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>     > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>     > > @@ -360,7 +360,7 @@ static int amdgpu_firmware_info(struct
>     drm_amdgpu_info_firmware *fw_info,
>     > >
>     > >   static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>     > >                            struct drm_amdgpu_info *info,
>     > > -                          struct drm_amdgpu_info_hw_ip *result)
>     > > +                          struct drm_amdgpu_info_hw_ip2 *result)
>     > >   {
>     > >       uint32_t ib_start_alignment = 0;
>     > >       uint32_t ib_size_alignment = 0;
>     > > @@ -431,6 +431,7 @@ static int amdgpu_hw_ip_info(struct
>     amdgpu_device *adev,
>     > >               return -EINVAL;
>     > >       }
>     > >
>     > > +     result->max_ibs = UINT_MAX;
>     > >       for (i = 0; i < adev->num_rings; ++i) {
>     > >               /* Note that this uses that ring types alias the
>     equivalent
>     > >                * HW IP exposes to userspace.
>     > > @@ -438,6 +439,8 @@ static int amdgpu_hw_ip_info(struct
>     amdgpu_device *adev,
>     > >               if (adev->rings[i]->funcs->type ==
>     info->query_hw_ip.type &&
>     > >  adev->rings[i]->sched.ready) {
>     > >                       ++num_rings;
>     > > +                     result->max_ibs = min(result->max_ibs,
>     > > +  adev->rings[i]->max_ibs);
>     > >               }
>     > >       }
>     > >
>     > > @@ -452,36 +455,36 @@ static int amdgpu_hw_ip_info(struct
>     amdgpu_device *adev,
>     > >       num_rings =
>     min(amdgpu_ctx_num_entities[info->query_hw_ip.type],
>     > >                       num_rings);
>     > >
>     > > -     result->hw_ip_version_major =
>     adev->ip_blocks[i].version->major;
>     > > -     result->hw_ip_version_minor =
>     adev->ip_blocks[i].version->minor;
>     > > +     result->base.hw_ip_version_major =
>     adev->ip_blocks[i].version->major;
>     > > +     result->base.hw_ip_version_minor =
>     adev->ip_blocks[i].version->minor;
>     > >
>     > >       if (adev->asic_type >= CHIP_VEGA10) {
>     > >               switch (type) {
>     > >               case AMD_IP_BLOCK_TYPE_GFX:
>     > > -  result->ip_discovery_version = adev->ip_versions[GC_HWIP][0];
>     > > +  result->base.ip_discovery_version =
>     adev->ip_versions[GC_HWIP][0];
>     > >                       break;
>     > >               case AMD_IP_BLOCK_TYPE_SDMA:
>     > > -  result->ip_discovery_version =
>     adev->ip_versions[SDMA0_HWIP][0];
>     > > +  result->base.ip_discovery_version =
>     adev->ip_versions[SDMA0_HWIP][0];
>     > >                       break;
>     > >               case AMD_IP_BLOCK_TYPE_UVD:
>     > >               case AMD_IP_BLOCK_TYPE_VCN:
>     > >               case AMD_IP_BLOCK_TYPE_JPEG:
>     > > -  result->ip_discovery_version = adev->ip_versions[UVD_HWIP][0];
>     > > +  result->base.ip_discovery_version =
>     adev->ip_versions[UVD_HWIP][0];
>     > >                       break;
>     > >               case AMD_IP_BLOCK_TYPE_VCE:
>     > > -  result->ip_discovery_version = adev->ip_versions[VCE_HWIP][0];
>     > > +  result->base.ip_discovery_version =
>     adev->ip_versions[VCE_HWIP][0];
>     > >                       break;
>     > >               default:
>     > > -  result->ip_discovery_version = 0;
>     > > +  result->base.ip_discovery_version = 0;
>     > >                       break;
>     > >               }
>     > >       } else {
>     > > -             result->ip_discovery_version = 0;
>     > > +  result->base.ip_discovery_version = 0;
>     > >       }
>     > > -     result->capabilities_flags = 0;
>     > > -     result->available_rings = (1 << num_rings) - 1;
>     > > -     result->ib_start_alignment = ib_start_alignment;
>     > > -     result->ib_size_alignment = ib_size_alignment;
>     > > +     result->base.capabilities_flags = 0;
>     > > +     result->base.available_rings = (1 << num_rings) - 1;
>     > > +     result->base.ib_start_alignment = ib_start_alignment;
>     > > +     result->base.ib_size_alignment = ib_size_alignment;
>     > >       return 0;
>     > >   }
>     > >
>     > > @@ -536,7 +539,7 @@ int amdgpu_info_ioctl(struct drm_device
>     *dev, void *data, struct drm_file *filp)
>     > >               }
>     > >               return copy_to_user(out, &ui32, min(size, 4u)) ?
>     -EFAULT : 0;
>     > >       case AMDGPU_INFO_HW_IP_INFO: {
>     > > -             struct drm_amdgpu_info_hw_ip ip = {};
>     > > +             struct drm_amdgpu_info_hw_ip2 ip = {};
>     > >               int ret;
>     > >
>     > >               ret = amdgpu_hw_ip_info(adev, info, &ip);
>     > > diff --git a/include/uapi/drm/amdgpu_drm.h
>     b/include/uapi/drm/amdgpu_drm.h
>     > > index b6eb90df5d05..6b9e35b6f747 100644
>     > > --- a/include/uapi/drm/amdgpu_drm.h
>     > > +++ b/include/uapi/drm/amdgpu_drm.h
>     > > @@ -1128,6 +1128,9 @@ struct drm_amdgpu_info_device {
>     > >       __u32 enabled_rb_pipes_mask_hi;
>     > >   };
>     > >
>     > > +/* The size of this struct cannot be increased for
>     compatibility reasons, use
>     > > + * struct drm_amdgpu_info_hw_ip2 instead.
>     > > + */
>     > >   struct drm_amdgpu_info_hw_ip {
>     > >       /** Version of h/w IP */
>     > >       __u32  hw_ip_version_major;
>     > > @@ -1144,6 +1147,17 @@ struct drm_amdgpu_info_hw_ip {
>     > >       __u32  ip_discovery_version;
>     > >   };
>     > >
>     > > +struct drm_amdgpu_info_hw_ip2 {
>     > > +     /** Previous version of the struct */
>     > > +     struct drm_amdgpu_info_hw_ip  base;
>     > > +     /** The maximum number of IBs one can submit in a single
>     submission
>     > > +      * ioctl. (When using gang submit: this is per IP type)
>     > > +      */
>     > > +     __u32  max_ibs;
>     > > +     /** padding to 64bit for arch differences */
>     > > +     __u32  pad;
>     > > +};
>     > > +
>     > >   struct drm_amdgpu_info_num_handles {
>     > >       /** Max handles as supported by firmware for UVD */
>     > >       __u32  uvd_max_handles;
>     >
>

--------------iQn8oTQyEK4sVy1qTWD8sFIi
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 11.04.23 um 11:06 schrieb Timur Kristóf:<br>
    <blockquote type="cite" cite="mid:CAFF-SiXXvAHYGet9MQ1-UXvpX-O4ncDPRdKuOppyFsw8ESeXdw@mail.gmail.com">
      
      <div dir="auto">
        <div><br>
          <br>
          <div class="gmail_quote">
            <div dir="ltr" class="gmail_attr">Bas Nieuwenhuizen &lt;<a href="mailto:bas@basnieuwenhuizen.nl" moz-do-not-send="true" class="moz-txt-link-freetext">bas@basnieuwenhuizen.nl</a>&gt;
              ezt írta (időpont: 2023. ápr. 11., Ke 10:25):<br>
            </div>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">On Tue,
              Apr 11, 2023 at 10:10 AM Christian König<br>
              &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" rel="noreferrer" moz-do-not-send="true" class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;
              wrote:<br>
              &gt;<br>
              &gt; Am 09.04.23 um 20:59 schrieb Bas Nieuwenhuizen:<br>
              &gt; &gt; We need to introduce a new version of the info
              struct because<br>
              &gt; &gt; libdrm_amdgpu forgot any versioning info in
              amdgpu_query_hw_ip_info<br>
              &gt; &gt; so the mesa&lt;-&gt;libdrm_amdgpu interface
              can't handle increasing the<br>
              &gt; &gt; size.<br>
              &gt; &gt;<br>
              &gt; &gt; This info would be used by radv to figure out
              when we need to<br>
              &gt; &gt; split a submission into multiple submissions.
              radv currently has<br>
              &gt; &gt; a limit of 192 which seems to work for most gfx
              submissions, but<br>
              &gt; &gt; is way too high for e.g. compute or sdma.<br>
              &gt;<br>
              &gt; Why do you need so many IBs in the first place?<br>
              &gt;<br>
              &gt; You can use sub-IBs since R600 and newer hw even
              supports a JUMP command<br>
              &gt; to chain IBs together IIRC.<br>
              <br>
              Couple of reasons:<br>
              <br>
              1) We can't reliably use sub-IBs (both because on GFX6-7
              there are<br>
              indirect draw commands that cannot be used in sub-IBs and
              because the<br>
              Vulkan API exposes sub-IBs, so we can have the primary IBs
              be sub-IBs<br>
              already)<br>
            </blockquote>
          </div>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Furthermore, only the GFX queue supports the
          &quot;IB2&quot; packet that is used to implement sub-IBs.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">(The same packet hangs the compute queue and is
          documented as not working in the PAL source code. Other queues
          don't seem to have a packet for this purpose.)</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">
          <div class="gmail_quote">
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">2) We
              believed GFX6 may not support chaining. (Then again, it
              turns<br>
              out the GFX7+ packet may just work on GFX6?<br>
              <a href="https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/22406" rel="noreferrer noreferrer" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/22406</a>)<br>
            </blockquote>
          </div>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">I was actually quite surprised when I found this
          out. Mesa developers seem to have believed that this is not
          possible on GFX6. I'd love to get some more context on this,
          did it always work or was it added in a FW update?</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">
          <div class="gmail_quote">
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">3)
              Chaining doesn't work if the IB may be in flight multiple
              times in<br>
              a different sequence.<br>
            </blockquote>
          </div>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Additionally, chaining also doesn't work on any
          queue other than GFX and compute. As far as we know, SDMA and
          the various encoder/decoder queues don't have a packet for
          chaining.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Christian, please let us know if we are wrong
          about this.</div>
      </div>
    </blockquote>
    <br>
    I'm not an expert for this either. Marek and Pierre-eric know more
    about that stuff than me. On the other hand I could ping the
    firmware people as well if our UMD guys can't answer that.<br>
    <br>
    It's just that last time we discussed this internally somebody from
    the PAL team commented that this isn't an issue any more because we
    don't need that many IBs any more.<br>
    <br>
    libdrm defined that you shouldn't use more than 4 IBs in a CS, on
    the other hand we dropped checking that long ago and exposing the
    numbers of IBs the UMD can use is just good design.<br>
    <br>
    Bas what do you think of adding an AMDGPU_INFO_MAX_IBS query instead
    of extending the drm_amdgpu_info_hw_ip structure?<br>
    <br>
    Background is that the drm_amdgpu_info_hw_ip structure is actually
    not meant to be used for sw parameters (which the maximum number of
    IBs is) and we wouldn't need to dance around issues with query size
    parameters because that function takes the size as parameter.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:CAFF-SiXXvAHYGet9MQ1-UXvpX-O4ncDPRdKuOppyFsw8ESeXdw@mail.gmail.com">
      <div dir="auto">
        <div dir="auto"><br>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Best regards,</div>
        <div dir="auto">Timur</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">
          <div class="gmail_quote">
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <br>
              We try to chain when we can but (2) and (3) are cases
              where we<br>
              fallback to submitting multiple IBs.<br>
              <br>
              &gt;<br>
              &gt; For the kernel UAPI you only need separate IBs if you
              have separate<br>
              &gt; properties on them, E.g. preamble or submitting to a
              different engine.<br>
              &gt;<br>
              &gt; Everything else just needs additional CPU overhead in
              the IOCTL.<br>
              &gt;<br>
              &gt; Regards,<br>
              &gt; Christian.<br>
              &gt;<br>
              &gt; &gt;<br>
              &gt; &gt; Because the kernel handling is just fine we can
              just use the v2<br>
              &gt; &gt; everywhere and have the return_size do the
              versioning for us,<br>
              &gt; &gt; with userspace interpreting 0 as unknown.<br>
              &gt; &gt;<br>
              &gt; &gt; Userspace implementation:<br>
              &gt; &gt; <a href="https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-rejection" rel="noreferrer noreferrer" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-rejection</a><br>
              &gt; &gt; <a href="https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/ib-rejection" rel="noreferrer noreferrer" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/ib-rejection</a><br>
              &gt; &gt;<br>
              &gt; &gt; v2: Use base member in the new struct.<br>
              &gt; &gt;<br>
              &gt; &gt; Link: <a href="https://gitlab.freedesktop.org/drm/amd/-/issues/2498" rel="noreferrer noreferrer" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">https://gitlab.freedesktop.org/drm/amd/-/issues/2498</a><br>
              &gt; &gt; Signed-off-by: Bas Nieuwenhuizen &lt;<a href="mailto:bas@basnieuwenhuizen.nl" target="_blank" rel="noreferrer" moz-do-not-send="true" class="moz-txt-link-freetext">bas@basnieuwenhuizen.nl</a>&gt;<br>
              &gt; &gt; Cc: David Airlie &lt;<a href="mailto:airlied@gmail.com" target="_blank" rel="noreferrer" moz-do-not-send="true" class="moz-txt-link-freetext">airlied@gmail.com</a>&gt;<br>
              &gt; &gt; ---<br>
              &gt; &gt;&nbsp; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 31
              ++++++++++++++-----------<br>
              &gt; &gt;&nbsp; &nbsp;include/uapi/drm/amdgpu_drm.h&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| 14
              +++++++++++<br>
              &gt; &gt;&nbsp; &nbsp;2 files changed, 31 insertions(+), 14
              deletions(-)<br>
              &gt; &gt;<br>
              &gt; &gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
              &gt; &gt; index 89689b940493..5b575e1aef1a 100644<br>
              &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
              &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
              &gt; &gt; @@ -360,7 +360,7 @@ static int
              amdgpu_firmware_info(struct drm_amdgpu_info_firmware
              *fw_info,<br>
              &gt; &gt;<br>
              &gt; &gt;&nbsp; &nbsp;static int amdgpu_hw_ip_info(struct
              amdgpu_device *adev,<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct
              drm_amdgpu_info *info,<br>
              &gt; &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct
              drm_amdgpu_info_hw_ip *result)<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct
              drm_amdgpu_info_hw_ip2 *result)<br>
              &gt; &gt;&nbsp; &nbsp;{<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;uint32_t ib_start_alignment = 0;<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;uint32_t ib_size_alignment = 0;<br>
              &gt; &gt; @@ -431,6 +431,7 @@ static int
              amdgpu_hw_ip_info(struct amdgpu_device *adev,<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EINVAL;<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;}<br>
              &gt; &gt;<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp;result-&gt;max_ibs = UINT_MAX;<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;for (i = 0; i &lt; adev-&gt;num_rings;
              ++i) {<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Note that this uses that ring
              types alias the equivalent<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * HW IP exposes to userspace.<br>
              &gt; &gt; @@ -438,6 +439,8 @@ static int
              amdgpu_hw_ip_info(struct amdgpu_device *adev,<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if
              (adev-&gt;rings[i]-&gt;funcs-&gt;type ==
              info-&gt;query_hw_ip.type &amp;&amp;<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp;adev-&gt;rings[i]-&gt;sched.ready) {<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;++num_rings;<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;result-&gt;max_ibs =
              min(result-&gt;max_ibs,<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp;adev-&gt;rings[i]-&gt;max_ibs);<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;}<br>
              &gt; &gt;<br>
              &gt; &gt; @@ -452,36 +455,36 @@ static int
              amdgpu_hw_ip_info(struct amdgpu_device *adev,<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;num_rings =
              min(amdgpu_ctx_num_entities[info-&gt;query_hw_ip.type],<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;num_rings);<br>
              &gt; &gt;<br>
              &gt; &gt; -&nbsp; &nbsp; &nbsp;result-&gt;hw_ip_version_major =
              adev-&gt;ip_blocks[i].version-&gt;major;<br>
              &gt; &gt; -&nbsp; &nbsp; &nbsp;result-&gt;hw_ip_version_minor =
              adev-&gt;ip_blocks[i].version-&gt;minor;<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp;result-&gt;base.hw_ip_version_major =
              adev-&gt;ip_blocks[i].version-&gt;major;<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp;result-&gt;base.hw_ip_version_minor =
              adev-&gt;ip_blocks[i].version-&gt;minor;<br>
              &gt; &gt;<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;if (adev-&gt;asic_type &gt;= CHIP_VEGA10)
              {<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;switch (type) {<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;case AMD_IP_BLOCK_TYPE_GFX:<br>
              &gt; &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp;result-&gt;ip_discovery_version =
              adev-&gt;ip_versions[GC_HWIP][0];<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp;result-&gt;base.ip_discovery_version =
              adev-&gt;ip_versions[GC_HWIP][0];<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;case AMD_IP_BLOCK_TYPE_SDMA:<br>
              &gt; &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp;result-&gt;ip_discovery_version =
              adev-&gt;ip_versions[SDMA0_HWIP][0];<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp;result-&gt;base.ip_discovery_version =
              adev-&gt;ip_versions[SDMA0_HWIP][0];<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;case AMD_IP_BLOCK_TYPE_UVD:<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;case AMD_IP_BLOCK_TYPE_VCN:<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;case AMD_IP_BLOCK_TYPE_JPEG:<br>
              &gt; &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp;result-&gt;ip_discovery_version =
              adev-&gt;ip_versions[UVD_HWIP][0];<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp;result-&gt;base.ip_discovery_version =
              adev-&gt;ip_versions[UVD_HWIP][0];<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;case AMD_IP_BLOCK_TYPE_VCE:<br>
              &gt; &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp;result-&gt;ip_discovery_version =
              adev-&gt;ip_versions[VCE_HWIP][0];<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp;result-&gt;base.ip_discovery_version =
              adev-&gt;ip_versions[VCE_HWIP][0];<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;default:<br>
              &gt; &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp;result-&gt;ip_discovery_version = 0;<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp;result-&gt;base.ip_discovery_version = 0;<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
              &gt; &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;result-&gt;ip_discovery_version =
              0;<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp;result-&gt;base.ip_discovery_version = 0;<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;}<br>
              &gt; &gt; -&nbsp; &nbsp; &nbsp;result-&gt;capabilities_flags = 0;<br>
              &gt; &gt; -&nbsp; &nbsp; &nbsp;result-&gt;available_rings = (1 &lt;&lt;
              num_rings) - 1;<br>
              &gt; &gt; -&nbsp; &nbsp; &nbsp;result-&gt;ib_start_alignment =
              ib_start_alignment;<br>
              &gt; &gt; -&nbsp; &nbsp; &nbsp;result-&gt;ib_size_alignment =
              ib_size_alignment;<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp;result-&gt;base.capabilities_flags = 0;<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp;result-&gt;base.available_rings = (1
              &lt;&lt; num_rings) - 1;<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp;result-&gt;base.ib_start_alignment =
              ib_start_alignment;<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp;result-&gt;base.ib_size_alignment =
              ib_size_alignment;<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;return 0;<br>
              &gt; &gt;&nbsp; &nbsp;}<br>
              &gt; &gt;<br>
              &gt; &gt; @@ -536,7 +539,7 @@ int amdgpu_info_ioctl(struct
              drm_device *dev, void *data, struct drm_file *filp)<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return copy_to_user(out,
              &amp;ui32, min(size, 4u)) ? -EFAULT : 0;<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;case AMDGPU_INFO_HW_IP_INFO: {<br>
              &gt; &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct drm_amdgpu_info_hw_ip ip =
              {};<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct drm_amdgpu_info_hw_ip2 ip =
              {};<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;int ret;<br>
              &gt; &gt;<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret = amdgpu_hw_ip_info(adev,
              info, &amp;ip);<br>
              &gt; &gt; diff --git a/include/uapi/drm/amdgpu_drm.h
              b/include/uapi/drm/amdgpu_drm.h<br>
              &gt; &gt; index b6eb90df5d05..6b9e35b6f747 100644<br>
              &gt; &gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
              &gt; &gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
              &gt; &gt; @@ -1128,6 +1128,9 @@ struct
              drm_amdgpu_info_device {<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;__u32 enabled_rb_pipes_mask_hi;<br>
              &gt; &gt;&nbsp; &nbsp;};<br>
              &gt; &gt;<br>
              &gt; &gt; +/* The size of this struct cannot be increased
              for compatibility reasons, use<br>
              &gt; &gt; + * struct drm_amdgpu_info_hw_ip2 instead.<br>
              &gt; &gt; + */<br>
              &gt; &gt;&nbsp; &nbsp;struct drm_amdgpu_info_hw_ip {<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;/** Version of h/w IP */<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;__u32&nbsp; hw_ip_version_major;<br>
              &gt; &gt; @@ -1144,6 +1147,17 @@ struct
              drm_amdgpu_info_hw_ip {<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;__u32&nbsp; ip_discovery_version;<br>
              &gt; &gt;&nbsp; &nbsp;};<br>
              &gt; &gt;<br>
              &gt; &gt; +struct drm_amdgpu_info_hw_ip2 {<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp;/** Previous version of the struct */<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp;struct drm_amdgpu_info_hw_ip&nbsp; base;<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp;/** The maximum number of IBs one can
              submit in a single submission<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp; * ioctl. (When using gang submit: this is
              per IP type)<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp; */<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp;__u32&nbsp; max_ibs;<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp;/** padding to 64bit for arch differences
              */<br>
              &gt; &gt; +&nbsp; &nbsp; &nbsp;__u32&nbsp; pad;<br>
              &gt; &gt; +};<br>
              &gt; &gt; +<br>
              &gt; &gt;&nbsp; &nbsp;struct drm_amdgpu_info_num_handles {<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;/** Max handles as supported by firmware
              for UVD */<br>
              &gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;__u32&nbsp; uvd_max_handles;<br>
              &gt;<br>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------iQn8oTQyEK4sVy1qTWD8sFIi--
