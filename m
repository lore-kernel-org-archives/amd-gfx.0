Return-Path: <SRS0=y248=KD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F26CC433ED
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 08:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BFD6145E
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 08:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BFD6145E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8942D6E864;
	Sat,  8 May 2021 08:45:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2DB76E864
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 May 2021 08:45:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrRpSCaJlYxGOfquns39LG7vcah2YWtpsykTy94Ixuv7F1QIXrvsm4iw7g2ORVqymokoQfgoGv9JytJXz27xoSTgynxcdkJNNtKbOOQhHHKKO5RHRXQYoiiwKqbZ57KmPb/m6lDVfLOwM57g1LAnLHLGpu3pTF3sko61jPjZTQtcivE37WePjsZpCLXAApYqcrkQkO4xPGUNmJkksMfR/+AIu6YMg3tbOap+bjf2FCeHcb6BcZ+IzoDWhBo76h/+gsm2T/HYB/yxnfym8gzwktoa/ewLnZZPJxI+toJsp1Wxdin+hqE0Yf79Q3bv9KL0P3m17FDDz7FObnC0FK3NpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nq8tOkpU+MMQzhcbvUiDfPWe+DZZRslWFianrkIuAR4=;
 b=POp+yo2q7rp36OgRcqR6+eAevLHfVinyDqxreNfg2MOgrou85rqzMu+Zdg6nlouKFd/zgo4Necaq0FG/pCdOiccy4ndblDOqHdNcNAppDAo+ux7GiepXYL8h+f0jZ9MaJHVtCTGbwtDrcZljfQmd0jC36js3cBc2pVvI23rfDVFh+jeeFj1C3/f5CvxZ3BGnjWCM8+4WUCVX9PdlnZtMYAmy2asF3QB7WicDkikC5L7LevA8uP9yIbiTAdULLLt6S9W5rJwNODcny+4xqyvgzmZtOzsnSNudJAYjka7mcxwUr3Jv7jeeb9+f6/YXo/RJJrQJM+TRcH/y+4yUm2+7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nq8tOkpU+MMQzhcbvUiDfPWe+DZZRslWFianrkIuAR4=;
 b=0qh8PjymkO058FuqmisRbeXKGHD7OU7LNQDBc/ob1XPENVD7cCXgIOouoSq6SlbJisIdth7D1cfUzZQRZMQD3JjPYaidCYVXEfNn4rNfpknjXVSMoo5fvlESVHmQabe2kPHBAKbrJDJmTOJmg2pULEULzqJRgVOlqPgFVsrMbO8=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Sat, 8 May
 2021 08:45:08 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4108.030; Sat, 8 May 2021
 08:45:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zeng, Oak" <Oak.Zeng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Quit RAS initialization earlier if RAS is
 disabled
Thread-Topic: [PATCH] drm/amdgpu: Quit RAS initialization earlier if RAS is
 disabled
Thread-Index: AQHXQt5lHxTwcQyoLEKnPHwctuHzQ6rX/SMAgABm+4CAAOLjEA==
Date: Sat, 8 May 2021 08:45:08 +0000
Message-ID: <BN9PR12MB536866E914B106FABD5E172EFC569@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <1620350085-22406-1-git-send-email-Oak.Zeng@amd.com>
 <BN9PR12MB5368CC933FDBA85FAE4A9391FC579@BN9PR12MB5368.namprd12.prod.outlook.com>
 <1461C211-D83A-4573-B569-BB04EDC271FE@amd.com>
In-Reply-To: <1461C211-D83A-4573-B569-BB04EDC271FE@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-08T08:45:06Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=d229196c-4caa-4896-b950-71f0cfe39012;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ae17a5e-0e90-45fd-8343-08d911fd95b6
x-ms-traffictypediagnostic: BN9PR12MB5211:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5211FEBFE4CA7B063543E013FC569@BN9PR12MB5211.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 372twFNrsQm8vjNhfhr1XkpBnfkR2XwNYD5LuI6QVYYn6ePKmT9lghIVQAiY/Dq3uEY1wtsvUKIlNMo9gX/995t6eloFdMkz2JMuWjCf5BAPP3Pdbv2h3n1K6NIH44k3P6cFtJYDe/H78bboEP7XlOwslQcfTRs+aO1DJm97Y4FTMm1XYqRe2Cz/uxwCxPsz/qqYVLi21hQm7L+Q7Yet3X/wF0bFgDeCJpsdqRt9SlIHWaoIwoqu4mNmnTHeNxJg28004Yvgix2FbEWul2k5O6dqinjYtSy+60qW4/nWww/XR45Bk+CJDTXvGX/o9FOTISZicvvI+sE8kCD1/1E6YoRWF/DMKjei4m/UfHCHTl9X62stosaEAP8cgH6BHd31e2xsT4hRftlU6k7LoQ97Dv6g1qQ8fOnJunqcaTPRUQkXJoNZEsc+rb3u2/HKuJvYPMWXjLsguRi8oUJRgUtKY3R0kEHWfsHfqPriQE8iZs+pzCv/+3jxH6LZ1xOWDEY0ex9EXYBQJbhLhpYOtPTDBp2lubtuD3cK0XTbbhzrO9t/wg35ZxOj2Mx2iNMwvUWKEWgN5305ZKOHok1Obf6a9yRmIKwceww/fYWkfQGEvDQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(83380400001)(53546011)(4326008)(6506007)(186003)(66476007)(66556008)(54906003)(33656002)(66446008)(38100700002)(66946007)(76116006)(122000001)(55016002)(110136005)(9686003)(8936002)(7696005)(5660300002)(2906002)(52536014)(478600001)(71200400001)(86362001)(8676002)(316002)(26005)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?Y3h3NUpNcHZ0NnZPOEJXODNoVGZ0cTdYaVZaUmdWSFphWnlNU1pRQ0NpUzdV?=
 =?utf-8?B?bVkwVkZmQ1NHRDJQV3V1cjJxNGgrbDBGNldlZFlacUxQVktEQ28wNnJKcExP?=
 =?utf-8?B?OWFoL1pPTENJY3dSTkV1aUtFdmZtYzFLa3VjMytUc1FzdkNZb3RTcjVKcE03?=
 =?utf-8?B?UEYxenF2RHo0d3k3RWdibWhBdGlTNWJKZElId09Vak9PWHk4Z1I2OHNMWWdP?=
 =?utf-8?B?bTltQXd4TzI4RkRhZWx5RDYrMHc4eHRod3d0SHRHMlVSNDhXV1RvdHJDejJo?=
 =?utf-8?B?Z2locklKSGNOUWE5cjJON0ZBNEUwMUZ2bWM2VTl4Znc0YVJtTkxYRWUxSmxj?=
 =?utf-8?B?d1BKWlh3Rk9UdnNSeDRxWWtjQS9SWkdwaDBQbit5Mk1YSytGMXVwdlg2NVkr?=
 =?utf-8?B?OVlVMXlia2VIZVZFY1pkbTh4V1JUQTlWKzJpVEg5eitzZnNZKzgyTHhFZEp2?=
 =?utf-8?B?ZFZjNGtyL3RSYmtsdE1ITmpwQzVMQlFBT0s2OVV4MTlyQng1SjZ0eDV4M0pG?=
 =?utf-8?B?Q2dvVU42OVRsVnBENzJYUDRRb1I1UGVrQnhDd2hjR3cwbEZ6bHRCQ3dSN1RW?=
 =?utf-8?B?c1dMS0kwVlZmeVJuVlp1eEhOb0RKSDg5RmlFQ3dZbFhiSldkSGVTcHpGbDUv?=
 =?utf-8?B?UG5OSVNoOCtneGhxMUZvRjZhVHhVTDAwdUJVY3luNGhVcE9jU3dCVFNhL3dl?=
 =?utf-8?B?N0QwNTdFdWFqOUV2dGt2L2R4MFo0QkZ1TUpLRXZFSkEyRGFDQXE0MHZ1L3ds?=
 =?utf-8?B?aVkrUVNGRjExME1JQUZxTGwzZWxXT0VPMTMrTHRwWlJ0RDhHbDMwTFI2cG1k?=
 =?utf-8?B?MzM3WC90dGFwWlVMOXgzbW5JK015c1F3SDN4cW1NTXVXMFE3VStQUVlOOFlN?=
 =?utf-8?B?akpRMGV0Vmh5TmFTQTBpelZFTHNsQmJSN2NNazRDbEkydGNNNUFiSE9qTjhD?=
 =?utf-8?B?ZmpWUmxIK0x1WVpsSUJsMzBIRHhkU3lqcEtNZmtXVElPU3djeG1OTDJZeFBZ?=
 =?utf-8?B?SFYxR2toRjNabTZ1YndJcmhZbmt6dU1MYkRpdjkwT3F5dS93aHBHUWEyVWN5?=
 =?utf-8?B?MWU1cElpbU9MU04xT1M5Y2FwYnNYZEh4NzlCenM1eHl3SUdESlBzTEY0ZDlK?=
 =?utf-8?B?eDREb0xXOHY3NlpPVXZEQ1Z0MTVuYVVnTmZGWU5QcXJoaTBmcUptWGNGNktW?=
 =?utf-8?B?N2xHL0pWaWI0OUdFRDU0NDBuSTBONkt6QlN4U1MzeXdFTGRDN1lWOTlaMFNR?=
 =?utf-8?B?OVBLYWdqUnhKNWN5Y0hPMXdEbkw4UmZ4M1pDcWhXTHhOVHpwMjJVZkdGbVhQ?=
 =?utf-8?B?OWQrNkpsR203bDkrakhvaUk0Vkk3T21ZYnN5YmRzUEkxcnp6MWJ2MllVL3BV?=
 =?utf-8?B?cmtnUkd2SDlrS1NvVVhMSm1xdmxCa2xwME9JMWJRc3lFTW5JakVuc085MGxE?=
 =?utf-8?B?S1Z0WHB1SnhndGVuaFlLbnlwRHhzRmswaWdGV1BtR1FVWHBicFZjV0g0MG05?=
 =?utf-8?B?cDZzNDcxN2plWGtBT05TTXI1VmRjUFVtMnpCaDFWRm5YbVRCcUVMTEFzTUV2?=
 =?utf-8?B?aGxKbldzUVBISEJwNUNCZXRoVTFnNTJRV1l3VVVxWHZCN3VoaXVKWEoyYkZQ?=
 =?utf-8?B?a3pvNnNraGtRb3V3SjZ3bDVnL0dQeFFmNlp3ekRmNXMrbXJhZURZcFMvSzZt?=
 =?utf-8?B?cjVhdTJWZWt0QjZ3V1plMzVPenJhdmxldVloZWtSa2NURTlMeUpqT2prV0VD?=
 =?utf-8?Q?ur1eJd8zWL8L3LDGlCAC9/nSydps39FqGME8Iev?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae17a5e-0e90-45fd-8343-08d911fd95b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2021 08:45:08.3520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TOtnHYxMbm1nyx5aPaDAxX4oxtqh1z0t3Opoub+GqZFIR6/8arQjAb4rVch83dE/mo1FFMDM5REzMo58jUDJfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211
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
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Clements, John" <John.Clements@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpObyB3b3JyeS4gSSBtYWRlIHNpbWlsYXIgbWlzdGFrZSBiZWZv
cmUuDQoNClJlZ2FyZHMsDQpIYXdraW5nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBaZW5nLCBPYWsgPE9hay5aZW5nQGFtZC5jb20+IA0KU2VudDogU2F0dXJkYXksIE1heSA4
LCAyMDIxIDAzOjEzDQpUbzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogTGF6YXIsIExpam8gPExpam8uTGF6
YXJAYW1kLmNvbT47IENsZW1lbnRzLCBKb2huIDxKb2huLkNsZW1lbnRzQGFtZC5jb20+OyBKb3No
aSwgTXVrdWwgPE11a3VsLkpvc2hpQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0v
YW1kZ3B1OiBRdWl0IFJBUyBpbml0aWFsaXphdGlvbiBlYXJsaWVyIGlmIFJBUyBpcyBkaXNhYmxl
ZA0KDQpUaGFuayB5b3UgSGF3a2luZyBmb3IgcmV2aWV3aW5nIHRoaXMuIEkgbWFkZSBhIG1pc3Rh
a2Ugd2hlbiBJIHB1c2hlZCB0aGlzIGluLiBJIGZvcmdvdCB0byBhZGQgIiBSZXZpZXdlZC1ieTog
SGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPiIuIA0KDQpSZWdhcmRzLA0KT2Fr
IA0KDQogDQoNCu+7v09uIDIwMjEtMDUtMDcsIDk6MDUgQU0sICJaaGFuZywgSGF3a2luZyIgPEhh
d2tpbmcuWmhhbmdAYW1kLmNvbT4gd3JvdGU6DQoNCiAgICBbQU1EIFB1YmxpYyBVc2VdDQoNCiAg
ICBSZXZpZXdlZC1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KDQog
ICAgUmVnYXJkcywNCiAgICBIYXdraW5nDQogICAgLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CiAgICBGcm9tOiBaZW5nLCBPYWsgPE9hay5aZW5nQGFtZC5jb20+IA0KICAgIFNlbnQ6IEZyaWRh
eSwgTWF5IDcsIDIwMjEgMDk6MTUNCiAgICBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCiAgICBDYzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IExhemFy
LCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+OyBDbGVtZW50cywgSm9obiA8Sm9obi5DbGVtZW50
c0BhbWQuY29tPjsgSm9zaGksIE11a3VsIDxNdWt1bC5Kb3NoaUBhbWQuY29tPjsgWmVuZywgT2Fr
IDxPYWsuWmVuZ0BhbWQuY29tPg0KICAgIFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogUXVp
dCBSQVMgaW5pdGlhbGl6YXRpb24gZWFybGllciBpZiBSQVMgaXMgZGlzYWJsZWQNCg0KICAgIElm
IFJBUyBpcyBkaXNhYmxlZCB0aHJvdWdoIGFtZGdwdV9yYXNfZW5hYmxlIGtlcm5lbCBwYXJhbWV0
ZXIsIHdlIHNob3VsZCBxdWl0IHRoZSBSQVMgaW5pdGlhbGl6YXRpb24gZWFyaWxlciB0byBhdm9p
ZCBpbml0aWFsaXphdGlvbiBvZiBzb21lIFJBUyBkYXRhIHN0cnVjdHVyZSBzdWNoIGFzIHN5c2Zz
IGV0Yy4NCg0KICAgIFNpZ25lZC1vZmYtYnk6IE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29tPg0K
ICAgIC0tLQ0KICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgfCAy
ICstDQogICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
DQogICAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KICAgIGluZGV4IGVi
YmUyYzUuLjdlNjViMzUgMTAwNjQ0DQogICAgLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhcy5jDQogICAgKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Jhcy5jDQogICAgQEAgLTIxNTUsNyArMjE1NSw3IEBAIGludCBhbWRncHVfcmFzX2luaXQo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQoNCiAgICAgCWFtZGdwdV9yYXNfY2hlY2tfc3Vw
cG9ydGVkKGFkZXYsICZjb24tPmh3X3N1cHBvcnRlZCwNCiAgICAgCQkJJmNvbi0+c3VwcG9ydGVk
KTsNCiAgICAtCWlmICghY29uLT5od19zdXBwb3J0ZWQgfHwgKGFkZXYtPmFzaWNfdHlwZSA9PSBD
SElQX1ZFR0ExMCkpIHsNCiAgICArCWlmICghYWRldi0+cmFzX2ZlYXR1cmVzIHx8IChhZGV2LT5h
c2ljX3R5cGUgPT0gQ0hJUF9WRUdBMTApKSB7DQogICAgIAkJLyogc2V0IGdmeCBibG9jayByYXMg
Y29udGV4dCBmZWF0dXJlIGZvciBWRUdBMjAgR2FtaW5nDQogICAgIAkJICogc2VuZCByYXMgZGlz
YWJsZSBjbWQgdG8gcmFzIHRhIGR1cmluZyByYXMgbGF0ZSBpbml0Lg0KICAgICAJCSAqLw0KICAg
IC0tDQogICAgMi43LjQNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
