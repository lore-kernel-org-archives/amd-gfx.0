Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE8AC34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 09:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A972070B
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 09:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tCJ3cB8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A972070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3775F6E9C7;
	Tue, 18 Feb 2020 09:49:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 853B06E9C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 09:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=littwkDNp6zrK1AUI9dNwWsnMt/EGSDGCwzr62GnmaLj7I4C65mKe7GfDlv28rL7J8W4dkAMDngEVq7I7lMA237/2iroiucMKRqVoO/elFeNdDKgLDHJ/+GmaZBqdBd2CV6Lh7srvdxb6HkHRj+jyVxlr+OivJJM+adS7P8k0F0sKwGArg0QwBR0ZRQWjpZ7Hk/+PJEzGmQCXohdd7uVZoN2XwwJKHjuO89K4eeZAHE3JIX3OtHmVnanVOZ7ql8+tmm7raQPp70T+5aN8gRuTQ15D4LyA/VaHwgG6+c+f61VlnG+m4BqVVeWGMl4FG1lWIr4gW7W7c4W9FxQfxRguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5KpaxSrw1dnTYvn1pz1AlqwKDjLTNKVhJvNVo1UtRk=;
 b=IgjeS/+3jVcZMdhY23U9KTg34Pjn6oZGsUlBdKqAThGKrt6GGM3bFPWVfG9oEAk+lhkMU8+ioYB/QwXEjocB65ARTHGkRDJu4a/9BOc6P+G+StoLdcN3Af5q+9yFpbPl8zJQHJjjmZHxLbu32zF55tee1cP1eltpJuZ514h2if7yL0DJgunUeV3ChBG3+RQr5+fgCjyc4IRLDcNp38urE+20R2EMR20DZX0GXCdR6yYKWBIrOXfMa4mkEmDgYGlQq6svIQ6+ziAf69Mym8ARsYBXRIsoE3qVxTXMOpTx1UJv/UFvsg59Fts6Z9carw6dZQ9nOpfXZhUEYcT8G8wXDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5KpaxSrw1dnTYvn1pz1AlqwKDjLTNKVhJvNVo1UtRk=;
 b=tCJ3cB8/q0Hfh9Jr8FwB7NNJZKnv31JU+tQmfSFDjp75QbUeTZOcremrIaqVM8MtA5moEBLQjp0JntqJ6PyG6mdSOrScdJg6gL2efoAM5TVQDMyA7ak9qPWgvIOaW93eVsmWG7hGhGiYTJicZEjWXlIxypprUNdyk/M5FEDpT7I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1817.namprd12.prod.outlook.com (10.175.86.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 18 Feb 2020 09:49:17 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2729.032; Tue, 18 Feb
 2020 09:49:16 +0000
Subject: Re: [PATCH v2] drm/amdgpu: fix the wrong logic checking when secure
 buffer is created (v2)
To: Huang Rui <ray.huang@amd.com>, Nirmoy <nirmodas@amd.com>
References: <1582014600-7147-1-git-send-email-ray.huang@amd.com>
 <879e7606-eedb-5b54-5600-8132df620933@amd.com>
 <20200218085507.GB6610@jenkins-Celadon-RN>
 <12b843ca-61e0-5368-eee5-fc000a6a0986@amd.com>
 <20200218093534.GC6610@jenkins-Celadon-RN>
 <20200218094421.GD6610@jenkins-Celadon-RN>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <16ffc3ef-96d4-b3a0-4736-c1754992b989@amd.com>
Date: Tue, 18 Feb 2020 10:49:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200218094421.GD6610@jenkins-Celadon-RN>
Content-Language: en-US
X-ClientProxiedBy: AM0PR0202CA0019.eurprd02.prod.outlook.com
 (2603:10a6:208:1::32) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR0202CA0019.eurprd02.prod.outlook.com (2603:10a6:208:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend
 Transport; Tue, 18 Feb 2020 09:49:15 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c26e3a64-a740-4c52-ae79-08d7b457d167
X-MS-TrafficTypeDiagnostic: DM5PR12MB1817:|DM5PR12MB1817:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1817F469C40A63426A5FF37883110@DM5PR12MB1817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(8676002)(8936002)(54906003)(110136005)(31686004)(186003)(81166006)(316002)(6666004)(16526019)(4326008)(81156014)(66556008)(5660300002)(66946007)(2616005)(66476007)(6486002)(36756003)(6636002)(52116002)(31696002)(478600001)(2906002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1817;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EWRIhiMnzzG1yABRIuh85DbUJ9D1O6/QUclEGoSvIe8KqZao+FOo55WziGspbX81px1/nTnMMzZZqA13l3FznLiVOucDCk5mKVsYcscbFKcnihKGxmJZlFKVifATtypVrbFvDaahzLgOecN5aw8azr6jL9OisjDFCJydofUecWdBcfpCcC2jRubKSrYb74by84bALazdw/tokpxlnDwH2DSC0TzH3uEqeWG1dVZNkNKxA5j+0TlNhd1H6rUnltTcorelfYLKISo/K8isQKkzfuSHSHcs+SbcmvIciOip18dPG7pgZAxePOtHEKLHsHS2LEKXItdQDuyR8+HPCexPVq+qj97aQQqS76TbkLTPGHWG3XLgoyGwpIGDBxi0YW7hu7UO+VfEQPLtIN/wZV9U+OMn1LeL4VzyJNihS6HaI9jeg9Qo4Clm58aHGhW5DS38
X-MS-Exchange-AntiSpam-MessageData: blZz7q3NEu4bz/xKdU7+ZjBRFV2fc8CbZQP2KCuf+XFbeK4SEZdcW0TbPn7Y0I+4doOUUUkM8ohC/Bn5GdpEuL3CjGiqd0dEnbO2zZN6gTMhSNyh5AMaAkXMf9v6+viHhhwVOsg9Y5yCQeGvFcZEzFdJztxfql3TPvKXmSUb8HzzTaSvbzBmOvt3nwEv/5Ts7RDWOeVf1yDlBoG0J60TNQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26e3a64-a740-4c52-ae79-08d7b457d167
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 09:49:16.7430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4L1O2pynnfZ7AyTbXc4uZpTFzsRD9xPvJGYhtVHFqSpXYnezFt/3ySkQJGc2SRn1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1817
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

Am 18.02.20 um 10:44 schrieb Huang Rui:
> On Tue, Feb 18, 2020 at 05:35:35PM +0800, Huang Rui wrote:
>> On Tue, Feb 18, 2020 at 05:15:33PM +0800, Koenig, Christian wrote:
>>> Am 18.02.20 um 09:55 schrieb Huang Rui:
>>>> On Tue, Feb 18, 2020 at 04:50:01PM +0800, Koenig, Christian wrote:
>>>>> Am 18.02.20 um 09:30 schrieb Huang Rui:
>>>>>> While the current amdgpu doesn't support TMZ, it will return the error if user
>>>>>> mode would like to allocate secure buffer.
>>>>>>
>>>>>> Fixes: 17d907c drm/amdgpu: implement TMZ accessor (v3)
>>>>>>
>>>>>> v2: we didn't need this checking anymore.
>>>>> You misunderstood me.
>>>>>
>>>> ok...
>>>>
>>>>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 5 -----
>>>>>>     1 file changed, 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>>> index b51a060..5cbc63a 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>>> @@ -235,11 +235,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>>>>>>     	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
>>>>>>     		return -EINVAL;
>>>>>>     
>>>>>> -	if (amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
>>>>>> -		DRM_ERROR("Cannot allocate secure buffer since TMZ is disabled\n");
>>>>> Only the error message should be removed, but we still need to test the
>>>>> flag.
>>>>>
>>>>> E.g. in general we should never log that userspace sends invalid parameters.
>>>>>
>>>> Why? It probably can help userspace to understand what wrong input it is.
>>> That's correct, but it also allows userspace to spam the logs with those
>>> messages.
>>>
>>> While the kernel tools are rather clever and filter out repeated
>>> messages this is still considered a bad idea because it might hide more
>>> serious error messages.
>>>
>>> What we could do is either make this debug severity or use something
>>> DRM_NOTE_ONCE() to print it only once.
>> I see, make sense. There is no DRM_ERROR_ONCE() and I think this case is
> How about about DRM_ERROR_RATELIMITED()?

That would work, but I think DRM_NOTE_ONCE() is more appropriate since 
this is not an error caused inside the kernel.

Regards,
Christian.

>
> Thanks,
> Ray

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
