Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D32D1A616
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 13:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B4410E8B3;
	Fri,  9 Jan 2026 13:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Js1Ku9sk";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C41B410E8B3
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 13:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMniJK6dBjPmFt9NnG+MJB7Y0pl2gmzfU+Lyf7fLeYfo3Y8r2wropou7sEEXG55sorSoLrexosCmkgQ8syVU57vpzrH7yax3rvu7IuYdJ0Tr6iCxpKfQ0uY4C+HV93fAoumyfHFPKLm37iRQITX7xGJm54MeVt397UR+N3JoHw9qvj8hT8yBdqqeM4Q/OaNqIKFsMV2w71yNpRDC7phkAtsC4PWbLx0sIRjWNBpvuW5A6JTd8q8kwMGyBmEoZrMWLY18h9ag3gLWazl8x3lPfxbSdzTZRB60/haIcOjZYM9iwl5Ql2Xea1WMH0kqXIV7JhGZSXGBMB5LizUY0fi3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+kVBoIMjvlzWs2CkpXcsVAWjVbUDeXIIaoO3i7Kmfk=;
 b=qu8DxikUBWM/bHAqpzcT+kYzfvoSXi/0dHHpfqQ7+w959bDMU5cfb2HqWPcC54+FaN6YlNHMwk1prsYUIIG3w2m9xJRb3udI7jY3q5ld8GSwKZxznU76ui0lrxUUO1MG5/Y0NOxzdsLVOfrz/zi/+G08HUrnRkkvIH5Ryla0bkE71wyMm2On9bldLEFNV5i9c7RokmXyv45cYOMXQ0Q7sBs3tD9ZDS7tuJUdFrB+Zap61iLdX8LQzSLvxsWQisMx6tEh4NAwxR1DbNjalLmA4P8UXihEZK9ndDUrEgQ1Pk6fzPMnwFnTK3q49WA5FgsIcCoyJhjJMKGhgn5LyAzVRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+kVBoIMjvlzWs2CkpXcsVAWjVbUDeXIIaoO3i7Kmfk=;
 b=Js1Ku9sku8t/1jYGLOf89XBjj79G9WHzitbih4mwNbaFQ1DGP+N4rcHgnaWxCOJu6Z8VeNyYQF37ds+7YICYjXbRw6bi1TB+nOsHhTpVpZExtQv49bn3VotY3sOysV5QuNSKdyS7RXhGBTU4tyPYL2CsJNzRz/PZNGHKojRxZ/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::623) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 13:00:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 13:00:36 +0000
Message-ID: <1fc87504-0280-486a-873b-c87ac2f4eff5@amd.com>
Date: Fri, 9 Jan 2026 14:00:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling
 Last Fence Update and Timeline Management v5
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260109123425.95712-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260109123425.95712-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::14)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: f72459e3-870d-4791-6d0d-08de4f7f1492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmlpa1dxd2w4VGl1WlQ1TVd4SDhqTkkyQ2Z3QXR1dVVrRlFZTFRZbjcwaTZ0?=
 =?utf-8?B?a2hNclpIdktuYnpVdExOQVZ6T2VRWkVhNkdNQWJWaXZWblY4eE0vN1JHQld5?=
 =?utf-8?B?emJEY1BObys1UmM3RVJQYnFReXdZcytKNTZ0R3haWjF6UFFxV05TVjdFd1Bn?=
 =?utf-8?B?NE9KK3d5MnpkMHhId0lOMkhicTR1TnVMbjZGaVJOd2NxRnlTQkNVa3NXUlcv?=
 =?utf-8?B?cllwVEprMGdVYmZhZzRSTXBUMnlWZHlBLzJ0QldicHVvbmhZZEIwSlMvRkx3?=
 =?utf-8?B?ekhtTEY0K3ZmM21hNTVnR2hBWXhJVi9yMWxUK2o4VHBPeVZTZ09UdW91aWd5?=
 =?utf-8?B?aHE4R1VPN3ZlRnpJNTRLNmU1UVphRVYxQUdjVWZ6MlIxaElhUVdDVm9SNy9U?=
 =?utf-8?B?MThiL0dGNVUvWDRHbllHNlZJWlR6NllBaEZxaStQaEY5TjU1K3JlRFUxUS9i?=
 =?utf-8?B?Um4ySTU2SUxOY1MwdXVQeU5URzRQQ0U5VkVzeC80U2FDZ1BRWWpJWTBLa2N3?=
 =?utf-8?B?czBLa0hERFkwVXB1S0NYUVY3djFLcko5d3cyYTBLK293S2UxOE5jdFhZS3BT?=
 =?utf-8?B?WlczKytmeTI1UHdJamlKWjVOWnR0a0lPdmp2Y1RjWkc3NDYyRERmMmF5WFdD?=
 =?utf-8?B?KytDdXRPeUFnSmp0SUw3MjV5aEhlUUtkMDVzRTE4NmlJOE5udE1iMnMvUGY3?=
 =?utf-8?B?SGxKV2VnYWNlS0M2dytoaGFEWTN5VU9NbjlLT1p6d1YvVitEaXFaajNXTE44?=
 =?utf-8?B?anpEZUt5VDk0bE50Zlk1UTVvTThTR28zTkF2eE96THpXUzV5TzVqL2RnWVFG?=
 =?utf-8?B?L0Q3SnRWZ2JFQWNkL0RnR1l2WUdpYkdvVGtHOVV1VHlXcjl3WG14NUdlT3pL?=
 =?utf-8?B?Z3dhL1JzUFh5V0F3YkJZdG1SeFFmL1VKZ3BERjMwYWNDVzl5SU8rcUdMZ3gx?=
 =?utf-8?B?V2ZTN3R5RmUwbXRoUXlJRzdZa0doSmRvNWJhZnlQK0FHZjFVcHNCOVh2T0Nv?=
 =?utf-8?B?bFBYaFQzNWxxcXhRWGhrejFSM0dHSFBkOWdYVVU5RUQzRUVXMkJZZHpndmJ3?=
 =?utf-8?B?Z0RXWktoNU9oc1RIMkl1cWZYcVFRZ1lmaWVzNEsxbFR2aXdsbDZMTHNhWmZi?=
 =?utf-8?B?ZVpuUlpqeHExVGozS2JNTjg0amI2ZDgwVEhVd2JmSzRRUmM5dFlBbFBNdlFH?=
 =?utf-8?B?bDh4ZDNEQnR5ZUYrSGFYVGs4N2swL2FJZHJ4VlY4K0Q3ZG16aUtEcDRTRk1t?=
 =?utf-8?B?L0ZUOXdLcm5KU1gwaThTend1Z1dTV2wrUFNnMG9LZWc1M2Y5RVRHQ0VJNGRJ?=
 =?utf-8?B?WFh4VUdKL2VyU0syWHU4Vy9uUE1LNzdWQk5Tc2ltbDRSREgwL3hGaWwzZFVy?=
 =?utf-8?B?MlZKRkZoQkJJRnZucmJNNWVIZmJCcmdHbUpwbTBBWGVZRy9lU1NoT2gyS0Jl?=
 =?utf-8?B?ZXBlY2ZJdFFWeEJsMldTSEd2bFV6N1ZJMUREdkF1a01KVURERGdqUThRUm5Y?=
 =?utf-8?B?UmdnRFdzekY0VnN0WGx2UllvdXlGU0JkSGVpOVUyYThRSkFhUmkyQ0p2NHQr?=
 =?utf-8?B?RHREaUhBdEJMUkdkQlVlUXk0eG5LUmpuZXZiRDZWWDcrS2J0QlBCeTFwQzg1?=
 =?utf-8?B?Yng0cmpPenpxNHE3c21CVTRwbjhueEp5SFRNQ1NMN1FFRDRpL1lXL2VpZlRX?=
 =?utf-8?B?enBiVE5heTcwekxlZ25mZXNUTlVOMUl6am8zb0t6dHRJTW1WbkFQekkwc0tH?=
 =?utf-8?B?WEZDdzY5MjMvU3RyRHZIOWZhdGs1K3RGb081ZHpFb1JjR2JlRWM4QUJvRzJv?=
 =?utf-8?B?Rmt5MlJmYlYxaElxMmcreTRLK0VXK2hpV0pVeUtYaG1vMVJKZVEySVhDL0l0?=
 =?utf-8?B?QVR0cnkzUWhLTS9IcWx6SktraHllY1lveVh1ck55Z3A1Z0FUUko3Y0MxSjA3?=
 =?utf-8?Q?v0fMh7m6Ro6YZ6xxAt1vB7FhW4U3FMTh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3IxSWx5NEFOZEswbmMycDZKay9wTWNKSEUxbHRGbDRWUE5XWkRDai9NV09X?=
 =?utf-8?B?L1lYejhuQWhTb3NEV21yM01qSGlzcUdwd2JndjRCOUd5SXVCZFF5K1RsOXFD?=
 =?utf-8?B?b215WG9sL3hnb05Yb3ZZYlAwVmUzVytaM3BneU9rYUdqRm9lU1hNQ0pJa09O?=
 =?utf-8?B?ZmVsdUxqQVh2UkQzU0Evb1MwOEE0NGMzUFBVVTgzVWM5aCtSUnFBM3RiUjN3?=
 =?utf-8?B?Q2xoMmdSb29GeVZ1Skw0aklCTkExc0lYR2lCSk44RktkMXptQTlneEpnRVFW?=
 =?utf-8?B?cEZmYmRlcW9TRU84Ky9SZURlMjB5TFNURk1aM1VMOTNtZENhNTJmVzdvVXRk?=
 =?utf-8?B?bXZqbG1HeVhrcmxTS0s3SHUyZHJ2REkvc2x1ZnFUMGNnN3N3bm5wbFREekFK?=
 =?utf-8?B?ZlJBRFBIdzMrN3NXUk5wZWRiQW1taGFlRDlQU3dUMVhCaXRtS0QxSFg0WlA5?=
 =?utf-8?B?c3o0a3NBRW9VRmVnUkQyVlQ0NFUwVFQ3Z1A3VTFyOTB6N1BzZG1BeHRKM0lG?=
 =?utf-8?B?SVdMamU4bmRjYnRQU2RpZDdiMUJsa2xxcEo5eHora3RYRFJVVGQyN1Zvc2V1?=
 =?utf-8?B?NzkrbVMzMm5JRWhJY01rcTFmTTJ6c2pYVXQ5K3dQVDNSVjUwMVNhdE1UTkFN?=
 =?utf-8?B?T0h5UnkzbWFGbUt4OWNOOVVjQXFySWhWeWVPemlJMDNtTmZtK1N3ZFdkMU8x?=
 =?utf-8?B?VHpYcW04WmhQdWx1SmkxanBQbDFOb2FtdXVwbVc5RmpTbTg0N0pjRWxpVnZv?=
 =?utf-8?B?NlY0NGpYZFBCS2VNYTh2Zm1PSFNldGxSTXJ4eXhjWkhmR1JnQmhTalNTbVc5?=
 =?utf-8?B?U2xBL2ZwQ3pFMVAzT0x4K0NQVjM2YXRTNFlDMlR4OXU1Q2ZkNFBERXpRclUr?=
 =?utf-8?B?N2ZidnBqQWt0U3VGeHVGWGJRSXdOZ2tCMmhMQko1aDlhUWV6cjg4aURmNmda?=
 =?utf-8?B?TnkvM1BrTkR0WmNncE40MklxUmdPdGhBZGtna2RualZMUllSaC9kaDZ4cnNB?=
 =?utf-8?B?QTJ4UFlDZzVBUHpKN2NoMTBZcFl5elJSSlFRamRpVVY1S0k2M29FWGRvbU5T?=
 =?utf-8?B?blVKbjFHNStRdzNINEFNNW82QzlyQmo2TVF4elo3OE10cms5aDhCYlJOaHo5?=
 =?utf-8?B?MWpmRVRWeGd0SzhIdnp4SVNPallFWnJ0TVE1Sk15ZVlLeC9EL3V4TVp3bmw0?=
 =?utf-8?B?UkVVbm1VRkpueEtmWll2eFArejFWYUllcEl2M1BwdzZoLzVNajZvRURFODlZ?=
 =?utf-8?B?RjVtOXQraTRraEpuZkY1VzVjOHNITkE4WGZkZ2pGd0xhTnJBSTRJNVZ6SE9E?=
 =?utf-8?B?RC9udkxSdEQ0VWU3L3VPdGZTUUxzOG8vb0RnTklKSVh2bHQyb1BJREEvMEZH?=
 =?utf-8?B?Q2NVM01vZUF1ekxGRXJsNUx6ejIrOTZsak1zMEw0UVltbC9pUEx0ODFsR2Z1?=
 =?utf-8?B?R0s4NHY2Mi9KeHBmY2o3Y0trS0tWVzJhR3dqUDIxS3A3Z0pHQThUQi84ZFdC?=
 =?utf-8?B?SUFPbDQ3T1RJQWN6VnBCdWkzKzFhNGdJcjA0ZklucVNUdlpUeTFiRVlabUZm?=
 =?utf-8?B?djVZYVVVcXdROWR5R2l6VlpGeHVCWFhISmZ3NWVDNmdPYWdwS0NzTjlsc050?=
 =?utf-8?B?WlVmZHE2SkxFcTZHYStHUFlRd1V6SGFkNWpUN2JoeTR5Ujl0TFpJZkxFYmJz?=
 =?utf-8?B?TnFnNFBndzlyY21VL0p0SlBNMEFkaEMydkpIVlRmS0RPeWcwbzBKNnRBSVJS?=
 =?utf-8?B?UlV0L1JLSmVLRnliR3ZzN2lFZkdTdzdKS1VmNVJ4SExaUUoxNUFyemhOMlpF?=
 =?utf-8?B?bWFSSDJKTlh3dkVnN3UwMVFxYmR3dDlCZm0rZ21OUUQwRU9ZOThLYTVsNC9j?=
 =?utf-8?B?WU1jQmpWWUJEanpoQTdEZzNHbENaa0xMR0FpUjN6L3M4dVFOOEJITnNaSG5t?=
 =?utf-8?B?WXhjSzNtclFZVHlJRURYVEx2elB2NGRoeE9FMVpZeE84Sm5xSm1IY1E5YTh2?=
 =?utf-8?B?OGk2dGJzMkxySjZTRnByZ0Rmci9HTkE4R2FyZHpYV29EZkUyTGFLeFljZ1Q4?=
 =?utf-8?B?S2U0cFlRYThmY2xtSFJGbkJVUFF6bEdDWndtUWRlTUFXUzN3ZDhIOGlHRlBm?=
 =?utf-8?B?ejMwWTdjWEhVcUcvOUoyTGJPOUxiRDhoM2FWZzg3bEpyblpzVVlFc1lpSzFm?=
 =?utf-8?B?em02TVBTbmxYNExGUXRCRTZGS2RiUDI4bURPeDM2dXU0MlNtK0tDalNEekRu?=
 =?utf-8?B?dndPZ0RFVzArc1Q2eURvY2grdDhRdWt2TGdKUmJYS0cyVkNra0FPZGVEcHVX?=
 =?utf-8?Q?pQXPHsVXQNAL6WLXEN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72459e3-870d-4791-6d0d-08de4f7f1492
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 13:00:35.8983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xB80peTpH9nlZqH1J9wTm1Z6jDyOkPvd5HbBoNV+5zHhj5UY6ZEKJLcCaXzbfnxY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1
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

On 1/9/26 13:34, Srinivasan Shanmugam wrote:
> When GPU memory mappings are updated, the driver returns a fence so
> userspace knows when the update is finished.
> 
> The previous refactor could pick the wrong fence or rely on checks that
> are not safe for GPU mappings that stay valid even when memory is
> missing. In some cases this could return an invalid fence or cause fence
> reference counting problems.
> 
> Fix this by:
> - Always returning a valid fence (using a stub fence if no real work ran).
> - Using the VM-level fence for always-valid / PRT mappings.
> - Using the per-BO fence for normal MAP and REPLACE operations.
> - Using the clear-freed fence for UNMAP and CLEAR operations.
> - Making sure fence references are always properly released.
> 
> This makes VM timeline fences correct and prevents crashes caused by
> incorrect fence handling.
> 
> Fixes: 463b33e780ae ("drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling Last Fence Update and Timeline Management v4")
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 84 ++++++++++++++++---------
>  1 file changed, 55 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index f387e47541fc..2a685db91b7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -730,13 +730,28 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  			uint32_t operation)
>  {
>  	struct dma_fence *clear_fence = dma_fence_get_stub();

Instead of the stub fence use dma_fence_get(vm->last_pt_update) here.

> -	struct dma_fence *last_update = NULL;
> -	int r;
> +	struct dma_fence *last_update;
> +	int r = 0;
> +
> +	/*
> +	 * Always return a valid fence.
> +	 *
> +	 * A fence signals completion of VM work. If no real GPU work was needed,
> +	 * return a stub fence instead of NULL.
> +	 *
> +	 * This prevents callers from seeing an invalid or uninitialized fence.
> +	 */
> +	last_update = dma_fence_get(clear_fence);

It would probably be simpler/cleaner to have only one fence variable in this function.

>  
>  	if (!amdgpu_vm_ready(vm))
> -		return clear_fence;
> +		goto out;
>  
> -	/* First clear freed BOs and get a fence for that work, if any. */
> +	/*
> +	 * First clean up any freed GPU mappings.
> +	 *
> +	 * This may return a real fence if GPU work was scheduled.
> +	 * If there is nothing to do, it stays as a stub fence.
> +	 */
>  	r = amdgpu_vm_clear_freed(adev, vm, &clear_fence);
>  	if (r)
>  		goto error;
> @@ -757,33 +772,42 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  	/*
>  	 * Decide which fence represents the "last update" for this VM/BO:
>  	 *
> -	 * - For MAP/REPLACE we want the PT update fence, which is tracked as
> -	 *   either vm->last_update (for always-valid BOs) or bo_va->last_pt_update
> -	 *   (for per-BO updates).
> +	 * UNMAP/CLEAR:
> +	 *   The fence returned by amdgpu_vm_clear_freed() covers the page table
> +	 *   work for removing mappings.

That is actually not correct. For clear it is possible that we don't have to clear anything and so just need to return the original vm->last_pt_update.

> +	 *
> +	 * MAP/REPLACE:
> +	 *   - For always-valid / PRT mappings, vm->last_update is the correct
> +	 *     fence to export.
> +	 *   - Otherwise, bo_va->last_pt_update is the correct per-BO fence.
>  	 *
> -	 * - For UNMAP/CLEAR we rely on the fence returned by
> -	 *   amdgpu_vm_clear_freed(), which already covers the page table work
> -	 *   for the removed mappings.
> +	 * Note (review): vm->last_update and bo_va->last_pt_update are
> +	 * stub-initialized and not expected to be NULL. We avoid redundant
> +	 * NULL checks and ensure last_update is never NULL by construction.
>  	 */
>  	switch (operation) {
>  	case AMDGPU_VA_OP_MAP:
>  	case AMDGPU_VA_OP_REPLACE:
> -		if (bo_va && bo_va->base.bo) {
> -			if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
> -				if (vm->last_update)
> -					last_update = dma_fence_get(vm->last_update);
> -			} else {
> -				if (bo_va->last_pt_update)
> -					last_update = dma_fence_get(bo_va->last_pt_update);
> -			}
> -		}
> +		/* MAP/REPLACE should return the page table update fence. */
> +		dma_fence_put(last_update);
> +
> +		/*
> +		 * Only treat this as always-valid when bo_va and bo both exist.
> +		 * This is required for correct PRT and always-valid mappings.
> +		 */
> +		if (bo_va && bo_va->base.bo &&
> +		    amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo))
> +			last_update = dma_fence_get(vm->last_update);
> +		else if (bo_va)

bo_va can't be NULL for MAP/REPLACE.

Regards,
Christian.

> +			last_update = dma_fence_get(bo_va->last_pt_update);
> +		else
> +			/* Defensive fallback: keep last_update valid. */
> +			last_update = dma_fence_get(vm->last_update);
>  		break;
>  	case AMDGPU_VA_OP_UNMAP:
>  	case AMDGPU_VA_OP_CLEAR:
> -		if (clear_fence)
> -			last_update = dma_fence_get(clear_fence);
> -		break;
>  	default:
> +		/* keep default last_update = clear_fence */
>  		break;
>  	}
>  
> @@ -791,17 +815,19 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  	if (r && r != -ERESTARTSYS)
>  		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
>  
> +out:
>  	/*
> -	 * If we managed to pick a more specific last-update fence, prefer it
> -	 * over the generic clear_fence and drop the extra reference to the
> -	 * latter.
> +	 * For UNMAP/CLEAR we return the fence from amdgpu_vm_clear_freed().
> +	 * That function may replace the stub fence with a real one, so refresh
> +	 * last_update to the final clear_fence before returning.
>  	 */
> -	if (last_update) {
> -		dma_fence_put(clear_fence);
> -		return last_update;
> +	if (operation != AMDGPU_VA_OP_MAP && operation != AMDGPU_VA_OP_REPLACE) {
> +		dma_fence_put(last_update);
> +		last_update = dma_fence_get(clear_fence);
>  	}
>  
> -	return clear_fence;
> +	dma_fence_put(clear_fence);
> +	return last_update;
>  }
>  
>  int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,

