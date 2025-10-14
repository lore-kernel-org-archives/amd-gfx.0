Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC491CCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 11:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 750FE10E5BE;
	Tue, 14 Oct 2025 11:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mZ7VWrPM";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F04310E5AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 11:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjBLFe9X4GLBcif5ySrnfOY6o9bC1VOII/jqZrXlODGDCSxEZwruUOtbCcjP0wv/C+CsPe0LwyqQVZ4uuMOsB8BybD7pAOwJPPXgYVun6eL+T9ZllAEBYR2leEjE5mn15I42zQdyLzMPaAchMfAzRBLcHLGjqIkVElhSPZlCM0fhjTxkpvwtdgZMSQZ+ErVMmvWBjiXLMx975Upnb5fIGA5A4+Jl9TyUALQ/BeWB7c8O+1edHCULUctIkHkALTcZGzpQQKJra9ozZM3Pn0cimEYyF3TAxyhILk136P4iVllEtnHJ25hEsPUB0l4okViUbKkuAOMtdjaQLXe/a6RGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuEgHkneBRXSN+HfBnVI7Zj2Gnr03IG1o8FDcSAjOzk=;
 b=RIUfLua40KPCbCtN5B41h5oHqCwN+GWM3nJb5HKlIsqdyKVVdBk0MztHAUA7sPBK/8J9CMr3UeGaMJRxqXrKdZhwBcCyJqJlDm7jN3ImdJPElHrpASeoiHioSBxxt5R7uhH+jeHiz6p0G75bSF72EIWXvYq0jgQawZ8KF6+A4UkQ99WMmyP+xb1ROqmk45gdAe0J3CHTklPITHxxymQrvIDbNanIifROhhPPCFf3A6MxOQ+FcBDW5zcvTIDkVT7gNSOlCEpd28XOf8HtyWOOiyViHcBWQeJuptdSSTpt6soy6rSr0LkcyXJe5gTGEXwO0YLuUVVpFY/rsFjnS09/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuEgHkneBRXSN+HfBnVI7Zj2Gnr03IG1o8FDcSAjOzk=;
 b=mZ7VWrPMUGlh4/UA8c0j3Ke4JmZ9TuYqaW+zZbJPgLeDD8izcoPa/jR9dCGJgrtBaivHLY4XDrg9XAR2gTxrfCsCZgJuFoGzWbJ48SjJqZyWlwTfPCRvY5ew2mFHlGg9lNIyeSxlxAYa4Fe/lH10ZBFycEmBFcJiugbiAtdH+1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH7PR12MB6394.namprd12.prod.outlook.com (2603:10b6:510:1fe::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 11:51:29 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 11:51:28 +0000
Message-ID: <5a17623f-2c56-468a-9de1-c1af4522906f@amd.com>
Date: Tue, 14 Oct 2025 17:21:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdgpu: add the kernel docs for alloc/free/valid
 range
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20251014074337.421304-1-sunil.khatri@amd.com>
 <f19b26b3-b419-469d-9c54-c7e9ff5fc424@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <f19b26b3-b419-469d-9c54-c7e9ff5fc424@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH7PR12MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b3a025-7a0c-467e-b961-08de0b1802b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnAzaWM3UWx2RGp1VmlmeW0vM3M3aDlaaktxbmd3di8rKy8vOGd4MXZPRGFW?=
 =?utf-8?B?bzFWUTVBWFhLd1p3dzBHQUc3NFptMmpuNzFMUmNYTmdzZzN5aEVtSFZTV3BG?=
 =?utf-8?B?MW9mS0R6RldMYnZUUVpSVHd0MEJ0SGl6N3NmVHRRTHZBWFlUZWcrTVE3OWxo?=
 =?utf-8?B?SWNnS2M3cmRTZ3E5Ymk5a3JiOHQ1SUhvOGlQMWxOMngvdkVBT3JxWDJoZmlp?=
 =?utf-8?B?UmY4akVkZnZZcndkd0k4TFJpbFFVZk4zbUFOU3ZSYTQ1cFFSVFBML1dlUDJh?=
 =?utf-8?B?SkR3UzRuRVVHNnFLV3Fkc2NiYTdMVTJqWWJaTXUyWmdyeDQ0alBlZmpIamNE?=
 =?utf-8?B?TmJSNnZsZmRhaThibnZhd29VVElyY3Z0VkhrSkF3SmVRUmlpeDZUOWVWcFFM?=
 =?utf-8?B?UUluOVQ2OTc2WFhTWDNoNE10M1hCU1l4dFpqeHNxNnRZSFN1dWFkUEg1WUdl?=
 =?utf-8?B?cmhBMjV2bmhidTNCdjE1L2FDbVc1cVFPUG1pcHhSMkN1cXhZdXpNdEs5V1Y0?=
 =?utf-8?B?dHZtZWtBZW1VK2pDNHhZMUdKM3ZJMWRsZ1Z5eUx4UWJtZDc3bkt4TlZ2QTVD?=
 =?utf-8?B?elpuaGpmc3c1d2VveGNSRXRsTE1GS0VlRGw0ZDk4MklKeVRidkFqV2tkcmZz?=
 =?utf-8?B?MHA3VDVUSlgrQWRjRmdudGdEc0dsVkxWWWF0VEdoa2Q1ZURLWEM1Ym5xY21U?=
 =?utf-8?B?WldHMWdYbTJLYWIyb0VsTUtpckFvU1hhdEdlekJxZVBqWlBSNmdjVWE1YUFk?=
 =?utf-8?B?Mi8rWlhSZlJRMnlFdk5GV2ZZSW9FcUFIZDcrY1RRNU5uN2oreXhEaUxzcHdD?=
 =?utf-8?B?UkovaGNhUWhCTFk3aXVQNTc0SW05WDZ2VlFnT3FFRFU5eEdvVEVCU0NxMG9p?=
 =?utf-8?B?THFNV3lBV285a1g5bk9adFFFTzV4U1NtcU9ydFNzdHloRUgvZW1uQ2hMUHpa?=
 =?utf-8?B?amFBOWhIT0Y2L1I4SzlydXc5TUFvY1dKNyt2Vm5MdFhZZExUNWZDUSttcVpk?=
 =?utf-8?B?QS9Ja3NBZUN1OFBjMzNRWHNicUExWWtYWkRucjFTQXZ2eEUrWlFTaEZzL0M5?=
 =?utf-8?B?SXRUQm1sN0wrRWsvODBNY1pKWDYxR1VKODY5VGVORnMveEd0NW9EWU5ibXhm?=
 =?utf-8?B?Y1BqNzBtZVZsTzVzSGRSdlIwRjRWMG5jSjJMYzNka3dBMlRNdVUvbW8xSGhh?=
 =?utf-8?B?VDBMUzRodlhiTS9JZk1Felp0bFJ1UWU1YUtJNW1RdFFkcVpsV205aGVFWXZS?=
 =?utf-8?B?K2hNMFdzM0FoNHF4cU1vbnhJbW1ZTzA2WUNqeFRrWENybVVZUkNaNnhHK2hs?=
 =?utf-8?B?eGdwYVcvaENWTlVFeWd5eTdMZTVTakswMVRZNFNsT016YzdkR2F4QXc3U3VC?=
 =?utf-8?B?NUpZVUFqV25TcGhiUGhoR0Y5T0ZHZDhxTnlRM043TTJFc1JxUnpSemkzbFFF?=
 =?utf-8?B?MldYYjhrYTcra1lOcnU2ZnN0VFZqMU9YM2wyNGJjZERHUklYSis2SWpRWHN0?=
 =?utf-8?B?WHdrZ0ZPVXUrSWJFOU9MRXZ4NGVBOFFZZjVDd0tveU1tNFMxd1FsbDBJQ1gz?=
 =?utf-8?B?c1ZVMWdsZ0wrditDUFZiMDUvTFpFMThsZEpwRUMwbUNIQU5sU29zZjBKeEs4?=
 =?utf-8?B?Rmxra2VTemdWWTJkbUJxL3o1VUYxTHJtTnRrb2Y2TFdUSFBtVktVeXFyVHRp?=
 =?utf-8?B?b0ZNcVVWRjNZZVdnbHl2Z2luSEZoUWZ2azE2Yk1lR2JuN3JlQ0xKMEp3VHM3?=
 =?utf-8?B?RGNpM1J1NU92ekI5M09EYmJOL2xYWWs4MnZDM0czaC84d1FZWTNwS3RkM0Mz?=
 =?utf-8?B?WDQzUFpIZUp3ZnBvT2NmR2FXSWRTanBGT3pKS2owaW05cHFyTm42c2JqRDFz?=
 =?utf-8?B?bkJBVTQxUTdnRTAyT2V2R2xwVzZsZVZwRG1sTXBkaEVOaG1GYlVSRDFGeHJq?=
 =?utf-8?Q?CqtYZv+USQpqtNN8bIQJuDdbgvtRpLUw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEFNNW1OME4wQ2lLWjhCMVU5RDh5MGpSZllFYjZkRjVNbTFhd3NDUnRWaXpY?=
 =?utf-8?B?dWtqV1o3MktXUnlhdXRSelNtMUFnQkZqRkpkMEdDZFdkdStCR21vQ0pkZHNp?=
 =?utf-8?B?R2JEVFArck5FNnNWM1VhQzRNNFJ2ZVNMRzhpTHlmeVZNQURGdkNjWlVZZWcz?=
 =?utf-8?B?Q21RMVozWGJGbk5uNTM4bXNlL2ZCV0hkRDBzR0hlZmx1ZzJqMEF0enh6NFVy?=
 =?utf-8?B?ZzJUWU9qVHlZeWtKTDJRS3l6TjhPZDBVc3V4YUJVcnhrRkRmQXA5ampMRXli?=
 =?utf-8?B?N2doNFp4L0ZqWTZSUTVkVjdhU004Zk9QN1o2RDR6NXFQdmR0NEhrY0xTK0NU?=
 =?utf-8?B?NUJmNENtRXV2bmNjY09XT1dhSlhUbFc3SmlJTWpJRmZKbXcyc2duSzU5MVhD?=
 =?utf-8?B?QlZqWmJXdkh2b2h5c2RxVGZGV2tLNU12cWk2RWNBK2lzMDJMUU5rZ1NNcG1M?=
 =?utf-8?B?SXlQSUVDSHVDa3QzVlBvajFNYm5xS1NWVkJ1WGNSeFlLeWFHdGUyZ1hYajRN?=
 =?utf-8?B?U1l0NUd3VmNoZkZ3L3hEVWVVeW4rV1RLdDRWZUNTRlhIRWZ5aFFwamhPakZQ?=
 =?utf-8?B?a3E4YkRXWkJWMTBFS0MzTWZJMFNkc1FtclZZdVppWHl4bFB3amZVUVI5d0ht?=
 =?utf-8?B?RDh3TDNtNENIVEd2L2VudHpxY25Ubm5aeHFZMTVTR2tiSk9veFM5NDBBTzFN?=
 =?utf-8?B?RDdsbVlhbWdzb05raHJBbjNWbzVMMXoxTkRkdGMzYzBPWlJiUWZaVzhMVVBv?=
 =?utf-8?B?WjQvZzdxTlBzYzZjalZuVzNUem9BSTd2ZVV3NUM4VTNhTWtwbERUQjZFT2Np?=
 =?utf-8?B?R25pNE5SbmRUc1NXN3lNYSttR1RZazBZVU83Z0ZzM0t3MTdFL2hEUHE1WE5r?=
 =?utf-8?B?S0Q5R25CVU9mblgrQlk4V0ovT2ZjSHFDckNoUVlhaEJIZFM4bHhCY1dUNmFr?=
 =?utf-8?B?Z1ZpNTdXTGU4bm5ZK3VKK0c4bGNCRXNsamo3bFZaMkNOSUJpZ0VxMGxubnln?=
 =?utf-8?B?K3RXVEYvd2xmRHlORGxXMml4aWNabnRlT0RoZkFqbjltVXpEUzRUYXowYVlO?=
 =?utf-8?B?emVtS2dqdDhYczNuTjEvcFlKN3BGUFI0N0svTTNvUG83bnJBcXliZG1qbllo?=
 =?utf-8?B?VXViYllXTmtNQjFnWGZUVTU2RVFtaHpaUlA1M1gyUUtZd2FnWW9tTWZXZmox?=
 =?utf-8?B?cXFVNkY3bVdEdkwxUTZBN2U2SnNJMkhwQm9uYmM2NE1QakVBeG9GTkU4NTc5?=
 =?utf-8?B?OEtuQUVXZ3djTnpnOGRkSzh4d09qRVdqMTl6K05RTmVmS1pTZEt3L0Zlc1Iy?=
 =?utf-8?B?MmFlbnA1bGZoOFFEM3A3WHVCZHRQVjNvWUpVVFZTVTk3akdUYko3L1lGRnFw?=
 =?utf-8?B?ZkFuZ3hMVWh4RWRNcHpnbS84ckJGeU1xWVNvcXlCYyttUlNTZloxSVl2alpo?=
 =?utf-8?B?eTFFbXdlN0toR0ZleUpFQTgyaVAvN1FxOEhiVWJTZ090ZVM3MFhTWnVuaHI0?=
 =?utf-8?B?TVlWU2ZaKy9YOEpDdHJ5cktRTVdKUnNHZGFIMm5RbDJWR2dTbnRXT3JIdkU5?=
 =?utf-8?B?OUNMc25EbjRyVGluRnNDQ0hMaENKMlA3L01iMnNXa1AvbFdzZ2lzWnNnbmFv?=
 =?utf-8?B?UEZYYjd3czhIZnhEZklLdVVBOTVvbkpVaW9yYnZobzB1QkV6RHdGOVdkZmZM?=
 =?utf-8?B?bEZvM3ZGdE54TnFpNGNJK0t4aTlCVFp2TVE2NjkvMmRCWHJka054R1luN0ZS?=
 =?utf-8?B?WjBZTVlITVZVTWtTK0p6eU8wck5EWE8vcEZ6blp1Z3RDMG9sVTJET2JIOTNV?=
 =?utf-8?B?aWRUUnlrcEJ1amZFSG9vYStSZVBZanNuanNSVXdqWEVkT25kR0RCczJHdUhu?=
 =?utf-8?B?Z1UxOU5lSEpQRnZlUjRJYWVUcHNXQXhydUdaYThWcVN6YnpZZ3RqUnYxeE9k?=
 =?utf-8?B?OHhOeFgvbmFJa2JwVXBCM0t5WFdhSnA0Rk9lOTIzZFVOanJVQ1RhZlFLOFFr?=
 =?utf-8?B?bS9TQ1Z4NmI2d0NlRDR6Sy8vYlZvUVByL3JYMEdNUEtYVy9WRWg5Uml5TEI0?=
 =?utf-8?B?ZlRhVWFyVkhvMW1ySXlSRktURGRlczdOcGdnQmZZcVVPT2dGcUFwQVBrNm94?=
 =?utf-8?Q?nfAxWsNlt8YEeKghpygFsh+31?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b3a025-7a0c-467e-b961-08de0b1802b4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 11:51:28.8259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mvADaKoJ1d0JTIE7CdlJOJSayBVSSS/wAhwxdBrg0gHGRv6Jqmrgp83I+Gddlzdy/g8T0ItGTuKltVfMP3Kjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6394
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


On 10/14/2025 5:16 PM, Christian König wrote:
> On 14.10.25 09:43, Sunil Khatri wrote:
>> add kernel docs for the functions related to hmm_range.
>>
>> functions:
>> amdgpu_hmm_range_valid
>> amdgpu_hmm_range_alloc
>> amdgpu_hmm_range_free
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 35 +++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> index 04f02e0c8bb3..419f0dbb38ea 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> @@ -227,6 +227,19 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>   	return r;
>>   }
>>   
>> +/**
>> + * amdgpu_hmm_range_valid - check if an HMM range is still valid
>> + * @range: pointer to the &struct amdgpu_hmm_range to validate
>> + *
>> + * Determines whether the given HMM range @range is still valid by
>> + * checking for invalidations via the MMU notifier sequence. This is
>> + * typically used to verify that the range has not been invalidated
>> + * by concurrent address space updates before it is accessed.
>> + *
>> + * Return:
>> + * * true if @range is valid and can be used safely
>> + * * false if @range is NULL or has been invalidated
>> + */
>>   bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range)
>>   {
>>   	if (!range)
>> @@ -236,6 +249,19 @@ bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range)
>>   					range->hmm_range.notifier_seq);
>>   }
>>   
>> +/**
>> + * amdgpu_hmm_range_alloc - allocate and initialize an AMDGPU HMM range
>> + * @bo: buffer object to associate with this HMM range
> "optional buffer object to ass.."
Sure
>
>> + *
>> + * Allocates memory for amdgpu_hmm_range and associates it with the @bo passed.
>> + * The reference count of the @bo is incremented.
>> + * In case the @bo is passed as NULL, caller is responsible of taking care of
>> + * the reference of associated bo.
> I would drop that sentence, when NULL is passed in there is most likely no BO to reference.
>
> Thanks,
> Christian.

Sure will make that change and send V2

regards
Sunil khatri

>
>> + *
>> + * Return:
>> + * Pointer to a newly allocated struct amdgpu_hmm_range on success,
>> + * or NULL if memory allocation fails.
>> + */
>>   struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo)
>>   {
>>   	struct amdgpu_hmm_range *range;
>> @@ -248,6 +274,15 @@ struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo)
>>   	return range;
>>   }
>>   
>> +/**
>> + * amdgpu_hmm_range_free - release an AMDGPU HMM range
>> + * @range: pointer to the range object to free
>> + *
>> + * Releases all resources held by @range, including the associated
>> + * hmm_pfns and the dropping reference of associated bo.
>> + *
>> + * Return: void
>> + */
>>   void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range)
>>   {
>>   	if (!range)
