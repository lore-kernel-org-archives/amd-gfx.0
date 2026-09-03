Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71117C624DA
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 18:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05B2F10F72B;
	Thu,  3 Sep 2026 18:45:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gHfnN7HV";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C864810F72B
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 18:45:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VO+cT0a1w5nOTfLEyyfvX1ckPi5w8iebnApE915G1CQs9ROsPRXDx2fOKaePtVSpVMNQeVqe3TpRBlKLU6HmF4aIM1MKTSiyo1iqMFHHA7C5mBTEgyXdk3VskUuipG87p0LKRbzHEkrsElOcIBUhvjvpA5FxJ3FQrsZby6DOIGhEhiJzOJt9WudlIiL5g8Zho6fFWwuLHiUwCqpTV04PfpRP57Lovzy4EE+7zTdQmV2fCts5LZqExnLWaCxuandKy4XALm7ZFKdtH8q34PdzK+jn9dJk5Hxn6U4o4tNLbFm/JcQY+SCckVHJyMwjng+/ekzte8VIwg7hpi16UuxB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VU0LChcmRF6LirDsTfJW/H0eBmHpwTYj5hQK2/ENrPw=;
 b=eETXH47cjZo3Fo+UpXCAGB97no4z7aZwA57qukBhtHbnl9owMZMHKIp1RCgpL693VIPCBZMCwo2o5FG77sItly/Z1UWCOVFCT8iypHV61UbwbD4qv612I37VN1bezpHvUvdMWdnSRCN/vTUJlCQpPanANms44MMe1MxB4zhWCsGrMPOsFFozG7BUd5O4EQyj+X1PPB2UVPKB9WZod8BQddB7+BhKHrw5YksTf61ZPwgC8Tn4DpAtyxJTgtzzCdSZrCl2FNk80FjF0hITBEOFr7S0XmqImTSAOWJBEHAmSvDrg1o7Eh4P0CjgZqZ4G9nY+AHlmKRsLmCC2QKBymwfug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU0LChcmRF6LirDsTfJW/H0eBmHpwTYj5hQK2/ENrPw=;
 b=gHfnN7HVqq1DrnTdf1zUnMzUh0b361o998hFAyl0Xi+cTq6Yy+Z1eneIfnURYpw88UXV20AcIaWhzcqrLmRZd2mUGGMiZ+NbU9V4Qzyl+OWk+0BaDCi1t5wuPafbGVtSONaHDlbj9GUrsy4fFNs7jp0l57IbiSq5FAdaZeXk8Sw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DSWPR12MB999130.namprd12.prod.outlook.com (2603:10b6:8:36d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 18:45:00 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 18:45:00 +0000
Message-ID: <c61093af-0f71-4d24-a646-f3caef0d05f5@amd.com>
Date: Thu, 3 Sep 2026 12:44:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm/amdgpu: fix malformed link_settings debugfs output
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20260903183234.426984-1-harry.wentland@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260903183234.426984-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:303:8f::12) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DSWPR12MB999130:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb63ac8-3644-421e-7d68-08df09eb7541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|3023799007|10067099003|6133799003|22082099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: SmoYsNbmL9wJBwxbVqc6MtH2VmVDwbUA2aszmbjQIdhF1wrzW8eudF67nDJ0lEoTcSmCpEReLYFMVWxJqGJfro82Cg+/SZQRmm4AWBA3oDUJkbVnk9PzIljbjHlp46uQ9kw4pM6nObR7d4gog4itud8ZjkRu9DmUkP/8yGXDQ/Lxr8eyX+HHTCKzXSdj2w/HHZ14yzgewJqPgl0pt2M2j95tGfYDnM7rte/EbWG5J7GRRunLcbXqPYA/2iGrRWkK+000leRdhUq3AONbHhEfseotNLxbv6W6Ax8mPOJ1ieH/S6ZqLC/m1+SzDYDH/3sc2id177koyxxr1veiu+Hj7dk470l+shy3Tnn7id9iB/ECdRjUKx8wgDgigYhe1DkpIUEeULmYgNNUxvWn7x53AKFSqB5Yrozz7KueMuKSgFm8Sro4aI99E8HG3uJiUzxzQ2Ktt7dg7wUDP/wg9LYZSg8QkyUJQHLAJbvpKZyqRUsECu0nE+9J0Wnhq8A1QnfJ4gKRRDuCyCdt1YPxMHghWepwbaYRns03XOzxU01OmmNaMgLQJIQGYtzb15CPUT9nzh3Zf8ZqC5E60bR4VE5XJf9n5a47e+UnTnBPoLGtlRg9f3tkwPN2Y2WqVapUF5ZzvjwcV2QZ47G0i68y3cUBYI/ddtUr6ZtT79XoKkHh38s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(3023799007)(10067099003)(6133799003)(22082099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0VzMnY0RnRBZ1ZwQkRxUXMrbkZ5dk1vQ0RBVGt5U2w1T0cwVjRYek1iZE9C?=
 =?utf-8?B?a3dPa0RjUExZbXF3dVp6OXJMQXZXaW5TbkhkNFBqRVJzK0ZwSHBjYmoyWUV3?=
 =?utf-8?B?Q2hjY09VM3A0eFBzVXgzWEVESHN0amlzMy8vOU1lcll5VHltcUYrZ2sxRThP?=
 =?utf-8?B?aEg4WmY3eGpyeC9FY2N0QTJKQUo3MGQ5UXZNSnRIcUVtNkEwYm9JTm02aEUz?=
 =?utf-8?B?OWN6OXpnYXJMaEhrMk5sTTFkZjVXUXBQOWhiTm44TnZjL2QxMWVmbzN5WVY1?=
 =?utf-8?B?a1cxVzVXYmRJYXUyVHUvb2ZqdG8wclNqbDZaVW5QZ1dySkMvcTNNb21VaXdG?=
 =?utf-8?B?TXZLNHh5ZkduNHB2YVVwT1FwaXp2VzN2YzZjZVRXbDNHWlByclJMMWZQdHRV?=
 =?utf-8?B?ZUlmTGZSRmN0d3JWS0hJUHZvaGpBb1VRVFhuZVFZWmtUSDlYd0NnY3Jya2FB?=
 =?utf-8?B?OG1HT0RkM3lpWnh3c2s1WG9pL2E4MUZLVmlibi9GRU1OcDRMNVI1K1ZBRGVQ?=
 =?utf-8?B?U3pvQ09qYWtWc0hMbGYzamlCbmNkdjZVa0cvREl0VG5wdGc5a2hWNlVYS1Rm?=
 =?utf-8?B?TE5INitlY1Y4dStjdHlwR05UU0dId2RjRXJDcjI1V2xpYzF1bGpOQk54VWly?=
 =?utf-8?B?R1ZZemQ5V3padG1OTFd6Zm5CQ0pxUHh3a096eW92cTZ2MGw3YklZQWxSYnhI?=
 =?utf-8?B?Q2lRaGhGRG1mOWlvZUlwaGxRUDIzQTNuNGJZLytOTCs5cGwxNXdPbHhHWFpk?=
 =?utf-8?B?ODI0L3BzUDBUSkZYVHBOcDBjRnIrZTlVK0RMRFVpSHNhSmlvUjIrZ0VRbWt0?=
 =?utf-8?B?alZOVlhGak1vSU9uWEh0dVdjbVlZU2JaNWZ3THQwZHorSkRjcnRrNDNQQkJK?=
 =?utf-8?B?YUlXMWZ6Ym1PVUVPUWVWSlppZVRqMzJKS2hBdkpsTUkvQVI1QUxvL0RiY0lp?=
 =?utf-8?B?Z3RWRkthc0x6NDNkNXV3aDNQTEtrdTljSE4yaXFKRzVwVkQ2UmdnM01nV1Jk?=
 =?utf-8?B?WDJpdkt2QkdMZUlVdXNVdlp6ZFNKSkVvUnZoWS92Y3krc2JNQ0QyZ3pHaWNa?=
 =?utf-8?B?MldPdkIzSzdlZlZwekt6cGFtd3pHai9zNHlqR2ptWWFuTEh6SVFpdWplZ3Vh?=
 =?utf-8?B?QnlUT2dSdVZpeXdVbkozVlR1WlR0ditXVGh3WTA3UlZESmZSVFBpQWdoWGV1?=
 =?utf-8?B?K3IrVnJJZFpaai95S0M0dWNZTEF3QXVTWHVpaWhLa2twbnRrNlNNZFlyRGJT?=
 =?utf-8?B?bWJzNHhhTGdMbVYvZjUrSHRrejdCQVEyWEZyUk5oWWpHcHZiSTByZ3lzTVRI?=
 =?utf-8?B?VENKeGs2U0Z6NUFvaHhHOGpyQzFDdTJ5LzlsbjY1ZnVwT2s5UXpTREdwVG5N?=
 =?utf-8?B?VERJa2FpbkZuZ05zNWN6M3R1aWl1VjQzcDVGT1FNMWp0ZXhlRk1PYmM0TDFU?=
 =?utf-8?B?OTJXZEQ2NmpJekVNcWRVdDB1RkRWZFRJb2E4WjJ6YkY0OFV3aHBwYnAxZW9t?=
 =?utf-8?B?NFBNKzMxM2J4QnNzWnpBL1J0VlBTUitFUkZoQVRVUWovaDV2dTlaVHYyRGg2?=
 =?utf-8?B?Tnl6UW0wL2g0M28xclJuZzFvNlpEWktQWldka3Q1dkc1Vk9SRnRQZzRQSy9S?=
 =?utf-8?B?bG42VXl0dFVGU2JKMnRhV2szQlpLdDBnb0pRSnRpOWlNUnF0aTVlZndIbjJy?=
 =?utf-8?B?SUl0WGFJQW43aWJJWXB3ZHp5ZmlEUDlxN0dka0ZBZWNwM29sOUloRUNLTDlW?=
 =?utf-8?B?RXprSzc2eENFWEl6ZTVrbHkxNFU1d0s4TWYxaHRidHA5ZytkS1loTzV4NmQr?=
 =?utf-8?B?TVZLUkVQb3RMTkRVaGZPNEdwL3NQbTVkblNPWFRISzdQNXBHK3RQMXhYWWNy?=
 =?utf-8?B?RzhoanJVcWFVUWs1WFpPcmY1UHU2TzBIOVdKNkZEK2lhamIxbDVMRTlDQlJC?=
 =?utf-8?B?V0FJSHJvS3NzNHBOT1NGcTF3TS92elN3U0gzM2hCOTBoTzF5NlhhZGlyR3ZW?=
 =?utf-8?B?WlR3VWN4WVBZaTdhdWY4d3hnTWZaSjNPemhPdUx2OUJwb0hKZ0R6VGZHT2pl?=
 =?utf-8?B?LzlsUkJ1aC9rdE5RZ3U0RktDWW9sZVp1MFV6VHl6N1dtN1IzMldSMXh3NklX?=
 =?utf-8?B?RXFXQWY5VkxhSEtzZkYzcWppZERGZkdEK0UwRVdzdWRqKzUybldtMzlybFBp?=
 =?utf-8?B?dHJsRElVMmtibnhvMlRPRmpFQTZqNE5icHFBc0RFSUs4aVNncG5Mb3VrV3dR?=
 =?utf-8?B?TVJUUUZMeFNqeGRaSFRKZHlJSENvTmt4Q2d0dmxsQllUcmt2MXYxdnNnWXBQ?=
 =?utf-8?Q?5vFuKp58vsRnb9J5Fu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb63ac8-3644-421e-7d68-08df09eb7541
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 18:45:00.0723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZgWphsGOTnecFBJkJ5nTsI4I+Gab5yrFXpMNS5fQMrRpKiP+Cs0Wspo09OxCZoOZdIAr/TglVXDgHFYgbAovg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999130
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 9/3/26 12:32, Harry Wentland wrote:
> [Why]
> dp_link_settings_read() passed strlen() of each format string as the size
> argument to snprintf() and then advanced rd_buf_ptr by that same fixed amount.
> The format-string length has no relation to the formatted output length, so
> snprintf() truncated each field at a NUL it wrote inside the buffer while the
> pointer was advanced past it. The result is a buffer peppered with embedded NUL
> bytes and fields that are silently cut short, so the data read back from the
> debugfs node does not reflect the actual link settings.
> 
> [How]
> Use scnprintf() with the real remaining buffer size
> (rd_buf_size - (rd_buf_ptr - rd_buf)) and advance rd_buf_ptr by its return
> value, which is the number of characters actually written. This both bounds
> each write to the space left in rd_buf and keeps the output a single,
> properly terminated string. The now-unused str_len local is removed.
> 
> Fixes: 41db5f1931ec ("drm/amd/display: set-read link rate and lane count through debugfs")
> Cc: stable@vger.kernel.org
> Assisted-by: Copilot:claude-opus-4.8
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 20 ++++++++-----------
>   1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index e4c92b1fa22e..36f32ed4b87c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -196,7 +196,6 @@ static ssize_t dp_link_settings_read(struct file *f, char __user *buf,
>   	char *rd_buf_ptr = NULL;
>   	const uint32_t rd_buf_size = 100;
>   	uint32_t result = 0;
> -	uint8_t str_len = 0;
>   	int r;
>   
>   	if (*pos & 3 || size & 3)
> @@ -208,29 +207,26 @@ static ssize_t dp_link_settings_read(struct file *f, char __user *buf,
>   
>   	rd_buf_ptr = rd_buf;
>   
> -	str_len = strlen("Current:  %d  0x%x  %d  ");
> -	snprintf(rd_buf_ptr, str_len, "Current:  %d  0x%x  %d  ",
> +	rd_buf_ptr += scnprintf(rd_buf_ptr, rd_buf_size - (rd_buf_ptr - rd_buf),
> +			"Current:  %d  0x%x  %d  ",
>   			link->cur_link_settings.lane_count,
>   			link->cur_link_settings.link_rate,
>   			link->cur_link_settings.link_spread);
> -	rd_buf_ptr += str_len;
>   
> -	str_len = strlen("Verified:  %d  0x%x  %d  ");
> -	snprintf(rd_buf_ptr, str_len, "Verified:  %d  0x%x  %d  ",
> +	rd_buf_ptr += scnprintf(rd_buf_ptr, rd_buf_size - (rd_buf_ptr - rd_buf),
> +			"Verified:  %d  0x%x  %d  ",
>   			link->verified_link_cap.lane_count,
>   			link->verified_link_cap.link_rate,
>   			link->verified_link_cap.link_spread);
> -	rd_buf_ptr += str_len;
>   
> -	str_len = strlen("Reported:  %d  0x%x  %d  ");
> -	snprintf(rd_buf_ptr, str_len, "Reported:  %d  0x%x  %d  ",
> +	rd_buf_ptr += scnprintf(rd_buf_ptr, rd_buf_size - (rd_buf_ptr - rd_buf),
> +			"Reported:  %d  0x%x  %d  ",
>   			link->reported_link_cap.lane_count,
>   			link->reported_link_cap.link_rate,
>   			link->reported_link_cap.link_spread);
> -	rd_buf_ptr += str_len;
>   
> -	str_len = strlen("Preferred:  %d  0x%x  %d  ");
> -	snprintf(rd_buf_ptr, str_len, "Preferred:  %d  0x%x  %d\n",
> +	rd_buf_ptr += scnprintf(rd_buf_ptr, rd_buf_size - (rd_buf_ptr - rd_buf),
> +			"Preferred:  %d  0x%x  %d\n",
>   			link->preferred_link_setting.lane_count,
>   			link->preferred_link_setting.link_rate,
>   			link->preferred_link_setting.link_spread);

