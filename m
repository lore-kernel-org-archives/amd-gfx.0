Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94418C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Apr 2022 14:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B5810E0F6;
	Wed,  6 Apr 2022 14:36:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB0B10E0F6
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Apr 2022 14:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEgxHqRcFyCFYV68F1RXAnL5ce5B3zf9eKQsRDim7gobFkZIZ1dHS1zRCe3uwWwOv8Mbyn+jeb4i86X0BjbCsU9aWLBrZzPZBGbK9gNSXKpMnc23AU3e1ekUu9X/2g+Nu8tdiaJTT4n46C8BPIJMNARoPsJNVuw6st8ni2fz4frKzmCJqjGtlq0Ix6yca7SiL+UdC1dOFB1CgY+YqDFRsFSe/9SOTQ+ZQo1fDUtRqlQzQfdYsC/5BMSLd/Xk6ma91XMO8wUPDjNuPF8wtT4Sy0p/JAZzuWDFmOHnUv5xouzJV8OC8GhazFwC+ah0xuHKdmeWs9CQ69B2ycebE2AUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xII2JF1fmehlp2UpUew4kiYynazZwpUAtGRSZ7ns/Pk=;
 b=Mqcvgid84cwYgvhDnQnJMoXQyvmCwAP08eJjR5Zpc8IjRNajEEzwTsANeEWbJfk4v34acP6Wz5/B9fJBz+OPbsf0LsxQfBb1FfFMFZmUCyul5RPv3EInFyOhKV1DEnNXi0aTjGKOLNDXJ/16eAkxhJSq5UlUKHSmTNGKA/IwSKoXzDWSTUUDWPBpziBdClsHawITnnnmeoY6Mrs34NCLKc7KCXqLddSOvOuaVDavNopEX31seb4KfghtncPdx598jAUYRphCQyccuRuH2XG2UtIgnFTQl6s3R8TMfVWh2Uq8MC2QRdHQt8UEaAKlZN1TDSLrvZq67Px5JtYh287hyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xII2JF1fmehlp2UpUew4kiYynazZwpUAtGRSZ7ns/Pk=;
 b=GiuteGgbjZOfjRJKWlCny9XO8GXDOQXTovc7rRFl8PGjUKPwTxz66YcYK4rU5iNV82Dx2sZZ9Vg+W21P9w00mGD2fCeGx8oqITz7SWnrfm7AEaTQxRu7KRCKJ3oP3uiHgV5KVLEzZuoQwY/lvnCato3DAsnQelisXI19KXH3ZYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB4896.namprd12.prod.outlook.com (2603:10b6:5:1b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 14:36:43 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%6]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 14:36:43 +0000
Message-ID: <990573e7-bc0e-0c3a-11b9-c725fdee44df@amd.com>
Date: Wed, 6 Apr 2022 10:36:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
Content-Language: en-US
To: Shuotao Xu <shuotaoxu@microsoft.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <PSAP153MB051776C60FFB06BB3278EEB4B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
 <2cdfcdee-bf4d-006a-19c1-c806feb4100d@amd.com>
 <PSAP153MB0517571E0AECDB007D90A8F3B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <PSAP153MB0517571E0AECDB007D90A8F3B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0014.prod.exchangelabs.com (2603:10b6:208:10c::27)
 To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a88b7e38-6dc1-454f-9a88-08da17dadea8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4896:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4896800508D0D1AE4D1C7217EAE79@DM6PR12MB4896.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sPWdG/lYeG6Ah7gnhhULD8Rq1vbp+4hndOgMPgTwbBaVwOx/0MzXgyoh2MnDoOAsH6d31dKKe6bZqS2s6n2QxIPOJVYNEZa8on6eHR0NmulGqcpj0U6wBdIrhdKHTlAFPs8SgC9g8Mxyd5YWOnvIcO8oU981iSBOjOJoYWweuQZg79xBHnYo2I37lM7/IAY2EQhcxO3mwaGZmklQNegl/yvrwiTRhBpL8IfMD/ha7bUFGrgdMOVHVd0T939VtiVAb5jwSIA6ZOM+eHmaA+RLaPe7mwWGKA2D3CH3lJ1iZX2HeoYO1hUux9ApefHFvHYy6tD/e0wFEq/4VG/Kzq/B0zRj9i2hbNnicBLbjNBuMx7JSWu1jLTz4ERe4V+75Vn5Ulv4YJoaNGxps5zSV+pnJxYJA3chwxMcrCiIHSNkkZzqtatlHJ+Y5s8Z1hjHKSccdxFWGkU0ULYjN6VHlXQM/OId/hbTByBIYn4JBzyKniG1a4GMV2t7kzMbPiD++Szt/qB+AzUxKwfK3JmILBUS6Bn7MUdctsyxyYL6X+hF3qfXt3BXiNDDn9D9JzMCPh/68gKMhxjX0L5hBaLVRRhsjpVmCmISibhLfOaEKxwTSWIlBHBe64F2b+QOOzkNYPhiOBtrssoAwm/uFX1yRwc20MBlW9FGXupC4ChjAsXxTXIv3LigdG7GrhLJoNaD8CZ+OsB8YhiZu93QqnqRsJutq13FTIPjqZcE7oiAKgQ7xrM9tD+RVzxX9EDtEFt1ea7qudVlhSazb3nrvV0s7RYqxUAbm6HOjB/RpK9bEJJh9UOSYx2htQgHm4BjhmB2TBxvnwU0DXXvH7tF4yxM0ugSMVTz6rBkpQ1ayIqHkBF0wV65IaTEs2XwiK5uFXbGU4lOwTgJG5S8igc7uySt4mrC5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(54906003)(316002)(966005)(6486002)(508600001)(45080400002)(38100700002)(16799955002)(36756003)(31686004)(86362001)(31696002)(83380400001)(2616005)(186003)(6506007)(53546011)(6512007)(2906002)(44832011)(5660300002)(8936002)(66476007)(66556008)(8676002)(4326008)(66946007)(45980500001)(43740500002)(10090945011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXduMG9kOGpiS0p4U3dXWkxrWXpHcVdkRXYzR3NPSGlMR25BQ3RieW9pbTRX?=
 =?utf-8?B?NjU2QWw2c09NWWJJUW1RRmlDd2xMOUVZQnU2LzlGZld4S2FXeS9kMDVVRnBs?=
 =?utf-8?B?Zk04UlIya3FxaEVFVGRad29nYkJJM2FHcUhVQlZ6MW9HSlRrQUZUWkwvUVNU?=
 =?utf-8?B?Zy9ITUlWazk3cE1TeFd4V2Q0ZWlpVnhnZVBYOWJxUjBQSi93UFc1N0lXRytF?=
 =?utf-8?B?dDU2blF2a1BHaDAySXNmUEtzZ3N1WHMwa0pKNkRsWXE0d1RBcnVDNWVxSGNv?=
 =?utf-8?B?czZlTmtlYi9kbUNOSVpVU3ZJQXN1WjBZS3RYN2FRRmxVbGpzM3g0TVdjMzNX?=
 =?utf-8?B?ZWMwZDI5ZkUzSmlkaU10Z1had1RHUnB6VU1Xc3FZT21QRGhZK2U1eW9haGk5?=
 =?utf-8?B?SE50MkR0VUVWbjlUaWZlQndYclY2eUNHTnZoZkVyc08zbzFNemozVG8xUzdz?=
 =?utf-8?B?ZTJCNm16ajN2WEJDbEJVWFY0TDF5Vkw5VkpSTzcvbDJVSk8xU0FEL1lqbjFn?=
 =?utf-8?B?d2NENnhiVXVLejhtb2ZuZVN1a1hzQzRsbUNmR2doVmdNS1VjRzJNVnFjM2gv?=
 =?utf-8?B?bnBTWHpTaEZrWTMzNGFyODJlS3FjNkxPdTQzb2xuanBadDVPUk4xVXVuTUxu?=
 =?utf-8?B?T21CVkM0Sy90Q0J4VXdKOWxISE0xdFExTUcyNjM1OFVpVEQzdGl0eGFZQnM4?=
 =?utf-8?B?Q05vdTNON3lSMGVSOHcvOWllYmxScWU5MEtmSkRxeWM3NzJFZnlrNjBnY2ZB?=
 =?utf-8?B?RkJ2eGFMdEpmdWdZcEpOV0pkOTFGUlcveXVYQURrUnBwUk1jRDZEOTFubGdN?=
 =?utf-8?B?VVN2NDczb3VJWXlXbnJPSmkzdDhIUUYwMTRKK1IwclB0KzJLQzBERXNYc0tZ?=
 =?utf-8?B?NDJwWlViNUZSc1FmUjREaUdvdmNFeEE2ekMwbVRqbVRDbVB3UUtHN1ZVN1o2?=
 =?utf-8?B?V0hMMUdXQSt1U1l6WEVveUN5YzV6S0FUVXRuQW54a2ZMd3RrczlMZDE0VUor?=
 =?utf-8?B?RG5MZ2RXK2Fsd0ZXYzgyZFpqaktxb2xjNnBOYmtEckZXVE9mM3FYczNtRFlW?=
 =?utf-8?B?V0NnclV1ZzNQTjUxQ3hHZVBUZnRlWS9qTThjWG55elFVMGcrV043djMrMTBU?=
 =?utf-8?B?cEN1R014K2lDb0RGdXNISVJlL3dPSENlUlRrSEdvWStVdHdldWllalVoL210?=
 =?utf-8?B?ZmkxOUcyZmltQWVPN3c3cHlvR1ZGaytmNzh4bHFoVmhFV0F1dCtzcmFrVVZq?=
 =?utf-8?B?b1VtMzlJS3FlTHlRa2sxdlMwWHVMYzcyNjBKNDk5aHNHU0dYWUdGVFNEa3FB?=
 =?utf-8?B?dEhLaXJHUXZhWGtWTENwMkRJS3FIWk9qOEM3OElkei9VYUhCczI3NzdiTHhN?=
 =?utf-8?B?N01HSC9BQ1pLczR3b2tNMkl6L0Z3SjdVWDRPZGJTZFF2MjBkYmcwWS9EcE8x?=
 =?utf-8?B?bHpBTS9iTUlGdjdQNVhsSzF6LzhYR1R0b0w5azFhdG4waE5IRUhRTUtLVlo1?=
 =?utf-8?B?Z3ZqeFhFdlZ4bzRPTVNPQ29Jc3dRR0VQVHJGTmR1OTdadGlkU3pCTFNHSmZy?=
 =?utf-8?B?bTgvRzRzU0dyRWE0cGhDUUViS2duNW0xbEphSUt3NS9HcS8rYVROSG1GdG5H?=
 =?utf-8?B?ZjQza0tFRmF5L3B0MWxuNktaOEZqRHhpY2twTmxxRXB5czNFZjc1Q3VsbGhq?=
 =?utf-8?B?QlNWRmxIUWUvcEFNWW9ZUXhRdm51VVNCbkM3MEhOek9aK1JMazM0cHh4ZU5F?=
 =?utf-8?B?VTQxTEVlWXpISVdFY2hiWVRndDF1eHUwTllSWFIvNlYxYStBVDBtT00yZUNx?=
 =?utf-8?B?bnFKODdoZUNsRElVbThMSXk4SS83cnEwMHZscHd3MFdjbEYxVm5HeElXQUc3?=
 =?utf-8?B?WE9XNGthTWVkay9sNGlDNWZrSmVSRkZrVW5KNmZ6U1F1aTBqOEVaMjcvenVZ?=
 =?utf-8?B?R3NGQlJBZXRNVjlQOU5OMHBvVGxPOUkzNVhSOHFienBBcHd2Zlo5QThHcDV0?=
 =?utf-8?B?S3VUK1RkNHNibWFBakFFNW11MEpXRlhzRS9BMDBiTlMwOXVDcTJCZFRBTWta?=
 =?utf-8?B?YWxXVDdOeVRSeTdZTm9OVDRSZ0x0RFJnUXhmcTlOY0l4UVh3R0V4RzRLSC9j?=
 =?utf-8?B?TE4wVGVHVnhHODFQUDdiVGpMa3h1cFhFbGxiWVEvckl2V2s3aGVVNi82KzJr?=
 =?utf-8?B?M1ZhVHJCSGE4ZUR6eUFNaXl5VDg3TXcwU2w0cDRwMzYwV1o0LzNVSyt0VWtB?=
 =?utf-8?B?NnMzZWhqK3NVdHYxMStkak1CeElSMVJpTWlkaVVYTGxSUGJGM3VUeTRzU04z?=
 =?utf-8?B?aVdXaEkxNmpHNm1PNzNmM0EvQlhuM3J5WWVIUmI5WlNGbnVxcEFIVmV0NEV3?=
 =?utf-8?Q?Vey84BEST17ejcWRmOsc9zqDOjdhDwFOQJD+YxYfcprUl?=
X-MS-Exchange-AntiSpam-MessageData-1: 6rztW6iIiLLMxw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88b7e38-6dc1-454f-9a88-08da17dadea8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 14:36:43.3809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7hCumpqz1X/eFdht4C7waCbiKZDJlDaxS1xHk8iLs1btpeVdvajUlZ8ix1h56WF4YUOw6FVLykUQZzoOsmKMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4896
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
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com>, Lei Qu <Lei.Qu@microsoft.com>,
 Peng Cheng <pengc@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Can you attach dmesg for the failure without your patch against 
amd-staging-drm-next ?

Also, in general, patches for amdgpu upstream branches should be 
submitted to amd-gfx mailing list inline using git-send which makes it 
easy to comment and review them inline.

Andrey

On 2022-04-06 10:25, Shuotao Xu wrote:
> Hi Andrey,
> 
> We just tried kernel 5.16 based on 
> https://gitlab.freedesktop.org/agd5f/linux.git 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux.git&data=04%7C01%7Candrey.grodzovsky%40amd.com%7C86a376e9139548aab4ca08da17d9621f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637848519676249428%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=wdPzJJBPVGWulUhyAyaI1Jtq4uD%2B80aBo7PDBpIjmQM%3D&reserved=0> 
> amd-staging-drm-next branch, and found out that hotplug did not work out 
> of box for Rocm compute stack.
> 
> We did not try the rendering stack since we currently are more focused 
> on AI workloads.
> 
> We have also created a patch against the amd-staging-drm-next branch to 
> enable hotplug for ROCM stack, which were sent in another later email 
> with same subject. I am attaching the patch in this email, in case that 
> you would want to delete that later email.
> 
> Best regards,
> 
> Shuotao
> 
> *From: *Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> *Date: *Wednesday, April 6, 2022 at 10:13 PM
> *To: *Shuotao Xu <shuotaoxu@microsoft.com>, 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc: *Ziyue Yang <Ziyue.Yang@microsoft.com>, Lei Qu 
> <Lei.Qu@microsoft.com>, Peng Cheng <pengc@microsoft.com>, Ran Shu 
> <Ran.Shu@microsoft.com>
> *Subject: *[EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
> 
> [You don't often get email from andrey.grodzovsky@amd.com. Learn why 
> this is important at http://aka.ms/LearnAboutSenderIdentification.] 
> <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Faka.ms%2FLearnAboutSenderIdentification.%255d&data=04%7C01%7Candrey.grodzovsky%40amd.com%7C86a376e9139548aab4ca08da17d9621f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637848519676249428%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=5VSq8jQN%2FXrj0SG%2B7Tv%2Bz29O0pE3eb9CUevGBiX1Bxo%3D&reserved=0>
> 
> Looks like you are using 5.13 kernel for this work, FYI we added
> hot plug support for the graphic stack in 5.14 kernel (see
> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unplug&amp;data=05%7C01%7Cshuotaoxu%40microsoft.com%7Cf1f7980b198541d7196d08da17d79838%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848512015144682%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=26qOd5vKzOigo0SaSc5%2FF8BOI9yzRlqC08xUMC01Jzk%3D&amp;reserved=0) 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unplug&data=04%7C01%7Candrey.grodzovsky%40amd.com%7C86a376e9139548aab4ca08da17d9621f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637848519676249428%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=8GPGb%2B9bgMH3ZgbFUeChtP0hxOMRKwt7Q4it%2BEC%2Flfc%3D&reserved=0>
> 
> 
> I am not sure about the code part since it all touches KFD driver (KFD
> team can comment on that) - but I was just wondering if you try 5.14
> kernel would things just work for you out of the box ?
> 
> Andrey
> 
> On 2022-04-05 22:45, Shuotao Xu wrote:
>> Dear AMD Colleagues,
>>
>> We are from Microsoft Research, and are working on GPU disaggregation
>> technology.
>>
>> We have created a new pull requestAdd PCIe hotplug support for amdgpu by
>> xushuotao · Pull Request #131 · RadeonOpenCompute/ROCK-Kernel-Driver
>> (github.com)
>> <https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&amp;data=05%7C01%7Cshuotaoxu%40microsoft.com%7Cf1f7980b198541d7196d08da17d79838%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848512015144682%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=u2NtNDfuiCfKNKqeZ337KLq2uRDB1oGyO3%2BxIMQweRA%3D&amp;reserved=0 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&data=04%7C01%7Candrey.grodzovsky%40amd.com%7C86a376e9139548aab4ca08da17d9621f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637848519676249428%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=qjShnpesp%2F0P1qFSeAPjF2Oc5Dh1tfnUPy4EcLUxylU%3D&reserved=0>>in
>> ROCK-Kernel-Driver, which will enable PCIe hot-plug support for amdgpu.
>>
>> We believe the support of hot-plug of GPU devices can open doors for
>> many advanced applications in data center in the next few years, and we
>> would like to have some reviewers on this PR so we can continue further
>> technical discussions around this feature.
>>
>> Would you please help review this PR?
>>
>> Thank you very much!
>>
>> Best regards,
>>
>> Shuotao Xu
>>
> 
