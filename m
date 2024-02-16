Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D2FC48260
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 09:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A228E10EAC9;
	Fri, 16 Feb 2024 09:33:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DAcNQ+BL";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0919210EAC9
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 09:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WK5FMjr01l4EY7JR8BM2WNvXLkhoj/WVMZhQ09G6BrwktXFn71O87WtAl2/14NU6rsYHqxsla/y+L1C45kkm4g9N54KIPy98KridvAusjVsjjcZ9fdOiBe187AfmbhapTz7FF5/nW9TBiWnwpZdfOFBp9dTLhIg4f55olbh0zJ+2lNRmeFTaUnzNQCxff7ysHoQabElifbAhGiwYHr8J2kqlhF76EhhfpuLCq+r4+F2cg+PhC0vyaEKasZwFwVTUpW85uqDOsUSyreil7a1A3ZUflQFMDtg9B6F4y8J9g12vtSWRZx8bBOiDSMNULV1F8DQaeX5bz5EO5YPmUH8RSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03pOeJt2eGrzDuRszD4ho0DnenlJMGJ3kPDZ8qcEcLg=;
 b=kIqLP1RWedTqiFgg06Wb/YxNN2LH5U0WP/Yy5aw2LSXzpEeGYRDibb2CR8kJIGiAcgWxjI2TZyfTqbjkyEW9NolPz9wQq77mRCUqAcnEUuo4s9hSZQQWD5E7rMVbZEel+rNZO++BaqiJgy4sRvpZF5U9RI8JT9toyzvldGTg7ajlj+Cx46uyrEW30gJkzUqlXDWWhz/PBvTmKJ8sXwkunr3DDCQUr0NUPAEiNeVZ7wHd0bOcHl/3V+WDtZVyV5xQPRXIq305NTet8m5u72YXh7+dZMuHgS4t3vADU9SiL/vw1I0y1yW5Ssw0hxp7vnaopDj+F8cye38iTwWgR/AMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03pOeJt2eGrzDuRszD4ho0DnenlJMGJ3kPDZ8qcEcLg=;
 b=DAcNQ+BLFcTbUTxEgev74yyY8NJ47XYzKPYKyoMi2mSSsPRiQ3G9bT/EGrooF2aVw198xQgv+5z7FTfGSVotPypR21vb8RmjhvbSvn19oir6nEMYMFkJzandN4LUtQ4S4CDV1MwYw3RqleUGVdQ7kaPdSNSdRSdoZdJ/K6v4qhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Fri, 16 Feb
 2024 09:33:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7292.022; Fri, 16 Feb 2024
 09:33:22 +0000
Message-ID: <77f4509d-435d-4fe2-99ba-6fecf035394d@amd.com>
Date: Fri, 16 Feb 2024 10:33:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: 7840U amdgpu MMVM_L2_PROTECTION_FAULT_STATUS
Content-Language: en-US
To: Michael Zimmermann <sigmaepsilon92@gmail.com>
Cc: regressions@lists.linux.dev, Alex Deucher <alexander.deucher@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CAN9vWDLbM3tiBQRz0rNxfrLP4bMrEOiTNLRd4avvYKiEcpUr4g@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAN9vWDLbM3tiBQRz0rNxfrLP4bMrEOiTNLRd4avvYKiEcpUr4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a361ca4-304b-4cbd-c8cb-08dc2ed25171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2PRGh2ZXLCsqCxkrBue+W9JLmiQFRcQWzlSpjS4a3vzBPasslFqNMq9yBbDZmay7cgLAcKpUT9XXT/ObAZJEjlwdM/2VWlPrNubk6ekGAI0jMwHWPyFtqweQ9X8/PCnCSqtowo3rmbpUxLrWjx5N0lATb57ZcIzcAJIESI5C5rNyCL+go8wTMKaKJwXSNtV/fMMMIZXb2e9rDQGMhwUmLSaNeIMnWtxIOTA298CB7VyPyjyG15K9YdCrs08ibuFzG66xNMDiux2bajE7qBkoSVKD0tQqNvSN7tcUMeI8f/RIkSgSABpn5keOtQIOZ4ASW8e/4J6mE5Tc5Ljn6LjuF7EStEbHB3A787UwDW4KnuwhIrFeSM683srFzP0cDjzhazfHndQpzBeP2y3aK9SXV5k03hk+xyBmrGYKfnBoqUXY/IPvJ58YLjpzuYHm45jf91RjYn0Q2u1zAGSJwWEgyCxOu6ChUF8NCV40WXWoKAsVcZxaXRuIyl+BXc2vEIEyB5dtLtKY5j4agsmRXLEGZFKNEP8TBYaKPru65xlxnOsTT6f9xYA21QOGF7ZJBO/k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(31686004)(2616005)(41300700001)(26005)(8676002)(4326008)(6916009)(2906002)(66946007)(66556008)(5660300002)(66476007)(478600001)(6486002)(316002)(6506007)(6512007)(54906003)(6666004)(8936002)(31696002)(86362001)(36756003)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDlLYjJmcEJIT3VTWC8rMUtKZ0JEdUUzZU1zZVVONFFQNkpoTkozUmVvLzc4?=
 =?utf-8?B?WG5BVHFjSUpTM3lxbmM4UVNMTEQrZUVld0N6bkdlSUNNTVNUTCtIcHNEcDJE?=
 =?utf-8?B?TlczZVR0Sm5JamxpWnZMZnJhVU1wNmkvRDZSSTlHa0JZbUdHbkNZTzZxVnUw?=
 =?utf-8?B?bTB5VmlPTXlCR3RJZ0VzUzVveE03Sk56L1F6UkI2U09CSm5WcDRtTzQ5WkFT?=
 =?utf-8?B?dmZTemdoVGFQNUxBaWNtWEFJT1VPODc2OWJRbFJ3RitnU0FLZDZsUGVyZTk4?=
 =?utf-8?B?cEc1N1Fzc0tzME9udkpXWHRZMnI1Y0d5R1VLZEphbUhMQmhwYnd6ZkVnSzM5?=
 =?utf-8?B?cXFTZXhOc2hURjZyMzdYQzNWdHFlWDBZaVlLVzFiNEdobnUwWXUrV1htZ0I0?=
 =?utf-8?B?aDRLSmdNU2xaYVpDUnYvQm0zMFNNTXZpT3IyUmNqaEtiYTFSclFEcHRGRjVI?=
 =?utf-8?B?VEJVMHJJNW42emhlTlR4RlJ1NmEyckhOb0l2UnFBbWpWQkp4aUo3UEhQSHZr?=
 =?utf-8?B?Qm81YUIvb0xDMnpSK2h4TDJmMWgxM1c3MmU2UVc1Sk5jdDY5WmJnaWtwOU0v?=
 =?utf-8?B?OG5MdVA4d3BCb1FiV3ZXdTBuUnBnYUFZYWpaMjJ1aXFXajVWUS9yMXlsd0Rl?=
 =?utf-8?B?L092VDRiNEkzZHRDaHFhL0JhTHRuMXB1M3NlUnJIbHI1QXIrZ2NUdGFFR0U4?=
 =?utf-8?B?K25ZNUw4NWJDQkoxdmQxZXB3VVVlQnhseGozS2VQaE80empxZWFmQ3U5Y3Js?=
 =?utf-8?B?cDBpNzJ1MW56Vm5PMlJQRnVwMzE3eFBVTmhyZ2pxQzlpTHVkNmM3aDZyV0p3?=
 =?utf-8?B?OTdIb1ZkaWtyZGVFbjNjNzFpQTJSMkhXUkZwTU4zTG54eC83WkwvRzFaTDN2?=
 =?utf-8?B?cXhjcGtGekZHV1A0ZkY2aW4zWm1mT283VjBCMGVwSzBHbmZVR1R2aGp0bmd0?=
 =?utf-8?B?RzBURXZmTmtBUjhoU25NUEdWNWtySjhlWjhSd2hjMnpqQjd6Rzc5dWNGSkVq?=
 =?utf-8?B?MFRmUVNyVDhBVW9CVTlUS2ZIS3B0V3FiTnlsbE9md2lyZnRTRzBlOGRlMUha?=
 =?utf-8?B?NG5CVGliVVFHOHl2SEdyUG5HNVlZQWdybm9NSzNvNXQxZ09oM09zdytPZ01V?=
 =?utf-8?B?VWR6dTU3bE1TMDNOczcvblFaeGEwYTBuRVZOTUM4UFMralc0Qk54MVRuYVZ2?=
 =?utf-8?B?dHk3eDVvQXNENjVDU2w0cnM4K1ByYjBiUGpSSVNLSUFiTmp6NGdmVHpONDdX?=
 =?utf-8?B?OUpYRWxCVG5nUUtrNmhzQklRMWdtT3JrYnY1b2hVNlFhRWhSbUtkZDVsdU4w?=
 =?utf-8?B?cjBJTVNVeWlBaHNQblBwREpKTHVRZUI4NmpmQVpMMVVyOTBCcUt4Tlh5bjhB?=
 =?utf-8?B?U1pIN3UxaTNRNEJ0YThWWWJ3Z0hQS1lSZXNibVIyTUVoSFQ3RkJwd2RnRzgv?=
 =?utf-8?B?YmdyamlkZHFKaHRXcUgrUU10dlk1anliM09qOUFlMEovQ3lnekxCQlRXbWI0?=
 =?utf-8?B?QytTNUNTZyt5UUFNbWFDdzR5aC9LSU00ZlhiRXB0ZkdjNEwvM1Q5Y0tZTS9t?=
 =?utf-8?B?RHBtSWZxOFdzRmdzOUY4UlFaWG9MTXNub0c3bHZleHd3VnRJbHk1Y2EwbFFj?=
 =?utf-8?B?VkxRMnUxVG4wQ1k4TzUvbW9KRDZwL1Rnb3ZKMGhjTzlOY3BpSDFsRFU1Rm9S?=
 =?utf-8?B?bmdmZjNUOTdjak1vRmdFQW1Sc2IxZkExcjgxOHluakdxY1NIQWZob28raUdo?=
 =?utf-8?B?aGY4M002U24xYVFtTHduVlNXK2xONzBCRmtwQlE2d1V5d2JMbXhsZ29wVm1B?=
 =?utf-8?B?Mllyd1RhYzB0Zm40bmZncmtWT3BTQ2dYVmlseXMydHJhSzJHT0hnU1hxMDd4?=
 =?utf-8?B?VWZIUWdod0FtbDJuZHRsaTVSQmNYc2NHSlBmVzU5S2hQbTdnUThpNm1LZXk4?=
 =?utf-8?B?Q0lleExLWEtUa3lZYzRIZ0o2NTFLOVl4WTZRZmF2TEdNbkw5a3I3cDhDRmhk?=
 =?utf-8?B?RjNaMWhTYjJ3RTRLRGJpSFl2VG5mNVBLbnNFMStBa3Q0R2t3c0pTdzZCOWVT?=
 =?utf-8?B?Vlo5aXZkQ0lZTmY1cW1sNlI5Z3R2NjVOMGRaLzRQeUxQcXY1OUJhZlJ4T3Zj?=
 =?utf-8?Q?IrNA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a361ca4-304b-4cbd-c8cb-08dc2ed25171
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 09:33:22.5675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imzmtJuQthHqGhByhHmMeWfEJAezD+9D+SwcyRUaDLyhtznRC+6vTuRbz0Gp8CEX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
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

Can you bisect where exactly between 6.6.0 and 6.7.4 the problems started?

Thanks,
Christian.

Am 15.02.24 um 16:59 schrieb Michael Zimmermann:
> I have a Framework 13 with a 7840U and started having massive GPU
> driver issues a few weeks ago (including system freezes).
> Unfortunately the information of when exactly this started to happen
> is gone, but It should be somewhere in between 6.6.0 and 6.7.4.
> I got many different and random dmesg-errors and system behaviors, but
> I currently can only reproduce one, so let's focus on that for now.
>
> First some basic info:
> I'm on Arch Linux using the `linux` kernel package.(currently at 6.7.4).
> I have an external monitor connected via a thinkpad thunderbolt 4 dock.
> I am using amdgpu.sg_display=0 and VRAM sharing is configured to
> UMA_GAME_OPTIMIZED in the firmware settings.
>
> If I start playing a youtube video in firefox with hardware
> acceleration enabled, it stutters until it stops playing after a few
> seconds. I can see this in the kernel log. I see this multiple times
> for many different addresses.
> [ 5641.070540] amdgpu 0000:c1:00.0: amdgpu: [mmhub] page fault
> (src_id:0 ring:40 vmid:1 pasid:32786, for process RDD Process pid 3680
> thread firefox-bi:cs0 pid 3852)
> [ 5641.070549] amdgpu 0000:c1:00.0: amdgpu:   in page starting at
> address 0x0000000000020000 from client 18
> [ 5641.070553] amdgpu 0000:c1:00.0: amdgpu:
> MMVM_L2_PROTECTION_FAULT_STATUS:0x00143A51
> [ 5641.070556] amdgpu 0000:c1:00.0: amdgpu:      Faulty UTCL2 client
> ID: unknown (0x1d)
> [ 5641.070559] amdgpu 0000:c1:00.0: amdgpu:      MORE_FAULTS: 0x1
> [ 5641.070561] amdgpu 0000:c1:00.0: amdgpu:      WALKER_ERROR: 0x0
> [ 5641.070563] amdgpu 0000:c1:00.0: amdgpu:      PERMISSION_FAULTS: 0x5
> [ 5641.070565] amdgpu 0000:c1:00.0: amdgpu:      MAPPING_ERROR: 0x0
> [ 5641.070567] amdgpu 0000:c1:00.0: amdgpu:      RW: 0x1
>
> Thanks
> Michael

