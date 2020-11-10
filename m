Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86C8C388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 09:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF8F20781
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 09:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aXgi+ODf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF8F20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D40F2898AA;
	Tue, 10 Nov 2020 09:23:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8393898AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 09:23:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwjt0HyFXyc9VlOEPKQ0IV0+hSWck8ZbGjc7JOLHzPRmGnd+FlMkx5c+QdYwvQDyBzrjLiEZ0jk64TP/NVhkerBkd1pVvq7r3TKfzEetsM8kzoDsWb74Cq+Ey1GsrGI5+MU0Qcg2Qzw2ug7sbQmBL7IKWMjZ4VS/Y+0ux/Qw6xO2nEZzOkA1XoD34tqYCa32Jki5tsHRDZTxWDh4puMG6Q6oIUM+p78COFl4ZaDhir1eSK5uYfT0RoP7Rjgjh3izszBf7fzMPPVhtQOLwldjv2Uqh0jK0zxS2yg0WpDkHxHenTg5ayameRShY0N1F5ZXjgNod+uLSsttQTgE2lYT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cnb++hfW0nbIdz0CjiQu+fwFnMOnMUq4u42ff3a2qIk=;
 b=CToKYednez28l4okt3y2RGmL12nVtdYlz+TLL6qOn5+GB91W7Os29Tf/Xm1VhBD7fhjRcTNrK3lz55qmVfYelmMv1e7aAdPJNkbYUBlMltDhNAWBCaXhUnvztXyMBxNwft4VTAWkCfef3RGsvYTBChoNFUeH/EvNsRIU9FJUDXZk6dV8ZsM65r2eAUoraU3kmGCTrhC1NTTsE+viBjZtpqmZW0HaJMRX/VhBpZpRDA+djoxbuOdKjUS4FmKbfpvMUvAkbRekxZ1KtWl2yK2Bwevdh9OP0AvkKJ9rQW1+xtUAakXKKeYdHQdl8aTIBOQzsshf5oHTiJ0VMg0iFmoDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cnb++hfW0nbIdz0CjiQu+fwFnMOnMUq4u42ff3a2qIk=;
 b=aXgi+ODfR9qGaf0gCN9t+6UanYPnZXyLbcLTzc48GsbqER5/3YMs8FuWbZzDfF37mUZzcf6Q4L2MYpM/UHLbk5JdxDcOH2dafoTb4eAij9qeEYRoAjKERu3tw9b1gmHpxh5OdzF+ZQTY4WQsPnvmZvmwXqZYapObv+SAyZ32KIg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0025.namprd12.prod.outlook.com (2603:10b6:4:53::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Tue, 10 Nov 2020 09:23:05 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3541.022; Tue, 10 Nov 2020
 09:23:05 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Wang, Mengbing (Martin)" <Mengbing.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: correct table_clk_vlt memory size due to
 replacing one-element array with flexible-array in struct
 phm_clock_voltage_dependency_table
Thread-Topic: [PATCH] drm/amd/pm: correct table_clk_vlt memory size due to
 replacing one-element array with flexible-array in struct
 phm_clock_voltage_dependency_table
Thread-Index: AQHWtzMHL/uPUsoizUe9AtegJWv4oKnBF6Vg
Date: Tue, 10 Nov 2020 09:23:05 +0000
Message-ID: <DM6PR12MB2619296F382E35A8884B9A49E4E90@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201110072644.4993-1-mengbing.wang@amd.com>
In-Reply-To: <20201110072644.4993-1-mengbing.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5ea05c5d-400f-466d-8c12-84b2ab6093b9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-10T09:22:36Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 497ec4a4-1a9b-4a05-7282-08d8855a3ae1
x-ms-traffictypediagnostic: DM5PR1201MB0025:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0025F9E29C6ADD2BD1137DE5E4E90@DM5PR1201MB0025.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xM1+YGSr81FE7b804a1b8IkaCysrAn2MdAL3Udn93mtWWuEzttvtX56JCjUc6St4OS5BcLaCh9KDlBfZ02+zzfJrALqYSpdrbxYJ/KaBZFTOCzEmbIlQB9xBohVkK5jYu82mk4vM5JVL5kxHfdeWvAvUOnnCYcoaEQMdcvOZXZq0W/bLlIDCcFlznmjEvesZvUaNcV8qnYyZDOWGNqEVRFsVRC7zZ2burlMcZiqcZ69xralbLViQ7gM9qL16iUrjRYvDx6LMcVfytd2KImfNnrJwkm3hUWyO1wWxejR5LMdNn6ghHBcR4bx+z8WjJ+UePtLzWEKWgkJ+dUrmbmZg1da2/+kszS/1H64fhlD3NdpYuEerd/oZOh0UrrZt1Ml12n37ZhdkwNbZ8o8x6yXoGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(8936002)(83380400001)(86362001)(8676002)(110136005)(2906002)(55016002)(26005)(316002)(186003)(7696005)(966005)(45080400002)(5660300002)(66946007)(66556008)(53546011)(478600001)(64756008)(66476007)(76116006)(66446008)(33656002)(6506007)(9686003)(71200400001)(52536014)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: px9O1l3NZWPk93TS5d2dqvDPdJr7JR+Sbn9FO7eCnNUVyc+wo9jJsw8sikshtIw/fGw/JkjTJO38bnw62oOqZpSDH7rX7LbJxHbpYLY3ZwZ+nAUb9fBbIoMIa6rX5bM7lXCjNnSkpMjLL0jqstCe/0ql1fa2Z1qAXVX6eFy7XPSsjO26b8QIKCXQsNRIM4jK+SYhyW796OHUZg/esj6n8Ivmkv0cIhGGk/JktdEtC0mDSw5zM2XJbt3GsPSteXVEXV6eZU9rulA6armwZSmV5a9VXV0bIsyHJMeA7oEyxeIFNa7KD0uQCOVUpgO/D0Tf8fITnA3uy52PztSlO1UusCnU+Xd6dpODz0Q/6Jrddvu43UqwinOYUSAle5GC9l+kk+5OBpGpMhwoITmX82xN8aMCgIPDQ88u3Eb2ArbWD7KTcJ+IuSZtJnIMWHFAPL/WLda4fGHzASj0GxqmGwYWZtCWZ4G5cW8/tFuAYfMbpZmqdOyh0NRB1SXcAV8sKs6pFGYoSHZ5IxyhF4ogqGqmqgLxP6djquyy9j93Ex2OyfpLrAdWIeR+kOrZp613KXprRK+yZ5js6jQu5e3R1q8G39KWlxircQhTbBm7xDoZ/UuytagwdGsm0jlhiUdD2c8dUwBWcj8tdX3nqaw453vjew==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497ec4a4-1a9b-4a05-7282-08d8855a3ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 09:23:05.3300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEBNVehM9AHx7pqRobd+bCtXLkhWIWtfCXrmgBj4PiSOGFVRX3d6vIqpCe0neJsu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0025
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
Cc: "Wang, Mengbing \(Martin\)" <Mengbing.Wang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpS
ZXZpZXdlZC1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4NCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVl
ZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBNZW5nYmluZyBXYW5nDQpTZW50OiBUdWVzZGF5LCBO
b3ZlbWJlciAxMCwgMjAyMCAzOjI3IFBNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCkNjOiBXYW5nLCBNZW5nYmluZyAoTWFydGluKSA8TWVuZ2JpbmcuV2FuZ0BhbWQuY29tPg0K
U3ViamVjdDogW1BBVENIXSBkcm0vYW1kL3BtOiBjb3JyZWN0IHRhYmxlX2Nsa192bHQgbWVtb3J5
IHNpemUgZHVlIHRvIHJlcGxhY2luZyBvbmUtZWxlbWVudCBhcnJheSB3aXRoIGZsZXhpYmxlLWFy
cmF5IGluIHN0cnVjdCBwaG1fY2xvY2tfdm9sdGFnZV9kZXBlbmRlbmN5X3RhYmxlDQoNCkZyb206
IG1lbmdiaW5nIHdhbmcgPG1lbmdiaW5nLndhbmdAYW1kLmNvbT4NCg0KDQpBZGQgMSB0byB0aGUg
c2l6ZSBwYXNzZWQgdG8ga3phbGxvYyBhZnRlciByZXBsYWNpbmcgb25lLWVsZW1lbnQgYXJyYXku
DQoNClRoZXJlIGlzIGEgcmVndWxhciBuZWVkIGluIHRoZSBrZXJuZWwgdG8gcHJvdmlkZSBhIHdh
eSB0byBkZWNsYXJlIGhhdmluZw0KYSBkeW5hbWljYWxseSBzaXplZCBzZXQgb2YgdHJhaWxpbmcg
ZWxlbWVudHMgaW4gYSBzdHJ1Y3R1cmUuIEtlcm5lbCBjb2RlDQpzaG91bGQgYWx3YXlzIHVzZSDi
gJxmbGV4aWJsZSBhcnJheSBtZW1iZXJz4oCdWzFdIGZvciB0aGVzZSBjYXNlcy4gVGhlIG9sZGVy
DQpzdHlsZSBvZiBvbmUtZWxlbWVudCBvciB6ZXJvLWxlbmd0aCBhcnJheXMgc2hvdWxkIG5vIGxv
bmdlciBiZSB1c2VkWzJdLg0KDQpSZWZhY3RvciB0aGUgY29kZSBhY2NvcmRpbmcgdG8gdGhlIHVz
ZSBvZiBhIGZsZXhpYmxlLWFycmF5IG1lbWJlciBpbg0Kc3RydWN0IHBobV9wcHRfdjFfbW1fY2xv
Y2tfdm9sdGFnZV9kZXBlbmRlbmN5X3RhYmxlLCBpbnN0ZWFkIG9mIGENCm9uZS1lbGVtZW50IGFy
cmF5LCBhbmQgdXNlIHRoZSBzdHJ1Y3Rfc2l6ZSgpIGhlbHBlciB0byBjYWxjdWxhdGUgdGhlDQpz
aXplIGZvciB0aGUgYWxsb2NhdGlvbi4NCg0KWzFdIGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmVuLndpa2lwZWRpYS5vcmcl
MkZ3aWtpJTJGRmxleGlibGVfYXJyYXlfbWVtYmVyJmFtcDtkYXRhPTA0JTdDMDElN0NldmFuLnF1
YW4lNDBhbWQuY29tJTdDMWE5ODE5Njk5NzZmNDQ4MDUzZDIwOGQ4ODU0YTBlYWMlN0MzZGQ4OTYx
ZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NDA1OTAwODQ3MzY0NjU0JTdD
VW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJ
aUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAmYW1wO3NkYXRhPTNQZU8lMkZ2
bVFYUUFNS09zc3JXOHduT3JlSWpsOGdmZVljMFhYMmZMQ2N4ayUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
WzJdIGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRnd3dy5rZXJuZWwub3JnJTJGZG9jJTJGaHRtbCUyRnY1LjktcmMxJTJGcHJv
Y2VzcyUyRmRlcHJlY2F0ZWQuaHRtbCUyM3plcm8tbGVuZ3RoLWFuZC1vbmUtZWxlbWVudC1hcnJh
eXMmYW1wO2RhdGE9MDQlN0MwMSU3Q2V2YW4ucXVhbiU0MGFtZC5jb20lN0MxYTk4MTk2OTk3NmY0
NDgwNTNkMjA4ZDg4NTRhMGVhYyU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdD
MCU3QzAlN0M2Mzc0MDU5MDA4NDczNjQ2NTQlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lq
b2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4w
JTNEJTdDMzAwMCZhbXA7c2RhdGE9Nnk0WWxPUFU1ejVRck90cHJVcmElMkZtNUVWa052TW5idUtn
YzVXV2szUXVFJTNEJmFtcDtyZXNlcnZlZD0wDQoNClNpZ25lZS1vZmYtYnk6IE1lbmdiaW5nIFdh
bmcgPG1lbmdiaW5nLndhbmdAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
cG93ZXJwbGF5L2h3bWdyL3NtdTEwX2h3bWdyLmMgfCA1ICsrKy0tDQogMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3NtdTEwX2h3bWdyLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5jDQppbmRleCBjZjYwZjM5
OTIzMDMuLjEzM2EwODQ0NDk0MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
cG93ZXJwbGF5L2h3bWdyL3NtdTEwX2h3bWdyLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vcG93ZXJwbGF5L2h3bWdyL3NtdTEwX2h3bWdyLmMNCkBAIC0xMzAsOSArMTMwLDEwIEBAIHN0
YXRpYyBpbnQgc211MTBfY29uc3RydWN0X21heF9wb3dlcl9saW1pdHNfdGFibGUoc3RydWN0IHBw
X2h3bWdyICpod21nciwNCiBzdGF0aWMgaW50IHNtdTEwX2luaXRfZHluYW1pY19zdGF0ZV9hZGp1
c3RtZW50X3J1bGVfc2V0dGluZ3MoDQogc3RydWN0IHBwX2h3bWdyICpod21ncikNCiB7DQoraW50
IGNvdW50ID0gODsNCiBzdHJ1Y3QgcGhtX2Nsb2NrX3ZvbHRhZ2VfZGVwZW5kZW5jeV90YWJsZSAq
dGFibGVfY2xrX3ZsdDsNCg0KLXRhYmxlX2Nsa192bHQgPSBremFsbG9jKHN0cnVjdF9zaXplKHRh
YmxlX2Nsa192bHQsIGVudHJpZXMsIDcpLA0KK3RhYmxlX2Nsa192bHQgPSBremFsbG9jKHN0cnVj
dF9zaXplKHRhYmxlX2Nsa192bHQsIGVudHJpZXMsIGNvdW50KSwNCiBHRlBfS0VSTkVMKTsNCg0K
IGlmIChOVUxMID09IHRhYmxlX2Nsa192bHQpIHsNCkBAIC0xNDAsNyArMTQxLDcgQEAgc3RhdGlj
IGludCBzbXUxMF9pbml0X2R5bmFtaWNfc3RhdGVfYWRqdXN0bWVudF9ydWxlX3NldHRpbmdzKA0K
IHJldHVybiAtRU5PTUVNOw0KIH0NCg0KLXRhYmxlX2Nsa192bHQtPmNvdW50ID0gODsNCit0YWJs
ZV9jbGtfdmx0LT5jb3VudCA9IGNvdW50Ow0KIHRhYmxlX2Nsa192bHQtPmVudHJpZXNbMF0uY2xr
ID0gUFBfREFMX1BPV0VSTEVWRUxfMDsNCiB0YWJsZV9jbGtfdmx0LT5lbnRyaWVzWzBdLnYgPSAw
Ow0KIHRhYmxlX2Nsa192bHQtPmVudHJpZXNbMV0uY2xrID0gUFBfREFMX1BPV0VSTEVWRUxfMTsN
Ci0tDQoyLjE3LjENCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJG
YW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDZXZhbi5xdWFuJTQwYW1kLmNvbSU3QzFhOTgxOTY5
OTc2ZjQ0ODA1M2QyMDhkODg1NGEwZWFjJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4
M2QlN0MwJTdDMCU3QzYzNzQwNTkwMDg0NzM2NDY1NCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhl
eUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZD
STZNbjAlM0QlN0MzMDAwJmFtcDtzZGF0YT1kSnFuVW1nQUFqelBSNVJzcyUyRkVjSFB2VlhkU3ZH
a01UMm5LNlF0b3BMNTAlM0QmYW1wO3Jlc2VydmVkPTANCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
