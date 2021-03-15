Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A10C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 20:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 762F164F0F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 20:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762F164F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F27496E193;
	Mon, 15 Mar 2021 20:56:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD536E193
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 20:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCKGEar6iYD70XUOpjGHYdqJXmgIMp8TtuJRBY5tbxlXliH+F4AwBPbMr7jMHf5Eku9jn4SJgyyP3LutyDYe73tNeR2sW8gPMAdAbUBkAqwMVMNL6nQbluS6Bn0u5377fP/sr5meFQryu0TdbhvapD9k5FdMYU71nsvDELn63FNxcbcdM5otJSziwy+RCL1Vmt7NqR9fkBBZBGGupnMIv2DUHdC2k4t4O5mm1ZZQqk3g8FfLQbzv/8DO6RxjHBqlKws4q/86PsnuDt1gj4vwgp1O61rNgoWBdvyj7ZiVMi7OYCiamCLjNHhUi0E9Bh/3fD5BpJIRuG/Zc+f4XV4IZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OT7UtAlBKUlT/hLjxXj+ED3G7lwfhoAZbrUbN7iRX5o=;
 b=hMws/jGzqPx9wuDACGLh42Pz6QfihAVurP7ZoBPKidj2J6AmuWh9Vzip+eut2FhP2j46DuEAlXp1bhupMwC+t6gyraM1CvCSFQIKzmSs6NaQAbTzTo/Vzjb8+BDA3Kgf7rRotz3dGL3Lh6juSqxWsIGIHTPbKgX/OYHJI7xzHz3SkYop+e1kxfzRIyJSks4ch5/whWaE6iV/bBxoOFckV41cDqLHt5zVhZe2JI4pqAUaWjOxpcTyLpHSN+rlQ6yuq6fM6i51+T1cZriP3P0C/rjUFr6yM0NIhydYjFZOzdaJGM3yxj66ulx6lpQxSNNKG+CBnpgUDR/EddOtmEF5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OT7UtAlBKUlT/hLjxXj+ED3G7lwfhoAZbrUbN7iRX5o=;
 b=cpwWF5/GFxw0SD1r4rLCIQKcH0nRGrgaCZ+rxw96WaQNUjCHftthG+PSR1uPZThhdZ2RX4NpoLRO2iZyWeIV59eRaLlOwQs+wa7Df3JBKLwCvVJPjNaKXzfH/0LyVp3O8eFT01zha4f0x+UdNh/2kkeEGWLCDv5UaGara9tyMck=
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM5PR12MB1596.namprd12.prod.outlook.com (2603:10b6:4:d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 20:56:26 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 20:56:26 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/ttm: fix ifdefs for non-x86
Thread-Topic: [PATCH] drm/amdgpu/ttm: fix ifdefs for non-x86
Thread-Index: AQHXGdLbf1OwS22Yz0quJ8PO9fMsQ6qFRJ6A
Date: Mon, 15 Mar 2021 20:56:25 +0000
Message-ID: <15E7AE9E-C79A-4B42-8ED1-5D1C09DC2740@amd.com>
References: <20210315193841.1539753-1-alexander.deucher@amd.com>
In-Reply-To: <20210315193841.1539753-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7eb1fad2-bcf0-4d16-8bd2-91b00706ad95;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-15T20:56:07Z; 
user-agent: Microsoft-MacOutlook/16.46.21021202
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40991127-f526-471a-e342-08d8e7f4cc65
x-ms-traffictypediagnostic: DM5PR12MB1596:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1596B34D26DF15706A3E4460806C9@DM5PR12MB1596.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b0ORSXONhVA4gU5aGyDg2501Ckb3gYYtaYfnGS+CwemhN434++W9jJmgARr6ycbsxgUdDqJCBCc4BsXVHZMQf/+QMheoohHwr0PGY0I7j1G3glguruWW3hGhiTJgjoQqvo2JHznDJel0H76WCHbvw/Vfm3pNQuyroQryK53KluIZYlFIOTJrJZazHsPjVk3O6kz4VTUHAsJyJf6tMG8qtHJfXd7L99h+QG5ou6CKzhsRocPpBVvX+MFCVt8WY5WE/lZI/U6SHCEwHR4NuEWzfuSJ35VMshCxz39lhpeKEokt8qj5oO7oKoYmxbCn6QQE6RVfINa9oTMwfeT+YvVZ5G4wda2cXfwUSCz0pCnBXQhYxnE0ba3eFZW8McGxXmTb4BtqAqqfODaKpAISyLbg4UXbeqWQsJqdnNDC1mvXlC3YGQpszEKFSfxAiqH7hg2BAerCl/bd5AKdCtJGaPUowjJkiwiTjQXlh0VPB4m8sXlmExIgjRNWo5ZQpRHcAsH3soeVWtxc+QNNHND6XgoM7Njafnbci3HT1iQXtybG17yxMUd7NC1cHPmggaRcobu4BNeLFWaUibXNjoQuRGedkhrsCL3Kj+JCizcwGVrM7pJjoDbaqKOwrV18BT5YchHKaB8tD2v2Bsff0mBiZimIvh6zBj8q/vuP9CfzvxoHavY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(2906002)(966005)(2616005)(33656002)(66446008)(45080400002)(64756008)(36756003)(110136005)(6512007)(8676002)(71200400001)(6506007)(5660300002)(86362001)(66476007)(8936002)(316002)(26005)(6486002)(186003)(91956017)(66556008)(76116006)(66946007)(478600001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?WWs3dW1QMklBNm8zUHpPcUx5M3dZY0JKM3dBOW96eDQvNXRMYUZiZWFJbHhl?=
 =?utf-8?B?VFFFdnpqRUxxRFZiTjVZK3BvZFU5WVI3enY0bG5PK1FzRmp4UFlDc0VZMDNU?=
 =?utf-8?B?eG5XWmE1MXNuUXdFR0k3UjBneGJQZFlRRGg3Z3djaklDVGZXMGxIYVY5dWN3?=
 =?utf-8?B?cUVuTUNzQk5PZWxPYnpubEhjblRwYTdlUmJkNkNFOVVyN2JpU2p5VG5xamE3?=
 =?utf-8?B?eng1bWFGTmlKRWErUEs1emFoTjE1cE9uamJrdXdyaktmVUh3Q1NHTS9Cd25T?=
 =?utf-8?B?UXVQa2cvSU94eWI4QWt0V0IyYS9GaHlRUkpyQWpsYVdDMW9jYWFrcXZLNDFV?=
 =?utf-8?B?cTBDNkJvdDNqU3lxTldheElxSGlkK3MrQkNUL2pVOHo4a3RTM1VkajNISWJ2?=
 =?utf-8?B?WElzTnpGTy9OQm9NSGluaXRQejV4NVJJZmZYZTl6eXQrREZudjdoOUlRb1Rp?=
 =?utf-8?B?VjJtY3ZQL1JWbzJaRnNuRXdiNHhMaHlDR08yMnBDcDRtNHlRRE85eTVMSUx2?=
 =?utf-8?B?TkJWYmNFV2JFelM2S3kzTzJ2RnpadVdTVzRtMVlQdmhjbEg0QlhvUldOVUwz?=
 =?utf-8?B?TDd3aWVNMDdDUEZIUVJRQ2VKU2NZK3h4R2QrR2M0d1FJUXdHTjBUWUxaRmp0?=
 =?utf-8?B?N3NGSWxvNEE3TytTdXZxVHB3dEhMMVRnZ1dtanJYVHdKNjZmME9JYVpPWWdX?=
 =?utf-8?B?VVBPbFZQWlhyL0ptUThjNGsyQXdxT3NuQlhyVC9mVXE2QVI1elJBMDNOZk9J?=
 =?utf-8?B?L2t2bXBtSFp1NUhQalJYTTdqSTlENEZPYVh1eVdlRTVoMUcwcjhuVmFmRFFQ?=
 =?utf-8?B?RDJFK29zWXhrbEZWdE1qRWhYMXJyTzh6blZKVEg3Vm9BLzQ2N2hWNlgvMlNV?=
 =?utf-8?B?UnpmU1RwNGljbFdGRUZTNldxZDlZTVh3UGE2OVEvOVFBdnQ1WHViYlJYM2hI?=
 =?utf-8?B?WHJBVi9NeVduM3lQVFpMU1NaK1ZyMDVJM0JRd1Q2TVlnZzJSVnZMZXkrdmVP?=
 =?utf-8?B?Ui9NMGtJYURDYnAxTzZBMk1LbElzS0EwMTBTeVVKbEliK2VpY0NlaCs3RzRM?=
 =?utf-8?B?TmJVNVdFTDk4V2FXWlA3TlRwRmpvL0tKWm9VMzN3cVZOZ2NSYWtNZjgzT0pC?=
 =?utf-8?B?VUk3K3p0cFpJL0EyNzIwQlJYRHpDZDRINGRzQkFkSzBJTVdpUUppM1NkRzJU?=
 =?utf-8?B?Mlh5ODArSzFLOVZRWkd4bERKT1hmeWg3Q01tZlpBNkprSzRmcGhuek5NZTJU?=
 =?utf-8?B?WDJVdW9ZS1VubjRUK0VzWGNiMC81RThJS1VueFlISmxpbUpzUEJ5VkpsMjls?=
 =?utf-8?B?Ny9KT2x4TDJUNHEzNTg3RkpxSUNlWExLdHdlYmRnVlpuTUxwelIvZ0tiL3Rt?=
 =?utf-8?B?Qys3akRIOGhxbTJYcSs4VlNCQ3U5UnJ1eDI4c2RRbW1lWDJVMmlwcldhSGwv?=
 =?utf-8?B?S3N0MGd2TW5IYVFQOUZFZ3B6b1p3OW1pK2NKS05Bd2d3aHk3MzJoL3JWUDg2?=
 =?utf-8?B?NWh0VlZlaitwYXNGcEdZU2VIS1hNMWQ3aGVKV1kzRC81Q1ZTRjBVcTB5eXZq?=
 =?utf-8?B?K0hBaDJNMmpFaFJzMzVCdXAzc283b2ZQUmdzMFJGWVJ5SCtGY2dDUVFFeGNG?=
 =?utf-8?B?OE1mZmN3Rm5pWkJrMVpNQTkzZ2hlTXduUlBEZSsxYnNQekhiVDZMMi8xTEtZ?=
 =?utf-8?B?Q2w1NVROcG4vUW90Q2RlNHljcjdwWkRSUUpkajdSL3YxUkZIdjE2SFdYZWFx?=
 =?utf-8?B?bklSRW0xTzRKZlJCWXlrVFdacUNmeHpPSmZvZFRiYjdPa01HQVY1OWc5OHcw?=
 =?utf-8?B?Q0kxWklpNm9FaDFFNXdHUT09?=
Content-ID: <C96C7F85608F0140BBAA7B1AE199B9E1@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40991127-f526-471a-e342-08d8e7f4cc65
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 20:56:25.9101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jaPWx+2s3taBHTcSbhAN8G6uuhPhs66b15xKSdiB35k1jtttDdfNyvCXX0qOCL7u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1596
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpS
ZXZpZXdlZC1ieTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+DQoNClJlZ2FyZHMsDQpPYWsN
Cg0KDQoNCu+7v09uIDIwMjEtMDMtMTUsIDM6MzkgUE0sICJhbWQtZ2Z4IG9uIGJlaGFsZiBvZiBB
bGV4IERldWNoZXIiIDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIG9uIGJl
aGFsZiBvZiBBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPiB3cm90ZToNCg0KICAgIFRoZSBlbHNl
IGNsYXVzZSBuZWVkcyB0byBiZSBDT05GSUdfNjRCSVQgbm90IENPTkZJR19YODYuDQoNCiAgICBG
aXhlczogZTk4ZjI1MGJkZGI1ICgiZHJtL2FtZGdwdTogZml4IGNvbXBpbGUgZXJyb3Igb24gYXJj
aGl0ZWN0dXJlIHMzOTAiKQ0KICAgIFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4NCiAgICAtLS0NCiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3R0bS5jIHwgMiArKw0KICAgICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspDQoNCiAgICBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jDQogICAg
aW5kZXggMTU4Yzk4NzY5NmZmLi42ZDVjZjA1MjUzMjUgMTAwNjQ0DQogICAgLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jDQogICAgKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jDQogICAgQEAgLTE3MzEsMTIgKzE3MzEsMTQgQEAg
aW50IGFtZGdwdV90dG1faW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCg0KICAgICAv
KiBDaGFuZ2UgdGhlIHNpemUgaGVyZSBpbnN0ZWFkIG9mIHRoZSBpbml0IGFib3ZlIHNvIG9ubHkg
bHBmbiBpcyBhZmZlY3RlZCAqLw0KICAgICBhbWRncHVfdHRtX3NldF9idWZmZXJfZnVuY3Nfc3Rh
dHVzKGFkZXYsIGZhbHNlKTsNCiAgICArI2lmZGVmIENPTkZJR182NEJJVA0KICAgICAjaWZkZWYg
Q09ORklHX1g4Ng0KICAgICBpZiAoYWRldi0+Z21jLnhnbWkuY29ubmVjdGVkX3RvX2NwdSkNCiAg
ICAgYWRldi0+bW1hbi5hcGVyX2Jhc2Vfa2FkZHIgPSBpb3JlbWFwX2NhY2hlKGFkZXYtPmdtYy5h
cGVyX2Jhc2UsDQogICAgIGFkZXYtPmdtYy52aXNpYmxlX3ZyYW1fc2l6ZSk7DQoNCiAgICAgZWxz
ZQ0KICAgICsjZW5kaWYNCiAgICAgYWRldi0+bW1hbi5hcGVyX2Jhc2Vfa2FkZHIgPSBpb3JlbWFw
X3djKGFkZXYtPmdtYy5hcGVyX2Jhc2UsDQogICAgIGFkZXYtPmdtYy52aXNpYmxlX3ZyYW1fc2l6
ZSk7DQogICAgICNlbmRpZg0KICAgIC0tDQogICAgMi4zMC4yDQoNCiAgICBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KICAgIGFtZC1nZnggbWFpbGluZyBs
aXN0DQogICAgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCiAgICBodHRwczovL25hbTEx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0
cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRh
PTA0JTdDMDElN0NvYWsuemVuZyU0MGFtZC5jb20lN0NjZWVhOGJjNjI1NmY0OTVjZGRhZDA4ZDhl
N2U5ZmNkZSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc1
MTQzMzk0NDQzNjA4MDglN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01E
QWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZh
bXA7c2RhdGE9SGo2M2NMWk4zYkdLdm5HRFJlSEttanBzTEpBcEJFOCUyQnlPNmxLVHp0a3BZJTNE
JmFtcDtyZXNlcnZlZD0wDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
