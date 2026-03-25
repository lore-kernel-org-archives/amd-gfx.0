Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03705FEA837
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 08:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9926710E824;
	Wed, 25 Mar 2026 08:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jYuIShUF";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012040.outbound.protection.outlook.com
 [40.93.195.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E15B10E828
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 08:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgtmlHGrXirH6DozHCupOb/uA4UMQKCgL0i3udcKsfWoFX3dlKTPDShpUMM4jT8REa1Ui32q3PY96S+D7d/uRGhlFEeL0zDLqOIFzCw0qkWODJN06eIhrOrfWac5Qf0EGmxGvdr0vZR9YVqRwPhpwC/qB6rjGLA/S2udL4r6x5w0IZ2XxXbyxCL24YPx6I3rfTRUx3KiVKowAjZ8xyhDtOmLP1XIW8BkBa6FVXsJfSK3NR1eIIHriF1gNJKzgT1jK+WXWv9VJOjfOTuREjzqPtM0EmjeEhEgqaQPI0uNHxVmcbJkK4zc+7A+LaLgO38R96g2PXeNEFMqj2f6Nro6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/t/L7ThzFx3lKlRSN0rqjkIiNkpdlVEX9azoG2jLvuU=;
 b=GH9KFT/5mktvPgaAcappp7+xqNEgg97uq0l/AUCIwFp7jmDWaJp70PjingZ3AjhwtGFeXixHWsmJLTUmic8ZwQXTHrcljzMS5qOes63G3MoB+sLLthWE+IsCkOGyVigSMTdcbviJizGJ+SPQit/qt5v5ki1viz6sJO0UHbAzyr14936jgx9yp9bk4kT4pQ2Yhoavrk/X0v8seqGZAXmfPZ8yMUDlxMWO5KbcYSBQKKZ9gagpEfMJQOzyC1Af43k61S81m7pAvb7L56SyLkJ06L7BWy1QgUJ2MseAxSGLJSsqF1Hi1UVq3977KU6L/V1Gf1gez4Cf4oqD7Z+li5a2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/t/L7ThzFx3lKlRSN0rqjkIiNkpdlVEX9azoG2jLvuU=;
 b=jYuIShUFT4MVVauEd1FbCM/eC1os7dtI8tTFQe1S7yauBFiWg+xy/uSS7/I4wgWYHvlNL2IUFphO/tb837cjiOVIFvqcPzYtMHhd2p3n4htnaYYqdT7NMHpjeiBoCzDzTghoh70m1MfUlwS7/qAve+gPNfKWzpwXTOJQC1jts9g=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by SA1PR12MB7175.namprd12.prod.outlook.com (2603:10b6:806:2b2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 08:56:48 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 08:56:48 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: validate SIGNAL/WAIT ioctl input argument
Thread-Topic: [PATCH] drm/amdgpu: validate SIGNAL/WAIT ioctl input argument
Thread-Index: AQHcunVvqVksCE2yR0qTWwFJstpeuLW9sfSwgAAI7gCAATfz4A==
Date: Wed, 25 Mar 2026 08:56:47 +0000
Message-ID: <PH7PR12MB600043837CC7A1E641E04380FB49A@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260323033023.3338683-1-Prike.Liang@amd.com>
 <PH7PR12MB600006CE3FC81B5FF6985A87FB48A@PH7PR12MB6000.namprd12.prod.outlook.com>
 <a089317c-cf9a-469f-a8d1-2aca8769d56e@amd.com>
In-Reply-To: <a089317c-cf9a-469f-a8d1-2aca8769d56e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-25T08:46:38.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|SA1PR12MB7175:EE_
x-ms-office365-filtering-correlation-id: 3df44ac1-0cd6-46ef-dbb6-08de8a4c729c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|56012099003|22082099003|7053199007;
x-microsoft-antispam-message-info: x/4IQPmNtMHMW7jTsdDRFHV0kTMZ9rtlJfsslhvkOGGixpWUyFcb5GTawPpsyn2dILKhKze0SvWKiSuRiFLdgHZTxqoRRqLJzZyn3EtSa6wwmnzyYBMxpkJUTvoHnD5b9UnDe9TUWDDo3wxNq9nWIcTWsgutWTGtf6gXw3f/ZyLYiopBvo/9VD0P3m50WPg4QGisQ4cr6TP6a5cBJrm9BhzOiJjIf3tRatZAzYqO61R3hJjzqffw9bdgLGk/mBp+w2O+JobWVoluSg7mTP+tRLPe0IZkHfe3ZWO/OL5uLIgoTcM1uGaNcfDUfpmsBVETSNIEZQGK+IC31vSyD3zvNYWpll40LQ3RGGx4eI9DLc00g7QFMPZ6ofWfYeGcvHXlGrWIgf1tiS5K0yFy48vpVKgYiqdsJk41ui7S9deazKdslgk+5BHXe10e3PyCU5/p/5nrefVneJuP1Hr49eCrjkNt4zWctaXrihC5TvhKwY0zz8MFjJI4JWceX5F+/HUVjOagXKPg2g87thKKGwxVj6Wfhj1/NFyfDq1gUPWOo/dQg34u9QRjgEFo5acWXFsUPrwobohcdfE0CdR1Q0jdibBtN/r+HySq1zuHf7vasusltv4841coVWEWP5lL7ni0sWtQ40jteyJqut03V/BxR/bzNEdZUaQMJpm3O94+L5Ds7a4VmN8IiYM/54HL/eIGIuwULP6Q7xOvvxn0LP0i7g061f7DzrOn6vVQgswEyQ0wfErQHCFrN/z/IdYH5izV8W1wJApaD5OV1+E29GgZMBsY2i+0l6kqKUSOOpwLxAQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVowMVpKNHdJQWpESzBuTTJDT0hZU2Vtc01ITSs4eitPbmVEMDQ2YXBGSllS?=
 =?utf-8?B?RzZNeFM3RmJReWZ3STJCUVVJOCtrUEZ2V1RzeGtUSmJrenRkY1FPNk5LQUNh?=
 =?utf-8?B?T2h3NUpwMER6TUl2WVlKby9DUmFxNmY0MWZiT2hXS3R0SkxzcktiME1ZdWZ4?=
 =?utf-8?B?WmVhejZLQ1dLNWhpQ2hnMWNsNmc0a2VmV294b2k0WXcrQ2hwNmFQYU9IQ0w4?=
 =?utf-8?B?U0g1THMva0RUakY4enhjNjltSTRzZENuOFlIUU52RVRXQXVIZmVSdndrYk84?=
 =?utf-8?B?bzVwOTgxZVFoalFOTHVRcmVZWWYwUVVaVWZyOXpsbmhDZlhRMkk5cFdxSjAv?=
 =?utf-8?B?b2YrbExKdFRkRnRjRVhiN2JVdWo3TXNhZjFyMkhGVi9QV0hDbG90b1Z3NER5?=
 =?utf-8?B?QVRHd0MxWlAzUWZoVm1wSG1wWjVnSU5zRXEyM1E5aDNlZWdJb3BVdTV6YUx5?=
 =?utf-8?B?aWhLQmVwOHhIbEpBSkxsN0lmZ1A3VXdMYUNmQkU3ZXZFNU52bGZmRUdIQWs1?=
 =?utf-8?B?bTBjYWY5MlZ5OStKOTF2aUc5TmFmYlRIL3FoSm9ac2pub0dqamdaVjFWS29U?=
 =?utf-8?B?dUw3WXJyN0lJQnRYYkJ0T0FJSGRMek80bWQ2ZTRCQkJhaFF0aEdXem1jTW16?=
 =?utf-8?B?elNIUUoxRWpDb0wxMWY4QjliQkJIYU1Vc01ETDV6S0ZsSUMzTlFUNE1HRGNJ?=
 =?utf-8?B?WGpzZlZaTVJSdTNwRmQ5NGVPSitvNEltdFkxdXlSZkRub1prV0NmTHRneVc5?=
 =?utf-8?B?MWtsLzdoOUhrak9tbnlBb2lkTFFpODZXSTBFRmJwVjdGNXpScDJiMzF1U0lR?=
 =?utf-8?B?RkVRbHhPWWllZUxEbFkxSWdSanF6ZGpmajREUUVIc04xSVZkS0hSU1dGaU1X?=
 =?utf-8?B?TEM1NFNLYmFvY0xlNlp1STdmK0pERDJ4cVNndWtQcHR1cG8wWjF4N0lNTnEv?=
 =?utf-8?B?MkFSYmY0Ykx3NDQyWjl0R1ZsT0xobUc2WnJEZklsS2c3dloyMjVRRlFxdXNK?=
 =?utf-8?B?djFTVkJyTXlrbHVEdndzL005RTJnK0xWdmhydXd6WmJheGVoUVlkYzdVT0ZS?=
 =?utf-8?B?RVU5bzF5Tk5sYVA1cnZudjVNeEFXczNZVDFvN1FmdEdzQm8wbUZ1THI4dEdr?=
 =?utf-8?B?YndsbzVjVUg4eWxzcTVMc0FVV3NFcFlDQ1V5TXFrdk5vZlNQejR5QUYxdEc5?=
 =?utf-8?B?L0R5ZndtWGNRNG1jV05MS0IzOGxFV29McHNtSlh0RmhDOWg3OGI1dVE5dFV4?=
 =?utf-8?B?b1U4emJFQkV0YTh3d3BvekpWVGpZbDFBRE5hWFAzODRtZm1kMEY5Q1J0U0dW?=
 =?utf-8?B?U0N3NXJ6b0gzQTBORzVyT0lUNGh6Vlcxa05MbmdpdmVKdGYzRmxyMFkwWHZa?=
 =?utf-8?B?QVQ0ZUxBNXRvQTdRVSttamszU1FYK0tJbE01dE5XV1VkUGhkS2J1aXRqY3Jo?=
 =?utf-8?B?cDJLSHFzOXM3emxESzN6eGJRM3Z6RHZWY0JVM1lWRjVFTWRiMk4vYWFENFdM?=
 =?utf-8?B?QzZ6b2NSeDkvNm1nMnk0UldHQittdC82VlEzRW9RajBidFpmbkVTSTJmTzkv?=
 =?utf-8?B?d3FuNGNCTG1mNTlGMlFJOTRLNnY4amlrRkRtWklVUnBYUys1eDhVOEZIWG1k?=
 =?utf-8?B?U3JzSGRvR0lXa1JVMmhpd1dzNVNOait5YzNxbjdRbHZGdWJudlpNTUpZMFZU?=
 =?utf-8?B?VU5WOXhnU1lJYndKNEtnVGtCY3ZqOTVnY2RseHE1L1NFRURBVlBBWW93UlVu?=
 =?utf-8?B?WkhCL1o4RU1wdTNWWEZ2UFRNVWgybkhBVm4wR1AwZ1JTTFdoV2loNjhiejRE?=
 =?utf-8?B?aWp0MEs4K09JeWJKUmlBLzN3d3RnaGhUc3c0RWxXUkJVSWd3cGFEVTBrR284?=
 =?utf-8?B?UVE4T0x1S2MrQTNUaVJ2Q0M1dENFMzJ4a3JZQml0emUvMjFCL0ZxNi94WXZL?=
 =?utf-8?B?bXd4Y1g5aVhZZ2ZPUmp4YVFEcmRFM2NwQWhkY2E1eFk0S2w0K0FzckErc2Q5?=
 =?utf-8?B?NmxscGtRQ2VLUWQ2TERVWU9jYTUrQVl1a2x1Q05nMExRM2dGdWtFMG9oMDNW?=
 =?utf-8?B?amFQTEF3ZWM5amZ0Y3pnbU50NXptMTJ3M0E4MG9mOFk2a3BuYnYzYmJKSW1W?=
 =?utf-8?B?aWJGdit4UXhQZDRJM3VvTHU1QXZJMjRyVFBid1podGNUWGxsTFNQR1JIbmNq?=
 =?utf-8?B?TmFEN3E3aHpHTjNxZ0NjN1p6UHpKa0hKMi9qYlJvQjRySXR1Ukl4eDc1OXRu?=
 =?utf-8?B?cnprY2E3aVo5eUM2TVdFY2F0N1ZPazhjbmxFeEI0NjJYY1hWWlBTK2w1aWVl?=
 =?utf-8?Q?JqXBhCjxxWamYAfdqO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df44ac1-0cd6-46ef-dbb6-08de8a4c729c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 08:56:47.7542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /JL7fKhODUaZ/gsf+9etLqv6fU99J43MTevFtvohd9C/2r0OvN2bLXrODM49zkae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7175
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KWWVzLCB3ZSBzdGlsbCBuZWVkIE1lc2EgdG8gaGFuZGxlIHRoZSB1c2VycSBz
eW5jIGhhbmRsZSBjb3VudCAgKG51bV9zeW5jb2JqX2hhbmRsZXMgPSAwKSBhbGxvY2F0aW9uIGNv
cnJlY3RseSBiZWZvcmUgdGhlIGtlcm5lbCBjYW4gc2FmZWx5IGZpbHRlciBvdXQgaW52YWxpZCAq
X251bWJlciA9IDAgY2FzZXMuIFRoZSBjaGFuZ2UgYmVsb3cgaXMgYWltZWQgYXQgZmlsdGVyaW5n
IG91dCBpbnZhbGlkIGhhbmRsZSBjYXNlcyBvbiB0aGUga2VybmVsIHNpZGUsIHdoaWNoIGhlbHBz
IHJlamVjdCBib2d1cyBoYW5kbGVzIHdpdGhvdXQgYnJlYWtpbmcgdGhlIGV4aXN0aW5nIHVzZXJx
IGZlbmNlIHNpZ25hbC93YWl0IElPQ1RMIGJlaGF2aW9yLCBhcyBJ4oCZdmUgdGVzdGVkLg0KDQpS
ZWdhcmRzLA0KICAgICAgUHJpa2UNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBNYXJjaCAyNCwgMjAyNiAxMDoxMCBQTQ0KPiBUbzogTGlhbmcsIFByaWtlIDxQ
cmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6
IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogdmFsaWRhdGUgU0lHTkFML1dBSVQgaW9jdGwgaW5w
dXQgYXJndW1lbnQNCj4NCj4gSSBkb24ndCB0aGluayB3ZSBjYW4gZG8gdGhpcyByaWdodCBrbm93
LiBVc2VycXVldWVzIGlzIHN0aWxsIGEgYmV0YSBmZWF0dXJlLCBidXQgdGhhdA0KPiB3b3VsZCBi
cmVhayBleGlzdGluZyBNZXNhIHJlbGVhc2VzLg0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4u
DQo+DQo+IE9uIDMvMjQvMjYgMTQ6NDAsIExpYW5nLCBQcmlrZSB3cm90ZToNCj4gPiBbUHVibGlj
XQ0KPiA+DQo+ID4gSXQncyBub3QgdG9vIG11Y2ggY2hhbmdlLCBzbyBwaW5nPw0KPiA+DQo+ID4g
UmVnYXJkcywNCj4gPiAgICAgICBQcmlrZQ0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4+IEZyb206IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4g
Pj4gU2VudDogTW9uZGF5LCBNYXJjaCAyMywgMjAyNiAxMTozMCBBTQ0KPiA+PiBUbzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+ID4+IDxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+OyBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+
ID4+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogdmFsaWRhdGUgU0lHTkFML1dBSVQgaW9j
dGwgaW5wdXQNCj4gPj4gYXJndW1lbnQNCj4gPj4NCj4gPj4gRmlsdGVyIG91dCB0aGUgaW52YWxp
ZCB1c2VycSBlbWl0IGFuZCB3YWl0IGlvY3RsIGlucHV0IGFyZ3VtZW50cy4NCj4gPj4NCj4gPj4g
U2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4+IC0t
LQ0KPiA+PiAgLi4uL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVuY2UuYyAgIHwg
MjcgKysrKysrKysrKysrKysrKysrKw0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlv
bnMoKykNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCj4gPj4gaW5kZXggZjkzZGE0NWNmYTdlLi43YjI3MDBhMGMw
YWQgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91
c2VycV9mZW5jZS5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV91c2VycV9mZW5jZS5jDQo+ID4+IEBAIC00ODMsNiArNDgzLDE3IEBAIGludCBhbWRncHVfdXNl
cnFfc2lnbmFsX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlDQo+ID4+ICpkZXYsIHZvaWQgKmRhdGEs
DQo+ID4+ICAgICAgIGlmIChhcmdzLT5udW1fYm9fd3JpdGVfaGFuZGxlcyA+IEFNREdQVV9VU0VS
UV9NQVhfSEFORExFUyB8fA0KPiA+PiAgICAgICAgICAgYXJncy0+bnVtX2JvX3JlYWRfaGFuZGxl
cyA+IEFNREdQVV9VU0VSUV9NQVhfSEFORExFUykNCj4gPj4gICAgICAgICAgICAgICByZXR1cm4g
LUVJTlZBTDsNCj4gPj4gKyAgICAgLyogQWZ0ZXIgdGhlIG1lc2EgYWxsb2NhdGVzIHRoZSBpbnB1
dCBvYmogcHJvcGVybHksIHRoZW4gdGhlcmUNCj4gPj4gKyAgICAgICogYWxzbyByZXF1aXJlcyBm
aWx0ZXJpbmcgb3V0IHRoZSBpbnZhbGlkIG9iaiBudW1iZXIuDQo+ID4+ICsgICAgICAqLw0KPiA+
PiArICAgICBpZiAoYXJncy0+bnVtX3N5bmNvYmpfaGFuZGxlcyAmJiAhYXJncy0+c3luY29ial9o
YW5kbGVzKQ0KPiA+PiArICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+PiArDQo+ID4+
ICsgICAgIGlmIChhcmdzLT5udW1fYm9fcmVhZF9oYW5kbGVzICYmICFhcmdzLT5ib19yZWFkX2hh
bmRsZXMpDQo+ID4+ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4+ICsNCj4gPj4g
KyAgICAgaWYgKGFyZ3MtPm51bV9ib193cml0ZV9oYW5kbGVzICYmICFhcmdzLT5ib193cml0ZV9o
YW5kbGVzKQ0KPiA+PiArICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+Pg0KPiA+PiAg
ICAgICBudW1fc3luY29ial9oYW5kbGVzID0gYXJncy0+bnVtX3N5bmNvYmpfaGFuZGxlczsNCj4g
Pj4gICAgICAgc3luY29ial9oYW5kbGVzID0gbWVtZHVwX2FycmF5X3VzZXIodTY0X3RvX3VzZXJf
cHRyKGFyZ3MtDQo+ID4+PiBzeW5jb2JqX2hhbmRsZXMpLA0KPiA+PiBAQCAtOTQ2LDYgKzk1Nywy
MiBAQCBpbnQgYW1kZ3B1X3VzZXJxX3dhaXRfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UNCj4gPj4g
KmRldiwgdm9pZCAqZGF0YSwNCj4gPj4gICAgICAgICAgIHdhaXRfaW5mby0+bnVtX2JvX3JlYWRf
aGFuZGxlcyA+DQo+ID4+IEFNREdQVV9VU0VSUV9NQVhfSEFORExFUykNCj4gPj4gICAgICAgICAg
ICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPj4NCj4gPj4gKyAgICAgaWYgKHdhaXRfaW5mby0+bnVt
X3N5bmNvYmpfaGFuZGxlcyAmJiAhd2FpdF9pbmZvLT5zeW5jb2JqX2hhbmRsZXMpDQo+ID4+ICsg
ICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4+ICsNCj4gPj4gKyAgICAgaWYgKHdhaXRf
aW5mby0+bnVtX3N5bmNvYmpfdGltZWxpbmVfaGFuZGxlcyAmJg0KPiA+PiArICAgICAgICAgISh3
YWl0X2luZm8tPnN5bmNvYmpfdGltZWxpbmVfaGFuZGxlcyB8fCB3YWl0X2luZm8tDQo+ID4+PiBz
eW5jb2JqX3RpbWVsaW5lX3BvaW50cykpDQo+ID4+ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7DQo+ID4+ICsNCj4gPj4gKyAgICAgaWYgKHdhaXRfaW5mby0+bnVtX2JvX3JlYWRfaGFuZGxl
cyAmJiAhd2FpdF9pbmZvLT5ib19yZWFkX2hhbmRsZXMpDQo+ID4+ICsgICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQo+ID4+ICsNCj4gPj4gKyAgICAgaWYgKHdhaXRfaW5mby0+bnVtX2JvX3dy
aXRlX2hhbmRsZXMgJiYgIXdhaXRfaW5mby0+Ym9fd3JpdGVfaGFuZGxlcykNCj4gPj4gKyAgICAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPj4gKw0KPiA+PiArICAgICBpZiAoIXdhaXRfaW5m
by0+bnVtX2ZlbmNlcyAmJiB3YWl0X2luZm8tPm91dF9mZW5jZXMpDQo+ID4+ICsgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4+ICsNCj4gPj4gICAgICAgbnVtX3N5bmNvYmogPSB3YWl0
X2luZm8tPm51bV9zeW5jb2JqX2hhbmRsZXM7DQo+ID4+ICAgICAgIHB0ciA9IHU2NF90b191c2Vy
X3B0cih3YWl0X2luZm8tPnN5bmNvYmpfaGFuZGxlcyk7DQo+ID4+ICAgICAgIHN5bmNvYmpfaGFu
ZGxlcyA9IG1lbWR1cF9hcnJheV91c2VyKHB0ciwgbnVtX3N5bmNvYmosDQo+ID4+IHNpemVvZih1
MzIpKTsNCj4gPj4gLS0NCj4gPj4gMi4zNC4xDQo+ID4NCg0K
