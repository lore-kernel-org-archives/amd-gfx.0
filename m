Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3510BC47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 22:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C49F410E0EF;
	Tue, 16 Jan 2024 22:43:19 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2ED10E0EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 22:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gua5QjpZWfJpyhrrQV06sLZFkGRplNcOj1KDQli70JiJwgawcPzpmiwzaEkT1hiJQ/8FEjev5yu6uu+GJLQ4rpuG0AulhNJ1MHfGslhlgZXw29IXSP3G1VaEDIO9nIjuQvq8sktZy95sHjuPmDgT2hqfqwrh9wYwd8axJUV04En252JMRpkz6jo9jiH7aqaX6tf11apsHGpmKNZZWDe2jjiAvQL7APVtrF3055ZaNzy+02dw76b/tNcJLr8v5j/HY6celErKHPHAidV7aMA/KAXNywCsI1TpdUJOmn4GN6246Wd44URfX+9xr6wzVY0tqCaWr/lNSq/OGzadUO6yNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqVzw0G52VeXJXBm3X07wd3LWmafbBqsOAdiucXoxbw=;
 b=UT/pn3TMjBp+35nKDvstUm5HwsKBGcp17dGBT5fO5/eUXNMQttXjbnQmCwMDvqnqLPWUA0nnInecsYt8Uw5UcvXgcZ48VSdckey84p8f4Snq3U5iAixhU4256FxZuhnoZaTY8uFN/khbarjuIWJtT6eHxCvq3TjnwL8okxvCRziGsJdrSf4AV1jAr/4qOPROQo50qPLJLqzHLnd/wAmpjpipgXQokK8n+dxeqrmcpn3jlBW/1tcQ1uaa4wZdLEj0UUzimYMlU7xiHsC/PYMb46gpcZ2c++ZI405SbMM1K5ksejUId7osuws2nbSvY8loAxbTNydayBxvLRQURWxBqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqVzw0G52VeXJXBm3X07wd3LWmafbBqsOAdiucXoxbw=;
 b=COUX8fjUEf3olGacbmeVkLDdlLZj1Tr9u/R9+Brj/zyBnskcgwzuUf5b/pn+Bh6jjBdyVnk5SIuPRaOCgNWrPjxy+/IgaC+hVdzr7Hj4TMg+geSFPEXrzCrxp8AJU8RbKHNaGOxHJOW1hmZF1uHYOVZZWC1TCPLM+BGXjpLen8k=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 22:43:14 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::1d05:912f:c481:44b]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::1d05:912f:c481:44b%7]) with mapi id 15.20.7159.020; Tue, 16 Jan 2024
 22:43:14 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Messinger, Ori" <Ori.Messinger@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5] drm/amdgpu: Enable GFXOFF for Compute on GFX11
Thread-Topic: [PATCH v5] drm/amdgpu: Enable GFXOFF for Compute on GFX11
Thread-Index: AQHaSMl/1JmL8sJRhk2AOsc/lNC857DdCRig
Date: Tue, 16 Jan 2024 22:43:14 +0000
Message-ID: <CY8PR12MB70991412F22183BBB93915498C732@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240116221447.195652-1-Ori.Messinger@amd.com>
In-Reply-To: <20240116221447.195652-1-Ori.Messinger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fdb3c311-be5c-475f-9fa1-98c646461f33;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-16T22:42:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|SA1PR12MB7365:EE_
x-ms-office365-filtering-correlation-id: 11cb1d8e-840c-4195-32c9-08dc16e48663
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nYjHuvGBK72rJGx4CtwTw38p3Yz1q+Xw6pNTbrPAJa8nfu5Fy0/Q8l2Dk5cPkx9iLdJoTjkHfKP+TuLJQvA06lWM4Fx8AIBunk+k1+FMncgHskTNeERKiaXNeuNm7nUqk2mOSDZM7gh9SiY1qRvN/lAQxSaSO39I3M0cr+QfgiAkFnpu3vv5C/hiM3vbPCIGG4VWhAykWEkULiwgIqojiDDRQ61s9Q6ovXkruOvwrnjXdDRnlLdQqcFFfMHUfCcupOqrDKHwxhvfU//TiMlPjTWd07Q09Qo2nRiHKMM+lu150JKgYV3EaV+YIVYI0RGU44+7uaUH+m0MWQSsNIJkC+XYKoFYTP/DTaGOofeMT0sQAfDsQzWjwSsUiGcpyfds6gKCPCmyU2sC05WFnHR9hDcrqowCZEfQ1sWPcKw3GLh0rnHlJytmMojl/a8UURzgtdBkCnVr1ttvyQKYnwt0AHFwdRZbVVUkq/1Kh5PIPntg/w1IReOIFYc70UTyvVLSyjJa0RD11JQ1wG4NVYlnmrRFyQUcYkuiLCnx0UdQKMdWy2bueQ61ltju/f15/3twUNOO3/wV/DpERCP5bKulYBEXEyfCK4cfXgA650zAynJGFfrmDwSZartY41EKkO/lSpPR/Eig14kV/1je7zxc0cknsRxqM3GfYvJ6Ut4jHOo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(64100799003)(186009)(9686003)(26005)(83380400001)(122000001)(4326008)(38100700002)(8676002)(6506007)(8936002)(52536014)(478600001)(64756008)(54906003)(316002)(71200400001)(66446008)(7696005)(66476007)(53546011)(2906002)(5660300002)(76116006)(66946007)(66556008)(110136005)(86362001)(41300700001)(33656002)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWx6eER0eWtGYTdZWmlzbFd6REREa3U4QzF1djR0WGpNMncxY2RHd25tNTlQ?=
 =?utf-8?B?bExoTXJNVFpDNkJ3cndyRVBUb21sNUlqL1lpNU9VUDQ5YzRHYmNDd1BJMkda?=
 =?utf-8?B?c1l1U0U4STgvV2RBWndpd0dwZXFESllOa1F4YkEvMTRaWkpITlZBdU1uZENl?=
 =?utf-8?B?RlJ3YzRKWVZRS21CN2xCa2picE9yY1Qwb2pzL0Z3eU5teThVQUIyN1lFU1lZ?=
 =?utf-8?B?eVVmYm1iSnlldGJQcUhjcldISGN0ZHJ4b3Z4enFvc3RrS0RMYk9kVlhFRTZx?=
 =?utf-8?B?MVNxZFRkc1Y3VTZoTm9xVHpFMUtTNFhsRElIWVJXYzUySG54MnIxWCtpOXFW?=
 =?utf-8?B?ZGppS2swQkp4RVoxSnRKY2thaVNyT0YvR1dIYnJoaWpyU0tyVExLYU5rTU1q?=
 =?utf-8?B?L1YxaXBnU2xvanY4VWx3dHJ2NFVRQzk1U0lLczMrQkpsMFRkUCtqSzdoWHJj?=
 =?utf-8?B?bDE2dUNQMEZBOGpuNEdReTc0b24vZForcVBKN2RDdkRLM2dDK3pzWFVTYVVU?=
 =?utf-8?B?cjZmMjB0UmJqUWtWQzVKRGNUWEdacFNsanM3bDdtbHF1S3hPdTZRZWM1ZlMv?=
 =?utf-8?B?anQvajM4YXM3MXJSNHgzblh4VEZVbWt6UUVjOE9xaWI0NkhyWnRMYnpIdE1j?=
 =?utf-8?B?VXU5eENZc1pwUG9INCtkblk2ajBzL3NMRmVva2xjbStKa1lxY2pCY3hseHNJ?=
 =?utf-8?B?SitnK1RnaUlkOWg1UFY0OGtqZXJGL0JLaWU4YUtJWEo4eTVZMnBBTjRHc1h3?=
 =?utf-8?B?MDB4QWgxRlpkOGIwTUhncFR6TTJiWVpKY2NDUWRHRGxPZjJ4aGZVdnRoQjNu?=
 =?utf-8?B?bitkcWFkdzlEcHZXbDJEMVQ2RWpMZm40Wll3ZnNqWjJqZk1hd0xaaTVRU1h1?=
 =?utf-8?B?MXpzWEtjaWZCWkVjV3MxWElvQllIM3UrSTRSMGR3dFFvQzhzQ3FUR2VRWTVC?=
 =?utf-8?B?dTg0UFo1UU1JNkNzUk5OdS9xcUNNcHJqSHJyN2ZKaDJBM3FpMWx4VlJXWDV0?=
 =?utf-8?B?TElZZWVZeHN0OGlDcDhZbXM0UURNTjVBZ2lycFNMMzBFcTIwdk9RZjlCaHhC?=
 =?utf-8?B?ZmY0TkNSZDFhdXJPamJUQ20zTUxjcFgzNTcwdnRhV3hRVmpMT1dtVk4zcjNv?=
 =?utf-8?B?azd0elZwZm5Gc2UweWgzVGhtM09Oeml5M3FQeWYvblVyNGo0UksrNnROdDBz?=
 =?utf-8?B?M2hZQmxEWFo5bHhreGRoZlhjb21qMzJra2ZwR2liK2Z5MWJlOVg1WmsvdE9N?=
 =?utf-8?B?bnpaWkhMV0FqSXhtaE83Y2EveFVwVXZKdFVjU1lDNmxIRXVnOHk3LytTL3Mv?=
 =?utf-8?B?aTIxYUZFaitSU2FEbThwd1lrMzF6M25IM0Z5SHUrM0hKQ3gwSWtuSkFjTFA2?=
 =?utf-8?B?RXp4bDZnc2x1SmxOQzVZUDhPS3JYSXN2UW14SXRJMlFaUnk4NXB0eWkvMXRH?=
 =?utf-8?B?S2djd2hDazFTNmNMdlVhbDN1RU40em9ENkYreFpyL245Snk4aWVtNll0ME0z?=
 =?utf-8?B?c1RiRFhsVnVIbzZqcUl5ck1ZMm5VbG1kOFhuRkxDZHVWMU5mVHh1cksrQURN?=
 =?utf-8?B?emltV0k1c1hBbSsxRkNiRHlIK05Sek5VOGpNYzN4dGxDMU56aDE3VXdaME00?=
 =?utf-8?B?b0toVGxyR2g1WG9UWHoyK1pxcHBZY1U1NmR5T1dVdUd5YVNoM2VzNkZHRWtM?=
 =?utf-8?B?RFZCeGdZUG1mZ2oxOXVOMDN6aGR5S3RuOXhpL1Y4azJiMC9IdGM1OGRtNnRJ?=
 =?utf-8?B?V3grcEVVNXcxd3kvTXp5Y014M3d5eVgvMTBGNDZVU0cwYnZmUlBTMjMxTjZF?=
 =?utf-8?B?NTl0RXNkR05YNllpMEdwaWVaMGZHQnFyYXg3SUpuTENJME9FK1RnOUJ4bjBu?=
 =?utf-8?B?eDZ4dHo5MnpJc2F4S0tKanlyVjRkdEdEL0JISjdYMUNRR2dEeEoybWRBaG4z?=
 =?utf-8?B?bnpCRnJKTDVreG1EUmwwSmVjVWgydWdVRDVjam9oUFNKNjBqQjB4dlFkcG5J?=
 =?utf-8?B?aFFxZmFoSVREZXU2V25NSmNXUm9NM1ZtUDkwdytyOGdqK2JCSDV4TlU0NFMr?=
 =?utf-8?B?NG04Uy9YUnNyb01ERVlmeGdoTHlrNHgxMzlvR1NFU0FhUGh6OU1JNUpqYTJS?=
 =?utf-8?Q?McwI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cb1d8e-840c-4195-32c9-08dc16e48663
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 22:43:14.2255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DcZPZpJLGPHHux+tbz5tzAjcek0dUWDspXbTffBaNpUxHIDLPDP+EXS17/S8pNwU4OpQUiicEjV1Bmx9QjRlEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Messinger,
 Ori" <Ori.Messinger@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBIYXJpc2gg
S2FzaXZpc3dhbmF0aGFuIDxIYXJpc2guS2FzaXZpc3dhbmF0aGFuQGFtZC5jb20+DQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgT3JpIE1lc3Npbmdlcg0KU2VudDogVHVl
c2RheSwgSmFudWFyeSAxNiwgMjAyNCA1OjE1IFBNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBNZXNzaW5nZXIsIE9yaSA8T3JpLk1lc3NpbmdlckBhbWQuY29tPg0KU3ViamVjdDogW1BB
VENIIHY1XSBkcm0vYW1kZ3B1OiBFbmFibGUgR0ZYT0ZGIGZvciBDb21wdXRlIG9uIEdGWDExDQoN
Ck9uIEdGWCB2ZXJzaW9uIDExLCBHRlhPRkYgd2FzIGRpc2FibGVkIGR1ZSB0byBhIE1FUyBLSVEg
ZmlybXdhcmUNCmlzc3VlLCB3aGljaCBoYXMgc2luY2UgYmVlbiBmaXhlZCBhZnRlciB2ZXJzaW9u
IDY0Lg0KVGhpcyBwYXRjaCBvbmx5IHJlLWVuYWJsZXMgR0ZYT0ZGIGZvciBHRlggdmVyc2lvbiAx
MSBpZiB0aGUgR1BVJ3MNCk1FUyBLSVEgZmlybXdhcmUgdmVyc2lvbiBpcyBuZXdlciB0aGFuIHZl
cnNpb24gNjQuDQoNClYyOiBLZWVwIEdGWE9GRiBkaXNhYmxlZCBvbiBHRlgxMSBpZiBNRVMgS0lR
IGlzIGJlbG93IHZlcnNpb24gNjQuDQpWMzogQWRkIHBhcmVudGhlc2VzIHRvIGF2b2lkIEdDQyB3
YXJuaW5nIGZvciBwYXJlbnRoZXNlczoNCiJzdWdnZXN0IHBhcmVudGhlc2VzIGFyb3VuZCBjb21w
YXJpc29uIGluIG9wZXJhbmQgb2Yg4oCYJuKAmSINClY0OiBSZW1vdmUgIlYzIiBmcm9tIGNvbW1p
dCB0aXRsZQ0KVjU6IENoYW5nZSBjb21taXQgZGVzY3JpcHRpb24gYW5kIGluc2VydCAnQWNrZWQt
YnknDQoNClNpZ25lZC1vZmYtYnk6IE9yaSBNZXNzaW5nZXIgPE9yaS5NZXNzaW5nZXJAYW1kLmNv
bT4NCkFja2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQot
LS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgfCA2ICsrLS0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMNCmluZGV4IDgxYWY2YmYy
ZjA1Mi4uNzdlMjYzNjYwMjg4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkLmMNCkBAIC02OTgsMTAgKzY5OCw4IEBAIGludCBhbWRncHVfYW1ka2ZkX3N1Ym1p
dF9pYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCiB2b2lkIGFtZGdwdV9hbWRrZmRfc2V0
X2NvbXB1dGVfaWRsZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBpZGxlKQ0KIHsN
CiAgICAgICAgZW51bSBhbWRfcG93ZXJnYXRpbmdfc3RhdGUgc3RhdGUgPSBpZGxlID8gQU1EX1BH
X1NUQVRFX0dBVEUgOiBBTURfUEdfU1RBVEVfVU5HQVRFOw0KLSAgICAgICAvKiBUZW1wb3Jhcnkg
d29ya2Fyb3VuZCB0byBmaXggaXNzdWVzIG9ic2VydmVkIGluIHNvbWUNCi0gICAgICAgICogY29t
cHV0ZSBhcHBsaWNhdGlvbnMgd2hlbiBHRlhPRkYgaXMgZW5hYmxlZCBvbiBHRlgxMS4NCi0gICAg
ICAgICovDQotICAgICAgIGlmIChJUF9WRVJTSU9OX01BSihhbWRncHVfaXBfdmVyc2lvbihhZGV2
LCBHQ19IV0lQLCAwKSkgPT0gMTEpIHsNCisgICAgICAgaWYgKElQX1ZFUlNJT05fTUFKKGFtZGdw
dV9pcF92ZXJzaW9uKGFkZXYsIEdDX0hXSVAsIDApKSA9PSAxMSAmJg0KKyAgICAgICAgICAgKChh
ZGV2LT5tZXMua2lxX3ZlcnNpb24gJiBBTURHUFVfTUVTX1ZFUlNJT05fTUFTSykgPD0gNjQpKSB7
DQogICAgICAgICAgICAgICAgcHJfZGVidWcoIkdGWE9GRiBpcyAlc1xuIiwgaWRsZSA/ICJlbmFi
bGVkIiA6ICJkaXNhYmxlZCIpOw0KICAgICAgICAgICAgICAgIGFtZGdwdV9nZnhfb2ZmX2N0cmwo
YWRldiwgaWRsZSk7DQogICAgICAgIH0gZWxzZSBpZiAoKElQX1ZFUlNJT05fTUFKKGFtZGdwdV9p
cF92ZXJzaW9uKGFkZXYsIEdDX0hXSVAsIDApKSA9PSA5KSAmJg0KLS0NCjIuMjUuMQ0KDQo=
