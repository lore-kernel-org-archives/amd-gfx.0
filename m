Return-Path: <SRS0=VV5o=DU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECC3C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 17:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FDF925313
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 17:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FluUNfAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDF925313
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6785E6E16D;
	Tue, 13 Oct 2020 17:04:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 315426E16D
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2020 17:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haGRIH/1DSnsiG/WCrzlo7Gzzai0ceyJZzYtW53OBrJCXqgVvAjP81R3i0Bksr1bRD8+3+ubBLcqOtB3S6PpSRoJncXnh32Oo5NlV8R86ZfXdw2l/bnFKn0scB0HV0b5M2ZoIkigru99VLZqAIzYok/QdgdKaJqxBztRKwbJa9bCywew8kiLQ5JQGyyM/7InZzgbhHiFWBNX/IaUu2/EbAL7QZB3pIx2bxSO9BJlvZXMY2ruJIrVH24FRojUoQ1u+sz6vxLxlbOMqxaVHUEFrY8oJeU/wAfAsZfaCS0jGSVox2kaLhAP9quOs5CQurDCn8xZJo8eq+8OpqCi6axzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1P0CT2PUCSnGXuoleiY3Zl4JkOe/n/5F5J3+kdqGJM=;
 b=TFtSXwalNrRsKrWjerlQRTHmb4vENJFmKPPlhVSkZWOgQRFC+/X+8M7aQzPg05M5ue2tgz/Fq79SNG7L+IvbccFwB3VdhBnMBy0tSPPu4K/VPLRCw+JiHlsUWGEkilzbXGJrBqc+Vh2X3REdmmonJB7EP5AV+EIcwd2gsP/qOwc4Ien2fH7yfoSRB5jNzkx/aEgIIVhcQagxz0HwsoVIUwpmLGPwbPMCyvk/u+IEfr0J2W9aYmEVWc0mfrhHKCWWWeI0A27LP0CFH8/jubCT/7/6DGyssAR1w9B8AcQKGtt3SMmXJmUwp1NGxLpmkn03v/U3WQ1anSpPhLJ9RJMjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1P0CT2PUCSnGXuoleiY3Zl4JkOe/n/5F5J3+kdqGJM=;
 b=FluUNfAxlCwPNq6P93Z+en4L6R/L5MPikI3cglOohTMVOsWW5+RwtfQpvSDJgw8n7rKBCejrYs+HSOdUtIW89tKgDh41GpVKLZb9c1F6cOthyrVR2ZysZYjItxM/HrxDiv9ENOi9j9hVglRi6tZeI99NyRgxlNgQ1SRNbxmVyao=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Tue, 13 Oct
 2020 17:04:27 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3455.030; Tue, 13 Oct 2020
 17:04:27 +0000
Subject: Re: [PATCH v3] drm/amdgpu: Add debugfs entry for printing VM info
To: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>,
 "Patel, Mihir" <Mihir.Patel@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201012090159.28825-1-mihir.patel@amd.com>
 <d2d63bd0-61a0-33ce-67da-78143412d6b1@amd.com>
 <DM6PR12MB44527C86830BA20463BCFE6BE8070@DM6PR12MB4452.namprd12.prod.outlook.com>
 <64b13a59-f5c1-ff4c-f76a-0e1a00b249a0@amd.com>
 <DM6PR12MB4452CDAE4721D598694241B8E8070@DM6PR12MB4452.namprd12.prod.outlook.com>
 <24df1d90-04ad-e444-306d-7c2e16979b80@amd.com>
 <3d9496e3-74ec-288d-4736-eb583d0f1c92@amd.com>
 <BL0PR12MB2433165202ECE6FF54999D809C040@BL0PR12MB2433.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <8972977b-be77-496f-d801-9c52bbf2e7c6@amd.com>
Date: Tue, 13 Oct 2020 19:04:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <BL0PR12MB2433165202ECE6FF54999D809C040@BL0PR12MB2433.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM3PR07CA0135.eurprd07.prod.outlook.com
 (2603:10a6:207:8::21) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR07CA0135.eurprd07.prod.outlook.com (2603:10a6:207:8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11 via Frontend Transport; Tue, 13 Oct 2020 17:04:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5fca3c99-9de8-4267-2fd7-08d86f9a0aff
X-MS-TrafficTypeDiagnostic: MN2PR12MB3951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB395130BE7536DC444C8D38C283040@MN2PR12MB3951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0AG1XK3lDRV1ZAorCJkCd9KMObUyJ3lYcW2hWAv5Dbh0wOQlxVjP7Ywm4ubemYv3VCgsCJ1gg0fDeaJeQoN01hzpEboTSftvJLrWItK744ZWWUY916on2M1t2JwzkNiXKh7d7DqKgKE5REzLAJ+VLK0O0lYYZ6GFrei0ZeTdxn17ZCRobFAQKP3mRauw1LB2mFLxHM5QgIqCUFASJfrq/wmodbKafAbOm3qWp1xFX6ByTdOMQx/1J/JIfyzVuy9HuBoeAJOB7xDIir8hcFeB5gD9sfkeD1SVpsp7SITrbK/kDUou53uU5xxAz2d0jORPmKLmxDLqHa0v27ARHAxSQSdQ3W8QcMmZRmxBl/xKokFlx0fpgYNnnjNNpgw5Cj/7SC+CEH+M70BKQbD2NXWe/uWD6lONEf2ca5z3lfOIfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(478600001)(36756003)(31696002)(86362001)(54906003)(4326008)(2906002)(2616005)(110136005)(316002)(6486002)(83380400001)(6666004)(186003)(966005)(31686004)(66476007)(66556008)(8936002)(16526019)(66946007)(8676002)(5660300002)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sntkjxvTP1p5QjLMg5Aw86ttZCakNhjNKmnaO45HSQ9LXBIR+OnhO5XZdsaZ6vGhapeqvFqOFg2ubX1NGsgI/lERh9P3iwn/tvqLk9RJU0lMCuQXtH0okW/yuZtJKAXBKVPyuGJnJPXvYnqSZpDrPOmfhXraPKgAaR0G71speBZu7ZDdk2rGqYPwdh/ZmrNmBU/2ZiKTZTkmrR6Ty/9ZtufRBjoSf6z0945aPCTN2NY9kkTcYPMzusQ4JnuT7fTzuKl5MnoXtuWK56XXmhRegUvy6hJZUTa2hvSCxXngVAOfOdDuhTwBK/RsP3+7NY6jC+MwYwqiBLqBdLikKuupPj5EnJcQKnef/5LL+ZNw5GW4u7jLNLv9BCpUPEvjsG1PXgFUQu5gAOGo2e5MIRyWn48HS+/aP85cJWm/wmTt8vUdDvJYNLt5nVlihBJfowQaAKg+8UqsIgqa6R+p7EqfBhU8jEzmU5nVKiyK5anSJnmpLZoC4ZV96dHlqcikl8ciXEixur9ETBraTZXDEXbArWN5jUOB4cpKAx/deJ1Ec9p9TuZvX178UxZ3i+GdMI1pz5Q1UBoAbDjju7oVLqcmghQOC9X6Bv+dpO6fm6EByaM6dgVE2VYbTw4YwnG/NDmAY6e97r9HGjclhsuLIjrqiqnzfXXWRDw6mahILN1aKbKR0n+c/RUtMe2D7oJUfoZdAEMvGoEapqOXLr9RJWRLDg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fca3c99-9de8-4267-2fd7-08d86f9a0aff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2020 17:04:27.7095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97bbgMNGiRH5cMWCzi7F1x9ItTBNLBl0088g1bE8q+Gi08FPK2U0YuAG2r7kRMQu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamliya,
 Prakash" <Prakash.Kamliya@amd.com>, "Surampalli,
 Kishore" <Kishore.Surampalli@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[SNIP]
> Thinking a bit more about it, when you also look at
> bo->preferred_domains and compare that with the current domain you can
> also figure out if a BO is swapped out or not.
>
> Christian.
>
> Thanks Christian for quick review/help and details. Summarizing your inputs  and some queries:
> 1. Adding BO from all the lists will give the total amount of memory allocated by this PID

Well you need to add the "done" list again, but otherwise that's correct.

> 2.  We can also print bo->preferred domain to check what user asked for and where it is currently.
> But we can have a situation where user asked for VRAM but allowed domain added GTT and we eventually
> Allocated BO in GTT.

Yes, that is correct as well.

> So do we update bo->preferred_domain in that scenario??

No, bo->preferred_domains always reflect what userspace asked for.

> 3. What will be the scenario in which we add BO to the Reloacted/Moved/Idle?? How it is different from Evicted??

We differentiate BOs by per VM and normal. Per VM are for example page 
tables and BOs which can't be shared between processes. Those you will 
find on the relocated/moved/idle list.

"Normal" BOs can be shared between processes and have a separate lock. 
Those you will find on the invalidated/done list.

Regards,
Christian.

>
> Regards,
> Madhav
>
>> Christian.
>>
>>> Regards,
>>> Mihir
>>>> Thanks,
>>>> Mihir
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
