Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BA5D10F5B
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 14:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D77F710E637;
	Wed, 26 Nov 2025 14:22:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ijAJJOu4";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F31610E637
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 14:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXNRWnQlM3h+HGE0UbOmzmnOEzAfZvlSUqxFUlRoMz1IlWcVOZdAjusA35M53vC5+DMzGZsCaADOKg/FrDSrDGXawEyiLv16eYa/dwzc7jdUSIvELAO4pEM3fFqn+nR0vBH52/NSo7D064v4oMTebHbhf78R6DycIlB/eLJvuY5l0dzaiyoYM5o2KpFRLdBFdUTzJ4sgzyB83MJErNtgdLO8vi3J4HW6KNYv+XamWdVqTo3uP0n6BYutWWCqLr7NmKQndiZtQJP4n3vuAgxGRdmictJoc1b/NtbelJjzsJzNEMMKswx62vN0WJoCskHLJYVDajv4RtbTv+cli6Gzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1CA9RyFucTpyrURzb7lAjG3vd4JnDTHRJTDhyA/5+E=;
 b=C4Flwg6GSoUOGl516BbPv2tg+EzqfkoEPIpIkJBKrEn5vextIrrCuXW/j8lY/P0YTOFbNGGk5Vfv0gTIed08VAhhzySLTZV7VeNH7xxjm5aPbRGfRyfC7FxeehyYNF/Jhq8IJKD1OIQHu6LioGACJ6Ju6vS0VerMPlNiZBfgRGTyg1kT2C2qsGJAPpBw3HSB3J5QlLX95hzs7g+vP3WvcumQDpLSaSoQJuPoaQ5pYpaDlHuihxR/NzBPdAibqGW1VUhg3Kuj/SaCK8DlYEZx+oWxJX/FUYKkQVMKDvdq0W0ea8Jx/ATbS1EsCpUncgN3+Rr1XWiinh5k60jfmNiddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1CA9RyFucTpyrURzb7lAjG3vd4JnDTHRJTDhyA/5+E=;
 b=ijAJJOu4Fq0JA0pSqJQnykQY6Eqw6Wzy8PXoowW+90jC5dq1uVUgV/y3/AjcSiDuR8+8jEn2thOsyUAdd2PjvqyChB4/vtst+DU8yS0pFGWGLmwmqqLJCTDmvmGdsSgewOqJY/9b7nDWMyt84DRlUne262xdnlQjK/BJkrYwQSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 14:22:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 14:22:29 +0000
Message-ID: <b4747792-6f2d-4875-88e7-5ed953f94fd7@amd.com>
Date: Wed, 26 Nov 2025 15:22:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] drm/amdgpu: Improve page fault handling on GMC v6-8
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251126132952.150452-1-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251126132952.150452-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:408:fe::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 796a92f6-fe19-420a-10c0-08de2cf73b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1lNcDJvWm9zUFJHL3o5S0VjZi8vZ2dZV1VrNVNNU1RSdVkrcXNSSURUZ3dW?=
 =?utf-8?B?MkFTaStWTHV5WlpGeWwvRGFTR0o4SXlibXdNdnRHa1dlTWZUeUJKZ1NPYXBO?=
 =?utf-8?B?c0hlTEUzb25EV1FJWVNnZEp5NElFYWkwdEZzMU9kZmZHcjJnMEsrakQ0TWRn?=
 =?utf-8?B?WEp1NnlXNmRkWG1KanJtZTFqN25jWlFXL2xSSTI2cFFSbzRzOE02QUJmWnlp?=
 =?utf-8?B?b01sdGdzZDhOY29hcWdrTWNXV0dhbFJkVjJqSjZzRGp5ZjlPM0loUUx2SFp0?=
 =?utf-8?B?SU14ajdKYXIyVVdkZllHQkUrZFdabHo5VGQ3WE5xQ3ZuckcrMDF5Z0djdE8v?=
 =?utf-8?B?YzRMK3AvSXllRTQzNVRPNFMwTzZBck91VWlUa1N0eDNGY2VMdy80RHB2SnVR?=
 =?utf-8?B?UlpKelJrelVGdkUrWFhPdTVBVkFtTVN6N0lrSW9LTnh1cFByTUFFMGFJNUNL?=
 =?utf-8?B?bU02cDRtQ2JWWXdKZVJqMzlENTZ5MmtlOVVoMEt2d2tQZ3F1bXorclo5TENB?=
 =?utf-8?B?aUx5emdlT0JrcElHb1dha0hmdURxY01ETGdEMDhwNitPT3VPSFpZVG9FMk51?=
 =?utf-8?B?d3N4dGJ5aHhtRXdGQXVOTlhncWUzR2ZncUVZYnRiSDFOdVc0OTZkQXJGdzRs?=
 =?utf-8?B?K0I1cUtyMDI5N2xldUh6SkhjY3dLcXJQenZXR3dDLzIxZGM1VEcwWERSL0xP?=
 =?utf-8?B?QXBWMmViUml1MDlxSk5sRG9GbWU3RjBWM0RrZHU5WGYrYVd1S1BzR2l1UnRx?=
 =?utf-8?B?Nm5IaWh2b25Nek16SXU3OS9OL1RxWEx1d3NGd1NMSncxK1dGL2ozVnhHNm5J?=
 =?utf-8?B?L1FIS0liank3bmcvYXE5SCsyTGcvM0dIT1NBQVhEcmZZUmxWalVtREQwZkM2?=
 =?utf-8?B?UjdTb2ZCNVlBQjlFZW1UcXgxK0t2SHRmdHNBTmJUc21ZVWJjWlpQYk5pb2pW?=
 =?utf-8?B?ZC9vRm5BRWRUQXZMc3RYaWFwYlFRM2RLVVpqNVJsenVhaXVLR0l1L01nYy9n?=
 =?utf-8?B?NnhHRk1zaU5ZMHJYOWJLTmtoYVVtSmRZT3A5T0hzSk8rVTlOUVNvcnJTaUZH?=
 =?utf-8?B?WmtYd1N6UTNnK0lnQzJNN0J5WmhKeDJSUEhnZUVYUzdqZTh5TUplMzY4SlIr?=
 =?utf-8?B?c1IzQTRVcGlreEpBdUFIMUVqcWVJY2YrcFlORFJMTG9LOUo5LysxNkp4T0tJ?=
 =?utf-8?B?cWRUL1dVUmhPM0t6R3NockxNbGxrS1puUEUzOWxFb0N0UnRBR05rWUNnUDUr?=
 =?utf-8?B?ZG5pMElveHZBRkNUL1hOeitTN1ZXUVJEZVpiaVpycUQxU0R3QVRzcFN0WVIw?=
 =?utf-8?B?WEkxWCtYMTV6WmpheVplWVZzMzZKR0xEZTB1bjJ6c0hSSzVaZWpOdUJwUHZI?=
 =?utf-8?B?Ryt3N2ZjSE1VNlF4TVlEcHRaQW5oZ3NsS0RVdzhEWjhsaXBnSE9LdTM2d1RC?=
 =?utf-8?B?Z2Z2MEY0N1RDSWpEOER4d0Q0Qk5vVTRLQWZWRDhJZEM5a3dSRExMd01LcTdU?=
 =?utf-8?B?SysvYkdFSXhKSXU2Z3VPalNUUGg4ZmhBNXQ2WWlEemhOVGZhdDlJUVV4RS9F?=
 =?utf-8?B?eUpvVmwwYW01aHpuK1F1Ukg1U2pnR3QzK0lPUEJuMC9MeGtacDFwSk92OFZs?=
 =?utf-8?B?UVZiVjQ5YnRTTDJLSWRnMGtSV29FWjlaVEdyN0w0bXJxM0FrVEowUTRTeW01?=
 =?utf-8?B?U3BJOU52ejN1ZjZyYmxBVDF3TmhZSWF3RlRPOVRpUkpGUW1jY3hsdTgrTi9R?=
 =?utf-8?B?b3ZmbWpEN2xaZUZRdjUzc2Z1UXF2THM2ZCtycjY5TEJ0b054K1ZVVERRM05L?=
 =?utf-8?B?YTdPKzI1Um1ueWF0ck9wdkRxYU1HZWw5T0xWVXlQRXBhNXdIc2UwQVJQOUd6?=
 =?utf-8?B?NzhYcVAwcTU5MUt3eTFZL0ZNS01pZ0l1SUdKWnp5bmxFbmhhQWtnV1BJeUpp?=
 =?utf-8?Q?c0kJNPA1x4sJkwjJNrHnF8Ile0XwK3D7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVZqTnVTcUhLZ1FNeVdkZFV4V09sQmFIWDNjeXRRYnMxVnJNTWg2aENrMU9B?=
 =?utf-8?B?QVd3U0IwUUFPMUdFRGtudXROUG5henIrb0o0WVZJM0x2K0lMVFJuUHF6MXNn?=
 =?utf-8?B?U2cxV0h5ZWN4UGZIZm1QdVpicjNMaWtHcVZBeU5iK0NmTDc1Mm9td3QxTjIw?=
 =?utf-8?B?Q2lpR0ZxQmY1T1ptc0NIazY3OFQ3dUxENDRBNG5uMTRHdDZEajRtQzRkTWI0?=
 =?utf-8?B?LytOZWZuVzRGUlo2bmJYMDlLSUNPaC90dXpZMUJjbzU4UFRScnBYM25HYTEv?=
 =?utf-8?B?NnM0RWg2SXowK1l0cXlyczkvVmppSFhzc1psTXRyOW10b2NXak5TMll2RDB3?=
 =?utf-8?B?QzgreEJaQlk0UEpheWJmT1dlUkVXY3c5ZlhvM2gvNmVvc0JDOFFWamoxQmJR?=
 =?utf-8?B?ZXZHMVZFb2s4RUVRNDl2NDdia2xNOXBlYTlrVzVoWjU3cVBTMGFvQUkramxl?=
 =?utf-8?B?c1EvdVpLVm5aUklxSGQxVTJ0QldkRlYvTHVFV04zemZqR2txd1NmUHVmWnhn?=
 =?utf-8?B?ajlIMDJ6UEFkdzgzQTAydGd3eHRlalJ2dHArMWhZaS8vTlhtWmN1UnRQYUt1?=
 =?utf-8?B?VFkvbUhEZy85UkE0MWFVa2dmNTRVN2RQZUw3d3RNWDZEb1RXZjNDb0k5SkJl?=
 =?utf-8?B?NVZ5TE1ZbjNKNDQ0YjI0aDI3eUw4UkRNbUp5Z0JDZE0xOUxKbVp0TTgxYytR?=
 =?utf-8?B?REkxQytSRkVkem0xVWY5dWwvVnNlaWZwaWFURU1PdEhkT3BDaVVFRTNzYWNr?=
 =?utf-8?B?bWFiMHZhbVRxTmhvdTRCODVNUko3VkRZVmtTbVI3S3FuaDlCQkc2eG9lK3Mr?=
 =?utf-8?B?YnJFcXF1c3NjQjR6cnN4bHU4Qm01VDRvS1VQRWR0SVJzaCs5THR5VHB3dmx4?=
 =?utf-8?B?ZDBCTEFJT1kzWFlzMHZZSWdka3JBNndRdE96Q3FieTlrbEk3VVRjakdsRTU3?=
 =?utf-8?B?Q1hCWExPb0ZBMU5sSzVDU3NMQVVadzVUQkUvdysvN093cXdSbHZnYzUvVEJi?=
 =?utf-8?B?YWxJVHk4SllkNTFpQWNYOVVjWUkxQ05oQzczYzhXMnI5UzBzOVk2RXM1SWV0?=
 =?utf-8?B?VkVHbFJmVlFBU3greStXeWxOZVRzZnhYUStsOXp5anIxcStXa0t2TFh2UjVI?=
 =?utf-8?B?cGo5NmVsTUVXaE9FdkFSRC9QZGtJSlhTQ25nRzFtd3hDTTFucC9vYXVqS2dq?=
 =?utf-8?B?dEhWUDh0QTZhalpEWXNDQlJlRWNmNTRweHJyOE56QVBSR3hMRkRYNXZmYVk3?=
 =?utf-8?B?TzhYNzdoWVRTZWpTbFZvYzNVUnMza3ZYUGxFcWhCaVBUYWVNOFdsczhDMktD?=
 =?utf-8?B?UG5hYmJpcjdyR3pKY3ZqV0g3YmcwYlZLMkpiWENHUGQ4c1h0QUdpQTBsc251?=
 =?utf-8?B?QWxaYldvaWdaN0lJMmRycEYwcEc0bGhJRkovSTY0VWEzNmlKUGdzY0dxbXJS?=
 =?utf-8?B?QXNQNXFZWnY1aUdLeGdYZFNiYTA1RDVaNHV4ZFlmUWNydnd6N0p2b1l5czdr?=
 =?utf-8?B?WnNMRW9oTjJoNmNRMi9Za2NXa3VNa1Y5ZFpnQlhYQ1dhYjEyUDJDa1M1R2xH?=
 =?utf-8?B?R3dzVjJISjE1bGNYdnU0Tnd5VmU1V1FpTmZHc1gzSTNDSDE2cDg4RldhZ0kz?=
 =?utf-8?B?WTc2cTJrQkMzMWxsMXdsbnExZnYwZWdIZkpsWEhzU09ZS2FwcWFTcGppYm9w?=
 =?utf-8?B?T1E4VTlDZGdCM29OODBEZDNkRHRENTlmTzRmUjh6TmExS3IwTGh6UTF0K3RX?=
 =?utf-8?B?NGwyRm4zNzZCcWh0TGpRSE9TUk4weHdSNEVMd0FmQ1hVZlIvNnoyVVBTMDlI?=
 =?utf-8?B?aG5TTjh1R0Y4dlBrV0lCRGZ2RmExQTlRTUoyOGhXR3FBZmswTlNBajR3b0Mw?=
 =?utf-8?B?a1FJclROeno4bThBSHhuM2NCUVpNTmRrV0VpVzNMdlNMN05qT3hyTDdHY0dv?=
 =?utf-8?B?a09LcW82MjBHam9sSVVVR0ZuSW9taHIyc2dVTTg2cSs4ZlQ4eTh0YzBUWXM4?=
 =?utf-8?B?NlliV2FrZkFyYzRkVGsyS1FGNEpTY0F5RE5aUnpEY3hMZlh0MVpQMG5zOENE?=
 =?utf-8?B?ZHVyOGRzRkdoQlNOVmtGVGxHVUd5MkgrS29kVWIzdUpGYWhNZGdWeDFmVEo0?=
 =?utf-8?Q?ovlk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796a92f6-fe19-420a-10c0-08de2cf73b0f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 14:22:29.4919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ue4lXlAgxABpWHtlevh/SuLSdL7dJwICWrimFiE8+Lo0MYWIz0gi+g60bpTi5dp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
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

On 11/26/25 14:29, Timur Kristóf wrote:
> Enable the soft IRQ handler ring on SI, CIK, VI and
> delegate the processing of all VM faults to the soft
> IRQ handler ring.
> 
> Why?
> 
> On old GPUs, it may be an issue that handling the interrupts from
> VM faults is too slow and the interrupt handler (IH) ring may
> overflow, which can cause an eventual hang. This is a concern
> especially on SI and CIK where there are some HW limitations
> regarding robustness features with some shader instructions,
> which in practice means that users can see thousands of VM faults
> during normal gaming use even when the game or the UMD don't do
> anything wrong.
> 
> With this series, we spend much less time in the IRQ handler that
> interacts with the HW IH ring, which significantly reduces the
> chance of hangs.
> 
> There are also a few misc improvements to the GMC v6 code.

Reviewed-by: Christian König <christian.koenig@amd.com> for the entire series.

@Alex do you want to pick that up for amd-staging-drm-next or should I?

Regards,
Christian.

> 
> Timur Kristóf (10):
>   drm/amdgpu/si_ih: Enable soft IRQ handler ring
>   drm/amdgpu/cik_ih: Enable soft IRQ handler ring
>   drm/amdgpu/iceland_ih: Enable soft IRQ handler ring
>   drm/amdgpu/tonga_ih: Enable soft IRQ handler ring
>   drm/amdgpu/cz_ih: Enable soft IRQ handler ring
>   drm/amdgpu/gmc6: Don't print MC client as it's unknown
>   drm/amdgpu/gmc6: Cache VM fault info
>   drm/amdgpu/gmc6: Delegate VM faults to soft IRQ handler ring
>   drm/amdgpu/gmc7: Delegate VM faults to soft IRQ handler ring
>   drm/amdgpu/gmc8: Delegate VM faults to soft IRQ handler ring
> 
>  drivers/gpu/drm/amd/amdgpu/cik_ih.c     | 12 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 10 ++++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 20 ++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 10 ++++++++++
>  drivers/gpu/drm/amd/amdgpu/si_ih.c      | 12 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 10 ++++++++++
>  8 files changed, 80 insertions(+), 6 deletions(-)
> 

