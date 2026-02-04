Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CC8E83EE3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 07:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A12E10E1AE;
	Wed,  4 Feb 2026 07:20:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NcYOO8lz";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FBD010E1AE
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 07:20:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwQOFKuKQ9OjyeF8PoSagGEyqA4z+6cxqHp01SLgQUt6WED9RWq23tYH5ocWSpGRRnh7DL+XqCQVGS1TPUtDlptn5veGg1drsGawFZ9VofppHFgTw1jg4jXlo70w9jy0kbHeMzaNBc4P8gM1opr7/SeFtgnr0vTqLZi+pZMmPjZpzdQfi4Zzeiy/5Dw6vLIkRaVLkGoHSDdR+XYpkwRQaix7K0bLDAviPE5LOyhZNG9yfgdJZigamfrwA3Os6P1PKKA2xXsgnVbQts4/Ep2L6GTV0Z/5wjeT7A4njDD1zAJM9odsHJbdXRuNDr9rv2vWU24dRP3J0BlvXtyvAceg5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdFJGgSao0mNdyKaNE1ITK2sqoPVTuLCqomk9WblKhI=;
 b=pO41Bp0mdhtgUsh7giZvWYM+++4llniW7IvF4bvB5/4AcIpFpyRseXK7YRyXEa/V9+rFyIVVnNBsmoZTKByOCZxqNzumhNY7jlig6/Xk2J6udT/MNakseZVwUzWI/K4rZxyuYwBBFsFhtJP0rCOJS8f3QJyfg2kYNq7rlzYu1j1nfmbLxClnK1k1tAzJjOALNiXV6ePyMxwwAFrA1JhvKptrM6kFFLvIE8jM07pcFmkylosxBPqDHygW+JeGzv/lOuFPpWoBSAjvvrhlWoL+u52ZJRLINgHqh0Y/bZsGIUVuREDBMmeOWN+IPafxcEExLFTo6bI+6HPeh5/UWZWUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdFJGgSao0mNdyKaNE1ITK2sqoPVTuLCqomk9WblKhI=;
 b=NcYOO8lzepGuj5O67zwyeKbL0t/bDUIb4ST01gt0HREOm0bmoCB/AH+14FZG6qs+VZmGDu/0XpYCyBz8ef/JLx/KPHRFhz38oVdeZPfDt1TO4VcpAL9JrjpXxV6XVUieC0xh7aRcx7sZn8+TORlf3xxsBAT0iz/sgpAcd9fEaQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 07:20:11 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 07:20:11 +0000
Message-ID: <f7092376-15a0-44d9-8d88-5d8ab19c3e0a@amd.com>
Date: Wed, 4 Feb 2026 12:50:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: use sysfs_streq for string matching in
 amdgpu_pm
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260204065743.206914-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260204065743.206914-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: da8d48c2-7069-482a-9ac2-08de63bdd519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?em5vRm1ySzR3akxyOS9VQ0JDRE54R1NNbUlCTTVJc0tjS0dFQlpSQ1BJRDNq?=
 =?utf-8?B?OG93R2JkTXZHS3JRaVhYRDQyemY5alpzSUNMYTU2MXJuYW5JMGVwWkFWMUYy?=
 =?utf-8?B?VkxXSTRMK01EUG1XeUtRNmtFamU2ZFdvWlgyLzRpaE1iZ1BPc3lGUFBYcDFq?=
 =?utf-8?B?ZCt6Uzh4cGp1MERMR25pVms2U1FUUmljejJtdUZHb3FwL2phWFV0dVFoUll1?=
 =?utf-8?B?UDFPVGlPdnRrQzdwTjRLRzdDSHBrc08wZTByZW9ydWpSSUFnMHZSTkhzU05I?=
 =?utf-8?B?eFJKQ0lVZmYyMzRzU2JZUmgrZHM5VlpqZjVEWDBtTi9kajFhWjF0VHg3SWgr?=
 =?utf-8?B?SEszL0lxMnBtOU9HKzF1dGp5OXpCT1hQenJ2ZFp6MUJYdERRNUhnMzdLZlBE?=
 =?utf-8?B?b05TUW8zemlmbFVqVktiUjIvSnRRWmVFU0h4STBaLzRLd0RXTyt3bWVxNklk?=
 =?utf-8?B?ZmJuMFo5Q3E0TDZkRmpEZG5oY2hIMGdzMjFkdUJtNE9JR0RHL2paMWdJbmxW?=
 =?utf-8?B?Q2oraU5xN050OFhNd2VFckdvYmNNcVhBcyt0SXpHWlh4WU9aU3gyeTBKcCtC?=
 =?utf-8?B?QVJTWjAzTWhSZGJlQnRkbm9sOEJHQ2d5OFA1Q0dnWW4zMjZwQjdOUEozWXpp?=
 =?utf-8?B?OGd2dnFQRFJLbzhwTFJYRFhVUWVUKytBUitCZHR6OTJUNWZ3RzIybXc4Slll?=
 =?utf-8?B?K2FJNU9YU01OSmU3c3VDNGUzdkFpeUJrQWhQZTlYaEJ5cGlpbjdVWWZIRFo4?=
 =?utf-8?B?eTRhNDRpc3NIcU8vVVJTckc5SGNEK3NRQ0lWK3A2blZkRW9PbFFxN0ZFOHg4?=
 =?utf-8?B?b3Z1OFM0ZFVzTDlnOGFFZkpPNGp2bVpuNXFaYTQ5aWNSVHFCcWtRSlZBdEVn?=
 =?utf-8?B?WXJObEZSS1BoMG9mQy9yL3lDUHJCWWZDb1pQa010L0tpSEdUR1BIWHErRGV1?=
 =?utf-8?B?K2NWQ1FBcmI1ekxzQlVjZDY3QXRDSVNVc3pYQ1dwSFNEbWhrd3lVd3hWRlRR?=
 =?utf-8?B?bGpFUHFPV1JVUkI1RjBzRW9RL1pvb21hVFEwQVBJMUJtNXFSQlBVZGkwd2tM?=
 =?utf-8?B?RlFuaUJaL2NHRlBvV0tiN3RyUnQ1MnIwK1JET3JaZ0QyUWFqVWRwNzhjUERk?=
 =?utf-8?B?cGhqd0pYaE55dndERERrVWxReWhjSzl4Z0h6UUdSdUh6WE1mUWJUUEF6VG1w?=
 =?utf-8?B?dXNkM3ovL1R3Z2R6cHZaSXlrQmJRYVQ2Unl3SlJYbU1teW1pa2x0MEtFZ3dH?=
 =?utf-8?B?MGdsRDBta281cllPbldRMk4rWnZFeGIyVmQrdW5ISllVeUpsYVFEZkNBdk1P?=
 =?utf-8?B?bDVsbFdDaXJOYnMyT0VZWGNMa1hRaEtHd2tHWGpzck1hb2RBQ2hsNTVibDVw?=
 =?utf-8?B?SWl6c28xL21XbS9BdWdKSjhQSzNWWEx5Tit1RmV4ZXovNFUvcDhKWHNDbzBy?=
 =?utf-8?B?ZDFpZHUzZkMvS3ZRRWk2RGtMd1hORWV1RndDaHB6S3pSb0txcVcxK0ZYV1JM?=
 =?utf-8?B?VmxYZitDZ0luUitDeGFoT1hiZWM0b3dBdGpmcXdsZ1VodEIzamZNSW83MWxB?=
 =?utf-8?B?ZnZzM2ZBc0U5SnE5WkF2S280VzMwWlA5Q3RkVzNpT2U2SUFsMVI1Mk1FaHdt?=
 =?utf-8?B?UzhZL0ZkaGgvZ005NjFxZkdVWk9GZzF1VTFKWGMrRlFYYTN6NlluM0FKQm1F?=
 =?utf-8?B?L1JVTmp1NkdER2RPWTFPaHU4YVNFVkxYUVNVZXlEWk5VUHdSdmU2YkRJc0pR?=
 =?utf-8?B?NkdYWUxwUHU1NVBzYWs2MXF3a1J5R2t2SC81cVB1Kzg0YnZGTEZqNEJRMTVY?=
 =?utf-8?B?SG1ZZWxXY0J6dW1HMGp3U3Jvd2pBMmEraFFDYjJlMklkbnpLVkdTZGlSNGNt?=
 =?utf-8?B?ZzA3WFB0QnkzY3BXekdSOHJGQmMrcFNwRGJNVVNWcHVuTzN6R2RMRXphL2pV?=
 =?utf-8?B?MVRKbmFrVkNIR2F3UWVBUWVNM29kU01BVnJpU1Zkb1NoT1FwdEV2aTBaRGIx?=
 =?utf-8?B?ZGxVRytYZnllekFONXYvWFY5ZFZTMVMyY1pRNHhwdVNBblllK3F6QVc5Szla?=
 =?utf-8?B?alU5TFE0L1E0dERoTnBOMUh1WW5hRFhQLzdrYWprNER2UWhxYkRNNXhiOHZG?=
 =?utf-8?Q?a9A4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bklHR0lZQk9vamFEbXRQVHdxRExaWk9ET0t0NmtDWWNheEJvclNwNzFWbStv?=
 =?utf-8?B?dTdwdmNwUDBOVlFkMkZkSzhoSHVoZ0RuKzFvQ3hLN1lRZlFkdlVOTUtVR0Ux?=
 =?utf-8?B?YVJGMGRLTDlINUlueVVHaXpCbVcvUmo4QndHZ3RtOFVxNS82dXIwTGhnM3dP?=
 =?utf-8?B?NmpHelkxcmhIT3Q2cHp3c1ZSb01pS0JET1V6eHVENjdhZjlkaTQyTTRXNVNU?=
 =?utf-8?B?NjZYQjhBL21iSUs4Y1NKRDN6ZkFFUTRmMDI3N1N3YzhBbFdXNmhVbmtsYU85?=
 =?utf-8?B?NEUzcllvVTJ2RkN5YnZtMHFYVW1xdk5lN2g4N0dUV2VrZE5ZNzJqd21NV1Ur?=
 =?utf-8?B?emJNeEY1a3MzL1hvZ2xQODNrMWJQNTNNaUxyUVNRV1BQYXVuUkV4T0x1MzNI?=
 =?utf-8?B?NjduMG5IbHo4dld2OHZtWU1HVCtvN2VFemVtWHdzUWQrTUJvSW1oRjZyT0xk?=
 =?utf-8?B?clg2bmlGUlpkZGNRRkFpQUZkSXVHbEx3KzZyUDV4dWd0QXZzSzZvcHJ5SGQy?=
 =?utf-8?B?cStmY2lSdXlYaG43NzdRNFJ6bSszSERvSU9ZcitaS3B4b2lHbmNqMm9tWGhS?=
 =?utf-8?B?K2dmUURFajJQaHQ0Z1dPNDlTeU9OTkxnR3plR2Y5VjF6UFRyTWRkenJWdklM?=
 =?utf-8?B?ZjVZS2N5azArS05aSWQ0S2RTN0JGQUw0SGVGdVNnVTlIU0ZENzJ6akR5MXhi?=
 =?utf-8?B?YUdKSkk3akU4b1lxNzR1ckpkZzRJQzJsWGdCV3FHWXJxR3hlc2xnNmJmSU0z?=
 =?utf-8?B?SFpYcTJ0Zmk1WDVjUjhtN2pIcU5Uak9HeGF4TGx1elFkMDI5M3NEdUwyd2gr?=
 =?utf-8?B?VTc0WkkwdWlqa1hvYmw5Y2pQK1VqZkpqYVZyOUtNSHhnZ284aE8wc1UzUlJ0?=
 =?utf-8?B?YXdZczg0ZGtraHZUaXJUZCtOdVlETXVhZnZSeTNpT0k3VmVPcG5aTjlTQUFn?=
 =?utf-8?B?NU9pa2Yzc0diemt1MVhqd0JOVzF0ZFp3UVkyL3V2cEpDU2F5SmFrdE5MTmhJ?=
 =?utf-8?B?OHRPT2pMbUt0LzZ6WkZONHhjaTJSU1pZQkNXVHZQVUpTeGlna0hWaGt5aWNu?=
 =?utf-8?B?ZW0wY1NOekZxNkE4SkhXejY2aVRCOHR2TzBtZForMUtjazh4dFdOSDdOaTlR?=
 =?utf-8?B?RStMQ2UzRllwZjFvQTZjTVcydTcvUDJyUGxub0dlcGZRbThDL3RHcmpjVVlN?=
 =?utf-8?B?SWZoTnVsUzBaS3ZYNFJYRjVjM1NxQVNXOWExcU02Q0IvaWplSkJNTkxMb0tl?=
 =?utf-8?B?MDE2TUpKRjBvRDRGSXprdnZBWUpuQ2phaWkvWitsRi90eE1aQ200UlJ1SjZP?=
 =?utf-8?B?NjVxUEg5Y0puM1lpZ2FXWEpzS0RrNVZnNnFrbGxVbU5hUEM5QVk1T2RoOVdm?=
 =?utf-8?B?SldZVE1haDhlZXJUcit4NnV5cTYxVU9BU0ZjMUEzZUtDZ0M5S3l2Mlpnbks2?=
 =?utf-8?B?aGQ4ZmhrQ1hmOE53Zmg1OVVMZy9jejFTcE04RXluMnU5Um1JcWJIWWZvSFpH?=
 =?utf-8?B?SllTNW01T2RLMm9ybjYrOGU5SjliZXpVUDEvTlRnaWdRL0dsQW91ay9yMkt6?=
 =?utf-8?B?eW95d3BtMEE1TkF6bW56YnlyQ1g5bnROVnNEdURHNmpzdWVCdkFXem9Qc08x?=
 =?utf-8?B?UEpzQlV3TUdyVmhaVExwcnJqVnBxVHBreEtIbis2UDUxY0JGWkZmSlpDeWE5?=
 =?utf-8?B?Rklyci9va1JjQkxNRzd2WlpsUlFYZHFMVG1qYUFzcytXeHNJUld1Qjd0Q2hZ?=
 =?utf-8?B?UGVQR2FQeGQ1V1FtYjViT1ZTaUdXZ0tjMFJkakZpV2k4TmxzWDBoWkVKbVFm?=
 =?utf-8?B?S05FdlJjTTIzNG9RT1NTTjRIekwrT1NFdTNGemNuTlZ0bWtoREJzNWJHYUlZ?=
 =?utf-8?B?VCtNbXUySUxiYWpBZEFrM0thUHpKSUcrazFWZEhXY1NrSWs3eWY3UEFveEta?=
 =?utf-8?B?ZmtxUjRtRVRwZ1JKYXp3QWw1THVKTXZhM1dvbFJVSzJody9UVnpBK3BIOW9i?=
 =?utf-8?B?OTFrNmlnUU53ZEt6dFA3QUt0N0tvUVJ0a2djc2lEL1pSb3RmSmFnWnNuSkRi?=
 =?utf-8?B?QWQ4dk8vTTFNV2M5ZzY1OXVzS09abXBac1pZTEpRNWZoWkVwVWg3Y0hlQUEr?=
 =?utf-8?B?bkM1M3pEUmZyZ1V0OFpwUGRwKzIxVnk1WXpPSkIyaG1LaGgwTGZ0Yk90K0Fn?=
 =?utf-8?B?aUhUYUhhYzA5SUVjVjRrcEVZQnFqMS90SW9oa0VtbVhwWjBsejFXY2R3VnVV?=
 =?utf-8?B?ZFBxUHpLOC9aUE1xbXhNeS9jNFBJMHlVa2RQTnljdENaZERpUTlFdXZDaE8x?=
 =?utf-8?B?WWxTLzVzcFhZYVljNUlHK1h6Tlg5Y1U3Mk1WNllHVmQwaW1FWmxXQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8d48c2-7069-482a-9ac2-08de63bdd519
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 07:20:11.2651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgESsohgmGRM6AGW4eYncQRdWbZIl604NL+A1MFLYOh3MM5f35/Cmk3bUemSc8jd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
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



On 04-Feb-26 12:27 PM, Yang Wang wrote:
> The driver uses strncmp() to compare sysfs attribute strings,
> which does not handle trailing newlines and lacks NULL safety.
> 
> sysfs_streq() is the recommended function for sysfs string equality
> checks in the kernel, providing safer and more correct behavior.
> 
> replace strncmp() with sysfs_streq() in drivers/gpu/drm/amd/pm/amdgpu_pm.c
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Both look like good candidates to be replaced with sysfs_match_string

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 29 ++++++++++++++---------------
>   1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 07641c9413d2..938361ecae05 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -243,11 +243,11 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
>   	enum amd_pm_state_type  state;
>   	int ret;
>   
> -	if (strncmp("battery", buf, strlen("battery")) == 0)
> +	if (sysfs_streq(buf, "battery"))
>   		state = POWER_STATE_TYPE_BATTERY;
> -	else if (strncmp("balanced", buf, strlen("balanced")) == 0)
> +	else if (sysfs_streq(buf, "balanced"))
>   		state = POWER_STATE_TYPE_BALANCED;
> -	else if (strncmp("performance", buf, strlen("performance")) == 0)
> +	else if (sysfs_streq(buf, "performance"))
>   		state = POWER_STATE_TYPE_PERFORMANCE;
>   	else
>   		return -EINVAL;
> @@ -363,29 +363,28 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>   	enum amd_dpm_forced_level level;
>   	int ret = 0;
>   
> -	if (strncmp("low", buf, strlen("low")) == 0) {
> +	if (sysfs_streq(buf, "low"))
>   		level = AMD_DPM_FORCED_LEVEL_LOW;
> -	} else if (strncmp("high", buf, strlen("high")) == 0) {
> +	else if (sysfs_streq(buf, "high"))
>   		level = AMD_DPM_FORCED_LEVEL_HIGH;
> -	} else if (strncmp("auto", buf, strlen("auto")) == 0) {
> +	else if (sysfs_streq(buf, "auto"))
>   		level = AMD_DPM_FORCED_LEVEL_AUTO;
> -	} else if (strncmp("manual", buf, strlen("manual")) == 0) {
> +	else if (sysfs_streq(buf, "manual"))
>   		level = AMD_DPM_FORCED_LEVEL_MANUAL;
> -	} else if (strncmp("profile_exit", buf, strlen("profile_exit")) == 0) {
> +	else if (sysfs_streq(buf, "profile_exit"))
>   		level = AMD_DPM_FORCED_LEVEL_PROFILE_EXIT;
> -	} else if (strncmp("profile_standard", buf, strlen("profile_standard")) == 0) {
> +	else if (sysfs_streq(buf, "profile_standard"))
>   		level = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD;
> -	} else if (strncmp("profile_min_sclk", buf, strlen("profile_min_sclk")) == 0) {
> +	else if (sysfs_streq(buf, "profile_min_sclk"))
>   		level = AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK;
> -	} else if (strncmp("profile_min_mclk", buf, strlen("profile_min_mclk")) == 0) {
> +	else if (sysfs_streq(buf, "profile_min_mclk"))
>   		level = AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK;
> -	} else if (strncmp("profile_peak", buf, strlen("profile_peak")) == 0) {
> +	else if (sysfs_streq(buf, "profile_peak"))
>   		level = AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
> -	} else if (strncmp("perf_determinism", buf, strlen("perf_determinism")) == 0) {
> +	else if (sysfs_streq(buf, "perf_determinism"))
>   		level = AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM;
> -	}  else {
> +	else
>   		return -EINVAL;
> -	}
>   
>   	ret = amdgpu_pm_get_access(adev);
>   	if (ret < 0)

