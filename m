Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62561C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 11:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2405F2078B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 11:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DrYDvT1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2405F2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B61C46E33F;
	Thu, 20 Aug 2020 11:45:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 933126E33F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 11:45:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RelYxU9B9pMcoTaWfG/NKhK2vALNMEutO9oD42asB3ry7gr9WAHNhosGHhgGa2HzWcHJlB8lo19UkM5wApy9PM5dSUwvLMm86FmhNLpA6iW1nfTUqsN51aZOtksQ4CtKqmvfK58EEjkQUoVa2C8oN9L7tu+XURyQX40dpXRjS/Vl3WvKva7BAda9dYySb10shAGrc6jpAlpCIts2YpXLcNtkbcElQQEoXx9ppmQvqvTZJ7UDocaZyyJICueZ6h5ZzrflgmKqMeg6zFRCsac0h17QUn+OxE4lNrr85HhLhwyYuwjp/oznveA4iF+FOQmfrC8hjRVg7ESMjiBr0wZOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhIlEgtonqovx1JzcV/WZxUdn0H36zEyr1/ABJugcSg=;
 b=oTGJPRsJbVX4fGB0FmcFGvkhoS7v33/QAJI7rUb3CEui2TqRhZDp92dB4iVh+VfXsFfcmf3D2pUV4+45yrW12D5kVgykLhYQ7ofFSBOhn+addDSzcJWMC+3V8nrdjPISk54sq3X1axj1FgzBo1qkHix6IbbdDjkAlSXa95v+JCI+/NXOWpQTAxA7lDpTUPH7z4pA0YBGH8W4y5zysrjwHKSmR29ko8PU0s3LadvumdhwitxmC4ViyMhYKGjLR/ld2lPypdis5+5WgbvKNRFouRM44Dy76koWpOwPNpSCBOmzLuQXZg275RZUnfcV3MDolVaHUIcp/jj1Ik1nM0L0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhIlEgtonqovx1JzcV/WZxUdn0H36zEyr1/ABJugcSg=;
 b=DrYDvT1O4KBW929dTSAT2az5+tOsj6FgSPv1hU0lGe+/L09g0C5pPkJJGnHBf/xYTQnW39TAY3rp3r79dGN5HIVSGOcfFrS5IUD7sY+1nVDn+s/wfI1CKybN5gOv15I0k1tAak0SInbi69+ZhgCh4t51ATEiACeRCDX57KWp8Vg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3998.namprd12.prod.outlook.com (2603:10b6:208:16d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 20 Aug
 2020 11:45:38 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3283.028; Thu, 20 Aug 2020
 11:45:38 +0000
Subject: Re: [PATCH v6] drm/amdgpu: add new trace event for page table update
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200820103823.3599-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <95f8b1c6-74ff-a6f7-b04c-2eb9b354df2f@amd.com>
Date: Thu, 20 Aug 2020 13:45:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200820103823.3599-1-shashank.sharma@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0142.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::47) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR01CA0142.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 11:45:37 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3fd7f0f8-72ca-44cf-bc35-08d844fe8eb1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3998DC2E24C66B442CB220BF835A0@MN2PR12MB3998.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icd3wavxlpvVJ/1XId0+hwVHNV/TlZMXa+PqRljUPlBYbesrVjBJEwqebZYnq7T6cybFYnaNwssjBhKYDkMn1W5Yvi98dgd1vjkkeA9hkC4UBIsyx9WtRtC+May6ZZntGbxf/1bHDPctOBfavMbzwFlFRqFTvs9aXaxaRS1NGXg27FR2DSN2DlbS+t+xkeJRbmJDUeSJJc2OmKvrXToJ9bHskgwRY/YVLYQNV2yHD5nGHR7C9vTKcCFTrGC/m1ozpY9Fa9Hk9leleHrPm08XHrdNnndaBf80mey55HiwJU0VdX+JopRMOTkICX7c7Q1Nvnw8oqs4oSXLR1Ih8UkQFzjovOxcw9EqhLolfen1oBur05mLh4cmX+AmUIb+AfGs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(6486002)(5660300002)(316002)(15650500001)(6666004)(86362001)(16526019)(52116002)(31696002)(66574015)(36756003)(2616005)(186003)(478600001)(4326008)(2906002)(83380400001)(8676002)(66476007)(31686004)(8936002)(66946007)(66556008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3EmfMNwoWOuASvOF6jL//3cjuLkJbYy2ZguytLZ880DBvwISoZ3edq8ePa5fxgciZxlCBMnlW3FY6dZ14oKUgdxNHRf++njC86Avei5wdnV7u9Pj1uNLq59JXgBn5W1qGy9X0OEadJHUYErq7/VXvZZregsLGCG6wsivS0wc9xcXhPaBQAahjISzrgq5s6nYiJ/L5WMdo5OPlgBTKxfSjzh42EUYzjsvlp8cwHgVZOZpXX1ei8kRnevZdvhuuVFzAMyx/Cp2lDElvxPLvGKlPaj8i9mEpZOtt1+3Kxn8CxrbfIgFgxZ6BFNZnMUXEpCQL1IthIUwb5Rgt8iVHLiDatGsv3SvURVzu3FBR4rbjGxBw+BWZKoEIbRSkAlwSAhrwLfJ+UaG5gJk+2YHAgop2lJEzIJzRzEIfrLbZZa8tF6qaLSNMcRJMRZyEBxcWyEuuXHibwJmURzWG8/9Lt5BZbp9pfhJikmNFY7KNJDV7jpy+zQd3OW5ZxtfmLVuLb0DSgWU8Ill1hX9aZRQTAHpmxO8ODzhdPC+IY0jfMeBDk6A6E44jXYM1HFvdbh153i3b2Tujftg6ILGdmzJdRkQj4xaEnc6sk+k7zlC2iSMXoqui27oOkB0StCuje2cckbS0P2uOwhYsVuC0IIbNd6YFhVq3mzy4t6TzRwFqHrYQKKCj+3dEoHHq0+h/zPaG5ZU6qrdmJQhADfigfb3PwWqpA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd7f0f8-72ca-44cf-bc35-08d844fe8eb1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 11:45:38.3087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXofjQ1v4s0P9Qr10xQYNhl8vIGoGJagg5wTcmATgHtPxviMjey+bxLgelCH/c0j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3998
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAuMDguMjAgdW0gMTI6Mzggc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4gVGhpcyBwYXRj
aCBhZGRzIGEgbmV3IHRyYWNlIGV2ZW50IHRvIHRyYWNrIHRoZSBQVEUgdXBkYXRlCj4gZXZlbnRz
LiBUaGlzIHNwZWNpZmljIGV2ZW50IHdpbGwgcHJvdmlkZSBpbmZvcm1hdGlvbiBsaWtlOgo+IC0g
c3RhcnQgYW5kIGVuZCBvZiB2aXJ0dWFsIG1lbW9yeSBtYXBwaW5nCj4gLSBIVyBlbmdpbmUgZmxh
Z3MgZm9yIHRoZSBtYXAKPiAtIHBoeXNpY2FsIGFkZHJlc3MgZm9yIG1hcHBpbmcKPgo+IFRoaXMg
d2lsbCBiZSBwYXJ0aWN1bGFybHkgdXNlZnVsIGZvciBtZW1vcnkgcHJvZmlsaW5nIHRvb2xzCj4g
KGxpa2UgUk1WKSB3aGljaCBhcmUgbW9uaXRvcmluZyB0aGUgcGFnZSB0YWJsZSB1cGRhdGUgZXZl
bnRzLgo+Cj4gVjI6IEFkZGVkIHBoeXNpY2FsIGFkZHJlc3MgbG9va3VwIGxvZ2ljIGluIHRyYWNl
IHBvaW50Cj4gVjM6IHN3aXRjaCB0byB1c2UgX19keW5hbWljX2FycmF5Cj4gICAgICBhZGRlZCBu
cHRlcyBpbnQgdGhlIFRQcHJpbnQgYXJndW1lbnRzIGxpc3QKPiAgICAgIGFkZGVkIHBhZ2Ugc2l6
ZSBpbiB0aGUgYXJnIGxpc3QKPiBWNDogQWRkcmVzc2VkIENocmlzdGlhbidzIHJldmlldyBjb21t
ZW50cwo+ICAgICAgYWRkIHN0YXJ0L2VuZCBpbnN0ZWFkIG9mIHNlZwo+ICAgICAgdXNlIGluY3Ig
aW5zdGVhZCBvZiBwYWdlX3N6IHRvIGJlIGFjY3VyYXRlCj4gVjU6IEFkZHJlc3NlZCBDaHJpc3Rp
YW4ncyByZXZpZXcgY29tbWVudHM6Cj4gICAgICBhZGQgcGlkIGFuZCB2bSBjb250ZXh0IGluZm9y
bWF0aW9uIGluIHRoZSBldmVudAo+IFY2OiBSZS1zZXF1ZW5jZSB0aGUgdmFyaWFibGVzIChwdXQg
cGlkIGFuZCBjdHhfaWQgZmlyc3QpCj4KPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFNoYXNoYW5rIFNoYXJtYSA8c2hhc2hhbmsuc2hh
cm1hQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV90cmFjZS5oIHwgNDMgKysrKysrKysrKysrKysrKysrKysrKysKPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jICAgIHwgMTEgKysrKy0tCj4gICAyIGZpbGVzIGNoYW5n
ZWQsIDUyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+IGluZGV4IDYzZTczNGExMjVmYi4uODJjMmU3MGE2
YTcxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFj
ZS5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPiBA
QCAtMzIxLDYgKzMyMSw0OSBAQCBERUZJTkVfRVZFTlQoYW1kZ3B1X3ZtX21hcHBpbmcsIGFtZGdw
dV92bV9ib19jcywKPiAgIAkgICAgVFBfQVJHUyhtYXBwaW5nKQo+ICAgKTsKPiAgIAo+ICtUUkFD
RV9FVkVOVChhbWRncHVfdm1fdXBkYXRlX3B0ZXMsCj4gKwkgICAgVFBfUFJPVE8oc3RydWN0IGFt
ZGdwdV92bV91cGRhdGVfcGFyYW1zICpwLAo+ICsJCSAgICAgdWludDY0X3Qgc3RhcnQsIHVpbnQ2
NF90IGVuZCwKPiArCQkgICAgIHVuc2lnbmVkIGludCBucHRlcywgdWludDY0X3QgZHN0LAo+ICsJ
CSAgICAgdWludDY0X3QgaW5jciwgdWludDY0X3QgZmxhZ3MsCj4gKwkJICAgICBwaWRfdCBwaWQs
IHVpbnQ2NF90IHZtX2N0eCksCj4gKwlUUF9BUkdTKHAsIHN0YXJ0LCBlbmQsIG5wdGVzLCBkc3Qs
IGluY3IsIGZsYWdzLCBwaWQsIHZtX2N0eCksCj4gKwlUUF9TVFJVQ1RfX2VudHJ5KAo+ICsJCQkg
X19maWVsZCh1NjQsIHN0YXJ0KQo+ICsJCQkgX19maWVsZCh1NjQsIGVuZCkKPiArCQkJIF9fZmll
bGQodTY0LCBmbGFncykKPiArCQkJIF9fZmllbGQodW5zaWduZWQgaW50LCBucHRlcykKPiArCQkJ
IF9fZmllbGQodTY0LCBpbmNyKQo+ICsJCQkgX19maWVsZChwaWRfdCwgcGlkKQo+ICsJCQkgX19m
aWVsZCh1NjQsIHZtX2N0eCkKPiArCQkJIF9fZHluYW1pY19hcnJheSh1NjQsIGRzdCwgbnB0ZXMp
Cj4gKwkpLAo+ICsKPiArCVRQX2Zhc3RfYXNzaWduKAo+ICsJCQl1bnNpZ25lZCBpbnQgaTsKPiAr
Cj4gKwkJCV9fZW50cnktPnN0YXJ0ID0gc3RhcnQ7Cj4gKwkJCV9fZW50cnktPmVuZCA9IGVuZDsK
PiArCQkJX19lbnRyeS0+ZmxhZ3MgPSBmbGFnczsKPiArCQkJX19lbnRyeS0+aW5jciA9IGluY3I7
Cj4gKwkJCV9fZW50cnktPm5wdGVzID0gbnB0ZXM7Cj4gKwkJCV9fZW50cnktPnBpZCA9IHBpZDsK
PiArCQkJX19lbnRyeS0+dm1fY3R4ID0gdm1fY3R4Owo+ICsJCQlmb3IgKGkgPSAwOyBpIDwgbnB0
ZXM7ICsraSkgewo+ICsJCQkJdTY0IGFkZHIgPSBwLT5wYWdlc19hZGRyID8gYW1kZ3B1X3ZtX21h
cF9nYXJ0KAo+ICsJCQkJCXAtPnBhZ2VzX2FkZHIsIGRzdCkgOiBkc3Q7Cj4gKwo+ICsJCQkJKCh1
NjQgKilfX2dldF9keW5hbWljX2FycmF5KGRzdCkpW2ldID0gYWRkcjsKPiArCQkJCWRzdCArPSBp
bmNyOwo+ICsJCQl9Cj4gKwkpLAo+ICsJVFBfcHJpbnRrKCJwaWQ6JXUgdm1fY3R4OjB4JWxseCBz
dGFydDoweCUwMTBsbHggZW5kOjB4JTAxMGxseCwiCj4gKwkJICAiIGZsYWdzOjB4JWxseCwgaW5j
cjolbGx1LCBkc3Q6XG4lcyIsIF9fZW50cnktPnBpZCwKPiArCQkgIF9fZW50cnktPnZtX2N0eCwg
X19lbnRyeS0+c3RhcnQsIF9fZW50cnktPmVuZCwKPiArCQkgIF9fZW50cnktPmZsYWdzLCBfX2Vu
dHJ5LT5pbmNyLCAgX19wcmludF9hcnJheSgKPiArCQkgIF9fZ2V0X2R5bmFtaWNfYXJyYXkoZHN0
KSwgX19lbnRyeS0+bnB0ZXMsIDgpKQo+ICspOwo+ICsKPiAgIFRSQUNFX0VWRU5UKGFtZGdwdV92
bV9zZXRfcHRlcywKPiAgIAkgICAgVFBfUFJPVE8odWludDY0X3QgcGUsIHVpbnQ2NF90IGFkZHIs
IHVuc2lnbmVkIGNvdW50LAo+ICAgCQkgICAgIHVpbnQzMl90IGluY3IsIHVpbnQ2NF90IGZsYWdz
LCBib29sIGRpcmVjdCksCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBp
bmRleCA4YmMyMjUzOTM5YmUuLjNkMjU3MzliNDE1OCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTE1MTEsMTkgKzE1MTEsMjYgQEAgc3RhdGljIGludCBh
bWRncHVfdm1fdXBkYXRlX3B0ZXMoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwYXJh
bXMsCj4gICAJCWVudHJ5X2VuZCA9IG1pbihlbnRyeV9lbmQsIGVuZCk7Cj4gICAKPiAgIAkJZG8g
ewo+ICsJCQlzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSA9IHBhcmFtcy0+dm07Cj4gICAJCQl1aW50NjRf
dCB1cGRfZW5kID0gbWluKGVudHJ5X2VuZCwgZnJhZ19lbmQpOwo+ICAgCQkJdW5zaWduZWQgbnB0
ZXMgPSAodXBkX2VuZCAtIGZyYWdfc3RhcnQpID4+IHNoaWZ0Owo+ICsJCQl1aW50NjRfdCB1cGRf
ZmxhZ3MgPSBmbGFncyB8IEFNREdQVV9QVEVfRlJBRyhmcmFnKTsKPiAgIAo+ICAgCQkJLyogVGhp
cyBjYW4gaGFwcGVuIHdoZW4gd2Ugc2V0IGhpZ2hlciBsZXZlbCBQRHMgdG8KPiAgIAkJCSAqIHNp
bGVudCB0byBzdG9wIGZhdWx0IGZsb29kcy4KPiAgIAkJCSAqLwo+ICAgCQkJbnB0ZXMgPSBtYXgo
bnB0ZXMsIDF1KTsKPiArCj4gKwkJCXRyYWNlX2FtZGdwdV92bV91cGRhdGVfcHRlcyhwYXJhbXMs
IGZyYWdfc3RhcnQsIHVwZF9lbmQsCj4gKwkJCQkJCSAgICBucHRlcywgZHN0LCBpbmNyLCB1cGRf
ZmxhZ3MsCj4gKwkJCQkJCSAgICB2bS0+dGFza19pbmZvLnBpZCwKPiArCQkJCQkJICAgIHZtLT5p
bW1lZGlhdGUuZmVuY2VfY29udGV4dCk7Cj4gICAJCQlhbWRncHVfdm1fdXBkYXRlX2ZsYWdzKHBh
cmFtcywgcHQsIGN1cnNvci5sZXZlbCwKPiAgIAkJCQkJICAgICAgIHBlX3N0YXJ0LCBkc3QsIG5w
dGVzLCBpbmNyLAo+IC0JCQkJCSAgICAgICBmbGFncyB8IEFNREdQVV9QVEVfRlJBRyhmcmFnKSk7
Cj4gKwkJCQkJICAgICAgIHVwZF9mbGFncyk7Cj4gICAKPiAgIAkJCXBlX3N0YXJ0ICs9IG5wdGVz
ICogODsKPiAtCQkJZHN0ICs9ICh1aW50NjRfdClucHRlcyAqIEFNREdQVV9HUFVfUEFHRV9TSVpF
IDw8IHNoaWZ0Owo+ICsJCQlkc3QgKz0gbnB0ZXMgKiBpbmNyOwo+ICAgCj4gICAJCQlmcmFnX3N0
YXJ0ID0gdXBkX2VuZDsKPiAgIAkJCWlmIChmcmFnX3N0YXJ0ID49IGZyYWdfZW5kKSB7CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
