Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8640CC43460
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 12:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBAF60FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 12:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBAF60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C78BC89D86;
	Mon, 10 May 2021 12:43:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F6B89D86
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 12:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BC5sF5h9veVJt4kQQcfny1+2HR39jVdIT/G6H58fWPDH1X8FRa4N8oQbss4HbcR94DMg/M/hoW4wJgttAHvXJUbeskLp/wSCAfCSgcJQd+ssDrPvTeisvslCTzefZZ3FffgwWUS3EgUPzXNqkf2LPqw5l46c3Qow8A+8Ni4UuJOS26ULT2YJYo4fS2DtmitX21QwYlkQWRQ3a02ohv3hAKgWl3V/uB9K4Sb+y7ZsT13SfvSUIrKOQagtVT6EaDdyWICih5toyEud/owj7CgN0yw81y3aW9JkJvVy709AY0MXtwwWeNpNr3cmxsF1cEY+1M/wMveRNJSQ9SX3H78Z9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA22KReIoo4Tut8mW5m+G3sTpCu/9KaLCQW20HlNQk4=;
 b=iZ6Mmo4VPS8ahLQubpIluT7h651v5f/GqOIE+WvZvOpUoEU6XbnaM0VfUQ1VsiZEHBJRlsb1SJQQ/IRrUxuS182WtDq5cLm90lEX2iplbE/9BOiViqt0OME3ijNVoccTAMYx4AyAH9Yb+kzeE0BISqPRBAfJsJIK++8mGx/SvdNscXrLGObXmZQ94XDlbPdtqsjmYooLekOGZQnuM53l2/HiOCQMOZUDtOju7bsTOIv5l9Pja4goxP/sB/9AUZLkNpzB6jg1+JBIfRJ3ATl4rXgXJr0o+YBVTYgeFFPzUlzgTLVbMR+xSxWnADWYLt9DSSw60v8/3JZtfpgZ8piIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA22KReIoo4Tut8mW5m+G3sTpCu/9KaLCQW20HlNQk4=;
 b=hHzq2ce9XVrhXPVLheCGhqrF8Hy/e4izrsEBGBANimw2OwuOAhK8Xu9dm+vgHsaB9qpFRjjif9wg8MhKYqgVBEN3Ql8LTj2oN2xK0IH8VV6Rd0qLIvAPSFW+haZS2nTJzWzteMwCNtkK7wUrrkvka9DSNK781rSpPUSpJVMopsA=
Received: from DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) by
 DM6PR12MB5551.namprd12.prod.outlook.com (2603:10b6:5:1bc::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31; Mon, 10 May 2021 12:43:18 +0000
Received: from DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::cdbd:bd79:d9b2:ed90]) by DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::cdbd:bd79:d9b2:ed90%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 12:43:18 +0000
From: "Shih, Jude" <Jude.Shih@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu/display: fix warning when
 CONFIG_DRM_AMD_DC_DCN is not defined
Thread-Topic: [PATCH 2/3] drm/amdgpu/display: fix warning when
 CONFIG_DRM_AMD_DC_DCN is not defined
Thread-Index: AQHXQ4C6Cs2taQ1TxkmpvuIXSxosZarcrQ0w
Date: Mon, 10 May 2021 12:43:18 +0000
Message-ID: <DM4PR12MB51337ED2A3FD4D7D9547D1B9F7549@DM4PR12MB5133.namprd12.prod.outlook.com>
References: <20210507203642.552770-1-alexander.deucher@amd.com>
 <20210507203642.552770-2-alexander.deucher@amd.com>
In-Reply-To: <20210507203642.552770-2-alexander.deucher@amd.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-10T12:43:13Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1f97cd37-95ee-4d77-86a1-75b1a998680a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [219.85.181.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1427d775-7e84-4b5e-45b3-08d913b12fde
x-ms-traffictypediagnostic: DM6PR12MB5551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB5551D1490EE9C21C08437CB3F7549@DM6PR12MB5551.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HB+myCs3YH0nwlTw5jcxWwfeUdpgHdYzd1Nr/6kSMCp+YtvOGiMGT8et/h9p9uJBm6/SqwA3ABpPAkYVy7/LYuUwsy3klOXkjlkg1KIQBhxhw4fconwVE7xjBVpKfAAUzW58FLZTQdLwf7ffl7c6HZjV3URC8/CKWPh93fEr0c01KZzetjB8f3jm/rtS8LxpzOXhCiDfgE0CkjqDk+FUA3U8NnKIYucuhxxsxNssczhwNKCXwJSyRLJ55Pe7pKxT4H0CfjmEfozjzOKoUIyBvT2YvV54wnOL8Qg5iXoQKmgNXcLxhSY8AYVJK9QiPJRMwSHGllQkmKJBorbjuvQpY587loMXGwqUDGPsmCIh/FWNt/H6a58v0EYP/akT+v1gQKdr34gVdzW+UhJNq8kOwxtB6tLwRboQg+q+wQet3ua3ANpNF8r8HrnDemxekHj8FAk/TkmEjvY8ljCYVERE7q4PHixf+FfNSWpkIubTfdhbqY8q+Rda3Tz9EeZDjZ1Illssx/UiAbI7tlJbqH73xg+uN7SH9gPxE4Y8CmyGqNW0U8CGHrRti+qsFWOGYAf7tv1/EvRCCHWXIhU7r/UPkKP4CdgHHvTVIRkg8nVWfTM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39850400004)(396003)(366004)(376002)(52536014)(316002)(5660300002)(2906002)(110136005)(33656002)(122000001)(38100700002)(55016002)(83380400001)(478600001)(8936002)(8676002)(66946007)(64756008)(66556008)(66476007)(66446008)(76116006)(186003)(26005)(53546011)(9686003)(7696005)(86362001)(6506007)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?Qk1VTzROVmpkUUQrWXJFOC9EZm9GZFI1NkVkL1MwdWgxT0Z2bTdDeWdEN3V6?=
 =?utf-8?B?S3JNSDY2NW1vMFN4VDUwQlZmMUpuWWpiczRzVUZuSmZ1QmhoNWwvNnhOSW1a?=
 =?utf-8?B?QXR6QmRsMlFPMjc2YzZVYnpndmxMUmpHS3pZV3FsN0taWDQ1SmNCZTVnaEl2?=
 =?utf-8?B?QmtlTFJhdzh3aExteHB3K2M3RFNWTzY1b1VDZ2JXNUw2VnRsRitvak5jbm9u?=
 =?utf-8?B?d2tUeVRIN2d1ZkZVQkw1Z21QK29lditubkRraFVMZU43UXFWTURJaytnWHZy?=
 =?utf-8?B?c1Y4SkhaWklPK1lJSHhkS1N6Z0dyLzI4c25SRFZUaDdqZGJoMGJCWStZRElh?=
 =?utf-8?B?VWREdXh6MjExZVFoUzBqQzhKclhlcCtmRXlmUTNQMTZlelJyR1FjMzJFZGNC?=
 =?utf-8?B?b2s3b1lwQ2ZxcGhqQkx3NjRJVHJkNmM5TVh5SS9PWGRaUEF3NDI3NmN1ZnlE?=
 =?utf-8?B?dndWeW01ZHlyM3dmbnFueVVGeU1Pc25xbmxNMytzVmpUVXRVbTVXN2t5eWhI?=
 =?utf-8?B?dGhBNFEwOU1QOHd2U0tqcjlVM2VvUkhNYjY1Z013aUprZEJ1UW5LRmEwd0oz?=
 =?utf-8?B?MTdKZ2EyTElpZCtaVWhYc3luaDRRVSsxT01aNmQ1Mmk2U1Noc2IzbjFkV3RU?=
 =?utf-8?B?T3N1K0ltNzhEK09wN2JGNmdwbWtKN25UWDIrdDQ4OUQvbElMUmpKUnNPclpF?=
 =?utf-8?B?MHExMEl2YTZNYXI2RUdLOTlWT1dQcEUvQ3dscS8wNzRKSFRvVFEyOENLWFV3?=
 =?utf-8?B?MGxoZ2tIVVVXK3djRHdZeXdMMTVkcEVSQ0RJSEx5RHB3eUdHdXl4WGlYOHNU?=
 =?utf-8?B?Y0ZmcHVMbS9xbU9hOWtBN29kU1ZUVDNreVc2OUEyYmFVTGcvMzcwOThhcnpu?=
 =?utf-8?B?WEtWcjRkUFV2SnBiZWp0dCtEU29uUzFDRlRaQlN1Vm50TWZWZ2w3aU0rUkI0?=
 =?utf-8?B?MFNoV2pKeTRzN2FkR1hwS0lIcUQ5NmpyMm9weFdGY01vLzdYRkVTV3BZWmpB?=
 =?utf-8?B?aHFGa052dWs2RFF5MkUyYnhGd3VqRWFwaFE4YXM3ZnBzR1d0MDVMZVJDVlVU?=
 =?utf-8?B?dk56U3N5V3ljL3hoSkRUZ2wxcytvZ1pQWjlHU3RpN2RUUUJEN0FGMm1MYTZw?=
 =?utf-8?B?NDE0QU5HcjRubUttNUtYZ0EvdFBJZi9uRWNoNWh4Mkd2S3VnaGNFOE9uTytY?=
 =?utf-8?B?S1hFdVFuQ1J4SkYwUlBzSklsQ2Q4YmNsV2JkZjhXU0ZLSDNwUEI4SHhxbzZU?=
 =?utf-8?B?Mm5PcGh6RVB3QkxMOTZ3YWxFYjdoMlZVOHBvQXM0NTNHWjUyZ2VsTWd3Vmhl?=
 =?utf-8?B?NWkzSURrcUNhYkJCRmpjNy9rc3RDWHc4eVdFRXU5djllK1BNWGltdFpRMm83?=
 =?utf-8?B?Zm9UQ0dmWVordTdIYk5DbjlFcVpzU244SmFoemFmcmxrMlpJL3BSb1lMUUNk?=
 =?utf-8?B?c0Fkb3lzTkFkK0FPWHBlNjVkSEcreTFSSXorRkpKeDB1S0xVZEFWTVoxODFn?=
 =?utf-8?B?emJ4dXhuc0FHV2dxa1p6VVl1aTdnNXZFMlloNDJFOUxFQ0hjSEpiSDJta0Zz?=
 =?utf-8?B?MHh1a2dydldxMDdFTFRCa3V2R3MzUGJRUnYxWllmclpZRVBRdGFXd0o3a0ll?=
 =?utf-8?B?QW5wVHpINE5MN2g0MVVPdHNKcTVaRDZwTThqMnZKdFI3UmR5dWpsazB4QUNS?=
 =?utf-8?B?K3psVFhyTk1ZT00vWFJCTFhQUW53ZTg3TWZuOWJVMTBVK291OXlmdFVxaE15?=
 =?utf-8?Q?9aNRnFJQvzjW77n/j+7qUIp2Gu6VkjTQmsmiA/I?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1427d775-7e84-4b5e-45b3-08d913b12fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 12:43:18.2502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+akHzUuw3Amv6G9ja9C1+XVSlhZrIt7jfaMmP4X5AxfwOOF8JjGRFkozP4Nq+ntU8Tahlk6bkHcP22SGhre0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5551
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
ZXZpZXdlZC1ieTogSnVkZSBTaGloIDxzaGVuc2hpaEBhbWQuY29tPg0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPiANClNlbnQ6IFNhdHVyZGF5LCBNYXkgOCwgMjAyMSA0OjM3IEFNDQpUbzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBTaGloLCBKdWRlIDxKdWRlLlNoaWhAYW1kLmNvbT4NClN1
YmplY3Q6IFtQQVRDSCAyLzNdIGRybS9hbWRncHUvZGlzcGxheTogZml4IHdhcm5pbmcgd2hlbiBD
T05GSUdfRFJNX0FNRF9EQ19EQ04gaXMgbm90IGRlZmluZWQNCg0KRml4ZXM6DQpBdCB0b3AgbGV2
ZWw6DQpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2FtZGdwdV9kbS9hbWRn
cHVfZG0uYzo2MzM6MTM6IHdhcm5pbmc6IOKAmGRtX2RtdWJfb3V0Ym94MV9sb3dfaXJx4oCZIGRl
ZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1mdW5jdGlvbl0NCiAgNjMzIHwgc3RhdGljIHZv
aWQgZG1fZG11Yl9vdXRib3gxX2xvd19pcnEodm9pZCAqaW50ZXJydXB0X3BhcmFtcykNCiAgICAg
IHwgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCg0KRml4ZXM6IDc3YTQ5YzQ1
ODkzMSAoImRybS9hbWQvZGlzcGxheTogU3VwcG9ydCBmb3IgRE1VQiBBVVgiKQ0KU2lnbmVkLW9m
Zi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KQ2M6IEp1ZGUg
U2hpaCA8SnVkZS5TaGloQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCmluZGV4IDczZDQxY2RkOThiYS4uNzdiZGU1NGM5
NTE1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG0uYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG0uYw0KQEAgLTYyMCw3ICs2MjAsNiBAQCBzdGF0aWMgdm9pZCBkbV9kY25fdmVydGlj
YWxfaW50ZXJydXB0MF9oaWdoX2lycSh2b2lkICppbnRlcnJ1cHRfcGFyYW1zKQ0KIAlhbWRncHVf
ZG1fY3J0Y19oYW5kbGVfY3JjX3dpbmRvd19pcnEoJmFjcnRjLT5iYXNlKTsNCiB9DQogI2VuZGlm
DQotI2VuZGlmDQogDQogLyoqDQogICogZG1fZG11Yl9vdXRib3gxX2xvd19pcnEoKSAtIEhhbmRs
ZXMgT3V0Ym94IGludGVycnVwdCBAQCAtNjczLDYgKzY3Miw3IEBAIHN0YXRpYyB2b2lkIGRtX2Rt
dWJfb3V0Ym94MV9sb3dfaXJxKHZvaWQgKmludGVycnVwdF9wYXJhbXMpDQogDQogCUFTU0VSVChj
b3VudCA8PSBETVVCX1RSQUNFX01BWF9SRUFEKTsNCiB9DQorI2VuZGlmDQogDQogc3RhdGljIGlu
dCBkbV9zZXRfY2xvY2tnYXRpbmdfc3RhdGUodm9pZCAqaGFuZGxlLA0KIAkJICBlbnVtIGFtZF9j
bG9ja2dhdGluZ19zdGF0ZSBzdGF0ZSkNCi0tDQoyLjMwLjINCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
