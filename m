Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AD7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 18:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD9966E47E;
	Thu, 25 Nov 2021 18:03:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 180616E47E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 18:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHlUt9l+OT7yhA+egpA5c20TWQhh7XD5wSPykMXUGjJmWdRsQPDOBji0QgAmwwXkt2a332wovOMz1qagsH8Hs1G1sbsurSyF2vu8zKlM+dhJDj3ecs1XLDIPyTVIrp1SNRNqXkxCasZmw3WN7uLomBv/Abj+j9o6tb8It2HKrhxV8yb9D6+BZMMMCIVlnnlqgOVPVbeU82o4G2aDNNs5T3lwl4C5W1qlXmavgvSy+hjj/Nbg2MK92zT5qHnCXayFWCmRrEaroMDeYoBCtmUgl9+68X8RoZ3PUgNMvehHrZj7TfZJAispeUMKafQNERch8LcnwTuXnjR0Tdhx02/k/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvFgdX0kscYTbiEtXwvStdn9fh5A/XIj137XzSpjnfs=;
 b=NGTaOqOitQJS9/lSYibgxfhuCwmcFP+4kzgbFZWpV+XzN1LkiS8iYsDS/ZfAUnvvpKmh7BfbTlPKYLWtQtHI5bhy/hoT1m6XbJr56mHCKf9ir7hkINhQFOGn6GZj590sDi1yEVKaX4RESwol3SowokMMb4pko75neaULMdRq8cLajjqyaoEuO03plQjlW2yxbKWi9e87Qtmy1L5dZzqiBOESjIkPViZ5y/lItH6aeIiCm3OKTNmWgrP6GMBcW7uV4BE1SHgtTJHDcOx+JL1gLm+JFTfv1GO8c1N35ev/EtjqoLvhrniWVcEEjSYVTktSQZB5OBHavlsiDme6LZXMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvFgdX0kscYTbiEtXwvStdn9fh5A/XIj137XzSpjnfs=;
 b=PrlyTay8XSb8KvVXgyA6CYMOXWc2Wq+x0D84CTKOi4+ByFYuXf/wjPKteUNND/FYbF+LBLaRilH3HjhvwBOYKuOUqBq3AspcwfAC87zCoK2l/hJBZgF0E+ypXsK+uMHFbkVWHoxR+ioi9Ndhsd9BxeR0fKQ4QZLWgx/RiWvTiLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5210.namprd12.prod.outlook.com (2603:10b6:408:11b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 18:03:13 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.025; Thu, 25 Nov 2021
 18:03:13 +0000
Subject: Re: [PATCH v7] drm/amdgpu: handle IH ring1 overflow
From: Felix Kuehling <felix.kuehling@amd.com>
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211125151656.30514-1-Philip.Yang@amd.com>
 <3730450a-1efe-4dcf-d785-1c24100b1c01@amd.com>
Message-ID: <a63ff759-c103-655f-ce7d-69fbcad97f4e@amd.com>
Date: Thu, 25 Nov 2021 13:03:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <3730450a-1efe-4dcf-d785-1c24100b1c01@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT2PR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20 via Frontend Transport; Thu, 25 Nov 2021 18:03:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2abe760d-5c1d-4ae8-0ea5-08d9b03dd8fe
X-MS-TrafficTypeDiagnostic: BN9PR12MB5210:
X-Microsoft-Antispam-PRVS: <BN9PR12MB52102D2C0F3C5518FFC724CE92629@BN9PR12MB5210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3CcfD7YOM81eMYTwRDUmxWT5zArtR0bQ5RXDMs3WI91Q8yMA2jyJZVIr7XA+rgge6UsVYelbF6LkDcimZH9Z8KGTPijz7uGZ8Ic1op/47Mag7ghi8ypS3PNhZTeDjJC4qSgcVgK+hIjpZL0Ajz6c63UtdZHVsa8+HaXKOohxr1RVmZ45r+2L3E4NjZnPg268SWpjnXy0kZi4TlBCmcGV5UPnaq49bYngE9o2hjmcRbDn4F+cTPKY1Nq0d1rS2Foo55wqqRIHiU8GmJ9RLsA/qz/jfCTe6Lx33K0jA/XRtj2+Sjj0PoTW//kQaD0/TPKAuz88P9wvXJM6MDsHHgfwq0VhChWsfPjFYj4yLACWjCPRqOhRzrwKW2tYsIuZJlH+FzBw0RUpF1v1Cq8QvtPORLly4dacpOGkPk7mmmvVYP/DOKiiyjvFtWDoEnuWErbG3UbHeV+l9XJm7WqAYo6s4uoulcm7eSvt394YIQLI+eWAVpP6CHA0zSFQQRDujVrHCKfjkJslhVqyVZ5N0l47A7IXspds4JYZPiakFHK7ZojwJ5oG1K4CIoE9hCldkTXXVyF0+MrCPKbRWZOGK2BcR0izEB+ituHa+INNudGCKi+GYKpyrKKaSrmctLe+APrRWVHMlrndFJoJH2MGZNdm0Q5+TxuJQL6JJdla9MZRV/scS0gWwoZ9Wy1p99Epoka8o5kGfdZwRQhuMpFNRaxNY8P9g2FjaXOVPaItATjLXE940FsxHsCHU7t6+02M5qyl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(8936002)(66476007)(186003)(31696002)(26005)(38100700002)(8676002)(44832011)(83380400001)(31686004)(2906002)(66556008)(6486002)(66946007)(16576012)(36756003)(508600001)(4001150100001)(4326008)(30864003)(2616005)(956004)(86362001)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0lkZG1CeHhzd0tNWGIrWEthWmhaWlNOQ0w0SzlUeGVlRUYvQUt6SmM5eE80?=
 =?utf-8?B?MFM0QVlzTnlaQjdKZXJEZmlnRmhxMVUvSlIxaXM3UlNSWG9LQUVIY1FEU0xx?=
 =?utf-8?B?UmRXKzNKeTZRcXdnQWNBa0M1OW5HV0VqM3RiNFJFK1lXTHEwMEMvR201WjNR?=
 =?utf-8?B?Q1VCRGphSUd3RmIwNFlRYkc3RHpnQzhvRHMybUVYUHBrWGkyZDJIWFNVNmJ5?=
 =?utf-8?B?YXMvelMyWlV0dE95d1BlK2VDZm93Y0orWmpjWTZYSFV1SHhCQ3FGQm90cmVt?=
 =?utf-8?B?OWNFSDBBY3pNK09iWXVSaFdvYU1HYVlPNUsxLzI1Q1p4WGMwODJ2ZFhGOVVW?=
 =?utf-8?B?WlJaMElsaitIOUNpb3ZuOHJSanVqMzQybHhQV2JqOEVsb24vN1RrTnd4Ni94?=
 =?utf-8?B?NVo2cW9LenlmZ3hleTZkdUQ5d2s1aXFPZGtPaFQzOUhiZlhCWGxtajdTR3Uz?=
 =?utf-8?B?SHRxN0dwdzdzd1ZNZkIwaDFSd1hvMVBKQmhNb3FiMkV5dXRLQWduNnBhdWZ0?=
 =?utf-8?B?TVAyZ2E4SkkvN1BhelF2N2xPQkxnUUh4N0NtbmdWa24vV0pHUFhaclJJZG56?=
 =?utf-8?B?OTk3RVJlanFWL09VUWZUQXByODZod3pvanFpb0pYQ0UyNk1pV0dKYkcyTmZC?=
 =?utf-8?B?QXo0ZUlYT1o1MWtnSmlmUk9IMFBWNFB5TE03L05LVENoK3dBQ1VnV1pBcjMz?=
 =?utf-8?B?clcvb2xUaS8wM2J0UmJnSzg5RzQvcjg2Ukwxd0o0em9wR1NEVTJCSDNuRHIy?=
 =?utf-8?B?MXYyelVJRmR6cnBOQlZ5bnZpVVAxM3V6bGhUa0hydlV6RkVYY1NTWmdlemZI?=
 =?utf-8?B?K2ZxYWlHaTJWMkJhRnJ1SDhRU1JoUFZHRkR0NXFsVWpiQ09oKzl3K2lYVjYx?=
 =?utf-8?B?QmFMQ05MdUhyQ2t6NlBWU2wvbmgyaDFVS0JDSlB2Zko1RTA2di9ja0NFNjhU?=
 =?utf-8?B?OU4wbzN5QkxWK2E4V2huaS84QUtDOGpVMmVCZlFoZ1UxaXp4S0xPK1FOQlZu?=
 =?utf-8?B?ZTR3RSs3aGNFK005SWlLb1FreER5c05uQ083YTBSUGY5QnZnLzNlTG9ocCtU?=
 =?utf-8?B?WlJlYkdMV1ZvQXA4NWFNYTZDU3QveTdKeUV0ZmJPa0ljZk9PdDlVYnlOQWUv?=
 =?utf-8?B?MDJtOWhScmFjUlR3WllaUzg1TURua1hCcS9QOHE5Mmo0aGZYS2FMRHZtanVO?=
 =?utf-8?B?dlZjWmdtTE5nV0lnTTE1R2cxUmUzcUptUHE2ZjdvVkkvT0ZHY3NTeGdhNWRR?=
 =?utf-8?B?UWlHVndhZmx4QnB4QkRPQWJJZ1o1UlBmQWk1eWRzTGJMMFJ3SENDWWJnSmdx?=
 =?utf-8?B?ZTlRNFBRQzJWOEM5dXpkbU5MbmZzaVgzSmVrOUozalpTQkgvZmtvMXZCYjlp?=
 =?utf-8?B?MTU1RDVlcUNUNms4c1YrSVNOTFZBbXJFMUo3TGhZSkxCckJIdkZqQTFHR2tO?=
 =?utf-8?B?ZkdCaS9ZREpOUjN0WHhhU1pYRWRnemN4NE9XUVBJZ0Y0NWMzVUVRSXJKTkdO?=
 =?utf-8?B?YU1sVVlyZDU3YUVzNFRUWkt4YmsvbTNQNm94VndNUHdrRVdLVUpxVW9QYWJh?=
 =?utf-8?B?L2tydlFNTzZrbW0rWW9mT0d2cmtpVVVYZm9oOVJReWx4MzluWjRsb2t2dTd0?=
 =?utf-8?B?eGlHYnNMNzhMUUQyOFpZblBoVExTUHBSSERjeXhXNWJ4S3NwcVM5VlNZN2RH?=
 =?utf-8?B?VGRaaXFSTklaaHZ6RUFmc3pkVUpQdCtabkpObDlJVVQyR21XYjJ4bFNra2VS?=
 =?utf-8?B?OTlUVUxmS25Pb3h5T3hlMTRxc0VtV21ZeVduRUt5Y1QvOTc3aG1OdHFXczBv?=
 =?utf-8?B?dXB1SkI0NGhuQ0FpZU45Z3loa01aSHJqcHVQbEJwK1ZQbzQzbTY4OUJFZlVG?=
 =?utf-8?B?cDdraHZDNG11SThuVHNzRUt3VkNlWk40RVFQejlBbUNhZzNzQ1hlWWVFNmtz?=
 =?utf-8?B?UDh4MWdlK1dPZlpIYm9DRXlZNU12MU9PVFJySUVVZEd4U2dBaTRlVVZtQStD?=
 =?utf-8?B?M0ZzUTh0MU8wNGsvR1NhQlpnTkoxUXZjTENWS2E1RU9lZzZTMXRKV0dmTHpG?=
 =?utf-8?B?SVNienhHdElLY0pqS1ozTVlOMUwxS1JxRkxpRjlWOC9mM2R4QlhkcFlBOHR1?=
 =?utf-8?B?VitUR2VFRkJQZ1Vxbmk0S1hDQ0pZTU5UVVEwVm1GVGdGTUc4cXNaSjZ1QnhI?=
 =?utf-8?Q?r0PQWpxWavPGe4SB43YHV7Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abe760d-5c1d-4ae8-0ea5-08d9b03dd8fe
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 18:03:13.0842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIViEGTtYV+sLUhtaPzyf/3+08tvQd9MBj+ypE0/Fe/KV4M+vZrxW0qe7dH8fNhyyLXiDsfj7+bSfXzBqcBk3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5210
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2021-11-25 um 12:52 p.m. schrieb Felix Kuehling:
> Am 2021-11-25 um 10:16 a.m. schrieb Philip Yang:
>> IH ring1 is used to process GPU retry fault, overflow is enabled to
>> drain retry fault because we want receive other interrupts while
>> handling retry fault to recover range. There is no overflow flag set
>> when wptr pass rptr. Use timestamp of rptr and wptr to handle overflow
>> and drain retry fault.
>>
>> If fault timestamp goes backward, the fault is filtered and should not
>> be processed. Drain fault is finished if latest_decoded_timestamp is
>> equal to or larger than checkpoint timestamp.
> If there can be multiple faults with the same time stamp, then this is
> not sufficient because it would allow a stale fault with the same
> timestamp to sneak through.
>
> For example there are 3 faults with the same timestamp in the ring:
>
>     ...     <- rptr
>     ...
>     fault1
>     fault2
>     fault3  <- wptr
>
> The timestamp is taken from fault3, the current wptr.
> amdgpu_ih_wait_on_checkpoint_process_ts returns when the rptr reaches
> fault1 because it has the same timestamp.
>
>     fault1  <- rptr
>     fault2
>     fault3  <- wptr
>
> At that time fault2 and fault3 are still stale faults that could lead to
> a VM fault.
>
> You would need to wait for latest_decoded_timestamp to be truly greater
> than the checkpoint (or the ring to be empty) to be sure that you've
> seen all stale faults. Other than that, this patch looks good to me.
>
> Regards,
>   Felix
>
>
>> Add amdgpu_ih_function interface decode_iv_ts for different chips to get
>> timestamp from IV entry with different iv size and timestamp offset.
>> amdgpu_ih_decode_iv_ts_helper is used for vega10, vega20, navi10.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  8 +++-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  3 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 57 ++++++++++++-------------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 16 ++++++-
>>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  2 +-
>>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  2 +-
>>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c  |  1 +
>>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c  |  1 +
>>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c  |  1 +
>>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  2 +-
>>  10 files changed, 56 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index 45761d0328c7..45e08677207d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -350,6 +350,7 @@ static inline uint64_t amdgpu_gmc_fault_key(uint64_t addr, uint16_t pasid)
>>   * amdgpu_gmc_filter_faults - filter VM faults
>>   *
>>   * @adev: amdgpu device structure
>> + * @ih: interrupt ring that the fault received from
>>   * @addr: address of the VM fault
>>   * @pasid: PASID of the process causing the fault
>>   * @timestamp: timestamp of the fault
>> @@ -358,7 +359,8 @@ static inline uint64_t amdgpu_gmc_fault_key(uint64_t addr, uint16_t pasid)
>>   * True if the fault was filtered and should not be processed further.
>>   * False if the fault is a new one and needs to be handled.
>>   */
>> -bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>> +bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
>> +			      struct amdgpu_ih_ring *ih, uint64_t addr,
>>  			      uint16_t pasid, uint64_t timestamp)
>>  {
>>  	struct amdgpu_gmc *gmc = &adev->gmc;
>> @@ -366,6 +368,10 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>>  	struct amdgpu_gmc_fault *fault;
>>  	uint32_t hash;
>>  
>> +	/* Stale retry fault if timestamp goes backward */
>> +	if (amdgpu_ih_ts_after(timestamp, ih->latest_decoded_timestamp))
>> +		return true;
>> +
>>  	/* If we don't have space left in the ring buffer return immediately */
>>  	stamp = max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
>>  		AMDGPU_GMC_FAULT_TIMEOUT;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> index e55201134a01..8458cebc6d5b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -316,7 +316,8 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev,
>>  			      struct amdgpu_gmc *mc);
>>  void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
>>  			     struct amdgpu_gmc *mc);
>> -bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>> +bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
>> +			      struct amdgpu_ih_ring *ih, uint64_t addr,
>>  			      uint16_t pasid, uint64_t timestamp);
>>  void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
>>  				     uint16_t pasid);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>> index 0c7963dfacad..8d02f975f915 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>> @@ -164,52 +164,32 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>>  	}
>>  }
>>  
>> -/* Waiter helper that checks current rptr matches or passes checkpoint wptr */
>> -static bool amdgpu_ih_has_checkpoint_processed(struct amdgpu_device *adev,
>> -					struct amdgpu_ih_ring *ih,
>> -					uint32_t checkpoint_wptr,
>> -					uint32_t *prev_rptr)
>> -{
>> -	uint32_t cur_rptr = ih->rptr | (*prev_rptr & ~ih->ptr_mask);
>> -
>> -	/* rptr has wrapped. */
>> -	if (cur_rptr < *prev_rptr)
>> -		cur_rptr += ih->ptr_mask + 1;
>> -	*prev_rptr = cur_rptr;
>> -
>> -	/* check ring is empty to workaround missing wptr overflow flag */
>> -	return cur_rptr >= checkpoint_wptr ||
>> -	       (cur_rptr & ih->ptr_mask) == amdgpu_ih_get_wptr(adev, ih);
>> -}
>> -
>>  /**
>> - * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs up to checkpoint
>> + * amdgpu_ih_wait_on_checkpoint_process_ts - wait to process IVs up to checkpoint
>>   *
>>   * @adev: amdgpu_device pointer
>>   * @ih: ih ring to process
>>   *
>>   * Used to ensure ring has processed IVs up to the checkpoint write pointer.
>>   */
>> -int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
>> +int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
>>  					struct amdgpu_ih_ring *ih)
>>  {
>> -	uint32_t checkpoint_wptr, rptr;
>> +	uint32_t checkpoint_wptr;
>> +	uint64_t checkpoint_ts;
>> +	long timeout = HZ;
>>  
>>  	if (!ih->enabled || adev->shutdown)
>>  		return -ENODEV;
>>  
>>  	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
>> -	/* Order wptr with rptr. */
>> +	/* Order wptr with ring data. */
>>  	rmb();
>> -	rptr = READ_ONCE(ih->rptr);
>> -
>> -	/* wptr has wrapped. */
>> -	if (rptr > checkpoint_wptr)
>> -		checkpoint_wptr += ih->ptr_mask + 1;
>> +	checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
>>  
>> -	return wait_event_interruptible(ih->wait_process,
>> -				amdgpu_ih_has_checkpoint_processed(adev, ih,
>> -						checkpoint_wptr, &rptr));
>> +	return wait_event_interruptible_timeout(ih->wait_process,
>> +		    !amdgpu_ih_ts_after(ih->latest_decoded_timestamp, checkpoint_ts),
>> +		    timeout);
Your code actually does this correctly (waiting for a timestamt that's
truly greater than the checkpoint), only the commit description was
wrong. But I think you have a chance of getting a timeout when IH never
sends an interrupt with a larger timestamp, e.g. because you've already
handled all the faults before calling
amdgpu_ih_wait_on_checkpoint_process_ts and no new faults are generated.
So it may be good to add an extra check for the ring being empty to
avoid that.

Regards,
  Felix


>>  }
>>  
>>  /**
>> @@ -298,4 +278,21 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>>  
>>  	/* wptr/rptr are in bytes! */
>>  	ih->rptr += 32;
>> +	if (amdgpu_ih_ts_after(ih->latest_decoded_timestamp, entry->timestamp))
>> +		ih->latest_decoded_timestamp = entry->timestamp;
>> +}
>> +
>> +uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
>> +				       signed int offset)
>> +{
>> +	uint32_t iv_size = 32;
>> +	uint32_t ring_index;
>> +	uint32_t dw1, dw2;
>> +
>> +	rptr += iv_size * offset;
>> +	ring_index = (rptr & ih->ptr_mask) >> 2;
>> +
>> +	dw1 = le32_to_cpu(ih->ring[ring_index + 1]);
>> +	dw2 = le32_to_cpu(ih->ring[ring_index + 2]);
>> +	return dw1 | ((u64)(dw2 & 0xffff) << 32);
>>  }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>> index 0649b59830a5..322e1521287b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>> @@ -68,20 +68,30 @@ struct amdgpu_ih_ring {
>>  
>>  	/* For waiting on IH processing at checkpoint. */
>>  	wait_queue_head_t wait_process;
>> +	uint64_t		latest_decoded_timestamp;
>>  };
>>  
>> +/* return true if time stamp t2 is after t1 with 48bit wrap around */
>> +#define amdgpu_ih_ts_after(t1, t2) \
>> +		(((int64_t)((t2) << 16) - (int64_t)((t1) << 16)) > 0LL)
>> +
>>  /* provided by the ih block */
>>  struct amdgpu_ih_funcs {
>>  	/* ring read/write ptr handling, called from interrupt context */
>>  	u32 (*get_wptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>>  	void (*decode_iv)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>>  			  struct amdgpu_iv_entry *entry);
>> +	uint64_t (*decode_iv_ts)(struct amdgpu_ih_ring *ih, u32 rptr,
>> +				 signed int offset);
>>  	void (*set_rptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>>  };
>>  
>>  #define amdgpu_ih_get_wptr(adev, ih) (adev)->irq.ih_funcs->get_wptr((adev), (ih))
>>  #define amdgpu_ih_decode_iv(adev, iv) \
>>  	(adev)->irq.ih_funcs->decode_iv((adev), (ih), (iv))
>> +#define amdgpu_ih_decode_iv_ts(adev, ih, rptr, offset) \
>> +	(WARN_ON_ONCE(!(adev)->irq.ih_funcs->decode_iv_ts) ? 0 : \
>> +	(adev)->irq.ih_funcs->decode_iv_ts((ih), (rptr), (offset)))
>>  #define amdgpu_ih_set_rptr(adev, ih) (adev)->irq.ih_funcs->set_rptr((adev), (ih))
>>  
>>  int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>> @@ -89,10 +99,12 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>>  void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>>  void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>>  			  unsigned int num_dw);
>> -int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
>> -					struct amdgpu_ih_ring *ih);
>> +int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
>> +					    struct amdgpu_ih_ring *ih);
>>  int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>>  void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>>  				struct amdgpu_ih_ring *ih,
>>  				struct amdgpu_iv_entry *entry);
>> +uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
>> +				       signed int offset);
>>  #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index 3ec5ff5a6dbe..d696c4754bea 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -107,7 +107,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>>  
>>  		/* Process it onyl if it's the first fault for this address */
>>  		if (entry->ih != &adev->irq.ih_soft &&
>> -		    amdgpu_gmc_filter_faults(adev, addr, entry->pasid,
>> +		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
>>  					     entry->timestamp))
>>  			return 1;
>>  
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index cb82404df534..7490ce8295c1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -523,7 +523,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>>  
>>  		/* Process it onyl if it's the first fault for this address */
>>  		if (entry->ih != &adev->irq.ih_soft &&
>> -		    amdgpu_gmc_filter_faults(adev, addr, entry->pasid,
>> +		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
>>  					     entry->timestamp))
>>  			return 1;
>>  
>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> index 38241cf0e1f1..8ce5b8ca1fd7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> @@ -716,6 +716,7 @@ static const struct amd_ip_funcs navi10_ih_ip_funcs = {
>>  static const struct amdgpu_ih_funcs navi10_ih_funcs = {
>>  	.get_wptr = navi10_ih_get_wptr,
>>  	.decode_iv = amdgpu_ih_decode_iv_helper,
>> +	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
>>  	.set_rptr = navi10_ih_set_rptr
>>  };
>>  
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> index a9ca6988009e..3070466f54e1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> @@ -640,6 +640,7 @@ const struct amd_ip_funcs vega10_ih_ip_funcs = {
>>  static const struct amdgpu_ih_funcs vega10_ih_funcs = {
>>  	.get_wptr = vega10_ih_get_wptr,
>>  	.decode_iv = amdgpu_ih_decode_iv_helper,
>> +	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
>>  	.set_rptr = vega10_ih_set_rptr
>>  };
>>  
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> index f51dfc38ac65..3b4eb8285943 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> @@ -688,6 +688,7 @@ const struct amd_ip_funcs vega20_ih_ip_funcs = {
>>  static const struct amdgpu_ih_funcs vega20_ih_funcs = {
>>  	.get_wptr = vega20_ih_get_wptr,
>>  	.decode_iv = amdgpu_ih_decode_iv_helper,
>> +	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
>>  	.set_rptr = vega20_ih_set_rptr
>>  };
>>  
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 10868d5b549f..663489ae56d7 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1974,7 +1974,7 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
>>  
>>  		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
>>  
>> -		amdgpu_ih_wait_on_checkpoint_process(pdd->dev->adev,
>> +		amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
>>  						     &pdd->dev->adev->irq.ih1);
>>  		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
>>  	}
