Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A3CC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 21:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5446C892C1;
	Mon, 13 Jul 2026 21:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="thfWdgIX";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB0DF892C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 21:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2LBP1hqML/LG9B+IwqMK9TF4Mlw3DGoxmnD8idzRFiWjwjeVYhxjAghaM9kzCrWNYGczi0IKsJAyB05UciVbJAXDhAhPClN6p7j4l4/Y1zZLNQkqbXyh+K8g2hWWLTVPKPJvFtn8sqCItZDNhJeJe8r0n0Gf6ZEPL1aBL+2z//c3R061zqQY2fFgLGY5ZVScAWbSsTZjSUvzz5+CvVJFomxDB8kzV9PbMvmNwYoTsHhYLlW98gAqrhlFIpdRjXXnf/Hou8j9ECK0zMZzHWZRnDPK+2AdzkzzZjvkR8NNUg/mtdlee6D4WCV2RwAoOKE4oir4bBFNgLWn0uGSk3Iow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHbrN4l5gZeAF1t6rbfOryzWLCXM049KMB20pOJR9EY=;
 b=zWmxBI5ZSdDJQy5TiRMvaFYqPWBN78Xe2REhQc3YGypZkqnUR9HhWu+o/ddIfVvAW7xvjRaGSwqvAKQlKiomRdz9QX/2peygqJpi2RiQaKioyMZdkomrVkbDn+dKBaXPhTprby0dIWpG7JqQpOazlL3A3jV6WrooHkBjoJwyhlGGQktNOdrrY+KwNlJWYRmWMv/hzIPThQLmZ0ly3jX/YRUQyzTyDVPNUVhVWCB1/LptyV0LDA2RyL8vR6JIsa8hhuJlepf4Ow1Uld+GCZAhXu1ZkGTBWlv/szjtyMQgSpXMQHGO/1+rKXZf3RuvZ+4DVR+aqe4WD3lLKpEPttIoQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHbrN4l5gZeAF1t6rbfOryzWLCXM049KMB20pOJR9EY=;
 b=thfWdgIXuiSFH3AOLu34xo2MxsAKC8JY0UZIdnub9VPoZte4kSJIb3apjxnTiBsUsRCJ+szT6HjFmyizBFHbvATCbPkLaStiBVTyF/GcYEyldJ/xV/N6tKe0pgJbVuvEl0MUA/mXfjefzQ05WRE45OzfToHZCgBs8mtW48+sZz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 21:46:58 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 21:46:57 +0000
Message-ID: <190b019d-d8ba-4b5a-b337-9043f0f96b3f@amd.com>
Date: Mon, 13 Jul 2026 16:46:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Create a device link between APU display and
 XHCI devices
Content-Language: en-US
To: Mark Pearson <mpearson@squebb.ca>, amd-gfx@lists.freedesktop.org
Cc: Aaron Ma <aaron.ma@canonical.com>, mrh@frame.work
References: <20260713195313.1739762-1-mario.limonciello@amd.com>
 <e3883839-e431-4ad1-aa01-b8b96c089e29@app.fastmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e3883839-e431-4ad1-aa01-b8b96c089e29@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:806:24::9) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: f677b600-a349-4d4d-1280-08dee12842e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: DzgvUASuw+RYC2yEYh1kDhoFcMAfOvakBwECrh2FiogPW9OcRiIkZwaKkChGeR0fEni15df2G3Er4trU/wJqR92IAhUAs3afB6RmrANWpWP0GGknQ2J27hZuLVWL9RunXgMmDOqpd4XCxcVS2mpBrYj75TGB0zUMkXLNZPXGlUiYqNOmOT5hezyD8pWxiiAfbBqLT/O1Ax4vW3gO7ATkIXZxwOHgXt2Mri6hf5VC32FdgxiMnPiBZQjNX1LVGqmAzXQErwe+nq1VixBp3GnAU37wstx9yyUsI7Zse82iCpKw0kNZDeKInP20s/6IhpKPfKdFfFv4sF6PvkdMqDx7KF9PilpHy/XRKmJpz1tNGKcTtrDL7qzpMbiMMYlHopJXkuE+0/XoCT/jh2msHv6X0G3oAJbatMoFGUWUhTpDrzGzJSyeFBJxIC8RVSS51dbgy5RNvZ+taAg+LZc/THUc+9PQGSVIpJzJXIfDFO0pLufPLKB6JFnb82xfdbYRQT71lr93NOfupGOVJXTXf8cMeeshRu35xKy0NKLVHAg4KD3JO/x0J4uB3VnWFXFYk+FOQw3rzJLUxBLB8dG4/M+jJLGCoVhqn1ZQPmW0viFIJcx63yeUhHjhMYB/maS4i6mbMEVjPfz8avFmyOkszXxtgFCK7ZyWA7MKN36dSc3zvhQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWRLTEdSR3BwNkYrbmZMOG9DL2twRFJGVUIwLzBmUGYxYU9mREY4WU5keVd1?=
 =?utf-8?B?R0dta1BHRmh6STVkOFhJa3F4UkRTMTd0YWhGR1dtMXVBbnY1MkVDTmwyM3Rt?=
 =?utf-8?B?U2ZoYWJJWFk2NS9nRUY0QzA2U3JDYktlNzhZOU4rSjZ2bmRHYVNrWU1JWDB3?=
 =?utf-8?B?eTNVQ3locVZ1VFpXemFIRVJQMHE4ZCtXQ0NPNDNmRDlXeGU3VFZzYjBMNDJs?=
 =?utf-8?B?UU9meXZVcnl6SWJ4cm1COXRvUjFvTmQ4TDlsdnVHTHFiWFpmSFJIV3Vxcllo?=
 =?utf-8?B?Vmd5aFNIUEp5Tmt4VUdxQ0E2aEhNZ1RuUFVtTnlEMTV4Q1NOTVZYWDBKcXJE?=
 =?utf-8?B?UVU5L3R6RnpQTnJlTHYvY2VOeUozdU1xUDkxTHRBN0NkVHY5cWc0bjltRW5j?=
 =?utf-8?B?QW5iMzdRUnV3ejFHYWQ2YWNEVTNJV1E4ZFg5bkRoakp1ZHdnVXJNOWpCMXRr?=
 =?utf-8?B?QjJKSFNINmNTQUluVzc0N0hZZHFERktkaVQrN2M1a0kvWnEzZkFkWjhQMkR4?=
 =?utf-8?B?R3hnazR6LzZLdnVmMXpCU2FXeUFYV2xtVE9ONDlwVHV4ajY4UlBUMTdiY1Jy?=
 =?utf-8?B?cnRxV2d0LzhNTGt4azBoUWpXM2xyck9UajF2UlhwdXR1THdaK05BN1ltQjQ3?=
 =?utf-8?B?R09PbVNzZVhMRVRhSTRxVHU0SGRia2FPckZlMVphUTI5bWg3QmVIWmVhaGZu?=
 =?utf-8?B?bEpUczZEYmgvN3VTRGg4L0lPbkxUUmZtSXg1eTQ3MHk4azZ6ZXdRdmI3enI4?=
 =?utf-8?B?TUpTRVlTc0JLVDZoQU1BOEpGZ3ZKbW91OVptc3k4R2loSVJ4WVR4QmttN0VL?=
 =?utf-8?B?R2oxcWd2WnlQWU43czJFSFpub0t3d2hDYmR0aFNrKytSWkwrTDFiZHFveU44?=
 =?utf-8?B?OXhvWnVVdUVic1ZZcGRtSUFpVzBaRHN2bVV6U2xJMVFkaU1ha3hlZTFzRTBL?=
 =?utf-8?B?R2tDd3ZHZEhhc0tORC9VWGxKb3FmQVR6KzlyVHNPRDdFWU9wNTZsM0dVUTlX?=
 =?utf-8?B?ZjkxZGpiVDVXdFN5dkVJTG9WZkVkbXBxN1duT1NxRW9UM0hBUmluQURMSVZZ?=
 =?utf-8?B?WHVWRWtWck4xYVVHVVlldTRob2V3eUlVVElpRzNFaHNwaGZ4dDZna1IxZ21J?=
 =?utf-8?B?TlNmUFpGZWtaTlcxMFQ4aVZHeitYQXRNRVAxM1FadjRRQ2hnOTBIWUZZS0NV?=
 =?utf-8?B?L29POTY2OFhISHhUOUdxWW1JRnJaK3d2RDBzZW44ZXBLMjRmSVJ5U3I5dVlK?=
 =?utf-8?B?M1BJQVFTZlUrQ3pub3NVTHArNHg2M3FZOTVPOWowTCs5aFpTN2FSRENPdXFa?=
 =?utf-8?B?Rkh5dTNPQ21NUGEvQVNHZlAwWERNQWtqZGFtenJMUElvY05UcUFQZEdWZGxx?=
 =?utf-8?B?cnBHN05IckpwMlhJVGtBZGpJc1BhRjFTSEpCNVM1Q0FJeHNIVENXZVY0UVdu?=
 =?utf-8?B?Vk5yWnF5bGp0aHgvWGJhUkwxUGFBdUpFcFpKdE15YytSOW9GT1ZJVXlyaUJR?=
 =?utf-8?B?L1ZCalkzQ3VMZUJhSFlPQjUzMlhONUtLcVdTZzZGdDJ1WklQZEsxelduYnV4?=
 =?utf-8?B?bkQ4c09waGF0Sytudm9SZ2dJWHFvVkFDdHNXZmVnZk1zZ1N2WmJCNU9hOWVW?=
 =?utf-8?B?K3V3YWl6VUhJa01GSGI5UWFWVHlTbG11SHZ2RzBKUmgvbE9XN2kwaFZvbzB3?=
 =?utf-8?B?Q2RJMHdoQnhlb0dybFZwaGU1a2VpdlMwZ3VMcGZQVzZaeUFrMEdoYU8vbEZu?=
 =?utf-8?B?SERxOU1ic0N5S2pPU2p5RjM3WW9HcmhBSHpXR3g2MkphOGYwVmkralpwSGhH?=
 =?utf-8?B?K3hYRXVsZkNUN2lxc2twekpUUmxETzNhV3Y5M2prWVFmdVd5N2oxM1ZpWGVH?=
 =?utf-8?B?YU5QSFBqN1hoaUdBWkRWYWtZb3pzbElJSkdSQVF4cjBkNVRXK1Bvd2ZoMUFW?=
 =?utf-8?B?SnlZbVo0eTRmbVBTTFNGbTNXcmFzbHVabk5SQ1B3NittOXVCZUVaSitDUDdo?=
 =?utf-8?B?TWRiOGJ3SEE1WGhVQnZMUnRCMmFDQVFZdXM1TlcvMDByTU9iLzl5T3BFbG91?=
 =?utf-8?B?SndpQmh5V1VpYVJESW9TZGM4NW43WjFTRnJPS1A0V3VXbVVEdWxrVTNpOCtC?=
 =?utf-8?B?WlZDdjBUKytrUW40VEkydTdaNGZOZmNzSHdCU283WktLbkRlT0RXOEhzblhl?=
 =?utf-8?B?aEV4VjJJaHdrV1VXZmpGMW1rL0xJSUtaZUlsMEFTbS9zakF1WXRZSXlaQjBh?=
 =?utf-8?B?MGJyRkhaTWZ6MjdISno3Q3lWenhRcFdjRm5SNzZMc3Y3Z1JPVHh1QXhRMHpD?=
 =?utf-8?B?a3NReFJNRkZncXR6c2huQzN6RDVqeXM2dVVDNENSVDl5bzQ3dkZNQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f677b600-a349-4d4d-1280-08dee12842e9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 21:46:57.2958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVlUeUZBNlrfSwyS+/PDZ8UQkZIMh7KuGOym17gRxDIJOjJaKPCwctdrUWPXKTL71qC9FrkdkGA6B0NBEiWxQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322
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



On 7/13/26 16:32, Mark Pearson wrote:
> Thanks Mario
> 
> On Mon, Jul 13, 2026, at 3:53 PM, Mario Limonciello wrote:
>> Some AMD APU multi-function devices expose an integrated USB xHCI
>> controller. In some circumstances (such as larger VRAM), the PM core
>> can resume can fail when the xHCI controller is resuming in parallel
>> with the GPU/display function.
> 
> Minor: extra 'can' in there (before 'resume').

Thanks.

> 
>>
>> On affected systems, the xHCI controller can complete pci_pm_resume
>> and start resuming USB devices while the GPU is still in its much
>> longer resume path. This race condition leads to USB device resume
>> failures followed by:
>>
>>    xhci_hcd ...: xHCI host not responding to stop endpoint command
>>    xhci_hcd ...: HC died; cleaning up
>>
>> Create a device link from any xHCI controller sharing the same PCIe
>> root port as the APU display function. The link uses DL_FLAG_STATELESS
>> and DL_FLAG_PM_RUNTIME to ensure the GPU completes its resume before
>> the xHCI controller begins resuming USB devices.
>>
>> This device link is done specifically in amdgpu so that if the
>> platform firmware has been modified such that this issue doesn't happen
>> the version can be detected and the workaround skipped.
>>
>> Suggested-by: Aaron Ma <aaron.ma@canonical.com>
>> Reported-by: mrh@frame.work
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221073
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 12 +++++
>>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 11 +++++
>>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 45 +++++++++++++++++++
>>   3 files changed, 68 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 4314dff4ac996..c1ceec7a1986b 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -1366,6 +1366,14 @@ static void smu_feature_cap_init(struct
>> smu_context *smu)
>>   	bitmap_zero(fea_cap->cap_map, SMU_FEATURE_CAP_ID__COUNT);
>>   }
>>
>> +static int smu_set_power_dep(struct smu_context *smu, bool enable)
>> +{
>> +	if (!smu->ppt_funcs->set_power_dep)
>> +		return 0;
>> +
>> +	return smu->ppt_funcs->set_power_dep(smu, enable);
>> +}
>> +
>>   static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>>   {
>>   	struct amdgpu_device *adev = ip_block->adev;
>> @@ -1427,6 +1435,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>>   	if (!smu->ppt_funcs->get_fan_control_mode)
>>   		smu->adev->pm.no_fan = true;
>>
>> +	smu_set_power_dep(smu, true);
>> +
>>   	return 0;
>>   }
>>
>> @@ -1449,6 +1459,8 @@ static int smu_sw_fini(struct amdgpu_ip_block *ip_block)
>>
>>   	smu_fini_microcode(smu);
>>
>> +	smu_set_power_dep(smu, false);
>> +
>>   	return 0;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> index f8fd93999617d..7ea7c4a5279be 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> @@ -749,6 +749,9 @@ struct smu_context {
>>   	bool pm_enabled;
>>   	bool is_apu;
>>
>> +	/* Power dependency link from an integrated xHCI controller to the GPU */
>> +	struct device_link		*usb_power_link;
>> +
>>   	uint32_t smc_driver_if_version;
>>   	uint32_t smc_fw_if_version;
>>   	uint32_t smc_fw_version;
>> @@ -1618,6 +1621,14 @@ struct pptable_funcs {
>>   	 */
>>   	int (*ras_send_msg)(struct smu_context *smu,
>>   			    enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
>> +
>> +	/**
>> +	 * @set_power_dep: Create or destroy a power dependency link
>> +	 * from an integrated xHCI controller to the GPU so that the GPU is
>> +	 * resumed before the USB controller during PM resume. @enable is true
>> +	 * to create the link and false to tear it down.
>> +	 */
>> +	int (*set_power_dep)(struct smu_context *smu, bool enable);
>>   };
>>
>>   typedef enum {
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
>> index 2fe006de927a3..2abdfef8644e0 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
>> @@ -1701,6 +1701,50 @@ static int
>> smu_v14_0_0_restore_user_od_settings(struct smu_context *smu)
>>   	return 0;
>>   }
>>
>> +/*
>> + * Link any xHCI controller sharing the GPU's PCIe root port as a
>> consumer
>> + * of the GPU so the GPU resumes first, avoiding an xHCI resume race.
>> + */
>> +static int smu_v14_0_0_set_power_dep(struct smu_context *smu, bool
>> enable)
>> +{
>> +	struct amdgpu_device *adev = smu->adev;
>> +	struct pci_dev *gpu_pdev = adev->pdev;
>> +	struct pci_dev *root_port, *usb_pdev = NULL;
>> +	struct device_link *link;
>> +
>> +	if (!enable) {
>> +		if (smu->usb_power_link) {
>> +			device_link_del(smu->usb_power_link);
>> +			smu->usb_power_link = NULL;
>> +		}
>> +		return 0;
>> +	}
>> +
>> +	root_port = pcie_find_root_port(gpu_pdev);
>> +	while ((usb_pdev = pci_get_class(PCI_CLASS_SERIAL_USB_XHCI,
>> usb_pdev))) {
>> +		struct pci_dev *usb_root;
>> +
>> +		usb_root = pcie_find_root_port(usb_pdev);
>> +		if (usb_root != root_port)
>> +			continue;
>> +
>> +		/* Create device link: USB (consumer) depends on GPU (supplier) */
>> +		link = device_link_add(&usb_pdev->dev, &gpu_pdev->dev,
>> +				       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
>> +		if (link) {
>> +			smu->usb_power_link = link;
>> +			drm_info(adev_to_drm(adev), "USB controller %s D0 power state
>> depends on %s\n",
>> +				 pci_name(usb_pdev), pci_name(gpu_pdev));
>> +			/* Only create one link for the first USB controller found */
>> +			break;
>> +		}
>> +	}
>> +
>> +	pci_dev_put(usb_pdev);
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
>>   	.check_fw_status = smu_v14_0_check_fw_status,
>>   	.check_fw_version = smu_cmn_check_fw_version,
>> @@ -1734,6 +1778,7 @@ static const struct pptable_funcs
>> smu_v14_0_0_ppt_funcs = {
>>   	.dpm_set_umsch_mm_enable = smu_v14_0_0_set_umsch_mm_enable,
>>   	.get_dpm_clock_table = smu_v14_0_common_get_dpm_table,
>>   	.set_mall_enable = smu_v14_0_common_set_mall_enable,
>> +	.set_power_dep = smu_v14_0_0_set_power_dep,
>>   };
>>
>>   static void smu_v14_0_0_init_msg_ctl(struct smu_context *smu)
>> -- 
>> 2.43.0
> 
> Tested on my T14 G7 AMD platform and confirmed it fixes the issue (which I am able to easily reproduce otherwise).
> 
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> 
> Mark

Much appreciated.

Another tag to collect from Kernel bugzilla on different hardware:

Tested-by: Alexander F <superveridical@gmail.com>

