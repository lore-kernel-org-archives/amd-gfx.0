Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED21C25B0E
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Aug 2022 02:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1662D10E1DB;
	Wed, 17 Aug 2022 02:54:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ABDB10E10A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Aug 2022 02:54:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqhO9Fcx0T1NtghsCglZLvkDhWl73hvnn4CGivnXrHMu2eaOsMe9VAAUOs+G8JdohzzUdjd9SD0dm/sje94uddMXk6tBEcawgEFs3y0ALXwacKpeNS7gLF5FRCRIruL8BMkDGxmM6bzHZCyIiLcyGdwscgCuJ6gM5M0PayVOFPxfh9UN7VQcwBmixpfuTWrjAbXRiy1PnOn69StmuMRuQzEUPyjOZexFnnCbmwxB/Yz23RZ4X4YwO+sKBSaBZnyD8xQY+mo4+meDY6/FJQPXWDWucS613VDcI6P1C5331OqQl8vOnKOdP0IfgGyadfujd4XKlZ8uPinMzvVnbKqpAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Thls+JiE8ixkPlZyt+DvPqMD9jDafLBdsYSndFdymAY=;
 b=EicLmLL+HCKX0Wmzni9zNJpMqWWns4pxF5F++0aH/1VfeRzMha/SHqxdT2GSGYV8/aiqUYSpgbNzBi8LAVzXlcoBkE4OY6IS9iaB27kL2dlx0GgUxHx/SUxlAMba1+ni8CdOHDQjD4I1zn15JRX6ED83jxVtfFu/QRuS3HHpBg6djzS/Lfq7ceZ36OEGXMJlwyqhkO80A83AKJ/GQfZ3e9472jMcKAqTBdBMRDC9xP1SPh6yDGxfr+nXSTiISj35+k71REqEfqbfhlt43bJlvOWq42CpxM/9fvmx8MHv2KRN0vI25ymU4PWlTimVTIVtpLxsrFVWOQEGD5Lcm06eNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Thls+JiE8ixkPlZyt+DvPqMD9jDafLBdsYSndFdymAY=;
 b=N8cGr2y40LwJDAxRT1kJKFDNisQjZSxxDkWOFP8Jp6GIX9myICXTNDlySCkrPkwCp8lnK+Z0OOqNyh4tgtlv1pF77tx02uqg3RLoaxA2WhXDE3W/89pOOgQjN5GnGfYzkzneMfsdIDIPR36LBrP//Q2nsrjD3oxbqQcfbWPcQCs=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by BN8PR12MB3250.namprd12.prod.outlook.com (2603:10b6:408:99::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Wed, 17 Aug
 2022 02:54:31 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::c85:7688:fe17:4256]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::c85:7688:fe17:4256%5]) with mapi id 15.20.5504.028; Wed, 17 Aug 2022
 02:54:31 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: TA unload messages are not actually sent to
 psp when amdgpu is uninstalled
Thread-Topic: [PATCH] drm/amdgpu: TA unload messages are not actually sent to
 psp when amdgpu is uninstalled
Thread-Index: AQHYsHVxdqnWEgZXO0eE42ktnSUoDq2wA7iAgAJjemA=
Date: Wed, 17 Aug 2022 02:54:31 +0000
Message-ID: <CH2PR12MB42155B12C1A2C1D7101EAA2EFC6A9@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220815070512.452430-1-YiPeng.Chai@amd.com>
 <CADnq5_NLzjD+4q0vF8n8JRaOf3iiGYoNN+W9K3FPLEP+_FHjUg@mail.gmail.com>
In-Reply-To: <CADnq5_NLzjD+4q0vF8n8JRaOf3iiGYoNN+W9K3FPLEP+_FHjUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-17T02:54:27Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=766c8849-0d49-44dd-9ec2-72f16c2e2f79;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-08-17T02:54:27Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f6ef7eac-fd63-44bc-9a38-14dcd31d5b11
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7a8ae00-5a32-4639-9a17-08da7ffbceed
x-ms-traffictypediagnostic: BN8PR12MB3250:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3r9VXDHPid/i0D2QXRo9kHXFVyZZmA8t76HeIr8CmJypSWT6mdHKyktXTQStATdt+TFXgVJXUq3L/3m/COz4YZILJvzAbcAQkpoKrzS6TrXuTuyQJQj7B/U5iraigpA+4uiOX9uiowpUbjlwtpS6lbw8xeL6Z+NweRPV6h6/MDSXgrG31BcdwhsniGCxInMw2tcuF26Qb8IgPvV/xmk1jSwhpnmf9lBEVrPJZ8eReKrl1Zo4Ysbxdt/nwliaAUcoU/snUXkbteF9h+unvyyKoEMc66bxwIw3I6hKpsJ8T1VdJlKZ6KA4rR8FYc1RVDA3cibwVN5AAEp/n6A03zNmiF4I+Z0keFkk6+jIw/Onzzge1NP76R5NL7QkYNT9br6L3auoQErkRIR42tJw935Pa4Ee/q+vn1ZsxZ+A3wp65zCEbFlL6Hs2aHtz6vUt+L7nF4of+Jm/ixnwVz29SZ9+XMn866Ji2uJkkawf3My1kN2usShKMmtgR3S+HS9wH4laJe+25NLnH0K8qor0GROLtGhc5lYuoa3+oGMvOR/ExOIjwPV5KyqOzKAjCqwJCmFQI7kvNfpwpDNBLIhYHv7g6pECmWE7qUWyB5kjEYD42ZAUOE3shE2h339HObct2QjGNiv3qDVjw3sUlOHczaX7qUA99yrWdRCU0UIS7WSIC9sM8F+FVyC5tbNNkiQ2T1PL4tBh9et1Ud6q5tIl4Wft09OKliIZHnnBoDfu0NWYUv+LXS203QhRUpvxq1W7nUPKDoeZCJBw3bLia32Udh5KscWSyI2hT2M/Ii/iGuorQRELdAEC1nHTqjHUS5sA4ItK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(15650500001)(122000001)(86362001)(71200400001)(55016003)(186003)(316002)(41300700001)(38100700002)(66946007)(8676002)(4326008)(64756008)(66446008)(2906002)(66556008)(66476007)(76116006)(53546011)(478600001)(38070700005)(9686003)(5660300002)(33656002)(54906003)(6916009)(26005)(6506007)(7696005)(83380400001)(8936002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3VUL0lkT1ZsanpNSmV2TjZ0S2haZmQvRVJoMlpwMThhY2kyWkRNMkN5UU5N?=
 =?utf-8?B?QU1WYmxnTWlDS0U2MGRTcDhOREwrY3duL1lTSUVJYVE0RTJ1L0ZMWGlVN0JY?=
 =?utf-8?B?eW9KQ1ErSnlUUzkvMlUzbHFEZHBreENxZ3VNaEd1cldKeGFVTVkzdFgrQlRY?=
 =?utf-8?B?aVZUTVAzM0d2WllYOThWNXBseDVDcndZQlJxUW5CSnkrek5tbThZOTNsTWlQ?=
 =?utf-8?B?ZTVGMjhwMnJ0V2R2cDc0ZmxxUm5wWHlzYllnR3JIRkE2alZIdE13RzMvY1k2?=
 =?utf-8?B?TGVQazF5bGhQMHJkYUNFY3B2OEpuSE9MWlZiQndkS0FuS3ZRWWE2dFRUSkkv?=
 =?utf-8?B?emhlMlpqNjR6enc0bTZseG9qOTFzcVRrcUFycVBTb3hZdmwzeGU1Tjh5amFo?=
 =?utf-8?B?TkpJUitaeHBXV0s4NEN4b1gvRGJxMk1QQmtxSDJZc1lzNmZ4L1dselhxaG1l?=
 =?utf-8?B?aC9NbzFOaHNpRWs1LzRFandyWGxleWdmVjlBZ3RnYXdUaVJ0NC82TEt4eFlw?=
 =?utf-8?B?Z1ozbGY2dFdCZmZoRWRzekVpeGUyUEowZWVtMVpIUWpLSWNERVhCZXpUTFFP?=
 =?utf-8?B?OWhNQUh6a2h3bVd1NDF2RkNQYVNTYXlrNS9tRlRoU1JuemV5bWNCOXNibTBY?=
 =?utf-8?B?cm5hVVBNblFxVmZ0RFBOYkx0OWhRS2tnaTQxSm1rRHJxOUJ6akVOZ2UvZFE3?=
 =?utf-8?B?eWtHY2ptN3ZTOU0wWGtUMm1ScFMyZWhWM1lvR0o5dWlRRytSck9rZXp4eGJU?=
 =?utf-8?B?cUxNa3ROYzgzc3VCZStGSC96ZXlhL28xL1lNTW5ZSStEVTRtSWVyQ3drUExl?=
 =?utf-8?B?QjFTeDZXVW1ZU0RnODR5WEp4WXo3dStyazlveDBMeDJDZ2RKUzA0ZlA3cUJF?=
 =?utf-8?B?V3F6eVNmc0ZOTVRiNkhMTUxkd2dsNlllNllLOGtQYjBic1ZFcWVQMHpqVHZn?=
 =?utf-8?B?K09DWjdZaERST1d4VnQwRFZJbUFFRG9xckJ2aHl3SXVwMUF6K3RHdzQyNlhP?=
 =?utf-8?B?R0RwSklDZ0J1ZjJHVVRST2V5eDByYnEzQWc0bytoYU45VnI2THQraXR4RVVS?=
 =?utf-8?B?bi95bVRNNm0vWTgyTDJuWmZCSkxxRFZCS05oM3ZWOW1ibnlud3RaTy9XNEpC?=
 =?utf-8?B?Ui9ZOUFlUHE1VFNsdEZrcUxkMEhCU2g1VlhBY01HcDI5cHZyYXhrc3VKM2dt?=
 =?utf-8?B?M2Q1cEMzN2Rrc0E0d1FZb3ljdnRnRU9PdE5rNkZrNVVuV001Z21kMC9RaXc3?=
 =?utf-8?B?QUc1enRvbVYwcE1ZZjFXNkVSeXc1UHJ0eS8xZ09JSWdlNUFqOC85QTQ0cGRI?=
 =?utf-8?B?UXQvRTJBUDJaNWJBUC9LaUFFSUtlS2ZDY1ByaUhOYUJiSmRJNE1iVGMvd0xR?=
 =?utf-8?B?cXp1UGpBSUFieW5ISy9jWmNCb0hUL2VVUEJJdjg0cGVLeldTOGMyTGYxVnlk?=
 =?utf-8?B?NXNwVWlOaUNMV3RCbklvUC9nVW5KSXN5UEZxbWM0OGhtMnh1WnIzOUN6bmk1?=
 =?utf-8?B?dHJzY2QwdGlxRStOYWZPZFF4cXE0NkJkWFR1L2NSZ2ZQS3lzRHBrSGMrcGpP?=
 =?utf-8?B?Ym03MjNtNFR1ZWRiVXJiYzViYXRHUnRZcHhXeVMyQTQrallVZ1NvQTFHYlVG?=
 =?utf-8?B?RXdrWDFwazhpZFFva2JCSVV2TTFXaGczUkhSeGU3WnZZOHk1MGNkUXIrck5P?=
 =?utf-8?B?WlYzNHV2WmFXd2NTcGJ6NGdCeVVwL3gvb2JWN09TQVNPdzVCaUdrYjdML2E0?=
 =?utf-8?B?TVhEQlJWSllNTjlZWEl1dGNBSDcvcU92UjZBUVh0ZElKM3p6LzlPL0ZVanZL?=
 =?utf-8?B?U3QzamxDU3M1K2FQQ3M5YVJyMGpoZHlNMTg3NTdzNFVVQnk1Vkt2YVM3OUx1?=
 =?utf-8?B?dFI3Qldha2VUTmdlRCtvcTFpZlFIcmxHNWtibmZma3RzYkhzZHEvK2RWdFd1?=
 =?utf-8?B?bHgzQ3dOL0JDcXRkYWhBdTdpMEE3eWdoeWovOEUrd0xJT1VKWHNja3FIaUdB?=
 =?utf-8?B?ckdmMU9JK0hVN05XY09TN1VlZ09qbndZRURCRkVsaUhpYkhKa3VJZ1htMTJp?=
 =?utf-8?B?bk1ZdTJyWmRvVmE5OEZSZlp4WTNaamZZYytyWGd5U2l6bXhYUWJIcFBmelBB?=
 =?utf-8?Q?sobUjXIayamgHHaQ+wOJ+tgMj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a8ae00-5a32-4639-9a17-08da7ffbceed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 02:54:31.1230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VIUd8v8kSLLjvMqi3PAX6iurcbuDMo2ZXEf2Qv3v8iWOq3F0m/NM3pM6Jw2MD6WPUsszZsetRvtfrZ3LWb+hMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3250
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFsZXg6DQogIFdoZW4gcmVt
b3ZpbmcgYW4gYW1kZ3B1IGRldmljZSwgaXQgbWF5IGJlIGRpZmZpY3VsdCB0byBjaGFuZ2UgdGhl
IG9yZGVyIG9mIHBzcF9od19maW5pIGNhbGxzLg0KDQoxLiBUaGUgZHJtX2Rldl91bnBsdWcgY2Fs
bCBpcyBhdCB0aGUgYmVnaW5uaW5nIGluIHRoZSBhbWRncHVfcGNpX3JlbW92ZSBmdW5jdGlvbiwg
IHdoaWNoIG1ha2VzIHRoZSBncHUgZGV2aWNlIGluYWNjZXNzaWJsZSBmb3IgdXNlcnNwYWNlIG9w
ZXJhdGlvbnMuICBJZiB0aGUgY2FsbCB0byBwc3BfaHdfZmluaSB3YXMgbW92ZWQgYmVmb3JlIGRy
bV9kZXZfdW5wbHVnLCAgdXNlcnNwYWNlIGNvdWxkIGFjY2VzcyB0aGUgZ3B1IGRldmljZSBidXQg
dGhlIHBzcCBtaWdodCBiZSByZW1vdmluZy4gSXQgaGFzIHVua25vd24gaXNzdWVzLg0KDQoyLiBw
c3BfaHdfZmluaSBpcyBjYWxsZWQgYnkgdGhlIC5od19maW5pIGl0ZXJhdG9yIGluIGFtZGdwdV9k
ZXZpY2VfaXBfZmluaV9lYXJseSwgcmVmZXJyaW5nIHRvIHRoZSBjb2RlIHN0YXJ0aW5nIGZyb20g
YW1kZ3B1X3BjaV9yZW1vdmUgdG8gLmh3X2ZpbmkgaXMgY2FsbGVkLA0KICAgdGhlcmUgYXJlIG1h
bnkgcHJlcGFyYXRvcnkgb3BlcmF0aW9ucyBiZWZvcmUgY2FsbGluZyAuaHdfZmluaSwgIHdoaWNo
IG1ha2VzIGl0IHZlcnkgZGlmZmljdWx0IHRvIGNoYW5nZSB0aGUgb3JkZXIgb2YgcHNwX2h3X2Zp
bmkgb3IgYWxsIGJsb2NrIC5od19maW5pLg0KICAgDQogICBTbyBjYW4gd2UgZG8gYSB3b3JrYXJv
dW5kIGluIHBzcF9jbWRfc3VibWl0X2J1ZiB3aGVuIHJlbW92aW5nIGFtZGdwdSBkZXZpY2U/DQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVj
aGVyQGdtYWlsLmNvbT4gDQpTZW50OiBNb25kYXksIEF1Z3VzdCAxNSwgMjAyMiAxMDoyMiBQTQ0K
VG86IENoYWksIFRob21hcyA8WWlQZW5nLkNoYWlAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZzsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47
IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT47IENoYWksIFRob21hcyA8WWlQZW5n
LkNoYWlAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IFRBIHVubG9h
ZCBtZXNzYWdlcyBhcmUgbm90IGFjdHVhbGx5IHNlbnQgdG8gcHNwIHdoZW4gYW1kZ3B1IGlzIHVu
aW5zdGFsbGVkDQoNCk9uIE1vbiwgQXVnIDE1LCAyMDIyIGF0IDM6MDYgQU0gWWlQZW5nIENoYWkg
PFlpUGVuZy5DaGFpQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBUaGUgcHNwX2NtZF9zdWJtaXRfYnVm
IGZ1bmN0aW9uIGlzIGNhbGxlZCBieSBwc3BfaHdfZmluaSB0byBzZW5kIFRBIA0KPiB1bmxvYWQg
bWVzc2FnZXMgdG8gcHNwIHRvIHRlcm1pbmF0ZSByYXMsIGFzZCBhbmQgdG1yLg0KPiBCdXQgd2hl
biBhbWRncHUgaXMgdW5pbnN0YWxsZWQsIGRybV9kZXZfdW5wbHVnIGlzIGNhbGxlZCBlYXJsaWVy
IHRoYW4gDQo+IHBzcF9od19maW5pIGluIGFtZGdwdV9wY2lfcmVtb3ZlLCB0aGUgY2FsbGluZyBv
cmRlciBhcyBmb2xsb3dzOg0KPiBzdGF0aWMgdm9pZCBhbWRncHVfcGNpX3JlbW92ZShzdHJ1Y3Qg
cGNpX2RldiAqcGRldikgew0KPiAgICAgICAgIGRybV9kZXZfdW5wbHVnDQo+ICAgICAgICAgLi4u
Li4uDQo+ICAgICAgICAgYW1kZ3B1X2RyaXZlcl91bmxvYWRfa21zLT5hbWRncHVfZGV2aWNlX2Zp
bmlfaHctPi4uLg0KPiAgICAgICAgICAgICAgICAgLT4uaHdfZmluaS0+cHNwX2h3X2ZpbmktPi4u
Lg0KPiAgICAgICAgICAgICAgICAgLT5wc3BfdGFfdW5sb2FkLT5wc3BfY21kX3N1Ym1pdF9idWYN
Cj4gICAgICAgICAuLi4uLi4NCj4gfQ0KPiBUaGUgcHJvZ3JhbSB3aWxsIHJldHVybiB3aGVuIGNh
bGxpbmcgZHJtX2Rldl9lbnRlciBpbiANCj4gcHNwX2NtZF9zdWJtaXRfYnVmLg0KPg0KPiBTbyB0
aGUgY2FsbCB0byBkcm1fZGV2X2VudGVyIGluIHBzcF9jbWRfc3VibWl0X2J1ZiBzaG91bGQgYmUg
cmVtb3ZlZCwgDQo+IHNvIHRoYXQgdGhlIFRBIHVubG9hZCBtZXNzYWdlcyBjYW4gYmUgc2VudCB0
byB0aGUgcHNwIHdoZW4gYW1kZ3B1IGlzIA0KPiB1bmluc3RhbGxlZC4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogWWlQZW5nIENoYWkgPFlpUGVuZy5DaGFpQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgNCAtLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgNCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcHNwLmMNCj4gaW5kZXggYjA2N2NlNDVkMjI2Li4wNTc4ZDhkMDk0YTcgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4gQEAgLTU4NSw5ICs1ODUs
NiBAQCBwc3BfY21kX3N1Ym1pdF9idWYoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsDQo+ICAgICAg
ICAgaWYgKHBzcC0+YWRldi0+bm9faHdfYWNjZXNzKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJu
IDA7DQo+DQo+IC0gICAgICAgaWYgKCFkcm1fZGV2X2VudGVyKGFkZXZfdG9fZHJtKHBzcC0+YWRl
diksICZpZHgpKQ0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+IC0NCg0KVGhpcyBjaGVj
ayBpcyB0byBwcmV2ZW50IHRoZSBoYXJkd2FyZSBmcm9tIGJlaW5nIGFjY2Vzc2VkIGlmIHRoZSBj
YXJkIGlzIHJlbW92ZWQuICBJIHRoaW5rIHdlIG5lZWQgdG8gZml4IHRoZSBvcmRlcmluZyBlbHNl
d2hlcmUuDQoNCkFsZXgNCg0KPiAgICAgICAgIG1lbXNldChwc3AtPmNtZF9idWZfbWVtLCAwLCBQ
U1BfQ01EX0JVRkZFUl9TSVpFKTsNCj4NCj4gICAgICAgICBtZW1jcHkocHNwLT5jbWRfYnVmX21l
bSwgY21kLCBzaXplb2Yoc3RydWN0IA0KPiBwc3BfZ2Z4X2NtZF9yZXNwKSk7IEBAIC02NTEsNyAr
NjQ4LDYgQEAgcHNwX2NtZF9zdWJtaXRfYnVmKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwLA0KPiAg
ICAgICAgIH0NCj4NCj4gIGV4aXQ6DQo+IC0gICAgICAgZHJtX2Rldl9leGl0KGlkeCk7DQo+ICAg
ICAgICAgcmV0dXJuIHJldDsNCj4gIH0NCj4NCj4gLS0NCj4gMi4yNS4xDQo+DQo=
