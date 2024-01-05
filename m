Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AADCC3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 20:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8713C10E682;
	Fri,  5 Jan 2024 20:20:44 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0AC310E682
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 20:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYx6vaEjZjvc987svi38Kk60ihEhcnMtmqqEUaUoB49GsSVltFfgEDafcUwd/8HWP0DXBjTWfznWc92LWzXI+Bao3xG+HnLIvhGeCJ28MF71p9bJJeVLTgyhR8hup6qWvFD0W3EqazBLHovXydBIAHIHaLt9nllt+rdMn3ApbtdPy7DILE5/prhCtGt5wRcWupXqxusG/GxzZ4DmOLjF9jm7eFpH5iXcIkKD7NRNqtPYx/5sguztUjBZAN9SA+Fre0taKEUEiByA8LXIlAtzhSDnSnWx7p9arjQ/Lo4XUyuCUfc73lCEe3gXnmm27tUJdlTyR7wG5sHCLZNZhEiWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzDlw+v5rCiM933hDEXZw4PasAQ/7nJfhyWJA2O/rjs=;
 b=IA7DHa1nra2GYmikrALAnk87reEq5YOMntxxkDpsDy2ygZuac/U9vT0k6oAA0lQTxQUsJRt5NzX5Sc/izHGH0XSHDN9wlaydcbRQ395ZoamfP1TIdykakUVfosbckySRhRMbtqGUFsgr5EZMwDr+A52e+MRmtF1LJhHtZGL/ulSyXb8Xaa9V+ONPHbIWNQyr+y10cODNj9LjijA0Vol2JbgC4qt0pbNV3s2DN+Euw+6/n7gRfPgkw3srzlgrTStFbzER1z9ccd77uZIi4JswnCcDgh7r8WqA7KCSUQFJfs5aAtr+LexSideZx1IfYTYKlV+LHnW6ZQhQzhs316MaOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzDlw+v5rCiM933hDEXZw4PasAQ/7nJfhyWJA2O/rjs=;
 b=RwC77I6UUiDcqtcbTMPrkDVQy5TWgYSwFhrwX1su8FeWHXYV9hqiMn3PHtUQWh4YhTeUteH+NuDhYYomJTwCux5IaBlnEttm3rMOxGiRRcBboGlkd4BQ4Qv9Bl03KeljW7Su19lXL5EUbJ0LbM1xOod+LY54rfj3Gqu9Biz4PyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Fri, 5 Jan
 2024 20:20:36 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 20:20:36 +0000
Message-ID: <285317c2-4236-4a22-a6ba-26e2100dde54@amd.com>
Date: Fri, 5 Jan 2024 15:20:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdkfd: Relocate TBA/TMA to opposite side of
 VM hole"
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Jay Cornwall <jay.cornwall@amd.com>
References: <20240103043000.23971-1-ent3rm4n@gmail.com>
 <CADnq5_NexkgrEKbM39QVGo+hOmd2G0Yc0sui3jWuJsKAyb3ONg@mail.gmail.com>
 <10b32f43-7b0c-1232-1070-cf51731c5d5f@amd.com>
 <0416969a-ddf5-4c6b-9017-6a6a4384b163@amd.com>
 <2e8cd9ed-bdea-eb54-99f1-a7b854594b69@amd.com>
 <CAAxE2A6YdbbC0EKWTdAMLQK9tKmO3v17+yPvhqfby2P_bfH1pw@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CAAxE2A6YdbbC0EKWTdAMLQK9tKmO3v17+yPvhqfby2P_bfH1pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0324.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: aa81bfbe-abfa-4a94-fea8-08dc0e2bc716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xjpVdTfxhfvFwdc7K7EX1Fzu/a95772ZtTXxy7m/tVivr21u6v3iTshWjchP4ekCF5+6YUGk9NNiAS3pekastaqu80xfm00yyFCToR2/OYQGjV7cBD5BMiwjEvavHFLyZmVjNsx1U3MBuce0LqUDdj6qU1VwxP+jzQQ11VEWNZGObfnVR/czYEUNvTN7n65yvy5x0niIPaAxFAb9Jaz6uWr4U8q9KrAe5mH5v4GT1xL2iLl1yMvoNlT0MOiATqDqV/o9Lc3Xxxbqyx9w6NkLkn6chT6TRxNR7xQg8f8mUEiH3gdplCoDkF75HzIrnVhaePvUXsdZwW1RMHjRp937fHgcrDznJYXINKQxFZdCbDY5h44IezurBHKxueFIpCwaA6uf7KKamFoJBm71/5qICJ4cXLH6TlnoH7W3CDEtZucfP4hDcbugS+G6wuLikyDw7zo4uLVjCIyD/WnMj9/bzkDVIvJJGiqmGC1BwCZ9QviUD4q71B9uYd5E/IO3ftRU2+RqVyWmWTyYtvfujVzaik+EgRr2Ini6OC+6JDzc+QBqrbF5eC+Z7HgHInGuwg1K8sDxSFiwIZnOWiqueHWZUOGOBQulcohatQTgiVanycd80J5DYQwacQfoc3nYwoi3K+1L579iXId0Dlp+FE/Alw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(36756003)(31686004)(83380400001)(41300700001)(38100700002)(66476007)(8676002)(54906003)(5660300002)(6486002)(44832011)(8936002)(316002)(6636002)(2616005)(66556008)(4326008)(53546011)(66574015)(478600001)(86362001)(31696002)(2906002)(66946007)(110136005)(36916002)(6512007)(26005)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0pScVVIV1NvS1ppQWN3SXl6b0Y3bnc4eVZWWkhBTFFMdjR5RU8rVDg0UFZu?=
 =?utf-8?B?V1A1cTQySWphbDZZUDQvR2ZEWllRemk0RUVZUHFzNW40b2JSZ0tTajcwdEFn?=
 =?utf-8?B?VGxZZDB6WCt4dlRXWjBoMmRwVEhyVHU0MzN2QlpmL2ExV2l2Ukx5Z2QyaUxa?=
 =?utf-8?B?akNOZVF2blpici9SL3BsejJxcVRkTW42WURVcDFNWFFrTjg2cDRGSEU0M2xw?=
 =?utf-8?B?K00rVnVDUmg3eGttY1V3amxtaW1XaGw1dStBdWdrNG9qcnBKdW8wRjJNc25L?=
 =?utf-8?B?N2NsSm9uUXc5NHJ6Z01TM0xmVldhbWVqdi9tRnNMOHlocldqR3dxZDYxTW41?=
 =?utf-8?B?aVQ0UkRjM1IrUy9ocHh4NGZNeTBKbzZkSEtJeVhKY0NYbkRta3QwaU5vaWNJ?=
 =?utf-8?B?bWt1U281blpvZE9jR3RrUFBmNzE0Um1zcWZtMGtnNkJqQzYwMmdsUHhjekhX?=
 =?utf-8?B?R3ZYUkFTUXZIanRXK0dGYXZJM3FzNHhHRDlVcjFFbi94aWxUUHlBWC9lN0hx?=
 =?utf-8?B?dDNZOS9EblZhV2lXNGZBSlRITjJlQ0kzR0lVWDNLYzFMdHVvWktsMGdtanpI?=
 =?utf-8?B?aSsvSzJPZ01NcEI1MEhpU0JicGlqY3c5bEtNZnhZcEJJUGFzVTRJK2trZno1?=
 =?utf-8?B?K0pRRURuV01tazByQU00a3IvWVJLRnNvTkNrVkpLVUxrTnJHeXhpUE8waTB5?=
 =?utf-8?B?cHZBS3htU0RpVFVRTGpHcythUVhlYlhPUzZlMWR1eE1Sd1pqa0dlRFlscGZj?=
 =?utf-8?B?aHMwL1VLVHpNcFVOb1VraWE4aVFGRkppd0RvbFR5QXlHbFd3TlFvbTVNZnRx?=
 =?utf-8?B?U3JZY1diLzcrbGw4Z1VOZk11UUhZaCtNMlozbmQwUTNucG5NTGM2ZXFWa0ZN?=
 =?utf-8?B?WnF1R2I0cXZTUVRaWWh2ZURNeko2eCtZVmpONnhmZ0F0NnpWNGI2SS9BUEhw?=
 =?utf-8?B?NEdaNUJTTmNhN0xUWm1teEZIckEyR2hwUmtxZWxGc0RtOWd0a0JEZ1EvUEtH?=
 =?utf-8?B?ZjFYZVBQNHBDSVYrcGNibE0xR1oyaW5RTjU0dFMyREJZdm80S1RnNERaZVBm?=
 =?utf-8?B?Vm03MlJMWjVtS2w1RGhXSjI1K01iYUZpakJKQ2IvTXVqL2ZaZ0Q4K2hWUzh0?=
 =?utf-8?B?RGR3WG04YktFWll2MGE0ZTVRRUxUa0pVRzk4YU51VGNiOWh5cnZXU3BYQ3JW?=
 =?utf-8?B?SXk3U0ZhMXFwdEkwTC9CQlZmbU1WdGRrL09hc2IwNXhUNVJ3aUp1bWI4MXgw?=
 =?utf-8?B?MXdzaUtLaEE1SXdWWDhsZmtlSTZQL0s5MGRqdEY1R0s3SU9iVjVNbkFnMUIx?=
 =?utf-8?B?bEZteTJqb3pnRHE5eGVBWmNpOHczd29hL0F2cHZFdU13N1lyb2dyOHY3ZE5Z?=
 =?utf-8?B?NlhFUXBsNjJkVXFSOFFNZHNhNTRGSGtUekhDaDV3V1BjTWdhTzdiUGJEaUxN?=
 =?utf-8?B?NG1mSHRGUlRhM3BwS2xIblR1MUlKamxIKytwV3gwbkdIRElNYW80WStvcU5j?=
 =?utf-8?B?c1NyRnlnMmJycEE2RE1SN01vQ1ROUDhZUDQ3bFpXakhrZGxvMTRaL0h6Zmhj?=
 =?utf-8?B?Z2dUU3pOK3dHbkZldFlPNjlvWFBWWi8velFsV3FsVjBzVVVQaDVDMWtnL3Zs?=
 =?utf-8?B?SDBOTG1VYVI0dWRPajBzZy84RFVZSERMWlNnN3hiNTNaeVIzSFU2alNDYjlW?=
 =?utf-8?B?bDRlcUZOQmFsUjZpWUh1R3NRYkNrbHBCS3VsUGJuSzBhOGZQTFBWVWs1d2JV?=
 =?utf-8?B?VHZjN3VneFB5Wk9RU2diNGwvRGRKRWtUYzk2azg5YVAxMXRidmVWSWQyWXhP?=
 =?utf-8?B?dUlRRW4yWU5KZFR5d2hQSmU1U0RzcUN4YkRFNjBvWEN5STRNcHhuem8yci9a?=
 =?utf-8?B?bEtjRi9nK21PSzdONm5ZMVI3eENUblh2cmFOU01YdFFYV0wxQ0I1NFFIQU5C?=
 =?utf-8?B?UWFMVmdNVlQ3blRXbU9nL1A1ekxlOVNHemtqR2tVTjVydElNQ1VBYml1RGZy?=
 =?utf-8?B?aWZXODJFMGpMcC9xTElnZnJIQzBKMG1qY3Y5MTFPTmx4R1lnTXRncXVYN1ov?=
 =?utf-8?B?MlVKZHVNTVhaeWNjbkVIYkVPSHlieEtyb3ZNaHRLRm1uZUhKN2tIMEgxTWpK?=
 =?utf-8?Q?wNjlxo+whdtsaG3SIu9bXelMb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa81bfbe-abfa-4a94-fea8-08dc0e2bc716
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 20:20:36.8103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftgrGPdvl+vk70uL0shFKEut4fJsMur4FEBN9VY6+fEw9T+axFOBAsWSRICiQHp3IyELGn0PDX7zOai/xXkyLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8773
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
Cc: Alex Deucher <alexdeucher@gmail.com>, Kaibo Ma <ent3rm4n@gmail.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TBA/TMA were relocated to the upper half of the canonical address space. 
I don't think that qualifies as 32-bit by definition. But maybe you're 
using a different definition.

That said, if Mesa manages its own virtual address space in user mode, 
and KFD maps the TMA/TBA at an address that Mesa believes to be free, I 
can see how that would lead to problems.

That said, the fence refcount bug is another problem that may have been 
exposed by the way that a crashing Mesa application shuts down. 
Reverting Jay's patch certainly didn't fix that, but only hides the problem.

Regards,
   Felix


On 2024-01-04 13:29, Marek Olšák wrote:
> Hi,
>
> I have received information that the original commit makes all 32-bit
> userspace VA allocations fail, so UMDs like Mesa can't even initialize
> and they either crash or fail to load. If TBA/TMA was relocated to the
> 32-bit address range, it would explain why UMDs can't allocate
> anything in that range.
>
> Marek
>
> On Wed, Jan 3, 2024 at 2:50 PM Jay Cornwall <jay.cornwall@amd.com> wrote:
>> On 1/3/2024 12:58, Felix Kuehling wrote:
>>
>>> A segfault in Mesa seems to be a different issue from what's mentioned
>>> in the commit message. I'd let Christian or Marek comment on
>>> compatibility with graphics UMDs. I'm not sure why this patch would
>>> affect them at all.
>> I was referencing this issue in OpenCL/OpenGL interop, which certainly looked related:
>>
>> [   91.769002] amdgpu 0000:0a:00.0: amdgpu: bo 000000009bba4692 va 0x0800000000-0x08000001ff conflict with 0x0800000000-0x0800000002
>> [   91.769141] ocltst[2781]: segfault at b2 ip 00007f3fb90a7c39 sp 00007ffd3c011ba0 error 4 in radeonsi_dri.so[7f3fb888e000+1196000] likely on CPU 15 (core 7, socket 0)
>>
>>> Looking at the logs in the tickets, it looks like a fence reference
>>> counting error. I don't see how Jay's patch could have caused that. I
>>> made another change in that code recently that could make a difference
>>> for this issue:
>>>
>>>      commit 8f08c5b24ced1be7eb49692e4816c1916233c79b
>>>      Author: Felix Kuehling <Felix.Kuehling@amd.com>
>>>      Date:   Fri Oct 27 18:21:55 2023 -0400
>>>
>>>           drm/amdkfd: Run restore_workers on freezable WQs
>>>
>>>           Make restore workers freezable so we don't have to explicitly
>>>      flush them
>>>           in suspend and GPU reset code paths, and we don't accidentally
>>>      try to
>>>           restore BOs while the GPU is suspended. Not having to flush
>>>      restore_work
>>>           also helps avoid lock/fence dependencies in the GPU reset case
>>>      where we're
>>>           not allowed to wait for fences.
>>>
>>>           A side effect of this is, that we can now have multiple
>>>      concurrent threads
>>>           trying to signal the same eviction fence. Rework eviction fence
>>>      signaling
>>>           and replacement to account for that.
>>>
>>>           The GPU reset path can no longer rely on restore_process_worker
>>>      to resume
>>>           queues because evict/restore workers can run independently of
>>>      it. Instead
>>>           call a new restore_process_helper directly.
>>>
>>>           This is an RFC and request for testing.
>>>
>>>           v2:
>>>           - Reworked eviction fence signaling
>>>           - Introduced restore_process_helper
>>>
>>>           v3:
>>>           - Handle unsignaled eviction fences in restore_process_bos
>>>
>>>           Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>           Acked-by: Christian König <christian.koenig@amd.com>
>>>           Tested-by: Emily Deng <Emily.Deng@amd.com>
>>>           Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>
>>>
>>> FWIW, I built a plain 6.6 kernel, and was not able to reproduce the
>>> crash with some simple tests.
>>>
>>> Regards,
>>>     Felix
>>>
>>>
>>>> So I agree, let's revert it.
>>>>
>>>> Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
