Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD88CCFA13
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Nov 2025 19:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1E5210E2F5;
	Mon, 10 Nov 2025 19:22:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xj47YSBi";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8D1310E2F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 19:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8r8x4aQNPCiapNgslLFgPrKNuLzDhOPlW5FY5yQkJ3Mk24v020wV8uQofek1pOs1OiU5X19wIKzsbxGFxBF3DCaNtAnyfw6zDSV01BNMtetEQPgwz+mp+o1yaosG0EGLRY8pVajFEZ9ryz0NVeDa7y9yEw7C31FMgIcr5wnqv68krLF8eghgfpDmZzvp/iWUwpJ+Hw9EqRJSBmTLMxbJuoNcl10gS9myulynUueAG0k7/5rnckq5CHj68fs5cJY34FgN/8KD5O6N3K5RKYDXB9A2th/Apc+BKchObyzgcp2QSham4Z14ki8IicXlP+JTehAGwBxCDBj8MbT/9wY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HGZ6Fn5faWsFG0ENyI2EPfl4yBPz1VTeWTM2MaKdC0=;
 b=wTKLM6RES+g+NXigxd4HYHdRF+lMp8JElY4EY7gZRlPlg3MenVHChUx5MXolzd31nR80xXHjqn7XVOx/PJtJ13SP7LDNoJsGB+VStk7tIVz+hjjp/scLTr4XM1cViFb/g57UU5/F1xoC//M0qfRtlvjOe0gq/Q1p2PnGEp2zbd/L5NuXBZq8+mdMJnRS62PH69UDDsOqwV+qpiCc4MTvn++W5DS0m7ypNk/1vq2/0mKmOKmwIZ3a/r2GcXcOQsfbxXkkF3wVRHQhUfkgyR3QvVTx42u2fKodcm7OmGN1sOQ1ToYJ4SVYLHlpLK8CaXR6d3FPYGSGxrFjvDSx+vvNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HGZ6Fn5faWsFG0ENyI2EPfl4yBPz1VTeWTM2MaKdC0=;
 b=xj47YSBi2M9VzBYwzJ44HbtEK0FZuvEzBrIzYCaSm3wPignQ/my9QVJgCZMU+llwpe+YUHuMkgSa6GmN8DvJqqE401rXpTfYToa2FpV75LPAWSndiqUVQVi7ImEFIkeDFiKF8wPiL5bby8EDCLMoWIsNDwfrrtwm+lM8aK0VDSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 19:22:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 19:22:09 +0000
Message-ID: <ab757720-750f-45ac-9892-c1c5742fcbba@amd.com>
Date: Mon, 10 Nov 2025 20:22:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] drm/amdgpu: Support VCE1 IP block (v4)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
References: <20251107155745.8334-1-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251107155745.8334-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0227.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: ce761475-d465-4779-bca4-08de208e7164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MitQWTNTa2dMOStsTGZ1Y0VScGcyanFLeTBFUTU0ZXZzRzFKUjlYSHJPcmhy?=
 =?utf-8?B?dWk3blNFVHJ5cUNvUHNHK3BlWm1JUFV2R29jeVEwSTlSVlJaWUdmVXN3WjJt?=
 =?utf-8?B?VVFjYUJtYmJ5T0hpVlp4NDMrZFhXZ1RXK3d1Tys3VERKZkl4MHpSQTczT2pV?=
 =?utf-8?B?TUtPckdFVHYxOGNwUlRBY0JZa1JuSUtKTHBRMSttTm1WeG1odGFoUFg4OHE3?=
 =?utf-8?B?dExSTjFnOHFVT0ovekNobmhMWVFTRTJSaXl1c3BsMjcrWmcvYkxpdG10SWRT?=
 =?utf-8?B?NWhSR3VaV3BLd0w2MlpsYW5xUlVjVDFTSk9Yd2NITXpQWnJLMEZwaytKdDMw?=
 =?utf-8?B?MzJraEJ4TVJ5bHhJUjQ2UHJ3Y3d0V2VJVG9YWHdYNk56aGV2S3k5ZzNwVUJG?=
 =?utf-8?B?WUhJUnRqYm9PcUxOZlFpRXRFSHlKckFsRExWSE0xZnZVNCtuemI2bVVCTitv?=
 =?utf-8?B?c1pROENRaTVHdGhGTUZ2YWpXZ2hWUXkvVkxpWlNSQWJUeWIxNkpjaXRCYUJK?=
 =?utf-8?B?cVBZMHJSNExSTVFHQmpydDh3V0lvUUVFQjUxM2ovVk9adlY3ZitDZ0pSbWVM?=
 =?utf-8?B?ajZLc3loT2J2eTcyUE9hYWsrZEJhamdVWmxIQlZQNnRhcTdIQ3Z5ZDZRNmI3?=
 =?utf-8?B?bkY0L0hKVm8wMDNBdm96cTR6dnl2dmhtOHZvaHdaQ1I2ZENPbEpLeU8yVW9k?=
 =?utf-8?B?Yzc0Nm5MUkdldUNUaEtjLzZ2aUpWSUN0RWRYZGVoRkYzcVJHcXRFY2RiYndq?=
 =?utf-8?B?UDdGUnRXZ3VaeDQ2b2V5MHNBYlRoV0RlNE8zNWk1TElrREZTS3B1QWUzN1V3?=
 =?utf-8?B?cC8wcGFEUHRxRE5xaXFlT1JOaUtOcVVqN2V5ckRTcWw1a0VIUnA2Vlh5eUlR?=
 =?utf-8?B?aCtybFhqdm9XMnZYYzBpNmZYMjlDaUkwajAxRzlZUUM1MnRpT0tveUdKREJy?=
 =?utf-8?B?SWQ2R243WTVIV3VxM1pjWWhjT3V4TFNFRTdOcW5jbEorV01LbHFSWmdOV0NE?=
 =?utf-8?B?WHJEek9FczJ5QlAvK3lzWG1LbEhCdTJLc01FT2ZMaVREcGNUUDFEQXNJb1ZJ?=
 =?utf-8?B?VTJMWk4rWmJwTUFpRDRuTThaT056U0IyUXZRU3ZVVkJEVkdRMGNkVWNoY0dk?=
 =?utf-8?B?ZFFoMTlRRUUxMllwcGhRa1Rib2R2QThxaWdiU0NtVWwwdzlJVGpuS1pyV2Rx?=
 =?utf-8?B?SHRDQ1A0aFpKMGNleElrb2IyOTZIbzU3YjNXWkJXYkVObC9GMk9wR2F6bDZp?=
 =?utf-8?B?bWNZa1d4VWI3dlUrY1I0cXp1cTVKZjI2cTVsQThpYTQrQmM3MWtXclp5SkFt?=
 =?utf-8?B?ZDVMS2hsNm1JSTZVaXRwbXJ4dTZRVkJ3ajJVTU0yei9ZdVlLSXJaWFhKRFJV?=
 =?utf-8?B?RHZZWWN5TDVqOENJNThvV1dKWnJXZEV3WStpZXJTNFpNZGJUVWI0RS9nOUMv?=
 =?utf-8?B?L0ZJZTRSL2hyeDg1V0RjRmlKSGZZTW42NER1SHpJaFZvamZhanZtOURuM3N0?=
 =?utf-8?B?YlA1SnkyS2NCcDVKQlhjZ0VJQWJWczZIOFJsMzNBS25Za2dDdHJkWithUlJF?=
 =?utf-8?B?THp3N0pvR2F5ckpNaEtjK2R5MTV4YW1uaHNxRVVyb3huOUpBU1dYN1o2WFpq?=
 =?utf-8?B?UDh2cnpOVmdSNEpWSXlRTm5IbzRBRkJleWxYTnlJVmEyWWdmN3lwellnc3dz?=
 =?utf-8?B?Rk5la3djS1ZaZ2pSN1BMNzZraFlscnVmUWZWN3FBMVFIZFkzOEdjRi9lWlYy?=
 =?utf-8?B?ODlYQS8xMUVSSXJPc1dBNkJPUkJ1WGlLWnZ4ZWNqdG1Yb0x2OERBV05TNVU1?=
 =?utf-8?B?RS9xeHc0SFRFdnpNb1NseERLVytnVnArWmcxN29sTXo1Z21hUVFFRVZxNzJ3?=
 =?utf-8?B?Mzh3ZFduKzJoZUZzYnZUTE9zRkRZeFFyR05BeFJkbDN4aTlyNW5ZVDR1d3do?=
 =?utf-8?Q?aGzt7kGUmaY2dbfooOWzEQKAdwwZrNO+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDgxSUlIWnA0NDNCYlN1UDlQaTdqSkF3dFNBdUhJbmFHQWdlV1ZzYzZlNUly?=
 =?utf-8?B?VUJnZS9SSkxYR3E0VnpHcDhwQnFDSWp6cTdldFV2VitDbVZHcEwzN3VHVGlC?=
 =?utf-8?B?VjJ2WXRzWkt6ck9UNzcrWlJZSFAyM3RnRFQxdERvSnM2S3AxMlFHMHFBekRz?=
 =?utf-8?B?c3E2U21YK2w2c0o5T2pOaVNHTVJRdmhGeUhYeENMZTFtSVFnU2tuM1hYVnFV?=
 =?utf-8?B?Y3pEc3FIRElqd2k2bGJjTCt1ekFoQWMrU2JaZG1aRm8yYy8wdnAyL2RSQk1K?=
 =?utf-8?B?L3h5elZCVjc0SWpZSHhHVC96ZnR5aGJ1NjBxeGFVZjNCcUp5WFAzalVpSVgx?=
 =?utf-8?B?WUFpK3JoaStkYytpRGJYcHBLUDczZUNHSnRWeiszZ2hhemc1bWhubUFXZmVY?=
 =?utf-8?B?QXNnRE94ckk4aVNzeGJiSjJEQ2RHcFh0MjlBMkVvbXpCMm9Dcm9LL0RDc1Zt?=
 =?utf-8?B?c1laQWtiT3BQSDQ0ZWlqeXR0b2ZKWk9JdVJvZGJPb0VTUlJ3WlU0T3Rxa2tX?=
 =?utf-8?B?YUVLT05hYm0vZFl5c3hxQnBmM0FTUkhuZHVVSWxYK3lUdlR3ZWtkR2srOE5k?=
 =?utf-8?B?SHN4aUpWY0hpNkQzemgxZzU0UzFYV01FaDFyVDFQQlFEaWd6cFcxVUVhTkQv?=
 =?utf-8?B?UDdYbDdkbVZVd05sWFBZcjBVZFNMU1pqRTZmVWpNTEV6MnUzdnkwcWdzcU1i?=
 =?utf-8?B?Q3lZTXVvVVcvNERPOGdTcHc3TFJ1MHliWW83N3JXMjQ5MzAwUmlQSU45L29R?=
 =?utf-8?B?S1RCVmFSVy96U1ErMlJRTDZWbU1UOE1yU283amExUmt1cjNRKzhVWERlbTl3?=
 =?utf-8?B?aWkxRExHUnNrMVpTdkRzWkppVGdUK2JWV3A5VjFwZzZPNURCTWdvalhCL0Nk?=
 =?utf-8?B?THI4akR1YXEyaTZ4UTRCMVllbHMydGlwSDExYTRTZW9ZdnV3N1Q0UTREOU82?=
 =?utf-8?B?R1B2L3o3UGhGQWZPUW45S1NTMnhnZW11VVhxYnRJemluMmVmZUFkUXhSWXgy?=
 =?utf-8?B?eFVaeFRqVFZaNW1mWmFmVnBPbHM4cFNZdlRHa01tOEk1SEVVejFBTlAvQi9O?=
 =?utf-8?B?Mk8wVTFJV2s5VHpiVFNrcjdXdG1ncnczREJBMGxNZSt1ZGJuSzcyOHBCaFpP?=
 =?utf-8?B?UHJyV3FFSDFDUkZLR2YvZ1FNY253S3F5Y0VMT1RXdGZtMXd5NkNuNEFDc0Ry?=
 =?utf-8?B?Wm9iR3lIV21Yd1c5ajJFa21nZVI1cENoaWhsbVJjTzdrbXArYThtczIzR2sy?=
 =?utf-8?B?WUxQVWhNeHYyMFprSVV6elVHNlMwZVFDQjY1RXlyZ1orQ1k2YnR2bUhQOXI1?=
 =?utf-8?B?YlV0Q1JGRXJhU1lhVzNaZWNERWZBWmdhR1BkWDQ3OHlqRkdGYmdkQXBZMlN6?=
 =?utf-8?B?Q3B0djZVR1BQbVFTNC9zVnNMQzFWK2ZSZzl6OS9KVjZKY2FicFFiWU5aczUy?=
 =?utf-8?B?eDNPelVyb3Z5K1hUd2xwOENZVWZnS1RHZXJnV2I2OUJrWWRpZFJNZEZyUyt5?=
 =?utf-8?B?T1QvTWpnNzcyb1RUdCt0bjJ6Q0hnNzFLb2NuMEY4SU5OZ291SndGOVN3b0Jw?=
 =?utf-8?B?Z2d6WDFYeVFaRjdtSDd1QmwvdXpYaEdMUVRnTGlicDc5Y0tJeGhhemRXRExt?=
 =?utf-8?B?TGdsZytxSmtZbUU2YTlSdnpUTjNQQ1o4UWhORnM5eGZkbkg4dVA3V3JTbkxp?=
 =?utf-8?B?U3hvYjZ3SGx4SU5MYngzdTA5UFh4czErakFLaFZydThQL3FNSitiNWpRQTNS?=
 =?utf-8?B?Vkk4RlBiTnBmWFY5TURERW1OYzN3MjJjZFZZdm0zYnV2ZDEyQ1VrcWdzUTlC?=
 =?utf-8?B?dXZZQ1Ryc0RFcmh6a0IwRThTSE9pREt3S1VkajEwL3ppZVVib0o2SWJ5TWE1?=
 =?utf-8?B?aEFMd0I4aTR1aUpMSHFUWFdSMmRIRmorNmcxSll2QnFWMnpKdldaR3IxRDZn?=
 =?utf-8?B?Q2FwRnU2aFYyYmZDdVN1Ujc0OTdPOVhDVmx2bVZzNTVzYmFZbDdqRWEzamVM?=
 =?utf-8?B?clN2eG1EbE1sNloxTHhHRys5ZUU3ZlRabmYydElGNjg2djBSdTUrY2RJUWZt?=
 =?utf-8?B?YUNSd29jM3JlQ2NqczlxWmtDN2JTbURwS1E3MDdhcjk4UDdmNTZqQ28vTHhi?=
 =?utf-8?Q?nr392xmq0y4VtXTBYIlcoegDC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce761475-d465-4779-bca4-08de208e7164
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 19:22:09.6686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLKa6xEd0s3RhD03Cv73kIBe88E4v9HHl71Y5bU5c2aIrInyuufLiwnJAftus9gZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749
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

On 11/7/25 16:57, Timur Kristóf wrote:
> VCE1 is the Video Coding Engine 1.0 found in SI GPUs.
> Add support for the VCE1 IP block, which is the last
> missing piece for fully-featured SI support in amdgpu.
> Co-developed by Alexandre Demers.
> 
> This VCE1 implementation is based on:
> VCE2 code in amdgpu
> VCE1 code in radeon
> Research by Alexandre
> Suggestions from Christian
> 
> The biggest challenge was getting the firmware
> validation mechanism to work correctly. Due to
> some limitations in the HW, the VCE1 requires
> the VCPU BO to be located at a low 32-bit address.
> This was achieved by placing the GART in the
> LOW address space and manually mapping the
> VCPU BO in the GART page table.
> 
> Also hook up the VCE1 to the DPM.
> 
> Tested on the following HW:
> Radeon R9 280X (Tahiti)
> Radeon HD 7990 (Tahiti)
> FirePro W9000 (Tahiti)
> Radeon R7 450 (Cape Verde)
> 
> Changes in v2:
> - Refactor the new GART helper to be reusable
> - Reduce reserved GART size from 16 MiB to 2 MiB
> - Clear VCPU BO only on device creation
> - Save VCPU BO on suspend, restore on resume
> - Rework how an empty codec list is handled
> - Add different workaround for FirePro W9000
> - Address all other feedback from the review
> 
> Changes in v3:
> - Drop patch to return empty codec list when VCE is not present,
>   this is actually not needed.
> - Instead of relying on gmc_v6 to set the GART space before GTT,
>   add a new function amdgpu_vce_required_gart_pages() which is
>   called from amdgpu_gtt_mgr_init() directly.
> 
> Changes in v4:
> - Clear VCPU BO on resume like in v1
> - Don't unmap/unreserve BO on resume
> 
> Looking forward to reviews and feedback!

I've just pushed the whole set to amd-staging-drm-next.

There is a slight possibility that the CI system find something (because of patch #4), but I strongly doubt it.

Thanks a lot for taking care of this,
Christian.

> 
> Timur Kristóf (12):
>   drm/amdgpu/gmc6: Place gart at low address range
>   drm/amdgpu/gart: Add helper to bind VRAM pages (v2)
>   drm/amdgpu/ttm: Use GART helper to map VRAM pages (v2)
>   drm/amdgpu/vce: Move firmware load to amdgpu_vce_early_init
>   drm/amdgpu/vce: Clear VCPU BO, don't unmap/unreserve (v4)
>   drm/amdgpu/vce1: Clean up register definitions
>   drm/amdgpu/vce1: Load VCE1 firmware
>   drm/amdgpu/vce1: Implement VCE1 IP block (v2)
>   drm/amdgpu/vce1: Ensure VCPU BO is in lower 32-bit address space (v3)
>   drm/amd/pm/si: Hook up VCE1 to SI DPM
>   drm/amdgpu/vce1: Enable VCE1 on Tahiti, Pitcairn, Cape Verde GPUs
>   drm/amdgpu/vce1: Workaround PLL timeout on FirePro W9000
> 
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      |  36 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h      |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  12 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       | 174 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h       |   3 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   2 +-
>  drivers/gpu/drm/amd/amdgpu/si.c               |  22 +-
>  drivers/gpu/drm/amd/amdgpu/sid.h              |  40 -
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         | 839 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.h         |  32 +
>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   5 +
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   5 +
>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |   5 +
>  .../drm/amd/include/asic_reg/vce/vce_1_0_d.h  |   5 +
>  .../include/asic_reg/vce/vce_1_0_sh_mask.h    |  10 +
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  18 +-
>  18 files changed, 1080 insertions(+), 134 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.h
> 

