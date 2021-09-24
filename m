Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F8EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 10:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A096103B
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 10:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 82A096103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 163076E1A8;
	Fri, 24 Sep 2021 10:37:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6090C6E1A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 10:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWruv9givT9lYQ/314neGZltnuwYWOUS0+jClsoqxjwlh1Dio7iOiya6qxvn9jp8eDmzjr7CP8yPhdO/uueLFNP+2Z0XhNWdn8S2Htp7u1zU7C+4nsKnx1ISnZzdWm4RNPcZORpHpL3qgWgHpKOdMEgRuYmSglzEkBaCDvhyuvb6Vc+e2OzqSAf8SGketoZmKskGnBwvvF1PxxGhjTjMzqRMeFi81Abonwe4Jm+wvtCocPbqgyQl4oPcrJy5116mw4+2HW1uOEu8jnOBTEiD54Q0gFXZAEpqMpb+o/25XZfbiXq5CUMLXkUyocE9UgRqgyMxswIybbxPGYHWpUGWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=pkBZzfTQbXQIzzxbOTPJiWfG2laB6jyb0odaC2DLNa8=;
 b=HFbVcXa4vdzP3s0qALhAyO3JZLD3MNOaa3bch5sK2jKHv5SzE28WZHgHgVWGukU12R6sITQojGB744FlZ9lmdLA974eycFEEplhY+mEBQqKwmF62unue2Xgg51HZmjqJOZVIhyAzkUNSi0JTdRaB1Bqoigv9YIU+8Dj67i10Q9Eo0ZwIZydIVNOHhlsXVyenDGIHeEa8UbfYjb8wEtR70uwZbHpo3yHETpWaaBHKKbogSd2o8r3vNF6RsMNK6mvRfUaIPNpTs+dTVsNhmHx7M/rCDe4EclVXT/D8ZnPBdCSYa1MuXkChdM3HoyR8b5qPoX+AvWGEnwiT31Jpv2My9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkBZzfTQbXQIzzxbOTPJiWfG2laB6jyb0odaC2DLNa8=;
 b=pNvfzihXqGDRXsSnN+pkPtjhFjhqLyg9tEFKLzYghEE+UBq2r3zEvQ5Wq6CbzwcLvhysVgExwRbhf8Pk8nNppWu2rOrmUZ8ElIhPXd4a29LnMoto/7s6aZhF0LC5xlU4HbclleyWMxOZY6gOayoa5H9EHvnvP1Wc5boOCtgP+eM=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Fri, 24 Sep 2021 10:37:44 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 10:37:44 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/kfd: fix ttm_bo_release warning
Thread-Topic: [PATCH] drm/kfd: fix ttm_bo_release warning
Thread-Index: AQHXsF+MFLhwcdC4i0yA4fQIMdExrauxfp0AgAAFQcCAAAcjgIAAFGOQgAAVHgCAAPVIwIAAA0mAgAABUSCAAAILgIAAAYSggAAKlACAAEEwYA==
Date: Fri, 24 Sep 2021 10:37:44 +0000
Message-ID: <DM6PR12MB4250923605F231EEBABCB5F2FBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210923094405.144613-1-lang.yu@amd.com>
 <063d904f-4083-f5db-b3d0-eb4e080b055f@amd.com>
 <DM6PR12MB4250123CDF0A1F69AD1C1131FBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
 <dc3b075f-70f9-6724-9b00-3e00afa922fa@amd.com>
 <DM6PR12MB42507FAA5B24CB49218517ECFBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
 <066e138e-3eab-8c4c-04b9-6c7b5d6a4acc@amd.com>
 <DM6PR12MB425014A356EE6C8D865D5AC3FBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <6d9ae09f-4347-8a58-0cd4-1efb0955fe0f@amd.com>
 <DM6PR12MB4250C7EC2039EC6405C5EDAAFBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <1ae03ed5-95ee-7e8a-b850-d0958aa974e6@amd.com>
 <DM6PR12MB4250D2851824AA4F27BE7FDBFBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <fc860cdc-e17a-ac94-b863-df8c21d4bacf@gmail.com>
In-Reply-To: <fc860cdc-e17a-ac94-b863-df8c21d4bacf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-24T10:37:40Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=99343230-a59f-47e2-8ec2-c4fd7eb048f3;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbc8b071-b4aa-4fa7-911e-08d97f4757ce
x-ms-traffictypediagnostic: DM6PR12MB4137:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4137C8B19F66C36D53101DDAFBA49@DM6PR12MB4137.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hc2YbbwgvBkyrsNkrMIdUtYrOw4LHO8zJp4plPeiIk2Gep6q8zTHOxlJYRRgSVQjDdCssycrf8JnxwtA+lb1m2NsXFKz3JqljZcAls66Zdo7Cs8ZXzI8JCPIS5dlM64NjyAnav8tWMYIsEd4nqXcVrSv6vkuDVTJu8FwfyZqdu9tvKZuQDDFowDxul1sq20aWAn0AAzptVJrKkXQQP+K+cq9MF66h102UPhi7YMit5FxiX07dm/5Wh1bA6MYW0e3N7yTvHMLIZV8nYooBWWgoBdTDr4RZsIkxSCIBF4c2o2GTrL+hjU344fauIv/p426dmTcsu9CDiJJRu0mwa8x5DirhQEY/qT+a8a/Oz7Yaq2vv2Hd/O1nmds60D0VTi7FBVuu6ridmoefA+sPevBLPoKH4RsObX5yO4DghhjJ0+tJup4vPaGJUkaSxA+4FPEX/s15ryJPXU13N6GrIqKwYDm1zV+4ruLrkvV3f4GMuGf43NIr0UjaH9Y9z2ICxqCGiH0xoECuujbgyzOFAU/EPoXVYTAarVtHAz0pEkpi8zNfjH10aZXv+1c1iBayV2HT5rk9ytLkv+xO9jZcWIjl06Mor0wazuv9/2/ErhgOECtwD8AEfcWlvUtEr4f8cMzpogJ4C2+WXaeNkV6xSu2q14LnU0kATIV3ZopPasfy0RVhMuQPFZltnfkv3+rQqo31sn+QtdUTp4AmV/NxQ/xtqg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(508600001)(9686003)(76116006)(66946007)(66476007)(38070700005)(55016002)(4326008)(71200400001)(64756008)(6506007)(33656002)(54906003)(122000001)(66574015)(66446008)(66556008)(8936002)(52536014)(8676002)(83380400001)(316002)(110136005)(38100700002)(186003)(2906002)(53546011)(7696005)(26005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGM2bmVjTUEwL1p1RlZxVXVTKzFTdFduNEEyejY3bHZXQzZJTitCMnY5elh5?=
 =?utf-8?B?TGJhNlM5Z0JkalVBV3l4bnltS0ZVUFY3KzBObzFiOThSRnN5WS8rQ2g5Z1kr?=
 =?utf-8?B?b09lSlgvQlNZcjRFNjgvblBrUlNjQXhGMGlPQmM4eVVIeXJLRlNFdFFWNmlR?=
 =?utf-8?B?aHBLOU1UWS96RDJyTjJqSG9FTmZzY3RVcWNFY2NCbUh3RVlrZ3hqQm9GSlRn?=
 =?utf-8?B?RlJPcWxzbkkyZ2NaRGtXQ0dwc3FIdVlzc3ZmeTh3aXlrMGZiZWRYUEM3LzR0?=
 =?utf-8?B?bjFLNXFvbjVEU1g5WENiMzMxQTd3R0hwQUdpamF2cHhmY3oveGFuVVlCcEFk?=
 =?utf-8?B?MEl6VGxZNVZwcnRPYmVaRllwQ3p4M01XaGhIWXBUSmU5WklSbWNhcVdRQmRK?=
 =?utf-8?B?UG5nRGt6WitNU3ZuYW1vYlV2S09LQjg4ZVJ0K2R1UlgvWE1wRlViczUrWEdt?=
 =?utf-8?B?alc2SWZMVHI0Y2pRZTM2TVQ2VWNlaUt4YUE4cVBMM093V2RpSmhIZHdRbEQ1?=
 =?utf-8?B?SnlGQkU1SUwwaHJXN2dYZ0JZREZzVmtlMi9iejhic213Yk5DQ0c0MDhJcmFF?=
 =?utf-8?B?djhiZ05CcWR2NXVVaFhBQllyUTloNXpWYXM1bThpZ1pRU3VMdndGQXc2V2d1?=
 =?utf-8?B?NlFMSUlFdHdNMENRVmxkSmtuaklFRmVKVW14bEFieSsrV25EUkZRck90K0ZP?=
 =?utf-8?B?am43ZnZQSzA0cDhHdFh5dHdMcjgzU3VSYm1iazBqOVVvckptZGF4N0h0T2JY?=
 =?utf-8?B?c3c1TXRzN0orMkxOdnorWG1zVGhrbG0xYXcvZWJyU2Q3QzNiNUYzdFJYdnhM?=
 =?utf-8?B?dk1GdHhleUk0MnI4Q21sTnI2V0x6dVd3dk1Kekw5ZEZwOC9NVVVTWHJwbEpo?=
 =?utf-8?B?ak9PcDhUSDczeTZSc2lmeG5rekJ4Q09PcTB4N2FaQnEyUXhBNU9sK2lGM3lV?=
 =?utf-8?B?eDc0NTRkbmgvd3l0S1RqQmVCeDNEY3d6WjIxaWFONy9xL2tyVndJcFFnVGRR?=
 =?utf-8?B?QWlaTE9tVnFWR3FUVTJiS0hmQ1FiR2RvNXRkRG01WUZxVDkvcGZvNE5SbUQ1?=
 =?utf-8?B?eDQySVh4dnhtUzhPWWNOeVlxN1R3TDErakdObVJ3ZWgwVnhkam9JMDRqT2tK?=
 =?utf-8?B?NmthbHhrTGF3N2d2R1M2MWtBRTFUUVQxTTlEZ0hkd2VlRHhiclVRbVEwSksy?=
 =?utf-8?B?Wkl0aWxFaXlWZElDL0J1bXZGTEF5RFovVUsyNXZ5REFVSmttdFQ3TDA3S290?=
 =?utf-8?B?WXF6QXBpajErQjkwWHdwNVpzdGpDdFNLV2tjVkErZENJM0pSZEJobkRlMlRn?=
 =?utf-8?B?N05UdnZWN0MzMk5tQTk1dWFxZ042Uk9Md1Y0dy9URUpUYUc2THV3MjlVNXd6?=
 =?utf-8?B?VnVGYUlyMzdTY1E1ZE16dldQOVUwdnVYbDR6cXhuczQ3RkhXclB3R3VGY1Jx?=
 =?utf-8?B?YXQ1bmJsTFRSUHpOQ2h0Mms0OW5HZjBnTThUY3JQRDcrdUc0OEx6OTVpREtL?=
 =?utf-8?B?Z1dPbUluNk8xaTFjK2hxK1lMMXREaTR0aWlDM3ZXZWExYXZJL2I2SDI5c0ps?=
 =?utf-8?B?N1UzajhkL2gyRlpuTzVkckhyRHpXa2p3MkZTWkJ6WjFLLzMwZHl4VU1FOWZq?=
 =?utf-8?B?MHV1SFNYYnNiczJnVHR6bVJkcFFOYjFkc3BTcDl4UGlEdGFoYmxuV3hUeVlU?=
 =?utf-8?B?eHlkRmN4cjBCS2RsUkN5c0JFcFFWcjc4ZzBwNjhCeGFJL08raEZ2SnlkZTY4?=
 =?utf-8?Q?vEJS37Za487vJobWHQf+LBKD0nWWif6kifN+Oth?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc8b071-b4aa-4fa7-911e-08d97f4757ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 10:37:44.0155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Su33FRvOBsoSdue28hCL1mwkuNGa/JUgXUobQvQl1DEMAp9n4qQm0kUrknajtPufbSf1vUh6sz+YUnbxJmYsOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPkZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwu
Y29tPg0KPlNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDI0LCAyMDIxIDI6MzcgUE0NCj5UbzogWXUs
IExhbmcgPExhbmcuWXVAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+PENocmlzdGlhbi5L
b2VuaWdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Q2M6IEt1ZWhs
aW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT47IEh1YW5nLCBSYXkNCj48UmF5Lkh1
YW5nQGFtZC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2tmZDogZml4IHR0bV9ib19y
ZWxlYXNlIHdhcm5pbmcNCj4NCj5BbSAyNC4wOS4yMSB1bSAwODozNCBzY2hyaWViIFl1LCBMYW5n
Og0KPj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCj4+DQo+Pg0KPj4NCj4+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4u
S29lbmlnQGFtZC5jb20+DQo+Pj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjEgMTo1
NCBQTQ0KPj4+IFRvOiBZdSwgTGFuZyA8TGFuZy5ZdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4+PiBDYzogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0Bh
bWQuY29tPjsgSHVhbmcsIFJheQ0KPj4+IDxSYXkuSHVhbmdAYW1kLmNvbT4NCj4+PiBTdWJqZWN0
OiBSZTogW1BBVENIXSBkcm0va2ZkOiBmaXggdHRtX2JvX3JlbGVhc2Ugd2FybmluZw0KPj4+DQo+
Pj4NCj4+PiBBbSAyNC4wOS4yMSB1bSAwNzo1MCBzY2hyaWViIFl1LCBMYW5nOg0KPj4+PiBbQU1E
IE9mZmljaWFsIFVzZSBPbmx5XQ0KPj4+Pj4gW1NOSVBdDQo+Pj4+Pj4+PiBIaSBDaHJpc3RpYW4s
DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gVGhhbmtzIGZvciB5b3VyIGV4cGxhbmF0aW9uIGFuZCBhZHZp
Y2UuIEkgZ290IHlvdXIgcG9pbnQuDQo+Pj4+Pj4+PiBBY3R1YWxseSwgdGhlc2UgQk9zIGFyZSBh
bGxvY2F0ZWQgYW5kIHBpbm5lZCBkdXJpbmcgYSBrZmQgcHJvY2Vzcw0KPmxpZmVjeWNsZS4NCj4+
Pj4+Pj4+IEkgd2lsbCB0cnkgdG8gYWRkIGEgZmxhZyBpbnRvIHN0cnVjdCBrZ2RfbWVtIHRvIGlu
ZGljYXRlIHdoaWNoDQo+Pj4+Pj4+PiBCTyBpcyBwaW5lZCBhbmQgc2hvdWxkIGJlIHVucGlubmVk
LiBXaGljaCB3aWxsIG1ha2UNCj4+Pj4+Pj4+IGFtZGdwdV9ib19waW4vYW1kZ3B1X2JvX3VucGlu
IGNhbGxzIGJhbGFuY2VkLiBUaGFua3MhDQo+Pj4+Pj4+IFRoYXQgaXNuJ3QgdG8gbXVjaCBiZXR0
ZXIuIFRoZSByZWFsIHNvbHV0aW9uIHdvdWxkIGJlIHRvIHVucGluDQo+Pj4+Pj4+IHRoZW0gd2hl
biB0aGUga2ZkIHByb2Nlc3MgaXMgZGVzdHJveWVkLg0KPj4+Pj4+IFllcywgd2lsbCB1bnBpbiB0
aGVtIHdoZW4gdGhlIGtmZCBwcm9jZXNzIGlzIGRlc3Ryb3llZC4NCj4+Pj4+PiBCdXQgd2Ugc2hv
dWxkIGluZGljYXRlIHdoaWNoIEJPIGlzIHBpbm5lZCBhbmQgc2hvdWxkIGJlIHVucGlubmVkLiBS
aWdodD8NCj4+Pj4+IFdlbGwgbm90IHdpdGggYSBmbGFnIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQu
DQo+Pj4+Pg0KPj4+Pj4gVGhlIGtub3dsZWRnZSB3aGljaCBCTyBpcyBwaW5uZWQgYW5kIG5lZWRz
IHRvIGJlIHVucGlubmVkIHNob3VsZA0KPj4+Pj4gY29tZSBmcm9tIHRoZSBjb250cm9sIGxvZ2lj
IGFuZCBub3QgYmUgcGFwZXJlZCBvdmVyIGJ5IHNvbWUgZ2VuZXJhbA0KPmhhbmRsaW5nLg0KPj4+
Pj4gVGhhdCdzIHRoZSBiYWNrZ3JvdW5kIHdoeSB3ZSBoYXZlIHJlbW92ZWQgdGhlIGdlbmVyYWwg
aGFuZGxpbmcgZm9yDQo+Pj4+PiB0aGlzIGZyb20gVFRNIGluIHRoZSBmaXJzdCBwbGFjZS4NCj4+
Pj4+DQo+Pj4+PiBJbiBvdGhlciB3b3JkcyB3aGVuIHlvdSBuZWVkIHRvIHBpbiBhIEJPIGJlY2F1
c2UgaXQgaXMga21hcHBlZCBpdA0KPj4+Pj4gc2hvdWxkIGJlIHVucGlubmVkIHdoZW4gaXQgaXMg
a3VubWFwcGVkIGFuZCBpZiB5b3UgZG9uJ3Qga3VubWFwIGF0DQo+Pj4+PiBhbGwgdGhlbiB0aGVy
ZSBpcyBzb21ldGhpbmcgd3Jvbmcgd2l0aCB0aGUgY29kZSBzdHJ1Y3R1cmUgZnJvbSBhDQo+Pj4+
PiBoaWdoZXIgbGV2ZWwNCj4+PiBwb2ludCBvZiB2aWV3Lg0KPj4+PiBZZXMsIHRoaXMgZnVuY3Rp
b24gImFtZGdwdV9hbWRrZmRfZ3B1dm1fbWFwX2d0dF9ib190b19rZXJuZWwiIGRpZCBhDQo+Pj4+
IGttYXAsIGJ1dCB3aXRob3V0IGEga3VubWFwIHdoZW4gdGhlIGtmZCBwcm9jZXNzIGlzIGRlc3Ry
b3llZC4gVGhlDQo+Pj4+IGZsYWcNCj4+PiBhY3R1YWxseSBpbmRpY2F0ZXMga21hcC9rdW5tYXAu
DQo+Pj4NCj4+PiBXZWxsIHRoYXQncyB0aGUgd3JvbmcgYXBwcm9hY2ggdGhlbi4gSSBtZWFuIHlv
dSBuZWVkIHRvIGhhdmUgdGhlIEJPDQo+Pj4gcmVmZXJlbmNlIGFuZCB0aGUgbWFwcGVkIHBvaW50
ZXIgc29tZXdoZXJlLCBkb24ndCB5b3U/DQo+Pj4NCj4+PiBIb3cgZG8geW91IGNsZWFuIHRob3Nl
IHVwPw0KPj4gVGhleSBhcmUgcmVzcGVjdGl2ZWx5IGNsZWFuZWQgYnkgIiBrZmRfcHJvY2Vzc19k
ZXZpY2VfZnJlZV9ib3MgIiBhbmQgIg0KPmtmZF9wcm9jZXNzX2Rlc3Ryb3lfcGRkcyIuDQo+PiBM
ZXQgbWUgcHV0IHRoZSBjb2RlIGhlcmUuIFRoYW5rcyENCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oDQo+PiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuaA0KPj4gaW5kZXggZWMwMjhjZjk2M2Y1Li5k
NjViM2JmMTNmZDggMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYW1ka2ZkLmgNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmQuaA0KPj4gQEAgLTgxLDYgKzgxLDcgQEAgc3RydWN0IGtnZF9tZW0gew0KPj4NCj4+
ICAgICAgICAgIGJvb2wgYXFsX3F1ZXVlOw0KPj4gICAgICAgICAgYm9vbCBpc19pbXBvcnRlZDsN
Cj4+ICsgICAgICAgYm9vbCBpc19tYXBwZWRfdG9fa2VybmVsOw0KPg0KPlllYWgsIHRoYXQgaXMg
ZXhhY3RseSB3aGF0IHlvdSBhYnNvbHV0ZWx5IHNob3VsZCBOT1QgZG8uDQo+DQo+PiAgIH07DQo+
Pg0KPj4gICAvKiBLRkQgTWVtb3J5IEV2aWN0aW9uICovDQo+PiBAQCAtMjc4LDYgKzI3OSw4IEBA
IGludCBhbWRncHVfYW1ka2ZkX2dwdXZtX3N5bmNfbWVtb3J5KA0KPj4gICAgICAgICAgICAgICAg
ICBzdHJ1Y3Qga2dkX2RldiAqa2dkLCBzdHJ1Y3Qga2dkX21lbSAqbWVtLCBib29sIGludHIpOw0K
Pj4gICBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9tYXBfZ3R0X2JvX3RvX2tlcm5lbChzdHJ1Y3Qg
a2dkX2RldiAqa2dkLA0KPj4gICAgICAgICAgICAgICAgICBzdHJ1Y3Qga2dkX21lbSAqbWVtLCB2
b2lkICoqa3B0ciwgdWludDY0X3QgKnNpemUpOw0KPg0KPlRoZSByZWFsIHF1ZXN0aW9uIGlzIHdo
byBpcyBjYWxsaW5nIHRoaXMgZnVuY3Rpb24gaGVyZT8NCg0KQ3VycmVudGx5ICB0aGVyZSBhcmUg
MyBwbGFjZXMgY2FsbGVkIGZ1bmN0aW9uICJhbWRncHVfYW1ka2ZkX2dwdXZtX21hcF9ndHRfYm9f
dG9fa2VybmVsIiB0byBrbWFwIGEgQk8uIA0KDQoxLCBrbWFwIGEgcHRyIGZvciBwZGQtPnFwZC0+
Y3dzcl9rYWRkcg0KQ2FsbCBzdGFjazoNCmFtZGdwdV9hbWRrZmRfZ3B1dm1fbWFwX2d0dF9ib190
b19rZXJuZWwNCmtmZF9wcm9jZXNzX2FsbG9jX2dwdXZtDQprZmRfcHJvY2Vzc19kZXZpY2VfaW5p
dF9jd3NyX2RncHUNCmtmZF9wcm9jZXNzX2RldmljZV9pbml0X3ZtDQprZmRfaW9jdGxfYWNxdWly
ZV92bQ0KDQoyLCBrbWFwIGEgcHRyIGZvciBwZGQtPnFwZC0+aWJfa2FkZHINCkNhbGwgc3RhY2s6
DQphbWRncHVfYW1ka2ZkX2dwdXZtX21hcF9ndHRfYm9fdG9fa2VybmVsDQprZmRfcHJvY2Vzc19h
bGxvY19ncHV2bQ0Ka2ZkX3Byb2Nlc3NfZGV2aWNlX3Jlc2VydmVfaWJfbWVtDQprZmRfcHJvY2Vz
c19kZXZpY2VfaW5pdF92bQ0Ka2ZkX2lvY3RsX2FjcXVpcmVfdm0NCg0KMywga21hcCBhIHB0ciBm
b3IgcC0+c2lnbmFsX3BhZ2UtPmtlcm5lbF9hZGRyZXNzDQpDYWxsIHN0YWNrOg0KYW1kZ3B1X2Ft
ZGtmZF9ncHV2bV9tYXBfZ3R0X2JvX3RvX2tlcm5lbA0Ka2ZkX2lvY3RsX2NyZWF0ZV9ldmVudA0K
DQpUaGUgcHJvYmxlbSBpcyB0aGVzZSBrbWFwZWQgQk9zIHdlcmUgbm90IGt1bm1hcGVkIHByb3Bl
cmx5IA0Kd2hlbiB0aGUga2ZkIHByb2Nlc3MgaXMgZGVzdHJveWVkLg0KDQpSZWdhcmRzLA0KTGFu
Zw0KDQo+PiArdm9pZCBhbWRncHVfYW1ka2ZkX2dwdXZtX3VubWFwX2d0dF9ib19mcm9tX2tlcm5l
bChzdHJ1Y3Qga2dkX2Rldg0KPiprZ2QsDQo+PiArICAgICAgICAgICAgICAgc3RydWN0IGtnZF9t
ZW0gKm1lbSk7DQo+PiAgIGludCBhbWRncHVfYW1ka2ZkX2dwdXZtX3Jlc3RvcmVfcHJvY2Vzc19i
b3Modm9pZCAqcHJvY2Vzc19pbmZvLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IGRtYV9mZW5jZSAqKmVmKTsNCj4+ICAgaW50IGFtZGdwdV9h
bWRrZmRfZ3B1dm1fZ2V0X3ZtX2ZhdWx0X2luZm8oc3RydWN0IGtnZF9kZXYgKmtnZCwgZGlmZg0K
Pj4gLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZt
LmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5j
DQo+PiBpbmRleCAyZDZiMmQ3N2I3MzguLjQ1Y2NiZTlmNjNlZSAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+PiBAQCAt
MTg1Nyw2ICsxODU3LDggQEAgaW50DQo+PiBhbWRncHVfYW1ka2ZkX2dwdXZtX21hcF9ndHRfYm9f
dG9fa2VybmVsKHN0cnVjdCBrZ2RfZGV2ICprZ2QsDQo+Pg0KPj4gICAgICAgICAgYW1kZ3B1X2Jv
X3VucmVzZXJ2ZShibyk7DQo+Pg0KPj4gKyAgICAgICBtZW0tPmlzX21hcHBlZF90b19rZXJuZWwg
PSB0cnVlOw0KPj4gKw0KPj4gICAgICAgICAgbXV0ZXhfdW5sb2NrKCZtZW0tPnByb2Nlc3NfaW5m
by0+bG9jayk7DQo+PiAgICAgICAgICByZXR1cm4gMDsNCj4+DQo+PiBAQCAtMTg3MCw2ICsxODcy
LDIwIEBAIGludA0KPmFtZGdwdV9hbWRrZmRfZ3B1dm1fbWFwX2d0dF9ib190b19rZXJuZWwoc3Ry
dWN0IGtnZF9kZXYgKmtnZCwNCj4+ICAgICAgICAgIHJldHVybiByZXQ7DQo+PiAgIH0NCj4+DQo+
PiArdm9pZCBhbWRncHVfYW1ka2ZkX2dwdXZtX3VubWFwX2d0dF9ib19mcm9tX2tlcm5lbChzdHJ1
Y3Qga2dkX2Rldg0KPj4gKyprZ2QsIHN0cnVjdCBrZ2RfbWVtICptZW0pIHsNCj4+ICsgICAgICAg
c3RydWN0IGFtZGdwdV9ibyAqYm8gPSBtZW0tPmJvOw0KPj4gKw0KPj4gKyAgICAgICBpZiAoIW1l
bS0+aXNfbWFwcGVkX3RvX2tlcm5lbCkNCj4+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+PiAr
DQo+PiArICAgICAgIGFtZGdwdV9ib19yZXNlcnZlKGJvLCB0cnVlKTsNCj4+ICsgICAgICAgYW1k
Z3B1X2JvX2t1bm1hcChibyk7DQo+PiArICAgICAgIGFtZGdwdV9ib191bnBpbihibyk7DQo+PiAr
ICAgICAgIGFtZGdwdV9ib191bnJlc2VydmUoYm8pOw0KPj4gKyAgICAgICBtZW0tPmlzX21hcHBl
ZF90b19rZXJuZWwgPSBmYWxzZTsgfQ0KPj4gKw0KPj4gICBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2
bV9nZXRfdm1fZmF1bHRfaW5mbyhzdHJ1Y3Qga2dkX2RldiAqa2dkLA0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qga2ZkX3ZtX2ZhdWx0X2lu
Zm8gKm1lbSkNCj4+ICAgew0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9wcm9jZXNzLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3By
b2Nlc3MuYw0KPj4gaW5kZXggMjFlYzhhMThjYWQyLi5mNTUwNmIxNTNhZWQgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQo+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQo+PiBAQCAtOTQxLDYgKzk0
MSw4IEBAIHN0YXRpYyB2b2lkIGtmZF9wcm9jZXNzX2RldmljZV9mcmVlX2JvcyhzdHJ1Y3QNCj5r
ZmRfcHJvY2Vzc19kZXZpY2UgKnBkZCkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHBlZXJfcGRkLT5kZXYtPmtnZCwgbWVtLCBwZWVyX3BkZC0+ZHJtX3ByaXYpOw0KPj4gICAg
ICAgICAgICAgICAgICB9DQo+Pg0KPj4gKw0KPj4gKyBhbWRncHVfYW1ka2ZkX2dwdXZtX3VubWFw
X2d0dF9ib19mcm9tX2tlcm5lbChwZGQtPmRldi0+a2dkLCBtZW0pOw0KPj4gKw0KPg0KPlRoYXQn
cyBhIGdlbmVyYWwgY2xlYW51cCBmdW5jdGlvbiBmb3IgdXNlciBzcGFjZSBhbGxvY2F0aW9ucyBh
bmQgc2hvdWxkIG5vdCBiZQ0KPmFidXNlZCBmb3Igc3R1ZmYgbGlrZSB0aGF0Lg0KPg0KPlJlZ2Fy
ZHMsDQo+Q2hyaXN0aWFuLg0KPg0KPj4gICAgICAgICAgICAgICAgICBhbWRncHVfYW1ka2ZkX2dw
dXZtX2ZyZWVfbWVtb3J5X29mX2dwdShwZGQtPmRldi0+a2dkLCBtZW0sDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBkZC0+ZHJtX3By
aXYsIE5VTEwpOw0KPj4gICAgICAgICAgICAgICAgICBrZmRfcHJvY2Vzc19kZXZpY2VfcmVtb3Zl
X29ial9oYW5kbGUocGRkLCBpZCk7DQo+Pg0KPj4gUmVnYXJkcywNCj4+IExhbmcNCj4+DQo+Pj4g
UmVnYXJkcywNCj4+PiBDaHJpc3RpYW4uDQo=
