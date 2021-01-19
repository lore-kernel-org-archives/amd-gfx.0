Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDADC433E9
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 18:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058F52310C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 18:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058F52310C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC61F892DE;
	Tue, 19 Jan 2021 16:39:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F3E6E42D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 16:39:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g11HmG0ve+U5C38GK3HxjE0fdde8Am8ONuRJWYeOn6yNFmiwKbf3JNqboLkSOSnCxBk7hIJAsC3nmTTfaftMa6JUyh0x2x2ME1FE96Ki09Rz2/J1TQ+VjUeZ4vQLyaZolmRaW5/pESgUAmiTZ8fLsEojywNb9VJ1qjm18DeLRdFLP6/kM8irL35YPF33FpMPqWKpoSIWGTNylNavRsVKiW59vUpIlkMPJsIr1AOD+916hQK8Omqun8yGqA9355RHCAIFdFGiyZSd5QLj2XFsQ5jIkwOZ2M0bI7lFEjzTSXH9EkDGwvtTqWNjkUNWpTO9am1MDaZ7js5LOeHdvlfvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPFYvF+JNhj3wznQ8O9n5jxHbRGGwH0WbajGA22htW0=;
 b=lC4q/YPGLedx+/Yu8DuADmWectTwJ1DuGIqSfZHClReRe9DBtmlsyj3XxepKG950Pd/B02Pp8bsptbtgiiPKwiXxbOgErNsJKMwTEmLsYBGaOaAqHeoF0iTLXakE7SMU/F7VoONLzu4BD+Pr/qP0EqRy13DXHZUA60SGaFVvwkMUdT6EfJRs6pNQ6NePhsZmkkxVcmgq65XU9zUtQyZ7mNRiPBNKzlp39rQ+G/VPqDgaIyqsUETYtTFcb1hJ0VfBxpVYf/D+ADxZM0ILlAvkaB1kObp564uMpjC+OA2VTzAGaPyJ3JbAp+ZAy/Jf/1WW5b2d9sdobYzX+M/oPb7GEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPFYvF+JNhj3wznQ8O9n5jxHbRGGwH0WbajGA22htW0=;
 b=3uPC7hqWt2juATfgnHIAU1A99qHx9AGzLlFMMBLPecgLJxC3Pq81rAqLmrd/TVcz+vnqBTkChHemWMwZJthDiUDlqGqNpAt7PdGIFPoTrRntXQJWizEjQ6qpep9RXajrcZh3UtSEhs0YPoM9Jnfh815CMCuJAD1RW8GW460HwsQ=
Received: from CY4PR12MB1573.namprd12.prod.outlook.com (2603:10b6:910:d::23)
 by CY4PR12MB1303.namprd12.prod.outlook.com (2603:10b6:903:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Tue, 19 Jan
 2021 16:39:52 +0000
Received: from CY4PR12MB1573.namprd12.prod.outlook.com
 ([fe80::b1e2:6f8b:b4e9:6ef0]) by CY4PR12MB1573.namprd12.prod.outlook.com
 ([fe80::b1e2:6f8b:b4e9:6ef0%9]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 16:39:52 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIDEvMl0gZHJtL2FtZGdwdTogcmFjZSBpc3N1ZSB3aGVu?=
 =?gb2312?Q?_jobs_on_2_ring_timeout?=
Thread-Topic: [PATCH 1/2] drm/amdgpu: race issue when jobs on 2 ring timeout
Thread-Index: AQHW7l3KPN/nhp3RQUq08BpKjF1LaqovA2gAgAAdf+M=
Date: Tue, 19 Jan 2021 16:39:52 +0000
Message-ID: <CY4PR12MB157352A2F7BF029B68A4A769E1A30@CY4PR12MB1573.namprd12.prod.outlook.com>
References: <20210119122236.8039-1-horace.chen@amd.com>,
 <3365c92c-9dbd-56df-4ba0-55793806cac7@amd.com>
In-Reply-To: <3365c92c-9dbd-56df-4ba0-55793806cac7@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-19T16:39:56.489Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [61.152.208.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eed5610d-dc91-4b94-9dfe-08d8bc98d8ae
x-ms-traffictypediagnostic: CY4PR12MB1303:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1303622689DFBB3CC30374A6E1A30@CY4PR12MB1303.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sYQO4JDZPnVUuhnDAnHVV2CUCAL1X44rC9DR6OZvLHiXzNgsdnMn7OypwR6A9EpMAKbr2VF2jVJsK8GSjcJJ7C36S0fjGScoA2/VfzxSRExUreXFFXIZlKuYR9i7aeOCaUQ5oCKaHLLRsD0iIs7oQPKex3e8sIYw7EZbMwwKj+8uM+wuVHAX14HU+T0zBiP+2MSqzkhWCl2qxdc9rw25XV7gaQnWdJshJPzRwgAW7n9vhFbVAw3KlHS/wHNsdFMDFculMi9Fnb/k/JPB5xwQBbCYyFzEUxJ4Hncm72I2TuqcZczgfnKYRMg99AZdp56uPPdcZqPBksCgRbEW0HvtUPPVyAPB+iXDFVwj35iN+Lj1Govvv6FEZ0/GdjGfhUeixVIr7YSBh+ETM/Y45M9Bew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1573.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(7696005)(76116006)(91956017)(19627405001)(4326008)(66446008)(9686003)(2906002)(66946007)(64756008)(110136005)(66476007)(26005)(66556008)(55016002)(5660300002)(52536014)(71200400001)(316002)(86362001)(8936002)(224303003)(83380400001)(186003)(54906003)(6506007)(478600001)(53546011)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?gb2312?B?VUFvZ3dLRnJaRXhwSEg5dlgxbjM5dzZtQWl0c0xYZDBpWCthdk80NHVGQjNn?=
 =?gb2312?B?WjM1NWZXYlVodlJaajJNd2dDZG55M045THdKa05MaVZOdFN6QkxoL3lXbGNS?=
 =?gb2312?B?QzIzS1NuendmYXlxTUl5NnhhS2g4TTJZUERWWXYrZFBrMkZRaktuVnRUUmhF?=
 =?gb2312?B?WUF4YnlZY09DQTExQzVVN3J4TlRnUmZObXFETWl3NnJmbGZZYnVOWEpjc0NL?=
 =?gb2312?B?Skt3V0UzbkVWYWdoaGNzWVFOSWF5QzJCL3JOZWhCRkRiT3ZOK2IvanFCQTZ6?=
 =?gb2312?B?Q0k1UGJuY3pQcTBLSGsrRVRmSHV4bHdLWkg4Tm9TYWsydUVJeU1RU09ydk9W?=
 =?gb2312?B?SU5KZVRpUHhzVVdmUzdjUHYweWw0M2lPdW56N3VCQnY3aWw5ZStlM1NwOGox?=
 =?gb2312?B?bWJXZkxtcnlEU2UxNlBZSnh1eWZtd09ObFFCTGQ4VEZvQXpsVXFpN0R4aUZ6?=
 =?gb2312?B?ZFpQcTBsQ2VWOEF0bEpRNFU1anpjcXViVEJsbnFXb01BZENHQlJ5WkM0RkVk?=
 =?gb2312?B?VW9aOGhDNnEzRWdDc3F6NTFFQzJ4QnBZakVrdEI4aUJ0R0NxU3JtZlZQbTZN?=
 =?gb2312?B?YXhBSFh2VlFYRytIK2ZkYVIxNzM5M2RiZkxMTnFKR0Jybm1FaWNacE0rdEVu?=
 =?gb2312?B?Vkk4THEvbjdvNktyUlJHRDB2QW9WTmM1bDRpVE9QdU9CZ2xtcmYwa1pqRzNo?=
 =?gb2312?B?STR1OTNBakd6T2xiZDIxM0NmWFFrWkhuNjl0ZngvNG1FcnVRVC9sdFNQcDlp?=
 =?gb2312?B?b2svd0Vqek16UXdXaC9lTTQvMjl1RGZoTWtxWFQxaGNwRE5PQmlsc1U2Zkw3?=
 =?gb2312?B?YURIT0prQW9KbU5ZeVlRTXc4aHR0R3JiVk5nTi9hNkNVaTNWZTdJVmxSa2RF?=
 =?gb2312?B?eURYaUhIWkovSzZIWDB2N3M4NjNRVlFYaUQ4RzFoeUZLOHErUFBRV2VPbWpN?=
 =?gb2312?B?K0N2dTdGamJkZGxzblZSWm8vZWt3cFpHekJvUVhPbWlrZWJaa0FyQVVMUzI0?=
 =?gb2312?B?Sk03ODNvekQ4dGlGK0U3YVYzQUlpcFBja3R6UnBvNDUvNERaVUUwR2p5R0Fp?=
 =?gb2312?B?OE9TU1pWVlVoNGd5UFkvcDZFWTBYSDdBVnFQQVhpcEJvaVpDQS9qVXBjZTBM?=
 =?gb2312?B?ck1MNkpHNFFQR21oRzhaUDBiWi9JQkhkTXBTZkZQdmNldjVXdjJBQ0kyVE9Z?=
 =?gb2312?B?WlZkYzFlMzFoWkxaV04xNGd5M1kvd1VVTXkyNkpSR2V0MHNZOHRZTXoxbDY3?=
 =?gb2312?B?UzFxWFZkaWV6Skl0WTJWc2pPeXc4anE2dmpzc1QvQnRtaGFyMkptTTFNQmx5?=
 =?gb2312?Q?8yjOkRLC0G0Dc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1573.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed5610d-dc91-4b94-9dfe-08d8bc98d8ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 16:39:52.7069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MeAX371w4EoJhs1jRjYrIqtjUdKKxiE2ln6WOJGKHNcmIN4U1tgpOc0g6F87ELbn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1303
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1333009408=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1333009408==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB157352A2F7BF029B68A4A769E1A30CY4PR12MB1573namp_"

--_000_CY4PR12MB157352A2F7BF029B68A4A769E1A30CY4PR12MB1573namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSBBbmRyZXksDQoNCkkgdGhpbmsgdGhlIGxpc3QgaW4gdGhlIFhHTUkgaGl2ZSB3b24ndCBiZSBi
cmVhayBpbiB0aGUgbWlkZGxlIGlmIHdlIGxvY2sgdGhlIGRldmljZSBiZWZvcmUgd2UgY2hhbmdl
IHRoZSBsaXN0LiBCZWNhdXNlIGlmIDIgZGV2aWNlcyBpbiAxIGhpdmUgd2VudCBpbnRvIHRoZSBm
dW5jdGlvbiwgaXQgd2lsbCBmb2xsb3cgdGhlIHNhbWUgc2VxdWVuY2UgdG8gbG9jayB0aGUgZGV2
aWNlcy4gU28gb25lIG9mIHRoZW0gd2lsbCBkZWZpbmF0ZWx5IGJyZWFrIGF0IHRoZSBmaXJzdCBk
ZXZpY2UuIEkgYWRkIGl0ZXJhdGUgZGV2aWNlcyBoZXJlIGlzIGp1c3QgdG8gbG9jayBhbGwgZGV2
aWNlIGluIHRoZSBoaXZlIHNpbmNlIHdlIHdpbGwgY2hhbmdlIHRoZSBkZXZpY2Ugc2VxdWVuY2Ug
aW4gdGhlIGhpdmUgc29vbiBhZnRlci4NCg0KVGhlIHJlYXNvbiB0byBicmVhayB0aGUgaW50ZXJh
dGlvbiBpbiB0aGUgbWlkZGxlIGlzIHRoYXQgdGhlIGxpc3QgaXMgY2hhbmdlZCBkdXJpbmcgdGhl
IGl0ZXJhdGlvbiB3aXRob3V0IHRha2luZyBhbnkgbG9jay4gSXQgaXMgcXVpdGUgYmFkIHNpbmNl
IEknbSBmaXhpbmcgb25lIG9mIHRoaXMgaXNzdWUuIEFuZCBmb3IgWEdNSSBoaXZlLCB0aGVyZSBh
cmUgMiBsb2NrcyBwcm90ZWN0aW5nIHRoZSBsaXN0LCBvbmUgaXMgdGhlIGRldmljZSBsb2NrIEkg
Y2hhbmdlZCBoZXJlLCB0aGUgb3RoZXIgb25lIGlzIGluIGZyb250IG9mIG15IGNoYW5nZSwgdGhl
cmUgaXMgYSBoaXZlLT5sb2NrIHRvIHByb3RlY3QgdGhlIGhpdmUuDQoNCkV2ZW4gdGhlIGJhZCB0
aGluZyByZWFsbHkgaGFwcGVuZWQsIEkgdGhpbmsgbW92aW5nIGJhY2sgdGhyb3VnaCB0aGUgbGlz
dCBpcyBhbHNvIHZlcnkgZGVuZ2Vyb3VzIHNpbmNlIHdlIGRvbid0IGtub3cgd2hhdCB0aGUgbGlz
dCBmaW5hbGx5IGJlLCBVbmxlc3Mgd2Ugc3RhY2sgdGhlIGRldmljZXMgd2UgaGF2ZSBpdGVyYXRl
ZCB0aHJvdWdoIGEgbWlycm9yZWQgbGlzdC4gVGhhdCBjYW4gYmUgYSBiaWcgY2hhbmdlLg0KDQoN
CkknbSBvayB0byBzZXBlcmF0ZSB0aGUgbG9ja2luZyBpbiBhbWRncHVfZGV2aWNlX2xvY2tfYWRl
diBoZXJlLCBJJ2xsIGRvIHNvbWUgdGVzdCBhbmQgdXBkYXRlIHRoZSBjb2RlIGxhdGVyLg0KDQpU
aGFua3MgJiBSZWdhcmRzLA0KSG9yYWNlLg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCreivP7IyzogR3JvZHpvdnNreSwgQW5kcmV5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29t
Pg0Kt6LLzcqxvOQ6IDIwMjHE6jHUwjE5yNUgMjI6MzMNCsrVvP7IyzogQ2hlbiwgSG9yYWNlIDxI
b3JhY2UuQ2hlbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcgPGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0Ks63LzTogUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFt
ZC5jb20+OyBUdWlrb3YsIEx1YmVuIDxMdWJlbi5UdWlrb3ZAYW1kLmNvbT47IEtvZW5pZywgQ2hy
aXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBYaWFvLCBKYWNrIDxKYWNrLlhpYW9AYW1kLmNvbT47
IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBMaXUsIE1vbmsgPE1vbmsu
TGl1QGFtZC5jb20+OyBYdSwgRmVpZmVpIDxGZWlmZWkuWHVAYW1kLmNvbT47IFdhbmcsIEtldmlu
KFlhbmcpIDxLZXZpbjEuV2FuZ0BhbWQuY29tPjsgWGlhb2ppZSBZdWFuIDx4aWFvamllLnl1YW5A
YW1kLmNvbT4NCtb3zOI6IFJlOiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1OiByYWNlIGlzc3VlIHdo
ZW4gam9icyBvbiAyIHJpbmcgdGltZW91dA0KDQoNCk9uIDEvMTkvMjEgNzoyMiBBTSwgSG9yYWNl
IENoZW4gd3JvdGU6DQo+IEZpeCBhIHJhY2luZyBpc3N1ZSB3aGVuIGpvYnMgb24gMiByaW5ncyB0
aW1lb3V0IHNpbXVsdGFuZW91c2x5Lg0KPg0KPiBJZiAyIHJpbmdzIHRpbWVkIG91dCBhdCB0aGUg
c2FtZSB0aW1lLCB0aGUgYW1kZ3B1X2RldmljZV9ncHVfcmVjb3Zlcg0KPiB3aWxsIGJlIHJlZW50
ZXJlZC4gVGhlbiB0aGUgYWRldi0+Z21jLnhnbWkuaGVhZCB3aWxsIGJlIGdyYWJiZWQNCj4gYnkg
MiBsb2NhbCBsaW5rZWQgbGlzdCwgd2hpY2ggbWF5IGNhdXNlIHdpbGQgcG9pbnRlciBpc3N1ZSBp
bg0KPiBpdGVyYXRpbmcuDQo+DQo+IGxvY2sgdGhlIGRldmljZSBlYXJpbHkgdG8gcHJldmVudCB0
aGUgbm9kZSBiZSBhZGRlZCB0byAyIGRpZmZlcmVudA0KPiBsaXN0cy4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogSG9yYWNlIENoZW4gPGhvcmFjZS5jaGVuQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDQyICsrKysrKysrKysrKysr
Ky0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRp
b25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMN
Cj4gaW5kZXggNGQ0MzQ4MDNmYjQ5Li45NTc0ZGEzYWJjMzIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gQEAgLTQ1NDAsNiArNDU0MCw3IEBA
IGludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LA0KPiAgICAgICAgaW50IGksIHIgPSAwOw0KPiAgICAgICAgYm9vbCBuZWVkX2VtZXJnZW5jeV9y
ZXN0YXJ0ID0gZmFsc2U7DQo+ICAgICAgICBib29sIGF1ZGlvX3N1c3BlbmRlZCA9IGZhbHNlOw0K
PiArICAgICBib29sIGdldF9kZXZfbG9jayA9IGZhbHNlOw0KPg0KPiAgICAgICAgLyoNCj4gICAg
ICAgICAqIFNwZWNpYWwgY2FzZTogUkFTIHRyaWdnZXJlZCBhbmQgZnVsbCByZXNldCBpc24ndCBz
dXBwb3J0ZWQNCj4gQEAgLTQ1ODIsMjggKzQ1ODMsNDUgQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1
X3JlY292ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgICAgICAgKiBCdWlsZCBs
aXN0IG9mIGRldmljZXMgdG8gcmVzZXQuDQo+ICAgICAgICAgKiBJbiBjYXNlIHdlIGFyZSBpbiBY
R01JIGhpdmUgbW9kZSwgcmVzb3J0IHRoZSBkZXZpY2UgbGlzdA0KPiAgICAgICAgICogdG8gcHV0
IGFkZXYgaW4gdGhlIDFzdCBwb3NpdGlvbi4NCj4gKyAgICAgICoNCj4gKyAgICAgICogbG9jayB0
aGUgZGV2aWNlIGJlZm9yZSB3ZSB0cnkgdG8gb3BlcmF0ZSB0aGUgbGlua2VkIGxpc3QNCj4gKyAg
ICAgICogaWYgZGlkbid0IGdldCB0aGUgZGV2aWNlIGxvY2ssIGRvbid0IHRvdWNoIHRoZSBsaW5r
ZWQgbGlzdCBzaW5jZQ0KPiArICAgICAgKiBvdGhlcnMgbWF5IGl0ZXJhdGluZyBpdC4NCj4gICAg
ICAgICAqLw0KPiAgICAgICAgSU5JVF9MSVNUX0hFQUQoJmRldmljZV9saXN0KTsNCj4gICAgICAg
IGlmIChhZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMgPiAxKSB7DQo+ICAgICAgICAg
ICAgICAgIGlmICghaGl2ZSkNCj4gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RF
VjsNCj4gLSAgICAgICAgICAgICBpZiAoIWxpc3RfaXNfZmlyc3QoJmFkZXYtPmdtYy54Z21pLmhl
YWQsICZoaXZlLT5kZXZpY2VfbGlzdCkpDQo+IC0gICAgICAgICAgICAgICAgICAgICBsaXN0X3Jv
dGF0ZV90b19mcm9udCgmYWRldi0+Z21jLnhnbWkuaGVhZCwgJmhpdmUtPmRldmljZV9saXN0KTsN
Cj4gLSAgICAgICAgICAgICBkZXZpY2VfbGlzdF9oYW5kbGUgPSAmaGl2ZS0+ZGV2aWNlX2xpc3Q7
DQo+ICsNCj4gKyAgICAgICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2LCAmaGl2
ZS0+ZGV2aWNlX2xpc3QsIGdtYy54Z21pLmhlYWQpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAg
IGdldF9kZXZfbG9jayA9IGFtZGdwdV9kZXZpY2VfbG9ja19hZGV2KHRtcF9hZGV2LCBoaXZlKTsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgIGlmICghZ2V0X2Rldl9sb2NrKQ0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBicmVhazsNCg0KDQpXaGF0IGFib3V0IHVubG9ja2luZyBiYWNr
IGFsbCB0aGUgZGV2aWNlcyB5b3UgYWxyZWFkeSBsb2NrZWQgaWYgdGhlIGJyZWFrDQpoYXBwZW5z
IGluIHRoZSBtaWRkbGUgb2YgdGhlIGl0ZXJhdGlvbiA/DQpOb3RlIHRoYXQgYXQgc2tpcF9yZWNv
dmVyeTogd2UgZG9uJ3QgZG8gaXQuIEJUVywgaSBzZWUgdGhpcyBpc3N1ZSBpcyBhbHJlYWR5IGlu
DQp0aGUgY3VycmVudCBjb2RlLg0KDQpBbHNvLCBtYXliZSBub3cgaXQncyBiZXR0ZXIgdG8gc2Vw
YXJhdGUgdGhlIGFjdHVhbCBsb2NraW5nIGluDQphbWRncHVfZGV2aWNlX2xvY2tfYWRldg0KZnJv
bSB0aGUgb3RoZXIgc3R1ZmYgZ29pbmcgb24gdGhlcmUgc2luY2UgSSBkb24ndCB0aGluayB5b3Ug
d291bGQgd29udCB0byB0b2dnbGUNCnN0dWZmDQpsaWtlIGFkZXYtPm1wMV9zdGF0ZSBiYWNrIGFu
ZCBmb3J0aCBhbmQgYWxzbyB0aGUgZnVuY3Rpb24gbmFtZSBpcyBub3QNCmRlc2NyaXB0aXZlIG9m
DQp0aGUgb3RoZXIgc3R1ZmYgZ29pbmcgb24gdGhlcmUgYW55d2F5Lg0KDQpBbmRyZXkNCg0KDQo+
ICsgICAgICAgICAgICAgfQ0KPiArICAgICAgICAgICAgIGlmIChnZXRfZGV2X2xvY2spIHsNCj4g
KyAgICAgICAgICAgICAgICAgICAgIGlmICghbGlzdF9pc19maXJzdCgmYWRldi0+Z21jLnhnbWku
aGVhZCwgJmhpdmUtPmRldmljZV9saXN0KSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbGlzdF9yb3RhdGVfdG9fZnJvbnQoJmFkZXYtPmdtYy54Z21pLmhlYWQsICZoaXZlLT5kZXZp
Y2VfbGlzdCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICBkZXZpY2VfbGlzdF9oYW5kbGUgPSAm
aGl2ZS0+ZGV2aWNlX2xpc3Q7DQo+ICsgICAgICAgICAgICAgfQ0KPiAgICAgICAgfSBlbHNlIHsN
Cj4gLSAgICAgICAgICAgICBsaXN0X2FkZF90YWlsKCZhZGV2LT5nbWMueGdtaS5oZWFkLCAmZGV2
aWNlX2xpc3QpOw0KPiAtICAgICAgICAgICAgIGRldmljZV9saXN0X2hhbmRsZSA9ICZkZXZpY2Vf
bGlzdDsNCj4gKyAgICAgICAgICAgICBnZXRfZGV2X2xvY2sgPSBhbWRncHVfZGV2aWNlX2xvY2tf
YWRldihhZGV2LCBoaXZlKTsNCj4gKyAgICAgICAgICAgICB0bXBfYWRldiA9IGFkZXY7DQo+ICsg
ICAgICAgICAgICAgaWYgKGdldF9kZXZfbG9jaykgew0KPiArICAgICAgICAgICAgICAgICAgICAg
bGlzdF9hZGRfdGFpbCgmYWRldi0+Z21jLnhnbWkuaGVhZCwgJmRldmljZV9saXN0KTsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgIGRldmljZV9saXN0X2hhbmRsZSA9ICZkZXZpY2VfbGlzdDsNCj4g
KyAgICAgICAgICAgICB9DQo+ICsgICAgIH0NCj4gKw0KPiArICAgICBpZiAoIWdldF9kZXZfbG9j
aykgew0KPiArICAgICAgICAgICAgIGRldl9pbmZvKHRtcF9hZGV2LT5kZXYsICJCYWlsaW5nIG9u
IFREUiBmb3Igc19qb2I6JWxseCwgYXMgYW5vdGhlciBhbHJlYWR5IGluIHByb2dyZXNzIiwNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBqb2IgPyBqb2ItPmJhc2UuaWQg
OiAtMSk7DQo+ICsgICAgICAgICAgICAgciA9IDA7DQo+ICsgICAgICAgICAgICAgLyogZXZlbiB3
ZSBza2lwcGVkIHRoaXMgcmVzZXQsIHN0aWxsIG5lZWQgdG8gc2V0IHRoZSBqb2IgdG8gZ3VpbHR5
ICovDQo+ICsgICAgICAgICAgICAgZ290byBza2lwX3JlY292ZXJ5Ow0KPiAgICAgICAgfQ0KPg0K
PiAgICAgICAgLyogYmxvY2sgYWxsIHNjaGVkdWxlcnMgYW5kIHJlc2V0IGdpdmVuIGpvYidzIHJp
bmcgKi8NCj4gICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnkodG1wX2FkZXYsIGRldmljZV9saXN0
X2hhbmRsZSwgZ21jLnhnbWkuaGVhZCkgew0KPiAtICAgICAgICAgICAgIGlmICghYW1kZ3B1X2Rl
dmljZV9sb2NrX2FkZXYodG1wX2FkZXYsIGhpdmUpKSB7DQo+IC0gICAgICAgICAgICAgICAgICAg
ICBkZXZfaW5mbyh0bXBfYWRldi0+ZGV2LCAiQmFpbGluZyBvbiBURFIgZm9yIHNfam9iOiVsbHgs
IGFzIGFub3RoZXIgYWxyZWFkeSBpbiBwcm9ncmVzcyIsDQo+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgam9iID8gam9iLT5iYXNlLmlkIDogLTEpOw0KPiAtICAgICAgICAgICAgICAg
ICAgICAgciA9IDA7DQo+IC0gICAgICAgICAgICAgICAgICAgICBnb3RvIHNraXBfcmVjb3Zlcnk7
DQo+IC0gICAgICAgICAgICAgfQ0KPiAtDQo+ICAgICAgICAgICAgICAgIC8qDQo+ICAgICAgICAg
ICAgICAgICAqIFRyeSB0byBwdXQgdGhlIGF1ZGlvIGNvZGVjIGludG8gc3VzcGVuZCBzdGF0ZQ0K
PiAgICAgICAgICAgICAgICAgKiBiZWZvcmUgZ3B1IHJlc2V0IHN0YXJ0ZWQuDQo=

--_000_CY4PR12MB157352A2F7BF029B68A4A769E1A30CY4PR12MB1573namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Andrey,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I think the list in the XGMI hive won't be break in the middle if we lock t=
he device before we change the list. Because if 2 devices in 1 hive went in=
to the function, it will follow the same sequence to lock the devices. So o=
ne of them will definately break
 at the first device. I add iterate devices here is just to lock all device=
 in the hive since we will change the device sequence in the hive soon afte=
r.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The reason to break the interation in the middle is that the list is change=
d during the iteration without taking any lock. It is quite bad since I'm f=
ixing one of this issue. And for XGMI hive, there are 2 locks protecting th=
e list, one is the device lock I
 changed here, the other one is in front of my change, there is a hive-&gt;=
lock to protect the hive.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Even the bad thing really happened, I think moving back through the list is=
 also very dengerous since we don't know what the list finally be, Unless w=
e stack the devices we have iterated through a mirrored list. That can be a=
 big change.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I'm ok to seperate the locking in <font size=3D"2"><span style=3D"font-size=
:11pt">amdgpu_device_lock_adev here, I'll do some test and update the code =
later.<br>
</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt"><br>
</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">Thanks &amp; Regards,</span=
></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">Horace.</span></font><br>
</div>
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> Grodz=
ovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2021=C4=EA1=D4=C219=C8=D5 22:33<br>
<b>=CA=D5=BC=FE=C8=CB:</b> Chen, Horace &lt;Horace.Chen@amd.com&gt;; amd-gf=
x@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>=B3=AD=CB=CD:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Tuikov, Luben &l=
t;Luben.Tuikov@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Xiao, Jack &lt;J=
ack.Xiao@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Liu, Mo=
nk
 &lt;Monk.Liu@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Wang, Kevi=
n(Yang) &lt;Kevin1.Wang@amd.com&gt;; Xiaojie Yuan &lt;xiaojie.yuan@amd.com&=
gt;<br>
<b>=D6=F7=CC=E2:</b> Re: [PATCH 1/2] drm/amdgpu: race issue when jobs on 2 =
ring timeout</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
On 1/19/21 7:22 AM, Horace Chen wrote:<br>
&gt; Fix a racing issue when jobs on 2 rings timeout simultaneously.<br>
&gt;<br>
&gt; If 2 rings timed out at the same time, the amdgpu_device_gpu_recover<b=
r>
&gt; will be reentered. Then the adev-&gt;gmc.xgmi.head will be grabbed<br>
&gt; by 2 local linked list, which may cause wild pointer issue in<br>
&gt; iterating.<br>
&gt;<br>
&gt; lock the device earily to prevent the node be added to 2 different<br>
&gt; lists.<br>
&gt;<br>
&gt; Signed-off-by: Horace Chen &lt;horace.chen@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 42 ++++++++++=
+++++-------<br>
&gt;&nbsp;&nbsp; 1 file changed, 30 insertions(+), 12 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 4d434803fb49..9574da3abc32 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -4540,6 +4540,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devi=
ce *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_emergency_restart =
=3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool audio_suspended =3D fal=
se;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool get_dev_lock =3D false;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Special case: RAS tr=
iggered and full reset isn't supported<br>
&gt; @@ -4582,28 +4583,45 @@ int amdgpu_device_gpu_recover(struct amdgpu_de=
vice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Build list of device=
s to reset.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * In case we are in XG=
MI hive mode, resort the device list<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to put adev in the 1=
st position.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * lock the device before we try to ope=
rate the linked list<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * if didn't get the device lock, don't=
 touch the linked list since<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * others may iterating it.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;device_l=
ist);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_ph=
ysical_nodes &gt; 1) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!hive)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-ENODEV;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!list_is_first(&amp;adev-&gt;gmc.xgmi.head, &amp;hive-&gt;device_li=
st))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_rotate_to_front(&a=
mp;adev-&gt;gmc.xgmi.head, &amp;hive-&gt;device_list);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; device_list_handle =3D &amp;hive-&gt;device_list;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; list_for_each_entry(tmp_adev, &amp;hive-&gt;device_list, gmc.xgmi.head)=
 {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_dev_lock =3D amdgpu=
_device_lock_adev(tmp_adev, hive);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!get_dev_lock)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
<br>
<br>
What about unlocking back all the devices you already locked if the break<b=
r>
happens in the middle of the iteration ?<br>
Note that at skip_recovery: we don't do it. BTW, i see this issue is alread=
y in <br>
the current code.<br>
<br>
Also, maybe now it's better to separate the actual locking in <br>
amdgpu_device_lock_adev<br>
from the other stuff going on there since I don't think you would wont to t=
oggle <br>
stuff<br>
like adev-&gt;mp1_state back and forth and also the function name is not <b=
r>
descriptive of<br>
the other stuff going on there anyway.<br>
<br>
Andrey<br>
<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (get_dev_lock) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!list_is_first(&amp=
;adev-&gt;gmc.xgmi.head, &amp;hive-&gt;device_list))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; list_rotate_to_front(&amp;adev-&gt;gmc.xgmi.head, =
&amp;hive-&gt;device_list);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_list_handle =3D =
&amp;hive-&gt;device_list;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; list_add_tail(&amp;adev-&gt;gmc.xgmi.head, &amp;device_list);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; device_list_handle =3D &amp;device_list;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; get_dev_lock =3D amdgpu_device_lock_adev(adev, hive);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp_adev =3D adev;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (get_dev_lock) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;adev=
-&gt;gmc.xgmi.head, &amp;device_list);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_list_handle =3D =
&amp;device_list;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!get_dev_lock) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_info(tmp_adev-&gt;dev, &quot;Bailing on TDR for s_job:%llx, as anot=
her already in progress&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; jo=
b ? job-&gt;base.id : -1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* even we skipped this reset, still need to set the job to guilty */<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto skip_recovery;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* block all schedulers and =
reset given job's ring */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev=
, device_list_handle, gmc.xgmi.head) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!amdgpu_device_lock_adev(tmp_adev, hive)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(tmp_adev-&gt;d=
ev, &quot;Bailing on TDR for s_job:%llx, as another already in progress&quo=
t;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job ? job-&gt;base.id : -1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto skip_recovery;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * Try to put the audio codec into suspend state<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * before gpu reset started.<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB157352A2F7BF029B68A4A769E1A30CY4PR12MB1573namp_--

--===============1333009408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1333009408==--
