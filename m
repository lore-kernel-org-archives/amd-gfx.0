Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC502C28B2E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 08:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F01910E72C;
	Wed, 12 Mar 2025 08:38:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YJei59F/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A044310E0ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 08:38:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYhXj5tOUzlBYT4COXMv8Une8u6UXtX8sZl5X67lbCCFCoIgPlf462z2Qv5Ui89hC7s2zKOHzkHyBYwpMztgWRjxiTq+40UW7SWeSMKJA3n5RSIC+Y6cAolvnxpBbrRyf4hmpFSmH0CoihA3cigbJyTgaYbKGz4BoydhkPMGvnXPi43qxQZXw/gKVddAf18OZ4EBw0drVfJe+8E5a6Fqp75QfsXkwdqCjxjQLSTuRmjtyRHN584nsFDUV5a5fHXjxJw0Q0GR3IACgsVyn5TzicG0mob67KdJ0bcLOK43rA82mLisZj+ZNCOIhMK/6OPSU/D4Rqb1ksuYE8pUi3YcEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnyTMp+cuzqITNQki6do00pksIEAq0ywCvWySSqu2t0=;
 b=a93ttD4ZmX2uzIXujCj8azOOvI+tQ5DBtKpPbEQnWKX2y4XSAScS8nnMFC3ZP2E2q8H5qG630SE/V5v6ttFK7srhQwVn/IdzvZaj+gCzzlAiUE0j8fmPzjWrqWLheh5e6ALnxq26KNhFwRAzJ8jnt61HrzDcbJpg7CTpX3gQ3OYJYMW3Gx9QxziLEBnleo1Vh7XPHbVjSQkpug1GAyi161mMan+Y3wkAGdyJdGdaAjjQoLrhqkAfSM1Zl7jr1YftE1M+yCPv8qcgjAIvksPAX4EG/x1SpnmSlUu7k2Uvv+2TrPzz2sN5Kh5qQG93HdgFj2D90251MzvXzTHHt+MdxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnyTMp+cuzqITNQki6do00pksIEAq0ywCvWySSqu2t0=;
 b=YJei59F/XC+ijpB9h6r2DDkmxctwWYMb7n4KoWGqfQBUtJynLSHVgZt8L2O+7wzdPuwCHQoDIvhGnST54o5AIcsoKExxZ6uLAtx7zKWvHw8YpJmfKEOoOPAqmphpCP25j335tDitM6b09DS05V6vHTA0Fp52qZZTs9dVFVfY2hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:38:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:38:50 +0000
Content-Type: multipart/alternative;
 boundary="------------yIwBE4ov7Tb4oLB12kvG9nyt"
Message-ID: <dcf2a1b5-f079-41e1-b310-79db0b927272@amd.com>
Date: Wed, 12 Mar 2025 09:38:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by
 removing dynamic callbacks
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
References: <20250312080003.3224976-1-jesse.zhang@amd.com>
 <0bc3ca8d-8a65-472d-ae63-ef570d08d1ca@amd.com>
 <DM4PR12MB515277590EC11D3757BB448FE3D02@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB515277590EC11D3757BB448FE3D02@DM4PR12MB5152.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR4P281CA0399.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 94250e5f-9d69-453e-9880-08dd61415056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjduL3ErSW53SFdkYWZSYjVKOTV4VWd5aUhaZ2pScDNaNGdVaXRnb29kQytQ?=
 =?utf-8?B?ZlJGVTJaTERmZDAwdmF6bnI3REtBUzd0OVkxN0V3aUVkVWpQbi92K0x3Uk1l?=
 =?utf-8?B?NUhid0pnRkc4Z0xQUlZEemVVN1l6S1ZsRjBRR3E2djVNREwrTE43c3lPdjlm?=
 =?utf-8?B?b0VkVUJhcm02TEZCeVEvb1grVW91TDlRazE4ak5XeHBCeXRUUlAwbUdNUUM4?=
 =?utf-8?B?N0Zhai82cFRlYVZBbUdWV3RUbmlpNmhySmJWT2tRUGdnZzVXcXl4ZW50NzJP?=
 =?utf-8?B?SGo3OXhQeGhnUFpXcjNXZkd1Z3ozLzltYklYendTMmRwdlByUTlmYjZkMG5Y?=
 =?utf-8?B?Nmk4NzhkZkRmTGFHckY4dHhXZGhHU0FNWmVhSXUzOWNwVG4wd09tdVVMSERB?=
 =?utf-8?B?RUFNOE1hbWRoSXpVSWF4R3hzcTBWMEVPeGRJOG82UjIzS25WK1d0Q3hRTU13?=
 =?utf-8?B?c0ZFNDNhWC91bUdiS2VEWDBxbjIvdnhMT1ljcCsxMS9qMDYzVUlCRkkvdDZP?=
 =?utf-8?B?emdLRHVmUUZpc29nYlNnaXFHN1BIMnBETyt1RUIzV1pLV2VhTHN5am1ieXR4?=
 =?utf-8?B?NUhITmNkbVBRc1pyNG1VVEh6ZHhBcnBFRDBqYlZRcDdpL2ZDc1B6SUJ2U1lp?=
 =?utf-8?B?aEFtaGZzV29vMytWNWJMTkFqUlBROVZvNmNieGs3dzlqMWxYSStIUEswY3RS?=
 =?utf-8?B?TzE4NWw3RTEzNkw3V205S2FwSU5rdThZODIrUUFPMTRCajg3T0xRWFlTZ3Vi?=
 =?utf-8?B?RzJpSGdUWWgyVGJjeFZBZWNvVllzWnVob0c2ZUtBMSt3RGhtTEVXWEtEQW4y?=
 =?utf-8?B?Z1JGb1B4Skd2ZmNUUzZYdGN1aEVjSmswa05IU0QwZTd3b3kyZ1dWNGZCOGZH?=
 =?utf-8?B?U0xtdzlvV0hBMTdlWHZLWHdMKzZJZm5WVkVxOVpSVFdGK3Axek9HMnRhZjZp?=
 =?utf-8?B?bjBkemNWejJzRVlPUGZYV29kbmNGQzA1R2dvTUwxS3BaeTdRbzhYTTY0VGV1?=
 =?utf-8?B?TFJPK2pYTnY1VEZpenBONGVXeXJtdW1SSzk2alR3VUZhek9vUitYVG1xYkph?=
 =?utf-8?B?cktkZmVpOVFKR2N2aGdkUjd3OVNhNkd0RW5YeGxEWjZtZHhMREMvUEhuK1NG?=
 =?utf-8?B?eUwzV0YvMHN0aTIzbVovMjcrTlliODNEYmVOYVlPb0RoL2d1cmVneEJKb2Fa?=
 =?utf-8?B?K1JkZ3N5UDM1QkxoeWJMN1dObXprOUx0UTBTWnc2eWlPRHpFNUdqRm9nNFZ4?=
 =?utf-8?B?VitZeUpxN05kbDlBU2Y4UnZkcmlMRHJicTQwTnplNDlpWTZEM3piT2NmNENU?=
 =?utf-8?B?L0RBZWJUV0RMLy9vQlFKb3VTOS93b2tJNzFaenlDUWZ6SGtZcG16RVZ4RlVp?=
 =?utf-8?B?eVN6WDV3dTVqUFpIcVRIczVzVDVvanIwSTB2VElncTMwTmNySUhiTUdUcmhD?=
 =?utf-8?B?VnpGb0NnSjNVbmNIWFgrNFFXcE0rQ1hBNGt3bVV5NFpNRSs3S2xyck9sMGx4?=
 =?utf-8?B?cVB3T2VHa2VDNnlhdzlCeFo5bVdQS0kyNkwwYnduSVppZnVxaXlmU0pEa1BP?=
 =?utf-8?B?dDlxaXhkUVNBSUMyRnpnd3E5Q2huc3dHWXpQc0JoUytHeEU2emJaVkQ3TFBV?=
 =?utf-8?B?ZHB2a09kOHpwVnFSTXZ6Z1BpbUNVZWFxdWxLMFNvTmhtT1E1a1VVVzRKejRW?=
 =?utf-8?B?QkdhLzhRYk9qT3lERm1UK29UL00zU2RGV0ZYaURpbVRKTzkvVUtLVkpLZ3Bp?=
 =?utf-8?B?QlFObDk0aHJzM0NLZFdEQWRad3pNbXlCUURweUtHTVFYbWJ0YjFBS1R3N3hZ?=
 =?utf-8?B?T0NXdzJmbk93cnI1UHFJSm5vTE9CNFRCd2pRRndOQUJXTnpXWGJwVTU5TFF2?=
 =?utf-8?Q?FLkwPCfu76mNk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFBhR3BUVCsrajNLOVFPekFISmUzUEVuaEVkcWJqYWVrVjI2bkVVeGgzRUIz?=
 =?utf-8?B?VkdXVHAwOHFETGVqYU16RUFEN2ZjM1AvTWxWaFd0YlF1ZDlxeE1tUjE3RzdE?=
 =?utf-8?B?V1cva0Jqejd5QktGQ2dsS2VSVFBsNkNWT1hHbjRZNVovZVRmSUwvNXRQdWwr?=
 =?utf-8?B?R1ZRQjFxOVRNSnpMOE13bm4yemx3QjhOeVlmSEV2RFhUd1M3Y2cyZm1MNStY?=
 =?utf-8?B?aU1qZEJzV05sUkdvRWZMYUxoU3U0NWpWaHc2QVJhYXhoVTlNL2VXNU5mV3pv?=
 =?utf-8?B?Q0UrbnJmRmFBRWxtMG9JL2ZSMm9seW1zM2R0N0JCVUFpeDMwUkNjSlZIVFZQ?=
 =?utf-8?B?ZnlzdHZMbk5hdi85MnZidXBodTJIWnJ6dkNXTWV6TW9vdmhORGtnaGYyMWdZ?=
 =?utf-8?B?UHhXdzl3QlR1bjd5Q0g5UWhyb2FVQ3VKMmoyOFlvZ0QvV0o0TGZRWHhiaGFo?=
 =?utf-8?B?WU9sUkxmNy8vYzlHVGh2UVRLSnBheUJzZy81bWdsNjE4RWxvUW01aHd4UXhr?=
 =?utf-8?B?ek5MK3RheDhpY0RWd3pPZEplNXBWQkx1M3pzbm1hUFJBMExmUWF3UDFCRGZN?=
 =?utf-8?B?SE1ZZWpoMWtyWUNWN3FiUXFSY21WeFhzM0xNSnZaWjRIemxGQTJYUUVkaElK?=
 =?utf-8?B?ZVdTRnR1MVdDQ2NPQmppQ0hMT29menArT3ZXR0dYOFBDcUVGY21wRHFNNmdO?=
 =?utf-8?B?NnVLeDZxaURIaWJ2SGJYZXRiKzE2K3g0STRMa1VsdGhlVHo2d3ByZmpsZ1dk?=
 =?utf-8?B?VE9yaElMeU5meXRDeVErZ2hwMnVzN3ZPK25TQ3lCd09BQ0xMV3NsUVhSaWpn?=
 =?utf-8?B?RGN1akIvL1ptY1dHSDg3VGZ2ZEhyL1JIZ3U1RGxhUnhpU3NjV05yUTAzU3Jj?=
 =?utf-8?B?bjRMSzJVa2lzcVNTZmdLYzdrNjFrL2lvZ1kxeWtSeldBblc4MGthOFFvZnVj?=
 =?utf-8?B?a0NPR0dyRjF0Wkw2dXg2emFoaXRoU0FQckx6WWd4cHlmQzhOUWtCU3ViOE1I?=
 =?utf-8?B?SkRCM0JlcVRBSlJ6eUY4ZVRpN2t4VDJNWHJxd1hhbzBnU21IeXc5aWQ4T0VQ?=
 =?utf-8?B?YWZxa1ZRZXVONzlTQ1RJNFFYMUwvREIra2RzLy9HSnJwc3AxVjFiRGxYOGFS?=
 =?utf-8?B?TWJKOTJEMHF5UFBEbEx0WWpHeTRhRG1vVXkzNVZRN1dOZ082UkM3TmtqMTdx?=
 =?utf-8?B?UCtjbVdzcmduSGxqWUtXVDNGblU2OEdBM1pDYjdzN3QwNjdyQTVWQW5TRnJJ?=
 =?utf-8?B?R0VxVkY0dnFNN2dpZjJ2TmhocG82TlFzUU5VVm9GOFVoS2Z0dVlmSWFxaUZY?=
 =?utf-8?B?V2xSbnVzalVkMGVYS2JaY0ZvckUxcHdiSEprbVl5ZVE2QnhxeVJOc2tpSmlp?=
 =?utf-8?B?S3NWaEFUNnl2UytUSGxDZTJucW4rSVczc3NjOGcwRmVDNDFmTmJYaThYSHZD?=
 =?utf-8?B?V1hOK2VTVXNOTitnMEM2c08rVHhyREZqVWhuRDIwcXhLc3BUeCt3TEFzQWZm?=
 =?utf-8?B?RFVjdWhnVmZOYU8rdFU1WjAzQk95Q2tnMGhDdnBPNHZDdmV1WElxNjBwT2R0?=
 =?utf-8?B?V3MwTFJGcytHNFpRN3lUdG95QTN6T2ZYRXpwckhpaTV2c29FTkVlUVc5MFM0?=
 =?utf-8?B?V3BGUWVBQXJ4dWd4RU9yZ09Ecm1MWnZsNXVRWCtlR1RudnZjRThBQWVYVlFw?=
 =?utf-8?B?eGZoSkhLQ0QrckF4b3UwUzVWcDZxaUNwakthc0NXRnVtcVQ0ZStwTUFid1l2?=
 =?utf-8?B?aDcrRUN4NHRJS0Q2Zit6WlVwOWFaTVlZSWpteWRIZ1N0Tm5KTlI2azdoZ3k3?=
 =?utf-8?B?RCt1cVQyZGtubG9VOVh3c2UxM084ZDFxWEUzb0h4TXB2OGtkV0JKVjhaQldn?=
 =?utf-8?B?Q0tjM0pvZHRieW1BSGc2U29EWXdtQzRVbW5LMm1GYVc4Q2NoSTRQUldpUEt0?=
 =?utf-8?B?VEd4b1haNXZKZ1hRUURZbTkvTVRmZlR0L1lwNDBabnhlek0raEw5RDNGQ3hz?=
 =?utf-8?B?amFKWU9veGlGcVdhRndNaDJHbkVtb2lWcG12eFAzRUNLK05QemtGNHBMYzlR?=
 =?utf-8?B?U2VsU3BtU2ZkcklBS3ljS1UrSXJsTGJRNlpyWjBrbXJKMkhGWUx5QUZZZGM2?=
 =?utf-8?Q?Y9NoeWSNjr9sXKddh9C8xKwvx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94250e5f-9d69-453e-9880-08dd61415056
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:38:50.7742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMtKR1vvdrVOnnbjL/n8KBhJ6ampqHUtzbp63oAvmfBgkduJ2/z+37ul8O02yE6Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230
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

--------------yIwBE4ov7Tb4oLB12kvG9nyt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 12.03.25 um 09:15 schrieb Zhang, Jesse(Jie):
> [SNIP9
>> -
>> +     gfx_ring->funcs->stop_queue(adev, instance_id);
> Yeah that starts to look good. Question here is who is calling amdgpu_sdma_reset_engine()?
>
> If this call comes from engine specific code we might not need the start/stop_queue callbacks all together.
>
>     Kfd and sdma v4/v5/v5_2 will call amdgpu_sdma_reset_engine, and start/stop_queue callbacks are only implemented in sdmav4/sdmav5/sdma5_2.

Why would the KFD call this as well? Because it detects an issue with a SDMA user queue  If yes I would rather suggest that the KFD calls the reset function of the paging queue.

Since this reset function is specific to the SDMA HW generation anyway you don't need those extra functions to abstract starting and stopping of the queue for each HW generation.

Regards,
Christian.

>
> Thanks
> Jesse
>
> Regards,
> Christian.
>
>>       /* Perform the SDMA reset for the specified instance */
>>       ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
>>       if (ret) {
>> @@ -591,18 +573,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
>>               goto exit;
>>       }
>>
>> -     /* Invoke all registered post_reset callbacks */
>> -     list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
>> -             if (funcs->post_reset) {
>> -                     ret = funcs->post_reset(adev, instance_id);
>> -                     if (ret) {
>> -                             dev_err(adev->dev,
>> -                             "afterReset callback failed for instance %u: %d\n",
>> -                                     instance_id, ret);
>> -                             goto exit;
>> -                     }
>> -             }
>> -     }
>> +     gfx_ring->funcs->start_queue(adev, instance_id);
>>
>>  exit:
>>       /* Restart the scheduler's work queue for the GFX and page rings
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> index fd34dc138081..c1f7ccff9c4e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> @@ -2132,6 +2132,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>>       .emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>>       .emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>>       .reset = sdma_v4_4_2_reset_queue,
>> +     .stop_queue = sdma_v4_4_2_stop_queue,
>> +     .start_queue = sdma_v4_4_2_restore_queue,
>>       .is_guilty = sdma_v4_4_2_ring_is_guilty,  };
>>

--------------yIwBE4ov7Tb4oLB12kvG9nyt
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 12.03.25 um 09:15 schrieb Zhang, Jesse(Jie):<br>
    <blockquote type="cite" cite="mid:DM4PR12MB515277590EC11D3757BB448FE3D02@DM4PR12MB5152.namprd12.prod.outlook.com">[SNIP9<span style="white-space: pre-wrap">
</span>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-
+     gfx_ring-&gt;funcs-&gt;stop_queue(adev, instance_id);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Yeah that starts to look good. Question here is who is calling amdgpu_sdma_reset_engine()?

If this call comes from engine specific code we might not need the start/stop_queue callbacks all together.

    Kfd and sdma v4/v5/v5_2 will call amdgpu_sdma_reset_engine, and start/stop_queue callbacks are only implemented in sdmav4/sdmav5/sdma5_2.</pre>
    </blockquote>
    <br>
    Why would the KFD call this as well? Because it detects an issue
    with a SDMA user queue&nbsp; If yes I would rather suggest that the KFD
    calls the reset function of the paging queue.<br>
    <br>
    Since this reset function is specific to the SDMA HW generation
    anyway you don't need those extra functions to abstract starting and
    stopping of the queue for each HW generation.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:DM4PR12MB515277590EC11D3757BB448FE3D02@DM4PR12MB5152.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">

Thanks
Jesse

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">      /* Perform the SDMA reset for the specified instance */
      ret = amdgpu_dpm_reset_sdma(adev, 1 &lt;&lt; instance_id);
      if (ret) {
@@ -591,18 +573,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
              goto exit;
      }

-     /* Invoke all registered post_reset callbacks */
-     list_for_each_entry(funcs, &amp;adev-&gt;sdma.reset_callback_list, list) {
-             if (funcs-&gt;post_reset) {
-                     ret = funcs-&gt;post_reset(adev, instance_id);
-                     if (ret) {
-                             dev_err(adev-&gt;dev,
-                             &quot;afterReset callback failed for instance %u: %d\n&quot;,
-                                     instance_id, ret);
-                             goto exit;
-                     }
-             }
-     }
+     gfx_ring-&gt;funcs-&gt;start_queue(adev, instance_id);

 exit:
      /* Restart the scheduler's work queue for the GFX and page rings
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index fd34dc138081..c1f7ccff9c4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2132,6 +2132,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
      .emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
      .emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
      .reset = sdma_v4_4_2_reset_queue,
+     .stop_queue = sdma_v4_4_2_stop_queue,
+     .start_queue = sdma_v4_4_2_restore_queue,
      .is_guilty = sdma_v4_4_2_ring_is_guilty,  };

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------yIwBE4ov7Tb4oLB12kvG9nyt--
