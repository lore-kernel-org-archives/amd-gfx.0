Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D60FC48BEB
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 15:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 859C610E78E;
	Wed, 21 Feb 2024 15:34:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KveuOHBU";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2971610E78E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 15:34:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G72Bf9li+xMUc11HtG9I/k18dGIzHvcFUJEwk1qc15cxq0cnvM+0rMBsk2fO89153ZN8RfG/2XNEqC3UyoHo4rJSJHenYEwKRXCK8MtkCYrZ+2Or43E3VRZNDOk2vNeu+0G12LbP62rIDZXkQgOQvQxtYwJmBwiRFLUFA01ultTBv9+FZjiOYPg0K0KUXPojVt76BZs7JV3AKMj9989Sqxcf6b2N1c6waFUG/NhVI9kEAU5HcJTlynKxhu+LkoWCYgev/xMZPbxM+hTo2OiFqQ4Pr66e14x9NxY5Sz16/mC7HPf4SPQwzBTOdhwtoF6Fog12+jMamBSDRccc7XLHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDV+/ypUSBOJimtd9LqvKAwvCyMAEpyhs3gz3gFRVCk=;
 b=kfRrR24494PMBWBUm1moHvxRyNrYYcXVh+jy5a3PCHRBBZvbpTMmBP/Te4l9zETGkbpuO30Kj69ZpgQFlqp8CIXcBPRsA1bQU73yDY5y8rp0D/xMlpY2xjBmGTsF06qV7qJ/w/ZDYvEXvrbpyxkwTOU9zG5aNpHyuqP1LvgQV8osOfHwq38n73QaC3EaI5SU1ks4FYCJ5poPnVpib/MihDtpc5+DlGdzAesGKzAWaVnkpYIhtav3vRc9tVvv3QCQW8nefatf3mcJawSobtMcpjqUta28EJPrr0CwiDkAutdU4yUfyQEgEBQT+hAkNt5m07uLrx2WrCWvWRZh7/jOAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDV+/ypUSBOJimtd9LqvKAwvCyMAEpyhs3gz3gFRVCk=;
 b=KveuOHBUikFou+ARBxZpndkOJGD+EFU/1EGB0093LXZfiAnEn1RC0R+XvbIcWBpQ8H3AOKcz39UNj5BgEVE/AYtUvvuSS2dnEDV9VfXuIRbUoqGrrriFaQlBAdalUikZVtLW11FrZXrAG5DcPPIwWfTXytsweEPfPBKBOqvhjNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 15:34:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dd00:9ab5:4d11:2d1a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dd00:9ab5:4d11:2d1a%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 15:34:42 +0000
Message-ID: <da4a5377-ccbb-45e0-8917-27ad0af0abf6@amd.com>
Date: Wed, 21 Feb 2024 09:34:38 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix the runtime resume failure issue
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Alexander.Deucher@amd.com
References: <20240221093515.1787230-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240221093515.1787230-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:806:120::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4bedd2-17bf-41b0-3717-08dc32f29f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fkw6agHLwPYoQBNXMlbUc59vVfkcmQhB8GT9EKf2kdcAdrrHSedkCwmD8LPF6oFp1CXK8zWH17BEYjtj6+wHEBTPcnajsBwelVKwPGCVHU7dYCU8ztSwo72gTaeRhfzHo2dNXZdfuHo3hEOJRcASfQEz5AX/WW+jwD7ozGRrt6Db9pEAikI8hHjcB8c52NL0F0BifkWq3d/jN1r4Fz7b52mZwmvqKQYiqwdhPhI0LNQNEpFhDoKoL1EWJvo3Gdz3H0nfipTTnpJUW2+iDEcsDE/u8fPiJEdqSJAdsGJ6YDXveiOo+b66PQuUsl3g/C1A9IEqYIG8LbaYAN++IV7FbtzwZWBhH3aQCmWbAVixjxQjdKpkArUNHCgFg57E/bCQhjFGHYKTTaYtnImfrA7rQ5tQd55tXP1N8YTkCizO+yAwFPyo+bZlQq5bj66kRJEMXi/4c4ZysWcyjEUJ2oetCNOJwoae+FGHLkcL/bUDfCaAD5fNtPwOOpEu68L/sC3NIxglQxm1IxoDENhvCckKqVEL1hjQyp112RBBmEdqAK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWV2NjF4emhKamN2MXRoTUE4SE9naG1JWE42empiVGdKSEpqYnJoeTZRdTNE?=
 =?utf-8?B?ZUlPS0crR3ZWeUUrRXI5NE10bDQ3ZnRGd05FVW5LdkYycE12Tkx2MDRQbWUx?=
 =?utf-8?B?bEFSRkZIdXdvQ2hJZjVlR3I0WEErd09qdDlOVk93MUVocU9LQzFPbkdpYUNG?=
 =?utf-8?B?azFkUEY5Zzd4c1BFNlJmN2xiNjRaOEo5OWo5dS9pZmdOdWtpc2s1Ym9LeGlF?=
 =?utf-8?B?TG8vNDBPemRUcGI4Z3dkcFVCYjZpVjBsOXpWM1JJSVZYcFRuSTZhOFBMSzhm?=
 =?utf-8?B?aDkzSmQ3dks0bVg1TlJSSjRIOUJqSmw4NFAzWlQ5YmlibFZXUmNOK1ZCTzJN?=
 =?utf-8?B?YXlMblRjS1BzSFRONmhNcHFPRjBvWFh1cER0N1ZKdmhabWxBdTdlVkgzSTRP?=
 =?utf-8?B?M0M1WHBaandHVmhkN3pHakN6ODNoL01ZU0Z5RTNVZ0FHcWJUQWE4djZ1STVi?=
 =?utf-8?B?SWdLVERuSXlPUlMrZkQ2VTNUNFlXMWhSQUZEQnFnSkc3K3JLMlRnaGQ5YkJm?=
 =?utf-8?B?bjhmVkR5Vlp1eEhCZjFTRUh0NkI3RXlmT2NHUThNQXFZT2dpZEdyOWxLOW1y?=
 =?utf-8?B?OFBwaXIyM0pGczN1WThBTTNPVDBrRVMrN2FyWWsyb0k0RzRDVDhDUktkV2hL?=
 =?utf-8?B?Zll0Ri96cm92UjZQOTZOckhqd3RYVWNrTGRuMWNWZkRNRUlybDJ3ZjFYbkZr?=
 =?utf-8?B?UWQ0UGxNdyt5SDdSKzRVVCt1VkszbjhQNUtEeG1pY3ZmNkpPL2tFMDhTTzEw?=
 =?utf-8?B?aWdDKzgrb1Q3NGVHRjNvWmJuOUdPL25uNUVyOHlGQ05SK01GUmtXSTcrSEtQ?=
 =?utf-8?B?MzRBM2JSSkhsbUhTRnp1RFYxQ29tejI1RmNYWk5PVm5Dbk9yK0NvMm1ZbXF2?=
 =?utf-8?B?clNESGk4alhuSXc4T1BxcTJzWlNHdmU2eXhkQng5L3g1WWR2U3Z6bVErU2RC?=
 =?utf-8?B?OHlEMHMycDNzTzFPSlFFVkxBa0F2M1ZmUFF6M1ROZnB3Qm5peldlN25CcDVy?=
 =?utf-8?B?NFJWL1lobCtBakoxZmRpaWU5MDZUWERpUmdFaGRwUDZwRmVteXprbm9UY05V?=
 =?utf-8?B?NHpTOUl2azlYWWJKeWwvWFR3RDdaaURQVjZSSHJZTFRZRWpicWVycGxPREk3?=
 =?utf-8?B?V0x6VzFWV3QrQVN6cjBtS3NaYngxTDNmYmp0ajF6blQweWhHTVpPampOODJs?=
 =?utf-8?B?VGluaFVWSDNYRy9RSXNLeFQ4UkVKU29wYTYxVFJ6NmFiTVg1N3ZqV2hDdHlC?=
 =?utf-8?B?RTIzNjJPbnVIelJuWXdkT3h4bm1QcWh6dVo0UGZ0SnVlSWdJQ3VOU3pzTWdo?=
 =?utf-8?B?elZadmZSN2F0YjFVWnFZQmtHR3grT3VBdTRDelkwcVBkNkVuTzNJRzV3ZUFq?=
 =?utf-8?B?VTVDNUlmZWNVQWlIb1FSL0VqSUYyc3E5Rmowc3l3QnNxUWx1SEtYRUlaYSs0?=
 =?utf-8?B?Z3ZsSUQ1dGdGUmNmeHVPajlQNENXK0lzaWtIUDR1R1JENTMxRmhtalhjY2sy?=
 =?utf-8?B?UEdlUzdxbFg3QUlzcEdEby93Zkh0Wm4ycWhEMkVwZ0E4NXg1K3ovZXNWaHcx?=
 =?utf-8?B?akhmMVFsRUFtaExnODJ5bXR1Wll2emFVbUMzcDFZa0lJZUw4Y3JrbFRnZkN2?=
 =?utf-8?B?YklLN1BUMDZVWmozcmhaTHQvVWpyVlc1U2NZQy9YeW5DWTRqTE5IN3JvMDVx?=
 =?utf-8?B?aE4zRzhEb0RpTWx3Q3BLcHQzMjlhRHJNMWV6TlBZRUJDVkxtbWczSFpsTFZn?=
 =?utf-8?B?d2xMNDNPM2E1VVpzenZvWGM5TER1dmZQSWExVjJPM3pSREdNWUpUb3FvMzQx?=
 =?utf-8?B?eXRsZzloZU5FOVBqYUlmaXkwZ3dPdzhnYklramNzUU5oNnFycGFJZXZaQXJC?=
 =?utf-8?B?VkxhL1hmTk9yWE12Yk5FblRGcnZqZ2NmVHFYSzFqRGNHSm5IdW8ycXc4RFpt?=
 =?utf-8?B?ZExnYWVaczhNMlBxVWxXTlp0QjIrSm84UFlhWUczaXpzaTFZWCtJTXlvTkRs?=
 =?utf-8?B?VlZ0M3prMk5jdXEwU0hTcnVpQXJNU3lVRjlnbW5oNk5rNU1YQ0ZyNy9zb0RH?=
 =?utf-8?B?akJNUTlMdjdpV2FObUI2TFZQMDczcE5JUzVnenU4NGYxZUkyK3VrODFkOHhW?=
 =?utf-8?Q?rhPnQcbRGSwO6IoJTyPoxGz7p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4bedd2-17bf-41b0-3717-08dc32f29f82
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 15:34:42.0508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybmQo0h/yNeyWLC1FFQaUReqqCV0CVYvSbJ+Vh5fvwB/p07CdgAmjRJfN4ripoLao1FPPIAQxhxVuDbWkzg9+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578
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

On 2/21/2024 03:35, Ma Jun wrote:
> Don't set power state flag when system enter runtime suspend,
> or it may cause runtime resume failure issue.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Please add a fixes tag for 3a9626c816db901def438dc2513622e281186d39 when 
committing.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index f754e50e7b43..4f1a4435cee4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1531,6 +1531,9 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
>    */
>   void amdgpu_choose_low_power_state(struct amdgpu_device *adev)
>   {
> +	if (adev->in_runpm)
> +		return;
> +
>   	if (amdgpu_acpi_is_s0ix_active(adev))
>   		adev->in_s0ix = true;
>   	else if (amdgpu_acpi_is_s3_active(adev))

