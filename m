Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFA7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 18:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D07810E7DE;
	Fri,  7 Jan 2022 18:59:23 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DBCC10E7DE
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 18:59:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OD7UtyQxHz0UbwAu/mI2jramaZVjbKzRZOxoswIgwskHOCJxw4Cm/XxeT6XbUAHJY4LBBxTjclts6PxTvEgIT8XSrNAMwb7YHEjMF2cQ9pnOT3cisUZhwmTpip6hR8ccCGdf4ZJL1t2z1Z4kNFkKbO9dE7G0vtGVDA8Vv1Hs+1c5MhzlVne4XsDbN4QBKha2Y7dJiALZNcFZi7VWwb9SxFKbb3iixZE1aBtDmtAKcR1N9SxFVDkaPBHS09zcQ0qyBGpqxxpNbPmvz/LNseGRmopLnPiyJ4s+IlM3iYlj7sYLgAVGcdUnpMlUTBpV/eZ+1JuYo3SnIDHqIQVcD1rJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+vZIQXujLrn65E4FetdPr0rjiT39L4oT44fSF6s1Ac=;
 b=eMjK5VJvXHJTYc9zQ/1ICl2wACCiA/hLPZLNhwHOh28cW/5bbDcdLdcGTRI0l/DUhchan2AxHVFTsiJqVWRKo9tDpl3Quk1FemSC0Ty8Vg5eTy5Zvr7S6Bab9XytIJb//BoCSmOll8gbRGROXKIt9YLu01edN/iInAjgVzfFxOq9K7VKQ+6WAvo0eFv3qvZ4w+RbGZtWD3Ovt3PRK/0P3BQJh8rRmSBuzfyN+tOd7KM5JNtQD/3nx5bMMOxT+T3WepRZM52SZxK2SVszpCmG3ARU4kDBaHYYlM5ma5wATjEEhsFOaVURTejS0MXXfNMxF2jPHvseszk2pLJ/IHL9bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+vZIQXujLrn65E4FetdPr0rjiT39L4oT44fSF6s1Ac=;
 b=XEYA386mP5MWhJ5tsqB3gzUnocLU+13ELrktSWH6MXyGNC/M/tUBAvWnUWN1yrVq6CiDQEuD/bIuOryffdzd2jNrhx0Wj8QFAGGVBgDMzmgHgSvvLouV3sFXp6KRCqN3iqX9A7yCs9xkp4RC2YWSyJxlIIJiQ8shmo2WmNzj3Ys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (13.101.157.78) by
 BN9PR12MB5308.namprd12.prod.outlook.com (13.101.158.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Fri, 7 Jan 2022 18:59:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 18:59:19 +0000
Subject: Re: [PATCH 2/4] drm/amdkfd: remove unused function
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220107085115.8820-1-nirmoy.das@amd.com>
 <20220107085115.8820-2-nirmoy.das@amd.com>
 <4702ddb8-d16b-c330-db7a-d3eb18c9693e@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <51772da8-e937-9cdf-4345-284dadc42ca0@amd.com>
Date: Fri, 7 Jan 2022 13:59:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <4702ddb8-d16b-c330-db7a-d3eb18c9693e@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f58251ae-8077-481c-3974-08d9d20fcef6
X-MS-TrafficTypeDiagnostic: BN9PR12MB5308:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB53083BAAC00174DBE39F3428924D9@BN9PR12MB5308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tjtSdPq4hYrPexg1rIvgM1IEEo2ceRe2bGSMM7DffDEQoJeJVoEcBZgKfgp7+6OvdqU/HVyp0OTZ88aauzH2xx2hJYzaeDWRIasJW/QudG/3HcHMbBZLDhPnRW3/+LASubeaEXBdTiLUVxgCXNOPmxzyhx8Y7/HlerV7KK6UKsHdnq0W11wk7Lu1qUl972iJ8TlS22LQXF8dGrKXZNz69y6WyeWpG+Ly54nDOBuEG3M7TFVfjm7+Ewe/5E+D8geRIrFv7vqbzkm3m93HSMXBe13QFjlkBvdhctrahos3VFjvZ3GY+owj0DnvqyINPRzavz4NVCLF/J9dwWfhCffPufhaLDy0WZQyyarbu8/AF+DXyVlHjFJMD21pQcMTHbxbi3yB0IGO5zFJOggj7R3Nv1Xq3AcSLxOE2pRZEjqM3DDuWibbdzxu0qgZMtqyAGHzypnOwm1yTx8du07eD8m4DoAYOVL1lpt+Ws8ejTBvndJz8HNP2/YFiJX3U7lR5PNsoONRhYhts0sD8GoRgzPca/IyiKZXFf6BeRNxEJEU92ULOXwZ7M2n7in5QdTJcIzYgR93CVzUVaamitGO16fp9O8PbtyupvxAmDWjifk7doQJqa3Nc+B8U2ciDkgJZg6mH1Lz7sl/tn325quDlrz9K27T+rOzTI7DFky+W1ijHc4VxwWSqVAUpgR7ru0FoHdZzwV4CS77BUwSx2NTpEuKJaC7mp+diWIfA2LbVeGh/mQj3rv/q5FM2w5oACQMe2qe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(83380400001)(110136005)(8936002)(6486002)(8676002)(66476007)(31696002)(316002)(31686004)(508600001)(66556008)(44832011)(2616005)(66946007)(4326008)(53546011)(86362001)(2906002)(6512007)(6506007)(26005)(5660300002)(38100700002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akFKTyt2cmNGQVE0NkRFMmt3dmI0aytvSm5RbDFYNnpjNi9aWjRiZVBPN25Z?=
 =?utf-8?B?K2dML3oyd0FoSVJaYTR6YXhSNVpCeGdxWDlZSHp4QlVTWjFVVXRoaEQvTU9i?=
 =?utf-8?B?VGU4NDEyRkdXQStqUlA4OEpTTnRuQ0M1c09LUzgwbVJKUHZtamtldUxNaTUv?=
 =?utf-8?B?OTh4WTBGRkExZE9Ed20yb2tGZEtTaldHNjlEL2x6cGlZeTJKZU4vMlJ3ak0z?=
 =?utf-8?B?T3lZNWFaL0lKSUN6Q01ZSmxVM3hEckY0OUo4bEJFanFnczFYZUlFMVdkYXFB?=
 =?utf-8?B?dTJNV29iaWk0QXVLV0hjZC9RdGVVVE9iQzhsdzROWUN5YkpGamFhYVBySjZL?=
 =?utf-8?B?MGtYemM4bVM5NWtKRzVtcUExdGdsWGs2WGh0ZWpPaXl6MHFaZUI1V21LQWVB?=
 =?utf-8?B?WEhJMHlyUEFieFdjenNrQWFyL1NRNndpVTFyYTU3UnpmTGxmOWI1RTBEYUFR?=
 =?utf-8?B?dHd6RkVWdUdaa01CU3pYUHlZWFZkUW9qWlF2SlNLVVd5bWpQUEJWaVVnZ2lI?=
 =?utf-8?B?TVpieUJRazlNenFlaGVzRHV5OG1zM0s4cWIwdlB4aWsvallLNmk3djRWcjJE?=
 =?utf-8?B?dGFDQk0yTWF2VmdlOXQ4ZlFBaXJFdDhoWUU1czF4cWhpR2VGbHpqRENrdWhn?=
 =?utf-8?B?NmhTQmlrM2tKbitGMWNyWENtcGdQTHFqdXFTWTBqcUtOalliRTJxZSs0TkpB?=
 =?utf-8?B?d2d2MThpbCtQSGx0czhMTUNHUUFUOXVGYnNCREowS2h0bk9MdnlZRWFCVXVC?=
 =?utf-8?B?WGN4eW9NUSsrbHJocXpDcmxmZXRrV01nTHNmTHJMWjFuSmczVUluK1JsbHUx?=
 =?utf-8?B?bTh6ZUc4OWsyVk9XLzZKditaWFM5aXNsOXFncTM5ek9IdStzUWZ3cWQyT0VR?=
 =?utf-8?B?eDJDMTRaWU1wWDZlbkhyaGpNTjIwMDNWRHJQcVBCTDgvRDZmT0d5R3N5YjEx?=
 =?utf-8?B?MTBqdm1oM1dYd3R5dzVnMlphU1dEei8ybzM3NERpTDJiNmIrcmhRL1ZXcXlB?=
 =?utf-8?B?U2hnY2Z0T1ZHYUc5aTRwYXhuMzgyRUI2TXZYZVZHdEJ2ZU5MYWsySGRHdHNO?=
 =?utf-8?B?ekp6MHFMOXR3NEkzUGtOT3pNc1Y4OTNnUmZueEJzbHBoQTRuSGMrMHB3bVAx?=
 =?utf-8?B?SmhOeklxeGF2MGxkTFQwYXBSby9OcFJ1NW5Faktna2tnTGI2TjNtQWpZWTZZ?=
 =?utf-8?B?Z0VSdGhBejVPRXZLRzNnN1VZKzZBUEpGM09Xc1c1S2V6dmVZUjhVR3ZjdkpV?=
 =?utf-8?B?Z0NqeHF0V3hYdnEvV2ZYSVphYXhWeENWaDJwVTlaVVBRb1AzaWk4TitCTjUv?=
 =?utf-8?B?N3gxb0x6dU9rRk9xV2RETlhUM3RnSXJTZTRYSkJhVEFwMmhzZUUvdVFOL2VQ?=
 =?utf-8?B?bHEzcWdxL2lOZVFmaUNvajVlWUh6Zk9wOVdGVUdHMEpmUDRQdm1xWEhjcWZm?=
 =?utf-8?B?WDlSN2ZMVWFocE95M2VqTGE1RXNwbW4vcDU1cGQ5bG1FTUloak1WTHorK1or?=
 =?utf-8?B?cTUrSW9ES0tteURxMEd3dlU1SFZVV0dlMU1iUGlQMVpoZzJYQVBQN2k0Wllp?=
 =?utf-8?B?RmlaamVtbVBoMWpTZE93WG9PNS93VzZPTE90VnhMbnNpRVdMNUxUa0hTMXVW?=
 =?utf-8?B?NVU1U1E5YUZwcnBQMm80dHlDeXRINlNvNjJCUE5iOEhQU1Y5L3RDRG42dGhh?=
 =?utf-8?B?K1RaS0p6bjlSTHFkSXJQZWVWbms4SS9CTEdsSml4TXV0bVZlNnl1N1BRUFlK?=
 =?utf-8?B?ck41Wjhvbkp5WFVvYkFqQTVBN0NYUWorbFZvT24vaFM0WjE4cFp3R0JhZjNs?=
 =?utf-8?B?V2dNekVTK0tLK1IxUkEyNi9ZVVczMjBCU29INmdIYTN4aWl0bVdOUWQvQXR4?=
 =?utf-8?B?TW1KaGc2SjduM0g3OHg4eTY4dGFFTy9hV0VScFdTbXFZVkRwV2Vvem50MktO?=
 =?utf-8?B?a1g2dWdoRlFMN3E5NGhnL1A3NDJQaFl1TkFZL1h3UXp3NlRZZGMwNkRJRFAx?=
 =?utf-8?B?dWFMVDlBSGRWZjBQalhMcmcxckM4eGU2UVEveW0vR1phUkZYZzRMeTZBRVpk?=
 =?utf-8?B?YkRLa0xsVzA5Wjg2amhZTDduR21qdHl6V3BNT1ZWcEtCbWxadHR6M2pjZ3RM?=
 =?utf-8?B?cEc2NzJRWnprd01pWGtFSG51YTdCd0tBcFF2akNsS05hakgxdGZZK0pQTEYx?=
 =?utf-8?Q?EdBrze0WiWalBRRIEdwmVgQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58251ae-8077-481c-3974-08d9d20fcef6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 18:59:19.1970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2tfNA78rM/zkt1phnD+IQNVv3DNjTuyMsgcXil8HzmoeHY/aeexeg35zucLEUDaQqAbkR4dO49QoXMC+gokbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
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
Cc: andrey.grodzovsky@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I think this is still used on the DKMS branch. But it's fine upstream.
Thanks for catching this.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Regards,
  Felix


Am 2022-01-07 um 5:18 a.m. schrieb Nirmoy:
> Found the commit that removed usages of this function.
>
>
> Fixes: dfcbe6d5f ("drm/amdgpu: Remove unused function pointers")
>
> On 1/7/22 09:51, Nirmoy Das wrote:
>> Remove unused amdgpu_amdkfd_get_vram_usage()
>>
>> CC: Felix.Kuehling@amd.com
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 -------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 1 -
>>   2 files changed, 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 776a947b45df..6ca1db3c243f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -514,13 +514,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct
>> amdgpu_device *adev, int dma_buf_fd,
>>       return r;
>>   }
>>
>> -uint64_t amdgpu_amdkfd_get_vram_usage(struct amdgpu_device *adev)
>> -{
>> -    struct ttm_resource_manager *vram_man =
>> ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>> -
>> -    return amdgpu_vram_mgr_usage(vram_man);
>> -}
>> -
>>   uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
>>                         struct amdgpu_device *src)
>>   {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 61f899e54fd5..ac841ae8f5cc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -223,7 +223,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct
>> amdgpu_device *adev, int dma_buf_fd,
>>                     uint64_t *bo_size, void *metadata_buffer,
>>                     size_t buffer_size, uint32_t *metadata_size,
>>                     uint32_t *flags);
>> -uint64_t amdgpu_amdkfd_get_vram_usage(struct amdgpu_device *adev);
>>   uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
>>                         struct amdgpu_device *src);
>>   int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
>> -- 
>> 2.33.1
>>
