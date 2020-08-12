Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F6CC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 15:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2CB207F7
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 15:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aMntIrxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2CB207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE236E13F;
	Wed, 12 Aug 2020 15:17:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8BF66E13F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 15:17:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnjLTRDUIo9QubI/EDNqiLrEs37DWTUtRB8ilmxbephu52hdzmCAU1EXHgLeXKofL0aqeo0K1U8UEH6DiBIATVRVK4ZmrSyXAfhWtQ9joawnbtT2iE6r0C1q5lhKm4u3aKV4I95KZBEg9kNyKRB9I+/kkmaR4H3Wb6KZMfPUecG7bJjE2IYBIp9OiOkx/R+k+sNfbz5Q7sXHLKhQFZkGkgHLTCcpGkr2aGfvu9Jh/WfE72PqI70Jt6SCiW57rbcEbF6iDJLJ+82brou0Rxru2Pm8QlAq5H70JYOFLUojbZIvk1wkhu9Mapeo6O2WUW0d5qDuY89qyFfVdzMYfevxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUKQ8Zzq+UO5atcKUzysXduQ7gBbfibngl+WtExbLVU=;
 b=DHl4NelsGD5wznIz0fqw7OnO15Mz8ixclCDisk+mUyRw6fudyqrFSZtvB17TMH9BAgUm8J9eajwEAX920mNqsQqWdTvYtW2H5SBP/b8jY46IiNFD4MphD1V3BlMTrwZPmsuSVMs0NwiFutauS5Sad00J3LooH9xdREtnlx7kODcxSCk1zIP6ZJU1JGfmxxxFqnUJ4gmukBTzslu96SlUZNNdZhaGXM8wcAubEFFqBM3VXS7ttt6wxBHs4fVsep9e7NyR/9NzMAQZAXiNP8EbSQWxu7p0tD6W3/Ld++YUccV2xkSOieXDIpY8jedrLWJ7tyGAtVbOHXGdLc/KglebNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUKQ8Zzq+UO5atcKUzysXduQ7gBbfibngl+WtExbLVU=;
 b=aMntIrxZsOuKJ4JD+NAveolQS3Q2kiVGoGrVh+z68E3qCErbzmge/XvZhw/qojXr4SNJLWFWj65nqi5C2m6G6vaipWKy4x261vJQD+E9mtmkL6JtfNWVmfy9YNxmXvrK/Yjdiq5W8b2PhbtnD57fbA4KkTfcSK0nbE1TXNIBy1I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Wed, 12 Aug
 2020 15:17:30 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3261.026; Wed, 12 Aug 2020
 15:17:30 +0000
Subject: Re: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arcturus
 ppt driver
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "Das, Nirmoy" <Nirmoy.Das@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200812122030.215907-1-tom.stdenis@amd.com>
 <6352188c-e508-37d4-a021-02c31e6ca855@amd.com>
 <DM6PR12MB354731EA392327C552D5083BF7420@DM6PR12MB3547.namprd12.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <16c4f27e-7556-dd72-3fdd-8907e52d390e@amd.com>
Date: Wed, 12 Aug 2020 17:20:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM6PR12MB354731EA392327C552D5083BF7420@DM6PR12MB3547.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR2001CA0004.namprd20.prod.outlook.com
 (2603:10b6:404:b4::14) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.5.12] (165.204.84.11) by
 BN6PR2001CA0004.namprd20.prod.outlook.com (2603:10b6:404:b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Wed, 12 Aug 2020 15:17:29 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fab30edf-056d-474d-61ea-08d83ed2d4a1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4313:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB431364737391DF468F73BF6B8B420@DM6PR12MB4313.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X77ICIMg9/2ZUIRm8D8tn9QuWkFlIXl7IjbqN3ZNPyIAagb8fKRuP30NzpGUra6zCjW1WpqLWPbTKlh/xc6EvFy5LQjnlB7A8x0ZWjLvYMdwuAARBHNpZLGonWhk5zQMuHnbOUFVqY06rbugWbMwc5nxcllhd7/5hx0O2Xg0WXTM25QsjBJmoufvnky0OTmTWU6VEa1DA1vMWL14Xu1Hto9L2NqphQfBLhdKYwUQzej5/OAlizd6kx4J4FMpFNg+8ASJgRHLuBXaXxnWKgAztGp5QnUurMx94wmYuHOEw2YBAT6ODi1KmyUegEKDFNrbVC99bL6lImZNiRUPN6HYIPYGPSH8E22Ra1/d2tnGi7he3N6rJUIlgMl1cCC6vIWz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(6666004)(16576012)(316002)(110136005)(66556008)(66476007)(83380400001)(31696002)(66946007)(8676002)(186003)(31686004)(16526019)(2906002)(6486002)(36756003)(8936002)(53546011)(52116002)(26005)(5660300002)(956004)(478600001)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: x1oHo20XbWFNFU/2oI0tCAOpSzsJVtPfyy/cTod7RtsR7kB2hkN+4skP6049fXx3+zNSVui185WJsWcEgb8WoPTRv92q494ytraNXxoEyLl0S9L57YBKyH11qmDkXjMAzUMMgmK4t2IoET16VR2ishcyQE5yFKt7xtwcQ2FXMkxU4Cvo6aomuTJTURh+ZSDagWjm+z1ZNMUJ9T+7KF8ht8jklC5B3ZIDYK5UQEvgq+48CxcPn3Hg6PKJNv0maKH8NjLpoJMBP1watKgsyr2u2QmrTaYKE9ziYGn55gg8zSrzoKjJo1xdDFAs9DQ5EY1G0Hw1ii+OLzkpM6kg8Gsiez9FCi6PfyVTJ5ox3VmXXcwL+HZ4qtall+r3m+o6afB0S3KZ8SevwlJB3rNxXSp/F81qakGfMe2Cp3wRZgIUSramoAiNuwXEVMTqMId1Oth06efQffcKYeboCyXk4C+yIL3CLWZSE4U8IzmoH9h71RNCrEyY9v7DMAeIB5TQAF6lVSfE1GxytK7MJxk4vhnIDNqO8Dg3u8ljKblujCqOYlKs62HjRFJ0OOPXjGlPQX31oevITMJdziVKMGyUZ5DA4HbXjY/mKjuK3x3CuNSefoGk11opki88BrsmVL6mUSmzARYfoxignuPFOpD/3YE6Eg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab30edf-056d-474d-61ea-08d83ed2d4a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 15:17:30.5964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahBEpZKDvkoUvGpdisYQS36NjK+xtNdnVNn8uuJW1gnCkcUvJxpzN4liWQXkh2yVtYjBQaqdiR5AaJ4YMQs8tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/12/20 2:43 PM, StDenis, Tom wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> Possibly, but since the arcturus_get_smu_metrics_data() can error out we =
should check that return value no?


Yes, we need that return check.

>
> (also setting *value to 0 avoids this bug in the future...).


I think caller should initialize the result value before passing it to =

arcturus_get_smu_metrics_data

as the warning is generated from the calling function. My comment is =

only concerning about setting "value"

to 0, which seems wrong. Rest of the patch is fine.


Nirmoy


>
> Tom
>
> ________________________________________
> From: Das, Nirmoy <Nirmoy.Das@amd.com>
> Sent: Wednesday, August 12, 2020 08:40
> To: StDenis, Tom; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arct=
urus ppt driver
>
>
> On 8/12/20 2:20 PM, Tom St Denis wrote:
>> Fixes:
>>
>>     CC [M]  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_ms=
t_types.o
>> drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c: In function =91a=
rcturus_log_thermal_throttling_event=92:
>> drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c:2223:24: warning:=
 =91throttler_status=92 may be used uninitialized in this function [-Wmaybe=
-uninitialized]
>>    2223 |   if (throttler_status & logging_label[throttler_idx].feature_=
mask) {
>>
>> by making arcturus_get_smu_metrics_data() assign a default value
>> (of zero) before any possible return point as well as simply error
>> out of arcturus_log_thermal_throttling_event() if it fails.
>>
>> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
>> ---
>>    drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 12 ++++++++++--
>>    1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/=
drm/amd/powerplay/arcturus_ppt.c
>> index 8b1025dc54fd..78f7ec95e4f5 100644
>> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
>> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
>> @@ -551,6 +551,9 @@ static int arcturus_get_smu_metrics_data(struct smu_=
context *smu,
>>
>>        mutex_lock(&smu->metrics_lock);
>>
>> +     // assign default value
>> +     *value =3D 0;
>> +
>>        ret =3D smu_cmn_get_metrics_table_locked(smu,
>>                                               NULL,
>>                                               false);
>> @@ -2208,15 +2211,20 @@ static const struct throttling_logging_label {
>>    };
>>    static void arcturus_log_thermal_throttling_event(struct smu_context =
*smu)
>>    {
>> -     int throttler_idx, throtting_events =3D 0, buf_idx =3D 0;
>> +     int throttler_idx, throtting_events =3D 0, buf_idx =3D 0, ret;
>>        struct amdgpu_device *adev =3D smu->adev;
>>        uint32_t throttler_status;
>
> I think initializing throttler_status here should resolve the warning.
>
>>        char log_buf[256];
>>
>> -     arcturus_get_smu_metrics_data(smu,
>> +     ret =3D arcturus_get_smu_metrics_data(smu,
>>                                      METRICS_THROTTLER_STATUS,
>>                                      &throttler_status);
>>
>> +     if (ret) {
>> +             dev_err(adev->dev, "Could not read from arcturus_get_smu_m=
etrics_data()\n");
>> +             return;
>> +     }
>> +
>>        memset(log_buf, 0, sizeof(log_buf));
>>        for (throttler_idx =3D 0; throttler_idx < ARRAY_SIZE(logging_labe=
l);
>>             throttler_idx++) {
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
