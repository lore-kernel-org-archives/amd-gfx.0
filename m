Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2931C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 14:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E85C22B45
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 14:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E85C22B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB4296E1F9;
	Wed,  6 Jan 2021 14:59:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 335C76E1F9
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 14:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJweiuxvYZWjUbbkpTiRFbSo9X5+RZ7aUOWvRS+pRANIW3YKgia8/XzZ4I2KzcDA7Q15yGKW9TRg+IURjH6+vAmyQJvFTZVS7oHX95y0v3352F/RGU1Jqj7ViqZhf9MGfj9nQ2Ub0sO+CVJLXMwJGtHXauMkFmUpOhhd8m6jqGIL5cDb3QLN+FEncuEeHT1qWpmljvsi42Q7jgYw2VKMGOSQoTyKnKRLKoaKLOu7tQtXZ0ID8Wtgpksv0Qj6X5ctR1hxOBliJAfi6vQAMM6Hm/6s3ukM8G25OwazGY/KM25S3QM+2obP+9Vv1HQoSyraWtnEIUNUD+pOHpymsujBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaVLaWRFX/UNkxApvAo1efckgEpUohXjucYozD3X2Lc=;
 b=jjZWVKsvj63I3sC5g9JINpg/gfO3d7QIXms+NPB9LDTM8Nk9P15GDddsF3p3jiJlAiiRjfBEPiCiN7GjY/+9ql911PO2HpJRs06BpoJo9IPPQGrRzxUzLGEp+WqfCIbEcZd7zOsLU8z8QnRJe79l799G091fx5/xhCPtQKVB61nnvK4MNXLINNY7nunludKxU+Dwy2TqRNyGYk8i4KkNEMwpLbpi8XnhktPgIZFUYh6Q0iTRRzpLfTqOx0P5PfHLLul5xXEr+vwZKpNrshDIsAFAGlhQ3busOoQv2Wmajh0Fg/O3kDm4sZmPg3sL+A2uPaUqEa9gE+rJYQJf0fVc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaVLaWRFX/UNkxApvAo1efckgEpUohXjucYozD3X2Lc=;
 b=h8E9LJs5YltdpKvpJD7t9iTaDDaLrqfTkPlcYSQK2jYAAfET/qFhvvwliEO/RPmhlQFFxXI9ks/WLLCSQr/BYhfYGVcSo19ZO2UD3cGiW2ohiAb79TTsSNkRpge0NS5YXrvPLWFTL+dX4gGDSO+9ozHAnnTTPTezgUOIuWqB7TI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 14:59:09 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3742.006; Wed, 6 Jan 2021
 14:59:09 +0000
Subject: Re: [PATCH] drm/amdgpu: don't limit gtt size on apus
To: Joshua Ashton <joshua@froggi.es>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20210105220359.1392555-1-joshua@froggi.es>
 <CADnq5_NcKG9H-dK0Kh2ksF8et+fnFkMdsejkg_RWrNeJ1JS4ng@mail.gmail.com>
 <6d6b0ae7-f732-167b-2bc1-6e517f6c8e99@froggi.es>
 <9902861e-77bd-d6dc-7284-0ad9bcf117b6@amd.com>
 <a8f72dc6-8504-269e-56e8-699b20135a07@froggi.es>
 <4a3fe8b7-4248-e5c2-d6c0-5075596ca852@amd.com>
 <CAP+8YyE2wBHAcn8H-Sr=+kKmE45kUhA=KBJL08ciZJESS4XSmA@mail.gmail.com>
 <66dc40b3-caed-6b3d-899d-32d1d0f74239@gmail.com>
 <f2009e7d-6fe5-0a55-0c37-8b0b2ca2c45c@froggi.es>
 <77444d7b-e8c4-16e3-6348-e322af9db103@amd.com>
 <f831126b-c31e-96cd-b056-0902d6d0d5cc@froggi.es>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <02c779e3-4e17-3afa-6b3f-9b5284254f55@amd.com>
Date: Wed, 6 Jan 2021 15:59:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <f831126b-c31e-96cd-b056-0902d6d0d5cc@froggi.es>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::25) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.2 via Frontend Transport; Wed, 6 Jan 2021 14:59:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a02720cf-ee4c-48ac-4131-08d8b2539eea
X-MS-TrafficTypeDiagnostic: MN2PR12MB4239:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4239C471A56DC02B93B4AA9B83D00@MN2PR12MB4239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJMuIlGuuEoCi7rghxpvyDR3CtLqzsSxi5u7r1t79lw7rYa4FO7lnkKRANjcGWX/l+S2EArvX/JDsRD8CjoueGW9E4DWq/svjGKxCLQT/NZCvCpuoW4jUXYw0uEG0z3RHrw8DdsiqPau+GUk0bneRMNYCM6cgDeA4jssJROG5RURDOOdMG2qBUingzimf+CUjT49CuDMskpbGcv+nM/71STqpnq/QXA5HAEsQazXgmoKJEXmGjKxvNHGY6jVrc2h2mMSEu1cyzAyp8DqIe2TcgC0DzKGQC3zyw00OiAsBrM4sCw93qaV3KRx1u3L9xNGSisPd26MRYLITpAVYVMoDlc/nljWsKIPXtd/NUrQAGg3KYlVeGUOhCrisA7XIcxdW4oQm3w0WuQkFbF0J/O+RToX/I/tGr9LOK2qfI8leGbRcm8v4Rc/HgEUWzs3+3LVyPymT1VDoSiMtGKk/CRhxTbVPRLQmBFlnklzd6h6Huc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(66476007)(66946007)(66556008)(4326008)(5660300002)(31686004)(8936002)(52116002)(6666004)(186003)(86362001)(2616005)(110136005)(54906003)(8676002)(36756003)(6486002)(316002)(16526019)(478600001)(83380400001)(2906002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RGlEVzVHbFdYY25WbytXM2JaWkw3REZlZUJwREZtWVBVOTFUZGcwbUpSd09T?=
 =?utf-8?B?RkhVeVhtQkxxaTBkUFY4YjBrWVpBNUgyWGJPWHNmMjkzQ0FoTjRncWc5Wi9t?=
 =?utf-8?B?OC9ETkEwekxLZkpKQ254QnZEYnAyeEx3dGtFaGZIMzV4aDJ4T3hxd0Q4VW4x?=
 =?utf-8?B?NVdvQldCdUtLaHJZTkxyTXUrLzliSkc3Y2M5SlhQZWxWdENvN2NEMXk0VkpJ?=
 =?utf-8?B?blplWUZGWG1aWTJmRmNmbk1STk05SjVoTTc2VkpCUWZ0RjV3dEZZSUtBM1ZX?=
 =?utf-8?B?eTR5SkowbmlBQlZEaGllR2FaUkU3b3FxaGxPS1ZZaFdQVm9sRS9nWXZqN2R0?=
 =?utf-8?B?aE9xL0c0Mjh4eHpSbXZwZ0pwSVJxOFpFaElLMUZuSUVPRndzaVgvbGFON2xP?=
 =?utf-8?B?ZWQ3YWViM1pkc0hiS1VtckFYbUJoWktHRThHUXRPem4yd0FGODhZWFdPOXZQ?=
 =?utf-8?B?Tk1uVGZLN3FEd2pmK0ljQVA4SE5Mb09hYkM1ejJHYVpsQ2ZxVlFTQlZTZUZm?=
 =?utf-8?B?dG5tUy9EejQwbGJvRGRMc3hsRGxUWUxLZ05qaWVEUVplQ1d5U3kvNUNobktE?=
 =?utf-8?B?b1M4d0VqOVdKOUk0K0RSVjlKbzVDYkZtU1N6ZVlnM04rd3hNUkxpVDhSYmor?=
 =?utf-8?B?bGg5OVpjYzN5SER1dU8zWXBxVnF2M2dJVk9vZlM5T0NTeXR6OVNQVzNqaUZN?=
 =?utf-8?B?TU5VbGJ2SGJmUkh4KzE0L3lDYmVDdytFOU1PWTNZMkRQUkVUZkRZVjdmM3JZ?=
 =?utf-8?B?NlIyWi8xOXI3dFdPRzFGT0FXWS9BZUNMVTFVWDdCV0lDd1dWa0dnQ1laeVFw?=
 =?utf-8?B?V2xQQW92NlJLVERRS1Z6T1VDNGhGN3Rla1FiZUFlSk56YlBFS1NURTJzTWNR?=
 =?utf-8?B?YW0yU21EUjYvRE9CQ1FoVno0SnU1N0ljZjBhTVZvaTJDcVNQNUE0b3Z3OHZS?=
 =?utf-8?B?WkplNldhMHp6KzFDMFkzRGtVTmlCS2VtS0ZjVEpxU2lqRjN6cmFrbUdsaUFm?=
 =?utf-8?B?Z3ZmZVhXNmlSZmZmWnZGckhEYWJZNm1CeEk3ZXJFZis3MEptU2JBSnlydERX?=
 =?utf-8?B?ZHJTSThvc09ZdXA0RmViZ3c4VG9HaTk4VGt3d3hBMWVhUWNDMzZXY0dUTEhr?=
 =?utf-8?B?ZExxRWZPQ2laVE1rR0lWY1lVTnNBZVY0bkF4M29Ga01YSlYxRHlSMHRGVXNO?=
 =?utf-8?B?aloydHV6TGRBQnJXaVMrWTdxVEVMM1NxdHBSakZId0hJSTZ6SEJscUdGdUpT?=
 =?utf-8?B?WkpWNHBWSDk0eGY1ckVHQkg1RW1hRnNOSFZSSWprNEQ4bVpONTBkV2czQ3l6?=
 =?utf-8?B?L3pqamlsYWZZdmhETzYreWR0K2JQUWVkeDVHREU5Tld5a3MvNXJiYnNzUDAy?=
 =?utf-8?B?WnNXWXBnaE96a3BNbzVsUG0ycitQWVdSTGJBc0QxM0hYVWdFRUtidTAxSDhh?=
 =?utf-8?Q?sD/5RZs5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 14:59:08.9328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: a02720cf-ee4c-48ac-4131-08d8b2539eea
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKSEViyYhL7JtlR/IeDGacS5Ji6DnF8Dg2l7X/Bq6lShAbBJgDp0bmE66kt/3pQL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDYuMDEuMjEgdW0gMTU6MTggc2NocmllYiBKb3NodWEgQXNodG9uOgo+IFtTTklQXQo+Pj4+
PiBGb3IgVnVsa2FuIHdlIChib3RoIFJBRFYgYW5kIEFNRFZMSykgdXNlIEdUVCBhcyB0aGUgdG90
YWwgc2l6ZS4gCj4+Pj4+IFVzYWdlIGluIG1vZGVybiBnYW1lcyBpcyBlc3NlbnRpYWxseSAiYmlu
ZGxlc3MiIHNvIHRoZXJlIGlzIG5vIHdheSAKPj4+Pj4gdG8gdHJhY2sgYXQgYSBwZXItc3VibWlz
c2lvbiBsZXZlbCB3aGF0IG1lbW9yeSBuZWVkcyB0byBiZSAKPj4+Pj4gcmVzaWRlbnQuIChhbmQg
ZXZlbiB3aXRoIHRyYWNraW5nIGFwcGxpY2F0aW9ucyBhcmUgYWxsb3dlZCB0byB1c2UgCj4+Pj4+
IGFsbCB0aGUgbWVtb3J5IGluIGEgc2luZ2xlIGRyYXcgY2FsbCwgd2hpY2ggd291bGQgYmUgdW5z
cGxpdHRhYmxlIAo+Pj4+PiBhbnl3YXkgLi4uKQo+Pj4+Cj4+Pj4gWWVhaCwgdGhhdCBpcyBhIHJl
YWxseSBnb29kIHBvaW50Lgo+Pj4+Cj4+Pj4gVGhlIGlzc3VlIGlzIHRoYXQgd2UgbmVlZCBzb21l
IGxpbWl0YXRpb24gc2luY2UgMy80IG9mIHN5c3RlbSAKPj4+PiBtZW1vcnkgaXMgd2F5IHRvIG11
Y2ggYW5kIHRoZSBtYXggdGV4dHVyZSBzaXplIHRlc3QgaW4gcGlnbGl0IGNhbiAKPj4+PiBjYXVz
ZSBhIHN5c3RlbSBjcmFzaC4KPj4+Pgo+Pj4+IFRoZSBhbHRlcm5hdGl2ZSBpcyBhIGJldHRlciBP
T00gaGFuZGxpbmcsIHNvIHRoYXQgYW4gYXBwbGljYXRpb24gCj4+Pj4gd2hpY2ggdXNlcyB0byBt
dWNoIHN5c3RlbSBtZW1vcnkgdGhyb3VnaCB0aGUgZHJpdmVyIHN0YWNrIGhhcyBhIAo+Pj4+IG1v
cmUgbGlrZWx5IGNoYW5jZSB0byBnZXQga2lsbGVkLiBDYXVzZSBjdXJyZW50bHkgdGhhdCBpcyBl
aXRoZXIgWCAKPj4+PiBvciBXYXlsYW5kIDooCj4+Pj4KPj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4g
QXMgSSB1bmRlcnN0YW5kIGl0LCB3aGF0IGlzIGJlaW5nIGV4cG9zZWQgcmlnaHQgbm93IGlzIGVz
c2VudGlhbGx5IAo+Pj4gbWF4KHZyYW0gc2l6ZSwgM0dpQikgbGltaXRlZCBieSAzLzR0aHMgb2Yg
dGhlIG1lbW9yeS4gUHJldmlvdXNseSwgCj4+PiBiZWZvcmUgdGhlIHJldmVydCB3aGF0IHdhcyBi
ZWluZyB0YWtlbiB3YXMganVzdCBtYXgoM0dpQiwgMy80dGhzKS4KPj4+Cj4+PiBJZiB5b3UgaGFk
IDwgM0dpQiBvZiBzeXN0ZW0gbWVtb3J5IHRoYXQgc2VlbXMgbGlrZSBhIGJpdCBvZiBhbiBpc3N1
ZSAKPj4+IHRoYXQgY291bGQgZWFzaWx5IGxlYXQgdG8gT09NIHRvIG1lPwo+Pgo+PiBOb3QgcmVh
bGx5LCBhcyBJIHNhaWQgR1RUIGlzIG9ubHkgdGhlIG1lbW9yeSB0aGUgR1BVIGNhbiBsb2NrIGF0
IHRoZSAKPj4gc2FtZSB0aW1lLiBJdCBpcyBwZXJmZWN0bHkgcG9zc2libGUgdG8gaGF2ZSB0aGF0
IGxhcmdlciB0aGFuIHRoZSAKPj4gYXZhaWxhYmxlIHN5c3RlbSBtZW1vcnkuCj4+Cj4+IEluIG90
aGVyIHdvcmRzIHRoaXMgaXMgKm5vdCogdG8gcHJldmVudCB1c2luZyB0byBtdWNoIHN5c3RlbSBt
ZW1vcnksIAo+PiBmb3IgdGhpcyB3ZSBoYXZlIGFuIGFkZGl0aW9uYWwgbGltaXQgaW5zaWRlIFRU
TS4gQnV0IGluc3RlYWQgdG8gaGF2ZSAKPj4gYSByZWFzb25hYmxlIGxpbWl0IGZvciBhcHBsaWNh
dGlvbnMgdG8gbm90IHVzZSB0byBtdWNoIG1lbW9yeSBhdCB0aGUgCj4+IHNhbWUgdGltZS4KPj4K
Pgo+IFdvcnRoIG5vdGluZyB0aGF0IHRoaXMgR1RUIHNpemUgaGVyZSBhbHNvIGFmZmVjdHMgdGhl
IG1lbW9yeSByZXBvcnRpbmcgCj4gYW5kIGJ1ZGdldGluZyBmb3IgYXBwbGljYXRpb25zLiBJZiB0
aGUgdXNlciBoYXMgMUdpQiBvZiB0b3RhbCBzeXN0ZW0gCj4gbWVtb3J5IGFuZCAzR2lCIHNldCBo
ZXJlLCB0aGVuIDNHaUIgd2lsbCBiZSB0aGUgYnVkZ2V0IGFuZCBzaXplIAo+IGV4cG9zZWQgdG8g
YXBwbGljYXRpb25zIHRvby4uLgoKWWVhaCwgdGhhdCdzIGluZGVlZCBwcm9ibGVtYXRpYy4KCj4K
PiAoT24gQVBVcywpIHdlIHJlYWxseSBkb24ndCB3YW50IHRvIGV4cG9zZSBtb3JlIEdUVCB0aGFu
IHN5c3RlbSBtZW1vcnkuIAo+IEFwcHMgd2lsbCBlYXQgaW50byBpdCBhbmQgZW5kIHVwIHN3YXBw
aW5nIG9yIHJ1bm5pbmcgaW50byBPT00gb3IgCj4gc3dhcHBpbmcgKnZlcnkqIHF1aWNrbHkuIChJ
IGltYWdpbmUgdGhpcyBpcyBsaWtlbHkgd2hhdCB3YXMgYmVpbmcgcnVuIAo+IGludG8gYmVmb3Jl
IHRoZSByZXZlcnQuKQoKTm8sIHRoZSBpc3N1ZSBpcyB0aGF0IHNvbWUgYXBwbGljYXRpb25zIHRy
eSB0byBhbGxvY2F0ZSB0ZXh0dXJlcyB3YXkgCmFib3ZlIHNvbWUgcmVhc29uYWJsZSBsaW1pdC4K
Cj4gQWx0ZXJuYXRpdmVseSwgaW4gUkFEViBhbmQgb3RoZXIgdXNlciBzcGFjZSBkcml2ZXJzIGxp
a2UgQU1EVkxLLCB3ZSAKPiBjb3VsZCBsaW1pdCB0aGlzIHRvIHRoZSBzeXN0ZW0gbWVtb3J5IHNp
emUgb3IgMy80dGhzIG91cnNlbHZlcy4gCj4gQWx0aG91Z2ggdGhhdCdzIGtpbmRhIGdyb3NzIGFu
ZCBJIGRvbid0IHRoaW5rIHRoYXQncyB0aGUgY29ycmVjdCBwYXRoLi4uCgpPaywgbGV0IG1lIGV4
cGxhaW4gZnJvbSB0aGUgb3RoZXIgc2lkZTogV2UgaGF2ZSB0aGlzIGxpbWl0YXRpb24gYmVjYXVz
ZSAKb3RoZXJ3aXNlIHNvbWUgdGVzdHMgbGlrZSB0aGUgbWF4aW11bSB0ZXh0dXJlIHNpemUgdGVz
dCBmb3IgT3BlbkdMIApjcmFzaGVzIHRoZSBzeXN0ZW0uIEFuZCB0aGlzIGlzIGluZGVwZW5kZW50
IG9mIHlvdXIgc3lzdGVtIGNvbmZpZ3VyYXRpb24uCgpXZSBjb3VsZCBvZiBjb3Vyc2UgYWRkIGFu
b3RoZXIgbGltaXQgZm9yIHRoZSB0ZXh0dXJlIHNpemUgaW4gCk9wZW5HTC9SQURWL0FNRFZMSywg
YnV0IEkgYWdyZWUgdGhhdCB0aGlzIGlzIHJhdGhlciBhd2t3YXJkLgoKPj4+Cj4+PiBBcmUgeW91
IGhpdHRpbmcgb24gc29tZXRoaW5nIHNtYWxsZXIgdGhhbiAzLzR0aHMgcmlnaHQgbm93PyBJIAo+
Pj4gcmVtZW1iZXIgdGhlIHNvdXJjZSBjb21taXQgbWVudGlvbmVkIHRoZXkgb25seSBoYWQgMUdp
QiBvZiBzeXN0ZW0gCj4+PiBtZW1vcnkgYXZhaWxhYmxlLCBzbyB0aGF0IGNvdWxkIGJlIHBvc3Np
YmxlIGlmIHlvdSBoYWQgYSBjYXJ2ZW91dCBvZiAKPj4+IDwgNzg2TWlCLi4uCj4+Cj4+IFdoYXQg
ZG8geW91IG1lYW4gd2l0aCB0aGF0PyBJIGRvbid0IGhhdmUgYSB0ZXN0IHN5c3RlbSBhdCBoYW5k
IGZvciAKPj4gdGhpcyBpZiB0aGF0J3Mgd2hhdCB5b3UgYXJlIGFza2luZyBmb3IuCj4KPiBUaGlz
IHdhcyBtYWlubHkgYSBxdWVzdGlvbiB0byB3aG9ldmVyIGRpZCB0aGUgcmV2ZXJ0LiBUaGUgcXVl
c3Rpb24gdG8gCj4gZmluZCBvdXQgc29tZSBleHRyYSBpbmZvIGFib3V0IHdoYXQgdGhleSBhcmUg
dXNpbmcgYXQgdGhlIHRpbWUuCgpZb3UgZG9uJ3QgbmVlZCBhIHNwZWNpZmljIHN5c3RlbSBjb25m
aWd1cmF0aW9uIGZvciB0aGlzLCBqdXN0IHRyeSB0byBydW4gCnRoZSBtYXggdGV4dHVyZSBzaXpl
IHRlc3QgaW4gcGlnbGl0LgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+IC0gSm9zaGllIPCfkLji
nKgKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
