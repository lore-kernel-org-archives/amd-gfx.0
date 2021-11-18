Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85596C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 13:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A6D61547
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 13:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 54A6D61547
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B4C6EBC4;
	Thu, 18 Nov 2021 13:11:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A4466EBB7
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 13:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNdg5BShoyAtgGbRB94gE2eGdCf26HpGRDTpFXymqk1tjhX5exnvLWG490cuKTOkI5V5rgdFPlrqJvUXq9Ye3qjN+5VFLzXrwPofBlP3QtBWPIK6koh+w2wGDmW7co4DHr2GrmnX8x+lY6vR4N94vlAjOoUQFnlhAXbEClFvKnoVoTk7YvIuBVLjhVujjPvItu8uLf3quNNINeuO6QMCzQQk5ZxiOe81gY79OKN+YKvhmqUgM7JGOMnYSHYbzmuuqbrp76UZeq1mdopE0qQn4n44PFvpnL7rlzTPPMnPwTkUsKn/ndQZBx7S78tX5kQqPiU03+QqluBPXbZY8DzvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xS0d7ms0ryvDNQOwsCaP0hHF5JCDHofo4GbMMkqGhVU=;
 b=UTZTIOzB8GdAdPQiVLgAE0/GhGOrylqGmlsC53fyMLRYkX+6mEx9nm2MQPyQLyZW7wk6/7ilHFYAPg2LILuX2NGloYIsxKAOAbvuCSePQ5yj3b1M7ObV4HpKLfKEoFb1vu/mSkwZk5cxkRVO2G8/e8fn9eGpWrne0vCN3rmynJfbKM6WfRAy0yuF4PMZ2Fp+kJaGAWxaTww7Ompcm48mG/Nbl7HbbKopqV7gfzAQujRjAI/kR2EZWPiyBhx+iaRjxM94BNObY3dLUA2qMfTERgumFuO4l6vh8HUnlPwvzMSjak+KfwrU2vV2TUusUTYPyVmv5MugiBBBQCxE3a+hlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS0d7ms0ryvDNQOwsCaP0hHF5JCDHofo4GbMMkqGhVU=;
 b=WsunV9ts0GOJ/AXmnmhavXeIaBi62bPVbiOZQtnBBrhdXGZuyCiA5DRYidw8ZZREWYILlzrexqnBBK19ZiAgVB3w+3jt4bXTl2ryjkb9Nl2CHW36E/q6VkIzLGrDhxH7c1KG6BOkqQUTZNkyCgc9U+ZyKbKzcUGS8o5gs6Bmhdo=
Received: from MN2PR12MB3246.namprd12.prod.outlook.com (2603:10b6:208:af::21)
 by MN2PR12MB3631.namprd12.prod.outlook.com (2603:10b6:208:c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 13:11:30 +0000
Received: from MN2PR12MB3246.namprd12.prod.outlook.com
 ([fe80::70b6:8476:4368:fd71]) by MN2PR12MB3246.namprd12.prod.outlook.com
 ([fe80::70b6:8476:4368:fd71%5]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 13:11:30 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
Thread-Topic: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
Thread-Index: AQHX3Ep0OrbJL2yYpUqCXznVALiInqwI7ECAgAA3wuA=
Date: Thu, 18 Nov 2021 13:11:30 +0000
Message-ID: <MN2PR12MB324647AA070CF7883BF70036FB9B9@MN2PR12MB3246.namprd12.prod.outlook.com>
References: <1637218976-30718-1-git-send-email-Prike.Liang@amd.com>
 <aaf39737-31da-4925-1aac-56478ad5296f@amd.com>
In-Reply-To: <aaf39737-31da-4925-1aac-56478ad5296f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9b755218-8562-4eff-9d85-1fa876d5585d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-18T11:20:41Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a904e47-300d-4c41-fe13-08d9aa94efbe
x-ms-traffictypediagnostic: MN2PR12MB3631:
x-microsoft-antispam-prvs: <MN2PR12MB36316A580AD4AC54F4989797FB9B9@MN2PR12MB3631.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /IDeOihzrpWOMbRGydJKddcN8uIXhg4E4/30FiV5Sc+xY+uTFVUJ0rW7m5jFqyer4wp03t/jANeAg+BTxvi6g2Dk0DCr5ygeyqLGGdNEvNOMRnfZJ11lXvY9yrTETeMC3Cm3Y1gyMBsq1JiPk45jlIDPNxP4AH8JsTZAzuZdsAQBfxOqlIdEprnSPl3sye5UBMt7LqTRkn3hHbsrPY0cFQiwsUZ9KSq6tYIFxaaQZL9eh5bSbEaS0F6krnq3ppV9hiHQTTqqYzTvyTIfV4oi5KB2/RnGpAyvhg6ppiG4piCIPnjNDfPlmI29ft/+vXy1fzFfBQnqQaM9YFGibQ/i080a2JRe2t6nNRmytedjrSHQa4vSuEDC0o7xiFu6cpC+7jh17yFRzoP4WqvnZJPiVw+uOg8QPjIwpCo8IaH2Dbsf+m80gIGrhJ4lfDB+vUvVcSUKsvcZDf2mdKds8aiZ6UfLylwi6LXc/XBV+O+PJUr5ckhtXETKh7+Kcl45uHOg9y67HucxBKgIaWPvveMarb3Oc/YtDODyBvSvMVAcgttpaTUYw2L4bvF7NWrkB0b/rXj5LDlY6TD/COsg2dZJAEbBsqa1XEMU26tC7GGek6PDW4tCv4Mojlrc6jSB96vG3KqZPFpnjroVopzc63JMXave//yGu2LI6vQPCdIRKXSPResLfzcPCneLAmbO8dqIAom2FBioI4s5ZWbTPH6CRE3agtWkHAEd9yoOOL1Ubj3RqnvRL6z8fIyuz55tBB9mzm5M39ZJ3pJGShTPB6qInAYNrKFkyWt21l6lWA6rj8A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3246.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66446008)(64756008)(66556008)(71200400001)(86362001)(38070700005)(66946007)(186003)(6506007)(76116006)(7696005)(8936002)(966005)(4326008)(26005)(83380400001)(8676002)(55016002)(45080400002)(52536014)(15650500001)(33656002)(9686003)(122000001)(316002)(508600001)(5660300002)(54906003)(38100700002)(2906002)(53546011)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjM0Nkw5MTRqMVRiRDFldnNWZjN3a0xtbXQvVXBJbFFHMy9XTGd4V2RiWmdU?=
 =?utf-8?B?Sk5WZ0ZqY1RMT1BvM3lrODNTTktQLytYRDIraVdKaFFNZ1EvbFpqK05ZcWk4?=
 =?utf-8?B?VmlhZ3ZrOE1kTG12cmFxU1IzdUdMaldWdzlic0UzK2twZ2VIa0YwSTJZRG9i?=
 =?utf-8?B?SGVncytxZmZ3dlVmeTJMSXg1TzhEdTgwNlVxNDhndkVWZlpmOE9KdVZlZllD?=
 =?utf-8?B?TG4rZnlQbzhuRlI5N25KamxGNEVZdk5tMVpPdWJJeGpmUTdZSEdiTjZDV3J2?=
 =?utf-8?B?bEZ1Y1V5bzV1M2QyNUxPZ3ZEd1ROaWFSK1NlVm42SXBQbFFNeklRTktnUktm?=
 =?utf-8?B?dmN5ZzJRRWZ3RE40d0hQbkNTakMwTGZuMXhIY3ZuZVlacEY5akQ2ZmZOMTBY?=
 =?utf-8?B?Zi9hZEpQNkNiZ3J1VEptN1ljREREbzl0YXhzS2twRTBRVzFheXhwZUJtVHlK?=
 =?utf-8?B?QnoxZWdWZVJ1VmJmVFZDaXVpRmU1RjJRd29KUGlHdnZhb1dacjR2Y1FMci96?=
 =?utf-8?B?Qi9EMVBFdms0UW4ydjJ3R0ovR2d6dHJMemNQMVMrM3VldjJLTERBd1JvdTFG?=
 =?utf-8?B?K2J6TjZFckJZZmY1bE5wK05LMEVPWkpxUkVyWGJ2eGcrWUQzaXI5enFydW5P?=
 =?utf-8?B?T2t1MFBVSGJGQmpRUklwdG5kZzhqM2wwRjBKelVhVVVOMklKZ2NpVGFPRHdO?=
 =?utf-8?B?RnBDUC9sWXVpMVNUbGdSeGNOTEtmcEtSZVIyS3FoREI1clVrWm9pNVE4UmVz?=
 =?utf-8?B?UVY3SWRKSXdGYUNueldYaWlTd0J0a1R0VjJwTmE0RGRtMUIyMkpLRDhIQzR6?=
 =?utf-8?B?d1lwQTZWNVNuUmJqVmNsRWhpWkdXSEkvVEhXQUg5aEFzd0JQV092by9lVW83?=
 =?utf-8?B?UHJHdFFYMXU5ajdrWFgreld2SG8xQzdDcVRSUXUyNEZVVzdvcVpqTHdyNlpZ?=
 =?utf-8?B?Z1c4ODcwbVZXWkVwamdabTBTZ0VDUUxMZVRGNmRSeCtvdDhubi81eEV4WlZt?=
 =?utf-8?B?NWFUZTladEJ3NGVzbDZrbEc2M1JnL2J1VG9MTGxDdkFhZmV5dmFTVTN5bkpa?=
 =?utf-8?B?U2FydUhkUTRSK2F5Qk5vdTJHS3BsQkNUdEd1WFRGY21STWN6Lzd1QWg0WFI0?=
 =?utf-8?B?OHUya1UzL05zRWJ2Tkx5MEI1d2gvdUhYdWJ5UXdmNkhGbGFQNTRKYmF4K3VZ?=
 =?utf-8?B?USs0cmtaMXcvSUZNaHlGRHRmbU9WNVREejlGdFdibE1EQmNPY3FUOXUrMTNv?=
 =?utf-8?B?RkhRc2REV3lpcUd1Snh2M2hNUmpZWnIzdGhrNU1KTUpaVmpucmwyTWJkQ3dj?=
 =?utf-8?B?R0Z0cTZob2ROcWZYdU4vMENQcDFhRGJrRUNkWjBkNzR2QXZpbEJ6czRiQmFl?=
 =?utf-8?B?aW4zSm9wMlN4UW9FaHVsR0x2eWZYd1ptL2c1YjM1SzVzS1ZUSmNGN1N6SWRW?=
 =?utf-8?B?V1lmdnhFUTNZc2syeGY5WGtnVVcvUW5OQjJaRFZnYisrZytsbC9MblF6aTZ1?=
 =?utf-8?B?Qms3aDZod3lNMUtvUUtIMEpuZ3VSQmEyNU9MTGw1aStaSm5EN1VNWWdQTEZv?=
 =?utf-8?B?NXJmQUZEUUN2TFNEd2lDSmZFNWl1bUpiVlpJVG5Dd0dQcVFGWFJ5eVpUT2da?=
 =?utf-8?B?WlFtRXBFdkZHa0lzNTJDS1ZpQ3EvWmdUQWtzZWUxczBQemxhVFYwdXU2SDdU?=
 =?utf-8?B?SDVHK1lWdEpLcmgwMHR3bU1XcDlqQW1OMnpDR3RTQlJCOG10ZHhlUnhCRlRh?=
 =?utf-8?B?dUh2S2EzUXpFcGY5L3lTMS9hbHJVTFJZY1cxczhrQTU3enpCVkpiWnJVVkJ0?=
 =?utf-8?B?eGFBUGxxeE9CMjgrVUk3U3UwbEZTcUtpd0htK2dmdlNrRkkzYnBkMDhYODdY?=
 =?utf-8?B?QWFrQ3RFVTkxUEZJTTE3aXczN2JUZjBrZGVHbi9yeGtmV3VLYlRRVndlWjRG?=
 =?utf-8?B?eStPbUhVRkI2aTVUK2NpKzVudkY4TlYxSUVhOU1LYU9McTVqUHBEUXp2blNu?=
 =?utf-8?B?aUdMWFBqYVpyQVgvRUhBWEhiRmFNeWRPMVlqa2E2bUdnNEhMMUE3S0Zudk9y?=
 =?utf-8?B?OC9RTzRWQWRGNEh0OGE3RjJNcGVQSW00bVVHWFNDMmVhRVZMSEpJbXIyL3VT?=
 =?utf-8?Q?0+Wo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a904e47-300d-4c41-fe13-08d9aa94efbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 13:11:30.1940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b82Ok9qVvgpqpJUPhcEWUk2XLbgQKCv8c4/YLKLIYdYhyKfpA5olwYu64TBUd7Ob
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3631
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTgs
IDIwMjEgNDowMSBQTQ0KPiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBSYXkNCj4gPFJheS5IdWFuZ0BhbWQu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiByZXNldCBhc2ljIGFmdGVy
IHN5c3RlbS13aWRlIHN1c3BlbmQNCj4gYWJvcnRlZA0KPg0KPg0KPg0KPiBPbiAxMS8xOC8yMDIx
IDEyOjMyIFBNLCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gPiBEbyBBU0lDIHJlc2V0IGF0IHRoZSBt
b21lbnQgU3ggc3VzcGVuZCBhYm9ydGVkIGJlaGluZCBvZiBhbWRncHUNCj4gPiBzdXNwZW5kIHRv
IGtlZXAgQU1ER1BVIGluIGEgY2xlYW4gcmVzZXQgc3RhdGUgYW5kIHRoYXQgY2FuIGF2b2lkDQo+
ID4gcmUtaW5pdGlhbGl6ZSBkZXZpY2UgaW1wcm9wZXJseSBlcnJvci4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggICAgICAgIHwgIDEgKw0KPiA+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgIDQgKysrKw0K
PiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jICAgIHwgMTkNCj4g
KysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1LmgNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4gaW5k
ZXggYjg1YjY3YS4uOGJkOTgzMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHUuaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdS5oDQo+ID4gQEAgLTEwNTMsNiArMTA1Myw3IEBAIHN0cnVjdCBhbWRncHVfZGV2aWNlIHsN
Cj4gPiAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbl9zMzsNCj4gPiAgICAg
Ym9vbCAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbl9zNDsNCj4gPiAgICAgYm9vbCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbl9zMGl4Ow0KPiA+ICsgICBib29sICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHBtX2NvbXBsZXRlZDsNCj4NCj4gUE0gZnJhbWV3b3JrIG1haW50YWlu
cyBzZXBhcmF0ZSBmbGFncywgd2h5IG5vdCB1c2UgdGhlIHNhbWU/DQo+DQo+ICAgICAgICAgIGRl
di0+cG93ZXIuaXNfc3VzcGVuZGVkID0gZmFsc2U7DQo+ICAgICAgICAgIGRldi0+cG93ZXIuaXNf
bm9pcnFfc3VzcGVuZGVkID0gZmFsc2U7DQo+ICAgICAgICAgIGRldi0+cG93ZXIuaXNfbGF0ZV9z
dXNwZW5kZWQgPSBmYWxzZTsNCj4NCg0KVGhhbmtzIGZvciBwb2ludGluZyBpdCBvdXQgYW5kIEkg
bWlzcyB0aGF0IGZsYWcuIEluIHRoaXMgY2FzZSB3ZSBjYW4gdXNlIHRoZSBQTSBmbGFnIGlzX25v
aXJxX3N1c3BlbmRlZCBmb3IgY2hlY2tpbmcgQU1ER1BVIGRldmljZSB3aGV0aGVyIGlzIGZpbmlz
aGVkIHN1c3BlbmQuDQoNCj4gQlRXLCBBbGV4IHBvc3RlZCBhIHBhdGNoIHdoaWNoIGRvZXMgc2lt
aWxhciB0aGluZywgdGhvdWdoIGl0IHRyaWVzIHJlc2V0IGlmDQo+IHN1c3BlbmQgZmFpbHMuDQo+
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9ETTZQUjEyTUIyNjE5NUY4RTA5OTQwN0I0
QjY5NjZGRUJFNDk5OUANCj4gRE02UFIxMk1CMjYxOS5uYW1wcmQxMi5wcm9kLm91dGxvb2suY29t
Lw0KPg0KPiBJZiB0aGF0IHJlc2V0IGFsc28gZmFpbGVkLCB0aGVuIG5vIHBvaW50IGluIGFub3Ro
ZXIgcmVzZXQsIG9yIGtlZXAgaXQgYXMgcGFydCBvZg0KPiByZXN1bWUuDQo+DQoNCkFsZXgncyBw
YXRjaCBzZWVtcyBhbHdheXMgZG8gdGhlIEFTSUMgcmVzZXQgYXQgdGhlIGVuZCBvZiBBTURHUFUg
ZGV2aWNlLCBidXQgdGhhdCBtYXkgbmVlZG4ndCBvbiB0aGUgbm9ybWFsIEFNREdQVSBkZXZpY2Ug
c3VzcGVuZC4gSG93ZXZlciwgdGhpcyBwYXRjaCBzaG93cyB0aGF0IGNhbiBoYW5kbGUgdGhlIHN5
c3RlbSBzdXNwZW5kIGFib3J0ZWQgYWZ0ZXIgQU1ER1BVIHN1c3BlbmQgY2FzZSB3ZWxsLCBzbyBu
b3cgc2VlbXMgd2Ugb25seSBuZWVkIHRha2UgY2FyZSBzdXNwZW5kIGFib3J0IGNhc2UgaGVyZS4N
Cg0KPiBUaGFua3MsDQo+IExpam8NCj4NCj4gPg0KPiA+ICAgICBhdG9taWNfdCAgICAgICAgICAg
ICAgICAgICAgICAgIGluX2dwdV9yZXNldDsNCj4gPiAgICAgZW51bSBwcF9tcDFfc3RhdGUgICAg
ICAgICAgICAgICBtcDFfc3RhdGU7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gaW5kZXggZWM0MmE2Zi4uYTEyZWQ1NCAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBAQCAt
Mzk4Myw2ICszOTgzLDEwIEBAIGludCBhbWRncHVfZGV2aWNlX3Jlc3VtZShzdHJ1Y3QgZHJtX2Rl
dmljZQ0KPiAqZGV2LCBib29sIGZiY29uKQ0KPiA+ICAgICBpZiAoYWRldi0+aW5fczBpeCkNCj4g
PiAgICAgICAgICAgICBhbWRncHVfZ2Z4X3N0YXRlX2NoYW5nZV9zZXQoYWRldiwNCj4gc0dwdUNo
YW5nZVN0YXRlX0QwRW50cnkpOw0KPiA+DQo+ID4gKyAgIGlmICghYWRldi0+cG1fY29tcGxldGVk
KSB7DQo+ID4gKyAgICAgICAgICAgZGV2X3dhcm4oYWRldi0+ZGV2LCAic3VzcGVuZCBhYm9ydGVk
IHdpbGwgZG8gYXNpYyByZXNldFxuIik7DQo+ID4gKyAgICAgICAgICAgYW1kZ3B1X2FzaWNfcmVz
ZXQoYWRldik7DQo+ID4gKyAgIH0NCj4gPiAgICAgLyogcG9zdCBjYXJkICovDQo+ID4gICAgIGlm
IChhbWRncHVfZGV2aWNlX25lZWRfcG9zdChhZGV2KSkgew0KPiA+ICAgICAgICAgICAgIHIgPSBh
bWRncHVfZGV2aWNlX2FzaWNfaW5pdChhZGV2KTsgZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPiBpbmRleCBlZWUzY2Y4Li45ZjkwMDE3IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+IEBAIC0yMTY4
LDYgKzIxNjgsMjMgQEAgc3RhdGljIGludCBhbWRncHVfcG1vcHNfc3VzcGVuZChzdHJ1Y3QNCj4g
ZGV2aWNlICpkZXYpDQo+ID4gICAgIHJldHVybiByOw0KPiA+ICAgfQ0KPiA+DQo+ID4gKy8qDQo+
ID4gKyAqIEFjdHVhbGx5IHRoZSBQTSBzdXNwZW5kIHdoZXRoZXIgaXMgY29tcGxldGVkIHNob3Vs
ZCBiZSBjb25maXJtZWQNCj4gPiArICogYnkgY2hlY2tpbmcgdGhlIHN5c2ZzDQo+ID4gK3N5cy9w
b3dlci9zdXNwZW5kX3N0YXRzL2ZhaWxlZF9zdXNwZW5kLkhvd2V2ZXIsDQo+ID4gKyAqIGluIHRo
aXMgZnVuY3Rpb24gb25seSBjaGVjayB0aGUgQU1ER1BVIGRldmljZSB3aGV0aGVyIGlzIHN1c3Bl
bmRlZA0KPiA+ICsgKiBjb21wbGV0ZWx5IGluIHRoZSBzeXN0ZW0td2lkZSBzdXNwZW5kIHByb2Nl
c3MuDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgaW50IGFtZGdwdV9wbW9wc19ub2lycV9zdXNwZW5k
KHN0cnVjdCBkZXZpY2UgKmRldikgew0KPiA+ICsgICBzdHJ1Y3QgZHJtX2RldmljZSAqZHJtX2Rl
diA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IGRybV90b19hZGV2KGRybV9kZXYpOw0KPiA+ICsNCj4gPiArICAgZGV2X2RiZyhkZXYs
ICJhbWRncHUgc3VzcGVuZCBjb21wbGV0ZWx5LlxuIik7DQo+ID4gKyAgIGFkZXYtPnBtX2NvbXBs
ZXRlZCA9IHRydWU7DQo+ID4gKw0KPiA+ICsgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4g
PiAgIHN0YXRpYyBpbnQgYW1kZ3B1X3Btb3BzX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+
ID4gICB7DQo+ID4gICAgIHN0cnVjdCBkcm1fZGV2aWNlICpkcm1fZGV2ID0gZGV2X2dldF9kcnZk
YXRhKGRldik7IEBAIC0yMTgxLDYNCj4gPiArMjE5OCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Bt
b3BzX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gICAgIHIgPSBhbWRncHVfZGV2aWNl
X3Jlc3VtZShkcm1fZGV2LCB0cnVlKTsNCj4gPiAgICAgaWYgKGFtZGdwdV9hY3BpX2lzX3MwaXhf
YWN0aXZlKGFkZXYpKQ0KPiA+ICAgICAgICAgICAgIGFkZXYtPmluX3MwaXggPSBmYWxzZTsNCj4g
PiArICAgYWRldi0+cG1fY29tcGxldGVkID0gZmFsc2U7DQo+ID4gICAgIHJldHVybiByOw0KPiA+
ICAgfQ0KPiA+DQo+ID4gQEAgLTIzOTcsNiArMjQxNSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
ZGV2X3BtX29wcyBhbWRncHVfcG1fb3BzDQo+ID0gew0KPiA+ICAgICAucnVudGltZV9zdXNwZW5k
ID0gYW1kZ3B1X3Btb3BzX3J1bnRpbWVfc3VzcGVuZCwNCj4gPiAgICAgLnJ1bnRpbWVfcmVzdW1l
ID0gYW1kZ3B1X3Btb3BzX3J1bnRpbWVfcmVzdW1lLA0KPiA+ICAgICAucnVudGltZV9pZGxlID0g
YW1kZ3B1X3Btb3BzX3J1bnRpbWVfaWRsZSwNCj4gPiArICAgLnN1c3BlbmRfbm9pcnEgPSBhbWRn
cHVfcG1vcHNfbm9pcnFfc3VzcGVuZCwNCj4gPiAgIH07DQo+ID4NCj4gPiAgIHN0YXRpYyBpbnQg
YW1kZ3B1X2ZsdXNoKHN0cnVjdCBmaWxlICpmLCBmbF9vd25lcl90IGlkKQ0KPiA+DQo=
