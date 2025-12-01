Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B244AD116F3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 13:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DA7A10E3E0;
	Mon,  1 Dec 2025 13:29:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cwzq/x5x";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC8210E3E0
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 13:29:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wb3xDtToyxjqTMP87Yu13fxwGHUw+I7qgBRA6QBJ0TjJsARbchG4Kn3Rfxl3zE4z5JaeYS0QP50u0rqrnmUivnrdo/loadQgPNibRIxRV8rgIwzJyE0+x3YzUDaiWVpuML7QC4Ei9JcfiD8LyGa5dz74WbaqyKJzMrqk7DPaLQ4TNKINkcO8MkCjWE4WFweYMyUWVCyVs7ZiPQGo+Pj3OZ8DdNCgAhxSW0e8XDt27URFQALnwhyDRSKX5/+O9vXxRB4V2eNE8yyMIIHTirlIHrRSg6rGLm8WuX/MQCyeg0rB1tPSwv+JbC5gGHf1soSx5ycLUPcmW36AGk6ACDWaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzvxzCSbL9dxpx6gnggX2XjDrrfXTeJiAighWTci7xY=;
 b=tHGZrrbGuBsS9zU0Q7YO6DxgOAVToUq1sTj6+EvH1Vjn/+LcfXdqewTaLWQOvE66r9FfiOH43TiDBMG27cmWOGsssri0r+o7YreN6UkujRkxltJRdoUX67Inzbex7uGrLopKokka28Uuw/XLN3YjDhTE6GnavHqaCpK5gidnCAeo4afu5NhmW+cAIG6kPrLvakHxG0EfhUWUcoPtpBVl4MYxz7rZxZGgXCF5eaO2New3q77MlkHhx18xegy2H05Dqq2DyvNHreph36IUSiIoa6+sPl8G/oXL9zWkMDrjXVaTmtcRWfpPEXBejL42aKptgbCAaWIn6z2oTs38F2pfyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzvxzCSbL9dxpx6gnggX2XjDrrfXTeJiAighWTci7xY=;
 b=Cwzq/x5xCa8omk8eq+GXZ567SxSyrGAj7ZJ1A8H6R00x6Xbs00NlsGOAAHsRI6o0yOz/01hU0IOT0oVeNjagleMAXCpxenY/ccQxvqLEGduSimrSXBOkXYj/x+K3Y3j7QiJ/JmbJoijFWCzTuffhwnhtC7pN535eEyU5zdiUf/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 13:28:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 13:28:57 +0000
Message-ID: <63e12180-1764-4a1a-a27d-5145a4af3bd5@amd.com>
Date: Mon, 1 Dec 2025 14:28:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Allow direct CPU drawing of DRM panic on APUs
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 Melissa Wen <mwen@igalia.com>, Rodrigo Siqueira <siqueira@igalia.com>
References: <20251128150814.11612-1-tvrtko.ursulin@igalia.com>
 <eef300e9-9368-43db-b148-f31453031f88@amd.com>
 <9cb701a5-76a4-46c4-ac72-8812decbc1c6@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9cb701a5-76a4-46c4-ac72-8812decbc1c6@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0849.namprd03.prod.outlook.com
 (2603:10b6:408:13d::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 0906fd6d-9bd8-454e-3cdb-08de30dd93b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHgzVjVMV0ZZazZYRFc1VmFZTjlnSVNQekhyYW94cFBGQkJZUFhJRWRGSEIr?=
 =?utf-8?B?Tm5rSFlaVHp6bGM2VDlJZUhxeFF1b3YrMENBYWlzdk5TOTRNMi96U2EzdzhF?=
 =?utf-8?B?ZklaMEhMbGM1YVh1eit6YnhaNUE1TWdjOEUrWEpFUnV0RDlXblQwblFrYU11?=
 =?utf-8?B?ay95UndGUGtGdDF3cUh5c2pYWUQ1cVFJWHNoQnY5ZWdFM1ZNMjYwaE5ldTR0?=
 =?utf-8?B?MWtBdkV3VDhJR0dTRlVsUnFuMlZ6RDEzVnBQOUg4dkliYlRMdFp1RUljdVBl?=
 =?utf-8?B?cXplajB4QjlzRXc4YW1aeTFNMWhDUFR4N0QrbUw1L1M5amV0Y1VYN0NvQ1hH?=
 =?utf-8?B?RnZzdnJuM0Y3d0JzaUl6MUNsTG93Rmg0UHhHNkx4cmdwU3VVcGkybEtobEFu?=
 =?utf-8?B?VEtBTE9UOW0xNHI5U0dJdUJUZTZNeTgrb1h5Z2h3czMzdDdUOERKMWRPR0py?=
 =?utf-8?B?eXdtZHAzanVYV293aEQ0SDBTV2ZNOS9neU93ay95eW9TaFNEZW0xQkpJRmdu?=
 =?utf-8?B?VkFTMGptd2swOWw5NVBXLzcxSlFscTFNQkR5MkNaWE43c3pWQVFMcml3clcx?=
 =?utf-8?B?WTdIdW4wMk9nTTEyekRMeUhsT3JGMllLWmpJc3MxWFhnY2ZzKzFrZWVKNk10?=
 =?utf-8?B?YnlBRHE3M3Npdkg1SVRRUGMxSXlwSkdNZ3hRbng1TFBwVGxuODFTcWh1ajJx?=
 =?utf-8?B?U3MzaEVkNW4wbk92K0N0aHhHK0xuQXhXSTB4SjJrMEJ3SnZFL1l6ZGlSVzZT?=
 =?utf-8?B?bTNjeDRXbG4zN0xYS3ZCcDhmWjlRa0xCbnY0NTREYWJ5WVc4eEhKdHZEcEdm?=
 =?utf-8?B?OGkwWDRzbElsb1pxVzBPSkFPblU4ejJ4RGR6Qm1XSWw1ZGwzdGlRV2VtMk05?=
 =?utf-8?B?V0J3ajZjNHduTWhqNmQ1cjlKWm5LRGoweC9keWdRZEU1QjVtV0cyZW54NjJB?=
 =?utf-8?B?SDZlbHAzVEhyeDJLM1ZiMXNCMEMyLzk2ME9UMHpvS3dHdnRDK09sR2wwSFlS?=
 =?utf-8?B?NVJKMlhPMnBuV1VCTFJNREhMMG1KMmhRS2NHa2JjWjRUWDZqcTFSY1RxMUto?=
 =?utf-8?B?RTFwOVc5a2U3RHV3ekhvazlGeEdTWk0rSkF4TVd2Mlo0eEVmalRsS2R5d0hR?=
 =?utf-8?B?eUc2UGRVRW5yQjNkRm5IQ0VzdWRCd0g3Rm0xMjl3aUtKbUtOWlgzZUZBSGpU?=
 =?utf-8?B?cnZvL1orRitDRll0Yk94bWVYWTE5bi9iWlFPNDh0Nk8xYWFMc0M2cE40d1JD?=
 =?utf-8?B?VXNWTXVnWU1oc2pVY1hZTmN5TjBzb3NYZmVFQWM1VnN3YnVwLzRzUVNDVWdw?=
 =?utf-8?B?ZWQ1bjE3N3JSbytjOEl0eWtmNXdQU3NKaFBtTTFNQ2lmL0IrTEZUTzVvVUxi?=
 =?utf-8?B?alk1R2Q3VHBwOWlpS2ZVaHAwdTh6dHZianVabTJsamZ3b3ZLQVcxYUZ0UDNN?=
 =?utf-8?B?Qm10VDVuQTEyR2ZCbzczSWREK0lHbk9uS2FCTkhwWWZERE53VnpjWCs3eHZF?=
 =?utf-8?B?STRFWVl3TnBSbjl5M2FObDB0c0tGMXhYSzZGdXQzWk03V3BBNmNjcjcyMkFV?=
 =?utf-8?B?c1ZDL285dnkyWXoyVUM1cVhyWXlpNVpNT0VEeGQ3M0M4ZTcyV29scVRCZW5a?=
 =?utf-8?B?U0NXV3dLTjc0UmZoTUF0SysxUXdKMWszRnZOSmpGdlk3T1RlazAwL21kNlJC?=
 =?utf-8?B?R0VWNDJuSE44Nm45RlI3Zmo3Z3FJN21LVTh6RlFjc3FsY3NnWFpCZm9qbFVC?=
 =?utf-8?B?amE4TmtBQ1Vhdmd2VDQ5K1p0RmliTEFURDdLOGsyZEdmQ280Y2FFc05ZSmxl?=
 =?utf-8?B?T29OUThhRHZSZVhlSFcxbTV2RzEybHNaV2lKcmlLSCtzSU43V1FoOTNRd1NM?=
 =?utf-8?B?eWo5ZkdTdVVlemlodGFBTHZoNzBlUmpkRWV3R2dGN2hNSXVEREplWi9DUWRF?=
 =?utf-8?Q?NNlKN7nVvjG2zb11ZQuvREhTXrxHadVK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFVaL29RTWljOWRuZEZCMjBOdjJKTjk0dGx4cHFsekY5WHJpWHdpM0wxQ1dY?=
 =?utf-8?B?bWxHRlR3R0hTWjROT0VUOHprQkpHbEwrWWdDQ0xDMzBJUE4xRFJOOHVjcHUz?=
 =?utf-8?B?VHU4YlY2RzB5MURpczh2NEhOYmpXOUtBZDgxbS8xZ1V3bTRwRWZKVXptdzZz?=
 =?utf-8?B?RktVbFFjTFhCM2xFSk9oR3BRVmFoYm43V2ZOSnFOQ3VHTVNRVjduT1orK0U5?=
 =?utf-8?B?Wld5VjhOSHM5dnRkQ3V4YjNTc0VlZUZLTFhncFdVRWRrdjdnYndkcVNIYkVi?=
 =?utf-8?B?ZytkYTEwMU0wT29MUWYybVFobjJKeFdwT013S0lic3h2NzhHUWo2Uysxd2cy?=
 =?utf-8?B?OGpTZmRjNFJKeURpbnlQL0ZRN05YRkV1eGFPNkJsS3o3TitibTR2dkRPcjI3?=
 =?utf-8?B?Um9SNFNyemhndm9VQjhLbkR1U2F4eWVXcEtDdmErNlpka3B0Y3EvaHB6cXR5?=
 =?utf-8?B?M3pyQUJFM3E1c0R6bnNZVHJCRnk5N3VRZTZBYU5tR2k2UHpSNGM3Q1NoTzJY?=
 =?utf-8?B?OU9sbHc2NVlGVUtKL3ZOeW43NDFiYllubnd3ck8yZUNDQVpFT1NYak5QVWtr?=
 =?utf-8?B?Yk5EQk9vdmhuTDJFaVlUengwY1dWYkMwRzVZNXJkbURsSDMxZE1BT2JQQjVu?=
 =?utf-8?B?NDNObW5zb0NLN0haOTh4d0ZjaS9DdzVSQ3BYcHBCRlROTldFUmNpT1R5Uml2?=
 =?utf-8?B?N2NkL1FXeUwvdStOejk2TmVZbGhyRXBmcjZaVmFtQ2IvbkZiSG16OUFFLzVl?=
 =?utf-8?B?SDlXN0lpUFFIekNYTTF6LytVUWxDdU9jWndaMS9tQVFRNkRaNG5pa243NlNl?=
 =?utf-8?B?VExUVFN3amlhY1pzTTUvbWFoMFdFVTNWWXF5VGZudjZrMFU1ZjFGVi9VUE1p?=
 =?utf-8?B?dFptWUhBSmdFblJkdEEzclU2eks5SERCQ2twSEM5NURBdDY3RThjQWhVNFVF?=
 =?utf-8?B?c1VIdU9oa1hiMk5oYXA1M1lMNG5jeXF6M2tkVUpVNmJER09TRVBTRDk0cnhj?=
 =?utf-8?B?Nmh6aERYNlFVWFFuSFVRUE9NaDNRaXVIRXJXVjYxN0dPbmV6dS9mM0txbDcz?=
 =?utf-8?B?ei9pcjhGZnJVMW9yNmdYUlZRU0FQS0ZZWGRkTmJpNFVWVTVON3FQZHZHSWh5?=
 =?utf-8?B?bE00WDNmVm9ERVdOUEN5TUFPQ2FxRzdTL2lqYnZFS1c1REpvVUluSklJTWZK?=
 =?utf-8?B?RExEd1J5K0p0SUJ1MjF5Z3FXYllUMUdXQWNML2phS25JbXNUejY2aHZjUnF5?=
 =?utf-8?B?OGJCb2tGRzB5VjNDbEVFblhCQlFLTS9PRnV5UWs2RU0yaVEwRWtWdHFpdEo5?=
 =?utf-8?B?OEhpUGNZelpPWXRiRlBKMVpFcDJUdWhRRm1SdTJvMUNjSWUvbzl2OU5ONHkz?=
 =?utf-8?B?QUU4ekxndzROcHR1TW1JMDBnc2dSZGhGeTFYTTlQeFF5N0tFeEc0Y1hKakVM?=
 =?utf-8?B?c1BHdTJ5ZEV5ZmpSb1RJUGlKN0swZVJsWERHYkVZNjhkM2d3WjBGOWpGZWpO?=
 =?utf-8?B?RFZhU3FLOXhzSmtxSmtWMnJWN0xMTlpKeW5LK3oySVdVYVRXK3VaWFV5Z3lx?=
 =?utf-8?B?NmprUTIzQTM5SGZybURreEJxMWxkRlMxbTVwaS9UVTlrT3dRd2dFUVpySzVR?=
 =?utf-8?B?YTFmYUxIcWdiZ01YU1FraWFQMVN2MG5jK3NoR1RTMnhkdURZNElacjV2d0E3?=
 =?utf-8?B?eTRKK2J3R0V4YXVZUzZ2K1QwbVZ5cTNtTmNXSUJ0WGRDdUdjMlpXNlBvcmw1?=
 =?utf-8?B?eVcrSnVWN3lRQW0yUGd5MUxjTWlaeEM1RkJhcXVldlh6WUtQdFNWSFFpNUZN?=
 =?utf-8?B?VjVlTk1RTkw3VEtXKzU1OWMrZ3UzV0g2ZDV3NlRNY1dobUlkVVFWMWJVcHFt?=
 =?utf-8?B?VUxuN1B1THFKc0VZdWpWYlRXMDAwak9QRWxHcElxYUUyN1BpRHVvRTN4dHlN?=
 =?utf-8?B?Y3NybHhaKzZYZzlRbnp2WnN2YzYrdzd0SWZ3bXJCb09zNEppMWFGd3NFbWlI?=
 =?utf-8?B?SEZYOWFNQS83Y0pMWG5TT2xhc2hKeWp0aTNyR2dJUGRFZ2cvQVVEbFFNZStY?=
 =?utf-8?B?SnFWdEJ6ZCtWcFpSaGdQYzhCU3NidlVROXNFbEhROWhvNVo0cHhJRjJaQXBP?=
 =?utf-8?Q?ccAagqde5SXVpsclMxAPNO4iJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0906fd6d-9bd8-454e-3cdb-08de30dd93b1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 13:28:56.9116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCkLxgYdJSB43sbCFFVOl6tonOVK43Qc9IbFYPp0reSBfSjviVfBTTwcXmgXacUs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
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

On 12/1/25 12:02, Tvrtko Ursulin wrote:
> 
> On 01/12/2025 08:27, Christian König wrote:
>> On 11/28/25 16:08, Tvrtko Ursulin wrote:
>>> There is no need to draw the panic screen via the slow MMIO access on
>>> APUs, since the frame buffer is guaranteed to be CPU accessible.
>>
>> Well that is actually not correct. It is only guaranteed to be CPU accessible on 64bit kernels!
>>
>> I suggest to use the appropriate test function to see if a BO is fully CPU accessible or not and just drop the check for the AMDGPU_GEM_CREATE_NO_CPU_ACCESS flag.
>>
>> BTW: It is perfectly normal for the framebuffer to not be in VRAM on APUs! So the check below is broken as well.
> 
> Hmm I also misread the tail end of this function. It wouldn't even work if frame buffer was non-contiguous since it uses ttm_bo_kmap.

Oh, yeah that won't work for scanout from GTT.

But we never implemented non-contigius scanout from VRAM (it is still on the TODO list). So in theory you could use direct access for that case.

Regards,
Christian.

> Never mind then, archive to /dev/null please.
> 
> Regards,
> 
> Tvrtko
> 
>>>
>>> Lets skip setting the .set_pixel method which allows the DRM panic core to
>>> just work and it renders much more quickly.
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: "Christian König" <christian.koenig@amd.com>
>>> Cc: Melissa Wen <mwen@igalia.com>
>>> Cc: Rodrigo Siqueira <siqueira@igalia.com>
>>> ---
>>> FWIW this draws the panic faster, but.. the whole DRM panic setup only
>>> appears to work with non-tiled modes. There is something broken in the
>>> dcn10_reset_surface_dcc_and_tiling() code with "more advanced" modes
>>> where thing the turning off compression seems to trigger some weird
>>> display engine behaviour. (On the Steam Deck at least.)
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>>> index b5d34797d606..7f75f1319d3f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>>> @@ -1900,7 +1900,8 @@ int amdgpu_display_get_scanout_buffer(struct drm_plane *plane,
>>>         sb->pitch[0] = fb->pitches[0];
>>>   -    if (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS) {
>>> +    if (!(amdgpu_ttm_adev(abo->tbo.bdev)->flags & AMD_IS_APU) &&
>>> +        (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)) {
>>>           if (abo->tbo.resource->mem_type != TTM_PL_VRAM) {
>>>               drm_warn(plane->dev, "amdgpu panic, framebuffer not in VRAM\n");
>>>               return -EINVAL;
>>
> 

