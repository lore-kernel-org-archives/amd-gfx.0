Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2746C07CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 15:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C92310E61A;
	Wed, 29 Nov 2023 15:46:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6802F10E61A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 15:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2+6JfXnXlMN0bmOo/5y85EaxecpYSqQt7uEbyiPpKaXyG6FbjsAtVGS/BBHyVOQF54KWvNR8FC1YGMD79PMRaYh6EHP5cCvOTjv5QeSmAZgHbZ/6fPH4xYNChima/uZuEgGuAuacWNlSPU1B9fPL50Rcys1eoSe4tLFL2LJ+sO7mkkCc7+dypTRBAHMAw5d2AZRm+OVpzP3K4Rvk89qU1iXYv4/dWBAJq8zCo63QE3wbZ2ZDGWtQvSx42eDKNw1Vs+ceewVisZ9t5DTB54xGbH6xkid8nGQeO5xu6RnXPzcTa0hL/NrCX+vDtQm481H7Qjkl4Bz9mnTKgQq09D5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0Y02O+/Xnya87dTyueIcSIkkxlV8rJv+346d30hXPU=;
 b=nRnQOllPtsW6BRPfLC0eXvrd3+v5uFqZn3t3j5b7W+tVZLl9wAy1kKWzv/Uw/GiTBroUJ0q3bUEXYxFfIzyyx4WfLEDZ0McaboSbdsugHVcBBOhYb7fI2RvTXDL9BcZMX3JARzfHYaj+bdfDWQ73LLzx8gmdNu0+T3NqlAuk/d+Wfh06xA8hPn14Q0Pa85kyt2tNIo8tOOZmgpu4gTJdFIV4sbcAOdtaGPVXfJAHXeR+sdVqCohXQVdyz+vetuY9DFs9u5ConbJrigKI061kOH2/qy9qa7kzHWgMm1XewcVHobG1rFCxHUrojM/YNFQaVWTKfmHYdKuM5dUVUMqQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0Y02O+/Xnya87dTyueIcSIkkxlV8rJv+346d30hXPU=;
 b=scBLrfC6BDzT24nTAYDFxLycMMJYqutkWXlmP+FL06wGvZhcGTlEOJKTqNUnwTNqUY8tfUQv9A3MpnBXrCUG5c7gxXC3jOMRDI0tAI7VywTCnnLJgyZGgTQQw8J2+DfmzN5RwoysqKj+nVTjLbVYK3WKhE5tNEEqBObS3hLZrPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 15:46:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 15:46:31 +0000
Message-ID: <8996e1e0-83cd-4eef-8820-2d99d7507926@amd.com>
Date: Wed, 29 Nov 2023 09:46:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Restrict extended wait to PSP v13.0.6
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231129123655.1161175-1-lijo.lazar@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231129123655.1161175-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS0PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:8:191::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 573b8414-5867-4dfc-14a5-08dbf0f25a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyWt+sTKq4n1FcHgiC3YI3fCeq72UwoYX6N17KtfkZOQFbwLiKt+LYaN90kn2WGtzWIjUuc8EaoJuUvnCsn7ae5c+QuHXQs4aOdKZgERerT9NkrEUxQATfmf+1S4Eaz1f4Cld9U+0e1xe4FSCTdDBM2vJfwd0vsBZFGw9obUHnDJbOFCk7DI4bkyfUfoCT1VxaChpLnt2LTILrsWH7R2i2ScGL/19/qiDTHVQpc5YniJt8lRTbDs4pt9MURKTvNSYueOd5NRXFV0/HcEFxHuNfAtkJbrW9z8U45ZJM9Cr4yWBdToRcHS3rk2Vi89wWkhomfl9UMFIoyBUpQLaqHR6+ZPoLgR9rFEw9ab+zGAU+UI+bzaIfGVL9g85k/f5F8SeellJDY0yq+4Yb4fuy3H+9gm4RdB8ZCAunDVcJkF7s4ZaASB8dOVLoOeYJkM6dZ8IyU1O4edvdh1kbvqZbS6fTX7ZhDFKdal6KGKXzHEHfBg/afeCjDYonRLcN5oCDDKQta6dPnxWtxipUQEPaROAdaam6Qf7Zp0tz6RejurbZS3ntqs7iLA4Qh7cvxqUEAUOZKF68IQKugmH7fJh5zInud24mXDhRC0zLgCJoJZtj8sZL4bAPTQTe/P0m9Szs7newhrQ9e3+pHkhLlAUSl1uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(366004)(346002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6506007)(31696002)(6666004)(86362001)(31686004)(41300700001)(966005)(6486002)(36756003)(53546011)(478600001)(6512007)(2616005)(5660300002)(26005)(66556008)(66476007)(316002)(66946007)(2906002)(83380400001)(38100700002)(4326008)(8936002)(44832011)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXRSa3l2Nzh5Y0k2QloyT1JudXN0aktNYmFSY1EzdXRkVmJtTGNVNXBwdjBW?=
 =?utf-8?B?aHlISlpiYTc2VHlTaFNvYnQ5ZWhZNiszTW9BeGpXWUc1eHY0aWZNelFYajNR?=
 =?utf-8?B?bndKYkwwSGkxMXNUa0tUT2ZldDRlQnh1bEJPM3lJdmNpZ2orV09FREFCMkZ1?=
 =?utf-8?B?NEFPSDZYNG1FdzZvWC9tcXA2UEFzSUZBWkFUQUhiZWplL1pjVEZGQ0d6K2Na?=
 =?utf-8?B?Nmsram9RTmpKQ2hCaFZRNStlTUJxVzFydGdzU0dBNFlqSjlxNWIzYjV4ZGZI?=
 =?utf-8?B?bHhTamNZYnhTb2FTd1ZTRWlkYWsxQnBZbjFtSmZkd2JyV1pSQzRhMHI4WnMv?=
 =?utf-8?B?SGVPdzhwRngzVXNVb09xakdBMjMvRXlCZG5QVmp3dXQ2akVyOHZUUHI0cUJJ?=
 =?utf-8?B?VHpEZWRMNnlMU254dXdPM09yVGNOcmEweEUxZWYxd2RRbHBjeDk2RFcrcXNm?=
 =?utf-8?B?blhBSFVva05pZFo1ZWRGUExXNld5WTlHcVNVaHYvQStXazFQZGUwNklNSjJo?=
 =?utf-8?B?bTgxcTVBUEZGQzRxb2U2Q1k2RWFySVNFVmdFVzhhZ0QwS3NOemIrNyt3WjF1?=
 =?utf-8?B?Z3NvZy8wQ3h1bWJYcmU4UytjcnlJYzlJR0hpb2FRRFlBK0UwNFNhMFA1S3pn?=
 =?utf-8?B?R3lzWmFobEZjZ2hFMnFNTVBJTUhSVmFSNFpkSlpRSkR2VXVGUFRtcmRSY2xi?=
 =?utf-8?B?eG9qSG1ITFJFcGgvQm9Jby9TcUkwNmErZ0ZsWWt0VzJzQVFpeWRaMm5iaEV4?=
 =?utf-8?B?LytlMnN1QjNBMEtDaWRaZ1ZHYk9aRkRsT3hiQnMrK0Z2c1A4NUJQcUhPcVVJ?=
 =?utf-8?B?QlhtVkQ5dEtyWTN1V3A4djMzaVhzMkxCSkVzdFd4dlNNc04rT0J6bDhzZ2hE?=
 =?utf-8?B?UU0yWWtERjdoSDdwVkhVZUxCdzV1VFdLajdSOXBhdWYvaTR5dmRaOS9xMEVK?=
 =?utf-8?B?SEx0U1lLdVZiYlIrbUFXYnhQT0VzZmMwd2gvWEJ2ckxtbmduc3p1WkVVWEVz?=
 =?utf-8?B?K0l3MUNSZ0FOUU82ZDFLaEJzUnZzbWpNejdESERiS3FJSkxjcGNhaHI0eW8x?=
 =?utf-8?B?QmdIRG5vRzFXcG10S04wRm85MnJNcHNWTFR3Uk1WMFlyQTNveFZWS2NtNFV5?=
 =?utf-8?B?dmdYUEZQODBnLzQ0dHkweXIwN3lKMW1ibFhIUGtweEd0NEsxUVpyTzRETmxl?=
 =?utf-8?B?bDNoUEpQWktBNCsyTk1taFVoZjJibHY3M1A0Mk03LzIrSXpPbDRPN3hPZ2N3?=
 =?utf-8?B?L29JaHRKbEZJWUFsMUwxUWNCRnczRUFPdkpKa0h1Z3FSdEtORkNaN20xNERT?=
 =?utf-8?B?NDBjSDdnQlNqc3BkYnIyeS9kMmxHVkFQVjhnc01ydG1DbmpwRTNiNytVcjZi?=
 =?utf-8?B?SFhpN1hXL1lJZEdoYVhRYkxUd3Q5dFE5b1pIdkoxRk92djZFWk1neE85WXU1?=
 =?utf-8?B?MjlSRFBvVDRjbHFTV242QVhDR2V2WGprMTY3blA2ZnFJdkp1VWhlMUhHNS9Y?=
 =?utf-8?B?SG9qZmNiWDRQVGhRR3ZwazExc0VtUzlKZU5zSVpCT1RQSENWd0wvbFhRZGRN?=
 =?utf-8?B?bGJoU29LR3o1czdjRy9wV1ZNK2F4WE5saDlUc3NZcEJqRDFBallFenl4bWtz?=
 =?utf-8?B?eWVDY2crQlEyc24xTnhSUklzR3dQVEZ6Y3dVN1Rva1dvOUZmZ0thSjFURnlY?=
 =?utf-8?B?VFdUNVlzSmNmQk1yYy9rQ1h5R3g2SEd4YkNwM0VqVUh4dmFtQllDK0g4eFJQ?=
 =?utf-8?B?VmkybWpPQ3h5M2ZWWkcrNndZUWtYMGxmV0xWK1JveEpxL0RuQXNqb3VielU5?=
 =?utf-8?B?bjh1MlBsQWZxSklpdnVDbitXSUREajU2eWYxSWdUN2lxZG9FSituRFRjL3Fy?=
 =?utf-8?B?ck93SkhySDFldENWMDl1UFdTaC83aDh2MWpjeXhFNnpuYTd1U2ZNTk5UNGVy?=
 =?utf-8?B?bzREZnVhcVl1cWxJbzAwWjNqRmxWRVJGQ0UyMXZuckNhMGJuWGc5NTRZOVdk?=
 =?utf-8?B?Z0VNOGpHNThIWXJjeS9tcVZpSExxNUJvZDF0dHNmL3N4V3BIT29CWC9ZdHlF?=
 =?utf-8?B?VnhXQzlEQ3oyRHVmT0ZGWmpYZGdKcDNCNmFRcFRDNmtoaXVieU50WWt5VHhW?=
 =?utf-8?Q?y7wfNWztVBSbYC1CktwJSylYU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573b8414-5867-4dfc-14a5-08dbf0f25a65
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 15:46:29.3786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbrqK37ud7B06c/V4l0RppjqfQceSzqC8vWkfCzqoJFiX9BKryceLgTxO2X/jB3h5HScFpNKulkRIGoaC7DKxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/29/2023 06:36, Lijo Lazar wrote:
> Only PSPv13.0.6 SOCs take a longer time to reach steady state. Other
> PSPv13 based SOCs don't need extended wait. Also, reduce PSPv13.0.6 wait
> time.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks!
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

When you commit can you please add the following extra tags:
  * Fixes: f2328c2ba0e84 ("drm/amdgpu: update retry times for psp vmbx 
wait")
  * Fixes: a11156ff6f41 ("drm/amdgpu: update retry times for psp BL wait")
  * Cc: stable@vger.kernel.org
  * Link: 
https://lore.kernel.org/amd-gfx/34dd4c66-f7bf-44aa-af8f-c82889dd652c@amd.com/

> ---
>   drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index 32048b805200..d335d1d2e93e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -60,7 +60,7 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_0_ta.bin");
>   #define GFX_CMD_USB_PD_USE_LFB 0x480
>   
>   /* Retry times for vmbx ready wait */
> -#define PSP_VMBX_POLLING_LIMIT 20000
> +#define PSP_VMBX_POLLING_LIMIT 3000
>   
>   /* VBIOS gfl defines */
>   #define MBOX_READY_MASK 0x80000000
> @@ -161,14 +161,18 @@ static int psp_v13_0_wait_for_vmbx_ready(struct psp_context *psp)
>   static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
>   {
>   	struct amdgpu_device *adev = psp->adev;
> -	int retry_loop, ret;
> +	int retry_loop, retry_cnt, ret;
>   
> +	retry_cnt =
> +		(amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) ?
> +			PSP_VMBX_POLLING_LIMIT :
> +			10;
>   	/* Wait for bootloader to signify that it is ready having bit 31 of
>   	 * C2PMSG_35 set to 1. All other bits are expected to be cleared.
>   	 * If there is an error in processing command, bits[7:0] will be set.
>   	 * This is applicable for PSP v13.0.6 and newer.
>   	 */
> -	for (retry_loop = 0; retry_loop < PSP_VMBX_POLLING_LIMIT; retry_loop++) {
> +	for (retry_loop = 0; retry_loop < retry_cnt; retry_loop++) {
>   		ret = psp_wait_for(
>   			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
>   			0x80000000, 0xffffffff, false);

