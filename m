Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4966AC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 16:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5DC64E46
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 16:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5DC64E46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A51F86E82B;
	Mon,  1 Mar 2021 16:23:05 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750045.outbound.protection.outlook.com [40.107.75.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 799C46E82B
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 16:23:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARQ68J5QJLUAhXJbVkqa+ThxAoLTrA6Jg2wJKRHw05Ns36VcSVj+Uan2baXAaRz0sBpadzNXQdXv58RSnzxA9F0ffkKQxx+QkJSg+XKqeoTlsiVNZp9uA5pyk6/mN3vVbMuwMAAwAaS4Pkno9qjF2eZGuRdNpGKTpJ2l3exxvlV0RjYBf5COOf7Ij3L0GKqOOm/AXQRdwFgMi7S+cpoEnn3PuonmhHI9GnEYZTNakenohLvZOGxGe6TSwB6YqJdW3LeVMmluQ4HgAWo3KpJpSLjhtmqemKEW+y1fCSqw6EcwyvdArc/lAGzrIgB4WS3x/r+Go3OgzDntjXpURQGweg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0DlOpuiGrQhg15Ul1XjxpTbUDjJHh/E0Y03j4tZOjI=;
 b=RYcCcyD+z3/nurQcgxeKNFlh1KZrifOg8jWoAyVLchl9yFA4m8EVNttKiaDNo+dI5RroIDYCW3y2+GboO9VJBqskbfp4G3WM4OMvlKhqTlzGMtgNVaiFCx4rhVR2xXrD4frENz00cYAHOIXjrrZSXhit7Dh9k7LzO+NHw0k8lFoZ+3R133Pcs+mFtOliSL6EEsVsNdu2NRUgQLgygddfDZ0/BAtCaEFNyibk0YUW3f9+7OgZav+Pr/v0Os7mvhXpQqMzAWynVT2XS+gXfm34baBFQM7BvfJ0aITPWiWAWqutKOPxsT3JDfjjV7RfjtBUcAaOgWFhl13Q+tUDBdKHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0DlOpuiGrQhg15Ul1XjxpTbUDjJHh/E0Y03j4tZOjI=;
 b=4gZkWCD//E9br0+Fd287Qakw82ZHWoVqNwMySR+RXyuvL7OSh+WPdoW9o1xCBlQ9ajIXR9hq1xkXQFnUzyxMqILFQ92iIlcpexsr4DowfY1/Tln2wnK+S3aJWuXRjIq9fh06hsKLzCnLQCGj80ycqtdgzGsfnfmUDHZcqtsTQE4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18)
 by DM5PR1201MB0154.namprd12.prod.outlook.com (2603:10b6:4:58::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 16:23:02 +0000
Received: from DM6PR12MB4108.namprd12.prod.outlook.com
 ([fe80::d6b:e85a:1902:1d96]) by DM6PR12MB4108.namprd12.prod.outlook.com
 ([fe80::d6b:e85a:1902:1d96%3]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 16:23:02 +0000
Subject: Re: [PATCH] drm/amdgpu: Only check for S0ix if AMD_PMC is configured
To: amd-gfx@lists.freedesktop.org
References: <20210226222758.1454716-1-alexander.deucher@amd.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
Message-ID: <b7fa4165-43a7-0898-789f-935f187a3e9e@amd.com>
Date: Mon, 1 Mar 2021 11:23:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210226222758.1454716-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [184.148.68.141]
X-ClientProxiedBy: YT1PR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::45)
 To DM6PR12MB4108.namprd12.prod.outlook.com
 (2603:10b6:5:220::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.20] (184.148.68.141) by
 YT1PR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.25 via Frontend Transport; Mon, 1 Mar 2021 16:23:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 34e73380-d919-40db-9972-08d8dcce494f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0154:
X-MS-Exchange-MinimumUrlDomainAge: lists.freedesktop.org#0
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0154826931CA2775B08144F7FE9A9@DM5PR1201MB0154.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4k/uAP75/hI8hus3RnkHNQ8LZxXpDPMOtIFcUyhKoPReJyZeF04siDEn6SLA9+OqqWGxwR/vZq8VLnC42H/DYOWpHXboo3SMID2FA18ngR0j+mTVFcqmU8GaBkKmsI2dRlJWCB1rNTxnYlYN89iwyEyP//R4E+AngmK3vEc28HV9RWSuSfB1UANVJWHK0QNcDLSV2zUAG/4FkClujJCq6dQSncs8q/E6HXMEkafeQeWpfUJ2Xv747aXgnI5PrnOZ9dmu9ma5eQX2sC7unP6n8FMp+Ewzmm6oFoSSCkZPHgxV0OugI4QZQDAYlpzC3GnaHQgSADLzjTYC7S1/TtlgvyzoF9/xDNaq+uYHgXsHKZT06EUiobQn7o3PDhicxM6sP3WDrlBg0UlhS5w6PsHYS+jGmZrbVFTzNbPGcd/qE707azTM3ZZjJB2oVBS74Al02HpCUiSxV1ACV1BrHvbf8zQEOlxZduxdCKUfFqdKx2xO2/9XMMQdsVND0ThIpq03GZSzSp8MwPcN3BHlaYHD7yqZ6wuwqZ/b8G4xnDHV0pn7j8x98UH+u0kJHsJ4II0+7ENzQa8Ouj8/XEd5wdMSuwMARCK6YLsZRTURnmruqOpOpaY7n8j3ZE4s6aaFjoUvW9uocUqSVyYexCUQik6Lt/6q9H/0/Cx1D61D0qZrvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4108.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(6916009)(83380400001)(66946007)(31686004)(478600001)(966005)(53546011)(45080400002)(31696002)(316002)(186003)(36756003)(8676002)(16576012)(26005)(956004)(6486002)(86362001)(16526019)(52116002)(66476007)(66556008)(2906002)(2616005)(5660300002)(8936002)(32563001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?elpzaFNqTmhuWE5zcW82L3VMMWV3dWhGTkcwR3kvdXRpZENrNFJLckRxalZ4?=
 =?utf-8?B?WUVBdi9xOEhrYzlGME8relI4SEhMV25tdnZHTnVOKzVtOG5ZMHk2bzZQTmpp?=
 =?utf-8?B?ZWlhSFIzaUY0bWE0bmZWbXFxeWxzMXFMUk52cGRYcHAyUTlTVmVIU0V4ZEpW?=
 =?utf-8?B?ejRJaTVURGlLUFRrWk9YckxUek1odXYvTlpvRGJ6anhWbktYTm1xUHhzWlBh?=
 =?utf-8?B?b3VjYTFKOVFFSzdpVUlRUkVYZnR5N0ZFUHNoMHEzUEE1dFVycmJFYXR5UFJm?=
 =?utf-8?B?N3I4NHFIQmVkdDJ3cS96T1JUWHcyUThPVW1icmIwMHdRd1AxZDNlS1B4NVFM?=
 =?utf-8?B?NFJjTk9FZ1JHbUhmbTZOL3ZpTC8zTEt2YU9JdC9CWjVzRjdqSmZ2bnlSTS84?=
 =?utf-8?B?aDRHMFRjTDJnbFkzNmpkTlZBemVhYzgrOFdrTERyQTFlRTNnaldyamFIamJi?=
 =?utf-8?B?OVdZNWhTbTQxZEIyVSthQllIeUFaTXJoVFY2UHNhMnNkaWVRTHhSUmZVb3FF?=
 =?utf-8?B?TDVLdld6ZXVNWTRvRytCeXRBWmhuc0hTcUNUU0kvTEZYOFJWaHdzWHp6UC9y?=
 =?utf-8?B?OUJ2VWJ5dUp6T1N6aERSRk1mUVQwTDVLb0haaVMvMXlBbDBFZklwNmg0ZWYz?=
 =?utf-8?B?ZVE4OE5XeEgvVFlBU0RGVXY4TEQ2bDQvcTJQamxSS3Fpa0pFOG9LZGxaL1du?=
 =?utf-8?B?S1NLTnZpRTEraE5sMHJYajdEVnhsNXRLMS8rZGE2a0ZGVDcvWmUra3pmTlBY?=
 =?utf-8?B?S2pNNGJreGJkeklGNjZ1M09sWFhKRjEyUkVxZkVCMFRvTHozSDM4MllLamNt?=
 =?utf-8?B?SHlRNmFkcTFEODQwd0ZlT05qQU9UWTVHbUwzYWdqY1dMS3Z0YWFYMTNVVTRy?=
 =?utf-8?B?N092RDVpVFNUeHppcTViR29vMHFjOUhqRzhFWExXb1ZiZENQcjlsVXVkdTRt?=
 =?utf-8?B?eldNSTJoNzNia2t4Q0hPTWNhand0WXhkTkJycCs0M1FMUXgvaDNGRlhwb2Fp?=
 =?utf-8?B?MkVCVXdLNXZFWXlRYWEzL3dWN0xpTDd4ZDFkNmU2R1BVVVVaM1lIRlphNm9C?=
 =?utf-8?B?UHpoSWhFWVdnVVJzT3ViYWhHT2xBM3FmNTFSNzQ1U3p2ZCtXT0pjMVNJVWdT?=
 =?utf-8?B?QkNMa3A0K1BPdHhlcFd3RkdXVE1Ya3c0OEtCV25mQ3FFdUlFMStRb2ltL3gz?=
 =?utf-8?B?M3ViWm1lUjBQRWd5YXl0R0VteWl1d3FqSnBTK0hqaGs2cDI2RVlqbEJsb3h0?=
 =?utf-8?B?STROSEIvVVpMK3hXaklBVzgzeWhVdmh5MmxiRlQ3L0QvcHRSUHVnM1h4WnRZ?=
 =?utf-8?B?b29uWnA0QmJXcUJFeDJlK3lvTHZNaGUvNnJLSHN5MUd6S0FYMFIzY2doZXFV?=
 =?utf-8?B?UTlYVHdJYXg4RlRtUDdadWpTdmE4WmYyTmxYa2pqZy9nSzJUVWlET2ZxTzNO?=
 =?utf-8?B?T2lITjVuLzZXSmZxZkN1aDB1M3J5QmI3SmNRbHNzbE9HbDNXU20ydTZQUmNK?=
 =?utf-8?B?djlDZTJDQkdzaUZlTS9HUEduZ2J3VmNIVXBBSGZINGRoVVFpVGJ2M0lJdTFu?=
 =?utf-8?B?MGFYSll3bXF4UHN1amMzMjFwbm1uc2FLY2p5KzdSTG1TWC9WSHRmV2l5Zm1Q?=
 =?utf-8?B?UDFKQ0c2YWV1ejBoYjYranc2bkZFNnorSjdLRUZtWTFBMVZoZXBwVm5lZnEw?=
 =?utf-8?B?SXFZOEE2TkxaL3A5WlVmS2hURVpYZU83azdKSmEyS0JObDh0OWhwTlU3UmRV?=
 =?utf-8?Q?+oOO9rMu/wF32T1+T6q+SulI/SPI6w5HSlUgSL4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e73380-d919-40db-9972-08d8dcce494f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 16:23:02.6213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CwB7/0HchKTMRGwHo2UoxNlVQ2sy9HwyyPVwDxsYkpycEaZqqpb88yhyFF5vGt5oaUpezRnWLx6sgNhVZpr2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0154
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

On 2/26/2021 5:27 PM, Alex Deucher wrote:
> [CAUTION: External Email]
>
> The S0ix check only makes sense if the AMD PMC driver is
> present.  We need to use the legacy S3 pathes when the
> PMC driver is not present.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 8155c54392c8..36a741d63ddc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -903,10 +903,11 @@ void amdgpu_acpi_fini(struct amdgpu_device *adev)
>    */
>   bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)
>   {
> +#if defined(CONFIG_AMD_PMC)
>          if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
>                  if (adev->flags & AMD_IS_APU)
>                          return true;
>          }
> -
> +#endif
>          return false;
>   }
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Crajneesh.bhardwaj%40amd.com%7Cb87b540fd0f94816b82008d8daa5d54a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637499753077416653%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=BAGVzTXPSiYXg7VgC0LeNinwMwDlcGJ%2BehuPffi6k4w%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
