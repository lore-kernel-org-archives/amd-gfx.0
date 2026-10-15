Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957DCCC6B30
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 02:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA19112061;
	Thu, 15 Oct 2026 02:53:04 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013041.outbound.protection.outlook.com
 [40.107.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3005210EB67
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 02:52:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZKThTD4x31mfyO8fHoLQCqf1yxHa/Ugmw7YjjLBxuy+d0YHlg37I2i4vatew6R9JNhDxG0AAS1II2nSUW7BM3cUeNA+OuDfY5A3B6H5EJm3LtAmXB1AlzG0pTNKLy2fP4WPOsR44wwS80Q5uWhKfjfwG8J/80FiWVxU18COlDaAvdnD+OpOMne7Kk6qWHVWgjxxCP4tdvcdh/Z17NHb7fYdhxilA6G1xDvtMW9ejWgCpnFYxcCU1U1U1S1fsdOqth6XyUypc/Ogwek2G+0A9K1bWU18CRQKmCozRHxONZIKxgnraFzQJq1prSzeFmV+HyGMJl9orGmig7L+SGgtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZ3Z2GEcKy3pbEBdKUskHNL9vGyKq/3PDMtvE1L4qe8=;
 b=CqsBAUYZ3auzUtKGny/qACs7ZWwr8BnXX/0ouX9ap1/GKb9gbR1t7sE4WHuVR+BjL0eHCUy6g1yg5X128k5CR7pKqHGQC6QqVcErPtewn08ZyNHFt0Ae3kUp9tiowWXf+RaT/kKflw2cAlmc0JODhzAWXDMt0FA3jAuvRv86nYd+USid0qImr+lU2mk9VhAReDJluYcQKljUMIwzVnI5vhvOTeWIcsQm1VLmpn0rfxSQyXhp5cfQUM/tylj9NOiwfda1u5hICQJ+DXr46vv3OHBtLb1+viyB9LvzvAilleLy+oPNGv9p/Y9Cc/koEGEQZS8AYmpsXML0fDhZIT7PYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZ3Z2GEcKy3pbEBdKUskHNL9vGyKq/3PDMtvE1L4qe8=;
 b=GI59rh9iDn4r2f3Q4d90eZnOwoWfSMpIVxRb+lMD2b22wCXJ4ZC5s186bfTyWNETf2Ouody0OsFQh62uRVdJx7TjlKH1/jd6uDdtLI+POCa9SggzbR2Ayz1hlOBnFHIyBNp9ZDAXcbmNXruNz2qZBlu202naVjrh1N1YCpinJYY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 02:52:53 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 02:52:53 +0000
Message-ID: <b6c30a27-4f8a-4c84-b227-0c54e5bf39b6@amd.com>
Date: Wed, 14 Oct 2026 21:52:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: prefer exact bus match when selecting VFCT
 VBIOS image
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Reza Nikzad Chaleshori <rezanikzadch@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Min, Frank" <Frank.Min@amd.com>,
 "Luo, Zhigang" <Zhigang.Luo@amd.com>,
 "Wang, YuBiao (Ethan)" <YuBiao.Wang@amd.com>,
 Oz Tiram <oz@shift-computing.de>
References: <20261014080523.186533-1-rezanikzadch@gmail.com>
 <BN9PR12MB51465FA6B74D63574BA3CCB6F79D2@BN9PR12MB5146.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <BN9PR12MB51465FA6B74D63574BA3CCB6F79D2@BN9PR12MB5146.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS3P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:45f::10) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff8a078-9f1c-4e32-bbcd-08df2a67689b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LZ0M7RBBcdGjZ1t5VPVAZaGoNDH8uiYMF4rbjAB853OkwxAhhAACHjB1Ow12kzVpU32f6RL9olyYIySoal2atEL1/bFCc/cN8GR37M8wgx6pEafk8XD1v9DII6T93GjzmjSqBZSI+riJIPAogKCRgQDDR6/+kupzbFRCTmKK9J0v0vvJgTRhalfy4okaqgwIgogFIS2TAr36qEgkwfVwBqByOz1RM+CUY94wlaTADNRHooyHHBVgBdpSrHCmXf9s6xDx7IKlaVYHIe0L3pZWmvNuAZsDJRK39CRm/Ytol1/t0UuJq7iIwiqVOgebDVHahi+M9Qhw9e5TyuwKzoA4zuX7s7eWxGLs78SMs5p11aySCWNbS3XfFqQDuf9E0xSyJKJkZt1bJbwg7+sI6toUYafDNwtOEzzPRlm0HNyoo88akoCP0q2v3a5Wmn5OgT4UeHX57Tx+1iBj7CmMRCMfF24Q5LaLBhgEXaCscGF83HRvjOx/MViqe5ArA1BMa+l/37TK6h/kGIZV2hMisreOqFeNfBfSj9CtmLw55xDY1WUy5j/6u9KGxRWTt7rncJnsNTh1qXig+5BmF+OuAS6E3MENcOziWFgmIDNnmUtloZMzUUrBOR7GShOSzOFw0+I0PciC9aC1Kb0uGarKSDwxPzQuz5uApa0zDjSCAham+dA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzhyV2JKWlYraFpkVit0RGp5R0pMN0xLVis1T2hNZHVGbHJva3RiTFBxcWsz?=
 =?utf-8?B?ZDZLV0U5UzNHbGtRNThrcUJ2MDR6ZmdneHljS25xWTNsR0ExSWIyVUFoK0pN?=
 =?utf-8?B?TWV2dTE4OS9KWVVIclJ6d0JMRitRNm93TVpoVFRqT0ZXMFpZTmlBWHRHYW9G?=
 =?utf-8?B?cmFteEw5TW5tV3YvZHFXcDQ3TVZLNCtUN281K05rVlUvekpEZWVjeTNTVWdD?=
 =?utf-8?B?d2YzRHVYcXAxSW9veUo1VE1vQmlSRktabDZjb3EyTlBuZWltMUhzWWpaN3Ft?=
 =?utf-8?B?TEticHJINDdzNHlWVGlmb2xOaCtnOEN3WU5PWXU5QTgydGJueVZYalFhbnpP?=
 =?utf-8?B?SDc1bzZkMXA1czJKSFpvSkpXQWJzTElEM1ZJVnRPdWhsNzNKd2hRcFhEUS94?=
 =?utf-8?B?d0xVbDZOVmVsZ2cvL0dHK2NpRUk3QVBYWnhWVnZGZ3c2T1BVUW1IMjh2ZEhm?=
 =?utf-8?B?K2kyR0krVFI5WkxKYldEVU0vejdlYlJFZWl1R1dWQnE3Sm05VnVORDF3dCtU?=
 =?utf-8?B?K1p6ZGkzenBlWnlQeUtJTVZoYXFKY0U3RDBPMmozRkNzZzc4Vkxha095WTdI?=
 =?utf-8?B?U0tac2FlSytzQituL0JtQnlFQWM1UWkyTkhVd0pZQzV3MjNDY0tyVjAzeTcz?=
 =?utf-8?B?SGlvOHBWZ2lRV0VaZDZoVmFHeE4xQ3M0eTZibVdvd1JQVHNpelRubWlWVFJ6?=
 =?utf-8?B?dldjUjFQTitsY1BGcC85QTB6K21pb2R0VGJJNjVrYnZiQ3llSUdZb3JPWXVn?=
 =?utf-8?B?Z1FyZ3k5aDZUTkk2cG05eEhENmdna2xOWHRtc0kwRzdyZ3ZmWXJLMG9lb2k5?=
 =?utf-8?B?SGFqcHoybWNTWHEvZDZzZTE0My80bXZkZS9waXVqTVd3R0FINTAybWlmck84?=
 =?utf-8?B?MFBBclBPSEdzd0t5QTJobThxR2pCT1JkdDU4cDFCaXhWZzhEb2M0bTNIcSt4?=
 =?utf-8?B?ay9LYjhZNytHWlU4ZWk3RmVZUXZBZ1ZOQkxjQVVjdm02S1ZhanpOWk9zekpW?=
 =?utf-8?B?UTcrRERYVlRXMVBENUxxaTNCZ2pPdGhuYVVDUTdIZUExdXNyT1I5eE5FVDZY?=
 =?utf-8?B?cHE1end6OFptdzVjdk9TUUJZaGxMNGlEMS92SitDWStFcmxnZStDWW9kdVJY?=
 =?utf-8?B?TDZoeXNjZkFPUkJuY25DYndtMGRZZ254TWc4ZWkxeTlScGpkZXBxL0dQZFY0?=
 =?utf-8?B?VGRMK0dIc3A2eXpWSmVuS3lvRnhYSzJWT1FRM21PbDIza1R6SkkrSzFjMW16?=
 =?utf-8?B?a2tXZzExd3VvTnVSUHBKSEZkQytPRTZHenNwZ09rK3NYYkxPN01RYzRlaCtW?=
 =?utf-8?B?MWZhU1VQdVhuSjV4L1ZZVjFaZThueTFhMXFMZGNtaThrOVZzdWEwVFNua1BO?=
 =?utf-8?B?SEUySlNWNnV6MlRsQkliTFRaVHpteUsxaEFodGpGZ3crK3g1TkltbGV3dkRq?=
 =?utf-8?B?TXNYOEJsSnQ0Z2JWZEl3ODZZWXp6VXBmaVNScFVUbm05N3hXNXdLMkV6NkR4?=
 =?utf-8?B?a3BKVXo4NjA5TS9GaWJ6aVlRWlEzSCtRbmI0Tkd0K0xhbTdsTjNmS3VaeWts?=
 =?utf-8?B?U09aa1VxckJXRTNUMFJzcFR2UkRqTlN1bGp4TWpqTS8wU2pBeXhWbFNOM1l2?=
 =?utf-8?B?MDdYeWlBSEZRcVJGSTJSVHlFK1JwV2NyRGxUM2FMTkVxYW1kUGFjMmZGZkww?=
 =?utf-8?B?ejV1eUEyYWhaR29yazN2UWNack5xSm5ETHY5alRPc0hIU1JNc3N2VjZQN3Fj?=
 =?utf-8?B?b0ZpUDU2VTZSck5LbWd5ekJwV2ZnTWEyNnAvWU8yYXRhU0cvU3Q2ckJYbVhJ?=
 =?utf-8?B?eEdPcE9haEszdXlQK1Q3M09NWXluWWpzczF0L05xMVhWYUhDc1NvVlFnYnM1?=
 =?utf-8?B?V2t2cUpzY1UrZ04rVmRIRWpzRWdtcXZYUHY5ME8yUXhEbkZxRkJQQnN2U2RF?=
 =?utf-8?B?cndkYnFmaUw4M2E5QkUrWnBaV1FwS0U5dEk1U2JMOVQ0WEdsSHdLYjZHN0lX?=
 =?utf-8?B?UGZvNHVNc016MmF4MnNsT0lZZ3QxN0tRRVg3VmZCeVVMdkVPQkZxWnVES3BG?=
 =?utf-8?B?Ukc0WGtYOU5scytUaEFMMVF1SU15Z0x3My92N28yM1ZuSUxwY3UvMUpkSDA2?=
 =?utf-8?B?UVU2VDZUSjBUaU9jOU1jNElKMGpNT08wWGw2YzJpdUpyeTY1anFSQWZ3aUdo?=
 =?utf-8?B?aE1NY25rRm4rNzNkZlIyemNNYW5PdGJtdENWM2t1NjlRVy9HTGNObjNVR3dP?=
 =?utf-8?B?ZlE1YW1rMytYdkoyNEJDYUNtakRiTjd3aHN5WXdEUzZra0h2ZlgrVHY5VE9a?=
 =?utf-8?B?MG1SMXVQQ0h4UkliNDQ1OWxjV0Y0SlFtRy91NmZKNXF1MFkwd09QQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff8a078-9f1c-4e32-bbcd-08df2a67689b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 02:52:53.6747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1otS/5krz/l+9GWKL4gA+cNeQ+53qZB/J1XOFx51I/OiNw+i9/Q8VQ9+5N1DQSmFBgBi3FqhD0RkPR8EFhOKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924
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

+ Oz Tiram

On 10/14/26 17:19, Deucher, Alexander wrote:
> Public
> 
> + Mario
> 
>> -----Original Message-----
>> From: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
>> Sent: Wednesday, October 14, 2026 4:05 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona
>> Vetter <simona@ffwll.ch>; Zhang, Hawking <Hawking.Zhang@amd.com>;
>> Min, Frank <Frank.Min@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>;
>> Wang, YuBiao (Ethan) <YuBiao.Wang@amd.com>
>> Subject: [PATCH] drm/amdgpu: prefer exact bus match when selecting VFCT
>> VBIOS image
>>
>> amdgpu_acpi_vfct_match() accepts an entry whose bus number differs from
>> the runtime bus number as long as vendor, device, slot and function match.
>> The caller takes the first entry that matches and stops.
>>
>> On systems with several GPUs of the same model (e.g. mining boards) every
>> card matches every entry on vendor/device/function, so an earlier entry is
>> selected for a later card even when the table contains an entry with the exact
>> bus number. The later card then runs with another board's VBIOS (different
>> power/clock/memory tables) and can fail to initialize, for example with "UVD
>> not responding" and a fatal error during GPU init.
>>
>> Search the table first for an exact bus match, and only if none exists fall back to
>> matching by device identity.
>>
>> Reproduced with two RX 580 (Polaris10, 1002:67df) from different vendors
>> on an ASUS B250 mining board: VFCT holds entries for bus 1 and bus 12, the
>> card at bus 12 was given the bus 1 image.
>>
>> Signed-off-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
> 
> I think I'd prefer to just revert the change the loosened the mapping.  The loosening was done to fix when someone sets pci=realloc on the kernel command line.  I'd consider that to be more of a corner case and presumably even that would potentially break on a system like yours anyway.
> 
> Alex

Oz,

Just to double check, it was pci=realloc that caused the issue right?  I 
seem to think so.

Another way we could do this is to only do the soft match when 
pci=realloc was set on kernel command line.  I think that would help 
both cases.

> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 71 +++++++++++++++-----
>> ----
>>   1 file changed, 46 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> index f9315e047..d42485e6b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> @@ -441,10 +441,15 @@ static bool amdgpu_read_disabled_bios(struct
>> amdgpu_device *adev)
>>    * the bus numbers disagree we accept the entry if the device identity
>>    * matches.
>>    *
>> + * @exact: if true, only an exact bus number match is accepted.  The
>> + caller
>> + * first searches the whole table with @exact set, and only retries
>> + with it
>> + * cleared when no entry matched exactly, so that an earlier entry for
>> + an
>> + * identical card on a different bus cannot shadow the correct one.
>> + *
>>    * Returns: 0 on match, -ENODEV on no match
>>    */
>>   static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>> -                               VFCT_IMAGE_HEADER *vhdr)
>> +                               VFCT_IMAGE_HEADER *vhdr, bool exact)
>>   {
>>        /* Vendor and device IDs must always match */
>>        if (vhdr->VendorID != adev->pdev->vendor || @@ -459,6 +464,9 @@
>> static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>>        if (vhdr->PCIBus == adev->pdev->bus->number)
>>                return 0;
>>
>> +     if (exact)
>> +             return -ENODEV;
>> +
>>        /* Bus mismatch but device identity matches (PCI renumbering case)
>> */
>>        dev_notice(adev->dev,
>>                   "VFCT bus number mismatch: table %u != runtime %u,
>> matching by device identity (vendor 0x%04x device 0x%04x)\n", @@ -474,6
>> +482,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
>>        UEFI_ACPI_VFCT *vfct;
>>        unsigned int offset;
>>        bool r = false;
>> +     bool exact;
>>
>>        if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
>>                return false;
>> @@ -484,38 +493,50 @@ static bool amdgpu_acpi_vfct_bios(struct
>> amdgpu_device *adev)
>>        }
>>
>>        vfct = (UEFI_ACPI_VFCT *)hdr;
>> -     offset = vfct->VBIOSImageOffset;
>>
>> -     while (offset < tbl_size) {
>> -             GOP_VBIOS_CONTENT *vbios = (GOP_VBIOS_CONTENT
>> *)((char *)hdr + offset);
>> -             VFCT_IMAGE_HEADER *vhdr = &vbios->VbiosHeader;
>> +     /*
>> +      * Pass 1 looks for an entry whose bus number matches exactly.  Only
>> if
>> +      * there is none does pass 2 accept an entry that matches by device
>> +      * identity alone.  Without this, on a system with several identical
>> +      * GPUs an earlier entry would be picked for a later card.
>> +      */
>> +     for (exact = true; ; exact = false) {
>> +             offset = vfct->VBIOSImageOffset;
>>
>> -             offset += sizeof(VFCT_IMAGE_HEADER);
>> -             if (offset > tbl_size) {
>> -                     dev_info(adev->dev, "ACPI VFCT image header
>> truncated,skipping\n");
>> -                     goto out;
>> -             }
>> +             while (offset < tbl_size) {
>> +                     GOP_VBIOS_CONTENT *vbios =
>> (GOP_VBIOS_CONTENT *)((char *)hdr + offset);
>> +                     VFCT_IMAGE_HEADER *vhdr = &vbios->VbiosHeader;
>>
>> -             offset += vhdr->ImageLength;
>> -             if (offset > tbl_size) {
>> -                     dev_info(adev->dev, "ACPI VFCT image
>> truncated,skipping\n");
>> -                     goto out;
>> -             }
>> +                     offset += sizeof(VFCT_IMAGE_HEADER);
>> +                     if (offset > tbl_size) {
>> +                             dev_info(adev->dev, "ACPI VFCT image
>> header truncated,skipping\n");
>> +                             goto out;
>> +                     }
>>
>> -             if (vhdr->ImageLength &&
>> -                 !amdgpu_acpi_vfct_match(adev, vhdr)) {
>> -                     adev->bios = kmemdup(&vbios->VbiosContent,
>> -                                          vhdr->ImageLength,
>> -                                          GFP_KERNEL);
>> +                     offset += vhdr->ImageLength;
>> +                     if (offset > tbl_size) {
>> +                             dev_info(adev->dev, "ACPI VFCT image
>> truncated,skipping\n");
>> +                             goto out;
>> +                     }
>>
>> -                     if (!check_atom_bios(adev, vhdr->ImageLength)) {
>> -                             amdgpu_bios_release(adev);
>> +                     if (vhdr->ImageLength &&
>> +                         !amdgpu_acpi_vfct_match(adev, vhdr, exact)) {
>> +                             adev->bios = kmemdup(&vbios-
>>> VbiosContent,
>> +                                                  vhdr->ImageLength,
>> +                                                  GFP_KERNEL);
>> +
>> +                             if (!check_atom_bios(adev, vhdr-
>>> ImageLength)) {
>> +                                     amdgpu_bios_release(adev);
>> +                                     goto out;
>> +                             }
>> +                             adev->bios_size = vhdr->ImageLength;
>> +                             r = true;
>>                                goto out;
>>                        }
>> -                     adev->bios_size = vhdr->ImageLength;
>> -                     r = true;
>> -                     goto out;
>>                }
>> +
>> +             if (!exact)
>> +                     break;
>>        }
>>
>>        dev_info(adev->dev, "ACPI VFCT table present but broken (too short
>> #2),skipping\n");
>> --
>> 2.53.0
> 

