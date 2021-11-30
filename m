Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC57FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 15:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DCED6E450;
	Tue, 30 Nov 2021 15:29:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD046E450
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 15:29:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOXkKW+a7ARF8nd5zf3z62iP6IRnd2SjUgWvWFVx3+R1dk0LV/x5tVEMNA3vJXLtB30wr6AF31+9Jkxm5VusddkpVZyg+qhlJP2OmOHaMzWccbOHy/EDlZmPmcdFOgh+m4eLXIYvarMiKI5BEx5qpYmsuqthPC96Le71pVHiCKILUZ3C1UpTNQSwxLRJBveOUrxiPkHYTkCaHc7m9IGjpxYQNwGVjuGA2d2XR+PE/KQrN4xE6q54cWas4wZfHN651HjEBsf/n+O9gRi1kbHnB7Aq1g5SAMDduUAEihs9BaYaYNn94cwXE0kEtPPhGp1hEFyvOsrsznZD/pw9d9tq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLzY+qeeB8QKhYi51j3EHPUPEfoGxwgopfj7mdo7LVg=;
 b=hX8QOCnlXo/w7UmDlwpArQrF6WLl0KQvXycMJIR9LPMMu0az5fDQV+04nnRk2jayUn39VJL3bA3E1Pd2eV8BQF48oe6KKLiyWBquYBD4cuip8KzpscqQywSpv4D8u2CmZbJqLfXQPoFB5u+T6HxpmbzMI22EIrSeZTV69RN+Y3d7w3Ewxjpai4q9JOJ4hDuSFVDGKz4a2ZC8Nc1lXv+c6hZQ+XPTBm8TuIhRSIV3KuoLGkV+aZjWHb44izewUjrd8nNDzfPvuSApUJusDK/YpmdmyaR5eYHkyBw8xl4GNdIzhVc6MHCMu1sTfGfRWpXaEbYuRpaGc/LppnwwKoJVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLzY+qeeB8QKhYi51j3EHPUPEfoGxwgopfj7mdo7LVg=;
 b=sdNbx2GfilGUHfYxLhWhKuqf/K+C+b8aqsY7Bx5gutJV5nLu9Lbzkf1EtpxnY+a3Lcywq2oF9O0I5d9DUMxeqRveSbQNCAkgHnID3E+Q7VZttbaNnnmXSRsq2Sy/w4zIpCjwQk1m5nshdlg9M/nWX9mCk85/ZiO6bgUK2rOOQEo=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5105.namprd12.prod.outlook.com (2603:10b6:610:bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 30 Nov
 2021 15:28:58 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 15:28:58 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: adjust the kfd reset sequence in reset sriov
 function
Thread-Topic: [PATCH] drm/amdgpu: adjust the kfd reset sequence in reset sriov
 function
Thread-Index: AQHX5ZOjJz/Ck+ZhG0aq4ZGLwki826wbmT6AgACZFZA=
Date: Tue, 30 Nov 2021 15:28:58 +0000
Message-ID: <CH0PR12MB5372A1035E255B243DA1B09DF4679@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211130024002.12492-1-shaoyun.liu@amd.com>
 <de193754-887b-50fd-3a4f-452796272854@amd.com>
In-Reply-To: <de193754-887b-50fd-3a4f-452796272854@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c2ac920-ad16-45a2-7778-08d9b416212f
x-ms-traffictypediagnostic: CH0PR12MB5105:
x-microsoft-antispam-prvs: <CH0PR12MB510582F6C786CA2EBC660E78F4679@CH0PR12MB5105.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kHfgtWD4O+zn43GJcAW/ppe5Kcqtw0hnQWPkgVWX6gIig/RasZHVC21kUJpAJ+KHs8DiQiDNURqIaFAQTYbV/fIjlBlkhrn7gvwD1WR972j5+ZSU9uHAfuyrlgi7z73rJxDFqNIL0/eTZTf5dTxSG4zt9za2uX8KMCR4rNPLoth9soXFGxf77Aq+h0ZXnTnBJWxWUmT+OWSeu4thd23OMTokMpQNpg/eTagKoQ1eVzXYAvR2EgdPkbCX23N81JRleRHK6/h82iFJq+/ogPbFIwl8+ObTdtmXU9zIhMXn+rPp1OOQO3haTWEd8fVAH4bQSJMk+1MHOlLqZorHZfpEjB+1UnKYD1UPr9vhjViZUB4Grr/9nbuUXm+xhFTrbM7KsRTUTESozUpSzu81Pe1CgnJ6Ao/Z+bWKd9Mm6vSE1I6HJrKgCPYaj2pOMXwPUaRGssVeItrL65S03rT+eSrwmEZWBlJWAauBNfg4Yhw7UV7scmytCf0DrDL2bksThJbNoI74zOnloWLGIKClaPAhgX4GX9HZEJMdUvvwu4glpI1TsNOY8LIZzwnWOWnjqHPOh2GenxEnOGTEz/KtF2t+/mWNquoVK0CEwpM0TpfTm9HPKP0gPurWDQMSMO7GSlZ/DDTxHIvhriK0C/irhh5bQDvwIsF86q/Etm/8/NBf180lkP+mxokxz7SybPejTPB6cE+eR8yUYzgTvfNPQGku4A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(9686003)(508600001)(38070700005)(55016003)(66556008)(64756008)(66446008)(83380400001)(76116006)(71200400001)(8936002)(8676002)(66946007)(66476007)(122000001)(38100700002)(5660300002)(52536014)(33656002)(2906002)(6506007)(53546011)(186003)(26005)(316002)(4001150100001)(110136005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmJFRGVzRlk5RFBzeUhmTjVnNjQ3TktMeklxVlBDbmY4ZG1rdGxGalA4VXF0?=
 =?utf-8?B?RUVud3A5aUZQeTVaVDNPLzRaY2krMnNHMEVRUkxhalI0YWRpOHRLT3lNZS9T?=
 =?utf-8?B?aTVTV3hXY3p4UUt0L2tsM2JkdlQrN0YyT2Qya1BDcWprRFpsbTA5OHNJR2RE?=
 =?utf-8?B?UG1mWUw2VXlrR0p0d0VSZmVybE5JTDFqdDNhNWhZMUhPeFE3REhjb1RQTW1y?=
 =?utf-8?B?UWdLNElHaXFVZ2hqa3dDQWF2bEZiQjlpUHk3My9mN0wwOFM1S3RSVmhzbWJU?=
 =?utf-8?B?aUpDUDdMOUpjSCtwb1RXM0xiMWY2Sk9MUWFOaFhIZEdVdGMwazlhazd1MWpk?=
 =?utf-8?B?SmxzSW1VMGJlamU5K2pxVEJZOWRnWE9SbEJlbWw3S1RlSTFSaUFIcmhJZFFo?=
 =?utf-8?B?VmhLbWN6U2EvaFlpS21aSy9hdS80WVpndE94bTBvVVN3L0dVS012VTYxc29a?=
 =?utf-8?B?MTJPcS9XeW9zTy8zdjJ2WURRaXpTU1RJZUsyZVVOZ1NRdE4xUHNneENaYUJy?=
 =?utf-8?B?VU53QjRJVC9vOEZ1UitpRzNCdFBKTkIrYUs3aDl5QXN4eWVMOXdIbUdsOFZJ?=
 =?utf-8?B?amFtM1U3TGZkZ0d5ZVgxcEdZSzJ3MjJDcllyeTlmQmljTXZtekZBNE5teEZU?=
 =?utf-8?B?aDErWHhSUU1lKzNjNW5ubUUvK2FDL0NxbkY3YlZmTk4vd1FrTEFTbWZUaklY?=
 =?utf-8?B?TXYzb09zZmorSlIyNUpvREkwaW9zaFZWQlAxdG9wdkVDU1BlbElTRnZTUU9Q?=
 =?utf-8?B?am9MMVZDOWM3MFoyS2dlUGM0MHhlRXJxeEt3NTBiVmFmemUzakFLemlpYTll?=
 =?utf-8?B?eVJkajlFZFJueE01d045RVpyNXhuUGh2aHU3dk01SmIxei9oS3VpQmtKUXUy?=
 =?utf-8?B?N1lXTHJJWS82Z1VISFdCQlRtSTIwZUJJcE11VWVLS1diRWFaMjJnVWNNTUx5?=
 =?utf-8?B?eUc3WVd0c3I1a2Nyc3U3Rktsd2JKWVFoS2g3MkxSelIveTAxRjFzMGZaNUZo?=
 =?utf-8?B?aEkwbVkxM2NlcjhSTVp2Z0s3b1ljWXFpdWYzNENZblo5Z1ozZDBONCtNWUg2?=
 =?utf-8?B?U20yNkRTQmplQ3ZGL2E4NklDR2RqUEkrV0FvUTZGV2Q3bktMdCtiSzZqaGE2?=
 =?utf-8?B?M3VXbHUxVENjODFRZlVFV0dRdG9IWjcwV3JGQVNMSGV3bDlqdklDUG1OTXlE?=
 =?utf-8?B?UGh0dmJUNm9jaFQ2dC9XUmFQTG4xV1RtMmVjRTBacmt2YnBmckpuRW5vYmZF?=
 =?utf-8?B?Z1NWa1FWZWZhWVZiYVZRaVk4N0RSb0tRdVBCS0pWS2wyRVJlYzJWd2E2Qi85?=
 =?utf-8?B?MFVRaER2M0R5aFJWOFJtblNlUEpUcTZnNmJoZ3doZ2Y1NEhzN3dHM0QzNmNB?=
 =?utf-8?B?VUVHQ3pMaUgyazlRNHBITHNJSzEvS21vdEdKdkFUQVN0a1lkZ0cvd0o5YzV2?=
 =?utf-8?B?bU5rcXNFTWE2bitQUHV4NFkyVXVDdzc0TkVmbm1xTmVJeXU4bHFKZkpDeThB?=
 =?utf-8?B?VGpBY0h2aEJPY2s1VktOeHZNcnRjNlBoaTdybU5PdHZ2MzFFb2k4d2ZXN0Jp?=
 =?utf-8?B?ZXI4NHhtdktrNkJMTzV1MXNPSkV1RDI4M2ZORVF3MXgzWDNNL21reVZwdlRJ?=
 =?utf-8?B?bFhkZU9mSHg5c2sxZlZCREQzSUdibUVJd2d5NTZJeUVnOTVzNlBVRTJIaEtV?=
 =?utf-8?B?L01GOWtWamFMMlVOQWVMRzBiNXAvWTRCR3hGdS9adFo2SjJhNWZDNUU4eW1H?=
 =?utf-8?B?Y0RidDNKL2N2UkRNNmFHeVI4d2VVZTl6OVRvV2Y2eDlqbzRHaWFhWDNmZ1dr?=
 =?utf-8?B?eityQU5lcmlrQXhxWHFJTnkxRjNKdDUwanB4ejZORElLL0lUZXhDYm5WbUcv?=
 =?utf-8?B?L1lJSk52Mm9aSW9CZXBETkxUeThVRzJYdFJkYk8wNitReExtbnppVzlRaUdj?=
 =?utf-8?B?dWFSZlJIejU5a1hYWlhJcXFSSWlJd3NmZHlVYUFDSSs2K3V1VWtrUUN2UXh2?=
 =?utf-8?B?Mlg3a2pLTjBuQ1NjU2htYXV0QU0xakszcmNZcHNXRlQ2WnpITHJsMzdta0lM?=
 =?utf-8?B?dUY5YmtrUVc5YnovSmpCWGExZm92dXhTamJRSktERlJSNFA4UU5VeTZsaWtW?=
 =?utf-8?B?KysvS1lRTWpzWU9XOXNnOE1TWDNuY01pTjhRSWZsaXhXR0xHR0h2RWozTkJZ?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2ac920-ad16-45a2-7778-08d9b416212f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 15:28:58.7390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRI/X0i7H2Hz7OLpgnRUAbKhAuQIj0Z3W4bvdUtgZN+DuJqY/kY5IxokERLSNuQRQjKH0sc12GosAdcpMybtIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5105
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

VGhhbmtzIGZvciB0aGUgcmV2aWV3ICwgY2hhbmdlIHRoZSBkZXNjcmlwdGlvbiBhcyBzdWdnZXN0
ZWQgYW5kIHN1Ym1pdHRlZC4gDQoNClNoYW95dW4ubGl1DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+IA0K
U2VudDogVHVlc2RheSwgTm92ZW1iZXIgMzAsIDIwMjEgMToxOSBBTQ0KVG86IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOyBMaXUsIFNoYW95dW4gPFNoYW95dW4uTGl1QGFtZC5jb20+DQpT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBhZGp1c3QgdGhlIGtmZCByZXNldCBzZXF1
ZW5jZSBpbiByZXNldCBzcmlvdiBmdW5jdGlvbg0KDQpBbSAyMDIxLTExLTI5IHVtIDk6NDAgcC5t
LiBzY2hyaWViIHNoYW95dW5sOg0KPiBUaGlzIGNoYW5nZSByZXZlcnQgcHJldmlvdXMgY29tbWl0
DQo+IDcwNzllN2Q1YzZiZjogZHJtL2FtZC9hbWRncHU6IGZpeCB0aGUga2ZkIHByZV9yZXNldCBz
ZXF1ZW5jZSBpbiBzcmlvdg0KPiBjZDU0N2I5M2M2MmE6IGRybS9hbWRncHU6IG1vdmUga2ZkIHBv
c3RfcmVzZXQgb3V0IG9mIHJlc2V0X3NyaW92IA0KPiBmdW5jdGlvbg0KDQpJdCBsb29rcyBsaWtl
IHRoaXMgaXMgbm90IGEgc3RyYWlnaHQgcmV2ZXJ0LiBJdCBtb3ZlcyB0aGUgYW1kZ3B1X2FtZGtm
ZF9wcmVfcmVzZXQgdG8gYW4gZWFybGllciBwbGFjZSBpbiBhbWRncHVfZGV2aWNlX3Jlc2V0X3Ny
aW92LCBwcmVzdW1hYmx5IHRvIGFkZHJlc3MgdGhlIHNlcXVlbmNlIGlzc3VlIHRoYXQgdGhlIGZp
cnN0IHBhdGNoIHdhcyBvcmlnaW5hbGx5IG1lYW50IHRvIGZpeC4gVGhlIHBhdGNoIGRlc2NyaXB0
aW9uIHNob3VsZCBtZW50aW9uIHRoYXQuDQoNCldpdGggdGhhdCBmaXhlZCwgdGhlIHBhdGNoIGlz
DQoNClJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4N
Cg0KDQo+DQo+IFNvbWUgcmVnaXN0ZXIgYWNjZXNzKEdSQk1fR0ZYX0NOVEwpIG9ubHkgYmUgYWxs
b3dlZCBvbiBmdWxsIGFjY2VzcyANCj4gbW9kZS4gTW92ZSBrZmRfcHJlX3Jlc2V0IGFuZCAga2Zk
X3Bvc3RfcmVzZXQgYmFjayBpbnNpZGUgcmVzZXRfc3Jpb3YgDQo+IGZ1bmN0aW9uLg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBzaGFveXVubCA8c2hhb3l1bi5saXVAYW1kLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAxMiArKysrKysrKy0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IGlu
ZGV4IDE5ODlmOWU5Mzc5ZS4uM2M1YWZhNDUxNzNjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IEBAIC00Mjg1LDYgKzQyODUsOCBAQCBzdGF0
aWMgaW50IGFtZGdwdV9kZXZpY2VfcmVzZXRfc3Jpb3Yoc3RydWN0IA0KPiBhbWRncHVfZGV2aWNl
ICphZGV2LCAgew0KPiAgCWludCByOw0KPiAgDQo+ICsJYW1kZ3B1X2FtZGtmZF9wcmVfcmVzZXQo
YWRldik7DQo+ICsNCj4gIAlpZiAoZnJvbV9oeXBlcnZpc29yKQ0KPiAgCQlyID0gYW1kZ3B1X3Zp
cnRfcmVxdWVzdF9mdWxsX2dwdShhZGV2LCB0cnVlKTsNCj4gIAllbHNlDQo+IEBAIC00MzEyLDYg
KzQzMTQsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfcmVzZXRfc3Jpb3Yoc3RydWN0IA0K
PiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgDQo+ICAJYW1kZ3B1X2lycV9ncHVfcmVzZXRfcmVz
dW1lX2hlbHBlcihhZGV2KTsNCj4gIAlyID0gYW1kZ3B1X2liX3JpbmdfdGVzdHMoYWRldik7DQo+
ICsJYW1kZ3B1X2FtZGtmZF9wb3N0X3Jlc2V0KGFkZXYpOw0KPiAgDQo+ICBlcnJvcjoNCj4gIAlp
ZiAoIXIgJiYgYWRldi0+dmlydC5naW1fZmVhdHVyZSAmIEFNREdJTV9GRUFUVVJFX0dJTV9GTFJf
VlJBTUxPU1QpIA0KPiB7IEBAIC01MDI2LDcgKzUwMjksOCBAQCBpbnQgYW1kZ3B1X2RldmljZV9n
cHVfcmVjb3ZlcihzdHJ1Y3QgDQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICANCj4gIAkJY2Fu
Y2VsX2RlbGF5ZWRfd29ya19zeW5jKCZ0bXBfYWRldi0+ZGVsYXllZF9pbml0X3dvcmspOw0KPiAg
DQo+IC0JCWFtZGdwdV9hbWRrZmRfcHJlX3Jlc2V0KHRtcF9hZGV2KTsNCj4gKwkJaWYgKCFhbWRn
cHVfc3Jpb3ZfdmYodG1wX2FkZXYpKQ0KPiArCQkJYW1kZ3B1X2FtZGtmZF9wcmVfcmVzZXQodG1w
X2FkZXYpOw0KPiAgDQo+ICAJCS8qDQo+ICAJCSAqIE1hcmsgdGhlc2UgQVNJQ3MgdG8gYmUgcmVz
ZXRlZCBhcyB1bnRyYWNrZWQgZmlyc3QgQEAgLTUxNDQsOSANCj4gKzUxNDgsOSBAQCBpbnQgYW1k
Z3B1X2RldmljZV9ncHVfcmVjb3ZlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gIA0K
PiAgc2tpcF9zY2hlZF9yZXN1bWU6DQo+ICAJbGlzdF9mb3JfZWFjaF9lbnRyeSh0bXBfYWRldiwg
ZGV2aWNlX2xpc3RfaGFuZGxlLCByZXNldF9saXN0KSB7DQo+IC0JCS8qIHVubG9jayBrZmQgKi8N
Cj4gLQkJaWYgKCFuZWVkX2VtZXJnZW5jeV9yZXN0YXJ0KQ0KPiAtCSAgICAgICAgICAgICAgICBh
bWRncHVfYW1ka2ZkX3Bvc3RfcmVzZXQodG1wX2FkZXYpOw0KPiArCQkvKiB1bmxvY2sga2ZkOiBT
UklPViB3b3VsZCBkbyBpdCBzZXBhcmF0ZWx5ICovDQo+ICsJCWlmICghbmVlZF9lbWVyZ2VuY3lf
cmVzdGFydCAmJiAhYW1kZ3B1X3NyaW92X3ZmKHRtcF9hZGV2KSkNCj4gKwkJCWFtZGdwdV9hbWRr
ZmRfcG9zdF9yZXNldCh0bXBfYWRldik7DQo+ICANCj4gIAkJLyoga2ZkX3Bvc3RfcmVzZXQgd2ls
bCBkbyBub3RoaW5nIGlmIGtmZCBkZXZpY2UgaXMgbm90IGluaXRpYWxpemVkLA0KPiAgCQkgKiBu
ZWVkIHRvIGJyaW5nIHVwIGtmZCBoZXJlIGlmIGl0J3Mgbm90IGJlIGluaXRpYWxpemVkIGJlZm9y
ZQ0K
