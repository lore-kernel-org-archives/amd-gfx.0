Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA667F8D763
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 17:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A69510E919;
	Thu, 16 Apr 2026 17:30:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kmj9wUdP";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010014.outbound.protection.outlook.com
 [52.101.193.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F9710E918
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 17:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p99+7LteGRWAQSz2pQ2u5Kjb7jnYkNs5CeX+YYRb4NfyxCZ9E0qlbvb26LKPE3pNDXYuqaxWonp+6+wDJDSPT2OpR/3dn6KbxqN9FQsmJ+qQWD7KiNQ96TPhaTxFlG+0qSd41MnACQdx1P1fcDL1914tk/DMdlyaIl01NfOwSQPR9xZCzd4VfJhJlx7GOebKpLhGQqnBSXCIzqZ0n2QJQ/UaiOkQzVU56rHKPVRyfj+/uHPzlfl7BfU5pWhA1GE8rkNFVZ+atf1nd6BPk1ZeKqVzoqKLNR0Oz7dkM8K7pe/4OtTG+RX9owDpu8y9rUc8Mt3sQFH6Dpqif1XHoQaiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNKMJPkWYQ/dmWG0/nNDn02mjjCTP5CIHNIx/f7JnhE=;
 b=FDsY2hVFqMRP8iSPOvHEfw1zm/70fQtk5ShyrAYCw2uDozc4PmH5l/Esv4CO06cr02rnFKouC5qnAjBi7h7r+x2p4oqRYQtjvUGU4RXoUNg1rZKR3gHrjjyDECPXmBElGn3FhhUn5xEzoiG1cYqx+Cu7dtUw15egKjouLnbqun7xmR0oYH+n6SW9/LnIQeCrdcAbYFBn/f8f4pnEDs3J5XmmW9CbCeUi6as0VWPjokPMNntPZoN8Ke/NOZ/sjmTguKp8uC243FytY+nkF0SmAUEIaWXo7pBFQjdpGHX2vnIm5SKvsYDo+uK6lgd2Pdr6j/iBOcN5cPBmuqpGBaDHCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNKMJPkWYQ/dmWG0/nNDn02mjjCTP5CIHNIx/f7JnhE=;
 b=kmj9wUdP6YQwCqxgMzjideM+dlyyB88WDLHaVgM6Wj0T2gOwi2T0mfXWphdKAdx1LKy0D6Gu4L03zW3MV7BhPHz/OS9smtk2mqXVB55wuxScCR8RDlNKPcjPtiieL4yeDcfr9X8ky/S35hSBnwcR1ypca8h0gWdphKquHmbp3ic=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by PH8PR12MB7028.namprd12.prod.outlook.com (2603:10b6:510:1bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 17:30:27 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::f3be:26ac:e6fd:16da]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::f3be:26ac:e6fd:16da%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 17:30:26 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu/include : update mes api header v11/v12
Thread-Topic: [PATCH] drm/amd/amdgpu/include : update mes api header v11/v12
Thread-Index: AQHczcE9Js1E4o5i+0+wtzzXoisFkbXh8QcAgAAAQhA=
Date: Thu, 16 Apr 2026 17:30:26 +0000
Message-ID: <CH0PR12MB53723E8B2FC6B3015351C646F4232@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20260416165056.15459-1-shaoyun.liu@amd.com>
 <CADnq5_OThuww_7RA0xyQNkaiGBzzt1q2tRsCBtH_CKn48aD7DA@mail.gmail.com>
In-Reply-To: <CADnq5_OThuww_7RA0xyQNkaiGBzzt1q2tRsCBtH_CKn48aD7DA@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-16T17:28:11.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|PH8PR12MB7028:EE_
x-ms-office365-filtering-correlation-id: fdb06dd4-7e1a-4fb7-7a18-08de9bddd92b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: EKMRPx0VygIoxX+6++yFtP2XYh/kyyoPJjiZXvAqHVrgTIO6t0+lb8+6J+DJLlk1R445QyTY0vMZSH8XYcKaJ79HpC5ZYsnMqKOjyTXIounAmNHO/VQqRZWTdjxBU3UoQTLuH8Hm9YSKfyp8ElIkNL54DzSPk109ZvjqzQZkn2Tt+RFZOzNeQIT9LRlx+pm9dWifZ0Lvt+cFPLnAdAZDdxLUEpsDOp2SB+lvun+YF9QDIkRNOELEaMkL+JRNAJWA55mIc4NzV1o3mShKL9eT6P/W2KhgkBfSF43HTsBPLv0n3jVH+WqGRBX4Yxv3LHvgXBYL89O1ExQE4OA509Qv+YCd0pW1iKYzm25NGLdZnNvE/tuQIJbsoJjraM2fNNChlXf1wkIdIWsZxLTZjqMjAB3uRF3dTuuOMl/z5zpq1POyINcpivS06euXe+dTFwsbcsUVEmvNaDhWlxBdobGnI4QeXLchJppm9+Gb/6lRvgoAwqnQ44JkE1V6fm3AJadVcoVO0ESyj/XKxXsGkmMdt6ugZCGmbP7jJwmlq1xozZN/ONmKMc0Zo7FLVgpiUUuP4QkHjFQ4gyryVljbSp1+E4njzH0RgGkjYky9sSJS7NCJHUE1uSwadEiQndxdFZP7XVLF54uZlnR+1cFgAdC44S/J7/uKLjH+jldt45F/sgqCRFfl497OZUV0Ah9zV4AJMKZmkMKPzk5mzi+Ws0kXGUmS7xzPCZ7h7NL2vsorw/r57RV8XMJMy1Pjl/seVXOq1OXJ8ODDCVJpNa8kcQMNvqt90mb0o1eFqGbpcE9jrNA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K25mN21XRGdYZ0Y1Yy9zTFFvdG5tVzFIMDFqYkRFbzV5R3FZY1dyRW5hNlhF?=
 =?utf-8?B?TjFQNGoySXpyaVQzTjdNTnVXRktxZkpBTEhVZ0puc1RwNTNlbFRXWFpONzJT?=
 =?utf-8?B?QTIwZDZXUGZ4djZvNVpsNXpCKzczU2NNMWt6NHE5ZVB3dUk4MWIyODBRQXhk?=
 =?utf-8?B?aldnbjFKb2cwQ3NwRHd0bzZFNnpCVXUrZmszM1Z5YnZ6OThUWE9RaWVuY2hE?=
 =?utf-8?B?SXYwelZYTXVEM2xoNU1YTEVFLzZwUlJVT3dqdU5ybDdEK3BZZ0dlMm8xYTh0?=
 =?utf-8?B?eFkzMFNVV2ZPSC93eXkwY0l6T0VZdCtZNzNPdEhEUXZjeUVrYjB4UzBqbFVi?=
 =?utf-8?B?cTVTZEcxdFVNRHp3eFdaL2ZmT2RyUFk4OWhZYkZMVzhSN3N1M00wMHV0TDNi?=
 =?utf-8?B?Y1NWanBLZkZLTFZhY0M0c3Fvb2VoV2VGK05yL0RqM3lNTFg0ZGV0ZWpXd3dF?=
 =?utf-8?B?bUtzd0FkVXZWaDNrOFBwTzQ2bDMxUHBBZEZQVWVNVlp2S05UbkIrd3F0eUJk?=
 =?utf-8?B?OTJMb1pSb0lRUmo0SEQzSUNOd1hCWkpwZkZ5NmU2OGFCWXl5M0ZxZTFTRmlU?=
 =?utf-8?B?ZFpRMUJiNWR2UFRHM1NrUGhmSlhnN20yT1k4SHJsQmhoSEwxRm5NRlB0L0R4?=
 =?utf-8?B?ZXR6bVZrYUVzbkhMS3pIRDk4TExUUWRueHRTMkdlUFpXUm9mTzlKUE54TVNr?=
 =?utf-8?B?c3F3TUZvS3dua2Z5Y2NIN1RFNm1kVzRxTkNPclVQMEpHbVV3UUdDMy9namx4?=
 =?utf-8?B?WE5NeWdBY2ZGZVBHY21QVnI4SXhNaGhIRmo0Y0ZMRnNiN0s3K054a0txSkVE?=
 =?utf-8?B?d3QySnJVdVpQQU5QWFAyYWNCNHBzNWpKM2Y1L0dNU1lpUHBBenZPVHhVbHhk?=
 =?utf-8?B?Q0VUUllFdzhIUnNEclAra0l0QjFwcmxiV01mOElLSFN2bjdXUmZOakd0ZGxo?=
 =?utf-8?B?S0pSbm1oUWptZ0RyY1dTNHgyeVE3eCtuUmtMU2NlLzZ1WCtwMjdjVFJNUXU3?=
 =?utf-8?B?RWlxaDZWTEdjbERMcXpCZkVOSzYxTGdON0VaS3hkdGRYMkgrcXFPQ0toUHBl?=
 =?utf-8?B?RjV1UGpDWFZjSW9UQTFwTUp0M1lWUXhXZ1FhRnhOYUFOcytaRFJ2Z2tpelox?=
 =?utf-8?B?UElic095ZUVVb0YwYlp2UTJFa1VJTU9qdHdMeGFWbEwvSzFqQUIvd0Rac2lU?=
 =?utf-8?B?K04xZ1Q0dDZVYlFUUU41VDBxZHVVNVpESGNzTk1objZNU2NYWVRjVVdqREtO?=
 =?utf-8?B?TUFZVVU4UXFZb1QrL3JFWTJHS2ZuVjhPanNmNGEzWWJFdWJlWGNCSG1FY2pQ?=
 =?utf-8?B?M25sOWQzN0U1TS9Za0xVQXJlVUxqclFPNW1HRk1qZk9idHdOWXMzTndPbXA3?=
 =?utf-8?B?bWdTYUhjVjlwL09pQlpLandzczhZNkRHRFg4WEkyL1hFVysvZjU0cUpzR0Qx?=
 =?utf-8?B?VTVxeU1yckJqRlBkWFE1d1VUeHNvSWo3eFlwN3NSTjFnekpyS3dXM2lKM3pN?=
 =?utf-8?B?Z1lNWVpuOWFoc3B4ZG53Z1VycUNHaU80NFhPQ25heC92RTRkYTk1WThDeFhu?=
 =?utf-8?B?T2drOFdmWDRTc1paUDlkbkJ4Mi9EeGE2anRhVytqVFlZL2dhQko4UDhBa0VE?=
 =?utf-8?B?cEp0SDJaWlZDY0tOVmpvL0p0b25uQ2RjT1RKU293TDg1V3IrSkdUa1NralpN?=
 =?utf-8?B?WlFBdnk3SkJKVHBxRDlPaTVoTytMYTh6UVk4T1lTNk10Q1dsQW9ZYVBzYUJ3?=
 =?utf-8?B?MHd1eGZJY29qTU1nVis2eHhNTUJKeVhKTzc5MDlWa0YwTlczOXBHYkRjUjBt?=
 =?utf-8?B?QldTVHV0cG8yczNYSHZQbkhLM3JaV3hKWU1kelU5c1ZyT0t2VWl0SEg0bVQ1?=
 =?utf-8?B?RmQ1VkcwdG1tamZXdE9pSWNCUU83dXZvaEVhQUF4dTE2eldmb2VYT2Q3S2Q1?=
 =?utf-8?B?a05TaHluem1vYTBDVTZGTVZhOEMwbjQ3V043bTVjOVVoTkJaYkdTNlUvbXZH?=
 =?utf-8?B?YzVhU1BmdXkxaVFDUm1QRXFPUDR3WjNhZ3g0L0tyWlFpWXhjVFY1bHdsMnFs?=
 =?utf-8?B?T2FzL0MxTWd3WFVMYkRXZi9PRWp2VW5senpHeTZWSkg5RFZyRDBYQWtKaFA5?=
 =?utf-8?B?N08zOGV0QXI4aGNtWHEyVVZNWEV4cFFzYUI2cEdPeTA2dkN2QnZIaDVHWUda?=
 =?utf-8?B?SDZlNWlkK3p6RGV2OGV5TTZZSlJQYzNEazBTbVBwNlJrZWF0VFBSQWRGMi9l?=
 =?utf-8?B?UjJNeEhEMHVRKzMvYzJXRW9uNndrZFYvTFlSdGdibkpUUzMvWGhWQmV4NUVx?=
 =?utf-8?Q?/W8nNG7KAQP8UytE08?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb06dd4-7e1a-4fb7-7a18-08de9bddd92b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 17:30:26.6144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AyMnG1/rgudXHNr+Af49XFRCLzA6UxYNBdhsF/pkqT5lM1o4DrEqO35mDvyCXclqjZFskC+CFJqD1xLJfaLo4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7028
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KT2ssIHRoYW5rcyAsIHdpbGwgYWRkIHRob3NlIGluZm8gb25jZSB0aGUgbWVzIGNoYW5nZSBn
ZXQgbWVyZ2VkLg0KDQpSZWdhcmRzDQpTaGFveXVuLmxpdQ0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQpTZW50
OiBUaHVyc2RheSwgQXByaWwgMTYsIDIwMjYgMToyNyBQTQ0KVG86IExpdSwgU2hhb3l1biA8U2hh
b3l1bi5MaXVAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3Vi
amVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZC9hbWRncHUvaW5jbHVkZSA6IHVwZGF0ZSBtZXMgYXBp
IGhlYWRlciB2MTEvdjEyDQoNCk9uIFRodSwgQXByIDE2LCAyMDI2IGF0IDEyOjU54oCvUE0gU2hh
b3l1biBMaXUgPHNoYW95dW4ubGl1QGFtZC5jb20+IHdyb3RlOg0KPg0KPiBVcGRhdGUgdGhlIHBh
cmFtZXRlciBpbiBTRVRfSFdfUkVTT1VSQ0VTIEFQSSAxLiBBbGlnbiB3aXRoIHRoZSBzZXR0aW5n
DQo+IG9mIGVuYWJsZV9scl9jb21wdXRlX3dhIDIuIEFkZCBlbmFibGVfY29tcHV0ZV9waXBlX3Jl
c2V0IHRvIGVuYWJsZQ0KPiBwaXBlIHJlc2V0IHdoZW4gY29tcHV0ZSBxdWV1ZSByZXNldCBmYWls
ZXMNCj4NCj4gU2lnbmVkLW9mZi1ieTogU2hhb3l1biBMaXUgPHNoYW95dW4ubGl1QGFtZC5jb20+
DQoNCldvdWxkIGJlIGdvb2QgdG8gbm90ZSB3aGljaCBNRVMgZmlybXdhcmUgdmVyc2lvbnMgc3Vw
cG9ydCB0aGlzLiAgV2l0aCB0aGF0IG5vdGVkLA0KUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvaW5jbHVkZS9tZXNfdjExX2FwaV9kZWYuaCB8IDUgKysrLS0NCj4gZHJpdmVycy9ncHUvZHJt
L2FtZC9pbmNsdWRlL21lc192MTJfYXBpX2RlZi5oIHwgNSArKystLQ0KPiAgMiBmaWxlcyBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvbWVzX3YxMV9hcGlfZGVmLmgNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2luY2x1ZGUvbWVzX3YxMV9hcGlfZGVmLmgNCj4gaW5kZXggZjk2MjlkNDJh
ZGEyLi42NjQ0ZmFiZWIwYjcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5j
bHVkZS9tZXNfdjExX2FwaV9kZWYuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1
ZGUvbWVzX3YxMV9hcGlfZGVmLmgNCj4gQEAgLTIzOCw4ICsyMzgsOSBAQCB1bmlvbiBNRVNBUElf
U0VUX0hXX1JFU09VUkNFUyB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDMyX3QgZW5hYmxlX21lc19zY2hfc3RiX2xvZyA6IDE7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdWludDMyX3QgbGltaXRfc2luZ2xlX3Byb2Nlc3MgOiAxOw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGlzX3N0cml4X3Rtel93YV9lbmFibGVk
ICA6MTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBlbmFibGVf
bHJfY29tcHV0ZV93YSA6IDE7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDMyX3QgcmVzZXJ2ZWQgOiAxMjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
aW50MzJfdCBlbmFibGVfbHJfY29tcHV0ZV93YSA6IDI7DQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdWludDMyX3QgZW5hYmxlX2NvbXB1dGVfcGlwZV9yZXNldCA6IDE7DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcmVzZXJ2ZWQgOiAxMDsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDMyX3QgICAgICAgIHVpbnQzMl90X2FsbDsNCj4gICAgICAgICAgICAgICAgIH07DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvbWVzX3YxMl9hcGlfZGVmLmgNCj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvbWVzX3YxMl9hcGlfZGVmLmgNCj4gaW5kZXgg
ZTU0MWE0MzcxNGExLi4wODQ2NmQ1OTY5NWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvaW5jbHVkZS9tZXNfdjEyX2FwaV9kZWYuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2luY2x1ZGUvbWVzX3YxMl9hcGlfZGVmLmgNCj4gQEAgLTI5NCw4ICsyOTQsOSBAQCB1bmlv
biBNRVNBUElfU0VUX0hXX1JFU09VUkNFUyB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDMyX3QgbGltaXRfc2luZ2xlX3Byb2Nlc3MgOiAxOw0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHVubWFwcGVkX2Rvb3JiZWxsX2hhbmRsaW5nOiAy
Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGVuYWJsZV9tZXNf
ZmVuY2VfaW50OiAxOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90
IGVuYWJsZV9scl9jb21wdXRlX3dhIDogMTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1aW50MzJfdCByZXNlcnZlZCA6IDk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDMyX3QgZW5hYmxlX2xyX2NvbXB1dGVfd2EgOiAyOw0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGVuYWJsZV9jb21wdXRlX3BpcGVfcmVzZXQgOiAx
Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHJlc2VydmVkIDog
ODsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDMyX3QgdWludDMyX2FsbDsNCj4gICAgICAgICAgICAgICAgIH07DQo+IC0tDQo+IDIu
MzQuMQ0KPg0K
