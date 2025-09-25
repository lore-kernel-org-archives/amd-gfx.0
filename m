Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A999CAC5B9
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 19:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF7E610E2D5;
	Thu, 25 Sep 2025 19:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l4MIdydY";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012043.outbound.protection.outlook.com
 [40.93.195.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E529210E2D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 19:50:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=na8wjgJQMe7RVFyqs5VsS3DqkBV4UtPLPdIPCbzHBY38G2QGhbuoGEKIp8qVECMj2OiVqimw/+K74O5mNFfQgSHRnp0VKkHVWSUU8HZRyInR20U3NnFVIVjmKezpL2JHgDTuCjG1bfv/pXjmjTWwhdxgKM1iAETi/qwBknCVHpFNXJGAx6txljDSAHRRKWO3ZtIdsdYQlDkEAWeZXXho5JgKDIl+yCnXJqkBf2nxMgy3BKwot0FUtpGQEBCR3SSLOKK24HCqlACeXiiCh00gvfsL6WNx/4ugWS94l1TdEX0ZCBWrFbp6Zrokk7Ox0QfGZwC+LnZWGEV6GsEjLBSIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPI76rtoED4pfm9O9uiJVpeiBNNfsmyZ2YhdLYWQpL4=;
 b=vz8Y8dQ1QFYxOZnVGfdZnuyZ62+epR3sTzg/15oTC979Pmv8I2DmQuP1AbcMlUywR+4HGIbw1JgHdFGn+m7JbkVBgf618W1K4yN/UD/VDDXYNIUpJPnOUPemNwBG5cNkVq64POZwGx5Yn2uON1kOgBj+MprvrAj8gFzEfvkVAiA38/LFNc2nXMEkhPK9XzXzNQlI6NsV9uR8VxniGTHPD0DHz4mkjqXeFGIIU3S+f3tHJgrXGnFCVWNPuwWi4q+wLaQ5JB5vkruan8VLd/aadPFvitCEFlagHDpo+4jPIna2z8bRQNMiCtgvzzpoQhU8aIjRE+ENAf21ysbZEnHufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPI76rtoED4pfm9O9uiJVpeiBNNfsmyZ2YhdLYWQpL4=;
 b=l4MIdydYIZTv32Fhi6cFUWkH5wIxkUVPxLq5WWkFGNidxqOmgZAkctXkYpvp10kgkJsRIeR47D3PUxU7o4WOcVjEaBo61oEnebC3N3ikOP3Gs8GK6F2yrXbEq1Y0JjEFJkAzTW7EXr4p44V0HtgE6EumYQvDV9+Ao6O9fPHdFUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7SPRMB0010.namprd12.prod.outlook.com (2603:10b6:8:87::8) by
 DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Thu, 25 Sep 2025 19:50:40 +0000
Received: from DS7SPRMB0010.namprd12.prod.outlook.com
 ([fe80::b021:a6a0:9c65:221e]) by DS7SPRMB0010.namprd12.prod.outlook.com
 ([fe80::b021:a6a0:9c65:221e%7]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 19:50:40 +0000
Message-ID: <b9863279-9303-4acf-961d-bbcd624c1cc5@amd.com>
Date: Thu, 25 Sep 2025 14:50:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Check whether secure display TA loaded
 successfully
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250925191402.2518978-1-mario.limonciello@amd.com>
 <CADnq5_M7_LTPz7KjtCWHH3XP5OZsFZoO=odqNPtkOLdgxXU-LA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_M7_LTPz7KjtCWHH3XP5OZsFZoO=odqNPtkOLdgxXU-LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0233.namprd04.prod.outlook.com
 (2603:10b6:806:127::28) To DS7SPRMB0010.namprd12.prod.outlook.com
 (2603:10b6:8:87::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7SPRMB0010:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 587331c4-c2c5-43b4-9bee-08ddfc6ccdd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVlNa0ZxTEpRRm80NUIxKzZ0OW9pRGErZ1lqSVpPUzhtM2lwQlRJRmY2UVVF?=
 =?utf-8?B?NmlWanhOV0JJcnZqbzdqZmtpUjcxMGQ3eXVsaVFPdUs0ZXVvMmVmdXhxZU1a?=
 =?utf-8?B?UUJnSHBGSGlnQk1uMHhnOCtGVEtYQlcySms5b0lQcVBBNVJQMDZwZVhCendS?=
 =?utf-8?B?Kzlualh3SCt0SWN0dkZEVUhpMlZkWWlNL3V5Z05Ray9yK2V6THVVUUNYQmlH?=
 =?utf-8?B?WlJMeFRDMGpGOWxLVTJubnVZMVVBL2hOckFxd2NBOUR1NVZ6Z1YzeE9PZGkz?=
 =?utf-8?B?SmRRMDAySWxCWjJXVU9RaFp4bVp1Y1RHUUdsczBySkliZjFzTnBHOEE1RXFj?=
 =?utf-8?B?cjJWN2lMQXRMNXIwOXBmOWdSNXlWanBDaWFXTllDVmJyRU1aaFFDblhVd3Qx?=
 =?utf-8?B?U3MrdHgxU0ZjQkkvR3A5Y0RNTTVXVzErK3o0V1hXb25kSzdUMUFrdWN3ODNO?=
 =?utf-8?B?NTczaG55L3h6RWZkVUFRcWVtRGw1OVZrdkhaVEY5RndyQ1VGOCtsWUw0RHBX?=
 =?utf-8?B?RXRXNHByUTg4OFB5UU92M1B4UXNkT0IvRkROampjcFJnNzVuaURzdXFwTHdy?=
 =?utf-8?B?STRzM2oxaHQ3QytaWUg5UzliVFRwNGpyQjlmaW9iaUQrNU5qaGMrZTVHMW9Z?=
 =?utf-8?B?dDVWVE13MDFxdGlTYUFmL1FCL0FpcngyQnpwZTZUZUJtMUFMWFZWS3ZtRkR5?=
 =?utf-8?B?a2VwV2lFYVhDRWY2YWhOT29WU0tJYVVrQVdvb3dLS1pGV09mSGNucVFyY3VZ?=
 =?utf-8?B?TVpjdGdSYkIzOUJUNGoyUndIWEV5RWxXcUpYYVFMQlcySi83blFpemR1cEda?=
 =?utf-8?B?d3d0TmZGSmowMkQ1MjlaTWJPaUZtOUdvaTNOZHBGRjZlYjVGWURFeHpaWkJw?=
 =?utf-8?B?YUdCcGRIRXBMTHN0eHVSUHdnaTFYTkhPOW5Ua1ZmODRwcmdWbXlFMjlEQzVr?=
 =?utf-8?B?MnRpL013T0JlS01KZ1Y4QnFOTXp4OFpOZmVkTGpQNHkyY29rSW5XVXZJVWFu?=
 =?utf-8?B?eWIwcHVMNXVzL29TdHltL2Q1Rk1sZkNBWGhraDVWaE92MUZ6TmxCR1h0WVAw?=
 =?utf-8?B?NjQ2ZE5ic0xHMTZLTVJjM0tySUVIWHFMNGFxYk83bTY4NXlFZG1ZZjlkOVdP?=
 =?utf-8?B?NTU5eFNWYWFyRmhzeWdMUEZwdUg2YjdCc3JYUUpHbDhHdXhtR3pqR2JJY0xv?=
 =?utf-8?B?bFpFakhxdndWOXRhaG00ZG1NUjZFQWtXM0J3ME9jMFpKNit3TzNoVi83b294?=
 =?utf-8?B?Q2xlY25wdWNLS0ZoZTAwVlppdzR2VDBJNUJrTXFWUFhaSFZOYjA1ZGZoU2du?=
 =?utf-8?B?eDFXR29QZHNDK2tBQUZ1U2JZUDg4eFJrSTRQbzZZdHZIYXFZK1FMRis0R0x2?=
 =?utf-8?B?cWxTWVFTTndhRXJLN2U1UG1UU0JNWkJJeXJVTEtRcWZKRkRqOEMreW54ai9S?=
 =?utf-8?B?eFpBaXVuNkJjZEFreUVvZFcwcDNtQUVwQXFQaDdidC9JQ1MvUjJ4MjZ4Yk1P?=
 =?utf-8?B?T2ozdExiYUpPWHVHTWxXZzFtb1B1dml3a0RpcjVTV0FZMXBIdWpPTm5Ec2VU?=
 =?utf-8?B?OEcvaFFkWXNLTEs1WFJwc0FHaXBwc1BDV1NLU01RNkpmSlRWSDRRc0VhSVkv?=
 =?utf-8?B?Z2lTRG5aVWp3eDRITVIzVXphdnhraEpOYjFRZ0hEbHdKNHBXVjNyMjFRSnov?=
 =?utf-8?B?TkVDV0xBYWt5Wk4wbEJwZWlXNzZ4aGdjT1FoVENkOHNKQnFiT1JYbmExbUkr?=
 =?utf-8?B?NC9Rbkw3N0FrUm9taGNSYkxUeGxNY1BvL2R4Z2dUb2FHcFdDT2VnREkrdGZi?=
 =?utf-8?Q?Y6F24M/4MdbtY0lPYvnn6PsQjzK19V+B+bGHY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7SPRMB0010.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d01vOGRGb25kVTZDSEVnL2lhWDF4d3NkdlNORkN0dlNpRlVicU5lbnBydm5M?=
 =?utf-8?B?a00zRjB6ZnhCalRGSnVzbkhaVUtvMktiQWpOZjFUdUtKWVFXQUJXR3ZWV1RQ?=
 =?utf-8?B?ekk0NDF4VzRyS3RSSFNJcjh3QXNlV085eDZ0QVg5ZC9PMXpUV09OLzN5OU5y?=
 =?utf-8?B?Y3EvaCtiR3NZZjV2N2x3eGpOamdKakJNN2FNa3NMWGtRWGNEbzhHVnRsOGFx?=
 =?utf-8?B?RWQ5cnNsYnhnUVEweVkyeThJR3pxWUt6S2NJOStwUkUzVFIvaFVWWWlFcGJM?=
 =?utf-8?B?TGpwUnppaUswbUMxWjY5VXNwQnNIOW5JWkZPT3FzZmNiVCtkVnRqUGIxdWZE?=
 =?utf-8?B?MUFIWDR0QWV4UEc0Nk1ROGMxZ3VsR2NBQ2lGeEQ3VkdtZDhxcWt0ajdrZkZI?=
 =?utf-8?B?UGhqcEx0T1NPWWxxY1gvdlNBY0xFU0JqaGRWUDFaT1FCbHIvUWJKUWYrRE1t?=
 =?utf-8?B?MW1Qd20vTWNSVjYvK3NSeE1qYzVaVVlQVnQyQXFNd1E0SXQrbklGRHZZYVlS?=
 =?utf-8?B?SlZMdzJ3c0pXdVhET0pBTkREL1pBMFpZUFA5N1NCSkkxRWw2dUFLK1p3ZEUx?=
 =?utf-8?B?Q2hQdWFOSlZ4bXFsQ1NESFJZT2FXZ0E1akE4MlhSVzJLSEliVUZFK2ZEd0JG?=
 =?utf-8?B?dEgxczMrMjhud2E1MGhmR1lkV0dHTG9LeDQyVERtMDB6VDlEa04xaFhTUG1Z?=
 =?utf-8?B?OVhjZUZNREhlRHlKZ2g4M1dZMXlZOTZCNVphSnZWN0hyOEN3ZGpDWE1Ibllw?=
 =?utf-8?B?eW1NZDdsczlwbm5XVTVsTmU5VnZXeHYrZ0VXY0w0RWZIUkUvTzRaUVFBQzRm?=
 =?utf-8?B?UmFRY0F5a2FPQVI0NGUwcXRER1padU1BZUIxK3o4K0tFRzhKSGdrVGFKQnU5?=
 =?utf-8?B?Uk5sc1NtYUhlbE1saFlvSklzVkJLRDdBM090dkJZVlVqRHpRUUVQUWNDQ1B2?=
 =?utf-8?B?bElnLzQ1TG9ML2tMS0tScnBQa1UzYy9yanNGSWpxdUdoUXVMbnlYVEJyVUhP?=
 =?utf-8?B?TUZKNHA5Q3dQamhWSWhuS1Z3cVBJcisxd0V0eGIvZGRhWVNwRzNEYjVsWlZS?=
 =?utf-8?B?dXBHVnJkS0FXeWszL1RGMXpiQ0JQU3pEcjlQNkJYMkhpZ0Q0M21GOXFiS2dO?=
 =?utf-8?B?ekJpQXZ2MmVFYXdWTDdobWlka3lVTnd4OE9xVEY2dVlvdWNkYlU4RDlQZTZ4?=
 =?utf-8?B?OStvMmVHUzF5Y2IvRjNDejM3ZlNEMEdZQ1BTTDByWTQ5U1RFN3pVYzNaR25T?=
 =?utf-8?B?aVdrRmpka0M4aFJEMS9OTnJ6aHpLTEk5d2tsU0ZiZGQ2OXIxdm5mSWc5cDNB?=
 =?utf-8?B?WDJzcVVVUUJTclVvY0lzUHl5V3lYbUlNU3RDYUxVVGVXZXNMUE1JSkFoOHgz?=
 =?utf-8?B?SFltQTI4UlBwdjY2WlUveVF4VVdZUHhmd3EvcEJCY2FVNlFkWTY1NUVEYVhX?=
 =?utf-8?B?T0JXVkN0NzV3Y1hiNnNrQ1pLY0RST25LTFgvN3FMVzJxaS9taTBUNXlSc3VX?=
 =?utf-8?B?OTN4WmNRQ0ZWUHV4RUM2YU1PeW1qV2ZkMytlZElGVmIvVDhvL3hkZ0hndTFt?=
 =?utf-8?B?QktvbmlkamZHZFRya0xiSUNEWVQ1Wml3T0VvTStWbXVKcEFtMzdaV1Z2K3pp?=
 =?utf-8?B?anFROGphWlJYZVQ1WGtSazVFS2RVTEl5eHArQUQzWjdhczRNdUF1VFNrd3Qr?=
 =?utf-8?B?dnJNa0lmVjdqY2ExZ245ZHplWEFHck50QWJkaG14L3FyTlN3akE1cXYyVmVo?=
 =?utf-8?B?N1p2QzJtbW0zc2FRckpUcVdIVGhMY3hPYUZ1cUdUOUtteDFnZE1jTGl6cHgw?=
 =?utf-8?B?TEVFSk8wRm83MnBXb2hoVmtUOUIxdmRidG1PMGhRK3JGTUtKc0hmcVVlMHJI?=
 =?utf-8?B?VVJpRGJMdzU2VkxleVRZcjd4RXNYcFplbStwQXhtMG9hMjBwYlhqSWwyTlFx?=
 =?utf-8?B?VXowTVdhVk1HVStsQkVRc3ZhWFVZWHVIRGNQcTB5dlZBM1RsTkJEcDZBWW96?=
 =?utf-8?B?eVE5VlB6dmwzTUdjcXQ1UG1ZV29iM3doN01sbE1jenBOTXZnR1Nuak1nR2pS?=
 =?utf-8?B?ekl3VGJlTXlUR0dKaEIrY0tPK1doV0NDUWxnNERzVXIvZWJOeVp6SVdNQTZW?=
 =?utf-8?Q?6dck3NKIfGjqbeMxDf3tGHkki?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587331c4-c2c5-43b4-9bee-08ddfc6ccdd4
X-MS-Exchange-CrossTenant-AuthSource: DS7SPRMB0010.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 19:50:40.1011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQGyDR/W5wb3xnEJOCOFp897pWkDmRoQ7OJuvPusGUZ1SIUMjoknOHQOZfywLVlOT5kVlxXMFTtJgpOojDI4Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
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



On 9/25/2025 2:46 PM, Alex Deucher wrote:
> On Thu, Sep 25, 2025 at 3:39 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> [Why]
>> Not all renoir hardware supports secure display.  If the TA is present
>> but the feature isn't supported it will fail to load or send commands.
>> This shows ERR messages to the user that make it seems like there is
>> a problem.
>>
>> [How]
>> Check the resp_status of the context to see if there was an error
>> before trying to send any secure display commands.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1415
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> I think the tricky part is that we want it to throw an error on a
> system where it is supported so the user knows something is wrong.

But a system that it's supported would have loaded the TA correctly, right?

This is specifically checking if the TA load failed which is being used 
as a proxy to show you shouldn't bother with the other commands.

We still show WARN messages from
psp_ta_load()
->psp_cmd_submit_buf()

I guess arguably this change really should be:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 693357caa9a8..1c790dfccc9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2350,7 +2350,7 @@ static int psp_securedisplay_initialize(struct 
psp_context *psp)
         }

         ret = psp_ta_load(psp, &psp->securedisplay_context.context);
-       if (!ret) {
+       if (!ret && !psp->securedisplay_context.context.resp_status) {
                 psp->securedisplay_context.context.initialized = true;
                 mutex_init(&psp->securedisplay_context.mutex);
         } else
> 
> Alex
> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index 693357caa9a8..70d4bfb13f46 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -2356,6 +2356,9 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
>>          } else
>>                  return ret;
>>
>> +       if (psp->securedisplay_context.context.resp_status)
>> +               return 0;
>> +
>>          mutex_lock(&psp->securedisplay_context.mutex);
>>
>>          psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
>> --
>> 2.51.0
>>

