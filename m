Return-Path: <SRS0=pLrr=6K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1653C55199
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 08:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549A820700
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 08:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nb3gYlMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549A820700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2D26E029;
	Sun, 26 Apr 2020 08:52:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 217966E029
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2020 08:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eggIABJbscP5LESiD+ApSlKyT/7U7GNMBKwYmtPjAzttRavM0uEuicRxIOodauRjJVHOCfFeMwGO5X/q01QD67Zst3Jaf8UxGcY3n9aLrgJ/Sw1DnPxJdI2krXhoGNXmhgFNXcbCQ402YKk4pIYydQfTKqw/kBETSo52xSaKG6/AG87VGeEmwVQ07Z7YElDy+xhj3lkflfW2Y9Wu8weUm4J4vWEeL4k/6+pLbxDCZnalF7DAwmT+HOzqMZCT9Tdac2RfK9c1pHL71ZKxED6PCjcezKWuaD0ywhm9UDLKuKZx8b4YK6aGetZGnM939lY5JehQwxHvhTVgPVdzOzaB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2c9ma0tU+yA20tl6ZlZI1MLxnbKHex2IJlPkOMwhtA=;
 b=RYRKYW/m8GN24CoK+x/qctVGYudp91wg9sSsrHOzuB6+8k/koPhK61kfpQugJ7juGJBNUpnXNGkTlvsgO8TILFlHptfxOuH4dNJ20ozgELRHpz1v1OcZACfwrxYq9XuIByYlUiSHhKL+r3bE0NG1GPqHhnXjXMcO62MlnZhTJDX/nSuQIUEEG2DDwQdADCR3kEOEoKq6Sw78hNdwavBPuiDqgAIZEbxJ+ixBR3ECgPAmrO4VQye7nyA5VmmQwQR5qwdF2t5rqTm45+0pQhCEIOaO9bE7NJKaNd89aoWwUcv2wxEdLiBksH+5Gblfk9Vxix2fnRGPt3SMH4SJcIZ5Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2c9ma0tU+yA20tl6ZlZI1MLxnbKHex2IJlPkOMwhtA=;
 b=nb3gYlMKz1YyKwFk28HqdPig8bVp0N8CXusr6dkMvQlhKMAi1gP7i0VC2OCubmxReyJKsKxtb1oV2dyV7vXFw/cuAOmw1I0g0NnqppXiPlw8JomBRSZCy3zIjR9e13FqjaEe/h9pwXZn3br+t+y1XK7M6H7gW0YA/5UDRGIFmu4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3273.namprd12.prod.outlook.com (2603:10b6:5:188::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sun, 26 Apr
 2020 08:52:34 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2937.023; Sun, 26 Apr 2020
 08:52:34 +0000
Subject: Re: drm/amdgpu: invalidate L2 before SDMA IBs (on gfx10)
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <CAAxE2A7M8Lcf5EG5TxyZXt+ogL0Zh=jL-foW3aVd2A++Y-RSVg@mail.gmail.com>
 <71c2f3e9-a734-5887-b5ce-7fa8b011d372@gmail.com>
 <CAAxE2A67RM1e0Xs2fTcDPm0eTyd4EvdH2vqPsVXWEODL=Dk4zw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <659c4b65-764e-85a8-6ac6-0a9daaa6437e@amd.com>
Date: Sun, 26 Apr 2020 10:52:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <CAAxE2A67RM1e0Xs2fTcDPm0eTyd4EvdH2vqPsVXWEODL=Dk4zw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0099.eurprd07.prod.outlook.com
 (2603:10a6:207:6::33) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR07CA0099.eurprd07.prod.outlook.com (2603:10a6:207:6::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.9 via Frontend Transport; Sun, 26 Apr 2020 08:52:33 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93a1e5c4-218a-4102-f2af-08d7e9bf29c0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3273:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3273C141C99CBE00A2E9C38B83AE0@DM6PR12MB3273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(52116002)(316002)(478600001)(66574012)(6486002)(2616005)(966005)(36756003)(186003)(66946007)(31696002)(66476007)(5660300002)(81156014)(16526019)(33964004)(4326008)(6916009)(2906002)(86362001)(66556008)(45080400002)(31686004)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGF2uV/K7ppEPXEXCQDzYwbVePo6itagF0bx3yYohE86tlvmwoWXuLYnV8HnvKSRZUlROTtnW0lhecksJ3yHZTW/yqhMIgXsD/cUeD2WNK1iDW+c8l3btuAjdT95IDb0NaTnkoeGnegyzhnKnMZYmtTOScN4480RBPdrVuMbO+Jrg2yutukit17BIcnX+NFc4ANK9yEFjNCwPdZPIL4IQoYZ5DY+ftmvb0qVAvtT5XWLIy3JuFQvQUeBDaTmDakDwCbWq0Nw/N+yo5ZvMT8/8TvIB4GU0z3lJtKG8+EN7WjOlBeF093d8sJ3eSrAaTXMGCtOAFnjRFK630PemI/0uxKaj17c4JYj7aSIwmWipPZ3XtnfMhGK8v13A4dyWu79sbKGpzM1gDx/nASAbT8fHwfNGuXVfJJdsqhQEkbMr48qbsFKnN22jQNVrzNl37chVWBVN5yEwWXMR/exKY6DUoiVYhhwlBSYd7SLtvOThAE=
X-MS-Exchange-AntiSpam-MessageData: La/baM0kKpyiBdG6GaLoB+3ec6Tdy6b5Hkh4vb6Gu1RTCDIKFWAyfjlMrDO6rJEFfNmjJ4AT40IfoWcYE/1964k7bYomM//5AGHcXi9IdMaVhVL+Xruy88eMYgXY50tjzsO1OjA/bbgZxgGlV7a+zBs7JapFU/5ssxhKqTNE08dmiCFywGN4zLwhMvu/BdSjz4gDbaIE1JcrtjjAvwXcIwhqWfA7KPVIU0dBe6tT7HmBtEid/JiUxVJ2uQvxRjwCvXjYkMxVHejPcxeNd1qFv1ibDJgv2hnX6iMFjNsfWx740AT4WfeI8YsAa19Z1MG4x7gPv4UzqbUegwpiGmJrW15AbJ9K5OtHw7zro1laGRO/D6RxCuMqrh7tlQVmcsopiBvKwspVLyA6wJARzLAU7qFCpD0AAYim6pHOjfGi1iXepdEAF63hZTwI5XeVNPh2WOdPnJIaNDWHcr13vxZ7wJtyAKvIzUPBR6UjV4qeZxGyJl71w5hB2iLjWo2PKnAdJYk1BE7DbEzuFf6gTTZFCCpt0yYuvMmoOH0/zOV2er/OwqxfS3KH+dUYQUNsfR764vfxWu4jjeXpFtaf7SnY+xf/cHGOcPTvvrE1lXgtRO+JtAnihfzZZkEPuj3cTDKa0w5he8PscbHGF9cOUK7RDmV/arwQjp26IWy9MLONUEThDsCn8f8VYdYIHYe/QQZc3F1cv1eCpsFmWTvwgNL/ma9dnOPnayicQvbYyMqS1sIBF0zRLPNmny84nHvCjEys1aAj/Ihpq9d7qfc8kD9U3K/MCdZvD7y/Fs1UbhlFjBfVncOzX5De8XfvgOhExnb393cX8PiAMsQ52FH8M7TgPrZ7JfB8ifk9D/IqMm3YEIE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a1e5c4-218a-4102-f2af-08d7e9bf29c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 08:52:34.7170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMj7wKU10hRG7s7fXFr8O857q4HonDk8p+WSX6BNt6zWYlSc7kx6YCb0ZX+Vt2/n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3273
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
Content-Type: multipart/mixed; boundary="===============0164836249=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0164836249==
Content-Type: multipart/alternative;
 boundary="------------3ADCE8214D167623DDE32F8E"
Content-Language: en-US

--------------3ADCE8214D167623DDE32F8E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Thought so, we should try to get this get it committed ASAP. And maybe 
add a CC: stable tag as well.

Patch is Reviewed-by: Christian König <christian.koenig@amd.com>.

Thanks,
Christian.

Am 26.04.20 um 02:28 schrieb Marek Olšák:
> Not without a mandatory firmware update. The gcr packet support for 
> IBs was added into the sdma firmware just two weeks ago.
>
> Marek
>
> On Sat., Apr. 25, 2020, 11:04 Christian König, 
> <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>
>     Could we do this in userspace as well?
>
>     Am 25.04.20 um 10:52 schrieb Marek Olšák:
>>     This should fix SDMA hangs on gfx10.
>>
>>     Marek
>>
>>     _______________________________________________
>>     amd-gfx mailing list
>>     amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Cchristian.koenig%40amd.com%7C359b939e8c09417cc08008d7e978cf48%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637234577398011504&sdata=XOGnAIRryyooKGH%2FDH1ZIT7TsFWZ8Y5lSDtVOcE6RxQ%3D&reserved=0>
>


--------------3ADCE8214D167623DDE32F8E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Thought so, we should try to get this
      get it committed ASAP. And maybe add a CC: stable tag as well.<br>
      <br>
      Patch is Reviewed-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>.<br>
      <br>
      Thanks,<br>
      Christian.<br>
      <br>
      Am 26.04.20 um 02:28 schrieb Marek Olšák:<br>
    </div>
    <blockquote type="cite" cite="mid:CAAxE2A67RM1e0Xs2fTcDPm0eTyd4EvdH2vqPsVXWEODL=Dk4zw@mail.gmail.com">
      
      <div dir="auto">Not without a mandatory firmware update. The gcr
        packet support for IBs was added into the sdma firmware just two
        weeks ago.
        <div dir="auto">
          <div dir="auto"><br>
          </div>
          <div dir="auto">Marek</div>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Sat., Apr. 25, 2020, 11:04
          Christian König, &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">
          <div text="#000000" bgcolor="#FFFFFF">
            <div>Could we do this in userspace as well?<br>
              <br>
              Am 25.04.20 um 10:52 schrieb Marek Olšák:<br>
            </div>
            <blockquote type="cite">
              <div dir="ltr">
                <div>This should fix SDMA hangs on gfx10.<br>
                </div>
                <div><br>
                </div>
                <div>Marek<br>
                </div>
              </div>
              <br>
              <fieldset></fieldset>
              <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" rel="noreferrer" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C359b939e8c09417cc08008d7e978cf48%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637234577398011504&amp;sdata=XOGnAIRryyooKGH%2FDH1ZIT7TsFWZ8Y5lSDtVOcE6RxQ%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="dlX4LGfyAh14NCCsa6dwqTrxPXuCCgJDe8w9kJd7hGXodluuRAGDJNyjEbd1JYV8vjgYlIqJoFXUrpI/7raQZC8kRAlk4SaUHimLdFOLIIu&#43;SQbYterDOjKJhztukpaReEroKRvjNIKvQP4R7uAGPCHEosh9OZbFveSp273tYQk=" target="_blank" rel="noreferrer" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------3ADCE8214D167623DDE32F8E--

--===============0164836249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0164836249==--
