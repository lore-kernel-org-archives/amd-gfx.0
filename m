Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564A7CC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 09:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADDBA10FC37;
	Wed, 14 Oct 2026 09:01:35 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC66E10FC37
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 09:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWwUulMMP6k3brXNOWwZuS3NqpQYxZt9pgChOCqhdu5MQ6O8a2UFIxoYUqK9Wa7o5wETjTufhc5YfnAloI/KCm8yxWNuh44K3HzDtK7MWOehyoc5qAFRzbrsljKq/KAZ3GZsqtbNbJYtwqBb0url7pqgTOTYGnHCGGDYIDy87ulEFExXQpYYUGFMu1RxVBBm8PKGp0zTNFhn2K59p7b5E0cfwwGX2gIdrNLLiPQIUE5omEQbfzxzR+zGOQXY07ArxHdHv/c1zw+peY+0bDIwB9dSpmJogbMVQEaeq0ixKEqvYzv/4h5Uhbij+JuYpUGZuHMwsiwo7G2c4FiCvZz8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8q7DwpgJSva3xweKKktzreO1zMqVXznDkWwOr/MmO8g=;
 b=YM1xUCrwDrbJMWQLU38QUbxd1LxwDyxs2l0yhIlfZcfwB5kXzBrBc8QjAgiwymjGNaGSBWCzoJvqNTwsVxeGUWUGc14odhr0mF1ooUFSRGFbtTCfH2pZm9lPhByYRDijbYroMPFmD+LSC1ZrnI0qMoYgFqvSug01hDlh1i267u+IDaEU1zocZv1dvHoW6Hc1Gq69+RwZiAobA42B7riABRc8XYLgT7D5W3JP9FNV813okQ1fZZFbNO3NGTDKkE45rAeAF072DB2R+/Q+DCAEepobHDB7JnBG5S4kW1CNN+8Z+8PwACFtqbQ2eEOwf82OuQ+JnbVuNoGUDChDrFRCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8q7DwpgJSva3xweKKktzreO1zMqVXznDkWwOr/MmO8g=;
 b=rABECgvnXojFw4rN/eJLHAasP1noMRRtYGlMYdkWeSFA2kUOCE/mxWQ9Lx0m6FX1HIWUNlNS6eawo9RlDrGlkTUMAQ8v+HUUM6vsnduNgqriGkpLBazu9Oiv5fBW+p6W1WHN9HI90sgPEsb+PuiWXA1PIJjZya2wiCzLuMJGD+A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) by
 SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 09:01:26 +0000
Received: from DS0PR12MB8199.namprd12.prod.outlook.com
 ([fe80::fdd3:ff85:ce0b:7c27]) by DS0PR12MB8199.namprd12.prod.outlook.com
 ([fe80::fdd3:ff85:ce0b:7c27%6]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 09:01:26 +0000
Content-Type: multipart/alternative;
 boundary="------------XuIdQUA4jgOCmMp0TqI9abJ0"
Message-ID: <fea17c71-c8f8-4e35-abd2-cbe9e2aedf1f@amd.com>
Date: Wed, 14 Oct 2026 14:31:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] drm/amdgpu: Make first-level trap state GPUVM-owned
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <felix.kuehling@amd.com>,
 Lancelot Six <lancelot.six@amd.com>, James Zhu <james.zhu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Samuel Pitoiset <hakzsam@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20261008070542.1111149-1-srinivasan.shanmugam@amd.com>
 <20261008070542.1111149-6-srinivasan.shanmugam@amd.com>
 <c7583972-aab5-42dc-a121-e619ce2d2e03@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <c7583972-aab5-42dc-a121-e619ce2d2e03@amd.com>
X-ClientProxiedBy: MA5PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::17) To CH3PR12MB8187.namprd12.prod.outlook.com
 (2603:10b6:610:125::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8199:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: d288aedd-20bf-4656-8edc-08df29d1ba0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|10067099003|8096899003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: jdTrFx2scq/CU8SjqDVtklFrbdCeM5loMZ0GreZBEbNE2qMM54KybABaoXOEJSNUpdBkHz//wDsXRrgv14ChwAuoIm51kyh1xdfSOwwx+ZM0UzAV/N+EgbBhXzbgijYbtlEa9UjZ1wzvifJFYN2CyHDkT4fTgXykFPBaTlXXfHYBa+wWkHzAfAp/tUlhGRpIMevI4QeyDmGhy3bufOEE06IRuYw3GhfmDQ/av/T/F7KH9OI7Pf2M+s9x37MfW34Zl8ZcpncqyzzG1cwUOR8Ef6iAY6Os/o8AUJO2/y7iC8Pv4bRCU5v97wXAnufTAhno3zt4BnXUczzKRqSV+nCD2BWKqLdHxYQurqMbf/Q8tKe/H4letTzA63dZd88DSfVFjRPpRcjBaDjr+DYDPvQ99kVLMz/1Q/lqWWkW1NHu9AVwPeeoBTlJhfISL8bwFGzjpKJL+LkwmhD1gH4oRvcMIX6+sgdvzZ5KgYGcJo4FgAnrrU22tBKWoyt/P5CU4g01LoF3oSGtuFdaaapH+9bW4KDisEV5UwfHXBfctXRyQWS77YdPiCwG7cIwCgl46fdCnr4oao0K1fxEHEHvbCByHJGV+sYby0PlUOY/Nr+vUx8oOGWvMFApnxfxPyXc/eOAwHa6dtdxHcElBfcEJXLVEVatbV6Xx81BitxI1DMEzYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(8096899003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDBDQXc3L0F6dVZQOFJoOTYrNlBET28xSnVVcjZvaUlqY0xCQVNnVlo5MnRU?=
 =?utf-8?B?ZFlqemNCWFZYZXNhR3pCQVVXZnV0L2Q3SzBYSW54MWtEY1ExaHZpWUtFOHc4?=
 =?utf-8?B?UGUzemRMaS9YSWVmcWZVaFUrOW8xdTNYdTc1bDRFZGgzb21WdkNIcmdYeG1I?=
 =?utf-8?B?UXBsZ1hkWldyaHJrMU1WbWlXYW1xVUtqQ3Z6SFJmdkZVV2RXWjBjbE8rZnQw?=
 =?utf-8?B?Rm1pellYcHFFTEpuRHRudW1UQ1hPQjdHampTRHczMldNT1JaWE5MbHQ2NlFP?=
 =?utf-8?B?K1RFNm9hN2NMbjJKbWt5ZGtjQ2NHUzJjdHltV3lmeUViWXZQVEJuQ2hXYThM?=
 =?utf-8?B?Y3d2b3gydklyelZOY2tSWVpGRXdSTmJMOHFBRFFDSWM5Ymo2dG5HU1Y0ZHF4?=
 =?utf-8?B?bEx1amlCaGNXVzEvS2lpazR6cHkwYVhTVzlNYnl4VTBtWGNSZVBISHpHaGt2?=
 =?utf-8?B?L3pDRm1zTlRCWk5PRmcycG1mcjNRRlZCVHB6ZG96S21GUjljNmRkaFdRS0p6?=
 =?utf-8?B?YklhOFNUWFc5QU9hWStFZ1lRTGZscU5Zd3NjcXFBM2w0eVh0TjNseEQyeE5X?=
 =?utf-8?B?UGxTcUdQMXlSTkRjektSUEFZOWN4bjNkQ0NoV2dCclA5M2xJZ2VQZm5zcVRE?=
 =?utf-8?B?U3NzS1JKWU5PT3RWOE9SakRRbmEyYkVVcVIxTmFZZ2NKdGpOdjBxSm5HNzNa?=
 =?utf-8?B?eVZjZTJsNkFqa1lUc2JRTGJrRUtFWkZBUFA3eGNreXJneU1uckR4NWlWbDQr?=
 =?utf-8?B?dEN2YWpVN2IxU00wdFlLQnk2ajBUQmpJMVdZdWQzMWJCTVZRM3FHMzJIbjRt?=
 =?utf-8?B?alVLNUFxSW1ncFFCbktjTTBKTzE5V2F3SDBXTTFWdjUyWFVENzUxWE5RK0t4?=
 =?utf-8?B?WjRqWWllMTlyd2Q3Y0xhc1ZlZUFLWWJKTTZOSE5nMEErOUVhbVhMZ3p6emxk?=
 =?utf-8?B?cmV5Ui9VRlBiVlNQbkhzL2dmSkZWTFMybG5WUUhFc3JTWWgveVpNVk5OcHRn?=
 =?utf-8?B?MmNvaSs4QW5FdFlKZHZvL3BlbjdhUktzcllYemVZSGJsaUxRS2dYdDAzZlEy?=
 =?utf-8?B?bGRxMFd3UEZBNCszNmltMnJIYXpVYmJlWDl1aDFhWTdxTkxSejU2OHlaWmhp?=
 =?utf-8?B?bmdZYmJFRktpaTUzSFQvdS9SUksrSUxvNlFHMWVmQUxXVDc4VWZMc290cGo0?=
 =?utf-8?B?RFhKOGR5MXozNFRLMEo2aTVyMFF0VFhtVFlPT1ZNb2NWVGVzWXQ5RkFyRUFr?=
 =?utf-8?B?TGoyWjhzbFhRT09MbzV3SlJEd1hCZk5HdlRacHk4M0hwZWR0L3BvVnBlMk1X?=
 =?utf-8?B?TVByeDZLbzU4ZnRrOExKZG0vY0NkU1JpOUlIMU85VEVzdWdDaUU1T29FNVBr?=
 =?utf-8?B?S0VKeUc5Y3JYa2VkK1VCa0xVVGFNMUVPUDY1dDF6Z1VLdFV0ZXJtUWFsTHFR?=
 =?utf-8?B?d0hxTmlRWWJvN3EwYXlzcW91OVUzVllpSVY5REpmdnN1dW5aS085NDdFdTdD?=
 =?utf-8?B?VitDNG1WMXN6amU0NE9ha0RoRmlPQmlWK2d1WU5aQjc0MEg2ZkVQVWFMMkRr?=
 =?utf-8?B?WTVVSHduUDZ3cE1KRW5FbTlDQ2pERFZNTk01d3I3RWdiU3l0Y09ZN0dXUk5E?=
 =?utf-8?B?MjNYVjhLQTZ6SnVGR2RidWVreTlLM1BndlJoR0YvbEpBL0tZOFk4emJGV3BK?=
 =?utf-8?B?aFR5cmljLytuZG40am9JK2NxSnd5bGppelZpOE5TWkxOd3A4c3RYL1FLb3lq?=
 =?utf-8?B?SkRoV0pQS1pjWDF0YWlFdkc5RzE3RkFabVZuOFVrVjZMWWxQaXdnWW0yKzVC?=
 =?utf-8?B?K2FnVXZpaEFBeWpHOVpsQ2xScktRZ3JmZzNoWnRWY3lzRlpPdlVmaGltSWsr?=
 =?utf-8?B?dWlzVHhMeHZxQnhvM3ZUa1VqV3hRZ2R5NXNuVWF0NU4vbEt0MkpmaFA0MzRM?=
 =?utf-8?B?SEZZTXpZUm8yWmZkMlJWOVg3TmlOWTFNaXR0MjJyQ0NWWnBZWjhydUFEVHBl?=
 =?utf-8?B?M1JSNUQzMWJlWVB3SzhtdFdaMVVHMy9lS2VMY1o4MjRCN1UyajZ1UjZQczFs?=
 =?utf-8?B?NUM5NldqWHJXbmQvNU91ekJiemR5azl0L3orNEhqYlFJaWlSQ3RkVngxdEtD?=
 =?utf-8?B?aXJ0ckJYc2FBNWVDSVRxQXNpbVJlOTNiK3JSZTF3aTdrNkw5bzRQZUxPSDky?=
 =?utf-8?B?THE3WDNiS1U5NWliaEYwN2tKQXgxZUxwTTRLckhGUFA1aU54Z0hhLzN6VG1V?=
 =?utf-8?B?cWJ4VGVYT2ZnS1JIaTNIWVAyeVczK3VCajQ4L1ZoMThzKzRKUlY2L3BIb2J2?=
 =?utf-8?Q?pWcsjSUTPsc+FtB1xC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d288aedd-20bf-4656-8edc-08df29d1ba0f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8187.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:01:26.3611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaXLZU7Drlk0VBjnfA1bMYzcYKBcwM5VO2kO7vwuvF37Wptw7kJRfNXrarg5JmiuNAtJjuiD7RgkYMFtbmiDJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179
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

--------------XuIdQUA4jgOCmMp0TqI9abJ0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/12/2026 8:02 PM, Christian König wrote:
> On 10/8/26 09:05, Srinivasan Shanmugam wrote:
>> The first-level trap state belongs to the GPUVM because the TBA and TMA
>> are mappings in that GPUVM.
> Oh, that was actually not what I thought of.
>
> The idea was to use the VM PDs root reservation object to allocate the trap handler and so simplify the handling.
>
> Moving that into the amdgpu_vm structure was not part of this plan. It's not really a page table and so probably better suited in fpriv after all.
>
> On the other hand we want to modify it through the VM IOCTLs and so making it part of the VM is probably not so bad.
>
> I need to think about that a bit more when I have time.

Hi Christian,

Good Morning!

Thanks for your feed backs and reviews, No rush, but when you have some 
free time, Just a quick follow up on the trap object ownership discussion.

My thinking was that the trap state is tied to the GPUVM mappings 
(TBA/TMA), and queues using the same GPUVM share the same trap state. 
Since the control path is also moving through the VM ioctl interface, 
keeping the trap object in |amdgpu_vm| felt natural to me.

However, I'm happy to follow whichever approach you think is best in the 
long term.

Thanks, Srini




>
> Regards,
> Christian.
--------------XuIdQUA4jgOCmMp0TqI9abJ0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/12/2026 8:02 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:c7583972-aab5-42dc-a121-e619ce2d2e03@amd.com">
      <pre wrap="" class="moz-quote-pre">On 10/8/26 09:05, Srinivasan Shanmugam wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The first-level trap state belongs to the GPUVM because the TBA and TMA
are mappings in that GPUVM.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Oh, that was actually not what I thought of.

The idea was to use the VM PDs root reservation object to allocate the trap handler and so simplify the handling.

Moving that into the amdgpu_vm structure was not part of this plan. It's not really a page table and so probably better suited in fpriv after all.

On the other hand we want to modify it through the VM IOCTLs and so making it part of the VM is probably not so bad.

I need to think about that a bit more when I have time.</pre>
    </blockquote>
    <p>
      <style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;
}</style>
      <div style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px">
        <p>Hi Christian,</p>
        <p>Good Morning!</p>
        <p>Thanks for your feed backs and reviews, No rush, but when you
          have some free time, Just a quick follow up on the trap object
          ownership discussion.</p>
        <p>My thinking was that the trap state is tied to the GPUVM
          mappings (TBA/TMA), and queues using the same GPUVM share the
          same trap state. Since the control path is also moving through
          the VM ioctl interface, keeping the trap object in <code>amdgpu_vm</code>
          felt natural to me.</p>
        <p>However, I'm happy to follow whichever approach you think is
          best in the long term.</p>
        <p>Thanks,&nbsp;Srini</p>
      </div>
      <br>
    </p>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:c7583972-aab5-42dc-a121-e619ce2d2e03@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.
</pre>
    </blockquote>
  </body>
</html>

--------------XuIdQUA4jgOCmMp0TqI9abJ0--
