Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2A0C3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 12:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4088D20863
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 12:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TnC3TvXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4088D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E57D46E86D;
	Tue,  3 Mar 2020 12:36:09 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760058.outbound.protection.outlook.com [40.107.76.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AAD66E86D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 12:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VylczuK3SQcIDLGCldsyWxY7UJpc5xISe80pY3XXaHtZ4pBARhVpWHV8JsReujPMt8FZfn6/ybzBaS2R2CKbOwjDqeWAuwq1p7XUvQf9sCqz6LyEjbkWldlUSpaZbNp4WpGaexM3uEuHOdTJ3oyzpVbg7y/Y07SrQkkLQveJmVLeN+4wpRBKk+yymq+0RObZn2wvTOmYrDWU0HtDieI6pNTkjhLgtEr2wsPunaFatGhtDNsYiN6/ISpe1R8RPMxv4ciwZSxOTa5il5LwIKqZbKYAWBx7Wom7+DuGfnwwmOaJD2W7wuzDDax1AQ0fp782VXuxKAmsGycK7P4JqPwDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47lP3Xhdd/B+ESkInjwp5lFbDalUzpjBXSapS5LmJUI=;
 b=bcLvgI4wNVRu1R+ztFWy2sBRcyvfzRsenXtJ/iQia+J71pyd7Dgsy/EH1GXlFJNfWnl1Ig/6FqtV4LZI1Xeq+PF969A2m0K5r2A93Iq+pp1iwq9/IocQtrLjYSooUCq1cS5Q/UL7YAsRejlspIP0Mdot6xyWbrYunlUQmE/0y/RgFWxBNDo9tNXJ0ssRXDriMYkQqx0FSsIIhVNyTT6QSXwB8eamd6MHTPDGKLXJOJ3ObkzD9E2AmjtzgGU9Epwk5+M0hBTifUk4tpfAA7OaetrFvFTB2lRRpiEYRk6K/m2Tlt0f+IMI5nPx+cMeSW1bWvFFKfjhHn8Y7QeOr8iElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47lP3Xhdd/B+ESkInjwp5lFbDalUzpjBXSapS5LmJUI=;
 b=TnC3TvXjK2xPYqxm1TNmM0BXSgD6EwnK2GAc5AGDnw7IhGM/udjBiZ4VC2up9YLyxoTjsGHJvb1arn7PsJBargRZC4NrEd11DtcgXF+xG6mcN2N6Jm86R8/EKlPRQrLavSwN3a1NF8TR3UiQwh1j5Ony2VQrobI1zM/owZDHh3s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1259.namprd12.prod.outlook.com (2603:10b6:3:75::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Tue, 3 Mar 2020 12:36:07 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 12:36:06 +0000
From: Nirmoy <nirmodas@amd.com>
Subject: Re: [PATCH v5 1/4] drm/amdgpu: set compute queue priority at mqd_init
To: christian.koenig@amd.com, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200302125836.56915-1-nirmoy.das@amd.com>
 <10f79f2c-4baf-e004-d75b-68836ea2e5bc@amd.com>
 <e98f6ea5-bb79-3c8a-354a-33e1b7a53e4b@amd.com>
 <97941567-fa4f-747e-44a8-7d61257ee354@gmail.com>
Message-ID: <606c06d5-c02e-ad3a-b72a-9c1892742d86@amd.com>
Date: Tue, 3 Mar 2020 13:39:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <97941567-fa4f-747e-44a8-7d61257ee354@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR04CA0142.eurprd04.prod.outlook.com (2603:10a6:207::26)
 To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f27:f600:ccd8:21cd:e339:f0da]
 (2003:c5:8f27:f600:ccd8:21cd:e339:f0da) by
 AM3PR04CA0142.eurprd04.prod.outlook.com (2603:10a6:207::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18 via Frontend Transport; Tue, 3 Mar 2020 12:36:05 +0000
X-Originating-IP: [2003:c5:8f27:f600:ccd8:21cd:e339:f0da]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0d99d1b-9e75-468a-2b62-08d7bf6f719a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1259:|DM5PR12MB1259:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB125914E862A05DA2DB4E1ECA8BE40@DM5PR12MB1259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(189003)(199004)(53546011)(36756003)(8936002)(66946007)(66574012)(2906002)(66556008)(66476007)(8676002)(52116002)(31696002)(478600001)(81166006)(81156014)(4326008)(16526019)(186003)(316002)(6486002)(31686004)(2616005)(5660300002)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1259;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cc7uPMnHSqCky4vhH9JkYHPTsYlz0KqU/kjAqECszQ43IGT4p+9wO3xe3mFIPOAPn9EWox8J7O+2HJZ1GCtoGB26lCO1JSBf9feV3/eQ1s+3xnyO5WfPKySLGbGk7NK4RF/JNRJS6vELFItB+cPrkXFHIaR0WY3XXFiExu2MgwCOV+7c6t8X+u0lD7NtFLHPyGxnBqenxXvwFrMmxsE5N90xaRgBsO4cxnRq2gIusZOTMnKh6lhdqOxzoduH0Ceaezp9PbnkHNk9wYzAsXouF8zrDzPbbNFO/Z09yKxAHBA3dbV8ndE71jbC/R09/aW4swG7Hcv5I05Qdsb7fd/CtbfZpcjELPI1/ePSiIb7EXPWWs81nGqTSMGJU5FGcc3qv/xszxGeRtbOjS0P8LnqlayT5bNLuxMAFmFkJuYwi2KCenxIMccAQHP2PT18UqFt
X-MS-Exchange-AntiSpam-MessageData: 9XUl1dbferVQcNAlZ0KSL002pAIzmNC5YGqjEblql2yXlwS3FkQT9jZil8AbLSuGBFiRch1V0YHVrFT5rgdxCQ7XtTIC601/IthNpXGTU46e5IYiWvnpV/v9aFAuJooMIuJXE5FTYF9yF+sQIcuw2MBPfsbHFz1JxX1iPPvhWLf1hpwO54Tpc5wb5buO7x+8zwelYbXb0yI8KL29bc1gyg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d99d1b-9e75-468a-2b62-08d7bf6f719a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 12:36:06.6697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDn6a8xKs9RtDfXEeDX5LF6uOTn32typh8IFWo6vfna/+bjzkHrf/0U+dgwV91YWLMGQ59MFBkXUende7OGVFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1259
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDMvMi8yMCA2OjE2IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4+IG9yIGVsc2UK
Pj4KPj4gQEAgLTIyMiw3ICsyMjksOCBAQCBzdHJ1Y3QgYW1kZ3B1X3Jpbmcgewo+PiDCoMKgwqDC
oMKgwqDCoCBzdHJ1Y3QgbXV0ZXjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByaW9yaXR5X211dGV4
Owo+PiDCoMKgwqDCoMKgwqDCoCAvKiBwcm90ZWN0ZWQgYnkgcHJpb3JpdHlfbXV0ZXggKi8KPj4g
wqDCoMKgwqDCoMKgwqAgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBwcmlvcml0eTsKPj4gLcKgwqDCoMKgwqDCoCBib29swqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZ2Z4X3BpcGVfcHJpb3JpdHk7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoCBl
bnVtIGdmeF9waXBlX3ByaW9yaXR5wqAgcGlwZV9wcmlvcml0eTsKPj4KPj4gZG9lc24ndCB3b3Jr
IGJlY2F1c2Ugb2YgY29tcGlsYXRpb24gZXJyb3I6ICIgZmllbGQg4oCYcGlwZV9wcmlvcml0eeKA
mSAKPj4gaGFzIGluY29tcGxldGUgdHlwZSIKPgo+IE1obSwgbGV0IG1lIGFzayBmcm9tIHRoZSBv
dGhlciBkaXJlY3Rpb246IFdoYXQgaXMgdGhhdCBnb29kIGZvciBpbiB0aGUgCj4gZmlyc3QgcGxh
Y2U/Cj4KPiBBcyBmYXIgYXMgSSBjYW4gc2VlIHRoaXMgaXMganVzdCB0byBjb21tdW5pY2F0ZSB0
byB0aGUgY3R4IGhhbmRsaW5nIAo+IHdoYXQgcHJpb3JpdHkgYSBodyByaW5nIGhhcywgcmlnaHQ/
Cj4KPiBCdXQgd2hhdCB3ZSBhY3R1YWxseSBuZWVkIGluIHRoZSBjdHggaGFuZGxpbmcgaXMgYW4g
YXJyYXkgb2YgcmluZyB3aXRoIAo+IG5vcm1hbCBhbmQgaGlnaCBwcmlvcnR5LiBTbyB3aHkgZG9u
J3Qgd2UgY3JlYXRlIHRoYXQgaW4gdGhlIGZpcnN0IHBsYWNlPwoKRG8geW91IG1lYW4gdG8gY3Jl
YXRlIHR3byBhcnJheSByaW5nIGZvciBib3RoIHByaW9yaXR5ID8gV2Ugc3RpbGwgbmVlZCBhIAp3
YXkgdG8gZGV0ZWN0IHJpbmcgcHJpb3JpdHkgaW4gY3R4IHRvIHBvcHVsYXRlIHRob3NlIGFycmF5
IGluIAphbWRncHVfY3R4X2luaXRfc2NoZWQuCgpJIHRoaW5rIHRoZSBwcmV2aW91cyBhcHByb2Fj
aCB0byBoYXZlIGJvb2wgdG8gaW5kaWNhdGUgcmluZyBwcmlvcml0eSAKc3RhdHVzIHNob3VsZCBi
ZSBnb29kIGVub3VnaCBmb3IgY3R4LiBMZXQgbWUgc2VuZCB0aGUgbmV4dCB2ZXJzaW9uIG9mIAp0
aGUgcGF0Y2gKCnRvIGV4cGxhaW4gd2hhdCBJIG1lYW4uCgpSZWdhcmRzLAoKTmlybW95Cgo+Cj4g
UmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
