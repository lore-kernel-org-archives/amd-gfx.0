Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B56C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 15:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D15D206DF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 15:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D15D206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 970AA6FA4B;
	Fri,  6 Dec 2019 15:45:46 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690057.outbound.protection.outlook.com [40.107.69.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D4B6FA4B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 15:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCEQSoO/yzrid2XGXbZQw+60QR/y9vO/ZeOdQmx6TiV5apPymQJaQbprgGhmoqGklpFBesOQoUsG0fPDC25iJwdOe/TtXbWdxDZRa1Q4C/iQKoomXc6H/mshp22YpjxdfOWOCiDT0gceWSz0ZG9kfYSO8GPqZWb3PDoOSIu9jffYqlB8DWCmtDNT90qAK0a/Uig/e8aAsvIos/KwMwXwWWkcCRfTf5jo+abTCMvpVlP3dkgs8q97Hnf/KCt6TJ53SJxzRckKorZ741wmn8rOR9/e8LqRgp1OwxdyIhcVlJ6RFJWEU5ylbsBSM4Sel23L4dFw+KiYiSQ6EnX12idFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpbeHRXVwb77+aYhL+3NgbG5Si/o68J7MZlzQfiOmVA=;
 b=UTeTj4nO8HnudYX+/2SFGoPQMrwVHTT8TkvEnozQMJQwJIoKR6JbWOwpoO2beZy2v+mBROEWzS3fYAoTR3VRQj9v5WL8uc7f3tSNxhEHKH7R6wrfS4kDuSmdyWe+eZ5RiwZmGwBy5hU07BlPojKQhsEYFlZDJ5DSoHZx12AIOJdil725Jw4aPG7LlCDEH3jVncpZLJI9LI+68O1JmDXarKtjMcIpZB38Zj+cbA6Aah8BLXAKoH184PP+uCJjFONuz+QrKttOtFK7ivlH1LMsmVv1008puoIpw6ISzK0dMbo2ZsVB6UDpxim9xJC38uzQhPqYiQ1jXT/LGHE2z3aHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1870.namprd12.prod.outlook.com (10.175.51.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Fri, 6 Dec 2019 15:45:39 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80%12]) with mapi id 15.20.2495.014; Fri, 6 Dec 2019
 15:45:38 +0000
Subject: Re: [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waiting for
 fences timed out or interrupted!
To: Christian Pernegger <pernegger@gmail.com>, amd-gfx@lists.freedesktop.org
References: <CAKbQEqEE3dgcF1bi-Sh5FQoHiU2TEHYn-H5fE92g6Pa+rgXbiQ@mail.gmail.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <08f54bf9-db69-ff9a-b3bb-477b2ac05eb0@amd.com>
Date: Fri, 6 Dec 2019 10:45:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <CAKbQEqEE3dgcF1bi-Sh5FQoHiU2TEHYn-H5fE92g6Pa+rgXbiQ@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::43) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-Originating-IP: [2607:fea8:3edf:e127:c5a0:8df5:d3f5:f311]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29b3c81e-af30-49f2-dc4e-08d77a63574b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1870:
X-Microsoft-Antispam-PRVS: <MWHPR12MB187026A9B89404338698F541EA5F0@MWHPR12MB1870.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0243E5FD68
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(189003)(199004)(2616005)(5660300002)(31686004)(6512007)(2906002)(54896002)(58126008)(966005)(6666004)(316002)(478600001)(45080400002)(37036004)(65956001)(81166006)(66556008)(86362001)(8936002)(81156014)(66946007)(8676002)(66476007)(52116002)(6506007)(76176011)(71190400001)(186003)(33964004)(53546011)(31696002)(36756003)(99286004)(229853002)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1870;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6aigBL+Pi41T2/XWfgfTIkUT2Axcs3TcUjon4Yomb6xTw6FN85A8uE1LCSCT/dlrLEkpAHeRu5RrCEuel3Gm8DmcC3pd6JFsZFijVSstqlS95EV6yEJfTbdKXIqBLzMHo+/3xDiv1wALYibN43PZ0XlurE4UKpVvXzqb0uBDT8Oi+dcN2cDPPDLNWYjO8la+hw9kZnOpGxyGzIVlL01kDNbvp+1Zh6Au3GzcjU6QFd7byS62MGSoyCA3ns/ZN4359zjQ5IA4Y4XZQ8gpvqhC13y5Dwn64VB1QGNr+dRo26SD6BYM1JLyChoP1j98OEVnhVVJac1u0m35miBsUXIwnPmqhgD1IX4DIyWsGQta0/VHcdPC8J5TNYbRUnPavUhGxhPnGc3aiR0GEVTkPiMJSUBvxxQLLgPbIhiOgiqmWOMyTVOljXSj3586J6+ZOKDhibiKfUl+fdJmYIxv+q+lv7/uhcV5NA/0c1a5u1BFCo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b3c81e-af30-49f2-dc4e-08d77a63574b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 15:45:38.7592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsNPZDrLwO5QHstnoxLNlH0mG6KlRCosO+yXNzFk0WJtm7255buaZJpRe4Y36up5WClo9uYxkTwaosvJwpK11Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1870
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpbeHRXVwb77+aYhL+3NgbG5Si/o68J7MZlzQfiOmVA=;
 b=ksNqAHH4zYZkKSz+0E4aZfG898Re2Q4uz9k7CJSVXWZY9UE7E9165gvpSPwdhhivPjYG6xP9eMYKF2q5iqdMZlymiPbXj2O06sXoxWQWMoDWETYGDPwmxXmJJfN8SexSv1OOXOwk26tJKJGrt087Y9wP0HV2wLR4sQV+Lxs6LuA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0247564086=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0247564086==
Content-Type: multipart/alternative;
 boundary="------------45B0E9821150DECC065DD4DB"
Content-Language: en-US

--------------45B0E9821150DECC065DD4DB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

The WARN stack trace after GPU reset kicks in points to not the latest 
code - can you please try running the same with kernel at the tip of 
https://cgit.freedesktop.org/~agd5f/linux/log/?h=amd-staging-drm-next ?

Andrey

On 12/5/19 6:14 PM, Christian Pernegger wrote:
> Hello,
>
> one of my computers has been crashing while gaming rather a lot
> lately, with kernel messages pointing to amdgpu. First line see
> subject, rest in the attached log.
> SSH still works, attempts to shutdown/reboot don't quite finish.
>
> Radeon VII in an Asus Pro WS X570-Ace. Ubuntu 18.04.3 HWE, mesa-aco.
> This one was with kernel 5.3.0-24-generic [hwe-edge], mesa
> 19.3.0+aco+git1575452833-3409c06e26d-1bionic1, vesa20_* from
> linux-firmware-20191022, running Ori and the Blind Forest: Definitive
> Edition via Proton/WINED3D11 under Steam Remote Play. I've had similar
> crashes sporadically even with 5.0 [plain hwe] and linux-firmware
> completely stock, and with native games (e.g. Crusader Kings II)
> running locally.
> It used to be maybe once every other week, though, that was tolerable,
> now Ori usually triggers it in under an hour. Turning off ACO via
> RADV_PERFTEST=llvm makes it worse (not bad enough to make it trigger
> quickly and reliably. though), going back to kernel 5.0 helps (as in
> an hour or two might go by without a crash, but the performance impact
> is severe).
>
> All very vague. Which is why this isn't pretending to be a bug report,
> just a "has anyone seen this?" kind of shout-out. If it's worthy of
> following up, I'd be happy to provide further info, just tell me what.
>
> Cheers,
> C.
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7Cbb730551c8ef4057491908d779d90a9b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637111845515070500&amp;sdata=RisL4HBqy35p25FOcp97EU%2F4Ldq6W1GJtkVANyzz8BY%3D&amp;reserved=0

--------------45B0E9821150DECC065DD4DB
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>The WARN stack trace after GPU reset kicks in points to not the
      latest code - can you please try running the same with kernel at
      the tip of
      <a class="moz-txt-link-freetext" href="https://cgit.freedesktop.org/~agd5f/linux/log/?h=amd-staging-drm-next">https://cgit.freedesktop.org/~agd5f/linux/log/?h=amd-staging-drm-next</a>
      ?</p>
    <p>Andrey<br>
    </p>
    <div class="moz-cite-prefix">On 12/5/19 6:14 PM, Christian Pernegger
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAKbQEqEE3dgcF1bi-Sh5FQoHiU2TEHYn-H5fE92g6Pa&#43;rgXbiQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">Hello,

one of my computers has been crashing while gaming rather a lot
lately, with kernel messages pointing to amdgpu. First line see
subject, rest in the attached log.
SSH still works, attempts to shutdown/reboot don't quite finish.

Radeon VII in an Asus Pro WS X570-Ace. Ubuntu 18.04.3 HWE, mesa-aco.
This one was with kernel 5.3.0-24-generic [hwe-edge], mesa
19.3.0&#43;aco&#43;git1575452833-3409c06e26d-1bionic1, vesa20_* from
linux-firmware-20191022, running Ori and the Blind Forest: Definitive
Edition via Proton/WINED3D11 under Steam Remote Play. I've had similar
crashes sporadically even with 5.0 [plain hwe] and linux-firmware
completely stock, and with native games (e.g. Crusader Kings II)
running locally.
It used to be maybe once every other week, though, that was tolerable,
now Ori usually triggers it in under an hour. Turning off ACO via
RADV_PERFTEST=llvm makes it worse (not bad enough to make it trigger
quickly and reliably. though), going back to kernel 5.0 helps (as in
an hour or two might go by without a crash, but the performance impact
is severe).

All very vague. Which is why this isn't pretending to be a bug report,
just a &quot;has anyone seen this?&quot; kind of shout-out. If it's worthy of
following up, I'd be happy to provide further info, just tell me what.

Cheers,
C.
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7Cbb730551c8ef4057491908d779d90a9b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637111845515070500&amp;amp;sdata=RisL4HBqy35p25FOcp97EU%2F4Ldq6W1GJtkVANyzz8BY%3D&amp;amp;reserved=0">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7Cbb730551c8ef4057491908d779d90a9b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637111845515070500&amp;amp;sdata=RisL4HBqy35p25FOcp97EU%2F4Ldq6W1GJtkVANyzz8BY%3D&amp;amp;reserved=0</a></pre>
    </blockquote>
  </body>
</html>

--------------45B0E9821150DECC065DD4DB--

--===============0247564086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0247564086==--
