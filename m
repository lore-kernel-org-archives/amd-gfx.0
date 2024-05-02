Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4359C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 12:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FECF10F0FD;
	Thu,  2 May 2024 12:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SIMo9m5L";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFECE10F0FD
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 12:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Guduhh/WcPvbeI9NFrwDEYZGqY40oDX6LZ18vnjd0565QSsBqzYN9UBk+Yw3KRmcoRYD3Z3j/9bMbkYb6V04IhZkPGqDZuD92XJQGCyndErsxu/1dRkF59Z4HhU4gzyagYuHUkMAVTiZI3VuQKvG5BDUUprmML/m0PIl6vQ8Bb0GLT9AuCnf8mre9Lz3z+S4obEcEbRLSY8OtJ+EWxJlOM6DIR8VzPRfcBhgZSUUkAvW9vTvY9yYvgSO6AoXqEEPePKoffm6EEB03rUkSPr10r1rdSLQQqp5rZkRoW6ZXkJAul858NTvb3Br86i5yAqHGIuJGqgiyGG7w4srb4gcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEuNCJMfuD+2Y0ugoRXEFjgu0dAlom4i7NdKUHaoAd8=;
 b=jzwS/2V82FOQS6TRUa+zmhtWJkt6Yci13S/GNFEr3zv5zRYz07hxA4HNMnaCJDnI41OKrW1AuZzwvwMTlvOYPOFEaQVm6TZzDbaCybUbbdls48jP3sGZ183DqREB1qyKrH8jYPNJD5/vD8aA0GVh4vDLTDYSJAvpR2ySL+bvImlrTmgtmfKufd0xAjvBiN76nDk4uXHbopIZw2K6gaPc+69q+891+aTni+m4PKIvuijfVs13rczZliL6U6Ah82kK4YnNsBx+1ud6QhhTZMIOg8Q87s9/YzWTiJMSVCuO4Zpd//fSNeUsL2lPO1OOhZw76xniqLjCktKpqBkA8FcetA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEuNCJMfuD+2Y0ugoRXEFjgu0dAlom4i7NdKUHaoAd8=;
 b=SIMo9m5LsbYkkaNizEx/fElTLTK0ZWnjgEyCrRv1sttNDrc5BmnCNKNH/iBf9yTU+A2sRCT+3+cHuVGB2JAwQTbH0/k0j30uYTzNM0B5OTbjIkxR3DKQG1IuPI3MQ6NQQxkKhmVFX+pvOSg07M0ZUOe3Jpy8G+jkz25rD/g6KLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 12:53:26 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 12:53:26 +0000
Message-ID: <09bd21a0-d796-ad41-da12-38ef611c5607@amd.com>
Date: Thu, 2 May 2024 14:53:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 01/14] drm/amdgpu: UAPI for user queue management
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-2-shashank.sharma@amd.com>
 <CADnq5_ML3xvC1-vP7AO5byS8oxq8_vayrsoWVghUhzqeCabUxQ@mail.gmail.com>
 <39458665-6f59-305c-5b47-70eb1072213c@amd.com>
In-Reply-To: <39458665-6f59-305c-5b47-70eb1072213c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: da6625e3-71df-4871-b83f-08dc6aa6dbad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGUxNENhZHVoVW8xNG01V1RlZ1JpUHZud3NUN3o5WnVhSWlrcVkyd0dIcG44?=
 =?utf-8?B?RVB1am1HOEVzUUpvMkZaRmdJaUxXYVU5Y2t1bWpmWE1CWlkwcmJIVFlPMW5S?=
 =?utf-8?B?ZlFGdUtsRUUrNlNUcUpGaVVXb0YyWS9qVGlWZDBTRXA5QzFlUUlBNnh4aldx?=
 =?utf-8?B?dkE2c1QyckZZdGNiUjI4OHdOM09MQm1CZnN3YXBRdElENlJPbmk0N3oxMWtw?=
 =?utf-8?B?VVpoaXR3ZFVPcWNpVTUybW1iMHhKbHBlZ01YMUdablZlcXM5YzJWakk3dXdY?=
 =?utf-8?B?YUNXOU1oWWhCQjJabjdMbG9ZQk1XZjNtOVB2N1JCc04wbUV5NFhlKys2VUF6?=
 =?utf-8?B?MlRvMC9EMHNGcHBxa2VRZFNlMUFXeWpmVzgwODNhdC85KzByMVJ5L1FnTlJ2?=
 =?utf-8?B?aE4vZmJ5Q3BVTXRCdVhHQVBvZ29iVE5NVGxmTHRKWGNISUFpV2U1V3djTWsz?=
 =?utf-8?B?NURCZjZZc0JCWmYxVHdnREl5ZUpuSDFBVFp1eXV2WEdsSm9wMGlCUVBZaWIw?=
 =?utf-8?B?QTd0NVo2WXJOdVJBMGlsQSt6aUR2L0dQam1LZ2YwZFRmTjNPWDViYmhwNFI2?=
 =?utf-8?B?dnJUMnFzdWx3bWUxK1U2eGlDc0dNMy9IL0g0UERoTTVVSHhuZHFINWhENFQr?=
 =?utf-8?B?bjBVVUNUcG9hakU0ZEdzT0lNdmNRUGJOYTZaVWNHaGJRTDJtSUxFL1VONUU5?=
 =?utf-8?B?SVFpcUhOWTVVZ1pBU3J1bFM4b2J0UXl2ZTRzSEEvWnhhMFpza3V5Uzk3dklN?=
 =?utf-8?B?cVYwVnZ0bU8vK2krcEZXdWdXZkhWMDVDL040eVBUbWJJR0ZzRjAra0V4U2VK?=
 =?utf-8?B?Wk05a3FqNEZNMTR1cEd4TXhOVnZtQjdUWHc5Z3dxWTdPaWlsTHhtVWtkdXFO?=
 =?utf-8?B?eHVjRVpYZXpONGEvSEt6VWltOFpBdFlsRjdOdTJ1K3cvcmduN25QdVQrQk9C?=
 =?utf-8?B?S3gxTEpaZE5RQUk0UVUrb1NvR2NLdzJSM2FOSVUxdVlqOEFYQy96STNrNGky?=
 =?utf-8?B?bGxacFo3aW9yZXJlL2ZJaEE1cEFrb0h6QVFtUTVOQW9HWk9qeUlsV2g4em5D?=
 =?utf-8?B?RllTMkk3d0ppM0lqVThzdHkrWXJxdFRHWmdKc2RJdE9LMTF0c1Z0TmZUNHA4?=
 =?utf-8?B?VVJ4UGhQL04raXliVWhXdXNzanhteDh1anExSXRMeStPZDlDbDZ1SUVQNVdK?=
 =?utf-8?B?WmMvY1kxMGx4ZFJ6d2M5d2JVK0lXMFBIOW1iMk42amkzMzE4SmxHNWc4RDFx?=
 =?utf-8?B?R1F6YUhNSXlmVWM4d1RBTmszeFhVTXdsdEgva2RyMHduREdYYWlrNzBDcDdV?=
 =?utf-8?B?bHJ6a2RqYXBKZDVabHRPNkppTCtzZGk1WmdOYmFoL21sS0N2dDE3bFJYSHV0?=
 =?utf-8?B?blB1VHVyZU41T3dQT1NwOEpGaUI1REphS1FzVzUwK3E2dkVMTWVDR1VHRGRV?=
 =?utf-8?B?Rm10TXB4QnRXamVxVXQreWxsVVptODNsQ2gxUys3NjdKTGFZZnJKbHBIYUdY?=
 =?utf-8?B?STFPT1MyMHY1N3dobzVEQzhoTzU4amRwWmpEZndmbEZmVmlITUFlZ3RxSDJq?=
 =?utf-8?B?dys0WndTbGMxMWhNY0gwUXFLaUJBU3FCdFRkU3ZOeW5LTzFvRnNZeFJRbXg0?=
 =?utf-8?B?eHdnT1didjgrd2lldmZxRWRQL3dYdjZCa2NLU21WMUVrRVJ3Yy9tL1l0SWNG?=
 =?utf-8?B?UWNhZTZnd0h3eVZrMWpaYkZJam9xTlFnakpDUWE3NldIQ2lLamtmQzRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUJMYkJqUWkrQ3RoYnZTajk0T0FxZ0lnU2J1V2xjaXpQQlhXK1V6ZFFWVzNl?=
 =?utf-8?B?Vms5aDlmdkJ6VjJXYk5KSDU5d3lmMVRZcHBhc2sreFVZMVdWdG90TERJRkhT?=
 =?utf-8?B?eDcrSnNWdnlLcjNNNHBqTFcvTU1PQnlJT2ZON2E4Z05zVjYzSDNnL2pxNi9m?=
 =?utf-8?B?UHZTRkVkb2tERnhIWXhNQ0RDcEoreE9FMlNIdHdHMzJpb3pPQkNGcFhoWWhr?=
 =?utf-8?B?MXhhM0s3UGxUdi9qQjBiOWlTSTB1NU5jNEUrNGJPL1ZTTjFXdTRockYvUFI3?=
 =?utf-8?B?RFpDWjd2TElQNWxJWENSUEhGTWc0cjhqSkU3cUplVjNTeE56RFM5eWsxdExo?=
 =?utf-8?B?UUt6MXlxanhWNTZZL0dOWncxVnpkTzZwc0xKUUlVay95WlJnUTNTUG5CN3Bh?=
 =?utf-8?B?akJ6TDBva29yUjZNMk9kKytiN1lDR2NwQWtoOFFpVktUd1NBSkdra3pySFVD?=
 =?utf-8?B?VVh6UUVSeDJNZkd1NVlrMGUyczBESENISldTYnNXeERUeitxTmhZd0RIbzdZ?=
 =?utf-8?B?djlqOHEwTC9pbWN5YjY4RDR1bWVBK0diVlNmaFN4WkRVUFhMamlCamt3WkVx?=
 =?utf-8?B?ajVpR00yVVA3T2FhSjZYL1dFUXVvdjBsSTQ1UGFpcnZEUDRtY3dQWkQ5L3lR?=
 =?utf-8?B?ck80b05YOVQ1K1JaKzI2ZU5zcFI4NzNHYUVjYmJObmR2d2pIM3R6MU5yMHll?=
 =?utf-8?B?SFcxT0FVTHBlWUt5R25tN2dlT1pjMy8vNzA5MmdJZWUvaitvM2Q5VVNRU0dH?=
 =?utf-8?B?cnk4RU1UTTJCbTBDTnA5bVAzS0wrNTlIRWJxU1JFU1ZXLy9vWS83bjVnY2RC?=
 =?utf-8?B?VkFhb3UzTFA2Vk5PTDNEQzJ3UlFGYzI0c3E3YnZzeEZQcWF2bkxHWGlIOFN0?=
 =?utf-8?B?bHBNT0NVamlLcCsrT0Fra2ZZUDM2UENBMmh1SGNZSXJ1RTV4ZlBpek9Vak93?=
 =?utf-8?B?RzNKL3p4OGNVelJKMU1tVVU1d1FZY3hxemZUVkd3ZUZTWktpQ2ZaM1FPU1dm?=
 =?utf-8?B?czFUU2NTM0M3Qy9DUWtTeTB1VTFRQzVHZ0JCdmo1Qkd6OVlLVWNvTHNZYVZN?=
 =?utf-8?B?bGpSOXRCSk9ra2M4QWczRzYrVFBXYldYUDdreDJEd295YXRUVk8xUUQxV2ta?=
 =?utf-8?B?NXJsZXQwWkNaNXRMcVFWb1lkb3dDLzhKdUdIQkZrM2FOcjh2ZE1PZVl0TTA2?=
 =?utf-8?B?MEZqTWNoVGZCbmFNQmdZMkN3OThpOERkY1A0RHRuL3hXOWcybjFuZWFGbmpt?=
 =?utf-8?B?TkpLUWljN1Q3NFEzZlduY0ZjbWlvbFdZWm9GRXlnZVpPMjQrZ0oxcTdaZE9v?=
 =?utf-8?B?T29TeWs2Y2lSWUtrekR2bWVKWVV6STE0alZhRWpobVFFMnN0SFcvUEtub1Aw?=
 =?utf-8?B?alNFTkxROFZNMWNhVHVvMjNsaXAyeUFadno1MU0xVjNNQi9kRS9NT1BlU0pI?=
 =?utf-8?B?UlljNS9lZlNiQWZvcVdQZHRrZ3lscGZBcmw1UEF5MjViYng0cnJWZ2V0a0tj?=
 =?utf-8?B?TUZKZWF5QTYvS1Byd3RTRHNROFozWmVQYVRvT3htRWJLa05rekgzaWZULzkz?=
 =?utf-8?B?SThiK0xUbXdkQU5RWk5Ea1ZBajlxaXJPRnRDSU9IVmp4Nm00Zm1FdU5GRXh3?=
 =?utf-8?B?TnQxK1VKaGhOb1RZZDJYL05RaEhHL2w5L1YwR2wycUhnc0RxTXdtVE4ydXVQ?=
 =?utf-8?B?bjdTdmNIUk80NkRSekJxc050V1NkSW5TRnY2U3M4ZVI5ZGdNWHVzbUNFbmFo?=
 =?utf-8?B?WkovOVdQaWhQbFBFa2RsSHN2dVdBbGE3V3l2bkRYRnR1MkhLbGdDTXBja2Q5?=
 =?utf-8?B?dDVMTSt1NjFmR0QyTU1PMXpQRXZqaWIvelRQcThWbEwxWldUTnhxcnFPQjcy?=
 =?utf-8?B?ZmFaSW5KNUh1MGl5K29oOUkwb2FGR0ltNEV2SmU2dks5ODNIUUZzOEdVb3pB?=
 =?utf-8?B?V2F3MWlnbDBjZ0ZMaUtkc2owK3owV0Q2SWtzS1VZQnlyd0xDUHkrV040NmN5?=
 =?utf-8?B?R0RiWCtIS1dmTDNsVW9nRjJKenVUKzRLMzdhaWt3K3o5enhRdnZ4bkgwNnlX?=
 =?utf-8?B?QTFObUdUamFJOGo4ajl4bXkzU0lueTlWbXNYL2xBYTJka3UvZVpNZ29XbmJi?=
 =?utf-8?Q?OVu8N9KAjeSSegrCGtctGjxH6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6625e3-71df-4871-b83f-08dc6aa6dbad
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 12:53:26.3809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bbILpsyEDZCIA9bOUfU4ERkECgc1aAI/8gRZoq92ClnBivjwhzIuLHj/IUXP1cPME2Qdle3A4VAmN8kqaEMkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194
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


On 02/05/2024 07:23, Sharma, Shashank wrote:
> Hey Alex,
>
> On 01/05/2024 22:39, Alex Deucher wrote:
>> On Fri, Apr 26, 2024 at 10:07 AM Shashank Sharma
>> <shashank.sharma@amd.com> wrote:
>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>
>>> This patch intorduces new UAPI/IOCTL for usermode graphics
>>> queue. The userspace app will fill this structure and request
>>> the graphics driver to add a graphics work queue for it. The
>>> output of this UAPI is a queue id.
>>>
>>> This UAPI maps the queue into GPU, so the graphics app can start
>>> submitting work to the queue as soon as the call returns.
>>>
>>> V2: Addressed review comments from Alex and Christian
>>>      - Make the doorbell offset's comment clearer
>>>      - Change the output parameter name to queue_id
>>>
>>> V3: Integration with doorbell manager
>>>
>>> V4:
>>>      - Updated the UAPI doc (Pierre-Eric)
>>>      - Created a Union for engine specific MQDs (Alex)
>>>      - Added Christian's R-B
>>> V5:
>>>      - Add variables for GDS and CSA in MQD structure (Alex)
>>>      - Make MQD data a ptr-size pair instead of union (Alex)
>>>
>>> V9:
>>>     - renamed struct drm_amdgpu_userq_mqd_gfx_v11 to struct
>>>       drm_amdgpu_userq_mqd as its being used for SDMA and
>>>       compute queues as well
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   include/uapi/drm/amdgpu_drm.h | 110 
>>> ++++++++++++++++++++++++++++++++++
>>>   1 file changed, 110 insertions(+)
>>>
>>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>>> b/include/uapi/drm/amdgpu_drm.h
>>> index 96e32dafd4f0..22f56a30f7cb 100644
>>> --- a/include/uapi/drm/amdgpu_drm.h
>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>> @@ -54,6 +54,7 @@ extern "C" {
>>>   #define DRM_AMDGPU_VM                  0x13
>>>   #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
>>>   #define DRM_AMDGPU_SCHED               0x15
>>> +#define DRM_AMDGPU_USERQ               0x16
>>>
>>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + 
>>> DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP DRM_IOWR(DRM_COMMAND_BASE + 
>>> DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>> @@ -71,6 +72,7 @@ extern "C" {
>>>   #define DRM_IOCTL_AMDGPU_VM DRM_IOWR(DRM_COMMAND_BASE + 
>>> DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE 
>>> + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>>>   #define DRM_IOCTL_AMDGPU_SCHED DRM_IOW(DRM_COMMAND_BASE + 
>>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>> +#define DRM_IOCTL_AMDGPU_USERQ DRM_IOW(DRM_COMMAND_BASE + 
>>> DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>>
>>>   /**
>>>    * DOC: memory domains
>>> @@ -317,6 +319,114 @@ union drm_amdgpu_ctx {
>>>          union drm_amdgpu_ctx_out out;
>>>   };
>>>
>>> +/* user queue IOCTL */
>>> +#define AMDGPU_USERQ_OP_CREATE 1
>>> +#define AMDGPU_USERQ_OP_FREE   2
>>> +
>>> +/* Flag to indicate secure buffer related workload, unused for now */
>>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
>>> +/* Flag to indicate AQL workload, unused for now */
>>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
>>> +
>>> +/*
>>> + * MQD (memory queue descriptor) is a set of parameters which allow
>>> + * the GPU to uniquely define and identify a usermode queue. This
>>> + * structure defines the MQD for GFX-V11 IP ver 0.
>>> + */
>>> +struct drm_amdgpu_userq_mqd {
>> Maybe rename this to drm_amdgpu_gfx_userq_mqd since it's gfx specific.
>> Then we can add different MQDs for SDMA, compute, etc. as they have
>> different metadata.  E.g., the shadow and CSA are gfx only.
>
>
> Actually this was named drm_amdgpu_userq_mqd_gfx_v11_0 until the last 
> patchset, but then I realized that apart from the objects (gds/shadow 
> va) nothing is gfx specific, its actually required for every userqueue 
> IP which is MES based, so I thought it would be an overkill to create 
> multiple structures for almost the same data. If you feel strong about 
> this, I can change it again.
>
> - Shashank


Please ignore my last comment, I understand what you are mentioning, and 
I have reformatted the patches accordingly. Now, I am keeping everything 
reqd for MES in one basic struture (drm_amdgpu_userq_in) and creating  
drm_amdgpu_userq_mqd_gfx_v11 for GFX specific things (like CSA, Shadow 
and GDS areas). Now there will be one separate patch which will enabled 
GFX_IP on MES code, just like how we have separate patches for SDMA and 
Compute IP in this series.  I will send the V10 patches with this 
reformatting in some time.

- Shashank

>
>> Alex
>>
>>
>>> +       /**
>>> +        * @queue_va: Virtual address of the GPU memory which holds 
>>> the queue
>>> +        * object. The queue holds the workload packets.
>>> +        */
>>> +       __u64   queue_va;
>>> +       /**
>>> +        * @queue_size: Size of the queue in bytes, this needs to be 
>>> 256-byte
>>> +        * aligned.
>>> +        */
>>> +       __u64   queue_size;
>>> +       /**
>>> +        * @rptr_va : Virtual address of the GPU memory which holds 
>>> the ring RPTR.
>>> +        * This object must be at least 8 byte in size and aligned 
>>> to 8-byte offset.
>>> +        */
>>> +       __u64   rptr_va;
>>> +       /**
>>> +        * @wptr_va : Virtual address of the GPU memory which holds 
>>> the ring WPTR.
>>> +        * This object must be at least 8 byte in size and aligned 
>>> to 8-byte offset.
>>> +        *
>>> +        * Queue, RPTR and WPTR can come from the same object, as 
>>> long as the size
>>> +        * and alignment related requirements are met.
>>> +        */
>>> +       __u64   wptr_va;
>>> +       /**
>>> +        * @shadow_va: Virtual address of the GPU memory to hold the 
>>> shadow buffer.
>>> +        * This must be a from a separate GPU object, and must be at 
>>> least 4-page
>>> +        * sized.
>>> +        */
>>> +       __u64   shadow_va;
>>> +       /**
>>> +        * @gds_va: Virtual address of the GPU memory to hold the 
>>> GDS buffer.
>>> +        * This must be a from a separate GPU object, and must be at 
>>> least 1-page
>>> +        * sized.
>>> +        */
>>> +       __u64   gds_va;
>>> +       /**
>>> +        * @csa_va: Virtual address of the GPU memory to hold the 
>>> CSA buffer.
>>> +        * This must be a from a separate GPU object, and must be at 
>>> least 1-page
>>> +        * sized.
>>> +        */
>>> +       __u64   csa_va;
>>> +};
>>> +
>>> +struct drm_amdgpu_userq_in {
>>> +       /** AMDGPU_USERQ_OP_* */
>>> +       __u32   op;
>>> +       /** Queue handle for USERQ_OP_FREE */
>>> +       __u32   queue_id;
>>> +       /** the target GPU engine to execute workload 
>>> (AMDGPU_HW_IP_*) */
>>> +       __u32   ip_type;
>>> +       /**
>>> +        * @flags: flags to indicate special function for queue like 
>>> secure
>>> +        * buffer (TMZ). Unused for now.
>>> +        */
>>> +       __u32   flags;
>>> +       /**
>>> +        * @doorbell_handle: the handle of doorbell GEM object
>>> +        * associated to this client.
>>> +        */
>>> +       __u32   doorbell_handle;
>>> +       /**
>>> +        * @doorbell_offset: 32-bit offset of the doorbell in the 
>>> doorbell bo.
>>> +        * Kernel will generate absolute doorbell offset using 
>>> doorbell_handle
>>> +        * and doorbell_offset in the doorbell bo.
>>> +        */
>>> +       __u32   doorbell_offset;
>>> +       /**
>>> +        * @mqd: Queue descriptor for USERQ_OP_CREATE
>>> +        * MQD data can be of different size for different GPU 
>>> IP/engine and
>>> +        * their respective versions/revisions, so this points to a 
>>> __u64 *
>>> +        * which holds MQD of this usermode queue.
>>> +        */
>>> +       __u64 mqd;
>>> +       /**
>>> +        * @size: size of MQD data in bytes, it must match the MQD 
>>> structure
>>> +        * size of the respective engine/revision defined in UAPI 
>>> for ex, for
>>> +        * gfx_v11 workloads, size = 
>>> sizeof(drm_amdgpu_userq_mqd_gfx_v11).
>>> +        */
>>> +       __u64 mqd_size;
>>> +};
>>> +
>>> +struct drm_amdgpu_userq_out {
>>> +       /** Queue handle */
>>> +       __u32   queue_id;
>>> +       /** Flags */
>>> +       __u32   flags;
>>> +};
>>> +
>>> +union drm_amdgpu_userq {
>>> +       struct drm_amdgpu_userq_in in;
>>> +       struct drm_amdgpu_userq_out out;
>>> +};
>>> +
>>>   /* vm ioctl */
>>>   #define AMDGPU_VM_OP_RESERVE_VMID      1
>>>   #define AMDGPU_VM_OP_UNRESERVE_VMID    2
>>> -- 
>>> 2.43.2
>>>
