Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E33C4706C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jan 2024 07:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EAE810EA4B;
	Fri, 12 Jan 2024 07:39:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A113C10EA4B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jan 2024 07:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jutYCK6/cFL+dGK2ZKpYdG5uXua3AiF52DupB8FXVSnhmEQoiO5N5OawFe4aK4R5R/ryBC9L8QH+ksmqpDOGS55iqQ9i406nA6ndEfWXftWahmz0Rz54hLSGItvPQpMVAhlJoQzchCFE1tVLry8PG7Ew7eFlUSnpppqpmdhlP34w8kDQyhfQIKw+m/z/lROs4agAj6WljwQmc/JuMKcP3FxV209br8f9EaIiSx08H8i8r1HQMpmQ5dMFmuY1kKJBVs/7D1l3kI0rs6grX+AutxDTYQBZWxG4AM5W5LVdlkBC16oahkBCl9iYyhyJPjD1O445pK8VcoX8Xy96HyQovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1AEAhH/EuBHgKp0OsB9oXY3vTf2yYLazqfHG53vcAg=;
 b=LSteFeYepeV72rtn5DMnP2i0UsaHrNUzBB8DhYQ2Mb4wfi4oEUQGCn6BfL9QkhwB+E24grHJgnzk9Hr0lWM2pmHXBljAqsJeEm1XrVCaL82PEg/mATUnGwFN4aF4olLy2a7uud1l+JB6SUP8xJe/PIsZzeoocQW5xrcPYrsBMskEtzHryjGvyYH0GxSR9Y0yBsl5RQTb84l10D8+UlXqNLQLqWe1RRXpmFuzdoihlxE0MZIvQyuiQRr1hAwOM7PeNJNJYug75Yf5DxXH7X5ULJWipNrIVrH8FBpWwBzO++yjoOwfst1v8w493fjCab4ja+z0ZxVw/YxGpBwpeS1eEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1AEAhH/EuBHgKp0OsB9oXY3vTf2yYLazqfHG53vcAg=;
 b=ZIuR1aUDOJiZyV4DCMpaTA8G5EGhsglvbOVYMOPAebT0Ikdf3ZxJAxi7xr/l+gwcBX3ms7n9F0ica0+67diRidNX4BPfnAf/8E/EVPt+iIXcITibANVXny4QJE1HnXZZswt7SY0v8buuRUmZznglcwACRdXkWhiGeWmoMuxNhiE=
Received: from CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 07:39:47 +0000
Received: from CH3PR12MB8902.namprd12.prod.outlook.com
 ([fe80::7d5b:f9e:d917:de79]) by CH3PR12MB8902.namprd12.prod.outlook.com
 ([fe80::7d5b:f9e:d917:de79%4]) with mapi id 15.20.7159.020; Fri, 12 Jan 2024
 07:39:47 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Francis,
 David" <David.Francis@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdkfd: reserve the BO before validating it
Thread-Topic: [PATCH] drm/amdkfd: reserve the BO before validating it
Thread-Index: AQHaRF77NJK4kDw6jki8P7DPYsq+jLDUyyMAgAD/dLA=
Date: Fri, 12 Jan 2024 07:39:47 +0000
Message-ID: <CH3PR12MB89023E46F7F223472655ED00FB6F2@CH3PR12MB8902.namprd12.prod.outlook.com>
References: <20240111072221.90774-1-Lang.Yu@amd.com>
 <d111de60-8bc9-4fd8-aca7-6c539362d9d9@amd.com>
In-Reply-To: <d111de60-8bc9-4fd8-aca7-6c539362d9d9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c8b939c7-dab4-455c-8c9d-ab2a30489f1f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-12T07:39:42Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8902:EE_|DM4PR12MB7599:EE_
x-ms-office365-filtering-correlation-id: c1134513-ff9c-4ac6-832b-08dc1341a70a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3orfh0fkSO+fQ9TNUcftZ/6bfBHwv34dmQTGmGm1ZfSA0do9ItUbee2sHje0coKM6AWlhMgvTjPLpyd6Xbk/Et4jvidHYuh92PerGoCU5DfmYpQ0cI3cNZhT3v1lUwFpjIbasm4exDQxBpr0sJdFnc9pg8r9NNl3qZtjQ+m4JiNtnwrclXeacNclf8XXFg8zJo8t9ZckfYqUVlL8Ct8YaGXa+NGzywC4pR64+RuUbk23BVgv5DlHwiMPM5iMxwAdgosxOP+DYB5Fl2k+v6JLesTZuyGYnGF5oPEtfe2Gbq7EHEr0xIlKLiFY2cepZYLtMmmU5UvZr4Slxn5ZfBLpTrkSMceDB9Qn/dK+HrkZbZSYd02BJyPdXYfth+eM8G8vw0qybNvTFQqE2zIukv+HIhqnRAY9BNtvzmR8Ax7NHQl8yLbvFJ3iqeKrb+PurEG2bSd4CAhpRXYNMkKJEKH8oHO0TAgRNjx4ylShn502pLVcP0fM7De/3GpT7AFoknSnSxdq8HmqABPwj//SqBnlPZr0BW4gV5NOrFXWrA/swp6hffkc+X7U+a/qv+w/9xth6P3TNstxvxE+DJq1WvdIANzuLEBjEzgDQ2BIzeAj+pHWEWVhCMwJdqdIIMoN0SRyX5P2opfcI+Zi1yfTewmvnA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8902.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(122000001)(83380400001)(71200400001)(26005)(316002)(38100700002)(52536014)(6636002)(110136005)(66446008)(64756008)(9686003)(66556008)(76116006)(66476007)(5660300002)(4326008)(8936002)(8676002)(7696005)(86362001)(478600001)(41300700001)(2906002)(33656002)(66946007)(38070700009)(6506007)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWRUb2kwMm9ZK3dJRkxyOUgwSVVXS0ZQbGVQb3BFRDdBekdIMExVNHJVOEw5?=
 =?utf-8?B?cVFGdUFOeVdPT3c2dG1pc0ptbWJKL2xsNkNsVi9SOTRsUDZXT2xXK2t4L0lM?=
 =?utf-8?B?Z0E5M0hZUXhyc3NoY0hkeFNqVjUxTWptazBvSXZKS21LaHRiMmRsVlpLK1VW?=
 =?utf-8?B?U1FlNG9aOFV0RzVkT3VvZjI2VG5qRGV4czZvNFFMS0FQc1NpcEd1T0dlcUNN?=
 =?utf-8?B?YzlYMlo3a3VRRkd6OFVtMmM4NkEyOUpuRkNWVWFuZWRWNHJoZEQ1L0tBOG53?=
 =?utf-8?B?dHF0cGl4M21URW9vZmhRMmJPNFVURU5mNUZKRHdJL2RkeERxaUVsbUdlU1lq?=
 =?utf-8?B?cFUvZEREaUNjaGJ3UnJaOWN4elhPU21sYkZwdTBLQ0ZsVjJJMzJpYjlLWXNx?=
 =?utf-8?B?Q0pDb3ZLRVhVaDFqRWZxckFnZGhldmdMT3l6MVQwT0ZZeUZlakhMR3BqZWJX?=
 =?utf-8?B?VUJLZ3J2K0RpcjFnOHlXS003TmV6T2t0Q1ZjeFZRVFhTL0dSd3FkYVNlWmhq?=
 =?utf-8?B?SjFsMnk1WG9RQTVLWjJ1SFRUaXpXT1V4d0VDNnhiZ0tTWEFWaVJidUJ5SzlX?=
 =?utf-8?B?VDUvc0FFc3doekpMY0ZKU2dZaWU4cXlNYjNkQVlQQ2VaOFVZMm5RWUI1MG1D?=
 =?utf-8?B?M3BlaW9IYWpoOUR4R3VrZk9mRW5pamRibi9qVnl1eXA1SnBmNnNFRitKQUJH?=
 =?utf-8?B?TWMxUUNyeUh3aXVRK1lNSW55VGtLZWF1WEk5VGtuL0hvTGFUN0gzZmpRNy9z?=
 =?utf-8?B?UmROVjR1MlVFem0rZ295NWM1ZEVSWGxjZGlMRmFQVDNpMkxzUWhzbjhaUUlS?=
 =?utf-8?B?cDVnb1h6K3ZaTHl3RmY5VXBodnNlL0REOTJDNnkveVY3cFM4NFVLcGM1TUp4?=
 =?utf-8?B?QW1aVWhmYTN6TC80STJQaUVoc0doNTRJSy80SjdBR0NqcXNhSWxJeXFlQzIx?=
 =?utf-8?B?RVA5ZFU5bmJoSjdxeGJMeVltMCtNSWkwQ09RNGZHUElEZk1DUGR3Sm93ZG5I?=
 =?utf-8?B?MU4vWUhqS21NdFNaMGIyVGlHcUdsaS8wb1lSZ1o2YWw0UGtLV2pOSFlxT0lU?=
 =?utf-8?B?K3c4Q25nb0t1YTlNM3J6alVZOG9zMit1RWhOMmppU1hoVURnbys0a3E5bTh6?=
 =?utf-8?B?YnozTjhUSGNUem9qTzFpYnNmazdtVUFUb1RYbU00NS9wWG5Id1lHWVl1dnVi?=
 =?utf-8?B?YkpxVGphTmxqQjFWUDhBVjUvSGpwWVovbXlEUVZZTTNyNkhLa2ZrbDNhMFpZ?=
 =?utf-8?B?bGUzNHloZXAxUVE1bzI0TnJtcEYwNmRFWkVlNjZNL3ZZZ0ExU3VvU2QreHRH?=
 =?utf-8?B?Y0QyUkNmSWZxRUEwMTBONWQyVFd4aklWbkhKZG8zK2x6K1VVd2NjRXZVczZp?=
 =?utf-8?B?aGFPdVJDRk13dFd6OFJSY0NTYXVnWkswbG0zYW5oN2ZpMU5lZzdMWFJGRjVD?=
 =?utf-8?B?SG05NkNGWWJHWDRHTXlpTXNSaHc2ZERSczg4RGMvWlFtQlA3aGI0TWJ2UTZn?=
 =?utf-8?B?QzNqUGl4VloxR1BtZkl1MWJQUWJqTzRldUNHQWFSd05ReEloYnQ4eUpPYXZq?=
 =?utf-8?B?NTg4VFN6bG1HSk9oaE9Pbmt6bjdQS3F5NlJBOEJucFYxZnhjL3ZDV09DQXJI?=
 =?utf-8?B?dkZpazVYTEQ0dmpuL2RrUFlqNzU4NlVjNlNjWWsvaTBtcWcxWTdnSVpOUFlX?=
 =?utf-8?B?NkNzQlRFaGcydFVZOTNZRXIvbjB1cU1Sa2E0cGk2RzdVUkdHcS9uaFZqY3Bt?=
 =?utf-8?B?MzNWSFZMNWFsRDNmYitGVFc4QW8xZHRwVWFrWjZqWDkxWXplcEROTTJHTDJk?=
 =?utf-8?B?VUVaenk3S2xvSGZIU2p2NXpaenR4Y1pmdnRPcFZGZnlWS3FrblMrUWNHdWdD?=
 =?utf-8?B?VU1KVVhPWjJXTVJTS043K3A2dS9KUGZZWFdRZHhaWkozR2E1Sm9hdnU0eXFw?=
 =?utf-8?B?TzRlR2loV2hNQ0ZCdEowL244UXlzN2dUdmdjUUpZemZrdXRiWjFJOUVBVEt0?=
 =?utf-8?B?TENYajJ3VEc2QTJMUDU2UWVSOHlrMGtMYUdoKzh5bFR4OHBEK3JITGlrRkt3?=
 =?utf-8?B?WGduUG1mSE44aGp6dmlETkNqbFpOZzhhMFhDM2FhT3YyMXRFNnFPV0UzYnF3?=
 =?utf-8?Q?fIKo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1134513-ff9c-4ac6-832b-08dc1341a70a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 07:39:47.5659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvJeoRs00c4EXVInE6OtGodw+RrSbPWZZRmQf4mNPUq9eHK6bWaEVRS1qkbpfb6NvtFvT+I8/aanGzuQwewCyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogS3VlaGxpbmcs
IEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPlNlbnQ6IEZyaWRheSwgSmFudWFyeSAx
MiwgMjAyNCAxMjoxOSBBTQ0KPlRvOiBZdSwgTGFuZyA8TGFuZy5ZdUBhbWQuY29tPjsgYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEZyYW5jaXMsIERhdmlkDQo+PERhdmlkLkZyYW5jaXNA
YW1kLmNvbT4NCj5DYzogWWFuZywgUGhpbGlwIDxQaGlsaXAuWWFuZ0BhbWQuY29tPg0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IHJlc2VydmUgdGhlIEJPIGJlZm9yZSB2YWxpZGF0
aW5nIGl0DQo+DQo+T24gMjAyNC0wMS0xMSAwMjoyMiwgTGFuZyBZdSB3cm90ZToNCj4+IEZpeGVz
OiA0MTBmMDg1MTZlMGYgKCJkcm0vYW1ka2ZkOiBNb3ZlIGRtYSB1bm1hcHBpbmcgYWZ0ZXIgVExC
IGZsdXNoIikNCj4+DQo+PiBbICAgNDEuNzA4NzExXSBXQVJOSU5HOiBDUFU6IDAgUElEOiAxNDYz
IGF0DQo+ZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYzo4NDYgdHRtX2JvX3ZhbGlkYXRlKzB4
MTQ2LzB4MWIwIFt0dG1dDQo+PiBbICAgNDEuNzA4OTg5XSBDYWxsIFRyYWNlOg0KPj4gWyAgIDQx
LjcwODk5Ml0gIDxUQVNLPg0KPj4gWyAgIDQxLjcwODk5Nl0gID8gc2hvd19yZWdzKzB4NmMvMHg4
MA0KPj4gWyAgIDQxLjcwOTAwMF0gID8gdHRtX2JvX3ZhbGlkYXRlKzB4MTQ2LzB4MWIwIFt0dG1d
DQo+PiBbICAgNDEuNzA5MDA4XSAgPyBfX3dhcm4rMHg5My8weDE5MA0KPj4gWyAgIDQxLjcwOTAx
NF0gID8gdHRtX2JvX3ZhbGlkYXRlKzB4MTQ2LzB4MWIwIFt0dG1dDQo+PiBbICAgNDEuNzA5MDI0
XSAgPyByZXBvcnRfYnVnKzB4MWY5LzB4MjEwDQo+PiBbICAgNDEuNzA5MDM1XSAgPyBoYW5kbGVf
YnVnKzB4NDYvMHg4MA0KPj4gWyAgIDQxLjcwOTA0MV0gID8gZXhjX2ludmFsaWRfb3ArMHgxZC8w
eDgwDQo+PiBbICAgNDEuNzA5MDQ4XSAgPyBhc21fZXhjX2ludmFsaWRfb3ArMHgxZi8weDMwDQo+
PiBbICAgNDEuNzA5MDU3XSAgPyBhbWRncHVfYW1ka2ZkX2dwdXZtX2RtYXVubWFwX21lbSsweDJj
LzB4ODANCj5bYW1kZ3B1XQ0KPj4gWyAgIDQxLjcwOTE4NV0gID8gdHRtX2JvX3ZhbGlkYXRlKzB4
MTQ2LzB4MWIwIFt0dG1dDQo+PiBbICAgNDEuNzA5MTk3XSAgPyBhbWRncHVfYW1ka2ZkX2dwdXZt
X2RtYXVubWFwX21lbSsweDJjLzB4ODANCj5bYW1kZ3B1XQ0KPj4gWyAgIDQxLjcwOTMzN10gID8g
c3Jzb19hbGlhc19yZXR1cm5fdGh1bmsrMHg1LzB4N2YNCj4+IFsgICA0MS43MDkzNDZdICBrZmRf
bWVtX2RtYXVubWFwX2F0dGFjaG1lbnQrMHg5ZS8weDFlMCBbYW1kZ3B1XQ0KPj4gWyAgIDQxLjcw
OTQ2N10gIGFtZGdwdV9hbWRrZmRfZ3B1dm1fZG1hdW5tYXBfbWVtKzB4NTYvMHg4MA0KPlthbWRn
cHVdDQo+PiBbICAgNDEuNzA5NTg2XSAga2ZkX2lvY3RsX3VubWFwX21lbW9yeV9mcm9tX2dwdSsw
eDFiNy8weDMwMCBbYW1kZ3B1XQ0KPj4gWyAgIDQxLjcwOTcxMF0gIGtmZF9pb2N0bCsweDFlYy8w
eDY1MCBbYW1kZ3B1XQ0KPj4gWyAgIDQxLjcwOTgyMl0gID8gX19wZnhfa2ZkX2lvY3RsX3VubWFw
X21lbW9yeV9mcm9tX2dwdSsweDEwLzB4MTANCj5bYW1kZ3B1XQ0KPj4gWyAgIDQxLjcwOTk0NV0g
ID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsrMHg1LzB4N2YNCj4+IFsgICA0MS43MDk5NDldICA/
IHRvbW95b19maWxlX2lvY3RsKzB4MjAvMHgzMA0KPj4gWyAgIDQxLjcwOTk1OV0gIF9feDY0X3N5
c19pb2N0bCsweDljLzB4ZDANCj4+IFsgICA0MS43MDk5NjddICBkb19zeXNjYWxsXzY0KzB4M2Yv
MHg5MA0KPj4gWyAgIDQxLjcwOTk3M10gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsw
eDZlLzB4ZDgNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMYW5nIFl1IDxMYW5nLll1QGFtZC5jb20+
DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9n
cHV2bS5jIHwgNyArKysrKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPj4gaW5kZXggNDg2OTdiNzg5MzQyLi5mNTU0MmE0
YWI4ZWQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
YW1ka2ZkX2dwdXZtLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYw0KPj4gQEAgLTIwOTUsOCArMjA5NSwxMyBAQCB2b2lkDQo+YW1kZ3B1
X2FtZGtmZF9ncHV2bV9kbWF1bm1hcF9tZW0oc3RydWN0IGtnZF9tZW0gKm1lbSwgdm9pZA0KPipk
cm1fcHJpdikNCj4+ICAgICAgbXV0ZXhfbG9jaygmbWVtLT5sb2NrKTsNCj4+DQo+PiAgICAgIGxp
c3RfZm9yX2VhY2hfZW50cnkoZW50cnksICZtZW0tPmF0dGFjaG1lbnRzLCBsaXN0KSB7DQo+PiAt
ICAgICAgICAgICAgaWYgKGVudHJ5LT5ib192YS0+YmFzZS52bSA9PSB2bSkNCj4+ICsgICAgICAg
ICAgICBpZiAoZW50cnktPmJvX3ZhLT5iYXNlLnZtICE9IHZtKQ0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgY29udGludWU7DQo+PiArDQo+PiArICAgICAgICAgICAgaWYgKCFXQVJOX09OKGFtZGdw
dV9ib19yZXNlcnZlKGVudHJ5LT5ib192YS0+YmFzZS5ibywNCj50cnVlKSkpIHsNCj4+ICAgICAg
ICAgICAgICAgICAgICAgIGtmZF9tZW1fZG1hdW5tYXBfYXR0YWNobWVudChtZW0sIGVudHJ5KTsN
Cj4+ICsgICAgICAgICAgICAgICAgICAgIGFtZGdwdV9ib191bnJlc2VydmUoZW50cnktPmJvX3Zh
LT5iYXNlLmJvKTsNCj4+ICsgICAgICAgICAgICB9DQo+DQo+SSdtIHByZXR0eSBzdXJlIHNvbWVv
bmUgZWxzZSB3b3JrZWQgb24gYSBmaXggZm9yIHRoaXMgYmVmb3JlLiBUaGlzIGlzIG5vdCBhIGdv
b2QNCj5zb2x1dGlvbi4gV2UgbmVlZCB0byBoYW5kbGUgZmFpbGVkIHJlc2VydmF0aW9ucyAoZHVl
IHRvDQo+RVJFU1RBUlRTWVMpIGFuZCBtYWtlIHN1cmUgdGhhdCB0aGUgdW5tYXAgaW9jdGwgY2Fu
IGJlIHJlc3RhcnRlZCBjb3JyZWN0bHkgaW4NCj50aGF0IGNhc2UuDQo+DQo+U2VlDQo+aHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYW1kLWdmeC81MzBhYWM1Ny01NTYxLTRkMWQtODc5YS0NCj45M2Ix
MDhlNWM4YzJAZ21haWwuY29tLw0KDQpHb3QgaXQuIFRoYW5rcy4NCg0KQ2hyaXN0aWFuJ3MgY29u
Y2VybiBpcw0KIktlcm5lbCBvcGVyYXRpb25zIHNob3VsZCBlaXRoZXIgY29tcGxldGVseSBmYWls
LCBmdWxseSBjb21wbGV0ZSBvcg0KZXhwbGljaXRseSByZXR1cm4gaG93IG11Y2ggdGhleSBjb21w
bGV0ZWQgKGUuZy4gaG93IG1hbnkgYnl0ZXMNCnRyYW5zZmVycmVkIGZvciBleGFtcGxlKS4gVGhh
dCB3ZSBvbmx5IHBhcnRpYWxseSBjb21wbGV0ZSBhbmQgdHJhY2sgdGhhdA0Kc3RhdGUgaW5zaWRl
IHRoZSBrZXJuZWwgaXMgdXN1YWxseSBhIG5vLWdvLiINCg0KRVJFU1RBUlRfUkVTVEFSVEJMT0NL
IGlzIGZvciBwYXJ0aWFsbHkgcmVzdGFydCBhbmQgbWF5IGhlbHAuDQoNClJlZ2FyZHMsDQpMYW5n
DQoNCj5EYXZpZCwgZG8geW91IGhhdmUgYW55IHVwZGF0ZSBvbiB0aGlzIHdvcms/DQo+DQo+UmVn
YXJkcywNCj4gICBGZWxpeA0KPg0KPg0KPj4gICAgICB9DQo+Pg0KPj4gICAgICBtdXRleF91bmxv
Y2soJm1lbS0+bG9jayk7DQo=
