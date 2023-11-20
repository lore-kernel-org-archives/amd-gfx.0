Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4472C197A0
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 16:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A31210E086;
	Mon, 20 Nov 2023 16:19:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3628310E086
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 16:19:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+Gmgdg1lw00ZXoV1uZ33E+zG2wkgtgVR5bPO6UPR6N8X/D5TTZkWfupdek/TijKa8b4KmhZJojreK8IVwbtEh7ZHKq/OfqgwRrW+bv5XWEQBDdMNbTU5NB9uB2522wNOf+F29kmRUX3hrSUys8ndU6ydULgrh+tW27txa72kTaqY4bt6gXxs27ZQbRW1WIFQr21R6Zer87XN415JAqcbzaRehhmVPRr1WSrImPCd8ZA8/QwBkZ6u6EGbAw0QBMfwdPTjfsm/VAgFCtVTCva6PQ5UKQYl1Q6IX0+AMyELmJDxH+D6MvHtiLl/WV9ePrB0B5utmS/nuWN7DJp5Ghdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDoGcuvmjsBG376qGowVvbX6f+kMFOx/lHU+EWSuMKw=;
 b=cNkymy9EAKYz990czsqozSZGb1hlzdjhJ0oV+AGaWVrx4/ndcMMmgQIi8nZdIktxRxU6CJ9/dilbkIq2TWiti1FhgiecT4wzleNS0YE+QymWNFv2CfVTKl0Qu75A8KeHZoAXqOcTDkDlG/3ql1y43Ihyv7w7AZzNd1Y/BH5woUvDHeLkegutwH2ygPfFGoarFSiA1324Vhr4hHjb3pgyni5YPJoTs7Lkl9LRVbUrukKxWpYafiUl/CEWRL2OsMAO0H7tU3U+7pHlzdDUWpQcTnZLzlULpRQJcS9tDR6FekXjlXZjycyt+967xZKAR8Unw/tvxdbWl887zqo8z8wO7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDoGcuvmjsBG376qGowVvbX6f+kMFOx/lHU+EWSuMKw=;
 b=E3jiW2Xv4i7UuG0QXor2GXDnj3VxIo5RdowWJyxfoeu0wxnqnFAsswfEfDps7P96TQ50LnO9qJqmNNNZVhcsWcRWqZ25AhbXs/6ZpU+GfnacSvAPBjRKSD/ybrNgAcrWcqyFwHcRL1572QMJ6Coi3uDK0IRokVZlBqFL/OlEL84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 16:19:16 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 16:19:16 +0000
Message-ID: <62a6ebdd-ed3b-4b95-8377-6ac34806cb82@amd.com>
Date: Mon, 20 Nov 2023 11:19:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/24] drm/amdkfd: trigger pc sampling trap for aldebaran
To: "Yat Sin, David" <David.YatSin@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-16-James.Zhu@amd.com>
 <DM6PR12MB502197027C8B46DB6A4CDDB695AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <DM6PR12MB502197027C8B46DB6A4CDDB695AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::24) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: d7eacc28-962e-48d0-90d2-08dbe9e470b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gaFWKRgWY+NItCX9AWAw2v6IzGHRvw1zvh7zWO4y8oigq3SaOImgNp57TJ3IQRwpmR9TLzgKaxhIJW4zNJIM5sdWY65gUWNz0xxQcFdKYqPZf/ipum8vEpWWKsX3W/glSualM5J9vJSFX/lDPh6hh6xAf7eN3TSNvclBi3VZukC0gr2x3dDTlD6uuS7+dWxHoeNf1VOUqJrKFMdxHo0zAlCrH5CYsj3+auAeBcvCEqlmPTw8qr1FgvHR2vJF4x+K2YnjHWyXe1aPyRQNR1QnBrMTT7Ol33EYMOydtkFgjBYGke4VjHLhU4wlwbzNMhmQdCGVi4K8Kn3ehN569/wzArgyMVv0n3+CZTIf+f8hTfc7Oh9cRsp5YrptZTUJjGKdS9dAf47wIN/PmoRRI2j+YPeq82M7BZPZeR4fDBAJlaPoDJ1Ja05uoCXyUNEIWC+F3B/2H/14RKKyBIinrk+TTJ8oSzl6I2kxRfN5AFk6geLev58QGKevlBhO1zsDpnF/KlrWapkbFvDhdE/hCEzjnEfTD7FvfB7wK6Z/piRZ5i81kkZ0i2dbMhENnLXMePotd4cfgqFCWD0/hkoghiNnNWezJbv2Stspz/ztszZ+ryNRwgbuznyZF6+YgrRIbXwZzr8dP20o/B6FquBS6fUYJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(110136005)(66946007)(66556008)(316002)(66476007)(54906003)(26005)(36756003)(8936002)(4326008)(8676002)(38100700002)(4001150100001)(41300700001)(31696002)(2906002)(5660300002)(83380400001)(6486002)(478600001)(6512007)(31686004)(6666004)(53546011)(36916002)(6506007)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU4wdCtiK21ueEFBVm5sbC9xOWVnNmxCcnozMlJBSDJzTm4weTlYSDRzblVn?=
 =?utf-8?B?alZmSGpGRGFUU0tRdGsrdVhKZjVlSnNSZ1JMOXhCSlVnZUZJbWxDTW5Cemtm?=
 =?utf-8?B?clNhSW51L3Q4L0xad0x0eTluall0M000dFdIVUdoSVhkZkQxa2kwL2srZ0xH?=
 =?utf-8?B?Qm1vUjU5MitxejV6RGcvazloRjExSHp0QURsdWV5U0cyQWt3ZUNFbHNFUU1w?=
 =?utf-8?B?MjhLblB5eHBRZE83cFE4Y0djY2RPbHlCblRIQW80MjJNN1BFa1pWUTFkQVZM?=
 =?utf-8?B?Vi9PQ0dCRGNNZ3MxTVgvaGVFWFZlVTU5eVMxZUdnMndUdk5YVzU0SzR2aHNM?=
 =?utf-8?B?ZGhGYUxuellzZXF1VE92YzlKRHdwTXQzbTJEZDIwck5wNWhpYUNsNVdKaWR6?=
 =?utf-8?B?MjBvdEJQTE1pNGhzdmVrVmpmUTIwQ2o1dDRMTWo4QkhSa1hqRWZzcEx5ZXNC?=
 =?utf-8?B?M1RGWFMyeUxLZS9HNFNqUVZmT003V0RyVy9kaFE5a1cySEtVS1RZRlNXTmtm?=
 =?utf-8?B?Q3h6Y0VaanVwdGNYMzFCL3Z1a2plTk5NVlpTVEo1NmJmeHBKT3lUUWVsV2R3?=
 =?utf-8?B?M28zSE1oc0xUcnQrdHpxY1VTRzBkMEpaeCtZcGJSQXBpRFlqbmMzK1pYK0tS?=
 =?utf-8?B?d2g3QVc4NHZZRm41YXlZY1JqSUoyYWNHZnhNMXc1OWFDd25EMktpbDJnOE9G?=
 =?utf-8?B?bHE4MHIvWTFWRHJMYzJSTGcxZXVjZjV0bjlLOGVham5OZ0E0K1A5OFFlMW1y?=
 =?utf-8?B?QVFOMXN5cVJreDhxNUo3bUpCWktqMjhaT3dPUnE1T2VLSjRIeWxPMHBnRGlB?=
 =?utf-8?B?bnEwVm56Q0dxajdMUUJMeGtRUXhlRnpnYWp2MnFDMngrV09WUlZaRmpRS0Zq?=
 =?utf-8?B?emE2azZIdjBzSkNWMlg2OWhXYkJDYjBIZjQydXpOOVJmcTVhWS9FWWNtdk4x?=
 =?utf-8?B?OWJaYU5FaDFYdDNQRE5qMGJIRUlvRGJTUkpyVHBJK2FOaE03VGhzNTVwR1Ir?=
 =?utf-8?B?bTZZZWhoQll3cG0zeDRlUURScFJNZ205dzFobHh4MmRkQWxPTDBXT2dvN1Z6?=
 =?utf-8?B?TkFPNWFhSzEwa3FlWllVTTdlQzk1a1JaSnRic25YM1huUDZQcEY2eEhYUEwy?=
 =?utf-8?B?Q2FyQ0JpL05TeXV5R3oxR244QUlMNDlRSGJidXgwWDdtSDJRUzdGUWdnak1u?=
 =?utf-8?B?REFBdURxNFkwbytXUkI3WGFwZzR2cWZvU0FZTDBTcGpkeXdKa2pXTGYzdVBP?=
 =?utf-8?B?TFcwUUhHR2l1SGoxT2s5TVcrNXZwekhFaWNaSThMU0Y4R2xUNExXUmNzaTQ1?=
 =?utf-8?B?Tk83ZDBGMHIveG1LdUFCS2RuTDVqR3FoRXQ4M3JmS3hCTC9ZVVhPQXQ0eDdT?=
 =?utf-8?B?WnBrbTZnOWF0WjFDWHNtdFVFQVQ4Z0p6SnlXZytHRWZZTUt5aHVoUklhdlcy?=
 =?utf-8?B?eW5KUjhRMUIvL1paalNVVHVwTUVaTEREaEJkRkUwWEo2djlBekVReTRKYUl0?=
 =?utf-8?B?NTFodUhwQjZIdFhwNkpxM3hxT1JMZllWN3RNRFpjWDI5b0lDZ2lFblUvcHQ1?=
 =?utf-8?B?cmFRbWRYdHI2aXZYbVZ1T2FUM051cndwVHNCNW4weVk0U3N4UEwxUndpL3Bq?=
 =?utf-8?B?WDVtaWxlblpUQnEwTjV3MDdXUGxSTWxSbXJUUWtaWEVmQUN5Vy9uekVTbVNV?=
 =?utf-8?B?Ry9xaFNpdXRDWFR2U0QzdDQ5SG5HKzFiTEZ0c2RjMWJBaFk5azkxN293Yktm?=
 =?utf-8?B?WTdDMW5XUzVDa1Izc01WVGlRSSt0Y3Y1OVVsYXgzcXRadDJudWRtS2x1a0dT?=
 =?utf-8?B?VUtZMWRkNVVPcStvODY0bXRxUXpSRUV5djBaVTF6TVRGTGdETDFmalYyb1Ry?=
 =?utf-8?B?bCtyRjBkTG1lNTUwdWlCaXRHNHc2bFcvNEU0alJ1K2hLcHhQbGhEakhPL3p0?=
 =?utf-8?B?VitRL25XazJCRFFzZXpOUnlFZVpNOFcrSTZBTS9yZGlldE9oNUdTR1p4VjJ1?=
 =?utf-8?B?a0xhYVlSeVVKWS9SZDliZWc4bS9YWTQ5dFV1V1o4bTJHNWZDUlpIT2w4cmt6?=
 =?utf-8?B?ZlJzNWhDTnNUbUtwV3haVW5QT0lOa1djSU4vcmN6MGljUnRhLzhHZnlQVUZk?=
 =?utf-8?Q?7iP0xzoNT0GwF+n2hPjqm0TYP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7eacc28-962e-48d0-90d2-08dbe9e470b8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 16:19:15.9137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oa/IHvRe829e4bx6zt6tPltKwYSYViuIPSZ9GXLVgt3D2vsTo1JlFq2UVKVO07Ie
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Greathouse,
 Joseph" <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-10 14:08, Yat Sin, David wrote:
> [AMD Official Use Only - General]
>
> I would merge this with patch 14 of the series
[JZ] it is better to keep two ASIC patches separately.
>
>> -----Original Message-----
>> From: Zhu, James <James.Zhu@amd.com>
>> Sent: Friday, November 3, 2023 9:12 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Greathouse, Joseph
>> <Joseph.Greathouse@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Zhu,
>> James <James.Zhu@amd.com>
>> Subject: [PATCH 15/24] drm/amdkfd: trigger pc sampling trap for aldebaran
>>
>> Implement trigger pc sampling trap for aldebaran.
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 11
>> +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>> index aff08321e976..27eda75ceecb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
>> @@ -163,6 +163,16 @@ static uint32_t
>> kgd_gfx_aldebaran_set_address_watch(
>>        return watch_address_cntl;
>>   }
>>
>> +static uint32_t kgd_aldebaran_trigger_pc_sample_trap(struct amdgpu_device
>> *adev,
>> +                                         uint32_t vmid,
>> +                                         uint32_t *target_simd,
>> +                                         uint32_t *target_wave_slot,
>> +                                         enum kfd_ioctl_pc_sample_method
>> method) {
>> +     return kgd_gfx_v9_trigger_pc_sample_trap(adev, vmid, 8, 4,
>> +                                     target_simd, target_wave_slot,
>> method); }
>> +
>>   const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>>        .program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
>>        .set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
>> @@ -191,4 +201,5 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>>        .get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>>        .build_grace_period_packet_info =
>> kgd_gfx_v9_build_grace_period_packet_info,
>>        .program_trap_handler_settings =
>> kgd_gfx_v9_program_trap_handler_settings,
>> +     .trigger_pc_sample_trap = kgd_aldebaran_trigger_pc_sample_trap,
>>   };
>> --
>> 2.25.1
