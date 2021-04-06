Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCD9C433ED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 14:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A996120E
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 14:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A996120E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D9B96E0F5;
	Tue,  6 Apr 2021 14:03:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49CAC6E0F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 14:03:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiRcPf3pXznYDqCGsrv2Uu+CHF7InFbVUjJikZ5koRsqtIKnGypsUL5qCJWNwQvvmDRjypmgPV94e8xB2V8zaLAiHLu8o3y11kyu/ZIKammEZloKW6QodlPt0U3F/g//lC2M4i2g1IO3E36VFD9g5hITzmi5Ml8KI83msrz8cacmPT4xZUrZAfl2UmUbBGi6fnPaMH1TJijLUGwIPCFh1b3Mr+C2BNeswXBIIxOYkg79wamgKYwDQzm5lysVkfzNDT93ewWdqnIsKEIG8sVesgyz7t6DUYqJE+s+6p+wCvKk+LaVuShWx+d/goRjVaS8mdZ+bqjJ5AmVGvZRukXrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgCIJH0cECoqoFSV3pAwfMpi9/CPL2UQKo38tkOuNZw=;
 b=hFisDY8XCXN7uuL3TY3H5y44+dLAKpg5QFOv88vt5EL325b4uEo7v7LF8y3UByj2hqmkmy1+uZ5hVgBC8tasGrPluescWk0odV19ep0jGPz/NGysx/pFFPZbQID4j5FXn/1QuhXdaXPD1jByPfj94Zw+s9YPav6xKQs8oU6rJ9otKprWtTIxiJ5uWMK2sYm+vVqu006+VpTtAbi4cBfNiU57MVWZekAeGbHJv1HrLZwaJxFEhmLDVvY4U6orWAvcJtgF9hNDBX6jKqFyXiHRfZw3eSmYH+bH3sF8p41cH1UbcHAYB8xgO+eV5WYpk/CqppAFR8rkMQaPs5kUuJsgQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgCIJH0cECoqoFSV3pAwfMpi9/CPL2UQKo38tkOuNZw=;
 b=k2X2DYb56YITWRfkM6JBMidO8GjJLB39Hr3elL4IaT0jEIy/GTuiMg70PBsovsQToENJAiZpaxF3D6oCwPBNQd+vpAN/RYkMERKcXdvm5DvcNQsgjWwXLy0duSyncr2AXJI7vf3ZVU9C1Gj8HsRom5RA3IGnRgl4BaKO5u02/Xk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM8PR12MB5493.namprd12.prod.outlook.com (2603:10b6:8:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 14:03:42 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98d7:4d47:2cae:38dd]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98d7:4d47:2cae:38dd%5]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 14:03:42 +0000
Subject: Re: [PATCH] drm/amdgpu: add DMUB outbox event IRQ source
 define/complete/debug flag
To: Jude Shih <shenshih@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210406134001.46915-1-shenshih@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <bb10f195-2205-a3a0-498f-94668ddb4bb2@amd.com>
Date: Tue, 6 Apr 2021 10:03:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210406134001.46915-1-shenshih@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YTOPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::18) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTOPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32 via Frontend
 Transport; Tue, 6 Apr 2021 14:03:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e60ea3d7-ff7f-48ac-7e06-08d8f904c925
X-MS-TrafficTypeDiagnostic: DM8PR12MB5493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5493E3A8F62A34774621E96AEC769@DM8PR12MB5493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFRHL83X1Fuw/vILKheBtOd49UGF3RDlMZW2aFSbBIE1dda3TY3HoY1K9i4GGS2fUFXHOUxXpcETFscBsAYb7ZROMVa0ogoXQf9Jv48XdyI+yPF77yz57ytSxrYAMdjMxY6HbacJqdn2isRZpT5lEcHtqDkCuzpdWOiqV7HRXhHS3KzG5PR7vToeCVzDfoQMViPJYDFd9pNujNQ3ZLyL3f0ftkujbAhlmA5RwGFYlOYcNmWULxVnXIrud4LRlcQkx8Ut6np62mh5knVnZYME7gzEZgXctuQYjKNNAlSeg3MFmL+cJAb1JTidaVoQ0qg71ODz2tVWX31NIjFONzrV1LwmMWvKmgigRcasUv56SPtCLh3XoiRo7XpW9aVLC5rpiOiATdY96Wf6pA9EEqHx5ja8xQPrL0AAUvHEb8BN+4DqVmz4Fikd1Wp0LJm+7jhw3WxJJCL4RuiEeq7JXL7EKvKA+dsSvJBZK+iYnM0abPVKYKyRqh52AQ8xlP55mAICDU/bUK98M7MoLovBw8We9sI5kI960stTdZugW8F5XAsbuh/UTpfpnjzF8EPeNpdsvSn+qhg2osb13VHir2LHy7FrGMoiUGL6IMN+doe/pb0KesZimCoc6V+YpuvzX38oKdommP5yyvSXNCp666gCPeNepCf316uiLwMlEdzny/pUaOxLDjMOzPr3LzoRnQ29dJVMuWk/5zlKBjCuZ1eApvRHFVgBrOyTN+PW5hM66kU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39850400004)(396003)(366004)(4326008)(26005)(6486002)(6666004)(86362001)(66946007)(8936002)(38100700001)(478600001)(16526019)(8676002)(83380400001)(316002)(16576012)(31696002)(2906002)(66556008)(36756003)(5660300002)(31686004)(66476007)(186003)(53546011)(2616005)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U1pLUzJQQ3BWaDExYWJMQ3Y2blNCb3Y3SGtGSXFYQ242b2pyRjFVVmg1cHha?=
 =?utf-8?B?VmIrOE5rYlRSNHRDRm03b1NhMGxCU2xnTmQ2REdjU1ZXWG5SQkxHRENzcXF2?=
 =?utf-8?B?QUFZS21acFJyczVjRmx1eDVzeGlQMVFsOTdPM3lTcVRPSll6d05tUThKS2E2?=
 =?utf-8?B?WVNCVU1TTE9KV2NuRFo1WW5VeGJpY24zbWx6VWpJWFlMUXpHWVV5MUlvL1gy?=
 =?utf-8?B?TTFPK1BvdDNGRDhQQ3RrNWdUNzl1bzJzMmFna3hHZ1d2Q3NTZ1RSTVFPZFdL?=
 =?utf-8?B?N2VGd0VSS2JXcmFEbUUxdXV4NjVTUkNSeDd0M09sdVRBTi9UTC92a0hBK0Uw?=
 =?utf-8?B?QnYyUHE3cWJEOFhhL3U3akRsMEJYVUY5RmVxZEZ3M0lCbVZRNndEaWNJRkxJ?=
 =?utf-8?B?bUwwZC81ZnJoVitQYVBDRURLVmc3Q2xzL3BXUEF2U2J4Q0pCVG8wNmNoSWV4?=
 =?utf-8?B?eFFLaHlVUDMxN01WcHZkTU1hUzRCbzhoS2xneU5INTVScmJJeGhKZ2crai9h?=
 =?utf-8?B?MnRBaUNPdXFvQzJQRyt2VmRSUzgrbWVybHdQT002LzRQL2xEM1JtNGVkNE94?=
 =?utf-8?B?UDRWZEtWeDVFaHY0cGYzMXpkempONG14QlAxOTBWYzB4NkR3WnBBMitYd3Vl?=
 =?utf-8?B?NDlnTkI5QlFYRkE5YS9BZzJhR0NrNGh2YjN1K1E0cWFLZFVNbzFWVTl6enVm?=
 =?utf-8?B?ZnlsRzdRcjVHYkxnWFVTcnA5K2xvbVZRTG4xOHYyWDhXZEZPMTV5YlJGUkps?=
 =?utf-8?B?KzV1RkxLWGRBQjYyQTd0T3AyMVc0UDh4WGhqdkdVTGtVcmo1UHU4T1R6L2dC?=
 =?utf-8?B?ZXFHNDIwVTBJN3pZZ3llKzloVFFmSGVnTFRhWlpwUS9rL1dEZ3h1TXdNbzNV?=
 =?utf-8?B?TXoyRGUyemtlRHJtOTdXcGJneVpGVkdPTy9qVW83c3dvR1Jsd0gveEhJdE51?=
 =?utf-8?B?eGtLaXo5OG1nemdaR3hGa1NNblhpa2Z3SXNsbU02bTJGZ2FlVzQ4eVBISGww?=
 =?utf-8?B?MTR4eTFHVk1FRVRhQlNwWEJManJPZmdrU3hvbmU0MldkT0F4cTVGYVQrbEtv?=
 =?utf-8?B?eHpPNTFURXkxdy9xTE0xU1FMOWNJekNid1g5Z0lseFdabWRnSmhDNDJzTktM?=
 =?utf-8?B?NTNKd1A2azIyY3VCTDZseFZFbk41SVRONTJrR2Jvbm5MWkNHaCt2MU1ZMzZU?=
 =?utf-8?B?azg2Nm5EZjExK0xxaGRoR214VmxuM2NRYUxGZ2dwMm9aaC9rSEZ2Wkd0STR3?=
 =?utf-8?B?cTBKNThyVTFiT3NQc0NiQWxvNGMyRXd0a25GL25KQXN1MkZMbFM2R0R2VzYv?=
 =?utf-8?B?SEdFS1J0YkJRd2FQNVlLeDJ1VzRVNnc1cWtoOUcwMWp3d0poNHRPRFBPM0lE?=
 =?utf-8?B?a1lGMEJUcjdLZFdURXpXQ2hNWGlkaEN5eGN6M28xcWtzK0JiaEFzbnZIRGZO?=
 =?utf-8?B?TGN5T1pkWTJ4b3M4UTZTMHZZTnhBNjVpbEhhSGhmajJERWduYUVCOUozUHY2?=
 =?utf-8?B?SjJNZWtNcytVRU0ya1pJVUxyejIreFFVZG16VkZqSU5GM0FOL0t4RHM2WXdQ?=
 =?utf-8?B?YTQveHF6MFJ0bURuVEtjUFd3Y2dzWThQS0xTamI2OTQ4T0ZvWS9uTjJyV1I5?=
 =?utf-8?B?MGJrZEpCYkhpV2hsZTFBNzhDUjFWZ0JFbjBQZlNJak1mTGRFSkV2QVhzajJa?=
 =?utf-8?B?VU8vRDh6bWhHUVJFRXpIN0FoVmhseHNOeHdFajZMQS9mVWw2cE9KT1BhRkdP?=
 =?utf-8?Q?xaTkTt3JfnQELpBGLwjRixbtTuNhtNKa6A/PSs8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60ea3d7-ff7f-48ac-7e06-08d8f904c925
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 14:03:42.4052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrGRThiQ9/8hDCh+2MjJ2lgYACICVIz/5BSsZKDIcdiCqoaOEGMu2BNOav2wRiQ8KLEuvDIj/2d/hu5Gixu/BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
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
Cc: alexander.deucher@amd.com, cruise.hung@amd.com, wayne.lin@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-04-06 9:40 a.m., Jude Shih wrote:
> [Why & How]
> We use outbox interrupt that allows us to do the AUX via DMUB
> Therefore, we need to add some irq source related definition
> in the header files;
> Also, I added debug flag that allows us to turn it on/off
> for testing purpose.
> 
> Signed-off-by: Jude Shih <shenshih@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h                       | 2 ++
>   drivers/gpu/drm/amd/include/amd_shared.h                  | 3 ++-
>   drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h | 2 ++
>   3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 963ecfd84347..7e64fc5e0dcd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -923,6 +923,7 @@ struct amdgpu_device {
>   	struct amdgpu_irq_src		pageflip_irq;
>   	struct amdgpu_irq_src		hpd_irq;
>   	struct amdgpu_irq_src		dmub_trace_irq;
> +	struct amdgpu_irq_src		dmub_outbox_irq;
>   
>   	/* rings */
>   	u64				fence_context;
> @@ -1077,6 +1078,7 @@ struct amdgpu_device {
>   
>   	bool                            in_pci_err_recovery;
>   	struct pci_saved_state          *pci_state;
> +	struct completion dmub_aux_transfer_done;

Does this completion need to be on the amdgpu device itself?

I would prefer if we keep this as needed within DM itself if possible.

>   };
>   
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 43ed6291b2b8..097672cc78a1 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -227,7 +227,8 @@ enum DC_DEBUG_MASK {
>   	DC_DISABLE_PIPE_SPLIT = 0x1,
>   	DC_DISABLE_STUTTER = 0x2,
>   	DC_DISABLE_DSC = 0x4,
> -	DC_DISABLE_CLOCK_GATING = 0x8
> +	DC_DISABLE_CLOCK_GATING = 0x8,
> +	DC_ENABLE_DMUB_AUX = 0x10,

My problem with still leaving this as DC_ENABLE_DMUB_AUX is we shouldn't 
require the user to have to flip this on by default later. I think I'd 
prefer this still as a DISABLE option if we want to leave it for users 
to debug any potential issues.

If there's no value in having end users debug issues by setting this bit 
then we should keep it as a dc->debug default in DCN resource.

Regards,
Nicholas Kazlauskas

>   };
>   
>   enum amd_dpm_forced_level;
> diff --git a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
> index e2bffcae273a..754170a86ea4 100644
> --- a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
> +++ b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
> @@ -1132,5 +1132,7 @@
>   
>   #define DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       0x68
>   #define DCN_1_0__CTXID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       6
> +#define DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT        0x68 // DMCUB_IHC_outbox1_ready_int IHC_DMCUB_outbox1_ready_int_ack DMCUB_OUTBOX_LOW_PRIORITY_READY_INTERRUPT DISP_INTERRUPT_STATUS_CONTINUE24 Level/Pulse
> +#define DCN_1_0__CTXID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT        8
>   
>   #endif // __IRQSRCS_DCN_1_0_H__
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
