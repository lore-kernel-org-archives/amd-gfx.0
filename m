Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B8EC4742C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 15:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FE820659
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 15:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YYWPY7er"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FE820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D70A9892E7;
	Tue, 10 Nov 2020 15:14:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64803892E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 15:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQBxmzLhbmTjLwquCb76rgxnAh7cJHsRpct4yI10D+Kx2lhhFXp9CjoxywouA/ZLTSeqsGciAMAJRvcauAX4vUObyyGXPzF5jQwRqgt7uSQIEGsDI4hTa3jKHsKfFF0RsebK/AHdLpEwfPuqnOs0ItQ3xXUQKGS4gDCjONrzMP/ZysSndn2tETVyHaeJdg1IPdSfxj1rnv/cXmQ0x4BOJ/+HGyrd92FgcLGiKcCGP+ct7UfW6HIv3m1JzsNlzr0l38J1q6Tzb0tDz962DODll5jTu9auCQrpLGwVgofpqVt3OihI3H+G3JjY3A6T2U2WuKdKFPjoenrNbyZRqKRBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z64I9+IfsHFWv+0u45fAU37Sa5tQcSGdSGt0L6541QY=;
 b=I6hksFkfS+1n2rcHJkGIBJ6IvaJwJerRnNx6kCMJkHJ0J/7dxurNSHdveY6bVv+QGw++ucjlDK7vnv+Irb8cPHOaR4FL5NF+m5dGnp1gtM8Y7jZOz8TBew0bubrULfrZ/lJ5us9JGkoZcvAliddNcle2wtJLtrpZOuRq2kEUszjdhlnhnlcnSSZ8Ztl9P5ya+rPHIadFURuq4xkrJyn34PVity5qaqV7tWBXr8LkfQRqV+6FuKgu7jKO36NSNhNLFCpjyYhviOee/aj0jQceF1gydFQkNBzHL7vu7N7i5Lfw3KnvyRiR6mHhNeihQHF32+i14O+DjbOtEhtClF2WSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z64I9+IfsHFWv+0u45fAU37Sa5tQcSGdSGt0L6541QY=;
 b=YYWPY7erw+3xyVVX7Yw441V3HmBs9dP/2YaW1RKqXTm7vlwE+1JkpNfXN9VP/ilStTc54B07xgGcwmNJIIv9O7ShrWj2UMOqj4BDatKSAd8vZfkvCGoB8RZpM4MtalmFBRUoZ+x3xEdYUHtqrYmAANVdU6Gmf3OlLVmnVncUPME=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1195.namprd12.prod.outlook.com (2603:10b6:3:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 15:14:38 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 15:14:38 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: enable only one compute queue for raven
To: Alex Deucher <alexdeucher@gmail.com>, Nirmoy Das <nirmoy.das@amd.com>
References: <20201109181214.35540-1-nirmoy.das@amd.com>
 <20201109181214.35540-3-nirmoy.das@amd.com>
 <CADnq5_MPHDA-SQoFcFMuuODDB39J=jEuq4pUGhC1cD2SAv7RsA@mail.gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <0d51382e-d90d-75b2-60af-c9c8a806409a@amd.com>
Date: Tue, 10 Nov 2020 16:14:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <CADnq5_MPHDA-SQoFcFMuuODDB39J=jEuq4pUGhC1cD2SAv7RsA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [217.86.115.160]
X-ClientProxiedBy: AM8P190CA0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::16) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.115.160) by
 AM8P190CA0011.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 15:14:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c270f1f0-8421-4402-2cbd-08d8858b56c4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1195:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1195D326D52426ACB772EA1B8BE90@DM5PR12MB1195.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +CA/H6yQqSZgcB6gv5hVbZxdIZDRIm4BnLOG+73VY6lxR0383N2Z54sgxAkzYyYm25bfUis8fbjov4MMKef0jIinDN6hzk751BCCTbG5rTj9Z7bdhYmCg4M3x2V2838U11mlsAMN0ugfhA/nJOSnws76x3rLM+EakyIo6+A54P81GbgCjL2w+xUPANaNVwiiozLZYH3kQ03rNNWmY4cJK4ZBa9NCvMc839kHTQsr9fH1cuCUVPRH7PvPGPJPfRovdJI9Plo6i0SbxQuHhKiSUoTUkL6GkU73cBA819Z1E+H//3lqaJoaS8P0ZyIF5C1KNmOuOJh1bAM691Iou4j1sxI8qIWbA79j1hYbDbiFAMnNcprZS2L5ezbeYd+TMIWpZvnNW1lRrUwJFecWVwZtglXzZUyQf4FHlh/kZ3Hqpbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(36756003)(6666004)(6486002)(4326008)(66946007)(53546011)(66476007)(66556008)(8676002)(26005)(54906003)(316002)(956004)(186003)(2616005)(110136005)(16526019)(16576012)(31696002)(478600001)(31686004)(45080400002)(6636002)(52116002)(966005)(8936002)(5660300002)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0lKhqes+9xxLTZ6Fpfdx1ZutP7GQCxi7RXqRpExvPpWZV/9/tMFvXB3XXDQYwZrHUjqd8KNXb5N4eeviyHgEWEFJD+XCGymW0ChbP2bXomgfV1fxfRkxX8zYJ/fcSE7X2lyFVTNz3rmwKlmcqh18z/K7+8gEaK4pEyDmiVDhcqRtlnEn4ULIE8fb9/O9uDLV7vWpB+HVe0bxQ6CvbPcBOP5VaIHDSUwrg+waTreOyWT7cu07e1L4IWKBXcWSSFaTuguYSJrPsx+8Wxc/eKlqOrJM+ZLv/1kkaIhbcj1/fc0tkxWZfRY++KeCzXMFdx50MvGfx4fa9xWQC8DgNm7b0KzuNRYo/b34DNNtSvhofJ8HV+f8j3WPMvDut9jZiaPwyzmBPnejDehuNdH8t01FTzrwTVH9JSiQc6fx65cClRMvykpe4FXsDAOT5NKTg1+cEtjON/xGcUp/64k7zp5ai0bnFfcgFl3KJoKfuT9fZVV/53gDs1UQIjRFH1vIuoBE4v/KsYxN2RFj6lAJr5kb/94rfRQytQiMJ5+405Jk6yyPdZvZmsWMapd8U7oGU+UNJl+t51IWcQ6unGLx0AnmL1DYZqE+ems2Ldua4OsP0SWFbE8DJsIqvVNARW8F6GX4hjsPiSrnItefsI7KKrTlav1SJvdHgwuV3LDn20D54NXAKJaRbGyjgcR6KEDgrulTIAYGli4QFLzlsrzzn/zpbI0/q2+Dqs8HlebCdLTuZiyuTtwcxoOFkidqTsXQX3TM3KO69gUW4HvePJCVOu1ivx2FJmcY2cMK8G/fN7qvOy8z+tZmIVPI9Cchpz1Sqhb3DqF/curLYQEEmMVq1W9YE/nfCvN2X/xtrMFmjkjj+Bo29oxVSE0KaGQhVhucGo8hFOEWz1zTzipMuVyFXzHSJw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c270f1f0-8421-4402-2cbd-08d8858b56c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 15:14:37.7899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtNDxZq9PNdj7/IgYHSlWzpq2DR2bp/NN4uI0pqjFNeVQ2JWxVlIPWkH/S9P32fkoG9Q9KhuDTfUvoBfxp4xUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1195
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>, "Kuehling,
 Felix" <felix.kuehling@amd.com>, Aaron Liu <Aaron.Liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 11/9/20 7:57 PM, Alex Deucher wrote:
> On Mon, Nov 9, 2020 at 1:12 PM Nirmoy Das <nirmoy.das@amd.com> wrote:
>> Because of firmware bug, Raven asics can't handle jobs
>> scheduled to multiple compute queues. So enable only one
>> compute queue till we have a firmware fix.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index 97a8f786cf85..9352fcb77fe9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -812,6 +812,13 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
>>   int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
>>   {
>>          if (amdgpu_num_kcq == -1) {
>> +               /* raven firmware currently can not load balance jobs
>> +                * among multiple compute queues. Enable only one
>> +                * compute queue till we have a firmware fix.
>> +                */
>> +               if (adev->asic_type == CHIP_RAVEN)
>> +                       return 1;
>> +


Hi Alex,


> I think this is fine as a workaround for now, but it would be worth
> checking is the issues are only between queues on the same pipe or
> pipes on an MEC.  E.g., can we safely enable one queue per MEC?  What
> about one queue per pipe?


Guchun/Aaron's test machine with a recent VBIOS(113-PICASSO-117) seems to

pass amdgpu_test with one compute queue.


I can reproduce the compute queue hang even with one queue.

With all queue enabled, the issue seems to appear much faster.

So I think those above cases won't change anything with my test

machine which is running older VBIOS(113-PICASSO-115).


I will try to find a test machine with latest VBIOS to test your 
suggestions.


Regards,

Nirmoy

>
> Alex
>
>
>>                  return 8;
>>          } else if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
>>                  dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid parameter provided by user\n");
>> --
>> 2.29.0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C5fee9c8359df4f41653508d884e162b3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637405450853281240%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=EKGmSryJhXMhWpo2XeT%2FTThcuv99%2BPAZ8MV%2Ff6sgmfo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
