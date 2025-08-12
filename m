Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEB3CA0EDB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 20:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D652910E640;
	Tue, 12 Aug 2025 20:37:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="slL3ZOTM";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7FF10E640
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 20:37:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZqwtgoBXAJ7P1USeTSkQqS6+4t2dnvMJfONdSd/25HnQKTUURRArS4MCErNmqnDXD5jEikpelzYVswyxD71vAgU7fQwBR2PKF9wWuOLAdmIVkPNjYo3Qw7gf2/IsaoBdlN4F+t426uXadlZXpMWaPppD3y65XCwDak6KGuMsZktQU9ulndTDN0Dej8jwavxjhiDsd9ylf7qZirh8y4B686c9mPhSEx3G5k+0zyTkDQm3CVZjeK/7HBic+lxfEa+0hJpMaTIa3QyJAfzYVz9xZD/GDsZ2YbO5Nfn0yptljcwfGrLbQdJ3MZvFdRtqegIGV+jjiGn4WrqCYgp8j1ZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmSNFmsHHdsQVChnEyPeOPQgMjfvtYb6vaknXm3mOoo=;
 b=HyOUS9YBVDta+ZSmB7vNKEac+we+UPu5ZhDuKWBN4N7gswzlP7gjid1RuObYOnVzfnqPtNTYetb6D7LjIXhHqQ6wKXCg3vuoXkMD2yU56uV5keIggxHbijOMh3QKU9iZFJsXJT7hOVQwXJ/WzukDeFIEkaJ5SAHw63c2U9+Ikm4qaEBYktvSDO950vQzathw/5AaGEnhyGs0wbNZBRJVJThfLHPnJ4kek0OzUV/vPCeT3I5CA0oe1k3hwVe9kbMFBbUvTYUBhD7hzbyCHTQtNAMOEi/Lm/bNHdZi+CRlCLRYeLlZIog5P2vKqB3ZeqM0Nwcc2re0E7whHcBdN1l3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmSNFmsHHdsQVChnEyPeOPQgMjfvtYb6vaknXm3mOoo=;
 b=slL3ZOTMAO648n+BaP/tMXPz3E62oEpkde3/veni6FzSxIVy/VLCv5nlahgetIWpJO7SqPXsOEj7RL7cQ52Kl+FnYpxK40ERyUbh+2f+dZzBBGWls3PfSbAjiYdPnhC38aeFpHwkVyXi3ggLKb/LBT8c3aBrHt50M9WAg9zPIQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 20:37:00 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 20:37:00 +0000
Content-Type: multipart/alternative;
 boundary="------------pmY0ykAkrlDZKpXmac5Jla2n"
Message-ID: <82e1b48d-ec52-f72e-72ba-eb8010edb7ae@amd.com>
Date: Wed, 13 Aug 2025 02:06:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu/vcn: Fix video_profile switch race condition
Content-Language: en-US
To: David Wu <davidwu2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>
References: <20250812145610.1300497-1-sathishkumar.sundararaju@amd.com>
 <d9152f70-7701-470a-9e1b-5620f2d4cffb@amd.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <d9152f70-7701-470a-9e1b-5620f2d4cffb@amd.com>
X-ClientProxiedBy: PN3PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::6) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f691cfa-39ec-4be9-19a3-08ddd9dffd37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVF0N3UxVkdIbUhFTlpYanNRNkY2NEZpaG54UGx3ZzVnTWsrSkNRMVdZSHo4?=
 =?utf-8?B?S0F1SlNMaHdRS05GZnJIN1NDTkZVZ0R0d1lNSDFWM3RKQ2xYVm5HajJ1VFFU?=
 =?utf-8?B?VzJkQ2JoTDNDUUZTZ1JablE0S0xOcno3NDhvaCtZVDZybmx5SkNYYTZKa1l2?=
 =?utf-8?B?WVR6bklMYUdhdkx5VHdiQldENVhXTXZhWUxvK3ErRE8yMkl1Sk9WSjZFUXBC?=
 =?utf-8?B?Z1h6eWUrSy9SQ0pEelVPQ1JOSTFSK2I0cytkRTh4VTdObGZvdk1oWU5jWkdR?=
 =?utf-8?B?WktqMVNXc3pKcTVJalFOWDJJYWxtRk1oWGpaS1JNQWt4QUo2aE9STTdpek12?=
 =?utf-8?B?cEd5MHRac0NRSGNDZUtvWkIzblBsdDRMMm1aQ2F4Z25YYVphVjRMVFQxUUNr?=
 =?utf-8?B?RzdIS0xqM1lQVDkwQ0xKVG83S2FZVnVzbllvL3Nxb01ZdTRFMFZIbVNCbEJH?=
 =?utf-8?B?SDlWeXhCMTJOT0NmeEtOOVpnNVc4N3ZtTzBSSzk5ZW10UEFkN2d0aHZpYlJv?=
 =?utf-8?B?cmF1d3pRR1ZFOG5Sa1QrQXRYa3pwaXVwdzg3N2hSRnJ0V0p1REJEYmhNY29K?=
 =?utf-8?B?V0RpWGVnK2k3WHdCQzdWU2NyU2dRUzRjbXYwSmp0ZklaS2Vsb3oyaGp2bW5r?=
 =?utf-8?B?U1ROYjFvY3VoTFJDRVhUVmMrWDBkeEdkUFNUWUVSNkFmeW1VRFB3WnhFcW0w?=
 =?utf-8?B?eXlJOUlrMVhNTXFxOVdPemV5ckpPaWY5ZnpTV2lxRks5U09qQ3lCZk9WMFRs?=
 =?utf-8?B?cUwxS0l6RnYxL252aE9sNjRHQ1htcjlsVngwZ1UvazYvaXBvTGtjaEgxdDRz?=
 =?utf-8?B?Sk1pbXFxeUw5R3NodGFLeUVibDlHMGh3R3U4bkhvZHhoek8zZkVWek9NY3lM?=
 =?utf-8?B?aE9Zc2RMVGtEMWVRbFJvbXI2KytjYjB3bld5ZWJidUZZUzFzdVd2ZnhSdXcy?=
 =?utf-8?B?SzRWU0pYUW4yN3NjK3RNcDl2T21OSmlsams3UVJKOG9VTHdwckFuVkVYblRi?=
 =?utf-8?B?SDI5Ukp6MUpTUjEzR0I5NjdISGpBQUJIYjhEaWxCVTJRYm1rY0FJcDNlLzlu?=
 =?utf-8?B?cVZQZ3Q0SGpoSGZGRXVMUU5pVWxVMzI3NmRiWkhKZmYvWWthL01CMGg4OUZR?=
 =?utf-8?B?YjdESVZkdGErUkVySmgwQkJwZGdLVFhQZGxhdXRwWlBJdTZreFI5RTd2bGpm?=
 =?utf-8?B?TVZhZTV4L01qOE92ai9sQnVMWlF2SDFreCswL0tFT3F4M3V3S1dRRGJJSENw?=
 =?utf-8?B?aVV3cnVVNWRmRUduTFBjOXdGU25aVnFzSHozcUEzVzVudlNZNmZVOGxOV0R1?=
 =?utf-8?B?TENoTTVzZ0libUE1eUFRb29NbEFnNGpHRVgxS3hmNlVxSG11QjNkYmFXOXBi?=
 =?utf-8?B?TGVldnV1a1JoN0hMb0ZMaDB2Mm5LZHJjK0xYVnRZZHhKQ0RFczJSRTlrMUVP?=
 =?utf-8?B?VVcrajRjMFJZWjNjMzNMMnVVMk04VjdRd09jNG03a1FVZitiNzhLZVZldXVk?=
 =?utf-8?B?Sm1SeFN5YlFmS0dBRkNkOVNYN2VJbnI1Z3NSaFNJVUJsWWFGOEdrZ3M3Q2x2?=
 =?utf-8?B?NWdhMVNRNUw2cDJTblZaWXZhTUpxWVZZUEdMZ0g3QnhiSlhvelRvSUNGa0dO?=
 =?utf-8?B?NmNmdmMvdDEyTUhlZXYrSDBOdDV6Vkl2Q3NMSzE1OEhySW5vaE01VWU1WEVj?=
 =?utf-8?B?dk92dUx5VWFGcUJwZzR4bnN4TENmWnVvTEJPSmVXRkJDaG8yUVI2L3NmOEUr?=
 =?utf-8?B?ZmNDUEVlQ3ZBQ0NSRXZlYU50TW5aTnIxN3JkcGtrTXAyYW5XY0JXOTN5cXR6?=
 =?utf-8?B?MTNWQXNIbXhKY0pDTW1vNUJmMytzWlI2eTJ6K1ZKZUZTM1J3V29PdGt6ZUJz?=
 =?utf-8?B?dUh1OW00MmltcHZzdUpQRnB0Z29xcHdFbkVxNmtGd3kvdmlKTko5SXk1TW1k?=
 =?utf-8?Q?xuCqc3Ra2tA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmN1VDlVelFOMVFwd2hOb1VmYjVKVDllbFRNaVlxeG1GaGZhQi9MYk1Ock5r?=
 =?utf-8?B?UlcwcWtRNkdYVElCeTRhZ3pYY3dsVTlFaE5zMW0raC9KK3Y0VnVPWFFnZStx?=
 =?utf-8?B?cnkwQ2U2ZldoTy9lcE5jNm50a29NSUk2ZldqWFd1ejNuYVYzZFpOendKTVha?=
 =?utf-8?B?R2x1NlJQTDg2SkxqQkNRUjFRVHpyTVBZNnRhS05uaG1JMmVIYXpTbWtubFdQ?=
 =?utf-8?B?WDZzcWtKYXlpSXpNcDVheUtUNjJXQnZ5UnRGblBQMWF2bnY3YW51UThmQVZz?=
 =?utf-8?B?YVFLby9ML2xoZTJ5NGFUQ3EvQnlJaU42WVlvVVBNQnBxWVgxamhuRGppTkpi?=
 =?utf-8?B?QU93c2Z5cVUwcEp5YWlNa01NMzBxOE1BL0d1N0pCYWw2SFZucDcvNFk2MFk2?=
 =?utf-8?B?S3FnWmExQXJKL0hkb3dwa0VkZFc5QnRYQnp1N0laWVd3aUIyOHhqd0syV2xj?=
 =?utf-8?B?QndBK2pqekZETUErSTVRektKalBJU1RMMUNrTGJjZW0xeUovS2lZWGFMenhN?=
 =?utf-8?B?MGkwU1RPS3pNRkQwaGF4RURSaUxlOVNRV3llVUlRWXRDYXZNaGpZT1lPVkpu?=
 =?utf-8?B?cVArYTZiMWY2ZFc0N2dDM3ZPNHprUUgvUUU2WXpLRmtKTC9GRXdwbGV5SXVi?=
 =?utf-8?B?bmZrWDFMcUV4MmtiSldtTGJFci83cTRYaVBoYTRxS1plUjAwRDhWb3pzOTVE?=
 =?utf-8?B?Ym9kM0dqd0hEQ2puZy8xamV2Tk1SWUlldTBPa1o1QU41cHJXSlRYZitnbDBv?=
 =?utf-8?B?ZmRwb2VPU2w4Q0VIWGxQRHdoLzNyOFgxcjhpMTlXV1d2M25XQ3B3RDZvdVhk?=
 =?utf-8?B?N1gyNHJBM1J6aXI0ZDYwYkxvWGtaUG1ZdnJoU2NLRWNaREdJT0dSSk1Ea2hU?=
 =?utf-8?B?aERqdFpmWGFUdmVkakllQ1hqNzErVG9LOHVPY3A5VHdYbzFTNmRyY1BXcCtW?=
 =?utf-8?B?UG42MG5CSVpicytGREE1MVplaGFwaU5xQnBpc3N3cDZ2OWhzY3ZjWHU1SExC?=
 =?utf-8?B?UHNSMVpuQmZBcUtSOUcwSHpVWG45MFVnRXJHbCtUeHNjc0ZEanNLcUt5MUZE?=
 =?utf-8?B?TkNMVFlGSERHV2NmbU9FQ3dsZkE5WUEzSUhSRkpYeEF2V2loSmdadkY3ZHFU?=
 =?utf-8?B?enphbVhqdUZmMmZYamhiSUpiZXRMTC9BZUc5TExtSTN6Y2pXU1VGem91U3Er?=
 =?utf-8?B?Q0Y4TjNxazZTekk0SGF4U0R2SUJRcGM1a2ZHUms5RlpYZ2tucGZMemN5bDF2?=
 =?utf-8?B?M0J2akdHR3U5SzFFUk0wb2xHTEU1UWwxQVZ4L3E5R3J2cDAwUm1nM0QweWhs?=
 =?utf-8?B?bjA5ZStEblhBMjhpT2E4VDFjcjByNURBK2ZiTGVWSVVDNnRraFpYN2htWFB2?=
 =?utf-8?B?djZ6UjI3emhNSjloY1N6emJmblU4ZzRyalU3QWxIWno5YTFSU0ZrbHlleU5Z?=
 =?utf-8?B?NlB5cG5iWkdyTnIySFJtUjdPTER5bllyUTJVYndkaHhCTm1JcmV0OU93VkZG?=
 =?utf-8?B?cmRUVGxFVkdlQkxvbGgzdWFRR0NzZTR0d1BQWEZiQ3B5ajVqZGFlTjVjYWZN?=
 =?utf-8?B?MXBYdEp1MUdrdGVBbjM4U09DSmhWTktvYTdpS2xmWFJ6L0MrOUFIUlZKUDV3?=
 =?utf-8?B?VWUzby9qYkpJbE9XRWlVSDg5YjZPMkVwdnlzV1R4T2lQTG40TlBXQklhbzU2?=
 =?utf-8?B?MHhDN0h0SDFOTTMxTlFPZkNkZFE1ZHFkYzZCWkl4NFA4dU1wcWpMMGhoVm1V?=
 =?utf-8?B?UzhsRkJYdTdoaU5vbFAxbkY3WEU3TXFURU1qSmJzZkFnM0VIV256SXRLWmZ2?=
 =?utf-8?B?WjA0OWRQZnVZeGNvOXZtb1RYYStvRE96ZkJZZGxBU0RCNXFMZDBhVkZrR2dC?=
 =?utf-8?B?ajd4dWhJZGRwZjAwdGF5UlZ3SzB5N2RRMDc3SEhVZlYzLzNmK3ZCZFM4clNi?=
 =?utf-8?B?MVU2RlRjdzFvUHRvZjJzWVRSempHaUZYc0ZPOTRJWDBFN2Rac1h1WUdzc05t?=
 =?utf-8?B?Y3ozSHNURVNHZWhzWTV4NWdjMHhxSmtrekRwMjFvNElBOGdKUW5PMzZ2R2xV?=
 =?utf-8?B?SkhkTVdCSnRHU3M3NkZyQWVnbFFENkc3YTYydDBWWFU5dUlxUm1TNktnSUhU?=
 =?utf-8?Q?r1PE7M74RfAIzByCPXvTnfZJ1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f691cfa-39ec-4be9-19a3-08ddd9dffd37
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 20:37:00.7377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTE+DMuGrhRps6lfSLbWaHelXgxvWwqL+fb1uY2W+LdTZf76jC0T7L4EcoNPkQnZf/vfIIWiYkXFIoubnV0i5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229
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

--------------pmY0ykAkrlDZKpXmac5Jla2n
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 8/12/2025 10:21 PM, David Wu wrote:
>
>
> On 2025-08-12 10:56, Sathishkumar S wrote:
>> There is a race condition which leads to dpm video power
>> profile switch (disable and enable) during active video
>> decode on multi-instance VCN hardware.
>>
>> This patch aims to fix/skip step 3 in the below sequence:
>>
>>   - inst_1       power_on
>>   - inst_0(idle) power_off
>>   - inst_0(idle) video_power_profile OFF (step 3)
>>   - inst_1       video_power_profile ON during next begin_use
>>
>> Add flags to track ON/OFF vcn instances and check if all
>> instances are off before disabling video power profile.
>>
>> Protect workload_profile_active also within pg_lock and ON it
>> during first use and OFF it when last VCN instance is powered
>> OFF. VCN workload_profile_mutex can be removed after similar
>> clean up is done for vcn2_5.
>>
>> Signed-off-by: Sathishkumar S<sathishkumar.sundararaju@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 24 +++++++++---------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 ++++
>>   2 files changed, 13 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index 9a76e11d1c18..da372dd7b761 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -445,16 +445,16 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>   	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>   		mutex_lock(&vcn_inst->vcn_pg_lock);
>>   		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>> -		mutex_unlock(&vcn_inst->vcn_pg_lock);
>> -		mutex_lock(&adev->vcn.workload_profile_mutex);
>> -		if (adev->vcn.workload_profile_active) {
>> +		adev->vcn.flags &= AMDGPU_VCN_FLAG_VINST_OFF(vcn_inst->inst);
>> +		if (adev->vcn.workload_profile_active &&
>> +		    !(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_MASK(adev->vcn.num_vcn_inst))) {
>>   			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>>   							    false);
>>   			if (r)
>>   				dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
> what if there is a context switch here? since the vcn_pg_lock is per 
> instance - if another instance starts to
> call amdgpu_vcn_ring_begin_use() the amdgpu_dpm_switch_power_profile() 
> will not be called due to workload_profile_active is per device.
> I think you still have a race condition.

The situation you are explaining is bound to happen even in the current 
form of locks without this patch as well, in both cases, processes will 
run mutually exclusively at different times

with the one holding lock finishing first and then the other continues 
after, without defined ordering between them. workload_profile_active is 
common for all vcn instances, it is ON before powering ON

first inst and OFF after all the instances are powered off.

Regards,
Sathish
>
> David
>
>>   			adev->vcn.workload_profile_active = false;
>>   		}
>> -		mutex_unlock(&adev->vcn.workload_profile_mutex);
>> +		mutex_unlock(&vcn_inst->vcn_pg_lock);
>>   	} else {
>>   		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
>>   	}
>> @@ -470,14 +470,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>   
>>   	cancel_delayed_work_sync(&vcn_inst->idle_work);
>>   
>> -	/* We can safely return early here because we've cancelled the
>> -	 * the delayed work so there is no one else to set it to false
>> -	 * and we don't care if someone else sets it to true.
>> -	 */
>> -	if (adev->vcn.workload_profile_active)
>> -		goto pg_lock;
>> +	mutex_lock(&vcn_inst->vcn_pg_lock);
>>   
>> -	mutex_lock(&adev->vcn.workload_profile_mutex);
>>   	if (!adev->vcn.workload_profile_active) {
>>   		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>>   						    true);
>> @@ -485,11 +479,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>   			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
>>   		adev->vcn.workload_profile_active = true;
>>   	}
>> -	mutex_unlock(&adev->vcn.workload_profile_mutex);
>>   
>> -pg_lock:
>> -	mutex_lock(&vcn_inst->vcn_pg_lock);
>> -	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>> +	if (!(adev->vcn.flags & AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->inst))) {
>> +		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>> +		adev->vcn.flags |= AMDGPU_VCN_FLAG_VINST_ON(vcn_inst->inst);
>> +	}
>>   
>>   	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> index b3fb1d0e43fc..a876a182ff88 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> @@ -366,6 +366,10 @@ struct amdgpu_vcn {
>>   	struct mutex            workload_profile_mutex;
>>   	u32 reg_count;
>>   	const struct amdgpu_hwip_reg_entry *reg_list;
>> +#define AMDGPU_VCN_FLAG_VINST_MASK(n)  (BIT(n+1) - 1)
>> +#define AMDGPU_VCN_FLAG_VINST_ON(n)    (BIT(n))
>> +#define AMDGPU_VCN_FLAG_VINST_OFF(n)   (~BIT(n))
>> +	u32 flags;
>>   };
>>   
>>   struct amdgpu_fw_shared_rb_ptrs_struct {
--------------pmY0ykAkrlDZKpXmac5Jla2n
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi David,<br>
    </p>
    <div class="moz-cite-prefix">On 8/12/2025 10:21 PM, David Wu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:d9152f70-7701-470a-9e1b-5620f2d4cffb@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2025-08-12 10:56, Sathishkumar S
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20250812145610.1300497-1-sathishkumar.sundararaju@amd.com">
        <pre class="moz-quote-pre" wrap="">There is a race condition which leads to dpm video power
profile switch (disable and enable) during active video
decode on multi-instance VCN hardware.

This patch aims to fix/skip step 3 in the below sequence:

 - inst_1       power_on
 - inst_0(idle) power_off
 - inst_0(idle) video_power_profile OFF (step 3)
 - inst_1       video_power_profile ON during next begin_use

Add flags to track ON/OFF vcn instances and check if all
instances are off before disabling video power profile.

Protect workload_profile_active also within pg_lock and ON it
during first use and OFF it when last VCN instance is powered
OFF. VCN workload_profile_mutex can be removed after similar
clean up is done for vcn2_5.

Signed-off-by: Sathishkumar S <a class="moz-txt-link-rfc2396E" href="mailto:sathishkumar.sundararaju@amd.com" moz-do-not-send="true">&lt;sathishkumar.sundararaju@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 24 +++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 ++++
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9a76e11d1c18..da372dd7b761 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -445,16 +445,16 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	if (!fences &amp;&amp; !atomic_read(&amp;vcn_inst-&gt;total_submission_cnt)) {
 		mutex_lock(&amp;vcn_inst-&gt;vcn_pg_lock);
 		vcn_inst-&gt;set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
-		mutex_unlock(&amp;vcn_inst-&gt;vcn_pg_lock);
-		mutex_lock(&amp;adev-&gt;vcn.workload_profile_mutex);
-		if (adev-&gt;vcn.workload_profile_active) {
+		adev-&gt;vcn.flags &amp;= AMDGPU_VCN_FLAG_VINST_OFF(vcn_inst-&gt;inst);
+		if (adev-&gt;vcn.workload_profile_active &amp;&amp;
+		    !(adev-&gt;vcn.flags &amp; AMDGPU_VCN_FLAG_VINST_MASK(adev-&gt;vcn.num_vcn_inst))) {
 			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 							    false);
 			if (r)
 				dev_warn(adev-&gt;dev, &quot;(%d) failed to disable video power profile mode\n&quot;, r);</pre>
      </blockquote>
      what if there is a context switch here? since the <span style="white-space: pre-wrap">vcn_pg_lock</span>
      is per instance - if another instance starts to&nbsp;<br>
      call <span style="white-space: pre-wrap">amdgpu_vcn_ring_begin_use() the </span><span style="white-space: pre-wrap">amdgpu_dpm_switch_power_profile() will not be called due to </span><span style="white-space: pre-wrap">workload_profile_active is per device.</span><br>
      <span style="white-space: pre-wrap">I think you still have a race condition.</span></blockquote>
    <p>The situation you are explaining is bound to happen even in the
      current form of locks without this patch as well, in both cases,
      processes will run mutually exclusively at different times</p>
    <p> with the one holding lock finishing first and then the other
      continues after, without defined ordering between them. <span style="white-space: pre-wrap">workload_profile_active is common for all vcn instances, it is ON before powering ON</span></p>
    <p><span style="white-space: pre-wrap">first inst and OFF after all the instances are powered off.</span></p>
    <span style="white-space: pre-wrap">Regards,</span><br>
    <span style="white-space: pre-wrap">Sathish
</span>
    <blockquote type="cite" cite="mid:d9152f70-7701-470a-9e1b-5620f2d4cffb@amd.com">
      <p><span style="white-space: pre-wrap">David
</span></p>
      <blockquote type="cite" cite="mid:20250812145610.1300497-1-sathishkumar.sundararaju@amd.com">
        <pre class="moz-quote-pre" wrap=""> 			adev-&gt;vcn.workload_profile_active = false;
 		}
-		mutex_unlock(&amp;adev-&gt;vcn.workload_profile_mutex);
+		mutex_unlock(&amp;vcn_inst-&gt;vcn_pg_lock);
 	} else {
 		schedule_delayed_work(&amp;vcn_inst-&gt;idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -470,14 +470,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	cancel_delayed_work_sync(&amp;vcn_inst-&gt;idle_work);
 
-	/* We can safely return early here because we've cancelled the
-	 * the delayed work so there is no one else to set it to false
-	 * and we don't care if someone else sets it to true.
-	 */
-	if (adev-&gt;vcn.workload_profile_active)
-		goto pg_lock;
+	mutex_lock(&amp;vcn_inst-&gt;vcn_pg_lock);
 
-	mutex_lock(&amp;adev-&gt;vcn.workload_profile_mutex);
 	if (!adev-&gt;vcn.workload_profile_active) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 						    true);
@@ -485,11 +479,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 			dev_warn(adev-&gt;dev, &quot;(%d) failed to switch to video power profile mode\n&quot;, r);
 		adev-&gt;vcn.workload_profile_active = true;
 	}
-	mutex_unlock(&amp;adev-&gt;vcn.workload_profile_mutex);
 
-pg_lock:
-	mutex_lock(&amp;vcn_inst-&gt;vcn_pg_lock);
-	vcn_inst-&gt;set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
+	if (!(adev-&gt;vcn.flags &amp; AMDGPU_VCN_FLAG_VINST_ON(vcn_inst-&gt;inst))) {
+		vcn_inst-&gt;set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
+		adev-&gt;vcn.flags |= AMDGPU_VCN_FLAG_VINST_ON(vcn_inst-&gt;inst);
+	}
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG &amp;&amp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index b3fb1d0e43fc..a876a182ff88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -366,6 +366,10 @@ struct amdgpu_vcn {
 	struct mutex            workload_profile_mutex;
 	u32 reg_count;
 	const struct amdgpu_hwip_reg_entry *reg_list;
+#define AMDGPU_VCN_FLAG_VINST_MASK(n)  (BIT(n+1) - 1)
+#define AMDGPU_VCN_FLAG_VINST_ON(n)    (BIT(n))
+#define AMDGPU_VCN_FLAG_VINST_OFF(n)   (~BIT(n))
+	u32 flags;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------pmY0ykAkrlDZKpXmac5Jla2n--
