Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FE1C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 19:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B24208C9
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 19:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mT5+qf51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B24208C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14B636E46C;
	Tue, 23 Jun 2020 19:21:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 794DA6E46C
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 19:21:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rc/14No17FANQj7VbdIDd+wRpUc0Ddnk7SMjcjt/7NomJGqP/5MXWwFJ/TUfepT0RYWtM010wIGsbYNXCt+YT6uPD6FkqtOLGifiigEIxZzCB9ptWP+YCs5T4UMEm0HmbsgddOS0Lg+ls+PW4/SXVpzdk6Ci80FFfdoI1B6wcRyRis/LeTWT0UYBhPKum/E4exVd15kDHxozB3pbhDWQqWw7+sZR6qnvgyDIqHNb9gwW1wyKKcnPr34Esy8RW+KMuXlIDf9VhCfYkHdcYt6yjcQeP4Mbnh82LPtUgwu0Md+gPxzPjeI+Ku0DWmAMDEglw2bTYuayr3w3y7P5fsbM5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY4hxZEDe4m/3BFc0QerG1xtQ68PPSD9VQFb7SEqd14=;
 b=LgcVqXBqx2eNWtxU/FncTesC5Sjq+OH0n67zSclE8fATQOtZRJte4RQuy5hd5l39xcl+TF9xc/17isLL8mnJqlpBJZqXOB+1XoYQ7Ul1pZPTKUVy13nI0i42nHh4A3NG3grEB4e0yUK4vs8MpF7wfBaMedLnEmPdaQqktyjnhbHCYJb6LPKPBOROzc8aYFIrYxKsmGRho/d91GNtn9aZcjxq6qtXuTG837PMPMm8YzVxaNk1BANBbM/zFNeOddCNHxd3eNvNlRh5tHg1arkyIO8DVfoosB6TL84Oqr/g/qsv/G2FaKI7/ZQHPKr3kVELh1X3fg28IZHkffB3goPGDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY4hxZEDe4m/3BFc0QerG1xtQ68PPSD9VQFb7SEqd14=;
 b=mT5+qf51jh2RLQ7vrdVV+RG5MVBfjPyAiwezeeTPd+GbmebPIWTOxs4awX2HU0/Z822FSikKSMCSgFm3YleeZmDNv2HptqDd5nyGcZb7Qwayo4n28TQmfX3HdokvukV/Y+Q12adWWwj/sfeJnFVrcz9Bd+F3cfjj+H4qugUFPCI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3911.namprd12.prod.outlook.com (2603:10b6:610:2f::12)
 by CH2PR12MB3719.namprd12.prod.outlook.com (2603:10b6:610:2c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 19:21:10 +0000
Received: from CH2PR12MB3911.namprd12.prod.outlook.com
 ([fe80::21f9:7c89:5b2c:39aa]) by CH2PR12MB3911.namprd12.prod.outlook.com
 ([fe80::21f9:7c89:5b2c:39aa%4]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 19:21:10 +0000
Subject: Re: Mutex stays locked on error
To: amd-gfx@lists.freedesktop.org
References: <alpine.DEB.2.21.2006231945490.3391@kirika.lan>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <cd4d5837-9ab1-863c-01b5-ff139cd88cb9@amd.com>
Date: Tue, 23 Jun 2020 21:22:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <alpine.DEB.2.21.2006231945490.3391@kirika.lan>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0302CA0029.eurprd03.prod.outlook.com
 (2603:10a6:205:2::42) To CH2PR12MB3911.namprd12.prod.outlook.com
 (2603:10b6:610:2f::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.120.26) by
 AM4PR0302CA0029.eurprd03.prod.outlook.com (2603:10a6:205:2::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Tue, 23 Jun 2020 19:21:09 +0000
X-Originating-IP: [217.86.120.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 812c6a44-145e-44bb-89d2-08d817aa9602
X-MS-TrafficTypeDiagnostic: CH2PR12MB3719:
X-Microsoft-Antispam-PRVS: <CH2PR12MB37194164CC2C222FD710487B8B940@CH2PR12MB3719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkuBpvB7olGgKVt8gQy/0nKLvcfHtc+aCaUTYzPiVPIykdnl2nCacicESOMmiy1f+cvK3imLIRFOPxfC1mkqGlDXqO99OCoLPHb+uLLmS/tmtdunOjW9EaFkKlcpLgJ98GEwMcseSg4KqoiqW/Lun36O6NGFYNhuu36jmtmH7Nd7AZWF14+QLZlwxYEFq0wQlAFHG1UhBaNtO/aQHs3LDv/lWnQ2J7ltcQVx6G1bqU2QHbh31PK5ReBWWI+mcAESFQHYoyhuCncZBgmhdsMUqDNY/CCt0Dr6QTCvYnb1O1gzNt0y484ApxF9OZNUyHczhVJWC1HDDnv4e9oxNMvImqTdtaiuLoaWkh7lfQjWxgFlD4kfmEn7jBn2ifOte0Yse1qLsNm1vmPewBgVyf0kpXbUDS73C68lWp8+XFLZxro=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3911.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(31686004)(66556008)(66476007)(66946007)(956004)(2616005)(45080400002)(16576012)(26005)(16526019)(6916009)(966005)(186003)(53546011)(316002)(478600001)(52116002)(31696002)(8676002)(8936002)(6486002)(2906002)(5660300002)(36756003)(166002)(6666004)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: qobvA5GGmYYoMn/WlOV+8mVy44u1mDzvkk3QNu/2Zme7MJWgbUKDh4B/CAgisQZWvkNlZYU9CZlzZNcmGvdNfxw/wf1b5P5CyEGwwnJmPt9NGDv9qzZauqUzkS/Ado0qx3uBo8S9foNhUEBuzEEXZnKtoVbfTUvUDHMQ/jujLr6Fe5YTc/dYlmHeLCwrVvM6b6b6AWb6xJ9HH9OYtU7NC4W7zX0H61agd1BGR3kyeSQuH5TREf5SFXOwN95VPVC5RVHQcjitbGHJ5/LHbT0vQdg3YaOBBEu/fEPIyQk1OHPS+k0ntfUijV/Btpf9BzW0JKiTRCX1MNSPoS0HypvGSc9r1qW9wys/kX95dhna386cfhade+Q9CwF8KxWzspOLVmQFRgnxhnhh5qVTzZsSSar8hyw/95RvLUZcezNC/9e1dy6u3qpCOEk9/HI3t8BBIkhttsx5Shoy3yndpBLzPtmTrgfLvTWJPp6GZXIRbK8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812c6a44-145e-44bb-89d2-08d817aa9602
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 19:21:10.3601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzn8gC18/rxNSDV79o4qYAArQbrLK6OpX/B+ZGZe3UQJ33wuoe2+zlqGtiXF8OD/KpO8d9MONabpYapYHq6qmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3719
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
Content-Type: multipart/mixed; boundary="===============0448594868=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0448594868==
Content-Type: multipart/alternative;
 boundary="------------966B27D6FACC0C81C6AF235D"
Content-Language: en-US

--------------966B27D6FACC0C81C6AF235D
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,


The patch looks correct. Can you please send a proper patch

so that we can apply it.


Thanks,

Nirmoy

On 6/23/20 7:48 PM, John van der Kamp wrote:
> Hello,
>
> I was reading some code and came across this which looks like a mutex 
> not being unlocked when an error happens. I don't know what the code 
> does or how to test it, but it looks quite obvious. Patch is attached.
>
> John
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cnirmoy.das%40amd.com%7Ce8be7708d132495e63bf08d817a7ad86%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637285356777805685&amp;sdata=uG7iWdwahxHL06IJRPw7mnkH%2FifnTuYcxG%2BytRmnEZA%3D&amp;reserved=0

--------------966B27D6FACC0C81C6AF235D
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-1252">
  </head>
  <body>
    <p>Hi John, <br>
    </p>
    <p><br>
    </p>
    <p>The patch looks correct. Can you please send a proper patch</p>
    <p> so that we can apply it.</p>
    <p><br>
    </p>
    <p>Thanks,</p>
    <p>Nirmoy<br>
    </p>
    <div class="moz-cite-prefix">On 6/23/20 7:48 PM, John van der Kamp
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:alpine.DEB.2.21.2006231945490.3391@kirika.lan">Hello,
      <br>
      <br>
      I was reading some code and came across this which looks like a
      mutex not being unlocked when an error happens. I don't know what
      the code does or how to test it, but it looks quite obvious. Patch
      is attached.
      <br>
      <br>
      John<br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cnirmoy.das%40amd.com%7Ce8be7708d132495e63bf08d817a7ad86%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637285356777805685&amp;amp;sdata=uG7iWdwahxHL06IJRPw7mnkH%2FifnTuYcxG%2BytRmnEZA%3D&amp;amp;reserved=0">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cnirmoy.das%40amd.com%7Ce8be7708d132495e63bf08d817a7ad86%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637285356777805685&amp;amp;sdata=uG7iWdwahxHL06IJRPw7mnkH%2FifnTuYcxG%2BytRmnEZA%3D&amp;amp;reserved=0</a>
</pre>
    </blockquote>
  </body>
</html>

--------------966B27D6FACC0C81C6AF235D--

--===============0448594868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0448594868==--
