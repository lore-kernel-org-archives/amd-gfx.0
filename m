Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F19C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 09:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F2810E401;
	Thu, 18 Apr 2024 09:34:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aYuTt9Cj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5078B10E401
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 09:34:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8jz2SAXC2b0UhUGM6OybDYjOXSiibfqhxJH4LMijv+E8nn2p1l09JdZcqaL6IS1fm0KRH6EWdHCXI0YlnqiqLJiOEP0wfnUfbHQYNtAKuKsAaz5dUsmvyYRR73cd/93CKnA9oWdRWtJ7fJ6GuMYxdxbkyFgHXbTRZgZ/1OUlXK8eE8x1tCg/JzpsOUQVgF/nWHJJKzh2eDIi1NURHynH39V/mmgH5EASBnaPFhybTW7T0TOWvQYS4lYh/dyAsMKopmKY1X/OZXg7yGkuFlKgBRFK2dG7NYG+Ak8Q8Mh2rlNHWB8tKcTXWf6Rr8KKnrmDFQDjmDIyvFhJUu0oDokdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQDwTA7kX6p16Buwe26mrBL5PFxDOGiaYDJelPhR168=;
 b=I5oKiMktfkIVsT4YogiXodSF31c4E7AYUeOOQKeSqK3LbHAkGEP8BqY0DVLjlCg6CYuJBYRfXF/b5Dcbholm0FOcguCTGWSCaLxELeYAOBmT15rPttbH+Ay7k8IVREd1ZdObRVLO44zXZ39LLs0tWU7AXyJgFwHgDN0svwBox9wzQPtUIuVayyD43biYCx2EbF2ODqdgE4HWY6SA8RnXC+40D+x98oiZYgGLWZ9yvQIMpTTj5SvnaFc5w5vYOTTq5IXFlh6sRSMDSBYlzv4F8LCAxnMc05Og4/3sPGM2UaI2vRPbS8bgVkzI5/kvzcMZslmSx5D57NcuWpQvv9Wqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQDwTA7kX6p16Buwe26mrBL5PFxDOGiaYDJelPhR168=;
 b=aYuTt9CjBXpTVrpLv4GIt1bFiM9g8UnOv9Q5C0wUHuThqYgoH01XyPUqjWuY+Bf9ktNrQJ6Pe6+B8IRoQosANWHQUSEfcaXrCGsWEXrLEIHSk14i0Ikzs/DK5DJcOEQ5NE2wjKZDuRRtlMK1G3NnJjde7MT+KsIYHOYo3QylhYM=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 09:34:36 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 09:34:36 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 15/15] drm/amdgpu: Use new interface to reserve bad page
Thread-Topic: [PATCH 15/15] drm/amdgpu: Use new interface to reserve bad page
Thread-Index: AQHakTzYwC0hSXi0TkSyow1znVkUCrFtu1UAgAAIq4A=
Date: Thu, 18 Apr 2024 09:34:36 +0000
Message-ID: <CH2PR12MB4215F6E6805189417A8D092CFC0E2@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
 <20240418025836.170106-15-YiPeng.Chai@amd.com>
 <17718699-72cc-400e-bef8-5b4314a06386@gmail.com>
In-Reply-To: <17718699-72cc-400e-bef8-5b4314a06386@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e9e457ba-c068-49dd-910f-bb40ced295b6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-18T09:31:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|SA1PR12MB6677:EE_
x-ms-office365-filtering-correlation-id: 1ae3a894-31b1-4ea0-9f0e-08dc5f8ac367
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bb3qd9RxIc7zAH82/ZUUt2+jeZN3DmZIpbORQlVA4SA9a4/gFVTBjN43co86xFS6sSCQ33+CjQ37TcDDr1R3W95aPV1lOj/wxk8UeaaUc/gdhwKOZO/yxKt1x70eZez0Di4Scg1QACMXneUeXtjbQW/Fl8i48xSGGMkyrmt+iFfqoqrp9jQC8IRd3b4PYk6H3/+i60ots2c3uvTsssvZ6p0Nano2r3+2mbJxsEhkbGfeNq0aqNxW2kbp0BSY2PZRf9x4zJ+LrtAfPAf+QFl6NFkguSh8k1ZSm4pNhpB/808Jfc5A5MgkNIsxZmJT6XwmBG/FUcZ+ysQ9z7fnsYt/RrE8XGmfuq3ae6Mbo6x1XzoytYIjhVlPWJ3ejglIvNqxupmHXXTulLyWR6rQ+Xzh2CwDtknoLVo7YrPNr4VRtn6M5kIXll0TfW0rStXdROt91J1I16NWAL7gJxlRlIrshDdUiHWrC11jEleT30hssWt5SXYJYpT81iu+1ebKfyUJc+JKnfQvwZpQ445sZeONNs37KsK7NbpEpxHp4DmhEiEgoFdcAxqS5j68WK6XLi3dUISZUEUw0/FlwzcW7M5UocU6rTOKxITiAp54XNuysBczs6bC3p9D4PTrLD7uZDY6dvIXNtEHt5C1m959ImlCDd72NfUYQM3cdIn7O34acLfSJspUGpXdfFcDTvb7ie2A6HKIuVbQWH2Iq46yYkS8qA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nmt6ZHJ2V2pIdXB3Y041aXU4WFk4am9aQVk4MHRWSkh2SlIwZWcwZ0FhMW9G?=
 =?utf-8?B?Z0twOVpiNFFhT21pQlp1MDdsOUQwNXEvTDUvLzFnd0FsNnlWUUNLellWTXJy?=
 =?utf-8?B?cjBIZGYrcXN4WkF1MmdKdDlSYkgwaXFhOHZadFpMRmhwNHFLQU43NHg4UGFF?=
 =?utf-8?B?MkFBVm1oYlNwTTRxeUlyaHVvcDNmYkJPREJNelVmSE5YMWFueGFIdHhsWS9E?=
 =?utf-8?B?WmRrTmhUcFg3aThQbDM2ZzMvNUhJdmJnak5HeGV3RWVQeTNmNU9NMlJidjAy?=
 =?utf-8?B?UHBnNmUwZld1diswL3dVam5yUkpXbFdJTWxXSEVDRXlVaDFqOUJzYzFhNFJU?=
 =?utf-8?B?TEU4QXpNVElGQmJ6ZjBxK0xyN2xUSFFVaUxDbm12ZHhWUHo0V3RhYXBia1ZQ?=
 =?utf-8?B?NGFTdGhMRlVicUZpZkl3RHdYRlhjL0ZKM1U3SWhmQ1NKZnV5L1VrbmRJTjhh?=
 =?utf-8?B?UDFocnQ3eXlaS2x0d1F2U0x3TldzL0xrWmdNcDArNVU0b3h1a2VDME9IYWRK?=
 =?utf-8?B?WWZ5MXhWNi9OUkRodGJiSDdWK0FPUDlWdVR2ak9tVC9vM0ZDM3dTMStiWHMz?=
 =?utf-8?B?L3Q1a3FqN0I1dkIvTE1mMEtubDYwUXV3clI3Skc1UjB6cXkya1VWUGxVR0N3?=
 =?utf-8?B?RWFGN2FCSXdMTkIyY2ozVzVKREEyUDBoSU0zZjdmN2xqNUtYU2I0b01TcTc2?=
 =?utf-8?B?OExGb0V4K21nUmlLRjE5WVRaVGZFS2lyVnU3QnJhMXBLVXI3U0hUTmhBWG5U?=
 =?utf-8?B?cEtQb1NaOVhXajE0K0pLdzE4Y1c1cFl5QXhCdVJzazhqeHlkVDVzZmU0cWdJ?=
 =?utf-8?B?eTB5V0h0b2ViTC9XOGxoeSszbVJXWFRMWHZIdzUxVkl2cG94RFY1aC95eUph?=
 =?utf-8?B?M0oySEZIN1ZTZmljck4zdHlubWxyNzZQVmJqZlZoU0J3UlJzNzV5ekQ0ODIz?=
 =?utf-8?B?MnZPNXpBOWQxSExIOEppSXE4eXJKQzFKK3hVV0pBcjhna24wT1ZoODh4aDRX?=
 =?utf-8?B?VEF6Q0pCYTRmdTR6WVRsaFowOU9zM3dDeUVGSnNoRFVvbUFSTlREQXU3RE8r?=
 =?utf-8?B?K1VhRzFoSWN6amQ1Y2JmbGluZzYvbnBUTk8yR0pWY2l1SGlwalhDUUs3SnAx?=
 =?utf-8?B?NzJDaHJJWEI1cmtCL2F6OHQ4U3hkSFN3VE9TYUpHL0JDUGJGeGJSYmlqV0dO?=
 =?utf-8?B?aFVMN0lVZzErSWpwWUJuYzhHaVhwSEdiN0cxQkIvZ2pvUngzVXBYa1haazd0?=
 =?utf-8?B?WUNQY1diT2VMTjd0WHJ5enNuSHJDTWg1RDA0c3U5M0JicVYzWjRRSFZSN2Zi?=
 =?utf-8?B?dEsrMDFlVHY4UEMxZTQyY0VSRXJFSDhPSGpOcWFBS2JrZU9FQ2tFc05YRkp1?=
 =?utf-8?B?VmRJYTYxZTVpaFNBTTV3SlFPWVNHRUxCaTdiVExzUUt3YjVvVERBZ1BPbUIr?=
 =?utf-8?B?eWt0UzI2ZkhEejZNSlUxT3JtZTlUcE5wZjBqL1JRdVA0TWtEZE92WGZDZlpG?=
 =?utf-8?B?WFZTcFhtSnRHZFVXNlZwWHl0NnZsWHc3Um9NQTJnd2FPR3huSlJSR1BROFVZ?=
 =?utf-8?B?Tkl5Y2o4VDVDODVQNWVzK3FGNytnOUdIVkVpR0VWeFljMGFWNCtXLzZEZXhP?=
 =?utf-8?B?WGFLZXR5UGJjeWVLUVI0RGNueG1iUGRIOVdJRlBLSThLdVU0WU93N3RIOE1l?=
 =?utf-8?B?VDNSRURyWmJXVS9oaGxKQktHNGtnSVZhRUNySklVS01xNzVXNlBVRmhFYXRR?=
 =?utf-8?B?M0JLNE5mNGJ4d25FLzFNNS85VjNlbktFZnRPV0psOXMya0xFS2NReGxRWFFv?=
 =?utf-8?B?L2lMcUVpMWVMZmY2UU5MZ3pzR1NJS1hZd0s1ZjFqN29MV3NuWGtZTW1PSGNq?=
 =?utf-8?B?ZkpNYWVEcnhTemQvZnE3SXcrWFZ6cXd1Vmk1VVA2WGlFRnhmNWxwTlMvc0wx?=
 =?utf-8?B?LzZWVlZSYWRCdXJMVGwzT2VFMjlpWE1PeEhJTlhyVDNEK3hjVTlzcW1LamtJ?=
 =?utf-8?B?MUZLZXFtVkZuaGpKTVoweGxvUHJ6UTNtQXpyMDRLWDFqd0FiNld5SnZhMCtu?=
 =?utf-8?B?d0Z3emhIUVU1MDI2OTdZQlhWSm0xczZCZTZURk0ycnJqTUt6TDlSMjFuV0s2?=
 =?utf-8?Q?mnxQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae3a894-31b1-4ea0-9f0e-08dc5f8ac367
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 09:34:36.7762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3XQYRcCsMBw8vDbBBHcb6lYvpiiSPLalu9pPvRwgTV5EuLozxyQSIHQCDcLU37lkHpb74J2FZHu1LUObPzOSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCi0tLS0tLS0tLS0tLS0tLS0tDQpC
ZXN0IFJlZ2FyZHMsDQpUaG9tYXMNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0KU2Vu
dDogVGh1cnNkYXksIEFwcmlsIDE4LCAyMDI0IDU6MDEgUE0NClRvOiBDaGFpLCBUaG9tYXMgPFlp
UGVuZy5DaGFpQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IENo
YWksIFRob21hcyA8WWlQZW5nLkNoYWlAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5n
LlpoYW5nQGFtZC5jb20+OyBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IExpLCBDYW5k
aWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+OyBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldh
bmdAYW1kLmNvbT47IFlhbmcsIFN0YW5sZXkgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPg0KU3ViamVj
dDogUmU6IFtQQVRDSCAxNS8xNV0gZHJtL2FtZGdwdTogVXNlIG5ldyBpbnRlcmZhY2UgdG8gcmVz
ZXJ2ZSBiYWQgcGFnZQ0KDQpBbSAxOC4wNC4yNCB1bSAwNDo1OCBzY2hyaWViIFlpUGVuZyBDaGFp
Og0KPiBVc2UgbmV3IGludGVyZmFjZSB0byByZXNlcnZlIGJhZCBwYWdlLg0KPg0KPiBTaWduZWQt
b2ZmLWJ5OiBZaVBlbmcgQ2hhaSA8WWlQZW5nLkNoYWlAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgNCArLS0tDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+IGluZGV4IGQxYTJhYjk0NGI3ZC4uZGVlNjZk
YjEwZmEyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmFzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+
IEBAIC0yNTQ4LDkgKzI1NDgsNyBAQCBpbnQgYW1kZ3B1X3Jhc19hZGRfYmFkX3BhZ2VzKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7
DQo+ICAgICAgICAgICAgICAgfQ0KPg0KPiAtICAgICAgICAgICAgIGFtZGdwdV92cmFtX21ncl9y
ZXNlcnZlX3JhbmdlKCZhZGV2LT5tbWFuLnZyYW1fbWdyLA0KPiAtICAgICAgICAgICAgICAgICAg
ICAgYnBzW2ldLnJldGlyZWRfcGFnZSA8PCBBTURHUFVfR1BVX1BBR0VfU0hJRlQsDQo+IC0gICAg
ICAgICAgICAgICAgICAgICBBTURHUFVfR1BVX1BBR0VfU0laRSk7DQoNCj4gV2VyZSBpcyB0aGUg
Y2FsbCB0byByZXNlcnZlIHRoZSBWUkFNIHJhbmdlIG5vdyBtb3ZlZD8NCg0KW1Rob21hc10gQ2Fs
bGVkIGluIGFtZGdwdV9yYXNfcmVzZXJ2ZV9wYWdlLCAgYW1kZ3B1X3Jhc19yZXNlcnZlX3BhZ2Ug
IHJlZmVyIHRvICIgW1BBVENIIDAxLzE1XSBkcm0vYW1kZ3B1OiBBZGQgaW50ZXJmYWNlIHRvIHJl
c2VydmUgYmFkIHBhZ2UgIg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+ICsgICAgICAgICAg
ICAgYW1kZ3B1X3Jhc19yZXNlcnZlX3BhZ2UoYWRldiwgYnBzW2ldLnJldGlyZWRfcGFnZSk7DQo+
DQo+ICAgICAgICAgICAgICAgbWVtY3B5KCZkYXRhLT5icHNbZGF0YS0+Y291bnRdLCAmYnBzW2ld
LCBzaXplb2YoKmRhdGEtPmJwcykpOw0KPiAgICAgICAgICAgICAgIGRhdGEtPmNvdW50Kys7DQoN
Cg==
