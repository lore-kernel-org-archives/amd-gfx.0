Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB893C41535
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Dec 2023 07:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C66610E417;
	Tue, 19 Dec 2023 07:53:55 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D511210E417
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 07:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F739U9eu2zCw6F16kUho7BEo8ZT5rAPrtXi+cnas6YyyjzSg6OSgkwnaNbmNBpodnerxPDKBpJD3VXvD4zbwGkrPUCHBdGfp1oUcGEojtI2Nwu9UGDO3n2ZbGCs6/lCZgHcDP3aUM0CKMfWqDBdZgB41xUOIDBykygiQBZ0kBMWZf2ppJ58XOD5A5uIIsS34z/3PkFq6XuS26LJT7G3AGgNFO2KJQG69bY2Z7m519xh96qvcb8XcIhSRkGW2wXlnYmR3vgNTCvo657rSMDfhsNT9AJLS0HRem4NPxbelpld9KSqZr9IuDOAQO0M+bPokwwhedPBB7sTh7wCnUOAbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoIPQdpjlNkdpXwpJZS9+NarAcJIa2AjkrHpHMo/lMA=;
 b=ANXLHH8SOjdM4AiBc1qRcazDZysf/l7Uh0FK5tLigTwg3m+ndwIp52urcIdt5bEZdbwDf1e/3VHITm7ij7WuQ7Fwq7P3/OFOVgkDUxo6xQy3RBmurfIBEA1veFC7Eau08WbuesYUZewPVVPWsVYGPJHe0UUykkhCAak6xprx2vvpnhQlcGuRiW/JTCG0zug/OuOY5RVi2tQ1CLp1SRIGh7dW5OXV2l1aQzti2snEsEZMdfw4/Cn3g5LV4pRSmkRBO1tN9Q7f0GXgJ7iwcUPGSGfMNSFlCYw2Fw9KQQ9suSFFXa/knbu6IS0YjxfHIK/JLCKdIqBnxYl8n3u00Rf9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoIPQdpjlNkdpXwpJZS9+NarAcJIa2AjkrHpHMo/lMA=;
 b=rru1Tp88WBxmC2n8E8w5GFLK1mJQ5djN+g9G5RRXJllpjHrReuGak/Tv9k+vDlHCORWmOvd/UTz1zsnD17xEPKL3SVJvIbwiYCWQaAjz5O++sExYt+8jCaryUTnP5NMVg62B7KpA57zV47b8m1nOvCzKYW3zmB97YOegv77h7Lw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 07:53:51 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 07:53:51 +0000
Message-ID: <1671df5a-de83-4b55-8cf0-02669307f9f8@amd.com>
Date: Tue, 19 Dec 2023 08:53:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Let KFD sync with VM fences
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231218212111.565869-1-Felix.Kuehling@amd.com>
 <9f21761e-4b70-4149-abb0-9733c3962a33@amd.com>
In-Reply-To: <9f21761e-4b70-4149-abb0-9733c3962a33@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bbf8ca1-76a7-4f2f-76a6-08dc0067a3f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O2s6Hx0wVAyz//O4hhzElJQmLS0/Ar0c6B847Wono0t8xPtY/TUg15Xqjv2KQ1hCxaE2kiNjKVP4VrrOxdUFu+OFzQLDXqtaTuvpgZylSy4NO2wq2Jl0G6weOkiAcJnTJ4Yl4HaWbbHWtOOi/xkovSiv1b/kUA+Y4W4shnViPa0GWFf/NrYJtdrTqLOa569ntLV+CeciucxOl7O4+KQJLNYcCMRXOpiZ2oFyc7ADp5aOHWGXOJjxZjz5P7DxuMkhqPKKNl7z/vmmDqL6SH8D/5tT2qBdf1yqxzFnyy3cJ3FMsXd/O4N77EMk0RlGT3+GOdKI2CSzN7rxNYVDQyama7wxlo0q27fEtBHYp2LDoXm3mmU5bB6XMYHKs7bNHiesYiD5g8TrZcpvF6iXp57mPtm9jA9VxxQLGJo2zqIbkRJg8GP0u2wh+2Oh5Z+1aAxzmXLQYW/JSRmmDnxUEtSer6Wivg9l3MlENoFFsmibQFsbPTdmAwKFIPfzkmFXZLVarIo6Ey+RxtoS166aEMd+Yzj75bRgchqxQNuc7zSEk40M7W0cMTLjvyZAt0IwLRJ4gvd7av/iKkgAO4mcot7fC7m7xxWw8CC6nQ55IE8FRNGIHtM74iplYQz0FpZlxC9/5bKxaMOsw8qHBTtmVNvTkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(36756003)(316002)(83380400001)(66574015)(66946007)(66476007)(66556008)(2906002)(38100700002)(8936002)(8676002)(5660300002)(6666004)(6512007)(6506007)(31686004)(478600001)(6486002)(26005)(86362001)(2616005)(31696002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enlaMWtRNUlEYXgvKzJzUjVLSTBGUUlkQmU1SCtYbmdIMkRKVGl4ckhiS0x5?=
 =?utf-8?B?ckltaVdMZWNtMkkxL0t4R2wzdFE1ZC9RbFEycE12MW5hZ04vS3R3aVFpTmFR?=
 =?utf-8?B?dmx3TUNMN0ZpNGE5RjlWMm9BU051UGNJNmlRVURlbTBFNGJEbjFmb2dySDNM?=
 =?utf-8?B?bEh1RmVFUWhJc3Z6azFHVys0bXREbmpGNHpJZjErYjR0a3JFMGMyRGRZUkVi?=
 =?utf-8?B?bVpWSmdURzdtcE1ldVQ4aVpWUUJPVWZPcmQ0bmUvWTZxMHFOZzhGMGd0ZGM2?=
 =?utf-8?B?NkUvY1R1cjRydUxnMzZPZEduTFlPL0htaTYrNkU2N2xXMUtTMTAvMlh1L1B0?=
 =?utf-8?B?Mmh6SHY4MDdlVlJKU0VGbXVRWFN6NXd4RjVVYzRxaGhUUFBlR1lHakNxak9R?=
 =?utf-8?B?QzlMc0tJVE9PUXcwRERDZ1dEbEtRaFV4YXVpOGo2MzVPV1l3UkpORDlaY2ND?=
 =?utf-8?B?QlQydXdFVGNmcjhzOHJHd2U1TUFaaHozYSsyVHZaVjFvMkJhVWFqZGMyNURB?=
 =?utf-8?B?dHBGM0hXRWdUTGRKR1pWdmltdlpxbENuaXQxNlJiZ0JpNGo5eCthcUlKZkkx?=
 =?utf-8?B?UCt6Y1dEb2JYR2cvUDlLU0lybWlKTVB5dGNaQWEvbXVnMzlCRThSVU8yVk94?=
 =?utf-8?B?Zzc5YmhqazdCTzk3MDJiaWtVZG1GNnA5bnZiRlJYVXVhVUhTSWZMUXZkZHhF?=
 =?utf-8?B?UWpGbmtqZWtvUitRSFdGemhjaEQ1a2tRN01YaTVRaGFFNy9CU1lldXFEQUhN?=
 =?utf-8?B?L08yemhsOHF1WC9DMTVEWlR1S1I1ZWM2S0UzUDhJYmIrSy9qaFlQTEFEb2JD?=
 =?utf-8?B?TE84dUJuR3AwdnJ4cFkrMlg1OW5UUCtQZURDM05kUWRqbFR3c1pGL1l1WUhZ?=
 =?utf-8?B?L1Iyak1MNGt6QlFyKzdldUZsa2s1VUNMYmUzeDlIQmwxd1pFK1N0Qm1EWkgz?=
 =?utf-8?B?VkMwS1RiNUJHcG5HaWpkVG8yNTdpTk9UdkVEa2lzTXhTWkl3WjMwUGVnY1ZG?=
 =?utf-8?B?UExha1lTcURyMlNSZ21taWFMTDZoNnpKRERhR01DOTZibHg0cHUzM2JHanY0?=
 =?utf-8?B?Z3p4b3ZXR0hRYWsxZzhJVWFnc284dzYwUFpRekFDdjBaMzFwdU9nbW4ycE5T?=
 =?utf-8?B?YllJaTRxbXV5QnVqaWFUMHZGODNNREF3K1AvdGx3aUo3dkNacDZPM0R3VGtE?=
 =?utf-8?B?emxKMmR3QUsrWlNHaWs0YVBseHc3VFZzUVdwSjVLNHNsVFA1K2EvdzRBMW4x?=
 =?utf-8?B?ZVVoUTMxSmFnbXdReDZIYk4xOGdOUHpPZHN2bHFWMEdXSFh4NkVKM1BYa1FC?=
 =?utf-8?B?U1RLdVJvd2NKcTlwVllQbzNabjRnbGE5R0dOVDkzMS81QXk1em1TMUVIbGRz?=
 =?utf-8?B?TWVqNGtZK3lTNVhLbGxhU01rVEI1Qk5XaXFIQ0xWNnpieWJvR09JdEJwdFdB?=
 =?utf-8?B?eXZTYnVBbHhod21zaUhYak5uYjRnOEFBcVY5aXhRYlBNUFhoemJ4eG1xUllP?=
 =?utf-8?B?bE8rTjhJeE5sLzlIWk9WR2FzYk5PdG11Y1M4ZDJ6clNzQnIvY1B2UW9FaGlV?=
 =?utf-8?B?YTN4UjcySHVxRnVVV1M5SHVaUU9tSENheFRha1FOQUtLNGtGK1FQYTJLejNi?=
 =?utf-8?B?ZnN0ZUljbzNvRFFmSjZSNzJNMXgvU2lpWXU0cGdObmZUUlFMTFpLd1J2cVQ5?=
 =?utf-8?B?TG0wWEw3eHZQWkZzd1dKb2M5MW9MTjJ2RVJOWnBmMmFUSDlFWW1IcThtbHlw?=
 =?utf-8?B?MEsrUVJiWHNld2N2M1hDaGJEcjFqOStKOW52Y09zbE9KaDJpMmZKbEVScDRR?=
 =?utf-8?B?R1hkbGpid0c4Tmx5a013TEF0dktyWSszSkREWDhyRWRPSDllNVJjSW04ZEJP?=
 =?utf-8?B?ZXVPdUJ5L0dmS24vZ21NOG9LOWptVHJSVW5LaDF3VGF1anp4OFVQMlgxQmZm?=
 =?utf-8?B?ZE9EYVFBUEpZMmg4ZXdlNEtxTjFvSCs1TnVmSGJONko3OFFpL2xWOVhGT1lz?=
 =?utf-8?B?S2Uxa21QL1pXWXRRREh3VUhZTkpUVmRkRE1keVBvVWFKalR4V1U5OGtoTStY?=
 =?utf-8?B?TzVBTWNORnJUbzdsY0NVYkc4NTRjY0d5cWh5aHBjazNNRnpNblVyYUVFTVZ5?=
 =?utf-8?Q?D1XGMISyASvOx2QdbAGIZXeFP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbf8ca1-76a7-4f2f-76a6-08dc0067a3f6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 07:53:51.3977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzNuIldnjrLogbqtlyxD4runYpuEQNQ79y3D7P+ukB5sacLjg5a4WZGCUDeyEOPb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836
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

Am 19.12.23 um 08:51 schrieb Christian König:
> Am 18.12.23 um 22:21 schrieb Felix Kuehling:
>> Change the rules for amdgpu_sync_resv to let KFD synchronize with VM
>> fences on page table reservations. This fixes intermittent memory
>> corruption after evictions when using amdgpu_vm_handle_moved to update
>> page tables for VM mappings managed through render nodes.
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> Reviewed-by: Christian König <christian.koenig@amd.com>

In the long term we should probably handle this by changing how VM 
fences are added to the resv object.

Implicit fences should be added with DMA_RESV_USAGE_KERNEL and explicit 
updates with DMA_RESV_USAGE_BOOKKEEP.

Regards,
Christian.

>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> index dcd8c066bc1f..1b013a44ca99 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> @@ -191,7 +191,8 @@ static bool amdgpu_sync_test_fence(struct 
>> amdgpu_device *adev,
>>         /* Never sync to VM updates either. */
>>       if (fence_owner == AMDGPU_FENCE_OWNER_VM &&
>> -        owner != AMDGPU_FENCE_OWNER_UNDEFINED)
>> +        owner != AMDGPU_FENCE_OWNER_UNDEFINED &&
>> +        owner != AMDGPU_FENCE_OWNER_KFD)
>>           return false;
>>         /* Ignore fences depending on the sync mode */
>

