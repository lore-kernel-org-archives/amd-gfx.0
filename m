Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBD0CA0FF6
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 20:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 462A310EAC4;
	Thu, 28 Aug 2025 20:46:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b9yrmI81";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F391D10EAC4
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 20:46:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rk+JqWj/zmVqjUWRcfYf1yckcbqUfN+wAbBxAXCpx3PmyPD1oNplWi9RY8pPGmA8a6ZZYwzFqxOTg8nCd8QT/M37ZpZ0xbN3oAtcRPcKcL3a3uRRBpcAzyiJeRN1ysh5YXNdtqPoa7rAFmp/5pcQE8gzuff6B70uH6TCMXSsLv2Iw9qP4AzAl9/tZnQg9XIUZmAP5n/+T4o591oNL0bNQByuMvI2KQ3AaUv8yOsY/o7b5me0pP2X+kGSUjmsxRgjPYztGiiBOvWcOXta7NPmx1BVuio3VXW7DrWafiDKRzd1jR1R1rF5SRpeVuOMgrE69P5vU+cJn2gE7QqdMLSHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCiJDwX29NoAVdUAQ25DH2bLW/DQKiEBf5S70EBdrss=;
 b=mFNmvVoR4iIPuGk8yr3WgQ5Q5iW6T91hSXQB/c3LlOLXuJA99u3P3tB19rxN9YQxwiHTuujuUS/L1FGVEKZGEZA0KY7IauQX2RZSMgLqdgvRUCnoFlcC8JRX4X8KHCgwLjHssPlOEa8OensCtpXvw8iFew2nk98Jw7C+jKFmLtUdnjeA+2787Rx+i3bp1JyVP9/D7856gX7HFghwD6UMZ4w1mrB2RqWXFtQ3V9EGnFollBTuNexApG51PFWxsHL2XjnSRlnhO4UQsJrZm4QRQyVWXnfQA1CoOARafZSFm+mj4sh8RalBgCWwZ3Pqy+FLB6SHK/h3S/jq2yq2oAOvKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCiJDwX29NoAVdUAQ25DH2bLW/DQKiEBf5S70EBdrss=;
 b=b9yrmI819TMrxcS+vWXIAkV/zT6+3vL8TAbV2ZNi/PC76H36vvWMGwZwZxA9lWYRORCZFzJyKEsoUYRTcCVGxTxIuGo5Djjp1Lu3mFn6j47VDAV3EO5T2PO6d1cRv1Tu/rX068jeWr4m5RC3RA7WB2jeF9t58yyb9mpwzqlS2es=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 20:46:18 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 20:46:17 +0000
Message-ID: <58b22484-c3ab-48f4-a588-5cf85ad1cacf@amd.com>
Date: Thu, 28 Aug 2025 16:46:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clean up and unify hw fence handling
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 David.Wu3@amd.com, christian.koenig@amd.com
References: <20250828140548.5792-1-alexander.deucher@amd.com>
 <c3386a43-a7fa-4ebe-bb37-3145cad47a52@amd.com>
 <CADnq5_O9QBP5Qye+3AUwLHJYwnf4gTzw1y_VQzFPVa+1Krdidg@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_O9QBP5Qye+3AUwLHJYwnf4gTzw1y_VQzFPVa+1Krdidg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0489.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::8) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a6116a-792d-4794-2cb7-08dde673efa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1BLcEY5WXdRVTlUWm5NUGtKeEFaZjVFRkVxWVUzRjBnS0JINDJyTVhwQzFL?=
 =?utf-8?B?bGI3eWVuNFN0cjVnRklxUFlHcjRNRFhRZVNmMmN2WDdBTzE2S2d5RVpaM3pm?=
 =?utf-8?B?Tnk2Tk4rb0hYWDh5T2dudWh4WlRKSjQzcnBGMUxDNlUvR1AweVRYbUxOQnpQ?=
 =?utf-8?B?cGtaZlJoRFNwalVqdmVKcHZqWTk0WjZoU1paQkZralVNNnNCWmsyNjc5ZGZL?=
 =?utf-8?B?UmNLdVVJNW9WZEEwMWNqckZPZkdJR0kyWkp3NWszOUZlczR3NHlNcGRNZU4v?=
 =?utf-8?B?K2huZXJzWkpNNVp2U3F1YlZTZ2xEemFKZng5cXBucDU4U3NUK09NVCtITmly?=
 =?utf-8?B?R0xlcm9wTUhUd0FvTzlCeWQzY2xqbWpZalhyS2tjdFgyZGIvME45UTJZMGdG?=
 =?utf-8?B?dUloeFNjdWZ4Z0RBemVobFcwd3RTbEZSd0huRy9mQVg4QytxaEVsOGV0Rm9G?=
 =?utf-8?B?dVRzb2hFRXRpdGQ3cHdXWmd1QU9keW55bjFiNzFMdmU0eXprM1BPc3lGa0JO?=
 =?utf-8?B?MCs1ZS9oLzZoZExLcm9ONUIrZG1Fak83RTczd2puT3p5bTQxbWdtSWQwYWxq?=
 =?utf-8?B?R0o5RUUxRGpmRksrcUgvTVI0akNyVCtybXRrclVWOGRadUxWeUV3Wkx1UHZt?=
 =?utf-8?B?NjlwbTN2UDNUYUN2bkxYMzdmL3BNbGVqdXZjR0hmZEtseUxBaUdsVTRkazRY?=
 =?utf-8?B?V085R0RUa2tlZmZPS3Z3QnhBMXhjTnB0c1hrZTB5SVF5Vm1lRmZoL0pXc0N6?=
 =?utf-8?B?T0Z3dDRMK2FnNXk2RFF1bGhieWovalRScWduSWVzVy9mSG0rNkU2K2dSbGNY?=
 =?utf-8?B?aS8zVzhZWndLM3hzWVpNRVBiWDJOcnljajhXOThDT0Q5d2RnOTNBdDdzU2tE?=
 =?utf-8?B?M1R3U2ZuYUFmZG9zUnBiamI1RHVqUXU0SmdIaDVIU0xCZG42TWFrRlBRaVNS?=
 =?utf-8?B?eFhFeWw3YXZWSnF6ZjQvTCs3Zi9MRXVWaUZBeHhvT0YzOFJzOE12S29SVEFn?=
 =?utf-8?B?UDlaVEVnNDRTdTkzbnVXalZGeSthdXViRnlVc1RiNklsemEwblZ1U29tcnkz?=
 =?utf-8?B?SzU0YWhDZkdXcXJLSUxjZ0J5UXFHUXR3UGU1enBidXcyMlNUdURad1NsUnVl?=
 =?utf-8?B?OTJuQnpJSjd0a3ZtQ1h4RjJaZDVha1ZxNjFUZndPR1VpS0w0K05kWXRHRVd6?=
 =?utf-8?B?eGswZDUwWndIYVF0R2dDVWNuREVHeEpzUXp5OW9oTndjZVFsTDROZnhmbWtr?=
 =?utf-8?B?bWJ5NU5HbUVPZXpWbDBHQ2cvRmQ1U3pQQ1ZZWmZpamV1aStha2xMVVpiSjhD?=
 =?utf-8?B?UGNhZTE4S2JYblEzUlNpeUh0OERJS0VkNTBhTUJKYlJhUWp1ZkROQXZkUm1P?=
 =?utf-8?B?MTZ5OGFDU3cyUDRjdE5qMktrM250d2lBZlRNU3dCcHl4eVd3ekY0WGVhWHU4?=
 =?utf-8?B?VXhHejZEVE5ycFJVS0oxWWFCUlFSQ3p4MGxXYkVxeHY1aUZSMTdiRWcxZVFk?=
 =?utf-8?B?bVdReHJjdVp6Y0p0SHlPNVFvc3N3WGhYN2FFclB6NmJrc3FwZEpGUzVndmpZ?=
 =?utf-8?B?R2RORHJpK2dkRkFIRnROMXZ1YW5Ua2wwcTNsSWZLMjAybjh6MTNnWUlJaVNS?=
 =?utf-8?B?S2RIMGUxNXZPdWlXazdoRmlaSmJVVXIyaDFlZnFNZzJLMy93aDV1SGdkSnNI?=
 =?utf-8?B?clBqbENnMng4c2JRcVhOWVh4enZ5RGNEaFBQRjlJaStsREZjcWFuRnNra28x?=
 =?utf-8?B?SzJnTjd2T2wwaTdWZlN4T3hRczJSaDRQaUc1NXAyT0xmM3RSTWpFaDJteTU5?=
 =?utf-8?B?NGJQUmgyNzUvRlB3Nml2SXdKNDliYW9pUWJKSW13YjRVV3lFSW9zN2RwZThs?=
 =?utf-8?B?VmducFg4WUJqSU1jeEUwdlFZUEp1ZUg4R1JWaTIvOUUza2FIK1poTWdGdFQz?=
 =?utf-8?Q?3adEE85XTkY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWNHUXlzd0I2dmp4SDFTemdBUXprbnY2SEYxZ1JxSk91Zk1JNmlFSDVRVU1M?=
 =?utf-8?B?ZWl4UmNkTlBNQW96MCtURnZ4aVdBS1Ewc21JTGw4K0NJakJVMkVLd0pabXJq?=
 =?utf-8?B?TWpPMmtxTzhvOHRFWmNPTUxaWWliczVFV1M4SVRHbmxTSzRJajhQbzlXVjFi?=
 =?utf-8?B?M0FMUURlT09kZ2pNRi9tQUw0QnNQd0VXVUlkTnA2a0Z3eEpoc1Bvd0Y1WVBP?=
 =?utf-8?B?MVM5c0VNTUpDbFFUUTJzWVpZTGw1VTRMWDRYTUl4Q2pMSG8za01KdytDQXVj?=
 =?utf-8?B?Z3R4MCtyMmtJbVlSaUxsV3gxbkFWWGJobFhyVXdDNElEZW9KRURLbWJvZUFQ?=
 =?utf-8?B?T0UyVVZhZWp3QVJUQUpzeWh3YXNVRDJXY2lyQnZMMVBzUUpJblQxQnJhdEl0?=
 =?utf-8?B?aEllaVBnbEtYQ1ZiUm83VVRvVkRkNm10OVJwTjhyd2FYVHpNZUk2SytxQm9U?=
 =?utf-8?B?ZUJJUjRTUTJXSjN3SzlWRFBKU0ttRWUva3pYNm4rK0ovOERSY09tZFU1eEVV?=
 =?utf-8?B?OS9hOTZCcUZqYU5DRjV4cFk0SkZ1aS93SUF6emIrbVhSK1Zub1VwL0RMVlpk?=
 =?utf-8?B?cUZmQVptOVBYdmFNK1M5V1UrVjlqbWo4bDVtZ21VTTZ4OFA2SDJvV3BSTTA2?=
 =?utf-8?B?MGRCbndHQmFxYzltQ1V6Wk1BaExBaGJxaUM1STVPenFSU1BBU2drWkZoOXFz?=
 =?utf-8?B?Wnp2aHZQdDhDTHA2bGN1d0pBSW5ES3VwWnpLcjVibUlXVEZhV2tsdXZlcm1x?=
 =?utf-8?B?aHpSWVd0d2Jua0hQOUt2VHEreEhqMEh1OUh0MHdBaXczTXBqSHBBak9aSTNj?=
 =?utf-8?B?RVRYU1NQVlMwNnVMUzFVU0xHR1EzdW9NekwweXRBSTk0S0RVNFd1MVhFa01R?=
 =?utf-8?B?TGx3cTFZY1NsRGZtODVhVy9JQXcxTXlvN1ExVFB3NFJlRVZnRFNOdlQ0LzVD?=
 =?utf-8?B?aGVnck5LVkhtMFp5ZEtwc1k0MDJ5NHRkeDI5a1YvK1d5bEk0ZDVtS2VJTnZR?=
 =?utf-8?B?V0dDdzdWQ0VMdGxJSE5NM3ZzaW5LRUNGRmlmMy84Z05DbUhpaFVSSlpKVDkz?=
 =?utf-8?B?VTR4dVg2eUpabThzenJrZmxzazBONXc3M2R1RHZhOTQzRXJwSnZWcUY2YmZN?=
 =?utf-8?B?UXdTMVVQR2JLTWZmRDhPQWQ4cGJvTmlTeUM1SG1IUWEvR05FdjFYVWVsb0hk?=
 =?utf-8?B?UkovdjRTN1oxTG9lTTdXODFvc2t3NWtzQ0dxWHVaanFER3llR3hrdzR2bmdY?=
 =?utf-8?B?RHBiL1R4U1djalVrdnhrVkpoSklzSnNSMWpIa29oNk5GUmxneVNFUmFaVEdG?=
 =?utf-8?B?M3FJdDNrSE1pbUoyOVFtMkZ2cG9jaFBMc2l1bG1EYmJVUkhIU2R0M2JXR0s5?=
 =?utf-8?B?VzROeG0yMkVJaGErSTkzK2c4cDY1cUhQKzJPYjlIOGpyWVNmSlVTVkZtUXA3?=
 =?utf-8?B?YS84MkY1dzF0dUo0bDl5UHNPNnZKTVFJbGJrN1RVd1ZlZzRDY1BWSVZZc0N0?=
 =?utf-8?B?TnFySDlXVDVIRk4xNm5nZjR2VklId3JQVnAwdHhoS0xEVE81RkxwRk9MUEF5?=
 =?utf-8?B?TUZCVFg3NGV0NDdLckNNVU12RHFZL1VCQi9hNXNmNGw4NWJqNUVLOGV3Y3dD?=
 =?utf-8?B?d0xHS1VwK2hocVRoSkM1TmQxZUErb1V1UWRjU29YS0pWYWJlcG5YRzBhU09n?=
 =?utf-8?B?a3d6ckxJeHFxWmsyYkpNYnExVmNrSkVQRzNBSW5kcXo3VVhodHRacndGbFcy?=
 =?utf-8?B?azdtRHZlamc3Y0VhL3p2YzlrZWNvY25uR0RtSmRsMmlJMHg4UmRhTGlCMjlD?=
 =?utf-8?B?SmhDSHR1TDlsYlBTTDNKR1kzbmJPUStxaGVmaktjMG16b0xHZFY2WEVYZkRD?=
 =?utf-8?B?Q2RaSUhlaXI5RHY2dGVlL0NjTWVNRUloNlBITmFnc09WRnYvT3pNQWN3RW5I?=
 =?utf-8?B?WEZzM2NDRmxOSjQwWVpUZkpRRXRkZ05rMURnYWtFcDRPK0NhSXRrQXRHbmk4?=
 =?utf-8?B?dFVYbzJBYThzd1M5Q0FvbkRxbklNTzlqZUxMZ1BUbWdEczcwb215cmF0cVJE?=
 =?utf-8?B?Z2FvdXd1NlE3c2hPYkR6L09IaXcvYVVwTnY4U3RqTCtrcm0wL3gwSWUvY1NL?=
 =?utf-8?Q?SwJcSE/kJhljEXUBouWEYizby?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a6116a-792d-4794-2cb7-08dde673efa3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 20:46:17.4831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YnzrEl/DBf0ukEpZIdY783PtNBreIPol44/KXbdFdKH+zBPkcyfYFsqaQnpSd3E05XIBeZBH249ONQLPZT6Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132
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

On 2025-08-28 16:26, Alex Deucher wrote:

> On Thu, Aug 28, 2025 at 1:38 PM David Wu <davidwu2@amd.com> wrote:
>> On 2025-08-28 10:05, Alex Deucher wrote:
>>
>> Decouple the amdgpu fence from the amdgpu_job structure.
>> This lets us clean up the separate fence ops for the embedded
>> fence and other fences.  This also allows us to allocate the
>> vm fence up front when we allocate the job.
>>
>> Cc: David.Wu3@amd.com
>> Cc: christian.koenig@amd.com
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>
>> v2: Additional cleanup suggested by Christian
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   7 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 140 ++------------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  22 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  41 ++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   7 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +-
>>   8 files changed, 64 insertions(+), 165 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index f81608330a3d0..7ea3cb6491b1b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
>>    continue;
>>    }
>>    job = to_amdgpu_job(s_job);
>> - if (preempted && (&job->hw_fence.base) == fence)
>> + if (preempted && (&job->hw_fence->base) == fence)
>>    /* mark the job as preempted */
>>    job->preemption_status |= AMDGPU_IB_PREEMPTED;
>>    }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 7783272a79302..add272fa31288 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5798,11 +5798,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>    if (!amdgpu_ring_sched_ready(ring))
>>    continue;
>>
>> - /* Clear job fence from fence drv to avoid force_completion
>> - * leave NULL and vm flush fence in fence drv
>> - */
>> - amdgpu_fence_driver_clear_job_fences(ring);
>> -
>>    /* after all hw jobs are reset, hw fence is meaningless, so force_completion */
>>    amdgpu_fence_driver_force_completion(ring);
>>    }
>> @@ -6526,7 +6521,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>    *
>>    * job->base holds a reference to parent fence
>>    */
>> - if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
>> + if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
>>    job_signaled = true;
>>    dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
>>    goto skip_hw_reset;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index 2d58aefbd68a7..1355fee0e978d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -45,16 +45,11 @@
>>    * Cast helper
>>    */
>>   static const struct dma_fence_ops amdgpu_fence_ops;
>> -static const struct dma_fence_ops amdgpu_job_fence_ops;
>>   static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
>>   {
>>    struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
>>
>> - if (__f->base.ops == &amdgpu_fence_ops ||
>> -    __f->base.ops == &amdgpu_job_fence_ops)
>> - return __f;
>> -
>> - return NULL;
>> + return __f;
>>   }
>>
>>   /**
>> @@ -98,51 +93,33 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>>    * amdgpu_fence_emit - emit a fence on the requested ring
>>    *
>>    * @ring: ring the fence is associated with
>> - * @f: resulting fence object
>>    * @af: amdgpu fence input
>>    * @flags: flags to pass into the subordinate .emit_fence() call
>>    *
>>    * Emits a fence command on the requested ring (all asics).
>>    * Returns 0 on success, -ENOMEM on failure.
>>    */
>> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>> -      struct amdgpu_fence *af, unsigned int flags)
>> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
>> +      unsigned int flags)
>>   {
>>    struct amdgpu_device *adev = ring->adev;
>>    struct dma_fence *fence;
>> - struct amdgpu_fence *am_fence;
>>    struct dma_fence __rcu **ptr;
>>    uint32_t seq;
>>    int r;
>>
>> - if (!af) {
>> - /* create a separate hw fence */
>> - am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
>> - if (!am_fence)
>> - return -ENOMEM;
>> - } else {
>> - am_fence = af;
>> - }
>> - fence = &am_fence->base;
>> - am_fence->ring = ring;
>> + fence = &af->base;
>> + af->ring = ring;
>>
>>    seq = ++ring->fence_drv.sync_seq;
>> - am_fence->seq = seq;
>> - if (af) {
>> - dma_fence_init(fence, &amdgpu_job_fence_ops,
>> -       &ring->fence_drv.lock,
>> -       adev->fence_context + ring->idx, seq);
>> - /* Against remove in amdgpu_job_{free, free_cb} */
>> - dma_fence_get(fence);
>> - } else {
>> - dma_fence_init(fence, &amdgpu_fence_ops,
>> -       &ring->fence_drv.lock,
>> -       adev->fence_context + ring->idx, seq);
>> - }
>> + af->seq = seq;
>> + dma_fence_init(fence, &amdgpu_fence_ops,
>> +       &ring->fence_drv.lock,
>> +       adev->fence_context + ring->idx, seq);
>>
>>
>> seems we are missing a dma_fence_get(fence) somewhere as I got the following error
>>
>> [    8.317720] ------------[ cut here ]------------
>> [    8.317723] refcount_t: underflow; use-after-free.
>> [    8.317734] WARNING: CPU: 18 PID: 752 at lib/refcount.c:28 refcount_warn_saturate+0xf7/0x150
>> [    8.317743] Modules linked in: amdgpu(E) amdxcp drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_helper video drm_panel_backlight_quirks cec rc_core drm_buddy drm_display_helper drm_client_lib drm_kms_helper nvme drm igb ahci nvme_core dca i2c_algo_bit libahci wmi hid_generic usbhid hid
>> [    8.317786] CPU: 18 UID: 0 PID: 752 Comm: kworker/u256:2 Tainted: G            E      6.14.0+ #61
>> [    8.317790] Tainted: [E]=UNSIGNED_MODULE
>> [    8.317792] Hardware name: Gigabyte Technology Co., Ltd. X399 DESIGNARE EX/X399 DESIGNARE EX-CF, BIOS F11 10/04/2018
>> [    8.317795] Workqueue: sdma1 drm_sched_run_job_work [gpu_sched]
>> [    8.317804] RIP: 0010:refcount_warn_saturate+0xf7/0x150
>> [    8.317808] Code: eb 9e 0f b6 1d 92 c1 ba 01 80 fb 01 0f 87 32 6e 7c ff 83 e3 01 75 89 48 c7 c7 f0 c7 1e a2 c6 05 76 c1 ba 01 01 e8 69 93 8f ff <0f> 0b e9 6f ff ff ff 0f b6 1d 64 c1 ba 01 80 fb 01 0f 87 ef 6d 7c
>> ...
> For posterity, the problem is here:
> -       else if (job->hw_fence.base.ops)
> -               f = &job->hw_fence.base;
> +       else if (job->hw_fence)
> +               f = &job->hw_fence->base;
>
> We need to check if the fence is initialized (ops is present), not
> just whether the fence is allocated.
thanks for the info 🙂 I will test and report back to the new patch...
> Alex
>
>>    amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>>          seq, flags | AMDGPU_FENCE_FLAG_INT);
>> - amdgpu_fence_save_wptr(fence);
>> + amdgpu_fence_save_wptr(af);
>>    pm_runtime_get_noresume(adev_to_drm(adev)->dev);
>>    ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
>>    if (unlikely(rcu_dereference_protected(*ptr, 1))) {
>> @@ -167,8 +144,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>>    */
>>    rcu_assign_pointer(*ptr, dma_fence_get(fence));
>>
>> - *f = fence;
>> -
>>    return 0;
>>   }
>>
>> @@ -669,36 +644,6 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
>>    }
>>   }
>>
>> -/**
>> - * amdgpu_fence_driver_clear_job_fences - clear job embedded fences of ring
>> - *
>> - * @ring: fence of the ring to be cleared
>> - *
>> - */
>> -void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
>> -{
>> - int i;
>> - struct dma_fence *old, **ptr;
>> -
>> - for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
>> - ptr = &ring->fence_drv.fences[i];
>> - old = rcu_dereference_protected(*ptr, 1);
>> - if (old && old->ops == &amdgpu_job_fence_ops) {
>> - struct amdgpu_job *job;
>> -
>> - /* For non-scheduler bad job, i.e. failed ib test, we need to signal
>> - * it right here or we won't be able to track them in fence_drv
>> - * and they will remain unsignaled during sa_bo free.
>> - */
>> - job = container_of(old, struct amdgpu_job, hw_fence.base);
>> - if (!job->base.s_fence && !dma_fence_is_signaled(old))
>> - dma_fence_signal(old);
>> - RCU_INIT_POINTER(*ptr, NULL);
>> - dma_fence_put(old);
>> - }
>> - }
>> -}
>> -
>>   /**
>>    * amdgpu_fence_driver_set_error - set error code on fences
>>    * @ring: the ring which contains the fences
>> @@ -765,11 +710,9 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
>>    amdgpu_fence_process(fence->ring);
>>   }
>>
>> -void amdgpu_fence_save_wptr(struct dma_fence *fence)
>> +void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
>>   {
>> - struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
>> -
>> - am_fence->wptr = am_fence->ring->wptr;
>> + af->wptr = af->ring->wptr;
>>   }
>>
>>   static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
>> @@ -830,13 +773,6 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
>>    return (const char *)to_amdgpu_fence(f)->ring->name;
>>   }
>>
>> -static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
>> -{
>> - struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
>> -
>> - return (const char *)to_amdgpu_ring(job->base.sched)->name;
>> -}
>> -
>>   /**
>>    * amdgpu_fence_enable_signaling - enable signalling on fence
>>    * @f: fence
>> @@ -853,23 +789,6 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>>    return true;
>>   }
>>
>> -/**
>> - * amdgpu_job_fence_enable_signaling - enable signalling on job fence
>> - * @f: fence
>> - *
>> - * This is the simliar function with amdgpu_fence_enable_signaling above, it
>> - * only handles the job embedded fence.
>> - */
>> -static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
>> -{
>> - struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
>> -
>> - if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback_timer))
>> - amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
>> -
>> - return true;
>> -}
>> -
>>   /**
>>    * amdgpu_fence_free - free up the fence memory
>>    *
>> @@ -885,21 +804,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
>>    kfree(to_amdgpu_fence(f));
>>   }
>>
>> -/**
>> - * amdgpu_job_fence_free - free up the job with embedded fence
>> - *
>> - * @rcu: RCU callback head
>> - *
>> - * Free up the job with embedded fence after the RCU grace period.
>> - */
>> -static void amdgpu_job_fence_free(struct rcu_head *rcu)
>> -{
>> - struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
>> -
>> - /* free job if fence has a parent job */
>> - kfree(container_of(f, struct amdgpu_job, hw_fence.base));
>> -}
>> -
>>   /**
>>    * amdgpu_fence_release - callback that fence can be freed
>>    *
>> @@ -913,19 +817,6 @@ static void amdgpu_fence_release(struct dma_fence *f)
>>    call_rcu(&f->rcu, amdgpu_fence_free);
>>   }
>>
>> -/**
>> - * amdgpu_job_fence_release - callback that job embedded fence can be freed
>> - *
>> - * @f: fence
>> - *
>> - * This is the simliar function with amdgpu_fence_release above, it
>> - * only handles the job embedded fence.
>> - */
>> -static void amdgpu_job_fence_release(struct dma_fence *f)
>> -{
>> - call_rcu(&f->rcu, amdgpu_job_fence_free);
>> -}
>> -
>>   static const struct dma_fence_ops amdgpu_fence_ops = {
>>    .get_driver_name = amdgpu_fence_get_driver_name,
>>    .get_timeline_name = amdgpu_fence_get_timeline_name,
>> @@ -933,13 +824,6 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
>>    .release = amdgpu_fence_release,
>>   };
>>
>> -static const struct dma_fence_ops amdgpu_job_fence_ops = {
>> - .get_driver_name = amdgpu_fence_get_driver_name,
>> - .get_timeline_name = amdgpu_job_fence_get_timeline_name,
>> - .enable_signaling = amdgpu_job_fence_enable_signaling,
>> - .release = amdgpu_job_fence_release,
>> -};
>> -
>>   /*
>>    * Fence debugfs
>>    */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> index 7d9bcb72e8dd3..71215aeb1b6f5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> @@ -128,7 +128,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>    struct amdgpu_device *adev = ring->adev;
>>    struct amdgpu_ib *ib = &ibs[0];
>>    struct dma_fence *tmp = NULL;
>> - struct amdgpu_fence *af;
>> + struct amdgpu_fence *af, *vm_af;
>>    bool need_ctx_switch;
>>    struct amdgpu_vm *vm;
>>    uint64_t fence_ctx;
>> @@ -148,18 +148,20 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>    /* ring tests don't use a job */
>>    if (job) {
>>    vm = job->vm;
>> - fence_ctx = job->base.s_fence ?
>> - job->base.s_fence->scheduled.context : 0;
>> + fence_ctx = job->base.s_fence ? job->base.s_fence->finished.context : 0;
>>    shadow_va = job->shadow_va;
>>    csa_va = job->csa_va;
>>    gds_va = job->gds_va;
>>    init_shadow = job->init_shadow;
>> - af = &job->hw_fence;
>> + af = job->hw_fence;
>>    /* Save the context of the job for reset handling.
>>    * The driver needs this so it can skip the ring
>>    * contents for guilty contexts.
>>    */
>> - af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
>> + af->context = fence_ctx;
>> + vm_af = job->hw_vm_fence;
>> + /* the vm fence is also part of the job's context */
>> + vm_af->context = fence_ctx;
>>
>> I think vm_af is not needed - above code can be
>>
>> job->hw_vm_fence->context = fence_ctx;
>>
>>    } else {
>>    vm = NULL;
>>    fence_ctx = 0;
>> @@ -167,7 +169,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>    csa_va = 0;
>>    gds_va = 0;
>>    init_shadow = false;
>> - af = NULL;
>> + af = kzalloc(sizeof(*af), GFP_NOWAIT);
>> + if (!af)
>> + return -ENOMEM;
>> + vm_af = NULL;
>>
>> vm_af can be removed.
>>
>>    }
>>
>>    if (!ring->sched.ready) {
>> @@ -289,7 +294,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>    amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
>>    }
>>
>> - r = amdgpu_fence_emit(ring, f, af, fence_flags);
>> + r = amdgpu_fence_emit(ring, af, fence_flags);
>>    if (r) {
>>    dev_err(adev->dev, "failed to emit fence (%d)\n", r);
>>    if (job && job->vmid)
>> @@ -297,6 +302,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>    amdgpu_ring_undo(ring);
>>    return r;
>>    }
>> + *f = &af->base;
>>
>>    if (ring->funcs->insert_end)
>>    ring->funcs->insert_end(ring);
>> @@ -317,7 +323,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>    * fence so we know what rings contents to backup
>>    * after we reset the queue.
>>    */
>> - amdgpu_fence_save_wptr(*f);
>> + amdgpu_fence_save_wptr(af);
>>
>>    amdgpu_ring_ib_end(ring);
>>    amdgpu_ring_commit(ring);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index 311e97c96c4e0..9a78fe01efa3a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -138,7 +138,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>      ring->funcs->reset) {
>>    dev_err(adev->dev, "Starting %s ring reset\n",
>>    s_job->sched->name);
>> - r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
>> + r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
>>    if (!r) {
>>    atomic_inc(&ring->adev->gpu_reset_counter);
>>    dev_err(adev->dev, "Ring %s reset succeeded\n",
>> @@ -185,6 +185,9 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>        struct drm_sched_entity *entity, void *owner,
>>        unsigned int num_ibs, struct amdgpu_job **job)
>>   {
>> + struct amdgpu_fence *af;
>> + int r;
>> +
>>    if (num_ibs == 0)
>>    return -EINVAL;
>>
>> @@ -192,6 +195,20 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>    if (!*job)
>>    return -ENOMEM;
>>
>> + af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
>> + if (!af) {
>> + r = -ENOMEM;
>> + goto err_job;
>> + }
>> + (*job)->hw_fence = af;
>> +
>> + af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
>> + if (!af) {
>> + r = -ENOMEM;
>> + goto err_fence;
>> + }
>> + (*job)->hw_vm_fence = af;
>> +
>>    (*job)->vm = vm;
>>
>>    amdgpu_sync_create(&(*job)->explicit_sync);
>> @@ -202,6 +219,13 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>    return 0;
>>
>>    return drm_sched_job_init(&(*job)->base, entity, 1, owner);
>> +
>> +err_fence:
>> + kfree((*job)->hw_fence);
>> +err_job:
>> + kfree(*job);
>> +
>> + return r;
>>   }
>>
>>   int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
>> @@ -251,8 +275,8 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>>    /* Check if any fences where initialized */
>>    if (job->base.s_fence && job->base.s_fence->finished.ops)
>>    f = &job->base.s_fence->finished;
>> - else if (job->hw_fence.base.ops)
>> - f = &job->hw_fence.base;
>> + else if (job->hw_fence)
>> + f = &job->hw_fence->base;
>>    else
>>    f = NULL;
>>
>> @@ -268,11 +292,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>>
>>    amdgpu_sync_free(&job->explicit_sync);
>>
>> - /* only put the hw fence if has embedded fence */
>> - if (!job->hw_fence.base.ops)
>> - kfree(job);
>> - else
>> - dma_fence_put(&job->hw_fence.base);
>> + kfree(job);
>>   }
>>
>>   void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
>> @@ -301,10 +321,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
>>    if (job->gang_submit != &job->base.s_fence->scheduled)
>>    dma_fence_put(job->gang_submit);
>>
>> - if (!job->hw_fence.base.ops)
>> - kfree(job);
>> - else
>> - dma_fence_put(&job->hw_fence.base);
>> + kfree(job);
>>   }
>>
>>   struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> index 931fed8892cc1..077b2414a24b7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> @@ -48,7 +48,8 @@ struct amdgpu_job {
>>    struct drm_sched_job    base;
>>    struct amdgpu_vm *vm;
>>    struct amdgpu_sync explicit_sync;
>> - struct amdgpu_fence hw_fence;
>> + struct amdgpu_fence *hw_fence;
>> + struct amdgpu_fence *hw_vm_fence;
>>    struct dma_fence *gang_submit;
>>    uint32_t preamble_status;
>>    uint32_t                preemption_status;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index 7670f5d82b9e4..901f8bd375212 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -152,11 +152,10 @@ struct amdgpu_fence {
>>
>>   extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>>
>> -void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>>   void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>>   void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
>>   void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
>> -void amdgpu_fence_save_wptr(struct dma_fence *fence);
>> +void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
>>
>>   int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>>   int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>> @@ -166,8 +165,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>>   void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>>   int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>>   void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
>> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>> -      struct amdgpu_fence *af, unsigned int flags);
>> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
>> +      unsigned int flags);
>>   int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
>>         uint32_t timeout);
>>   bool amdgpu_fence_process(struct amdgpu_ring *ring);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index bf42246a3db2f..7d1a363ad6878 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -772,7 +772,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>    bool cleaner_shader_needed = false;
>>    bool pasid_mapping_needed = false;
>>    struct dma_fence *fence = NULL;
>> - struct amdgpu_fence *af;
>>    unsigned int patch;
>>    int r;
>>
>> @@ -835,13 +834,11 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>    }
>>
>>    if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
>> - r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>> + r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
>>    if (r)
>>    return r;
>> - /* this is part of the job's context */
>> - af = container_of(fence, struct amdgpu_fence, base);
>> - af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
>>    }
>> + fence = &job->hw_vm_fence->base;
>>
>>    if (vm_flush_needed) {
>>    mutex_lock(&id_mgr->lock);
