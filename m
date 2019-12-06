Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C82C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 08:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E2320659
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 08:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E2320659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E84836EC63;
	Fri,  6 Dec 2019 08:47:59 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680089.outbound.protection.outlook.com [40.107.68.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5416EC63
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 08:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8Kk9nNIBMbQSThMOjhE/8fenjoEoazL5vh+usvLMaw8BprEaAXU1AMX1W8+sEvO4L4eo60wY5O76aeFSRNP6jXcZZpaasRL/a286TugzAMJUG1+FXGSvUfinOvvmQwGm8x5SKUa0msraEaQTG77bPgavTiPMKvnrzvrM95nltmbL+mzrURqRSSANZbozQqIGu+Fp8FSKD77EmHRF2S+bI7O6Dgf4+6c+DZtUtACzn5knJA6tTGkGivXSwP9yLxWIWsruQl6nR6+wI6hLNCB/U1A62w9hi+1sWWGTyNfktiOxDUvSW1Ho+7h3KQfW/67yMyTD8Vqab+tchqDl2IzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7fvAU4mNTS0Heqeowuyk58VDqdUnpX36bJy9rUGakw=;
 b=PQI/uWrdmlGVyaHxIcr9LBZsYGdfLh8BxL/NR/80ssfxqoMGZoophQNXinr6DkMZ8S0CbGBYuTynIVhL7bb1JIMk9YtjBMU78Ewp+iXmubPyfpY7r4I7jAEpGZYf3iEr5blQsW+4JnAJE/Y0zQ0h9vyobaLSz2z4ybQAv7qIFN9GOs18t4VyPoPsikiXAvKeuVf+7i/Gozfx11wNSsTAIQUEUzh/gFNa26SFPsZd6ri94W0tXD+nhBxgWC9VMosowJ3jhIttF6m8iT5irkVFhM5JR6hkX6TOHwha+lsRbhndDSvE2xX25aaRAk8CJUWySFGrWIICLuq0lND/9Freqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1323.namprd12.prod.outlook.com (10.168.237.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Fri, 6 Dec 2019 08:47:56 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2495.026; Fri, 6 Dec 2019
 08:47:56 +0000
Subject: Re: [PATCH 2/3] tests/amdgpu: Fix unused function warning
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Tuikov, Luben"
 <Luben.Tuikov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <f57d33f459df0c733ef108b2beb889e844450542.1575606273.git.luben.tuikov@amd.com>
 <ef63cf555221724a49c7f926c57786cae559fe77.1575606273.git.luben.tuikov@amd.com>
 <BYAPR12MB2806E067D3B177DCE07A3AA0F15F0@BYAPR12MB2806.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <054751d9-6a54-c15b-5066-7187125b06ea@amd.com>
Date: Fri, 6 Dec 2019 09:47:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <BYAPR12MB2806E067D3B177DCE07A3AA0F15F0@BYAPR12MB2806.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::19) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a0743f52-9511-4fea-bdc4-08d77a28fd50
X-MS-TrafficTypeDiagnostic: DM5PR12MB1323:|DM5PR12MB1323:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13233B3B1D23E3480593A6D6835F0@DM5PR12MB1323.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0243E5FD68
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(189003)(199004)(13464003)(6506007)(53546011)(76176011)(23676004)(52116002)(11346002)(2616005)(65956001)(186003)(14444005)(5660300002)(6666004)(305945005)(2906002)(8676002)(81156014)(81166006)(6486002)(31686004)(8936002)(66556008)(66476007)(66946007)(14454004)(6512007)(4326008)(50466002)(86362001)(478600001)(966005)(31696002)(229853002)(45080400002)(230700001)(316002)(110136005)(58126008)(99286004)(36756003)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1323;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MM9Px/MZQ5Udjlvl5wQ52SvqwFrRQiPfwTusEUJxqF2iT3VU1I4GAuJ+ZzDyWyyNmnV5Q1OL6ZZb9R4H5vcERlpKulmYysJ+0zR9NDJL2R5oaI5HmFoZHp4/zjf0fwTC+m6dgRjuhhfZQhq6hgAsezGwDt9fkQb5OFxvlE0ghC86SZh0i4ytRQB3TsV+9y+rZFBXxCAokG8RFFPyBV9zku5px5acr1uHdFnDLMP04al18ASycaqkbJPdc2YCFcq2Z99UVe3nH+R7aLut9bu8XGteKi6Err0Df/Kwv2ViWynK1KTBjXMgQbZG2cLQU1cDYo5nlffWRifRs7pQKggBHymyxmq8643apiGKlDLwFSVpvJDtcDzrllNIg7LhiQHCMnbIighBYnYIK5JeBp8iydVjp4h/ayY0jNGKtEhzpyGwaYi8cBz8FS1BCWwAOOOEStPBiNhScHIccRPFxUqp3mPNhCx1HnwmpyXLZK4us7gm8djnj8qcBr9sP6U4Kv9UZOJGk6SII122rLFlKsUhXE+I9FeO6YIUnoG7Ml4iVaw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0743f52-9511-4fea-bdc4-08d77a28fd50
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 08:47:56.6690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tmU0cHeJoFmxmVAAtjoyhe5/4mX9C/WhFeoafTiC8p6wPHt8ZDAi8BEehBsL/9Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1323
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7fvAU4mNTS0Heqeowuyk58VDqdUnpX36bJy9rUGakw=;
 b=KPHlh7TPdBkiwdBF1BcVHnLvOPGOq7BnGUDO49S/jWZLVJSkrxE2u2N8uVqZApy/D6kuWF/X83T4/f6WU9fMxNmuD9hMj8qNBWjpZYu7MN8E6bShUAeGFjkZu3/+YZpYLb7+srRNFGC/3B2ON6/G3tFhAE2+6164679y4pzgZzs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDYuMTIuMTkgdW0gMDk6MDMgc2NocmllYiBDaGVuLCBHdWNodW46Cj4gW0FNRCBPZmZpY2lh
bCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQo+Cj4KPgo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEx1YmVuIFR1aWtvdgo+IFNlbnQ6IEZyaWRh
eSwgRGVjZW1iZXIgNiwgMjAxOSAxMjozMiBQTQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBUdWlrb3YsIEx1YmVuIDxMdWJlbi5UdWlrb3ZAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0
aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+Cj4gU3ViamVjdDogW1BBVENIIDIvM10gdGVz
dHMvYW1kZ3B1OiBGaXggdW51c2VkIGZ1bmN0aW9uIHdhcm5pbmcKPgo+IFRoaXMgcGF0Y2ggZml4
ZXM6Cj4gLVd1bnVzZWQtZnVuY3Rpb24KPgo+IFNpZ25lZC1vZmYtYnk6IEx1YmVuIFR1aWtvdiA8
bHViZW4udHVpa292QGFtZC5jb20+Cj4gLS0tCj4gICB0ZXN0cy9hbWRncHUvcmFzX3Rlc3RzLmMg
fCA0ICsrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0cy9hbWRncHUvcmFzX3Rlc3RzLmMgYi90ZXN0cy9hbWRn
cHUvcmFzX3Rlc3RzLmMgaW5kZXggZDcxNGJlNzMuLjRjMzk1MzgyIDEwMDY0NAo+IC0tLSBhL3Rl
c3RzL2FtZGdwdS9yYXNfdGVzdHMuYwo+ICsrKyBiL3Rlc3RzL2FtZGdwdS9yYXNfdGVzdHMuYwo+
IEBAIC03MDksNiArNzA5LDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Jhc19kaXNhYmxlX3Rlc3Qo
dm9pZCkKPiAgIAl9Cj4gICB9Cj4gICAKPiArI2lmZGVmIEFNREdQVV9SQVNfVEVTVAo+IFtHdWNo
dW5dTWF5YmUgaXQncyBtb3JlIGZpbmUgdG8gbmFtZSBpdCB0byBBTURHUFVfUkFTX0VOQUJMRV9U
RVNUPyBBTURHUFVfUkFTX1RFU1QgaXMgb25lIG1vcmUgZ2VuZXJpYyBtYWNybywgd2hpY2ggY292
ZXJzIGFsbCBzdWItdGVzdHMgbGlrZSBxdWVyeS9pbmplY3QvZW5hYmxlL2Rpc2FibGUgdGVzdCAu
CgpXZWxsIG15IHF1ZXN0aW9uIGlzIG1vcmUgd2h5IGRvIHdoeSBkbyB3ZSBoYXZlIHRoaXMgZGVm
aW5lIGluIHRoZSBmaXJzdCAKcGxhY2U/CgpUZXN0IHNob3VsZCBhbHdheXMgY29tcGlsZSByZWdh
cmRsZXNzIGlmIHRoZSBrZXJuZWwgc3VwcG9ydHMgdGhlIGZlYXR1cmUgCm9yIG5vdC4KClJlZ2Fy
ZHMsCkNocmlzdGlhbi4KCj4KPiAgIHN0YXRpYyB2b2lkIGFtZGdwdV9yYXNfZW5hYmxlX3Rlc3Qo
dm9pZCkgIHsKPiAgIAlpbnQgaTsKPiBAQCAtNzE3LDYgKzcxOCw3IEBAIHN0YXRpYyB2b2lkIGFt
ZGdwdV9yYXNfZW5hYmxlX3Rlc3Qodm9pZCkKPiAgIAkJYW1kZ3B1X3Jhc19mZWF0dXJlc190ZXN0
KDEpOwo+ICAgCX0KPiAgIH0KPiArI2VuZGlmCj4gICAKPiAgIHN0YXRpYyB2b2lkIF9fYW1kZ3B1
X3Jhc19pcF9pbmplY3RfdGVzdChjb25zdCBzdHJ1Y3QgcmFzX2luamVjdF90ZXN0X2NvbmZpZyAq
aXBfdGVzdCwKPiAgIAkJCQkJdWludDMyX3Qgc2l6ZSkKPiBAQCAtODgxLDcgKzg4Myw3IEBAIENV
X1Rlc3RJbmZvIHJhc190ZXN0c1tdID0gewo+ICAgCXsgInJhcyBxdWVyeSB0ZXN0IiwJYW1kZ3B1
X3Jhc19xdWVyeV90ZXN0IH0sCj4gICAJeyAicmFzIGluamVjdCB0ZXN0IiwJYW1kZ3B1X3Jhc19p
bmplY3RfdGVzdCB9LAo+ICAgCXsgInJhcyBkaXNhYmxlIHRlc3QiLAlhbWRncHVfcmFzX2Rpc2Fi
bGVfdGVzdCB9LAo+IC0jaWYgMAo+ICsjaWZkZWYgQU1ER1BVX1JBU19URVNUCj4gICAJeyAicmFz
IGVuYWJsZSB0ZXN0IiwJYW1kZ3B1X3Jhc19lbmFibGVfdGVzdCB9LAo+ICAgI2VuZGlmCj4gICAJ
Q1VfVEVTVF9JTkZPX05VTEwsCj4gLS0KPiAyLjI0LjAuMTU1LmdkOWY2ZjNiNjE5Cj4KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFp
bGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL25hbTEx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0
cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRh
PTAyJTdDMDElN0NndWNodW4uY2hlbiU0MGFtZC5jb20lN0M3NDdjNmRiMzZkMWE0Y2JmNTM2YzA4
ZDc3YTA1NTUyYiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2
MzcxMTIwMzU2NzIxNTUxMTQmYW1wO3NkYXRhPTl4VGVOc0M1YkxQRFhvZ3hWdUZuSmhSbHJDd0l1
RDlGbTUyWDAyM3dWeDQlM0QmYW1wO3Jlc2VydmVkPTAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
