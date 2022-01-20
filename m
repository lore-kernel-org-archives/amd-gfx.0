Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408F7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 17:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A777210E662;
	Thu, 20 Jan 2022 17:58:59 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD8910E87F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 17:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJvPr9Rd4Sln2TH4zg1DldB7xYtLsNV6500JEb8oOaYFdhp5CFf+LLaPiOP/UbxX0JrhaRO8HdhxUDdqaYR+OUECNHwQzRCKGEq65llrOgcFXkDBoVtbr1kZwKvS/Kwvjdx3FF3kYFVcfp+ulp89FqsWAes/Mkx+qmf+Osq2oXAXzFDG8hSv/OwEmhGDvFKiBi2Y01UI9yXdufJbAbxKFJw4vXi4a85o4Dt7mQvA5UhedvhD/m4To054Sx9ns+4zZpg6DUMXdkTlUn/vv4AdXWbnYVo1/PTO41yos2czC5Dg7nmnIXmlH+WvbHgRAQjZTwSgDqMmwkYd1hyricCusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQrNLsjHyFKf4GZzEOR6X7tWR8wcF8OMDMHYYeOpQ6w=;
 b=d6jUePb7r2gx3oNTPV9noPNQv+SI9zdprJBQRJkVOPjZU5sx0Bq+5oVmGMewp9kIcUo7Ti0zhSGcMvDbVNqywbTP8E621/hikP9YZGK1UExgzOJ6OxKS0NthIED6ATSdareObdTc3ncgu4PlRZS56DYvcA6IWTPw3Wf+7N8JKWTlYRgSALHxCfVEuDhKcXAt+utLCweXjYDmBUMjNyNjSELGU68PRZaCyQBL7dC1oxHU9ixMSKmUkLG1yYEsT8plkJAK4aP1YLLQ8Tz0fkSnnkSJJl4oePmzOZOwgHyyvIXRoo9DjPGFE14Cs0RrVc2Bq5K1/O3rhSsTAIvBMfwRuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQrNLsjHyFKf4GZzEOR6X7tWR8wcF8OMDMHYYeOpQ6w=;
 b=420ssTLV7V4VnWP+XxQM1xJzBEvzSjJKP2l/k5jBUvjPboZdb/c4RnVlMJLm+RRYj11aDrAgeo1FQcVUU6TQDnCOtnfHH23Tcr4eTFwL90ZLW4fX5Lx9uvf7wdJ8YbgLOZrzbgJB8qL0/QpEhAuSro2aGeku05/nxxFTIwVwtMg=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.10; Thu, 20 Jan 2022 17:58:56 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::b975:de48:9987:2ea4]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::b975:de48:9987:2ea4%11]) with mapi id 15.20.4909.010; Thu, 20 Jan
 2022 17:58:56 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disable FRU EEPROM access for SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Disable FRU EEPROM access for SRIOV
Thread-Index: AQHYDhVG5AKPaUWtqE22SBbuJBE0yaxsH38AgAATF9A=
Date: Thu, 20 Jan 2022 17:58:56 +0000
Message-ID: <DM5PR12MB130832EC4BABF05873EF3971855A9@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20220120154851.22223-1-shaoyun.liu@amd.com>
 <CADnq5_NkuthTyhDWS+2u6AV-FZkgmFJjTmHmoho3SXhk-ibvsQ@mail.gmail.com>
In-Reply-To: <CADnq5_NkuthTyhDWS+2u6AV-FZkgmFJjTmHmoho3SXhk-ibvsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f8912751-7d51-4aca-b02c-1f745483965b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-20T17:58:49Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d11907a2-1f48-4bc1-e086-08d9dc3e8708
x-ms-traffictypediagnostic: DM6PR12MB4252:EE_
x-microsoft-antispam-prvs: <DM6PR12MB42528D6AE1DE9248DB57EAC4855A9@DM6PR12MB4252.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PTzK2DOa0+8Y2aAIcC+tJHiUTUa8C+EbwBl4okodI6MfhR3UstgN/LSxR34geFEK7OXRH+XsSPebvw5NqvmpI+ZlIlgRaWuAPz10EiZEdHkCQSpt5HVxGQ3Ba60Xx3FOXZ8z6blmz8xHThzdCd8vxfvw5bW3m3NaDV45aCe0elJpLx74RIN1HUdfVNgDxMpX0+YyF5wlbOecCymML1DBS+/3KoqwbMm6FbwaxFFm+1bqgbAzaBlxhJ9+c9ccgzc3L/2I5GgA9kZgH3xbHEBzaOuFQkz2uwAgSVVOD+GwTA+Yq7IK9DpkWCu5n/8qUKpfcr+swZuQrDwPpnq4NnMBUM1ix70YEJtwpXiecrrD+IF9pzNZMJGKrha/K9KzoLD2o9mqH4s7b2mGOpOemw7NKprvVOIybbx90WdIKqxcy0uRKiKOBSZ1LJ6CKSt0ioZgxMotxAcja8NtHcyabLyGk0rQbYuJf/dRn2CZI8etkCUicMZs+2jM2kYsuBF0R96tbXV17TQLIQdtHNXNfFgciqvvzBxsf/v2iDn0bsn/irOqWqH9Ro/nI8PwyXEc2H6vcRlea4uH/U6Kd9Bto6bvNEcH+eKxiQMAWGLkgGRliheQv/P9P9kp2AEoexbtQYGuCs0/9ualJuw1QG9zYTbgy14r9XD7VHrow4sq50LJKGEDGZLfBGRsaItsFtkTtqrLYHu79JlmiB7Sj/7RdC+brg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(33656002)(38100700002)(316002)(26005)(71200400001)(122000001)(76116006)(7696005)(2906002)(186003)(110136005)(86362001)(4326008)(53546011)(8936002)(6636002)(6506007)(38070700005)(508600001)(55016003)(66946007)(5660300002)(83380400001)(8676002)(66446008)(64756008)(52536014)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDlveGZTbkgzUitGTkpuMXQrTHFidzl2UC9CQVE2VEx0SE5vK1lwa0U2K0pp?=
 =?utf-8?B?djNVUXBtcHNRc2svaVRSVXc5b01vRVdGU0lCaytoKzJkcHZVcmNmTVo5Q3gr?=
 =?utf-8?B?NlpxczV2ZjUycnRPZXVSQUFOZlhvdGFvcmQwWFRjaFNuUzZvUGc3RHlnZy8z?=
 =?utf-8?B?VjMzQmthZnJCa29tQnd0RnZaaXhVcXk0UU1NMFYzcFoxWUJNQkJ4bHN0dHlV?=
 =?utf-8?B?RURKajN2UWR3UU4yMUFKVzFhVWtINFo0U2d1Yy9tak1LejU1YmoyUkRPZUc0?=
 =?utf-8?B?V0UxdTdIRTNHUFIyL0N2eWRVY3NkVXJ5ZVQ3T1pMREZaTTgydU9PKy9lVjEx?=
 =?utf-8?B?dFljTk45cmtwYnVvWERWZmhiTGZtK2R0dnI2QlpBZjlXQTNFUGVKVlk4ejBS?=
 =?utf-8?B?WThkd05sMmFwazhVMm5ZWk96aWo2TTIyd2hvL2wxd25XMCtXVW16WjZSLzdl?=
 =?utf-8?B?blEvYnlHdUY0MzVlaVhsYjZPTTRTRms0RllWV3AwaFp4ZVRubG5BSjA3Nmp0?=
 =?utf-8?B?QlRaTTFaV09JZUtsM1BpMXZuSTJzZ0dNL3ZndDZsMk93YTF4SkRHdmExbFhu?=
 =?utf-8?B?Z1VOKzR1V3ZBbitGMUJzcHV0VXpObzgzeTd1bWpvVG1SbGdEa3loaGJkOVBP?=
 =?utf-8?B?cEVJMS9wRTNOcFlrYU80ejF0QXNjc29UTEN0K3N2aXZOZytDbFdiNi83TUc1?=
 =?utf-8?B?UjZtVEZMTnRSd2c0ZUV3dU00NTZIQ0JjYzJWTlJDN0FodDlaWXQzR2ZZTUxN?=
 =?utf-8?B?YllURHhHK1ZYZFpZanZwSTZoMVZLUnlXQmdZdjhLLzg0UlZDRnIzcTdGSEJI?=
 =?utf-8?B?VVRWOU9kdlV5QUpuNmIyV0srOWk0QjhzQkxPckxnZVliQTVCMXZTeXpSOG9x?=
 =?utf-8?B?ZWx3bGVYVmdDTUtYVVRXeWlrYytXRnZTWVRsclJzempiUHlCaWVlUEliQlhV?=
 =?utf-8?B?d3JRbERLbTl1MXhlSll5cEwvNGNTcTBBL1hHSVJ0d2k3Nm43RDRMa0lIOHda?=
 =?utf-8?B?KzRBQ1hpUDN3TDhSUUVSaUZIN3ZoVGNQTmRtVmxUR0p4RStkaFpQUFMreURj?=
 =?utf-8?B?WXNCcW5WRkRFejF6YWtZK2dRREswU25EaDBsVk9aVDNuNnI1bHFDOXNXTnVr?=
 =?utf-8?B?VEtCajA5djNuU3RMeENmNGorMUtReVJxcmVId0QvRGFpQi9kZzlBQW9vQVJo?=
 =?utf-8?B?dWhSR2lDeXJBcXdjWmVWYnQvSXBJa1ZTUUtoQ3g2WWl1MmNhU1JEMkZOK0JU?=
 =?utf-8?B?b2RrYzNJK1VKdng0ZXdRUGcwOG1rOU84T3ZodkR4TE9SU3hVdE9yZ3hmV0dP?=
 =?utf-8?B?VVpOa1haVERnNVgxSFJpZFVma0NVRGRlNjdFSEYzOElDUVdNbTlPU1pGcU9U?=
 =?utf-8?B?cEZsbEd2RXl5SEJ4dUE4Uy9lR1FOWnA5K2dGT2VUQlNMeWFLeTBPZEd1SkIw?=
 =?utf-8?B?WmJVZGpaY3Z3cE5EcWRMWi91TWJkQmZoYlRhR2VjUzdZUmwxOTNPWnc0aUNJ?=
 =?utf-8?B?VWxxaFR2ellBY3JSZ1ZCeGRHUlJXQ2ovSTErWnREUW1jVWtCR29ZQndXRGVv?=
 =?utf-8?B?a0JjLzFCK0gzcGJIeVg1T3NjbGNZSVVhSktCUjN3MlQzeHNVaG01ZEtneCtt?=
 =?utf-8?B?SU9SbUpPUGVXRmpRRlQwU3BnN2tic3J6ZzlRRjFvdk1SWEhRcUFjbk0wWVE5?=
 =?utf-8?B?K3hxN1B6V0xzNitMV1hNaldCNTZ0dTRhSW1NNmE5SmhpVFl6MThreFUxWWxU?=
 =?utf-8?B?Z2pBd2IxNXFlNGhESVlGK2VWT2FudWdzam1zMUN6bFhMRkh6YitqMjlIVWVz?=
 =?utf-8?B?QlBTb2hGTEtaRUNwSFVRV0ZWSnpEZ01TdlIvNUZteWdaR3didm9lQUpEa1k2?=
 =?utf-8?B?NkdPMEFYTWg0dlZwRU90aG0yZXlWaEtDbWRFK2Zzb0dSM3BUZU9VdXU0Nldq?=
 =?utf-8?B?M0F6M1dNcDgza0VscWdHa2NDeHk3alQ3ZFJJSzZrMzBPbGVWc3AvU25NdW5j?=
 =?utf-8?B?dTkrNDdCMnBRdTV1Ny9pODhQK3J3RGphWTUyTlE5L2Nqc3lGWHVsS2ZQSWE0?=
 =?utf-8?B?UzkxV0RQYVYzMTJEazlBN2s4QVB1Mm1TaFhVUjYrZmw4NlBZb0JZM09XeHVZ?=
 =?utf-8?B?OXlxMitMLy80bnlaVUFTY293bUpaOWUvanlTQUEzZ1l4UVNycmxnS0NXT0ZK?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11907a2-1f48-4bc1-e086-08d9dc3e8708
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 17:58:56.0756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MAXEn2yt51gUakF+BkUrvhl8EP+GQn823zsf2ytcWPApOJ/gc0Jxs2FCToMnvhvxFZKvr9WIDib7KV/IPFKYYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KUmV2aWV3ZWQtYnk6IEtlbnQgUnVzc2VsbCA8a2Vu
dC5ydXNzZWxsQGFtZC5jb20+DQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9u
IEJlaGFsZiBPZiBBbGV4IERldWNoZXINCj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMjAsIDIw
MjIgMTE6NTEgQU0NCj4gVG86IExpdSwgU2hhb3l1biA8U2hhb3l1bi5MaXVAYW1kLmNvbT4NCj4g
Q2M6IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IERpc2FibGUgRlJVIEVFUFJPTSBhY2Nlc3MgZm9y
IFNSSU9WDQo+DQo+IE9uIFRodSwgSmFuIDIwLCAyMDIyIGF0IDEwOjQ5IEFNIHNoYW95dW5sIDxz
aGFveXVuLmxpdUBhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IFZGIGFjY2VzIHRoZSBFRVBST00g
aXMgYmxvY2tlZCBieSBzZWN1cml0eSBwb2xpY3ksIHdlIG1pZ2h0IG5lZWQgb3RoZXIgd2F5DQo+
ID4gdG8gZ2V0IFNLVXMgaW5mbyBmb3IgVkYNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IHNoYW95
dW5sIDxzaGFveXVuLmxpdUBhbWQuY29tPg0KPg0KPiBBY2tlZC1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jIHwgNiArKysrKysNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMNCj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jDQo+ID4gaW5kZXggMmE3ODZlNzg4NjI3
Li4wNTQ4ZTI3OWNjOWYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2ZydV9lZXByb20uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMNCj4gPiBAQCAtNDAsNiArNDAsMTIgQEAgc3RhdGljIGJv
b2wgaXNfZnJ1X2VlcHJvbV9zdXBwb3J0ZWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+
ID4gICAgICAgICAgKi8NCj4gPiAgICAgICAgIHN0cnVjdCBhdG9tX2NvbnRleHQgKmF0b21fY3R4
ID0gYWRldi0+bW9kZV9pbmZvLmF0b21fY29udGV4dDsNCj4gPg0KPiA+ICsgICAgICAgLyogVGhl
IGkyYyBhY2Nlc3MgaXMgYmxvY2tlZCBvbiBWRg0KPiA+ICsgICAgICAgICogVE9ETzogTmVlZCBv
dGhlciB3YXkgdG8gZ2V0IHRoZSBpbmZvDQo+ID4gKyAgICAgICAgKi8NCj4gPiArICAgICAgIGlm
IChhbWRncHVfc3Jpb3ZfdmYoYWRldikNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNl
Ow0KPiA+ICsNCj4gPiAgICAgICAgIC8qIFZCSU9TIGlzIG9mIHRoZSBmb3JtYXQgIyMjLURYWFhZ
WS0jIy4gRm9yIFNLVSBpZGVudGlmaWNhdGlvbiwNCj4gPiAgICAgICAgICAqIHdlIGNhbiB1c2Ug
anVzdCB0aGUgIkRYWFgiIHBvcnRpb24uIElmIHRoZXJlIHdlcmUgbW9yZSBtb2RlbHMsIHdlDQo+
ID4gICAgICAgICAgKiBjb3VsZCBjb252ZXJ0IHRoZSAzIGNoYXJhY3RlcnMgdG8gYSBoZXggaW50
ZWdlciBhbmQgdXNlIGEgc3dpdGNoDQo+ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0K
