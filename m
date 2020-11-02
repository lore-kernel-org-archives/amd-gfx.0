Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3F0C00A89
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 19:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C2CC2225E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 19:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wJx7U+/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2CC2225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F10BB89F4F;
	Mon,  2 Nov 2020 19:13:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1A2689F4F
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 19:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXecIDVW4WG911Tfnv7wU5+Hr8bbJ46ih9uTAtM0A9McXSqJ260tTmc3OVIsmE+4ASWkYlyxKDYe5BTkbUQWZWmRkAGYvzSnmHyyehvE0gDkPa+Sd2dtygq8kuVebgVEJfXtrrU9AuFG/icAQJMd13LM8UduJ/NeIpXwxl7C354V2eGPENwFZwg0jNSDRzkdR2Jk7r/SKDfAvefiEkRLqde+TiD5pVhp7bi/wZdZX/ydih8zf7utuxUxb44xOfFerf82TZo/iAoC4eKLaebS+XIJupMUs90kGtBue4N2FJC1iNxUGvO9IcKTRdfeQEiVfj5Y+eah/uJ0+vhns1VYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kJe6HRguQxOujiV9XecgLgp8pEAXcjXOHbrct34k+E=;
 b=DBtDpqUu7Lk+tsbMBRp/REapNYUh2S75Bm9C97dVOu50yRR7L/Uw9Oufztdp8mQ/423cVLDVCynJjF9h5gITvN/4VP6cz4ltEvgGOu70acsFaUmlCqlFmgRb/SZGGkBEUCXFpTvVfYZ3uWihMFXaiC/iCJswmeXNL4DJqZ/p/AnFLByKPGAx4nlyzOgQvbgZ6FAuy9qG6yANaDH/hsSAGul6mxEfeD7KrREqWIBHhxb4V2fwWQQymRVDBtgpElA0XZtJCo6RbWAhpN1x+NnVabphIqlTLfsvZR1CnhLEaWsAfDrC4jamHvyUS6j4uPJGpH0qMl4kpIKm1wQFNyoAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kJe6HRguQxOujiV9XecgLgp8pEAXcjXOHbrct34k+E=;
 b=wJx7U+/XkcTDuHNDOyiGON0hZmV/FoDuPOTgdP8LIBfwuIbmEFA4hEgyyDf9z1z6fFEUzYGLEPyfSp7MDmVs8taBcJcYOdkdLFEjabUryogCMsYvo5HGdLBLgX8VH+G7BQgTZ7Tdo5oHsfR0k/ydWzDkzpqxnPw15qLWgfGAcAw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3064.namprd12.prod.outlook.com (2603:10b6:a03:da::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Mon, 2 Nov
 2020 19:13:47 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999%7]) with mapi id 15.20.3477.037; Mon, 2 Nov 2020
 19:13:47 +0000
Subject: Re: [PATCH] drm/amdgpu/display: fix warnings when
 CONFIG_DRM_AMD_DC_DCN is not set
To: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20201027150356.1786991-1-alexander.deucher@amd.com>
 <CADnq5_MktP-NEq0s7c_gqV8wFYqxR21eQ1mVvGzEFF3b_K7vJw@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <ea1a77f2-66b9-3201-f460-1c5487dcf62d@amd.com>
Date: Mon, 2 Nov 2020 14:13:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <CADnq5_MktP-NEq0s7c_gqV8wFYqxR21eQ1mVvGzEFF3b_K7vJw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YTXPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::19) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTXPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 19:13:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 624689fe-a2f8-41f4-0b55-08d87f636c70
X-MS-TrafficTypeDiagnostic: BYAPR12MB3064:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB30640869E9E9E9CF79C5FFB9EC100@BYAPR12MB3064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d/vZow0gom7WlLOITNmX+RCVwABk4rORD4G3fn7wZUkL4lt6s6Yeqc3YKu3Kt16GxMK1D2lSBaiRB6KfgucI8JWmhOLvF+dN6gLAkKmXIn8TmqCxOYINrctr8pOAYr3by5k6f42F2O4VBcSyB+yF4r4mqwCtm8SwazwSYnutJObfbSR3zFBtOLDljp/rs5vPtOkaqG4Wwyh5gLQ4kfZ9ismVFJG13NS27SzZfxYOXr1cRJB8ah9PEb2qB5F7Lc/2iL+kCXrp2+/O+g6NXurcXJlVNVVWMfR44HP1osyZ+Z8dBGsWj63exsCsTq/XMlYT2gK0GJKmCiXkP5C3rs/40et7k7pvVH9zPf0ERsudN/L5dBfD0MbDaEIB7NTJ2jOePHRqM8Xf8I7b6uEbG+5UQA++VWamI8/yKkw/ea7I6Ww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(6486002)(110136005)(66946007)(5660300002)(36756003)(66476007)(83380400001)(316002)(16526019)(4326008)(186003)(86362001)(52116002)(16576012)(26005)(31686004)(2906002)(66556008)(2616005)(31696002)(956004)(966005)(478600001)(8676002)(6666004)(53546011)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: AGpYg/CRj3dy6aMh9+UxZkM3rU3WaNcwO1G8/ayAGOwfs171EDk6cAzj4yUstFwi9J4DK0buGgL4aGtXw0tQUOEw51UHjNGde8lKXhBrcKCD15PEwB+UsFU5nnO1N+rSkL4v5V3WPkB0BOrLP6U77TJt2RM6728dq7CcrZO/b/H+LbMNPnocxIRWdCHXlBJl3t6LhDXZfVQaYD2ePhLXZ+L7OC28fMVDiQlLPkaHiSNN4Pl4xHm81Y+w2N20+VnbwriY6BmssK9urezkoYJp6cR8TwJoCJayFfeXDCOJtmcfai4j2+gEBtpWpZbSBNOT1QS+o6cj38tAemXud4ZO0XP8DivBmsglDO+TnzlHlAiDkbXNAONpseTTC7QLQcpe9YA2HSOeuuJZUwal+XYgLXSvORucXX9ftmxW0Ph2nM1W7UbUOv4l9OMoEQv8kXncyaKhHHk8JSV36TqmTffa48o6KckvwazFEDvA8ixuhwED+BL2Nc4Q6ETrVAotqU/gRYJt1ie0ISRoV/i165XVVVbRguZcNFIbCBqFqGi0WQeLgeHQqmUEtsvJBhvmEXgGDnTULmXQvJ0ySmNwg46xaqtMyZ7jeIKi5OvYmy3B0NPy+jN2Y8d0/HDT7ZQOxJjlNtD0v+jWvOo6Yk5Pklc/FQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624689fe-a2f8-41f4-0b55-08d87f636c70
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 19:13:47.5194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBqXHof5/JeCpjcbNrr4Jd57SGvQGGhd3r59VGtCVlw2VpWc5uioEqxwQhsh9QHFJe53KXbLZRyyoN28PQXQBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3064
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-11-02 1:49 p.m., Alex Deucher wrote:
> Ping?
> 
> Alex
> 
> On Tue, Oct 27, 2020 at 11:04 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> Properly protect the relevant code with CONFIG_DRM_AMD_DC_DCN.
>>
>> Fixes: 0b08c54bb7a3 ("drm/amd/display: Fix the display corruption issue on Navi10")
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index fdb1fa72061a..843080e4c39e 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -893,6 +893,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
>>          return 0;
>>   }
>>
>> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>>   static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_addr_space_config *pa_config)
>>   {
>>          uint64_t pt_base;
>> @@ -945,6 +946,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
>>          pa_config->is_hvm_enabled = 0;
>>
>>   }
>> +#endif
>>
>>   static int amdgpu_dm_init(struct amdgpu_device *adev)
>>   {
>> @@ -952,7 +954,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>   #ifdef CONFIG_DRM_AMD_DC_HDCP
>>          struct dc_callback_init init_params;
>>   #endif
>> -       struct dc_phy_addr_space_config pa_config;
>>          int r;
>>
>>          adev->dm.ddev = adev_to_drm(adev);
>> @@ -1060,6 +1061,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>
>>   #if defined(CONFIG_DRM_AMD_DC_DCN)
>>          if (adev->asic_type == CHIP_RENOIR) {
>> +               struct dc_phy_addr_space_config pa_config;
>> +
>>                  mmhub_read_system_context(adev, &pa_config);
>>
>>                  // Call the DC init_memory func
>> --
>> 2.25.4
>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
