Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C724FC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 14:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFED010FBC1;
	Thu, 30 Jun 2022 14:18:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17C4A88C11
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 14:18:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPYe/y3mwzPbqA+lhooK52SqTlwJWY+vXnje1uPHMbUb++MZltcdiBjD+GnbR2+qmqLnRS2No7WN+IN8iWzdFsVM+GW4YpD7bRDNEc0v46anHyk/fS3X/IXTbYLzDXhmDz07smVGFeZSRYPnYulmfjlUuFbb/z84opOooIWqwDi9JmiTBxMD/aFwf5HfKt4n/Qu2LlzQJQw+n0BpwUIhdzouskVugBOGqPu+ZqkaqPtZ/RdIuBVSEBULbT1gtKrnljYGLLfmESy8ydLnOvBegKVAVJC7CbNos5ebrmWZoIwr1bVLcf0cjlmUcnXlYoXeejiv7mdCSpdKj3XqC2jyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jZ4PpQKiJBiEK+r6E1LQdwe7kdZrkbTLA54mlM8p7E=;
 b=Xyajn1IM/14ebLMTF2wMXd7vLL34yYxpTLokuHhw/geuImTYCVtykiqneeMlHZD1kXS4ZWFm2Al5Nue7Ods+u9NGqR/mXYt0Tgi/5Q5/XlndktWgSQdilCxP7tZAiy8bw+rNoowaAzXphLtrD0A8XJDvlDXnusKWHq8IImZPwQt+0UTR84L31cOuKjMOQ8FPjzFBUbZbMloE98NVdAJW1uhYAMxbOJvyBzCee5GyQWx5jTC+dhDZfpLvaAdkqd+2Cj8/WjmLucVBvh0dgfnAphmMT+A6uXCrp4P9N9wQhyjmIWZaD3tbuy9/wqrdXSo51HhZXuI0t4MVMc/hTViEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jZ4PpQKiJBiEK+r6E1LQdwe7kdZrkbTLA54mlM8p7E=;
 b=5WjNkd7IeAhE55/Np5HnyUzGxstN9St76EnnMVX8aYks1UsAAqfz78yVq9kfyH97NzAajs3UV0koVIfzH2+eehKYhLZDBUZhv0mNyNKCiOxL14mhtDwvrnwMLgxhQoGCUCt9xVJcvQ7NT4V/EnyTaNmR3fT7y8k9CKn79OmVY2I=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 BN6PR1201MB0068.namprd12.prod.outlook.com (2603:10b6:405:53::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 14:18:47 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::11ca:14fb:e8ea:627f]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::11ca:14fb:e8ea:627f%6]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 14:18:46 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdkfd: simplify vm_validate_pt_pd_bos
Thread-Topic: [PATCH v3] drm/amdkfd: simplify vm_validate_pt_pd_bos
Thread-Index: AQHYf83d1UyuQscO60yjNuM0pMS8p61OnOEAgBl7qEA=
Date: Thu, 30 Jun 2022 14:18:46 +0000
Message-ID: <DM6PR12MB425034712C2DA725D2AB6A81FBBA9@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20220614090307.999988-1-Lang.Yu@amd.com>
 <77fb7897-0a54-cdc6-4c1a-77b7ec82f9f4@amd.com>
In-Reply-To: <77fb7897-0a54-cdc6-4c1a-77b7ec82f9f4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-30T14:18:44Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b1fdce09-f098-4a57-b23f-ab3289812942;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-30T14:18:44Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 07efaafa-1d2e-4b30-bc64-374dffc4cf3f
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4df13492-2297-493f-44c6-08da5aa37219
x-ms-traffictypediagnostic: BN6PR1201MB0068:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4e6d3F5/QqTWCpVrvn9aqN1hsm9OaMvfEoYeg7OaZcAwi7Fv8YgmHuoH3ouK7TO+4ZZHvrHILJoAV7FvmdfBRMewjQzrxSy2p+YndykKqUmwCgDSAuPHhq8I/8YQHWv/5MuHgVEp9S9DC17TMo62tzablVz7XAXuWFklrNjx1/TKNAhdQVjmLYc3PYb1nFAQ2bW1/naUCEdhudcgVgg1RCmQKslQYAnj3TsW9uwLn3SVu9kVwv/noznU9N7SMoR3TIultDGM0AxJ0axwIptewGYGjgqv2oFEoY1ok4RoIkzhV6OXMJFAeWdNkScRrWFHAhZPw2OZ08SIlI4EpC0mUensm3/WKdE1njzibBbZVWANBlhQA/qWEu/JpLWvD1GlLelRpp6DPgau2HdULxTK93woxXoIJ/gX/2HRDWwPoMZISOAsbcBMZLTKtmsLBEWAsf8MACQAZftCmJsTg8gHz53Nc+j9C7YrPKnXvR1zEple3qQs+pA+8SDK7dfvfICczmtCoBeljyNHlMbIMXBCnP+EkU76vr4vxo02T+feflAEulPhzanqX6cofCvz3iR7i8MPonMxVbd2U+IbnTKr+h6/7OLsCw3J9Eh/pUO/1K0OcuwqK5QnmubxtkREuPcR9WkuQ7c+R0THrYMjc0BQSoOEK3AofoXNTkRBAzmaGofCKndOJSv3rE1QpW5U/wMQTCjXBbd7VZTDgvbeV0Djn4vVMUY3n+m/1DgNsGkyPIHqDFeSefFTOA/QqNpRDKIb38/qR4JjebbyzKc/jVHYw+uN2ezCRsLjr0f0JqUlpQPV/T6cBW2iRHUdSAUgQqwN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(76116006)(66556008)(64756008)(316002)(66446008)(8676002)(478600001)(66946007)(66476007)(55016003)(54906003)(4326008)(71200400001)(2906002)(110136005)(5660300002)(52536014)(6506007)(66574015)(8936002)(38100700002)(186003)(122000001)(26005)(9686003)(33656002)(38070700005)(86362001)(7696005)(41300700001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTY3dXVFZHU3K3BZZDdQaXRCUmY0aUFzWHAvKzNJN3JsMkVzaCtkRERPRTlH?=
 =?utf-8?B?Z3dPL3VBSk5sRjBXQXRMSjZocVdpTExacHUyS0xYT3ErdEFydE9DMEtHOW8z?=
 =?utf-8?B?UW85Z21BVG52R2dMZkhNOHEyZnMwajF3T2VBUVM3Tm1pM1lYUTVIUlFJUFJO?=
 =?utf-8?B?UWJGNVFXZFRBcEFTZ1JmSWp4ZWZuNzhlb2tDMndtYVVZdmptOGc0K1JFMWpr?=
 =?utf-8?B?WlFlVXhCVFFFOUVWYXJyN1luVmcvYllZVVAvQUgvSnl2b2ZSdWFkbVRMalhZ?=
 =?utf-8?B?RGo0OHA2T095M3NoaVptdVVhMThRbElzMjdTdHQzVjRBVjNJcW9VSXl6RlVW?=
 =?utf-8?B?VEhjVVFSRmpIdHA1MkZ2Q2psclFUNDdiVHpZYUpNTWFmdlJUdURYNitRSFRP?=
 =?utf-8?B?ZUFvQlJnaTBlVTd2S1plRzRVdU1QRHpZcTA3WXpFaUk5a2FrYURFaXBWZ2ZO?=
 =?utf-8?B?UnFneXk4Z2kzZUcvRy9zUUx0aG96K2E3WitVdmU2VUE5a0wvNjQ1VnVnbTUx?=
 =?utf-8?B?TitMdmNzdEorY2RsakkybmNlM09UWEdLYkk1Y0g2b0VYNVk5eGh1dEE4SnF3?=
 =?utf-8?B?YlhtRUt5V2NMT3pPb1ZyczRJMStGaDJyMis1Q2UrdTNmUWY5ZW5zbjVqYklx?=
 =?utf-8?B?dktzNlZFcVN5SHVSVG1OcWxlR251T0Y5S2hCZlptdjBHMlFIb1JWdis2MElk?=
 =?utf-8?B?d251QjlzUGwyN25TL1BXaHBINWtFclZVKzhWdHRBaUtyTDhCTnJFK0xGd091?=
 =?utf-8?B?dmFIajNBQkRXMStMVUhpQnp6NW9CclpRVzg2d3d0TndoeVpGVWFGMkM0Y2R5?=
 =?utf-8?B?Uk82OGtvbE40VGh3SnQ5MzdBTUhrbHI3VXhLZ1llTmZYL0NObGtyaEtvY3Z1?=
 =?utf-8?B?UElmdVViWkh6Mkd6YWRtdTB0U0plUlE0U2Ewd0V4ekFwcStqUjlUNDdDbHBu?=
 =?utf-8?B?YWlMVHFBSkU3c1hZcmYybVNzbGh3RkJpVTV3eU9heDF1UGZublE2WUdxcmVH?=
 =?utf-8?B?SXZwbHNKZHZucU8zaEwwV2YwcnJZYXZsdjVZeE9pZ3ZiQng4d3JIaGgxNkZQ?=
 =?utf-8?B?Q3pCZW5yL3IxLy9aMzhvK2l6NHBoYWdmdC82Q1JWbzhHd0VlNHZEb2g4SFlU?=
 =?utf-8?B?Sitvc3JoOGwzUTM4K0lHZTl5WmpnV3YxUTQvVlAvaVlmcTgrMk1LeVFxZDRk?=
 =?utf-8?B?M2FCNnZjZCtjd0plNVB2bmd3aXRiMXV5aVFpc2NOUmtQUzdhSDRXYW9WajZi?=
 =?utf-8?B?REY1UnhFUGNwVmNVbFlGZHJYYmVuOW5VL2NVNGljSEE1bk5CSjh1QnZ2UDMy?=
 =?utf-8?B?SzN6ZmlxSGhkVHd4bGxyVVlEVDQxTHhTTWZRZ3pSWG9hS1FhcE8rN2U0NWdJ?=
 =?utf-8?B?ZWZYUjY4VUd5eTRYZmcrR0lFSWl4VWxwc09HR2pvU1FtdzN2WFNVQ2tLSXZl?=
 =?utf-8?B?a3MzRE9YSk9BWm5XV3FXcTMrblArYWhCQTY2cHBDazlzbklWdER0VkJkcysr?=
 =?utf-8?B?T3ZIb1FVZlV5OXBWbHVlS3djVUVFRk9UU0kvZEV0d21ER3ZYQ1BUL08zZUJa?=
 =?utf-8?B?Q0RnVXJqNXo2RzM1MWhWR3ZicXNyMzU2VFlPbVFIRGxNbk1DYytvR0c4NUw0?=
 =?utf-8?B?TTdiai9XdmZGNnM0OTIxN0ZoUFJOS2hTR01yUFp2K0twMmVHSDVNakNqNkpq?=
 =?utf-8?B?SUovdFBySzNQMmlzZ2FDcGlGcGRlUVVaN3VEbkpxK01UY2lZNE4wUmJQdkVY?=
 =?utf-8?B?bjQ2bzJCQlFVNVkzK3Y1aXdhQm90N05VN2d3amVNM3NhUklkMUhDNy9PQ0hD?=
 =?utf-8?B?R0lndnRlbEc2Zk9rMzhCOUkrcjc1YzFNaUJSOU9MMjZIdGo4U2NHMlJBTHB0?=
 =?utf-8?B?MzBSWFR2aWpOMy9VUC9GRXhwbGlqU0c2YmJXVWl5VXl2bGdYMXprYm93V0c2?=
 =?utf-8?B?djRNd1JtbjVHdFFRT29TMU1ZM0VrZmNTc1lZdnpNempGU1BENEZ3VlF4OWw2?=
 =?utf-8?B?eGYzZGExWWltdnJHMTl3bFB2NXlYd0Q2QTdFalZ4SU95cFBtMnJIQ1NGOTZI?=
 =?utf-8?B?T1dzRVM5aU5EekFRTVBlS2ZDOW9VVlRTMnBhR0FZUy9yYXJ0cEttMDBHWDVx?=
 =?utf-8?Q?lDu0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df13492-2297-493f-44c6-08da5aa37219
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 14:18:46.6461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VP1z0t360GYftdcV/dAeo9XzOTjIpPZNzdGbqKA65CeCXegAYdFFGrdmEr1Ibth19rWxNzRL/Bfof66VezMXMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0068
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
 Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClBpbmchDQoNCkhpIEZlbGl4LCB3
aGF0IGRvIHlvdSB0aGluaz8gVGhhbmtzIQ0KDQpSZWdhcmRzLA0KTGFuZw0KDQo+LS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktv
ZW5pZ0BhbWQuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIEp1bmUgMTQsIDIwMjIgNTowOCBQTQ0KPlRv
OiBZdSwgTGFuZyA8TGFuZy5ZdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj5DYzogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgRGV1Y2hl
ciwgQWxleGFuZGVyDQo+PEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgUmF5IDxS
YXkuSHVhbmdAYW1kLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzXSBkcm0vYW1ka2ZkOiBz
aW1wbGlmeSB2bV92YWxpZGF0ZV9wdF9wZF9ib3MNCj4NCj5BbSAxNC4wNi4yMiB1bSAxMTowMyBz
Y2hyaWViIExhbmcgWXU6DQo+PiBXZSBkb24ndCBuZWVkIHRvIHZhbGlkYXRlIGFuZCBtYXAgcm9v
dCBQRCBzcGVjaWFsbHkgaGVyZSwgaXQgd291bGQgYmUNCj4+IHZhbGlkYXRlZCBhbmQgbWFwcGVk
IGJ5IGFtZGdwdV92bV92YWxpZGF0ZV9wdF9ib3MgaWYgaXQgaXMgZXZpY3RlZC4NCj4+DQo+PiBU
aGUgc3BlY2lhbCBjYXNlIGlzIHdoZW4gdHVybmluZyBhIEdGWCBWTSB0byBhIGNvbXB1dGUgVk0s
IGlmDQo+PiB2bV91cGRhdGVfbW9kZSBjaGFuZ2VkLCB3ZSBzaG91bGQgbWFrZSBzdXJlIHJvb3Qg
UEQgZ2V0cyBtYXBwZWQuIFNvDQo+PiBqdXN0IG1hcCByb290IFBEIGFmdGVyIHVwZGF0aW5nIHZt
LT51cGRhdGVfZnVuY3MgaW4NCj4+IGFtZGdwdV92bV9tYWtlX2NvbXB1dGUgd2hldGhlciB0aGUg
dm1fdXBkYXRlX21vZGUgY2hhbmdlZCBvcg0KPm5vdC4NCj4+DQo+PiB2MzoNCj4+ICAgLSBBZGQg
c29tZSBjb21tZW50cyBzdWdnZXN0ZWQgYnkgQ2hyaXN0aWFuLg0KPj4NCj4+IHYyOg0KPj4gICAt
IERvbid0IHJlbmFtZSB2bV92YWxpZGF0ZV9wdF9wZF9ib3MgYW5kIG1ha2UgaXQgcHVibGljLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IExhbmcgWXUgPExhbmcuWXVAYW1kLmNvbT4NCj4NCj5JIGNh
bid0IGp1ZGdlIHRoZSBrZmQgcGFydCwgYnV0IHRoZSBWTSBzdHVmZiBsb29rcyBnb29kIHRvIG1l
IG5vdy4NCj4NCj5BY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPg0KPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYyB8IDE0IC0tLS0tLS0tLS0tLS0NCj4tDQo+PiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jICAgICAgICAgICB8ICA4ICsrKysrKysrDQo+PiAg
IDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9n
cHV2bS5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1
dm0uYw0KPj4gaW5kZXggNTBiYjU5MGMzMzA2Li5jOWVmMjQyMTc3ZTIgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPj4g
QEAgLTQzOSwyMiArNDM5LDggQEAgc3RhdGljIGludCB2bV92YWxpZGF0ZV9wdF9wZF9ib3Moc3Ry
dWN0DQo+YW1kZ3B1X3ZtICp2bSkNCj4+ICAgCQlyZXR1cm4gcmV0Ow0KPj4gICAJfQ0KPj4NCj4+
IC0JcmV0ID0gYW1kZ3B1X2FtZGtmZF92YWxpZGF0ZV92bV9ibyhOVUxMLCBwZCk7DQo+PiAtCWlm
IChyZXQpIHsNCj4+IC0JCXByX2VycigiZmFpbGVkIHRvIHZhbGlkYXRlIFBEXG4iKTsNCj4+IC0J
CXJldHVybiByZXQ7DQo+PiAtCX0NCj4+IC0NCj4+ICAgCXZtLT5wZF9waHlzX2FkZHIgPSBhbWRn
cHVfZ21jX3BkX2FkZHIodm0tPnJvb3QuYm8pOw0KPj4NCj4+IC0JaWYgKHZtLT51c2VfY3B1X2Zv
cl91cGRhdGUpIHsNCj4+IC0JCXJldCA9IGFtZGdwdV9ib19rbWFwKHBkLCBOVUxMKTsNCj4+IC0J
CWlmIChyZXQpIHsNCj4+IC0JCQlwcl9lcnIoImZhaWxlZCB0byBrbWFwIFBELCByZXQ9JWRcbiIs
IHJldCk7DQo+PiAtCQkJcmV0dXJuIHJldDsNCj4+IC0JCX0NCj4+IC0JfQ0KPj4gLQ0KPj4gICAJ
cmV0dXJuIDA7DQo+PiAgIH0NCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMNCj4+IGluZGV4IDcwMzU1MmY5YTZkNy4uM2E2YjgyN2U1NDBjIDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+PiBAQCAtMjIyNSw2ICsyMjI1
LDE0IEBAIGludCBhbWRncHVfdm1fbWFrZV9jb21wdXRlKHN0cnVjdA0KPmFtZGdwdV9kZXZpY2Ug
KmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtKQ0KPj4gICAJfSBlbHNlIHsNCj4+ICAgCQl2bS0+
dXBkYXRlX2Z1bmNzID0gJmFtZGdwdV92bV9zZG1hX2Z1bmNzOw0KPj4gICAJfQ0KPj4gKwkvKg0K
Pj4gKwkgKiBNYWtlIHN1cmUgcm9vdCBQRCBnZXRzIG1hcHBlZC4gQXMgdm1fdXBkYXRlX21vZGUg
Y291bGQgYmUNCj5jaGFuZ2VkDQo+PiArCSAqIHdoZW4gdHVybmluZyBhIEdGWCBWTSBpbnRvIGEg
Y29tcHV0ZSBWTS4NCj4+ICsJICovDQo+PiArCXIgPSB2bS0+dXBkYXRlX2Z1bmNzLT5tYXBfdGFi
bGUodG9fYW1kZ3B1X2JvX3ZtKHZtLQ0KPj5yb290LmJvKSk7DQo+PiArCWlmIChyKQ0KPj4gKwkJ
Z290byB1bnJlc2VydmVfYm87DQo+PiArDQo+PiAgIAlkbWFfZmVuY2VfcHV0KHZtLT5sYXN0X3Vw
ZGF0ZSk7DQo+PiAgIAl2bS0+bGFzdF91cGRhdGUgPSBOVUxMOw0KPj4gICAJdm0tPmlzX2NvbXB1
dGVfY29udGV4dCA9IHRydWU7DQo=
