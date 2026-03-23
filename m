Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6165BF4610D
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 13:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03CF810E0AD;
	Mon, 23 Mar 2026 13:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TCGx0rMQ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6755910E0AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 13:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEWLHRCtotDYXqP7js0E2ZroA+hh9SoiBAgna6IRcdY7pnvgD0xWQkIKOMt4O+LwXhmv1hykWrbdzhW/yHUD8w3YtwkcuCAQG1FcFDEN1alZl8d6n58jVRiN48SxErN9v3Y4bjmRfbLss6ZMs9vxIDKYgcHvKF4+RsQu2hwnPln0cDKplE8OwzMfQxk5oWkbyCsyYagQCVQ+nm1JVVHiM3liiBXK5wxFllv6TqMZEsijxXr5bGGTAKvNJRWnQK8KZ4ZilF6KoaSQ/bGwwuBuyHWkhP7b/Mf2L128N1HxDRULE1pgwZcDmNxiP+uPSxvH1Xe/qfaaNyBCjgoJtoDAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlI55xJyrUy5Nb9ZA95IgM89+u6sYGOoKhJuQFzLUPY=;
 b=xcFII99jpcAcpJ8aO7+l8hsHD3wDiyzwWFhPKhCpPCAKT5tc5jw4QmnlSBHq9DfP6gAaRCZW1IlJnYbs/vKCnkJ7z37fw6xObhrUIUV43k8WSbNcNQ1NorVdedMDSHWW9AbviYz1xJCi8MzD5AwVD2mYURxcaQwRk+QXd/XAwPRvexAzhLCqY5u8rVsuFxRGzH+OCMXVF+/7w5Ji0nUJLOBs7cN5rp/t4nVR4chXo0tsziafK6pUUeXyWk+isXXfGslmCISitja2nmdEsexhUrUd0XSNw15kvPRc9LwamywRYVT88OTXBdgJhMPwJedbpAgmfFniBHWB6ve3Taz3tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlI55xJyrUy5Nb9ZA95IgM89+u6sYGOoKhJuQFzLUPY=;
 b=TCGx0rMQvb0r7fsJDXXTWpkjFaPuZ8pjson8jwlk1a9j4kn1wHmCAu6uzkHqOgohxWDl7rqQb90aB/YhSLMTrXimAHvKhia8b4hZSBEHTzk2/JJnb7TVG5dftOFDJdiz3DGkLNQ6AM2XhRpm73fQ88Nkyqf0GtkH0h81rehKjQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.19; Mon, 23 Mar
 2026 13:49:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 13:49:07 +0000
Message-ID: <76890001-297a-4503-b64e-7328b479b676@amd.com>
Date: Mon, 23 Mar 2026 14:49:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: check system memory when set apu_prefer_gtt
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Yuan, Perry" <Perry.Yuan@amd.com>, "Lin, Leo" <Leo.Lin@amd.com>,
 "Perry, David" <David.Perry@amd.com>
References: <20260319073250.147808-1-yifan1.zhang@amd.com>
 <80732b5f-27a9-4969-8afe-98f3156c725e@amd.com>
 <CY5PR12MB63693D88EBEAEE20CC4B6870C14CA@CY5PR12MB6369.namprd12.prod.outlook.com>
 <f388c29e-4d1c-4d04-9eca-ce3b74f00931@amd.com>
 <65c61436-f076-4308-b89f-d2bdb214e481@amd.com>
 <35726709-03f5-4e5f-8425-7a84ea406464@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <35726709-03f5-4e5f-8425-7a84ea406464@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB9501:EE_
X-MS-Office365-Filtering-Correlation-Id: 580461e0-75f9-48c8-c56b-08de88e2f420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: CZ1OzQFsAk3geQZfyOnY8OAn7E4wmro7KIGWlTm5cvNBj/duy2hnk//LdC939Sds+r+zK+D8rjjmR1Lu8FmPe5b4FQVPyj0/zL1ziQxK1FoGAGB5zY38PpNV5VJj5PTiNX9NQvwNR0Z5v6c8aBJCLzanfodm+vwG6VlXcJcvUC75pwHtVSOUh/8mp7Wjmgq8bdJYhu19R6jkpF6Rw9I/HsPk0j7PlwC6ZGYAMa78j7d7Qt02EAl6oT0YrqEwTet5ZRX76zLE9U9YwD3V8oaaVWdn5kSc3p0mkNNhwZ0zjQk1CY/wsVMZJySiesI2HCmUpvKOEwMQFHly0rerVMIBGBeXC0PsLcMmY0E/CEU3Apj35l5hoXJnCMqc2moJS3Ure9AbSaMRIyTMw11tILPHtyL/p2cb1FPGyM+fWXIgE3yIKcfwReQ65lNq/n5U9gzQgn0KGwE8d0fnBLZQbhypUjVFXWX/+NG9YgnhjjLzUOPldjBXn55Kjv9OMulguX5sABnhGUSq3V3Y7DO0ZLEOcblZrz+yJX8N8BQD/GVTiR296S3jPhMAFiSB5FalCzeEM/jCuU2u93nzxlJa4jR2DdV7wdrefQVhZGucbWL9tJFcTlo9TrPX411U7Cl1m5WsXB2EmYnlr0EOaKE7j5Le4+ZJe4KjFhRINFBPBLitnf0xGQzbCv6b5PEiGuWQwK3TTutxWMZX9gMJF/WPlrF9mFMKMSmDG8ZITpsBjGnvAKDaBYPKzZ1dWtpxEt0tHwhq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnovUmZUMFFjNGVjSHlQMSt4TDRNQm8rK0xWakV3Q2pRZkRENFFPVCt1SlZa?=
 =?utf-8?B?MC9ocHphVjBlWjNaNkE5T0JQcVA1VTFER0VaWXJhYUFlTHJ5VEt3Vm14SnZz?=
 =?utf-8?B?R2s1NjRmNm9WclZod2hDOWF5dzJiU3VUeHhpakJVemNCeWlxU1RDZHhLajNG?=
 =?utf-8?B?MXpnaE92Zi94M3dYakNmazRDQ3RPY2Zodk41V2d6Q3VRamhMMjRpcnZyM09O?=
 =?utf-8?B?R21CR3F3SlFhT2xmc0ZKZm9QblcwL254ZThLS3FTUm5GdUtJY2ZjK3k4NVhL?=
 =?utf-8?B?OUFmVXJ3ZDdaTVR4TXk3M3EvU1ZacmZYSWczUTA2VlJVcHlWS2FqdGhkOFBy?=
 =?utf-8?B?VnVpZmtyUGxqZk5IQ1VRWTFJSy80VkcvcXc1eDBTN2hNMml0dDEzUUQveUhr?=
 =?utf-8?B?cEpiN1hwQk5tbmZHK3NJRXdBd3UvY2FYRDJDZXBhL0xDTXRCVHlKQm1Vd3FV?=
 =?utf-8?B?ZUJIZk9JL1JwS3lJaDVNQUhha09Nd2Q5YUtsaGpmTzRqTFdKZWNlTWd3VEFX?=
 =?utf-8?B?cjRRZDFESmNyMTh5SWRQdWpLK0ROQWQ4L1daeVcvclpmYmlZTXZpUDFzL2V2?=
 =?utf-8?B?RDVBbWV1K0xmRVkvZWJQUlVsMFVSdmlRTG80Smc3OWtXck96OGNndElicWZX?=
 =?utf-8?B?T1F3WHRCSWJLTVJzd1VtRmI0RnR1V2toeHliZEQ3M3lRbVBSZEtIcmd5anVr?=
 =?utf-8?B?cmtCTGZoNHdnT3VRVFZtSFNOMU1FYUdISUMvbXNNd3E1aFBQcjliSXdQTDVt?=
 =?utf-8?B?VGM3ZjJqNnUrMnhPdWJvU3JxUm95eVlyVlRqWGpBZkhLdElrQ0labmFzUExi?=
 =?utf-8?B?ODJ4TlFLUDZ1UzNxRXducDRCUlRZcVptcG4rcGhlU05acW8xcE1Eblp1Tldk?=
 =?utf-8?B?YTRRL0Nzajd2NllSS2s0YnJ5NUg3dmI0N0lXUzV1ejVXeWpPaFp0KzFUVGdC?=
 =?utf-8?B?ZG93Y0lTcnBiWndCb0hESGtyT1g1S3hCSzFIaTZXcnhqT2I5S0p6cWFNUnp5?=
 =?utf-8?B?OUdQR1JJczlDbGxsODRYT0xTZWt2MGZtMFY4WWZuQXF0Nmd2T0t6bG1KNllY?=
 =?utf-8?B?WjQvckU4RHJVUk1vSG9IZ0RKb3dLdmhCaHAyeTgvVXY3bVRoUGVNMlJRN3Jz?=
 =?utf-8?B?R0VQNWdqbCt0WVMvL01WTXpwZlM1bklVQmgxWVJXZVFCWEZjbktpZFdHZ3Jz?=
 =?utf-8?B?UFFDZXlLYUhUbW95d1E4VVl0RitWemdPMjB1blV5d2lnbjNLMDNDNXVhVWwx?=
 =?utf-8?B?RXBYZ2lsMGp4VzdIZStwWnhFTUN6SGZVSW5sTXdxQjN3OTlvTXRQS0VsUllj?=
 =?utf-8?B?aU1IMUVkUlhnRlpWY3pzQlVjYVZkZHpHdnY3MklDRS9JK2RKbC9jc3ZXeDAw?=
 =?utf-8?B?eUhLd0VESEZEVENNWk1pNkgxUnNaVmI4WGZvSzc3cGE5azBmNHVBVkROdU5V?=
 =?utf-8?B?ODNyN1pxN05uTzZCNXBmUU5PVlBlNjdXWEh3ditqQkJYNG1sU3U4eDFrd0RV?=
 =?utf-8?B?RE1MLzdMbmRRM3lpM0MydHNZeVNvMTU5NTRlazZQZitrZEZLbGRYdmd0WTht?=
 =?utf-8?B?eThxSkoycnZhWkIzZmVwOURmZTJUejRGNU15dGExa0FFcWhiajNyVGdhaHZx?=
 =?utf-8?B?VnMzY3dFQ3ZNd1FzbnpmMXNsS01UazJVeVZGTkwyVjAzMCszTjdqdHJUeStr?=
 =?utf-8?B?WkdpVW1nb2haTW42T3dUYjJoNjA4TWoxRkRmMmxVVHU0MkF1TmtYc1M4TEd4?=
 =?utf-8?B?emttcStuNTZIemhCSUpmQ3JuVDhwaEU5WmU1WDQvL0haSXdVWURUVGxLSkRB?=
 =?utf-8?B?N0N5ZTRKL0c2Skc2czIyK0ttQ21iSzk4Nnc2bnVaU3Z2bFE4TURrVStQaG8z?=
 =?utf-8?B?M3ZKSVdOOTdFL0NvTHVNUk53Um03VExGQzdlSXlydGpydXBNb2RYbndNS1cy?=
 =?utf-8?B?WlQ0RFpENUlyL21FbktZeXphYzdQcXIzSlVyVlRMQXRKREc4L0RCUFoxV2gx?=
 =?utf-8?B?T0FwYmgvYmFOV1ZDZTBpR1dxK3Bqb1ZEY05CL0JXR241MUpGcmR5UHpvQzRO?=
 =?utf-8?B?b0RSVXMwcnZITnBRTnVyYldrOUJTWWFBdXNHMkVETlZnbk9IZXg4S2xGQnZC?=
 =?utf-8?B?dnczcDVCT1NaOFM2NVFkemtybVQ3VEVHeDdRRnpFWjlDR2ZwOWZDMUJaU0w5?=
 =?utf-8?B?SnQwL1dPNnQreHRaVGREWXF4RHhjR0dDTVJBSjhGTDZrdzBwQlBlNkc2Vm13?=
 =?utf-8?B?WXZ5ZWNFNFFFekJVeDh6dlBiaDVuaGxHOXdleG9QZ3k3ckw4WjBCM2k4MlEr?=
 =?utf-8?Q?/dF5iGC4qH88Xizpa+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580461e0-75f9-48c8-c56b-08de88e2f420
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:49:07.5051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J78nFWIi7NAfkQydao31FzDy3wPFdyPdRSSdKSLg5JGDYOQtq51Uw7vyxAWO4mwY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9501
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

Hi Mario,

On 3/23/26 13:56, Mario Limonciello wrote:
> 
> 
> On 3/23/2026 4:13 AM, Christian König wrote:
>> Hi Mario,
>>
>> first of all please loop me in on TTM changes as maintainer explicitely. I don't see everything which flys by on dri-devel.
> 
> Sure.  I was initially just looking for anyone comments on it, didn't think it was worth bubbling to top of your mailbox for an RFC.

I usually completely miss such stuff otherwise. I'm not very proud of it, but I have a backlog of multiple thousands of mailing list mails I couldn't look into.

>>
>> Then changing the 50% limit is an absolutely NO-GO. It's completely irrelevant that AI wants to use more, HPC use cases complained about that for decades, but we simply can't do that reliable.
> 
> What does HPC do now when they need more?  Tell people to put page limit on the kernel command line?

Yes, either that or other similar workarounds.

>  This shouldn't be any different than status quo before - except that user intent can persist.

The key point is the system starts to become unstable when you go over 50%. We have tons of complains about that as well from HPC customers.

The problem is that TTMs eviction code needs memory to swap GPU buffers out to disk, that's why we use the 50% limit here.

Intel has been working on and provides an alternative shrinker callback (see drivers/gpu/drm/xe/xe_shrinker.c) to work around that and so lift the 50% limit. But so far that is only implemented for XE.

If you want to fix this for amdgpu just take the xe_shrinker as an example and implement that same stuff for us as well.

Regards,
Christian.

> 
>>
>> Regards,
>> Christian.
>>
>> On 3/20/26 15:34, Mario Limonciello wrote:
>>> I think there is actually a very easy way to trigger it and it's not obvious that a user messed it up.
>>>
>>> Assume you're on a 128GB system with VRAM set to 512MB.
>>> 1) Set TTM page limit corresponding to 96GB
>>> 2) Use uma_carveout sysfs or BIOS to set VRAM to 96GB
>>> 3) Reboot system
>>> 4) Now VRAM is 96GB, but the page limit was a module parameter and will be wrong.
>>>
>>> I actually /think/ that the RFC [1] I proposed a few weeks ago could be a good way to prevent this.  By using EFI variable instead, TTM could sanity check anything it reads at startup and save sane values to EFI for the next reboot (if they're insane).
>>>
>>> https://lore.kernel.org/dri-devel/20260306055439.1822879-1-mario.limonciello@amd.com/ [1]
>>>
>>> On 3/20/2026 9:28 AM, Zhang, Yifan wrote:
>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>
>>>> Yes, I agree. I’ve just been notified that this memory configuration is a mistake rather than a valid user case. So the fix is low priority for now.
>>>>
>>>> -----Original Message-----
>>>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>>>> Sent: Friday, March 20, 2026 11:14 AM
>>>> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
>>>> Subject: Re: [PATCH v2] drm/amdkfd: check system memory when set apu_prefer_gtt
>>>>
>>>>
>>>>
>>>> On 3/19/2026 2:32 AM, Yifan Zhang wrote:
>>>>> Current apu_prefer_gtt setting only check gtt_size, which could be set
>>>>> by user to a larger than system memory value (via ttm modules
>>>>> parameter pages_limit). E.g. carveout vram 32GB, gtt_size 50GB (via
>>>>> ttm modules parameter pages_limit), system memory 31GB. In that case,
>>>>> apu_prefer_gtt will be set incorrectly. Take system memory into
>>>>> account when set apu_prefer_gtt.
>>>>>
>>>>
>>>> Wouldn't it be cleaner to do this in TTM?  IE test that a bad option was set by user pages_limit value and then show something like:
>>>>
>>>> if (user > possible) {
>>>>        pr_warn("Requested invalid %d pages, limiting to %d pages", user, possible);
>>>>        user = possible;
>>>> }
>>>>
>>>> Then we can always trust what we get from TTM.
>>>>
>>>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       | 2 --
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 4 ++--
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++--
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          | 7 ++++++-
>>>>>     4 files changed, 12 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>> index 3bfd79c89df3..a6ee9d9bfafb 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>> @@ -170,8 +170,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>>>>>         int i;
>>>>>         int last_valid_bit;
>>>>>
>>>>> -     amdgpu_amdkfd_gpuvm_init_mem_limits();
>>>>> -
>>>>>         if (adev->kfd.dev) {
>>>>>                 struct kgd2kfd_shared_resources gpu_resources = {
>>>>>                         .compute_vmid_bitmap =
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> index cdbab7f8cee8..13cada7da4a9 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> @@ -369,7 +369,7 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct
>>>>> amdgpu_device *adev, int xcp_id);
>>>>>
>>>>>
>>>>>     #if IS_ENABLED(CONFIG_HSA_AMD)
>>>>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>>>>> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>>>>>     void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>>>>>                                 struct amdgpu_vm *vm);
>>>>>
>>>>> @@ -382,7 +382,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
>>>>>     void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
>>>>>     #else
>>>>>     static inline
>>>>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>>> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>>>     {
>>>>>     }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> index 8a869fe41acd..4fba7d2f34a9 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> @@ -109,13 +109,13 @@ static bool reuse_dmamap(struct amdgpu_device *adev, struct amdgpu_device *bo_ad
>>>>>      *  System (TTM + userptr) memory - 15/16th System RAM
>>>>>      *  TTM memory - 3/8th System RAM
>>>>>      */
>>>>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>>> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>>>     {
>>>>>         struct sysinfo si;
>>>>>         uint64_t mem;
>>>>>
>>>>>         if (kfd_mem_limit.max_system_mem_limit)
>>>>> -             return;
>>>>> +             return kfd_mem_limit.max_system_mem_limit;
>>>>>
>>>>>         si_meminfo(&si);
>>>>>         mem = si.totalram - si.totalhigh;
>>>>> @@ -132,6 +132,8 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>>>         pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
>>>>>                 (kfd_mem_limit.max_system_mem_limit >> 20),
>>>>>                 (kfd_mem_limit.max_ttm_mem_limit >> 20));
>>>>> +
>>>>> +     return kfd_mem_limit.max_system_mem_limit;
>>>>>     }
>>>>>
>>>>>     void amdgpu_amdkfd_reserve_system_mem(uint64_t size) diff --git
>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> index 714fd8d12ca5..df98ece071e1 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> @@ -2071,6 +2071,7 @@ static void amdgpu_ttm_buffer_entity_fini(struct amdgpu_gtt_mgr *mgr,
>>>>>     int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>>>     {
>>>>>         uint64_t gtt_size;
>>>>> +     uint64_t max_system_mem_limit;
>>>>>         int r;
>>>>>
>>>>>         dma_set_max_seg_size(adev->dev, UINT_MAX); @@ -2210,8 +2211,12 @@
>>>>> int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>>>         dev_info(adev->dev, " %uM of GTT memory ready.\n",
>>>>>                  (unsigned int)(gtt_size / (1024 * 1024)));
>>>>>
>>>>> +
>>>>> +     max_system_mem_limit = amdgpu_amdkfd_gpuvm_init_mem_limits();
>>>>> +
>>>>>         if (adev->flags & AMD_IS_APU) {
>>>>> -             if (adev->gmc.real_vram_size < gtt_size)
>>>>> +             if (adev->gmc.real_vram_size < gtt_size &&
>>>>> +                     adev->gmc.real_vram_size < max_system_mem_limit)
>>>>>                         adev->apu_prefer_gtt = true;
>>>>>         }
>>>>>
>>>>
>>>
>>
> 

