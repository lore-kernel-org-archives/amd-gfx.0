Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5A3ECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 13:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B86910F20B;
	Mon, 29 Aug 2022 13:13:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2603810F208
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 13:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOB+c+YfZfG4ArzhqFVYggiTjwDkzkkcXWsOXZagHNNEc41jId4zjUXQ3wMx7uGEsp7IRa9rZlOI3KGWdLOldw4mljln5Aul1MZtsdRUCitSgb/e4omdgjWhjNRSEUQemwSzXU8N5i2GXwVojMZg6POrgsY/IX8hW+ifeqem2dFZB7xWXjzYLsCxmEYc52TAXyKvO52toiD14hO31ibIyBHEION/63Ns+/xHcdpKRIpdHGcFqXucJjUHhciVowWwos44HSVXe1DNL2hNWMySHNG8JT0UTji2PDGVDDt8C2g3oY4bvE4H2mFaZl7bUm+H69xJia/S/Bv/kl3j2WVYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/JaJCKXjtnI73cAlrVebdVyN0yg0lD3Xxogm8qJFoc=;
 b=IkMFUAk2fElJlj+tLp+z4eh4XhlC741z8FFcUqsxvsLbwmVbuNs3qvGo2TLEbGVJxLH0p4Lx7q4tXZEshQfGKz78NB+luMsvhAIUWe573MKdyg+Wrp/TdOPekjUD2St17uqYV3UGZZQ5ZpPZ2yPpsvrNZk0ZmzWB799Z6Tnj3eXOA3v+Z+DXujf63tiLlY3sm+WyvPTHOtw4EHG6FHyG2aSMmruxiaEum4bCe1DK6TLmknhjPCuvVQYWN5lRqS2pCJBO5eKVTGOCav/ygbXi8CUNqj/GkMSJc1c8jboWisBPTdXwnYLe8WvvPMOdifKMnx29UNtskXoIkzqqQ0LLeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/JaJCKXjtnI73cAlrVebdVyN0yg0lD3Xxogm8qJFoc=;
 b=JbS7lVz5LE/0WvKqk77mLBrPOAjmXd1ou+25LIJ7rs0mn57VM5I4yKbVPNVxEKbcnsjlfrIT72XmcGzRw+uOq7kgVS/NC9Uy0bl4ZL4JoC3M8sl8OAoux31oU3I1+jezUp3vzVnvFP6LEDaIY7iQ7G5mgqrcZHgapLe0T2RpoxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 13:12:54 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 13:12:53 +0000
Message-ID: <02f14828-f6c4-7f1d-8c93-93266c6609fc@amd.com>
Date: Mon, 29 Aug 2022 09:12:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: ensure no PCIe peer access for CPU XGMI
 iolinks
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220826154752.10984-1-alex.sierra@amd.com>
 <ca7c6e23-2a1a-2bed-7ae8-6a5092cb083d@amd.com>
 <877fa64a-10ad-9ff2-11f3-9a47174552b6@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <877fa64a-10ad-9ff2-11f3-9a47174552b6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce5f998c-b982-4cbe-b848-08da89c02e70
X-MS-TrafficTypeDiagnostic: PH7PR12MB6442:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T9kD7oocs9yfU8cH1Fia3CJyjHvGMQCDLz5mNC5lsq8OzgQE0h0KfL1vVLxogOaqG7NmKo2yt/vCgrRZMfBNO4XrtWFV8CcQ78IuImFna3iOprOJNJrkJsull0ALnuFaYUez3SwET/pH8S7rhFKz7ZHDwXGTFKNO9c9nyvK2aOzV4pCBSiTRqhIHHLpveDCwJNZA2EnuVw1hmOA2xmXeoLJXbkWCNguCqRdVQySCIfNd0EvC2dek6va7aUcS3vqp5iY+C3DaYkiE5sBnjIyiRtwDQrUqaxuE95Sbq4RcTXpmP8MsUWzUj8rUmGWeD/m7NLzhehCs0d6e/dDndl23qcPfzomySA9l7iyzkTD7nm+DMdgaRExnO59vr+XWNxwXtYJ3prL/4QALZGkfUvDZ7rao5HaYltDMQh5Mir2+BMPmq0pW5eaxKgQYsbtQ1C2SOouLuZ0dusZzEYZt9a72NNXw/Chfo0Ghn7jZDux8NGftQ0NZhV1+kHk0e9xs3I751sEsvzCzBqngRRVRyKUTN6MXatiqRZu8QQCdUPMoU17W422PlozlHNSD9ouUsopbF6Tds8DItQZyJk0fKGRCRv5lIf88OcW5UDwyRUeQO2tv7wJgGmYAx3bpeyspymLfKw1asQjgkxc2o8AaqmQ+RMTGC2IDg/hUMNAAnsyaXqSbbAlSG5DxVBL1vrCRiMe3Y1X6bv2dwdwNIJ8PknLDMaoHk95Hkcj9OX1bOz5TTU25hc7ktWyxFskmWTGl4JveElTXKedJbmMp0x4xp6bnD0cHoq1Cwddu62BHj/rC8Wc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(31696002)(110136005)(38100700002)(36756003)(66476007)(2616005)(316002)(66946007)(86362001)(6486002)(31686004)(8676002)(66556008)(66574015)(186003)(53546011)(2906002)(83380400001)(8936002)(5660300002)(44832011)(478600001)(26005)(6506007)(6512007)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFVIcG5DY01HQnlTUmQyaU5OU2g4cFdPajM4Vk5YTmlLaWNZOHJRVTNkMmNU?=
 =?utf-8?B?YTVvVzVuT3FXbDFrc001MklmNnZSVlA4eU9kU1JndEcwTDBhQXI5aXBVTjY1?=
 =?utf-8?B?QnVtQ1VCNW0rSVUrdEk0RGhnOVpLK2Z4OEFpYnIyQm04K3BCVzdvK0RuODRz?=
 =?utf-8?B?VklobkNYei9CQjNBalFSenY3QnhwVUJQUHhwZ2h5YWU4UkdYMnBMbkNTR1NN?=
 =?utf-8?B?ejYvNlRTSW1MOVVXeWJRUllEQW9aWU1XZFE2YzFTYklCdVZGT1QyZmRxRyth?=
 =?utf-8?B?SXBaUm9XMXdQdVdxdEhQZXBZaXU4eEdCUXg2YzJMTEtKV24yaTNYUXRnT2NC?=
 =?utf-8?B?REZtMlZKdDlnMXdNVnlZUG42N1J6VlFSdjdNampDYWhXQ3RLeU56RURHQ3pV?=
 =?utf-8?B?N1NCUFRnNHorVXlPbVNrTFFwOFBybXBBMGpuNFE0bXptQlZxNkpLd0JsN1g3?=
 =?utf-8?B?U3FIV21FNEtOMnJLMFhxaENJdXBobWRuN3Uyemd3RXNsOWJTbGp2M21ETUk3?=
 =?utf-8?B?dlE0OEhGOHUzVDNndFVVRnBtZE5jMjRwSkVzWEhmSjFjbnVPK25BdlBwaHRW?=
 =?utf-8?B?d0F2RjJsd0MwSjZTaEQ1TGtwcXhVUWZPKzlJbXl1bmVOdnk2V2pvVnlGdVVi?=
 =?utf-8?B?dDN1bW40NDE4TVBndmNDeXU5QzVHSmZQYzVYZmlXUjlKRGlSU0lzQStUeE9G?=
 =?utf-8?B?dFBEaE5NcGU0RzhpV0RRTjlIZlVOeFQ0M0pIbE1uZ0h2L2pQWFg0eDROYXQ5?=
 =?utf-8?B?Y1RwQnpEMlM4L0tDbzVPNXlQWHQ0ZWN3SHM1ZUtoVDIxQzVaSmtRc2xoUDVB?=
 =?utf-8?B?WWZBZXV4VDlRRDA5aGluaEc0L1pmZHZmWFVHNW9STmtWUno5ejdrYlA0TUdM?=
 =?utf-8?B?aUtJTlVIVk81cis4WjJFU3lRRkZMK0dkNnFwSjY3ZDlLbEkxMEczTUI3TzBt?=
 =?utf-8?B?SmFobnB4MThDeXg1QTdYRjQxSUdZYlg0aWs4QVB0OWRNNnVvcVZSUmgyQ3R5?=
 =?utf-8?B?cTV1SlpOcFo5VHZlenVnUDFoa2JBSlRWWlptdTV1TnpZd2ZDSHF2VnRadGYv?=
 =?utf-8?B?MVpkTndobzRnR0YwQ2dvWHlVSGRuemlhMHRrczN0WFg5MytnVG93Q25vN2Z3?=
 =?utf-8?B?ZGJ4aWc4aVR0NFNZYzZNa0hPWmIrNkVkMEJOVTdMUTlPRGJuZmtnc3hpVHpv?=
 =?utf-8?B?V3hkQmxRY2lPbUxHNGttMlRkbDlZUU4zY09Ud2lLcmU4bUtYNUJGOVVMOG9D?=
 =?utf-8?B?aHAzUmx4VHBVN2VTVmdnb2NZWk1DenI0UlZ0RFZGR05zOWtTeTNsV2JQMjBz?=
 =?utf-8?B?NW5jT0JKNmhNVWVUSkZYZDB0ai93c2ZOb2huY1l4Qm04SGtrRVRPUk9ycGM2?=
 =?utf-8?B?dVF4NGx5YWpZWWVZSXFpUlVsMFdsWTdQajFIYnlJbE5YelEvZzMvMGpMdGQr?=
 =?utf-8?B?OTd1RXQvczhGa04xYXNoYmtqODNVOGs3cVYxSHFOTjU0TFVPR05ldXgyQU9p?=
 =?utf-8?B?RzExNE9PQTdwdnNueXZXVCszSFVQZEEzWVNnS3dtL1NLM2RZbGtOSFk2eFo3?=
 =?utf-8?B?eGw5T3labncwR0lLOVFnUUNJYUFUUUFscktkTEtWY256am9BTTVOdlRtQkFm?=
 =?utf-8?B?Z29lRU1CaEhrZXJtdmVidFV6Nk4zWmJKb0toRnNhbzZTak54a2FuZzAzaVlh?=
 =?utf-8?B?NnNFRm5HQjV4QWg4d3ZHZkdZWHdOY3pYdTNQS2hkK2VUVnFqdllIejdmLzJH?=
 =?utf-8?B?WXZmU0prVDBHQWtTYjdOcFN1QmVGUDFpdU5jUnhrclIxemFLeEF0a3ZEeE9l?=
 =?utf-8?B?ZnpLcVhySXArOW9ieXR6T0dNV29QYmhNK0FzYndzWGZDUHZQTzA4SzBsZjg0?=
 =?utf-8?B?K3M3UkpJeHJUbXBDTFNyb3lGU0RWbGpHNElUdWxNNC9vdmI4R3U3NlBNWGE2?=
 =?utf-8?B?ek02L1pNNmdxQnNtZnJzMnBWUnFQOHVuTWZMbHJYMGpuUCtxVWJQdVRiY1dp?=
 =?utf-8?B?OUhBVzY4Z0FuMlBHRVJMS3hxRTVqTTJCR1hlVG84WXNxMFYwQ3BJa0FRMTU0?=
 =?utf-8?B?eHBsMEJERkdLTTRrNldNLzQyVk5IYm9sWUZ6RGpCV2pyK2RYSWdhSDRDanJT?=
 =?utf-8?Q?Bp0V7741ZmVtYBIR3Yj1TlGKt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5f998c-b982-4cbe-b848-08da89c02e70
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 13:12:53.3774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rS7MumwDLgdzCjgIXqN3zTP59nNY2teBuhbdZnotMIm9b8EK0Bmzs+IRowGxcVk9SpVpX5FFIs4A4UkpsbcOXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442
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


Am 2022-08-28 um 11:28 schrieb Christian König:
> Am 26.08.22 um 23:49 schrieb Felix Kuehling:
>> On 2022-08-26 11:47, Alex Sierra wrote:
>>> [Why] Devices with CPU XGMI iolink do not support PCIe peer access.
>>>
>>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index ce7d117efdb5..1ff66718639d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5538,7 +5538,8 @@ bool amdgpu_device_is_peer_accessible(struct 
>>> amdgpu_device *adev,
>>>       return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
>>>           adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
>>>           !(adev->gmc.aper_base & address_mask ||
>>> -          aper_limit & address_mask));
>>> +          aper_limit & address_mask) &&
>>> +        !adev->gmc.xgmi.connected_to_cpu);
>>
>> Maybe it would be more readable if you added this to the 
>> initialization of p2p_access. In that case you can also save yourself 
>> the call to pci_p2pdma_distance_many and all the aperture checks. 
>> Like this:
>>
>>     bool p2p_access = !adev->gmc.xgmi.connected_to_cpu &&
>>         !(pci_p2pdma_distance_many(adev->pdev, &peer_adev->dev, 1, 
>> true) < 0);
>
> Yeah, agree. Static checks should come first.
>
> But another question: When we have an XGMI link to the CPU all local 
> memory is directly accessible, isn't it?
>
> So the PCIe root complex should be able to allow PCIe device to access 
> our local memory, even with snooping.
>
> Or do I miss something here?

This patch is meant for the case that the module parameter 
amdgpu_use_xgmi_p2p=0. With XGMI disabled, I don't think PCIe P2P would 
work on this platform. This patch will ensure that we don't report PCIe 
P2P links in the KFD topology, and don't attempt to create PCIe P2P 
mappings and potentially DMA mappings in the page tables.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>
>>>   #else
>>>       return false;
>>>   #endif
>
