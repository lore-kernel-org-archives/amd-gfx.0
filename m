Return-Path: <SRS0=BBbY=NX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_ONLY,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0E2C432BE
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 16:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41CE561053
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 16:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 41CE561053
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 584A9898C8;
	Wed,  1 Sep 2021 16:30:04 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2052.outbound.protection.outlook.com [40.107.96.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E6D89862
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Sep 2021 16:30:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7qRktUZ888M4QeJEL0iYa+m2nKP0wp9EbRQqiRg+yBRCvLirGmUWssVyKV8eBX7leu8zkCqP9ylMqwiLosLyjWQO+sgcdk/XJKrlAl5JWv+2ZJOEkStQcdUgDexe1udgjoZbsSMrQg+MDtWv8CNyxzIfjqTS/5S/Ktn2xab7oZ6sBdxjG/hXWqwj9eaD8g7QN87rdw+Q625b7wa96yl+qeovr5Y9KFbAyyxI8HiSMlgGrAN8gKRdARWHGNhl0TTYYzotX6JWdWPd9wwrc2U6tW1155kSmhvAPYGaYwWV0voQoB2lDmTbCJoMA+n4Asw/E/kWIV0SYwkbmfGQEqpag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=uhiutJMsV+2TFNDEGjuZn1bmvQlDczwOhq3bq9Zfuso=;
 b=aRHDUmHBSlSeXvGkXXQga3t9AY68t2t/mvX2y8eOmH7aqJMLIupJTMJAHwfHVCWZnGdYqQ75IIBFplvm8UDzu/L9zRW60OtYx6VJA2gnszpTRddy+VsE4IMgmEVnzQFMyHCwkoEe18RZTY1oWuGIZD0/ruOubGOgKT/BmPTAUum7Z919oW5xZIvMBA89UdiLxUzc921iqpM+MF9AtnffhvVSin+YLYM3MC4HuB4FzH3P9784nTpN7iKpMvrRvlObrWeL7oySmulLT6bbo7Le/x9bSdhcvjegUj6yIUpk7qEDWpZhh7Hl2g9kypK8niWCMnAAbdEmpzYgPVxmlKOyMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhiutJMsV+2TFNDEGjuZn1bmvQlDczwOhq3bq9Zfuso=;
 b=iY8xSjG5tv8xb2ElFarfJvrAzjM+KSVqPPtDm9QVzMLonccoEbdhZU/v60yt5OgNegxTcQbfw86/KSgRE6BWsgrJdWdrthRrAYhM/eJbHMvDP6wl3FVeHX1gIxVX2GNuZE2Q9S/aeo1AboQaPxufzopVmXD/CjXRApjygFxQH68=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Wed, 1 Sep
 2021 16:30:01 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab%5]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 16:30:01 +0000
Subject: Re: [PATCH] drm/amdkfd: drop process ref count when xnack disable
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>, "Sierra Guiza, Alejandro (Alex)"
 <Alex.Sierra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210901024121.23964-1-alex.sierra@amd.com>
 <b690d7a8-6c4b-fc52-0076-7a8c0bc7a391@amd.com>
 <DM5PR12MB4680D1A4C08DBD7DCF72120985CD9@DM5PR12MB4680.namprd12.prod.outlook.com>
From: philip yang <yangp@amd.com>
Message-ID: <813b0a09-a81e-3d0d-0342-eaad81f67f8a@amd.com>
Date: Wed, 1 Sep 2021 12:29:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <DM5PR12MB4680D1A4C08DBD7DCF72120985CD9@DM5PR12MB4680.namprd12.prod.outlook.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 16:30:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 893182ea-7257-49d7-943a-08d96d65bed3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB523237A2C42D71FCDCFFD8CAE6CD9@DM4PR12MB5232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2NR0B5J46/9UbcJDsheTfXe/zDK0LlAv/ZHAU/Y7uFT/vfcSO+ubiN3rQEt5AuJGgtqiNKpsF+eVjj/ak4X+Jmwzjw1ddbPXiK6XxA+2++DmS4jUqy1axcnuswkXhvPO/jDsiBYGpBa046qbXSU2dn6fHgNrNeGlwOg/hb2iXksUgXRDo35OKgf2T9dX9tavZVwg/a3zj15g8yQ9RjPUnTGJiMtfh1vZ6bN0GbsPg6auIvjX7ySQY/1HUCbvS7XvGTyq/3faj3jAxBJG+mCJ+JOeDzv/hZ8qOI/DEp37WoPWtrNXH6pfxGyPyKbQ2JnpAw3XVc/LU80IZiAGbk4837ifmzLncatStZZZFUrOraaWHh8lx4NbE0PWa/5juiC1h5HXsdJFIV65ItT0vaFmTnkjXYvAl76hKndZjAP3EcuPVhrtWUbDTFtiwgkUzXj9BcL1A/o7I1FNDYaH3JKxxbt5IMub7qVtj7QYylwcUGhVt/nxfrCAhmnrNXoFWvyiBa6MayxKZZp/ax/I48tJOJLdbrlxbUMm+ZqyJCwMaYbEHgVv1cDFdf3KTB0Op8HQILRNkFm+FkrrZcKD6I/GYw0kl3MpUIQ4Yc/YHzmhQ2JgFPhL7qqNAJ4g9//YOWZj9I76cruK8lBXc+moWFQ1jRq9y9+xbcn+jTy+rbq1KD1Ims/ViLAzzRh+rVlONTKoNKRN7C9k9nqf+y2DfJg1IA/bvciSh02P6t8ruYR6oU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(186003)(38100700002)(83380400001)(956004)(31696002)(8936002)(31686004)(110136005)(66946007)(53546011)(16576012)(66556008)(66476007)(6486002)(26005)(508600001)(316002)(8676002)(36756003)(2906002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enExSUEyUmZGSHp2djl3UUtIK3RCcmhsLytkK2lHYW9ZVE4rYi9DaXlOd0t2?=
 =?utf-8?B?cXdxVk91d2FhUjJMUkIyK3pvWm1tTVlGOGFlVTFWUEVGVVVCTDVHMlRyS3Rq?=
 =?utf-8?B?QTRLaEdIQk01bTRiM1M0ejhxK0hUcUNqeUN2bm8yS2lMbzJsRlFKa0VaNGRI?=
 =?utf-8?B?Q2tYL2xCNU56Z0JVZjQ1b0NNZXFNZjNhVmdGOWthYlRUM1pzbjNWUlAzbWlI?=
 =?utf-8?B?VitiNnhiRytPTzZUUGUrYkRRYnJyQ1FLTmx1R2VQWmtoUnA5L3h4Z3BDQlJI?=
 =?utf-8?B?dmtUV0o0cDZaZzlaVmxRaG43akYwUWJPSGpLdmd3dDlZZzUxZmdNdUx2Z1lM?=
 =?utf-8?B?UVBpTWduV1c3R3JZNk8rWmNUUVNkd2FjSlFNOERROGQ4bktVWGlyc1h4T0tV?=
 =?utf-8?B?YytybWVLK1MvYkZjS2FVK25neFZ6U3FDcVBNWkcvSGxzUGxlcXhxd0xRS1Ry?=
 =?utf-8?B?STNMdjE2a1V5djhOcWhIejQ5T01nY3hGRjVzcUthdmd0OU14ZG5YZDN5MU1o?=
 =?utf-8?B?YjZhODYvb0dkVVVTdmtaRTk0aXZPOVNVazJtT2t6bHlaK0xGSDFzUDB6NHVi?=
 =?utf-8?B?VkpLL0FMV2l6YzFPbFIwMGtwSVZtL1NRaG1xMGM3NDkrazUreXI1SnB1Z3E1?=
 =?utf-8?B?MkI3VXpCVlFCcGV3b0VVT1A3ZGdzOTdUMy80MTVqd2VBc2xLdkxGbnBHUjEr?=
 =?utf-8?B?SUFhSlY5RWtweURuM0poUE51TU1YMitJcEo1K0hBUUhaNXJZTTFuRlIzQjV5?=
 =?utf-8?B?L216anhSVlNTZXlwQ2R1eVNBa2ViSFZ6T1kzY1h0ejNjcVFoWG1aUnVEajQ3?=
 =?utf-8?B?WGRYcTVmZHJsTlRpQ3NVL3oxTXlOdWdvczNBelRza2pRSU1OcFM2SVYybjQ0?=
 =?utf-8?B?MWFIRTg2SWtQV1RaODlZcWRUUFh6SFBvVkQ2OEFSNERDNDRBbzEwZFdpTEZO?=
 =?utf-8?B?OFVMUDV5Q1RTL0ZtVVRIYWJQWWNDWEUvWEI4SlZUUnpGTytXOVpQTUdoKzUw?=
 =?utf-8?B?SXNONm4wRTFPZjRrWlNQckZ1Uk84alkrYVdudTRkd0NFWWR1aTB2MDkrN0RR?=
 =?utf-8?B?NHlzSGU4SXl3dnVJa0g4dGNUeFUrd3hIN2hyUysyb3VPYmlpNWJmUHo3eGgx?=
 =?utf-8?B?dGVVbVkyTEtGVHFiUlNOUFUvUkRObmJkMzhuQVJ6cUVQU0k4Qk56Z0hJK2Fn?=
 =?utf-8?B?RytIQ01ma1Z1U0FPZlJwbkFNUmUzWXo0ejlqSFducjQvekpDUEpuRFoyVWJz?=
 =?utf-8?B?QW10NC8zd0QxeGhnQzlaRUYzb3NjcThyZ2JGcHV2Myt6M1Q1Ukp6SGc2dWsv?=
 =?utf-8?B?VUwwNDJoS2N6Vkp3aXprR294OWY5d0tENzYxUnVFZE1uMy9aWVVXNVlyVHhw?=
 =?utf-8?B?NTJuVWNpTngySDFPVFBQTjV4ZWplUWtkZEUxdFJ3Zm5TN093YUFXMktuYmxs?=
 =?utf-8?B?Z0l2SFplSVZwTmdSUVZmeStha2ZyTDA2Sm5DMGdNZ0NLQ1RGL3dZekg3UytF?=
 =?utf-8?B?VnFZY21DNWduUXgxcHkzZDcwekZKbkJHa3hRRGdJOTlxektoN0tBRGVGRk1W?=
 =?utf-8?B?dndCcVE2WVVhY0JpVnZGSnEvZTIvM3dRSjlhTy85MFI1cXhSUUZ5UHRpRy84?=
 =?utf-8?B?VFcyVFlPTW1nWFo0R3g0cFZoSmYrWUdId1RsQzJHanhGQkRra1JubTFUSGxG?=
 =?utf-8?B?U0RRU2ZmTXowZUMyZFk5cWdVaGJ4R25GL1RGNVVUamdwS1F0SUxmQjNhcGpr?=
 =?utf-8?Q?LB0hSfxjo9ezuZOw8lHavg3u3Ud/SBTVLUQy+H1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893182ea-7257-49d7-943a-08d96d65bed3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 16:30:01.2238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ma4CfwOcGRabDj7iEUSIBwr1C8eY3yIcUChymPYrmcLVipslJkG1n8at7lVDlCN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-09-01 9:45 a.m., Kim, Jonathan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM5PR12MB4680D1A4C08DBD7DCF72120985CD9@DM5PR12MB4680.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"Malgun Gothic";
	panose-1:2 11 5 3 2 0 0 2 0 4;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}@font-face
	{font-family:"\@Malgun Gothic";
	panose-1:2 11 5 3 2 0 0 2 0 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Consolas",serif;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" align="Left">
        [AMD Official Use Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal">We were seeing process leaks on a couple
            of machines running certain tests that triggered vm faults
            on purpose.<o:p></o:p></p>
          <p class="MsoNormal">I think svm_range_restore_pages gets
            called unconditionally on vm fault handling (unless the
            retry interrupt payload bit is supposed to be clear with
            xnack off)?<o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        </div>
      </div>
    </blockquote>
    <p>yes, with xnack off, sh_mem_config retry should be off, retry bit
      is supposed to be clear in fault interrupt vector, we should not
      try to recover vm fault, just report the vm fault back to
      application and evict user queues. Maybe it is another bug cause
      p-&gt;xnack_enabled and sh_mem_config retry mismatch under
      specific condition?<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:DM5PR12MB4680D1A4C08DBD7DCF72120985CD9@DM5PR12MB4680.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal">Either way, this patch prevents the
            process leaks we seeing and is also:<o:p></o:p></p>
          <p class="MsoNormal">Reviewed-by: Jonathan Kim
            <a class="moz-txt-link-rfc2396E" href="mailto:jonathan.kim@amd.com">&lt;jonathan.kim@amd.com&gt;</a><o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">Thanks,<o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">Jon<o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <div style="border:none;border-left:solid blue
            1.5pt;padding:0in 0in 0in 4.0pt">
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b>From:</b> amd-gfx
                  <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                  <b>On Behalf Of </b>philip yang<br>
                  <b>Sent:</b> Wednesday, September 1, 2021 7:30 AM<br>
                  <b>To:</b> Sierra Guiza, Alejandro (Alex)
                  <a class="moz-txt-link-rfc2396E" href="mailto:Alex.Sierra@amd.com">&lt;Alex.Sierra@amd.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                  <b>Subject:</b> Re: [PATCH] drm/amdkfd: drop process
                  ref count when xnack disable<o:p></o:p></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p class="MsoNormal">[CAUTION: External Email] <o:p></o:p></p>
            <div>
              <p><o:p>&nbsp;</o:p></p>
              <div>
                <p class="MsoNormal">On 2021-08-31 10:41 p.m., Alex
                  Sierra wrote:<o:p></o:p></p>
              </div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre>During svm restore pages interrupt handler, kfd_process ref count was<o:p></o:p></pre>
                <pre>never dropped when xnack was disabled. Therefore, the object was never<o:p></o:p></pre>
                <pre>released.<o:p></o:p></pre>
              </blockquote>
              <p>Good catch, but if xnack is off, we should not get here
                to recover fault.<o:p></o:p></p>
              <p>The fix looks good to me.<o:p></o:p></p>
              <p>Reviewed-by: Philip Yang <a href="mailto:philip.yang@amd.com" moz-do-not-send="true">&lt;philip.yang@amd.com&gt;</a><o:p></o:p></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>Signed-off-by: Alex Sierra <a href="mailto:alex.sierra@amd.com" moz-do-not-send="true">&lt;alex.sierra@amd.com&gt;</a><o:p></o:p></pre>
                <pre>---<o:p></o:p></pre>
                <pre> drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ++-<o:p></o:p></pre>
                <pre> 1 file changed, 2 insertions(+), 1 deletion(-)<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                <pre>index 8f9b5b53dab5..110c46cd7fac 100644<o:p></o:p></pre>
                <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                <pre>@@ -2484,7 +2484,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p-&gt;xnack_enabled) {<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;XNACK not enabled for pasid 0x%x\n&quot;, pasid);<o:p></o:p></pre>
                <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EFAULT;<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms = &amp;p-&gt;svms;<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
              </blockquote>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>
