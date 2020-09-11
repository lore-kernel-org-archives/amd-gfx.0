Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BE9C43461
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 17:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF7E21D79
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 17:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eApM+xtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF7E21D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 555D76EACA;
	Fri, 11 Sep 2020 17:57:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BA316EACA
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 17:57:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ije0HcnhoBE3Z26yXGDNMByMbzwktrUYreD+Ab2cdiqkEA/qyfZ3JzTgtriNlC9j6MwYqaa3W2daJqmjYLvhdXPxcaPLR8IgcXYLrcLC6UK5rj8lp5WvVg87EL2mGPO5AiYsxXQ0U13iWgmJ9+N4rKb9M3vOdVBbMBH5w6Qi9Qdl5cEP61PpJaVPgmW7xAMwNkdQGb7bhMsM6Dd4E/A7nI+84RhAAKmcyicqcKrAIQiAmp62uh1bEc0mLdAu4LfzrNTY+4CENC+M5NKL+e/fuJuBHaoHdh0u6acM1kqMAZiERT0JVZZFZeoGM5KYfA71c3ZeTO4blXiLHuaM+56AOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wco6vOKutg7HnePlINtfm3RRNzWkjv38rG7SK3zzJ5k=;
 b=a9FBzexJ1k+XpmOOQRcTwROqSnWqfux/hbrcPKEczSx5A6EU1hBCwYUtyEnI35NYroFKMPKEVs3n6/z9dejD0J0rdVcrP721/cCcenTb6j4fPTTZy03qPt8jLx4BnYbTd2uulYx76GUwUAuvt9ZRkl2rlSK/QxwQXsigE+egWSJNrv/M/5YnmoHO7neX1cyUCKf0ipk4gtL6Ou9gEZ1Nhnw78HNACtFUunxQ9hdcNkznJ4bilsUKTE1T6AKjLt7cpS9XxvilFQWhLBG0zd+UWQmjeC0ftawYLvcOoIRMiLW+oFea5QvhNfkImbE8DD2DGLic1Q20tBxuVAvGmrUjfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wco6vOKutg7HnePlINtfm3RRNzWkjv38rG7SK3zzJ5k=;
 b=eApM+xtEwIpL+XBXYtYfHgg48na9ts9GJXtlS/C3iECUT1xEqaf3AF1eGHy4hP84zIXsAAB4oddRxHVIcrhL8szwQJpf1x6Ts9a3qjOL+nbzdOznEEVw0PuMiF3W1RFiTZ62+h57kFpifsovKbNtKA0A/S3a7pLX6MTqM0ZP658=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2541.namprd12.prod.outlook.com (2603:10b6:802:24::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 11 Sep
 2020 17:57:43 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 17:57:43 +0000
Subject: Re: [PATCH] drm/amdgpu: Enable SDMA utilization for Arcturus
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200911162711.10645-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2af58112-a675-a442-3ec5-55acb51a907f@amd.com>
Date: Fri, 11 Sep 2020 13:57:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200911162711.10645-1-mukul.joshi@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::14) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTXPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Fri, 11 Sep 2020 17:57:42 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ab66c3c-f705-4291-ef93-08d8567c2e7a
X-MS-TrafficTypeDiagnostic: SN1PR12MB2541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB254175D2E4D525725701AC5792240@SN1PR12MB2541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWiA7Y1czN6k2J6kTvWxk71lBjZs1IbHMcVHuawftnATTtXZuVOmGSJGbddzc7Lh3me2nUBSIeofVGVYo7B3dw8426AZpt5wci2t4dqdOJxpZrSTHqaHgG9SYO+hANyk+0p6WCd9rSIRemkqQe4TWIvaE2zXpA2OnimFCIDT0n0G+NKn3MTg9Qn1K50eC7CH4r58+viyYdJpAqgg94dA8t5qryTxiBpRo5YZiZAGoDTvFrLl7Qpo8vgeBL0MclgyPqG65l+5FwOwKwDL91pNw5jzssNSmec1t2O22hUZLlmTLNfXtu7EGR0QGzp1T7JaVpN4cwr7v3uVoCV8XuMvhjsGKymI1SNOmKhHiQFBRQ3NR7k1ljuhYOoybz7MXGoX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(16526019)(83380400001)(16576012)(8676002)(2906002)(66476007)(956004)(6486002)(186003)(44832011)(52116002)(31686004)(2616005)(66556008)(66946007)(36756003)(86362001)(316002)(478600001)(5660300002)(31696002)(26005)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uTLVFG+dRVJiEzTJkgLs1FKd8EBjRHZZGfMhi+F6lsqAiwmVYio89SiHayeZHivVT2jAmK9A31B+D9u5QpDsF6+GNaMtobZYqIeO/7d4jYhAYSV3rvF7wNQLftYVVDUpvcuDOGC34nzmgT8vLBLdQb9MNFeauTWq+Ba8f0GOXtdMgMZMlH7hNySnNPpjaz+IVEcJDmSrU3qhriyOvlEoBAz3XLn24pVhjOQNmiw4K5lnnjDMBMM4AFiGylLXAGSVLJK1muT3q7YU7uBdKdzff3SDpuDI9G3aJDd3+9FTb8yCHxPwnRN+JoeeEgqsSy7SxZ23Wbs0QW6abNkpWK1eh1+enXSHwTteNgT8LGkHemlfbCy3JjQz3i9fkAX2PbrvMh5OjX+wfC8wvnCSCjQlRlaAHwhyRKbSIkqdb4eIsOMhv6CZJUuHsfnrrLmraJ30UanmCoWCv3a71YOafJsMBIDyCbRlnecbqy2BJiTyZz48wauXi/IeRCvudPNCUSguOn/To5rxBeDzhetRGqF4Ul2pOqnZ8/n38vNQgOitRkhbD1eECWU+xDzE+srQfpZyzhsE82nBXnpXPVIhO3Zuyce57jbnzboUUDeDQZquCGOmnn1E/on9MrrSOsQ8WFw2RaqC+8Yh+pldgAV2H1bmOg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab66c3c-f705-4291-ef93-08d8567c2e7a
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 17:57:43.1135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7FpUnv1wZlNXFiP0nRsIYxGPfLWL4PiHEJGhRiE4rvglmgLzYhBuO/LKGhTAnk1LLRieQCKZh4x9ievEjPIig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2541
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMC0wOS0xMSB1bSAxMjoyNyBwLm0uIHNjaHJpZWIgTXVrdWwgSm9zaGk6Cj4gU0RNQSB1
dGlsaXphdGlvbiBjYWxjdWxhdGlvbnMgYXJlIGVuYWJsZWQvZGlzYWJsZWQgYnkKPiB3cml0aW5n
IHRvIFNETUF4X1BVQl9EVU1NWV9SRUcyIHJlZ2lzdGVyLiBDdXJyZW50bHksCj4gZW5hYmxlIHRo
aXMgb25seSBmb3IgQXJjdHVydXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNdWt1bCBKb3NoaSA8bXVr
dWwuam9zaGlAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2Rt
YV92NF8wLmMgfCAxMCArKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8w
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYwo+IGluZGV4IDg1NmM1
MDM4NmM4Ni4uYzc2NGMyN2JhODZkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NkbWFfdjRfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2Rt
YV92NF8wLmMKPiBAQCAtMTA2Myw2ICsxMDYzLDE2IEBAIHN0YXRpYyB2b2lkIHNkbWFfdjRfMF9j
dHhfc3dpdGNoX2VuYWJsZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBlbmFibGUp
Cj4gIAkJCVdSRUczMl9TRE1BKGksIG1tU0RNQTBfUEhBU0UyX1FVQU5UVU0sIHBoYXNlX3F1YW50
dW0pOwo+ICAJCX0KPiAgCQlXUkVHMzJfU0RNQShpLCBtbVNETUEwX0NOVEwsIGYzMl9jbnRsKTsK
PiArCj4gKwkJLyoKPiArCQkgKiBFbmFibGUgU0RNQSB1dGlsaXphdGlvbi4gSXRzIG9ubHkgc3Vw
cG9ydGVkIG9uCj4gKwkJICogQXJjdHVydXMgZm9yIHRoZSBtb21lbnQgYW5kIGZpcm13YXJlIHZl
cnNpb24gMTQKPiArCQkgKiBhbmQgYWJvdmUuCj4gKwkJICovCj4gKwkJaWYgKChhZGV2LT5hc2lj
X3R5cGUgPT0gQ0hJUF9BUkNUVVJVUykgJiYKPiArCQkJKGFkZXYtPnNkbWEuaW5zdGFuY2VbaV0u
ZndfdmVyc2lvbiA+IDEzKSkgewoKVGhlcmUgYXJlIHNvbWUgcmVkdW5kYW50IHBhcmVudGhlc2Vz
IGluIHRoZSBjb25kaXRpb24uIFRoZSBjdXJseSBicmFjZXMKYXJlIG5vdCBuZWVkZWQgZm9yIGEg
c2luZ2xlIHN0YXRlbWVudCBpbnNpZGUgdGhlICJpZiIuIEFsc28sIHdyaXRlID49CjE0LCB0aGF0
IGNvcnJlbGF0ZXMgYmV0dGVyIHdpdGggdGhlIHN0YXRlbWVudCBpbiB0aGUgY29tbWVudDoKCglp
ZiAoYWRldi0+YXNpY190eXBlID09IENISVBfQVJDVFVSVVMgJiYKCSAgICBhZGV2LT5zZG1hLmlu
c3RhbmNlW2ldLmZ3X3ZlcnNpb24gPj0gMTQpCgkJV1JFRzMyX1NETUEoaSwgbW1TRE1BMF9QVUJf
RFVNTVlfUkVHMiwgZW5hYmxlKTsKCklmIHRoaXMgZmVhdHVyZSBpcyBvbmx5IGF2YWlsYWJsZSBv
biBBcmN0dXJ1cywgd2Ugc2hvdWxkIG1ha2UgdGhlCmNyZWF0aW9uIG9mIHRoZSBzeXNmcyBlbnRy
aWVzIGNvbmRpdGlvbmFsIGFzIHdlbGwuIFlvdSBjYW4gZG8gdGhhdCBpbiBhCmZvbGxvdy11cCBj
aGFuZ2UuCgpSZWdhcmRzLArCoCBGZWxpeAoKPiArCQkJV1JFRzMyX1NETUEoaSwgbW1TRE1BMF9Q
VUJfRFVNTVlfUkVHMiwgZW5hYmxlKTsKPiArCQl9Cj4gIAl9Cj4gIAo+ICB9Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
