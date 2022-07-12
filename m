Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC55C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 09:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3AF093A79;
	Tue, 12 Jul 2022 09:07:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B630A93A6A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 09:07:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrzLWTOpmB7pTsRchESxwTIfux5H32fAIFGBCfQhjvmW/jLa/eTzpNdj4t/d2QT+3K2CfNOwUvEFrbN65mUVf0uXPGdeBhOIUVZgLPXuv4Kxu71wmPlaa/T2zLNoDu3WwPvb1m8ZXRKIjHFNnGJDgVUdJlK7Z0oBw4uOVPIMH6xIEIu8ull/FfixUsNqAAJ87pAqiRqVhlIpZPY/TYax6Ay1WfT7nTW+pPNchuUtTnqHawmpbPzOVK9dr/DLhI6pS47Of+FYqvJP7zmX9TDqe3XqRsweL0Twh3vT18PF6XqEdh9qUEJ//YrVlstnDX6hlN13Od9lrH4CRHJmlWg6UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZDsonNG/6FX36ecSTb4bVLjrwK5MDL09tHEJ2Kw3Ww=;
 b=JVfJNIBO8QPSekdRAsPYBMyn6PFlwQu+LKo106XhLfiQbeMTzNzpCpCPtSpwzKnpdjXC2/MFD21z/edJUmyFNlO1rvyI/ZHXX2vsrW4ajxJFxxD4wSngv9rNvzydAZVz5S+sfl2ob+tchw1TuObQ9AWCYnFoI9tlttPl4mFTa6AM5M0unDMsqWVUm7fLgwbPI4nWPhLC2z0v6esUWD+o6BLY5859+WIdThhdgZBhTNJYeXXikY61sIO5KO5gBVlC8qUCdAyj1U8gGo6uWQThjMqvw3KdbP6f9QyyyaJjicybRTtyQ9JLsUYbE9iAW8IiW1AYyq5Mch6Wt89W+yjiIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZDsonNG/6FX36ecSTb4bVLjrwK5MDL09tHEJ2Kw3Ww=;
 b=oQhBrIFEwEJTvqOfeJJ9/fkrD3IyHa3HpKT0Y/WhVE6kI5N89jv9LcPnEZuh2riUeDySFNSdmT7/dZDPqq/Bx9Lph5tz5hhAqvz4IX+d80pKVHNp7Sm4bXg49dbtQpcL24pMcRAIPUOP4+4oy/bkrslKM+Dc81zXqyPYOJPl+6c=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15; Tue, 12 Jul 2022 09:07:35 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 09:07:35 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Quan, 
 Evan" <Evan.Quan@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: use cached baco flag as the check in
 runpm (v2)
Thread-Topic: [PATCH 2/2] drm/amdgpu: use cached baco flag as the check in
 runpm (v2)
Thread-Index: AQHYlboJ8XUcxvE9aUeOmvlGFZThw616TZSAgAAkVhA=
Date: Tue, 12 Jul 2022 09:07:35 +0000
Message-ID: <DM5PR12MB2469E0C2505695FD13037545F1869@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220712063827.28300-1-guchun.chen@amd.com>
 <29f2d302-8891-944c-49fd-f468c81c8d4c@amd.com>
In-Reply-To: <29f2d302-8891-944c-49fd-f468c81c8d4c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8acbe220-ef39-469e-54ca-08da63e5f639
x-ms-traffictypediagnostic: DM6PR12MB3962:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Otvr9lpZSOdvdH5YoaYhsdzwMqGJWSUu7wUxnlY4umgGUCiWv05W2dx40qAQvCdujBBh61n6KncSwNlqLE++n8ATqRDURU+Eg0cmD6xE7xoUHVbZeC4Vfdz+us03ckBmb3neXAADfpTzVRg71HgqIkLK93+aB07ARWgMFI0GfyceQfmXf/uLBNm+uv+kYHx+N8eLNcGc9k86xx6cpVsTc5B/MIs5KCpcArUpXHSCGHFJ/o75JXHJDRJJ3gogns0AEbtO6T3M/TsHLn+634HsbYlZksJ2u09AVXwuKRfF1l20m0+zrbPqAkMKA3oy2UKYPYxUGAZ21rXjjtcPB3lTr3dSzqyHU99HOpHS1ToRuCms3RU4tuwY78FjTDQBj3HuXBIu7jVMVrN4+dvQbo0S5cCP/3epRUiWdWzRff94Ql39c2YUGU95VfkPP/1qR3d6gT0La7YhuPPgOQpWnmRaGl8XB+0POiwQmaacw7N1aSYT7tf+t251EUN2beO4TwP2Yo1Cr6GCH++h9dsH6zf/KAm1z6ffVwsgy0gCEoS3DtTjQSZE8po13M54C5o9Fn8cwNeRJcUiw761rp5aOI/FqNe2felV19UG1liCv42jtDaA/mSCghuGgyWP1Yjco5SBtOPQ0mALaXS2THcZDL/NfQB7OPtRDljHS+iOe2RiWM03vTuzV+aEBvaWi9mgamoMLZT7tFHdDlA2EVMO4hTHTcdlGRFQd71Set/9iaYByV1cx1k9HELm8a3J5KwCeq3AMUKEsbNkOzzCQlFrxxnmbVdJBDd6v4k5H1tiYFrT/vixLWmpXGM7hXK9dNp3DxRQuPIbZWOpv+1qOUDSqxbiSf5oBKWi+QyHntVEFErJhiE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(33656002)(2906002)(186003)(26005)(53546011)(66476007)(66556008)(9686003)(7696005)(86362001)(66946007)(6506007)(122000001)(55016003)(38100700002)(921005)(38070700005)(64756008)(66446008)(966005)(71200400001)(83380400001)(478600001)(52536014)(5660300002)(110136005)(8676002)(316002)(6636002)(41300700001)(8936002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGwyYmIyRUtiRUMzMTFOTnZkSzR0dHg5ajcwNzJWRTVjdmtIY25lTnFsdmdl?=
 =?utf-8?B?dmRha3poeG5jcFBNS0tLajRjVTFUdGpzendoV3NRbm9jam11Rmh0UjduUzlY?=
 =?utf-8?B?RXFBV1hWUm9TY0cyVXRhTTdhZUxkaDcvQ1BVM2FXNjliaW85YUY0YnlIRHJD?=
 =?utf-8?B?NGhlWnhOdkpVcHc4OEo0cXNKSUxKUGtQUCtEakxTV3RFWkEwRVpPZEkxR3Fm?=
 =?utf-8?B?UUlNMG8wK1BSZ3lqamwrOVJGV2J2RlR4Y2tpbWN0SVAycFVqNUlrTGM3YkJL?=
 =?utf-8?B?MWdpaVBBSWtXME5TNWZ1RVBTWXpHZWtCemE1MnIwcnZuakZXYVc2VWowUk5U?=
 =?utf-8?B?L1pncHEzZTlxdDNMRndsN1BYSUgzVDZsc01vZC9LRXNNMWdTYzI3dVJ6OENO?=
 =?utf-8?B?dkJIWSt2ZU1rUU5OSFhjNWszNEwvbnJzUHdmM013UXIzS1p0dzhXQ3gzV1lZ?=
 =?utf-8?B?Zk5WdzNNZ3F2M1hXZUtnMk5TeHBjemcxazcxRmNWVlk1Q3J2WGI0Sm80MGdz?=
 =?utf-8?B?SHFlK3d6T3FEWnpnTGNzSkY2Z1ZuVWdnaTlhVUdCZzhQbnBFMGxBYmxIaStJ?=
 =?utf-8?B?SXExTDM4R3lMWkhqQ2RCTnpXekRRaGpmU0ZKSHp1b1A2bVh0QW5KUjZ2amlr?=
 =?utf-8?B?YXBDanhxZi9JQU5iMlZjNytlU29ES0xHMG5wWFFNWEJzczlXc3hMTXZuOUJl?=
 =?utf-8?B?OVg0alM3UmI2Vzh1NlVIYyszeHlQeXo2dnBBOVFyOFp6dDJoa0dQRGJ0aGR4?=
 =?utf-8?B?bHNGL1k3ZGNiUUI3MnI3VS9HT0prK2M5dXN2cC95NjlMRnl0OFAwckxwcDBG?=
 =?utf-8?B?dW44OUYyV0d0Umd1NkVpVEdBL1VuTU5PYUljWVdMOXNPNXZWMGU4VnI1WUhR?=
 =?utf-8?B?aW55dFpZdXVlcGhzaitNemdLQ2ZuQmNVd2Y1MU52SXhuWFk5V09EMmR2NitY?=
 =?utf-8?B?RGpZWXZsa0hUVjh1SGk3N3lCV0l5Y1VIRkhTK2F4Q2t1M3gyd3NxYnYvcUsw?=
 =?utf-8?B?L1ZXYThGbjNpQjN4Rm9aMzdWdkJxaWJpalZndHlpRTBvTTRUalptemp0eE9q?=
 =?utf-8?B?SUVqTnRaL1pDVS9hL1FFR09iWU5jbnZhZS96RmdYK2RkUERsOUEwMTZxa09O?=
 =?utf-8?B?cWphd0s4RUtkZGFXYTVPbDArVmgzczdmUGZTQ3BYaHRuVWJIcG51dEVBcXZD?=
 =?utf-8?B?cGxJZmtEa0VmTkh1cC83L0xWRUFsb3QzdVo0SkJzMTEvQkhySm1nYzg0NGEy?=
 =?utf-8?B?eUJZL3JSbGdhUWthVGVlNjlmSlhLWUNtZmd6R3o1Z1B4aXArUkltRGpLcGRn?=
 =?utf-8?B?d2l3NVF5UXZUNlEwOStTNDJZdlpGcnRGbE1FNzV2NndSWDV5dWhhMGRySzlR?=
 =?utf-8?B?Q0c0UmNsaURQR1dlQlkvOEgyeHhmKzZUYVlaMElxVjVad21YVk9RQ0VTOW03?=
 =?utf-8?B?YnRuZkZ2UUVsNGtFWk52VlA3MmtPa1VTVTJTNHJCWnIzd0hTSHJ4RjdWQ0VO?=
 =?utf-8?B?QjFYM2hnb3VIYTMySHdNRC93dyt0eUEzVEo4ME1qckJQdW5HanRlbjNVWlZO?=
 =?utf-8?B?SHpSaW5GMmNWRUNHSHVaSVJITmlvTEkwMWVXU29xdFdVTzlCaUIyT3diWk1J?=
 =?utf-8?B?a2c3TjFVT3hMc3lOU0U5YlphYjNvRVJBZyt3TVFoNFRPVWNZcm1ac1M1Y3U4?=
 =?utf-8?B?RWQ0WjFaZEt3Sm1ZK3c0cmFMMUxMUnVaUDFiNlF3dFRoOTBwcUc2VkJWL0dj?=
 =?utf-8?B?RWt0b09jRWRVR2FveGxoMkFLVXovVzFYN0d2OGpiNGJyVjFwamw0ZC9yVkFx?=
 =?utf-8?B?K1UwRkJDdlFBV2xZMjE0dFQ1M3RvSTJPMVV5YzQ1eU9pMS9rTXF3S1h1djU1?=
 =?utf-8?B?MXRZUXFxa3BYNkZWZ0hwRUMrTThCR2Q2ZGxoeEJBRnVGMzNGcVp5bmJlZFRP?=
 =?utf-8?B?cmlMbmRDQXd2dkVEMmtRUFRPdEpGZ0NnSFRacGVSaTQ0NElIQlp4T0tFa2FE?=
 =?utf-8?B?VUx6c3dDN0xOU0FUU1NTL296ZGlXT0pnemVRNjhUZlV3dFMrcW92RSt4SGpG?=
 =?utf-8?B?VWJDRzl1eHNGcytVSDM1L0hYZWxIQW85Ty9BTnVHbUpiUmNncC8yMVNqL1Ez?=
 =?utf-8?Q?I0ODHQtovxlRNDaSWWmM0OzQ8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acbe220-ef39-469e-54ca-08da63e5f639
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 09:07:35.5490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DgMIglERSQFpuw3uMkQ/QIaunUhpofxSq9DRGnb1TQKZsvaUxpGlvAW9g2dPpJPOlNruLUfUVBFc9ao9EdlFKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
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

VGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24sIExpam8uIEkgd2lsbCBmb2xsb3cgeW91ciBzdWdn
ZXN0aW9uIGluIGEgbmV3IHBhdGNoIHNldC4NCg0KUmVnYXJkcywNCkd1Y2h1bg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNv
bT4gDQpTZW50OiBUdWVzZGF5LCBKdWx5IDEyLCAyMDIyIDI6NTcgUE0NClRvOiBDaGVuLCBHdWNo
dW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsg
RGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIEhh
d2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQu
Y29tPjsgRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTog
W1BBVENIIDIvMl0gZHJtL2FtZGdwdTogdXNlIGNhY2hlZCBiYWNvIGZsYWcgYXMgdGhlIGNoZWNr
IGluIHJ1bnBtICh2MikNCg0KSW5zdGVhZCBvZiBkb2luZyB0aGlzIHdheSwgc3VnZ2VzdCB0byBj
YWNoZSB0aGUgcnVuX3BtX21vZGUgaW4NCg0Kc3RydWN0IGFtZGdwdV9wbSB7DQp9DQoNCllvdSBj
b3VsZCBjYWNoZSB0aGUgcnVuX3BtIG1vZGVzIGluIGttcyBsb2dpYyAtDQpodHRwczovL2VsaXhp
ci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9rbXMuYyNMMTgzDQoNCkFmdGVyd2FyZHMsIHlvdSBtYXkgdXNlIHRoZSBjYWNo
ZWQgdmFsdWUgZm9yIGFueSBjaGVjaw0KDQpGb3IgZXg6IGFkZXYtPnBtLnJ1bl9wbV9tb2RlID09
IEFNREdQVV9SUE1fQkFDTw0KDQpUaGFua3MsDQpMaWpvDQoNCk9uIDcvMTIvMjAyMiAxMjowOCBQ
TSwgR3VjaHVuIENoZW4gd3JvdGU6DQo+IFNNVSB3aWxsIHBlcmZvcm0gZHBtIGRpc2FibGVtZW50
IHdoZW4gZW50ZXJpbmcgQkFDTywgYW5kIGVuYWJsZSB0aGVtIA0KPiBsYXRlciBvbiwgc28gdGFs
a2luZyB0byBTTVUgdG8gZ2V0IGVuYWJsZWQgZmVhdHVyZXMgbWFzayBpbiBydW5wbSANCj4gY3lj
bGUgYXMgQkFDTyBzdXBwb3J0IGNoZWNrIGlzIG5vdCByZWxpYWJsZS4gSGVuY2UsIHVzZSBhIGNh
Y2hlZCBiYWNvIA0KPiBmbGFnIHRvIGZpeCBpdC4NCj4gDQo+IHYyOiBjYWNoZSB0aGlzIGZsYWcg
aW4gbG9hZCBzZXF1ZW5jZSB0byBzaW1wbGlmeSBjb2RlIChmcm9tIEV2YW4pDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4NCj4gLS0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggICAgIHwgMSArDQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgMiArLQ0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyB8IDQgKysrLQ0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDIgKy0NCj4gICA0IGZpbGVzIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHUuaA0KPiBpbmRleCA4NDVkNjA1NDk5MmEuLjgxNmY4MTNhNWRmMiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gQEAgLTEwMTQsNiArMTAxNCw3IEBA
IHN0cnVjdCBhbWRncHVfZGV2aWNlIHsNCj4gICAJYm9vbCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBydW5wbTsNCj4gICAJYm9vbCAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbl9ydW5w
bTsNCj4gICAJYm9vbCAgICAgICAgICAgICAgICAgICAgICAgICAgICBoYXNfcHIzOw0KPiArCWJv
b2wJCQkJaXNfYmFjb19zdXBwb3J0ZWQ7DQo+ICAgDQo+ICAgCWJvb2wgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcG1fc3lzZnNfZW47DQo+ICAgCWJvb2wgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWNvZGVfc3lzZnNfZW47DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZHJ2LmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rydi5jDQo+IGluZGV4IDFjYzkyNjBlNzVkZS4uYzNmODcwYzAxYzQ3IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+IEBAIC0yNTEzLDcgKzI1MTMs
NyBAQCBzdGF0aWMgaW50IGFtZGdwdV9wbW9wc19ydW50aW1lX3N1c3BlbmQoc3RydWN0IGRldmlj
ZSAqZGV2KQ0KPiAgIAkJZHJtX2Rldi0+c3dpdGNoX3Bvd2VyX3N0YXRlID0gRFJNX1NXSVRDSF9Q
T1dFUl9EWU5BTUlDX09GRjsNCj4gICAJfSBlbHNlIGlmIChhbWRncHVfZGV2aWNlX3N1cHBvcnRz
X2JvY28oZHJtX2RldikpIHsNCj4gICAJCS8qIG5vdGhpbmcgdG8gZG8gKi8NCj4gLQl9IGVsc2Ug
aWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYmFjbyhkcm1fZGV2KSkgew0KPiArCX0gZWxzZSBp
ZiAoYWRldi0+aXNfYmFjb19zdXBwb3J0ZWQpIHsNCj4gICAJCWFtZGdwdV9kZXZpY2VfYmFjb19l
bnRlcihkcm1fZGV2KTsNCj4gICAJfQ0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9rbXMuYw0KPiBpbmRleCA0YjY2Mzg2NmQzM2EuLjUzMjQwNmQzMmZiYSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYw0KPiBAQCAtMTg4LDgg
KzE4OCwxMCBAQCBpbnQgYW1kZ3B1X2RyaXZlcl9sb2FkX2ttcyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSANCj4gKmFkZXYsIHVuc2lnbmVkIGxvbmcgZmxhZ3MpDQo+ICAgDQo+ICAgCQlhbWRncHVfcnVu
dGltZV9wbV9xdWlyayhhZGV2KTsNCj4gICANCj4gLQkJaWYgKGFkZXYtPnJ1bnBtKQ0KPiArCQlp
ZiAoYWRldi0+cnVucG0pIHsNCj4gICAJCQlkZXZfaW5mbyhhZGV2LT5kZXYsICJVc2luZyBCQUNP
IGZvciBydW50aW1lIHBtXG4iKTsNCj4gKwkJCWFkZXYtPmlzX2JhY29fc3VwcG9ydGVkID0gdHJ1
ZTsNCj4gKwkJfQ0KPiAgIAl9DQo+ICAgDQo+ICAgCS8qIENhbGwgQUNQSSBtZXRob2RzOiByZXF1
aXJlIG1vZGVzZXQgaW5pdCBkaWZmIC0tZ2l0IA0KPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9wc3AuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cHNwLmMNCj4gaW5kZXggZGU1OWRjMDUxMzQwLi5mMDVkN2FjMDMxMjIgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4gQEAgLTIzNTMsNyArMjM1Myw3IEBA
IHN0YXRpYyBpbnQgcHNwX2xvYWRfc211X2Z3KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQ0KPiAg
IAkgKi8NCj4gICAJaWYgKGFkZXYtPmluX3J1bnBtICYmDQo+ICAgCSAgICAhYW1kZ3B1X2Rldmlj
ZV9zdXBwb3J0c19ib2NvKGFkZXZfdG9fZHJtKGFkZXYpKSAmJg0KPiAtCSAgICBhbWRncHVfZGV2
aWNlX3N1cHBvcnRzX2JhY28oYWRldl90b19kcm0oYWRldikpKQ0KPiArCSAgICBhZGV2LT5pc19i
YWNvX3N1cHBvcnRlZCkNCj4gICAJCXJldHVybiAwOw0KPiAgIA0KPiAgIAlpZiAoIXVjb2RlLT5m
dyB8fCBhbWRncHVfc3Jpb3ZfdmYocHNwLT5hZGV2KSkNCj4gDQo=
