Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC807CD1284
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 10:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DE0910FC32;
	Tue,  2 Apr 2024 10:35:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eDCMjKPb";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2108.outbound.protection.outlook.com [40.107.95.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B1510FC48
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 10:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VC8WY/TtYnjUBVPUmo0fc5d0B+38wQEU3k+gkDwpSxIRztO8UKzZEa80qT7mMjtDy8kEadN0w3+adJVXVfLH5WDP1E63prB0cFwunXKHEfmlO6HMWulfR+0hQvjt/wolfTn2cZP63aOWgB2oCtcFI9VIWUsqJwGwgWwQDqr08D32wDZ2iUqjJVORI2bhZeWrIbDiKeijuB3ZFo6SMOjIxsKhGYR3HfTLQQybHTclZH2dOBdCp9+GTnpenF0axgqLXHDqzba0xFW+ryBV+/l33mvmHtBlCmKA+OwgTTxegDb4DPID/Z+lRzOT5kp7svIoydcvX+AQjeegOpWpnRboQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unwXWERbDVHt79hrIVKl/SIVrFzFujxLo5WWaXEbQic=;
 b=AuayjfkcvzT9DlNmiPgT3+c1mO+MwpKlULfsY1sTEWCU2FRl/eOfJfxO/gT1Gxo64MPkN+DcNPrpDVEgRMimbfck+K/Z+5lAGVrAbqkO1rVEZBnEYeeAJaOoJaV3P2Ys5ZFWEUfnMTnJnxeyeUagKyoii7SrDdRQ4A0zV8Wp+CSTw3YpXS4UzP8Mo70uxdjn/FXSJmE5gzDvuHpML+KeYcsFCjZtEG0FkUVsY9B1FZH2uZ34tdgNKiJh0u6W/v/+d18FRf5yM2Kx8cYWAyJjHSHW98oPBkbbcItIcrawHJ7NgtwaiCQJj2kimoG9Bcv8ccKaeRK+qIVCoxF3hq3h/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unwXWERbDVHt79hrIVKl/SIVrFzFujxLo5WWaXEbQic=;
 b=eDCMjKPbu6Mxcik6PtJJXp5FOYMuWhCZ+udmNw1ai7w5qDO7gOFKbWCge8dUUXaQzlbiSX6SpK5eCQzNHU6YMuhZJcJP1uituX7z09SAWYio+qme1lrynESNXeHN4ZPruTFB7o8hgKx2kvmfyeK0BgQ94ncxHxYcvH0N5mYVcZk=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Tue, 2 Apr 2024 10:35:54 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 10:35:53 +0000
Message-ID: <d3ed17ad-afac-43e0-a12c-56ed3b41690b@amd.com>
Date: Tue, 2 Apr 2024 16:05:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/pm: Report uclk and sclk limit
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 donald.cheung@amd.com, sepehr.khatir@amd.com, daniel.oliveira@amd.com,
 charis.poag@amd.com, Shuzhou.Liu@amd.com
References: <20240402102244.3374108-1-asad.kamal@amd.com>
 <8aadcc95-3d19-4ae3-9352-04254a878971@amd.com>
Content-Language: en-US
In-Reply-To: <8aadcc95-3d19-4ae3-9352-04254a878971@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::23) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BL3PR12MB6476:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LoqCDwIx3mNy5Es/54+P0Y8Zm/2RaDpI1NUa4IvOYeab7Qg9uL4b4LQRwvn2/J9UIbrq23MFiUE3jb0Zf/cSVpdodZK7e7KUsL6zaqQgJvKF9LRZkA08oqF3IiL8DLxcK06r/RNxxyDxgGywf+0RYf8YPllLpTC3gRfdOK1vwC2kzy8JmaNZ2bnayzi6uGkKv6Kx6EcPMtJ0brM6e0AcYFUYDTG0c246P/MpHahJvIJ4nevyd9PED9r8DDyFR49eyWfauvl6Mo0GyFIMuwF2U+M31buUPDO+O1hnwlZY+Wgg/r2Xi9aC+vbpmqfbYB07VID4/pmrsoy6D9ABkJsf+h9YgluN7i6BihmcDima46FpDT4+U9Zqr1FAn0C4Zd6Ql4KEG5/vKEkS7LWDkXMgkuZXfAYRj1SeLKDLwHKuMNR3IVDURROJ/VYe1lCuwFNWPWsm5f/CfHFqzP86fbRuJNeBfFZdk0FXJ1C4CJbPEbI0PFlDVvXrrx6YQ+vdSMYk7a3zwUnFKqVUVzrDzZgODXS5RqOzfQ0GdfA2X340glq4uIPpfrDdQ/B9mA6UAhnIqyzSfSHvsKtYl1EYia+TraoJ4fqM9gVGq44xDwhCvt5r0QaBHKtKJaNzFoBEps9VmySeJboBV8cnbYvk3QnR0t0+/MtcQGZStghgrA+bX5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2ZnY1FWalI3c3RnbnFLeHpqRUdtTlE5U3RoaXg0VFhOUnZ1TDFWVk5xZTVQ?=
 =?utf-8?B?MVJIbmMwMVM0WTBpelE4elg1cmFBVVhlam8xR0huQVhrUXNIMS9hZGFwK09U?=
 =?utf-8?B?MlNhNHFUMHFZbjNvRFdjS3BnMUdncG5XWjY0VkhRLzI4Y3ZLZVBzZDdMb0N5?=
 =?utf-8?B?S2xUa20zUDNWQlNDMElIMmNrdTFndnFxU2xCSVVXN2o0NWV6bGJ4UW5RckJB?=
 =?utf-8?B?R21iZEM4SnYxOWxIeE9zOUpNUzg5SHVFZlV4K1FSWXN2OTBZcmozeVk2RTRa?=
 =?utf-8?B?b1JyWjZYbEhkejlBMlNDZGp5N2FhS1dLMzhWY01jekdmR0tJZXNHR1dUK0lx?=
 =?utf-8?B?d2VnUUNtOHpBV2w1Z0dnUzNCclRQaXN0d0ZQbGRzQ0YzTS9tS1hmOXFKMXh3?=
 =?utf-8?B?NGVtM2ljb3YwWE5MQWdWZVdYN2FQeEhZR1dRdXNaK0VlU3o5a084VmtyVzV0?=
 =?utf-8?B?QmxXbFEwZkNZcVMvWUtCYjAvSTI4Q05lMVo0aFVCYXV3eTF1TGZxeVZaTmoz?=
 =?utf-8?B?VHZlRThhTEVhbHlzSGhpWUdQOUQwRXV0TWZTdUhPOTNzVFRMM3RLVVdYS2ts?=
 =?utf-8?B?TVhWcExma3ZCZE1OYTZwSitDNFpRVUI0OUZDUkxIZG9VeUVEUjRCNFlHRm5j?=
 =?utf-8?B?REQ4cCttbGhtUDlDODRxb1E4VE91Mk1GUVRuei9SWGpFRDFqaFNBdXZMU0pu?=
 =?utf-8?B?SDJOU0tYMDg1Mk1DV2s3aU5lcXdKUGl1REpLWUdBZFFWTUxaRDFoRmlzTEgv?=
 =?utf-8?B?amFOS0xmUUVaMkhheGhhd2xqOEFqN01iTUFieXlvejQ2UHVOcVJLVGk3TlBV?=
 =?utf-8?B?U0dtdWR3QW5KL0xZL0FCV2lvTm14UVdDeGV1eUlpRlcrUzY4bnZ6VFNUODla?=
 =?utf-8?B?OGJHK1NIckVqY29oSFVvR2t2clZDOXpBTG1icGZKVzlyT3BpZTF0OUtMWkg3?=
 =?utf-8?B?djVCU3F4TmxGK0VPT055a2k3dXhPYk9lUVlYZ3RGSm9sUHYrVkR3YkRjMG5v?=
 =?utf-8?B?V1FFRWFVM0JNSGdMV3BtZi9yRC9ZWTcvL3VYTmtDZTE0MXBYeXpnQ2xCdXlp?=
 =?utf-8?B?UFhPK1NFRVJPU3pGSVYyNEtzUlNYc1BLaHZrekoxcVZXOWRCZFRtM2oxbkhx?=
 =?utf-8?B?dWFjdVB1RXN6bVNwZ29pQ2pTUm9uV2lrakhJclpKbXhTNVJBSFMwWU92cEF2?=
 =?utf-8?B?aThBT2tLN1NxaVZ4T0lVQW5uMEFEY2U1VjlPeHdrSFQ2Y1RybzAzaUdKWHJL?=
 =?utf-8?B?cDNlY0N0ZlRrTWNZWWs1SkhSb3RSbU84UHBJdzhKSk5NN01pdklxK0FqcTNv?=
 =?utf-8?B?cWY1OXQvSjBjS2h1YW9oMDhWYVZMakN6eUlWUXQvcVNIZmd6QnFFNitxR3lH?=
 =?utf-8?B?L0JLYjYvK2N3RGhESzdQb01iUDdHYVRvZGhHR3dOV2JXbGI3QVc1QUJDOXhF?=
 =?utf-8?B?Smh1OEI1TmFyVE1MdFNPTkZHY01UYTZHWjlwQ1pzRUJrSzRVRUg4MXZuQ3pH?=
 =?utf-8?B?Y3J3TUp4dUpJbWttMHkvQ1AzNldyeTlIRXJHdzJDeUlCR1JmaDFkandIK3g4?=
 =?utf-8?B?TSt0b0hDN2YycUlVaHlTd3BGYzMyZHEyWm52WHB2WXFIY0M3TVJCbUtqakEv?=
 =?utf-8?B?WE9Ed1EzOWdPT3hWUlB0YmExRXNvbHF4VFFhV3lDSUNSTlAwSzg0bTRiYVN3?=
 =?utf-8?B?L1pkVmxmbmQyMGJOeEhMd21DWVpWZm1OZ3ZvY2lvTWVOZHdxU202L2lQOWZM?=
 =?utf-8?B?UWlmZE54aDZrN0NVVWVFQkpmSzJGdlliUHdpdkNtQkhOS1hmaThsMUZTNk5N?=
 =?utf-8?B?RlJrcVFlTExjbWJod2RZNGcybGo0VGQxNlBYb3labmM1OTVrMlNCc28vVXd0?=
 =?utf-8?B?emEyL3J4TkpaQzdIVDdLc1JIeXZFblpZNjFZd2cyUkJDWDlSdTZsUFlHOWxs?=
 =?utf-8?B?RCtyeXZBdXZUWHN2dUJsbFc0YVlhYlFJVFp5bUpCSUlMVFBMMTRiUnVTTHdO?=
 =?utf-8?B?L2RtSmd0TVBrYjBnSE84a1R6SFFvV0FQbmhPVGRuc1gyODFDMW1lVThxU0w2?=
 =?utf-8?B?NUs0bkQ1TEsxQ2JOazUvMW1lUmpyY2twdVErNERHZCt5ZjhzaTgyNk5KMlNu?=
 =?utf-8?Q?4DselvF2IL+/7oU7Agfvxrlb5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0d8ce6-3062-48d7-f884-08dc5300ac41
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:35:53.8903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Shxu+5IIqaclLibd9F/P5y6Wd+lrx2GKBPP0wxT6TvKigNtl198AEKG0T+VlLDUh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476
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



On 4/2/2024 4:00 PM, Lazar, Lijo wrote:
> 
> 
> On 4/2/2024 3:52 PM, Asad Kamal wrote:
>> Report max set uclk and sclk for smu_v_13_0_6
>>
> 
> You may rephrase as
> 
> "Use OD (pp_od_clk_voltage) interface to report current limits, default
> or those set by user, for SCLK and UCLK."
> 

With the update above -

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Thanks,
> Lijo
> 
>> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
>> ---
>>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> index 575292314f57..f81096bfbf2c 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> @@ -1010,8 +1010,11 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>>  
>>  	switch (type) {
>>  	case SMU_OD_SCLK:
>> -		size += sysfs_emit_at(buf, size, "%s:\n", "GFXCLK");
>> -		fallthrough;
>> +		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
>> +		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
>> +				      pstate_table->gfxclk_pstate.curr.min,
>> +				      pstate_table->gfxclk_pstate.curr.max);
>> +		break;
>>  	case SMU_SCLK:
>>  		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_GFXCLK,
>>  								&now);
>> @@ -1052,8 +1055,11 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>>  		break;
>>  
>>  	case SMU_OD_MCLK:
>> -		size += sysfs_emit_at(buf, size, "%s:\n", "MCLK");
>> -		fallthrough;
>> +		size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
>> +		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
>> +				      pstate_table->uclk_pstate.curr.min,
>> +				      pstate_table->uclk_pstate.curr.max);
>> +		break;
>>  	case SMU_MCLK:
>>  		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_UCLK,
>>  								&now);
