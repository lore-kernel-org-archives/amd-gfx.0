Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1752AE77183
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2024 08:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE70B10EAE9;
	Wed, 18 Dec 2024 08:32:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2aAd9cbj";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C56B610EAE9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 08:32:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsvvPLNhoCG0hW0zoEZJASg/baJ/Ssg68B3HaY1NAkLqULx9E9zz6nWZIlJPRQCin5OLrcWiY0jRQnZgh6bW8qmmdUyz4lh3u7qlJr/huiH5iupaHfEOKUYu8yHIXLgjGhyNSaYMD+q7q/4TR64tzCTElBQFE/46/nYrAZE5FTMqmHiaZ1jwYequc8jChp9HmriNdsbYx7QErG1kYtgmqROoNDy4L6vDh0YuiwuZ552K6dTT2pnZ2BABzj3ZzHj/MoNOgpKZ24eI5/sHTECXz/gZJjh4UpjjqnSQsLmKgC4PTG9yT5xyYxmi2HQUvsRL3bjPp8IuDEz9GkWHEjQxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2atnLaW1Fhiu7emFVLunCU0Pb5cY+MtjUg15gzXz3Kk=;
 b=tmib8naiinGwjwXgbX4LoLIRuwPQ75+Ivtv+7gxL4i+waiczC2XAbxZN8b92B2KTfNq/8f9qZwo9d9oL+Hk6hN2B+qejTdx2QgzEitWwyhVZfvFEtHywcf7KzbQvJBmLoxwU0Yvl2fu2miugUUMzA/AEMoYJD00uLJ3LKk1q2joReKRegjksO+X+/XZjz6dx8tYwUEUmsZ+5KU1RTUCjBP7RHkJRda8dKIV28DKn9T9a8Gh/9vGFuCcaLxKeS37G7f4XwTzcQmKHN/vk+BFmLC6Cf3OSwHTTD/6KowyvV2tCZFNd5lqEL3C/oU/sYagEUKyanthPzaNN/52GFJIQ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2atnLaW1Fhiu7emFVLunCU0Pb5cY+MtjUg15gzXz3Kk=;
 b=2aAd9cbjPCuz215jU4po/K6HHdXhPDjJtmFP3pYCCvwyHDFnCka1/R0119tP6DgRvNNpi3FUtDtc7nXWi0rdd9VFTZPR7DIMNAqr/rybmaQCBGIBFXiXEOeRlK/7q9gi+Kc2W7/1R4d/0XhNxSzOLLus5Qzszq8QrSuCAA+rNrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 08:32:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 08:32:52 +0000
Message-ID: <5a88367d-22be-45b5-921d-a9985a56357a@amd.com>
Date: Wed, 18 Dec 2024 09:32:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Handle NULL bo->tbo.resource (again) in
 amdgpu_vm_bo_update
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241217172256.3668-1-michel@daenzer.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241217172256.3668-1-michel@daenzer.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 770f3f30-0efe-4b8c-daef-08dd1f3e8fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1pVUzl6aEFMNTlJQ24rb2xtUTJBMHg5aEJpaG1vMGhBMVJaZElQbUovTWNv?=
 =?utf-8?B?Yk9uV2RQM0FpdlAxSU1uZkNCeW96ZFpGSzdRY3Jqc0IxamNZZHNQUXE1dmFU?=
 =?utf-8?B?a1dmSUVDelhIV0wwRWlkeE05VXFZaE5IK1Z1Rm11UWlDbTBKY1YycXlsNFBM?=
 =?utf-8?B?K1R3VlErWnVvMUZPMnZ2VDVBUXh1SzNXb1pMdE8rTSsvZDcyYnRaVnNpWWhl?=
 =?utf-8?B?NVppd2NiQWZyMUVlbnJsRHV0Nk1TS2w1UkFEK2habk05cmR0bFlqU25SZXlF?=
 =?utf-8?B?Znd5Q1pzVENBWWIzU1JTWWdoWmEvNGhyZmxYNmZLZGJsWHJJT3Z0NFZYMFJa?=
 =?utf-8?B?Yml4c3RBT1hpTEluemhjeTJWT2o3Z1duWWlPanhZaTRzNHpxU25MK3B3emlm?=
 =?utf-8?B?SzdBeFQ2VjRwZVBreC9ZaW1lREdtOWJtbnp1cG1nalJITldlZ2FhcDR2OGdo?=
 =?utf-8?B?UWpBZStWcVp6RTBNcXl0NU1JemJiL0FvMmZ0UldRZU15VXR4bnpmVzdaTW15?=
 =?utf-8?B?UnhJUnFobkIyN005S01MM2pGZjBQRmxOdDhNeng0V1JlelZTK3VBcDYzMXVR?=
 =?utf-8?B?cTlQR0lQRTFEM053UUJQUm9lNGw5emNDZW5ySlRTd0lkUkFGVit1QURuSU9k?=
 =?utf-8?B?VFZPR050QnMydEF4UE1GY0s1ZVg1dXNsUkVOM1hhamI3MGlyM0s1SHVCb3dO?=
 =?utf-8?B?b2ZlOGZmY0lTaGxlMW9CRk14RmtWOTlEdUl5d2xVSlEzNmJtZ3k1VjhDTnhC?=
 =?utf-8?B?SC9XcFgyZzV0cUN6NDBTbGRSclVibEhSakt1ZUg4aGF2SzNicUlBcFpYUHJx?=
 =?utf-8?B?SjQ4aHpSTDY4TU1nenBFNWhYNmlpM28vcHA0dzhzOGFZRGtTN3lydkFaeGZL?=
 =?utf-8?B?YWhwVENtbVcxNFd3V01NcW84MXZOT3VSbGlnSEgxcnlRSlRFblVHNUwxai9i?=
 =?utf-8?B?d3VuQ2pXSlh6bzZ6M3k3VmZHMFZiMXl5TVBXa2N3elErdC8xdDRCdkdxWTVo?=
 =?utf-8?B?L1JxVUJpRDJxV2h6SzF1bFhTbjU1ZXVoTDF5TlBiRnFZODdpV0t5d01wYTVy?=
 =?utf-8?B?OTBKYzFMNnhYS0JXaGdsU21BTmNlSmZqWG9CS3I2TGRQeWxWUDNMUGZjbGRP?=
 =?utf-8?B?b05NSlhGR0krVzRHMzdCU0VQVjU4d2ZBT1JscStYZ1ZIeXhpcXYvVWdzTXdk?=
 =?utf-8?B?eWVTRnVqeEx3YUVRakg3R3Vyb1ArNzU2VzQ0aDlLbDJ1a1FtTEF4c1lsNThH?=
 =?utf-8?B?dnJFMVc3c2JFQzV5NEFPZjVXb3o4VHdqZzBpb2JOcWV4UXp4eWpTREFjcVFM?=
 =?utf-8?B?dkM4YkJtNk85NmR1ckd5WUZ0eWE5T3RlSFpOUUZ5bTBZdDEvMUhYZUh5S3lH?=
 =?utf-8?B?eE1XTTViUndTVVdUbDI4MFBuWnJPcmR2MTJ0cXc4b1RENGZtNVFxMllwenho?=
 =?utf-8?B?Q1hxcCtaalVYeEt0TGIyY1N4QXVjR1lMdjhOUmJVNG1Lbmp4RFgzY1c4WWQw?=
 =?utf-8?B?OG9OUjcwZWUxUC81YjRPWGNUUHFYYkY3UFBxTE9BRFZlRitLamNqUm9KNG91?=
 =?utf-8?B?OHFNVkhuTlR3Qzl1RW9JMXVDcm5ZeTdZWEJVdi9RU2xhZm1pUFUzNmJRY1Jz?=
 =?utf-8?B?dHJnYm04bWJKQzhIVHcwbHI4d002SGd5aUUwNWY2WnlhdnBacmwyejhxbkRI?=
 =?utf-8?B?cFFJMk1mU2dsSnB1cGtPb2prd2VXWlhMcG5PRURabDI4MGhBdjNBNWRpVkVQ?=
 =?utf-8?B?NGdNK3pYVi92anlCS3JKS0VidlhsaDd2RHZmR0htNlQyM3BWZTk4OVhNc1Nr?=
 =?utf-8?B?aHMyc09Ea04wQXlGTVA2QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFkrMnZFdFM3T2MrNldRWkpnWGNYQWJuR0VmNE4wTzVCNTA1TFFwelBOMm9T?=
 =?utf-8?B?aWJia3dKQysvUWFTdHZJN0xmN0hKSWFnVER6TFhCdTFOVEZHamd3UWFjRnlQ?=
 =?utf-8?B?R0VqamRhdlJPU3BneVZWMkFXTzYwSEcxajRJR2JZVWp6dVUwSE5SdTg3cm1P?=
 =?utf-8?B?d1dSYkthcFJ3OHpWa2dlL2xIaFZhbVRKcnpOR2xCdDFsYjdoeU5VUVJ2dm1m?=
 =?utf-8?B?VzlyMXRxZXlHSnFvSXBseHB0Vlk5Mm1DM2ZMQnBSaUo0V0I5elk1Y2lCYXUx?=
 =?utf-8?B?WFpIb1paaFQ5dXVMZHNOVlV4TUh2ZCswcHZGbkFTMG04dmtGU21PdXRhOFZv?=
 =?utf-8?B?Ynh4ckM1TnpJRHBBanlVNnB6OUhqQUs3RzVIb21jckR6WFppU1c2NW5TeUN1?=
 =?utf-8?B?Y3JqbkFMWjEwUWdnNG5TdXhvcS9hZUlYRFdmckRyNlppd1crN2dZSTRkRng2?=
 =?utf-8?B?amdrZFNWcnErUVMveS9LTEtCWFVPcldITlp3dXFuTkhKZHFkUENMT2JUVFZz?=
 =?utf-8?B?S0R0RldkTXdZMVozdG5CV2o2WVdvRmdyNjFLK2xMN1ozeDBsL2Z0SXhheWdS?=
 =?utf-8?B?OGxQeWY4ZjM4bWxkUUdia2RYUXNwZG14SytvRUF6Z3YyaldnVFlyaVB6VUVp?=
 =?utf-8?B?TEpqZEZxb28wQldCdUMxc3hOcGpxUkV5UGZpS2N3TEhodHd3SlIrNkdUeWdF?=
 =?utf-8?B?WUtVcHNlandFS1B1RzdiRmxRVExvU1RpakhXd2RxRkR2dEtuN3IyUVVSMnQw?=
 =?utf-8?B?K0pqODJJSU9LMC82S3Z2YTVleG41Q1JmZzUvSjFDWDQzcmg2TXVucXdxK3Zw?=
 =?utf-8?B?blE1OGpTR2dtRFVxbDA0d24yMmRXeUh0dDdkTzZvSWZHNCtwNWNqRE8vK3Ry?=
 =?utf-8?B?cVlUaE1jVXhoeHdKMm1jWDI3SmRWUGM5Y0lCbGFqNFFJNndZNFlYSTU5b2tB?=
 =?utf-8?B?U0pURzBUbVVLV1RCenVzWnlzV3F2T1crUFIxM094Si9CcnBFQlhCV09oUXNM?=
 =?utf-8?B?RjZZR3dvbjhpSjhUeVhDSlNmaWtwVFFDdzhRSFh6cWE2UG41dG1FUEpXY09w?=
 =?utf-8?B?blNBQk5mYWdEUnpJVUZ4dXY0eVVrMngwUWJOb2JRNWMxUkM3UmhBNWthZHhi?=
 =?utf-8?B?ditocDNveVlVeHdZNG9LdjZTNGtnWVV0Z1piRmtLS1AvRE1kQzNSOHNkQXYw?=
 =?utf-8?B?TlAyNlFYL3RNNXJhazhRSkh3eGFVam1CRDZpVTJ3YVZ4WmY4ZVFKOHR1aEhX?=
 =?utf-8?B?ZkhSMXBUTzdqNDdrWFl6Nnd2c2pJakJWVWl1MkhGT2ZLMjhaK2NkNCtzSDBC?=
 =?utf-8?B?WnBidVNLRDEzV3Z5c1JKOFB6eFlSQzd2R3dHQ3I4RGpOVml1UjZ2a3gzaUV3?=
 =?utf-8?B?M0hqWmZreDNMeDFITFJ0NzFpZXpLRVJJZVExaDNXdkx2YmRHZWFKUWg2NHpv?=
 =?utf-8?B?Qm1qMm5rYnV0c3RSSStBallsMkMrRlhGd1BQWHlrK0JYdmlQTHpCYmh0UTV6?=
 =?utf-8?B?Y3MyNnRCeGFOaUtTaUtTaVNUT1d4ZnJsekJUcDRDNjRKTUd0eFViaHR0Tmtp?=
 =?utf-8?B?K1kzV3IzTWIzUjBPbmRMbmR0VUx4K3Njb3BjK1lyWFE3Yk1RVmJTSjloL2l0?=
 =?utf-8?B?SllrNkdDZkNnUmthaDBaNnEwaHFZYlo4enM4dmFGd2xjWVZXSWUyZDBIS1gv?=
 =?utf-8?B?bVNXb1pKcHJwcUgwNmRNOFRVU1VwWThJMS96V1QraGxLYVhneWY5KzZPYmJC?=
 =?utf-8?B?bEt2cHIwY2JpSk9ieTZkT2IvWDM2SFdFcHdmTktzMWZ6VHJsR2wxdVIyRHNJ?=
 =?utf-8?B?bkZ5Myttand6amVGUlJST1l0Z1hmSEFaczNJSnVTUm00MlpURUJIc0lGcHFH?=
 =?utf-8?B?TE8vVS9PU012dHdzRnhIdHhEclBFNXc2SlFoSE83d3p5UGNCbXBSY2VlV3hs?=
 =?utf-8?B?WEk2Wit2THNxWmVrWWFpOXcrOWtaL0NpQTROQ3NrUm5DSmE4RVJrZHhiOG9i?=
 =?utf-8?B?RXc4VkRDZys3aVhYTXB5RFRpb0tWTnZWQkwyeVdkMnkvQ1BpZlVOTnBNKzNP?=
 =?utf-8?B?eHhHbmdqdW91bkFzQVZucHNHeHlYc2FZQTU0UkxqYUhWQU1RTDVjME5Ldzdo?=
 =?utf-8?Q?3OcZfxOupXOZxxNBKEJuqEe3+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770f3f30-0efe-4b8c-daef-08dd1f3e8fe5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 08:32:52.1815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSVnt4gywDhObLKfNtWqQjOqCWOLT1xDw4ThqtbvSnIjYqtelWufD4hO25pLRGsV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652
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

Am 17.12.24 um 18:22 schrieb Michel Dänzer:
> From: Michel Dänzer <mdaenzer@redhat.com>
>
> Third time's the charm, I hope?

More like the twenties. It's astonishing how many use cases for BOs 
without a backing store we have.

>
> Fixes: d3116756a710 ("drm/ttm: rename bo->mem and make it a pointer")

Please double check if that code wasn't introduced later than this patch.

> Issue: https://gitlab.freedesktop.org/drm/amd/-/issues/3837
> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>
> Or should amdgpu_vm_bo_evicted be called in the !bo->tbo.resource case
> as well?
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ddd7f05e4db9..c9c48b782ec1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1266,10 +1266,9 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   	 * next command submission.
>   	 */
>   	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
> -		uint32_t mem_type = bo->tbo.resource->mem_type;
> -
> -		if (!(bo->preferred_domains &
> -		      amdgpu_mem_type_to_domain(mem_type)))
> +		if (bo->tbo.resource &&
> +		    !(bo->preferred_domains &
> +		      amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type)))
>   			amdgpu_vm_bo_evicted(&bo_va->base);
>   		else
>   			amdgpu_vm_bo_idle(&bo_va->base);

