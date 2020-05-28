Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B01C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 14:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A802075F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 14:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eTboarIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A802075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B6906E578;
	Thu, 28 May 2020 14:13:43 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680041.outbound.protection.outlook.com [40.107.68.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2A36E0A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 14:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYDOhbx2BcaxHD3+GrOO7iviimCg83TI9pqfKDEgb2kb4zAMxKxiNt99NV1IPdt7Z+OylYoQqtwPResCmvV6rrRvTOCYsivr2A7VAYtyjeqIsTmlTSBDqJEU0UUum3ZWIqadN18X+lRwiWH4NGGWPca+Jmxkgw0DTitAPP72JtpjjJf2q9v0HNoZtpLWVCUrIUo33fSmsCcGGaX3LCIqykYeWU6mkVaa4FxwtQ8k4zmsDM29iaOptoY82jY6q3F/3IcG2s5B49ETCcpsncRo1EEJZABRcy+FKzuQlaTPN0M6sqFEqH1tmEUYJwDp4zxvbG854kBg9ThrOTGpDTJwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUGX4ep8hJ07ota21+XoyTkdKq+Fz31UiymAujwrLgo=;
 b=jRh5MFwNnYUaWCw9R/tILN8m7wtKbfUnn+kq3NYR0IycCmwIk2rLmaSTdDk2Md85hScuojbEkTj0aUNj3eg8Bu2kjiduVcT3DudJ/vn9UO5w8Yscta2vIFoklyWVXTloq4RCUv3Zg9viLa/kztemwtZeTNz1BLsXAmT3vVuVSDLZ+KFaFZfYc81o1zn/l0Pj+Es4d2pNSVliPxjUGzTn6ZXN+mHBfVWS+CnqNDDM3la7Dxum1jFJTZwiMmlh9d7JKbRkU+4LTyAmiZGULZk88UqPJw+I0sxyxw+ftEq8oiZLIlJjo0TD7BmQ7zlv7G62nBWAQd1xRQvVBlGM06kXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUGX4ep8hJ07ota21+XoyTkdKq+Fz31UiymAujwrLgo=;
 b=eTboarInC5K0XYAlIra32jRx7zc2YR7CtDJnUHGRYI/5XNDItX3MnUb9cg55uYXXDfVgIPfwvpDGWoi24iOAFjG0D+U8gOPBtKTitz5sPOv3Gf9AO32aqENkbzwnmS5vkrJz3VjiGdHHea5mg+92AD8umBWdM5jXi0w4/bYE5d0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2872.namprd12.prod.outlook.com (2603:10b6:a03:12e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 14:13:36 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210%7]) with mapi id 15.20.3021.030; Thu, 28 May 2020
 14:13:35 +0000
Subject: Re: [PATCH] Revert "drm/amd/display: disable dcn20 abm feature for
 bring up"
To: Alex Deucher <alexdeucher@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20200528134807.5665-1-harry.wentland@amd.com>
 <CADnq5_MoT580EM=yO_Oib17Y0T9xghnnADmanRr7gnTsiY6OTg@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <95b64607-a2ce-66b8-078f-8fd1e5ea9bdc@amd.com>
Date: Thu, 28 May 2020 10:13:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <CADnq5_MoT580EM=yO_Oib17Y0T9xghnnADmanRr7gnTsiY6OTg@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::11) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0132.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Thu, 28 May 2020 14:13:34 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3276181a-758c-42b1-658a-08d803114f64
X-MS-TrafficTypeDiagnostic: BYAPR12MB2872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2872F140AD0C9866B6FA16A6EC8E0@BYAPR12MB2872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:164;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UrLOiEYiCEcxmGqO1xgkOBmzDKf6jJnkDjjrn/ATZvi/tVNUFLAEEKqxCSFx9FMgByG+bLwHcmUO4QEOQ2DlfzZmxbv6lfhcA01pweD/H2rNK19d7pwqynhyDLq5AantPUKEjZYnblN9Ez75Abx2X/6ToX+LZyiVwcmaFzyE4WjadzqyZ1SnUp+2RS8gb2nFZAxDBkZr3WfIY2cKJmRNd/SDzBWBrmTY47qRHgQPHB4ovS9Abe6seZbB20gLTtoiwjliLrZ0xBBVkCmpCk46rSVow+jaC74ojO/ZEUTDe3HBT5QYjrbmbtobn0t45NW6i7w72zb1n8n3E7MiURUBLmK2KOtWH/nKz+29/eRvMO9/SIwwv5Eal9tjL6iyIONexrhXx4J9qniXFDVkO2UCr14ypyDNkncVjdHhlozQE2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(5660300002)(36756003)(83380400001)(6666004)(31686004)(31696002)(66476007)(66946007)(6636002)(66556008)(86362001)(2906002)(54906003)(8676002)(52116002)(8936002)(2616005)(966005)(186003)(16526019)(16576012)(316002)(110136005)(478600001)(53546011)(26005)(4326008)(6486002)(956004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UxecdK+XNKZxF+go00PH9HkcFCNw2TimLDO3KxqnrC9F+GyQF59t96PHm18gjd9EG+6Bw+4Rl0+3WN77ku+ArJ37c7Z7/No9aUyuSKvM+Us/AnFADfLZO9SVvGHDagN/94yAvTQBWyvd2lVzm+01p287C/x+eaahqOsCy6J/cpfkOJRT81kRoYR1wVLp5BYI7MJ39Jp9yfzBwe0GvpDEsiAY7r37HYtbAeTBA0dnDzxWSsLMpcmgH/hLBLQgp9h54m5bqN0sZtMLrE/nAUOMlFtYOkufbKq0ZCCpstvkFMt7Gtbvq0Ndk2lsQWHKcXjryPbnq/tOHs5xkXC5TlOyw2SeQJvJYfig27chlWI3EsP3Zv55U8ZSqbZPH7/5aN8b+N2pZWEXAKsplxgLotnsD87hbOXa3kqEK94GS3g4H4tXSs86Wp1wQhXgHCDyEApR4xTv6Z28zRgNYbpFfvtinmEoTyB99RA2D9vul6uEE+yybqN3CvgQ5K+RtDXzBihF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3276181a-758c-42b1-658a-08d803114f64
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 14:13:35.7040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsUYSWFRzp2L5oXcnYp5qyaw+DkJLHNLhU3YfFX4QBc0jlijeOOO83sye/UlLAD5/fW6aKk93Ol3ErbVGapMkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2872
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
Cc: Hersen Wu <hersenxs.wu@amd.com>, Alexander Monakov <amonakov@ispras.ru>,
 Anthony Koo <Anthony.Koo@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Michael Chiu <Michael.Chiu@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-05-28 10:08 a.m., Alex Deucher wrote:
> On Thu, May 28, 2020 at 9:47 AM Harry Wentland <harry.wentland@amd.com> wrote:
>>
>> This reverts commit 96cb7cf13d8530099c256c053648ad576588c387.
>>
>> This change was used for DCN2 bringup and is no longer desired.
>> In fact it breaks backlight on DCN2 systems.
>>
>> Cc: Alexander Monakov <amonakov@ispras.ru>
>> Cc: Hersen Wu <hersenxs.wu@amd.com>
>> Cc: Anthony Koo <Anthony.Koo@amd.com>
>> Cc: Michael Chiu <Michael.Chiu@amd.com>
>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

> 
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index ddc979e3eebe..acd4874e0743 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1356,7 +1356,7 @@ static int dm_late_init(void *handle)
>>          unsigned int linear_lut[16];
>>          int i;
>>          struct dmcu *dmcu = NULL;
>> -       bool ret = false;
>> +       bool ret;
>>
>>          if (!adev->dm.fw_dmcu)
>>                  return detect_mst_link_for_all_connectors(adev->ddev);
>> @@ -1377,13 +1377,10 @@ static int dm_late_init(void *handle)
>>           */
>>          params.min_abm_backlight = 0x28F;
>>
>> -       /* todo will enable for navi10 */
>> -       if (adev->asic_type <= CHIP_RAVEN) {
>> -               ret = dmcu_load_iram(dmcu, params);
>> +       ret = dmcu_load_iram(dmcu, params);
>>
>> -               if (!ret)
>> -                       return -EINVAL;
>> -       }
>> +       if (!ret)
>> +               return -EINVAL;
>>
>>          return detect_mst_link_for_all_connectors(adev->ddev);
>>   }
>> --
>> 2.26.2
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
