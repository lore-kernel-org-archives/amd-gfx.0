Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E5EC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 14:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE4B6135F
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 14:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8BE4B6135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 137446E9BD;
	Wed, 20 Oct 2021 14:56:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D18C16E9BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 14:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMCzGXw5GnqKage6kKUWeG2sk3gYjDlgG/4r9kFxqVQ4m6YZbsg1i13C0L6dlXxQ5DusYYrCLSICBED0Ywur1QPNUbcILtdyF3/VsaFbmOdwIgTZnKhUdD+wtYX7x2JxUsIfrfpFAb7+HdpFxIRD1dIGIiQf0J0eCRAWqRKvU/bFCTKlP/bSCB4Nn0WHjepd3wYBPm6CsSrwK8Bubk8wEEo5KjrGksCzZYcWTEP174HuF8lPAlFaPMFPUygYN7jaIBTif0aIl0aE5/to+JCJ/l3koAWuSYbTVQBjfJWr+geikHXtesG5jkmvh8KVKHjEyJDj6/gJnoUPZ8hnnXge+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBo1Kdz/iA1BD6P7LeVVQ1OXqGoLF876yJuxzg3bbXI=;
 b=dvyub509KwrtKjZvZD3CrTc51vNOrv7/CmhAh7bbZDmw5PL0+4BYPADzQD+VujmQYk0YS9QMjHzKmipONrrQQHO9khUz9tknPsrrO23hgouf0iyaV6D+OUnUKdqwc7o+kGBk80RjjRCkaSnNWJcGQuewDcCNAl6LpXoU9pRXj6Hnui/rQoE0Pe8tY0yJqVGqZybZD2I89yRtbZ5FazJ/4HM3/DzCSZ1blH6KZVFVlySvjnz9uKkh4ZJtLdhpNHOqsRqlsaML5nPwzlFxTH+nbQxZIMcFuVKhHpdj62Wu4yNaAAfpd1HT4NTkFyMTENoa7v1jF2Dj19IVx27Jg3QSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBo1Kdz/iA1BD6P7LeVVQ1OXqGoLF876yJuxzg3bbXI=;
 b=yGXyHBirDo+JxpNn0GDkQ5Gli7CCirXHn5cy/6++rns2Uhlo0sNsigk6ovFCww2C70PSQDahRRk4Ib+0KGHsvzGJHZ24ZfeEWmYXohvAra036QlpDahd3MqfB7wLxo8HWk73+qytqtNLX7MtjQR8+5DLuk0ZyeK/CD2O8r49WFk=
Received: from BYAPR12MB3319.namprd12.prod.outlook.com (2603:10b6:a03:dc::10)
 by BYAPR12MB3078.namprd12.prod.outlook.com (2603:10b6:a03:a8::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 14:56:09 +0000
Received: from BYAPR12MB3319.namprd12.prod.outlook.com
 ([fe80::ec57:ca5e:cea0:cf8f]) by BYAPR12MB3319.namprd12.prod.outlook.com
 ([fe80::ec57:ca5e:cea0:cf8f%5]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 14:56:09 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: Add kernel parameter for ignoring bad
 page threshold
Thread-Topic: [PATCH 3/4] drm/amdgpu: Add kernel parameter for ignoring bad
 page threshold
Thread-Index: AQHXxRHm4aBUYTyVHUC/Fhwm8igFtavbt8UAgABBFVA=
Date: Wed, 20 Oct 2021 14:56:09 +0000
Message-ID: <BYAPR12MB33194D82AFAE38A46AC4A89B85BE9@BYAPR12MB3319.namprd12.prod.outlook.com>
References: <20211019175050.934527-1-kent.russell@amd.com>
 <20211019175050.934527-3-kent.russell@amd.com>
 <a826bce1-bcff-3984-0d27-30b6c4e0e045@gmail.com>
In-Reply-To: <a826bce1-bcff-3984-0d27-30b6c4e0e045@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-20T14:56:07Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d00d26a0-7b37-4aeb-8dfb-ab0a98011188;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6708ad63-47ec-46df-dd26-08d993d9c064
x-ms-traffictypediagnostic: BYAPR12MB3078:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB30786173A8CEEE10E5658D1685BE9@BYAPR12MB3078.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3SN0EUCBnFspcZW0WX6tJs1+vvMxgbOnNGfgHthpotrC0+r4/PT/FzEpFIHhqucGmzweykQzKsD6Yd/Lk8Tg83mpALUM6V/3zTS3iZ4sVOqld7Es/DQIhiL4kr1kVyFZlbWXT0V0DHEa6Ao7LXbsFrECI7WVrjoWrzWjY45XW2xJ7nROmzj42e2QSICznin8HltJJ2o0ZD8XfBH3SBlEDdzUntlCFZpl7ALRjz16bSnJij54tFNzLpA4qzIS2k3QFqeb5hBhH1ovnlIynMuQrGvCf/W8vA4hOuvEeVUjQXTOCXyBhVPUP03BfLXtT+Cm+HyzrH245LQAkg1KaYFE0WWDBIWMuro9MAhqA1TBnNduNGmVN/LTo59F2A/vd9i83wVXXWnJPRl9ETqGapuPMgNPgmUFZvntmV5hu+esTqGn8P2qiwraich9lyy9su7P3F00TVMbse1I8VNQ6pPRLfNI3jcTIP2bsm3Dj7UMedR6qjO0VyNoWpVtlqSal3Oo/6Vm4o+YvwnF/iSeWjNm2Pr/6G976u4BMko0QdUVfcpOs3LM19dmJD67ZNUf7gI7gn5Kot50o/jDt9+1q12Fsc9urlLU1Htu87YyXSGYdi53UZNMriNUURX/3xaRetNbrv+Hk6QIC7RDYOHpZggjIqWgJ2smqv66waPZPpxhDDhVtj+vXQHnrR2etfGsu3CP0byJWQviKzecTVZk1ioI2A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3319.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(66556008)(66476007)(66446008)(110136005)(38070700005)(54906003)(76116006)(66946007)(122000001)(83380400001)(38100700002)(64756008)(86362001)(5660300002)(2906002)(4326008)(52536014)(8676002)(316002)(71200400001)(55016002)(9686003)(8936002)(186003)(66574015)(33656002)(53546011)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXJscFJYMFBrV0V5VHE5elpHWk1oUGk3cjJzMkg2QXJFempsaUQwQ1lIcWNu?=
 =?utf-8?B?R3d3U01vZ3EzOHZPcUIrclJxY3dWNURnZVgvSi9XN3lxa0VOVjU4ekNsZjgy?=
 =?utf-8?B?eDJQMEtqMjlOanBRMVQ2Mm4yMDIycEIvZXAzdy9ObXRmSTZQS1loYjhKVElE?=
 =?utf-8?B?Yzhua2pDdUgrY0JmSTZobjdCS1VEUFpjSXdNeHFEZndSN1FxdlFTM0RkMml5?=
 =?utf-8?B?QXFDSkF0QkM2T1MyZmU0bDZsOEJ4UVRLOFZTOUFxZHdTQ2YxR0dEaERneVdG?=
 =?utf-8?B?RDI5cWNDMm4yWHo1SnVIL0Rnay9yQS9IUXYvNS9jUXJXWGVPcmFzbHMycFgw?=
 =?utf-8?B?SHZ3U3ZoZUNtR0FTSXAyRmdORW9VSG1ETXhXeWRYSFVxb1VteU9JQ2dpcU10?=
 =?utf-8?B?OTZDejlqOStybFo2T1VRTzhaWDhVQkY2M0xBenF2UjkwQ3drTHhmek5XSWtI?=
 =?utf-8?B?RnZTbWVzWXpxN1FJYXpuMUttQzlZS09iZ0VGR0dkUEZuaW55RWFiQVBrNUJJ?=
 =?utf-8?B?V1B2VGdZQ2dqdUJZOWFzSUU2TUhXcUNhcWUvQmhVb3Byc3EvK0xVWUM1WnJW?=
 =?utf-8?B?NlFoRlFsT2ExU2ZtSDNHWW5IQTFtZjBRdnlwaE5acENPc1JFN0JQbjFZMC9n?=
 =?utf-8?B?dW85bmVYWUpuaE9ZaG9iWFV1TEVWWmg2WWtwdld2c1ROQ0xLVTFIN0srVG8v?=
 =?utf-8?B?c2ttOWVVZDRFZ3V1OVR5QThHcytWVTFuUFIwZGorQWx1MUlIN3VoUHk1Zmk0?=
 =?utf-8?B?UlRpeEhhWGhWbVRSbXhsc2xOKzFORTBkVTQ1U1QxVTVCUkZLeVJTOW10RXVo?=
 =?utf-8?B?RnhuVEM3ZHI3UEFiNUVWZ2ZSMzNQOTF2ZEV0MUxLNXRObzE0L1U2VVdtYi80?=
 =?utf-8?B?cVhSZk1CZmh2L2p1MW9TbmpSTDlrU0ZJV3pjcnBZd0grY1o5Y3FMY3I2eVRk?=
 =?utf-8?B?L1FpUXZNSXdsZFcwSGI1aE5Zelp6djAxKzRTWHdTWFBOUWFtR2czUWpyTjcw?=
 =?utf-8?B?NmRlc2JYbHFDM3FacEJsQ0xTY3MvdXpkcFI4VkExaFNvZktzOFRMcHB4TnN0?=
 =?utf-8?B?aGtxa3ZFaWxheU43MTdpWVFWdVBLb0ZVZytRdHpmUmhhY0thZHFqOWZyZjc1?=
 =?utf-8?B?c3dVUEgyTCt0Wmt6L0I5UVRrNkNHaWNwUE9nUUFheWpaUjI5Zk1hak1PQzVu?=
 =?utf-8?B?UmtmNjg5MFlwT1cvOXJ6MzB4emVYcUZNMFpTaDZkd2kvWHhSbzJEMVRmYUly?=
 =?utf-8?B?YWRhRncydUpwUFM5V2tTY1MySDhJSDd0VUlCMVc4ellmNFlKZTJOb2RzU21C?=
 =?utf-8?B?S0NCY0tQWnNKeUxiZGxOaHZodkdOTCtnRFJkQ2lNaG9CMStaandtemNoZUdJ?=
 =?utf-8?B?REVYYm9oMlQxVENWQ0ZSTGF2cmkrOTJQWjZyc3pmRTZkZDBwM3pJWmgrK3VB?=
 =?utf-8?B?bGY3MWFvR25SMU9iZ1c2d3lmTkxoK2hOTm81eDM2ZmVZM3ZjN21SejByWmti?=
 =?utf-8?B?ZXMvQ1ZDZ2w0ckQwcUswOHJ4SnVoWG8vRW50RGtiZjFTUjg4M0tZQkVHbkc2?=
 =?utf-8?B?b0NaTmZMQnBOQk4xenZSWDRYSWFqN0ZCOWR6ckVzVi9GNWVnZWZYVmlZZmcv?=
 =?utf-8?B?OGVjdmNQSWFFMWtpd1pNSm8wU3ZJTHRvMjk3V2J1b21NZFYyNlV2clZ4Q09l?=
 =?utf-8?B?RVlGY3pnTFNJVzBPMHN4RERmSDBicnFVZmp3dmx5UWMzTktYK1VtdDZraGZS?=
 =?utf-8?B?V0R0RURFeDNBTGlKUStUOFVlSXBjOVVvTEpxYVVqUTNyNU0wRjFaNmhYVVp5?=
 =?utf-8?B?dFJqV0VIMlp0VmRwcXVIWEJrODBTNStEOHpsTGttZmJzb3JuZFBVcnpmYkRU?=
 =?utf-8?Q?mytrqw/sPTCrA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3319.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6708ad63-47ec-46df-dd26-08d993d9c064
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 14:56:09.3928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: niK5D6NqC/qM9B5XDo4QrMbYx1oycc+rdf+4xfJhLJPsg71D6zzQtc7tBnM88zfknyHLvZF+yWy5eNnRqWdZNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3078
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSSBjYW4gc2VlIGJvdGggc2lkZXMgb2YgdGhlIGFy
Z3VtZW50LiBIYXZpbmcgYSBjb25maWd1cmFibGUgdGhyZXNob2xkIG1lYW5zIHRoYXQgeW91IGNh
biBkZXRlcm1pbmUgd2hhdCBzb3J0IG9mICJIVyByZWxpYWJpbGl0eSIgdGhhdCB5b3Ugd2FudC4g
VGhlIGRlZmF1bHQgdmFsdWUgaXMgbGlrZWx5IG5vdCBnb2luZyB0byBnZXQgaGl0IGJ5IHRoZSBh
dmVyYWdlIHVzZXIuIEFuZCB1c2VycyB0aGF0IERPIGhpdCB0aGF0IHRocmVzaG9sZCBjYW4gZGV0
ZXJtaW5lIGlmIHRoZXkgd2FudCB0byBpZ25vcmUgaXQsIGluY3JlYXNlIGl0LCBvciByZXBsYWNl
IHRoZSBoYXJkd2FyZSwgdGhyb3VnaCB0aGUga2VybmVsIHBhcmFtZXRlci4gDQoNCkJ1dCBoYXZp
bmcgdGhhdCBvcHRpb24gbWVhbnMgaXQncyBjb25maWd1cmFibGUgYmFzZWQgb24gd2hhdCB0aGF0
IGN1c3RvbWVyIHdhbnRzLiBJZiB0aGV5IGJlbGlldmUgdGhhdCBhbGwgZGF0YSBpcyBwcmVjaW91
cywgc2V0dGluZyB0aGUgdGhyZXNob2xkIHRvIHNvbWV0aGluZyBsaWtlIDEgYmFkIHBhZ2UgbWVh
bnMgdGhhdCB0aGV5IHdvbid0IGV2ZXIgcnVuIG9uIGEgY2hpcCB0aGF0IGV2ZXIgaGFkIGEgYmFk
IHBhZ2UsIHRodXMgZW5zdXJpbmcgZGF0YSBpbnRlZ3JpdHkuIEl0IHNlZW1zIGx1ZGljcm91cyB0
byBtZSB0byBoYXZlIGEgdmFsdWUgc28gbG93LCBidXQgSSBhbSBzdXJlIHRoYXQgc29tZW9uZSBv
dXQgdGhlcmUgd291bGQgd2FudCB0byByZW1vdmUgYSBHUFUgYXMgc29vbiBhcyBpdCBoYXMgb25l
IGJhZCBwYWdlIHJldGlyZWQuIEFuZCBzb21lIHBlb3BsZSBjb3VsZG4ndCBjYXJlIGFueSBsZXNz
LCBzbyB0aGV5IGNhbiBzZXQgaXQgdG8gZGlzYWJsZWQgb3IgaWdub3JlZCBvciB3aGF0ZXZlciB0
aGV5IHdpc2guDQoNCkFzIGl0IHN0YW5kcywgd2UgaGF2ZSBhdCBsZWFzdCB0d28gY3VzdG9tZXJz
IHdobyBhcmUgZm9jdXNlZCBvbiBoYXZpbmcgdGhlIHRocmVzaG9sZCBhdXRvbWF0aWNhbGx5IHJl
bW92ZSB0aGUgR1BVcyBmcm9tIHVzZSwgdG8gZW5zdXJlIGRhdGEgaW50ZWdyaXR5LiBUaGV5IGp1
c3Qgd2FudCB3YXJuaW5ncyB0byBrbm93IHRoYXQgaXQncyBnZXR0aW5nIGJhZCAobXkgOTAlIHRo
cmVzaG9sZCBwYXRjaCksIHNvIHRoYXQgdGhleSBjYW4gcGxhbiBmb3IgSFcgcmVwbGFjZW1lbnQg
YWNjb3JkaW5nbHkuIA0KDQogS2VudA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29t
Pg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjAsIDIwMjEgNjo1NSBBTQ0KPiBUbzogUnVz
c2VsbCwgS2VudCA8S2VudC5SdXNzZWxsQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBDYzogVHVpa292LCBMdWJlbiA8THViZW4uVHVpa292QGFtZC5jb20+OyBKb3No
aSwgTXVrdWwgPE11a3VsLkpvc2hpQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy80
XSBkcm0vYW1kZ3B1OiBBZGQga2VybmVsIHBhcmFtZXRlciBmb3IgaWdub3JpbmcgYmFkIHBhZ2UN
Cj4gdGhyZXNob2xkDQo+IA0KPiBBbSAxOS4xMC4yMSB1bSAxOTo1MCBzY2hyaWViIEtlbnQgUnVz
c2VsbDoNCj4gPiBXaGVuIGEgR1BVIGhpdHMgdGhlIGJhZF9wYWdlX3RocmVzaG9sZCwgaXQgd2ls
bCBub3QgYmUgaW5pdGlhbGl6ZWQgYnkNCj4gPiB0aGUgYW1kZ3B1IGRyaXZlci4gVGhpcyBtZWFu
cyB0aGF0IHRoZSB0YWJsZSBjYW5ub3QgYmUgY2xlYXJlZCwgbm9yIGNhbg0KPiA+IGluZm9ybWF0
aW9uIGdhdGhlcmluZyBiZSBwZXJmb3JtZWQgKGdldHRpbmcgc2VyaWFsIG51bWJlciwgQkRGLCBl
dGMpLg0KPiA+IEFkZCBhbiBvdmVycmlkZSBjYWxsZWQgaWdub3JlX2JhZF9wYWdlX3RocmVzaG9s
ZCB0aGF0IGNhbiBiZSBzZXQgdG8gdHJ1ZQ0KPiA+IHRvIHN0aWxsIGluaXRpYWxpemUgdGhlIEdQ
VSwgZXZlbiB3aGVuIHRoZSBiYWQgcGFnZSB0aHJlc2hvbGQgaGFzIGJlZW4NCj4gPiByZWFjaGVk
Lg0KPiANCj4gSSB3b3VsZCByYXRoZXIgcXVlc3Rpb24gdGhlIHByYWN0aWNlIG9mIHRoaXMgYmFk
IHBhZ2VzIHRocmVzaG9sZC4NCj4gDQo+IEFzIGZhciBhcyBJIGtub3cgdGhlIGhhcmR3YXJlIHdv
cmtzIHBlcmZlY3RseSBmaW5lIGV2ZW4gd2hlbiB3ZSBoYXZlDQo+IG1vcmUgYmFkIGJhZGxlcyB0
aGVuIGV4cGVjdGVkLCB3ZSBzaG91bGQganVzdCB3YXJuIHJlYWxseSBsb3VkbHkgYWJvdXQgaXQu
DQo+IA0KPiBDaHJpc3RpYW4uDQo+IA0KPiA+DQo+ID4gQ2M6IEx1YmVuIFR1aWtvdiA8bHViZW4u
dHVpa292QGFtZC5jb20+DQo+ID4gQ2M6IE11a3VsIEpvc2hpIDxNdWt1bC5Kb3NoaUBhbWQuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFtZC5jb20+
DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCAgICAg
fCAgMSArDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCAx
MyArKysrKysrKysrKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUu
aA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4gaW5kZXggZDU4
ZTM3ZmQwMWY0Li5iODViNjdhODhhM2QgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHUuaA0KPiA+IEBAIC0yMDUsNiArMjA1LDcgQEAgZXh0ZXJuIHN0cnVjdCBhbWRncHVf
bWdwdV9pbmZvIG1ncHVfaW5mbzsNCj4gPiAgIGV4dGVybiBpbnQgYW1kZ3B1X3Jhc19lbmFibGU7
DQo+ID4gICBleHRlcm4gdWludCBhbWRncHVfcmFzX21hc2s7DQo+ID4gICBleHRlcm4gaW50IGFt
ZGdwdV9iYWRfcGFnZV90aHJlc2hvbGQ7DQo+ID4gK2V4dGVybiBib29sIGFtZGdwdV9pZ25vcmVf
YmFkX3BhZ2VfdGhyZXNob2xkOw0KPiA+ICAgZXh0ZXJuIHN0cnVjdCBhbWRncHVfd2F0Y2hkb2df
dGltZXIgYW1kZ3B1X3dhdGNoZG9nX3RpbWVyOw0KPiA+ICAgZXh0ZXJuIGludCBhbWRncHVfYXN5
bmNfZ2Z4X3Jpbmc7DQo+ID4gICBleHRlcm4gaW50IGFtZGdwdV9tY2JwOw0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPiBpbmRleCA5NmJkNjNhZWVkZGQu
LjNlOWE3YjA3Mjg4OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZHJ2LmMNCj4gPiBAQCAtMTg5LDYgKzE4OSw3IEBAIHN0cnVjdCBhbWRncHVfbWdwdV9pbmZv
IG1ncHVfaW5mbyA9IHsNCj4gPiAgIGludCBhbWRncHVfcmFzX2VuYWJsZSA9IC0xOw0KPiA+ICAg
dWludCBhbWRncHVfcmFzX21hc2sgPSAweGZmZmZmZmZmOw0KPiA+ICAgaW50IGFtZGdwdV9iYWRf
cGFnZV90aHJlc2hvbGQgPSAtMTsNCj4gPiArYm9vbCBhbWRncHVfaWdub3JlX2JhZF9wYWdlX3Ro
cmVzaG9sZDsNCj4gPiAgIHN0cnVjdCBhbWRncHVfd2F0Y2hkb2dfdGltZXIgYW1kZ3B1X3dhdGNo
ZG9nX3RpbWVyID0gew0KPiA+ICAgCS50aW1lb3V0X2ZhdGFsX2Rpc2FibGUgPSBmYWxzZSwNCj4g
PiAgIAkucGVyaW9kID0gMHgwLCAvKiBkZWZhdWx0IHRvIDB4MCAodGltZW91dCBkaXNhYmxlKSAq
Lw0KPiA+IEBAIC04ODAsNiArODgxLDE4IEBAIG1vZHVsZV9wYXJhbV9uYW1lZChyZXNldF9tZXRo
b2QsIGFtZGdwdV9yZXNldF9tZXRob2QsDQo+IGludCwgMDQ0NCk7DQo+ID4gICBNT0RVTEVfUEFS
TV9ERVNDKGJhZF9wYWdlX3RocmVzaG9sZCwgIkJhZCBwYWdlIHRocmVzaG9sZCgtMSA9IGF1dG8o
ZGVmYXVsdA0KPiB2YWx1ZSksIDAgPSBkaXNhYmxlIGJhZCBwYWdlIHJldGlyZW1lbnQpIik7DQo+
ID4gICBtb2R1bGVfcGFyYW1fbmFtZWQoYmFkX3BhZ2VfdGhyZXNob2xkLCBhbWRncHVfYmFkX3Bh
Z2VfdGhyZXNob2xkLCBpbnQsIDA0NDQpOw0KPiA+DQo+ID4gKy8qKg0KPiA+ICsgKiBET0M6IGln
bm9yZV9iYWRfcGFnZV90aHJlc2hvbGQgKGJvb2wpIEJhZCBwYWdlIHRocmVzaG9sZCBzcGVjaWZp
ZXMNCj4gPiArICogdGhlIHRocmVzaG9sZCB2YWx1ZSBvZiBmYXVsdHkgcGFnZXMgZGV0ZWN0ZWQg
YnkgUkFTIEVDQy4gT25jZSB0aGUNCj4gPiArICogdGhyZXNob2xkIGlzIGhpdCwgdGhlIEdQVSB3
aWxsIG5vdCBiZSBpbml0aWFsaXplZC4gVXNlIHRoaXMgcGFyYW1ldGVyDQo+ID4gKyAqIHRvIGln
bm9yZSB0aGUgYmFkIHBhZ2UgdGhyZXNob2xkIHNvIHRoYXQgaW5mb3JtYXRpb24gZ2F0aGVyaW5n
IGNhbg0KPiA+ICsgKiBzdGlsbCBiZSBwZXJmb3JtZWQuIFRoaXMgYWxzbyBhbGxvd3MgZm9yIGJv
b3RpbmcgdGhlIEdQVSB0byBjbGVhcg0KPiA+ICsgKiB0aGUgUkFTIEVFUFJPTSB0YWJsZS4NCj4g
PiArICovDQo+ID4gKw0KPiA+ICtNT0RVTEVfUEFSTV9ERVNDKGlnbm9yZV9iYWRfcGFnZV90aHJl
c2hvbGQsICJJZ25vcmUgYmFkIHBhZ2UgdGhyZXNob2xkIChmYWxzZSA9DQo+IHJlc3BlY3QgYmFk
IHBhZ2UgdGhyZXNob2xkIChkZWZhdWx0IHZhbHVlKSIpOw0KPiA+ICttb2R1bGVfcGFyYW1fbmFt
ZWQoaWdub3JlX2JhZF9wYWdlX3RocmVzaG9sZCwNCj4gYW1kZ3B1X2lnbm9yZV9iYWRfcGFnZV90
aHJlc2hvbGQsIGJvb2wsIDA2NDQpOw0KPiA+ICsNCj4gPiAgIE1PRFVMRV9QQVJNX0RFU0MobnVt
X2tjcSwgIm51bWJlciBvZiBrZXJuZWwgY29tcHV0ZSBxdWV1ZSB1c2VyIHdhbnQgdG8gc2V0dXAN
Cj4gKDggaWYgc2V0IHRvIGdyZWF0ZXIgdGhhbiA4IG9yIGxlc3MgdGhhbiAwLCBvbmx5IGFmZmVj
dCBnZnggOCspIik7DQo+ID4gICBtb2R1bGVfcGFyYW1fbmFtZWQobnVtX2tjcSwgYW1kZ3B1X251
bV9rY3EsIGludCwgMDQ0NCk7DQo+ID4NCg==
