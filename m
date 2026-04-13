Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C50EBFD22
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 09:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A798310E39B;
	Mon, 13 Apr 2026 09:24:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pYP9io+u";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2A7489EB1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 09:24:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKgPJzoldzjuy0OtoI53rOm/gYW4AhE9Xaq4e8rWgH8GdmqRkDtjenC3/BddA20PUi+ozgbRQeNJnQnCFeDoU+BC6dhj6lzGT0HezNrrlMEUnphSkCoFs4D7Yex+3WXDfTQQYsRjnQuIwQVjsc20txY0axZpH4GI0RaGWd7mZiuuz02avTkcVlKFsRl++r3+YAobj3XUBy9saVCeZVRwVINDNa3kinD3uVoy7ttnwLNfKNYkFcc/Ud9sJrLjmVUsiRj1Y7LknuExfFz5gr3SwIjYPZ6kSwKNYYbeEB/5qm2i9U/A2boSKmcmxIlrdyAWB+0R7CLfRb7DkL6zrEgidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppT9oMEKj3xI16ffIj/UDGHhSfcXvAzgr2RFeBtaJSw=;
 b=p6ZVidhWYeSoP22XM3qfSYngt9K7WDnSIMswaYXrjQDbopN3CXR6nUuJx7v0jtc9+UjKU2mEY+CHncEmkEIPPKZvIjxAyZujeaahtMTaKMBFjluIqT5JyuvbEHZ2PbYbhoIRfsYZZ9OR/VuygXKRdgb9kDhcqwr1YZvb9DMR8MhNEptuNTMbhUUV736NWZqBIP1ibYfbnYIXW2+q3qyI6PtYu+344vgcpgc+IGSS16nxkNTC4vGyLUAsDrOrKtimSJbciR2Azwmq9La2jdc7/2qBeM3+I5lBipIN1on5XdSAOxEEIoWJQqdhyThEZ3QiVKWi0Vqa34DnnsDA++nSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppT9oMEKj3xI16ffIj/UDGHhSfcXvAzgr2RFeBtaJSw=;
 b=pYP9io+uuuJvAIE1UFLx/weJx1+nrZwlaasPne1GkQUGLBHC7/59tmOtsW3raIuyu7H9jbCD2l7QL0xUhGQ6SsVPlNFrdLUHZNWiYUakjYVB1x1V09VznwONvttOR2n1bbX50hx3yLHtDQHvmHFNLIbyVIYiUafzr4Ul3hR/ysg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) by
 DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Mon, 13 Apr 2026 09:24:48 +0000
Received: from DM4PR12MB5771.namprd12.prod.outlook.com
 ([fe80::dba:6509:159c:fba3]) by DM4PR12MB5771.namprd12.prod.outlook.com
 ([fe80::dba:6509:159c:fba3%6]) with mapi id 15.20.9769.016; Mon, 13 Apr 2026
 09:24:48 +0000
Content-Type: multipart/alternative;
 boundary="------------0AXxu5d11h7apsRHf3nPfI0O"
Message-ID: <4e862955-3437-40f4-bf04-2bdab7d84909@amd.com>
Date: Mon, 13 Apr 2026 14:54:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: gnome shell uses max priority
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>,
 "Mohan Marimuthu, Yogesh" <yogesh.mohanmarimuthu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260413084943.819126-1-sunil.khatri@amd.com>
 <5976d500-d768-4a63-8fbe-4e68e20fc0e6@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <5976d500-d768-4a63-8fbe-4e68e20fc0e6@amd.com>
X-ClientProxiedBy: MA0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::6) To DM4PR12MB5771.namprd12.prod.outlook.com
 (2603:10b6:8:62::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5771:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: beb1a558-a8bf-4776-8d76-08de993e8193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: QYmihq+HicQjTq61KkYwMNBprHVhAJkKGl1JybQ+8QMINDA2GSgzHZS8TiE/hs75QyMFhwqSx6cqYZKdqFVw8a9alfLAkGgHgzVqqIJOkgTli0DIbBxaNDvXySYajs1m+hQO+oTuTkJeRN6RzYzZrPBECkawBNKDYyhCTetmPH5gNfJnNslAwXDGuLfXIfn5/2tuXYJ2C0ypPCvvTvk3D820obkMAr9cTnfmhpD21Gwdqj9Fb5Bqmmua2Y+mGfFXPuJusUYjtSlbsjodPJ1YyFZEAx3ECTAYH4CMfITfedcNxu4os0vVyI//Uv0iQFwu03FW/wv9V1DrfQ+erz8BlQD0lTmslA22vUmBWq3eAEZH+cLbq8kOW3716tM4uVml7ri89YTJZJJYT12dIpZ8Ezn0LNVK1cYLcOtg5D5baEh+VquCqdkMD+7slSYpqUPkGMW6R7WTQcT+JzN+QCQa0OSmEUepGgcCpOlg3Mi8zleW6vtDuEG/CbhbAd8QzDT9QC1PyhMmwHXMgZVQFbwlUxkKNWbEpqWzaEXKzV6aDXi2X4wcxZqkfSqPCZqGrLLBitHH8G1MRcIkx3UGX8f+ZtuD7zXHFyQYO99fO7KM7jNeBWWZvnuoZ2BAV2Egd7Ewms3uYADaazWKciHrVkYiJ7y5K50zUlfYZV4trXptEzyZtEQMtYleo8i2d9ZeKKm8QxFCz7oBgeOYh1FgPeg6XY0EHZu1RIBiWqnNynxUOg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5771.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SCs3eSt2NjJGOTQreW04dCswdmxxeDBpaW9EQlExUkliNnBSUGdPV25zQTB5?=
 =?utf-8?B?ajFVRlAwMnA0TmZ6aGg3dTgyUzdxSnlrbFAxVnpsLzdaNHFaSCtrN0VaM2hV?=
 =?utf-8?B?VmxPQ0JYWmltQ2xpMm1Tazl2R1BOd1phMnRBKzFYNDFDNUVSYW45ekg5eS9Z?=
 =?utf-8?B?VUFmY2dxbEdHWloyTmJnRmR2NC9tNy9mbm9WWlFiWWFwc1l2aU9rSTZqdWpv?=
 =?utf-8?B?TTJHZDBuM1VGNzBEZll3SmtLUzhOeUFvZHZoWGtobWxlelBOWEVBTUI4TzI2?=
 =?utf-8?B?WUEvZ3Mvc0pOMGJqTFZUem1qbThXOVR3cjMwYVhvQzMreHU0SSt2b2ZHMGRz?=
 =?utf-8?B?RkY4Nm9Nd2dhcGRsS3U1dElzSStlbHZWbFo4K1RCUmJHOGFXSW5LcFdZLzZx?=
 =?utf-8?B?KytYb0ZramxuRjV6U01QTEc0alJJbzExY2xWTzhUOVByYlhlQVQwME9Pb1ZV?=
 =?utf-8?B?Mm5zMkNBSzBuRXdHUm1QalVoMnhMTHBvNEpZVUVCSVNVTHJMYnVXY21PcW1j?=
 =?utf-8?B?MW9tNU5xUjk3dndzY1BxU2VyRFpJdVRuditSSHh4WWV0WURQK3cvRkFvdWF4?=
 =?utf-8?B?SythdW9qbnlIUmFoUkhvOFR3c2lFNmZNR3NkZ3JzZ2Q4SHEvL1hVa2lPQUov?=
 =?utf-8?B?MDMxYXlxQkpNQTNRekxhN2tDOExvejYzcFpvVVowbnJpQURjTGM2R2ozcjBz?=
 =?utf-8?B?NTNDZmJwNG5nL21kZnVKNUhxZmxraW9JeUVaM3NIQUZZc29LajdVYThodkdS?=
 =?utf-8?B?N3BxbmJNYy8wOENadTFBaEM5VFFCTU5KM1hZcVJ2amh3OTcrNkhQUDRFVTgz?=
 =?utf-8?B?MjZVN2wyYzVZOW5TQlB4US9XYllpYU11R01vSzFwdTdPNU1EZ1dKS093M05U?=
 =?utf-8?B?NHNNWWJpQ2ZLMWtCNkt5OE1vZy8xK1JWcE9OeDB2WFM2ZS9ub2hRYXdXNUtw?=
 =?utf-8?B?NGhtM2Q5aVFORERQR2hqZ1hPUnJiS0lsaUxVNHpGckgvQmQyd1JPVmlJdjdl?=
 =?utf-8?B?TkRGSEd3TGhVcUg0U1F6Ui80UkpvZndROWxHTWZiVHBnMWx0MUxzaXZyTjRQ?=
 =?utf-8?B?WDZ5OVRFd2JZVVoxOTZpbnhGa2JqaElYUXdIdjBtRFB5a3hSL3hjRmpvbGpK?=
 =?utf-8?B?YkV4RXpLSVAxUk5MVHFnc2UrRnFkZXI1V3g1MHdMQWZ5aEhsdG1JYVMrSVo0?=
 =?utf-8?B?WFlyMmVpU3lFN0JBQlV4TUZkUmpnZlBBRW4xRURNbENJKytXQmErSGlLeFpo?=
 =?utf-8?B?YUVKOEFlNGMvMmdJNHFyVHRmR016c0lkY1V5ZENNTUltM1p1N200VGltL1Rp?=
 =?utf-8?B?ZTFvYS9La0pLUEdQN3RFTUlNazFKd0FuNWhQZTZKOTN6eWtmVE1Kb1AyOXpU?=
 =?utf-8?B?L293bW1WNW42LzZEWVFwTVBGdDFhbFVKS0RwZktqZmJSRHhaTUZ1TEVKdEJU?=
 =?utf-8?B?WHhyNUNWNnJYQUg0NGNHbkZFQy9xZng3UHY5b3NoRkVxRWgzSWJ5dGVZYy9C?=
 =?utf-8?B?RHZOamMweHV4SFB4Nll4VHJCUGdLMlRZR09HVVpWL0xTYllTeDRFRXFnYzNW?=
 =?utf-8?B?aDhENnRON3VPRzBpZU5PRHI4UHVuOE0rbHhNa2xUSEFIQVNCSEdxbzEvUXR2?=
 =?utf-8?B?djhKNHlXcGhxeFk2Z2QwOWt6U2VyQ1JUMThDWDgraS80Q3luVG5IZGhUc0ZR?=
 =?utf-8?B?RzhleCtKUnkvd2JwN0pvazBKd2tMcnF2djhxL2MvczRCU3I3UGExVy93UVdw?=
 =?utf-8?B?bUJaTGdsM2l1MmZnbEVEUk9hL2R2YkVjdzh3T1ZlUW5LZXdxdFEvaFBHQnlZ?=
 =?utf-8?B?bWNMRWY4c0xYZlFxVktnbU1VdlFQS0NxTytxS0FYN3R2NlF4KzZjbmpkZFdE?=
 =?utf-8?B?V3MzRmg5dGFWby9MM3BJeG9uTXV6N09PbHpRT2ZzdDBqRzNqSEEwZ2tQQUpE?=
 =?utf-8?B?NGhmUUZDVGl5bGM3cXlaQUdRRVlNYkkyMUxSV0J4QStoaDFDSlNWVXBBVlBj?=
 =?utf-8?B?Zm5jYnh1RCtqeWEzTjF6VmkvMFhuY2I1UU13aHpPR25oU0pFbmlIcUcvS3Ji?=
 =?utf-8?B?b0w0VnBVR2lnWXgxWFprTDBjM0drTmR2aVI2bnZmU29qeFR6bEh5dU5zSXgx?=
 =?utf-8?B?OWxvMGhiS0ZpZXh5YUtrQjYxUmpVUCtzZzZ2RzV5RlQzME1ubEFRL2RiRnlJ?=
 =?utf-8?B?ZmdSVmwrYlE1Z3ppRkhuZTRydEhTcDhLeVVmVXBPT1VmaUUrWDRwSkx1bm5p?=
 =?utf-8?B?VEo5bFpicjQ0L083WnkxemM0ZEYydzZPZG1Ia1I2cWR2dlh4VTA2SGRKQ0RF?=
 =?utf-8?B?NUowT0htT1ZZZk8xa0Rlc1BCL3pBYktMQkN4dWsxQnloSnUweXF5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb1a558-a8bf-4776-8d76-08de993e8193
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5771.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 09:24:48.3568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqsG0JDChRMd+QLMpL6akaob1OXtdyQhHoroncTjf5oIXS847FMyHxdnhiQTapgAtTQNLhZ56plZi28SAv/E2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486
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

--------------0AXxu5d11h7apsRHf3nPfI0O
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 13-04-2026 02:32 pm, Christian König wrote:
> On 4/13/26 10:49, Sunil Khatri wrote:
>> In function amdgpu_userq_priority_permit allow till
>> maximum priority i.e 3 which is seen for gnome shell.
>>
>> This is needed to fix the issue of unable to create queue
>> for gnome shell.
>>
>> logs:
>> [drm] *ERROR* comm: gnome-shell pid: 2802 client-id:10 client: Unset ... SK: Priority 3
> Clear NAK, as far as I can see the existing code is correct.
>
> AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH is only allowed when you have CAP_SYS_NICE, e.g. you are root.
>
> That is also documented in the UAPI. Question is why is gnome shell trying to use that?
I see, let me add Yogesh for his inputs, @yogesh, why gnome shell is 
asking for priority AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH. Based 
on the code seems mesa is getting a flag set flags & 
PIPE_CONTEXT_HIGH_PRIORITY -> this sets 
AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH for graphics queue.
Regards Sunil Khatri
>
> Regards,
> Christian.
>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 6a635bb8bb30..b4f7229c21c5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -701,7 +701,7 @@ void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
>>   static int amdgpu_userq_priority_permit(struct drm_file *filp,
>>   					int priority)
>>   {
>> -	if (priority < AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH)
>> +	if (priority <= AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH)
>>   		return 0;
>>   
>>   	if (capable(CAP_SYS_NICE))
--------------0AXxu5d11h7apsRHf3nPfI0O
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 13-04-2026 02:32 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:5976d500-d768-4a63-8fbe-4e68e20fc0e6@amd.com">
      <pre wrap="" class="moz-quote-pre">On 4/13/26 10:49, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">In function amdgpu_userq_priority_permit allow till
maximum priority i.e 3 which is seen for gnome shell.

This is needed to fix the issue of unable to create queue
for gnome shell.

logs:
[drm] *ERROR* comm: gnome-shell pid: 2802 client-id:10 client: Unset ... SK: Priority 3
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Clear NAK, as far as I can see the existing code is correct.

AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH is only allowed when you have CAP_SYS_NICE, e.g. you are root.

That is also documented in the UAPI. Question is why is gnome shell trying to use that?</pre>
    </blockquote>
    I see, let me add Yogesh for his inputs, @yogesh, why gnome shell is
    asking for priority&nbsp;<span style="white-space: pre-wrap">AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH.
</span><span style="white-space: pre-wrap">Based on the code seems mesa is getting a flag set 
flags &amp; PIPE_CONTEXT_HIGH_PRIORITY -&gt; this sets </span><span style="white-space: pre-wrap">AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH for graphics queue.</span><br>
    <span style="white-space: pre-wrap">
Regards
Sunil Khatri</span>
    <blockquote type="cite" cite="mid:5976d500-d768-4a63-8fbe-4e68e20fc0e6@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 6a635bb8bb30..b4f7229c21c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -701,7 +701,7 @@ void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
 static int amdgpu_userq_priority_permit(struct drm_file *filp,
 					int priority)
 {
-	if (priority &lt; AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH)
+	if (priority &lt;= AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH)
 		return 0;
 
 	if (capable(CAP_SYS_NICE))
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------0AXxu5d11h7apsRHf3nPfI0O--
