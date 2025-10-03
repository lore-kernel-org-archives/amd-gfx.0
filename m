Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C103BCAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 21:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4667410E980;
	Fri,  3 Oct 2025 21:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wiidF6mo";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010069.outbound.protection.outlook.com
 [52.101.193.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3EF910E980
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 21:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyBtwkwFf3ucfaKXYPM0TJL/HoVcoXW38Yr1T3t8ER1Sx9pUGpqiV1hY0t5HtUz4ykVpyQPDgvXHi6GbBA5QGLWlygg9HqfWSFUERnVXijL1uGyTz5I4hMWfnbF+PiEMSe15qvD8DmU6iu7r6k3q01EVf6/JOB8+FbEzpvi8OQKEhb4s4edGJ2ZugURBAQLmXu3KPY8WlF+gli7AVd8VuDpurUERUcgrvN1u6g7x7lMkJHtX41s4B09V5JElDnYzuYXaoVdaq58LjBtZgM9D9EQwaPgG9KhS6zootV1yyNT1hvSF0bbJNg4jcDkok1SIcdlLJt6J9FiUUwnTqovzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGq+7A/2xM7+spKEzXGF+s6Q8J+ANOT2eSpJKEusnrY=;
 b=dRwAP7Gxl3zQ+KeUcady1dA2Kr747mSt6DlBctin2Qy5D5lFet8vsVnTEOCg/8QA83h5aHQsfIA0TVj4crB8EAErW8aQ8bQyu5I6CZjZCNgxFtdi8SzhQyznk0p8+GALvAJp4BsHPFmb+gRnF2h5idCJD2eDMj19ZIvF+Em+f2Z0lB4CzcjM0tTGANJY45m84ZvEV4njhOkjfhn7FPDB2VLEgUtfcEQyho2EpgfoBJQAlZArhBmSWUBBY47lqRuE1A3dsBQqsLCZSNQkbQDpOtXAx1d1Qfo3Bpgk/fdvjbMuqtfC1j/mGyFb4WatdDUwJDikvR6bgKYS4WTRgCIBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGq+7A/2xM7+spKEzXGF+s6Q8J+ANOT2eSpJKEusnrY=;
 b=wiidF6moBtUikaBwWKUK3fVeCl9zSWzfdh97u0uUdK0n01950nGd1taliaij9eySKsKqh07qlEiurYBoi1mdU/3vxdyDjlu6+74g86JqdQ3wB+ND0mMBG+34t5HzTmGsTTiT89TGG6k65HDavwe4D4kN7cKqOlH5aElBbGItkR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 21:46:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 21:46:05 +0000
Message-ID: <674f455e-434d-43d2-8f4f-18f577479ac9@amd.com>
Date: Fri, 3 Oct 2025 17:46:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix svm_bo and vram page refcount
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250926210331.17401-1-Philip.Yang@amd.com>
 <87ae1017-5990-4d6e-b42c-7a15f5663281@amd.com>
 <f3349a43-446f-f712-ac61-fa867cd74242@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <f3349a43-446f-f712-ac61-fa867cd74242@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: 8abc5082-4a15-4b3a-5390-08de02c640ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmNEMzg1MVl1MlVXK0FXWWdBck1zWCtrQmpCamYvNjdUK0NMSEsrNkMvTTFw?=
 =?utf-8?B?TENHRmt6d05ZL2pSM3BicS9JQjZUUzI1cnppQnJ3WXpqejdDSUdmaHB5YmRD?=
 =?utf-8?B?S1JSTXBBalBMQjNaS1FSMFRFR3k4QVBpZFVYYmhMT0tpbTFoRVArRGNibmIy?=
 =?utf-8?B?Q2JnelFwYVBESkR5R2krRE1heVA4UlBEdVhXcjZQUUtlUDRSR0VjSmFtajk0?=
 =?utf-8?B?dWNla21TNDZ0VWlDemNUTGdvT1NnLzdxMDVHTkpBWUdVVXprVWZXdmVrZ09R?=
 =?utf-8?B?Z2hzTHg0TGR5M1BucXBFd0craDhJTlhRMDUwb1VNdjBYTkNhYXd1bDNzSG5u?=
 =?utf-8?B?MlczVU9ja1FVM2JrUDhRdFJDVGRTOFRIT3pwU0h6ZElmcG9JSHMwV1FOL3JZ?=
 =?utf-8?B?UGhxY1VGTnVrOEQyWHRKaDdoeEJJT3BEY2FIWXoxS2FWWEJWY0Q4TzZ1MnR3?=
 =?utf-8?B?U1JJU2wyYzZhb2pKZkpKcVd2ZzlyTnFTYVdpRzE0MlhMRHNkNVkvWkNOWVJM?=
 =?utf-8?B?cTRydTlmZ3NwdTZiNEduQ2JadDRnQ3VqbW94ZW5kOVJ4RDNGZnNLZW00Z1dR?=
 =?utf-8?B?VFNTY3pyNkxlWkhHNk5WcE5tY0d5UDUvNG90Q1d0YlBZcXhPMUFxcGdndkJV?=
 =?utf-8?B?L1hOdnRQWUh2cWpGT25ld3lUN0I2cnJkSFV4MlZGUXJLOTBieVdPSkVsVEto?=
 =?utf-8?B?cytiN2VlOFdyK2JsMkVzdUdySE9oNUs1b21MK3FHMlpoeGNEYXN4U0ZCTDho?=
 =?utf-8?B?UGRzMkJEamR4Ly83djZqcXdIamlMNFRJa2dzUmJpY2hhbW9kRTZFc0NaZVh3?=
 =?utf-8?B?Q2hEQVpVZC8xREhjZHRvbHpUb1RYUEJQeFkrbVZGMUF6OEdoK2dsSGwxUDl6?=
 =?utf-8?B?dHFDUmtSR3VYTk02TUw0ZGh1VXYyenh2MkxWVlNGZElNMmd0QlhNd296MHBL?=
 =?utf-8?B?NDFSUHBBTU5ESTR2RHhjRjJjTDl2QkxIa2M5NVFoMVAzdVZCNUFLb2o5Mld0?=
 =?utf-8?B?Y2k0Y0hyZGQvQnZjWXhUcnpWeFRNampTWWdJNUZOYUkrTUpLYlRtdklZZndR?=
 =?utf-8?B?NDZoRCtHb21yU0l5VnpWaHhkcXd0N3RESXVhV0tUcm5xRDZnVDVCcUR6T1k1?=
 =?utf-8?B?WkNVSEZ2L0trczd6aFNhZFRKTHdCQmJLYnl4MzAvMU1hM09Md2tiaWpHSUcz?=
 =?utf-8?B?Qmg2aWp2Zkk5SkEyRm5WZ0lzbzJtcTFJemNvNDhQUDBSZnNhTERTZjlsSGFF?=
 =?utf-8?B?cDlISDd4c2FlQXNGb3huRmdxdjRlaFRpSDRIUi9hUjcyWDVUaU9qM1ozUjNy?=
 =?utf-8?B?ZEZGcmhLQjNleG5Fb205cUlSRFZ5WTNLUlVhV1l1VUFvQlM4RWRBWFZGMmpm?=
 =?utf-8?B?WjI3ZXZsb1gzbDBlbFNPN3hSeUNkN3JCZkI1ZndNZUY5SVMzU291SGxtaENI?=
 =?utf-8?B?TzBhUHZhLzkrN1ZXd2lPcTE0cWFOVkRpa1ZlL090QnQyNzZjVE9NYTltZTBp?=
 =?utf-8?B?ckVTQmIvUXRmbFVHL293UjFqYk1MZGd5aE9KTXNTaS9zbGxOQUpDL3g3cy9V?=
 =?utf-8?B?SzRjUmtyNHJZSFBybXo3SXRYaGZzUGFrL1NDRjV1T21xVDZiZzRzRUpXbUVB?=
 =?utf-8?B?UVcvbUh3bkVhN0pHT2MxRWNhRWFHWjhWU0szNVlDck8xbWdzMzBGTHhOTmlX?=
 =?utf-8?B?TzB3MHFPQXcrNnI3MU5xczkwQTJhZUU1L3B1Uis2bUphTzlSa0xES0wweDl3?=
 =?utf-8?B?d0NLRHVIRUJ6dDJTcWM1U3BUQWMzYjJCQWpjRjMzbWVRNEYxSjdmV3duaDNm?=
 =?utf-8?B?QjF6SWdVMEdJcm5QOHcwMGp5bkFCMDhzRHYrcWZUT2ZkUEFKTVlkb2JFN3Bm?=
 =?utf-8?B?aGRIV2lzMEMwemdHWUtIc04yRTNtdHFBRjRwelNNd3JsbDFpUG9jOHFEN3cz?=
 =?utf-8?Q?pTU50vIDF20bJDxDpPxO8JAJK1ibnbFI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzZOYVRXZkVmUThEV1FZMDdJVWVJUTFiZkJNLzQ0Sm82aEpITWhWVHVpM3Z0?=
 =?utf-8?B?L2RMTm5tMVhEMGZFR25ZZXMyQ3Y5WUh6R3ZqNWpmcTNLemNueEtodmM2RHZU?=
 =?utf-8?B?QW5PSW93VjhybDkwVE1IZHlrSFJKelNYTUhBdGVVeVMvSnVNU2RqU0RyN091?=
 =?utf-8?B?R3gvMlJEd1FJQU83azI1ZDBMODBkUG52aHh1RG5QamkwMldObXpEejBSaFZE?=
 =?utf-8?B?blRTRXpRcEhFYkQ0V1dnVFRycmZXeXI4K0huTmh3S2U1ZGo3bGI3eGhMSVlu?=
 =?utf-8?B?Y2NPK2hoVUN2ODJPSms3WW9ScHY5bitsQWdHTGxpNVo1TDV1VnpGRmpXT0Nx?=
 =?utf-8?B?ZXc1cURjZVArcVFlYlNlNVE5QXVkWXhRQU1LM000dzJhY2tScGJpczByZVpl?=
 =?utf-8?B?Ly9EeFhHN3FWb1o2cTc4ZWNQL0Jac1luaTJFaEd0VzkxTXUrNVlmeFpQVGhh?=
 =?utf-8?B?UEhqbzFyd0NuckkwUTFoc0NzS2V3aW5sNDd2SUxabGc2Uy9rYm5mcnVFbXZF?=
 =?utf-8?B?K0ZGL08zbmFGWW1aejhVcGZIZHQ3d0kwNjJnY3VkcDBXM0FscUZLWllxM1R6?=
 =?utf-8?B?QWg1T0lxQ1NwdU9YS1l4cmh3bEM1bTZQdXlraWhNMFFtVGF5dmJ5VmpXdEhM?=
 =?utf-8?B?czN2Y2ErWWx4ejYyc2dIWlNXcXlNYS9ieGV3ekoyMjNsbklMU0dudERLeWR3?=
 =?utf-8?B?VmxnM2pPU3lvMndaUkZId2tKYXErQ1Q2S3YzRUpOZ3hNK1lYdnpWYjBndEFF?=
 =?utf-8?B?UElkSXVPWFM5UVBBa1d4czh3LzF5cEE4ei9oWlEvd3NMWGNWVERnb1paczZO?=
 =?utf-8?B?eWxBWnFTemVrTGY3VWZFMDloS3BOZFdLOGJ0TTJ0cnZqVVBVK0JMcW5JMDdB?=
 =?utf-8?B?TUdJV2NyaG9QYUJVYXFpYksxOEhDSnY1VWNUcytHQjZ5OTVlUS9tVlVVTklw?=
 =?utf-8?B?U3VaUUZ0ZW01OHBBRHJENmc5TGZoS3VPanIzc0R3K29qRGMxVVY1VzNHS2g1?=
 =?utf-8?B?ZXVkLy9PSjNRTlhCSldMSGlCTXNNN0U1enBtcS9wRzYvSUNjRk9yVjlBYXVm?=
 =?utf-8?B?RjF2RUphM09KV0pXVWF6Tm5yTE5RMGY5MHNlMWl0LzlrZW5Ra1NBN00xcE9X?=
 =?utf-8?B?T0pXRVVyR2drYzJyYit2NjhUUEJPUTVNQ2pFWmdDMDNCRTc1RlZ4M1ZCWGJR?=
 =?utf-8?B?cVUyV05sempkSTFlU2JQQ21BZ243YkN4ZlN0a2pzL21kaXVKaXAzYS84OVNk?=
 =?utf-8?B?dlQ0U29KVHZWQWNacGhDY1JVUTdrZU9mYy9VdTg5VmxkT2pGeVJ5LzF3OCsy?=
 =?utf-8?B?eEtSOCtoMWl2OFdYZlJkTDFlcmN6TFNvZG1wRWk5OUtqUndWVCtQUHc0b25S?=
 =?utf-8?B?Zyt0MkNxRy9EOXIvMEpoMVhDT1YrdXRkTjFqSFJKS2dMZENzUDUyYzEwZFhV?=
 =?utf-8?B?a0lTRXJlWmR0cGd0N3ltejRyNDhRdWo5bUgzMkFmUG5CSk5rakdJcVdKUjY1?=
 =?utf-8?B?Rk9JcVU4MkxuUzN0V0hGMnJrZEY5d2ZqVWVWbzBHdXNRVVBkY0s2SlJyVmlR?=
 =?utf-8?B?bC9HMVVzRUNJZ0k5eUJRVEtWNmVyOE12UE1kazVuNm5GY3NUOGpMQWdvK0VP?=
 =?utf-8?B?UVdUN0duWk1uYVNxcUhlZTh4QjFpVG0yTVlIZmthN1JFU0FlM3dWNHJoZGJO?=
 =?utf-8?B?NWlhdFZOS2pvaVJYWmpIVVk0aHgrUjFaMzNaRU4zaExHK25UNW43eDNTaEhh?=
 =?utf-8?B?a05oOEdiRk1GdUdteXE4di8zTUJrUFZIMnZCNERtNFhWNDkxa2VrbkJZSk1s?=
 =?utf-8?B?Y29JZ1ROZlBQWXp5RktwN1FmTG9aMitoUEhVMlQ2M1NRQlFEVlRKckIrdDVU?=
 =?utf-8?B?R01CUVhCcTJNbDVWMHpDTGZIV3l4aEwvWE90UkRscGpYL0dBa0h3UDdkZXAw?=
 =?utf-8?B?L0pib2kwVDdHMUNjTE5tRlFySzVLbFJhQzA3eGxiVk5wKzJLTm8zUExqREhi?=
 =?utf-8?B?NWxSNDN5VVlPaW9HQzZEdWZ5Mko4ODdkOVliOUhQTnlaM2swWFk2NWxtb280?=
 =?utf-8?B?MEMyQnVzeVdGMWxoaDl6SmVnYk1pbHdYMlpYSStWbjd5SUZJcEpWWEhDdDZs?=
 =?utf-8?Q?RjTPy9cQFkLasinZwHkSv5Yn2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abc5082-4a15-4b3a-5390-08de02c640ee
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 21:46:05.0929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FordGnZ5bx9H7NhXqc4IGbc5r5Mg+wZ10AzBhqcrtarRVXRqTi25Vl1WdANnh8axRlxck1offsBytpBqD1xcxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977
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


On 2025-10-03 17:18, Philip Yang wrote:
>
> On 2025-10-03 17:05, Felix Kuehling wrote:
>> On 2025-09-26 17:03, Philip Yang wrote:
>>> zone_device_page_init uses set_page_count to set vram page refcount to
>>> 1, there is race if step 2 happens between step 1 and 3.
>>>
>>> 1. CPU page fault handler get vram page, migrate the vram page to
>>> system page
>>> 2. GPU page fault migrate to the vram page, set page refcount to 1
>>> 3. CPU page fault handler put vram page, the vram page refcount is
>>> 0 and reduce the vram_bo refcount
>>> 4. vram_bo refcount is 1 off because the vram page is still used.
>>>
>>> Afterwards, this causes use-after-free bug and page refcount warning.
>>
>> This implies that migration to RAM and to VRAM of the same range are 
>> happening at the same time. Isn't that a bigger problem? It means 
>> someone doing a migration is not holding the prange->migrate_mutex.
>
> Migration hold prange->migrate_mutex so we don't have migration to RAM 
> and VRAM of same range at same time, the issue is in step 3, CPU page 
> fault handler do_swap_page put_page after pgmap->ops->migrate_to_ram() 
> returns and during migate_to_vram.

That's the part I don't understand. The CPU page fault handler 
(svm_migrate_to_ram) is holding prange->migrate_mutex until the very 
end. Where do we have a put_page for a zone_device page outside the 
prange->migrate_mutex? Do you have a backtrace?

Regards,
   Felix


>
> Regards,
>
> Philip
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> zone_device_page_init should not use in page migration, change to
>>> get_page fix the race bug.
>>>
>>> Add WARN_ONCE to report this issue early because the refcount bug is
>>> hard to investigate.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 +++++++++++++-
>>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> index d10c6673f4de..15ab2db4af1d 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> @@ -217,7 +217,8 @@ svm_migrate_get_vram_page(struct svm_range 
>>> *prange, unsigned long pfn)
>>>       page = pfn_to_page(pfn);
>>>       svm_range_bo_ref(prange->svm_bo);
>>>       page->zone_device_data = prange->svm_bo;
>>> -    zone_device_page_init(page);
>>> +    get_page(page);
>>> +    lock_page(page);
>>>   }
>>>     static void
>>> @@ -552,6 +553,17 @@ svm_migrate_ram_to_vram(struct svm_range 
>>> *prange, uint32_t best_loc,
>>>       if (mpages) {
>>>           prange->actual_loc = best_loc;
>>>           prange->vram_pages += mpages;
>>> +        /*
>>> +         * To guarent we hold correct page refcount for all prange 
>>> vram
>>> +         * pages and svm_bo refcount.
>>> +         * After prange migrated to VRAM, each vram page refcount hold
>>> +         * one svm_bo refcount, and vram node hold one refcount.
>>> +         * After page migrated to system memory, vram page refcount
>>> +         * reduced to 0, svm_migrate_page_free reduce svm_bo refcount.
>>> +         * svm_range_vram_node_free will free the svm_bo.
>>> +         */
>>> +        WARN_ONCE(prange->vram_pages == 
>>> kref_read(&prange->svm_bo->kref),
>>> +              "svm_bo refcount leaking\n");
>>>       } else if (!prange->actual_loc) {
>>>           /* if no page migrated and all pages from prange are at
>>>            * sys ram drop svm_bo got from svm_range_vram_node_new
