Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56723C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 13:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CFF061C71
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 13:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFF061C71
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B98EB6E461;
	Mon, 28 Jun 2021 13:55:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1B876E461
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 13:54:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j++YGqIVge9WlC0kzux68SOxfk8q6cttXCwSUeTGVpjwXiLqw9vAag4kZGw1FuOE3tGtD36uqQP49pyHa2HngbI3hwjv9b5ObGS/gVcT/b3meg6D+vNev/6A9zvtu6DVBFJRJIrV1OJWOEk4ou67gs6z1L21bPJBQPH1Bf7br7XynTZ+SRYeJCEryIHcQoQNFgmwLym9cKKN2PAVqpVYYwlvD5AYz64V9kk5umEpBHTLSCdd0ykeK4bKhPu0J7f6SWLTNZD0GD7oBRIz4CZNBohi47TPb/M/aL+6ekUEqNycGiUi8ks56pzeXNsIqrRapcHixYYYlXoP84i/dqwmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swqU7b256cAwUxR11ILG4xKBVKzF/FezwIbcuetLux4=;
 b=aL+AmWnVP032e0UvH/Q2o9a8kwravLJNC26FXCbInZvaPRz8SYoHYuPIu5RYQcttTGn3WVu2NG50Uo5czVacKndZreNcb4D99q5p1QPZPuotpSTLlJPnlHuExiPenQXnc+Jeyb44yosAaTOxf7y2IIldUOgMJC+aViza3pDX1UcdTDPwPaoyokDp7FdEBHy47GutTINdYdRnOuRNqBjFgl+i3n1IX/vFfAi4Z7kZKZs7hRdHdccZV4z6MIICzKF5kJHEsFhkFoKDIU57ltacuJ5ySNvcgzCLN1hh+AlciAa7G4e/P2EwkNA0pSxgHLNxG66LUxad2tF0e0Tro7Q9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swqU7b256cAwUxR11ILG4xKBVKzF/FezwIbcuetLux4=;
 b=O/sJF6800+N8cn2/7hQ+z84hwO+B6eOD/QwmPy9uttcRxNZF+ApTdJAsYcnOz8sL9ZH48o5k1zTQZ1jekViIVNTrbTnmF+zi417veC4I6kQkRMIHxAqqMbnV9NCM1Ja8My6CxiPKrCtYM87JjXFquuvsq1opGxkgnNnknnNjobg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 13:54:56 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::401d:c7a2:6495:650b]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::401d:c7a2:6495:650b%3]) with mapi id 15.20.4264.019; Mon, 28 Jun 2021
 13:54:56 +0000
Subject: Re: [PATCH 2/2] drm/amd/display: fix null pointer access in gpu reset
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 rodrigo.siqueira@amd.com, aurabindo.pillai@amd.com, tianci.yin@amd.com,
 alexander.deucher@amd.com
References: <20210628092730.4722-1-guchun.chen@amd.com>
 <20210628092730.4722-2-guchun.chen@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <eac643a9-b49b-203b-ab9a-c0672e34b884@amd.com>
Date: Mon, 28 Jun 2021 09:54:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210628092730.4722-2-guchun.chen@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.154]
X-ClientProxiedBy: YQBPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::16) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (198.200.67.154) by
 YQBPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 13:54:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13714cb1-d019-4a3d-266b-08d93a3c4fab
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5444F737207525C9C6AC18148C039@CO6PR12MB5444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uda4oQ9nm5Z+Ywt5Z+m8Ui8AGsq3Uh/POwqE9VqDuevxUFMFFT1tujhnfyHDjegUlRaAt3e/zJNy79WjLYqKiEH9Bm+ejCyO6c0SLLLLY8HJ8oYnXnYYhfOv7fR4MMd5ay+NTdt6kpZcmVS2aWY4Neiy+BBwFkdjcAxG0XP9beofGpugh15+3VtMn9vmhwtCu70PrkeT4BSKS/446DYb1DVVxBQ7CN7DyDyy/Mp8GFlg0lIBOL+pqGgZyYuJgO5HxNn+JULROVOmwjyEBpkD3Wuh0i8sk0gmQVqlRWLrw5zJFW8J7/ZsggVLYVzTCYeiMpfdUbP56s4WOkD4Qe1su7VV8ccVbXxHqwkiCuL64znBkBtoi2X+CRTrCVv5HZq6xJ70huGFsi64ZNIYeMxDWu1v+Fgn89/PKLDlrtQJ0i3iPZmFoxeYTzLeG5erxlc4H1csXcrNNTSzLv6ULTwDILKERQmH3n7kWIAOhvrYlr73+9RHFzAPGX08J/bL4spRJCT8jrMd7YBdtCWT+CXRF4bd2hWBo7jYaE1GBkbwO8M0Pua6qVjqmTZhA0SgkMw+xwhA/Ejl0rLmxIdy6xmjiH5M49u8u/a0qoV3WBJLISYtqjuLXdLjCc+8u81nndH1sfsqog5oFaYx9MdsI4l1hAMi+8H0iRGD6ouROh00sqG3Ajou8znDNctfCCy/qOPZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(8676002)(8936002)(83380400001)(36756003)(478600001)(16526019)(66946007)(38100700002)(6636002)(186003)(2906002)(26005)(44832011)(53546011)(6666004)(5660300002)(31696002)(86362001)(31686004)(16576012)(66556008)(2616005)(956004)(6486002)(316002)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDRLSC9oemY1NVZXV3Y5ZFlWMWtVUldPc0NlK2xEbXl1WW9xS25wNy9XNnBK?=
 =?utf-8?B?L2FDbEVQRVAwUnVuTSt2eWlER3lySXdVT3hBSkxrNm44UmdMMm42VnJ4R3py?=
 =?utf-8?B?eUpoeUoveFE3WHg3OU9wWDUxeGpTblFnZExzYzNRcVoxK1hMcUcvNEtiZUVZ?=
 =?utf-8?B?cCt5a0hpSERKUjEvdmJ4LzJvS2pRbXRqamF0MlhYNmhTYzJyYnBhK1RXd1dV?=
 =?utf-8?B?Um9JaWRTZ0N5bkdRTFg0L2NHWmVVUXJ3R0JSU2VEK2ozbjN6dE9uVGR2Nm5y?=
 =?utf-8?B?Yi9OOG1FZjE5T2FTMUNBMTFONnJOYXVPdTUzZDVqSHVVRFhUbGZ5YStqaEZp?=
 =?utf-8?B?blhUUjJRUS9Rdng5bzhaRmY3WERqSXprV3gxNWVBOTRRZzV1SDFJNnFMT0tH?=
 =?utf-8?B?VXR3QUN1UHNRZHBmWmZwdnFXRzE3dGZSNzVydk12TUdhdnEvVHdQTVBxc3VZ?=
 =?utf-8?B?d29GVjB3Ui9aRE4yS3RGUXU0UllpUUdWODIwOVpPRXdvV29ORkU1N3lpSWNB?=
 =?utf-8?B?M0puS3M4amhqR3RweHo4VEZSSWxYMDZyZ0dqSHFuQVJPdzlxdU5QaVVCNElo?=
 =?utf-8?B?cGQvcnlZaUN2Y3czOFZOei9mZGRPbjMrLzZOQ0tCaENzTExhN0hHc0ozQ3kr?=
 =?utf-8?B?R0t6bzFvS3ZpVm9pa2ZLTEhCajc4V2QxcWk5aUJJdkFydWNEUXRtNGVrWW4r?=
 =?utf-8?B?TmVJdkZrS1FuS1Z3WUR5ZVZQaEtIU2FUYmtaTy9CQVhsVFZQR1A1T2xpeWNx?=
 =?utf-8?B?RlowdTZDSGxrcFBjSnZraGpOVExUQklWRUh5cUUvZm02ZkpweWNZRXJNb3Zu?=
 =?utf-8?B?RXU1RlplTDVqcFNUWFlaUWYxa2NWUEpXbkdQcnNJUnR4TDJOQmtFMEppOVB3?=
 =?utf-8?B?TGZFZDY0bURFSTQrL0ZBcXQ3bjJkQXBOQ2VLSWtJQ0NZOHdubHNiaGZYOGdH?=
 =?utf-8?B?YTM4YWhnc2JOM1REL1QwTDltQUlHd0FIZGpNdUhTemgwWUNYNzFsTlZqWG1q?=
 =?utf-8?B?Y0JGVlFTMDRVUnFmb1k4VDNFS1FSV21pMnFuMytWK2tHbXo1R2hVYjZ3WnR0?=
 =?utf-8?B?TUN4Y3IySlNJZVEreTdxeGhQN2phL3lUcXdtdnlhRXRGdE5YVGZVRGJPZUlp?=
 =?utf-8?B?Rlpsd256cTZ0VmJEZytGcWdCQ3orVXdFcjBCSksrSFBGdFRrNVFNSzBMK1F3?=
 =?utf-8?B?NmdqTkJ1eWlMaDFoMW4rN2Q0SVJ6V1NzTGhRNy9qMDUxNzY5amk4bUF5QkZY?=
 =?utf-8?B?TlAzZEpvbFA0QWN4WURYczVUdEhVcmdTZEVZSkJ5cit2V0ROcjNRWGFQclBM?=
 =?utf-8?B?a09OVExhaWQ1ajI1R1Q3UzFiemlJYlJDb1hZSVJlSTFJUmp3bFRnNWtvQllM?=
 =?utf-8?B?elRJUG5paFFGdVNmU1RKUEVuVEVWWlhLRE11MGk4U0VibWFWTVFTdVZTMnk4?=
 =?utf-8?B?T0RnR01NdXpzako3YVZDL0dFVnFMZlNoRnFZUlR6bmNaQWtDdjJ0ZTZjakky?=
 =?utf-8?B?VE8zTkpnMXh0RGI2bldoQzVqUnZ3SzBrWEJlSkY4L1hnYWt3dXh1U29KRDVz?=
 =?utf-8?B?Q1VTV0hLbEwxSmVLelRvbmtQdzl5elhDYWpKcW5sTS9RRGRXWnBmWTZFNldv?=
 =?utf-8?B?NGNoOGNxQUVBU0U0N0RoVHA2QWFRRFdyTVlkdTY3L3lVb1J2YWZCLy9ZYVVP?=
 =?utf-8?B?NjF5MC9VMS9mMm12bmRiVlJZQlova1AwbnpmckZTZ2FEcFhmSENRbUNqWHM3?=
 =?utf-8?Q?ck4mzFb5VN7ig0ZfXWemOzX24IYJLY4Vc8no0rf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13714cb1-d019-4a3d-266b-08d93a3c4fab
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 13:54:56.1220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2cuJCtfFh1Pmza1S6QQtoTO1cjriBHsKddOqajZb0XqaSJdx3DqJohXA0FYaXQXMIGgPWLkgzhfaYZZI4wBbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5444
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-28 5:27 a.m., Guchun Chen wrote:
> During GPU reset, when receiving a DMCUB OUTBUX0 interrupt,
> DAL code will set it to be OUTBOX interrupt and sets hw interrupt.
> However, OUTBOX interrupt is not registered yet, so a NULL pointer
> access will be executed.
> 
> Call Trace:
>   dal_irq_service_set+0x30/0x90 [amdgpu]
>   dc_interrupt_set+0x24/0x30 [amdgpu]
>   amdgpu_dm_set_dmub_outbox_irq_state+0x22/0x30 [amdgpu]
>   amdgpu_irq_update+0x77/0xa0 [amdgpu]
>   amdgpu_irq_gpu_reset_resume_helper+0x67/0xa0 [amdgpu]
>   amdgpu_do_asic_reset+0x219/0x260 [amdgpu]
>   amdgpu_device_gpu_recover.cold+0x8c5/0xb64 [amdgpu]
>   amdgpu_debugfs_gpu_recover_show+0x2c/0x60 [amdgpu]
>   seq_read_iter+0xc2/0x450
>   ? do_anonymous_page+0x22c/0x3b0
>   seq_read+0xf9/0x140
>   full_proxy_read+0x5c/0x90
>   vfs_read+0xaa/0x190
>   ksys_read+0x67/0xe0
>   __x64_sys_read+0x1a/0x20
> 
> Fixes: 85465bd6dc6e drm/amdgpu/display: remove an old DCN3 guard
> 
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/irq/irq_service.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
> index 5f245bde54ff..a2a4fbeb83f8 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
> @@ -119,7 +119,7 @@ bool dal_irq_service_set(
>  
>  	dal_irq_service_ack(irq_service, source);
>  
> -	if (info->funcs->set)
> +	if (info->funcs && info->funcs->set)
>  		return info->funcs->set(irq_service, info, enable);
>  
>  	dal_irq_service_set_generic(irq_service, info, enable);
> @@ -153,7 +153,7 @@ bool dal_irq_service_ack(
>  		return false;
>  	}
>  
> -	if (info->funcs->ack)
> +	if (info->funcs && info->funcs->ack)
>  		return info->funcs->ack(irq_service, info);
>  
>  	dal_irq_service_ack_generic(irq_service, info);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
