Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376ABC61DA4
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Feb 2023 06:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2626510E06A;
	Thu, 16 Feb 2023 06:48:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC19110E06A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 06:48:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJhWIgOtiWmi/ePn1rvQq9gAnEYAaZSZW+todFQ0KgNG+KUm6uF5yIH17CwXQ3rhVUG/yGOz5kPLFMXje4dpim+hS+V84F8WsJKVNg6IEvzZ5AtRjsrBO4YXsQ7GuqMF6U6cGDDk58/Zdy7yR9wzVnL2YgjyrRQqcAHEf69OKVUBGZOptcZFt2BUOoDUVSi55ylhE5SUeYzZef0bcMVGlMiXlV9Cw+nDy5OlcAUKHAPlxj4dxhUv3J+OX8QdLlD8MudfS7PRmGSz7XvQUL7Upu9QywhbJ2Q0dc7l+CiZhz1cp0rJ+1k8ctEojSeurkLB2FA7HlKnfgOCYdegP7okfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t677h9ZsC43gobto8B9i/5WQsptwPkPD/PN1ypdsRyI=;
 b=csNAEKdSCGWOOP/SXL+m9pdeSpygnwZcXk4PC0LpDV09+OwASLdJJHPIXbF9i7Hbw/lnSgInyZHdq48JPk71IcZxNmt2JUNk8MSTYjqwHZ6Rgh58zV2JcqcqfY9e3ZdLEUV/f9MAapz9mzwPOOnLUKHYuDneiNAsQxI7S1jEB7HfPB1YjUvsiXTVkcvK0r/KM68KEbSQgB9k/Xq9Tu5pvPKjaRXLumA7h/YAVa9TZ6sXbwEaEX+kG5rSUqaPyhc3jp1Rwep8iFcrbp9YI/8lqpg1TZcLfdIP+4LlgKRlQ2uftp1Ug+gg2vud2r+VLtT9aCZSFqvOBVejeMgPk/PY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t677h9ZsC43gobto8B9i/5WQsptwPkPD/PN1ypdsRyI=;
 b=FpS5YRQ6/U1L/VVUgOK76JfExJnJ7+2zmnIYXoejAPoQjmeQtuoVarCyMRj+NQrw/Zka/SZ5J94P39f3QYVedxkYav1zV/hytmE4citQZrO+LTyDpiMrcDAlHq5rd0F249fdHc6gtSJSBhd/CoVUWghSq75HYdImYKKZkwcMUvY=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by SJ0PR12MB6901.namprd12.prod.outlook.com (2603:10b6:a03:47e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 06:48:46 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::66d:8790:631b:f03]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::66d:8790:631b:f03%5]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 06:48:46 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Paneer Selvam, Arunpravin"
 <Arunpravin.PaneerSelvam@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when using drm
 buddy
Thread-Topic: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when using drm
 buddy
Thread-Index: AQHZQGYt6UtYU+TqfkGPLAP/umhypK7OYmkAgAAYTNCAAFJDgIAAeHgAgACOmwCAAMIMgIAAQGZw
Date: Thu, 16 Feb 2023 06:48:46 +0000
Message-ID: <DM4PR12MB5261B9EFFEFB88A558B7E3C39DA09@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20230214111851.2525197-1-shane.xiao@amd.com>
 <ca40db72-6c04-e3cd-38f9-3254f37c850a@amd.com>
 <DM4PR12MB526136D00F81419EEFCE47579DA29@DM4PR12MB5261.namprd12.prod.outlook.com>
 <0a5fd1ae-45b0-96bb-5160-a34b57fc6a2a@amd.com>
 <DM4PR12MB52616659C39CB1242A4AD8B89DA39@DM4PR12MB5261.namprd12.prod.outlook.com>
 <62ca76cc-a553-21c2-9538-03cefb7b02ac@gmail.com>
 <46fd3add-e02e-9a88-f672-3ef09da1aced@amd.com>
In-Reply-To: <46fd3add-e02e-9a88-f672-3ef09da1aced@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|SJ0PR12MB6901:EE_
x-ms-office365-filtering-correlation-id: 2f52e6ed-1957-4aae-46dc-08db0fe9d9eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FjwJ4w+8JLWb70fle+SLdCFjrCfXfoWwHkJqmJnH26VkwYJIuF3yRLQBElxQQPRU9kVKF7uEH/u0ZB/M49mgS8lNuLrfLsMd3/CoYkiAQha/MHh49YjAraxGAOHM+ISl9/GsVYMghYv89PEVGnszfpVsE+FUYs70kOHLRjNVBH89QlM4T4vKL6b50WTCBygjlLlOtDyGpcCno4rjXxz2EdcSPgcUrtrRbKrxzFL9pe7RaWEya9RVSgKHr6/1CjOXgNuWpE4ARGv+pXz8m0KLBm9uZnKaCLM+nrPAUMY4oHefn9sVCUi9G0ZJ4TdwP6IsG7w9Od5GDOp6OppcqI84bwcyZPZsdAYQrdWkJ/MPrH1G4aRnTi8vqp+NQKsyWvTqMd0K1vVQRoqJR8rvntUt2tsuOpQQvFsC1OyHvhHnvPn9HaRyW0muapc9/xFETTXlsA2qJQO5qLEtPC/BHUeE1W20qAcJRuD2zBWFKLwRkK6C5sM/Um5Q1GDODSS5X1idKOnZYMiRYCbfDBYzIw1sewAN9m+qT/2MGJQvZsLmnqa7/2tPgQ/bUsFYsFeqLWxldjkuBltpPTqOelWTmf2lsv2CeDcmbYS3cUa+5As9h8WVbccb9/t5XC/B2QrssE556bWhqfF4ghkq0bn5Dh3BxrvoGoD8nJlKRlklS0s7T61EGu6LYLwn46NPTtFr9QN9yjxXCpjLteEifrmxPuRiUQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199018)(8936002)(2906002)(52536014)(41300700001)(5660300002)(76116006)(4326008)(64756008)(66476007)(66946007)(8676002)(66556008)(66446008)(316002)(110136005)(478600001)(6636002)(7696005)(6506007)(38100700002)(122000001)(55016003)(26005)(38070700005)(66574015)(33656002)(53546011)(71200400001)(9686003)(186003)(86362001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXZzMVM0TWNQTjcwMmNqQ1F3TzJFQndYbVlva25VL2RhZkNkMFJkU3lYVXRR?=
 =?utf-8?B?enc3NXoxZHRuN1FFVjliN0pPQi9hTG1pMnAvRmRyOFdPL1FnTE4xQmlvSDNT?=
 =?utf-8?B?dzYzT3lJTnZVLzFmRktrd3JvbVJyMzRQa3VaL2FSTlNMc3BQMGZYb1B4ZjQ3?=
 =?utf-8?B?V3p5L1Bub1plT1QvRGVDbXRia0tSenRQUUlNK1Ywck1KOXUraGliRjBmdVpM?=
 =?utf-8?B?S0MwaEZkTmRDd3J0SUlraXRkOElPajkvVUNCMGs0dlEzR2pHeFlpdmk1YXh2?=
 =?utf-8?B?OGwvTEkzZHBYQ1Fkand6ZUQwYng5YVpFNXd6R2dIbU83bDczWDFYN2p6NWwz?=
 =?utf-8?B?Z2lMTFRsQlVqQnRaNnRpVHllRkhtM1RNcnM4VHRGQXFQay9MNFhLVy93WGV1?=
 =?utf-8?B?MzhQM0FRUGZMMzFsYkdUSjBKaUhnZEIvSFQwSy83WDlKWWlDa0hHa1dNMmM2?=
 =?utf-8?B?ZHVadjJGRXpNZzFtNFQwZURYRkxpVk9aaHdHQk5jMDVRWkFldjVFcGhhTDlW?=
 =?utf-8?B?VG9OOVM5OXVWeGMwR3VwQzdZYTdHZUM1N3Y3VjJuTkJ1Yk5ZbTdraG9VMWFa?=
 =?utf-8?B?NzNoWG1TbHd6aS8wTWhHUjR0SUFOVjJBYk55VjI3RHVMSmF2YkFrc2dVTXJk?=
 =?utf-8?B?VkFTYy82VTFEemI3UVhQUHVRUUxVMHZkdzBpUFh1YlIyVVdYV3N2NlFINzRq?=
 =?utf-8?B?WDA4cGk5RklqSzBJZ09CYWtoeXE2T0VVcFRGbm9DL29icWxxR0VyK2dWdkJD?=
 =?utf-8?B?ZkVwSDlsYWFsL2U0ZTdEclZ6YW9LUFdsZjlxV1VxTDRDVFBkcmxTZnhuY0lt?=
 =?utf-8?B?b21KR0RORm1KUlp1N3piZ1ZxU1E3WTBGeVZCOVdNZWZVM0V4NkNWOGk2dFRW?=
 =?utf-8?B?c2JvdkMrVzZVbDhLelNnc3dHNEVXdHo0RStzY0VYZ1E2a3BmVkFKY0JTMHd6?=
 =?utf-8?B?TWc2aXVQNHlpcy8yRm1jVkpjVVJpdkVPSlYxZ0VPbkFqS3U4WFZ0dE80VFg0?=
 =?utf-8?B?TVFVbFZHSXphR1JhbzNKMkdSWjhWN1VDM3Vwd2M3YmZCMXd4S251Kzc3Q3Fx?=
 =?utf-8?B?Q2FqdUhqOGt2UXBFWjBIb1FUS2xsR0VlZldNd1UwSFNsZytUN0FXdEw0NEdw?=
 =?utf-8?B?ZVVGWGxOOENtdHdGdi9Ca3hoNlNYaXM0UXBxbWVDam5IUk80cVBGb0Z0b3Nt?=
 =?utf-8?B?aldYemtVTlVKdHNuUCs2Y3plR1lqNGpjaHpyUTN1R3Z0RHBNWHFJWXgzMitR?=
 =?utf-8?B?WVZpUkFwb280NkRvVDYvbXl2NCtMQytpLysrVHRHbEhveDBTaDBJMzNpM04z?=
 =?utf-8?B?cTc1aXRIM3VRYXRCaTVtaTNRdytLdEE4WmhGS2pkWkx2VWVvMzlYT2xxdWt5?=
 =?utf-8?B?U2dobGV4ZDdFTDJxdmZDQmxRK2YvUjlsQXk0MERZOTVGUW1CeG9YTnNORGw1?=
 =?utf-8?B?ZkxEUEJ4SGNUV3ZHZHBDLy94MlBYLyswSUhRVzB3Rll0bEhqUm9GQTBJUWZq?=
 =?utf-8?B?NDJpM2JmaTRVejNUQXNRRjRFZ25XQTBSbzlVRkRoSHpkaTZoNEhFVFgxOVB3?=
 =?utf-8?B?Y2dyR0FvaHdidkNGV3B5Tkk0a0UzNFh5eGVGN25pdVZWUzZLZzhyVE9QVzlU?=
 =?utf-8?B?QUJUTEFTNjIxc3VnMUxCR0xia1FDMURJZFl5WUFXenFZUytkMy9PS2U1aFpJ?=
 =?utf-8?B?eEFRYlVQSXQ4MWFpbU5nYUthQlIvRzIzbGdla2hWZVN2dFpQTE8yaldsNDh6?=
 =?utf-8?B?dkQ2dnJ1L1FaS2hGUjBVRFNza1lZRzluRHdjSTlDZ29uQ0pVVkJDYzR0OEQy?=
 =?utf-8?B?a0toYjF4emsxbHpsaU5jdXFNWHZnZ0hJUS9kSlR2RjRJY211V0RBYk5JNkpP?=
 =?utf-8?B?VHI5R3VzcUZ2WWp4QUpYaTFEdnE4bEw3VXp4OHJqb1J4aWNZeFJ6TENPdkI4?=
 =?utf-8?B?cGJ0OGppY0l2WnM1T3NzdnMwZHIwR2t4a0FlTi91dGU0MENxNFNyMEUwakYx?=
 =?utf-8?B?dDNmbzRReTM3REJBdVQyM0s3SDMwQzdRQ3dnMnlvYURDOHlJMlY2a0xlMUNy?=
 =?utf-8?B?Vzk0NW1XVFZlbFNjOVdIS1BYTUt3S0JFemtOSTkrWGFTcitQeEZSTFJMYnpV?=
 =?utf-8?Q?TxNmp5o2B2z/t9nGl8GhnSPMt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f52e6ed-1957-4aae-46dc-08db0fe9d9eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 06:48:46.0772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOE296IsoyWq9h0lt0GzyPhvikyX2sKu/lRHYaosLXbpKLrlbCJoxqZ1qtczl5uOu8bmYEgyuBnpdJHwl9NiJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6901
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMTYs
IDIwMjMgNjoxOSBBTQ0KPiBUbzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1l
cmtlbkBnbWFpbC5jb20+OyBYaWFvLCBTaGFuZQ0KPiA8c2hhbmUueGlhb0BhbWQuY29tPjsgS29l
bmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47DQo+IFBhbmVlciBTZWx2
YW0sIEFydW5wcmF2aW4gPEFydW5wcmF2aW4uUGFuZWVyU2VsdmFtQGFtZC5jb20+DQo+IENjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0g
ZHJtL2FtZGdwdTogb3B0aW1pemUgVlJBTSBhbGxvY2F0aW9uIHdoZW4gdXNpbmcNCj4gZHJtIGJ1
ZGR5DQo+IA0KPiANCj4gQW0gMjAyMy0wMi0xNSB1bSAwNTo0NCBzY2hyaWViIENocmlzdGlhbiBL
w7ZuaWc6DQo+ID4gQW0gMTUuMDIuMjMgdW0gMDM6NTEgc2NocmllYiBYaWFvLCBTaGFuZToNCj4g
Pj4gRm9yIHB1YmxpYyByZXZpZXcNCj4gPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4+PiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0K
PiA+Pj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAxNSwgMjAyMyAzOjAyIEFNDQo+ID4+PiBU
bzogWGlhbywgU2hhbmUgPHNoYW5lLnhpYW9AYW1kLmNvbT47IFBhbmVlciBTZWx2YW0sIEFydW5w
cmF2aW4NCj4gPj4+IDxBcnVucHJhdmluLlBhbmVlclNlbHZhbUBhbWQuY29tPg0KPiA+Pj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IG9wdGltaXplIFZSQU0gYWxsb2NhdGlv
biB3aGVuDQo+ID4+PiB1c2luZyBkcm0gYnVkZHkNCj4gPj4+DQo+ID4+PiBBbSAxNC4wMi4yMyB1
bSAxNTo1MyBzY2hyaWViIFhpYW8sIFNoYW5lOg0KPiA+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+Pj4+PiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5p
Z0BhbWQuY29tPg0KPiA+Pj4+PiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAxNCwgMjAyMyA4OjQx
IFBNDQo+ID4+Pj4+IFRvOiBYaWFvLCBTaGFuZSA8c2hhbmUueGlhb0BhbWQuY29tPjsgYnJhaG1h
X3N3X2Rldg0KPiA+Pj4+PiA8YnJhaG1hX3N3X2RldkBhbWQuY29tPg0KPiA+Pj4+PiBDYzogUGFu
ZWVyIFNlbHZhbSwgQXJ1bnByYXZpbg0KPiA8QXJ1bnByYXZpbi5QYW5lZXJTZWx2YW1AYW1kLmNv
bT4NCj4gPj4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IG9wdGltaXpl
IFZSQU0gYWxsb2NhdGlvbg0KPiB3aGVuDQo+ID4+Pj4+IHVzaW5nIGRybSBidWRkeQ0KPiA+Pj4+
Pg0KPiA+Pj4+PiBBbSAxNC4wMi4yMyB1bSAxMjoxOCBzY2hyaWViIFNoYW5lIFhpYW86DQo+ID4+
Pj4+PiBTaW5jZSB0aGUgVlJBTSBtYW5hZ2VyIGNoYW5nZWQgZnJvbSBkcm0gbW0gdG8gZHJtIGJ1
ZGR5LiBJdCdzDQo+IG5vdA0KPiA+Pj4+Pj4gbmVjZXNzYXJ5IHRvIGFsbG9jYXRlIDJNQiBhbGln
bmVkIFZSQU0gZm9yIG1vcmUgdGhhbiAyTUINCj4gPj4+Pj4+IHVuYWxpZ25lZCBzaXplLCBhbmQg
dGhlbiBkbyB0cmltLiBUaGlzIG1ldGhvZCBpbXByb3ZlcyB0aGUNCj4gPj4+Pj4+IGFsbG9jYXRp
b24gZWZmaWNpZW5jeSBhbmQgcmVkdWNlcyBtZW1vcnkgZnJhZ21lbnRhdGlvbi4NCj4gPj4+Pj4g
V2VsbCB0aGF0IGlzIGEgdHJhZGUgb2ZmLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBBbGxvY2F0aW5nIHRo
ZSBCTyBhcyBvbmUgY29udGlndW91cyBjaHVuayBhbmQgdGhlbiB0cmltbWluZyBpcw0KPiA+Pj4+
PiBiZW5lZmljaWFsIGJlY2F1c2UgaWYgd2UgdGhlbiBsYXRlciBuZWVkIGl0IGNvbnRpZ3VvdXMg
d2UgZG9uJ3QNCj4gPj4+Pj4gbmVlZCB0byByZS1hbGxvY2F0ZSBhbmQgY29weS4gVGhpcyBjYW4g
YmUgbmVlZGVkIHRvIGRpc3BsYXkNCj4gPj4+Pj4gc29tZXRoaW5nIGZvcg0KPiA+Pj4gZXhhbXBs
ZS4NCj4gPj4gSGkgQ2hyaXN0aWFuLA0KPiA+Pg0KPiA+PiBUaGlzIGNhc2UgbWVhbnMgdGhhdCB5
b3UgYWxsb2NhdGUgQk8gdGhhdCBpcyB1bm5lY2Vzc2FyeSB0byBiZQ0KPiA+PiBjb250aW51b3Vz
IGF0IGZpcnN0IHRpbWUsIGFuZCBsYXR0ZXIgdGhlIEJPIHNob3VsZCBiZSBjb250aW51b3VzLiBJ
J20NCj4gPj4gbm90IGZhbWlsaWFyIHdpdGggZGlzcGxheS4gQ291bGQgeW91IGdpdmUgbWUgYSBm
ZXcgbW9yZSBzcGVjaWZpYw0KPiA+PiBleGFtcGxlcyA/DQo+ID4NCj4gPiBPbiBtb3N0IGdlbmVy
YXRpb25zIERDRS9EQ04gaGFyZHdhcmUgbmVlZHMgdGhlIGJ1ZmZlciBjb250aWd1b3VzIHRvDQo+
IGJlDQo+ID4gYWJsZSB0byBzY2Fub3V0IGZyb20gaXQuDQo+ID4NCj4gPiBPbmx5IG5ld2VyIEFQ
VXMgY2FuIHVzZSBTL0cgdG8gc2Nhbm91dCBmcm9tIHN5c3RlbSBtZW1vcnkgcGFnZXMuDQo+ID4N
Cj4gPj4+PiBZZXMsIEkgYWdyZWUgdGhhdCBvbmUgY29udGlndW91cyBjaHVuayBtYXkgZ2V0IGJl
bmVmaWNpYWwgc29tZXRpbWVzLg0KPiA+Pj4+IEJ1dCBhcyBmYXIgYXMgSSBrbm93LCB5b3UgY2Fu
bm90IGd1YXJhbnRlZSB0aGF0DQo+IGFtZGdwdV92cmFtX21ncl9uZXcNCj4gPj4+IGNhbiBnZXQg
b25lIGNvbnRpZ3VvdXMgY2h1bmvCoCBpZiB5b3UgZG9uJ3Qgc2V0DQo+ID4+PiBUVE1fUExfRkxB
R19DT05USUdVT1VTIGZsYWdzLg0KPiA+Pj4+IEZvciBleGFtcGxlLCBpZiB5b3Ugd2FudCB0byBh
bGxvY2F0ZSA0TSs0SyBCTywgaXQgd2lsbCBhbGxvY2F0ZSBvbmUNCj4gPj4+PiA0TSBibG9jaw0K
PiA+Pj4gKyBvbmUgMk0gYmxvY2sgd2hpY2ggaXMgdW5uZWNlc3NhcnkgdG8gYmUgY29udGludW91
cywgdGhlbiAyTSBibG9jaw0KPiA+Pj4gd2lsbCBiZQ0KPiA+Pj4gdHJpbW1lZC4NCj4gPj4+DQo+
ID4+PiBPaCwgdGhhdCdzIGluZGVlZCBub3Qgc29tZXRoaW5nIHdoaWNoIHNob3VsZCBoYXBwZW4u
IFNvdW5kcyBtb3JlDQo+ID4+PiBsaWtlIGEgYnVnIGZpeCB0aGVuLg0KPiA+PiBZZXMsIEkgdGhp
bmsgdGhpcyBjYXNlIHNob3VsZCBub3QgYmUgaGFwcGVuZWQuDQo+ID4+IEFjdHVhbGx5LCBJJ20g
bm90IHN1cmUgdGhhdCB3aHkgdGhlIGFsbG9jYXRlZCBCTyBzaG91bGQgYmUgYWxpZ25lZA0KPiA+
PiB3aXRoIHBhZ2VzX3Blcl9ibG9jaywgd2hpY2ggaXMgc2V0IHRvIDJNQiBieSBkZWZhdWx0Lg0K
PiA+PiBEb2VzIHRoaXMgaGVscCBpbXByb3ZlIHBlcmZvcm1hbmNlIHdoZW4gYWxsb2NhdGluZyAy
TSBvciBhYm92ZSBCTz8NCj4gPj4gwqBGcm9tIG15IHBvaW50IG9mIHZpZXcsIHRoZSBUTEIgbWF5
IGJlIG9uZSBvZiByZWFzb24gb2YgdGhpcy4gQnV0IEknbQ0KPiA+PiBub3Qgc3VyZSBhYm91dCB0
aGlzLg0KPiA+DQo+ID4gWWVzLCB3ZSB0cnkgdG8gdXNlIGFsbG9jYXRpb25zIHdoaWNoIGFyZSBh
cyBjb250aWd1b3VzIGFzIG11Y2ggYXMNCj4gPiBwb3NzaWJsZSBmb3IgYmV0dGVyIFRMQiB1c2Fn
ZS4NCj4gPg0KPiA+IEVzcGVjaWFsbHkgZm9yIHNvbWUgY29tcHV0ZSB1c2UgY2FzZXMgdGhpcyBj
YW4gbWFrZSBhID4yMCUgcGVyZm9ybWFuY2UNCj4gPiBkaWZmZXJlbmNlLg0KPiBXZSBhY3R1YWxs
eSBmb3VuZCB0aGF0ID4yTUIgdmlydHVhbCBhZGRyZXNzIGFsaWdubWVudCB3YXMgaHVydGluZw0K
PiBwZXJmb3JtYW5jZSBkdWUgdG8gY2FjaGUgbGluZSBhbGlhc2luZy4gU28gd2UgY2FuJ3QgdGFr
ZSBhZHZhbnRhZ2Ugb2YgID4yTUINCj4gcGFnZXMgaW4gb3VyIHBhZ2UgdGFibGVzLg0KPiANCj4g
UmVnYXJkcywNCj4gIMKgIEZlbGl4DQoNClllcywgaWYgd2Ugd2FudCB0byB0YWtlIGFkdmFudGFn
ZSBvZiAyTSBUTEIgdXNhZ2UsIHdlIHNob3VsZCBrZWVwIHZpcnR1YWwgYWRkcmVzcyBhbGlnbmVk
Lg0KDQpBcyB5b3UgaGF2ZSBtZW50aW9uZWQgdGhhdCBjYWNoZSBsaW5lIGFsaWFzaW5nIGlzc3Vl
LCBJJ20gY29uZnVzZWQgYWJvdXQgdGhpcy4NCklmIDJNQiBhbGlnbmVkIFZBIGdldCB0aGUgcmln
aHQgUEEgZnJvbSBUTEIgb3IgcGFnZSB0YWJsZSBhbmQgdGhlIGNhY2hlIGxpbmUgYWRkcmVzc2lu
ZyBtb2RlIGlzIG5vdCBjaGFuZ2VkLA0KdGhlIGNhY2hlIGxpbmUgYWxpYXNpbmcgaXNzdWUgc2hv
dWxkIG5vdCBoYXBwZW4gaGVyZS4NCklzIHRoZXJlIHNvbWV0aGluZyB3cm9uZyB3aXRoIG15IHVu
ZGVyc3RhbmRpbmc/IE9yIG1heWJlIHRoZXJlIGFyZSBzb21lIGJhY2tncm91bmRzIHRoYXQgSSBk
aWRuJ3Qga25vdy4NCg0KQmVzdCBSZWdhcmRzLA0KU2hhbmUNCiANCj4gDQo+IA0KPiA+DQo+ID4g
UmVnYXJkcywNCj4gPiBDaHJpc3RpYW4uDQo+ID4NCj4gPj4NCj4gPj4gQmVzdCBSZWdhcmRzLA0K
PiA+PiBTaGFuZQ0KPiA+Pg0KPiA+Pj4+PiBPbiB0aGUgb3RoZXIgaGFuZCBJIGNvbXBsZXRlbHkg
YWdyZWUgYWxsb2NhdGluZyBiaWcgYW5kIHRoZW4NCj4gPj4+Pj4gdHJpbW1pbmcgY3JlYXRlcyBt
b3JlIGZyYWdtZW50YXRpb24gdGhhbiBuZWNlc3NhcnkuDQo+ID4+Pj4+DQo+ID4+Pj4+IERvIHlv
dSBoYXZlIHNvbWUgdGVzdCBjYXNlIHdoaWNoIGNhbiBzaG93IHRoZSBkaWZmZXJlbmNlPw0KPiA+
Pj4+IEkgaGF2ZSB1c2Ugcm9jcnRzdCB0byBzaG93IHRoZSBkaWZmZXJlbmNlLg0KPiA+Pj4+IFRo
ZSBhdHRhY2htZW50IGlzIHNob3duIHRoYXQgYWZ0ZXIgYXBwbHlpbmcgdGhpcyBwYXRjaCwgdGhl
IG9yZGVyIDwNCj4gPj4+PiA5IHRvdGFsDQo+ID4+PiB2cmFtIHNpemUgZGVjcmVhc2UgZnJvbSA5
OU1CIHRvIDQzTUIuDQo+ID4+Pj4gQW5kIHRoZSBsYXR0ZXIgaGFzIG1vcmUgaGlnaGVyIG9yZGVy
IGJsb2NrIG1lbW9yeS4NCj4gPj4+IEFydW4gY2FuIHlvdSB0YWtlIGEgbG9vaz8gVGhhdCBwcm9i
bGVtIGhlcmUgc291bmRzIGltcG9ydGFudC4NCj4gPj4+DQo+ID4+PiBUaGFua3MsDQo+ID4+PiBD
aHJpc3RpYW4uDQo+ID4+Pg0KPiA+Pj4+PiBCVFc6IE5vIG5lZWQgdG8gZGlzY3VzcyB0aGF0IG9u
IHRoZSBpbnRlcm5hbCBtYWlsaW5nIGxpc3QsIHBsZWFzZQ0KPiA+Pj4+PiB1c2UgdGhlIHB1Ymxp
YyBvbmUgaW5zdGVhZC4NCj4gPj4+Pj4NCj4gPj4+PiBJIHdpbGwgc2VuZCBpdCB0byBwdWJsaWMu
IFRoYW5rIHlvdSBmb3IgeW91ciByZW1pbmQuDQo+ID4+Pj4NCj4gPj4+PiBCZXN0IFJlZ2FyZHMs
DQo+ID4+Pj4gU2hhbmUNCj4gPj4+Pg0KPiA+Pj4+PiBSZWdhcmRzLA0KPiA+Pj4+PiBDaHJpc3Rp
YW4uDQo+ID4+Pj4+DQo+ID4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTaGFuZSBYaWFvIDxzaGFuZS54
aWFvQGFtZC5jb20+DQo+ID4+Pj4+PiAtLS0NCj4gPj4+Pj4+IMKgwqDCoCBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYyB8IDIgKy0NCj4gPj4+Pj4+IMKgwqDCoCAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPj4+Pj4+DQo+
ID4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zy
YW1fbWdyLmMNCj4gPj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zy
YW1fbWdyLmMNCj4gPj4+Pj4+IGluZGV4IDc1YzgwYzU1N2I2ZS4uM2ZlYTU4Zjk0MjdjIDEwMDY0
NA0KPiA+Pj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1f
bWdyLmMNCj4gPj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
cmFtX21nci5jDQo+ID4+Pj4+PiBAQCAtNDUzLDcgKzQ1Myw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1
X3ZyYW1fbWdyX25ldyhzdHJ1Y3QNCj4gPj4+Pj4gdHRtX3Jlc291cmNlX21hbmFnZXIgKm1hbiwN
Cj4gPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogTGltaXQgbWF4aW11bSBzaXplIHRv
IDJHaUIgZHVlIHRvIFNHIHRhYmxlDQo+ID4+Pj4+PiBsaW1pdGF0aW9ucyAqLw0KPiA+Pj4+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplID0gbWluKHJlbWFpbmluZ19zaXplLCAyVUxMIDw8
IDMwKTsNCj4gPj4+Pj4+DQo+ID4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKHNpemUgPj0gKHU2
NClwYWdlc19wZXJfYmxvY2sgPDwgUEFHRV9TSElGVCkNCj4gPj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oCBpZiAoIShzaXplICUgKCh1NjQpcGFnZXNfcGVyX2Jsb2NrIDw8IFBBR0VfU0hJRlQpKSkNCj4g
Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtaW5fYmxvY2tfc2l6ZSA9ICh1
NjQpcGFnZXNfcGVyX2Jsb2NrIDw8DQo+ID4+Pj4+IFBBR0VfU0hJRlQ7DQo+ID4+Pj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGN1cl9zaXplID0gc2l6ZTsNCj4gPg0K
