Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E53C369A6
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 13:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC24910E8C3;
	Wed,  9 Apr 2025 13:46:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rzobsksP";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E7A10E8C3
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 13:46:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EovZ6jwIFKnxKb8I6U792YG7Q1A/efu7yh5tMuV9AAq/jD9ZKL+f1vb1PvdOJOZNPIK9gniq7UGF1uEdqJHSRaaAqwO8zE62gddgzjr7JBrzlattW5nz7bbz2Qdwn1kwR8Kxlf6+CS+D8pINpniYH3JO/UNZ1o//BGunD9EpGsfvR+oeyVeZm1Q18ePMPkAB2oEzQRuWGZmFtf6oMVah2iaPsyYBZFtqQtrcUzvGWWfJpWMLDmP9B6eIE+70AjY0kjZgcSUb9C+EWdRDpj/VEFg3KAwc3rLozVJjEGPZI6Rcm3XudOH2nBSyZH9l0cl9HHLb+/qtPTLuoGN1Gmqn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkVRhmMkp1tE4TXg8qQr22Wz4fwnZHvg6f6Wxyd17Wc=;
 b=dIPjD8Toa+EaA69Ev0FcCUxSzyWQg8mFqSBea2jHGczxZUBXGm3LBNrdsb7Zp3gywfRrSH3ulLxH47JG9j448cMGi4LAjq6Vi8/9MZyrmkCoWNbzR9yup/hkJC+eKrSbxetJaKIc5N6qGNE3Us9WytsLukCsLMt6tKvQDbrKq5CM+45S0BbD+jj5DJqlh6Cc7lhbwCZ0EjFmT/gFpJLZDnVfryPT9506pvo1+XYFe1KwXItRJPc3+iJlwZHxbBOMKRsqPbtse9mhPTetXWtcqJFZ2FDn1oql6mZ55+On3o1Usr76iS8H48S9HYyi2ydpiTzBs6QmLKvVlo+w/46yNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkVRhmMkp1tE4TXg8qQr22Wz4fwnZHvg6f6Wxyd17Wc=;
 b=rzobsksPw3cp4+MPFFJ+59eOn/zBouirxyrTffku0T3Y4I02t5auIejfrRGsFphHNnsHisEVzVH6vzzQT9hk46mlF5daiumH8qxso8lr2/5uW4PWjJ0wFo3y98GEB6lljUZWj5T32d/vWoLjvp0F8P4//jXufjdjbIt05/oRX8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SA5PPF530AE3851.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 13:46:11 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 13:46:11 +0000
Message-ID: <65d607ab-3d65-4d08-9ac2-49f3228b195b@amd.com>
Date: Wed, 9 Apr 2025 19:16:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: cleanup amdgpu_vm_flush v5
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250409104500.2169-1-christian.koenig@amd.com>
 <965773b6-40fd-481e-8699-ae7234cc1934@amd.com>
 <c2270a3b-943d-477d-9220-593e05631d82@amd.com>
Content-Language: en-US
In-Reply-To: <c2270a3b-943d-477d-9220-593e05631d82@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|SA5PPF530AE3851:EE_
X-MS-Office365-Filtering-Correlation-Id: de0764ea-d0f4-4f90-ce94-08dd776ce30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHl6eklITWRJNjl4SktsaDdLbmk3Ny8rbEgvM1BXZ2pwZElEZkZtMTdPMldX?=
 =?utf-8?B?M01KZHpOTU5QZHQvaWhpOUVzeHhuMG5WSUNaSzc1Z1pYYkpwV3BhcGF1TTAy?=
 =?utf-8?B?RjRQOW9uWDQxU2V0N1p6NzNIZE5lUkxXK0pYOGxOWmo5YXRaNGlZM1QrdnMw?=
 =?utf-8?B?WjhMNDhZeVJoYXZqSXBxbmpYY1NXNkd4NkJhVG1QTmhFTUk0UFFkTWVUWDRB?=
 =?utf-8?B?YXFoWmk2dXVGTWxmK0dIWm1iOE1xVGlMZFVDQ1NrQmVPZ2ZHVDJjNzNHYllV?=
 =?utf-8?B?bVpNZExuT0VaN1I0S0taVnZHMEZBMXIrWFRZTDI1UDdvYlVEWTFoY3h5aXVY?=
 =?utf-8?B?VTFVdjRKTml6V2xadFk2ZDA0SVRBdlNrRGNoaDFnRVJQVm5PNm5QWm9FYW5U?=
 =?utf-8?B?czFQelhvUlpMQXF3bWhyOURETGhmSjJTRCtiR3oyMjg4aUlRY0NheEF2N1Ar?=
 =?utf-8?B?T3Z4eHhSOXBuRzRHa3ZFMGJNeWVXVHZNcmxZU1E5L2xKVm9HY3Mxc2NWZmI4?=
 =?utf-8?B?a210eHZ5ZGpxdlluQUY3NFVYMjZpcngxN0ZNelN4d2F3WjZmZ2VHRGgxMkFH?=
 =?utf-8?B?c3VvQldlS1kvbWNIZTB4TG9iRkpNWXVmTDMxR1JHWGxjT0p2UmFKaUl6WlJ3?=
 =?utf-8?B?VU0rYlRLYTV2Z1ZMaFlkV20rMUtYNXV2dFVBdTNVOE9zaW0yZytWRlZ5aDVP?=
 =?utf-8?B?bmp0dURpeEJEc2s5VVA1SHBmUmRBN2VBeVBsN1lER1pNNExqUGlqaXVCQmpP?=
 =?utf-8?B?cFFqcE1kdGhtdHJNUkpKZlYzOU5oVFpDYlhIYlExd0FsK1VNN3pNUGJXcWFp?=
 =?utf-8?B?eSt2NzRudkh0R0QwaUF1OXlKb3d3Njl3dWZQaXFSbzNseGEzK2tnSWpidEJB?=
 =?utf-8?B?N1ZlQlRtNndUL0M2Zk16b2s4ZG5nV250a1FiOEJETjUzY1pwamdkMU9CQjB1?=
 =?utf-8?B?YUJIV1V1WUJVK010YisvMUZtekJBdGV6cFB5b2thQTVJZlVBcGNMT0hGQ0t2?=
 =?utf-8?B?WUxHbWM5VUN2c2R2VVh0c2QwME9mZldpeVhBT1laTkZ5V2NXMGpBVC9oU1pT?=
 =?utf-8?B?aTRYYkdLTGZTWm9oYldPTUUrNHdVcHNUUlF0LzJQWVdtUXBVb0NYdUFRWStx?=
 =?utf-8?B?aks4Ny9RdHdMUjBEYno4Q2JOSnpGZWtOMVF4UG44UEpHRU56bGk5NUN3MHRa?=
 =?utf-8?B?L3FjVE1Jb2tWaExWV0YxYi95bXBveVFJOWdSVUJRRDgrRytkaEx5YmtQK1g3?=
 =?utf-8?B?M25OMmM1d1lLbi83TSsxL2JwdUtnQ2FjNk0ya2c0alRDZmdKYmcxVmdnVzNj?=
 =?utf-8?B?ZDdsSHBKQUp5NzhOaHlTeW1uMWNGNkpPR2tUKzFkTXRpV3FxaTBmaDhwTlVE?=
 =?utf-8?B?TzIwM0IxcUNYdUVYTmxvODN4VmFhRmZsbmo0RWFEUjhMYndZL1lnVkhZL2kx?=
 =?utf-8?B?THN2UjNUR2w0Q3ZBZ0RhNGlxcmhnWlRCNUNrNEJMb1ZNYTN0Ris5dEJrVnlC?=
 =?utf-8?B?SzFrdWt1ZlNrMlZlRWJwRDUwVkFob3d4cTBWeHowd0JMcm5obE53Q3FLS3JQ?=
 =?utf-8?B?eFRuYTdRNUxzUGxlYjk1Tk1pbTdsY0xDcm8rTEJUMUd0Ri94VVc0bnVDZ0t3?=
 =?utf-8?B?WS9QMUZHZTF6Vmh3QklIdEErM2ZNZXdLbWxLcXF1VUpwOVV2eTVXSHlnT3pi?=
 =?utf-8?B?OE04N1pHL0NNSk1POWpIbnJBMkhwOUNKTGEzT28weDNvU3hSbG1xWGJIUEYw?=
 =?utf-8?B?MlJYVUNhZzJ1UTJLb0Ezbm9xbW0rWlc5V1ZhOVhISUtiNEc4TTVhZStWNk5R?=
 =?utf-8?B?blk4SHIvb1QzanZ0TVBhQ0xRODBaMVlsNFdYSW82UEVBTi91UHVyQTJndi8v?=
 =?utf-8?B?SlpmVzU3MGhuSmNYNmZzZnFLSzYwSXVBK1Z3SkY3Ris5VCtPbkxBWnRKWjhE?=
 =?utf-8?Q?vl1wFGxT72o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG1TZTE1WC9mQWJCTk14a2IrMEgzUFRKMGdaQTBqUkQwM3cxM2t6U0RCODdC?=
 =?utf-8?B?T09PSXE0WEpJMVBwanBpZGROdXBIWEZENENTcWZWTE4ydEhsK0RoZXFZSlNV?=
 =?utf-8?B?a1RSa2IvY3pFckRJZVNETXU2eThVM25hU28xM2UvWVNlSnBQckYyTTFQYUZr?=
 =?utf-8?B?NWxSUUZKNloxK3NFcXVwcDFoRjNVZG52QmFLclJ0bVZyWjUvRGtVNEx0bCtk?=
 =?utf-8?B?TnlHaGpVcFJSOE1VQmJ5a3ZXR3R2WWhUKzZhMXdkSjJZYy9FNzAwditHMWJr?=
 =?utf-8?B?bE43blRjRlBnOThxeUxpNjVYdTNlRCt5Wm1ZN3dyZzVueS81eVUvT3lFWjRo?=
 =?utf-8?B?NDB0MkVBY1hVMEZRSFk3ci95Yy90MGZHaEVKTWgzNU5uZnlFVnZCSU9QRHFp?=
 =?utf-8?B?OHNwS2tMTjh0dEdyWUlHTjFta2VwS3ArajRtclJGYUp3QTk0OFBOcHA1aUJy?=
 =?utf-8?B?TWRRR2RxWVZpK0Z4Q25aYXhRcmVRMEJmd2VZYi85Z0F1T0pqeWtZaWNjRGVm?=
 =?utf-8?B?NlhDNTRVYUZhZUtNb295SDJFdk9aeExrR2hDcFQ5NkFqU3NFaGt0NjR4Qyts?=
 =?utf-8?B?WGswUFF1eFljRXVJOWt6Tjd2ejYxT3AydmJRRmxQTTNKRFArcVRvaTRuSlI1?=
 =?utf-8?B?endFNUpZNXpMczNQdkh6SUcwWnpPK0RrcTl4WWRsejRtRFZYMW5uaC9vZGlR?=
 =?utf-8?B?SjU4TGc2UzJFOW1rbHVYNEdYcXZ0NGlzcFZhZFBXOHZiclNTcVhKeVRIK3dk?=
 =?utf-8?B?d3E5bFlSRTdZOXFIQnJ5UmlRaW1LRXZHeEE1Q1JSYzVTa1VNWVZEQzBvb2ZG?=
 =?utf-8?B?UWtlenlaSGVVd0ptVHh6Undob1EwdEF4eGhzcVNRQlFXWDlRd09JT1lvT2ZS?=
 =?utf-8?B?cVk4di8wVkNMZFJlSjljdDMwOEp0WHppalRVYWVBWm90L3pxbGpmK21TWFFK?=
 =?utf-8?B?QldXWmdJTlViVXd6VDlwcERRNVN3YnRPTVNueTMraFJTZERNY29PeFIvdWNu?=
 =?utf-8?B?Rlk0N05aS29XNkEybmFhNTRsL0wxaEhLSVBoMEdmNmtRRm92VzFkWld1TEVR?=
 =?utf-8?B?Mi8rS0hTTDBGRi8vZUI0NCsxSlhpU2hIYlBRQ25NZGU3TlpCNnFNdXdUWHdy?=
 =?utf-8?B?SDFLZXpaOEF5aHBxR0pDU2Erckk0b0xSby9kRXFMeTBYSVdrWGdodWRKU1Uz?=
 =?utf-8?B?MHM5c0dBUXdDN0xIcHc4c0laWDdUWFlhNkNXcHpwZG1kVU1KSW4xRVE0eXBq?=
 =?utf-8?B?ZXYySUE5ZEtjWnY3ZGVYMlliVnVycnd0UUM0aStkejBJU1VKOU4xZGZIejkv?=
 =?utf-8?B?cEltTTgrUWhvb1B3OTcyOUJUb1hjQlhDSGUvSzUyeEdTNlhuN0FKaXJ3K1ha?=
 =?utf-8?B?V0VjT3F2N3Z2bENsZzhkbzZpUkhGZ0ZMQk9DUUJjeXA0SUs2SGtva3RvZHRX?=
 =?utf-8?B?NWpoaUVCazRiSXloU2Zpekx0UkJ3SWZNOU85QktBUXNnNjI3Uk5WaTZack14?=
 =?utf-8?B?ZnJmaDhqRE94NDBDN0ZWb1Q5WHNvd29zY0RrdlBMVDN3RDBZbXVEaEpadGgz?=
 =?utf-8?B?aGNQaWs4aktzM0R2RzdFWmRUek5wV3p4TWlTbDZkZy9IUElPcng5SCtsVHpD?=
 =?utf-8?B?M3VscTRkOFNneGZqWmdyZlZYK1ZuRXBvYWlDVldhMzA3OU5CdTFSZUM2WUl4?=
 =?utf-8?B?bjBhNkZDZjhMV2NVRnY5RTVqajQ5dDd4WkEwcTVGaEx0Z0RDWHdGSzlEc1Fw?=
 =?utf-8?B?TUpWWGp5ZFhCd1lqZGFId2Q3M2pXTFBiVXVldDl1dlpCcHZxMHhwUUpHd1lj?=
 =?utf-8?B?RVVkbUZxS2ljU2tFNmxzY015V2pvRk82K2hrZDBuQmp1NUtyVVUweDY5cEUv?=
 =?utf-8?B?T2dEeEF3bjlHWXp6TjMxMGhYbXFVd3RjL1YzRTFieGtteUsvdDVibVFxNnUv?=
 =?utf-8?B?RG11Zk02YXNvN1c2OG15OWNUek5scWNrQ2t4YXZEQ3c2aVZUTFphcHdreWJC?=
 =?utf-8?B?RWxQRnNLaWZwcEE2VURwTktDZUNDbVVqZFBYTDBGWWtmeFZZVXgvbEM0cVg2?=
 =?utf-8?B?VVRHNTZyblNRUlhMWDA3ZHNDTVdOTmlGY2NRYUhVK0R3R3pOZ0JKNzdITDlB?=
 =?utf-8?Q?IL5yel6PLTFNCFqR0O18y2myu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0764ea-d0f4-4f90-ce94-08dd776ce30e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:46:10.9682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRBEa0wN+qapX2gCV5NZnQN5FOquX1VWvI+UYCvkBleCB+a2tSKpraBSnia9+qnwAQI/yOSPnp8g/Ciq6QZrGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF530AE3851
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


On 4/9/2025 7:11 PM, SRINIVASAN SHANMUGAM wrote:
>
> On 4/9/2025 6:45 PM, SRINIVASAN SHANMUGAM wrote:
>>
>> On 4/9/2025 4:15 PM, Christian König wrote:
>>> This reverts commit c2cc3648ba517a6c270500b5447d5a1efdad5936. Turned 
>>> out
>>> that this has some negative consequences for some workloads. Instead 
>>> check
>>> if the cleaner shader should run directly.
>>>
>>> While at it remove amdgpu_vm_need_pipeline_sync(), we also check again
>>> if the VMID has seen a GPU reset since last use and the gds switch
>>> setiing can be handled more simply as well.
>>>
>>> Also remove some duplicate checks and re-order and document the code.
>>>
>>> v2: restructure the while function
>>> v3: fix logic error pointed out by Srini
>>> v4: fix typo in comment, fix crash caused by incorrect check
>>> v5: once more fix the logic
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  6 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 94 
>>> ++++++++++----------------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 +-
>>>   3 files changed, 39 insertions(+), 66 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> index 802743efa3b3..30b58772598c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> @@ -189,10 +189,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring 
>>> *ring, unsigned int num_ibs,
>>>       }
>>>         need_ctx_switch = ring->current_ctx != fence_ctx;
>>> -    if (ring->funcs->emit_pipeline_sync && job &&
>>> -        ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
>>> -         need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, 
>>> job))) {
>>> -
>>> +    if ((job && (tmp = amdgpu_sync_get_fence(&job->explicit_sync))) ||
>>
>>
>> Direct assignment in if condition looks like may not be allowed, may 
>> be can we split this logic , something like below:?
>>
>> /* Check if job is present and get the fence */
>> if (job) {
>>     tmp = amdgpu_sync_get_fence(&job->explicit_sync);
>> }
>>
>> /* Check if pipe sync is needed */
>> if ((tmp || (amdgpu_sriov_vf(adev) && need_ctx_switch))) {
>>     need_pipe_sync = true;
>>
>>
>>> +         (amdgpu_sriov_vf(adev) && need_ctx_switch)) {
>>>           need_pipe_sync = true;
>>>             if (tmp)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index b5ddfcbbc9fc..8e99dbd70968 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -596,37 +596,6 @@ void amdgpu_vm_check_compute_bug(struct 
>>> amdgpu_device *adev)
>>>       }
>>>   }
>>>   -/**
>>> - * amdgpu_vm_need_pipeline_sync - Check if pipe sync is needed for 
>>> job.
>>> - *
>>> - * @ring: ring on which the job will be submitted
>>> - * @job: job to submit
>>> - *
>>> - * Returns:
>>> - * True if sync is needed.
>>> - */
>>> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>>> -                  struct amdgpu_job *job)
>>> -{
>>> -    struct amdgpu_device *adev = ring->adev;
>>> -    unsigned vmhub = ring->vm_hub;
>>> -    struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>> -
>>> -    if (job->vmid == 0)
>>> -        return false;
>>> -
>>> -    if (job->vm_needs_flush || ring->has_compute_vm_bug)
>>> -        return true;
>>> -
>>> -    if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
>>> -        return true;
>>> -
>>> -    if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
>>> -        return true;
>>> -
>>> -    return false;
>>> -}
>>> -
>>>   /**
>>>    * amdgpu_vm_flush - hardware flush the vm
>>>    *
>>> @@ -647,43 +616,49 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, 
>>> struct amdgpu_job *job,
>>>       unsigned vmhub = ring->vm_hub;
>>>       struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>>       struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
>>> -    bool spm_update_needed = job->spm_update_needed;
>>> -    bool gds_switch_needed = ring->funcs->emit_gds_switch &&
>>> -        job->gds_switch_needed;
>>> -    bool vm_flush_needed = job->vm_needs_flush;
>>> -    bool cleaner_shader_needed = false;
>>> -    bool pasid_mapping_needed = false;
>>> -    struct dma_fence *fence = NULL;
>>> +    bool gds_switch_needed, vm_flush_needed, spm_update_needed,
>>> +         cleaner_shader_needed
>>
>>
>> I think, should we initialize the "cleaner_shader_needed" here, 
>> cleaner_shader_needed = false?
>>
>
> or somehow, try to move below to here?
>
> "     cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
>          ring->funcs->emit_cleaner_shader && job->base.s_fence &&
>          &job->base.s_fence->scheduled == isolation->spearhead;"?
>
>>
>>> , pasid_mapping_needed;
>>> +    struct dma_fence *fence;
>>>       unsigned int patch;
>>>       int r;
>>>   +    /* First of all figure out what needs to be done */
>>>       if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>>> +        need_pipe_sync = true;
>>>           gds_switch_needed = true;
>>>           vm_flush_needed = true;
>>>           pasid_mapping_needed = true;
>>>           spm_update_needed = true;
>>> +    } else {
>>> +        gds_switch_needed = job->gds_switch_needed;
>>> +        vm_flush_needed = job->vm_needs_flush;
>>> +        mutex_lock(&id_mgr->lock);
>>> +        pasid_mapping_needed = id->pasid != job->pasid ||
>>> +            !id->pasid_mapping ||
>>> +            !dma_fence_is_signaled(id->pasid_mapping);
>>> +        mutex_unlock(&id_mgr->lock);
>>> +        spm_update_needed = job->spm_update_needed;
>>> +        need_pipe_sync |= ring->has_compute_vm_bug || 
>>> vm_flush_needed ||
>>> +            cleaner_shader_needed 

Sorry here pls:

"     cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
          ring->funcs->emit_cleaner_shader && job->base.s_fence &&
          &job->base.s_fence->scheduled == isolation->spearhead;"?


>>> || gds_switch_needed;
>>>       }
>>>   -    mutex_lock(&id_mgr->lock);
>>> -    if (id->pasid != job->pasid || !id->pasid_mapping ||
>>> -        !dma_fence_is_signaled(id->pasid_mapping))
>>> -        pasid_mapping_needed = true;
>>> -    mutex_unlock(&id_mgr->lock);
>>> -
>>> +    need_pipe_sync &= !!ring->funcs->emit_pipeline_sync;
>>>       gds_switch_needed &= !!ring->funcs->emit_gds_switch;
>>>       vm_flush_needed &= !!ring->funcs->emit_vm_flush &&
>>>               job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>>>       pasid_mapping_needed &= 
>>> adev->gmc.gmc_funcs->emit_pasid_mapping &&
>>>           ring->funcs->emit_wreg;
>>> +    spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
>>>         cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
>>>           ring->funcs->emit_cleaner_shader && job->base.s_fence &&
>>>           &job->base.s_fence->scheduled == isolation->spearhead;
>>>         if (!vm_flush_needed && !gds_switch_needed && 
>>> !need_pipe_sync &&
>>> -        !cleaner_shader_needed)
>>> +        !cleaner_shader_needed && !spm_update_needed)
>>>           return 0;
>>>   +    /* Then actually prepare the submission frame */
>>>       amdgpu_ring_ib_begin(ring);
>>>       if (ring->funcs->init_cond_exec)
>>>           patch = amdgpu_ring_init_cond_exec(ring,
>>> @@ -703,23 +678,34 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, 
>>> struct amdgpu_job *job,
>>>       if (pasid_mapping_needed)
>>>           amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>>>   -    if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
>>> +    if (spm_update_needed)
>>>           adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmid);
>>>   -    if (ring->funcs->emit_gds_switch &&
>>> -        gds_switch_needed) {
>>> +    if (gds_switch_needed)
>>>           amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>>>                           job->gds_size, job->gws_base,
>>>                           job->gws_size, job->oa_base,
>>>                           job->oa_size);
>>> -    }
>>>         if (vm_flush_needed || pasid_mapping_needed || 
>>> cleaner_shader_needed) {
>>>           r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>>>           if (r)
>>>               return r;
>>> +    } else {
>>> +        fence = NULL;
>>> +    }
>>> +
>>> +    amdgpu_ring_patch_cond_exec(ring, patch);
>>> +
>>> +    /* the double SWITCH_BUFFER here *cannot* be skipped by 
>>> COND_EXEC */
>>> +    if (ring->funcs->emit_switch_buffer) {
>>> +        amdgpu_ring_emit_switch_buffer(ring);
>>> +        amdgpu_ring_emit_switch_buffer(ring);
>>>       }
>>>   +    amdgpu_ring_ib_end(ring);
>>> +
>>> +    /* And finally remember what the ring has executed */
>>>       if (vm_flush_needed) {
>>>           mutex_lock(&id_mgr->lock);
>>>           dma_fence_put(id->last_flush);
>>> @@ -749,16 +735,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, 
>>> struct amdgpu_job *job,
>>>           mutex_unlock(&adev->enforce_isolation_mutex);
>>>       }
>>>       dma_fence_put(fence);
>>> -
>>> -    amdgpu_ring_patch_cond_exec(ring, patch);
>>> -
>>> -    /* the double SWITCH_BUFFER here *cannot* be skipped by 
>>> COND_EXEC */
>>> -    if (ring->funcs->emit_switch_buffer) {
>>> -        amdgpu_ring_emit_switch_buffer(ring);
>>> -        amdgpu_ring_emit_switch_buffer(ring);
>>> -    }
>>> -
>>> -    amdgpu_ring_ib_end(ring);
>>>       return 0;
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index daa2f9b33620..e9ecdb96bafa 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -493,7 +493,8 @@ int amdgpu_vm_validate(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm,
>>>                  struct ww_acquire_ctx *ticket,
>>>                  int (*callback)(void *p, struct amdgpu_bo *bo),
>>>                  void *param);
>>> -int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job 
>>> *job, bool need_pipe_sync);
>>> +int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>> +            bool need_pipe_sync);
>>>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>>                 struct amdgpu_vm *vm, bool immediate);
>>>   int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>> @@ -550,8 +551,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device 
>>> *adev, uint32_t min_vm_size,
>>>                  uint32_t fragment_size_default, unsigned max_level,
>>>                  unsigned max_bits);
>>>   int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct 
>>> drm_file *filp);
>>> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>>> -                  struct amdgpu_job *job);
>>>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>>>     struct amdgpu_task_info *
