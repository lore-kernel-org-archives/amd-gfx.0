Return-Path: <SRS0=44+a=ZL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE921C432C3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 23:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49EB222C2
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 23:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49EB222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FE426E398;
	Tue, 19 Nov 2019 23:51:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770052.outbound.protection.outlook.com [40.107.77.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B44056E398
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 23:51:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx4mNuOPC/16yw3GT2DKocQcFVw3oEEf0BkFhrrML1tw0TEC/2p7jwXRUKCpjmzVNVZ+dkuwu4Z6ONEU5KFE7W8S/l/Bs2iDjXnh/8HofIuIoAdVi6dBRdf0F0Pci8xhR5fijrWzhC0/UmFe+3JRkvbjMcjg2zh9bNfLQI/Z4TF5CdlDwfd1LKQLAoMm3y9PgVTKYBnuOzR58U2Jd/rzgJMOhaiNmKWbKJ31WDT5UabMeS4/blITA1EL37SROIfYPdzA5fZqYPLVY0V3DMFgRuuHXCkQ5OiZ5RUqIRxGJV/EW5wDxjWJ5wNihYux0iiAiAT4FT/Law8qzP2X/8miig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBpr7D4fXTxEGqOvYJVfoZtUhFXa7Jd/7r3+ajXX9wI=;
 b=IXGEl6uZhxZkiubm7qXLfKscfHYuqwp5FH/FINolhuTSVxhyU+NXMVD0qCSz7Vtz8ZVOgFwrGXxbGBYQf+rgzC0ZhD+ssOfkw9kUxbqn4nRnST5LkQPAuELhtuPQlcpO+LYAWTnSIo6/frrbYAA11nRe6+PT2U2KMqwzfYYRYQeCPGev87rKKhQwId/2Vwhfsom5iKXTKPXNB3DcNbJToymOBCukLG+ndQX6EisZxyhl8M76kCCkp7pSdKKAK+Cw3UovfRry2EVRdIXYOikmSuBQ4hQ19IyJK7xNYm1TsIV2LdaVVweFX4JLNqwYtuszaTzTNmgLbHefcmxSjaQlQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN8PR12MB3348.namprd12.prod.outlook.com (20.178.211.221) by
 BN8PR12MB3618.namprd12.prod.outlook.com (20.178.212.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 23:51:44 +0000
Received: from BN8PR12MB3348.namprd12.prod.outlook.com
 ([fe80::a158:1dcd:18f4:8b81]) by BN8PR12MB3348.namprd12.prod.outlook.com
 ([fe80::a158:1dcd:18f4:8b81%3]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 23:51:44 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu: enable TMZ bit in FRAME_CONTROL for gfx10
To: Aaron Liu <aaron.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1574054316-2802-1-git-send-email-aaron.liu@amd.com>
 <1574054316-2802-5-git-send-email-aaron.liu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <de8125e7-a483-4701-7d29-2ba33ca3e21d@amd.com>
Date: Tue, 19 Nov 2019 18:51:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <1574054316-2802-5-git-send-email-aaron.liu@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::23)
 To BN8PR12MB3348.namprd12.prod.outlook.com
 (2603:10b6:408:47::29)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e98d25d9-3fd7-49b2-d514-08d76d4b6e8f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3618F2ED207139D1D8628A92994C0@BN8PR12MB3618.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 022649CC2C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(199004)(189003)(4326008)(186003)(6506007)(386003)(6116002)(14444005)(58126008)(305945005)(76176011)(6246003)(65806001)(53546011)(52116002)(478600001)(2486003)(36756003)(81156014)(2906002)(8676002)(446003)(316002)(99286004)(4001150100001)(6486002)(229853002)(5660300002)(230700001)(66066001)(65956001)(47776003)(11346002)(81166006)(26005)(6436002)(6512007)(25786009)(3846002)(8936002)(23676004)(44832011)(66476007)(66556008)(66946007)(31696002)(86362001)(31686004)(50466002)(486006)(4744005)(14454004)(7736002)(2616005)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3618;
 H:BN8PR12MB3348.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEUYBEzQWtzMOKKDg48rDXiSZAX1Qyfn5JTdkUhAXuU3ye3tus5qt9dDhZAgipJdiBW9U8mcRYibVbz8XeCp4lWTG4joXjwO5dg0h9EuanLD/hPG8Q0++VnEjB69rvEYL/io9j9ncuYGXsAl7lqmB3lLAo8k3YK+QzXrYnk6YiAPPEto/HjA+1CN0UxeEe0y8djTMUWLy/xirFuwLJ/MHCMekxLXBR2SzaVwVoSPEhub1c57kwNYIUji4aR4J0r4ZUOdwzXIzE+/SN+KgqIJrtC6hZGXNfCu4qKTRe0ooVXrUkMFYYCAZ9/tsbBILyyURDYsFl3AvIDmrWsjm86xP0u3CxIxLX3VVWIEX3SFHlgS0nS89hUEIVwXX6Yb+xl5RR/9iukgsYWrQPbAa607IFLdKSKciSPQMqUz1AUmTAZfdnmZUKsPe1pYjBeiJbER
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98d25d9-3fd7-49b2-d514-08d76d4b6e8f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 23:51:44.4337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8Ckj7Upfvguj7WEcenTjyBr0htDKETDlDc7NBycbXRVUeOze44817w/GkHs5EMe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3618
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBpr7D4fXTxEGqOvYJVfoZtUhFXa7Jd/7r3+ajXX9wI=;
 b=Ofr/nbXEgh+6Q4Q2rRIe3kPW4hifoPu31a/xuf0nZlvCPay1Jra9mHwHIw71R1+chebqVmLh4V95T0K2fdSuDPjBBIBDRyBkwPXDzqftI463hEjJev3gPNlYbHoBCWeu3+ZNFM1D2SkSwj+pOeFhicOXGwNSfnsA3vpkDqthXQU=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Christian.Koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191119235142.gKqK79G7AQrzHtp1QvXyjt-suRy73HFKOI0bdk957vs@z>

T24gMjAxOS0xMS0xOCAxMjoxOCBhLm0uLCBBYXJvbiBMaXUgd3JvdGU6Cj4gVGhpcyBwYXRjaCBl
bmFibGVzIFRNWiBiaXQgaW4gRlJBTUVfQ09OVFJPTCBmb3IgZ2Z4MTAuCj4gCj4gU2lnbmVkLW9m
Zi1ieTogQWFyb24gTGl1IDxhYXJvbi5saXVAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92MTBfMC5jCj4gaW5kZXggZDZlMTFlZS4uOGRjZTA2NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4gQEAgLTQ1ODgsNyArNDU4OCw3IEBAIHN0YXRpYyB2b2lk
IGdmeF92MTBfMF9yaW5nX2VtaXRfY250eGNudGwoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+
ICAJCWdmeF92MTBfMF9yaW5nX2VtaXRfY2VfbWV0YShyaW5nLAo+ICAJCQkJICAgIGZsYWdzICYg
QU1ER1BVX0lCX1BSRUVNUFRFRCA/IHRydWUgOiBmYWxzZSk7Cj4gIAo+IC0JZ2Z4X3YxMF8wX3Jp
bmdfZW1pdF90bXoocmluZywgdHJ1ZSwgZmFsc2UpOwo+ICsJZ2Z4X3YxMF8wX3JpbmdfZW1pdF90
bXoocmluZywgdHJ1ZSwgdHJ1c3RlZCk7Cj4gIAoKRG8geW91IG1lYW4gaGVyZSAidHJ1ZSIgKHRo
ZSBvcHBvc2l0ZSBvZiAiZmFsc2UiKSBhcyBvcHBvc2VkIHRvICJ0cnVzdGVkIj8KClJlZ2FyZHMs
Ckx1YmVuCgo+ICAJZHcyIHw9IDB4ODAwMDAwMDA7IC8qIHNldCBsb2FkX2VuYWJsZSBvdGhlcndp
c2UgdGhpcyBwYWNrYWdlIGlzIGp1c3QgTk9QcyAqLwo+ICAJaWYgKGZsYWdzICYgQU1ER1BVX0hB
VkVfQ1RYX1NXSVRDSCkgewo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
