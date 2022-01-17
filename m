Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81814C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 11:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0007310E1D3;
	Mon, 17 Jan 2022 11:57:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5914A10E1D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 11:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6v7ESbLsrNgtRMJ6G3BDY3TOgPUHTNaPVgkxoqYapDo6Kt4Q5gmTBescvNZrQqZl/eJLhGrrYS70dWPXgmpI2vJEkBHAsXmwOXM51T2HHeIPOnu5+MNTdQslQKePlxlHnPPq6MsJlUy56vZQOLvnSDrCXSaWOK9Z1x496TNFRACRmMeSdyVR2zGCNTMe+y73o9GF0e2E58y7BbCstUwX8k6bILd/UTE8c9QEfXhldf28uVvo6weFb21NkDFZdB04ud6yXqNFbLjPC6VHQJXX8l2kgQcX0dLP1pn4WGSlwLTK/78KRpagCS62KEISDpK8w6SayTDEFbImbu0+kiyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqlwBmLDLeBDXs0ZtxEyEzLkyKFg2cP4b+QH0Smi47o=;
 b=e1B5xYPC7ZSe7vTNNfPVSLy0drXkf0td+yT57dVNi12Lv45hScC69sxK/TWVeU364gUJ3EM7CJcgRVvm7MvgzNk2GUvEBTEfMEcO3fUmJRLeUUdvKbf/657TeXkxY8JonTGK9WgdEU99xOaL3SUKrsDAjKf3QK+S15qnl46m0olM4eg1n1hd+ZdvUbu7hBiBvU36xO6GB8UXed/AZxhyTXx/2vsuqOwut0PpeeXowEQ/eMDyjxCqKpns6gauPMYBEG0IMcDPWC6dtvYbsoCKr0mZgxYnAuP6iDTJkMqseyqWCYfyx60PTzaD6QVyc2g0nY1McPzCFNTGIkNHt5gnWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqlwBmLDLeBDXs0ZtxEyEzLkyKFg2cP4b+QH0Smi47o=;
 b=fO6gfptALFgGSJeHlWbqhXrjtl7nLFWcDl5egVstq2QPrxjF23VzDie53bs59I1fBKBzjb4cRrUYoQMr4bjJdNEbJMpqYTo5bL+wrfoZyZo/DS7MYxBgpmNiCyn5pvH9btMLeedw4divhyrConwZKUdNR/Ucxga20mvs2DDYuhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW3PR12MB4458.namprd12.prod.outlook.com
 (2603:10b6:303:5d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 11:57:28 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246%7]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 11:57:27 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 "Somalapuram, Amaranath" <asomalap@amd.com>,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220117063343.27896-1-Amaranath.Somalapuram@amd.com>
 <12d7152f-3274-a250-e25e-6144cc9cc1e2@amd.com>
 <DM6PR12MB3897D77C82314BBBDBE8AF93F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
 <5568c4e1-7bc5-cd7f-d6d7-92a4f920c40c@amd.com>
 <DM6PR12MB3897D33226DBA88264B5BBF8F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
 <62372e77-31c8-211f-0d9c-01a0f880badf@amd.com>
 <779d4778-6b85-2769-f169-f5f9e956a671@amd.com>
 <10fe91c4-9078-8937-5dac-0625d38c2ea3@amd.com>
 <7a082b06-179a-22dc-e176-3f6d46a1deeb@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <8ffbf71a-9c62-b153-bf52-a88e7bcf91d3@amd.com>
Date: Mon, 17 Jan 2022 12:57:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <7a082b06-179a-22dc-e176-3f6d46a1deeb@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AS8PR04CA0031.eurprd04.prod.outlook.com
 (2603:10a6:20b:312::6) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0631f501-1b78-408d-f8d8-08d9d9b087f5
X-MS-TrafficTypeDiagnostic: MW3PR12MB4458:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4458AF1A0F96221D3FFFE6AA83579@MW3PR12MB4458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhrvI5Tvmamtvg4EG/M1sAttxEogJwgRNkmRjdafDcQoxyk22EmOWGH4kclDB/3LaQRjNDGlsJV2II9fi039/8x45gDU+j7XJaeh4w1TmZaXm8Pq9ymXHkvXx/Q1jjCchBw0fvTvf0B4gIV2atWISCOJh6gQypPeJIRXHwm/AtfkjxzK9pJmCcnmP2xUYgmlPIDMsJmNJ5iBKICDN6O9nqfwuGW+eWbs8pYjc1hB04xfpnNv+2kDQexHkIRSSjlMYq4V4QrD9kzXHd0MeqsU/3k3eq3O4M02EC/r5qfW9MevBldIa4yc825Ub9J2/xi9ItV04WthDWspT0XhUtz3ozE+qDQy6U4y6r8qqGBJnp2p4T7QMq97f8CxSuQbSNuX2DrW94wM5UlI1RuuVl3T9mmOjdhuecJYwnfR3Z/pw1G4KTyRBjU8LttGRxBtG/WY+OUTXVzL7Rn4Yl1e+uW5kAN8/5zwzvh23A8JR4oWJIWa3gYMEu0/fgod1QZWxqbrEK+0BQcjTQzRpmE6YHt82VMO6hjD2ZBAblpSRbxliPbcPshE9sscmbjTgSDoQo4wkOhkb66YXJ+ws7248fPEoXC83k8CWzfD+7DlLpCUlbb+fsOunPWzN4yCseSpxxG+8D5a6YUF6FfZ6tzkNJP2BT4wta/tToMgiUSr/L7KPBPrU5OpHeJ5xtDKH9xAN37EDN0epKab0HWbKX3C1/9Wlswdvv9EiAIc8r8g4hur7DjCTE7tViBCQqkjk7Txz3PG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(31686004)(53546011)(86362001)(8936002)(83380400001)(110136005)(6506007)(8676002)(2906002)(66556008)(66476007)(66946007)(6666004)(36756003)(26005)(316002)(38100700002)(6512007)(5660300002)(6486002)(2616005)(186003)(508600001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmxNeUQ3eVVVZ2dIaHFqaTVBZlQzaFVPT1JTSHZtekVUTTJzSkdjQUtaUzNu?=
 =?utf-8?B?QnR0eTEzNFMyNUgwNEZNSzFWaDVMTGRIZUJ4OUl2WEoyUko1UTltd25XRVg3?=
 =?utf-8?B?cklWWEk3ZCtVcTFha0RmcStOSHZjbGlUMElZbkhEQXlHWGsxdFc1MGJEVTIx?=
 =?utf-8?B?YUxTdHpVdjJIci9tanZ6c2lVN0k0b1lGbkcrcDJBRVRIV2ZvMkR3VVJNbkNV?=
 =?utf-8?B?UER5SjJ1N3Q3Z0NCeXZjemVhTUJ3dFNLOXpYMVZzbENWenZQajV3dlk5MWMw?=
 =?utf-8?B?Nnd1bU13WWFKbXhjOFZwdTdiV1FuS3VQc0EvSjBvd2xnVkRTc2hOQVcza3Vn?=
 =?utf-8?B?Ym54OW9IT3VkRUxFY2Zhc0ljUWN5Z0V5bENvclYvZVZxMmM4dE12S3NKTFBo?=
 =?utf-8?B?a2ZWWlA2MHArTFI4M2pOakZWd24zS2NmMmhwcGtkVnBvaHA2dDZ6V1p4S1hi?=
 =?utf-8?B?eFB0S0liR0M3a2p3MElwK0NZcEhhSmpyVHZYbk9STmlMSzRXRlFJOGFNOEdK?=
 =?utf-8?B?Q2ZhVHJENjZOdjRVR3pmTFVLOXR0cVhTTUNQbTAyQlJJeU53N2tjb2sxVjZ2?=
 =?utf-8?B?ODFxM3hEUXFPbW1EdXdKSGR0RUVKcWYrTGcxUy9HY0hMR0JaMGUzaXU2dU01?=
 =?utf-8?B?S3IvNkdFNDNjZVlOb3F0bmhhQXkvWFBDRGFOZ3BoQ2FOY21OemFlQTRCc1ps?=
 =?utf-8?B?c281RC9IT0lKTjNIUEFqSDJxSTFsRjFGaWpiQkhwc0xxMEQ1azVBZ011VHlE?=
 =?utf-8?B?M0U2bUhwNzVILzBrc0Mvaks4TFJ6SHpOakZXejAxQmpoYzgvMlBVNWVwWXVw?=
 =?utf-8?B?Tkl6aGdrZmxNVzRacXppbmF1MnFVR0ZsWGtndllzZ1NSZ2czTHpLNmtKQXZq?=
 =?utf-8?B?eE4rQmtvRHJvWGVVQ3AxcnVvVFZ3SFF6SG5PS2FmL3ZRTzNYRjRPQ1IyVnJH?=
 =?utf-8?B?bmYyeGFzQVFKZ2xMMExSMGRwbE5qWkNYL295ZUQ1bXZpcFlESi82aEVJcmFz?=
 =?utf-8?B?RDZFM0UxUWl4aHhzUCtyS0Fqd2ZpcFFRalNvMC9FN0NvYTVNSkxlZTVFRkNI?=
 =?utf-8?B?OXVvOUFMcG5UZTZySzhzb1ZoMVFpTjQ4SVYwN1pJYTZ3WFpQSWp4NEQ2Mnp4?=
 =?utf-8?B?cXVaOVduMUVVV3pRSWVVcERBR0hvMld1MWJvRjZEVHZVa3JTOEJQaytVUTZD?=
 =?utf-8?B?VFdOZ3BBTlBGSFJzYWFGWXV3dkxQVlNsZS9talZGZkhQVE9POXh0M2syc3J4?=
 =?utf-8?B?K1dDeURaeVJKbFhMT3pYZGtsYkFKTkZKblJOalBzRkV0Qk1qUzJmaFZJanc1?=
 =?utf-8?B?bExtMnBjNnFGVCtwUy91eStaMTRQZlpWaFRZc2EvRFVTZFZzd2gxRGNWc1Vi?=
 =?utf-8?B?V1JMZExLa2NKK2N0UXM0OEhMbUZWekdQblFRdEo1TmZPUTdEWDRwNGNMbFNO?=
 =?utf-8?B?ZDF1R3Jhd0V1Nlh4d3FsMWwzbE55Q3owc0dpQzVneTR5Y3RPMHc3WE1lU1RR?=
 =?utf-8?B?aTg1M0hnK0RReERZRTh2M0xIeWExaHdyZjJwTG9VaG9qa1MvSmhDNkF0Y2J1?=
 =?utf-8?B?NE1ZdmN4Nk1JZlNaTVRyZEg3cTBFbDZ4NFVxRk5XcVVIWVhGdXJ5NFF1R1Fs?=
 =?utf-8?B?RFJLeWIwSERZb0E1aGVrWi9WSW5QVjBKRktpNmIxcHAzdVIzYXNJSlRTY0Zl?=
 =?utf-8?B?cTdld2ZMcUt5NzBaZCtxRFVia1VBNExMUU1BSW1rWUxtU0RPOUdRYlhuaXQv?=
 =?utf-8?B?QllpYjFDRXR4ZGxtcE9manZDWTlkR3d0THNVNmgyRE5tYVhvaDU0dkpqdkdk?=
 =?utf-8?B?U1EyL3ZweGVvWUlTUEhMaEE4bTZBSVFRY0l4RUp3NW45ajZjankzOGdUVy9j?=
 =?utf-8?B?NHdFQzdRYXVnU0pGZTNEc084N1JtQkpsaGVrU1VId2p3S0JOYkJGWFJUd3ht?=
 =?utf-8?B?NEpTcFVibVdRbEtVOGFWWXpxdEY0aEFja2cxc3dXZ3RQRkVta3MyaWRVWkR4?=
 =?utf-8?B?Q1o3Z3ZWVHRsOStzZWNLN1cvTFJiRVVsbGNwSU8xZGo4NmhuM2V5aUtCNHVP?=
 =?utf-8?B?OUpjcDJNM2tVdHgxMHNqNk1qNnJUd3BrMU40d3RpVzFRdEJWY0YzbDdnUllV?=
 =?utf-8?Q?8+eU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0631f501-1b78-408d-f8d8-08d9d9b087f5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 11:57:27.2369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0HVqLVaU/n6frb0hB5PFw1EoNd5QqbpPcDcTLsARmtxdwkNtM74BREmoCicovC0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.01.22 um 12:43 schrieb Sharma, Shashank:
> Hello Christian,
>
> On 1/17/2022 11:37 AM, Christian König wrote:
>> Am 17.01.22 um 11:34 schrieb Somalapuram, Amaranath:
>>> [SNIP]
>>> Any suggestion how we can notify user space during this situation. 
>>
>> Well trace points should work. They use a ring buffer and are 
>> specially made to work in such situations.
>
> We are anyways sending a trace event with data, but can trace event be 
> a wake up source for an application (like a tracer) ? This DRM event 
> is just to indicate that reset happened, so app has to read from trace 
> file.

Yeah, that's a really good question I can't fully answer. As far as I 
know you can filter in userspace what you get from the tracer, but I 
don't know if you can block on a specific event.

Christian.

>
>>
>> Alternative would be to audit the udev code and allow giving a GFP 
>> mask to the function to make sure that we don't run into the deadlock.
>>
>> Another alternative is a debugfs file which just blocks for the next 
>> reset to happen.
>>
>
> - Shashank
>
>> Regards,
>> Christian.
>>
>>> Regards,
>>>
>>> S.Amarnath
>>>
>>

