Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A015C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 01:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C36C3113DDF;
	Fri,  8 Jul 2022 01:08:46 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B13A113DDF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 01:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDkrx6QclvHM5By1UI39V1Ns0sr6N6PVpeebCI/gEv3jxdd0ocA3dXhqVOUmIUFrihXUlbuHVAOoptyNfOsHPyjKcQMZyxVCVY1VWVBiHivCLaL80oFD5Vx/jARz1hmvkOzC5KNRQ/sZ+7ouedMc4KkCjbGE23ReyS9D3HxPCE0gRrPzRug683EcatcZs/r+qwmPvCS/GS5vqOUX3DuHoUk4NQBGWgD5r3k4pYC0RJW2ikI59CXsF6baCNlMkn8v7V+q8PXZSulrfL79xlDNg36R23czs24JHSnTYORXdP7sC6ldBOZm3hB2yu8BgO7nJ5ICbYLKL957M/FSWLI2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voVBt3jmLsTPbLd+CKAToEYtF3JxwjI2QjmqmQ/WgI0=;
 b=kS7msXZmr1U+HaATgu+eS6iT38NWvQNX0WYkWO1+2Jd4nWE/+W7uBrSAPvOqclIjuVE7HSNNse4cbSTMa2tGGagrPTJNkAC3ZgxWOGad7hxW3cocoqI95PmK3GVoy3NpoA2MlTq7EdPmfkm6h929GnUX/GkhvdYP7JkwCpswFZqhVmW6Xza/m1uqBF9hUHwfSWXqSVnF8rIZCmZy7jbfQduWPI0GLdbE+4uArEkFqLgq6faWC+1/zeWQhA8pZK3KTyzDtCBS0c02Yfya2jlo7kyoIvGsQAQMpywAxvmdvhcz5Kwh9MjNDk2olgNCTPGwrZcq99O5GO2fNGywXA5Nrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voVBt3jmLsTPbLd+CKAToEYtF3JxwjI2QjmqmQ/WgI0=;
 b=dcvOUXvH7XoZrSbXBlnMZD/ERCf698gHl4HstIyHnopvmyyHfS8yeEJVpIWMcmyiYYsMgS145aHiJSkHhVG8dJTSj1Jg7gHI/RgH4KJPpCtyWGkQi3aQ2la+Cfdv8Rr9c0JMXL/7fHR5pxF6fMEjvfWyTbZV52zo+s7FVpFO9JY=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 BN8PR12MB4979.namprd12.prod.outlook.com (2603:10b6:408:75::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.21; Fri, 8 Jul 2022 01:08:39 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::d5e:faee:862d:6a8]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::d5e:faee:862d:6a8%3]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 01:08:39 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix a NULL pointer of fence
Thread-Topic: [PATCH] drm/amdgpu: Fix a NULL pointer of fence
Thread-Index: AQHYkecaKl79k+okoEKY/+BJtwqupa1yqzeAgABirACAAI06oA==
Date: Fri, 8 Jul 2022 01:08:39 +0000
Message-ID: <DM4PR12MB5165724D36AB92CF9D40728487829@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20220707095053.6755-1-xinhui.pan@amd.com>
 <92f468dc-2fad-5135-4aeb-c8ce2a680c69@gmail.com>
 <4b60ece6-afa5-62ca-afa6-bb800cdba982@amd.com>
In-Reply-To: <4b60ece6-afa5-62ca-afa6-bb800cdba982@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8d51f88b-394e-489b-bd1c-189bb393182c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-08T00:12:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a60ff10-966d-4f13-1eaa-08da607e6470
x-ms-traffictypediagnostic: BN8PR12MB4979:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DwDAu2oES2owMnvAjpryjn0hVS6zO2QH5OckNX/XQD1l/gBvOUdw9VRkley4Hczc4xT2iRc0xBhQ3O6iLnG2kgVjkCowTG/IbfXPuWedhoJmVzQe5SfORk5u6IvgGFCy5n5UORn3WTf0s/MKFtZaWP4Dfusv7n++FG5CiRYNmNAKhkFuPGZdN6KU0Wcy+Oz+mUDw2UzrqWvCDfOsAv63znsfdsWAEM4DOyYwLY5+OGhpxX7YDBdWXS9S8SCPC8FZNeUNuEOD5PzUX+xLAj4g0QVigUQJwVsqLls++hkewX5v8xrlw6O9hYIM3B9ZIlBDaMcWi0/3R3+1DQwEtrKRjWyc34iirPbWBLxxthNo67lI6sDTEN/Cdt80m1FsQObS9En+LVAPqiPe1VdKWgNK0QIwdKPHisZdM2/++6dZ5h7iOOm7v6QCopiF5CvSXB92FH7zItnMqejHxXVB77sY2iVAAaFQ4sXYVi/YBSFuzgMDM96R1n9X3XbozfYpoYYd6xKf/MwNjAm1TruqPMFN7cgBPcIgXxNcQ1Jjnh4Y1PGhKOEYxYRXwHbhMt1O57QN+HJhj7HPprtK1jijYmY1OzN9dEs4+Uj7sVdvpqca9Rig5u3jMf0O7iZrXAccp9oPGDpgx+MjfMVPLmPyOLIQVdWoMWkVGH1X6nncFfdZOCDnfS5bsIMRkwlAIoeGDRf2uZsj4jQXuudfy3DXDltJYLUeLiwEJHdXg2YYYOOuiv0j5RG9srqpJZ8huTbv/G15Zj5IifLZbTnLwcZ2XQ35GwWQz6N7CUCImgnWhIMNfxwzGdbQPlNGSM5QL4HIoyjl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(66446008)(66476007)(38100700002)(478600001)(86362001)(71200400001)(2906002)(8676002)(64756008)(110136005)(4326008)(54906003)(41300700001)(33656002)(66556008)(8936002)(186003)(76116006)(66574015)(66946007)(38070700005)(7696005)(53546011)(6506007)(55016003)(316002)(83380400001)(122000001)(26005)(5660300002)(52536014)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cm8yRVRlM2tBWTVlRXBDZEs4bDdQMzdkUlh5MFBPak9ORC9ob0t5aDYrUG93?=
 =?utf-8?B?Q2g5bkZDdlJham5TYkF5MVhWaC9NQ0RpczdJLzhSUmY4am5FNmtpMG1ERnhZ?=
 =?utf-8?B?UHA0N1hUQUx4N1VlcklObzBIcW9VK3R2SUdldFdzbXhoZmVBT2l6MUhUMFp1?=
 =?utf-8?B?WXdJemkvU0JYcnpvY1BRaEZRcDllZzg4Y1RXSEtaNkhGbjBvTnArS2RaVllu?=
 =?utf-8?B?Z3FiT2E5TXd3QUt0TFpvRUZVcTRMWTFSYzZyNS9OdktTdVcyVktsVUJmU1RO?=
 =?utf-8?B?L3FNN0I2RXZCc3RmVlFQKzlYN01UcFM3Z3ZsajFsVVliNlNvSzRjQWNVZzQv?=
 =?utf-8?B?TysyUlJOSVUva1U5RGFyK2RvRjBUQ2FUTWxTUnB2S0c0Mng4MDFLOEdLSUhs?=
 =?utf-8?B?cTJlTm5PeDZtM1B6bGRXSWRXWnk0cVNIa3dJRldLY3UzY1RKa0g4cVM3N1lG?=
 =?utf-8?B?MFM2dk9JRGhnZjhiYjAyU01yaVVISkRPMWtod0EvdjFNb3RjaFNlREhZS20r?=
 =?utf-8?B?VjlXVFJpdTg5M2JhaGVROWZiUnVRd3RCRUEyMUtMWDNTdXl3U2Q0N0xXTUVB?=
 =?utf-8?B?QWJMMG5tNW9EMndiUVNmM05aSTdLQXFTWkhrQVJkcnRLT0haQUZwM29scVpU?=
 =?utf-8?B?R0R1NHFuYndOUlNsdTh3WkxhbHlYMGlUeUhKSHZydHZucjREdlRrRXlUWWNK?=
 =?utf-8?B?aVA1aXA4dFF3MU5qTDRaU3haeFhPZTM5ZG04UXZGTzI4WTE5YVczUVFvb01Y?=
 =?utf-8?B?T0dhbnEwTUZRbWtGdndTamNpak5RcWJjaXk4UFViK0gweS80eFBueXBZaDFa?=
 =?utf-8?B?dG5BVDhJdzlOV2c3SXUyNEJQZW1Ec1Q4RUhZb0RYV2lmcW9NTFNDU1Q4Nkw4?=
 =?utf-8?B?anJIT0tWL3Ntejk0ZUwrZDlVNW1Gek95WUFlcHV1Y2dRTzlSM2ttSHV1MmpK?=
 =?utf-8?B?TEtlL09TaWo0U3orWWpMZjF3YWR2ZC9adXAzR2NMbG9XNXdCTGt3K3dwSUxK?=
 =?utf-8?B?RDgvd2dYOXd5ckNRbjB0M0RFKzFnaGxEYkxRMFdpTXlnYlhSSW5QUVdOWjVx?=
 =?utf-8?B?ck5tZndBc1hDYWV4ZkN1UWVYTDg1anNFS3VKTWxqQVIybkZteGQwQnQ5Wkow?=
 =?utf-8?B?QUlEa1E5aXdOTGloZ2hIdkFoUFh4Y3J4bzh1MHBDczZ0d0JzcEs0amxCOGsw?=
 =?utf-8?B?cDY0RTBQS0JON21PVXVRVlV0VmhyaFJhNEZpemxscnJMNDRzNTNoVm5yK0lj?=
 =?utf-8?B?WkZiektKSWJ0RWNuSVhwL204MHdDVHVvM1R4d0Zha1l3Q0xXUURHb0VlUlRp?=
 =?utf-8?B?NHd3L01qTGQyclJiVHNuSk1PVDREbVVPZnZvWCtVWmVyU0hydHVBVGE0clF0?=
 =?utf-8?B?bEM1Q0pJNkEzUUI2U3lpaUlOMndxSUdmcmluUVQ4ZExTdFVGdEdVdXVvZVZn?=
 =?utf-8?B?Y2dSaTZBUUFYK2lTVW5qZ2NJMjZZcVFZSmpvSGRPeU1BZW5mM2Q5SklyTEFC?=
 =?utf-8?B?dnBIcEJxM3NUbFg3eXNGblp5aEVoUDJBQUtZdHFCTnJ4dkg2WW1pQWxBSTdW?=
 =?utf-8?B?Y2d4QWpJY3FxTVpVRmJJa0lOalN2K3BwSy80Z2N0ZG1IMlh4QXNlQXkycTZN?=
 =?utf-8?B?SnAxYWRvSVB6YkltMUF2RUdFT1Z6Y0VEdHR1cHJEcGh4KytsUnJOdlJoblRm?=
 =?utf-8?B?elFLRnJaT05EeSt5N2hZc1oxTHVlVHAxbTljZWwrS0xVKzUxL3llVUFkbFBU?=
 =?utf-8?B?WjJXaThuNi9yL0VWZlFTUHN6UDArRURRRHd3MzZIN1BId2QxbWd0S0hMZno5?=
 =?utf-8?B?WFpqLzI4MGRMeG5iaVU1aU1aNUYveTl5YitCY2phWTE5eWpMYk9BY2loMXJN?=
 =?utf-8?B?WEpEUzc3NCtnUVZwZ0w1blUreGl3cWs5N2VtbS9FRDlrYUViV0VqMFNoeWw5?=
 =?utf-8?B?c051MVcxMFh2QmV0bHpOMXJaV0FiVzV1Q0dOZllDUmlJOHROeHdnamZvZmRV?=
 =?utf-8?B?bjlTNUVSb0x2cklRL25jRlc1aWxJVnRxbDZ3M2dMNDBudU54M3M4M0NndGJw?=
 =?utf-8?B?bnU0dE16VFpaUmhscWtheDgwVjBEdndreitxYkZzeGdKM1J2c21Uakw3Zy90?=
 =?utf-8?Q?CS1I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a60ff10-966d-4f13-1eaa-08da607e6470
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 01:08:39.3248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q85GRLrff5Ec72N2jcIOEXtdWgYz5v2rs/2I7Ajw2+bPopdHp7tagqN3m5INsnLp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4979
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkZlbGl4LA0KU2hhcmVkIGZlbmNl
cyBkZXBlbmQgb24gZXhjbHVzaXZlIGZlbmNlLCBzbyBhZGQgYSBuZXcgZXhjbHVzaXZlIGZlbmNl
LCBzYXkgTlVMTCB3b3VsZCBhbHNvIHJlbW92ZSBhbGwgc2hhcmVkIGZlbmNlcy4gVGhhdCB3b3Jr
cyBiZWZvcmUgNS4xOCAuIPCfmIkNCkZyb20gNS4xOCwgYWRkaW5nIGEgbmV3IGV4Y2x1c2l2ZSBm
ZW5jZSh0aGUgd3JpdGUgdXNhZ2UgZmVuY2UpIGRpZCBub3QgcmVtb3ZlIGFueSBzaGFyZWQgZmVu
Y2VzKHRoZSByZWFkIHVzYWdlIGZlbmNlKS4gU28gdGhhdCBpcyBicm9rZW4uDQoNCkFuZCBJIGFs
c28gdHJ5IHRoZSBkZWJ1Z19ldmljdGlvbnMgcGFyYW1ldGVyLiBObyB1bmV4cGVjdGVkIGV2aWN0
aW9uIHNob3dzIGFueXdheS4NCkkgZGlkIGEgcXVpY2sgY2hlY2sgYW5kIGZvdW5kIGFtZGdwdSBp
bXBsZW1lbnQgQk8gcmVsZWFzZSBub3RpZnkgYW5kIGl0IHdpbGwgcmVtb3ZlIGtmZCBlZiBvbiBw
dC9wZCBCTy4gU28gd2UgZG9u4oCZdCBuZWVkIHRoaXMgZHVwbGljYXRlZCBlZiByZW1vdmFsLiBU
aGUgaW50ZXJlc3RpbmcgdGhpbmcgaXMgdGhhdCBpcyBkb25lIGJ5IHBhdGNoIGY0YTNjNDJiNWM1
MigiZHJtL2FtZGdwdTogUmVtb3ZlIGtmZCBldmljdGlvbiBmZW5jZSBiZWZvcmUgcmVsZWFzZSBi
byAodjIpIikgd2hpY2ggaXMgZnJvbSBtZSDwn5iJIEkgdG90YWxseSBmb3Jnb3QgaXQuDQoNClNv
IEkgd291bGQgbWFrZSBhIG5ldyBwYXRjaCB0byByZW1vdmUgdGhpcyBkdXBsaWNhdGVkIGVmIHJl
bW92YWwuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLdWVobGluZywgRmVs
aXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQpTZW50OiBUaHVyc2RheSwgSnVseSA3LCAyMDIy
IDExOjQ3IFBNDQpUbzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBn
bWFpbC5jb20+OyBQYW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29t
Pg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4IGEgTlVMTCBwb2ludGVyIG9m
IGZlbmNlDQoNCkFtIDIwMjItMDctMDcgdW0gMDU6NTQgc2NocmllYiBDaHJpc3RpYW4gS8O2bmln
Og0KPiBBbSAwNy4wNy4yMiB1bSAxMTo1MCBzY2hyaWViIHhpbmh1aSBwYW46DQo+PiBGZW5jZSBp
cyBhY2Nlc3NlZCBieSBkbWFfcmVzdl9hZGRfZmVuY2UoKSBub3cuDQo+PiBVc2UgYW1kZ3B1X2Ft
ZGtmZF9yZW1vdmVfZXZpY3Rpb25fZmVuY2UgaW5zdGVhZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFtZC5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIHwgNCArKy0tDQo+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0u
Yw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMN
Cj4+IGluZGV4IDAwMzZjOWU0MDVhZi4uMWUyNWM0MDBjZTRmIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4+IEBAIC0x
NTU4LDEwICsxNTU4LDEwIEBAIHZvaWQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9kZXN0cm95X2NiKHN0
cnVjdA0KPj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4+ICAgICAgICAgaWYgKCFwcm9jZXNzX2lu
Zm8pDQo+PiAgICAgICAgICAgcmV0dXJuOw0KPj4gLQ0KPj4gICAgICAgLyogUmVsZWFzZSBldmlj
dGlvbiBmZW5jZSBmcm9tIFBEICovDQo+PiAgICAgICBhbWRncHVfYm9fcmVzZXJ2ZShwZCwgZmFs
c2UpOw0KPj4gLSAgICBhbWRncHVfYm9fZmVuY2UocGQsIE5VTEwsIGZhbHNlKTsNCj4+ICsgICAg
YW1kZ3B1X2FtZGtmZF9yZW1vdmVfZXZpY3Rpb25fZmVuY2UocGQsDQo+PiArICAgICAgICAgICAg
ICAgICAgICBwcm9jZXNzX2luZm8tPmV2aWN0aW9uX2ZlbmNlKTsNCj4NCj4gR29vZCBjYXRjaCBh
cyB3ZWxsLCBidXQgRmVsaXggbmVlZHMgdG8gdGFrZSBhIGxvb2sgYXQgdGhpcy4NCg0KVGhpcyBp
cyB3ZWlyZC4gV2UgdXNlZCBhbWRncHVfYm9fZmVuY2UocGQsIE5VTEwsIGZhbHNlKSBoZXJlLCB3
aGljaCB3b3VsZCBoYXZlIHJlbW92ZWQgYW4gZXhjbHVzaXZlIGZlbmNlLiBCdXQgYXMgZmFyIGFz
IEkgY2FuIHRlbGwgd2UgYWRkZWQgdGhlIGZlbmNlIGFzIGEgc2hhcmVkIGZlbmNlIGluIGluaXRf
a2ZkX3ZtIGFuZCBhbWRncHVfYW1ka2ZkX2dwdXZtX3Jlc3RvcmVfcHJvY2Vzc19ib3MuIFNvIHRo
aXMgcHJvYmFibHkgbmV2ZXIgd29ya2VkIGFzIGludGVuZGVkLg0KDQpZb3UgY291bGQgdHJ5IGlm
IHRoaXMgaXMgcmVhbGx5IG5lZWRlZC4gSnVzdCByZW1vdmUgdGhlIGV2aWN0aW9uIGZlbmNlIHJl
bW92YWwuIFRoZW4gZW5hYmxlIGV2aWN0aW9uIGRlYnVnZ2luZyB3aXRoDQoNCiAgICAgZWNobyBZ
ID4gL3N5cy9tb2R1bGUvYW1kZ3B1L3BhcmFtZXRlcnMvZGVidWdfZXZpY3Rpb25zDQoNClJ1biBz
b21lIHNpbXBsZSB0ZXN0cyBhbmQgY2hlY2sgdGhlIGtlcm5lbCBsb2cgdG8gc2VlIGlmIHByb2Nl
c3MgdGVybWluYXRpb24gaXMgY2F1c2luZyBhbnkgdW5leHBlY3RlZCBldmljdGlvbnMuDQoNClJl
Z2FyZHMsDQogICBGZWxpeA0KDQoNCj4NCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KPg0KPj4g
ICAgICAgYW1kZ3B1X2JvX3VucmVzZXJ2ZShwZCk7DQo+PiAgICAgICAgIC8qIFVwZGF0ZSBwcm9j
ZXNzIGluZm8gKi8NCj4NCg==
