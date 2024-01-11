Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F290DC47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 22:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AA2E10E0B5;
	Thu, 11 Jan 2024 22:41:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C973010E0B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 22:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIcRRN3EMZKp2xLEOcmqKwZJbl0BPSXIIwufF0yghVBhMrUGKlr2+E5oFw2Vy5z/hglQt2C9Y37iMa3RwH/DgtpMj5RtSpXZCSza9hyplGSJ6rRxcCySBu/rjxkVnqyxeNz5D4CfvFsO4BwJ9khwubEYj3NYPVjLx3Ef0vsW99g82wAZKP44o2T1BG4asY//CFP0rdXixq5+idyKAuo/PLDwMSpnP0SHNKEUWVM6JYboZqYhGLddP5CkRxsrcrn1gzCdQo29u5dmHuljfNJ2pI3VuXC4+q9GzgmXulm/2SkPMk+x6aUqrp9zaNYRPt+iiyfs4Y0rrcRkX5gwIBoMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKTYIcM3tKUr4O38wQlRltX/iauGMC5caz8HgxxHCZU=;
 b=Gqxv57JiNQyofozOkLExjOnIR1vU1XJ5FVyeyxvA0jdBUxcomK61R0WEPqXhK934u2MUKLvNx589UQr1pPcUwHC+LMPJ7NpQUyw2HOf7AT4fBr4y+ogB44zDEtj9qtg2XtotBpvl6l7bGATOLiPUD8J+zAaLn/YlqZuz/1bldw3fTREYRe0NJFwafDI8yCFIuKm+RcSRWzygzjQ7q7GPgAYgUDQm3ULa4zTQIXSHhKaVKPCBFgHvjI8KFUaTQ4rjakjwmsX2RBQn94OlWDsAc+pH79OyL4nMZGY6Na5vTe6JKL3+CyOju1xfiNlGWXTzFMi/JfHdtgvR6zjwPsEGBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKTYIcM3tKUr4O38wQlRltX/iauGMC5caz8HgxxHCZU=;
 b=htFBpnMQvYpD0zbUSUL+SQCoiOz+C2B/VSzuTdfOp3YCZ5yAFpWsqAYC2cpXCp05w7dsAtNhsk9OlVtUPAVUEMx7fKwu61G9SXbFGPOUNWPrvskrU59K1g4nPFo+SNGsujZ26u4zPX52AK8oEzdKKnYhxda7gF2PTwtC0Qf37pI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 22:41:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 22:41:09 +0000
Message-ID: <0a345f0a-f344-45e9-af0d-13b0c43d6234@amd.com>
Date: Thu, 11 Jan 2024 17:41:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdkfd: Relocate TBA/TMA to opposite side of
 VM hole"
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20240103043000.23971-1-ent3rm4n@gmail.com>
 <CADnq5_NexkgrEKbM39QVGo+hOmd2G0Yc0sui3jWuJsKAyb3ONg@mail.gmail.com>
 <10b32f43-7b0c-1232-1070-cf51731c5d5f@amd.com>
 <0416969a-ddf5-4c6b-9017-6a6a4384b163@amd.com>
 <2e8cd9ed-bdea-eb54-99f1-a7b854594b69@amd.com>
 <CAAxE2A6YdbbC0EKWTdAMLQK9tKmO3v17+yPvhqfby2P_bfH1pw@mail.gmail.com>
 <285317c2-4236-4a22-a6ba-26e2100dde54@amd.com>
 <CAAxE2A7+bJm7g+8S_Z3z99vinnSr_8CwjJs+YZVizOS94CekoA@mail.gmail.com>
 <CAAxE2A6c2pxv5j_Mums73Y0PYMXyASOJFoS3rXvUYuRGmbSj-g@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CAAxE2A6c2pxv5j_Mums73Y0PYMXyASOJFoS3rXvUYuRGmbSj-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0019.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::47) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: 643a4aee-4e74-4563-b30e-08dc12f6680e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILNzIYK+NkIAyZMg9ZSKpzU8AvAhgKSAPgsWxOjlwozHMm/zFVdI4vypmmzzlpyxJWxIXpvgeeFvuhO1Ip7JOcmgD84inBkxDMZr2TuyE/hqjQfjhYhJrD193/a3wSJSoTJiMnaPFVGPtp1kIHrL6EXhC7XS+tcodOQU1cjKbTSXV/iOEhBLKiyex/FLYLSzS4/33KJuv5t5NUx1Y59j8rF8IBc1ZQIv+SgwXrPNEaGvI4x6WMfOZTxKwhPq7nLg5odOIvXFv3IwSBfI+5C9vt7tMwRcQXHIHV5TaUoEIiDCobFwtGC36ogAINuXoaotQyIxYcBwymsQIUWKluwtlFBmfwsIzu1B194ewOYH8TJdXYvnHexlpp6PN1F95a4PaEvHnV4i9iYW/TQab63MXipi+zK4ep5DRPFlFvndulX2GHpWmvY4vJcgdN+7rLS/VOaO6aRuVALOQ2YgUZ3Cg1HypRvXXF6UYPDzJJVhKweJE5NXrxz6e3/hCB/5bdyYgxFifMCBN1r7MMt75/ygO1DgeMMMDjcpfPk+LzM/S3zpbMg9yBn025try23allsJp7DBSKxXixDVKDlYdIxhYWemSawTYEaF2p/eZ3KHi+vxyhhDe04FX3w0wr7xOc6XKxdNzleeRJWwgxIURETuiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(36756003)(66556008)(66946007)(478600001)(6512007)(66476007)(6506007)(53546011)(6486002)(31696002)(83380400001)(86362001)(36916002)(66574015)(38100700002)(2906002)(26005)(2616005)(316002)(6636002)(4326008)(5660300002)(44832011)(41300700001)(8936002)(110136005)(54906003)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzFLMFVSMitCZUltMG1hWTd6UmEzZjZPbGZSdmxOM3Fud3YzWEIvSElEOGJL?=
 =?utf-8?B?RjRkUmVja1ExMGdEcDF0TFBrdDlZVk5NU2dLL3hRc1BnN1IrNFI1am1mSmNm?=
 =?utf-8?B?TVVoY0xUOGxJVWl3WENhdGRlK0ZvUE54U092ekFrV1FFeUQxeVVIVlVPcWVs?=
 =?utf-8?B?ZU1ubHV3SFh6SFJIRzYvWjY3Q2xicVI3WXl3ZkNVSWl2TVFtWHNsMTBhR09S?=
 =?utf-8?B?WHBlWmNnQ2dXRjAwa0FweGtiSWlsdExSbllNVkIxMnBiWk9IS05LbmJHcFZh?=
 =?utf-8?B?dGowYnVGUk1aWURnTVdDS3MxUFRYU1RuM1IvTVJCb0xVUkhQQWV1R1UzZDZ4?=
 =?utf-8?B?eS9kSVdHWFJ5dGN6RTJ1YlZtRXBXVVJnblBYaVpucmhNK3Y2WmptTE95dkox?=
 =?utf-8?B?ajVCSEFvRHMyWEE5WitWOHg5ZDlUM2xGeGVYODZCeUw3S3IrWFd2ZFNrK2Jr?=
 =?utf-8?B?U3BWNkt6em9qUXlzREdFM0VBUDkwNlBPSHF6RktCNHZMTW41RnA2VHQvZEYv?=
 =?utf-8?B?Ny9iakNaQVc0MThMSzhTVmMzT3dQTzRKcFJINVNpdERUczRialN2VGtzUHVs?=
 =?utf-8?B?K1I3ZlQzSGV0Wnhrdjg0ZDF3cFE2R2JMb0JaV0swRkpDL1lOd3U4TFJWdkhP?=
 =?utf-8?B?blBXVmlBc2tRN2J2N3k0V0xBL1JFNjdZK1RhYWJjQUFJT001cWRqcTdaKyto?=
 =?utf-8?B?ZzVZMDZvOVhFUjNyV2RieVdSQU5uSUtEMlJHMm1tS2duWDFiam5ENGRFbUJP?=
 =?utf-8?B?cjBrekNvNFVUYWRFTXZIR1ZGaXh6R2hrVDMrRVhHb1pXekJ4RURERy9BSkFp?=
 =?utf-8?B?dURuT0FaWTNpbFlBWmFqcG44NWs1WWRFd3N6anA5ek9IOU9yUHdnWXhrZUtL?=
 =?utf-8?B?Q0tqNzN3bnBKbGZVTkhjU0pySmxmeW5LeXZjOFk2c3orSllwYnlFaFZHZTE0?=
 =?utf-8?B?NHlMWHkyNjRmc2paR0ZIdmM0bkFCV2pIbS9MdDJCMVNCYmxDTlBvdEtLb1VG?=
 =?utf-8?B?WldBaVduV25LK3V3RFpQZHZuSGJQYVViYXdjeFJWSWx0OTV3RzRYa2pyc1Vz?=
 =?utf-8?B?andRTEk2UVZRYmR2QlYyZHpNZ3hZZ1JWeHA1TW9RTmU3MS80Z1hKaCtiQUFt?=
 =?utf-8?B?UkQzMForZVdBclFyR05UUlNjbkN4Z3loT0hvTkVkWURtTFFPdnduek5QN2I5?=
 =?utf-8?B?N1ZrWkQ0UmZvdVBsb21tdk00ZUUxWDY2R01hWnVNRUcrbWI1K2dEZDc1dnpw?=
 =?utf-8?B?OWprUUdFSUtCcXZuQytuY3JlWFFZamxVdVFzbjIvcE9aNTBMQ2dvSG5SSFdp?=
 =?utf-8?B?MS9wdmg5aGpJeUM4amFqZHJWMldzZ3VkVnF0cTdYVXFqckg2VGR5UGxvRDNJ?=
 =?utf-8?B?NWFodzBydm8rMDV6UDBKZnlCM2hOZklCOWtzcU4yejhERWFGdzhaNmJjUzQ4?=
 =?utf-8?B?cVBNdWR2VjhhYk96akM2QUJ4RHpJMXU0c1Nkdnd5T0UvZ2YwQjFENVc4d2xZ?=
 =?utf-8?B?aUNJV3VhdDI5NEw4ckJrZThDWWw4Y3duZ1k2RERhT3UwdkFRZWNZb0tndElI?=
 =?utf-8?B?VURJcEhvbHg2RlV6VjVRYjJFY0tmdmtLTXJNK1Z3SUdhRHNaSlgvN1g2dGti?=
 =?utf-8?B?Nm8xcGRUK05kckdQeDdQTDhndmtpVEdmYkxDTTBQZk5RTkNkemRsYnFGbytE?=
 =?utf-8?B?bG5kQkxjTlVKL2tYNmRRMWsvVERCbnJpNlA2ZnlyVUFUUGt1dFAyRG0xSU94?=
 =?utf-8?B?cXFDYVhQWXcxemtlMkR5MFRCQ21JMnltTXNlNFoxeE41cEpRa0RieXQrWEVl?=
 =?utf-8?B?Q2JxMmNrRis1bVZTd1R3SmVYTFVNRENIQUo5QVEwZTVZWGwvQ0RSeGZsSGl1?=
 =?utf-8?B?S3V4aG9hNEcrc0J5NVN5OGUxRm1kK0xZRDIvMjlaMWkwMWRxTUt5TzQvd2hw?=
 =?utf-8?B?Y1ZuekljYXJGK0ordmFYUGNBbFlWemI2NkJtOHZMdkZndUFyd2grNFpTamRn?=
 =?utf-8?B?US9ocDhYS3lsS0tYUEU1VWdJSzJOOERiTi9KY3dmSW8xbUNMVVRZOTkvM0NH?=
 =?utf-8?B?RFNLZ0ZDT1hUdzVDTExjMDk5bkJCbC9vZmFnVWk3VGsyaTNEdmpWbzF2OEdF?=
 =?utf-8?Q?sVvR5I47HOESNV+Z7r20O7f3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643a4aee-4e74-4563-b30e-08dc12f6680e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 22:41:09.8228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CJeIAcNr4A1iz9qk/mgrc5G/dp4Tf1dFAuhjqCc/Y2h3LXsaI5S3DZnwcal6TwDISQp9+CtwbJHeN1ppWXu+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857
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
Cc: Alex Deucher <alexdeucher@gmail.com>, Kaibo Ma <ent3rm4n@gmail.com>,
 Jay Cornwall <jay.cornwall@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[+Christian]

I'm looking into virtual address reservations in amdgpu and what's 
reported by AMDGPU_INFO_DEV_INFO. So far I only found 
AMDGPU_VA_RESERVED_SIZE, which is reserved both at the start of the 
lower virtual address range and the end of the upper virtual address range.

The reservation size is currently 2MB. The upper reservation is used by 
the CSA, which is currently 128KB. That leaves plenty of room for the 
TMA/TBA above the CSA. I'll create a patch for that.

Regards,
  Felix


On 2024-01-10 12:45, Marek Olšák wrote:
> It looks like this would cause failures even with regular 64-bit
> allocations because the virtual address range allocator in libdrm asks
> the kernel what ranges of addresses are free, and the kernel doesn't
> exclude the KFD allocation from that.
>
> Basically, no VM allocations can be done by the kernel outside the
> ranges reserved for the kernel.
>
> Marek
>
> On Sat, Jan 6, 2024 at 1:48 AM Marek Olšák <maraeo@gmail.com> wrote:
>> The 32-bit address space means the high 32 bits are constant and predetermined and it's definitely somewhere in the upper range of the address space. If ROCm or KFD occupy that space, even accidentally, other UMDs that use libdrm for VA allocation won't be able to start. The VA range allocator is in libdrm.
>>
>> Marek
>>
>> On Fri, Jan 5, 2024, 15:20 Felix Kuehling <felix.kuehling@amd.com> wrote:
>>> TBA/TMA were relocated to the upper half of the canonical address space.
>>> I don't think that qualifies as 32-bit by definition. But maybe you're
>>> using a different definition.
>>>
>>> That said, if Mesa manages its own virtual address space in user mode,
>>> and KFD maps the TMA/TBA at an address that Mesa believes to be free, I
>>> can see how that would lead to problems.
>>>
>>> That said, the fence refcount bug is another problem that may have been
>>> exposed by the way that a crashing Mesa application shuts down.
>>> Reverting Jay's patch certainly didn't fix that, but only hides the problem.
>>>
>>> Regards,
>>>     Felix
>>>
>>>
>>> On 2024-01-04 13:29, Marek Olšák wrote:
>>>> Hi,
>>>>
>>>> I have received information that the original commit makes all 32-bit
>>>> userspace VA allocations fail, so UMDs like Mesa can't even initialize
>>>> and they either crash or fail to load. If TBA/TMA was relocated to the
>>>> 32-bit address range, it would explain why UMDs can't allocate
>>>> anything in that range.
>>>>
>>>> Marek
>>>>
>>>> On Wed, Jan 3, 2024 at 2:50 PM Jay Cornwall <jay.cornwall@amd.com> wrote:
>>>>> On 1/3/2024 12:58, Felix Kuehling wrote:
>>>>>
>>>>>> A segfault in Mesa seems to be a different issue from what's mentioned
>>>>>> in the commit message. I'd let Christian or Marek comment on
>>>>>> compatibility with graphics UMDs. I'm not sure why this patch would
>>>>>> affect them at all.
>>>>> I was referencing this issue in OpenCL/OpenGL interop, which certainly looked related:
>>>>>
>>>>> [   91.769002] amdgpu 0000:0a:00.0: amdgpu: bo 000000009bba4692 va 0x0800000000-0x08000001ff conflict with 0x0800000000-0x0800000002
>>>>> [   91.769141] ocltst[2781]: segfault at b2 ip 00007f3fb90a7c39 sp 00007ffd3c011ba0 error 4 in radeonsi_dri.so[7f3fb888e000+1196000] likely on CPU 15 (core 7, socket 0)
>>>>>
>>>>>> Looking at the logs in the tickets, it looks like a fence reference
>>>>>> counting error. I don't see how Jay's patch could have caused that. I
>>>>>> made another change in that code recently that could make a difference
>>>>>> for this issue:
>>>>>>
>>>>>>       commit 8f08c5b24ced1be7eb49692e4816c1916233c79b
>>>>>>       Author: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>       Date:   Fri Oct 27 18:21:55 2023 -0400
>>>>>>
>>>>>>            drm/amdkfd: Run restore_workers on freezable WQs
>>>>>>
>>>>>>            Make restore workers freezable so we don't have to explicitly
>>>>>>       flush them
>>>>>>            in suspend and GPU reset code paths, and we don't accidentally
>>>>>>       try to
>>>>>>            restore BOs while the GPU is suspended. Not having to flush
>>>>>>       restore_work
>>>>>>            also helps avoid lock/fence dependencies in the GPU reset case
>>>>>>       where we're
>>>>>>            not allowed to wait for fences.
>>>>>>
>>>>>>            A side effect of this is, that we can now have multiple
>>>>>>       concurrent threads
>>>>>>            trying to signal the same eviction fence. Rework eviction fence
>>>>>>       signaling
>>>>>>            and replacement to account for that.
>>>>>>
>>>>>>            The GPU reset path can no longer rely on restore_process_worker
>>>>>>       to resume
>>>>>>            queues because evict/restore workers can run independently of
>>>>>>       it. Instead
>>>>>>            call a new restore_process_helper directly.
>>>>>>
>>>>>>            This is an RFC and request for testing.
>>>>>>
>>>>>>            v2:
>>>>>>            - Reworked eviction fence signaling
>>>>>>            - Introduced restore_process_helper
>>>>>>
>>>>>>            v3:
>>>>>>            - Handle unsignaled eviction fences in restore_process_bos
>>>>>>
>>>>>>            Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>            Acked-by: Christian König <christian.koenig@amd.com>
>>>>>>            Tested-by: Emily Deng <Emily.Deng@amd.com>
>>>>>>            Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>
>>>>>>
>>>>>> FWIW, I built a plain 6.6 kernel, and was not able to reproduce the
>>>>>> crash with some simple tests.
>>>>>>
>>>>>> Regards,
>>>>>>      Felix
>>>>>>
>>>>>>
>>>>>>> So I agree, let's revert it.
>>>>>>>
>>>>>>> Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
