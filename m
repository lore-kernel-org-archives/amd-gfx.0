Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FD8C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 08:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2794C64F21
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 08:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2794C64F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E9CF6EB21;
	Fri,  5 Mar 2021 08:43:45 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690053.outbound.protection.outlook.com [40.107.69.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D91026EB16
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 08:43:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DveuMi/XkPjuOAW4C69RpUgW84O9X7dWuhQeZsJNz+SbTB/3Pr5c3Q61RZA3nuDj7aqQftvJQP39r1ufJTbjXYqyuOFaE2SV+ARMTG2rD1CdQI8mGgsz1EzNIWpDmbRILbkNzFEMboPIjrjjZSNghHVGzwMnN0w0ja5UU10naH0022SdaFPFz9/vF30LuiqrvKUhk6SztGojRa9xc/fy8FsiwQK+OVR+GBDOqAaql9/pruRROB8h1d9L+4v+GiA+uQclrv0akrE2E1Xr+azdF0C2whe2caqS4gioaTMki+Adk8ycfxuAeEXPjA+xXHzrqFrXZulVDPKiyHuKTlEdRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Npt7IuI7j3wiHteq3jRwFU+AjcJD/q/bGc8EqwpKTYA=;
 b=gK2e7TeLc6NB9Sr1BFFd4YkOdI8t/YrBiJmbXbsf6IbFpKPYzdW8gkEulLDXj7G19yqlklb28JV3NxfQl7ZO+X91DRFaqj5Mh23NQOEqX/4z63nh+sIxIcUXAVFEfLFTOd4HzwaFhbAS77TmGnD/xtSYYwcgHjdfHNokr5mVRauyB0tMiQwFGA5yjZU0ldzVl8DwQ2nqUlMcynw861hGpA0pKTQR+3ttZQyKXJ/kqN2D9/kI1eO+Hn9DUECo+jMdVtI+fwTqfo8dJTrCHwjmgLmEwvdiFFuEbflVmZbgZAqivL5D4xgHki/9RFPB6s7jlpHqpdTrS0TP3zma2DPqwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Npt7IuI7j3wiHteq3jRwFU+AjcJD/q/bGc8EqwpKTYA=;
 b=zhe18g31I2vqG91SWHR4yyCXSYFHxQRhZexoTVsPPZI0sMz94Wh6pGgb/UWMze8lr7roQgZXNGdAfBXoWqaTD3bbyS4Z2hM/SJnVfnYL+xWOK+Ps+H81x1hFuTJ517fiEdU+7eL2OHJ66LxJoRkr9wUo75MTzHyQHaFHwEKSjps=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4999.namprd12.prod.outlook.com (2603:10b6:a03:1da::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 08:43:41 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3912.019; Fri, 5 Mar 2021
 08:43:41 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix some unload driver issues
Thread-Topic: [PATCH] drm/amdgpu: Fix some unload driver issues
Thread-Index: AQHXEV27YtpYoYbhtUOoONSNwG/opap1Bu4AgAAMA/A=
Date: Fri, 5 Mar 2021 08:43:41 +0000
Message-ID: <BY5PR12MB411507D0009D10FFA11F0C648F969@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210305012019.58196-1-Emily.Deng@amd.com>
 <3c929a45-c8d6-904b-25ce-2909e530dead@gmail.com>
In-Reply-To: <3c929a45-c8d6-904b-25ce-2909e530dead@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e7824c9c-4f9f-4de3-ac1d-e2281660e62f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-05T08:37:54Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47190232-325a-437a-bf62-08d8dfb2c74c
x-ms-traffictypediagnostic: BY5PR12MB4999:
x-microsoft-antispam-prvs: <BY5PR12MB4999BF8C5E64F6E10FD830948F969@BY5PR12MB4999.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LQgsfNjI/26OvsVvTH+UnzG9e9/Km006goNOT92gbdPXMPIc23A29dJ0K6Gybf18kRFE6qrisoqEubm2kTcfmYECE5/w1icO+NGbnkVX1ahQybcZIyGa1TWhJUwE119lEd763ZxYynjfXCpeoZyuRUCy7SCFlAjOPs5fjtNL8960R4tlWw3KWtpZ7vl1p+qkiCzGUqm1xOCLMFak6OKO5Aqg5EKE004prnAO4ddm8sL1FxuZpMQdV5kHHx5mZpx/EI7ebYoXsK5zfM3PGTDZsNnPx5y508EMc+FEHm6qAaCSwzYmNGQaJ1YYHvLyyRjJV1U/l/V9etr/eISL2kJOURGsJdPj4CcO0S+mvIg9sxdQB3xh9hMy69fKXycERRn5uN9f8OhcPYBQX0QuV/mkqMI8cekUQc9JoARtlTH8ue0vKDi3Ya9Fki+UogVnlvXJOmrksfirYNbD/iySfibCBapfYnuqPhN0Yhru3POu8Ys4a9M8EHeOUuFN8Mzb0kz56iA65irXdWW/d/ETTaf5sw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(33656002)(66556008)(66476007)(2906002)(316002)(76116006)(26005)(64756008)(71200400001)(186003)(478600001)(66946007)(86362001)(8676002)(110136005)(6506007)(5660300002)(66574015)(9686003)(55016002)(7696005)(83380400001)(8936002)(66446008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?V0JTdFl1ajZ2QXowcGZ5V3ZTVDNtOXNkYk5GZlRLclc2d2ZERStQcjJmMlBa?=
 =?utf-8?B?dFBETGVoVVRZckhsS2loeGNpZGkzbHhRQi9vWnNYdmxvL0xnRGlMd09VNUUw?=
 =?utf-8?B?RUluZ3VnZ1JWTjBvZnhUMUE1R1pJU0dneEdrL1Z0djN3aGFOalNjeTlUcUhN?=
 =?utf-8?B?bmdpRjlSZFVPdi96eERhQ2xTODVWTWdyaDdOSU4vTkZnZjdvS3krb09ZUjZL?=
 =?utf-8?B?dWR1UHQvdTNycytwMFV2U21MUFBnN2tUQVVSbUVaSkxjeXV5MXg0bDBkM2R6?=
 =?utf-8?B?MUpmYmxqd2xXS3ZUclFRQWNYMlU2SThkWEcvc3JMS2FjazNzR04xTmZBSGp0?=
 =?utf-8?B?ektUUU0rV1JUTHdOYi9WZ0ZaSVhXMUl0b2dQSkhXaXdHVHJOakwyaGp2Tmhu?=
 =?utf-8?B?NEhiN0JkY0Rha2YvWW9pdGJ6V1NMNE9LMEJ2OHM0MVJXcEkzZmEwR21UR0dR?=
 =?utf-8?B?M1Q1TnNvWTN2cXR3eDNPdkNUVWpKUGY5ZHc3Y3lVVWdFSU9DeUNPNkJXd2hq?=
 =?utf-8?B?RmEzdGZ0VzcvWkpzVDQ0YUY2ZHV3OHBBOHJuNFgxL2M5T04vUzNPd1I0QzA2?=
 =?utf-8?B?VWVZbDA1YXNWNFNreWNDU2VGaWxOcUZWalFLZjdiYWl3bkYrZmxaQzBiSDMr?=
 =?utf-8?B?VEloRjdZUFFaNzloNTBQT1FCWGVWR292aW5Na2E3NU05aWJqMGlEeG40Ylh0?=
 =?utf-8?B?bzdkNStFd3RhOEFOM010UjJpc0x0RjR2SzdRenc4aXhiNFpPRGFhQ2w0Vk00?=
 =?utf-8?B?VEMwdU93U2lUY2F3VGV5NDY3eWJnamZYa3N0aW5lajZjSHRCTjNYcWxZSEhs?=
 =?utf-8?B?ZmRMdTZtZkxMQ04zMnVTSVZjdUFSVW1hODBhbTNWdDVIT01TbEhwSGpBc2J0?=
 =?utf-8?B?ZnFHalZQOVQxQlRXUWE0dU5zVzBXc2t5N2hJdzYvaFl1NEFkbzFZc0oySkJL?=
 =?utf-8?B?Vk9VWldnZDNMc1NveGQyYzNuV0FTWERQNW00SUxZMEtlNDJmRnRPZml3Q2Rm?=
 =?utf-8?B?ajhXUjExSzIrNDRkNEVoMFRJcDJtaTJNSTFnYXBiODhleFhuVWMzSjFvZkow?=
 =?utf-8?B?VlVhelVsbU1HTU9kcFQxV085SUpkcG9NYjhwWjF6b0F5bk9uRTdCV1hsUjRr?=
 =?utf-8?B?cERjMks2TXc3bWdXSVZsbS9GRE1EYzVvajcwdnlOV0RXRzZyVkJGTy9jTnRy?=
 =?utf-8?B?M28rcEJNV2IwS1JWanBXOFczUVhnVTlXdWNyZ2YxcnI3Ujd0VktFK1J4VEV5?=
 =?utf-8?B?azNFNUFtTkpjQ3I2cjM5V0lHNWtvbFhhZzF2TG85M21LLy83TENSTnNqcDhx?=
 =?utf-8?B?YWdXc2xwMmhicW9welF3Z0hnZHpsbGdRc0hNMnZWMktacFFQdTdPKzl3OGRl?=
 =?utf-8?B?OWREckpWUkduVWN0UHhiSmliU3pDK1JZV1RRVVUxbnd1UnMrQWtBb2dvWlhH?=
 =?utf-8?B?Y09PL3hsaHg0cGdDVE5DUE1rd0U2NHo0dUpGSWZtU3JVZmJrampaWlIyQW9z?=
 =?utf-8?B?bWtUcXhCNFFVYkdmbVZRSmRMMis0VDFkMDg5OXVwRGE3VFIyRU1jVHZBcGJa?=
 =?utf-8?B?TUVvbTd0UUp6cEpncVpyaHFiOVJaMkVBWG9reHdvQXVNNE9pUHllamxmb2NW?=
 =?utf-8?B?U3h6UGU3Q2FqM2dTdEhZdUVGU0RMUHkrUzh6bVR6RVpkV1hhVHZGb1ovQzlO?=
 =?utf-8?B?Qm9XeVYzYUI0V0h5RUY3NldLVmxhWUhWL0VNaGtLeDlWNWd4MmxSQmxIbUNr?=
 =?utf-8?Q?mwDY12E8Y6ZEAtTDP0d73ddIVUeu3eJ4JgATz9J?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47190232-325a-437a-bf62-08d8dfb2c74c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 08:43:41.2738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jx+VQle2W1PSaAFJyV/7bgw5O9I++EAHq5wpW//dP2qNUQUflJJF4JwLjcilmt/u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4999
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQo+
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29l
bmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCj5TZW50OiBGcmlkYXksIE1hcmNoIDUsIDIw
MjEgMzo1NSBQTQ0KPlRvOiBEZW5nLCBFbWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPjsgYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1
OiBGaXggc29tZSB1bmxvYWQgZHJpdmVyIGlzc3Vlcw0KPg0KPkFtIDA1LjAzLjIxIHVtIDAyOjIw
IHNjaHJpZWIgRW1pbHkgRGVuZzoNCj4+IFdoZW4gdW5sb2FkaW5nIGRyaXZlciBhZnRlciBraWxs
aW5nIHNvbWUgYXBwbGljYXRpb25zLCBpdCB3aWxsIGhpdA0KPj4gc2RtYSBmbHVzaCB0bGIgam9i
IHRpbWVvdXQgd2hpY2ggaXMgY2FsbGVkIGJ5IHR0bV9ib19kZWxheV9kZWxldGUuIFNvDQo+PiB0
byBhdm9pZCB0aGUgam9iIHN1Ym1pdCBhZnRlciBmZW5jZSBkcml2ZXIgZmluaSwgY2FsbA0KPj4g
dHRtX2JvX2xvY2tfZGVsYXllZF93b3JrcXVldWUgYmVmb3JlIGZlbmNlIGRyaXZlciBmaW5pLiBB
bmQgYWxzbyBwdXQNCj5kcm1fc2NoZWRfZmluaSBiZWZvcmUgd2FpdGluZyBmZW5jZS4NCj4NCj5H
b29kIGNhdGNoLCBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPiBmb3INCj50aGlzIHBhcnQuDQo+DQo+PiBTZXQgYWRldi0+Z2FydC5wdHIgdG8g
bnVsbCB0byBmaXggbnVsbCBwb2ludGVyIHdoZW4gY2FsbGluZw0KPj4gYW1kZ3B1X2dhcnRfdW5i
aW5kIGluIGFtZGdwdV9ib19maW5pIHdoaWNoIGlzIGFmdGVyIGdhcnRfZmluaS4NCj4NCj5Gb3Ig
dGhhdCBvbmUgSSdtIHdvbmRlcmluZyBpZiB3ZSBzaG91bGRuJ3QgcmF0aGVyIHJld29yayBvciBk
b3VibGUgY2hlY2sgdGhlDQo+dGVhciBkb3duIG9yZGVyLg0KPg0KPk9uIHRoZSBvdGhlciBoYW5k
IHRoZSBoYXJkd2FyZSBzaG91bGQgYmUgaWRsZSBieSBub3cgKHRoaXMgY29tZXMgYWZ0ZXIgdGhl
DQo+ZmVuY2VfZHJpdmVyX2ZpbmksIGRvZXNuJ3QgaXQ/KSBhbmQgaXQgbG9va3MgY2xlYW5lciBv
biBpdCdzIG93bi4NClllcywgeW91IGFyZSByaWdodCwgd2l0aG91dCBjb25zaWRlciBtZW1vcnkg
bGVhaywgd2l0aCBhYm92ZSBwYXRjaCwgdGhlIGJvIGFyZSBhbGwgY2xlYW5lZCwgdGhlbiB3b24n
dCBoYXZlIGlzc3VlLiBCdXQgaWYgaGF2ZSBtZW1vcnkgbGVhaywgbWF5YmUgaXQgd2lsbCBoYXZl
IGlzc3VlIGluIHR0bV9ib19mb3JjZV9saXN0X2NsZWFuLT4gdHRtX21lbV9ldmljdF9maXJzdD8N
Cg0KPg0KPlJlZ2FyZHMsDQo+Q2hyaXN0aWFuLg0KPg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEVt
aWx5IERlbmcgPEVtaWx5LkRlbmdAYW1kLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAxICsNCj4+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgIHwgNSArKystLQ0KPj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jICAgfCAxICsNCj4+ICAgMyBmaWxlcyBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+IGluZGV4IGExMTc2MGVjMzkyNC4u
ZGUwNTk3ZDM0NTg4IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMNCj4+IEBAIC0zNTk0LDYgKzM1OTQsNyBAQCB2b2lkIGFtZGdwdV9kZXZpY2Vf
ZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiphZGV2KQ0KPj4gICB7DQo+PiAgIGRldl9pbmZv
KGFkZXYtPmRldiwgImFtZGdwdTogZmluaXNoaW5nIGRldmljZS5cbiIpOw0KPj4gICBmbHVzaF9k
ZWxheWVkX3dvcmsoJmFkZXYtPmRlbGF5ZWRfaW5pdF93b3JrKTsNCj4+ICt0dG1fYm9fbG9ja19k
ZWxheWVkX3dvcmtxdWV1ZSgmYWRldi0+bW1hbi5iZGV2KTsNCj4+ICAgYWRldi0+c2h1dGRvd24g
PSB0cnVlOw0KPj4NCj4+ICAga2ZyZWUoYWRldi0+cGNpX3N0YXRlKTsNCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KPj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KPj4gaW5kZXggMTQzYTE0ZjQ4NjZm
Li42ZDE2ZjU4YWM5MWUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZmVuY2UuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2ZlbmNlLmMNCj4+IEBAIC01MzEsNiArNTMxLDggQEAgdm9pZCBhbWRncHVfZmVuY2VfZHJp
dmVyX2Zpbmkoc3RydWN0DQo+YW1kZ3B1X2RldmljZQ0KPj4gKmFkZXYpDQo+Pg0KPj4gICBpZiAo
IXJpbmcgfHwgIXJpbmctPmZlbmNlX2Rydi5pbml0aWFsaXplZCkNCj4+ICAgY29udGludWU7DQo+
PiAraWYgKCFyaW5nLT5ub19zY2hlZHVsZXIpDQo+PiArZHJtX3NjaGVkX2ZpbmkoJnJpbmctPnNj
aGVkKTsNCj4+ICAgciA9IGFtZGdwdV9mZW5jZV93YWl0X2VtcHR5KHJpbmcpOw0KPj4gICBpZiAo
cikgew0KPj4gICAvKiBubyBuZWVkIHRvIHRyaWdnZXIgR1BVIHJlc2V0IGFzIHdlIGFyZSB1bmxv
YWRpbmcgKi8NCj5AQCAtNTM5LDgNCj4+ICs1NDEsNyBAQCB2b2lkIGFtZGdwdV9mZW5jZV9kcml2
ZXJfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+ICAgaWYgKHJpbmctPmZlbmNl
X2Rydi5pcnFfc3JjKQ0KPj4gICBhbWRncHVfaXJxX3B1dChhZGV2LCByaW5nLT5mZW5jZV9kcnYu
aXJxX3NyYywNCj4+ICAgICAgICAgIHJpbmctPmZlbmNlX2Rydi5pcnFfdHlwZSk7DQo+PiAtaWYg
KCFyaW5nLT5ub19zY2hlZHVsZXIpDQo+PiAtZHJtX3NjaGVkX2ZpbmkoJnJpbmctPnNjaGVkKTsN
Cj4+ICsNCj4+ICAgZGVsX3RpbWVyX3N5bmMoJnJpbmctPmZlbmNlX2Rydi5mYWxsYmFja190aW1l
cik7DQo+PiAgIGZvciAoaiA9IDA7IGogPD0gcmluZy0+ZmVuY2VfZHJ2Lm51bV9mZW5jZXNfbWFz
azsgKytqKQ0KPj4gICBkbWFfZmVuY2VfcHV0KHJpbmctPmZlbmNlX2Rydi5mZW5jZXNbal0pOw0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmMN
Cj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuYw0KPj4gaW5kZXgg
MjM4MjNhNTczNzRmLi5mMWVkZTRiNDNkMDcgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ2FydC5jDQo+PiBAQCAtMjAyLDYgKzIwMiw3IEBAIHZvaWQgYW1kZ3B1
X2dhcnRfdGFibGVfdnJhbV9mcmVlKHN0cnVjdA0KPmFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+PiAg
IHJldHVybjsNCj4+ICAgfQ0KPj4gICBhbWRncHVfYm9fdW5yZWYoJmFkZXYtPmdhcnQuYm8pOw0K
Pj4gK2FkZXYtPmdhcnQucHRyID0gTlVMTDsNCj4+ICAgfQ0KPj4NCj4+ICAgLyoNCg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
