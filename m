Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D0DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 17:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78CEA61248
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 17:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 78CEA61248
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C5FC6E91B;
	Thu, 18 Nov 2021 17:12:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48EF76E91B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 17:12:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRZ65Uq25q6Feib/MXWlMLiHxTKYaSwi+3zbE494htIWtW/6A7dvNqKoi8iJQIrc8/H8x+XgAZb3E3BvRWoneTInpuj8n3XBNqvuKBOEYYKZ4D4VtrU/XfPXRYfqha9qPUBHhtIvE/Gc6Me89AXG5r+dP0hnSEf3FvOdHjBfTmWEKIR3tsOznUTu4Dkqmhg4+Qenyk5Cohjn6Oh8lLO4RHMqpcrUvzepqQLoQZEEHZa7nwMabHpUs0e4NDWP4WVVHXW5/f/Ykm/NzUqoyHHEWm9+PoBnWm6xMQV/MPXPyPtp2bwQ9MTvub2+9mgDoaq+a8Cyn5sw+VDd5FpB9VSGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cU5ZrqOhDdBLnrFijgQA6+hCbgmhC5YnaFQSJojIQGM=;
 b=Jbwgp+uLkVTPPoKYdSNVR8rieK+wRZe+mpX3h5KU4N8HMfx2EaQ0jU9S/XNW74l5z4mpNiVP2X8SCaqRNQEmnI5pPvNA5tp9QgbiL3FDA1ynEhe6EbXxT9N7bMhL1JT+VbwQLQS40yz41GbKBKkGvKOYse8Ki++o6CCPdf9awUM1K7nYCKlLHSIeU6F8FATYthbR5/5fFnWpxhgDPf9EcK+pHNiKoSlgI+9+pK+re4Pl7SGXQWZTvYItQJipfkv5ubZcQLh1BBfslhtbRTQabO3qJJZJCGQzYdWU69Km9MMbFGTxCFz55Gl707Q505WEZvKoVkiVDalfFO4BGKiUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cU5ZrqOhDdBLnrFijgQA6+hCbgmhC5YnaFQSJojIQGM=;
 b=SB0MTr9Lm3T/2iDHXK6KCWbRwEsfvrLgSvgVokn0YGmfHppraU/lQwEo5FULp2lFbE++1IEpZ3OOs5Qb9uB8qWOn6bwNXDzKAXwOxejjq5RE/Ko0AQlOtMALlsKgSfrpEm+uuogBZ3P7PI6QkgXiQQ4EyycbA03o6B0+BmsSqzE=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 17:12:29 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::f8f5:5c09:6c41:e962]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::f8f5:5c09:6c41:e962%9]) with mapi id 15.20.4669.015; Thu, 18 Nov 2021
 17:12:29 +0000
From: "Ma, Leo" <Hanghong.Ma@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/display: Drop config guard for DC_LOG_DP2
Thread-Topic: [PATCH] drm/amd/display: Drop config guard for DC_LOG_DP2
Thread-Index: AQHX3JzDx4Ve4IAZBE2Owv+Cxri9xKwJgsIAgAACMIA=
Date: Thu, 18 Nov 2021 17:12:29 +0000
Message-ID: <DM4PR12MB50382AA77F2334F51D3B0498F19B9@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20211118165302.15821-1-hanghong.ma@amd.com>
 <CADnq5_M1dPi69MpJ1naoC3SPQZzArfGYMeJbFmu_UG6Xhbi=DQ@mail.gmail.com>
In-Reply-To: <CADnq5_M1dPi69MpJ1naoC3SPQZzArfGYMeJbFmu_UG6Xhbi=DQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-18T17:12:27Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=90632bc9-7e9c-4c7d-b74f-fdcf5573e478;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63de6cc5-f10c-4771-377b-08d9aab699e5
x-ms-traffictypediagnostic: DM4PR12MB5054:
x-microsoft-antispam-prvs: <DM4PR12MB5054F6AA34A342ABAFC86A8FF19B9@DM4PR12MB5054.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: axNWdsZk46aGaHNsuOKzFxK7BZzqTAE4PCrqhJrqoegC8NdLwKjUh0xs0dQZdqRHgtHROYFgPsJf7ujRY/j+E3M3AcCcOzrZkpiM7phaiXh+CS6D7XTLAgNMSXesR6WiJavUQ5gEZdXthtf+vaGCelBWMZKN2hIAKKqU5GLrW9ff4A4ZUplG4qrRwnag+1CoSl8dIkfuD1LT5loRMkRfvQGlh/9oIhjefDgY68ZEI1psX8MxV+B4zRly7b174KV0iyvaz2kdR40gNf5F5ecEnjL7oP0NPgjOYg7hvwTSJdUPKTS6hK502lDOvZQ1i456dPM+HjYoUJ8N+wh13Uc6s/p5PG5WUOj704E1YoK+ohDOUMiUiB1veDyH/nuhb9vDOUnI0PeZ2jtjKKem385ZZP/LIoNZcTOVIwJJoJnyut9sO4bHnmDrISrVWVGJ0hxUS2Z0d8ACfPZm8VnLpxqFUPqTiW0QuZkNG35Vu6Hqu1vWKBKrKVCc8dF0kMzinau6IY17p6hCUz/fbOvDirF1yE1OsFisYLuWHFkpkLfP6lhRXMuH87l2mWx4yW/D2if2BbLoWCD2gflAtVZOLjMF9Mg77F89K2+bG8qsIwY++h0un5E2yTC19m09rpnkT+0Mz0D64ubS8Fl/IgamYFn6OlSxvVBNHdP4q8v2jroMiqRG0Wj9MWS6t1seZUI/t6Oi1WyzdP8cOfUbZg8b0SW3OQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(38070700005)(122000001)(8936002)(4326008)(8676002)(52536014)(83380400001)(6506007)(186003)(53546011)(26005)(64756008)(54906003)(508600001)(7696005)(316002)(9686003)(76116006)(66446008)(66476007)(6916009)(66556008)(86362001)(2906002)(55016002)(5660300002)(38100700002)(71200400001)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzVLVnpQUHFnczRmdHRyYWllTkFzb0pHOGQ4SEJqZkxXcGVDazVyVXZpOWpk?=
 =?utf-8?B?L0xFZTZ3RHBpYWpwVjMwZVZ2TFpKRVQzSTUySzUydU1iUzlCWVgyZjFrYXov?=
 =?utf-8?B?b1p1M1JzcXAzc21zdWVnMGY1MFNVSCtSTzNrSlE1UDVvcTdhQkR3cmhFR0NT?=
 =?utf-8?B?RnpUUGJWaWkwNXFmbk1Uc2lQSmg0N3hmSm9UNWtzQW9HWjJzSXZhdmhkMWVu?=
 =?utf-8?B?MDU5MThJTEJsSlI4cE1MRWQ3TnVzVGxVa1dBb1AydGdLUDMxWHR3amtkK29T?=
 =?utf-8?B?d0plc1ZXckhFbFN4QU1Edm1Sazl4K1Zkc0g4Q3RVaWM4OFh2Qm1KeWFQcE5V?=
 =?utf-8?B?RFFSaGZjTTlEbUtpY1ZWcFM0VXE5Mm43dU9MeGMrOFgwbkZDU1Bpd0JGNk4r?=
 =?utf-8?B?WExsTkxMamRUUkgvR0VOZm9scUtibUlWZG82U2xlMERJaGs3bGVVa2VWMFp2?=
 =?utf-8?B?VnpwWUdRYmhCc1l4dnRja3dmMldvZ3g1Zm9MRlJ4VWVQSmdXMFl0RjRzS3Rx?=
 =?utf-8?B?QlAxK0NZLzdWb2lTK3Bkalh6NHA3enVwaC83VGFLRktka28wckRZMjNKWDNO?=
 =?utf-8?B?UVc4ajcrTVJUV1ByNTVjN2J1bllEYktFOTR0c0dyS2lteDRMYTdyWXNQSDJY?=
 =?utf-8?B?cldGVW9IUU40Sk1xOEV5MmNZcXVEQjQvTzFhMEFUekd5NVdXdXE4V2tSODlt?=
 =?utf-8?B?UnNqVUp2cVlrdXNQOXJSVlEydkcyQWN0SUV0Um1aRE1iVDZGdVJLeElZd2t0?=
 =?utf-8?B?ZThNQ09JdWNaUHFSZmtrUVltN3hOUWRvcnNxOEQ2NGsza0lXZ1FKT2lnNGU2?=
 =?utf-8?B?U3g2bVFsYUdMS3FHU2lWbDdUSTFGRldoa0hxZXlVaHBXTm85TTNidGxKWEp3?=
 =?utf-8?B?OVBCSFhEZ2VqR1Boek53VTE5YVhUTlpmYUVldFI1REFUMVh1Wk5BUHJRKzRI?=
 =?utf-8?B?bTBuanU2emR3ZXlRbEdKdGxua095aGhOZVdWRFZwUGdIdHMwaHpuOFNCS1ZH?=
 =?utf-8?B?Q1hkU3pxZFlrTHlXaVg0bU9JZFdNNUxwNExEbFdSM2NEVkJ0bTV1OVF6b0ZJ?=
 =?utf-8?B?emEwK0w3YjlwNWZ0clZYUlJDTnFncmxrdzR3TDlqQVQ0MVBlOG1YWndpajA5?=
 =?utf-8?B?dzBlN1Mxd0kzS2pSNmFNOUVuVGVhanVPanJQUEJKZ283VFovTUt0Tkc5OUJU?=
 =?utf-8?B?TTAzMkR5T2VtVjBRTEU1ZmZXR1NtNDJMTjR2cnBERXhTN0lrcTRYN0paaGVn?=
 =?utf-8?B?YnloU0ZKL09DSlBWREkzY0tKUXkrMGxvT3hlWFpReDZDTEppUGs5ZzArQ1BH?=
 =?utf-8?B?T2QvU0pQQ2VhOUNaK0Q4QmpJd0FGTUdEY1JJa0MycWVEREIxOVR6cnJqY0dR?=
 =?utf-8?B?eDFDWEo5WDc0SGhTUDdCYnQxMWhEQld1U25vWGtKcUVmSHQxb3RlUTlqdWZj?=
 =?utf-8?B?dzJRa05EMWNRQnJBUU13bytlMUM4RVh0UlV6c2FhcVJEdy9sNDc4U1BHdU5K?=
 =?utf-8?B?M285SHB5TDFCTFFmdk9WcXZBNWI2Z0RzbGkxTGRSM1pxSEdML1RVSGJxS1N1?=
 =?utf-8?B?NXNicUZsWXRwL0FFcVlDYzN3WFIydTNWLzZ0VWdpTUpGemNCTStjc1c4ZWJz?=
 =?utf-8?B?bmRlbmpTajlXQkFicnk5TklXcVhoc1hWNTIxV2NlNk51bzBlUlJDVFgzenNt?=
 =?utf-8?B?dHRVRzR4RTU2bDJPdUcrcDJDQi81QVpuVkRoV09VZkNUcVE3djUrK0hVek5x?=
 =?utf-8?B?M1paQzJ0QTVCMkdZZ2NGTE5obE93UktqK2RjNEM4ellBWWtjK2tueGJNMXZp?=
 =?utf-8?B?Q3c4Uzk3bTJKYnNuVVBvWlZ1aDMzN2ZRWWNsQjBUOG5pTFplTXlCd3owaXds?=
 =?utf-8?B?ZnlUMVFOTHVBSGpaWVV4Z08vdFVTaTM1TzVUT05QUldjaEJpUTZWLzlmcVBM?=
 =?utf-8?B?bDN1d1NYUHhFdjdDdk01elpGcnRsMXNnRndLbXVxWXBNTDZHNU9UeUZvMytX?=
 =?utf-8?B?NHdCRWxRWWllbE9oR0xBbzVid0JXWms2Y25zeE1vYWFmWUxFSUFlV2xQV0tU?=
 =?utf-8?B?MUkwN212OVhndWV0N0N0L3ZGWnlGMFpaNERQSUJLT2hJbnhEZnIxR0t2WUty?=
 =?utf-8?B?RU0vMy9sSVJCeWhZclE3eld5TS85bEFtRmZtcWkvRDdRS0NXZUtZa3pjOWFU?=
 =?utf-8?Q?21RnD53BFQGs3zuTwz95SNc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63de6cc5-f10c-4771-377b-08d9aab699e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 17:12:29.1505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ws6GpAWeWroOkds81xns1d+x2kmb8kj+/RS2vCrnIes22enJ/uaWLgWvt05h8fXWBz0i6mQ/9/6kkxZfCAsKhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Choi, Nicholas" <Nicholas.Choi@amd.com>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KQWdyZWUuIA0KUGF0Y2ggYXBwbGllZC4gVGhhbmtz
IGZvciB5b3VyIHJldmlldw0KDQotTGVvDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gDQpTZW50OiBUaHVyc2Rh
eSwgTm92ZW1iZXIgMTgsIDIwMjEgMTI6MDIgUE0NClRvOiBNYSwgTGVvIDxIYW5naG9uZy5NYUBh
bWQuY29tPg0KQ2M6IEthemxhdXNrYXMsIE5pY2hvbGFzIDxOaWNob2xhcy5LYXpsYXVza2FzQGFt
ZC5jb20+OyBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgQ2hvaSwgTmljaG9s
YXMgPE5pY2hvbGFzLkNob2lAYW1kLmNvbT47IFdlbnRsYW5kLCBIYXJyeSA8SGFycnkuV2VudGxh
bmRAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvZGlzcGxheTogRHJvcCBj
b25maWcgZ3VhcmQgZm9yIERDX0xPR19EUDINCg0KT24gVGh1LCBOb3YgMTgsIDIwMjEgYXQgMTE6
NTMgQU0gTGVvIChIYW5naG9uZykgTWEgPGhhbmdob25nLm1hQGFtZC5jb20+IHdyb3RlOg0KPg0K
PiBbV2h5ICYgSG93XQ0KPiBJdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8gZ3VhcmQgRENfTE9HX0RQ
MiBieSBDT05GSUdfRFJNX0FNRF9EQ04sIGFuZCANCj4gdGhpcyBhbHNvIGNhdXNlZCBidWlsZCBm
YWlsdXJlIGZvciBhbGxtb2Rjb25maWc7IFNvIGRyb3AgdGhlIGd1YXJkIHRvIA0KPiBmaXggdGhl
IGNvbXBpbGUgZmFpbHVyZTsNCj4NCj4gU2lnbmVkLW9mZi1ieTogTGVvIChIYW5naG9uZykgTWEg
PGhhbmdob25nLm1hQGFtZC5jb20+DQoNClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+DQoNCkF0IHNvbWUgcG9pbnQgd2UgbWF5IHdhbnQgdG8gcmV3
b3JrIHdoYXQgdGhlIERDX0xPRyBzdHVmZiBtYXBzIHRvbyAoZS5nLiwgdXNlIGRldl9kZWJ1ZyBv
ciB0aGUgbmV3ZXIgZHJtIGludGVyZmFjZXMpLg0KDQpBbGV4DQoNCj4gLS0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9sb2dnZXJfdHlwZXMuaCB8IDQgLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9sb2dnZXJfdHlwZXMuaCANCj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9sb2dnZXJfdHlwZXMuaA0KPiBpbmRleCAzNzBm
YWQ4ODNlMzMuLmYwOTNiNDljNWU2ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2luY2x1ZGUvbG9nZ2VyX3R5cGVzLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2luY2x1ZGUvbG9nZ2VyX3R5cGVzLmgNCj4gQEAgLTcyLDkgKzcyLDcgQEAN
Cj4gICNkZWZpbmUgRENfTE9HX0RTQyguLi4pIERSTV9ERUJVR19LTVMoX19WQV9BUkdTX18pICAj
ZGVmaW5lIA0KPiBEQ19MT0dfU01VKC4uLikgcHJfZGVidWcoIltTTVVfTVNHXToiX19WQV9BUkdT
X18pICAjZGVmaW5lIA0KPiBEQ19MT0dfRFdCKC4uLikgRFJNX0RFQlVHX0tNUyhfX1ZBX0FSR1Nf
XykgLSNpZiANCj4gZGVmaW5lZChDT05GSUdfRFJNX0FNRF9EQ19EQ04pICAjZGVmaW5lIERDX0xP
R19EUDIoLi4uKSANCj4gRFJNX0RFQlVHX0tNUyhfX1ZBX0FSR1NfXykgLSNlbmRpZg0KPg0KPiAg
c3RydWN0IGRhbF9sb2dnZXI7DQo+DQo+IEBAIC0xMjYsOSArMTI0LDcgQEAgZW51bSBkY19sb2df
dHlwZSB7DQo+ICAgICAgICAgTE9HX01BWF9IV19QT0lOVFMsDQo+ICAgICAgICAgTE9HX0FMTF9U
Rl9DSEFOTkVMUywNCj4gICAgICAgICBMT0dfU0FNUExFXzFETFVULA0KPiAtI2lmIGRlZmluZWQo
Q09ORklHX0RSTV9BTURfRENfRENOKQ0KPiAgICAgICAgIExPR19EUDIsDQo+IC0jZW5kaWYNCj4g
ICAgICAgICBMT0dfU0VDVElPTl9UT1RBTF9DT1VOVA0KPiAgfTsNCj4NCj4gLS0NCj4gMi4xNy4x
DQo+DQo=
