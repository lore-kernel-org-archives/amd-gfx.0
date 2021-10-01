Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CEBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 15:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BDDD615A4
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 15:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BDDD615A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 927656EE25;
	Fri,  1 Oct 2021 15:21:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79B036EE41
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 15:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5P41Tvfx39jp+yNFF+ivL7Xj8Cx5kA4MDG560kBVQMFpkobwd6FFv1/Sle+FL35KOOtY004AjyNA/gwmb1ILTlsqMQb3sXeyNuwh3IoLkWjh3AeHnMc6xhUAtLINRAfXu6aZFZszPF2gZtXCA6R2zuIJImNHBN1McXjE/43Ht7QvxlW20PSNPeRTr0WiT8GGA81c5R9MYlvzfQYheVQHZU9bRE2Hs3FA8jh01Xi6Q2Lh8Q/z2ftVavNp41RorbHLf4WDpXb5Pq/5nR8F7Dn070v1kz8GBgVe8PKIPeXZYFsBxdg/quOwBDrAgvRx+LKd3H5U7TtazMuZ0R9QPg0ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJtTFLX8eqeLofAQim1zImvpZI8XT5A0bWnxpQwALew=;
 b=kTZiC04rjKGC7F0S0K+u6y5D2SfvVrWu1sqnPUyLGba1k/2h+o979tXM47Z+YPmxGqeDKyldocPbaJzpkmN+1cMvvstVPT+DqP3PhYHFpGUm7UOKdV6yNxotsrO9ZuYsOmPMb2dTorKLIXf3odLTdUBj+SrDleg7E1nZpUZMeByCX6xIafCdvaEs7lnZkkXt927h7KK9w9FRsR8bgehuOaQLwmunn6X8ADgNXAfq9Y1hqNFS4RL4tkSpmnBEgW3nwarogkMCCSf04wGdOpJrEgPyYjQJrTl4Yw3C0FIPXNOngrxkkzQ77i9OlMqYagJSXYYZZuCXG/yiqs937gG3gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJtTFLX8eqeLofAQim1zImvpZI8XT5A0bWnxpQwALew=;
 b=Rp/8hbjow8l6zXlNrQgrKBkCfXQht6UNanx4monXZ6FCHXFs6dlqLLck63Kv6nSyjSVuauLTzeh3UK0wGpbhp2JL/nxovqE8OwhAZN63Xai0Kdz137/rZ/mMQIessYnhFaqzMKkkAj44FTZLMapT2pjJzAguNdnMbE0+8qCLX9M=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3579.namprd12.prod.outlook.com (2603:10b6:5:11f::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.17; Fri, 1 Oct 2021 15:21:07 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::bd0e:e376:6277:8109]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::bd0e:e376:6277:8109%6]) with mapi id 15.20.4566.017; Fri, 1 Oct 2021
 15:21:07 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add missed write lock for pci detected state
 pci_channel_io_normal
Thread-Topic: [PATCH] drm/amdgpu: add missed write lock for pci detected state
 pci_channel_io_normal
Thread-Index: AQHXtmgcFP6hLZvNJE64Efk6FSBEOKu9aU0AgABjvXCAAGdygIAADkng
Date: Fri, 1 Oct 2021 15:21:07 +0000
Message-ID: <DM5PR12MB2469490BBE6ED3A83D542004F1AB9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211001020000.14501-1-guchun.chen@amd.com>
 <b7febaef-5442-1503-d743-24a6c50fa179@amd.com>
 <DM5PR12MB2469D34B746A0C1927906879F1AB9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <b45147f2-9ced-23f2-5020-2ff9aff1e12d@amd.com>
In-Reply-To: <b45147f2-9ced-23f2-5020-2ff9aff1e12d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-01T15:21:04Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8e7d453e-8c36-466a-a8a9-19f51563b0cd;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27bbc225-c30f-44c0-8508-08d984ef177e
x-ms-traffictypediagnostic: DM6PR12MB3579:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB357973DB51DA39848662412CF1AB9@DM6PR12MB3579.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /cSX2dupYnVCpQSWwE6I2rZrjkba+Sio1BOIPjcNYiLw+UfjzRay41W4D7Zy9GqQhmj/KLg0EwDOEL+QkUunC1t2P9RsvUvBqLmWzDdu2m0L/rRflKalOIS7Hc/WVE+fRJ7MTdm9zZR7xgt5x0k8Pu6+csb4RCYOKlQWkwHG49IjwytSILXstQJ+D7NoAYiDkgliJsyglkAjy0y3RtCwHFyLgf0gtInEKrrfvLlpI2ZqZWcoCOp0giyJdGgWsydbVIX+yc8cMPOBmBn7U/pB73FiGuI9AwcHMBAjtTSABl/1eTpuvffghOWXGL+FXTh0uJ5DrywIP2wOkdFIPWJMLj2yz4GHvH2x5Mf1gj9dyJ8cyEZTnUhpI2CUuOYlIYremvh6YasocEmrSm9x0gKKQmSorkyHSWn7C5txepB/BZN0GzI3uEL3rilV0pj/h9N8wXaIgA/wo2Q2ehyNQky5DJc3NcpQxl+sl1L6RN6wEwy0AGnORhMdCeDaNpXljQQxEwNzl0r2HNvfsv6h/U6iB5mddAVJuAx8uJKLwobvsPvQ0hfGaTrO23eeCQKy5gIxDZBP2pDiaTRfGw4uKJXWIV7+Khw5VddmPcoRFjSYxNkPA3IdEZKSbOO5tG2Aca5z/U/FQC/f1QyZTpcMBofJJVp788btLvnyCGCExgId10hQbFknstBs9o1ThRcRA5PLTubJduzdgFTrT2WNyd6SZg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(52536014)(86362001)(71200400001)(9686003)(55016002)(8676002)(508600001)(83380400001)(33656002)(5660300002)(2906002)(110136005)(76116006)(64756008)(38100700002)(316002)(122000001)(53546011)(6506007)(6636002)(66446008)(7696005)(66556008)(66476007)(66946007)(38070700005)(186003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXd2Y1dQekMzdHR2ZDlqd2tLN0F1UlYxTEJMUFNXdSs1enpvSmlwVUNGSFRy?=
 =?utf-8?B?Rkp0VDJMK0lTWU9MeGo5enM5OFdZSmk4MGJIZzUwNDltZ0tDQXVjMzJBdnJW?=
 =?utf-8?B?TXBrMzJKSzRUbmRMSFBkanBrYlJMVFBRZkduajk3eHpDSjJxQ1N6enZqaEw3?=
 =?utf-8?B?UFhnMXBBODhBdVJiSkpXR0lBMytlSjA2M3FlWEltV09ERHFpTEJNajZDTXZm?=
 =?utf-8?B?bTA1NFJmRkYrSEtIOW10WGJnR3BpdHQvTjJSY2poN1A2Z2djK2pqRjJNakUv?=
 =?utf-8?B?Vlc4NVJqOTJvVmpxakVkb0lmNnNkNzBDaytkZVdXM3ZnRmxvVXlsTFhZTFAy?=
 =?utf-8?B?SkJXNXp2aUNhazQvWWxDVEd0cHJ1OFFBL3lVdkhFZDZVRHAxR1BWVzVFYmhD?=
 =?utf-8?B?eUNEYUNhMFVidzJmb2JsT3I5WjRRajZNK1lObjZoR29CZnlLYlY0bGtKRUJQ?=
 =?utf-8?B?M3dybGdqT3dyVVh3b2tKU01LcnhaWkxNU1VIbS8yWXNCUkVBbHhGVjljOUlv?=
 =?utf-8?B?WWp0ZTR0OUdVQUE1QmdaV2tLT3hGZzRHd2lya2pMTHpIMmVLTkpLQy9sVnZ4?=
 =?utf-8?B?Ny8zQmJaYjJmR3J6Rk4zL1lobUgxQzg0N0lWK0MvQW03U0tPRnpnYm5iMk9T?=
 =?utf-8?B?SWdUYkdMcHl0clArSEJqRnpvSW9kM004by9nVXVpaXo3aHpDanc3NU5mMG5k?=
 =?utf-8?B?UUJyYTFGMFJDNzFUSU1sYjd2NVZuRUZGeVhteHJxRjVCZ2RmTHgrR2M3Yzl4?=
 =?utf-8?B?eVJxbnp6clc2UHFyKzhrYWE0bnVjMi9SZnlBMVFvOVA4czhGRG9XUVdEYmFq?=
 =?utf-8?B?a2FDNE1XMWNoWTBublRJNitRMGtaY0p5bXJlRnhYNUswQ0xqSEpscXY5akZu?=
 =?utf-8?B?Vm1CUEFsU3NEZmdTaGZHYTNoWGQ2K0hROU8wUGY2VTU2ZkFoSEZLVTNxZWV6?=
 =?utf-8?B?dGlETjBacHEvVklFVkVyMTJ1QVN4Z0ExMVdUYlZsZkxZVTVVZGdOSmp6UmM4?=
 =?utf-8?B?djVSQS9YTDBmOEltZVA3akdXdVVPeHN6Tk55NW1mODhuWHlwaXluZ2JkS1NT?=
 =?utf-8?B?TUhiNGZIeDNReDFsSGR1dSt4bWhMWHhRQXVsbS9ZRnBlR0lMbG5CYm43VWsv?=
 =?utf-8?B?a0FtcHhtTjVJa3h0ZnJwV3dVQUxoY1RvVVpzb3FoeHJmSy9XV2pEc2wrenFG?=
 =?utf-8?B?MDJPeGN6N1lpUmtRcit1MFRYVHBpSndpWmhQNUpDd2t3RTlNVTU3R255blF4?=
 =?utf-8?B?WXZLSVRQMEd2QVU2U05pVFl0WnM0M3R6amV1YWVjc1p1cUxhTjVUVkJDL293?=
 =?utf-8?B?azNtdDJaNWpuVkdGU1MraUluT3I3d3FkWVcxMWYwTUhaNGsrWWlUMmRieExR?=
 =?utf-8?B?Smxub1liN3U4V3IxVzZKUTliM201UEtPNzc4NUhGYUpqWGt2WkRoV2p2STk0?=
 =?utf-8?B?ZkJZMmNjYVdnM0R3OVFldEVvYVhJT3NMdUJLd0d5TUVyVmt6TU94YWR0VGZr?=
 =?utf-8?B?UTVTNnErMjVGSm1ySS9iZkRZSjVvb1VRMXFWVE9lbVlNVk5DcS8zeHNhdWpH?=
 =?utf-8?B?cm14aTlLMFIySGxNQjg5c2tQQmZ0R242OVIwMjdJWExhSm9wM1N1Uy9Wd1ZO?=
 =?utf-8?B?SmZGRXE5bEdUZ0lTZ2dlcTZDcGxudndSMHJKRWF2RDcxQUZzVmhYYVcySzVG?=
 =?utf-8?B?YU1EdXVZczdKcmJtRmRVcmdOUE85RFV2bDI2NVlsVG5lR1hycFEzZlpWa0lL?=
 =?utf-8?Q?fGRLNib8l7wu++T4xzTPUB2Pg/2Hx6RaiIe0SL9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bbc225-c30f-44c0-8508-08d984ef177e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 15:21:07.4554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aKwAbVNkRvaU4tsVWAllvMo7NeJocPdnqv4Ivfm424EfYxmnZTrrjE1ni1/2xE8o4vjCPdQGF85nyM1bYyTnpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3579
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

W1B1YmxpY10NCg0KR290IHlvdXIgcG9pbnQuIFdpbGwgc2VuZCBhIG5ldyBwYXRjaCB0byBhZGRy
ZXNzIHRoaXMuDQoNClJlZ2FyZHMsDQpHdWNodW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IEdyb2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT4g
DQpTZW50OiBGcmlkYXksIE9jdG9iZXIgMSwgMjAyMSAxMDoyOSBQTQ0KVG86IENoZW4sIEd1Y2h1
biA8R3VjaHVuLkNoZW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBL
b2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgUGFuLCBYaW5odWkg
PFhpbmh1aS5QYW5AYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGFkZCBtaXNzZWQg
d3JpdGUgbG9jayBmb3IgcGNpIGRldGVjdGVkIHN0YXRlIHBjaV9jaGFubmVsX2lvX25vcm1hbA0K
DQpObywgc2NoZWR1bGVyIHJlc3RhcnQgYW5kIGRldmljZSB1bmxvY2sgbXVzdCB0YWtlIHBsYWNl
IGluYW1kZ3B1X3BjaV9yZXN1bWUgKHNlZSBzdHJ1Y3QgcGNpX2Vycm9yX2hhbmRsZXJzIGZvciB0
aGUgdmFyaW91cyBzdGF0ZXMgb2YgUENJIHJlY292ZXJ5KS4gU28ganVzdCBhZGQgYSBmbGFnIChw
cm9iYWJseSBpbiBhbWRncHVfZGV2aWNlKSBzbyB3ZSBjYW4gcmVtZW1iZXIgd2hhdCBwY2lfY2hh
bm5lbF9zdGF0ZV90IHdlIGNhbWUgZnJvbSAodW5mb3J0dW5hdGVseSBpdCdzIG5vdCBwYXNzZWQg
dG8gdXMgaW7CoCBhbWRncHVfcGNpX3Jlc3VtZSkgYW5kIHVubGVzcyBpdCdzIHNldCBkb24ndCBk
byBhbnl0aGluZyBpbiBhbWRncHVfcGNpX3Jlc3VtZS4NCg0KQW5kcmV5DQoNCk9uIDIwMjEtMTAt
MDEgNDoyMSBhLm0uLCBDaGVuLCBHdWNodW4gd3JvdGU6DQo+IFtQdWJsaWNdDQo+DQo+IEhpIEFu
ZHJleSwNCj4NCj4gRG8geW91IG1lYW4gdG8gbW92ZSB0aGUgY29kZSBvZiBkcm1fc2NoZWRfcmVz
dWJtaXRfam9icyBhbmQgZHJtX3NjaGVkX3N0YXJ0IGluIGFtZGdwdV9wY2lfcmVzdW1lIHRvIGFt
ZGdwdV9wY2lfZXJyb3JfZGV0ZWN0ZWQsIHVuZGVyIHRoZSBjYXNlIHBjaV9jaGFubmVsX2lvX2Zy
b3plbj8NCj4gVGhlbiBsZWF2ZSBhbWRncHVfcGNpX3Jlc3VtZSBhcyBhIG51bGwgZnVuY3Rpb24s
IGFuZCBpbiB0aGlzIHdheSwgd2UgY2FuIGRyb3AgdGhlIGFjcXVpcmUvbG9jayB3cml0ZSBsb2Nr
IGZvciBjYXNlIG9mIHBjaV9jaGFubmVsX2lvX25vcm1hbCBhcyB3ZWxsPw0KPg0KPiBSZWdhcmRz
LA0KPiBHdWNodW4NCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3Jv
ZHpvdnNreSwgQW5kcmV5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPg0KPiBTZW50OiBGcmlk
YXksIE9jdG9iZXIgMSwgMjAyMSAxMDoyMiBBTQ0KPiBUbzogQ2hlbiwgR3VjaHVuIDxHdWNodW4u
Q2hlbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IA0KPiBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgUGFuLCBYaW5odWkgDQo+IDxY
aW5odWkuUGFuQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGFkZCBtaXNzZWQg
d3JpdGUgbG9jayBmb3IgcGNpIA0KPiBkZXRlY3RlZCBzdGF0ZSBwY2lfY2hhbm5lbF9pb19ub3Jt
YWwNCj4NCj4gT24gMjAyMS0wOS0zMCAxMDowMCBwLm0uLCBHdWNodW4gQ2hlbiB3cm90ZToNCj4N
Cj4+IFdoZW4gYSBQQ0kgZXJyb3Igc3RhdGUgcGNpX2NoYW5uZWxfaW9fbm9ybWFsIGlzIGRldGVj
dGQsIGl0IHdpbGwgDQo+PiByZXBvcnQgUENJX0VSU19SRVNVTFRfQ0FOX1JFQ09WRVIgc3RhdHVz
IHRvIFBDSSBkcml2ZXIsIGFuZCBQQ0kgDQo+PiBkcml2ZXIgd2lsbCBjb250aW51ZSB0aGUgZXhl
Y3V0aW9uIG9mIFBDSSByZXN1bWUgY2FsbGJhY2sgDQo+PiByZXBvcnRfcmVzdW1lIGJ5IHBjaV93
YWxrX2JyaWRnZSwgYW5kIHRoZSBjYWxsYmFjayB3aWxsIGdvIGludG8gDQo+PiBhbWRncHVfcGNp
X3Jlc3VtZSBmaW5hbGx5LCB3aGVyZSB3cml0ZSBsb2NrIGlzIHJlbGVhc2QgDQo+PiB1bmNvbmRp
dGlvbmFsbHkgd2l0aG91dCBhY3F1aXJpbmcgc3VjaCBsb2NrLg0KPg0KPiBHb29kIGNhdGNoIGJ1
dCwgdGhlIGlzc3VlIGlzIGV2ZW4gd2lkZXIgaW4gc2NvcGUsIHdoYXQgYWJvdXQgZHJtX3NjaGVk
X3Jlc3VibWl0X2pvYnMgYW5kIGRybV9zY2hlZF9zdGFydCBjYWxsZWQgd2l0aG91dCBiZWluZyBz
dG9wcGVkIGJlZm9yZSA/IEJldHRlciB0byBwdXQgdGhlIGVudGlyZSBzY29wZSBvZiBjb2RlIGlu
IHRoaXMgZnVuY3Rpb24gdW5kZXIgZmxhZyB0aGF0IHNldCBvbmx5IGluIHBjaV9jaGFubmVsX2lv
X2Zyb3plbi4gQXMgZmFyIGFzIGkgcmVtZW1iZXIgd2UgZG9uJ3QgbmVlZCB0byBkbyBhbnl0aGlu
ZyBpbiBjYXNlIG9mIHBjaV9jaGFubmVsX2lvX25vcm1hbC4NCj4NCj4gQW5kcmV5DQo+DQo+DQo+
PiBGaXhlczogYzlhNmI4MmY0NWUyKCJkcm0vYW1kZ3B1OiBJbXBsZW1lbnQgRFBDIHJlY292ZXJ5
IikNCj4+IFNpZ25lZC1vZmYtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0K
Pj4gLS0tDQo+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMg
fCAxICsNCj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+PiBpbmRleCBiYjVh
ZDJiNmNhMTMuLjEyZjgyMmQ1MWRlMiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jDQo+PiBAQCAtNTM3MCw2ICs1MzcwLDcgQEAgcGNpX2Vyc19y
ZXN1bHRfdCANCj4+IGFtZGdwdV9wY2lfZXJyb3JfZGV0ZWN0ZWQoc3RydWN0IHBjaV9kZXYgKnBk
ZXYsIHBjaV9jaGFubmVsX3N0YQ0KPj4gICAgDQo+PiAgICAJc3dpdGNoIChzdGF0ZSkgew0KPj4g
ICAgCWNhc2UgcGNpX2NoYW5uZWxfaW9fbm9ybWFsOg0KPj4gKwkJYW1kZ3B1X2RldmljZV9sb2Nr
X2FkZXYoYWRldiwgTlVMTCk7DQo+PiAgICAJCXJldHVybiBQQ0lfRVJTX1JFU1VMVF9DQU5fUkVD
T1ZFUjsNCj4+ICAgIAkvKiBGYXRhbCBlcnJvciwgcHJlcGFyZSBmb3Igc2xvdCByZXNldCAqLw0K
Pj4gICAgCWNhc2UgcGNpX2NoYW5uZWxfaW9fZnJvemVuOg0K
