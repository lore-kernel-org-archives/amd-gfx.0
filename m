Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC8EC11F68
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 02:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E5861CC7
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 02:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E5861CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EFF36E12D;
	Wed, 30 Jun 2021 02:27:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB11C6E12D
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 02:27:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OA5cF8+oxOo+yOX5aQuroIvAnzsN1HOX2lCbooFZDXiP9mysavebrNF2OCD3L+lYgAdHuEbFUSfR4FtvIvpJ9kGsg12qrS/eCIAVXIwcTh1bz/nwzxrUBaY5X99q6DdgeOCnfvJHcwmzDrTCoQ7KhtDbycKxxEo+cEBjDyKWl5qRDF/JDp3SnzeFtDum080MN5iCUV0ZF/KSo0cN55ZSC4N+alUuhUkqxCoot65Hm0JXI37q13h/KRhZuR+Z8Npe0thumEoAqog9+tThoUYkXG7sDlbCCn+dtPRffeDZTZpQdTxtXcZZ+4UzA9JY0GNO3HwA3rXEPqUOTWu2aF8H9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuGbKwfXcme+CAFBMjVOt2Q+lq0cQJOvgvDZonXokuA=;
 b=SH76As0rhFL1ep9IhtgSgLJRReLkhjDr4LeoErxWT836IS42YMnBsu79D0x25GQueOXEGMiRbNTLE3PaYdjOfWOLNBoZd4WgOALOhZTminwEqeHFoVeSuh33vlcE1v4MlOny5i+bBXTa05/VfQbgvlwyAv1d04lG4MQk/ImuDGqlhCBn0Vaw1AUn9rlJsvgg5ZrSZbFo3kzf3ksLEeNyyWFslX1AcCp2RdmGx7eBuPJl2QbGLL4NE29Fk3A/ET8mDU8bEFhWv5Xw5TQsfTcfaqXajjZbTRfFc6KFylrtInOglIkaJhmmo+kuXFkxiktfu9gSALprnnWYy2nG+x+4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuGbKwfXcme+CAFBMjVOt2Q+lq0cQJOvgvDZonXokuA=;
 b=hCqSItnM+qJh7t4g/5TMUIElD0ImtllC/fBR1/qMs1H4y/R7cmAyzBfr95QoyGnFuXewyy2pXzjyIgBoM0LJjCZHt9QiCy2rebwzWb27W3HjTvA9HdMTdQA3KcZaB+/XNAVxJEWL0TQ9nIt8XbOFl4somuZcaS6j7Y2exXN8bUU=
Received: from DM6PR12MB3035.namprd12.prod.outlook.com (2603:10b6:5:3a::24) by
 DM6PR12MB4880.namprd12.prod.outlook.com (2603:10b6:5:1bc::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22; Wed, 30 Jun 2021 02:27:18 +0000
Received: from DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::7d47:ce8a:ac44:6eb]) by DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::7d47:ce8a:ac44:6eb%3]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 02:27:18 +0000
From: "Wang, YuBiao" <YuBiao.Wang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay
Thread-Topic: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay
Thread-Index: AQHXbMvHyqExnMI5kU2HA84q+AEmkasq1qCAgAD9FZA=
Date: Wed, 30 Jun 2021 02:27:17 +0000
Message-ID: <DM6PR12MB3035D002BA2E14DA21A121F8E5019@DM6PR12MB3035.namprd12.prod.outlook.com>
References: <20210629094719.1912299-1-YuBiao.Wang@amd.com>
 <fcfff6cb-2274-6daa-a76a-f75d4ac5cca0@amd.com>
In-Reply-To: <fcfff6cb-2274-6daa-a76a-f75d4ac5cca0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-30T02:27:14Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b8db5684-3db9-4c62-9e0c-b4212a1474ce;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6886c244-1382-43fa-6038-08d93b6e94e9
x-ms-traffictypediagnostic: DM6PR12MB4880:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB488035D012990E96D3430B28E5019@DM6PR12MB4880.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NP9C2ESyBHiZzdbLfWe5k0O0N3lmXe5nD8lDiX0juj07de3SCj8lTDEIIfi5vBXD59Zx8mP1xdsH0l+kyFyI6JShQmq2R8MCgPjz+kjCDS2ecsuxTJmYogOIXtaregkmTDZ3KcqCHq6M8J3I49SM3ufmCAo0SUHpWTxrzpZvrSLalF807uUbPKlXuA/DPzFeq0rLgWgLtRka3GFo2fkBZpNQo4rDMctKWFBWpxR5O31xbVfPttKCrOArxPii2+SdTjKRBZnu6lFEFyW6oYFhKUhat7wQ653LQ3iZTQctCBdgSvXatCTKGqYcC1ShCxQZKDyA16HYW+rPqztiZaohVtvKwlnyFA+Z1Z7j5nv/Au3dzKgMHNukNbdjHnAogOCvAkHy+1wnUhJVqONM4dvm6PhOeI8SWdZn26YHEcqR1OYWP8fLd6XRSgzFold/sToXL15/l/EEDRnkqBxUIaNtnA4nKEB1mjMQF7omYBsbI2IE7Tumqq/TpaHH/qOeZDqLoGvDIDfbNc+s54utWCdKN9EAoY0/ab1VoYTx1RdlChJGnrLCYdoi+02Noqyi3ACkb+IUdOQdOAoCTVFjAixlgwg4Doq4RJrFtzaIM4qZ78hx1DlN/YZMYjpC8Av+WrDuaqwKo8LkplIwfui3e7RtVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(186003)(38100700002)(55016002)(33656002)(122000001)(86362001)(478600001)(5660300002)(26005)(9686003)(71200400001)(53546011)(6506007)(64756008)(54906003)(110136005)(8676002)(316002)(2906002)(52536014)(4326008)(76116006)(83380400001)(8936002)(66556008)(66476007)(66946007)(66446008)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXI1NjhWd0FoVTVOaGdtNytpTG5zUDc4aUJXZEtHeFl4YlJFZ3V0aDlYT0dC?=
 =?utf-8?B?Zkw2NmZTQUVlRHBHMWJ4dEVQT1IydFhyRFRaYXFmUDhSRkVLUzIvVmo1WXRu?=
 =?utf-8?B?bFRlL1dCTU0rdWxTNzVsV2hXOG91NWJzZCtpakxjZS9oZU5WdWpQSmZtUmtB?=
 =?utf-8?B?ektrOGpXdW1lNmdnRTFncEtLak13ZFBUZ1dlblBNVnZVS0MyWXBPemRja00y?=
 =?utf-8?B?cEdWMHB5ZS9jK0VCNFFIUWx3aExiaVllTHRqLzB0K0xJODlQbmNPYmdwZmxM?=
 =?utf-8?B?Z0dXYW9iU3ZqSXBocUxjZlVuTlJnZ0NWTWgzelUyaElHQ1hxa3BSNVlsdzk3?=
 =?utf-8?B?dExLN3l6dXRTRTVNTnZ5dVdjYTF2UUIxWHNTRlhKZU00ZDVvVG1OUkE5QVNq?=
 =?utf-8?B?akVUQjIrTUJBWENDM0k1emRJcWFnVXVpTkNsdndHY3BFcVM1ZmpKZzE5dkZp?=
 =?utf-8?B?WHVXL3pCR1c3MjBvd1FmeGR1M2h6aGFEY2IyZXBPZXBvbFp6eVlNZEY2ZC9K?=
 =?utf-8?B?SFNPcllzOE82Zy9yYkZkN2Q2M0ZQUUJjOXJXOGNwM09QR3VrN1BsaER4NUFo?=
 =?utf-8?B?c1hLcENNK0RIQUN0L2d5U3lnaklHakY4ckg3OS9haUtZblBrNStTMHhWTUNG?=
 =?utf-8?B?Z0xGbDZMQnp0Si91ZkVlTENnMkpIelIyNDNzWFkwNEt5LzF2eFJuZEo5MzFQ?=
 =?utf-8?B?SnBueVpaMFE4eEcwTDhpSVlObU0zY05HbzVGNlduVFhQNVJXMmVrc0RrbjhQ?=
 =?utf-8?B?aUpUSG81L0NLcFlsc1VNQ1k0a1l4NmNQRGh6VkswdHV3a1AvRUxiTElyRFNy?=
 =?utf-8?B?T3FySFBiK2lBdEMwK244M3lpQTVLa0lCZVU3ZUNudllBOS8vQ2d4cEZuekEv?=
 =?utf-8?B?bVFPVDNnaW8zcEpBM3hsa1psb0s5WWFHa28zYlBid2g5UU81MTI2V3BsRlBr?=
 =?utf-8?B?MDJQdmk2U0hHU09aS3RJNGVZOUdJZW9GMEJTNzVHR3U3L1JOb1NhWjFpM0Zw?=
 =?utf-8?B?WGI1cHFZdm9GWVlrVC8zMW5od0c4NUN1MmQ0azFDR3V2VUgwNzU3YmowZjN3?=
 =?utf-8?B?T1UxOTU0dkZ2aElod2NjalllMERqTWxzQ3JwYSsrMUxVSHdkQ2hjcWJrajZX?=
 =?utf-8?B?ZTdBK1gydCt2ZEVGdnlKbDJRRmNzNk12emNBd2thOUJwZ2x1UWtnREJOT1lz?=
 =?utf-8?B?eTZXMDUrU0NobzQ3RmNnRmYwVXJXcmdNMEUwb2FkdUI3K0x4TkJQY3g3M3Z5?=
 =?utf-8?B?dS9XQXpBbmRvRUswZ080Ulh1VGVwMFgwWFFNTk5TZzFpdXBuK1o5cWlNazdV?=
 =?utf-8?B?ekNtbGZiL0U0MUZDZk82QWNWS2JBelJHbFMzMVViRmpqTldueHIzZFA2SVQr?=
 =?utf-8?B?K1cvRmdZT3BONWdaendoTXh0K3JmUWw5TkVYR2lTOGV1eHFNR3VWYVQvdGJn?=
 =?utf-8?B?TkV5WjNGWlEzcjRsQ1RhMzE4ZzZKVFM3MG5maFZiQUtCa1BhNXloUWZORWk4?=
 =?utf-8?B?NCsyQXB3VGlBbFVGc1N0OHVWYis3T1JSdit3eU1VYm9ZWE1EbXZrNEpod3l4?=
 =?utf-8?B?cXVOdC8zaUU2YWZHR3ZsYW1zQXg5VThHQjlrU3o2VUxvUTNGSGp3TFdYT2I0?=
 =?utf-8?B?R1EzdE9rL2wyMFRwMGorOU5HblFEVXRSejZWV3pPWkE3YWpIdWlTd1pxKzBE?=
 =?utf-8?B?VExMc0dPdWFGR05yNWxMU0lxeVA2NWtzUnVEQUU4UGRwVmhyOHp0QkxqMndU?=
 =?utf-8?Q?4zL/W48u9CAg69hGI/9bPp4wK9n5hYYkWvnUkoO?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6886c244-1382-43fa-6038-08d93b6e94e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 02:27:17.8370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A3OKwh5CvDcIIzuEfAkDE0TuzubUAnI1fftK7dfpKdU8on6i/JLMxBbG/eJUh5Ze+lBVakqEwZk5rKKo5vFICw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4880
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGVsbG8gQ2hyaXN0aWFuLA0KDQpUaGFuayB5b3Ug
Zm9yIHlvdXIgY29tbWVudC4NCk90aGVycyBoYXZlIHN1Z2dlc3RlZCB0aGF0IGl0IGlzbid0IG5l
Y2Vzc2FyeSB0byBrZWVwIGNoZWNraW5nIHN1Y2ggYSBsb3cgcHJvYmFiaWxpdHkgaXNzdWUgYW5k
IHdlIG1heSBsZXQgaXQgZmFpbCBpZiB3ZSBjb250aW51b3VzbHkgaGl0IHRoaXMgY29uZGl0aW9u
LiBTbyBJJ3ZlIHNlbnQgYSB2MyBwYXRjaCB3aGljaCBjaGFuZ2UgdGhlIHdoaWxlIGxvb3AgaW50
byBhIG9uZS10aW1lIGlmIGNvbmRpdGlvbi4gQ291bGQgeW91IHJldmlldyB0aGF0IHZlcnNpb24/
IEkgYmVsaWV2ZSB5b3UgY291bGQgZmluZCBpdCBpbiBhbm90aGVyIHJldmlldyByZXF1ZXN0IGVt
YWlsLg0KDQpUaGFuayB5b3UuDQpZdWJpYW8gV2FuZw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4g
DQpTZW50OiBUdWVzZGF5LCBKdW5lIDI5LCAyMDIxIDc6MTYgUE0NClRvOiBXYW5nLCBZdUJpYW8g
PFl1Qmlhby5XYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6
IEdyb2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT47IFF1YW4sIEV2
YW4gPEV2YW4uUXVhbkBhbWQuY29tPjsgQ2hlbiwgSG9yYWNlIDxIb3JhY2UuQ2hlbkBhbWQuY29t
PjsgVHVpa292LCBMdWJlbiA8THViZW4uVHVpa292QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBYaWFvLCBKYWNrIDxKYWNrLlhpYW9AYW1k
LmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBMaXUsIE1vbmsg
PE1vbmsuTGl1QGFtZC5jb20+OyBYdSwgRmVpZmVpIDxGZWlmZWkuWHVAYW1kLmNvbT47IFdhbmcs
IEtldmluKFlhbmcpIDxLZXZpbjEuV2FuZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAx
LzFdIGRybS9hbWRncHU6IFJlYWQgY2xvY2sgY291bnRlciB2aWEgTU1JTyB0byByZWR1Y2UgZGVs
YXkNCg0KQW0gMjkuMDYuMjEgdW0gMTE6NDcgc2NocmllYiBZdUJpYW8gV2FuZzoNCj4gW1doeV0N
Cj4gR1BVIHRpbWluZyBjb3VudGVycyBhcmUgcmVhZCB2aWEgS0lRIHVuZGVyIHNyaW92LCB3aGlj
aCB3aWxsIGludHJvZHVjZSANCj4gYSBkZWxheS4NCj4NCj4gW0hvd10NCj4gSXQgY291bGQgYmUg
ZGlyZWN0bHkgcmVhZCBieSBNTUlPLg0KPg0KPiB2MjogQWRkIGFkZGl0aW9uYWwgY2hlY2sgdG8g
cHJldmVudCBjYXJyeW92ZXIgaXNzdWUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFl1QmlhbyBXYW5n
IDxZdUJpYW8uV2FuZ0BhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjEwXzAuYyB8IDEzICsrKysrKysrKysrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
MTEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92MTBfMC5jDQo+IGluZGV4IGZmN2U5ZjQ5MDQwZS4uMTkxYjllM2VlM2Vh
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KPiBAQCAtNzYx
MCw2ICs3NjEwLDcgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfc29mdF9yZXNldCh2b2lkICpoYW5k
bGUpDQo+ICAgc3RhdGljIHVpbnQ2NF90IGdmeF92MTBfMF9nZXRfZ3B1X2Nsb2NrX2NvdW50ZXIo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgew0KPiAgIAl1aW50NjRfdCBjbG9jazsN
Cj4gKwl1aW50NjRfdCBjbG9ja19sbywgY2xvY2tfaGksIGhpX2NoZWNrOw0KPiAgIA0KPiAgIAlh
bWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIGZhbHNlKTsNCj4gICAJbXV0ZXhfbG9jaygmYWRldi0+
Z2Z4LmdwdV9jbG9ja19tdXRleCk7DQo+IEBAIC03NjIwLDggKzc2MjEsMTYgQEAgc3RhdGljIHVp
bnQ2NF90IGdmeF92MTBfMF9nZXRfZ3B1X2Nsb2NrX2NvdW50ZXIoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpDQo+ICAgCQkJKCh1aW50NjRfdClSUkVHMzJfU09DMTUoU01VSU8sIDAsIG1tR09M
REVOX1RTQ19DT1VOVF9VUFBFUl9WYW5nb2doKSA8PCAzMlVMTCk7DQo+ICAgCQlicmVhazsNCj4g
ICAJZGVmYXVsdDoNCj4gLQkJY2xvY2sgPSAodWludDY0X3QpUlJFRzMyX1NPQzE1KFNNVUlPLCAw
LCBtbUdPTERFTl9UU0NfQ09VTlRfTE9XRVIpIHwNCj4gLQkJCSgodWludDY0X3QpUlJFRzMyX1NP
QzE1KFNNVUlPLCAwLCBtbUdPTERFTl9UU0NfQ09VTlRfVVBQRVIpIDw8IDMyVUxMKTsNCj4gKwkJ
Y2xvY2tfaGkgPSBSUkVHMzJfU09DMTVfTk9fS0lRKFNNVUlPLCAwLCBtbUdPTERFTl9UU0NfQ09V
TlRfVVBQRVIpOw0KPiArCQljbG9ja19sbyA9IFJSRUczMl9TT0MxNV9OT19LSVEoU01VSU8sIDAs
IG1tR09MREVOX1RTQ19DT1VOVF9MT1dFUik7DQo+ICsJCWhpX2NoZWNrID0gUlJFRzMyX1NPQzE1
X05PX0tJUShTTVVJTywgMCwgbW1HT0xERU5fVFNDX0NPVU5UX1VQUEVSKTsNCj4gKwkJLy8gSWYg
Y2FycnkgaGFwcGVucywgY29udGludW91c2x5IHJlYWQgdW50aWwgbm8gY2FycnkgaGFwcGVucw0K
PiArCQl3aGlsZSAoaGlfY2hlY2sgIT0gY2xvY2tfaGkpIHsNCj4gKwkJCWNsb2NrX2xvID0gUlJF
RzMyX1NPQzE1X05PX0tJUShTTVVJTywgMCwgbW1HT0xERU5fVFNDX0NPVU5UX0xPV0VSKTsNCj4g
KwkJCWNsb2NrX2hpID0gaGlfY2hlY2s7DQo+ICsJCQloaV9jaGVjayA9IFJSRUczMl9TT0MxNV9O
T19LSVEoU01VSU8sIDAsIG1tR09MREVOX1RTQ19DT1VOVF9VUFBFUik7DQo+ICsJCX0NCg0KVGhp
cyBjb3VsZCBiZSByZWZpbmVkIGludG86DQoNCmRvIHsNCiDCoMKgwqAgY2xvY2tfaGkgPVJFQURf
Li4uDQogwqDCoMKgIGNsb2NrX2xvID0gUkVBRF8uLi4uDQp9IHdoaWxlICh1bmxpa2VseShjbG9j
a19oaSAhPSBSRUFEXy4uLi4pKQ0KDQpBcGFydCBmcm9tIHRoYXQgbG9va3MgbGlrZSBhIGdvb2Qg
aWRlYSB0byBtZS4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KPiArCQljbG9jayA9ICh1aW50
NjRfdCljbG9ja19sbyB8ICgodWludDY0X3QpY2xvY2tfaGkgPDwgMzJVTEwpOw0KPiAgIAkJYnJl
YWs7DQo+ICAgCX0NCj4gICAJbXV0ZXhfdW5sb2NrKCZhZGV2LT5nZnguZ3B1X2Nsb2NrX211dGV4
KTsNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
