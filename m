Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675A2C2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 22:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 385FB2083E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 22:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fbLizSI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385FB2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD586FA40;
	Thu, 30 Jan 2020 22:34:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71C096FA40
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 22:34:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDQkOvB9SqsM8TbTJ3rxblJQwUC/4TemdqFmuj5xsj/I+ARi6W3P0bcB/DgwDQ4uwC7EdElt+eor42p3KD2e5+Tth5xIo9qIBGuBDn6nOHwoRSp1icou5fC+3J1vEhlGLJ0TB0jDBOZFWR8+hdderrVwfr1qMUjdfIgarUTMN/JNYSdcijEiY2KNDcyYKphisv6axDvz1IV7XDPPXjYnE0oUhFBACgwYNjOSMNZip7blezCF/57eSBiQMkxqFdfMv/AHLHByDQ7hSzvgeyq84M/Uu0FIsrPsXV9+WnpMVmcy2ajHfgT57OJyzlw/v17XFugqT+yqPInylodtqx12fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMBiQ+VZlIdPGb1KFf3j+WQiqboAVgwQjIpb/rO94/c=;
 b=lDSP+Da8ALBthlbc1TAuTv+HZUozsjxexteQwmhuMFbUTgWotTkiPZxshXxMUGArhNMSCFlH2FRcGfgEvRNJqbGjSC37QKjNa/jAVcIdDjG8f4cZ85j5Rnr4FYgABSc1r/EYXVJt5c/F1NfHdSr6VI4F3YmZb4889PIOjQaCY5GVJ0QT9tB+FmPSCvrgWtsQhSBzKSv3LonAATpBi/7nbZqpPCUoASxFUlCet4eEYBld6OmLA6dWPtoT1swdG2izKUh9ZTlr2LQrmeKDDJQ2AsSgxm44f4/PbZJxHS3f0ts7CS5D1xQQZFkNvAAp3BtUHKiayapUmH0/UnBzCVoAlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMBiQ+VZlIdPGb1KFf3j+WQiqboAVgwQjIpb/rO94/c=;
 b=fbLizSI7rUwc90or268s+Lso8AIhwW1sqhi9b5cKo6YcK4L+yETAoIA1ufGas9mkptBMHTHbiIjWt7bDBlKfEama+34p+9oDHD4xaWIV6WIT518V9etQYMqjr/4r+0CR5x2bVbze8f699E9tyxvWBvujEyHn/g2JrtBHOI4RFqY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from MWHPR1201MB0095.namprd12.prod.outlook.com (10.174.255.8) by
 MWHPR1201MB2527.namprd12.prod.outlook.com (10.172.95.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.28; Thu, 30 Jan 2020 22:34:03 +0000
Received: from MWHPR1201MB0095.namprd12.prod.outlook.com
 ([fe80::ade9:4cf3:87ad:707]) by MWHPR1201MB0095.namprd12.prod.outlook.com
 ([fe80::ade9:4cf3:87ad:707%11]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 22:34:03 +0000
Subject: Re: [PATCH 4/5] drm/amdgpu: simplify and fix amdgpu_sync_resv
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200130124940.30380-1-christian.koenig@amd.com>
 <20200130124940.30380-4-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <84804d63-5f2e-403b-5fb2-9991442f391d@amd.com>
Date: Thu, 30 Jan 2020 17:34:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20200130124940.30380-4-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::30) To MWHPR1201MB0095.namprd12.prod.outlook.com
 (2603:10b6:301:4e::8)
MIME-Version: 1.0
Received: from [172.31.19.228] (165.204.54.211) by
 YTXPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Thu, 30 Jan 2020 22:34:02 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c297130-e1f9-4bf4-5890-08d7a5d481e8
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2527:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2527D895E2F851AC06A382BA92040@MWHPR1201MB2527.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:480;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(189003)(199004)(6486002)(2616005)(31696002)(16576012)(52116002)(2906002)(956004)(316002)(86362001)(66476007)(66946007)(66556008)(81156014)(81166006)(8936002)(8676002)(186003)(16526019)(26005)(31686004)(53546011)(44832011)(5660300002)(478600001)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1201MB2527;
 H:MWHPR1201MB0095.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jwzRYP+vWv9HSoW2qYGJr7XHqRSo/lhKnQWUY0bdE35PF57xF45o9ciV7Eghtnxp/WimrDr2f2OcK+mmxHYplx2dQHx/HGE9c+3HCZYwvNzxVO5MQnPYkga3DAEO9KIQGFz0nH2NYp/eftym5ZxATYZh/yLncWYONcch5A699ulNz1swPGhKGA5GBOlHmINv0UiXo0hGdLc3edrp7j1ghw54WxBMHaXh1fije3mUi4+IW7NNAMrvh5GrVj96dvmsN0AZWowFe4YtF8Gvo00skK2bwdhdIlhOV+b+CpYtMMzTGU6IuqbfG8ju9TGdHzqjk75RFCdM5C4C6vxYKRaMmiUhxrm/RkJIq1+0TgCkDU3j66uG9hc29FcL5TVynpOTiAoO/8g7UWiure/IR2lpdpkTubwi1OVcDR3a04XY85HClAAWInKj17g1DVhgO56g
X-MS-Exchange-AntiSpam-MessageData: cxTf5OWA28O0JGw8qWhkRPurbdEGJVTvDOY4MqwT1FnxyIq9bSBppw0cOjiaTHBYVdFA+HdU8gzyHtnLcKcVXsNeaQ3M6dIOWSa+m5xLZ/XN/o+5BAAyQ3TKCpuN+r1Z7NEm6hsdBRm4ktTeqJbQ0A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c297130-e1f9-4bf4-5890-08d7a5d481e8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 22:34:03.0230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkpMi4uLkjXtNDlGq2c7qV9myRzaiNPHl8xzoCSUbPeLiIff/nHXUno02/8anOqGzLwUhxAVdBK6hS2inaLD0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2527
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

T24gMjAyMC0wMS0zMCA3OjQ5LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IE5vIG1hdHRlciB3
aGF0IHdlIGFsd2F5cyBuZWVkIHRvIHN5bmMgdG8gbW92ZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gVGVzdGVkLWJ5OiBU
b20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogRmVsaXggS3Vl
aGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMgfCAxNSArKysrKysrKysrKy0tLS0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jCj4gaW5kZXggYzEyNGY2NGU3YWFlLi45ZjQy
MDMyNjc2ZGEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3N5bmMuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMK
PiBAQCAtMjMyLDEwICsyMzIsMTkgQEAgaW50IGFtZGdwdV9zeW5jX3Jlc3Yoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfc3luYyAqc3luYywKPiAgIAo+ICAgCQlmID0g
cmN1X2RlcmVmZXJlbmNlX3Byb3RlY3RlZChmbGlzdC0+c2hhcmVkW2ldLAo+ICAgCQkJCQkgICAg
ICBkbWFfcmVzdl9oZWxkKHJlc3YpKTsKPiArCj4gKwkJZmVuY2Vfb3duZXIgPSBhbWRncHVfc3lu
Y19nZXRfb3duZXIoZik7Cj4gKwo+ICsJCS8qIEFsd2F5cyBzeW5jIHRvIG1vdmVzLCBubyBtYXR0
ZXIgd2hhdCAqLwo+ICsJCWlmIChmZW5jZV9vd25lciA9PSBBTURHUFVfRkVOQ0VfT1dORVJfVU5E
RUZJTkVEKSB7Cj4gKwkJCXIgPSBhbWRncHVfc3luY19mZW5jZShzeW5jLCBmLCBmYWxzZSk7Cj4g
KwkJCWlmIChyKQo+ICsJCQkJYnJlYWs7Cj4gKwkJfQo+ICsKPiAgIAkJLyogV2Ugb25seSB3YW50
IHRvIHRyaWdnZXIgS0ZEIGV2aWN0aW9uIGZlbmNlcyBvbgo+ICAgCQkgKiBldmljdCBvciBtb3Zl
IGpvYnMuIFNraXAgS0ZEIGZlbmNlcyBvdGhlcndpc2UuCj4gICAJCSAqLwo+IC0JCWZlbmNlX293
bmVyID0gYW1kZ3B1X3N5bmNfZ2V0X293bmVyKGYpOwo+ICAgCQlpZiAoZmVuY2Vfb3duZXIgPT0g
QU1ER1BVX0ZFTkNFX09XTkVSX0tGRCAmJgo+ICAgCQkgICAgb3duZXIgIT0gQU1ER1BVX0ZFTkNF
X09XTkVSX1VOREVGSU5FRCkKPiAgIAkJCWNvbnRpbnVlOwo+IEBAIC0yNjUsOSArMjc0LDcgQEAg
aW50IGFtZGdwdV9zeW5jX3Jlc3Yoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBh
bWRncHVfc3luYyAqc3luYywKPiAgIAkJCWJyZWFrOwo+ICAgCj4gICAJCWNhc2UgQU1ER1BVX1NZ
TkNfRVhQTElDSVQ6Cj4gLQkJCWlmIChvd25lciAhPSBBTURHUFVfRkVOQ0VfT1dORVJfVU5ERUZJ
TkVEKQo+IC0JCQkJY29udGludWU7Cj4gLQkJCWJyZWFrOwo+ICsJCQljb250aW51ZTsKPiAgIAkJ
fQo+ICAgCj4gICAJCXIgPSBhbWRncHVfc3luY19mZW5jZShzeW5jLCBmLCBmYWxzZSk7Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
