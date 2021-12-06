Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E232C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ACF67AF3D;
	Mon,  6 Dec 2021 10:21:29 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2043.outbound.protection.outlook.com [40.107.95.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 097DA6E117
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 02:49:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFjZM3GVmEyAxxQMbCDTzGltCeRKsomea+Q0N+sKXbnRwV60IIBTWlt8620DIrAAteOagZPvi3HcCyt5aEtzIyHhALPAUAgTglQwouRIyculA2vnUoR+Uy72eYMG8sAL3deahfq8uWnDgIbI9tShx6h/dJQUtAH5cW1BRCySKr/+8CN9pqvYkkGd4FqVodqOV2HdpNLsTQ40gyAOp9OYcX51VFTANeYQ5PfyYTjohtrEiE4t+3hpeKlMKjKdoR3sdFbQ4EsJoZGFBSJ8qnMnDZ9vmvBWhN7sSEmXIrgI6P1lJ3cTCVLipve1LmDphgo9tD6F1TfDIe/n2zRXGu2Jgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oO7q/kR5PATbEqADbWpIS5R5W+V9g3Os7VFqkILzPYM=;
 b=PieNnFWUkehtjo+4BnRJItA1Deg6p9Pd0iAvYl1MA6FIGSp26qjxScuf7zzAf9hvfwgvLY9hERLE22k6p1tMI/euUWISrvlUHEeBOH+YiZjcBRSzcXUXemL+/BF+WBfbBiJvScXu3DfzOtaVzohsrjZAssVQ34s2203Rt+kr0/AT5O0I0I5UibZqoXrTgYhXUMlgXq7pj8I49OgnGwOqbcFvyn4LeGgPrsRXHh05Isrlfb9OPaML/wqIujXj6Yw4MOtbLJLL4T9W9sw3voMKkxI6lKsAzCRXCUO4poCyJgsciS7cGmV5lGLV+lI/03T1lWv7wyPO4x/uc6lbJCJJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oO7q/kR5PATbEqADbWpIS5R5W+V9g3Os7VFqkILzPYM=;
 b=nhHOr0LSyTTg0uO+CgrtfKleJiGD/EPxA5ojBQXRL1ookw3dLB9488OpYyHo4p1/s9WsKBSDVyYXAF9LAjpvrXHEZLg/IMBXykK/OnA2lLE3eLACen6tWaPG1kllRmMLfRVSGcSNB4ydSfBY1/S1Vf4xeg1unxN1LGjGPr36tS0=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB3115.namprd12.prod.outlook.com (2603:10b6:5:11c::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.20; Mon, 6 Dec 2021 02:49:30 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 02:49:30 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: allow APU to send power gate message when
 dpm is disabled
Thread-Topic: [PATCH 2/2] drm/amdgpu: allow APU to send power gate message
 when dpm is disabled
Thread-Index: AQHX6BKd6VxxmsBvHECw3m2gr5Y+dqwghsoAgAQ/fRA=
Date: Mon, 6 Dec 2021 02:49:30 +0000
Message-ID: <DM6PR12MB4250A082C1B20249D79406E6FB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211203065407.3714697-1-lang.yu@amd.com>
 <20211203065407.3714697-2-lang.yu@amd.com>
 <52f4d894-b122-a831-8182-70bcc2e1ce94@amd.com>
In-Reply-To: <52f4d894-b122-a831-8182-70bcc2e1ce94@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-06T02:46:10Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=09009bf0-f895-432a-8180-974e886d1f9f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-06T02:49:27Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 8cc07799-fbc5-437a-a629-ae89d8376b37
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ce92256-9d75-4343-80ae-08d9b86306e6
x-ms-traffictypediagnostic: DM6PR12MB3115:
x-microsoft-antispam-prvs: <DM6PR12MB31154B6678E16145FD99B5C9FB6D9@DM6PR12MB3115.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NXff50Ajn78xmmVNhWbrEMhYAmOB3WXTUHMrsKw4/sk4kQsm3fiom6RdHeiCFo4TOUT7hFByYVczYvItlOmmsNVtBlivF0l/2sELidWf79ZEfkScvbxc5RMnjUebxxnbfi8G+9JGKuJa7mtYTZXDqWpvtmrdnFEZRLw5lAsFPzzOXqOx8uKIm72UmHGCLmy+Pci3AI66RcsaM9R6TR2UrX73wINboQNiH0T2A6lJZkgzBly2Dvmsfyun21+POSXnWxhMjMDprcGB15mUKI0UkKHeEZZkVgEUyZe+MGnnmbUk7dDgbFwkYUaMrPqGC6sl7/vBqzsORdxssnjhNFjfwIFF3XgyJmP0AKgOfgeiva1GIsjMDzjhLsh3BVVo4f6290U2rO7KuEUAJJEqVoE2qruaw5J6vkYTgmks/ddMelIsCshwBNz7i356lFt2Kr0tuM6RmqBloqMLRoHEpy/uWm4RLeUV1XNpkVeuD+ABuW011BcuuYPzMMAGYu8SLjW9MS3p8rQ3b2cjGIfmuGOTJlQQKosct7o5Hlhg1YYZIpRl37kjEdsDkA+eoza9ZKAMQN562kmMrxR49Ngkm8iPA+Pnx5ApaleGI44ni1HE4SAGG9Vxw7IWKKjt452pOHPRRm3L2CpgAKkL5OHUfqMZkhkc4ayQkMy13/GwTa+A5URQFygut8aH9adnmBLQvRxo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(52536014)(4326008)(38070700005)(2906002)(15650500001)(122000001)(8676002)(8936002)(33656002)(9686003)(6506007)(83380400001)(316002)(76116006)(5660300002)(66446008)(64756008)(38100700002)(86362001)(110136005)(55016003)(71200400001)(54906003)(26005)(66476007)(186003)(66946007)(66556008)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzBIcDdidnNPY2l1RjByUUhpYTgreTJhK0ovaVNDSU8wVWUwRC9GdWJLT0c0?=
 =?utf-8?B?MlRsYXQxWDBuMUZYL044dTFRcVQ0WWp3cGhNVEZXa2luVUhLVWttbFRuamZP?=
 =?utf-8?B?Yno2cFVib0srTWx6bHFaUVZ0TFhpVEdtRFJRcFRsMlgyWXdzREZLNW96RW1T?=
 =?utf-8?B?L296QmtrOFNiRlhQTVN4V1JJOXg1NER3TkgxeGZvRUtjTW00bmMrR3NRV1hN?=
 =?utf-8?B?N3lrZHFUMXZQZGpzeWxXSThFOEpBSnJlNTFZL1FIakZ6bVZURjVUSlRaejRm?=
 =?utf-8?B?VWE3NEhNVDRYU09OSGo1dVltT0RKM1BVdE85M1lyMFNrYklKdXFLRUw4RWhR?=
 =?utf-8?B?NjlLQlZWWWt5QmR0MC9acThmbUZGNjU4S1lGcVUxS01VNVl4Q3kweUE2NU56?=
 =?utf-8?B?ME1veG5KRFB4MGxRK1ZBUXNqaUMrS0crZXlkaUsybGs3Y0pnNXBrQWJYNW9Q?=
 =?utf-8?B?QkJRL2xzVnhmY0JweEdWM0R1VlVKZTM1UnJqRUpMa2VYdjhnSHozZmNYb29z?=
 =?utf-8?B?czhFeS9WK2FTeVVHUzFRWXV5UTlVUytVNHJVZDhIT3VXYWc3TkxjVlFFbHFB?=
 =?utf-8?B?bHJpUjE4S3NRNjRNanV0YXFHaTNST05KdnVoTGxQdDY4SkVGUVgyVzAyS04r?=
 =?utf-8?B?ZVE1a25pRkNSb0pxbmhSUWdlQ2g1VFZpMDEwQTY4VWRXMHo1dU9NTUlkb1lk?=
 =?utf-8?B?V2UxcDhvcmwzbkxLMTZQbWpodmRqOUxyR3dXN0kwZzBqblkrbnlJaFA0bzli?=
 =?utf-8?B?djd5cXo2RzZNNkQweS9pblNIQ2lCWVNqZi80QnJCaGJrbytyc0drdnJraGZq?=
 =?utf-8?B?RWV2UDJ5QXJadDJIVmJkRDhNclh0cW9RWHJCT2VZSDJySlQwQUxPaW1qNHpW?=
 =?utf-8?B?dEo2NUlNeW5JSjQ4djJJQnd0bTZwMHRwdTN5QmNuTDJBdER0Y25sRituNTZX?=
 =?utf-8?B?WEhjVHVkenRKMWdPSWtBYVpzdUllV1l5V3RHdXNRczE0SVp3ajZXeklqenNw?=
 =?utf-8?B?NG5oT25ETUlVelJCY0xtSVg1TENhZkNBbFczak95Y1BCSUV6M2dNQzA3VEtl?=
 =?utf-8?B?UnV4b0VVanBFcEZOcy81dmtmbHFpU1lVMU14ZFQ2cGRhUEhwQjlCbWJDNXov?=
 =?utf-8?B?Y3Y1UElwUE9nalFXVUE5bDBmWW1QN3JSVXFyM0FVdWo4b3dVTFUzT3ptaHg5?=
 =?utf-8?B?Y3NqZm16K1JWcWtnejA5cnBjNVpxblJYWGVyaFZ2OHA2L1Qvb2hYTkIxdVMy?=
 =?utf-8?B?K1lBK2Z6ZGlhTmxpZEVCcTlMQTd5QWl0WkM5cnhGem41L0ZJR21zT3pnZnh6?=
 =?utf-8?B?TXQ3ZGdUMCt5WWVCT3RUYy92czYzUDBxenBIRGE3RnRaVFQ0bmdXUTRVRW55?=
 =?utf-8?B?RzZpTVcyeTBDNjQyUytMVjlHdjE2SHJxTGtJOU4zY09LSTVqZkFwRm9URFFl?=
 =?utf-8?B?Vzd0YWRTc1VUQk43OXRVbUQrRU5JQ3VUOUhUVEp5VTloQUhJaGpuZmQxV0cr?=
 =?utf-8?B?YXc2d3BpZkc3dklqNnptZUF4QkRIYng2ODZ0MUxnUVUya3pRMndRM2M1S015?=
 =?utf-8?B?aFd0YkVoQW9hYVNHRGRTTWtBVU5zTnpiUDFHZXZBK3pOVElwbFdCcWdCeDVY?=
 =?utf-8?B?RmNEWmdMS3BtY2hBV1hHRHNyNG00dW50MTl2alR5RnVEVENVSnIycXU0L1dO?=
 =?utf-8?B?MXNTWGN5a3IyV1BIeEtldlVTZ1ZjcGJKYmRveXY3WW1zQ21ZWGtnMzc0ajFn?=
 =?utf-8?B?N2pZL09UVkQyV1A3TzdWbHJJQXZQL2U4b0FaYTB1bDFWcnhyR2k3U1BFTHlz?=
 =?utf-8?B?ZDNTUXBrMXBVY1NKdXBFK3M5cEFCU096cnhGRk9lZzdtRW9KZ3NQa3pnMitV?=
 =?utf-8?B?YlMzR3g3K0JXRjEwOEFGUy81b3MyTThlMUtMTURVdWZ0NGlVZVlBdnpsSWJP?=
 =?utf-8?B?YWVWQ093YkJyZnFRK2p0MkZSZVBwcWYwTS9mK1R3cGhsR04yWXkvSk1NMkMy?=
 =?utf-8?B?VmlhN2d5Z3ZmYnFyK21yVUFYTkd4Nzg2SkF0WEpVemhGbTN6ZXZxOGY3ZTRH?=
 =?utf-8?B?MFo3TmN4ZE90d010ZVd1NnNyeElGQlV4MXV0U09ua2UxUWN1MGpscWJZZFRZ?=
 =?utf-8?B?VWJnZFlkNFNnUmgwcm9iRGp0OEtpNVdCdDI4Mm16dEdTaVNSYlpUcHZtVTdQ?=
 =?utf-8?Q?eR0/YhCBb+pWUW3+d6dqNbg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce92256-9d75-4343-80ae-08d9b86306e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 02:49:30.5125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h84ogBKToTegVDNYRclxaHMcBIk2oFJij+W4WSJC+6lQ+Nv0O+VQOpi9UvyYWrz+nwCy1mhwLRH/bLVE8dbu5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3115
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

W1B1YmxpY10NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExhemFy
LCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+U2VudDogRnJpZGF5LCBEZWNlbWJlciAzLCAy
MDIxIDU6NTIgUE0NCj5UbzogWXUsIExhbmcgPExhbmcuWXVAYW1kLmNvbT47IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+Q2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT47IEh1YW5nLCBSYXkNCj48UmF5Lkh1YW5nQGFtZC5jb20+DQo+U3ViamVj
dDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IGFsbG93IEFQVSB0byBzZW5kIHBvd2VyIGdh
dGUgbWVzc2FnZQ0KPndoZW4gZHBtIGlzIGRpc2FibGVkDQo+DQo+DQo+DQo+T24gMTIvMy8yMDIx
IDEyOjI0IFBNLCBMYW5nIFl1IHdyb3RlOg0KPj4gVGhlIGdlbmVyYWwgaHcgZmluaSBzZXF1ZW5j
ZSBpcyBTTVUtPiAuLi4gLT5TRE1BLT4gLi4uDQo+PiBXZSBuZWVkIHRvIHNlbmQgcG93ZXIgZ2F0
ZSBtZXNzYWdlIHRvIHBvd2VyIG9mZiBTRE1BKGluIFNETUENCj4+IGh3X2ZpbmkoKSkgYWZlciBk
cG0gaXMgZGlzYWJsZWQoaW4gU01VIGh3X2ZpbmkoKSkuIEFsbG93IHRoYXQgZm9yIEFQVS4NCj4N
Cj5UaGlzIG1lc3NhZ2UgaXMgbm90IHJpZ2h0LiBJbiBBUFVzIHRoZXJlIGlzIG5vIG1lc3NhZ2Ug
cHJvdmlkZWQgYnkgRlcgdG8NCj5lbmFibGUvZGlzYWJsZSBEUE0sIGl0IGlzIGRvbmUgaW4gQklP
Uy4gUmVwaHJhc2UgdG8gc29tZXRoaW5nIGxpa2UgYWZ0ZXIgc211DQo+aHdfZmluaSBpcyBjb21w
bGV0ZWQuDQoNCkl0IGlzIHBvd2VyIG9uL29mZiBTRE1BIG1lc3NhZ2UuIE5vdCBlbmFibGUvZGlz
YWJsZSBEUE0uDQoNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMYW5nIFl1IDxsYW5nLnl1QGFtZC5j
b20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211
LmMgfCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2Ft
ZGdwdV9zbXUuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUu
Yw0KPj4gaW5kZXggMmQ3MThjMzBjOGViLi4yODVhMjM3ZjM2MDUgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYw0KPj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCj4+IEBAIC0yNzcsNyArMjc3LDcg
QEAgc3RhdGljIGludCBzbXVfZHBtX3NldF9wb3dlcl9nYXRlKHZvaWQgKmhhbmRsZSwNCj4+ICAg
CXN0cnVjdCBzbXVfY29udGV4dCAqc211ID0gaGFuZGxlOw0KPj4gICAJaW50IHJldCA9IDA7DQo+
Pg0KPj4gLQlpZiAoIXNtdS0+cG1fZW5hYmxlZCB8fCAhc211LT5hZGV2LT5wbS5kcG1fZW5hYmxl
ZCkgew0KPj4gKwlpZiAoIXNtdS0+cG1fZW5hYmxlZCB8fCAoIXNtdS0+aXNfYXB1ICYmDQo+PiAr
IXNtdS0+YWRldi0+cG0uZHBtX2VuYWJsZWQpKSB7DQo+DQo+DQo+VGhpcyBjaGVjayB3YXMgdGhl
cmUgYmVmb3JlIGFsc28sIG9ubHkgdGhlIFdBUk4gaXMgYWRkZWQuIFRoYXQgbWVhbnMgaXQgd2Fz
DQo+c2tpcHBpbmcgc2VuZGluZyBtZXNzYWdlcyBpbiBBUFVzIGFsc28gYW5kIHNvIGZhciB0aGlz
IHdhcyB3b3JraW5nIGZpbmUgKHVudGlsIHRoaXMNCj5nZXRzIG5vdGljZWQgYmVjYXVzZSBvZiB0
aGUgd2FybmluZykuDQo+DQo+Tm93IHRoaXMgd291bGQgdHJ5IHRvIHNlbmQgdGhlIG1lc3NhZ2Ug
dG8gQVBVIHdpdGhvdXQgYW55IGNoZWNrLiBUaGF0IGRvZXNuJ3QNCj5sb29rIGdvb2QuIElkZWFs
IHdheSBzaG91bGQgYmUgdG8gZml4IHRoZSBzZXF1ZW5jZS4gT3RoZXJ3aXNlLCBzdWdnZXN0IHRv
IGRvDQo+c29tZXRoaW5nIGxpa2UgYmVsb3cgYXMgdGhlIGxhc3Qgc3RlcCBvZiBzbXUgaHcgY2xl
YW51cCByYXRoZXIgdGhhbiBzZW5kaW5nIHRoZQ0KPm1lc3NhZ2UgYmxpbmRseS4NCj4NCj4JaWYg
KHNtdS0+aXNfYXB1KQ0KPgkJc211LT5wbS5kcG1fZW5hYmxlZCA9IHNtdV9pc19kcG1fcnVubmlu
ZyhzbXUpOw0KDQpzbXVfaXNfZHBtX3J1bm5pbmcoc211KSB3aWxsIGNhdXNlIGVycm9ycyBpbiBz
dXNwZW5kLg0KDQpIZXJlIHdlIGp1c3QgIHNlbmQgc29tZSBJUCBwb3dlciBvbi9vZmYgbWVzc2Fn
ZXMuIA0KSXMgaXQgbmVjZXNzYXJ5IHRvIGVuYWJsZSBEUE0gdG8gc2VuZCBzdWNoIG1lc3NhZ2Vz
Pw0KDQpSZWdhcmRzLA0KTGFuZw0KDQo+VGhhbmtzLA0KPkxpam8NCj4NCj4+ICAgCQlkZXZfV0FS
TihzbXUtPmFkZXYtPmRldiwNCj4+ICAgCQkJICJTTVUgdW5pbml0aWFsaXplZCBidXQgcG93ZXIg
JXMgcmVxdWVzdGVkIGZvciAldSFcbiIsDQo+PiAgIAkJCSBnYXRlID8gImdhdGUiIDogInVuZ2F0
ZSIsIGJsb2NrX3R5cGUpOw0KPj4NCg==
