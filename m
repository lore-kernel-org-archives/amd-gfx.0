Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5466DC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 20:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA14964E15
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 20:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA14964E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C726E197;
	Mon, 22 Feb 2021 20:59:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB996E197
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 20:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeXKvx4fvcajltQXLeX2gonL6wyjeBw8X/gli66RvPVIJOtPy2ypyznEMFc3Emm3DJHJg8t1ORgSmaXvMnhv8i7hammvbfHDsWB0peBAgUZ3Air/0tM5arMDV4Jikhnlar2sbvGpnNitW70/ovFHH0peZL+es8xuQu/lznRlhbtWEntewh+E4DvpYVnRmjSPZCP8tHh/LtK+pI7gTcrfiMLdivCvHfHz/TH8Ikumlmp47G/E8XuATjP2sGGSrT2EuXKt/FFpxUT2pTae5nxPwmzn7+wL5oZZq7J6CXHEj8d8QDApAWpXnqGOsM8oMHNDqFeb3gsaUCRcQJd35wlAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hsz0l1hlMTN3+ZNZW93Bcx8PmYrbt5kPfdDrBublKMs=;
 b=ZhfGU8p2zb5B8boXsgs3XO3OHzJG49LXd+w3ktx+hJPUHQvK6/56ichGvfByCUxWNWtX218ct3wkoNa1Z3EWhCG58mOikC3whhiSzAR7OdmcRv2FNxUbzkmjwjHUhM5wrnTToHNkf46eqTbC6/NR/gocAj4cF4LnqEqAWsITBTvVHXGVTj2ArTD8zz5U1teacs0B9kfihqrsIw1NSU7hEygOGRXEgdrUO3MaNbNaYdWP8ak/CzfJ8zZ+UPRy4rNmO53DYxlPNAU8CQ6u0Q3GaqZqnKcYUoZGxUK1wkfsMLGIm4Nsrbfcga41SFOKm99HEtpQqKB6wumL+kc+tXgAZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hsz0l1hlMTN3+ZNZW93Bcx8PmYrbt5kPfdDrBublKMs=;
 b=LLUo4tQbGmQZgBiLQussdLdaWGiIZUMDTugEIXwFQrNjuKMavch0yDwU8wZ1RdsQX6QA3i/9yZxF7braVtKW6HRwmT+7vxqGWybfWUqMhw7ZA4Sxc8cUsD8uZ5uFJbAM1vjXyiYV9Rrx2olHEitVOuNza2X6sdk/i8KoBBHmO5s=
Received: from DM5PR12MB4679.namprd12.prod.outlook.com (2603:10b6:4:a2::37) by
 DM5PR12MB1644.namprd12.prod.outlook.com (2603:10b6:4:f::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.38; Mon, 22 Feb 2021 20:59:09 +0000
Received: from DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::4846:47d7:6a0:1044]) by DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::4846:47d7:6a0:1044%7]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 20:59:09 +0000
From: "Cornij, Nikola" <Nikola.Cornij@amd.com>
To: Simon Ser <contact@emersion.fr>
Subject: RE: Overlay issues
Thread-Topic: Overlay issues
Thread-Index: AdbSl9sxMkfhaFWoRjW4p/7OX2aWMgAIDMeAABHbJ1ABe+bI4AuFiu2AAI89wCA=
Date: Mon, 22 Feb 2021 20:59:08 +0000
Message-ID: <DM5PR12MB4679C406F33E9B04BA343295EE819@DM5PR12MB4679.namprd12.prod.outlook.com>
References: <DM5PR12MB4679C807DB8DB502AC4793DCEEC60@DM5PR12MB4679.namprd12.prod.outlook.com>
 <05FNtjCma79AawCUxH3mqJ8sWHmoIXFXhQWW0N_b-mpl7QvuW3JN3AbtPUiR0y1LOf3tLhWFWv8YjuIEvJ3dci9y1EHk_D9a9L1BAyWyxRs=@emersion.fr>
 <DM5PR12MB4679F2B26887B76BC025161AEEC60@DM5PR12MB4679.namprd12.prod.outlook.com>
 <DM5PR12MB46792E5F8DF0F128FF01D79EEEDE0@DM5PR12MB4679.namprd12.prod.outlook.com>
 <Zq5awE32--JJaePI-8O0Rd-2AYVUPYgIn1PspErRR_qpQeTlX_L0M_8iQMyN6rGZPJRuBmkf6OGmeQFLYkzB9cswAhdyWbAzEXqT-0ZjFC4=@emersion.fr>
In-Reply-To: <Zq5awE32--JJaePI-8O0Rd-2AYVUPYgIn1PspErRR_qpQeTlX_L0M_8iQMyN6rGZPJRuBmkf6OGmeQFLYkzB9cswAhdyWbAzEXqT-0ZjFC4=@emersion.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Enabled=true;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_SetDate=2021-02-22T20:59:07Z; 
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Method=Privileged;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_Name=Internal Use Only -
 Restricted;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_ActionId=fbe50978-e54e-4d12-8d7f-c16347046820;
 MSIP_Label_c3918902-4ff3-42f6-8eb5-e5d9c71daf16_ContentBits=1
authentication-results: emersion.fr; dkim=none (message not signed)
 header.d=none;emersion.fr; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c838e908-99af-4795-de33-08d8d774b2ea
x-ms-traffictypediagnostic: DM5PR12MB1644:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1644CABAED6A81C06891F430EE819@DM5PR12MB1644.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: enQFEJI/Jb9a6uWgA6Tg+0CYtAnM+Xic7m3JXAIsh6xXpIxZBNYCH/+5WvLEDyVw1KlfLDY09drW3hUBb1QWy3UB5QFqUlmhcxqNg6+nOAt3P+Il0z7/kw8//ekGx8zXVP9YXeYfHHQFOQigSmhZ2ErTnI/3e+tGUCp1o8p8+VwPw0zMkWGU1ypICDHepyD0IQDzXk0/EWC3ve6NTQ8aOQ2kps4b71MRvbdmNzQl3ltwhr8Ri0/R1UnYB9fVugH5LOZ0Mx0D2cS/Z03uP752lG0/bVqE2CDkO/CB3IOvog/rHH2g9EM5oynhY7BMPVFpJE3zHFX8dK1/f60eqc+gkmJFKX+hCUovwo2gTpc+6glygkYAPFzc7ZT+Lh2xKrQzYpfujM61aamh8jiDpVKR7+z4BkStsa4ij3wM+hk9Yq2CQhXC/ymp5gC/WrDJxhZkNMOSZdHBcMYALJrPrUzLIU77gn9NB6pu1R+JSpx0op3alTwaY3kzFyuQ9SivkI0YRcDND+XCCAq8gELfQGqtZg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4679.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(26005)(86362001)(3480700007)(316002)(7696005)(186003)(66446008)(64756008)(66616009)(66556008)(76116006)(2906002)(52536014)(66946007)(6506007)(66476007)(53546011)(8936002)(54906003)(8676002)(55016002)(9686003)(6916009)(5660300002)(478600001)(83380400001)(4326008)(33656002)(7116003)(71200400001)(99936003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?MGtEYlpqeWorTUVyYThPbnpYb29IM3U5T0Z3LytGTGFWZng0ck1OMWpVNXVS?=
 =?utf-8?B?ZE9QWGlhNW1uUUpQdXpncEUxRUE5bUVrL0ZIMStSV0J2ZFRueWRNNkRtUnhL?=
 =?utf-8?B?NThhQTlQeDkvSm9QSThVODdUZXF1cTlTdGhYcTM5MGpKMWNYR3ROZWk4Q24y?=
 =?utf-8?B?WVBXOGtIaDdxSWdyY2RVSmdTZ29aczY1UjRaa242MExLSEpiWmdWcmFQc3lZ?=
 =?utf-8?B?dEluejNEMzhMbTNxT2U3cnpRSUhoZXFoS1h2OEc4Zi8rQmdBUk1FTitsVExB?=
 =?utf-8?B?U2QzR1QzbTV0VHZaWXFiVDk0eHl6Y2RVelBqQ3FoY21OMmM3QXlOZjVBNEF4?=
 =?utf-8?B?VTg3dkxpL3JDcFVDdStJLzRVQ2U4WjlzNFJVNC9pWkZtQ2NycXl5WVpJMDZV?=
 =?utf-8?B?dlcxd2g0RGtGUUtYdzc2S2s1cXc1eGR3cU4vWjBwNnM1QXZ2c2JZZ0JEd1Z0?=
 =?utf-8?B?djY3RnhjSXh6MkNoYmlYTXFLdVZRL0VZVjMxem9FNmYzaTdpZ29kME1PMlp5?=
 =?utf-8?B?dlhHTDZKY2FwUHROdjdNN2xtdU56VXo0dFRNN01zbGxZMy9iQlR2WFVEUXM1?=
 =?utf-8?B?M1hVUi84RVBSZ04xa3Y3Y2Z5bXFzUGJudHczK1VvcDdkUGV0MmE2QUF5ZXVB?=
 =?utf-8?B?ZGlSRmJ2VlhPR3g4TFdvRUplYkdzOEExZlFENVIxZ3EzVG5tWVdtVXJ6Z1Fo?=
 =?utf-8?B?WHRiZ1FXWjhIYU5rT3prd2V6WE1OV0F4QUtuZ1JSN0hNU1lLc1VBa21mbWtn?=
 =?utf-8?B?TUZrOEsyZXgvRmtncURoWnNHUHFIWmlQTVg0SFZ5dy82amFCM2EzWWwzb09G?=
 =?utf-8?B?dmFBaVd6LzJyeGp1N3ZGcnZra1Z1b3JtTXdkd1RFMVVVTHlYek9QOGQvamNG?=
 =?utf-8?B?UE9kbFNlTmN0VkQrNTEwUHhyTmNVNG9HN3NTbHhJTkd2V09VQ2Z5TGUzdGF5?=
 =?utf-8?B?dnBvVUk2Um50TEJHU0pYRjRLQ0JQZmNWbnE4d0dkWi84aDNmSEZ0M0hMRGVO?=
 =?utf-8?B?QVRCcWIvWFpESU9tQ1kyUVBTZDR0UFA2a3hMT2JjT0JZWnBKQjZtZGExL2pj?=
 =?utf-8?B?UE82dnk5WGxNVzRjVkwvajRaVmd6cUswMkQ1dUZjdHZCMTd5NjRQcmdlODRi?=
 =?utf-8?B?RDNNU202L3NYN0RONHE0YS9kYnpqOUhCRDFNSjFvbjltWHppU1lpSUo5anNY?=
 =?utf-8?B?UERERVI5eHNzdkFlRkhqSnlaTkxlbGRiVGRIRzUwWmQrSDRvWHlMaVMvbmdp?=
 =?utf-8?B?VTEzd2FKR0JOcjRoVWJWWkN6SElRT2dPejQxcEJOcjVGbC8xa1FvaDdpdGJR?=
 =?utf-8?B?WkZpMVB1M2xxTHpRM2FPNUVJV2k1WUhvZGJsd3dNZ0IxWGJWWjZjM0dnaHMx?=
 =?utf-8?B?VUxidjdWKytMKysrVEU0UkNhSzlzcTcwN0RvWDRWakQxaW5SNXRoTndyRHFv?=
 =?utf-8?B?RnQ3ak11WTlPcmNkSFZyNTdDZFhOd2JZWmNSOC9rMGQ1MGJSRisrQlBVd0ZS?=
 =?utf-8?B?bFNYZnFwNG5HRWc0ejRmQm9sUWE5WlFGdU5sU0lnMU9XUzlQSExDM2NtNjR5?=
 =?utf-8?B?VmljdzAwVUlDWUFtR2oyN2M0OVJSbDBNNzI4dU5Cb01Yb29JZWRaQlRFNG5v?=
 =?utf-8?B?cUFGSU9qc1ByRFNPME9vS1Q3QTE3QjdnWDcxWEhkdnlIWXJKdEZJSlpRaWhr?=
 =?utf-8?B?TGpoM0pVNDVaUXkrQ3kvL1BCRU9lUGN1aCtyaiszNEhaWGdob2twTzBSNUcx?=
 =?utf-8?Q?K+F5u5I2BQr2Ar1JaH4Bz+MEQLLAFDbfJUxK5L1?=
Content-Type: multipart/mixed;
 boundary="_002_DM5PR12MB4679C406F33E9B04BA343295EE819DM5PR12MB4679namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4679.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c838e908-99af-4795-de33-08d8d774b2ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 20:59:08.8731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Y3CJW2QphBpMb4fEV4nxlVSqKpQ/f0msWw4JAKHPpaxQqXukbrlXw8l4bvUWA0N/boAzrr6Jxsrr8iYx24y5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1644
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_002_DM5PR12MB4679C406F33E9B04BA343295EE819DM5PR12MB4679namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFwcHJvdmVkIGZvciBFeHRlcm5hbCBVc2VdDQoNCkhp
IFNpbW9uLA0KDQpZZXMsIEkgZGlkIGhhdmUgYSBjaGFuY2UgdG8gd3JhcCB0aGlzIHVwLCBpbmRl
ZWQgOi0pDQoNCkl0IHR1cm5lZCBvdXQgdGhpcyBhbmQgb3RoZXIgc2ltaWxhciBzZXR1cCB3YXMg
aGl0dGluZyBhIGxlZ2l0IEhXIGxpbWl0YXRpb24uIEkgYWRkZWQgYSBwYXRjaCAocGxlYXNlIHNl
ZSBhdHRhY2hlZCkgdGhhdCdkIGZhaWwgdGhpcyBjb25maWcgYXQgdmFsaWRhdGlvbiB0aW1lLiBU
aGUgcGF0Y2ggaGFzIGJlZW4gbWVyZ2VkIGZvciB1cHN0cmVhbWluZyBhdCB0aGUgYmVnaW5uaW5n
IG9mIEZlYnJ1YXJ5IHRpbWUtZnJhbWUsIG5vdCBzdXJlIGlmIGl0IG1hZGUgaXQgdG8gdGhlIHB1
YmxpYyByZXBvIGJ5IG5vdy4NCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIG1vcmUg
aW5mbyBvbiB0aGlzLg0KDQpSZWdhcmRzLA0KDQpOaWtvbGENCg0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogU2ltb24gU2VyIDxjb250YWN0QGVtZXJzaW9uLmZyPiANClNlbnQ6
IEZyaWRheSwgRmVicnVhcnkgMTksIDIwMjEgNDoyMiBQTQ0KVG86IENvcm5paiwgTmlrb2xhIDxO
aWtvbGEuQ29ybmlqQGFtZC5jb20+DQpDYzogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFp
bC5jb20+OyBLYXpsYXVza2FzLCBOaWNob2xhcyA8TmljaG9sYXMuS2F6bGF1c2thc0BhbWQuY29t
PjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgV2VudGxh
bmQsIEhhcnJ5IDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPjsgYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NClN1YmplY3Q6IFJFOiBPdmVybGF5IGlzc3Vlcw0KDQpI
aSwNCg0KT24gV2VkbmVzZGF5LCBEZWNlbWJlciAyM3JkLCAyMDIwIGF0IDY6NDggQU0sIENvcm5p
aiwgTmlrb2xhIDxOaWtvbGEuQ29ybmlqQGFtZC5jb20+IHdyb3RlOg0KDQo+IEFub3RoZXIgaW50
ZXJpbSB1cGRhdGU6IHNvIGZhciB0byBtZSBpdCBsb29rcyBsaWtlIHRoaXMgaXMgYW4gaXNzdWUg
aWYgDQo+IHRoZXJlJ3MgZmV3ZXIgdGhhbiAyNCBwaXhlbHMgbGVmdCBvbiB0aGUgc2NyZWVuIHdo
ZW4gbW92aW5nIHRoZSBGQiANCj4gb3V0c2lkZSBvZiB0aGUgbGVmdCBlZGdlIChlLmcuIHdpdGgg
MzAweDMwMCBGQiBzaXplLCBpdCByZXByb3Mgd2l0aCBYIA0KPiA9IC0yODApLiBXaGVuIHRoaXMg
aGFwcGVucywgd2hhdCBsb29rcyBsaWtlIGEgYm91bmRhcnkgY29uZGl0aW9uIGluIA0KPiBvdXIg
ZHJpdmVyIGlzIGhpdCBhbmQgZGVzdGluYXRpb24gcmVjdGFuZ2xlIHVwZGF0ZSBpcyBza2lwcGVk
Lg0KPg0KPiBJIG5lZWQgdG8gZG8gc29tZSBtb3JlIGRpZ2dpbmcgdG8gZnVsbHkgdW5kZXJzdGFu
ZCB3aHkgaXMgdGhpcyANCj4gY29uZGl0aW9uIGluIHBsYWNlIGFuZCBob3cgdG8gYXZvaWQgaXQu
DQoNCkRpZCB5b3UgaGF2ZSB0aGUgY2hhbmNlIHRvIGNvbnRpbnVlIHdvcmtpbmcgb24gdGhpcz8N
Cg0KVGhhbmtzLA0KDQpTaW1vbg0K

--_002_DM5PR12MB4679C406F33E9B04BA343295EE819DM5PR12MB4679namp_
Content-Type: application/octet-stream;
	name="0001-drm-amd-display-Reject-too-small-viewport-size-when-.patch"
Content-Description:  0001-drm-amd-display-Reject-too-small-viewport-size-when-.patch
Content-Disposition: attachment;
	filename="0001-drm-amd-display-Reject-too-small-viewport-size-when-.patch";
	size=4164; creation-date="Mon, 22 Feb 2021 20:56:00 GMT";
	modification-date="Mon, 22 Feb 2021 20:56:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiYTczZWJkMGNkYWUwNWRjZjBmNjE5NWYwNWYxY2RhNmYwNTllOWVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWtvbGEgQ29ybmlqIDxuaWtvbGEuY29ybmlqQGFtZC5jb20+
CkRhdGU6IFRodSwgMjEgSmFuIDIwMjEgMjI6MzU6NTQgLTA1MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kL2Rpc3BsYXk6IFJlamVjdCB0b28gc21hbGwgdmlld3BvcnQgc2l6ZSB3aGVuCiB2YWxp
ZGF0aW5nIHBsYW5lCgpbd2h5XQpPdmVybGF5IHdvbid0IG1vdmUgdG8gYSBuZXcgcG9zaXRvbiBp
ZiB2aWV3cG9ydCBzaXplIGlzIHNtYWxsZXIgdGhhbgp3aGF0IGNhbiBiZSBoYW5kbGVkLiBJdCdk
IGVpdGhlciBkaXNhcHBlYXIgb3Igc3RheSBhdCB0aGUgb2xkCnBvc2l0aW9uLiBUaGlzIGNvbmRp
dGlvbiBpcyBmb3IgZXhhbXBsZSBoaXQgaWYgb3ZlcmxheSBpcyBtb3ZlZCB0b28KbXVjaCBvdXRz
aWRlIG9mIGxlZnQgb3IgdG9wIGVkZ2Ugb2YgdGhlIHNjcmVlbiwgYnV0IGl0IGFwcGxpZXMgdG8K
YW55IG5vbi1jdXJzb3IgcGxhbmUgdHlwZS4KCltob3ddClJlamVjdCB0aGlzIGNvbnRpZGlvbiBh
dCB2YWxpZGF0aW9uIHRpbWUuIFRoaXMgZ2l2ZXMgdGhlIGNhbGxpbmcKbGV2ZWwgYSBjaGFuY2Ug
dG8gaGFuZGxlIHRoaXMgZ3JhY2VmdWxseSBhbmQgYXZvaWQgaW5jb25zaXN0ZW50CmJlaGFpdm9y
LgoKU2lnbmVkLW9mZi1ieTogTmlrb2xhIENvcm5paiA8bmlrb2xhLmNvcm5pakBhbWQuY29tPgpS
ZXZpZXdlZC1ieTogTmljaG9sYXMgS2F6bGF1c2thcyA8TmljaG9sYXMuS2F6bGF1c2thc0BhbWQu
Y29tPgpBY2tlZC1ieTogQW5zb24gSmFjb2IgPEFuc29uLkphY29iQGFtZC5jb20+ClRlc3RlZC1i
eTogRGFuaWVsIFdoZWVsZXIgPGRhbmllbC53aGVlbGVyQGFtZC5jb20+Ci0tLQogLi4uL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgMjcgKysrKysrKysrKysrKysr
KysrLQogLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNvdXJjZS5jIHwgIDQg
Ky0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaCAgICAgICAgICAgfCAgMSAr
CiAzIGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0u
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKaW5k
ZXggZTExMTM5Y2E0MWQ0Li42MjZhOGNjOTJkNjUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAtNjQ5Niw4ICs2NDk2LDMzIEBA
IHN0YXRpYyBpbnQgZG1fcGxhbmVfaGVscGVyX2NoZWNrX3N0YXRlKHN0cnVjdCBkcm1fcGxhbmVf
c3RhdGUgKnN0YXRlLAogCWludCBtaW5fc2NhbGUgPSAwOwogCWludCBtYXhfc2NhbGUgPSBJTlRf
TUFYOwogCi0JLyogUGxhbmUgZW5hYmxlZD8gR2V0IG1pbi9tYXggYWxsb3dlZCBzY2FsaW5nIGZh
Y3RvcnMgZnJvbSBwbGFuZSBjYXBzLiAqLworCS8qIFBsYW5lIGVuYWJsZWQ/IFZhbGlkYXRlIHZp
ZXdwb3J0IGFuZCBnZXQgc2NhbGluZyBmYWN0b3JzIGZyb20gcGxhbmUgY2Fwcy4gKi8KIAlpZiAo
ZmIgJiYgc3RhdGUtPmNydGMpIHsKKwkJLyogVmFsaWRhdGUgdmlld3BvcnQgdG8gY292ZXIgdGhl
IGNhc2Ugd2hlbiBvbmx5IHRoZSBwb3NpdGlvbiBjaGFuZ2VzICovCisJCWlmIChzdGF0ZS0+cGxh
bmUtPnR5cGUgIT0gRFJNX1BMQU5FX1RZUEVfQ1VSU09SKSB7CisJCQlpbnQgdmlld3BvcnRfd2lk
dGggPSBzdGF0ZS0+Y3J0Y193OworCQkJaW50IHZpZXdwb3J0X2hlaWdodCA9IHN0YXRlLT5jcnRj
X2g7CisKKwkJCWlmIChzdGF0ZS0+Y3J0Y194IDwgMCkKKwkJCQl2aWV3cG9ydF93aWR0aCArPSBz
dGF0ZS0+Y3J0Y194OworCQkJZWxzZSBpZiAoc3RhdGUtPmNydGNfeCArIHN0YXRlLT5jcnRjX3cg
PiBuZXdfY3J0Y19zdGF0ZS0+bW9kZS5jcnRjX2hkaXNwbGF5KQorCQkJCXZpZXdwb3J0X3dpZHRo
ID0gbmV3X2NydGNfc3RhdGUtPm1vZGUuY3J0Y19oZGlzcGxheSAtIHN0YXRlLT5jcnRjX3g7CisK
KwkJCWlmIChzdGF0ZS0+Y3J0Y195IDwgMCkKKwkJCQl2aWV3cG9ydF9oZWlnaHQgKz0gc3RhdGUt
PmNydGNfeTsKKwkJCWVsc2UgaWYgKHN0YXRlLT5jcnRjX3kgKyBzdGF0ZS0+Y3J0Y19oID4gbmV3
X2NydGNfc3RhdGUtPm1vZGUuY3J0Y192ZGlzcGxheSkKKwkJCQl2aWV3cG9ydF9oZWlnaHQgPSBu
ZXdfY3J0Y19zdGF0ZS0+bW9kZS5jcnRjX3ZkaXNwbGF5IC0gc3RhdGUtPmNydGNfeTsKKworCQkJ
LyogSWYgY29tcGxldGVseSBvdXRzaWRlIG9mIHNjcmVlbiwgdmlld3BvcnRfd2lkdGggYW5kL29y
IHZpZXdwb3J0X2hlaWdodCB3aWxsIGJlIG5lZ2F0aXZlLAorCQkJICogd2hpY2ggaXMgc3RpbGwg
T0sgdG8gc2F0aXNmeSB0aGUgY29uZGl0aW9uIGJlbG93LCB0aGVyZWJ5IGFsc28gY292ZXJpbmcg
dGhlc2UgY2FzZXMKKwkJCSAqICh3aGVuIHBsYW5lIGlzIGNvbXBsZXRlbHkgb3V0c2lkZSBvZiBz
Y3JlZW4pLgorCQkJICogeDIgZm9yIHdpZHRoIGlzIGJlY2F1c2Ugb2YgcGlwZS1zcGxpdC4KKwkJ
CSAqLworCQkJaWYgKHZpZXdwb3J0X3dpZHRoIDwgTUlOX1ZJRVdQT1JUX1NJWkUqMiB8fCB2aWV3
cG9ydF9oZWlnaHQgPCBNSU5fVklFV1BPUlRfU0laRSkKKwkJCQlyZXR1cm4gLUVJTlZBTDsKKwkJ
fQorCisJCS8qIEdldCBtaW4vbWF4IGFsbG93ZWQgc2NhbGluZyBmYWN0b3JzIGZyb20gcGxhbmUg
Y2Fwcy4gKi8KIAkJZ2V0X21pbl9tYXhfZGNfcGxhbmVfc2NhbGluZyhzdGF0ZS0+Y3J0Yy0+ZGV2
LCBmYiwKIAkJCQkJICAgICAmbWluX2Rvd25zY2FsZSwgJm1heF91cHNjYWxlKTsKIAkJLyoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNl
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNvdXJjZS5jCmlu
ZGV4IDY4YjY1YTA5MGQxNy4uMGMyNmMyYWRlNzgyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNvdXJjZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmMKQEAgLTExNTMsOCArMTE1Myw4IEBA
IGJvb2wgcmVzb3VyY2VfYnVpbGRfc2NhbGluZ19wYXJhbXMoc3RydWN0IHBpcGVfY3R4ICpwaXBl
X2N0eCkKIAogCWNhbGN1bGF0ZV92aWV3cG9ydChwaXBlX2N0eCk7CiAKLQlpZiAocGlwZV9jdHgt
PnBsYW5lX3Jlcy5zY2xfZGF0YS52aWV3cG9ydC5oZWlnaHQgPCAxMiB8fAotCQlwaXBlX2N0eC0+
cGxhbmVfcmVzLnNjbF9kYXRhLnZpZXdwb3J0LndpZHRoIDwgMTIpIHsKKwlpZiAocGlwZV9jdHgt
PnBsYW5lX3Jlcy5zY2xfZGF0YS52aWV3cG9ydC5oZWlnaHQgPCBNSU5fVklFV1BPUlRfU0laRSB8
fAorCQlwaXBlX2N0eC0+cGxhbmVfcmVzLnNjbF9kYXRhLnZpZXdwb3J0LndpZHRoIDwgTUlOX1ZJ
RVdQT1JUX1NJWkUpIHsKIAkJaWYgKHN0b3JlX2hfYm9yZGVyX2xlZnQpIHsKIAkJCXJlc3RvcmVf
Ym9yZGVyX2xlZnRfZnJvbV9kc3QocGlwZV9jdHgsCiAJCQkJc3RvcmVfaF9ib3JkZXJfbGVmdCk7
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaCBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oCmluZGV4IGQ1MTA1OTI0YzllMC4uYmU5YWRk
ZGZhYzk2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaApAQCAtNDgsNiArNDgsNyBA
QAogI2RlZmluZSBNQVhfUExBTkVTIDYKICNkZWZpbmUgTUFYX1NUUkVBTVMgNgogI2RlZmluZSBN
QVhfU0lOS1NfUEVSX0xJTksgNAorI2RlZmluZSBNSU5fVklFV1BPUlRfU0laRSAxMgogCiAvKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKgogICogRGlzcGxheSBDb3JlIEludGVyZmFjZXMKLS0gCjIuMjUu
MQoK

--_002_DM5PR12MB4679C406F33E9B04BA343295EE819DM5PR12MB4679namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_002_DM5PR12MB4679C406F33E9B04BA343295EE819DM5PR12MB4679namp_--
