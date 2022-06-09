Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A299C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jun 2022 14:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE46211A90F;
	Thu,  9 Jun 2022 14:44:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B9B311A90F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jun 2022 14:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kU7GxnH5MBqPKel7MTLm5fUXYn3DT+Kj2yvpCK1Sm/DoOdUIg2nfmfq9mMVAMGGkJXitR1FucS1gYhyG1lDZ3NNmawUWR6QNbFCJTniNbykEcxQaQsqr/AochqoD/LlLgjYT6kic674IO+uO7DSko00h38uS+NwDmgTHL9H5F5DXvz9lNAwFhTzWiQwyxCvX7HVzGY7XMi1OoglUq5S8AxbHTPGVcwem0DuAU6WmaJCdRvtNicI43sJrVAvjnhtoQezjdErHXX8ogwMryu+7/vtbit1pYUay2f1GIiYRdLTwoK4VF2gt38LbaH57dqmrYCIiJVFcsRtn1wseeAliVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPmrnNrZzGEesGOLqXvGbNf3gH8H9KBhFGz68XjFxYo=;
 b=nqPr36FXBkCO7O2FsIWn6WGusxozRhY0w9ubY/I0foWqKZVlXNkD0czrPzFFtcrehf9NJXaLqWHdBqdjjIjw7muw79gUeaCnf5dD8/ncAWoUxkt5y3uWE9oJQeyrsgtOrX2ZQH9pKwetmk+Qksadre+IOgnw+o+1LbocFS1UFnTjQrCWlQ2C9clBTyiKJqBWDTuL4oB3eSyIGLYBa5llKU/CsZsdnQwYaDhS1BXftSRiFdvoUrw4Dla8hP9gbP4qqajcpCSgGEug5i9bHwC5aiHukv4b4/XyEVkqBDKLQxbGfWnHnrU0WG/Xo+pqgaIeNprbPsT89PpizFHWMwiiSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPmrnNrZzGEesGOLqXvGbNf3gH8H9KBhFGz68XjFxYo=;
 b=aH4/mC644A0pqQz++5rvYn6bzXx9f9kei5qAnN+60/b1rQiFPHL5TEHBtQbeLOMjBi7F6fFn3/cg7sk4KJHxT3aygg1mTDF9kjs7ywCUsSBrPnrxikolYio68cMVh2DtLKg52skBv8jYgPuyQTRytL4VVuKxFR9AEkivhccrMdQ=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 by BYAPR12MB3270.namprd12.prod.outlook.com (2603:10b6:a03:137::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Thu, 9 Jun
 2022 14:44:20 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::58d8:1b61:8bdb:2824]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::58d8:1b61:8bdb:2824%4]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 14:44:20 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Unpin MMIO and DOORBELL BOs only after map
 count goes to zero
Thread-Topic: [PATCH] drm/amdgpu: Unpin MMIO and DOORBELL BOs only after map
 count goes to zero
Thread-Index: AQHYey4Vf9pg3yO4kUK6rCliqoBzWa1F6JsAgAAF7eCAAAwVgIABAQUg
Date: Thu, 9 Jun 2022 14:44:20 +0000
Message-ID: <SN1PR12MB25751550E5E84F119F616EFBE3A79@SN1PR12MB2575.namprd12.prod.outlook.com>
References: <20220608115110.1798650-1-Ramesh.Errabolu@amd.com>
 <954e9aa2-835b-397a-299c-c98bb60b764f@amd.com>
 <SN1PR12MB2575DAB025B69322D14B60D1E3A49@SN1PR12MB2575.namprd12.prod.outlook.com>
 <4eb71fb8-fff6-4686-03ba-877fb920770e@amd.com>
In-Reply-To: <4eb71fb8-fff6-4686-03ba-877fb920770e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-09T12:03:57Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d7bd5e0b-042d-4f92-9f29-63f8b5909bf6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-09T14:44:18Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 6a2983fd-24ea-4835-b232-6c99c4824b90
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05ebbdd0-9a83-4a73-2a44-08da4a2689cb
x-ms-traffictypediagnostic: BYAPR12MB3270:EE_
x-microsoft-antispam-prvs: <BYAPR12MB327041EBD107B0FDD6EA292DE3A79@BYAPR12MB3270.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SMDSAuFEOs04pPIQGWTcr5qzZL1rF9nwFpAJ6hbMhnF6uMAbUyTCPWaL0ZZKVPXbwX+VWRxaVj0+3mK0CmS+LSRz+BItUWo1s47/XN0kI3zPRNMHvR1ncsCf/2pAaj2REev/OyuuemC0CXiPQEqCzMbRBoJKtg9DkSTOFYfK1YZu7Kz7TLQHoLHQXILFMbqTpgEWQLiZoJ9ciCjg+ua7QjN92gLhW96mVYngVjy2memBG7hT+mXUv5Zvh7lyHmLtS81ArbjWleQlPXLk7HjuVAHVCJp7qgAn3+wIJ73VmKmdwNQ9HdtID6POOLX7yTH5MG5U9eO4WsAmbbwP6ohwPBTOG0B5We6u51kiqM1AmABeQ6PiuFRiT97k5G7NOSbMM2e4esdMfNoETdIvhfC0j+KuXlCKm4C53FK6XNT1Uu2diMZGd68wQZoEwPbBcFOwLFoWuAZEdmha8rsSE2rz2MUrvnHy15VcHJ0ZDnmgtKNvxSbPntrEXeAZQp2y8OhzCRXTlnpgZ7YqYNt4pu1UulDZ//kxIAWUNuWghKccDI0vc8rFAoN7kpwGX1/xM/UeyY1XfYDH1APQz8j0/DR/kQIHbCWBUYTrQEgM4RZ99aDLoHlx6So0NckGlaoozz40pFcUVudysVu/26C+i2txcT/kuJV7WP+Tgy/MKp8/syZBoet15KcFEIupcJOgvB49wj955yAtVukJfTj9q3BBrg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2575.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(5660300002)(38070700005)(122000001)(38100700002)(86362001)(83380400001)(110136005)(66476007)(66946007)(33656002)(186003)(26005)(64756008)(66446008)(8676002)(66556008)(8936002)(55016003)(71200400001)(2906002)(6506007)(7696005)(9686003)(53546011)(508600001)(316002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uy8vMit5NTI3VTR4Z3lhK1oxbTZqWXh5d2xRTENLL0FpQ1JHR3BvT2hPTTFr?=
 =?utf-8?B?YkR5WjdCTmIwWFA5dmhNSCtlem5kTG9pTHJEbGJhS0ZTUHVsTW9Qb0NGNHBG?=
 =?utf-8?B?YitnUU1PWm1zZVRUaThJRHdpMXlyTGFJNFRMTThvdFZQdFBmczlhUExTbUNy?=
 =?utf-8?B?bkFUWVBTN0Z0c0ZsZi9YU0dFT29yUjhsNlc3NVlucld2b2tZcTQrZFJNNUFk?=
 =?utf-8?B?akZZM3YwZ21wRFhKditBckdWbzlxVUtmeThKMVc2dTBUQ2MyQ0RIc2VKTW4v?=
 =?utf-8?B?Q1FjV0VIckgrMkxPUC9sdFRtUlcxb2lYTitWMzBaelBkYk1aek9LRjhQTG1a?=
 =?utf-8?B?TE1OenhwNE02SHpwdUpHUGNpd1NnMisyTE1veGd6MzZTWDBvckxEMWw1MHov?=
 =?utf-8?B?SUlQaWorZEdMUXFqNlR0eDM5OWRMdmZEQWx2TlROTXoyckFHZDNlclI0Q3JP?=
 =?utf-8?B?YXNHakVSRzFURjVXWjJIVVhja0JQL2dPd0xBemx4ZHpnM1pJQmkzNmI3NkF4?=
 =?utf-8?B?WjZvQXhRZHUyRmFaQ0FYUjBRNUlBSHkrRUtVR2x1NlBjZlN5M1FrWUlSeFBp?=
 =?utf-8?B?dlNhNFloaFUxcUorTjRseUFyRktkNTdpM1BwSWUxbmJ0TVVnZTJVUlMwckZ5?=
 =?utf-8?B?RlFDZVZrbEZ5b1V3TitMaCsxbGdXQzU2UXBrUjlWMUV2emI2K3hVVXEwWDZp?=
 =?utf-8?B?L2Y2MUtOanpmcTlncjg2aTB2azlmY3VpZWVlMGMzVXJTcDVtb0NmM0Z1dUly?=
 =?utf-8?B?OXlqNTc5eUt1U1AwbDc2L0xTR05KeTZVRysyQThvMlNEQ3l5QlhlRTVsMFFJ?=
 =?utf-8?B?cDNmSUNOeTJDcTRlVmw2YUJWSkNER3FrN05DcXZQcUl5WDBXRWZNNU9vbFcr?=
 =?utf-8?B?RkRhaXp3ekQ2VDJYanplS3RZbGxQRU9GRTZFaVN5VGkraWVFbk9aYnl1MVVl?=
 =?utf-8?B?TjZqR201VzljMjVzK0pDanB5ZDdYbFpTZElDZUt4eWl3WkNFbDVPckZvYWZ0?=
 =?utf-8?B?SnZ5QXdTeWdBQVgyQ1hzSWluNjFJTlBFS0M0SHMyUmFyOThtNktCMlp2NXA5?=
 =?utf-8?B?Tllra2tla0gwenNLNGswZ2VqN1RvSzZrZWVQa3AzUmtac2NXZUFSNlMrWlhs?=
 =?utf-8?B?WjFoN3pRaytoNTVTNjR2M3d0RTI5eCtWcTFrSFpDc09qNng5NWlJMllqZk5E?=
 =?utf-8?B?VlBRTTk2bXVuVVllclFpMzhpVFgxNHVlK1ZzUHowTVdmM2Irb0wrNDdTYzJ2?=
 =?utf-8?B?TUN3MUR3RDhidWw2WkF6OUFwcUhDUEo0R0M4Vk1nL3JteFc5cUhoOGRqNzJ6?=
 =?utf-8?B?Q25kTjMyeERvVGtRS0g4QnBCbGtQaW54Zms3RGlxOVAxNFZHYkNySGpJbHdx?=
 =?utf-8?B?c2dCbU50UHVpaWNrZk0rQVJMS29OanlHcjM4T1YyVjNzbDZEYjRFKzFQbG1M?=
 =?utf-8?B?c1p6d0dRVjBLVnNMODNxM28wTW1wTXVoWG5TS1hKTmxEQkFVaG9mbHI2Qzdp?=
 =?utf-8?B?ZXNRTWZZWHlyYVFrV251UFNRaWlEelJ6YWtEdk1QZFUxZlhFMU90RnhJaXpF?=
 =?utf-8?B?Z3VQSlRsSmpzVVZ1NmVOdDh2ZUQvTVlLb2VlZHh5ODZjZ3Vva1RyUG9xTEll?=
 =?utf-8?B?OTl5ZkZSR2VBcHlzQVRYTHp4REU1UVVkOTR4VzlNNjdHdDRkZDhmVXdhL0t5?=
 =?utf-8?B?U1ZlMnpiMXAxdDZaT0tpMnBFdTNsdkRBYWZDS0hRTDJtMzBwcThHdXhzQmo3?=
 =?utf-8?B?RlZOTjRJSFZCblJlWTEvR04xbWE5RnA4WjFMT0RGalJ3U2JoZjFtYktUZlRr?=
 =?utf-8?B?elFoczdxNDJNcDM3bGRCejZCWHg4aTJ0K2xaUGozTHVGQndKZkN5cGdqbmF5?=
 =?utf-8?B?YXBGZ0Rhd1pEM21hSUZzL0JkTGNzYzJHOE9zNFlNRVExZkhpVmxCcnh4M3hW?=
 =?utf-8?B?aXVmT3JFS3hyeUR1dnNPSU5ONHNOWUc3N2c1TEhjbURkaWU5dG5WRGVrYUVY?=
 =?utf-8?B?MGxkUC9nMVUzRVhZVG1VNHFyVlNlRXVZSDdGNTJsTzNoWklhdnh6aDJ3dXYr?=
 =?utf-8?B?SU9WajFxZzlZdndqcGsxdk11eWNZMmhGd2ZhK3FiNE0walNUeE95cUd6VUVS?=
 =?utf-8?B?VERGTkhmaUZhbjMrN09xY05FZHhkZ2xWL25HNWpIaVI4R01adG5XRzdGU2xo?=
 =?utf-8?B?dnRkSGtFWmlrdE9yVWM3Zkw1M0xLamQ1dHRGZ0lPVXJZVVh6N2liZy9YNnNM?=
 =?utf-8?B?RXBZUTZOZlgwaDVzMTErVDQ0ZzBqaTg1ang1MEQ1d2w5bjkvMUhwOGJXVXhV?=
 =?utf-8?Q?er2zXaSrueQr9v65DM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2575.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ebbdd0-9a83-4a73-2a44-08da4a2689cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 14:44:20.6883 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgIIDoyQ8qjSrJHsMmqsMcxW+CHuaFLC/CaNgTulrktkBR8ynd3EraGYR8Kr450Xw8GDQy3kEJV9/7NXb/DuSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3270
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCk15IHJlc3AgaW4gbGluZQ0KDQpS
ZWdhcmRzLA0KUmFtZXNoDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLdWVo
bGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+IA0KU2VudDogVGh1cnNkYXksIEp1
bmUgOSwgMjAyMiAyOjE0IEFNDQpUbzogRXJyYWJvbHUsIFJhbWVzaCA8UmFtZXNoLkVycmFib2x1
QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQ
QVRDSF0gZHJtL2FtZGdwdTogVW5waW4gTU1JTyBhbmQgRE9PUkJFTEwgQk9zIG9ubHkgYWZ0ZXIg
bWFwIGNvdW50IGdvZXMgdG8gemVybw0KDQpPbiAyMDIyLTA2LTA4IDE2OjAzLCBFcnJhYm9sdSwg
UmFtZXNoIHdyb3RlOg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gR2VuZXJhbF0NCj4NCj4g
TXkgcmVzcG9uc2UgaXMgaW5saW5lLg0KPg0KPiBSZWdhcmRzLA0KPiBSYW1lc2gNCj4NCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5L
dWVobGluZ0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSA5LCAyMDIyIDE6MTAgQU0N
Cj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBFcnJhYm9sdSwgUmFtZXNoIA0K
PiA8UmFtZXNoLkVycmFib2x1QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9h
bWRncHU6IFVucGluIE1NSU8gYW5kIERPT1JCRUxMIEJPcyBvbmx5IA0KPiBhZnRlciBtYXAgY291
bnQgZ29lcyB0byB6ZXJvDQo+DQo+DQo+IE9uIDIwMjItMDYtMDggMDc6NTEsIFJhbWVzaCBFcnJh
Ym9sdSB3cm90ZToNCj4+IEluIGV4aXN0aW5nIGNvZGUgTU1JTyBhbmQgRE9PUkJFTEwgQk9zIGFy
ZSB1bnBpbm5lZCB3aXRob3V0IGVuc3VyaW5nIA0KPj4gdGhlIGNvbmRpdGlvbiB0aGF0IHRoZWly
IG1hcCBjb3VudCBoYXMgcmVhY2hlZCB6ZXJvLiBVbnBpbm5pbmcgDQo+PiB3aXRob3V0IGNoZWNr
aW5nIHRoaXMgY29uc3RyYWludCBjb3VsZCBsZWFkIHRvIGFuIGVycm9yIHdoaWxlIEJPIGlzIA0K
Pj4gYmVpbmcgZnJlZWQuIFRoZSBwYXRjaCBmaXhlcyB0aGlzIGlzc3VlLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IFJhbWVzaCBFcnJhYm9sdSA8UmFtZXNoLkVycmFib2x1QGFtZC5jb20+DQo+PiAt
LS0NCj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0u
YyB8IDE1ICsrKysrKystLS0tLS0tLQ0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgOCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPj4gaW5kZXggYTFkZTkwMGJhNjc3Li5l
NWRjOTRiNzQ1YjEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPj4gQEAgLTE4MzIsMTMgKzE4MzIsNiBAQCBpbnQgYW1k
Z3B1X2FtZGtmZF9ncHV2bV9mcmVlX21lbW9yeV9vZl9ncHUoDQo+PiAgICANCj4+ICAgIAltdXRl
eF9sb2NrKCZtZW0tPmxvY2spOw0KPj4gICAgDQo+PiAtCS8qIFVucGluIE1NSU8vRE9PUkJFTEwg
Qk8ncyB0aGF0IHdlcmUgcGlubmVkIGR1cmluZyBhbGxvY2F0aW9uICovDQo+PiAtCWlmIChtZW0t
PmFsbG9jX2ZsYWdzICYNCj4+IC0JICAgIChLRkRfSU9DX0FMTE9DX01FTV9GTEFHU19ET09SQkVM
TCB8DQo+PiAtCSAgICAgS0ZEX0lPQ19BTExPQ19NRU1fRkxBR1NfTU1JT19SRU1BUCkpIHsNCj4+
IC0JCWFtZGdwdV9hbWRrZmRfZ3B1dm1fdW5waW5fYm8obWVtLT5ibyk7DQo+PiAtCX0NCj4+IC0N
Cj4+ICAgIAltYXBwZWRfdG9fZ3B1X21lbW9yeSA9IG1lbS0+bWFwcGVkX3RvX2dwdV9tZW1vcnk7
DQo+PiAgICAJaXNfaW1wb3J0ZWQgPSBtZW0tPmlzX2ltcG9ydGVkOw0KPj4gICAgCW11dGV4X3Vu
bG9jaygmbWVtLT5sb2NrKTsNCj4+IEBAIC0xODU1LDcgKzE4NDgsNyBAQCBpbnQgYW1kZ3B1X2Ft
ZGtmZF9ncHV2bV9mcmVlX21lbW9yeV9vZl9ncHUoDQo+PiAgICAJLyogTWFrZSBzdXJlIHJlc3Rv
cmUgd29ya2VycyBkb24ndCBhY2Nlc3MgdGhlIEJPIGFueSBtb3JlICovDQo+PiAgICAJYm9fbGlz
dF9lbnRyeSA9ICZtZW0tPnZhbGlkYXRlX2xpc3Q7DQo+PiAgICAJbXV0ZXhfbG9jaygmcHJvY2Vz
c19pbmZvLT5sb2NrKTsNCj4+IC0JbGlzdF9kZWwoJmJvX2xpc3RfZW50cnktPmhlYWQpOw0KPj4g
KwlsaXN0X2RlbF9pbml0KCZib19saXN0X2VudHJ5LT5oZWFkKTsNCj4gSXMgdGhpcyBhbiB1bnJl
bGF0ZWQgZml4PyBXaGF0IGlzIHRoaXMgbmVlZGVkIGZvcj8gSSB2YWd1ZWx5IHJlbWVtYmVyIGRp
c2N1c3NpbmcgdGhpcyBiZWZvcmUsIGJ1dCBjYW4ndCByZW1lbWJlciB0aGUgcmVhc29uLg0KPg0K
PiBSYW1lc2g6IFRoaXMgZml4IGlzIHVucmVsYXRlZCB0byBQMlAgd29yay4gSSBicm91Z2h0IHRo
aXMgaXNzdWUgdG8gYXR0ZW50aW9uIHdoaWxlIHdvcmtpbmcgb24gSU9NTVUgc3VwcG9ydCBvbiBE
S01TIGJyYW5jaC4gQmFzaWNhbGx5IGEgdXNlciBjb3VsZCBjYWxsIGZyZWUoKSBiZWZvcmUgdGhl
IG1hcCBjb3VudCBnb2VzIHRvIHplcm8uIFRoZSBwYXRjaCBpcyB0cnlpbmcgZml4IHRoYXQuDQoN
CkkgZ2V0IHRoYXQsIGJ1dCBJIGNvdWxkbid0IHJlbWVtYmVyIHdoeSBJIHN1Z2dlc3RlZCBsaXN0
X2RlbF9pbml0IGhlcmUuIA0KSXQgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCB1bnBpbm5pbmcgb2Yg
Qk9zLg0KDQpOb3cgSSByZWNhbGwgdGhhdCBpdCBoYWQgc29tZXRoaW5nIHRvIGRvIHdpdGggcmVz
dGFydGluZyB0aGUgaW9jdGwgYWZ0ZXIgaXQgd2FzIGludGVycnVwdGVkIGJ5IGEgc2lnbmFsLiBy
ZXNlcnZlX2JvX2FuZF9jb25kX3ZtcyBjYW4gZmFpbCB3aXRoIC1FUkVTVEFSVFNZUy4gSW4gdGhh
dCBjYXNlIHRoZSBpb2N0bCBpcyByZWVudGVyZWQuIFdlIG5lZWQgdG8gbWFrZSBzdXJlIGl0IGRv
ZXNuJ3QgY3Jhc2ggdGhlIHNlY29uZCB0aW1lIGFyb3VuZC4gbGlzdF9kZWwgd2lsbCByZW1vdmUg
Ym9fbGlzdF9lbnRyeSBmcm9tIHRoZSBsaXN0IGJ1dCBsZWF2ZSB0aGUgcG9pbnRlcnMgZGFuZ2xp
bmcuIFRoZSBzZWNvbmQgdGltZSBhcm91bmQgaXQgd2lsbCBwcm9iYWJseSBjYXVzZSBjb3JydXB0
aW9uIG9yIGFuIG9vcHMuIFVzaW5nIGxpc3RfZGVsX2luaXQgYXZvaWRzIHRoYXQgYnkgaW5pdGlh
bGl6aW5nIHRoZSBwcmV2IGFuZCBuZXh0IHBvaW50ZXJzIHRvIE5VTEwuDQoNClJhbWVzaDogSSBz
ZWUgdGhlIHNhbWUgaWRpb20gaW4gdGhlIG1ldGhvZCByZW1vdmVfa2dkX21lbV9mcm9tX2tmZF9i
b19saXN0KCkuIFNob3VsZCB3ZSBiZSBjYWxsaW5nIHRoaXMgbWV0aG9kIHJhdGhlciB0aGFuIHJl
LXdyaXRlIHRoZSBzYW1lIGNvZGUgYmxvY2suIEFsc28gdGhlIG5hbWUgcmVtb3ZlX3h5el9rZmRf
Ym9fbGlzdCgpIGlzIG1pc2xlYWRpbmcuIFNob3VsZCB0aGlzIG5hbWUgYmUgY2hhbmdlZC4NCg0K
U2VlIG9uZSBtb3JlIGxpdHRsZSBmaXggYmVsb3cuDQoNCg0KPg0KPiBSZWdhcmRzLA0KPiAgIMKg
IEZlbGl4DQo+DQo+DQo+PiAgICAJbXV0ZXhfdW5sb2NrKCZwcm9jZXNzX2luZm8tPmxvY2spOw0K
Pj4gICAgDQo+PiAgICAJLyogTm8gbW9yZSBNTVUgbm90aWZpZXJzICovDQo+PiBAQCAtMTg4MCw2
ICsxODczLDEyIEBAIGludCBhbWRncHVfYW1ka2ZkX2dwdXZtX2ZyZWVfbWVtb3J5X29mX2dwdSgN
Cj4+ICAgIA0KPj4gICAgCXJldCA9IHVucmVzZXJ2ZV9ib19hbmRfdm1zKCZjdHgsIGZhbHNlLCBm
YWxzZSk7DQoNClRoaXMgdW5yZXNlcnZlX2JvX2FuZF92bXMgY2FsbCBjYW5ub3QgZmFpbCBiZWNh
dXNlIHRoZSB3YWl0IHBhcmFtZXRlciBpcyBmYWxzZS4gSWYgaXQgZGlkIGZhaWwsIHRoZSBlcnJv
ciBoYW5kbGluZyB3b3VsZCBiZSBicm9rZW4uIEknZCBhZGQgYSBXQVJOX09OQ0UgdG8gbWFrZSB0
aGF0IGFzc3VtcHRpb24gZXhwbGljaXQsIGFuZCBjaGFuZ2UgdGhlIHJldHVybiBhdCB0aGUgZW5k
IG9mIHRoaXMgZnVuY3Rpb24gdG8gcmV0dXJuIDAuIEJhc2ljYWxseSwgaWYgd2UgZ290IHRoaXMg
ZmFyLCB3ZSBhcmUgbm90IHR1cm5pbmcgYmFjaywgYW5kIHdlIHNob3VsZCByZXR1cm4gc3VjY2Vz
cy4NCg0KWW91IGNvdWxkIHVwZGF0ZSB0aGUgY29tbWl0IGhlYWRsaW5lIHRvIGJlIG1vcmUgZ2Vu
ZXJhbC4gU29tZXRoaW5nIGxpa2U6IA0KRml4IGVycm9yIGhhbmRsaW5nIGluIGFtZGdwdV9hbWRr
ZmRfZ3B1dm1fZnJlZV9tZW1vcnlfb2ZfZ3B1Lg0KDQpSZWdhcmRzLA0KIMKgIEZlbGl4DQoNCg0K
Pj4gICAgDQo+PiArCS8qIFVucGluIE1NSU8vRE9PUkJFTEwgQk8ncyB0aGF0IHdlcmUgcGlubmVk
IGR1cmluZyBhbGxvY2F0aW9uICovDQo+PiArCWlmIChtZW0tPmFsbG9jX2ZsYWdzICYNCj4+ICsJ
ICAgIChLRkRfSU9DX0FMTE9DX01FTV9GTEFHU19ET09SQkVMTCB8DQo+PiArCSAgICAgS0ZEX0lP
Q19BTExPQ19NRU1fRkxBR1NfTU1JT19SRU1BUCkpDQo+PiArCQlhbWRncHVfYW1ka2ZkX2dwdXZt
X3VucGluX2JvKG1lbS0+Ym8pOw0KPj4gKw0KPj4gICAgCS8qIEZyZWUgdGhlIHN5bmMgb2JqZWN0
ICovDQo+PiAgICAJYW1kZ3B1X3N5bmNfZnJlZSgmbWVtLT5zeW5jKTsNCj4+ICAgIA0K
