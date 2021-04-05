Return-Path: <SRS0=xdDd=JC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6073DC433ED
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Apr 2021 16:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FD7613A0
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Apr 2021 16:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FD7613A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC2689CC9;
	Mon,  5 Apr 2021 16:34:06 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700070.outbound.protection.outlook.com [40.107.70.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E7C989CC9
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Apr 2021 16:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBm5oL8ZK1pCFtAmQ8QCLWDqNf8un9tJ+3zcBqFeNmpZFagaoznyOrJElHOjRUtU4rVJufBeINexcM6k+eYmHkfxT2kLOtSKr3OlVg2GulN6rmp9Q6Jt3PTfgx6Cxo+8uNcFl4aWaSFVFi2RmFr1+NPTT55k4EhEqIf4z0mcy4Xg/eObzLBOWNsv48Yqwo3vuTcosJrq5xkOrj52zFcb6sXgVGoEOuqngmbldsuVIRtuvByv++SRpKjibXcUJLGBeGnFC6wrxqr8uRdplA9svd0Roth2khV3iVs+gXhMZHB1/okLG0RYvS5Dx7RirpgJP90X2wdet/LWfsi6sVsVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZD79FgB/Eh1r335eqaQiWOSDQzXh+/t3Dol7LI1Pbk=;
 b=lQrmAPOlGd+rRAXHIClA+jrEWj8j0YbTNuFPb3vNv/q+pndde7m/cjczo2uz1x7a540ad323bS+9nFtjeECg7HmCmgXZV0gmmA1Kw8WtJPQISrw1AQcHAJZ1use8qH7AEfjwSDmNxtiChbmwQxGNFuAr58d17oC2gTcOvBtwiWjtiAwtxrPw2Wd7W0F+hHk0P4zsLymAM52OGn6zPEGjQFSsi3qKgdVLjITzjprQco0NziWw7XrepDcj/WYddiPpP/KC6BKZS9kVvtJV/DRIquA+Kv6U0TD3N4cfYSrE/0BeB7A4jR46pcPyS8X99jxD8C+oiWSa1Xf7HaHGPgjdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZD79FgB/Eh1r335eqaQiWOSDQzXh+/t3Dol7LI1Pbk=;
 b=ti/wfABvCYlzV2vfo6s70LyRm1dc/chcCA8U/Iv5ioE+3H0//dYK9fgFeE9o2Ir6haXVfwLF0ydxTViboI7S52zf5T8P93GT9Ro75xpUeolDXPUWd4N8aLFx2m+YRl3wVDFNdBaEMTGGPRVuYzp3NGvrTTOeA1FB0viu/cAvmFA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Mon, 5 Apr
 2021 16:34:03 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 16:34:03 +0000
Subject: Re: a quetion about buffer migration for user mapped bo.
To: 258454946 <258454946@qq.com>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 "Christian.Koenig@amd.com" <Christian.Koenig@amd.com>
References: <tencent_826EEA87BF2072281A8B94B2955DDCA14E05@qq.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <729f8458-4586-2fd8-6232-012907c47ccc@amd.com>
Date: Mon, 5 Apr 2021 12:34:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <tencent_826EEA87BF2072281A8B94B2955DDCA14E05@qq.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:735:b7a7:7d67:dece]
X-ClientProxiedBy: YT1PR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::49)
 To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:735:b7a7:7d67:dece]
 (2607:fea8:3edf:49b0:735:b7a7:7d67:dece) by
 YT1PR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32 via Frontend Transport; Mon, 5 Apr 2021 16:34:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea63e86b-cfe6-4315-77e4-08d8f8509f8a
X-MS-TrafficTypeDiagnostic: SA0PR12MB4448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4448060AC1F4AC4312A0304BEA779@SA0PR12MB4448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WjO/7wKxBhiSb3h0RrdcB3YHekrmOEpFu4kK+gFQo7AJVpQ7ta7+jHdJV9J2jcU6dfmVhusM0YaL229eiMoq3LL2Tj27apFV9JUe8i5p07gTLnJB0nT4YjFwH0LjxBIYMPrSD7xKqu+YeIUgmar3lji4Y++uswzmdgSqYedcCNP+6y/24MorHwTnycIPuwyc/YnJoZ1IfP5BDdCX3k9sEMte/pxEvsWvli4xSAT5xR68fvr+wDMKiQFiCBkeDkhKi35+x1ETuZwDhNcrVsCgCCp+u/draXzYun2IjbXuqHTsk3JvTXsoPRafOqqAbHjIbmE/zdMd5k8JnheNP1ldz3ImRknthcGiasWTerVUHr/lb/Hq4+hPygve4Mq0YAF3y50awu9LgNqwhPc5jtYGzvw0e9Tu/o4hf+Us05J4nDnouSCmLHzujLsNdMrx8vEjzel4wkiHA+YGFsBYHJpeH6vyE7z/9LJRiG5iCRCm4NR2bjI4B9fkOVfkvK6UcCNsK5CzfjpNZENxkemUZkBMoqIxOOd3VOy0mx4TR0qXhN/48Mkyr+0oms/5gCdLIVxEaYZxIWujSP5cVlQXEqPqx/kXzperRnmISwtuxRuSLG4ryrkv3Iw8j+H0tPUXnXltSBHPKFQUnRZx90rCnrB5S0wai2Hr9GWDneGAOmmY7QiuzMtmtQkkpWG8Qn7atqigULAtWE5vqG6SSayrBb/cMHD7H/+QIgtILmsJAA+gnIGhl3JeX4YFXzWHO2oL7/L0iWa7KtuPRlR9TlCMPXVvsV2NozOXhO62mVAyi0Tkuho=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(83380400001)(6486002)(38100700001)(478600001)(44832011)(52116002)(53546011)(966005)(166002)(5660300002)(2616005)(8936002)(16526019)(66476007)(66946007)(66556008)(8676002)(36756003)(6636002)(2906002)(186003)(31696002)(86362001)(316002)(110136005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?BwiEAXtrUBfV07NH/3xHCs9WMStFJildQesl/X+/PXg7eVtRrdixHPFi?=
 =?Windows-1252?Q?1Gz1NSWfywsQcgTorj5Q0x3TqzkJFiSeHYUHdeZVQarp8JG3lhDAoEOf?=
 =?Windows-1252?Q?a0JsS3+MT3vbeLptjbtona+l6HSpoJ+5tYvcMM7xUOKWZLJHKHXGCO3t?=
 =?Windows-1252?Q?h/kpk+/7NqDCJ6hOghDGoDJnOo045U9kKNBqk68YauSn1s56pvUR2Xxg?=
 =?Windows-1252?Q?CFAffOsL2+SfzOa3fL4tWjSfe7hoRvB/GmhUD252QDC+uiG4gZZs4wga?=
 =?Windows-1252?Q?KeKYIdHQwv9GKXjzQ7qBBdyt9oWcubJw2SazJJ3ikfK4BvWjfH/z9PIT?=
 =?Windows-1252?Q?ojJkrmx89Akq/W44Lp4lRrUBXqVeFJY3HYydZScu/PQvWUJv6dokM7JQ?=
 =?Windows-1252?Q?izJmyAe/exj56g/xS9Sc84xREuZDPuyd5TJeNI/e3lnd479u/TJOYbMV?=
 =?Windows-1252?Q?tU5uL7dhp7slrxSfyhBaxIzZ5c3QnxyfKDj6UMZzGzVA6ZZCu9KsR2wg?=
 =?Windows-1252?Q?j7flo2ivo6yEJlksycAe6W8K3d9zL+ovhRS0CKais+a8jZLJORz4NkGU?=
 =?Windows-1252?Q?k8+7mBnFnPf/NhkMygh9CfL8qN+JC6E6c51+Hn6X0CFT2KJIW6Ad78Cx?=
 =?Windows-1252?Q?z8cXH8EpXkgsMMrf4U6AR6JgShAbKQoCRzEXcZg3ubU9piGR3n2DxLP3?=
 =?Windows-1252?Q?Bs/xxnETqinDvedoRi/NP8HFZ9hArdDgpdHYfWpu9G0d3Q9IDBtwwtTB?=
 =?Windows-1252?Q?0ioEtWv9MC9ATHQOweJKa8R6j5F3pTeUiC8hkWVw4z/CZtpglFriMfpN?=
 =?Windows-1252?Q?OFO1NHwmNCwYl7HNwoYdqDkuipUlV+21BZDt7xhP0G5A1grDlsCucgYJ?=
 =?Windows-1252?Q?ZmZxyEIhx8NOmwGBOY6nJ1nSOzRqKQGh3gKy/SVC53cyzSPg6oa8/PPl?=
 =?Windows-1252?Q?p/QUtgqZIn5N2SH6RAd5rV3m+2u9YRFOViu+ysXSUvnVn0Et7JPiOtWs?=
 =?Windows-1252?Q?4nzu+NwqQC77rGQFLN/sl0Mhx5P5stDn/0/i/JSFaNpw0Aw1HMc3bhA3?=
 =?Windows-1252?Q?BhFbMl86wXKIX/he9b8kIFI5tcOFT7DbQze7jfTQCbLKYXIX58A5rscR?=
 =?Windows-1252?Q?qDDA2szjdPlJ7z10BFUjp17G6Dpsw6dj6Nf9IUfEslphW7xeDX1CSJi5?=
 =?Windows-1252?Q?1tn/tW9VPwK3EDXDnTdj7ZFLiVEU8KsQqxRhL1IZXW6sdXkQ2I6mCwmc?=
 =?Windows-1252?Q?KV3UYEa+gKuc2M3WQti3cTD1/evWWD6vR+8bRDaiF1Tgb/AMT/WufM7O?=
 =?Windows-1252?Q?cKTetOS77MerTlMsCyITxwUpVSW88pd9obiGsmCsnp7n6deV5g8mRm8s?=
 =?Windows-1252?Q?thFdRfx6DRTZgGzTRovDJ4kLm1awS5JmeI2ePxwemI987kY3dIktREqB?=
 =?Windows-1252?Q?SkeV5Zze+VOevC1gGDLih9EIm8wz3RT8/Ha+ZI5pLchqP3fGJ7DCJcz9?=
 =?Windows-1252?Q?q04hvdFy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea63e86b-cfe6-4315-77e4-08d8f8509f8a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 16:34:03.1768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkXbLLhlb89IQPMu42l4nLrMCtDYiyEG0MxfK4fgG2Aw3o0hm1ASPSegLBkmIyymucAKJbzteV/QUKpLi1Fclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
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
Content-Type: multipart/mixed; boundary="===============0112882136=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0112882136==
Content-Type: multipart/alternative;
 boundary="------------C025CBD34C547DB449C7761E"
Content-Language: en-US

--------------C025CBD34C547DB449C7761E
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

 From my understanding and looking at the code I think we don't prevent 
but rather invalidate current user mappings and use subsequent page 
faults to map into user space process the pages from the new location. 
Check what this function is doing during move - 
https://elixir.bootlin.com/linux/v5.12-rc5/source/drivers/gpu/drm/ttm/ttm_bo.c#L238

Andrey

On 2021-04-05 12:01 p.m., 258454946 wrote:
> Hi Guys,
>
> I am a newbee of gfx development. Recently, I am researching amdgpu 
> open source driver, and encounter a problem, but do not find the answer.
>
> We know the user maybe map a gem backing buffer for reading/writing 
> and hold the mapping for a long term. while, kernel driver will also 
> moves the user mapped bo to other memory region. vram ->gtt, 
> gtt->vram, even it may be swaped out under OOM case.
>
> So, my question is how driver prevents kernel ttm from moving the user 
> mapped bo while user is accessing it?
>
> Thanks for your attention!
>
> Lizhi.
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--------------C025CBD34C547DB449C7761E
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-1252">
  </head>
  <body>
    <p>From my understanding and looking at the code I think we don't
      prevent but rather invalidate current user mappings and use
      subsequent page faults to map into user space process the pages
      from the new location. Check what this function is doing during
      move -
<a class="moz-txt-link-freetext" href="https://elixir.bootlin.com/linux/v5.12-rc5/source/drivers/gpu/drm/ttm/ttm_bo.c#L238">https://elixir.bootlin.com/linux/v5.12-rc5/source/drivers/gpu/drm/ttm/ttm_bo.c#L238</a><br>
    </p>
    <p>Andrey<br>
    </p>
    <div class="moz-cite-prefix">On 2021-04-05 12:01 p.m., 258454946
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:tencent_826EEA87BF2072281A8B94B2955DDCA14E05@qq.com">
      
      <div>Hi Guys,</div>
      <div><br>
      </div>
      <div>I am a newbee of gfx development. Recently, I am researching
        amdgpu open source driver, and encounter a problem, but do not
        find the answer.</div>
      <div><br>
      </div>
      <div>We know the user maybe map a gem backing buffer for
        reading/writing and hold the mapping for a long term. while,
        kernel driver will also moves the user mapped bo to other memory
        region. vram -&gt;gtt, gtt-&gt;vram, even it may be swaped out
        under OOM case.</div>
      <div><br>
      </div>
      <div>So, my question is how driver prevents kernel ttm from moving
        the user mapped bo while user is accessing it?</div>
      <div><br>
      </div>
      <div>Thanks for your attention!</div>
      <div><br>
      </div>
      <div>Lizhi.</div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
  </body>
</html>

--------------C025CBD34C547DB449C7761E--

--===============0112882136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0112882136==--
