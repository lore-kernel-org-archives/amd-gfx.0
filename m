Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C1910A3D8A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 12:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B31C10E0BB;
	Thu, 26 Mar 2026 12:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kvmANENK";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC53F10E0BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 12:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbQxU4uRSD03+al/vf468DQ4hU6JyvU9L31Rvgt1MGGRxUj1E7wGX/xMGfOa5XBiLdh20nD4jaPzTD8x7iENaUwN4wt8NvLmp6uMlyMWxAlQidXcpRdWsysQ/Kp6Cm3YvPHNPQFT+aL0HE8/nDxZjsGc2TMSbGYPX8QEf7Ko2owLwbPKiVPB8k2LaXqmgKC62hgtonIX/0UM0hOC6eK9pdWFJPfPT+iK2IlipqKv1Xa7VqbNOzdBMOKJCOCFzPbuEbNS407BIShQ1OG/Jirl6aPkYFweF2aAoI2lkkbMKNCy0GrC2a8wUf3rybw873OzbHlRTRn+ds7DvDUmNw8QxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/naeZ4JAD5G4ndNRw2RUzNujRSN3R7EXOBzpEISpbLI=;
 b=uCW86SJC1cW+F5nhcKe/2ZGqnSkQenvFvoAUK1PekJ0/QNeCoswv2bqJZepIKXaunEy0b0554R1snRnrdn3BgKYmvbcBRLuaeKSbeqLCzVv8dIBD2ID+PpOBHtYNyIE0taYqrAgoUvxfkmvOvt2JUDTi5es/AwZTVRf6pTIFYKHEiZoADm+zR5ZuctXhh1FheWuaWfrPuGLqcTQia2HKfuA2wLsDniUQRx+BzmNxwm1kg8rwAyeirofq5QRHCM+SxuothzAIqyjNXY4G7+bHaw7GMqx0PEsqH8OQgREhNsTvGN1xTbXI/0pJahXISHPVteY8k3RjFU8zXfbuLI8t7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/naeZ4JAD5G4ndNRw2RUzNujRSN3R7EXOBzpEISpbLI=;
 b=kvmANENKVdU650VCSUNl81tMxujvphfYxH0ASE+ubwde8Exelc6eN2KRbi293jlqQmEQslpgaP/Csp/KnNJCLOvnrKImK6VEnJN/5d0cXqWvXGPM7mIQypbegcv8YENOy+4mEZwCvfLmlu0bA2ddQ+ezEQB0k7a6M3GzvGYpWSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 12:26:44 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 12:26:43 +0000
Content-Type: multipart/alternative;
 boundary="------------ycJO4Y0yXKgy8NtxyF2emxsy"
Message-ID: <e477110b-f1c2-4a5b-980c-be2d7e8cd6ae@amd.com>
Date: Thu, 26 Mar 2026 17:56:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1 1/4] drm/amdgpu/userq: no need to use local variable ret
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260326085601.2665215-1-sunil.khatri@amd.com>
 <20260326085601.2665215-2-sunil.khatri@amd.com>
 <6bc42907-3370-4c92-94f9-9a873f50ede6@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <6bc42907-3370-4c92-94f9-9a873f50ede6@amd.com>
X-ClientProxiedBy: MA0PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::11) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CH3PR12MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b6e9ff6-d469-4ecd-e5e5-08de8b32f08e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: FNt6PoggGk2lBfdPwYCq5Up1oFaYDWagm+d5pUGQRWrilmdno3d4/wYQJ6PaPvMAMDdncpso0Ehfeq/rpqdoaaQM1J3OV/sIti2L19Z6PGNFL19ddD9H5+G6DUVvOfBZaKdIvysgrVDZ7BztgId5pR31dl/H5Zx0wQ8Uy0PFxkbVXtTVjlPMiIqV3FyxESgRMZaZu/ARomFh0jG+tMviIzHA8gQ++pfus57ZOkDjXHwwsOf98eAssUaOiOhxwP30jEv+v78O2aYIXYazuvpmkbdYbDcFA3uGXKZSPsmABH+6n2/9BuBA7A/eT4FoyWimodrA49/GdzgwJ0DameyZ75GdaAeppNFIgEn9xGDDs4HmtPUeS7LarS6B+B8emdXhLMbBxE+5DZRz4NQWCrnatw/pkzXFprchbOh2/0012/mComqf3L0ru4BD8378ml0Td4ocNuhAYnXsLlla8tl58fxxx4BoNYmNHkmsl4NxvJZikblao5Q88okqVKNTqbX5ZwlkcfPXiktN3GhDMBJeaJjeKUusOQzgTvg211+qC4Jn+hXRsbBcfj9Q/BFbAVvYmX/JseUN53K6Y+WzcPwm+5Hhu5z6Ok2z8B4A+5SpDPL7Mx6bPGUH5Dq/+freYudtaSll6NatqZIOv65WPGfL0/f/BfRBTQ8ARjR9dRxWgzn5NgdkaotYG3IU+s2PiVsDMTOtBM1VlIYx3g2o+FH0giv0/ZA+mGvALmflxWn3T9g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWZYMXl6SDNZUDZESnBTQ1JWRlQ3MC9VQXR5NHAvQjEyL1E2UHpvdFlpb1lB?=
 =?utf-8?B?MC90YXc1bGE3Q2M1V25Bck1LV3Y2djF5MjVFbENoT25wYStiMWp3SjdQV29u?=
 =?utf-8?B?OUFkZ2kzU1ZrS21yMU9vdER2bkl3Nk5NTmU3RlZNRkNHeW5YbFhXcmZ6QVJC?=
 =?utf-8?B?a3IwY1plbzNQYWJmNDlCU3BKN2pDRk1GOTNzQlZOeGNVS1ZDNnJsR1lldVFO?=
 =?utf-8?B?SzZCZEZMSlV1Z08yUDN6S1QrNnEyd2xOY3lab0ZHYkVjZk1yWTJVMGptVWpv?=
 =?utf-8?B?YW5HeWJsOWhHMkVaa1JhU3dSRkFLbnhxZy9xblcySnNidU9zZFowdThORE1C?=
 =?utf-8?B?Kzh2YldUeDh1NGZ1bTBqdXhCZFBLVkp0R0Jtd3JONStJUE5NNnQyWkh4MlY2?=
 =?utf-8?B?N1BpS0UyRUZoOFVDVHBOK3dNMlhiR1pZOG9LUnQ5OVIyaTdGMXJiY2FOWGZv?=
 =?utf-8?B?R0thQTN4b09kQVdhdlFQd2V2RE0zemdyYWVDUnZRNHJwa3oxRjdpNy9yWnFE?=
 =?utf-8?B?UkJxTStyYUlVdnV3OGI2TE1Ic0VTYnVzV3pURVE2czUyOVA2ckM5S1FabHBR?=
 =?utf-8?B?cXZnelZjMXZoUlBGQWpMS053MXFsRVpDU1VIWkFlREZRLy9kaVEvS2dEUytq?=
 =?utf-8?B?SmdHaEVVYXM0UGk3MEpzbEd3dEE3RmFLbWdwTWhKVzBscTVqREZabTFIa0pv?=
 =?utf-8?B?YzFqMm9SdGZaaHQvWlpBMWt6aUJBSTZBRHQzTVhzbW1BeTFKL0orWHR5TEwr?=
 =?utf-8?B?ZzdPZ0lJeVFzaW9yYTBzdVJ0L0JqbjNtekZaMVN6MHVXWEgrM2lkcFU2S0NH?=
 =?utf-8?B?ekRwejUydFFBVjJpYVJpbC83QWh2WFpzdXNyekZVMW9xbXRwdXYvTlg3Szc1?=
 =?utf-8?B?MzlXdjkxWGNXLy9kMGNnY2x2NDNTbnZrd3laQTJIWU5lcDMxWjl1blRWZnpx?=
 =?utf-8?B?U1crckJDNHhnaDgwVVNkT3RBMDJ4Tk5jZU5rWmxWNzJOY0NzUmNmWHpISTZk?=
 =?utf-8?B?d3dpMDd2c1hpWDgwNFhhVzFjRGNMaGRYUi8zaDRnTEE0SmlxOThLZEJMOWRX?=
 =?utf-8?B?N3BiYnNjbmUzUWV3ZmtPczh5NlhHOWFhc0hsL3lqekVOZ2lrSGp1a0hTUll6?=
 =?utf-8?B?WDdwbHR6dEF2OGNUclVwVWJ3SmU3NS9wNkRWUGZHY1UvdDd3a1NWSFBERjlG?=
 =?utf-8?B?d24xNnJvSDFLN0tyRVBkN0xWZFlMWFdNTTJwb3FuRStkSnh4MEh4Z2wvdDhI?=
 =?utf-8?B?M0VVSWMyZHVGVTYya3BxMXM0ZWV4Y1R0YVBwRFpiRGk4R3paSXp1dXlKNWt2?=
 =?utf-8?B?VnRkK1ZnTDJpdSs4ZzNYYlhHa2QvTU94TmROblJVSzRqaldTWFREMk9SMFVa?=
 =?utf-8?B?VzErdEdnMXM2YWYwYUk1RUpzUEhBMjc4TmRGSFF4d2VDSWFRbDBZZ0kwSzFm?=
 =?utf-8?B?TWxOS3FBcFdzMWNHbGtNN3NLYjFGYzgybUp4d1BsVWEvYUZTdGdjWU1uQitk?=
 =?utf-8?B?OXV6SmdzZkJ5bjQ1ZExkUTh1TVR4QXk1ZmxQNGgrY09ITjZZQjVQRFFEU1Zw?=
 =?utf-8?B?aS8rVktzVWo4MVFPcUVWcEZpRDFsSnZFbzcwSmd0WEhQbXI4bE5BQXNEQTda?=
 =?utf-8?B?dzRMZlFqNVkyK1dhNUNyUU9mTGF2ZzEyRXAvVXVxdjd2Qk9hZXdTd2QyUndh?=
 =?utf-8?B?VzErU0ErVERPTGFWemZmczVVckxIbWszYmNNbHVPY3duQjU2eVNsNVFTcjhp?=
 =?utf-8?B?UUZ2aXc2MnVPcUJuaW1EYXhZYTJUVFpuOEhLdEZOZGlMYmJUVXA2QXNzOHlt?=
 =?utf-8?B?ZHBKdEZKTjFFZllFTmxsbGcreG5vZW5VOXY0cGRhVnh1SXh0V3lNY2N4UWlC?=
 =?utf-8?B?VHc3YmhTb0RVN0tTK24wK3hrSTFTZ1RkUytPNDFKdFZ3a2RhYVBXd2JGYTZC?=
 =?utf-8?B?a2pkem9LMCt0RWhTOWtIZzBRL3hGSjMvYityZjY2b01JT0pXTmp4L3F5cVhF?=
 =?utf-8?B?QVpMc1FQdmVPNEFua1p1bld6QmhQbW1oR0FFZ09TUXVkWlM1amR6Nzk5UWwy?=
 =?utf-8?B?ellqRlhvKzlhRzg3SG1ET1BMMEhOOWIyakxJa1BBZm9Sc2k2S2gwOWMvZFhX?=
 =?utf-8?B?VThlMWRuZTdNdjNmc0cwNzlkSTBhbk9hU1FjeVNRUzc1SDFFbXUrTURSTllP?=
 =?utf-8?B?cWh6MEw1ZWprbWFyeDF5U0lzVWhNWjNpeTRUY0MwOXFFTFRsZHpJU0l1NXp5?=
 =?utf-8?B?eWI3ZDVVVDYxWldpOXlsdlM4NDhRQ2gzby9KeFNVREVOV3d5YklSYTROdENx?=
 =?utf-8?B?ckZIc2s5VG04ZUQwdE03OWFqMWlycldBaUtqNjRUODBiNlFhZjdyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6e9ff6-d469-4ecd-e5e5-08de8b32f08e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:26:43.8422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqO+Eb/fmoZB9Y+Y3b7ICFR/uHTVZqWPa04oWDlPjKD8z3QaxZORtgIsMBMNmeOnvx1d5hYm4SgsOljL8zlTCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8460
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

--------------ycJO4Y0yXKgy8NtxyF2emxsy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 26-03-2026 05:38 pm, Christian König wrote:
> On 3/26/26 09:55, Sunil Khatri wrote:
>> In function amdgpu_userq_evict use the function return
>> value in the if condition instead.
>>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index aa0e6eea9436..2a1832fce6d2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -1308,17 +1308,13 @@ void
>>   amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
>>   {
>>   	struct amdgpu_device *adev = uq_mgr->adev;
>> -	int ret;
>>   
>>   	/* Wait for any pending userqueue fence work to finish */
>> -	ret = amdgpu_userq_wait_for_signal(uq_mgr);
>> -	if (ret)
>> +	if (amdgpu_userq_wait_for_signal(uq_mgr))
>>   		dev_err(adev->dev, "Not evicting userqueue, timeout waiting for work\n");
> That actually looks like a pretty bad idea. Instead we should start printing the error code.
Sure could add an error code in the logging.
>
> But before we do that I would rather like to know why amdgpu_userq_wait_for_signal() can fail?
dma_fence_wait_timeout is what could fail and we are returning 
-ETIMEDOUT. We could totally avoid checking for the error here 
completely as we are already printing the error in
the called function below.
ret=dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
if(ret<=0) {
drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
f->context, f->seqno);
return-ETIMEDOUT;
                 }
> That should never happen in the first place.
>
> Regards,
> Christian.
>
>>   
>> -	ret = amdgpu_userq_evict_all(uq_mgr);
>> -	if (ret)
>> +	if (amdgpu_userq_evict_all(uq_mgr))
>>   		dev_err(adev->dev, "Failed to evict userqueue\n");
Here also the below function returns error and printing error too. We 
could avoid the return value here too as we are already printing the error.
amdgpu_userq_preempt_helper(queue);
if(r)
ret=r;


Regards
Sunil Khatri

>> -
>>   }
>>   
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
--------------ycJO4Y0yXKgy8NtxyF2emxsy
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 26-03-2026 05:38 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:6bc42907-3370-4c92-94f9-9a873f50ede6@amd.com">
      <pre wrap="" class="moz-quote-pre">On 3/26/26 09:55, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">In function amdgpu_userq_evict use the function return
value in the if condition instead.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index aa0e6eea9436..2a1832fce6d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1308,17 +1308,13 @@ void
 amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_device *adev = uq_mgr-&gt;adev;
-	int ret;
 
 	/* Wait for any pending userqueue fence work to finish */
-	ret = amdgpu_userq_wait_for_signal(uq_mgr);
-	if (ret)
+	if (amdgpu_userq_wait_for_signal(uq_mgr))
 		dev_err(adev-&gt;dev, &quot;Not evicting userqueue, timeout waiting for work\n&quot;);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That actually looks like a pretty bad idea. Instead we should start printing the error code.</pre>
    </blockquote>
    Sure could add an error code in the logging.
    <blockquote type="cite" cite="mid:6bc42907-3370-4c92-94f9-9a873f50ede6@amd.com">
      <pre wrap="" class="moz-quote-pre">

But before we do that I would rather like to know why amdgpu_userq_wait_for_signal() can fail?</pre>
    </blockquote>
    dma_fence_wait_timeout is what could fail and we are returning
    -ETIMEDOUT. We could totally avoid checking for the error here
    completely as we are already printing the error in<br>
    the called function below.
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #9cdcfe;">ret</span><span style="color: #cccccc;"> </span><span style="color: #d4d4d4;">=</span><span style="color: #cccccc;"> </span><span style="color: #dcdcaa;">dma_fence_wait_timeout</span><span style="color: #cccccc;">(</span><span style="color: #9cdcfe;">f</span><span style="color: #cccccc;">, </span><span style="color: #4fc1ff;">true</span><span style="color: #cccccc;">, </span><span style="color: #dcdcaa;">msecs_to_jiffies</span><span style="color: #cccccc;">(</span><span style="color: #b5cea8;">100</span><span style="color: #cccccc;">));</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #c586c0;">if</span><span style="color: #cccccc;"> (</span><span style="color: #9cdcfe;">ret</span><span style="c
 olor: #cccccc;"> </span><span style="color: #d4d4d4;">&lt;=</span><span style="color: #cccccc;"> </span><span style="color: #b5cea8;">0</span><span style="color: #cccccc;">) {</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #dcdcaa;">drm_file_err</span><span style="color: #cccccc;">(</span><span style="color: #9cdcfe;">uq_mgr</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">file</span><span style="color: #cccccc;">, </span><span style="color: #ce9178;">&quot;Timed out waiting for fence=</span><span style="color: #9cdcfe;">%llu</span><span style="color: #ce9178;">:</span><span style="color: #9cdcfe;">%llu</span><span style="color: #d7ba7d;">\n</span><span style="color: #ce9178;">&quot;</span><span style="color: #cccccc;">,</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n
 bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span><span style="color: #9cdcfe;">f</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">context</span><span style="color: #cccccc;">, </span><span style="color: #9cdcfe;">f</span><span style="color: #cccccc;">-&gt;</span><span style="color: #9cdcfe;">seqno</span><span style="color: #cccccc;">);</span></div>
<div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #c586c0;">         return</span><span style="color: #cccccc;"> </span><span style="color: #d4d4d4;">-</span><span style="color: #569cd6;">ETIMEDOUT</span><span style="color: #cccccc;">;</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</span></div></div>
</div>
    <blockquote type="cite" cite="mid:6bc42907-3370-4c92-94f9-9a873f50ede6@amd.com">
      <pre wrap="" class="moz-quote-pre">
That should never happen in the first place.

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 
-	ret = amdgpu_userq_evict_all(uq_mgr);
-	if (ret)
+	if (amdgpu_userq_evict_all(uq_mgr))
 		dev_err(adev-&gt;dev, &quot;Failed to evict userqueue\n&quot;);</pre>
      </blockquote>
    </blockquote>
    Here also the below function returns error and printing error too.
    We could avoid the return value here too as we are already printing
    the error.
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #dcdcaa;">amdgpu_userq_preempt_helper</span><span style="color: #cccccc;">(</span><span style="color: #9cdcfe;">queue</span><span style="color: #cccccc;">);</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #c586c0;">if</span><span style="color: #cccccc;"> (</span><span style="color: #9cdcfe;">r</span><span style="color: #cccccc;">)</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #9cdcfe;">ret</span><span style="color: #cccccc;"> </span><span style="color: #d4d4d4;">=</span><span style="color: #cccccc;"> </span><span style="color: #9cdcfe;">r</span><span style="color: #cccccc;">;</span></div></div>
    <p><br>
    </p>
    <p>Regards<br>
      Sunil Khatri</p>
    <blockquote type="cite" cite="mid:6bc42907-3370-4c92-94f9-9a873f50ede6@amd.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
-
 }
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------ycJO4Y0yXKgy8NtxyF2emxsy--
