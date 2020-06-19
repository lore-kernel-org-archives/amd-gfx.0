Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A58C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 16:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE372168B
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 16:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wfQK40Sn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE372168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E65406E0B9;
	Fri, 19 Jun 2020 16:24:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D7C6E0B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 16:24:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VexU/tDuUxE/TLaIxuyvImpfADOf9+gwh1AL7z2lBDM1vhKynSHeBXv42Vu6AhjD8hRNpFClvx14iS2mInIHQvITWbIGW1WkKR+JKL9ogzjb04v7qOtijQoVJQIkY5TQs2Dh9cazf2mKbGqHiUyuqL/V+Iuh2CmgSiIlBAhPdxZVG4wd976HG+v2cN1p407YY1eMlvkRZIMm8ktAYkUziddxk0+G9Gm3/CLQQyiejaOub+1BxCTI97uIemj4BILEbdedN/MuF2QOZY0LYAaJ0rEogqFAlz2rm9pYpiI7UqT18tuD0j3jfqs9jbwb97/3mfC2WvI7i3ZZLq8HQLVzrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wdh2yP9T0pBLn+TVqtzxamQvOb4X88GB7sPJ+Nepy0M=;
 b=B69BTICRhSFCoKQR4WgUY1Wv5e2Voa3Rydi/BTCHxFdSRZ0LCpP4Dc5W4yefCDYdu3E2HVDOzS8BsLKCKULBwiMVqZroG0B+bpnvAWjNqujyn0jB++nT1EuIdyp15mcW37fxaQCJoK98unf5HiwwF/c9YA4SCUo+JKyu9W6MMRB4w5EErgaUIYGLA/roO2c9RJScmjPpHjYYITiXpmYUte2AwAPtMfGIrm0JLW50tgiWgecuNoZQGYE2goKfR5UkwKmo3poaZdGzWtmoC/O0bOdcL2hq5uKVeKpRTGar8w1X9vGdGE0/cgMZv7sTOwBFOgTykOiwL+OahIriHdz3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wdh2yP9T0pBLn+TVqtzxamQvOb4X88GB7sPJ+Nepy0M=;
 b=wfQK40Sn6NgVlwrV82JnIksSuNSTcimgPlgVgi9PliMnsaA5IWAAICcL4G0mlpiKvk1Wl+0DFvn8CzqJky5SYtHy5iQjBD0Atg8F5O2KNnotoY/3K9RrId5yf+RsKU8jqc8bCkDlVS/GhNTj+irgaMZ9nkb9jGHd2FySznpSWno=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 16:24:39 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210%7]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 16:24:39 +0000
Subject: Re: [PATCH 1/1] drm/amd/display: fix compilation error on allmodconfig
To: Alex Deucher <alexdeucher@gmail.com>, Qingqing Zhuo <qingqing.zhuo@amd.com>
References: <20200618194936.9158-1-qingqing.zhuo@amd.com>
 <20200618194936.9158-2-qingqing.zhuo@amd.com>
 <CADnq5_NiJyjfS5zhE1zMCXPw9aDUwkXrhrAgpL6duM7OzoVriw@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <6de790c1-8b59-3505-3b51-6c130262dd45@amd.com>
Date: Fri, 19 Jun 2020 12:24:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <CADnq5_NiJyjfS5zhE1zMCXPw9aDUwkXrhrAgpL6duM7OzoVriw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::20) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Fri, 19 Jun 2020 16:24:37 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 77442a4a-7c22-4194-bfb2-08d8146d43a4
X-MS-TrafficTypeDiagnostic: BY5PR12MB4146:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4146B1E745AD2AB2DA2D9F6EEC980@BY5PR12MB4146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IaiYZU1xRGn2iHTt8oZu1qvWS+NtZnihCzENZ0Dba4WeAfouGB1oA4y1+n8L/QtDCSNTdrzBSXUZmrMznTiRY7NH0nUct6Tl/tPvhIDpoN33AXyvCy+qGlnzFgn24wPF0+H7uhz7AjH8+N64YajRHil0pJDevwHYdTZ9zzcOwTSUwl16CTzGmFoBeOR93gQCywpY0ejPDqcrxMiQT429MwqYO3gSFp3P9ulQJR6CZUiL4rjMt6nQjKsGvI558BSMM3n0esL34Ug3Q4gVvclePAo+oHX4lw7L5/yz+Tggklah+lpHn0Q60Ru8L1vzOpO0HeFOQQ2KaMx9/VoLWzCbfKOByXlPF7skO2qzGHot+dtaE1oG4rGVC687UTYbqfKaZx5fCe/S+UFu3Y+XQmf0abLruvXh5kzJ7NfJfGm0aSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(6486002)(956004)(2616005)(36756003)(83380400001)(53546011)(478600001)(8676002)(6636002)(31696002)(31686004)(86362001)(8936002)(16526019)(6666004)(26005)(966005)(2906002)(110136005)(54906003)(316002)(4326008)(5660300002)(16576012)(66476007)(66556008)(66946007)(52116002)(186003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SVgXROjdu1+SULh8/Ple3T9sG4+izLAk2wDbYRu9ERl0WZphi8s8FmG792w7XCn0QXZtAGtROAJyqJeCa9qSUEbCg+adXl0q6uop7p8yV8Q62+k9gIjcOjRO0ICptq2/WKYZMeo5r3xhovYUBp2BLdeiSsU5pggHzshnBqePzTkA8yZxq3KiU/GftM4jNPGmCbSaXpD5yKojiCkPXglNDzVHYzJeafQR9nNW5Rr1YlrwpSSxXJ9KiSXNZHvbzqdTQRKebiL6ACZIwSbFE5YJ5jzL0S3zNovuLR2klm0bFN/ED5AybMNr3KRSiiUW2DG8gil3/5wVyDD0ZRxYAImsdg2VESqRNK4QUhdKhvOM+4IDZ/WwsjYk1yhlgNlIELmpnt1twkUr/V7/RD+gkhdx/mcRMl0J5XsF5N83+lVrLX7h5eds+b2TS/8xNV7IeHD6CSKJv1cXImuGo2d8BhWqFZFevYfXaZzIBiSQFpBlUcRAg4Atj6izCXbfzwM0nUNB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77442a4a-7c22-4194-bfb2-08d8146d43a4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 16:24:39.4185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOeg7qe921cgOg010AcRvlq6kAur5wQLWBWKeIhpKmVqNeS5+dOy78naxGHwjPTPMcTV8yHExRvlJyYWmTJvmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
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
Cc: Lewis Huang <Lewis.Huang@amd.com>, "Cyr, Aric" <Aric.Cyr@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Harry Wentland <hwentlan@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-06-19 11:27 a.m., Alex Deucher wrote:
> On Thu, Jun 18, 2020 at 3:49 PM Qingqing Zhuo <qingqing.zhuo@amd.com> wrote:
>>
>> when compiled with allmodconfig option, there are error
>> messages as below:
>>
>> ERROR: modpost:
>> "mod_color_is_table_init"
>> [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost:
>> "mod_color_get_table"
>> [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost:
>> "mod_color_set_table_init_state"
>> [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>>
>> To fix the issue, this commits removes
>> CONFIG_DRM_AMD_DC_DCN guard in color/makefile.
>>
>> Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
>> CC: Lewis Huang <Lewis.Huang@amd.com>
>> CC: Aric Cyr <Aric.Cyr@amd.com>
>> CC: Alexander Deucher <Alexander.Deucher@amd.com>
>> CC: Harry Wentland <hwentlan@amd.com>
>> CC: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
>> CC: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
>> CC: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

> 
>> ---
>>   drivers/gpu/drm/amd/display/modules/color/Makefile | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/modules/color/Makefile b/drivers/gpu/drm/amd/display/modules/color/Makefile
>> index 3ee7f27ff93b..e66c19a840c2 100644
>> --- a/drivers/gpu/drm/amd/display/modules/color/Makefile
>> +++ b/drivers/gpu/drm/amd/display/modules/color/Makefile
>> @@ -23,11 +23,7 @@
>>   # Makefile for the color sub-module of DAL.
>>   #
>>
>> -MOD_COLOR = color_gamma.o
>> -
>> -ifdef CONFIG_DRM_AMD_DC_DCN
>> -MOD_COLOR += color_table.o
>> -endif
>> +MOD_COLOR = color_gamma.o color_table.o
>>
>>   AMD_DAL_MOD_COLOR = $(addprefix $(AMDDALPATH)/modules/color/,$(MOD_COLOR))
>>   #$(info ************  DAL COLOR MODULE MAKEFILE ************)
>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
