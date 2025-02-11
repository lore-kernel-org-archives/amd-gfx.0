Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA873C0219E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 04:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3122010E41B;
	Tue, 11 Feb 2025 04:18:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NkBcVdD4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D767810E41B
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 04:18:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8Yt0DBRFFIQWtHbQ3OitcU2aoUsBquQOOdwPCDAwIW3X28wqJDLwiixkPh4PODkN2VhM72HgI+loFjIFQJ6K0cfYuKPWZM7DjL4bZit9F9jI9yb9WmUcqsDIV7SG/oucSdPMcCpqdoK7XBOVPGxRSudHzZlI0Nk3USC2vc+GyPbH7cIy09HkE+47HY+ldogxiWA+81zYEZmsVoOErG03rILN6Dlh7Gj3NlGpVDEW5ZSLGlB21nWIRpCkS9KTI8/GZaMwfPG43BPK2+g/5y3sOB6fhC5Rzg6e5QGijdP9aC+UUTyVs9rbRiaZVlwx5LZDHC4TTXBM+VQcEp/YhtwKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlkJmhX7qrkzHPAVdvqK3+aUI/ibcuwy3KgH7BmT3QE=;
 b=uxZInITSTS1O1kd0w1EjY75puqdMZWo9//lguslNTOizkB4pdoODuPiImUiKh2SFmZzTwpKeEVBeJHlqSKBcMEXRYXU4KmFB/DU8TQKaGKEsBJiHeJglHvLHIICgdzqx4sjHLVHZ0E0Mu9/obCdd/UN3DvMe0uVS7VC0bOW3gu9JZeYuOUGIwApsUKG0kXJNxALXE+qTqaKPcLbPgwGSMUSoVVY5eDi/1xNIdzN03CALPYo1tvoaMhBaUOwiU2Dw5xnN1V3t55XzY46x7FwtzAhMy6zYRRioAZ3bfXgzHq1NtyjvnkWs8V6df0jVfMBdiO6VHE4vL/z33XHFK9nEQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlkJmhX7qrkzHPAVdvqK3+aUI/ibcuwy3KgH7BmT3QE=;
 b=NkBcVdD4ZuDYmXp8xkCb4KRdBTr5f3WaNNifBe1W8G4DqNXG/1TAMwe4GM4vpST7HRsVAZ1Zd1IuQKG9R6m4FQlbhdjtWAS52F7ezkSPCfHLd3uMwMWHGE0InXoavEb96NOvEOTzP/H76Yr4eQZEzq3JcstrT6OxG6YG4KlScwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by SJ0PR12MB7083.namprd12.prod.outlook.com (2603:10b6:a03:4ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 04:18:33 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%3]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 04:18:32 +0000
Message-ID: <1ea2b552-015e-4c19-82b9-52007bf45ef5@amd.com>
Date: Tue, 11 Feb 2025 09:48:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] drm/amdgpu: Add ring reset callback for JPEG4_0_3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>
References: <20250210142548.2321625-1-sathishkumar.sundararaju@amd.com>
 <20250210142548.2321625-3-sathishkumar.sundararaju@amd.com>
 <db44b482-2e61-414d-9c6b-9a1199e0a2f3@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <db44b482-2e61-414d-9c6b-9a1199e0a2f3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::23) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|SJ0PR12MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d46774-1557-41be-23ee-08dd4a53253b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlYvTzA0dnJ0YkR1OURkL2gwSUFBM0xvVFM2WlpkTklReGQ0eWQvcHNWbkZw?=
 =?utf-8?B?S2h3cU9kQlVOVEkzWFZWVDhiNDEzenk3MUhMNHMvU0Mwa2ttQS9HMmpwLy96?=
 =?utf-8?B?bXNXUlZrUDU1bnRsQWFYT0xFTEFpZnV4eW9uR0ZmcW5ES2tHd2lUK1lMNEEz?=
 =?utf-8?B?U2FJL1FoZlNHQ0hKVmRyd0lWZmF3RFRTSDFZclVLZUtOKzZKQm1DVVA2dThQ?=
 =?utf-8?B?elIxVGVBZ2gzNnN1eC9SYlE2Z2JuNmlwQ05NbTlyNENIYzFIK1dLcXhXd1Bj?=
 =?utf-8?B?QjZabFhQeGZSVGpndklDMSt3RjVQRzJwcFU2YzRiNEdZUFJObkVQQW1WM3Zk?=
 =?utf-8?B?SGJPY1BCdllIV0M0TUVvc0haUkNmb3JPQmxGVFZGS0xiVWJva2pEV3hHRGZQ?=
 =?utf-8?B?U0JCM0lmQStNYXBSU2t0QW5teFVidWJ1Z2FrOWpVS3hBVms2bzNqNDZUdGVm?=
 =?utf-8?B?MUp1OXNTd09kYVFLeTVrV2ZaZi9vcEs3ZnNMQlRidk1NMTRYMW9WYWI1NFBL?=
 =?utf-8?B?NUJrTDFiTFg4bllsZHV0Z1BzSjQyLzY1Q01pVGhLZzRnQlNMM0ptV1NNOXJP?=
 =?utf-8?B?eEdXeXo3TjU2Y2Ixc0lrZzlzQ1k1ek9QRk5nbHlhOG5kR1I4T3E4MWVtN1Rt?=
 =?utf-8?B?dVcxdlk1WS9DOWRaOW1zSXFMZ1A5M3Z4QnhCT0p0VFBLZlEwNk5JVDNaamZy?=
 =?utf-8?B?d2dZT2t5ZW5nMjlmcFJPaGdpdTB2bm5nM3lEbGNmT0VObFZSMmN3OGRWWGRi?=
 =?utf-8?B?eVdEdVgyQlBOSkd6dlpObjI1Syt0bnF4dStvaXNOdW50aUVvbjZmZzZwV1Jz?=
 =?utf-8?B?VzVKTVR6dmoydit4ZUJxU01VUnZUNk0yMnVDSUpDQUMweTBGcExIQUlucERy?=
 =?utf-8?B?Y1ZGUWk3T2RuL3FQam43V1gyUy9mVlM5dWxkNkdHU3FqUEZSN3JzK2F4eWRu?=
 =?utf-8?B?ekRKTUd6UERvQUlUQ2x0VUIxanduZU9SZk5RVitxdEJxMzNRKy9qNlBJaGI2?=
 =?utf-8?B?ZGhIUnRiblhsNW41MVM5YjdpRldneloyR3hSdDk1TGYrSzVRNGZadEpEN1Zt?=
 =?utf-8?B?cTdEcnY0VTBITkNRWFVSOW92U0hZdzFuQ3JYTEwxOE1jbjNNUkNPcHVTcnkx?=
 =?utf-8?B?N25PbXpXSTduNUxGVHlkZTFlakZtMCtMdlZva2NNSG01d05sZkFxZ1BieWlh?=
 =?utf-8?B?Y2FNeElGaitLQmMvdm8wemUxZGEwdnFGTG1KRzFXQTJyelk3RDhqZjBpR2t5?=
 =?utf-8?B?S1VKaDc5WjFnMUhhMjZXS1dvaENVdDlpTWFKdXdGVGpmZVp1Q09ON1ArN0U3?=
 =?utf-8?B?WXJQUExJQlJ0OTkza3pPVlBSdXJ3Q05jMmNmbGtOM21RYnRLWGxwajNXWE9O?=
 =?utf-8?B?WGdBOU1xMzdJUTJEdE5lRlNaR1FESnVtaU1naGNraFJ1UUMrdlZ6c3B0SFpU?=
 =?utf-8?B?b1RXSXR1UHd2S1lEVUhXL2dOZHh5TTFGa0V3OSszK0YvYnlXOTB6aXo0VTI1?=
 =?utf-8?B?MUtWc3REVkx1ODJXQzR5VlhOTmxvYy8vaVliUHoxOVlWaGU4TzlRU3lQMWlY?=
 =?utf-8?B?WllwelFHeUpqYzNHREZ3VGtvY3U5bWp6RkFYblAzTklYMUJJR2d1cW00aXJ0?=
 =?utf-8?B?MDNxT0g3UlJ1VVJlYzUvNmZIWUZzRDEwS01BR21JaUdjeTdPNFBCT0QvT1ZJ?=
 =?utf-8?B?aG9QdUtLMllDYlNIY3Vjb2o1YWZVMWplZFM3aFQwR0JRc3VJbWVpblJ0YkFJ?=
 =?utf-8?B?eFdDakRMQVRLZEx6V1J2MUxrck5BYlB2VFdiRUNTZ0t2aytnSmZHUlZNWFJF?=
 =?utf-8?B?RVluUnhoRGVoNWFZWVE3NlMwMzc5ZHM1UDA1YVBudWZLUURGaWlJemdlQlYy?=
 =?utf-8?Q?ITF7/Gz/rAaux?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUcvNnRzVHZUb3hpN3VMSGo1QmdteEZVdnFITnFzMVI4aGN1WkpzSzQ0QzQ5?=
 =?utf-8?B?eUF4NTRVaDJqZXZsQzhyaGZwUnRTeXc2UUxURk1JUUNDM0RWcXBFOW56NUFH?=
 =?utf-8?B?YUxSWVkrc2pKNEZUdC9hQklBQjdBYW8yRUFBdmRKeURaNm9jRkdjR2FIVXUy?=
 =?utf-8?B?K3FFU1o5bHQ0WEJ0YTA4WVZHZ2xZRnJYaUNDTTZFcFRLNmtVWTFKQ3M0NWxN?=
 =?utf-8?B?ZzlXbXYrSVhJWkpFRTRwa1hvZTNEbDIvazNKWlVkQ3NORXA5RXdZcEhkbzVs?=
 =?utf-8?B?UVB3allielFWKzU3eVhrdHlUa0FvSmZBYWw5djJodEZpZ2xYQVc0ckpDcnQw?=
 =?utf-8?B?eFA5SVM0RWs5dkZrV2V5bHVqMHdQbzF4VjVNNHRsV3Zna2llVUNpYkxhRDNY?=
 =?utf-8?B?eW5Rd0VqQS9SMXZDNWV6RGNQclRLMmNTWEw2QWdXTDlUTUNGYTc0SkQ0VGFy?=
 =?utf-8?B?a3hlMGZyeGUweTVDRjZHb1NGTTJIdUxXVk1rTjdvakNVcmZULzFKWWJKc095?=
 =?utf-8?B?L1hQcy9rNGNBUVdweS9NY0dvb0I0K0VMSm9YWGVSMFh0U3UxWnJhTkx6MEZX?=
 =?utf-8?B?VUVxK3RMaDV0VDBuVzhUeGcxS0ZZcGtMZUQ1UlFaTHRVd1QvTVJpbGZnbkF2?=
 =?utf-8?B?THU3SlpKdS9KaDc3Y09ycG80dHdxbmR3MWZXaXBnSkI3N08zU0JpTisvWHFh?=
 =?utf-8?B?d1NmVzZPa3hVdmhsTFgzQ1dMOEg4Yk5ZQ1R2NjN0aTVINWFNMjl0b3E1TVA3?=
 =?utf-8?B?ZExVbUhhYjRrSEtlYkRYNVhVN3YvV2h4ajd3Nno5M2c1anRyU2VwSjJncTZh?=
 =?utf-8?B?aE8zRmtleGZmaTE5aWtLM0tvTXNKRlo5UGEvS09WdThsYkhBeFcwN2lpM3l3?=
 =?utf-8?B?aXNRSTMxN2plTVpua3pxN3o3c2lndUVLTEFRTHVSbFJVRVM2L0Q4V3pheHNk?=
 =?utf-8?B?Rmp2dFBwMVpIUi9XMFY5VnR0TkE3YTQ5NjFOZU85VkljRncvQjg0YUlkUG1i?=
 =?utf-8?B?RE40T0paeFF6SmhqRWNhTldhMDRSMng0NDY5VVhNME85eWtqRkM4dVg5Zy9s?=
 =?utf-8?B?aDdrZkU1YkNGMTNRelc2N2FvZVBDdnZjeU5JcGRaUzhuRXpab29DdnV5RDFJ?=
 =?utf-8?B?WHVpNktSWitGYWFMRVZGT1dFQ09qRnpPdndzeUM4aGw1TFptQ1grQkY3azN6?=
 =?utf-8?B?MXk2dzVKcUcwYU9Zb0N5bFNyeGR4SGRzT1d6akFLWjR3UFRwK2gzS0gydld6?=
 =?utf-8?B?RmdFbVVtYVFCZ0x0Nk5WOVNiWGdDRVZTbUpHM0owT0p5K0pBOWFteGswSFJV?=
 =?utf-8?B?Qko2RlZSZEZwb1Ntb0t5YW1QR3F4TDJuVVFvTkw2RWhLbTVnTUp1WmZ4Z3Iz?=
 =?utf-8?B?bzcwWlJEM3dPUUtHaGt4aUQ1eDdobFFEYk9KbmJHT3crK3habVYvQnFiZTdr?=
 =?utf-8?B?alVndmhWZzlOaTZnMWIvOEljQ3JoN1NIWGpocVB2TXJFVzRHUWpSa0NRczRX?=
 =?utf-8?B?K3NDNjZnemkxZzcxTTRQaHNVV002OHR4dS90d1FFMFcrNHNNangyV1hIV3Fm?=
 =?utf-8?B?aVNjZWZXb2ZTMkpkUEJBTi9iQ3FRbUY3ZUFXTzNka1A4WmNId3BzNXBoRStk?=
 =?utf-8?B?eUhwOVNRRWp0VnNVNDFBN0NGdzIwVjdVQnI4TEZZTXhtRXNjKzhLY0JoNGVh?=
 =?utf-8?B?UnYvVDdtbHU0OFowZWlySVFuaDBTNGhXdWdaSGFJSVFveHc3V1NTQkxpekQx?=
 =?utf-8?B?ODhRTDh3SWszV3k4K1NSWEZ3QjkzMXlueHdRcG1hR2hYaU9tcEU1K3FoQyt4?=
 =?utf-8?B?Wlg4T0psdmVvVGkwdC9HeHdDa1N1T3dBdG9ZOGx5ZFJScjdoTVoxcGVrOXRX?=
 =?utf-8?B?UXNtTEUrV0diNFFUdWljS2t4MmZheTAvR3NCSlhnZzZtVjBTWEJBS3dlR3px?=
 =?utf-8?B?VUxFcFUxT21XQTRNczFJUytwRzFEUDdWYVdyOFQ5cCtGMExyckhGN3NzVHVI?=
 =?utf-8?B?ejB2SEtnQTZXWDhLZ2taY1BIckZCSXM4VXI3WEZtNENPMkNtZXlabXhhWStp?=
 =?utf-8?B?Vmp2RWF0eHVEelBxSkVpZHpnRkJQaGR6aWRMeStJeVg5a1h4Sm45WHBUUS9q?=
 =?utf-8?Q?asG4lYNVSDZg8VVmg1dTLRjPp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d46774-1557-41be-23ee-08dd4a53253b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 04:18:32.5492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKCpAM+liVdhumq8A7DQYckcmQEMyiFnK7kMyfZHSZgaZIjTFA6igAIUg2+5ehaWTm2BNsVOqiYdSUWm4PN5YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7083
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

Hi Christian,


On 2/11/2025 12:54 AM, Christian König wrote:
> Am 10.02.25 um 15:25 schrieb Sathishkumar S:
>> Add ring reset function callback for JPEG4_0_3 to
>> recover from job timeouts without a full gpu reset.
>>
>> V2:
>>   - sched->ready flag shouldn't be modified by back-ends (Christian)
>>   - use drm_sched_wqueue_stop()/drm_sched_wqueue_start() instead (Alex)
>>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 69 +++++++++++++++++++++---
>>   1 file changed, 63 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c 
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> index be0b3b4c8690..b6168f27addd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> @@ -204,14 +204,10 @@ static int jpeg_v4_0_3_sw_init(struct 
>> amdgpu_ip_block *ip_block)
>>       if (r)
>>           return r;
>>   -    /* TODO: Add queue reset mask when FW fully supports it */
>> -    adev->jpeg.supported_reset =
>> - amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
>> +    adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
>>       r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>> -    if (r)
>> -        return r;
>>   -    return 0;
>> +    return r;
>>   }
>>     /**
>> @@ -231,6 +227,7 @@ static int jpeg_v4_0_3_sw_fini(struct 
>> amdgpu_ip_block *ip_block)
>>           return r;
>>         amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>> +
>>       r = amdgpu_jpeg_sw_fini(adev);
>>         return r;
>> @@ -1099,6 +1096,65 @@ static int 
>> jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
>>       return 0;
>>   }
>>   +static int jpeg_v4_0_3_wait_for_idle_on_inst(struct amdgpu_ring 
>> *ring)
>> +{
>> +    struct amdgpu_device *adev = ring->adev;
>> +    struct amdgpu_ring *r;
>> +    int ret, j;
>> +
>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>> +
>> +        if (ring->pipe == r->pipe)
>> +            continue;
>> +
>> +        /* pause work submission on this core */
>> +        drm_sched_wqueue_stop(&r->sched);
>
> Again complete NAK for that!
>
> A HW backend should *never* mess with the scheduler front end whatsoever.
>
> What exactly is the requirement here? Do we need to make sure that the 
> JPEG engine isn't touched by the scheduler at all?
Yes, that's the requirement, stop submitting jobs on any ring 
corresponding to this instance, each instance in JPEG4_0_3 has 8 cores
among which one of them is hung at this point, so want the complete 
instance to be idle before reset sequence.

Also per-core reset isn't able to recover from hang I generate with 
wrong command in IB (skipping sequence), or few other known
ways of simulating hangs on jpeg, the reliable method I see so far is to 
reinitialize the JPEG instance (pgcg gate/ungate and reinit, this is
able to recover from any kind of hang), but after the idle check on this 
instance to make sure no active contexts are decoding on any of
the rings/cores on this instance, while they can simultaneously on other 
instances and resume on this when it is back online. I can
first try per-core and up on its failure, fallback to per-instance as 
bigger reset, but stopping the jobs on all rings/cores for this instance
is required for that, without this rest of the good jpeg contexts on 7 
other cores will fail to function as expected.

This requirement is specific to JPEG4_0_3 and a few versions where each 
instance has mutiple jpeg cores that can simultaneously run
decode jobs from a single mjpeg context or multiple individual jpeg 
contexts, both of which can be interchangeably referred to in case of jpeg.

Please suggest, thank you.

Regards,
Sathish
>
> Regards,
> Christian.
>
>> +    }
>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>> +        if (ring->pipe == r->pipe)
>> +            continue;
>> +        /* wait for idle on all cores except on the hung core */
>> +        ret = SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, ring->me),
>> +                        regUVD_JRBC0_UVD_JRBC_STATUS,
>> +                        jpeg_v4_0_3_core_reg_offset(j),
>> + UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
>> + UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned 
>> int vmid)
>> +{
>> +    struct amdgpu_device *adev = ring->adev;
>> +    struct amdgpu_ring *r;
>> +    int ret, j;
>> +
>> +    if (amdgpu_sriov_vf(adev))
>> +        return -EINVAL;
>> +
>> +    ret = jpeg_v4_0_3_wait_for_idle_on_inst(ring);
>> +    if (ret)
>> +        return ret;
>> +
>> +    jpeg_v4_0_3_stop_inst(ring->adev, ring->me);
>> +    jpeg_v4_0_3_start_inst(ring->adev, ring->me);
>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>> +        jpeg_v4_0_3_start_jrbc(r);
>> +        ret = amdgpu_ring_test_helper(r);
>> +        if (ret)
>> +            return ret;
>> +        else if (ring->pipe != r->pipe)
>> +            drm_sched_wqueue_start(&r->sched);
>> +    }
>> +    return 0;
>> +}
>> +
>>   static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
>>       .name = "jpeg_v4_0_3",
>>       .early_init = jpeg_v4_0_3_early_init,
>> @@ -1145,6 +1201,7 @@ static const struct amdgpu_ring_funcs 
>> jpeg_v4_0_3_dec_ring_vm_funcs = {
>>       .emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
>>       .emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
>>       .emit_reg_write_reg_wait = 
>> amdgpu_ring_emit_reg_write_reg_wait_helper,
>> +    .reset = jpeg_v4_0_3_ring_reset,
>>   };
>>     static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device 
>> *adev)
>

