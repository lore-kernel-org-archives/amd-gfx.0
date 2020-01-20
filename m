Return-Path: <SRS0=J303=3J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D960C2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 15:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD420217F4
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 15:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="caiRfOnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD420217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5306E9C2;
	Mon, 20 Jan 2020 15:39:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F30996E9C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 15:39:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKnaTsuXgskQhKn/QyCAxMbdCLgFhXBL1OH+QojOjZ2y8QlCHfMWFDGSrYdjflaPdzu+CjIGnLkgblsGwakIPmmZI7BNAjd3v5qD/iYdXXlSrW6cKHmQBws62kvKWA0W/tTfPomrBrkEL770A3EGV/TR5ait3m9iIkWiv1wqH8ai8VDxbO0v0gJ9HbEDKaxqsWLHcMUdVtj8SGRPGZJakv5wogT5PiTtikInrqduF48n/fNBIudBEfWwQ7FBUTlGMzhmUqg4WXI0NCDXloY2lpVeRjdXpUC9jwT9IJsR/D+GjIRdTtx2XValsuiBPLk9GtRB0hJiz9RqqDCC5AGj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZH0i9chd06hqNREr6nK0s+WlNUkve4HMJNDi5JOQkc=;
 b=BVzwGFIgV24we+e/9/H2mQrVcj/HketVHpqZ7SoilgR2ZoyBUejlHLm8uY7QhwfIig0J5B2GR13ZpP/lk9Q8pZB8sFd9QV7db61+8fM4pliFADkn0mlkIA9kHKPH2NbeRpT8YGsaP5JpA8Y1YA60nHqOJQSJaXBViZbCHtrPfawR/ZTihUsCAYGuHtmR80TKOdpeV8FLeKsAX7jJBJ4mvVfb4ELpspWfutd2sxwYvcZffYzYtwXg6RAt8A164HOnWvX9Ot+n3ypoBd5ofiEkm0wut9H3U3rhN6TmwxXkvZoOc5yo5kiIgc3UDFFupNo+v6wzxml5q8PLP0p2PEkrKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZH0i9chd06hqNREr6nK0s+WlNUkve4HMJNDi5JOQkc=;
 b=caiRfOnL2tplikaMrpxxViUV8kz+WHnJowsakM2j0r02mpxtqjrmehvmB0CYsDw+d0VMPQ+Zv2zNhg5MN0lP3yXnnc5ku8ZB151SICW5l4OzrxkE4OcaMxSJeyh2ftsWFWRktRDnAVQvX+fawf3d8S1nbdaJa9CIMU3pazpSh/Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB2940.namprd12.prod.outlook.com (20.179.71.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Mon, 20 Jan 2020 15:39:56 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 15:39:55 +0000
Subject: Re: [PATCH] drm/scheduler: fix documentation by replacing rq_list
 with sched_list
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200116144320.109044-1-nirmoy.das@amd.com>
 <cec773a9-8040-ee55-c73b-f7165a117696@amd.com>
 <8080c3c5-0d8d-5f85-011a-1edf4074eda9@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <97e0f042-e6e6-0d62-85d2-dec4f2434c5d@amd.com>
Date: Mon, 20 Jan 2020 10:39:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <8080c3c5-0d8d-5f85-011a-1edf4074eda9@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::38) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.55.250) by
 YTOPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Mon, 20 Jan 2020 15:39:55 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: daaadb27-1fd9-4724-f8d9-08d79dbeffb3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2940:|DM6PR12MB2940:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB294050CEEAB8AF5303EA29FE99320@DM6PR12MB2940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(199004)(189003)(86362001)(6512007)(4326008)(81166006)(6486002)(956004)(2616005)(44832011)(31696002)(66946007)(66476007)(2906002)(66556008)(478600001)(36756003)(186003)(110136005)(316002)(31686004)(16526019)(8936002)(5660300002)(52116002)(81156014)(26005)(6506007)(53546011)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2940;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tIpaA01fnFW2xKSBtYMoJA3Q+ZIrdGyRIzxcndl9JOmNCubdDREeXS58XOC9OkJ/y5hdGQFX34nKTb92n3kAHn1nir4LQO3/HtEd6ckhjAo6HrYPxsdbqddcW4Fdp+OAdqY4A/zccWHqnvLYICgRs9YHIBH69D9AuhvfcIb/3iBOJohCxqsdk5AcPEk1C0cq4T7Tre+YpBtcLmnaJ/MvZ48wyk2GEm+5kxoUAh7pG6g/WrAiRgGg/g4ax1Hz1Wc2FqXONJMcwm8NMAf2iObOeod6x+X4dX2Sv4nOpFH9FASIScCrFwh+225GwbRWfa1lJWFoNLrmvmrMs4Fq69Fr7FiPByILrUFEHIo84HqGAGNkIu8emXkjIrL6vgYZEzfUX8upOo4DJ8PgEAOpZMSIvqUS5M5EOuTJMaTofOIZMqES9oFanb6EjMHsMWNHXjP7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daaadb27-1fd9-4724-f8d9-08d79dbeffb3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 15:39:55.8264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dg30b9dnjpXlPi3PpQTATucmgAqMepYG1LlJfFyLwDIE904vC4mpc2NvCKNcrhRe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2940
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-01-17 5:59 a.m., Nirmoy wrote:
> Hi Luben,
> 
> On 1/16/20 6:13 PM, Luben Tuikov wrote:
>>> - * Note: the rq_list should have atleast one element to schedule
>>> + * Note: the sched_list should have atleast one element to schedule
>> "atleast" --> "at least".
> Always a tricky one to catch, Thanks!
> I will create a patch and ask Alex to squash with this one.
>>
>>> - * @num_rq_list: number of run queues in the rq_list
>>> + * @sched_list: a list of drm_gpu_schedulers on which jobs from this entity can
>>> + *              be scheduled
>> I had to read this a few times to understand it. I wonder if splitting
>> it into two sentences would make it clearer:
>>
>> "A list of schedulers (drm_gpu_schedulers). Jobs from this entity,
>>   can be scheduled on any scheduler on this list."
> 
> I don't know, both feels right to me. Please create a patch if you think 
> this splitting makes it more clearer.

Oh, god, since you're submitting a patch to fix "atleast" to "at least",
it would've been good to also fix this.

But you chose not to do it. Sure, you understand it, but making it more
clear, surely shows attention to detail and thinking process. And it
would help others to maintain the driver and contribute. Making
it more obfuscated, by bunching up what acts and what, makes it difficult
to understand.

I had to read this sentence a few times to separate the entities,
what acts on what, in order to understand the description.

Bunching this up into a single sentence, invariably makes
the documentation *more difficult* to understand. Breaking it up
into two sentences, makes it much easier to understand. For instance,

The first sentences describes a single object: the list:
"A list of schedulers (drm_gpu_schedulers)."
The second sentence describes the jobs, that they can be
scheduled on any scheduler of the previously talked about list:
"Jobs from this entity, can be scheduled on any scheduler on this list."

Why would you refuse to also update the documentation, as part of your
spelling mistake patch, is beyond me. It only makes sense to make
things better for other people to understand.

And this is how well-written documentation dies.

Regards,
Luben
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
