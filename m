Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A420C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 15:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F0D20675
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 15:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Yt06qTZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F0D20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD5946EC17;
	Fri,  3 Apr 2020 15:54:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B5D6EC17
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 15:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDbgGtQzkfwgKBRg9sBjngpDQFvXCBvErweAzl8KaUwpSKdqcunh9H8Qd6u5DsNOzs8fnwFTZSq+u0GblDJ3grYYpxm7/B4sNdlKa5macRJFp1v9uil/mXTGR60zFOt+kuxhiDNsxf+PZC2sNGU2jcIWWfUH8yGXa9Dy2KqujKCrpeFreYzLunLuwweb0Kgj9krMGP9HZRKRjO3U3NGdz2tlguXApy2ioU7Pb5fdrgZGxPz1x07FNfXCIwv6giDKdRqzS+0by6WqWr3BYTb5h6N7zUEZHPPT9iJGLbx56Jhi70Oy7tsDr/Q4u7hSWMVRogc+X6u5ph3enUI8+/weZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zQZuSwQijToubUL939aGGbANHIHgkTZxUZXTlFqOKk=;
 b=jrrSYrq+Zthl0siArTDOiOGa+iyKjp9k9fGBePo76R1xbGb75Ja9I6TTLbajkLCYD/TfBcLqUgrfshaaNvqh8pAXGvk20VnZ/x1FE+i7h5h7fqBx1NBUFukbUi8S2xYB0HCFDJTnETFR7dJNLcj1R/OQcbSeq3e3to7D+rFX6HkKPNuxwpTc+L526/QBJut3I8XGk4WvKlLKwSx7whh5Xv3o+yLC/r6AFNp1fYqfaQztXPf19pF/45CZfmPOkw8/72GyTy4VLjEbq/Vd9XD5fdvKPXrnpi5BowaeeJnSABaf1knsWxeS6g4sAv3/DWDLPm5qewzi+rw5Gh6BD/hK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zQZuSwQijToubUL939aGGbANHIHgkTZxUZXTlFqOKk=;
 b=Yt06qTZgsTga1uQQ78On7lyqY12YzjMUbuuJxDP9V4NE+ZbnR1JP2ykHYbsvIZYpNiyCPwpOIRgiP8qpEDkXnaXdnG6+gA1JkTXIUDSYpLxA1OfxlCzVzxKHGcV+Ibm0bxq+5PXOw9ecrKY+74R/HUrjanX4eW/V2l8aJUy7bDs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1866.namprd12.prod.outlook.com (2603:10b6:3:10c::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Fri, 3 Apr 2020 15:54:23 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129%3]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 15:54:23 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn: add shared menory restore after wake up
 from sleep.
To: Alex Deucher <alexdeucher@gmail.com>, James Zhu <James.Zhu@amd.com>
References: <1585918324-16780-1-git-send-email-James.Zhu@amd.com>
 <CADnq5_OwEiyjtfoy4ri+wMt9KTL7cZirrKJFhsQmYncPHSeH-g@mail.gmail.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <62cc4dea-88aa-15cc-cc54-9f5fc5fdea38@amd.com>
Date: Fri, 3 Apr 2020 11:54:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <CADnq5_OwEiyjtfoy4ri+wMt9KTL7cZirrKJFhsQmYncPHSeH-g@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::48) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.233.155] (165.204.55.251) by
 YTXPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Fri, 3 Apr 2020 15:54:22 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 973477d8-8f28-4829-e914-08d7d7e7473e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1866:|DM5PR12MB1866:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB186677EAF67D8F534E6F3070E4C70@DM5PR12MB1866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(8676002)(8936002)(81156014)(66946007)(81166006)(45080400002)(54906003)(36756003)(66476007)(66556008)(110136005)(478600001)(4326008)(26005)(16526019)(6636002)(36916002)(16576012)(31696002)(31686004)(53546011)(52116002)(186003)(6486002)(5660300002)(956004)(2616005)(2906002)(316002)(966005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JhVvHwPbPd12EFfMGd9t0aIqFbQmXZdLI7BmkuLWl0g1wYb6aWy9VQPLMLJuYuviMOoX8z/xgLo9OqC+qE94AxM335rFs1rJ29tS0sEF4efgTxIs1kjW8Fvp1WwtPYBxyV4UAfxP0uTqti9j6kOlVxrFMmVhkwJNRYfzZelgDyIfQD414b4mzqYY3zh1J0gBm56wj8ztsEOSzTu1OF+tBZwAdkZDDJo18BXqOqu2M21dNG1iQgFfdAxUB3BBpFL9EVzsnUL09m8O/mYWK9/WB82sFOsi2/cFqXFJpE8f5TXX0g8k2zBPv2dggKyIdf0mfP9W1OQUi6bX+DBldtSHLIGr0mmc4wHrAcANkGpHyZ8nkkfRoryaV93vcfO2PYLPhKNP5IyySeo0Xzg+FZd0Rz2ofQWDeTaltqc+o3nxYX6MTuJNfBMqSuYyCjHZ5msybUzaymywgsM4Os382lU3o+xjH82E+c5fIkfKuYH7dgE=
X-MS-Exchange-AntiSpam-MessageData: bawh0Sxw/4hL7fASOmlMOlUIHhR1hepcAzQ85mCchlWvfCuU1YvgT3Qckgm78pvnfRsSlDLJTLHI5QCVxQypbwVcfOTVfxNJafxfT4wKZrv3PvobQJCMJyEpmrnlqZIA8/m56ab6aNyE8bO92P0SkA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973477d8-8f28-4829-e914-08d7d7e7473e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 15:54:23.0935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5GusmLZrsqo0ZAh3ciYG3MPDzZIkUedQoWs4/0e1FQp6PTcOmZ5IXOYNE7codni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1866
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
Cc: "Li, Pauline" <Pauline.Li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2020-04-03 11:37 a.m., Alex Deucher wrote:
> On Fri, Apr 3, 2020 at 8:52 AM James Zhu <James.Zhu@amd.com> wrote:
>> VCN shared memory needs restore after wake up during S3 test.
> How big is the shared memory?  It might be better to allocate the
> memory once at sw_init and then free it in sw_fini rather than
> allocating and freeing in every suspend/resume.

Hi Alex,

After alignment, it is only 4k. I can change it as you suggest.

Best Regards!

James

>
> Alex
>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 26 ++++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>>   2 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index d653a18..5891390 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -205,6 +205,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>>                  if (adev->vcn.harvest_config & (1 << j))
>>                          continue;
>>
>> +               kvfree(adev->vcn.inst[j].saved_shm_bo);
>>                  amdgpu_bo_free_kernel(&adev->vcn.inst[j].fw_shared_bo,
>>                                            &adev->vcn.inst[j].fw_shared_gpu_addr,
>>                                            (void **)&adev->vcn.inst[j].fw_shared_cpu_addr);
>> @@ -254,6 +255,18 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
>>                          return -ENOMEM;
>>
>>                  memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
>> +
>> +               if (adev->vcn.inst[i].fw_shared_bo == NULL)
>> +                       return 0;
>> +
>> +               size = amdgpu_bo_size(adev->vcn.inst[i].fw_shared_bo);
>> +               ptr = adev->vcn.inst[i].fw_shared_cpu_addr;
>> +
>> +               adev->vcn.inst[i].saved_shm_bo = kvmalloc(size, GFP_KERNEL);
>> +               if (!adev->vcn.inst[i].saved_shm_bo)
>> +                       return -ENOMEM;
>> +
>> +               memcpy_fromio(adev->vcn.inst[i].saved_shm_bo, ptr, size);
>>          }
>>          return 0;
>>   }
>> @@ -291,6 +304,19 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
>>                          }
>>                          memset_io(ptr, 0, size);
>>                  }
>> +
>> +               if (adev->vcn.inst[i].fw_shared_bo == NULL)
>> +                       return -EINVAL;
>> +
>> +               size = amdgpu_bo_size(adev->vcn.inst[i].fw_shared_bo);
>> +               ptr = adev->vcn.inst[i].fw_shared_cpu_addr;
>> +
>> +               if (adev->vcn.inst[i].saved_shm_bo != NULL) {
>> +                       memcpy_toio(ptr, adev->vcn.inst[i].saved_shm_bo, size);
>> +                       kvfree(adev->vcn.inst[i].saved_shm_bo);
>> +                       adev->vcn.inst[i].saved_shm_bo = NULL;
>> +               } else
>> +                       memset_io(ptr, 0, size);
>>          }
>>          return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> index f739e1a..bd77dae 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> @@ -194,6 +194,7 @@ struct amdgpu_vcn_inst {
>>          atomic_t                dpg_enc_submission_cnt;
>>          void                    *fw_shared_cpu_addr;
>>          uint64_t                fw_shared_gpu_addr;
>> +       void                    *saved_shm_bo;
>>   };
>>
>>   struct amdgpu_vcn {
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CJames.Zhu%40amd.com%7C46c4773164334ec712b708d7d7e4ebd6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637215250518903143&amp;sdata=Mj%2FgeXKkiNVFUUsyKAesC5eaanDg%2FvQQpQe1rhT9uek%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
