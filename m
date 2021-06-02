Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA0EC47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 13:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B2361168
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 13:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B2361168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD5F66E507;
	Wed,  2 Jun 2021 13:29:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA58E6E507
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 13:29:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/4z1zYLo0GTSpvwb9TX7KYdx5tiaQx8Jw7jOyndRZ2TR+t9uu3VjSohfBJ+o/mLC3s+ICYQw6Ld5exFuzH1K27huplQNRwhhfLXYI3RTWehn1XL/lDGmuGZcvhFHuCEYwkk0mkdq9Jeiadk8ZgKrEdOMZ2LSu2dhEBVQipozsmWwxw+6AEM4NpZzvXJDA0cQ+HUkYFqtvmLMwm0v0tM8Zsqg47y2kr6lub824Wm4MmhHmDXiR0IMqwl0Ugx+NIWtMXh5tZYletLHho80NpA2CTxTCbBkbWedJnkFzAiF81OoYZ8VmCQBWPbEFZeiQqN3SQCSdB9bqef3RyR8uredQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cMV6UQUrIZC7ObVxCEBNeqSyKzqTi9bhfsIgYjYebo=;
 b=PgiTd8qKwEnqLXuK5ZHVBhwyS66ufUygXEaR97zRJWNIiFS/2i8JZxGeWZw+mrU7dB8wPjO6nuX7DRA2pcsbBu6mYhfQozFp1IFqsMFwGquofTxO/MNKXhcUg2YKgx/1p6gQbm495myma0Oa9pBpEuujDVzBgr+s9ktfR8Xqn4delqQE+8YavYCPf0RIooeqpdWV4B8wSGXw3IIKJg/gjHj/U4Nsfu16Jyr+3GXRUMlY7VbfTirh8im7hNevnBK2X3KdZumJ2bJtu2u4JftoWmR8U2eA1/z7hoqmBeTk/tfhYDtcn0rFSscGy9Wmlrsz7RnfkuNohcyqcrDRQInDLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cMV6UQUrIZC7ObVxCEBNeqSyKzqTi9bhfsIgYjYebo=;
 b=APzBuahJx7wcwX5wWIWegQ3cd2d3GUduIAroFjd8obYQZChIRLNsvyYQj5z+B+xI3/5Xt8TSn0pR7ovnDNe8D59uEUdQLT815HBho3yMC4EWn295HitcEt2qJ/479xHtotUvCnAZWvn93RRS65yXML1H/CiOeaIZ+EAUPH3dBLg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM6PR12MB5567.namprd12.prod.outlook.com (2603:10b6:5:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 13:29:03 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::407d:38a8:e51a:8145]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::407d:38a8:e51a:8145%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 13:29:03 +0000
Subject: Re: [PATCH 1/4] drm/amdkfd: Add flush-type parameter to kfd_flush_tlb
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20210601225907.749049-1-jinhuieric.huang@amd.com>
 <1b688ac5-e4cd-5c8b-7972-1f120186b502@gmail.com>
From: philip yang <yangp@amd.com>
Message-ID: <96d3eab3-ec3e-534b-28ae-17710b92fb80@amd.com>
Date: Wed, 2 Jun 2021 09:29:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <1b688ac5-e4cd-5c8b-7972-1f120186b502@gmail.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::16) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YT1PR01CA0077.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.27 via Frontend Transport; Wed, 2 Jun 2021 13:29:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a0dfc48-12a5-4f64-4074-08d925ca631f
X-MS-TrafficTypeDiagnostic: DM6PR12MB5567:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB55672354EA74388A4F5D2AC2E63D9@DM6PR12MB5567.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sx4zugKPPfp/XEnqie8UtHuH8Pvs12PHKUJoKDB5+IHiXPKdyKb3RiEAT99ZlN+8CHmwYB5aNKy9Kl+i0emTdkJIijrFKrWaV76CafVejjsHIttAHwEYtUPmfDga3cGRcemE0cgUPnhc5sV4ZVojPWSAMgzB3NnxsGASfuxVCnAK+izzFdOsQuqFtn6Zo5gHX3lJwEIAgRKVnM8wejs4KPuECwMKouEXSInF8Cpf6+6s4wbFD/EodR+AbksrRlQBQmnSwVY1GzRoQmzR3brfilCCJJmWbp5Xs9ilFLVdygn1EkRZ+Myyr/4cxZRZ8E3eaTWTgxWFtUm6efX2WBtnPxWQP1g/dj4+ZqoTXiX8bucXDYZenbIwqSJByzAClEGwBbrAxXrPAbF+6zuKawUfPhjs7KfXXOy4Bp8849Fwnhyq/eH3xcujaweb46N5b76aFl+/D5VOhRc0shd4o4slbhMWSodFqXvR69U/mbb98IuZIPh2hk8sHuG83jprz0+ap/qpIhG7g181ijoWI7Q09+Bx9B9W4cw7RyWnvIjyJyW6FhhHWb9bQWGlaZN3cgs/YsdAcZTNJwaG8rYwed2QxBcZWOIJP2BtaqTDo1AfHlf/1yxO6WiR3C68P7gI3/u4JCFQCJ4olzQEYko1Hqx3x0Lef1/KsIf6kIuc0xw7pBQV8LkJkuRv0MqBSkm8b7ha
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(2616005)(956004)(110136005)(16576012)(83380400001)(31696002)(316002)(38100700002)(6486002)(8676002)(66574015)(36756003)(186003)(478600001)(16526019)(2906002)(6636002)(31686004)(26005)(66946007)(66556008)(66476007)(53546011)(5660300002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SklrQjQyOUdXNzFXdTkwT1VJZ1NyY2xMVk41UW9IUnE5M3lDOWZIYnNucmJK?=
 =?utf-8?B?bUU3b29JbG5pb29qOThmc3VHUTVXVnNDMFd4TG1TN2s2RTQvWUV1TFVUdTZn?=
 =?utf-8?B?cHBEQkIzaEM1OUIvVzY3NHhsQ1ZBaTZpV1BjTkIyYWo1V09zNjBoSUxCc0Ux?=
 =?utf-8?B?WFlGRzdOOVcrdDVyYkFHTzFnOUNMcDBDcjRVMmRiMS9MQ3VPeWRZYUQxcUZ6?=
 =?utf-8?B?clVGTXB6RTFjLzYwbllOM2RSOUFYMG5zL2kyK1IrME8rQXB3bE93YVFHem8x?=
 =?utf-8?B?SEdoNzdZdzh3dDlVWEFWQisxVGh4bmhteUdTR2NkN2hOMDB5OU81VE1VVUlM?=
 =?utf-8?B?c0w5NDJ1bTF4UHNXQzYvVFBWZTVoOGFkWVpwQXJTUkxLc1N2Q0VQQlorNVJs?=
 =?utf-8?B?c2JQVytzS0c1NS9DYVM0d1lrNnVsQWtFcGdPcERhQldDTVZ0akhCd1g4Vy9J?=
 =?utf-8?B?Ymo1bW1iMUt1bWFhNm4xTDlsSjlPS2pwM2dPYmpWYkY3dUpqMkhUNHBscFJI?=
 =?utf-8?B?d3d5M0tOaEFsZTdHZDJwTktiSzhaSFVYZDZ5WmdSSTY2V1loaXVHeGVCcGNO?=
 =?utf-8?B?d3Bpdm9obkRRQXA2YlhaVXNlaWlDTkxzcWlDMVErdmhXWEpOcnVrUlpEM1hr?=
 =?utf-8?B?VEsrWmtTRWtrNmlJLzVteEhvcDVtdTU0THlqL1lMWjBuN0F1S1dvQzQvejRv?=
 =?utf-8?B?bGdLOFptOWdPeEJBWWMzb0FhRWttNEJUVmdwSStvbThaUkt2Z1lycFZLTy9S?=
 =?utf-8?B?cDNsZ0o4VFR6SUVjN05MZDF5MWJDVVdHV2ZreUQyTnNWaDFLR3ZXZFpaRFJq?=
 =?utf-8?B?K1RSL1g0VmRKUVdXZ0hUbkdZeDhkbWZ6cDh0Rkd5eEFob3h4WVdvMW5Id1J2?=
 =?utf-8?B?QWZwWUgrRUFGOFFjK2tZWnlQalA2Vi96ckwxOE0vMEhTaHk2NWdNTlVQYy95?=
 =?utf-8?B?Q093RFhvaHFKNzc3L1cyVmdEcmxvS1FLOVVlbEV3djhGZHc3TVlUVlRBSkxG?=
 =?utf-8?B?NzgxUEJhNFdveHVpZGlVSC9ORTM3S2U5UVpqOHcrcUlvcitKV1dqbW5DVkw0?=
 =?utf-8?B?OC9ab3EwUStXaTBlTW9nRFFNQzgvQ3JQTDNrNTF3a2ltMzJUMHZvS3hadXlJ?=
 =?utf-8?B?NzdPR2pQMHFzbGxoZDh5VHlRRFNmY3hGSktyUnRnc01RT3RxUkNpVVk2ai9p?=
 =?utf-8?B?L0szeEk1T3ZiSDBKT2xqOFB0RjVwKzFGMGtWdExZaUZEcXJudXpRV1laczBt?=
 =?utf-8?B?Z2g2cExMY214ZGpoVVcxVkFDcmF4VjBVLyt1dHIzdUliWTNWdFpIVXJQSHNY?=
 =?utf-8?B?dlhQaXM2aEI5SVpRYW9GZzduMkxIVGRZOG45dzgwclRNck5JQmYzWStPQ2NC?=
 =?utf-8?B?TnpaRFJDZWgrdDJ6Nmk5WmwyN01JZlJqU1lObS90VGJIUG94Y1pqMllxSWNY?=
 =?utf-8?B?NllxTDV6RDMzbEd3QlE5QmljMmY0Z0hqNFZNSExNM1BUc1Y5Q2UzWUhzUEtj?=
 =?utf-8?B?dGJZNktSQWJRSGFwcmtjSG9VSXFxaFI1dHBLeUxkajlXL3p3N2pWMFBYZDRU?=
 =?utf-8?B?dUxxN08zM1A1UXdEWmQxM3hJUStwc1REb2lVNHRrazBna3hGSUVZZFFLQ2w2?=
 =?utf-8?B?bkIrZkNXOGxtbWRBenZUT2VKTlpOV3puMFFBaFp3TkI3N1B1ZE5KYjBCLy9P?=
 =?utf-8?B?Wjg0SzNGalBIZXBlMy9ROUdjSGlhVCtpUWZZZEFiNnhlYTl1L0k4RHEyM2Zm?=
 =?utf-8?Q?1Y15qlulu77pzg4gj667NvrOlfPEy0MF47tJTsV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0dfc48-12a5-4f64-4074-08d925ca631f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 13:29:02.9057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jsw7CNKOfL9VcaM9PkLyTemcyrNEIQe4Xy2KnOgAnAXz4Cjhp1DnFxLTORVUCg11
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5567
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
Content-Type: multipart/mixed; boundary="===============0898906200=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0898906200==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-06-02 2:53 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1b688ac5-e4cd-5c8b-7972-1f120186b502@gmail.com">Mostly a
      question for Felix and Philip:
      <br>
      <br>
      I've been thinking for a bit about how that case happens in the
      first place?
      <br>
      <br>
      I mean if we have a PDE which points to PTEs and then switch that
      into a 2MiB PTE then why wasn't that range invalidated before?
      <br>
      <br>
      In other words when the PDE points to the PTEs we should have had
      an unmap operation on that range before which should have
      invalidated the TLB.
      <br>
    </blockquote>
    <p>Because one cache line has 8 PDE0, after unmap flush tlb, access
      address on same PDE0 cache line will load PDE0 back into tlb. For
      example:</p>
    <p>1. map and access 0x7ffff6210000, unmap it, tlb flush<br>
    </p>
    <p>2. map and access 0x7ffff6400000, PDE0 for 0x7ffff6200000 into
      tlb, which is P=0, V=1</p>
    <p>3. map 0x7ffff6200000 update page table, access has vm fault
      because tlb has PDE0 P=0,V=1, to recover this fault, map need
      update page table and flush tlb.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <div>
      <div style="box-sizing: border-box; font-family: &quot;Segoe
        UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe
        UI Emoji&quot;, sans-serif; font-size: 14px; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: start; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;">
        <div data-tid="messageBodyContainer">
        </div>
      </div>
    </div>
    <blockquote type="cite" cite="mid:1b688ac5-e4cd-5c8b-7972-1f120186b502@gmail.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      Am 02.06.21 um 00:59 schrieb Eric Huang:
      <br>
      <blockquote type="cite">It is to provide more tlb flush types
        opotion for different
        <br>
        case scenario.
        <br>
        <br>
        Signed-off-by: Eric Huang <a class="moz-txt-link-rfc2396E" href="mailto:jinhuieric.huang@amd.com">&lt;jinhuieric.huang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6
        +++---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4 ++--
        <br>
        &nbsp; 4 files changed, 7 insertions(+), 7 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        index 960913a35ee4..4da8aff3df27 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        @@ -1666,7 +1666,7 @@ static int
        kfd_ioctl_map_memory_to_gpu(struct file *filep,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON_ONCE(!peer_pdd))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_read_lock(peer-&gt;ddev, true)) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(peer_pdd);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_read_unlock(peer-&gt;ddev);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        diff --git
        a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        <br>
        index 2bd621eee4e0..904b8178c1d7 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        <br>
        @@ -278,7 +278,7 @@ static int allocate_vmid(struct
        device_queue_manager *dqm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;vmid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;page_table_base);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* invalidate the VM context after pasid and vmid mapping
        is set up */
        <br>
        -&nbsp;&nbsp;&nbsp; kfd_flush_tlb(qpd_to_pdd(qpd));
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dqm-&gt;dev-&gt;kfd2kgd-&gt;set_scratch_backing_va)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        dqm-&gt;dev-&gt;kfd2kgd-&gt;set_scratch_backing_va(dqm-&gt;dev-&gt;kgd,
        <br>
        @@ -314,7 +314,7 @@ static void deallocate_vmid(struct
        device_queue_manager *dqm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flush_texture_cache_nocpsch(q-&gt;device, qpd))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to flush TC\n&quot;);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; kfd_flush_tlb(qpd_to_pdd(qpd));
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Release the vmid mapping */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_pasid_vmid_mapping(dqm, 0, qpd-&gt;vmid);
        <br>
        @@ -885,7 +885,7 @@ static int
        restore_process_queues_nocpsch(struct device_queue_manager *dqm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;dev-&gt;kgd,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;vmid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;page_table_base);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(pdd);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Take a safe reference to the mm_struct, which may
        otherwise
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        index ecdd5e782b81..edce3ecf207d 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        @@ -1338,7 +1338,7 @@ void kfd_signal_reset_event(struct kfd_dev
        *dev);
        <br>
        &nbsp; &nbsp; void kfd_signal_poison_consumed_event(struct kfd_dev *dev,
        u32 pasid);
        <br>
        &nbsp; -void kfd_flush_tlb(struct kfd_process_device *pdd);
        <br>
        +void kfd_flush_tlb(struct kfd_process_device *pdd, enum
        TLB_FLUSH_TYPE type);
        <br>
        &nbsp; &nbsp; int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct
        kfd_process *p);
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        index 3995002c582b..72741f6579d3 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        @@ -2159,7 +2159,7 @@ int kfd_reserved_mem_mmap(struct kfd_dev
        *dev, struct kfd_process *process,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_CWSR_TBA_TMA_SIZE,
        vma-&gt;vm_page_prot);
        <br>
        &nbsp; }
        <br>
        &nbsp; -void kfd_flush_tlb(struct kfd_process_device *pdd)
        <br>
        +void kfd_flush_tlb(struct kfd_process_device *pdd, enum
        TLB_FLUSH_TYPE type)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev = pdd-&gt;dev;
        <br>
        &nbsp; @@ -2172,7 +2172,7 @@ void kfd_flush_tlb(struct
        kfd_process_device *pdd)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;qpd.vmid);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_flush_gpu_tlb_pasid(dev-&gt;kgd,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;process-&gt;pasid,
        TLB_FLUSH_LEGACY);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;process-&gt;pasid, type);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; }
        <br>
        &nbsp; </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--===============0898906200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0898906200==--
