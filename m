Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F91C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 12:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E27BE89067;
	Wed, 30 Apr 2025 12:43:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0x8ePWS/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64DF389067
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 12:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2bO3p5w6drQbguwCELbCxvUAnB2S+oQjmnVxHwQDZPPP/C4qgMU1ukcFY8e0M8gybPVF7IhX7qC9D2n5XiA1QQLjtXsmf1+0HrSyLR84oxAmw5Ic/Whqcp6XfaYc1KaP9ud5+cBdFqFYa36uTQzEmKGUNLdHTURnBM7SHWoLy6vhAAi9SjqzLIc6MIRVQ7irzLB1Q1EFtFagtGr1CVGKyENHcdmSu7Nkejqm4st478141QYLEhTF+xNrQEG65SgwaD+JKrQRZvD21j+PBafjL91ai8fh59iGLLGfFFMQlfR38aQTlshZkIl0duJov7Xn85dRbc2tw4MT7hJr8VgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5sRt890NTw2F0fknnVNG1+UZffCnoV3mWLEAEQhKbo=;
 b=v9Re8RrmDUsjo6/vOLdqvY3+1HEU8P1+Ir/VWay9hWscXYf7PQe9C5xD2hNPbLuXCEk/p1zvQu5ZcYzjQC5JT9dmhPI7+0nQeSFHqGMenjTqIozH8cYRSswQnPeGb9Q9kehZfF7NGvXT/jjDMRnWODlEtAJ0H9nHhV3lUO6WFvKTi1wUaj+vwzRtSGAMHnlT3t8hQSNeN3UEEt418Q5FrIZh2vI+vKUmPKMd9Jkc7Sjx347B8iVRgSCIpZ1/Yf3Hy7uxWSMtL+eDlG33GlX6EhuvvdMrTkSyQi+ZYWo5Uj5DJ8OmUjlWPJR4VUh4wvwhQjyACKfH+1JQqxOOmlUu6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5sRt890NTw2F0fknnVNG1+UZffCnoV3mWLEAEQhKbo=;
 b=0x8ePWS/Kev67F0u+XyudQm3HHnOI8NHIOdHeJC8ktXA56D/zYOe1d1nMiK8RFzi1B+OGNwzBO+KIQTT537EbtLP7pe4JDudlVyfXqqNkYQY6IPAJZK2NZ18F87/fapue8IL8pZHtAL+2te4mxaTrE77M5UijMPjs9S2WUnwx38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 12:43:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 12:43:30 +0000
Message-ID: <2aabc3aa-75c6-4ec4-ba7d-2f765b020af8@amd.com>
Date: Wed, 30 Apr 2025 14:43:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/amdgpu: update XGMI physical node id and GMC
 configs on resume
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Alexander.Deucher@amd.com,
 Jiang Liu <gerry@linux.alibaba.com>
References: <20250430101638.649274-1-guoqing.zhang@amd.com>
 <20250430101638.649274-2-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250430101638.649274-2-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: d14b962e-22bf-44ca-d440-08dd87e49c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MCtDM040TVJYRVdPc1BhOUtOT3U4VmlCSWtXcFNmbXFwQ2ZNRVo1RHJZdFpT?=
 =?utf-8?B?L2pINXdOd2J5WUE2Yk1JeHVqSzhKZCtxdEphck9aeGNBNG5sVGJyMGV6YmxL?=
 =?utf-8?B?QzhzK3YwcGxwOHBHSW1UYkJLMVV4OXg0QmN3N29uMlMxcXViUGxwR3NwdWZ2?=
 =?utf-8?B?MlQvZVJxajRHdzdwT0k3c0JTWnJaRHNtZFZ6UDltSHBCRWVaZXV6RFVvbEFZ?=
 =?utf-8?B?ODR1Q1JhdzZLZFZGcGgza3dpaVdFYXl2Sm9IQ1ZTeFI0NDFpUEVnbHUxdjhQ?=
 =?utf-8?B?NXpYc1BkZU8rb0NFZTVzRlZ5THVSRnVPUXA1ZkJ3Y0tJejV2dlJWeEZCcktm?=
 =?utf-8?B?dVZrT1dTM2VCSlZaNmhYbkt3dzQ3Rk84M0M5V2Y0V0U3akxibDQvem1lcWpl?=
 =?utf-8?B?elpvR3pWS1BsNGZPUEpWUU93QmZVUFVOcjBKY3ZOcFVzR0JSN2tGT3JTTUpY?=
 =?utf-8?B?SmtFUDIyckVIaUFGdjljcGxCSnRiZSs0Mm9ZK0VkWHlFelhaK1VYeHdSR0px?=
 =?utf-8?B?eEExeDFZMmt0Rk1yUEZqQ3lIU3AxZjFGNTdtN01XVGpnNVJiOTI2ZXNPQXNQ?=
 =?utf-8?B?ZGhHWTRqNklVRDVWS0ZKNmlxeDIyUnpjejRyTzdsbGJLbDhpdWhjZG91a2hi?=
 =?utf-8?B?TlhzeCtoK0RtNEEvSWtkVFFEekRRUUpoRjBxZWoyNkVEUE9Na3JLNjB6Ym5D?=
 =?utf-8?B?OWdmTFZaMGJzU0xQOER4UWVHMDJNWE5qMG9mWWk0M0NNSUNIWHBDMmpZckht?=
 =?utf-8?B?TUROUDhrcnE1VUlmbGRaQTFmVTJ0VTBEb1kya2tEVHZLckI5SXZ3TFl0QUxG?=
 =?utf-8?B?anozeGN3V2dGYmNaZ3lFQlVQWjJZQUZsWE5mZGJEbXorbWpsTGlSZmkyS01B?=
 =?utf-8?B?TVdKbS9YS2xlNWYwNnQ2WkJwcjZrVlBtVmgxeGlsM2dSRUFMakt5ZzI2S21y?=
 =?utf-8?B?N1lkS0J2Y21RaGZXdFNwcmFVcFhqdzNveElPeFB2clBhWXM2Q1pGL2lIc05s?=
 =?utf-8?B?bkx3TjlNVGpYNW1YTm5laVNwOXJ3MDd6eGJrOEFkUmZnZHlCcERQOU1sdjJN?=
 =?utf-8?B?NUNaZGdFL0dTaFFtcFpNNVdDOW1hL3FYd3RnSEZxUWlpRkozWGdLTUNtdlBl?=
 =?utf-8?B?b2x5UGtwV2pvamZmWExWZjBMTHhacSs0allWaTFHOFQ2ZVRhT2ltOWE5N1Fa?=
 =?utf-8?B?SWFJU0orNERaWVhKdGVmTmUrYjlXNm9mampBTFRZOHlka2tCb3FtMXJXVVQx?=
 =?utf-8?B?ZDNOVEc4YW40NU1ta29NbmRZczdRc2hTbHlPejQrSjJML21GTmZDNXV4Yklw?=
 =?utf-8?B?c3N5QXpES0JpL2krUnFQL3BWSlV2YUdjbkZ6MU96NEZuM0hoLzgzdWFSU1lF?=
 =?utf-8?B?SktXSElBRmlsNE1IWEk3NmdIelk2RWp4RVdVYzBrdTdhTklpcmZTT3Q0b2JK?=
 =?utf-8?B?T1QyUzN1amxxYzUxWER6Ky9LUEpsS3Z2RmZNc2xPNm1GRW5hajQwS0tLYVN1?=
 =?utf-8?B?YkVkcldDWFhxUWlzeHZOU3podjR3TkhMeHE2NEJkMU5iSW9ib0M0aityc3RJ?=
 =?utf-8?B?ZzNLSnluNUdZNjJRandybjBhNFdNR3NyUU1UWGMrSGtObHhZSC9ZN0YvUUxt?=
 =?utf-8?B?TU9jaDJ2eWMyc01ORzBmOG9LSGdOMTRwdVhPK2RRN2dBKzJYTmRZTTFPY0Fa?=
 =?utf-8?B?TVB1WGdGdlJLWGF4cE03U2pGTk5JcFg1Y1ZoWk5kdVBKOE54STAzMU5nYWlY?=
 =?utf-8?B?OE1vSVR3em0vMVFCRDJyekozdzgybXlFWDJtMGlBZkJiWXRQT0hqK2ZpYlR1?=
 =?utf-8?B?NGl0VDh2TVgzYjhBTzlKWUtxZi9yYTBkWDZ2QWk0ZUF5Tm9CL2srK0FrVWZM?=
 =?utf-8?B?eXM1clpDZjd6N1JSS0N0Zld1QXBsdmI4S0tWUzlJMXU0M2FNeUVWaXk3aVJN?=
 =?utf-8?Q?04KzJhDyoho=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1NUendhQ0h4WjljUHIycUZoNlFZVmhXZVpobVREblF5OHE4ZU9NMHBLaHdM?=
 =?utf-8?B?d1p5NWdzdmpJWFB5Uk9xcE1vcXVRbGozeUszc1NJVzBLSThJOEtBMWtWYmVu?=
 =?utf-8?B?eFZDUWQzWkxlVHgrSHVBNEkwaTVXcDZnaW9pMVZzZ0ExRE43S0RaNlU1bUxY?=
 =?utf-8?B?dGp5VTgxdmhORDZlTURIOHZPd0xIVlJMUTNiL1k4dVRJYW51R0lieHU5cENq?=
 =?utf-8?B?VmM0WVozTHRlK1RQOXZyU2I4RWh0enNQZ1AwTGd2eVNHTU1XV1F4L2ZmTEZ1?=
 =?utf-8?B?Y2YyYTMzcmNqSWFJdkFsUDhzVXpjT1V5VExIemQ2dEh4TU5nM3Z2Z3lqUUV4?=
 =?utf-8?B?QVRQL0ZFVW8vQlVCeWs1WTAyY1dwYzZMbS9GOHhYWlRUUFFkNVhjN3ExV2Zp?=
 =?utf-8?B?SDZ0em9JZVRheHF4R3d6alV4bW02UDVuZWNEaGpVNGlBUEs5a3EwQVU1UFhI?=
 =?utf-8?B?clFnZEVmWDM3eHRsQTFxaVpnYXlkMUxaZERhb2xGMWlpbkxKNXRnRVVzS1Qx?=
 =?utf-8?B?aUtnOUtCODRrelVCTVZtaXljWS9sSytZNlYxTFU5MkVqMmt0bEs4WldKRFFh?=
 =?utf-8?B?VlFZOU9TSGhJR256SGxYZWNEaG41KytNcGZXYld1aGw1UEQxdlVHdlROcWxv?=
 =?utf-8?B?R3lpWWFTZVNzZWRLWjQzUVdEN1c5bUVua3k0bVo5S0JOM0R0VnhLNTRDcXBB?=
 =?utf-8?B?dDRzNzRVNW13SlQyVnRNN25BK0RVaUkyRkJyUWtCQURBazJTTGNtUllxdUxU?=
 =?utf-8?B?WVJ3Q0ZYMStmaERUaEdocTNwa2JIc3dTZG1JYXNOc0JQNkIremR3aHZ1SVFp?=
 =?utf-8?B?b3RLZ1FyTG43MFVmYmNKZTVBQVFBbGlqWHo1eHV0aXhBejAzd2VaSWIzVGtH?=
 =?utf-8?B?VTB0S2FpY1pCRVlTZEFxeEM3ZXJ5ekI0Qjg1ZFF1MWF3QU9UQWVFb25NWmd6?=
 =?utf-8?B?RWJIaVNHbnFCMmF5RWNwdTJreVkyVzNTcHNHSUd2VnlHeWp4MkZYOGpDdElO?=
 =?utf-8?B?ME4yV251WkZFb1pVbDlQd090ekp1RHRabWFTam9jRStKaWk5Z1BjcEdyUWl5?=
 =?utf-8?B?Wnk0OEoyZXlueEJnMkxuSTFBMHpXMG9YY2dVaTlpeDdSN0tteTdYWmhTU3lJ?=
 =?utf-8?B?WEZ5aTVqQVRGdEFLZTRZNUZ3eWpIbEpxWFQ0cDVxdkVDUjZTdlVwM2g1NXk4?=
 =?utf-8?B?eGdCcVRISmIrSFIzcHRpbUJZaWlXUVp4MFlvbTI0UUUyRE5QZnRuTEZMNFZy?=
 =?utf-8?B?ZkI2RnltanROcGVtdml0dlM4Nlk4ODZtREJmaGwzRENDd1RSQzFseW1xQTh4?=
 =?utf-8?B?eUFJZDJEZHJXSWw2SXF4MzNWa2p3UFkxMjNSK2RRelkzWVZ6bUtDOGRiek5I?=
 =?utf-8?B?THNUS3ExbldUU2FIdmR5OUdpTGFUZUxMUXdnRGxmS2RMeXlOL0h1Smk2OE1X?=
 =?utf-8?B?UDhucEhDR0EwMzVSUmVlV05jY01JYzRGWkRaM3NybkVUb3Ftdzd0QVdTUWRM?=
 =?utf-8?B?RFJYNHhjQ09YdHRCSk9ROFlrZ2tXUjNxTzYwZVJ2QjZuWkhaMXFlTVZGcUlq?=
 =?utf-8?B?VnZUTGVvSTljQld1c09yVzhCR0FjdTIyc2ZrU0FtUEw0SWhCWFcwTWRqeHAw?=
 =?utf-8?B?R0VQOTNuczFzTFBIMys5em1ZUDh5SU9saktMaUMwMXhlYk1KVmxWM0JSVmMz?=
 =?utf-8?B?K0FGMDNrbUFodXZtRGhicm8vSkxUVzNMRDNHd2lkbmdpeDlKQUJoWjFpS2hQ?=
 =?utf-8?B?Vk5QbUI4dkRxbWdwM3dKa3VUNUQwd2pVZW5ibTNVOE5VaHUzWEdvVXFOS3Iy?=
 =?utf-8?B?dmpMYUIwTGMrTzRyNXhaQ0hCRmVYR3YydVFqQnRaa0Z6Z005Y1YzTVI2QUxZ?=
 =?utf-8?B?QjViaXhBZ3k0YmROY04yWERiWkRxYWw5dzVwYzBKbVZLMUo0UkpreStEbkRS?=
 =?utf-8?B?RzJvY0VnMmx6MVJRYlhmYXFRZm9DSFJmZEMxYkQ3VUlQOWhzOGVJdFc0Qnhk?=
 =?utf-8?B?Q01wTnF3TlhTUk15MXhOK2lsS3ZETlVmNzJjRGhESHlUNWxIUDk0Y1JZT3lV?=
 =?utf-8?B?dERXR2dDU25mZzk0Y1RUdzl2dEs2a2lZbi9zY3hoS2dYZGFrelRlZ3Q1UjU2?=
 =?utf-8?Q?SPiHWK4wLP2TZ9dI63DhiGe1V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14b962e-22bf-44ca-d440-08dd87e49c47
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 12:43:30.2001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XLEj1KxEg2zDgfgBARIG7nQSlAZjRdKQc+y6ovDZ2YbYPq0R5fTSTRGd6XVgHpV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393
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

On 4/30/25 12:16, Samuel Zhang wrote:
> For virtual machine with vGPUs in SRIOV single device mode and XGMI
> is enabled, XGMI physical node ids may change when waking up from
> hiberation with different vGPU devices. So update XGMI physical node
> ids on resume.
> 
> Update GPU memory controller configuration on resume if XGMI physical
> node ids are changed.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 +--
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  5 +++++
>  3 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d477a901af84..af2c784a6ccd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5040,6 +5040,28 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	return 0;
>  }
>  
> +static int amdgpu_device_update_xgmi_nodes(struct amdgpu_device *adev)
> +{
> +	int r;
> +	unsigned int prev_physical_node_id;
> +
> +	/* Get xgmi info again for sriov to detect device changes */
> +	if (amdgpu_sriov_vf(adev) &&
> +	    !(adev->flags & AMD_IS_APU) &&
> +	    adev->gmc.xgmi.supported &&
> +	    !adev->gmc.xgmi.connected_to_cpu) {
> +		prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
> +		r = adev->gfxhub.funcs->get_xgmi_info(adev);
> +		if (r)
> +			return r;
> +
> +		dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
> +			prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
> +	}
> +	return 0;
> +}
> +
> +
>  /**
>   * amdgpu_device_resume - initiate device resume
>   *
> @@ -5059,6 +5081,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>  		r = amdgpu_virt_request_full_gpu(adev, true);
>  		if (r)
>  			return r;
> +		r = amdgpu_device_update_xgmi_nodes(adev);
> +		if (r)
> +			return r;
>  	}
>  
>  	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d1fa5e8e3937..a2abddf3c110 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1298,8 +1298,7 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
>  	if (!mem_ranges || !exp_ranges)
>  		return -EINVAL;
>  
> -	refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
> -		  (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
> +	refresh = true;
>  	ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
>  					    &range_cnt, refresh);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 59385da80185..3c950c75dea1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2533,6 +2533,11 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int r;
>  
> +	r = gmc_v9_0_mc_init(adev);
> +	if (r)
> +		return r;
> +	gmc_v9_0_init_sw_mem_ranges(adev, adev->gmc.mem_partitions);
> +

That is most likely a no-go. We should only adjust the base of the memory partitions and not re-initialize the number of partitions.

Regards,
Christian.

>  	/* If a reset is done for NPS mode switch, read the memory range
>  	 * information again.
>  	 */

