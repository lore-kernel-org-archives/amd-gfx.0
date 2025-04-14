Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55299C369B2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 09:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2537B10E55E;
	Mon, 14 Apr 2025 09:58:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FmTNmc4O";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2762910E53C
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 09:58:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/5ANSifNtnWAFStrPurTmYuwNsLKAiSfICWy79y0fYDhxmqY94O+UVNgSQHEeMw14mimikQnWBUbWxm76WzOS5maUwdscOxp3YWIx/eN+ZExBnYlK1PR4po04QD4jNoKMWwn47FcsyPgDUqh0qobeNWeeecI/WDKaLjQsrujny5KaFZvYxHvlOHWS8Dg3GJBHfdJPZG77/miGxXx1MlrJwNHCZw+bn3fNQMhjhnEfHYRP0a/5r+CzxlFZz4CJJw18en1N3a7PNk0onBe/LGvSYulgzbmZBu4PW70VxPTPGd6W/vv6GVgvyDueKvgEAth950n5HWM4dve/q/ie2gAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGus95eOGKVRX1ucyurMnXkOdmj/Q/LGioGizIx/Dd0=;
 b=Rsh8kDSK5wJlpP72o4+ZgB75HY4yCva70q+1WTBu5AH9z37RoAxriUMFSxTQan/yyB8zPjKIkidElbmQQI0VY9Xa6Vyhka6LVpiNi0269so3VRTzls3TcAoYDUoTve7C0wyIEDLtr1gq1qLmyVfcRQsv5rWTMhGJ45Lu26oT0PUKCq20Jmjrnm8Q1eEUacaji2tKa5nIryMA2NW8ILGusRwVF9UnWhK1n94gH3VRXhpxORKVGc/VzVz2hhy9pcdkJcCXJ1GZ/1Oo50FtrCiZOTo5HWp0/WzR/aEZQcGCAa2c6O6+id7ypUwTpuF52suR6WXWloh7suGp9uQiYbergA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGus95eOGKVRX1ucyurMnXkOdmj/Q/LGioGizIx/Dd0=;
 b=FmTNmc4OQkmxZBPhRR5sxHFK3/VWknArHZGy4RhyaVW8x49gEbZpYXQs4LFO9LpQCGO64m0TyCc84xa7JerTnCetYL9AP/DTjDpQWa2M3KOTFVSFIuDDgX0AKYEwkv0XnWnNM0qV3+G6GSCG9iUe2hr9vhGigdKZz7RyNrsfCsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 09:58:37 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 09:58:37 +0000
Message-ID: <36ea9a52-9a39-484a-8100-bde07d320db2@amd.com>
Date: Mon, 14 Apr 2025 15:28:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/sdma6: properly reference trap interrupts for
 userqs
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250413160608.2198429-1-alexander.deucher@amd.com>
 <20250413160608.2198429-3-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250413160608.2198429-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017B.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::46) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a33d613-587f-401c-0c8c-08dd7b3aed20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bE94ZUpMcVZWOXNNQ2t0SGpUbXgxdlpOR2Nybm1KdVVmR3NaTElnV3F0L3l5?=
 =?utf-8?B?RUZ1ZVk1elRseEF2VnBGK2RsRVVOTjIzdU44akxiVUlXL013UElqcEs5bWRi?=
 =?utf-8?B?TjhZaWUyZ1EzU1FWNGpMRTJwVjhPZDJicEx1YXMzLzhUMFQ5dTVCL1FPL0xy?=
 =?utf-8?B?TFd0MDlPTjlobTJ4VUxyOG5NTGxwVmZ5dnM5aERuMUZJektXalZvbjlhOEM3?=
 =?utf-8?B?MFd3enN6MHVRZWtrQkxOT3NOREJ0SWlINDFweVhVRXVvUzc4dHJaVFJ1TEl3?=
 =?utf-8?B?WnNRYUNwcmMzWWFBZERuTnBubE85WVIzQllNYzNwQkJ4dmhtVHZiRmhmWmRC?=
 =?utf-8?B?cXZvcXNxQkJaWHpENW1iNmVTenFGVDI1WnkxMXdqS1haZjhhUGNzM1o2ZjFH?=
 =?utf-8?B?VWFMOWlBRnV3ZkZTY1RWb0plaW1GTjQ5eDZzeVR6QnF6bFc4Nng1c1ZFSmFk?=
 =?utf-8?B?Ky9RV2RzenlXa3RHUFJ3Mi9kZjF5L3BYUE1MV2h1RXpYUWwzc05HeDJvY0dK?=
 =?utf-8?B?Q2o0RXdMRklLbWRGMStSVklIb3ZYdkNCVkZXUUJRT0EwMittSVZWcWkxcmlw?=
 =?utf-8?B?SlJKTlRiUFdScFNHWEFGdlkxSWxxOHJwalVXazRDT2syYUJzTVFYMjJ1VjZz?=
 =?utf-8?B?TTBlV3pIZGo3RlozOHVhV2V2YldZaDBoZnN5b0hrTTg0d21PaDZoVmw2eUdr?=
 =?utf-8?B?ajhqekQ5eUthVUdNNmFjT1FNekdtNTRPTEUxd2QyT1RVczNUbmw2cVBhSW5H?=
 =?utf-8?B?WDljVE5ua2Z0aGcxY3I1UU9ZNFoydTBmOXdsMktPa1ZudVdiV3lIV1FNRHJP?=
 =?utf-8?B?bWQyUjRqTDRRdk9OVFlHcDN5cUJ5OTFoTjVnaUVIREk1M1YwK25NcmdmaU5w?=
 =?utf-8?B?enliTGcwb2RpZmRFSEtxeGd1L0s0ekpqVUlOOEJXUHkxd0Z1cjV2TDhmNGFm?=
 =?utf-8?B?enJOd01mMEZ6a0tuWm9iTjMzYTJYWVBwZ0hjNjdSSUZVbkllRG1Bc3VXTUJy?=
 =?utf-8?B?UVl3SGZWSTlERDJ6ZHB6ZEhBYWhHRllxVHpyaFFJOEFFNEczTHhITHVPMnF4?=
 =?utf-8?B?L3lnNWhHbUUwVEZSVTMrOHJuaC9KNlgzV0VZckVnL3RsLytvRUpPcHQwQlhl?=
 =?utf-8?B?NTdpQ1JuQldOak1EbVVKTmtaTVk3VkV0Y25rbUFRYnpveXVpYVlSSWdWNXBs?=
 =?utf-8?B?WDEvNTl5Z0F4TnVZbWwvak9ZN09VaTFoVDdlVWRMbTVMTkcvQjl2ZlllQzdk?=
 =?utf-8?B?Nks3Zk9HMzBsbzRLVEtISk5rRko1TFRtRzZLa2R5VFkwQnVDN0dxaVA1K0Vx?=
 =?utf-8?B?QWZyZUoxbUt5WCtIb0JacnYrL2tZcHQ3SzMvOFh3ZjJoSGc0blpuMnc1bXBH?=
 =?utf-8?B?dVg2d2hFUTJjaTE3KzJVZVR2YzdZNUg1czBSbmcxSUZBNDM0WnZua1VjZmNB?=
 =?utf-8?B?MndVYXdEQ0V5ZUM0QUsxRnFmd0pheC9YSHlkamx3YkRSRUFudklOZmQvVWgv?=
 =?utf-8?B?L2pBODJtK0RQQldrcGUycmNTRzc4ZHdhQUhXdVN6RVMxU3Y3WTU2VzBEcHo0?=
 =?utf-8?B?elI0WGNmZzRZckVGbHN1bG1OZEVwSnNkc2lkWlY2Zm1veGhqVnNBa09LanhI?=
 =?utf-8?B?dlN6eXNjdEExSlFDRDRzYlU1U2dBRVk1UHA5bThPRXZmT3VPbGp5OWlZMUIw?=
 =?utf-8?B?T2FBS1p0dmxYcjRUS09YV1UrUTlqU21nVWg0eUs4MjcvUHdva0tpZDJwTXJN?=
 =?utf-8?B?bjBlU0YyaEhuaVJtVjM0SnM4UlYxa1NTdnpsNEMwbUZxYW9IUGxkRGsxSHAw?=
 =?utf-8?B?a283OUl2UEdNNmV3bWVpSCtySWlmMjY4Uzh0Nm0xWmlodEhwYW1XT1U2REp3?=
 =?utf-8?B?SExJNWpUQStHMzdvbjQ0TVM5R0tSRC85bWU1cUZIMVRPcFFHS1BzSzdLMmdP?=
 =?utf-8?Q?RItuz9WZgrM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXhoVzJKMW1pdWM1T3dDN2tTMUxtVm5VYk9ER3BIZUl5WEVPQU1rRUNvMlc0?=
 =?utf-8?B?LzRRbm5kRlRQRGdJeitJLy85RDdSNW81WGhlc0NBbmt0ZmhTSDB5NVlwYnJC?=
 =?utf-8?B?Z3lQdVg0SnpIZ1NUOGE4UzUrNGp0SGJ6SW1MMUlrek16bXBZVEcrdk9kb0Jh?=
 =?utf-8?B?S29BaWFnLy9wRlMwa2hXL3k1ZUxXUDZkeGtSUVliMi83bjBlV2ozN09IN0NP?=
 =?utf-8?B?K0VDMDFNRjdId1FCcU9xZnJWSTRkdWFXVWxkNUo2dFRVTmN4ZHZCVUc4dVJu?=
 =?utf-8?B?NjFWdGRlWE81aytBeCtOZUFmN3lSYitFeVF1b1l0dXdUdU10KzlXbi8xU0NR?=
 =?utf-8?B?VktEZmoxcDdqNUkyenlGalVyLzRzbHhBbGo4OHpqN3pRZE44aGtsaTZ2L0w3?=
 =?utf-8?B?czdiMmVlK2d5YjhudG8zTXpZeitXZm9xTEN1cUgxQzE2U2FFaVhJMEU5RjYv?=
 =?utf-8?B?N2dyZVJlUHBFWDdQOXJWc3hWUzdDWVE0YUZJeTZIOXZTbHlROTZuUkN1eWVR?=
 =?utf-8?B?alFPWUhFbXQ4VzZUUzJUQWYrRSszdnUwdXgvVW5WcWJYQnAwTDNoaXlaS08y?=
 =?utf-8?B?dk5BWiswampJaHdsZDhtRGx5TmF4UXM3S0pNWDZWSmtSTHhkcW5maWpiUXVB?=
 =?utf-8?B?bFRHaWVsN3ZPQk9sS2xPbzNLcm5GbHdscWJXRWdLNnl2WTFjZG8zUWJrSGo4?=
 =?utf-8?B?eFlpbFBsZlVRYjREL2pZQnlNOVZMNHpzS0RWeE1qc09DVCtJekxCTzYwWWhI?=
 =?utf-8?B?SXdHdWxhTnZ5cjFublF4OTlnYlFTMFpET01kbEtJVlprRlpOTU1UV3B6Ni9W?=
 =?utf-8?B?ZWwvSkEvNDB1blVlRXZVOHc2WTZpNFZuTGZzZnhpRjNmQ2JmdkU3d1VrNVVX?=
 =?utf-8?B?aE1VN0RPN2toUGQvRkFSMVpJT3pNdUlBZDBkOWFTbmRzVFhXalp4eUd1dCt2?=
 =?utf-8?B?ME5sa1R6byt5dmRZYis4NFhNdk9CK1E4WmQyNTU3QnV0cVVJM3B5NExRdith?=
 =?utf-8?B?cUZHc3BGSkZMU3Z5T1EzMmZCRG5LY3VKQkVKdFdWZ1ZLY0RMN1EraFpleTZv?=
 =?utf-8?B?RktDUDMvNFJwVFZ1Ulo1Q084bHZpRlZsWXhabCtBcXZuTFR4MjdEaUU5OFgx?=
 =?utf-8?B?MWhJWE5iRVpsbVVIb3ZkalU5SFFNRHRKZU5oZG5meW5ZWHcwbjY5NUw2L1BC?=
 =?utf-8?B?R255UW42NlZuc2RYSTZ0dTFnWVJBK01pSlBaemZOVVpBYkg0a2ZCSnVpM1R4?=
 =?utf-8?B?TTh1bzFPTTRXV1VPN0FORlhiR1FGWTFPTi9rdlpWa2RFU09Ka0MvaFJEalFa?=
 =?utf-8?B?VmZWaUdESS9mQ29MVG1IQWRYd2tWOHllNk54elc1RC9yNWpXWEVFbUwrQ0hi?=
 =?utf-8?B?LzVPdXFzbzV1bVpPVFI5a0ZicWJaM0taOThiRFVDU2ZrT3BNeXVrOWV3dGQ0?=
 =?utf-8?B?c1Rhei8zeVROY2wwdFhFZkNBTUY3YXIxOXAycE5aRGpOUjFhc0dRb1FYRHlO?=
 =?utf-8?B?c0Z6bGJ2T2xIbXh6WTcrbGRNbFdxZ2EwYVRBK0djU0w0OEtGT3NnSTVERzJS?=
 =?utf-8?B?c0JHYWFPeEhDMFA2bEhDOWNBZW9PZFlMbEw0Q3JCbWRWQmM2cG0zNm1OcEtU?=
 =?utf-8?B?Rk5zRHRtY01pRVRGUjVyNHB1a2JZeEZnVEM1Q0tYV2dHcHgxeG1MMm14SUt3?=
 =?utf-8?B?VUFnMitaV1B6WmlGdHZ4Rm9SZWJkMUNrTVJmZUZsZVFPMm5UUUdHUmtRenV0?=
 =?utf-8?B?SHJPcGNvcXVRcnRjWEI4bU4zQWdxdGxYNUwzZmxUOG5KVGpJSU50ZHRkRHFx?=
 =?utf-8?B?WUc5R2JmUnR4b3Q2ZnlGL3J4a1Y0ZlVDamI5ZXFPQTV5UFI0RnoyQUJrbmUw?=
 =?utf-8?B?dkJFRlkvdm1tTUVNeFB2MWNSbGY2aThDYXVkN2J4WldkWWRMMG50Tk1Pdlk0?=
 =?utf-8?B?R2FnTFdVUmVFTXgxUEpjZ0RWRTdvbDlaWjNmMG50cSt2eU40SUl6SXRIalJS?=
 =?utf-8?B?Z1lHdzYycmJudWt1anpHQXppZy9aQzR1bDZkY1lLcGJ5TjhPQm1EVkNWekNH?=
 =?utf-8?B?UWhqSnhhcVI4Q09wWlZyRy9rWi9zeFY3T3l5QTQwN0k3aUdJbU5IU3g1ZjhS?=
 =?utf-8?Q?VGUB8/D74TfIa3VLCuTOA2YY2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a33d613-587f-401c-0c8c-08dd7b3aed20
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 09:58:37.5840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20aqfB96Xl3ZttUTs0DdbdmHqQ4oNWw5bSFtH3XamjhVlR4t/2XR0MV8v74VrBTILl392QeMLQVfx3U2CqnAAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
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

Same explanation as patch 1 of the series here too. Do we want to depend 
on the disable_kq flag solely to enable/disable sdma trap.
IIUC, we dont want to do it in case of kernel queues at all and only 
needed when using userqueue and that is taken care by using the flag 
disable_kq.

Regards
Sunil Khatri

On 4/13/2025 9:36 PM, Alex Deucher wrote:
> We need to take a reference to the interrupts to make
> sure they stay enabled even if the kernel queues have
> disabled them.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 31 +++++++++++++++++++++++++-
>   1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 2249a1ef057bf..c3d53974e7f53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1377,11 +1377,39 @@ static int sdma_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> +static int sdma_v6_0_set_userq_trap_interrupts(struct amdgpu_device *adev,
> +					       bool enable)
> +{
> +	unsigned int irq_type;
> +	int i, r;
> +
> +	if (adev->userq_funcs[AMDGPU_HW_IP_DMA]) {
> +		for (i = 0; i < adev->sdma.num_instances; i++) {
> +			irq_type = AMDGPU_SDMA_IRQ_INSTANCE0 + i;
> +			if (enable)
> +				r = amdgpu_irq_get(adev, &adev->sdma.trap_irq,
> +						   irq_type);
> +			else
> +				r = amdgpu_irq_put(adev, &adev->sdma.trap_irq,
> +						   irq_type);
> +			if (r)
> +				return r;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static int sdma_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
>   
> -	return sdma_v6_0_start(adev);
> +	r = sdma_v6_0_start(adev);
> +	if (r)
> +		return r;
> +
> +	return sdma_v6_0_set_userq_trap_interrupts(adev, true);
>   }
>   
>   static int sdma_v6_0_hw_fini(struct amdgpu_ip_block *ip_block)
> @@ -1393,6 +1421,7 @@ static int sdma_v6_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	sdma_v6_0_ctxempty_int_enable(adev, false);
>   	sdma_v6_0_enable(adev, false);
> +	sdma_v6_0_set_userq_trap_interrupts(adev, false);
>   
>   	return 0;
>   }
