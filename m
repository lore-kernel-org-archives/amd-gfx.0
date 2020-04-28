Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01CAC83004
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 03:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB81206D6
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 03:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uZxsjmeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB81206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2214D6E063;
	Tue, 28 Apr 2020 03:22:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AEFC6E063
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 03:22:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljWwTyiEZziZ1Sg4PuzSqVbnzNHn7XXl9zBfqarSBgKIUtyiUF4f6kU1GcREvU3cp65QEaj6TPV7rUhzXxNaD3FgtuRD6PTTkqIP1jjE7MUjqQfc+HNm4pL094UCCfQ0HLLPeyiQ3oBMKX+KmoRM9HOCTNOo0EmWvNjN7JM9dNTZK3oGhiRrIcREMkbfklancJJF9yIBDaF13GAR0L59x0Jmd5cJHjuf66X3jSIA3M8bzJQN224dapvJ/DNVJpWwqDJtdInzqHM09nOF0BBiaEBT04wkDHVMNaPEWOeqse4FFqlBi5QG7vfNFq+ZkC1eJTWGOsEiKZzPQjvKTy0gqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wU8/IrzXPwRqQoX/Ty2fVj/Ab/s38Lxj3VkLgp7g/E=;
 b=SCuLXdRJ733ZFbkgnHS9Jz0Yyj6vHDEqY72uT2/guECCtKIWjTwpHZfspB989xvlsdJqqYV6y9xmPEBcAJdKn2YRebP2lfVYe/YGE7AZtuQ3rwjYlc5UPdBXK/3f9OneSfq2KdY65f3+88jvs0eD09DMXcqOFnpOCjCGYX9lbUuXQrxxWNV+z8xhtJ7INJfQYzI6i9mO22gjAvRkm3+WpdYN40a3cpRRcJiLi6iPyyLisJuAjRcBkbc5bR1Y+0fEN5UTpX5Hjf8CkjYgOlhzwtmRBdCt90/hIJvFQEwowDsRV8dSjt9xh2wH3kprbWxOwoytsi5DTaqtocofVpJugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wU8/IrzXPwRqQoX/Ty2fVj/Ab/s38Lxj3VkLgp7g/E=;
 b=uZxsjmeK6j94dvianYZQTcT9nSrDeKp0obD0k7C4PhSvYkCo4F3XgAsVx7XAQ48JpYeQY0CI1LIYRyeqxEWHaqge9kMyMSnP3aajLd3k0BgDdZaZRm1nwH7wx3BtRraUyfs3/ObuoPsqdmqqOeaQYBaswj5MeEuhAN9BrJ1QYvY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David1.Zhou@amd.com; 
Received: from DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) by
 DM5PR12MB1898.namprd12.prod.outlook.com (2603:10b6:3:10d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Tue, 28 Apr 2020 03:22:44 +0000
Received: from DM5PR12MB2440.namprd12.prod.outlook.com
 ([fe80::557:72a2:dfed:1c28]) by DM5PR12MB2440.namprd12.prod.outlook.com
 ([fe80::557:72a2:dfed:1c28%6]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 03:22:44 +0000
Subject: Re: drm/amdgpu: apply AMDGPU_IB_FLAG_EMIT_MEM_SYNC to compute IBs too
To: christian.koenig@amd.com, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <CAAxE2A64Z91LiB9FduJf-8OO3He+1gZ9sxDfD+BVwc+-9Z7BnA@mail.gmail.com>
 <64c5a883-1933-c494-7a93-dc19e0bd0445@gmail.com>
 <CAAxE2A6Hgnq_zBjQQoa51S7KfVzddjndRGjrJYtjY7v9+vuwDw@mail.gmail.com>
 <328ea10b-1453-371e-7392-54e1a4051715@gmail.com>
 <MN2PR12MB448809E68050B9A61B1CC7FAF7AF0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <CAAxE2A50b_+oX9wmF2D6LZs9GvG9Rhug8AQU40aeDbMDm_kFqw@mail.gmail.com>
 <217db438-608d-d28c-6678-4173a6291d8b@gmail.com>
From: Chunming Zhou <zhoucm1@amd.com>
Message-ID: <305d42a7-5810-b6ca-bfec-bba1b8bd5272@amd.com>
Date: Tue, 28 Apr 2020 11:22:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <217db438-608d-d28c-6678-4173a6291d8b@gmail.com>
X-ClientProxiedBy: HK2PR03CA0060.apcprd03.prod.outlook.com
 (2603:1096:202:17::30) To DM5PR12MB2440.namprd12.prod.outlook.com
 (2603:10b6:4:b6::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.121.145] (180.167.199.185) by
 HK2PR03CA0060.apcprd03.prod.outlook.com (2603:1096:202:17::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.10 via Frontend Transport; Tue, 28 Apr 2020 03:22:42 +0000
X-Originating-IP: [180.167.199.185]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b391287-e5ea-42bb-e5eb-08d7eb236ab9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1898:|DM5PR12MB1898:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18988DB6AC50DAE9B1E8EE54B4AC0@DM5PR12MB1898.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2440.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(8936002)(186003)(6666004)(2616005)(956004)(26005)(110136005)(5660300002)(316002)(16576012)(16526019)(31686004)(2906002)(66574012)(53546011)(6636002)(45080400002)(478600001)(4326008)(31696002)(966005)(36756003)(66946007)(81156014)(66476007)(52116002)(8676002)(33964004)(66556008)(6486002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GlIHIzckls3do+JoghcNZkLpK2xcjikIx7kk2jrnIIKPGfgKBoWkEWl3cExRfoS86v+CIC4Sh+ADGjJawOr41QNjuoEtId4hB+sZLUD8H6cR9r85O00WIygVa8RBOLd1DSqJx9myVGiigmij9+ash0lsZveVxkzy2PB+m5WMPm/WtXDQOIMQ/xHiQ/sg4MXszZMQuzjiW2cKEIy2fpRSQDb2Izo08oyn9zbGnTkk6ZhBYnfEnoMM85SVxqp8xrrmEK+zkH+cohe8G1Mz9kY2GoglfleimC7IQwpj5cKDbVZLMB1hX24bRcQF5xEYds+r1WN51Y3WrTuleZS2B5vUgAcsKL6vrQEqWqXYzq4JwMJ4z/zNOHDWk2QyGrhvKjNc/RAj5LyMIZ8DRJshqI18CIXVu9xg9rB8SMO1fs2s/gRyEKgxaecnfkMVFEL0Z51M9JvLa/Dk4RGcvHpeBt0yLi7IeqXGhwF4KRo43mkqyfc=
X-MS-Exchange-AntiSpam-MessageData: 10gr2Sd9zsdR3306ESPb8f67a7JaDyiLWbcLpxRbPBubw1csYylVwRRvdQTNEJ3TodwTI/nzZwMfdUiAaroAQnesGxnD7EnvgYNJvI1WLDiSwK9Uo/D17FjRcTEUt4EDIrhogNsOZm93ZMGN5bhhPVUNMWI3HJN5eT4wnZbktwkpT/x0ADD8yc16jNs3Tbym3C5nmQ602SQMoYJO0VOp1YL7Qq7i4JU9CRxAaoQ14SFjNYD+UZdIx+UziP67w2V7Jz/41g5yJOnV92eiY63t4GkPJgYgSEMJVcFWO/ayiWNGKJxOL4iILsV6WN3yP9MvKGiFN/5Z0YYDmt5+EDCMKFXp4by2kVwv81Tm61GJZZ6LJJiocfUuu9OW2ZJ9fL5QlCmXnvJ8T1Qoxq5FOa7xb9Dc5DlZPmX3pAugxqco+4W2rUXNprivtSXnGwKEve4F4ku2OsoZJX1u4Zlx7y1DaT3j4nUe4Ft/5KDYYcTPEs96CZxNc19Q6hHSdWq7Xryc650UNYeSFvj44cku/FD0e10g/rW1utkhjhbYDsOa2quhMeyuuRWOQVvLKZL+zwY24YjbBx/uYKrhUlBVtmQgiIPDHv8DTvtiyM96W2DZQMV3NF2e7yzBb/q7ergw6uwAgdhWqG7qPMCbnZR1vd0hn2XrCxForYFHKPs6l8t9WCEJEMyJD08i0ZxlXeKti4fCMUTCJvYj/lxfb0NzKcJSKFa/8RfLIgI0B6u4OvFcUNtlrz+HWLPsvahC4wETBJEukYQvhlSHHbz0q7QvijLNJgp4WzZm4uDq3dUWxyco8mhZag6emfzPCX8XFiVzI4iZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b391287-e5ea-42bb-e5eb-08d7eb236ab9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 03:22:44.6273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5R3zM+AScOfNOAK/ZoAz7ZbTlOijc6sRdcSF3YMChQBut7/KuioUeCchPmoJIKX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1898
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1525519624=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1525519624==
Content-Type: multipart/alternative;
 boundary="------------FDA16AED658F63885E1EAB32"

--------------FDA16AED658F63885E1EAB32
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, same question.

In fact, PAL cmd stream has itself Relase/Acquire packets. That we use 
the flag is per your request.

-David

在 2020/4/27 22:53, Christian König 写道:
> Yeah, but is Mesa going to use it?
>
> Christian.
>
> Am 27.04.20 um 15:54 schrieb Marek Olšák:
>> PAL requested it and they are going to use it. (it looks like they 
>> have to use it for correctness)
>>
>> Marek
>>
>> On Mon, Apr 27, 2020 at 9:02 AM Deucher, Alexander 
>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>> wrote:
>>
>>     [AMD Official Use Only - Internal Distribution Only]
>>
>>
>>     Do we have open source code UMD code which uses this?
>>
>>     Alex
>>     ------------------------------------------------------------------------
>>     *From:* Christian König <ckoenig.leichtzumerken@gmail.com
>>     <mailto:ckoenig.leichtzumerken@gmail.com>>
>>     *Sent:* Sunday, April 26, 2020 4:55 AM
>>     *To:* Marek Olšák <maraeo@gmail.com <mailto:maraeo@gmail.com>>;
>>     Koenig, Christian <Christian.Koenig@amd.com
>>     <mailto:Christian.Koenig@amd.com>>
>>     *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com
>>     <mailto:Alexander.Deucher@amd.com>>; amd-gfx mailing list
>>     <amd-gfx@lists.freedesktop.org
>>     <mailto:amd-gfx@lists.freedesktop.org>>
>>     *Subject:* Re: drm/amdgpu: apply AMDGPU_IB_FLAG_EMIT_MEM_SYNC to
>>     compute IBs too
>>     Thanks for that explanation. I suspected that there was a good
>>     reason to have that in the kernel, but couldn't find one.
>>
>>     In this case the patch is Reviewed-by: Christian König
>>     <christian.koenig@amd.com> <mailto:christian.koenig@amd.com>
>>
>>     We should probably add this explanation as comment to the flag as
>>     well.
>>
>>     Thanks,
>>     Christian.
>>
>>     Am 26.04.20 um 02:43 schrieb Marek Olšák:
>>>     It was merged into amd-staging-drm-next.
>>>
>>>     I'm not absolutely sure, but I think we need to invalidate
>>>     before IBs if an IB is cached in L2 and the CPU has updated it.
>>>     It can only be cached in L2 if something other than CP has read
>>>     it or written to it without invalidation. CP reads don't cache
>>>     it but they can hit the cache if it's already cached.
>>>
>>>     For CE, we need to invalidate before the IB in the kernel,
>>>     because CE IBs can't do cache invalidations IIRC. This is the
>>>     number one reason for merging the already pushed commits.
>>>
>>>     Marek
>>>
>>>     On Sat., Apr. 25, 2020, 11:03 Christian König,
>>>     <ckoenig.leichtzumerken@gmail.com
>>>     <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>>
>>>         Was that patch set actually merged upstream? My last status
>>>         is that we couldn't find a reason why we need to do this in
>>>         the kernel.
>>>
>>>         Christian.
>>>
>>>         Am 25.04.20 um 10:52 schrieb Marek Olšák:
>>>>         This was missed.
>>>>
>>>>         Marek
>>>>
>>>>         _______________________________________________
>>>>         amd-gfx mailing list
>>>>         amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>>>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Cdavid1.zhou%40amd.com%7Ced56cca1a5214cf9132808d7eabac6d9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637235960880865820&sdata=1eMdG%2Fr07okHFC%2F%2B3Oz4mg6dAvnd%2FULM6ucEoy7xXDc%3D&reserved=0>
>>>
>>>
>>>     _______________________________________________
>>>     amd-gfx mailing list
>>>     amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Cdavid1.zhou%40amd.com%7Ced56cca1a5214cf9132808d7eabac6d9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637235960880875773&sdata=8IuVdWV7WS%2BZR60H8B9rWug64%2Bb7xnEUOucMzOlr1wY%3D&reserved=0>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cdavid1.zhou%40amd.com%7Ced56cca1a5214cf9132808d7eabac6d9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637235960880895689&amp;sdata=6p%2BAuZXHiUrO8wElftOqsJzHF%2BVLe5TMDIF%2BbJNV6ac%3D&amp;reserved=0

--------------FDA16AED658F63885E1EAB32
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Yes, same question.</p>
    <p>In fact, PAL cmd stream has itself Relase/Acquire packets. That
      we use the flag is per your request.</p>
    <p>-David<br>
    </p>
    <div class="moz-cite-prefix">在 2020/4/27 22:53, Christian König 写道:<br>
    </div>
    <blockquote type="cite" cite="mid:217db438-608d-d28c-6678-4173a6291d8b@gmail.com">
      
      <div class="moz-cite-prefix">Yeah, but is Mesa going to use it?<br>
        <br>
        Christian.<br>
        <br>
        Am 27.04.20 um 15:54 schrieb Marek Olšák:<br>
      </div>
      <blockquote type="cite" cite="mid:CAAxE2A50b_&#43;oX9wmF2D6LZs9GvG9Rhug8AQU40aeDbMDm_kFqw@mail.gmail.com">
        <div dir="ltr">
          <div>PAL requested it and they are going to use it. (it looks
            like they have to use it for correctness)<br>
          </div>
          <div><br>
          </div>
          <div>Marek<br>
          </div>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Mon, Apr 27, 2020 at 9:02
            AM Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div dir="ltr">
              <p style="font-family:Arial;font-size:10pt;color:rgb(0,120,215);margin:15pt" align="Left"> [AMD Official Use Only - Internal
                Distribution Only]<br>
              </p>
              <br>
              <div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">Do
                  we have open source code UMD code which uses this?</div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><br>
                </div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">Alex<br>
                </div>
                <hr style="display:inline-block;width:98%">
                <div id="gmail-m_-4239586701017450887divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri,
                    sans-serif" color="#000000"><b>From:</b> Christian
                    König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
                    <b>Sent:</b> Sunday, April 26, 2020 4:55 AM<br>
                    <b>To:</b> Marek Olšák &lt;<a href="mailto:maraeo@gmail.com" target="_blank" moz-do-not-send="true">maraeo@gmail.com</a>&gt;;
                    Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" target="_blank" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;<br>
                    <b>Cc:</b> Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" target="_blank" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
                    amd-gfx mailing list &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                    <b>Subject:</b> Re: drm/amdgpu: apply
                    AMDGPU_IB_FLAG_EMIT_MEM_SYNC to compute IBs too</font>
                  <div>&nbsp;</div>
                </div>
                <div style="background-color:rgb(255,255,255)">
                  <div>Thanks for that explanation. I suspected that
                    there was a good reason to have that in the kernel,
                    but couldn't find one.<br>
                    <br>
                    In this case the patch is Reviewed-by: Christian
                    König <a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">
                      &lt;christian.koenig@amd.com&gt;</a><br>
                    <br>
                    We should probably add this explanation as comment
                    to the flag as well.<br>
                    <br>
                    Thanks,<br>
                    Christian.<br>
                    <br>
                    Am 26.04.20 um 02:43 schrieb Marek Olšák:<br>
                  </div>
                  <blockquote type="cite">
                    <div dir="auto">It was merged into
                      amd-staging-drm-next.
                      <div dir="auto"><br>
                      </div>
                      <div dir="auto">I'm not absolutely sure, but I
                        think we need to invalidate before IBs if an IB
                        is cached in L2 and the CPU has updated it. It
                        can only be cached in L2 if something other than
                        CP has read it or written to it without
                        invalidation. CP reads don't cache it but they
                        can hit the cache if it's already cached.</div>
                      <div dir="auto"><br>
                      </div>
                      <div dir="auto">For CE, we need to invalidate
                        before the IB in the kernel, because CE IBs
                        can't do cache invalidations IIRC. This is the
                        number one reason for merging the already pushed
                        commits.</div>
                      <div dir="auto"><br>
                      </div>
                      <div dir="auto">Marek</div>
                    </div>
                    <br>
                    <div>
                      <div dir="ltr">On Sat., Apr. 25, 2020, 11:03
                        Christian König, &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
                        wrote:<br>
                      </div>
                      <blockquote style="margin:0px 0px 0px
                        0.8ex;border-left:1px solid
                        rgb(204,204,204);padding-left:1ex">
                        <div bgcolor="#FFFFFF">
                          <div>Was that patch set actually merged
                            upstream? My last status is that we couldn't
                            find a reason why we need to do this in the
                            kernel.<br>
                            <br>
                            Christian.<br>
                            <br>
                            Am 25.04.20 um 10:52 schrieb Marek Olšák:<br>
                          </div>
                          <blockquote type="cite">
                            <div dir="ltr">
                              <div>This was missed.</div>
                              <div><br>
                              </div>
                              <div>Marek<br>
                              </div>
                            </div>
                            <br>
                            <fieldset></fieldset>
                            <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" rel="noreferrer" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cdavid1.zhou%40amd.com%7Ced56cca1a5214cf9132808d7eabac6d9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637235960880865820&amp;sdata=1eMdG%2Fr07okHFC%2F%2B3Oz4mg6dAvnd%2FULM6ucEoy7xXDc%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="bQ6LZdwdzzCwNV2EqXiQfAcyvdzjXbTYyHK64lz3mRJBKJbIZm0xDdDeFJlNNzp1qVON7LzcvTP4A85Du/h4jY2a3b/ejhQmLP2Abe2GC&#43;0wNmj2UEKjF2tm6GyA09NNgscey&#43;Esqrhnaq1NpxwexH6ZRUJ&#43;7sEgmuFb2J9LPus=" rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                          </blockquote>
                          <br>
                        </div>
                      </blockquote>
                    </div>
                    <br>
                    <fieldset></fieldset>
                    <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cdavid1.zhou%40amd.com%7Ced56cca1a5214cf9132808d7eabac6d9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637235960880875773&amp;sdata=8IuVdWV7WS%2BZR60H8B9rWug64%2Bb7xnEUOucMzOlr1wY%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="vB2eCpZvtmS3gxgkCBI0szHocIrkxYjohPfqzIqRT6MjSPKmZ72B6d6zznHqsia1oUsaf45ySo6UZLiiVkU6FMstjas5dx4QruWuD0F8JGj90K7T7EsN7btMYzZFdPvMqmA/iQS907a3sOR2pJJCFxcuXjcR0M/mqvyb5fPT33c=" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                  </blockquote>
                  <br>
                </div>
              </div>
            </div>
          </blockquote>
        </div>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cdavid1.zhou%40amd.com%7Ced56cca1a5214cf9132808d7eabac6d9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637235960880875773&amp;sdata=8IuVdWV7WS%2BZR60H8B9rWug64%2Bb7xnEUOucMzOlr1wY%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="vB2eCpZvtmS3gxgkCBI0szHocIrkxYjohPfqzIqRT6MjSPKmZ72B6d6zznHqsia1oUsaf45ySo6UZLiiVkU6FMstjas5dx4QruWuD0F8JGj90K7T7EsN7btMYzZFdPvMqmA/iQS907a3sOR2pJJCFxcuXjcR0M/mqvyb5fPT33c=" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
      <br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cdavid1.zhou%40amd.com%7Ced56cca1a5214cf9132808d7eabac6d9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637235960880895689&amp;amp;sdata=6p%2BAuZXHiUrO8wElftOqsJzHF%2BVLe5TMDIF%2BbJNV6ac%3D&amp;amp;reserved=0">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cdavid1.zhou%40amd.com%7Ced56cca1a5214cf9132808d7eabac6d9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637235960880895689&amp;amp;sdata=6p%2BAuZXHiUrO8wElftOqsJzHF%2BVLe5TMDIF%2BbJNV6ac%3D&amp;amp;reserved=0</a>
</pre>
    </blockquote>
  </body>
</html>

--------------FDA16AED658F63885E1EAB32--

--===============1525519624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1525519624==--
