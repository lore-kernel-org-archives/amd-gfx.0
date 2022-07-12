Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A245C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 17:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D0AA9594E;
	Tue, 12 Jul 2022 17:42:14 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F43A9594D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 17:42:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UK/HEfmj0k8zek9qtSvQDM+mcf+iofOGNCp2rJPDtbrmLrF5BcHtZXH8FF3i4AeWWNmrNdTRZlo78KamJZOMQjr1qRFUpiZVSExhwVYjDckW89H3Yykd+Ddv5Cm2R+LdlbkNFjbVnWduYW93LXktkaaGQ0LXQX59mWmWICRv745PVYGfASZVtKZOoNv09R2+fR9dOR7Uf+15TO9E7sXhmc2EoFkpufjjKI8eY1gQEJ9CKvLO/j3e4PC/nY/SUD3kT6ogiiImLucQMPkGFKxzQyGnD+3ePRSTQ2BR6i4d4WmfZR8wqD5yr3aCpslVYiSTum56QCz9B8/E6aRMrem9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNx4O0DDqUCu2AnyHQ3JqMRNL3Y20LA4ZaC7LNIOKPk=;
 b=Iy/QjAkGBk1GDz2XGdJdk6eP9+3rVT8LfuXNyNIPlPV1o9liIRqOmZsOv4bTkCsztqNrwtpGH96/d/llwyfQBbuNn/MhI0BGIYpZDXp31mIMjspf+5zv8PP4cxvcMYDCLLQXTJpe7VZQ55Bn9NlN17xVyOQ7Pk4jsTDjVs9KYUT8yIAYUXrlJg8y0DeJza6SdAEUN5jfEZrZ2sTtrduvM4hvHZ5GZw7Drt1Oa4YgnNmCQpVBCCrU0coaqfKjZxZBhrKYZZ9+ipSd4JIp1w+OYfu5ZJFossvRy/02k60fEckaIOSYhZP7In181GZ46P/yghMFlkMrD2CZupq6vapHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNx4O0DDqUCu2AnyHQ3JqMRNL3Y20LA4ZaC7LNIOKPk=;
 b=BK0zW3Ai/FmtjK9QUIBhkQlLK8+XpmeoVhgOwa8h2chB5TF/GZrSTNP1ZV+fxAsuClwSHnq5pp3JaOGzi9dcqYjsh9O67TzccQ8V0A7KPRLcI3RH/133w5zzj6Yi+jNR3QEwwKeia/r1HF8I5+Y2PKPpJ7pY+ueJPYrlbxdKRCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 SA1PR12MB5660.namprd12.prod.outlook.com (2603:10b6:806:238::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 17:42:11 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::b54e:e6f9:e716:5f38]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::b54e:e6f9:e716:5f38%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 17:42:11 +0000
Message-ID: <c61fa0f9-6d5c-61b3-1a4f-a382ba6af762@amd.com>
Date: Tue, 12 Jul 2022 13:44:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Check BO's requested pinning domains
 against its preferred_domains
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220711224443.1157747-1-sunpeng.li@amd.com>
 <20220712163029.43581-1-sunpeng.li@amd.com>
 <CADnq5_OAiWeb1H1Jc=ZM=y39UVgER0d5ZoHrw=cM2JzHis-qJw@mail.gmail.com>
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <CADnq5_OAiWeb1H1Jc=ZM=y39UVgER0d5ZoHrw=cM2JzHis-qJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0005.namprd14.prod.outlook.com
 (2603:10b6:610:60::15) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2968e6ca-ec4c-4b26-19e3-08da642dd970
X-MS-TrafficTypeDiagnostic: SA1PR12MB5660:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2lFHAVeTuBpWwnDw3Zq4r0r0+wD33dkTh0wafpsdyqgt9CB1Al3/j/PzPlDc0QmMdj9g0g9nf6LEeZe1M3N/EWMRQg60FoH2IECK7yQpDDwkfDGOgFBTmrHgqW8Ko/wcI/34vT1RG/A3LhlFobsJM1Vc1S4IjA66fZ3d+RaDogRAa743PJwJ4bpC4vZiPLdXZYejSXB9nfNlOiR/af/OadbpIZ/6fuhLu7+o5yPR6vaxKmESG1IkJYgxfEZtnrnLefsNDe+apIW2iWpXboofs4ICb5P8Rsi+XU/JgoJWdsyQ3eC3sqOwd6pF29CQoX0+FOsQ7Yz/D+HWqF1wlHkS/dAqwldW6AJ9LWmP4kjCKdGas2Rbh5wz6Lt669WB+zt34RTylphtDVhqffgbpQEc1DjGkc6Oxa47afrPGTF3Xj+iVMrtQdzc0kYgqbLHle7l93Wi3c0jqrxzTK/uzkjxR5NvWfZiQJ9E1M4xPN7V0+J7k+8KxFXylBd4Kk1k3WbdJ+xyFayMoSJm01m3D50nMHbIuhuO3k6gnuD/0te6D4pM/Sz0WzU+WJnqA/eDOhFDgFLGjKHBMAb9aH9ZmsLnX25pSpVXLwCemll0wRnnBoKltU/0DR+eSGyc1/o9gEYkFh5N+XB3EhErxIGLeYpcyRJUAhcTt2EppPrgLKxIkxkE64rkes4GrqF+flWyuzL0bVTj/YeOn0LZ2Wgc2W5leBcuk7QLH9ITnGXTpvCvJVG5f2QS2qGHkOWvDI/m6bFhsjFYTjuTcRYWs6kuTKmAuZpssITHUPBx4NOnddQKnT+u0w8JdSjN/6w/+3HHs8VjZqdDCrUw2dhv0GOd1jP34dHcMMrLDsjG5VohLNdQWm4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(31696002)(86362001)(6666004)(8676002)(31686004)(66946007)(66556008)(66476007)(4326008)(38100700002)(54906003)(6916009)(316002)(8936002)(6512007)(83380400001)(5660300002)(2616005)(2906002)(36756003)(26005)(53546011)(6506007)(6486002)(41300700001)(186003)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V21NMXY2S0FiMU1pUUNQK3FDMnBTeUFNY1drRDFWZlBQR2xOMWR1WHhnQ2hx?=
 =?utf-8?B?ekp1d3dXcDBkYlQ3OFpLb3JhOGozeFZkU2JBK1RhN0tFblQrZ3EwbWZvQmVC?=
 =?utf-8?B?NE5Bb3Z3YnV3d3dkbzZIYnlsQk4ydlNJVTl2a2UyK3hIaURsYUdUTXlqTHZX?=
 =?utf-8?B?Smh0RDg1Vy9sUHdHbmJGbmhzNjFGT0VET09ZYjl6RC80eWJwNk9XQ2tvcjl6?=
 =?utf-8?B?UDZuTTRtTDdLUnhkd0RLSWdBTXppOEk3ZUw1UUs1ZFlQa0UvemRBbU5lSUxi?=
 =?utf-8?B?cHMyNlBjN0c0OWh6N1BDSHk2amtROXovN09YNTBKNFdzek5xZStqaDZrOFlr?=
 =?utf-8?B?RkJCdzVNb1RPalR4TTN5aElmQmg2KzNXL2J5UkQ4RjZhbHdPTXhyL0dmTktV?=
 =?utf-8?B?MTF4OWk4OGoyZVZ5YXFxQnVGc1lzaURqMCt6cERxTkpPY3RNK095Y3JtUmFp?=
 =?utf-8?B?Z0t4NkRyN2J0YjRsbUZNR3FIcUI1dlI0Rmd5cExzK2dRRjkwaFdiYStDdmdC?=
 =?utf-8?B?c2IzOVJwVnZIWFhuZFdTei9Mazd1NGU5aU55VUdXUGJIWFNNQWVoWVB3TzhR?=
 =?utf-8?B?TTBmdHJzVmtYRjM4QitzcnlXN2RQTXdhbFROWnRhaUhZbjR3cE41am54clZQ?=
 =?utf-8?B?R3BIL2s0ZjV6TERJaWw2NUN3SDR0SnJOcm00bDZTTldCZlphVXNPVlhBZkZF?=
 =?utf-8?B?cWdOQzc1TGFXYWxoVjNtUXQxWlk2dXprMVVDMG9FSUQ5UDIwOFFvQjRMend3?=
 =?utf-8?B?eUZZTFVYdmlrMGtlWER4TUVweXlwMHRwRnh2RHpRWWdjU2p6MUxiZTVlNUEx?=
 =?utf-8?B?aUMwR0p4TG1wQ2hIbWJHVzNGVHhVU2lVVk14QWtVbUxvM0krYitCdUJkYlBS?=
 =?utf-8?B?MDNoaE9QNm01a1c4R1U0QkpsQlFTWEFTVklnL29PZUF4RDRkNnp0RzVwQjhN?=
 =?utf-8?B?ZkkvMkJ6c054bXdSTEFmeUthZEY1dzcwbUM5Mm9hclFWbGVqYUU4TDgrdUR1?=
 =?utf-8?B?Y0xZNWN3c3YvSGZqRmc4Tm5wQk1POE96eG93ZU9NTVVkczhST0VmTDlERUtU?=
 =?utf-8?B?dHFHNEViR254L0xtejJOOERqK0hXL3JpcERFZmEzNnlPY3dRb2NBMmtCZDJD?=
 =?utf-8?B?OFlVUTdzcEQzYVlWdm03dXJVS1EzOWFTWGJaRndXc3RzUnpMMTJoK0tzeU4r?=
 =?utf-8?B?eFFOZC9oV0NSdS9WMDRqZjlPUnp2OFJPTWU4UTBBYStoSzErR1BzNkdxQ1cr?=
 =?utf-8?B?azUzNGhKckhGRlpxc3ZiR1hlcjR1bDdINmV1NUNlVzBpb1c4SlFiODhsQVNW?=
 =?utf-8?B?MjUzUEdNb0hmUG0zTHZQNXBjTkNnVkFOOGMwYU05WHRIaEdCa3pZU0lCTFps?=
 =?utf-8?B?UHZnSmdPaXZhejQyd1ZzVlIvaFdzZ2dTeHRNS1phcVdIVVFyYmpZcEtUaGNo?=
 =?utf-8?B?d2h1QVdWbytURW1GdFUvd3NUVWIxTTNhR2M3aE90TFVHNnZ5dUFub3VYUlRh?=
 =?utf-8?B?d2RGQkxrNy94UTlES29VZ1MrMmlrTEMzMkRrRGlrdzluNDR6UFhnWE5WYnRq?=
 =?utf-8?B?RytaYUJkcCtneHI1ekZtWXdnd2FmRk1PRFBjclJ3MjFmYTQ1K25LRldNQkd6?=
 =?utf-8?B?V0pGbm1uZEV3N2V2NnlWNEMyZU5WSmJ5OXpFU2hrckNITFc3WHN4cWZ1Wk92?=
 =?utf-8?B?Y01kTkZ4eTJtYUlaeU5jeGVObC94NDdBcmcvVHBFdzMzOHdyeGk5dEhFUDM0?=
 =?utf-8?B?WDFLT0JyQjdnVE1oSDJCSmkyMng0b2JxZ2hjYTlkTVhxT01yUzBLMVRSWEtl?=
 =?utf-8?B?WjR3WTdqRGJ3eXN0NE91MUNQTHNINFhjc3lQZ0NHVUk5aTcxaFdtbGJHL3g2?=
 =?utf-8?B?UEFVQktWbjZTS29LSXVKWFd1NXVYQkNzOHBsVUpPQkt6NHNmRGtuUGFjQnl5?=
 =?utf-8?B?N3h2ZkxYWm9WS2RMTEpNTFZQek5TMDBWUDBqSWFWVG5aQlBRUzBZay9QOXVo?=
 =?utf-8?B?L0kvakludDlqRVlMZHNrb3p6ckVybER5elhuMkFmcldoT083ZVMyUjlwN1Ru?=
 =?utf-8?B?TVorWEMrR2hZYldVakpTdFo3eDNLMVBlbXV1NyswYWZoSWVwdjY2UVBPTWZu?=
 =?utf-8?Q?jPI0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2968e6ca-ec4c-4b26-19e3-08da642dd970
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 17:42:11.1904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sr3vQk4br6No4IjAes+Uh4HQNuNR1QXig4O3Tn7QCVGCubGAFjawfgrb6jH6b685
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5660
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
Cc: Leo Liu <Leo.Liu@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <Marek.Olsak@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-07-12 13:00, Alex Deucher wrote:
> On Tue, Jul 12, 2022 at 12:28 PM <sunpeng.li@amd.com> wrote:
>>
>> From: Leo Li <sunpeng.li@amd.com>
>>
>> When pinning a buffer, we should check to see if there are any
>> additional restrictions imposed by bo->preferred_domains. This will
>> prevent the BO from being moved to an invalid domain when pinning.
>>
>> For example, this can happen if the user requests to create a BO in GTT
>> domain for display scanout. amdgpu_dm will allow pinning to either VRAM
>> or GTT domains, since DCN can scanout from either or. However, in
>> amdgpu_bo_pin_restricted(), pinning to VRAM is preferred if there is
>> adequate carveout. This can lead to pinning to VRAM despite the user
>> requesting GTT placement for the BO.
>>
>> v2: Allow the kernel to override the domain, which can happen when
>>      exporting a BO to a V4L camera (for example).
>>
>> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Pushed, thanks!
- Leo

> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 8a7b0f6162da..bbd3b8b14cfb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -883,6 +883,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>>          if (WARN_ON_ONCE(min_offset > max_offset))
>>                  return -EINVAL;
>>
>> +       /* Check domain to be pinned to against preferred domains */
>> +       if (bo->preferred_domains & domain)
>> +               domain = bo->preferred_domains & domain;
>> +
>>          /* A shared bo cannot be migrated to VRAM */
>>          if (bo->tbo.base.import_attach) {
>>                  if (domain & AMDGPU_GEM_DOMAIN_GTT)
>> --
>> 2.37.0
>>
