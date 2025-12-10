Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38215D2CE17
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 09:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6293E10E6C1;
	Wed, 10 Dec 2025 09:52:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iFvUOfJk";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDACB10E6C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 09:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfeS8PrgBVJZiZz5qAJde/tIpceTZIajFbIIUrV/eGD0W/bLUIpyAe1RFlulZChLhiBneAD0E1/x3rDVFTI5LGwpANl9DHJiOPggkWhQOp8JMGSnB+quCmzcxTckWMfzBWGu8jNygB840PtNK1nwVhNlMWsXVv/65IiMl36/AMLFYy695w6m5aHDzLr3m5UriSsb/SM7VYRuz0SjALB6zAg1rAGtteVnpJB4f4rQtTI6NMhb+p00xfbZM76BDfPAPTR6FOdW2UNEsbqBtOkXxIh45GQjqefnXpcntjtUPtMJdAVND6yPh688w4Fwn/03zPnwuhthvIKKxEGAyUKoMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5BIaGy2dgGXxJVK3PecKR4hcK/4P7Q+B9jxcHY5m5s=;
 b=I2KTb+61oDs+v56J+fzx7/cipZ5xhLKETIQlLr4qI7Cs/FZqjZeP0hPIh1oIK5TxrEUCXDWd9PqQ5sndaXnurwq1LwJq7jgQX2svrW8QtPa7EQ1wFtglIuwZwcBlvxlSAv9wZ8viCxc2H3lGkaSVgf7gmDz8kMiCzO66VwphigX5EXta/2lt9aqGo4CezOTh9SvASlkt7+wXnrWu9yIr1jb2K3ChGKJ+R9+j0yfrdCdkojhJ7WptWi+ChFo4OxDSIaghZJUTjV6jSi6EbbgmkgHa8bRzwG1+4Fho/pumnGvKftdwpFwKRGMx583T4f4bmxWDd/rVFXrnlKUdmu4llA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5BIaGy2dgGXxJVK3PecKR4hcK/4P7Q+B9jxcHY5m5s=;
 b=iFvUOfJkn3kRCK7wX5Nv7+tx8Z/LIvXQSmYHE9zlxXampFkH9h1VXhvd30t/Nk9PmZ4OewYGKASR3+tYL1BPZzaHZBDyyNmHoAT82jfEeKWDp1tRpyCV/7uDvuD/vTFzSdiAAW2INac6chg+zLbaTdIECcVDBeRBGvAAhHM91I4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8826.namprd12.prod.outlook.com (2603:10b6:510:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 09:52:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 09:52:43 +0000
Message-ID: <23b13d2f-c232-48d2-85cd-1d2656c93bad@amd.com>
Date: Wed, 10 Dec 2025 10:52:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Wait for eviction fence before scheduling
 resume work
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20251209092409.1257671-1-Jesse.Zhang@amd.com>
 <c1aa6e1e-88a8-4b09-aa8a-f239f1306b9d@amd.com>
 <DM4PR12MB51521EBE33AC44DA2EC192A0E3A0A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB51521EBE33AC44DA2EC192A0E3A0A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0401.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: 4807d1a8-cf83-454d-7f06-08de37d1dd61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmZYY3QzQVN1bW1PdUMrS292cTNOVmRXYmhXdU5Gd0dVeXRoZGMvQ20rTUll?=
 =?utf-8?B?ZHBRZm01cWVITUpGLzhRWXM2NHl4Uzk4MHowUlBxMVpTUWI3NTZkekd4bzNP?=
 =?utf-8?B?WVlIQmtxRlFmbmExek9hcjFPYXg0NDhsQ1JJUko0bWQzcGQwTjZTVW9LbWJF?=
 =?utf-8?B?NzA0TWNBS2VibjhsZjBtQUhsVy9PRnJCeEZWb1VjMTEwNUthNkZFWnVnemhq?=
 =?utf-8?B?VHNXYURMSDg0aHJVZ0h5cmcxbXhIa0tyMVprUDVPbXRLNzZDUWpJb21nWDBw?=
 =?utf-8?B?a2hMeCtwVFR0ZC96cXR3anpvOXVvdDRwbWllUmhMZDdWd0tqTHdDY1Z4TFZq?=
 =?utf-8?B?K09ZOC9Kc3RPUUIrMHptWkVNOVp6NC9jWGcySlNzTjR0akxKcWo1cEdSaWl2?=
 =?utf-8?B?Rk5GSGpCSzhmVXZPZnR6d0hweUExR1krQ25Kd0ozWVk5eE9kZXE1SGpCc083?=
 =?utf-8?B?VWxmZ0x2UXJrbUk0bFQ2Vi9wQUwvdmdFKzkxODhqNHJIZlhqK1RrUVlGZVpE?=
 =?utf-8?B?UWFqUk5hMEttTGRYaUJuVWNKaEQrY0UxT213SW9VREpPSW9RbVlwRHNNQSs5?=
 =?utf-8?B?N2Z1OWMvYVJEZVFjUXhZNkVCTmtxQkEwN3ZORXJFeTdSSWg5YjdLWDE4T2c3?=
 =?utf-8?B?VVhwekErUFlQdFhPclVyQlZzOVdkYkZYRGxOb0JLc1NHWVMxSVpzSFpxTnBl?=
 =?utf-8?B?ZEJaaDFlZWlpcUJzSTZzbFNVTzVuNDhWYUlDa01xQTY4dzFnR3lWZ29uODB0?=
 =?utf-8?B?RGNDenFCbE5jMkg3Y1FlUy9TbEZBM252bmFkVDE1MElHSEJvNlVOUEJxMTFt?=
 =?utf-8?B?TG5Za1FOTmhVTEQ2MDIwREovTzQxL2UzZXlieVZ3bGFFOGl2enp2bHI1UlNj?=
 =?utf-8?B?NUlGZ1pDN0Rpbkl6VzV6am11M1I2Tko4UCtUMkJocVB4VE9BL2NPYUhNMW4r?=
 =?utf-8?B?V0JnZnhiZzdhc1Q3dHN4cVRvb0dWSEFNMVpUYWdOV3JscjU0cHNJRVRMb1Y4?=
 =?utf-8?B?S2NPbmRYeDduaEt1YkJkTEJFa0xnYjJYalNyRy91Qmg4OXIxbDlLUEQ3V2dT?=
 =?utf-8?B?SENpYk9hak1sbkxmbWhlM3NSazJ3a0ZpV2NRbm9XaUdmZkE4c3kvQnBpRUdV?=
 =?utf-8?B?SjFhZGUybkpKaTZlVDdNYUFTQ0NtZXNiTitENXRWbk1PdkpEaWF1bnJhUHRL?=
 =?utf-8?B?aHgzQU5URm5PQVlCREl6MDNhRHlJbVdtT1NHMlRkYllHVzNHZXVOZlV6S1Yx?=
 =?utf-8?B?NENubVNhd29kTGFEVXk1MDV0MExkdFQ3NVgySWpaM3E1M0s0TjdLbXJzeGxv?=
 =?utf-8?B?SHJYalgzWWdUTFJidk1ldHM1cm1kSWd5b3M4bERrZlBTcUhibkV5WU5iZVFy?=
 =?utf-8?B?MXFGRDJBcUtQa3p2UGJUenRUSEJUN01YMklhZDIwb2pjejk4MTFKTlY1NnRI?=
 =?utf-8?B?Vm1mRThVYU5NbjR1Uk5UZmp2M0dkYjRkNStMM2cxbEdTR1c0cWRKRFZheW1Z?=
 =?utf-8?B?dnlweHJDN0V6ZUN1aksvamZEanMzT3V0UzhkZVJtZkJObmcxRitubk1maXV2?=
 =?utf-8?B?QmRERXdIK1huTFcybTNWODMraDhwSEszdlh6YmJLUHZUS3h0Rkk3aE1nZjd3?=
 =?utf-8?B?eXFkUElIWGVBcThKMmVwazJZYUwvWDczdHVSZi9iT0VzQzdkK1NRQm91SytU?=
 =?utf-8?B?NFVoWkpzYWRBeUlUa0xVNVZVQWJWYS80U3VOZ2pLZlNiMHpIWWJhNk9UU09K?=
 =?utf-8?B?VXF0OUlIcWpJOWMyRmt0dUtGVG1jT0l5cUF2czMwTjdNbVR5aGFzRFRzZ2dw?=
 =?utf-8?B?YXVBck9ZUityRFRjTTc3YnFLdXhqcCtwMW95eGxTSWtIdXU1SStRL2RsaEUx?=
 =?utf-8?B?Wnp0QkwzT0tDa1MwN1ZNQ3IyMVJoTUlCVUlLcTQ4aExsNzlKclpWci8vMmtv?=
 =?utf-8?Q?6HzmOOsoT2IvgcnrDkRqqzEr0Who6U9Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um85OEVOVlV2VS9waEx5QUhMbXBsRzFmTUcyQVZUd3V5Uks5aFhDcmtMd3JX?=
 =?utf-8?B?Yi9FV0lCVTBDVlRFcm80K3BkTVozdFJ5SHZvK3VqQksyT0o2aXA0ZUt5NXgr?=
 =?utf-8?B?R01PS1lnenYzYWUvTUMxUEtDSldaVm9CN0tYeVpxU29hK015d1M5ZDZZOS9P?=
 =?utf-8?B?QWloSWVwY0FvNWc0RkxkY0FNeGF5RnpwVHREMEFOL0dERzh0Q3NVN0JNR2FS?=
 =?utf-8?B?aFdyWFBPSFJqYUFETEd4ZldzUDk3RjNBcVU2QjZtWmFESm0vT3VYU0RpM2Ns?=
 =?utf-8?B?Z1J4cVBZRXRoYlU1Zk1pY0I2ZUY0eE9Cc245VE03YTMzOW5iRU9La01vRWhS?=
 =?utf-8?B?bXpjakxqczNSRzkxd1J3R1VtbXhoYzlRU0dSSjc4cEZhOFdjeCtPYmtlRVdF?=
 =?utf-8?B?SnZremlyaXpMR3JtWHErdnp3TXMySklpSmI1R0JoVEg5eFZtSDV6N0hiQlZH?=
 =?utf-8?B?a0VYVXRQOU41UklkMERjSmpsQTFsOTZ1ak83RW9oelFzazdZQS9kT2RkZUxB?=
 =?utf-8?B?M1dvSDhqZ1duSkV6eE9qOGdGNkdiajJNRmpuZEF5a1RteGpjVmNiT25lS21r?=
 =?utf-8?B?Ry9lZ2tkMkRlOStkS1RyblhkR2pZdTdEbUxpcUtnV1JLd21wYjVSWG5yK1ph?=
 =?utf-8?B?NHVORUM4QXYrcnE4bnJCbityV2RSKzhTSldMTDVJTW1pMjhXT1VTMEtEbDlZ?=
 =?utf-8?B?akVJMkNlQXg1SzE2WUVCVUdwZ1pXWDlha1IrRDdIb3RlM0tnRnk3Q3hvRTNC?=
 =?utf-8?B?STExZ3VKRFZKcHhzM0YzTlJaczYrSkFDaFcvV1Frc1hCdzlWODJDZ3RzV0Yr?=
 =?utf-8?B?ZTRaUEZsVnhpQTlEVS9yU3RQRGJOV1ZPYm9NOUpPOW5aYlNvVG8wSUVyWGNN?=
 =?utf-8?B?aml0WE5UMlBmMzJiK0JVdUQzNHdjZGdtT3F4S29acGVuQkRJc1drQ1k1TWJx?=
 =?utf-8?B?U0VVQi9TbHY1L1JYcFNhMGZpZlFaZE0zazR5Z1k1YUpzTENvMWJsS0J2dVp1?=
 =?utf-8?B?N0VTYXBnLytBdXhjNlpYQlpMSTh1ZHVwOTVKTmVWRU84Z1oxUCtWaTljbDlO?=
 =?utf-8?B?bmsyV0NyKzNtL3l2THRFWjdyTEkxWmJ2eUNvQTlQakJYeEVRcTlMV1ltcERj?=
 =?utf-8?B?YURFS0pVdFlqcWwxSUNEMXU3NVBFLys5L0Z5eERjOUxlZnRhSzcveU81RWJS?=
 =?utf-8?B?UGZOWlp5aGxScGRDNmE4VzhGOEFQdDJHWmh3eUVOWG1zR0grU3ZWOFdvU1lU?=
 =?utf-8?B?WGFOVGxXZjNLTDNsQVJ0NXlGVGx4RnAvUWZzcFFHM2JvZmtXSzI0TXIrdWVp?=
 =?utf-8?B?Ly9NdTE3TkJjQytwaWxHOUVKWmJHd2dNbDBnVXlhYzNqTEJ0NExmVGhXd2Vo?=
 =?utf-8?B?YmJKeC9aWG5yaTRsOXhXUXVGVlJtb3Q4RGJzMXhLVVJXYXlRNmZRUXVUaU5J?=
 =?utf-8?B?blVFQ01UdENjdnNwMGc4ZUpONTNHT2hZdC82aGk2Q0hwQ2FGOVAzVTFlQjM3?=
 =?utf-8?B?ZCtMeEh5c0VRWVVLVEllSjk2cWMzc0VJRkxMa1YvYXFKK3dZVkpIR0plNnlW?=
 =?utf-8?B?cnJZa2w1YzQvYk5oaUNvcm5HakRpUSsvMjBEY2g5UlNBTU44dWNjVGZWb1hE?=
 =?utf-8?B?eVlja2JSYnRyZGhNTGtMaTgvM242MnpFZllya1lvajJXRWNtL0VGYWJvNlov?=
 =?utf-8?B?bjlWVGVEV2lMMmtPeWJTZjU1c3c4cWZucjhWd3ovV3ZvTXRpWkMxQzNiUWhD?=
 =?utf-8?B?ZjlHZmRleDNYNTZ0bkcyRXRuTm1zemNRSzlvYVdEeVAzNDNwR0R6RFlEQm1S?=
 =?utf-8?B?SzRwOVhISjY3dTM2b05heHlmdkhuTTdVdHBGc2twdzF1Sk9mWE9IY0ZnKzkx?=
 =?utf-8?B?SWFXQitweGQrZ2dKZ0dlZlk4SGVzcUk5S0QvWFZrQnZ4cDFiRzYwZTBpdmUx?=
 =?utf-8?B?NldQaXlMVkNaekJnWkp1eW84bDNjbm51bmU0NlRIdGJqYS9oRUVtb0kzYXFQ?=
 =?utf-8?B?YmJTYzFMb2JEWE12SzRWVzQ2bzErZDd0YVdpWXB1STJEdmJkb0pCUGNLN3k4?=
 =?utf-8?B?MHhicWtrbkVpOFFoOERzVy9ZM0ZnMmgrcjRtZHNlQVF2U0RlZ3N1dThJU2VS?=
 =?utf-8?Q?TMiWoAjYVV1pPRL0Qwj+Pdt3G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4807d1a8-cf83-454d-7f06-08de37d1dd61
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 09:52:43.8485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnLiRD9yD9XD/kLig5VdjvdzpKbqJaRC766lihiGI/87YZnCIvB6gBbLA9iuAP50
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826
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

On 12/10/25 04:04, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, December 9, 2025 5:42 PM
>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Wait for eviction fence before scheduling
>> resume work
>>
>> On 12/9/25 10:23, Jesse.Zhang wrote:
>>> In the amdgpu_userq_evict function, after signaling the eviction
>>> fence, we need to ensure it's processed before scheduling the resume
>>> work. This prevents potential race conditions where the resume work
>>> might start before the eviction fence has been fully handled, leading
>>> to inconsistent state in user queues.
>>
>> Well signaling the fence means it is fully processed. So this change here is just
>> bluntly nonsense.
>>
>> What exactly is happening?
> [Zhang, Jesse(Jie)] Hi Christian,
> 
> Let me clarify the issue we're observing with the SDMA user queues under stress.
> 
> **The Problem:**
> During stress testing of SDMA user queues, we intermittently see stale doorbell values persisting after the CPU writes to `cpu_wptr`.
> Specifically, after updating `cpu_wptr` (which should update the doorbell), the doorbell register sometimes retains its previous value,
> causing inconsistent queue behavior. This happens randomly under heavy load but is reproducible in stress scenarios.
> 
> 
> **Root Cause Analysis:**
> After signaling the eviction fence, the resume work is scheduled immediately without ensuring that all internal driver state updates
> (queue state transitions, MES state cleanup, etc.) are fully visible and consistent.

That is a massive bug and the root cause of this issue.

The eviction fence can only be signaled *after* all queue state transitions and the MES state is clean.

What the heck is going on here? What state are we talking about?

> How about changing it this way?

Stuff like that is an absolutely clear NAK as well.

Regards,
Christian.

> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1130,8 +1130,27 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>  {
>         /* Schedule a resume work */
> -       schedule_delayed_work(&uq_mgr->resume_work, 0);
> +       schedule_delayed_work(&uq_mgr->resume_work, usecs_to_jiffies(1000));
> 
> Thanks
> Jesse
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 2f97f35e0af5..ed744b2edc61 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -1238,6 +1238,10 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr
>> *uq_mgr,
>>>             return;
>>>     }
>>>
>>> +       /* Wait for eviction fence to be processed before schedule a resume work */
>>> +   if (dma_fence_wait_timeout(&ev_fence->base, false, msecs_to_jiffies(100))
>> <= 0) {
>>> +           dev_warn(adev->dev, "Eviction fence wait timed out\n");
>>> +   }
>>>     /* Schedule a resume work */
>>>     schedule_delayed_work(&uq_mgr->resume_work, 0);  }
> 

