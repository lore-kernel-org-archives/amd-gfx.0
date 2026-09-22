Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9682EC982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 14:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3528710E6F9;
	Tue, 22 Sep 2026 14:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I751t5K3";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013067.outbound.protection.outlook.com
 [40.107.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 674F010E6F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 14:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oW/1zYvk34eWMVh+l5q7bVCzVoYsK/wXp8cPLKJv+F2BQzAUE/TXHpuOPe0cAs0Q75LILTDOM5XifuMIOPMjW5NNdKDO+X55meL3JODhKC6t2+F3nYBFqq/leHwG1gEoVVqM0UGr+Qs7H2OY8nrHW4WEO6mbha1R2p1ocZwwisu5c6m7ez4oKcvYlG+VDqjywfSfkKic237ByYJ7X/B4ivOMWS+f/D1L0cao2l85RMs+HJJCdh3RgAnNjVmwHpQRGg03i2UTMD3ysJc14mL8V09AgoHZ9WYk+0qlsJcs20Uhmi+xtH2AICxyJTuYrfkYBsH9Z9uuiEtjapVXwVKbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9akT1rqydoQGqnjra/Sqk4JiZRsusi8PC+Fr5io6/lY=;
 b=j8aW2LPWomdcq10+VM/5YoA4omYdbZc7pAWNGPXAR4U6AFvHw+6f8lrkB3EMQMxY+rxeBPccasISuu7a4Edoj/AGFV+QziZxrZSG191p62AX/0zMJBeeH8+XK/p2ZrzJVxiuRndRgoDYRjU1edkdhXKZWj8I8Ya3+IjPywkgTu82d+/Lq8D+wYOEstsuhBPwla9rR/5aAiT4txPcxPfyXlMIfWvMjgiVXqCeXv9QVIHvnQj8Q9CFWr8Me80InAEKhpiEsYERem5TMfnIiTCYPYWu2Sd7fophiTqkA8JVWjnRZJ4uI/EvWo2ydiyh+utPOQ8W+NeqSEEYkS9ERTt/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9akT1rqydoQGqnjra/Sqk4JiZRsusi8PC+Fr5io6/lY=;
 b=I751t5K381rD+JwAxiMFbqvMizkEfihtYbC35tkvWaZJ0tfFvolDsRf9uj1r7VeICPRUMW6Y+TUFUC21ZXXfHqy4KSfxc0iieq2UGQmjqksPashBgp625m4NdRThNaQIjum1JcprIaweeJ0F5llevemaBvNacjMvh9u0UyDW2cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by LV1PR12MB999280.namprd12.prod.outlook.com (2603:10b6:408:3f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 14:11:33 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0406.007; Tue, 22 Sep 2026
 14:11:32 +0000
Message-ID: <c9cd0934-25ca-4d14-99c1-cc7aa3d566c8@amd.com>
Date: Tue, 22 Sep 2026 10:11:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] drm/amdgpu: add amdgpu_xcp_get_xcc_mask helper
To: "Lazar, Lijo" <lijo.lazar@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, Bing.Ma@amd.com
References: <20260921200313.865829-1-James.Zhu@amd.com>
 <20260921200313.865829-4-James.Zhu@amd.com>
 <8f06398f-e207-45b0-ab85-931ccac35b65@amd.com>
 <ce3dbd30-31e6-4680-8618-2144fe44a928@amd.com>
 <0e573608-7f9e-4f3e-ac58-cf375962ae2b@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <0e573608-7f9e-4f3e-ac58-cf375962ae2b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::25) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|LV1PR12MB999280:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ca439f-34d1-4f13-0c94-08df18b3671b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|3023799007|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: OTdr+nxRxMpb/hY6q5XXqqbBOs89vRTJO55DaDuECTHiinWtd1jpXYXS0sOaGn2Y/R7X6xuyYCCTdC0zZw1SNhFU2htrgctMBJOBuwTre7poH217G0vHmiDVSqmIn8z2dH3Ww9HAewILc15/pe8Mx8yaj0u06tsnBr0qRBb93wvvlLe9FOWEG2nIb50Pu6zA3OzkV6d6B1beEe7P+WGg2QLMFo4m8Lt6GBGufXTJ1h5Hc7Xil7RlT6h0X/DiX/ZS3SKzSuVgsnsXYPw9W9YboNcOxrLNqOnO82GiI3v3S7kZV07CaXuQOTukqgMsMyFYBcOKHGTe3Iz9FCwX5e0XOev8re0jaD2IvwJ8/0A6rQ8Ukqv1gHRLlWA8qEdnOJpAMr7AdsF2tsiI9kFMLBZsOPdcAkQhuuBuBy/saqSbAmzIpUTtH1qGbDiiPO//kinaJVOfAPtRlXtfHZpBYVR2wjfAPI6aAIMxElbxmrz6SYtLFHjQv3vZ+9XtutbjWMvAixRBisLLTqv2wOwwjpGwSQRz1fUpMOFxLUqc6Y6gZ/P9jjpbVyRMP0ok2hDFAyv/ZQ2fH0KC+hT3EcfrOE1PVbkGS0F9Sja7np3u/O9vpHgYfC5s8IQF0bJupyKdwcS9rP7/BJYU7oxSjsx2vFESrEf6bxCUO6SfLdOKZItxBdg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(11063799006)(10067099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0kyQS9DeWFsVnBoOWZpS2RudmpqdnBYelhUeGFuckFvSHNHaE9HRGlJYWYy?=
 =?utf-8?B?MHBBUFgzb3BYV2QyMXpxL2VTdU1wVXdVelUzUW1ianFqMHErRTJkNTJKaUNM?=
 =?utf-8?B?SHkxUVlXZ2lVZFp1YkkvMEJGWmZ0T3NhOTJaSll0N1I3Z0RzNGc5bTNFK25R?=
 =?utf-8?B?Q1FqSUx6bG1DUTBsYUxQR21YSVRmd3pWQkx0aUlsZVFFVDR6UUFsZjMrRGo3?=
 =?utf-8?B?dUt3RlZpUzl1VXNydGc1UkFZQWg1cXBWcjUzU3RsQm5qbkJGNkxhWGVpMUln?=
 =?utf-8?B?bDZoV09aWUlJWENJOXJpQWY4Y1FoR2pJaGVSUU8wVzhERnJLRXpFa3ZaQXRm?=
 =?utf-8?B?eGJFTW54bzBtSlZabFRjaFVWaS9Vc1J0NDhGaVJRSmhNUTJMc2owOTdONlhj?=
 =?utf-8?B?REJ1MFJkSWlpOEdPZHV1K0pWWkhtUElKUXN4bDJXT2dyWnVsZVhlYVFtako1?=
 =?utf-8?B?S2ZsakQxNmlXeW5BQjdwb2tmYlNJMDBUUkRBc3g1YVdrV1l6WVpIUXhGYzdu?=
 =?utf-8?B?REM1clZzUkhoNUV6aDBqVUo1Qk5LaFlDU3dXbnpQOEI1SEk0VlZZSEIyazZ3?=
 =?utf-8?B?ZDQ3TDZBY00vSXFIamxHREpGd0JMcHM5UmtoZGcrQ3JKRzg5QktCYVJwUUZx?=
 =?utf-8?B?Ynl1U3g5cm9sL3p3TjFzUUxWZEFaSTdoOGEvanNzSEVReDdtUUw1b2FIbFpt?=
 =?utf-8?B?U3cxRW5CN3h4VldXY0FKMysyWXZhenB1eGNQOHpCcmQ2U2M4QlIvTXZxSm5O?=
 =?utf-8?B?U2dUa0ViYlFnWEdkRWlkTzNJUElrNnAvSGF2YzNqeEF4RXAzSjA2UWlCTHUr?=
 =?utf-8?B?UXNQY0xURzJxRG1yaERZOWRLYld1bXBDeXdkb0l2TU8wODh4OFBJK1BIa2tR?=
 =?utf-8?B?c0poeGVyb2ZZV250a3M5bDFGN2cza3lQS2hjUHpkT3ZrRGpQbWVLN3ZPY29r?=
 =?utf-8?B?RUt5U0hrTi8vTXp3aktJN0NMeDdjeURNMU1pcmRWSFhMcFF2allwcEx3cWto?=
 =?utf-8?B?QzVxZTQvT0RyNUxKUVRtNUFUU212VEdBN1RleWF3eTNFVXNob1N3UFhUZHYz?=
 =?utf-8?B?b2NheHYxc25LSkE3b3N6aG5kWjlvV3pJU3RaZlREYThqc1h6Q2xUZVpnRWNS?=
 =?utf-8?B?T3RsREtJWEg0a1FieXkvVmFKRFNNZ21PV0E2MDBwcDJiVTNuU0h2V3poNEJl?=
 =?utf-8?B?UTNtSk8vanZhL3dqOVA1eGdpQkI4U0ZEOXU0NlByejY5cEpTeWhzVVIvUWFl?=
 =?utf-8?B?YktWMVJ3SGNNdTllRGw3YTlsMytzVlhlSUx3cGdqMm0zVkhubnNkV1dXZ2s1?=
 =?utf-8?B?cDUyR3RCZksxNFluRzBkK1RUREh6NkdaNEpETUJ1S1FmSStyY3pOazVBVVpw?=
 =?utf-8?B?UUwwTldNVVNBUjVqOU1NNVhjQ1k1MUhaajBjYVZwOUpUeGxBalQ1M3EwSlgx?=
 =?utf-8?B?dUhEb1VyMzFidEYyYnBkNDA5Ri9xYU82ejlFMnl3MExidTlTd3ZacWFFWGlm?=
 =?utf-8?B?emhvd2JjblhWYUo4RTZxUzBDM2Z6Qkt2RUtwajVXV0JmcktEUUZ6M1VSbm1N?=
 =?utf-8?B?UU1UMXVNdFlaOTUzUjZ4Z2Y2U2R2S3c1TnY5emVkWGFqVUI3MlNKTUFsUDVy?=
 =?utf-8?B?UFU1ZlloNVVXellDalJSQ0FuMlllMCtydHA4Zld3NHMvRXdQNkk3Ni85Q0ty?=
 =?utf-8?B?Y0dKL2RRMWlBbmFSZ3NGOWszdlV6QTZzZFRSa3pobVhkUzlrVnkvcEFTVFp6?=
 =?utf-8?B?ajltSnVZQlh2dldNaEMwSkliMnNSMENMVVZQZ3NxM0w5ZUs3cG8ySzNXOFN5?=
 =?utf-8?B?R1dYMlRUQjNvUHhzMTZ5NnMzSUVrTGZxQS92ZEZaaHVGbHYxUUtpaERCWTFt?=
 =?utf-8?B?MXdZL1ZZN0I5Tzh3SnhabUVUVDB0VVdLeVVlV0t1YWRFYldlNVZYM0lCSEc3?=
 =?utf-8?B?UXRzT29sNGE0ZkcvSzVNQnRQZ1k3Vk55MzdsUHUzLy8wenNxTkZPbkVLb3FE?=
 =?utf-8?B?dXVheVV6SjBON1pCWnJ5N1RkZ0tFWWo0TzJydU1NaDRiWm14QlAxQlphVmpN?=
 =?utf-8?B?cHllSmVLMmM2eUpmQXBrSGtYRGRGd2tPaHQ3TVJ5TzBHYUp6ekxPTGJKQzNy?=
 =?utf-8?B?SjVtU0FPdEZDWGl5QktGTUtWWFVNeDc2RjJVUTFvM3lmYWZXMHhEa0YzMk0w?=
 =?utf-8?B?S2NFNG4rd1JWZjFGM2RtUHpwS1lVbmxLU28vZzZZVEt6ZnAzM09PQ2pvQnpz?=
 =?utf-8?B?WXZTMEtIZWZFeitNT1JpUU80UlJuUG9OR0IrSi82dys0ZXlHRkY0SDQ0UHRL?=
 =?utf-8?Q?HG3G0JMxgVkAexRE62?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ca439f-34d1-4f13-0c94-08df18b3671b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:11:32.0004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txmlzFG0btUYcuglRci47WHU4oGnrnq3UtaS1GPIbtfcnn1A1WONQ/SkTi+bu7jL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999280
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


On 2026-09-22 09:45, Lazar, Lijo wrote:
>
>
> On 22-Sep-26 7:05 PM, James Zhu wrote:
>>
>> On 2026-09-22 01:22, Lazar, Lijo wrote:
>>>
>>>
>>> On 22-Sep-26 1:33 AM, James Zhu wrote:
>>>> Add amdgpu_xcp_get_xcc_mask() to return the XCC instance mask for a 
>>>> given
>>>> XCP partition. This is needed by upcoming SPM (Stream Performance 
>>>> Monitor)
>>>> support, which programs hardware per partition and must operate 
>>>> only on
>>>> the XCCs that belong to a given XCP.
>>>>
>>>> For partitioned systems the helper returns only the XCCs belonging 
>>>> to the
>>>> specified XCP. When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the 
>>>> device is
>>>> not partitioned) it returns the device's full XCC mask (e.g. 0xFF 
>>>> for an
>>>> 8-XCC device). Note that the full device mask is returned even on a
>>>> partitioned device; callers that require partition isolation (e.g. 
>>>> SPM)
>>>> must reject AMDGPU_XCP_NO_PARTITION on a partitioned device 
>>>> themselves.
>>>>
>>>
>>> Could you clarifiy on this part - xcp_id = AMDGPU_XCP_NO_PARTITION 
>>> usage on 8-XCC device?
>>>
>>> The default state on a multi-XCC device after driver load is all 
>>> XCCs in a single partition called SPX. It should have at least one 
>>> partition valid.
>>
>> [JZ] Yes, 8-XCC device should not reach AMDGPU_XCP_NO_PARTITION case.
>>
>> the if(!xcp_mgr ||xcp_id ==AMDGPU_XCP_NO_PARTITION) mainly covers non 
>> partition device, I can remove the above comments which don't reflect 
>> the source accurately.
>
> Then I'm not sure what issue this is fixing.
>
> Multi-xcc devices will be in SPX mode and will return a mask with all 
> the XCCs. Non-multi xcc devices are expected to have this set to 1 
> anyway to reflect that a single GC is present always.
[JZ] Just realized a Fixes tag is added. I think somehow AI review added 
it, and I did not check properly, is should be removed also. Sorry for 
this confusing!
>
> Thanks,
> Lijo
>
>>> Thanks,
>>> Lioj
>>>
>>>> amdgpu_xcp_get_num_xcc() is reworked to take (adev, xcp_id) and 
>>>> derive the
>>>> count from this helper via hweight32(). The helper is defined out 
>>>> of line
>>>> in amdgpu_xcp.c so that the static inline in amdgpu_xcp.h never has to
>>>> dereference the (incomplete) struct amdgpu_device; it only passes the
>>>> pointer through.
>>>>
>>>> This is a user-visible change: amdgpu_xcp_get_num_xcc() previously
>>>> returned 1 for non-partitioned systems (and for 
>>>> AMDGPU_XCP_NO_PARTITION),
>>>> and now returns the actual XCC count (e.g. 8 for an 8-XCC device). 
>>>> CWSR
>>>> callers (amdgpu_kms.c, amdgpu_userq.c, mes_userqueue.c) scale the 
>>>> per-XCC
>>>> control-stack and debug-memory sizes by num_xcc, so the uAPI-visible
>>>> ctl_stack_size and dbg_mem_size values grow accordingly to match the
>>>> actual hardware resource requirements, which were previously 
>>>> undersized.
>>>>
>>>> Fixes: 4cd417bfec49 ("drm/amdgpu: Add helper function to get xcc 
>>>> count")
>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>> Reviewed-by: Bing Ma <bing.ma@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 48 
>>>> ++++++++++++++++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    | 32 +++++++--------
>>>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  3 +-
>>>>   5 files changed, 66 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/ 
>>>> drm/amd/amdgpu/amdgpu_kms.c
>>>> index 57fa69c0382d..7782ccd4d28f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> @@ -1501,7 +1501,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, 
>>>> void *data, struct drm_file *filp)
>>>>           fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
>>>>           if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
>>>>               return -EOPNOTSUPP;
>>>> -        num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, 
>>>> fpriv->xcp_id);
>>>> +        num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>           cwsr_info.ctl_stack_size =
>>>>               adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
>>>>           cwsr_info.dbg_mem_size =
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c 
>>>> b/drivers/gpu/ drm/amd/amdgpu/amdgpu_userq.c
>>>> index db09e879b85e..d19af9cb6ee1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> @@ -258,7 +258,7 @@ int 
>>>> amdgpu_userq_input_trap_params_validate(struct 
>>>> amdgpu_usermode_queue *queue,
>>>>       int num_xcc;
>>>>       int r;
>>>>   -    num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
>>>> +    num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>       r = amdgpu_trap_validate_params(queue->userq_mgr->adev, 
>>>> trap_params,
>>>>                       num_xcc);
>>>>       if (r)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/ 
>>>> drm/amd/amdgpu/amdgpu_xcp.c
>>>> index 2a56f5ec9c76..90846d55292b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>> @@ -390,6 +390,54 @@ int amdgpu_xcp_get_inst_details(struct 
>>>> amdgpu_xcp *xcp,
>>>>       return 0;
>>>>   }
>>>>   +/**
>>>> + * amdgpu_xcp_get_xcc_mask - Get XCC instance mask for a partition
>>>> + * @adev: amdgpu device pointer
>>>> + * @xcp_id: XCP partition ID
>>>> + * @xcc_mask: output parameter for XCC instance mask
>>>> + *
>>>> + * Returns the XCC instance mask for the specified XCP partition.
>>>> + * For partitioned systems, returns only the XCCs belonging to 
>>>> this XCP.
>>>> + *
>>>> + * When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the device is not
>>>> + * partitioned), the device's full XCC mask is returned (e.g. 0xFF 
>>>> for an
>>>> + * 8-XCC device). Note that the full device mask is returned even 
>>>> on a
>>>> + * partitioned device: callers that require partition isolation 
>>>> (e.g. SPM)
>>>> + * must reject AMDGPU_XCP_NO_PARTITION on a partitioned device 
>>>> themselves.
>>>> + *
>>>> + * Note: On error, xcc_mask is undefined. Callers must check 
>>>> return code
>>>> + * and only read xcc_mask when return == 0.
>>>> + *
>>>> + * Return: 0 on success (non-partitioned systems or valid XCP found),
>>>> + *         -EINVAL if xcc_mask is NULL, no matching XCP id is 
>>>> found, or the
>>>> + *         partition's GFX IP details are unavailable
>>>> + */
>>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
>>>> +                uint32_t *xcc_mask)
>>>> +{
>>>> +    struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>>>> +    struct amdgpu_xcp *xcp;
>>>> +    int i;
>>>> +
>>>> +    if (!xcc_mask)
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION) {
>>>> +        /* Non-partitioned: return the device's full XCC mask. */
>>>> +        *xcc_mask = adev->gfx.xcc_mask;
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    /* Partitioned system: get this XCP's XCCs */
>>>> +    for_each_xcp(xcp_mgr, xcp, i) {
>>>> +        if (xcp->id == xcp_id)
>>>> +            return amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
>>>> +                               xcc_mask);
>>>> +    }
>>>> +
>>>> +    return -EINVAL;
>>>> +}
>>>> +
>>>>   int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>>>>               const struct pci_device_id *ent)
>>>>   {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/ 
>>>> drm/amd/amdgpu/amdgpu_xcp.h
>>>> index 692508be23fb..6eed82ad49b1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>>> @@ -44,6 +44,7 @@
>>>>   #define XCP_INST_MASK(num_inst, xcp_id)        \
>>>>       (num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0)
>>>>   +struct amdgpu_device;
>>>>   struct amdgpu_fpriv;
>>>>     enum AMDGPU_XCP_IP_BLOCK {
>>>> @@ -219,26 +220,23 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr 
>>>> *xcp_mgr, int *from)
>>>>       for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
>>>>            ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
>>>>   -static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_xcp_mgr 
>>>> *xcp_mgr,
>>>> -                     int xcp_id)
>>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
>>>> +                uint32_t *xcc_mask);
>>>> +
>>>> +static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_device 
>>>> *adev, int xcp_id)
>>>>   {
>>>> -    struct amdgpu_xcp *xcp;
>>>>       uint32_t xcc_mask;
>>>> -    int i, r;
>>>> -
>>>> -    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
>>>> +    int r, count;
>>>> +
>>>> +    /* Derive the XCC count from the partition's XCC mask (or the 
>>>> full
>>>> +     * device mask when not partitioned). amdgpu_xcp_get_xcc_mask()
>>>> +     * handles both partitioned and non-partitioned cases.
>>>> +     */
>>>> +    r = amdgpu_xcp_get_xcc_mask(adev, xcp_id, &xcc_mask);
>>>> +    if (unlikely(r))
>>>>           return 1;
>>>> -    for_each_xcp(xcp_mgr, xcp, i) {
>>>> -        if (xcp->id == xcp_id) {
>>>> -            r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
>>>> -                            &xcc_mask);
>>>> -            if (unlikely(r))
>>>> -                return 1;
>>>> -            else
>>>> -                return hweight32(xcc_mask);
>>>> -        }
>>>> -    }
>>>>   -    return 1;
>>>> +    count = hweight32(xcc_mask);
>>>> +    return count ? count : 1;
>>>>   }
>>>>   #endif
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/ 
>>>> gpu/drm/amd/amdgpu/mes_userqueue.c
>>>> index 16aa22b25098..1c7b2f3227e5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>> @@ -503,8 +503,7 @@ static int mes_userq_mqd_create(struct 
>>>> amdgpu_usermode_queue *queue,
>>>>                   uq_mgr_to_fpriv(queue->userq_mgr);
>>>>               int num_xcc;
>>>>   -            num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
>>>> -                             fpriv->xcp_id);
>>>> +            num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>               trap_params.ctx_save_area_address =
>>>>                   compute_mqd->ctx_save_area_va;
>>>>               trap_params.cwsr_sz = compute_mqd->ctx_save_area_size;
>>>
>
