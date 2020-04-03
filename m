Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39475C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 20:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAAE2206E9
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 20:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FRW5UbEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAE2206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 857886EC71;
	Fri,  3 Apr 2020 20:23:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56E4B6EC71
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 20:23:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ95Ynj2VRLkXJUz4pLTppa8BSwPP1XGxmJDDBipg2K0JzcqrKME7cIri/ji6zym/MUhQvWd7io9ZJjPuT23rhO3+p420fRY7LnA7lkmPA8CdRz0+Ul84p08wlCRRCTPUI2icc5VIYzW76+jRIS9CiiLZkhCDpZCwdc0jDPLRG8/YqiuUYihMo1Y0WaL34ekHkKqwhFQIot8WhgzmDeFNhHRAOfCRSIRuqOAedZk/4OLJvBrNjUYUo+wdtXzwIdSyOm+QTMqmV7vn0N80uw9S2ivFG6PLspChai5xRQlxt8Cu/GkSKJWTbJ+R6FMmI7dCP0MAADo0QTsK9WJT5KdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDwSR8Aw/S2VRLce5ls/nsBBhAXWFiPmIQNd3SVky7U=;
 b=YTpNwlQs5SSyl+IxnhCa5+x5n7Zuf0pExUb/HNaSuFTrOG/IaHA48lW0PHo2KGPdSqcL/Zs2BgSC6PseZy1V15PWaLlejz880U3nuFEEGGeu8a9qnwS2v4/VfT8XmIlDkf5S9AIlgaxDhM6B09RKOQxFJdihwprC8K6/Q0yM8qWAdEm7d5lgQ24ZFBZtdJrv8o/BWHGjSHwFLHLYKdywTgif5mxsk3ZjH3z/UFN7UV8dFDuiCpdPP1A8M09m5OAa5XHjPDFijG1wpwzINm2SVbeSN9Q+3dkZl1aw4MWuxLCLOfCU9in339ivzvmXGo8PcsgZYwPMN79r8jIVflmTag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDwSR8Aw/S2VRLce5ls/nsBBhAXWFiPmIQNd3SVky7U=;
 b=FRW5UbEsNskMdAg0YBPEeVLmXWm0AS3kg0nRDdgO/WjZWa/dr+vSovAXtwkYvFj8JMbvvsZkXTt6Mxc9NxhhvPqpBU7zgaPe8LBHgQPq3gdnVFO3Kv0iWusKgc+qcFTFGJhr5Gf5cp04E8v69D91SllePXIPM6xTxfYSOf0rJHo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2509.namprd12.prod.outlook.com (2603:10b6:802:29::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Fri, 3 Apr
 2020 20:23:11 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 20:23:11 +0000
Subject: Re: [PATCH] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset
To: Jack Zhang <Jack.Zhang1@amd.com>, amd-gfx@lists.freedesktop.org
References: <1585890173-10429-1-git-send-email-Jack.Zhang1@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <172d9d3c-9f88-4545-4203-457a3c5323e5@amd.com>
Date: Fri, 3 Apr 2020 16:23:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1585890173-10429-1-git-send-email-Jack.Zhang1@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::44) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTXPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Fri, 3 Apr 2020 20:23:10 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 07f46f1a-eac6-43bf-2828-08d7d80cd44d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2509:|SN1PR12MB2509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2509FF4A96DF13B68EA834DC92C70@SN1PR12MB2509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(44832011)(2616005)(66556008)(956004)(52116002)(36756003)(66476007)(8936002)(66946007)(6486002)(16576012)(31696002)(2906002)(16526019)(31686004)(81166006)(316002)(5660300002)(26005)(86362001)(81156014)(8676002)(186003)(478600001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/RZ4JhXql5Xaiq29MQU2uYWYRyHcecFxg6etSH/n1Y4K1iwJOo5nEE2MGLh8vmIxsKxkFOnCPiv3Z2NbUAG9lmrpPLLtuIq3dOGM2AW+AGmsrp9redIMb++wdIAcJnv/EwxQr5b7KhNHWsCVkmyqUXo6Uky6zfz903OiHV1eCiEpRJPj33757hsz+CsT7+lIEIfP3Ghg3GTixxalvOmR5M0ItqXxVeR6YM2EQ21F1Fv9SfK+F14EPc3hSne/JujgFEXcpwWv7qKbErwWgBsq80GmevGLx17qCaq+Qqk00hwefw77wH2/DnTI+dlytxUnnOOpNpgfnJNRKDPBxfGSKzfD/zHGWxQB8Qytkgpy2ovyXhlD5RCKAgyn+ncV+iLOCQCKFrA9zzYH0sdW+wCGeLjdvpIHDG/6qqfPa7F4tjGoOWYKhKQgU9i52D963Cu
X-MS-Exchange-AntiSpam-MessageData: /s2GUENPCFGB7K7oNijKsrbI/bS3QisOjB3smbqantdVuuh3Ef04Q52Bj5kTvhy0ZMr20EkcjIkzAwTdl9bdp5oVMYtkYnElCLTucJyKYMQ65oqEtVJgRy9rk8VbH/AJLkmSDOAlgZ4dxvR8Lu+Ofg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f46f1a-eac6-43bf-2828-08d7d80cd44d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 20:23:11.1806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8s64SvytXEhwjMJ/wpqaz1p9W/cPBB10wv5J/s9Fc4ZaHsA8fCzVmxD3gmxgSZJ1lJyPu4BXdnu1zHW/6aDsBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2509
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

UGxlYXNlIHNlcGFyYXRlIHRoZSB0d28gZml4ZXMgaW50byBzZXBhcmF0ZSBjb21taXRzLgoKSSdk
IGxpa2UgdG8gc2VlIGEgYmV0dGVyIGV4cGxhbmF0aW9uIGZvciB0aGUgY2hhbmdlcyBpbgprZ2Rf
aHFkX2Rlc3Ryb3kuwqAgVGhlIEdGWDkgdmVyc2lvbiBhbHJlYWR5IGhhcyBhIHJldHVybiAtRUlP
IGluIGNhc2UKaXQncyBpbiBhIEdQVSByZXNldC4gSSB3b3VsZCBhZ3JlZSB3aXRoIHBvcnRpbmcg
dGhhdCB0byBHRlgxMC4gQnV0IHdoeQpkbyB3ZSBuZWVkIHRvIHJldHVybiAwIG9ubHkgaW4gdGhl
IFNSSU9WIGNhc2U/CgpSZWdhcmRzLArCoCBGZWxpeAoKQW0gMjAyMC0wNC0wMyB1bSAxOjAyIGEu
bS4gc2NocmllYiBKYWNrIFpoYW5nOgo+IGtmZF9wcmVfcmVzZXQgd2lsbCBmcmVlIG1lbV9vYmpz
IGFsbG9jYXRlZCBieSBrZmRfZ3R0X3NhX2FsbG9jYXRlCj4KPiBXaXRob3V0IHRoaXMgY2hhbmdl
LCBzcmlvdiB0ZHIgY29kZSBwYXRoIHdpbGwgbmV2ZXIgZnJlZSB0aG9zZSBhbGxvY2F0ZWQKPiBt
ZW1vcmllcyBhbmQgZ2V0IG1lbW9yeSBsZWFrLgo+Cj4gdjI6YWRkIGEgYnVnZml4IGZvciBraXEg
cmluZyB0ZXN0IGZhaWwKPgo+IFNpZ25lZC1vZmYtYnk6IEphY2sgWmhhbmcgPEphY2suWmhhbmcx
QGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmRfZ2Z4X3YxMC5jIHwgMyArKysKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2FtZGtmZF9nZnhfdjkuYyAgfCAzICsrKwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMgICAgICAgICB8IDIgKysKPiAgMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkX2dmeF92MTAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmRfZ2Z4X3YxMC5jCj4gaW5kZXggNGVjNmQwYy4uYmRjMWY1YSAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92MTAuYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3YxMC5jCj4gQEAg
LTU0Myw2ICs1NDMsOSBAQCBzdGF0aWMgaW50IGtnZF9ocWRfZGVzdHJveShzdHJ1Y3Qga2dkX2Rl
diAqa2dkLCB2b2lkICptcWQsCj4gIAl1aW50MzJfdCB0ZW1wOwo+ICAJc3RydWN0IHYxMF9jb21w
dXRlX21xZCAqbSA9IGdldF9tcWQobXFkKTsKPiAgCj4gKwlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFk
ZXYpICYmIGFkZXYtPmluX2dwdV9yZXNldCkKPiArCQlyZXR1cm4gMDsKPiArCj4gICNpZiAwCj4g
IAl1bnNpZ25lZCBsb25nIGZsYWdzOwo+ICAJaW50IHJldHJ5Owo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYwo+IGluZGV4IGRmODQxYzIu
LmMyNTYyZDYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2FtZGtmZF9nZnhfdjkuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ2Z4X3Y5LmMKPiBAQCAtNTQxLDYgKzU0MSw5IEBAIGludCBrZ2RfZ2Z4X3Y5X2hx
ZF9kZXN0cm95KHN0cnVjdCBrZ2RfZGV2ICprZ2QsIHZvaWQgKm1xZCwKPiAgCXVpbnQzMl90IHRl
bXA7Cj4gIAlzdHJ1Y3QgdjlfbXFkICptID0gZ2V0X21xZChtcWQpOwo+ICAKPiArCWlmIChhbWRn
cHVfc3Jpb3ZfdmYoYWRldikgJiYgYWRldi0+aW5fZ3B1X3Jlc2V0KQo+ICsJCXJldHVybiAwOwo+
ICsKPiAgCWlmIChhZGV2LT5pbl9ncHVfcmVzZXQpCj4gIAkJcmV0dXJuIC1FSU87Cj4gIAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBpbmRleCA4ZmFhYTE3
Li5lM2Y3NDQxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYwo+IEBAIC0zODU0LDYgKzM4NTQsOCBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfcmVz
ZXRfc3Jpb3Yoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gIAlpZiAocikKPiAgCQlyZXR1
cm4gcjsKPiAgCj4gKwlhbWRncHVfYW1ka2ZkX3ByZV9yZXNldChhZGV2KTsKPiArCj4gIAkvKiBS
ZXN1bWUgSVAgcHJpb3IgdG8gU01DICovCj4gIAlyID0gYW1kZ3B1X2RldmljZV9pcF9yZWluaXRf
ZWFybHlfc3Jpb3YoYWRldik7Cj4gIAlpZiAocikKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
