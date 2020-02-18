Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3ECC34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 09:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEDB220659
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 09:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3wXdX6+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDB220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 672186E198;
	Tue, 18 Feb 2020 09:15:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2E0F6E198
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 09:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCKily0F+WGHXrwHoeLx7wiFXZvS3ZvO45tyaMLt7tUhpsscCRwUMHffU1NsyOOrzL5fEvjCU84mwCvsWdH3NnrwkveeEW4twUOvr+o1RncgjJOABUc7NHYWAbXfH3lVcERgh5TOPkvyYuWRS6NfTjVvJ2HkZR9tZ7qwyJtBHhSDQrvEX4rNhAjFPF9xkjd9qYgGij7WS7dsLG7G3WxzMo2E9Ef+oLlc20w/3lxlw0A6RBpn1wiICYs0WaxzgoqVa16J9QhO5Ha7VvCh5xjyDD3OSXp6Wh64tipbsGyeYGc/M8hTfghAquOg0ZIVW36gyB13dioZlCy/en/hXmow6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVpRV/gi4V/jtDkttlcW0TbEO7qDKGy0+54dAOlKGa8=;
 b=keoPLQokRIcz0omFsG4PlCJkjdQ4WMeH2TTOw/hAQylD6qSLmERJsXIRJe/qv7L2F9BOc7h/6qI8wWgxQoc3ymsaMcefXRIeznnHcC4QWRUYaTkxkLWMbmicUq7KSR5stClwhml995uc/CZktSKwMxbjSkYuj9jbS36ekc5Xs89x7CiDD0D9QfP4jMCOJW/NyrjJLeG/WyF2cLrbrzG7vkoI3oN2q7R1ShWg3CyxB+1c3xAtlMVSgAvHpwM5gWgQSfWtgkYG/Cw2bUpsV4UanoaDqflnRoqbTOsKHpYSxZe/kJWTvEip65qp1Wh+D4DadBKz9dzIIL45RCynYA20qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVpRV/gi4V/jtDkttlcW0TbEO7qDKGy0+54dAOlKGa8=;
 b=3wXdX6+U5b6PCUpBQDAMIhcGFA79e7ODI/AEYzd+584mVuV0UUNcziEqtpNsRjMn8HpGZ8kWpagZl6uRsGgIorxkAZINfmkzkuSJYa/RunSXlee3oCl5Mf3SPD/cB2O9HzM2VXmIoacPEPq5aK/P9K8+d96ATb4YvQc3dn5rdrk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1180.namprd12.prod.outlook.com (10.168.237.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Tue, 18 Feb 2020 09:15:38 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2729.032; Tue, 18 Feb
 2020 09:15:38 +0000
Subject: Re: [PATCH v2] drm/amdgpu: fix the wrong logic checking when secure
 buffer is created (v2)
To: Huang Rui <ray.huang@amd.com>
References: <1582014600-7147-1-git-send-email-ray.huang@amd.com>
 <879e7606-eedb-5b54-5600-8132df620933@amd.com>
 <20200218085507.GB6610@jenkins-Celadon-RN>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <12b843ca-61e0-5368-eee5-fc000a6a0986@amd.com>
Date: Tue, 18 Feb 2020 10:15:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200218085507.GB6610@jenkins-Celadon-RN>
Content-Language: en-US
X-ClientProxiedBy: AM0PR05CA0005.eurprd05.prod.outlook.com
 (2603:10a6:208:55::18) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR05CA0005.eurprd05.prod.outlook.com (2603:10a6:208:55::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25 via Frontend Transport; Tue, 18 Feb 2020 09:15:37 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 14514825-3ccb-4263-b2b8-08d7b4531e75
X-MS-TrafficTypeDiagnostic: DM5PR12MB1180:|DM5PR12MB1180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1180160103DE73F63452040F83110@DM5PR12MB1180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(6666004)(5660300002)(186003)(16526019)(31696002)(6636002)(36756003)(2906002)(81166006)(81156014)(6862004)(66946007)(86362001)(478600001)(4326008)(31686004)(8676002)(52116002)(54906003)(37006003)(2616005)(8936002)(6486002)(316002)(66476007)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1180;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeyKkq8W//8Jz3m0Yj/PCbdWR2m0LIuMvsGUa5VnjxKO+AvJqJTmYpldT4/hj2MyXAWknMfXax3g6LQD105gG1TMM8I+EWM8//xi3rAXVF209RYft9LgHfkRCaUMgQ6p+XpeCMsSzCDT1FhF+MbjHzlptKrTTJlRG798RgX3Uom3FcS5twTQtK9nG/cDepB4ngKbREJ88D9RDFHzdD/D7+2EJXm/2fdI8smH+dNMQ0YiLsoWOl9EY1SOW/EVBkJBPR5nNvIF2Xw1ylZ7FSO9fVGY7Vh/my3nC6X/fQmi60amjwyj4all/joTsIl3Lg50BVgL01KttI9oGntyHRo9OjNqBNpBHM1S+fwKyja5SwL7TnebRMjXf0UtF4yySy9ZIN4rnVxDRrwQ4wQDqcJOvfvtp3cQp8iLwbcIUnMTEZinmnirRws+ZuHrUkyMhFeA
X-MS-Exchange-AntiSpam-MessageData: Xi8orOOmgC9p09o88xwwNWmOx7ni1VE9qlbVYMlHTLegRFVvYN3d19iTBxhZKxM2ksuyLya4imff+EgEFxGd8Gya69wXKp5T7pv+U2xbDZX+KbTqlmTJgKfpF2DWdxBy1zFbqhWYNWQkT7okD8FnB7DeOHWRTMFX92gqgWed7dUQlqMvndmuWRfqYhVg8VkI9dyRzbE93n0NTCs07TYXsA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14514825-3ccb-4263-b2b8-08d7b4531e75
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 09:15:38.6577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMT5TF9cllkjSwlXZya2fy/4Ui2DOgDWcIDQgWlYjwuBbbcFTrCB6KZe+FYCfGKQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1180
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.02.20 um 09:55 schrieb Huang Rui:
> On Tue, Feb 18, 2020 at 04:50:01PM +0800, Koenig, Christian wrote:
>> Am 18.02.20 um 09:30 schrieb Huang Rui:
>>> While the current amdgpu doesn't support TMZ, it will return the error if user
>>> mode would like to allocate secure buffer.
>>>
>>> Fixes: 17d907c drm/amdgpu: implement TMZ accessor (v3)
>>>
>>> v2: we didn't need this checking anymore.
>> You misunderstood me.
>>
> ok...
>
>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 5 -----
>>>    1 file changed, 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index b51a060..5cbc63a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -235,11 +235,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>>>    	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
>>>    		return -EINVAL;
>>>    
>>> -	if (amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
>>> -		DRM_ERROR("Cannot allocate secure buffer since TMZ is disabled\n");
>> Only the error message should be removed, but we still need to test the
>> flag.
>>
>> E.g. in general we should never log that userspace sends invalid parameters.
>>
> Why? It probably can help userspace to understand what wrong input it is.

That's correct, but it also allows userspace to spam the logs with those 
messages.

While the kernel tools are rather clever and filter out repeated 
messages this is still considered a bad idea because it might hide more 
serious error messages.

What we could do is either make this debug severity or use something 
DRM_NOTE_ONCE() to print it only once.

Regards,
Christian.

>
> Thanks,
> Ray

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
