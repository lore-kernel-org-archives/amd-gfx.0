Return-Path: <SRS0=jeuu=7X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08825C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 07:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C05442072F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 07:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E9AmRaXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05442072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78DCF89CE2;
	Wed, 10 Jun 2020 07:56:10 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760041.outbound.protection.outlook.com [40.107.76.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 132576E405
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2020 07:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emxCvq1gcxKCOteFZAAbTAlbIU6tLjEImkyTqCs+bmrA0VcB9pL2M1S1TDuXbfp7WZz7w2mH4SYe54c/O8//UI8DqJRr0W9JS66pVjTSCYeVOLiGpnfymTHbQNQicv+mtw0kZpbu7/0u2Fb4fOI4u5HDLDXxwr1sQ7ItH2eaA/HGNpA4M6vX5SN6qKzvcTYHuhpyEkJHCGPVuAwQ3vu6V64OKq+LtDufYJj/5YFFo0Zfp5YpVcXHrxO3FA4KxtMxsiXs6YnLwZTss2mrcafYNmg1JHhVzTDW73JTCq/hNrvO/Gw9LhVFkxHUfhiQH1omJvMUpsX5eD1aBXj4kzNueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJFF5TKtShNnLWtaJsSZKd3ns6Nn+y1yms0yq8avDrE=;
 b=mn6dfRJFpcyLKThBie3vzcIM8qNz7hFy92xQhrpHolA32XTKtr+xRVkjldTWoKuw+sD9OCDsOOBtzyN3gTR1uV+AMziv8az9HWSFwz/JK3jjMIYF+zB6JT4VEdGpdTagpHJsgf6++fC3QII/pwXeoCP/gi2LtO3SwWxG53kWzwOcdFxLwrhHCDlXbCepRdo1fqKgxaN4PsElwSPpBi/ysPI+6tSLWOFO6ohLV8YKWCZpOaUZxPgrqJPrgvBcLLPeOfKsmyP7JLthEc++4CXrrFiyAY2IeMnYh4vJZ40jTkb1RpNUdWB5TX3bg5AAmUzM45wUejFoXBlGRQ8m85Uvrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJFF5TKtShNnLWtaJsSZKd3ns6Nn+y1yms0yq8avDrE=;
 b=E9AmRaXKI40ASYE/+rJnMkJD7OMZE6dZsZc0XAu6CXk5QMD/yHFVQeKzCKUBd/Tc09S190+yeFRkcPW5JAqj9NMCbrDX+gVfZFggSzkaEdrY9svPQOZMAtp9WDLAeM7kJkobJxkTlCzckkJ74vcEuYyF8a/kEWz+hI0HyjBxr9w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) by
 DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19; Wed, 10 Jun 2020 07:56:07 +0000
Received: from DM5PR12MB2440.namprd12.prod.outlook.com
 ([fe80::cdac:3b10:3487:83be]) by DM5PR12MB2440.namprd12.prod.outlook.com
 ([fe80::cdac:3b10:3487:83be%6]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 07:56:07 +0000
Subject: Re: [PATCH] drm/amdgpu: remove distinction between explicit and
 implicit sync (v2)
To: christian.koenig@amd.com, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
References: <CAAxE2A6T-hGWE7r_aFVmPyO__wh5kptbJiJ7rYd7dFg2TH2BKw@mail.gmail.com>
 <DM5PR12MB24405F71791676A64CB02D9EB4830@DM5PR12MB2440.namprd12.prod.outlook.com>
 <b47f193a-9103-ca7b-85e6-c8a52a977da8@gmail.com>
From: Chunming Zhou <zhoucm1@amd.com>
Message-ID: <82cfde02-d2e4-35fe-f790-7ce63145aacc@amd.com>
Date: Wed, 10 Jun 2020 15:55:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <b47f193a-9103-ca7b-85e6-c8a52a977da8@gmail.com>
X-ClientProxiedBy: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To DM5PR12MB2440.namprd12.prod.outlook.com
 (2603:10b6:4:b6::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.121.145] (180.167.199.185) by
 HK2PR02CA0162.apcprd02.prod.outlook.com (2603:1096:201:1f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Wed, 10 Jun 2020 07:56:05 +0000
X-Originating-IP: [180.167.199.185]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba16428e-866d-4320-a133-08d80d13bb52
X-MS-TrafficTypeDiagnostic: DM5PR12MB2583:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25835124431E8B26F2A184A8B4830@DM5PR12MB2583.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /IrN0lWwja+1YyFaheLVsJd4E9uCx9VdJf2xBSsmBRRcKsZJS4c9OCE/Bbwk9jO188o/EzAo6v1BKFVdKrkzy6YgOwfsYfQXI9nsih9h7gDEo2AV5zAaYFUomER6hRCApC/2ub2ItSYAlw0/M2jzoUgr4TOwYTqej0FdcLSSZX9b3NS2MYgVsVclMAErVWMJOkZtESfn/5Q0f22ldGeIrw5ljMd/LHC10QM+YuYG3d7U3M+rV1lxu7Z+3SpMyUjgjjrNY/OGRR3VGu/siSRhK7V7u553aOqFTtsfPzQq+bDXn3opZJxGsIoQG5pcXnG+30i/7Z2++D0JxY+zZen4dI5GoPFp3YC4HDm+JlUj7i5V0e2MCgPG4dO9F25o4t94os/EpRf0TvklraREJ8F+aCqXo4bil2yVgQSbQ1/i2N8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2440.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(478600001)(316002)(26005)(186003)(16576012)(110136005)(33964004)(52116002)(53546011)(16526019)(166002)(66574014)(956004)(2616005)(966005)(6666004)(83380400001)(5660300002)(66556008)(66946007)(8676002)(8936002)(2906002)(36756003)(31686004)(31696002)(6486002)(66476007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cbTCuRcuHtU+hx+GIOz1u7CYmWiDnpcXTxM2Tf1THFBu9X8QbmsKCq5E5MA5vPRf6ZYv0tovyoZnazdmLcLIgpe8MZE7k3+M9vtndNwHqjVA4y3OhHAKd+YO3fDsEvFUVhCENr4ZvohI0NiB91SPWXmSU1kRJJRgeyjAy7JDxJDs0CGUh4xY6aprEADIwvUKj12NOOsssrCnNwMsIRFIpFSWmTJdgKUZbq/1K9rPktTYEqPH47aayqKP/MWjI2qaDdh/xS800K0GsDYW7p0lRd0CG2CSacf2PlTsFWELGZxPvViGFM+yps2Ps7x4aP0DUjMsOIiofVtQ/5ST+YV8bbp7ALR14PJaQ8d/i9bLqyFVxsOAKuP4B14HAARIeIb0/85yuOG1ZwaJROjQNtzBLGlObxhjzNTr4TemcNjJbn3CHuaBu1U8IFNeJA9B0sU03RkV3mY2bS27jgowy+ljfWYv1QLY/c+sujVEWNQR11nCI7CmkPnYANtusVlxryrL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba16428e-866d-4320-a133-08d80d13bb52
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 07:56:07.4037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHxUcTo2vIVNOaTU6a0Rojce0YY/iZEgM2AdZM4Ga0DJJjdjjw/JhRl3jtqTsW4F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2583
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
Content-Type: multipart/mixed; boundary="===============1610943760=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1610943760==
Content-Type: multipart/alternative;
 boundary="------------048C22828C49F935361BCCAA"

--------------048C22828C49F935361BCCAA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2020/6/10 15:41, Christian König 写道:
> That's true, but for now we are stuck with the implicit sync for quite 
> a number of use cases.
>
> My problem is rather that we already tried this and it backfired 
> immediately.
>
> I do remember that it was your patch who introduced the pipeline sync 
> flag handling and I warned that this could be problematic. You then 
> came back with a QA result saying that this is indeed causing a huge 
> performance drop in one test case and we need to do something else. 
> Together we then came up with the different handling between implicit 
> and explicit sync.

Isn't pipeline sync flag to fix some issue because of parralel execution 
between jobs in one pipeline?  I really don't have this memory in mind 
why that's realted to this, Or do you mean extra sync hides many other 
potential issues?

Anyway, when I go through Vulkan WSI code, the synchronization isn't so 
smooth between OS window system. And when I saw Jason drives explicit 
sync through the whole Linux ecosystem like Android window system does, 
I feel that's really a good direction.

-David

>
> But I can't find that stupid mail thread any more. I knew that it was 
> a couple of years ago when we started with the explicit sync for Vulkan.
>
> Christian.
>
> Am 10.06.20 um 08:29 schrieb Zhou, David(ChunMing):
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> Not sue if this is right direction, I think usermode wants all 
>> synchronizations to be explicit. Implicit sync often confuses people 
>> who don’t know its history. I remember Jason from Intel  is driving 
>> explicit synchronization through the Linux ecosystem, which even 
>> removes implicit sync of shared buffer.
>>
>> -David
>>
>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of 
>> *Marek Olšák
>> *Sent:* Tuesday, June 9, 2020 6:58 PM
>> *To:* amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
>> *Subject:* [PATCH] drm/amdgpu: remove distinction between explicit 
>> and implicit sync (v2)
>>
>> Hi,
>>
>> This enables a full pipeline sync for implicit sync. It's Christian's 
>> patch with the driver version bumped. With this, user mode drivers 
>> don't have to wait for idle at the end of gfx IBs.
>>
>> Any concerns?
>>
>> Thanks,
>>
>> Marek
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--------------048C22828C49F935361BCCAA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">在 2020/6/10 15:41, Christian König 写道:<br>
    </div>
    <blockquote type="cite" cite="mid:b47f193a-9103-ca7b-85e6-c8a52a977da8@gmail.com">
      
      <div class="moz-cite-prefix">That's true, but for now we are stuck
        with the implicit sync for quite a number of use cases.<br>
        <br>
        My problem is rather that we already tried this and it backfired
        immediately.<br>
        <br>
        I do remember that it was your patch who introduced the pipeline
        sync flag handling and I warned that this could be problematic.
        You then came back with a QA result saying that this is indeed
        causing a huge performance drop in one test case and we need to
        do something else. Together we then came up with the different
        handling between implicit and explicit sync.<br>
      </div>
    </blockquote>
    <p>Isn't pipeline sync flag to fix some issue because of parralel
      execution between jobs in one pipeline?&nbsp; I really don't have this
      memory in mind why that's realted to this, Or do you mean extra
      sync hides many other potential issues?</p>
    <p>Anyway, when I go through Vulkan WSI code, the synchronization
      isn't so smooth between OS window system. And when I saw Jason
      drives explicit sync through the whole Linux ecosystem like
      Android window system does, I feel that's really a good direction.</p>
    <p>-David<br>
    </p>
    <blockquote type="cite" cite="mid:b47f193a-9103-ca7b-85e6-c8a52a977da8@gmail.com">
      <div class="moz-cite-prefix"> <br>
        But I can't find that stupid mail thread any more. I knew that
        it was a couple of years ago when we started with the explicit
        sync for Vulkan.<br>
        <br>
        Christian.<br>
        <br>
        Am 10.06.20 um 08:29 schrieb Zhou, David(ChunMing):<br>
      </div>
      <blockquote type="cite" cite="mid:DM5PR12MB24405F71791676A64CB02D9EB4830@DM5PR12MB2440.namprd12.prod.outlook.com">
        <meta name="Generator" content="Microsoft Word 15 (filtered
          medium)">
        <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
        <div class="WordSection1">
          <p class="msipheader4d0fcdd7" style="margin:0in;margin-bottom:.0001pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
              Official Use Only - Internal Distribution Only]</span><o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">Not sue if this is right direction, I
            think usermode wants all synchronizations to be explicit.
            Implicit sync often confuses people who don’t know its
            history. I remember Jason from Intel &nbsp;is driving explicit
            synchronization through the Linux ecosystem, which even
            removes implicit sync of shared buffer.<o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">-David<o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
              <b>On Behalf Of </b>Marek Olšák<br>
              <b>Sent:</b> Tuesday, June 9, 2020 6:58 PM<br>
              <b>To:</b> amd-gfx mailing list <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>Subject:</b> [PATCH] drm/amdgpu: remove distinction
              between explicit and implicit sync (v2)<o:p></o:p></p>
          </div>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <div>
            <div>
              <p class="MsoNormal">Hi,<o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            </div>
            <div>
              <p class="MsoNormal">This enables a full pipeline sync for
                implicit sync. It's Christian's patch with the driver
                version bumped. With this, user mode drivers don't have
                to wait for idle at the end of gfx IBs.<o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            </div>
            <div>
              <p class="MsoNormal">Any concerns?<o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            </div>
            <div>
              <p class="MsoNormal">Thanks,<o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal">Marek<o:p></o:p></p>
            </div>
          </div>
        </div>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CDavid1.Zhou%40amd.com%7C47e97eb8e3654708f7ff08d80d11bcf7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637273717119277965&amp;sdata=EFq2J33HIOiIS3bok2ZcIz%2FhE%2FVs9T0HPy0UFi92Nf4%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="Wu5qQmsssmDlZ3rZ8IUyvRR2RfYafdPHoiCAOgS6xtMeQYWO2FSq6&#43;sbfoOW7KsVB7/XQSBzwDxl44F98MSMJ1O&#43;xswyjle0NkNaUYcRjfMubSYTw7VV0tGW2u/ZO2v&#43;2wy5w6UBj0PpHnsTiO9ppxdUb6HlyqdJJAKZR12o0Fw=" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------048C22828C49F935361BCCAA--

--===============1610943760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1610943760==--
