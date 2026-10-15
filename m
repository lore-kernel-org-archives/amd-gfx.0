Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE93CC6B33
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 16:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2709310F21C;
	Thu, 15 Oct 2026 16:01:12 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 131BF10F3A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 16:01:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AF+zQWhdf34gdx7JEF0dHeQPWztABACxrVB6/GHQOnMqmDUffMLJ3Jd1OeoTok2LBX4DH3/74fin/Ehmgo1KRkru4vHGf/Hd0xi/HgnF74LBY0p7S6D3OQOvv6cPcEnak5w2lXPzdk9tshP/euYG+KTE79JeE4vRaj7d5zSo1KsIYXkV4ccbuRSKbLEWP0pu4fFiimELGnasPu4IX0p1/6p2g0eaeFOLpmpHW/V2TDX4oyvtltg3v8fhDFaML/tVJ++biQYft6V8ibobr3n+l3Bu04gI5pKtLw5GaBYgF3o6FKJ5K1E20l0/6Kf+4LttrEaxsbCn9oDa+BxkJZSGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9FrwFB0kXrAnvhjML4rTded5DESjirCgM6DkfhWJn4=;
 b=l0l1r1T3+bOqtUDZyUABJyjC/5UdIIC6rqyZAhlq7eJCWR9DWHuteVX8d7s82YRe/xYnuVUb2bfY2y4xQ2hN62RUEwRrwFsM6b/mZuO1igY6KdjWw+TP/mCkImfvhPs2tJUhdrq/ER3NUthEYaMgExRUT9DPT5a60CdcwVFyxUM6E9G3hNElU/nDF790aNrkKCSyP2hcnlTKTb6OlL/RTbkjdLnlvXQXz+O9HJ7+0PCzaa2nMe3OX3miC+GXWeskhGVeJePzocWBaBTd49A3kdoO8HMi/wkGdaKBtxBU4x6LAv/JEMPTm3Y3MZD0bdOBKX7c/N3u+ZCM2K2HHmKAZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9FrwFB0kXrAnvhjML4rTded5DESjirCgM6DkfhWJn4=;
 b=JrJSa9BAQn//pl/ybcElfx2Y90cM4nxrPpPO2xe+pD1JpStx40vWbOkTKROxCq7Ry/vNx9/Dg8B27qutn9X8N+aexWx/5lAMuZq+hEFrORAGdFARos9rBkxGSPNTBgznHo7wbCDYf750jGx/5o3n4+mAr5kdLc3jUVlSpPraNQ8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by LV8PR12MB9333.namprd12.prod.outlook.com (2603:10b6:408:1fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 16:00:47 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 16:00:46 +0000
Content-Type: multipart/alternative;
 boundary="------------ErJZlfqeviy5YTrWEJJTcmEr"
Message-ID: <c628ac6a-50bb-4725-acf7-e7e1809675a6@amd.com>
Date: Thu, 15 Oct 2026 12:00:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: UALink add debugfs selftest
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Mukul.Joshi@amd.com
References: <20261013181010.1886675-1-Philip.Yang@amd.com>
 <a9ead820-9869-4280-b086-76933de4dd34@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <a9ead820-9869-4280-b086-76933de4dd34@amd.com>
X-ClientProxiedBy: YT4PR01CA0394.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::23) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|LV8PR12MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a87e1fe-3126-4c70-b543-08df2ad57894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|8096899003|6133799003|18002099003|10067099003|3023799007|22082099003|11063799006|4143699003|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: KSx3PD4EiO91DyF1D9C4hxO6SusaJXeEi9TLctYekrNIJR+Rx0K/hfs8/t7619g15Xb8vhMHsAhVmrLVJOaH3FDMZkpllgo0ag5GeaJmR9UUL1726l64FAPuYB0BTlfe/qBGKinDhNvV0qySHwHbxj8OCLo098iewI+2rfqtsgZWsXjrNNtunKNV10xLJ3WuyLSRk1jBtfW0h62MRgluyna7+vJvYv4Ae9piMxWlRE+/jg/BbpJmJLBkTFXXPzCXchxRzaDZqbOZmPPCGJZAnUHGmzs8IKAJKoUqMFY7nkwTIwUhxnsv/Y0FzT4hSbgZEvYiSmWK00/jb1362Jsu4Uy/0M4tmx0rcpmoRpDUsnzKWt+1HtdYZwQtwUuRYQYc4oeH/sejyLrZFuG4T1swbcB4BcLBEUf6X8ofthpUir+d90HSW/4jAJdJuwSnJcQdiXbfQg5qJL1u886i4IFxF1fuF07/+cgyirqeKZ+3EyyH7YjSo+7/qETjnYBMRsyJmu3B5tuA5FwuYTGGxf6/+iRY0nB44Yb95K6FqM8v7+LKDjbAyH3T4kgOMySUNqE7A/HMG7xFiZ2o8p1TSWqTXeB/n8HBlVaH8nHHh8Ybu3UkCOER9aLklp3bLa/fGVgab3r+/XDlCKj3FpPZxtlSEqWlrr2OQk+YznUgMPDG7jQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(8096899003)(6133799003)(18002099003)(10067099003)(3023799007)(22082099003)(11063799006)(4143699003)(261009223027099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDd6YUs4MENrZWFLblZxTEZMTElLMGxMcXIzYVBEbVRqSkFTWUNlanc2N3V4?=
 =?utf-8?B?YUtUYmVEUC8yQmRIeTZYT3RUdkNaTkszYUtZZkF2T0dqeXdxeUVkRk1UQ24w?=
 =?utf-8?B?dTdsdXZZU1l6K3ZaM0ZmbjA5WW5aK2ViSnNzMzJzcCtsc0YvV0s0dHRISWhY?=
 =?utf-8?B?Y3RFSklOcHVlem54ZURtbXlURTZVR0cwdmRQeWRDNS9qbGlMeFplREZhaFVV?=
 =?utf-8?B?dW1YNFJ1SkJIejVJbTdXQVVMWGJ5ZGRmcGErSnlzNUQ1VGs0MEJ4bi9JQzEr?=
 =?utf-8?B?djg1ZUVkZms1QjZIVXQ2MGVrTmtvSktPM2RKMTBzSEFtSmZlaCtzYzNBdmxp?=
 =?utf-8?B?N3NDOU9jcTFLQXEwQktSWGFyM0VteHNodlFTS0ZIY0F0S3hER1NpZUF6NG5j?=
 =?utf-8?B?eHEzZWR2aVh3blVoV1VUd0ljeUtoeDlDNjdwK0hlcmk0NDkxOVZOc1g3NTNp?=
 =?utf-8?B?TlRweFVsbm1qQ3M4MDZtUWhmT05wcU5YNXdab0ZpcHVnZzdjV01FelgwMGdk?=
 =?utf-8?B?MXBjTGVnaFFna2ZIN1ZLb0tHNVhlYUNWR0lkbGRxQUVCT3JKMkFBUmhicW9n?=
 =?utf-8?B?eFkybEY1N1BZL0Q5bTFrYUFZZjVReDhpQ2VKZmJYZzFEemJCSmQ2VjFUQ3Iw?=
 =?utf-8?B?REhmUTNmc2pVWkdwMTFzS3BmZ0Z4RDh4OGI0bjllWXNFempUNU5yVkRVcGh1?=
 =?utf-8?B?eVlEeE5ZOWdnMG45aERZQno0bXpIS1JMcnpKUnM3UitreExxZkRxT1MyYnB4?=
 =?utf-8?B?azBPL2U0dnNseWF3L0o0OVF5N29TaS9ONWYvSnBZVVF0WlNBMXZVZXBGMVFT?=
 =?utf-8?B?SHhSWTNBay8rN3lGSE94czg5aUJqUkQyWHhnTDJ2SzNjaUp4RkRQRmtTTE5U?=
 =?utf-8?B?RVIzTWF2VU1hSXJQZVJJZTdtWXY4YW9oR1FjMDc2RjBYNTE5dVh6VWFsdXFp?=
 =?utf-8?B?T3JFclAvYmkwTjlDbS9jTUl5SHF4bHdyV0JUak5MQUJqS0J6MnZrb1o3OHpm?=
 =?utf-8?B?UVNtS3FLb3dUT1VTeUg4ak4wU2ZmSUJIOEt1Yk9oa05iUE94d2hqYjk3eXhv?=
 =?utf-8?B?Y2h1UjdzM2F3Nno0Z3VHcXBVTzFCYnlFU0JuZ0NtTzdnZmkrVmNtTFVBNGZy?=
 =?utf-8?B?LytHZDlXSXhyVXhSYlpHL2xkbjU0OHRTRFRCeU4zakdCSFdGV0hjaUF6QlZy?=
 =?utf-8?B?Qy9GSHp3SXlqOGNTbXg4RTBJbm5UcVMxQTEweEhmclEvYVo3U3g4MXYydStJ?=
 =?utf-8?B?YzNodE4wUDYrWm4zNnpBd3VRNENKKy94aEZJTlB2TllYZ3d0SVdod1Yvenp1?=
 =?utf-8?B?NDZOR3BDQW5qc09STFBYVHo5VXNVWkE0cTA0RDNqTUhVMisyNkdQeWNXblF3?=
 =?utf-8?B?VnpKTXh1UjI1ZnNydkRXZ2FuV3AvUDc0aDZVSHdHR1Mzc0tnazkzUURLMjVQ?=
 =?utf-8?B?WXZ2OEpySStjWGN1Z0JZZ0NOWVNEQ09OS2dlZzhLL3JxNkRxQVJOWmpFeUNI?=
 =?utf-8?B?RHI2Z0RZQ1hVZllwbUlqUTFKYk9McDNPUWZBUUFyYXdSd3RJNzQwbWlTTUh4?=
 =?utf-8?B?aDZiWFBCNXU2QUVTSTRhRlJRdk01THM1bGVvRXR4Y1FMdnRCTEdyS09zZXl1?=
 =?utf-8?B?aEZvcXE3MU5xL0NOZ01LeEZ5WDZwMitJS0ZpZkpsQ3RheUpHd2YzQ3hNMzZp?=
 =?utf-8?B?YVhzU1poK0pqUENTWitybnVDS0k2cWZWbTUyM0ROVnFHNlBCTlhuWERlbG8v?=
 =?utf-8?B?S0ZscW4vbkRXWUovekhVV203b3FlcU55MGZMRVYwNXl0MENqclZsZHRBbzZN?=
 =?utf-8?B?YitPK2hCNDduaUVMZ0FSYlZTUmxpY2tNbzJlN3dYTmVRcUMvUlNVSnBHY0RG?=
 =?utf-8?B?YXNLVUxoc1dSd051K0UyMGk1L2tCN29MUW1KaXhmV2dNWFVBRDlKY2lyZHh2?=
 =?utf-8?B?b2RWU1hKbC9obkpXNTZEd0lIM3Q2ZjZhY1grRXpGcWJIU1kyOHByR3JYbm9u?=
 =?utf-8?B?UEpVeGhHb0tLczUyLzNzYmVMZUtlSmdIUVhGcXExakVUbUx0NEM0bnlKSkhw?=
 =?utf-8?B?L205SHBCSEZqdlRFOVM4UWpqSlphMVBIKzJURnU1RTFzeGRLS3JEaEwzOWw1?=
 =?utf-8?B?WTdvdzFsbEViNTRhY3BXdTNwVUk1aEN4QnBkUEoxdVRVbyt0d3NlWk9hUFJP?=
 =?utf-8?B?ajRjaWVWN2hrSUxqdVVLamwwU09vbm5QMUczdjBPQzJpREp1SkJ5RTB2ZHVF?=
 =?utf-8?B?alVZcHhvRWhKSEdOS0FRL085Tlh0MWNIR0wxZmZhaU41bW9MR2tIUE10NkhJ?=
 =?utf-8?Q?13TlN/hag1+0ciOFTS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a87e1fe-3126-4c70-b543-08df2ad57894
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 16:00:46.6781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAFU+Z93+Utj9+brp3BbE/BR3lJIsyhuYLGzSstLiQ+0lcxsyphd1EVEaBoCrcho
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9333
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

--------------ErJZlfqeviy5YTrWEJJTcmEr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-10-13 18:32, Felix Kuehling wrote:
>
>
> On 2026-10-13 14:10, Philip Yang wrote:
>> Add debugfs directory "amdgpu_ualink_test" to trigger UALink selftests
>> without userspace application, with three read/write entries:
>>
>>    command          write the test name to run it, read to list the
>>                     valid test names
>>    remote_accel_id  accel_id of the remote GPU used by the tests
>>    test_size        test buffer size in bytes, from 4 to 8192
>>
>> Add helper functions: ualink_simple_rw() for remote VRAM R/W,
>> ualink_remote_shootdown() for TLB shootdown, ualink_send_hello()
>> for handshake, ualink_update_interrupt_wb()
>> and ualink_update_shootdown_wb() to read writeback results.
>> Use lsdma by default, can select sdma with command.
>>
>> v4: Use a single "command" entry taking the test name, instead of one
>>      entry per test (Felix).
>>      Resync the remote wptr before sending a command, the peer may have
>>      rebooted.
>> v3: Replace the single entry taking a test number with a debugfs
>>      directory and a named entry per command.
>>      Take peer->lock to update the writeback address and selftest_mutex
>>      to read the test parameters.
>> v2: Fix typos and issues from copilot code review.
>>
>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 241 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c   |  49 ++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h   |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c  | 249 +++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h  |  15 ++
>>   5 files changed, 554 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 3dc95d9accf2..a898a24fda0d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -2133,9 +2133,237 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>   			amdgpu_debugfs_sclk_set, "%llu\n");
>>   
>> +enum amdgpu_ualink_test_cmd {
>> +	UALINK_TEST_SW_INIT,
>> +	UALINK_TEST_SEND_HELLO,
>> +	UALINK_TEST_REMOTE_SHOOTDOWN,
>> +	UALINK_TEST_FLUSH_TLB,
>> +	UALINK_TEST_READ_LSDMA,
>> +	UALINK_TEST_READ_SDMA,
>> +	UALINK_TEST_WRITE_LSDMA,
>> +	UALINK_TEST_WRITE_SDMA,
>> +	UALINK_TEST_UPDATE_INTERRUPT_WB,
>> +	UALINK_TEST_UPDATE_SHOOTDOWN_WB,
>> +	UALINK_TEST_LSDMA_SELFTEST,
>> +};
>> +
>> +/* commands talking to a remote accelerator, remote_accel_id must be set */
>> +#define UALINK_TEST_NEEDS_ACCEL_ID					\
>> +	(BIT(UALINK_TEST_SEND_HELLO) | BIT(UALINK_TEST_REMOTE_SHOOTDOWN) | \
>> +	 BIT(UALINK_TEST_READ_LSDMA) | BIT(UALINK_TEST_READ_SDMA) |	\
>> +	 BIT(UALINK_TEST_WRITE_LSDMA) | BIT(UALINK_TEST_WRITE_SDMA) |	\
>> +	 BIT(UALINK_TEST_UPDATE_INTERRUPT_WB) |				\
>> +	 BIT(UALINK_TEST_UPDATE_SHOOTDOWN_WB))
>> +
>> +static int amdgpu_debugfs_ualink_test_run(struct amdgpu_device *adev,
>> +					  enum amdgpu_ualink_test_cmd cmd)
>> +{
>> +	u32 remote_accel_id = adev->ualink.test_remote_accel_id;
>> +	int r = 0;
>> +
>> +	guard(mutex)(&adev->ualink.selftest_mutex);
>> +
>> +	if ((BIT(cmd) & UALINK_TEST_NEEDS_ACCEL_ID) &&
>> +	    remote_accel_id >= AMDGPU_UALINK_ACCEL_MAX) {
>> +		dev_err(adev->dev, "set remote_accel_id first\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	adev->ualink.selftesting = true;
>> +
>> +	switch (cmd) {
>> +	case UALINK_TEST_SW_INIT:
>> +		if (adev->ualink.remote)
>> +			amdgpu_ualink_sw_fini(adev);
>> +
>> +		dev_dbg(adev->dev, "load metadata init MPNHT firmware\n");
>> +		r = amdgpu_ualink_sw_init(adev);
>> +		break;
>> +	case UALINK_TEST_SEND_HELLO:
>> +		r = ualink_send_hello(adev, remote_accel_id);
>> +		break;
>> +	case UALINK_TEST_REMOTE_SHOOTDOWN:
>> +		r = ualink_remote_shootdown(adev, remote_accel_id, 1UL << 30, 1,
>> +					    TLB_FLUSH_HEAVYWEIGHT);
>> +		break;
>> +	case UALINK_TEST_FLUSH_TLB:
>> +		ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
>> +		break;
>> +	case UALINK_TEST_READ_LSDMA:
>> +		r = ualink_simple_rw(adev, remote_accel_id, true, true);
>> +		break;
>> +	case UALINK_TEST_READ_SDMA:
>> +		r = ualink_simple_rw(adev, remote_accel_id, true, false);
>> +		break;
>> +	case UALINK_TEST_WRITE_LSDMA:
>> +		r = ualink_simple_rw(adev, remote_accel_id, false, true);
>> +		break;
>> +	case UALINK_TEST_WRITE_SDMA:
>> +		r = ualink_simple_rw(adev, remote_accel_id, false, false);
>> +		break;
>> +	case UALINK_TEST_UPDATE_INTERRUPT_WB:
>> +		r = ualink_update_interrupt_wb(adev, remote_accel_id);
>> +		break;
>> +	case UALINK_TEST_UPDATE_SHOOTDOWN_WB:
>> +		r = ualink_update_shootdown_wb(adev, remote_accel_id);
>> +		break;
>> +	case UALINK_TEST_LSDMA_SELFTEST:
>> +		r = adev->lsdma.funcs ? amdgpu_lsdma_selftest(adev) : -EOPNOTSUPP;
>> +		break;
>> +	}
>> +
>> +	adev->ualink.selftesting = false;
>> +
>> +	dev_dbg(adev->dev, "ualink test cmd %d remote_accel_id %u ret %d\n",
>> +		cmd, remote_accel_id, r);
>> +
>> +	return r;
>> +}
>> +
>> +#define UALINK_TEST_CMD_NAME_MAX	32
>> +
>> +static const char * const amdgpu_ualink_test_cmd_name[] = {
>> +	[UALINK_TEST_SW_INIT]			= "sw_init",
>> +	[UALINK_TEST_SEND_HELLO]		= "send_hello",
>> +	[UALINK_TEST_REMOTE_SHOOTDOWN]		= "remote_shootdown",
>> +	[UALINK_TEST_FLUSH_TLB]			= "flush_tlb",
>> +	[UALINK_TEST_READ_LSDMA]		= "read_lsdma",
>> +	[UALINK_TEST_READ_SDMA]			= "read_sdma",
>> +	[UALINK_TEST_WRITE_LSDMA]		= "write_lsdma",
>> +	[UALINK_TEST_WRITE_SDMA]		= "write_sdma",
>> +	[UALINK_TEST_UPDATE_INTERRUPT_WB]	= "update_interrupt_wb",
>> +	[UALINK_TEST_UPDATE_SHOOTDOWN_WB]	= "update_shootdown_wb",
>> +	[UALINK_TEST_LSDMA_SELFTEST]		= "lsdma_selftest",
>> +};
>> +
>> +static ssize_t amdgpu_debugfs_ualink_command_read(struct file *file,
>> +						  char __user *ubuf,
>> +						  size_t len, loff_t *offp)
>> +{
>> +	char buf[UALINK_TEST_CMD_NAME_MAX * ARRAY_SIZE(amdgpu_ualink_test_cmd_name)];
>> +	unsigned int i;
>> +	int n = 0;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(amdgpu_ualink_test_cmd_name); i++)
>> +		n += scnprintf(buf + n, sizeof(buf) - n, "%s\n",
>> +			       amdgpu_ualink_test_cmd_name[i]);
>> +
>> +	return simple_read_from_buffer(ubuf, len, offp, buf, n);
>> +}
>> +
>> +static ssize_t amdgpu_debugfs_ualink_command_write(struct file *file,
>> +						   const char __user *ubuf,
>> +						   size_t len, loff_t *offp)
>> +{
>> +	struct amdgpu_device *adev = file->private_data;
>> +	char buf[UALINK_TEST_CMD_NAME_MAX];
>> +	int cmd, r;
>> +
>> +	if (len >= sizeof(buf))
>> +		return -EINVAL;
>> +
>> +	if (copy_from_user(buf, ubuf, len))
>> +		return -EFAULT;
>> +
>> +	buf[len] = '\0';
>> +	cmd = sysfs_match_string(amdgpu_ualink_test_cmd_name, strim(buf));
>> +	if (cmd < 0) {
>> +		dev_err(adev->dev, "unknown ualink test command\n");
>> +		return cmd;
>> +	}
>> +
>> +	r = amdgpu_debugfs_ualink_test_run(adev, cmd);
>> +	if (r)
>> +		return r;
>> +
>> +	return len;
>> +}
>> +
>> +static const struct file_operations amdgpu_ualink_command_fops = {
>> +	.owner	 = THIS_MODULE,
>> +	.open	 = simple_open,
>> +	.read	 = amdgpu_debugfs_ualink_command_read,
>> +	.write	 = amdgpu_debugfs_ualink_command_write,
>> +	.llseek	 = default_llseek,
>> +};
>> +
>> +static int amdgpu_debugfs_ualink_accel_id_get(void *data, u64 *val)
>> +{
>> +	struct amdgpu_device *adev = data;
>> +
>> +	guard(mutex)(&adev->ualink.selftest_mutex);
>> +
>> +	*val = adev->ualink.test_remote_accel_id;
>> +
>> +	return 0;
>> +}
>> +
>> +static int amdgpu_debugfs_ualink_accel_id_set(void *data, u64 val)
>> +{
>> +	struct amdgpu_device *adev = data;
>> +
>> +	if (!adev->ualink.info)
>> +		return -EOPNOTSUPP;
>> +
>> +	guard(mutex)(&adev->ualink.selftest_mutex);
>> +
>> +	if (val >= AMDGPU_UALINK_ACCEL_MAX ||
>> +	    !test_bit(val, adev->ualink.info->vpod.active_accel_bits)) {
>> +		dev_err(adev->dev, "invalid remote accel_id %llu\n", val);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (val == adev->ualink.info->ppod.accel_id) {
>> +		dev_err(adev->dev, "remote accel_id equals to local accel_id\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	adev->ualink.test_remote_accel_id = val;
>> +	dev_info(adev->dev, "set remote accel_id to %llu, local accel_id %u\n",
>> +		 val, adev->ualink.info->ppod.accel_id);
>> +
>> +	return 0;
>> +}
>> +
>> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_accel_id_fops,
>> +			 amdgpu_debugfs_ualink_accel_id_get,
>> +			 amdgpu_debugfs_ualink_accel_id_set, "%llu\n");
>> +
>> +static int amdgpu_debugfs_ualink_test_size_get(void *data, u64 *val)
>> +{
>> +	struct amdgpu_device *adev = data;
>> +
>> +	guard(mutex)(&adev->ualink.selftest_mutex);
>> +
>> +	*val = adev->ualink.test_size_dwords * 4;
>> +
>> +	return 0;
>> +}
>> +
>> +static int amdgpu_debugfs_ualink_test_size_set(void *data, u64 val)
>> +{
>> +	struct amdgpu_device *adev = data;
>> +
>> +	if (val < 4 || val > 8192)
>> +		return -EINVAL;
>> +
>> +	guard(mutex)(&adev->ualink.selftest_mutex);
>> +
>> +	adev->ualink.test_size_dwords = val / 4;
>> +	dev_dbg(adev->dev, "test buffer size %u bytes\n",
>> +		adev->ualink.test_size_dwords * 4);
>> +
>> +	return 0;
>> +}
>> +
>> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_test_size_fops,
>> +			 amdgpu_debugfs_ualink_test_size_get,
>> +			 amdgpu_debugfs_ualink_test_size_set, "%llu\n");
>> +
>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>   {
>>   	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>> +	struct dentry *ualink_test;
>>   	struct dentry *ent;
>>   	int r, i;
>>   
>> @@ -2246,6 +2474,19 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>   	debugfs_create_ulong("amdgpu_ualink_drop_msg_bitmap", 0600, root,
>>   			     &adev->ualink.drop_msg_bitmap);
>>   
>> +	mutex_init(&adev->ualink.selftest_mutex);
>> +	/* 64 bytes test size by default */
>> +	adev->ualink.test_size_dwords = 16;
>> +	adev->ualink.test_remote_accel_id = AMDGPU_UALINK_ACCEL_MAX;
>> +
>> +	ualink_test = debugfs_create_dir("amdgpu_ualink_test", root);
>> +	debugfs_create_file("command", 0600, ualink_test, adev,
>> +			    &amdgpu_ualink_command_fops);
>> +	debugfs_create_file("remote_accel_id", 0600, ualink_test, adev,
>> +			    &amdgpu_ualink_accel_id_fops);
>> +	debugfs_create_file("test_size", 0600, ualink_test, adev,
>> +			    &amdgpu_ualink_test_size_fops);
>> +
>>   	adev->debugfs_vbios_blob.data = adev->bios;
>>   	adev->debugfs_vbios_blob.size = adev->bios_size;
>>   	debugfs_create_blob("amdgpu_vbios", 0444, root,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>> index 05bc281216bf..1f83d9b69135 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
>> @@ -97,3 +97,52 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev,
>>   	mutex_unlock(&adev->lsdma.lock);
>>   	return ret;
>>   }
>> +
>> +int amdgpu_lsdma_selftest(struct amdgpu_device *adev)
>> +{
>> +	struct amdgpu_ib ib;
>> +	int i, r;
>> +	u64 gpu_addr;
>> +	char *p;
>> +	u32 size = 128;
>> +
>> +	memset(&ib, 0, sizeof(ib));
>> +	r = amdgpu_ib_get(adev, NULL, 2 * size, AMDGPU_IB_POOL_DIRECT, &ib);
>> +	if (r)
>> +		return r;
>> +
>> +	gpu_addr = ib.gpu_addr;
>> +	p = (char *)ib.ptr;
>> +	memset(p, 0, 2 * size);
>> +
>> +	for (i = 0; i < size; i++)
>> +		*(p + i) = i;
>> +
>> +	dev_dbg(adev->dev, "copy src 0x%llx dst 0x%llx size %d bytes\n",
>> +		gpu_addr, gpu_addr + size, size);
>> +
>> +	r = amdgpu_lsdma_copy_mem(adev, gpu_addr, gpu_addr + size, size);
>> +	if (r)
>> +		goto out;
>> +
>> +	p += size;
>> +	for (i = 0; i < size; i++) {
>> +		if (*(p + i) != i) {
>> +			dev_dbg(adev->dev, "data mismatch expecting 0x%x but read 0x%x\n",
>> +				i, *(p + i));
>> +			break;
>> +		}
>> +	}
>> +	if (i != size)
>> +		r = -EIO;
>> +
>> +out:
>> +	amdgpu_ib_free(&ib, NULL);
>> +
>> +	if (r)
>> +		dev_dbg(adev->dev, "lsdma selftest failed r=%d\n", r);
>> +	else
>> +		dev_dbg(adev->dev, "lsdma selftest passed\n");
>> +
>> +	return r;
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>> index 34e92aaa4617..f0a5eeb3529f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
>> @@ -46,5 +46,6 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev, uint64_t dst_addr,
>>   			  uint32_t data, uint64_t mem_size);
>>   int amdgpu_lsdma_wait_for(struct amdgpu_device *adev, uint32_t reg_index,
>>   			  uint32_t reg_val, uint32_t mask);
>> +int amdgpu_lsdma_selftest(struct amdgpu_device *adev);
>>   
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> index 6cd3927a7e82..d6c4d98f5143 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> @@ -5284,7 +5284,8 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>>   	if (status != AMDGPU_NHT_FW_ST_PREINIT &&
>>   	    status != AMDGPU_NHT_FW_ST_HALT) {
>>   		dev_dbg(adev->dev, "fw status 0x%x not preinit or halt\n", status);
>> -		return -ENODEV;
>> +		if (!adev->ualink.selftesting)
>> +			return -ENODEV;
>>   	}
>>   
>>   	dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
>> @@ -5333,6 +5334,14 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>>   		remote->rb_gpu_addr, remote->rb_cpu_addr, adev->gmc.vram_start,
>>   		adev->vm_manager.vram_base_offset);
>>   
>> +	if (adev->ualink.selftesting) {
>> +		u32 *p = remote->rb_cpu_addr;
>> +		int i;
>> +
>> +		for (i = 0; i < rb_size / 4; i++)
>> +			*(p + i) = 0xdeadbeef;
>> +	}
>> +
>>   	/*
>>   	 * address aliasing mode, shared wptr pagee left is not enough for wb data,
>>   	 * wb status and rptr, alloc another BO, and then alloc npa address and map
>> @@ -5402,6 +5411,8 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>>   	r = adev->ualink.msg_ctl->send_metadata(adev,
>>   						    remote->metadata_gpu_addr,
>>   						    AMDGPU_UALINK_ACCEL_MAX << 8);
>> +	if (r && adev->ualink.selftesting)
>> +		r = 0;
>>   
>>   out:
>>   	if (r)
>> @@ -6387,11 +6398,247 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
>>   	adev->ualink.remote = NULL;
>>   }
>>   
>> +static void dump_buffer(struct amdgpu_device *adev, u32 *src, u32 size_dwords)
>> +{
>> +	u32 i = 0;
>> +	u64 p;
>> +
>> +	dev_dbg(adev->dev, "buffer 0x%p 0x%x dwords\n", src, size_dwords);
>> +
>> +	/* at least 64 bytes dump */
>> +	size_dwords = ALIGN_DOWN(size_dwords, 16);
>> +
>> +	while (i < size_dwords) {
>> +		p = (u64)(src + i);
>> +		dev_dbg(adev->dev, "0x%016llx: 0x%08x 0x%08x 0x%08x 0x%08x\n",
>> +			p,
>> +			*(src + i),
>> +			*(src + i + 1),
>> +			*(src + i + 2),
>> +			*(src + i + 3));
>> +		i += 4;
>> +	}
>> +}
>> +
>> +/*
>> + * With or without MPNHT FW running, write to remote ring buffer
>> + *
>> + * Write 16 dwords (64 bytes) to ring buffer, don't update wptr and ring the doorbell
>> + *
>> + * Dump VRAM content check if remote writing is done correctly
>> + *
>> + * assuming ring buffer is located at VRAM offset 0x60000000
>> + *
>> + * root@atitest-MZ01-CE0-00:/home/atitest# cd /sys/kernel/debug/dri/0/amdgpu_ualink_test
>> + *
>> + * root@atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test# echo 4 > remote_accel_id
>> + *
>> + * root@atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test# echo write_lsdma > command
>> + *
>> + * root@atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0# xxd -e -g 4 -s 0x60000000 -l 64 amdgpu_vram
>> + * 60000000: 00000001 00000002 00000003 00000004	................
>> + * 60000010: 00000005 00000006 00000007 00000008	................
>> + * 60000020: 00000009 0000000a 0000000b 0000000c	................
>> + * 60000030: 0000000d 0000000e 0000000f 00000010	................
>> + *
>> + * root@atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test# echo write_lsdma > command
>> + *
>> + * root@atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0# xxd -e -g 4 -s 0x60000000 -l 64 amdgpu_vram
>> + * 60000000: 00000002 00000003 00000004 00000005	................
>> + * 60000010: 00000006 00000007 00000008 00000009	................
>> + * 60000020: 0000000a 0000000b 0000000c 0000000d	................
>> + * 60000030: 0000000e 0000000f 00000010 00000011	................
>
> This is still very cumbersome to use. You need to figure out physical 
> addresses of the ring buffers. It would be a lot more convenient, if 
> you could read the data directly from debugfs.
>
> I'd suggest replacing the remote access commands 
> (UALINK_TEST_READ_LSDMA, UALINK_TEST_READ_SDMA, 
> UALINK_TEST_WRITE_LSDMA, UALINK_TEST_WRITE_SDMA) with three debugfs 
> files that can be read and written:
>
>   * local_test_data: reads or writes data to the local test buffer
>     (ring buffers) that can be accessed by remote GPU
>   * remote_sdma: reads or writes data to remote GPU using SDMA
>   * remote_lsdma: reads or writes data to remote GPU using LSDMA
>
> Now you have full control over the test data and you can get to the 
> data without having to look at debug logs or using xxd with physical 
> addresses.
>
>
This is good approach, an example for the test will be:

Two nodes: A = accel_id 2, B = accel_id 4.

Part 1 — B stages data, A reads it over UALink

On B, write the pattern into the ring-buffer slice used for traffic with A:

   cd /sys/kernel/debug/dri/0/amdgpu_ualink_test
   echo 2  > remote_accel_id       # A's accel_id
   echo 32 > test_size             # 32 bytes = 8 dwords

   echo "0xdead0001 0xdead0002 0xdead0003 0xdead0004 0xdead0005 
0xdead0006 0xdead0007 0xdead0008" > local_test_data

Optional read-back on B to confirm what was staged:
   cat local_test_data
   0xdead0001 0xdead0002 0xdead0003 0xdead0004 0xdead0005 0xdead0006 
0xdead0007 0xdead0008


On A, pull it across the fabric:

   cd /sys/kernel/debug/dri/0/amdgpu_ualink_test
   echo 4  > remote_accel_id       # B's accel_id
   echo 32 > test_size             # match B so the dumps line up

   cat remote_lsdma
   0xdead0001 0xdead0002 0xdead0003 0xdead0004 0xdead0005 0xdead0006 
0xdead0007 0xdead0008

   cat remote_sdma
   0xdead0001 0xdead0002 0xdead0003 0xdead0004 0xdead0005 0xdead0006 
0xdead0007 0xdead0008


Part 2 — A writes over UALink, B reads locally

On A
   echo "0xbeef0001 0xbeef0002 0xbeef0003 0xbeef0004" > remote_lsdma

On B
   cat local_test_data
   0xbeef0001 0xbeef0002 0xbeef0003 0xbeef0004 0xdead0005 0xdead0006 
0xdead0007 0xdead0008

I will add ualink_test_ function prefix in next version too.

Regards,
Philip
>> + */
>> +int ualink_simple_rw(struct amdgpu_device *adev, u32 remote_accel_id, bool read, bool use_lsdma)
>
> Should these function names have a ualink_test_... prefix?
>
>
>> +{
>> +	struct amdgpu_ualink_remote *remote = to_remote(adev);
>> +	u32 test_size_dwords = adev->ualink.test_size_dwords;
>> +	struct amdgpu_ualink_peer *peer;
>> +	struct amdgpu_ualink_ring *ring;
>> +	struct dma_fence *fence;
>> +	struct amdgpu_job *job;
>> +	struct amdgpu_ib *ib;
>> +	u32 seq, ndw, ndw_copy_cmd;
>> +	u32 *src_cpu;
>> +	u64 src;
>> +	int r, i;
>> +
>> +	if (!remote)
>> +		return -EINVAL;
>> +
>> +	peer = &remote->peer[remote_accel_id];
>> +	ring = &peer->interrupt;
>> +
>> +	/*
>> +	 * 1 sdma copy command to write data to ring buffer
>> +	 *
>> +	 * sdma linear copy command is 7 dwords, align to 8 dwords boundary
>> +	 */
>> +	ndw_copy_cmd = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
>> +
>> +	/*
>> +	 * 16 dwords data
>> +	 */
>> +	ndw = ndw_copy_cmd + test_size_dwords;
>> +	r = amdgpu_job_alloc_with_ib(adev, &peer->entity, AMDGPU_FENCE_OWNER_VM,
>> +				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
>> +				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
>> +	if (r)
>> +		return r;
>> +
>> +	mutex_lock(&peer->lock);
>> +
>> +	ib = job->ibs;
>> +	ib->length_dw = 0;
>> +	src = ib->gpu_addr + ndw_copy_cmd * 4;
>> +	src_cpu = ib->ptr + ndw_copy_cmd;
>> +
>> +	seq = ++ring->seq;
>> +
>> +	dev_dbg(adev->dev, "src 0x%llx to npa on gart rb 0x%llx seq 0x%x %s %s\n",
>> +		src, ring->rb_npa_gart, seq, read ? "read" : "write",
>> +		use_lsdma ? "use lsdma" : "use sdma");
>> +
>> +	for (i = 0; i < test_size_dwords; i++)
>> +		*src_cpu++ = seq + i;
>> +
>> +	dev_dbg(adev->dev, "dump test buffer data\n");
>> +	dump_buffer(adev, ib->ptr + ndw_copy_cmd, test_size_dwords);
>> +
>> +	remote->use_lsdma = use_lsdma;
>> +
>> +	dev_dbg(adev->dev, "use %s\n", remote->use_lsdma ? "lsdma" : "sdma");
>> +
>> +	if (remote->use_lsdma) {
>> +		if (read)
>> +			r = amdgpu_lsdma_copy_mem(adev, ring->rb_npa_gart, src,
>> +						  test_size_dwords * 4);
>> +		else
>> +			r = amdgpu_lsdma_copy_mem(adev, src, ring->rb_npa_gart,
>> +						  test_size_dwords * 4);
>> +
>> +		amdgpu_job_free(job);
>> +		goto out_unlock;
>> +	}
>> +
>> +	/* SDMA commands copy from ib to NPA */
>> +	if (read)
>> +		amdgpu_emit_copy_buffer(adev, ib, ring->rb_npa_gart, src,
>> +					test_size_dwords * 4, 0);
>> +	else
>> +		amdgpu_emit_copy_buffer(adev, ib, src, ring->rb_npa_gart,
>> +					test_size_dwords * 4, 0);
>> +
>> +	amdgpu_ring_pad_ib(&adev->sdma.instance[0].ring, ib);
>> +	WARN_ON(ib->length_dw > ndw_copy_cmd);
>> +
>> +	fence = amdgpu_job_submit(job);
>> +
>> +	/*
>> +	 * wait sdma done
>> +	 */
>> +	r = dma_fence_wait_timeout(fence, false, HZ * 10);
>> +	dma_fence_put(fence);
>> +	if (r <= 0) {
>> +		dev_dbg(adev->dev, "remote sdma fence wait timeout %d\n", r);
>> +		dev_dbg(adev->dev, "use lsdma for testing afterwards\n");
>> +		remote->use_lsdma = true;
>> +		r = -ETIME;
>> +	} else {
>> +		r = 0;
>> +	}
>> +
>> +out_unlock:
>> +	mutex_unlock(&peer->lock);
>> +	if (read) {
>> +		dev_dbg(adev->dev, "dump remote read data\n");
>> +		dump_buffer(adev, ib->ptr + ndw_copy_cmd, test_size_dwords);
>> +	}
>> +
>> +	dev_dbg(adev->dev, "ret r=%d\n", r);
>> +	return r;
>> +}
>> +
>> +/* The peer may have rebooted or the vpod was reconfigured, adopt the remote
>> + * wptr before sending a command, same as the handshake does.
>> + */
>> +static int ualink_resync_peer(struct amdgpu_device *adev, u32 remote_accel_id)
>> +{
>> +	int r;
>> +
>> +	if (!adev->ualink.remote)
>> +		return -EINVAL;
>> +
>> +	r = amdgpu_ualink_ring_resync_ptrs(adev, remote_accel_id);
>> +	if (r < 0)
>> +		return r;
>> +
>> +	amdgpu_ualink_reset_peer_rings(adev, remote_accel_id);
>> +
>> +	return 0;
>> +}
>> +
>>   int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id)
>>   {
>> +	int r;
>> +
>> +	r = ualink_resync_peer(adev, remote_accel_id);
>> +	if (r)
>> +		return r;
>> +
>>   	return amdgpu_ualink_send_hello_msg(adev, remote_accel_id);
>>   }
>>   
>> +void ualink_flush_tlb(struct amdgpu_device *amdgpu, u32 flush_type)
>> +{
>> +	amdgpu_ualink_flush_tlb(amdgpu, flush_type);
>
> This function is just a wrapper with the exact same signature. Maybe 
> just make the original function non-static and call it directly.
>
> Regards,
>   Felix
>
>
>> +}
>> +
>> +int ualink_remote_shootdown(struct amdgpu_device *adev, u32 remote_accel_id, u64 addr,
>> +			    u32 size_in_pages, u32 flush_type)
>> +{
>> +	int r;
>> +
>> +	r = ualink_resync_peer(adev, remote_accel_id);
>> +	if (r)
>> +		return r;
>> +
>> +	return amdgpu_ualink_remote_shootdown(adev, remote_accel_id, addr,
>> +					      size_in_pages, flush_type);
>> +}
>> +
>> +int ualink_update_interrupt_wb(struct amdgpu_device *adev, u32 remote_accel_id)
>> +{
>> +	int r;
>> +
>> +	r = ualink_resync_peer(adev, remote_accel_id);
>> +	if (r)
>> +		return r;
>> +
>> +	guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
>> +
>> +	/* Update interrupt completion write back address */
>> +	r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>> +					    RB_TYPE_REMOTE_INTERRUPT);
>> +	return r;
>> +}
>> +
>> +int ualink_update_shootdown_wb(struct amdgpu_device *adev, u32 remote_accel_id)
>> +{
>> +	int r;
>> +
>> +	r = ualink_resync_peer(adev, remote_accel_id);
>> +	if (r)
>> +		return r;
>> +
>> +	guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
>> +
>> +	/* Update shootdown completion write back address */
>> +	r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
>> +					    RB_TYPE_TLB_INV);
>> +	return r;
>> +}
>> +
>>   /*
>>    * The low bits of handle_lo carry the message-header field on the wire.
>>    * Strip those bits and splice in @acc_id to recover the
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>> index 85c9a9634a4b..b381e378dae2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>> @@ -333,6 +333,13 @@ struct amdgpu_ualink_mgr {
>>   	/* For remote interrupt and shootdown */
>>   	struct amdgpu_ualink_remote *remote;
>>   
>> +	/* true for selftest driver path, ignore FW error */
>> +	bool selftesting;
>> +	/* serialize the selftest debugfs entries */
>> +	struct mutex selftest_mutex;
>> +	u32 test_size_dwords;
>> +	u32 test_remote_accel_id;
>> +
>>   	/* handle irq from ualink client of remote GPUs */
>>   	struct amdgpu_irq_src irq;
>>   
>> @@ -393,6 +400,14 @@ struct amdgpu_ualink_mgr {
>>   int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev,
>>   				 unsigned int client_id, unsigned int src_id);
>>   
>> +int ualink_simple_rw(struct amdgpu_device *adev, u32 remote_accel_id, bool read, bool use_lsdma);
>> +int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
>> +void ualink_flush_tlb(struct amdgpu_device *amdgpu, u32 flush_type);
>> +int ualink_remote_shootdown(struct amdgpu_device *adev, u32 remote_accel_id, u64 addr,
>> +			    u32 size_in_pages, u32 flush_type);
>> +int ualink_update_interrupt_wb(struct amdgpu_device *adev, u32 remote_accel_id);
>> +int ualink_update_shootdown_wb(struct amdgpu_device *adev, u32 remote_accel_id);
>> +
>>   int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
>>   void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
>>   

--------------ErJZlfqeviy5YTrWEJJTcmEr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-10-13 18:32, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a9ead820-9869-4280-b086-76933de4dd34@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2026-10-13 14:10, Philip Yang
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20261013181010.1886675-1-Philip.Yang@amd.com">
        <pre wrap="" class="moz-quote-pre">Add debugfs directory &quot;amdgpu_ualink_test&quot; to trigger UALink selftests
without userspace application, with three read/write entries:

  command          write the test name to run it, read to list the
                   valid test names
  remote_accel_id  accel_id of the remote GPU used by the tests
  test_size        test buffer size in bytes, from 4 to 8192

Add helper functions: ualink_simple_rw() for remote VRAM R/W,
ualink_remote_shootdown() for TLB shootdown, ualink_send_hello()
for handshake, ualink_update_interrupt_wb()
and ualink_update_shootdown_wb() to read writeback results.
Use lsdma by default, can select sdma with command.

v4: Use a single &quot;command&quot; entry taking the test name, instead of one
    entry per test (Felix).
    Resync the remote wptr before sending a command, the peer may have
    rebooted.
v3: Replace the single entry taking a test number with a debugfs
    directory and a named entry per command.
    Take peer-&gt;lock to update the writeback address and selftest_mutex
    to read the test parameters.
v2: Fix typos and issues from copilot code review.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 241 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c   |  49 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c  | 249 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h  |  15 ++
 5 files changed, 554 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 3dc95d9accf2..a898a24fda0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2133,9 +2133,237 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, &quot;%llu\n&quot;);
 
+enum amdgpu_ualink_test_cmd {
+	UALINK_TEST_SW_INIT,
+	UALINK_TEST_SEND_HELLO,
+	UALINK_TEST_REMOTE_SHOOTDOWN,
+	UALINK_TEST_FLUSH_TLB,
+	UALINK_TEST_READ_LSDMA,
+	UALINK_TEST_READ_SDMA,
+	UALINK_TEST_WRITE_LSDMA,
+	UALINK_TEST_WRITE_SDMA,
+	UALINK_TEST_UPDATE_INTERRUPT_WB,
+	UALINK_TEST_UPDATE_SHOOTDOWN_WB,
+	UALINK_TEST_LSDMA_SELFTEST,
+};
+
+/* commands talking to a remote accelerator, remote_accel_id must be set */
+#define UALINK_TEST_NEEDS_ACCEL_ID					\
+	(BIT(UALINK_TEST_SEND_HELLO) | BIT(UALINK_TEST_REMOTE_SHOOTDOWN) | \
+	 BIT(UALINK_TEST_READ_LSDMA) | BIT(UALINK_TEST_READ_SDMA) |	\
+	 BIT(UALINK_TEST_WRITE_LSDMA) | BIT(UALINK_TEST_WRITE_SDMA) |	\
+	 BIT(UALINK_TEST_UPDATE_INTERRUPT_WB) |				\
+	 BIT(UALINK_TEST_UPDATE_SHOOTDOWN_WB))
+
+static int amdgpu_debugfs_ualink_test_run(struct amdgpu_device *adev,
+					  enum amdgpu_ualink_test_cmd cmd)
+{
+	u32 remote_accel_id = adev-&gt;ualink.test_remote_accel_id;
+	int r = 0;
+
+	guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
+
+	if ((BIT(cmd) &amp; UALINK_TEST_NEEDS_ACCEL_ID) &amp;&amp;
+	    remote_accel_id &gt;= AMDGPU_UALINK_ACCEL_MAX) {
+		dev_err(adev-&gt;dev, &quot;set remote_accel_id first\n&quot;);
+		return -EINVAL;
+	}
+
+	adev-&gt;ualink.selftesting = true;
+
+	switch (cmd) {
+	case UALINK_TEST_SW_INIT:
+		if (adev-&gt;ualink.remote)
+			amdgpu_ualink_sw_fini(adev);
+
+		dev_dbg(adev-&gt;dev, &quot;load metadata init MPNHT firmware\n&quot;);
+		r = amdgpu_ualink_sw_init(adev);
+		break;
+	case UALINK_TEST_SEND_HELLO:
+		r = ualink_send_hello(adev, remote_accel_id);
+		break;
+	case UALINK_TEST_REMOTE_SHOOTDOWN:
+		r = ualink_remote_shootdown(adev, remote_accel_id, 1UL &lt;&lt; 30, 1,
+					    TLB_FLUSH_HEAVYWEIGHT);
+		break;
+	case UALINK_TEST_FLUSH_TLB:
+		ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
+		break;
+	case UALINK_TEST_READ_LSDMA:
+		r = ualink_simple_rw(adev, remote_accel_id, true, true);
+		break;
+	case UALINK_TEST_READ_SDMA:
+		r = ualink_simple_rw(adev, remote_accel_id, true, false);
+		break;
+	case UALINK_TEST_WRITE_LSDMA:
+		r = ualink_simple_rw(adev, remote_accel_id, false, true);
+		break;
+	case UALINK_TEST_WRITE_SDMA:
+		r = ualink_simple_rw(adev, remote_accel_id, false, false);
+		break;
+	case UALINK_TEST_UPDATE_INTERRUPT_WB:
+		r = ualink_update_interrupt_wb(adev, remote_accel_id);
+		break;
+	case UALINK_TEST_UPDATE_SHOOTDOWN_WB:
+		r = ualink_update_shootdown_wb(adev, remote_accel_id);
+		break;
+	case UALINK_TEST_LSDMA_SELFTEST:
+		r = adev-&gt;lsdma.funcs ? amdgpu_lsdma_selftest(adev) : -EOPNOTSUPP;
+		break;
+	}
+
+	adev-&gt;ualink.selftesting = false;
+
+	dev_dbg(adev-&gt;dev, &quot;ualink test cmd %d remote_accel_id %u ret %d\n&quot;,
+		cmd, remote_accel_id, r);
+
+	return r;
+}
+
+#define UALINK_TEST_CMD_NAME_MAX	32
+
+static const char * const amdgpu_ualink_test_cmd_name[] = {
+	[UALINK_TEST_SW_INIT]			= &quot;sw_init&quot;,
+	[UALINK_TEST_SEND_HELLO]		= &quot;send_hello&quot;,
+	[UALINK_TEST_REMOTE_SHOOTDOWN]		= &quot;remote_shootdown&quot;,
+	[UALINK_TEST_FLUSH_TLB]			= &quot;flush_tlb&quot;,
+	[UALINK_TEST_READ_LSDMA]		= &quot;read_lsdma&quot;,
+	[UALINK_TEST_READ_SDMA]			= &quot;read_sdma&quot;,
+	[UALINK_TEST_WRITE_LSDMA]		= &quot;write_lsdma&quot;,
+	[UALINK_TEST_WRITE_SDMA]		= &quot;write_sdma&quot;,
+	[UALINK_TEST_UPDATE_INTERRUPT_WB]	= &quot;update_interrupt_wb&quot;,
+	[UALINK_TEST_UPDATE_SHOOTDOWN_WB]	= &quot;update_shootdown_wb&quot;,
+	[UALINK_TEST_LSDMA_SELFTEST]		= &quot;lsdma_selftest&quot;,
+};
+
+static ssize_t amdgpu_debugfs_ualink_command_read(struct file *file,
+						  char __user *ubuf,
+						  size_t len, loff_t *offp)
+{
+	char buf[UALINK_TEST_CMD_NAME_MAX * ARRAY_SIZE(amdgpu_ualink_test_cmd_name)];
+	unsigned int i;
+	int n = 0;
+
+	for (i = 0; i &lt; ARRAY_SIZE(amdgpu_ualink_test_cmd_name); i++)
+		n += scnprintf(buf + n, sizeof(buf) - n, &quot;%s\n&quot;,
+			       amdgpu_ualink_test_cmd_name[i]);
+
+	return simple_read_from_buffer(ubuf, len, offp, buf, n);
+}
+
+static ssize_t amdgpu_debugfs_ualink_command_write(struct file *file,
+						   const char __user *ubuf,
+						   size_t len, loff_t *offp)
+{
+	struct amdgpu_device *adev = file-&gt;private_data;
+	char buf[UALINK_TEST_CMD_NAME_MAX];
+	int cmd, r;
+
+	if (len &gt;= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, ubuf, len))
+		return -EFAULT;
+
+	buf[len] = '\0';
+	cmd = sysfs_match_string(amdgpu_ualink_test_cmd_name, strim(buf));
+	if (cmd &lt; 0) {
+		dev_err(adev-&gt;dev, &quot;unknown ualink test command\n&quot;);
+		return cmd;
+	}
+
+	r = amdgpu_debugfs_ualink_test_run(adev, cmd);
+	if (r)
+		return r;
+
+	return len;
+}
+
+static const struct file_operations amdgpu_ualink_command_fops = {
+	.owner	 = THIS_MODULE,
+	.open	 = simple_open,
+	.read	 = amdgpu_debugfs_ualink_command_read,
+	.write	 = amdgpu_debugfs_ualink_command_write,
+	.llseek	 = default_llseek,
+};
+
+static int amdgpu_debugfs_ualink_accel_id_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = data;
+
+	guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
+
+	*val = adev-&gt;ualink.test_remote_accel_id;
+
+	return 0;
+}
+
+static int amdgpu_debugfs_ualink_accel_id_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+
+	if (!adev-&gt;ualink.info)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
+
+	if (val &gt;= AMDGPU_UALINK_ACCEL_MAX ||
+	    !test_bit(val, adev-&gt;ualink.info-&gt;vpod.active_accel_bits)) {
+		dev_err(adev-&gt;dev, &quot;invalid remote accel_id %llu\n&quot;, val);
+		return -EINVAL;
+	}
+
+	if (val == adev-&gt;ualink.info-&gt;ppod.accel_id) {
+		dev_err(adev-&gt;dev, &quot;remote accel_id equals to local accel_id\n&quot;);
+		return -EINVAL;
+	}
+
+	adev-&gt;ualink.test_remote_accel_id = val;
+	dev_info(adev-&gt;dev, &quot;set remote accel_id to %llu, local accel_id %u\n&quot;,
+		 val, adev-&gt;ualink.info-&gt;ppod.accel_id);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_accel_id_fops,
+			 amdgpu_debugfs_ualink_accel_id_get,
+			 amdgpu_debugfs_ualink_accel_id_set, &quot;%llu\n&quot;);
+
+static int amdgpu_debugfs_ualink_test_size_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = data;
+
+	guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
+
+	*val = adev-&gt;ualink.test_size_dwords * 4;
+
+	return 0;
+}
+
+static int amdgpu_debugfs_ualink_test_size_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+
+	if (val &lt; 4 || val &gt; 8192)
+		return -EINVAL;
+
+	guard(mutex)(&amp;adev-&gt;ualink.selftest_mutex);
+
+	adev-&gt;ualink.test_size_dwords = val / 4;
+	dev_dbg(adev-&gt;dev, &quot;test buffer size %u bytes\n&quot;,
+		adev-&gt;ualink.test_size_dwords * 4);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_test_size_fops,
+			 amdgpu_debugfs_ualink_test_size_get,
+			 amdgpu_debugfs_ualink_test_size_set, &quot;%llu\n&quot;);
+
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
 	struct dentry *root = adev_to_drm(adev)-&gt;primary-&gt;debugfs_root;
+	struct dentry *ualink_test;
 	struct dentry *ent;
 	int r, i;
 
@@ -2246,6 +2474,19 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_ulong(&quot;amdgpu_ualink_drop_msg_bitmap&quot;, 0600, root,
 			     &amp;adev-&gt;ualink.drop_msg_bitmap);
 
+	mutex_init(&amp;adev-&gt;ualink.selftest_mutex);
+	/* 64 bytes test size by default */
+	adev-&gt;ualink.test_size_dwords = 16;
+	adev-&gt;ualink.test_remote_accel_id = AMDGPU_UALINK_ACCEL_MAX;
+
+	ualink_test = debugfs_create_dir(&quot;amdgpu_ualink_test&quot;, root);
+	debugfs_create_file(&quot;command&quot;, 0600, ualink_test, adev,
+			    &amp;amdgpu_ualink_command_fops);
+	debugfs_create_file(&quot;remote_accel_id&quot;, 0600, ualink_test, adev,
+			    &amp;amdgpu_ualink_accel_id_fops);
+	debugfs_create_file(&quot;test_size&quot;, 0600, ualink_test, adev,
+			    &amp;amdgpu_ualink_test_size_fops);
+
 	adev-&gt;debugfs_vbios_blob.data = adev-&gt;bios;
 	adev-&gt;debugfs_vbios_blob.size = adev-&gt;bios_size;
 	debugfs_create_blob(&quot;amdgpu_vbios&quot;, 0444, root,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
index 05bc281216bf..1f83d9b69135 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
@@ -97,3 +97,52 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev,
 	mutex_unlock(&amp;adev-&gt;lsdma.lock);
 	return ret;
 }
+
+int amdgpu_lsdma_selftest(struct amdgpu_device *adev)
+{
+	struct amdgpu_ib ib;
+	int i, r;
+	u64 gpu_addr;
+	char *p;
+	u32 size = 128;
+
+	memset(&amp;ib, 0, sizeof(ib));
+	r = amdgpu_ib_get(adev, NULL, 2 * size, AMDGPU_IB_POOL_DIRECT, &amp;ib);
+	if (r)
+		return r;
+
+	gpu_addr = ib.gpu_addr;
+	p = (char *)ib.ptr;
+	memset(p, 0, 2 * size);
+
+	for (i = 0; i &lt; size; i++)
+		*(p + i) = i;
+
+	dev_dbg(adev-&gt;dev, &quot;copy src 0x%llx dst 0x%llx size %d bytes\n&quot;,
+		gpu_addr, gpu_addr + size, size);
+
+	r = amdgpu_lsdma_copy_mem(adev, gpu_addr, gpu_addr + size, size);
+	if (r)
+		goto out;
+
+	p += size;
+	for (i = 0; i &lt; size; i++) {
+		if (*(p + i) != i) {
+			dev_dbg(adev-&gt;dev, &quot;data mismatch expecting 0x%x but read 0x%x\n&quot;,
+				i, *(p + i));
+			break;
+		}
+	}
+	if (i != size)
+		r = -EIO;
+
+out:
+	amdgpu_ib_free(&amp;ib, NULL);
+
+	if (r)
+		dev_dbg(adev-&gt;dev, &quot;lsdma selftest failed r=%d\n&quot;, r);
+	else
+		dev_dbg(adev-&gt;dev, &quot;lsdma selftest passed\n&quot;);
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
index 34e92aaa4617..f0a5eeb3529f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
@@ -46,5 +46,6 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev, uint64_t dst_addr,
 			  uint32_t data, uint64_t mem_size);
 int amdgpu_lsdma_wait_for(struct amdgpu_device *adev, uint32_t reg_index,
 			  uint32_t reg_val, uint32_t mask);
+int amdgpu_lsdma_selftest(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 6cd3927a7e82..d6c4d98f5143 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5284,7 +5284,8 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	if (status != AMDGPU_NHT_FW_ST_PREINIT &amp;&amp;
 	    status != AMDGPU_NHT_FW_ST_HALT) {
 		dev_dbg(adev-&gt;dev, &quot;fw status 0x%x not preinit or halt\n&quot;, status);
-		return -ENODEV;
+		if (!adev-&gt;ualink.selftesting)
+			return -ENODEV;
 	}
 
 	dev_dbg(adev-&gt;dev, &quot;accel_id %u addr_mode %d fw status 0x%x\n&quot;,
@@ -5333,6 +5334,14 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 		remote-&gt;rb_gpu_addr, remote-&gt;rb_cpu_addr, adev-&gt;gmc.vram_start,
 		adev-&gt;vm_manager.vram_base_offset);
 
+	if (adev-&gt;ualink.selftesting) {
+		u32 *p = remote-&gt;rb_cpu_addr;
+		int i;
+
+		for (i = 0; i &lt; rb_size / 4; i++)
+			*(p + i) = 0xdeadbeef;
+	}
+
 	/*
 	 * address aliasing mode, shared wptr pagee left is not enough for wb data,
 	 * wb status and rptr, alloc another BO, and then alloc npa address and map
@@ -5402,6 +5411,8 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	r = adev-&gt;ualink.msg_ctl-&gt;send_metadata(adev,
 						    remote-&gt;metadata_gpu_addr,
 						    AMDGPU_UALINK_ACCEL_MAX &lt;&lt; 8);
+	if (r &amp;&amp; adev-&gt;ualink.selftesting)
+		r = 0;
 
 out:
 	if (r)
@@ -6387,11 +6398,247 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
 	adev-&gt;ualink.remote = NULL;
 }
 
+static void dump_buffer(struct amdgpu_device *adev, u32 *src, u32 size_dwords)
+{
+	u32 i = 0;
+	u64 p;
+
+	dev_dbg(adev-&gt;dev, &quot;buffer 0x%p 0x%x dwords\n&quot;, src, size_dwords);
+
+	/* at least 64 bytes dump */
+	size_dwords = ALIGN_DOWN(size_dwords, 16);
+
+	while (i &lt; size_dwords) {
+		p = (u64)(src + i);
+		dev_dbg(adev-&gt;dev, &quot;0x%016llx: 0x%08x 0x%08x 0x%08x 0x%08x\n&quot;,
+			p,
+			*(src + i),
+			*(src + i + 1),
+			*(src + i + 2),
+			*(src + i + 3));
+		i += 4;
+	}
+}
+
+/*
+ * With or without MPNHT FW running, write to remote ring buffer
+ *
+ * Write 16 dwords (64 bytes) to ring buffer, don't update wptr and ring the doorbell
+ *
+ * Dump VRAM content check if remote writing is done correctly
+ *
+ * assuming ring buffer is located at VRAM offset 0x60000000
+ *
+ * root@<a class="moz-txt-link-freetext" href="atitest-MZ01-CE0-00:/home/atitest#" moz-do-not-send="true">atitest-MZ01-CE0-00:/home/atitest#</a> cd /sys/kernel/debug/dri/0/amdgpu_ualink_test
+ *
+ * root@<a class="moz-txt-link-freetext" href="atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test#" moz-do-not-send="true">atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test#</a> echo 4 &gt; remote_accel_id
+ *
+ * root@<a class="moz-txt-link-freetext" href="atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test#" moz-do-not-send="true">atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test#</a> echo write_lsdma &gt; command
+ *
+ * root@<a class="moz-txt-link-freetext" href="atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0#" moz-do-not-send="true">atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0#</a> xxd -e -g 4 -s 0x60000000 -l 64 amdgpu_vram
+ * 60000000: 00000001 00000002 00000003 00000004	................
+ * 60000010: 00000005 00000006 00000007 00000008	................
+ * 60000020: 00000009 0000000a 0000000b 0000000c	................
+ * 60000030: 0000000d 0000000e 0000000f 00000010	................
+ *
+ * root@<a class="moz-txt-link-freetext" href="atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test#" moz-do-not-send="true">atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0/amdgpu_ualink_test#</a> echo write_lsdma &gt; command
+ *
+ * root@<a class="moz-txt-link-freetext" href="atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0#" moz-do-not-send="true">atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0#</a> xxd -e -g 4 -s 0x60000000 -l 64 amdgpu_vram
+ * 60000000: 00000002 00000003 00000004 00000005	................
+ * 60000010: 00000006 00000007 00000008 00000009	................
+ * 60000020: 0000000a 0000000b 0000000c 0000000d	................
+ * 60000030: 0000000e 0000000f 00000010 00000011	................</pre>
      </blockquote>
      <p>This is still very cumbersome to use. You need to figure out
        physical addresses of the ring buffers. It would be a lot more
        convenient, if you could read the data directly from debugfs.</p>
      <p>I'd suggest replacing the remote access commands
        (UALINK_TEST_READ_LSDMA, UALINK_TEST_READ_SDMA,
        UALINK_TEST_WRITE_LSDMA, UALINK_TEST_WRITE_SDMA) with three
        debugfs files that can be read and written:</p>
      <ul>
        <li>local_test_data: reads or writes data to the local test
          buffer (ring buffers) that can be accessed by remote GPU</li>
        <li>remote_sdma: reads or writes data to remote GPU using SDMA</li>
        <li>remote_lsdma: reads or writes data to remote GPU using LSDMA</li>
      </ul>
      <p>Now you have full control over the test data and you can get to
        the data without having to look at debug logs or using xxd with
        physical addresses.</p>
      <p><br>
      </p>
    </blockquote>
    This is good approach, an example for the test will be:<br>
    <br>
    Two nodes: A = accel_id 2, B = accel_id 4.<br>
    <br>
    Part 1 — B stages data, A reads it over UALink<br>
    <br>
    On B, write the pattern into the ring-buffer slice used for traffic
    with A:<br>
    <br>
    &nbsp; cd /sys/kernel/debug/dri/0/amdgpu_ualink_test<br>
    &nbsp; echo 2&nbsp; &gt; remote_accel_id&nbsp; &nbsp; &nbsp; &nbsp;# A's accel_id<br>
    &nbsp; echo 32 &gt; test_size&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# 32 bytes = 8 dwords<br>
    <br>
    &nbsp; echo &quot;0xdead0001 0xdead0002 0xdead0003 0xdead0004 0xdead0005
    0xdead0006 0xdead0007 0xdead0008&quot; &gt; local_test_data<br>
    <br>
    Optional read-back on B to confirm what was staged:<br>
    &nbsp; cat local_test_data<br>
    &nbsp; 0xdead0001 0xdead0002 0xdead0003 0xdead0004 0xdead0005 0xdead0006
    0xdead0007 0xdead0008<br>
    <br>
    <br>
    On A, pull it across the fabric:<br>
    <br>
    &nbsp; cd /sys/kernel/debug/dri/0/amdgpu_ualink_test<br>
    &nbsp; echo 4&nbsp; &gt; remote_accel_id&nbsp; &nbsp; &nbsp; &nbsp;# B's accel_id<br>
    &nbsp; echo 32 &gt; test_size&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# match B so the dumps line up<br>
    <br>
    &nbsp; cat remote_lsdma<br>
    &nbsp; 0xdead0001 0xdead0002 0xdead0003 0xdead0004 0xdead0005 0xdead0006
    0xdead0007 0xdead0008<br>
    <br>
    &nbsp; cat remote_sdma<br>
    &nbsp; 0xdead0001 0xdead0002 0xdead0003 0xdead0004 0xdead0005 0xdead0006
    0xdead0007 0xdead0008<br>
    <br>
    <br>
    Part 2 — A writes over UALink, B reads locally<br>
    <br>
    On A<br>
    &nbsp; echo &quot;0xbeef0001 0xbeef0002 0xbeef0003 0xbeef0004&quot; &gt;
    remote_lsdma<br>
    <br>
    On B<br>
    &nbsp; cat local_test_data<br>
    &nbsp; 0xbeef0001 0xbeef0002 0xbeef0003 0xbeef0004 0xdead0005 0xdead0006
    0xdead0007 0xdead0008<br>
    <br>
    I will add ualink_test_ function prefix in next version too.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:a9ead820-9869-4280-b086-76933de4dd34@amd.com">
      <blockquote type="cite" cite="mid:20261013181010.1886675-1-Philip.Yang@amd.com">
        <pre wrap="" class="moz-quote-pre">+ */
+int ualink_simple_rw(struct amdgpu_device *adev, u32 remote_accel_id, bool read, bool use_lsdma)</pre>
      </blockquote>
      <p>Should these function names have a ualink_test_... prefix?</p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:20261013181010.1886675-1-Philip.Yang@amd.com">
        <pre wrap="" class="moz-quote-pre">+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	u32 test_size_dwords = adev-&gt;ualink.test_size_dwords;
+	struct amdgpu_ualink_peer *peer;
+	struct amdgpu_ualink_ring *ring;
+	struct dma_fence *fence;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
+	u32 seq, ndw, ndw_copy_cmd;
+	u32 *src_cpu;
+	u64 src;
+	int r, i;
+
+	if (!remote)
+		return -EINVAL;
+
+	peer = &amp;remote-&gt;peer[remote_accel_id];
+	ring = &amp;peer-&gt;interrupt;
+
+	/*
+	 * 1 sdma copy command to write data to ring buffer
+	 *
+	 * sdma linear copy command is 7 dwords, align to 8 dwords boundary
+	 */
+	ndw_copy_cmd = ALIGN(adev-&gt;mman.buffer_funcs-&gt;copy_num_dw, 8);
+
+	/*
+	 * 16 dwords data
+	 */
+	ndw = ndw_copy_cmd + test_size_dwords;
+	r = amdgpu_job_alloc_with_ib(adev, &amp;peer-&gt;entity, AMDGPU_FENCE_OWNER_VM,
+				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
+				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &amp;job);
+	if (r)
+		return r;
+
+	mutex_lock(&amp;peer-&gt;lock);
+
+	ib = job-&gt;ibs;
+	ib-&gt;length_dw = 0;
+	src = ib-&gt;gpu_addr + ndw_copy_cmd * 4;
+	src_cpu = ib-&gt;ptr + ndw_copy_cmd;
+
+	seq = ++ring-&gt;seq;
+
+	dev_dbg(adev-&gt;dev, &quot;src 0x%llx to npa on gart rb 0x%llx seq 0x%x %s %s\n&quot;,
+		src, ring-&gt;rb_npa_gart, seq, read ? &quot;read&quot; : &quot;write&quot;,
+		use_lsdma ? &quot;use lsdma&quot; : &quot;use sdma&quot;);
+
+	for (i = 0; i &lt; test_size_dwords; i++)
+		*src_cpu++ = seq + i;
+
+	dev_dbg(adev-&gt;dev, &quot;dump test buffer data\n&quot;);
+	dump_buffer(adev, ib-&gt;ptr + ndw_copy_cmd, test_size_dwords);
+
+	remote-&gt;use_lsdma = use_lsdma;
+
+	dev_dbg(adev-&gt;dev, &quot;use %s\n&quot;, remote-&gt;use_lsdma ? &quot;lsdma&quot; : &quot;sdma&quot;);
+
+	if (remote-&gt;use_lsdma) {
+		if (read)
+			r = amdgpu_lsdma_copy_mem(adev, ring-&gt;rb_npa_gart, src,
+						  test_size_dwords * 4);
+		else
+			r = amdgpu_lsdma_copy_mem(adev, src, ring-&gt;rb_npa_gart,
+						  test_size_dwords * 4);
+
+		amdgpu_job_free(job);
+		goto out_unlock;
+	}
+
+	/* SDMA commands copy from ib to NPA */
+	if (read)
+		amdgpu_emit_copy_buffer(adev, ib, ring-&gt;rb_npa_gart, src,
+					test_size_dwords * 4, 0);
+	else
+		amdgpu_emit_copy_buffer(adev, ib, src, ring-&gt;rb_npa_gart,
+					test_size_dwords * 4, 0);
+
+	amdgpu_ring_pad_ib(&amp;adev-&gt;sdma.instance[0].ring, ib);
+	WARN_ON(ib-&gt;length_dw &gt; ndw_copy_cmd);
+
+	fence = amdgpu_job_submit(job);
+
+	/*
+	 * wait sdma done
+	 */
+	r = dma_fence_wait_timeout(fence, false, HZ * 10);
+	dma_fence_put(fence);
+	if (r &lt;= 0) {
+		dev_dbg(adev-&gt;dev, &quot;remote sdma fence wait timeout %d\n&quot;, r);
+		dev_dbg(adev-&gt;dev, &quot;use lsdma for testing afterwards\n&quot;);
+		remote-&gt;use_lsdma = true;
+		r = -ETIME;
+	} else {
+		r = 0;
+	}
+
+out_unlock:
+	mutex_unlock(&amp;peer-&gt;lock);
+	if (read) {
+		dev_dbg(adev-&gt;dev, &quot;dump remote read data\n&quot;);
+		dump_buffer(adev, ib-&gt;ptr + ndw_copy_cmd, test_size_dwords);
+	}
+
+	dev_dbg(adev-&gt;dev, &quot;ret r=%d\n&quot;, r);
+	return r;
+}
+
+/* The peer may have rebooted or the vpod was reconfigured, adopt the remote
+ * wptr before sending a command, same as the handshake does.
+ */
+static int ualink_resync_peer(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	int r;
+
+	if (!adev-&gt;ualink.remote)
+		return -EINVAL;
+
+	r = amdgpu_ualink_ring_resync_ptrs(adev, remote_accel_id);
+	if (r &lt; 0)
+		return r;
+
+	amdgpu_ualink_reset_peer_rings(adev, remote_accel_id);
+
+	return 0;
+}
+
 int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id)
 {
+	int r;
+
+	r = ualink_resync_peer(adev, remote_accel_id);
+	if (r)
+		return r;
+
 	return amdgpu_ualink_send_hello_msg(adev, remote_accel_id);
 }
 
+void ualink_flush_tlb(struct amdgpu_device *amdgpu, u32 flush_type)
+{
+	amdgpu_ualink_flush_tlb(amdgpu, flush_type);</pre>
      </blockquote>
      <p>This function is just a wrapper with the exact same signature.
        Maybe just make the original function non-static and call it
        directly.</p>
      <p>Regards,<br>
        &nbsp; Felix</p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:20261013181010.1886675-1-Philip.Yang@amd.com">
        <pre wrap="" class="moz-quote-pre">+}
+
+int ualink_remote_shootdown(struct amdgpu_device *adev, u32 remote_accel_id, u64 addr,
+			    u32 size_in_pages, u32 flush_type)
+{
+	int r;
+
+	r = ualink_resync_peer(adev, remote_accel_id);
+	if (r)
+		return r;
+
+	return amdgpu_ualink_remote_shootdown(adev, remote_accel_id, addr,
+					      size_in_pages, flush_type);
+}
+
+int ualink_update_interrupt_wb(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	int r;
+
+	r = ualink_resync_peer(adev, remote_accel_id);
+	if (r)
+		return r;
+
+	guard(mutex)(&amp;adev-&gt;ualink.remote-&gt;peer[remote_accel_id].lock);
+
+	/* Update interrupt completion write back address */
+	r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
+					    RB_TYPE_REMOTE_INTERRUPT);
+	return r;
+}
+
+int ualink_update_shootdown_wb(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	int r;
+
+	r = ualink_resync_peer(adev, remote_accel_id);
+	if (r)
+		return r;
+
+	guard(mutex)(&amp;adev-&gt;ualink.remote-&gt;peer[remote_accel_id].lock);
+
+	/* Update shootdown completion write back address */
+	r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
+					    RB_TYPE_TLB_INV);
+	return r;
+}
+
 /*
  * The low bits of handle_lo carry the message-header field on the wire.
  * Strip those bits and splice in @acc_id to recover the
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 85c9a9634a4b..b381e378dae2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -333,6 +333,13 @@ struct amdgpu_ualink_mgr {
 	/* For remote interrupt and shootdown */
 	struct amdgpu_ualink_remote *remote;
 
+	/* true for selftest driver path, ignore FW error */
+	bool selftesting;
+	/* serialize the selftest debugfs entries */
+	struct mutex selftest_mutex;
+	u32 test_size_dwords;
+	u32 test_remote_accel_id;
+
 	/* handle irq from ualink client of remote GPUs */
 	struct amdgpu_irq_src irq;
 
@@ -393,6 +400,14 @@ struct amdgpu_ualink_mgr {
 int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev,
 				 unsigned int client_id, unsigned int src_id);
 
+int ualink_simple_rw(struct amdgpu_device *adev, u32 remote_accel_id, bool read, bool use_lsdma);
+int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
+void ualink_flush_tlb(struct amdgpu_device *amdgpu, u32 flush_type);
+int ualink_remote_shootdown(struct amdgpu_device *adev, u32 remote_accel_id, u64 addr,
+			    u32 size_in_pages, u32 flush_type);
+int ualink_update_interrupt_wb(struct amdgpu_device *adev, u32 remote_accel_id);
+int ualink_update_shootdown_wb(struct amdgpu_device *adev, u32 remote_accel_id);
+
 int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
 
</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------ErJZlfqeviy5YTrWEJJTcmEr--
