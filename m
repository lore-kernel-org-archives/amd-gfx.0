Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34454C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 09:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB52910E6C8;
	Fri, 28 Jul 2023 09:54:18 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3DC610E6C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 09:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uy2HAqwsY9BMKGM0HnSSnjH7Y05ms9uuQD6dlj4SkD0rZorpmNlxaCB9YqD7lLtsI2QBs5IQQtQnXXA7cxBnMb9fIil6yAT9Pv92p9EGANYFkhS1+HVzDWXhzX3/A+TpPpJZiRUy0TVobyqWsAGR2Ds3wPhpCujl+UfhJyIRCX/jR84c57MK+O2vTeBBu9U1WVoDPP2r047C5JU+rVytv6BG2FOUjjz8xPw4WPpyCa57/HLBRNMqmrWW/L7U+rN7PU300LKC9KFn5V/e1iIgEsLnCspYS8tEDJj/iSD+P93LQsWLiEBZBgUY9B7qnvADE4pBXpW/2W9BFSBMcbcwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgXziQkDVo2cDs+rkF95LwbxwVYAZC5yPDPPKAq1nV0=;
 b=Qh26h6vwXOjltNnnjxMW2bSzz11iq82KXA9lTkLBUUyqO4mKxrlx3TM9gVfEAqcnmQ3EPjUP2kPNir4OS5UomDHktcu0O2bOY2Xf8FHaSa4RMA8fDUgL9x4ZXe8Szl2tTN0SbAozCmvTSnbTEpLcn4w9BoQKJ/4QqbytMkRmnCOaFmPv9Xuho3+r0ZBwGhqpGuT9zZDhKJxbQiqaZw1DyrcX106/kYgJeugskmhaHgdDoM1R1/FMUXKVIbeh3WoOi0ny8e4ili47xyc8bOoh+J9YSa0Pk+uQMr5J88AOvHg9Q6soN+KDWfqgqpOLO9B9xzMOsAolzzqn/tNyvdczKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgXziQkDVo2cDs+rkF95LwbxwVYAZC5yPDPPKAq1nV0=;
 b=gh4PiLSKQ+viMXcxvZQpGkwgbiVYtHLWavCCPN89xJJFRQ/B13QygAhnqYIbRi2CzLGOVr7qT3vewKh5CMESJygPhj83UWMyo/Ag5E+yPJDjxOpcZnrRWdNEq+MmFTzjF1xWZOjPx1nE1/2w1TNDFLds3LK1pyGYYjjzVggqkOw=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 09:54:15 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 09:54:15 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdpgu: Fix printk() should include KERN_<LEVEL> in
 'amdgpu_atpx_verify_interface'
Thread-Topic: [PATCH] drm/amdpgu: Fix printk() should include KERN_<LEVEL> in
 'amdgpu_atpx_verify_interface'
Thread-Index: AQHZwRkBd0ZP1IPenU283zuAiXO3F6/O8Jhw
Date: Fri, 28 Jul 2023 09:54:15 +0000
Message-ID: <DM5PR12MB2469149EDF5C0AACB5CA8114F106A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230728060129.2691502-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230728060129.2691502-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5f5a3782-80ca-42ca-8655-384ce3be03de;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-28T09:53:49Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|PH7PR12MB7139:EE_
x-ms-office365-filtering-correlation-id: ea5dd88a-eeb9-4a7f-87df-08db8f509a68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cxbW4i1Bcm7bN+GnAe9lb1Zy2Tf1YgeTDUe78C3vFNfFjx7+2qIDFOHOFmkJ6TJSTjVzo1JHjZ2mxePRUcTCeObYexFYRoUNzmPrm9j8d7VkXL7z9RaQncHHvL0G/KSMj1gGbVXrmRyzo0A9fFZ8VTGNzmrzCJE686PFfoHncDwkdCROeBa0ggGd68vvji3b1AsjOpd4Q7LB7103Czf/tZo2FIJamwjuW2Xg9CxI09z3fHYUQLOSnLmyTp8kRKQRk56pDkcYVZ/3liHtK9zIhgT+afo5PPqYBcv02DalHBG+cronMVhaAZ97UAFl4bP7FNAlyJCM9ULb775E98Fez3KEnWOSP+r0kb2cO4yACHvQtw81K09K9ZBEXkyXYWrdyRaMv+8VVD5lBUcrFpZIl6Tilig2sTrWRZriWPza+7LhFse1yvwkdOeRAN39o5fNT609S+/ZnLoOBEsLwIfhMMsnBr+pkQHGHWhfVUuxBRa0YR8B8XvRgbizkNbt1Mcmt5X+hUe09T5xw9tFNMH4/WuGbaTi2zFCAFr/x5qD0LXxt20sTDdXNZuPFVKMhHHUsMFW8aozwP2ia3aHcJIviuwyUTLXVlzUJiCipcB/jlXo9KdYPKARklOQ12Yi/3NN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(83380400001)(110136005)(478600001)(316002)(66574015)(8676002)(33656002)(8936002)(55016003)(41300700001)(2906002)(52536014)(71200400001)(38070700005)(64756008)(122000001)(76116006)(86362001)(66556008)(38100700002)(66446008)(66476007)(66946007)(5660300002)(6636002)(4326008)(26005)(53546011)(6506007)(9686003)(186003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDhBTm1MMjBXdk1obTJzVHQwSzF4VndGdGpzWW8zT2tyU3d6TGN0dVZkOWYz?=
 =?utf-8?B?ZUVoM3M2dGg1emJ6STV4emZpN1FkSzRzV1hxQWdqZWJmaEVmVGZ2Y3BleXN0?=
 =?utf-8?B?RlZicFpTMFRLSnJ5UTlQL09TeEQyNTBFb255TmdDVUZUWGtkWlBrcjM4ZVJC?=
 =?utf-8?B?L0cvWlI2YStYQzhWbWd1eVlvcHRRclJGRG4zRTR4VjJRSGlSbndmWmlyMnhL?=
 =?utf-8?B?UWl1MDk2KzVOYU1QK2Z0eFBOTkhkV3BtdURra0NvbDdhU0JaU3d4THYxbzBL?=
 =?utf-8?B?Rkdham90Ym40Mk9uZndFcWhCMmhpdU9DSVUzcURJS0docnVhNDQ5Z1J1cFZ5?=
 =?utf-8?B?ampCak9ibzZTcDVxRmx2ZGg4aVF6MnY0QXY3WDBPd1hQMTVuc0c0aXRYMy9Y?=
 =?utf-8?B?UmIzSmNKMFpZc3JIek8rWWwvVFUvYkpvalUwcU5MSWpIVXVDZFZXcmtXdzk3?=
 =?utf-8?B?VWlFaUlydDdub1dpL1YrMHhJd3pIZHF5VTF1enVXdVJCcWdTbkM1MjhVVjcr?=
 =?utf-8?B?Q2VNak5Ua2NXYS81NFVYL1E3M2N6ZlBoY2dQSmtVRXRJTHc2MkV1dmsxdVFD?=
 =?utf-8?B?K3crc0dDb3ZFWmU5VGw1U3U5d2hZbTBiYWlaTExKREphQWxDR0xpOWViVkor?=
 =?utf-8?B?VzJHMmJ3dlVoZmdubCthb0lqZXdNcEJlMkx1MS9IaGYzbXkyVXUya1J6K3Bo?=
 =?utf-8?B?dnN0dDQ0c3YyQXRrQlh3QWF6U3hxcW9mQm9MczFSaWVaRWI1aVpzVVNvUlpB?=
 =?utf-8?B?SHowWUk2bXBscTZWMEt1N2ZEYVlpcFprMDV5VWZwa0t0MmUrcUJJa3ZZM3hx?=
 =?utf-8?B?NncydmQvcXM4S3N6T3Exa1NOVTdMcjNNR1lRR0E0Vnd2NStYc0tmempiZnRJ?=
 =?utf-8?B?OFhQWFpEcS9aUFduQ2JpdmRFYkZ4cklYSzZkQzdNVWFjektNalhPQ2ZOUWJB?=
 =?utf-8?B?bFFjZ0o1a3VyL09pTkN0YWpDVXNGR2pnRGwyRzYrT0dWa1VvbjRmVVNtYzRj?=
 =?utf-8?B?aVducUNzeWRCMDMwSjZBbTVYRnkxMEtvR093ZXkwSSsvL3Z5Y1J5VEgvUlBR?=
 =?utf-8?B?Q0NxMDBNN1lzOFRqV01CQ0tISUxIQU5hU1NXejg0MFRDSTdXdHI4SFNzNjd1?=
 =?utf-8?B?QU1SZTBIQTZxcWd3TnlMUU1RTWl6VTh0b011cnNKZ25iY1I1Ymp0Tjh6cDVj?=
 =?utf-8?B?eGJ2Z2gyelk4Q3RCSTRXNU5SV005L2VhRGdEUW8xTFJiUFlCbkVod2xIWFA3?=
 =?utf-8?B?QW4wL0RMb3RtSUtCT2pUTEkvK3BnVldWVU1SNzU3dlh6L1MwMEFxMllKRlF6?=
 =?utf-8?B?b1RJd2pjRVI1amV3RmZGdU9ueU9Hd2RjOEVvbUVQRmpCMmV2UFN3a3FRK25X?=
 =?utf-8?B?YnFrbldLRVovY201d3F0Y251VkRJRG9FWFdLaU9nK3ZQQmtiQ1hSV2E1c2Za?=
 =?utf-8?B?NW5JRFJWdS9MVE1oM3p6ZytmQmRvTUtUeUs4Nmx3MEhhQ1JzRjlNVmxZRG1K?=
 =?utf-8?B?U2VlUlUydlRhWnV0blVtVE9LVzR1VlB2eHdzNlovTENUT3VWL0tVYW9Ecy85?=
 =?utf-8?B?S2VRRTZHR1JCMWNaYzRGZWlWNWlobmN6ejJYRC8zaTcxL3lpMDFnVEQ5SlF4?=
 =?utf-8?B?NE5QMTFxZzQzRXJXc2FiUWpCQjZyQ0k1V2JZeFZEcnp0cS9wMlY0eGlSQzFt?=
 =?utf-8?B?b1pXZHVZc3hMZmVOR1h4Q2FjVTcrU1NXUUNYZWQ4TUFyakFBR3Z5a0hyS2l1?=
 =?utf-8?B?bnp0S0RVaGRQNVhPYUY0emJ2NE9TT0drY0U2b3M3QldhYTBJVjlzNzFvVFdD?=
 =?utf-8?B?ZitZbllBVTBrZjBUZjRBR0xsT1BIKzFSNDl1SVQ5UStFa0hwaU43eCtUL2RO?=
 =?utf-8?B?SEF0WkdwRG1SWGhsVmhGUVFNN09oSHR3ODZPK01iMVBtT3gzcVpkTFVqZ3po?=
 =?utf-8?B?NkR0M1dMU00zREhRVFZsSzMxSnJ4S01lM0N1QkhEU0ZyUUpKcGszMXN6d25C?=
 =?utf-8?B?a1J0bVduRGlCUE5xRXhUZ0w5c2pDTFBFOEtwR3p2d2xvT2RmRG5NZWlxTHNh?=
 =?utf-8?B?c2xQeWRhN1Q1QXk5NWROTkRMdjlNU0VwVk9ZZkx0Wk1xTCtwNjdib1hwY3A2?=
 =?utf-8?Q?GTt8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5dd88a-eeb9-4a7f-87df-08db8f509a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 09:54:15.3414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B00OwK4onDQb1YICOMx3ZIRhlIjMETGx/g+/Tpxu1V+rk+P2GySBaSYqyrVjBuUIhr83Kp+O6AkiFvo3Z/bBoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29t
Pg0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29t
Pg0KPiBTZW50OiBGcmlkYXksIEp1bHkgMjgsIDIwMjMgMjowMSBQTQ0KPiBUbzogS29lbmlnLCBD
aHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0K
PiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5A
YW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVHQU0s
IFNSSU5JVkFTQU4NCj4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFN1YmplY3Q6
IFtQQVRDSF0gZHJtL2FtZHBndTogRml4IHByaW50aygpIHNob3VsZCBpbmNsdWRlIEtFUk5fPExF
VkVMPiBpbg0KPiAnYW1kZ3B1X2F0cHhfdmVyaWZ5X2ludGVyZmFjZScNCj4NCj4gUHJlZmVyIGRl
dl9lcnIgb3ZlciBwcmludGsgdmFyaWFudCBzbyB0aGF0IHdlIGdldCBiZXR0ZXIgZGVidWcgaW5m
byB3aGVuDQo+IHRoZXJlIGFyZSBtdWx0aXBsZSBHUFVzIGluIHRoZSBzeXN0ZW0uDQo+DQo+IEZp
eGVzIHRoZSBiZWxvdzoNCj4NCj4gV0FSTklORzogcHJpbnRrKCkgc2hvdWxkIGluY2x1ZGUgS0VS
Tl88TEVWRUw+IGZhY2lsaXR5IGxldmVsDQo+ICsgICAgICAgICAgICAgICBwcmludGsoIkFUUFgg
YnVmZmVyIGlzIHRvbyBzbWFsbDogJXp1XG4iLCBzaXplKQ0KPg0KPiBDYzogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5t
dWdhbSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYXRweF9oYW5kbGVyLmMgfCAyICstDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hdHB4X2hhbmRsZXIuYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hdHB4X2hhbmRsZXIuYw0KPiBpbmRleCA2
ZjI0MWM1NzQ2NjUuLmRjY2ViZTZhYWFkNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2F0cHhfaGFuZGxlci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hdHB4X2hhbmRsZXIuYw0KPiBAQCAtMjgwLDcgKzI4MCw3IEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X2F0cHhfdmVyaWZ5X2ludGVyZmFjZShzdHJ1Y3QNCj4gYW1kZ3B1
X2F0cHggKmF0cHgpDQo+DQo+ICAgICAgIHNpemUgPSAqKHUxNiAqKSBpbmZvLT5idWZmZXIucG9p
bnRlcjsNCj4gICAgICAgaWYgKHNpemUgPCA4KSB7DQo+IC0gICAgICAgICAgICAgcHJpbnRrKCJB
VFBYIGJ1ZmZlciBpcyB0b28gc21hbGw6ICV6dVxuIiwgc2l6ZSk7DQo+ICsgICAgICAgICAgICAg
ZGV2X2VycihkZXYsICJBVFBYIGJ1ZmZlciBpcyB0b28gc21hbGw6ICV6dVxuIiwgc2l6ZSk7DQo+
ICAgICAgICAgICAgICAgZXJyID0gLUVJTlZBTDsNCj4gICAgICAgICAgICAgICBnb3RvIG91dDsN
Cj4gICAgICAgfQ0KPiAtLQ0KPiAyLjI1LjENCg0K
