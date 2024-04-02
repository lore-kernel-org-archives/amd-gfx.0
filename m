Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92CECD1284
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 09:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C6EB10FBC1;
	Tue,  2 Apr 2024 09:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zg4h7UtL";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2117.outbound.protection.outlook.com [40.107.212.117])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6DF110FBC1
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 09:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql8AisYSJDia/TWxLCDUzlEaZcD9Dvjuu3qHadj2yRoWnuSHLVR55G4p51RHnqao1BzW1CZw1DFm0V7l0bUjxiyp1RG4QSWKGQusBGSCPDQu5WhP19ZfTDS7OmMeToThXapquGzlU+t5VFKXG19RWWlb3hexa9zgXjQ6W1bqMu4+P1IKrY0DhBMMxOuH0S3pkECIOsZ2aNZv6YSH3RzOrCryRGAAftlzN8OB44OjFcA6Uxb4wxBzn72nQBYlKeU6C/1lwiAH8fewerUMggza4WcIAXW4gzbUEA8ZvgGahTVD8XriZXu0NlnMKvyAKDQOpRrHRz5/OSWSZ8HnETgHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTapF/AaHnQ5ni2ajL/8FCGnmmndgLkpjqodZs3MWkc=;
 b=fQgy7PR0KDi/qxU/5Kx1IdMmJMm8k2nNYA8qgg7aEM1qLdo440MhfRy1YFst2VGF63I5us+ntQCX33Ix+ibMHBq9aY9kWMyIkk2fBbDvCtrOaC3cvdbkngZWBBr1RbBXuj3/zMSBl4/j/EJ03EGmjjoWj5dr4gW+2s5wxStAf9DAK716Hdwjk8WgqbamqHryaI5F6uB39FPhX1m7+OoAi0Qd3YjqtwGRe2p7xbSXSrkDoyBB8MLxp1QLRgrHk3qMBbo6BdRQvG+qRJejnVIJxoO0nfEhaT7XkwCbUk8ZwVkg+MPyGrWhEulRS59gYsqW64FVwwePLWbZ4Q1HFNYFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTapF/AaHnQ5ni2ajL/8FCGnmmndgLkpjqodZs3MWkc=;
 b=zg4h7UtLyTmyTAwi4naitkJ1XIlef9nU3nUPxtUNoXR82aE/tU/OH2F/KAhLlNl3oYV/lDcB+LvRSKA3BWyECjNSreHGZi8AyJrZQxt0midVDeLFDQUqzC7lFv2vmoNczPmI1b/JhCpOU56UZ5DpboR/c2eJuB00RcT6OnCK02Q=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Tue, 2 Apr 2024 09:48:30 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 09:48:30 +0000
Message-ID: <333764ae-504e-4f16-8f45-cfe0da460775@amd.com>
Date: Tue, 2 Apr 2024 17:48:24 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com
Subject: Re: [PATCH] drm/amdgpu: Fix discovery initialization failure during
 pci rescan
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Alexander.Deucher@amd.com
References: <20240401101847.3113771-1-Jun.Ma2@amd.com>
 <bc206c92-ee28-4438-bc2b-06e33096a28a@gmail.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <bc206c92-ee28-4438-bc2b-06e33096a28a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0105.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::21) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|CY8PR12MB8364:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rlbb3t8pvpcpjm8aN41OUkkyAfixl2mRnQChNVTd/260JY+vxxCabqPQOM8xIZlj+Er4yBzlgo/wuA6WxV/fMs97pBXjZ3bJ3HDkH+XjO21KNH2Pk7AIN9kXepI/tRVVeZAt1aoT0d4vuhyO7WZDTDGkfEZpkaVrgXTuaurmucakryAyiXQvpPUw05H818E8jMZmBy9fDvc2Q2baJnAvoi4AbY8j+s2WsZZauPGsrnX/vBMTnYlw235HVpCQ8XPuOtowcM2eDlnoakp0uL/SXem0gw1eWNWfz4qSFjr1y9Hyl8WJv6ygiJoAsp6X2PVmBhS5pEla5zgxQltjE/MwnHHKymrvnBwXnVB2y3xYv3ZZJAiBWXp83EwedcJCg8wl5jkl7SqtCxysUVIFgY6YztVbZimM7U7AM1Jx7W2jX8RODCIFewSaQGPw7VIJPj5m2AfiOl8rBudJKthx4TIsJyNm/9UhOqJ9h4K4lx3D3feYQZ88nausNZP6M+rhfBUqQ05cf0lvv5Zp63GmGRMtT2BhqbWJBmkda93g1jZmy5zqpXlMSEFHmrp4LpSxBDkRItHKqaMkOSLPz2JIu9AUrfQtbd/exnoGvpV/v8/oNO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z01sVm0veUVWdVlFcDdldzJQbFNhdVVZZXRvaXp2N2NkaWhZd2RUVU5NSVVw?=
 =?utf-8?B?SThhUFM0bDRreC9Gb3M5TWthbWt6Q2ZHRjNKbWxNQzFkNm9KNDNCZUFZNWRU?=
 =?utf-8?B?RVI3djZqQjVJQ3M0NWt6VTI2MmdTaW5GM1AxdThLZHVSalY2VFJUU2pFTGFX?=
 =?utf-8?B?T05Od3FtZHYwMXVLN1krcytSc0dKVkNETTNVYjR0T2tNSzFxWU1IdFYyL3Qr?=
 =?utf-8?B?VDZxdk9wcllJUC9tU0I0dG1KYzJXN3VrSXlNamxiV2RqQU4rMlNQd28xSWcv?=
 =?utf-8?B?SnFwd3UvU2ZYdzhEd2s5MjBFZXFzS1lxaGs2eVNaYTVKVWhrTSs5eUUrVjZS?=
 =?utf-8?B?RE9mRDQyY3h5Zy81b2ZwRC9HUlpIc0dOSFFLdDZZZlJLd0JwL3NtenZhWDhE?=
 =?utf-8?B?RkdsdWFUekpMMjFZWEdwRTVLcjhvQVZHWDhmQkNRL2drTC9nQUE1SDhYblBn?=
 =?utf-8?B?aVBobVRaTlBFWDgwL3NncGIrMHRjdDRjckoxV1N2M1p3dkdDMCtTRGV6UW5l?=
 =?utf-8?B?UVBRekZzTWpsMS9QR3RGMGZnZmttLzcrRFR6aWNtWkY3NWhxOVgzd2liOWxr?=
 =?utf-8?B?R2pmcVZVUWZTQ2IzWHhCTExYdVlpdzFqY0pmemloZDZNVEFKSUdsU3FNQlJW?=
 =?utf-8?B?aXNnT29QWEYyWVlzQlZiUFZtdGx3YWd0dFREdnl6YlJ3Vk1TMmRnSnlGb1dp?=
 =?utf-8?B?Q05qQ3FrSldQa3JIS3Jya3pJbFVTeDNoMWhVejQ4T2pIeE1zUDg2MWdLQVdu?=
 =?utf-8?B?R1JTSVhTZjFzRlJvZjM5d1BiRUE5M21sYThKTTRmb3l5TXBCdmRtemVYS2kz?=
 =?utf-8?B?TXc1aXFwcmh4YkpJNVVxQVZYZ0t6YnF0b2UrTWtzS1UyL2NOMzU3c3pTV3VP?=
 =?utf-8?B?NzJmRHdha1dlUGp6ZWpySlMxSEZ6YXVnUWt1T1h0SUlTOHBSS21jNllYYWhp?=
 =?utf-8?B?MFdVcTRRMWZLc2J2YWc1MlFXMERIajJtVGM0elAvYTZOMFkrQ0M5anJJTnlU?=
 =?utf-8?B?dm52WGk0OXYwUmhmZ1JLYmJJV1NDeStabXVKTVMzQldhdzdLZC9CdmFqUnRU?=
 =?utf-8?B?ZXdFa3VpdjhiUVg1TmdwSzlMWXptRUtZYkQveG4zNCtqUWZadjNDcW9HQmxy?=
 =?utf-8?B?elV0VExlS1YxTVczUUdsR3hhRTBXUndlcDY1Qkp0cEN3UHFtOGlQclo0SlJr?=
 =?utf-8?B?N0JnTEFOZ3p5UkdQYWl6SnZMRUFYRkFMWWtacXpVeXVrZUlKaG9LQy85a1FE?=
 =?utf-8?B?dVAveDVkT2wzdzMrRVhWc0wxR3ROSDhhSjJqenBZbFhXNDVERklGTEtOcktC?=
 =?utf-8?B?YlVSUEx3VkI4R1NUVVZ4blhwTFd6Q0R3akMvVlhOV1F1bWlSNlAxcDVWdDR1?=
 =?utf-8?B?RzlWdW1yd1Q1TGU5eFhCWGd0ckFXN3Z4cnFuNzZrRjE4bnhyRWNLOFRERDQy?=
 =?utf-8?B?SjV5T0tRcCthZEZlK2c1NTY3WTJQQjdoeFNPd1M5ak5aL2hlYVJDK0NpRmM3?=
 =?utf-8?B?ZmlSM0VTanQrV2tucjhUZ0dnYXd5Nld0dTdJbUtaZUM0VUlpbU1IMkpabStJ?=
 =?utf-8?B?cFg2eVRVS2o1RENHRDJSY3dFWmQvcitudHBneFlObW8zQTFYNFAvM3l0KzBC?=
 =?utf-8?B?K3htMkJmNmY2bnd6SUs2S25GWjNadFBtNk9wWml2NVB4Ung3NG1WRzNsZzNv?=
 =?utf-8?B?RDg2L1VaZkdoVG9TOFgzV2phKzk5YTlpclIrNm5IOWxuRGNJdFNxU29yVGMz?=
 =?utf-8?B?SVI5S1RjKzJXa21uWElkaUJoSHBFdzEwRVUzYzNCU2VFMGlHaHdML2VVQW14?=
 =?utf-8?B?eE9BM1ZmaUdOeURWYkR4M1pQSDMxcTR2d2FFTjFiMFZiR1U2Z3IvelUzc1Jk?=
 =?utf-8?B?ODRYR2JtVmJnUmdRM2NzcVc4VytPNS9QVXJENTdTUlBHVzB3UG5LNVNSNFh0?=
 =?utf-8?B?djl6OHprTy9FeFhNa0tOcHRsN0UvUTJTMkdQQ3kzYVpuRjFXWkpnNVBORzk1?=
 =?utf-8?B?czhQV21kNStIYzBrU1BaSzlPTzNyVEJzR1ZvVkNncHA2QzFqME5ucXAyU1NM?=
 =?utf-8?B?WTQycjFQcDV0SU51bU1oVUJjNWcyRnJ3a3VVQ2E1aHVST1JQUmpVbUc0KzRU?=
 =?utf-8?Q?HOrnX4a0ArdobHRTTZ6nEz4sr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b504f7ae-8620-46e0-5830-08dc52fa0da7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 09:48:30.6787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UgCQm+khpdam4wPcVqbg/8k4w95Qkg1WNHEzd8S6kU/fz3iEsvXIMYaQqaA0nSjk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364
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



On 4/1/2024 8:24 PM, Christian König wrote:
> Am 01.04.24 um 12:18 schrieb Ma Jun:
>> Waiting for system ready to fix the discovery initialization
>> failure issue. This failure usually occurs when dGPU is
>> removed and then rescanned via command line.
>> It's caused by following two errors:
>> [1] vram size is 0
>> [2] wrong binary signature
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index 07c5fca06178..ac6b2ae6414c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -276,7 +276,12 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
>>   			msleep(1);
>>   		}
>>   	}
>> -	vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
>> +	for (i = 0; i < 100; i++) {
>> +		vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
>> +		if (vram_size)
>> +			break;
>> +		usleep_range(1000, 1100);
>> +	}
> 
> Nice that we come closer to a solution for this, but that here is really 
> hacky.
> 
> Do we have any idea why mmRCC_CONFIG_MEMSIZE is zero when we re-scan? Is 
> some initialization not completed yet or something like that.
> 
I just found there is a patch related to my issue.
https://lore.kernel.org/all/20240306174446.2042884-1-alexander.deucher@amd.com/

But I think it should not be limited to removable devices or devices with
discovery_version=2 and 4. 
I will submit v2 based on this patch.

Regards,
Ma Jun

> Regards,
> Christian.
> 
>>   
>>   	if (vram_size) {
>>   		uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
>> @@ -371,6 +376,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>>   {
>>   	struct table_info *info;
>>   	struct binary_header *bhdr;
>> +	int error_count = 0;
>>   	uint16_t offset;
>>   	uint16_t size;
>>   	uint16_t checksum;
>> @@ -380,7 +386,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>>   	adev->mman.discovery_bin = kzalloc(adev->mman.discovery_tmr_size, GFP_KERNEL);
>>   	if (!adev->mman.discovery_bin)
>>   		return -ENOMEM;
>> -
>> +retry:
>>   	/* Read from file if it is the preferred option */
>>   	if (amdgpu_discovery == 2) {
>>   		dev_info(adev->dev, "use ip discovery information from file");
>> @@ -401,6 +407,10 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>>   
>>   	/* check the ip discovery binary signature */
>>   	if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
>> +		if (error_count++ < 1) {
>> +			msleep(100);
>> +			goto retry;
>> +		}
>>   		dev_err(adev->dev,
>>   			"get invalid ip discovery binary signature\n");
>>   		r = -EINVAL;
>> @@ -515,7 +525,6 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>>   	if (0 && offset) {
>>   		struct mall_info_header *mhdr =
>>   			(struct mall_info_header *)(adev->mman.discovery_bin + offset);
>> -
>>   		if (le32_to_cpu(mhdr->table_id) != MALL_INFO_TABLE_ID) {
>>   			dev_err(adev->dev, "invalid ip discovery mall table id\n");
>>   			r = -EINVAL;
> 
