Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF21C0015E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 13:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6751210E31D;
	Mon, 24 Jul 2023 13:41:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A206610E31D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 13:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVf5lq2SKfZoeQ3yyqZE2/nP0PANbwvymNerzIN3P1Uxo1F65dQAAKuMsiA4ShTmr7oA8Lh0mM0FmGK3LbsdeYMZ0BbwbT2QSXJKyud1kFLWprGV2iODVRGwr89he76Pwk84AWNRuR9kUsGV6c1xqrOQDCtmLFH4heXNBLBUN+xEG23AnQcVj/aWd/T+/B8Qfcxoztu5ZfnlM/ocINqT5Di2KnoZjojDXSkupbPlDHGzP4qM/rFBZCrrtFU3zT4tm+yGJMsGvV/I6DbUlM0+e21yEpoYzdRY9ukzKxtoXLDOuYKMAQYP91K0ixBHvCtn/ZwNQnH24UZbkVZRCU+MkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+yNDt4vW9aJsG3euqUnC95sFQkKeGxjl1uK6QOVpIo=;
 b=au0Ca3lGRc3SDNSklEljN6CiqIFuO+oJdInmfux5ILan+uAey9S/necnSJ9PSQdjtvXKofIyIQ6ZNs3DgOQwsqfVBwrn99ji1MPJgrtvJ8O2E+kutlnVL59E5jlp/j+s9iuByc7TVvoNGbrH5f6ep7i94hRGr/Mt4o9CMTUshtEetGA8uDgv/AwPkxRQbw+UfKGbCTQvDZqZYOF2ExWMRQA4lKcQSjAwVrNVndVPd0xWqWEvcM/iaNfuITtk5KONMz6Wzk5S6zT9HOROfkBbvJBIYHVheOe0eoBgrwE7g2O2pcp/VlJzlqRP0I/dV2WGw2HsvxSvKKOYmEa4qbwIXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+yNDt4vW9aJsG3euqUnC95sFQkKeGxjl1uK6QOVpIo=;
 b=p9h8PVmlTxzZTZaAj1lgDv63AL3E4EPt5V702zDKWKT675tjMUiwroYyH1ecEqya9/19tKyQZUq0Vq5t5h6LD9Im5rH2cvn+F8YdjAslj/DVxxgReJDAfGwhR8vQaRWdhC+qAc6fU0e8XMKrWGoaEI0Kc90uBfXYe2+qUc2Evrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 13:41:11 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9fd8:53b3:2a30:5d93]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::9fd8:53b3:2a30:5d93%5]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 13:41:10 +0000
Message-ID: <5c0ae79c-7701-5889-1a23-21a57cf19595@amd.com>
Date: Mon, 24 Jul 2023 09:44:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd/display: Implement zpos property
To: Joshua Ashton <joshua@froggi.es>, Nicholas Choi <nicholas.choi@amd.com>,
 "Akuneme, Ekene" <Ekene.Akuneme@amd.com>
References: <20230709020700.3116749-1-joshua@froggi.es>
 <20230709020700.3116749-3-joshua@froggi.es>
 <9c8f8fcd-d730-22b7-f46a-5a6b326bde32@amd.com>
Content-Language: en-US
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
In-Reply-To: <9c8f8fcd-d730-22b7-f46a-5a6b326bde32@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CP4P284CA0004.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:128::11) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: f701055c-61c5-4f52-4776-08db8c4ba3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKP743prZe6eY8aaVzK8k/YwJkQQO+zAhMtQL7cliRIW6OqlqqhGHd48TZ3W6KtSPqUSu1d+pc1yz8mSaAJIYJsEyIku0Qp4hJahDAfM2+E22xClLtfIqMDkyxm1AByCckuIbtu9p08Gag3COHLnov8Ha63tXIw5RrmZC7YrJpBNfJvEMxNZnriuHYOWKCvQWUV6stehIltyGpuw1aTTVcdNl4hFOpeNKRu5dkd1IXqjR3j+CbOVKbYFbyJf3LtzGdG6sMC9zildwfTniAcbOxahMNn8hdxB+l/pWHWKpmkuM/5QuQ8bbE9p/se2a38okN3w9sT0iiqFD7SwLptzAiRBs1/V9XPYphmGTu2aG/Rmw2EPCZBbj0b7hufdIMbTvONboLf1lkzIXg+aRbYfd9G1OiEQc1EhEjdNLDtVHfT3/7leT8oSasOB3PJUjZToZviWIvlA+XGYsnXhN6dy91bjfflfq14L/IjG/tbis0UfGy9/7Y8Et7VAYdiOVB6GICBYPLo2+rKz34J43hNaB1EjerIop2Q7xISgdpmb6yZT+NxJ4uGQsxsJXL9r5lmDaxs39WtsiNO+gbxDUpGkw0sXUzzcuwAACTUN4PIupsIXS23oM25/7R3VOf740sw5JLmKsYj09JhoIOK4TRamFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(86362001)(38100700002)(6486002)(2906002)(6512007)(6666004)(2616005)(53546011)(186003)(6506007)(26005)(36756003)(5660300002)(41300700001)(66476007)(66946007)(66556008)(31686004)(316002)(6636002)(4326008)(478600001)(8676002)(8936002)(54906003)(31696002)(110136005)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cko4T3JyYkEwYUVIZEh3SHoyQ0UwUmhsRUVpOUVxL1VvVWRWYXU1ZWttcDgv?=
 =?utf-8?B?R3pIQ2QxRndBVU9xdDJ3OTdreml4NEZTbnRTNmprcU1hQ3R1QmVHQ2ZyeEVz?=
 =?utf-8?B?WElSTExzOGh1M3FFUlljOWhtQWJUOEVMcXJleDU4b3FVdVVXa2QvVXozOTVF?=
 =?utf-8?B?bTRsQ2hSYmpRUkFEZitEb3pLQmdmaS9OT1NFRU9pREQ3MVc2dnBBZHI1aitX?=
 =?utf-8?B?SjhKMjZUOG4vcWp3U29VekpabktKd2lhQmFlUXYzaEJEaExtK1ZySEdKNHlI?=
 =?utf-8?B?WUxRd3B5YVZ5RDh5empXbGs5SVhrTWFiOUJkM1VtTHFYU2ZMNkYvL2t6NGVE?=
 =?utf-8?B?azJqKzErYnRubUZqZ2J1eUFCajlEM05IUngxaUM3c2c4YWRJMTk1OWx3OE16?=
 =?utf-8?B?bTNlTmVpd3M1ZDJpeERIV3JqUzJneGtaNVBtZHVNUS9IbXhRUS9vcmdhNmFj?=
 =?utf-8?B?UlB2RVZQUTRkc1g5YmJjYWRpWUpWU2hIcEVWUEw1bUZNYXRmN3BGTDRGTklG?=
 =?utf-8?B?UjU4WjRWcjFHY1hKUWNjSVQrb1lUWFFjZi9lNDM0NmJBd1h2Y2E0K2RCMXJH?=
 =?utf-8?B?UnZ0Z3ArWjVtQlgvbE1sU2swaHVSTW8zM0NSYjdqMjIrRWVKdmRHcjJmK0ZH?=
 =?utf-8?B?UTBYQjQ5Q2pHempYeFFwSUtKNldqTC9NUlZYZDA4eXlOVktYSituako4T0dP?=
 =?utf-8?B?U3FrR0pTQTZVK2t6K1UybWFPa3J1Q0l0TWNNWkpvcWI1dnpkb1RkVTljQnZH?=
 =?utf-8?B?MDVSeUt6ckcwdEFmS1J1S0c4ZmgvMDFyK2s5bGplRUVCazlZZUNFdDQ5VWRS?=
 =?utf-8?B?dUJ1U2hOOFN2L2pRNktGb0VHb1QrVVVjd29aR3hZOHN0WndLNmJkWHFvVU01?=
 =?utf-8?B?QXlRY041MTVVbGgwUU8yejRDbHhseDVPL2ZkMmppa292Q3JkMDNpbEc3aDc5?=
 =?utf-8?B?c3lTYjd5Sk1nSlNTdCtINVNRS1MyYUx5c2xTcUdabitsVy9EMEd4UDBOMWNj?=
 =?utf-8?B?blQ5TGM0Y1lkNXRSN09udWNDeTA3RDZHaFNOYTk4YlQyejJsbWNRdWRISjdv?=
 =?utf-8?B?STcvNmgzUnk3b01kbVZ2Ny9jakJnekxPVEs4UXUvd3pEK0taYnVZUkdueFVF?=
 =?utf-8?B?cTBSb3BPbkVoRXA0dThCOFh6NHc5Mk1yYWs4T21OTUZGaFZwSGhaVVRDVnZx?=
 =?utf-8?B?MUdZNDl1YTk4TVVtZnc0VXh0NnZ5bThvcy95a24wY2ZIcDVJUG54Zk1OVjB4?=
 =?utf-8?B?VW80KzA0WVoremZ1VlZUUEZLc2h2RnRBZkRTUDN0TklqL1dDRzZZQkNDaGtx?=
 =?utf-8?B?bmNsSFhBczE0dmR6K0hIVll2UGhpeTl1S2RNM1NkS0srbVllK1dxWFIwbUlt?=
 =?utf-8?B?UGdOWnlpVHhrN2dlTEZscVlWTGlDV29MMmx5aDF4WTc4RGs0ZlNjMHJyQW8y?=
 =?utf-8?B?aDJFRTZya3hUR3k1TXZTeDVXOURtZGNYQmNhblRzcG03VHNJMWJTRHhxL05C?=
 =?utf-8?B?OEtTQzNBTHdMeWkxLzRQSzRFS2p3RWhqRTZsVHBxODZFZUk1bkt4VENPRnpq?=
 =?utf-8?B?S2FZaFZkcHRKd2JEYmpyb0JDc1p4RE1pT2d4QWZPWThJdEhpSDZLanRGNmZk?=
 =?utf-8?B?SEVTQ2RuNjZydSszNGZ1cnljR1R0Wi95R3dMVlZQUG44aExyUHM5UWxDUG9n?=
 =?utf-8?B?emU5OHhuYkJFNlFJOEczNlQ1dVpDeGN5NXhmTmRoMFdzM3drd1VkWU1PQ2Za?=
 =?utf-8?B?a0QwZHIrdTdLV2gvNUt3RWhhQ0pWa3o1MlJ6ZGVpVjhHZ0I0WXBudmkxb09j?=
 =?utf-8?B?WERIN1JVVEZLZG9JOFFONXhYeUZvV2h3THh4bXhoZ3F5Q3hUR0ZPbEZYV0FK?=
 =?utf-8?B?UldyREMvNVJUM3g1VzNhRnBzSG51UEd4QVhxQUs4UDNybDJ0MU13S2xvOUR6?=
 =?utf-8?B?K0hPcWRDWVF0dGJqNDUzWjd2bWJxVjlQS3hycFdxVStQRkZ2bCtnSEkvRjA5?=
 =?utf-8?B?dlkrOTlLaUxZQ1NiUENVRHRYRDVKWVhVU1J6TDV5M1h2TlRnazljVm95WHZr?=
 =?utf-8?B?aEhYNHp2dTJDaXh2M0RWbyttZEpHaTcreStUK25tRi9BSGMvSHZ3S0Zsa2JE?=
 =?utf-8?Q?bnN0u5cZsdYUQA0JVhdJgmShP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f701055c-61c5-4f52-4776-08db8c4ba3fe
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 13:41:10.8163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bf48nd8HGbrLKr6GE68uUnnTJ8RVgExxveb+bpN2SujIY0jqXqk5BD+waR+t7qPFO+FzhGngWB8v4Z8Wu7tzsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040
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
Cc: Melissa Wen <mwen@igalia.com>, Simon Ser <contact@emersion.fr>,
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Joshua,

It looks like this patch caused a regression in the following IGT test:

kms_atomic@plane-immutable-zpos

This issue is causing failures in our CI; we probably need to revert it. 
Could you check it?

Thanks
Siqueira

On 7/13/23 13:55, Harry Wentland wrote:
> 
> 
> On 2023-07-08 22:06, Joshua Ashton wrote:
>> Despite certain GPUs supporting multiple overlay planes already in
>> AMDGPU, the driver did not expose the zpos property which is required
>> for userspace to take advantage of multiple overlay planes in any
>> meaningful way.
>>
>> The driver was already hooked up to normalized_zpos, but was just
>> missing the exposure of it.
>>
>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> 
> Series is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> Harry
> 
>>
>> Cc: Harry Wentland <harry.wentland@amd.com>
>> Cc: Melissa Wen <mwen@igalia.com>
>> Cc: Simon Ser <contact@emersion.fr>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> index 8eeca160d434..2198df96ed6f 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> @@ -1468,6 +1468,15 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>>   		drm_plane_create_blend_mode_property(plane, blend_caps);
>>   	}
>>   
>> +	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
>> +		drm_plane_create_zpos_immutable_property(plane, 0);
>> +	} else if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
>> +		unsigned int zpos = 1 + drm_plane_index(plane);
>> +		drm_plane_create_zpos_property(plane, zpos, 1, 254);
>> +	} else if (plane->type == DRM_PLANE_TYPE_CURSOR) {
>> +		drm_plane_create_zpos_immutable_property(plane, 255);
>> +	}
>> +
>>   	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
>>   	    plane_cap &&
>>   	    (plane_cap->pixel_format_support.nv12 ||
> 
