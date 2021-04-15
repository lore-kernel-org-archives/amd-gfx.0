Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0A0C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 06:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F4B61139
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 06:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F4B61139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA136E0F0;
	Thu, 15 Apr 2021 06:27:42 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690046.outbound.protection.outlook.com [40.107.69.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DEC46E0F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 06:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ph8bykS+TLvIkOWN/9aGOP1UTS/oQNSUb7rd660MfI3+5pLPVKyQhIAqEEhnv3m8VtPgqXGNPZ8J5M5CbW3Ptvtx5Qkp1xhqVM51EwDIkW8iNCcybOpjoFbbRV4eZTf79O6hPrjrS9ozlBhJOMpIYRuVX/ybZ1NheHN6lBr4jqDU4h2BbzVuWx0KVnfyetIAc/28qeJ+Iip8bsUvs9S+LkEL0EZNkcFxOeZsh/9XSj+w2LXWPdu1MX6Kvx1YF1u3zPTQu4sDkqDZZ8q4ORzakyBYA8xqPM71ytjy6WcXhHwq6tghEYRIBg7x+eNxBplIEBif4leDi/VTHd84ctPsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8zapzr7vhOPN+sIOwDAd7I3qE7JtTqDlFYfeGo2vZ0=;
 b=EGHDgiAhTjWL2gVnvSrBElwShowwNxGQlT4LxRyl55SINzL8u8gssDpxmMijxIFeDGEAW48IQd1gpKd4aG0+MLOxcOX9MJed+3nhkMwAOzJHFSCjjbuwVHaXWIfMMWjCj+VgfWrhJ7m6c6vUDXWt+3mbjM8syXQ6BzRv8oBtplI3benTkljy2B+o2qEJ/119mWF6o7iTAaIyc6g/WClQCJc09r9YHv3nypcqxkICWtqwjjDVwygR6fPFMe3BWqGp3Km0PMOtoR4GQyWz9Ghjv5K6zrXHy2eS3EOJRgkI2t7XyA1bxy5ckSl1lwH9yPavX0WT9JY9ebXCz7t8sPdqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8zapzr7vhOPN+sIOwDAd7I3qE7JtTqDlFYfeGo2vZ0=;
 b=iUo8tdryTEard3TLs88x6DubOG9mKmgkNT99c5Jv5Eg1RvbkfrcT57kJNqnINvYoev/rh58W/37o8DrpwgAbeGyvm8qqY+l9tGKbPqqLXmgrS/IipqWVxEUbQHSmkY6YfSf7x5shVRcr1sxFy0B1qFzwnSUvNFl1mrzoub0H7Qg=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4591.namprd12.prod.outlook.com (2603:10b6:806:9d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Thu, 15 Apr
 2021 06:27:38 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde%5]) with mapi id 15.20.4020.022; Thu, 15 Apr 2021
 06:27:38 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
 <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
 <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
 <0224d3c2-1bd0-3941-fa7f-5667027368fa@amd.com>
 <a92e8f96-029f-6d21-4430-7e3116c21dea@amd.com>
 <9ea8f0c1-8d58-f4ab-e2a9-1ef8fd00718c@amd.com>
 <9b9e84ca-b259-b683-ef9d-1f9be95e1734@gmail.com>
 <ae02bdf3-8f4b-ed38-b62d-c3b606554a59@amd.com>
 <8b2db19a-d5f9-a7e3-6662-b990b7b3db2f@amd.com>
 <0fe87232-08ec-d804-ff55-2716b8e09c12@amd.com>
 <e37d6954-46e7-e7eb-22c3-a5b19829fe6c@amd.com>
 <65cd86df-b660-6c8a-348e-d511b61d91d4@amd.com>
 <689099ea-c1e9-31ea-6a5a-070562cb7440@amd.com>
 <b30c75cf-9b00-b52d-1ac1-ccd33e02bfe3@amd.com>
 <3dab0504-b834-add7-1f2f-0237b0f0c20d@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <bb13794d-1067-6b91-c2dc-138118c3ef0d@amd.com>
Date: Thu, 15 Apr 2021 02:27:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <3dab0504-b834-add7-1f2f-0237b0f0c20d@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:8516:e223:361b:cfe8]
X-ClientProxiedBy: YTBPR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::24) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:8516:e223:361b:cfe8]
 (2607:fea8:3edf:49b0:8516:e223:361b:cfe8) by
 YTBPR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Thu, 15 Apr 2021 06:27:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b76d5646-7311-4a88-b2cd-08d8ffd79097
X-MS-TrafficTypeDiagnostic: SA0PR12MB4591:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4591209FA21F4CBAC7C9979BEA4D9@SA0PR12MB4591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bEG5KEYdeAhnQZYYljRiripMo+Ig7ayiAYsCartTCsM5f7DI5glRPgcdWru9C3rxP/k86FVo0qtuGSBhP6mUdqepxQ/2NySf63gYt4+wOacmEAn7zPtneQ4LBHgB2HMsIoh9OBxB4wdiVTjdlkacaKzDGvOOmG5lA0dy/U0Zt4R0iBzueczatre7FNJtwScAY0I9YMAWfoPXxfaT1uQ7Wo3ojjvV3tCzmRLl5Cdrrk+1SM78iz75SiNIr2aJz06QJ2ONw8h3hQ1QvwM/ysXf4H7JBWLsqe+9CKA+L7ojXTAmMKMDIEo0ra0R9IQS+nAPvP+3TMYxkD+6WGYvI44WwrhHRMkzSrlsjc+BVQ+Z0cZDNebP/N4swlfKIZXflzY32i1qyfVggwgrRcYdT+XZQ4g3KgWNb8DlvkOgZBtgeQKLPL7o3Brwd01w1pOFhjDdyePgVNaq2m0T3l+d43UEfWxpl7mEFiH69JMO/kxqxLdxF96N2wwa868ucYNl862a16zXYePSoxfHDWEF8hRQWuvdhbmxc81OmTM0/UUGIIn2wnBKsSR2yBZQF/69JZOTI5xNqV3sIUYjH1UH2BVRw+vf3lLGhjVQDg6Z7wpMWOgQ9bNXyRo1VCSKEEEBProHRZctN3gRk2Fu4bVTkMwFjwUUu1Lq4N2KpMHkLN/gC99fLHc9uL/7mXbvbY6nQnf0pIP6r8CJFnN2T5oGUoOcBeoIWy1QgiNOTbtZGdgSWdtBiiZR6jpXOtQp96YvYEEL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(86362001)(316002)(16526019)(66476007)(31696002)(6486002)(5660300002)(36756003)(66946007)(110136005)(2616005)(66556008)(53546011)(66574015)(8676002)(921005)(52116002)(186003)(45080400002)(478600001)(2906002)(8936002)(44832011)(966005)(38100700002)(31686004)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YW44dnpycTg5RDU0RmtPcmQ3NGhXUWp2MkUwbGg2WkRuRlk2Rll6NlFsV1lt?=
 =?utf-8?B?WU52ZFI1NThkM1JKbkF0clhUOFh6dnZwQm1HS3NLTTI0R0dUUTdUais0bzFD?=
 =?utf-8?B?TEhOaER3M0xaSzl5dmFmeWNob25SS3lQREl1Q3h6OVdwU21SV25XKzdKMkJK?=
 =?utf-8?B?M1M2NXVhREdhTHRtMFlXLzE2QURsdDdyRUdWOEs2VzRLQWpYcGZGaFpSbzNF?=
 =?utf-8?B?OEN4L0ZzMnJMMGErcXJNa01Xd2xwQ2c3TjNpZmVPVTYyOVZtKzZGL1o3Q3VI?=
 =?utf-8?B?aThQcEk4VDc0aTU5ZzV0V0k4blMrN24wYkdocVZ3S0laZnpjbXdsdXBXdmY4?=
 =?utf-8?B?NWJvNUw1bEZBNVdQMldJS010Ym40QUVaMXY0UlNjeWVwWlJXQm9sWmQzdmdr?=
 =?utf-8?B?eUJqdE1TK2grTzd4eU5vSnZTQVllL28wT1JwOHdiRXhjNDJuM1JkS095bm9i?=
 =?utf-8?B?ZW1JdXZJNFFiczB4V3pjcnpXRzZTZG9nSnpNUE1yQTVqcjFHczVNYmIxVDVj?=
 =?utf-8?B?WGJMNVlGWFB0TlVzZ05ncFVBTTRTdnlRSjVSV1Z3SlY4SmczekVmOEVEcGZV?=
 =?utf-8?B?b0NFN084WXJPQVNaVUlMYktrZG1IM3FVYkp0R1AxSWtZL0lTVjlLOXRBbXdm?=
 =?utf-8?B?VGltTzF6aktXUmV4c3hVRHJ2a2FIYTRESnVEdTl2NHMyNXlCcUJBbHE2SUNm?=
 =?utf-8?B?bmExNEpvNEI4M2ltT2s5QWgzZXhIdTZkRGFxZ1pkOFhOSGVvWmZPN2xBaFJN?=
 =?utf-8?B?cktDczFqUHFlSFM2QTJhUk84c0JjSHI0a2tEYzh2bVRZeCtsTDhncnhDdWpu?=
 =?utf-8?B?MS9jSSsraHpzcjdoOTAzcTZHZ3dFRGQrTHV4MytnMVAwcVIzU3lEa1JGRkVw?=
 =?utf-8?B?N2pXNCs0NXI5T24yVTRwaG82VGRJNUt1bHRPOVBSTmw5cFdNaFFVWENidS96?=
 =?utf-8?B?d1VkZEp2SnRPMGVXNHNuWDE3TFJLVUFlZjErNjc3SUxrY0dCSExocWtXaVRh?=
 =?utf-8?B?akpEcEdQdU53V3RUVVJob3pkUXRJQmRHMFRhdXVWSHR5Q0RzWE5pdE16c2Vr?=
 =?utf-8?B?RnpJeU5sUlEwVGF3dXZqM0ppNDh5Z3VrdERuYXgzWS90L1pLaldkcEVFd3Jq?=
 =?utf-8?B?amZZTkwwL2lOaUF4VGdMN1pQSS9vb01LcGYwVUlxVnNCdllJWHZHZ2VqbDFQ?=
 =?utf-8?B?Mm9pclc4Z21JUW5BcEhkaElrem5vbGJiemhJbEh1Ny9ybm1ISzJZVTd0MG14?=
 =?utf-8?B?cnA2N2FPZml3Tm9oVFFNOUR0dXl2dnRIWFVpRTl1di9NQ1VrTS9HdU9QTnpO?=
 =?utf-8?B?ZWxpcE1JSzFERnBUaThmcldlR1BjMGNYcWh0V2VYazNJNWIwWGdpWk1DcDFl?=
 =?utf-8?B?cmdSUlZHOVc0NGlIMHAxdzhjcURCRUZRY0VGYStCNERJSGNieVN5TUI1Mllp?=
 =?utf-8?B?dVJFSDI5b3h1WjZRcUg5Y2NlTjdZL2lVNUU2SFgwTGw4bkcyYnJzNFl2M0M2?=
 =?utf-8?B?MDFyZWQ4Nm1HYjV5V2IwMmlaQzRpYVg2bW9Jb1VpRXZyZHY4NTk5c3dwc1kz?=
 =?utf-8?B?ZDRkOGh3TmlNbzRha0JhMlFudHA4YUo4L0Vsb1F0anY1dXdnU1J0RGR4REhW?=
 =?utf-8?B?NENYTFpHZHZhMWgwTjV3SnNMYjQ0Smd2bGg3NzZGN28reVRYL1lNMEp4SUZX?=
 =?utf-8?B?eFhncVpkRUVQaDZ3ejFjL3RhR2gzTXFaUzZudWozT3ducGNtcnVKOHBibG1o?=
 =?utf-8?B?Yk5kdm1PS05hZ3lLZjFyTXF2Wm5NMllxTjM3ZXFHaXh2aGVYQko3NEM3WDNE?=
 =?utf-8?B?aldmM0l1MHRxWGFUUmVzOVVSYlpVYURoM3pvSUlHaFNESEI0NlVVRDR4cnVr?=
 =?utf-8?Q?p/neGp9y0bDXP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76d5646-7311-4a88-b2cd-08d8ffd79097
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 06:27:38.6035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7SpXJuA8Tyv0v+i2DIiWjYgaO0ZEcTx5wYrTmFyI/lccMXsSfJlrKhE5SUAelSXzc0xb5zlTxGFNufWmzgnmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4591
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjEtMDQtMTQgMTA6NTggYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAx
NC4wNC4yMSB1bSAxNjozNiBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+PiDCoFtTTklQXQo+
Pj4+Pgo+Pj4+PiBXZSBhcmUgcmFjaW5nIGhlcmUgb25jZSBtb3JlIGFuZCBuZWVkIHRvIGhhbmRs
ZSB0aGF0Lgo+Pj4+Cj4+Pj4KPj4+PiBCdXQgd2h5LCBJIHdyb3RlIGFib3ZlIHRoYXQgd2UgZmly
c3Qgc3RvcCB0aGUgYWxsIHNjaGVkdWxlcnMsIHRoZW4gCj4+Pj4gb25seSBjYWxsIGRybV9zY2hl
ZF9lbnRpdHlfa2lsbF9qb2JzLgo+Pj4KPj4+IFRoZSBzY2hlZHVsZXJzIGNvbnN1bWluZyBqb2Jz
IGlzIG5vdCB0aGUgcHJvYmxlbSwgd2UgYWxyZWFkeSBoYW5kbGUgCj4+PiB0aGF0IGNvcnJlY3Qu
Cj4+Pgo+Pj4gVGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgZW50aXRpZXMgbWlnaHQgY29udGludWUg
ZmVlZGluZyBzdHVmZiBpbnRvIAo+Pj4gdGhlIHNjaGVkdWxlci4KPj4KPj4KPj4gTWlzc2VkIHRo
YXQuwqAgT2ssIGNhbiBJIGp1c3QgdXNlIG5vbiBzbGVlcGluZyBSQ1Ugd2l0aCBhIGZsYWcgYXJv
dW5kIAo+PiBkcm1fc2NoZWRfZW50aXR5X3B1c2hfam9iIGF0IHRoZSBhbWRncHUgbGV2ZWwgKG9u
bHkgMiBmdW5jdGlvbnMgY2FsbCAKPj4gaXQgLSBhbWRncHVfY3Nfc3VibWl0IGFuZCBhbWRncHVf
am9iX3N1Ym1pdCkgYXMgYSBwcmVsaW1pbmFyeSBzdGVwIHRvIAo+PiBmbHVzaCBhbmQgYmxvY2sg
aW4gZmxpZ2h0IGFuZCBmdXR1cmUgc3VibWlzc2lvbnMgdG8gZW50aXR5IHF1ZXVlID8KPgo+IERv
dWJsZSBjaGVja2luZyB0aGUgY29kZSBJIHRoaW5rIHdlIGNhbiB1c2UgdGhlIG5vdGlmaWVyX2xv
Y2sgZm9yIHRoaXMuCj4KPiBFLmcuIGluIGFtZGdwdV9jcy5jIHNlZSB3aGVyZSB3ZSBoYXZlIHRo
ZSBnb3RvIGVycm9yX2Fib3J0Lgo+Cj4gVGhhdCBpcyB0aGUgcGxhY2Ugd2hlcmUgc3VjaCBhIGNo
ZWNrIGNvdWxkIGJlIGFkZGVkIHdpdGhvdXQgYW55IAo+IGFkZGl0aW9uYWwgb3ZlcmhlYWQuCgoK
U3VyZSwgSSB3aWxsIGp1c3QgaGF2ZSB0byBhZGQgdGhpcyBsb2NrIHRvIGFtZGdwdV9qb2Jfc3Vi
bWl0IHRvby4KCgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+Cj4+Pgo+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+
Pj4gRm9yIHdhaXRpbmcgZm9yIG90aGVyIGRldmljZSBJIGhhdmUgbm8gaWRlYSBpZiB0aGF0IGNv
dWxkbid0IAo+Pj4+Pj4+IGRlYWRsb2NrIHNvbWVob3cuCj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IFll
YSwgbm90IHN1cmUgZm9yIGltcG9ydGVkIGZlbmNlcyBhbmQgZG1hX2J1ZnMsIEkgd291bGQgYXNz
dW1lIAo+Pj4+Pj4gdGhlIG90aGVyIGRldmljZXMgc2hvdWxkIG5vdCBiZSBpbXBhY3RlZCBieSBv
dXIgZGV2aWNlIHJlbW92YWwgCj4+Pj4+PiBidXQsIHdobyBrbm93cy4uLgo+Pj4+Pj4KPj4+Pj4+
IFNvIEkgZ3Vlc3Mgd2UgYXJlIE5PVCBnb2luZyB3aXRoIGZpbmFsaXppbmcgSFcgZmVuY2VzIGJl
Zm9yZSAKPj4+Pj4+IGRybV9kZXZfdW5wbHVnIGFuZCBpbnN0ZWFkIHdpbGwganVzdCBjYWxsIGRy
bV9kZXZfZW50ZXIvZXhpdCBhdCAKPj4+Pj4+IHRoZSBiYWNrLWVuZHMgYWxsIG92ZXIgdGhlIHBs
YWNlIHdoZXJlIHRoZXJlIGFyZSBNTUlPIGFjY2Vzc2VzID8KPj4+Pj4KPj4+Pj4gR29vZCBxdWVz
dGlvbi4gQXMgeW91IHNhaWQgdGhhdCBpcyByZWFsbHkgdGhlIGhhcmQgcGF0aC4KPj4+Pj4KPj4+
Pj4gSGFuZGxpbmcgaXQgYWxsIGF0IG9uY2UgYXQgSU9DVEwgbGV2ZWwgY2VydGFpbmx5IGhhcyBz
b21lIGFwcGVhbCAKPj4+Pj4gYXMgd2VsbCwgYnV0IEkgaGF2ZSBubyBpZGVhIGlmIHdlIGNhbiBn
dWFyYW50ZWUgdGhhdCB0aGlzIGlzIGxvY2sgCj4+Pj4+IGZyZWUuCj4+Pj4KPj4+Pgo+Pj4+IE1h
eWJlIGp1c3QgZW1waXJpY2FsbHkgLSBsZXQncyB0cnkgaXQgYW5kIHNlZSB1bmRlciBkaWZmZXJl
bnQgdGVzdCAKPj4+PiBzY2VuYXJpb3Mgd2hhdCBhY3R1YWxseSBoYXBwZW5zwqAgPwo+Pj4KPj4+
IE5vdCBhIGdvb2QgaWRlYSBpbiBnZW5lcmFsLCB3ZSBoYXZlIHRoYXQgYXBwcm9hY2ggd2F5IHRv
IG9mdGVuIGF0IAo+Pj4gQU1EIGFuZCBhcmUgdGhlbiBzdXJwcmlzZWQgdGhhdCBldmVyeXRoaW5n
IHdvcmtzIGluIFFBIGJ1dCBmYWlscyBpbiAKPj4+IHByb2R1Y3Rpb24uCj4+Pgo+Pj4gQnV0IERh
bmllbCBhbHJlYWR5IG5vdGVkIGluIGhpcyByZXBseSB0aGF0IHdhaXRpbmcgZm9yIGEgZmVuY2Ug
d2hpbGUgCj4+PiBob2xkaW5nIHRoZSBTUkNVIGlzIGV4cGVjdGVkIHRvIHdvcmsuCj4+Pgo+Pj4g
U28gbGV0J3Mgc3RpY2sgd2l0aCB0aGUgYXBwcm9hY2ggb2YgaGlnaCBsZXZlbCBsb2NraW5nIGZv
ciBob3RwbHVnLgo+Pgo+Pgo+PiBUbyBteSB1bmRlcnN0YW5kaW5nIHRoaXMgaXMgdHJ1ZSBmb3Ig
b3RoZXIgZGV2aXNlcywgbm90IHRoZSBvbmUgYmVpbmcgCj4+IGV4dHJhY3RlZCwgZm9yIGhpbSB5
b3Ugc3RpbGwgbmVlZCB0byBkbyBhbGwgdGhlIEhXIGZlbmNlIHNpZ25hbGxpbmcgCj4+IGRhbmNl
IGJlY2F1c2UgdGhlIEhXIGlzIGdvbmUgYW5kIHdlIGJsb2NrIGFueSBURFJzICh3aGljaCB3b24n
dCBoZWxwIAo+PiBhbnl3YXkpLgo+Pgo+PiBBbmRyZXkKCgpEbyB5b3UgYWdyZWUgdG8gdGhlIGFi
b3ZlID8KCkFuZHJleQoKCj4+Cj4+Cj4+Pgo+Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+Pgo+Pj4+IEFu
ZHJleQo+Pj4+Cj4+Pj4KPj4+Pj4KPj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+
IEFuZHJleQo+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+IFJlZ2FyZHMsCj4+Pj4+Pj4gQ2hyaXN0aWFu
Lgo+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pgo+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+PiBC
VFc6IENvdWxkIGl0IGJlIHRoYXQgdGhlIGRldmljZSBTUkNVIHByb3RlY3RzIG1vcmUgdGhhbiAK
Pj4+Pj4+Pj4+Pj4+PiBvbmUgZGV2aWNlIGFuZCB3ZSBkZWFkbG9jayBiZWNhdXNlIG9mIHRoaXM/
Cj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+IEkgaGF2ZW4ndCBhY3R1YWxs
eSBleHBlcmllbmNlZCBhbnkgZGVhZGxvY2sgdW50aWwgbm93IGJ1dCwgCj4+Pj4+Pj4+Pj4+PiB5
ZXMsIGRybV91bnBsdWdfc3JjdSBpcyBkZWZpbmVkIGFzIHN0YXRpYyBpbiBkcm1fZHJ2LmMgYW5k
IAo+Pj4+Pj4+Pj4+Pj4gc28gaW4gdGhlIHByZXNlbmNlIG9mIG11bHRpcGxlIGRldmljZXMgZnJv
bSBzYW1lIG9yIAo+Pj4+Pj4+Pj4+Pj4gZGlmZmVyZW50IGRyaXZlcnMgd2UgaW4gZmFjdCBhcmUg
ZGVwZW5kZW50IG9uIGFsbCB0aGVpciAKPj4+Pj4+Pj4+Pj4+IGNyaXRpY2FsIHNlY3Rpb25zIGkg
Z3Vlc3MuCj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBTaGl0LCB5ZWFoIHRo
ZSBkZXZpbCBpcyBhIHNxdWlycmVsLiBTbyBmb3IgQStJIGxhcHRvcHMgd2UgCj4+Pj4+Pj4+Pj4+
IGFjdHVhbGx5IG5lZWQgdG8gc3luYyB0aGF0IHVwIHdpdGggRGFuaWVsIGFuZCB0aGUgcmVzdCBv
ZiAKPj4+Pj4+Pj4+Pj4gdGhlIGk5MTUgZ3V5cy4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gSUlS
QyB3ZSBjb3VsZCBhY3R1YWxseSBoYXZlIGFuIGFtZGdwdSBkZXZpY2UgaW4gYSBkb2NraW5nIAo+
Pj4+Pj4+Pj4+PiBzdGF0aW9uIHdoaWNoIG5lZWRzIGhvdHBsdWcgYW5kIHRoZSBkcml2ZXIgbWln
aHQgZGVwZW5kIG9uIAo+Pj4+Pj4+Pj4+PiB3YWl0aW5nIGZvciB0aGUgaTkxNSBkcml2ZXIgYXMg
d2VsbC4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gQ2FuJ3Qgd2UgcHJvcG9zZSBh
IHBhdGNoIHRvIG1ha2UgZHJtX3VucGx1Z19zcmN1IHBlciAKPj4+Pj4+Pj4+PiBkcm1fZGV2aWNl
ID8gSSBkb24ndCBzZWUgd2h5IGl0IGhhcyB0byBiZSBnbG9iYWwgYW5kIG5vdCBwZXIgCj4+Pj4+
Pj4+Pj4gZGV2aWNlIHRoaW5nLgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IEknbSByZWFsbHkgd29uZGVy
aW5nIHRoZSBzYW1lIHRoaW5nIGZvciBxdWl0ZSBhIHdoaWxlIG5vdy4KPj4+Pj4+Pj4+Cj4+Pj4+
Pj4+PiBBZGRpbmcgRGFuaWVsIGFzIHdlbGwsIG1heWJlIGhlIGtub3dzIHdoeSB0aGUgZHJtX3Vu
cGx1Z19zcmN1IAo+Pj4+Pj4+Pj4gaXMgZ2xvYmFsLgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IFJlZ2Fy
ZHMsCj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4g
QW5kcmV5Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBDaHJp
c3RpYW4uCj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+IENocmlz
dGlhbi4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoCAvKiBQYXN0
IHRoaXMgcG9pbnQgbm8gbW9yZSBmZW5jZSBhcmUgc3VibWl0dGVkIHRvIAo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4gSFcgcmluZyBhbmQgaGVuY2Ugd2UgY2FuIHNhZmVseSBjYWxsIGZvcmNlIHNpZ25hbCBv
biAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+IGFsbCB0aGF0IGFyZSBjdXJyZW50bHkgdGhlcmUuCj4+Pj4+
Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqDCoCAqIEFueSBzdWJzZXF1ZW50bHkgY3JlYXRlZCBIVyBmZW5j
ZXMgd2lsbCBiZSAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHJldHVybmVkIHNpZ25hbGVkIHdpdGggYW4g
ZXJyb3IgY29kZSByaWdodCBhd2F5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqDCoCAqLwo+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoCBmb3JfZWFjaF9yaW5nKGFk
ZXYpCj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBhbWRncHVfZmVuY2VfcHJvY2VzcyhyaW5nKQo+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoCBkcm1fZGV2X3VucGx1ZyhkZXYp
Owo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIFN0b3Agc2NoZWR1bGVycwo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4gwqDCoMKgIGNhbmNlbF9zeW5jKGFsbCB0aW1lcnMgYW5kIHF1ZXVlZCB3b3Jrcyk7Cj4+
Pj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqAgaHdfZmluaQo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKg
IHVubWFwX21taW8KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiB9Cj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+IEFuZHJl
eQo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbHRlcm5hdGl2ZWx5IGdyYWJiaW5n
IHRoZSByZXNldCB3cml0ZSBzaWRlIGFuZCAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gc3RvcHBp
bmcgYW5kIHRoZW4gcmVzdGFydGluZyB0aGUgc2NoZWR1bGVyIGNvdWxkIAo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+PiB3b3JrIGFzIHdlbGwuCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gSSBkaWRuJ3QgZ2V0IHRoZSBh
Ym92ZSBhbmQgSSBkb24ndCBzZWUgd2h5IEkgbmVlZCAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiB0
byByZXVzZSB0aGUgR1BVIHJlc2V0IHJ3X2xvY2suIEkgcmVseSBvbiB0aGUgCj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4gU1JDVSB1bnBsdWcgZmxhZyBmb3IgdW5wbHVnLiBBbHNvLCBub3QgY2xlYXIg
dG8gCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gbWUgd2h5IGFyZSB3ZSBmb2N1c2luZyBvbiB0aGUg
c2NoZWR1bGVyIHRocmVhZHMsIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IGFueSBjb2RlIHBhdGNo
IHRvIGdlbmVyYXRlIEhXIGZlbmNlcyBzaG91bGQgYmUgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4g
Y292ZXJlZCwgc28gYW55IGNvZGUgbGVhZGluZyB0byBhbWRncHVfZmVuY2VfZW1pdCAKPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+PiBuZWVkcyB0byBiZSB0YWtlbiBpbnRvIGFjY291bnQgc3VjaCBhcywg
ZGlyZWN0IElCIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHN1Ym1pc3Npb25zLCBWTSBmbHVzaGVz
IGUudC5jCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gWW91IG5l
ZWQgdG8gd29yayB0b2dldGhlciB3aXRoIHRoZSByZXNldCBsb2NrIAo+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4gYW55d2F5LCBjYXVzZSBhIGhvdHBsdWcgY291bGQgcnVuIGF0IHRoZSBzYW1lIHRpbWUg
Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBhcyBhIHJlc2V0Lgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBGb3IgZ29pbmcgbXkgd2F5
IGluZGVlZCBub3cgSSBzZWUgbm93IHRoYXQgSSBoYXZlIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiB0
byB0YWtlIHJlc2V0IHdyaXRlIHNpZGUgbG9jayBkdXJpbmcgSFcgZmVuY2VzIAo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+PiBzaWduYWxsaW5nIGluIG9yZGVyIHRvIHByb3RlY3QgYWdhaW5zdCBzY2hlZHVs
ZXIvSFcgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IGZlbmNlcyBkZXRhY2htZW50IGFuZCByZWF0dGFj
aG1lbnQgZHVyaW5nIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBzY2hlZHVsZXJzIHN0b3AvcmVzdGFy
dC4gQnV0IGlmIHdlIGdvIHdpdGggeW91ciAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gYXBwcm9hY2gg
dGhlbiBjYWxsaW5nIGRybV9kZXZfdW5wbHVnIGFuZCBzY29waW5nIAo+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+PiBhbWRncHVfam9iX3RpbWVvdXQgd2l0aCBkcm1fZGV2X2VudGVyL2V4aXQgc2hvdWxkIAo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBiZSBlbm91Z2ggdG8gcHJldmVudCBhbnkgY29uY3VycmVudCBH
UFUgcmVzZXRzIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBkdXJpbmcgdW5wbHVnLiBJbiBmYWN0IEkg
YWxyZWFkeSBkbyBpdCBhbnl3YXkgLSAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gaHR0cHM6Ly9uYW0x
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzOiUyRiUyRmNnaXQu
ZnJlZWRlc2t0b3Aub3JnJTJGfmFncm9kem92JTJGbGludXglMkZjb21taXQlMkYlM0ZoJTNEZHJt
LW1pc2MtbmV4dCUyNmlkJTNEZWYwZWE0ZGQyOWVmNDRkMjY0OWM1ZWRhMTZjOGY0ODY5YWNjMzZi
MSZhbXA7ZGF0YT0wNCU3QzAxJTdDYW5kcmV5Lmdyb2R6b3Zza3klNDBhbWQuY29tJTdDYzdmYzZj
YjUwNWMzNGFlZGZlNmQwOGQ4ZmU0YjM5NDclN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRl
MTgzZCU3QzAlN0MwJTdDNjM3NTM4OTQ2MzI0ODU3MzY5JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNk
OGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pY
VkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPTY0MzYyUFJDOHhUZ1IyVWoyUjI1NmJNZWdWbThZ
V3ExS0klMkJBanplWVh2NCUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IFllcywgZ29vZCBwb2ludCBh
cyB3ZWxsLgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFu
Lgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4KPj4+
Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
