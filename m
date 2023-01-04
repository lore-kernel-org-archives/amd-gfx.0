Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A021EC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 17:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 216DE10E45E;
	Wed,  4 Jan 2023 17:44:01 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63AFA10E45E
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 17:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRBToopsOTxYvPm9BVb9Rg2tWCFunSHhe7T3Pm6h2dxde2ktij/JO2HUwKu6GmFJwXbW2wS57snIFx2Mo7BZSLVokSmPQbWCW7bNDvim0Cpxpy6kha/+0RbEZH7dzNlGGTZ5aI0eXw+17IHqvIH/lZkLQoBxg+rK9vJ8Kh3dOnF1iBc8gzqZpatmdNPbLx83sXAfEhMN6H/7ft6BnsYSF2JVtjSWlR8MEHCe+F0rkhXsdDnRsGJ9bP4n65916hJnZtI2tLlZleU/ULV7piCHOU7OtdpQkzfsd4B4z+/9oienUEARVfvWpXvQ/xXJMHI8BgifjNlz5isdIju8902iBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSOc7YUhwqJtku6zxXSmFEF++bNBVCWrjRj9dy901J8=;
 b=BqghbzcddH+A3C6mb82gfClH8Li2+ABXUM9gO+GzBYcpY76+GTH3HqaBhp83YX51O1h0TBiB3qYVkmfNv4qqaeK+W8Yd1fhXXxAVzERd+RiyNmRrjd8is4b4DYbV1OtDh/1ncfh33VOo7a3DoA9F0hIDe+9TnPHwbQfHllgNUoZNw1DQRg2OImV5tDLwNqbvO6geQL1Vde1/R40cLRZODrNfY/mTIWEyMJcaDFhMY9g9QyKPgPsycQbB6M037hDmaL0H0fedYYyqygbRh9p02KWqxSC4WHCICCHYMXhbbkJMSVEjiNFv/JGDEqUINb+17LIT7tJWi+OpiQT5P19QVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSOc7YUhwqJtku6zxXSmFEF++bNBVCWrjRj9dy901J8=;
 b=zdeiHYi8Rhds5sJ/xeLLSMU6cgtyoc2UwHI+yRSTX68tuamEpEdwIHVJ5bGQnsedZGL0VuMryCpO1Q0liNcozd1oFBev8h3e46UFqWCBqwUCfUE+2TzykcHR60/+fqDhTjgbVMzL4i49gH0jYG2XzvqCXwONX/3tH6eWu7ZvLzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 17:43:56 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5935:7d8d:e955:6298]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5935:7d8d:e955:6298%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 17:43:56 +0000
Message-ID: <ab72c997-3f6b-57fe-6c64-72f4e1ba456c@amd.com>
Date: Wed, 4 Jan 2023 12:44:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] drm/amd/display: drop unnecessary NULL checks in debugfs
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>, amd-gfx@lists.freedesktop.org
References: <20221227170415.209904-1-aleksei.kodanev@bell-sw.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20221227170415.209904-1-aleksei.kodanev@bell-sw.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::16) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|MN0PR12MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: c4754d8a-d69f-4016-b520-08daee7b4084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVjYuacJvs75dzQr+UuKoatzaarKwo9MxaFn9KdeUxugMCoX1m9QpnlqC9gU2gFpTML1JrN8faARfXw/sjtZ/XZFrH4K6b2RdipYXxkVdLojz5MPnXGioLa9QK9V2tceDZlMnKpitVsitArV5ZgrxA8p1DBE9Z6VE05om5SHIaXXDeCUI3yJmIr9N8+16qD+uqb5QIU1g9MejsBQrCka2rfD/izPKv20Wtrqro8OxsSelmatTAc8k4/W7E4UgcqsojFF+FUjpaQIXZQb7Ptcph+1PeE3I7YGC/UsiYXCUj9QDtR2BP6gFQT01hvjg0mrLHJueeovAoqPPDLihqVWz0EyJxBkVIi0eTMV6JxkdNoUpAbJk+CAa3Cvjaw4PHGBFDiJaUWVCSbA68J2tcKzuZP1p+flM6UBeCjoZ0JhEK0s13N5T7FEBqrRd/YT0EAK/EAWudPtt5Qcy0l8Wx3Oh6zyqW0hyBfFeuj8CBUYRS4/eSvr8R+pVGkNr6mwHqL6HAwa8s/pwHt/yRXmOoFlE8R5BxPfqBbwwflK8zexNSkcgd+AYS7R0aw7zbcV+o757f8Kbsw0gu0fofcr3HHs1uHHAk0WL4kZIoSmQ/Wf608sG7jx8IdkikBfRAvCaBIzcy/4aP6vhwsI0+L/vjyWrwT8LD2SjvXi77BwHTZQz+kjubQYLndrlfV3PMLl6tLD1TpEuRLeeckNAhEWXFn96MxWf24xsN9mTYVNskP2RSU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199015)(5660300002)(2906002)(44832011)(8936002)(41300700001)(478600001)(316002)(8676002)(66476007)(66946007)(66556008)(6486002)(31686004)(6666004)(6512007)(26005)(6506007)(83380400001)(186003)(38100700002)(53546011)(2616005)(31696002)(86362001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjE3emZoUE4yRG9xMnJBMHpsS2h1Ti9md1haeDdQYmxLL0dUd2FmVmtHbi9p?=
 =?utf-8?B?VmU3c2YyZWdKdm1LMXNkd1pkZ3hsMGFKVUJjRzFmcCtlZmdjNVlXNlhCcEpI?=
 =?utf-8?B?Y1dwTUJjSkdvQjJSYk9JWW1GWHhMTWh1eE5adXF2anJrVG5JVy9rdHJwYmE1?=
 =?utf-8?B?YmZ6ZEZGSUhOTnRoNUxVdUVOeXJ5MllwTTUwNWhtTWdGdk8va1FxRWxWeUtx?=
 =?utf-8?B?a3hCM3R3ZVR1Y0I4OTdWeFYyaUd0c01hM3ZRdXp1UzkrWlR4WEhjdWt1UHFW?=
 =?utf-8?B?UUF6cHdmaGhDYmY1QW5uWXBjcXJpTkxyWk9FQzcrcmsrakJNS2NJRUJCU2FK?=
 =?utf-8?B?dGtlL05va2pXOE40QnUzRTJOUzdGTm9TTkp4UUZmVnR2ekZSaVJ6cjhIaWdJ?=
 =?utf-8?B?QWcrUjdpRXhtb0FnNmRZaTVkcllUMjdwNlh1V2hQTndUQU5RYzZHYTl4TlJj?=
 =?utf-8?B?NmJLQlFuNjBhRXgrN25wTHRYMjU1SUhRclJwbzVZdlR4TGR1Zmx0blZ4anhm?=
 =?utf-8?B?bCtPZndna21GY2RYQzlIVEc4WFBwNEppVkEvc0hsTEpQeW5sbURFZW41OFBi?=
 =?utf-8?B?RFdJQndPSEFOWnBneWxPdU8wNHVLS01VbGxZeTFDZWl1b1pBQ1dWTVdzZ01s?=
 =?utf-8?B?eDl4eGVWekQ2YVdYZC9PdjMwUys2OS9lNDdORnVkQzRPdDI4TWJRdkVHUFBa?=
 =?utf-8?B?cWp4dmNweWxBMDBleVNRWFpuUkFOeEh6cUg0R2pWSzBFdkxhMEpiVzRlL0lY?=
 =?utf-8?B?WFlmRUNzcVMzU1haVE14anV5R2VQZU9JYnJYeVViVmxpb2syanRTVERrS2sz?=
 =?utf-8?B?OWUrSFpBamR1WjdpSmtwWnJWSE5MZ1RlOXo3VVFKTE9jYUR1dTB1bHFrbFN1?=
 =?utf-8?B?Z0MyK3pDNTlieXpZS2VMdFg0a0gvaUEvN1FrZk00Y2hobkhzcVNRRHlTb0NM?=
 =?utf-8?B?RnMzaEY4NmFDTGdkMW1CWmhxMTZqcTBwekNjL3ByaEdxWVhsK2pUTm41WnRN?=
 =?utf-8?B?eWM0d3hpSWQ0ZHJiWnMzYnZaQWFWdWRtZGY4b2xEblZKL1hieHl0K1pjR3p4?=
 =?utf-8?B?aUlOK25iUUNubVZsaUJ6L3NoS0JPRlU1SmJtL3dHbkhFd2dySEUzMXU1WWFL?=
 =?utf-8?B?dUxxRnJMVnFVdHVHNkFPZFNnNENWVXBhMkpMTVVDaFFtZ2dZZjJ5NncxZ0F3?=
 =?utf-8?B?VkUxSDBMZnJUdlNDS1E5NEJ4OWs3OEFxUE43MkdUbGJGUDJxOTB5ZVZlU1Vu?=
 =?utf-8?B?cE5TbE1xRHpVQTIwMzZMYjlZZ2U1RDMvL2NSamYrc2NoOUlCWDliOGdNQ21Y?=
 =?utf-8?B?SFdLUDgxTSs1YlQrRUFVNklteHBNVXZuaXRIak1tV2liWWk2L0NDbS9rdG5L?=
 =?utf-8?B?eU45eVAvdW92dXhJNldJNXgweTdPU21YV0tRd2h4WUo3MVB1UUdVdEZEbCtC?=
 =?utf-8?B?VmVmM0hkK3VTdmVFc0k3UEdFb2lsbDRFRnhCYlZVL3dTQVhvRmdXOERyc1dK?=
 =?utf-8?B?RlJkUm1FQXB5a1dscXRkU1BFSThOdjZIRG04OVNoQ2RrWTRWQThIQnlJRERr?=
 =?utf-8?B?REFTeDMvNFRMaFhvOXRTcmc3L2Y4ZCsvaDlHc2V5S1ViYnQwSUhyUWxRZXRj?=
 =?utf-8?B?dFZLWjdGSVpKMWUvMUNMYlllZ3BuNVdtbUkyNFAvQzBoRTFsRVVLWGdGZGh5?=
 =?utf-8?B?OGtPYjQrTmtPYkpZeTlrLzA3YVRtOStQMnFCWnFCbUMyZ0gwQzBpNmlQR1pa?=
 =?utf-8?B?dTR4cWtqTHZvZ0VCMDUveDRtbURDamJaMzlocHNHQy9JQ0Q4SFJNU3hzRVJZ?=
 =?utf-8?B?V0ptaURhbk8xZTJ1eVIyeExMdm5XazNsNW5XRVF6WWp1a3BhRmgwR2dhS2hZ?=
 =?utf-8?B?TXdiK1EyTW8zcEN1bE1haHpOdW82TnVjcnZaSURmdTNBOUsxTzVuMExIbk1w?=
 =?utf-8?B?czFoQ2tBcnVBamVpQWpkeVNJeVpwTFp5dVd5ZGVJdlZPVko5eHZ6V2FxYk5x?=
 =?utf-8?B?bXBnZE5SNmY3SjBTUVhvK1VCVlhTempEc3JCeEFUdkJ1TU4vYkgyOTZYQ0pa?=
 =?utf-8?B?ODdpTTFWaTAyNFFyb3MyYjVmMWdmZ0RQL3pxck0wcmZVakNWWC9CSm1yaCtN?=
 =?utf-8?Q?/+GHcPz+ch8qh0HKCZwQyThbP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4754d8a-d69f-4016-b520-08daee7b4084
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 17:43:56.2485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nZww+cr47UlqiQwv7lelBW+Ty0cMm6rVGzONdeh8yOp8oEHZk/pwygZO7ZcFK+RRvTgrqE7vbPa8/tBijyDCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857
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

On 12/27/22 12:04, Alexey Kodanev wrote:
> pipe_ctx pointer cannot be NULL when getting the address of
> an element of the pipe_ctx array. Moreover, the MAX_PIPES is
> defined as 6, so pipe_ctx is not NULL after the loop either.
> 
> Detected using the static analysis tool - Svace.
> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>

Applied, thanks!

> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 72 +++++--------------
>   1 file changed, 16 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 461037a3dd75..cec16eaf2fb0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -1375,16 +1375,11 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
>   
>   	for (i = 0; i < MAX_PIPES; i++) {
>   		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
> -		if (pipe_ctx && pipe_ctx->stream &&
> +		if (pipe_ctx->stream &&
>   		    pipe_ctx->stream->link == aconnector->dc_link)
>   			break;
>   	}
>   
> -	if (!pipe_ctx) {
> -		kfree(rd_buf);
> -		return -ENXIO;
> -	}
> -
>   	dsc = pipe_ctx->stream_res.dsc;
>   	if (dsc)
>   		dsc->funcs->dsc_read_state(dsc, &dsc_state);
> @@ -1481,12 +1476,12 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
>   
>   	for (i = 0; i < MAX_PIPES; i++) {
>   		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
> -		if (pipe_ctx && pipe_ctx->stream &&
> +		if (pipe_ctx->stream &&
>   		    pipe_ctx->stream->link == aconnector->dc_link)
>   			break;
>   	}
>   
> -	if (!pipe_ctx || !pipe_ctx->stream)
> +	if (!pipe_ctx->stream)
>   		goto done;
>   
>   	// Get CRTC state
> @@ -1566,16 +1561,11 @@ static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
>   
>   	for (i = 0; i < MAX_PIPES; i++) {
>   		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
> -		if (pipe_ctx && pipe_ctx->stream &&
> +		if (pipe_ctx->stream &&
>   		    pipe_ctx->stream->link == aconnector->dc_link)
>   			break;
>   	}
>   
> -	if (!pipe_ctx) {
> -		kfree(rd_buf);
> -		return -ENXIO;
> -	}
> -
>   	dsc = pipe_ctx->stream_res.dsc;
>   	if (dsc)
>   		dsc->funcs->dsc_read_state(dsc, &dsc_state);
> @@ -1670,12 +1660,12 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
>   
>   	for (i = 0; i < MAX_PIPES; i++) {
>   		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
> -		if (pipe_ctx && pipe_ctx->stream &&
> +		if (pipe_ctx->stream &&
>   		    pipe_ctx->stream->link == aconnector->dc_link)
>   			break;
>   	}
>   
> -	if (!pipe_ctx || !pipe_ctx->stream)
> +	if (!pipe_ctx->stream)
>   		goto done;
>   
>   	// Safely get CRTC state
> @@ -1755,16 +1745,11 @@ static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
>   
>   	for (i = 0; i < MAX_PIPES; i++) {
>   		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
> -		if (pipe_ctx && pipe_ctx->stream &&
> +		if (pipe_ctx->stream &&
>   		    pipe_ctx->stream->link == aconnector->dc_link)
>   			break;
>   	}
>   
> -	if (!pipe_ctx) {
> -		kfree(rd_buf);
> -		return -ENXIO;
> -	}
> -
>   	dsc = pipe_ctx->stream_res.dsc;
>   	if (dsc)
>   		dsc->funcs->dsc_read_state(dsc, &dsc_state);
> @@ -1859,12 +1844,12 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
>   
>   	for (i = 0; i < MAX_PIPES; i++) {
>   		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
> -		if (pipe_ctx && pipe_ctx->stream &&
> +		if (pipe_ctx->stream &&
>   		    pipe_ctx->stream->link == aconnector->dc_link)
>   			break;
>   	}
>   
> -	if (!pipe_ctx || !pipe_ctx->stream)
> +	if (!pipe_ctx->stream)
>   		goto done;
>   
>   	// Get CRTC state
> @@ -1940,16 +1925,11 @@ static ssize_t dp_dsc_bits_per_pixel_read(struct file *f, char __user *buf,
>   
>   	for (i = 0; i < MAX_PIPES; i++) {
>   		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
> -		if (pipe_ctx && pipe_ctx->stream &&
> +		if (pipe_ctx->stream &&
>   		    pipe_ctx->stream->link == aconnector->dc_link)
>   			break;
>   	}
>   
> -	if (!pipe_ctx) {
> -		kfree(rd_buf);
> -		return -ENXIO;
> -	}
> -
>   	dsc = pipe_ctx->stream_res.dsc;
>   	if (dsc)
>   		dsc->funcs->dsc_read_state(dsc, &dsc_state);
> @@ -2041,12 +2021,12 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
>   
>   	for (i = 0; i < MAX_PIPES; i++) {
>   		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
> -		if (pipe_ctx && pipe_ctx->stream &&
> +		if (pipe_ctx->stream &&
>   		    pipe_ctx->stream->link == aconnector->dc_link)
>   			break;
>   	}
>   
> -	if (!pipe_ctx || !pipe_ctx->stream)
> +	if (!pipe_ctx->stream)
>   		goto done;
>   
>   	// Get CRTC state
> @@ -2120,16 +2100,11 @@ static ssize_t dp_dsc_pic_width_read(struct file *f, char __user *buf,
>   
>   	for (i = 0; i < MAX_PIPES; i++) {
>   		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
> -		if (pipe_ctx && pipe_ctx->stream &&
> +		if (pipe_ctx->stream &&
>   		    pipe_ctx->stream->link == aconnector->dc_link)
>   			break;
>   	}
>   
> -	if (!pipe_ctx) {
> -		kfree(rd_buf);
> -		return -ENXIO;
> -	}
> -
>   	dsc = pipe_ctx->stream_res.dsc;
>   	if (dsc)
>   		dsc->funcs->dsc_read_state(dsc, &dsc_state);
> @@ -2181,16 +2156,11 @@ static ssize_t dp_dsc_pic_height_read(struct file *f, char __user *buf,
>   
>   	for (i = 0; i < MAX_PIPES; i++) {
>   		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
> -		if (pipe_ctx && pipe_ctx->stream &&
> +		if (pipe_ctx->stream &&
>   		    pipe_ctx->stream->link == aconnector->dc_link)
>   			break;
>   	}
>   
> -	if (!pipe_ctx) {
> -		kfree(rd_buf);
> -		return -ENXIO;
> -	}
> -
>   	dsc = pipe_ctx->stream_res.dsc;
>   	if (dsc)
>   		dsc->funcs->dsc_read_state(dsc, &dsc_state);
> @@ -2257,16 +2227,11 @@ static ssize_t dp_dsc_chunk_size_read(struct file *f, char __user *buf,
>   
>   	for (i = 0; i < MAX_PIPES; i++) {
>   		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
> -		if (pipe_ctx && pipe_ctx->stream &&
> +		if (pipe_ctx->stream &&
>   		    pipe_ctx->stream->link == aconnector->dc_link)
>   			break;
>   	}
>   
> -	if (!pipe_ctx) {
> -		kfree(rd_buf);
> -		return -ENXIO;
> -	}
> -
>   	dsc = pipe_ctx->stream_res.dsc;
>   	if (dsc)
>   		dsc->funcs->dsc_read_state(dsc, &dsc_state);
> @@ -2333,16 +2298,11 @@ static ssize_t dp_dsc_slice_bpg_offset_read(struct file *f, char __user *buf,
>   
>   	for (i = 0; i < MAX_PIPES; i++) {
>   		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
> -		if (pipe_ctx && pipe_ctx->stream &&
> +		if (pipe_ctx->stream &&
>   		    pipe_ctx->stream->link == aconnector->dc_link)
>   			break;
>   	}
>   
> -	if (!pipe_ctx) {
> -		kfree(rd_buf);
> -		return -ENXIO;
> -	}
> -
>   	dsc = pipe_ctx->stream_res.dsc;
>   	if (dsc)
>   		dsc->funcs->dsc_read_state(dsc, &dsc_state);

-- 
Hamza

