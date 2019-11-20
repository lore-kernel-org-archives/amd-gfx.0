Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6641C43215
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 17:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96B320878
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 17:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96B320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62A106E9CE;
	Wed, 20 Nov 2019 17:55:35 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730062.outbound.protection.outlook.com [40.107.73.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A635E6E9CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 17:55:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOWMkk/Mh0XhuY33/fqX5LILP+WfX6ImU+r4PjUVMojbAiiKvsTTsCIjDFVwUY5oD6Na+sbO4Z55NrNQp6xGPYZpCT3/zTV3vNw9t1W/QBxZXrlmHP3HrGlZCSW7ZQQ+B/EU3Z2MOiYSkWlNSZehizIJiPfdIstMCsMrsrFpjSORQtP6/f86VbVF/2kU99LjxN4aIHHhARP87y615e2dmlS0suOiJtcXt3UZZqIgBbpWB8kY3WJV/j91keJXr22igmfa55zNMCTSF8jwExxJqR/ThN9xPtP6NzkilUbNQdN3mgtqalnSZsodhU5tIB9UEDSg/qnYurboIKgPsnIIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EB7KngeR0/9l11kbd3Gonvri1sXUYZqoi8jOnpkm7B0=;
 b=jwsuwMBLEg1Zjc37V/8ESbZ33ZhjwnedJwDk331RfQuPqMQA4HfDq29/gRQ7ADjIX2LulKRQVCue1xIMBDgGLiJ3nXGlxW/Z5HSZtUyJn2U4MypzlwlFJLFuqdLBtx6vggIz20kTzsourZLnDBFOCv4CQmr8N1v/TNEYmDjprdSP4vE9YG99Jh5rAZrFwUxcE6j7UJmb8/W3fRl9w7vaZhdXE7qq3FBQden8jWsjcsPaQVBmn0P/cSBVH8iBeXUcChfIFlJIK37djHmKT+SGhkHDAgSDU8E4qhS/2zKzy3/vnWqHN8dULSR0ZjdN67QyDHQ9aV20+AobAzt9wkkNgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB2732.namprd12.prod.outlook.com (20.176.116.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 17:55:31 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 17:55:31 +0000
Subject: Re: [PATCH] drm/amdkfd: Delete KFD_MQD_TYPE_COMPUTE
To: Yong Zhao <Yong.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191115160747.1827-1-Yong.Zhao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <369496ac-2fb1-3606-0e4f-d2049c99744e@amd.com>
Date: Wed, 20 Nov 2019 12:55:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191115160747.1827-1-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::29) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ac0b468-74cb-417f-69b1-08d76de2d586
X-MS-TrafficTypeDiagnostic: DM6PR12MB2732:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB273277C9E8BA332FC905B97D924F0@DM6PR12MB2732.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(26005)(14444005)(58126008)(5660300002)(31686004)(476003)(486006)(478600001)(305945005)(7736002)(6116002)(3846002)(14454004)(66556008)(316002)(230700001)(66476007)(6666004)(66946007)(99286004)(86362001)(4001150100001)(36756003)(50466002)(2616005)(25786009)(66066001)(65806001)(6246003)(65956001)(47776003)(6436002)(44832011)(6486002)(76176011)(6506007)(186003)(8936002)(6512007)(8676002)(81156014)(81166006)(229853002)(2486003)(23676004)(52116002)(2906002)(446003)(11346002)(31696002)(386003)(524014004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2732;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jniWEkRpRmY/tB1RwGicIGLezKGjTJVe9qAnkOszPnMpDlC8fC2EY99NpSqol3ONjy1Oi2vry9CDeHxp1ztljaGsYl5CplMjVVz+0/TbhM8jgiddPXrgeMcDasQE8gtovkRiQQEGa753t83Ct+82b0ljE8Ys8WYo5gdSFZU0SiuigGVp4XkAlYyk60Aq4EgOMsqX63CTJdkXBiN52OYRodguGdmGXN7ZfUwS18ZoksR4X3lNn48aM+ySF32rwX4ikwaWqhK9DMQZJfRS7/hPq/0OGmN+KTPF7Qht9LIQdgXdJwutHcXKo6GFA0zHFG8yOObFwFusu2hJ0j3EkIA5xX3jY8LG7UPgymxUdHt5gaMfSMPXxXnNCSSffe0XAdwOrDkXaXLuO8mHhsldT/XqzXsiEweeSzpyodT+xPWbtLZF3a2rcErFzq/bxjFL4xNh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac0b468-74cb-417f-69b1-08d76de2d586
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 17:55:30.9606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysi9dovQ3ySKBiEO78vx9Xy8GnB7gm90+imaeEPwRg9k7gqoUQ+ukGAznCQeZkQdRey0u2nRjsRbe+yALNAaRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2732
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EB7KngeR0/9l11kbd3Gonvri1sXUYZqoi8jOnpkm7B0=;
 b=AObf3u83h8iRSWDiv/VFTksp60JIptHBte5etPfz8U9JWrUzVN9nrvEiF0s2JUTK0iESF2T8lAf4N7a1Pr4V4O8M8UHk8k5oBrJh08LO7MXgFfEcZ9F+y/ZbtDjhEGJwXyec4wm3WeuqfbIdSmK7+NnSHM2Se14xFCOfSOWwr6s=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120175521.HvXJvYhUCukFRci2cgHYbnZSyQ4-wqZ6qOvt21MHDB0@z>

biAyMDE5LTExLTE1IDExOjA3LCBZb25nIFpoYW8gd3JvdGU6Cj4gSXQgaXMgdGhlIHNhbWUgYXMg
S0ZEX01RRF9UWVBFX0NQLCBzbyBkZWxldGUgaXQuIEFzIGEgcmVzdWx0LCB3ZSB3aWxsCj4gaGF2
ZSBvbmUgbGVzcyBtcWQgbWFuYW5nZXIgcGVyIGRldmljZS4KPgo+IENoYW5nZS1JZDogSWFhOThm
YzE3YmUwNmIyMTZkZTdhODI2YzM1NzdmNDRiYzA1MzZiNGMKPiBTaWduZWQtb2ZmLWJ5OiBZb25n
IFpoYW8gPFlvbmcuWmhhb0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxG
ZWxpeC5LdWVobGluZ0BhbWQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYyB8IDIgKy0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl9jaWsuYyAgICAgIHwgMyArLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYyAgICAgIHwgMSAtCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYyAgICAgICB8
IDEgLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3ZpLmMg
ICAgICAgfCAzICstLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaCAg
ICAgICAgICAgICAgICAgfCAzICstLQo+ICAgNiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+IGluZGV4IGI0MmYzNGVmMmI1Yy4uZjdm
NmRmNDA4NzVlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9k
ZXZpY2VfcXVldWVfbWFuYWdlci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMKPiBAQCAtMTU5NSw3ICsxNTk1LDcgQEAgc3RhdGlj
IGludCBnZXRfd2F2ZV9zdGF0ZShzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSwKPiAg
IAkJZ290byBkcW1fdW5sb2NrOwo+ICAgCX0KPiAgIAo+IC0JbXFkX21nciA9IGRxbS0+bXFkX21n
cnNbS0ZEX01RRF9UWVBFX0NPTVBVVEVdOwo+ICsJbXFkX21nciA9IGRxbS0+bXFkX21ncnNbS0ZE
X01RRF9UWVBFX0NQXTsKPiAgIAo+ICAgCWlmICghbXFkX21nci0+Z2V0X3dhdmVfc3RhdGUpIHsK
PiAgIAkJciA9IC1FSU5WQUw7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9tcWRfbWFuYWdlcl9jaWsuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9tcWRfbWFuYWdlcl9jaWsuYwo+IGluZGV4IDI4ODc2YWNlYjE0Yi4uYjA4Njk0ZWM2NWQ3IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl9j
aWsuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl9j
aWsuYwo+IEBAIC0zNzQsNyArMzc0LDYgQEAgc3RydWN0IG1xZF9tYW5hZ2VyICptcWRfbWFuYWdl
cl9pbml0X2NpayhlbnVtIEtGRF9NUURfVFlQRSB0eXBlLAo+ICAgCj4gICAJc3dpdGNoICh0eXBl
KSB7Cj4gICAJY2FzZSBLRkRfTVFEX1RZUEVfQ1A6Cj4gLQljYXNlIEtGRF9NUURfVFlQRV9DT01Q
VVRFOgo+ICAgCQltcWQtPmFsbG9jYXRlX21xZCA9IGFsbG9jYXRlX21xZDsKPiAgIAkJbXFkLT5p
bml0X21xZCA9IGluaXRfbXFkOwo+ICAgCQltcWQtPmZyZWVfbXFkID0gZnJlZV9tcWQ7Cj4gQEAg
LTQ0Miw3ICs0NDEsNyBAQCBzdHJ1Y3QgbXFkX21hbmFnZXIgKm1xZF9tYW5hZ2VyX2luaXRfY2lr
X2hhd2FpaShlbnVtIEtGRF9NUURfVFlQRSB0eXBlLAo+ICAgCW1xZCA9IG1xZF9tYW5hZ2VyX2lu
aXRfY2lrKHR5cGUsIGRldik7Cj4gICAJaWYgKCFtcWQpCj4gICAJCXJldHVybiBOVUxMOwo+IC0J
aWYgKCh0eXBlID09IEtGRF9NUURfVFlQRV9DUCkgfHwgKHR5cGUgPT0gS0ZEX01RRF9UWVBFX0NP
TVBVVEUpKQo+ICsJaWYgKHR5cGUgPT0gS0ZEX01RRF9UWVBFX0NQKQo+ICAgCQltcWQtPnVwZGF0
ZV9tcWQgPSB1cGRhdGVfbXFkX2hhd2FpaTsKPiAgIAlyZXR1cm4gbXFkOwo+ICAgfQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEwLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEwLmMKPiBpbmRl
eCA1NzljNWZmY2ZhNzkuLjVhMGUzMDQ0MWJlOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEwLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEwLmMKPiBAQCAtNDAxLDcgKzQwMSw2IEBA
IHN0cnVjdCBtcWRfbWFuYWdlciAqbXFkX21hbmFnZXJfaW5pdF92MTAoZW51bSBLRkRfTVFEX1RZ
UEUgdHlwZSwKPiAgIAo+ICAgCXN3aXRjaCAodHlwZSkgewo+ICAgCWNhc2UgS0ZEX01RRF9UWVBF
X0NQOgo+IC0JY2FzZSBLRkRfTVFEX1RZUEVfQ09NUFVURToKPiAgIAkJcHJfZGVidWcoIiVzQCVp
XG4iLCBfX2Z1bmNfXywgX19MSU5FX18pOwo+ICAgCQltcWQtPmFsbG9jYXRlX21xZCA9IGFsbG9j
YXRlX21xZDsKPiAgIAkJbXFkLT5pbml0X21xZCA9IGluaXRfbXFkOwo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5jCj4gaW5kZXggMjJhODE5Yzg4
OGQ4Li5iZGJjZWEyMmFkMTIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfbXFkX21hbmFnZXJfdjkuYwo+IEBAIC00NDQsNyArNDQ0LDYgQEAgc3RydWN0IG1xZF9t
YW5hZ2VyICptcWRfbWFuYWdlcl9pbml0X3Y5KGVudW0gS0ZEX01RRF9UWVBFIHR5cGUsCj4gICAK
PiAgIAlzd2l0Y2ggKHR5cGUpIHsKPiAgIAljYXNlIEtGRF9NUURfVFlQRV9DUDoKPiAtCWNhc2Ug
S0ZEX01RRF9UWVBFX0NPTVBVVEU6Cj4gICAJCW1xZC0+YWxsb2NhdGVfbXFkID0gYWxsb2NhdGVf
bXFkOwo+ICAgCQltcWQtPmluaXRfbXFkID0gaW5pdF9tcWQ7Cj4gICAJCW1xZC0+ZnJlZV9tcWQg
PSBmcmVlX21xZDsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X21xZF9tYW5hZ2VyX3ZpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21h
bmFnZXJfdmkuYwo+IGluZGV4IDdkMTQ0ZjU2ZjQyMS4uYzllMTE1MWI1YTU3IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92aS5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3ZpLmMKPiBAQCAt
NDI1LDcgKzQyNSw2IEBAIHN0cnVjdCBtcWRfbWFuYWdlciAqbXFkX21hbmFnZXJfaW5pdF92aShl
bnVtIEtGRF9NUURfVFlQRSB0eXBlLAo+ICAgCj4gICAJc3dpdGNoICh0eXBlKSB7Cj4gICAJY2Fz
ZSBLRkRfTVFEX1RZUEVfQ1A6Cj4gLQljYXNlIEtGRF9NUURfVFlQRV9DT01QVVRFOgo+ICAgCQlt
cWQtPmFsbG9jYXRlX21xZCA9IGFsbG9jYXRlX21xZDsKPiAgIAkJbXFkLT5pbml0X21xZCA9IGlu
aXRfbXFkOwo+ICAgCQltcWQtPmZyZWVfbXFkID0gZnJlZV9tcWQ7Cj4gQEAgLTQ5NCw3ICs0OTMs
NyBAQCBzdHJ1Y3QgbXFkX21hbmFnZXIgKm1xZF9tYW5hZ2VyX2luaXRfdmlfdG9uZ2EoZW51bSBL
RkRfTVFEX1RZUEUgdHlwZSwKPiAgIAltcWQgPSBtcWRfbWFuYWdlcl9pbml0X3ZpKHR5cGUsIGRl
dik7Cj4gICAJaWYgKCFtcWQpCj4gICAJCXJldHVybiBOVUxMOwo+IC0JaWYgKCh0eXBlID09IEtG
RF9NUURfVFlQRV9DUCkgfHwgKHR5cGUgPT0gS0ZEX01RRF9UWVBFX0NPTVBVVEUpKQo+ICsJaWYg
KHR5cGUgPT0gS0ZEX01RRF9UWVBFX0NQKQo+ICAgCQltcWQtPnVwZGF0ZV9tcWQgPSB1cGRhdGVf
bXFkX3RvbmdhOwo+ICAgCXJldHVybiBtcWQ7Cj4gICB9Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfcHJpdi5oCj4gaW5kZXggMTA0OTc1OWRjNmJiLi41MTQ4OTZiZWY5OWEgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaAo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgKPiBAQCAtNTA4LDggKzUwOCw3IEBAIHN0
cnVjdCBxdWV1ZSB7Cj4gICAgKiBQbGVhc2UgcmVhZCB0aGUga2ZkX21xZF9tYW5hZ2VyLmggZGVz
Y3JpcHRpb24uCj4gICAgKi8KPiAgIGVudW0gS0ZEX01RRF9UWVBFIHsKPiAtCUtGRF9NUURfVFlQ
RV9DT01QVVRFID0gMCwJLyogZm9yIG5vIGNwIHNjaGVkdWxpbmcgKi8KPiAtCUtGRF9NUURfVFlQ
RV9ISVEsCQkvKiBmb3IgaGlxICovCj4gKwlLRkRfTVFEX1RZUEVfSElRID0gMCwJCS8qIGZvciBo
aXEgKi8KPiAgIAlLRkRfTVFEX1RZUEVfQ1AsCQkvKiBmb3IgY3AgcXVldWVzIGFuZCBkaXEgKi8K
PiAgIAlLRkRfTVFEX1RZUEVfU0RNQSwJCS8qIGZvciBzZG1hIHF1ZXVlcyAqLwo+ICAgCUtGRF9N
UURfVFlQRV9ESVEsCQkvKiBmb3IgZGlxICovCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
