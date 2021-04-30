Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDCEC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 21:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F79B61466
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 21:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F79B61466
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA366F5E7;
	Fri, 30 Apr 2021 21:39:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFEB6F5E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 21:39:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKuPOooyrOZpP2A9f2UTnInWvRXhYZ59Le3EqONaV0chCxJkGGK22AsG+R318HC4kp3+owsEJt78tNlwi4QGt16yNZcuWyw169XI/8qjlCHOeyBAthnzu1CJrP0gH8NmGrzVua8OxJ15JG6u5m8n0Cy+ip66y2udhKYJLavfUcHr7OkuGQqgfI6qrqaaO7jzkQnyzOF4qzXBc6JjLlxwAL7ByBOhuSVaff1cH1gyn8FjF47QXgg/e7dvDOK8tF9zRibOvAxRAZ1FRLBVXKq/k+JXrwalPcDtEn1H1bGP0sxgip7aywOaJyTT0ueib4WIPgEQK6DcEdPcKSJ/hU9JPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHj4A6ogwb5bdtYyrqBTrPoQVXW7zG782M7xhpWFLb0=;
 b=IVfJ5aLKTPiQAiuhduZ6u/SW9VwTYKWxJ53Lg9QhPbPFTE+c8m35wqXCshGFwo5aGfl+bnahKq5YdyVMFG6N5kpdwGhXQN1JaQP/HTlfcQ8J5FUsGRz7LQQmPJgDLp3d2GT4ntjCBRVckkuTHTZTlIxJWwzRlN+a8CLG3kjeFAl4xHaNkb9Sv6Hf+YSoQvKZThoz3YDFzHEA8E3QBm1t5ZgvJ1NhkChd29NflMdbN7yFnjtOq2F+zNT34eKo7yg4wT792DADH3faIQA4tlSWFcztBdsVI3LrDECofW+dg6d0R+JY/jTmegyy/yE8vw1A/lZtntiRvdPqGpJbIqvqeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHj4A6ogwb5bdtYyrqBTrPoQVXW7zG782M7xhpWFLb0=;
 b=DPPyPhOP75Qk56rcRryohvu8bDUqsTq3+pR/e1MxnY1d40q/Ire69ihfj114z2DEmSnHZHL3+2OdT6icQMuip7n41UeCap+XnK7X5WkxHDER6AOiYGtkPqa9PE5hsEaKC1Zk5YgNgiJcM0TjcHqYSCBTkUS9Acm3+Fy3XY+dhY8=
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.25; Fri, 30 Apr 2021 21:39:03 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.4087.037; Fri, 30 Apr 2021
 21:39:03 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdkfd: Make svm_migrate_put_sys_page static
Thread-Topic: [PATCH 1/1] drm/amdkfd: Make svm_migrate_put_sys_page static
Thread-Index: AQHXPaCh2J7MIKPvb0mQ0eO9IObsz6rNVCkA
Date: Fri, 30 Apr 2021 21:39:03 +0000
Message-ID: <77330DD2-3195-4257-8F18-56FA6D629E11@amd.com>
References: <20210430090953.31524-1-Felix.Kuehling@amd.com>
In-Reply-To: <20210430090953.31524-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.46.21021202
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d40e7e2-485d-4cf2-8802-08d90c205fcb
x-ms-traffictypediagnostic: DM6PR12MB4418:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4418D4A0EE4477A9CE135CF2805E9@DM6PR12MB4418.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:428;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QneDFvSAOjmGNHFXwyUmL2Sb1UK2wT9DgGnOw6XHDRa11gIeMXyn+giTekbEWOg68yZJlhunb07zQSXbWyaTlQpDDECU3i1X50cPJ4IcX8eBaGB7YcYfvBKIRPJgWVieD2wg1einh6VCTGCi311S8YM7EgqdcdJYfSBOm3GzKqqPJmCfjrLLKlUMV8YmvC5UZcm/4dZOFh7KobOUPI0yhrd6yYPK0trKVPJxiLFnUNUc4oK6hMfEfALZrw9euqXy9ag8o+6OnjpIK5sEIoPUoHt+HXvCIN3qz8StP5FjKxB4drHvH7o9LUHyTME5+46SNUrK6zalHyfj+p5N9NsJLq5SxavgjzEvRa9DvN9PgmxgFnCLHuTEPhBp0wekNTjn+mfPtNcW3eIjwcuEDuPppRCRvdhDEMKT/KXRQKL33+AXhDnp4XIxq3x028fv6HlqKU+p7XG2/CkVXC8QbyFfDQq/mImn1Ivi/9u75pP4XnnXqpWlwmmedbWRj3apiAWRWaIdmdogjXLJsEasCrlzWP3ZDGqrXwbJM81F2Jc6ZeUfVpjpML+NZIAxn5mkRSCygqNwQV6rky8CgBgiGwfy3LFd1v0iX+FTMgOCVI9Gj1CLVb3PwfmObLE15ROKO1fOVoj0J2CATYKW+kpATyglJJ5WhnWN/3W9BtJ4Z1SC/jYC2+1PVuaP4frGTI5nHF+TbYOskRzP4lQCD3NP8sSFNQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(36756003)(86362001)(83380400001)(66446008)(38100700002)(66556008)(122000001)(6506007)(110136005)(316002)(186003)(8676002)(33656002)(71200400001)(5660300002)(26005)(91956017)(2906002)(45080400002)(6512007)(66476007)(66946007)(2616005)(4326008)(478600001)(966005)(6486002)(8936002)(76116006)(64756008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?QnFoQS92U0l4QVFkak1UZXk1L1R0RDZSSk1kWitRL1ROdFc3K3h4cnVoc0V5?=
 =?utf-8?B?SSsxSGtYVjhKV3BxM2locFRCYit1VG1GQkpXVi80QU1ySDh4VG01ZU1idW5a?=
 =?utf-8?B?NTNyaHJGTGJWYk1IMHN6VkdWVVZOKzd0MTgxSnRVV2htc3VXQS9Wb01YZS93?=
 =?utf-8?B?WmUydkY1bitYTGhDMDM4MHAwZStQT3VNN3VNS1hPV0xhZytYZGd4M0RBOGI5?=
 =?utf-8?B?eUdXK2txeDJEYVFCYmhDR1FVaUlzMGtIRUFMTHQxOUpDOGlockJyWUR4aGYv?=
 =?utf-8?B?SHQvRWZvSHYyUzNiUWsvcy9hUGJZMzBJV3FIY3dxbHJkSi9EWEg4d0pDdWJa?=
 =?utf-8?B?MUxzTDhudHIrcU9RcWwxRU5mZmxpMnl3c0Mwc3N3OTdZRTNpdlpTS0xyUnpR?=
 =?utf-8?B?MS9iSDU1QUFvVTNpT0hETTM4TytHa29scHpmRlovSlBnQlhITlNyVGZIakE0?=
 =?utf-8?B?UVBoTmRxTkRiTmNWV05VWkFVajF2eFFMTXFVMDV2dnpwc1JJK3kvem5OTzJq?=
 =?utf-8?B?Q3BWTnpWZ3d3UmxZWitINnFqQ3RHVTNKYnJYNzBWc1JLWXFQR3lQSHErN00w?=
 =?utf-8?B?SzZtK0M4ZHhHRGdiSUFpS2RNSGc3MjNHbEIzcWViaVJiNDVCWWdKbmhnL3lC?=
 =?utf-8?B?YWhHSUoxdWNJVy8xbWF0K1BEbGZoS0dwWmFtMHdYTnlXWTA1aXpHSjl6c00y?=
 =?utf-8?B?bHA5eWowUWpjNThqa2tuM2kxQ2NrZVo0OTF2UTZEcExmYWpKbDg1NldONXRy?=
 =?utf-8?B?bTZ5VXhIWHg4V3VRS1BsSHRkeDFSL0RBU1RpejZLdkhTRXpzWFd2a1ZTT2Nv?=
 =?utf-8?B?UmFWRU0wU0orTWpBcW1YQnovY3FGcmpZdytNSXUvRUJGOWlTSTAzM2VtcEx0?=
 =?utf-8?B?WEp1V2pYa1lMbnZESzA2blVmZVNRNE9GSGRPNitKTWpNemg1TkFJSURhR2lk?=
 =?utf-8?B?VkFBMHFHa0ZMaDIwV2NQNE9ZMC9GNkU0ZW1GM3ZlZ013bjRnVjBWMVlZdWty?=
 =?utf-8?B?NloySVVIT0Z3TEVKcXZ1cHowS2F5M3krMkpLVC9wQVVIT05FcG1PTTNxM0hI?=
 =?utf-8?B?dkIwVVRDZXlCb1ppeE9mTm1XS096SFdjdkRlNm84WUMreXdTRGdBSDQycjB2?=
 =?utf-8?B?bDEwa2dyeGo5NXh5a3BzaHVGWEQ1ODZlbHFnRCsxczQ4M0wvU0UvZlNDbzBH?=
 =?utf-8?B?ckcybkczMFRXeEdVMXRkQTREQjdLQitrYmY3aUlhVU91ZExMN0NZUFo4dDV0?=
 =?utf-8?B?WDNkbGtEeUluc24rZlRnZ2FzTGl3anNiM3E0eW0rODdUeVFOWkhjOFpKQml6?=
 =?utf-8?B?MGprTTlCNVdxVGorVVN5ZDQ1SHZtMFc5WTN2RHI4YlRTdnNmblJoakVQV1or?=
 =?utf-8?B?N2tweStXb3lDTU0rQ2sxR0tPTzJQZjdLdUdkNmVUOEI1bHJhZ0JsMFZyU2tk?=
 =?utf-8?B?UDRvKzJSZklYL3ZIU2NjM0RBNFBvLzRSOWd5K0FnSXVocE5qK3NiMHV2b2Uv?=
 =?utf-8?B?TWhtbW1kVzlKSDRwclV0Qk9lV2pxWlNBMU9vVXFJR3FOSDRHTklWak5Yc0ZC?=
 =?utf-8?B?QmVUeXpzMGduaFVsdEN5NlRoRzNIeG81N1A0eTVxN293NjdwWnEwK1pQQVV5?=
 =?utf-8?B?RHplZjhxZ0FwKzdtV2hYSzZpeDc1ejRQOTZUVlZrUnA1SkVJZTVzSGNYVWox?=
 =?utf-8?B?cGR2aDRtdUk2M2MvQmJBZjlrYTFtRFFIeWM1dEpPSDIwMitEa0xJM0JpbEpu?=
 =?utf-8?B?RjVqeTlFTy8yK05zLzhOcm1EUlEvKzJlcThJTDFScERDd1ZkSURaa1R1alBx?=
 =?utf-8?B?dG1na0xOVlk2WDVoRUZ1UT09?=
Content-ID: <A6A75E2C966D044AA19658CAE3078FFB@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d40e7e2-485d-4cf2-8802-08d90c205fcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 21:39:03.4177 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nj82vR6fo8lK8wUu9xG0CwNMnnHiprHUjAg6dY6gZ4C1GvP/ZKFuBThA2yMN/WRJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
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
Cc: kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29tPg0KDQpSZWdhcmRzLA0KT2Fr
IA0KDQogDQoNCu+7v09uIDIwMjEtMDQtMzAsIDU6MTAgQU0sICJhbWQtZ2Z4IG9uIGJlaGFsZiBv
ZiBGZWxpeCBLdWVobGluZyIgPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmcg
b24gYmVoYWxmIG9mIEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+IHdyb3RlOg0KDQogICAgVGhpcyBm
dW5jdGlvbiBpcyBvbmx5IHVzZWQgaW4gdGhpcyBzb3VyY2UgZmlsZS4NCg0KICAgIFJlcG9ydGVk
LWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCiAgICBTaWduZWQtb2ZmLWJ5
OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCiAgICAtLS0NCiAgICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYyB8IDIgKy0NCiAgICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCiAgICBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMNCiAgICBpbmRleCA2YjgxMDg2M2Y2YmEu
LmJjMmZjNTI4YWQ1OCAxMDA2NDQNCiAgICAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfbWlncmF0ZS5jDQogICAgKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X21pZ3JhdGUuYw0KICAgIEBAIC0yODEsNyArMjgxLDcgQEAgc3ZtX21pZ3JhdGVfZ2V0X3N5c19w
YWdlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGFkZHIpDQogICAg
IAlyZXR1cm4gcGFnZTsNCiAgICAgfQ0KDQogICAgLXZvaWQgc3ZtX21pZ3JhdGVfcHV0X3N5c19w
YWdlKHVuc2lnbmVkIGxvbmcgYWRkcikNCiAgICArc3RhdGljIHZvaWQgc3ZtX21pZ3JhdGVfcHV0
X3N5c19wYWdlKHVuc2lnbmVkIGxvbmcgYWRkcikNCiAgICAgew0KICAgICAJc3RydWN0IHBhZ2Ug
KnBhZ2U7DQoNCiAgICAtLSANCiAgICAyLjMxLjENCg0KICAgIF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQogICAgYW1kLWdmeCBtYWlsaW5nIGxpc3QNCiAg
ICBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KICAgIGh0dHBzOi8vbmFtMTEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVk
ZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDQlN0Mw
MSU3Q29hay56ZW5nJTQwYW1kLmNvbSU3Q2YyMzU3Y2RiMTM0YzQ4ZTMyOTVmMDhkOTBiYjdjMjcx
JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzU1MzcwNjEz
ODE0NDgyNyU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJ
am9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0
YT1abkdHMld6R0pIdm5FZ3dkd3B3TmNpNCUyRkFobDRod1hUJTJCSXdVSkdBcks2VSUzRCZhbXA7
cmVzZXJ2ZWQ9MA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
