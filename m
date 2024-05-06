Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7081C25B10
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 22:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CD2310E28E;
	Mon,  6 May 2024 22:14:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PZNQdj7p";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABFAD10E65C
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 22:14:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B48HMWLFxmQjQTWaZGI9OsgIv/v7XNPLC2M8I1pSK+Oy44jYqK50bjeWwsGRFe0QpWU7pG6vpUxHLciPCkyPHq/+GYc0op3+ztBvZS87GjCBIZgOGhvvgmLMxMgeMhhhE05qQmk/0HXXLltBBHoZxlFyHwkPWX1EfZ93RzH1PCRC+NzddF1TT9MtrTlAJQUulpfGNbvRpLpxrwdYdHJ2pn8aB4b3zW7nWJteaF4IoegeNtWkzWblM8UryaENLdiAuYeLeinmZpqDoV/P5ShIkE0N1itM8PdZStCHI59HY59QYo+JhYF1ce5FoYaoVYA9MI2zRMfsPcoRsP4ZB8Ch8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nan3j6wLArxoo5/tRkUi0q7o0esEjARbAhhCQsoehrE=;
 b=lir66PqUnAgi9uYPXu5Y2ygeSb92IpNM81hmBzUCYBZAATM4KQXwLzWIjgxCNL+54XrFAEfcH3NEE31N8ZXifXtzEFuDyEpcLUHQ2t1pPHVrTSqzAwCCcPb3QDctKXJg+FU32aNDR6LtEMmQKoKdW1knKI+NWxsKYYAoNoZfZpM7FprqDsdg/OLALBGEL1JzHAH67LfF+tCPV18cezUrIJkiNmJCIxiiru8hWoR258euU6oMH2k0TzDvCiUl6w85fM54rGidSVwNkrdGd6P6EqQNG1UTdvA4Bl0IRLICiVSHw2Xq1NgfFckBgFAPO314dZkTkCXjYGUH3nkcfh0TpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nan3j6wLArxoo5/tRkUi0q7o0esEjARbAhhCQsoehrE=;
 b=PZNQdj7p6tAM3W3quchyLyKpDvFN0GaaLcYJkrUhRXpPtw4NPPlVCdh55ToRNZ7+3eeAzgX6F5GnoxZwUCv3vZUIox4eh2DxnluRqf7J57z8NO2wugvFjF0HbK8LBwXIlYkUD6GQeGI9mQ8LYgKiBIzktZk5QzI5LG28xraKgVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 22:14:14 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 22:14:14 +0000
Message-ID: <714a1da9-e353-4e73-bebf-bd91bcb198fc@amd.com>
Date: Mon, 6 May 2024 18:14:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Ensure gpu_id is unique
To: Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240503220639.335198-1-Harish.Kasiviswanathan@amd.com>
 <64bbdff6-1944-41ea-85b6-d836165c9952@amd.com>
 <deca3d41-ef0a-477c-b904-6d5473b3e78f@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <deca3d41-ef0a-477c-b904-6d5473b3e78f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: fef1c2ff-11c4-4cd4-6cb7-08dc6e19dcea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXNGd1JXM2UzODc3WGE2YjhPS3JUOVJPS1YzbzBpdGE3MzA5MTRabVcvM0Uw?=
 =?utf-8?B?OVF4NTdHMFBER1BYTXg2dnN3UWgydE1MQVAyS0l0TmRVUmVpVEE0OHlaR1Ry?=
 =?utf-8?B?Q1NkQWtYekNZRjF3M3BaclRwOTA3MjB4SVRFRmlLVFhveXJhZHVONkdCNnNN?=
 =?utf-8?B?ZUQwYzlWbVNUQi9JWEJrc2hITjJsSGpNV2FqSXJzdEdkWWdueDFnUUhFUml5?=
 =?utf-8?B?aHpFREI5ZUhHQmF4dzRCSHJCcDRESHhRa3YrUlN5eTVmVXFuV1JpdlNldloy?=
 =?utf-8?B?WmRhcVJ2OUR0NHZsbmhBMFYyN0RtaVVISUxqTDdEQjVnRDZ6L0ZqZDk5cXdo?=
 =?utf-8?B?Y0ZuV1VjZHJoT3RiUHRkQ0NLUnJsWXBGek1BNXQ1NjRacDBrbU1UcFFUdWs3?=
 =?utf-8?B?NVNUYmxOSXQwTGFsaUMvMjJxaWVIRndGbk9WUW5zMEpRVC96TVEyTGhwajBK?=
 =?utf-8?B?YmVkeWs4ZmlPSHl0d3RHMnFEaDJaUUUwR2VPM1IyNG5IREQ0WkhQVTE0TldY?=
 =?utf-8?B?eFFHemVmWHllWGE1QTNKMDNaOXJPQVBpMVJlVmV2by9iMmJoYnB2WjlKQlVD?=
 =?utf-8?B?RmxnY1Znemh4SUNPL0VwRXVXQjJrdG9nMFBKM21Ca01MK0tYV3dudzdqRmUv?=
 =?utf-8?B?V0piRGJzaGtxS1dBSm0xeVZTV1lSOUZnNUtwVTNxOCs5NERIWnQrYnBXRDJj?=
 =?utf-8?B?V0t4VW5hL0IzbUxCSzR3WUd2b3JPbVNMT1NVdUJvT2JXV2N1dUYwekFIcm0x?=
 =?utf-8?B?eW0xenovRytERStCZjkrcFJYenZ3MEZrQmJ6ZTRWVFgvRzVsd3hJWmJMZCsv?=
 =?utf-8?B?bWtuTWZhZHhFNGgrTjJ0VENUeGFiSUZLMUU2U0pNNUhZZFBudnRzZFQ5bnJS?=
 =?utf-8?B?MW9RTXB5SWlKWVlmRXB0blZKNkJUSllkNGprYVI3N2Fzc0wrOGZlcGxWUk5N?=
 =?utf-8?B?QWtPSXQ3RGdpVHNGVjhpSFVOVC8rc21JV0FlMnltMlpNdS9ONEQ2Zk1oUnpD?=
 =?utf-8?B?Qk9qOFBsR0Q1ZWlidXBQTUFkOERCTlNrK0tWTEk3MHZZdUd4djM4SWVaQlZz?=
 =?utf-8?B?dzdIK1gwb0J0WWxTWVpvL3BHT2p4eWZGdWlsa0dqYzBrVEV4c2srSU85Vk1V?=
 =?utf-8?B?N0owTFoxaU1YaHBxeGlneFRuSkRjbEFmdnF5dUpZRFZTeVRGZFo2anIxaXFy?=
 =?utf-8?B?UENmVGxES1VDMnY3VVdpUy8weVBwQXJTZHF4K2VUNHY4Y1doMng1RlFPNnh3?=
 =?utf-8?B?SHlCMHArdklkd0JNeE9MVXBJNXV2elJWRmxPWUg2N2JMRnJFWW92MnFHT3da?=
 =?utf-8?B?TVRFZnNuOUlYVTRzcUlUSUxJK3ZjMFRXMHBqUVlUbTBQd0h1M2JTV003aXF1?=
 =?utf-8?B?M2gyQXhLNGF4YzVXZDZ0Qk9tRW8wb0xXS0hnNUxheTlodUhEK3Z6bks1MU1K?=
 =?utf-8?B?ZDhScEh6dEtaalE3WU9LUG1wOGF6VU5ncE1IQnRQeW5QS3lpZUJpUFRqTm9z?=
 =?utf-8?B?bVBkM2ZaQnVBZldNRm9xNklJSWtiQzhxKzdwSzU5Yy9aSktZa2tWVGUzMEJL?=
 =?utf-8?B?UlljR1JmNzRoTklnbkhWdkpCdTJMRXVLQzlkMHZWQUN0SlAvdVJ1MlpwR1dr?=
 =?utf-8?B?cHJHUXJERU5TWEFPK01hb2lCa2N4QUNobjd0WlE2Vk1zVXNYaENJcHVGNmZo?=
 =?utf-8?B?eldvbE5kRHNncWdVWXpsa2t0SFN4UXVtd1V3TmMxWnVqK0hUbno2VUt3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDNvZlR2ZzRVbmtoZmFmdDdKV1Q4cU83THhLN1V6T1hqQ2NCMGFFSXgwMlNI?=
 =?utf-8?B?OUlCQUpkRjMwWFI0MlhCWE53Zm5hQWtPSk9pdXBtTGRJVVhnY241M1FBb1Ez?=
 =?utf-8?B?T1lsdCs3bCtZM044eXdaRGFLZDlReWNRdDM1SFBJMXNWNjBVOFhzdXYyOWZH?=
 =?utf-8?B?MUNSTjRxT0lSYndDaEVlK3N6WUJ4eTJ0TXZlaG45R01LWllVRzgzV0twdXZj?=
 =?utf-8?B?OW1ibzVXaVVWZXJJOXZRNFcyVzZOUmY2OGJRQ2ZpckRLZmZBTUV4VDYveDJZ?=
 =?utf-8?B?N3ZweDdPazI4RmJmK3JnQit2alh6aTNacmF1UUJqK0ZRaFVMT3NPU3MrcURF?=
 =?utf-8?B?cmJhRXcvNHpodXBjR0VENDJaeGN1WmU3eHJlL2YxM0ljUkx2ZDMyZVRmbjZV?=
 =?utf-8?B?R2xmbHVxaEJ6ejhKMTVCYW9YSHVTTXlVT2lrUkNNb1g1dy82eTlHckkzaHdm?=
 =?utf-8?B?WDVleGdCQTdGTUYvMDM2b2IzbjdwUUtVZkdpMi9RbDNKdi9ScmtMZlVtai9m?=
 =?utf-8?B?NVd4Q1lHdkNERGpYeGZiZ3FRekZZeklaRU8vcjVxOFQvZXQ2VkpIYWxLWStD?=
 =?utf-8?B?Nlpsc0JDSGg3aXlmSlZ2UXFxaDBtKzZ6YkxzQm0vWG1kT2FsSGhvaHd1Skhw?=
 =?utf-8?B?dlJ5UkVMcVZMS1dyUkllZTdVWFVIUjFqK2NYYXlhaCtVai9MTWRNcmZLTmwx?=
 =?utf-8?B?d0M0R2k4SmdJYU5HNU8wS1FFVTA0L295eExOQUtxbFFycUZ0RlNCYkxSVUJI?=
 =?utf-8?B?Y3JtWkUyUXMzaE10QkY2TkFxUlo1NTFOdkRrNTlCR0JBeENhQWdmUDAxRGRr?=
 =?utf-8?B?ZTIwUHpublBldGVwSkNZSHVnd1FldFc2Z2tJN05ET2hiY3A5a04wekoxMHN4?=
 =?utf-8?B?YUtDaTJQaGNpcERnOHl0N1RqOFlia3hnR2RyMzl2cHpveDQrSHhFRjdLaTNp?=
 =?utf-8?B?K0wwY0NQdEdEUkhJalhLblg1cjdjQ29pYjZ5TGVVdFg0cCtwcEJ6WGVSK2ZH?=
 =?utf-8?B?eWtxLzZzZGpzM1F5blZBekVpbDF1VnpNZHJjZ3M4RERseXZOeHloaGZocFl0?=
 =?utf-8?B?aWdiM2oxNlkyUEpKWFhqMXF6eHdqUDlDMXg1U3BUd0hSRnVuY0NXN0ZYMU9P?=
 =?utf-8?B?dnIvb1k0bHk1WkJiY0RONVJ3bStDcklrL1R6YjVNdFpXdm5CNE45Sm5ibzJE?=
 =?utf-8?B?aURrTTYrMGxkN2RXNFI1ek5aRXRXdFBKNzE0UytZZ2lxaXZyVXp2c3N1dFk0?=
 =?utf-8?B?UFphNXRrZ3Axb3ZPUllxL2IrMW5HZXlscy9PWEJOaTlqVTVHb2pLREQyd01v?=
 =?utf-8?B?cEJEQWtvRWJ6SEdiOEpGRE5yZzVWWUY5QmFqZ3RDT3l2RzZ5OWVVb3NBMlBY?=
 =?utf-8?B?K1o4V1MvUktyUG5xVW8xQVNVTTZaY3UrdmNzdkJ1bm9qa3hnWHkrbUhUMWsy?=
 =?utf-8?B?cUJSa3AvbVZaZ3FENlN4dmJGNUlUVXhVcHM4SldiUUhNcm5na0M2TWpZOFVa?=
 =?utf-8?B?enZqYnl0UnlkMThNQmJKUHFhZDRhQlFoODJGcFlDc2l1NEh4THk3Z1c1NDlt?=
 =?utf-8?B?bkJzT2I0bHVkclo3eGVwaDIwT2J6bEo3WWt6aktNK1ZNM2w4UWRpSytxV1pV?=
 =?utf-8?B?cE80eWVGdUx4aTJrTVc2amJHWXJnQzNzdWxleDdyQzAybVFZZmJrS2FYMk16?=
 =?utf-8?B?SUFWM2o1dmNJN1JhQ05EM1RUc2g2N3FsSU1SbjFYMkZoL1M3RHR6VkhSOVpW?=
 =?utf-8?B?UEZiK3dUbzdpTUJCaXg5aUJrKzcrNlBBMDh6aDA3M0ZRUFNrVy8wY0JBZlZN?=
 =?utf-8?B?VmJvdCtEY3dDMThRcUh6UzdtOGFpeW9tVmJ2dkhzYU0ybUVVbHBjMWdRc2t3?=
 =?utf-8?B?bTZRbU1ZNmJyV3gyQlFHRnZsbURqSkxQK0dTVGdDcXo3c2l0ODBMbzJraGE2?=
 =?utf-8?B?Z1M0cEJFbDRTdHhpcjFEY0I2UUJMeUpUa1JKT0lVM0lqSTAzWEs2Szkvdlhz?=
 =?utf-8?B?V3IwcXRvSE13eW5uallCbzZSQkhEby9jS0Q1YnJtRU14SHpndjVVSzV5YVV1?=
 =?utf-8?B?ZitLdU0rQUpSaEtYcy93NHdKaUUyMHN0SG1aTUlHMWY4RStKQzdzZ1FNQWxW?=
 =?utf-8?Q?S4rx7ktU+LVhLGRP3ZBH0MBlw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef1c2ff-11c4-4cd4-6cb7-08dc6e19dcea
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 22:14:14.0387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clIPC2m655TtwAC5PW3qAs+yQvduX+Ovi6nU00KDYa1H9A3uBd+fbQjpaVz5eNhJGMxn6XVxlkvcsBIJ9+PEAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254
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

On 2024-05-06 17:10, Harish Kasiviswanathan wrote:
> On 2024-05-06 16:30, Felix Kuehling wrote:
>> On 2024-05-03 18:06, Harish Kasiviswanathan wrote:
>>> gpu_id needs to be unique for user space to identify GPUs via KFD
>>> interface. In the current implementation there is a very small
>>> probability of having non unique gpu_ids.
>>>
>>> v2: Add check to confirm if gpu_id is unique. If not unique, find one
>>>       Changed commit header to reflect the above
>>>
>>> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 26 ++++++++++++++++++++++-
>>>    1 file changed, 25 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> index b93913934b03..01d4c2e10c6d 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> @@ -1095,6 +1095,8 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
>>>        uint32_t hashout;
>>>        uint32_t buf[8];
>>>        uint64_t local_mem_size;
>>> +    struct kfd_topology_device *dev;
>>> +    bool is_unique;
>>>        int i;
>>>          if (!gpu)
>>> @@ -1115,6 +1117,28 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
>>>        for (i = 0, hashout = 0; i < 8; i++)
>>>            hashout ^= hash_32(buf[i], KFD_GPU_ID_HASH_WIDTH);
>>>    +    /* hash generated could be non-unique. Check if it is unique.
>>> +     * If not unique increment till unique one is found. In case
>>> +     * of overflow, restart from 1
>>> +    */
>>> +    down_read(&topology_lock);
>>> +    do {
>>> +        is_unique = true;
>>> +        list_for_each_entry(dev, &topology_device_list, list) {
>>> +            if (dev->gpu && dev->gpu_id == hashout) {
>>> +                is_unique = false;
>>> +                break;
>>> +            }
>>> +        }
>>> +        if (unlikely(!is_unique)) {
>>> +            hashout = (hashout + 1) &
>>> +                  ((1 << KFD_GPU_ID_HASH_WIDTH) - 1);
>>> +            if (!hashout)
>>> +                hashout = 1;
>> This doesn't catch the case that hashout was 0 before incrementing it, and was found to be unique.
> I didn't actively think about this case when I sent the patch out. However, we don't have gpu_id to be 0. There are places where gpu_id=0 means it is CPU node

I think we make that assumption in a few places, both in kernel mode and 
user mode, e.g.:

struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *p, uint32_t gpu_id)
{
         int i;

         if (gpu_id) {
                 for (i = 0; i < p->n_pdds; i++) {
                         struct kfd_process_device *pdd = p->pdds[i];

                         if (pdd->user_gpu_id == gpu_id)
                                 return pdd;
                 }
         }
         return NULL;
}

Or in the Thunk in hsaKmtGetNodeProperties:

         /* For CPU only node don't add any additional GPU memory banks. */
         if (gpu_id) {
                 uint64_t base, limit;
                 if (is_dgpu)
                         NodeProperties->NumMemoryBanks += NUM_OF_DGPU_HEAPS;
                 else
                         NodeProperties->NumMemoryBanks += NUM_OF_IGPU_HEAPS;
                 if (fmm_get_aperture_base_and_limit(FMM_MMIO, gpu_id, &base,
                                 &limit) == HSAKMT_STATUS_SUCCESS)
                         NodeProperties->NumMemoryBanks += 1;
         }

Regards,
   Felix


>
>> Regards,
>>    Felix
>>
>>
>>> +        }
>>> +    } while (!is_unique);
>>> +    up_read(&topology_lock);
>>> +
>>>        return hashout;
>>>    }
>>>    /* kfd_assign_gpu - Attach @gpu to the correct kfd topology device. If
>>> @@ -1946,7 +1970,6 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>>>        struct amdgpu_gfx_config *gfx_info = &gpu->adev->gfx.config;
>>>        struct amdgpu_cu_info *cu_info = &gpu->adev->gfx.cu_info;
>>>    -    gpu_id = kfd_generate_gpu_id(gpu);
>>>        if (gpu->xcp && !gpu->xcp->ddev) {
>>>            dev_warn(gpu->adev->dev,
>>>                 "Won't add GPU to topology since it has no drm node assigned.");
>>> @@ -1969,6 +1992,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>>>        if (res)
>>>            return res;
>>>    +    gpu_id = kfd_generate_gpu_id(gpu);
>>>        dev->gpu_id = gpu_id;
>>>        gpu->id = gpu_id;
>>>    
