Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8154BE77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 18:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30AEF10E08F;
	Fri, 10 Jan 2025 18:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pOdu488R";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AB4810E08F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 18:13:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lx03d5v4Acen8WWcMeY/72lrrQeQEBZqXy3qaA09pRNG2Gqj44FMTPm8SpEwo7b5ky+FdHJk9DJgWtW26TGMxTNh74Kp1j1HfaBV0hxtZtD6Hquvu0LhDf3D1CWYFobopY48b6TP+lbbyAVd3rcYtAdbvcyHE9znKcM9qRZB42zgxmfJWWH5Moo0DMPrjLxMr/8YO7yipI4aoREb7IAQaGxQIDbCPgu2ubbh7dB6sbYSkdDOUOp4Thv7m9s2J/ViPZX70WWp7VfZQ1lZgTBEqqtxHgKnHRfmcEel45UmJ7cSzYIysVkGxhiNZ5DujmYtLQos/bU8ledcHXarC+flxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9S/87Kiaxw0mYJt161AMN/sNpO6h3Xac4ACCs9f8aA=;
 b=j+sicaiENn7/ATZrdOIAQoO9UK3BzR5LjhACqPW61Zv3PoP68eSoNak0mcNtKumcxhQUjcySO6CBOPA+vZg/sIUXmelQ51izDFONalXNjHttmN1UyPz+pL5nfO2WJXSvIB2UXQoBYCsNCevHSmwtc96M3nnk1oNLKv+2ILjHmP1K/MQOSxtXveud2Q76zv0dFXn1dZVJB9D0ZPKs0aCsTojBlTLVEGdr9OUmATT0ED79quwsLzaEDzYPNfHZmCegiPNYA9TFjZfMsRqE0xIjGNlsJsAssf3Wa4H7EY5ksaAJtymfP1nIHGmXB+F3z5EkfF1HKaReFF0tEGA28MJ1VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9S/87Kiaxw0mYJt161AMN/sNpO6h3Xac4ACCs9f8aA=;
 b=pOdu488R1oTDCGVdbYt89zOvcr2ZcGjLCessAGTXLB/KOB2xC6nper1TLa2zyu72b2TJMqpH/7Beeu9+EVEaBrTqWR3BIskQVzBdOuKxTQqgRJW0E2JUBxFM6ePj4bnCNsaM4gJByZB+fchdrJP550cWIB2Mu61uvSDIkebPKkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.11; Fri, 10 Jan 2025 18:12:57 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 18:12:57 +0000
Message-ID: <3f1b9c39-ed9c-42cb-bc8f-fbddb9275a46@amd.com>
Date: Fri, 10 Jan 2025 12:12:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdkfd: Fix partial migrate issue
To: Philip Yang <yangp@amd.com>, Emily Deng <Emily.Deng@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250110074924.1441364-1-Emily.Deng@amd.com>
 <28f8397b-0f2a-4738-22e6-734abc21f0a9@amd.com>
 <7fba9b16-4bb7-44c2-bc7e-d455024ce2b7@amd.com>
 <bd1da61b-0f84-eba0-4a4c-9124429c4eac@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <bd1da61b-0f84-eba0-4a4c-9124429c4eac@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0006.prod.exchangelabs.com (2603:10b6:805:b6::19)
 To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 14301a2f-2c09-4b19-0505-08dd31a268ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkVSVHdITXV2Y2pUMmNxbUlFTHFQdCtHeUU0aU8xWm81OWpjeTloM2VGMzdQ?=
 =?utf-8?B?N254SEdTUVl1aFNkYTBER1hPZTRTYmtKUWQ5MGZrR2VwNEFRU211Um5oeGkx?=
 =?utf-8?B?ZjkzdEdlRHdrWlhvVFU5cDloazljYnpVeVNOQ1FkMlI3bmNNcVFPaHIzbUQ4?=
 =?utf-8?B?RkU1eC9DanpzUTBsY0M3Ui9jMTJ6QWxKcmZXcXhucUxFVHozbmhzYThUS0J0?=
 =?utf-8?B?TW9iWUpaekh2Vk12Q0tyRFp0NEdMaE9OWUNjeWsrQW5oMnEvVjgydytVR2Mv?=
 =?utf-8?B?eFFsdmlXWmJwVWoyWFJoL0loeDd6N24xWHJwRHlzM0pHaTFBaElGT0tXYkxj?=
 =?utf-8?B?VjdzQkNuK3Axb2JwMExVTGk1MGJ6YkJRWFdJcytuMW14a0YyMkliUyt4Kzd3?=
 =?utf-8?B?c1hTNmZhQWI0NHNJTTgvWVhkdU45VDBYd3JrbVozQjNDc3g2ZWR6dEJXU3VU?=
 =?utf-8?B?TE1RV1RsdEh6SU5rM2djdUZlMEozbm9VSTdxcmxqMGpTL3dBeHFQdnRtVDN3?=
 =?utf-8?B?Q3JJUi9FQS8vbDJWY0p5ZjMzYUp3eGhMbnZHZC9Eb0VuV21mQ2x5cmN3R1Ax?=
 =?utf-8?B?dkpSK3FDcEk3eHZIZkhlUElGQUhkL1VQQ0pVSW1tZ29ZRlRxMmJkVGdSNmtm?=
 =?utf-8?B?V3V3K1BGdCtPM09BSnJ0TDcwWTVGbURQRU9tOWh0NmNlTFl2bGljREZ5dnQ4?=
 =?utf-8?B?WFNQamRXQytCUjZxSjc0c0NTVmxkU1FCalczbFBESFlnaWJkZFVoVkV0Wmd1?=
 =?utf-8?B?UUlzMTZoc1hGMS92VlZkMVJZUGlTZDExOFdhbWJhS0piK2tQYUw2VGdXZ2JS?=
 =?utf-8?B?bEJPbW1EQVFUMUd1N050enVZamw3YzU2amp4bWtXV2lJUjVVTHloS20rWnpl?=
 =?utf-8?B?cFpWcHRPZUpkbWJaZUV4Z1h0K1lZbE1BRWt5bDJqRmlETXNjT0xEbGhYZmZr?=
 =?utf-8?B?YWQ5TVR2Q2xjbGtFOTZ2UEpnVTZNWGlVYUk1aDlSN3ZQZWx1ZkRnU3dHQXhx?=
 =?utf-8?B?ZWVpWUJKbE85VGJvZUxoOFNlRWlmNXdmNkNRakZkQjJWSzB0TVJ4MkhVRWd0?=
 =?utf-8?B?S2l2OFdYaFpEdEdvYzBwQlJMQXBsZVVwUHlpazBIbGFTL1JYK0Y0cXF4N2ZP?=
 =?utf-8?B?MThHOXEydjRMOVVkeWY3ZXhzNWUvSDU2aHFaajdjaWJvVndZcFdhNDE4UERJ?=
 =?utf-8?B?dERnUDczN2grUDh4VkVHQ2JzTitYRGFwdGlzVVZFaTkrNDFDMTRweHA2TnNP?=
 =?utf-8?B?cFNXOVBHTURuR3p5SXdOa1hYa2N3YnhJR1pqZzA0Skt1Y3ozRmxIKzN5VmtM?=
 =?utf-8?B?M1ZsdTRLTnJzakJDWlY1L0p6ZTlSWUs1VlhaVElFSjE2Rkpld3ZmeEYyMXll?=
 =?utf-8?B?Y09IUitHalhDNGQxYlFzRGlaREs2VzUzL3ZrZzVjV1laWng4eTJ2TUNGamds?=
 =?utf-8?B?ZjdIVWV6UlJZdjJoUjBOLzNjWGJmMEQzTFNTaktaZ21FajNCRitHNEJHS2Fa?=
 =?utf-8?B?Mjh2b0xKZ2hxY2pxbmYwTTZzcFYyOTJLMlRKSk1pUCtUK2JTSnFWNDh4YUJs?=
 =?utf-8?B?TXdNZ0xoRXZlSXVuUUpVSGFZM0I5cjBnR2d2NkoxWXdlekw5azZ6NU5EckNP?=
 =?utf-8?B?cWM1TTFrdnVVd094SHdOT2lRdmRjL2xaSmlmbWc3V0swcUFXeU9HU2NPWjJt?=
 =?utf-8?B?aTNMSGYwSzNUa0VUazFyejU1NHVWMldHcitYcjR3VUVWTlg5ZlRmejZrcGZ5?=
 =?utf-8?B?NGhmYVNVMktQWGphc1gweGRrYlg4VDlLSVRHUjhQVmpVU0NONjU2OW1HcEpF?=
 =?utf-8?B?UHlKWU8xdGN2MlphMUhaZlpGVGF6UG5Qb1NvVk8wNWhsVlV6MlFudHFUeE1a?=
 =?utf-8?Q?RjQOLXoH1KZwS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmNJTnREOVZ6NHZpZVd0TFF4R29DdHZMRXIxU3lUM05rM3M4OTl2ZCtzckkz?=
 =?utf-8?B?SUlWblgxL3VFVXFDdXZVQUx6azZDbGVXK2F4T3BzUGxWeVd0cmlEaU85NkF2?=
 =?utf-8?B?NWQxUkl2VDBDYko2MTB2U3Q2VkUydEJtamM2eDhlT1R0T2FVVHdrek82RXQ4?=
 =?utf-8?B?V1kwOEtteXlGQ3FVYXcrQU1mTHZRY2dUNjJiNWRqaTVzZFE0ZjZNVWxhYXoy?=
 =?utf-8?B?dkY0c2lNYjF1N3E1M3ZSMDd4NlRtUFU1RjNpenE5R01tTDVWeS9vZlRSTHhr?=
 =?utf-8?B?OWhKcEgyMWlMTVpuQVU1VmJqVm1uSUsvcW5uMUxCQ1J6aE5iMS9oVk1BNUVD?=
 =?utf-8?B?UkNlSEhKL2RwNThvOVRrbVJoV1NPeTFENHRsV1p4ck9zWkYxSnR3VHppMUhH?=
 =?utf-8?B?NitudG1XYVFXcDEwWG5zRXVVVW5qVDVPek44QjVDeFFHMjkxVEhHNnh1S252?=
 =?utf-8?B?UHhqZDRma2VPOTE1SGd3UWM3WnA1Q2xBMUcrckxJMFhpbjNqK3BzUFdWUDBE?=
 =?utf-8?B?N29VZHhKdjlteXlLY3Q4eDBDbTMvWTF4OGJpTFBTaFdNWmNBOXRuNDd3VFkw?=
 =?utf-8?B?dDVVc0NpenJodVVod1Bmd3Z5RDQ3RklSa3dRL3lrYXJZN2tvMVJabWpxVlNz?=
 =?utf-8?B?M0xaYnJod25xWU5KajVhVEhiaDJqNUZKVEEvWExZVkc1aEdoVzVnbmtBekhi?=
 =?utf-8?B?WU15WjV1azEvQlJiN3cwUFhzcjV1bWxjV1QvQ3JYTlQvVTJXbDluRWt3Vlc3?=
 =?utf-8?B?M0dHY1dvVkk1clZ4SmlubEpwcW5jUlBsc1pVYmsrL3FMaURDc1NjaHlhZXhE?=
 =?utf-8?B?c2F5MEdRQXlRbCtIUUlYdzZPNU9WVCtXYXpRWWY4anZxZnNyNVZpUVg4K3dz?=
 =?utf-8?B?VU02aTlNM1BsK3ZlSlIvWDdVZlFOTFJ6TENiT3RCUElNMzgrdklwWEh2cTdU?=
 =?utf-8?B?QmVTS0lyTncxQzN5YlBVUUd4VjR1ZWcxZVd2UlphZEhwMVE1RzNTMVIxZkp3?=
 =?utf-8?B?aWE3cDV4V2c3NzdSNkNNTFhrY2hON0Q1TDVGMzNOMVZBNHkrRFpvdk93NXFx?=
 =?utf-8?B?U0lhajdQczFtMnVMV2JySE9zWXVNSjhwak50TGlzN05veW9vektlSXl1Qi9p?=
 =?utf-8?B?NHZhY1VkcDhuQ3kvUWRKYm5SK2JFeE92UTVKVWdvL3ZuUUxLNGJyTk8rU1lN?=
 =?utf-8?B?ZXEwU1VqU056ODRMQlZyc0x3eXY4Y2dkemNqbTFEcG13VkZXNDhEeUE2eUxU?=
 =?utf-8?B?R05uNkFaSENuNnZlRXJWSWcyakQwd09OZVpTcXpscWVHN1dLeVpLUkF3UDhB?=
 =?utf-8?B?RzdLVTIyV3pLSk9kOUN5QTRXd1U1ZWFyQkpCbTZhUm5ta01xVGV1N05vWEll?=
 =?utf-8?B?ZENsekErNVdkMGtOby9zVFl2eG1idU1DOXJ4am94blVGSkExVUR2SE9oQy9z?=
 =?utf-8?B?aVpOZjJseHNmaFZyM0Z2aXMwODJMQ0Q0d1l3c093U0tOaUZseXMwazBQb2Qx?=
 =?utf-8?B?YWpXSllUWm5aQmZGWmEzMWtJQXBKeTUycnJoSmRlTU5LcmpwM0hkbFRvMlhi?=
 =?utf-8?B?RGFzSUpldnhubklGTE9xaEQrMThSSlF1Ykl2WElyTGNoVUlXNWd4VXE4dmtD?=
 =?utf-8?B?N3dwNzdveVZUVERYU01kOU5teW5tZ1UrVVZVVHgyL3JuRGsvaU1UK0VqZ3Jx?=
 =?utf-8?B?MURDV1dnZUc2QWVybWl0ZG1IYVo2U3lKYUxyYnltcmFNUUxwOHRMdGg2bDZq?=
 =?utf-8?B?dTBGYTJMTldQY2F0WjVmOUtBWU1sQkVCcnM3R2swbjdvUHY3bDRDSmRpakh6?=
 =?utf-8?B?YlA1WkVtaDFaZFdnREZVa0cxYnhXTmgyOCsycVZ4OHk1QmdjZlkzdk1YRC9G?=
 =?utf-8?B?czFTcTNMVlZDekt5VGtMTGk4QlltSjRMNlhGdVhSb01DSW1Hd1krR0dEMkNY?=
 =?utf-8?B?bHdKeC9ZVnd0MXNuSVgzRTZlZlpQNlNCTElYQzQ0ZkE1c2dlNkkwTGYrTUF0?=
 =?utf-8?B?eEFRN1NKbUgwWlVFcHROTW9HbXVFR0JGbmc3WWt2dEtMb1o2VTlUYk1jd3hQ?=
 =?utf-8?B?WVhZSlB0NzM5ZkdTcFNtbEoxeVB0YU1hZFhObmNtWHlNSk9PZGc5aEZzRzZP?=
 =?utf-8?Q?JHc4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14301a2f-2c09-4b19-0505-08dd31a268ff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 18:12:57.4246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHP4Lik+pGePKNJFJnLBTPsfaK1qFjfOUEJTzO470T12ZWeduFc2rS2kf5q33jcH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
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


On 1/10/2025 11:33 AM, Philip Yang wrote:
>
>
> On 2025-01-10 11:23, Chen, Xiaogang wrote:
>>
>> On 1/10/2025 8:37 AM, Philip Yang wrote:
>>>
>>>
>>> On 2025-01-10 02:49, Emily Deng wrote:
>>>> For partial migrate from ram to vram, the migrate->cpages is not
>>>> equal to migrate->npages, should use migrate->npages to check all 
>>>> needed
>>>> migrate pages which could be copied or not.
>>>>
>>>> And only need to set those pages could be migrated to 
>>>> migrate->dst[i], or
>>>> the migrate_vma_pages will migrate the wrong pages based on the 
>>>> migrate->dst[i].
>>>>
>>>> v2:
>>>> Add mpages to break the loop earlier.
>>>>
>>>> v3:
>>>> Uses MIGRATE_PFN_MIGRATE to identify whether page could be migrated.
>>>
>>> The error handling need below change, with that fixed, this patch is
>>>
>>> Reviewed-by: Philip Yang<Philip.Yang@amd.com>
>>>
>>>> Signed-off-by: Emily Deng<Emily.Deng@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 17 ++++++++++-------
>>>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>> index 4b275937d05e..bfaccabeb3a0 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>> @@ -278,10 +278,11 @@ svm_migrate_copy_to_vram(struct kfd_node 
>>>> *node, struct svm_range *prange,
>>>>                struct migrate_vma *migrate, struct dma_fence **mfence,
>>>>                dma_addr_t *scratch, uint64_t ttm_res_offset)
>>>>   {
>>>> -    uint64_t npages = migrate->cpages;
>>>> +    uint64_t npages = migrate->npages;
>>>>       struct amdgpu_device *adev = node->adev;
>>>>       struct device *dev = adev->dev;
>>>>       struct amdgpu_res_cursor cursor;
>>>> +    uint64_t mpages = 0;
>>>>       dma_addr_t *src;
>>>>       uint64_t *dst;
>>>>       uint64_t i, j;
>>>> @@ -295,14 +296,16 @@ svm_migrate_copy_to_vram(struct kfd_node 
>>>> *node, struct svm_range *prange,
>>>>         amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>>>>                npages << PAGE_SHIFT, &cursor);
>>>> -    for (i = j = 0; i < npages; i++) {
>>>> +    for (i = j = 0; (i < npages) && (mpages < migrate->cpages); 
>>>> i++) {
>>>>           struct page *spage;
>>>>   -        dst[i] = cursor.start + (j << PAGE_SHIFT);
>>>> -        migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>>>> -        svm_migrate_get_vram_page(prange, migrate->dst[i]);
>>>> -        migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>>>> -
>>>> +        if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
>>>> +            dst[i] = cursor.start + (j << PAGE_SHIFT);
>>>> +            migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>>>> +            svm_migrate_get_vram_page(prange, migrate->dst[i]);
>>>> +            migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>>>> +            mpages++;
>>>> +        }
>>>>           spage = migrate_pfn_to_page(migrate->src[i]);
>>>>           if (spage && !is_zone_device_page(spage)) {
>>>>               src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
>>>  out_free_vram_pages:
>>>         if (r) {
>>>                 pr_debug("failed %d to copy memory to vram\n", r);
>>> -               while (i--) {
>>> +
>>> +               for (i = 0; i < npages && mpages; i++) {
>>> +                       if (!dst[i])
>>> +                               continue;
>>>                         svm_migrate_put_vram_page(adev, dst[i]);
>>>                         migrate->dst[i] = 0;
>>> +                       mpages--;
>>>                 }
>>>         }
>>
>> This error handing not need recover all vram pages as error happened 
>> at middle. Can use se do {....} while(i--);
> no, for example migrate npage=cpage=4, and outside for loop, 
> svm_migrate_copy_memory_gart failed, dst[4] is out of range access.

You are right, but it is awkward. Inside loop we update dst[i] before do 
sdam that does not include the dst[i] just updated.

Regard

Xiaogang

>>
>> Regards
>>
>> Xiaogang
>>
