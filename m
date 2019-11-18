Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0C9C432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 13:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C61206D4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 13:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C61206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A52CC6E50E;
	Mon, 18 Nov 2019 13:17:16 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820089.outbound.protection.outlook.com [40.107.82.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8BAE6E50E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 13:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUOdafdVzRByt9dQ9e9UIREsROd9JIhkgz+jRpemDJbRmDp0bP1b6hvbNzayyMGWjJRD5+YcFBrmblmNF9j5c76HXOZY54N95GR8O+PLbK4w79d2SssVb7L2VagKGKgsi2Q2RjQdGLxyzzPM2F0XUCC+F/s5OHwraEqbBBDflO7OOF+t7OoWfWolwOAWz20jDDfP3dA5U2Ye8pGwEeNKgkp65fjJajB6M+Zo6vriKh9R50gHNmWSxQ9WbZUs+AnlYCHuNsgWUs5KC8UsTEENDe039GgpUGeP3yGUg/QuAQ66DiJUdwzCkAD7EWqQL3eSLsbhNrJybBP/bjiFWwIGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9qEAMaXzoPIDUnYsulz9D8Axokzy/amZABLNM/5Zcs=;
 b=hiR72ImZEZMzaEhnqitXszyb9cNYcVwIFR6BpoCNv9hHuiT3OrLlLAqnL9DcYvsuTqRCyOux+vqPajPGTQpYJl8KS8uR3r9OHpJtU45amA9sVCyFCB6VyUDuN6bv61XGt8ryCiBL6tUVAC4/SNpkQGGqrlWQtca1MTNrgN2MYVj+1DLWP/z9fdAL+ImU9qkcCD/AgL22f2fZAlbO66bM2GCp4rc5IaBFEYg3ASVT2Cz/9vvaCJATFv85URoDR/9P4NxYXSQbwjIxW/pg6pi6EzHxF421FzvKVE/sceEAN3fAwlb397ut6i4346sCb88RNfb5afw19PxGBTkK7S4P8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1626.namprd12.prod.outlook.com (10.172.38.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Mon, 18 Nov 2019 13:17:12 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 13:17:12 +0000
Subject: Re: [PATCH] drm/amdgpu: put flush_dealyed_work at first
To: Yintian Tao <yttao@amd.com>
References: <20191118122759.15654-1-yttao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4b247c8f-fa62-4b42-1f9e-6f33897f9791@amd.com>
Date: Mon, 18 Nov 2019 14:17:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191118122759.15654-1-yttao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0016.eurprd04.prod.outlook.com
 (2603:10a6:208:122::29) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46fd36fb-639b-4894-340a-08d76c299f73
X-MS-TrafficTypeDiagnostic: DM5PR12MB1626:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB162690D46D06113A9D200EC9834D0@DM5PR12MB1626.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(229853002)(2616005)(66574012)(25786009)(4326008)(86362001)(50466002)(52116002)(76176011)(2486003)(8676002)(81166006)(81156014)(23676004)(6862004)(14444005)(31696002)(8936002)(14454004)(6486002)(2870700001)(99286004)(476003)(46003)(486006)(6666004)(11346002)(446003)(66946007)(6116002)(186003)(6246003)(66476007)(66556008)(2906002)(5660300002)(6636002)(47776003)(478600001)(6512007)(31686004)(6436002)(316002)(37006003)(58126008)(65956001)(65806001)(305945005)(6506007)(7736002)(386003)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1626;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IEG8snQKIeG6LfjcBuaYLckgkwR9oQ0a23rJQSH+IEFcF+QKNcNjxYGXA1xuKRe05kefzMoI48Kfh3ydB9XZVypxL97/74z8X+hWM9/1odb+EJcbSfaoHW02C6EamCCl1yWWYRA87g4uP3HdGLHMGeLuijFrALZXUtdieE3OwUMnPqmlyn9innm9I6rmqlH5O0pDiulLGNOR3XTciS+7nMh0F8ZZkju3KEMgHDy/yT/8RybYZWhb80dMoqYuufcUrjd1ezCeE48cv4g+WyQr2GpomVQNwA6f8X5HXpqalMrLqDenuhMspb2RIpTnyAERVpPKvzWjrky2rQZyOtbJ2xZd5e2G+q6eDXQfpwArfqUYozVJchWlxAs71ISH+U0V/XPzEwbdmxskmvWdeDms39mX6/ZJC69U6t1LlRwIIuCs8xV+DOfBv+miuj9FoeQJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fd36fb-639b-4894-340a-08d76c299f73
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 13:17:12.3389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5ONIsNPOMw/zllgUEBQJQI2x9s/6XJBuEoCHNJpWGPawkEhp/KrOIdb3Xr8xnn0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1626
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9qEAMaXzoPIDUnYsulz9D8Axokzy/amZABLNM/5Zcs=;
 b=LhXKZoCGkK42CtGYFyZBk7N+LkkphaFIDddR2jaS1BFkSbkPjUFT3WlXC3MCA2ijNTQpoOgRPGLc1oPJCGr+oa3sa0/8TBGK4TdU3yj0Q+322fxDdHqyNIWX9q+0PCMJkckfHmN1JzloBC9P5NovsUymQRLVKmlx8rVIZCJbMtA=
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118131707.mk_wuFRc1MLpB5Krs41BA7X44MPva8jJ_O8_Lb59bK8@z>

QW0gMTguMTEuMTkgdW0gMTM6Mjcgc2NocmllYiBZaW50aWFuIFRhbzoKPiBUaGVyZSBpcyBvbmUg
cmVncmVzc2lvbiBmcm9tIDA0MmYzZDdiNzQ1Y2Q3NmFhCj4gVG8gcHV0IGZsdXNoX2RlbGF5ZWRf
d29yayBhZnRlciBhZGV2LT5zaHV0ZG93biA9IHRydWUKPiB3aGljaCB3aWxsIG1ha2UgYW1kZ3B1
X2loX3Byb2Nlc3Mgbm90IHJlc3BvbnNlIHRoZSBpcnEKPiBBdCBsYXN0LCBhbGwgaWIgcmluZyB0
ZXN0cyB3aWxsIGJlIGZhaWxlZCBqdXN0IGxpa2UgYmVsb3cKPgo+IFtkcm1dIGFtZGdwdTogZmlu
aXNoaW5nIGRldmljZS4KPiBbZHJtXSBGZW5jZSBmYWxsYmFjayB0aW1lciBleHBpcmVkIG9uIHJp
bmcgZ2Z4Cj4gW2RybV0gRmVuY2UgZmFsbGJhY2sgdGltZXIgZXhwaXJlZCBvbiByaW5nIGNvbXBf
MS4wLjAKPiBbZHJtXSBGZW5jZSBmYWxsYmFjayB0aW1lciBleHBpcmVkIG9uIHJpbmcgY29tcF8x
LjEuMAo+IFtkcm1dIEZlbmNlIGZhbGxiYWNrIHRpbWVyIGV4cGlyZWQgb24gcmluZyBjb21wXzEu
Mi4wCj4gW2RybV0gRmVuY2UgZmFsbGJhY2sgdGltZXIgZXhwaXJlZCBvbiByaW5nIGNvbXBfMS4z
LjAKPiBbZHJtXSBGZW5jZSBmYWxsYmFjayB0aW1lciBleHBpcmVkIG9uIHJpbmcgY29tcF8xLjAu
MQo+IGFtZGdwdSAwMDAwOjAwOjA3LjA6IFtkcm06YW1kZ3B1X2liX3JpbmdfdGVzdHMgW2FtZGdw
dV1dICpFUlJPUiogSUIgdGVzdCBmYWlsZWQgb24gY29tcF8xLjEuMSAoLTExMCkuCj4gYW1kZ3B1
IDAwMDA6MDA6MDcuMDogW2RybTphbWRncHVfaWJfcmluZ190ZXN0cyBbYW1kZ3B1XV0gKkVSUk9S
KiBJQiB0ZXN0IGZhaWxlZCBvbiBjb21wXzEuMi4xICgtMTEwKS4KPiBhbWRncHUgMDAwMDowMDow
Ny4wOiBbZHJtOmFtZGdwdV9pYl9yaW5nX3Rlc3RzIFthbWRncHVdXSAqRVJST1IqIElCIHRlc3Qg
ZmFpbGVkIG9uIGNvbXBfMS4zLjEgKC0xMTApLgo+IGFtZGdwdSAwMDAwOjAwOjA3LjA6IFtkcm06
YW1kZ3B1X2liX3JpbmdfdGVzdHMgW2FtZGdwdV1dICpFUlJPUiogSUIgdGVzdCBmYWlsZWQgb24g
c2RtYTAgKC0xMTApLgo+IGFtZGdwdSAwMDAwOjAwOjA3LjA6IFtkcm06YW1kZ3B1X2liX3Jpbmdf
dGVzdHMgW2FtZGdwdV1dICpFUlJPUiogSUIgdGVzdCBmYWlsZWQgb24gc2RtYTEgKC0xMTApLgo+
IGFtZGdwdSAwMDAwOjAwOjA3LjA6IFtkcm06YW1kZ3B1X2liX3JpbmdfdGVzdHMgW2FtZGdwdV1d
ICpFUlJPUiogSUIgdGVzdCBmYWlsZWQgb24gdXZkX2VuY18wLjAgKC0xMTApLgo+IGFtZGdwdSAw
MDAwOjAwOjA3LjA6IFtkcm06YW1kZ3B1X2liX3JpbmdfdGVzdHMgW2FtZGdwdV1dICpFUlJPUiog
SUIgdGVzdCBmYWlsZWQgb24gdmNlMCAoLTExMCkuCj4gW2RybTphbWRncHVfZGV2aWNlX2RlbGF5
ZWRfaW5pdF93b3JrX2hhbmRsZXIgW2FtZGdwdV1dICpFUlJPUiogaWIgcmluZyB0ZXN0IGZhaWxl
ZCAoLTExMCkuCj4KPiB2MjogcmVwbGFjZSBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoKSB3aXRo
IGZsdXNoX2RlbGF5ZWRfd29yaygpCj4KPiBTaWduZWQtb2ZmLWJ5OiBZaW50aWFuIFRhbyA8eXR0
YW9AYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jIHwgNCArLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jCj4gaW5kZXggMTdiZTYzODlhZGY3Li5iN2FiNTIyNGFlMjMgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gQEAgLTMxMDksOSArMzEwOSw4IEBA
IHZvaWQgYW1kZ3B1X2RldmljZV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAg
CWludCByOwo+ICAgCj4gICAJRFJNX0lORk8oImFtZGdwdTogZmluaXNoaW5nIGRldmljZS5cbiIp
Owo+IC0JYWRldi0+c2h1dGRvd24gPSB0cnVlOwo+IC0KPiAgIAlmbHVzaF9kZWxheWVkX3dvcmso
JmFkZXYtPmRlbGF5ZWRfaW5pdF93b3JrKTsKPiArCWFkZXYtPnNodXRkb3duID0gdHJ1ZTsKPiAg
IAo+ICAgCS8qIGRpc2FibGUgYWxsIGludGVycnVwdHMgKi8KPiAgIAlhbWRncHVfaXJxX2Rpc2Fi
bGVfYWxsKGFkZXYpOwo+IEBAIC0zMTMwLDcgKzMxMjksNiBAQCB2b2lkIGFtZGdwdV9kZXZpY2Vf
ZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAkJYWRldi0+ZmlybXdhcmUuZ3B1
X2luZm9fZncgPSBOVUxMOwo+ICAgCX0KPiAgIAlhZGV2LT5hY2NlbF93b3JraW5nID0gZmFsc2U7
Cj4gLQljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPmRlbGF5ZWRfaW5pdF93b3JrKTsK
PiAgIAkvKiBmcmVlIGkyYyBidXNlcyAqLwo+ICAgCWlmICghYW1kZ3B1X2RldmljZV9oYXNfZGNf
c3VwcG9ydChhZGV2KSkKPiAgIAkJYW1kZ3B1X2kyY19maW5pKGFkZXYpOwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
