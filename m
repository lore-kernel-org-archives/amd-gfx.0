Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_ONLY,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0206EC4338F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 15:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A189B60F0F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 15:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A189B60F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 022106E03B;
	Wed,  4 Aug 2021 15:01:55 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFBF66E03B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 15:01:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMMynHZz2OzQoy5Hw9X8q1EuLb2oOrMywJ8p+M/hFD3l31//Ejsn+SpZW986dTA0XdRTHHhU/gR+K3PmkzxXQTS5ZNuaoyzM7KBREbj1fsKGap2gXs0Le+NkBGnk0SMXGWaQzCcs6FgvgBvZ2loy93SfgFTt2YhP30iAIiO0SpT1sBIaTl919PiwGeYsYOPO+8mzFNyOHyQuPacwL2cn8bR/zz/neklVWb+fmvRxcvkKMp2IuwGFYGspRyamufh5Xi4uZjCfts38VpF8zfAR2QQbNaCncbnNZI/JDvZIy4KjEZ78eXfHK2lkCyTeGS4aoSqaRqWvfc4bCMUBHAv+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6GcfFx/lGMRQ9pTgEs+GHCvVpJ8ETaGUhAxLOeZwpY=;
 b=EDRR0gdMrdkNIhr9d28rzDuMuyvAm/AwgVAL/xgmSXx43NneWfyBONPyYInfXaWiefI73vjp1dZizxwYsAcYo996oJg6eNqSBsY52Jhh8EdV87v2GU+RJL/AKJfgWU5xFUxl3bj/ReTc/QxPlS25kaXvc//17VS65ZeTcdJV85XNKyZuBHpXUqcPJTriqQlBDRTVU/jkCqK9sNdbWoyxvbdT1Bn/Xc9ve6fxPApKZfguz7TUAYx5+gWbL9nucHuZkSuAKBjchF4KYZvO9YsJ+1eyrv0E0JEOkG7bo7X7bsOjNTXgalRUa9uy52aVCoaFJ7lrn269ODXTmCUrlbJNQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6GcfFx/lGMRQ9pTgEs+GHCvVpJ8ETaGUhAxLOeZwpY=;
 b=nHLW7I/7Xt2tkvLzC1PqhOYGrKenpgQB+gbqxQwwPnEfEZ2J3luhKvdcbDJnRyVzhNT29lygRx68aV+AY80MBdAolsYmWQaz1mwa5i2BRi/eacVfDV1p5P9ZK3XvhJDFUCdyyroYsue5RJmS+mojyUaW31STV8bML7vyijCps90=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Wed, 4 Aug
 2021 15:01:50 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5987:7323:7c90:a427]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5987:7323:7c90:a427%9]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 15:01:50 +0000
Subject: Re: [PATCH v2] drm/amdgpu: fix fdinfo race with process exit
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210730021321.7953-1-Philip.Yang@amd.com>
 <00330732-4232-3d3e-e271-47df226514ad@amd.com>
 <c24b471f-6b4b-8301-b7d6-bba69f6467ab@gmail.com>
From: philip yang <yangp@amd.com>
Message-ID: <30fa53ed-f9ed-e85d-aac5-c225547e5655@amd.com>
Date: Wed, 4 Aug 2021 11:01:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <c24b471f-6b4b-8301-b7d6-bba69f6467ab@gmail.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::22) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YT1PR01CA0053.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 15:01:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10c63bff-a678-4964-67c0-08d95758c9fc
X-MS-TrafficTypeDiagnostic: DM4PR12MB5357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53574F0E53E0258023DEB65EE6F19@DM4PR12MB5357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:130;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y8pVYlrgnX3QglR50A91LdNrDs7/zWFJm66frASeBr7QbHgU8+KX8+nqsJl8buz9xf4e7Vo+E2UbsLEwfQ0TKB/fh4J2IoaXzhSSnt9RUBKCYMA1Llsd61akTK8Ydiqli1KPvdsgIFPsAKOK+jTZ90HqFu1C6hxA8tuD4h+NRxCw92EQrdUZu2U+zGmNESWDF3cOs6f0u0tcPeV4d0HBTJ909DJ55kSxK9c8c/y2Zj0tiQI4O/rD4VvFOkSOAoCGg71psQOLQhRETn7sXf/vRyL2FwyhjsF26r4bWhqS9jrB3uBiTe602eHTJ1CvxgmBPthH0IrEIj5q8VONk/IatX5p+ViG/wt0N9dZxR3r8DY5gXEVPPv6hVRUHaWZ0mYO5ZUvEPjFH5arkIuJiA5yJu8V8AOrG1emD6mQ/JV/hT3RS2G6ZXArLjTCMII/WCxr9KOKnhKSsqTtUGfX5wB8pVYEvpfpW2P94/fgq7HFERek2IgPWuZJxUAMZWgXMWeKB8UPDs+vqV3PB4kCnDo2Tq5/k8u+tdtwSRoWG2/7EfNyObHo64CmlcWvZtSbxIDjITGOnt7Xt1ESvep77OsaFI47rNHtZnlRdPXFoQMJ8+P8WQmBEOSFedyYkGM6fDiRpr2/TkV2xKlASlTKp1s3HgKIHalsMNv0P7qx2N/b0/YGWBePU8v5Djk2iR3MUP8EhT9buPjAZBevKFAw8mnGKdMXxgAo9kx6IIKaetCn7J8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(6486002)(26005)(53546011)(8676002)(8936002)(2906002)(16576012)(31696002)(186003)(316002)(110136005)(66946007)(83380400001)(38100700002)(66476007)(66556008)(66574015)(956004)(2616005)(36756003)(31686004)(5660300002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzEvUXg4UkJzQXgwVSszZ0ZaTFBuMEhtcFhyRWJCYVpUc2ZLVTlYTFR5WkFk?=
 =?utf-8?B?UHRmZXEwSHRWMm15QUFYTXpvU0ZHRXJLSTYzQ004d054L0dYNUpxakdnR3lN?=
 =?utf-8?B?NU9nUnFGWjllZnNsNEJZaFplYUdqTUJKeXJ2ZEJCYmNhRHZyWm9UWDNsQXNX?=
 =?utf-8?B?bUpXVU05NkZ2WEl4OHNDd2lPc0NmcXMrWVZjQmZZZEtrZmtFMG92bXZKdnRH?=
 =?utf-8?B?ak5sb1MxQUhwWWZ1YjY3Zm5MUzg3ZTArc2R1S09hM3kxZUJYcit0Z2kzUHBa?=
 =?utf-8?B?RW01bTB0dWVGK2RLdDZLSlduUSsrc3NnWWd1b2VFK0lMODdUZHlNS2ZFUUNo?=
 =?utf-8?B?UmdxL2NTbEhiREF1TnVETkZtWkFDc1cxMGxZbnBxRkt3UVBzbjBaZFVhKzdY?=
 =?utf-8?B?U0ZzOStjWUZnemR0WC83S3ZBYVprNDJieDNXb04yOS9MaXg0THFFVU5WQ1R5?=
 =?utf-8?B?UXlRSlBMbEJidlRMczdITWhaNFN5VXplWU15em9ZQjdBRVAyTjk4U28rU3g0?=
 =?utf-8?B?aXhjUkxkaG5xUXB0aG1Xc2FlZFNLSGJ4bk1sdTV4N2hCSkhlbjFzVno2TThu?=
 =?utf-8?B?NHpsNnZobnlYYTVqWEJBQjdyK0tRQmNqT1psY0ptNUZ3RTVzWkIvTkpCbFF3?=
 =?utf-8?B?MTRLU1p3anpYalFtL0VOZnk1c3JKOXI3R2RNUlF0NUpEUFcxdmttMXAwUGlB?=
 =?utf-8?B?Q1lRQjlPWFpuSWZzUTdaZVNDZkZHZWoxcTd4bUxybEhwYXdOVlYwbGxEZkRG?=
 =?utf-8?B?MU5xWmpyR2tJNFAyNlNEY2xlOUxLMkdiakFSakJNQ3hBc0F4OFJURGloVXN1?=
 =?utf-8?B?aTczUlJ5ck5YRVQrWUI5NUtLRTdoVnhuTllRTVp5bmlNZjJySjZlVW1zZ3dR?=
 =?utf-8?B?NmdNZElWb2pDSXEzdlFQYXdrdjUxanQ0aTNBVDk1djZIdmFqNGZUamh5Wk11?=
 =?utf-8?B?Qkt3cmNOWERxSHcySzhIOXFXU3EvZUx1d0FnQlpYNDd4cGgvb1oxN1YrQ2pH?=
 =?utf-8?B?YmRaM2tJc1dhcnBidjVVNDB4L2dnVFZUZVkwUkp4a29hb3FDZXhHWHpIbzM1?=
 =?utf-8?B?Z2V1dy9qY1RqK0tEZHpMYlNRZHh5SEZkcENJUE8yc0EyUzRNV0RRTGFVRTFW?=
 =?utf-8?B?SUFYOTV4Nzg4Q2lsSm9ZUDFaUDJ1VUk1NUovV2E2azdtVGdZYkZTU1VidzZR?=
 =?utf-8?B?dVRRcTBaNXZRWEZyZ003RTVIcitLYWcyWWhKY0FLTmNETEZQYnVzb0E0bkNr?=
 =?utf-8?B?c1pHbExGU1p2alY3TTJzb3RHU21XRjJpWHZXTFdDWE5taVhMMXpWVW51Nit2?=
 =?utf-8?B?Ui9WcVJ0OXNkcUhLSk5lSFF3TFlLRmptTytndGtwR09TUExXajBVaW83RTUw?=
 =?utf-8?B?TWFYa2x4UXRCOUU1UVQ5NzQ2d3JaR2ZXZUZOdnVOblhESU9CTmZiZ2VzOC9i?=
 =?utf-8?B?Zmovc3ZNc2R6NlpZUXFsMVpLeW14RVdUSmdGR2xkbTFuUlI4RXFTT0ZPMFE5?=
 =?utf-8?B?KzIxUWFya1A0MlQ0TzRYSlp4cnRwclZ0bEU1Q1pkY2VWcGZZbzcxSTFUQ2xN?=
 =?utf-8?B?ZDJ0WjJYUkFlaDkvUEVEelkweVVmZk14Q3lxVnhrRnNCQXlGeDE5UFFucXdO?=
 =?utf-8?B?ZUoxSlZWWHFWNjc4UnNRaXQ5UStXOWhWeUM4WVdyUjFWNUJmVjVKcFkxRGIw?=
 =?utf-8?B?a1ZoUWN4YXJzY3BQdCs3eE9yMTJEaUJpeVNjWm9LZkJiZm9xWkMzclpTTStZ?=
 =?utf-8?Q?VI21o67iefBOzKbUPZQYKTca8niHpxXopjiOfvt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c63bff-a678-4964-67c0-08d95758c9fc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 15:01:50.8201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXxN10MXXSoNX4WbxE+M2Tp7APwvw+Tt5ed/kpt6C98j9qgqPrJP2YuimVmrhu+E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
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
    <div class="moz-cite-prefix">On 2021-08-04 5:04 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:c24b471f-6b4b-8301-b7d6-bba69f6467ab@gmail.com">Sorry
      I'm on vacation and can't reply immediately.
      <br>
      <br>
      This is the wrong approach. The fdinfo should have grabbed a
      reference to the fd it prints the info for.
      <br>
      <br>
      So we should never race here. Can you double check how this
      happens?
      <br>
    </blockquote>
    <p>This backtrace happened once, from
      /var/crash/..$date../vmcode-dmesg.log on the server machine, I can
      not repro the issue, grep app folder, there are python scripts
      accessing /proc/pid/node_id/fdinfo. This happened after app crash
      segmentation fault killed.<br>
    </p>
    <p>fdinfo grab fpriv reference, but not fpriv-&gt;vm.root.bo
      reference, I think this is needed, otherwise
      amdgpu_bo_reserve(fpriv-&gt;vm.root.bo) may deference NULL
      pointer.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:c24b471f-6b4b-8301-b7d6-bba69f6467ab@gmail.com">Thanks,
      <br>
      Christian.
      <br>
      <br>
      Am 03.08.21 um 16:06 schrieb philip yang:
      <br>
      <blockquote type="cite">
        <br>
        ping?
        <br>
        <br>
        On 2021-07-29 10:13 p.m., Philip Yang wrote:
        <br>
        <blockquote type="cite">Get process vm root BO ref in case
          process is exiting and root BO is
          <br>
          freed, to avoid NULL pointer dereference backtrace:
          <br>
          <br>
          BUG: unable to handle kernel NULL pointer dereference at
          <br>
          0000000000000000
          <br>
          Call Trace:
          <br>
          amdgpu_show_fdinfo+0xfe/0x2a0 [amdgpu]
          <br>
          seq_show+0x12c/0x180
          <br>
          seq_read+0x153/0x410
          <br>
          vfs_read+0x91/0x140[ 3427.206183]&nbsp; ksys_read+0x4f/0xb0
          <br>
          do_syscall_64+0x5b/0x1a0
          <br>
          entry_SYSCALL_64_after_hwframe+0x65/0xca
          <br>
          <br>
          v2: rebase to staging
          <br>
          <br>
          Signed-off-by: Philip Yang<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
          <br>
          ---
          <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 11 +++++++++--
          <br>
          &nbsp; 1 file changed, 9 insertions(+), 2 deletions(-)
          <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
          <br>
          index d94c5419ec25..5a6857c44bb6 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
          <br>
          @@ -59,6 +59,7 @@ void amdgpu_show_fdinfo(struct seq_file *m,
          struct file *f)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_file *file = f-&gt;private_data;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
          drm_to_adev(file-&gt;minor-&gt;dev);
          <br>
          +&nbsp;&nbsp;&nbsp; struct amdgpu_bo *root;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = amdgpu_file_to_fpriv(f, &amp;fpriv);
          <br>
          @@ -69,13 +70,19 @@ void amdgpu_show_fdinfo(struct seq_file
          *m, struct file *f)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev = PCI_SLOT(adev-&gt;pdev-&gt;devfn);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fn = PCI_FUNC(adev-&gt;pdev-&gt;devfn);
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; ret = amdgpu_bo_reserve(fpriv-&gt;vm.root.bo, false);
          <br>
          +&nbsp;&nbsp;&nbsp; root = amdgpu_bo_ref(fpriv-&gt;vm.root.bo);
          <br>
          +&nbsp;&nbsp;&nbsp; if (!root)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp; ret = amdgpu_bo_reserve(root, false);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Fail to reserve bo\n&quot;);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_get_memory(&amp;fpriv-&gt;vm, &amp;vram_mem,
          &amp;gtt_mem, &amp;cpu_mem);
          <br>
          -&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(fpriv-&gt;vm.root.bo);
          <br>
          +&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(root);
          <br>
          +&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;root);
          <br>
          +
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n&quot;,
          domain, bus,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev, fn, fpriv-&gt;vm.pasid);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;vram mem:\t%llu kB\n&quot;, vram_mem/1024UL);
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
