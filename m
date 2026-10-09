Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECAECA5FED
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 07:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF9410E702;
	Fri,  9 Oct 2026 07:41:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xaAeY7PF";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013050.outbound.protection.outlook.com
 [40.107.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DCFA10E702
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 07:41:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hW9Ubi0udq6Rp21vo0m3uol7ELPqBhv1dgdqBJ3qAkiuCCy/ljlMhdMcmrKZF1SFk4vSc+OMYYWAULFaVuUoXlCFfA2tEKgx1FhDW0ent7kJwQjeRgRs7WnIAJQcs2OU5kFah+FXWcNdRlI5rS/Kef0774HQdys/vFSmW4ro1PNNlxcRBw1f1aHeFZMCX1JedU7TkNVZXnqcPZBgYA+IRps5D/AVDopqItzDvwLzizC2WXhdlE+IraWmolDBAMLSCSxSazE3Hm6YwtAkkNJHCM5jEVRNUv4w0ghLRpKHRL0mZHhbdfvN3J5AFgREt/3pyZaPy7ePKrzo8plX4M97ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFPqFSxxMSOciU5uRBBQVHufcR6pLf9AwblziPznLKE=;
 b=sqW5fYXy5Aph6upDfc/3Ja522aja4RZ16qZVRhIPV9KpcBpX9gwHWjSCVDn7Ofs+oFra7lV1sZeZ2X2EU+WUI1R/rAIahq6jDWjebeYWVg4kFq+PcQLyTqGR/jA2EYoy41AlN8npUgHz/J4sgcFH4b7o612zxcc00mXYON5zo3I+aUWdPSZ8aVBJkgcxl5xbJoPQxBMeTrFZeDO1JRlqKEvB9hDD14nMrBXK9j+MtTAxIzFwGYnHTFGXLxIT9luGl+kaNEoA91KPovO+oc2LTtGgMo+CvwYCcqZcWOxQ1UFXKdqkNwLTgSd8TScmP/VkYEsUaNYjSS7L4qqyTvoROw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFPqFSxxMSOciU5uRBBQVHufcR6pLf9AwblziPznLKE=;
 b=xaAeY7PFWLbCSDjSJYKCkVTPHKeQGlQQ6oESTYSnsYjfMvlJvMtHgYGkDNUHpsbXHZrRJ7dFaTrGDu4f6AhSk7psLgzANxFHza7VfTcnQZVVKGvkYLlojpfn495ob6UhbFa506YqSTYNfgLFaLBwH5KW3oUtAwLsuoxKKy13se8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SAVPR12MB999170.namprd12.prod.outlook.com (2603:10b6:806:4e8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 07:41:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 07:41:54 +0000
Message-ID: <1db03d2d-8f11-4b9b-875a-9b6d2c0fc4aa@amd.com>
Date: Fri, 9 Oct 2026 09:41:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across
 GPU reset
To: "Liang, Prike" <Prike.Liang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
 <20260929034650.2393125-9-Prike.Liang@amd.com>
 <0375ebd0-df28-437c-b6b4-47f06d4d1a24@amd.com>
 <5ff3175a-a8fb-49d4-b40a-36ab460f8ca0@amd.com>
 <PH7PR12MB6000ADDBADE18139E2B7401BFB932@PH7PR12MB6000.namprd12.prod.outlook.com>
 <PH7PR12MB600066077324CFC6B1BAA16FFB922@PH7PR12MB6000.namprd12.prod.outlook.com>
 <7f51bd62-7a74-4cbc-95d1-5c31d52fde31@amd.com>
 <PH7PR12MB60004BE15CAB1279EFDEBEC0FB922@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <PH7PR12MB60004BE15CAB1279EFDEBEC0FB922@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SAVPR12MB999170:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ec1ed6-d38e-47bd-781a-08df25d8ca11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: QzqCNKS/zMTQ4FwIyKhjS4YDF3PtHmdt6K8GniIgvYS87/v/KH/Uq7RRCkFSByZwe/na4xgtcd6BnUUAjs02+gwsA7Esmn4B+uvdU9sNyfUQNLG2Gz9pwX5oD5wSou+iNDD5XMBuPn7xa8YubZftUuPbHJyS65FNDNlKibKf1dttm2jV8VA7Xdju+4wCyzjkPMBKB/0v6inP6HZWo+aiGvydcjjg5eOR+M0PJZMk9Ytu+HAECcv6vH/jn1zRkoD/BTBSbrC9no6blq3PRMSHz7Ivk6Mswnelb+ca0Epa5GqJb9goeL/FXxLjAyrMSeAnvsDz+f7lQrWZ57o6pyN07+cVpQa7gDU4Kk51PJDe1KISv1/C9RjwGfYxDWJ83U2LfwsAKMsh4aMzJd6zl8Ro1VKcjuGRBrIS+ZF4VkpBiO5HE3jIaE7mD5L1J2KvOrB3s1l3eEwl7ch3IM1aXIGlMQEZ4jda7LGS8ODGoBQt8vo2hwStQuhxEJKEBwJB2YnwbWlG5I1YWXBRHrxluZc3wDF5jZIWjPG9Mc805HQE0rzR02P3rjk1lTbezVvBFfZF3c+LeUCPgBGPh54Dem90/iDjTpRg6gkfq1uaeokUjIACt2oSmC27IG9dnfiYj238xoiBB9Eiqox73Zwxx9PVpJ0EnJlJYrJTJF0+4yRyQ7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWg1S0xyRm40SFVFaVVsVDBIWnF0ZkdIV09MamV6OVl2bisyMWp4RVduTXFT?=
 =?utf-8?B?Zkw4Q1dCTWQ5NlBkcC9Vd0RHNm9kdDdhU2N1ZkdDZUNCa1hUTlR1NkNqU0dO?=
 =?utf-8?B?azZJZGZHWVlFUzBwMU45VGwwMXlEdWo3SmlwNTU4eXRoYmdDRnRGL0RPck9U?=
 =?utf-8?B?QVNVR0F6WHBSTyttSFlHRk1qOThiYWdtbUZZZHFUSFRyR1FVT05vbjYwWnlG?=
 =?utf-8?B?VG9OaDBYRTl6NGpjMENTdFJFK3E3S0JEdHdKMXVtSTEvM1hiSnQyZGhwRVVQ?=
 =?utf-8?B?Sm0yaVJ1blBITzd5ckpQZXFpeTVsclg5SEhxZnN2ZTlCOGVJSGNibWh1NU1m?=
 =?utf-8?B?WDVEWnNOd2RPeGxvY1Q2TGt5Wlh1TXRjNzFTbE5DZHdFWjFjNmV1RUZvQUl2?=
 =?utf-8?B?YnNGSDBvdzQrdzNVd2J0Q2NyQUZKdnowdk80YjNoVXB5bGM0V1NYem5LTS8r?=
 =?utf-8?B?REY3cThLdWw1dmFzSEY3NzVhZXo2bWRva0t1YXRWMTFsVkhQbDBsSFVSdEFi?=
 =?utf-8?B?VjBBcm9laTFhSVM3RkNkSG16RkI0TE1KMXF1WmROdlBFRGM2T0ovRXBwMElu?=
 =?utf-8?B?M3pHTzNDcE4rM3ptTXdTeWpldStkZVM1YUJBRW9lWVowTlBoaGduZ244elJp?=
 =?utf-8?B?cHlQT0ptZjV0aVlNL2w3U2RhTmhESzNSY3dpcU5tc3hMVFYzZ0gxN2dmODBo?=
 =?utf-8?B?T200OWVMbWplOEN5MDR4M3g2OHd0ZDRnaWs2am56SjRxWEpnQ3VFcFFkWnlE?=
 =?utf-8?B?K09jZklueUVGREpJTUppeUJzR3ZTZFNJL3o3eGlZajk2T3JrbVZ6ck9RcGh2?=
 =?utf-8?B?OVZFcFplMnA2SW9sRmFUQTk5TXZ4Sks0WW0vWmhoeDl4NEZ2L1RIQzRNNkU0?=
 =?utf-8?B?RWlEaG54QUt0Tmx5NGlMVW01RG1tdVZNZjFHWm5zdlNkY3FaTWR5ZzlXbFEw?=
 =?utf-8?B?eXhoRGZWUThzRDhMS05WZlh1M0oycUUwc3Z6bDhRMDhiUDZqMWl1RE1LWWtZ?=
 =?utf-8?B?a0EyQXF6TzV1eGF5M1dQNWJ2bmpoUkRQZnpKbTlrUjEweFIxaGhRcHZHeEJI?=
 =?utf-8?B?bXlycDl5ZHl2TWE1cUFpbm5MZFVSSkxnUjRCdEhHRDdMOUlKY2ZROW83VWEz?=
 =?utf-8?B?ZW82bnUrekpUSkpINWp3dEdzMGFmK3dJc0RpR0wwcnExRDU5eHZ3WlN6dXhH?=
 =?utf-8?B?NWU2eXFrVjF4ZXprSDJuN1g1d3JtbytJcWp1aDA0OERqbXNxeFdKWDBScDQv?=
 =?utf-8?B?TjN0WUYrdkpzZmdsWmRCR2JjcDdEblJYY0xIVFBORXYyYTlJbUdHbWhRblhW?=
 =?utf-8?B?TDlWVDgyd08rdzk2anUzM0hKUFppd3JEMGxKa041QzJEZU9rVnRubXpyeGpU?=
 =?utf-8?B?eC9NbHpBYy93c2QwaTl6bHB0YTlwTW5Bakp0RkxTakJabHZsS21tY0txT2F3?=
 =?utf-8?B?TnRGY2hvelJxZXMzejBwd3BsRUFUVldKRGhKTm1DNlZVaHR5dUtuTVdrNUlW?=
 =?utf-8?B?cGJXSXk3dlg0dkRzZnZQU3lESW5XR3Q0QW9FWHVLNWQrTFZ0MDRtblluZEN2?=
 =?utf-8?B?L2p4TjVuTU43cFBBbDI5dW9GZTVraHhGa0g4aEZlVTZxSTBOU00xK1FTbU5u?=
 =?utf-8?B?ZlVJNS9oMmU2S3Q1Ry9wSzM3Q0psSlFzSldRbk5VVGl6QVZINzhWSU5MbkpZ?=
 =?utf-8?B?bG5kWUdkQ0hXaUVQZlJsNlE4bnZlS25MK0NzempDdU83SVBlVkJiU1cwdC9K?=
 =?utf-8?B?Um1IZXRXR0FjVjdrbDFNMEFmNkcvUGJzWHpXV0xwTVlTOE1VWEtic0cybFg2?=
 =?utf-8?B?bmZkelRuVFFEMWNJT3Nzdys2YlBMOHBxOVJXaE9ldDIwRXd5WFlvdmQvaGd1?=
 =?utf-8?B?YzVzeitsWk05U3FjWmVMVHdZdHdwZ2kvWnZXdDN4cGw1aU1vR0M0R1ZLOGN3?=
 =?utf-8?B?ZHBHUkdNOVo3cndoY21qQ3lIcFl3M2xTVnJqeC9BaVgrN0R0SE05Rk1nS01h?=
 =?utf-8?B?T0FJZ0lOSW40bGNKTFdEUHdUbHU5M1FjbWJLMDBrQVMyY0t3RytKck9HMVo0?=
 =?utf-8?B?Y2lMdy9iT2V4Z2FlUUpQNVc0eUxnVmNiY0gvWlFWRDRla2lSajB1cUJyREor?=
 =?utf-8?B?K0dlRzZKYk5MWDhPYWtWbW1xSVdjZC9vTjZWVmN6aGR4NWtaeW81OE56RVp2?=
 =?utf-8?B?eHhGMFg2VVc1NEo1azN5dkx0V2c3WkxRd3BuSXh4cmgyVVRuKzFya2w2b3k4?=
 =?utf-8?B?N3MyVFJiN3gzWncwOXBTUEFUeGxXVWtDd3NUekE4NStLd1lyMDR3R3dKNFZk?=
 =?utf-8?Q?fuFeGipsYDsoMq2LTX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ec1ed6-d38e-47bd-781a-08df25d8ca11
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 07:41:54.5240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teLhki380GkGUADrvERUudrf4Wj9UXD2ojB/4gFCtZ+5kL7xGMXxKZowplZCXSg2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999170
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

On 10/9/26 08:19, Liang, Prike wrote:
> AMD General
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, October 9, 2026 12:50 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Prosyak, Vitaly
>> <Vitaly.Prosyak@amd.com>
>> Subject: Re: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across
>> GPU reset
>>
>>
>>
>> On 09-Oct-26 9:13 AM, Liang, Prike wrote:
>>> AMD General
>>>
>>> Regards,
>>>        Prike
>>>
>>>> -----Original Message-----
>>>> From: Liang, Prike
>>>> Sent: Thursday, October 8, 2026 8:42 PM
>>>> To: Koenig, Christian <Christian.Koenig@amd.com>; Lazar, Lijo
>>>> <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Prosyak, Vitaly
>>>> <Vitaly.Prosyak@amd.com>
>>>> Subject: RE: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle
>>>> work across GPU reset
>>>>
>>>>
>>>>
>>>> Regards,
>>>>        Prike
>>>>
>>>>> -----Original Message-----
>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>> Sent: Thursday, October 8, 2026 8:34 PM
>>>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Liang, Prike
>>>>> <Prike.Liang@amd.com>; amd- gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Prosyak, Vitaly
>>>>> <Vitaly.Prosyak@amd.com>
>>>>> Subject: Re: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle
>>>>> work across GPU reset
>>>>>
>>>>> On 10/8/26 14:17, Lazar, Lijo wrote:
>>>>>>
>>>>>>
>>>>>> On 29-Sep-26 9:16 AM, Prike Liang wrote:
>>>>>>> Protect media idle workers with a reset-domain read trylock. On
>>>>>>> contention, requeue the idle timeout and return without hardware
>>>>>>> access. Keep the ordinary end-use scheduling event, including from
>>>>>>> reset-time ring tests, so otherwise idle engines eventually power
>>>>>>> down and VCN
>>>>> drops its profile.
>>>>>>>
>>>>>>> A blocking read acquisition would deadlock with reset-time
>>>>>>> synchronous cancellation of these workers, so the workers must
>>>>>>> only try the
>>>> lock.
>>>>>>>
>>>>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 7 +++++++
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 7 +++++++
>>>>>>>    2 files changed, 14 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>>>>> index 9887a4f99aed..7b10260ad0d4 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>>>>> @@ -114,6 +114,12 @@ static void
>>>>>>> amdgpu_jpeg_idle_work_handler(struct
>>>>>>> work_struct *work)
>>>>>>>        unsigned int fences = 0;
>>>>>>>        unsigned int i, j;
>>>>>>>    +    /* Reset may cancel this worker synchronously while holding
>>>>>>> the writer. */
>>>>>>> +    if (!down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>> +        schedule_delayed_work(&adev->jpeg.idle_work,
>>>>>>> +JPEG_IDLE_TIMEOUT);
>>>>>>
>>>>>> Is there any need to schedule this work here? Being not able to get
>>>>>> the lock
>>>>> indicates that a reset is in progress already.
>>>>>
>>>>> Yeah agree. We should just block for the GPU reset to finish.
>>>>>
>>>>> So a simple down_read(&adev->reset_domain->sem) should do it.
>>>>
>>>> This patch wants to schedule a delay idle work during processing a
>>>> gpu reset process, and then retry to run the VCN idle at the next scheduled loop.
>>>
>>> A potential deadlock can occur if the VCN/JPEG idle worker runs during a GPU
>> reset while performing a blocking wait for the reset to complete. This patch resolves
>> the issue by using a retry-based wait on the GPU reset semaphore within the idle
>> worker callback.
>>>
>>
>> VCN is going to be idle after a reset. The next idle worker will be scheduled after a
>> fresh job submission is complete. Why we need to reschedule idle work here?
> 
> If the VCN idle worker runs while GPU reset holds the semaphore, returning without rescheduling could leave VCN ungated if no new jobs arrive. However, blocking on the semaphore in VCN idle worker could deadlock because the reset path may synchronously cancel the worker while holding the semaphore. Using a trylock and rescheduling on contention avoids this deadlock while ensuring VCN can be power gated once reset completes.

In this case absolutely clear NAK to that! Approaches like that are completely illegal upstream.

The reset work handler *CAN'T* depend on the idle work and so also can't synchronously cancel it. That is an absolutely clear NO-GO.

Just use down_read() to make sure that lockdep starts complaining when the reset handler does such nasty things.

Regards,
Christian.

> 
> Thanks,
> Prike
> 
>> Thanks,
>> Lijo
>>
>>> Thanks,
>>>   Prike
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +
>>>>>>>        for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>>>>>>>            if (adev->jpeg.harvest_config & (1U << i))
>>>>>>>                continue;
>>>>>>> @@ -129,6 +135,7 @@ static void
>>>>>>> amdgpu_jpeg_idle_work_handler(struct
>>>>>>> work_struct *work)
>>>>>>>            mutex_unlock(&adev->jpeg.jpeg_pg_lock);
>>>>>>>        } else
>>>>>>>            schedule_delayed_work(&adev->jpeg.idle_work,
>>>>>>> JPEG_IDLE_TIMEOUT);
>>>>>>> +    up_read(&adev->reset_domain->sem);
>>>>>>>    }
>>>>>>>      void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>> index 17db7264269e..f851a6ecea1b 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>> @@ -470,6 +470,12 @@ static void
>>>>>>> amdgpu_vcn_idle_work_handler(struct
>>>>>>> work_struct *work)
>>>>>>>        if (adev->vcn.harvest_config & (1 << i))
>>>>>>>            return;
>>>>>>>    +    /* Reset may cancel this worker synchronously while holding
>>>>>>> the writer. */
>>>>>>> +    if (!down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>> +        schedule_delayed_work(&vcn_inst->idle_work,
>>>>>>> +VCN_IDLE_TIMEOUT);
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +
>>>>>>>        for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>>>>>>            fence[i] +=
>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>>>>>>    @@ -499,6 +505,7 @@ static void
>>>>>>> amdgpu_vcn_idle_work_handler(struct
>>>>>>> work_struct *work)
>>>>>>>        } else {
>>>>>>>            schedule_delayed_work(&vcn_inst->idle_work,
>>>>>>> VCN_IDLE_TIMEOUT);
>>>>>>>        }
>>>>>>> +    up_read(&adev->reset_domain->sem);
>>>>>>>    }
>>>>>>>      void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>>>>
>>>
> 

