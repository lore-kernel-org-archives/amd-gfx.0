Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16E4C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 09:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3127210E492;
	Thu,  8 Dec 2022 09:59:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC85210E492
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 09:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agq5lbNmotgoAA1dlCcl2IlY4s+OPWYTNsZ9Ru/x8oxdn2+G+WuJggsbuG6GawNrXugrho7pYcaSdmRBMy4B+ClufsxxNsE6YConnk6JW7ZFqzFBezR1aEIlY93t3rL8FSC4p0HSBVpKYuuXUevabiJSp4i9FKh8sFUMf6cXlTCPB9wkM5Dx8/Tt/d07V4LWjHgR1YRzb/hG74qyrhbm9R4w3I+erY+M7MlfxssmcltGKyKB2cShSqXlEYtxrbXkdo89CfW6vaS+ZZYgFLmslOiEBa8vaRxL4hOUgwPF278VpE0VUXwYAiiv4H7WJYFHNSXnOCXQ4UCTG+au58gFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0yLyro+OL8oWCJzySeonF1fjaJ/gPZBYqnwhcgBvCY=;
 b=FBb2NO4xM+QQ4P/o1+cYzUfBb2fsr8QMN6xBgMmkdBkGYqdimtUu8moZdyWlDox8h07LMElGQPc6CF/KBfUMwuYwIiVUwxcb6f2wHyfW5ikYPywcRrOjtpDhF8u05ZQaS8zo/IQjErxN+PGTznsoBzVp/iW9nbMLPWilxH3rp2lHgCwDfy06YeTyPss4A7NBwyIgMlm1QNGypQD8cWvCkr4UxJJjFPZaeyAfx6aqtpE8OxO+PNr+K5N2J0YhnK5nhL7jSF0wJkAUSseTAdnibCJishZuWedyUnXA6DlQmCESwUSVqJLekYhQfelq1ABZBCF3W0AAN8/QYBPlepRxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0yLyro+OL8oWCJzySeonF1fjaJ/gPZBYqnwhcgBvCY=;
 b=gdiZgJdLePYrTxlByhrNlM+UwXOFf8zeMHhBdPJQNhkNvHL7MWhnsykUagVuv4G9XLZmRwC5Bx+aPvWNJ+ZwG1m53MiqSVB82CcZyn4jOJYETzMel1pi7moJfeXAiyUsX/7kUNkle3iwesPeAnNFtb0G4L1p8ZxuHAoeBhekPDc=
Received: from MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 09:58:52 +0000
Received: from MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::14d7:4ac6:33e:dbc3]) by MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::14d7:4ac6:33e:dbc3%4]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 09:58:51 +0000
From: "Fan, Shikang" <Shikang.Fan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add an extra evict_resource call during
 device_suspend.
Thread-Topic: [PATCH] drm/amdgpu: Add an extra evict_resource call during
 device_suspend.
Thread-Index: AQHZCucaWuohfO+CVkmhAw2HI9cI365juYQAgAAHZbA=
Date: Thu, 8 Dec 2022 09:58:51 +0000
Message-ID: <MW2PR12MB2586FE60C8A0247C1EAC68DEEB1D9@MW2PR12MB2586.namprd12.prod.outlook.com>
References: <20221208092545.4792-1-shikang.fan@amd.com>
 <9d88a136-bd7e-3af2-acc7-c19521556a2d@gmail.com>
In-Reply-To: <9d88a136-bd7e-3af2-acc7-c19521556a2d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-08T09:58:49Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5f2214a9-a087-46ac-8f3b-b7c8ba75ee4b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-08T09:58:49Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 882dfb30-f801-46cc-85af-3adddf96eb34
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB2586:EE_|IA1PR12MB7544:EE_
x-ms-office365-filtering-correlation-id: e61a773d-72cf-4ac6-008e-08dad902cf56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W07iAWu23hanqglyYDHbM59JVu/4miooqVrwIb+M+LlwrFGiJkSbQtL/5y+oh3qzxxhqa5YEfyra0rg7zZqy1s+796ZxbcmerXu42u/4nUmBQo6EXdYPoxyaKHoWb00R2MjrLsIKmKmW7EMvUC+9LZV/ntH5zQR3Gg0JY0wxwslGyx3Cysk8U1+Cu2DqwejltPgI2XYuTkkuZZef5Yx1LlLC1kQNhRAik1s87n9eGWwndMWVT5UkhVi5IZ4FgSZBVOXITITAatsSiJLVzkp/BE+lom6mWhlZ8u+wf0vb025lwJ1PXgxkDLe4k+HSfpRDsUmVnx6Yh+6ENEq+NUXGKKTPJ1GrWwRUh/F43r8aoOJpRSexvkN6yxlEXdq2aWyhYA2RaiTBN95rjJai6jwzo+Ccl8gs4fbrUWd0O+KX4zgdmm836urNJ3XNEDCWzxvUc69DrQDXxKVsgnrZctnO0UzO5rxE/0jZAb1SIMKJBG725CirhjyAZ9rMWu+clFXobXt/etQDvNagHL8ChEKtdIjM+dG63gCriNglq4Eesc9PeuRP3Xptp9dQZKpRdaV7kch5bgLdsqNs+eSZiDS3u7KeSpjveXSHuOr1s5UDcK2wbdzS4mw1QjkpCSxkMbHHFrJc91JJPscc6N+eg+CXh/qb/IsmSpDiGNs6t8NR7LdHce8i22WQalpKUBm7GX8zuVNmVyhqzRoQR0coum4KyLta8HIXlrQ6jdfWRAQt0Wk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2586.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(41300700001)(122000001)(86362001)(478600001)(966005)(83380400001)(33656002)(71200400001)(316002)(38100700002)(8676002)(38070700005)(7696005)(5660300002)(26005)(8936002)(2906002)(6506007)(52536014)(53546011)(110136005)(66946007)(186003)(9686003)(66574015)(55016003)(66476007)(66446008)(76116006)(64756008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tk9DV3lZZFlaZTcrNHpyY2FoTllwSUIrNG9FR0dJT3NpV3F5R3VmenBDcXNN?=
 =?utf-8?B?OEtFV1B5VU1RNXUwWnNUeG10Y2ZaOEpvN1NreFRPTmVwTnkrZVF3UWJHeFp6?=
 =?utf-8?B?UmorMjdPVnJaT1czM3BBUFA0Yk1iajdOeTFJYjlHOVNKbzBUcUw0UGtzU0hP?=
 =?utf-8?B?cyswRFlKVUZJeER4SzRaamR3NGJjSXhEaHVSSnFGSFMveXY2RDNFb1UrcThE?=
 =?utf-8?B?S1FGYmRHSmp0Ty9hQk5qd3JHUHlDanRFY2E4aTAwSVFYNFo4SzdmSmVCdTdx?=
 =?utf-8?B?NXM2ZnFCWWgvWXc3dGc1Kzk1VEhEaHJUeFd5cldjdUxlYi9EcldWSENWWkh4?=
 =?utf-8?B?Yzl2c3ZFT2doOXNqa2JqM0hST09weFdGNzFFY0JrWHB2VHlPOXN5bEZvejkr?=
 =?utf-8?B?aWZ6TGFLMWNRSzl4Z01RU0JwWFRQK21ZYUhKdjhWekpSZXgzOS9KNnZtOEJa?=
 =?utf-8?B?VHN5VUdTV0xzQ3UrYTk3b3ZZNEl0dDdtaXhmSzlMRTF5UVo1Vy8xc2dycmpj?=
 =?utf-8?B?NG11T0pPNGY5d0JvM0NzMXVESjJuOXVqOGIwNFJsQ2RoR1JQMjdlNk5KMGc1?=
 =?utf-8?B?ZlpjWXdGL3J5T3dFMG55K1NUSmV3cHlHN056bWswUFV3dmo4M2pWcDluQVlY?=
 =?utf-8?B?OWFkeXFQcVJ0Y2dVNGw2TC8xVUwvSXh3UTVDWFRkMjlJQTFPbkVFazBsZHdS?=
 =?utf-8?B?ZldMSE94NVMwT0F2Rnp5Wkk5MHpGRGxzWi9zNE1BOTY1WWN2djdlV1E5QXpM?=
 =?utf-8?B?MnhLUXhyZ0F4L3YwdklRclNaNENYR3lpTXpJMXJ6SmowSzlaNWR0bXlmaFlv?=
 =?utf-8?B?WmFxSGd5bjZuM3F6cW5TSER4RUlKMGJvWE11ODM2bklnOWZNRDJ1WEJWWjB5?=
 =?utf-8?B?R3dmN0tYUm13WUxGVVA0bDlRWXNXSkN2RnlZbU15SWVnczlpSUZMNE51R2RC?=
 =?utf-8?B?ZHpESVE3ZmNIZVdZYk5GQ1pLQVRTcm0xN3dxbmxhVE1od1VKMVlOMEpudkJ3?=
 =?utf-8?B?bDdWbE1najNwWkVDRjNyVXpGbmhYTTNxOE1zUmNUeUNtREIvUDhvZmZrMit4?=
 =?utf-8?B?b0tJRGptTDQwUVI4VW1jN1JuenJ3UGYwaDl2NEdGVTN1QzhudHZlc3I3Mlg0?=
 =?utf-8?B?aWdlVDNuWGt3OTBqTSs1V2Y0OGY0enp4WllXR2VDVTF5aDJMc3JLdnZkT084?=
 =?utf-8?B?UmlLRmczNkhjSUpyUHlvYVBpaGxPZFVXT1MxeXFPYjRhWGFWWGhlblhVeWtH?=
 =?utf-8?B?VWlmVWVnN2FCOExMOW5wTmRjQ1dxMWM0d1VhSkFjTkI0YklLRUp5T0ErNVNV?=
 =?utf-8?B?L2Y3SUFaNUpZZzJwUjB2WUt6d2dBZnFEd1lGREROcUQ4R1E1ZTk1cTV1UEJu?=
 =?utf-8?B?M1JoRU5wdTZqU0IydGtqcjBUN1R6TW04a2pYL0J4TjB4S3BvcS9uU21kUjdu?=
 =?utf-8?B?RnNsYU1NYWVJYVZESEZ5cTMzVVZRUHZPZUlyUW1rd01BNUp6Y0FTUmJScW1W?=
 =?utf-8?B?TVdZRG1lVndPck9XYVF1ajZ2ZWZyMHlRcmtQT29OQytTbm9iK2pWZjVUalZu?=
 =?utf-8?B?Und2MElycHRtQS9uNHNGZXhsZTFlcG51L25udXJvSGRKaTZ0WUdScTU2OGE1?=
 =?utf-8?B?a3RPVFVIcmRNbnpuYTBSclZzQSsrODV0MlhLMEwxZ0p4TVlrYklwaXJ5V1Vn?=
 =?utf-8?B?T29mby9tR3UwTU13Y3hENmlaTVB1SEFMREtxYUxFL0swRituMmtVVUNwSUFJ?=
 =?utf-8?B?U1pkR3FPSnpkL2pwVG5PUGtIc09NTmk3WElEQVlPaHdxcldFSUpRZHNaVWVF?=
 =?utf-8?B?cExFYWxvTjlUOGx3dUV4Y2JFOU1SZ0NyMGEwMG1rM1Q4MklZYnJnQjVqdkF3?=
 =?utf-8?B?SWpueWUrZVZUVHZLdEV5TDlOaXhMaWN6Q2o2OTVoZmtwTnZuUkpMSFZjMTds?=
 =?utf-8?B?b0ZhcGMwRSt2bS8wSm5KSnA2cjFIUCtWbUdJUG5zOHBZN2pNU1FMbCtsZzkr?=
 =?utf-8?B?aFNZdkdXcXJUazNyUmx1UlhGSVN3SXB0ZGhJOHBNVTg2WjdNeFZqeEpiT1BE?=
 =?utf-8?B?eFJyM3FwVUZHdU5zalEyV3JlM2taSEpPZ05IYnErcmpmbElHNGcwRXVnWTQr?=
 =?utf-8?Q?5bB/81QfcPZXFcPCc1T+1ZbVU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2586.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61a773d-72cf-4ac6-008e-08dad902cf56
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 09:58:51.7559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7VSc8TBMdNHKs3rupE0bvVbQHxHgwm9a83pakpcQDrdPJ/dSY4PwArMvWnbaUFrG9DBCLd8zBoac7QnsMH5r4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIENocmlzdGlhbiwgDQpodHRw
Oi8vZ2Vycml0LWdpdC5hbWQuY29tL2MvYnJhaG1hL2VjL2xpbnV4LysvNjIwNTIyIEluIHRoaXMg
cGF0Y2ggSSBzYXcgdGhhdCB0aGVyZSB3YXMgb3JpZ2luYWxseSB0d28gZXZpY3QgaW4gdGhlIHN1
c3BlbmQgYW5kIHRoaXMgcGF0Y2ggdGhlIHNlY29uZCBvbmUgKHRoZSBvbmUgYWZ0ZXIgaXBfc3Vz
cGVuZDIpIHdlcmUgcmVtb3ZlZC4gSSBhbSBhIGxpdHRsZSBiaXQgY29uZnVzZWQgb24gdGhpcywg
c2hvdWxkIEkganVzdCBrZWVwIHRoZSB3YXkgaXQgaXMgYW5kIGp1c3QgYWRkIGFuIGV4dHJhIGV2
aWN0IGluIHRoZSBiZWdpbm5pbmc/DQoNClRoYW5rcywNClNoaWthbmcuDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1
bWVya2VuQGdtYWlsLmNvbT4gDQpTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgOCwgMjAyMiA1OjMw
IFBNDQpUbzogRmFuLCBTaGlrYW5nIDxTaGlrYW5nLkZhbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IEFkZCBh
biBleHRyYSBldmljdF9yZXNvdXJjZSBjYWxsIGR1cmluZyBkZXZpY2Vfc3VzcGVuZC4NCg0KQW0g
MDguMTIuMjIgdW0gMTA6MjUgc2NocmllYiBTaGlrYW5nIEZhbjoNCj4gLSBldmljdF9yZXNvdXJj
ZSBpcyB0YWtpbmcgdG9vIGxvbmcgY2F1c2luZyBzcmlvdiBmdWxsIGFjY2VzcyBtb2RlIHRpbWVv
dXQuDQo+ICAgIFNvLCBhZGQgYW4gZXh0cmEgZXZpY3RfcmVzb3VyY2UgaW4gdGhlIGJlZ2lubmlu
ZyBhcyBhbiBlYXJseSBldmljdC4NCj4gLSBNb3ZlIHRoZSBvcmlnaW5hbCBldmljdF9yZXNvdXJj
ZSBhZnRlciBpcF9zdXNwZW5kMi4NCj4NCj4gU2lnbmVkLW9mZi1ieTogU2hpa2FuZyBGYW4gPHNo
aWthbmcuZmFuQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYyB8IDEyICsrKysrKysrLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IGluZGV4IDgxOGZhNzJjNjcwZC4uOGI3ZGI4
N2NmZmQ5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jDQo+IEBAIC00MTExLDYgKzQxMTEsMTAgQEAgaW50IGFtZGdwdV9kZXZpY2Vfc3VzcGVuZChz
dHJ1Y3QgZHJtX2RldmljZSANCj4gKmRldiwgYm9vbCBmYmNvbikNCj4gICANCj4gICAJYWRldi0+
aW5fc3VzcGVuZCA9IHRydWU7DQo+ICAgDQo+ICsJciA9IGFtZGdwdV9kZXZpY2VfZXZpY3RfcmVz
b3VyY2VzKGFkZXYpOw0KPiArCWlmIChyKQ0KPiArCQlyZXR1cm4gcjsNCj4gKw0KPiAgIAlpZiAo
YW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7DQo+ICAgCQlhbWRncHVfdmlydF9maW5pX2RhdGFfZXhj
aGFuZ2UoYWRldik7DQo+ICAgCQlyID0gYW1kZ3B1X3ZpcnRfcmVxdWVzdF9mdWxsX2dwdShhZGV2
LCBmYWxzZSk7IEBAIC00MTM1LDE0IA0KPiArNDEzOSwxNCBAQCBpbnQgYW1kZ3B1X2RldmljZV9z
dXNwZW5kKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIGJvb2wgZmJjb24pDQo+ICAgCWlmICghYWRl
di0+aW5fczBpeCkNCj4gICAJCWFtZGdwdV9hbWRrZmRfc3VzcGVuZChhZGV2LCBhZGV2LT5pbl9y
dW5wbSk7DQo+ICAgDQo+IC0JciA9IGFtZGdwdV9kZXZpY2VfZXZpY3RfcmVzb3VyY2VzKGFkZXYp
Ow0KPiAtCWlmIChyKQ0KPiAtCQlyZXR1cm4gcjsNCj4gLQ0KPiAgIAlhbWRncHVfZmVuY2VfZHJp
dmVyX2h3X2ZpbmkoYWRldik7DQo+ICAgDQo+ICAgCWFtZGdwdV9kZXZpY2VfaXBfc3VzcGVuZF9w
aGFzZTIoYWRldik7DQo+ICAgDQo+ICsJciA9IGFtZGdwdV9kZXZpY2VfZXZpY3RfcmVzb3VyY2Vz
KGFkZXYpOw0KPiArCWlmIChyKQ0KPiArCQlyZXR1cm4gcjsNCj4gKw0KDQpBcyBub3RlZCBpbnRl
cm5hbGx5IHBsZWFzZSBrZWVwIHRoaXMgZXZpY3QgcmVzb3VyY2VzIGNhbGwgd2hlcmUgaXQgd2Fz
Lg0KDQpJdCBtYWtlcyBzZW5zZSB0byBldmljdCB0aGUgQk9zIHdoaWNoIHdlcmUgcHJldmlvdXNs
eSBwaW5uZWQgYnkgZGlzcGxheSB3aXRoIHRoZSBTRE1BIGVuZ2luZS4NCg0KT25seSB0aGUgZmlu
YWwgZXZpY3Rpb24gb2YgQk9zIGZvciBmdyBldGMuLiBzaG91bGQgYmUgZG9uZSB3aXRoIHRoZSBD
UFUuDQoNCkkgc3VnZ2VzdCB0byBhbHNvIGFkZCBhIGNvbW1lbnQgdG8gZWFjaCBjYWxsIGV4cGxh
aW5pbmcgd2h5IHdlIG5lZWQgaXQuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4gICAJaWYg
KGFtZGdwdV9zcmlvdl92ZihhZGV2KSkNCj4gICAJCWFtZGdwdV92aXJ0X3JlbGVhc2VfZnVsbF9n
cHUoYWRldiwgZmFsc2UpOw0KPiAgIA0K
