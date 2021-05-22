Return-Path: <SRS0=HO04=KR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC688C04FF3
	for <amd-gfx@archiver.kernel.org>; Sat, 22 May 2021 01:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E0C611ED
	for <amd-gfx@archiver.kernel.org>; Sat, 22 May 2021 01:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E0C611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76BAF6E8B4;
	Sat, 22 May 2021 01:48:28 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A33DC6E8B4
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 May 2021 01:48:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi3VAXda6aYwHuHic6s0jSWlFo3Knz0APZc/grpgFYlZZBdoi8Vxk7dkfv8oPmSsb2H6KlauIaEV5Lcr7rJ3EzxP8SLE5hUeIobhF4pMh2bSBx9HOV5/Oy8x6gMmnLskOcUzj0+p9Fmrq965Bvo4I4E3McPqBJcU3JGZAcjbsx027nWEudVqeezKCQ9rqOiAIdrG02oK4X+l/K6GhTQiew4HjSrbwcGR/bYjJXIBSZxHclDXKbF7nAKtdL9GJCZvnDaPsAMmZ0PFkRaEzHxbalaLJstKLwdzvZBHTb1cYiYEN96IDs80xFDrBaT9XewLNbAM59+R2aIP12KFQX31Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTG7Unm8UgHyGV43xV5su5Pwy1jG8wNnuYjcerH0pw8=;
 b=AdwKWaN7/A/CMfi9X2VRIeLPx2OOYgn0IlBAcpHPDA2aeKzMEBL/KhVNqLo2Al5XD1PiiW6I9aQLg3xbnCQ/NgVfzFeWjB/QAO4Kw9Nou9Bkjvk0xjqS7DLrTXB/VuhRHP1yvrKMX9Enqr+/2Zazz7yL7IrYkp8H7YatQco4lklCfkxH99fNTL3IzBTkIRPbULbOwY7wtnWF2crQDQPMYPvid6rSzFj6B7129edZDt3L9XtDplmHHqtGPzsyKG9qwo7Twa4M8b0l1IKa2gBmJwwXiSByza6exIRviw/hWlzElRVDpCVGZQpVpfGSi3b2K4aokKLT1DDm/ZXzB2WhXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTG7Unm8UgHyGV43xV5su5Pwy1jG8wNnuYjcerH0pw8=;
 b=5aGCp4XMXI5mckT+4L49eRUenqvX+8t+V8Nd0/8xB2BVY69hiRSzYSKZaupsadQd6xx96OkRbbAWhAfgdb2+z6BmSek4nfXEOHGVTHKZ6/Q8Bq+ktoeGQmz29VJ0fdp4pIAS9vgKqG/cdyyziJrvRAaGllhiRN1gzpD+Cg8ntrI=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.26; Sat, 22 May 2021 01:48:24 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::4543:6802:6acc:c92d]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::4543:6802:6acc:c92d%5]) with mapi id 15.20.4150.023; Sat, 22 May 2021
 01:48:24 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBkcm0vYW1kZ3B1OiBVc2UgZG1hX3Jlc3ZfbG9jayBp?=
 =?gb2312?Q?nstead_in_BO_release=5Fnotify?=
Thread-Topic: [PATCH] drm/amdgpu: Use dma_resv_lock instead in BO
 release_notify
Thread-Index: AQHXTgHc85yiMmEs2EaNhunEfUBSgqruQPmAgAB7PN0=
Date: Sat, 22 May 2021 01:48:24 +0000
Message-ID: <DM4PR12MB5165FC17DFB06D121EFB241487289@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20210521052606.20323-1-xinhui.pan@amd.com>,
 <1c46b6a8-db7a-9aaf-7909-c61886ce1879@amd.com>
In-Reply-To: <1c46b6a8-db7a-9aaf-7909-c61886ce1879@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-22T01:48:23.728Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a7a207c-fa3a-40ad-3588-08d91cc3afee
x-ms-traffictypediagnostic: DM4PR12MB5054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB505479FDF03853AA573A596C87289@DM4PR12MB5054.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oT1D2VrIvaqgCaU11r+Llh6UNBFoBize/dbbjdipqrrDTo3li7MPg8OI7z5BxLDMgtFltoDlfhJeC1qnZhZgkIOrSrTwT9NNf7fvu4Q2+eyga+RH7sqUbbM7DeXNTf1lMUggP/zOM7L4ZlC7KmjFLIb4ydu/MC+vdRFRMMVccszxkhisxXYQZwz9Lkisij+IgLYqptB9KU4Q7uzPxR4MymynSccmNF9Tl+4DwbLVSM/1l6zZhmPtVuGGl6dp6JJLOVTUO8ZzwxQtv2X9yQfY7ZHOyxgMA2A5x6JaD8EijbXfOQqu9fSZOfIbeh4ASARqy6PAPbT5MCnp26/w/R+F5S2xYgPyDfuforqHeU3Qumd54xUrUCNEG+VJMbIt78HyHCO9eJ/ObOsCqAa+vGkRv3Eo9X6JqPjZ/6kdredFtWl7fT8zhs7GMQNukjuV3NpjCYQXB7K31Y2UMdnfFz7bvuNIsHpfDQpNH1Czeuk4QxYJaWrYbvov7ANPno4lGWqqtkDqMjOUAdySfYdYHD2gWtTQHBvJ3J9M4Dknglj2eZV/ilQemGbdfo8pRR3WdBby3roKZyrQRye2Ar4cXNge0mWciXKK3rT6qUe8YzFQdzY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(7696005)(224303003)(9686003)(83380400001)(110136005)(38100700002)(66946007)(52536014)(478600001)(76116006)(6506007)(316002)(55016002)(33656002)(66446008)(64756008)(66556008)(91956017)(86362001)(54906003)(66476007)(5660300002)(26005)(122000001)(2906002)(71200400001)(8936002)(4326008)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?gb2312?B?eTU2bE1CSjhoY0tMSzNDQmt0Um1IcHVCNFdQaDltV2dhcDQyWlhPak1WU3h0?=
 =?gb2312?B?MDN5YWQ4K00yQi9zdmNZVG1ualdXWFE1VXVVb0hKdDFxNDFIODdSZVVBQUR4?=
 =?gb2312?B?TVZ2NmJjeDRZQU1TRDNUSVVLVCtYdG4rUG9RMjVkZk5IZFZ0YlNkTHFtMHJL?=
 =?gb2312?B?emxmWlRkK2dxa04zRittN01nSjk2blVIdUpnUzJxdUFhaVI5dmxzMlhXbkJk?=
 =?gb2312?B?aWZNdkZqOUVNY05RVTV2MHRRTjZmZG5LenVPVWZKSFlwaXNWcHE0QzFHbllC?=
 =?gb2312?B?ZmU4RDVhLzlXM1VEMWJmOFFLaFZKQ3hhWUxGelc3ZVlPdjlienVpcnplVTla?=
 =?gb2312?B?enliSUpSUzI3SUdZT3hFM3A2a2NYbURhN3hxSTJwN1hYZkFQb0RKYVBJaVZE?=
 =?gb2312?B?STVvMytTb2dBb1RYNlFZNXBqRjNhZlhNMVliSEg3MWJMK0wxRE5jbVpXVTZQ?=
 =?gb2312?B?d0RHa2tyME5HVkFWMjFpK3dDSFkxZXJLaExNUHJ4bC82emE1ZEhyUzBnS0I1?=
 =?gb2312?B?bEgrRFF0b1VpWUo2M3c3NHpoY1YrY3prdkh1K1ZwM2M5ZWJZZjkxSmhTNk1q?=
 =?gb2312?B?Lzh1T1dCc0R0WlhZTng1L0FMZ2hUN2lZZlloWjJLWEV1YVdvM2tzSjM5eWxD?=
 =?gb2312?B?SUNGUFdoQ0lxdkJCYXNDMThUcmhDK3Q2WkVOWjJhRkM1NmJDeHlJMDhyRENY?=
 =?gb2312?B?bEwzeFRYb0tlQmRIUEJWRUxSUHk5dkU0eGtXNGJiajVHN3lvMEIzMkx4RXI2?=
 =?gb2312?B?MFBqcFFBZ3B3TExHTnFPdXhGdE01R1JqV2ZCcUR2TG5Ia21kbjdMMVpYQlZ6?=
 =?gb2312?B?VThGNGRLYmNwZmh5NmtoTENhdjQxN25BelZNTXlLSnlKbm1nVVI5MDMwamgx?=
 =?gb2312?B?MHorS0MyakRPcVg5elFFdkdKOElKNml2K1hQRnJ1YmtPb2tYVzM2R2xGa0JZ?=
 =?gb2312?B?T3plNFZyeHJ5YmdReXIvT1NSZko2dXZRT2xaaHJNU1Y2NHFkemFSZ1FUL0do?=
 =?gb2312?B?VkZSSXB3TXBGTU1jTkF1eWRyNEZCRkQrZE9XSFJMN0xXMTVpa1ZCRXd1UHNM?=
 =?gb2312?B?WWRsbDR5ZmhBUzU1UFowT0ZMY1FkY0lZYmZaa0g1bmlwcDFiUzc2blVhR01L?=
 =?gb2312?B?NFY2Uzl3d2V0RElVbUtnSmI3ZDdrYURLamYyNnZYcUVrd1JCU2hqazhCTWpB?=
 =?gb2312?B?TVFNUk1OZm9JakUyd1MwbmFHdERNc004QzNuOEVoaFJOWkF1SzgzcTZ0Y2RT?=
 =?gb2312?B?NEF1cjVvTFd4MGtmYy91Wm9LV2ZYTEZSdEozZDhNSGExYm5ydGlpd2JyUXRn?=
 =?gb2312?B?QlpGMG9VdHVXbGhRbitNZ3dBQXAvUERNa2FVZXpBS0tQRTVkNTRMNmdzdDZX?=
 =?gb2312?B?ZUVMQ2JNMkI1N2kyVzQvLzdqSXV5RnlmVFR3SmVmRktZbVJIRVRIbThCQnp0?=
 =?gb2312?B?c3RRRnlSQWFKYnB6WWJudkZqc1RvUDZ5b2dqZSsrc0hwYkloNGtRZEVrR1VC?=
 =?gb2312?B?TVAwRnRRamV2ODZ1ZFFiS3dqUVFRSXh1QnhnQlBTaTJLRXUyaGVjbm9WV2g5?=
 =?gb2312?B?c2hkRkhROWxJYkpGZGVSUlN4MDB0OFhLbkhqZGlxbzdlUkZSNG42NkZqU25P?=
 =?gb2312?B?NFFFYVY4aHRJdFZBRURWbWloYUtIQ0N1T1paRUh3aTJjQkJEMkgwNjBDeStJ?=
 =?gb2312?B?Vm9uV2UzWW1ZRUQ5S3FLakx3QmZHN2MxRnZralFiTTh2NWl5RjVjdEVKY1J3?=
 =?gb2312?Q?aYv47rAWCFaCm11Gq4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7a207c-fa3a-40ad-3588-08d91cc3afee
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2021 01:48:24.3708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADdSIkMtpBJK7cZkSk0Lo9iLXBo5T36IeiGW0Zb96VheNwRkUWUEfXft+sGfIFqX
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KT2gsIHNvcnJ5IGZvciB0aGF0LiBJIG5vdGljZSB0
aGUgbG9ja2RlcCB3YXJuaW5nIHRvby4NCkkganVzdCB0aGluayB3ZSB1c2UgdHJ5bG9jayBlbHNl
d2hlcmUgYmVjYXVzZSB3ZSBob2xkIHRoZSBscnVfbG9jayBtb3N0bHkuDQpTbyBJIHRoaW5rIHdl
IGNhbiBkbyBzb21ldGhpbmcgbGlrZSBiZWxvdy4gTGV0IG1lIHZlcmlmeSBpdCBsYXRlci4NCg0K
QEAgLTMxOCw3ICszMTgsOSBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9yZW1vdmVfZmVuY2Vfb25fcHRf
cGRfYm9zKHN0cnVjdCBhbWRncHVfYm8gKmJvKQ0KICAgICAgICBlZiA9IGNvbnRhaW5lcl9vZihk
bWFfZmVuY2VfZ2V0KCZpbmZvLT5ldmljdGlvbl9mZW5jZS0+YmFzZSksDQogICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2FtZGtmZF9mZW5jZSwgYmFzZSk7DQoNCisgICAgICAg
c3Bpbl9sb2NrKCZiby0+dGJvLmJkZXYtPmxydV9sb2NrKTsNCiAgICAgICAgQlVHX09OKCFkbWFf
cmVzdl90cnlsb2NrKGJvLT50Ym8uYmFzZS5yZXN2KSk7DQorICAgICAgIHNwaW5fdW5sb2NrKCZi
by0+dGJvLmJkZXYtPmxydV9sb2NrKTsNCiAgICAgICAgcmV0ID0gYW1kZ3B1X2FtZGtmZF9yZW1v
dmVfZXZpY3Rpb25fZmVuY2UoYm8sIGVmKTsNCiAgICAgICAgZG1hX3Jlc3ZfdW5sb2NrKGJvLT50
Ym8uYmFzZS5yZXN2KTsNCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQq3orz+yMs6IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCrei
y83KsbzkOiAyMDIxxOo11MIyMsjVIDI6MjQNCsrVvP7IyzogUGFuLCBYaW5odWk7IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQqzrcvNOiBEZXVjaGVyLCBBbGV4YW5kZXI7IEtvZW5pZywg
Q2hyaXN0aWFuDQrW98ziOiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBVc2UgZG1hX3Jlc3ZfbG9j
ayBpbnN0ZWFkIGluIEJPIHJlbGVhc2Vfbm90aWZ5DQoNCg0KQW0gMjAyMS0wNS0yMSB1bSAxOjI2
IGEubS4gc2NocmllYiB4aW5odWkgcGFuOg0KPiBUaGUgcmVzZXJ2YXRpb24gb2JqZWN0IG1pZ2h0
IGJlIGxvY2tlZCBhZ2FpbiBieSBldmljdC9zd2FwIGFmdGVyDQo+IGluZGl2aWR1YWxpemVkLiBU
aGUgcmFjZSBpcyBsaWtlIGJlbG93Lg0KPiBjcHUgMCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNwdSAxDQo+IEJPIHJlbGVhc2UgICAgICAgICAgICAgICAgICAgICAgICAgICAgQk8g
ZXZpY3Qgb3Igc3dhcA0KPiB0dG1fYm9faW5kaXZpZHVhbGl6ZV9yZXN2IHtyZXN2ID0gJl9yZXN2
fQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHR0bV9ib19ldmljdF9z
d2Fwb3V0X2FsbG93YWJsZQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZG1hX3Jlc3ZfdHJ5bG9jayhyZXN2KQ0KPiAtPnJlbGVhc2Vfbm90aWZ5KCkge0JV
R19PTighdHJ5bG9jayhyZXN2KSl9DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKCF0dG1fYm9fZ2V0X3VubGVzc196ZXJvKSkNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRtYV9yZXN2X3VubG9jayhyZXN2KQ0KPiBBY3R1
YWxseSB0aGlzIGlzIG5vdCBhIGJ1ZyBpZiB0cnlsb2NrIGZhaWxzLiBTbyB1c2UgZG1hX3Jlc3Zf
bG9jaw0KPiBpbnN0ZWFkLg0KDQpQbGVhc2UgdGVzdCB0aGlzIHdpdGggTE9DS0RFUCBlbmFibGVk
LiBJIGJlbGlldmUgdGhlIHRyeWxvY2sgaGVyZSB3YXMNCm5lZWRlZCB0byBhdm9pZCBwb3RlbnRp
YWwgZGVhZGxvY2tzLiBNYXliZSBDaHJpc3RpYW4gY2FuIGZpbGwgaW4gbW9yZQ0KZGV0YWlscy4N
Cg0KUmVnYXJkcywNCiAgRmVsaXgNCg0KDQo+DQo+IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4g
PHhpbmh1aS5wYW5AYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiBpbmRleCA5MjhlOGQ1N2NkMDguLmJlYWNi
NDYyNjVmOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2FtZGtmZF9ncHV2bS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYw0KPiBAQCAtMzE4LDcgKzMxOCw3IEBAIGludCBhbWRncHVfYW1ka2Zk
X3JlbW92ZV9mZW5jZV9vbl9wdF9wZF9ib3Moc3RydWN0IGFtZGdwdV9ibyAqYm8pDQo+ICAgICAg
IGVmID0gY29udGFpbmVyX29mKGRtYV9mZW5jZV9nZXQoJmluZm8tPmV2aWN0aW9uX2ZlbmNlLT5i
YXNlKSwNCj4gICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfYW1ka2ZkX2ZlbmNl
LCBiYXNlKTsNCj4NCj4gLSAgICAgQlVHX09OKCFkbWFfcmVzdl90cnlsb2NrKGJvLT50Ym8uYmFz
ZS5yZXN2KSk7DQo+ICsgICAgIGRtYV9yZXN2X2xvY2soYm8tPnRiby5iYXNlLnJlc3YsIE5VTEwp
Ow0KPiAgICAgICByZXQgPSBhbWRncHVfYW1ka2ZkX3JlbW92ZV9ldmljdGlvbl9mZW5jZShibywg
ZWYpOw0KPiAgICAgICBkbWFfcmVzdl91bmxvY2soYm8tPnRiby5iYXNlLnJlc3YpOw0KPg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
