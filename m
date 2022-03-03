Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E98C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 16:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF74010E281;
	Thu,  3 Mar 2022 16:36:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1DBA10E281
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 16:36:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8oND88zp42/2M1MYimiEdZ98fLM/xfs44TRGlZe0uCXHih3iHAbdFw6MT3SJonx7Zy8sdJBdnxwM9aY0g4r/MC7SdZUU51wkbGGJF52076s96Zumt2CGSBF5BznGGd71HzNUr+UYK1fmgrb42KmIRAfa6ATq6up9vbMeu6z/a/3yQiw+r2TOm6DqK+KcmUiQWctFi4hVUrlwW3kNYFDEyYV5YF6lwWekjXuGVjHcsRYZ4Nlv9Wod3bYFVFLXx/Db/v0jWbZ915VuqFCP3SzaD/Nf02d0BRqfAK8GGwM63o8ZLaEuNpKcOD4KhJS6IKz8Ja8VI06NGgJQcwdqQA5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WacFb7A9lj/mD3faaxNLk9QAJMh6wWUIF2Rw6X9XDCY=;
 b=cRQLoWDdWgDbs4snIMk2GUpjoXwCgaYGiAmi1WToMhU42z1iXN8wSjiOM65pFZi4EOCUum4twWXfNFjzZfoGHQMKijmQrnhBCEGiE97BAOK0YpgHeP+qSsH7yoaotB1nzV0kpZhFNcEW+BWEg/qK9F+SNUcsSWJESnNIp1+YBDHOuGNWyafJocYtbRVPMos4uM3p9+Z5LKpX8lZQcGQr3wejm+IuJSj2dC2+EalFCtrixRTEyoyyc1IapSSnEIRrQkX+Kn4DU86AxTqqf1DMFOQxiMtw3zi13RNZL8SeJQJhNXPEhVkS4fZf/lrW4LJtugRoBpYtLGMLjV67ApEkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WacFb7A9lj/mD3faaxNLk9QAJMh6wWUIF2Rw6X9XDCY=;
 b=qFmAimMR6MNFVPPhw93rGb7vguHTLrApdMyFjXGA4CoGlUUj8IiD7k3YAq0+j0GIkMlSEKmNN/6LmFeYZJF1yaAAwdPhW4f0pDrGIR11I+oLFy79pwEj/FPCjPymeSI51Mvs2dvCy3tWazU8L/mgtDgpZdnNL2A3aEJAZjQOcC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BYAPR12MB2647.namprd12.prod.outlook.com (2603:10b6:a03:6f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Thu, 3 Mar
 2022 16:36:54 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 16:36:54 +0000
Message-ID: <1f4c7682-790a-7c71-33e2-0d2277b642d1@amd.com>
Date: Thu, 3 Mar 2022 11:36:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC v4 02/11] drm/amdgpu: Move scheduler init to after XGMI is
 ready
Content-Language: en-US
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>
References: <20220209002320.6077-1-andrey.grodzovsky@amd.com>
 <20220209002320.6077-3-andrey.grodzovsky@amd.com>
 <d82ac1a0-d81d-9861-fc1b-8cc06017a2b5@gmail.com>
 <1d7cb471-c32c-416c-4336-317ee9f171ef@amd.com>
 <3752a89c-d468-8c39-03a9-37d592dae89f@amd.com>
 <48c207dc-cc7a-efda-a4a8-4f1f1a6511fe@amd.com>
 <BL1PR12MB514424A75728E78BC0E5B848F73D9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <91b8771b-695d-b126-13ec-50dddd56f200@amd.com>
 <7c07d1b7-e700-60f3-1114-f1386892e836@amd.com>
 <9df3a044-a0a6-cdea-887a-82e7cc9f47eb@amd.com>
 <f36352a4-78a9-8e4b-4ec4-8722240d445d@amd.com>
 <0049c754-2af6-0558-3278-620faa4ed7e3@amd.com>
 <C3715E75-B013-409C-B2A3-E10CD79FD027@amd.com>
 <7e9dc4ea-3665-7632-280f-9e8ed8948b45@amd.com>
In-Reply-To: <7e9dc4ea-3665-7632-280f-9e8ed8948b45@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0415.namprd03.prod.outlook.com
 (2603:10b6:610:11b::26) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d81b920f-31de-478b-e812-08d9fd340637
X-MS-TrafficTypeDiagnostic: BYAPR12MB2647:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2647130D74E9771BE0AF43B1EA049@BYAPR12MB2647.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPX4GebFiezbfT4SCPxE59Fil1a/QHMGxXnpAROFV2+EoxZHKCJuVv+9z/wmCHcy1DjWRB1B3unQz+x+Ni9ZfZ3fC6A7WeKEaUbMmuJz9A3h+0FDi9g/jB3txlNaozDYh4Agodq6h4eNPE/kISnD5mVu5JhkS+/WM4ZtYzWJtpjXVrxxk8lUFbPYn0gyKV4I6Yimh9D2n01GBT4G+hYyvweaRcJbdlNmzPb9Ju/7HZIo4+VIJHCs9OKg4kwtaTrN50yj+n+vnfReIbfrwqhFxx3e0rHBrsDsbKyXlWeon67WgFDRMc7/YiFsYepE4Z95kqcNbABUSyVYKBaNfj3IvOjmgh7A3NrbEbxyGkjjAWcTExN3bjU0JrZFzQll2vsfsQm7k+WeeG/HVRVuq71Ioc7fHjqIne15g6IrEqoDp3HBElcX714WyJKLlWYtDVCl8nnZYaIkdr489tEczQ5R+MhtruOB42aXgusywq4DmKF2deh4EJr4A7D29ewMFI7JMC3nItfnlGehKAaBstzkx85+2yLPL5CkDCOTgmh+mWYKa8ewsF3Q3ktNPFm+DuZZlFl9+vm0DdTzz1TH3xFX+AzbO5abF5+Zvugu+eAmjJCHU7xjiUeqEtRJ03xav49BkI1s5g03sxuVnG8BTwfPlEPTIndhevic4Ra4di41Ly5MuQ1uzdIYnXlRzEcBwABREPmQb126SH8QCM9/MXNV6og3Zls/6Eoqe0++LEGN5zk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(66556008)(6862004)(66476007)(8676002)(8936002)(31686004)(66946007)(53546011)(6486002)(4326008)(86362001)(5660300002)(30864003)(6666004)(316002)(6636002)(37006003)(54906003)(44832011)(36756003)(508600001)(31696002)(38100700002)(6506007)(83380400001)(2906002)(66574015)(6512007)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MllpQVFyVWFvNzBZcURVb05FQjJRb0k2SFErVzBhOHRIczZ6UEpEWDR1dVEr?=
 =?utf-8?B?QUE4dFlQN1NzckhqU1VGN2d2UHhUaloyWXFFWHNKaUFiM29DUnBZMVpxYnB4?=
 =?utf-8?B?S0I0aWFCWWNNQk5VT3ZIVkdKWlVnTkRVMTBVTkNOUWhuSDBNTVprN3pxd2g0?=
 =?utf-8?B?ejdDSDk4TmNVTkQ5azNQUGd3N3JzV0VMSmlhbXc4a1JXYWdrMStCUFk1Z1h1?=
 =?utf-8?B?aG1IcFc5ZFZOdDZkV0poa0kyK0RabllkQlRhNXd2cDQ5NERLeEdxTStLRDhG?=
 =?utf-8?B?dGl6TmxsWkRHT2lteEE3RmlzTys3ZGlLTktRU2NVRjhkUkVnWEYwUUR3ck1L?=
 =?utf-8?B?REZZL1FqeEpuYlJnU2pTVTFKMlUzOVFJUW9RYUNNY3JEdVg2UDlWcFZlVlRH?=
 =?utf-8?B?RmZrZUs0MzltQnRYdHhVS2ZoSCtjRW05S2c3TWVBTU5KZzBwa0xFRzM0NEtQ?=
 =?utf-8?B?S1p3OUpIdWpBOUpRdDFjbzJNWnNyT202UmtJMzFYeTFXN1dsaTVuMy9HN2Nx?=
 =?utf-8?B?d0pqcGVKZXNIcFVsOVNzTHhqYVIxQWNSazlYVkdUek40d1loaVVSY3BkRFEy?=
 =?utf-8?B?L1hqS3FQYTFXWWtkZ2s5SFBIR0RGdkJLbEhnajR5N1NsblVLTnJ6a0V0QnAy?=
 =?utf-8?B?QnRTdUZSeWNCbW9mRERHK05rL1JQbGQwZFg3TDV4YnJMMmhNTkRjS2ZQbS96?=
 =?utf-8?B?RFZhTlFSY21tbUtuYkFmeXRnWG8xWlNvSExHZTBFTEVvT2hOaVRpQWVCREs4?=
 =?utf-8?B?WXJMNVBkNWJNRWpGL3gwWFVXbkJUZ2RIUHBJYnFPVnp6cTcweXZ5MUhkWFkw?=
 =?utf-8?B?U1FwZ3hvcDkvN2NRbENUeGlGSHBheUl1T0VmVmh0K0lKVlA3MWlvcGtNWm44?=
 =?utf-8?B?L0xKRWFwbE9XU29VRVpiaXlBbjk4cE9uQ0pjMnF5c3M0TUFsbGVVRGxwWnhv?=
 =?utf-8?B?VDdFTFdDMHFqa2hWV0wyK213RFhRUVJ5Y1lVaW91Ti9CYmFFdGhtaWoxTTRF?=
 =?utf-8?B?RnhrR1UxMjJkb09ueTduNjF6VGRic1RLK0xYNUZFOXJETFNrUWVaUmV3V1JM?=
 =?utf-8?B?ODJWUzVRR1VhSmt0OHFDK1dnRHEwd25ad0xWamZjNU05SUVGdmNGL05DVzJx?=
 =?utf-8?B?RGtVZjJlb0tScXNUK3daNEJnbVJDeVRuWVE1dlRMV2JhNWQ1dGsxQ0V0WFhU?=
 =?utf-8?B?dEcwOHZnaHRJV0E0Tmd2aUVtVFBTUHJxNE8zSVc4OGNXc1J0LzUzaDBsalBQ?=
 =?utf-8?B?aU9ZS0xMM1VWVTQzY21XaVc2QXlRbStNdEZaN1hWanh1eEFjL3ZoWEhUZ2w1?=
 =?utf-8?B?U3ovUjV6UEpxSHZlNXNyejhLZVlrekcwb0pXSmFvVjhLSHNlQjY1MTFtYi9w?=
 =?utf-8?B?V0dmejJBUUZoQmJpcWFXc1dTM3BrT01rWWtIc1ZlcWtxNDBCTXZ1VUJPQkYy?=
 =?utf-8?B?TWhtRXZUV2h0alJ0WE1MTnRydkpxVDZHKzBQNFUzbTBYOVMwMlU0TjRMcTNX?=
 =?utf-8?B?VEZWbnZwOU1aZHR1RUhLK054QTdBOTkyelMzU1VObm5mQUVIR1FIWi9UUGU2?=
 =?utf-8?B?ckFXUUxtRHdhb2RGcjZNSW1RSk44bURrazZtU0ZzQloxbzI2SFlHV3BneGFr?=
 =?utf-8?B?ZFNFemltdXMyYURQNDFHdmFBWlZUdC96TXBhVnZSWk0wVDc2NVdrMlc1NVJ4?=
 =?utf-8?B?ZytIM1RUVC9pVGtkbnFhc25vYnI0d2h1ZEVSb3lMQmRtVXZnc1c2b2MzT20y?=
 =?utf-8?B?ckRqQXpxc3JEQ3NyV2pUUmpycXBMUFJ6dUFPRnRLd2ZBVHJnTlNFZVB4Y0sr?=
 =?utf-8?B?N0pXT3dEUXlocXduN2xGSlQ5a3JIeDlEWG9RSldZTVFOWHQyQm5Ob3BQTzFZ?=
 =?utf-8?B?S2lXenI1QWZ3OGxyeDY2YXQ3NVF4ZHJWRGNUVDM1VnhObmM3TUNFb2xmR3RD?=
 =?utf-8?B?TzVSVnpFR2pWN1V0U2x3SWhlQk13U0toWUVJc2s2TVlORUZLbXdtd2VKVVY2?=
 =?utf-8?B?TjZxSGhndVB5TzFOL3JjYVhvd2VYL0EvSHU2QXJiWTBKeldpSm92Z29kOXVm?=
 =?utf-8?B?ZkNhUFJaY29SQnVlclQ3ejJwUFZYeXdTZEdYRExFanBXWnIycW9DT3NiWnRZ?=
 =?utf-8?B?WnFpNWpUZy96cXJnOVFoWHNTWThwNUVuU2VXVllGNVU4NFlYd3ZGOHcrZDA3?=
 =?utf-8?B?dkVEaTk4NTVabXdpT3BzMDFHNVAweHozQzRCNmQ5L3ZEZmozenBWd2lQNHNp?=
 =?utf-8?Q?KuyvqGlWteDY8UA8B27/RsDDAqaQ/RDQPuoOvtiV/Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81b920f-31de-478b-e812-08d9fd340637
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 16:36:53.8776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJ4VwkUqf1On0vsIAUm/skwPktiyaqrZZNEkZi359deE6w0m1XCyMt/yt4Ycrw2E0Tho86QsQQshUTmYga3MSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2647
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I pushed all the changes including your patch.

Andrey

On 2022-03-02 22:16, Andrey Grodzovsky wrote:
> OK, i will do quick smoke test tomorrow and push all of it it then.
>
> Andrey
>
> On 2022-03-02 21:59, Chen, JingWen wrote:
>> Hi Andrey,
>>
>> I don't have the bare mental environment, I can only test the SRIOV 
>> cases.
>>
>> Best Regards,
>> JingWen Chen
>>
>>
>>
>>> On Mar 3, 2022, at 01:55, Grodzovsky, Andrey 
>>> <Andrey.Grodzovsky@amd.com> wrote:
>>>
>>> The patch is acked-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>
>>> If you also smoked tested bare metal feel free to apply all the 
>>> patches, if no let me know.
>>>
>>> Andrey
>>>
>>> On 2022-03-02 04:51, JingWen Chen wrote:
>>>> Hi Andrey,
>>>>
>>>> Most part of the patches are OK, but the code will introduce a ib 
>>>> test fail on the disabled vcn of sienna_cichlid.
>>>>
>>>> In SRIOV use case we will disable one vcn on sienna_cichlid, I have 
>>>> attached a patch to fix this issue, please check the attachment.
>>>>
>>>> Best Regards,
>>>>
>>>> Jingwen Chen
>>>>
>>>>
>>>> On 2/26/22 5:22 AM, Andrey Grodzovsky wrote:
>>>>> Hey, patches attached - i applied the patches and resolved merge 
>>>>> conflicts but weren't able to test as my on board's network card 
>>>>> doesn't work with 5.16 kernel (it does with 5.17, maybe it's 
>>>>> Kconfig issue and i need to check more).
>>>>> The patches are on top of 'cababde192b2 Yifan Zhang         2 days 
>>>>> ago     drm/amd/pm: fix mode2 reset fail for smu 13.0.5 ' commit.
>>>>>
>>>>> Please test and let me know. Maybe by Monday I will be able to 
>>>>> resolve the connectivity issue on 5.16.
>>>>>
>>>>> Andrey
>>>>>
>>>>> On 2022-02-24 22:13, JingWen Chen wrote:
>>>>>> Hi Andrey,
>>>>>>
>>>>>> Sorry for the misleading, I mean the whole patch series. We are 
>>>>>> depending on this patch series to fix the concurrency issue 
>>>>>> within SRIOV TDR sequence.
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2/25/22 1:26 AM, Andrey Grodzovsky wrote:
>>>>>>> No problem if so but before I do,
>>>>>>>
>>>>>>>
>>>>>>> JingWen - why you think this patch is needed as a standalone now 
>>>>>>> ? It has no use without the
>>>>>>> entire feature together with it. Is it some changes you want to 
>>>>>>> do on top of that code ?
>>>>>>>
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>>>
>>>>>>> On 2022-02-24 12:12, Deucher, Alexander wrote:
>>>>>>>> [Public]
>>>>>>>>
>>>>>>>>
>>>>>>>> If it applies cleanly, feel free to drop it in. I'll drop those 
>>>>>>>> patches for drm-next since they are already in drm-misc.
>>>>>>>>
>>>>>>>> Alex
>>>>>>>>
>>>>>>>> ------------------------------------------------------------------------ 
>>>>>>>>
>>>>>>>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on 
>>>>>>>> behalf of Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>>>> *Sent:* Thursday, February 24, 2022 11:24 AM
>>>>>>>> *To:* Chen, JingWen <JingWen.Chen2@amd.com>; Christian König 
>>>>>>>> <ckoenig.leichtzumerken@gmail.com>; 
>>>>>>>> dri-devel@lists.freedesktop.org 
>>>>>>>> <dri-devel@lists.freedesktop.org>; 
>>>>>>>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>>>>>> *Cc:* Liu, Monk <Monk.Liu@amd.com>; Chen, Horace 
>>>>>>>> <Horace.Chen@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; 
>>>>>>>> Koenig, Christian <Christian.Koenig@amd.com>; daniel@ffwll.ch 
>>>>>>>> <daniel@ffwll.ch>
>>>>>>>> *Subject:* Re: [RFC v4 02/11] drm/amdgpu: Move scheduler init 
>>>>>>>> to after XGMI is ready
>>>>>>>> No because all the patch-set including this patch was landed into
>>>>>>>> drm-misc-next and will reach amd-staging-drm-next on the next 
>>>>>>>> upstream
>>>>>>>> rebase i guess.
>>>>>>>>
>>>>>>>> Andrey
>>>>>>>>
>>>>>>>> On 2022-02-24 01:47, JingWen Chen wrote:
>>>>>>>>> Hi Andrey,
>>>>>>>>>
>>>>>>>>> Will you port this patch into amd-staging-drm-next?
>>>>>>>>>
>>>>>>>>> on 2/10/22 2:06 AM, Andrey Grodzovsky wrote:
>>>>>>>>>> All comments are fixed and code pushed. Thanks for everyone
>>>>>>>>>> who helped reviewing.
>>>>>>>>>>
>>>>>>>>>> Andrey
>>>>>>>>>>
>>>>>>>>>> On 2022-02-09 02:53, Christian König wrote:
>>>>>>>>>>> Am 09.02.22 um 01:23 schrieb Andrey Grodzovsky:
>>>>>>>>>>>> Before we initialize schedulers we must know which reset
>>>>>>>>>>>> domain are we in - for single device there iis a single
>>>>>>>>>>>> domain per device and so single wq per device. For XGMI
>>>>>>>>>>>> the reset domain spans the entire XGMI hive and so the
>>>>>>>>>>>> reset wq is per hive.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>>>>>>> One more comment below, with that fixed Reviewed-by: 
>>>>>>>>>>> Christian König <christian.koenig@amd.com>.
>>>>>>>>>>>
>>>>>>>>>>>> ---
>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 45 
>>>>>>>>>>>> ++++++++++++++++++++++
>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 34 
>>>>>>>>>>>> ++--------------
>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +
>>>>>>>>>>>>       3 files changed, 51 insertions(+), 30 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>> index 9704b0e1fd82..00123b0013d3 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>> @@ -2287,6 +2287,47 @@ static int 
>>>>>>>>>>>> amdgpu_device_fw_loading(struct amdgpu_device *adev)
>>>>>>>>>>>>           return r;
>>>>>>>>>>>>       }
>>>>>>>>>>>>       +static int amdgpu_device_init_schedulers(struct 
>>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    long timeout;
>>>>>>>>>>>> +    int r, i;
>>>>>>>>>>>> +
>>>>>>>>>>>> +    for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>>>>>>>>> +        struct amdgpu_ring *ring = adev->rings[i];
>>>>>>>>>>>> +
>>>>>>>>>>>> +        /* No need to setup the GPU scheduler for rings 
>>>>>>>>>>>> that don't need it */
>>>>>>>>>>>> +        if (!ring || ring->no_scheduler)
>>>>>>>>>>>> +            continue;
>>>>>>>>>>>> +
>>>>>>>>>>>> +        switch (ring->funcs->type) {
>>>>>>>>>>>> +        case AMDGPU_RING_TYPE_GFX:
>>>>>>>>>>>> +            timeout = adev->gfx_timeout;
>>>>>>>>>>>> +            break;
>>>>>>>>>>>> +        case AMDGPU_RING_TYPE_COMPUTE:
>>>>>>>>>>>> +            timeout = adev->compute_timeout;
>>>>>>>>>>>> +            break;
>>>>>>>>>>>> +        case AMDGPU_RING_TYPE_SDMA:
>>>>>>>>>>>> +            timeout = adev->sdma_timeout;
>>>>>>>>>>>> +            break;
>>>>>>>>>>>> +        default:
>>>>>>>>>>>> +            timeout = adev->video_timeout;
>>>>>>>>>>>> +            break;
>>>>>>>>>>>> +        }
>>>>>>>>>>>> +
>>>>>>>>>>>> +        r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
>>>>>>>>>>>> + ring->num_hw_submission, amdgpu_job_hang_limit,
>>>>>>>>>>>> +                   timeout, adev->reset_domain.wq, 
>>>>>>>>>>>> ring->sched_score, ring->name);
>>>>>>>>>>>> +        if (r) {
>>>>>>>>>>>> +            DRM_ERROR("Failed to create scheduler on ring 
>>>>>>>>>>>> %s.\n",
>>>>>>>>>>>> +                  ring->name);
>>>>>>>>>>>> +            return r;
>>>>>>>>>>>> +        }
>>>>>>>>>>>> +    }
>>>>>>>>>>>> +
>>>>>>>>>>>> +    return 0;
>>>>>>>>>>>> +}
>>>>>>>>>>>> +
>>>>>>>>>>>> +
>>>>>>>>>>>>       /**
>>>>>>>>>>>>        * amdgpu_device_ip_init - run init for hardware IPs
>>>>>>>>>>>>        *
>>>>>>>>>>>> @@ -2419,6 +2460,10 @@ static int 
>>>>>>>>>>>> amdgpu_device_ip_init(struct amdgpu_device *adev)
>>>>>>>>>>>>               }
>>>>>>>>>>>>           }
>>>>>>>>>>>>       +    r = amdgpu_device_init_schedulers(adev);
>>>>>>>>>>>> +    if (r)
>>>>>>>>>>>> +        goto init_failed;
>>>>>>>>>>>> +
>>>>>>>>>>>>           /* Don't init kfd if whole hive need to be reset 
>>>>>>>>>>>> during init */
>>>>>>>>>>>>           if (!adev->gmc.xgmi.pending_reset)
>>>>>>>>>>>> amdgpu_amdkfd_device_init(adev);
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>>>>>> index 45977a72b5dd..fa302540c69a 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>>>>>> @@ -457,8 +457,6 @@ int 
>>>>>>>>>>>> amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>>>>>>>>>>>>                         atomic_t *sched_score)
>>>>>>>>>>>>       {
>>>>>>>>>>>>           struct amdgpu_device *adev = ring->adev;
>>>>>>>>>>>> -    long timeout;
>>>>>>>>>>>> -    int r;
>>>>>>>>>>>>             if (!adev)
>>>>>>>>>>>>               return -EINVAL;
>>>>>>>>>>>> @@ -478,36 +476,12 @@ int 
>>>>>>>>>>>> amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>>>>>>>>>>>> spin_lock_init(&ring->fence_drv.lock);
>>>>>>>>>>>>           ring->fence_drv.fences = 
>>>>>>>>>>>> kcalloc(num_hw_submission * 2, sizeof(void *),
>>>>>>>>>>>>                            GFP_KERNEL);
>>>>>>>>>>>> -    if (!ring->fence_drv.fences)
>>>>>>>>>>>> -        return -ENOMEM;
>>>>>>>>>>>>       -    /* No need to setup the GPU scheduler for rings 
>>>>>>>>>>>> that don't need it */
>>>>>>>>>>>> -    if (ring->no_scheduler)
>>>>>>>>>>>> -        return 0;
>>>>>>>>>>>> +    ring->num_hw_submission = num_hw_submission;
>>>>>>>>>>>> +    ring->sched_score = sched_score;
>>>>>>>>>>> Let's move this into the caller and then use 
>>>>>>>>>>> ring->num_hw_submission in the fence code as well.
>>>>>>>>>>>
>>>>>>>>>>> The maximum number of jobs on the ring is not really fence 
>>>>>>>>>>> specific.
>>>>>>>>>>>
>>>>>>>>>>> Regards,
>>>>>>>>>>> Christian.
>>>>>>>>>>>
>>>>>>>>>>>>       -    switch (ring->funcs->type) {
>>>>>>>>>>>> -    case AMDGPU_RING_TYPE_GFX:
>>>>>>>>>>>> -        timeout = adev->gfx_timeout;
>>>>>>>>>>>> -        break;
>>>>>>>>>>>> -    case AMDGPU_RING_TYPE_COMPUTE:
>>>>>>>>>>>> -        timeout = adev->compute_timeout;
>>>>>>>>>>>> -        break;
>>>>>>>>>>>> -    case AMDGPU_RING_TYPE_SDMA:
>>>>>>>>>>>> -        timeout = adev->sdma_timeout;
>>>>>>>>>>>> -        break;
>>>>>>>>>>>> -    default:
>>>>>>>>>>>> -        timeout = adev->video_timeout;
>>>>>>>>>>>> -        break;
>>>>>>>>>>>> -    }
>>>>>>>>>>>> -
>>>>>>>>>>>> -    r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
>>>>>>>>>>>> -               num_hw_submission, amdgpu_job_hang_limit,
>>>>>>>>>>>> -               timeout, NULL, sched_score, ring->name);
>>>>>>>>>>>> -    if (r) {
>>>>>>>>>>>> -        DRM_ERROR("Failed to create scheduler on ring %s.\n",
>>>>>>>>>>>> -              ring->name);
>>>>>>>>>>>> -        return r;
>>>>>>>>>>>> -    }
>>>>>>>>>>>> +    if (!ring->fence_drv.fences)
>>>>>>>>>>>> +        return -ENOMEM;
>>>>>>>>>>>>             return 0;
>>>>>>>>>>>>       }
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>>>>>> index fae7d185ad0d..7f20ce73a243 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>>>>>> @@ -251,6 +251,8 @@ struct amdgpu_ring {
>>>>>>>>>>>>           bool has_compute_vm_bug;
>>>>>>>>>>>>           bool            no_scheduler;
>>>>>>>>>>>>           int            hw_prio;
>>>>>>>>>>>> +    unsigned num_hw_submission;
>>>>>>>>>>>> +    atomic_t        *sched_score;
>>>>>>>>>>>>       };
>>>>>>>>>>>>         #define amdgpu_ring_parse_cs(r, p, ib) 
>>>>>>>>>>>> ((r)->funcs->parse_cs((p), (ib)))
