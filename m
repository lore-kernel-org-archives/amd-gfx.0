Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CBECCF9E3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 22:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A962710EA42;
	Thu, 30 Oct 2025 22:12:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="msN8Tq9U";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013066.outbound.protection.outlook.com
 [40.93.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A203010EA42
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 22:12:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjA1EAIUB9rj+iDqDgrT9QLOYwTdkO1/laVd3t1wzNGZ/E4vaMZ6enp7upt5C+BeptyJAaQAGCQvTjJ/3Krv+03zh8EJtWTkLbFTLj798NKtYcWQSoAMm5EJW8gzDJT/uRqHY8kELrzmB9zNZHLQTR7/FNVMSCkJeT6gR84FcDw7vJesVeMRgloGnMZN3Ce26hPEmyrra1gTwGX/HHXy/cNY57yU1rU7gxywZNLEfNiVKlP3TDoyMsWTQ56HhOihMIsbCcF/Xnn6EIpbkY/vIilQqqmaAFkwTCqO0cPyYRJ3h0JHQZAr3D62zIOx0pPXMgnTOcnIbRtVRQ7D+t1XRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIciKF9bIcPnW3X/rzP5268nIZ5kwHHunZbdEDN1KdI=;
 b=gyDeKylvylSf07pvYhCBbF6roZy6wS5QZ2JDgVDefk7chts1u7OX7we0esfobotgPFFl3KaxfCwLlId99p48QABGvGsU5TsQo862p2J1wmx6fGnSOmppsTv72cr3ZxF9fMeX6PAWXpjtOod8Tjt05FjTwIXWqw2uA3uyZniq+Ckvl4aFrcjjaY4ww2WEc6GBt23sbVHvUTO0IKiZEwDYVfrnpLEeHT7Di5diVqP9XrxjTOehQpZl3F5oIEkLQTg1h3EB0/j35a209HVTWdesv9eARfG7676bV5Ge1oVwKpaB/tV2sVjas1lusVZuvTvHeL2pE3iLLkmHH031R/n3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIciKF9bIcPnW3X/rzP5268nIZ5kwHHunZbdEDN1KdI=;
 b=msN8Tq9Uq4HUa0VDKv/s9APAi6Q/c4kqkDY4ldiRxAO24FE3l8/D3sRkSxI00LI1YmKNRBolZ5PoPuY7nsBJqk1m74Mf/V/Qyqd0Gtkwh3XDozqvGrfeNUkopoROHsFAZRgfoJf1m5T6/03TC5Rr2VTMF633qhv1b4GJcw5oYi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 MW4PR12MB6974.namprd12.prod.outlook.com (2603:10b6:303:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 22:12:20 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 22:12:20 +0000
Message-ID: <67f96c31-e0e7-4e1c-9ea7-d77c8e345f8e@amd.com>
Date: Thu, 30 Oct 2025 17:12:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Fix GPU mappings for APU after prefetch
To: Philip Yang <yangp@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>
References: <20251030010027.2503555-1-Harish.Kasiviswanathan@amd.com>
 <CADnq5_MMZ+mE1=0aRRLE7dbfpndVOXL9UCODB7BeQg9QMyspJw@mail.gmail.com>
 <0c8c8f75-a4ab-d0c3-067f-cb389d7c61f1@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <0c8c8f75-a4ab-d0c3-067f-cb389d7c61f1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:806:23::6) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|MW4PR12MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c76a11-5fd3-420d-9be1-08de18016513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkxIRGJkd0s4UEVDRmZHYXZXaEEvVjhUaTZ0VWRMTjNacW4xRE5LZ2FEWEpY?=
 =?utf-8?B?V2hnbElJL01rSkxVTXRqUUZUeE56U2lETU9Cb3N4dGI5a0FIcFN4eUcvbmw1?=
 =?utf-8?B?RzFQWS9kaWI4bGgrK3Jvblh0K3VhUnp0Z0wvTDFFOUtycW94N0Q0RmVvTGp6?=
 =?utf-8?B?MVVHTFVaMUtlYkVqU3h3M3Z6UGtHTEZoV05yVmZpTHFoOEdIWE45STBNZCtr?=
 =?utf-8?B?bHFpLzF6d1lWdXJ6MFhPaElHT2duWTV0YWxCNEpvdjhsMkFVbzIrVVViVHZ0?=
 =?utf-8?B?dGRHdmF5YkdIR0FiNjF2aEdFVThjeXp0bk5UUnB5RXRranNLQ1NZRjVzZ1Ru?=
 =?utf-8?B?ZW85dFZ0anNFMjEvdG51eEt1K3ptMllTUnRMaVVKT0RnWjVqQXNta1Yvb2ZR?=
 =?utf-8?B?NUVnaHZCS2ZQOFdmbW5nWUtGNFF5YVliU2pFQXZ5Wjk1anI4VlRsTThEWjJ2?=
 =?utf-8?B?d2Z0WHRDY3h2L1lKdDZxSFNBTE5wVWNucVhmN2RxTEE4V3BpcTVoaFB2eXg2?=
 =?utf-8?B?WDE2bGdhT2g1MVE2YXdDWDJzRTc0Qk9rNnhtRW90ZjB5YTBSZHNBTXIvQmRR?=
 =?utf-8?B?dGd3VlN1aFNSZWRaWlVuOVpHdlNaRkI0a252WHJNZHJQZyswVGFudFI1UzhV?=
 =?utf-8?B?emZtMjlqMkdYaTdPU0kxSUwvNi9CUjlDUkU2YlhCb1ZnbjZzdTA5a0FTWkZS?=
 =?utf-8?B?VmdjQXFRbUY5SVN5b2J3UzliQjJJVHB1VFBqS3ptangrdHlwOVBDOG9YN2pE?=
 =?utf-8?B?aHhYVWs4QURRYTJDRzV4akxkcjBtTEFzUmNJSTdKelR4WUJrWUNjalYybVZt?=
 =?utf-8?B?b0kwZnUrYXJIdGprYUlUYzZUODBrS0c3aEJlaUxrRWZXdXU0VXluSlc0ZnJi?=
 =?utf-8?B?WjhyQ0JuMGR2QXNJN0ZDaHF1R3kxOWhCYWtjK3NURTBZQVRraHlwTlNMMjJI?=
 =?utf-8?B?VXhpdHhKUFpTdkRIM2NXcGpxb1FlMm9Fb0tZYjJEVnRkcmFvWWFKZ1J0RFZY?=
 =?utf-8?B?K0g4Qk5GZ3V2VGRtQnNCK2FZdFF2MkJrRzR2bnJxTkdOVzhSMEpLb3RJcWd6?=
 =?utf-8?B?c2h4OUtzenpzRDN5bml1eGlXMjk4VENHbnhPNDcva0tQaXk0QTdYT3BXUHhw?=
 =?utf-8?B?YUVMZmdGOGZsK0tNUWZkeWgvWGV4YnhTMDQ5MlF4Y253VElDWDNhbVNRdHls?=
 =?utf-8?B?cElScWhndERwZldLNE9DMG91UGw4VGdJUy9wQThCQzhvV2JKQzNxMS9iTDlh?=
 =?utf-8?B?d2l4RDdkRGk0Z1RpdzgwUUdNMDF0TEs4WmROY01pWnJ0Q0w4ckhrZTZRbVNa?=
 =?utf-8?B?SmNVbWt4OUxVM2IxVXVTaC9ObURzd1RBdTFRZFVVT21PcC8rZzJTK09zV0Z1?=
 =?utf-8?B?c2E4cy9RZ0xuWkNqbkNYRjdkeHlCMEMwN0FPc1ZWL2RIaU5NWGNPcTFtZ1ls?=
 =?utf-8?B?aXFWdE9oYWJkSFZub1V4VHc5MHZMQXhWdnNuZWJvWUVlSlFwQmFwN0NMNFdY?=
 =?utf-8?B?bWRqazhxYmZ6Qkxsb09kRFZvUk0vSDlmUU9HenBzQTdlMVFubVJWTjlMbjl2?=
 =?utf-8?B?NzM5ZHBDOXV2a0h1L0Rad3llTnl6YlV6Qnd3RlZVOXpFUHFwT3NSTys5cy92?=
 =?utf-8?B?d0F5QS9zYld0ckFsdHJPeU5zZmcwd1d4bi9ndHl2VkhvZDhSMzNhQ3g3THln?=
 =?utf-8?B?L1QwUUFlOXR6S3kxQ2tsNjRRYm96R3gzYnFLWW9wVEp4ZlhacXBVc1dtVVJT?=
 =?utf-8?B?SkN1U2VzU1Uzb2dTcW0yM0E2QmtpdFhERGlHWlBqRzdSZW1Cb25icVFMdnVF?=
 =?utf-8?B?eFdRdWErTUFZcURPSzBvQjdjTVdvS2s2enhUQVg1bnNLdHIvckpybUJvakpo?=
 =?utf-8?B?cFA5Kzk2RXlHUFZ0cThDcW1CWk1aNVM3WldMaTEzYUREWHJZbi9LSnRqNkhn?=
 =?utf-8?Q?iue46NcpVeEr/eAIdMxNGu4In0B4H4FH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjZLU2N5YzdqVHhmOTd0Z2hSU3RTWm1JdVdJWkZPYU1qL2VYZ0ZMTkQ5QVd6?=
 =?utf-8?B?WUNEWUI4Vm1PSUdIZ0VETXppTFZFVm1IZWhlMDhtOFBWblpyVm1SbFR5Vlgv?=
 =?utf-8?B?ZkFjTUZXNzBzTWFxaVhWNUxPWVFhb2FFNmpPcXVHVDFUc295MU1Ca015OEhj?=
 =?utf-8?B?Rk1tZmlWRWRINm8wWU9vRG5BTHJCM3lva29qMTM3ZUpnN05sNjBuOEh3K3Rp?=
 =?utf-8?B?R3h5U0laQUczbEZTWTU3SnhZeFJGL2VsL0s3L3J4SjdVdDYvY0Jicyt2UUpR?=
 =?utf-8?B?c2gyUnpscWNMaURRRWo1QitWd3dnTi9ZRHVCL2pBZ1BRTmtnZysvUFFobUFT?=
 =?utf-8?B?WU03dnBWS0I4VHA4Z2QwY0l6ZGJuQisrZjBSTHdvZ3hzczZNM0lBY1FrdS94?=
 =?utf-8?B?c0hXR0FUY3puMi85K0doU3dWVHM1d2U2dWhXdlM5WmZPQ0VyNmUxMGRxakhV?=
 =?utf-8?B?WUpja3o0U2dHMTVYT1RHbUNhTXpRa3g0RWJyampjWFh1ZHA3MnRyVmJTdE84?=
 =?utf-8?B?VjlDajYvR2ZDRGVSZVVrY1pwdWlqRzh5TUFJMG5TbUxxd0kvNHdjSy80OHB3?=
 =?utf-8?B?cjNyNjNWV3NNU1IzdlF6UjF0UC9ybGxpemhXSFJkSlZKYzE1dFJpQkFOUjlJ?=
 =?utf-8?B?Tm16UGlXWFRoSjlnckc4VUtFZUlZVFJ0ODJ4UXBYWC92RzVJeDdjSk4yejVu?=
 =?utf-8?B?QSs3SkVxSm5ldzRVam9UeVE4cDJVUWY3eVVOWGFvSW5WNzQvMVVyY1U1NjRY?=
 =?utf-8?B?Q0swTEJvbTVoTjhmNzYrVnB4dWNuYlViV1ErT1ZaQTVoTkJjeEF4YkNjemt3?=
 =?utf-8?B?SGlsTDM5Uktwd3hHMjFGYUlzMWF1ZTRUZUNuWnIxUTVuKzUraGl4RGxVck9o?=
 =?utf-8?B?bkI4QVBQYVFEWmJuaW0vNitIQzQ1ejVkMTRGdVN3U1RJZ3Z6SDEvd01RS1dZ?=
 =?utf-8?B?cGs0T0hJZ1FuOXRDNUU1a3VzcHhlR2FsNWZlKzFiY2g1ZzNObnAvbnhoNjZt?=
 =?utf-8?B?b2cxNHcyNURGaXBmU3RCbEo2cE1YN3I4aHJKUHVtaU5YT3JtUk1hL2hid0Nu?=
 =?utf-8?B?aDVtMFIxcXNyVElrZXJCUHBPNTN6a1ZsZGllT3ZOK1gydlE3QVlmTWM0OWl4?=
 =?utf-8?B?bkRuTW9MTkIzWS9OS29JTWlBYjdXMjZ3aHZtbWI3SUUyNzVsdDlNaFlIY2di?=
 =?utf-8?B?d0tXT1RIajRvSkh3WHdTOTJoM0M1S29iWHZWQ2IzcndxRC84LytpaUJPcTRu?=
 =?utf-8?B?MmFQdDl2emo5Sjk5S2h1RmtlRUc5UXFoVk5BQ3lUNmpFUzljWGJ1Nk5LUlcv?=
 =?utf-8?B?eE8xbFVpVmkxeUtINTdDbTV0T2lVd1FaS2xTYTBxZEpGRUdTWDRxZHhVRU1n?=
 =?utf-8?B?U2hlMUkwTHJ0amc1ZDQ4M2lmR2hyek4rVjM4eXBZOGxmNDFMMjJLZDNZdkgx?=
 =?utf-8?B?dDJrcHVlcnNxSlRwR1E0ZytPUzJSRTRSZTVudmpYUXZQYnVnRUxZVkFtdCtw?=
 =?utf-8?B?YmpiWW8vQUFoR0hJcjVwQ1hYdHBZaDB5ZU5rbDIzNDBzYzh6bkkwbW9hN3E3?=
 =?utf-8?B?VHRwSXN5WWd5VmhJUjRLanFQL3YrNWMrY1dkVklwZDR2UGlvR21Nd1FZcTFD?=
 =?utf-8?B?K0RpbW42bWw1ZE42cGJyWVBSdWhFbXUvK2o1RUxhS3FTeFVPNGxXVW1wMGlK?=
 =?utf-8?B?VUFYejNrTG4wTVNScVNiL21HWVNhNDJSdWpXWXE0Mlpja0ptY2MwMitEU24x?=
 =?utf-8?B?V1hyZGd3VHZiQlJFUmF0amprcFBaU1dTWWN2WHh0QkRmUGp5eW5yQkFzWVZn?=
 =?utf-8?B?SzlBQks5RVppaHpSdVNhOERoSmJSaVVreFZwSFFjbEFRSmQ3M2NKVFg3L3hx?=
 =?utf-8?B?RFRxdWZEOUlwaE5HdVZCdlkyV0RVbmZPR1Q5b3VObTUrVnc3Ri9KdTBTT1Rr?=
 =?utf-8?B?U3VQSjJwVUlQanhHeXNWeUFWYmNaQ3hFNFVlakxOS1Q5U2JMTkNCYllvM1k2?=
 =?utf-8?B?cTR5bFNzQTJoRXdTWmY5Nk1yTzFDTEFBb1ZMV3FtNFA4TG5HWnhNejQwclFq?=
 =?utf-8?B?ZWhqVHFaa3ZkbkFBUDFDV3MyREdwUHVGN1QxM0Rvd3dncTVCdlBmUU1IZUgv?=
 =?utf-8?Q?Fp/s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c76a11-5fd3-420d-9be1-08de18016513
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 22:12:20.5028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uepctk2qHCkW2AZqnUuvOjRWVRbeo7byCwZmYE9SRLuDccPGMuLVqZt9QdCErWc5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6974
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


On 10/30/2025 3:14 PM, Philip Yang wrote:
>
> On 2025-10-30 10:20, Alex Deucher wrote:
>> On Wed, Oct 29, 2025 at 9:36 PM Harish Kasiviswanathan
>> <Harish.Kasiviswanathan@amd.com> wrote:
>>> Fix the following corner case:-
>>>   Consider a 2M huge page SVM allocation, followed by prefetch call for
>>> the first 4K page. The whole range is initially mapped with single PTE.
>>> After the prefetch, this range gets split to first page + rest of the
>>> pages. Currently, the first page mapping is not updated on MI300A (APU)
>>> since page hasn't migrated. However, after range split PTE mapping 
>>> it not
>>> valid.
>>>
>>> Fix this by forcing page table update for the whole range when prefetch
>>> is called.  Calling prefetch on APU doesn't improve performance. If all
>>> it deteriotes. However, functionality has to be supported.
>>>
>>> v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with 
>>> carveout
>>> VRAM
>> apu_prefer_gtt is used by small APUs as well.  It depends on how much
>> VRAM vs GTT is available on the system.
>>
>>          if (adev->flags & AMD_IS_APU) {
>>                  if (adev->gmc.real_vram_size < gtt_size)
>>                          adev->apu_prefer_gtt = true;
>>          }
>
> yes, if apu_perfer_gtt is true, then no page migration because 
> best_prefetch_location is always CPU. For small APU, it will have same 
> issue if KFD is used, prefetch split range page table not updated 
> because no migration. This patch can fix the issue on both small APU 
> and APP APU.
>
> Reviewed-by: Philip Yang<Philip.Yang@amd.com>

Is the case like that: the svm range got split; the pages are not 
migrated and attributes for the pages are not changed. Then why need 
update pte as page physical locations and attributes are not changed? 
Basically it used huge page pte, now you split the pte into smaller 
ranges. Or I misunderstood the scenario?

Regards

Xiaogang

>
>> Alex
>>
>>> Suggested-by: Philip Yang <Philip.Yang@amd.com>
>>> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index c30dfb8ec236..76cab1c8aaa2 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -766,14 +766,21 @@ svm_range_apply_attrs(struct kfd_process *p, 
>>> struct svm_range *prange,
>>>   {
>>>          uint32_t i;
>>>          int gpuidx;
>>> +       struct kfd_node *node;
>>>
>>>          for (i = 0; i < nattr; i++) {
>>>                  switch (attrs[i].type) {
>>>                  case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
>>>                          prange->preferred_loc = attrs[i].value;
>>> +                       node = svm_range_get_node_by_id(prange, 
>>> attrs[i].value);
>>> +                       if (node && node->adev->apu_prefer_gtt && 
>>> !p->xnack_enabled)
>>> +                               *update_mapping = true;
>>>                          break;
>>>                  case KFD_IOCTL_SVM_ATTR_PREFETCH_LOC:
>>>                          prange->prefetch_loc = attrs[i].value;
>>> +                       node = svm_range_get_node_by_id(prange, 
>>> attrs[i].value);
>>> +                       if (node && node->adev->apu_prefer_gtt && 
>>> !p->xnack_enabled)
>>> +                               *update_mapping = true;
>>>                          break;
>>>                  case KFD_IOCTL_SVM_ATTR_ACCESS:
>>>                  case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
>>> -- 
>>> 2.34.1
>>>
