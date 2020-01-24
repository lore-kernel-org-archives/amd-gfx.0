Return-Path: <SRS0=Oth2=3N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3AAC2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 12:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C023C20708
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 12:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rtJKC3DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C023C20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7878872A4D;
	Fri, 24 Jan 2020 12:56:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B55972A4D
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 12:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQjsVrlsXXSNKBxd3EWRqMLAn+zgrcd/FN1vvZYaZj9i+7/jlmcfBbqMTBwedn5ZvIT5BKFT5yoNk4BEwTpUL6jX5Yb54XNQO2r5ceBN3BTDT48KDEKWI4ij2C++zIeLsmtijFjL95FiEoSkAmVr0N3PCRk20S1lU7GwsHXZWBdUWqcgyhxotIhujhLWmB0uojhQOroqF460gY5gKTM17mwm39UCNeGOGG1cKBl9lL6pKT6j6cJmH+ewT3BxSSyeOTRtMBraLZb83opwKSyVbe8ht1GGK0cvkUWK7mvshzrF30JdDuqga/pH6uesm9x62NnQVWPT0YUuEmB6Lvf+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37skD22By++OE1x/mFYQhtEG6s7B16rlbyz+2EDhwjQ=;
 b=A5H1cStn+5g3WxqHSDKmcnmZdq8KN5oKWjmojonKwmaQ7gG2QBTRa1yVnWW1whn9CY/w4bsC2AjyqsxBjdEO+iiluy24Rtp+ZFtNvKAFix3sFb9zcYajhfHtSOQbvc4NrN7Uiy0k3P/hrv6zq4dj4VPf5LPiIoX5Ce7Qy2Xd2fzEEwvE1hpBb4C+cFdCW5Mcf/0UuN98kO5xl0JkiEC3+Y4HtOuOI0QKJAAtqV74tGdxTUXLxe3jEak0g2XOZb+4TgYcBFiwcoRqEr/jdQAJaTdlSXgBORyZR9YLOjTqbTwvK46OLkRuok2K/zAfBy7zcJi3Ikf4EXilxKrLCE5jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37skD22By++OE1x/mFYQhtEG6s7B16rlbyz+2EDhwjQ=;
 b=rtJKC3DPUDh1hxqBjkZ0Kf9QSCWAeGHWg1A+hQC3xoKu9M0K8gUBdJNhRnqxGn4UaS48FQlIcuKEFMqnBLRP9nUwt3cFqBYlp3D7K+0dSU9/Aeeeie7lKb8LCaUKLo+t8NJQB0U1eQvFeJFnBTyo0j3CTbE4yLMyyxZRLoFl3Ks=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from MWHPR12MB1710.namprd12.prod.outlook.com (10.175.56.16) by
 MWHPR12MB1741.namprd12.prod.outlook.com (10.175.53.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Fri, 24 Jan 2020 12:56:51 +0000
Received: from MWHPR12MB1710.namprd12.prod.outlook.com
 ([fe80::1980:e91a:a256:269b]) by MWHPR12MB1710.namprd12.prod.outlook.com
 ([fe80::1980:e91a:a256:269b%8]) with mapi id 15.20.2665.017; Fri, 24 Jan 2020
 12:56:50 +0000
Subject: Re: [PATCH] drm/amdgpu: allocate entities on demand
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200124115311.8037-1-nirmoy.das@amd.com>
 <bc9b30e6-1ecb-574f-8712-446091cca580@amd.com>
 <c62a3859-dbfb-8b5e-ec9c-4498220e3f61@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <47d6aca2-1df7-37fc-cae9-02e55d4f0eab@amd.com>
Date: Fri, 24 Jan 2020 13:56:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <c62a3859-dbfb-8b5e-ec9c-4498220e3f61@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0014.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::24) To MWHPR12MB1710.namprd12.prod.outlook.com
 (2603:10b6:300:114::16)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZR0P278CA0014.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20 via Frontend Transport; Fri, 24 Jan 2020 12:56:48 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1303a351-153c-449b-b6ba-08d7a0cce0d7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1741:|MWHPR12MB1741:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB174152C5D5CE3A13687787FE830E0@MWHPR12MB1741.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02929ECF07
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(189003)(199004)(6486002)(478600001)(316002)(31696002)(66946007)(4326008)(66556008)(66476007)(86362001)(6666004)(16526019)(186003)(110136005)(2616005)(66574012)(36756003)(81156014)(2906002)(81166006)(52116002)(31686004)(33964004)(8676002)(5660300002)(8936002)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1741;
 H:MWHPR12MB1710.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOuh7TN0sFnLGogCRjuQyefehO+VOr6Js8MZYZ27tj2IaESJSDcUpaB7dl0ow/TvaZHoUfZ6+2kYK1hnQKMb6uqUCOYiS9zdDZQgJa/SQTWPP4MCuoADdqRmbfLnk4jSdnmgAHqiyahav66sJHnAuq79WxkynONSIIOyGDv6wS6n3F/5reG7JlHUFr6l2Zq7wdWgKkvmP4wkfu05zmbyVZ491CG2IyO+en7zyDDEvAlqyMlmdJE2b/F2Fl6ifvYqrc5O/NHUAAT5tPFMm52givekppGrQcQp8h4kR5JguHcljFsmlT6xQweHJnOONRQh+FLy+KGLEJyZDA4VkP2f+CeLWu7qW+pZqREGViaAs0eJJS1dMOj0DlVkjl2ElXyavzw7LD588FoGQqlBDX8o3QO5/Wmvo5LmaD4Q44rzN6sozdc9Hc1kpmwmbaGF1Ycu
X-MS-Exchange-AntiSpam-MessageData: 5mKx9t2UP35TOWnlGGtsAqvh8DycpxJQoGcr7QBtCG5Mz6PeAFEvxGffuKFm6VRARg/j1fv4Ju7L3K//jxczDY+QYv0hh5oZOUqZ7ST1aMU/HeJMPHAuxrOWYvrUvlEZDr8ytnKkGDNHN4eTaR5dYZUxoBzsuBLHL5vQzIGIRlXmvUqb4Kj78xfJBGdQcr8LE95y8fVklrPWk5mUAwBmBQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1303a351-153c-449b-b6ba-08d7a0cce0d7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 12:56:50.5319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkT+DVLbqiOBeesV2FtytDXCm5yusZBa2phh6/Epy1OJ+CLnt85UskAkBDl4Pzwn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1741
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com
Content-Type: multipart/mixed; boundary="===============0379369955=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0379369955==
Content-Type: multipart/alternative;
 boundary="------------3CF8F2BEDEC382B4088AEA93"
Content-Language: en-US

--------------3CF8F2BEDEC382B4088AEA93
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 24.01.20 um 13:43 schrieb Nirmoy:
>
>
> On 1/24/20 1:09 PM, Christian König wrote:
>>> + return  -ENOMEM;
>>
>> That's complete overkill, just statically allocate the array in the 
>> amdgpu_ctx structure.
>>
>> The maximum instance should be 4 IIRC, so something like "struct 
>> amdgpu_ctx_entity *entities[AMDGPU_HW_IP_NUM][4];" so a maximum of 
>> 288 bytes used.
>>
>> Only alternative I see would be to allocate the array behind the 
>> structure, see dma_resv_list_alloc() for an example on how to do 
>> this. But I don't think that this is worth it.
> Resent with added
> +#define AMDGPU_MAX_ENTITY_NUM 4

Yes, of course that is certainly a good idea as well.

Christian.

>
> Regards,
> Nirmoy
>>
>> Christian.


--------------3CF8F2BEDEC382B4088AEA93
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 24.01.20 um 13:43 schrieb Nirmoy:<br>
    </div>
    <blockquote type="cite" cite="mid:c62a3859-dbfb-8b5e-ec9c-4498220e3f61@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 1/24/20 1:09 PM, Christian König
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:bc9b30e6-1ecb-574f-8712-446091cca580@amd.com">
        <blockquote type="cite" style="color: #000000;">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          return&nbsp; -ENOMEM; <br>
        </blockquote>
        <br>
        That's complete overkill, just statically allocate the array in
        the amdgpu_ctx structure. <br>
        <br>
        The maximum instance should be 4 IIRC, so something like &quot;struct
        amdgpu_ctx_entity *entities[AMDGPU_HW_IP_NUM][4];&quot; so a maximum
        of 288 bytes used. <br>
        <br>
        Only alternative I see would be to allocate the array behind the
        structure, see dma_resv_list_alloc() for an example on how to do
        this. But I don't think that this is worth it. <br>
      </blockquote>
      Resent with added <br>
      <pre class="moz-quote-pre" wrap="">&#43;#define AMDGPU_MAX_ENTITY_NUM 4</pre>
    </blockquote>
    <br>
    Yes, of course that is certainly a good idea as well.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:c62a3859-dbfb-8b5e-ec9c-4498220e3f61@amd.com">
      <pre class="moz-quote-pre" wrap="">

Regards,
Nirmoy 
</pre>
      <blockquote type="cite" cite="mid:bc9b30e6-1ecb-574f-8712-446091cca580@amd.com"> <br>
        Christian. <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------3CF8F2BEDEC382B4088AEA93--

--===============0379369955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0379369955==--
