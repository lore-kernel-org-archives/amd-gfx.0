Return-Path: <SRS0=mrdw=6P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E41C47253
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 14:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26FA720857
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 14:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IF783NLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FA720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E63916ECBD;
	Fri,  1 May 2020 14:44:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A65D46ECBD
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2020 14:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lT+K5u5HYrzCxUKP3dIZ9W5WfndG4eQFhPWGA+1ESbtr5+FVocRQpq0CKHd4Eochdeg7GzMlVUuEuDPVjPunnJqRmjjAB3BmysdKtxZr5ghjkgj1WwOEDQqa0RRKgSMnurBCAkU8RcwQCv/sGgzw4ZZI7oFivmXJHViNEQDm5Wjl7sgW7ShClHPjxDdMG4Z2Tw762LT4qTjQxezYs6ppzxiZdrcct4mnJAU7RNOYeFXUp9WNXrM9fwpZb6Yu3Xqa4rO+EoaYvXZxHdrhXgZ6xoxXlHMObx4kitFjax0hKNGBbcOxCq6MZQYWfGEVuWv6qL3hp2a/sVhnNPRBdA2n5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9u4o6jLRr5bzmwBm3b7pj/18Qgh1u3IjxORKVK3Vqc=;
 b=cwqQlcpP8QgMJXoDdT0ICVSndQ0jWRgDR7eV1XLw+GXutmyvtykPu6MIRkgoE0nVgKPIiqQLd3Ed20H5PGRl8eRwOGhnfzE60EajiY8zcHAMSKhMxHCPxU1qrAtRI49W/LfsQsc3TR8jOhA4TY4rUhIrYSiW+8x6V7FvPZdTc4ZkeszqbnYhdp5L+lne9D8jJ5HskCugkYp1xyldnKMJOmBocz63SiiAFrkkNW38wy97ulgeViRq4qsmOjTHL6F4G1UVbQUDZpVrlbt74/pAwwhNZmzkSfgH/7I5D/G3HQ7giZiCq2G4r5/FiDkWpVPohLcoPdqXO4Mvc7WKSNdNqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9u4o6jLRr5bzmwBm3b7pj/18Qgh1u3IjxORKVK3Vqc=;
 b=IF783NLf6ggkcjEeclKHhgnHM6SYzDcepUlvaT3C3TD28fjf3aMDPsLcYNfafSZP9Qhb3ODjx4D/veKJs8MQFLD85Q2ZFR44o7/5bfEspEN4Z6//q7Hq+lHNWc7c6aCnmGx9B43Uqc02pOeClzX/1u5pPmpptpOZQ6gc52/RaEc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (52.132.199.31) by
 SN1PR12MB2368.namprd12.prod.outlook.com (52.132.201.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20; Fri, 1 May 2020 14:44:07 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2937.028; Fri, 1 May 2020
 14:44:07 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: Take a reference to an exported BO
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20200501142127.14202-1-Felix.Kuehling@amd.com>
 <70e5d202-34ed-532f-e6b6-c195a3effad3@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <551849ec-bc90-0bd2-d46c-f6d8e5c0fee0@amd.com>
Date: Fri, 1 May 2020 10:44:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <70e5d202-34ed-532f-e6b6-c195a3effad3@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Fri, 1 May 2020 14:44:06 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92ac3b74-faf2-4263-b890-08d7edde1a00
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:|SN1PR12MB2368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23688CC6099803FABBBA683B92AB0@SN1PR12MB2368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0390DB4BDA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oiMYk8Bka8jcF4/t/9nxuVxF82z3nKmU0DQ7HJCZU0RqfHI/tjN/cfzA0LqaLcBjJ+ssWT1nCCgPMZu19eSX7KHuSvyg5ivnpY3K2kgRpYu6TiGqhh0vuHfr+UIQjJJNbdGADvgISK/LnNhKCqHI59/Y4ht6mB5iShbje+vVSYLLeUZzrvZ6X12I34ApDWQuf9E6B5i8zB4Rw4aeDvi32+d2q/i82BLNqkFOXhmOwyuedIwrAl+3b989xuMtUpEMq6pSoJBbC4uR716gZgblZpreNuhwPnZ3oJmV3TpS6MqtYsPlRC9nzw+e0GQazf7iwLLPvriMnsdBow1KnbPx6WTeOgwntzHMkSkeDSskamyffqi7o0coHrR2I46c9AwrJPwdudNPNreEKuo61T3mphbUb1LcZN+zZqyyc0GywydvvihoB1243mOWcDARWQpU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(6486002)(2616005)(956004)(86362001)(478600001)(316002)(16576012)(33964004)(36756003)(66574012)(16526019)(52116002)(186003)(26005)(5660300002)(8676002)(2906002)(31686004)(31696002)(44832011)(66946007)(8936002)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1bfGSMFHvNU9MUTcboq88kEbsTW+XGSWT3+hQEqBKc+T7Qzz0tLvGWslEd1BAyAkYOf7D/OOVqVrpnxpSthJsHY1zJQjAzQwIOmTlRwBhl8JP2miwCKZUb0gO4D0uXw56XTS0J8JJv1/FCDiMGap4GzGfrSxAqDTUw7g/0Rt1ZG69qH9a8WleYJ6q/cnx2vEqY6rLLW2Q3NoIcsGkoVPWZcq5Cqa4iO+nAgShvP771ELiy0bKy0hJ60sOFC5MTjwLy/eNr1hfEQOChHddfkdjfVCrHvcwCsXEVF9zfDisfvuCBd//tKzFayiBXuyq1/SYsY0rAaEYZ+F0B+EiuhvL0zim1HgRgPFbVfVO33X2AHQg2MfgVIJh1+R1EhJrjV8ku/wx143a+z5jfKODPl4jyB2bH2jF2cATjn3i6uwQC2YyAfjq4rZQmxo3y80SitRLiDAaOxvRHHwISEc5SqryQJ4MzGeVw3vu9ijpSTKeHtiUkGsSh6pSlnRCtIhG3girB2T6wwqB/3pobwuqs1ViKuyA+YktdGlfr78UqAdpO6oKykkLQlsPdf2oYINJ0dCf372ZnKA1xuTN6Xzc8MLPfN/oi1TIEJzvXZD6FDLYIPMqMUnM6ukOGsnR2tWkhjcCYsk2dLUls4WQyxhL/zz8y2xFTdcCBBadEK3mKue9iw7FcvdsRLwl4rq+C7cJY3t74bvP95fAfvEFuPHJfqHpjtN4CDjeLcZBvAcMIFFTT2PuFEHp2Z6WNSbSUhurVu0klnXN7JRHZrjDxdXiqNhV8TWCtfBiHaGdS3mYREJ26I=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ac3b74-faf2-4263-b890-08d7edde1a00
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 14:44:07.5449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMJbXM6Tt0zl1Oi6aSFiSX2Whr3i9E/hQz2pVRPQtvMwnfyYL/3X0GqgcblI6K2+MZeIotyf/1KKgmfOwl2YAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2368
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
Content-Type: multipart/mixed; boundary="===============1211166943=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1211166943==
Content-Type: multipart/alternative;
 boundary="------------2D4887FD1CCBD0C2AFC042B7"
Content-Language: en-US

--------------2D4887FD1CCBD0C2AFC042B7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

[dropping my gmail address]

We saw this backtrace showing the call chain while investigating a
kernel oops caused by this issue on the DKMS branch with the KFD IPC
API. It happens after a dma-buf file is released with fput:

[ 1255.049330] BUG: kernel NULL pointer dereference, address: 000000000000051e
[ 1255.049727] #PF: supervisor read access in kernel mode
[ 1255.050092] #PF: error_code(0x0000) - not-present page
[ 1255.050416] PGD 0 P4D 0
[ 1255.050736] Oops: 0000 [#1] SMP PTI
[ 1255.051060] CPU: 27 PID: 2292 Comm: kworker/27:2 Tainted: G           OE     5.3.0-46-generic #38~18.04.1-Ubuntu
[ 1255.051400] Hardware name: Supermicro SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 3.0a 02/26/2019
[ 1255.051752] Workqueue: events delayed_fput
[ 1255.052111] RIP: 0010:drm_gem_object_put_unlocked+0x1c/0x70 [drm]
[ 1255.052465] Code: 4d 80 c8 ee 0f 0b eb d8 66 0f 1f 44 00 00 0f 1f 44 00 00 48 85 ff 74 34 55 48 89 e5 41 54 53 48 89 fb 48 8b 7f 08 48 8b 47 20 <48> 83 b8 a0 00 00 00 00 74 1a 4c 8d 67 68 48 89 df 4c 89 e6 e8 9b
[ 1255.053224] RSP: 0018:ffffb4b62035fdc8 EFLAGS: 00010286
[ 1255.053613] RAX: 000000000000047e RBX: ffff9f2add197850 RCX: 0000000000000000
[ 1255.054032] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9f2aa2548aa0
[ 1255.054440] RBP: ffffb4b62035fdd8 R08: 0000000000000000 R09: 0000000000000000
[ 1255.054860] R10: 0000000000000010 R11: ffff9f2a4b1cc310 R12: 0000000000080005
[ 1255.055268] R13: ffff9f2a4b1cc310 R14: ffff9f4e369161e0 R15: ffff9f2a1b2f9080
[ 1255.055674] FS:  0000000000000000(0000) GS:ffff9f4e3f740000(0000) knlGS:0000000000000000
[ 1255.056087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1255.056501] CR2: 000000000000051e CR3: 00000002df00a004 CR4: 00000000007606e0
[ 1255.056923] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1255.057345] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1255.057763] PKRU: 55555554
[ 1255.058179] Call Trace:
[ 1255.058603]  drm_gem_dmabuf_release+0x1a/0x30 [drm]
[ 1255.059025]  dma_buf_release+0x56/0x130
[ 1255.059443]  __fput+0xc6/0x260
[ 1255.059856]  delayed_fput+0x20/0x30
[ 1255.060272]  process_one_work+0x1fd/0x3f0
[ 1255.060686]  worker_thread+0x34/0x410
[ 1255.061099]  kthread+0x121/0x140
[ 1255.061510]  ? process_one_work+0x3f0/0x3f0
[ 1255.061923]  ? kthread_park+0xb0/0xb0
[ 1255.062336]  ret_from_fork+0x35/0x40

drm_gem_object_put_unlocked calls drm_gem_object_free when the
obj->refcount reaches 0. From there it calls
dev->driver->gem_free_object_unlocked, which is amdgpu_gem_object_free
in amdgpu.

Regards,
  Felix

Am 2020-05-01 um 10:29 a.m. schrieb Christian König:
> Am 01.05.20 um 16:21 schrieb Felix Kuehling:
>> From: Felix Kuehling <felix.kuehling@gmail.com>
>>
>> That reference gets dropped when the the dma-buf is freed. Not
>> incrementing
>> the refcount can lead to use-after-free errors.
>>
>> Signed-off-by: Felix Kuehling <felix.kuehling@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> index ffeb20f11c07..a0f9b3ef4aad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> @@ -398,8 +398,15 @@ struct dma_buf *amdgpu_gem_prime_export(struct
>> drm_gem_object *gobj,
>>           return ERR_PTR(-EPERM);
>>         buf = drm_gem_prime_export(gobj, flags);
>> -    if (!IS_ERR(buf))
>> +    if (!IS_ERR(buf)) {
>>           buf->ops = &amdgpu_dmabuf_ops;
>> +        /* GEM needs a reference to the underlying object
>> +         * that gets dropped when the dma-buf is released,
>> +         * through the amdgpu_gem_object_free callback
>> +         * from drm_gem_object_put_unlocked.
>> +         */
>> +        amdgpu_bo_ref(bo);
>> +    }
>
> Of hand that doesn't sounds correct to me. Why should the exported bo
> be closed through amdgpu_gem_object_free()?
>
> Regards,
> Christian.
>
>>         return buf;
>>   }
>

--------------2D4887FD1CCBD0C2AFC042B7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>[dropping my gmail address]</p>
    <p>We saw this backtrace showing the call chain while investigating
      a kernel oops caused by this issue on the DKMS branch with the KFD
      IPC API. It happens after a dma-buf file is released with fput:</p>
    <pre>[ 1255.049330] BUG: kernel NULL pointer dereference, address: 000000000000051e
[ 1255.049727] #PF: supervisor read access in kernel mode
[ 1255.050092] #PF: error_code(0x0000) - not-present page
[ 1255.050416] PGD 0 P4D 0
[ 1255.050736] Oops: 0000 [#1] SMP PTI
[ 1255.051060] CPU: 27 PID: 2292 Comm: kworker/27:2 Tainted: G           OE     5.3.0-46-generic #38~18.04.1-Ubuntu
[ 1255.051400] Hardware name: Supermicro SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 3.0a 02/26/2019
[ 1255.051752] Workqueue: events delayed_fput
[ 1255.052111] RIP: 0010:drm_gem_object_put_unlocked&#43;0x1c/0x70 [drm]
[ 1255.052465] Code: 4d 80 c8 ee 0f 0b eb d8 66 0f 1f 44 00 00 0f 1f 44 00 00 48 85 ff 74 34 55 48 89 e5 41 54 53 48 89 fb 48 8b 7f 08 48 8b 47 20 &lt;48&gt; 83 b8 a0 00 00 00 00 74 1a 4c 8d 67 68 48 89 df 4c 89 e6 e8 9b
[ 1255.053224] RSP: 0018:ffffb4b62035fdc8 EFLAGS: 00010286
[ 1255.053613] RAX: 000000000000047e RBX: ffff9f2add197850 RCX: 0000000000000000
[ 1255.054032] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9f2aa2548aa0
[ 1255.054440] RBP: ffffb4b62035fdd8 R08: 0000000000000000 R09: 0000000000000000
[ 1255.054860] R10: 0000000000000010 R11: ffff9f2a4b1cc310 R12: 0000000000080005
[ 1255.055268] R13: ffff9f2a4b1cc310 R14: ffff9f4e369161e0 R15: ffff9f2a1b2f9080
[ 1255.055674] FS:  0000000000000000(0000) GS:ffff9f4e3f740000(0000) knlGS:0000000000000000
[ 1255.056087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1255.056501] CR2: 000000000000051e CR3: 00000002df00a004 CR4: 00000000007606e0
[ 1255.056923] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1255.057345] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1255.057763] PKRU: 55555554
[ 1255.058179] Call Trace:
[ 1255.058603]  drm_gem_dmabuf_release&#43;0x1a/0x30 [drm]
[ 1255.059025]  dma_buf_release&#43;0x56/0x130
[ 1255.059443]  __fput&#43;0xc6/0x260
[ 1255.059856]  delayed_fput&#43;0x20/0x30
[ 1255.060272]  process_one_work&#43;0x1fd/0x3f0
[ 1255.060686]  worker_thread&#43;0x34/0x410
[ 1255.061099]  kthread&#43;0x121/0x140
[ 1255.061510]  ? process_one_work&#43;0x3f0/0x3f0
[ 1255.061923]  ? kthread_park&#43;0xb0/0xb0
[ 1255.062336]  ret_from_fork&#43;0x35/0x40
</pre>
    <p>drm_gem_object_put_unlocked calls drm_gem_object_free when the
      obj-&gt;refcount reaches 0. From there it calls
      dev-&gt;driver-&gt;gem_free_object_unlocked, which is
      amdgpu_gem_object_free in amdgpu.<br>
    </p>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
    <div class="moz-cite-prefix">Am 2020-05-01 um 10:29 a.m. schrieb
      Christian König:<br>
    </div>
    <blockquote type="cite" cite="mid:70e5d202-34ed-532f-e6b6-c195a3effad3@gmail.com">Am
      01.05.20 um 16:21 schrieb Felix Kuehling:
      <br>
      <blockquote type="cite">From: Felix Kuehling
        <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@gmail.com">&lt;felix.kuehling@gmail.com&gt;</a>
        <br>
        <br>
        That reference gets dropped when the the dma-buf is freed. Not
        incrementing
        <br>
        the refcount can lead to use-after-free errors.
        <br>
        <br>
        Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@gmail.com">&lt;felix.kuehling@gmail.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-
        <br>
        &nbsp; 1 file changed, 8 insertions(&#43;), 1 deletion(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
        <br>
        index ffeb20f11c07..a0f9b3ef4aad 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
        <br>
        &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
        <br>
        @@ -398,8 &#43;398,15 @@ struct dma_buf
        *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ERR_PTR(-EPERM);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf = drm_gem_prime_export(gobj, flags);
        <br>
        -&nbsp;&nbsp;&nbsp; if (!IS_ERR(buf))
        <br>
        &#43;&nbsp;&nbsp;&nbsp; if (!IS_ERR(buf)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf-&gt;ops = &amp;amdgpu_dmabuf_ops;
        <br>
        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GEM needs a reference to the underlying object
        <br>
        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * that gets dropped when the dma-buf is released,
        <br>
        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * through the amdgpu_gem_object_free callback
        <br>
        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * from drm_gem_object_put_unlocked.
        <br>
        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_ref(bo);
        <br>
        &#43;&nbsp;&nbsp;&nbsp; }
        <br>
      </blockquote>
      <br>
      Of hand that doesn't sounds correct to me. Why should the exported
      bo be closed through amdgpu_gem_object_free()?
      <br>
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return buf;
        <br>
        &nbsp; }
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------2D4887FD1CCBD0C2AFC042B7--

--===============1211166943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1211166943==--
