Return-Path: <SRS0=opbO=4I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8326BC11D0C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 15:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D214208CD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 15:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TVALSrR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D214208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4082E6E8CA;
	Thu, 20 Feb 2020 15:12:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C8A16E8CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 15:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCrs64+6baUxj+e855V70E0JpZ/vIugi4TgwmwXm9wKVqera12Y1wxuEMf+a7Bl/oBRjoF6DblqQ0UoMc2n8eo9nJUZBqvWpijlh5LAeOCuErbYaVRWgJ1NHRY0rj1Wc3WnukTXSxuc8etVq4ZDcYiLrtlXddU8I18Co6tY1wc7EW0tuhdPhQHZass1HgaT2funp3bChFNR29BHhK2K+xuLTHhGRkysG6xECnmVqHoIFAb5fBs0Mpoq7t7/yIP+mLxizFnbzGKZL0FizBd9Pv04XBB/2Sp6F89S9XZ6mbHn6Xp1eYsf3/UExK9eBLXkkBt4BRXtsrMDuHPzUiWG4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8JMhnWxAAC8oDZqLFATBl95+67tgRDDgcdKGh4NrzU=;
 b=T0q5fFz3VrA7683QSFk+BXtZGuqmvjxyaaIZSiGVQ6U+bK3kLHk9gQ+5iQjSTvid3AZjjhtP+fowkvPNj6WIwI+LZLZA/ARhyVVe1x7+mHUEEVJIXdoQIHj8gpTGv/mLx5XiCWkmqjfmCUfH8tGd3jjvY34ny7iv8E0GHXLRRV6EX2jx6/1H8nI+Ij1O2ude3HnLrbLnFssxtuQ4lYaELzb6uYVjYBrDzs6cirSwhSOhVKtm7mxOYo6R90QQOQXYUaXoEdGCK6SabOILU1SuCC8VdqUcHPbRfXU9pqkdtdWzgMyuDxwG2k4DRckmybzuDhmYuVfxntW5fQ1Mlj36TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8JMhnWxAAC8oDZqLFATBl95+67tgRDDgcdKGh4NrzU=;
 b=TVALSrR9vMiXvafhltpt1I/UUdCYWKQwW8Bh8sMoep405CQf+C2W6tZDaixAz2XoujR23wTbuDVGIzTLzlROVXBOlsCeYeoGUfG71xuaN9KrBH0wu72+zeX5S8Z70PhGg8+VpBhfxCNDwV26ZTHWt4MWwmeBkYSefwgL/iTVbvU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1787.namprd12.prod.outlook.com (10.175.91.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Thu, 20 Feb 2020 15:12:42 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 15:12:42 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggYSBidWcg?=
 =?UTF-8?Q?NULL_pointer_dereference?=
To: amd-gfx@lists.freedesktop.org
References: <20200219040445.11112-1-Dennis.Li@amd.com>
 <DM5PR12MB1418062D884DBE08E1FB9997FC100@DM5PR12MB1418.namprd12.prod.outlook.com>
 <e7ea478f-95ff-69c6-e81e-709b44904209@gmail.com>
 <DM6PR12MB393104A6C93ED039BAA5ED1C84100@DM6PR12MB3931.namprd12.prod.outlook.com>
 <MN2PR12MB3167C68A5B6AF0E97613A6A4ED130@MN2PR12MB3167.namprd12.prod.outlook.com>
 <DM6PR12MB39317635C3FB63265B9216D084130@DM6PR12MB3931.namprd12.prod.outlook.com>
 <DM6PR12MB39317F37CBE569725C00ABD284130@DM6PR12MB3931.namprd12.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <a8e8df99-aaed-5c0a-10ee-7cb63861c283@amd.com>
Date: Thu, 20 Feb 2020 16:15:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <DM6PR12MB39317F37CBE569725C00ABD284130@DM6PR12MB3931.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2c:5d00:8d2:968:f382:8499]
 (2003:c5:8f2c:5d00:8d2:968:f382:8499) by
 FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Thu, 20 Feb 2020 15:12:41 +0000
X-Originating-IP: [2003:c5:8f2c:5d00:8d2:968:f382:8499]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70309a14-5062-4191-baee-08d7b61754e2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1787:
X-Microsoft-Antispam-PRVS: <DM5PR12MB17877646BA3E23CA0F280F4F8B130@DM5PR12MB1787.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(189003)(199004)(6486002)(316002)(81156014)(31696002)(8936002)(5660300002)(81166006)(224303003)(66946007)(6916009)(2906002)(478600001)(16526019)(66476007)(186003)(36756003)(66556008)(2616005)(6666004)(53546011)(52116002)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1787;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9StQcImpmit2VptIW63P+GttarCamHqOIgt925bk8P9OdII985t8MCQvmur3cggY382MON9ps8XySozsEFS4eSHyV+3TZxSPtO1FPdujknjdSXMvtHVm5p69uLVAl5zgREk7rM5vH+ZDsuBqKMWVpv7MM2ni/+Ff4jb6+GAkeIMQR5Ypf24bd4QOlU30060jhQamqjcmMciQlWA87SoXIId3YEBXeM8ZxbpC1ORMnClFM420mFT6IQJ3W4TddX9EW0cbWX4yFR1xHzi4DDWm4n4dkBDee+kCiKl23en2Msh5qIUOD8r4qiMpDfWycr/C22B5d/DNj4+P1j7gWE+07aL8KklK5JQPjb5ILeVKGqYy5YTodhoP/dxIEu+fwebVlIU0JvKuKWzSbkRUYXe79ORi7pGJUKyFyoB4d1zgv0q6w4IFeBOgiilevYrD2qYK
X-MS-Exchange-AntiSpam-MessageData: e0xtAnvOJtlJ95ma2DRRzwEAexIOYeUoUw5BiKeglXhd5aB2A1YKoSs5B5Pn9m5An7ltzHzQ/EdiS0A3mIYzQ9T7PbY2F4FTmgJ5kgMhmrsx3aQhOaMFyBhPIzR7AYxcsTWFHOXVVip5pMxY6VG5+NGn66BkOuQCLvwxenA2lhKJ7VquAOy3nAvfk57c5frNSLBDafD/HyXldr2cX/T7pw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70309a14-5062-4191-baee-08d7b61754e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 15:12:42.2931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAq/lNr2zHirXZYMYdVIth8xVRlI2DTDLBsrjRCeZV0dpcVQjxkVESwEJ5Ov+XfW/BytkeW9ZDzDFhnEUvC57A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1787
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


On 2/20/20 2:35 PM, Liu, Monk wrote:
> Sorry, my previous idea still leave RQ null, please check if below method works:
>
> 29 static struct drm_sched_rq *
> 130 drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
> 131 {
> 132     struct drm_sched_rq *rq = NULL;
> 133     unsigned int min_jobs = UINT_MAX, num_jobs;
> 134     int i;
>
> 135
> 		While (!mutex_trylock(....))
> 			Sleep()
We can't do that drm_sched_entity_get_free_sched is in another 
module(drm scheduler) independent of amdgpu
> 136     for (i = 0; i < entity->num_rq_list; ++i) {
> 137         struct drm_gpu_scheduler *sched = entity->rq_list[i]->sched;
> 138
> 139         if (!entity->rq_list[i]->sched->ready) {    //we take the gpu reset mutex lock, so now sched->ready won't be set to "not ready"
> 140             DRM_WARN("sched%s is not ready, skipping", sched->name);				
> 141             continue;
> 142         }
> 143
> 144         num_jobs = atomic_read(&sched->num_jobs);
> 145         if (num_jobs < min_jobs) {
> 146             min_jobs = num_jobs;
> 147             rq = entity->rq_list[i];
> 148         }
> 149     }
>
> 		Mutex_unlock(...)
>
> 150
> 151     return rq;
> 152 }
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
