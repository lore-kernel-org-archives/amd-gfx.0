Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EAAC2D0A8
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 17:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CA321BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 17:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0JIKNQyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CA321BE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E4B46E9E5;
	Wed, 23 Sep 2020 17:28:04 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700045.outbound.protection.outlook.com [40.107.70.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E656E9E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 17:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBEF9lfbaIWL5EUXChOxW3iMEJrJOlVQVHhUB6QkWnu2YXIH53XmDPAnwcZiNfX/e9WdSONrZoBZhAIRFoB7M1dgTmTu73lDh6BtZ4xMBHUO1gcATI43Bkjr9YEugZ4cxuHJF0VLJtn39nQA7AqpeFJPY+Pn9MmPZjetXB3SDwqApToT8S9J36jY9TkqPM13k+01fJ05NSNSnCIPYByfqi2/4Te/WKRSlr7oAf3vOdiMz9cc61g1O3OFoOFgBv0GTDWR1ehvBK3CXyttzXLs8VgvPf2Jsr0GEVsT0iOYQ/TacAIPSAfyRBQd6+s/VyA9g2Dy8Gx5qR2RXltQGvDTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkwSU3jQzrATVlQKkX2CA44fWP7pOLNausSQFymSzkM=;
 b=og0e6/PfMieF7TpzmufjdBoxSFKX+DJGOnQ7zppP9Sw8E9tYnN2IkdJ156riSEYxhyhZ77NGAxc8lDLda21Hd793nEbya+PKL4VGJUnOCCBr0AF8gnYLsnyjXO1viQcBofSPlYC4H7GkvkLuMy2HwhrqTlLvxOthj8fmPOjl7gwv4/ii8l2akkIdf2lJ/PWaqX3BRNbQ194RpxyikQ30eLNtHIG3CuNMcRioTb0Os2UOLWlwjn3d7vEoqzlR+smJIr0bzQbFFNx4Rfypb0uKFrySrgkNhbYXzC/JOh77iDnHYb/6AD2Qm3Lhep1G2UAC957TfnypbMagAT7L4HpfFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkwSU3jQzrATVlQKkX2CA44fWP7pOLNausSQFymSzkM=;
 b=0JIKNQyq5U1XE/2/mq/s3g7cRPHdKGHFIii6lZ5DrJQZUFXUFXUUPGWPgIiKrqj++LF+Gul+3LyX9n0uGUcO9mh72a8UCTBGpXfnoxM9O8vP4GTSCp2ZvkVIcR1KysliYMwASCfWNVcTOMxaSbzihGJe+97M/erA7Z2xI6awclA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3221.namprd12.prod.outlook.com (2603:10b6:a03:135::29)
 by BYAPR12MB4741.namprd12.prod.outlook.com (2603:10b6:a03:a2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 23 Sep
 2020 17:27:59 +0000
Received: from BYAPR12MB3221.namprd12.prod.outlook.com
 ([fe80::d492:66f5:21c4:7046]) by BYAPR12MB3221.namprd12.prod.outlook.com
 ([fe80::d492:66f5:21c4:7046%7]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 17:27:59 +0000
Subject: Re: [PATCH v2] Add PP_FEATURE_MASK comments
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200922155500.9239-1-ryan.taylor@amd.com>
 <be88bf11-c18a-f316-9255-1a9d69b76308@amd.com>
 <48257725-d7dc-dc05-eeab-4aef18445d50@amd.com>
 <6028dd73-f662-27f9-c75e-3522643a7771@amd.com>
From: Ryan Taylor <ryan.taylor@amd.com>
Message-ID: <c6be8358-e22f-be87-bf0d-3f29f51c4903@amd.com>
Date: Wed, 23 Sep 2020 10:27:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <6028dd73-f662-27f9-c75e-3522643a7771@amd.com>
Content-Language: en-US
X-Originating-IP: [2600:1700:9260:7260::f]
X-ClientProxiedBy: BYAPR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:40::33) To BYAPR12MB3221.namprd12.prod.outlook.com
 (2603:10b6:a03:135::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2600:1700:9260:7260::f] (2600:1700:9260:7260::f) by
 BYAPR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:40::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.22 via Frontend Transport; Wed, 23 Sep 2020 17:27:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: afe6465e-f90e-4f0a-1781-08d85fe6041b
X-MS-TrafficTypeDiagnostic: BYAPR12MB4741:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB4741B6FE7269DCCA1133E664EA380@BYAPR12MB4741.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVQv3AnSI/B9ktXSsF5z+ufq48bv8pYOlbPwpqaGLzlvl4Fmu0NIBWLzbKIlj31VcpJiftZNZNIamTqLjE48+imkQ+/k7IXD+VuT6rG9nKrL52FfBTLtzuiMsi2SSD0yGuv6Re3ASRceXvAQRVDib4PryAvV8geuvTu5s4V+ulzhiIqV+QJB6wBSkpj5PHvL3MtZiK1Uyjaos02XTh08qqHj7D+pFeutMEq3jMH5Pn62GToiOV4MHIXRQAvMtMrHLsHuqJqoY4WImwW6Or1zC4Tso/zJNA9SUESslQ5bBjeXwzojOa0sU/ndnRMJE2vf74kUmvNoD++kExx22ntYifuOXuvUHJFIZO5L4PFGcTM4uT7br8KQ9J1qhHqt6Kbyxo9hEhZJCfSXj+gHZakM20HH2X2Hn+DBnlEPvv26DAqsryQH9K1hIj0SFz9lXmoS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3221.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(31696002)(186003)(66556008)(66946007)(53546011)(8936002)(6666004)(52116002)(2616005)(478600001)(16526019)(66476007)(44832011)(6486002)(2906002)(31686004)(8676002)(86362001)(36756003)(83380400001)(316002)(4326008)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BESz4ubjJZnl/FAfkcRZm6mqwN2Cp9UmGkVjBCAitEgdZCSpN7BEdFHrpXl+xeipfkkrhP8B77qKTxjisoPb5HeYQtCqtrs390lk0LyXEOCfrODeCDJFrKaYSbn7bnQIZTqig9KZ5BVDh+ASaRVD4yabdjF5Qbge36xCXx4kUtR64TLzpvwTqo6yZlwAoqmXtPTwHTn/dTMjfX6dj+Ji0dcObPDHHt6yTXPP3k+4eVA9wSwjSyhVz5G3hvTgVc4cXBRht9zUgJservTh6r6jKbt5NoZrqtjvkwNoNL9ciAu02rhLNJ+NDpmF0q5L8PJS3BfPJ3uyqzATWmJhXIqr6UyHWKXvmFgSlJoK2wxntZ0kPWndcR2n6mVj2iwRNTX9NbuS/hC8/mGDB4+GQyfJ29bqfhb4DuTVcGTakybf3dXPK1yqITgPsfUCmFGTRxV/bJeZyiyCICyup4LmJYpOl+Oc3rSF/uR6T4F2QwZ2M5W/kv2aY6n0bZ8mUJuSW8s3E+xpoNOhHtjSW8iVdhHx1hH+/p1fuQdw399Ua2bMEkTdpoAPiKkdN+PkYB7ctY9JlDILXL0jfkKIdu88Or2lAzi8iv+izUy1ZKPRnCA5xRxbJ7YaG+JNbLGX9r5TUcdXrYds/sU4NLwZ03pzCPWxjvy1DD533uT7Ke7YycNcTNY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe6465e-f90e-4f0a-1781-08d85fe6041b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 17:27:59.0595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSN0do0AJFY9FpJJbD2IU1paufGUrWxkc6DMeUTO1jpiPjLFO6DvWjqY2Mzf37KsR/tsuez+8tObUE8m5LCe5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4741
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

I see, I'll add it to the end next time then.

Ryan

On 9/23/20 10:13 AM, Luben Tuikov wrote:
> On 2020-09-23 12:31, Ryan Taylor wrote:
>> Thanks Luben,
>>
>> I'll make these revisions and try out Git's patch version setting.
> 
> Well, Git's own patch revision command line option (-v of git-format-patch)
> would put it in the "[PATCH v<N>] Title text" as you had it here, and I'd
> presumed that you'd used that command line option. Our practice
> here is to manually do "[PATCH] Title text (v<N>)", where the patch version
> is postfixed.
> 
> Regards,
> Luben
> 
>>
>> Best,
>> Ryan
>>
>> On 9/23/20 7:40 AM, Luben Tuikov wrote:
>>> On 2020-09-22 11:55, Ryan Taylor wrote:
>>>> Documents PP_FEATURE_MASK enum.
>>>> Provides instructions on how to use ppfeaturemasks.
>>>>
>>>> v2: Improved enum definitions. Adds kernel command line
>>>>     parameters to ppfeaturemask instructions.
>>>>
>>>> Signed-off-by: Ryan Taylor <ryan.taylor@amd.com>
>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/include/amd_shared.h | 28 ++++++++++++++++++++++++
>>>>  1 file changed, 28 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
>>>> index e98c84ef206f..7c84d5beb600 100644
>>>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>>>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>>>> @@ -128,6 +128,34 @@ enum amd_powergating_state {
>>>>  #define AMD_PG_SUPPORT_ATHUB			(1 << 16)
>>>>  #define AMD_PG_SUPPORT_JPEG			(1 << 17)
>>>>  
>>>> +/**
>>>> +* enum PP_FEATURE_MASK - Used to mask power play features.
>>>> +*
>>>> +* @PP_SCLK_DPM_MASK: Dynamic adjustment of the system (graphics) clock.
>>>> +* @PP_MCLK_DPM_MASK: Dynamic adjustment of the memory clock.
>>>> +* @PP_PCIE_DPM_MASK: Dynamic adjustment of PCIE clocks and lanes.
>>>> +* @PP_SCLK_DEEP_SLEEP_MASK: System (graphics) clock deep sleep.
>>>> +* @PP_POWER_CONTAINMENT_MASK: Power containment.
>>>> +* @PP_UVD_HANDSHAKE_MASK: Unified video decoder handshake.
>>>> +* @PP_SMC_VOLTAGE_CONTROL_MASK: Dynamic voltage control.
>>>> +* @PP_VBI_TIME_SUPPORT_MASK: Vertical blank interval support.
>>>> +* @PP_ULV_MASK: Ultra low voltage.
>>>> +* @PP_ENABLE_GFX_CG_THRU_SMU: SMU control of GFX engine clockgating.
>>>> +* @PP_CLOCK_STRETCH_MASK: Clock stretching.
>>>> +* @PP_OD_FUZZY_FAN_CONTROL_MASK: Overdrive fuzzy fan control.
>>>> +* @PP_SOCCLK_DPM_MASK: Dynamic adjustment of the SoC clock.
>>>> +* @PP_DCEFCLK_DPM_MASK: Dynamic adjustment of the Display Controller Engine Fabric clock.
>>>> +* @PP_OVERDRIVE_MASK: Over- and under-clocking support.
>>>> +* @PP_GFXOFF_MASK: Dynamic graphics engine power control.
>>>> +* @PP_ACG_MASK: Adaptive clock generator.
>>>> +* @PP_STUTTER_MODE: Stutter mode.
>>>> +* @PP_AVFS_MASK: Adaptive voltage and frequency scaling.
>>>> +*
>>>> +* To override these settings on boot, append amdgpu.ppfeaturemask=<mask> to
>>>> +* the kernel's command line parameters. This is usually done through a system's
>>>> +* boot loader (E.g. GRUB). If manually loading the driver, pass
>>>> +* ppfeaturemask=<mask> as a modprobe parameter.
>>>> +*/
>>>
>>> Alignment should be:
>>>
>>> /**
>>>  *
>>>  *
>>>  ...
>>>  */
>>>
>>> Also, you can use Git's own patch version setting,
>>> but I've seen here we usually put it in the commit title.
>>> (Remember, titles do not end with a period.) Something like
>>>
>>> 	Commit title (v2)
>>>
>>> I don't mind using either. Not sure what the direction is
>>> on this one.
>>>
>>> Regards,
>>> Luben
>>>
>>>>  enum PP_FEATURE_MASK {
>>>>  	PP_SCLK_DPM_MASK = 0x1,
>>>>  	PP_MCLK_DPM_MASK = 0x2,
>>>>
>>>
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
