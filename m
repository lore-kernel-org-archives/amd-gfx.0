Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4022C54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 14:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B2F710EEFB;
	Wed, 20 Mar 2024 14:58:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K/mI1DUj";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D43EC10EEFB
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 14:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyrTJbPBqKXwH4t+Ldrh4+PE1MzYXt2Ax5KWH3cTn9vGMTnu1zKqVo7a+8NFROQ6R302bWR29HTrDJ3tVAqDVW9WGcZtEjTjWeGJo/4rJMUlruXHlPAZ/AForPSHK/CXLZyZIPVSUnog9j3aCX3ZYSHvwPd3dhoGmF1fwC5XYdLVyAhNey/Y+aX3vT0izbcHb0RFkbKR8FmYLZRC3c4ezCOPSDACamxXI7Gut9ZbvHoQHsqrwAapFDhjBLP8xZzhA/aHrrUvZJ7mumcOjY6AcVTx/eiduzRhGlUwHQbuRXJW8JaUdkSHp7R0aRMJCRpD4A0U/pqkprF9rNLSA5bICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVaQ69ixZAJwFNQLaZGcf2CYAdX3eTC5f9kifhQfScE=;
 b=AAlsZs0ngxYZNAceGuKa7+EuirSQGb0do8p//SC6jJCMwj6elmdj1kng92SbahGheEgn614JKMev6qvS7TrZTps+FbNkeRUG5yMq3grmJFgFtOqGPCOX5w8erf9n016c9N3Nrgb2wQF59Hx/gOGxfR4kk8jvx3nTgj3igdfkJFaKoiVU2oOFVhrZ8w4k3iM80wQu7CKvBWLYHoqamtF7oF3R3pnYfNkEB3bs4c7+PDT3ULRneh0ARBAs+FtapJlzE8Tk7NzTPVd76pgygQz8OonsAs1UM/HOBv9PEodTrmo0TMAnhp68y9AOF8CKU4B5rk2X8BVx6dMSKrENQ+DYeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVaQ69ixZAJwFNQLaZGcf2CYAdX3eTC5f9kifhQfScE=;
 b=K/mI1DUjGSwu/K/AVmMgv4Hsn4AKrDtIuxfevl/ts4mRx3ElX0Z0uB+sEgVD7KK1/shuo+qtqil23puKbYoFRLyYpel+CoFvaYMXvr270/9QN9rfc1QCubS8RLU6o6psbOqxpkXrvK6lYr0Wwrc7iNkYX7ToK1K3KKfxBJX5O88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 14:58:40 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::86b2:e267:3bf7:682e]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::86b2:e267:3bf7:682e%4]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 14:58:40 +0000
Message-ID: <db154f26-6af1-41b2-a3ec-a4fd2afe0d5b@amd.com>
Date: Wed, 20 Mar 2024 20:28:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix format character cut-off issues in
 amdgpu_vcn_early_init()
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240320084513.3026222-1-srinivasan.shanmugam@amd.com>
 <5d46d7bf-d487-4a60-9f73-7146947f989d@amd.com>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <5d46d7bf-d487-4a60-9f73-7146947f989d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0204.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::14) To MN2PR12MB4128.namprd12.prod.outlook.com
 (2603:10b6:208:1dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 88164adc-fae5-4b3f-71aa-08dc48ee3a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jP0qGScEktEsRo2/vceWiswQ77rbB0t0+Zmb5PA4KxtX7JRFT5MFw2dFTxXiG9pruHXy1rWMcs26XX0wqxdUp2di0ISZINntHVaHXRGFxBnIz62SWC22sQSiDPD1bufabi5Z/cBP0km1443XsjGLlyOZxuG0QHJXW/AuPNw1tbRuC1oqw+JtQWbvfV8dKj/rjgakN9dg2Wra2qggFBpMbq/LxLujRYMaVfC4QkNwYPu75GobIpICGNkhwsks/uVFswlPzRSuZtT5oVIa7c4vksU2D8ZcYCVf7uDYyINoi6nn/4Yv1J3MPYFQzTU6I1ad3h+xxNIYihydRWSoTy2YhMOTfsR0OwBLdB9GfU5uFrnjtUuGIbfjcefRChvEy+Tbt7UGBHR1TRD5vXz1YAOjMqc/uzTBfVcPEFy5jMvBRSeaox/9DiwVEqcffFmrPH5480hf4lUdoxCTwtdfqiA5i4rBX/UX2V/V21EPFmevlHb3pr9kDlhuuJ3oBYDIBxvuvcDjyOdfOY5T97jzDcqLlC3UWLeatDj6WOP4boSgVPxWXFrqb40HDUGA7k/Qzvuag6nEZ3rCkjpiOpLotyl+UaMpKxwtI51Jsx6Yg85snIOUIJQ3M6MQyVd6hrgTgR7DCCGWmdmdxxyCnVWnQMdCDrko6lR/7aLv4XxP3sdHlnY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHlJWFVINEludU15ajJ1Vy8rV2JwaGE2UlNFT3dPZXZXdjM4SHpodEVVV2tL?=
 =?utf-8?B?WjJ6YnJvZVU1RGJOSjlsZTRsTk92L2hKL3NTSkdhdlJKSEVSU0xUeXVvKzlE?=
 =?utf-8?B?MnQxRGE3N1lmc2x6cUMxbExSOFN0bVJTblhZM0FJbk5vQVE1bUlnL0VuS0VV?=
 =?utf-8?B?MVkveHpqN2VtTDZHUjcxRlhMOVZ1US84NWRMWVpybnMrbkREWXFidkM5TWcr?=
 =?utf-8?B?U0tqZ01Cblo1N1NwajF4eFl2cUFGM2Z1U2M2eW5NSWMvMkRQRjd4M0pYMFR5?=
 =?utf-8?B?cU9QSEdtMVgrYWF5SXZGVm9jT3hMYjhtYVI4Y3dLM0M2NENCV1d2OFRhTU9Q?=
 =?utf-8?B?L2xRVnMvZktiUjhhemVZS0dDMDNtMlpLRXNyRGsxTExHbDVSUHluUmpJSmpD?=
 =?utf-8?B?M0V2NkJvNm1KWDJKak40NnBpaW5ScE5HOCs5eHlkRXdETU4vcTBUdmp2SS93?=
 =?utf-8?B?YVRKOHVjd25PbHJ4V0EzWFF0WS9YakZlVjZTc0x2TGVDeUpWdW5CTmxXV3cz?=
 =?utf-8?B?Vy90TmkrN2FWMmdsUzY2WlJmUDFNY0JnT0FLY3RhVXlvSDdNVnR6MDQ3YXF5?=
 =?utf-8?B?clZ5TVdncjdKZEoxZUtmT3NqSTJicVZTTUVFVEp2Wm9UNmttY2xyOEROcHR3?=
 =?utf-8?B?MXNLZkNUV0srWGdSVGhzK29OM0VGTEtzS0kvbnJqUk9ZYjdaWjgvTHVTMlNn?=
 =?utf-8?B?QnA1NjR0V1Jwb1VGL011Y1ZtVk9jdVpiL01TNVRmTGtRMHc4dHprdmtBeDh0?=
 =?utf-8?B?S3c2UURiSUh3a2VyZ3RPZkhKWUxrYVMyOFFGZjdIWGJIZ2g4alg2cUphQUVm?=
 =?utf-8?B?ajJubkJaQURjamloOXF6S2p5Q1pSN1VGd1ZKT3prTXZuY0QxQ1F4ZzV3NG9o?=
 =?utf-8?B?VWR5eC8zcmJwNzg0bnVqSGN6NjBzRE80VmpKajU4aFhBRTR6Ry9raTlMU0xE?=
 =?utf-8?B?d1BLUmlNeEM1THplSGJ6dHFsSWdWVk14T01obHAxOEhmaHlCeW04WW14TC9r?=
 =?utf-8?B?T1M3K2UvRWcvdk1NM1diQW9OVGM5U3dQbkpXeDk1eXprOVpZRmFGaUpXWGhq?=
 =?utf-8?B?OWZuT1RwVTZ6YmJ4RVdTVG9GZ05DM3k4UCszWm9DRG05SzFRTmhhblNacEJ6?=
 =?utf-8?B?cTI3TzdCdlh0eGE2cGRMcWc3VjhJUkIvTkRxMjM3QlFxSEJvblNvS2FoQy9k?=
 =?utf-8?B?SjVtOXo1WGh2Tk15SFQwK3RQd3M5Y0RWMVhUU2F4SGcyK0Y0K2xtNzBzM1ZG?=
 =?utf-8?B?QnVmWDQ3Tlk5bjJQeWpWaHFlRGwzVHFOL0xlVTg1Tzh2ak84TUtySzhabUN3?=
 =?utf-8?B?alpIWU9kRStaVFoyMmUxNE5DWlF1YmJueUx2aERjalRXbHJIak10QzBzZXg4?=
 =?utf-8?B?VGZXakQ5a3IvZEZkQ0NkYWdsZ1FwVUYzT3YvNEtEbHBjZHNVYzRHVmxhWnd4?=
 =?utf-8?B?Q0hNcGdwSmF5Nm9MeTJuTmFxK0pNenVId1k2aTRPUVpiYmkrNlBxNjlQakFm?=
 =?utf-8?B?RFBtWWp4QlVuaDlwb1BXNFdBSXB3OVdtdG9TdjhoeE94RFJGZ1BuRjlDeklu?=
 =?utf-8?B?eTB4S0lGbFpmOTlXUkxCYUFBdHErNTYySFh5U1JnVmVnc1pKUUQrMHpiZjBF?=
 =?utf-8?B?QVdOdytONWZsS0JiYndHVi9mM2dxZHhFREpkS2VtdW5oTkVHZjFpY1RrT0Vm?=
 =?utf-8?B?QW1YQmh6aWJsNzUwTG1QQ0ovYkVacDhzc2pGWFFXZkl6SXh1WUlXYnlKYjE3?=
 =?utf-8?B?bFdndlVtVUNBY3RMTDltZmtybk1iZGNZclBROHR6cDBBa1RUSlFGQmdDdUUv?=
 =?utf-8?B?WXp4aUVscnVJM0k4eWVyQksycFBhandkZ1QwcDdrNWh2c005dzJVQzdOTW5l?=
 =?utf-8?B?UVpnYkZVQ2RHR2k2S0JiVTBsRy8vdXFoWitEbzJQQXNuYmpyWDRZZEd5MUFv?=
 =?utf-8?B?TGV4ZXYwUWRqM2JyOWhPZ0ZUL1Jtbk5PdmJGUTZUZEZtOVR1ckFqM1ZFb2lX?=
 =?utf-8?B?dUJrTjYwNEtUT1o4VFhxbHArUHBEU1NXaUdPZG1vTjN1MDFtdDhMRnAwNzlM?=
 =?utf-8?B?dEUxQ09lWWYzZExPaUJqR1ZQalRUWHBQQkVWbEMyUEJKWUt6aWVvTjVKZjI5?=
 =?utf-8?Q?fQ9UnAEZNM85bN25XdMABMifS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88164adc-fae5-4b3f-71aa-08dc48ee3a96
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 14:58:40.5637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOAHtvDVJ+cn151rvhe5x7iXDytXqp2jCAXvQlsI7sMAepLhhb1Dw6OKKd8z92hMgFj5OTFdfe84KSHTuuIg+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873
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


On 3/20/2024 3:12 PM, Lazar, Lijo wrote:
>
> On 3/20/2024 2:15 PM, Srinivasan Shanmugam wrote:
>> The issue was present in the lines where 'fw_name' was being formatted.
>> This fix ensures that the output is not truncated
>>
>> Fixes the below with gcc W=1:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c: In function ‘amdgpu_vcn_early_init’:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:66: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
>>    102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>>        |                                                                  ^
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:17: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 40
>>    102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:66: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
>>    102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>>        |                                                                  ^
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:17: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 40
>>    102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:105:73: warning: ‘.bin’ directive output may be truncated writing 4 bytes into a region of size between 2 and 31 [-Wformat-truncation=]
>>    105 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_%d.bin", ucode_prefix, i);
>>        |                                                                         ^~~~
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:105:25: note: ‘snprintf’ output between 14 and 43 bytes into a destination of size 40
>>    105 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_%d.bin", ucode_prefix, i);
>>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index 9c514a606a2f..f994ee6c548d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -94,7 +94,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
>>   int amdgpu_vcn_early_init(struct amdgpu_device *adev)
>>   {
>>   	char ucode_prefix[30];
> Hi Srini,
>
> Sorry, if I miscommunicated. Suggestion was to reduce prefix size to 25
> as the max prefix length is possibly length of dimgrey_cavefish_vcn.
Hi Lijo,

my mistake, the fw_name size must have been 53.

How 53? -> The size of ucode_prefix is 30, so the maximum length of 
ucode_prefix is 29 characters (since one character is needed for the 
null terminator). The maximum number of digits in an integer is 10. 
Therefore, the maximum possible length of the string written into 
fw_name is 14 + 29 + 10 = 53 characters.

On the other hand reducing ucode_prefix to 25 from 30:

1. The length of the string "amdgpu/%s.bin" is 12 characters plus the 
length of ucode_prefix. The length of the string "amdgpu/%s_%d.bin" is 
14 characters plus the length of ucode_prefix and the number of digits in i.

If ucode_prefix is 25 characters long, the maximum length of the string 
written into fw_name is 14 + 25 + 1 (for a single digit i) = 40 
characters, which is exactly the size of fw_name.

Is that this solution assumes that i will not be more than 9 (a single 
digit)?. If i can be a number with more than one digit, should we need 
to increase the size of fw_name accordingly.?

2. If you reduce the size of ucode_prefix to 25, it means that it can 
store a version string of up to 24 characters (since one character is 
needed for the null terminator).

For example: if tomorrow, if we get something like 
dimgrey_cavefish_smc_xxxyyyzz - then in this case yyyzz would be lost? 
is that in "amdgpu_ucode_ip_version_decode " & 
"amdgpu_ucode_legacy_naming" , is that are we always ensuring that it 
will never be longer than 24 characters?

Thanks,
Srini
>
> With fw_name[42] also, you may run into 43 bytes (30 prefix + 13 for
> others) warning.
>
> Thanks,
> Lijo
>
>> -	char fw_name[40];
>> +	char fw_name[42];
>>   	int r, i;
>>   
>>   	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
