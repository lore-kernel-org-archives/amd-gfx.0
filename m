Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D3606A884
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SZAmGJOv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9BE10F012;
	Mon, 16 Nov 2026 15:04:55 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F19BB10EFD5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 15:04:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XydHr15OXQ4j4ZASbjMfhSmH6FP9C28AX4raM6qfhU4D6U/PM8b060WIQgdtZaG5yj3NSZGbUoTpooSzNJar6AZjxjZxgqmcN2kE7sPx2tHPDg4jVGfqFn95gYeHPODQ1+KGWe3POLeYO+MJRfPn1uSKZqgx8TwSUW8q5+GLqthm5q3BJuc4xyqYs94ZMoXgIvOGrFB3AorB4Odd67yW0CDJLIyZ7JSEQvx48DeCNGViCybKyBnH83sAYvcK+4RSoPoe9F80ebFNXo82IcEK0sIUv364gjH0T37ZiZchtp4xwa2POp2AM8rGD14UDwxhDE1Id26QGPZ+EU06XGEh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3kmWR4VRRJ26z07/ImQSkJ8WR0u8BhGPRDOH7oP4Tg=;
 b=uEQL1knJFX8rP7cePZrjcvPr1WVO84Su0qqcEsWbPS0lcnh6IILmA85ITIIP9CA17VgkLkk6vnzSc+WbBy4yjk0u4sXU9ENbp9C3LzYSjwo0sFSVHT893/8x+DCCLdeG2DJC9l9f2/ziSz/gxO8DQjNEwGaUTpMP4sz/ryFGCGJyvoeCYJaZAeim1Lx2HOvsVsm1d0o3fH52UkLoUxO8FUN5Y4o4XP6ecPtGwVyFPZs7l2qflI3TcltVh9Oe1kF74fRPUlf9jqyPhlFMuvsv/x2fcWU19dDiE02bozAwfwRM7zUSZyCQ2z3RQzdhPhEuSsuu7oEMTVrYynAFx562EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3kmWR4VRRJ26z07/ImQSkJ8WR0u8BhGPRDOH7oP4Tg=;
 b=SZAmGJOvuZNGgM8kAHaeZMyQxXZqlRnS++nipykfGeHagGa2yK2F/nU5Ipxkn3Z67v/R/orjgSoJvoBLv2X4p3YlEe28uuNJPTN8ILNVkH8SHFCDK4gN2a7uTTLhv+kpZ4KRBa5FFhwD74dmbSjfLAcR8D1OxpIoDO2jyiraiyw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB999088.namprd12.prod.outlook.com (2603:10b6:510:38d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 15:04:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 15:04:47 +0000
Message-ID: <835ebb0f-126c-4d30-b5d9-14f1950da83b@amd.com>
Date: Mon, 16 Nov 2026 16:04:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: drm/amdgpu: Patch review for gfx hang on submitted jobs for S3
To: "Thothiralingam, Logatharshan" <Logatharshan.Thothiralingam@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Perez, Randy" <Randy.Perez@amd.com>, "Chiu, Michael"
 <Michael.Chiu@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <SA1SPRMB0073292C113C6B98D9282092F87F2@SA1SPRMB0073.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1SPRMB0073292C113C6B98D9282092F87F2@SA1SPRMB0073.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0351.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB999088:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f27b600-8dcf-495b-54a5-08df43f2f43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|11063799006|56012099006|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: jUdBBsWynQJlIcf5oru4j+TutXsB41jwCDjadBKY+c27lpABQ6ijqyXV4zxHoi6c4EBZC21pkx12N/+QG+zdksT/KEqi0iDWZ7B7hxyCSummh1Mmpi3U0wlUmV546uFnv1MPUKtIFoWyXQp/iFiIgS0J8g6emP0+7qdqC3KFA0vhhWz/M6qP6avZsF1UPKoX1bT8T29enS7qF6Ww/dim1NwIsBvTgrUuYStyxxuuGsnNoCDlzasyVDJ7ZOsx8vQ0kQFHQLinj9ilqMmJytcrRoZ1amD/BoXidVKWl5iocXvCzQkjU+CEAC7Le0CevrwRbIQYuiaTcJhzvY7I9fGdoG1eTCfqST72YkeV9XxBEX+I8mEWXEuH6eBjBv87su+FTOqgNsxWS+XOB8rgSy+AEbSjXVFPGv4RwKdmkRX0llg0F3hJDT8nrG3zOFAdHAjvk+K1R77lJBaCvs1ENd4F5R2ye1axHWrLOk9UIux6Ik9EDF8/HpL3L2H/TZsWm7yfeA5D7MQKR4kBI6FHVxjAGdKbPGqZ9u7JdYSgO5IZ0JCs2PZLlpqxzjAZs8hC+qJz/YcNxMsDcUUdNDakhtzPHVlFYmOCPNFq9OB1Tc9N01E8YZsYI8aCOnA3b3/duZL+NSBcaCzeRoIp2e6HeA0TTkfW1JNv/2SDRmWXq4nUJFQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnlCWWoyS21IK0VKeCtFc0dQcTdzbDdZT29YbUEwT0sxQmsydzB6d3ZkSWVY?=
 =?utf-8?B?dXYwWVdNdllSOENwWUh0MjBreGxTTzdzVFNLcnB1dlNyNy9vUXU4cEpqUjMy?=
 =?utf-8?B?aUFOZkgwYklZZ1JNcWFuTTNxNUsyUE9pdmdCaFRGU3NtelRxMUFnMitrR2F4?=
 =?utf-8?B?amtXMVVXZHk4UXplTFd3ZTNaSmhMdzBsNUpPc2FjZTRMd1ovc3JrYTdrK2tD?=
 =?utf-8?B?cU45a3JrQU4wRkI0eURYdzlnQ1d4UTF6NmV4YmpsTjl6cXJJRGV5bmczMDE1?=
 =?utf-8?B?eWtrZGNDdVhTSVR2RkNrSGNnQTl3bGsrY0RGU1VKUWNKamNtemNRUXRudDZk?=
 =?utf-8?B?dkwzUk9oWk1FbEo3RHRaaW5NcDhmL0dTQ0NWRmVnQndWUnQ1NUpZT2k0Q1B3?=
 =?utf-8?B?VlVTOHZ3ZFBjdHV2YTFFS0sxV0tKRFFmc0FBYVpMLzJxVGVtbzhuRHJBQWxS?=
 =?utf-8?B?TzY3NzAvcjZuUkhwdzhPVGZacnk3S1ZBcVFtV3czRGs2VHE0cFBXYWZvWWp5?=
 =?utf-8?B?TXBhbHh0UDVNL3NnYVBEUEVLOHM4RWlJcVhURW02THkxLzRQWEVDNUJxbU50?=
 =?utf-8?B?VHNDS3FVRGNVNFljZVZxUE9lbkllNWNwdUVoWEtnZTdBUUozQStLNzJmT0Rn?=
 =?utf-8?B?OThaQ2hLL21uai9NVWVSdDN6M25ZcHMxMlhqaU8yTHh0TFZUWHZDMFFia1hU?=
 =?utf-8?B?QSs2YkVQWEU1N0lLeHVJalhSNWFCalcyaytWTFByVGUycWlqcUZEd3B2RzVl?=
 =?utf-8?B?VGYyc3NJV1N1SEVjcHpmMUxvclRzc096emkzYml3YkFlalg3aUlpYUpPc0Vp?=
 =?utf-8?B?c2JCVXlZWm4zM0dRcTZMd1JzQkhKQk5kcXNJZ042ckdabzMxQmtGdVFJVEpD?=
 =?utf-8?B?dVBQcXI3eG16c0NXbXEzblB3dWhIZTNzM2RyV0hOdkp5OGRQbUxwWGwvNUd5?=
 =?utf-8?B?cUFSQ285cHZ0eUs1dGZjMzRpdkZnWndUS25iQ0UrNlF4MzdjbnhYTzFaMUI3?=
 =?utf-8?B?MDZzdS84bWs2K0VlVVg5MVhNYjRscnJmVkw3TEI1REV3eW9mSC9UbHFsVHFY?=
 =?utf-8?B?M0RnQWVZVU1oMUVJbW5EYXQwcFZ2VHE0RWtuOWxtSmtLNlFUT0hzb21VM3lV?=
 =?utf-8?B?Y0NVQmRkeHBPNFp4K3VSVUNtVkNCaGFLd2M5WDZOUVNYRFhXdERuS0RKQTVs?=
 =?utf-8?B?UGU5TkV0RHVXMWx1VDJlSWpTSlljUTFlUkNCRmFkZEZEWlVCVkY0TnRoRXVK?=
 =?utf-8?B?enYwVG5XNEJXYnp6QkdEWHJ1dmlvRlRQWFQ4UHgvZlpOSWlHeHp4ejcySHNI?=
 =?utf-8?B?YnBmcnNPNGg2b09hZ3M4ZFc5UEVLa3dXZlJNVXhRRW5iWUhqNlpDdFpJNTJr?=
 =?utf-8?B?R09rTHVDbExtWmtVMldSYzBtelBBaldqQ00ybTQyQjdaUkljWHFQVGxFMWZw?=
 =?utf-8?B?TWdvNlJ0V0pDMkR6WnNJL3Nta29aQnZCVC9EQXg3VlpNUkFiSGJuLzZwbU5u?=
 =?utf-8?B?cDdxdm5pNUYrQnNZK2traThwWlJTbWtRa0NXL3V5cHl6VHdsVW1UcmdZbjlC?=
 =?utf-8?B?aW1xWHlSS1VBVmNHaTYybmxHU1M4ZzJiaFljZDRkMDBJcjZ4NDk3VnFtWWJD?=
 =?utf-8?B?Qk0vN0dKdk1URkpyZHl6UmY0YUxDSU5VTmgwYWluSFU1Wk8vS3ExaHZVMERO?=
 =?utf-8?B?YVZCTURnejZMei9uZnFlc1JQWVdhKzlDbXM1aXVBbm9sMVJGR1owY1VmaGxS?=
 =?utf-8?B?SUdYZHRjQ2UrdUw3c281RWhVWnlJek10WjFOaXdIeFRya0JWeXlCWXJOT1Vv?=
 =?utf-8?B?bmUydjRFOGFiam02cmN5M0syWUFoTHdoaXdvc21EUzJrTWpSdVEyNWhWUXFL?=
 =?utf-8?B?dGhCRVVqZHZ3enZPMzhWQm1JMi9Bc0RxQVRYVUk3ZDNVYWFyeUJpelRsa0dL?=
 =?utf-8?B?aVZoTWxFWk5LL3VSZ05QY0hqbTB6T1haNlN1RWFLaTdGNVhHMXNqRnNZYzdD?=
 =?utf-8?B?Tll5WE9RWldhUGc2UVRSVzBLeWw0amZDcWh1dlpBU1BMSGN3Rk03NGNocGhE?=
 =?utf-8?B?WEtaU1BkZ0VRalJGK0RIUGU3dFRnbUhabDdjY0ZQUVFCejN4b2NFNGFYWjF1?=
 =?utf-8?B?ZTRyR0M5WEQyYzdIWTlJYXVpYndSdHFTeGZ4dWV1MDJJVFNxR0trMnJMQzJ6?=
 =?utf-8?B?Z3RqajFFQnZTVDI5MjNVMDdGejkwYzI0b3FHNStNVUxveDRIY0dXK2dIbmtk?=
 =?utf-8?B?RnZNZE9IdnpuRVhzY3RTVzdQakxtWjhYcElkRmZOc2JSa1I2cDJsa1M1WGJj?=
 =?utf-8?Q?lIHanV+XxtY4fZpJVL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f27b600-8dcf-495b-54a5-08df43f2f43c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 15:04:47.1578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJkmCXn0Dz+Hl2FU1ssHJ51q3FTI7hRmuN6j4GSw5/rytN/Mh3vzbRGmwnwUFeQi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999088
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tharshan,

the idea looks good in general, but could be simplified a bit by waiting for the VM to be idle.

Question is why don't we already have that? Or do we already have that somewhere else? I'm pretty sure that waiting for all submissions before S3 should already been implemented somewhere.

Adding Mario to answer that question, he has been working on suspend/resume quite a lot recently.

Adding Vitaly to double check if we have already a test case for that.

Thanks,
Christian.

On 11/13/26 17:44, Thothiralingam, Logatharshan wrote:
> AMD General
> 
> 
> Hi,
> 
>  
> 
> Please help me review the attached patch.
> 
>  
> 
> A gfx hang that occurs 2 out of 400 times when performing S3 cycles. The issue is seen with the kernel version 6.18.8 and on AMD hardware; Picasso gfx9 APU.
> 
>  
> 
> When going to S3 suspend, the driver checks whether GPU has completed its tasks, but it doesn’t wait for jobs that are submitted to the scheduler. As a result, queued up jobs slip into the ring and are lost when WPTR is set to 0. On wake up, we hit a timeout followed by a hang.
> 
>   
> 
> The fix is to wait for all scheduled task to finish before going to S3. I tested the patch and the issue is not seen again.
> 
>  
> 
>  
> 
> Thanks,
> 
> Tharshan
> 

