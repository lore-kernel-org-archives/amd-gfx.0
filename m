Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A34C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 14:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC16C60FDB
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 14:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC16C60FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFE76EDD7;
	Wed, 19 May 2021 14:47:46 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A001D6EDD7
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 14:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9ae2xnGAeNVpDkMcY+xVonxnHQOHvaWoRmJuhIARfzBWjCVjvpVOnPBy5bBP/TAK29ocXaIZ8vOd1j3Ej+kQdvZV1dv55ULT5dw8pqz0zSEP87bgwQD4+1xxiHopnDnP2SoXlRlMLLGvM9lFGXfv5KzOdOz6aNdWxDiBbpvj3EAg2IdkLA+95UahI3lJWdOXJlIXUr1mo5xcWJ/YbCgZclbxYXf38kj/WF2ECjfzivPQLoAf7fcD3N0IRvMjsGkm1GyCip8wyh/x0uA14kbsnEBnWX++KJWEsjSfEcCwsW9n1jhQGJvrfSBTHiZWqng2Ts8gztLXugy7emHnMXmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mDZqQ7BOcWFWz/P4+9jDx2S3P7VAXDaSeZ0x1KSy0k=;
 b=K4GYBSN5HJE7ZO6fIcLhtQPlQVutQ8onQgeMf9m/OEP259l8TRBJ78Qe/TG03dy7mLfe24DDip9RY0z4wQgjufcHsbIEfNcVxPhOTQ02h9zJHI4wRRXvZjFdrjU3gBDwtEXX13NIpRZZrevXk3Zwi4vL9+DCjFWtvC2+AB36MjMReSsDfKZE1w6pOlNxT71iasNiQe1D/+YOkzr+cPzmVVqIzYqH8Ff8mG+ft5HgsfxNIPCGCyRDu6G+forZBJjEvAHqkE8+bou/MzAhv2kYd/PTxxy8tx6MSz2pj3939bAT1DOasC8r+XhlKVzG4p6ASMkgVxP+IebHEamuwkrACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mDZqQ7BOcWFWz/P4+9jDx2S3P7VAXDaSeZ0x1KSy0k=;
 b=y+3C1kcy+Op19zD4ZY1i0rcCPrqOmKqWIzsBZ4rHm+f9xi2SRWCRL+ux4Mkv7lVkhjXD0hcjWe9ZPGtRsI6BH4yQGKetfxkVBZZOBUAWQe76xfX/LBgBBIoDk3js/9w7Ysm8XmyxtJ0mQ5dTnH/GQHk4O/hLLDxKlUCvk4uLAOQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 14:47:41 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 14:47:41 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBJbmNyZWFzZSB0?=
 =?UTF-8?Q?lb_flush_timeout_for_sriov?=
To: "Chen, Horace" <Horace.Chen@amd.com>,
 "Liu, Cheng Zhe" <ChengZhe.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210519093209.888377-1-ChengZhe.Liu@amd.com>
 <b9d6e51c-b172-9627-799f-937c3e94851a@gmail.com>
 <CO6PR12MB54592ED7CDBD40D670A80361932B9@CO6PR12MB5459.namprd12.prod.outlook.com>
 <cd905238-aeb7-dd71-e1a7-2fd8d20a2474@amd.com>
 <DM4PR12MB507287194C10E15669DEBAEDE12B9@DM4PR12MB5072.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7350e5e2-ab7f-5092-8b7b-f55aedef1e08@amd.com>
Date: Wed, 19 May 2021 16:47:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <DM4PR12MB507287194C10E15669DEBAEDE12B9@DM4PR12MB5072.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:8e28:1d3:41f3:e15a]
X-ClientProxiedBy: PR0P264CA0161.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::29) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:8e28:1d3:41f3:e15a]
 (2a02:908:1252:fb60:8e28:1d3:41f3:e15a) by
 PR0P264CA0161.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.32 via Frontend Transport; Wed, 19 May 2021 14:47:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16efb1f5-68d4-46f2-ed6c-08d91ad50dad
X-MS-TrafficTypeDiagnostic: MN2PR12MB4096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40962BE8A136678D9D472047832B9@MN2PR12MB4096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJTcPx2OgyyxtJmVLwpW961SCRWi7DUG+BfjhS1hkrnYLiOVM76YMNIQPCVZHAGBra1vwD4BX5TCgIiHCiwB+DD34HB+GrdbgEyPk13FbmmTW02QnO0ftE9LFUuhWyImghuEZJm3twgvnurPxUCJAoQY4lJwTtU4KUuxOKdFrCTrp4RZhS0LSSADn/MME6eec13lj/oesaM71VjRTklu/gyj+yf0TLjmoFysIs2zPc8+h21CNfhOB5HE1HQJxpDT9+gfhyYRqPDRWo9RAIV0l39v47bgaiVi37CgLkzBOyEwYUYVdFAisWquESCP6/q6NLa+L5T+y3KGGo7/ro/wTozw/cJtetlJN52crhgxYu0kWLbG8yabSPCFpPeY0sZwgWi4AxesiJnqX9FvUn3cGPEkmYnwf+TXe7JyASLlV1M1nX22D02qUFBVw0uvoWoha+EB3kmoKGock3HmyKfhmRJfTuGF+/hGVQwYS+qIKYQR47yJejTf4HFSWEDwAVOWNILG8Yp2nlX7jeYcr/lCJ39yaPxtT8j+Wo0Mb6yKsUvaT6iguWzSaVdgjeiZMgw4IuCmAPb3osLnqAZtw37OsCUyz7o0qgm/xdDiHUy+dN+TlxSNUnmcTzrxjcDaJhL/IKLY1ggcvntarHkjgMTDEXtxC1SY2iP9rVLbWdgTIbpbboadmz8ygw3KZ+Y+zgSU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(66556008)(66476007)(6486002)(30864003)(19627405001)(86362001)(66946007)(31696002)(224303003)(5660300002)(8936002)(83380400001)(66574015)(4326008)(6666004)(36756003)(31686004)(478600001)(38100700002)(2906002)(53546011)(33964004)(316002)(110136005)(54906003)(52116002)(186003)(2616005)(16526019)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b25rNkdmdHg1czVyYTcwYXBUM1d4b04wS0hGcFRxUDlnbEdJcFgvcC9CRHRK?=
 =?utf-8?B?eFlnTEYyOEk0ajRBaEcwWnZIYkdlQ3lDZGh2SVhSQWZuNmRMbUdCRVVIU1BQ?=
 =?utf-8?B?WkpWQ2d4TW83YmhNZjVkdkpJQVllWDNJcXVEckdoOS9ud3R6TkNlZmpISnZU?=
 =?utf-8?B?VCtXaU9YYm5WaWpOM1E2aFpPbGdmOHI1a0J6OGF2TURYVDJIL09YMEZUZ1VO?=
 =?utf-8?B?UHZtRHhRcHkrUzBLRjdtRHdpZktmN1B2ZVEzZHBvNGFTZTlWYW5mSTVoZjJP?=
 =?utf-8?B?M0l1RFFNSDBUbm0wRElKbXA5UDF5M3U4aXBhUk5iZlpQYlN5L0F6cGQydWox?=
 =?utf-8?B?R2tIWUh2VVVXYVpoNTVtU2pBa1ZQaWdiQ0RFa0NCU0ZBUzhic3JMTmpVM3FL?=
 =?utf-8?B?aUFOc1ZiTCtkTkxQb1F4Qk5DUmNBOTRPYVBST1RaR3ZaVTBDV0o2am9RaVhu?=
 =?utf-8?B?U1krS1RidVE4VWhSMVgxSkI1eENZeUVvTERwRXdWMGp5M3E0dHlwUkM5Tm80?=
 =?utf-8?B?dkJ6ZmdUWFFKVkRsallPQnFvQ0FoMXJ2d1ByL1M2SW84aW9CWmlBODJFc1B4?=
 =?utf-8?B?QTNNeHdLQnBZM2NMSDdQL1NEZkphcGFMUHJnNHNFYUtNNmIwU2JzZGRuT0di?=
 =?utf-8?B?QUxpR1NJaUpIbWJBVWZab2NGNlFDOHNMSWZIdW1zaWxSSGFrTmN3bFJYRkdG?=
 =?utf-8?B?a08rN0lDWU9IUkNrd2NYRzY2VVVQazdHdUZFeGFLTzBjalQ1M2IreU9hU0tJ?=
 =?utf-8?B?b2Zia215Y3YxR1ZPeHNqWCtSVCtPS2FFZHR1TFVBRXdIVWtuVmZDMk5kZWlQ?=
 =?utf-8?B?em03eWxQZmVET1p1ckVidzRiQzdBQlJ2dW1oOGhudTBTdERBTHVFQUd3c1Zj?=
 =?utf-8?B?d3d2MUxkMzVLdmI3d1k5cENUSFJSSGZmUTh3eU9QVWJsYWZuZGdmMlh3MUhu?=
 =?utf-8?B?Qi9sditVUG5WRTkySXQ1K2Q2bTU0VVFLak51VG1YOGRzTjFSYUg0MklmUnpV?=
 =?utf-8?B?R2dMUHJuUjFQNjErbk0vSEZPQVdyL0ljeWMwQ1N4SUliMHp5WkhwT2JLOXZy?=
 =?utf-8?B?MU94L21pUGI5VGdIY1Z5MHNGMW9LRGduQ2lXWkwwcDdlYzNBdzFmYlhxcEU4?=
 =?utf-8?B?RkJSQndEMERRem1iT2Rqc3pTTkJpV0I2TzljbkZ6WjJ2MngwdzVzY3VmUVZt?=
 =?utf-8?B?UVRCQUxBdmtmM29MUDJvMFVoR3NLckFJaGphOElmYml3cmpMa01lbnN4NUk1?=
 =?utf-8?B?WDc1NnA3WGt4OSszTnpqdHduRFgrWG85STRpeVdteGhiZ1E1M2xTQnRmZXV3?=
 =?utf-8?B?STZYNVlpQ3Z2RTFCTnE1NVdTOHZuNHNQVlVxN0R5dXI1eHpBWTlqZWtZOUFT?=
 =?utf-8?B?ZStoWFZQelBiY0hvWWNGNHd3Ui9QaTNCSFYyWGEvRE90ZGNPcG5Yb2p6bzl1?=
 =?utf-8?B?elVBZUdjTXpUclRackFuZUJZZHo4b1pZK3d2czNkR2VpdzVCLzFxN3NZZWlR?=
 =?utf-8?B?Wkc5bzNYUnRwRjhSdU1EaSsrWkc3OHYzMkYyUS9UUVVFbzlyMU9MYWdYVDN0?=
 =?utf-8?B?ZUltd0RDbDE0aVNqeHIwR3JCanBGVmZ4QUN5Z1VlR0JRWFJIRG5KTTl0aUtP?=
 =?utf-8?B?SWVuRHp2aWVnSEN5RldOaXUzV1JqMVVBYTJ3Z2NwU0JhVnZZQi96NmpTRTlT?=
 =?utf-8?B?ZGswWlRpUnA2V2tkQktQTSt0OVdVblA3NVRaTGxjZ0VVRTczZlNnSkhrN2Y2?=
 =?utf-8?B?OVpyMmcwcGljNEhDRVRUVWRPN2pTYXkvQUxMU3pIYVk2L2N4bTBHRGdCNGY5?=
 =?utf-8?B?S3UyMHNKVDlOdlhxaDlaWFZad21veFoyYjBRVmZhUGZrVEdYQUpWMFRVem9o?=
 =?utf-8?Q?Db2O1UK/A+fJk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16efb1f5-68d4-46f2-ed6c-08d91ad50dad
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 14:47:41.1863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fv3zV8fesfUtmmkN3bMA//OTkwHlCLlzsMXr3Iqw4qxRcqSZkERWmO7a8zhCsVEH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============2117273625=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2117273625==
Content-Type: multipart/alternative;
 boundary="------------630B88129A106CEEE9DBADA2"
Content-Language: en-US

--------------630B88129A106CEEE9DBADA2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Horace,

that is correct, but also completely irrelevant.

What we do here is to wait for the TLB flush to avoid starting 
operations with invalid cache data.

But a parallel FLR clears the cache anyway and also prevents any new 
operation from starting, so it is perfectly valid to timeout and just 
continue with an error message.


On the other hand waiting for 6 seconds in a busy loop will most likely 
trigger the watchdog timer and potentially kill our process.

That is a rather clear no-go, we simply can't increase timeouts infinitely.

Regards,
Christian.

Am 19.05.21 um 16:39 schrieb Chen, Horace:
>
> [AMD Official Use Only]
>
>
> Hi Christian,
>
> I think the problem is that a non-FLRed VF will not know that another 
> VF got an FLR, unless host triggered a whole GPU reset.
> So in the worst situation, for example the VF0 to VF10 are all hang 
> and will be FLRed one by one, the VF11 will not know that there are 
> FLRs happened, in VF11's prespective, it just see the fence didn't 
> come back for about 5.5(0.5*11) seconds.
>
> Thanks & Regards,
> Horace.
>
> ------------------------------------------------------------------------
> *发件人:* Koenig, Christian <Christian.Koenig@amd.com>
> *发送时间:* 2021年5月19日 19:49
> *收件人:* Liu, Cheng Zhe <ChengZhe.Liu@amd.com>; Christian König 
> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *抄送:* Xiao, Jack <Jack.Xiao@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; 
> Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Tuikov, Luben 
> <Luben.Tuikov@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; 
> Chen, Horace <Horace.Chen@amd.com>
> *主题:* Re: [PATCH] drm/amdgpu: Increase tlb flush timeout for sriov
> Yeah, but you can't do that it will probably trigger the watchdog timer.
>
> The usec_timeout is named this way because it is a usec timeout.
> Anything large than 1ms is a no-go here.
>
> When the other instances do a FLR we don't really need to wait for the
> TLB flush anyway since any FLR will kill that.
>
> Christian.
>
> Am 19.05.21 um 13:08 schrieb Liu, Cheng Zhe:
> > [AMD Official Use Only]
> >
> > We support 12 VF at most. In worst case, the first 11 all IDLE fail 
> and do FLR, it will need 11 * 500ms to switch to the 12nd VF,
> > so I set 12 * 500ms  for the timeout.
> >
> > -----Original Message-----
> > From: Christian König <ckoenig.leichtzumerken@gmail.com>
> > Sent: Wednesday, May 19, 2021 6:08 PM
> > To: Liu, Cheng Zhe <ChengZhe.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Xiao, Jack <Jack.Xiao@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; 
> Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Tuikov, Luben 
> <Luben.Tuikov@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: Increase tlb flush timeout for sriov
> >
> > Am 19.05.21 um 11:32 schrieb Chengzhe Liu:
> >> When there is 12 VF, we need to increase the timeout
> > NAK, 6 seconds is way to long to wait polling on a fence.
> >
> > Why should an invalidation take that long? The engine are per VF 
> just to avoid exactly that problem.
> >
> > Christian.
> >
> >> Signed-off-by: Chengzhe Liu <ChengZhe.Liu@amd.com>
> >> ---
> >>    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6 +++++-
> >>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 6 +++++-
> >>    2 files changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> >> index f02dc904e4cf..a5f005c5d0ec 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> >> @@ -404,6 +404,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct 
> amdgpu_device *adev,
> >>       uint32_t seq;
> >>       uint16_t queried_pasid;
> >>       bool ret;
> >> +    uint32_t sriov_usec_timeout = 6000000; /* wait for 12 * 500ms for
> >> +SRIOV */
> >>       struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
> >>       struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> >>
> >> @@ -422,7 +423,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct
> >> amdgpu_device *adev,
> >>
> >>               amdgpu_ring_commit(ring);
> >> spin_unlock(&adev->gfx.kiq.ring_lock);
> >> -            r = amdgpu_fence_wait_polling(ring, seq, 
> adev->usec_timeout);
> >> +            if (amdgpu_sriov_vf(adev))
> >> +                    r = amdgpu_fence_wait_polling(ring, seq, 
> sriov_usec_timeout);
> >> +            else
> >> +                    r = amdgpu_fence_wait_polling(ring, seq, 
> adev->usec_timeout);
> >>               if (r < 1) {
> >>                       dev_err(adev->dev, "wait for kiq fence error: 
> %ld.\n", r);
> >>                       return -ETIME;
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> >> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> >> index ceb3968d8326..e4a18d8f75c2 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> >> @@ -857,6 +857,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct 
> amdgpu_device *adev,
> >>       uint32_t seq;
> >>       uint16_t queried_pasid;
> >>       bool ret;
> >> +    uint32_t sriov_usec_timeout = 6000000; /* wait for 12 * 500ms for
> >> +SRIOV */
> >>       struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
> >>       struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> >>
> >> @@ -896,7 +897,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct
> >> amdgpu_device *adev,
> >>
> >>               amdgpu_ring_commit(ring);
> >> spin_unlock(&adev->gfx.kiq.ring_lock);
> >> -            r = amdgpu_fence_wait_polling(ring, seq, 
> adev->usec_timeout);
> >> +            if (amdgpu_sriov_vf(adev))
> >> +                    r = amdgpu_fence_wait_polling(ring, seq, 
> sriov_usec_timeout);
> >> +            else
> >> +                    r = amdgpu_fence_wait_polling(ring, seq, 
> adev->usec_timeout);
> >>               if (r < 1) {
> >>                       dev_err(adev->dev, "wait for kiq fence error: 
> %ld.\n", r);
> >> up_read(&adev->reset_sem);
>


--------------630B88129A106CEEE9DBADA2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Horace,<br>
    <br>
    that is correct, but also completely irrelevant.<br>
    <br>
    What we do here is to wait for the TLB flush to avoid starting
    operations with invalid cache data.<br>
    <br>
    But a parallel FLR clears the cache anyway and also prevents any new
    operation from starting, so it is perfectly valid to timeout and
    just continue with an error message.<br>
    <br>
    <br>
    On the other hand waiting for 6 seconds in a busy loop will most
    likely trigger the watchdog timer and potentially kill our process.<br>
    <br>
    That is a rather clear no-go, we simply can't increase timeouts
    infinitely.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 19.05.21 um 16:39 schrieb Chen,
      Horace:<br>
    </div>
    <blockquote type="cite" cite="mid:DM4PR12MB507287194C10E15669DEBAEDE12B9@DM4PR12MB5072.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" align="Left">
        [AMD Official Use Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Hi Christian,</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          I think the problem is that a non-FLRed VF will not know that
          another VF got an FLR, unless host triggered a whole GPU
          reset.
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          So in the worst situation, for example the VF0 to VF10 are all
          hang and will be FLRed one by one, the VF11 will not know that
          there are FLRs happened, in VF11's prespective, it just see
          the fence didn't come back for about 5.5(0.5*11) seconds.</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Thanks &amp; Regards,</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Horace.<br>
        </div>
        <div>
          <div id="appendonsend"><br>
          </div>
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>发件人:</b>
              Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
              <b>发送时间:</b> 2021年5月19日 19:49<br>
              <b>收件人:</b> Liu, Cheng Zhe <a class="moz-txt-link-rfc2396E" href="mailto:ChengZhe.Liu@amd.com">&lt;ChengZhe.Liu@amd.com&gt;</a>;
              Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>抄送:</b> Xiao, Jack <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@amd.com&gt;</a>; Xu,
              Feifei <a class="moz-txt-link-rfc2396E" href="mailto:Feifei.Xu@amd.com">&lt;Feifei.Xu@amd.com&gt;</a>; Wang, Kevin(Yang)
              <a class="moz-txt-link-rfc2396E" href="mailto:Kevin1.Wang@amd.com">&lt;Kevin1.Wang@amd.com&gt;</a>; Tuikov, Luben
              <a class="moz-txt-link-rfc2396E" href="mailto:Luben.Tuikov@amd.com">&lt;Luben.Tuikov@amd.com&gt;</a>; Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Zhang, Hawking
              <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a>; Chen, Horace
              <a class="moz-txt-link-rfc2396E" href="mailto:Horace.Chen@amd.com">&lt;Horace.Chen@amd.com&gt;</a><br>
              <b>主题:</b> Re: [PATCH] drm/amdgpu: Increase tlb flush
              timeout for sriov</font>
            <div>&nbsp;</div>
          </div>
          <div class="BodyFragment"><font size="2"><span style="font-size:11pt">
                <div class="PlainText">Yeah, but you can't do that it
                  will probably trigger the watchdog timer.<br>
                  <br>
                  The usec_timeout is named this way because it is a
                  usec timeout. <br>
                  Anything large than 1ms is a no-go here.<br>
                  <br>
                  When the other instances do a FLR we don't really need
                  to wait for the <br>
                  TLB flush anyway since any FLR will kill that.<br>
                  <br>
                  Christian.<br>
                  <br>
                  Am 19.05.21 um 13:08 schrieb Liu, Cheng Zhe:<br>
                  &gt; [AMD Official Use Only]<br>
                  &gt;<br>
                  &gt; We support 12 VF at most. In worst case, the
                  first 11 all IDLE fail and do FLR, it will need 11 *
                  500ms to switch to the 12nd VF,<br>
                  &gt; so I set 12 * 500ms&nbsp; for the timeout.<br>
                  &gt;<br>
                  &gt; -----Original Message-----<br>
                  &gt; From: Christian König
                  <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                  &gt; Sent: Wednesday, May 19, 2021 6:08 PM<br>
                  &gt; To: Liu, Cheng Zhe <a class="moz-txt-link-rfc2396E" href="mailto:ChengZhe.Liu@amd.com">&lt;ChengZhe.Liu@amd.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                  &gt; Cc: Xiao, Jack <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@amd.com&gt;</a>; Xu,
                  Feifei <a class="moz-txt-link-rfc2396E" href="mailto:Feifei.Xu@amd.com">&lt;Feifei.Xu@amd.com&gt;</a>; Wang, Kevin(Yang)
                  <a class="moz-txt-link-rfc2396E" href="mailto:Kevin1.Wang@amd.com">&lt;Kevin1.Wang@amd.com&gt;</a>; Tuikov, Luben
                  <a class="moz-txt-link-rfc2396E" href="mailto:Luben.Tuikov@amd.com">&lt;Luben.Tuikov@amd.com&gt;</a>; Deucher, Alexander
                  <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian
                  <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Zhang, Hawking
                  <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                  &gt; Subject: Re: [PATCH] drm/amdgpu: Increase tlb
                  flush timeout for sriov<br>
                  &gt;<br>
                  &gt; Am 19.05.21 um 11:32 schrieb Chengzhe Liu:<br>
                  &gt;&gt; When there is 12 VF, we need to increase the
                  timeout<br>
                  &gt; NAK, 6 seconds is way to long to wait polling on
                  a fence.<br>
                  &gt;<br>
                  &gt; Why should an invalidation take that long? The
                  engine are per VF just to avoid exactly that problem.<br>
                  &gt;<br>
                  &gt; Christian.<br>
                  &gt;<br>
                  &gt;&gt; Signed-off-by: Chengzhe Liu
                  <a class="moz-txt-link-rfc2396E" href="mailto:ChengZhe.Liu@amd.com">&lt;ChengZhe.Liu@amd.com&gt;</a><br>
                  &gt;&gt; ---<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6
                  +++++-<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp; | 6
                  +++++-<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp; 2 files changed, 10 insertions(+), 2
                  deletions(-)<br>
                  &gt;&gt;<br>
                  &gt;&gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
                  &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
                  &gt;&gt; index f02dc904e4cf..a5f005c5d0ec 100644<br>
                  &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
                  &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
                  &gt;&gt; @@ -404,6 +404,7 @@ static int
                  gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device
                  *adev,<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t seq;<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t queried_pasid;<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret;<br>
                  &gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t sriov_usec_timeout = 6000000;&nbsp;
                  /* wait for 12 * 500ms for<br>
                  &gt;&gt; +SRIOV */<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                  &amp;adev-&gt;gfx.kiq.ring;<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq =
                  &amp;adev-&gt;gfx.kiq;<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
                  &gt;&gt; @@ -422,7 +423,10 @@ static int
                  gmc_v10_0_flush_gpu_tlb_pasid(struct<br>
                  &gt;&gt; amdgpu_device *adev,<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(ring);<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);<br>
                  &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                  amdgpu_fence_wait_polling(ring, seq,
                  adev-&gt;usec_timeout);<br>
                  &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
                  &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                  amdgpu_fence_wait_polling(ring, seq,
                  sriov_usec_timeout);<br>
                  &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
                  &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                  amdgpu_fence_wait_polling(ring, seq,
                  adev-&gt;usec_timeout);<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 1) {<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,
                  &quot;wait for kiq fence error: %ld.\n&quot;, r);<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIME;<br>
                  &gt;&gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
                  &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
                  &gt;&gt; index ceb3968d8326..e4a18d8f75c2 100644<br>
                  &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
                  &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
                  &gt;&gt; @@ -857,6 +857,7 @@ static int
                  gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device
                  *adev,<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t seq;<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t queried_pasid;<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret;<br>
                  &gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t sriov_usec_timeout = 6000000;&nbsp;
                  /* wait for 12 * 500ms for<br>
                  &gt;&gt; +SRIOV */<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                  &amp;adev-&gt;gfx.kiq.ring;<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq =
                  &amp;adev-&gt;gfx.kiq;<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
                  &gt;&gt; @@ -896,7 +897,10 @@ static int
                  gmc_v9_0_flush_gpu_tlb_pasid(struct<br>
                  &gt;&gt; amdgpu_device *adev,<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(ring);<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);<br>
                  &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                  amdgpu_fence_wait_polling(ring, seq,
                  adev-&gt;usec_timeout);<br>
                  &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
                  &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                  amdgpu_fence_wait_polling(ring, seq,
                  sriov_usec_timeout);<br>
                  &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
                  &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                  amdgpu_fence_wait_polling(ring, seq,
                  adev-&gt;usec_timeout);<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 1) {<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,
                  &quot;wait for kiq fence error: %ld.\n&quot;, r);<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  up_read(&amp;adev-&gt;reset_sem);<br>
                  <br>
                </div>
              </span></font></div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------630B88129A106CEEE9DBADA2--

--===============2117273625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2117273625==--
