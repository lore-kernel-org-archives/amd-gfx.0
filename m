Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51F8C4338F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 06:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF6F60BD3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 06:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7BF6F60BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2CA89FED;
	Fri,  6 Aug 2021 06:01:33 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 029F489623
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 06:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecQCFylTA26Yi2IprrSY8DgDHCbLRqYHlE1kaLUQYw19XAS7jgK4vvbrPDE6jpqLhSBg0mNmmVmkTCX+zM7eTleueSoo6KTfbcqcN4EfplsPJkGl7AJCqWJ6DYDi3ZSJ0TRgSPqhE/QJhXjoTrvYwrSRYhQQPLOWzj7ksy9TljQmgwhG9+YhjpCVHOu3RNjeZRTK39zFDk7l3C0SyBI3Lm1IJ8JAJP6m0T4i8+/HC2lQZtk7bPxGqQecTdZltVZ+44j8mWpU6UNDC4R7hkY0idCKYlGJ5M5uDX5HmO5rzqBCpNQEFcN+E/2oLFjkYhy4PoFF3INtJn/jNDkEu7n+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mqyQRxrPaKJ7Ja9QUWDBEjHoZGl1jtDOhYdKFbwaAQ=;
 b=YKVjCgtf0NQgCDS9/j0ZyZ6R11Qq4VesvHaO7ldWkI9H+mV+Klrc1GRc7JP6X1vH+QhHdWz49wJrG533CvmMCMJS9g650cgQFHMWxkQcVsA+OOpi8/25gGJrpNMa2D68cI7JJLd4FeuT2RJYoS15rNDIykrs0P67oIsPuQYazP4PGBmfjB71bemuDTi84fM7qJNVThHIrXEc9QfQOrAaitx4FyjrkTalu206iP1U+OSCBmM3J9FO4KVkg6426W2rii1SJvUGqXOVlq3N8QIwVa1/mbCJlVEqgVqmd1YbCPHVCPvRYq8TAtO/PsdIaOCO6kIYz9Czsib6Fs/nVjXSzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mqyQRxrPaKJ7Ja9QUWDBEjHoZGl1jtDOhYdKFbwaAQ=;
 b=CgZ9wIk7mMDKr1PDH6yPzGleAkjPlxYdAR27/pppKQIkpxB1nPGWe9/8NjyVir3Uj/i/jcaJhajmN5svEVYJahGvhpJyKV4tut/opiiHWJ1BjKiZkOlrCngZbfMI1ofaCRKSCKczgGUIAsIduz8zVC3znbyO6yeIgtvejf3Vm+E=
Received: from DM6PR12MB3035.namprd12.prod.outlook.com (2603:10b6:5:3a::24) by
 DM6PR12MB4880.namprd12.prod.outlook.com (2603:10b6:5:1bc::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.17; Fri, 6 Aug 2021 06:01:16 +0000
Received: from DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::7d47:ce8a:ac44:6eb]) by DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::7d47:ce8a:ac44:6eb%3]) with mapi id 15.20.4394.019; Fri, 6 Aug 2021
 06:01:16 +0000
From: "Wang, YuBiao" <YuBiao.Wang@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Quan, Evan"
 <Evan.Quan@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "Tuikov, Luben"
 <Luben.Tuikov@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Xiao, Jack"
 <Jack.Xiao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Liu, Monk"
 <Monk.Liu@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, Kevin(Yang)"
 <Kevin1.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: skip locking delayed work if not
 initialized.
Thread-Topic: [PATCH] drm/amd/amdgpu: skip locking delayed work if not
 initialized.
Thread-Index: AQHXiaLeEkEZp/StyE2y0v9mjPBucatk2YyAgAEgf1A=
Date: Fri, 6 Aug 2021 06:01:16 +0000
Message-ID: <DM6PR12MB3035AA319B913375CCBBCAACE5F39@DM6PR12MB3035.namprd12.prod.outlook.com>
References: <20210805023736.699291-1-YuBiao.Wang@amd.com>
 <834428df-0c3d-859b-7958-2c95a14c6750@gmail.com>
In-Reply-To: <834428df-0c3d-859b-7958-2c95a14c6750@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-06T06:01:13Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a287a6ea-b30a-4684-8529-b01c7f93d14b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73564a7b-695c-4067-6f1f-08d9589f9a6c
x-ms-traffictypediagnostic: DM6PR12MB4880:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB488003BAD4D3F9DD1D6689D6E5F39@DM6PR12MB4880.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oNrhudUBIorYUeg/DrF18QHBfKgoOJ5W2TI1NONO4vQw/x9Ynm6wUgtJLQo/QvpsJVm6/qdu2UnE5nOCn7ApDVj5nvugofLaJkE7jKM/bwLLg75IlKEBiSkjtl28NS6voyPUH8vEcrmq/t+tMBNLlN/OX5ZKag1DLsGrzfQ06+pomxCZimj6ccs6mAsYXcKj6S+rXNOHOL7qn6us6xCFeFF52A6zfZ9qhqhvgnwuNKOrVcke0KhG6JqrWi5/L2rbUsPODP9ceIlpGcOjjrxu/Fr03fLxqDfCdm8RACWRhV+51GS5qv6nS3s/gY2ApOcF9PyCK0QNdYfZzd2DKjJ8iH1ZVT+/FnwMSuHTySGQ8M0gxI6KENyQ3O0pr95knkbjx3f+xoXT+Em461/UH8USo0kQ14arrPdxAuE01kvF6V0xCTusBQony/1SCkCZ5fHqN+t1nGoSxDf9tg27d95AtOmDbM8KhQp1Zn4s8YeXPLCFreje2nHGyIixRjBvQ9LWqXbXZ05smUeJ8W3FogMaFMd1O02kM+1L/pjxTfQAPEB2lz2c6kdOY5KvkdAXavAKuzJKDBXWyLLUtuM/WOU/7wBxrL06BqIbWCH+A/qxtgHeqm+jDyql8TShLMUPlriF7VBPiUKvY04b4NN7xTqPlCmHccVCVYddLrKkjp1YEEbZ/WCsvyzEx+mZaa1/dpeo70vCq3++BRFbGzInT9ojQQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(66574015)(86362001)(478600001)(7696005)(110136005)(316002)(186003)(33656002)(71200400001)(4326008)(2906002)(83380400001)(6506007)(53546011)(8676002)(26005)(54906003)(66556008)(66946007)(76116006)(8936002)(38100700002)(5660300002)(55016002)(66446008)(64756008)(52536014)(66476007)(9686003)(122000001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnZyOFM0YkpvS2Y2cC9rcjE1RjM3MzlPYk43NnAweG5pK28zL3JqTVg1U0lO?=
 =?utf-8?B?bHkyM2wvNTYzaEJKSkt0UlNRYlYrTWEyWjJ5TUNYMmFUVERtU1F3TUZJTkhP?=
 =?utf-8?B?QUhwc3R3WmFUNnRxZWZmclJUT1RTWVVsMFZ2NzNNTDdiam81VTBOTEpEb1V4?=
 =?utf-8?B?Q1FXanVaeUtMcUhpVEpyTVpIM2ZESkRvblk5WkFZUytCMnhQMmFPWXZLb0Ni?=
 =?utf-8?B?eW1QdEREK0hvbzFJb0VRUkZMYUVBS0FuZElDcGdoWkRmRUtCWnJ1cW5RMlpD?=
 =?utf-8?B?YmQ5NVllVGxWcm9mcDZvYnp5UFB0dGhzVDF0eE5LYVVqdjZrdVdBOTh3T0tq?=
 =?utf-8?B?ZVNyVmp5Z2NFRUxZNnBmSE04ajY3LzdsMHVsdEJzZHYwZExzWHRoMThKNkds?=
 =?utf-8?B?bWZubEJkQnlreTdCOXVTU2ZHV0F6TmEvNy95eGF6OEdzNkU0R1AzN2lFTDg5?=
 =?utf-8?B?QXB6dG96S2xJdUdydWRJVExKVWRDYUp1eFoxL0pVUmlwUFQ0cXBPSWJOelhk?=
 =?utf-8?B?Tlg2S2hSbERBajBUTUZjbVpkb0FtZU1WN0VzL1JSdkdkRUlkMEZsTmhSb3Jr?=
 =?utf-8?B?ZFZFbDI2bjlUSFVJampGMytKckNkRkFQUDZYS3VRTG5zVG5QeC8rTUoxQmRM?=
 =?utf-8?B?ZkdFU00xeUUzSUFqU0V0T2haTE0yMnJ4bVUvdWZXOWt1cGtOV215cnNIZTBC?=
 =?utf-8?B?T1NhSXhkaGw2V3BsWHRRL3dyeWtscHVPY1RvNjdRZ00yYkV2Zk81WGFsVm5V?=
 =?utf-8?B?dlZYZnZ0bkUzdEhsUktIU0kyaUwrbWc1Q2lhSkpnRHpCcmYzLy83QVdMRmY5?=
 =?utf-8?B?K2NURmxodUthSVVTUHNqWVR5NW11UUZWdnkxY01BRk80RHQ3WEpmZHJHRWVj?=
 =?utf-8?B?N2I3Mi8vS0ZBM1lIYTBDZitKcC96YUFGbitFSjN3RVRxd0RsempUOVIvME0r?=
 =?utf-8?B?eTFlWTdXM3dYZENZMFBlNjZSMkxtV3hCQ3ZHSzlkNGJkMGdZSm5lMy8yZ3lm?=
 =?utf-8?B?L01QWlRiWFZtS1RuU0xmOFU4cHVXT1VEeVBNUEtDaFZLRHBOMnFwTFJSUFdB?=
 =?utf-8?B?OUNpWXJBbnR1cHNNdWIvQWhraG43Uk1Fai9WRzE1dDBmV0hGMHNiaU16NjJq?=
 =?utf-8?B?M2tUcUdUdm05TktKL3AvcVRTQTJIQytYNWFnNmZSMUM5UVN0VVlDVWtIYi80?=
 =?utf-8?B?bEJ0N2NMVVVHbk5lUjFCdWpvdTZDemJORTUwbUFVeGZpS1grdEhDcHBSc203?=
 =?utf-8?B?UVFqRkxwU2c2QXRKYUJ2Q01OQ1lVSDZhRnEwamFpZFdBWXBwQ1pmMC9UaFRC?=
 =?utf-8?B?NWwva3JWWHBBbURURHBvQ3Z2MzZkZUcweVNmNUp4UldSWjBIYTNBM0liQ200?=
 =?utf-8?B?dlJLM2l3a2pjbkpmc3lzNkdCc1NNQzZRTS9OTTJpcWRQSEFaVHVobGZJRWFy?=
 =?utf-8?B?N3pkb3dMWWJHM3pUaVBKVlRwS0tvcVFQa3hTblRxSzNRbi9RTDJBdVNWdHFY?=
 =?utf-8?B?MThhUEQ2dUY2ZzZJSXVKTWNvazNBOTU4R0lDS2dDaWdxRXd1Ky9zcmdodXg3?=
 =?utf-8?B?RTJjRVdYbE10SEJSV1ZKeWZacDI1eDk4dnBndnZha3JFYktUUGtUWUlNOUR0?=
 =?utf-8?B?S0t6RFJWcEdYUjNvOVhJRTl1YVRtdlkvdDFlazRJckxVZi9FUDNxS09iNmNi?=
 =?utf-8?B?M2tQSXFVanBERGFkb1MyWDY5L2p6eWpwWkNZdXNFWTZwbGt3V3VRa29va2pY?=
 =?utf-8?Q?hjNKmCYv/m8Qcf0HqY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73564a7b-695c-4067-6f1f-08d9589f9a6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 06:01:16.0739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTtXHnw05OEPKtWm9JLkQEwaXao3KQC1CVn9kSY54SQEMvYPoOzWmeNOUztU1givZrx8uF5uu2TOT3RksefgBQ==
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgQ2hyaXN0aWFuLA0KDQpUaGlzIHBhcnQgaXMg
YWRkZWQgYnkgYSBjb21taXQgd2hpY2ggc3RhdGVkIHRoYXQ6DQpXaGVuIHVubG9hZGluZyBkcml2
ZXIgYWZ0ZXIga2lsbGluZyBzb21lIGFwcGxpY2F0aW9ucywgaXQgd2lsbCBoaXQgc2RtYSBmbHVz
aCB0bGIgam9iIHRpbWVvdXQgd2hpY2ggaXMgY2FsbGVkIGJ5IHR0bV9ib19kZWxheV9kZWxldGUu
IFNvIHRvIGF2b2lkIHRoZSBqb2Igc3VibWl0IGFmdGVyIGZlbmNlIGRyaXZlciBmaW5pLCBjYWxs
IHR0bV9ib19sb2NrX2RlbGF5ZWRfd29ya3F1ZXVlDQpiZWZvcmUgZmVuY2UgZHJpdmVyIGZpbmku
IEFuZCBhbHNvIHB1dCBkcm1fc2NoZWRfZmluaSBiZWZvcmUgd2FpdGluZyBmZW5jZS4NCg0KQXMg
ZmVuY2UgZHJpdmVyIGZpbmkgaXMgYmVmb3JlIGFtZGdwdSBpcCBmaW5pIHByb2Nlc3MsIHNvIEkg
dGhpbmsgSSBzaG91bGRuJ3QgbW92ZSBpdCBpbnRvIHR0bV9maW5pLg0KDQpCZXN0IFJlZ2FyZHMs
DQpZdWJpYW8gV2FuZw0KDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENo
cmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiANClNlbnQ6
IFRodXJzZGF5LCBBdWd1c3QgNSwgMjAyMSA4OjM2IFBNDQpUbzogV2FuZywgWXVCaWFvIDxZdUJp
YW8uV2FuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBHcm9k
em92c2t5LCBBbmRyZXkgPEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+OyBRdWFuLCBFdmFuIDxF
dmFuLlF1YW5AYW1kLmNvbT47IENoZW4sIEhvcmFjZSA8SG9yYWNlLkNoZW5AYW1kLmNvbT47IFR1
aWtvdiwgTHViZW4gPEx1YmVuLlR1aWtvdkBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENo
cmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT47IFhpYW8sIEphY2sgPEphY2suWGlhb0BhbWQuY29tPjsgWmhhbmcsIEhh
d2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNv
bT47IFh1LCBGZWlmZWkgPEZlaWZlaS5YdUBhbWQuY29tPjsgV2FuZywgS2V2aW4oWWFuZykgPEtl
dmluMS5XYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTog
c2tpcCBsb2NraW5nIGRlbGF5ZWQgd29yayBpZiBub3QgaW5pdGlhbGl6ZWQuDQoNCkFtIDA1LjA4
LjIxIHVtIDA0OjM3IHNjaHJpZWIgWXVCaWFvIFdhbmc6DQo+IFdoZW4gaW5pdCBmYWlsZWQgaW4g
ZWFybHkgaW5pdCBzdGFnZSwgYW1kZ3B1X29iamVjdCBoYXMgbm90IGJlZW4gDQo+IGluaXRpYWxp
emVkLCBzbyBoYXNuJ3QgdGhlIHR0bSBkZWxheWVkIHF1ZXVlIGZ1bmN0aW9ucy4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogWXVCaWFvIFdhbmcgPFl1Qmlhby5XYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDMgKystDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIA0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBpbmRleCA5ZTUz
ZmY4NTE0OTYuLjRjMzM5ODU1NDJlZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBAQCAtMzgyNSw3ICszODI1LDggQEAgdm9pZCBhbWRncHVf
ZGV2aWNlX2ZpbmlfaHcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgew0KPiAgIAlk
ZXZfaW5mbyhhZGV2LT5kZXYsICJhbWRncHU6IGZpbmlzaGluZyBkZXZpY2UuXG4iKTsNCj4gICAJ
Zmx1c2hfZGVsYXllZF93b3JrKCZhZGV2LT5kZWxheWVkX2luaXRfd29yayk7DQo+IC0JdHRtX2Jv
X2xvY2tfZGVsYXllZF93b3JrcXVldWUoJmFkZXYtPm1tYW4uYmRldik7DQo+ICsJaWYgKGFkZXYt
Pm1tYW4uaW5pdGlhbGl6ZWQpDQo+ICsJCXR0bV9ib19sb2NrX2RlbGF5ZWRfd29ya3F1ZXVlKCZh
ZGV2LT5tbWFuLmJkZXYpOw0KDQpJJ20gcmVhbGx5IHdvbmRlcmluZyB3aHkgd2UgaGF2ZSB0aGF0
IGhlcmUgaW4gdGhlIGZpcnN0IHBsYWNlLg0KDQpUaGlzIGp1c3QgZGlzYWJsZWQgdGhlIGRlbGF5
ZWQgZGVsZXRlIHF1ZXVlIHdoaWNoIGlzIHBhcnQgb2YgdGhlIHN3IHN0YWNrIGFuZCBub3QgcmVs
YXRlZCB0byBoYXJkd2FyZSBpbiBhbnkgd2F5IHBvc3NpYmxlLg0KDQpJIHRoaW5rIGl0IHdvdWxk
IGJlIG11Y2ggY2xlYW5lciB0byBtb3ZlIHRoaXMgaW50byBhbWRncHVfdHRtX2ZpbmkoKS4NCg0K
Q2hyaXN0aWFuLg0KDQo+ICAgCWFkZXYtPnNodXRkb3duID0gdHJ1ZTsNCj4gICANCj4gICAJLyog
bWFrZSBzdXJlIElCIHRlc3QgZmluaXNoZWQgYmVmb3JlIGVudGVyaW5nIGV4Y2x1c2l2ZSBtb2Rl
DQo=
