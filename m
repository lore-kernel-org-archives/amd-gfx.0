Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1D7C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 15:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 218E810E0A7;
	Mon, 20 Jun 2022 15:32:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E36310E0A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 15:32:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMw/yWTkSe4PTzNP/KsUkJVcdHCXPGtLr6zfhgMV4PMQmEzX+miDmICKsGhUeHgit6+tCsnx0tXx/57CXuJ+8RohnCviD+LzZBGRc/9NR23mpR8a/T0FJcxn/UPeEsFlfMC2Rnk+z1+nV6AGCJe0VG6HY+oaX7I6X/oqzJY1GlOkis3il5nkV9fTZoJ/OXd0+HqqT/y7bm8pR3sigYGIB+Ymp8IFy3oIW2+GKk8GBCxu35Fz8BKLKwfD5qW7Y6G/13JTX75gqOQsc2+xiSrlER04YIbcMuCe1cJ9HykSacjT1Y8D0sVqxs7NB7TxgqOe/3eeUeGSmgQfEeOXDVt7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFH5jOApmXndHWmx/j3Mj5lcFxFVZGCZaRmNClkhm8A=;
 b=OMJqh+wf8A9ZoZV5+mjdjTLb6rOyXt/IipAomZJGGD4M13WBuoB5dDmvZbrFUZHxQO/v5ewmpF4eyVuxM2fxMCooeBW+LEPIsbNkLtgY4d63w+0GhTaEp2vQeVxk2oCZr5Y87stBoCciS35UJjo4ZiWdcOx+wmWDBr7Tt2rJAAe/EqcC8+l3Kc0lZtki1OW3e9a0+V1ihB4myAZHOuGFcbMxLzqSpHuvcGwztrj71OhYs20nhEYNiF1TI0pidMfmGkzMQK/qnln4Cd2IuF9R7/FqVgwnwujEKlULSeq4ijjRwGyrC8xjYZkqsRltqaZ55bYgoijVBFdl383sOYssVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFH5jOApmXndHWmx/j3Mj5lcFxFVZGCZaRmNClkhm8A=;
 b=H9VDX3WHunynSYJu+5eST4I+e4oos39ZS9dDmc8xEimYsKw4HbcFwLFWG3tIVCASZHEuGdyXcdoRECPDboFLS4qabY3rcttUvQLzPONNPGlFqVX6cD3CaKx3Hu88z1R6+uRlGCFzhrBTq81giXSG1RpiwLjFPHen4XaVTbwcGAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by MWHPR1201MB0047.namprd12.prod.outlook.com (2603:10b6:301:54::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Mon, 20 Jun
 2022 15:32:44 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::85a:3075:1744:8317]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::85a:3075:1744:8317%7]) with mapi id 15.20.5353.020; Mon, 20 Jun 2022
 15:32:44 +0000
Message-ID: <b194ebb6-8437-a5f2-fe97-e9cef74f7188@amd.com>
Date: Mon, 20 Jun 2022 11:32:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 16/31] drm/amd/display: refactor function
 transmitter_to_phy_id
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
 <20220617193512.3471076-17-Rodrigo.Siqueira@amd.com>
 <YqzbVxByDw1xSdXb@dev-arch.thelio-3990X>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <YqzbVxByDw1xSdXb@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0070.namprd19.prod.outlook.com
 (2603:10b6:208:19b::47) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f9f47a4-0a85-4024-16da-08da52d21ebb
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0047:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0047D124B72DFB702607AEDD98B09@MWHPR1201MB0047.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8M4ueTwEKlTucP3fPP0c3FdFajTSLvIMn8sS/3ekjif5Z/j7niW4/epPyL8M7ip0koQoc539XBqFZbvNjMTbqgSup8Qa8zj7Hup/USw5u6KeS0vHLgYiuTqPUqAqO888PAzj5Zq9iu6nyQ+Vf/t1hm9mVdRl2/aUKIKAHZmP9AEY3BFjEWrpq5JAgl7sEk4zPpt9MARUV6Ox6J69nvH8rGJMhCLZGaw+oJdvI3uz5cSXBhu1DlfskZyY4bhI3AZ7H7csxaGh4Vp5z9r+Js64GWeSyNF1XbI89uLRhlBkUfLXTI8E73+cR8v6jYwhOVDj0Cge2IQZ61QK7eTP0MSUdCF2Kvq20plnj7CvHsggV7R15S76sMeHD2EnZyGcELa6K4RtC8xXV8mLs0WwIdgxGwMqxinpTlJgQqCKhp1h7+pBjoGRpIwUShNJqEobZ/1cqzLvMOzG4DWZsASuAuuBK29pZUSsoQXa3DXOqSLf4YXRmH4HCQi9DKvHevqnH8c9AHy84BA8+/A0viOi+sLXaJzBW9wO4K78f/9QgqaRelXlAmyercX+e7Cd/QkQQkukEVMw8GmzC/q/FgLMXF0bfxWviAZEF8/lGXqzLuqpCV8FwK37JpKdy1ZlmZ6UUqn/gH54RS0+F0w77Rvy8JsXAIq4VblSHOxra1mh+A30GgBYtVQqk5o4k75TI+SWXL1CaRD3tIz4PsU/7VbDU4M1vuTppfGcyi4MSTMsAN/nrY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(2616005)(186003)(41300700001)(86362001)(8676002)(26005)(6506007)(83380400001)(6512007)(53546011)(2906002)(36756003)(6666004)(54906003)(6916009)(316002)(8936002)(38100700002)(66946007)(66476007)(4326008)(5660300002)(478600001)(6486002)(31696002)(66556008)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmowUEdOVmM4cElRb1NwR2NHUVBOalp1cS9XVzZaRUoweHE2QlQweTdNTlhs?=
 =?utf-8?B?RThrUG5DSnRTOHBETS9NOSs3M1RGd3FpcElUdVV5VmdheFZnTTY4QWlxQmhE?=
 =?utf-8?B?VG4rSHhSZ1FJRENtZm16OGFiRjNmdXVDZ0I0MzNEZlM2Ly9sN2RLWFZ3bkNJ?=
 =?utf-8?B?cE1jRnl4dTZ4QjdrQVFFNW84UVR6MXphSXo0NllRaDNTQUNaZnUwWko5cW5U?=
 =?utf-8?B?c0N3ejByRkgrSWJteExlWklyTHlIUFFvV2tuR0d4MGYzbFVUQkNTcG1MaWhN?=
 =?utf-8?B?eXpDamIyRE8rM3lZTUVOK01GdHlCZnp0b0NFem1UVTNLTlJiMnNqdzcwRG55?=
 =?utf-8?B?SUVUK2VRVU1GSFR0Z3RRSGZSSml5ZW43b2pHQnh1akszay9CT3RZRG5jblFQ?=
 =?utf-8?B?OFQvaWNhUkg0dHBwRzcyeFFiU0g4enh4SUxScXJ5Y3d3ZDZsa3Rtb2tDKzNW?=
 =?utf-8?B?S3Fvejh0Sk1PRzRpUkd3Q2dZZ3VoNGVqVStpWDJMbERxL1ZwTGFFVEdWUUNH?=
 =?utf-8?B?Sko3eXROMnRncm1LWHduYXlMbDloTHZaQjNiaVhjZDBXYTJuMkp6L3h1eUNv?=
 =?utf-8?B?Y3FwSTljdmkrVm9HM0NpR043Y25uSjNkOWNzYnl2MHhnQTZkWWRTYThqSXF3?=
 =?utf-8?B?dkZ4SnNENFpwb0Q1QlNsa2pxYk16dzhZdVlTUXlLYjA0NHg5RktPKzFJTHNa?=
 =?utf-8?B?SFJvQWY3eVRSMHk0ZVpZOTBzWXVVcU9EUHZxc3VkdGJZQSs5Q3lTS1Jibmhy?=
 =?utf-8?B?QXgxbytXaEQ0QXNoUW9zNCtoMEdnQjM4QzI1Qm5jcHYyMDZoR244UCs4bGVC?=
 =?utf-8?B?RzBVaHQ4a2kxdVUvWGpZSSs4TnNsQjBrZGFtdVl1c0ExMmplQ1JmWWlNVVNo?=
 =?utf-8?B?aEN2MFpudkY4N1JSNkh6OTZLbnBpTzhnd2lWTURGUDA5T1ZPT0tTUmtRYzZY?=
 =?utf-8?B?YVVjV04rTEtMOEVVOTkxcnEvVTU5ZG1nNUhFK05FUHlodlltUUZLeThpNElv?=
 =?utf-8?B?Z0lRYkZKYXNEcmFHVW1SSEhUZ01tdnNRc1JmZDdlL3Yrb25iZ3pZQ3NQT3FC?=
 =?utf-8?B?d3FxaU53K0tGbU9uTUVPaEpjeUswYkdDaXVML0lsSnZCK2hoM2N2Y1BXWDRW?=
 =?utf-8?B?SVc2M1REWDNjWU4xT09ab3ZDVEFEa2VoNDl4S2ZVTUVCOGMrNGo4OHhxbUov?=
 =?utf-8?B?b1h5Mk1zOEd4amlFcTRZOFFMdjNFOHlrTlc4cXRQaVpwdjZZZkJrNXhUZXZ6?=
 =?utf-8?B?NUcyZ2JlclgzTVJpaFNFbUg2dlZsMWs1bEptWldNMU5nRmxSNEF5dGJaVmRH?=
 =?utf-8?B?TmJIajZhdjFYNUxDYW1sZW1najZZeEtYOWxESGZqNFNKRmdWTjYzbCt5ZTI4?=
 =?utf-8?B?enkyTElpUTFsMFNQY2d5YldxNUI0eU1wL09lNVhlTlprVnBiQ01ndWpzWitw?=
 =?utf-8?B?Z2RmYVJjNHFLOGpseHhYT0RRbGx3N25yR3IxQTAyL1FLbFlhZURjSmFWbzdT?=
 =?utf-8?B?d3gzYnVCUkdYL1ljdG96cFg2UXh1T280SXRBZkJvb1pWWGRTNElYRmFSS01I?=
 =?utf-8?B?V2xYbXNHakVSMXhwM0ZUOTk2L0s3TVZJdDFXaHdmZE8xdzQ2bkFPSHcxM2hB?=
 =?utf-8?B?RER1QWpOZmJHYkxOMDloblVNNmRjaTNaRUR6bTYrNUpLRSt6QldWZFJ2am5E?=
 =?utf-8?B?ZEQ1WnpzWlJINDJPbGw3bFUxUFpDTXRUakRtdnFYUk9VdCtFNmVqbHFlbVRW?=
 =?utf-8?B?QWF4WkVvRFlJOStiRE9BTXdEMXJ2YWczU052NTIzVmJrWWNQNHYyVjZPZ0I1?=
 =?utf-8?B?R3BWTlE4OXB6eWNIUXp5YVRRcTlmRE1DZ1JwNVlqNVVxanB2eWMwLzAxalZ0?=
 =?utf-8?B?VlNqRmFOZFRVd0hMRXJ2Q0xqbkVDRmlxcVlyVFVyRHNOTXJBdUJ4UjB3dDhN?=
 =?utf-8?B?c1A3Sk5lRk84ZXhyQ0ZvWHZpc0sybTZjcCs4ZVZzRVQrbCtNUU1Xc1EzZXVo?=
 =?utf-8?B?U1RLSnNrQ3BuR1lHYmdDN2VPY3lyTGl2Z21OQ1Erb2tnWmpiQVltYzZzSGx6?=
 =?utf-8?B?QUZuM2hVVzI1KytSNkw0QmI0U1AzSU9RZWUzUVMwSHRycjMrQkJvc05abjNF?=
 =?utf-8?B?NVpUSTNSREY1UHZoaWFENjNyejlGdUNYY1RUSlc4Ri84cUtkYjhxSWhUVy8r?=
 =?utf-8?B?OGlFcWszSFRYUFVPYStNMEwxVlZiNEcxUXlmWk16T2p6UWI3Skx4Nm9FMjhJ?=
 =?utf-8?B?eDE0Qjd4dlQzQXg2eFRNaDBqS056NnFxL1d5cTJuaW5ERVR3bFE0Ylp0VkdD?=
 =?utf-8?B?emhGQjlLMDkzQXNiam9UdDBmV2Ntdit5SmM5WnJ4cnRZMHNPTzREdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9f47a4-0a85-4024-16da-08da52d21ebb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 15:32:44.1033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DTBatLbvZsC69b//c6CLMGB3QpaTH2gUJZg/pdOPid4O7duLXgb95K9n8I2Ef4qt4g4y7f1QCqjOW2EVmwUOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0047
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
Cc: Chao-kai Wang <Stylon.Wang@amd.com>, Alan Liu <HaoPing.Liu@amd.com>,
 Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com,
 roman.li@amd.com, amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 Nicholas Choi <Nicholas.Choi@amd.com>, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 Nathan Chancellor <natechancellor@gmail.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-17 15:51, Nathan Chancellor wrote:
> Hi Rodrigo,
> 
> On Fri, Jun 17, 2022 at 03:34:57PM -0400, Rodrigo Siqueira wrote:
>> From: Nicholas Choi <Nicholas.Choi@amd.com>
>>
>> [Why & How]
>> Since we only need transmitter value in function transmitter_to_phy_id().
>> Replace argument struct dc_link with enum transmitter.
>>
>> Reviewed-by: Chao-kai Wang <Stylon.Wang@amd.com>
>> Acked-by: Alan Liu <HaoPing.Liu@amd.com>
>> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> How did I end up in the signoff chain for a patch I have never seen up
> until this point? That should definitely be cleaned up.
> 
> Additionally, this commit message doesn't really seem to line up with
> the change. It says that "struct dc_link" is being replaced with "enum
> transmitter", when it is really the reverse, and that only the
> transmitter value is needed, which is already the case, right? I guess
> this is so that you can use DC_ERROR(), which requires a dc_ctx
> variable? It is not immediately obvious from the commit message so that
> should be clarified as well.

Hi Nathan,

Thanks for reporting this error; it looks like our scripts have some 
issues. I'll take a look at that.

About this patch, I'll drop it.

Thanks
Siqueira

> Cheers,
> Nathan
> 
>> ---
>>   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
>> index 43b55bc6e2db..58882d42eff5 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
>> @@ -3185,8 +3185,11 @@ bool dc_link_get_psr_state(const struct dc_link *link, enum dc_psr_state *state)
>>   }
>>   
>>   static inline enum physical_phy_id
>> -transmitter_to_phy_id(enum transmitter transmitter_value)
>> +transmitter_to_phy_id(struct dc_link *link)
>>   {
>> +	struct dc_context *dc_ctx = link->ctx;
>> +	enum transmitter transmitter_value = link->link_enc->transmitter;
>> +
>>   	switch (transmitter_value) {
>>   	case TRANSMITTER_UNIPHY_A:
>>   		return PHYLD_0;
>> @@ -3213,8 +3216,7 @@ transmitter_to_phy_id(enum transmitter transmitter_value)
>>   	case TRANSMITTER_UNKNOWN:
>>   		return PHYLD_UNKNOWN;
>>   	default:
>> -		WARN_ONCE(1, "Unknown transmitter value %d\n",
>> -			  transmitter_value);
>> +		DC_ERROR("Unknown transmitter value %d\n", transmitter_value);
>>   		return PHYLD_UNKNOWN;
>>   	}
>>   }
>> @@ -3331,7 +3333,7 @@ bool dc_link_setup_psr(struct dc_link *link,
>>   	psr_context->phyType = PHY_TYPE_UNIPHY;
>>   	/*PhyId is associated with the transmitter id*/
>>   	psr_context->smuPhyId =
>> -		transmitter_to_phy_id(link->link_enc->transmitter);
>> +		transmitter_to_phy_id(link);
>>   
>>   	psr_context->crtcTimingVerticalTotal = stream->timing.v_total;
>>   	psr_context->vsync_rate_hz = div64_u64(div64_u64((stream->
>> -- 
>> 2.25.1
>>
>>

