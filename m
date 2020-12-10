Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEDFC4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 09:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1177235F7
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 09:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1177235F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 216C06E400;
	Thu, 10 Dec 2020 09:41:03 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760048.outbound.protection.outlook.com [40.107.76.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D48FD6E400
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 09:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmfgQVMHjQj8f1ZWh9DMLZD6SArnr3GQAim4knKOJbDhe65MOXt+3Gbe10s8QvM8zbQMs3bYU2DJPxqoc125M4GLGjJmLjGTUgnuAjaKy+uvDBVnC20LbFM1qdcoqXA0Bt3AyU2Mt+DS8PCGoLWYckgCmMxgbLSJZWQiT8sI+/v48sEs6nS3ODj0qWDpXYFMOPUF3RL23QGu5cxjlikg68ocaBvdmqEz96zAHpSUM31a3+SuS3B/9bpq3v1/1iQ3A5rYgELBglg/WbODZFjSzEpKFdiBGb1D//DCzDuhuPieLdH4q3XswFH5BZJJnLebpfZ3h/UaHkTtS57QCPi8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXGwcsb8P4PgWljp3Gz6DYZlr1GXgxzL1TbcPZAktCo=;
 b=E1aFJpYITF3Af7wurfv30GNGsBw2IUyTgVfNnKBll0ONOzyzS830gv5eh6ItqxkfbfwY758tudDzcB768HQWEhDVWQOro5mDcptjuR+jQsEi0MYexLfm9yGYDTZBj3tTHibjOTicATbn1GJOYvnTMbQca1tBooK5T0AtEszvHBjNrdWSZzZftRjDmBsR5ZmS+aFEikr+iRhf43XstyC9QYtnLeK3cstPvVc2j/bMCEZAIvEaSS1vyoWPgQp9Ua08R4eFkhCbOzr1CFJu1CeLq4CYjgUQE1veY535F3WMmXfoHqgfgzP+MRpcAimxBb+OfYFO1kZzYGFj8hmBzA/3Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXGwcsb8P4PgWljp3Gz6DYZlr1GXgxzL1TbcPZAktCo=;
 b=noNyWOxSbHvg/zhrA/hHFm1kgG1sNmeTVtLOFlnE2d1szOIMiAfQRck0LQWk4YFN+9mSnRw86BBJb2AZkUnlKIdVtej8HpXPRUb22bKk7Ocn/maZjhN52ZuyfXccv+E4ngKuVWrLUBL3p17yAImfBPG67DeqPTGLIXfN83guP3A=
Received: from BYAPR12MB2967.namprd12.prod.outlook.com (2603:10b6:a03:d5::24)
 by BYAPR12MB3512.namprd12.prod.outlook.com (2603:10b6:a03:134::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Thu, 10 Dec
 2020 09:40:58 +0000
Received: from BYAPR12MB2967.namprd12.prod.outlook.com
 ([fe80::4d46:f48e:92dc:5e72]) by BYAPR12MB2967.namprd12.prod.outlook.com
 ([fe80::4d46:f48e:92dc:5e72%4]) with mapi id 15.20.3564.041; Thu, 10 Dec 2020
 09:40:57 +0000
From: "Liu, Cheng Zhe" <ChengZhe.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu, Monk"
 <Monk.Liu@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Return -EINVAL when whole gpu reset happened
Thread-Topic: [PATCH] drm/amdgpu: Return -EINVAL when whole gpu reset happened
Thread-Index: AQHWzhBApQutOAWMEka9xMqxDtvSuKnuicYAgAEPC+CAAHi2gIAAApYw
Date: Thu, 10 Dec 2020 09:40:57 +0000
Message-ID: <BYAPR12MB2967353F8880B45E27374E2A93CB0@BYAPR12MB2967.namprd12.prod.outlook.com>
References: <20201209094652.192633-1-ChengZhe.Liu@amd.com>
 <75590f2b-019e-b6d3-7a8e-be11e3564f57@amd.com>
 <BYAPR12MB29677B831AC49217B288D20393CB0@BYAPR12MB2967.namprd12.prod.outlook.com>
 <379bccc0-2f1a-722c-a8d3-cc06079f0985@gmail.com>
In-Reply-To: <379bccc0-2f1a-722c-a8d3-cc06079f0985@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Monk.Liu@amd.com,Horace.Chen@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-10T09:40:16Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=de739875-0772-4230-bcaa-0000d135f5a9;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-10T09:40:53Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 011a54bd-4039-495a-90d9-0000b6836df2
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94c0d578-394d-4afc-c878-08d89cefb290
x-ms-traffictypediagnostic: BYAPR12MB3512:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB35122DE2B9AB4BA6AC2636E993CB0@BYAPR12MB3512.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zaexfF5RRC5WOzBmF420v9DHFRK3r/WIFjlxsJJB1/q7QE85ghFgWutK4KAYVlNs9FbwLla3UwROvGUXMVernLU9p0TZPmzPk4+zJEeP1DjolRNDVddCi0njVeuAdqaDqH5QefyieIPthMmNPJX21W7Yok+wtaCo/YKIXsPgNhtOn6t7Q2+7QMucN7Bfln6Yy3ANHYAkgv1WUUOYaHvZy9x5GAaYeRu1f7Ld9edgNa7X2ZhgqOgUB62jdJVNS6lU0FLDpu0a1mFqQkkyRSHce1qRFIWRuR6WguakWXUboOE6HIwcB0fyjZ/FySAI3x6Tno28HnhL4ojz78ZRcBEU5c33jXSgZtwUwI1isQurMtYp2mbkUJ/lXe+rXVDvW0dwObssWJLaIBm1TRGPEuvsoQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2967.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(508600001)(71200400001)(6506007)(53546011)(5660300002)(66476007)(52536014)(966005)(76116006)(66446008)(64756008)(110136005)(26005)(186003)(6636002)(66946007)(33656002)(66556008)(66574015)(8676002)(83380400001)(2906002)(54906003)(4326008)(55016002)(8936002)(86362001)(9686003)(7696005)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?MmVkcy9DZ1dTVG5hbTJMWUhOOTVZK2QwcHhvRXNObFZMVjBsU3dxRFlDUklE?=
 =?utf-8?B?N2RmU3VMT205cXJvaEg1YitZVUZ4M3JVd1BmUDNuLzdwNDRLb1hHZnJXRElp?=
 =?utf-8?B?dXdJNVJhb29Zb0djYmNreVh1T2RUeW9Jby9LS1BLMFV0a1luWEFmOVJnSWxW?=
 =?utf-8?B?SzFWemkxVTNNOG5iZUZhS3VMM1p6L1I0b2N4TW95TXNXb2xYODNNcDFhU0ZP?=
 =?utf-8?B?SU9WUUdDOTkxQitBRFBROWxSbjViZXRJUk1KZENjZnQ5SHpDT0pZbFpIT0N3?=
 =?utf-8?B?emxkeXVCSHhUT2cxYnpYVllnd1E2ZHk2eVRkYUlkYlZVa1NGbmZIUFZtZy9R?=
 =?utf-8?B?eHk5a1dEK0RqdkxBWUhSb1B6T0FmeUU3TlIwdG5ZOHdYQTNjSjBXZXhwbVVE?=
 =?utf-8?B?QURVaHpPODErblhRTmVKSEZNclVoanJRMklqb0JsVHlvRUV4NVhvMVFkSlRD?=
 =?utf-8?B?cmtWd0ZTa2svL1JWQW5IeGtzaVRZWVUrZXVVQjVld2dkdUZOQTFwbDdubGxp?=
 =?utf-8?B?WUloZWdNZitKalJ4OHFKT3JNVHgrRUpHWWhKYTZDVUdORVlURjBiV3hjTGdQ?=
 =?utf-8?B?cW5qOUxOeFNJZ3kzVlpWQXpWRXZtM001Q29lbERqdGR3a1NwYW93b0RHRmJQ?=
 =?utf-8?B?eDY2RlFxUFBvY0F0R1ZwRndBcnI1QmhDVjNjaEhGdHJLNWVpNnhDSE1XdU1x?=
 =?utf-8?B?TUZIaXk1bm1uQXJwMGUzT25yMUMyL1Z2UDVEcytvUWVuakN5Q3k3ZDRGbU51?=
 =?utf-8?B?NmFoMzJLSVZ5NWo2SEhPdkNrUDhNY2kwUVRsajloeFpTVXRhY0FKZ0tKV1Bw?=
 =?utf-8?B?ZW9IMExpUEZqNXJuOGNnYmREMHJ1MVc0TWVNUi9LQVZBM0duQWxxL1JYRERi?=
 =?utf-8?B?SDg3UUlDRjdPMzhIM2Z5bCtQbTVBV3F3M2NXS1RkYzdMa1pPN1dMZkEzalJO?=
 =?utf-8?B?dzY2a1ZUaXFmdkRlQ2s1aFBsYjJTZCs0SE5mQVJYQU5iMkd3UlVraU45UkNm?=
 =?utf-8?B?RHprTTh0eGtXbmdHVWF4L0tENHpuU3h2bTI1SXZhSFN1T3lNUTZtTmRORlcy?=
 =?utf-8?B?d09oTVZTNHowWk14bTRnNlFDRjVBYk9FaFhHUVVQdTNWdFZuUWZDOFg2SnFB?=
 =?utf-8?B?d0RHZGFiKzdiRFJGejJjd3JjRXNWZmFTdmVya2kweEF0djNkby9MVCswaHJv?=
 =?utf-8?B?NDlUeE5rS2xpQ3hFVGozY29pSnhtZW8xTFBNWUtjb21IQjVEcmZXcGtNLzln?=
 =?utf-8?B?OVZ4M2dHaFRMelNsZWY4Y3k4bXVnV3BiN1p2dUlUVDFiM3I5OE9WUnFhbjJk?=
 =?utf-8?Q?4hlEn/UpgeL4w=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c0d578-394d-4afc-c878-08d89cefb290
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 09:40:57.7586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pvc526ZRq3ibm/YNYXRIk3SCkT+YzXHMD3Dv+u1lvg+Pr7lkOHSIAVV+Lm3pSxhxujNTdtjAaDpujmewQ4da2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3512
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpIaSBDaHJpc3RpYW4sIA0KDQpJIGRpc2N1c3NlZCB3aXRoIEBM
aXUsIE1vbmsgYW5kIEBDaGVuLCBIb3JhY2UsIGl0IGhhc24ndCBkZWNpZGVkIHlldC4gIEknbGwg
YWRkIHlvdSBhbmQgQWxleCB0byB0aGUgbWFpbGluZyBsaXN0LiANCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJr
ZW5AZ21haWwuY29tPiANClNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAxMCwgMjAyMCA1OjI5IFBN
DQpUbzogTGl1LCBDaGVuZyBaaGUgPENoZW5nWmhlLkxpdUBhbWQuY29tPjsgS29lbmlnLCBDaHJp
c3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQpDYzogWGlhbywgSmFjayA8SmFjay5YaWFvQGFtZC5jb20+OyBYdSwgRmVpZmVpIDxG
ZWlmZWkuWHVAYW1kLmNvbT47IFdhbmcsIEtldmluKFlhbmcpIDxLZXZpbjEuV2FuZ0BhbWQuY29t
PjsgVHVpa292LCBMdWJlbiA8THViZW4uVHVpa292QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBZdWFuLCBYaWFvamllIDxYaWFvamllLll1
YW5AYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQpTdWJq
ZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBSZXR1cm4gLUVJTlZBTCB3aGVuIHdob2xlIGdw
dSByZXNldCBoYXBwZW5lZA0KDQpIaSBDaGVuZywNCg0Kd2VsbCB3aXRoIHdob20geW91IGRpc2N1
c3NlZCB0aGF0PyBTdWNoIGRpc2N1c3Npb25zIHNob3VsZCBoYXBwZW4gb24gdGhlIG1haWxpbmcg
bGlzdCBhbmQgYXQgbWluaW11bSBpbmNsdWRlIEFsZXggYW5kIG1lLg0KDQpBbnl3YXkgYXMgZGlz
Y3Vzc2VkIGJlZm9yZSB0aGlzIGlzIG5vdCBhY2NlcHRhYmxlLiBXZSBhbHJlYWR5IGRpc2N1c3Nl
ZCB0aGlzIHllYXJzIGFnbyBhbmQgdGhlIGJlaGF2aW9yIGlzIGZpeGVkIGFuZCBub3QgY2hhbmdl
YWJsZS4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KQW0gMTAuMTIuMjAgdW0gMDM6MjUgc2No
cmllYiBMaXUsIENoZW5nIFpoZToNCj4gW0FNRCBQdWJsaWMgVXNlXQ0KPg0KPiBZZWFoLCB3ZSBk
aXNjdXNzZWQgdGhpcyBpc3N1ZSBhZ2Fpbi4gV2UgdGhpbmsgaXQncyBiZXR0ZXIgVU1EIG1ha2Ug
c29tZSBjaGFuZ2VzIGluc3RlYWQgb2YgY2hhbmdpbmcgaW4gS01ELiBJZiBGTFIgaGFwcGVuZWQs
IGl0J3MgT0sgZm9yIFVNRCBjcmVhdGUgbmV3IGNvbnRleHQgYW5kIGNvbnRpbnVlIHRvIHN1Ym1p
dCBqb2JzLg0KPiBIb3dldmVyLCBpZiBCQUNPIG9yIG1vZGUgMSByZXNldCBoYXBwZW5zLCBvZiBj
b3Vyc2UgVU1EIGNvdWxkIGFsc28gc3VibWl0IGpvYnMsIGJ1dCB0aGVzZSBqb2JzIGNhbid0IHVz
ZSBhbnkgcmVzb3VyY2UgY3JlYXRlIGJlZm9yZSB0aGUgcmVzZXQsIGluY2x1ZGluZyBwYWdlIHRh
YmxlLg0KPiBCZWNhdXNlIGFsbCB0aGUgY29udGVudHMgaW4gVlJBTSBoYXMgbG9zdCBhZnRlciBC
QUNPIG9yIG1vZGUgMSByZXNldCwgd2hpY2ggaW5jbHVkaW5nIEFQUCdzIGJ1ZmZlci4NCj4NCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENo
cmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciA5LCAy
MDIwIDY6MDYgUE0NCj4gVG86IExpdSwgQ2hlbmcgWmhlIDxDaGVuZ1poZS5MaXVAYW1kLmNvbT47
IA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogVHVpa292LCBMdWJlbiA8
THViZW4uVHVpa292QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgDQo+IDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPjsgWGlhbywgSmFjayA8SmFjay5YaWFvQGFtZC5jb20+OyBaaGFuZywg
DQo+IEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFh1LCBGZWlmZWkgPEZlaWZlaS5Y
dUBhbWQuY29tPjsgV2FuZywgDQo+IEtldmluKFlhbmcpIDxLZXZpbjEuV2FuZ0BhbWQuY29tPjsg
WXVhbiwgWGlhb2ppZSANCj4gPFhpYW9qaWUuWXVhbkBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBkcm0vYW1kZ3B1OiBSZXR1cm4gLUVJTlZBTCB3aGVuIHdob2xlIGdwdSByZXNldCAN
Cj4gaGFwcGVuZWQNCj4NCj4gQW0gMDkuMTIuMjAgdW0gMTA6NDYgc2NocmllYiBMaXUgQ2hlbmda
aGU6DQo+PiBJZiBDUyBpbml0IHJldHVybiAtRUNBTkNFTEVELCBVTUQgd2lsbCBmcmVlIGFuZCBj
cmVhdGUgbmV3IGNvbnRleHQuDQo+PiBKb2IgaW4gdGhpcyBuZXcgY29udGV4dCBjb3VsZCBjb25p
dG51ZSBleGV4Y3V0aW5nLiBJbiB0aGUgY2FzZSBvZiANCj4+IEJBQ08gb3IgbW9kZSAxLCB3ZSBj
YW4ndCBhbGxvdyB0aGlzIGhhcHBwZW4uIEJlY2F1c2UgVlJBTSBoYXMgbG9zdCANCj4+IGFmdGVy
IHdob2xlIGdwdSByZXNldCwgdGhlIGpvYiBjYW4ndCBndWFyYW50ZWUgdG8gc3VjY2VlZC4NCj4g
TkFLLCB0aGlzIGlzIGludGVudGlvbmFsLg0KPg0KPiBXaGVuIEVDQU5DRUxFRCBpcyByZXR1cm5l
ZCBVTUQgc2hvdWxkIGNyZWF0ZSBuZXcgY29udGV4dCBhZnRlciBhIEdQVSByZXNldCB0byBnZXQg
YmFjayBpbnRvIGFuIHVzYWJsZSBzdGF0ZSBhbmQgY29udGludWUgdG8gc3VibWl0IGpvYnMuDQo+
DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IExpdSBDaGVu
Z1poZSA8Q2hlbmdaaGUuTGl1QGFtZC5jb20+DQo+PiAtLS0NCj4+ICAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIHwgOSArKysrKysrLS0NCj4+ICAgIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jDQo+PiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jDQo+PiBpbmRleCA4NWU0OGMyOWE1N2MuLjJhOThm
NTgxMzRlZCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9jcy5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYw0K
Pj4gQEAgLTEyMCw2ICsxMjAsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jc19wYXJzZXJfaW5pdChz
dHJ1Y3QgYW1kZ3B1X2NzX3BhcnNlciAqcCwgdW5pb24gZHJtX2FtZGdwdV9jcw0KPj4gICAgCXVp
bnQ2NF90ICpjaHVua19hcnJheTsNCj4+ICAgIAl1bnNpZ25lZCBzaXplLCBudW1faWJzID0gMDsN
Cj4+ICAgIAl1aW50MzJfdCB1Zl9vZmZzZXQgPSAwOw0KPj4gKwl1aW50MzJfdCB2cmFtbG9zdF9j
b3VudCA9IDA7DQo+PiAgICAJaW50IGk7DQo+PiAgICAJaW50IHJldDsNCj4+ICAgIA0KPj4gQEAg
LTE0MCw3ICsxNDEsMTEgQEAgc3RhdGljIGludCBhbWRncHVfY3NfcGFyc2VyX2luaXQoc3RydWN0
IA0KPj4gYW1kZ3B1X2NzX3BhcnNlciAqcCwgdW5pb24gZHJtX2FtZGdwdV9jcw0KPj4gICAgDQo+
PiAgICAJLyogc2tpcCBndWlsdHkgY29udGV4dCBqb2IgKi8NCj4+ICAgIAlpZiAoYXRvbWljX3Jl
YWQoJnAtPmN0eC0+Z3VpbHR5KSA9PSAxKSB7DQo+PiAtCQlyZXQgPSAtRUNBTkNFTEVEOw0KPj4g
KwkJdnJhbWxvc3RfY291bnQgPSBhdG9taWNfcmVhZCgmcC0+YWRldi0+dnJhbV9sb3N0X2NvdW50
ZXIpOw0KPj4gKwkJaWYgKHAtPmN0eC0+dnJhbV9sb3N0X2NvdW50ZXIgIT0gdnJhbWxvc3RfY291
bnQpDQo+PiArCQkJcmV0ID0gLUVJTlZBTDsNCj4+ICsJCWVsc2UNCj4+ICsJCQlyZXQgPSAtRUNB
TkNFTEVEOw0KPj4gICAgCQlnb3RvIGZyZWVfY2h1bms7DQo+PiAgICAJfQ0KPj4gICAgDQo+PiBA
QCAtMjQ2LDcgKzI1MSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2NzX3BhcnNlcl9pbml0KHN0cnVj
dCBhbWRncHVfY3NfcGFyc2VyICpwLCB1bmlvbiBkcm1fYW1kZ3B1X2NzDQo+PiAgICAJCWdvdG8g
ZnJlZV9hbGxfa2RhdGE7DQo+PiAgICANCj4+ICAgIAlpZiAocC0+Y3R4LT52cmFtX2xvc3RfY291
bnRlciAhPSBwLT5qb2ItPnZyYW1fbG9zdF9jb3VudGVyKSB7DQo+PiAtCQlyZXQgPSAtRUNBTkNF
TEVEOw0KPj4gKwkJcmV0ID0gLUVJTlZBTDsNCj4+ICAgIAkJZ290byBmcmVlX2FsbF9rZGF0YTsN
Cj4+ICAgIAl9DQo+PiAgICANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdA0KPiBzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxt
YW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q0NoDQo+IGVuZ1poZS5M
aXUlNDBhbWQuY29tJTdDNTZlNDUxOWI3OTE4NGNkYWIzZTUwOGQ4OWNlZGY4YmElN0MzZGQ4OTYx
ZmU0ODgNCj4gNGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzQzMTg5Mzc2NzIwMzEx
NyU3Q1Vua25vd24lN0NUV0ZwYkdacw0KPiBiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpv
aVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEDQo+ICU3QzMwMDAmYW1wO3Nk
YXRhPXNRSWMlMkZoeEMlMkJvdFg0OXlEN1ZodzVGZnhMOTZOejRJUEFrY1hNVVZaUzZjJTNEJmEN
Cj4gbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
