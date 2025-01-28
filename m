Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBAFC0218D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 11:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F5E610E63F;
	Tue, 28 Jan 2025 11:59:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FSowN41m";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ED3C10E644
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 11:59:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVJcuEaa88h8r3SRaM7HEluq4aIRMkCLMK14t+H5EFWCBfNcIk1381DcbjIRrzMG19Yyr4x9GIkJoq0OGYRmKdYWyIYPoJx8/01MFjuDqSwPahvFpN2nmw6mTZpnOvrhGD9ygSEdBjwhm5xaD5URKr7av2eIqfjbo/abbiW9mytRSvQdfaZziC+xqj6CK2DEANGiL+xtR+dvaZ3WbezxaMyvHU8Ecj3ynUmlvUvWDAQFKgLDDgwFeFdRKWo+RQpXQJgnnYiNYHO5RDZlKGkmsUs6Jsksvxvxgs/w0KxCSUqaFEnX97BV7L2pgTCyVrqP3t9DW7yEijGqoCy3QjCAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6tcCM49nS9X6sppIkrJL4Eea3+POhynszmD5FfMlIE=;
 b=JEfP8DJDD4bnjwUccGCxGe0wMIA9gTQmVatDyUseCtrOt+YKWu3Op94ytNsOjPb3lsCyWHwxV4TZ6rMVV+Bu/+q2X2SozbiqSCCGMRhEDo9tp+ksaIoswfXFW+6OnLJ5BC06f6Jd/KkwqEfQ3iLD9TfQOZaJDco/bcfbqbsBWrivrDUGBKNuXFXZWpYbZpSIGD5ImcVP8gjcB4XgMRL4WcnjmNP5xJ60WY4qN489aqBgWP9r39xeq1G5nmFymGdt1Vx3ktBeWv926WTtbia4wiF8RxWu1Xlg87lQCTscApULN9iOxOM2OTVf1dAUt8sVMoMd5BDn/kBeGWbYG++FBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6tcCM49nS9X6sppIkrJL4Eea3+POhynszmD5FfMlIE=;
 b=FSowN41mlJSspD12titH9345BKwwLJQcImfTxJfPIvKi1Y31gSI7KxMEoXbdXeTYbmlGr8SMLW69m+Lx5/+pQhqPEZpomkI09kVCPjhRPdQWk+eSjJJrLC3xu+JYiaNlalcipFcybeIh3XZpT5rL9tlGyS9tw5id13EtIBu/5Mw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Tue, 28 Jan
 2025 11:59:29 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 11:59:28 +0000
Message-ID: <174adca3-3b0f-4174-bf71-a57598db912f@amd.com>
Date: Tue, 28 Jan 2025 17:29:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/amdgpu: Add helper funcs for jpeg devcoredump
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>
References: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
 <20250128090950.461291-3-sathishkumar.sundararaju@amd.com>
 <16793f54-a7b8-4e45-b899-fb177b39f8f7@amd.com>
 <9b7392c7-6085-4c99-93b4-2bfac8b332ce@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <9b7392c7-6085-4c99-93b4-2bfac8b332ce@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::24) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: f81998a0-9378-4c46-f847-08dd3f9337bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d09qSUtqZ0o5MFNHcVI1a0JPbHhPdGVEZWlkc0laSWhHOFBOVjgxdk93Z1Fn?=
 =?utf-8?B?czZjWnlTUVdHZ0t6SlU0T1ZpQW1uUVdGQ2tHdDUrQUl6Q3laNTBTTlFQNVc0?=
 =?utf-8?B?R1YyRmZQR3I3bmIrMnpWUHpUOGJTcFhTaHZmeUpGeHh5a3R0b0dPaGlOR21q?=
 =?utf-8?B?a2NucXp6N2w5VG5JMDBWN1FVQlZ5RmswMXY0RThoM2RGdVhUMCs2cjlCblVC?=
 =?utf-8?B?N1h5TlNLMDVPeFFJb1B3Mmx1ZUh3RUV0Y2E5NXBubUdpeEliNWZQWUZEWkh5?=
 =?utf-8?B?OXc3R1pQblJmL2E1RGZrZjNBRkl3Wkh2ZW1FSDEyeWVoeEorU25nT1NBWHlr?=
 =?utf-8?B?OHBpUmVucmtoVUQzSERtWHlDaS8xNVdRM2hwd0dLeU0zcFcrR2p5WnZPQkl3?=
 =?utf-8?B?b0NlaXZNYlpyRzAvcHQ3SjgreGI4V0VWbTNFQWVqNGpXV1poeGlLUnRjR1Y5?=
 =?utf-8?B?aC80UUNUUGE2V3NJdS8waU4wZ1lEUTZldHFVV0I5aFI5QXArRGl4SEhUTFlF?=
 =?utf-8?B?Y2hMQXE1Rms3NkovNm0zZC80NmFaVWU1Rm1UZ2xhSDJBVmx3alo3Q3BlaWh4?=
 =?utf-8?B?d09GQml3cDdjamE1Umwvb3JCbFNpY2lmcmk4STIxaGl6ZlVFNXA2YmNmOFlZ?=
 =?utf-8?B?N1hzRzBYWGNLTUV1MjVBUUd0L3ZuUGJScjI3VStQV0RsVDd6OURHNzRISEh4?=
 =?utf-8?B?Y0l2MGVNQjdvR2UwaW5nQWhwQ0crNk8rcTBUUmdZT2VYZUVjWGt2QU1JVkI2?=
 =?utf-8?B?cmV3dFVsNU1EUHpkODAzSmhSTTdwRU1FcTJnQ3l0MU5CRkovYnQ1VnlxV0ZC?=
 =?utf-8?B?SklIR3VoM0hXSzNobEpFUlZEQlZmZVN5MGtjMHhPQzNRN1hoK3lOQ2lncW9G?=
 =?utf-8?B?VUg2YkRFN1JqUjJPdEdvWGdRNkdReEU1YXlWUTUwci9QcEkzODJGRU9zb29N?=
 =?utf-8?B?N3VoNTN5anFBWTJsQlZ6bDJDK29jY01uVHpQTlVYLzVZV0pBSlp0ZHBib0tj?=
 =?utf-8?B?OXNHWGVZeFZTaTBsdkRHQnRjRU1Hakt5WDlFL3NDM1lYaCtXc04xV253aTBn?=
 =?utf-8?B?eDlwU3U4MGhPSEhoWEhFTDdPQnhxZDJvZnJVRU1uTkpKU3RjaVBIdExQRE1W?=
 =?utf-8?B?T1lmYWw0eFlqMEZXMVhNWUpxbUpoOVdiWnQ0b0Z3bTNsTjhGaGxJZjNkOCsy?=
 =?utf-8?B?bU83a3N4SkNwanl3ei8xd3NPeW5qNFdiWFhRa0o1QW5MaURyL1FXT21kZG9M?=
 =?utf-8?B?YU5RaWVkTmFRQ09OSWxuZU9rdUNlZUtYVU9xY09vVmY1K3V6WEZ3NVp1Qmpn?=
 =?utf-8?B?NE00d2xaaTNIbk5aUERGVEJBdUJ5QU91VFh2UzhRWU55NHh0dWJBckRuUUtI?=
 =?utf-8?B?TXpGR0k2NDdOa3BuNjhsZkF5RmJCQ2MrMlczNDBQbGFhbmVtQ0puVnhCYmJG?=
 =?utf-8?B?dVZXZ1FWMXpSM1ROOUV6bFFnK1k1Yk5VZmFtdFVhY3RFN0x3UHcxZzRZYkZw?=
 =?utf-8?B?TnRZcmVZdTdFaTdxV0E3b3pkK3BHWHVLdk1MWGxUOFF2N1JweG5mNVNGcThp?=
 =?utf-8?B?NjBrRGNremtSSytyZGZLbXhFdFB4Sk9USDJBT0tlNTRnQ1QvaGpaUnJSLzE1?=
 =?utf-8?B?cDU2c29ZSkVBdDVBOTMvaitVdEgrMWNheUpyR0ZjZzZDSFlKWWZ3aVBVWHRQ?=
 =?utf-8?B?bFE0TU54Q0FydVRpTmhPS2RnM2RBL0hibkpCeElkVVYxaCt1YjlPUTVWMjVy?=
 =?utf-8?B?TDR6eDZmYVdBU2JRa1lud2VkeHBQUS9HUTFnanROVHpwbmM1Rzh0dlM0TmJj?=
 =?utf-8?B?VCs0QXltYVFWdWtpR2Ezd0FvNC9RMnREcTY4SVRrNWlveGZVZWp2VzhqT1R0?=
 =?utf-8?Q?2YaTKeyPL8JMm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHVZalY3NjIraW9nMFRoNVhEY1Vma0RXNi9WQUNydTNjTDh4TXlMMnlYOE1I?=
 =?utf-8?B?c2hGVUxhTEUzZ2drTTlwaE1qR2lTMjdTUkNPbVU3WndWYUlSaHV3S3N1STNo?=
 =?utf-8?B?STJrTnJXVEZOMkxTd3ZuSnVYV3ZHU2wwOUErZGE4N3FNQ2ZMQ2M0UVpoaHpm?=
 =?utf-8?B?Wk04MlhTWnFXK0UvWGYweFRvTExSUFJNU3JwT2s5Q3BPS09KUy8zcklXZEsv?=
 =?utf-8?B?YW9VSGpsZmt3V0hudjJRcjd1Rlp1dE5sd2JTcXNJV1VEcE9taWpBUXg2d1pC?=
 =?utf-8?B?a0p4ZTFpcEdBR2tFbWVESjRqNTBMQ0Q0QkhDTDdEcWFwR0QwUU1QV2QzSllU?=
 =?utf-8?B?bzhCM1A5b3dLa1Y3V01zZFZtMjBVek5ESm5MMmlERkZ4WXZXVXpzbC9HUnZP?=
 =?utf-8?B?TS91LzAvcEJWWm93RFhabm9ZOGU5VlM4eWR1L2FTRTV1TUY3K0Y1djBydVRB?=
 =?utf-8?B?SFhjTmNRR3RMdUo3RW9CZVNWMVNPNWs0bTlSLzNWakpkL29DMnpiRDRWeW1o?=
 =?utf-8?B?ZDJyN3pVcEh6S0FGbjA2Y3UxNFdXUmVUcVlwbEY2a1RmQjlEam1mcE5nTmtH?=
 =?utf-8?B?VFlVNHkzOGtxM1orQ2ZPNG9YRTB5OGpibWtFS2JOa2ptaDUrcXZuVFl2ZTBR?=
 =?utf-8?B?M1Bmc2c3Q1h2aGJHSzVkZitTNTJYTWVrbm1hZ1dabXlWYWtVR2t0blg1NmNh?=
 =?utf-8?B?bEIyTnBTUExEalN0TDFhRXVDQTg4d2xhaGJVcDZ3YlVNQk52Q09vVzF4b3lS?=
 =?utf-8?B?VVc5am50dVNLUkRPcy9TcUZWQm1tNk1WVHNBcVk4cFFRU0FQU2txKzJIOWhv?=
 =?utf-8?B?K09tVWM4bkVVUmYraUUvOHpraG5NZHFlOU5FY3pXZ0JzenRQdTJEeE01Nnh6?=
 =?utf-8?B?UFZnd0EzUGpMbW5VUzRPcUJCb3YxMzZ6ZWdUUWhDOThkL2xuZnhtbExIdmFh?=
 =?utf-8?B?UTFSd0FQanJZQVljQUhheEtlUit5eHZ6amdQNDRsNnZVVHVMN2pvOUJrOUJo?=
 =?utf-8?B?Sjhad3dNRkswclBycW1kVnVsd0JCSE51empnSWhFc3FUTFhkdUdGMzdsRXF2?=
 =?utf-8?B?NTZIRWt2YTZIUFFWQ3BCUE5JQVl6YnFBRFhSWVVhdUxEU2tSdTV3aGZXb05s?=
 =?utf-8?B?OGpyaWxXN0M1RWxOdG5HTEFnaDh1OHZXZzN5S0ZHditQalFqMHUyTkZma28w?=
 =?utf-8?B?amEzR2pQY0JlR3BIUXhrTmIvdVl6SFpTMVFhTjl3SU1pTHJkNHFrOFhBdlZj?=
 =?utf-8?B?bGpsUnM4N293dDRxbHcrOVpoVENLTjh6RzZUWTVqd1hZTlJ3dDl4V29oMExq?=
 =?utf-8?B?MFN6RlFqWE9tQm1JKytMYVJLa2tPa0pIa0FNQzdiRG91MkRIdUVXSEZ2SEZP?=
 =?utf-8?B?VjREdzJCamlLYUdac3pQVzZFTUU0QXV0enFOZDhrN2tpN3E0YkU5TzVQbzI4?=
 =?utf-8?B?eUJKZVpGQmJ6RkJTSHUwR2dsMDIwZUJsSmFGUFlYdFhZYjQvUXdML0Mrdjcv?=
 =?utf-8?B?VVRLbG5NcXVlZ28zUFhCUFkycUwxU1VKWlo1MXNNNkNha2JhZjZpNnRCK0FV?=
 =?utf-8?B?L3YxTUhSUnM2U2g1enRzNGFtYVJyTUsrMlZwN3haM2R0THFlSGdjYmo1WEpY?=
 =?utf-8?B?UFduVGIrZ0xTWWJ3UVl5SEk0cHEvSDRUb1Q5ZEJ2ajNQY1Zkb1JrTm4zbjND?=
 =?utf-8?B?Q0VGbENkMTBTY3lVdHh0MnZlNGt3am1yQmVGZmo3cHpFcGlBWjYyMU9mclBJ?=
 =?utf-8?B?MWdsd1hIbk5pcCsrT0hjVDdJelp0M2swTEZ1TGtkeGs2ZG9KVFM2dXZ6UVo4?=
 =?utf-8?B?SWkyaURaTzd3YVRWTFg4aHdxVnVIc0VhOWdxVmJrZFkvRTRGQnJCeWNtRkkx?=
 =?utf-8?B?dnNwem5hanErQnpSNTZkMi9RQWhZWHFYSmd2R093bzdodUI5WXBZcU1TU2x6?=
 =?utf-8?B?Y1N4U0h6VE9YYWtUM3Q2L0hLbk1KczdxTStab2lYYzVJWG9ZUThWemJtLzh1?=
 =?utf-8?B?eDR4R1JWbmtFclNqbFN2dFpCbngvS3laQjNvM1dGbHFXWjVSdnQ4c2pxbnFE?=
 =?utf-8?B?MjFVd2wwSlAyZlY5RzdpcW1vaFdjQW8yMlk3aklIbVVLNWRheTA4VWFoN3Rk?=
 =?utf-8?Q?qW+wH0poDASSaSQLQQs5LC4FW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81998a0-9378-4c46-f847-08dd3f9337bc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 11:59:28.8089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOnhsBP91fIrI0l4eqKwd+XE0h9Jiy91rHSFxiP040lkRSHDIPw6jvjnH1IulpxG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997
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



On 1/28/2025 5:06 PM, Sundararaju, Sathishkumar wrote:
> Hi Lijo,
> 
> 
> On 1/28/2025 3:04 PM, Lazar, Lijo wrote:
>>
>> On 1/28/2025 2:39 PM, Sathishkumar S wrote:
>>> Add devcoredump helper functions that can be reused for all jpeg
>>> versions.
>>>
>>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 59 ++++++++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  7 +++
>>>   2 files changed, 66 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/
>>> drm/amd/amdgpu/amdgpu_jpeg.c
>>> index b6d2eb049f54..70f1e0e88f4b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>> @@ -452,3 +452,62 @@ void amdgpu_jpeg_sysfs_reset_mask_fini(struct
>>> amdgpu_device *adev)
>>>               device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
>>>       }
>>>   }
>>> +
>>> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block,
>>> +                   const struct amdgpu_hwip_reg_entry *reg, u32
>>> reg_count)
>>> +{
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>> +    u32 inst_off, inst_id, is_powered;
>>> +    int i, j;
>>> +
>>> +    if (!adev->jpeg.ip_dump)
>>> +        return;
>>> +
>>> +    for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
>>> +        if (adev->jpeg.harvest_config & (1 << i))
>>> +            continue;
>>> +
>>> +        inst_id = GET_INST(JPEG, i);
>>> +        inst_off = i * reg_count;
>>> +        /* check power status from UVD_JPEG_POWER_STATUS */
>>> +        adev->jpeg.ip_dump[inst_off] =
>>> RREG32(SOC15_REG_ENTRY_OFFSET_INST(reg[0],
>>> +                                          inst_id));
>>> +        is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
>>> +
>>> +        if (is_powered)
>>> +            for (j = 1; j < reg_count; j++)
>>> +                adev->jpeg.ip_dump[inst_off + j] =
>>> +                    RREG32(SOC15_REG_ENTRY_OFFSET_INST(reg[j],
>>> +                                       inst_id));
>>> +    }
>>> +}
>>> +
>>> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block,
>>> struct drm_printer *p,
>>> +                const struct amdgpu_hwip_reg_entry *reg, u32 reg_count)
>>> +{
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>> +    u32 inst_off, is_powered;
>>> +    int i, j;
>>> +
>>> +    if (!adev->jpeg.ip_dump)
>>> +        return;
>>> +
>>> +    drm_printf(p, "num_instances:%d\n", adev->jpeg.num_jpeg_inst);
>>> +    for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
>>> +        if (adev->jpeg.harvest_config & (1 << i)) {
>>> +            drm_printf(p, "\nHarvested Instance:JPEG%d Skipping
>>> dump\n", i);
>>> +            continue;
>>> +        }
>>> +
>>> +        inst_off = i * reg_count;
>>> +        is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
>>> +
>>> +        if (is_powered) {
>>> +            drm_printf(p, "Active Instance:JPEG%d\n", i);
>>> +            for (j = 0; j < reg_count; j++)
>>> +                drm_printf(p, "%-50s \t 0x%08x\n", reg[j].reg_name,
>>> +                       adev->jpeg.ip_dump[inst_off + j]);
>>> +        } else
>>> +            drm_printf(p, "\nInactive Instance:JPEG%d\n", i);
>>> +    }
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/
>>> drm/amd/amdgpu/amdgpu_jpeg.h
>>> index eb2096dcf1a6..1d334f35d8a8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>>> @@ -92,6 +92,8 @@
>>>           *adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;    \
>>>       } while (0)
>>>   +struct amdgpu_hwip_reg_entry;
>>> +
>>>   enum amdgpu_jpeg_caps {
>>>       AMDGPU_JPEG_RRMT_ENABLED,
>>>   };
>>> @@ -137,6 +139,7 @@ struct amdgpu_jpeg {
>>>       bool    indirect_sram;
>>>       uint32_t supported_reset;
>>>       uint32_t caps;
>>> +    u32 *ip_dump;
>> It's better to keep this at per jpeg instance level (amdgpu_jpeg_inst).
>> If the hang happens for a single jpeg ring, that will help rather than
>> dumping out reg settings for all instances.
> The devcoredump infra in amdgpu does not propagate the job itself or the
> hung instance, so there is no feasible way of doing this, meaning
> dumping only the affected instance.
> And if every instance is represented by an ip_block then I can implement
> this with a flag to handle per instance case, but I doubt it is, as seen
> from the below commit
> fba4761ca00f drm/amdgpu: partially revert VCN IP block instancing support
> 

Even if the API in its current form doesn't support per instance dump,
suggest to keept the reg_dump data struct in jpeg_instance. That way it
doesn't need any calculation to find the right offset etc.

On the other hand, a single copy may be maintained for the reg address
list if that is feasible. As I see the address calculation is dynamic
based on the instance id and it may not make sense to keep it in all
instances.

Thanks,
Lijo

> Regards,
> Sathish
>>
>> Thanks,
>> Lijo
>>
>>>   };
>>>     int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
>>> @@ -161,5 +164,9 @@ int amdgpu_jpeg_psp_update_sram(struct
>>> amdgpu_device *adev, int inst_idx,
>>>   void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev);
>>>   int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev);
>>>   void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev);
>>> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block,
>>> +                   const struct amdgpu_hwip_reg_entry *reg, u32
>>> reg_count);
>>> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block,
>>> struct drm_printer *p,
>>> +                const struct amdgpu_hwip_reg_entry *reg, u32
>>> reg_count);
>>>     #endif /*__AMDGPU_JPEG_H__*/
> 

