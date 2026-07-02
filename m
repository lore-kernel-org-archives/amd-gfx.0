Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE0BC43327
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 12:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F6F610F343;
	Thu,  2 Jul 2026 12:30:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ak4c/x3W";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010033.outbound.protection.outlook.com
 [40.93.198.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E99D10F34A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 12:30:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBmUmiUrfR0hu0n8YLxlVyFjriuyBW4tWhM37t17xs2/XwCnhSCTUUDBifMMswPiEbCKqFPr1Hz/9OI9C7y142CXRtxHZWwZ/wV5LmhPR5qGEuirUJFv34zvhPpfYUjidDVAhvQG4OFzLhHh5fYLp6SUqW5wUi/zo8HXKV/x/gXnWKXqqRiK+Di423fsimhmBQxCPvcSFqjR1NRldAI+NJjKQSGChNUIf4Vn3h7NDAIWlvHSpsnhsiFkVXkLqU9eQo8ta42HmrYDBStNLG2xulcIaVVVtMkTmHCyY4Ue79TFy8SvEwgUvXHykawyhRQEHnXm3eEvIt9geIysjGNKww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqpCxK7M2t25m8kd2n1RkVX5RipcGpNBE5PThKM4Ans=;
 b=WSM9ozKQNkXC3Dg2SEBL93Od5LJOkEd/toYihaJhGh9vmpeq91SWjmYcoT15TSQMyBDQLQwPyZCz6pNVyMuVhH53/3X1rJT8kVBV7dND8cBcmSx9977iq34R9eH4NG+KHLQ5V1mwOIYTI+78m96K1uzfV9l0ItpuEY962vdmT6oldElfEiotd58ifsMq+3yGnsrrh2HAMKR9HUAzcwtPwCTv1ZaYcUAm6NeZ3rmxgA35vxbjEgdFVDqhVESFNsjPwzzyRcS31QZb2ubzCocZAmfq0BwglMZrlEZTLYVyiFR3PFpuAVy8YBpk+ZtEY62v1b24dP9qRjpPDG4Z12VjGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqpCxK7M2t25m8kd2n1RkVX5RipcGpNBE5PThKM4Ans=;
 b=Ak4c/x3WH//nnsiFFA3s3TlLLjXnTzvjiAmZXx0woWXfAzTVuVGRakxt3NjLspe69Gd9utHgtXl7oz2oCvGXsimwgPeNolkKiD9qKft4R9Bud/F9Jvkwp37Ey87UZaf8RGvtgrva33SErM+Z9Z/S5cNtxg4nRfPk/wo8JLQss24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7132.namprd12.prod.outlook.com (2603:10b6:806:2a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 12:30:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 12:30:26 +0000
Message-ID: <15459d84-24fd-404c-b90f-97d2ecfb7af8@amd.com>
Date: Thu, 2 Jul 2026 14:30:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] drm/amdgpu/ih7.0: Enable retry CAM on Navi 4 dGPUs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-15-timur.kristof@gmail.com>
 <dee4f6f3-0494-40e6-94d9-e0249633d0bc@amd.com> <5873192.ZASKD2KPVS@timur-max>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <5873192.ZASKD2KPVS@timur-max>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7c49b2-8d3a-4fed-badc-08ded835b1a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003|921020;
X-Microsoft-Antispam-Message-Info: +VqaXcQz9LhdlzBKdoa/4SxSd1YcJ/sDdzMS7clQlM2hNwxWNs6atdznQehj4l4AcinnrFuHdZ8WKl6LKqCVvrThgL6oxkXZfhNhumt9+Y9IaHvoKJW/tETq8O/ol484uU9l0pkWrtWL/xolTyVy/9z+b9VsPg7ZsfT9PIVsfaAmDct/Fhht2dmL8cLYEtK1dL/9EMIs25TxUIUMw+TI5q73AT6+z7cqidRUS5oWta3paWMDoZlxsQ9Jt8jbzrmXlmkycSrAIQwixdm3DPlBJ8n7VDRXk1yrS+UA7azUXSd15BILXpoT75Q5AbEw/p1kLBGPd2HD9g/OiWIDJPYP/KASERwWvtEUZoh7dBXnm17veh6XB4wJG6vmo2G2qctMv8MKcIjpZ6G42ZB9Ug9UNRWqgyjJvRdwD2CJnZoNc13xJaT8qZqIPPXcAdFIRVNgL3FUj88X4Dfsuq2CesCViqFxgHyEzR8Dd3ieh6l49qCDTCM88aYgOsWB1CLpMp9aWrCqwFP6hhMbRft1nFljafC2R3SNRARFbzLUM+77K3u6lN1cLrXpwJ1z9H+cifcX6ULOipIdS1xXid48cal7VVH6rwg5hp8WZXHVdZtfrRw3Cii/yPekZ+fTQjnpDJ6lB3RrnGnJ8USt8oS3eXioHTIdh7qwwi307LBaLqWL3cAjZ4nklSLc3LUUYdW8Kif6anIl9BN+mr4bt7a9CIZzWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkkwVXpLVE5Yd1VsSWJXNHMvVVRKUitEK1pnaTh0eHpBaXBya09ZL3VKc2l4?=
 =?utf-8?B?ZXJHRDNnU3c5VmpSWmhSWkl4TW1ZNlh0aTYxOCtVZFFKR3htaDJMQkVtdi9o?=
 =?utf-8?B?dFMzZUN4Q01MT3Y0UXJLckgzbUNjUCt4ajh4OWp3VXV6bytZRDhJdnQyMHlO?=
 =?utf-8?B?UWkyeHFxa2dUSEJ3SmlzcnV4aUtoV09SY0RtWEhabWJtZTFYSFZaeFpVM2tC?=
 =?utf-8?B?YXhSVElhNHRJbXFqMktsejZ0UitIWWhpeStWWTVldk1DT2h6SEJpOEp4aW1Y?=
 =?utf-8?B?RjhzVDk4S3laUStyZHA3cHpNUzY4b3NRVW84MUlpMlhKeDROZURGb1dKVjht?=
 =?utf-8?B?djNKVEtvRXhYQ01JT0FPN2JmQy9WRm9NUDVSQk12eXYxeEw2Qm5NcStwMVZh?=
 =?utf-8?B?VnB3RWgwT0pCSTdIUmJnbDEzYzFwMVBqRHVLR0gwY2ZBRkp6VzBXWHhLSldV?=
 =?utf-8?B?VmIwWnVCRUtEUHB2T3pXdEJyeGdOcjIwejd1Ni9DeWdGRGtXTW9NdzdGZHlt?=
 =?utf-8?B?WnlPOTV3TjE3bzJjOEF1OEhMYjNHN1I1MFFtRXpHL3JsNSszeUJneVdIU1E2?=
 =?utf-8?B?RlpydTFoSWRJTXQ1a0ZlaWlSeUpMMWNkQWFvUHlLT2UyRWU2d0YzejFmZXY0?=
 =?utf-8?B?TzZjc2pocENLZUFLUWpzMzdqR2FWdy9oVnk5MnpwRVI2bUhRVS9MKzFsaHJS?=
 =?utf-8?B?ZDZzYTcyZEpjUUxoRnN5ZWZMSFJNSSs5NWF2SG9mWFhkZzJZVHFLNGtiRjhN?=
 =?utf-8?B?MmtsUlpjOFduU3dCa3NqdUx4RTRxNDN5UzlvL3JwdzZrRi9ld3U1S0Jkck1G?=
 =?utf-8?B?cUF3bXZ6WUltVXp0VWl2clJPWWgvNFNobzFDeFY3R2U0N3FObG1KQWtnbTRi?=
 =?utf-8?B?MXc0bEtLWlBTSEtVZFQzZHc5anpTYzlBRU1PTTdKMTdDa1R2ZXZlbC92cXFG?=
 =?utf-8?B?SEZUNkFuckIvNXpkSk9OUlZiZWw4V2ZtSStVbXRKVTNzVkl2RlpFUXZYaXND?=
 =?utf-8?B?VlpGK0RNaDhjaUpBQmc3d21CektXd1BSM3RIWG5ibnpHdC9KTmM0U2ZxVzVi?=
 =?utf-8?B?MkEwU3lXamhmSWpONkVua3M2V3NBK2Z1bGJ3elA5ZVpSZzBMbmdzU01jN0Ry?=
 =?utf-8?B?WTFaaDdIMVJyUU5QTHFDZzZuTTROU2ZPRzVsam1TSm5aYW5UeEdhb0JmckZs?=
 =?utf-8?B?UDVsM1RvZC9vdkJBY3JtVkt2UCs2dWNNSWdVczhqdmxBa09tMGg3LzhHbWVB?=
 =?utf-8?B?VTNEaVhFaUJrb2ozSkgvalRNbHA0bTFhRStJQUhGWDlOcXEvaHU0SWR1NDZW?=
 =?utf-8?B?dTZ4QjZtWlpXRUhOcXhCSkh1bTFPU1IwckRPTFQ1aDlJekp5KzhMSHVadnRx?=
 =?utf-8?B?bmtTSkNFUXpPdGFJcXlGYk5xQTdvcXV6ZTRhb3JHZzJNczhEdkMyNHpneUZT?=
 =?utf-8?B?QkRKY3pHMk8xVTlUUmhsYUdiajVOWGFhdDZoM3RGbjYzZ2YxK2dHQ3poZndM?=
 =?utf-8?B?RTZKeDhaVS9VVzFyd0g2ajIzUGJtcStESHMreVFpRlNYcEJlVTh4d2JLMkhW?=
 =?utf-8?B?YkU3Z1BHMXlxNzM3VldpZmpRR253c2dXRy9qSzlxOGlPbmlLbC9XcldCMHpC?=
 =?utf-8?B?anJRS0YwVnlZRlViNnNRODN2OVRpSFZDNjk5aDhDRERQbmRyVVRWYkFmMEI3?=
 =?utf-8?B?M1k3a1EzbnhFWXlJeGJwRkdqbmdUSHMxYkU2dktYRGJFeitoR0hYTkxkRWp5?=
 =?utf-8?B?amRYZ3JYR2pKbXZheGI4cDFuMDAwaGI2ZHk2dEJoanh4UFhLVkQ3M2VpYmlW?=
 =?utf-8?B?Q2ZxbTlpRGdLdUdTWGMxbzJhaHN0WWNKcGRueTFEZWNPNVRKbWdwU1ZEUHpt?=
 =?utf-8?B?ZjJJMlgwNDJvdzMrOVBqcjQ3TUpJRUxxNmtNQnNhajAzRFZjeHErcnNSeFRF?=
 =?utf-8?B?MWovSFFxV2JmL1FhWHZEQkYyM29XeEsrZGZCdVpSQ0hxKytiYzUrU2x3cWYx?=
 =?utf-8?B?Y1N6SnhGOVhvdmlUelZ3ZXh3TktDM2lJNVlCMVFTb2hDWnJGOW1EeFVYY0tH?=
 =?utf-8?B?RlJZUEc5dmpoMXRDNFpWU1orN09WNkt1VWtlejZ5aEtqQlFQWEpBWnF5UGx1?=
 =?utf-8?B?bmRDTDFhcXc5bThWMlVjMWdkSnJROCsrc0pmeDZpcVhVNHVBTU1VSmRNbFZP?=
 =?utf-8?B?dExUSWhVUlpSQ0xNb25aVkgwa25aaHNYb0I2OElmRXZjMEJXMS9NdWRqNXp3?=
 =?utf-8?B?TmVCakhlSWtCc2NYSGpVU3NSeEFiSHRNVXBJVk83TGhUSDFZUXZNZ1JkeU00?=
 =?utf-8?Q?hQVAmUDzY9vxTjzLxl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7c49b2-8d3a-4fed-badc-08ded835b1a1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 12:30:26.0817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEMgt/TA0WbFrRcriXXMbQ0lns3Zlyix3/6G9ChP/0ciD1vtQNHbLqUZGKGwCgBo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7132
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



On 7/2/26 13:53, Timur Kristóf wrote:
> On 2026. július 2., csütörtök 12:38:12 közép-európai nyári idő Christian König 
> wrote:
>> On 7/1/26 18:17, Timur Kristóf wrote:
>>> The retry CAM can filter interrupts which occur repeatedly,
>>> such as page fault interrupts when retry faults are enabled.
>>> This makes processing those interrupts much more efficient,
>>> because the CPU won't have to deal with processing the same
>>> interrupt repeatedly.
>>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>  drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c index 291326d2ee8b..ec0919fa8254
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>>> @@ -390,7 +390,8 @@ static int ih_v7_0_irq_init(struct amdgpu_device
>>> *adev)
>>>
>>>  	pci_set_master(adev->pdev);
>>>
>>> -	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 
> 0)) {
>>> +	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0) 
> ||
>>> +	    !(adev->flags & AMD_IS_APU)) {
>>
>> I think the check should be the other way around.
>>
>> In other words we can enable the cam on dGPU or APUs with IP version 7.1
>> because that one has the CAM as well.
> 
> What do you mean by the other way around?
> 
> The patch keeps pre-existing behaviour on IH 7.1 and additionally enables the 
> retry CAM on dGPUs. The patch makes no functional changes to IH 7.1, on that 
> version the retry CAM is always enabled regardless of whether it's an APU or 
> dGPU.

I just wanted to make the logic more readable. In other words:

if (!(adev->flags & AMD_IS_APU) ||
    amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0))
...

I still need to double check why we have the exception for OSSSYS 7.1.

Could be that this is for some MI* product, but I'm not 100% sure yet.

Regards,
Christian.

> 
>>
>>>  		/* Enable IH Retry CAM */
>>>  		tmp = RREG32_SOC15(OSSSYS, 0, 
> regIH_RETRY_INT_CAM_CNTL);
>>>  		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, ENABLE, 
> 1);
> 
> 
> 
> 

