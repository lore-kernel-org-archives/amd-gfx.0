Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93189D37487
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 12:44:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4971F10E328;
	Thu, 17 Oct 2024 12:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UOYiq01a";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14EFB10E328
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 12:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmyLex9uceVHFZZm6BPEbczHqSthwEMINvjQyJz5mX5Al08QFxP6niFtGlTI8T965vDInU+NhipmQYr2yklgTdEZ4nq2k7uhPxQ9AwXsC2XZKiZ1Z4OqLrHFZk4IFc42T4q9hGRoUvxYZbH0olTpziJUcQnLOiZsAW4n7I5s0HkZG38U2EQhfLhrWjo/W1lg/itipmV9VqBoZmoOLQEMo9vaM293PDsUu7JgHYFJpbJFchKBXZ+FDQPooCEPBGzEnZI4spmOiv8CUkdvn55dHtrfyH2C5THYio4KisK+oLS5ahXzbGHcdIpSBWKcIclejOtBRgoocgfTnsuLp0+1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jg0bfo64v3Qs6peNWqDOfW0NOAB4KQUcNmV0FXzVdfQ=;
 b=M7hPFbxeWsDGcjoTvlGs+FRkINaIUqNxkSWir0TQK87s3JA5ZQKf3Ex0VtdsR2jnafUgWjeIu7Sqv4JWzbvTbAeOSECTpkiXEtlDdRprrXPXkppTD0LPGXKx1WZUsHIUhCjNo9zycDD3xL/607YF/F6WdsD+ugWx8NPj0U0wvKBitOC3GyI7z+ojwhtwEjnGjG5cOKp81JWFnUObMJS3J6bXPbk+esupSuJvOjYDrigexAVlaZvnk6wl73quJId+qcxpr+SyW+qVcZdCZ6B1CVrviv62ut8hVcAdluf/YzHwkvyBd8zcq71SBeaOCYQZ/gJAFCvst8Ag5jUka7WECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jg0bfo64v3Qs6peNWqDOfW0NOAB4KQUcNmV0FXzVdfQ=;
 b=UOYiq01arDPODpK8eOlAkWn2S3xKZaS9Qx7xKE+JbxbZkrkHD/kp4YRu57XwbiX5DrmVceY2UsBt41hoYBPStXuJ6k7KI2SmEDEu9aCN9R7QSxpNewUoLioNg8LVOyFulhhnHGQpjREtR+99/dVpxMRClD7YYy06ZGG4XHP7Bko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 12:44:51 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 12:44:51 +0000
Subject: Re: [PATCH v4 05/15] drm/amdgpu: validate hw_fini before function call
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241017100615.1492144-1-sunil.khatri@amd.com>
 <20241017100615.1492144-6-sunil.khatri@amd.com>
 <b44b172b-675c-465a-8329-1d93f2abc04e@gmail.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <4e36b3b1-fc42-e8f2-d7d2-845c4e4cca13@amd.com>
Date: Thu, 17 Oct 2024 18:14:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <b44b172b-675c-465a-8329-1d93f2abc04e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN0PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::10) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: aa59b77c-934d-4e72-3ae9-08dceea97ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVBjWE9IZkpFNjZqaXIvN0NORjYwSlVvN2l4VmF0SGc3aHQ1cjBQOGZ2bXhY?=
 =?utf-8?B?ZEdSaGI2dXVZYTJFeXhaVTduQjVaMjRIdmhlSE9PWlhhV3hlbEdLR25temRo?=
 =?utf-8?B?eGZ2ZUVSYjdmVXdyOTlqc1JOYXlkYUhnVlNhY1dWbUlweW0rVGdqV0JvSmdi?=
 =?utf-8?B?ckhOWmZISkJZNTdEbW96NGtnb1E1cUlUcURObU1IV1pVQTkrdEFBRG1mY1kz?=
 =?utf-8?B?cHl3WDh5V1FCcFlmWEtsa0d1SllTTUNOV2twSVgwWk9zcWRjdmxaZmY3eHhv?=
 =?utf-8?B?dUFXNWtwZXJaaWJPRDdBdTNZTDVxS3FOVjhDNUlnaWxmVDREOHN0YjZFVUsy?=
 =?utf-8?B?Y3Q4bUZrSUJrSGhCSWdHb2FLeHJqSVFYR25KNEszNUpVYmF3dGZ2ajJDb1Vr?=
 =?utf-8?B?dURBbjk4b2t2aGM2OHlpR1JnM0IzSEpnVGoxc3VsaDYvY2t2bmgxQWhkaTA2?=
 =?utf-8?B?VWpCTEpPN3U5dWpOQTVEcThmSDlOWldhZnV1NUlOTlFHaUd6R1A0Z2pzT3Rs?=
 =?utf-8?B?Qk5mQ1ROaTZqcEZ6d1pSWmwvS2gzbTBEWVViYXVENEVGMmRuM3pNM3RUSVY4?=
 =?utf-8?B?ck5hVXdYK3pyOG5KWS8xWkFrSWpJWjlyWW9STDFpUE9BNTJUWEpVMVhkTUhZ?=
 =?utf-8?B?dzZEcUtyakl3ZXhlQUU4bGt2ak1rYmJNK29JODFTUzI3MzduOUpyWTU5WVVL?=
 =?utf-8?B?QVVMME5KS1ZzODNHYVIzU1NZdko0cWFMS3BKWEkrNVNEeWsvVWVDa1JML3dB?=
 =?utf-8?B?aTRZekppb0dXY2pSTkdxMm9rdFNiWE0xazNYMisrVTZMRFN4TmpKcGR6VUhK?=
 =?utf-8?B?cU9WTWgwaG53aFYyUzlteGtMOElRWURLeUR4L1NSVjh3N1ZTQllqcVJKOUZy?=
 =?utf-8?B?M3k2eWFLWjVEbVUzSldtTWJMb1VqTEpuS1oxKzNlSHZxQWVOOVhDYzdvSERT?=
 =?utf-8?B?U0FFcDk4MXBWZDlHUGVPcTNtZkZUWmdWd3E3RUFjZE8weTVGd1JEVlc4amlp?=
 =?utf-8?B?ZG1qRGdKZ1grRWtvTXU2bzJSNkVBWXllRHRUNlNBbERwSENTQmU3MWJBVzhm?=
 =?utf-8?B?MjNDTnBJMWx5WWdDY29xZXFENE5VNTEwVndJTXV5QWpFV2VUUXZhcHEveWwz?=
 =?utf-8?B?eWV0UzRDWi9sK3R2U3BmcFBsN2FyQThac0EwczRRYW54TzBkS1hoZG1SOTB5?=
 =?utf-8?B?czF4TzN6YnBQckJHRmFRQUlhZU52dm5WUFhodmtaRkNRQUlucjZFNEdDaWs3?=
 =?utf-8?B?OTBJUVVoSjkrWitYc0ZMNXllVzdlWlJoWVJDVVNITjFpc01FN2VveFdlWlZo?=
 =?utf-8?B?dzA5YW5VcTI4M1hKNllZOUQ0NVV1Tml2UzZlYlVXSldVZFMvK1dyNXc3ZXVN?=
 =?utf-8?B?dnJmUGVlSUN3Z2RDb2RFaE1KNmJnSGp4Z1J5UytkU1ZGUDVsM3MwemFhbmd5?=
 =?utf-8?B?SFFpMWUwK2JzQU5oTnphdEx3dG9neGY3My9TR0pvL3FQWDZqWlF2dkorVDI1?=
 =?utf-8?B?MythZkxKT1RzUVZtTjROQUV0WU4xVHlmZmdPcjhlYUtyWkVma2VldXBlSUJo?=
 =?utf-8?B?TUhESVFDbS9iaVM4TlVzcXJSaFhCUG1VWU9IRjhXNmlwckNjZzBzVjNxQ043?=
 =?utf-8?B?djB5ejNacmNzSjlqQjB1bE9yWE05dTBnQUZFdEc3NkZsMUhlY01aZmhnR0Nz?=
 =?utf-8?B?WkhJWkhPSUx0WnNsT2tyRHlSTUxpdE1iL1VjNnNzVUw1K0FMK09kK1p3TjZ1?=
 =?utf-8?Q?X7fjCqI/VJT3XFYOMzG9tY+xxfKAfwACdUxxXlz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFFicVBIN0FaS2tDSlZ4WkxTcVpxWjNBU1QyanQ3Z3ZuNEZ2SEdLRk1qN2hX?=
 =?utf-8?B?THFLaG5oMXEyYVBEbHo1U2toUkJsQ05ROStONEYzeGMvVEVnOWp3MFRWVllo?=
 =?utf-8?B?SzJabnZwQ1N4TjVQZGc4enUycFhsb2wwR21pNWRwMldhWVcvVVZDQjE2VXlT?=
 =?utf-8?B?Tkw0cTcyVG8vNDhTV1BkbmpaWllCSnZBTlJwYjdwL0w0N0dQMCt3TDJpaDhw?=
 =?utf-8?B?YzQ0aUpiQi9VTU1oSzN1WlNIZ0hLTFZWaWdaNU5Ddld4Ky9yVEJXRHdZSUlQ?=
 =?utf-8?B?RHhSNmhaV2N4VitucGl5ZnBmWUtZd2dsRjhEMlYzditNdDMxQy9tQTdTb3Jj?=
 =?utf-8?B?V3IxTE1PaVViSGUvZThrRXNtNXMwOTZzbjlObWNIT3pxUC9raUdjSmZTZFZW?=
 =?utf-8?B?dUkwQWRRQ2tHUHI3KzhBMEt2d1lFcEtaRWxyU05OYmVVbkRVYWI5aENiVlNN?=
 =?utf-8?B?dFpCQVlCa3VGUFQ5aFoxbTdSMkhkTS9lR3lSQ2RUbXRES2U2Q2NkaVR4cXlQ?=
 =?utf-8?B?aEVSU2hRbWl0S0ZlZyszTU9PMnIrQWJHbHArZVRZMEw5Nm5ZcHQ0L1dvaXlp?=
 =?utf-8?B?Vm1qYUJ2dTV4REZ5OHNnUzhUbjkvZjd6cVExTG92bTNLUDBmVjdDWXhzZ0tP?=
 =?utf-8?B?OGptZW5ja2NaOWlOUWdsTkY4dVdQSDlkdnJHNkFWa2l4alBPZ3RPQ1ZvSFJO?=
 =?utf-8?B?OGJ0MFpZSTNuRXRkVDVwQVJrNmNUUk1QbTNodG0rb1pZSkcxaU5jOXFNcGQ4?=
 =?utf-8?B?SFY4cU9rK2JCeUZ1blFWSitEOSs4VnI5MS82N09XVkpjOGJ3dW1OY1lyTU4v?=
 =?utf-8?B?WkZueDVSTmdGVkNveXJVQmwwRkJUSDdpaURNeExjaDFvZTNFVmtYVXkvb0xD?=
 =?utf-8?B?TkdwbU44cjl1QlgwNHoweVk2MndkUDV4cm9VNG52Lzl3aVV2L2M1aDF3UzFN?=
 =?utf-8?B?MzI1eUxWa05IYkwrdlNWTjc2QmNuMkV6aUNNcnVoRDJuaTJhekZKMDFaOXhr?=
 =?utf-8?B?VVRYSTBVU295RHdYcldGYmdKNStHV2xkNzV1T0cxRnpDYVpqWmE2TUNTZnBW?=
 =?utf-8?B?TE9OUUowandCTmxqNWdKTTVCdzZ6KzJiMGlPdXpIaW9sSUNpODNOL2tYc2lB?=
 =?utf-8?B?S1lLZnJ0SXVrYlJCSFJVZUxYWW1yVXp5RkRaNkhiZXBqUHg0ejdlbnpMMCtp?=
 =?utf-8?B?REdtcmxBNFdWbytlWVRyZDJjZWtUbElDRFRhbGpZNFdsQ1kvVExXWDQ0Smxr?=
 =?utf-8?B?b0dvcmh4cGFIRHJEcHVzaUtVbHhZbmQ3Z0VjQXJEekxSWCt3UjJZbGVVK0Mz?=
 =?utf-8?B?M0dkWHlkRXhmS21Gd3dWTXVPakxzQnhZd0NJVllxZGNBTXFQMWNWVURMVDh2?=
 =?utf-8?B?K3YvKzVuWC9nTU1WZXgyUTZLd3BaOEFnSENaa0xKM1hpL2luRXlFSXN1Ym9t?=
 =?utf-8?B?bmZHL2p1SjVOcjlObm41ZVFnNmd2RTc2cU80K3pjSVJlM0Q3Um10RFljL1Y5?=
 =?utf-8?B?bHR0NkptWWVtSzBDK0FFMHMvRUpMUmhrajYvbmIrUmNDY3RtKzVaWEt2QU9w?=
 =?utf-8?B?Qlp1NDBnMDlWd0I4RkxmKzBid1ZCTWNkcmVOblJZNE1MOVgyT0toRGFjVXhl?=
 =?utf-8?B?cWc3K05leXJ2TzliN2lJOThiUFY4RDZTejRMeXBKREk0YW9WaWZsWEhuWEFz?=
 =?utf-8?B?MHk2blh1NjczUitFeGdUVzdtS0x1MDlacGhjZmtLL2hyaHVRVlI0YXUzakUy?=
 =?utf-8?B?M21LNDVhdk5mWHJxcmRDdmxQRGJHNi9xRjZFOURheUNUS2I2NG9Oc05TV0NO?=
 =?utf-8?B?VzBDdzc1dHBLR2R1NnVhWkFBTUhwWVFJVDh0QXVMVnlpeHdDRVNtRFBFeFdV?=
 =?utf-8?B?Mlp2M3VoNUlsSFh3N09sRll3T1JldDJvaldOek9sSFp3NUErbnZqVnhFdkFD?=
 =?utf-8?B?eFlBZmFwdjN5NzhQTm5sVWp0SWcxbFgyNU9NQnBkVlV1b3BHV3NWbDNYM0tB?=
 =?utf-8?B?MTdYdFF0bUFLSXZCSHhWL1hIQnF0TWhaZHl0eFdOVDkvNzVhVjNIbDkrNUdZ?=
 =?utf-8?B?RnhwbGp6aGVMNjViWWJaRVQ3UnRaa2VaUW1tVlNxNFZrM0drQkxwQ0ZCR1JZ?=
 =?utf-8?Q?1l4QPBAbn2IJ2+oDQRiMOzqYV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa59b77c-934d-4e72-3ae9-08dceea97ddd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 12:44:51.1154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ee5eNmKER2o5wsWBsF+Xs1yYXlROxed/koy8QP8t/ycLJZ2RI/h9ybMPnSpZ3yqYIvYkJLVbjXKknU5/cCcFDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
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


On 10/17/2024 5:22 PM, Christian König wrote:
> Am 17.10.24 um 12:06 schrieb Sunil Khatri:
>> Before making a function call to hw_fini, validate
>> the function pointer like we do in sw_init.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 33 ++++++++++++++--------
>>   1 file changed, 22 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index cf84b50f2355..96cecd4a636b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3287,11 +3287,17 @@ static void 
>> amdgpu_device_smu_fini_early(struct amdgpu_device *adev)
>>           if (!adev->ip_blocks[i].status.hw)
>>               continue;
>>           if (adev->ip_blocks[i].version->type == 
>> AMD_IP_BLOCK_TYPE_SMC) {
>> -            r = 
>> adev->ip_blocks[i].version->funcs->hw_fini(&adev->ip_blocks[i]);
>> -            /* XXX handle errors */
>> -            if (r) {
>> -                DRM_DEBUG("hw_fini of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> +            if (!adev->ip_blocks[i].version->funcs->hw_fini) {
>> +                DRM_ERROR("hw_fini of IP block <%s> not defined\n",
>> + adev->ip_blocks[i].version->funcs->name);
>> +            } else {
>> +                r = adev->ip_blocks[i].version->funcs->hw_fini(
>> +                    &adev->ip_blocks[i]);
>> +                /* XXX handle errors */
>> +                if (r) {
>> +                    DRM_DEBUG("hw_fini of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +                }
>>               }
>>               adev->ip_blocks[i].status.hw = false;
>>               break;
>> @@ -3325,12 +3331,17 @@ static int amdgpu_device_ip_fini_early(struct 
>> amdgpu_device *adev)
>>       for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>>           if (!adev->ip_blocks[i].status.hw)
>>               continue;
>> -
>> -        r = 
>> adev->ip_blocks[i].version->funcs->hw_fini(&adev->ip_blocks[i]);
>> -        /* XXX handle errors */
>> -        if (r) {
>> -            DRM_DEBUG("hw_fini of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> +        if (!adev->ip_blocks[i].version->funcs->hw_fini) {
>> +            DRM_ERROR("hw_fini of IP block <%s> not defined\n",
>> + adev->ip_blocks[i].version->funcs->name);
>> +        } else {
>> +            r = adev->ip_blocks[i].version->funcs->hw_fini(
>> +                &adev->ip_blocks[i]);
>> +            /* XXX handle errors */
>> +            if (r) {
>> +                DRM_DEBUG("hw_fini of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +            }
>
> I strongly suggest to make this a separate function, e.g. something 
> like amdgpu_ip_block_hw_fini() and then call it twice.

Sure. Noted.

>
> Regards,
> Christian.
>
>>           }
>>             adev->ip_blocks[i].status.hw = false;
>
