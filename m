Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F380BC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 12:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8F720760
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 12:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NZHMYZid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8F720760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DDA1892BF;
	Thu, 11 Jun 2020 12:13:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6DA4892BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 12:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2XY3mDTyOHV978imHDK2FNtUCOVTgo0zi4GlD/CbOwq9tzUNh6kHWy0r+i44JXtknDvM/JH9iuT0rXi0wAX4iBwd1i6n9O1b5hxJ/5DXsztl55bPhefnDNKPcAW/boYS+Jg8v+4Pm8M03Kw2kznvRGVWEanSpiRaw+6OAuVvJUypzt0QOKTn/wek9Ov9pvkxdQiCFcJzL2ZLy3Buz5VmOyHCmjIlL+ELlbURN1NbhxAnglZ63Nz9drRRMWtb1XpmvyAeXSqxO0SsymAbxDK4Ql9l3DvIDX+C2lM8Jnk2icEijUY/7bNliziFIDdNeza+QkMzoHu9U59Su1KxALHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+jbyf8Ob5y7PzAyN+NlpGSMgakMPENMWdFFt8hqznA=;
 b=T8qbaZKSJn4iSeCGKWrLYr6AkvIQcqJT3Z63rfEiApy8Soa2voKcmzDUMVaXu6DhJ25AUOypLnzHcJiDerAKlJTFD5S6NFurrxjamVeZwhoFVjc3iO3niIn2/mncRXudGZxivCpuIW5aQzAfzgAQhMyn7rMRRnES7Y+PvXe+NTMdemuf4C5ta96DQ+CVNPPcZSbEvGwRRubFQ0Hbn0iNsH1kbHLde5ZXor/W/uZbJymLqFf1pT0JfjGRTp6KUNFIGQdGVw0bwSv2KwfsDDdNK+UaVd4R93g1qaOi+3ype5EnpfuTjAnJFaC+T5Q0hN0PpV3iflnDZBRh46edFe5R7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+jbyf8Ob5y7PzAyN+NlpGSMgakMPENMWdFFt8hqznA=;
 b=NZHMYZidBXkIbGp2vLh8zmsvTq3iCMckfAU+/yt/csRymIJ4G1lxFQ/eOaKx3q2Ax+MPJs+fc208E92tU3YehECf5dmrYm/FGusDNkLr07x0xRuJMy4z6UMzFoFzveFiaHTMhP/Pv+rCYtM+fcYYmlofky5T9HhCSttRXFUVJuY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0127.namprd12.prod.outlook.com
 (2603:10b6:301:58::13) by MWHPR12MB1247.namprd12.prod.outlook.com
 (2603:10b6:300:10::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Thu, 11 Jun
 2020 12:13:43 +0000
Received: from MWHPR1201MB0127.namprd12.prod.outlook.com
 ([fe80::b4b8:1fc2:8c15:51]) by MWHPR1201MB0127.namprd12.prod.outlook.com
 ([fe80::b4b8:1fc2:8c15:51%3]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 12:13:43 +0000
Subject: Re: [PATCH] drm/amdgpu: remove distinction between explicit and
 implicit sync (v2)
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <CAAxE2A6T-hGWE7r_aFVmPyO__wh5kptbJiJ7rYd7dFg2TH2BKw@mail.gmail.com>
 <DM5PR12MB24405F71791676A64CB02D9EB4830@DM5PR12MB2440.namprd12.prod.outlook.com>
 <b47f193a-9103-ca7b-85e6-c8a52a977da8@gmail.com>
 <82cfde02-d2e4-35fe-f790-7ce63145aacc@amd.com>
 <CAAxE2A4JsmQL8kUA1Z0aq3sK86D3oJ54YkRe=yEo1AXJ1MT-yg@mail.gmail.com>
From: Chunming Zhou <zhoucm1@amd.com>
Message-ID: <161297ae-c098-27fe-ed80-2b46f64c1065@amd.com>
Date: Thu, 11 Jun 2020 20:13:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <CAAxE2A4JsmQL8kUA1Z0aq3sK86D3oJ54YkRe=yEo1AXJ1MT-yg@mail.gmail.com>
X-ClientProxiedBy: HK2PR03CA0053.apcprd03.prod.outlook.com
 (2603:1096:202:17::23) To MWHPR1201MB0127.namprd12.prod.outlook.com
 (2603:10b6:301:58::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.118.49] (180.167.199.182) by
 HK2PR03CA0053.apcprd03.prod.outlook.com (2603:1096:202:17::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.9 via Frontend Transport; Thu, 11 Jun 2020 12:13:41 +0000
X-Originating-IP: [180.167.199.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6733f0f6-0e63-4e02-4451-08d80e00e231
X-MS-TrafficTypeDiagnostic: MWHPR12MB1247:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1247D0F71C2408F325A248ACB4800@MWHPR12MB1247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYeT+tyNIG/WYD83JDS2jSOe1/wGhOXEDp20lkn61Ti+G9wZ+kVIhgsQ6gH4cctoOdCdxIfRMH/628AUGfiFbtzpTPmVMv+V2cm1a+jsXO3AFKeSqmr2/9PAy/2xFFoCQrjjM5z2B7G68nK6kvM8RSEF+JuLEW6o0E2qxh2HORZr84IIzVHfoN2QLGSQ3kbz2IHCoIzq1JEdqenYxNXYBGyrzbniEl1qhXPFLjQ3N9zFepEFBDpNjpYlvbi93QaMm8MrdGHwq13+RYATcbqhzL6Sr8aOJrsKznq+QEGI5huaIu8vsnMKHeqcOqayu/2UHjr4NVPsfXzbSZnaYA68CMoy8rFbA5aYU6J5OcBmbYrMnmHZZF2l58RYlxTZPeYLup6aSkkmouAtDBxdjJpIG9PdHgmRGC+/v0d/3KGsO4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0127.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(5660300002)(66476007)(6666004)(2906002)(31686004)(66556008)(166002)(66574014)(31696002)(66946007)(6486002)(36756003)(478600001)(16526019)(316002)(16576012)(186003)(45080400002)(8936002)(8676002)(26005)(966005)(83380400001)(2616005)(53546011)(54906003)(6916009)(33964004)(4326008)(956004)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Dj1uBulkUJcbLxQIJuuAopQmIpEOS2xK9criigJ8XBAIuKhUef16g/gJiQpzcQh1+oR7fjiqTuXrcvVRAszcDjcmFbALQcvzNLQhTn5JAq9BH/lGOZMIajZNOIJDP7+Sn8gzq1MLuARzKrbP48GS+Jd8gIYZmsGt4cih31qa7o8NrYvtyeYNbMQBhs2u9RbCqr22pyU+ob2ys8FO5U1cMQ/Tz3AN9ZMlYf/X+kVrYqd4mZ9ciVTE5oZRs6A5y+sz695olB7J3x5XPOhn0QanSHjpnomL6Wf6C16f2KGKQw+9LFRdb6PJim0QwAJIbKRCSfMAXL3WL5oMinwWTW+MEMoFhTMdJeDgrqVSc5E35NJ56UaRXEzimONOqn7n2vdkt9rcek3HgRqYkpMtKdS369AgCU5L9QafDYP03ZJXz+i7E7EDfeQtawPyJGu10yU8M6O/a576ES56Z6TviA4reJ2TZ+QXJLvui4ZsLjCUs8E7mWMK4gqL0y9HMIFRzBrN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6733f0f6-0e63-4e02-4451-08d80e00e231
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 12:13:43.4231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5LoB5pUBCITeOt6qO0GaYAXFpO1Z0ZYlPHBudAbfCOsWD8VQ69ITvsXUrc0a6tb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1247
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
Cc: "Zhou, David\(ChunMing\)" <david1.zhou@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1836460603=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1836460603==
Content-Type: multipart/alternative;
 boundary="------------C39FE8116C43654DE5F089C5"

--------------C39FE8116C43654DE5F089C5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I didn't check the patch details, if it is for existing implicit sync of 
shared buffer, feel free go ahead.

But if you add some description for its usage, that will be more clear 
to others.

-David

在 2020/6/11 15:19, Marek Olšák 写道:
> Hi David,
>
> Explicit sync has nothing to do with this. This is for implicit sync, 
> which is required by DRI3. This fix allows removing existing 
> inefficiencies from drivers, so it's a good thing.
>
> Marek
>
> On Wed., Jun. 10, 2020, 03:56 Chunming Zhou, <zhoucm1@amd.com 
> <mailto:zhoucm1@amd.com>> wrote:
>
>
>     在 2020/6/10 15:41, Christian König 写道:
>>     That's true, but for now we are stuck with the implicit sync for
>>     quite a number of use cases.
>>
>>     My problem is rather that we already tried this and it backfired
>>     immediately.
>>
>>     I do remember that it was your patch who introduced the pipeline
>>     sync flag handling and I warned that this could be problematic.
>>     You then came back with a QA result saying that this is indeed
>>     causing a huge performance drop in one test case and we need to
>>     do something else. Together we then came up with the different
>>     handling between implicit and explicit sync.
>
>     Isn't pipeline sync flag to fix some issue because of parralel
>     execution between jobs in one pipeline?  I really don't have this
>     memory in mind why that's realted to this, Or do you mean extra
>     sync hides many other potential issues?
>
>     Anyway, when I go through Vulkan WSI code, the synchronization
>     isn't so smooth between OS window system. And when I saw Jason
>     drives explicit sync through the whole Linux ecosystem like
>     Android window system does, I feel that's really a good direction.
>
>     -David
>
>>
>>     But I can't find that stupid mail thread any more. I knew that it
>>     was a couple of years ago when we started with the explicit sync
>>     for Vulkan.
>>
>>     Christian.
>>
>>     Am 10.06.20 um 08:29 schrieb Zhou, David(ChunMing):
>>>
>>>     [AMD Official Use Only - Internal Distribution Only]
>>>
>>>     Not sue if this is right direction, I think usermode wants all
>>>     synchronizations to be explicit. Implicit sync often confuses
>>>     people who don’t know its history. I remember Jason from Intel
>>>      is driving explicit synchronization through the Linux
>>>     ecosystem, which even removes implicit sync of shared buffer.
>>>
>>>     -David
>>>
>>>     *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
>>>     <mailto:amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of
>>>     *Marek Olšák
>>>     *Sent:* Tuesday, June 9, 2020 6:58 PM
>>>     *To:* amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
>>>     <mailto:amd-gfx@lists.freedesktop.org>
>>>     *Subject:* [PATCH] drm/amdgpu: remove distinction between
>>>     explicit and implicit sync (v2)
>>>
>>>     Hi,
>>>
>>>     This enables a full pipeline sync for implicit sync. It's
>>>     Christian's patch with the driver version bumped. With this,
>>>     user mode drivers don't have to wait for idle at the end of gfx IBs.
>>>
>>>     Any concerns?
>>>
>>>     Thanks,
>>>
>>>     Marek
>>>
>>>
>>>     _______________________________________________
>>>     amd-gfx mailing list
>>>     amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7CDavid1.Zhou%40amd.com%7C0d3096fc043f4443f14e08d80dd7c674%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637274567683552668&sdata=xIHDswGRsdCP%2BE7MRI4nKXdoMgV2LBzFPP46zGpQusk%3D&reserved=0>
>>

--------------C39FE8116C43654DE5F089C5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>I didn't check the patch details, if it is for existing implicit
      sync of shared buffer, feel free go ahead.</p>
    <p>But if you add some description for its usage, that will be more
      clear to others.</p>
    <p>-David<br>
    </p>
    <div class="moz-cite-prefix">在 2020/6/11 15:19, Marek Olšák 写道:<br>
    </div>
    <blockquote type="cite" cite="mid:CAAxE2A4JsmQL8kUA1Z0aq3sK86D3oJ54YkRe=yEo1AXJ1MT-yg@mail.gmail.com">
      
      <div dir="auto">Hi David,
        <div dir="auto"><br>
        </div>
        <div dir="auto">Explicit sync has nothing to do with this. This
          is for implicit sync, which is required by DRI3. This fix
          allows removing existing inefficiencies from drivers, so it's
          a good thing.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Marek</div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Wed., Jun. 10, 2020, 03:56
          Chunming Zhou, &lt;<a href="mailto:zhoucm1@amd.com" moz-do-not-send="true">zhoucm1@amd.com</a>&gt; wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">
          <div>
            <p><br>
            </p>
            <div>在 2020/6/10 15:41, Christian König 写道:<br>
            </div>
            <blockquote type="cite">
              <div>That's true, but for now we are stuck with the
                implicit sync for quite a number of use cases.<br>
                <br>
                My problem is rather that we already tried this and it
                backfired immediately.<br>
                <br>
                I do remember that it was your patch who introduced the
                pipeline sync flag handling and I warned that this could
                be problematic. You then came back with a QA result
                saying that this is indeed causing a huge performance
                drop in one test case and we need to do something else.
                Together we then came up with the different handling
                between implicit and explicit sync.<br>
              </div>
            </blockquote>
            <p>Isn't pipeline sync flag to fix some issue because of
              parralel execution between jobs in one pipeline?&nbsp; I really
              don't have this memory in mind why that's realted to this,
              Or do you mean extra sync hides many other potential
              issues?</p>
            <p>Anyway, when I go through Vulkan WSI code, the
              synchronization isn't so smooth between OS window system.
              And when I saw Jason drives explicit sync through the
              whole Linux ecosystem like Android window system does, I
              feel that's really a good direction.</p>
            <p>-David<br>
            </p>
            <blockquote type="cite">
              <div> <br>
                But I can't find that stupid mail thread any more. I
                knew that it was a couple of years ago when we started
                with the explicit sync for Vulkan.<br>
                <br>
                Christian.<br>
                <br>
                Am 10.06.20 um 08:29 schrieb Zhou, David(ChunMing):<br>
              </div>
              <blockquote type="cite">
                <div>
                  <p style="margin:0in;margin-bottom:.0001pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078d7">[AMD
                      Official Use Only - Internal Distribution Only]</span></p>
                  <p class="MsoNormal">&nbsp;</p>
                  <p class="MsoNormal">Not sue if this is right
                    direction, I think usermode wants all
                    synchronizations to be explicit. Implicit sync often
                    confuses people who don’t know its history. I
                    remember Jason from Intel &nbsp;is driving explicit
                    synchronization through the Linux ecosystem, which
                    even removes implicit sync of shared buffer.</p>
                  <p class="MsoNormal">&nbsp;</p>
                  <p class="MsoNormal">-David</p>
                  <p class="MsoNormal">&nbsp;</p>
                  <div style="border:none;border-top:solid #e1e1e1
                    1.0pt;padding:3.0pt 0in 0in 0in">
                    <p class="MsoNormal"><b>From:</b> amd-gfx <a href="mailto:amd-gfx-bounces@lists.freedesktop.org" target="_blank" rel="noreferrer" moz-do-not-send="true">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                      <b>On Behalf Of </b>Marek Olšák<br>
                      <b>Sent:</b> Tuesday, June 9, 2020 6:58 PM<br>
                      <b>To:</b> amd-gfx mailing list <a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" rel="noreferrer" moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                      <b>Subject:</b> [PATCH] drm/amdgpu: remove
                      distinction between explicit and implicit sync
                      (v2)</p>
                  </div>
                  <p class="MsoNormal">&nbsp;</p>
                  <div>
                    <div>
                      <p class="MsoNormal">Hi,</p>
                    </div>
                    <div>
                      <p class="MsoNormal">&nbsp;</p>
                    </div>
                    <div>
                      <p class="MsoNormal">This enables a full pipeline
                        sync for implicit sync. It's Christian's patch
                        with the driver version bumped. With this, user
                        mode drivers don't have to wait for idle at the
                        end of gfx IBs.</p>
                    </div>
                    <div>
                      <p class="MsoNormal">&nbsp;</p>
                    </div>
                    <div>
                      <p class="MsoNormal">Any concerns?</p>
                    </div>
                    <div>
                      <p class="MsoNormal">&nbsp;</p>
                    </div>
                    <div>
                      <p class="MsoNormal">Thanks,</p>
                    </div>
                    <div>
                      <p class="MsoNormal">Marek</p>
                    </div>
                  </div>
                </div>
                <br>
                <fieldset></fieldset>
                <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" rel="noreferrer" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CDavid1.Zhou%40amd.com%7C0d3096fc043f4443f14e08d80dd7c674%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637274567683552668&amp;sdata=xIHDswGRsdCP%2BE7MRI4nKXdoMgV2LBzFPP46zGpQusk%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="hAGAyoS6auIG5z/ymuBRZ8NQ1FyVyzxjLTP8d56vUWHt3KOGxnZA9JR3arWRHVNGShrJPcF8kl5FVDL8/CaUnIELQRxp&#43;YA&#43;LqJpUCIUiFkJQUnkS8xLZ4pFCx17bcOL632sj4r1sETdA7zJMsD8dR7TUlzPxzmmzFhKnYvV&#43;/w=" target="_blank" rel="noreferrer" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
              </blockquote>
              <br>
            </blockquote>
          </div>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------C39FE8116C43654DE5F089C5--

--===============1836460603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1836460603==--
