Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10518D3B7F6
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2024 09:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 988DF10E087;
	Mon, 25 Nov 2024 09:28:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lLQjTP0H";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A18B010E087
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2024 09:28:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/Ii4+280rlq04RLratKVLRV/gm2uNJpDjoyDc5j9J2f1axaVmc+eRjXq5B3n1FB3GP9jYFLTbnECcAQ9ZyLFhavUDCIqZeuD+3THrrm9YvmWULVDqDJ4Krngp/+c1rg2360rlzSosq/P71qwtht5rCvGoDdk9+SfHeDhOKgp/54khx6o8Z91uA95PXHpmpxkDJ/rIP96j65pWmVZ/Pc58NgpNWs5dasuJraFunCZBRFp3bKuIEvbpLEH0t5ojhERRl7FGqehG6ygcFix2GEm6stSQvKv2NWREJmXspulG+kY5EHq+BBodkHLA2Zc0G5n0oHYWGo7lAwm5EFEVprQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFRutxNXam8phW6wH6DddXnA5iMzQwrRkbsjZRdxzXU=;
 b=OvDbxPAj0S40ngRo4z9dUbu6PPNTa6wVww15v35lDlf1klWBUrwxlr0KpZ6hQxspDZbqOIIDyx4nNiDdWwwNxutkDHIuvKrQk76K5NbnF4TlP9kJAX47E9AcCgskvauXuECk9muDcRXn4jXYKsAtD/XCFzS2koOXt8FXqTz/2zVlq27idx8TBG/05GTXQu1Fsd8EIavGE0kPfkEohJ9qh4aPvkzZw3vHKB9s5n2axCS2XTRJR37Y7vFAo92egxbk7GPDJ6UdtfSeFqeQvBd612dD+X7L9L7u3m+SZhLUcVMESPVDbK9jg6BkoBalboriPm1Z636EEADXEsqDkK++SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFRutxNXam8phW6wH6DddXnA5iMzQwrRkbsjZRdxzXU=;
 b=lLQjTP0H8XzY8qjPvIFcsf9abMbY8+0aRVX/Njj0Qu4iMqdxryz9HSwgTfay3wp3DlwLuC8/yLOjELuooTPL3/gAQ6DKC9MpRGBX+FuqV2AvY1sxiak+C/+ohsGSv+q0sFqHUdEPAERStx9K3boLRx0WrkiB2/5xvXvw3RSPGz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9074.namprd12.prod.outlook.com (2603:10b6:510:2f4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 25 Nov
 2024 09:28:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 09:28:11 +0000
Message-ID: <e96f1383-87f1-4bea-ac28-66985473752d@amd.com>
Date: Mon, 25 Nov 2024 10:28:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add NULL ptr check for non userq fences
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241120092611.177202-1-Arunpravin.PaneerSelvam@amd.com>
 <9bd31692-9372-40a4-af9c-0c34a01535f9@amd.com>
 <5dfd88a6-41eb-4731-9565-cdd5aaef2e64@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <5dfd88a6-41eb-4731-9565-cdd5aaef2e64@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0353.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: 495f0737-8a00-4b80-038a-08dd0d337ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TG1XUERwbk4wRmN6WjhNZVVRSDl1ZnVHNktIMDFUVUxtNWVHWHF2NkJnUFZT?=
 =?utf-8?B?MGZYR0dHL1hWamgxSWlyVHl1NEt5SnA0ZGxrRFZlSncvNllqYnp4ckM0UFQy?=
 =?utf-8?B?Mm5mZ1dLb0I3TEI3cGVjaHhpcXowTEx2OUFaSHBHTlErL2xXTXU2Z25Mdnlu?=
 =?utf-8?B?NS9BR0lQbStMTkFzM1QxNVlxbEJ3TlB0VXNjUGo4ODJSaXRLblFhbDdhUnNo?=
 =?utf-8?B?WnRWVko3OEYveDVmdVVUNjhGZjNxaG14RlNrK256Mm8rSEd2SElFNFUvN3Qr?=
 =?utf-8?B?R3lqcDNxUVVwZGs2dksrbDdzV0xoV3FpbDZGRmt1ME43RFpRb1JLSFJCY2xJ?=
 =?utf-8?B?SmVSTlg2L2NrcUdHZHRCQTBGTnZXWGZqTEcydzdnWWVaTXZMSDZuai9qeG96?=
 =?utf-8?B?WFplbDZMaTdCdjZIR0hiVTZKZ2RVSkhEUk9TRlFSeDB1alFaU24wbXliKzc0?=
 =?utf-8?B?TzhTR2JnbGluRG1mK2VKNitHWmRNeHZTTzhKQ1l1Mk1pN2dkOUNrNTRRRlF4?=
 =?utf-8?B?TDhMQ1FHSU9Xclk0alh5UDJrNEJkVTMyK1pKUHJEOERpaE1Hd0ZsSGJza054?=
 =?utf-8?B?NlVVam9zUjdHc3dxdlhZS0FqYWdJcW5JbDlqRW0wR1d2ZytVdkxzcTJENnZD?=
 =?utf-8?B?ZUdXc3pvTStKOWFEVllFZHFzeVREOWs1cTVYdU1qNy81Sk9pM1FhMVFNV05C?=
 =?utf-8?B?NVU3UytrVTBjUncwdkovTXR0N016bjVnRkw1YTh5MEptM0JEYjNnbGxnRlRJ?=
 =?utf-8?B?djBzZGtwbVZWaEpHRU80bHVVV1NLa3duOWhsZjdYdFhkcVg4blJPMGJkNjdN?=
 =?utf-8?B?Um9UT1dtV1lmMnlyNEg2NXdZZGdGUkYxcWlGWEdTT0xscGVjV3U4aWdLS25F?=
 =?utf-8?B?WktRd1BTNCtQSXYyZitQclhnNkk2QkNTM295UStYRGZ6K1lDLzBtV3dKR2pV?=
 =?utf-8?B?Y2lCaDRyTnVFRG9ORS9UcldpRHlqNVdQcW9aVkdlMjJFdDJUa3JlaDhaMVBp?=
 =?utf-8?B?V1hEMlZaUFlLWXFOc1Jjb21pWXFBUGEyNi9qSmNYQ0k0dERNY2VjUDE4NUN0?=
 =?utf-8?B?MERKak14eUc0TU43eUJXRjZtTHVaazB1VkMxeE5mMzRyZXFZL01Ob1VIOFpu?=
 =?utf-8?B?QnFZcjlaK1N0WnJTWkRkTzVranY4ZkJBak1DNE14TWhyVmludnAycFpBM1ZU?=
 =?utf-8?B?QVJOOUV0dXNLelAydEhXRUU1aDU2cUd3eExsZTBhUUhNdWhlYVR6VzVzUmFR?=
 =?utf-8?B?OS8velJjaWZGY2NrVnlDNlc5ck9VclVoOHArcW9UdHQ1KzlxZk5teCtOMWRi?=
 =?utf-8?B?VWxJRjZOeFR4NlBNQXBPTXBWUlhreHd2azFoS0VsSVkzcTU0dDJoQTNnU3lj?=
 =?utf-8?B?cmdTL0ZxR2xwbGM2ZHhwSXZBNmk5NUw2ajFyMWd1L1dFSUhLMGJFUzMrYjBk?=
 =?utf-8?B?b2VsNXE3NEVVQjRaeXFlWHhyMk9ud0JlV3lVZmxHNnlQd2NlSVBObmQ1L3Ux?=
 =?utf-8?B?T0NiSWZsUm9EQVo5Q2c3aHVla01mcW9tdzRvYnExNUErYXl3L3BVWEc1bkpx?=
 =?utf-8?B?WXEwRDZDdHZIVCtGV0pQV1RZcTJPdGdobys5RUwwcFFkOUZDc1V2ZnEwRU0w?=
 =?utf-8?B?ZDE5aE8vUGp5aGpiRndYTmtxYkE1U2hxMno5QzVzVEtTQVBWZXBCVVFmMG1k?=
 =?utf-8?B?dGRQTWErMTJDbm1UVThFWkp2VXFvNFhvUmhZYlowcWVNR20xR1ZHN0h4bGp3?=
 =?utf-8?B?azlXZWgxUXhteXJBVkdnaVlPMmdBYVdEeHlXSGZhUDFsMGtBSDU4L2VaWGds?=
 =?utf-8?B?bnVaamU2NklDZ25MZithZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWh2c1VCdVgyTTFaY2Ftenc3Z3NoZ3BmQ3ZaTG5sd09PK1Foc1d5eEZKYVo1?=
 =?utf-8?B?S3lCRUFnRXhHVGVGaDd1RFQyK0xPV29LdEIzSEk3QU9YSjRsT3JQRFhFRktU?=
 =?utf-8?B?OGQzYm9CbjErbXV1ZC9VVTlDTkFRTWlkd3g3Z24rSXZ5MXBOb2dzMFhhYkhC?=
 =?utf-8?B?cEgwZzdjeit1OTl4MXJCb2I2K0c4dVd3ZU9BQ3NlcXhQb2JSMTA3Q01vNXJl?=
 =?utf-8?B?NFZ0cEZYY1d1ajhGUDQvNnp5b0RFYVVMd2JOZXhhcXhqZEUvSlFPdXZNOEgr?=
 =?utf-8?B?b3NoSTNLdVFUVUNkekh2LzNPNTRScUJPYVlNTkk2ZHlOZVFHMitLQUpzMFRl?=
 =?utf-8?B?ak5Ybnl5SjE4emt1Y00wRVZrb2toMnJPSmdGVnhRN3VidDNUNkFpZUowSGww?=
 =?utf-8?B?NnRrdnFjYVZNMXBwSWEvK0dEYjhaMEFIYVk4K1kvNm83dHJoRExzK2F6Y0ZF?=
 =?utf-8?B?aSttdFBneUFBUWRvb241T3pPbVBINTBtdVkra1hGVmgvQlVVZmJMTUNiZUtX?=
 =?utf-8?B?aVk2c2tSeTM4d0crdEVPVVV0NUh6MFJzcC9QVGw2NWkrWEpSMkd5TXBicU5B?=
 =?utf-8?B?SnQraGNQSWRzQUhZUlZnbkNVY3o5cTBoaTlXVjBISDJFbU1taWswa1BBS2Rt?=
 =?utf-8?B?QmtIL3JRdGsyQ2txNFQzZHptc1hNMkNtakpXVDNnWDcxSjNKQVZYVkk4Q1FL?=
 =?utf-8?B?N3k3VFhpcG53dDJKWWt2amZVQmJNc1c2Z0dLWGJDTS9KZG94bFVnN05LOEt3?=
 =?utf-8?B?VjV1bnJIb1JuajNxT0NJNHYzakRVajRLbDRiaGZuUUhLTDJ0ZXlzUW1vOGNK?=
 =?utf-8?B?M3V2MElVWkJoTnNnWFFiTDBvaTVFa2F3ZUpIbTF4d0ZiNXJBQk55NThQMURT?=
 =?utf-8?B?ekI3ZTI0U2x6NFM4dEVqNDJIK203RHM3QjhJc3VKSzRZQ04vTmNRVzkrcklW?=
 =?utf-8?B?MUdDcXlKT0tianZIVENmU2JJWjNId1krbmtCTWl5OFBZVVd3djR0RDhVK1U0?=
 =?utf-8?B?Q0E5aDhNQW9NSk9SWDl0dUNSTTZ1dWxxdG9BRlBweUsybVlLOWVyZG5BNlQw?=
 =?utf-8?B?eUdNeWFWYnRXZHkxT3Ntb1hIVzU1Y2kwMzhabzRteFlzdEpnR0xhNi9id01x?=
 =?utf-8?B?SVYyaWZZVHdVbzFEUFk5QmxYMWQzMnhqbFdmMWdEUUtXeFJoTXZZK05vY0dP?=
 =?utf-8?B?dU13OCtDZUdhUUpGbTdsRHhTY3IzMnBtUVUwU3E5OUl3aEozZ20vdW1RZXpU?=
 =?utf-8?B?ckQzUUpRZHpFdEQ3SEc3a2t1enVxQUY1WWJoQ0Y5Z0s3cGFtK2U2MjF3NDBi?=
 =?utf-8?B?eUhMRFp4UHVqYjBSTGRmK0hKWTBXelRPUHpjeVZqQ09sc2lSd1ZlcUJuZE5N?=
 =?utf-8?B?aVcxSUE2a2J0UllRODZwR3RqMDlraGVQOGxSQXlISTNNcit1ZjZ6MXpqVk9i?=
 =?utf-8?B?VmJSYWp6VDBDUmdOa1VjNUJJNmQxaklLck9PSUdlWW1BcFJzL1Zxek9GQXZa?=
 =?utf-8?B?Z2k3bDJvSEk1RUhsVmpxdkdvZ3N5azZaQk1KRlozaEwyNTJscU9vTjBuVmhn?=
 =?utf-8?B?anNSNktUdUVRSzhueWgrOURtTzVPYlptMU9nQjVTSUlVNmxWOU1ZcjBPS1Rp?=
 =?utf-8?B?SVVDMkJZYVVPZFh5M1c1dVhBTXRQaFFaVjZKZVNrL0l5QVlERm5lUU11ZjJm?=
 =?utf-8?B?V2RqcUtMWVhycTlKRkx1UEwvWXRPaVV3TU5nNG1kM3VET2sreXB5M1YwNWRO?=
 =?utf-8?B?QnpZQXBXb0d0SmlHMGh0aVNGZjJGanNlM083MFloYnpkbHFRQUlEOVZCWStO?=
 =?utf-8?B?TEN2dWdscUhHQlN5RGw2eVNHbUQ1TEZaN1V2ZzE5NWx2aVdRcHk1Qlc4ZGlT?=
 =?utf-8?B?Mit3Yko1NU9HQ0JaZTFMalR4RXBrMjd1TjNsSzB2MytEa0p1a1VKZTVWWUFp?=
 =?utf-8?B?a2xveDNrY1BLSExjN3E4WHpqdEJjZC9JdS9EQ0gxL0NxbEdyY05acWsrK2V1?=
 =?utf-8?B?N245cUpJN3h3NFdQZlo0TVhrbitlWVY2T0NCaWphUVlMMjFQNENpb1JNWGFx?=
 =?utf-8?B?L0lIRDQreld6SUV4TGRNVlhWYnU0aHZxRitIeHZaMXdncmJmbXZSbFZ0OGhz?=
 =?utf-8?Q?WFI3wGHNAHvKo1pVpKyptMv1w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495f0737-8a00-4b80-038a-08dd0d337ac4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 09:28:11.3431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFFcxRkxhA1dpxxYQ02peN6KVtvpgiPuCiyAM3c/BXTR3/Jn4falX6d+kd80HtnV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9074
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

Hi Arun,

Am 25.11.24 um 07:40 schrieb Paneer Selvam, Arunpravin:
> Hi Christian,
>
>
> On 11/20/2024 4:04 PM, Christian König wrote:
>> Am 20.11.24 um 10:26 schrieb Arunpravin Paneer Selvam:
>>> We are observing a NULL value in the non userq fences,
>>> thus added a NULL pointer check just to avoid the
>>> NULL pointer dereference crash.
>>>
>>> v2: Moved the NULL check above the non userq check.
>>>
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 6157a540c929..76f7babd7a54 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -815,6 +815,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>> *dev, void *data,
>>>               struct amdgpu_userq_fence *userq_fence;
>>>               u32 index;
>>>   +            if (!fences[i])
>>> +                continue;
>>
>> That should never ever happen in the first place.
>>
>> All fences in the array either come from some reservation object or 
>> drm_syncobj. If any of those are NULL then there is a bug somewhere 
>> else.
> We are observing the NULL fence for the non user queue fences, and 
> these GEM BO reservation objects are coming userspace, should we request
> mesa team to analyze this issue from userspace?

No, that is clearly a bug inside the kernel code.

The question is when and why does the kernel code add NULL into the 
fences array? That should never happen in the first place.

Regards,
Christian.

>
> Thanks,
> Arun.
>>
>> Regards,
>> Christian.
>>
>>> +
>>>               userq_fence = to_amdgpu_userq_fence(fences[i]);
>>>               if (!userq_fence) {
>>>                   /*
>

