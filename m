Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD190606A32D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CotlbFdx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEDDA10FBF6;
	Wed, 11 Nov 2026 14:06:41 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BAB310FBF0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 14:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/COUNp4IVo5y4Hy0b7l+io9PRqZo0Q9MMlKDicjMrAjXBZk93Lnfxdn9jAaKm/GTzewNeKgcfK5um+aHb4v2EBDOLtR9Hh8rrcFoPVWUN94uAHIfM6W/TmsyLvsY6aZetItY8XxmlX0eC0ly6pCG6qkNWGa7y9PNfNB6sxpsOLnKUrrIdywLl4l1tXotYnpHpH115w9UQEGohyZuYKVgiOX20/Ve9+wdF7k4kR/j9utz+vGY1Uy7r30EttZU9xaIUN3EGmXSY+iRrsiP8cg86apVRpJsEvqB0sY8J+e/qE3CED0jNXPFJYjAimEBPEJNHMsMLE7EDGFQMxEQ468og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAjaKKjDnCQydC9EbmPJHuEDHOjD4XA7RFbLtfLf6HY=;
 b=qKHMuWH7llRRs386Fuvli+96/FDlX1K6zqVZBwRczW2fLVKvp3aHiSQRbaFjel6sCTaAUXhskNiHYtTeNTlIYFqbs6BsJNk9TffIkhCt9ArSA+hWdda+OuIPdUXorumHmzjCZt0dpkZvUZ5Zr73V0gevx5jzjCwdvjZrQY0dqvOh/KYdcV3/0XTbMov2ZfpCd0L8BuMoI2YbO9EuojNBqrcs9JLBpOPpdZLfFNdI36QLco/3S7Y3FUFsqPnokCFH9UvGXDP8GriDvuS/tseUmDLjc8P8fzrO+ohQU1XwRv89qEPF/W4ObNfG8xehN3aZbn9l5t1Aqz1hmFIOV2aMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAjaKKjDnCQydC9EbmPJHuEDHOjD4XA7RFbLtfLf6HY=;
 b=CotlbFdx6x0nFdv/VfqmYpflULJLN+qGQdP+4+qXBOIdvql2vbjsgut4GrWCBpbwMjVN3fUd5MGR25/ObUA+Xo54sagU9qHMqefnSan0mOVfrpDb+4oiAwsx0EiuE23a9OXSJGQxnzimFipuKl5u9xytRXzEoeW+2x7hsJtpFtg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 14:06:32 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 14:06:32 +0000
Message-ID: <d3587296-810a-41f1-b0a3-06a89296e792@amd.com>
Date: Wed, 11 Nov 2026 08:06:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd: Select the firmware signing scheme the PSP
 reports
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261109165009.763473-1-mario.limonciello@amd.com>
 <e825ccbd-8c50-4508-a0ab-9db97ac055fe@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e825ccbd-8c50-4508-a0ab-9db97ac055fe@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:610:e7::8) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: eca52827-6e96-4c83-cef9-08df3ffcfcfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|5023799004|11063799006|4143699003|56012099006|261021121427099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: aqUOy5FwW+7WWbBhoqbjT0V5BPWy9MVlUL29y9GIe1ru1xu2xs+yhr7zxB+tSdHMDw8N/ysQKhFRR8Tg2U77PoeESb0E9VlbzMROpmcS1Af2CWRC+QcDKbWbOpuFxTFcnIhMFu2CaedkL9APU1iH+eIiV+9viBJvjq1V7Zvo790tQlI6TlgmEQfhWL5jrf8+9nbFwGXE0mC64mppRP5dVG/pldov9W7CTrXluPGI9GTqJTgGaJwTcWN02TZTxd6DBNAftD/Ld5xbYdkRFlCOJ6EmTi8DETSgszYsTFqMIjmOyFGeCPDQhhLhrio3Y4fcnpVtFBnPSQV9j4d/Ts6nXTvoCSrp28vGlkbW+MM9bN0mhY5ULt5wO9oyNMp10XBIyjsDX8y0wriRcsauNRNMAPowbAg+tGkbE5OvePqBNs+ae8otd+XlsiqZMhx82pY98tQQ0SEWjCI2oEV1+WZ0S4Ic4sPb/jdd8vR7bSHcx+UHx69SQFofYXCKo2tzbKBvWnTLSFVbA6mm8h3Tajpi//1Ag1uJzlVpsjCS4+0WdTXDU6GSZ5ZHmqUjJUetLIV3SSOQ4KAYrB5Ag1HDcLDSypVZsuqQuLvecbgfh913FV1XKp7vO7dboLADnD3nxXz5G2j0i9IVlwjuVhbOxCj6x3y+/YwTB6ygcIIfZnyMeiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnZuc0hoMTZrbFdqdmFMSm1nRHJNTWxwVksrN2h0cGJ1dUdMNWVyM0tHcnRa?=
 =?utf-8?B?TDdTemJWaDZSanVPem80cVFnRy9WbGZjYlIrYnpKZHBTcktCakpjRGg5MEd2?=
 =?utf-8?B?WlBEZHdhOXd0UzNBRWpGTmxsOEwrV25abitVM25McFQ0VEFCMmVOMVYyUTFQ?=
 =?utf-8?B?L3JPNDlIdkk0ZnRwS3A3WVNOTGxKK1RIOEQ1elAwQ1hoaEZXcGU4L2hvdUZD?=
 =?utf-8?B?Wi9PMWRuTlNBcVhRaWRvbWFUeDBZOStrZkpmYjJ2eXRjTFBmTGxDYmJweG5k?=
 =?utf-8?B?MTMyUis1VEhHcC9ueXp6NmppWUxLTUdmUjhMSzVwVWlWcmJpeEYyUXlHVDNP?=
 =?utf-8?B?MDBwZ0hyb0lDQmZoTHRWR0tLQ2NNeTV0WS9pTFEwUGpBTzZDbGRXUmhsNVMv?=
 =?utf-8?B?TWRmYkxvMDNWemU1RjhXNmpWTzBUUkZKUlMza2pkY1BkWW93cHowMk5hWnVS?=
 =?utf-8?B?U1BnK2ZJVjMybWVqTjg3Vmx5YUlTcU81TGdRZFhpREVxNFlVTUtCOVUrZ1pU?=
 =?utf-8?B?S0dHVmZxSDk0U1A1ZWVQUzQ4UlBPcmExcXVFY3lOdy9mZ3h3eEp1OXVoOFI1?=
 =?utf-8?B?R0xBY0tkdVNRN0RrNGhUSDdYQTMzaHZVRURkdi9Vb2hVdVVDYUNPRE5RNk9H?=
 =?utf-8?B?blpiSE1CSHBQbWJtaXNiaEVPQnRweTJnOWcyM1B4TEFoOGsvMkZnblZnUWVR?=
 =?utf-8?B?ZHRRdXRZT0lQWVBTYjE0V2ZWTStydzJZYXFnaDUrK3JWSkU1Z1dmdGlKUmtL?=
 =?utf-8?B?M3RadDhFNHJzZTZ1cnBTZldBd3dsQUxpQjhTWkV2cGpQRVdwWDBwd1FDVFJT?=
 =?utf-8?B?WGFLZU42Mjg1Y0FQY2xuVFZLZCtXemF5RjJYb3BVSlZDQ3lUR1p4RHlkNWFP?=
 =?utf-8?B?R3VVOXpFYjQ0L3FneHNzbWlYdWh3YUUrWkkrcDVPL3RxeTlHaVZvV1JJV1lX?=
 =?utf-8?B?UlhUeFF1RE42T0REbXBnMDVCL292bmR2cXRRYUprd0VqR3NldTkrdzE1VWtF?=
 =?utf-8?B?SE1xbWsxYTZvWWswbmgveVk3d0p3MmFSeElITVBweExWOUx1a1pZSCtzdFJT?=
 =?utf-8?B?TDcxWHE4VklEVXVWS2lWcUpIcklSN3MxTGlsa1pxaDFobjNXMk4yYW9ja2J0?=
 =?utf-8?B?ZDJrdzl2d3k1UnZKVjhpUDR5dy9YUDdVOXU0Ni9xVUhxOXF5cnpkc3hTek9E?=
 =?utf-8?B?RFp6UlJ5YWh5OExiNEI4SGlxQmNYZmdzR1p4TENQaGVGakNMS2xyUnkrTlFa?=
 =?utf-8?B?cE1hamZEWFF6R3pxeHZkRGR6TkxYdEF5TzExd2g4MFhiOVRTdTdPaXJXT3Vy?=
 =?utf-8?B?NXk2Q1JYOUdMdTM0d2ErV09nbEpreUp2aTdEcUcyMWFhSGViUDdINDY5UG94?=
 =?utf-8?B?OTZWVURaSnJSRzB5dC9GOU1lZnArajJoOC9DRWprRkJsUXVwbE1kSEx5RWFD?=
 =?utf-8?B?cHNPODc2VndPV3FXTEdtT2FrQWo1TzZZczhLK3pxYVE5YXoxWWhLR1hyLzRv?=
 =?utf-8?B?dXY0L2c0ZUtoZUVMRFp5dzR0WTlBQjU2L0xDdytDOW5hdWdwaVZKT3RFNGhr?=
 =?utf-8?B?LzlaVFZ0cmNIWEk2cGJCWDgyaVptMnR3WGk2dzhqYUExcUZQWHhQVVd0TEtv?=
 =?utf-8?B?UzRrTlNpWEZUVVFLaFRCcDNBWnRzUG9GVjk1cEFydEpMOHNtcWt2OVN1b1JI?=
 =?utf-8?B?K1ptOWkyb3k5UE9seTdEcHZyWFlLK0Q3eW4zUmdpOVlaSDhYcmlWS3pTMWVE?=
 =?utf-8?B?TURtRVBuZEEzTjlyN21ZU0o1dm5VUVVDLzJxNEZ6bTllcXd2a21KQnJ2TmRw?=
 =?utf-8?B?dFpwcWVHbnZ4K2hKTlhGVkQ3VTBSUzNTVFB1azB1cXpuRFpxR1VjTS8xK3NQ?=
 =?utf-8?B?R0xpZWVYc0lHZTFMM01oc0RDSDRoaWw0b0pva1lKNmg3MmNTYjVZTWNGOWhE?=
 =?utf-8?B?R2Vva0VMOVp6Nk1CQnAwKzE0UVhXWUNjUVBqSlVtazVWNlEvL0crZlRNa0JI?=
 =?utf-8?B?Q3l2ejRPOThtK3Y5U1B6VG9IMitvZ1gwUkYvNlhxNXliOGZVd1BRWjJFY0pr?=
 =?utf-8?B?eW5NSGdhNWJTUXdzeXhUY3FZK1Izc1VkS3pJcmJZUi80b01Xc3Q0SG95N1N0?=
 =?utf-8?B?eVF6QXJDQ1BSUzljZkIrR1lWWW1ONWl2N0ltVjRWb1JMbnAwUld0S0NsVXJm?=
 =?utf-8?B?S2hiOWdObjNNdmhzTGxiTUxhTXQ4dW5BTmM5QXAweGV4ckQvbHI3ZUFYVGNh?=
 =?utf-8?B?U0FqQWZlamhxMGVSNGxybzVTc001VDFLakNEVjlMU25PdExUblBBVVhpRUJv?=
 =?utf-8?Q?n4ATwYJaYB9oOZO5eu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca52827-6e96-4c83-cef9-08df3ffcfcfa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 14:06:32.0406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRi52Fm6aeGU8WDLMv/s3ajcSkRkE2gv3gbaiaarUAi4ntdm0Er1r2q3wpUx6xXfVT4Kwn/jUrge+iGC6SZ1fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/26 00:35, Lazar, Lijo wrote:
> 
> 
> On 09-Nov-26 10:20 PM, Mario Limonciello wrote:
>> Some platforms ship BIOS with either a default or an alternative trust
>> authority, so firmware for every IP must be signed with the matching
>> scheme.
>> The PSP advertises which one is in use in bit 6 of C2PMSG_63, and in 
>> bit 28
>> whether this is a preproduction part, which needs firmware of its own.
>>
>> Add amdgpu_psp_init_fw_variant() which reads those bits through amdgpu's
>> own MMIO, and keep the result in adev->firmware.sign_type and
>> adev->firmware.preprod next to load_type. It is initialized once, 
>> after IP
>> discovery has populated the register bases and only when firmware is 
>> loaded
>> through the front door (the PSP). Only MP0 15.0.0 reports it. For all 
>> other
>> ASICs, SR-IOV VFs and an inaccessible register (all ones) the defaults 
>> are
>> kept: AMDGPU_FW_SIGN_DEFAULT and not preproduction. A preproduction part
>> that also reports the alternative scheme is not expected, so warn 
>> about it
>> and use the default firmware.
>>
>> Firmware for preproduction parts is named with a "_p" suffix before the
>> extension and firmware for the alternative scheme with an "_l" suffix 
>> (e.g.
>> "foo.bin" becomes "foo_p.bin" or "foo_l.bin"). Production parts on the
>> default scheme use the plain names. Do the substitution centrally in
>> amdgpu_ucode_request() so it covers every IP that loads firmware 
>> through it
>> (PSP, SMU, DMUB, GC, IMU, MES, SDMA, VCN, VPE, ...) without each loader
>> having to care. There is no fallback to the default file: it would be
>> rejected anyway. Declare the variants of the Medusa IPs with
>> MODULE_FIRMWARE() so that initramfs generators include them.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   * Cover PSP 15.0.9 too.
>>   * Cover MODULE_FIRMWARE declarations for more files.
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 32 ++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 25 +++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |  7 ++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  4 ++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 16 ++++++++
>>   drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  4 ++
>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  4 ++
>>   drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        | 37 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/psp_v15_0.h        |  1 +
>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  2 +
>>   drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c         |  2 +
>>   .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  2 +
>>   .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |  2 +
>>   15 files changed, 143 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_device.c
>> index c170bf3b61281..799a76e1cfe77 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2098,6 +2098,10 @@ static int amdgpu_device_ip_early_init(struct 
>> amdgpu_device *adev)
>>               amdgpu_ip_version((adev), GC_HWIP, 0) == IP_VERSION(9, 
>> 4, 4);
>>       }
>> +    /* Needs the register bases, and must be known before requesting 
>> firmware */
>> +    if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
>> +        amdgpu_psp_init_fw_variant(adev);
>> +
>>       total = true;
>>       for (i = 0; i < adev->num_ip_blocks; i++) {
>>           ip_block = &adev->ip_blocks[i];
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_psp.c
>> index c0ed3e24b6840..4f060666f12a1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -403,6 +403,38 @@ static uint64_t 
>> psp_get_runtime_db_header_pos(struct amdgpu_device *adev)
>>       return pos;
>>   }
>> +/*
>> + * Which firmware the platform needs, as reported by the PSP in 
>> C2PMSG_63: the
>> + * signing scheme and whether this is a preproduction part. The 
>> defaults are kept if
>> + * the ASIC doesn't report it or it can't be read.
>> + */
>> +void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev)
>> +{
>> +    bool alt, preprod;
>> +
>> +    if (amdgpu_sriov_vf(adev))
>> +        return;
>> +
>> +    switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
>> +    case IP_VERSION(15, 0, 0):
>> +    case IP_VERSION(15, 0, 9):
>> +        if (psp_v15_0_0_get_fw_variant(adev, &alt, &preprod))
>> +            return;
>> +        break;
>> +    default:
>> +        return;
>> +    }
>> +
>> +    if (alt && preprod) {
>> +        drm_warn(adev_to_drm(adev),
>> +             "Preproduction part with alternative signing, using 
>> default firmware\n");
>> +        return;
>> +    }
>> +
>> +    adev->firmware.sign_type = alt ? AMDGPU_FW_SIGN_ALT : 
>> AMDGPU_FW_SIGN_DEFAULT;
>> +    adev->firmware.preprod = preprod;
>> +}
>> +
>>   /*
>>    * Helper funciton to query psp runtime database entry
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_psp.h
>> index 975d123593588..9b04e51f589ff 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>> @@ -631,6 +631,7 @@ int psp_ta_invoke(struct psp_context *psp,
>>   int psp_xgmi_initialize(struct psp_context *psp, bool 
>> set_extended_data, bool load_ta);
>>   bool psp_is_xgmi_ta_supported(struct psp_context *psp);
>> +void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev);
>>   int psp_xgmi_terminate(struct psp_context *psp);
>>   int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
>>   int psp_xgmi_get_hive_id(struct psp_context *psp, uint64_t *hive_id);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_ucode.c
>> index d2ce526dd95cc..eeb056dcad2c4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> @@ -1527,6 +1527,27 @@ void amdgpu_ucode_ip_version_decode(struct 
>> amdgpu_device *adev, int block_type,
>>       snprintf(ucode_prefix, len, "%s_%d_%d_%d", ip_name, maj, min, rev);
>>   }
>> +/* Add the suffix of the firmware variant before the extension: 
>> foo.bin -> foo_l.bin */
>> +static int amdgpu_ucode_set_suffix(struct amdgpu_device *adev, char 
>> *fname, size_t size)
>> +{
>> +    const char *suffix = ".bin";
> 
> May keep it as empty string.

OK.

> 
>> +    size_t len = strlen(fname), base;
>> +
>> +    if (adev->firmware.preprod)
>> +        suffix = "_p.bin";
>> +    else if (adev->firmware.sign_type == AMDGPU_FW_SIGN_ALT)
>> +        suffix = "_l.bin";
> 
> This doesn't distinguish a prepod firmware signed with alternate 
> signature. Is there a case like that?
> 

There isn't a real case like.  But I did already have a warning for 
this.  See:

+
+	if (alt && preprod) {
+		drm_warn(adev_to_drm(adev),
+			 "Preproduction part with alternative signing, using default 
firmware\n");
+		return;
+	}

>> +
>> +    if (len < strlen(".bin") || strcmp(fname + len - strlen(".bin"), 
>> ".bin"))
>> +        return 0;
> 
> Consider using strends(). Also if 'no different suffix' (empty string), 
> copy can be skipped.

OK.

> 
> Thanks,
> Lijo
> 
>> +
>> +    base = len - strlen(".bin");
>> +    if (strscpy(fname + base, suffix, size - base) < 0)
>> +        return -EOVERFLOW;
>> +
>> +    return 0;
>> +}
>> +
>>   /*
>>    * amdgpu_ucode_request - Fetch and validate amdgpu microcode
>>    *
>> @@ -1555,6 +1576,10 @@ int amdgpu_ucode_request(struct amdgpu_device 
>> *adev, const struct firmware **fw,
>>           return -EOVERFLOW;
>>       }
>> +    r = amdgpu_ucode_set_suffix(adev, fname, sizeof(fname));
>> +    if (r)
>> +        return r;
>> +
>>       if (required == AMDGPU_UCODE_REQUIRED)
>>           r = request_firmware(fw, fname, adev->dev);
>>       else {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_ucode.h
>> index 7c809692807fc..a77758c07be23 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
>> @@ -571,6 +571,11 @@ enum amdgpu_firmware_load_type {
>>       AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO,
>>   };
>> +enum amdgpu_firmware_sign_type {
>> +    AMDGPU_FW_SIGN_DEFAULT = 0,
>> +    AMDGPU_FW_SIGN_ALT,
>> +};
>> +
>>   enum amdgpu_ucode_required {
>>       AMDGPU_UCODE_OPTIONAL,
>>       AMDGPU_UCODE_REQUIRED,
>> @@ -606,6 +611,8 @@ struct amdgpu_firmware_info {
>>   struct amdgpu_firmware {
>>       struct amdgpu_firmware_info ucode[AMDGPU_UCODE_ID_MAXIMUM];
>>       enum amdgpu_firmware_load_type load_type;
>> +    enum amdgpu_firmware_sign_type sign_type;
>> +    bool preprod;
>>       struct amdgpu_bo *fw_buf;
>>       unsigned int fw_size;
>>       unsigned int max_ucodes;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_vcn.c
>> index 6c12d8aa3c769..1df2725d31e0c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -66,6 +66,8 @@
>>   #define FIRMWARE_VCN5_0_1        "amdgpu/vcn_5_0_1.bin"
>>   #define FIRMWARE_VCN5_0_2        "amdgpu/vcn_5_0_2.bin"
>>   #define FIRMWARE_VCN5_3_0        "amdgpu/vcn_5_3_0.bin"
>> +#define FIRMWARE_VCN5_3_0_ALT        "amdgpu/vcn_5_3_0_l.bin"
>> +#define FIRMWARE_VCN5_3_0_PREPROD    "amdgpu/vcn_5_3_0_p.bin"
>>   MODULE_FIRMWARE(FIRMWARE_RAVEN);
>>   MODULE_FIRMWARE(FIRMWARE_PICASSO);
>> @@ -95,6 +97,8 @@ MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
>>   MODULE_FIRMWARE(FIRMWARE_VCN5_0_1);
>>   MODULE_FIRMWARE(FIRMWARE_VCN5_0_2);
>>   MODULE_FIRMWARE(FIRMWARE_VCN5_3_0);
>> +MODULE_FIRMWARE(FIRMWARE_VCN5_3_0_ALT);
>> +MODULE_FIRMWARE(FIRMWARE_VCN5_3_0_PREPROD);
>>   static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
>>   static void amdgpu_vcn_reg_dump_fini(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/ 
>> amd/amdgpu/gfx_v11_0.c
>> index 5d068a9d9c72c..3d82cfbd14f17 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -134,13 +134,29 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_6_me.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mec.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_rlc.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_me.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_me_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_me_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_me.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_me_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_me_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc_p.bin");
>>   static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
>>       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
>> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/ 
>> amd/amdgpu/imu_v11_0.c
>> index 09dc01a425d13..a409911939d38 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
>> @@ -44,7 +44,11 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_imu.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu_p.bin");
>>   static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>>   {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/ 
>> amd/amdgpu/mes_v11_0.c
>> index 60b27278a598b..e9778f950738a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> @@ -61,7 +61,11 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes1.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes_2.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes1.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_l.bin");
>> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_p.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1.bin");
>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/ 
>> amd/amdgpu/psp_v15_0.c
>> index abaa40b6def90..148d62e68225b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
>> @@ -32,11 +32,19 @@
>>   #include "mp/mp_15_0_0_sh_mask.h"
>>   MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
>> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc_l.bin");
>> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc_p.bin");
>>   MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta.bin");
>> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta_l.bin");
>> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta_p.bin");
>>   MODULE_FIRMWARE("amdgpu/psp_15_0_5_toc.bin");
>>   MODULE_FIRMWARE("amdgpu/psp_15_0_5_ta.bin");
>>   MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc.bin");
>> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc_l.bin");
>> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc_p.bin");
>>   MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta.bin");
>> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta_l.bin");
>> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta_p.bin");
>>   #define 
>> regMPASP_PCRU0_MPASP_C2PMSG_64                                         
>> 0x4280
>>   #define 
>> regMPASP_PCRU0_MPASP_C2PMSG_64_BASE_IDX                                2
>> @@ -108,6 +116,35 @@ static int psp_v15_0_0_ring_stop(struct 
>> psp_context *psp,
>>       return ret;
>>   }
>> +/*
>> + * C2PMSG_63 bit 6: 0 = default firmware signing, 1 = alternative
>> + * C2PMSG_63 bit 28: 0 = production part, 1 = preproduction part
>> + */
>> +#define PSP_V15_0_0_FW_SIGN_ALT        BIT(6)
>> +#define PSP_V15_0_0_FW_PREPROD        BIT(28)
>> +
>> +int psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev, bool *alt, 
>> bool *preprod)
>> +{
>> +    u32 val;
>> +
>> +    if (!adev->reg_offset[MP0_HWIP][0])
>> +        return -ENODEV;
>> +
>> +    val = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_63);
>> +    if (val == 0xffffffff) {
>> +        drm_warn(adev_to_drm(adev), "Unable to access 
>> regMPASP_SMN_C2PMSG_63\n");
>> +        return -EIO;
>> +    }
>> +
>> +    *alt = !!(val & PSP_V15_0_0_FW_SIGN_ALT);
>> +    *preprod = !!(val & PSP_V15_0_0_FW_PREPROD);
>> +    dev_info(adev->dev, "PSP firmware: %s signing, %s part 
>> (C2PMSG_63=0x%08x)\n",
>> +         *alt ? "alternative" : "default",
>> +         *preprod ? "preproduction" : "production", val);
>> +
>> +    return 0;
>> +}
>> +
>>   static int psp_v15_0_0_ring_create(struct psp_context *psp,
>>                    enum psp_ring_type ring_type)
>>   {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h b/drivers/gpu/drm/ 
>> amd/amdgpu/psp_v15_0.h
>> index ebd612103526f..2915ddcfff312 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
>> @@ -26,5 +26,6 @@
>>   #include "amdgpu_psp.h"
>>   void psp_v15_0_0_set_psp_funcs(struct psp_context *psp);
>> +int psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev, bool *alt, 
>> bool *preprod);
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/ 
>> amd/amdgpu/sdma_v6_0.c
>> index 4845588c4c247..2586d49f1e940 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> @@ -56,6 +56,8 @@ MODULE_FIRMWARE("amdgpu/sdma_6_1_1.bin");
>>   MODULE_FIRMWARE("amdgpu/sdma_6_1_2.bin");
>>   MODULE_FIRMWARE("amdgpu/sdma_6_1_3.bin");
>>   MODULE_FIRMWARE("amdgpu/sdma_6_1_4.bin");
>> +MODULE_FIRMWARE("amdgpu/sdma_6_1_4_l.bin");
>> +MODULE_FIRMWARE("amdgpu/sdma_6_1_4_p.bin");
>>   MODULE_FIRMWARE("amdgpu/sdma_6_4_0.bin");
>>   #define SDMA1_REG_OFFSET 0x600
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c b/drivers/gpu/drm/ 
>> amd/amdgpu/vpe_v2_0.c
>> index c92c5fc59aeb9..cefb8d739faf8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
>> @@ -31,6 +31,8 @@
>>   #include "vpe/vpe_2_0_0_sh_mask.h"
>>   MODULE_FIRMWARE("amdgpu/vpe_2_0_0.bin");
>> +MODULE_FIRMWARE("amdgpu/vpe_2_0_0_l.bin");
>> +MODULE_FIRMWARE("amdgpu/vpe_2_0_0_p.bin");
>>   MODULE_FIRMWARE("amdgpu/vpe_2_2_0.bin");
>>   #define VPE_THREAD1_UCODE_OFFSET    0x8000
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/ 
>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
>> index 0ea8f9a582ccc..b28d67b4e70aa 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
>> @@ -62,6 +62,8 @@ MODULE_FIRMWARE(FIRMWARE_DCN_351_DMUB);
>>   MODULE_FIRMWARE(FIRMWARE_DCN_36_DMUB);
>>   MODULE_FIRMWARE(FIRMWARE_DCN_401_DMUB);
>>   MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
>> +MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB_ALT);
>> +MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB_PREPROD);
>>   MODULE_FIRMWARE(FIRMWARE_DCN_42B_DMUB);
>>   MODULE_FIRMWARE(FIRMWARE_DCN_60_DMUB);
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h b/ 
>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
>> index df3e776c1ad14..219e9c0427441 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
>> @@ -61,6 +61,8 @@ int dm_init_microcode(struct amdgpu_device *adev);
>>   #define FIRMWARE_DCN_36_DMUB        "amdgpu/dcn_3_6_dmcub.bin"
>>   #define FIRMWARE_DCN_401_DMUB        "amdgpu/dcn_4_0_1_dmcub.bin"
>>   #define FIRMWARE_DCN_42_DMUB        "amdgpu/dcn_4_2_dmcub.bin"
>> +#define FIRMWARE_DCN_42_DMUB_ALT    "amdgpu/dcn_4_2_dmcub_l.bin"
>> +#define FIRMWARE_DCN_42_DMUB_PREPROD    "amdgpu/dcn_4_2_dmcub_p.bin"
>>   #define FIRMWARE_DCN_42B_DMUB        "amdgpu/dcn_4_2_1_dmcub.bin"
>>   #define FIRMWARE_DCN_60_DMUB        "amdgpu/dcn_6_0_0_dmcub.bin"
>>   #define FIRMWARE_RAVEN_DMCU        "amdgpu/raven_dmcu.bin"
> 

