Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34329C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 08:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07CF611B0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 08:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F07CF611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F3A06E9A7;
	Fri, 10 Sep 2021 08:54:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC4ED6E9A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 08:54:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9vEBHaoFP26pl5pkWyFHFOUplSXFyGLHMVD3b1uoPHGgNkw9eA5dNBdS5doVft0bZzEt8yHdkGN9U9VLFlLM7pZNVyxWDaGxHMoUXFOF4oGiyXz+6e4tZ80TFF5LMCR1q4AKTeLHFGIH60lkfd5YbqzCvnZPDO0MS/nRtSJMDvglDBVbpBqozyfTveU+SmyuFwBbrghiTLELliY4BDvyqP487kCJRJ2VzICKUklmL2YfYLsxdQultSgMKkZnaa9Bv1+Z9r1MrJFy3rQHqdKV4dYlZDnirKRnKx9ds0eI5bPQ7jbgHCY0478S9Ms6ApxZwlJPVj5ZBEKtMFQlQYtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=tcyOfIunyDCZpcqt1iCszOjyiaBR37eIBtkqgVvPR38=;
 b=QOZ3boKFbdwCZ852TLJUUjv8U50220irxEMaO0/kNptHzpmtajs2I7CmLQhU/sRLTksDr4d4HKj/CPoOmmppdY2bRNvZt/emGQ+ZNyZK+TmVSMwaRBi49M/TGxNxoQuJimQYhwW1ZFiBwW/MUOgGFnvh+IsT93CgLc8UvC4KQXL460QkmQH/lqhAgbMMrkKlqhYFsf6hEj2bqFhr9DXRMgATc+OCyctqqKo7JvlQ711VClVMc+gTiTcTqls7JC1QRZnowCeI01BJ4/phyM9NfC2vZpLSA7hRFgXvfwcGVt4a9nTqAhAT27FeoFQL2EDHAEgiuVkZDL3dOj1mhYlDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcyOfIunyDCZpcqt1iCszOjyiaBR37eIBtkqgVvPR38=;
 b=ygpng9qhfOdka7uMuPIpWWFTFPh/eKZ3UPvkOaYkZANE5ThqQejHBCRRKjz5fzige2eyF13OQdaXqUEq2mAZrKH61TVEysiRBKs45OFo60B25AzZAsRyPNtwrUIRtOvwCe+x9DKv5ZWd20vAUnPRtBhCx/asIeRCafmYMAj1Q7c=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3902.namprd12.prod.outlook.com (2603:10b6:208:169::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 08:54:05 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 08:54:05 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIDIvNF0gZHJtL2FtZGdwdTogVVZEIGF2?=
 =?UTF-8?Q?oid_memory_allocation_during_IB_test?=
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210910003828.4013-1-xinhui.pan@amd.com>
 <20210910003828.4013-2-xinhui.pan@amd.com>
 <005bbb06-034d-6cdf-7c61-1d0339b2e54d@amd.com>
 <DM4PR12MB5165533F0F3EB7FE1F14CD6D87D69@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9393c355-0d63-d4f5-1ecb-1ec9fa392a85@amd.com>
Date: Fri, 10 Sep 2021 10:53:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM4PR12MB5165533F0F3EB7FE1F14CD6D87D69@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::24) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM0P190CA0014.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.15 via Frontend Transport; Fri, 10 Sep 2021 08:54:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bafac68-67d4-40ac-aef9-08d974388b17
X-MS-TrafficTypeDiagnostic: MN2PR12MB3902:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3902FEDA261F59DE65A4328A83D69@MN2PR12MB3902.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aj6uCv64G4VPSPLUbNbFRTLT2TLY8XukinDqV8PF8U3SfQkqKU0iECd26hoLHoQGKowi9rTAp6p9TQlIWVfNEU/vUcsv9D+nUbJcM9KGstwKipJ7Ljk7ELg1YffHs2FtK+Oq3biWklI0f1TaiPcVb5UY6Xg/RYgz4rXg+XDsNDYAmEFdbA9cno+DI4QJPqC4O7tfU2/FpAWz10N/gvwdQIE7+RRlVBQiWCc3sUZF/Jxmrt0QOWk7oqlbt5YSgDvto0p/E6P3icn64wl7MVi2ovOOinX3BW/frLNYHeUHZQchV3mjipIZbbMDhdgzngUUgKLpjRGuZF02+wFEszJEpb2aY7VHVgiRW4S4O/S4wwn+7ym12kyTPAWvb1QDWeHDQhZiEAEQybsu1I5u8xMw+xpXWvU9xZt5lmV95WEPIWZQBbjm24wTNBPdY8rc6tIckE2Ge1XNFtdeP3dFF/mcwFGBwmEAeZZIjLNKlXK4KwjILIwpYmRqjlukJhPi68IJ6f0VS6MNlrGB6dCr+J1W3Bkr4meUPy5zRO+5aoZkpd/N/z294qtqKsoXj8jQ4MEVtWKYbxBBxHdJWVVXnovY8d8aR8EuA5oub6V4ucEpv98g7ScUT7DYrSSfRz5j3C4Wq8bki6UEAc4xQjbQFoOIL11yq/26MhL8l+qgB9Fpnld6HVuMUvEkoOU5CCG0LXoXdXE2Yf5TApnY6bJO0W7WQgZFsWXqH8+/FgYZmxX9aH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(6666004)(4326008)(224303003)(2906002)(66476007)(26005)(5660300002)(316002)(16576012)(2616005)(66556008)(956004)(66946007)(110136005)(83380400001)(186003)(31686004)(8936002)(38100700002)(86362001)(6486002)(31696002)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?RVpIRXZHNUlKMmV5ZjRMOFd0aWZtUE1ySmJSTGJhMmJkd1VkcGVGSXhFdFJ3?=
 =?gb2312?B?TmdzL21LM2k5ZjVndzhxdW9BRGxpcGJ6Q2IxUHNsTkdBNkI5TVhqOWhIWG5I?=
 =?gb2312?B?T0VYWHJQSFdyWnpiTkxycGZFcVNOSmNCNm9Ya0p0TGc3dFRmS2VZT2FKTmZ1?=
 =?gb2312?B?NG9sUlJ4RnU2YnBKOEpZZ3Y0WHpOMzQ4V1hrSkFqbGVsM2lNckQ4MjlFSGd4?=
 =?gb2312?B?b0RRVXU3MWpYd1VxUitVVDJzM2tvSU9sdGY5L0tqaCtLK3EyOGZsQ21JYnUr?=
 =?gb2312?B?OFV0NUl4a0o3STNrNlorUy9hemkxczB6S01vRnB1TEwxOG55cFM0d3lwQ2Zl?=
 =?gb2312?B?R2ZFYUc3U2hmK0JxR2J3UFREeHY1dHF5MXVFbkl1NENnUEQ0czRuZEpOWnVo?=
 =?gb2312?B?NkQxK2xIMDlaNFIrTzA4ZzFvdmJQbWFxaTBNRlc4TEd0UGNsSDkxblJyOTVx?=
 =?gb2312?B?bzhMN0k5dkFVMGdsRU5SeHZPdzJYcUVJcDRoK0hEVjVnNFBabDU3SmpoMG9p?=
 =?gb2312?B?U0M1SlZQVXNoQ2diRE9RK2NLVFgxa0pQR1gvU29pb0I0eDNFK2ZOelRKbHIw?=
 =?gb2312?B?SHJkaTNPYjV4VmdKRFc2U0ZVemJncFR3bnhtWXB0WVRTZEsrKzNMeHVxNFBM?=
 =?gb2312?B?K2o3YnhGMjlkbXhSOGptc0phaWVJY3dzRldYR3RPWXVtVktZaU5HM2krR1VK?=
 =?gb2312?B?V01HK0lSN3Y1K1dMOHE2STJuVm5iUHNodk9QSGZhWkdKaFUzTVhHTGdkS0o3?=
 =?gb2312?B?YlZRaEt1Z3lzNEZMWm9yc3ZmSXNtSGlOd1dmQ1c4NW9oWCt1WE90U2hPOGNE?=
 =?gb2312?B?cXJ1U0QweXZCNXFTQi9PMTExNTBkc3pPMGd4U2EvRzllU0M4MGJ2akZsSjA3?=
 =?gb2312?B?OFNYcWRiL0JnNzFiQmVDOXhYYUI2VzBjc20yeTk5blVHdjlzKzVucGp0Tldy?=
 =?gb2312?B?VE4vSVdUV1dISlNZd0lJNmN3SkxwOFEwb0pVU0RkaHlETDVHcXVmWlp4VkFU?=
 =?gb2312?B?K1kxQWdvMzIyMFVRM3ZyRHBqcUo2WGZPZjM0aGZGclNFckljTXNSTVBzZWJy?=
 =?gb2312?B?RC9mOXZmWVl1Z2szNE5xd203M1gxSkp6dlhRekFvcmtkTXBzZFBDek8vV1Mw?=
 =?gb2312?B?NG5uME9qREZaYUJVQzBYMVg4S0hLQThPN1FaSWhhd05WRFM4Z2NMc3p2ZlRl?=
 =?gb2312?B?L3NRYXBqTGtKQm4wazJVaFVJSzhDMTZhU0IyUTFsZWJRY3R3YlFkQ0xIclhY?=
 =?gb2312?B?Y2o1c1hZbDhsR3QzNktiOUUvWjh0Mkc2b1BKaXg2VDF3UVFaaEtKZ0ZZdUlm?=
 =?gb2312?B?akcyNUg2UkxLa2JpUnpFWDNTTndpd0d2b2Z1NDF3MHAyQWtST3B3NldSQ1hI?=
 =?gb2312?B?SFAvVmJMYmFwK09NaGpVelVlQmRvRk1DNGVocGZFZnQydlo5QVJLbzVXV21h?=
 =?gb2312?B?WG1aeE9vekJSLzFvR2o5V3ViZmhrdVNJTk9TV0VpUGNLQ1kvcGczSmh2bVEr?=
 =?gb2312?B?UGQvS09tSXRnQThMRUk5QTU3YnBiQk92bk1yc1NkRlJHNUw5Wml5NUV1Mi9o?=
 =?gb2312?B?anNXd05FRzlUbkw0YVRiTXdobGJQYzQ5TGdDT0lLQ1FjUW1jNXo3bStOTExn?=
 =?gb2312?B?OXJ0UGgvL2VFYndoSm9jTGZnRFhOTTlXSU12ZFFiRVVSWEJFMWpWRFRpS1pi?=
 =?gb2312?B?cENJSmw4cHNzKzl2NWFPQ2NST3Awamdtc1l0cW1WOGhWMk1ENFh2QVhUTjhR?=
 =?gb2312?Q?6HGmWuFhgypG36eJIpxYG2UJgyYpXH1Mf/4Elfe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bafac68-67d4-40ac-aef9-08d974388b17
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 08:54:05.1990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4NbT1pDTXZ9HZCEzFW2wuyPHFeGxiw+RDQwzDDYVJcj/Nnnd4eUoCxnD3ZZhK/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3902
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It should not unless we are OOM which should not happen during driver 
initialization.

But there is another problem I'm thinking about: Do we still use UVD IB 
submissions to forcefully tear down UVD sessions when a process crashes?

If yes that stuff could easily deadlock with an IB test executed during 
GPU reset.

Christian.

Am 10.09.21 um 10:18 schrieb Pan, Xinhui:
> [AMD Official Use Only]
>
> I am wondering if amdgpu_bo_pin would change BO's placement in the futrue.
> For now, the new placement is calculated by new = old ∩ new.
>
> ________________________________________
> 发件人: Koenig, Christian <Christian.Koenig@amd.com>
> 发送时间: 2021年9月10日 14:24
> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
> 抄送: Deucher, Alexander
> 主题: Re: [PATCH 2/4] drm/amdgpu: UVD avoid memory allocation during IB test
>
> Am 10.09.21 um 02:38 schrieb xinhui pan:
>> move BO allocation in sw_init.
>>
>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 75 +++++++++++++++----------
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |  1 +
>>    drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |  8 +--
>>    drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |  8 +--
>>    4 files changed, 49 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> index d451c359606a..e2eaac941d37 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> @@ -141,6 +141,8 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>        const char *fw_name;
>>        const struct common_firmware_header *hdr;
>>        unsigned family_id;
>> +     struct amdgpu_bo *bo = NULL;
>> +     void *addr;
>>        int i, j, r;
>>
>>        INIT_DELAYED_WORK(&adev->uvd.idle_work, amdgpu_uvd_idle_work_handler);
>> @@ -298,9 +300,34 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>                adev->uvd.filp[i] = NULL;
>>        }
>>
>> +     r = amdgpu_bo_create_reserved(adev, 128 << 10, PAGE_SIZE,
>> +                     AMDGPU_GEM_DOMAIN_GTT,
>> +                     &bo, NULL, &addr);
>> +     if (r)
>> +             return r;
>> +
>>        /* from uvd v5.0 HW addressing capacity increased to 64 bits */
>> -     if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
>> +     if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0)) {
>>                adev->uvd.address_64_bit = true;
>> +             amdgpu_bo_kunmap(bo);
>> +             amdgpu_bo_unpin(bo);
>> +             r = amdgpu_bo_pin_restricted(bo, AMDGPU_GEM_DOMAIN_VRAM,
>> +                             0, 256 << 20);
> Please keep using amdgpu_uvd_force_into_uvd_segment() and validate here,
> cause I want to remove amdgpu_bo_pin_restricted() sooner or later.
>
>> +             if (r) {
>> +                     amdgpu_bo_unreserve(bo);
>> +                     amdgpu_bo_unref(&bo);
>> +                     return r;
>> +             }
>> +             r = amdgpu_bo_kmap(bo, &addr);
>> +             if (r) {
>> +                     amdgpu_bo_unpin(bo);
>> +                     amdgpu_bo_unreserve(bo);
>> +                     amdgpu_bo_unref(&bo);
>> +                     return r;
>> +             }
>> +     }
>> +     adev->uvd.ib_bo = bo;
>> +     amdgpu_bo_unreserve(bo);
>>
>>        switch (adev->asic_type) {
>>        case CHIP_TONGA:
>> @@ -342,6 +369,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>>                for (i = 0; i < AMDGPU_MAX_UVD_ENC_RINGS; ++i)
>>                        amdgpu_ring_fini(&adev->uvd.inst[j].ring_enc[i]);
>>        }
>> +     amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL, NULL);
>>        release_firmware(adev->uvd.fw);
>>
>>        return 0;
>> @@ -1080,23 +1108,10 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>        unsigned offset_idx = 0;
>>        unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
>>
>> -     amdgpu_bo_kunmap(bo);
>> -     amdgpu_bo_unpin(bo);
>> -
>> -     if (!ring->adev->uvd.address_64_bit) {
>> -             struct ttm_operation_ctx ctx = { true, false };
>> -
>> -             amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
>> -             amdgpu_uvd_force_into_uvd_segment(bo);
>> -             r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>> -             if (r)
>> -                     goto err;
>> -     }
>> -
>>        r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
>>                                     AMDGPU_IB_POOL_DELAYED, &job);
>>        if (r)
>> -             goto err;
>> +             return r;
>>
>>        if (adev->asic_type >= CHIP_VEGA10) {
>>                offset_idx = 1 + ring->me;
>> @@ -1148,8 +1163,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>        }
>>
>>        amdgpu_bo_fence(bo, f, false);
>> -     amdgpu_bo_unreserve(bo);
>> -     amdgpu_bo_unref(&bo);
>>
>>        if (fence)
>>                *fence = dma_fence_get(f);
>> @@ -1159,10 +1172,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>
>>    err_free:
>>        amdgpu_job_free(job);
>> -
>> -err:
>> -     amdgpu_bo_unreserve(bo);
>> -     amdgpu_bo_unref(&bo);
>>        return r;
>>    }
>>
>> @@ -1173,16 +1182,15 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>>                              struct dma_fence **fence)
>>    {
>>        struct amdgpu_device *adev = ring->adev;
>> -     struct amdgpu_bo *bo = NULL;
>> +     struct amdgpu_bo *bo = adev->uvd.ib_bo;
>>        uint32_t *msg;
>>        int r, i;
>>
>> -     r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
>> -                                   AMDGPU_GEM_DOMAIN_GTT,
>> -                                   &bo, NULL, (void **)&msg);
>> +     r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>>        if (r)
>>                return r;
>>
>> +     msg = amdgpu_bo_kptr(bo);
>>        /* stitch together an UVD create msg */
>>        msg[0] = cpu_to_le32(0x00000de4);
>>        msg[1] = cpu_to_le32(0x00000000);
>> @@ -1198,23 +1206,25 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>>        for (i = 11; i < 1024; ++i)
>>                msg[i] = cpu_to_le32(0x0);
>>
>> -     return amdgpu_uvd_send_msg(ring, bo, true, fence);
>> +     r = amdgpu_uvd_send_msg(ring, bo, true, fence);
>> +
>> +     amdgpu_bo_unreserve(bo);
>> +     return r;
>>    }
>>
>>    int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>>                               bool direct, struct dma_fence **fence)
>>    {
>>        struct amdgpu_device *adev = ring->adev;
>> -     struct amdgpu_bo *bo = NULL;
>> +     struct amdgpu_bo *bo = adev->uvd.ib_bo;
>>        uint32_t *msg;
>>        int r, i;
>>
>> -     r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
>> -                                   AMDGPU_GEM_DOMAIN_GTT,
>> -                                   &bo, NULL, (void **)&msg);
>> +     r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
> Please use amdgpu_bo_reserve() here and elsewhere as well just to be on
> the clean side.
>
> Lockdep will sooner or later complain that we reserve a BO in the reset
> path, but that is mostly a theoretical problem and existed before. So
> I'm fine with sticking with that for now cause the problem was there
> before as well.
>
> It's just that trylock might not work because the BO is busy with
> indirect submission.
>
> Apart from those two minor issues the patch looks good to me.
>
> Thanks,
> Christian.
>
>>        if (r)
>>                return r;
>>
>> +     msg = amdgpu_bo_kptr(bo);
>>        /* stitch together an UVD destroy msg */
>>        msg[0] = cpu_to_le32(0x00000de4);
>>        msg[1] = cpu_to_le32(0x00000002);
>> @@ -1223,7 +1233,10 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>>        for (i = 4; i < 1024; ++i)
>>                msg[i] = cpu_to_le32(0x0);
>>
>> -     return amdgpu_uvd_send_msg(ring, bo, direct, fence);
>> +     r = amdgpu_uvd_send_msg(ring, bo, direct, fence);
>> +
>> +     amdgpu_bo_unreserve(bo);
>> +     return r;
>>    }
>>
>>    static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>> index edbb8194ee81..76ac9699885d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>> @@ -68,6 +68,7 @@ struct amdgpu_uvd {
>>        /* store image width to adjust nb memory state */
>>        unsigned                decode_image_width;
>>        uint32_t                keyselect;
>> +     struct amdgpu_bo        *ib_bo;
>>    };
>>
>>    int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> index bc571833632e..301c0cea7164 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> @@ -332,12 +332,10 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
>>    static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>    {
>>        struct dma_fence *fence = NULL;
>> -     struct amdgpu_bo *bo = NULL;
>> +     struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
>>        long r;
>>
>> -     r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
>> -                                   AMDGPU_GEM_DOMAIN_VRAM,
>> -                                   &bo, NULL, NULL);
>> +     r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>>        if (r)
>>                return r;
>>
>> @@ -357,9 +355,7 @@ static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>
>>    error:
>>        dma_fence_put(fence);
>> -     amdgpu_bo_unpin(bo);
>>        amdgpu_bo_unreserve(bo);
>> -     amdgpu_bo_unref(&bo);
>>        return r;
>>    }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> index b6e82d75561f..efa270288029 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> @@ -338,12 +338,10 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handl
>>    static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>    {
>>        struct dma_fence *fence = NULL;
>> -     struct amdgpu_bo *bo = NULL;
>> +     struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
>>        long r;
>>
>> -     r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
>> -                                   AMDGPU_GEM_DOMAIN_VRAM,
>> -                                   &bo, NULL, NULL);
>> +     r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>>        if (r)
>>                return r;
>>
>> @@ -363,9 +361,7 @@ static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>
>>    error:
>>        dma_fence_put(fence);
>> -     amdgpu_bo_unpin(bo);
>>        amdgpu_bo_unreserve(bo);
>> -     amdgpu_bo_unref(&bo);
>>        return r;
>>    }
>>

