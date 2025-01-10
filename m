Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06302E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 19:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7F1B10F177;
	Fri, 10 Jan 2025 19:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wrHVWnC9";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 029D510F177
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 19:05:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFNVw68cZQ+vWv5VC4y7VDO3zlHTrfzW2IyKZZZ66iqHKrKoRsZWG2DxMY+NosToBK+XZ83LGujhEJrLjrqdwt+6/r4dasChQ3Ub1P0DAuKmdinBCPpUwSAz7WEQBQonmkrGQpM3TnFiTex0wKqnzo12OfIAOIax03ky8k/R42gnagmQaMfE5fdl1GMjhXVoFHR7v2wpyLldYp8pZ1XsTHQ7SGVFLKlnsUdVRgl6H9RT4hdPSIhiajZ/+VrSXvRzW8M/V0ODpPJx5j/IivFQWdo7n/B+JJuPwLVxjjw9bcxQ6VIYJD6ythDE8ylnUiAIkPNCcAL8adbAfM14o+nr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXDw+Zffu2yeKunht9XMqYhbPvDRUWJDvJiXFCA9apg=;
 b=XbBEtFTnl3opZ04Lw1GLDn7pg5dB9IzPgyr0fpM6qyCcPEUWVzI0PhS3cObUZiTkZdWJoeoFYyYY/E4j7FuUYuIndOG7OYXl1qDchll4ecy4kUgx2Znr9GQv5Orm0BQ+Sl8J1iQ1FqMIVBSHi73u++izPpWZyEp6EyLjH6Xn9JBGOHuMPZXCnk/YwQpnSHIb/08CCoGWM0xB3Xozr+QmHb2JFyvtcJtexuB2k9NFZ1wyYn9qkx9MpylHRjhiZkt9Hk30pYnD8xzjJvB0U1InTjYjITLNHKndb8CSpxYO2l2bagG2aSH7gWnUGaY6ggcMQfHtXIRg5EpgpY0M3q26FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXDw+Zffu2yeKunht9XMqYhbPvDRUWJDvJiXFCA9apg=;
 b=wrHVWnC9w4/iFHZWigez0+n+yY8pOzkpgkIwgFeseOTbVeXyr0/w4+/4I/E4G0HePQHIoi/ge7QEIHQRGURKiFn6riw08fWynRHiIMMIj9SL3SFIMLmAF/2TsMzN6cRQDUcK3o99QNT+T3Ov3jrfFU0Ie4YWK6iTOQD6cwKdLDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 19:05:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 19:05:06 +0000
Message-ID: <541bc316-ae05-4e6c-9c69-8838e5f87370@amd.com>
Date: Fri, 10 Jan 2025 13:05:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 4/5] drm/amdgpu: enhance error handling in function
 amdgpu_pci_probe()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736474822.git.gerry@linux.alibaba.com>
 <ae5fe482d1310c5006384a6ec55438f6d31acadc.1736474822.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ae5fe482d1310c5006384a6ec55438f6d31acadc.1736474822.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:806:130::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: e75d2cb0-a96f-4f38-eee7-08dd31a9b247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZCtmRzF1VGdmSG8weVpuamR4Y1NVakJ1amRRZWRITys1ZGxrU1JWWGV6Q255?=
 =?utf-8?B?UnkrSXkwdnY2b0pBTXJVMVlJWGUzNlIyTWd6dTF4RFNVVk1oalc3SklTVFJx?=
 =?utf-8?B?OWg3TGR4RzhjamR5cU03Rm9RWUxtWGtwUTFaa1dXU2RVRklOZHBUazJ4QWNu?=
 =?utf-8?B?VjBUY1IxcEZVM0dJUFFMbGYrMG1CenFha3cxQllTejg3bm5WV2dESmZiNGM4?=
 =?utf-8?B?NS8yUGNFYzRpUW84UXp4VEtpd294d3JsL1RheU5tUVRMcW1jKytyVUNxMUM5?=
 =?utf-8?B?bnJjSlRiL09mdjgrLzlxU3hZNXF0cTJxRmd0NGJ3bGZiNW5WTUVNNHhzclA3?=
 =?utf-8?B?azlPTXB6ZEo1TUsxaVJIRFM0Z2ZRaFR0dldLNzdPbm01QTBmWEtxN2s2UEpv?=
 =?utf-8?B?SFAzWEZ2aVBINlJpNGg4SzVQSkoxU1dpODk4cEplMHlZcVpFSkkrTWtvSkZX?=
 =?utf-8?B?ZXgwYkliY0w5OVpnWWtnY0s2YnkvekhkT21Mb0hDNWZHSy9UellIMjhtL3ZI?=
 =?utf-8?B?clpTeEtaaHRhbDdJaE56QnRwK0MwKzBuQnZkWXo4NG9VTDJhaElKU2dJOHZW?=
 =?utf-8?B?Qnd0dlA5RTArSG1jVEMzOU5XQ0hJMjQwejFxTTBZM05lUmozbFZhQkZpaVZr?=
 =?utf-8?B?K2k4MFNkbE1vQkdLc0JCMlBldFA1dEdBNnVLcklYVU1VZ21vbVk4V2FCejV0?=
 =?utf-8?B?M1pQTnZHNHI3d2JZWnJaejNrUmdyVi9ZOFI0UUUrVnduUFMwSEtMdkdPM3ZL?=
 =?utf-8?B?ZG1kZGZxNFVEMk5CRUg1MU96SVNoTk1IT2NCbHYrT2tCd0xRU3RTaE5GV2Za?=
 =?utf-8?B?aDNpWGF3ZTMrdldHKzZvZGZseVBkRDVSWFBIS0doRENsVURjWEdxVWxpVnM2?=
 =?utf-8?B?VUR5OGM2eDljbjIzUm1hWXdYUGJtOUVxeGJ4dFVVcXQzazRRcE9UbVJYZDJO?=
 =?utf-8?B?bXhPWjhuejdZakhCaE1nYmtlTzdPeTlUUlppbytDbEw2SzJ2Q1lGekNLbk1K?=
 =?utf-8?B?S3BjOFB3dmU0ZWhoT0RpNGZUd2F4Nys5UjJLdjFrYUppWXNCQTBxYXdOZHMr?=
 =?utf-8?B?VUhSd00vbFNrd2U2QklZOHZpbVZ3SHZicEwya3ZmNm1KbHVWWUUxaENrOU9s?=
 =?utf-8?B?OHpZSzNuYVZabDQwQXQwT09JT09abFIzbHNVaW5QbERwS3MxVDBDTFlDREJ6?=
 =?utf-8?B?dVo2ZVBmc1hTUU1kbGwyL2ZoK2ZjSTQrRFhwRGEvbUxpU1NPZ3AzVWQrbE81?=
 =?utf-8?B?UGlwWWhMS0hNT0tXRjN2YnJxd1RVQUFhNzhEU2QxNXFPRks5WmFqNjJRVVNV?=
 =?utf-8?B?M1E3SEdqd2IvVXErMGt3Yk13U1puY1c4QjJNWFk4NjB2RVFrNDFhNm5FUjVh?=
 =?utf-8?B?dUJSN0ZjNkNONld1ejcrejAxR09VMEJUNWc3SER4VzhzK0ZtZDBjTUt1MUxt?=
 =?utf-8?B?d1BaelB0VTE4cDJiMmxqNmQ2bjB6U3JzTGJabzE4N3NlMmFQb2w2WWI4STYy?=
 =?utf-8?B?V3VkTEgyU2laMUVuYkx1SXpHWGY3enFTaFR3RGR0SEFlcTFlc0Q5UThlcWpF?=
 =?utf-8?B?NDlBWjdianQxQWRMOWpaUWNLc0JsSHp2c1NYKzA3bDVlV0JFaklncDBSNjVD?=
 =?utf-8?B?Z2JlV2pSdzFOVWMvYVdtQWRtMzAwaW9LYVdDVmlha1V3NFVCZ0tWRTllOEVN?=
 =?utf-8?B?bU4yNnRTNFpveklFTFdXUWZKNVcwUU1RWDdtNDIrelVCcTB5KzkyajNnVUhz?=
 =?utf-8?B?eE9MQ3dUZlBJeDRTd1ZVQ1FUWTlsLzdxNmFtYUJMSHN0Sy8vOEdJMjlKa25i?=
 =?utf-8?B?Z2w3c0YyTFlHVWEra3VzNXFodDFWeUR1STZwOFd2SEFrOWhxZUl0Njd5WVFw?=
 =?utf-8?B?bVg2YVFIUUhNamFlbnNaRGdSMnBYYlFndVhXSVpDWjdPcFJzUERxNTZjWUho?=
 =?utf-8?Q?s8fxe3lGAfM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXRQWFZaTC9CZ1lJZjE1cldCdnpua3B4L0FqaXNXb1Q4SUNZL2VWNm1VK1hZ?=
 =?utf-8?B?YU5YOG5mZnJTUlJNNDdKRjhBaDR2QnlrUlB5cUJ1WUdaV214eDgrdnRZY3JC?=
 =?utf-8?B?QkpzUUxQemlrUU9VZ1BjaFRCY3J0cFVLam9lRFpIZ1lRa1ZSQ2hRbjRrK2t3?=
 =?utf-8?B?bWlpTWpxQ3E1S0FnQ0hxWEtoR1FQZUlDa28zdHZVUm1wcGx0bUYvMmQwSUpx?=
 =?utf-8?B?N0FIU1VYREU4eW44OUp5TVlDWEJJOGtGL2o2enRqc1BMZ01Yb1VGdmtyb29x?=
 =?utf-8?B?QVRkdEVJQTBnb2c1bEZQVjltanptZml2UklPMmpXWElLN0grQkZOVW1HSWl2?=
 =?utf-8?B?VHJDUEtFaGxkYUdCYWJyc1NmOTNaTTg5cnJtWUFoaEo0QWpmdVppd1hDQWpR?=
 =?utf-8?B?Tldvc0FJb1B1R0dHeVU1b2N2d1J4b09CSzA0N3E4Vytoeno2OHpuU3BWeC96?=
 =?utf-8?B?NmhtbkJnb1dvVDM4cEI3amFYWEJVbytFR1RSVElENkJNRE55QlJtREUxMDJi?=
 =?utf-8?B?eFYrQ3VvcGhIdHNkdm5NUS82bWJKSlpqZ25ITTRFWEF5WDRSTUZaY3VFempw?=
 =?utf-8?B?ZTlyOUZ5dlpkeVVWTVhUQzF2cysrTjJNZzc4OTJsTmk0ZWJiUmFCUVZGcUhp?=
 =?utf-8?B?S0RaS0ZmRGtaVmFCbVY3Uk9qdktkVlAxMkk3UzRXRUowdnZUdEhFOE83N3J1?=
 =?utf-8?B?bnBPYTFhNlZxQmlhb2lGSGpqM05oZDFpbGlhRElHNXdkSGpwai9wS3VFOVVh?=
 =?utf-8?B?eHNSYTlmVVVNNDRHaXFzbEV2VUJjdVA1cVFXR1pYQTgzVGVmUXZmMDZPUDFY?=
 =?utf-8?B?Q2NFMEMxUHdnT3NKZ0tYRmJUWU5sUGUxZUR1OXJtQ3cxZk8vbUVTeEUxa2Zr?=
 =?utf-8?B?K1FjVnZvWnlnZXI0YW13V0kraHpmTkhDLzdpQ3ZSKzhMU1QzeFFqcVZ4L2Z3?=
 =?utf-8?B?bjNUZ2pnbm9SS3cwMHVEUGZvN0psQmZabmZBd2YvQnkwYlBqNHJwbndvQUpM?=
 =?utf-8?B?OU5PVXA3cHp4eEVSQ0hnSWI0aWxOcXU5SzZUelJuNlEyWVE3ZU15RTI4SEF6?=
 =?utf-8?B?QzNWaUZRbXhEVDd2M0Nvek9oN252d2VDbkgzdFZHSC9zT3JIVGdXSWU5b0o3?=
 =?utf-8?B?Q2VKaHNNN1cwUHNHSk9IbXQrRzJEMjB1MjJrdXgveFRHWjRXZUVYT2Q5Yy9T?=
 =?utf-8?B?VHdFN0NUVFEyZk4veWVLU1A5ZVliOXJUa3R4WmE5aGdLMFhmZlVMK2pPZ1J6?=
 =?utf-8?B?VFBUZjhvT21NSEhZQW8wMjNiMFN3UlcxOUZoUjF5SzJ2c0wyS2Z4aEtSSllh?=
 =?utf-8?B?Y1oydmJTRGZyOWl2QnNLMzFyTUhaUHlHOTZ0czNrVzIrRGI5V0hLakpNcmFl?=
 =?utf-8?B?blUrVEVGcDJLT0R1MS9teHMzNHpQVXlWRjJOZVlYSlRhNHZrT0dOeG4zdG5n?=
 =?utf-8?B?c08wenFweUF4SE9XYXJENVNGdGljeDVjazFlZ0FrK25FRG1yMjZGdHFtNVdG?=
 =?utf-8?B?V0tFeU9Fa2lPbGJrM3EyakJBeFRUUmpVeHhNRW1BbWJYR0xRNmV6dFNlc1Vs?=
 =?utf-8?B?TURnNHNmWUIvclYyY28rWldiTjc2SzgrQVE2cVBqTjVhNFJyNWcxT0pYcEZC?=
 =?utf-8?B?VGZWWXorS0ZJdWVaTlg1ZGdwWk8yeXFkT3hzUTVwOWZYVVJWNS9WVU41dytL?=
 =?utf-8?B?WEk4V0xmQVRRTDNxVDd1OGRLQVJsOG5JZGRWb2ZsRWZ4c0I4LzdGWXVZNlBE?=
 =?utf-8?B?MjlpOTMvSXBQdkhjam9xWFZURW45N3RvUjErVk5JQ1dPTGc1Rkk2bjY2WnQ2?=
 =?utf-8?B?MUxYQlA2ZmNtajNEUDVnRkxzWTBUVkYzaG9kZ1lQR3RIMGNYNEthNW93WnVC?=
 =?utf-8?B?N05GcVpXMTN6VkZGY2JhczBQM3FPN0Uzam92K3dWRGdmMXk5czVuUi9zQUFa?=
 =?utf-8?B?MDhrcFRVQmhoeUdzbHAvNVVrYjg4dmNDMHQwUkpUanpyK3VzckRZb2FUVG4w?=
 =?utf-8?B?d29Dejk3Z1RKaGpYaVV0UmR5djFLNUtoMGFtY2s1emhQYURGamYvNVJYZTRD?=
 =?utf-8?B?NmVUNmVJZktYUDYvMTRVUkZZZnFEV3RWTVVJbDhtSzUzM1JEUTkxeGtoMVV4?=
 =?utf-8?Q?bT18M+quQYhXKsZ75A2H59E/4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75d2cb0-a96f-4f38-eee7-08dd31a9b247
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 19:05:06.8111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XK2CdB7QaS9G9rYJlv7A2k4unQnohoj06BXtlkWrQfiT0JWQHbwCXTZyhaEe/TsRrYNDEcjn7yVLcTq4cV7wqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345
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

On 1/9/2025 20:08, Jiang Liu wrote:
> Enhance error handling in function amdgpu_pci_probe() to avoid
> possible resource leakage.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 41d1b06be600..f8deca2f2696 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2346,16 +2346,16 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   		msleep(5000);
>   		goto retry_init;
>   	} else if (ret) {
> -		goto err_pci;
> +		goto unload_kms;
>   	}
>   
>   	ret = amdgpu_xcp_dev_register(adev, ent);
>   	if (ret)
> -		goto err_pci;
> +		goto unplug_drm;
>   
>   	ret = amdgpu_amdkfd_drm_client_create(adev);
>   	if (ret)
> -		goto err_pci;
> +		goto deregister_xcp;
>   
>   	/*
>   	 * 1. don't init fbdev on hw without DCE
> @@ -2424,6 +2424,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   
>   	return 0;
>   
> +deregister_xcp:
> +	amdgpu_xcp_dev_deregister(adev);
> +unplug_drm:
> +	drm_dev_unplug(ddev);
> +unload_kms:
> +	amdgpu_driver_unload_kms(ddev);
>   err_pci:
>   	pci_disable_device(pdev);
>   	return ret;

