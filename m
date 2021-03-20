Return-Path: <SRS0=4T84=IS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF9AC433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 00:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C30D61975
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 00:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C30D61975
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ACB16EB11;
	Sat, 20 Mar 2021 00:31:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F2726EB11
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Mar 2021 00:31:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwWhobg1xNDaZHMKgnjd1d14tK8s6iP2rzemY6U0y1gLiLyceYTdZV3qBplRooesmXespatSr3iPcJt7Yn3qUJFbbgpWFuwKw4hhOInRzGvZz2U5IjZRD1M7ijVE/jBEpGD24hpAduSKsMjYaj64JOkx0qy+kqwRJ8kd567hrpHg3Zj8qVQyJ5HzN+jKZUTZqrdcJ96J9EQEF8jw9/UMfHzBwDRk91r/ZU2HBTD3vPTVRfIjLrOvf+Mzna+/Gc92nvt6LM7MHfsBIKpcourJG7HCXRVDNk+iSNt5mN644VK4vpWovrwZSdi3RHNDBI1yWCgl2rN9VcIOD9gvjuh+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO1NHkvhpCPllGgKFv0vwEobddVjzfHM0qjRsFHrskE=;
 b=E6lUQv0hPde7FIMBAzfXuQFdLA2noBcxzgG2xGCAPoGc0J2PQwVskjp6oz6nka2pRy6PrZLgmq+9oyMZpZdaj1ANsZrEjPgZaaw9WRGeJJsrvMRc/6+8SIEUndlCJzig3HH6Jn4NjIMVdxFt8v86PfF/mQs6+qjv5pUCy2fByktHn61nNbc8nudLT4Pvp9oRBL+QaIkYCkqNlid99NUcIuEZMKNpFkGkc/gzyXrs71pZbwOtzRVbIhucVHwDlj5d8gd+UXmq/m8oB/OOkgA0WDVpYgS8/fAZwDNUR7lQiSfGQDjTaG74HxGMEtM7dtMtbg+dFk/prNq+LGdjH2Ua4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO1NHkvhpCPllGgKFv0vwEobddVjzfHM0qjRsFHrskE=;
 b=c6H/lFJMfl7oMmA3YymqtAjd+CGcDJaEF5eA08X257rMoNlmtKPb67IBxMSF6X7dwZwQaw1E00Tdd4g2O5XtB2uZjWOuY9rBEWiDEbwEz2viy1IL47v+aH+gRhXiRmNaPn0KbZxspd2yI+LMg7tW+MzN3wYAXpaoLS17NdSd9TU=
Received: from DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Sat, 20 Mar
 2021 00:31:02 +0000
Received: from DM6PR12MB4267.namprd12.prod.outlook.com
 ([fe80::3017:8af0:cb60:485a]) by DM6PR12MB4267.namprd12.prod.outlook.com
 ([fe80::3017:8af0:cb60:485a%9]) with mapi id 15.20.3933.033; Sat, 20 Mar 2021
 00:31:02 +0000
From: "R, Bindu" <Bindu.R@amd.com>
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Allow idle optimization based on vblank.
Thread-Topic: [PATCH] drm/amd/display: Allow idle optimization based on vblank.
Thread-Index: AQHXGr8h9juTNKU0QUGYcEdatosS4KqIDjKAgABa8oCAAg71L4AAqGqAgADpRHk=
Date: Sat, 20 Mar 2021 00:31:02 +0000
Message-ID: <DM6PR12MB4267121B24149811AB3658FFF5679@DM6PR12MB4267.namprd12.prod.outlook.com>
References: <20210316234952.254296-1-bindu.r@amd.com>
 <2a8218f2-9df9-d5c3-3a88-7e930a8c8524@daenzer.net>
 <MW3PR12MB4554B23D18EFB926B9EAFF05F96A9@MW3PR12MB4554.namprd12.prod.outlook.com>
 <DM6PR12MB42677FABD0BB51F870CD9DF4F5689@DM6PR12MB4267.namprd12.prod.outlook.com>,
 <d28b97df-8bc8-88cb-68aa-d0bd7adc611c@daenzer.net>
In-Reply-To: <d28b97df-8bc8-88cb-68aa-d0bd7adc611c@daenzer.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-20T00:31:01.609Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: daenzer.net; dkim=none (message not signed)
 header.d=none;daenzer.net; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:4ce1:13a0:a59e:e676:11b1:e20d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 734acb7c-add9-4dcd-d408-08d8eb3770fa
x-ms-traffictypediagnostic: DM6PR12MB4057:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4057EECFAC0FF2FD8CFA3617F5679@DM6PR12MB4057.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DM1yviRLimDR6q4LOsjsj2Nrif3jviR7Ij7KC8dGyXHWsf9X1MNBFX3kEEPiIpD2JggJXqcURQ3C/8i8N53LojFp908YOi5JMmqiAhmxKG42Oax2aP7WwZuQb8GErsd2mehlTbL3WT1/1CtY8JMYggQ7Jhrb28pSQFuUffzTdt+pLjqVfuSoxUp2aK5ZyH3N4spycCehGRDJLh+KXqv2dQqmaikezz0zpOs7FlA/5sWnlMGcd5oAW0ov/iJgOt8UboiJqEzZJQm0dOCJHqTkz8Ecth68Z5fYClBRXgS1ABEQ9cpm2NLRnu/Fd1WLFCB7MjHnRsnaYOuFoVQQ8GkyxPmapY2tZzosuyU6MHGLgVZrG/SrDFJJpDib7hnc3LUfmIgERsaQGj7eH3+Zg5laTqRY9D3S/5clNr4TpRaa7W4jcLUMP+O8/X9va560+a3dhgnP1c9JLpz4K3mmx/NSUajF1JO9y2SgMlHB1Zz+yr9/g5wRrF03zSNxhn1BCuNLBaRgXmLjtjfpA2xLk0cy7IJZkzaVWm9BKoVdrnzeOdECrLzirZdwSFgjVArHl3xtUI4Ae3bPJZcbUPcVm8MrNDThia4RuAlhG23eYJlMFNOVhdJ7yKQxnCIIcAGt042OKDvx7mYJ0+7H8u+I3Al+FhGdu/xOy0COnjfDOiE7qE8i2oneIPYM84Bss0H2Z1vnDkpYD8XdaZFoo/wWiSufnJkicbJLsbn4GenW+69EZxjBEH+SpixnLO7HyA0cApkB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4267.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(76116006)(7696005)(71200400001)(66946007)(478600001)(19627405001)(8936002)(52536014)(86362001)(966005)(66446008)(66476007)(4326008)(5660300002)(66556008)(166002)(64756008)(6506007)(55016002)(53546011)(2906002)(9686003)(33656002)(186003)(110136005)(316002)(54906003)(8676002)(38100700001)(66574015)(83380400001)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?NS9kZVhXSnZRMGR0TmU3Y0w1dXMreXZsSldlYTcvbTNtNC90NUxZTk5ES0d2?=
 =?utf-8?B?cUszcXU3VjJvc3dYS2ttVG1JeHN5UEVSZzZpVVVEeDFCZVRMelp3YzQ1eDVL?=
 =?utf-8?B?bkp2eHcyNGRUVXFxWFJTV3lzc1ZMRk83UGh3Z1RyYTg1MFFEb3pwNEE1MTVL?=
 =?utf-8?B?V0hGbXYxL1ZYbjJHdTQ2TGNhaGxsbStzYk01NEFEcWxiWWhaalJlbVNJeElW?=
 =?utf-8?B?Q0N2SVZuc3ErSlhuejc2UmNCSTBnYWU1TlpJT052T3BpMTkwN0Y5ZUVnSUFJ?=
 =?utf-8?B?OWNDTlhMeHIvSno3YUNJdGk5aXF1b25DK3UzSkxEMUpQY1hIc0xuTkhpTXll?=
 =?utf-8?B?Z2JjNzgzd1JYODdtQmZISjMrSXNVSysrNk5ENnFOMjI4amFvNEpxSW9WOWhq?=
 =?utf-8?B?NnNuVlpjUWFGWDNJUkd1eEdMRFlTQjl2YnZBakZFQWJmTXJhc29kVy92L1FY?=
 =?utf-8?B?Qzdxc2xoVW5VTFJBQjIwUHVvY2dQUzNXYXArcVBkRXNSVExxYXFrNTFVYnJD?=
 =?utf-8?B?Tmk2d0pyN25PbmZzcDViNWV6anhlR2d4SmlVS3hKc1pjWHVUTWZhTjQ2MkFn?=
 =?utf-8?B?cEE0eEdqaXBpaGNPcTVPdUJnbnl4bHZlSGRLYjd2RmlOUmxnTUNBQnFtQ2h2?=
 =?utf-8?B?T2JJaVhSSFB1OVdvNmxSZ0lEVW5oT05aaTR2VnVWelVQVmQzY1MrTjFYZE8x?=
 =?utf-8?B?ZU1nZXdhLzZSRWVLb3ZZMWJZeURzTmo4SFNjeHIwZHJ2Yi9GQWFpdDMyUG44?=
 =?utf-8?B?a0pBSDhJVUZYU2lvVHBtSFM0cFhKb3kvU2VCTFRQVFhRZzhTdTA3U0dJMi9j?=
 =?utf-8?B?MXRLV1ViTWd0T2p2VnlKdXdXVS9PK1F4VnJWUllvL2l3dGJjcFA3N2VJUndz?=
 =?utf-8?B?VFdVVnlWVTFwekpxRVdTYjh3N080SWowVlJMcEp3UUVDUjlEcytOMXFFZys1?=
 =?utf-8?B?R2YyNDZHMDJWcGlOdEhuMCtCd01WQ3hIeDFnUTByRXk5VkI3WkMvVXRkd05x?=
 =?utf-8?B?SVFValExY1UwMmx6WThDYWJESXdxN2xQYTNYQ243bHk2OHBYNkpla2lsdlNJ?=
 =?utf-8?B?YUg1bUxpWDlpU0hjUGZhVlN2SFZRQW5ubUp1aGRHUkVWeHI1WTh4ZzVYZzRS?=
 =?utf-8?B?T0M4eE5FWGx6aUI2emRJd2J2VVk1OWhsTnFSUUZXajBWc09OY0tlV3FqdEp1?=
 =?utf-8?B?VTRrNjFkdFdKNkVTUEJvS214ZUtkUVFWRk5pak54VElwTzVKZ3A3clp2QWM4?=
 =?utf-8?B?WGFIRHZQMDZDdkZkNnhWMU5oSVFTOEhLTXhuOGppV2JRaXNGZzlXUG1YMWRT?=
 =?utf-8?B?Q3BTUWFnU3oyMEhEdm1QWWdZWFVDNDFjN1BQRWtiNUFaZi85b2JIRXdlNGxr?=
 =?utf-8?B?aEJzanhCRW5GZEdlSHVLWk9UeWtoTnBLdWdYcVNiSXRKc2JyenRKQlRkTUkx?=
 =?utf-8?B?djNFRTFXWTYxR3ROd29jRHI1MzlnU1VtMjlPTm83Vjc1SDdnNXZCUEk3ZUU4?=
 =?utf-8?B?MzFyYjNaUHAxS3RMTUxBMXQzTk5UWmJIWXo4b2hUdVluRnBOYVQxQlJzSC9j?=
 =?utf-8?B?TS8yZDA5VDdsVCt2TWZONTJUdlRmRnJQMy8rOTZGVnppWmY1dnNNZm5CSDh1?=
 =?utf-8?B?aDRBdk5FZXd3a0RBOE1xTTJMMnBVbFJHZytPbkhWUnd6VXF6WThvb1A5UmJC?=
 =?utf-8?B?TGo3VHBTRlFiWnYzWmw3bnNJWXRDZGhudXRkVnV2L0FtbWF1WnNYWU5FMWlV?=
 =?utf-8?B?MjZLVW90TVJCV25CL0N5UUZTWTRqclNrVlNaYXQ1NkhpSCtaTUdrSjhqbS9p?=
 =?utf-8?B?dC9IaEhzK28rVzhkZ1E3YkJJa2RrOTY0Y3MrNFNXaGxGdlBTUXllbUFWMXBx?=
 =?utf-8?Q?lP/ROVMAdZlO0?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734acb7c-add9-4dcd-d408-08d8eb3770fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2021 00:31:02.2666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJ0WUL92QimmbuILfp2QEpU/EPjFyoq2PnOjEtoNI01K08H1pgo3/Xs2s8eWyNPfNgSkhng/z31w0jACkbybLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: multipart/mixed; boundary="===============1923060899=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1923060899==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4267121B24149811AB3658FFF5679DM6PR12MB4267namp_"

--_000_DM6PR12MB4267121B24149811AB3658FFF5679DM6PR12MB4267namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpU
aGUgVXBkYXRlIHBhdGNoIGhhcyBiZWVuIHN1Ym1pdHRlZC4NCg0K4oCLUmVnYXJkcywNCkJpbmR1
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTogTWljaGVsIETDpG56ZXIg
PG1pY2hlbEBkYWVuemVyLm5ldD4NClNlbnQ6IEZyaWRheSwgTWFyY2ggMTksIDIwMjEgNjozMSBB
TQ0KVG86IFIsIEJpbmR1IDxCaW5kdS5SQGFtZC5jb20+OyBMYWtoYSwgQmhhd2FucHJlZXQgPEJo
YXdhbnByZWV0Lkxha2hhQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyA8
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+
OyBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGRybS9hbWQvZGlzcGxheTogQWxsb3cgaWRsZSBvcHRpbWl6YXRpb24gYmFzZWQgb24gdmJs
YW5rLg0KDQpPbiAyMDIxLTAzLTE5IDE6NDQgYS5tLiwgUiwgQmluZHUgd3JvdGU6DQo+DQo+IOKA
i0hpIEFsbCwNCj4gICAgVGhhbmtzIGZvciB0aGUgaW5wdXRzLCBoYXZlIHVwZGF0ZWQgdGhlIHBh
dGNoIHRvIGluY2x1ZGUgdGhlc2UgY2hhbmdlcy4NCg0KVXBkYXRlZCB3aGVyZT8gSSBjYW4ndCBm
aW5kIGFuIHVwZGF0ZWQgcGF0Y2guDQoNCg0KLS0NCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAg
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZyZWRoYXQuY29tJTJGJmFtcDtk
YXRhPTA0JTdDMDElN0NCaW5kdS5SJTQwYW1kLmNvbSU3Q2JjMzEyMjVjNzY4ODRhNTg1NTlhMDhk
OGVhYzIyNTMxJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYz
NzUxNzQ2Njg4MTcyNjc2NSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3
TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAw
JmFtcDtzZGF0YT1xOSUyQkd4ZVBoVEtmcFFrTFpuWiUyQjVqVjFnU2IwaFlwQWVpam9MZWhKdm40
QSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAg
ICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyDQo=

--_000_DM6PR12MB4267121B24149811AB3658FFF5679DM6PR12MB4267namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxwIHN0eWxlPSJmb250LWZhbWlseTpBcmlh
bDtmb250LXNpemU6MTFwdDtjb2xvcjojMDA3OEQ3O21hcmdpbjo1cHQ7IiBhbGlnbj0iTGVmdCI+
DQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldPGJy
Pg0KPC9wPg0KPGJyPg0KPGRpdj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBDYWxpYnJpLCBB
cmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2Io
MCwgMCwgMCk7Ij4NCjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDExcHQ7Ij5UaGUgVXBkYXRlIHBh
dGNoIGhhcyBiZWVuIHN1Ym1pdHRlZC4gPC9zcGFuPjxicj4NCjwvZGl2Pg0KPGRpdiBzdHlsZT0i
Zm9udC1mYW1pbHk6IENhbGlicmksIEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQt
c2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KPGJyPg0KPC9kaXY+DQo8ZGl2IHN0
eWxlPSJmb250LWZhbWlseTogQ2FsaWJyaSwgQXJpYWwsIEhlbHZldGljYSwgc2Fucy1zZXJpZjsg
Zm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQo8c3BhbiBzdHlsZT0iZm9u
dC1zaXplOiAxMXB0OyI+4oCLPC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDExcHQ7Ij5S
ZWdhcmRzLDwvc3Bhbj48L2Rpdj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBDYWxpYnJpLCBB
cmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2Io
MCwgMCwgMCk7Ij4NCjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDExcHQ7Ij5CaW5kdSA8L3NwYW4+
PGJyPg0KPC9kaXY+DQo8ZGl2IGlkPSJhcHBlbmRvbnNlbmQiPjwvZGl2Pg0KPGhyIHN0eWxlPSJk
aXNwbGF5OmlubGluZS1ibG9jazt3aWR0aDo5OCUiIHRhYmluZGV4PSItMSI+DQo8ZGl2IGlkPSJk
aXZScGx5RndkTXNnIiBkaXI9Imx0ciI+PGZvbnQgZmFjZT0iQ2FsaWJyaSwgc2Fucy1zZXJpZiIg
c3R5bGU9ImZvbnQtc2l6ZToxMXB0IiBjb2xvcj0iIzAwMDAwMCI+PGI+RnJvbTo8L2I+IE1pY2hl
bCBEw6RuemVyICZsdDttaWNoZWxAZGFlbnplci5uZXQmZ3Q7PGJyPg0KPGI+U2VudDo8L2I+IEZy
aWRheSwgTWFyY2ggMTksIDIwMjEgNjozMSBBTTxicj4NCjxiPlRvOjwvYj4gUiwgQmluZHUgJmx0
O0JpbmR1LlJAYW1kLmNvbSZndDs7IExha2hhLCBCaGF3YW5wcmVldCAmbHQ7Qmhhd2FucHJlZXQu
TGFraGFAYW1kLmNvbSZndDs7IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnICZsdDthbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyZndDs8YnI+DQo8Yj5DYzo8L2I+IERldWNoZXIsIEFs
ZXhhbmRlciAmbHQ7QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbSZndDs7IFpob3UxLCBUYW8gJmx0
O1Rhby5aaG91MUBhbWQuY29tJmd0OzsgRmVuZywgS2VubmV0aCAmbHQ7S2VubmV0aC5GZW5nQGFt
ZC5jb20mZ3Q7PGJyPg0KPGI+U3ViamVjdDo8L2I+IFJlOiBbUEFUQ0hdIGRybS9hbWQvZGlzcGxh
eTogQWxsb3cgaWRsZSBvcHRpbWl6YXRpb24gYmFzZWQgb24gdmJsYW5rLjwvZm9udD4NCjxkaXY+
Jm5ic3A7PC9kaXY+DQo8L2Rpdj4NCjxkaXYgY2xhc3M9IkJvZHlGcmFnbWVudCI+PGZvbnQgc2l6
ZT0iMiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMXB0OyI+DQo8ZGl2IGNsYXNzPSJQbGFpblRl
eHQiPk9uIDIwMjEtMDMtMTkgMTo0NCBhLm0uLCBSLCBCaW5kdSB3cm90ZTo8YnI+DQomZ3Q7IDxi
cj4NCiZndDsg4oCLSGkgQWxsLDxicj4NCiZndDsgJm5ic3A7Jm5ic3A7IFRoYW5rcyBmb3IgdGhl
IGlucHV0cywgaGF2ZSB1cGRhdGVkIHRoZSBwYXRjaCB0byBpbmNsdWRlIHRoZXNlIGNoYW5nZXMu
PGJyPg0KPGJyPg0KVXBkYXRlZCB3aGVyZT8gSSBjYW4ndCBmaW5kIGFuIHVwZGF0ZWQgcGF0Y2gu
PGJyPg0KPGJyPg0KPGJyPg0KLS0gPGJyPg0KRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyJm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHwmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgPGEgaHJl
Zj0iaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGcmVkaGF0LmNvbSUyRiZhbXA7YW1wO2RhdGE9MDQlN0MwMSU3Q0JpbmR1LlIl
NDBhbWQuY29tJTdDYmMzMTIyNWM3Njg4NGE1ODU1OWEwOGQ4ZWFjMjI1MzElN0MzZGQ4OTYxZmU0
ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NTE3NDY2ODgxNzI2NzY1JTdDVW5r
bm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxD
SkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO2FtcDtzZGF0YT1xOSUyQkd4
ZVBoVEtmcFFrTFpuWiUyQjVqVjFnU2IwaFlwQWVpam9MZWhKdm40QSUzRCZhbXA7YW1wO3Jlc2Vy
dmVkPTAiPg0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHBzJTNBJTJGJTJGcmVkaGF0LmNvbSUyRiZhbXA7YW1wO2RhdGE9MDQlN0MwMSU3Q0Jp
bmR1LlIlNDBhbWQuY29tJTdDYmMzMTIyNWM3Njg4NGE1ODU1OWEwOGQ4ZWFjMjI1MzElN0MzZGQ4
OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NTE3NDY2ODgxNzI2NzY1
JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1
TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO2FtcDtzZGF0YT1x
OSUyQkd4ZVBoVEtmcFFrTFpuWiUyQjVqVjFnU2IwaFlwQWVpam9MZWhKdm40QSUzRCZhbXA7YW1w
O3Jlc2VydmVkPTA8L2E+PGJyPg0KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyB8Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IE1lc2EgYW5kIFggZGV2ZWxvcGVyPGJyPg0KPC9kaXY+DQo8
L3NwYW4+PC9mb250PjwvZGl2Pg0KPC9kaXY+DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_DM6PR12MB4267121B24149811AB3658FFF5679DM6PR12MB4267namp_--

--===============1923060899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1923060899==--
