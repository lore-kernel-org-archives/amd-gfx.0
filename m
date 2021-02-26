Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2787DC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 10:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95C664EE2
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 10:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95C664EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E3B6EDB5;
	Fri, 26 Feb 2021 10:00:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E0596EDB5
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 10:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWXTSKzf5TxdtN3pSDvwYNk3Cx146SmL5u04OneTe1+/XTtFXvil0AUZL91BuBBsd5FaC+db1XiDUF8Ds97IrtUMnnkngutHbVUjRdFC5+7O2pY9RYHg+VtN2rx+7qD/nmpnQkslg+4dYpdubA6XJpdA/JLmB6X6CGT5zdiSLmaVuWkdDNtOUmxGLuO06wgYiqAtOKDwRBmoGQVvmQG+c++3PKnHbgsCvwcv57DWapsqgFBff5AT+WUntQmsUNxEfGwh8nJtol14omRK/9GgKuJzr/dNo4ZdkqLLIGULTyo+y5ydWTp5zbyJl7HzC/LLXBOh19e8SWQknt1FDepwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsSSm5GDzbYFjjCsevQw7PZcevoCZb6mYR/oRs+oFq8=;
 b=Nv92eFW5yHAk71pyrWRZeuBDAIlZ1jZjCEKEdQoR13su/AAH3+IstImfsEN+504hWg2iwmE5vz9pBOgXZE+vcoYZBBmJ/lz7BzmLyX0jdoQnB88sNIYQtaL8xuAdJgHjmWRyLtlauFUBNGBX6NGYoCSRMO2nI81UZaYwMaFTC+7k7idmUl1+7tNQot0+hVwki/a2a42izgsT3YXKMK3XiulsvnU+UvvNGWmTRG5/lfx7c0dprnjButQW8k38bqwBtvmKbg3nXytiJkhWgkl1lp+EA6jVdaX7ucgY+d+Euli0AgLHt7cd5TaKZav0Q8sWn0g32JshzhAMAKw0TIkSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsSSm5GDzbYFjjCsevQw7PZcevoCZb6mYR/oRs+oFq8=;
 b=OvlfYFfZnmQFw5l2BK1mQIq7NGBffWilUf1QXULTXeDRka9vCU0IoFYruvA3TsNCDJkQpKEjUFheauRwJztqC6jCmJep+3OoIhb/d5wNdMIuEkRFBahNTSnZbIV/FNvfB1mkz2/WNP0f1uT1FKrdxfm9AuHUXzgAAY5fVO+/TMo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4815.namprd12.prod.outlook.com (2603:10b6:208:1bf::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Fri, 26 Feb
 2021 10:00:05 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 10:00:04 +0000
Subject: Re: [bug] tab crash on media playback
To: Cory Bolar <cory.bolar@gmail.com>, amd-gfx@lists.freedesktop.org
References: <e281729c-d632-1cc2-a1c7-79b4d1cbdc66@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f4b795f8-9f79-a946-49dc-0aea27766bf6@amd.com>
Date: Fri, 26 Feb 2021 10:59:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <e281729c-d632-1cc2-a1c7-79b4d1cbdc66@gmail.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:6c1e:37ec:4f8:3a9e]
X-ClientProxiedBy: AM0PR03CA0033.eurprd03.prod.outlook.com
 (2603:10a6:208:14::46) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:6c1e:37ec:4f8:3a9e]
 (2a02:908:1252:fb60:6c1e:37ec:4f8:3a9e) by
 AM0PR03CA0033.eurprd03.prod.outlook.com (2603:10a6:208:14::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20 via Frontend Transport; Fri, 26 Feb 2021 10:00:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c8b9198b-73c0-4d72-2a10-08d8da3d496e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4815:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4815AB71625B613806975A56839D9@MN2PR12MB4815.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mY6IDZ3nLbEikg9DWBMLHSHYlEn4oBt33A9eqU63t6uj50/GDRs1yvaWsZ5aqyX9pwiJUABT4TkV9BdU45UIRPeD6Q6DkB6rbTppkbPcFMrGerw+dCm+vvoG60spUpcDx2cXhDpALGanZ9qqmbsRokCTItql+1zhZBg0mxUauYoe7Vu33/i6K8abplPBYDTdiJLpB91m9z5OVbVV/3yz97QcJVTrxJ1GxFXp8c9q/Sv0tk2gtaIVSF4ZMFA56pOlAZdq3vMroSMR0iNX1wk5wlZqCyqKKi5ix7Quo78rN1CoT4XQ5oy8DZIaMJ6qKAJjbk+GjMDDxpKYERze/CyThvLrGbK0ehZUN63G+4j45FK4jRzw7qBNr584TqrT0A0BsFmmHHmMv+mKTocpxlu8JRf/13GQl3yIbydDGDj/T5x7M52dyaCanccXmNPI4gYG7acRikXgPOUhC0JLutF4/EOvqDA9PwzLGwe5xCk/bIZYMeAFVYKLKTSwO5t+HigTC40wUCc2uyvbZ5WLzFmL25QgTIswZkHY2OgVAfrB+8sUObaGCaebdhMeFEPSbirJs7T5o6VkFrm1et4rQjf3jvrxSPuBZu1B59/2jb3iEsQ1P9OMfu/EbuX4EYfhreWfk9bWVUqqSZewtatJitJ0nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(66946007)(66476007)(66556008)(166002)(478600001)(186003)(83380400001)(16526019)(2906002)(6486002)(52116002)(33964004)(36756003)(8676002)(966005)(31686004)(6666004)(8936002)(66574015)(31696002)(5660300002)(2616005)(86362001)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dVZyWG0xVU9uTHJPWVF1aXpySENuaGl6QUlKK1ZFRUJYZVBrVW9MeFFDMVJX?=
 =?utf-8?B?ejB6M0pObHNON1FZTEdlVDJIam1pNEJOOXF4SjNVTXF4VmdXTitjaTcrNXll?=
 =?utf-8?B?V3dWaStva25MUjg2M20xVHdjS2VvT1NCYmNVRGhCcGdIdVdjNG9icWxXeVRa?=
 =?utf-8?B?NEd3QmdFbi9wTVd0VDF6TnRXRU4wKys4K2NuSjBjY0U5OTZUZDIvMnNUS1Rn?=
 =?utf-8?B?VmV5d1dNN0Y1UVptcW53VGVmWnFoS2tQQzBnanNvRk55bk1EbmhINTlWbnVP?=
 =?utf-8?B?ZXBzMGNFdmxhazVNbDhEbVFyQlAvalZScFMvaStjdmZ2bFA4OWtiZ0NlT1Av?=
 =?utf-8?B?WUw3OVJrUjBrRks0dUIxSlEvNDlBazUvemowaVp5ZFlqV1JKd0VDeFZVVnFL?=
 =?utf-8?B?VlBpeDdIVllEdzhlMUVjcHJoODR2MHFSd2dYM3dlT002VUd2eTRXdnlaUncw?=
 =?utf-8?B?ZVFrN3lyTmJIdXhGLzZxa1NsWnVBRWdOajdzL0YzMmt0bVFHNFFmUVJucGJS?=
 =?utf-8?B?eTlWdFY2QzJET1RUV0pnUUxONzhaMUlHaGd6NXF1Skg4VnNReXF0bGRnZTRx?=
 =?utf-8?B?OVBYajlFeldwTDNCbks4VmgzOTY4aUtvemJjQWg0Rmh5TGM0aGZDZDBjM1ZY?=
 =?utf-8?B?Tm1DY3NzLysvR042L0N3dUhOWm5qWEd4Z1I4c0RoUEFyYWJsNUdyYWpSdERI?=
 =?utf-8?B?dElwc3Znb3lxUmdzRVh2RkJOeUlxNUxzQU9BUFJEWWVvaVN3QVdYUFRpUyto?=
 =?utf-8?B?VjkzNW1ZVGNZWFNMYlROVlkwZElENUFSUnZoUS9uOU0ySVlCNjBUWkNhZVFE?=
 =?utf-8?B?VEJsblA5Y1V1MFF5L0wwdWF0MXdpV2FkTmxuS2p3aEpiWWJqNjR5c0t0N0hG?=
 =?utf-8?B?NGFYendiamZabzhSMEdIRHRPWlN5UlV2NjV6MDZVWnI5MHh5S0NPcjJNazJK?=
 =?utf-8?B?UFVZd2VId2Izako1emtMNnhVMFhkbkRPQWFUaFpUOWxITFZ3TERxK1lBWkti?=
 =?utf-8?B?WFBrd1dPTDBiL3FJNkIyL3lOV2tBRGlkQUpHQlVNL1VvUnVCR0lhbXZweXIv?=
 =?utf-8?B?UG81MGNtQ2ZhSU5mZmRDaTYvcG9lYmFjQnc0eDNIbmt3d3gxOUZRbjlGTGZ1?=
 =?utf-8?B?T0ZVWmVoL3dNWENtS013amlWNlpDakQ0M3hVUllDK2p3cXBWa3pUUGhXT3pY?=
 =?utf-8?B?b0tVNFF1a1ZKd3gyZDRnU3M3OEdxSjZZQVlFSmRaRDZ0OHNnc3Z5T3M4RFox?=
 =?utf-8?B?aVN4bzFGZi8rTWVZWGRaTVJ5S2lKdEQ3Nkl6cFdTbHFmZ3hpUkFOdEpEVTNB?=
 =?utf-8?B?MXJmVFpkTzJHcFhMaWJBSXJFSzYvRzVjcVV5bVFBcFpUaVhoR2tlbkc0UWg4?=
 =?utf-8?B?R0hXV2lVS0tlWGE0eXZHZ2dPR1FoN2RNZWoyL3c5YzhTa1VKSU1xbDNwbXRF?=
 =?utf-8?B?OGJhOTZScVVHM2VJczZqYXdCalJucmdaS3M5Slh4bzBMQldmZmtLbnowa3FR?=
 =?utf-8?B?eTdNWUtTajVzU1JnNHYxdVFXbTBkS3lWc0Q3VFVNcVlXVzErTEpRRGhsdE5n?=
 =?utf-8?B?L2ZtWS9tcHNZM1JCMy9pYW9kM052WnF5TDhXYmFPUk9Pc3hHVCtic2xQenlP?=
 =?utf-8?B?aHpjRUlsa0JhbXRUZjBGekdJTG41bnQrZ0lTa1BLR244b0ZRU1JHdVMvVG95?=
 =?utf-8?B?ckdtVzFYeVhTM0h5bWNJNW5tUzNNSEhRa1k4bURtVXB5YlJkay9yNGNyUXA2?=
 =?utf-8?B?bEpKcUVmbCtBT2FrVmNpUWk4UXhwR09ldVJGZG5XZjQ0cmJUZC9icjQ4UVVG?=
 =?utf-8?B?NVBUT04xajRDTHhYZ3V0cXp1SVJqS3NoVGt6bEJkWGk3bWFOQWtuNVB5Tys2?=
 =?utf-8?Q?Nnzr9z/LZxAKM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b9198b-73c0-4d72-2a10-08d8da3d496e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 10:00:04.8663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YXh5GEWuHTKOPzXzZz6pPN63GLlSauIpR1Ar6AgeO1mFjpXLNpeMYV13DLh29gE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4815
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
Content-Type: multipart/mixed; boundary="===============1114669684=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1114669684==
Content-Type: multipart/alternative;
 boundary="------------8B405F3FF62F1A82CEB16483"
Content-Language: en-US

--------------8B405F3FF62F1A82CEB16483
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Cory,

I'm the author of the patch you bisected, but that looks like a bit 
strange bisect result.

The patch in question shouldn't have an functional change, it just 
restructures the code.

Can I send you a debugging patch which prints a few lines into dmesg 
when problems happen?

Thanks in advance,
Christian.

Am 26.02.21 um 07:47 schrieb Cory Bolar:
> Hello,
>
> When upgrading the kernel from 5.10 to 5.11 my Chromium browser's tab 
> crashes
> when playing video files, for example, any youtube video.  Other media 
> related
> programs and browsers appear unaffected and I have tried multiple 
> versions of
> Chromium but this has not resolved the issue.
>
> I bisected the mainline kernel from tags v5.10 to v5.11 and found commit
> d3ef581afa5e6a65cc3a40de2e62901f17b8cebc to be the first commit to 
> cause this
> problem.
>
> A few other details:
>
> GPU: RX580
> Window Manager: Sway (Wayland)
> Chromium flags: --enable-features=UseOzonePlatform 
> --ozone-platform=wayland
> --enable-logging=stderr --v=1
>
> Without these specific chromium flags media playback works as expected 
> but I
> lose native wayland integration that has been working for some time now.
>
> There are no logs in dmesg during the tab crash but I have attached 
> the crash
> dump and relevant log sections from chromium, although I understand if 
> they are
> not useful to you.  I have not yet reported this bug to chrome as I 
> was able to
> reproduce/resolve it reliably with kernel version changes but not with 
> chromium
> changes.
>
> Please let me know if there is any other information or tests I can 
> perform to
> assist.
>
> Thanks,
>
> Cory
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------8B405F3FF62F1A82CEB16483
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Cory,<br>
    <br>
    I'm the author of the patch you bisected, but that looks like a bit
    strange bisect result.<br>
    <br>
    The patch in question shouldn't have an functional change, it just
    restructures the code.<br>
    <br>
    Can I send you a debugging patch which prints a few lines into dmesg
    when problems happen?<br>
    <br>
    Thanks in advance,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 26.02.21 um 07:47 schrieb Cory
      Bolar:<br>
    </div>
    <blockquote type="cite" cite="mid:e281729c-d632-1cc2-a1c7-79b4d1cbdc66@gmail.com">Hello,
      <br>
      <br>
      When upgrading the kernel from 5.10 to 5.11 my Chromium browser's
      tab crashes
      <br>
      when playing video files, for example, any youtube video.&nbsp; Other
      media related
      <br>
      programs and browsers appear unaffected and I have tried multiple
      versions of
      <br>
      Chromium but this has not resolved the issue.
      <br>
      <br>
      I bisected the mainline kernel from tags v5.10 to v5.11 and found
      commit
      <br>
      d3ef581afa5e6a65cc3a40de2e62901f17b8cebc to be the first commit to
      cause this
      <br>
      problem.
      <br>
      <br>
      A few other details:
      <br>
      <br>
      GPU: RX580
      <br>
      Window Manager: Sway (Wayland)
      <br>
      Chromium flags: --enable-features=UseOzonePlatform
      --ozone-platform=wayland
      <br>
      --enable-logging=stderr --v=1
      <br>
      <br>
      Without these specific chromium flags media playback works as
      expected but I
      <br>
      lose native wayland integration that has been working for some
      time now.
      <br>
      <br>
      There are no logs in dmesg during the tab crash but I have
      attached the crash
      <br>
      dump and relevant log sections from chromium, although I
      understand if they are
      <br>
      not useful to you.&nbsp; I have not yet reported this bug to chrome as
      I was able to
      <br>
      reproduce/resolve it reliably with kernel version changes but not
      with chromium
      <br>
      changes.
      <br>
      <br>
      Please let me know if there is any other information or tests I
      can perform to
      <br>
      assist.
      <br>
      <br>
      Thanks,
      <br>
      <br>
      Cory
      <br>
      <br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------8B405F3FF62F1A82CEB16483--

--===============1114669684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1114669684==--
