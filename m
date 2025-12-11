Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C06BD41C2D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 12:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2028C10E7FE;
	Thu, 11 Dec 2025 12:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xSA6+85/";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012071.outbound.protection.outlook.com
 [40.107.200.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE5F710E7FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 12:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3woU+Ee3WAUsFDeHmAtW3/aoLzAN27nxVsnWi7cVQ/ts5skm0KgApcq95WSbFtHHFREIgdRTB7w8f1eC20JnEBsTbv2OfGkU6dsqbi2S7nE13ZJwX8/sbZoi3jEhEdTerX5thh+o9mDPq6r7mEdCPr1kD6SxESkbEj0uq4pa+97sXtPQFR6Fahoy6Qix+M4ZcScF8AXO62bk5yUQZLUq1ovcVibtiX9rSjc2GPj7wIj3YVVJHVbUszkhumHH+/IjXpEyzAVNY77ZjUV24vZN6Tmfl/NrguiKIVHJxCPWgAP+PRRJTt5APcRNboZq/1SQ/2se+r2l1109jnNa6oiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZGdTI5yvk5R1yQX7i7T2aNs7IK0vSSICREr+A6QnPk=;
 b=pPMMgGvfPTSYCG+93SMShqtAiHWFz9InDLBIPnGGbia2p41ZY7yA8Abtl/NDszew+b2Umtui1vrMvPPtO5Hqd7d3DzJPfXZaRn8+9a3NXleq2qLd+6/3U+CzOiy/OOHLh2bcem7YOrLry1M0TIHdvkFPNVfkmClgrO/dJzkiG8HZaFreK6M1zRfL6/w/HfPOpJPiG8DwwoWcDUx76Up9kKwO+8XUKfhKFwlyX5J4ztohMzW1rFl6wuaJxil60Kfg+1wEVb8pBO73Z2epm8xTE0JE0ZDzyHlx/O2gX0ojBjfqtMqDuL0ZnD4X3BFo9v2SahKjkRf5yGC2xM2sQmEf3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZGdTI5yvk5R1yQX7i7T2aNs7IK0vSSICREr+A6QnPk=;
 b=xSA6+85/C8aGX5TVDAycR9GDlaiExk8TFRg+h2NasypgwF060L7WJXa/6vXRFKuTaKpFmDee2uLhfXFteiAC4MXoT1typnGKkK99pHqL3HdIZExLZQtq/gaIQNV9lzCYPkoUSVmX1VSX1XMYf1U+O2NfD+q1b+yCVJbE72fcCis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.10; Thu, 11 Dec 2025 12:28:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 12:28:19 +0000
Message-ID: <a7d31ae0-dbef-46a9-bce7-2c0c59417b18@amd.com>
Date: Thu, 11 Dec 2025 13:28:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu: fix a job->pasid access race in gpu
 recovery
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: SRINIVASAN.SHANMUGAM@amd.com, vitaly.prosyak@amd.com,
 Matthew Brost <matthew.brost@intel.com>
References: <20251210202347.63243-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251210202347.63243-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0486.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f5b00f-b2da-48a5-614f-08de38b0c490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXlXcW9iUmw1ZEEzY3lreUxpMmVxVm9IcFBJYjhTd2FWbHpabnd2WXRjd09L?=
 =?utf-8?B?MEtmODNwRWRQcE82cFllOFFuM2xZQ1pUOGR4V0YyOUNib0RTOTFqNllJSUJU?=
 =?utf-8?B?dnNNU25TQldZcDg0Vm1oeHFJblI5OGJTTUFTMU9INUJPdW9DZEV4QXh3aE8z?=
 =?utf-8?B?SUY0YS9PZkpSY1VyM0R3dXNQMmkyTE5abmFFWTZ0OWZ0K1hoSG9jdENVQnZs?=
 =?utf-8?B?VkZZZ1JsdmxQL002QjlXVFJ2dXNneXdMa2REcmJGdWg4SU45UXpuWTRIZTdW?=
 =?utf-8?B?VmwxSDFFYWF4bFJPejZPNWR2czBqRmVPMnlwbGEweDc4RGU4ejhqSmpuWXly?=
 =?utf-8?B?cFB3eThyV0JQVEF1QWF5cGE3RmdtdHh1eUJ0c3JHMmhsZ09IUHlVc1laOFVo?=
 =?utf-8?B?YkRuWFQvVkl3ZHVMbGM2QWp3MStSNUxJa3hwMjNNdGtTU1JXZVQyUDNvZzRm?=
 =?utf-8?B?YXlKbzdLUEsyeUozYlpnZ01PZUR3WUVHQ2JWRTZKaXltSkVhQnJFbFVqLzRj?=
 =?utf-8?B?Z2ZIemhBdEdYSlFTUDBEWkc3V3E3d3RkYitoK3NKL2EvSlp3U3lBZmZrcWlj?=
 =?utf-8?B?dW9TaEpNa0FuK3pKNThLYy9YVDBrODd2UU42ZmpOMzJqSWt0RzVjWXBYd3Ru?=
 =?utf-8?B?Vy8vSWs0b29YbDZJM3Y5dWtITDhxVEg5d0RWN21PaTRVbmZqNkZlRiswQnBJ?=
 =?utf-8?B?Y1ArZTk4RUloSG5IN3lSQ3NoL1QwSmJMTFhjN3NUdmlzcm5STUZBK2hhQktx?=
 =?utf-8?B?czBHRmZVejAzNHhSVktSY2MrNmhVSDFtTk5kcXRBRGpBZGlJM1Z5cFVLRVVM?=
 =?utf-8?B?cXE4L3hBd3U5VHpFK3N5OXhGcGJPREtMRkhKOFIrTkVwZU9rZWFsTGpmZm1x?=
 =?utf-8?B?ZmhoVW91TXdmREFXTGRPS20yaEVNVGczT0RqTWhsZXpJTzdFZTJmcUtiWHNk?=
 =?utf-8?B?dUZobmVqZHgvQzVBZlQ3bWk1c043VFovQjNubEhCdXNPaXphb1dZdGtGSmtN?=
 =?utf-8?B?MS9lYXYxNHFSZUZlQnEyZUpDRWhyeTJ0b3NtNWMxSmg1MmErUGs2bm4xYkF4?=
 =?utf-8?B?YW90bzduTGhHUWpuK0N4TUg1a3Vidk9VUGpuakZtWDNMOEM2c0syaENOM3VB?=
 =?utf-8?B?VUxpUUVtWWVjV3FaS3QxNUpEb3BSaU9pSU8xS1FzcGcyVG0za012Wk1JQlFP?=
 =?utf-8?B?TjdBR3dEb3hySEsyZWl6eGpMM0JIUnBlUWhGSEFndmhmTWk0RTVvWERYRHdr?=
 =?utf-8?B?cjR2NmQxczdtL3pTcGRDVHJYMzRVbk00N0Exdm5ydSszY0EyditrOTJMdjNB?=
 =?utf-8?B?TTliRUk5YmpPQnp5UHkwTWxjUTF4UjAzRlRqTXIvTXpLL0VEVmJGdE1wMnla?=
 =?utf-8?B?SnNVbTJRM1d2S2xJeWFnelRkVWtGemxrc21lZ0tNTTV2d0pMVUFyVWs0ekl4?=
 =?utf-8?B?S1ZxdmtwdmM4K2IzdGEreFhTckhtTS9RS2UvM094ei9JMEVjK0twcVlUVGkx?=
 =?utf-8?B?KzFVNkNGUkp0SzArZ2FPbjcvY0tYcC9XYWtsd0t1TDJiMmVhajBDdE16cnNM?=
 =?utf-8?B?ZjRzZmVUQlN5TEs0VFB1WEFMNUlpZ016OSs3TEFIWUhqaVMwekYxdE0zZGRI?=
 =?utf-8?B?aHYzeWl4aXNMM1ZUK3JoSkZERWZpWkkvanlhVWQrWHNkYWUweW9Yd2szeVQ3?=
 =?utf-8?B?S2sveVlDTngzNXVWcC9IM1FyU0g5dk1VaVIwRE9oNk9USi9KT3FnTDhyUHpO?=
 =?utf-8?B?bVhuNjFsSGk5WVlTUHlJYzRLdUV3M1JSNWFVdkxXMWhmVW9reWhmYWtoaVU5?=
 =?utf-8?B?eG9mSWF1VmV4OVVnRk92VlNPV2NDZmgxQ2F0MHlwMjMxRExNcExrMUEvWjNC?=
 =?utf-8?B?dmtCTzdDSnZwQ1pvSEpaS1JmUFpNMWdUa1R3cWowSlRCVmlNTVpRS2ZucFRP?=
 =?utf-8?Q?75/JMPt7xtwL1ViqZ72iNx5FA/6LM+/E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFo0ejNGN0RUZG50bHFIZVVqV2ZKcU1RTTFSdml2cDlUZlg2R0sxZzlWNEdj?=
 =?utf-8?B?bmpZVzAvcERVTDQ0TVNyQkpmQVU5VG9aQml6TXYyLzY4NUhrLzVQb0F6QS9H?=
 =?utf-8?B?cnU0UkJ5MXlucjhaUFFlSTVCNC9zVHFOUUE0VlEzQTRlWEUvdzNlWDhBSVVE?=
 =?utf-8?B?bUplaFFCNUxURlBxQ29FWjJtdEVGZ3RGL3ZzdDFqbXIrR0pZaEhVYTFzQURT?=
 =?utf-8?B?QUtXR0VCaHJ4RXdOY3NqUE50WEVTNE0rbm9tbkY1Nk1wKzBFN0RrejdtajRX?=
 =?utf-8?B?RCtRamJmR01MWmZ0cENCVFYyNndZOWhwcGVnbUFHQlZBbHlNYUkxY1d1TzRK?=
 =?utf-8?B?dXpjYnpTQSsycEJ5ZFRmeU5UMXVFZGtnSFFHb250WWRUTXRpVTRJRUtPSTJo?=
 =?utf-8?B?cnhDcFJsaWovVHBvYk9JTHZraUZJYkcydDNqNzd3WGljTXVjR2lOeHkva0c5?=
 =?utf-8?B?MkY3TFg3ZjRyQVNENGs5THhZVTBSVC9XRE54L3gwUzhRc251VFUwU1NVaUxo?=
 =?utf-8?B?Mitiejd3RXBIM1VrTkt6S2tjK0FRTVk4a3d2YUFQd1k4T1o5OWRTUU9uQ1FC?=
 =?utf-8?B?ZytFSlBFRDJkMVFuK1BQbzUwcHovb0RaeFZlSVhPWWZUSVVrU3FKK2lxZ2Nq?=
 =?utf-8?B?V1QxWHZ0bXR2MlZuN0dHd2tXWHNSNyt0UzNnaU80V3ZpN3hkak9BYytYSWt2?=
 =?utf-8?B?N0RnQkE0Ulo1RDdEVDM2VUcwNkl6MFVvRmRpbjZHbGx2OU9DUTFPdDljak5S?=
 =?utf-8?B?TVBSN3c1YmlicFZiV05HZFJxZ1B3RWhKVjhsNnRLM1NjajUvQThoU2FmMGVh?=
 =?utf-8?B?ZVI3UjlLWXZTUU42ZDFPbGc0SjFSSEdpVk1vVVN2TWNkQUROd05KbUs3WUE5?=
 =?utf-8?B?dzhCU2tHdFQ2ZlNPeWFscGxHd0Y3LzhSQy9Zc0M0RFZlUUVTVy9TNmJrT0Iw?=
 =?utf-8?B?R05zOHFIeGt6d0VxTG4waEYxb1lqaWZqMG9YT1JiZTlTQUpHUEN2MG5EeVJZ?=
 =?utf-8?B?bnMzbmZYR2xQVGNRMG15RVd6ZWNBem9FS3I2OFdGUmJ5UUs2WHMyanR0ZE1i?=
 =?utf-8?B?NHlLbXBIb2RjSUF4ZUtwMndhU21vMXdzZVFURkpjOHd1WGVBNVU3c3ZDMUhE?=
 =?utf-8?B?eFBWN3NvZURPb0ZrdkdEVmsyK2xuVjJJQTF6VlNqSE1OczI3WkFXWFFZU29H?=
 =?utf-8?B?TFVuREdiMmV6OTIxY0pkY2grcEpjWXhWZXZKMVAyMFJmQnV4SVJMQ3NSaDVu?=
 =?utf-8?B?MnJtWGRMVWk2QmtpcXN2WGM2WFZiSUpwcU8yUHVRZFpuazFvUnBoeVJ1LzFk?=
 =?utf-8?B?blFGa2VxSWd4ZWloamM3aXUzanlpY1hMdmRLSDFDVzBXZnRSMkt1bFp4MUFY?=
 =?utf-8?B?anBQdjY5T0NsME9FUlBJVWkzQTl5YkJLZTJzT0hMYUhSaG9aYVc5cFF2bGg0?=
 =?utf-8?B?M01HNThXRGhFMjdTTFZnaDB5aWJCZmlzM2NZZjQrQjZYYjRQQStSaTV3Rksx?=
 =?utf-8?B?bWtQVzI4SkIzTE1WWHdiZXU5WDJBUjloMFNBR01JL0N4ajlYbW5tWk5TTFF4?=
 =?utf-8?B?QzJTYzlwYmV4cllFVnovQkFjMzkrR3djSkZrMkkxbUgxOXJNaUpFUXpaS0Z3?=
 =?utf-8?B?eHpOMGpOL1p2RkpoSDlBL0RIeEQ2eXh0T2hheWZkOENkdEhJbXhKK0hlazJF?=
 =?utf-8?B?aGFTZEFHUzY4MXhZTHE4TC9jUW1uMitNV2RUOU5uN3ErbW1lSUxicE9HNmN5?=
 =?utf-8?B?Z09zMENPMGRGOGFBazB5S0VzZFZYNWw0eEhCbmx4dXNFVHJMRXp3S1BoSkJk?=
 =?utf-8?B?RnA3YTc1RVBCOGtOMGh6UVVnRjhXSUgxalM4T0g1Z1VLd0RiL1BMYjhjWXVI?=
 =?utf-8?B?VVZucGNBcTRkTHZzT2prTlZlWlFvdGI0NDB2bC9ISDNPSlFNSS96RG5idElH?=
 =?utf-8?B?WWEwemYrdlRjMTlNcVlMZVpLKzBUZTl2eE5vdnRIRUdxVkl1V04rQ0F1UUN6?=
 =?utf-8?B?TzNsVmJUN1pkWTdZdXQ2NS9HRGtJa3RLekVnYXpLbzlPYzBDY1VhRFVON3Rn?=
 =?utf-8?B?T1ovWXZJWFk3c0tYaDBDZ0JDby9SYjRLc1FlVS8rRHE1NnpXMDA2dXdBNHE3?=
 =?utf-8?Q?OKUI9cF1MFMjFpmknsgBeRVy0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f5b00f-b2da-48a5-614f-08de38b0c490
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 12:28:19.9047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cktScdmjKHtCDE9UrKzUo4aRAylTUbp5JnUp38/mA5DkzuyZB9RkZW1yZXLpjM9J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
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

On 12/10/25 21:23, Alex Deucher wrote:
> Avoid a possible UAF in GPU recovery due to a race between
> the sched timeout callback and the tdr work queue.
> 
> The gpu recovery function calls drm_sched_stop() and
> later drm_sched_start().  drm_sched_start() restarts
> the tdr queue which will eventually free the job.  If
> the tdr queue frees the job before time out callback
> completes, the job will be freed and we'll get a UAF
> when accessing the pasid.  Cache it early to avoid the
> UAF.
> 
> Fixes: a72002cb181f ("drm/amdgpu: Make use of drm_wedge_task_info")

Philip and I briefly remember that there was also a bug report about it a while ago.

But I can't find the link of hand, if anybody can find please speak up.

> Cc: SRINIVASAN.SHANMUGAM@amd.com
> Cc: vitaly.prosyak@amd.com
> Cc: christian.koenig@amd.com
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> 
> v2: Check the pasid rather than job (Lijo)
>     Add fixes tag (Christian)
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 8a851d7548c00..c6b1dd95c401d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6634,6 +6634,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	struct amdgpu_hive_info *hive = NULL;
>  	int r = 0;
>  	bool need_emergency_restart = false;
> +	/* save the pasid here as the job may be freed before the end of the reset */
> +	int pasid = job ? job->pasid : -EINVAL;
>  
>  	/*
>  	 * If it reaches here because of hang/timeout and a RAS error is
> @@ -6734,8 +6736,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	if (!r) {
>  		struct amdgpu_task_info *ti = NULL;
>  
> -		if (job)
> -			ti = amdgpu_vm_get_task_info_pasid(adev, job->pasid);
> +		/*
> +		 * The job may already be freed at this point via the sched tdr workqueue so
> +		 * use the cached pasid.
> +		 */
> +		if (pasid >= 0)
> +			ti = amdgpu_vm_get_task_info_pasid(adev, pasid);
>  
>  		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE,
>  				     ti ? &ti->task : NULL);

