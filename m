Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A52C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 15:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F3E310E468;
	Tue,  9 Jan 2024 15:10:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C412410E468
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 15:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kejojTtzbOQX+3dnUMO5dl8VFeqWT+zevivqkKK/9yqkt7n2aBPRw32c9cf73klc5h3QX+f7F3Z67RNSWnTOWLOjBghuuWPrhG3Xd5BhqTqOSt981vbR3lFYiAblHIDQzwAfecDILsE1THWjWEsn1AQDHxxOuRiEW07bKijYkjzHzeA+uGiQl7WTmHyc3TgsOtu6LEWA93tdvWWNl9LLqbtOI5nZNzA4yQWGxnCGJJNF4+8btnPWqrTO+6x5MFOhUojkrxBvUouDs9YcPmqUFOF5DM9JCPu4eRD39Su7iFvYeO0R7V+sQMrMV3Lqq/F9z/Mw4xylaWLJ3OwMQNPwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLhvuKRcrF9Ok9X/guYzlj3N9o9K0DNx5YN/IlgDJ/M=;
 b=ZW1ndccINnAQgeieG0Pfb5MUh/eW6R40ihQCu7ZDBIU9Be7zvtSiLDJ6uFhdLKvZz+4O7cxmiswdKwhr3oS4Bcip7x/MrmgUIl3vpJmzTeOSTBYthxQBQJuvuP/sUtt1Gggiimcwf6weuhTce1ny6q4ciojS967gnkH0aD3Cb+mV9hFnDrdxyWO0VTVK/3oxsCyJblK/dcQN+KCKZXt5hLMDxEAlOgzRLrcwjGd5GUV35uu03nar7ZasuFegpzqdXG1onHhGo7P3kCDkvxiF7QFpDydsQmjq5phBDpN+7qTdhJ+HJUSqMtwRpBaKWuqC3QVf4XK8nqALjEoqXGph4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLhvuKRcrF9Ok9X/guYzlj3N9o9K0DNx5YN/IlgDJ/M=;
 b=1R0502Tl8KKLf1PP2W2+OzseXGgz2IiRL2yVFj15cVLf8lpPxXYb3iYMEru/S8mXx5+7+8MMbCVF99R0wvxxDVLv4nbneaxV7tITV4GhEJ5oozkMsOXj4BGTMSZ6y8MNzlTItDOdBUvyinIjR5zQYCHCJC6n61uZCZO7S38bkAE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 15:10:30 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 15:10:30 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Alexander Koskovich <AKoskovich@protonmail.com>
Subject: RE: Documentation for RGB strip on RX 7900 XTX (Reference)
Thread-Topic: Documentation for RGB strip on RX 7900 XTX (Reference)
Thread-Index: AQHaQg5xcJeFw0AC60y3NTa3oyYX3rDQfpSAgAAhGwCAAPZNgA==
Date: Tue, 9 Jan 2024 15:10:30 +0000
Message-ID: <BL1PR12MB5144D58D8EDA16731BA48102F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <oCYzPIgXFcQ3jdqAKY2upsY5qq23yOba06RkrzD5Bfai97jMWxGvBsaOiKi1k5oZvNg7IoJLE6jAA6BLGFXt08WbBEtdgJA4snn7khZ0JFM=@protonmail.com>
 <BL1PR12MB514454D5E625F71BB0E6A8B6F76B2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <xgXz7D0Xgjysg4ZLJpfd1ryjeEoM2fKFn9W5WIGBGxc6WSxcYxTZPzwKRNbqPYcDIf8P1zuDr5SYqSvl36GqzW8TimxvO7BGDq5S_zv8v3g=@protonmail.com>
In-Reply-To: <xgXz7D0Xgjysg4ZLJpfd1ryjeEoM2fKFn9W5WIGBGxc6WSxcYxTZPzwKRNbqPYcDIf8P1zuDr5SYqSvl36GqzW8TimxvO7BGDq5S_zv8v3g=@protonmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ad66582f-e161-40e8-866a-7b17c8175efc;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-09T15:03:57Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BL3PR12MB6641:EE_
x-ms-office365-filtering-correlation-id: 2862f076-ddba-4942-9603-08dc11251ea3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1e8zWYd1GkIEu4pzsi4GUMCsM2jATzX08m6Due3eC5ApRnyt8XzD1u0QJgY9zPwa0JtKTSf6is8r5QLbPlwIZc6SOy4JF/BCoDQZXUvnynGnDX3OUYa0DmTe/15QSnUgdk6apGG8QRSW2bbTGzZTIP5VHLUSVNspbLTlsTUYrjOgLS9v8BBSSqpeYqoBbCYM+CEvrZGrgQOH0Dm+m+bqSfhsQ9lxBeCIkiKNdiaJ17WsmC67mh85B6WwFhVdkqD45XfgUUYnZezeBp7eULiw6v83vz24uIQzBJ0b+r0aR7PAIjks+WRg9t0d1EE1eODQmFSKDCb05VBVvEudXNLVTNaS2l+41Atk0ZaHwON4zd8SKfMU/PjpOvHG/BB8AkO7d/XYjgpwEMfAGlJK1uqmxRUhKm4qCQpbnHE9aTBpZsbYp8ToGH/+5VE+GOXjX4GXGAYhP7P90yPATkmBHPlDZ84VZIF6Stzuktx9gHq3+bfHmsjEtv8jMiyeTrk6albErSKYcE1byqBDnXEqpPqP2LU6+F1b2I3C+L3vtvCabY3/jkDCjDKFp1eXh5D2iIMfpxXuy5ENALf4cxW45yagtPsSeqHCAzcxYZM3NiQiWf8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(71200400001)(316002)(7696005)(4326008)(52536014)(122000001)(38100700002)(66556008)(64756008)(76116006)(8936002)(66946007)(6916009)(66476007)(53546011)(9686003)(6506007)(66446008)(8676002)(83380400001)(26005)(966005)(55016003)(478600001)(5660300002)(2906002)(38070700009)(86362001)(41300700001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ky9LVTRLRHRvOXBuTStKWVpiL1Q0SWF5K1FVdjZYVVU3MWY1bDExTzhlMkdP?=
 =?utf-8?B?YWVOYmkrSmxRRTJKMENGYUpTT2hiNHl0K3kzZXptc1pLSWJtYmpPOGVMemQ3?=
 =?utf-8?B?VDNXMmwybmxkN0RFUEZ4OFAyQ2U0WS9VSGFOSE41QzdrL0JQVDdyS3ZraDhR?=
 =?utf-8?B?L05EcmdSTFpNZnBFU3k0eHNRTnA0QjJNUjZRTlAvL3V5ZEhkb3RJZEg3Q25L?=
 =?utf-8?B?c3ZZUkc2TVhqTDIvRkZqSTFucGMxc3RhZmxBRzg0dElRVjM4NlNzY0oxNU9s?=
 =?utf-8?B?ZXp4bXp1MjFrUTRhK3VRTXBIaEJodlovY2E5RlZnU3lnZ3Q1YTZzNkl1NkxD?=
 =?utf-8?B?M1VzU1BpdnU2ZDN2U0Z0ZXlwNVQ4bE9wbllzQ2ZEdW96S3M5OHlONHI2L3Jt?=
 =?utf-8?B?Q2NOYzRUNVZVUDREeGNkTWJaRC9BemRmWVA1YWdyb2JLK0VpdVNmSTV6SEZF?=
 =?utf-8?B?OSswNndxWmo0VGhERGg5QjhFVWxVOWhCS3BpWGpBa1V3YlBkemZmTFF3TUhr?=
 =?utf-8?B?OEFaQnZOREl5Q3ZxSlk4REt1U0NrNjdudm9KTzRHTVRVdHJtNWt1VkNNMnRM?=
 =?utf-8?B?MkNaL1BaV3NmazZsSjU5Y0ZmMVE1L003SDg2TFFLZXZ6T0dkVWlJMUlIaXoy?=
 =?utf-8?B?ZC9xU2hxZEp4QVBZb1hRV3pNUksrTXNEWUE5Zkh2VU1sZGYraGdTNlpLOFdE?=
 =?utf-8?B?bE93ZUk2REM1YmwvOTl3eHgrVVBNV2FQa2I5VkVoU0kzWHZBYnJ2U3hObGhK?=
 =?utf-8?B?cHZObWYzd1grekdEZ3RYTnFsZ255VFlBcEhLUGZOTXQ0OEJzQzBYbWpPTkZH?=
 =?utf-8?B?TjJnTWRKNzVpZC9FT2hwVERpNlYrWFN1Wk9DUzFwWml6d3ZWRUp1Kzd4RW90?=
 =?utf-8?B?WUxyZ1prblo0RU5XRlluSkVOYmZLWk0xMjZaM1pHc2wyZ1BYTHg3RW5Wd0FE?=
 =?utf-8?B?NUw5UHQzSjh3OVJVdXV5Z1BkaGgrdTZTdEhSbHpjNU9vdGVTVTJnOFVLVG9H?=
 =?utf-8?B?aE83SGRqUFJ6L1VhM0duNzVNTXhWTFlNMHNwQ0tTNHhBZmNTZDVCVFg2anlz?=
 =?utf-8?B?T3dyd1ZiWHZYS1VVN040S1h1OFFQSFVZUEI0c2swMXRJSmFlVFU0WUVobVBH?=
 =?utf-8?B?UXdEakZlY2UxV2pvejVFSk4yMXB6VjZZaEl4d25PY3VHUXVFOFI2QytXNElF?=
 =?utf-8?B?a2Z6ckw3RWpoMGF2ZDFBUTdCTzJONUpqOW12RU4yMUxDL3dzUTZhUnN3OXJ2?=
 =?utf-8?B?SHVSL0dUZ3FUWWM4ZUtHV0E2MUtROURxTVI2WUwyNkt0RjI2RmY0bWhLdkZF?=
 =?utf-8?B?d3owRHFrRXRHOU1oWkdFZTN3WU1zY3VnY3ZHck1PakpkVm1yL2lRdmlwSjB4?=
 =?utf-8?B?bjVqbnJ4VE9aV3IzL2k0eU8xcEZPVEVmVjR5cktLdW5Hd0hvU21aVEwrUUVl?=
 =?utf-8?B?WDdvbU1abEsxY3Z2aXh2dHR0dEVlTDJGbCswUXNZZ0k2djNnNkxlNTB1U3cr?=
 =?utf-8?B?ODVpVUJNVkFjeFh4SG5YTUsrT0ZWTzRJT1lFTHZtcE81ZU1SYURsaFlPVWVT?=
 =?utf-8?B?U2lrTytJQjIvRnJLWVBSWWtVUGVidmYxR1l1eDR0cDg5YjhBTEZTV3BoZ0Uw?=
 =?utf-8?B?TU1aY2REVmFQelpIeklqZ0RvNzlnTUdNbWFuY0FIVFNLc1JaOElEUEI1WEl5?=
 =?utf-8?B?ZUlHbEJmbzFtUFBlenRFeXBHbVlPRllnbXFESGh1YUZVZ240NUpBcjN1cVhV?=
 =?utf-8?B?dC9UTjBpeGpEUnBUY2lDQnRhc1duOG9SVnJmY0ZpSG8wZi9KcGpDZEFXb29r?=
 =?utf-8?B?eSsyTWdsU0ZiaFBvUGx3NG5jU050M21kaVd6aGFWYTRTUXNuV01NelpsMk9R?=
 =?utf-8?B?SFczNlJrQWlXOFV1cXJ2a3FpdTUwUENhcExkV2duTnp0eHlHWVZwKy9Nbkp6?=
 =?utf-8?B?QjRlc1IwSE1FSlBRQVFMMFVyekNpamdiUWpxUU5qcml2Vm94ajRzOUhuTU5U?=
 =?utf-8?B?eFVYN05RQmg2aVJVa2dFQ05zN2E0YXJZR0VoTEVZbzM2aWRtcnlNMDFzZitx?=
 =?utf-8?B?UlUySE9kUW5RaFpFMUJLY3lZNUN1ZllFNzRteFRUckU5UFptVE9XMDI0dS9q?=
 =?utf-8?Q?1ZyE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2862f076-ddba-4942-9603-08dc11251ea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 15:10:30.5129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPHApmY+zhsHX1J9Vbhs/f1a/VvMsjycUuPv1ppsHOcCc7iMjeIMFXerZ88F4YMYTmW8rUBSsdCfIr5tOjinQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5k
ZXIgS29za292aWNoIDxBS29za292aWNoQHByb3Rvbm1haWwuY29tPg0KPiBTZW50OiBNb25kYXks
IEphbnVhcnkgOCwgMjAyNCA3OjIyIFBNDQo+IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPiBTdWJqZWN0OiBSRTogRG9jdW1lbnRhdGlvbiBmb3IgUkdCIHN0cmlwIG9uIFJYIDc5MDAg
WFRYIChSZWZlcmVuY2UpDQo+DQo+IEN1cnJlbnRseSB0aGUgcmVmZXJlbmNlIGNvb2xlciBmcm9t
IEFNRCBkb2VzIG5vdCBoYXZlIGFuIGV4aXN0aW5nIFJHQg0KPiBjb250cm9sbGVyIGZvciBPcGVu
UkdCLCB0aGF0J3Mgd2h5IEkgd2FzIGxvb2tpbmcgZm9yIGRvY3VtZW50YXRpb24gb24gdGhlDQo+
IEkyQyBjb21tYW5kcyB0byBzZW5kIHRvIHRoZSBzZWNvbmQgU01VLCBzbyBJIGRvbid0IHJpc2sg
YnJpY2tpbmcgbXkgY2FyZCBieQ0KPiBzZW5kaW5nIHdyb25nIGNvbW1hbmRzIGR1cmluZyBkZXZl
bG9wbWVudCBzb21laG93Lg0KPg0KPiB3cml0ZVNldENNRFdpdGhEYXRhOg0KPiAqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KPiBh
ZGxpMmMuaVNpemUgPSBzaXplb2YoQURMSTJDKQ0KPiBhZGxpMmMuaUFjdGlvbiA9IEFETF9ETF9J
MkNfQUNUSU9OV1JJVEUNCj4gYWRsaTJjLmlBZGRyZXNzID0gMHhiNA0KPiBhZGxpMmMuaVNwZWVk
ID0gMTAwDQo+IDAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gRGV2IDA6IEFETF9EaXNwbGF5X1dyaXRlQW5kUmVhZFNNVUkyQygwLCAmYWRsaTJj
KSA9IDAgYWRsaTJjLmlEYXRhU2l6ZSA9DQo+IDI0IGkyY0RhdGFbMF1+WzI0XQ0KPiA0MCA1MSAy
YyAwMSAwMCAwMCBmZiAwMCBmZiBmZiBmZiBjYyAwMCBjYyAwMCAwMCAwMCBmZiBmZiBmZiBmZiBm
ZiBmZiBmZg0KPg0KPiBGcm9tIHRoZSBSR0IgYXBwJ3MgbG9ncyB0aGlzIGlzIGFuIGV4YW1wbGUg
b2Ygd2hhdCB0aGUgb2ZmaWNpYWwgQU1EDQo+IGFwcGxpY2F0aW9uIG9uIFdpbmRvd3MgaXMgc2Vu
ZGluZyB3aGVuIGl0IGNoYW5nZXMgY29sb3JzIG9uIHRoZSBSR0Igc3RyaXAuDQo+DQo+IEZyb20g
dGhpcyBjYW4gaXQgYmUgYXNzdW1lZCB0aGUgQU1EIGNhcmQgaXMgdXNpbmcgdGhlIGxhdHRlciBt
ZXRob2QgeW91DQo+IG1lbnRpb25lZCB3aXRoIHRoZSBzZWNvbmQgU01VIEkyQyBidXMsIGluIHdo
aWNoIGNhc2Ugbm8gZHJpdmVyIGNoYW5nZXMNCj4gd291bGQgYmUgbmVlZGVkPw0KDQoNCklJUkMs
IGVhY2ggQUlCL09FTSB1c2VzIGl0cyBvd24gcHJlZmVycmVkIFJHQiBjb250cm9sbGVyLiAgVGhl
IHJlZmVyZW5jZSBib2FyZCBqdXN0IGRlZmluZXMgd2hpY2ggaTJjIGJ1c2VzIGNhbiBiZSB1c2Vk
LiAgVGhlIFJHQiBjb250cm9sIGFwcGxpY2F0aW9uIGlzIGp1c3QgYSB1c2Vyc3BhY2UgYXBwIHBy
b3ZpZGVkIGJ5IHRoZSBBSUIvT0VNIHRoYXQgY2FsbHMgQURMIHRvIHRhbGsgdG8gd2hpY2hldmVy
IGkyYyBidXMgdGhlIHZlbmRvciBwdXQgdGhlaXIgUkdCIGNvbnRyb2xsZXIgb24uICBPbiBMaW51
eCB5b3UgY2FuIGRvIHNvbWV0aGluZyBzaW1pbGFyIHVzaW5nIHRoZSBpMmNfZGV2IG1vZHVsZSB0
byBvcGVuIGEgY29ubmVjdGlvbiB0byB0aGUgaTJjIGJ1cyBkcml2ZXIgcHJvdmlkZWQgYnkgdGhl
IGtlcm5lbC4gIEkgYmVsaWV2ZSB0aGF0IGlzIHdoYXQgb3BlblJHQiBkb2VzIHRvZGF5LiAgSXQg
bG9va3MgbGlrZSB5b3UgYWxyZWFkeSBoYXZlIHRoZSBwcm9ncmFtbWluZyBzZXF1ZW5jZSBhYm92
ZS4NCg0KQWxleA0KDQo+DQo+DQo+IE9uIE1vbmRheSwgSmFudWFyeSA4dGgsIDIwMjQgYXQgNToz
MiBQTSwgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPiB3
cm90ZToNCj4NCj4NCj4gPg0KPiA+DQo+ID4gW1B1YmxpY10NCj4gPg0KPiA+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IGFtZC1nZnggYW1kLWdmeC1ib3VuY2VzQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZyBPbiBCZWhhbGYgT2YNCj4gPiA+IEFsZXhhbmRlciBLb3Nrb3Zp
Y2gNCj4gPiA+IFNlbnQ6IFN1bmRheSwgSmFudWFyeSA3LCAyMDI0IDExOjE5IFBNDQo+ID4gPiBU
bzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiA+IFN1YmplY3Q6IERvY3VtZW50
YXRpb24gZm9yIFJHQiBzdHJpcCBvbiBSWCA3OTAwIFhUWCAoUmVmZXJlbmNlKQ0KPiA+ID4NCj4g
PiA+IEhlbGxvLA0KPiA+ID4NCj4gPiA+IEkgd2FzIHdvbmRlcmluZyBpZiBBTUQgd291bGQgYmUg
YWJsZSBwcm92aWRlIGFueSBkb2N1bWVudGF0aW9uIGZvcg0KPiA+ID4gdGhlIFJHQiBzdHJpcCBv
biB0aGUgcmVmZXJlbmNlIGNvb2xlcg0KPiA+ID4gKGh0dHBzOi8vd3d3LmFtZC5jb20vZW4vcHJv
ZHVjdHMvZ3JhcGhpY3MvYW1kLXJhZGVvbi1yeC03OTAweHR4KT8NCj4gSXQNCj4gPiA+IGxvb2tz
IHRvIGJlIGhhbmRsZWQgdmlhIEkyQyBjb21tYW5kcyB0byB0aGUgU01VLCBidXQgaGF2aW5nIHBy
b3Blcg0KPiA+ID4gZG9jdW1lbnRhdGlvbiB3b3VsZCBiZSBleHRyZW1lbHkgaGVscGZ1bC4NCj4g
Pg0KPiA+DQo+ID4gSXQgZGVwZW5kcyBvbiB0aGUgQUlCL09FTSBhbmQgaG93IHRoZXkgZGVzaWdu
ZWQgdGhlIHNwZWNpZmljIGJvYXJkLiBUaGUNCj4gUkdCIGNvbnRyb2xsZXIgd2lsbCBlaXRoZXIg
YmUgYXR0YWNoZWQgdG8gdGhlIEREQ1ZHQSBpMmMgYnVzIG9uIHRoZSBkaXNwbGF5DQo+IGhhcmR3
YXJlIG9yIHRoZSBzZWNvbmQgU01VIGkyYyBidXMuIFRoZSBmb3JtZXIgd2lsbCByZXF1aXJlIGNo
YW5nZXMgdG8gdGhlDQo+IGFtZGdwdSBkaXNwbGF5IGNvZGUgdG8gcmVnaXN0ZXIgZGlzcGxheSBp
MmMgYnVzZXMgdGhhdCBhcmUgbm90IHVzZWQgYnkgdGhlDQo+IGRpc3BsYXkgY29ubmVjdG9ycyBv
biB0aGUgYm9hcmQgc28gdGhleSBjYW4gYmUgdXNlZCBieSAzcmQgcGFydHkgYXBwbGljYXRpb25z
Lg0KPiBDdXJyZW50bHkgd2Ugb25seSByZWdpc3RlciBpMmMgYnVzZXMgdXNlZCBmb3IgZGlzcGxh
eSBjb25uZWN0b3JzLiBUaGUgbGF0dGVyDQo+IGJ1c2VzIGFyZSBhbHJlYWR5IHJlZ2lzdGVyZWQg
d2l0aCB0aGUgaTJjIHN1YnN5c3RlbSBzaW5jZSB0aGV5IGFyZSB1c2VkIGZvcg0KPiBvdGhlciB0
aGluZ3MgbGlrZSBFRVBST01zIG9uIHNlcnZlciBhbmQgd29ya3N0YXRpb24gY2FyZHMgYW5kIHNo
b3VsZCBiZQ0KPiBhdmFpbGFibGUgdmlhIHN0YW5kYXJkIExpbnV4IGkyYyBBUElzLiBJJ20gbm90
IHN1cmUgd2hhdCBpMmMgTEVEIGNvbnRyb2xsZXJzIGVhY2gNCj4gQUlCIHZlbmRvciB1c2VzIG9m
ZiBoYW5kLiBodHRwczovL29wZW5yZ2Iub3JnL2luZGV4Lmh0bWwgd291bGQgcHJvYmFibHkgYmUN
Cj4gYSBnb29kIHJlc291cmNlIGZvciB0aGF0IGluZm9ybWF0aW9uLg0KPiA+DQo+ID4gQWxleA0K
