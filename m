Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37A4C27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jun 2024 11:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C6B510EC38;
	Wed, 19 Jun 2024 11:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xZ4irhtO";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D7810EC38
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jun 2024 11:20:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOjPNaej0WWaz8h2jNDdLh/vm1LYJB23DeAVoEsDXLHCmeOBHozoDDcPavTFie8vcBRDA0o1DaTIvSwBcIChouBBgvyJkoHuI7x5PmRcB0ixd+nVxq6bVgPZQPT9G9F8vUnraEBdL8b4gJ7KLO6tp6iIrUQrhEHyrxxeYctydwBFfIf3gDKaW8wZObj+GZUwnDQK0G6CMDYBJA0YJ6t1a0I9Lz6tEdHU5c3aEb37HcR0SKcUp0r0W5uXXrlNFYm+J+kdwKv00gpryaKDYSf+GB7Viqhb3w/VHlE4HQtkbRzyRF/RI0Po0cOhPTioWQdc+IrdwfszqgNM98iJX3im0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3NVRrGdOUNJQvRNYQzp4vzJn3fCuwDOAMvcRqL6HX8=;
 b=bbz3kAH3up3FGA9ZGMEA7G8B1WyMg1+j+j1+ejeLFd6Y6OIrfnaaKeVNpsic1T33MjQ/+eEP2tH8Fjc/4fN0S9lsqU4SUMNZIMcnzX+NHH0dRbP7C5DxtB9T32bsCov+m0GlWmiG4Hx6A6dy0RmUpqr0RFp4MZ7qqzAWl8Sqc/+PgxkoC0uV89yB60WbvoFDkGbwcNDA31oQaM16B+mAIjYRNDt3di7tDgwmHLgRlhtQYJNaOmydvHyya1Jq+temgwlz9X1Ki07yIS5bxNr/GChQ2/IamDS6gWv78068e7JMZh43mKWYK1Nfq0ueyYNoGIf0AWaj5CsQ8zkwaSAB1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3NVRrGdOUNJQvRNYQzp4vzJn3fCuwDOAMvcRqL6HX8=;
 b=xZ4irhtOiqKdjqMhuCTiTHFsKneuTw/qS9vIK8kkNLrEUHEr0fj3eDaYzcLKRy13SoHzCUfs9zvr8LHdHqmE7l9z6v78CmWnQTEbMMv976d/FaJIuB641QIt7/ecdLSIK7QZdQrwtj3drgNkDZ0TSPzNWEt+4uJCcGjpx1HvRjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 11:20:23 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 11:20:23 +0000
Message-ID: <b034fdba-5df1-46d3-95d3-7f2fc05ad6e0@amd.com>
Date: Wed, 19 Jun 2024 16:50:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: process RAS fatal error MB notification
To: Vignesh Chander <Vignesh.Chander@amd.com>, amd-gfx@lists.freedesktop.org
Cc: jeffrey.chan@amd.com, zhigang.luo@amd.com
References: <20240618211446.598261-1-Vignesh.Chander@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240618211446.598261-1-Vignesh.Chander@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: dee1548c-ea11-4526-d14d-08dc9051cf95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmVzMmJrRUk2WDNvKzRsYW1pN3FqSlJaMnExZE5hZlQ0ZFd4enVVeUlScVNY?=
 =?utf-8?B?RlNkeXUvdU80V1lTQlFsUE1VSVNWVEVicGV4SEQyQTg5N3d1bzdqYVNrU1lE?=
 =?utf-8?B?Tk1vVVpDaGNZVlgrYlFmTElnSXFYTEl2SnV0QW90ZGt3U2I5d0RXRGNML3pN?=
 =?utf-8?B?U2JMNkE4MjdxQXIrYnE5eWxaUCtqaVFTdXp2MmwvbTV6bE43ZXU3T3dLbDdr?=
 =?utf-8?B?dzVEY3RFSnJjV0M1a2Vua0JPRWkrRHZqeGYzQVppMnpuWWJPTmxJc2hyQjNO?=
 =?utf-8?B?dlp3MVgxRDg4TmxNb1R6b2xaZFZYYmlZYmV3ZFhuTkNQUnkrNWJ5NWg5OHFV?=
 =?utf-8?B?LzZrMU9sa1N4VVpqQ3VRSTBtQXFOTjlLNGhqampWVGlqVzlpc29lVmJ6dFhL?=
 =?utf-8?B?bGY1N25GTmxjOEZ2K0FnYnYvaXk4cjMzSnFwNGMrVHJ3VFByMnF6Vi93MWZs?=
 =?utf-8?B?cTJITWp5UXdhS0dzQkU2a1Z6SFVCODNORjJyV0tHVDhPU29td0Q0UU9CaE1s?=
 =?utf-8?B?NDhvVjI1UnRrZmJMY2d0cUFJL0pDUUxxRG5icWxBcFJGQVpGaTRpWExwSklt?=
 =?utf-8?B?MjNxS3ZXcWxRbkhHR2ZOYjAxMnhiNmREcGdhMmhOTGV1VVZMelYyblVSbHps?=
 =?utf-8?B?NWd5Y0g1WkJ1cHltRjhRSGNHVHQ2UDAvZHc5bEFxK0k0aERqcFlJRnRZT1Fn?=
 =?utf-8?B?TC90OWJUUllDa016cXJCZmRxS3BPZStCWW5JdmVWcmNBVDVRa1JEamRLWnBj?=
 =?utf-8?B?c2VQM2J6U3M1UFB5ZTQ4aGx1V0VUOUVWb3VzZERqYS80UjQzS1pLMkNrdVpq?=
 =?utf-8?B?NXMxWEV6bXBtZjZUYUpQRVhPNWhzeG1oUEhRSkd0MFBvTUNxbTlsUUxSajVx?=
 =?utf-8?B?azVlZEpPemN1TWRKWisvdmQ4alRvSk9WVVFvOWdnQ1JBc2FtR3VoMEczLzZp?=
 =?utf-8?B?RkZHVXJQVWwxWi9DNVlhMUNyMlEzVDNFeTVwdk5IY0tzQ25tS1QzZGVIUFRr?=
 =?utf-8?B?SVA2RHhDSWk0MjZpU05iejQ1SDJMVEkvT01pOFNWQmRxMzJoM0ppNTR3ZEVw?=
 =?utf-8?B?SGUxZDlCeVZJRG1qS094Ulh6RFQvZmw5dHVIOFUxY25BS0d2MTJJY0RXb0Z3?=
 =?utf-8?B?RytOOWRETlh5WkRnOTZNYWVsT2tHN2EzT3hFR0JhQ0ZqbHpyT21FVkpSbU5k?=
 =?utf-8?B?TG9sNjdjNWFCN3FGSmUyNGpuRUxnUzVIeURlem1ZRHRCVnduNlllczI1ZjRU?=
 =?utf-8?B?ZFRCMzk3S052K2pHSGYxLzQwa1VsZVFJOWpjVDZvMEtTWWp2Y3ArRG1WbXJt?=
 =?utf-8?B?YmRVK2d4LzNJZWowS1RzWjMwT05meXMxQVFxMzljUXA0SnNHczRibU5wbjBw?=
 =?utf-8?B?VzMxVC9QVVRWREVsT1B3cVpvK3dvUXpGd2NUMVovVTVqcW8wYTVOeDg2K2tO?=
 =?utf-8?B?ZWwwd3hTWGNTbXpnc3NOWFVKaUlGR2ROUzNZNXJ0b05DTllJVXNZeS9oV3Yy?=
 =?utf-8?B?TEEvNTNGeTZHOURRRlpIaDdUSUUzMEJacjVLeHFObTRVQ0FycVkwMVozUFNC?=
 =?utf-8?B?WFQ5QVFEb3JGVUxOZDFqdWlqR0dPa2c2SGlTOHdUM0t1elZ6Kzc1VnJsditD?=
 =?utf-8?B?a3RBYUxTYUE0SnBIdFB5Y0ZsY0RnWTUwbDdTYS9kalRRQXJVbkgxUEtnU2xM?=
 =?utf-8?B?QlV5YnZEWG1KaVcrQzljUy9PeGZMUnhIcFR2cGhOellic2pCMGRHWTMwanAr?=
 =?utf-8?Q?y+k08uLVrL3tbAYePJhS5Q1XzvobzaH/wEHI2TH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXJhQTlRMTJoYWk2Z0FEV1V6Snp0Y1RmUTdHQ1JPOENXMlNzNDkzNXZmcHFN?=
 =?utf-8?B?NWYyYy9LZVdjR3VRRmFTdDVYSGNFUlZqd2lxREZKK0tMcHVUazNucjYyNllC?=
 =?utf-8?B?MDhUTmlNZ0pXb2dFNU9oME1teUFTelhZMnJKb1pBaUNGS2xtendOYnRQeERn?=
 =?utf-8?B?NEpvcUNSd0s2bGdwOUFuamhXSGhTQS9UUCtRVWtOK1E4MVJEamZzbWkyZFBP?=
 =?utf-8?B?VVA4UXpDQlpmTmxTcjAxMHZyOEN2Nks0azVua3RkdldNSktIY3ZzRVYvTDVG?=
 =?utf-8?B?Sm1zQWM1Wm0yRzZBN3R1YUJLQXBjZXVJdlFpNCtPbjMvVGdjaFpyUk9qMnJP?=
 =?utf-8?B?SnZDOFR0SzRJeEJJeTJyZURZeEJ1VHpTbnFTOERlb0lBVGtaZElTVlhFWjlv?=
 =?utf-8?B?YzJsN09sbHI2YmtwNVBKNVZNelNlVUNRRDJuN0ZjWTVxVVJoVjNmUkVOQWlX?=
 =?utf-8?B?UE1QLytkcVpIekI4bi9LN3pTVnFoaHpRWTZzZm1vd3NyRXZMa2haVm9sRERv?=
 =?utf-8?B?V09CbktwUDdPa2JzM1dGQ0dvL0tmMVVCQitZOXpFZTJxWEZ5UWJLNm5rY2Fo?=
 =?utf-8?B?ek1WeVhLTkMwdXY2NC83bW41ZW9pRWptS3FQb1JBOEYzeGpvSG8yMHRJT1ZQ?=
 =?utf-8?B?Z0dyOU9NbzQ2a1k3aFlCYVlGdU0yUlYza3ZsU0k2V1dOZ2M4YzJVMVFzWk9t?=
 =?utf-8?B?QmtOMGVCdEp3TVgybUNxMnV2QnJyLzZjd2llWFMzWXhPNWxIY1VsNjA3WDVl?=
 =?utf-8?B?ZkRodlpPTVcza3JZU2xLYnhPYVA0ZzJBNXFxeDc2NlA2QnpUbUJSY05mNkZK?=
 =?utf-8?B?Y1FsWXVJL1ZsNkhTdUNKakNXQ1FBOUEyc0NmUVdSSlgySFFUQms3d3h1TUgy?=
 =?utf-8?B?K1MyTTVNT1dENzhyYzN1cXpUbUhuaGdhZXFNVGd3SjdFUHpzS3k0cmFjOGhR?=
 =?utf-8?B?OXgxNnR6VkFVSXZmQjNnVUlIRDJuTWNvRXdzQ0cxVEUyTjRQQnVtNGpEQStR?=
 =?utf-8?B?MExXbEsxNW9XWTdwMkxMbHIxcWdCYVZxSzRFeWRvcmxDbkE1bm5qSVFOaFJt?=
 =?utf-8?B?d0R4SkNjdEJNdG04MHlVcU02QzAyc0pXcU9OL0s4VGs4YkFSV1g0bUVVYUEy?=
 =?utf-8?B?OGpHTS9OVDd4aktjcUU3eUtrRUszWDZtR1lIdlliTmpqeTROc2lOVmFLR0Q2?=
 =?utf-8?B?bXQ1OXVTV3lJZHRpZHdmaEIwRDA1QzRQOGkzU0xiWVlGTFJuNmlvNWVUd1ZH?=
 =?utf-8?B?alEwVHVFYlMrMUdpT0pEUWJKSUVzSTZwWkpDUHBTWFExN3VKajBoNTNjR2dh?=
 =?utf-8?B?cjFNNExZZHQzcWxLN3lENUFJZFdmdXNzbnVGTmNrazRILzJ6NGpveHkreHdC?=
 =?utf-8?B?RTFRUkhiZmtuQlZLV0hxR29ZT29MdXhtTGhmZStxZmZ1RjU4QXoxUUFqOXJU?=
 =?utf-8?B?NWtQSDVud3JidVBISVFZZkVzZEF4eml5RFhwOFVwaDFaR0RtVkNqdndTa3NL?=
 =?utf-8?B?Rm5ORWVpWHorcHk4VWZLZksxalBuNHJuVFdUc2VybWtVbktraU1rSXJFcVBQ?=
 =?utf-8?B?WWxlMWdNb3ZuQkw1THJCYnlnTGdPQlNTRXM3aDRJY1BWTCtFVjh0ME1uaEhS?=
 =?utf-8?B?TFd1RXhwbHJvcURvcE82ZWpjMEhacnpaTTQxU2dGQjZwT3NGR2p5U044M0tj?=
 =?utf-8?B?ekRuZWJzb2tlMWFLU1ByQ1VPMzd0SUFYUm5TYUcreG95aUZVZFhEQS8wZXdO?=
 =?utf-8?B?REwzS2JNNDdYVGZpTHlnOU10ZnRPa1V5WFpzeHhxTmg2bXE4U0hibXA4THVt?=
 =?utf-8?B?dFB6UEVLZ0lEKzJKS1UwUDE0dEU0bFBsV3o2UmRRTmZFeWtBeW5zNGhrMEhX?=
 =?utf-8?B?R2ZTclRRandFZkwyZW5vbmlzQkt3VXoxQ01tRzhZUEpxZTc5OWRlTzZVcWhC?=
 =?utf-8?B?Y2drVVlEamk2NmFCWGdadnIxZlBNRVlxb0NINVMzMXlzbDZWN09SRld4ZHhZ?=
 =?utf-8?B?NUx2U1N4OW5LVTBTWnp3Ym5xb1ptWnJ1SDVldVFxeG55U0paekxTTHZTUU4v?=
 =?utf-8?B?SncvUE0yYWZTVTZQa3VOWTZxQzhzcElQYWIwNFQ2WnQrRE1xWDBRSlNYN2ZJ?=
 =?utf-8?Q?b0bOzxnlveqVjjDp/nj4hIUrD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee1548c-ea11-4526-d14d-08dc9051cf95
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 11:20:23.2851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/aKTXPlJ9HvZ93X42APouDlxi5OteN9OdanIVVo2VQ1AWNBv52nDpk5NQ9FS11j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958
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



On 6/19/2024 2:44 AM, Vignesh Chander wrote:
> For RAS error scenario, VF guest driver will check mailbox
> and set fed flag to avoid unnecessary HW accesses.
> additionally, poll for reset completion message first
> to avoid accidentally spamming multiple reset requests to host.
> 
> v2: add another mailbox check for handling case where kfd detects
> timeout first
> 
> Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
> Change-Id: Ib501c653265883999c62a12a209ce5eb81c80846
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 25 +++++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 22 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 22 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h    |  3 ++-
>  6 files changed, 70 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 63f2286858c484..ccb3d041c2b249 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -229,6 +229,22 @@ void amdgpu_virt_free_mm_table(struct amdgpu_device *adev)
>  	adev->virt.mm_table.gpu_addr = 0;
>  }
>  
> +/**
> + * amdgpu_virt_rcvd_ras_interrupt() - receive ras interrupt
> + * @adev:	amdgpu device.
> + * Check whether host sent RAS error message
> + * Return: true if found, otherwise false
> + */
> +bool amdgpu_virt_rcvd_ras_interrupt(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_virt *virt = &adev->virt;
> +
> +	if (!virt->ops || !virt->ops->rcvd_ras_intr)
> +		return false;
> +
> +	return virt->ops->rcvd_ras_intr(adev);
> +}
> +
>  >  unsigned int amd_sriov_msg_checksum(void *obj,
>  				unsigned long obj_size,
> @@ -612,11 +628,14 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
>  	ret = amdgpu_virt_read_pf2vf_data(adev);
>  	if (ret) {
>  		adev->virt.vf2pf_update_retry_cnt++;
> -		if ((adev->virt.vf2pf_update_retry_cnt >= AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT) &&
> -		    amdgpu_sriov_runtime(adev)) {
> +
> +		if ((amdgpu_virt_rcvd_ras_interrupt(adev) ||
> +			adev->virt.vf2pf_update_retry_cnt >= AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT) &&
> +			amdgpu_sriov_runtime(adev)) {
> +
>  			amdgpu_ras_set_fed(adev, true);
>  			if (amdgpu_reset_domain_schedule(adev->reset_domain,
> -							  &adev->kfd.reset_work))
> +							&adev->kfd.reset_work))

Instead of this and below waits, what about checking the status in
gpu_recover() or in device_reset_sriov(). It will get called for reset
initiated from all sources.

Setting the flag means it will wait for FLR completion.

        /* Actual ASIC resets if needed.*/
        /* Host driver will handle XGMI hive reset for SRIOV */
        if (amdgpu_sriov_vf(adev)) {
+
+               /* RAS error is equivalent to FLR initiated from host,
wait for
+                * completion
+                */
+               if (amdgpu_virt_rcvd_ras_interrupt(adev) ||
amdgpu_ras_get_fed_status(adev))
+                       set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
+


Thanks,
Lijo
>  				return;
>  			else
>  				dev_err(adev->dev, "Failed to queue work! at %s", __func__);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index f04cd1586c7220..b42a8854dca0cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -52,7 +52,7 @@
>  /* tonga/fiji use this offset */
>  #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503
>  
> -#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 5
> +#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 2
>  
>  enum amdgpu_sriov_vf_mode {
>  	SRIOV_VF_MODE_BARE_METAL = 0,
> @@ -94,6 +94,7 @@ struct amdgpu_virt_ops {
>  			  u32 data1, u32 data2, u32 data3);
>  	void (*ras_poison_handler)(struct amdgpu_device *adev,
>  					enum amdgpu_ras_block block);
> +	bool (*rcvd_ras_intr)(struct amdgpu_device *adev);
>  };
>  
>  /*
> @@ -352,6 +353,7 @@ void amdgpu_virt_ready_to_reset(struct amdgpu_device *adev);
>  int amdgpu_virt_wait_reset(struct amdgpu_device *adev);
>  int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev);
>  void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);
> +bool amdgpu_virt_rcvd_ras_interrupt(struct amdgpu_device *adev);
>  void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev);
>  void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
>  void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index 65656afc6ed1c2..1bb8393ad6d358 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -196,11 +196,22 @@ static int xgpu_ai_request_reset(struct amdgpu_device *adev)
>  {
>  	int ret, i = 0;
>  
> -	while (i < AI_MAILBOX_POLL_MSG_REP_MAX) {
> +	if (amdgpu_ras_get_fed_status(adev) || xgpu_ai_rcvd_ras_intr(adev)) {
> +		dev_dbg(adev->dev, "ras flag is set, poll for IDH_FLR_NOTIFICATION_CMPL\n");
> +
> +		for (i = 0; i < AI_MAILBOX_POLL_MSG_REP_MAX; i++) {
> +			ret = xgpu_ai_poll_msg(adev, IDH_FLR_NOTIFICATION_CMPL);
> +			if (!ret)
> +				break;
> +
> +			dev_dbg(adev->dev, "retries left = %d\n", AI_MAILBOX_POLL_MSG_REP_MAX - i);
> +		}
> +	}
> +
> +	for (i = 0; i < AI_MAILBOX_POLL_MSG_REP_MAX; i++) {
>  		ret = xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS);
>  		if (!ret)
>  			break;
> -		i++;
>  	}
>  
>  	return ret;
> @@ -408,6 +419,12 @@ static void xgpu_ai_ras_poison_handler(struct amdgpu_device *adev,
>  	xgpu_ai_send_access_requests(adev, IDH_RAS_POISON);
>  }
>  
> +static bool xgpu_ai_rcvd_ras_intr(struct amdgpu_device *adev)
> +{
> +	enum idh_event msg = xgpu_ai_mailbox_peek_msg(adev);
> +	return (msg == IDH_RAS_ERROR_DETECTED || msg == 0xFFFFFFFF);
> +}
> +
>  const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
>  	.req_full_gpu	= xgpu_ai_request_full_gpu_access,
>  	.rel_full_gpu	= xgpu_ai_release_full_gpu_access,
> @@ -417,4 +434,5 @@ const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
>  	.trans_msg = xgpu_ai_mailbox_trans_msg,
>  	.req_init_data  = xgpu_ai_request_init_data,
>  	.ras_poison_handler = xgpu_ai_ras_poison_handler,
> +	.rcvd_ras_intr = xgpu_ai_rcvd_ras_intr,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> index c520b2fabfb9a8..ed57cbc150afba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> @@ -51,7 +51,9 @@ enum idh_event {
>  	IDH_FAIL,
>  	IDH_QUERY_ALIVE,
>  	IDH_REQ_GPU_INIT_DATA_READY,
> -
> +	IDH_RAS_POISON_READY,
> +	IDH_PF_SOFT_FLR_NOTIFICATION,
> +	IDH_RAS_ERROR_DETECTED,
>  	IDH_TEXT_MESSAGE = 255,
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index 17e1e8cc243752..f2e5b38a64314c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -225,11 +225,22 @@ static int xgpu_nv_request_reset(struct amdgpu_device *adev)
>  {
>  	int ret, i = 0;
>  
> -	while (i < NV_MAILBOX_POLL_MSG_REP_MAX) {
> +	if (amdgpu_ras_get_fed_status(adev) || xgpu_nv_rcvd_ras_intr(adev) {
> +		dev_dbg(adev->dev, "ras flag is set, poll for IDH_FLR_NOTIFICATION_CMPL\n");
> +
> +		for (i = 0; i < NV_MAILBOX_POLL_MSG_REP_MAX; i++) {
> +			ret = xgpu_nv_poll_msg(adev, IDH_FLR_NOTIFICATION_CMPL);
> +			if (!ret)
> +				break;
> +
> +			dev_dbg(adev->dev, "retries left = %d\n", NV_MAILBOX_POLL_MSG_REP_MAX - i);
> +		}
> +	}
> +
> +	for (i = 0; i < NV_MAILBOX_POLL_MSG_REP_MAX; i++) {
>  		ret = xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS);
>  		if (!ret)
>  			break;
> -		i++;
>  	}
>  
>  	return ret;
> @@ -449,6 +460,12 @@ static void xgpu_nv_ras_poison_handler(struct amdgpu_device *adev,
>  	}
>  }
>  
> +static bool xgpu_nv_rcvd_ras_intr(struct amdgpu_device *adev)
> +{
> +	enum idh_event msg = xgpu_nv_mailbox_peek_msg(adev);
> +	return (msg == IDH_RAS_ERROR_DETECTED || msg == 0xFFFFFFFF);
> +}
> +
>  const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
>  	.req_full_gpu	= xgpu_nv_request_full_gpu_access,
>  	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
> @@ -458,4 +475,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
>  	.wait_reset = xgpu_nv_wait_reset,
>  	.trans_msg = xgpu_nv_mailbox_trans_msg,
>  	.ras_poison_handler = xgpu_nv_ras_poison_handler,
> +	.rcvd_ras_intr = xgpu_nv_rcvd_ras_intr,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> index 1e8fd90cab4347..719a4c88615752 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> @@ -52,7 +52,8 @@ enum idh_event {
>  	IDH_QUERY_ALIVE,
>  	IDH_REQ_GPU_INIT_DATA_READY,
>  	IDH_RAS_POISON_READY,
> -
> +	IDH_PF_SOFT_FLR_NOTIFICATION,
> +	IDH_RAS_ERROR_DETECTED,
>  	IDH_TEXT_MESSAGE = 255,
>  };
>  
