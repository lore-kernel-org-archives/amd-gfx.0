Return-Path: <SRS0=hs5v=5E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8F8C4332D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 13:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E42920663
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 13:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c9k4Q1lv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E42920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66456E338;
	Thu, 19 Mar 2020 13:41:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A1B6E338
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 13:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdeDRs2K5F+8OImX0PKjltcKLpNzjJ78VnpAz9jVQDDLZsWxZ7e70q8qKVRQk+Bdjr66HXmYa5CGftGNx/+/dlaSyWB5FDj8WmVgYjViUbXOqvAITcm/Fhb7RxL84Sp8anSSBuDP03hZJrUPkcau2rto4dwe9vyvcbUWObICcOoxhfgEKLTD4K+8i4UFA/bNxqY6eIWjG2sTQldaK9+1wCU49FosQixSi6w8hvDSvWX7MTyEqvPAto84VBeej5PofD2sAROTmVVujQK36n5Vhq+vw6SCgd0qu7KjWzdjB31vJPy59npaCoU34l9/amLwYdNneokkUGNiT5Zygq/cYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ccj0UTRtrWe3CXFWB32aD9tb44Ko1Yzvoe6otI9H+3c=;
 b=J+WsetB4Fvw7RGuOs2mRJF4RdcjedmbDXLxYP14uiRbltw7BF3zxAcDKxAtGUUvrxjgbSujKhIKgXDuZOLbEjPas2/nv3rvr3EMR8vf1ie3KCR/KX0cIkBt53oppKJK5C3nkcxf/ShCkzjNyVUZ0s0tFO1pBFkczw71ks8sNxG43ZJ0g71ZcrudZ+RX3plRKpvRrVrkiHeuCB+25oUk3RJ0K/eUJ5/SBXSdbJwF4AVNsHNckGUYIEBYbPCVv86vGzFqKYQwaH5K2NNSpGDBI0PKFgD9SLVPbat1z/BOWdVWjIg1Ek0MY914mDlRvLlzB5Ub4oidt7Pd8f6QcKgCsiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ccj0UTRtrWe3CXFWB32aD9tb44Ko1Yzvoe6otI9H+3c=;
 b=c9k4Q1lvmVeLdVMJ+VXY7ELDtE/ywxYk8d3hE+KMc1m8AIeLA/wfXjzQ1mBgYL1VtKe0kXGCHvEb7PQXrBgMOAMhB5OKTxfA2O0NUDDZUlSXFkhaeGvkP5IBjY6BaQKHaFHeNaMOcaf5yCTm39I1xdXVmhiMYXxj/p6Eg1syHZA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB2894.namprd12.prod.outlook.com (2603:10b6:208:10a::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Thu, 19 Mar
 2020 13:41:07 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 13:41:07 +0000
Date: Thu, 19 Mar 2020 21:40:58 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: Re: [PATCH] drm/amdkfd: fix the wrong no space return while acquires
 packet buffer
Message-ID: <20200319134056.GA4918@jenkins-Celadon-RN>
References: <1584615099-8115-1-git-send-email-ray.huang@amd.com>
 <7E5FA008-9DFF-445E-A82E-DB825A3DE614@amd.com>
Content-Disposition: inline
In-Reply-To: <7E5FA008-9DFF-445E-A82E-DB825A3DE614@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR06CA0001.apcprd06.prod.outlook.com (2603:1096:202:2e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Thu, 19 Mar 2020 13:41:05 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2535b752-e912-45b2-42f4-08d7cc0b2cf8
X-MS-TrafficTypeDiagnostic: MN2PR12MB2894:|MN2PR12MB2894:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2894FA34C764EFA7E2101FBFECF40@MN2PR12MB2894.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(199004)(8936002)(26005)(52116002)(6496006)(9686003)(5660300002)(54906003)(316002)(4326008)(6862004)(81156014)(66476007)(8676002)(66556008)(55016002)(81166006)(66946007)(478600001)(33656002)(1076003)(186003)(956004)(16526019)(966005)(2906002)(86362001)(6636002)(45080400002)(33716001)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2894;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iz1x9De7M81LSYV0CIt49YS2w9umTcI48ZpvS1qZtHZyRyIqaKJZItxBOUyHR1sMk6m5F/wWEKm6ZtF8NsqVpyOfo/3zuzLU/Zjad7R+30EixUTpbBwHZ8xp+eP/fdmuoCP11PwJMnitp9yKlqOfZKIGqZjsJVvSgRM3wn0v61QUmlr2vM+ykVsQ+fbGPP/TJZIc4FoxlgSNNXdDMr16KtBVozMU0X/lNPS8eXCMSx+xda5RgkJGm8fIZwBpmBn7HTBL93NCPDy0wb2z/Ep17+u3D6nHnL2+DFKZJoiJNE6EfTLczYuSosHKgd2JP5BY4ow1cR6NTe9lYBGISHStK2dxYnoP2kF0Ub5P5h2jUaG80V3nP2gIFPt25vJAm+v8UqNe4N/rKrMxJr+GpoPZSHvvyNvFeb2iOEeqMjqOe3c+nC7AyPo2GcZSit84TSpgoJVgp0HYIVHDxmceQrUEJeX1igeJ95hLHKZkVVLwMIY=
X-MS-Exchange-AntiSpam-MessageData: 2nPNBhSd7ad7DoZC7K3jOc5W6GbrWjDyW/bmUhTFGGYOt0VI778jPckIcsSkQgZ8fiLPTsNd8TikAtiMZ574C8fZE0OUkOpdINf36e4Yy8DOCdfmNvzI1aa2wg9hnyP6gDPoJeRzLT8IOtkYfEFppQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2535b752-e912-45b2-42f4-08d7cc0b2cf8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 13:41:06.9257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51AinIuEHtf1V8JJ/eFwRgU2RPBazeS8L3cwBH6UfrwMuRZ6BVXqyQ04k/ag6rikMww+k2twDS21fKsVZpmFeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2894
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBNYXIgMTksIDIwMjAgYXQgMDc6NDI6MDRQTSArMDgwMCwgUGFuLCBYaW5odWkgd3Jv
dGU6Cj4gCj4gCj4gPiAyMDIwxOoz1MIxOcjVIDE4OjUxo6xIdWFuZyBSdWkgPHJheS5odWFuZ0Bh
bWQuY29tPiDQtLXAo7oKPiA+IAo+ID4gVGhlIHF1ZXVlIGJ1ZmZlciBpbmRleCBzdGFydHMgZnJv
bSBwb3NpdGlvbiAwLCBzbyB0aGUgYXZhaWxhYmxlIGJ1ZmZlciBzaXplCj4gPiB3aGljaCBzdGFy
dHMgZnJvbSBwb3NpdGlvbiAwIHRvIHJwdHIgc2hvdWxkIGJlICJycHRyIiBpbmRleCB2YWx1ZS4g
V2hpbGUgdGhlCj4gPiBwYWNrZXRfc2l6ZV9pbl9kd29yZHMgPT0gcnB0ciwgdGhlIGF2YWlsYWJs
ZSBidWZmZXIgaXMganVzdCBnb29kIGVub3VnaC4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogSHVh
bmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPiA+IC0tLQo+ID4gZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZS5jIHwgMiArLQo+ID4gMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVsX3F1ZXVlLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfa2VybmVsX3F1ZXVlLmMKPiA+IGluZGV4IGJhZTcwNjQuLjQ2NjdjOGYg
MTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVsX3F1
ZXVlLmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVl
dWUuYwo+ID4gQEAgLTI2Myw3ICsyNjMsNyBAQCBpbnQga3FfYWNxdWlyZV9wYWNrZXRfYnVmZmVy
KHN0cnVjdCBrZXJuZWxfcXVldWUgKmtxLAo+ID4gCQkvKiBtYWtlIHN1cmUgYWZ0ZXIgcm9sbGlu
ZyBiYWNrIHRvIHBvc2l0aW9uIDAsIHRoZXJlIGlzCj4gPiAJCSAqIHN0aWxsIGVub3VnaCBzcGFj
ZS4KPiA+IAkJICovCj4gPiAtCQlpZiAocGFja2V0X3NpemVfaW5fZHdvcmRzID49IHJwdHIpCj4g
PiArCQlpZiAocGFja2V0X3NpemVfaW5fZHdvcmRzID4gcnB0cikKPiAKPiBycHRyIHNob3VsZCBh
bHdheXMgYmUgPiB3cHRyIHVubGVzcyByaW5nIGlzIGVtcHR5Lgo+IAo+IHNheSwgcnB0ciBpcyA0
LCBwYWNrZXRfc2l6ZV9pbl9kd29yZHMgaXMgNC4gVGhlbiB3cHRyIGNoYW5nZXMgZnJvbSAwIHRv
IDQsIHRoYXQgaXMgaWxsZWdhbC4KPiAKCkhleSwgeGluaHVpLCB5ZXMuIDotKQoKU2VlIHRoZSBj
b21tZW50ICJ3ZSBjYW4gb25seSB1c2UgdXAgdG8gcXVldWVfc2l6ZV9kd29yZCAtIDEgZHdvcmRz
IiwgdGhhdAp3ZSBjYW5ub3QgdXNlIHRoZSB3aG9sZSBwYWNrZXQgc2xvdHMgaW4gdGhlIHF1ZXVl
LCBpdCdzIHRvIGRpZmZlcmVudGlhdGUKZW1wdHkgYW5kIGZ1bGwgY2FzZXMuCgpUaGFua3MsClJh
eQoKPiAKPiA+IAkJCWdvdG8gZXJyX25vX3NwYWNlOwo+ID4gCj4gPiAJCS8qIGZpbGwgbm9wcywg
cm9sbCBiYWNrIGFuZCBzdGFydCBhdCBwb3NpdGlvbiAwICovCj4gPiAtLSAKPiA+IDIuNy40Cj4g
PiAKPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+ID4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
PiA+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUy
RmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q3hpbmh1aS5wYW4lNDBhbWQuY29tJTdDZGI5OGNm
ZDg0Yjc2NGU3N2QyMGUwOGQ3Y2JmMzhkZmYlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRl
MTgzZCU3QzAlN0MwJTdDNjM3MjAyMTE5OTUwMTE5OTA3JmFtcDtzZGF0YT1tcXJsMnVvb1E5NURu
czRsNkN0bW1PQkNtJTJGcVp5dzFwWDQ4VkEyMG1sWlklM0QmYW1wO3Jlc2VydmVkPTAKPiAKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
