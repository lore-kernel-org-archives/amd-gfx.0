Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1393C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 13:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C3A10E237;
	Wed, 15 Dec 2021 13:28:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA58110E237
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 13:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ntg0dnRC+F0eYc/uLGdv9T/AkLNppqmIChPLAFDyD3RJqS3cym0XHA9Y0aOiLuL0eJxwQEt9h3wLghyEGGl24s7NDgAjx8Y2Shj+rTz4A2ZPkmlKEJAf/pajiTLqmGjrgiIKAJF5sG6bRf0rKPGbjFjI6eUJR9wv1zjJdomovVcyObh82LcTayXdtVA0nEvaAuEtEGqNFqY7/zhtL2M0qqE8/dMRSAzMC130rrCifu7SPIDjd6IqWQaAxTMCRcF2vUzrc2QJR6FL7W/Fo0yChbd34iC7a8aN1QH/loH0ROQMPxzYlh1TFmVh6Hun+qDJzI5FUit5+QdLLIC+n9fw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QR8ut5CQ/AJd7pYxVJQ3MgI9FOGlVBxbq4EZ07u4CeM=;
 b=kFckYttIVPKMYb+L0AmX+IISHrupkhswvQ01ySl+xv3n/R+t0iPTi4q697k9DzZkHcjeWWDlauzXYS1dwwYXL6kC0Z+jpiXG/pmZDSOjwtfqVRAbYLKaA6kWrb4LUh2zPj65fdQ9i+rABRqHrx2WUc27k7OdgfIm2FyaDC6NGn74DFb9l74RpnldQZTZLHFl9f/0x3hekliC3zVLghZakwGV7WQ3jz95J0XqJwCuDGMujn//wVzGWcuBTt5g3zUgt6hFHQiEfs/FA8xgM2obVawQqYPFNH6tzhJOUlKXMv8ZP6v1TD3L2dT/qcNC0UKzEycvDjyGv/D0HYbuT9lTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QR8ut5CQ/AJd7pYxVJQ3MgI9FOGlVBxbq4EZ07u4CeM=;
 b=Fqc+J7aWkkuTcJ1W5CayHFVQpxN65DRbKxjxVsoGwb7F8eaSmWHYRu2TtV//Hg5ybHgVkXFRaP59bKIot8tQ3kMkCbuuq/He18/baBqocmssg+kBYU66cB3XAuXyhQHcR4z0jtQB/AePmYdAsQlWlRhx0vEebsMWkjDrc1N+lsE=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Wed, 15 Dec 2021 13:28:15 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 13:28:15 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Shi, Leslie"
 <Yuliang.Shi@amd.com>, "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add drm_dev_unplug() in GPU initialization
 failure to prevent crash
Thread-Topic: [PATCH] drm/amdgpu: add drm_dev_unplug() in GPU initialization
 failure to prevent crash
Thread-Index: AQHX8ZBaLzABT8jhI06NFNCOIrnebawzYpyAgAAoWEA=
Date: Wed, 15 Dec 2021 13:28:14 +0000
Message-ID: <DM5PR12MB2469E068544B0A422872FDB2F1769@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211215084636.2133355-1-Yuliang.Shi@amd.com>
 <a8f7b8b6-669c-86b8-78eb-e08e6ce147a2@amd.com>
In-Reply-To: <a8f7b8b6-669c-86b8-78eb-e08e6ce147a2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-15T13:24:14Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7450465b-0d2c-4cac-b73b-f3d471d86c42;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-15T13:28:11Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 33be526c-39d5-4d20-ba1b-2eafb6791907
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e04f94c-0cc2-4b00-4968-08d9bfcebfb4
x-ms-traffictypediagnostic: DM6PR12MB2892:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2892B9BE60C513AE34D202AAF1769@DM6PR12MB2892.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FBdj/hmjgr+VcB4+viSLQg7NXYULcMsBNtj9vX2lmVLmY6fyEyJ7BuGNrEU6HdkSDYbA5Ei/BuOI2KO1FkjJoV+lWkYdOWAaXC0s/H3l6grIRxhh/NnU/TCmFRPSI813v2X4B3XKXMGnAYquR+EO+nkVc7L1J16vO+8k5EUNLI2jFFlGUkqpNXLdJUQ7m+tCZeqysTdmL2aefbpoXpg4q/9ppr681WWAXG/bOqrr7gKxNgGGgH96fFT9hpkeJl8jtVyYpbGoW1DM8IhT1JmWAXIRubV6z8LEgp8aRSBWZo4fw+1elrMvTHAvvgrHZdI1N4dVMtkFUVO4mKaJmJQFcnURCxNd26jS3SmQm4dRJzo9iraK9BhlJof7qIXjttmBxuHQd+s7ow1Yi/zlMJN6z1RuiZR+Ziho1O8kqNtcY6KcfikY826B7f27dx/mqKHN8VOulkJJZ3Uz9zAE38jXFL5V+1RGqH8zajJhHvkmmyLAGzdH3mKaN70s6mPL3+5gAz9h9gLdaxkJx6IXGNmRTeunbw08YyJx8g1OtojhsYHl343IQblCBz2s6vqcAd+ap9D1zhU22EMdbkHC+qhg4tXBpq9yGlurNG8jFVuZBmpIjgzJ4/ahnDfYRRHGUXmtKsZ656MuyM+ikCoLH5H/uOltiLDuK8v/ZoKP/Kkt0TPR1ybeOP8HzaTHCH8DmnB2DxhCH1tHDHNn7qA5EgdJV1dvY1UvDIHurMb20ZkJ1a0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(38100700002)(6506007)(52536014)(186003)(55016003)(110136005)(53546011)(26005)(86362001)(83380400001)(122000001)(38070700005)(316002)(7696005)(33656002)(921005)(76116006)(508600001)(71200400001)(5660300002)(2906002)(66446008)(66476007)(8676002)(66556008)(66946007)(64756008)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0dwclF6bTRqcXZ5RHdkeVVoc2V4YXZPajQ5dEh6MU5panBPaWUzb0crOEpq?=
 =?utf-8?B?UEZkREhubmEwMkZDSW53dHdVWG9mL3FRdEc1dFdUMGk5eWhjcEJKTXV0d3NQ?=
 =?utf-8?B?ZG9xaVQzcmFVNVZ5T2wxQnRneEloK1RGaUlIK0x2a21HZEI2NUFwcHAxNk5v?=
 =?utf-8?B?WXJxeUo5RU9KTmVISTFvMmVLZnJndmFXVjdYa3NmbmhPdGt4V2FmOWhrdUc4?=
 =?utf-8?B?a2NhZitmZ01hdWlGOFdyZEUwbjZ6Wnl6NjY3bTF3TW41ZVQ5OVFIcCtRb21C?=
 =?utf-8?B?M2IyRkNJV1hvTVhWQThkeVBWa2F6MTZHOW1EOXJHajRTMFlzSUs0TkI2cENa?=
 =?utf-8?B?aTRsUzA2eWRsMUt3REFWQTlBcUlrem80SmNhSWJLTWQ0eVpzR0RnUy9aT3Fx?=
 =?utf-8?B?d1h2ckxWaGY5aHlQZkt6dUE1ZWo5QlF5WXl6QlpCY3duWEYzSzdSU2hmc0xr?=
 =?utf-8?B?ajRCQUltRmVENmlWVGt3eGVCL3A5eld3YXB3ZjJrSklnR0FCZXRQQlh3WlND?=
 =?utf-8?B?SGlCc3hXS2MzUWpvQTNhdzJyZTlRdEEzWWtxNTcxeU1aK2l4eGY5S0dUczBj?=
 =?utf-8?B?VDdRcmxrbkVid2ZRaG5ldURxQUZIcVdZazFLbVNXUWhCakNXT3hkZDE0S2g4?=
 =?utf-8?B?Rjk1ZDFIT0R3Nlo2dENERlR4MDJZOUlacm9FeG5LQXdOOWh0c2pEL2ZZbVVW?=
 =?utf-8?B?WkFGN1dYaVVMUWI3bTdsdE9Dekd0Tm9BTWc0VnF6eGM4bDMzYWc0K1ZJV1J2?=
 =?utf-8?B?Y0Z1SHJmMWxzRXIzbmV1T0dua1JRYjJvamw2UW4ySUwzNWNQS0t5TjZ5WUQy?=
 =?utf-8?B?NXBSckZZOC9hMi9rb3h0VEFTdXFmeHdsaTkrUlVtYVg1VWR1ck1iUXowQm45?=
 =?utf-8?B?OFBRVFZhVjRVTGtpZ2Y2RE02emZDK0JPb2huYWYyRFdqSHUyT1QyOVB3a2tF?=
 =?utf-8?B?YXEvYnZUbW13Zlo5RkZVOHExUzlQQnVjOG5LZ0NYZml2emQ5YTF2TVZCYzcw?=
 =?utf-8?B?RHVldElYYm1yb21hYzgzWGNaVlBuNGRCcEpkRDJEYnZnM2ZVdFlBWVZSenFp?=
 =?utf-8?B?L2xvOUdUaUVHc1h5c0M0Vk0yNDExV0hiVDA5OW4wVjc1ZWI4M25FSC9idGMy?=
 =?utf-8?B?L2Z0ZmJrZmlQWStBR1RMUjVTckMvWWUydVIxYWU0TnZqL3VtWWVzZHFLSENl?=
 =?utf-8?B?cXBUem1qSlNiUmJSZVdjY3dOb3hGVUExZmp2TWVYZ09aaHovcDhXbkU5eVRS?=
 =?utf-8?B?ZnVKUWV4UlRrT05lQlhGZVh1T1NwcXhHZ1BqaENlMlI0UXdZb3NJTm1EUXNJ?=
 =?utf-8?B?dldGSHE0ZWh6ckhla0N2djFrTjcweUIvblIraDdIWTNkNUNQbmQ2YWx2eThj?=
 =?utf-8?B?bGRLTXVBQU9uZVh5M1B6cXJDdWo5K3FKbXFpczB6WmpXVmlpdVBTYXorMlo4?=
 =?utf-8?B?ZFgrTy81WTNXNVN1WEVGRDBwbCtGVElPbVN6ZUtLZ2lqYXVTYk5mdFkydW1E?=
 =?utf-8?B?UEVKWFE3R2NSTVJaU2RMTmxYakNqWlIvdlkxaXNUNnNBWkxDYThDZXRUNTdk?=
 =?utf-8?B?YTI5SnZhc21jM0tQZkFoYzU2VXBKRjRUbTBabFA1UTBEcUNTWGIyK0VoSXVE?=
 =?utf-8?B?aG1hbW9IKzRZK1NNYnlhd3hUVGZTaEF2Qy8yRithbmtCWUlRbkp4U3czZlF6?=
 =?utf-8?B?ZitvOVdzaVZGaHpZRlNGVnFaQ3ZHQTUvWEI2NHJ1ZzQ0bXRGSW1ZUEs2RGFo?=
 =?utf-8?B?KzhyQktEb1NwbC8zNS9leTNzMjl5ZHR2VFB5SmtZbmRzUmVtdit6NFFFbFBz?=
 =?utf-8?B?VllhbEhIQmdROThKN1RyMFc1MExpOEtRc2ZEeHN3QUtzeGdKbzlzbkl2NUh1?=
 =?utf-8?B?NEF1Ri84d0dWTlRtQW5lYnZoWlJ1TVd5R0lERGE0bmdpS1J3dCsxV3NvL1c5?=
 =?utf-8?B?M1VsOFcvNkQzOUJJeEVBMWN4VDU1bnRZR0FDU21XT0Y3TWpGbFdOelNNc0xM?=
 =?utf-8?B?ZGJ3YWY3KzVPbVNDZktJdmM5Y0k0RmdORmtLK1B6WmtCQWpIVExTbXg3b2I0?=
 =?utf-8?B?bVhrRU5hMTBlaUJRanA5QVNGYzhKVC9GbjNpN1hvRjZ6bXFVZ0lDWDQyaDMr?=
 =?utf-8?B?bzJjZkNrRVUxbThCd3VmdjVaNFVtY3hIV3lxMkJYY3ZxZGIyVWo1NWVsOVk1?=
 =?utf-8?Q?QkHoULkmhv53S5kOa1PcX/k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e04f94c-0cc2-4b00-4968-08d9bfcebfb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 13:28:14.8817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15aXGA4fPJYxTK5lTYZWQW6GsrgwhMt5w9qWjYVhGuglCr7GkEQailp+dRS9/wHcIptBwYgx1TtK4nc3ngDnYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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

W1B1YmxpY10NCg0KSGkgQ2hyaXN0aWFuLA0KDQpZb3VyIHF1ZXN0aW9uIGlzIGEgcmVhbGx5IGdv
b2Qgb25lLiBUaGUgcGF0Y2ggdG8gdW5tYXAgTU1PSSBpbiBzdWNoIGVhcmx5IHBoYXNlIGlzIGZy
b20gQW5kcmV5J3MgcGF0Y2g6IGRybS9hbWRncHU6IFVubWFwIGFsbCBNTUlPIG1hcHBpbmdzLiBJ
dCdzIGEgcGF0Y2ggaGFsZiBhIHllYXIgYWdvLCBhbmQgZXZlcnl0aGluZyBsb29rcyBmaW5lIHRp
bGwgdGhpcyBjYXNlLg0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29t
PiANClNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMTUsIDIwMjEgNzowMCBQTQ0KVG86IFNoaSwg
TGVzbGllIDxZdWxpYW5nLlNoaUBhbWQuY29tPjsgR3JvZHpvdnNreSwgQW5kcmV5IDxBbmRyZXku
R3JvZHpvdnNreUBhbWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT47IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29t
Pg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogYWRkIGRybV9kZXZfdW5wbHVnKCkg
aW4gR1BVIGluaXRpYWxpemF0aW9uIGZhaWx1cmUgdG8gcHJldmVudCBjcmFzaA0KDQpBbSAxNS4x
Mi4yMSB1bSAwOTo0NiBzY2hyaWViIExlc2xpZSBTaGk6DQo+IFtXaHldDQo+IEluIGFtZGdwdV9k
cml2ZXJfbG9hZF9rbXMsIHdoZW4gYW1kZ3B1X2RldmljZV9pbml0IHJldHVybnMgZXJyb3IgDQo+
IGR1cmluZyBkcml2ZXIgbW9kcHJvYmUsIGl0IHdpbGwgc3RhcnQgdGhlIGVycm9yIGhhbmRsZSBw
YXRoIA0KPiBpbW1lZGlhdGVseSBhbmQgY2FsbCBpbnRvIGFtZGdwdV9kZXZpY2VfdW5tYXBfbW1p
byBhcyB3ZWxsIHRvIHJlbGVhc2UgDQo+IG1hcHBlZCBWUkFNLiBIb3dldmVyLCBpbiB0aGUgZm9s
bG93aW5nIHJlbGVhc2UgY2FsbGJhY2ssIGRyaXZlciBzdGlsbHMgdmlzaXRzIHRoZSB1bm1hcHBl
ZCBtZW1vcnkgbGlrZSB2Y24uaW5zdFtpXS5md19zaGFyZWRfY3B1X2FkZHIgaW4gdmNuX3YzXzBf
c3dfZmluaS4gU28gYSBrZXJuZWwgY3Jhc2ggb2NjdXJzLg0KDQpNaG0sIGludGVyZXN0aW5nIHdv
cmthcm91bmQgYnV0IEknbSBub3Qgc3VyZSB0aGF0J3MgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvLg0K
DQpRdWVzdGlvbiBpcyB3aHkgYXJlIHdlIHVubWFwcGluZyB0aGUgTU1JTyBzcGFjZSBvbiBkcml2
ZXIgbG9hZCBmYWlsdXJlIHNvIGVhcmx5IGluIHRoZSBmaXJzdCBwbGFjZT8gSSBtZWFuIGRvbid0
IHdlIG5lZWQgdG8gY2xlYW4gdXAgYSBiaXQ/DQoNCklmIHRoYXQncyByZWFsbHkgdGhlIHdheSB0
byBnbyB0aGVuIHdlIHNob3VsZCBhdCBsZWFzdCBhZGQgYSBjb21tZW50IGV4cGxhaW5pbmcgd2h5
IGl0J3MgZG9uZSB0aGF0IHdheS4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KPg0KPiBbSG93
XQ0KPiBBZGQgZHJtX2Rldl91bnBsdWcoKSBiZWZvcmUgZXhlY3V0aW5nIGFtZGdwdV9kcml2ZXJf
dW5sb2FkX2ttcyB0byBwcmV2ZW50IHN1Y2ggY3Jhc2guDQo+IEdQVSBpbml0aWFsaXphdGlvbiBm
YWlsdXJlIGlzIHNvbWVob3cgYWxsb3dlZCwgYnV0IGEga2VybmVsIGNyYXNoIGluIHRoaXMgY2Fz
ZSBzaG91bGQgbmV2ZXIgaGFwcGVuLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBMZXNsaWUgU2hpIDxZ
dWxpYW5nLlNoaUBhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfa21zLmMgfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2tt
cy5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYw0KPiBpbmRl
eCA2NTFjN2FiZmRlMDMuLjdiZjZhZWNkYmI5MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9rbXMuYw0KPiBAQCAtMjY4LDYgKzI2OCw4IEBAIGludCBhbWRncHVfZHJp
dmVyX2xvYWRfa21zKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCBsb25nIGZs
YWdzKQ0KPiAgIAkJLyogYmFsYW5jZSBwbV9ydW50aW1lX2dldF9zeW5jIGluIGFtZGdwdV9kcml2
ZXJfdW5sb2FkX2ttcyAqLw0KPiAgIAkJaWYgKGFkZXYtPnJtbWlvICYmIGFkZXYtPnJ1bnBtKQ0K
PiAgIAkJCXBtX3J1bnRpbWVfcHV0X25vaWRsZShkZXYtPmRldik7DQo+ICsNCj4gKwkJZHJtX2Rl
dl91bnBsdWcoZGV2KTsNCj4gICAJCWFtZGdwdV9kcml2ZXJfdW5sb2FkX2ttcyhkZXYpOw0KPiAg
IAl9DQo+ICAgDQo=
