Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585F9C34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 14:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D7B2176D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 14:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eywlcUP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D7B2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA9936E30D;
	Tue, 18 Feb 2020 14:57:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9456C6E30D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 14:57:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReS0BtGXKzHFWvASiV9gjs61XyoArMopOLqaHRgkfoTfAQE42jFe+afxcJ5mNQNRVSk+KMUFNCTHQ8AON58UmahtFe9AKOyhryZ9ynB++CDG79W/3zJPjsO2I3olpa9A599oftOwUdZB3javZokvtTstmNFNEznwcqWPXjyj6VrO8lSVE0QQ7BK9WFy74Q4fleuRTX8oCFUosv6kFhMLzhDw2CQ8qUnIlmm/9+v4zrvgxwM8hCn04nc6rmOCPbTKjEdZMCWhmV7pgCIH5VN84bBDIpvA6HGhow/wRqwu8nsQY1ZyxFIDTcyQbkqXwyakykvbVjR4j3J3By0Gp6dmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uGAu13zU/U+kvE5lYe2gUDnNcbOpDjix8IMN6mz2tI=;
 b=nNHPAZniCLONy3JKWjjM/mZWYdExv5C5zpQrcNqavPzF6AbTEo4FYNZExw7NP6vXm/6IRmSIeR1Hi0KXVGZYsQ592fjQVyJoQ1iVRLDtFWzxmSqtjG7OzfXunsHeW2GdFX8LtPgwXUcppRvQ47eQpb9K7/QdcVbOjVKYv3KGQPJmODIMIwwj1YxZDrFhSWqFZBPAdiuv1XJppcTz6TjGfuPHZDU5FejQa07sHDeKdBmv8un8/fr49J6fMVpGRg5jVyExpy65Fx0TqgCGHNiiMBGo/uvY6941SWfELBnB4jAoJuDspLsD06HukSz/YBTpIW/CPZ4fkAuYTUj1voN8sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uGAu13zU/U+kvE5lYe2gUDnNcbOpDjix8IMN6mz2tI=;
 b=eywlcUP9frGVJ8Ha0301p8z7JwKlUDKp2tI8GWyzm6K7P24aV1UDPX1pCFE9Fzp5TBud9pop5vJsWrhoBrGgXLgQ6AzBONLVFPJF+Qdc10dA7K1unvFmgmwpWzP7a/I1RrvcYL4D9k0v5azDws23H2qeZrNfq1sDrwFRcM3wxx8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2423.namprd12.prod.outlook.com (52.132.140.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Tue, 18 Feb 2020 14:57:34 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2729.032; Tue, 18 Feb
 2020 14:57:34 +0000
Subject: Re: writing custom driver for VGA emulation ?
To: "Bridgman, John" <John.Bridgman@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Yusuf_Alt=c4=b1parmak?= <yusufalti1997@gmail.com>
References: <CAGzVRjzs8rgaLkWcaxdAn-DUf3Kk70TW=NPM+Hk9SLt7Tcjsfg@mail.gmail.com>
 <CADnq5_MutDzY0fdhX3anCQXFAOLkAbcMS3timfFEDFBqVc-jxA@mail.gmail.com>
 <DM6PR12MB3097CF2E5C2F02FC1C94F4ACE8110@DM6PR12MB3097.namprd12.prod.outlook.com>
 <460d7881-2223-12f1-bc47-b48b851d1138@gmail.com>
 <DM6PR12MB309715C009FB496F1D3B4B56E8110@DM6PR12MB3097.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1a5ff944-9549-6045-8120-350a2e5c33ce@amd.com>
Date: Tue, 18 Feb 2020 15:57:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <DM6PR12MB309715C009FB496F1D3B4B56E8110@DM6PR12MB3097.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR07CA0027.eurprd07.prod.outlook.com
 (2603:10a6:205:1::40) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR07CA0027.eurprd07.prod.outlook.com (2603:10a6:205:1::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.9 via Frontend Transport; Tue, 18 Feb 2020 14:57:33 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a8b34d9d-d817-43e3-fe34-08d7b482e2dc
X-MS-TrafficTypeDiagnostic: DM5PR12MB2423:|DM5PR12MB2423:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24234358F3DA26068391C3BE83110@DM5PR12MB2423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(52116002)(5660300002)(19627405001)(81166006)(8936002)(4326008)(53546011)(316002)(66476007)(66556008)(36756003)(31696002)(2616005)(186003)(110136005)(66946007)(16526019)(86362001)(81156014)(66574012)(6666004)(966005)(2906002)(478600001)(45080400002)(6486002)(31686004)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2423;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRhBveWJbpwNt6RyPI7orPqmzm2CxqH5k/gKVVAIFTJRaoFu71oPGYrAtvHyL1sGS4Xnr2Tj94thNeFR2q6VAmyhHmY+VhKw+NWCj3VWzR7ZgkzGR2ftjXWm9iBtSlGxACDnP2XvRnP5AS08e9Gp2ztHXV7GpwKCtQU18csIq5zg9o4g6WFNzsrb5yw0MC9ZEY0EjBEQlnU4wR3cfLD4BtqB52/s5D7hFgff4y46T6T0CedMl0X0ckVM0Rkn2q8T/N44T3mHRe8h5GEAa1PJkkV+gIKuGnLd+qvhoZJM93HDXCKjDv0R2y6pv9XUesoEuPABhh2eWaBXbqbAv0D0Z4efRJlw5cpbT+dp30YjjAIDp6B/uMRi1Cv8o8NMdAqzvwgAPLc8Y/WuNVLC6S9N2gFHBWKl9EROQ0hFrN2ZpJ2m/hS0oWy2Xw9iq8Xgid4euvH8m0KoX508B8ibM06XrK1ozN/Kiu8XnBXLGpbqJAP87JzQAkIZbohlW91qduWJfyQHs97JsElDW2HEF/U5xw==
X-MS-Exchange-AntiSpam-MessageData: Pqne+x55TyAPT6VaEgn/LOVai1rM99hFYZxNEuESlLQ2HodCkkzb8c1ujuoYdx9tk1vxB2cpabVYrSZl5bNkEuL0fYNUJK38eGEZLLGGr564E4SXFtWcYHWy8OuxdJminMJ9u85MCQonoMR9XXi19H33BuPNFreTEfRTiIpCDKBBiVsgrblg56++Twj9xf3SVTbNz9Jy0lO2FWYpAYXN5w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b34d9d-d817-43e3-fe34-08d7b482e2dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 14:57:34.6953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdTs/wVdb39nN/GCOx+QrValv5Go2qFbDv8+mkrR0Gt8W7n6fgLODFm31c6/zxYN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2423
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0346911160=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0346911160==
Content-Type: multipart/alternative;
 boundary="------------EAA9072E2165D2188AD24407"
Content-Language: en-US

--------------EAA9072E2165D2188AD24407
Content-Type: text/plain; charset=iso-8859-3; format=flowed
Content-Transfer-Encoding: 8bit

Yusef is using an ARM platform. As far as I know he already tried to 
shuffle the static allocation for the MMIO address spaces around without 
much luck.

The only option I see would be to use the PCIe bridge trick I've 
mentioned below, but this is really so hacky that I won't recommend that.

Christian.

Am 18.02.20 um 15:43 schrieb Bridgman, John:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> >And we already checked, 256MB is unfortunately the minimum you can 
> resize the VRAM BAR on the E9171 to.
>
> Ahh, OK... I didn't realize we had already looked into that. I guess 
> that approach isn't going to work.
>
> Yusef, guessing you are using a 32-bit CPU ? Is it possible to talk to 
> whoever does SBIOS for your platform to see if you could maybe reduce 
> address space allocated to RAM and bump up the MMIO space ?
>
> ------------------------------------------------------------------------
> *From:* Christian König <ckoenig.leichtzumerken@gmail.com>
> *Sent:* February 18, 2020 9:19 AM
> *To:* Bridgman, John <John.Bridgman@amd.com>; Alex Deucher 
> <alexdeucher@gmail.com>; Yusuf Alt¹parmak <yusufalti1997@gmail.com>
> *Cc:* amd-gfx list <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: writing custom driver for VGA emulation ?
> The problem Yusuf runs into is that his platform has multiple PCIe 
> root hubs, but only 512MB of MMIO address space. That is not enough to 
> fit all the BARs of an E9171 into.
>
> But without the BARs neither the VGA emulation nor amdgpu not anything 
> else will work correctly.
>
> And we already checked, 256MB is unfortunately the minimum you can 
> resize the VRAM BAR on the E9171 to.
>
> What could maybe work is to trick the upstream bridge of the VGA 
> device into not routing all the addresses to the BARs and actually use 
> only a smaller portion of visible VRAM. But that would be highly 
> experimental and requires a rather big hack into the PCI(e) subsystem 
> in the Linux kernel.
>
> Regards,
> Christian.
>
> Am 18.02.20 um 15:08 schrieb Bridgman, John:
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>> Does the VBIOS come up with something like a splash screen, ie is 
>> VBIOS able to initialize and drive the card ?
>>
>> If so then another option might be to use a VESA driver rather than VGA.
>>
>>
>> ------------------------------------------------------------------------
>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> 
>> <mailto:amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex 
>> Deucher <alexdeucher@gmail.com> <mailto:alexdeucher@gmail.com>
>> *Sent:* February 18, 2020 8:50 AM
>> *To:* Yusuf Alt¹parmak <yusufalti1997@gmail.com> 
>> <mailto:yusufalti1997@gmail.com>
>> *Cc:* amd-gfx list <amd-gfx@lists.freedesktop.org> 
>> <mailto:amd-gfx@lists.freedesktop.org>
>> *Subject:* Re: writing custom driver for VGA emulation ?
>> On Tue, Feb 18, 2020 at 2:56 AM Yusuf Alt¹parmak
>> <yusufalti1997@gmail.com> <mailto:yusufalti1997@gmail.com> wrote:
>> >
>> > Hello AMD team;
>> >
>> > I have E 9171 GPU and want to use it on a embedded system which has 
>> limited MMIO space on PCIe bus (MAX 512 MB).
>> >
>> > I received feedbacks that I can only use VGA emulation with this 
>> memory space. I was unable to get 'amdgpu' driver working with Xorg 
>> due to I had many errors(firmwares are not loading) in each step and 
>> tired of solving them one by one.
>> >
>> > I want to write a simple custom driver for this GPU with kernel 
>> version 4.19.
>> > Is it possible to print some colors on screen with a custom driver 
>> over PCIe communication ? or writing some words on screen as VGA ?
>> >
>> > If answer is yes, then which code pieces (on amdgpu driver folder) 
>> or reference documentation should I use? I have Register Reference 
>> Guide.pdf.
>> >
>> > I will be appreciated for your guidance.
>>
>> That is not going to do what you want on your platform.  The VGA
>> emulation requires that you set up the card first to enable it, which
>> in turn requires MMIO access and thus you are back to square one.
>>
>> Alex
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cjohn.bridgman%40amd.com%7Ce7bf224775ad487d240708d7b47992f4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176306561328560&amp;sdata=QbfaIN%2F6LvgUihz5O0x41TwvdGYy7QTS5IVJq3RXYlA%3D&amp;reserved=0 
>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7CJohn.Bridgman%40amd.com%7Ccda5469b6f5f4ae43e6d08d7b47d899a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176323587003958&sdata=6eKo51jnHbE1QWkDB%2BN%2FFLMLB40HA2wVN3mU1l%2FeFhk%3D&reserved=0>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7CJohn.Bridgman%40amd.com%7Ccda5469b6f5f4ae43e6d08d7b47d899a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176323587003958&sdata=6eKo51jnHbE1QWkDB%2BN%2FFLMLB40HA2wVN3mU1l%2FeFhk%3D&reserved=0>
>


--------------EAA9072E2165D2188AD24407
Content-Type: text/html; charset=iso-8859-3
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-3">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Yusef is using an ARM platform. As far
      as I know he already tried to shuffle the static allocation for
      the MMIO address spaces around without much luck.<br>
      <br>
      The only option I see would be to use the PCIe bridge trick I've
      mentioned below, but this is really so hacky that I won't
      recommend that.<br>
      <br>
      Christian.<br>
      <br>
      Am 18.02.20 um 15:43 schrieb Bridgman, John:<br>
    </div>
    <blockquote type="cite" cite="mid:DM6PR12MB309715C009FB496F1D3B4B56E8110@DM6PR12MB3097.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p style="font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          &gt;And we already checked, 256MB is unfortunately the minimum
          you can resize the VRAM BAR on the E9171 to.<br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Ahh, OK... I didn't realize we had already looked into that. I
          guess that approach isn't going to work.
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Yusef, guessing you are using a 32-bit CPU ? Is it possible to
          talk to whoever does SBIOS for your platform to see if you
          could maybe reduce address space allocated to RAM and bump up
          the MMIO space ?<br>
        </div>
        <div>
          <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
            font-size:12pt; color:rgb(0,0,0)">
            <br>
          </div>
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
              Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
              <b>Sent:</b> February 18, 2020 9:19 AM<br>
              <b>To:</b> Bridgman, John <a class="moz-txt-link-rfc2396E" href="mailto:John.Bridgman@amd.com">&lt;John.Bridgman@amd.com&gt;</a>;
              Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a>; Yusuf
              Alt¹parmak <a class="moz-txt-link-rfc2396E" href="mailto:yusufalti1997@gmail.com">&lt;yusufalti1997@gmail.com&gt;</a><br>
              <b>Cc:</b> amd-gfx list
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>Subject:</b> Re: writing custom driver for VGA
              emulation ?</font>
            <div>&nbsp;</div>
          </div>
          <div style="background-color:#FFFFFF">
            <div class="x_moz-cite-prefix">The problem Yusuf runs into
              is that his platform has multiple PCIe root hubs, but only
              512MB of MMIO address space. That is not enough to fit all
              the BARs of an E9171 into.<br>
              <br>
              But without the BARs neither the VGA emulation nor amdgpu
              not anything else will work correctly.<br>
              <br>
              And we already checked, 256MB is unfortunately the minimum
              you can resize the VRAM BAR on the E9171 to.<br>
              <br>
              What could maybe work is to trick the upstream bridge of
              the VGA device into not routing all the addresses to the
              BARs and actually use only a smaller portion of visible
              VRAM. But that would be highly experimental and requires a
              rather big hack into the PCI(e) subsystem in the Linux
              kernel.<br>
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              Am 18.02.20 um 15:08 schrieb Bridgman, John:<br>
            </div>
            <blockquote type="cite">
              <p style="margin-top: 0px; margin-bottom:
                0px;font-family:Arial; font-size:10pt; color:#0078D7;
                margin:15pt" align="Left">
                [AMD Official Use Only - Internal Distribution Only]<br>
              </p>
              <br>
              <div>
                <div>Does the VBIOS come up with something like a splash
                  screen, ie is VBIOS able to initialize and drive the
                  card ?<br>
                </div>
                <div><br>
                </div>
                <div>If so then another option might be to use a VESA
                  driver rather than VGA. <br>
                </div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                  font-size:12pt; color:rgb(0,0,0)">
                  <br>
                </div>
                <div>
                  <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                    font-size:12pt; color:rgb(0,0,0)">
                    <br>
                  </div>
                  <hr tabindex="-1" style="display:inline-block;
                    width:98%">
                  <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> amd-gfx
                      <a class="x_moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">
                        &lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                      on behalf of Alex Deucher <a class="x_moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com" moz-do-not-send="true">
                        &lt;alexdeucher@gmail.com&gt;</a><br>
                      <b>Sent:</b> February 18, 2020 8:50 AM<br>
                      <b>To:</b> Yusuf Alt¹parmak <a class="x_moz-txt-link-rfc2396E" href="mailto:yusufalti1997@gmail.com" moz-do-not-send="true">
                        &lt;yusufalti1997@gmail.com&gt;</a><br>
                      <b>Cc:</b> amd-gfx list <a class="x_moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                        &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                      <b>Subject:</b> Re: writing custom driver for VGA
                      emulation ?</font>
                    <div>&nbsp;</div>
                  </div>
                  <div class="x_BodyFragment"><font size="2"><span style="font-size:11pt">
                        <div class="x_PlainText">On Tue, Feb 18, 2020 at
                          2:56 AM Yusuf Alt¹parmak<br>
                          <a class="x_moz-txt-link-rfc2396E" href="mailto:yusufalti1997@gmail.com" moz-do-not-send="true">&lt;yusufalti1997@gmail.com&gt;</a>
                          wrote:<br>
                          &gt;<br>
                          &gt; Hello AMD team;<br>
                          &gt;<br>
                          &gt; I have E 9171 GPU and want to use it on a
                          embedded system which has limited MMIO space
                          on PCIe bus (MAX 512 MB).<br>
                          &gt;<br>
                          &gt; I received feedbacks that I can only use
                          VGA emulation with this memory space. I was
                          unable to get 'amdgpu' driver working with
                          Xorg due to I had many errors(firmwares are
                          not loading) in each step and tired of solving
                          them one by one.<br>
                          &gt;<br>
                          &gt; I want to write a simple custom driver
                          for this GPU with kernel version 4.19.<br>
                          &gt; Is it possible to print some colors on
                          screen with a custom driver over PCIe
                          communication ? or writing some words on
                          screen as VGA ?<br>
                          &gt;<br>
                          &gt; If answer is yes, then which code pieces
                          (on amdgpu driver folder) or reference
                          documentation should I use? I have Register
                          Reference Guide.pdf.<br>
                          &gt;<br>
                          &gt; I will be appreciated for your guidance.<br>
                          <br>
                          That is not going to do what you want on your
                          platform.&nbsp; The VGA<br>
                          emulation requires that you set up the card
                          first to enable it, which<br>
                          in turn requires MMIO access and thus you are
                          back to square one.<br>
                          <br>
                          Alex<br>
_______________________________________________<br>
                          amd-gfx mailing list<br>
                          <a class="x_moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                          <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CJohn.Bridgman%40amd.com%7Ccda5469b6f5f4ae43e6d08d7b47d899a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176323587003958&amp;sdata=6eKo51jnHbE1QWkDB%2BN%2FFLMLB40HA2wVN3mU1l%2FeFhk%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="U6meQaXVtmMvUg9YEUEclm83S&#43;Z07KrR9tCRISlpsrQ2MhZ3nHWjky8Y5XYAe9N&#43;vGF9XTpXLPgG33LoV6btCVtFURjkdXC6O1izBKd19S&#43;02Npep/Uw50puidKypM969urqdIFuT0ZCb9NZI4a8/iRekjRKHFXPNbeIJs51WNo=" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cjohn.bridgman%40amd.com%7Ce7bf224775ad487d240708d7b47992f4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176306561328560&amp;amp;sdata=QbfaIN%2F6LvgUihz5O0x41TwvdGYy7QTS5IVJq3RXYlA%3D&amp;amp;re
 served=0</a><br>
                        </div>
                      </span></font></div>
                </div>
              </div>
              <br>
              <fieldset class="x_mimeAttachmentHeader"></fieldset>
              <pre class="x_moz-quote-pre">_______________________________________________
amd-gfx mailing list
<a class="x_moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="x_moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CJohn.Bridgman%40amd.com%7Ccda5469b6f5f4ae43e6d08d7b47d899a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176323587003958&amp;sdata=6eKo51jnHbE1QWkDB%2BN%2FFLMLB40HA2wVN3mU1l%2FeFhk%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="U6meQaXVtmMvUg9YEUEclm83S&#43;Z07KrR9tCRISlpsrQ2MhZ3nHWjky8Y5XYAe9N&#43;vGF9XTpXLPgG33LoV6btCVtFURjkdXC6O1izBKd19S&#43;02Npep/Uw50puidKypM969urqdIFuT0ZCb9NZI4a8/iRekjRKHFXPNbeIJs51WNo=" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
            </blockquote>
            <br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------EAA9072E2165D2188AD24407--

--===============0346911160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0346911160==--
