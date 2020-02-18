Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FEDC34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 09:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE0420659
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 09:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dwO6tK8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE0420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC416E195;
	Tue, 18 Feb 2020 09:11:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B427D6E195
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 09:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYgHb85MvbTk3G+ffrjCHUH9D0AF4s2KHvepi32iPz3UAG7SorKOck4SQm1XW5T/oU2WKFiI2QOWUG2/bh3wjnWDyfPsBOQXcEGUyv2p9Xq7jmPLfAIQkEZvBpOie8K53PTITcJsMPCvarJGOdOa/59HC7TsMS5UiLGep1xOibjn+FrJ/3PsyJQErbVZ5gvrd2nVz/QIUxIk3W/UUKjcIrVFE5Q070F/usBXHpaGXdn1r6Pc77XBtnK2ojtLmJQ6dyd/Hn1Tx2qKUuKWrSrSZYNhCx16bKFNcZk1MfnUA5pKdbE3U0/dqZaggNa+yxACrdImUDZN2hzqL1ScmoSkzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oO+wfjqgsZuTHnYuzYDuyzi28MctNmSVQ40motx9iU=;
 b=NALFLgTwC6iz+F+63Nnpx5+5S/tjY1ZTd0c4vN33Z6FAw2QOGJmUYKiasfuqNuLdGDCVyyfTCR0qc2jeMXWhEjpOdVWH+c903jkejaPLi02sJRkMd7eYA2yIZjbeSBETvKQO+O4qDq0XhLFAjB0hZC/rbEba8fY7hsrTEP15exFg+lxnn77vElz67HxMQ0HEaqWuml+BEtCd1E+ncowopFht8VqemFQLWZfUuAL+6ySXlJaAJf8MJK9/TOC1KZ9g0OyWhhMn2b3SBkdz0GmbS8YofeZNmQNeSXDaw0e2J9GmQawjZ+0JgNHgMNs3Lt/V2ZPtFdTQUP2o04sdSuAEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oO+wfjqgsZuTHnYuzYDuyzi28MctNmSVQ40motx9iU=;
 b=dwO6tK8A31/FoA+XH5ydwgd1Qdmf3G1dNrU2Zplt0yxDxiVVxCi3L2vjFNRNdnBLRmQaetDlq/2jDDxBkkDs+JvQnUzFxzH2o7aKWlYhAH1MMXoERrCN+YWcisKP3htKd3PkJJppsCSzKVkllSpVp3IBqI3J83/hKhbiLYyKIzY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from MW2PR12MB2377.namprd12.prod.outlook.com (52.132.184.148) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.177.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Tue, 18 Feb 2020 09:11:09 +0000
Received: from MW2PR12MB2377.namprd12.prod.outlook.com
 ([fe80::381c:62b:e211:7e0d]) by MW2PR12MB2377.namprd12.prod.outlook.com
 ([fe80::381c:62b:e211:7e0d%4]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 09:11:09 +0000
Subject: Re: [PATCH v2] drm/amdgpu: fix the wrong logic checking when secure
 buffer is created (v2)
To: amd-gfx@lists.freedesktop.org
References: <1582014600-7147-1-git-send-email-ray.huang@amd.com>
 <879e7606-eedb-5b54-5600-8132df620933@amd.com>
 <20200218085507.GB6610@jenkins-Celadon-RN>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <cb859c62-6e8a-7cdf-460d-03156fa64875@amd.com>
Date: Tue, 18 Feb 2020 10:13:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200218085507.GB6610@jenkins-Celadon-RN>
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0007.eurprd05.prod.outlook.com (2603:10a6:205::20)
 To MW2PR12MB2377.namprd12.prod.outlook.com
 (2603:10b6:907:11::20)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f2c:e900:7512:2832:6401:b174]
 (2003:c5:8f2c:e900:7512:2832:6401:b174) by
 AM4PR05CA0007.eurprd05.prod.outlook.com (2603:10a6:205::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24 via Frontend Transport; Tue, 18 Feb 2020 09:11:07 +0000
X-Originating-IP: [2003:c5:8f2c:e900:7512:2832:6401:b174]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8424cc95-233b-419d-01e9-08d7b4527e26
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25549F0C41D9F1B09991051A8B110@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(186003)(8936002)(8676002)(31696002)(16526019)(2906002)(81166006)(81156014)(66946007)(66476007)(66556008)(2616005)(52116002)(53546011)(966005)(45080400002)(5660300002)(36756003)(316002)(478600001)(6666004)(6486002)(31686004)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2377.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kENCH0pE0aNOYVRgjKbRRwC+mW+VDMzTlCJLIuhD+GfhDNw2BkY5CwMRqhXpksfxCvjvFYCHoGmMb1z2LdfJ1Akx9KI+HyszV7xET0DQEQckotiSx4yZXyvczcz9yTueKucKCByZ+Z8nQ0xWTmwaqaZKOReKRUTEkMYq96/51QrmvT2HH6PfTj+XT8nB7llSavV5mX5oay4YHM2pP0AHKLK+UOpaxJvjsN06iEn8G/6P6ktevBWu/miBbJun9E7VcavCtCBt0WldYj9NnJyQweEAo+EYNFqyasmte02qJxRc2RA7j4LnOzOyK8oI9NV7WSm1nliWVnCotVZbKH8DeitHTNcvPkqBGOULMFHZl274h/zyBLpHrRd4Kd5OOa8An5rnYZJBpu7VzQqyE5N8gaKhr09ie0r1Xs0aMgnB3Bl6pJ6jRUYSWWwRU5uee0vlJb/8wyF4DQqlfaxp/4pEKjkxC7Mg7bWFcMuOSnwmB9pPnZCUUI16Dnm8YFEgfmCUulpupP4ri5Ap2LmZWAG6rg==
X-MS-Exchange-AntiSpam-MessageData: K9yEJx9Vd6YQ/8Jx6A24vgNzJaE0B4zd4xio8ntZa1ZBbVrMIecRScrZeXJlSEnIivQtQtyYMJWCTSwWDCS2bCXf7Rnrpp4IVP1sUsOXoJ+uVyrJrSLBAW0eoRpI/mPiso9QDji/LirWViUMG23kii6OOGCzVSEH/aIi7gs0Lihjmw5nJdRR7+xxO6xj95uKMM0XKSrE3B/Y4/rFVV9AOg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8424cc95-233b-419d-01e9-08d7b4527e26
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 09:11:09.5571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEriP7zGWNjTGjGHyisZ4WdfWITrS2lEma3ao0onTRgdgrsUYXBrj9zeo0NNwS49f//8n0SKR/uJFDPFAZqxHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/18/20 9:55 AM, Huang Rui wrote:
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

May be we can use some rate limited logger here.

Nirmoy

>
> Thanks,
> Ray
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cnirmoy.das%40amd.com%7Cc022e81747e446bfe0c208d7b4504a56%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176129272549986&amp;sdata=drEDHkueArU6KVFCfUIcU3up%2FlmVhQRbXb7y2JZiSdE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
