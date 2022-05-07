Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E8BC433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  7 May 2022 01:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB4F10F2E0;
	Sat,  7 May 2022 01:36:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3FD10F2E0
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 May 2022 01:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nInXfwoBu67RRlqihu8XosC0sCblBhK/lkMpCaNiuWSg7rDbcvQuTw/n+Fe051k8fnwSRF05wZ5Y+jaR5MEv0/nZ5BH0NKEcYUf83Qic8rBI1pbgpe37PGwuAVWae9iq/BIdpr1GYlLAP0KOQZak3fDN+SiDEP85GDUr/ImZRvxuMHk2hc7c/dTQBod0ruMvbr4FsmpDEBrElgTXEp0CBvL2nEdxV0hvUBzNQlw7C0XKqG/I9hMu0cK3/ueNYm+p249GbtE1F0E0OY2LBvDXFchwDKdIDzZ3kb8jCEt//1UnBB+KLjoTJ1VQoDTYKBLF9LA83p/61u8VVJpmcsckbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3pDDJJvyHaDWy7EGVoEsO9WEDiRL0VYzcE4arAKzxA=;
 b=JS1N518oNrZalmb34XRKup/l7/GaOw/GCevn17owhB2LF3/1DWwagaShuma15T43WciLbM4hSHqNJstoRtsWTXDR36AccJBjlMJYrZSwlR3rP6bUvZ5GPvSq0N4M4m2ukrDpAkU0rmjFNe1ePX1KrI6547aFexs05TWoClfcofzF1ZRbLV0m36XXift5CuIXktt4HkPqYyT031yRpNKdydgeoOgddrpWLXhwoYRZE4m9AuWSFXglJQ3MdHPlyA4p59xxUA0THzdYi8COfIOH0ttr0s8PwGjYiDW7BnKRZWMAiosUBVR0SUgVbCHuG55Osy7A2KBdl9ublepURVj9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3pDDJJvyHaDWy7EGVoEsO9WEDiRL0VYzcE4arAKzxA=;
 b=3vw+8ulhnkQFgg50e50Oqp+KccgxYOf8DsRAVeRfG1/5Amu5z3JSLk4ll4jsVQEPWQuGTXBQCj3FgvzIvAi3Z5W5vp+CDkqL4RqB+RTM2qQ00TWZPbz9v7YOL9051MPESFuPH0TR5cf2DinuRV71OfAdEIQJmxXmjCtZMBo1C70=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Sat, 7 May
 2022 01:36:26 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::9c68:a1fd:1445:49ad]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::9c68:a1fd:1445:49ad%4]) with mapi id 15.20.5206.025; Sat, 7 May 2022
 01:36:26 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBkcm0vYW1kZ3B1OiBtYWtlIHNtdV92MTNfMF83X2No?=
 =?gb2312?B?ZWNrX2Z3X3N0YXR1cygpIHN0YXRpYw==?=
Thread-Topic: [PATCH] drm/amdgpu: make smu_v13_0_7_check_fw_status() static
Thread-Index: AQHYYVZHcOAODXubTEekkGvnBHzW9a0Sowai
Date: Sat, 7 May 2022 01:36:26 +0000
Message-ID: <DM4PR12MB51658D3DB330A3CCB6C6ABFC8EC49@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20220506143318.2467559-1-alexander.deucher@amd.com>
In-Reply-To: <20220506143318.2467559-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-07T01:36:18.5340006Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0379bf21-8c2c-4826-0d72-08da2fca007d
x-ms-traffictypediagnostic: MN0PR12MB6125:EE_
x-microsoft-antispam-prvs: <MN0PR12MB6125F944E33647E203AA8A638EC49@MN0PR12MB6125.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: idOz2XAPvwn7ocy7JY8WuN09hq8zivbxIhdrb3xDE1D1JTC0fLTWB5Ct+hIhuODt0i/xv8S37gHXa3R/6LoOfgHlyweeu6k+wXgjpKcL58ExasvPEjT+GTPryKn81TVEbcG+1T1pkv3poDPqXE1jx7BQ9acOmvHJhESE466+F3KUuK6JcelGiJmVXKRzLJYCMo5pKV7z1L0ioQQFkm+5FTFCB16Lo3uRGd1UDQ9Q/gx59CKL8E79NNbSVVmE++NdyHtVEFc50LkDBX7CAofy4CbFrqW165GboSj0Q41BLB4NPeBvwTx7wU6ssdp1X6ytST2PgQrm+lung8MfY7aHuD27/6nF7SJuHqbuMJ+aPcXMuNu+hBuwRVxm1Zug7y8DpE/1ut9hK2FzQ9by6++Iv1UntRNphtrn2f+QbHUoCmwdJKLaZfoJN/kfpLlPbMtiRbA/AdWm9Y9C3D5jfJj0qNcQQ41+y+pLEnToF2ivjuF/KTUZ8qdSKXua86EoPnP3cC35R1ChC96kI4WQWEydgpo122w6+qi3nSrKeRBbAnpwpmIRfRrJR6UBQQLewsGz+9al3xQ4f4UMuFcDWlTspH2Qiot6JVtHQfSlm8wMK9clNJO2GeDE2OeaESiSoNwAOEqddtaWmTcY5dHmuivA7w/jhAfWsn1fEsZrDD3eckOt5BJcHm240/VawYNvUyz8reDzECw+12CHJX+7vis2hg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(5660300002)(508600001)(83380400001)(2906002)(110136005)(8936002)(66446008)(66476007)(71200400001)(64756008)(52536014)(316002)(4326008)(66946007)(91956017)(224303003)(66556008)(76116006)(9686003)(33656002)(186003)(7696005)(6506007)(38070700005)(38100700002)(86362001)(55016003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dVpjMTloQVJsRHhnMHVNc3V5cG1aSC9xemZIT2lyYXRvZEFvOVNhS2JtbFM1?=
 =?gb2312?B?bWJHdVpGNHRIVnR1MG8wTk5rbjJ3TWUwYlFXeFFHMEIxSko5cWhNUE9JcDFS?=
 =?gb2312?B?UTJrRlRPdGxTK0VtYkRjRjFPNDVGaTlHSW9laXVnYXNqS2dMV3NNWjgzc3g5?=
 =?gb2312?B?UGhGWHJrUzlSZDI2NlU1QnB2ZFVEdkVabDFMOFlLSDhmYkxZUnM0SXBSejV6?=
 =?gb2312?B?Z2dKOFRRcXN0ampkek5jTWdzZS80bVorcm4wNGNqWGJrWkRpd0VpbmhnSXkz?=
 =?gb2312?B?N3h2MFh0STJacUFHT0ovYndrejZvZXRFVmlOU1VvYUZlRnV5Tkx4VitRTHhO?=
 =?gb2312?B?MVAydE5FSG9Hckw2QjVSQnFzYXM1ZXpwNk5nN0lMZFpubGVlN3hWUWdMekQ5?=
 =?gb2312?B?dUkrQkl3SUhOV1N2WTBPZ2JOVUF4bERrNlZPQVJZaFNMV2FWdGwxS3NNYXNF?=
 =?gb2312?B?aUN0RUtyaVQxd015NGdYalNWWjdzNytIS0d2NUFacWNwZ0xtdXFOZ2pqdUZT?=
 =?gb2312?B?aHZzOURCQ3I2RlB1RmtyazNmc3A1WXdoL3BiSFRCdDdLVHlCYTAxUFhIeWVG?=
 =?gb2312?B?YzBWSkVpQW1MUExHQkpXek5OOHEzSmM3QWZ0cENwcFRTQTFJVmhBWENwYjVk?=
 =?gb2312?B?WEhMemQ3aUkxSjJVR0R5a0pPN3Q1cmFPRnF3VzhHVkRCYWFpOElybHpTVkww?=
 =?gb2312?B?Zk40aUpDSXZrbjIxSWtFK2tWdGc3UWZnN2xyeTVnMU1tcFFvRG5uNnlhZnN1?=
 =?gb2312?B?ZHZGNmRITUNtMnlXaVFqblNhMjNSbFRPMFV2bi9MU05ydmN5OTlBS2ViVUUx?=
 =?gb2312?B?bXp4bUFmMjQ0N3hRSUk4Q3RoWEljTlhhRm1yb29jRGtIZmZYWTFpZmlwVlho?=
 =?gb2312?B?UU5hcmJCZlM2RytWZ3d6YXhhQ0Z0ZDNCM09YU25RbEYwbjFmemxiUnJPNFdl?=
 =?gb2312?B?VWd2TWpaM252eHJkL2tWUjNnN0NkaFhxRE8zeFg2TkpZdTJmRzF3MGY3VXRK?=
 =?gb2312?B?NHE2MXBlU0dHNDcrVUlCcTQ0UkpaRmVFcnNMckp5NkRva2VBMHl4eWtHTXFo?=
 =?gb2312?B?bzRxaVYwcWQxa3JzZWZidnE2U2NNZlBLMEtqN296NTRYZGVYUWxCQVpIT2d1?=
 =?gb2312?B?a3VtdnZUZWtqUWt1RUVGYm9rQXViSUxJK05YeER5MWxjREJwaVNyOXZZRmFY?=
 =?gb2312?B?VENuUS9wS2t2NlZ3UG9oM0k4NzUxZk1EbFp6bTFaQTJ0NndqZmJVbFFSNmh4?=
 =?gb2312?B?Y1lWRFFLU3dZZDhJZ054Y3Qvdk1RRTN4VXRENlFUSCszR2ZEUnN0SldDSHhh?=
 =?gb2312?B?WXJWelN5bXhWRFZGZjBIYjVHbWozTnZIUFpwd0Y1bisvcXUwVTZuYUtWc2cx?=
 =?gb2312?B?WHlSTHcyT1Boc2N2anlrYnVWTEplN1p1cWlScEVhbTNwN1psZ3VEbnhwMTY0?=
 =?gb2312?B?ZWQ5Qm10M3F2SWo2N3RoRm85cGc0WVZRVGxCV0Q0eUFFK1ZGVWI1RVZ0UmJF?=
 =?gb2312?B?dVU1akFCRXdvU2lFZm4zckN2ajRwMnk3U0VMZ25wNy9qRU1aQkd2ZlRWc1RQ?=
 =?gb2312?B?MHMwTnJFVHg2YnRVR3QramNlK1ozMkp4QXg5UFBBWklnSDdDNUdEYitjWTNU?=
 =?gb2312?B?SkpUTktZTlRWYlF0aEg4YnBPdlNueWp0VTZsbGRhN2F2UkNKdmRSUmpoWGwr?=
 =?gb2312?B?dE1ua1dzTDV6V3lQRjVkckJwMjN5VkhYdHUvb3BpYmpUZFdWWnFrNHU1SzdM?=
 =?gb2312?B?UnVKR1FZM2NLTUZiQ3c4Znl4ZHM5U2I0K0xyYXc4cEdoMUZXY01uWlcwRndJ?=
 =?gb2312?B?QS9BdTFjdUVZd21BUno1STd5TEdkTk81TmRlS1RVSVJtTkpNczBJNmRrSENV?=
 =?gb2312?B?bitvK1JwSWFNcy9vZFVSZGhUOUpaNE5ZQVVvR1psSmE0Y1F2dkxiYXNYQUlz?=
 =?gb2312?B?VUVpZVo1bzNOWHlTeDFKWlZHdWJKd2pza1NrZ1MrbE1iTkNkUFNaQktrY3Zt?=
 =?gb2312?B?M1BaMU1GTXhmS29CSTloUU9mQU8wdzFtRndKZzQxbG5sWGo1YmRpK0IzSThD?=
 =?gb2312?B?czNDSGc5Nk5LdmoyTlNQOFA0RWZYWVNtc3QvYmZQeWNWOVJTYWV2RUlMNHhT?=
 =?gb2312?B?TCtlU0hvY3ZUQ2QvcmpIYUIxMFNCK1ViZ0wvclZOK0poMUZIYnNTNU9nTVlw?=
 =?gb2312?B?SVhGNGkxakJVSE1EMGhCS2ZpcG9GdDBYLzJpdXZqeEh2bFFnUFRBb2tRenVq?=
 =?gb2312?B?b3B3Qk1BZU4zMHlsNTdEQkd4OFU3WHV4YzlSS2N5TTRFaG9OQTIrRmJpeUM1?=
 =?gb2312?B?cHJ6cEdiWWU5dkJPU2pVS0twb3RuWGNsUDRseGovN2xPbmppTTVRZEVQSmp5?=
 =?gb2312?Q?wxeIr/Kdu8vm4YTKgQuTVbEJ/4igJioYNNG1cFnrFXbNc?=
x-ms-exchange-antispam-messagedata-1: jeDxYEDvGI2I7g==
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB51658D3DB330A3CCB6C6ABFC8EC49DM4PR12MB5165namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0379bf21-8c2c-4826-0d72-08da2fca007d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2022 01:36:26.3972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R556qo/XIJe5dTuhz1Lk+Obz7sbYw8yDYameg9mwCtM1HyQ+I4vrN0sWAycU9sYs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB51658D3DB330A3CCB6C6ABFC8EC49DM4PR12MB5165namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBLZW5uZXRo
IEZlbmcgPGtlbm5ldGguZmVuZ0BhbWQuY29tPG1haWx0bzprZW5uZXRoLmZlbmdAYW1kLmNvbT4+
DQoNCkJlc3Qgd2lzaGVzDQpLZW5uZXRoIEZlbmcNCg0KDQq3orz+yMs6IGFtZC1nZnggPGFtZC1n
ZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+ILT6se0gQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KyNXG2jog0MfG2s7lLCAyMDIyxOo11MI2yNUgMjI6MzMN
CsrVvP7IyzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcgPGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPg0Ks63LzTogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPiwga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQrW98ziOiBbUEFU
Q0hdIGRybS9hbWRncHU6IG1ha2Ugc211X3YxM18wXzdfY2hlY2tfZndfc3RhdHVzKCkgc3RhdGlj
DQpbQ0FVVElPTjogRXh0ZXJuYWwgRW1haWxdDQoNCkl0J3Mgbm90IHVzZWQgb3V0c2lkZSBvZiB0
aGUgdGhpcyBmaWxlLg0KDQpSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRl
bC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNf
MF83X3BwdC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUx
My9zbXVfdjEzXzBfN19wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMv
c211X3YxM18wXzdfcHB0LmMNCmluZGV4IGNmNTgwMDgyMjE3NC4uOTk0OWVlM2FlMDkwIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19w
cHQuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBf
N19wcHQuYw0KQEAgLTI5MSw3ICsyOTEsNyBAQCBzdGF0aWMgaW50IHNtdV92MTNfMF83X3N0b3Jl
X3Bvd2VycGxheV90YWJsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkNCiAgICAgICAgcmV0dXJu
IDA7DQogfQ0KDQotaW50IHNtdV92MTNfMF83X2NoZWNrX2Z3X3N0YXR1cyhzdHJ1Y3Qgc211X2Nv
bnRleHQgKnNtdSkgew0KK3N0YXRpYyBpbnQgc211X3YxM18wXzdfY2hlY2tfZndfc3RhdHVzKHN0
cnVjdCBzbXVfY29udGV4dCAqc211KSB7DQogICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2ID0gc211LT5hZGV2Ow0KICAgICAgICB1aW50MzJfdCBtcDFfZndfZmxhZ3M7DQoNCi0tDQoy
LjM1LjENCg==

--_000_DM4PR12MB51658D3DB330A3CCB6C6ABFC8EC49DM4PR12MB5165namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"DengXian Regular";
	panose-1:2 11 6 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:DengXian;
	color:windowtext;}
span.searchhighlight
	{mso-style-name:searchhighlight;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span class=3D"searchhighlight"><span lang=3D"EN-US"=
 style=3D"font-size:11.0pt;font-family:&quot;DengXian Regular&quot;,serif;c=
olor:#070706;background:#FFEE94">Reviewed-by</span></span><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;DengXian Regular&quot;,seri=
f;color:black">:
 Kenneth Feng &lt;</span><span lang=3D"EN-US"><a href=3D"mailto:kenneth.fen=
g@amd.com" title=3D"mailto:kenneth.feng@amd.com"><span style=3D"font-size:1=
1.0pt;font-family:&quot;DengXian Regular&quot;,serif;color:#0078D4">kenneth=
.feng@amd.com</span></a></span><span lang=3D"EN-US" style=3D"font-size:11.0=
pt;font-family:&quot;DengXian Regular&quot;,serif;color:black">&gt;</span><=
span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Best wishes<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Kenneth Feng&nbsp;<o:p></o:p></=
span></p>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"col=
or:black">=B7=A2=BC=FE=C8=CB</span></b><b><span lang=3D"EN-US" style=3D"fon=
t-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
> amd-gfx
 &lt;amd-gfx-bounces@lists.freedesktop.org&gt; </span><span style=3D"color:=
black">=B4=FA=B1=ED</span><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;color:black"> Alex Deucher &lt;alexander.deucher@am=
d.com&gt;<br>
</span><b><span style=3D"color:black">=C8=D5=C6=DA</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black">
</span><span style=3D"color:black">=D0=C7=C6=DA=CE=E5</span><span lang=3D"E=
N-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">, 20=
22</span><span style=3D"color:black">=C4=EA</span><span lang=3D"EN-US" styl=
e=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">5</span><span =
style=3D"color:black">=D4=C2</span><span lang=3D"EN-US" style=3D"font-famil=
y:&quot;Calibri&quot;,sans-serif;color:black">6</span><span style=3D"color:=
black">=C8=D5</span><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri=
&quot;,sans-serif;color:black">
 22:33<br>
</span><b><span style=3D"color:black">=CA=D5=BC=FE=C8=CB</span></b><b><span=
 lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:b=
lack">:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&q=
uot;,sans-serif;color:black"> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lis=
ts.freedesktop.org&gt;<br>
</span><b><span style=3D"color:black">=B3=AD=CB=CD</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> Deucher, Alexander &lt;Alexander.Deucher@amd.com&g=
t;,
 kernel test robot &lt;lkp@intel.com&gt;<br>
</span><b><span style=3D"color:black">=D6=F7=CC=E2</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> [PATCH] drm/amdgpu: make smu_v13_0_7_check_fw_stat=
us()
 static<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">[CAUTION: External Email]<br>
<br>
It's not used outside of the this file.<br>
<br>
Reported-by: kernel test robot &lt;lkp@intel.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
index cf5800822174..9949ee3ae090 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
@@ -291,7 +291,7 @@ static int smu_v13_0_7_store_powerplay_table(struct smu=
_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
<br>
-int smu_v13_0_7_check_fw_status(struct smu_context *smu) {<br>
+static int smu_v13_0_7_check_fw_status(struct smu_context *smu) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D s=
mu-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mp1_fw_flags;<br>
<br>
--<br>
2.35.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB51658D3DB330A3CCB6C6ABFC8EC49DM4PR12MB5165namp_--
