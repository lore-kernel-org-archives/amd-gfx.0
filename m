Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3181CC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 03:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0359F206D4
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 03:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fFI8umgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0359F206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E37EA6EAB2;
	Wed, 24 Jun 2020 03:21:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6446EAAD;
 Wed, 24 Jun 2020 03:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgo+XJhtx5qfG4D1YCkLxiM7n9eC3qqUWXbRtAUEjYga2Og1i4hv52VNu3CC6iJasFxz084MAUvDlcF8vGxksn1fQpQ0+ZUoqwTzuVrjUXTAeN3xyh8XPBw+ZR+WqRXYD+WZGmDQ6K4Y74WosMG49ritRIRDc4SMiay5BPj1ko5XGVeFavdN87YcuhgynFhLk42ZioKgdeVZ17ojSTzkNHRDlLlHzRv/SYNmKTVr+JCd/C6Kk04SDRCba88Ow2ncJHYy/olZoKfZE1etvMBKyC1xHXlqzKxfKkDnarZnPZRxmSUqTlzAgXWiweR8HXypAZBs5jTV8UvrUiYs/k8ABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLFIjAFhAV+MM5aJV868dPTOyaMImx0JpQZaU+G+Aog=;
 b=Kt+wOY11JzEd7lKh0prKDRjBVw9jyuPDjHS0UNGClDRVt8gqbNOT7urqbmQLCgC0Uc1qJtinOkwgDpbDF+rTV878ZHScXvKOsdiqkiLGQ0+EozaLbTpUd1gw5aBIlS09IOqejtJOObmLs6xGrJ1t/nQOkCryDC9uf5yeLMGgQixRWr5+Ije1iUcD2Rf/8uJ7XeAjVX2yw5YWCmth6kH0/3wr04SrSg0RRwE/9FVOhVvFFKqupN/mV1BYBm/FGlmSYxOpaMQXXC1QnYHsNuAthMoC5/LVASnFEnPZ3zkE6tr1XNdijGBYJQ9caVYyhjVwt+3xPHSSk0UIhGDVwaaAbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLFIjAFhAV+MM5aJV868dPTOyaMImx0JpQZaU+G+Aog=;
 b=fFI8umgIuqErhpQFyJ80IiCqa37x2wV20nIqHgSmCJEUxnEVXwBejSVGYrLWJDUWi7nW1sCcWNbp5LYtgXOQKltq4Ssl9dZg/aYTceeOhYKYUPggIYJCTtzbt0VjpYtYkgkX88jjTPYFtEMfk0K5lqqPKmJ3pq/DTl11xPKQSjk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Wed, 24 Jun 2020 03:21:42 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf%3]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 03:21:42 +0000
Subject: Re: [PATCH v2 0/8] RFC Support hot device unplug in amdgpu
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Daniel Vetter <daniel@ffwll.ch>
References: <1592719388-13819-1-git-send-email-andrey.grodzovsky@amd.com>
 <20200622094655.GC20149@phenom.ffwll.local>
 <a6e58cd8-8219-4997-fbbc-b68b0408cc49@amd.com>
 <742bf102-9ba1-63b0-3dc0-edf0f62200db@daenzer.net>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <8929b0d1-ed3a-2c26-f40b-2dc159bb796b@amd.com>
Date: Tue, 23 Jun 2020 23:21:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <742bf102-9ba1-63b0-3dc0-edf0f62200db@daenzer.net>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::14) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:f841:dc76:7c07:f4bf]
 (2607:fea8:3edf:49b0:f841:dc76:7c07:f4bf) by
 YTXPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Wed, 24 Jun 2020 03:21:42 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:f841:dc76:7c07:f4bf]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 09cc6e8c-3448-4281-5a8b-08d817edb754
X-MS-TrafficTypeDiagnostic: DM6PR12MB4546:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4546FD57BE316C51911BEE33EA950@DM6PR12MB4546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9UMDTihdakGT4oi49X5LQmffNkAK3RUhDf9msiC5uH1zF9MYcJ0HJQirmdNN/GNLZL8F6uK64ake04K50zOuk40cFzk3v1KsPhNWbZgDLIfOkvp2nxSfSAL3gATJcwKBhmv+ZJnLsk1hW73q9dcKxFXacSncrPXXIZ9fMsYhRKyhqH70yLk0AFdMHQf6HvXRhM1Dkj+dZERS4B+6NZCM8lDcA7/qGpgGF8MrUCmE0i7wh4jt7fxheGM7qgZxl16ETGxmHsmZpB3PGqTG6q9ew8P+izlNbTZjfXMrAtDaGJ6nXdG659/q4utLiVBdPL+j6FHS33h9x9Us5k7nbarnbNnY1RIDHVBusI3jlLDsuK7H4jma9F6Vw/+hpd7pBqFa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(83380400001)(2616005)(316002)(31686004)(31696002)(86362001)(16526019)(186003)(8936002)(53546011)(110136005)(52116002)(8676002)(2906002)(478600001)(66556008)(66946007)(66476007)(66574015)(36756003)(5660300002)(4326008)(6486002)(4744005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: I8XHkRE7SaoaG2+Ntt2U0DBu1Sm0nryppOGiCvnVIsCX9ouOjlw5RTYnEd6PRaBTSGVhxsjA72ubkBs8vo38KdO8uaSGwJRWtg8AC/KjCotrHiWvdAtaqbGT0FoIlfOBUaxmJ93uH3XwCnjE8e2ZGX+/m72DFihgxm8h6ZB/vs5xb5lgJIMmoKz/BmEXeENs69T1PIPvd1BkfkmrsBd0COzxc/ZC4lIwtNxGbwCwW6aUeoHo/Mozchey9OVMSShSfMxIlkMqSP2bKby+4JtP/IhSTh/KBbh7cvFJxyZnN4k/mxTo+6AtXXbNDBYxCbT474/baZdJAaeYYw+EiGpfAOj0fx0I3UPt/fxWhwUmfXdwXTpbRTLNtxpfKkIYRBHFPAsOB5tcLphcfzUsRWWKvF5pM5q+plJqYcWTVQqCf1637vvvKCc+4h+WjQNeJhzmREbJitHueXZa3LEgQrv6m9mayhMJEDa6Pn1u1+PNXokrwo3+H4srL8cKr7fl8lS0Hb0FrTIZwLz3rXZQwDv1ZxN9L48yOFqHqFWuJB6X89n3N4nWMH8p2upg9G9P8DVv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cc6e8c-3448-4281-5a8b-08d817edb754
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 03:21:42.4258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HozBDSqeIOTEGX9SBYE6P5uMruyzVi0XoSon4FQla6JRGVS1D9bfJMUIXkLjS9RZ7kXYrGIfM2K5OVYVUgr4SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4546
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
Cc: daniel.vetter@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, ckoenig.leichtzumerken@gmail.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VHJpZWQsIGRpZG4ndCBoYXZlIGFueSBpbXBhY3QKCkFuZHJleQoKCk9uIDYvMjMvMjAgNTowNCBB
TSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjAyMC0wNi0yMyA3OjE0IGEubS4sIEFuZHJl
eSBHcm9kem92c2t5IHdyb3RlOgo+PiBJIGFtIGZpZ2h0aW5nIHdpdGggVGh1bmRlcmJpcmQgdG8g
bWFrZSBsaW1pdCBhIGxpbmUgdG8gODAgY2hhcnMgYnV0Cj4+IG5vdGhpbmcgaGVscHMuIEFueSBz
dWdnZXN0aW9ucyBwbGVhc2UuCj4gTWF5YmUgdHJ5IGRpc2FibGluZyBtYWlsLmNvbXBvc2UuZGVm
YXVsdF90b19wYXJhZ3JhcGgsIG9yIGNoZWNrIG90aGVyCj4gKndyYXAqIHNldHRpbmdzLgo+Cj4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
