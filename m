Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE27BC3ABD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 21:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D57D10EB9D;
	Fri, 16 May 2025 21:38:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cXZzvEPO";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7127410EB9D
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 21:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZNThYcZsxnC5WPLP8DWQl5g8V75Ec3w2lP4/uI6OaBYw9QSgv98VnWl5bkTqVe4FnbXcIDZxLt5DirwJ7pOCu74Ui5d32UcmBmOareMnblECoR2DoGzAIdQgXD0agZ+kv7gZYjjUyxYYvB2k+f0IT3+p6NNdkGLuAMHMgkNFVwdlaGHhHZZpiZrc2HTNokcjNg/7llGQ2gT69nC/kvbgobd5jI7qDfCDpFN/hskYEoP7HBhNcbmbwMz4OENu501xCZ/gTCsIvoyNm353zRZH3yi4XgrFm8YzqW9yLXz/kIKgPGPjOTlod9B+a4VdC1Beho0xWeNSfeiUOS7MJ2KUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRDpPtdz7xUbp45obWF3pw8wyskyhT5+TVO9xvqaP0M=;
 b=OWTFbNO6TLl1qeF09Ux7PJ835G8I+allyhe+OVQx3yQWTGOXfALZ3gFcVbUp6/+QIMukwhBRgsAElAWWHOciHFB/Ex9tzdg8K0t9HL61uDS8K//KVHFv7M9VnXGrLUPbHnCrDqkBgQSAjJAATRjFL7Qycr8P+aBfw2N/HxceUNJp8dhJ4hhVy1YZSeQyZakB0hruKw6us5xb87ItYVjmvzGmcw66YUq8qs+WmwqmK4AluZPnrFHLe91InPSjNO59bJg63VP3DUjoFtfhCFRbT8EBdrpg8af5j4iFjO7KgqfwnDP4tLRe0DWfOcBk1KW3q2Oyd08SQ/g9glaAv/rCDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRDpPtdz7xUbp45obWF3pw8wyskyhT5+TVO9xvqaP0M=;
 b=cXZzvEPOoYt7xyGMj6OvRgGfSCTWcuY9SF6h+wdB78ZxlFFu3Tl04DQ0fQYvwr2eo3WeR8qK5gIIEd8Rdu+ilbuwi1HjBIyD+34VriRjUAYtzP6bC1px7xZAfKfV5esv4L+HlmMuErMa9ZLvoKYIWSltmXK8uxuhS1ZRF5trdFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 21:38:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 21:38:21 +0000
Message-ID: <87136b85-d0b4-44e5-b5be-4b589ccd49b8@amd.com>
Date: Fri, 16 May 2025 16:38:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amd/amdgpu: Add GPIO resources required for amdisp
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com
References: <20250516213126.1830572-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250516213126.1830572-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0199.namprd04.prod.outlook.com
 (2603:10b6:806:126::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da200ee-afd8-4838-c4f5-08dd94c1faeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUd0OFVFby81RFlRRitvT2k2NEtqcy9JOUJ4VUZyZXJsWUpRbnNDQ1pqbzc5?=
 =?utf-8?B?d3ViZ01rTXlYTUR0SXh3YUdJQ1A3MG5PWmJwNWtUekFzMWFhU0ZzaHR1S3Ba?=
 =?utf-8?B?UW1jY25JTGtsbkF1MkhVS29mSTZTc3VYOTdhZzAzRHA3VHJ2T1Q1WWw1RTh6?=
 =?utf-8?B?L1FnbU1qUm1rbjJhVmxBMFZUbFVieStCUjhLNzZDZjBrVGlMSU9BVnoyMngv?=
 =?utf-8?B?aFdWUTIyTXdIdGRFM3VibHBDcEFLTjRqT2dZa2lhZVVha3Y5MFVzdjhPTFVG?=
 =?utf-8?B?YzNLYWxJbXVoaUlTeHF4MXY0VXpBVEN1N09RVUxhdk9yTEg3aGtMNVFUQXMr?=
 =?utf-8?B?SHpuYnU2bFBqeXpJdkk0aksvK3FMUjE0cFFwamRjL3p3VHAydDN3dDh0bGdI?=
 =?utf-8?B?d2RmM0JGL1pjVDFtQXZqbElTYXRiRmxsZ3A0cnVwSFY3Tm1rMjEvMGlxMG93?=
 =?utf-8?B?TXhlMEgvb1g1dysrcWNhVm1GV1BFTXV2SWltS25IUVFHS2ZIRU5rQjY3MXJz?=
 =?utf-8?B?azA3WWY1QXlZRzB2TGRkSml3UllGMTJtS0VBSkZ1SlVpNmZUWkw3V0hkWXJW?=
 =?utf-8?B?ODQzQ1MyTjlhbzA4MTdydjFUSkM0WkJFSjdMSDBWeUx3VnNLV0JNYi9GZEJB?=
 =?utf-8?B?bDFLSDg2SjVBS1ZZZUhtZ0d6U05CV3d5T1dqdVRGOEFFbm9valFXK05lOWlu?=
 =?utf-8?B?WkNycklJOU1QOHAvTUo3UnpwbFRjMHB2NElVTy9DTXZodFN5MG94djcveDRl?=
 =?utf-8?B?Z2FNWmZxcUxFbmo5Ti9YQmZBRGh0U2Y5VzVYbXB4MWt0SW9XK2d6bFdUanI2?=
 =?utf-8?B?Zkw1dkJpV2xLQ3R4T1V5VWI5ekY1TzBRT0UvWE5POFF5NnJ6VUJzaTc5cXkr?=
 =?utf-8?B?VVE4S2dYVlZ1WXZxMFFLVSt1bXc4Rkp0dG0xejBla2xpS0JkZE1QbGdEdmZD?=
 =?utf-8?B?V1FuSjNRWmtnOHl6MkJ6MzdiUjhSR04rY1REbVlBUm5IUFBSUzQySks0RDMw?=
 =?utf-8?B?dTVoNmxRZ1VUdzVPL2xwb0R4MmdCT2draDNnT1FPeXhmaFlXY3dVcVc4cmVI?=
 =?utf-8?B?N1dBZTdRVmdBOWxIekNERGdFL1JMbUtUckQyUjZwbStFSWV5TXBaV29kUUUv?=
 =?utf-8?B?TkNIMFFjL1JwNXBWWlJFbzVnWGgxaUhrRnN5SFdIMU5mZ1Q2U043dWNwWUty?=
 =?utf-8?B?Z1ZSR3ZjMjRoSkVIOVh0N0Nod3ZIOUVwTDNHaHFrRElNTkFRci8wR1ZpQ3U5?=
 =?utf-8?B?UjJOQ0NySEV4MmdXRUlKRGJpZ0w4MTRPUGF3d29SUzMzcTMrdDZMcCtRT3Fm?=
 =?utf-8?B?Rm1MTEhKU21OOXdIeStGY21OaVdBbVoyRUdmQWc4M0plV2NId1djNTdWT0w0?=
 =?utf-8?B?M043WjZ0SElsSCtYQjdGdk9oYXpremhlZzA0SmlSZm1KNk9ESS9ydmxzRkdI?=
 =?utf-8?B?VVZOY2cvWXVsbWt3bXNiNkdxTGNRWjVuR1VkZmR1UDM4Z0p3alV5NGFnWERx?=
 =?utf-8?B?ZFl0YmUxN3FpZDRSNkdSbkxCcXVBZWRvSXRvTjU3R21FVnZwNDd6QWVDMXI1?=
 =?utf-8?B?VmdzekVBYkNtZU9VcFlVRThwS0RPMnRaeGxRSzVYemxIYklnZHBFYmE0c2d2?=
 =?utf-8?B?UWN4MmpuS1hPSVlqeEhjelpDdVdpYlF2cXhROHZ6eTgrU3d2a0g0WFJVbHBW?=
 =?utf-8?B?VC9aczJTKy9IczZaS25QUEZJN29zUCszMGRlS2FzMkVZdjRhb1Q0Zk1ZMzRR?=
 =?utf-8?B?QWRQTlA3TVZtN3pPU2JuWGZ6U2NZY0VRaUxTL0FTM25KVmhwN0VyTGFjek16?=
 =?utf-8?B?cmcvTnJsYy9ZdW4rL2lVY3dBMzg2RXB5eHV6YWgvTHJVY0ZSbVNBNG1zUWEw?=
 =?utf-8?B?VEYzdVIxMXp5VEV0RUU0V0RYOFFRRi9uTko1V3grTk13OWNRSGI3MldiajFw?=
 =?utf-8?Q?WQaJr/mK9zM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REhKZ2lhNTR6N0ZhMjRLVjlHWnViakY3NVk5cm9mbWNDcE5Ma292UlNIdzZl?=
 =?utf-8?B?d2pEeDExMGJwLzE0UGVqbmhOYWhrVksvamJoMURNRlI0c21YbHNBZ0ZVdUxy?=
 =?utf-8?B?ODZFRlJjVEpkZ0Y1YnVlZk8zeVRud0E5QkFPTTZsdTVCMlF3dUdtc2FqYjV4?=
 =?utf-8?B?aXpaQ0ZKdVl3MGhiWTV2TGo4RldEOE9ZYy93T1lNNW4rTW9lOVNaVVZXQTZF?=
 =?utf-8?B?eGpSNVdUMXNValA3VkxTNndBa3dGdDhBS1diN3ZzVytEK0RKUTQ1b1ErY2ds?=
 =?utf-8?B?S1U5UkIxblgvWlpRWmFLUytadzFMRThGRkE5Yms2WmlMVWFWN1NHYXM4eEtJ?=
 =?utf-8?B?ZXd0cG9CVm1PYkFnZURkYWFNQ0tqWnM3QWRBZU5xTFNQSEtpbTF5ZGR1dGdl?=
 =?utf-8?B?K2ZUclphR2RtWUp3bVF0MTBDanVCeEdhZ1ppV2VGRCtkVW1RTlJwUzFvakY5?=
 =?utf-8?B?NmtEZm9LUVFqYWgvZXVPUzBaaUwzRyt6UXVPM1NBN05ZUXhuUkxPMmZKZGQ2?=
 =?utf-8?B?bVJsZkN2VUljQ0FUM0JlQWg0cjRpc3hObC9yaWhxQ2Z2UFR0UjVrajhqNnpW?=
 =?utf-8?B?ZE0wekpuci96Y3lnVUR6aVd1dkh1QUpIUmxkc3FOTGU2OXJnSkZQWjJtQ2FJ?=
 =?utf-8?B?SUtlQlNmL1Z1QTlrMGFEZlVtbDY4STZoM0svYlJGZS9xYy9RNzBvTGl4VGVv?=
 =?utf-8?B?TXpWTGl3Q2lWelRoTUVKSWJEbi9jSlEzcURMTkNKaEZEUGJXeDYwN0RCbktE?=
 =?utf-8?B?R3YwRnNseEkzWXBmbGdTR243d1duOHc0S0VEOGdRbm1TYnpmMW5yVzJUVUoz?=
 =?utf-8?B?MTZDOGJYcm1EY3lwRlhoOTBQaWUvdWROWmpad1BySHR4cWQycVAwRDZhb2tV?=
 =?utf-8?B?S0M2RnJXUXFBVTVMb0N5UGZxenFHQ25iUzduOWg5TDhsNWxyMytIWFhZLzh5?=
 =?utf-8?B?N0ZrNmVGVW53UkJBOER5bGtEemVQMllMV0M2Q1orRlZxZkdrdkg2NUZnLzBG?=
 =?utf-8?B?Mmp3Q0JSV1RPSUczMnN2b1FYUzNoK3NqTzNEQWkyUk0zWDlScGt4UGJPOVZq?=
 =?utf-8?B?Wm5Ea0NzWWpzL3VrcWhxbW5BdXRPMkFuTjdxS3hmakEvRDV1bnQ2ZEluMEVT?=
 =?utf-8?B?RDdBVXQ0SW9vdFdNWitmR1ZsTENnRnBTWGkvLzFUdkxzandCNUNCdEh4Q1dG?=
 =?utf-8?B?S25XQTMrREQ1UVN5MTVJUTR1T0IwaWZNaFIwR3MwNXRsUHAvNlV3dStkakY2?=
 =?utf-8?B?RGl0MDRRa1pSTW51UkhiVzhOcnI4bDJBUTRvU3NpdmdSSjhMZmJvSy9aS1RX?=
 =?utf-8?B?S3AzYXdSc1BJbmwySVE0TDhOYm5hQUxDUVdnem1odDQ3N2NLVWJuYm15b3M5?=
 =?utf-8?B?OHdNMmc3UndmWWxxVkNVRXNrQWRJWTlSdFR3TVhmbHY4WUFvajV4NkZLM1FR?=
 =?utf-8?B?cHF1UWxwODByMjNXM1l1U0hjelZVYVlodjJwcS9hUktLK01LNzhJQm1jekI5?=
 =?utf-8?B?am0xUW0vNEpOUW1rcVdwUFRNd1UwajdrSWFrdk94QUR5b2kwTmcrYWsrU1JY?=
 =?utf-8?B?M1VFWkthMU50dkdvYU5kQnJuMzlsOWRlRGJiM1lweS9kK3F4TTNhR3VPLzhW?=
 =?utf-8?B?WlFFay9VMEhWTTlrMUR3OWlkdlN1T0dRZzFpSDNScmxsSUlKcG1zZkRGamNL?=
 =?utf-8?B?L0FTZVNXOFdpWXovY3VBajYxWVFnUWpIL0Viazg3QkprNjJVRHZDZGhNeVN3?=
 =?utf-8?B?c2FNWFNwekVlOTl1QkI0MktIRlZheXFRYlg1VHMwNWtUeUF0b1RCZThkM2Vr?=
 =?utf-8?B?NWFqY2cwRmgybHNLZWlzY3NzYTVDVjNRUVZxTGZyeXpFTldzclFpUkZPUVNt?=
 =?utf-8?B?d0NaNUJOUzJQVG83NHVzQUpoVnNKMXI2OXpHaEFEQ3BrZXhsYnVpMDFNUDFJ?=
 =?utf-8?B?akQ2dDBOeFpidmRWL3Yra2ZSVUFHU0UzN2hmOEd0UjFkNU8vcHppUUpXMkhm?=
 =?utf-8?B?S2NyWldqaThwSk9aT0dPN1RwZlBjZU1wc1BtaHVHalQ5b1o0eEx2eXhqZU9Q?=
 =?utf-8?B?cmgyeXlpd1E1T0doK0J0QnZUc1RjZDUvUFNXa3FuNWxSQUZvcjFwaEo4TFdh?=
 =?utf-8?Q?2mLdcA29vmDWqWJPlkF7d330X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da200ee-afd8-4838-c4f5-08dd94c1faeb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 21:38:21.8232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6qQWpkJGFhKx5FIWFgQtlwveiZFot+O1JWIacWaFsyMQyD+IJd5K8VEUYSVpwyc/5Fx0LeyT3yIm0iD0uxsKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815
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

On 5/16/2025 4:31 PM, Pratap Nirujogi wrote:
> ISP is a child device to GFX, and its device specific information
> is not available in ACPI. Adding the 2 GPIO resources required for
> ISP_v4_1_1 in amdgpu_isp driver.
> 
> - GPIO 0 to allow sensor driver to enable and disable sensor module.
> - GPIO 85 to allow ISP driver to enable and disable ISP RGB streaming mode.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
> Changes v2 -> v3:
> 
> * Add NULL check for acpi_device handle in amdgpu_acpi_get_isp4_dev_hid()
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 31 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 31 ++++++++++++++++++++++++
>   3 files changed, 64 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index cc26cf1bd843..2aa7e89a190e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1657,10 +1657,12 @@ static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_cap
>   bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
>   bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
>   void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
> +int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]);
>   #else
>   static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
>   static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
>   static inline void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
> +static int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]) { }
>   #endif
>   
>   void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index b7f8f2ff143d..78441d5f3231 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1551,4 +1551,35 @@ void amdgpu_choose_low_power_state(struct amdgpu_device *adev)
>   		adev->in_s3 = true;
>   }
>   
> +static const struct acpi_device_id isp_sensor_ids[] = {
> +	{ "OMNI5C10" },
> +	{ }
> +};
> +
> +static int isp_match_acpi_device_ids(struct device *dev, const void *data)
> +{
> +	return acpi_match_device(data, dev) ? 1 : 0;
> +}
> +
> +int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN])
> +{
> +	struct acpi_device *acpi_pdev;
> +	struct device *pdev;
> +
> +	pdev = bus_find_device(&platform_bus_type, NULL, isp_sensor_ids,
> +			       isp_match_acpi_device_ids);
> +	if (!pdev)
> +		return -EINVAL;
> +
> +	acpi_pdev = ACPI_COMPANION(pdev);
> +	if (!acpi_pdev)
> +		return -ENODEV;

There's a slight problem here that put_device() isn't called in this 
error path.

Maybe you can use a __free() macro for struct device *pdev?  Otherwise 
you can jump to a label above the put_device() call below.

> +
> +	strscpy(*hid, acpi_device_hid(acpi_pdev));
> +
> +	put_device(pdev);
> +
> +	return 0;
> +}
> +
>   #endif /* CONFIG_SUSPEND */
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> index 69dd92f6e86d..574880d67009 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> @@ -25,6 +25,7 @@
>    *
>    */
>   
> +#include <linux/gpio/machine.h>
>   #include "amdgpu.h"
>   #include "isp_v4_1_1.h"
>   
> @@ -39,15 +40,45 @@ static const unsigned int isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
>   	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
>   };
>   
> +static struct gpiod_lookup_table isp_gpio_table = {
> +	.dev_id = "amd_isp_capture",
> +	.table = {
> +		GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
> +static struct gpiod_lookup_table isp_sensor_gpio_table = {
> +	.dev_id = "i2c-ov05c10",
> +	.table = {
> +		GPIO_LOOKUP("amdisp-pinctrl", 0, "enable", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>   {
>   	struct amdgpu_device *adev = isp->adev;
>   	int idx, int_idx, num_res, r;
> +	u8 isp_dev_hid[ACPI_ID_LEN];
>   	u64 isp_base;
>   
>   	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
>   		return -EINVAL;
>   
> +	r = amdgpu_acpi_get_isp4_dev_hid(&isp_dev_hid);
> +	if (r) {
> +		drm_dbg(&adev->ddev, "Invalid isp platform detected (%d)", r);
> +		/* allow GPU init to progress */
> +		return 0;
> +	}
> +
> +	/* add GPIO resources required for OMNI5C10 sensor */
> +	if (!strcmp("OMNI5C10", isp_dev_hid)) {
> +		gpiod_add_lookup_table(&isp_gpio_table);
> +		gpiod_add_lookup_table(&isp_sensor_gpio_table);
> +	}
> +
>   	isp_base = adev->rmmio_base;
>   
>   	isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);

