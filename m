Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D1FC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 03:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C78AE99075;
	Thu, 14 Jul 2022 03:52:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1471A1417
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 03:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeWguT7sDjWzE1MIJaXCY9sfymUWk8moYJz5TiqjNFTm8J0BZlfPsqP3y9xnGCABM6mHb0YRRMjn2cH1UxxKHORNo29SEKNjQKeDLKtjXVhUOxQfwzV1DxkfSsdTV15V+QLI4ATDoiYVyvWSS04G/rTyfEOqSDsTcNxbNywwoUzdQgRCDKVNtsU/tOLNG0Wc01Bkc9ZllLGwwuy97LwY11IRmoxdwmgP594mzl7CBelYxa8GxUKN8WBOUB3k2SgzAoUbiFI1OIV1T0YrL054Y1quohaI7j2iSoajwelioR1KCVnmRa4HGBOMDZIeJbFqHg8O6JgRXmE1ue1lbK8qtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e84gj76BSLlHsa1HT/nLxI0S/tHz5k8T7TKXq4QSybs=;
 b=Y4fmVA276TaEGA4LtseXTNeIoKfWf5LVWdLDbR3IZrxIbQBBrahG49VMsCDDQTttWYdv64Kw0fVMyGSUFfRBZo3xPeZzeKebT9UKLeL5pYZMmgbuJxeQWzms30iedBo97mX/QyxpWMiZKPp4pzb4nByQukgyNEoXJHQMdqA9czDcYyBLzJIsj20XP4gc250vpaIVkQUPIvTn2XyplSebMJ3pghZ8WMy3y2i3k4+DZHGv5LWF4JMKETgEGysMq5rm8n8lCo4kz+ke0ocfbmKIS3yFNn7F+wYYbJj18G2tkGOWMuliFTrfx5+ukD3MgkH3O2HmmFOsp2WQWWhCwOU59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e84gj76BSLlHsa1HT/nLxI0S/tHz5k8T7TKXq4QSybs=;
 b=XEadley+ijxutmeKTw3q04rnKSz1f1JQqqO1An8XUnGaCGFLx6j1JSAD4zlqMTJ+wgrqQm76GRD3tAHno9U//pJEtppV7RjzTm9uDqbrIqAiq9Bz14TBgcGfzk0VZKOWre5IQG/7f8uLOol7pfwt0UM8zxmXJkgTLJc4+eZ1dwQ=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Thu, 14 Jul
 2022 03:52:53 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d%7]) with mapi id 15.20.5417.027; Thu, 14 Jul 2022
 03:52:51 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: skip SMU FW reloading in runpm BACO case
 (v2)
Thread-Topic: [PATCH 1/2] drm/amdgpu: skip SMU FW reloading in runpm BACO case
 (v2)
Thread-Index: AQHYlmcZeWo9gpDXJUqkKZdiV7L/ca18bl4AgADD3DCAAAjBgIAAALSw
Date: Thu, 14 Jul 2022 03:52:50 +0000
Message-ID: <DM5PR12MB2469359739E1B0D88FB994D9F1889@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220713031704.2004-1-guchun.chen@amd.com>
 <CADnq5_PzunYt9CBWF5Z4s2EERe2WBDmpREnfDD48KYNPkeS95g@mail.gmail.com>
 <BL0PR12MB2465F64BAEAED76DD32EE204F1889@BL0PR12MB2465.namprd12.prod.outlook.com>
 <CADnq5_P-o2Ut_V5JM=w4XMHDtDYvyU7Ub8dwbHJcTNQW+ko9=A@mail.gmail.com>
In-Reply-To: <CADnq5_P-o2Ut_V5JM=w4XMHDtDYvyU7Ub8dwbHJcTNQW+ko9=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee974a84-8d75-42a1-5174-08da654c52f9
x-ms-traffictypediagnostic: MN2PR12MB4094:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g/NxNBu9HggKv2fKPclCWHNCFU/H5ZSEO17OF0zkJf4PseHPcKJz5tVqbDplbzzEHjRwYFEG3eA4EPZLykfEPkB5cZrXtnm+2APFYAGsmbH6vU1jnsM4K8u/6rElXd7pRtNux3siYC4ji0rRPzU5H21NVOAadAsOvQNkW2v01WU3PYMQF/R4Ops7goU+z5jTap37J93G4Sl+y71WyD9D6BN72FYvWpnVcNiR0RuRjXpRZc3/ehXwIPufk/6HuYSHOIBfWImUp4nJ0y2vu9GqjTm/oRFD7fdP9jWbco23AnR8iyADti3uomKVrUjWHJ96GGzqkvyjYbSgX1RSufgtGsa4RS3Gn1krro+GkBE0HrFH7nSWiy1e78oV7AzthSBprohk00tFNCHhZNyvUslGa2W+xHr8VuwdhaQPF/GVZHVYqlz+vYE09WF6gZ275uhGH2YqKnNWyW8+dxt5Lg57jhP9pT6kRNZoENUUGL+mSgAg4aEct1ugVFkT+H1fo5+nOazSiL0i0c4kVrbwBIUbwH4qpmzdwA/Oj+9zQDlY0LO3qOltygENmNv/79wB2d+VL+4ontop5d/y/D0+Gr4/+x8lLAYuhN+cjZXuALVQRfx778Twmig4vETW628gQXm+6FzV/VHcIWXetQQTFqA2djuh7ef2CSDl0QEB1OuMBSqExfRw5yYSbq7StTQwJO9H1wyynNzWxlRt/n92x9ezemQr/S8KCShIDWSj+aPq8jPrWDw64WzCMOIfOg/svB6T5DPyFHaN9QRNSkQKaJCJdIuee6DJPD98sgy5xW/Ytvvga7yGIbUyWDxbsE6kx70c
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(8936002)(5660300002)(52536014)(122000001)(55016003)(38070700005)(2906002)(86362001)(83380400001)(33656002)(38100700002)(71200400001)(478600001)(6916009)(66476007)(66556008)(54906003)(66946007)(8676002)(316002)(66446008)(76116006)(186003)(6506007)(4326008)(64756008)(53546011)(41300700001)(7696005)(26005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUtyT0liN1ExTWsvTW8rcXNiTzdhc2t4OGs1d09ZTzBaSFYwMFgrdEwwM2pu?=
 =?utf-8?B?SFBXQnZMRGxqMHRVUUc3OVN6MW5JMUN6bUdQdXNsY3NCaVI3OEFobGxVb2Ix?=
 =?utf-8?B?a3VBZkw5NUVKWUFKMXRvOTI3MEtWLzNXRGtHY2RMZHBGYnNUaDdXMTVqOXVF?=
 =?utf-8?B?cU10aTdnZk5wazJYRDJZUG1mYkwzU1JvUkk5dEN1a3k5OVdkRWJVd1dVSTk5?=
 =?utf-8?B?QmNDSHlHZDVyRERBTUp6WThVeWpHRGx1bkFqWllKQjBtVlhSRnc1VC9lay96?=
 =?utf-8?B?UERnL0xoN2tCbzJsVS9mOFpkSERia1NwVmo3TS9ORDhtekFmQW5ZVVdHL0h4?=
 =?utf-8?B?Q3g4WTVxVVNHOUtnT1NEQVdIR0lTM1hCcFlnM1dKMDk2cXI2Ym5MM3JRM21Y?=
 =?utf-8?B?Y1k5RzZQcGlrSzQ4aE5KRTRYbkphUmd5VTRUN3g0azBtTlRTSG9qemxRVmll?=
 =?utf-8?B?MWUxNm5mVE5NTmtUY01jR0s5dGtGMGJvNWR0Rm5vdHdYUXdDNS90cUlmTVdu?=
 =?utf-8?B?b0ZSVlJ5QjR0YU9pTW83U0hVSDdvWmRhbElpbnE2NlRZUkMrTmRmSGlWVWk3?=
 =?utf-8?B?VlJnZHh4OGtwT1JtZlI1RVNQSmpzOTR0N0p5d0dsalZJeHhLSVVuYU5PWkl5?=
 =?utf-8?B?UVErU0JwUmx6VjNVMDNKUUZjYWxmUFBpWU9ZbmNzOXBNZmowaUMrQzdHMHlp?=
 =?utf-8?B?SmVuUnJsRUMvdDQ5aVhRSndqRXFheDF3VWVzTVIwbHpTYlNsS0pOc3pVYjYy?=
 =?utf-8?B?Yk1yNmFRSWlhc0x0WWM3MG5USGFXWCtlNExNaEJ2UGZwTExLU0tlcjlVL1VO?=
 =?utf-8?B?ektFamVZVUF6UEJsaTlVeldHSjhQa1AraDZWLzFod29FSVdRZFY1aWdaUFdk?=
 =?utf-8?B?ZFp4alVLMStZY055WkZ4eEVEazJrVzF4NEVuN04yYUwxQVZpbzE0S1N5WFBr?=
 =?utf-8?B?VVMwOGFQaCs0VUxKcmJ5Z0p6ZVZtMDNwRytrTXhQSnVMSkJtUjlsYWQwei9M?=
 =?utf-8?B?R2hwNllCUEZOUVI5NXdiOFdDbzQ0RU5iVGVnU2NVZnpKcmRvRHR2b3A1c1px?=
 =?utf-8?B?VlhyUlBNcmxjcjlYbWxVNDVxLzZTOXRWclZiVCtOVWw4SkxVZDA2UnJQTUIz?=
 =?utf-8?B?cmtnak8rbjhEN2xhQUc1bG9acHVZK0RYSTZEay9wblhhQ1RXT2VNYjZEaHFm?=
 =?utf-8?B?TE1PU2YrRXdkVjJwa085TitxS1ZhZVNFeHB6WDY2Q2NOT2NEU2EyKzVFbTI3?=
 =?utf-8?B?TkE1QjN0bzYxRFE2SHpFWndhZnRmSXJGa0RBOHZMMnowZFJCS3RJS202eDBO?=
 =?utf-8?B?SkNJSUYvZDlRWHREQVN5SWpSZlUwMUZUMnJveStDYXEyKzYwdHpsUTZmbEZF?=
 =?utf-8?B?OUpydEhMSGJIc1puRGJmNU9ZdHRkSGVoUHRpdkFOTGYzVHFzaEFESEdjaFBl?=
 =?utf-8?B?U2FhNTE4QnNwSnhXMFhPWVJid2twZDFjNXN5Yks0U0lJSS9RazlSVEJ4VEJH?=
 =?utf-8?B?S0xEUGFLVFRUSDFXNWEzenVmNHVvT2IvWFF0d1dvTzdra0VnczNmTHFLZDA1?=
 =?utf-8?B?UFdkZDlLempEemZ4ald1SnI1bEdORXJ3VWM3aVhHTUcrZXIvOTkyMjlHNTUw?=
 =?utf-8?B?dHAxS3NWdGtBUGZPOWZzbkVvOGl6VUc1MG55Vkg3MlM5MDZDWWRMVzExNERs?=
 =?utf-8?B?Q0EzV1kwSHdsSTd0VGRNY1dKMzJmNTNUazhNRnRSNXgwZHpmS0tRSW5vT09z?=
 =?utf-8?B?WnVxSjhvMXBoc1Y2dklLOEhiNzErSGRNYjFHWXZ6QTh5VHByeFIxS3dLRHlW?=
 =?utf-8?B?V3JuemdOUFZGWmhIbDlRaWFsNW5KdDNmVDMveVpoSlFjQ3ZITjFGb0tpRXhQ?=
 =?utf-8?B?bUtzSngvaWN3dDRDT3RLTTdtOGs5aEZiN0wvaENJZUZWZHRTcWkwcndjeHhq?=
 =?utf-8?B?WE5vd2VhTjh3NnE4d1A1Z2FBZTA5dDBMT3lKeDVGbENYN0ZNdU8vMUczRCtV?=
 =?utf-8?B?N050SEhrOENlM3JRRWdjSnBiejZGSC8xdU0wb3hmaW9LUi8weC9Uelc2dFN3?=
 =?utf-8?B?M2k4cW5RcDJzVGRNUkpoWW1pNWY0Q2ZrcEV5akN3Zjd4bXFxcVYvc2Z2VHBq?=
 =?utf-8?Q?jNR3BzjGr31EtW2Hy1ASWNsIQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee974a84-8d75-42a1-5174-08da654c52f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 03:52:51.0181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CelrivlI+WaX86taK5kZi/e9+H2gmLX7+JQRx+IX/6PcAo9eZU4Pk9lKubew+S+jbh++f52Euh31JU8pNFA/Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Feng, 
 Kenneth" <Kenneth.Feng@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U291bmRzIGdvb2QsIEFsZXguIExldCBtZSB1cGRhdGUgaXQgc29vbi4NCg0KQWxzbywgYWZ0ZXIg
YSBkaXNjdXNzaW9uIHdpdGggTGlqbywgb25jZSB3ZSBpbnRyb2R1Y2UgcnBtIG1vZGUsIHdlIHRo
aW5rIGl0J3MgZmluZSB0byBkcm9wIGFkZXYtPnJ1bnBtIGluZGljYXRvciBieSBycG0gbW9kZSwg
YXMgaXQncyBhIGJpdCBvdmVybGFwcGVkIHdpdGggbGF0dGVyIG9uZS4NClNvIGZvciB0aGUgY2hl
Y2sgbGlrZSBhZGV2LT5ydW5wbSwgd2UgY2FuIHVzZSAncnBtX21vZGUgIT0gQU1ER1BVX1JVTlBN
X05PTkUnIGluc3RlYWQuDQpJZiBpdCBtYWtlcyBzZW5zZSwgSSB3aWxsIHByb3ZpZGUgYSBmb2xs
b3cgdXAgcGF0Y2ggYXMgd2VsbCB0byBvcHRpbWl6ZSBpdC4NCg0KUmVnYXJkcywNCkd1Y2h1bg0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1
Y2hlckBnbWFpbC5jb20+IA0KU2VudDogVGh1cnNkYXksIEp1bHkgMTQsIDIwMjIgMTE6NDQgQU0N
ClRvOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQpDYzogYW1kLWdmeCBsaXN0
IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz47IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFt
ZC5jb20+OyBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgUXVhbiwgRXZhbiA8RXZh
bi5RdWFuQGFtZC5jb20+OyBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT4NClN1
YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1OiBza2lwIFNNVSBGVyByZWxvYWRpbmcg
aW4gcnVucG0gQkFDTyBjYXNlICh2MikNCg0KT24gV2VkLCBKdWwgMTMsIDIwMjIgYXQgMTE6MTUg
UE0gQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPiB3cm90ZToNCj4NCj4gUmU6IEkg
dGhpbmsgdGhpcyB3b3VsZCBiZSBiZXR0ZXIgYXM6DQo+IGlmIChhZGV2LT5pbl9ydW5wbSAmJiAo
YWRldi0+cG0ucnBtX21vZGUgIT0gQU1ER1BVX1JVTlBNX0JPQ08pKSBvciBzb21ldGhpbmcgbGlr
ZSB0aGF0Lg0KPg0KPiBZZXMsIHBhdGNoIDIgaW4gdGhpcyBzZXJpZXMgYWRkcmVzc2VzIGl0LiBQ
YXRjaCAxIGludGVuZHMgdG8gZml4IFNNVSByZWxvYWRpbmcsIHdoaWxlIHBhdGNoIDIgZm9jdXMg
b24gZml4aW5nIHJhY2UgaXNzdWUgd2hlbiBnZXR0aW5nIGZlYXR1cmUgbWFzayBkdXJpbmcgcnVu
dGltZSBjeWNsZS4NCg0KSSBnZXQgdGhhdCwgYnV0IEkgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVy
IHRvIHN3aXRjaCB0aGUgb3JkZXIgb2YgdGhlIHBhdGNoZXMgYW5kIHRoZW4gdXNlIHRoZSBycG1f
bW9kZSBpbiB0aGlzIHBhdGNoIGFzIHdlbGwuICBUaGF0IHdheSB3ZSBhcmUgY29uc2lzdGVudCBh
bmQgd2UgZG9uJ3QgbWlzcyBzb21lIGNhc2UgaWYgd2UgY2hhbmdlIHRoZSBCQUNPIG9yIEJPQ08g
bG9naWMgaW4gdGhlIGZ1dHVyZS4NCg0KQWxleA0KDQo+DQo+IFJlZ2FyZHMsDQo+IEd1Y2h1bg0K
Pg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFs
ZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDEzLCAyMDIyIDEx
OjMxIFBNDQo+IFRvOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQo+IENjOiBh
bWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgRGV1Y2hlciwgQWxl
eGFuZGVyIA0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxI
YXdraW5nLlpoYW5nQGFtZC5jb20+OyANCj4gTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNv
bT47IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPjsgDQo+IEZlbmcsIEtlbm5ldGggPEtl
bm5ldGguRmVuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHJtL2FtZGdw
dTogc2tpcCBTTVUgRlcgcmVsb2FkaW5nIGluIHJ1bnBtIA0KPiBCQUNPIGNhc2UgKHYyKQ0KPg0K
PiBPbiBUdWUsIEp1bCAxMiwgMjAyMiBhdCAxMToxOCBQTSBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNo
ZW5AYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBTTVUgaXMgYWx3YXlzIGFsaXZlLCBzbyBpdCdz
IGZpbmUgdG8gc2tpcCBTTVUgRlcgcmVsb2FkaW5nIHdoZW4gDQo+ID4gcnVucG0gcmVzdW1lZCBm
cm9tIEJBQ08sIHRoaXMgY2FuIGF2b2lkIHNvbWUgcmFjZSBpc3N1ZXMgd2hlbiANCj4gPiByZXN1
bWluZyBTTVUgRlcuDQo+ID4NCj4gPiB2MjogRXhjbHVkZSBib2NvIGNhc2UgaWYgYW4gQVNJQyBz
dXBwb3J0cyBib3RoIGJvY28gYW5kIGJhY28NCj4gPg0KPiA+IFN1Z2dlc3RlZC1ieTogRXZhbiBR
dWFuIDxldmFuLnF1YW5AYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHdWNodW4gQ2hlbiA8
Z3VjaHVuLmNoZW5AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3BzcC5jIHwgOCArKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3BzcC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcHNwLmMNCj4gPiBpbmRleCBlOTQxMWMyOGQ4OGIuLmRlNTlkYzA1MTM0MCAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4gPiBAQCAtMjM0OCw2
ICsyMzQ4LDE0IEBAIHN0YXRpYyBpbnQgcHNwX2xvYWRfc211X2Z3KHN0cnVjdCBwc3BfY29udGV4
dCAqcHNwKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICZhZGV2LT5maXJtd2FyZS51Y29k
ZVtBTURHUFVfVUNPREVfSURfU01DXTsNCj4gPiAgICAgICAgIHN0cnVjdCBhbWRncHVfcmFzICpy
YXMgPSBwc3AtPnJhc19jb250ZXh0LnJhczsNCj4gPg0KPiA+ICsgICAgICAgLyogU2tpcCBTTVUg
RlcgcmVsb2FkaW5nIGluIGNhc2Ugb2YgdXNpbmcgQkFDTyBmb3IgcnVucG0gb25seSwNCj4gPiAr
ICAgICAgICAqIGFzIFNNVSBpcyBhbHdheXMgYWxpdmUuDQo+ID4gKyAgICAgICAgKi8NCj4gPiAr
ICAgICAgIGlmIChhZGV2LT5pbl9ydW5wbSAmJg0KPiA+ICsgICAgICAgICAgICFhbWRncHVfZGV2
aWNlX3N1cHBvcnRzX2JvY28oYWRldl90b19kcm0oYWRldikpICYmDQo+ID4gKyAgICAgICAgICAg
YW1kZ3B1X2RldmljZV9zdXBwb3J0c19iYWNvKGFkZXZfdG9fZHJtKGFkZXYpKSkNCj4NCj4gSSB0
aGluayB0aGlzIHdvdWxkIGJlIGJldHRlciBhczoNCj4gaWYgKGFkZXYtPmluX3J1bnBtICYmIChh
ZGV2LT5wbS5ycG1fbW9kZSAhPSBBTURHUFVfUlVOUE1fQk9DTykpIG9yIHNvbWV0aGluZyBsaWtl
IHRoYXQuDQo+DQo+IEFsZXgNCj4NCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4g
Kw0KPiA+ICAgICAgICAgaWYgKCF1Y29kZS0+ZncgfHwgYW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRl
dikpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+DQo+ID4gLS0NCj4gPiAyLjE3
LjENCj4gPg0K
