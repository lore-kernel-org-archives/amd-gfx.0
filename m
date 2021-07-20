Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6172AC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 07:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE76610FB
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 07:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE76610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9DFF89AA2;
	Tue, 20 Jul 2021 07:49:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3228B89AA2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 07:49:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7EY5zvPWHI4PxvY5kPktUQAyuj20GkNsJRSjyzZ6fCGvq8tFLAyMPLe8BORCu/rkX6of1qmitVqtHrut2RHXHvLOmsBBpHjqwIsw1dKUxap1/2ZMrTY5+eYgNMQ/RrKT4aGXTPaUF8UI4/OZBhHfHkoTH2khPgAuvEmRSvJ8NDzzfX/tdanei0WYFpkL3WBKmOChZy3YltpkmWXD+Fb+3Y2zm5zee5s5kAalyBDveAHRyADdpoLFEScedGFGzImndoSzBaB7oDMT4jZ6j/k3QoHH2ps36plTYyywd8rIAweMMfKKNX1YyqErLlA0snSThtTBKqgDoFIB5HdNll1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8drze0I4x57wMgSXqzaFr3wkBgYvFpWE7JmL1IMJAqc=;
 b=YZej060h0jyevnNUawvzK07hipFQbmQHIh3dtYZve+xR3xqCOwK0pTUyrU0+H/Fh//l31LL6Q7DuGuwWkqxdLkzpKYXtoK9DIUutnV9kZoLVWSm/dFEWwv0QLljKma64FuuFpIadi/ahnjpxZdQsoFsj1xDyLhATAGeBGhrxL9pM/gXNT/MAUCq3FTLkD5Og5QsN+WFSL4BRsnMj09pgav8KSgRDJ0WRXl6zYSBrjDetsHqCywHGe3XTVGf7plVjpJCOhC+5VNnnj3j8uWuk80I8PJgmnKCkeQ9LPjtZ1Gh1Q8yGEnfaQRBSTqW/p+VI9hlhWuAPVSXTTmdR5yhACw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8drze0I4x57wMgSXqzaFr3wkBgYvFpWE7JmL1IMJAqc=;
 b=zyNvVhcsFCii/g6U1emjnFPsvGxtPSBHwDiSf1FDDs78ga3UNDT782K+SB22M3ZCEkGUW5gVcrni0GKd9kMuttPmTqunhROUevxqzCbdAJ9XgZaHooiF3w5xQ51rF8HC25JTBasei/oe2Cgr7F7KEWn1heplnbGbiyXh2KXy/nA=
Received: from DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16)
 by DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Tue, 20 Jul
 2021 07:49:55 +0000
Received: from DM4PR12MB5232.namprd12.prod.outlook.com
 ([fe80::9977:1325:c275:327a]) by DM4PR12MB5232.namprd12.prod.outlook.com
 ([fe80::9977:1325:c275:327a%8]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 07:49:55 +0000
From: "Chen, JingWen" <JingWen.Chen2@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: vm entities should have kernel priority
Thread-Topic: [PATCH] drm/amd/amdgpu: vm entities should have kernel priority
Thread-Index: AQHXfGMXOH6nqLqskUGCx+NsyuS83atJ9lKAgAAU/wCAAADSAIAAGFEAgAFYOHA=
Date: Tue, 20 Jul 2021 07:49:55 +0000
Message-ID: <DM4PR12MB52322BAD9B4EBC3B8AE38F24B7E29@DM4PR12MB5232.namprd12.prod.outlook.com>
References: <20210719055754.244832-1-Jingwen.Chen2@amd.com>
 <a56009a5-4793-7301-2a80-b4b051db6c0c@gmail.com>
 <BL1PR12MB5269EC6B2D9822EAAC4A292A84E19@BL1PR12MB5269.namprd12.prod.outlook.com>
 <BL1PR12MB526951A39795137AA03FA19984E19@BL1PR12MB5269.namprd12.prod.outlook.com>
 <73d76ebe-9850-9429-25cd-c723a40b99dc@gmail.com>
In-Reply-To: <73d76ebe-9850-9429-25cd-c723a40b99dc@gmail.com>
Accept-Language: en-150, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=9cafefd1-1497-406f-8f59-6b102f0f6998;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-20T07:42:00Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a7a1791-b647-4de0-9ccd-08d94b52f714
x-ms-traffictypediagnostic: DM4PR12MB5136:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5136D663A536600179887088B7E29@DM4PR12MB5136.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ertbbzy8ohmY4FJcckp6L025ROkX7GQXzrbFx23U6zfLSQl2Gmfct4SXCoP3NmX3Y0ODvmuAvMA1YbcGpZACzer3hoPTTycGdlPfCfPNA1lcKicXMorviDFpiB5ub5NjFFSlZej3tnwt5XDMfJJY7q44bIcpVReS3EuCmKBZIaACTNqK1gLRbW5lzCdiBXfxebZY3S452vS7pqZgCi+r0Erg5x0zP7x4vSqqv6yZ4NC7qp2LHpDc3NSPnUAHwphDKZVqqEdymEWBMG639kaorqw/08LJvxPuH48bVWn1NMiXZFo8opdpiUrWFOdJslg5ljobN6TgBzM6qDpHzJVkAuLnP2RRT3iXLRcouM49jNzlYCeiQY6KDj0YJmUT9WQeQYiDsADekHDknQxdGTm1i3kRA9l+Uc8COEssH6V65pt4O9P5y/WTO016Y97gj6JJ9zMeq5azAB/+2BDDA1PxcOMMdFZ4k9LljiOamUFln+PYE7+ZfHgdkckCfQUSjtJrVQ6su0S/6A7TOWqMCtxtlam+aGaF3qD7o9WxWGIIyuie9/xiGoHgH3/hnnjLw4KE2FWsjIafmQFpL+MSnR5jGap8bSr/mx2i3rG8Mb71cPuh4SWL58c6nK10zYJRbb1/uzkWhlbiJCuPuy9e7TnFoQSs1u/x2N4yPIH3mLd4Y45jmc2WWZNF3zWKtG0lS0X+UxL8NrmIbWeh1fkOKS3lGI+EH7LS13UdOIEYmGDw0FY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5232.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(71200400001)(38100700002)(2906002)(316002)(66574015)(86362001)(478600001)(83380400001)(122000001)(8676002)(5660300002)(110136005)(8936002)(76116006)(66946007)(33656002)(4326008)(7696005)(53546011)(55016002)(9686003)(186003)(52536014)(26005)(66476007)(66556008)(66446008)(6506007)(64756008)(3714002)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDRGeHN1azFXNmdVZDUvSXV3QnVXOEFpS2d0WjZJQkM1WTVJUVlWbmo3dFBE?=
 =?utf-8?B?K3h1aHZCVmRCYmZFL3dSdW5EZ0ExNDNWalZFRUhRUmd5dTRsRGlvZ2pleVVK?=
 =?utf-8?B?eUt4QlcyN21FR211dHZDYUJtT3YvUVFxUHd4VTh5U0lCWDFOM05Ubmo3TFVu?=
 =?utf-8?B?RTloUVAwcVJlejFrV2J6ZmJjWitGZ1dkRWxJMjEvVXMwOXJBT1o3c3JJcVR0?=
 =?utf-8?B?UlFRbEQ3N3Rwei9aSGJjTGJBejZWRzMwSUs4V3Q3RlhmZmh1Q1hGOHpCQVhJ?=
 =?utf-8?B?QkVjMVRabmVhMkVyQmg1RkZUR3VvaTR4ZWNrWm1JODJadERXblpUcVlBL1h0?=
 =?utf-8?B?Sjh1WVJmV2FGRDhiQTZBNWFaeFBmN3NyTDF2RTdtelhkVTlJZFVoM0c3VElw?=
 =?utf-8?B?eEEyMnBJWGZIaVdnQSs3VHhEY2twWWVqV2FwZ1lTQS9Tb2xMYld5K0s5M3lj?=
 =?utf-8?B?d1ZvL00yY2FJTVFEeWJiS2tUdXY3aHNyNmhFWG5OczNpQXM0bzlmTm1MNWho?=
 =?utf-8?B?K0h1YXRteWxKSmltZTZDSDNMRjhYS3B1OHI5MEJnYSthZzQ0eldhMzFtVHg1?=
 =?utf-8?B?c1ZSb3JRY25ha2VlUFM4R05lbkFvSU53MkhwdTBvNjFsZW9UZ0E0WVI0Q1pU?=
 =?utf-8?B?N0JiNWpIU2ozRDBzTzRtY1NyMGZZc2lvTC9nZnRyd25rNENFOU9aY3hzMGx2?=
 =?utf-8?B?U1BHQ1RIL2FFR1h4VVBIejhQQms2RzNCeWtLS29iZTRqanVSdUxVVHdPeG1T?=
 =?utf-8?B?YncvcnhkTUxUZEdrd2EzZTU4OTQyVVRoTWhRSWhWSU1KeWRUdG8reHBFQS9Y?=
 =?utf-8?B?US9wREZ2MDV1ZnFrR0JHdFYxWWRJeDNZQWtnMzZadHRNMGhOTm02eldObGtB?=
 =?utf-8?B?NUlnTWtCdXU0cmsrelMxa2ZqdFRKL1pwZDJRTHI4amlPQUYraG9KSmJsb2dV?=
 =?utf-8?B?dm5GRnVvMEc2M2UxVFhKZHVPelUzeEdGU3hXd3htbUM1MmVjYzBCcFdUL3F6?=
 =?utf-8?B?MXdDVGpVV0tLOVAwVjEzMmNLb04zLy9UZyt3by9WOWc5TDRBQUxPMHZqMDZr?=
 =?utf-8?B?N3QyNEZramxoN0dqeDhKL2MvT2xuM2svcCtybHlHbVNySTIxNUpMdGhhU0RC?=
 =?utf-8?B?ZjBvNXlHT2Z3MUlaak8xVTNYbXB0S2Q3dFYxZlI3RXR5RnZHWFRiaEM2Zity?=
 =?utf-8?B?OUhrWGUrcnhoUVRacE5uZVd1ZC9iYTNZckV1elNHWTJXYmFGcFoxZWwycDRk?=
 =?utf-8?B?TlhLcjhFWTY0SDhGZnhheDlUc1ArNWFRdzk2QVZHS3AxaFR1UWQ2a28vRmtH?=
 =?utf-8?B?cHlIU3VlRkpwUDFsRWF4R0k2dmhpS2VOanJ1b2Y2aWxWeG1xd2ZYU1Q4NHFU?=
 =?utf-8?B?VzNCTXMzTVFnejI4Nm5mZGRIVnczbHNUQ1ZXMlBDYVVuSG1KdU9oMHNZcFpz?=
 =?utf-8?B?cCtKTXdNTDh5aitOWDExRVArdUNCNHEyTUNsVFFxYk5BbjRCY3NYeHlkMXpI?=
 =?utf-8?B?TDhzT3p0T3JvSU84c3NFdHVWZ0F5MEZCR1NCVk4reXduUEVrQzZQckJXS3N6?=
 =?utf-8?B?U1lFSWd2RmN5TG9nQUxaWUl5SnV3emdndW1lYlY1akNiTGlIUWtoQldxNCtB?=
 =?utf-8?B?NHdGM0c3MlJpbWtFWldZWmE0bGVMZnlqRzlYOEZaRzlQVUpLLzZCd2VUMHln?=
 =?utf-8?B?dHlZZ1ZiNE1KREVnQzBKaGQ4Um5JeHEzaS9aVXlvZUpKWDBGNGdnZExYVU5Q?=
 =?utf-8?Q?5MXK2gSztVbwQFfPqGSjcZ6RGP1K2V1w5r29Kps?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5232.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7a1791-b647-4de0-9ccd-08d94b52f714
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 07:49:55.3305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b81ZjgfNJBOhoKtPakU2m6B77sSxuGd++q5lM8gIKVEIfJS5/QdaFGvGhKy/KwX1PFJrGmV0BZXSPkUfZnStQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5136
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgQ2hyaXN0aWFuLA0KDQpFdmVuIGlmIHRoaXMg
aXMgYSB1c2Vyc3BhY2UgbWFwcGluZywgaXQncyBzdGlsbCBwYWNrYWdlZCBieSB0aGUga2VybmVs
LCBzbyBpdCdzIGFsd2F5cyBhc3N1bWVkIHRvIGJlIGNvcnJlY3QuIEluIHdoaWNoIGNhc2UgbW9k
aWZ5aW5nIHRoZSBwcmlvcml0eSBzaG91bGQgaGF2ZSBubyBzaWRlIGVmZmVjdHMuIE1heSBJIGtu
b3cgdGhlIGRldGFpbGVkIHJlYXNvbiBmb3IgeW91ciBjb25jZXJuPw0KDQpBbmQgaWYgd2UgZXZl
bnR1YWxseSBkZWNpZGUgbm90IHRvIGNoYW5nZSB0aGUgcHJpb3JpdHksIGRvIHlvdSBoYXZlIGFu
eSBzdWdnZXN0aW9ucyBhYm91dCBob3cgdG8gbWFrZSBzdXJlIHRoZSBwYWdpbmcgam9icyBhcmUg
bm90IGNvbnNpZGVyZWQgZ3VpbHR5Pw0KDQpCZXN0IFJlZ2FyZHMsDQpKaW5nV2VuIENoZW4NCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2Vu
aWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0KU2VudDogTW9uZGF5LCBKdWx5IDE5LCAyMDIx
IDc6MTAgUE0NClRvOiBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+OyBDaGVuLCBKaW5nV2Vu
IDxKaW5nV2VuLkNoZW4yQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
Q2M6IENoZW4sIEhvcmFjZSA8SG9yYWNlLkNoZW5AYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGRybS9hbWQvYW1kZ3B1OiB2bSBlbnRpdGllcyBzaG91bGQgaGF2ZSBrZXJuZWwgcHJpb3Jp
dHkNCg0KQW0gMTkuMDcuMjEgdW0gMTE6NDIgc2NocmllYiBMaXUsIE1vbms6DQo+IFtBTUQgT2Zm
aWNpYWwgVXNlIE9ubHldDQo+DQo+IEJlc2lkZXMsIEkgdGhpbmsgb3VyIGN1cnJlbnQgS01EIGhh
dmUgdGhyZWUgdHlwZXMgb2Yga2VybmVsIHNkbWEgam9iczoNCj4gMSkgYWRldi0+bW1hbi5lbnRp
dHksIGl0IGlzIGFscmVhZHkgYSBLRVJORUwgcHJpb3JpdHkgZW50aXR5DQo+IDIpIHZtLT5pbW1l
ZGlhdGUNCj4gMykgdm0tPmRlbGF5DQo+DQo+IERvIHlvdSBtZWFuIG5vdyB2bS0+aW1tZWRpYXRl
IG9yIGRlbGF5IGFyZSB1c2VkIGFzIG1vdmluZyBqb2JzIGluc3RlYWQgb2YgbW1hbi5lbnRpdHkg
Pw0KDQpObywgZXhhY3RseSB0aGF0J3MgdGhlIHBvaW50LiB2bS0+aW1tZWRpYXRlIGFuZCB2bS0+
ZGVsYXllZCBhcmUgbm90IGZvciBrZXJuZWwgcGFnaW5nIGpvYnMuDQoNClRob3NlIGFyZSB1c2Vk
IGZvciB1c2Vyc3BhY2UgcGFnZSB0YWJsZSB1cGRhdGVzLg0KDQpJIGFncmVlIHRoYXQgdGhvc2Ug
c2hvdWxkIHByb2JhYmx5IG5vdCBjb25zaWRlcmVkIGd1aWx0eSwgYnV0IG1vZGlmeWluZyB0aGUg
cHJpb3JpdHkgb2YgdGhlbSBpcyBub3QgdGhlIHJpZ2h0IHdheSBvZiBkb2luZyB0aGF0Lg0KDQpS
ZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+DQo+IFRoYW5rcw0KPg0KPiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gTW9uayBMaXUgfCBDbG91ZC1HUFUgQ29yZSB0
ZWFtDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaXUsIE1vbmsNCj4gU2VudDogTW9u
ZGF5LCBKdWx5IDE5LCAyMDIxIDU6NDAgUE0NCj4gVG86ICdDaHJpc3RpYW4gS8O2bmlnJyA8Y2tv
ZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+OyBDaGVuLA0KPiBKaW5nV2VuIDxKaW5nV2Vu
LkNoZW4yQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogQ2hl
biwgSG9yYWNlIDxIb3JhY2UuQ2hlbkBhbWQuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBk
cm0vYW1kL2FtZGdwdTogdm0gZW50aXRpZXMgc2hvdWxkIGhhdmUga2VybmVsDQo+IHByaW9yaXR5
DQo+DQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHldDQo+DQo+IElmIHRoZXJlIGlzIG1vdmUgam9i
cyBjbGFzaGluZyB0aGVyZSB3ZSBwcm9iYWJseSBuZWVkIHRvIGZpeCB0aGUgYnVncw0KPiBvZiB0
aG9zZSBtb3ZlIGpvYnMNCj4NCj4gUHJldmlvdXNseSBJIGJlbGlldmUgeW91IGFsc28gcmVtZW1i
ZXIgdGhhdCB3ZSBhZ3JlZWQgdG8gYWx3YXlzIHRydXN0DQo+IGtlcm5lbCBqb2JzIGVzcGVjaWFs
bHkgcGFnaW5nIGpvYnMsDQo+DQo+IFdpdGhvdXQgc2V0IHBhZ2luZyBqb2JzJyBwcmlvcml0eSB0
byBLRVJORUwgbGV2ZWwgaG93IGNhbiB3ZSBrZWVwIHRoYXQgcHJvdG9jb2wgPyBkbyB5b3UgaGF2
ZSBhIGJldHRlciBpZGVhPw0KPg0KPiBUaGFua3MNCj4NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IE1vbmsgTGl1IHwgQ2xvdWQtR1BVIENvcmUgdGVhbQ0K
PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4NCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5s
ZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSnVseSAxOSwgMjAyMSA0
OjI1IFBNDQo+IFRvOiBDaGVuLCBKaW5nV2VuIDxKaW5nV2VuLkNoZW4yQGFtZC5jb20+Ow0KPiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogQ2hlbiwgSG9yYWNlIDxIb3JhY2Uu
Q2hlbkBhbWQuY29tPjsgTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTogdm0gZW50aXRpZXMgc2hvdWxkIGhhdmUga2VybmVs
DQo+IHByaW9yaXR5DQo+DQo+IEFtIDE5LjA3LjIxIHVtIDA3OjU3IHNjaHJpZWIgSmluZ3dlbiBD
aGVuOg0KPj4gW1doeV0NCj4+IEN1cnJlbnQgdm1fcHRlIGVudGl0aWVzIGhhdmUgTk9STUFMIHBy
aW9yaXR5LCBpbiBTUklPViBtdWx0aS12ZiB1c2UNCj4+IGNhc2UsIHRoZSB2ZiBmbHIgaGFwcGVu
cyBmaXJzdCBhbmQgdGhlbiBqb2IgdGltZSBvdXQgaXMgZm91bmQuDQo+PiBUaGVyZSBjYW4gYmUg
c2V2ZXJhbCBqb2JzIHRpbWVvdXQgZHVyaW5nIGEgdmVyeSBzbWFsbCB0aW1lIHNsaWNlLg0KPj4g
QW5kIGlmIHRoZSBpbm5vY2VudCBzZG1hIGpvYiB0aW1lIG91dCBpcyBmb3VuZCBiZWZvcmUgdGhl
IHJlYWwgYmFkDQo+PiBqb2IsIHRoZW4gdGhlIGlubm9jZW50IHNkbWEgam9iIHdpbGwgYmUgc2V0
IHRvIGd1aWx0eSBhcyBpdCBvbmx5IGhhcw0KPj4gTk9STUFMIHByaW9yaXR5LiBUaGlzIHdpbGwg
bGVhZCB0byBhIHBhZ2UgZmF1bHQgYWZ0ZXIgcmVzdWJtaXR0aW5nDQo+PiBqb2IuDQo+Pg0KPj4g
W0hvd10NCj4+IHNkbWEgc2hvdWxkIGFsd2F5cyBoYXZlIEtFUk5FTCBwcmlvcml0eS4gVGhlIGtl
cm5lbCBqb2Igd2lsbCBhbHdheXMNCj4+IGJlIHJlc3VibWl0dGVkLg0KPiBJJ20gbm90IHN1cmUg
aWYgdGhhdCBpcyBhIGdvb2QgaWRlYS4gV2UgaW50ZW50aW9uYWxseSBkaWRuJ3QgZ2F2ZSB0aGUg
cGFnZSB0YWJsZSB1cGRhdGVzIGtlcm5lbCBwcmlvcml0eSB0byBhdm9pZCBjbGFzaGluZyB3aXRo
IHRoZSBtb3ZlIGpvYnMuDQo+DQo+IENocmlzdGlhbi4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpp
bmd3ZW4gQ2hlbiA8SmluZ3dlbi5DaGVuMkBhbWQuY29tPg0KPj4gLS0tDQo+PiAgICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDQgKystLQ0KPj4gICAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4+IGluZGV4IDM1ODMxNmQ2YTM4Yy4uZjc1
MjZiNjdjYzVkIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
DQo+PiBAQCAtMjkyMywxMyArMjkyMywxMyBAQCBpbnQgYW1kZ3B1X3ZtX2luaXQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtKQ0KPj4gICAgICBJTklUX0xJ
U1RfSEVBRCgmdm0tPmRvbmUpOw0KPj4NCj4+ICAgICAgLyogY3JlYXRlIHNjaGVkdWxlciBlbnRp
dGllcyBmb3IgcGFnZSB0YWJsZSB1cGRhdGVzICovDQo+PiAtICAgIHIgPSBkcm1fc2NoZWRfZW50
aXR5X2luaXQoJnZtLT5pbW1lZGlhdGUsIERSTV9TQ0hFRF9QUklPUklUWV9OT1JNQUwsDQo+PiAr
ICAgIHIgPSBkcm1fc2NoZWRfZW50aXR5X2luaXQoJnZtLT5pbW1lZGlhdGUsDQo+PiArRFJNX1ND
SEVEX1BSSU9SSVRZX0tFUk5FTCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBh
ZGV2LT52bV9tYW5hZ2VyLnZtX3B0ZV9zY2hlZHMsDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYWRldi0+dm1fbWFuYWdlci52bV9wdGVfbnVtX3NjaGVkcywgTlVMTCk7DQo+PiAg
ICAgIGlmIChyKQ0KPj4gICAgICAgICAgICAgIHJldHVybiByOw0KPj4NCj4+IC0gICAgciA9IGRy
bV9zY2hlZF9lbnRpdHlfaW5pdCgmdm0tPmRlbGF5ZWQsIERSTV9TQ0hFRF9QUklPUklUWV9OT1JN
QUwsDQo+PiArICAgIHIgPSBkcm1fc2NoZWRfZW50aXR5X2luaXQoJnZtLT5kZWxheWVkLCBEUk1f
U0NIRURfUFJJT1JJVFlfS0VSTkVMLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGFkZXYtPnZtX21hbmFnZXIudm1fcHRlX3NjaGVkcywNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBhZGV2LT52bV9tYW5hZ2VyLnZtX3B0ZV9udW1fc2NoZWRzLCBOVUxMKTsNCj4+
ICAgICAgaWYgKHIpDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
