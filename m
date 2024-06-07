Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E488C27C55
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 07:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8406310EB73;
	Fri,  7 Jun 2024 07:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c5ochq/1";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A9910EB73
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 07:24:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8qjW9s+1wCL+vYuir598tvd3YRnNb/2mm5L/2bRpp+ZE1+jSFSW6XU95XbHfy6UjYQsrhetywoQYMXLJFN92yXx78Ul8jVY3fVu62ebBVgsBSt0HWtveBOCG4WUjPwXZ9saZiquvgJ4OTbkAR1gOXR0OYBMbC3H0wEG8HVpNSJe9F0JA1hqSiWARnnTBbSqglDWzs1SkbsDQr4EpiJN+zG+MU/0XSGLsmH6OxZ+QrbgLvjCYHD+oORIjXj/9Uyuy5zz7sZBTUgcB6OuOcl2JPikCF4sLHKEfFTU6PAr3AZDkPUV5b+M2uBV+QUcIJXD7HZ3vRr7eG7YTMVOkEPz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zy/rde+iNRwPJ06oSfSztg004I5whASFtySk9jWhp/U=;
 b=GXrrp6q/LivmhEJvkg3weCHcWSzdSfI6oZrEG9M+IGIO+SKVS1cgZMMt6cON4dcKqtNPDQuloQl71/suEgkE+kGcug7BB9hTtkeHEIxErn9hCsn1Q2p+TSb7YZSw1LlATNYGsUrL060alXos2HZbIEfpl/xnUK8oW2z46BpZo+GjchHnjH6PPIiXNmBJ2hkhgEhANxUDVSdClsz+Mrb3pUZAcGuJZLQj/Ouh1+fLvltRqdMxGz50sL0qfuxR+3ZZdGehR+TvvbgHFFsRUfgNMloB3xIcX/EDw4dbY9XTBxxLh7GxR33G7BQgMsbOTr54QH6kXbMwnuFzO5TbzgzJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy/rde+iNRwPJ06oSfSztg004I5whASFtySk9jWhp/U=;
 b=c5ochq/1qkwrw30QExSpiSt0/VJ0Cqx5au2B+oCms8hzo+yu/lNvKZhlj23EThQ9FSyE79KcFav+hKDCBd9vJgoHKNq8xNWWWx+XQstYWDUJxWH7J2kgRRbe0Ek5AKe4o5BLmcpdt8EwV2Dh75HJwG3sJkGasenNmuSOd/LH3zo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 07:24:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 07:24:26 +0000
Message-ID: <683ec7da-6a06-4113-8570-a49d22ca24a1@amd.com>
Date: Fri, 7 Jun 2024 09:24:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Move SR-IOV check into
 amdgpu_gfx_sysfs_compute_init
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240606120532.2499698-1-srinivasan.shanmugam@amd.com>
 <f189a0ed-2c3e-4e66-96fc-36f2e2ad3bc8@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <f189a0ed-2c3e-4e66-96fc-36f2e2ad3bc8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc6abf4-bb86-488d-7f09-08dc86c2dc3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUxjdzR5Zzd6RkJ3MWdEWnRtMjFhVlFQSFllVzNHbWZjVnhTNmd6OWI1cWpE?=
 =?utf-8?B?eXVKeThocFlUOGFVUGZCNGxyTXVpN3VoVjE0TWF4ZFZZME1RSHhjZnJIbTVh?=
 =?utf-8?B?RXE5bXIxUFNBSmZmZ2ZtQU52dWE4MGdXSlBCTUdyN25LTkJycUpmc3BUd2VG?=
 =?utf-8?B?TFlIc0RGTDZMM2pvUURTaEpNaHJoMFRsQnNHY3pVaXdHb3Y4b1FteTZUc0U2?=
 =?utf-8?B?NXZPZHNiQVVMK1NsNXdHZFZENWprMTVJTkhDdG96SHdTa2g1ZUxTNmpXMzlN?=
 =?utf-8?B?dzhyMit3VXJ5di9hbTZMNUNzMjVVV1d3d3AxTmYvQk5kZHpjSEFQbmErdjAy?=
 =?utf-8?B?TTJrSTFyVDk0QVpwU0ppdUxkMDJMOHg4bjBaOGlweTBrQ1N5cWJheFRneVhJ?=
 =?utf-8?B?Tk43Qk45OEViWkN5ejFRRS8zN2ZWV3U2WEUvQUMxeTZNRzBlRGVTUGpmRXRh?=
 =?utf-8?B?V0xycVNVUDk4bHROTFVBUERvVFNSakc3dTgvVHpZMStLWmNtSWFuT2MvV0pw?=
 =?utf-8?B?MUdVbHBuaUhyT3BKc0lmL1hRYklobnAvekF0VE1YNGFNQ2VCZGZvWFUxMnc0?=
 =?utf-8?B?UCsxM2I1TlBOUm55VkxFVVV6c3ZYcThxcktFamVETUV4L3BvMVcwc0JwblNW?=
 =?utf-8?B?R3l3ZnJLZWFNb3FqdFhSektERTRLWXFxdXowa3lLRFV3Q29wNW50UzkvaG1Y?=
 =?utf-8?B?bStwZ2xuWEFxaWFmaHdxRlJlUlVuQWw1L3hhK1pXTnJPV0VORk1paEVkZXk5?=
 =?utf-8?B?cVluYkZVN0NScENtQlNNL2ZKcXRCUHo2Wkp3RmxSOFU2SGtTOEdLdlE3TU1y?=
 =?utf-8?B?TzJ3VTFhN0xuZldqS0JZam1hZTYwbnExenB3U1BLNUtzc3ZKRWVRM25FWFJT?=
 =?utf-8?B?SkR6eFJBUU1waVhack03TmQxanNlWlNPa2N2elFUdkkyNHcyMXBKWExxd3ht?=
 =?utf-8?B?UGMrMHNxT1RQb1dybVJKU0pEVko1QW1wblhTNWNnU1hiYkVWZHltclZLdGZ4?=
 =?utf-8?B?djdCMDQwOHk1bmJ4U3krWDhuckh6UHkxR1czWkxqK2RDSENINk5jNjJXdytZ?=
 =?utf-8?B?UDNuY2NsUE9VQ0l0TUx3S0VySDQwVGNlMlFYdGVweFlpSVIrd2tzNjByMFlw?=
 =?utf-8?B?SFVDTmRielZDUkk4UUl5V3NGbVhVY1RwSGo3VGJ6UVU4SmtJeE5kNVc5V0JZ?=
 =?utf-8?B?MmpNL3BiZ2xGYUVoM0tTK1QyenBLRHpzdE1Vd29lNmlxUkIzRVprTVJCWFFQ?=
 =?utf-8?B?SmdQNkVhcHhMSWd6U1pkWk9qY0RSRFVueUxRdzBBN1NBTUQ1cEhCeStHVjJE?=
 =?utf-8?B?ajNvL1BpUU9UQ3N4cGlVK0p2ejU5OWtVTldyRW9razh2ME51eko5VXZNWWht?=
 =?utf-8?B?Q1BvbDlpcEc4WU12cFNDQXVQRkprK1BYRlFtM2ZrS25HRkhQZVFRM25sMG44?=
 =?utf-8?B?T2VReHhzcGZ1U0hacWI5WTlON2dlSUxNY25PcEJJYnYzaHE3QUR0Tjg3Ym9p?=
 =?utf-8?B?QWc4eW5xaG5FaE5ZZmg1VVVWTWNDZndSeUtTRnJiRGJ1THNqY1pwOEtPKzRD?=
 =?utf-8?B?cGxOcDIwdlJvUm1JZEdzTEpvSlpTL1E2bTRSNHRqdGVkKzZrcnJRRTloaUpy?=
 =?utf-8?B?amZzeFhnWmwzWGt5WmdsOWFYMWhnT2FXTkF6a1RTYXBSTGJabWxpekZaYjhi?=
 =?utf-8?B?UVgvVmM5NnA2N0lsMXNuRm4xM1l1WVJRUGxnZHBSTnBXKzRkK3NQT0RuRVJC?=
 =?utf-8?Q?wWrFuQW+/7qx7Z0CpiVVDBNiy13lGj7s4s1ppzS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3pEcjFXa2ptbVpUU0w5ZnBUM1FHSTFCT1prbW9zRjVnU3JuL25VbWpJdURi?=
 =?utf-8?B?ZzFydG5YbTRnaysrTjFQZk54Q1ZndzRKcWdxd0ZVbVNkZ291MktvMVJBeCtQ?=
 =?utf-8?B?V1FlOXpXUk4yZnhiQzJWK3EwVFE1WDVsa21xMFRUaXNyKzJzT0lwNlhUVFZi?=
 =?utf-8?B?azFzclRoKysvZ3FTK09IYmFrYU94L1Q5TC9LNk1PV2Uvc3dTQUo1MVJXV2s0?=
 =?utf-8?B?Yk4ycTlOVGJxQmRTSHhuQVNIeFNSZzE4WDF6bnJHdHFieW5NTitVMlFiS1ZO?=
 =?utf-8?B?Q09MbnFWdnA3U3FXSk9DQTRvcVkvQkdVTEdqa05uaHgwMnEyR3NVRUJobWpB?=
 =?utf-8?B?eXh3MnB1cXdNMERmbUJ2TWlSWmo2cHovQmw1Zk5SdHYrc1ZWS0ROQ0pPRkVI?=
 =?utf-8?B?L2pKdm1kUUI1cGloazVOVk9oOElFSDM2eUdyUGhFM0p6YmQyRHBSd2ZxR2tM?=
 =?utf-8?B?WDY2L3kxMlpuZDZzQUZobGRsOUp0SFEvN1Q1R2c3WU5qY2M5VHVGZHRSWkl5?=
 =?utf-8?B?OGVoaTlZM0o2RGpaWCthL0JldGZUb3JGcG50YitVZHhZUCtZTndMZmM3WXo0?=
 =?utf-8?B?UEdMLzNzbzAyS1hwVndqbDljbkJOdGJOK3NXRzRLczNVZUIwTTBYdXV2M2dk?=
 =?utf-8?B?SUdXNDdVVkhQTHBPSXpaVlRNMXM1eUlhWG4zZVFjUFdpay9CL3gwNEFEcjVy?=
 =?utf-8?B?cHdoMDAyOGhKeHZSVHdIZ0hkck16NU1XKzk2eXYxckdnemUwZ1AySVlRdWZG?=
 =?utf-8?B?bzNQdjJMYktrdUlxRTBLTFlaQUNxMXVQa2hmdU9qRmcvMi95L2VFZG1IbmtG?=
 =?utf-8?B?b0xkd201aFlDa0JmbFFjOTFHb2h0bzFCQXJiSmYwd3dpcWJZZlZqZ3ZNZnlt?=
 =?utf-8?B?QmtUUXpLR1lFYXAzQnNkZGlXdlVHV3Y1QU42V0NpV2NrYzNXZytLa1BWeWI1?=
 =?utf-8?B?Rkg2eXFzOUg0RnBUaWtJUWlPb0E4TkdWc1VxWVFLWlIyekpmZEZxRzlrWDhs?=
 =?utf-8?B?Vi9zUUtSTGFzaTIraTYvano1K2EraXp5UExycithcmZXeFlNUWJhR0IyZjZm?=
 =?utf-8?B?MEpQajE5MDhSV05LUmNRSmJiNnVXOW4xTmpuRGVKSjV2Q1lxQjBWYk5TQTEw?=
 =?utf-8?B?OVdIUkZoWlNaS2J4WVoxTElkc0ptL2V1eThVVFEwRzl2UDNhNW9FbEdDNFVq?=
 =?utf-8?B?cERzREc2a0tjQTVydUE4RUF6bkJJS1pEMFlvNW9mK2ZXTjhBSHdJUFJYdk9Q?=
 =?utf-8?B?aXZkYjJrWHgxYmNyTDM2NHYvaDF0aHJMcVJTeUg3L0J4blhRV3dnaWM5b3hT?=
 =?utf-8?B?Q1ora1FmdnJFS3FJTXh2RGdJRkY4QXd2Uzl3SEtieGpOczBPK3owVmE3RWl4?=
 =?utf-8?B?QXh5WCttNXhnRTNzeDhGN2daNys1b2FQY3lOVVkya1hJb1p2cm5Sa2dlZ2NO?=
 =?utf-8?B?KzV3aDlNYlI3V0M1V0xMVkZzRjlsdW5mRmZKUHBvU24vUzIwZGV5QUZYUXlF?=
 =?utf-8?B?bHJQWFM5VUZpd0dGRlRGNTdDc3FqM1U0YmVUU1RPU2JSL1U5VDBoZGk3TWFS?=
 =?utf-8?B?VTZqYjFXRkliOGIzWHNLcElyMWRxYWVSNUtEUmZOTWtIYUdDS0FwZUw0azV3?=
 =?utf-8?B?bjFaVkJUN2xOcVh5RE9sSUk0SHM5VDVIWEhSdGxVTHhhZEVMdHhpTEVsR1c2?=
 =?utf-8?B?OElFVXZjNjZuMGlINFExS0dLZ1pnNVUvTmVUeUxENjZUTTFGamdrb2RjVzBn?=
 =?utf-8?B?VjRHalcrT1E5ZmdGL3VNYWJ5am52UUVoQmNPLzVETk03S3JVd0Zwd0lUTHhq?=
 =?utf-8?B?QWhiQTdVMWdLTVRreWVORXRuUklBZEVNQ3RwRnpibUxmMndWK05JdWdsZHRJ?=
 =?utf-8?B?L0NJdzlaWmY0TElRUE1tNzZ1SFBPZmY5eWJ2MGNWWGYyNGRPUjlZa3VOaDkx?=
 =?utf-8?B?bmRya1p0bUFLSmxMcWFaLysxYVAzaVFraVM0WDNxSG9Ebm1NMGtHV0N3RFIy?=
 =?utf-8?B?djhHSlIzY281eXFCajAzeTJiSjBWWWNWU0tYS0piKzkveVlPUG96RWppTzFC?=
 =?utf-8?B?d29OYTgyREYyY215RFBLbXg3NXIzZUdFcGtBRkt3U2l2MldVcDl5TDVGUGVr?=
 =?utf-8?Q?juWyVKB90ZA264CZd3Xowzmes?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc6abf4-bb86-488d-7f09-08dc86c2dc3a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 07:24:25.9340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: om6c/fTRdp2g2VkamisTyzw3xdnY9ZWNBekMRbk3sz10Hzte19An3UBoCLA3R+zb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750
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

Am 06.06.24 um 19:28 schrieb Lazar, Lijo:
> On 6/6/2024 5:35 PM, Srinivasan Shanmugam wrote:
>> Previously, this check was performed in the gfx_v9_4_3_sw_init function,
>> and the amdgpu_gfx_sysfs_compute_init function was only called if the
>> GPU was not a VF in SR-IOV mode. This is because the sysfs entries
>> created by amdgpu_gfx_sysfs_compute_init are specific to compute
>> partitions, which are only applicable on GFX9 and not on a VF in SR-IOV
>> mode.
>>
>> By moving the check into amdgpu_gfx_sysfs_compute_init, we make this
>> function responsible for deciding whether or not to create the compute
>> partition sysfs entries.
>>
>> This change improves the code organization and maintainability. If in
>> the future the  conditions for creating the compute partition sysfs
>> entries change, we  would only need to update the
>> amdgpu_gfx_sysfs_compute_init function.
> This is not correct. If this has to be true, this will reside somewhere
> in amdgpu_gfx and you would also need IP version inside this one. If for
> a new IP version say gfx v9.4.5 this needs to be created for VF also,
> then this check here won't work. This is the specific reason why we put
> the conditions inside IP code.

Yeah, but that doesn't make sense. See the partitioning mode is 
something which is fundamentally incompatible with SRIOV.

So this is not IP version specific at all.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 24 +++++++++++++++---------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 11 +++++------
>>   3 files changed, 22 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index 19b1817b55d7..72477a5aedca 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -1376,21 +1376,27 @@ static DEVICE_ATTR(current_compute_partition, 0644,
>>   static DEVICE_ATTR(available_compute_partition, 0444,
>>   		   amdgpu_gfx_get_available_compute_partition, NULL);
>>   
>> -int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>> +int amdgpu_gfx_sysfs_compute_init(struct amdgpu_device *adev)
>>   {
>>   	int r;
>>   
>> -	r = device_create_file(adev->dev, &dev_attr_current_compute_partition);
>> -	if (r)
>> -		return r;
>> +	if (!amdgpu_sriov_vf(adev)) {
>> +		r = device_create_file(adev->dev, &dev_attr_current_compute_partition);
>> +		if (r)
>> +			return r;
>>   
>> -	r = device_create_file(adev->dev, &dev_attr_available_compute_partition);
>> +		r = device_create_file(adev->dev, &dev_attr_available_compute_partition);
>> +		if (r)
>> +			return r;
>> +	}
>>   
>> -	return r;
>> +	return 0;
>>   }
>>   
>> -void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>> +void amdgpu_gfx_sysfs_compute_fini(struct amdgpu_device *adev)
>>   {
>> -	device_remove_file(adev->dev, &dev_attr_current_compute_partition);
>> -	device_remove_file(adev->dev, &dev_attr_available_compute_partition);
>> +	if (!amdgpu_sriov_vf(adev)) {
>> +		device_remove_file(adev->dev, &dev_attr_current_compute_partition);
>> +		device_remove_file(adev->dev, &dev_attr_available_compute_partition);
>> +	}
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index 6b0416777c5b..b65c459b3aa9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -533,8 +533,8 @@ int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
>>   						struct amdgpu_iv_entry *entry);
>>   
>>   bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
>> -int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
>> -void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
>> +int amdgpu_gfx_sysfs_compute_init(struct amdgpu_device *adev);
>> +void amdgpu_gfx_sysfs_compute_fini(struct amdgpu_device *adev);
>>   void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
>>   		void *ras_error_status,
>>   		void (*func)(struct amdgpu_device *adev, void *ras_error_status,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> index aecc2bcea145..07ce614ef282 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> @@ -939,11 +939,11 @@ static int gfx_v9_4_3_sw_init(void *handle)
>>   	if (r)
>>   		return r;
>>   
>> +	r = amdgpu_gfx_sysfs_compute_init(adev);
>> +	if (r)
>> +		return r;
>>   
>> -	if (!amdgpu_sriov_vf(adev))
>> -		r = amdgpu_gfx_sysfs_init(adev);
>> -
>> -	return r;
>> +	return 0;
>>   }
>>   
>>   static int gfx_v9_4_3_sw_fini(void *handle)
>> @@ -964,8 +964,7 @@ static int gfx_v9_4_3_sw_fini(void *handle)
>>   	gfx_v9_4_3_mec_fini(adev);
>>   	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
>>   	gfx_v9_4_3_free_microcode(adev);
>> -	if (!amdgpu_sriov_vf(adev))
>> -		amdgpu_gfx_sysfs_fini(adev);
>> +	amdgpu_gfx_sysfs_compute_fini(adev);
>>   
>>   	return 0;
>>   }

