Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8661125858
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 17:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65BFA10E3D5;
	Wed, 11 Mar 2026 17:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iq+Roi01";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013003.outbound.protection.outlook.com
 [40.93.196.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 757B710E3DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 17:51:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqX8ZtpJ4JBLNZePsmweKBq1Fh94Xf6sFH2GH6VzBWDnCaSrS5THnPMna0NjhRepdU+a1qbkMsPhPg31av3uLDMkSMmts/dQTTSRTxdfuBm7ZquwXc8DJR2OXeBTLt8MCKDR7ek1DsTfV14vdgzHGwSHmrn5pyHmd4Hen6d/xkrvvnT8YlcWdbbY/l9NXQDMk3ElLJKraeHmYX9PG6pGGl5SMQWSWivMjE6UpRm0FCzKnOe2FbHbi272kMx5UD/TZhfSB9mk0Zc8bkgdP8gvkXogXSY1Ni+4M9UyXQums3K+jPQfFrZMOwILvh1igl176P8lT7/KBdPBHYZcR0uijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4acGppuu38AW0GWlvV2q5dc3In5QcR1O5M+nZnYT4V8=;
 b=QHtyxKtTKI+R4BxDDU+6ErTkjrxr9uygR1fil/fs6X4MGZjvxCWMXh5W+0fHds3F+AoPeQM3+cn+PRjWHKxZTOb7CHpTQOkjDdNMZy76yXhUbsVA+rv/6/ts2Du4GdBdKAoK5NZTrYeOh/YZNymGFEDwRy1pg8Lm+ZjPqJ5Z4HVvSR72s2XXKTZa3sS+NxoP8b/AXEnjA1LDGpYM/CKOM9VL3l+m/TnbnRx+g43HStU+oGyaFhI6nQDHRW+iTK3FbuLDT81YV+kw3YYlzjTqzw7Vv18bl25D8Oh+yfhqQw9nB6NvFWTJa2Hyhz0tSk/7dGCHdDkA5y3kZqVNj60DSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4acGppuu38AW0GWlvV2q5dc3In5QcR1O5M+nZnYT4V8=;
 b=iq+Roi01IZmGl4VeosAlhKymFGxopaUglDnwG2NMZZ9qRt6I5jczS/o2uLnOBQAF2kz/48a96RmyX9WW+YqTHeAx0qc9GvBnwdzRf257Op+3DJjMpOJyMuUJbkLf+BnnhyDP4DTt45QBHoCj0Pjkt/iWRdCU5u6hd7DhaBbWvoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 17:51:52 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 17:51:50 +0000
Message-ID: <05767344-6fb2-483e-b553-2921753ee40b@amd.com>
Date: Wed, 11 Mar 2026 12:51:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Fix ISP segfault issue in kernel v7.0
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 mlimonci@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: rafael.j.wysocki@intel.com, benjamin.chan@amd.com, bin.du@amd.com,
 king.li@amd.com
References: <20260311174251.3121654-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260311174251.3121654-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:806:f3::29) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee68ac7-433b-4625-dcd1-08de7f96df98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: bFc14+P9u4kjQB1/Cje7P0rDo6SYlOrFmXlCp/uw3w1KkwYBrq3WovZCJJ7CEtpVJE4wbb9noV+CG6FUUQQTyqha0mpT+wOZ0jHax9Qjt6HSEYQm3xD9jFEu97Bu+MKkYmplJICP8xQrwmxmiJUjpeasHf/Vp8KZHHHY0Ru2rEsq17nOYhb3W4J86XyixQyLWhiIICX2cBVsYFdta18t+ITIT3lexQPpBQ82/5n3q7iC62HjR2zNRlIR0XkIqHMQjCDtzfcabYdK9Qroy6U+1MBYvHTns6LXaMIquMU0FEmoqKGDlFyasNaXKm9Anvq+Ne6Mjmm1IrGHfIkZikJz4T+YpEg2AiHdyrr/4hORKYrWPBukf3jdpFr0lrS3TN/jBG8J74rLgXnBnkFnyk+yaFq9DgJkquSS2Oi4wCiV9/Tb8aVOTQytMDciHEbxz+eLDHIwjVGjqELx+05T3GSObhM2vtH1oki4AKYPyAu3vGvY6tn5266hOYju0ZZn0SXrVqEhnPctzm0x7Sr539VSGQIvDld9BPrKZXMsKi1MI5G756N0UxIXJOr/yfOVOAgcJvV29lxi0yMxUYpc49G7t8kLJtdLIwTroEYUZnIXt5RYBxJxbZxjI/FoMW2CwVz33NkTUU2bXgMoINNXNpLl3qitvBNoSi05c4Som8gowJjotw4TWrV3nUc+2Xbl7zpYNySj2Phn3iDZYir4XF2QtEMcwOXQMDcosnetXHm+YcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFY0NTNYSmRsSWxvK040dkNSbnRFU0ZPTk1LQWdYRHBiL3F2Q1d1czZxTTJL?=
 =?utf-8?B?azRQbXVTMktnNXdtNkw3azhmU2dmZStYOU50V0Zic1FCcUlReTVlM21TRlgz?=
 =?utf-8?B?RCtZZVJsTXlxMHVnUEVRTHQ0NURSajlFVXlwNm13V3ArZldQYjVjZ2t0Mmtn?=
 =?utf-8?B?V2FTSEU5YkFlV1VacnU2MThRNkE0SzZPb2NEWnUxSFZ2WU4yZE80NG1KQkxD?=
 =?utf-8?B?eDZZSjZtS2FHMXpQU0IycWJtUlVQN1p1dlBBajFmSjJpeG05bjVPZFBjV1RL?=
 =?utf-8?B?M2tiRkhjMnF1QnRPVW5PUU05aFBaa3AvRGJTRTY5WkpCditVM1hmQklZNmNj?=
 =?utf-8?B?OXdHOENIM2wzc3BqR1IvSEZxdzRyQ3F3WEdmVUFsTmx1dFl1N3dPOFRqUFIy?=
 =?utf-8?B?eEJSUjFhR1l5NmVjZE5jTHg5eG0xRWtCTmR4UTlqRlVyaGk5Z2FFSXRFNG1G?=
 =?utf-8?B?R2lrMHc5SVFLeEUwL1ZZRlFMOUFGR3RzZENxVjlSd0ZjZVBqbTFHalR2WE8z?=
 =?utf-8?B?cVZQWW1TY3RxcklIbzdJaWhEZGxjdUlyTUlZL0ZFNDdHS3oxUHFlNWxjeEVG?=
 =?utf-8?B?RG1DTU1CUk5iUEJkU3l3QVdnZmIyWGxNbEdPcVczUDJHelZHMmVIOHppRFQx?=
 =?utf-8?B?UzJpMFowM28yOUpUMzlIblVxbndrTXBROTB0M0VsbEszb1ZzNGM1dGlnaUdj?=
 =?utf-8?B?eG1vL3dQM3hTbWV0RmE4WVJBMmFUMlFScG4zejdCRXFXY2RLVElRRVdDWjE1?=
 =?utf-8?B?Z1ZwVkZxK2VzMlNvNWdaZk1zY2ZPZmZIWGl0bHl6VEZWU0h2MCtJWENjbkh6?=
 =?utf-8?B?SGJwbkxGL3ZiUjBLWi9VRFN3K2h6bUlVMmV6a25ucjY4ZkJRbEhjYVcwelU0?=
 =?utf-8?B?bUVvZGpORlZIRWN4cTlYQUdycXg2VkJ1MjdsblZxcUhzUHN5R2pMUVM5TGQy?=
 =?utf-8?B?dDVtTS9hWHNub2xkR08rRmcxQTBtTm41UTN6N3BsL3hTV2JudXExV0tua1BP?=
 =?utf-8?B?MmZxZXNCWkZNbEdqTzZidGs1cU9OK09XSjhoK3BRdmZIWEM2UmJxd0hGOFRu?=
 =?utf-8?B?Nk4zWEVmeGdIckN3eWc1OEVwUnBVSVVQbDZEY1VTN2dGYnprVHIxc01vbkRo?=
 =?utf-8?B?aFhZdmVxUHV0Wk5IZ25SMmhPUUxJZG9seHF2ais5N1hpUEMxdXhZbkl1MWpq?=
 =?utf-8?B?Wmw0aW9xRnZ5QkdIRUw3V05CdktnQmdRaGh5RFlKTTdoeWtXdERlNllmaXF4?=
 =?utf-8?B?Vkt1QzFxYmRjSzNQM1JieFFjMkF5enZKbWRWUDlQT1Z3TVRFOUNUYUdWRW1k?=
 =?utf-8?B?RkdZbWZqT2N4SC8vMW12bGhBK3ZvbVJldkNlUkxJNGJLMzU3ZWFEeEsrTXZN?=
 =?utf-8?B?c1pXeVZrV2pmNExnVSs3ekEzLzBtUFZKOGFkSFM1d0xQejJtaTRObzIya0JT?=
 =?utf-8?B?c0RSaUNlaVVVNHlVbEprU3RsaCt2ejZpQWlLS044NHp0Tm4yWldxdURLaktn?=
 =?utf-8?B?NWJCM3pGNkFkdXE4VExETVJuVlhuS2dQSTVyc0hXWVYxVmJPVWg3MDVYK3hV?=
 =?utf-8?B?SjNPVUtJcFBXeTYyaCswWC9nbzZLd0dVaUhkY1JGT1A1N08vQVo4Qm1oU2Y5?=
 =?utf-8?B?MWtrdmIzUWx0OEJFUG52UHVaWHhtKy9iMkJPaVFIcm1qcHNrKzE0RURkN2NR?=
 =?utf-8?B?NXRPaGtHekNsNWdNSmNpYkRqRXpBOWdVWkpZb3htdmZWT3ZkMFNNRThDeEpO?=
 =?utf-8?B?NnVOODRJTTNMZVYyaGpLcXMyOTdLTXE0dUxQUEIyUWdMRDZ4YWhUeGFQQnVQ?=
 =?utf-8?B?TUo0bU9SbTZZdnZUcFlsdnVCaHpSc04xRTY1dXRFZmVFOTR4Tzd6cUhhcTB6?=
 =?utf-8?B?QitNVnBzU1BQak1XWVMrdXJNYUpiUzFySit4Rml1QURqWUd2UFVuME16YVdL?=
 =?utf-8?B?Qm05VGZyTGhtU0N4UUpINjEzbUNhRncxK0xxS0dKcFdXWHoyUUFmMmo3K1k4?=
 =?utf-8?B?VG1uYmxCTiszN3VON2lXUVA2SlZBNXF1UkJNdWYwcUtXbkxFSlkyZkZyN2Jz?=
 =?utf-8?B?KzVaVXNvblFnY1k1aUh4WWdrOVBYcVQyVVF4MTVNK01LS0w4N0dPOStwZlFk?=
 =?utf-8?B?V1AzQ3VRNkZkd0NHcG50c25XT25HSlZWWFk0SC9iTXZhbFdJN1ZQbzI3U0hH?=
 =?utf-8?B?UWphRWU5bUZrU0U2TWlyVjhCRjRwRUI0R3BRRmlVWHh6TG1nVk1jSUE0WGxE?=
 =?utf-8?B?U3djN2xxTDI0TFd3Uit6eS8ycEFTR0JuV0ZTMmIrSm1PQnkrYTE1dUExbUky?=
 =?utf-8?B?L0k4QW03UFVpV1AvcTd2bGU0a2FvaDh1b0xORXFwSkRBWGxBeDFEZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee68ac7-433b-4625-dcd1-08de7f96df98
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:51:50.7595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yl5GtqsTtU2nVjDJKStsPt50zdVtYk0hnXpnXP1mKwWX8vnvSGu2rtHvpLyy9jHQFFAiGM/BSkSFm0e0mNS7sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055
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



On 3/11/26 12:41, Pratap Nirujogi wrote:
> Add NULL pointer checks for dev->type before accessing
> dev->type->name in ISP genpd add/remove functions to
> prevent kernel crashes.
> 
> This regression was introduced in v7.0 as the wakeup sources
> are registered using physical device instead of ACPI device.
> This led to adding wakeup source device as the first child of
> AMDGPU device without initializing dev-type variable, and
> resulted in segfault when accessed it in the amdgpu isp driver.
> 
> Fixes: 057edc58aa59 ("ACPI: PM: Register wakeup sources under physical devices")
> Suggested-by: Bin Du <Bin.Du@amd.com>
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Changes v2 -> v3:
> 
> - S-o-b tag is not applicable when Suggested-by is used, so it is removed.
> 
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> index b3590b33cab9e..485ecdec96184 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> @@ -129,7 +129,7 @@ static int isp_genpd_add_device(struct device *dev, void *data)
>   	if (!pdev)
>   		return -EINVAL;
>   
> -	if (!dev->type->name) {
> +	if (!dev->type || !dev->type->name) {
>   		drm_dbg(&adev->ddev, "Invalid device type to add\n");
>   		goto exit;
>   	}
> @@ -165,7 +165,7 @@ static int isp_genpd_remove_device(struct device *dev, void *data)
>   	if (!pdev)
>   		return -EINVAL;
>   
> -	if (!dev->type->name) {
> +	if (!dev->type || !dev->type->name) {
>   		drm_dbg(&adev->ddev, "Invalid device type to remove\n");
>   		goto exit;
>   	}

