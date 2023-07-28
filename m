Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815BCC001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 09:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D0010E06F;
	Fri, 28 Jul 2023 09:51:47 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1587510E064
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 09:51:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKYDseBKqD8UaNUrxOfMQTzHWj7BkNtHWkxBM2qstaxKH6axiY67ppXTPEAQB4Eb3bHuCItbakBXvi/UtaN0zopK4hQWp6IZHY5iq4Iibsk1GogFeQq2RGHm+xnGpKFd41DYlnqdYZmBOGXQjF/hSkMWuTgQx8ywrRXMJmAdOpGT70hkQ7yjK+JsT5CPp8DqWZnEzdVTy+gukpCBFRLLiXFUS+armXqbH/cMMiwbudh3iFBnZGjdNH3wEbzxwjyduGy8VOcJ+Ar46JQakBcIYWdE02kNFREMCP6rN1Pl4H6ML+haKjYa83XeTCcuEdYeiipPPNEjRKHdnG4+rtKAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQy1Vo3xH2GJRv7Zkj5Cyz9oyFKfx/YiwtWTp4nal5s=;
 b=N+hhUnTHZ2j8ziu5di3a1gxeLxsamfOWN3BmJ7k3n/EnNa3pdYwzI3KyjAJRXzARRiPdDa6NRRChOtbIwi5CZJNTSF2ty87909Me1yHJQchA0TEx38fivh6zqhjR3KbCqllsa+gbmh0bZMqhlNpP43HdIFJ3+MsmHpmO014ltv4HqAPBSLyjptnf1AA7Pkz2QVyljn1gJ2NLVu1EZgfZX+FbDqCQoxbIgt7V43UWfR0otwhw1fsJi7upfZ9AY6IBoTq75BHmifd4eR0O9kcMbQqBSH1GkWxIMcZHn0Btmhx0n3z4iCDipvf91lzQNg2xKedW7B2qH4lkiBPxb4Pnlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQy1Vo3xH2GJRv7Zkj5Cyz9oyFKfx/YiwtWTp4nal5s=;
 b=w7nbu+HnVFTZpCh467X9l+uAF7YKnawPg4qAoydyf5A0pDhT3tYZsc3xvoDPm5sFisSUaUgT4NHrxC2H42VywLrUbfEY1WBmPB2gKtb9HjzM1aPV0Zpolp+ofZxESESJvMvjgVTl6RXOHQfGRctVRnTnqybiiSPpC+T/ZKSkS88=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 09:51:42 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 09:51:42 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix printk_ratelimit() with
 DRM_ERROR_RATELIMITED in 'amdgpu_cs_ioctl'
Thread-Topic: [PATCH] drm/amdgpu: Fix printk_ratelimit() with
 DRM_ERROR_RATELIMITED in 'amdgpu_cs_ioctl'
Thread-Index: AQHZwDK6/Waue2HTRkSsqtjUucelEK/O8aqw
Date: Fri, 28 Jul 2023 09:51:42 +0000
Message-ID: <DM5PR12MB24694D01E4C43A84B76EC72EF106A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230727023246.2544384-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230727023246.2544384-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=13a7556a-477f-4eaa-b05b-6678ab960a19;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-28T09:51:11Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|PH7PR12MB7139:EE_
x-ms-office365-filtering-correlation-id: 7154998c-8c0a-4f9d-8cac-08db8f503f08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EKaFM0utz1hx75QVxOwpJLSkDzJKhpB7ZEIe3kwEeVrFrd+fV9udj341D+E2kxWQAtc1lGYIjPD5eVOCdjcGCJQ97lqcxx0Xl8cXq0IcDFwBtHELee7ns4BoCXtwjH+q8mQ5G/Kt/By3ZZ1guIdTZPU7nDDKJvpmW6GnViiw5S0iaAffy0u31Xi42TqTtDendcoeSqMVX9gO6pHFL9FzccqjTN92eN0R4dk1t2OS8Ixb1RHyen597t2N14jgrvZCYSi6QhTmZGF3DKYCt26KwJpjhM8Wt/SNFX3ZulrUv3xR6dOMl/8S/xnPdf0T+7d7DmISoppa+4c6BgLL6rXcLM+7FHCjGZWgpEqy3RppcJpQV/Ioe5jPEM1SeHoJATcRO2brgP10NCvF72JE00XmIDWFULv3laxf0PI8T46JQkBKi1o9Oo1HOoUbr0hWZ54otsl9cUnVksE2ToljBrRAmPeKlI8aKGuO35ZskUpXEw63QK1+4mjGXbf12zyHiprFI2aL2UJ0IgADDxVGW0cB0tR1L3RTEJNljfYc8/235tbhVZPEvzm2Jl0B63hh25Kec0FAe5RCQVr80jKrEEBP7KbBlaIUKasCRuN6dsNm0h/s+61N+qM+9FG+RFC445yv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(83380400001)(110136005)(478600001)(316002)(66574015)(8676002)(33656002)(8936002)(55016003)(41300700001)(2906002)(52536014)(71200400001)(38070700005)(64756008)(122000001)(76116006)(86362001)(66556008)(38100700002)(66446008)(66476007)(66946007)(5660300002)(6636002)(4326008)(26005)(53546011)(6506007)(9686003)(186003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHFJeTVianVTRkozdmtmVUhSd1ZIaFVEMnl4OTNLNHdrRkZJRzFvOStlZkJE?=
 =?utf-8?B?c2NVQ2tFam9lZVVXQkV0dEVaTjRnNk9aZUc3ZGlPREF2NThreGJRT1FmSUt2?=
 =?utf-8?B?VEVUNStQSnQ2TUJmUTdtbHA2Vk03RU5qVmtScTZ4OU9QcHJUQVRwNUxJc1lz?=
 =?utf-8?B?aC9FMDRmbFZ4a0FpcGZrdXZ2K3VhQ09PV2haWFhFNlUrTERxUEsvNEtQd0Jz?=
 =?utf-8?B?dlprd3kxdmxTaWRPWm5lWWQycUtEWGdFaXNaTzJIQVZyc2NPbG93TFNNbHBJ?=
 =?utf-8?B?QlZpb29aMm95SjJvM0R5ZURJQnNVNWRsUGJVdkRvdXk1TDh2QXJYTytMdWFn?=
 =?utf-8?B?MTRIRDBKaCsvTVdPU01ueW5oTWF2bE1aYkRsMURJaEE1TGRuNERoanBpTVBC?=
 =?utf-8?B?T0JqODkrV2MzbXlqaTZYREtpREdjQnRmTWY2UHZDYm9pWWxVbGd0VVZsUEYy?=
 =?utf-8?B?c0tkVXBCSUVBeGhYRVFkVmV2UHp5OXgvQmlJaW90eUJmLzN6TzN2ZEJ3TFNy?=
 =?utf-8?B?emdGMjRsQUVmaWt5RGJ4cjBCT1d6c2QvSHdYK2I5ZlNza2pSSStUUDY0R3Vz?=
 =?utf-8?B?VDFSREhQSGdKaVRWbktMdjBPL3lvRlNVSGN0NlNNRmNNemVwemNxTWwvdzRW?=
 =?utf-8?B?ajZBZVBaaWpKM3N4TFQ4TzV3QkpkMUlYV3JWRENueU04UjdRMldDRTM5MzBz?=
 =?utf-8?B?QnhVdGtNTG85YWFNUnhPSm1DbEE3YjNwLzQxVEVMRXlhZnBEUFJ1QU5TNE1r?=
 =?utf-8?B?ODlwdUZtL0IydEhNR2xESjZOa29UUXFYK2lMeGpNZ1BSUE9MdU5yS05YMS9P?=
 =?utf-8?B?bXNQYzBkMjA1NVFESkQ1L0pHbTRwd1BqOTBVa3l5MUdEOThtVjg0Rm1WVXQ1?=
 =?utf-8?B?RmF2NFgvQTc0dSt6aXZPNHdZQmZmZ1ovYmpzcTlYSzdkR29MS25aQkJKeEgw?=
 =?utf-8?B?OG0vbklMZFdKWDNiVjREenNGVmV6L0U0ZFpsMk1wWTFCV1VuM0xVcEU1NjU0?=
 =?utf-8?B?SzFYa2ZNMUpUeng0WDNCbmhCS0pMTXNadE92ZGlERlVTU1VRNk10TWVyUUZ0?=
 =?utf-8?B?dkN4UEIxb21ERkJUcXdOUFRzdXgraElYeTVId2szVzhlckowQkhpcVdxM3hD?=
 =?utf-8?B?Nk42dHFEZVM1NnlodExkc2xINzRiVC85RVc1alJvckxvdFZYVkdIRDEzU2Fj?=
 =?utf-8?B?bCt2cFlXN0Rtby85QXdMNnh0cGVSU3AzZk1EemZEanNMQ1lmYnJRU2k4b1lt?=
 =?utf-8?B?SkxmZmJMc3I5MTVMQjF3YlpnY0FCME5hRnZUczZRMEJ2azNmN3pibmh5NGZM?=
 =?utf-8?B?WkFkYU1jTklrT1JJdUNVOWlxc1h4RGFPeWMzM1c0Vy9LdUE5VXBNa3V3TTdM?=
 =?utf-8?B?T2hsbThsdjhmbXlGRDJJdVNHbzhQV1MwUHVCQmNtQzdsR0QzNjdXbVc2Umor?=
 =?utf-8?B?VWMyK2p2a3ZobGdkZzZOR0MvVEVDdEhNZTJpVlNrTTFBL2d5U0VDeDMrVUdt?=
 =?utf-8?B?Q3lLN2htVzhzV3FHcTcra1U5SkR6REFiSU1PVVd1VXRIUE1EN3lwTWpKU3BR?=
 =?utf-8?B?Q0IvdlBFWHEyWnBLdFp3YzRIOHAxR1F2amRUeXFNQnRNVUZ0YWdBZituSzhp?=
 =?utf-8?B?KzJOU1c5L0c4dEFpSUFaS0RnWWpjQTRUS2Jkd2RKK2hmOGdpM3Fhb01DT21n?=
 =?utf-8?B?ZHBGRVZucW5kZ1FJVEhGL3c1Y3BpQk9EdzBnUHVvdWRTUmFKQ1JQTkVwSVda?=
 =?utf-8?B?RHB6NDlQRHJyNmtKOXY1bEMrTW9iTU1vbWdpWHdkRzMza3AxOEJoWkhmQjlG?=
 =?utf-8?B?UWx2ZCtmQ1VJRnlsS1BJL3FLQU85SW1HWVN3ZTlVSnlta0JYbWZKdWZQZGp6?=
 =?utf-8?B?ZEd4WU1FUHF5S3pRTENldGIrUnFnYkVuZFUrMm5qZFROSTBBMkhuSmp6S1Uv?=
 =?utf-8?B?RGRJSDIxeVUyRlZIN0t4VEJKWCtFejlBNlNvU1lDZUlHbG1mdlZTUVhPeGFs?=
 =?utf-8?B?WXZ4VENUZEh5anZNSXZ2VXJ4QnJWMjYrREhPSmYwb3lnZ1lKREZJaGdwemtR?=
 =?utf-8?B?ZUEvbjdZbGlJRFlFQk4vSS9vYzFJcjNIZXRlVjZUL1dlczYwR0hJM2cwNzA0?=
 =?utf-8?Q?lYzA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7154998c-8c0a-4f9d-8cac-08db8f503f08
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 09:51:42.0591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58c3Yat8ZSS9ijCq+X/pNMVrDd5ilDQHaSRAMzgrqTdj3PnsKexTZN/9oC4CDuQ3kI9U7nrdnQ8H9JSxfPA0Hw==
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
Pg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAyNywgMjAyMyAxMDozMyBBTQ0KPiBUbzogS29lbmln
LCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRl
cg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNo
ZW5AYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVH
QU0sIFNSSU5JVkFTQU4NCj4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFN1Ympl
Y3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4IHByaW50a19yYXRlbGltaXQoKSB3aXRoDQo+IERS
TV9FUlJPUl9SQVRFTElNSVRFRCBpbiAnYW1kZ3B1X2NzX2lvY3RsJw0KPg0KPiBSZXBsYWNlZCBw
cmludGtfcmF0ZWxpbWl0KCkgd2l0aCBpdHMgRFJNIGVxdWl2YWxlbnQgdG8gYXZvaWQgZmxvb2Rp
bmcgb2YNCj4gZG1lc2cgbG9ncyAmIGhlbmNlIGZpeGVzIHRoZSBmb2xsb3dpbmc6DQo+DQo+IFdB
Uk5JTkc6IFByZWZlciBwcmludGtfcmF0ZWxpbWl0ZWQgb3IgcHJfPGxldmVsPl9yYXRlbGltaXRl
ZCB0bw0KPiBwcmludGtfcmF0ZWxpbWl0DQo+ICsgICAgICAgICAgICAgICBpZiAocHJpbnRrX3Jh
dGVsaW1pdCgpKQ0KPg0KPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPg0KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNhbi5zaGFubXVn
YW1AYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Y3MuYyB8IDMgKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRp
b25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfY3MuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jDQo+IGlu
ZGV4IDA0MGY0Y2I2YWIyZC4uYTNiYWU5OGM3ODAzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfY3MuYw0KPiBAQCAtMTQzMCw4ICsxNDMwLDcgQEAgaW50IGFtZGdwdV9j
c19pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkDQo+ICpkYXRhLCBzdHJ1Y3QgZHJt
X2ZpbGUgKmZpbHApDQo+DQo+ICAgICAgIHIgPSBhbWRncHVfY3NfcGFyc2VyX2luaXQoJnBhcnNl
ciwgYWRldiwgZmlscCwgZGF0YSk7DQo+ICAgICAgIGlmIChyKSB7DQo+IC0gICAgICAgICAgICAg
aWYgKHByaW50a19yYXRlbGltaXQoKSkNCj4gLSAgICAgICAgICAgICAgICAgICAgIERSTV9FUlJP
UigiRmFpbGVkIHRvIGluaXRpYWxpemUgcGFyc2VyICVkIVxuIiwgcik7DQo+ICsgICAgICAgICAg
ICAgRFJNX0VSUk9SX1JBVEVMSU1JVEVEKCJGYWlsZWQgdG8gaW5pdGlhbGl6ZSBwYXJzZXIgJWQh
XG4iLA0KPiByKTsNCj4gICAgICAgICAgICAgICByZXR1cm4gcjsNCj4gICAgICAgfQ0KPg0KPiAt
LQ0KPiAyLjI1LjENCg0K
