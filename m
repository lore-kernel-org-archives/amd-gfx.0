Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77CFC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 13:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7859310FF03;
	Wed,  8 Jun 2022 13:20:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0977110FF03
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 13:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZk99+pczAb0xeLP+HpCiYfsGN0MuNZQC0nEfDdR5U4LSTg+XhhgFRCV2WByMxF2TWSnTzGU+emOasI15u8mQjOXyCAcXPeRHn20lEYfwrD5nownndjwAHCQJicgTfHNdD4wmrf9BB3HQMTt+OlDndsBfLkUDjLJv2TZtcFKCEgFuptVWEWEpHKyRAlUXC0uJ62ySWa5SOl8eXN1qrR0sNjzFZdE9SUX132PDUCW0zW7TP3qjq4TmShZgT8cwJ9+tLfQEB+VJX5gBFGWit2VcQRLw0ANpb0PRsIU8/yRtDeGF+UeqcWfERa+lFcoOlGTCcH/gEJ9hS3dtrtpWKFTEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjtPvZZ7x692E6CBVlqH6xqbzAQQok0LtX9wwLDONk0=;
 b=k67dpY6xIuv+SfK7P1GyCK0FL9sMEUFxxDfVmnRXZS3cqC8Zn+IXv8L5hfowXMCJs9NCcW+1wj22vGKUvk4tRO0EIYSnveR6ZuuXjZN8cEXw0GdaicfbBYSG80cYaoo6RKPCsup/57faSPy/XDbHp1Um2Xh4+zHM29CcB5v0OKW2BpkRv0qeIDyW9/KRGcFeF9sudCJg5IOx0u7VH1/1BPnbdm81WlbDGY2/lChI2Z1QQDBMQtY0UarwNEXJYoWbHUc/Vz16JmpruooGmiw7OoVWD5f7OsRSwFmRT65g5GykNDd5yCKQb51bmsL3fjPwczeD15OJaJZZmOy5rjw9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjtPvZZ7x692E6CBVlqH6xqbzAQQok0LtX9wwLDONk0=;
 b=0j91YSz3G+E7IQnPGdkkK9BwuE6AxpH9LhzLRx8KhUtkiKP+enaXu1xhQIub0XsXb4q8KKd1kQ8ZaOehbVFeSvwssXa2sWxuV7AGevFJM2QUzv0Ruwyr0eD0UA0BKkltr9jSuY2wSzlMPAZ23laQn+Q6+hK7bGTHSy2y73ix3IE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1750.namprd12.prod.outlook.com (2603:10b6:903:11c::21)
 by DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 13:20:37 +0000
Received: from CY4PR12MB1750.namprd12.prod.outlook.com
 ([fe80::fdf5:772c:7e9c:8b6f]) by CY4PR12MB1750.namprd12.prod.outlook.com
 ([fe80::fdf5:772c:7e9c:8b6f%11]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 13:20:37 +0000
Content-Type: multipart/alternative;
 boundary="------------G0CEokFNRl6JaKnKXKQ90CKu"
Message-ID: <1df0ba44-d872-59a5-9539-47c5ee5fbc82@amd.com>
Date: Wed, 8 Jun 2022 09:20:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] drm/amdgpu/jpeg2: Add jpeg vmid update under IB submit
Content-Language: en-CA
To: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>, lijo.lazar@amd.com,
 James.Zhu@amd.com, Alexander.Deucher@amd.com
References: <20220608053618.3484143-1-Mohammadzafar.ziya@amd.com>
From: James Zhu <jamesz@amd.com>
In-Reply-To: <20220608053618.3484143-1-Mohammadzafar.ziya@amd.com>
X-ClientProxiedBy: CH0PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:610:76::9) To CY4PR12MB1750.namprd12.prod.outlook.com
 (2603:10b6:903:11c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c87ba0ea-d031-4921-dd96-08da4951ad09
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB25044338BC93B6E5B6242692E4A49@DM5PR12MB2504.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYFVP0m23D11Qjw8tGQ8VYmqnOw44SsC2t5vegnBEsLd1fc9nRLW0KL+Tdb8HAFXWcHggm9+KrJdOWpPjoXuTEjuYHg7ZrvuefH1Lwrvhj2nLIQGeS2DB6/Ziq0bN0/WLYDjAb3qArH6S7ZiMhfghwqwOi2zCxPCdpgT7cPZqyI2ZKJbKg9CMsX8I+2FKR1nI0tJ/KAg53uHS4ccvU0N8Pa09YKojRIOVFfJi37EZEhvH71ZF405tlRHblmBwv77scoeAjOQ/kea/SXhBPRVAnzoyQDHmUHrkgwaZ+i7q7HDo0qHlX+7IGzLIaAG6y7h26Ttx9UbHK66fFV7piw8PZjd7klBtlEtsLWfW2L20G4/qFqtOiu3AkUPnAPg7VdWmJeKYX/6Ju7/A4JFYWuYKn+IQtnvP9DrUm2vsr+AnYwvlFQIaTCK+wmJkvgjWazyauErORbO1+HWRU6plOPW45FmnWGte6Zmp/HTjy1Q9cB4lcpgUJqixN4OQTVnuWuYGVSefPs6GejVMyk2/7CCLC086ju++ZFYDOGpZ3Cre4VQ/Vs1+3/0/MDO67n2mDNuGKxnIPX7zoV/TqrLFJYFRaY31rCzt2KJm60h5j5jK8JvILS3GQ4msZisS72ZcBWjTyFiRjoqQZ8ssqa1LrOQJKLjXap61muS4t0LGrJ0qFuAMpLFvpdGFaKabgYOzwPgaQAQVcoJG1TCCYO/I6BcMs7itKAiA0Txl2ejc343mjc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1750.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(508600001)(4326008)(31686004)(6636002)(8936002)(5660300002)(26005)(6512007)(38100700002)(53546011)(2616005)(6506007)(6486002)(33964004)(15650500001)(83380400001)(186003)(316002)(2906002)(66556008)(66946007)(8676002)(66476007)(31696002)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWtpSkkvazRZcUtqVHc0eFMySmUwLzBmcDE0RzdpbEwyMWlvekZMM2xoNjNK?=
 =?utf-8?B?RGJjdjljK0Q4WFQwa3RyamVEeXFDQXg1ZXdTVDBuOFRvcW44T1I2QXBkSW4v?=
 =?utf-8?B?UEVrc1NobjFhRm5sQ3FDbmpIZnNwMFVaUE1vZW9TN25CSm85VHNzdmNQL3B0?=
 =?utf-8?B?aFIrYnZ2cTZhcGx6bHNUajV2dVNCb0JZeXVORzdlSTltVWYwVG1BdW10R3ky?=
 =?utf-8?B?VkYydFVZTGg4dGYxZ1Z1dDFiT1QzamFqd1l5dkVlek9uL0tUL1M4ZVdneXBx?=
 =?utf-8?B?VHJxODdoZTVuSkgxQzd6Y1UxT2VRR0xUMkcrOE1hVTdZREREQi83V3hIcytp?=
 =?utf-8?B?M3dHUkpoTjVFM0g5MTVjVVJ3Umk3N0hkVkxLZnVXWk1pcHFIUTIxeFRFWHdn?=
 =?utf-8?B?TkNCZUxYNmV3ZmlPUHlCQTh0T0N0dCt3WFdiSU5BK3hHVlIwWk9NeFIrN2Jj?=
 =?utf-8?B?WHB2RVZnUm4xcm94ZitnbjVDWW0xRkZaZHZOYzUvVWdLSyt1S29oZ3hLamI1?=
 =?utf-8?B?dnRCYlg3Z1pwajhsZUJrZjUzQVlMUjQ5SHJwN1BYNWQ5YWN5bFpkZzY1alZ3?=
 =?utf-8?B?ZkxxdDIwNDlSSG1LWTVVUGZYQ1I2bnJpbFdOc2M0QUNUamZ1YTZEeHZQWkJh?=
 =?utf-8?B?NHROZGFIQWZPTlpSMElMN3EvcXByU2lqT2JNaGRDMjRkdmdsMjdtb1Z6a3BM?=
 =?utf-8?B?Zm95ODN2L3pUaWR1QTVVN2VTRDV6b0hjdnB2NjRNWlBRTEw3MFd2S3dwTDFt?=
 =?utf-8?B?QzJIbkc5Z0JWN3RreG1hYjB2dnU5QmtOeW1UbGpockJlaDEvUS9EeFo3Qysz?=
 =?utf-8?B?QmE3dFNOemY3elhFQ0YyWFQ4d00wZGd1eXN2VHl0WUY3d2FoenAzaUhnWWFo?=
 =?utf-8?B?azFwUnd3a1FWaGtMVFpWZEYvUFJHMi9tQm9XS1R3UXUwWnFlUEFIelVHRFBI?=
 =?utf-8?B?SmhRVHNwT25raTNheTJ3UEx2b25GR2daSCtCQnRpMWkwWlBYdFNINFdvVVZk?=
 =?utf-8?B?aFlZejdwWEt5c2U0ZVI3dzdJQnpsOTRSZnFFQWFVNEVNWkxWMVFmV1Z4bUJR?=
 =?utf-8?B?NjJkM25rWDNteXpRK2k0SkJwdE9iTDBTejlqMzNQZ09xcTgvZkpXT2hGdzFz?=
 =?utf-8?B?UFpFbVE5dXVUZ1YyYjdzVTEwNk9CZ0swb29jMjFzbHpaOXV5UnZENGFCOFV2?=
 =?utf-8?B?MFRuOFl1ME1mV0tTUnVsOFZCa2dEaUVlODJBcjk2WWZraFNjZmZtOWZNeVlu?=
 =?utf-8?B?VW1NSUtJUmRSTFkwdTFMOU40Wk5DMU53dmpPWTkvdlRhK1FxbkI0bU9sT0Rj?=
 =?utf-8?B?NW1Hb1VKQ0ZSQlFleTBHbG4zcjQ1UUovQzJzaUloZVlGL0NwczU0YzhqSmRr?=
 =?utf-8?B?VGliZDh4T2UzaENmamV0MnpsZnhHTWRtd05qcWRVdHRnS1NtZXcvTzcwRGQx?=
 =?utf-8?B?UHljNlh5MnNLV3AwMG9XOWlzeW8xSHJsYkFYWHFuRmp0bkQrN2xmSUpYZ0J1?=
 =?utf-8?B?TWhmczFBL0Q2MEo2RDREUmZYVktMSXNYMnJqZzBFTGsycW9IYmh6WEdTME9o?=
 =?utf-8?B?c1dsdXVlK0ZtMjNuMDFJeUtSWnNXcy9mYmoyZEo4Y3BFc0lSWWNtQnlUVUJa?=
 =?utf-8?B?ME9NaU9HTjF4R0g2cnNjdWs5Yktta0g5Z1p0T1gxaUkvMVVzdjhvNG5pZ0xK?=
 =?utf-8?B?c0JBYnRvK0pRbUEvMzlTR0Y0b3BDRDh4WmFYREhicDA2Ti9PK1VFbmVkbXRa?=
 =?utf-8?B?elUyYTRVd29jNHZtQ09WY2ViS1NvSmQxVWM5Z2NlZWowaGFZQzNtTWxHcEhl?=
 =?utf-8?B?blU4SjF1QmkyRGZTQVpGSDlrY0ErQ041MzVNamZNdEo1UVVRNjVWbk9UQlJ1?=
 =?utf-8?B?SzFEZmowUjNMckZ5ZU5pSnlTcTdGaFlNMVBIbHVlZFZnL3ZYT3l4c0JBWWdG?=
 =?utf-8?B?cE8yUFdHd1lLbGsraStwNmRaa1RmLzhyRmdDR0J5b0Z2RVBNa0hYclIrdUY4?=
 =?utf-8?B?TlRHWjhxOCtHNkdlRmNGZjZ5T1A1eVNBMldSclhXeW5US1RldWVyS29qT1ho?=
 =?utf-8?B?SDhNNDZ5UCtBRUxXTi9vVjhNUS9Mb2tidklTblgzSGhPcUtYVVYvZFhEbWla?=
 =?utf-8?B?TWl4Nkw1cVZGUGFzVTVJRGxhYmdPWkI4OG9JQnQ3cFpYRkhIUEhBdXdHcHRR?=
 =?utf-8?B?dW5hQjUrbmZ1dGlqVlUxeHdIelhLTzVhT2pLRFFnWEljaUhSZE9oMlhoVWJB?=
 =?utf-8?B?WDZGNzJ6VlNjdGFNN3pnQzRuN3Y5dFl2TWNkTElzMzZLQ0FXNjEwd2d1d3Aw?=
 =?utf-8?B?SjRYYW1QeFVqaTNFK0UvM3VNQnI1bmZnOER0Rzh5WkxxMkpEUll3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87ba0ea-d031-4921-dd96-08da4951ad09
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 13:20:37.2661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wKjY0XMJ9+vDZrrFoI2leLQJc7UUbtxzvV9FInomm8MJOYnonZtUA/f6bE5s2m7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
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
Cc: Christian.Koenig@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------G0CEokFNRl6JaKnKXKQ90CKu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by:JamesZhu<James.Zhu@amd.com>forthis patch James

On 2022-06-08 1:36 a.m., Mohammad Zafar Ziya wrote:
> Add jpeg vmid update under IB submit
>
> Signed-off-by: Mohammad Zafar Ziya<Mohammadzafar.ziya@amd.com>
> Acked-by: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 6 +++++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h | 1 +
>   2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index d2722adabd1b..f3c1af5130ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -535,6 +535,10 @@ void jpeg_v2_0_dec_ring_emit_ib(struct amdgpu_ring *ring,
>   {
>   	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>   
> +	amdgpu_ring_write(ring,	PACKETJ(mmUVD_JPEG_IH_CTRL_INTERNAL_OFFSET,
> +		0, 0, PACKETJ_TYPE0));
> +	amdgpu_ring_write(ring, (vmid << JPEG_IH_CTRL__IH_VMID__SHIFT));
> +
>   	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
>   		0, 0, PACKETJ_TYPE0));
>   	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
> @@ -768,7 +772,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
>   		8 + /* jpeg_v2_0_dec_ring_emit_vm_flush */
>   		18 + 18 + /* jpeg_v2_0_dec_ring_emit_fence x2 vm fence */
>   		8 + 16,
> -	.emit_ib_size = 22, /* jpeg_v2_0_dec_ring_emit_ib */
> +	.emit_ib_size = 24, /* jpeg_v2_0_dec_ring_emit_ib */
>   	.emit_ib = jpeg_v2_0_dec_ring_emit_ib,
>   	.emit_fence = jpeg_v2_0_dec_ring_emit_fence,
>   	.emit_vm_flush = jpeg_v2_0_dec_ring_emit_vm_flush,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> index 1a03baa59755..654e43e83e2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> @@ -41,6 +41,7 @@
>   #define mmUVD_JRBC_RB_REF_DATA_INTERNAL_OFFSET				0x4084
>   #define mmUVD_JRBC_STATUS_INTERNAL_OFFSET				0x4089
>   #define mmUVD_JPEG_PITCH_INTERNAL_OFFSET				0x401f
> +#define mmUVD_JPEG_IH_CTRL_INTERNAL_OFFSET				0x4149
>   
>   #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
>   
--------------G0CEokFNRl6JaKnKXKQ90CKu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
</p>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">Reviewed-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a><span style=" color:#c0c0c0;"> </span><span style=" color:#ff9d04;">for</span><span style=" color:#c0c0c0;"> this patch

James</span>
<style type="text/css">p, li { white-space: pre-wrap; }</style><pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></pre></pre>
    <p><style type="text/css">p, li { white-space: pre-wrap; }</style></p>
    <div class="moz-cite-prefix">On 2022-06-08 1:36 a.m., Mohammad Zafar
      Ziya wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220608053618.3484143-1-Mohammadzafar.ziya@amd.com">
      <pre class="moz-quote-pre" wrap="">Add jpeg vmid update under IB submit

Signed-off-by: Mohammad Zafar Ziya <a class="moz-txt-link-rfc2396E" href="mailto:Mohammadzafar.ziya@amd.com">&lt;Mohammadzafar.ziya@amd.com&gt;</a>
Acked-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index d2722adabd1b..f3c1af5130ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -535,6 +535,10 @@ void jpeg_v2_0_dec_ring_emit_ib(struct amdgpu_ring *ring,
 {
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 
+	amdgpu_ring_write(ring,	PACKETJ(mmUVD_JPEG_IH_CTRL_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, (vmid &lt;&lt; JPEG_IH_CTRL__IH_VMID__SHIFT));
+
 	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
 	amdgpu_ring_write(ring, (vmid | (vmid &lt;&lt; 4)));
@@ -768,7 +772,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 		8 + /* jpeg_v2_0_dec_ring_emit_vm_flush */
 		18 + 18 + /* jpeg_v2_0_dec_ring_emit_fence x2 vm fence */
 		8 + 16,
-	.emit_ib_size = 22, /* jpeg_v2_0_dec_ring_emit_ib */
+	.emit_ib_size = 24, /* jpeg_v2_0_dec_ring_emit_ib */
 	.emit_ib = jpeg_v2_0_dec_ring_emit_ib,
 	.emit_fence = jpeg_v2_0_dec_ring_emit_fence,
 	.emit_vm_flush = jpeg_v2_0_dec_ring_emit_vm_flush,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
index 1a03baa59755..654e43e83e2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
@@ -41,6 +41,7 @@
 #define mmUVD_JRBC_RB_REF_DATA_INTERNAL_OFFSET				0x4084
 #define mmUVD_JRBC_STATUS_INTERNAL_OFFSET				0x4089
 #define mmUVD_JPEG_PITCH_INTERNAL_OFFSET				0x401f
+#define mmUVD_JPEG_IH_CTRL_INTERNAL_OFFSET				0x4149
 
 #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
 
</pre>
    </blockquote>
  </body>
</html>

--------------G0CEokFNRl6JaKnKXKQ90CKu--
