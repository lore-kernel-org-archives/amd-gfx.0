Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA07C2D0A8
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 17:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7146A212CC
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 17:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VTSZSY5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7146A212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E14FD6E9DA;
	Wed, 23 Sep 2020 17:13:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8071B6E9DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 17:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKOS14KUpdAPkRdH/iVpy+auxizcaXR6PzV0FNzGhXIr7AVL6aUL6/UIhRsy8hSkR/nGSvcmlzHQVmO+NO075ZGhsrK6TisQje365GXFowW/DyKAWJ14FF3uXDW4nnJ/irq5/0tFwtWMfw6Gfi7Sj8nJ8SxU29wdcDXC9kEvO1XaX7Pn4MD52nOOoahEDfXcRP0lHDBS2aTmu8DboZzJSjyJYXYVWhPWw8qRm/TJ49xJGMcGbGglJKoMSYw/TV28n1Y4utJmVRPnkqRyHV/RkVnzZaBKecJFSPJeJoClxu+4wjkVxtqUMAQxobqgaViW8drgEFl/mUonVL3pSVNYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Garc8jUdaK3WSO3NH3UWsdgPwevEw2151DT82ta076A=;
 b=CxP7EUDFy5EfVuZ7yBnGe2B1+nbmX1X9RmqKWMr2BFMEMlsGOD22f0bsWoyGrEDF1IS8buYo3BAdr09nsvqIBSUG1gW99jo8BL+QbbxhzUsqgyb4TX+jr+Rl1t77qodCzyGSj/tHVABnVAoZjI2zWKG3laoci63QS2b/w0rJGyL2GKTAgqkjrXNHDRXhhZF59KzmxvBCeL3Yrda8N2TtcP2jPLYoxd3QCfkkaxsAWXTmGRPcWlonnD27md4wSGT4Uw9oio9tEtBrHyr4tzldCmMHTreSeHWfzeA4IwyyokUNSaM4psiRPU2sdNO2OIrz6FlfGxx228+bcYhHs4Xqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Garc8jUdaK3WSO3NH3UWsdgPwevEw2151DT82ta076A=;
 b=VTSZSY5pTlZ8TLlArXSI81vrlcoYsEo4xj11md7po1iigtJHxuq6pGO591uNiC0ttU60ZHsY6Qj/VT6oyTqXu9IQFvFcMNYMe7wX8oGtrH6wv55BRXdkwGfdkC7BzGRf17lOQBxeIcE4ItsbBKLn0HK9b13xQAFwKMVwYGzS9PA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR1201MB0028.namprd12.prod.outlook.com (2603:10b6:4:5a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 23 Sep
 2020 17:13:46 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933%3]) with mapi id 15.20.3391.025; Wed, 23 Sep 2020
 17:13:46 +0000
Subject: Re: [PATCH v2] Add PP_FEATURE_MASK comments
To: Ryan Taylor <ryan.taylor@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200922155500.9239-1-ryan.taylor@amd.com>
 <be88bf11-c18a-f316-9255-1a9d69b76308@amd.com>
 <48257725-d7dc-dc05-eeab-4aef18445d50@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <6028dd73-f662-27f9-c75e-3522643a7771@amd.com>
Date: Wed, 23 Sep 2020 13:13:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <48257725-d7dc-dc05-eeab-4aef18445d50@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::40) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YTXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend
 Transport; Wed, 23 Sep 2020 17:13:45 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0f408a51-a0d5-4f7b-ed4a-08d85fe407f2
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0028:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0028DA5408FB282183D3EC5899380@DM5PR1201MB0028.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2aTy66sqKSegiHMJr4P/UG0JgvNAGk84Mu76FHL+d2zLMz0pJJcl9iJv0JMhC0SQWTBbdWXuHOcIbnQ/U74TRpTIgORYwU71G96x+8N65MspLu/eWSDozQJc4ok/9KXE5oJJ1Mv8gfRYiaNVA4QoDU0CPhVojd04Clmm3K1UzdnW7y6B22hkBUvKfitTZBDkPsU/+9z+yRuq4LZT1FVLK833FYjNNNuFmvpIW152txHCScMi3F9+Klgvb4HBsp35DHf6TIvFF2YsgFiYUz4gtH9ytjqw/hDx/IBMXqx+QMsp39caDphVpRleTZ82vTKU6Cql3wUvuML14wuwZEhkG5+HiEKZNLMu6gcG3ADIZHDMtJd3Ld4vWELQozRC6E/yR0t7xSXRagSymSeQrDWiINNG9YH8RU0onjfiyrrkRknfB7xrz9l0NE9hzbnV6F7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(52116002)(4326008)(66946007)(53546011)(8676002)(66556008)(478600001)(2906002)(66476007)(83380400001)(86362001)(31696002)(5660300002)(26005)(36756003)(8936002)(186003)(956004)(316002)(44832011)(2616005)(31686004)(16526019)(16576012)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: gGwLSjUiadPMoaWVOCLHZXv2egpBoPk9SInSksQ80pxLdveVVXspfsB5xbPLvmvz1aw8zeYabXlKX8DdmEIhilKmRkNcJ7b7OWhXpj7Mm8wp4EdYPiZqdIXv9eIUiCfOlLU9v5Vu7dcTKF1ZpuUhXRrqQ0GpWi5ji9suP3An3+hAOqrVFiXhriu+xcaLNuyRHudDzmHqF5SG5YpaWfXV4bARBLUHHzb7+Grs7/468Iz/rbgL6eYAfeVGBHu6jCmcLfyRPAFsDlbRvo/IVIZ6Yz/mLo08igXUoPPvgE37VkIJdV7JGhseHGheBxEGjh/B0o+qFtRn+XD6lM7rX2U02gOkvLCybbPYXePf/r/54nkG/N6L7fGwZmRN71k+4qRdWe8NCK3YbAI5b6sX27U570Jntqs0iQ4+qrLw1LEzRtGijUAj+sld6VqdXr2jorkhwycMw/GuTy3WmL3TMDqQlNieBUcOhip5jtDKUefD2xmXS3DNTmpYs9eTCsNbAvUjp603/lYr2KVsIKQI/Z6EhvTiZqsGrkMoDgBZAoiWScsjDQsLfrgN9ZNG7Hqs9pEkdJtdel7LrkGpcsQ/WhpEzxZ1VolfXQaTw79L+TShrNKYShoJOMQSNnpXbxXSo7MageeVHO7UK4v5SoS2CgWYnQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f408a51-a0d5-4f7b-ed4a-08d85fe407f2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 17:13:46.6916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGd28TNO2apQdF13pW0F2NmbEojMBBijOePfr9JOmW/0ChePYWj+SzhjWGlNyk8p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0028
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-09-23 12:31, Ryan Taylor wrote:
> Thanks Luben,
> 
> I'll make these revisions and try out Git's patch version setting.

Well, Git's own patch revision command line option (-v of git-format-patch)
would put it in the "[PATCH v<N>] Title text" as you had it here, and I'd
presumed that you'd used that command line option. Our practice
here is to manually do "[PATCH] Title text (v<N>)", where the patch version
is postfixed.

Regards,
Luben

> 
> Best,
> Ryan
> 
> On 9/23/20 7:40 AM, Luben Tuikov wrote:
>> On 2020-09-22 11:55, Ryan Taylor wrote:
>>> Documents PP_FEATURE_MASK enum.
>>> Provides instructions on how to use ppfeaturemasks.
>>>
>>> v2: Improved enum definitions. Adds kernel command line
>>>     parameters to ppfeaturemask instructions.
>>>
>>> Signed-off-by: Ryan Taylor <ryan.taylor@amd.com>
>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/include/amd_shared.h | 28 ++++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
>>> index e98c84ef206f..7c84d5beb600 100644
>>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>>> @@ -128,6 +128,34 @@ enum amd_powergating_state {
>>>  #define AMD_PG_SUPPORT_ATHUB			(1 << 16)
>>>  #define AMD_PG_SUPPORT_JPEG			(1 << 17)
>>>  
>>> +/**
>>> +* enum PP_FEATURE_MASK - Used to mask power play features.
>>> +*
>>> +* @PP_SCLK_DPM_MASK: Dynamic adjustment of the system (graphics) clock.
>>> +* @PP_MCLK_DPM_MASK: Dynamic adjustment of the memory clock.
>>> +* @PP_PCIE_DPM_MASK: Dynamic adjustment of PCIE clocks and lanes.
>>> +* @PP_SCLK_DEEP_SLEEP_MASK: System (graphics) clock deep sleep.
>>> +* @PP_POWER_CONTAINMENT_MASK: Power containment.
>>> +* @PP_UVD_HANDSHAKE_MASK: Unified video decoder handshake.
>>> +* @PP_SMC_VOLTAGE_CONTROL_MASK: Dynamic voltage control.
>>> +* @PP_VBI_TIME_SUPPORT_MASK: Vertical blank interval support.
>>> +* @PP_ULV_MASK: Ultra low voltage.
>>> +* @PP_ENABLE_GFX_CG_THRU_SMU: SMU control of GFX engine clockgating.
>>> +* @PP_CLOCK_STRETCH_MASK: Clock stretching.
>>> +* @PP_OD_FUZZY_FAN_CONTROL_MASK: Overdrive fuzzy fan control.
>>> +* @PP_SOCCLK_DPM_MASK: Dynamic adjustment of the SoC clock.
>>> +* @PP_DCEFCLK_DPM_MASK: Dynamic adjustment of the Display Controller Engine Fabric clock.
>>> +* @PP_OVERDRIVE_MASK: Over- and under-clocking support.
>>> +* @PP_GFXOFF_MASK: Dynamic graphics engine power control.
>>> +* @PP_ACG_MASK: Adaptive clock generator.
>>> +* @PP_STUTTER_MODE: Stutter mode.
>>> +* @PP_AVFS_MASK: Adaptive voltage and frequency scaling.
>>> +*
>>> +* To override these settings on boot, append amdgpu.ppfeaturemask=<mask> to
>>> +* the kernel's command line parameters. This is usually done through a system's
>>> +* boot loader (E.g. GRUB). If manually loading the driver, pass
>>> +* ppfeaturemask=<mask> as a modprobe parameter.
>>> +*/
>>
>> Alignment should be:
>>
>> /**
>>  *
>>  *
>>  ...
>>  */
>>
>> Also, you can use Git's own patch version setting,
>> but I've seen here we usually put it in the commit title.
>> (Remember, titles do not end with a period.) Something like
>>
>> 	Commit title (v2)
>>
>> I don't mind using either. Not sure what the direction is
>> on this one.
>>
>> Regards,
>> Luben
>>
>>>  enum PP_FEATURE_MASK {
>>>  	PP_SCLK_DPM_MASK = 0x1,
>>>  	PP_MCLK_DPM_MASK = 0x2,
>>>
>>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
