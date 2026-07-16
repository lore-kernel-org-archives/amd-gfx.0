Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CAAC4450A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 13:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C1F410F2ED;
	Thu, 16 Jul 2026 13:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NBoMWDeY";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010039.outbound.protection.outlook.com
 [40.93.198.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C01EC10F2ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 13:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhhMb85San1HOVmtV2XHhOyX24R/jpmlWlQzNtRZjzRoxil2ijndZAs154LNui6vH5Rk55+mYjSGzIFNpUZGnePZeoPcKrnDvgiH9teGglqfNOxaC1wLjsSxj/pSexRX/4NKmNFyMfE92N5wQhW9Rvtjg5JKDvpa0GEc+G5x+RJ4rp7GHxCPFim/44Oa7JNG4PAmijfGB0JimUVg0JGMPzkiRX7bW00BLL5wVqIttQrhTQPNO17pdWewEvCuCkxCE8tcFBplpeXt3kI3sk0k60Xl9vnedR1BUNa2aoqDmbkNCobU/16ZJuJEjUD/ITFYw0JhJxRqG0yNqbAg2i8y1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pk1x2+VVaZpQ+KAQR0OlHi4TNEdy/LtLl97+bGluN6Y=;
 b=QBghGPjSKKD87pEf9aTt4Ts8sMvRvtPDuTfQW19E4o2A+Zh3RL4lx4CiDyYTxYl9HHwS+wEZCoVssOjmG0NILXntWDNXc/sLeGJjWmMv0v3dH2hWhT0dgNj/Lweh34o47P8emojVBWBlPmQYKOGfImdscoavX7iu4FOv/f3w6iHfD8vaz69ab1Pn1/yvGtBAobe+5ObFP+/EQbyHoFk0OcVi6BNInqhHiebb2QVWszh23VTMJ9XE5jNwW81291r6H1AtfaGu8rpknyLYFkYIK82c+3zrJR2b3JMbCreLbS3nldvmvzLQ2+gWZx7LwMDyfl8gfHFkAMZfmIUcLe69RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk1x2+VVaZpQ+KAQR0OlHi4TNEdy/LtLl97+bGluN6Y=;
 b=NBoMWDeYgoeYf9XNwS6pHgaE3ezNTNeT4I3ciwpeVEY3N8EWfx5ROvVBrTgZh4LER2t8TLd8qwubAnQzWuOhToLAbcEHMHmeHqCIQ04wu7UyoTcFk+AULEK8/DrURve58gM1VCUc3rl6HJHKSdtyW61fnkIVZDrZBBhzx5Juq9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 13:21:16 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 13:21:16 +0000
Message-ID: <6f4ec487-6cb8-412c-ac1a-b0710c79c584@amd.com>
Date: Thu, 16 Jul 2026 08:21:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu: Fix VFCT bus number matching with soft
 filter
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "Deucher, Alexander" <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Oz Tiram <oz@shift-computing.de>
References: <20260708193518.702584-1-mario.limonciello@amd.com>
 <20260708193518.702584-2-mario.limonciello@amd.com>
 <aljQlgDxiRrtMJti@monoceros>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <aljQlgDxiRrtMJti@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::12) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 05cb3472-6ec1-4613-bdbb-08dee33d1d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: m26YacnVVmd0nUQLQHfdB4/b3zD7xRfwiETgoaA2FmknBWQ7P3Ood40u0SmoG+G6WaF9uBzPKz3ZlHMIE+LeT417hLD995g+0jXjiGvQu/TMgsWEnXYjJGZm+Aop6TNxsIlPGp7Ue4LOlXZ1U1cmvzXwoCfccOCCax+/lNZYO/wiy0hHa9it/sWeIUs+h6llYpxji4L7hrZBcBSu7lluvOiHw95t2MkDn6S6jFwQ1Au8OjeTrMKaY1H0umYUvcBiNFJlvsupkHZWyk1RrUK231VqJYen/GUBGwTeMgEJ4QtCyoZ25pUEoJOu87qZaA+uSowb/FsfRXCF1pV+K7alnlQsnvtdIgEeIkB3wprahgM20qzaT1Xva6vDxALoXeO53I3y5nfInD23nib8KbzQhZzrc0NxnMq7EO7MISojaeLso8yhhFopC4VeqWStWoau2IJAu4x7s7xAWXMBASaSr3WVsjvb/eMmxE4bb0TSnnx/CxFquls1DaSd3mgTopFZePcFLkWt2JVENC0vZoA6eC3WLSVhkxga14wRoxjfnjpUc0m2t08wrQuWUTNgoKCG2Lg0uzJ92PhVMDQpyDXzwXVxNpFREFPYCpZ6gtsJZhhix1c9U6RnRwh8vPg9kp4c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjJnR3FQZ3RGY2hXMEtCUlFNWWdoaGxLR2hFekZaUWNwRDhCaDUveVdEWVpT?=
 =?utf-8?B?cURSSDhPdWxMSk1UT2E5UFVDb29PcHJFQldGemd2MG5vODV0azB0dTF4WGF1?=
 =?utf-8?B?U3VrR0lnbnVFaUdnNVZnR3J5UnhjcnRHdHZxU2dvZWRzREErcEdXZGcxSUJR?=
 =?utf-8?B?Y0d5Qk52c2g0bFQrV1pxNkdkVE1EOHFhTUQ2ZGNCclNqV1JyaTdOWG8zdDE5?=
 =?utf-8?B?ZlE5aDExK1VRNHg5Zkd1NkI4d25sWXR0N3I3T281SVZ1YVRleDdxTlBmcjl6?=
 =?utf-8?B?bUc0cnlubWFzWVkrMDQxRlF5ZzlWbkpEckQ1Sndzb1lTN0xNMTBhVE5YZ2Rw?=
 =?utf-8?B?YjROa2NOU1BDblR2OUJPaytWRGgyelYyc1J1Y0VRc2JrRXVpem4wY2dBMzNk?=
 =?utf-8?B?czJaa2dxTXlFR05hNXF3WUsycmMxZUx6aisrNFBKeDRyaU1qUzNQMXR2aXVC?=
 =?utf-8?B?aUxDQ3pYTzRTeWlHc2lRcXFFV1dlU1JtRWtwSCs3cGNoOG05ZUI5SDh6eUpN?=
 =?utf-8?B?WmlIUFJIR0JJZE1FZVdQWGN1bXZ4NU5FckdRT0RTUHkyNWFnRFRrMnFUazBI?=
 =?utf-8?B?MjUrelVzR3B0VjFMeDIwalpDN2tEVCtTWnB1MVp3VDNIbmp2OTJkOXp1eUVu?=
 =?utf-8?B?TTIwdUc3dExSN0pEUURwUDlYR3VOU0lPbFJ4SFFPQzVYZUl4SS9MQVQzZFY0?=
 =?utf-8?B?YWlqMzJ4UUU2U0Vra21MVSt2SXpGR1hIR0ZsSVZsdGRXd1hKdTMvZ0JsdDJw?=
 =?utf-8?B?RmtvdklmcS9MYzNPR1NHWGVhVHRhQzJkeEUrT2d6UWw3Z3RCY2M2Z09jL0Rw?=
 =?utf-8?B?OEVISVNHcktqYlNEaHRKTytha3hRSzNRdWZyZlNERWc0RnY4Ry8rWXpxNHBG?=
 =?utf-8?B?SkVDK1RKWlg3cVJ1QkxkUGpvc0lMWUVhS2I5WVJ4U1hPNHZJV0x3SVhza1Z4?=
 =?utf-8?B?cEo4Q3RCdFltNStBVDZQUkNVN3NkbGp2LzRWYUhTVi9mbXROc0dkbGU3Y29m?=
 =?utf-8?B?VTlhbTFCMXdWQ2wwbXdIdnovMDlRdTZFY0NwRlVqNmJSR0VBU1JoditmVmlm?=
 =?utf-8?B?WlB6eUtkbFNPbkl0WUFtRmZxOEMwQ3kwZ0xHbFZvMzhHOXYrUGJvWnRLeTFT?=
 =?utf-8?B?WXk0MEliUnZVVmlSYTlZdVp1bG0xVUdmMTFkNjZJVm1VM0w4VjFHdDlQZit2?=
 =?utf-8?B?WlExNGpQdFNxSmZKY3pWK21JOG8zdXc5UDByaUkraWhFR3psc0VYL09kQ1Q5?=
 =?utf-8?B?WEs4cW9oUVY0S0VoeDBXZUpEZU5EUUVsNTJZTWdGY1VOR3BicmR6VFowUSs3?=
 =?utf-8?B?eSt5Q3QreHNwNVYzYUdDN1RQUWlIL2J0Ujl2QWt6Wk4rMGhzamlab1QzdkxJ?=
 =?utf-8?B?bEpLZWx3by9nRjhDVGs4K09nak9lN3QxWUsxQmpEQjdTemdvTEtjdjVGMHQr?=
 =?utf-8?B?YWI4RlZwSE1EY2pxSmZWWjF3RC91WjI3VThYeERFUjJCc0FWU2FtSkZWdmhC?=
 =?utf-8?B?d3Nra01FOTQ1dzJpOHNKeGtPVktEdWhYUjNUM1BTWCtKMVlQTVFKZDJGYlhm?=
 =?utf-8?B?NkEwUWpmSTdPVkhwNnNwb3VrejRoQzM3cnFCK1BrandwTHAyVkZmMUdBaHhE?=
 =?utf-8?B?SmRDczZ5a0JxV3E1bE96VzZVZHZMZm9ydU9WOXVBRmhob0NydkdYZlBsTzly?=
 =?utf-8?B?Y3MwZTNZRlhzTFlaM0J2MzIybmY2WVhrOW92M29VbXpxYi9CdWNQK0ZzeVZw?=
 =?utf-8?B?S2x5endaeWxGa3h0WnI3ck5XMW9Fc1lXWEs3UzMrUlMzOFJ2S0sxSGZKOU9U?=
 =?utf-8?B?SG5iTjFCNWxNMnlLSXJlTDJsSkVvY29SM25Oa2dkbGJqWCtUSFFWZGg4NExZ?=
 =?utf-8?B?OWx3Tjd0NGpjR0l3NEJVYzRTcWkyVWZBNk1iNVF0MURUcDNnYzd3eTJUMWR4?=
 =?utf-8?B?S3c4SnduMmpLU252R3hqbzNEZDcrUm9rb0loZTVLOVBHYm1jdU5wNTg3dDh5?=
 =?utf-8?B?UUF2Y3cvNXlBTEhtNi9EMmN1NXFCYk9LamZ4V0l1K2RTN1lXTjd5RzkzdFhG?=
 =?utf-8?B?cEp2cU9LRW0wZFVDNG1IY3NmWk96SXlBNEZDRW1COHQyYWtTQTFCaWpHaDI4?=
 =?utf-8?B?UW8rczlCUG1HSFN4dTdrRFk1amZCQjNZakcxZGJMS2hieXl4b2QyL0Z4VWFS?=
 =?utf-8?B?TE96Znppb3NwbEJzanhVMTBuQmhoYmg3UGtFcTIzWWlKY0dJNzVZOTRiMi85?=
 =?utf-8?B?Tm51MHhkUzFibTBUQndtUXpuTDFtd1ZQRUJ5UEpna3l1bEs3c2xOY0dXQmgv?=
 =?utf-8?B?US9LdlRFeS9UNjUwMlQrQkQ2eW1nK29zNG1Pbm0yc2NCTVU5TzVIQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cb3472-6ec1-4613-bdbb-08dee33d1d8d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:21:16.3031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TcSj/IO1huViq0OxG9v9W7X7JdkFM30+o7GNS7kmByooIH5BSwDGigP7kQOvqSZIr0orK3V5xH7FhLfxTZYng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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



On 7/16/26 07:41, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Jul 08, 2026 at 02:35:14PM -0500, Mario Limonciello wrote:
>> On systems where PCI bus renumbering occurs (e.g. pci=realloc,
>> resource conflicts), the runtime bus number may differ from the
>> BIOS POST bus number recorded in the VFCT table. This causes
>> amdgpu_acpi_vfct_bios() to fail finding the VBIOS even though
>> the correct device entry exists.
>>
>> Introduce amdgpu_acpi_vfct_match() which treats the bus number
>> as a soft filter: vendor/device/function identity is the hard
>> requirement, while exact bus match is the preferred path. When
>> bus numbers disagree but device identity matches, accept the
>> VFCT entry and log a dev_notice for diagnostics.
>>
>> Reported-by: Oz Tiram <oz@shift-computing.de>
>> Closes: https://lore.kernel.org/amd-gfx/20260621173211.28443-1-oz@shift-computing.de/
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 45 +++++++++++++++++++++---
>>   1 file changed, 40 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> index 3ebdd792feec1..d8fd047295d9d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> @@ -377,6 +377,45 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
>>   		false : amdgpu_asic_read_disabled_bios(adev);
>>   }
>>   
>> +/**
>> + * amdgpu_acpi_vfct_match() - Check if a VFCT entry matches the device
>> + * @adev: AMDGPU device
>> + * @vhdr: VFCT image header to check
>> + *
>> + * VFCT entries contain the PCI bus number as recorded during BIOS POST.
>> + * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
>> + * resource conflicts), the runtime bus number may differ from the POST
>> + * value.  Match by device identity (vendor + device + function) and use
>> + * the bus number as a preference: exact bus match is preferred, but when
>> + * the bus numbers disagree we accept the entry if the device identity
>> + * matches.
>> + *
>> + * Returns: 0 on match, -ENODEV on no match
>> + */
>> +static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>> +				  VFCT_IMAGE_HEADER *vhdr)
>> +{
>> +	/* Vendor and device IDs must always match */
>> +	if (vhdr->VendorID != adev->pdev->vendor ||
>> +	    vhdr->DeviceID != adev->pdev->device)
>> +		return -ENODEV;
>> +
>> +	if (vhdr->PCIDevice != PCI_SLOT(adev->pdev->devfn) ||
>> +	    vhdr->PCIFunction != PCI_FUNC(adev->pdev->devfn))
>> +		return -ENODEV;
>> +
>> +	/* Exact bus number match - preferred */
>> +	if (vhdr->PCIBus == adev->pdev->bus->number)
>> +		return 0;
>> +
>> +	/* Bus mismatch but device identity matches (PCI renumbering case) */
>> +	dev_notice(adev->dev,
>> +		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
>> +		   vhdr->PCIBus, adev->pdev->bus->number,
>> +		   adev->pdev->vendor, adev->pdev->device);
>> +	return 0;
>> +}
>> +
>>   #ifdef CONFIG_ACPI
>>   static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
>>   {
>> @@ -413,11 +452,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
>>   		}
>>   
>>   		if (vhdr->ImageLength &&
>> -		    vhdr->PCIBus == adev->pdev->bus->number &&
>> -		    vhdr->PCIDevice == PCI_SLOT(adev->pdev->devfn) &&
>> -		    vhdr->PCIFunction == PCI_FUNC(adev->pdev->devfn) &&
>> -		    vhdr->VendorID == adev->pdev->vendor &&
>> -		    vhdr->DeviceID == adev->pdev->device) {
>> +		    !amdgpu_acpi_vfct_match(adev, vhdr)) {
>>   			adev->bios = kmemdup(&vbios->VbiosContent,
>>   					     vhdr->ImageLength,
>>   					     GFP_KERNEL);
> 
> For the record to hopefully make it easier for others to find the fix:
> 
> This patch became 33a18ecd2fbf in
> 
> 	https://gitlab.freedesktop.org/agd5f/linux.git drm-next
> 
> and thus next and it introduces a build failure for !CONFIG_ACPI builds:
> 
> 	drivers/gpu/drm/radeon/radeon_bios.c:614:12: error: ‘radeon_acpi_vfct_match’ defined but not used [-Werror=unused-function]
> 	  614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
> 	      |            ^~~~~~~~~~~~~~~~~~~~~~
> 
> Patch available at https://lore.kernel.org/all/20260716123646.1933293-2-u.kleine-koenig@baylibre.com/
> 
> Best regards
> Uwe

Thanks.  Alex can you squash that in, or has the merge request already 
gone out?

