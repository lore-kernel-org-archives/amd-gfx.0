Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB94CA0EF1
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 15:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8557A10E42D;
	Tue, 12 Sep 2023 15:06:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A79D510E42D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 15:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBj2enK6JjMGA4tNW+CPIenUw8dU30rS+2GCPSQJ3QkPjkO1d/RBz2rTW4Dmwbjq68Hdgcs933hPpSMhLQknYZdS04PFKVmwdGiPYeWEsGBx/x0xIxxcJNJmxIOGCD4oG60YqOfYgK4DfVkmoOOCQ0MrcjY2MNULvQKf94EcKltBGlHJWDpceVo0MW0t9qJr0aLnahShGSwI4xsXM/EpLg7Yle+UEsmKUbbH7S4KBPe0VLfcbT9ajL/4nk/wPBdQurJeBqSA6s8kcipN2OeyVbwYRW3qdDTNv50lFDT86mmz4TURqfvugZsL+B4oA8tMxcizIMr5Be6vzRj4vVIoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAsJv/m1QwIxTRSlCZa96+cdpoyIqWyTseKbAMnbaXQ=;
 b=HPMMavY7ZXcP1M8MpeSIq/p6/TLWWtgiTIlaQ7VQ2yOGm1Jl11VM1J5c2wIDWl/ilGgUzK1mohTqoeBiOjUs8Mq/ZtA43/PoYjhlRoNogCY15Og19yZJwFmQu65lioglhLpXfUQ4esMe45MKL+ZOWZ8i4IAvULjSffr6QRJ5uSzxwEQi2t08blFYWzKkR3JX80Z4VlPytvlRZjhlVzAnoOFJge1BpGfqNJASPIFlh4afS5JA8L5OXPe3AWY4BOO1eMjic6Z/kxV6Tq+W66huxkDYOjJ02boeBLlUcOqDxwAMhOQJeYJkKjc6UsCpkodoGDjdeytk458DZPR+QyFqEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAsJv/m1QwIxTRSlCZa96+cdpoyIqWyTseKbAMnbaXQ=;
 b=OYscEZuh9emaXtFR+SYTnT6wyceulhSkkSaj1+fJ/1BmPon+Oo+bVcA0i465MBvBuGfW7XmfLsMZXSZx4dFauhHET8YwZnpRdWw+0I2M0DgcovNPl7lZ6aslB2A0WZcimbG98RDHWx2tcj1gJkoLxicU1GIQylsSv1ztGZDX28g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Tue, 12 Sep
 2023 15:06:25 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%6]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 15:06:25 +0000
Message-ID: <a91e575b-c334-b0d6-a475-400ace0953a9@amd.com>
Date: Tue, 12 Sep 2023 20:36:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 3/3] Documentation/amdgpu: Modify pp_dpm_*clk details
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230904131027.912234-1-lijo.lazar@amd.com>
 <20230904131027.912234-3-lijo.lazar@amd.com>
 <CADnq5_MGGCEgSHM4-ZdFZiLX+b50P-bEC=EgB3ZrW7=Zp94GUw@mail.gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_MGGCEgSHM4-ZdFZiLX+b50P-bEC=EgB3ZrW7=Zp94GUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SA1PR12MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: b237a4d0-64d6-436b-993f-08dbb3a1d526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8XNk6HJcbckNdKVspgha0N++snhnLJAaKG3RkNBTw6fHRo/p8LyTo/zEIFnmzZmjXpXiy0f7lF3dp1Vmctnf08H5YJrvzdB32UDO007IKFOmXoS+s4PmmbOCfJaiE7AFgCcq7qQRakpvQOfRs54GkJgT3JBdwBFVyHGtofyEkVwkOJ73dm3kjM1HBvKDOoEc0BGo3iUjAvSWOeOZMkW3yZfLQoCQ2jfsycoqtrpFDD96JzQqjXAzIlWT17iViezwcU199nO9W8RrYmQzkSnr9Ye/tcYh6I9vb7tky1f3SWZOj1dm2AFrDbcogted2Fr8kRcsIg9OymxjO34NxE9yBk4csflCCYj3r2OVUP2uJvRzWlTlmwF+iRPL6SnUMDEF+jrSUCCsl1naj2HLKc6ihP8Fk81Ey16dALkKS82owU/MXLB1Wn9rcAzVIvXOmUMKzjuoAeOev81K43FV3HBG5J/Zq2xfphKmMFI05wdBVxnYTP9W8DYyhyWuYIHSdBFhljboG9FhSZf4WVmiXqOVhtLlU3mLZqKRjRQy69IBINEbsTQ1LzcfYR75uUBwyFyIvyMwAXkT6EMwY8+7s2oMri3+SXuNW6MSG5bvE1EcB17pnIFjUgOVe8281MpetcEX3Qka8I7GlTJijUdr2Gw+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(186009)(451199024)(1800799009)(6666004)(6506007)(53546011)(6486002)(6512007)(316002)(478600001)(83380400001)(26005)(2906002)(66946007)(66556008)(6916009)(66476007)(41300700001)(2616005)(4326008)(5660300002)(8936002)(8676002)(31696002)(36756003)(86362001)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0E5dW8zNFgwUllNd2tadzdiT1BDcDZPMTZlV093SWlIelY4bERjVnU3WmlJ?=
 =?utf-8?B?ZWFYVHZLOWpuamZ5TUNPOXl2TjI0a3RxUkM1TEJqZHV4L3I0VU83RHBQU21n?=
 =?utf-8?B?Tnhjak53THJjb3pDeXBQRWdCWlRCbzNGSFg5TElpMG9Td1BvcEV4bGNiTUlJ?=
 =?utf-8?B?am5hV3FlNEFGNGZYeEFLWXhIeDMrREE3YmxWenBHMWVxNUV1SGdxWGphVDRV?=
 =?utf-8?B?YzIvN0tmVzV2a1cxVkU3TTRvVzFsYmZnOUVxd21ZNVJMUFZVdXZrcjdWRUF4?=
 =?utf-8?B?SC84bEloQ1Y4L3g5amVsaHFKeGYxWk5SMmE2MW41ZHhJMmxDeFNTVEZzam1E?=
 =?utf-8?B?UWhJTUh4TFBtcENSYVZDRDcyZklQOTI5R2tTY2lZRU5qRXhtOG80WlhhcG14?=
 =?utf-8?B?ZFhmdEdTNlZTckhhZjI1Zk1RbWEwMlU0Nk4zZGczWldsYTR3STNGellDSnUv?=
 =?utf-8?B?RFJtYk9QWnBYNnJzYVJQZ2k1azRyVVk5Q1prdll5MldjVXBDU2RxWlN3Nkxn?=
 =?utf-8?B?T1o5YTZRWjFLdXB1YnVObEk0OWZYWmxFMWlpNElrQkdUNnJVbklJSXdBV3hZ?=
 =?utf-8?B?MWNGeTJvZWhjYzZtL0E4NHpEdUwxc3dJZlU0UkxFejc5cFBJRXJXZFk3djBJ?=
 =?utf-8?B?THBNQkZqcERYZC95dVYzS1cvUTZTT1FyT3R6YmRVdlRGcEhQeVVHbHhyY2tT?=
 =?utf-8?B?ZmZsaFBHRno5SFJUMU9vOEd2UzhyMFo4bVJLTVRnVjlZd0pOVyt6M0ZvQTNY?=
 =?utf-8?B?S0t2K1lZTUtVK3AvWCtLSDhUbGhvbU1jb3Y3MExUeWtEcm9sbDhEd2dDYk5Y?=
 =?utf-8?B?dnRBUzBoSTBXQ2kzd2dybUpmMXpyVG5KN3QwekZtV2EvWTNBSjN2NmJ0R0dK?=
 =?utf-8?B?Sjg5QlMvbW5DcVF0eERlY2hDbzZZcEpKMWRtekdoTkJtcU5wTlhZaDRBMW9T?=
 =?utf-8?B?U0JrZE5NZlVVQnRIT2lFd21ia0lFNTM2bWxKWnNhTnRib28vSU9nbzgwd29K?=
 =?utf-8?B?STh3d2lnNm85aHZWNzZLdnhZMjVMdlI4dWJFaFdpWEtrNEY0bjlpUlhER2o5?=
 =?utf-8?B?N2p5YWNGZkxkNDR0VmZrUW53c3E1TGgvUnBDbW93TTJCcGpqT093TEliSVl3?=
 =?utf-8?B?R2NBV2pJZjVGZzhoTytObTdYM3R6bGkvWXdSSWVhS210Nndwd2JOMzdmRHJW?=
 =?utf-8?B?MlR4YmlYL2hlTjRYeTJveGQzRTZrbENaY0xONkRHMnQveDdnNmo3RjhxV3Rz?=
 =?utf-8?B?RngwNi9mbks4Zm80cUY3WmtTY0RzYXNvY2NDY3o1UWRsRExBbUZVWlRIMUtl?=
 =?utf-8?B?dThTaXdPejI3ZEVkTDBxb1o0Y3JXR3ZiRUxTTFpIckU5bUtxb1gyb283WW1i?=
 =?utf-8?B?WnpxcFlKUjBKcW1LUnRuTHRJMzFwdXF2WFlGYW1VRWh1b3NpSXBCTjVLVVBG?=
 =?utf-8?B?WXhLWEhqcFRCaG1ocUIyVDVyU2xpWTlpbmJjeVlvZlB1blBCenRTRnlmSTJD?=
 =?utf-8?B?NjF3eVJLY2l3RzBMSVdHSDlKQWM0cjVUV3JxakRJK1ZDZEovQUxuQm5ndEN2?=
 =?utf-8?B?cS8zQjhjMXlGQzEwaFE2M0V3Y0xqYUR5M1h6L2lJY01TemRNNGJYQ0t5Wi96?=
 =?utf-8?B?c0RlMmVZK3J5V1FRaURST0d3VzkvYzdWQ3dWMzFwWmg3SndRbUhNSTVsU2xv?=
 =?utf-8?B?UXpOZEJua0FKVlFKOGhIdTZ3QXF5K2puUzF0UjR0bmxJL0hLMDFsb1YwUjhH?=
 =?utf-8?B?NmVYRnZxb29IMXpDV3RwNDhwUlN6b0x0SWEvNzh1cEhxZ0hiUE9HNGNCdXlh?=
 =?utf-8?B?cWo4RnpoQmlNd3dod01VSXo3bTZwOGxYM2xrUGh6cDRrVHBBWXBFMmh5czU5?=
 =?utf-8?B?T1daZ21FWTFJNXFzSXoxRzlFWVo3K2Rtb2NTbGdQc2g1Q2ZDSG40Q293eWtK?=
 =?utf-8?B?TXkzeG9XcW1RaVpPZHA2cEdSdXM2WXdubDBBVklRL055d2w0OGF3aGVzRmxM?=
 =?utf-8?B?dWE4SmRQeWozVmVwc2tDaE8yMnlBbm5tdkNBdGQ5YmVFdUNxZE9RQTJHaFRj?=
 =?utf-8?B?azZ1MUs1TldaOUZtRFh4WWQwcnAvWHpDZW1vbVhnU284QzJLWU5kSmxyczZZ?=
 =?utf-8?Q?tTKWHy5GmXnBNnzMX4SOq0AOG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b237a4d0-64d6-436b-993f-08dbb3a1d526
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 15:06:25.4561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0PbGaE0JaTpGA0nFH/2deGxFb9BUskZSR+7tLM5G6G5Acnp4zFJ2jCh0FqIFmgO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/5/2023 8:20 PM, Alex Deucher wrote:
> On Mon, Sep 4, 2023 at 9:20 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>
>> pp_dpm_*clk nodes also could show the frequencies when a clock is in
>> 'sleep' state. Add documentation related to that.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index 84e1af6a6ce7..3dca1aa473c8 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -983,7 +983,15 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>>    * pp_dpm_fclk interface is only available for Vega20 and later ASICs.
>>    *
>>    * Reading back the files will show you the available power levels within
>> - * the power state and the clock information for those levels.
>> + * the power state and the clock information for those levels. If deep sleep is
>> + * applied to a clock, the level will be denoted by a special level 'S:'
>> + * E.g.,
>> + *     S: 19Mhz *
>> + *     0: 615Mhz
>> + *     1: 800Mhz
>> + *     2: 888Mhz
>> + *     3: 1000Mhz
>> + *
>>    *
>>    * To manually adjust these states, first select manual using
>>    * power_dpm_force_performance_level.
> 
> Might be nice to update older asics to follow this model as well at some point.
> 

Hi Alex,

Can I go ahead with this doc update, or you want to hold till other 
ASICs support this type of reporting (with the patches, only SMU v13.0.6 
SOCs have this behavior)?

Thanks,
Lijo

> Alex
> 
>> --
>> 2.25.1
>>
