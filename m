Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21AEC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 14:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9038010E102;
	Thu, 24 Nov 2022 14:56:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192A010E102
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 14:56:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WI3jxq4TTEuXLzVOgVi6k5qpLIgKgq6FNT9G+ySb4qzhh8wN682pI1giyqnF5AV79muxYJJd1Vvk1Ucvedq1sacMXo4jrrFciWxYQQHdJHVbpG9KW+1tepVisrOCXaSKzAbUUm42jeetTUsAqcwJesj49e/mBS4oTv1gYo1cGGWykkLxsaL5V1K8V0sn5fOfXyPeOeCAXN2RrQlLzLocy4qTX5Y1RcHTPUDTSGrOWGxqmoTF/hmZCGvgcm+Kxu2MboAkmQwRdwMpzBPzoUp0x4Ue7zga/9qEavkJPb9ZxqataabK6eUulEmgdtrBk5O2i3s4hyKxUDXeXL7d1za64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiFAspXeohgH9TG+B4CwOwzBPSHfRYFzTbnYKbXTP8w=;
 b=KU6XC7FWmSpnvC5AYP8dj63lHgum5GM6gFi+TQRSDfyYbxQpXD9cvhkNNQdWUWT+ITpCApelHYGw6TNB7HxopZ/o6XaDion5hmQEpYhRAldgtEZsdd3/kEjvQrrfT3vWKpUCsID9QetLQ4xUSXOFobfEq8mmypWEVI0oN77AtzNa1fTJE2kKD1Ansq3nWkt0h3/AacaSmO68K8+lpWEWW7kOAenAmvVZHXwG2xCP5KitPvSmNx+YPv65IUX4249JGSd8d9aV2J+L+crEblkiMjCYyJoTmcnjUM5Pto2YrYz2NsIHAMIA3sewnzBSbnynRmPERrTB4qjSBFFy1JFE0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiFAspXeohgH9TG+B4CwOwzBPSHfRYFzTbnYKbXTP8w=;
 b=jHi0qbeEzK7HwFmEUulsQ2uTuNieBvKuQXgueM7AyNQKr+74oTqCDCmrKowy+rupnMTlxd3kihmjOOiNWb1hkdCA/kBPtQ8eLTiMhPHtlwJWDZtTlZwOWnEon89FUYvXqxQiza9i6Jvb+NOnirHKaW+/HKp82DLCrLMcr/E8XIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by CH0PR12MB5106.namprd12.prod.outlook.com (2603:10b6:610:bd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 14:56:52 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::6755:9455:2407:ea3e]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::6755:9455:2407:ea3e%9]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 14:56:51 +0000
Message-ID: <e40d1956-0fb6-2972-6a85-193f4e89c328@amd.com>
Date: Thu, 24 Nov 2022 20:26:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drm/amdgpu: add amdgpu vram usage information into
 amdgpu_vram_mm
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221124054945.3409867-1-KevinYang.Wang@amd.com>
 <7ad77cd9-6c35-1785-6f5a-31397d8432e7@amd.com>
 <PH7PR12MB59978C83CEDB8D1AE8BB8D80820F9@PH7PR12MB5997.namprd12.prod.outlook.com>
 <dea21b09-35ff-a180-7f64-a5b12adcebf1@gmail.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <dea21b09-35ff-a180-7f64-a5b12adcebf1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::34) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|CH0PR12MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: d53152fa-0def-4fc6-82d4-08dace2c1eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qxck2tAgXtlGR7OXQf32C+9WAMIk6nHi+oqz1OYWjDOXt61IpRiaVHCsiYxX8boK8Vj47yrnteKi8APF4Sat5FEjtPsxAU54Z/szYHN6SsGTGoNrUZYtIU0ivg1Vu9z2qauBKC2zbMtms2XitfpnZM8WpJugCQPuPtEWvk9ohxCycHaCg2StZlbAR8BKvmnz2bdvrCANZdLBHLGhUhR8KPH+8bRRz4fOp1qFziFvkwtqQjzF5lG49TY9519yIXaBiHjaNc+sAjkmMgMD2G7zQsiKoZ+fNqGaLqMHBA7fn9b59aP2V6pTApFGDHaFCY8sPhBmgH3SYL1+cAh3bH97NXOe6pzWckNjGN4GvUiACznDg/NOpWbhIsDb+OGq7e9pJuEFKi0Coy+HVfJD3DDe4Ay1JzRR/AqrBkL7Zzf7180S6fb7SwJGiEVc1jxpPCbjcZiSeq7+1dvN0lgHj49VK7gmRKRidR4hSutIfRvBPfVJaaEdd+svkCQxB0L/o/Zn0fWJhD/xnJ4+WkQWTAIEaQEVhGcoo3eA/Yubu2K5iEq/nNIPoPkPeIamGln5nQ2JInDI6qf76N6ghgwQhLkt8zzDz0bquY2Od2BoQf+PF25DU7IGyet7BTdO0MrwYxQBhd6rYbLT1X5asXStXErgCcE7jome6Zcc0WkPRGY9J8oW8u+IjUH147+qi+ge4iUc+KXHbVABIepnzHWtLN3pGzJ1wa/XaZZenom95iT+2Ao=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199015)(31686004)(86362001)(31696002)(36756003)(8936002)(30864003)(2906002)(5660300002)(66574015)(186003)(83380400001)(6512007)(2616005)(26005)(38100700002)(478600001)(6506007)(53546011)(6486002)(41300700001)(6666004)(316002)(54906003)(110136005)(66946007)(66556008)(8676002)(66476007)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUxEajR0MkRCZEVDRXh2cUN1UDRmZkhXRnBnZEMwQ250Mkw1a0J3dVgwVTZT?=
 =?utf-8?B?U2s4TUNvMU82T1JxcjZVY1pBZ2p1UWptVmtGZmFKN08wdTFldUJWYkpRSDFt?=
 =?utf-8?B?K3ZObVpLOW1ubXQyTVVvN3RYdmxPMmgyZ0tCUW05M2pDaXdJbzdmRzFyVGQr?=
 =?utf-8?B?bS9GTk04U0N2VTdTU01jRDZjWFhrWHczRUh1ODQ3WThjbzdmenR2cDN4SHlt?=
 =?utf-8?B?QUh4UzZuUVNoYkFncFZRRUdiUWpUMFp4OGJjSmJoSjJDRXdyQ3RKaVVQS2Yr?=
 =?utf-8?B?b21qQzliMFpZR1FnYUxNUUw5dTdob3lrTkpTYXB2THNkaWt6OHBEaDJ6dFRu?=
 =?utf-8?B?aVBqMmFWSUVQeFNUYjNjR3ZEVllUaWwzNEQwem1Wb2ZjRzNDV01kakVtZTA4?=
 =?utf-8?B?UnBUQ213TDBxWElrc2xHQk9SRUFKYVduQUxuTjRqb2xTeW5lOWNWaWdXK1pz?=
 =?utf-8?B?VGx3Rmg3aHNuMDdFb0RBVlZORWlvM0szeGppTjBBaGVUUXVseTZkemx1UnE1?=
 =?utf-8?B?bGU0S3NHOEp6eXdsbWw0VFAvUUxweW9oZVJWVTgyaEJ6bU9HRXBDdThoTTNz?=
 =?utf-8?B?M21JaEg1S0tUZGtCamp1TG1CUmU0czU4V3g2d2pNUWRNYStYRzlFZEZkMmV4?=
 =?utf-8?B?NU5GU3BjelkyVGVLV2pIN0wycHAzNWRtcElvdVF4MjVDcHdqMjgwcFZrMElN?=
 =?utf-8?B?T3JQckNQUW1jdUhVUksxMHRIUjlSWi96K1Y5SktRQnlJYzNIT0FMQkxMSVZP?=
 =?utf-8?B?ZjVtM2NxSHBoR08rUTNaanpjRk9mK0JCSEU0OEtiTEYyMnJtakkvbXNTV3V6?=
 =?utf-8?B?eHh6Y1h0cGYwK3VHNFlYaCs3QVp4dkViVHF6ZnF5dmowNk1rTDczeitRZEN4?=
 =?utf-8?B?bkg5L09wblpRUHVCdzlZSzEzVE5vREpmVHpBQ2J4ZTJQRExURzBxb2lSbGpH?=
 =?utf-8?B?WWJwbnhudVpreHhnT3Z6WThvM0FnV2p5UjdGWTdHUmlhNzg3MFNLZ3FlcVhL?=
 =?utf-8?B?WjBYa0x2aGV2cFpTUXZ1SHhxSXgySERNUXBWL2NNcS9QZyt1Y3dOM0NUTEVv?=
 =?utf-8?B?aUdzL2VHaDdFeHN0cnRDcXppanZVSHM0SXpoNUpPS3oyUEF4TGkrQ2pSMEli?=
 =?utf-8?B?bDU5S0owUlhFWmdQN0xHZ3M2VHMzTldndE9BK3VRazErVHF2N3lMOERSNkpS?=
 =?utf-8?B?VlByMG1FcTViVFZhNEMxc0ZUWk5SUGlUZ1hzSXFmWDFKZ0lBRnlOQ0tUSXdx?=
 =?utf-8?B?S1E2TGRIajFVTXVCSzVlbHdYYmFNK0JHSlRHY0NKYldCOUQwbnl0QTVxVGdG?=
 =?utf-8?B?bW5HOGNJYzI3dExTb3hmY3pSMllDckJ1dExDd0llQm50aEtJWm15anF2Ujd6?=
 =?utf-8?B?R25YcEEwTEhNK1lZUnp4T2lpOHBacEdMZjQzRHJxZ3BLRWNNVXUydzZOSDQ5?=
 =?utf-8?B?R05Hb2lLYzl1TDBNUGRNcm9UT25nb3Rab2I0UDNJYXZRVktxc0Q2QjUrNExT?=
 =?utf-8?B?cG1xUWNlSWppQTNPM3VSYTZLRXVTNEt0QXgvNFlOSjlUYkkyN2dZcTNHcDl3?=
 =?utf-8?B?UmNhUnhvSGpGWEhEZm5NMDJheUhZQXE2UEY5bkNNYURJVjRwV0M5S2NHZ2FS?=
 =?utf-8?B?bkw1bUtVM2xvbEF2U1V3Sml2SzZmdU12dHNHd2xTQ0gvMWRPTlBUK0NEZHlI?=
 =?utf-8?B?SlFIYnJPaGxBWFpaWGJYMkM1L1NkeFRNVndIVHlSWUwrN0wvMENZMUEwRFZl?=
 =?utf-8?B?Q0NNTVRsZEZuZi8wRlFUVTVCZC9vZGpDTUxidXYvWitKd1htekVTYmd6NEdO?=
 =?utf-8?B?TUhTRUgzQWt4SFkxbmgwQXk0eXhOb3VUSzEzQmlqN2paVWNMWkFZb0lzbDFp?=
 =?utf-8?B?SmpiSWlTOWdIeTEvN2ozUFR0UEJyQ2k4aGJmWEwzWVRDem5QN3Z4STBjK0l4?=
 =?utf-8?B?dlB1c2hiaXhVM3dPT2t6R2hDMG90Yy9UZ3I5U0ZIMTBJQlZKek0rcnRSbEFS?=
 =?utf-8?B?WHNMYmVlTzJxMC82UlBHS2dPLzg3T0QxUTdGQ1Vjamh5Ym0zMmhRZzAxZWFs?=
 =?utf-8?B?a0xGVklpOGUvYTduSjFZTWovMEY1M2FUVVNHUXJYNnNZQlhEc21DTENNU2lh?=
 =?utf-8?Q?4OGZ+fuOZ5WtoQRvvqs7m6lF7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53152fa-0def-4fc6-82d4-08dace2c1eb0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 14:56:51.8550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9t31xaaT6tLnt1EasVBSm2NJOGE5XiHgK5rBaGR7O2Ix4qsLQFz4wzjmfnoT60YMrD8Hl3KMafVu1PSAcQmiaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5106
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/24/2022 1:17 PM, Christian König wrote:
> Am 24.11.22 um 08:45 schrieb Wang, Yang(Kevin):
>> [AMD Official Use Only - General]
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, November 24, 2022 3:25 PM
>> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; 
>> amd-gfx@lists.freedesktop.org; Paneer Selvam, Arunpravin 
>> <Arunpravin.PaneerSelvam@amd.com>
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander 
>> <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: add amdgpu vram usage information 
>> into amdgpu_vram_mm
>>
>> Am 24.11.22 um 06:49 schrieb Yang Wang:
>>> add vram usage information into dri debugfs amdgpu_vram_mm node.
>>>
>>> Background:
>>> when amdgpu driver introduces drm buddy allocator, the kernel driver
>>> (and developer) is difficult to track the vram usage information.
>>>
>>> Field:
>>> 0xaaaaaaaa-0xbbbbbbbb: vram usaged range.
>>> type: kernel, device, sg
>>> usage: normal, vm, user
>>> domain: C-CPU, G-GTT, V-VRAM, P-PRIV
>>> @xxxxx: the address of "amdgpu_bo" object in kernel space.
>>> 4096: vram range range.
>>>
>>> Example:
>>> 0x00000003fea68000-0x00000003fea68fff: (type:kernel usage:vm       
>>> domain:--V- --V-) @000000001d33dfee 4096 bytes
>>> 0x00000003fea69000-0x00000003fea69fff: (type:kernel usage:vm       
>>> domain:--V- --V-) @00000000a79155b5 4096 bytes
>>> 0x00000003fea6b000-0x00000003fea6bfff: (type:kernel usage:vm       
>>> domain:--V- --V-) @0000000038ad633b 4096 bytes
>>> 0x00000003fea6c000-0x00000003fea6cfff: (type:device usage:user     
>>> domain:--V- --V-) @00000000e302f90b 4096 bytes
>>> 0x00000003fea6d000-0x00000003fea6dfff: (type:device usage:user     
>>> domain:--V- --V-) @00000000e664c172 4096 bytes
>>> 0x00000003fea6e000-0x00000003fea6efff: (type:kernel usage:vm       
>>> domain:--V- --V-) @000000004528cb2f 4096 bytes
>>> 0x00000003fea6f000-0x00000003fea6ffff: (type:kernel usage:vm       
>>> domain:--V- --V-) @00000000a446bdbf 4096 bytes
>>> 0x00000003fea70000-0x00000003fea7ffff: (type:device usage:user     
>>> domain:--V- --V-) @0000000078fae42f 65536 bytes
>>> 0x00000003fead8000-0x00000003feadbfff: (type:kernel usage:normal   
>>> domain:--V- --V-) @000000001327b7ff 16384 bytes
>>> 0x00000003feadc000-0x00000003feadcfff: (type:kernel usage:normal   
>>> domain:--V- --V-) @000000001327b7ff 4096 bytes
>>> 0x00000003feadd000-0x00000003feaddfff: (type:kernel usage:normal   
>>> domain:--V- --V-) @00000000b9706fc1 4096 bytes
>>> 0x00000003feade000-0x00000003feadefff: (type:kernel usage:vm       
>>> domain:--V- --V-) @0000000071a25571 4096 bytes
>>>
>>> Note:
>>> although some vram ranges can be merged in the example above, but this
>>> can reflect the actual distribution of drm buddy allocator.
>> Well completely NAK. This is way to much complexity for simple 
>> debugging.
>>
>> Question is what are your requirements here? E.g. what information do 
>> you want and why doesn't the buddy allocator already expose this?
>>
>> Regards,
>> Christian.
>>
>> [Kevin]:
>>
>> For KMD debug.
>> The DRM buddy interface doesn't provide an interface to query which 
>> ranges of ram(resource) are used.
>> It is not easy to debug in KMD side if driver create BO fail at 
>> specific location.
>> and from the view of KMD, the VRAM at some locations has special 
>> purposes.
>> with this patch, we can know which range of vram are actually used.
>
> Well that's not a good reason to add this complexity. Debugging 
> doesn't justify that.
>
> Please work with Arun to add the necessary information to the buddy 
> allocator interface.
>
> Regards,
> Christian.
>
Hi Kevin,

I will check and list down some of the necessary information that we can 
add to the
buddy allocator interface.

Regards,
Arun.
>>
>> Best Regards,
>> Kevin
>>> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |   6 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   |   3 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 130 
>>> ++++++++++++++++++-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h |   1 +
>>>    4 files changed, 136 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index 90eb07106609..117c754409b3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -53,7 +53,7 @@
>>>     *
>>>     */
>>>
>>> -static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>>> +void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>>>    {
>>>        struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>>>
>>> @@ -66,7 +66,7 @@ static void amdgpu_bo_destroy(struct 
>>> ttm_buffer_object *tbo)
>>>        kvfree(bo);
>>>    }
>>>
>>> -static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
>>> +void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
>>>    {
>>>        struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>>>        struct amdgpu_bo_user *ubo;
>>> @@ -76,7 +76,7 @@ static void amdgpu_bo_user_destroy(struct 
>>> ttm_buffer_object *tbo)
>>>        amdgpu_bo_destroy(tbo);
>>>    }
>>>
>>> -static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
>>> +void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
>>>    {
>>>        struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>>>        struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo); diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> index 147b79c10cbb..3f6a687309a7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> @@ -332,6 +332,9 @@ int amdgpu_bo_restore_shadow(struct amdgpu_bo 
>>> *shadow,
>>>                             struct dma_fence **fence);
>>>    uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>>>                                            uint32_t domain);
>>> +void amdgpu_bo_destroy(struct ttm_buffer_object *tbo); void
>>> +amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo); void
>>> +amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo);
>>>
>>>    /*
>>>     * sub allocation
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> index 27159f1d112e..165f4f1a8141 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> @@ -23,9 +23,11 @@
>>>     */
>>>
>>>    #include <linux/dma-mapping.h>
>>> +#include <linux/interval_tree_generic.h>
>>>    #include <drm/ttm/ttm_range_manager.h>
>>>
>>>    #include "amdgpu.h"
>>> +#include "amdgpu_object.h"
>>>    #include "amdgpu_vm.h"
>>>    #include "amdgpu_res_cursor.h"
>>>    #include "amdgpu_atomfirmware.h"
>>> @@ -38,6 +40,122 @@ struct amdgpu_vram_reservation {
>>>        struct list_head blocks;
>>>    };
>>>
>>> +struct amdgpu_vram_node {
>>> +     struct rb_node node;
>>> +     u64 start;
>>> +     u64 last;
>>> +     u64 __subtree_last;
>>> +     struct ttm_buffer_object *tbo;
>>> +};
>>> +
>>> +#define START(node) ((node)->start)
>>> +#define LAST(node) ((node)->last)
>>> +
>>> +INTERVAL_TREE_DEFINE(struct amdgpu_vram_node, node, u64, 
>>> __subtree_last,
>>> +                  START, LAST, static, amdgpu_vram_it)
>>> +
>>> +#undef START
>>> +#undef LAST
>>> +
>>> +#define for_each_vram_mm_node(node, mgr) \
>>> +     for (node = amdgpu_vram_it_iter_first(&(mgr)->root, 0, 
>>> U64_MAX); node; \
>>> +          node = amdgpu_vram_it_iter_next(node, 0, U64_MAX))
>>> +
>>> +static void amdgpu_vram_mm_add_block(struct drm_buddy_block *block,
>>> +struct amdgpu_vram_mgr *mgr, struct ttm_buffer_object *tbo) {
>>> +     struct amdgpu_vram_node *node;
>>> +
>>> +     node = kvzalloc(sizeof(*node), GFP_KERNEL);
>>> +     if (!node)
>>> +             return;
>>> +
>>> +     node->start = amdgpu_vram_mgr_block_start(block);
>>> +     node->last = node->start + amdgpu_vram_mgr_block_size(block) - 1;
>>> +     node->tbo = tbo;
>>> +
>>> +     amdgpu_vram_it_insert(node, &mgr->root); }
>>> +
>>> +static void amdgpu_vram_mm_remove_block(struct drm_buddy_block
>>> +*block, struct amdgpu_vram_mgr *mgr) {
>>> +     struct amdgpu_vram_node *node;
>>> +     u64 start, last;
>>> +
>>> +     start = amdgpu_vram_mgr_block_start(block);
>>> +     last = start + amdgpu_vram_mgr_block_size(block) - 1;
>>> +
>>> +     node = amdgpu_vram_it_iter_first(&mgr->root, start, last);
>>> +     if (node) {
>>> +             amdgpu_vram_it_remove(node, &mgr->root);
>>> +             kvfree(node);
>>> +     }
>>> +}
>>> +
>>> +static inline const char* ttm_bo_type2str(enum ttm_bo_type type) {
>>> +     switch (type) {
>>> +     case ttm_bo_type_kernel:
>>> +             return "kernel";
>>> +     case ttm_bo_type_device:
>>> +             return "device";
>>> +     case ttm_bo_type_sg:
>>> +             return "sg";
>>> +     default:
>>> +             return "unknow";
>>> +     }
>>> +}
>>> +
>>> +static inline const char* amdgpu_vram_domain_str(u32 domain, char
>>> +*tmp) {
>>> +     int index = 0;
>>> +
>>> +     tmp[index++] = domain & AMDGPU_GEM_DOMAIN_CPU ? 'C' : '-';
>>> +     tmp[index++] = domain & AMDGPU_GEM_DOMAIN_GTT ? 'G' : '-';
>>> +     tmp[index++] = domain & AMDGPU_GEM_DOMAIN_VRAM ? 'V' : '-';
>>> +     tmp[index++] = domain & (AMDGPU_GEM_DOMAIN_GDS | 
>>> AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA) ?
>>> +             'P' : '-';
>>> +     tmp[index++] = '\0';
>>> +
>>> +     return tmp;
>>> +}
>>> +
>>> +static inline const char* amdgpu_vram_bo_usage(struct
>>> +ttm_buffer_object *tbo) {
>>> +     if (tbo->destroy == &amdgpu_bo_destroy)
>>> +             return "normal";
>>> +     else if (tbo->destroy == &amdgpu_bo_user_destroy)
>>> +             return "user";
>>> +     else if (tbo->destroy == &amdgpu_bo_vm_destroy)
>>> +             return "vm";
>>> +     else
>>> +             return "unknow";
>>> +}
>>> +
>>> +static void amdgpu_vram_mm_debug(struct amdgpu_vram_mgr *mgr, struct
>>> +drm_printer *p) {
>>> +     struct amdgpu_vram_node *node;
>>> +     struct ttm_buffer_object *tbo;
>>> +     struct amdgpu_bo *abo;
>>> +     char tmp[5];
>>> +
>>> +     for_each_vram_mm_node(node, mgr) {
>>> +             tbo = node->tbo;
>>> +             abo = ttm_to_amdgpu_bo(tbo);
>>> +             drm_printf(p, "%#018llx-%#018llx:", node->start, 
>>> node->last);
>>> +             if (abo)
>>> +                     drm_printf(p, " (type:%-5s usage:%-8s 
>>> domain:%s %s) @%p",
>>> + ttm_bo_type2str(tbo->type),
>>> +                                amdgpu_vram_bo_usage(tbo),
>>> + amdgpu_vram_domain_str(abo->preferred_domains, tmp),
>>> + amdgpu_vram_domain_str(abo->allowed_domains, tmp),
>>> +                                abo);
>>> +             else
>>> +                     drm_printf(p, " (reserved)");
>>> +             drm_printf(p, " %llu bytes\n",
>>> +                        node->last - node->start + 1);
>>> +     }
>>> +}
>>> +
>>>    static inline struct amdgpu_vram_mgr *
>>>    to_vram_mgr(struct ttm_resource_manager *man)
>>>    {
>>> @@ -288,6 +406,7 @@ static void amdgpu_vram_mgr_do_reserve(struct 
>>> ttm_resource_manager *man)
>>>                dev_dbg(adev->dev, "Reservation 0x%llx - %lld, 
>>> Succeeded\n",
>>>                        rsv->start, rsv->size);
>>>
>>> +             amdgpu_vram_mm_add_block(block, mgr, NULL);
>>>                vis_usage = amdgpu_vram_mgr_vis_size(adev, block);
>>>                atomic64_add(vis_usage, &mgr->vis_usage);
>>>                spin_lock(&man->bdev->lru_lock);
>>> @@ -540,6 +659,8 @@ static int amdgpu_vram_mgr_new(struct 
>>> ttm_resource_manager *man,
>>>                vres->base.start = max(vres->base.start, start);
>>>
>>>                vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
>>> +
>>> +             amdgpu_vram_mm_add_block(block, mgr, tbo);
>>>        }
>>>
>>>        if (amdgpu_is_vram_mgr_blocks_contiguous(&vres->blocks))
>>> @@ -583,8 +704,10 @@ static void amdgpu_vram_mgr_del(struct 
>>> ttm_resource_manager *man,
>>>        uint64_t vis_usage = 0;
>>>
>>>        mutex_lock(&mgr->lock);
>>> -     list_for_each_entry(block, &vres->blocks, link)
>>> +     list_for_each_entry(block, &vres->blocks, link) {
>>>                vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
>>> +             amdgpu_vram_mm_remove_block(block, mgr);
>>> +     }
>>>
>>>        amdgpu_vram_mgr_do_reserve(man);
>>>
>>> @@ -747,6 +870,9 @@ static void amdgpu_vram_mgr_debug(struct 
>>> ttm_resource_manager *man,
>>>        drm_printf(printer, "reserved:\n");
>>>        list_for_each_entry(block, &mgr->reserved_pages, link)
>>>                drm_buddy_block_print(mm, block, printer);
>>> +     drm_printf(printer, "vram usage:\n");
>>> +     amdgpu_vram_mm_debug(mgr, printer);
>>> +
>>>        mutex_unlock(&mgr->lock);
>>>    }
>>>
>>> @@ -769,6 +895,8 @@ int amdgpu_vram_mgr_init(struct amdgpu_device 
>>> *adev)
>>>        struct ttm_resource_manager *man = &mgr->manager;
>>>        int err;
>>>
>>> +     mgr->root = RB_ROOT_CACHED;
>>> +
>>>        ttm_resource_manager_init(man, &adev->mman.bdev,
>>>                                  adev->gmc.real_vram_size);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
>>> index 0e04e42cf809..a14c56e1e407 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
>>> @@ -28,6 +28,7 @@
>>>
>>>    struct amdgpu_vram_mgr {
>>>        struct ttm_resource_manager manager;
>>> +     struct rb_root_cached root;
>>>        struct drm_buddy mm;
>>>        /* protects access to buffer objects */
>>>        struct mutex lock;
>

