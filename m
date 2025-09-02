Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF1ACA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 13:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BACCC10E6EC;
	Tue,  2 Sep 2025 13:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UXuHBxIR";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A92C10E6EC
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 13:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGJgODWo1KO651gZ/XXX5rjW5r6xlVuOt8wrYGXXs74zUovaxqYx2mthQFOylLYDRP0mSjcScCNp73KVVH4W1xcCkjoeaQL2GCJCj5lcom17meNsB2V51UszlGIWcc9MuX5A95Vkrm6LmPYnN8IkyT5T3mS/K+VgV5glcRe82ijSQk6rBT8eEeKmTb6tUcwD735I8pMHuvlnjYuJ9bKZ6oM6kmTuNwkfskAdXb9lYGID1g/utyP5TeusgqkK3yM/cLKoSV5BpuCDemFSoaqO8IksJw3X/aT4cafS934+HOiX2T69RHtM5Xz0NBF+8mnXqiAYODtAiEq1zVbQPJIoYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpdVKlbGeus8CJqWtERZPmSLdTgRCY+XS5EfBDEjI20=;
 b=cRFb2wmxnqFCW8V4kLGZ+d33OamA79coc4AmBholISud3gXoVfLUKmELth7t0QA6bMKWwysDUABP5Psdid9wAACTSQEAv9ZVdhnVOgziciWKQozBhT2W7vcb24QUuRafOL+nCPSvyZ9IxtgwONr3UU+frS6THEv4lz5DPdrdNYzZebXW4AlrdiL4H0GbLHp0oWOuPkZIq+ppGdZtgndgXWKlDUje7HSjA4yZ7PmQtq5E6pAlAaddQX2H04mLqXD4l3XwUBBjAPHOADr05kAYykogdcp7EGfMl311w4EHCRAIrHEj16Qwuj3U5jb3lDg2fnrLFlps5VLfinjOSMDQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpdVKlbGeus8CJqWtERZPmSLdTgRCY+XS5EfBDEjI20=;
 b=UXuHBxIRMM/gMqjQZIpEz7sJccm15eBCfcTTXontOVuV39VlxF7BVFJQBKMa+qIP1BNzsLucmCBMHTCp5q3lfum19ZTAthzLiodT3CXLK0h6ePwqAi8aWR5+lW0e8XoLzix1Mdqn4W7qTR/kbeZpiXD96nhw0Q1+1p8cvxQkr3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:27:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 13:27:09 +0000
Message-ID: <50b38fdd-93c8-4176-affc-6435aac7640f@amd.com>
Date: Tue, 2 Sep 2025 15:27:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP
 Singleton
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
 <20250902032938.468332-8-srinivasan.shanmugam@amd.com>
 <c1e61d59-b8e7-485d-8e75-34bc306a430b@amd.com>
 <CADnq5_O59on_=wt6ayS-JWY7ZVCzO0EdvikeQAAv6hG_++bZxQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_O59on_=wt6ayS-JWY7ZVCzO0EdvikeQAAv6hG_++bZxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0208.namprd13.prod.outlook.com
 (2603:10b6:208:2be::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aac03bb-99d5-41ea-b880-08ddea246b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUZuS3JodE1vYUdLZ3VDeXpMK25id1o3RTlnQ2hwVjBoL3gxazZIdERTTGcx?=
 =?utf-8?B?UkQ1ODBKYXRpV2dEK01tNFhxbFRRTDc1aGlueGdzN0xnWDNNRmZFTVBIR25t?=
 =?utf-8?B?WTh5Z0lNOHBhd0lEMTJiWGk5SGpyRy9jU0ZKakcwVnl6bkJuUk9GWFRTSFkr?=
 =?utf-8?B?ZEVaSHErVzRhd2NtTmtCV1ZRUy9yYkRFNEZkNi8xUVRheTBBa0IrTzBsM2l0?=
 =?utf-8?B?WVJtbjJyZ0M1VzEvU0lQRzFUY1M2MzFreC93UkJBN1E5cEhvSDZkaUdlTTN1?=
 =?utf-8?B?VklSWDZyMlR6WVFyRVVvZ3FZWEk3b0lKTHE5Vzd3ejAyUXNnK0JjT1ZyZ3hZ?=
 =?utf-8?B?TkszRWsxeUVBbE9lbVM1V0pwenYybTd1blFTR0hGU0QvQjJ0b3ViQUNzMDN1?=
 =?utf-8?B?ODIvSGxzV3dZWEM1L1dPenQwMEh1ZG5rbmJNUGRKRW94NU5yYkVGOHZYYmUr?=
 =?utf-8?B?M2l4NldIVGdxemlIR2pIVlRkUzgvYkFSSmp6Z3RwbG1mZnlSbzFLRWhvSGZh?=
 =?utf-8?B?K2hHZjdpWXpDL2wxeFYyd044c0VtNThWelZRd3I5czBRaGU5d3hIQmRhaE52?=
 =?utf-8?B?Vk5zcjM4RXVGSGQ1TEhoaGljcmdJanZ6cTNXVTlSUnZyOWF0OXFYU1p5NS84?=
 =?utf-8?B?eEYzbEhZRHZjQUQrKzV6VHR4MVpkazFVRFJobGpvSDNkcG9SZGYvVkRuSm1F?=
 =?utf-8?B?Rlg0WS9UTG1kQnpqd29nZC9VOHFOMkZxd1VqNytjRXcya1lMdGxPMlFHemtP?=
 =?utf-8?B?MEFYYTRzOUQrc29EOFJ0eGplelpMZjNuV00wa1cwREJxSm0xcWRVY1dldjhX?=
 =?utf-8?B?cDZHQUMrQkhKL0MxK0lGTE1YakMyTFpQaEN1L1FVNXY0UVkzaGNJMzg2dVlo?=
 =?utf-8?B?VkFPOElmbDBIRW1VOG1DTzdaRW5SVTZodzl5T2l1dzVHQlRQTXYwaGdIQlpl?=
 =?utf-8?B?Z1BVZ3ZlbTQrZDNkNjdvVnBPeElTSGxYM3RKZCs0SWdsTHlDZ3ZkRk8wMzRh?=
 =?utf-8?B?WXB2bXArRkpNRUQvbGRuS094QTVNanVtYUJpcGlkZVJLWXJlekNNZTNldk5x?=
 =?utf-8?B?TWZpczVzV0ExVDdORGtPMkFUQXcxNlRCcE5jSlBWZFA1bnhHQXpZbDc3V2JK?=
 =?utf-8?B?ZmZYb2ZBSkt5OU4wNkczYklPVDNWblAzWklXd0UvZUN1STZNUG1EalFHV3pC?=
 =?utf-8?B?bHNiaUFrMkluOEk1UFdSb29XUGh4Vk1UcWVIY3VWWWROTjBKeXJZRk1UVFVM?=
 =?utf-8?B?UHZsZ1N5WUpwa2ZtalZnZnp5cmYyMmNleG1BUXNHQkVrc2pVZE9iRjh1SmxG?=
 =?utf-8?B?YmtHRUptM3VobkxoK2gvZUV1Y3cxTFQzTWtRWTBvQVpKZWVZSWE3Wkt4ZlFm?=
 =?utf-8?B?c3JscEVORGdDSlUrbmxtRUpiQjhDWk9pQ05NcHhmQlJScWtUVlk5NUpzQll0?=
 =?utf-8?B?WkoyT0s0MTBaQ082eUdCQy9IVmxveTczTThKbCtVY3FMcVRhM2Z2ZFMzRUFS?=
 =?utf-8?B?bHBlQ1Jndk9BZU9oVEw1dFZXcXdMajJEL0oxZFhyZkxiMS83OERIY0lRb1Qr?=
 =?utf-8?B?cytiK1VQbld2Wk1ib283VnBvd0x2YzU0M2xaL0pubUhGU0o2Z1ZzY2w1L1RH?=
 =?utf-8?B?U3hIRFplS3E3bms2UlBjb2ZGamFIeDlSeExVQTZUbGp2L0JRcVZreVdtdHZj?=
 =?utf-8?B?VkZMSXRqYVNNK2ZKSUxEdVBabG5ia0l1dGtVRUhmRm5YT1NyL211b21XMElt?=
 =?utf-8?B?SThhWmt6T2ZCMDZZdkNWcEJ6L0N4eUs4Rzk0ajlNWjdsZFhCenFCZ3BJdUJ2?=
 =?utf-8?B?dEloakd3TjRZK1VhcjFsNkFkQXhlUHk1VUE3UXEyNCtDTVNpRktsU2tnYnYz?=
 =?utf-8?B?dUUxbUlmRUNyTk9BT1NGZ3BHMndCMjFnRUE2VWlmMUJ4a01BVkVsYk0welN3?=
 =?utf-8?Q?jN7cRga2kzQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emVRdnZNT3RQN3VualM3NlF4azBramhLazhVNXpZMldrL0xtbmRjV1lrSU5L?=
 =?utf-8?B?d3F1b1Y2d01ZWWQ2REhDZ3NqbWI2YytQUUdha1YrZGJ6N04rN0xmRnVoZE15?=
 =?utf-8?B?UTR4RjJtb0l0SEhtZkx6bE10bVJBTTdlTmlrVW02aVRrM0UzQjB2dG5xc0p5?=
 =?utf-8?B?cHlZb0VUd2gwMlN1Mlo2Tlh4R3ZMRk9jQmM4NzNrVE1CYzhlQmxlNktIZ015?=
 =?utf-8?B?M0p6RkVUY3V0Zk9LYzRSUFQ2cWNMUXRpUUlHTEVVOHpxaXFVc0Yrcmx2Ykxn?=
 =?utf-8?B?K1JxWENEd3VHUmllbENoTXlmamkyWUhrWkZ6U2dzTllFM0YxQ3ZXTTdvZ1k1?=
 =?utf-8?B?RTB5WUhrSG9kbWdJOTJLVWNWSDdhOTZaWjdTT2h1L29HRUZBWi9iT2daOEln?=
 =?utf-8?B?K01mS3RZVHFSZ1dKMHh6TWp6ZDlTQUZKNGplZlhKcTI5UWNDSm54M0hKYk92?=
 =?utf-8?B?UENndjN5eDltWm1aMWtxVjBCMnlkWm9LUmdtSm5CbjUzV1Rpa01pVHYwSGlW?=
 =?utf-8?B?RENBeU9EaXpDUU1Rakp4M1RuSloxVThKTjhxUEV0czN6SGJhMkNYVDNDRGZX?=
 =?utf-8?B?MUpuRGd5QS9veGhaWDNZUGl0UUxjVS9TZCtnT2pyL3R1UjN3WE1lNTZRU2sz?=
 =?utf-8?B?czdiMTFOc0p3N0lvYm1nV01PYS90dDUvZk9FZytVSEZ6ZVlpQW94TWp3NEZ2?=
 =?utf-8?B?eFFjNWNoMXdhM1ZSeXU5MXlCL0lJUzVGSGZKVXo5cS9WZkN0VEZSaXNYUXB6?=
 =?utf-8?B?SHpsT0dKQXRGNnlJNTN4YXZ2QWZkbStIQnIvd0tXaHR6THNJVmxrb1pHTmxk?=
 =?utf-8?B?dGJROGhBK3Fod3ZjT2FTWmFrRGZlMmFtc05OTUhCTnIwckErQkl6Mllad3dV?=
 =?utf-8?B?WWZkam41Uzd2d01iRkdFeDloYVVUb0FnbDExVjBLYkc1emhKeDM5VS8rOTUy?=
 =?utf-8?B?cmRRa01zcERVSXhsL2Jyd2VBVHpWT3pTTVdzd3lFbWdHaFhEZ1NBMFpZMzlR?=
 =?utf-8?B?SmkzRUpiVUdRSVFLQWV6MUNQRTJhOVBhMnNKV0M0bUNuMWJ2NnJWVk5GTjlE?=
 =?utf-8?B?NjViU0xOM3o1TmpHVEZrSlJDa1FVUG1WRVhNMmNNc0hmamVmanNScDhEREZh?=
 =?utf-8?B?REJDdlBOWHE0ZCsyVTBNcTRzOWFPdk9UWU5NUzE4dkE1aEljRzVyUG9YKzRX?=
 =?utf-8?B?N0JCeXRlamtJVWg5dFprTHJhQ3dNakVWclRJL2VuZ1dGZU45U1lqbkZ0eVVZ?=
 =?utf-8?B?UDRRRG5UTTZ6ZnMrT0o1eFRGSzBaM0poWCtiRkE2VE56OXo0cFh5cjlEVnR2?=
 =?utf-8?B?RmZ2NFpua3hnWHpvYUpsTGl4RkdSc1k4aTBzTnh2NTZMbUJpRlM4V2JiVXpX?=
 =?utf-8?B?ZzNlOG5GZWtQT3ZVS2l4NTRYN3JuTUEza0dGcTN2dHhuS3pLRGR2dWNjbC9Q?=
 =?utf-8?B?a2Q3Qm5IQW15a1o3cFdpNnZlUkV4K1ZDRjgzOXNlS2wwT1RrbWxZYmU5ZW9U?=
 =?utf-8?B?MTBZbjdBdHBVZzhaRW9KbmJsZHBOMHBuMkgwL1lKd3MzZFRUaXA5M3I1QmpZ?=
 =?utf-8?B?aXozRG1xeFkzMCtmUWE2aEJsTGpEWnVGT1JsR2dHVWk1cElPZGwxdXhUcjE1?=
 =?utf-8?B?ZEtCVndDbUdQUnRyU3dmMDdVS1pTS1Njd2pWblJRVXByL0hTdC9rWldCOUk2?=
 =?utf-8?B?Rnp6eUFUZHVMdTBnd29NNXliK201RXRkK0VNKzhkd05hMW1hTDZ0M2xXVkdi?=
 =?utf-8?B?RThQQmcycStWY0xSczVHempNSUZMYk5pc3VLdzc1d3pKS2FwL202VjE5SUlv?=
 =?utf-8?B?MW5MRTRYV1hVNDduSFpYK2hNajZvSmdiUWE5NkR3YWtrVkx0dXlNZDRIVnUz?=
 =?utf-8?B?WjJadU83SElFdlRMZlp0dmhYOWM5QlVSMXFieE5nejNsYzV4NHRmOXdlSGRI?=
 =?utf-8?B?aXc3VTNhM0xjM05mVVBmdUNGdTB6Q3dtR0Q1WDBQUjh3c0NlOXBDWDJZUGxV?=
 =?utf-8?B?ZCtUQmRycjZiYmUxYmMwb0N1SUtyeUluS0Z4RVBLUnlrWVY3OGJva1BzQlRV?=
 =?utf-8?B?K01YQ0k2TUI4T2NnL24zWndzSlFaVzRzWGd0VzBXUE95RngzSEkreXBlSCtK?=
 =?utf-8?Q?FKPNd6cVFZkVg2eC04XQ55b0h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aac03bb-99d5-41ea-b880-08ddea246b3d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:27:09.8249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Dt7Yr4vRRsHK7GsQN55BJIqJa8fM8go4+LA1IZz+J9HftiulXZg/BFIlM3qbV3T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541
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

On 02.09.25 15:25, Alex Deucher wrote:
> On Tue, Sep 2, 2025 at 3:38 AM Christian König <christian.koenig@amd.com> wrote:
>>
>> On 02.09.25 05:29, Srinivasan Shanmugam wrote:
>>> Add mmio_remap bookkeeping to amdgpu_device and introduce
>>> amdgpu_ttm_mmio_remap_bo_init()/fini() to manage a kernel-owned,
>>> one-page (4K) BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP.
>>>
>>> Bookkeeping:
>>>   - adev->rmmio_remap.bo : kernel-owned singleton BO
>>>
>>> The BO is allocated during TTM init when a remap bus address is available
>>> (adev->rmmio_remap.bus_addr) and PAGE_SIZE <= AMDGPU_GPU_PAGE_SIZE (4K),
>>> and freed during TTM fini.
>>>
>>> v2:
>>>  - Check mmio_remap bus address (adev->rmmio_remap.bus_addr) instead of
>>>    rmmio_base. (Alex)
>>>  - Skip quietly if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE or no bus address
>>>    (no warn). (Alex)
>>>  - Use `amdgpu_bo_create()` (not *_kernel) - Only with this The object
>>>    is stored in adev->mmio_remap.bo and will later be exposed to
>>>    userspace via a GEM handle. (Christian)
>>>
>>> v3:
>>>  - Remove obvious comment before amdgpu_ttm_mmio_remap_bo_fini() call.
>>>    (Alex)
>>>
>>> v4:
>>>  - Squash bookkeeping into this patch
>>>  - Place longer declaration first; clear bp via memset
>>>  - Reserve + pin + kmap(+kunmap) the BO at init; unpin in fini
>>>    (Christian)
>>>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 87 +++++++++++++++++++++++++
>>>  2 files changed, 88 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index ddd472e56f69..24501d3fbefe 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -752,6 +752,7 @@ typedef void (*amdgpu_block_wreg_t)(struct amdgpu_device*, uint32_t, uint32_t, u
>>>  struct amdgpu_mmio_remap {
>>>       u32 reg_offset;
>>>       resource_size_t bus_addr;
>>> +     struct amdgpu_bo *bo;
>>>  };
>>>
>>>  /* Define the HW IP blocks will be used in driver , add more if necessary */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 1a68ba17a62d..0d03e3a6f92d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -1854,6 +1854,87 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
>>>       adev->mman.ttm_pools = NULL;
>>>  }
>>>
>>> +/**
>>> + * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton 4K MMIO_REMAP BO
>>> + * @adev: amdgpu device
>>> + *
>>> + * Allocates a one-page (4K) GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP when the
>>> + * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the host
>>> + * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a regular
>>> + * GEM object (amdgpu_bo_create).
>>> + *
>>> + * Return:
>>> + *  * 0 on success or intentional skip (feature not present/unsupported)
>>> + *  * negative errno on allocation failure
>>> + */
>>> +static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
>>> +{
>>> +     struct amdgpu_bo_param bp;
>>> +     int r;
>>
>>> +     void *kptr;
>>
>> kptr should potentially be saved in amdgpu_mmio_remap.
>>
>>> +
>>> +     /* Skip if HW doesn't expose remap, or if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE (4K). */
>>> +     if (!adev->rmmio_remap.bus_addr || PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
>>> +             return 0;
>>> +
>>> +     memset(&bp, 0, sizeof(bp));
>>> +
>>> +     /* Create exactly one GEM BO in the MMIO_REMAP domain. */
>>> +     bp.type        = ttm_bo_type_device;          /* userspace-mappable GEM */
>>> +     bp.size        = AMDGPU_GPU_PAGE_SIZE;        /* 4K */
>>> +     bp.byte_align  = AMDGPU_GPU_PAGE_SIZE;
>>> +     bp.domain      = AMDGPU_GEM_DOMAIN_MMIO_REMAP;
>>> +     bp.flags       = 0;
>>> +     bp.resv        = NULL;
>>> +     bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>> +
>>> +     r = amdgpu_bo_create(adev, &bp, &adev->rmmio_remap.bo);
>>> +     if (r)
>>> +             return r;
>>> +
>>> +     r = amdgpu_bo_reserve(adev->rmmio_remap.bo, false);
>>
>> The last parameter should probably be true here.
>>
>>> +     if (r)
>>> +             goto err_unref;
>>> +
>>> +     r = amdgpu_bo_pin(adev->rmmio_remap.bo, AMDGPU_GEM_DOMAIN_MMIO_REMAP);
>>> +     if (r)
>>> +             goto err_unres;
>>> +
>>> +     r = amdgpu_bo_kmap(adev->rmmio_remap.bo, &kptr);
> 
> Can't we just skip this?  We don't need the CPU address in the kernel.

I thought you suggested to use the remapped HDP registers for the HDP flush in the kernel as well?

If we don't want to do this we can just skip this.

Christian.

> 
> Alex
> 
>>> +     if (r)
>>> +             goto err_unpin;
>>> +
>>> +     amdgpu_bo_kunmap(adev->rmmio_remap.bo);
>>> +     amdgpu_bo_unreserve(adev->rmmio_remap.bo);
>>> +     return 0;
>>> +
>>> +err_unpin:
>>> +     amdgpu_bo_unpin(adev->rmmio_remap.bo);
>>> +err_unres:
>>> +     amdgpu_bo_unreserve(adev->rmmio_remap.bo);
>>> +err_unref:
>>> +     amdgpu_bo_unref(&adev->rmmio_remap.bo);
>>> +     adev->rmmio_remap.bo = NULL;
>>> +     return r;
>>> +}
>>> +
>>> +/**
>>> + * amdgpu_ttm_mmio_remap_bo_fini - Free the singleton MMIO_REMAP BO
>>> + * @adev: amdgpu device
>>> + *
>>> + * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
>>> + * amdgpu_ttm_mmio_remap_bo_init().
>>> + */
>>> +static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
>>> +{
>>> +     if (!amdgpu_bo_reserve(adev->rmmio_remap.bo, false)) {
>>
>> Same here.
>>
>> Apart from that looks good to me, feel free to add my rb.
>>
>> Regards,
>> Christian.
>>
>>> +             amdgpu_bo_unpin(adev->rmmio_remap.bo);
>>> +             amdgpu_bo_unreserve(adev->rmmio_remap.bo);
>>> +     }
>>> +     amdgpu_bo_unref(&adev->rmmio_remap.bo);
>>> +     adev->rmmio_remap.bo = NULL;
>>> +}
>>> +
>>>  /*
>>>   * amdgpu_ttm_init - Init the memory management (ttm) as well as various
>>>   * gtt/vram related fields.
>>> @@ -2028,6 +2109,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>               return r;
>>>       }
>>>
>>> +     /* Allocate the singleton MMIO_REMAP BO (4K) if supported */
>>> +     r = amdgpu_ttm_mmio_remap_bo_init(adev);
>>> +     if (r)
>>> +             return r;
>>> +
>>>       /* Initialize preemptible memory pool */
>>>       r = amdgpu_preempt_mgr_init(adev);
>>>       if (r) {
>>> @@ -2091,6 +2177,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>>>       amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>>>                                       &adev->mman.sdma_access_ptr);
>>>
>>> +     amdgpu_ttm_mmio_remap_bo_fini(adev);
>>>       amdgpu_ttm_fw_reserve_vram_fini(adev);
>>>       amdgpu_ttm_drv_reserve_vram_fini(adev);
>>>
>>

