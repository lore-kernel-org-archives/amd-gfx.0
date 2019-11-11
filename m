Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49213C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 20:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE5920659
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 20:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE5920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB2716E2D5;
	Mon, 11 Nov 2019 20:29:49 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760053.outbound.protection.outlook.com [40.107.76.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E02036E2D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 20:29:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVUvZhZf9kvq1J1/7RMjgTrH/rVpKMZ4rCSYshf5wlyn4iHDCcOTqMHBJHI+82CHg0pEg200kkZ379RJq1wSiDHZJP9iAzEamJ/IrUNa7PVuOuh1HLB9Npxlfwv1Ubn5cyYnf1lpbeWZWUz79VBdGLmSkv/6iP0rTdmPTEKRN8muoARyX4NeEJfeFk22k66wMH+eNB+vBZVy1CnmQUI7oc7rW4t2vnrR5xO+8tOfxfbDG33s1K4JrDeg3N/b0o3HmBUR9caZxQ30bp2Yxvi/eEP0yy+fI0n6E60ZW+KyqIT+EQ9wd6xoZrG7VIPm9SX+dg6e86G5Mof8I/QiR7Qb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtmaeugYYP0b8xEpsAvbtkpe2lwVKGW9Pn6A4RoT2FE=;
 b=dEbAg3itw0G+wGbTaECtit3hGkC/T4XdVNZKIAA26JTVoa58ve2GBtTRmgiTUAp0kihaRzXc5dNx1Vjl9tAt4VGBebGZcU8L7f271chPWNBdQyr01RsmVD5Zqd8Os6Vk8Bq89YD4cTUpXw3Vj9MowVDJvlnDGOw0HZWgeT5xh2G2wJAfq586CvaXuspD0ZEPLMs3EH/uhoIpy0HuDCTB/T+6tuz9RF5QEx+pl0HQwE+fbzQOXda2dgW/T1zI6TWYXkAgI6SG0djebJRuSC+QIBUy2qmkkwEH1R2jxebQCod7Z7dx7YVxNISxeceAN4FeyKovQZ/YXcR6m/JILHCIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.174.156) by
 DM6PR12MB2761.namprd12.prod.outlook.com (20.176.118.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.26; Mon, 11 Nov 2019 20:29:47 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede%4]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 20:29:47 +0000
Subject: Re: [PATCH 1/2] drm/amdkfd: Use better name to indicate the offset is
 in dwords
To: "Zhao, Yong" <Yong.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20191101201016.5973-1-Yong.Zhao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <6a2f59af-1736-0c2d-c052-35b6649e0e55@amd.com>
Date: Mon, 11 Nov 2019 15:29:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191101201016.5973-1-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::33) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:1cb::28)
MIME-Version: 1.0
X-Originating-IP: [142.116.193.252]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef55b70d-76d3-4304-219c-08d766e5e4d7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2761:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2761904C91D255FAFEE3000C92740@DM6PR12MB2761.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(78094002)(199004)(189003)(5660300002)(99286004)(66476007)(186003)(66556008)(110136005)(478600001)(14454004)(7736002)(2870700001)(31686004)(36756003)(31696002)(2906002)(8676002)(486006)(6246003)(6512007)(6486002)(86362001)(26005)(14444005)(6436002)(81156014)(81166006)(66946007)(50466002)(44832011)(305945005)(446003)(23676004)(2486003)(8936002)(25786009)(3846002)(2501003)(6116002)(476003)(47776003)(76176011)(65806001)(65956001)(66066001)(316002)(11346002)(229853002)(2616005)(53546011)(6506007)(386003)(58126008)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2761;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deR/+37D3ocDd29y54BpJKgud5s84qcfdHo97/SnqWzrkvbWA44K+548iKPXmjJVxUNKmKlC4p2AuTAgNwZvmQjNoEnYSAEtcsjejV9jh4M90NHaAO8bt4HJAFyNrumMp8WPtNTDt53H3oU8ZSTgsyWwy874ZECL5WVXwokL5m6HXzHeN2plLvSjL0qJjJ6Ta+3z0FzfE+6yCOZOaRdabXZCTvkcdiEBQ/L+s0Ps2JsMSuQ1+QtLMh3v/8vxcjkmU+4NZIdMo8DA2NFkLdfh2JuzoCrrnf/ppm9VlLFmNgpvAdRYeY+6Ccj9Ex1xRMa3Dhmm1todLrguJJYVdFikhwMC1zRLtw6RJFKI/SicrLTKDFBPMJi/dmCfr5YbMvwGQ+cSO9urjwYcIE3Bp4bfqMc6ULfkm1pzYFcTYsTcIo71giHnW2EhxT5WQvaKT1ts/K24VpJRi6rtBRVU7QYtyQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef55b70d-76d3-4304-219c-08d766e5e4d7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 20:29:47.1461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gIsnHFUTMhkZTqtVbmHzF+DFj31b9cJfTVLlEvxqRXQFKQrUP+tE0uHmBLN/u0ysliLb+0x5Qki/GK6PzTIXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2761
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtmaeugYYP0b8xEpsAvbtkpe2lwVKGW9Pn6A4RoT2FE=;
 b=yEEZmp8uKUawoy7lahMV5nNmQCq8+6kibEnCGIWonc/J1eQuQZ9LjkfP/9E/yXGNYjvF1KpjvTpGTFiIGSEpf/9q7Jo5eGXylnbl7LB5nV05h+a4BTDUO9xlL4RvE8s/7iH8LrLryB6Fgn9O9z/ySiE703kG2V4KW2bltIQJZf4=
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
Message-ID: <20191111202946.3QjDzBjLOf7Urs4EN93Z6bHsuQlAGe9a-en2H9aqu8E@z>

T24gMjAxOS0xMS0wMSAxNjoxMCwgWmhhbywgWW9uZyB3cm90ZToKPiBDaGFuZ2UtSWQ6IEk3NWRh
MjNiYmE5MDIzMTc2MmNmNThkYTMxNzBmNWJiNzdlY2U0NWVkCj4gU2lnbmVkLW9mZi1ieTogWW9u
ZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNvbT4KCkkgYWdyZWUgd2l0aCB0aGUgbmFtZSBjaGFuZ2Vz
LiBPbmUgc3VnZ2VzdGlvbiBmb3IgYSBjb21tZW50IGlubGluZS4gV2l0aCAKdGhhdCBmaXhlZCwg
dGhpcyBwYXRjaCBpcwoKUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGlu
Z0BhbWQuY29tPgoKCj4gLS0tCj4gICAuLi4vZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2Vf
cXVldWVfbWFuYWdlci5jICB8ICAyICstCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfZG9vcmJlbGwuYyAgICAgICAgICB8IDE0ICsrKysrKystLS0tLS0tCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oICAgICAgICAgICAgICB8ICA4ICsrKystLS0tCj4g
ICAzIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVf
bWFuYWdlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9t
YW5hZ2VyLmMKPiBpbmRleCA5ODRjMmYyYjI0YjYuLjQ1MDNmYjI2ZmU1YiAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdl
ci5jCj4gQEAgLTE3MCw3ICsxNzAsNyBAQCBzdGF0aWMgaW50IGFsbG9jYXRlX2Rvb3JiZWxsKHN0
cnVjdCBxY21fcHJvY2Vzc19kZXZpY2UgKnFwZCwgc3RydWN0IHF1ZXVlICpxKQo+ICAgCX0KPiAg
IAo+ICAgCXEtPnByb3BlcnRpZXMuZG9vcmJlbGxfb2ZmID0KPiAtCQlrZmRfZG9vcmJlbGxfaWRf
dG9fb2Zmc2V0KGRldiwgcS0+cHJvY2VzcywKPiArCQlrZmRfZ2V0X2Rvb3JiZWxsX2R3X29mZnNl
dF9mcm9tX2JhcihkZXYsIHEtPnByb2Nlc3MsCj4gICAJCQkJCSAgcS0+ZG9vcmJlbGxfaWQpOwo+
ICAgCj4gICAJcmV0dXJuIDA7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9kb29yYmVsbC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rvb3Ji
ZWxsLmMKPiBpbmRleCBlYmU3OWJmMDAxNDUuLmY5MDQzNTVjNDRhMSAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZG9vcmJlbGwuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kb29yYmVsbC5jCj4gQEAgLTkxLDcgKzkxLDcgQEAgaW50
IGtmZF9kb29yYmVsbF9pbml0KHN0cnVjdCBrZmRfZGV2ICprZmQpCj4gICAJa2ZkLT5kb29yYmVs
bF9iYXNlID0ga2ZkLT5zaGFyZWRfcmVzb3VyY2VzLmRvb3JiZWxsX3BoeXNpY2FsX2FkZHJlc3Mg
Kwo+ICAgCQkJCWRvb3JiZWxsX3N0YXJ0X29mZnNldDsKPiAgIAo+IC0Ja2ZkLT5kb29yYmVsbF9p
ZF9vZmZzZXQgPSBkb29yYmVsbF9zdGFydF9vZmZzZXQgLyBzaXplb2YodTMyKTsKPiArCWtmZC0+
ZG9vcmJlbGxfYmFzZV9kd19vZmZzZXQgPSBkb29yYmVsbF9zdGFydF9vZmZzZXQgLyBzaXplb2Yo
dTMyKTsKPiAgIAo+ICAgCWtmZC0+ZG9vcmJlbGxfa2VybmVsX3B0ciA9IGlvcmVtYXAoa2ZkLT5k
b29yYmVsbF9iYXNlLAo+ICAgCQkJCQkgICBrZmRfZG9vcmJlbGxfcHJvY2Vzc19zbGljZShrZmQp
KTsKPiBAQCAtMTAzLDggKzEwMyw4IEBAIGludCBrZmRfZG9vcmJlbGxfaW5pdChzdHJ1Y3Qga2Zk
X2RldiAqa2ZkKQo+ICAgCXByX2RlYnVnKCJkb29yYmVsbCBiYXNlICAgICAgICAgICA9PSAweCUw
OGxYXG4iLAo+ICAgCQkJKHVpbnRwdHJfdClrZmQtPmRvb3JiZWxsX2Jhc2UpOwo+ICAgCj4gLQlw
cl9kZWJ1ZygiZG9vcmJlbGxfaWRfb2Zmc2V0ICAgICAgPT0gMHglMDhsWFxuIiwKPiAtCQkJa2Zk
LT5kb29yYmVsbF9pZF9vZmZzZXQpOwo+ICsJcHJfZGVidWcoImRvb3JiZWxsX2Jhc2VfZHdfb2Zm
c2V0ICAgICAgPT0gMHglMDhsWFxuIiwKPiArCQkJa2ZkLT5kb29yYmVsbF9iYXNlX2R3X29mZnNl
dCk7Cj4gICAKPiAgIAlwcl9kZWJ1ZygiZG9vcmJlbGxfcHJvY2Vzc19saW1pdCAgPT0gMHglMDhs
WFxuIiwKPiAgIAkJCWRvb3JiZWxsX3Byb2Nlc3NfbGltaXQpOwo+IEBAIC0xODUsNyArMTg1LDcg
QEAgdm9pZCBfX2lvbWVtICprZmRfZ2V0X2tlcm5lbF9kb29yYmVsbChzdHJ1Y3Qga2ZkX2RldiAq
a2ZkLAo+ICAgCSAqIENhbGN1bGF0aW5nIHRoZSBrZXJuZWwgZG9vcmJlbGwgb2Zmc2V0IHVzaW5n
IHRoZSBmaXJzdAo+ICAgCSAqIGRvb3JiZWxsIHBhZ2UuCj4gICAJICovCj4gLQkqZG9vcmJlbGxf
b2ZmID0ga2ZkLT5kb29yYmVsbF9pZF9vZmZzZXQgKyBpbng7Cj4gKwkqZG9vcmJlbGxfb2ZmID0g
a2ZkLT5kb29yYmVsbF9iYXNlX2R3X29mZnNldCArIGlueDsKPiAgIAo+ICAgCXByX2RlYnVnKCJH
ZXQga2VybmVsIHF1ZXVlIGRvb3JiZWxsXG4iCj4gICAJCQkiICAgICBkb29yYmVsbCBvZmZzZXQg
ICA9PSAweCUwOFhcbiIKPiBAQCAtMjI1LDE3ICsyMjUsMTcgQEAgdm9pZCB3cml0ZV9rZXJuZWxf
ZG9vcmJlbGw2NCh2b2lkIF9faW9tZW0gKmRiLCB1NjQgdmFsdWUpCj4gICAJfQo+ICAgfQo+ICAg
Cj4gLXVuc2lnbmVkIGludCBrZmRfZG9vcmJlbGxfaWRfdG9fb2Zmc2V0KHN0cnVjdCBrZmRfZGV2
ICprZmQsCj4gK3Vuc2lnbmVkIGludCBrZmRfZ2V0X2Rvb3JiZWxsX2R3X29mZnNldF9mcm9tX2Jh
cihzdHJ1Y3Qga2ZkX2RldiAqa2ZkLAo+ICAgCQkJCQlzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnByb2Nl
c3MsCj4gICAJCQkJCXVuc2lnbmVkIGludCBkb29yYmVsbF9pZCkKPiAgIHsKPiAgIAkvKgo+IC0J
ICogZG9vcmJlbGxfaWRfb2Zmc2V0IGFjY291bnRzIGZvciBkb29yYmVsbHMgdGFrZW4gYnkgS0dE
Lgo+ICsJICogZG9vcmJlbGxfYmFzZV9kd19vZmZzZXQgYWNjb3VudHMgZm9yIGRvb3JiZWxscyB0
YWtlbiBieSBLR0QuCj4gICAJICogaW5kZXggKiBrZmRfZG9vcmJlbGxfcHJvY2Vzc19zbGljZS9z
aXplb2YodTMyKSBhZGp1c3RzIHRvCj4gICAJICogdGhlIHByb2Nlc3MncyBkb29yYmVsbHMuIFRo
ZSBvZmZzZXQgcmV0dXJuZWQgaXMgaW4gZHdvcmQKPiAgIAkgKiB1bml0cyByZWdhcmRsZXNzIG9m
IHRoZSBBU0lDLWRlcGVuZGVudCBkb29yYmVsbCBzaXplLgo+ICAgCSAqLwo+IC0JcmV0dXJuIGtm
ZC0+ZG9vcmJlbGxfaWRfb2Zmc2V0ICsKPiArCXJldHVybiBrZmQtPmRvb3JiZWxsX2Jhc2VfZHdf
b2Zmc2V0ICsKPiAgIAkJcHJvY2Vzcy0+ZG9vcmJlbGxfaW5kZXgKPiAgIAkJKiBrZmRfZG9vcmJl
bGxfcHJvY2Vzc19zbGljZShrZmQpIC8gc2l6ZW9mKHUzMikgKwo+ICAgCQlkb29yYmVsbF9pZCAq
IGtmZC0+ZGV2aWNlX2luZm8tPmRvb3JiZWxsX3NpemUgLyBzaXplb2YodTMyKTsKPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaCBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgKPiBpbmRleCA2MmRiNGQyMGVkMzIuLjdjNTYxYzk4
ZjJlMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5o
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaAo+IEBAIC0yMzgs
OSArMjM4LDkgQEAgc3RydWN0IGtmZF9kZXYgewo+ICAgCQkJCQkgKiBLRkQuIEl0IGlzIGFsaWdu
ZWQgZm9yIG1hcHBpbmcKPiAgIAkJCQkJICogaW50byB1c2VyIG1vZGUKPiAgIAkJCQkJICovCj4g
LQlzaXplX3QgZG9vcmJlbGxfaWRfb2Zmc2V0OwkvKiBEb29yYmVsbCBvZmZzZXQgKGZyb20gS0ZE
IGRvb3JiZWxsCj4gLQkJCQkJICogdG8gSFcgZG9vcmJlbGwsIEdGWCByZXNlcnZlZCBzb21lCj4g
LQkJCQkJICogYXQgdGhlIHN0YXJ0KQo+ICsJc2l6ZV90IGRvb3JiZWxsX2Jhc2VfZHdfb2Zmc2V0
OwkvKiBEb29yYmVsbCBkd29yZCBvZmZzZXQgKGZyb20gS0ZECj4gKwkJCQkJICogZG9vcmJlbGwg
dG8gUENJIGRvb3JiZWxsIGJhciwKPiArCQkJCQkgKiBHRlggcmVzZXJ2ZWQgc29tZSBhdCB0aGUg
c3RhcnQpCgpUaGlzIGlzIHN0aWxsIGEgYml0IGNvbnZvbHV0ZWQgYW5kIHNvdW5kcyBiYWNrd2Fy
ZHMuIEkgc3VnZ2VzdCB0aGlzIHdvcmRpbmc6CgogwqDCoMKgIE9mZnNldCBmcm9tIHRoZSBzdGFy
dCBvZiB0aGUgUENJIGRvb3JiZWxsIEJBUiB0byB0aGUgZmlyc3QgS0ZEIApkb29yYmVsbCBpbiBk
d29yZHMKClJlZ2FyZHMsCiDCoCBGZWxpeAoKPiAgIAkJCQkJICovCj4gICAJdTMyIF9faW9tZW0g
KmRvb3JiZWxsX2tlcm5lbF9wdHI7IC8qIFRoaXMgaXMgYSBwb2ludGVyIGZvciBhIGRvb3JiZWxs
cwo+ICAgCQkJCQkgICAqIHBhZ2UgdXNlZCBieSBrZXJuZWwgcXVldWUKPiBAQCAtODIxLDcgKzgy
MSw3IEBAIHZvaWQga2ZkX3JlbGVhc2Vfa2VybmVsX2Rvb3JiZWxsKHN0cnVjdCBrZmRfZGV2ICpr
ZmQsIHUzMiBfX2lvbWVtICpkYl9hZGRyKTsKPiAgIHUzMiByZWFkX2tlcm5lbF9kb29yYmVsbCh1
MzIgX19pb21lbSAqZGIpOwo+ICAgdm9pZCB3cml0ZV9rZXJuZWxfZG9vcmJlbGwodm9pZCBfX2lv
bWVtICpkYiwgdTMyIHZhbHVlKTsKPiAgIHZvaWQgd3JpdGVfa2VybmVsX2Rvb3JiZWxsNjQodm9p
ZCBfX2lvbWVtICpkYiwgdTY0IHZhbHVlKTsKPiAtdW5zaWduZWQgaW50IGtmZF9kb29yYmVsbF9p
ZF90b19vZmZzZXQoc3RydWN0IGtmZF9kZXYgKmtmZCwKPiArdW5zaWduZWQgaW50IGtmZF9nZXRf
ZG9vcmJlbGxfZHdfb2Zmc2V0X2Zyb21fYmFyKHN0cnVjdCBrZmRfZGV2ICprZmQsCj4gICAJCQkJ
CXN0cnVjdCBrZmRfcHJvY2VzcyAqcHJvY2VzcywKPiAgIAkJCQkJdW5zaWduZWQgaW50IGRvb3Ji
ZWxsX2lkKTsKPiAgIHBoeXNfYWRkcl90IGtmZF9nZXRfcHJvY2Vzc19kb29yYmVsbHMoc3RydWN0
IGtmZF9kZXYgKmRldiwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
