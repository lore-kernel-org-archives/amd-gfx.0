Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08E1C282C6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 18:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B45410E0B5;
	Fri, 28 Feb 2025 18:24:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nNME00/V";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E3FB10E0B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 18:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2u0nwhli5b2f9TBCypJDts4MlF1LLVEphxp3TNE+RhSCl+qy9CMTO45z46E3LXb6hCU+yAU1K4tQAynTCYqyAxoGJz5m4Ck/e+PWW4Bf2briyAUHrH+Q6KvD6A5Ic++Jq/8feXzEBMIuN0zk9LQHfzSeWIcOZRAC92xnOXAJ+ql0drqODLEboBEUTxRtjEyQljce6w1FFDMZ7bEpMsVJY6VHy/GGkwfQjXjXamqOGjmJJmQlQZvKwdGGX/v2tuiYcrsA44yF7T7mEuv4yUAeOqskX7kja3dZht4FY080SsZhJMnMKZKhsD627qW3FB8XwpUs6NOLpzSNQBpRN8fCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUkfi39SQdwC3xLtEf5O1MA7eIbNAuJdxmxHhqmhECk=;
 b=BiCjV2DXJQFKU9gASUAz5ekOag/7H30I6yxSD0kBN5TLz/zQRpL0OKpxdQjfoJTzb0KXgQjadsogf3gjnBSbYIiLav7LTrorY4Ocm5hu0glzAWRSBDrveT0CfqJsxtrYukpbB5qFYxDhEnAq8h3i0jCyHeLDaDIQGY3BEOrAEYJ8RRDZHSIswr3IGEheqw6qR/K0dldAsC2DMAgLrjhpfoOHVnAnMHc4dlzAYAOoSdBpW+pdplLA56I9uq9+uo9EzEwnvQ+x64RGooagX4INfvnyMoW4M3lCzj/+zhySb5H/JuxKIKwbpYbmw/NAaWZ/rETJwa3lbZSAy21ZNLjstQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUkfi39SQdwC3xLtEf5O1MA7eIbNAuJdxmxHhqmhECk=;
 b=nNME00/VmCJhs1KvCjHz6Ab96Z5nU6nXErglRpL/te0q7aNMxrxzhEA3rnxBHVNGGrUnlYjkC7tAedHP4kPYGkjOOf0IQO2N4tLRPELqkPr4G2dC19xe7Z/9mQylWKuX9exMmTqSpVJAqolyY4e9S4j6yDPknyn1XtKxEURDiO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 18:23:53 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 18:23:52 +0000
Message-ID: <11dcbf9e-b1d7-4bc5-902f-0c6e0aa804f9@amd.com>
Date: Fri, 28 Feb 2025 11:23:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/amd/display: Avoid operating on copies of
 backlight caps
To: Mario Limonciello <mario.limonciello@amd.com>,
 "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>
Cc: Harry Wentland <Harry.Wentland@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
References: <20250221171002.209895-1-mario.limonciello@amd.com>
 <20250221171002.209895-4-mario.limonciello@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250221171002.209895-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0163.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::24) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH0PR12MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa599e9-4717-4b0c-2e17-08dd58250d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tm5nMnVmSGd3eHdhWWI4Z1FLUTgrWHVKdXVJTmZpV3lDUm5XUE9zQVNCTmw3?=
 =?utf-8?B?MnREckZFU0dlZ1ljMzdlWjh2L01ybkw2TlRHRXZwMEJmd2ZQYmN5bzJmV2pw?=
 =?utf-8?B?NStNVElUOUJMZzVhMVJJc0dTY0lsT2xkQmM0ZXRKdFMwOU8vTnMvdHZZaUhl?=
 =?utf-8?B?MVR4THJqWm1hdVRGSkpuTE1kOHNONWI3L24vN3FpMjNOd0dWaHVOT3d1eGJ1?=
 =?utf-8?B?anJQNjV0bDArMGlTaHNwK1pkZjBkSzlPVTE4YW5XWWdKcytCd3VNdW5zd1d0?=
 =?utf-8?B?cldZMEI2cUdUdmJkZmJORG14dWd4YWJWNUZuaWRaU3BrTXlLZmpMUVRUQWNF?=
 =?utf-8?B?dzRWNnBRRkVkMEdGNk1wYlAwNDBIRjdPRC9UTndrSVNpNHVtSVV6UHhwRjZR?=
 =?utf-8?B?RFJ2Y0w0STlPNWlnZTZ0eEduWEFxQjA3L0gzOG55cTJJblFzWEZFT2p1YlhU?=
 =?utf-8?B?ZlB5cTRhcUtqUmw1cWtXNU5pMm05R2l5Q0Z5RE9TaEpZOGptZnJkZ3hyeEND?=
 =?utf-8?B?OVhXV0xrQ1hnOTBCSVVzWHlFeDlzelgyV1hYT2NBb0xmcC9MWjRaczc3bUYw?=
 =?utf-8?B?NzhmUzN1TzUwam9NakdCUWpYenV6RWQxd0JFVk92bDBFdWZMdi9IamVuYmJS?=
 =?utf-8?B?N2xnMFA2WVArNVZaVWdiVFI3a3lLdjBPRURVQTdjM0dmMDh3UFQrdFFwaDRV?=
 =?utf-8?B?cmZ6RW5MQ01PdFhRZFJYSkYyRHdZb1BRbUUxWE1uRUU2bmZEbXgzcEYzMVNq?=
 =?utf-8?B?TFB0NmV6eUdqVEFhYVp6cCtiNVpQTUdiZEV3MTV4ZzVRRGxXTDMzcE5PcU1U?=
 =?utf-8?B?MmMxTWVWTmJKNXRhbUtmRDlKRHZRT3NIVVFMek9BNFl0KzFnT2lhQytpdjBv?=
 =?utf-8?B?MDVyWXBhelF4bzFnTGMyL3dFMWlaNVhzalowZkRldHdFT2RKNytGVVVackJj?=
 =?utf-8?B?bDFpKy9KMHBMb2pLeTdTbVdnWlZjSUJyYU1nbXhsRUM5L2h1OXhwVU5tdms1?=
 =?utf-8?B?UUlRL203MWNYQTlJQXhDMFBmakdYdmpycWtING8rVDI2WklSLzAzcTdKUHVq?=
 =?utf-8?B?Y0RFdkp2Q0tZcXhaeWJBQmNMMkFCeDc4ZVI4cjNNK3NrL2FLWlhwU0Z4Mmx2?=
 =?utf-8?B?UjBSWE4rNzhCZ2dVUlJia2MySUg4a1FiVmhlS3RlR3dXRndSbEg4ck9LK2Y3?=
 =?utf-8?B?U1FaaUc2WWJTUFBLVXdEM0k4YVFkTGNCbnNWaUFnL3hIMlUva3hleW5ZdTZL?=
 =?utf-8?B?c05tZ1p2Q0hhWjVjMERyWGV2bmx5ajZXSmJaYnczajNlaUQ2eGxKK01GZlkz?=
 =?utf-8?B?MElIaXJRQWVhVVFya0xCSlNibGhZSUFycnAxeHg0SVE1czJ2bE90RDdPanNM?=
 =?utf-8?B?Nm1rMnVKQ1E5QWgrOWRlR2dyQ1dsT3pCZEhKOVNrNHZmdHMwalFSWHFyUVZ4?=
 =?utf-8?B?RjJTVVNXQi93ZXkyZENJZmhlNGdxajErSEJkMG9HamNwRUJwNm9lUVZoaGZN?=
 =?utf-8?B?bU1id3E4cDJVaVhSdURpZVBDMVRKbGFGMW44cDE3YnRMZ0ZFWGNIbjBDL3dm?=
 =?utf-8?B?ZGpNWUJINytJZ0Z5MlFpLzVOVHZtTXBmUk5RaVdtL3dnbFRscGZmbmFPdHU0?=
 =?utf-8?B?UnhGNUhoeHVKZ1JVVWVnQjZZdElOTUkzOG5McGErVnkwbGxPSStGTXRkYWZ6?=
 =?utf-8?B?YldqT1BWZ0ZOOTRnUjU5UVp2RkN2VUt5RWdsTnlyKy9kM3d1QzBTUW1aYjc2?=
 =?utf-8?B?Sk8zTVNqRXI4UGozU28yL0Z1T21yOE5hTHBQanVpSlRlVmxmZElwa1doVm1T?=
 =?utf-8?B?a0lXNzNjdy8zT0xNTU02WGpiREo1bHpHV3ZrNTBScjJEWjFPSzdIdHZuREd6?=
 =?utf-8?Q?sQpOYpEF+/K7R?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di9hMVRya2hSSnNoQ3U4LzZyakRXdzdRSjhxY3MvY1hMUDFRRXJIUy8wMW53?=
 =?utf-8?B?R21WNXJpUHpIUnA0SkdlM0NKNU9aOTRsVWNROUlCK2tvNVUvalJtZXZXK0dx?=
 =?utf-8?B?R2I2OFJvR1pINjVrdU9PaWF6Vk1mcEhlR3RBQnFzNXNSWWVLRkVIT1pQUnFK?=
 =?utf-8?B?SnlKNEVNdUNrajlJc3ZRTGlFUCtWaC8xRXhzeHRnSjk1WGFYOHVXK0tiM2pZ?=
 =?utf-8?B?Nk9BODBGbFR2Rlp6cnhBWThnSm1XUFdOdVhMWTZCVEFleFdlWXdOV2kxeTRs?=
 =?utf-8?B?TzBYQ0JON2lmV0dMeTlpWFRDT1NaK3dSbk1LdU9sdmxXT1NvMXIzMWM0WmdH?=
 =?utf-8?B?UnN0QmhRVHpoM1RzMUh1elRKeUdkVFNtVytCRXZzek1mOXlkeGVwczNwMGlF?=
 =?utf-8?B?Q2pleGJBM25xSUgxUHNZMVprVXMxNGptSkxWVmpMYUE1MnZTRFoyMDBtWEpx?=
 =?utf-8?B?bjFSR3pQMXlKc1JveStTVmxMM3AyKzh4OUsybkhVWnpJZnplNDdheUxBRFda?=
 =?utf-8?B?VFFCSUxJRWFpVmVOSXYyMEhnUFJUeDQrRmxyOWp0c25TU1c2V1pLeVhyeDFS?=
 =?utf-8?B?d1NYbW85UjNuL0RQT0ZnT1hORmZwTVZYcERvZmNGa2trUDFNcmVpWGI3K3Jn?=
 =?utf-8?B?Q0hxeTdJT1RuMGFOdDd1Nlo4ck12NU1KUGRna3dzTU9NMld6K3VLQUJxWWpx?=
 =?utf-8?B?bWk0MmVpR2tsZ3ZRSjVtUUdvQkV1MnMrbkxWdnoxREl4SUhtdlNSZ0JoWnFm?=
 =?utf-8?B?M3dteVB2cGY5dFJHQXpiaFloNTNDOUMyTTJ3WVZZcE9JRjE5Kzc4OGtxMFB4?=
 =?utf-8?B?ekJRelQ2cFBWK3RPeE5KNWpkYTg5WFdzWHkxYTlqSEpITllyOWh0RVhsa0Ny?=
 =?utf-8?B?NGp4dTFUU3lUdi81a0I3TkRuNmVDbUp4YWZGbHVlL2JzdnlEbXZUT05ZVk00?=
 =?utf-8?B?VHNYOS9TcURNd0Q1SFZXbHZ2anVOMWpKQWpJUzFyRDFJM1dTbXMycmpxZVBq?=
 =?utf-8?B?bVR4MjlTSFNtZjY5UisvaVdIaDZLb0MwZjZaeXVxMGpnU2Y2L3ZJMit3MWwr?=
 =?utf-8?B?dHNiN1JEYUlvcUhuakVJVGJnT3RlZ3BLWHdlK0pyTG4yOTZLWUdBQzdoSUYx?=
 =?utf-8?B?T052dE5PNHhZQ2VwL3U2c3NyWUlFcHI4STgvRWp5eUVYbUxXaTdiUHJJelJw?=
 =?utf-8?B?Z2pYS3kvOGx5UDRkN3FUVlZyR0haeDg4dWcyUyt6ZllzUllUVnY3dkVmdXpt?=
 =?utf-8?B?ZFR1akpYSEV6RFh6cmRpV2FnZk1UaC9qS1FmQUZzSm83dmZyYnFFVkRDbi9M?=
 =?utf-8?B?N0FPK0tKQlhVS09SOGg5bFhTcUE1Q0RKUERiYTN5SllWRVZacUJ5R2tPOUtE?=
 =?utf-8?B?TjJJSWo3SmdVaVVQSjg1VVAwSmNQcmdEdkQ4TVFIVjhhMFYzYW1Bd0FoZ3Ba?=
 =?utf-8?B?MnVTaEVZdWNnSTljcHM2L3ZyaE81YVFkckF5ZDNLb0pUYnlqNnRBMEFwMXVw?=
 =?utf-8?B?SnZmODZwSDltVTJwVFlQcU9LZFpNdnkydlRHMFFwUDV2RWV5SHRtMTUxM0h5?=
 =?utf-8?B?d0RSa0dxNTB1YU9Pa2RPNlBZalMrTW5CYnhoOWphQmkzUFNaR3hnOVFvWmRp?=
 =?utf-8?B?NzFTa0xkeDhudnhSbVE1SWdNaHZCRXFnaGZwaDhUSTFPdzVTSGltNUdSK1h2?=
 =?utf-8?B?MTlOVWNOMEdFaXhYaUJsN3FmZzFKNFl2VDJHczFCMmsxdWdtTEEyRE14UFlj?=
 =?utf-8?B?bFlCOWVHSmdiMlo0ZVB1bzAwRldZcDhES2t5Z01JeFlHSnRaSjFkaGlnTE8y?=
 =?utf-8?B?eUVVNGVXVnhCb1FxbTJkV0pkZTZsTUdFaG9sU21YZDJsTHhqNTFFOTViTjFD?=
 =?utf-8?B?UjlwaDVTSkZ5VGN2eW9FNGxFaDlWc3FmQlo3bGZwWkczWTBjZVJiSGQwQ3Nj?=
 =?utf-8?B?TEtMME9XSlhnM1BYZENtUkI2MVd6akxsajJYNEZpT3pUQUZWK2VkUnl2cE5k?=
 =?utf-8?B?VWxNcDFOZHN1cTdsMWEwTERnOXJleFpYa2w1TkQwRXViZUpOZHA4NC9kTlVo?=
 =?utf-8?B?K05lQyt4dFJaWUIrWGNyOTdudHFFVGNYUEZjTWZYWXpwQ09MM0M3V2EvelIr?=
 =?utf-8?Q?fb3WXRlkOEJ/fUD+9bUvvHHb/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa599e9-4717-4b0c-2e17-08dd58250d6e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:23:52.0091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmtW3w1mTlxyiyXQSH9GV1RIczeZB4V+kR9HCWudSkyiAU/PQaONxnsg8lAxoi45LOe2YKU88/sPPd8b9Pxg+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005
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



On 2/21/25 10:10, Mario Limonciello wrote:
> Making a copy of the backlight caps structure between uses is unnecessary.
> Refer to pointers to the same structure when using it.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 50 ++++++++-----------
>   1 file changed, 21 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0d21448ea700..70c8d800e173 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4646,47 +4646,39 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
>   					    int bl_idx)
>   {
>   #if defined(CONFIG_ACPI)
> -	struct amdgpu_dm_backlight_caps caps;
> -
> -	memset(&caps, 0, sizeof(caps));
> +	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[bl_idx];
>   
> -	if (dm->backlight_caps[bl_idx].caps_valid)
> +	if (caps->caps_valid)
>   		return;
>   
> -	amdgpu_acpi_get_backlight_caps(&caps);
> +	amdgpu_acpi_get_backlight_caps(caps);
>   
>   	/* validate the firmware value is sane */
> -	if (caps.caps_valid) {
> -		int spread = caps.max_input_signal - caps.min_input_signal;
> +	if (caps->caps_valid) {
> +		int spread = caps->max_input_signal - caps->min_input_signal;
>   
> -		if (caps.max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
> -		    caps.min_input_signal < 0 ||
> +		if (caps->max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
> +		    caps->min_input_signal < 0 ||
>   		    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
>   		    spread < AMDGPU_DM_MIN_SPREAD) {
>   			DRM_DEBUG_KMS("DM: Invalid backlight caps: min=%d, max=%d\n",
> -				      caps.min_input_signal, caps.max_input_signal);
> -			caps.caps_valid = false;
> +				      caps->min_input_signal, caps->max_input_signal);
> +			caps->caps_valid = false;
>   		}
>   	}
>   
> -	if (caps.caps_valid) {
> -		dm->backlight_caps[bl_idx].caps_valid = true;
> -		if (caps.aux_support)
> -			return;
> -		dm->backlight_caps[bl_idx].min_input_signal = caps.min_input_signal;
> -		dm->backlight_caps[bl_idx].max_input_signal = caps.max_input_signal;
> -	} else {
> -		dm->backlight_caps[bl_idx].min_input_signal =
> -				AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
> -		dm->backlight_caps[bl_idx].max_input_signal =
> -				AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
> +	if (!caps->caps_valid) {
> +		caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
> +		caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
> +		caps->caps_valid = true;
>   	}
>   #else
> -	if (dm->backlight_caps[bl_idx].aux_support)
> +	if (caps->aux_support)
>   		return;
>   
> -	dm->backlight_caps[bl_idx].min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
> -	dm->backlight_caps[bl_idx].max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
> +	caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
> +	caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
> +	caps->caps_valid = true;


caps is not defined in "#else" so this fails when CONFIG_ACPI is not 
defined.

Below are errors messages for your references

[2025-02-27T05:12:05.659Z] 
/jenkins/workspace/github/dal-linux-promotion-nightly-github/linux_temp/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4714:6: 
error: use of undeclared identifier 'caps'
[2025-02-27T05:12:05.659Z]         if (caps->aux_support)
[2025-02-27T05:12:05.659Z]             ^
[2025-02-27T05:12:05.659Z] 
/jenkins/workspace/github/dal-linux-promotion-nightly-github/linux_temp/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4717:2: 
error: use of undeclared identifier 'caps'
[2025-02-27T05:12:05.659Z]         caps->min_input_signal = 
AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
[2025-02-27T05:12:05.659Z]         ^
[2025-02-27T05:12:05.659Z] 
/jenkins/workspace/github/dal-linux-promotion-nightly-github/linux_temp/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4718:2: 
error: use of undeclared identifier 'caps'
[2025-02-27T05:12:05.659Z]         caps->max_input_signal = 
AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
[2025-02-27T05:12:05.659Z]         ^
[2025-02-27T05:12:05.659Z] 
/jenkins/workspace/github/dal-linux-promotion-nightly-github/linux_temp/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4719:2: 
error: use of undeclared identifier 'caps'
[2025-02-27T05:12:05.659Z]         caps->caps_valid = true;
[2025-02-27T05:12:05.659Z]         ^
[2025-02-27T05:12:05.760Z] 4 errors generated.

>   #endif
>   }
>   
> @@ -4740,19 +4732,19 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>   					 int bl_idx,
>   					 u32 user_brightness)
>   {
> -	struct amdgpu_dm_backlight_caps caps;
> +	struct amdgpu_dm_backlight_caps *caps;
>   	struct dc_link *link;
>   	u32 brightness;
>   	bool rc, reallow_idle = false;
>   
>   	amdgpu_dm_update_backlight_caps(dm, bl_idx);
> -	caps = dm->backlight_caps[bl_idx];
> +	caps = &dm->backlight_caps[bl_idx];
>   
>   	dm->brightness[bl_idx] = user_brightness;
>   	/* update scratch register */
>   	if (bl_idx == 0)
>   		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
> -	brightness = convert_brightness_from_user(&caps, dm->brightness[bl_idx]);
> +	brightness = convert_brightness_from_user(caps, dm->brightness[bl_idx]);
>   	link = (struct dc_link *)dm->backlight_link[bl_idx];
>   
>   	/* Change brightness based on AUX property */
> @@ -4762,7 +4754,7 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>   		reallow_idle = true;
>   	}
>   
> -	if (caps.aux_support) {
> +	if (caps->aux_support) {
>   		rc = dc_link_set_backlight_level_nits(link, true, brightness,
>   						      AUX_BL_DEFAULT_TRANSITION_TIME_MS);
>   		if (!rc)

