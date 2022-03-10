Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE391C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 18:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D1210EC6A;
	Thu, 10 Mar 2022 18:15:19 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816D410EC68
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 18:15:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKJmPtXv8d7U9oBiiT5TusMnQ8yRMA7JN77GFLR9daVsT8kb91KYY1wyCfZBpY2A2VwcnWZzgClzP1vwIAQVK3biTh7wfvEFOYbNMMCi4YErbKTwTNwdWVPQJipxI6Gc33O4jNDznGoTplkaw286KaWtxpahi/dHUW9zEnySA2M61OZfdFMxYQcxXmsDSjPM7PA3OT7AwZe0pU13/nqBs4NrnNu6wO4Prn7t5z3qHsnShaOpNxt2Ew8GDnO8QLF9/o3RQVAcscTm/d4fyK+sBE2WR0M1kb78YKdpfJZe27CAkNOg556uQpxf+1smaA8tLk/aDD9J7Lkx4gN4+U6XrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o29IMr1V/l3/CtihRTrRkG03FkhFsqOBNtCT9ljLJKc=;
 b=Z2/CWfwbvRdS+sHbviZuANLdthjtmXNc0fJn7FmMroFU/pGAmfQriPiTgfAMRoiBdzpTEmrMi6EnMg96h1C2U6EHYiWjqDB5OwuFepBct1EU4XLR40gdp11ksOao/qUnecfWFs3AsFZUDXsQMPx7jY0g/OtGttcV4KzD0W13NqJpbX2eT9kemaImPXqg7zic4yisxfrliOdOEioLKKfrJp8AoxUTL3cdlsCvDaX4ZXXHyqBICuutCvk3M4hc0s6ocq5CZ0WzDLYHbHBWMol64OKNbMMWDTw7IG4RiytwTAMvohHjdDSp+BcOpdvwAtwvP9FvSrQve1D/rL/Md5kziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o29IMr1V/l3/CtihRTrRkG03FkhFsqOBNtCT9ljLJKc=;
 b=AkAyg+QbyDU3TaQ8QZZPq3fTuX/1HX20/ZxM24UTsBgh2d3irV5F2s6fviAnWUph8pKlH5nKkJ9vE0HOSH0K+qf7QQhYkQVB8jK9a4WI/Rb5hQOUnZdC0h2AukPkRSE9yjvwPWEXPvQ+KK3g/DbFuFqQL5LnAyeAAittkLWhQus=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM8PR12MB5495.namprd12.prod.outlook.com (2603:10b6:8:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 18:15:14 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 18:15:14 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu/pm: Don't show `smartshift_*_power` files for APUs
Thread-Topic: [PATCH] amdgpu/pm: Don't show `smartshift_*_power` files for APUs
Thread-Index: AQHYNAIsSNH0GGjFmEq3C0woGMafWay4F0IAgABiH4CAAHPGoA==
Date: Thu, 10 Mar 2022 18:15:14 +0000
Message-ID: <BL1PR12MB515733F013923BFE37DF412DE20B9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220309220548.2541074-1-mario.limonciello@amd.com>
 <237ec5cb-44e3-0f94-c439-9b6742e7740b@amd.com>
 <CY4PR12MB19436AA4A2EDF04562418F309D0B9@CY4PR12MB1943.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB19436AA4A2EDF04562418F309D0B9@CY4PR12MB1943.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-10T10:56:31Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7bee2aa0-f89b-457f-99da-f48f89ac040d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-10T18:15:12Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 2d7c3f96-1067-4ddb-a0e5-0604c30da57f
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 775c42eb-19ec-4a55-3f1c-08da02c1eca0
x-ms-traffictypediagnostic: DM8PR12MB5495:EE_
x-microsoft-antispam-prvs: <DM8PR12MB5495E8EF9362E4BF8C8B54D8E20B9@DM8PR12MB5495.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sOLA+lY2CIvhyx3GBwyNaLDQ5di7zWPmrFNNxd6eedOBfbZNMlH6eo5T7wB8FIYUGdgh/WK20cF+MqzZT5xpgrdQqMKQxPTjFAhB60XDfYRAXx8yVGcKdYTmO+2UvMR9lDkQzBvzur5zqs4z4nhsvIeD5WVC7wVInqtmKYA0M84YZZ8ddh4JN2+PCPQ5kebD4+5zycvCnhZwzNdw00TUSNxyD27pIGc7hGWCYIGZ2oRAtVMILxr3bW3ycH9lwF4O6wyYJH5UJfy0/4uSENXVlUcuLwgmza2NXB4gLn8wfywcSjRlmIyDvdKysiwGZ9EOs4b+5rHD144ePNMuKxTyEwRAhIbF9wpP+ApFsHmoFVVU8sMqvlZHVCGGgw2kPCsj6h0Q3R+c4Ra7z5myfs15q9JZ6n2oKosVWM+EeR3x/l/K2hOQu59MEBnnvVAG9+mFs2vKixr0JBDWx+pDxh9eLH6N4PfRsez9qX5MH4GXXVAP+JP2I4mH58TvPXufMCN5nJm2WsJ9nxSLw+7XcpjRuP75Kd0P8t9uZjUvHKZQ83WFhEYN+C8RjA6ch792a2xgM9svmbMcY4zp52AZLBS2rMYd1Z86x2b6OSmrbZN9rXGpDsTludpLOgJmmPxQYzBrmfeQ4p5MOsgtgQQA9A7g0U++srXhbp0xVX5LreJB5UN35EKFmMJ4EA/NhF4uG/9TwVu8kQQ+biV+EO4ZNWxS7U7mZJL4Sf50yH64xtgv9s4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(76116006)(66946007)(66556008)(66476007)(64756008)(7696005)(9686003)(6506007)(55016003)(71200400001)(38070700005)(83380400001)(33656002)(186003)(26005)(8676002)(8936002)(66446008)(2906002)(86362001)(53546011)(52536014)(316002)(110136005)(5660300002)(122000001)(38100700002)(81973001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnFHYm8yZlR2VEt4QVpUcW5CZjI1LzFndFNrQ0dXZzRldUI1Ry9DMk1CUU1s?=
 =?utf-8?B?dENPU0lrWTZ4N1VwVnJGcnFnbjljenZOckxwK3FsN09kL3NyMTU0OFhuREVk?=
 =?utf-8?B?bkx6SllQdUtKckcwdFRDVjRuQXRJcTd1NWh4cUI0Z0FsQkpmQ3k2QmhEWmEv?=
 =?utf-8?B?eCszczBqQ1dnSTN2WDZ1eGZsNk0vMHhRTWE2K3c3T0lLWjNtNXRuZDFaR21j?=
 =?utf-8?B?VndNQkNDOENYQWYxWnRMUUR1bEpBSlBUbTF0K1ZmV0NaZkdYV093V1RCUFdP?=
 =?utf-8?B?Y1l0OGM0eEl2UmZZL0F0NmQ3ekZzbVBXb0hYbUVHeXlXUU5XMXl3Y00zUXJx?=
 =?utf-8?B?cEVHY3FqdTRDb3pod0ZsUlJWSlZXQlJORDlBdW1VMmM5aGdMcGlzWkFuS0VU?=
 =?utf-8?B?VHFQdjdHYlEzcGRNQ0ROdzk3a2xHYWgxQWNOU2lySW94UTBOclFaZjJ5TnJ0?=
 =?utf-8?B?UnZST2N4a2U1MEl2V2pCL2VXMTFsZGdiYjlHcHZZcnVFNHpqZ2VSTlJqK0hR?=
 =?utf-8?B?OTVNYmhVUWVLNnR3SW5IR0p0M2lnL0dnSk9zTzZVallRUDRtTlBOcmNvOU51?=
 =?utf-8?B?WjRnbHgySWg1MjZ1YlI0QzFsL0xSV051Mk8zUW1rcy9DdyszRHNXNitEZGFl?=
 =?utf-8?B?UnBPN1ZnQndWL1c5aXZ3bm56M01Kejd2QTZLenZRSDZlakZOUnhVOFV4ZUNT?=
 =?utf-8?B?Vy9wdGNiQ0dLZVlSRDBJN3JkTE9XcHljeTRzblZhWVJzcE5ZK2tlWThud0pr?=
 =?utf-8?B?N1RNUnlNa1JCRm1ScFAxZS9pNGplUDkrZndkVDF3aDhDRVB4bURMZ0tsYnpl?=
 =?utf-8?B?TWE0TUlYbW9XYlF1ZUJTWm1kcHA5VmVTVUFUQ1N3ZlpLZ1dxVWVZVXVNTW5q?=
 =?utf-8?B?OFpTQTFreGRPbzZLQ2lPTXVrNkdGMEVtbm40V0xGdE1aNUJ5b3FWeitQdVZ5?=
 =?utf-8?B?ZCtsL3hSU0RPWmZJNTM2K0U0aE5XYWtLdWtvaG5oYU0yczRSMVNaM3JIS0xm?=
 =?utf-8?B?dTQvcTJ5OVJGb2xTTUJmWlZaL05YWFJNQ2VhU0JqQW9oYjN0OFU3VWNya0lY?=
 =?utf-8?B?aWVmcE9pWUZRSGhnUmVNVnFZQXgxNUg0eFNVTTBWa2xSRWVlQlNMOTJvTXBH?=
 =?utf-8?B?ck9QYXpla3Zvb3d0TWFGQlNEQkt0czd5a1dFVVBQRU1rWDVnK3lBUHhzU3kw?=
 =?utf-8?B?Qm83bTBaTE9sUTFJWWEyUDA1eFAxbHRGcWltano4QW9HV3BtRm5ZdUF2MjNZ?=
 =?utf-8?B?QVd2Z1FiSU9IdDQ4WGQ0V1NTRU5zYzYwRTZXdExuMjhMbTA5UWVmTG00V0NM?=
 =?utf-8?B?SnMvQWF4MFQ5Rzg1S0xreThTL3pxSys3dWxlRlh4UEs5eDVKK09EcTZaRDJP?=
 =?utf-8?B?aDdlNmh3TkhNN3R0UmdwbmNiVzc5U0NjMzlVdFNPdXVDLy9ZMkpWU0lLSlpq?=
 =?utf-8?B?UlNaWWhJVUpFcGFZT1RrNXpwRDZnRDN0UlFwcHdSSWtaNUNsZTEyeWV3VFF5?=
 =?utf-8?B?azhYcGROd0YydEdmMjBudVZJZ09WRGFjSEpCZDJKVk9tTmNNMEppbUF3VmdI?=
 =?utf-8?B?ZlY5Q0tkUXJER3pBcmlSN3lnSGtxbDJYK3hheXBOZGJIaFF4S3EySmRzZDRT?=
 =?utf-8?B?eVJQZnBkM3c0K0dzWU1JbjBUbENBbHVaZEJ2bWpyVzFrQ0FUN1daOWJsUjRN?=
 =?utf-8?B?SXNKSEJCbnhTVi9kZmlEYitzMXZaeE1HbXVKaklnWGk2TGgvZmh6YmtuNHgv?=
 =?utf-8?B?ZjVFd25tQ3dXTWV2RFhZTDR6dXpSWU0xUzJNUnVtcVdqeThjczVBOXFtUlBK?=
 =?utf-8?B?cGxSdG5ycW1YdEx6eXJGcGt4MkdUdDFiNmExWHc3RjhwSnZva2JDYlpLeUdD?=
 =?utf-8?B?WTUrOHlYaVBvRUtOYjQ2UVpoVjN4NjlzVTRxNmxGRjAwM09kNUtmNEp6eVNY?=
 =?utf-8?B?YTlyZUE2ZVFudklUSzZrWGRhTm9lVHNweUNnS1gvMjNLeU1KaUFnM21zMi95?=
 =?utf-8?B?SGJUSFZ3MUJEMVNnbVRKbHpISXhZclQ3VjRZNVNQVlErdXNrbWpxbDc1NThM?=
 =?utf-8?B?cGM4NmZBelVaek1VWk5mQTE2NHFLQ2RoWGNDSDhBZDRJeG5rb29CTENOdjUw?=
 =?utf-8?B?WGU4bS9NcTlKeThFckpHVFF5UmNUcW1tWjQ4aEwwVEE0N3lXdEtnUHhVVzB3?=
 =?utf-8?Q?Om6t8/glFBWpeo52ru9QaAA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775c42eb-19ec-4a55-3f1c-08da02c1eca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 18:15:14.7277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hKORUS/HvAnPR1mGW0Y08YEUTJYoVToZfsMKHhSd2aGU7stZ+/RcHZOh4QEpoIGhGb8DO6lNpFIqdUAR/kjPmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5495
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSSdtIG5vdCBmYW1pbGlhciB3aXRoIFNTIDEuMCBp
biB0aGlzIHJlZ2FyZCwgY2FuIHlvdSBleHBsYWluIHdoeSBpdCB3b3VsZCBmYWlsIHRvIG1ha2Ug
dGhlIGF0dHJpYnV0ZXM/DQpJIHdvdWxkIHRoaW5rIHRoZSBhdHRyaWJ1dGVzIHNob3VsZCBzaG93
IHVwIGJlY2F1c2Ugb2YgYW1kZ3B1X2RldmljZV9zdXBwb3J0c19zbWFydF9zaGlmdD8NCk9yIGFy
ZSB0aGUgY2hlY2tzIGRvbmUgaW4gdGhhdCBmdW5jdGlvbiBub3Qgc3VmZmljaWVudCBmb3IgU1Mg
MS4wPw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN1bmRhcmFyYWp1
LCBTYXRoaXNoa3VtYXIgPFNhdGhpc2hrdW1hci5TdW5kYXJhcmFqdUBhbWQuY29tPg0KPiBTZW50
OiBUaHVyc2RheSwgTWFyY2ggMTAsIDIwMjIgMDU6MTkNCj4gVG86IExhemFyLCBMaWpvIDxMaWpv
LkxhemFyQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPE1hcmlvLkxpbW9uY2llbGxv
QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSRTog
W1BBVENIXSBhbWRncHUvcG06IERvbid0IHNob3cgYHNtYXJ0c2hpZnRfKl9wb3dlcmAgZmlsZXMg
Zm9yDQo+IEFQVXMNCj4gDQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHldDQo+IA0KPiBUaGlzIHdp
bGwgZmFpbCB0byBjcmVhdGUgdGhlIHN5c2ZzIGF0dHJpYnV0ZXMgZm9yIFNTMS4wLg0KPiANCj4g
UmVnYXJkcywNCj4gU2F0aGlzaA0KPiANCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24g
QmVoYWxmIE9mDQo+IExhemFyLCBMaWpvDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxMCwgMjAy
MiAxMDo1OCBBTQ0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0Bh
bWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGFtZGdwdS9wbTogRG9uJ3Qgc2hvdyBgc21hcnRzaGlmdF8qX3Bvd2VyYCBmaWxl
cyBmb3INCj4gQVBVcw0KPiANCj4gDQo+IA0KPiBPbiAzLzEwLzIwMjIgMzozNSBBTSwgTWFyaW8g
TGltb25jaWVsbG8gd3JvdGU6DQo+ID4gYHNtYXJ0c2hpZnRfKl9wb3dlcmAgZmlsZXMgYXJlIHNo
b3dpbmcgdXAgb24gc29tZSBPRU0gcHJvZ3JhbXMgb24gdGhlDQo+ID4gQVBVIGluc3RlYWQgb2Yg
dGhlIGRHUFUuDQo+ID4NCj4gPiBBZGp1c3QgdGhlIGxvZ2ljIHRvIHRoZSBmdW5jdGlvbiBgc3Nf
cG93ZXJfYXR0cl91cGRhdGVgIHRvIGRldGVjdA0KPiA+IHdoZXRoZXIgb3Igbm90IHRoZSBhdHRy
aWJ1dGVzIHNob3VsZCBiZSBleHBvcnRlZC4NCj4gPg0KPiA+IFRoZSBleGlzdGluZyBjaGVja3Mg
dGhhdCBhcmUgZHJvcHBlZCBhcmUgYWxyZWFkeSBpbmNsdWRlZCBpbg0KPiA+IGBhbWRncHVfZGV2
aWNlX3N1cHBvcnRfc21hcnRfc2hpZnRgLCBzbyB0aGlzIGNhbiBiZSBzaW1wbGlmaWVkLg0KPiA+
IFRoaXMgY2F1c2VzIGF0dHJpYnV0ZXMgdG8gbm90IGJlIHNob3duIG9uIEFQVXMuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1k
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMg
fCA1ICstLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRn
cHVfcG0uYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYw0KPiA+IGlu
ZGV4IGNiYmJkNDA3OTI0OS4uY2NkMDY0OGM2Nzg5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL2FtZGdwdV9wbS5jDQo+ID4gQEAgLTE4ODQsMTAgKzE4ODQsNyBAQCBzdGF0aWMgaW50IHNz
X3Bvd2VyX2F0dHJfdXBkYXRlKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3Qg
YW1kZ3B1X2RldmljZQ0KPiA+ICAgew0KPiA+ICAgCXVpbnQzMl90IHNzX3Bvd2VyLCBzaXplOw0K
PiA+DQo+ID4gLQlpZiAoIWFtZGdwdV9hY3BpX2lzX3Bvd2VyX3NoaWZ0X2NvbnRyb2xfc3VwcG9y
dGVkKCkpDQo+ID4gLQkJKnN0YXRlcyA9IEFUVFJfU1RBVEVfVU5TVVBQT1JURUQ7DQo+ID4gLQll
bHNlIGlmICgoYWRldi0+ZmxhZ3MgJiBBTURfSVNfUFgpICYmDQo+ID4gLQ0KPiAhYW1kZ3B1X2Rl
dmljZV9zdXBwb3J0c19zbWFydF9zaGlmdChhZGV2X3RvX2RybShhZGV2KSkpDQo+ID4gKwlpZiAo
IWFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfc21hcnRfc2hpZnQoYWRldl90b19kcm0oYWRldikpKQ0K
PiA+ICAgCQkqc3RhdGVzID0gQVRUUl9TVEFURV9VTlNVUFBPUlRFRDsNCj4gDQo+IFNTIDEuMCBh
dHRyaWJ1dGVzIGFyZSBzdXBwb3J0ZWQgb24gQVBVIGRldmljZXMuIFdpbGwgdGhpcyB3b3JrIG9u
IHRob3NlPw0KPiANCj4gVGhhbmtzLA0KPiBMaWpvDQo+IA0KPiA+ICAgCWVsc2UgaWYgKGFtZGdw
dV9kcG1fcmVhZF9zZW5zb3IoYWRldiwNCj4gQU1ER1BVX1BQX1NFTlNPUl9TU19BUFVfU0hBUkUs
DQo+ID4gICAJCSAodm9pZCAqKSZzc19wb3dlciwgJnNpemUpKQ0KPiA+DQo=
