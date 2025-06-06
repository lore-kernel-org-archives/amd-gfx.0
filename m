Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6F3C5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 05:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB37E10E33D;
	Fri,  6 Jun 2025 05:08:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tnpOHfTA";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6601110E33D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 05:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+wkg89oz+XB9wcU/P1kl+ZxClxguot3S/l/3OobMweZHuDkB4vMhQVkuB/ZWbaggpr+6i4JLc80rrpXzm5hvUL5YONV0uuhrWTn1TSQF9gwpHMdgL+UPc61BM1fjPDjmOCxmPdNBWEhkKX0jbPurT4GCGbQH4uL+6PDBJ879r631OUzGU0amwcbVmNaANxG1/PvOTUp6vFvR4riK3rBRwVDjfl8XW3OLyHK7n/p1dzyeGnMKpA4QzqySgz50ou9vlinveWOs7rmmrs867UtKdl/s8ZD7bMyuj+on2AC7vMEO34JigyFBHZ7AWqBMiOQlTRqPuUsnqV79WdUMA7lGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+lbeDHrhnWw3toOOv4V0p3Q18Pc9NSGUq5uJsaxW2Y=;
 b=j1Z1Gu16ceHU2baaAZi8Ofwab2joINKQU/lDeN9o/nLp4/EKoPqXEy8eoD7Rn/j7Zw6BcXNF2JHwaGViOylwGZ8xaRdTCaWmFbTWkt+8FoAmZpkzdvhsCdioL3Ig+GIEWYmKF99BZtqPxkHg36XnMFktZjiONTEJMCpee+SiDyVAV+MIyqRVif32sMEScF1ETrIWrXf6Ts+ujxqBPmrOOHGCM6PFC8+5/AUtrvhXmEYchop/V7IIQSMagJ9KIN29R8vNPD7Wh/RYje5J3IkSH7/GeL7si4whYVeAc6CCwpZgVftwIUx/UIjYvXu5o9FyXLx6txElMTS88fX1x3aKag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+lbeDHrhnWw3toOOv4V0p3Q18Pc9NSGUq5uJsaxW2Y=;
 b=tnpOHfTAm3UI/2oUeCo4UGHdS9x67ovijzP+MXA8n4vLEyRmxcty8AL/j7qoaFadvXxtwSADU6YAgB0je5z3KAGInBYjCKfD+BzKvCUJwDwBpJUzaAxH84/UZZoYJRjCUL2K0ufIfutfhuwDFj5DJeJLUTRty6VwutdLsiEvnp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB6578.namprd12.prod.outlook.com (2603:10b6:208:3a2::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.35; Fri, 6 Jun 2025 05:08:09 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8792.033; Fri, 6 Jun 2025
 05:08:09 +0000
Content-Type: multipart/mixed; boundary="------------D0yh0p18QtVJg8RrVPmFRdUn"
Message-ID: <7aa5dc2f-22d8-4886-8310-2f5a5ff4efd2@amd.com>
Date: Fri, 6 Jun 2025 10:38:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix the gpu recover deadlock issue in
 abnormal situations
To: Ce Sun <cesun102@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, YiPeng.Chai@amd.com
References: <20250606035412.145081-1-cesun102@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250606035412.145081-1-cesun102@amd.com>
X-ClientProxiedBy: PN4P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: a325b7c3-c405-41f8-f90c-08dda4b820d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|4053099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHlFcEYvVHJWaloyNjZGNWlyUUFaQWVDSDR6WElYekU3YU1xZ3hiWGttV1Ju?=
 =?utf-8?B?ck10WUR5cGEwT3FZOVFic2ZTakNNOG1wclpjQm5OT1BuQ2NZeUVWbzJ5Smlr?=
 =?utf-8?B?eUdWejYyYVpmQ2svcDUyVUkvMDFiR3ByMEQvSk94NXJXREhVNUlYekJ0Z1Bi?=
 =?utf-8?B?SmhEcmY5YXVPcFp1RmNwOWIwbzVub3BWUmZCUC9YMnZubmdWZEcwUUhtY2lw?=
 =?utf-8?B?d3VDU0FjYmZsVllMd2hJMzk3Ykw4a1pvMmJDTVJ6eEpjbEJLK3gzeXo2dk02?=
 =?utf-8?B?U0Z1TGZ5cXNTcGdXVlFMQkhxM3VMSGlsNU9YNHVLZHZtK0p1SmMwQVZJTVBI?=
 =?utf-8?B?cXlUZFNNbzdRaGtTcm1tYSs2VTRVVTEweERwRmJUc0lvd1ZNSUh5Tmd3WHlH?=
 =?utf-8?B?WjlKekZhS2phWTVuSEExOE9QWGMwTW5Qc0ttMFJSTjVjNTdGWlVGZlZDUUo4?=
 =?utf-8?B?eHkvN1ROVERtSnJpdmNUY01ob2lWUlRQZW9rSm5ld0YydllZUk9CWUlkbmU5?=
 =?utf-8?B?OXo0WkJ1citIK0h6NS9OWklFd0p1MHA3dE42d1VObi9LZFZDM3IwWlBuaWVK?=
 =?utf-8?B?eDE3b2hFb3JhYy9IQjhXbGF5SEp0Ykp5VEhrYlNPMlhzbm5sT09XSTFsZnE5?=
 =?utf-8?B?VXBSTUh2OFdmN1lyMk45VWVDbU1tN3I4WnZkK2dyU3hGbVl4ZjFmVnpvUW9s?=
 =?utf-8?B?OWdQcHFNMWVwZE41aFhLckdCNFNDOE43VDM0VU5ETDVJWTk1SVZHY0d2VFdk?=
 =?utf-8?B?NlpMRk1veEFXVGdCMU5TeHdIVWtLTlNzWHp4WnZjSnJQQUo5eGZkQy9oV3FJ?=
 =?utf-8?B?OWJBOWtGSmI1NW9tNWg1bEJpTzM2UFN2Qms5OERUYlgrTmVYVWpuakMycERL?=
 =?utf-8?B?aWloenVobGlvaFB4dDRVS3FOUVowZTRnRUE3SWdhNzROdjI4SG91SWs3NnAr?=
 =?utf-8?B?L3ROSHBoTVFHRW9aNFNxVVptaGtwb0lCa2h0SlZyM21qT2h2S3JiR0Y2UmxJ?=
 =?utf-8?B?blgvOGRUNE1xVVNxbktOTzIvNUZrVkxoYUY1ODk2clNLOXNKanBiVVBaTXhr?=
 =?utf-8?B?M0JrNWpzeGk1U2FQM040SE9LOTFNSkg4ZjFxcGdpVWpxYWx2S1RLNlh0Q0sz?=
 =?utf-8?B?NXBoSnJJVVllZkZoa1EwWWgyOEdaSU81WGhJRlJ2UW5wK3IwQmMrRFVBUVBu?=
 =?utf-8?B?cUQ2QzEvaFZBUDZKU3gyNUpPNlQrUkZpdmxScDVVNENXbENiUVJyVjRBQWs2?=
 =?utf-8?B?L2dwYVFFeVZ4cFBrcVVOYURCbVhlUHVTTlNpS2djSVdZY2tNMVc2MjJ5Z0Er?=
 =?utf-8?B?Q2ZuRHlsL0EwanBtY2N6eG9kemJDeUJVUXF0S3gza3V2Wm04WTYvVFlmZEkv?=
 =?utf-8?B?blhZVHdYR092SEoyYkg5N0VLamZacEFJclo0azVHWHZkWmtaZG9hWVhWcmp5?=
 =?utf-8?B?cERjaXYwR0tDcXpHSWlxRXV4ckVrQ0pHTy9XOFRyOTIyZ0tvNXBvSnRvS1Zx?=
 =?utf-8?B?S0J2Y0JGV2x4Qk12eHdMWkNIWDZLT1RGZ2dnbFovcXduZW1WRXYxNXdkNy9Q?=
 =?utf-8?B?TTZBMThKTFhhZnE4STVUV0MzbWdTS1M2YVF4dW5WQzJObDlQWE9iU2Y4NDAr?=
 =?utf-8?B?V0JtQWc3VHltTHZHaytnRDhKMFVhbGhyT3R3clZTaWxxNHJ5UldSSHV4NkFM?=
 =?utf-8?B?OUYycExmSnVvd2lEaTNiUCt5dmFBVTJTbTNsZ3RKUjR0UWErQXo5MEdXMnBD?=
 =?utf-8?B?TWdhMEpsbTFUd01BZkZnYnI4ckoyMGkxMHUwbG1lNkdDQllXdFVVR2JLOFNT?=
 =?utf-8?B?M1cyaE5RKzVHdG4xOTFCaC9ta0tDQ1p1Wm0zUVJuWkRPOStOQ21uOXlLcnFD?=
 =?utf-8?B?d21sL0E3KzRMa3RyU0NScWpXbFJaYnpDTUlrUFBZL2VVZlB5TmMwaVRCQ2VN?=
 =?utf-8?Q?F0+iBYIagQA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(4053099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDJYUWhUUkk1Nm8zOXl2b1lUQ0ljOW1haUFTZTVtK3YxNy82TEFWUnphRWpo?=
 =?utf-8?B?T05wWnlIdER3V0x6Nzh0ZXFtaWNrd1ByTGZxclJ0dUJSSk42cXFKUXQwTEhH?=
 =?utf-8?B?elVuOEpjM3VDRGNBeXhBbS9wYkEzSjFZakdNU2RrQUlkMDBHU0MyY0o1a2Vy?=
 =?utf-8?B?TE5BQlA5aklWL0RkcCtJT0tCVkY1b280NVJQN2Q4R2t3SDJqenRnbjI0NHNz?=
 =?utf-8?B?Q2NpNGRwbTd1S212emYzckNoNDhWYzloNStHKzhOM2hzSDk1c05Udk9IOGFq?=
 =?utf-8?B?UzNPbEVMVktySlIyQ0dFL0c4SldiMTFuaVBJYzRpQ0VyaUgyb0MzblZFZVdZ?=
 =?utf-8?B?aDh4bTZPOEE3TnVJN3FBZlBzMU00Z0hzNEFyNUxvSmNWd0J4ZnhwTU1VdEkv?=
 =?utf-8?B?MGNNRGJxSzRtWHNSQ2lYeFRwRzRsMjhJRk9IZjFCanlOazlHQXVDZVRIM1BB?=
 =?utf-8?B?RU5md3ZSa21uT0RRN3ZQcDZORTVnUFJnOW1NZFlRdDJoU1B0cDJ1ZjZLcldy?=
 =?utf-8?B?Rjk3NVVKUnB5dVl5SWFjU1pxK2lqSU42QzdJemhrOVZGU3AzNE5ZaHFRcFBo?=
 =?utf-8?B?Q2N2dmhTamRTYnlIWXFqZTVNc042d2xWc1FGTVE1ZzVrSXBiQWdmWEhKSXQv?=
 =?utf-8?B?T0xKREtLZkxrL01hRnBvK1FSd3lmSUZBL3dGZUNRQ1NPVDZIQmNoNWRMS0V6?=
 =?utf-8?B?anliQy84UGZGM3dSN0hNNTB3L1Z6ZXF0SXVUY08wbUxmbG8vVU9RNW51Q0Z2?=
 =?utf-8?B?RjQ5d2RhWDZFOGdGamd1ekdMdGVRZEQ4RUlGQnlRN2V0MHNZR1lRM0xMU0RX?=
 =?utf-8?B?NG9FM0pSWFBkdXpWaGlONGZWRUROb3NQMzhIdnRZazZWT3d4SllRZjZyUHZW?=
 =?utf-8?B?U1pUcWltR2tBUUozd3BTd21jYm1UTFFKeTZpcDhVMnAvRXdkcy9GbXhEMXVj?=
 =?utf-8?B?NksxN1QwNHNFNUx3M0pXVTAyRFlWYlc0ejBEV1oydGV1NVZ6Q2lpQlYwYjVF?=
 =?utf-8?B?d05xS1IxRVc0R21FcEw0RlpaZWRsRVhpd2ZsWmZabjIybURENThsOEZ1Rzdn?=
 =?utf-8?B?SEI2Skp2c1ZCcktFaVErOXZvZ1U2Z1ArTXQyK1QzYmk3aExvK0hCSVc2RkhV?=
 =?utf-8?B?RGVobG8zNlAwZEN0WUxNd1hCeCtnaFB4RzduQ3h5Q1R2UUo4YnZDRU9KYXRp?=
 =?utf-8?B?T0krYmUrRm5xMmNmMU1NM2M1VmNrUERTcmZVNlVwTzVaNEtIQTNScDk5SCtt?=
 =?utf-8?B?NGwzeCtRVTBHK0ZxMGowKzhGTmJCVFhaQ2l5RXVZRGg5N0o0Qk4vN2MxcFZa?=
 =?utf-8?B?K0NZOGJhbEMva3ZGWVNtTVBIWUZSeTd5WlpjV01PdjNwL3NtcFlRQ0Y2Wndl?=
 =?utf-8?B?M2RvN29CVW4xYUlndCt5eW9VUVMrdkQ4TjBQMVFkOXRpeTlkZm8rM2R3Qmdm?=
 =?utf-8?B?NEloZUNaOXZrTitod1lzT3hDVTZ5ZnNWNHZBeHlGcC8wZnJNdUZ3Y0xNaVAr?=
 =?utf-8?B?WVM2alZ2TzY2ODF3WWZNd1NFMUozWFJ6K1FMVWlmMVVobnljTnZHME9BUnBa?=
 =?utf-8?B?aE1mcHBLRWtTc04rRTk4dVpCZUJPajFhSXJoQ29tZUhHVHd0S0tuUVNiaWc2?=
 =?utf-8?B?eUxBd2ZlMDhSaXpXSE1uRUpSdjU1TkdnYjhyTGZOVnI0dlpxeTdoVFdvYzhZ?=
 =?utf-8?B?WktmenRqaEhyL0wrZlp6MWx1dU1JSVFJTXhwWGVPcjFaSXVSNHZSa2RTS3hy?=
 =?utf-8?B?RE9BVjkvcEMwUXBWT0piTHl1YVI1VmpycENyMmIrMXdiRGtrYTBxbnd3QXEx?=
 =?utf-8?B?Z09EU3Ztbm1VdFp2Zjh1SlVoM1ZEK0tlQTRETlU5WTR4ZEZMb09tbUc3ZTZW?=
 =?utf-8?B?bXROYW9GdTBZRWRyQjlCU0NRdFpPcm1VY3Mvb2VPUTNyVjQ1UVRZUXVHOU9D?=
 =?utf-8?B?Y1VMaHpwK21WZ0ppSlhLaGxaVHZDZU1EY01ydThDRkVZWklrRjAycXd5UzQ4?=
 =?utf-8?B?SHcyV1ZzdGNNR2VBQ3R1U3p6b0NxMmFXYTJQUnArd2hXeTRPUFZYQ3F3Ungw?=
 =?utf-8?B?YlI0MVdZWDNWNVdkT0pkaTJUNVRaL01OdUtHYTVvUUU1a21PSnVxQU8zVWJ1?=
 =?utf-8?Q?Lwk1twfoXIVORiNiWCmyX+yNJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a325b7c3-c405-41f8-f90c-08dda4b820d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 05:08:09.1818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPxQZJfm7Y4FtqReRigjYtLZq0RaP1GSGg12oxRXUKXT/r3TnA1Tq++z1xzD0LoK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6578
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

--------------D0yh0p18QtVJg8RrVPmFRdUn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/6/2025 9:24 AM, Ce Sun wrote:
> rma occurred in the RAS records exceed threshold device. When the
> device was performing gpu recover, the reset domain lock was not
> released, resulting in kernel panic
> 
> [  630.141619] INFO: task umc_page_retire:9472 blocked for more than 122 seconds.
> [  630.157663]       Tainted: G           OE      6.9.0-0_fbk6_brcmrdma11_125_gfecec9d12677 #1
> [  630.176213] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  630.193591] task:umc_page_retire state:D stack:0     pid:9472  tgid:9472  ppid:2      flags:0x00004000
> [  630.214251] Call Trace:
> [  630.219673]  <TASK>
> [  630.224326]  __schedule+0x589/0xad0
> [  630.232070]  schedule+0x67/0xb0
> [  630.239038]  schedule_timeout+0x22/0x100
> [  630.247740]  ? __smp_call_single_queue+0x36/0x100
> [  630.258195]  ? wake_up_process+0x7df/0x1190
> [  630.267477]  ? wait_for_common+0xa4/0x150
> [  630.276371]  wait_for_common+0x99/0x150
> [  630.284881]  __flush_work.llvm.6727378282878825097+0x20a/0x290
> [  630.297826]  ? rcu_work_rcufn+0x20/0x20
> [  630.306338]  amdgpu_ras_page_retirement_thread+0x469/0x4e0 [amdgpu]
> [  630.320344]  ? amdgpu_ras_do_recovery+0x5f0/0x5f0 [amdgpu]
> [  630.332587]  kthread+0xdd/0x120
> [  630.339552]  ? __sched_group_set_shares+0x160/0x160
> [  630.350373]  ret_from_fork+0x2f/0x40
> [  630.358303]  ? __sched_group_set_shares+0x160/0x160
> [  630.369128]  ret_from_fork_asm+0x11/0x20
> [  630.377831]  </TASK>
> [  630.382796] INFO: task kworker/u1536:1:10591 blocked for more than 123 seconds.
> [  630.399018]       Tainted: G           OE      6.9.0-0_fbk6_brcmrdma11_125_gfecec9d12677 #1
> [  630.417554] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  630.434935] task:kworker/u1536:1 state:D stack:0     pid:10591 tgid:10591 ppid:2      flags:0x00004000
> [  630.455594] Workqueue: amdgpu-reset-hive amdgpu_ras_do_recovery [amdgpu]
> [  630.470537] Call Trace:
> [  630.475958]  <TASK>
> [  630.480609]  __schedule+0x589/0xad0
> [  630.488347]  schedule+0x67/0xb0
> [  630.495313]  schedule_preempt_disabled+0xa/0x10
> [  630.505362]  rwsem_down_write_slowpath+0x2ba/0x510
> [  630.515994]  down_write+0x2b/0x30
> [  630.523346]  amdgpu_device_halt_activities+0xef/0x400 [amdgpu]
> [  630.536363]  amdgpu_device_gpu_recover+0x124/0x230 [amdgpu]
> [  630.548797]  amdgpu_ras_do_recovery+0x5af/0x5f0 [amdgpu]
> [  630.560653]  process_scheduled_works+0x184/0x370
> [  630.570900]  worker_thread+0xc6/0x3f0
> [  630.579022]  ? __ipv6_chk_addr_and_flags.llvm.7715710786076949193+0x160/0x160
> [  630.594857]  ? __ipv6_chk_addr_and_flags.llvm.7715710786076949193+0x160/0x160
> [  630.610693]  kthread+0xdd/0x120
> [  630.617660]  ? __sched_group_set_shares+0x160/0x160
> [  630.628483]  ret_from_fork+0x2f/0x40
> [  630.636413]  ? __sched_group_set_shares+0x160/0x160
> [  630.647232]  ret_from_fork_asm+0x11/0x20
> 
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2b84df8da61a..f5e69132bce8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6305,7 +6305,6 @@ static void amdgpu_device_gpu_resume(struct amdgpu_device *adev,
>  	tmp_adev = list_first_entry(device_list, struct amdgpu_device,
>  					    reset_list);
>  	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
> -
>  }
>  
>  
> @@ -6396,12 +6395,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	}
>  
>  	r = amdgpu_device_asic_reset(adev, &device_list, reset_context);
> -	if (r)
> -		goto end_reset;
>  skip_hw_reset:
>  	r = amdgpu_device_sched_resume(&device_list, reset_context, job_signaled);
> -	if (r)
> -		goto end_reset;

I don't think it's right to proceed further in case of failure. Please
try the attached patch.

Thanks,
Lijo

>  skip_sched_resume:
>  	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
>  end_reset:
> @@ -6938,8 +6933,10 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>  		if (hive) {
>  			list_for_each_entry(tmp_adev, &device_list, reset_list)
>  				amdgpu_device_unset_mp1_state(tmp_adev);
> -			amdgpu_device_unlock_reset_domain(adev->reset_domain);
>  		}
> +		tmp_adev = list_first_entry(&device_list, struct amdgpu_device,
> +						reset_list);
> +		amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
>  	}
>  
>  	if (hive) {

--------------D0yh0p18QtVJg8RrVPmFRdUn
Content-Type: text/plain; charset=UTF-8;
 name="0001-drm-amdgpu-Release-reset-locks-during-failures.patch"
Content-Disposition: attachment;
 filename*0="0001-drm-amdgpu-Release-reset-locks-during-failures.patch"
Content-Transfer-Encoding: base64

RnJvbSBhNWM4MWZlMDg2ZmExZjljOGRmMDg3YTQxZDlhNTI5ZjU3ZDY1ZmFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaWpvIExhemFyIDxsaWpvLmxhemFyQGFtZC5jb20+CkRhdGU6
IEZyaSwgNiBKdW4gMjAyNSAxMDoyOToyOCArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRn
cHU6IFJlbGVhc2UgcmVzZXQgbG9ja3MgZHVyaW5nIGZhaWx1cmVzCgpNYWtlIHN1cmUgdG8gcmVs
ZWFzZSByZXNldCBkb21haW4gbG9jayBpbiBjYXNlIG9mIGZhaWx1cmVzLgoKU2lnbmVkLW9mZi1i
eTogTGlqbyBMYXphciA8bGlqby5sYXphckBhbWQuY29tPgoKRml4ZXM6IDBmOTM2ZTIzY2Y5ZCAo
ImRybS9hbWRncHU6IHJlZmFjdG9yIGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIiKQotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDc2ICsrKysrKysrKysr
KysrKy0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKaW5kZXgg
ZTY0OTY5ZDU3NmE2Li4wZWVkY2ZmZDI1ODIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMKQEAgLTYwNTcsMTYgKzYwNTcsMTIgQEAgc3RhdGljIGludCBhbWRn
cHVfZGV2aWNlX2hlYWx0aF9jaGVjayhzdHJ1Y3QgbGlzdF9oZWFkICpkZXZpY2VfbGlzdF9oYW5k
bGUpCiAJcmV0dXJuIHJldDsKIH0KIAotc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2hhbHRfYWN0
aXZpdGllcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKLQkJCSAgICAgIHN0cnVjdCBhbWRn
cHVfam9iICpqb2IsCi0JCQkgICAgICBzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2NvbnRleHQgKnJlc2V0
X2NvbnRleHQsCi0JCQkgICAgICBzdHJ1Y3QgbGlzdF9oZWFkICpkZXZpY2VfbGlzdCwKLQkJCSAg
ICAgIHN0cnVjdCBhbWRncHVfaGl2ZV9pbmZvICpoaXZlLAotCQkJICAgICAgYm9vbCBuZWVkX2Vt
ZXJnZW5jeV9yZXN0YXJ0KQorc3RhdGljIGludCBhbWRncHVfZGV2aWNlX3JlY292ZXJ5X3ByZXBh
cmUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCisJCQkJCSAgc3RydWN0IGxpc3RfaGVhZCAq
ZGV2aWNlX2xpc3QsCisJCQkJCSAgc3RydWN0IGFtZGdwdV9oaXZlX2luZm8gKmhpdmUpCiB7Ci0J
c3RydWN0IGxpc3RfaGVhZCAqZGV2aWNlX2xpc3RfaGFuZGxlID0gIE5VTEw7CiAJc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKnRtcF9hZGV2ID0gTlVMTDsKLQlpbnQgaSwgciA9IDA7CisJaW50IHI7CiAK
IAkvKgogCSAqIEJ1aWxkIGxpc3Qgb2YgZGV2aWNlcyB0byByZXNldC4KQEAgLTYwODMsMjYgKzYw
NzksNTQgQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2hhbHRfYWN0aXZpdGllcyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwKIAkJfQogCQlpZiAoIWxpc3RfaXNfZmlyc3QoJmFkZXYtPnJl
c2V0X2xpc3QsIGRldmljZV9saXN0KSkKIAkJCWxpc3Rfcm90YXRlX3RvX2Zyb250KCZhZGV2LT5y
ZXNldF9saXN0LCBkZXZpY2VfbGlzdCk7Ci0JCWRldmljZV9saXN0X2hhbmRsZSA9IGRldmljZV9s
aXN0OwogCX0gZWxzZSB7CiAJCWxpc3RfYWRkX3RhaWwoJmFkZXYtPnJlc2V0X2xpc3QsIGRldmlj
ZV9saXN0KTsKLQkJZGV2aWNlX2xpc3RfaGFuZGxlID0gZGV2aWNlX2xpc3Q7CiAJfQogCiAJaWYg
KCFhbWRncHVfc3Jpb3ZfdmYoYWRldikgJiYgKCFhZGV2LT5wY2llX3Jlc2V0X2N0eC5vY2N1cnNf
ZHBjKSkgewotCQlyID0gYW1kZ3B1X2RldmljZV9oZWFsdGhfY2hlY2soZGV2aWNlX2xpc3RfaGFu
ZGxlKTsKKwkJciA9IGFtZGdwdV9kZXZpY2VfaGVhbHRoX2NoZWNrKGRldmljZV9saXN0KTsKIAkJ
aWYgKHIpCiAJCQlyZXR1cm4gcjsKIAl9CiAKLQkvKiBXZSBuZWVkIHRvIGxvY2sgcmVzZXQgZG9t
YWluIG9ubHkgb25jZSBib3RoIGZvciBYR01JIGFuZCBzaW5nbGUgZGV2aWNlICovCi0JdG1wX2Fk
ZXYgPSBsaXN0X2ZpcnN0X2VudHJ5KGRldmljZV9saXN0X2hhbmRsZSwgc3RydWN0IGFtZGdwdV9k
ZXZpY2UsCi0JCQkJICAgIHJlc2V0X2xpc3QpOworCXJldHVybiAwOworfQorCitzdGF0aWMgdm9p
ZCBhbWRncHVfZGV2aWNlX3JlY292ZXJ5X2dldF9yZXNldF9sb2NrKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAorCQkJCQkJICBzdHJ1Y3QgbGlzdF9oZWFkICpkZXZpY2VfbGlzdCkKK3sKKwlz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqdG1wX2FkZXYgPSBOVUxMOworCisJaWYgKGxpc3RfZW1wdHko
ZGV2aWNlX2xpc3QpKQorCQlyZXR1cm47CisJdG1wX2FkZXYgPQorCQlsaXN0X2ZpcnN0X2VudHJ5
KGRldmljZV9saXN0LCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSwgcmVzZXRfbGlzdCk7CiAJYW1kZ3B1
X2RldmljZV9sb2NrX3Jlc2V0X2RvbWFpbih0bXBfYWRldi0+cmVzZXRfZG9tYWluKTsKK30KIAot
CS8qIGJsb2NrIGFsbCBzY2hlZHVsZXJzIGFuZCByZXNldCBnaXZlbiBqb2IncyByaW5nICovCi0J
bGlzdF9mb3JfZWFjaF9lbnRyeSh0bXBfYWRldiwgZGV2aWNlX2xpc3RfaGFuZGxlLCByZXNldF9s
aXN0KSB7CitzdGF0aWMgdm9pZCBhbWRncHVfZGV2aWNlX3JlY292ZXJ5X3B1dF9yZXNldF9sb2Nr
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAorCQkJCQkJICBzdHJ1Y3QgbGlzdF9oZWFkICpk
ZXZpY2VfbGlzdCkKK3sKKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqdG1wX2FkZXYgPSBOVUxMOwor
CisJaWYgKGxpc3RfZW1wdHkoZGV2aWNlX2xpc3QpKQorCQlyZXR1cm47CisJdG1wX2FkZXYgPQor
CQlsaXN0X2ZpcnN0X2VudHJ5KGRldmljZV9saXN0LCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSwgcmVz
ZXRfbGlzdCk7CisJYW1kZ3B1X2RldmljZV91bmxvY2tfcmVzZXRfZG9tYWluKHRtcF9hZGV2LT5y
ZXNldF9kb21haW4pOworfQogCitzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfaGFsdF9hY3Rpdml0
aWVzKAorCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X2pvYiAqam9i
LAorCXN0cnVjdCBhbWRncHVfcmVzZXRfY29udGV4dCAqcmVzZXRfY29udGV4dCwKKwlzdHJ1Y3Qg
bGlzdF9oZWFkICpkZXZpY2VfbGlzdCwgc3RydWN0IGFtZGdwdV9oaXZlX2luZm8gKmhpdmUsCisJ
Ym9vbCBuZWVkX2VtZXJnZW5jeV9yZXN0YXJ0KQoreworCXN0cnVjdCBhbWRncHVfZGV2aWNlICp0
bXBfYWRldiA9IE5VTEw7CisJaW50IGksIHIgPSAwOworCisJLyogYmxvY2sgYWxsIHNjaGVkdWxl
cnMgYW5kIHJlc2V0IGdpdmVuIGpvYidzIHJpbmcgKi8KKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KHRt
cF9hZGV2LCBkZXZpY2VfbGlzdCwgcmVzZXRfbGlzdCkgewogCQlhbWRncHVfZGV2aWNlX3NldF9t
cDFfc3RhdGUodG1wX2FkZXYpOwogCiAJCS8qCkBAIC02MjkwLDExICs2MzE0LDYgQEAgc3RhdGlj
IHZvaWQgYW1kZ3B1X2RldmljZV9ncHVfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAogCQlhbWRncHVfcmFzX3NldF9lcnJvcl9xdWVyeV9yZWFkeSh0bXBfYWRldiwgdHJ1ZSk7CiAK
IAl9Ci0KLQl0bXBfYWRldiA9IGxpc3RfZmlyc3RfZW50cnkoZGV2aWNlX2xpc3QsIHN0cnVjdCBh
bWRncHVfZGV2aWNlLAotCQkJCQkgICAgcmVzZXRfbGlzdCk7Ci0JYW1kZ3B1X2RldmljZV91bmxv
Y2tfcmVzZXRfZG9tYWluKHRtcF9hZGV2LT5yZXNldF9kb21haW4pOwotCiB9CiAKIApAQCAtNjM2
MiwxMCArNjM4MSwxNiBAQCBpbnQgYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcihzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKIAlyZXNldF9jb250ZXh0LT5oaXZlID0gaGl2ZTsKIAlJTklUX0xJ
U1RfSEVBRCgmZGV2aWNlX2xpc3QpOwogCisJaWYgKGFtZGdwdV9kZXZpY2VfcmVjb3ZlcnlfcHJl
cGFyZShhZGV2LCAmZGV2aWNlX2xpc3QsIGhpdmUpKQorCQlnb3RvIGVuZF9yZXNldDsKKworCS8q
IFdlIG5lZWQgdG8gbG9jayByZXNldCBkb21haW4gb25seSBvbmNlIGJvdGggZm9yIFhHTUkgYW5k
IHNpbmdsZSBkZXZpY2UgKi8KKwlhbWRncHVfZGV2aWNlX3JlY292ZXJ5X2dldF9yZXNldF9sb2Nr
KGFkZXYsICZkZXZpY2VfbGlzdCk7CisKIAlyID0gYW1kZ3B1X2RldmljZV9oYWx0X2FjdGl2aXRp
ZXMoYWRldiwgam9iLCByZXNldF9jb250ZXh0LCAmZGV2aWNlX2xpc3QsCiAJCQkJCSBoaXZlLCBu
ZWVkX2VtZXJnZW5jeV9yZXN0YXJ0KTsKIAlpZiAocikKLQkJZ290byBlbmRfcmVzZXQ7CisJCWdv
dG8gcmVzZXRfdW5sb2NrOwogCiAJaWYgKG5lZWRfZW1lcmdlbmN5X3Jlc3RhcnQpCiAJCWdvdG8g
c2tpcF9zY2hlZF9yZXN1bWU7CkBAIC02MzkwLDYgKzY0MTUsOCBAQCBpbnQgYW1kZ3B1X2Rldmlj
ZV9ncHVfcmVjb3ZlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJZ290byBlbmRfcmVz
ZXQ7CiBza2lwX3NjaGVkX3Jlc3VtZToKIAlhbWRncHVfZGV2aWNlX2dwdV9yZXN1bWUoYWRldiwg
JmRldmljZV9saXN0LCBuZWVkX2VtZXJnZW5jeV9yZXN0YXJ0KTsKK3Jlc2V0X3VubG9jazoKKwlh
bWRncHVfZGV2aWNlX3JlY292ZXJ5X3B1dF9yZXNldF9sb2NrKGFkZXYsICZkZXZpY2VfbGlzdCk7
CiBlbmRfcmVzZXQ6CiAJaWYgKGhpdmUpIHsKIAkJbXV0ZXhfdW5sb2NrKCZoaXZlLT5oaXZlX2xv
Y2spOwpAQCAtNjgwMSw2ICs2ODI4LDggQEAgcGNpX2Vyc19yZXN1bHRfdCBhbWRncHVfcGNpX2Vy
cm9yX2RldGVjdGVkKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBwY2lfY2hhbm5lbF9zdGEKIAkJbWVt
c2V0KCZyZXNldF9jb250ZXh0LCAwLCBzaXplb2YocmVzZXRfY29udGV4dCkpOwogCQlJTklUX0xJ
U1RfSEVBRCgmZGV2aWNlX2xpc3QpOwogCisJCWFtZGdwdV9kZXZpY2VfcmVjb3ZlcnlfcHJlcGFy
ZShhZGV2LCAmZGV2aWNlX2xpc3QsIGhpdmUpOworCQlhbWRncHVfZGV2aWNlX3JlY292ZXJ5X2dl
dF9yZXNldF9sb2NrKGFkZXYsICZkZXZpY2VfbGlzdCk7CiAJCXIgPSBhbWRncHVfZGV2aWNlX2hh
bHRfYWN0aXZpdGllcyhhZGV2LCBOVUxMLCAmcmVzZXRfY29udGV4dCwgJmRldmljZV9saXN0LAog
CQkJCQkgaGl2ZSwgZmFsc2UpOwogCQlpZiAoaGl2ZSkgewpAQCAtNjkxOCw4ICs2OTQ3LDggQEAg
cGNpX2Vyc19yZXN1bHRfdCBhbWRncHVfcGNpX3Nsb3RfcmVzZXQoc3RydWN0IHBjaV9kZXYgKnBk
ZXYpCiAJCWlmIChoaXZlKSB7CiAJCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2LCAmZGV2
aWNlX2xpc3QsIHJlc2V0X2xpc3QpCiAJCQkJYW1kZ3B1X2RldmljZV91bnNldF9tcDFfc3RhdGUo
dG1wX2FkZXYpOwotCQkJYW1kZ3B1X2RldmljZV91bmxvY2tfcmVzZXRfZG9tYWluKGFkZXYtPnJl
c2V0X2RvbWFpbik7CiAJCX0KKwkJYW1kZ3B1X2RldmljZV9yZWNvdmVyeV9wdXRfcmVzZXRfbG9j
ayhhZGV2LCAmZGV2aWNlX2xpc3QpOwogCX0KIAogCWlmIChoaXZlKSB7CkBAIC02OTY1LDYgKzY5
OTQsNyBAQCB2b2lkIGFtZGdwdV9wY2lfcmVzdW1lKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQogCiAJ
YW1kZ3B1X2RldmljZV9zY2hlZF9yZXN1bWUoJmRldmljZV9saXN0LCBOVUxMLCBOVUxMKTsKIAlh
bWRncHVfZGV2aWNlX2dwdV9yZXN1bWUoYWRldiwgJmRldmljZV9saXN0LCBmYWxzZSk7CisJYW1k
Z3B1X2RldmljZV9yZWNvdmVyeV9wdXRfcmVzZXRfbG9jayhhZGV2LCAmZGV2aWNlX2xpc3QpOwog
CWFkZXYtPnBjaWVfcmVzZXRfY3R4Lm9jY3Vyc19kcGMgPSBmYWxzZTsKIAogCWlmIChoaXZlKSB7
Ci0tIAoyLjI1LjEKCg==

--------------D0yh0p18QtVJg8RrVPmFRdUn--
