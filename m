Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACABC433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 07:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0686A10E9C3;
	Sat,  5 Feb 2022 07:00:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E4A510E9A1
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 07:00:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCr/adLBNnLejdkEbYr9Leg+hmF3+uRIq98K1uuI7qubFgLCV8dZE1KK+f0+EMrwK9ATPv+CzNvi7CZHzelmVKuoYjKWC6BOpgq977P4U3zqbWefhNGXBq3W0+r1t7LIGPAs7dfLE4hxQyCsBvZDC34S2HOG/Cogy8ItlWlATtblaqo2Kq99wAtZNqQOpn8syfA11K/PcqxWtOfwnyveXbrGfyo+Fd3xc7I2JuQTAx/+jg+ExIzP47HvVKn1C2OMrEeK/Rlee9EmblTDavi2gLR9aaDo0Met8EKgu+Wfs+h7IGiN1edzSwpmEF/+OsfeVM2KhDC1EfPMTPYLOfn0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r74ujNBrsVkRfWPI+q7fW2z6olgesOS31URkcRJvTpc=;
 b=XQR5Sg727hPHfO92mghrtCrcB1P1lQCuwxUWGGR7yNbfFV/Qxp6GiwjFkJGFip7ED848rp/SzOm2KLrxxdUvl3VVwZgfTJyCH5EaWRlP21z9jlvY1jjEnsNlRmUn3Y0r4WtEsOsPElRvhlc9GkiKVboka7dImIoMfnmX/YLDXcrmEAD5ADmQKFb+QiuFhPNNvbsRqrU2RMNnk8+XFI2vrLkoLL1f5GBz7X+Lm3/zeyou65s7280+96h/GOL+1/Ksls7Tt4izVz5+KhjFBIWDNEEqscQuxPaw6lprP2QJiedwXp6tNwUDGi5o6ggoLIeSUVA5USFCARZqJB1oWc5x7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r74ujNBrsVkRfWPI+q7fW2z6olgesOS31URkcRJvTpc=;
 b=4qkcjmd0oMfFAK6n1OBFCWucNKHXd5ERZXJKbz21PGboaW22sNpUq7kD7paVDhj9g2kbNZAhcW8xRu/1L7gpwEoygw1Wy3yg1fitiaMxIc+5U3A+HbbQzRaB72TiAuzSYuTg91g9n1pNH4wNsjzT96OZ9z911fJXxd+emGzCKOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BL0PR12MB2436.namprd12.prod.outlook.com (2603:10b6:207:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Sat, 5 Feb
 2022 07:00:21 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4951.017; Sat, 5 Feb 2022
 07:00:21 +0000
Message-ID: <74cea3f7-0761-fc93-e90a-7ebaaf1cd6ce@amd.com>
Date: Sat, 5 Feb 2022 08:00:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
 <a0693436-619c-efa1-b3f1-2fca6377e2fe@amd.com>
 <817df2c3-e7af-92cb-53f8-8bc70b69b988@amd.com>
 <BYAPR12MB46149A07EB030CB27FDA8B1397299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <8bada9e4-d6d5-e11a-45fe-aea7615f3356@amd.com>
 <BYAPR12MB4614325D69EACA459547E4F597299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <77fd42df-be70-18bd-ebb8-503214ef6af8@amd.com>
 <BYAPR12MB461419D8152EBBD70BB9BAFC97299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <c28e3fad-29ac-a326-30c3-4f4de0001e47@amd.com>
 <BYAPR12MB4614628DE8E6D39EE53307DF97299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <b885ef98-3ff3-92b3-c238-041a0f5ab2a6@amd.com>
 <BL1PR12MB5144C96658B5B9F3058FCB1AF7299@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BL1PR12MB514487E169A1614431BCD1F7F7299@BL1PR12MB5144.namprd12.prod.outlook.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <BL1PR12MB514487E169A1614431BCD1F7F7299@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P194CA0072.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::49) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e64a5109-2c67-4b6d-3bad-08d9e8752ccc
X-MS-TrafficTypeDiagnostic: BL0PR12MB2436:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB24367F39F7011E1E4B3F3B02F22A9@BL0PR12MB2436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEnwfexWrbwk4F/G4kJZ+Ku1VbJ4S7kLXLw86UepDqfjqS+jHDkXsIUli+3rMt2a3fEWp/+oXnpQM2/RwF1aqUNnIb9ybTY3Arj0u3BZ0yx6fRHsbkZXaPIfY2wc5ni5Vfz/dUy5SF2Opx8BdbiRZ0d6iqTvQLL70DMzM3RLDMDvt1ojjc+EM6T2Q8oQ6ww8senzDHw6ig4AVU4HSv1Isw1cpNRmtk8wEr43ttnZeEeBdXTZte2ekij5Pi4QRFMAghSX7IOO9n7K/cCyV1L2BGPi7u2rg5h8shitkGznY1+z6VcP5ptNhOVCZttPdsrFwHVNPvWD35y3dkesOhDGyXBasOh4ZvvDoQyc3sB+NhxcICmNSPhWuDDm1h+KmOky5fh93bI+8HFEu+ubJngcVALCJCCnwoIfnYb2DkaMM09HLHOWMgn4AUdjjyc4DwlNq1frRJmpoOO1+VSZP+r+Gk7tFzqVcgHtlzFgliqkPpPwmSX3CH9tIEELbHXl3q3u/GOSClndI89X6K1qit5/1ZkhqNP+QL2vyVZ6lQKW0WkE28KdOcGM+7nIM/caB0sqHvGXucjs21SkyKMb8t7zWjmGjgxOsppXAbx1AD55eP01arSo+486k+Y+nsqOB+BR52uCXs2/wuAtKj7RUnVo2cSs6wZuS0jwGn1J/cul8QrmNiN3dTv9Nqm0cRIyrpW00qC96NkpEfhWPH4zZIBssS8BPrSJPqEkdpNgqxa50ASEExzfPxoAB32RErSA5q96
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(2906002)(53546011)(6666004)(6512007)(6506007)(38100700002)(4326008)(8936002)(66476007)(66556008)(8676002)(66946007)(31686004)(36756003)(316002)(54906003)(31696002)(186003)(2616005)(110136005)(6486002)(508600001)(86362001)(26005)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckhWYnhtcmlqUjhGR0tTWVRxaDdHUXNNZ3dERTdLMjFiQ3N5SVExa2RJbkc2?=
 =?utf-8?B?d0NmZGxpNlpHZjdHaVlyUkltUEd2eS9BYURMRVZ5VHoyaDNWOGZYTWdCNG9v?=
 =?utf-8?B?SXVYYjNyT0dScGt3V2hPY2ppOUd5T0YyazBqbnp2VUNIYktHdjloWkNkUWRp?=
 =?utf-8?B?V01laFpGZGVBS2tROFlveDlSbUNtcDlQQU9oYTVVOG1sdlNVZXdsRGt3V0lv?=
 =?utf-8?B?VXVHQXJxSjhTeFIvV2VXWXF4UlpaYzFIamhmTDhES1QwbzFvLzBIUVhaMU0z?=
 =?utf-8?B?UWNFZ1RVT04zRkVEZzNJNWxDUEJtYXJZNHIrQ0ZXQ1NVcG5QSUVPbFZ5WkNn?=
 =?utf-8?B?Q0tkSDNlSDVHSXhORGZaZnBZOEpsRkJ4L1lEamZEdGN5Vm5ZSHFxZ1RLQTVr?=
 =?utf-8?B?ODhMci8rR2t5Z3pUT3I2YTZWWFJFOVF1eUtIbFpIaW1JVjR5QVEwazNJeEF0?=
 =?utf-8?B?NGJEZzRmbHRQejJRVVFxbkxydUg3dm45SkdtaGUrRHRyUTNZc1p6ZUlhQUps?=
 =?utf-8?B?by9YMzJleVk0S0xOYzlZMUE2REdxdEFkT3NLUHNGUm0xRExhQUVHN2hJUDNp?=
 =?utf-8?B?dzlIMjFwczVSd2x4dW1oRTVSakxWSjZOODVaTlJ5UlRmWC8rMEEraWdpTUdm?=
 =?utf-8?B?WXhwa3BBMCs2RFF1ZHg4RXBmTDlzc294YjVsVWJlSjVuTFowTkJhWnhvNXA3?=
 =?utf-8?B?UWsraFFwRXozcUdxS0lsMXIyU2ZqMmpBNSs3dEdjbkRWbW1SMmNWT0d4VzV4?=
 =?utf-8?B?SDBNYjVkZE1iVDB2bHN1eXV1aTZKSUtCL05TODNuamdJT2tlcmhOeC9mK3dK?=
 =?utf-8?B?UkZkVm9kL2RMeVk4dlZSUVlSSllweVgveUU1MFNENWJCZm51aW0vWnA0ZUtL?=
 =?utf-8?B?eVlXYnhOQnlMbnAxVkN3TEhyRWxXT0czZW9HWUJkMDNySGk5a2ZUS2pzQi9M?=
 =?utf-8?B?YngrbG51Vm1paDNxR1VPaC9VejREbnU1TGxSbXZVeU5tN2hKTDFVWlk2c24x?=
 =?utf-8?B?dHJTUFZBcTRWUW1peGxEL1R2akU1UXhOOEhySVBtczJrdnY0OCtQZEdRc1Js?=
 =?utf-8?B?TVhzRDlVQTRlWmdBWXZIVXhZU3hudlRCenNvaUo5OUw1M0xZWURMYmszR3Bw?=
 =?utf-8?B?UXNVYTN2SXdESFpUTGUxK09DY2V6bTVManVTZmF1TExrQXVBUW1nNXJOTVA4?=
 =?utf-8?B?STNQUTJiMEJaMmhMQWJYQk12N2NiY3JVZU9yeW5uMG0wdEVuMWV0QVdUZXIv?=
 =?utf-8?B?QlQrM01WZ2N6MUs3RUtFdHMxSnhyTDRGaExDV2tEbW54NlpqeUorRkRRdm1G?=
 =?utf-8?B?aFRLbVVIbWxhajFFc2RrRERIN2FhNkdVdkRrcWpiS2VjME5jejIvZnlFZTMy?=
 =?utf-8?B?VGtyQmk1NzEzZVBjRHJsaEhrTmlaemVIYmRZVEdKS3BLa1UrbTdzMGR0ZExQ?=
 =?utf-8?B?aUhtS3J3WGN6Mi9IVnpwYUhvNGljRE1WOVhWUFZtUGVqVFR6QTMyd0hqeW9Y?=
 =?utf-8?B?c1ZHTmJrRFp5VmVRdFEzZFBERHhQdEpEWGpRSWc3RS9jS1d0UUFSZEE0bzU1?=
 =?utf-8?B?bkF0ZXk5dTdjWWtwOUZSRVU2Y3pSbWR1NHY1ZTBPTU0zYkU1QThYc0FjT0Y0?=
 =?utf-8?B?YTVWRWtBR0pSbFZab1krR1M5N05RakJrUjIrNTVOWVdPcm1qcElRRTB0SVFk?=
 =?utf-8?B?WEpqUE9FMjkwRy92aXdYayttazI5Q3h6bjFTdUdEVmV0YWt2STM3bzNRMW5Q?=
 =?utf-8?B?a3paT3dBL1dYbUozcVI4ZkVweUwrbmJZd0N1OTBwQVVGajRPSmlpR0dzY3Zs?=
 =?utf-8?B?OTFHY0NaSGVnaEZ0aVcwNHlSTUxOY3R0aFlWS1FRQ1B5MktQaXNBc0xpSFhT?=
 =?utf-8?B?dlVCL0U4NHZhN25SYlluc1liRHJaTkFndjVteEx0T3grbTJreHFkb1lpR0tW?=
 =?utf-8?B?U2lUM1FEN3JGUlBzbXhVYzRvcXZieXNxeW1ydFBLbEZRMGN6WjBhOHViMUpI?=
 =?utf-8?B?U295cnloR3BjWHoyeU5FZVIvN0lIV3pZdjAybVppMnJSVjJ6eGhHZHpvNUxN?=
 =?utf-8?B?QVJzYjdsMVJ1MDZMU2ZIb2NDM0wxVG9YZjcrb2VWZEMrSCtaOXpjY0sybFFL?=
 =?utf-8?B?UHhDTHRhd1lJeVhtalFpaVp5R1cwQVdSSXFUZTY4ZVp4cFdpSUVxdC9JU0ls?=
 =?utf-8?Q?HsK5D71OTUlFoxYY/qaAAFs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64a5109-2c67-4b6d-3bad-08d9e8752ccc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 07:00:21.2847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiRsb2+HlvtgyvHfg2R7gkyDApC+J66W5FvQhmSvJncrRvuLvNST/azCIYimayzGcrQoE1j4Cvfeb6TP15GaIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2436
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
Cc: "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Alex,
Agree, we are moving it above, Christian also had the same feedback.

- Shashank

On 2/4/2022 7:44 PM, Deucher, Alexander wrote:
> [Public]
> 
> 
> Seems like this functionality should be moved up into the callers.  
> Maybe add new IP callbacks (dump_reset_registers()) so that each IP can 
> specify what registers are relevant for a reset debugging and then we 
> can walk the IP list and call the callback before we call the asic_reset 
> callbacks.
> 
> Alex
> 
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Deucher, Alexander <Alexander.Deucher@amd.com>
> *Sent:* Friday, February 4, 2022 1:41 PM
> *To:* Sharma, Shashank <Shashank.Sharma@amd.com>; Lazar, Lijo 
> <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, 
> Christian <Christian.Koenig@amd.com>
> *Subject:* Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
> 
> [Public]
> 
> 
> [Public]
> 
> 
> In the suspend and hibernate cases, we don't care.  In most cases the 
> power rail will be cut once the system enters suspend so it doesn't 
> really matter.  That's why we call the asic reset callback directly 
> rather than going through the whole recovery process. The device is 
> already quiescent at this point we just want to make sure the device is 
> in a known state when we come out of suspend (in case suspend overall 
> fails).
> 
> Alex
> 
> 
> ------------------------------------------------------------------------
> *From:* Sharma, Shashank <Shashank.Sharma@amd.com>
> *Sent:* Friday, February 4, 2022 12:22 PM
> *To:* Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, 
> Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>
> *Subject:* Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
> 
> 
> On 2/4/2022 6:20 PM, Lazar, Lijo wrote:
>> [AMD Official Use Only]
>> 
>> One more thing
>>        In suspend-reset case, won't this cause to schedule a work item on suspend? I don't know if that is a good idea, ideally we would like to clean up all work items before going to suspend.
>> 
>> Thanks,
>> Lijo
> 
> Again, this opens scope for discussion. What if there is a GPU error
> during suspend-reset, which is very probable case.
> 
> - Shashank
> 
>> 
>> -----Original Message-----
>> From: Sharma, Shashank <Shashank.Sharma@amd.com>
>> Sent: Friday, February 4, 2022 10:47 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
>> 
>> 
>> 
>> On 2/4/2022 6:11 PM, Lazar, Lijo wrote:
>>> BTW, since this is already providing a set of values it would be useful to provide one more field as the reset reason - RAS error recovery, GPU hung recovery or something else.
>> 
>> Adding this additional parameter instead of blocking something in kernel, seems like a better idea. The app can filter out and read what it is interested into.
>> 
>> - Shashank
