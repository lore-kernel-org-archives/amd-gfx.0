Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC7DD69112
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 14:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE59710ECB1;
	Thu, 28 Nov 2024 14:42:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M2OZEviT";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D3510ECB1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 14:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9YcgPC50aNZ/RS8SdeBX85fl+HhobaYZ0qDILWCz7rkePSaJcpPy0GH5PwSZVKg/3drv+SyxaAEpxU7Ewo4uAYWPljcJL8D0pj14w/jj6E1tzvU4At3xDebU8yYRhhZ+vPhAWq1chEPc998ieC/tl7glzbpxaG8iS3OHVAFwTcYn2j/d5ru48qQdGdwfInsXtPs6m5+0idWIRTfmjeDvfuISJBF3o9v+xiVtGJ1OQuLcmMA+w4dBqEn9N7RGUaMOJdtnUxUt1S6GHuPLs0md+WDwd4Jsy4Nt085XCcVERs7yft+k/LfHpRGhZxpX8dMqxKAuS+zLHlRWvZo3ztoXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3QwsnPfQqa0FGl3jcazIzJpbcEMxU/8PsMTqMyfLeI=;
 b=QWZXmb+6c4gdj7EkXTsj/zAgTjkw8AQBxUFH96GiC/Z++51kRZ3UPHNmRpigtp3YxEdN1Mhs47BrVYWecPum22WJxNNEQHDTePf4n73eHZsOY8WUawJpP4dHDMtTi/Te+hwT+n33+n0hVg9Wo6ZyZ1z6XDNAprGKi+wgeVcT67VB8AkIGAsOwq7S5Kq4Dbs5kjLK48XQrAmJcmgV0ltNXjQPf7yN/EYmsmY6N/6ukQuHkD8YrNPhlYv5Hf9MlI2Zj8VRYaCFKiSsJLhMEvB1UXIdPXeI6gEb7So3Aoukj4rBFY3XtGWDquIhXfA9ARJBJHrywlQGGhGKZiEN23rpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3QwsnPfQqa0FGl3jcazIzJpbcEMxU/8PsMTqMyfLeI=;
 b=M2OZEviTxe3WdUu0np46G5O9Nc4YC02gjmXxU+3X/wwkZCQGpnDJvl2Kq8DeQCakqFrrHO/6JNWFTcKFJhMWwfU7hHPEIRunz5taDqlma2h8Afgm1f6PTsgtASsumF/ihyyUptY13U0FkdcTZgYJA6Q5qYUVzThGzQ184feijBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 14:42:40 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%4]) with mapi id 15.20.8207.014; Thu, 28 Nov 2024
 14:42:40 +0000
Message-ID: <5116ebb9-e0d2-4525-a3ca-ca5f254b3cce@amd.com>
Date: Thu, 28 Nov 2024 09:42:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Use the correct wptr size
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, mukul.joshi@amd.com,
 Harish.Kasiviswanathan@amd.com
References: <20241118053434.3382003-1-lijo.lazar@amd.com>
 <7fb86a69-aa43-41fc-90e9-4750c84a3a89@amd.com>
 <a8cb1cfb-bdc9-4e56-8a11-bbe8f311fe6f@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <a8cb1cfb-bdc9-4e56-8a11-bbe8f311fe6f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0020.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::49) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|SN7PR12MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a501caa-fb0f-4264-07b2-08dd0fbae8bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTBJYWJsZXJOSisvaWlRc0h5dGlQRHRQc3NKdkpHVGNTbmNrWnlzeUJEVkdO?=
 =?utf-8?B?UFJtUFhVWkhxdHE3V0xUaFVRcnN4cFJSOXc5RXZwQnc5Rk5nQno3eFdhSDFE?=
 =?utf-8?B?eW5NUTBOais3clBteHdtT01vYWQ4MGFPUEdNY0RJSEYxR2M0ZmptMHI1ZDlJ?=
 =?utf-8?B?cnN1TjlZRlZoT2NHYzJJcnZJNFgrQ3J6NWE0bUlmS3hFOU9NQ1ZlNzdSaGJH?=
 =?utf-8?B?d0tPOGxhd0h3NmJZYzZvQWthOEFvcmFHb09oakJEZHU0L3FJaVFydm9sMUs0?=
 =?utf-8?B?MzdCQkh1TW9JM0hVNnZ5ZkdEcFQva2l3NjJET0p5eXVaMGN1ckVRN1pZcGV3?=
 =?utf-8?B?aXVBdDM2K210bGVnMDZqbG0wNm83cEtKOFdGM0gzdm5NL00wNnEvWnVtblpz?=
 =?utf-8?B?YzFCUWZ4eFZEdEFvNFNKc1lrN3R5ZEtUeUYybUZsWXdvR1dvRnQ3SThLdE9n?=
 =?utf-8?B?MmJ3R0FiRUJQSTJpVmw4SVJLbHVkeHZITFdFZG9qNGV3M3RMSTZ0Mlc1ajF0?=
 =?utf-8?B?andKejhUL3RrUTd0OTdJMmMyRUhaOVRBUFVCSDF5aVdPcm1ZVkhRV1F6ZmQ2?=
 =?utf-8?B?Y0cwMkwraHdjdUU3eXRucjFIdDdnblljYktQakE1VnJGdWg4SGJIbjVUVHhO?=
 =?utf-8?B?S1RydFNXbVEwakRHcm92YUd2aEdDRnRQUDA4UEt1dHJoQmdtTGc4NzdUOEt4?=
 =?utf-8?B?cVBIQy9lWXNhMjZYclc1UkFtMzdoWWNXWExYS1gwY0wrUkl1NjhvdHdJSDFn?=
 =?utf-8?B?V0lkQzJ2NnM1dUk0SFFRNzJCdkc0RUlyUFNLUzN5U0RPRmx4bVhucDdaRG5t?=
 =?utf-8?B?anIvaDdUaDB2SEZuOGJuRVgzZXI3REFxejJUcU5pN0VSTndYN2JvTldxZ21M?=
 =?utf-8?B?dWU2SmxJR2w2R0QvVkN5Z1lOd016WkJEdlNuVzlCQmprKy8ySEt6ZFFaS1hK?=
 =?utf-8?B?TTg4K0x1ck85RlJvKzVBWW9PTDRJam4wVmZIaktIdlVNMkdDbmFzQzcwYklV?=
 =?utf-8?B?SW9EdXoyZXB0dnBBb3YzVno4TnJOaTdpWk5RUlViMlIzMldMNjAzQzBPN2lS?=
 =?utf-8?B?NDI1b2NsaVhxaFlacXY4SmRMVUMvZTZkcTNKS295OHZHTTlqSkFrd2w3ck8x?=
 =?utf-8?B?ZkJnYlQ4NVFRNm1iWURjYkZkcUpzc0dyM0Z6Q09pcXpjZ3R5M1VjYXpNVnV0?=
 =?utf-8?B?NDNTSkJpNkNlbmtCS25yNll5bSttVSswTDZFRndEZHZwZEc0TkVEUmNVWjla?=
 =?utf-8?B?U3RZeVo4ZDIwdnRQS0RLVnhVeTE4dG5ML3ZYZEJSUFhSNHljY3lYOHhYcWd3?=
 =?utf-8?B?NEJjZTNYTmV4dm9kSUZ3RVovTGpRMnpVOGkrU3VYNTM2WityVXlWSlNEWW1w?=
 =?utf-8?B?QUtzSmdyc3hnTjQvamJ6bkFKRjZ4cmY3Y0lGYmEvdEM2Y09VZFF4bzN3Qnh3?=
 =?utf-8?B?QzVqRTUwQ0ZVMFV3VDdvWEo5MkUwamtpRldXc0tyUGdzaHVYNVVQZk5oMnVk?=
 =?utf-8?B?RnJ5T2pUNTBUeUlqUUZBZ2l5NFRRVkhTWmFVRTVsdG1aN0NSdE10STN6YnR0?=
 =?utf-8?B?THFDdnhjdWRZOFp1L1c1REJKa3g5QTZGVHQwSW5VV1o0SlBjZzh0YmxqNGtQ?=
 =?utf-8?B?Tm5NbGQram12K25kZVNXbFpYMTNiUXhvY1hDMlI3TnJSYlB6OHlzV01tZnVZ?=
 =?utf-8?B?bnJzNWJZUGhpMWxZVHV0VFMrVU9vQU5OaDhKWXp2QkRrbjlpdlhycnlocmtk?=
 =?utf-8?B?MnFuaGthWkdybXk4YVQwdi9taXlHSWx1YkdXZUFjOVVrSlRweUNKb0hJQWRu?=
 =?utf-8?B?VlI4SHdnRkdxVEZEdC83QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEQxRFMwZE4wQWx0bWlKRjFpRUV1dkxYNkx0c2FXMjNUWmUzNU5lZy9rZ3hT?=
 =?utf-8?B?VFpXY2ZPcVUzZWV0RDkwRVdiSlVQenNmYmlOOUY0Q2F3R3hiaDFWSWd5N0lr?=
 =?utf-8?B?eENoKzRVUERJMmJJekVsdDRQNWF1TnhoSmxQYVAvQXhyNTdiZVVPSm0vTzhG?=
 =?utf-8?B?QVJ4QlZHaER2MGI1VlIvYTcveFI3eHg1amxlVTlDQjMzclppTlQ3UGJCdTha?=
 =?utf-8?B?Y0RwWno5ZTJZMUVxL1FnbDlCbDBETkhVNlIwa1djcHJKbEFBRjVUMTVFU1A0?=
 =?utf-8?B?UEZyOGFURlpXZUltdHZ3c2tCUjRmQXhOSEZDeThITmJ6aFlBRVRnYUM1Tmg1?=
 =?utf-8?B?Ni91RWZIM0xDR2RLTWRyM1FqNTF1Y2xCRDdRWlhnTHQ5akVvQ1dFQkZseXhx?=
 =?utf-8?B?V3ZtTTFkSUNORHY4M01TRXk2UUFuTzd4akM5ellETVVaWm9UaGo1cU1qUHhz?=
 =?utf-8?B?VGdueVRud2x3R3pCUjhZdWtJL3BabGl3M21mYmlrMGFybERuNk9UL0o2Z3Rn?=
 =?utf-8?B?UXFRZmt0WXFtVkZrYU1mQnNWUk96Z0lVWjc0U3ZlTjFDQVAvZ2VGNDdnSVZs?=
 =?utf-8?B?MjRnY2g3Snlmc3gxRTM2M3dBNTBwN1duNFJweWtkL2VJcUFZWDFuNmh1cUxj?=
 =?utf-8?B?cnJGdjRsckltazd6TDJnK3Nhd1d3QnlnT09oYXJNTWRhTCtkZk9Cck96OHVK?=
 =?utf-8?B?K3JYQXYzM0RZS2R2bHBIbU1nRytTdFF0Snk1UjNTRkZQRS9yVFpURVhkZ1JX?=
 =?utf-8?B?NGc4N01paFN1YmRxU3N1cnZXMHNjaFBRQ0ExcXJPSXRtVGQzdms4UXBoejhJ?=
 =?utf-8?B?UVlOcDNIa0FIMWMreGQyRUx3Ukh4bDFqN2dLVVBYZHozSXNLM2FZUXlmeG5u?=
 =?utf-8?B?S3diUjBXUGhrQ0NleWpIV1hlOXA3eWE0SkQ2NGlYeXZGczRPZkliK0I1WW5W?=
 =?utf-8?B?NVd1S0JSOGdRYlJEVjdtd1FiRDdrMTZyVEY4TlVLck13QUVaOEl1dExRRTd2?=
 =?utf-8?B?SHAyN3BoQnNQRDZCekdvajVXZS9NNGJ6YTMrMUN4SG1ENjkrOGNxd2REeits?=
 =?utf-8?B?RXdESHlBUERMeUxsbWh4aGZKYVFKWkRuMHFCRFRzN3o2TGc2TUlzaWl4bi81?=
 =?utf-8?B?enpxY2ppcjZwMEVlSzk1VXltL0UxRllUZ2tpQU0rZ1FyTGlmeEhvNUIvYU9z?=
 =?utf-8?B?OWZQVmZHajVDVVFLUnRqdnQxKzZvWUZXQVYwSlhYSWlMN3NFR0MrZzZFaE8w?=
 =?utf-8?B?OWZqTEFDQTVySUFOZ1dVWTJ2aVVuS0tmOGRCWGl0ckNFcGFQdXprTysySFND?=
 =?utf-8?B?clpid1VUMHN6T0JSRmtabDhCcnlPd0dqUGFqOHBFNTVvRUQ2TUx0R0lTVXpz?=
 =?utf-8?B?N01Ldk8rOHZHWWNpaDB0L2hpb3N6UkszR0hlelZ2MnEzM3lGcll3U0JidkZw?=
 =?utf-8?B?Ris2MExNYUdCd2xpSmVaNDFhcDYzdWE5TDk0NS8vK3JONFFqNFpOc0hFM3lL?=
 =?utf-8?B?eHR3d2NtUmYydXlsTHFGYjJEeVJibERCRWRsS3IrQ2M3RUE4SGM0dWFobkU3?=
 =?utf-8?B?dzlGRXU5ckVUeG16QU1XTHBkb0EvZG02VDkvV3V0TE5LK0FpNTlMLzVyOEl1?=
 =?utf-8?B?R3hKR3Q2TXNXU0lIWVl5VHVaV1p6ZTJCekR5eVJXcjYzWFBjSFFDRVVxZGZK?=
 =?utf-8?B?UFk2eUZwSTBjdkhPT1hWeThHclNNMkZlOWl6ai9ZVTA2Y3dhaldpWTFzN1o3?=
 =?utf-8?B?RytaMENvMmJxTmVVbTJNQ3RnRTNNcXZTUVNHbWQrcTlnblZwODZuRTB4NVUr?=
 =?utf-8?B?elgvelBmQ2lnK1ZOQTErRlZJN1VPOGhSVW95SFRMbVFaUnp4NlFHSDFjMjQ1?=
 =?utf-8?B?eXNxVWNxTE4vOS9sUVpjeXNNYk44ZURTV25mRzFUYzVHUmFmRkprQ0NRTVdv?=
 =?utf-8?B?cExjM2hySXlDcG15VG9jU28vWnROTjkrRVorRGVOeDU3eTVIV3VlcmpDY0Z6?=
 =?utf-8?B?VFluZm81QnR3eldIbDhPTzRJUGpyU2NXcytONmF6WnZRWEx0aWFKN2JJNzJ0?=
 =?utf-8?B?SFVNTEQ5NTVLelhoNktBdmxNTFFNRmVGRHB6eWZWRmFyY0VFRVY0MVJ3T1hh?=
 =?utf-8?Q?6Qq91svUsOWHQVS5TjybNZmIB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a501caa-fb0f-4264-07b2-08dd0fbae8bf
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 14:42:40.2167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gq1EtEF/77wEvB9n6ncYmMEagmAHJbOCbmrYOAw49LGIEezBWTvCIiCfx0vHT6Rvc0JW+h5gewLE1GiJPpWf+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790
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



On 2024-11-27 22:45, Lazar, Lijo wrote:
> 
> 
> On 11/28/2024 5:43 AM, Felix Kuehling wrote:
>>
>> On 2024-11-18 00:34, Lijo Lazar wrote:
>>> Write pointer could be 32-bit or 64-bit. Use the correct size during
>>> initialization.
>>>
>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/
>>> gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>> index 4843dcb9a5f7..d6037577c532 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>> @@ -125,7 +125,7 @@ static bool kq_initialize(struct kernel_queue *kq,
>>> struct kfd_node *dev,
>>>         memset(kq->pq_kernel_addr, 0, queue_size);
>>>       memset(kq->rptr_kernel, 0, sizeof(*kq->rptr_kernel));
>>> -    memset(kq->wptr_kernel, 0, sizeof(*kq->wptr_kernel));
>>> +    memset(kq->wptr_kernel, 0, dev->kfd->device_info.doorbell_size);
>>
>> It would be safer and cleaner to just initialize kq->wptr64_kernel,
>> which is always 64 bit and aliases kq->wptr_kernel.
>>
> 
> It's done this way because of aliasing. The size requested is
> doorbell_size which could be 4 or 8 bytes.
> 
> By safer, do you mean to have an if..else check in case the aliasing is
> taken out?

Cleaner because the size of the memset would match the size of the variable. And safer because it clears the entire wptr, regardless of the doorbell size.

That said, it doesn't really matter because the whole kq structure is allocated with kzalloc just before calling kq_initialize. So maybe we should just remove all those redundant memset(kq->field, 0, size) calls.

Regards,
  Felix

> 
> Thanks,
> Lijo
> 
>> Regards,
>>   Felix
>>
>>
>>
>>>         prop.queue_size = queue_size;
>>>       prop.is_interop = false;
> 

