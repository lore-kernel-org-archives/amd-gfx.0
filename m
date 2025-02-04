Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED82C02193
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 15:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19B7210E6B1;
	Tue,  4 Feb 2025 15:58:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IzCk6c/R";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D390410E6AD
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 15:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCaL0HfzxN63da7x0FAqhEl4Jxj8LGQzHv3iUaL1iM7QQM6UxhO6Hq+2N0YwrApy5CfaggMpQdEiT8h2V++eCYW1Y3kS0mdCqbrQEu2CfDVatxhgR8cKnB0bN/qYHo3Zg5tecz2z0B559OaiO8/1eLugzKLI2+z2PcAit/yCw75tR6exH96bySJGdlnKWbp/HCQAetIoO8jLW2V/gvSaCes/b9M37ShOjwVCCpSlCXFgyVlyWpeDEbu8KGxSfnJhwLp6eUV8khbq/NwQAPMDPWy5K+t744Umthq3V/es8aI2xR2CqjXoo08Zt6RK2bq6Ke9D0u8eLHhkEpcLChtvSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GauNvDXHadoNewPgCXM67ypgPYaVdabrcRiGbN2uGk=;
 b=Xjw9AaU+YvgJQiU4GHgtoY2tv8DUvJDSef4pl9XHmqsu1oQS6EXR2fy/tsy8UN8HMYglNTJIvaNm/aHTQYUEWZurU4pkXs48ykoVmgOvaooaxuXvP2s6ZMtd7N3t9TKJA1iqZz1oZYaH29ewcUyLenX9BdgoYfddFbPaGuK/qXL6j3Zu5Mg7MdzDXLMJHynzzEYIYZXEPn1xa9PJ3YQ2cvJGpvpXSAqXLZ8OIcFrKk/qCzZf28otuq/NcwEo+v/vs3+wP3IMQBdxAkV+JffzavsR0RdqqQRTAZLq0qLHEPfzs32dx2MiFyew0cWtoyaQdi7zTiWNkLkf/X4JcBe+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GauNvDXHadoNewPgCXM67ypgPYaVdabrcRiGbN2uGk=;
 b=IzCk6c/RUVWrUj6DP8WHATK0CWYNumPyBRIjGz9pGwOBwyFNvXILx3RyHCxk5bn9azEHy+gA+5bSfSMO0H8Fl+klgmG+FLbHREtg5whQIJzbbY4+4g8UWYETy87ZNWqw3SVLGHLu1tTiZ0AXQL0kYhXuBqHSTtNsx+3FR+7QeTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by LV3PR12MB9266.namprd12.prod.outlook.com (2603:10b6:408:21b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 15:57:14 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 15:57:14 +0000
Content-Type: multipart/alternative;
 boundary="------------QNvNAvIhwgd1hbD2IfZozzn3"
Message-ID: <e231c2f9-3abd-4126-9ddc-24604a920cb5@amd.com>
Date: Tue, 4 Feb 2025 10:57:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/44] drm/amdgpu/vcn5.0.1: split code along instances
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-8-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-8-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::38)
 To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|LV3PR12MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: 192a5e93-fdda-4d06-799f-08dd453497aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWdEQi80NFk0U040TnF4Y2xWOWlvbDVaRWgvcWpHVTU4d08zQVgwODlZTEs4?=
 =?utf-8?B?Y01MWWJ5d0JMa2hPQ1M3cjlndy9acS9pOFhXRys5SzgzWGJPZ3R1VkZTMlM3?=
 =?utf-8?B?Rjh3WHNvNHVhSjc1NnJDMDcvNEFmeHdPajNXVWdCcTMvdjlDaGNGcXo3SjdC?=
 =?utf-8?B?SUlUMzd2NzU3V1JFRzc5MzdSeVUzOVlJNDRLdW9JM0ZXVTA4OXBTSmRlZnZn?=
 =?utf-8?B?ZXRvanhkQ1ZiaGVXYUp0WUk4OVFEd2pMNEJFaXpIWjRwNThxNUcyQ0hUaE5C?=
 =?utf-8?B?cUFOUGY3TUYrMW4vZDMxMGh1cFdPYUUvNTBzSkhVNUYrb1JnWU9LbnIxMWtm?=
 =?utf-8?B?NWh1ZFpDNEdmRVg5V2xSSGVaNTF1bG0rMW1XdHRINnI5WVVYeDdmZHNxZWZF?=
 =?utf-8?B?RUpFQVZEY3BGSHh5QXh1Uy92OGg5dXMvVElPL2V4S2ZrWnc2Y2p3ZGpSNWhr?=
 =?utf-8?B?QytvZkFmTGFsSUdITVR2NjM0SEpyeFZWTUorZWEvTWJsYkdaMnBHenRhNFlF?=
 =?utf-8?B?TWJEZXF6VzhLeFIyWmVlZmZjOEZzZEU1azNRMk5Tcm5oaWd5QzNRNWhQamo4?=
 =?utf-8?B?OUFkNjZHTHFoVUptd0ZhS1hxZ20vRmxmNjFXU2NFZHZJMFlwSUoxUGlMUno1?=
 =?utf-8?B?OWtLbUFjbU56R250R1FKcW14Z2dWNEEvUEhNRzVadEloNWlnWmFWRmIzdmRM?=
 =?utf-8?B?WGxkYzZzSEVJMnM0cnB3dk5yQ1NwMUJPcXNUeVlxMWRkSktFdU1nTTdLanNK?=
 =?utf-8?B?YVJoNk1NSHhBSHFEaFMzRjhzcFpWdGwzdUxuYjRvSU5lV3FNWFVYc0E0TDRH?=
 =?utf-8?B?UkFtNXRhd2VtQThjUUNaeTgxSzdnbUlLbWRpOFhiM0pqdkQzVlp6SzlkU0I5?=
 =?utf-8?B?RGV0L1RSRm9lMWFJa3hmWUxiWHRCOHZwd0VNc3ByNEk4aXdFanJSWitlbktr?=
 =?utf-8?B?VTBRdUtLSzMwR1psYVFabjNBYi9RWEl6aGRMaFUrYktmVGkvNGE2ZXhwME5Z?=
 =?utf-8?B?U2NRYWRoR3daTWFlTDJiYjRuZmo5WW5SeTF5V0p2Q0RtNEhDVWUvUzc0L3V6?=
 =?utf-8?B?QzRMSmoyenFQR3JqQ0lSSTQ1SU5kUm5wRXF5UWVmdEVMQUhadTJ1R05hU2dF?=
 =?utf-8?B?WWx4SkZFbWErR25GZDlDUlVIQjJmbG1FcWFuV0VJQlJsMWlPSEdiSmlDM1Nr?=
 =?utf-8?B?bmpFWnZ3V2RCN3J6d2E1V1g5ZGtxYkNUYTc4SmFjUEtMQUYvaDBFckZMRm84?=
 =?utf-8?B?b1FFZjVzSG8rRHFFZzRxM2FtbEU5U01kMlNiOFVTMXFVb2dRMGNXdjhKTmh6?=
 =?utf-8?B?U3U3ZkdCb05SSlNlOENkZUdrY29Fc0U5NFcxdkQ5NU8xYXNCcm9QZmZNNW5z?=
 =?utf-8?B?MCtLd3ordkVGNldSemVYcHY1dUVHejVVOEJabWZ5bE53V1hwbm5Fc0NENlFY?=
 =?utf-8?B?MEIwWUtKWHEyM0lSU2d2QXhONHAyTHpEUUJ5RWllK210aVlVNzFjOTJVdDVQ?=
 =?utf-8?B?T2RxKzJpMWRmZ0pKSTd5S21EUG1WUlZnYldqa2lZbTdyRWFkRkdNOGovekd5?=
 =?utf-8?B?WnRmREdBbWZyeG42T2xLc2EwRFBWUEhyMzRZNFlXY285RDZPYkRyM3ZtNXNq?=
 =?utf-8?B?V2VjTzkzUklWN3F0WHBOcUNubzZUYkRWdDVrOHQ1NURKa0I0OC9uVEVNYlcv?=
 =?utf-8?B?NGpRNTJ4OTZCc1dlS09ob2VoRGdtR0JmMmVycnU2QVZwQzU2SmNwbWdaV3Ra?=
 =?utf-8?B?bWl3ZlpOekc2bE9XMmoxK3FYNWQ1aXYyR0hKSXNkTWF5RkcrWkdoWXJtSXFO?=
 =?utf-8?B?R3BwNkYvWE5MZEhGeXVndC96QmliZzJZOVZibWlETmhNNXJMZnh6azJxN2Yx?=
 =?utf-8?Q?Q1SKVt6H1C1ji?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anEybHJ6NStlR3o1eXNndTBLTGpHYjFYdDNaTG5pSlZQWjlQRjJTb3hqcHV3?=
 =?utf-8?B?MEtKWkcyYzRINWgzRnl4WnpKQ1ZTWjR5eFRXSnhNYXZNV0RSL3Jpb09xenYv?=
 =?utf-8?B?OGRPTzcvTDVsVzg2a1p2NTQ0NzhhVkpTTE0rWWY1NXZ0dnR6czYwYUpWRFZr?=
 =?utf-8?B?Mmk3RXpid2xkTjZDSjY1VFM0MzQ0Tzk4QSs1dVQ2eEh3aGp5MTVFbnN6WVQw?=
 =?utf-8?B?bWZxNnoxUFBJbW1zMm1Ib1dxUkdna3pBak9YL0c3OHdXY0lJYkZtOUo5aDR2?=
 =?utf-8?B?M3BXdjNFelpRSTJEUWZReFRCZjU2Sk4xZWJGbTJjbktPVlhFY3IrR1RPamQ2?=
 =?utf-8?B?TjRsM1I4alBWTUJtSC92dkl2aFpTOEVuOUgvWlZZb015WVYvdHlhQWhPWmt5?=
 =?utf-8?B?bHY1WUxONENkcjE2Szlqbk8va0pYRlNiUFVlSGp3QXptRURSSEtpdVl2M2FY?=
 =?utf-8?B?SWpHcFdmVytyYnBVRk54Z2ZUdEpUQlhLN0JUWTlZdmk0d3BCcDJYTDZPa05P?=
 =?utf-8?B?WDI4NGtMQzFwcTNCUlU0U1lvYXNaOTRZNE1BSUtjenlhVllIVTFnM2lwV1Qx?=
 =?utf-8?B?b2dSWnFVbURCZnN5c0tsQkt5VzZBeHU1c0J2N3lyZEtNTGx4eExyNEU2aGVa?=
 =?utf-8?B?d0xPZzd2WmlTaThSL3ZVeUVXS2pEcHhhbzc5WWZEb25hZE5NTDc4L0pOYUF3?=
 =?utf-8?B?cmdBRHlIc25oc3Q4UWlZUERSUGJLOHNpdUtwNStQOE1qbXpZY3l4ZUR2bklY?=
 =?utf-8?B?eWlab3RuVHBIR2RpRmIxMmgvMjlmUG1vOHg2cGpWK3phUmx5dGl4cG9UazBC?=
 =?utf-8?B?SVFBa21JWGZTZU51aDlCQ0hlSnR1UDRZVzFVbFJxZUl6VjRTbWFBaUttVTFn?=
 =?utf-8?B?MlcyWUJUZG1QNXJlM2lwRlJoelE5WUlhTk0yWnlLVWpFbW53MlA2dTJlZm5Q?=
 =?utf-8?B?MFlhSkU2eEY1VVU0dlcxWFA1WXBZVU50U3Nmbzh2QTUwNlRpRlFlNmRQNlRB?=
 =?utf-8?B?VW5BaG1TUG41emttN0pFTlp1NE1LT1loYmdLYWNSRW4xS3hUaisySVBIYzNv?=
 =?utf-8?B?K0ZQb0RIMnlIVE1rYzhvZDBGRVI5cERjc2pSVERzZ3dzYlYyMWZYU29Tbzcv?=
 =?utf-8?B?R1phQmJGd1MwYXRLWmRiZ2JhTll2KzVMUHcxZVJibDVWbnpHZWRWY296SGhi?=
 =?utf-8?B?UWdrMTc3MVdGdDMyb3RPN2FsVHNxYjc0ZERtd1JoUTlCYlRzeGJXWWFML3dU?=
 =?utf-8?B?NSt0aFZ2OFhtVE1nWTA5YnhIc1ovYWZpSEJhVTU1b1M4YzA1eDlyK2Q1VUR5?=
 =?utf-8?B?SnJKeDhmSThmOG9MdzRUdVFhTU0wS3BjSW5acnNmNjNNNDhxM0xVOW9vbmNx?=
 =?utf-8?B?VjFTWXZkY2Z0anh1WkdwS283VlBvbG5UdmxpWkRKcyszNmZIOW5leFBzMW5U?=
 =?utf-8?B?MDZCQnZiQTQyc3J0bGxGQjdJaGhjUFJIRTlEN1N0TE9hd0JxYldyWTYxYzZm?=
 =?utf-8?B?UlFWcUVvTXQ5cmhzcUJVSjg5Smw3aURmM0hKVEFCODc4L2ExZGlPTUhvckhl?=
 =?utf-8?B?enZGK1dNUFZqZmNSYnJUdFdzcndtaTFxNmFrRWV4c2VPYkRRVFVkT25pMFRC?=
 =?utf-8?B?OExwTlRYNDM2enp2MCtjTHc5T2hXNWlqQTBMYXp4aG11V1IzbWtrVGFNZS9F?=
 =?utf-8?B?aFpMT1VpNVBvWHljZkNycXpGbGk2cUVFV2lLd1BFMnloWUpONVN2aWJCV1NP?=
 =?utf-8?B?K0xaRjRVOXA1aXcvcVJCWEdQYVE3dVc0akE3ZTlCR3d1TlVGbjVKT0ZTMXZJ?=
 =?utf-8?B?c2dUTENDeWxnYzRqMTdsZmp2ZWVGcWZLUVhjd0FzT1FOMDdFWWhtNytoc3Ru?=
 =?utf-8?B?eEV5VDFobTVUamI1U2ZKUEM1aml2YTczOWdPMTBjVVd6QVFZdFlEWVhNeGda?=
 =?utf-8?B?anNHdkJvdXNJcmk3K0lLR0FlOE9ubE9wWHZZMWI0L3puMlpQVFlVU1h1WXpv?=
 =?utf-8?B?RDA0Um1NQlZWTHlnbWZpbEsvVkJQSEJoSnBsM3RXWk9iKytxb3BDaEU0c3d0?=
 =?utf-8?B?eWZmWnVlblYvR2d3ZG9IaHJ3OVlzc0I1MUErblJjYlRhR2N6ZlZIaVJNMUZH?=
 =?utf-8?Q?JFtC8pPrulGnZ3QWgL3+Vn0Uq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192a5e93-fdda-4d06-799f-08dd453497aa
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 15:57:14.3069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zO3uvZsQfTwzLXhAV6UAVONo1MhnenDxYFmThow+3an1McVesx/XMWtAeuoJ42HyazdftD1GW849mjmICrwYbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9266
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

--------------QNvNAvIhwgd1hbD2IfZozzn3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Split the code on a per instance basis.  This will allow
> us to use the per instance functions in the future to
> handle more things per instance.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 352 ++++++++++++------------
>   1 file changed, 174 insertions(+), 178 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 8b463c977d08f..25abb303d6698 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -568,149 +568,145 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>    *
>    * Start VCN block
>    */
> -static int vcn_v5_0_1_start(struct amdgpu_device *adev)
> +static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
>   {
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t tmp;
> -	int i, j, k, r, vcn_inst;
> +	int j, k, r, vcn_inst;
>   
>   	if (adev->pm.dpm_enabled)
>   		amdgpu_dpm_enable_uvd(adev, true);
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			r = vcn_v5_0_1_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> -			continue;
> -		}
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +		return vcn_v5_0_1_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
>   
> -		vcn_inst = GET_INST(VCN, i);
> +	vcn_inst = GET_INST(VCN, i);
>   
> -		/* set VCN status busy */
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
> -
> -		/* enable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> -
> -		/* disable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
> -			~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -		/* enable LMI MC and UMC channels */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
> -			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> -
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> -		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> -
> -		/* setup regUVD_LMI_CTRL */
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL, tmp |
> -			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> -			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> -
> -		vcn_v5_0_1_mc_resume(adev, i);
> -
> -		/* VCN global tiling registers */
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
> -			adev->gfx.config.gb_addr_config);
> -
> -		/* unblock VCPU register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> -
> -		/* release VCPU reset to boot */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -		for (j = 0; j < 10; ++j) {
> -			uint32_t status;
> -
> -			for (k = 0; k < 100; ++k) {
> -				status = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
> -				if (status & 2)
> -					break;
> -				mdelay(100);
> -				if (amdgpu_emu_mode == 1)
> -					msleep(20);
> -			}
> +	/* set VCN status busy */
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
> +
> +	/* enable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
> +		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> +
> +	/* disable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
> +		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
> +
> +	/* enable LMI MC and UMC channels */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
> +		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> +
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> +	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> +
> +	/* setup regUVD_LMI_CTRL */
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL, tmp |
> +		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> +		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> +
> +	vcn_v5_0_1_mc_resume(adev, i);
> +
> +	/* VCN global tiling registers */
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
> +		     adev->gfx.config.gb_addr_config);
> +
> +	/* unblock VCPU register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
> +		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +	/* release VCPU reset to boot */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
> +		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +	for (j = 0; j < 10; ++j) {
> +		uint32_t status;
> +
> +		for (k = 0; k < 100; ++k) {
> +			status = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
> +			if (status & 2)
> +				break;
> +			mdelay(100);
> +			if (amdgpu_emu_mode == 1)
> +				msleep(20);
> +		}
>   
> -			if (amdgpu_emu_mode == 1) {
> -				r = -1;
> -				if (status & 2) {
> -					r = 0;
> -					break;
> -				}
> -			} else {
> +		if (amdgpu_emu_mode == 1) {
> +			r = -1;
> +			if (status & 2) {
>   				r = 0;
> -				if (status & 2)
> -					break;
> -
> -				dev_err(adev->dev,
> -				    "VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
> -				WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
> -							UVD_VCPU_CNTL__BLK_RST_MASK,
> -							~UVD_VCPU_CNTL__BLK_RST_MASK);
> -				mdelay(10);
> -				WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
> -							~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -				mdelay(10);
> -				r = -1;
> +				break;
>   			}
> +		} else {
> +			r = 0;
> +			if (status & 2)
> +				break;
> +
> +			dev_err(adev->dev,
> +				"VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
> +			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
> +				 UVD_VCPU_CNTL__BLK_RST_MASK,
> +				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +			mdelay(10);
> +			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
> +				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +			mdelay(10);
> +			r = -1;
>   		}
> +	}
>   
> -		if (r) {
> -			dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
> -			return r;
> -		}
> +	if (r) {
> +		dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
> +		return r;
> +	}
>   
> -		/* enable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
> -				UVD_MASTINT_EN__VCPU_EN_MASK,
> -				~UVD_MASTINT_EN__VCPU_EN_MASK);
> +	/* enable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
> +		 UVD_MASTINT_EN__VCPU_EN_MASK,
> +		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
>   
> -		/* clear the busy bit of VCN_STATUS */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
> -			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +	/* clear the busy bit of VCN_STATUS */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
> +		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>   
> -		ring = &adev->vcn.inst[i].ring_enc[0];
> +	ring = &adev->vcn.inst[i].ring_enc[0];
>   
> -		WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
> -			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> -			VCN_RB1_DB_CTRL__EN_MASK);
> +	WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
> +		     ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> +		     VCN_RB1_DB_CTRL__EN_MASK);
>   
> -		/* Read DB_CTRL to flush the write DB_CTRL command. */
> -		RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
> +	/* Read DB_CTRL to flush the write DB_CTRL command. */
> +	RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
>   
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO, ring->gpu_addr);
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE, ring->ring_size / 4);
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO, ring->gpu_addr);
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE, ring->ring_size / 4);
>   
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
> -		tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
> -		WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
> -		fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
> +	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
> +	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
> +	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
>   
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR);
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, tmp);
> -		ring->wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR);
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, tmp);
> +	ring->wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
>   
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
> -		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
> -		WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
> -		fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
> -	}
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
> +	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
> +	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
> +	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
>   
>   	return 0;
>   }
> @@ -750,71 +746,69 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>    *
>    * Stop VCN block
>    */
> -static int vcn_v5_0_1_stop(struct amdgpu_device *adev)
> +static int vcn_v5_0_1_stop(struct amdgpu_device *adev, int i)
>   {
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	uint32_t tmp;
> -	int i, r = 0, vcn_inst;
> +	int r = 0, vcn_inst;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		vcn_inst = GET_INST(VCN, i);
> +	vcn_inst = GET_INST(VCN, i);
>   
> -		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
> +	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>   
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			vcn_v5_0_1_stop_dpg_mode(adev, i);
> -			continue;
> -		}
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +		vcn_v5_0_1_stop_dpg_mode(adev, i);
> +		return 0;
> +	}
>   
> -		/* wait for vcn idle */
> -		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> -		if (r)
> -			return r;
> +	/* wait for vcn idle */
> +	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> +	if (r)
> +		return r;
>   
> -		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -		      UVD_LMI_STATUS__READ_CLEAN_MASK |
> -		      UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -		      UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp, tmp);
> -		if (r)
> -			return r;
> +	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__READ_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp, tmp);
> +	if (r)
> +		return r;
>   
> -		/* disable LMI UMC channel */
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
> -		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
> -		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> -		      UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp, tmp);
> -		if (r)
> -			return r;
> +	/* disable LMI UMC channel */
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
> +	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
> +	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> +		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp, tmp);
> +	if (r)
> +		return r;
>   
> -		/* block VCPU register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
> -			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> -
> -		/* reset VCPU */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__BLK_RST_MASK,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -		/* disable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
> -			~(UVD_VCPU_CNTL__CLK_EN_MASK));
> -
> -		/* apply soft reset */
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> -		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> -		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> -		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> -
> -		/* clear status */
> -		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
> -	}
> +	/* block VCPU register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
> +		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +	/* reset VCPU */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
> +		 UVD_VCPU_CNTL__BLK_RST_MASK,
> +		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +	/* disable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
> +		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +
> +	/* apply soft reset */
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> +	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> +	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> +	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> +
> +	/* clear status */
> +	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
>   
>   	if (adev->pm.dpm_enabled)
>   		amdgpu_dpm_enable_uvd(adev, false);
> @@ -1010,15 +1004,17 @@ static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					    enum amd_powergating_state state)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int ret;
> +	int ret = 0, i;
>   
>   	if (state == adev->vcn.cur_state)
>   		return 0;
>   
> -	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v5_0_1_stop(adev);
> -	else
> -		ret = vcn_v5_0_1_start(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (state == AMD_PG_STATE_GATE)
> +			ret = vcn_v5_0_1_stop(adev, i);
> +		else
> +			ret = vcn_v5_0_1_start(adev, i);
> +	}
>   
>   	if (!ret)
>   		adev->vcn.cur_state = state;
--------------QNvNAvIhwgd1hbD2IfZozzn3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-8-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Split the code on a per instance basis.  This will allow
us to use the per instance functions in the future to
handle more things per instance.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="mark1tk8wrane" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-8-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 352 ++++++++++++------------
 1 file changed, 174 insertions(+), 178 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 8b463c977d08f..25abb303d6698 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -568,149 +568,145 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
  *
  * Start VCN block
  */
-static int vcn_v5_0_1_start(struct amdgpu_device *adev)
+static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
-	int i, j, k, r, vcn_inst;
+	int j, k, r, vcn_inst;
 
 	if (adev-&gt;pm.dpm_enabled)
 		amdgpu_dpm_enable_uvd(adev, true);
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
 
-		if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v5_0_1_start_dpg_mode(adev, i, adev-&gt;vcn.indirect_sram);
-			continue;
-		}
+	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v5_0_1_start_dpg_mode(adev, i, adev-&gt;vcn.indirect_sram);
 
-		vcn_inst = GET_INST(VCN, i);
+	vcn_inst = GET_INST(VCN, i);
 
-		/* set VCN status busy */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
-
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
-			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
-
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
-		tmp &amp;= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		tmp &amp;= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
-
-		/* setup regUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL, tmp |
-			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
-			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		vcn_v5_0_1_mc_resume(adev, i);
-
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
-			adev-&gt;gfx.config.gb_addr_config);
-
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-		for (j = 0; j &lt; 10; ++j) {
-			uint32_t status;
-
-			for (k = 0; k &lt; 100; ++k) {
-				status = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
-				if (status &amp; 2)
-					break;
-				mdelay(100);
-				if (amdgpu_emu_mode == 1)
-					msleep(20);
-			}
+	/* set VCN status busy */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
+
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
+
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
+		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp &amp;= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	tmp &amp;= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+
+	/* setup regUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL, tmp |
+		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	vcn_v5_0_1_mc_resume(adev, i);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
+		     adev-&gt;gfx.config.gb_addr_config);
+
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (j = 0; j &lt; 10; ++j) {
+		uint32_t status;
+
+		for (k = 0; k &lt; 100; ++k) {
+			status = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+			if (status &amp; 2)
+				break;
+			mdelay(100);
+			if (amdgpu_emu_mode == 1)
+				msleep(20);
+		}
 
-			if (amdgpu_emu_mode == 1) {
-				r = -1;
-				if (status &amp; 2) {
-					r = 0;
-					break;
-				}
-			} else {
+		if (amdgpu_emu_mode == 1) {
+			r = -1;
+			if (status &amp; 2) {
 				r = 0;
-				if (status &amp; 2)
-					break;
-
-				dev_err(adev-&gt;dev,
-				    &quot;VCN[%d] is not responding, trying to reset the VCPU!!!\n&quot;, i);
-				WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
-							UVD_VCPU_CNTL__BLK_RST_MASK,
-							~UVD_VCPU_CNTL__BLK_RST_MASK);
-				mdelay(10);
-				WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
-							~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-				mdelay(10);
-				r = -1;
+				break;
 			}
+		} else {
+			r = 0;
+			if (status &amp; 2)
+				break;
+
+			dev_err(adev-&gt;dev,
+				&quot;VCN[%d] is not responding, trying to reset the VCPU!!!\n&quot;, i);
+			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+				 UVD_VCPU_CNTL__BLK_RST_MASK,
+				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+			mdelay(10);
+			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
+				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+			mdelay(10);
+			r = -1;
 		}
+	}
 
-		if (r) {
-			dev_err(adev-&gt;dev, &quot;VCN[%d] is not responding, giving up!!!\n&quot;, i);
-			return r;
-		}
+	if (r) {
+		dev_err(adev-&gt;dev, &quot;VCN[%d] is not responding, giving up!!!\n&quot;, i);
+		return r;
+	}
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
-				UVD_MASTINT_EN__VCPU_EN_MASK,
-				~UVD_MASTINT_EN__VCPU_EN_MASK);
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
+		 UVD_MASTINT_EN__VCPU_EN_MASK,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
-			~(2 &lt;&lt; UVD_STATUS__VCPU_REPORT__SHIFT));
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
+		 ~(2 &lt;&lt; UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		ring = &amp;adev-&gt;vcn.inst[i].ring_enc[0];
+	ring = &amp;adev-&gt;vcn.inst[i].ring_enc[0];
 
-		WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
-			ring-&gt;doorbell_index &lt;&lt; VCN_RB1_DB_CTRL__OFFSET__SHIFT |
-			VCN_RB1_DB_CTRL__EN_MASK);
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
+		     ring-&gt;doorbell_index &lt;&lt; VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+		     VCN_RB1_DB_CTRL__EN_MASK);
 
-		/* Read DB_CTRL to flush the write DB_CTRL command. */
-		RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
+	/* Read DB_CTRL to flush the write DB_CTRL command. */
+	RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
 
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO, ring-&gt;gpu_addr);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI, upper_32_bits(ring-&gt;gpu_addr));
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE, ring-&gt;ring_size / 4);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO, ring-&gt;gpu_addr);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI, upper_32_bits(ring-&gt;gpu_addr));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE, ring-&gt;ring_size / 4);
 
-		tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
-		tmp &amp;= ~(VCN_RB_ENABLE__RB1_EN_MASK);
-		WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
-		fw_shared-&gt;sq.queue_mode |= FW_QUEUE_RING_RESET;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp &amp;= ~(VCN_RB_ENABLE__RB1_EN_MASK);
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	fw_shared-&gt;sq.queue_mode |= FW_QUEUE_RING_RESET;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
 
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, tmp);
-		ring-&gt;wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, tmp);
+	ring-&gt;wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
 
-		tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
-		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
-		fw_shared-&gt;sq.queue_mode &amp;= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
-	}
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	fw_shared-&gt;sq.queue_mode &amp;= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
 	return 0;
 }
@@ -750,71 +746,69 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  *
  * Stop VCN block
  */
-static int vcn_v5_0_1_stop(struct amdgpu_device *adev)
+static int vcn_v5_0_1_stop(struct amdgpu_device *adev, int i)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	uint32_t tmp;
-	int i, r = 0, vcn_inst;
+	int r = 0, vcn_inst;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		vcn_inst = GET_INST(VCN, i);
+	vcn_inst = GET_INST(VCN, i);
 
-		fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared-&gt;sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
+	fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared-&gt;sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
-		if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-			vcn_v5_0_1_stop_dpg_mode(adev, i);
-			continue;
-		}
+	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
+		vcn_v5_0_1_stop_dpg_mode(adev, i);
+		return 0;
+	}
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
-		if (r)
-			return r;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
 
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-		      UVD_LMI_STATUS__READ_CLEAN_MASK |
-		      UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-		      UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* disable LMI UMC channel */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
-		      UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	/* disable LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
-			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__BLK_RST_MASK,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
-			~(UVD_VCPU_CNTL__CLK_EN_MASK));
-
-		/* apply soft reset */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
-
-		/* clear status */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
-	}
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
+		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__BLK_RST_MASK,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
+		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
+
+	/* apply soft reset */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+
+	/* clear status */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
 
 	if (adev-&gt;pm.dpm_enabled)
 		amdgpu_dpm_enable_uvd(adev, false);
@@ -1010,15 +1004,17 @@ static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int ret;
+	int ret = 0, i;
 
 	if (state == adev-&gt;vcn.cur_state)
 		return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v5_0_1_stop(adev);
-	else
-		ret = vcn_v5_0_1_start(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		if (state == AMD_PG_STATE_GATE)
+			ret = vcn_v5_0_1_stop(adev, i);
+		else
+			ret = vcn_v5_0_1_start(adev, i);
+	}
 
 	if (!ret)
 		adev-&gt;vcn.cur_state = state;
</pre>
    </blockquote>
  </body>
</html>

--------------QNvNAvIhwgd1hbD2IfZozzn3--
