Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03757C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 20:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63A860F25
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 20:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B63A860F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ACBA6E0BA;
	Mon, 18 Oct 2021 20:29:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 322FA6E0BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 20:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLz4vD2aUmRoIlvDgQJ03OuQd+33BxjkscVfa+9PtVxmEihlJu5ytDyS4M0lNo4ZBJTRJMLElmwgWCIfViI2YC/mSZlozIlmLJcz1mCj5HcjgOsqqwP4XQBtSSzFCj4mFDW31nV3edXXHEFkiKrTLHWFQ8OQ3CRpvg2qyjIT50bt4iilWr7wnJhq7ho9tot22ip3d1aXTkUmTPJTU5Ae6mmTApLaSS4gTQkgsynAUwJOpi1bfyboOsn20RzRGRWwGDP7ts4DhDvYvYueX/uQumVha182lAVob31xtFgQxFEDLEVcqfYY24rX2i4N4RrSAmcwRBKduF6L59bFIspT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FsyAk7Nw+NOaapeUKqIg6s8G0P+CpyIL8dXgE/NuLI=;
 b=N/J2dgSJB/D4nJW49PhjNkCwuMp8EswTgdkaL4QSHEBujLtkWeu/tA9zEbFClOo9XwVbhezy84LJ+djxDvqJk/rTBy0Pp3qWBPgKu1x7VukYWi6gFAxs3P+VvJTZ6iORCkos+j350Owgdj148XmPkYEGLwpyP6SY9+sDBphLQD3IHmvxDM091HXw6F2FlVx97cNukrFfVrp1j2OJVyMIESjFYjIeZAoCwZC5biZUt0695YMBmVrGwdkdIP1COsHpNRxreHw4aRI1Ozdu9jTMRVvUPNM+449W30KzJjNxVDFww4OwFqCakD0yIQ4vp0JmLMj/Q1Un8LABRua+EAvlEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FsyAk7Nw+NOaapeUKqIg6s8G0P+CpyIL8dXgE/NuLI=;
 b=zWpcpjMTxGVn85imb0a1WQ5r5vI7RM+Jep3Nz1dj4vQPrLPkKALYO1rj4EmhJR/4E5+4GftDOjBkncBFRDKfb4/pYmbbMwcocqR85Id1Lu6gzklhTb7/NCupCcyAUtYKAfsE/TRxSrQiQgstlEmK4yy4F2yrS2g+t9mHIjkRzCM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 20:29:49 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3%7]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 20:29:49 +0000
Message-ID: <091c6805-a72c-a286-f7fb-9d5d5da344d3@amd.com>
Date: Mon, 18 Oct 2021 16:29:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
Content-Language: en-CA
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Russell, Kent" <Kent.Russell@amd.com>
References: <20211013031042.53540-1-luben.tuikov@amd.com>
 <858da53c-7937-3ebf-360d-f20f30f825d9@amd.com>
 <e3d94e8a-ea9b-85cc-8e85-2ee2e6725f2f@amd.com>
 <DM6PR12MB39307EA02DE72479774D8FF297B79@DM6PR12MB3930.namprd12.prod.outlook.com>
 <DM6PR12MB26196111DA43A1EE11266558E4B99@DM6PR12MB2619.namprd12.prod.outlook.com>
 <BL1PR12MB51443E4EA64480401839E135F7BC9@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <BL1PR12MB51443E4EA64480401839E135F7BC9@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::17) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [192.168.1.14] (135.23.225.238) by
 YT2PR01CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18 via Frontend Transport; Mon, 18 Oct 2021 20:29:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa851f08-0e31-4f12-68d3-08d99276083b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2988:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2988B2D3E05FF8A1D0D9334299BC9@DM6PR12MB2988.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +WRN6AK9ZTlIW0XQWH0quVn5XJwvAtSmteAIqb84FdV0tLaPAHh1Zi1ECNebz/9fDuUfVO8F56QmNaj39lhuuO5xOQxUi8l1aHx9albQMn3xHqrf3PcEeAuuSXGOgTl6asnbIffKMO374wBmFEUqmSEEuvI4ojxYy/L1xpDlCuwZfzQNRY6/8zuVN9OWSsJTaQU+njr3l0tD6XO4enAsLobNONTP3i5GHSGZ5+hVphpVYb5hiZgVhOrjVbRzNpLHJ4d6wTs/1BzFd3gK94UOfWo4Wuap81oGlvP4GKqxtfXDaadiJBX6YtKq/znckZiTDfgAVMXYf7l8ITilPCOj3snXTqShfe+f4G6AHGMTQLjWdUy18+ATf6jeY0BZ+2GbYyRxRyjpyZ/+FkPPzIpA0ALXfPKUvcAAR0LAUV5uV6OEuGjA9SsVQN5NZfarlmpbSy4EksXy9wZIlQVrVrTi9DV7P21dhEeTb98KR/UMatItR5bqAnRzhP+IqdqJQY9pPR7uxhu3BSPeuINKJQV5QTv7BbMSXGjNlrzLtraUBXuIshclefMtoLWdDzdf035NCutHQ+5Ru4gTAq5ctg71yxCQjRIezAONbsbCAjsPioaMgUyprWj+g2PsdAWepT3Gwmvu5HqtWXRl8TRlIMwWfu5qM+mizeInfUZEqaqUkv4kGCwF9/iRflYZlk037pobfYfk5ufEQJmvOcu0IcstKhondHSUzH6eLYFXiIvdj21znnArnO4qiSCLUwU388OH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(31686004)(31696002)(66476007)(66556008)(16576012)(53546011)(83380400001)(956004)(6486002)(2616005)(2906002)(508600001)(5660300002)(66946007)(26005)(186003)(86362001)(36756003)(110136005)(38100700002)(8676002)(8936002)(6636002)(44832011)(19627405001)(4001150100001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bys0WVB0TFZHVnlKcTIwc1ppd3g2L1REQVJCdmppcXU2WEc2TzZLNnI3OFRi?=
 =?utf-8?B?K2J3TDc0S1RYMk50Q0hNN2pHMnZDQVVqWmJUTVlxNTVoVHZhdld5WUQzTThj?=
 =?utf-8?B?ejhoSURGNkppRlZrREhkN0NiSlRrVVpRaW5WcmtFWkVNQ244ZDExU3dUeHpj?=
 =?utf-8?B?bXdyRjVEVGNVU20zVjNvbFFEb1NuSGJna3QydUNlaWl1OWNVYnVFZnFKY3da?=
 =?utf-8?B?N1pJZ2cwaXZpeFdleXlzaTVVczQ0NEpoVDBWQmpCMzVvZWM4SXZZQXhZYnN4?=
 =?utf-8?B?TmFMa3NaRVR3QitGRGpheTJvQW90VndSN3ZqVWFDUGl4Y21hYlRjWER4cVN4?=
 =?utf-8?B?dUcxY29JYklVVjVRTERndVVDQlc3c3Nmb1BKQnRXai9YSUhmZ1pLemo5Zlhl?=
 =?utf-8?B?RkNGeS81ejJwUU0yOFY3dEM1TjU5VDQrem82Um4yVEJEK3MraFB3TStoN3dH?=
 =?utf-8?B?Wm9RZW53cS9DYnVPRWNXQkVMVHlKRW9ETHRoYUFuVW15K1cxaGVjNkR0M3NR?=
 =?utf-8?B?eGpSeWtkWVBEVEExOGxQam14VitmQXRuYS9VSGc0K1M3ODNVVThIR0wzTTV5?=
 =?utf-8?B?eEJtYWxCQllTbGxEZWpueEpnQmJhUG9mS0kxLzRuTVQyelNLRnVCZGZaY1J6?=
 =?utf-8?B?QXFxdmtNdm15aGlJcFBESS9GaTljYTFHMDhOQzRNT1E3eTRTN2hkbSthdVg4?=
 =?utf-8?B?WFFhZjhaSEYvNW9BU2lPazYvMlJ2MXRlNWEzdHdTbFFsZk1CUDB1bFE0R1RV?=
 =?utf-8?B?Sm9jQzRlWmVVUFFwVVJPWGRUc2lqWXdVZEFzK09tcndEaUlBc2dyZ05GQ1F5?=
 =?utf-8?B?YTRMRjJBWGU2aEZkK2VGbG5PYlNtR0hVVldZTitITllNbDU0a1c2L0hPcUps?=
 =?utf-8?B?d29IOXdWc09RaVArbGhhQUM1MXVqNjN5ZWgvbWlEaE15ZGdaRnF5allvRnh4?=
 =?utf-8?B?WklabjZkeEZmb3NpY3ZNTG1tbEVPc0c2RVRsejRxalhlM3RnZWcwNTY2ZHVr?=
 =?utf-8?B?Mm5UdVU2M1BXNUEwczdIY1oxczdpNWtkZ0t3YXRQUXdvcnFaYnZKQkhHaitq?=
 =?utf-8?B?ektTQ25hdmg2NE5iTXM1WGpobmNuZU1MMjl4MFdzSDVJOGdlYklrRnlEendt?=
 =?utf-8?B?bk1EUzVDYUZpK0ljSFdZdHdLMTRLa3R5L3ZpZ0xRUW9hN0o3K1N6U284WHBZ?=
 =?utf-8?B?MjZnek93dEIvZE5BYkQ4amJ4dC9sbGRmeEgrVUtZQ3lwUWJjVXdjMlNnbnJM?=
 =?utf-8?B?N0ZpcXVJZDlkWXFUNHRIb1ByM3FYTnNueWN5UCsybXEwY1NVRWNPQ2lFQlVn?=
 =?utf-8?B?ZXdTcVpQQVgvZi9QQUVHUU9CaWxJb2cwaE9aK1RqVU1VczMyZVMyTWNMa09r?=
 =?utf-8?B?NENuRDBPSnQ4RWlVY0hsVUNpT1RKZWJaaEVpN2hkeGpNZXRPM1FIQXVpdGlJ?=
 =?utf-8?B?QjA2NCtVZ1VuU2Zxd0lVak4xVHp1Z3J1V0VSRGwvbksvZDBJWTJKdzh1VGpO?=
 =?utf-8?B?TlI4enlMR3dXSFFQV1ZYMkFBZjM0TGpEaUE3c2tkR0hudWN4bUZERVV6NGRk?=
 =?utf-8?B?cmlPWXBJMVNqNjdKRlBqR25DUDJjSU1pY0NKS3Uwblk2ZmhveGNGSjBiY1E0?=
 =?utf-8?B?eXE0K0xEUWd5WU5nelRUc1BkMnUzYlgrdUlidmd3ejVOb01kbXBzSThTOG5O?=
 =?utf-8?B?cnhIcGRyRzlHWkEyY1NJTjFUYmNVQzY1c2JnUGwrMnltYjRRMEo3OUsyNkJa?=
 =?utf-8?Q?4N6bMMyBupfUnv4FWkXqw2QA9cA1J+3605UGdcd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa851f08-0e31-4f12-68d3-08d99276083b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 20:29:49.2912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MV0PCkUbpD3+Y/SEcCzWmcTUBL5u4dklDtmSMNVCcuIzUt6tni0QZQb7Ozq/x6fs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
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
    <div class="moz-cite-prefix">I think Kent is already seen these
      patches as he did comment on 1/5 patch.<br>
      <br>
      The v3 version of the patch, posted last week, removes the
      asterisk to report the lowest frequency as the current frequency,
      when the current frequency is 0, i.e. when the block is in low
      power state. Does the tool rely on the asterisk? If this
      information is necessary could it not use amdgpu_pm_info?<br>
      <br>
      Regards,<br>
      Luben<br>
      <br>
      On 2021-10-18 16:19, Deucher, Alexander wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BL1PR12MB51443E4EA64480401839E135F7BC9@BL1PR12MB5144.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" align="Left">
        [Public]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          We the current behavior (0 for clock) already crashes the
          tool, so I don't think we can really make things worse.</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Alex</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Quan, Evan <a class="moz-txt-link-rfc2396E" href="mailto:Evan.Quan@amd.com">&lt;Evan.Quan@amd.com&gt;</a><br>
            <b>Sent:</b> Thursday, October 14, 2021 10:25 PM<br>
            <b>To:</b> Lazar, Lijo <a class="moz-txt-link-rfc2396E" href="mailto:Lijo.Lazar@amd.com">&lt;Lijo.Lazar@amd.com&gt;</a>; Tuikov,
            Luben <a class="moz-txt-link-rfc2396E" href="mailto:Luben.Tuikov@amd.com">&lt;Luben.Tuikov@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Russell, Kent
            <a class="moz-txt-link-rfc2396E" href="mailto:Kent.Russell@amd.com">&lt;Kent.Russell@amd.com&gt;</a><br>
            <b>Cc:</b> Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
            <b>Subject:</b> RE: [PATCH 0/5] 0 MHz is not a valid current
            frequency</font>
          <div>&nbsp;</div>
        </div>
        <style>@font-face
	{font-family:"Cambria Math"}@font-face
	{font-family:DengXian}@font-face
	{font-family:Calibri}@font-face
	{}p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}span.x_EmailStyle18
	{font-family:"Calibri",sans-serif;
	color:windowtext}p.x_msipheadera4477989, li.x_msipheadera4477989, div.x_msipheadera4477989
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}.x_MsoChpDefault
	{font-size:10.0pt}div.x_WordSection1
	{}</style>
        <div link="#0563C1" vlink="#954F72" style="word-wrap:break-word" lang="EN-US">
          <div class="x_WordSection1">
            <p class="x_msipheadera4477989" style="margin:0in"><span style="font-size:10.0pt;
                font-family:&quot;Arial&quot;,sans-serif; color:blue">[AMD
                Official Use Only]</span></p>
            <p class="x_MsoNormal">&nbsp;</p>
            <p class="x_MsoNormal">+Kent who maintains the Rocm tool</p>
            <p class="x_MsoNormal">&nbsp;</p>
            <div style="border:none; border-left:solid blue 1.5pt;
              padding:0in 0in 0in 4.0pt">
              <div>
                <div style="border:none; border-top:solid #E1E1E1 1.0pt;
                  padding:3.0pt 0in 0in 0in">
                  <p class="x_MsoNormal"><b>From:</b> amd-gfx
                    <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                    <b>On Behalf Of </b>Lazar, Lijo<br>
                    <b>Sent:</b> Thursday, October 14, 2021 1:07 AM<br>
                    <b>To:</b> Tuikov, Luben
                    <a class="moz-txt-link-rfc2396E" href="mailto:Luben.Tuikov@amd.com">&lt;Luben.Tuikov@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                    <b>Cc:</b> Deucher, Alexander
                    <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                    <b>Subject:</b> Re: [PATCH 0/5] 0 MHz is not a valid
                    current frequency</p>
                </div>
              </div>
              <p class="x_MsoNormal">&nbsp;</p>
              <p style="margin:5.0pt"><span style="font-size:10.0pt;
                  font-family:&quot;Arial&quot;,sans-serif; color:blue">[AMD
                  Official Use Only]</span></p>
              <p class="x_MsoNormal">&nbsp;</p>
              <div>
                <p style="margin:5.0pt"><span style="font-size:10.0pt;
                    font-family:&quot;Arial&quot;,sans-serif;
                    color:blue">[AMD Official Use Only]</span></p>
                <p class="x_MsoNormal">&nbsp;</p>
                <div>
                  <div>
                    <p class="x_MsoNormal" style="background:white"><span style="color:#212121">&gt;</span><span style="color:#212121">Or maybe just a list
                        without default hint, i.e. no asterisk?</span><span style="color:#212121"></span></p>
                  </div>
                  <div>
                    <p class="x_MsoNormal" style="background:white"><span style="color:#212121">&nbsp;</span></p>
                  </div>
                  <div>
                    <p class="x_MsoNormal" style="background:white"><span style="color:#212121">I think this is also fine
                        meaning we are having trouble in determining the
                        current frequency or DPM level. Evan/Alex? Don't
                        know if this will crash the tools.</span><span style="color:#212121"></span></p>
                  </div>
                  <div id="x_ms-outlook-mobile-signature">
                    <div>
                      <p class="x_MsoNormal">&nbsp;</p>
                    </div>
                    <p class="x_MsoNormal">Thanks,<br>
                      Lijo</p>
                  </div>
                  <div class="x_MsoNormal" style="text-align:center" align="center">
                    <hr width="98%" size="2" align="center">
                  </div>
                  <div id="x_divRplyFwdMsg">
                    <p class="x_MsoNormal"><b><span style="color:black">From:</span></b><span style="color:black"> Tuikov, Luben &lt;<a href="mailto:Luben.Tuikov@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Luben.Tuikov@amd.com</a>&gt;<br>
                        <b>Sent:</b> Wednesday, October 13, 2021 9:52:09
                        PM<br>
                        <b>To:</b> Lazar, Lijo &lt;<a href="mailto:Lijo.Lazar@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Lijo.Lazar@amd.com</a>&gt;;
                        <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>
                        &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                        <b>Cc:</b> Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Alexander.Deucher@amd.com</a>&gt;<br>
                        <b>Subject:</b> Re: [PATCH 0/5] 0 MHz is not a
                        valid current frequency</span> </p>
                    <div>
                      <p class="x_MsoNormal">&nbsp;</p>
                    </div>
                  </div>
                  <div>
                    <div>
                      <p class="x_MsoNormal" style="margin-bottom:12.0pt">On 2021-10-13
                        00:14, Lazar, Lijo wrote:<br>
                        &gt;<br>
                        &gt; On 10/13/2021 8:40 AM, Luben Tuikov wrote:<br>
                        &gt;&gt; Some ASIC support low-power
                        functionality for the whole ASIC or just<br>
                        &gt;&gt; an IP block. When in such low-power
                        mode, some sysfs interfaces would<br>
                        &gt;&gt; report a frequency of 0, e.g.,<br>
                        &gt;&gt;<br>
                        &gt;&gt; $cat
                        /sys/class/drm/card0/device/pp_dpm_sclk<br>
                        &gt;&gt; 0: 500Mhz<br>
                        &gt;&gt; 1: 0Mhz *<br>
                        &gt;&gt; 2: 2200Mhz<br>
                        &gt;&gt; $_<br>
                        &gt;&gt;<br>
                        &gt;&gt; An operating frequency of 0 MHz doesn't
                        make sense, and this interface<br>
                        &gt;&gt; is designed to report only operating
                        clock frequencies, i.e. non-zero,<br>
                        &gt;&gt; and possibly the current one.<br>
                        &gt;&gt;<br>
                        &gt;&gt; When in this low-power state, round to
                        the smallest<br>
                        &gt;&gt; operating frequency, for this
                        interface, as follows,<br>
                        &gt;&gt;<br>
                        &gt; Would rather avoid this -<br>
                        &gt;<br>
                        &gt; 1) It is manipulating FW reported value. If
                        at all there is an uncaught <br>
                        &gt; issue in FW reporting of frequency values,
                        that is masked here.<br>
                        &gt; 2) Otherwise, if 0MHz is described as GFX
                        power gated case, this <br>
                        &gt; provides a convenient interface to check if
                        GFX is power gated.<br>
                        &gt;<br>
                        &gt; If seeing a '0' is not pleasing, consider
                        changing to something like<br>
                        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;NA&quot; - not available (frequency
                        cannot be fetched at the moment).<br>
                        <br>
                        There's a ROCm tool which literally asserts if
                        the values are not ordered in increasing order.
                        Now since 0 &lt; 550, but 0 is listed as the
                        second entry, the tool simply asserts and
                        crashes.<br>
                        <br>
                        It is not clear what you'd rather see here:<br>
                        <br>
                        $cat /sys/class/drm/card0/device/pp_dpm_sclk<br>
                        0: 550Mhz<br>
                        1: N/A *<br>
                        2: 2200MHz<br>
                        $_<br>
                        <br>
                        Is this what you want to see? (That'll crash
                        other tools which expect %uMhz.)<br>
                        <br>
                        Or maybe just a list without default hint, i.e.
                        no asterisk?<br>
                        <br>
                        $cat /sys/class/drm/card0/device/pp_dpm_sclk<br>
                        0: 550Mhz<br>
                        1: 2200MHz<br>
                        $_<br>
                        <br>
                        What should the output be?<br>
                        <br>
                        We want to avoid showing 0, but still show
                        numbers.<br>
                        <br>
                        Regards,<br>
                        Luben<br>
                        <br>
                        &gt;<br>
                        &gt; Thanks,<br>
                        &gt; Lijo<br>
                        &gt;<br>
                        &gt;&gt; $cat
                        /sys/class/drm/card0/device/pp_dpm_sclk<br>
                        &gt;&gt; 0: 500Mhz *<br>
                        &gt;&gt; 1: 2200Mhz<br>
                        &gt;&gt; $_<br>
                        &gt;&gt;<br>
                        &gt;&gt; Luben Tuikov (5):<br>
                        &gt;&gt;&nbsp;&nbsp;&nbsp; drm/amd/pm: Slight function rename<br>
                        &gt;&gt;&nbsp;&nbsp;&nbsp; drm/amd/pm: Rename cur_value to
                        curr_value<br>
                        &gt;&gt;&nbsp;&nbsp;&nbsp; drm/amd/pm: Rename freq_values
                        --&gt; freq_value<br>
                        &gt;&gt;&nbsp;&nbsp;&nbsp; dpm/amd/pm: Sienna: 0 MHz is not a
                        current clock frequency<br>
                        &gt;&gt;&nbsp;&nbsp;&nbsp; dpm/amd/pm: Navi10: 0 MHz is not a
                        current clock frequency<br>
                        &gt;&gt;<br>
                        &gt;&gt;&nbsp;&nbsp;
                        .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp;&nbsp; |
                        60 +++++++++------<br>
                        &gt;&gt;&nbsp;&nbsp;
                        .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c&nbsp;&nbsp; |
                        73 ++++++++++++-------<br>
                        &gt;&gt;&nbsp;&nbsp; 2 files changed, 86 insertions(+), 47
                        deletions(-)<br>
                        &gt;&gt;</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>
