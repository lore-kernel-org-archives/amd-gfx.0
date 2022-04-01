Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0961AC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Apr 2022 14:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E71610F4D7;
	Fri,  1 Apr 2022 14:46:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3EF010E3E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Apr 2022 14:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iACmr92LPZUdHmzkyYjHfafoYej/t6WNOcHvSToYqpmlGhVYnEUgsV5Bl90nwcLuqUTO4r2b5zQzyJ1sXAUzT7OcMk1ztML6IqnX+/NNIOHXdN2zL3ysmpLOCQqQX4xTYmdDoE89iBGfgFvet7HE/+bc7N3nveC6HBqMX6tWdsbTA2KzQqoVYtuzCrKEyfOjfP/weWi2SFoEJNE0v3Jwy0bH01X4TRM/hezxWH3Kq+lhkza9E6dX9CjR2L3sHccRTLVXd7j/XJUS4ray1278mrMv9886njm0iiQ+buquOEzdTgsU2omwy6II1iiTAuIiwJa56+6o3MAsMN52eZ7qtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkobDifKck3Zc8nFkekKRq2XEBK3M3HiyZx529nqcCM=;
 b=G7Z+4j9Mxm+6XMrXSANZnTzqeZbMEXHLj3aI/GteHMnLyZvZnEkC0OoK4vx0ZauDqg31CbCFrT8CRqxyjyv9RHIoRJy23PJqEQgaFZnGCxCS47eHg9OK0Z9Hxd2YcpnNZ9tP4AJqpcbmdXXGpUCMxhg8U0FvAjwuWbt/Nvsgs7B4WoSF9H+97Uuz3F6aeDwPhEZYKPztyLa7EKwmYRXqci+mY7glLclzrDh78nacpLBqfhHHtwHLSeLcfaMl7CqXXVFrq3NVxtD0/WwYKaQFsUm+fOx1jfksynI0uAEXULH2HukXfElsOSUPbb9w5gIy8ibzw00GWjV+i5UUZP2lhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkobDifKck3Zc8nFkekKRq2XEBK3M3HiyZx529nqcCM=;
 b=Chg97mTuxz95NnnPaU1/OecWUOSgUeLzKd9igCvFC28ncZW6gi4lKYJ733vP02WE4t42TjlMr7zaYVkVozilzrdxZIjaopn7QFKmciiL6Z2Qk7r5TAQJqVExIbhW8clPwZKOiqVed5THABHKTeGjljJFxcmgTNYWsqH4z69+7kg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL0PR12MB2466.namprd12.prod.outlook.com (2603:10b6:207:4e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 14:46:19 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06%5]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 14:46:19 +0000
Message-ID: <6eb611ce-1606-91cf-c671-e6dc468735aa@amd.com>
Date: Fri, 1 Apr 2022 20:16:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] drm/amdgpu: don't use BACO for reset in S3
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220401140230.2628733-1-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220401140230.2628733-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::13) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 831f0843-0d4a-4406-486f-08da13ee6190
X-MS-TrafficTypeDiagnostic: BL0PR12MB2466:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2466202FF424FB4BDD59F88697E09@BL0PR12MB2466.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AubW0+ausAXhzI+OM+gK5mdjoBoz8ym5eZqBkx/xc3hHvHbsfLsxpHVzSbN+3UVeMwHTtQz9N4W4F12uHN0bNWibWa9NmT/4q+tVAyHFK78Vrb9FU5CUA/B6eWmj2xkZP9wXWCATWQyTdpggqnwK/VdeNhfojtGfQbYu557UGtQ+w9dWITX0PXAS9Erj7wIf4P53OMakS5nYYLXGod1i17qnQQhnjPllH0ugcyJZZeBM/K4RkDe06rALT7OXj4KiNC/NvwOWOnbWJsr8RH18ffymsWaS+cN26bH4YFOGJ+r30/yg8PB9O7390Zb+VuDuWR/6zq1QeMxbTvt4rfnCvrQTXffn1R1hOIFLq+vA1ACeRyvR1G+xahlhhppfo7fIDsQvhJOQACydw4iArt9GX/bb8tZ9eBNnUQVgCfPaIx72lt/hV3al2+wDBUT1AaY340EpX1q6+HX/vQoZdMK4/QcQNDS0XYDlclHBkP1nkqLy4BYZOx+sFy98aH+XN2lVqZKVBf/79d4fCfKhaZiDYfyT93EEFk6fjjqXoEOKpsgasPB9yEZchvMxsn9Vjih2/DuAEgayDuPsehaol+Oao5uiBKEwKRLq3BTr2iH1TxQkHeYraG8jUTBRbE203GJGQ9h8lYVIGcYpejIWRSWGlyb9gdkvVis5VrpJmd1yE6RmCHrSbc7ilPyTSqltWVR4l7Q2NHZonP0G5uBa82o9e/Yx5V0I7JHmF089gYhipN9zBT3TNh+WkT0Y+5yEqrll
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(5660300002)(86362001)(2616005)(2906002)(8676002)(186003)(26005)(83380400001)(66556008)(66946007)(66476007)(53546011)(8936002)(316002)(31686004)(966005)(6486002)(6666004)(6506007)(36756003)(508600001)(38100700002)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXM2aEJzdWVWc25hL2xpVy9LeVVPdkg4eUpPbG1kNlRMbmtBeHE1S0NFTTlj?=
 =?utf-8?B?T00xcnV4bzVGK29uamJ4N2dnaVdkZ3AweEJvV0FUNExwa1NxdklIV29aMXJi?=
 =?utf-8?B?c0I5dzlvdms1aVEydXh1a0FmWmJjeE0rMTlHeTlSd3pFMkR2ZWQ1blhsdGZ4?=
 =?utf-8?B?VVkrUTBSSjVJbSt5a1RBd0FKcmRxN1Nhc2RBdXM4enZHWk5nQzd3aEkwYTNS?=
 =?utf-8?B?UzFhcjhmVDF3endiZHYwZmNtdEhMZlplc1RFdG9FMEdXaE5SVEV4ZHVhOTds?=
 =?utf-8?B?aFRLVjdXQnU5ejQ2Z2laeVFqUktGT09aS2ZFeWVCVDhVWmJTTDZVZC9FRVh5?=
 =?utf-8?B?dDI3SldDRUJ3bS9NakQvSjFsVkx6MWs1Rm9ONHhCOEVpTUtTbGdvY1U2QW1j?=
 =?utf-8?B?NmFMMytNMHZuOFd5ZjRMd3dXRjFPdGdGQm1BY0RrUzZOTXJDbVRycVNVR2VW?=
 =?utf-8?B?TE4xVUJ5bDgxajQyUmpOTDFkK2dzUzZXM3hmWVJ0VjdkUk5YWlZGUHl6OEhh?=
 =?utf-8?B?eGdOZjNWVWpVd2l2U1F4bFBLdXdNVGlsNFgwbnQ3UGJPVlVGemh0dmtWV3BI?=
 =?utf-8?B?Q2dWQnZVNFArbnVwcStiUWxHSmFRbzVnb0x5cEtDbjE1S2RDRWhMTyt2TFBK?=
 =?utf-8?B?YjR1WmVHS3Y0czUzWmVIUnlTTEl6eldFRERFdmdtNVNIdnZhU25rb09TTUFH?=
 =?utf-8?B?TmhLU250amcralVTQTgxeUxRaWJrZEtoekJOZ1ZzVlB2b3l1M05sQlJyVnlC?=
 =?utf-8?B?cUlzWXlyY1p0Q1pydmdoTngzS1ppRjArL0wrWTJpM2ZYRU82NUp0aUdEL2du?=
 =?utf-8?B?SlF3NEhMaEpVLys4cDdxeVpCYzBodzN1SzYwRGZZQ1hWTU5KS2V2SUxXclZK?=
 =?utf-8?B?UzJKc3MxcVByOXd3Mk5VMTdQQ3B0Q1B4QkVnZ3hmMmdKalFSSDlpenBMQUlC?=
 =?utf-8?B?cngrTDdvQVhhcDdUNmRFRm9lM3g1aGJXQ2xRWGhqUlBZLzk0VWlpY2NEbmFM?=
 =?utf-8?B?MTZVeDRZakRmRUc5VVEyVE9NSlVLUWdReFVhT2NDbHF4VklMcnU4c0hkMEta?=
 =?utf-8?B?MDNtWmdEZjRONHV3YUVLcmRpWkdMVit1YmFJbG12OEdiTnVsa09pcUh6NStD?=
 =?utf-8?B?OEpuRHhtR0xoTGtoYjdyTzc0cVY4cmRaeFVzYkMveHNWMXkyVzhGSndTemhN?=
 =?utf-8?B?R2x1YzZVdE1adlRUQmNKNHdNV2ErN1hHcHlsWlp4bnZTeld3a21kRjF4RU1y?=
 =?utf-8?B?R08vZTZsMFFBcUtuVG1PaEVlM3dHQ3QwdnVNRTBpWVI4SERtMGpQQmpJbllS?=
 =?utf-8?B?Y0hkM25hbEoxVFliSEZBMEZsSGtLTklMcjBNVGJ5MmpDWnZWS3pCUEJjTlJo?=
 =?utf-8?B?Q2cybTRpVUxZVTdkS2xxZDA3N2diRjFBR290U0V0RUJQRFFLVC9odnJvcjFV?=
 =?utf-8?B?V015Mm95MjRGdXhSTHEzT2d2QnhPcXJMbUU1VFlvQ3FuS3VkQUwwb2kyTWRD?=
 =?utf-8?B?TVpHanFtUHAySzVOZFhNZjhJZWZlOS81eksxQ1RMTmlyUGZVRkthWUdLTjgr?=
 =?utf-8?B?d0RxSmNmd2JJc01oRGtGeG1mV2hCd2hQeWtzUmF6dUlUYnhQYlBQS2JLTloz?=
 =?utf-8?B?YnJoSmJLNHh4dXlrVmoxTlhZRmFoM2kzU2g2aFZGRW1qaFNhdXJCRS92WjlO?=
 =?utf-8?B?ci9nNTdhMEpMK1k1TG5FSVFvdWx6VjdEbzczRy9ZZVBsZ3VVS0pHVFEzQzlz?=
 =?utf-8?B?U3NuZkx0M21ZY3FuSWRCUE5KdExmcnRpZ3B0SGxLTVh4RHYwWCtaaVQxVHJa?=
 =?utf-8?B?dXhWaUVXczRKVTFlZlQzaU1hcEdFZ240a3FQc2hIN2drbjRqT1NRVGk1K3c1?=
 =?utf-8?B?emFTYVBKeFhnZzFFYVpCNlFyQ1lxSi9TOFRUUHdWb3V0TStUMDdDZjVrWmdR?=
 =?utf-8?B?cjBZOFFVbDZod05vOGhtMDdZNnFkQnlxYUR3WTZOc3NPTXlKSnpBWXZUMERV?=
 =?utf-8?B?cWxJMllXVnFvcDg5dU9IaFVZcFl6L1VpQ21lcEplaGJveWJ4bit0c2RLL3NE?=
 =?utf-8?B?STlMZzk3WmczU202eG9rMXROQ3ZMNklWeTNwWHJFY2NDZm55Z0NGK0tFZkFi?=
 =?utf-8?B?dmV2L3VEemNPbzVBOWswM2tYeEF0bTd0VFFxSGdFSXBEZXlYR2tzckVoemdT?=
 =?utf-8?B?UUpnejFNcjl5ZWx1dGpydU44VFJmWXFhTVNva3RheXZhNTFMRndOWWMrOFdu?=
 =?utf-8?B?QnN1NkswRnpEKytKZUdkVGk1djF3YVdmbWpRSktFZ0tkaVF1Q3lwcVNUWGs3?=
 =?utf-8?B?UGQvU1o3NjJVQlhMZ2FORmRkTFdwZW1pek9uVEpTNThYY01KcHpQQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831f0843-0d4a-4406-486f-08da13ee6190
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 14:46:19.0242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UvtCQVVYgHpkqq2wlByaNhaac/7t7goFCNWM/e8XjibIjqzI8/Sb9xFsKsQlK6J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2466
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



On 4/1/2022 7:32 PM, Alex Deucher wrote:
> Seems to cause a reboots or hangs on some systems.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1924
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1953
> Fixes: daf8de0874ab5b ("drm/amdgpu: always reset the asic in suspend (v2)")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index c73fb73e9628..ee62c74685ae 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -173,6 +173,13 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
>   
>   	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
>   		return false;
> +	/* Don't use baco for reset in S3.
> +	 * This is a workaround for some platforms
> +	 * where entering BACO during suspend
> +	 * seems to cause reboots or hangs.
> +	 */
> +	if (adev->in_s3)
> +		return false;
>   
You may also mention about the thing that there is no device link checks 
during suspend, so it is not a safe thing to forcefully power off 
through BACO.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>   	mutex_lock(&adev->pm.mutex);
>   
> 
