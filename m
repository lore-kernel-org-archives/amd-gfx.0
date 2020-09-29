Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427DFC4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 18:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B099020789
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 18:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mSRREUSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B099020789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0722489A16;
	Tue, 29 Sep 2020 18:59:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 799B08997E
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 18:59:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXHjmwILWuzo6R7iauTQwqALEHnz4wmfmzHYVKuXXctABYS37Aw0pbFqSdZSLEfVzkE9s10qaIjWW2MSOb8yZ0+sPkfVvT2+Hxh2EEM8clsbGaihIIwCKcvkUz4W/sttqJP3VI8YiqR1bCkFXBRfIc9qL7drRjRQWWn7TY2dnu7aFp/eYcUmLAVXMr8tAIEg4bw3SBn493lrpmJAUdncD4TSYSWIUJtRASZYPZ0mjK6OllSTnznX1krPPDe3YA2F15fq0i7jFwuUtw+1o+1dFEcBPQPOSxex10LwGsMfjW8E1EGYMr/4wbqLbCeMd69rObEwVd7sgMRCOdQuwpl+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwrAp/jWXAcOxUvAofEkod56f71ISBG/vQO6z6/VD+g=;
 b=ezIuI3fq4B2jCLwnS8Xx8TrpbEcc6a3Kyj+3gcAFBDWu/9AsmC4JYLTdJ2XDv7+8Lu++0CQzoYwO1vuBQTq3JF/bf4BDhOWjSop6DthbkPvNMiFrrXrpGRv6fglWuauZWi3AtKOY9DY+J7vr0smLQFvbEg43Wgkgh12NrHrMFFh3zV//VGULKwxi5hAnYYZKz5iOKvGtQTZz5P204WuVbj4fT3gb9e0cx9pfb/Y9AaSPKQ+cM4xrCqh8k9oHoIwlDR3tjfqnSn/njhQ+1g4qtDGQV3P/XH0pqczbH4jGQ1RvWCJFXganT91ZTQVtV/8HD2n5oF2u55I0bPUyruj2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwrAp/jWXAcOxUvAofEkod56f71ISBG/vQO6z6/VD+g=;
 b=mSRREUSJfpKSZ8zzkEcPseTQxJC5TZH7FRFUsl2u7xTUz3BIKJ4qaiMkH7ZmntVkIeG+GwyRds/En4tGExrbsI3KYlPdY45AioGlkRJy23VYOwMfm8OPtUgRfv4EVBU/F/2aDa/xmFwMMHecQ1DAuWudY78j0EadimiOm3AqIs4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1867.namprd12.prod.outlook.com (2603:10b6:3:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Tue, 29 Sep
 2020 18:59:13 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 18:59:13 +0000
Subject: Re: [PATCH 05/45] drm/amdgpu: add vangogh_reg_base_init function for
 van gogh
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
 <20200925201029.1738724-5-alexander.deucher@amd.com>
 <56f74006-5a7a-c4a6-26e1-1a51cc0be1e9@amd.com>
 <CADnq5_P7P5zTLueV0GwVifo8WXctTCPzYh7CcpmjDet3kM1Vng@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <26b8665f-1aa9-21ca-b5b6-2aa395affd9b@amd.com>
Date: Tue, 29 Sep 2020 14:59:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <CADnq5_P7P5zTLueV0GwVifo8WXctTCPzYh7CcpmjDet3kM1Vng@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend
 Transport; Tue, 29 Sep 2020 18:59:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8becb6db-3061-4cbe-0907-08d864a9c029
X-MS-TrafficTypeDiagnostic: DM5PR12MB1867:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1867772A7AD7803DBC6FC25299320@DM5PR12MB1867.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgJFo0UGW1bFaMT6k18d9H/C3jjiA31+Jc7W4V/u4as1ciEdZ/HWVXat2ah0cEN3nNg5e4uEb3glNHAmfRhfGfZStIvb+e9ScgHgIPMKh980Na4QFbm2SKqHSHz5kDTVWl8R7yCWslHGILB9TBp7Rxk1x25IHuIXCuhK6Iqw+l2e6Wb181cFJTpe0V/2CSxn06F7QW1U+1Vr7mLdGuwtyYNzXsKS6QglkIOP3cKzpHRVj0vFbT9wnQIx3q+nqQslJpXdH8jNXBzHBmBbxyzPq6DqqOh5t/xZtYPXbnAc7b4qo6DQYkpw00HgSFom/DMM5ImGcxLn4u9MYdPJr7RlsfMIEftUqaAJbGNkv3/4vh0vwHrWhI/FMCMfw4cxrK1hHoU8rI2Ytc2quNd9Z9lgaxANMtfu5UN04Xn366Hy6+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(66946007)(44832011)(478600001)(54906003)(52116002)(956004)(26005)(53546011)(6506007)(86362001)(66556008)(66476007)(186003)(2616005)(5660300002)(316002)(16526019)(31696002)(8936002)(4326008)(6916009)(2906002)(6512007)(31686004)(8676002)(6486002)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: L4Gm8v9/DczQNrSSUVQFnKSPmtTT7HSlYD2kLK/wuZ1m/HGcNgGTcNtI+zFA3T1/KYTiWh8HXzerH8jHtFHQixKtJIJW4lI8UBz0+FBPwPSwB9e3ticCKLze8vBOjSIVacqI76Vub8LSN94QsWmguxsBHgVFMcDDq1p9Si/4iZx9z3OzR8oCrrYH2l3FunV0vQoutbq4FGD8anBu2nXy9scwZ0625q1RXSo1KpjYGT/9bKqwyabDWMJrrKnyUAh2KAhgKHDXa0SzU7QjmNRsAwf7AYTsJc8oIG/RKHYR+vhY2adeidSEdC8s4PkUPXQEzK+JqAr5M1tUZFe/AGCzWg50hw60gbt+kDQH/WszvFrwYI9FRnMSWRWJ2tFFe3LcW5ArevT/IJ1O71/xna+7BqrDuSxykOVd6l5dMPQEMOM08ZNIaaq5LAMOm/sXXWkr0dITXVc1F9MZlsLObdDnRBVr+H7nk6/630KlKxvUbEAojJnS0gfPdc9mlIpJYqwWQRMjy2qYC07ymEUwIzsmXwwFpnMtjcV1YhfsRoLJQNG+qRygJpnnScUl60DaCJflyD14EIVJ2KqLJ9V+TjhHrDEvEvPrQxPmGRiYSE43ijSYNoP/AoQuP+a6o01p1H5yWRbSLOipG6enxiLdGuP3EA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8becb6db-3061-4cbe-0907-08d864a9c029
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 18:59:13.0098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJu1GtrbVSHQKQuNoCLuPQEJp0Wtibl5J5yWlRENedC1Jh04bHjtR8suANaA9rBM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1867
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-09-29 10:57 a.m., Alex Deucher wrote:
>>> +#ifndef __VANGOGH_IP_OFFSET_H__
>>> +#define __VANGOGH_IP_OFFSET_H__
>>> +
>>> +#define MAX_INSTANCE                                        8
>>> +#define MAX_SEGMENT                                         6
>> No. No "max". Use "num" instead, as:
>>
>> #define NUM_INSTANCE   8
>> #define NUM_SEGMENT    6
>>
>> To mean, the _number_ of instances and the _number_ of
>> segments. (Their count is a number.)
>>
>> A "maximum" (similarly "minimum") value is an _attainable_ value,
>> i.e. something you can get, use, etc. But array indices are 0 to arraysize-1,
>> and thus max instance can never be attained.
>>
>> It is the count, the number of instances (segments, wlg),
>> not the maximum instance. The maximum instance is 7,
>> the minimum instance is 0. Similarly for segments.
> Valid point, but this file is shared across components so I'd like to
> minimize the differences.
> 

Is it possible to educate the organization?

Is it possible for knowledge to flow backwards,
i.e. from the Linux team back in?

As a mathematician, this really, really bothers me.

It leaves traces of badly named objects and new people reading
it would pick this bad naming up, and experienced people would
either be confused or find it incorrect.

Let's fix this at the source.

Regards,
Luben
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
