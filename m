Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D362C34031
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 21:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26192070B
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 21:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="r9lvTnWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26192070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 762EB6E3FE;
	Tue, 18 Feb 2020 21:37:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D67506E3FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 21:36:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2RbHjrKN17lb+7O42GCHa6SJ5lARqiiD8ckVwNBXy8akbZNigJnCIySmK+KrW2EwiHrIgiIG/8n6lgQ5XAovlEdQ/CdI7zg/kPeTBMx4gcNdIzlRvKzWKevxAQ/2HN5gBAsYAnm9Y7y6S7i5UGhm7bZjmIJuhFC0e2GWMrK8yxSYTOTkaB08iYyEqmqjGWixdhXHGCKVWhacPo2vZhZ49DUKwuHaC9PDAPaZjqWTanezCqZdK26ykEyyGVD9NdiCdjoANK30eNJRwv5Z3TPhB1rZRi+Qs4MomxW315Sveuv1r/oPqAdcQrIfgvgO+emKYCiwXVZo8wMAhVC90HcCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7otwI24PT0XjJlFhnRO3378utpT03X/9he44+fysLU8=;
 b=QKbrlVX6i6bREY7TigO60KHO/LOA1NMKIYvBTtVekFu/7B5zgcK/hhrcpZ3Wrkpq3PJZIrDBPu3GTPBV6jk4/z1dpV5AW9FHHI7x8os4XXUGncZ23SIXSqx4AG6cQ448UIp1nwFVL9UwxE4uLUQ4dIM0r/XhWTnE0G33Lda9J4c/yel4ebQiAuhh3m4/qnuNi5rCLq0WBUdoikfsW1b+enlFccV5s4q6ianztL6W2CeMl23rknw35//o1HX9XXkuWt0ZRyuyes0f/OWZ63lDfwxqlnzdQTvToKgux9a8D99U6THhP+7CnY7wiuDhJzM2azIaN5P8yTvkc+tB5JMGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7otwI24PT0XjJlFhnRO3378utpT03X/9he44+fysLU8=;
 b=r9lvTnWp3XSFb73ezD6+cnlmqH8SE6lKWD2Pc/9xmEn/iT5Mf04+ElCFjtq3yKluDUlUDH9MWO5IXLrzVAiMqSMdRRDetbdr/0wwwSo6JwbivIpVjzSSIaLBNDtG9oxYhpdMmTv0OjoNFCxcIh7M9i+IJC+KqRxS8vEdYbp4+Dk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB2652.namprd12.prod.outlook.com (20.176.118.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Tue, 18 Feb 2020 21:36:57 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 21:36:57 +0000
Subject: Re: [PATCH] drm/amdgpu: Add a GEM_CREATE mask and bugfix
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200215001714.605727-1-luben.tuikov@amd.com>
 <CADnq5_NQnRx-=zRru0zLcp61cLFhdL6xr7+PDcfh1oQCBTPpHQ@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <34764f7b-363d-c9a3-5e02-191c359d8f9f@amd.com>
Date: Tue, 18 Feb 2020 16:36:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <CADnq5_NQnRx-=zRru0zLcp61cLFhdL6xr7+PDcfh1oQCBTPpHQ@mail.gmail.com>
Content-Language: en-CA
X-ClientProxiedBy: YTBPR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::30) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23 via Frontend Transport; Tue, 18 Feb 2020 21:36:57 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4d85f05-6c75-432a-a8e4-08d7b4baae02
X-MS-TrafficTypeDiagnostic: DM6PR12MB2652:
X-Microsoft-Antispam-PRVS: <DM6PR12MB26525D1EFAE43DE7ED41514499110@DM6PR12MB2652.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(199004)(189003)(36756003)(6916009)(86362001)(81166006)(8936002)(8676002)(478600001)(31696002)(26005)(186003)(81156014)(53546011)(16526019)(316002)(6506007)(52116002)(45080400002)(2906002)(31686004)(4326008)(6486002)(5660300002)(6512007)(956004)(66556008)(66476007)(66946007)(966005)(44832011)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2652;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Qh7Xc+Pjb3QGE6zHMFC/fbug9qbPlFEY1HoT1uWhHkrX1fEUhW41Vv3okhD27RPvOgWAbOoN5PPDXpJckXCk7eKHkNoselx7wGCLZuouM4RUf3RyNYAiaUMgneoCQrrI8cR66U7N7RgTRqVhcVIZzQKchrJSiXoU6lIStka/9bE2ib3PZ8FpBWSkDtv170xr7cUVPlLzSVhAj9G/gbZynjdTbwn/MW02+mF1voKeVHsv70vXkUqCGzO1VodftkPtsjWTuVi5JJwVOn5gNVLGvmInNpysk2Yaef1xOozOAA3yq04b8tNQA69h6Js93WoNRqccbq1eLWTdtVnTSW1x25I4yh+ngLfZLGu/JjJATKFSYBGgRs8nO1/ZeaWecoOPx/qd5JczNLti5pavFQURVT+4GriAX+qQna7b2Z/V2OCxPxV3C2h3g3dSuKzLjTYUM63j+dz4gaHMC0uu6DG886TZZQdTy3XZPs2HezieQ361SZNm31pacN0o7v7s/IGqBHayhugoLLrD/2RjVvn2w==
X-MS-Exchange-AntiSpam-MessageData: XVG4RAfbZMtteur6mvK93Fnv5gQC5bLf1ghTYYGjYUR34yaJ3NXjB+aYbqIQoHldcgexXDs3I4DfYIu9R+aDPasU6kFvG/iOkyv9f9svMPgrhdxXkxyuRsmrxwGOeBgQXYyvlcm1StfZUURzelcq2Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d85f05-6c75-432a-a8e4-08d7b4baae02
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 21:36:57.4699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1NwoxKGNTzRjWufsdDXoNIF7fGBMR+5GuDRIxAZNApu/4I+mhJexinUPm/piYZ2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2652
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-02-17 9:44 a.m., Alex Deucher wrote:
> On Fri, Feb 14, 2020 at 7:17 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>
>> Add a AMDGPU_GEM_CREATE_MASK and use it to check
>> for valid/invalid GEM create flags coming in from
>> userspace.
>>
>> Fix a bug in checking whether TMZ is supported at
>> GEM create time.
>>
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 ++---------
>>  include/uapi/drm/amdgpu_drm.h           |  2 ++
>>  2 files changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index b51a060c637d..74bb79e64fa3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -221,21 +221,14 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>>         int r;
>>
>>         /* reject invalid gem flags */
>> -       if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>> -                     AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
>> -                     AMDGPU_GEM_CREATE_CPU_GTT_USWC |
>> -                     AMDGPU_GEM_CREATE_VRAM_CLEARED |
>> -                     AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
>> -                     AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
>> -                     AMDGPU_GEM_CREATE_ENCRYPTED))
>> -
> 
> I'd rather keep the list explicit so no one ends up forgetting to
> update the mask the next time new flags are added.
> 
> Alex

What about the bugfix below?

Why did no one comment on it?

> 
>> +       if (flags & ~AMDGPU_GEM_CREATE_MASK)
>>                 return -EINVAL;
>>
>>         /* reject invalid gem domains */
>>         if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
>>                 return -EINVAL;
>>
>> -       if (amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
>> +       if (!amdgpu_is_tmz(adev) && flags & AMDGPU_GEM_CREATE_ENCRYPTED) {

This one right here?

What's going on?

Regards,
Luben

>>                 DRM_ERROR("Cannot allocate secure buffer since TMZ is disabled\n");
>>                 return -EINVAL;
>>         }
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index eaf94a421901..c8463cdf4448 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -141,6 +141,8 @@ extern "C" {
>>   */
>>  #define AMDGPU_GEM_CREATE_ENCRYPTED            (1 << 10)
>>
>> +#define AMDGPU_GEM_CREATE_MASK                  ((1 << 11)-1)
>> +
>>  struct drm_amdgpu_gem_create_in  {
>>         /** the requested memory size */
>>         __u64 bo_size;
>> --
>> 2.25.0.232.gd8437c57fa
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cluben.tuikov%40amd.com%7C622cd0e399a041e8ad4908d7b3b7e97d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637175474785178580&amp;sdata=CLlIUaQVOhMibxBtkHtbBZQ9d%2FjNBSRtZ8Db%2FYN2Hj8%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
