Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB8ACF258C
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 08:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E5510E234;
	Wed, 19 Nov 2025 08:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AJuYtUVp";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08AB410E234
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 08:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/DEzSfW2F0iJzCG44HjwsPCvGF3RUzgnaqVn9L/gth2t4IGmiYQ5nuFvNhTQJWjMJ97uEinnqI/WkrQDm8OGs2NEfyqIBZ6jO93I9uGqkSZw+lxEqHwVJMPGiGqA9AVmUvKf5nkVzpkebsurVBya4OdmOBLSWAY8db5uiUOvfzHTW0PstpnQlqW41H+Id9sSGZOqh+ly/x0dLvwQ1i/tcaqk64zQsto9iycNP4Qngc3y5ZgFNoPO8ZpnvqEwT07u+GDZF5S5ED1LrC3HieoVD9xaCHuKSzEGJITlaB8UfKVXbf4kp/PhpO9CgJrFFFoFF6SIG9fKisMttIOlGTE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXR+PEXJgPsDJ/LTvXMuUNvbewCNEKeyWSmqLtUgjKA=;
 b=Rek8Wad5hJe11dLDBPVK5guM1WhdUpV5sMhhIjuH9UGheq86VF7m1NwOu2GisnE8yOijp+Jq0BYUzfPDDsL9eesEkW6JIW0vb9uWc0En6iaA5JeSJ0YphHjOyEUzhWVVZMl0HgzFirEFi5lYGIDEo3G64lLwJ/REcPJuooOMPV7JJp3awTFf8gSYACaZ+aMiR1qEfagGnZaDZzb8jLj4MtSrk6UnsqNvdl7USsyvujarLt62xlmq59qWuQYk4wmUsQQ4jNU/vMOr/26exGOahnBaCfWufe6p1SpJdH1VOxaLHS8eVMqVIvntACL9a5qirWSWACH8+FDGstvVe7mRsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXR+PEXJgPsDJ/LTvXMuUNvbewCNEKeyWSmqLtUgjKA=;
 b=AJuYtUVpaKGmlN3ckUttqHVORupQ6FMOfOVr5UR6qULaVyN0wtt37uSyLik3ukRaGz8Xz33q4W5+9PZBLbPl8ezubevkcmidoF/LSQFa1NV6oWLCnP4nVUDL+adrL6M4rofAlr0kn+R7HesHJ20xswHlvAb+MLWuiSyz11iEEgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 08:33:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 08:33:37 +0000
Message-ID: <29631fec-eccf-43dc-8d88-a899cab6322b@amd.com>
Date: Wed, 19 Nov 2025 09:33:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu/uapi: Clarify comment on AMDGPU_VM_PAGE_PRT
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20251118165620.216753-1-timur.kristof@gmail.com>
 <20251118165620.216753-2-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251118165620.216753-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0371.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: dd24f73b-b072-4c4d-5100-08de27465569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUNJNkNwWHdmSHNmNnB3NTFySFVRaTZrMW9zYjFjeHppcThBYUZuVWdnSFRH?=
 =?utf-8?B?ZnhhTW82eittR1VHNnNubFVCVUlKcy9wYnlmVVpMelR0L1NOM3ZRNVdmSjZE?=
 =?utf-8?B?emtoSEp3bTJXaERyOXJ4RTgvemdkMWJ1a3F0by9ZSjJzOURHL0J5WXZDYUFB?=
 =?utf-8?B?RS95Z0lMR1MxSVUzZ0VKNjB6NFdJbzFBVU9sbmVXQ1JKTGdGVlk3ZWFuUmhj?=
 =?utf-8?B?ZkNiQWVxc05MQnVYOWdPUmRNRU41T1lYOUMzWUxzOWNoOWRvVGtidkJqSENL?=
 =?utf-8?B?M3BuOWNKV2U1ekh0QmUxVW14ZEdpK1NrMDdXWlpxc1JXc28wNkV3dFh1MWlm?=
 =?utf-8?B?THpKNW45Um0rMHZTcFF5YVBqWVpsamZWUmxNcUZuK1o3cHBvazRzMFBLd2dT?=
 =?utf-8?B?T2Jac2p0bXBweEE2QkYxNWNnZVB2QzJ6OEhpbUNiQS9hUWI2ZVBZMGFqekNN?=
 =?utf-8?B?UmlPS0RFMDVGV28zcFRSZldLZnNLWlVtL1A4MFNiK2VXb0JhaXF1eUdFMElk?=
 =?utf-8?B?SlZSYmloUGtmMHl0MUYwb3V2OGNucS8waUVUWk1uUWZDMER0M09sYlZPT1hO?=
 =?utf-8?B?OGVjdHZRU1R3a1E2U3RrQ09KOVU0RXk2eXI1REJEemk3MVVFbTZDeXE3V3FX?=
 =?utf-8?B?aXk5TDNrQnQxUWNBcU9mZU5WODZjblJ5emdVcEpEcDcvSDBza09DUUs4T1Mw?=
 =?utf-8?B?RCt5U2FUdkhxaG01MjhtNTNkSGtCMHpOU2Z4bkpVdllaMXZ1dWczWEdZb1Zj?=
 =?utf-8?B?WEZYOEZsYzh0cGx3T0NUaGo1SWZyNHhLLzlWYWFHVkFZcmVPUUxzZ1ZtWEVI?=
 =?utf-8?B?M3dZaWE3VXplME5HWjA3ZGVZdEcxNXZYeDRwY3p5SC92aklXTzhzaHp3WnBr?=
 =?utf-8?B?ZW4rT216Y1h5NFFFQ211aXA1a2FIc1lwdDVSdDRURUN5ZWJRaG5Vc3g3STJT?=
 =?utf-8?B?eFZpdHl4ZnlST0pFcHFRcytZeHlWSnQzd0twS0F0U05ZY0ZmK1VLVVRlTUdu?=
 =?utf-8?B?UjBqZnovL2xFTnJYd1dKb2diNU4rNUUwRXoyVmF2WFU3S1IweHgyd3dQNGtz?=
 =?utf-8?B?dDJXRTM1Z2w5T3NaNmxlNVpiM29ENUVyOC83d0RSNTNsYUJrY21hVXJpcEpY?=
 =?utf-8?B?bkQ0bkRGRG1UQnpBUGpGZ3hZNHdJd2RteThFcGoydldMUDJTMXNaUWl5ckZ2?=
 =?utf-8?B?a2ZHUzE2QUVjUStYSmFtSVN0M0tsd2FCQzhqS3dNYkxzTUdGbFVoQVdtNWFw?=
 =?utf-8?B?Y0tldnl0SXF4SlFQYkY0cjhrTmlDQ3FDK1dVRjlPd2RwK3F4UjNMSUN2c09C?=
 =?utf-8?B?ZGpiSDdZUnE1dS9DeDh6VHlqNlhXSU9OZ0NZMEhIZnJyQ09GVzlKMXhJTTlk?=
 =?utf-8?B?c1RFTGJ6RVhERS9GVGlOY2JkRTBiMmV0b0xuSWhLUjJCcmdORDM3SlJkQ0VG?=
 =?utf-8?B?SFdFUHVjREhaa09VZGV1L1Nvd3kzUUMzdnBibUREbWdWQmFMZVdwV3IrSEZM?=
 =?utf-8?B?eUQzV3ljRkxMSFZFUHdrMHRJTFZLdUpKMGltK1J3cmt0ZjVKd21jTHpoVUE0?=
 =?utf-8?B?QitrS1ErR0w1dHB2M2RzZjFhS29vRlNzSWZQMU9DSnZkT2tBdTlMMHhFQ21S?=
 =?utf-8?B?UndnNW02Wk1aeWtkbkwyTEtEV3V2bXBrTUM1cVFxczUzZDZMSjF2ZzIyUGRQ?=
 =?utf-8?B?YlFTTFFTMDhHVnAydHJmcXRHWFdSTVJ3eS91NWJHUU9DR1pmMmVkMWZaYUZw?=
 =?utf-8?B?eXVUandTTDFNUDdqRFZjdng4Mm85K1NXeS9nVXdzVnh3akxtUnhKZVFYaTVX?=
 =?utf-8?B?MEFNVEJxWUJyaS9nQ0RQTHdIOUhPSEJYMmsySWg4N1c4eXlpSzZvd3p3YkJW?=
 =?utf-8?B?SjROWjlWMkV3blpkclEwOG1BcTY1MzRPZEE5M1hJYlJZL1VXVFBlRTU4Y21P?=
 =?utf-8?Q?DpSpkkKuzZYg5R0Uv6ssN1+2HQk6XF34?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDFTSGFoK1lLaW9Kalo3NUVrWTNjVzFGM2NBdDR4blFZdkJkeDViVDVWb0ls?=
 =?utf-8?B?am1WZmxlUXJ1T0cxemEvWGpqSitRUVZzYUJkOHBncFg3NFh4VGxqWkRMTStx?=
 =?utf-8?B?VHRtTDcwRUdLQmVvL1Z6bmlKbUJQbTI1cnd0RWNlYlhFZkdHUC9DQnFWZmQ4?=
 =?utf-8?B?cjJSdDE3cHcxOGlCYnI1MURUOVF2UStQMFozVkttM25WQnorQUJsSStuS1RD?=
 =?utf-8?B?ZW5IQTA4ZC94RElvSkFnVWV3QS85S2w3SlIrWUR2TWxSNnY5SVhvTDBQZWdL?=
 =?utf-8?B?WXE1RmM4QlhKK2lyTlN3UlhZc2ZrWEppNzg1NDg4ZXV4SHUyajNBc2NZY0hl?=
 =?utf-8?B?Yk51MnA3YXFCMVAxSHpoVURORzJzOWw0eXJRTXp1dTF5ZlBuNGE2aU9adG95?=
 =?utf-8?B?Mll6SEtZZW9NVzlwTVg2eTVaT2o0NVdsTmtjYVhrbFEreGkxck9qUnlJNTMy?=
 =?utf-8?B?cjc5VzdpbDZJWFhuQXJjY3diWm9IK2xPcGttNzJwRHk2SVJMdVZJOXNzb1VX?=
 =?utf-8?B?RDFacUxxd2lPeUM3VS9WaHpyUytNZGo0VUxtRHp5bGhjdmlJdVF6STF5UHZV?=
 =?utf-8?B?ak8zL1RxWWQ3ZEp0d2pKR2lNam9wQko5eUtCMVBOSndablo1M0g5VklGbU5N?=
 =?utf-8?B?V2V4TmtvWTYwd1Z6dXNsc0t4ZytPcWxaRk9pTy9RcEQyeERPeVQvL1h2MUNw?=
 =?utf-8?B?WTFhalZNNDVqU3dhZThiMzlvL2JyVUduM3ZIdVB2YU5CZmdpdXNQb3BmcXll?=
 =?utf-8?B?eURDRmJ4QXBkdElvdVRQZzFSYWs5T1p3TUxkK0lVcmlDbWZqRHQ3dmNKc2xP?=
 =?utf-8?B?WW9MWG1FVTdMdXl2dW5Dck1Ua3RxNEFBZk4xOTVUeDgyZHlOcnRJSUptd0xz?=
 =?utf-8?B?MCs4UXUzZHRLeDlreG84endyTFhZNlU3V0VpUmJQQXoranFla2FkMXB5Slph?=
 =?utf-8?B?RWxLQ3hsZFNROVl6aDVBbkF3QmhiVk10ekl2NEg1cFZrT2VreGRHc0RCdmJT?=
 =?utf-8?B?YklTTU5PR3UyQ1IwWE9rWGs1eUtmNU1WbkdDRi9SRnlyL1NieXdMWXlBck1R?=
 =?utf-8?B?VG1obENQZmorc2t5ZmVKMC9rL0toV3RUK3UzZzVRb2RTZ3prTEs0R1lETG1t?=
 =?utf-8?B?UndpVkJzUEFMb0toZXRueW1tdEhFSjFqaHNSbDErU0Q2bVZRdlNXNE4vSHlO?=
 =?utf-8?B?NVUwWkd1YUk0WlhIMTgzbnN0d3NORXZlOGladVQrQmJIWWp6clY2S2ZwWk9y?=
 =?utf-8?B?TElvVC95aHN5TU5EV1E1SnlzWGJ2Z01XM1dGcW93WCtZQjFSUTg5VnNWaGxx?=
 =?utf-8?B?VzAwVHFEZHdXa0xONmE1UnN1WE15emRkekQ0MWh3eVErQW9WSFM3MGNLQ1hq?=
 =?utf-8?B?N1N5ZTZPK1lpL1NaS2VIekVtdFVlQVJoZnZEcisxajBHdHpiZGlHQ0RibW96?=
 =?utf-8?B?UkpRZDVrWnJkT2tqY3M0QTVOQzBBTnRYZXR1Q3ZPaDM3T3FZMFRsQWkxbFIx?=
 =?utf-8?B?RGczZXpSemlVS2JSWGl5VVcwdlVxUU51cXpYVGJ0ZlNQQm4ybnpOS2VwbEdz?=
 =?utf-8?B?ZnFndGs0V0p3dnc5Nm9Vc0wrY3I4NVNtQ3YySE44WVBoUHdqZWZmZnJjcFFZ?=
 =?utf-8?B?WWlyQ1RvZlh5UDUrN2dHckN4ZUtBSTJBcWVwc2dNSHpIU20wdzJOamRlaVR2?=
 =?utf-8?B?bEltTGJXS0JFR0J4MmQyVS9aanNjVE1saGQwV3AyQjdvQWorZklobGtmT1dE?=
 =?utf-8?B?WUF5dUJiZ01VMVRic2FzakV1Qkw2dmVhL1BJT014NklEUEZHY2RQeXZIa0Nl?=
 =?utf-8?B?T3dRbVRMK0s0STk2ZDdhVmgrb1NiVGRWYTc1dnY2YnowcW9NczhEMmdCQldl?=
 =?utf-8?B?QzAybVBlVEZpZUFhUHlaeTJNVjBwdWlBd2RIeHlWQkpQckxEcTVuRGszQndH?=
 =?utf-8?B?SjZRY1phekp3bG81dWo5cnh1SWhoa3BwcGY5OFhkcklkcmZ6bThjWjU0Zkxj?=
 =?utf-8?B?b284aGNvdnowTGlpdTNodFBmSnFmSWg3bERyaEp2UzJubndCRTBRZEhhSG0w?=
 =?utf-8?B?VTg1emh2dXBPNEVVd20yUzJFcGJ1QytnOTRBaTFFdW9UOUVHbFVZTTJqQzdy?=
 =?utf-8?Q?o6Zg53Ux1Sn1tnqee5yam1TJ/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd24f73b-b072-4c4d-5100-08de27465569
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 08:33:37.1061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTdkO2UXTQ4WaU/CLR2Y9Z17myumZ7LNqZzNzQ0kXMNkuykIL7k2atdMzIV9GDsS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
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

On 11/18/25 17:56, Timur Kristóf wrote:
> In the context of the amdgpu uAPI, the PRT flag is referring only
> to unmapped pages of a partially resident texture (aka. sparse
> resource), but not the full resource.
> 
> Virtual addresses marked with this flag behave as follows:
> - Reads return zero
> - Writes are discarded
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  include/uapi/drm/amdgpu_drm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 406a42be429b..f43592997b49 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -883,7 +883,7 @@ struct drm_amdgpu_gem_list_handles_entry {
>  #define AMDGPU_VM_PAGE_WRITEABLE	(1 << 2)
>  /* executable mapping, new for VI */
>  #define AMDGPU_VM_PAGE_EXECUTABLE	(1 << 3)
> -/* partially resident texture */
> +/* unmapped page of partially resident textures */
>  #define AMDGPU_VM_PAGE_PRT		(1 << 4)
>  /* MTYPE flags use bit 5 to 8 */
>  #define AMDGPU_VM_MTYPE_MASK		(0xf << 5)

