Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F484C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B43B112A21F;
	Thu, 30 Jun 2022 19:28:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F259011BAE8
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/Wk59xAuw9N4tm/KP3kUBVZCHhTaI8N9CLqTs0ljZNZ1H4dyW5370i2zvVtcF2nBY4TAdPkeHjm/ztZi+UFRFTErbTlJm3A5Eo+K8jMJyI4+dgPE7F5U13vZUPWCKIZe4s1e4w8ix9yrNvNsSwzmVF68iG2EBIz7S2fbn1tTasW9bpG9GdbQwQJgeeHRoQR2J25vZoNTI5uvOybBRzP7iQXltrRgXKpsCgC7PlZryoFy+Frrdzko1ZrZwXSAaHZqu6iqnIiwry/Zkt8yJb1dt78CqmxjHuAoQ5axDxQWaRV3naqabEDaWyf/lT42b/XEC6hLgCsFwb0Wz2CYCIWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfL8g/rT55giFi9HrdUluyaQqyL++k2diDlBancdh1g=;
 b=cn26AoyRD8RWtApI07IpWuPYWLFTtf7W9sA9m2z3joR7qMfUc9AzRURCn8iIu4ziJ7y72uncHU2F4TmT34wyZ5kzvbJ9NgeMEdjMmJU3IGWU9dsIJpSPZqyCcckqAB0/MASfwYcTOud3bwFb4d8TsBPQQlNTHUBCB0D8HN28+Hp4QtNKVzvhelCy3ajwPp5qVcVm+tdgJuvAHdt7cXsLXBwVyXPgwS7/wM9txq4ndc/6OLBzd6v0gwOuHG3atJs7mVjND6B6+v6PMlyPzNeQE/085or4iYjBAhYDdAaBZTbQYNUVG2HgJa8/+HyrgX3UNic10jrSdla+jyuQ//GkzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfL8g/rT55giFi9HrdUluyaQqyL++k2diDlBancdh1g=;
 b=Ssz8ygF+SsSs8rXTskfPEjVusz5IN0RHXkeXpIqm8hwlqJaQu7VFw7O+gWpSPmor8+MMr4odb40mJsJPCkFzxk8UBB8JwLEyFKuKQzudCjIeqlfhtZzZeh7yrOrYnopihxflIHBP2PLiY9cF0q7nnwZqxYpyfPMkPDiggk/d9e0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 19:28:55 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::1563:b9e5:78e3:5c15]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::1563:b9e5:78e3:5c15%6]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 19:28:54 +0000
Message-ID: <7eaf9676-b6ac-c2d0-2950-da7ffb31848f@amd.com>
Date: Thu, 30 Jun 2022 15:28:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/amd: Add debug mask for subviewport mclk switch
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220628212635.2263706-1-aurabindo.pillai@amd.com>
 <CADnq5_ND=YHJ_gTx5VLOx7zJzRbaZmCQHA2uo5HZHBrjzvyDMw@mail.gmail.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <CADnq5_ND=YHJ_gTx5VLOx7zJzRbaZmCQHA2uo5HZHBrjzvyDMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:208:32a::25) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6685b7c3-14b0-4c30-b56f-08da5acec560
X-MS-TrafficTypeDiagnostic: DM6PR12MB3179:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ToskhudfibQdvIiSQuwLdHCh3pRqRdX3uzndZ5SMfG8gbRxAsXv6d3LGs2CTCrDDMTQGa7eeP7iaArMbfkVIDNrmiGe1yDyE/sqbIpvDVkSVSyeS6t9H23qi0tx3Cqizw4xyX23QZdJFOC9vahnOOkPgGQkQdov19gMDYh/hVTYFgCtmAe7rxEnbxpkXPQ6c7r7gteVqXtu0gT0EhR3sD9XkQbkh1fd/mo2D6e5JDYUxZJZ5DG0hqMfDSo/3KS3oNaJdBLHqLFjzZ0JKddvDJvtN7vIKNkI2L/2Yuxh+avBElNgggyh8ZXVvDeHQxlAfVdbcwZqQ6Put0L10k5Uc/ExUed5YmPktmhrRAUsnsXknvVfnSqEg4iTPlN+tUU2ByzEGb04jvJqh/Q932oDKr6NsKXFnjvxsAXgQgobH22WQX/wQzYhl/Mwo/zG/bnnHu1BHQpmFvL18nLclBNs+MnvVTfi90++hHEg43DeH5Mz6n5J6cDKE6jnxgInM70kFT0146zixp9Mo0WhkuMt2bwMRGHv98zAjBW3NClTVu5dvt3nrt9F16dv9PwFtWf4pm6Q1wjwss9/H79OXGGGn7Vzuc5rV9SLs0IF9xixXSsZun4dCvFOJ8l6pCpkPE3V4nL/4IG0mZEFFoWve8k0uqzU655juMDWfPJT5FuFRbzHwDEPaw9t7TwtqGmOaTKIVERmVKHts0U5ui0gNIj9w27FRZ9tvl9/5yWNR1nHBv95JP+5d4lVlxjlFmfflTnUDz+5RtD97Wx1edRXsf+zEIfIEBJuhvqlPO0igi5Ru+ahyqJSKtlkMyC+w82UScAC/byTPmJhO1VzoWGPdCATe7UrQqWQ6NNQ2bExFmg19gXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(2906002)(316002)(31686004)(186003)(54906003)(2616005)(66946007)(83380400001)(44832011)(5660300002)(36756003)(8936002)(6916009)(66556008)(41300700001)(31696002)(8676002)(478600001)(26005)(6506007)(4326008)(86362001)(38100700002)(53546011)(6486002)(66476007)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REU0eWxpelRGQi9JaHJpUG0vUmxYcXEyZ280RVdBcnBpYmRXdVRnbEtPMHRx?=
 =?utf-8?B?QXpaWUdScW5VakNGOElDK0t5UGE5amZnSUpUdy9mOWJIanVldk5jUkpocEFY?=
 =?utf-8?B?YmM5U3g5ZmpUdEFnM0NTRFJkMXVwcmo4R0xNeE9EOW5Va0ZjUjFOekNwYWtR?=
 =?utf-8?B?SWFxZ3R0dlcxUFdQUDhnNm80bjFWdnVYbXJkTHg0bnQ4dWUzTHpZenZsMmlI?=
 =?utf-8?B?RVF1dnBQOGp6cDFYK0c2U0lZemdGZTBsdU4rZ0tXUWdnUjh5b2lKTS9oMU9Y?=
 =?utf-8?B?N2VSWkxSRFJaOC9ZN2RUdkNGWGxSSm1oNVRmQndSODBhT0gwMnJpZ3FmenFa?=
 =?utf-8?B?WUFmcEdOS3RkU0tRYittK0hrWHVNb1o2S0ZVWEo1S21MbWxycVR5VHJlK3U5?=
 =?utf-8?B?UUJLTVdBSUtiK29SZzFlcVpINTN4SDNxSDhiSXhXTzJDVkduMlVhWnM1cTZJ?=
 =?utf-8?B?YnFySW53emwxbVc3d2UrSXlCSnRyc2lIOW9lK3I1am5MZWw3MGo2Y0gxNFdu?=
 =?utf-8?B?dkFXQmZXbWlsZE5nRi9kZVoyNWdrYS85aHdObFNObVdpZU9wb1VLdTNsYk9q?=
 =?utf-8?B?anU0eFpnTHRIbGc4VFpwYjlOZWYzc1IrZEpkTnNrTVQwQU9URVVwN292U3dS?=
 =?utf-8?B?ZkJESWtPTmN2d2VraGlMemxtN3gwMVlSTVl6YVZwb3U2TE96ODI3SjBEcXli?=
 =?utf-8?B?ME9Ea1h1SnhJakprbVA5bVBjdVZqNlBLa1MzM0tXTXQ2NlB6RXk5UkdUYVBP?=
 =?utf-8?B?c2VLUHZEM3FhT2hoWHpGczZBZHdUdlVpKzFSd1RPbmJnZ3FDY1l2Zm5tbVBj?=
 =?utf-8?B?UERzeDExaGNtdWJYMmp0QzZvVC9Xb0FQNXVzRCs4eXMxRWdKTlB6ZVkrN04r?=
 =?utf-8?B?dFNxMmtTNzVQalowNGZuNDlUT0JYQ3hFZlZvQm9veXdQMGFFZEdjblBpb0pk?=
 =?utf-8?B?aklqU25mbHAzVmcrSCt3VkhBU0RrZUxUSGpOY2tJVGVuL3B5Z3d3WXFrQU9B?=
 =?utf-8?B?MHg2NncrMTRnVEt3dlpQTjlBNEZLTG5VNldadXpJVHBXTjRTWmZMbm5zREtX?=
 =?utf-8?B?NVZjYnZxUm45eE50RkxVbHJaRXpWMCt5ajl5RU4vZUNRTFl1WGpNT2ZUUndZ?=
 =?utf-8?B?UTY1aTZucEJGK1ZBd2pqdkxVVWhzMlJiUnM2K3hqZFhvL1FJalJOMXVUZkxV?=
 =?utf-8?B?MkhqZTdKeSs0NHg1RGl1bnhpV2FlOUNxSGhrbS9WOEJXR0ZaZVVtZ0Y1S0hX?=
 =?utf-8?B?VHJDS0czMzZvUERzWkpGVFF1WEIxMGo3aDdiVzZVRWxua1FPYzVFTG5XTE5j?=
 =?utf-8?B?RWwvZThIRlRxZnNyc1F4ZnpaMTlxL2dldCs5cXVUSEN2U2p2a1k4M0ordTJ1?=
 =?utf-8?B?S2tVSGxuQUloZXNWZkRIYk9GRTlhWnVudHNDLzdYQmVtdUNVNGRJOUx6UkZk?=
 =?utf-8?B?dCs4NG9NM3pyd0duM0ROcldTbmpNQ1lGQ2NCalpVT1NCTDA4YlNFOWx6TWta?=
 =?utf-8?B?UXkrYkszS2pUNnZRTUNrMlJKTm9IdzMwNDBuaFZnVXY0ekhEVFJ1REx4UDBJ?=
 =?utf-8?B?YUgyaU9LelpZRDl2VzV0OVBnTWNCVWxjQ2hXQVF4VkpsOURlcjJ6UTR6aGQ0?=
 =?utf-8?B?UEhmYktweWJYZ0krd2RPRSt1eGg5SEsyK0hMaWhGemViYWlqT0FpaUprUXZZ?=
 =?utf-8?B?MEdwVzhKN0NUUW95YzI5Tm9GRVcxdGljVjY5R3NDb2lYMzJxbVQyV0grMWcy?=
 =?utf-8?B?VkdmaDNaVHkyZ2xuMzEvU1U5K0FmMDRWKzVoZ2t6VWhjRmRqS0JYclRnbWNG?=
 =?utf-8?B?dGFENGFqbjBKeXRES3JuSGdtb2ZabS91V2cxOGJXcmdrZ2VJczl0ZzlyTHQ4?=
 =?utf-8?B?TXRYa2psaGc3VkF3RzNBN3JadTM4VVVqeXJVcmZyRmdkM3p1UnhsQWIzRHFr?=
 =?utf-8?B?eVRXTThubEMyWTJ4NXhLSmx4TDdLME4vN0VhV0I2VTNzcmVPb2ZZV2lJeDI5?=
 =?utf-8?B?cE5PWE40MzhoODl2QUwrZHZKQ3J5RXorSlFoLzZacmRvUkxHcHNwdFZBZE0w?=
 =?utf-8?B?dGhCTWtHTk9kMEZJUTR5MWRJT092YmlqaE4ralNKNWVQaGtMT0NzVVd0QW5S?=
 =?utf-8?Q?Zc3Q2cxzHPwgwLaLfu4YBkeBe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6685b7c3-14b0-4c30-b56f-08da5acec560
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:28:54.8808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAU4R36nK9rqsJUXQM9V/A3oWjZv0FASMSI55gwm/E6EWwjFMx7pmcQapg2KFMxClc+pmWFtybH18tCZzfB0kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
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
Cc: "Wentland, Harry" <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-30 14:28, Alex Deucher wrote:
> On Tue, Jun 28, 2022 at 5:26 PM Aurabindo Pillai
> <aurabindo.pillai@amd.com> wrote:
>>
>> [Why&How]
>> Expose a new debugfs enum to force a subviewport memory clock switch
>> to facilitate easy testing.
>>
> 
> Is the debugfs support already plumbed in and this just enables you to
> use it?  If it's in debugfs, do we really need a module parameter to
> enable it or can it just be enabled by default and used via debugfs
> when needed?

Sorry, I meant to put in debug mask, like in the title. Will fix that. 
There is no debugfs associated with this change. The change in DM is 
enough to enable this.
> 
> Alex
> 
>> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>>   drivers/gpu/drm/amd/include/amd_shared.h          | 1 +
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index c9145864ed2b..7a034ca95be2 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1559,6 +1559,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>          if (amdgpu_dc_debug_mask & DC_DISABLE_CLOCK_GATING)
>>                  adev->dm.dc->debug.disable_clock_gate = true;
>>
>> +       if (amdgpu_dc_debug_mask & DC_FORCE_SUBVP_MCLK_SWITCH)
>> +               adev->dm.dc->debug.force_subvp_mclk_switch = true;
>> +
>>          r = dm_dmub_hw_init(adev);
>>          if (r) {
>>                  DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
>> index bcdf7453a403..b1c55dd7b498 100644
>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>> @@ -247,6 +247,7 @@ enum DC_DEBUG_MASK {
>>          DC_DISABLE_DSC = 0x4,
>>          DC_DISABLE_CLOCK_GATING = 0x8,
>>          DC_DISABLE_PSR = 0x10,
>> +       DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
>>   };
>>
>>   enum amd_dpm_forced_level;
>> --
>> 2.36.1
>>
