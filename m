Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83269C44520
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 02:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 192D210E269;
	Tue, 21 Jul 2026 02:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ms0wmxb1";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F4D210E268
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 02:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0cPhls4AI7ghPH1VXnNBNEmeG3vCHU4g9MCXfVlFK0ZE/atsoQezVYBjwoWwDqxFqbjMVwdxI7dGcGycbBbUBIRSigF8gCpp1bMcE/AQyEhJDRCb7UJdomYXFtdsAxaTEO6jXN0HzQ7TJ9Yuj53M5xvse5XhHaf9YcXuxvNq9KfYcR78Ff98RUW2dYE3fLY5WiBLhE+4APfbPs3/CLhIcPdk3xg61ReuXNAFsYV+xCf53wL3J9LsTCMPHmBx/lHgCJZSNrdHLuin4lrW9HWoa3GWVY3vYYZietyMLLGI/nLnQQvPDUsosU9Ag29wWfnsFFlKIOBRHOG5amdOoehqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwuJVI1zoT54TnV9hPfHMjOe51V23Y/92EwFJKR2pJ8=;
 b=o8fZY1ZJeIfZ4ky6VaLYT3+bS2apcRQ6Am91IEJLH8oEr5jHL3KiQJA1LtQhlRqdXKgmoe5TtxqPDXV5pd9JigauUu84bphhzqM7pGUii+PRq2UFVHKdKfdpRVeLL6nMGmtlGISbtoQ/jEql+QxZECXJ0WYI6oJJ0U1kGbMTLWf1N2RH4GzXWF0s216lAlIPND7MhMiXZYKmVuDpHJWEj6UBzfuY3XpkGGYN7W05HswwagqTA3VCNLFe9c/tGoSQgvN6iJau9m7hPx2xqcod0sXrvapxsHoVJo8FvM94yY7qPAC8kuB0o8u30z0hxrbcBT+YcGt2snabjed5CK2w5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwuJVI1zoT54TnV9hPfHMjOe51V23Y/92EwFJKR2pJ8=;
 b=Ms0wmxb1qnvZOBadq9cidYkFR8k0wcmsood8szK0Yafa5Nb/Pr7ejocYeYhXcXA/uGipCAB639i3iVIMVtChilhko94XWVbZW8SfcA8umC6Tz8j1YwID1GRzH8AFzCZL0trsgNhGY5ToAPw8pG+Q7nTw9R6fSL1+8sW/J28rEvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8)
 by PH7PR12MB6719.namprd12.prod.outlook.com (2603:10b6:510:1b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 02:27:52 +0000
Received: from CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd]) by CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 02:27:51 +0000
Message-ID: <407e7ce1-4fff-47c5-b899-1d2bb824c68a@amd.com>
Date: Tue, 21 Jul 2026 10:27:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/32] drm/amd/display: Add Support for HDMI Compliance
 Automation
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, James Lin <PingLei.Lin@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
 <20260610094639.1965367-17-chen-yu.chen@amd.com>
 <nGLVvJOTS8eSI7IusBrUxw@collabora.com> <dvZfompQRf-4fxleZDXPUg@collabora.com>
Content-Language: en-US
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
In-Reply-To: <dvZfompQRf-4fxleZDXPUg@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR01CA0145.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5b::9) To CY5PR12MB6132.namprd12.prod.outlook.com
 (2603:10b6:930:24::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6132:EE_|PH7PR12MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 5672f76b-9161-4b4d-04e5-08dee6cfa9c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: zaTLZerNtDhPIgEE4KLwJqNRHFvGyO2QusIbGlKWNvT/XtGxLSoR9n7TBrA09cyLyN6YOwY4M60S1tayr8HAxf14LzwAlYtYHj745PuhWMk7RAdg2m3Q8QXmScLKq+Nf2seYEY0veeyGfyGi9etIfP+XFgXvqRd3h6BQXoVQNPdmjO1XxezFnn8FVYqbN99YRxl0yWxwUn8ubofTlHH3OV/Ao8lPvJerlSjsa977+SsDQe5I0FlG14K53GDTD4+BjFoFS2fWWwOWbzdLp9o2jkMnOspE97oCUCrP/1T/XJjqxVCqbeuapvDlhuL6A3nzRsaMbKgV9BAYgHpHK67rWnKuteWgyMxw9EzRfLWhxvBACnxpnFqXFANJ5jdmK8Q7RJ4ByVlbFFQ40rNrUEt3h6Em95Mz5FZENZ+STOd2s+IfyTrHth4sgjfELOO96RY57jtFQ627jIndc7HDc/ptbu4pg/6iHKgzjtQCR4i3xbew6Z42H9ci+TFfYa5W9mbvcxoMknF+J5rL3jr6kInUmddRJdWotsbVyWFNrUMsWtAqEezLJHGGFzG3hdqqyYBQBGMec2+c2vZ1Dz0AlcT9Xvety/2VqDDvNGF5TvtCFc95N5q5YtnboQDuTrGFBrt6qWRoXiL+olqjYWepPPT/ERuiZDO73H+qI7r0mjBCBZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjRqdVdRMTZlWUhvdnNzV1Nvbm5UMVludDdqalgxYUFyZkhmckxtT1VwbzRB?=
 =?utf-8?B?d25RckU3aGFyMjdmKzN4aCsrZVQ1UUMwRHFNUnh0QXoxUWdFN1lxaGM2eGx0?=
 =?utf-8?B?MmRyRUExald5Nm11ZmwwTTQzSTZaSXF6dzBpRTZzYkRUR3M0NzQyYmFPN1di?=
 =?utf-8?B?QW00NmNIa3BxUkQzc3h1NGE3QjFTYXBwUXlrWThwVFlnRGdicSsxTFB6eUt1?=
 =?utf-8?B?ME5zeGluc21FNTc0ekt2RTdJdjJyRXRpSGw5bEFtM2syMUNHTkxUcjM4elRz?=
 =?utf-8?B?TkVWcUtOZSt4YzhmcWo0aHN3ajlqTWVKQjVtL2hRUDR0bWl3WUtzSzdRcWgw?=
 =?utf-8?B?aGJzRk54VUlTSjRYcVZOckVpSjd3Tm1tTmMzRjh6bGhUdW5DOGtyTXlPaFI2?=
 =?utf-8?B?aU1nbUltdkk0aVR6OVlkMGVhNDlTRUJld1lBSTcvciswMytPWHVmRFcySzBI?=
 =?utf-8?B?Uit1WXE0QkZsSUQrWHFxTUt4bjh3TCtSMDNncEpRTyt6T3lmTVU5bzZuT2ty?=
 =?utf-8?B?K2FSVk44bHJvQlVvWFNwRitvRWdwazdxRXlqWjlicG5kQzFDWDVMSlRrQ2FD?=
 =?utf-8?B?RWVjU1RyYzhROHg4UGJZaTU1NVZZY3U0T2tsMDNJeVlXdGFPR2cwT0pPc2Vi?=
 =?utf-8?B?ZC94VzRMZTVBWVFUSll5YVFXQklJaFljK09VcXN5QVNRaWx6TGRmMi84dGtJ?=
 =?utf-8?B?MXA1aEJPVkRNcU42RjJaTThBU3A3UFAyWThQazd2d0JtejN2cVJLdEh4TG1m?=
 =?utf-8?B?WnQ4cVVtV2Rqb2NZcGg1Y2VRcWJhQ2p4RkxkRUxOS3RhUFFJUUNjZ1R1V2ZZ?=
 =?utf-8?B?emlnZ0ZDandhdEE1a0x3dnRCRVpGMVBBNlBZaFJqUmdxNS9Xa3RFRktZcUM2?=
 =?utf-8?B?Qm1Pc1orS1RxeExjTGpWcUNzUjAvRzk5dXU5cGVvS3Y1OE1RRmwzQ05QYnZB?=
 =?utf-8?B?VGcydnYydGNaTk9CdGVVRVdlQWo2MURKTjRhWEJiN2Z5ZXo3NzZ5OU9jVFR6?=
 =?utf-8?B?L01CcDNBL1dKNkEvS2cwM2RNeVBnVjJtYk01WnZyaWtQaU5hT2paN3dWbTdi?=
 =?utf-8?B?Y0FpT3M4QklSVUE4bkxrS1NYNmNmaFdKVm5VN0M1a2x1Vmc5b0s3UTFVbXFZ?=
 =?utf-8?B?ODVHcG8wNmI0REMzQXZqMnZ1QUJURWp4SndTSTk4ZEw4NjEzVlZqVWM4OG5x?=
 =?utf-8?B?NTkzeC9ERmV2Zmd4WFl0TE9VNHFhWlNWSXBsVFFaKzIxdytCZDI3T2JreWFT?=
 =?utf-8?B?WSs3M0ROQXJlZm5rUE1KQng1RUZQcnNhbGNHWWxZRjl6UDA5S09HVlUwOThr?=
 =?utf-8?B?Y0MyS2hCVlJKb3FkKzdNQ1phM1FiQ2k3Q3dNc1UrU3FtRjRDcE9PSUhheVE4?=
 =?utf-8?B?Zk96b0F3cE44TGpqQnVBbmhtWVo3VGRyMUI4VnZha093VjVBbVd2Ulk5cFNX?=
 =?utf-8?B?bzhzcURzTXY3M0JYZ1VzRXNFajVKMjZLZ2ZIVjRYUmdweDBFczBjR1UwUUJR?=
 =?utf-8?B?WGpJV1c1UlJPSyt0bmZDakluTWRodEVjZ294UFV1YTBtYk9JOUN3N3VoZjNv?=
 =?utf-8?B?MklDUk9KbUpLSllxcWxCclZmVHhDQVRYNVlCWXB6MFZOeG4vMWFLUzJNNnFC?=
 =?utf-8?B?aVNCVHU1Y3lNZzBkWVZyQkFHWktWcVZkcUNVMlM4YlVYNWlXaVMwRlJubE1w?=
 =?utf-8?B?ak1vR1NLNi9yNmcwdTZrWnRIRmxzSWJkMW1VTFJXclpqVVFvLzAwaXBHTEJy?=
 =?utf-8?B?Sk9zNGpzNFBGSXhuLzNmaGwxUm5zejVFVzZVZnJaRVBLU1o2UEJhdkZRMW5t?=
 =?utf-8?B?UG15SklINHhwQ3ZUeFhvUnhYNVFXR29MQm40SnpYYVh4S2p5UVF5bmxTYTk3?=
 =?utf-8?B?TlRvUXVoYnZMTUpFa3QvMHhWQmU5d01veGNOUWs4L0tCRHFiSkozaVJNWGxO?=
 =?utf-8?B?RHJhaUU1c01VTjBkUUZGeWpUVXFlQTh3Z2hlMGNNbStqcjBGdWFLNDZtZnAw?=
 =?utf-8?B?YlZlSXNQc2UxM1V6cENmWVlSakdtcEZaaWN2VFNoTmtYV1FxMlphbDlTa1pP?=
 =?utf-8?B?b1Byck5JRVA1T3JIZUsxcVVjakJma3pMQUFTTmFZQzR4UFdXcGlkbnpoZzM4?=
 =?utf-8?B?akV3Q1Q3Q21GaWUrRW5tQWE2Nm1hS1A0K25aSVA0TktUUDRLSG82blhmbyti?=
 =?utf-8?B?a3VFaFBtYVNkTmllL2oxK2E1clJRM2YxaExFWER2R1JCNmkxbndldzMwUEFC?=
 =?utf-8?B?Y0l0SGNYWEl3d1dvdC9XVFBMTjFNdWt0TkVoMC9pVnBxUFdqWHRPVzBZNnQ3?=
 =?utf-8?Q?UsmSrE7RdPCYJQQg/m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5672f76b-9161-4b4d-04e5-08dee6cfa9c1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 02:27:51.7079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAQQhI6UVmz63B34XL27bb/opuabfXPX1oyzbISnBCR7PowLA4td1YgaXGG0YRW6a5+1bVJazPAvcVj4uqLC/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6719
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



On 7/20/2026 9:14 PM, Nicolas Frattaroli wrote:
> On Wednesday, 10 June 2026 16:43:37 Central European Summer Time Nicolas Frattaroli wrote:
>> On Wednesday, 10 June 2026 11:45:00 Central European Summer Time Chenyu Chen wrote:
>>> From: Fangzhi Zuo <Jerry.Zuo@amd.com>
>>>
>>> Add support to get DUT trained at FRL link rate when working with
>>> Teledyne M41h compliance automation.
>>>
>>> Reviewed-by: Alex Hung <alex.hung@amd.com>
>>> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
>>> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
>>> ---
>>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +
>>>  .../display/amdgpu_dm/amdgpu_dm_connector.c   |  5 ++
>>>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 67 ++++++++++++++++++-
>>>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  6 ++
>>>  4 files changed, 80 insertions(+), 1 deletion(-)
>>>
>>> [... snip ...]
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>>> @@ -2982,6 +2982,64 @@ static ssize_t hdmi_cec_state_write(struct file *f, const char __user *buf,
>>>  	return size;
>>>  }
>>>  
>>> +/**
>>> + * hdmi_automation_enable - Enable/Disable HDMI automation feature
>>> + * @f: file structure.
>>> + * @buf: userspace buffer. set to '1' to enable; '0' to disable automation feature.
>>> + * @size: size of buffer from userpsace.
>>> + * @pos: unused.
>>> + *
>>> + * Return size on success, error code on failure
>>> + */
>>> +static ssize_t hdmi_automation_enable(struct file *f, const char __user *buf,
>>> +	size_t size, loff_t *pos)
>>> +{
>>> +	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
>>> +	char *wr_buf = NULL;
>>> +	const uint32_t wr_buf_size = 40;
>>> +	int max_param_num = 1;
>>> +	uint8_t param_nums = 0;
>>> +	long param[2];
>>> +	bool hdmi_comp_auto;
>>> +
>>> +	if (size == 0)
>>> +		return -EINVAL;
>>> +
>>> +	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
>>> +	if (!wr_buf)
>>> +		return -ENOSPC;
>>> +
>>> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>> +					   (long *)param, buf,
>>> +					   max_param_num,
>>> +					   &param_nums)) {
>>> +		kfree(wr_buf);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (param_nums <= 0) {
>>> +		kfree(wr_buf);
>>> +		DRM_DEBUG_DRIVER("user data not be read\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	switch (param[0]) {
>>> +	case 0:
>>> +		hdmi_comp_auto = false;
>>> +		break;
>>> +	case 1:
>>> +	default:
>>> +		hdmi_comp_auto = true;
>>> +		break;
>>> +	}
>>> +
>>> +	/* Persist setting across sink re-detection/hotplug. */
>>> +	aconnector->hdmi_comp_auto = hdmi_comp_auto;
>>> +
>>> +	kfree(wr_buf);
>>> +	return size;
>>> +}
>>> +
>>>  DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
>>>  DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
>>>  DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
>>> @@ -3099,6 +3157,12 @@ static const struct file_operations dp_mst_link_settings_debugfs_fops = {
>>>  	.llseek = default_llseek
>>>  };
>>>  
>>> +static const struct file_operations hdmi_automation_debugfs_fops = {
>>> +	.owner = THIS_MODULE,
>>> +	.write = hdmi_automation_enable,
>>> +	.llseek = default_llseek
>>> +};
>>> +
>>
>> I really don't understand why this can't just be a DEFINE_DEBUGFS_ATTRIBUTE,
>> and then you can replace the overcomplicated hdmi_automation_enable() with
>> just simple setter and getter functions that already receive the parameter
>> of the right type.
> 
> Aaaand this was applied without the review comment being addressed.
> 
> Along with the incredible other things in this series, like
> 
>    link.dpcd_caps.dongle_type = (typeof(link.dpcd_caps.dongle_type))0x7f;
> 
> in "[PATCH 21/32] drm/amd/display: Add KUnit tests for amdgpu_dm_connector",
> I'm feeling like AMD is treating mainline as a vendor BSP to just dump code
> into.
> 
Hi Nicolas,

Sorry, that's on me. I missed your review comment when I promoted the series. Thanks for pointing it out.

I'll take a look at your feedback and follow up with the author to make sure it's addressed.

Hi Alex, 

Could you please take a look at the feedback above? It also looks like pointed out another issue in the patch below that may need to be addressed.

Please let us know whether a follow-up fix is needed.

Apologies for the oversight on my side.

Regards,
Chenyu
>>>  static const struct {
>>>  	char *name;
>>>  	const struct file_operations *fops;
>>> @@ -3131,7 +3195,8 @@ static const struct {
>>>  	const struct file_operations *fops;
>>>  } hdmi_debugfs_entries[] = {
>>>  		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
>>> -		{"hdmi_cec_state", &hdmi_cec_state_fops}
>>> +		{"hdmi_cec_state", &hdmi_cec_state_fops},
>>> +		{"hdmi_automation", &hdmi_automation_debugfs_fops}
>>>  };
>>>  
>>>  /*
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>>> index a2d0bb34e639..6350212b9a66 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>>> @@ -193,6 +193,12 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
>>>  					__func__, connector->name, edid_caps->frl_dsc_10bpc, edid_caps->frl_dsc_12bpc, \
>>>  					edid_caps->frl_dsc_all_bpp, edid_caps->frl_dsc_native_420, edid_caps->frl_dsc_max_slices, \
>>>  					edid_caps->frl_dsc_max_frl_rate, edid_caps->frl_dsc_total_chunk_kbytes);
>>> +		if (aconnector->hdmi_comp_auto) {
>>> +			edid_caps->panel_patch.hdmi_comp_auto = true;
>>> +			link->ctx->dc->debug.force_frl_max = true;
>>> +			link->ctx->dc->debug.force_frl_dsc = true;
>>> +			drm_dbg_driver(connector->dev, "%s: HDMI_FRL [%s] hdmi_comp_auto --> enabled\n", __func__, connector->name);
>>> +		}
>>>  	}
>>>  
>>>  	apply_edid_quirks(link, edid_buf, edid_caps);
>>>
>>
>>
> 
> 
> 
> 

