Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52548C12002
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 09:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 191CE61164
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 09:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191CE61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD25F6E0D7;
	Mon, 19 Jul 2021 09:43:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716D089EA3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 09:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dX/QMnSarsGkLaCEEw21oFrMpG3tqmGP7Ck2wjKYb/nEUfgEiuL5Pt9+Ev4o04af+ZGUKxglkWbxq5Bs7O4eDV4+RuNIMEuopA40EjhSbtsRYQSLu8tscIFG2Gwhh1Z7n8luk75+oAsasdgk8Fv0qGpVzBhtFUuKKnqEMoUkJ243itEduuu4cr5HfV0FURXz+nYA4JaGClGxPyr1g1fexZaCiACrp4P14A4BCcofpKvENzPRB3OPKEWUlj9Ck6w4Rb1rucwJ/ay5HoPSjf0gjqYoVI4OB2RUqFTYLg+4Tk+J1YDu24QBNtFW6uZKBJ7G/7HHi43wes6n0fArPD47Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfQojdGMSlbssUN7BFEyopUYPIvMlIqEp+sFGV/Bi5A=;
 b=IicDL0c/UhWCUgY0IVtTEDH5aBfquOLZWQl8bYv2AEW4HALdE0+ewv+EWiRYjIaqXVLo+r3xGDQESoAbpdWUxd4GP+19cRntV5p7pXK/TMfJ1dMcsHCfbNpiPOaJjXlUUttbmp3zjvLdzZjdq5ecTNwZyy4PClUCExQfOSdaJu8mCtfF6sVydMroqfRyHEN5lqKSxGQF/9vpOyWBLumOGeetRaR3wSXPWzJkW5/xQA+Rr4ZH82pdzRhl6+QI39y5Dit1vJ8uHJA3uvbjFABon9XIwP5PX7q7qPBGTl+IRcQ5VIxJDi/8oeWpdPnDKSAbmJwE4myj8be8hBDqxXrmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfQojdGMSlbssUN7BFEyopUYPIvMlIqEp+sFGV/Bi5A=;
 b=Q1YLZX75BH42utP9MK6FxDE+65XMur+mdFHlOP6ZHrQvL0veOgAygYVVA6gxVen4sPYVo+j4j8lNC3YLyTKvRZcfc4LoMJURLA4pn+eJt+p2B6eQ79f6Mzubyv+gUcfASz8p8xWL4LQZ/hAyJBdtgwnD0UmwV+srl1RCcBPA2Bo=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 19 Jul
 2021 09:42:58 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3%3]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 09:42:58 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: vm entities should have kernel priority
Thread-Topic: [PATCH] drm/amd/amdgpu: vm entities should have kernel priority
Thread-Index: AQHXfGMXqyKk82oQU0e799K+59gf9KtJ9lKAgAASVkCAAALS8A==
Date: Mon, 19 Jul 2021 09:42:58 +0000
Message-ID: <BL1PR12MB526951A39795137AA03FA19984E19@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20210719055754.244832-1-Jingwen.Chen2@amd.com>
 <a56009a5-4793-7301-2a80-b4b051db6c0c@gmail.com>
 <BL1PR12MB5269EC6B2D9822EAAC4A292A84E19@BL1PR12MB5269.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5269EC6B2D9822EAAC4A292A84E19@BL1PR12MB5269.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-19T09:42:57Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=876cadf2-8664-4bc0-baa6-2bd453e1fa6b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f641f44-e7c1-442e-e829-08d94a9997c8
x-ms-traffictypediagnostic: BL1PR12MB5238:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB523868FB7011CD11DDBAC8F884E19@BL1PR12MB5238.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 73GkKHZRIZKFptxPbfljnMH6cMUDWRrwkqwnTc4mxYG9Ybad/5lN0mLB0vfEV7v94n5brRC1DrIGJtJT103yJ7KwNLTgopYcG2ti7YfdIERn3TqhEVRm96pZ4fgY65PUDzH/9b5e4dU+F5eRr1T8S99kZFDl6wDB1tfi2vRJjI16gAjzuSb8xUxARRTeqHOcjUNHEi7+p7q7Gg9UnyiQbm95ryC4U3+GvUz7gLxp5jewXTvaDdSig+JRJF2P6gMw8ipBuCf9b6hX4LD2OhFW+xURKroTQ031fKSW/e3bsOUf/bmgrbpLtNOb9N01GZQickA3EqLiPPZ3WWyLZizcec0EIJMMblce35Y7t3sHn3NXLRl46cO/WuwHI/9C8a0iNhPIpEe9zkHyQy2iODhbB7euIr+yyzfGGQDgwq1n6x4WGepozXEnmGtUL6+JMxmmwIe8bnLkyuKvSK4rxv8yhXmqZsCGy9oF92kVzTeVdv3fiYi8xF6ATwL69JYvwh7JKV/h1JhojErGDYT6ATVCEGyPpBSF373uLpnkWaNX/dtqDe7WSe+1mCmbnZhrhc+q9iwlTWiMzGG4Nb4prHR9aULqc6E3/G4bPP8Ckq8oE5aZPxWIakOp5rpCfScM5AKa7+XwEAayHawHpnro3+CmBgroJD5ZoFpcDah8sNBMp3eydaGpKKH4qdgczaHLmnFGyBLLyN/pQb9l6M2rtQpbKA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(26005)(186003)(86362001)(2906002)(4326008)(64756008)(66446008)(110136005)(66556008)(71200400001)(2940100002)(33656002)(508600001)(316002)(52536014)(66946007)(8936002)(76116006)(8676002)(6506007)(53546011)(7696005)(55016002)(38100700002)(83380400001)(5660300002)(9686003)(122000001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVFsNkc4eVVEZnlrdVRNaytEcCtaZGoxbzMzSTZsV2thdzlkemxqckVuNWVT?=
 =?utf-8?B?NFRTRXJmbHRiM0dQbG5GL3BWRHc1OExhQndTdHhZQkJmUUI4SmlMVStQUmJ5?=
 =?utf-8?B?RDMxS1ZTUmc1QjJxTFpPbTFIdkhnMmNGVXYzMmJUamJObjlVN3pRWXAyNHBI?=
 =?utf-8?B?TlJLdUdrdmZwNll1TGFVd3JaTUkyTjh6NVB4TU5IcVZKTmdGd0N4bXN6K044?=
 =?utf-8?B?dzIyQnlydmRrOGdXNk5UTE9IOFlvQW56b1JQdmsrVHNTMWZLS2ZEVS9JbWYy?=
 =?utf-8?B?ZUN2eXdpLzk5Zyt0N21OVmVNS0ZXSTZjU2tXWUNoUVRQM1IyVm1obXFFenVL?=
 =?utf-8?B?UUFXTjJYYUlDc0dLVWYxY3kvc0FxOTBwVVRBb2ZmZnd6WEpJdXpHTTNLbW1m?=
 =?utf-8?B?VFN6L1FaMmJPdk16WjhlV29uUGhJMHZ4dFJsRHg1Rk9PYnRxeUUrUGxGeWJU?=
 =?utf-8?B?Wnp6ZndmUUM1NnZFelY5QXdwRGMvbm1PTVNsZDRTSzE2cDBMd1AwRjNodUov?=
 =?utf-8?B?enkzS3J4VEp2QUQ3OHJIUnJPeERSYUJXdjg4ZjBuOTR5K0xtakZqcGN5alBK?=
 =?utf-8?B?dXR3cFBjZXJKVWxFWHlRandJZitjVExHV05HdFp6UkZpUjRxVHFOY09mdDZG?=
 =?utf-8?B?QklqMXBFdnhIQURJbEYxMzU1VUxLQWUvbUxPUENuRFhFaTR0VDJGSkNVZDdZ?=
 =?utf-8?B?QndxSzZ6dkRxK2s4WEEvUG1zdUx2WnhGb0FtTHZxWFhXSzUxbk13TFpvN1ZK?=
 =?utf-8?B?MWYwVThoR0VJOFZBbjhlVWR6NmlNUFFob2c0YVljZVIxY1h3VWFBeGpiZmk2?=
 =?utf-8?B?eDZFMXVCTTZLYy9iWWozUTc4T0xlNXV0YWo5bm5uUHBOcGxVWTdjb0dqWTdF?=
 =?utf-8?B?aHpGRXBPWENQdk9Gc0dSZ0UzajRFUStOajkzZ2YvUmx6U3pvc1dGaEMzL25O?=
 =?utf-8?B?azNZZVJXMmlmck10K2VJbm4wNUFTZHo1S0NRZ29kbkovVVpmeXNCSGQya1Jz?=
 =?utf-8?B?ZU9Tamdxc2ZVQWMvVUNoUThyOXdPTUpMc1VvVm91a3F4UytLVmZRaFJjem4y?=
 =?utf-8?B?VFRHZFI5bmZ4VmNXVTMyY0hUTTk1eUM5MjBEUE5qOUQ5WE1CVm40a25qUDhZ?=
 =?utf-8?B?U1BlU2dCNk9hMkNNNEFNaDRBWmZUZHdyZ2pMUWVJak11dUxmV0NBbXlrSSth?=
 =?utf-8?B?Nnh1VHlweCt3UCtXRkdVbFJsaUhDVVhIUmUwWGJxYXFWZjFGWHc5azl5VVdZ?=
 =?utf-8?B?dDVNZ1Z3SzZ3T2JTLytxRHNwZ2ZEbGVSWlQzU1lYRGRQb2h2V0RLUURhZVJW?=
 =?utf-8?B?LzNKSTR4NUpYcVBTZUxJb1lDMWJWNzdXK0dFazVzcU0vOE1iY0RiRCtWWGNI?=
 =?utf-8?B?SzJPSUFSK2Y1d1YzejVTdkZ1MjdhUm5XR2JTdkNMT2VUbUZVNlJiUTN3UGJ0?=
 =?utf-8?B?aXhGQ3BsMXB3MVlIRGJRYkJrQ0x5cDNlMmZxdW1wWVlPUzFBL0dJZzcwWTFE?=
 =?utf-8?B?RGR4TWI1bVFNRkl3QnUxRUcvVFc0dDdZeHJFYzdwTFlWcCtKUDhsMmM0VHhP?=
 =?utf-8?B?Q0l0bTI5dnpjSlJIcmN6YnMwTHhYVnhkaDQ4UlExZVdmSHNRMWFhWXBWWlNz?=
 =?utf-8?B?U0oxekdrZHRWSmxLamoyT1ZTT1FFcnJSQlI2ZzA4NnBYZWFqbUQrNmxhSUpj?=
 =?utf-8?B?MjN3ejIvRURpYVNtbVhFaitma1hDMWpjQjNOYnZ4NGpNS0NOVFU3c0FVeU1t?=
 =?utf-8?Q?eyvuEUqpFRq0WUSzkZfuhG0KS319e018lknAG9l?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f641f44-e7c1-442e-e829-08d94a9997c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 09:42:58.4931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YAunWSo/N+mHI0qeeZK2vFxpslnxmAr4pp832AXaUeHjrSd2eYh8C4mGoeuIzEY4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KQmVzaWRlcywgSSB0aGluayBvdXIgY3VycmVudCBL
TUQgaGF2ZSB0aHJlZSB0eXBlcyBvZiBrZXJuZWwgc2RtYSBqb2JzOg0KMSkgYWRldi0+bW1hbi5l
bnRpdHksIGl0IGlzIGFscmVhZHkgYSBLRVJORUwgcHJpb3JpdHkgZW50aXR5DQoyKSB2bS0+aW1t
ZWRpYXRlDQozKSB2bS0+ZGVsYXkNCg0KRG8geW91IG1lYW4gbm93IHZtLT5pbW1lZGlhdGUgb3Ig
ZGVsYXkgYXJlIHVzZWQgYXMgbW92aW5nIGpvYnMgaW5zdGVhZCBvZiBtbWFuLmVudGl0eSA/DQoN
ClRoYW5rcyANCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpN
b25rIExpdSB8IENsb3VkLUdQVSBDb3JlIHRlYW0NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGl1
LCBNb25rIA0KU2VudDogTW9uZGF5LCBKdWx5IDE5LCAyMDIxIDU6NDAgUE0NClRvOiAnQ2hyaXN0
aWFuIEvDtm5pZycgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPjsgQ2hlbiwgSmlu
Z1dlbiA8SmluZ1dlbi5DaGVuMkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCkNjOiBDaGVuLCBIb3JhY2UgPEhvcmFjZS5DaGVuQGFtZC5jb20+DQpTdWJqZWN0OiBSRTog
W1BBVENIXSBkcm0vYW1kL2FtZGdwdTogdm0gZW50aXRpZXMgc2hvdWxkIGhhdmUga2VybmVsIHBy
aW9yaXR5DQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHldDQoNCklmIHRoZXJlIGlzIG1vdmUgam9i
cyBjbGFzaGluZyB0aGVyZSB3ZSBwcm9iYWJseSBuZWVkIHRvIGZpeCB0aGUgYnVncyBvZiB0aG9z
ZSBtb3ZlIGpvYnMNCg0KUHJldmlvdXNseSBJIGJlbGlldmUgeW91IGFsc28gcmVtZW1iZXIgdGhh
dCB3ZSBhZ3JlZWQgdG8gYWx3YXlzIHRydXN0IGtlcm5lbCBqb2JzIGVzcGVjaWFsbHkgcGFnaW5n
IGpvYnMsDQoNCldpdGhvdXQgc2V0IHBhZ2luZyBqb2JzJyBwcmlvcml0eSB0byBLRVJORUwgbGV2
ZWwgaG93IGNhbiB3ZSBrZWVwIHRoYXQgcHJvdG9jb2wgPyBkbyB5b3UgaGF2ZSBhIGJldHRlciBp
ZGVhPw0KDQpUaGFua3MgDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KTW9uayBMaXUgfCBDbG91ZC1HUFUgQ29yZSB0ZWFtDQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0K
U2VudDogTW9uZGF5LCBKdWx5IDE5LCAyMDIxIDQ6MjUgUE0NClRvOiBDaGVuLCBKaW5nV2VuIDxK
aW5nV2VuLkNoZW4yQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6
IENoZW4sIEhvcmFjZSA8SG9yYWNlLkNoZW5AYW1kLmNvbT47IExpdSwgTW9uayA8TW9uay5MaXVA
YW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiB2bSBlbnRpdGll
cyBzaG91bGQgaGF2ZSBrZXJuZWwgcHJpb3JpdHkNCg0KQW0gMTkuMDcuMjEgdW0gMDc6NTcgc2No
cmllYiBKaW5nd2VuIENoZW46DQo+IFtXaHldDQo+IEN1cnJlbnQgdm1fcHRlIGVudGl0aWVzIGhh
dmUgTk9STUFMIHByaW9yaXR5LCBpbiBTUklPViBtdWx0aS12ZiB1c2UgDQo+IGNhc2UsIHRoZSB2
ZiBmbHIgaGFwcGVucyBmaXJzdCBhbmQgdGhlbiBqb2IgdGltZSBvdXQgaXMgZm91bmQuDQo+IFRo
ZXJlIGNhbiBiZSBzZXZlcmFsIGpvYnMgdGltZW91dCBkdXJpbmcgYSB2ZXJ5IHNtYWxsIHRpbWUg
c2xpY2UuDQo+IEFuZCBpZiB0aGUgaW5ub2NlbnQgc2RtYSBqb2IgdGltZSBvdXQgaXMgZm91bmQg
YmVmb3JlIHRoZSByZWFsIGJhZCANCj4gam9iLCB0aGVuIHRoZSBpbm5vY2VudCBzZG1hIGpvYiB3
aWxsIGJlIHNldCB0byBndWlsdHkgYXMgaXQgb25seSBoYXMgDQo+IE5PUk1BTCBwcmlvcml0eS4g
VGhpcyB3aWxsIGxlYWQgdG8gYSBwYWdlIGZhdWx0IGFmdGVyIHJlc3VibWl0dGluZyANCj4gam9i
Lg0KPg0KPiBbSG93XQ0KPiBzZG1hIHNob3VsZCBhbHdheXMgaGF2ZSBLRVJORUwgcHJpb3JpdHku
IFRoZSBrZXJuZWwgam9iIHdpbGwgYWx3YXlzIGJlIA0KPiByZXN1Ym1pdHRlZC4NCg0KSSdtIG5v
dCBzdXJlIGlmIHRoYXQgaXMgYSBnb29kIGlkZWEuIFdlIGludGVudGlvbmFsbHkgZGlkbid0IGdh
dmUgdGhlIHBhZ2UgdGFibGUgdXBkYXRlcyBrZXJuZWwgcHJpb3JpdHkgdG8gYXZvaWQgY2xhc2hp
bmcgd2l0aCB0aGUgbW92ZSBqb2JzLg0KDQpDaHJpc3RpYW4uDQoNCj4NCj4gU2lnbmVkLW9mZi1i
eTogSmluZ3dlbiBDaGVuIDxKaW5nd2VuLkNoZW4yQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNCArKy0tDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gaW5kZXggMzU4MzE2ZDZhMzhjLi5mNzUyNmI2
N2NjNWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+IEBA
IC0yOTIzLDEzICsyOTIzLDEzIEBAIGludCBhbWRncHVfdm1faW5pdChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0pDQo+ICAgCUlOSVRfTElTVF9IRUFEKCZ2
bS0+ZG9uZSk7DQo+ICAgDQo+ICAgCS8qIGNyZWF0ZSBzY2hlZHVsZXIgZW50aXRpZXMgZm9yIHBh
Z2UgdGFibGUgdXBkYXRlcyAqLw0KPiAtCXIgPSBkcm1fc2NoZWRfZW50aXR5X2luaXQoJnZtLT5p
bW1lZGlhdGUsIERSTV9TQ0hFRF9QUklPUklUWV9OT1JNQUwsDQo+ICsJciA9IGRybV9zY2hlZF9l
bnRpdHlfaW5pdCgmdm0tPmltbWVkaWF0ZSwgRFJNX1NDSEVEX1BSSU9SSVRZX0tFUk5FTCwNCj4g
ICAJCQkJICBhZGV2LT52bV9tYW5hZ2VyLnZtX3B0ZV9zY2hlZHMsDQo+ICAgCQkJCSAgYWRldi0+
dm1fbWFuYWdlci52bV9wdGVfbnVtX3NjaGVkcywgTlVMTCk7DQo+ICAgCWlmIChyKQ0KPiAgIAkJ
cmV0dXJuIHI7DQo+ICAgDQo+IC0JciA9IGRybV9zY2hlZF9lbnRpdHlfaW5pdCgmdm0tPmRlbGF5
ZWQsIERSTV9TQ0hFRF9QUklPUklUWV9OT1JNQUwsDQo+ICsJciA9IGRybV9zY2hlZF9lbnRpdHlf
aW5pdCgmdm0tPmRlbGF5ZWQsIERSTV9TQ0hFRF9QUklPUklUWV9LRVJORUwsDQo+ICAgCQkJCSAg
YWRldi0+dm1fbWFuYWdlci52bV9wdGVfc2NoZWRzLA0KPiAgIAkJCQkgIGFkZXYtPnZtX21hbmFn
ZXIudm1fcHRlX251bV9zY2hlZHMsIE5VTEwpOw0KPiAgIAlpZiAocikNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
