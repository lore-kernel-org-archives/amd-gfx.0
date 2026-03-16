Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58903C5DF77
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 03:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A329010E156;
	Mon, 16 Mar 2026 03:31:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UNQPDHwa";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27FBA10E156
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 03:31:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYf23psXN3EKlsgIP5SbDhmGxG3AZHgHSJEdw6nqEHAbjcLUog/o8GO8Kv4LF9LtLAo0QV6CV1+w7SL3Z71LIQMmq/T0eYv4e2IZ2u6+0x36Gyo42SadDprDe1jpUMDfIkTDqH3bCITlfw0/26OYcEKXzra/PCJnJG14tFt+EO/dIuWTqtmkASM0XH8TC7XD2j73Ro0+/CMfFSB1UJtH5+8h7bzP152/s8C0qMpgKfF3zMabn2+6Cr1PvOovMRdLu0PHphx+98Sa46q+c0l4DJ9eCpADCmpMqzmyWxub4MluxDQK/WKnRvSi7b1XS0aVO8i259ajCF5YK6g3IPgoGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8zBA/Ji9zoURNAXU9cmFf0iyCkZAu32oaYm8SJR72k=;
 b=siak8FRE4Hsk4oIz13ycNhrFJVStlJTJdnbU/ppKRwnfNG6Ve+NHZn9J4i6i9ez7JW2UyActaRZvDCcZ0CvEqQOu3MAMqrENx8wwkDpL+F8Qsng/ugk+p2MDo7ck8j6a5voKNUFeYQBfIE3cyolYWB/5n+wvvz+HhfWnTsqtExllL/OL7mQjZ6fWuEXjG13gR21sJQ4zAH4cb7cX/pPTmiXQmMtRUody0F6c1XtX/k3LyioqRYJzulx2CcMCnwuPHeLayoBt5nZR0zamCv1mLVhbsUxNzRLhLLsSAqlBbXY1xMB4dJSuMYNbYa4zlz0oAdCVr9V2A6nZ/H5n55alWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8zBA/Ji9zoURNAXU9cmFf0iyCkZAu32oaYm8SJR72k=;
 b=UNQPDHwapxHeeNmcWgJ5SgzWyYUG0HutXsk3Oyq7ewSnW7BEKyh0CB1bzMCogviuyEOa7+ypAFXFI2Pkudub7c2hrQZTXe7p9e8/TFTBKTcHW7IQWNAM0G4YZzfyBfJ1vAMq+dI70w4TAbSuuhu7GUBWkgVekeWKjC38Ydd0vN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by SA5PPF634736581.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Mon, 16 Mar
 2026 03:31:46 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::4f70:b453:55c9:a190]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::4f70:b453:55c9:a190%4]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 03:31:46 +0000
Message-ID: <077962d8-0bf0-43b4-8f03-ed5934a99d17@amd.com>
Date: Mon, 16 Mar 2026 11:31:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix DisplayID not-found handling in
 parse_edid_displayid_vrr()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Jerry Zuo <jerry.zuo@amd.com>, Sun peng Li <sunpeng.li@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20260315130237.1933993-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Tom Chung <chiahsuan.chung@amd.com>
In-Reply-To: <20260315130237.1933993-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0015.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::10) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|SA5PPF634736581:EE_
X-MS-Office365-Filtering-Correlation-Id: 20831708-28be-4346-b7f9-08de830c8cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: nAwK7MmpGhFDc5BqQsOqzxloZHt8Nxmu8U3+RkznqWv1CRG4eIb8Dlr14yFh+gkC0/KGZhqbgf2BI0pIyfZGnduleKMyS++5J5PgwEkqNkaNrYkdgzlIpJFw1wibzGRT//lYBXwll/JtBlCtHjydARX2encgsFPCCaenkdZyPngc+z1wVwoKMOxLjlX7WmKmShfOyKgcBJblbZILq3ZxiVlWy4G0QufozGJLGcZwgHjIa7PSxunNFxqsdfa4lFGqguWSiPgznSCLHUe/WbFoPzyCYAiVcOL+HoGKZ/fqfwiEj3F2PTQE394DgJKRZ/ZNdJBahYRuKX3GF1PSA2LIP6swKM/SMd+ebNpWwrbK8Vlsg14qLZhEHyaO+iJ+6/Z8w0pz0RXP+WVJ42yJKVesq6/lqKGDvAgtIimlrZIGS43J3ptXC520/3ffyQe7WVgFsYIJ1HUTfv1CYz07LtK7+lFiHH26w1P1roBiBWGI8PT9vLMcbKPu3h9E1+toDdRTeJmHcJgIbBMJeMZR8dODSYHPdl7QJGxdYY0WSgLXZnprRlhBOqJiONe7rTGgaeeUaV7EZ0w2vMV+GHn91y4oxSXJ9cB2VX/dZmcLAc760MXQnJR3RVjXmRy7HE4w0iBOLM4CfquigyEPbAyWiC8NOIrLDF2n2u/AUpcdLruW+gFP9n4vrrU1Yzi4Be1WGnaAZzEGNsbjY8NI2+6cJ/MPFzZdOPl9/SR3girTFHdSH2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2UzRmdFT29ZVHNFRWQ4K0xSa0pBUS90Z2xkUS8weExHZHpYYlZtMjUxZ3Vi?=
 =?utf-8?B?TmVCU01jMFh2eUZXWGlUTDZ2dzBPMGtOSDQzMlJZbTVxcVR3YlR4d3MvMjBF?=
 =?utf-8?B?enpXTFZ5U1VZRDZyZ2VLcGcxUkRFU1ViM3FSNkc0ZnVDdCtiNngxMCtLRXVD?=
 =?utf-8?B?d1d6NTBkRmNkRU5pRTBhVFB0Y2JWdmtkNGd5ZkM4bFd0djlKRjVKTTVtQU1k?=
 =?utf-8?B?WS9MdzY1T3o0eEtmeXJ6aGNrM0VDMDFjT2U0QStGREFHQXpCbTY0TnIrNWY4?=
 =?utf-8?B?b000d3dZbjZ6b0gwNUpYbjlON2FPUUJuRTVld1pCeFIrYklpMENINWd5ZHEy?=
 =?utf-8?B?THY5MElEeEFmc3g5Ymc3ZXBIVEtlZHYyd2xDZkdTUEE5bVRKVE5mTUcvclp1?=
 =?utf-8?B?ZEJDdkhmTzdNR2pJWTNiaFk4SWRtSFBMSUlZNnRscXdXN0YxUHFxZkcwTi9L?=
 =?utf-8?B?RzhNV1V2dGVzUVJlWE1iVUg5US9sQzlBaDFoeHV2TVYwbGFtRnY2VCtSZmNR?=
 =?utf-8?B?R1NtNHI2VUhVTXo0ZXhNb1dMa3kvektnWGF5dGptaitOZXVrQjVEMS9JQ3B2?=
 =?utf-8?B?UGRMejV2QlF3cy9NT1JjcjQvd2ZlS0E3YXBWTytkVWZtMTh3b2J0Z1cyYWpK?=
 =?utf-8?B?TVdWbjQzc0Q5UWlJWnNaNlIzNjZNMmpzVzJhY0VvdGVPNzRmNHFBeVk5N0sr?=
 =?utf-8?B?NFJUQjQ5dW52OTFPUVo3UXpsR1dyUlJOcU1CVGVUUzRLcEhiSkJ1aDI5UUM4?=
 =?utf-8?B?S29KRUF6RllrTDVlMFh1QUJWTURYV3E1RmFuSzIrTjMrQTdNbEZ1NHFQcEZ4?=
 =?utf-8?B?MlgrZUFHRUpwL2RybGhCUCtpVFp3MkRyOEFTbHRnbHpkbEM1Ny9MUitWM25J?=
 =?utf-8?B?QXBCcHM5dmNnWnJGSExFc2xtUkVNUzhSYzNHVWtqU1RLNnJyZTNoMTB0c1J1?=
 =?utf-8?B?UTJ6Y3dyaklvaGs1Ylp3QXcyTHAxNFNwWVlGTXB1UTE0NU9vbXVhUm5pTGpD?=
 =?utf-8?B?ZXJjWjg0K253V3Y5ajdWSnd5dFU3QnZqSUVubCtvOUwzL0xpOWQyUGVIOU5y?=
 =?utf-8?B?OG9DNFgrU3JHanMxUm0zbkRpNEt6TnB4RVNzRFl2UzkzelRya2k0d0U1WWRK?=
 =?utf-8?B?SDdLZmlXNDBuVG4yMUgyeThRYmppckhZb0RFLy9oaC9DcHkybTljR2NEUHVG?=
 =?utf-8?B?STU5b2o5MDA3RWxZQ0tOSFc4MmxwYTczYTFHOVNPV3J6cmhuYWN6RVNaZyta?=
 =?utf-8?B?N1ZLSGYvTUNzaEZRbCtlb0xpRTd4YU15cFhqRGxsb1JtRzM3TkFrVWdCcHRx?=
 =?utf-8?B?RXBkL1JFb0luQUZEZFdkUHpNQzBDSUJlSEt3QkVMOUdMMDY2KzdJYThRNmxR?=
 =?utf-8?B?VnBUV0VmaHJiaUtpNEE5WDUrY204MTMrS0NxeGhCQVZ0SEtaTnBVUk5IbHRO?=
 =?utf-8?B?dVhhOW0vU1pNcUx6U3ZKMTJjWnJ4aG5mcEl5QTRDRGhDRS9UVWcwNGhSNHVa?=
 =?utf-8?B?MXBaWmUzN2l6OHh3MnRzR3crWHlJNjJrVXhqR01JUkNaUkJLUlE4ejhnaE1m?=
 =?utf-8?B?RUFFOGpnTkgxVVRsVFVjU2I2NFluSEZrZ3QrV2VwcHBYTGVMZCsvWThROWF1?=
 =?utf-8?B?cGhnN2oxMDAwTzJnUStYcEw2YXFmcm1SV3F6Mm85b3VjKzVKK3pXemVML3Ax?=
 =?utf-8?B?eFpYbVNieEpJdXI5WHBwODRvYS9zRWd5dnYvYkhkLzhwZjNVNkRWbFlSZS90?=
 =?utf-8?B?SXFFdy9mOEFDSFl0c2IyLy9jU1VGNmE1K0Zia0Vra2FmUDljblI3L2dQQnNN?=
 =?utf-8?B?a0FYa0h2VXhVUEEwWVY4ek1RSzF3ZHJuZ09qbk9CMXZMdUtpYS9tNThuOUhT?=
 =?utf-8?B?SG1oSXJmZWlwWmFDbERUSWI2OWZRa1RmNlMvUGhXTnZTU3lvbEpxcTZWYnIr?=
 =?utf-8?B?VjV0dnNjNmRybjdYVUtQWHhsNjBmQm16Q1RZbno1R1Vucys4ZFUxaXk4WW8y?=
 =?utf-8?B?RHdoQUM5RlZqaERmOFk2RXNTZmJVajZsKytEczZTMjFRZktsUVR5RHRvUEh0?=
 =?utf-8?B?ODJjVnpYVVpmMUN1bTU4VER4b3BlYVpyRHJxREtYSGQ4dE14NitwYkw5Z0tO?=
 =?utf-8?B?OSsvbENoUVJ0SDlRend4dTVhQllLd1pqeGo2dTFJbWJZR0ZwaVVyVTFVaXFX?=
 =?utf-8?B?ZnlEc09wYWdoVlpDd1ZpV252TUJjb0Vhb1I2ZktRV0tsazFJUEowQ3JoZ2hn?=
 =?utf-8?B?WU5KZ211eHJDZWNFejF0TUd2Q002RGdiZTFIVk04WlhaYlM1VFVNbFpyU1c1?=
 =?utf-8?B?WnlRM1dMZ3hyMnNycEZYQkIxbm16SmNjNlVlWDJUUy9vMWpoY0psdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20831708-28be-4346-b7f9-08de830c8cbf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 03:31:46.0810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vx1wHKWiudxWSlJEICMrkPLFcoyr9yCnzkHBaKe2OfKx5A5qRRpMLRiZcDeO/X/Jp2yqdSV2zbt0nqV8J/VQrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF634736581
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

Patch looks good to me.

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

Thanks,

Tom Chung

On 3/15/2026 9:02 PM, Srinivasan Shanmugam wrote:
> parse_edid_displayid_vrr() searches the EDID extension blocks for a
> DisplayID extension before parsing the dynamic video timing range.
>
> The code previously checked whether edid_ext was NULL after the search
> loop. However, edid_ext is assigned during each iteration of the loop,
> so it will never be NULL once the loop has executed. If no DisplayID
> extension is found, edid_ext ends up pointing to the last extension
> block, and the NULL check does not correctly detect the failure case.
>
> Instead, check whether the loop completed without finding a matching
> DisplayID block by testing "i == edid->extensions". This ensures the
> function exits early when no DisplayID extension is present and avoids
> parsing an unrelated EDID extension block.
>
> Also simplify the EDID validation check using "!edid ||
> !edid->extensions".
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:13079 parse_edid_displayid_vrr() warn: variable dereferenced before check 'edid_ext' (see line 13075)
>
> Fixes: a638b837d0e6 ("drm/amd/display: Fix refresh rate range for some panel")
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Jerry Zuo <jerry.zuo@amd.com>
> Cc: Sun peng Li <sunpeng.li@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5323843c718d..acdc4abbdddc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -13124,7 +13124,7 @@ static void parse_edid_displayid_vrr(struct drm_connector *connector,
>   	u16 min_vfreq;
>   	u16 max_vfreq;
>   
> -	if (edid == NULL || edid->extensions == 0)
> +	if (!edid || !edid->extensions)
>   		return;
>   
>   	/* Find DisplayID extension */
> @@ -13134,7 +13134,7 @@ static void parse_edid_displayid_vrr(struct drm_connector *connector,
>   			break;
>   	}
>   
> -	if (edid_ext == NULL)
> +	if (i == edid->extensions)
>   		return;
>   
>   	while (j < EDID_LENGTH) {
