Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35796C433E5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 14:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E922072D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 14:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vLAQYFxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E922072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B2756E11E;
	Mon, 13 Jul 2020 14:13:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 473C16E11E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 14:13:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTwQ65C4zGCXrUhW0Du5U+dFepMQDDcxGTRiXmaPMQJ1GPaloF4yDKkqdra33dH01Femv9YpTqCuLviBxr77Snbzx19npTIzaNzebQeDZIH+XHZhYf966ChJQUzv2os3vmmUus0CTcqgfuoXedpd9QEJl2Hf/dZ0mybtu3oVnRXiAYBA5ojBduq4BJcyIDKfHHXeKBWr1hq6nRnUjos04d1LN6QD82NzEfh7eLLKVKpxn3C9wrENLu8ATyHlqOwLjpH0DcqokqI5dRDF+9q6owH62mDuyLHoynWylg//nVDmxhvXKuMJ/7pAt/QGTFbIbvNXaevsDNZVDanTghUh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLJOajQ01SAoM6Somd9lNBvE9G1mh9ooZZdE/IBiVU0=;
 b=BqNG2x4cAf/EGdjDSxCN//e5lrKEt3tpGpGvzl5JJ5/WrCsfbnnfDT60Z2VSXLXcK0RF7O1VamnM7cT5WQo8fkyAkP48wAdVqTWQzNv68p2JjYCf1K0wq9ARJmOiY5RgIrTjz2iTRnWlOR9K1OutXqqxATUnV5z9v2K8keWklzKLsxy1JHKrvosHmy69Fx1ZFrIgKwmxHuMU1KPluB8taK1rpJrX2F5spUnXQ2wNinffsMvZaCP7sjW409dAtjAZS14QYNdUOq8zBCTrLpAE68nrUHrCSE5yTBSGPcoOOu3to6I9RVNubgSZ68LcAwg42QzS6EtIoYRs92ytd+tMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLJOajQ01SAoM6Somd9lNBvE9G1mh9ooZZdE/IBiVU0=;
 b=vLAQYFxcx9DxVRYs8lsBXWE0YqjmpIAbBxmUzJlwQJpiL4pEgNZpamYahGsI1s+KnIK2DQ1LUrT9q8j9Wh5UEaysTWhGHVY60qj6AHRXouZnnUZ6zLtIHhf/pkases+3uv5OJfKo+bDQA3o61t67jGxDvjR8DaLcVbzOX8fd70Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 14:13:12 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 14:13:12 +0000
Subject: Re: [PATCH] drm/amdgpu: use ARRAY_SIZE() to add amdgpu debugfs files
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200713055950.19611-1-xiaojie.yuan@amd.com>
 <59e9b843-ee3f-2b70-f9eb-f96289be3a9a@gmail.com>
 <MW2PR12MB2586787CBB596190ECDF754789600@MW2PR12MB2586.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1297674c-e2c5-4e71-a477-02ecc7ea6549@amd.com>
Date: Mon, 13 Jul 2020 16:13:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <MW2PR12MB2586787CBB596190ECDF754789600@MW2PR12MB2586.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0179.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::48) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR01CA0179.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Mon, 13 Jul 2020 14:13:11 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb696a98-1aa9-43bb-8ec2-08d82736e050
X-MS-TrafficTypeDiagnostic: MN2PR12MB3775:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3775200910948DD350E9A7D583600@MN2PR12MB3775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uh9HGLb97pN/PL+75mlSu2BlPy3hYtLp7e2K0kOhxYEmrcRYzPwK/IhTk5Gb1nEz62WbGoWR4MxElzzndSC5vaN95zQv5t/C8KyTCADG6Ri36kNx9t+hfi1SHtNS01e3N2tH5EBFV4D7ImjJBHXKsqN5zdpHwzn4wpfRXecpCUS0Kahgl8O2noKyRjnMaBjY0Ytk+xz+uKzJidnYs2pESMk+HsXUoRhmJcUwjlFaOBGSrWjWQ/ryF/AK9cJ+3CLVQJlrSJdoXM3/WX3jCaUamslUtrCtZYaO+Ne5tW/GniILrUCi1R4iEzO0vQapgcpWvMvDUDINcypX4o2leAr8J1V9M5/gCkAlGUSn4XGUQoTslfw82Uvblh3hGbh2J8oQnsdMMzkBugVHc4Ag74A7IJCb7C4P8pyhRl0HykzfveP8axJ+0KXEKY+ow49o4vp59bCWM6s4yc1Ch/KhODEP+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(83380400001)(5660300002)(52116002)(8676002)(166002)(6486002)(66556008)(86362001)(53546011)(8936002)(66476007)(31696002)(110136005)(66946007)(316002)(478600001)(6666004)(33964004)(2906002)(2616005)(31686004)(16526019)(36756003)(186003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HsuqUciQMi1ZIY+ixyRpKVlTTVz+3nnxWez1V8ZRmFC0u4G0V58FGpqn1J3yTSonv+t8k+OQIzZ+t78hjLgpR1+BRi//Cm53AcbNxlIhau1fML1nKlpRc/144Q5pmy4bAdx+Yvekd5xsw73qFRoJ/ux6/TvdI1m0vzH93bPeHrudjXSIzIpdu+Ch++Jhc30FXK7oo3qtWXmBbjecFAdGJjrMfwAnSZ4md/hzxD4EQiTS66GS5ghGPL0z3FzI27CYcd+EAaKwETLWKiL/Gzp1yQfWzlpvoMt7Fd9u82KI82CLUlUoxHYTTFpP6uxjzTT4EIMdUAiHTQVsQdR1kg2x4oZmAnUnY+s7K3Mqf8RenPQSLfCqzyWJxZRXFe6MtE2i/NY4tZ57lfwtk/CyWPptdlVU1RhgEDfuuIl38ewAby3UY8uFgA6C6zyBw+QWTWXxUfajx4r3i/XCUNxy6OuSe3Z5p/KK9jvm6CrGl9EaPl2W/Fv/q/eYDtYjvCZhFaZae6LZIBKE4gQ0vdi3L7xLZuLDQr73/kqBO+ewPmeiB+JfDELAIwWnCrsvEUsnWWAH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb696a98-1aa9-43bb-8ec2-08d82736e050
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 14:13:11.9397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gI6hTw8s2Z2minFzB+RhXOcxdiY+47wvTLRqK9balvNQ/maKPHm3LiDBEg+loN9V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3775
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
Content-Type: multipart/mixed; boundary="===============1837252306=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1837252306==
Content-Type: multipart/alternative;
 boundary="------------5EF197642C9D98959D8E17BB"
Content-Language: en-US

--------------5EF197642C9D98959D8E17BB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.07.20 um 15:34 schrieb Yuan, Xiaojie:
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Chris,
>
> This was observed when I was trying to add a new debugfs file.

In this case please add the new file using debugfs_create_file() 
directly and don't touch this old code.

>   Some similar
> occurrences using ARRAY_SIZE() are:
>
> - amdgpu_kms.c :: amdgpu_firmware_info_list
> - amdgpu_pm.c :: amdgpu_debugfs_pm_info
> - amdgpu_ttm.c :: amdgpu_ttm_debugfs_list
> - amdgpu_dm_debugfs.c :: amdgpu_dm_debugfs_list
>
> This patch simply unified the usage of amdgpu_debugfs_add_files().
>
> BTW, do you intended to use:
> debugfs_create_file() - need to call debugfs_remove() explicitly
> or the drm helper
> drm_debugfs_create_files() - debugfs files will be removed automatically

No, exactly that's the point. All debugfs files are automatically 
removed when the driver unloads because the parent directory is removed.

See the debugfs.h file in the Linux source code:

> void  debugfs_remove 
> <https://elixir.bootlin.com/linux/latest/C/ident/debugfs_remove>(struct  dentry <https://elixir.bootlin.com/linux/latest/C/ident/dentry>  *dentry <https://elixir.bootlin.com/linux/latest/C/ident/dentry>);
> #define debugfs_remove_recursive 
> <https://elixir.bootlin.com/linux/latest/C/ident/debugfs_remove_recursive> 
> debugfs_remove 
> <https://elixir.bootlin.com/linux/latest/C/ident/debugfs_remove>

The whole tracking amdgpu_debugfs_add_files() and the underlying DRM 
function do are completely nonsense and was only added because somebody 
didn't knew that this stuff is automatically removed.

The only functionality amdgpu_debugfs_add_files() still provides is 
protecting to not try to add files twice. And that in turn is a coding 
bug we should probably fix :)

Regards,
Christian.

>
> If so, we need a separate patch to cleanup them in a batch.
>
> BR,
> Xiaojie
>
> ________________________________________
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Monday, July 13, 2020 4:38 PM
> To: Yuan, Xiaojie; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: use ARRAY_SIZE() to add amdgpu debugfs files
>
> Am 13.07.20 um 07:59 schrieb Xiaojie Yuan:
>> to easily add new debugfs file w/o changing the hardcoded list count.
> In general a good idea, but I would rather like to see
> amdgpu_debugfs_add_files() completely removed and debugfs_create_file()
> used directly instead.
>
> Christian.
>
>> Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 ++++--
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c   | 3 ++-
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 3 ++-
>>    3 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index b8ce43c28116..58d4c219178a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -781,8 +781,10 @@ int amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
>>    {
>>    #if defined(CONFIG_DEBUG_FS)
>>        if (amdgpu_sriov_vf(adev))
>> -             return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list_sriov, 1);
>> -     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list, 2);
>> +             return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list_sriov,
>> +                                             ARRAY_SIZE(amdgpu_debugfs_fence_list_sriov));
>> +     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list,
>> +                                     ARRAY_SIZE(amdgpu_debugfs_fence_list));
>>    #else
>>        return 0;
>>    #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 77d988a0033f..8c64d8d6cb82 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -928,7 +928,8 @@ static const struct drm_info_list amdgpu_debugfs_gem_list[] = {
>>    int amdgpu_debugfs_gem_init(struct amdgpu_device *adev)
>>    {
>>    #if defined(CONFIG_DEBUG_FS)
>> -     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_gem_list, 1);
>> +     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_gem_list,
>> +                                     ARRAY_SIZE(amdgpu_debugfs_gem_list));
>>    #endif
>>        return 0;
>>    }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> index 4ffc32b78745..dcd492170598 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> @@ -468,7 +468,8 @@ static const struct drm_info_list amdgpu_debugfs_sa_list[] = {
>>    int amdgpu_debugfs_sa_init(struct amdgpu_device *adev)
>>    {
>>    #if defined(CONFIG_DEBUG_FS)
>> -     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_sa_list, 1);
>> +     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_sa_list,
>> +                                     ARRAY_SIZE(amdgpu_debugfs_sa_list));
>>    #else
>>        return 0;
>>    #endif


--------------5EF197642C9D98959D8E17BB
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 13.07.20 um 15:34 schrieb Yuan,
      Xiaojie:<br>
    </div>
    <blockquote type="cite" cite="mid:MW2PR12MB2586787CBB596190ECDF754789600@MW2PR12MB2586.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">[AMD Official Use Only - Internal Distribution Only]

Hi Chris,

This was observed when I was trying to add a new debugfs file.</pre>
    </blockquote>
    <br>
    In this case please add the new file using debugfs_create_file()
    directly and don't touch this old code.<br>
    <br>
    <blockquote type="cite" cite="mid:MW2PR12MB2586787CBB596190ECDF754789600@MW2PR12MB2586.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap=""> Some similar
occurrences using ARRAY_SIZE() are:

- amdgpu_kms.c :: amdgpu_firmware_info_list
- amdgpu_pm.c :: amdgpu_debugfs_pm_info
- amdgpu_ttm.c :: amdgpu_ttm_debugfs_list
- amdgpu_dm_debugfs.c :: amdgpu_dm_debugfs_list

This patch simply unified the usage of amdgpu_debugfs_add_files().

BTW, do you intended to use:
debugfs_create_file() - need to call debugfs_remove() explicitly
or the drm helper
drm_debugfs_create_files() - debugfs files will be removed automatically</pre>
    </blockquote>
    <br>
    No, exactly that's the point. All debugfs files are automatically
    removed when the driver unloads because the parent directory is
    removed.<br>
    <br>
    See the debugfs.h file in the Linux source code:<br>
    <br>
    <blockquote type="cite">
      <pre><span class="kt">void</span> <span class="nf"><a href="https://elixir.bootlin.com/linux/latest/C/ident/debugfs_remove">debugfs_remove</a></span><span class="p">(</span><span class="k">struct</span> <span class="n"><a href="https://elixir.bootlin.com/linux/latest/C/ident/dentry">dentry</a></span> <span class="o">*</span><span class="n"><a href="https://elixir.bootlin.com/linux/latest/C/ident/dentry">dentry</a></span><span class="p">);</span>
<span class="cp">#define <a href="https://elixir.bootlin.com/linux/latest/C/ident/debugfs_remove_recursive">debugfs_remove_recursive</a> <a href="https://elixir.bootlin.com/linux/latest/C/ident/debugfs_remove">debugfs_remove</a></span></pre>
    </blockquote>
    <br>
    The whole tracking amdgpu_debugfs_add_files() and the underlying DRM
    function do are completely nonsense and was only added because
    somebody didn't knew that this stuff is automatically removed.<br>
    <br>
    The only functionality amdgpu_debugfs_add_files() still provides is
    protecting to not try to add files twice. And that in turn is a
    coding bug we should probably fix :)<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:MW2PR12MB2586787CBB596190ECDF754789600@MW2PR12MB2586.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">

If so, we need a separate patch to cleanup them in a batch.

BR,
Xiaojie

________________________________________
From: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>
Sent: Monday, July 13, 2020 4:38 PM
To: Yuan, Xiaojie; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Subject: Re: [PATCH] drm/amdgpu: use ARRAY_SIZE() to add amdgpu debugfs files

Am 13.07.20 um 07:59 schrieb Xiaojie Yuan:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">to easily add new debugfs file w/o changing the hardcoded list count.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
In general a good idea, but I would rather like to see
amdgpu_debugfs_add_files() completely removed and debugfs_create_file()
used directly instead.

Christian.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Signed-off-by: Xiaojie Yuan <a class="moz-txt-link-rfc2396E" href="mailto:xiaojie.yuan@amd.com">&lt;xiaojie.yuan@amd.com&gt;</a>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 &#43;&#43;&#43;&#43;--
  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c   | 3 &#43;&#43;-
  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 3 &#43;&#43;-
  3 files changed, 8 insertions(&#43;), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index b8ce43c28116..58d4c219178a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -781,8 &#43;781,10 @@ int amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
  {
  #if defined(CONFIG_DEBUG_FS)
      if (amdgpu_sriov_vf(adev))
-             return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list_sriov, 1);
-     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list, 2);
&#43;             return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list_sriov,
&#43;                                             ARRAY_SIZE(amdgpu_debugfs_fence_list_sriov));
&#43;     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list,
&#43;                                     ARRAY_SIZE(amdgpu_debugfs_fence_list));
  #else
      return 0;
  #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 77d988a0033f..8c64d8d6cb82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -928,7 &#43;928,8 @@ static const struct drm_info_list amdgpu_debugfs_gem_list[] = {
  int amdgpu_debugfs_gem_init(struct amdgpu_device *adev)
  {
  #if defined(CONFIG_DEBUG_FS)
-     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_gem_list, 1);
&#43;     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_gem_list,
&#43;                                     ARRAY_SIZE(amdgpu_debugfs_gem_list));
  #endif
      return 0;
  }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 4ffc32b78745..dcd492170598 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -468,7 &#43;468,8 @@ static const struct drm_info_list amdgpu_debugfs_sa_list[] = {
  int amdgpu_debugfs_sa_init(struct amdgpu_device *adev)
  {
  #if defined(CONFIG_DEBUG_FS)
-     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_sa_list, 1);
&#43;     return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_sa_list,
&#43;                                     ARRAY_SIZE(amdgpu_debugfs_sa_list));
  #else
      return 0;
  #endif
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------5EF197642C9D98959D8E17BB--

--===============1837252306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1837252306==--
