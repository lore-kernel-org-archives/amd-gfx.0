Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D79C636D7
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Feb 2023 23:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4FF710E396;
	Tue, 21 Feb 2023 23:27:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFCC310E38E
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Feb 2023 23:27:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbrQ+VLuw3Xx14MCQJxo2dJlm5VIYfMWLjz5hAF2gndQZVFtPtGr8bGMAz0DtPn66asoNZGx0zcZnquzFdlNyE6NMBp+xls8gIWGGn1Q9tKT4s1nQ4jWq//ffrhwXwlfqDy/zmRBQ5qU4lSlTHfsQTFWg6OV7L6e5xaW1FB/LZCwEpKdmtEa7qUJPxz8es4FLK8QMvpByr2RiNaOlXuOwh6/dd9FtaZ6Aeac/BtoXWj+pXfUGnVHRQn0FpuCL7TqjP9UjflIPn4eAsDHmH8C4AD/OUt+Isb+2iLQbMWavQBGaMysEjWK8uRM2Xu2QT/rMxlFazheTe3BduDqVUHLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whin8PD5s1MjlGw4SDYwC9EwVNThdspHAB6pqBqertw=;
 b=VuTk+eI3DpKz7UEWjJ0nIBA3qeRJFOOTccr5b+xuEzmZg8CQmPx8FyFHbwwjCruLF2UFFcKUK7q8ciBbx1B2UrmwLFc4EA5x9/UF1+5dSQYOQ+AeO9dftb8oa4HJQ3o+wVC7ei0oa1ObSG0Krvd+qqxjRW7W5oIXaao4aSGyhaPDqirY6VkgZlt3YlaDOpor2xAclyhl05uvTLbvZxe7l9z/OWrZKna92uRzpUbuNs4W7aXUzQZp2h9GqtoXw3giWRkYmX4pGokPlLMiLotay379VdaEDB4L2K5Z86SZeuO2RNXmPNm1kPfUKgsMWOHJsxhSRgo2X+H/ZPX8PlxWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whin8PD5s1MjlGw4SDYwC9EwVNThdspHAB6pqBqertw=;
 b=emMfxAD8J1aJVM/xYY0XCcFy8vRbNyPFLT4+ltp2Oqt7fal27J6G+8ZnPe3XQLQ08dUC+YoRZHwkJIO3hv4N45exUJ4jzwJap0Nxwwea7P0RTScoSVojMKmLTMgVUUJuBxCL7hgxSs8H3Y8jFbCqwItkNgzWmHod2ZrCyoFk56U=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5279.namprd12.prod.outlook.com (2603:10b6:5:39f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Tue, 21 Feb
 2023 23:27:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6111.019; Tue, 21 Feb 2023
 23:27:24 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amd: Use runtime suspend in lieu regular suspend
 on supported dGPUs
Thread-Topic: [PATCH 2/3] drm/amd: Use runtime suspend in lieu regular suspend
 on supported dGPUs
Thread-Index: AQHZRWhDu4PJVzr+Jkaugpc6cM3cfK7ZY7OAgACo4NA=
Date: Tue, 21 Feb 2023 23:27:24 +0000
Message-ID: <MN0PR12MB610140110790FBD1FEFE8760E2A59@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230220201618.25962-1-mario.limonciello@amd.com>
 <20230220201618.25962-3-mario.limonciello@amd.com>
 <7d614a1f-b2a0-56fb-dd42-0101c2262b94@amd.com>
In-Reply-To: <7d614a1f-b2a0-56fb-dd42-0101c2262b94@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-02-21T23:27:22Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c0bb04a2-2a95-45fe-904f-345bbc6f955d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-02-21T23:27:22Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 4e238a0c-af5d-40df-acf0-86d361ff2911
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM4PR12MB5279:EE_
x-ms-office365-filtering-correlation-id: 595aaf67-c35d-49ee-e7a0-08db1463301c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AOdvf2fM1Xr1rrUSuRaGG/j2RGT/AZ716LLFNPCTZIW0ISrIgVKVB5pNtijDVWcpZxZiI3gozK6Pt9oMrgwcRl/8WFD3ojjJ9jM84syDS7cfeNwaWx/tRT8iKcrJL04D/4/2vIZRzewqfD4MqpXX8sN3d7eIs1OnlmUl+QKZpCsltzeljB73D6yeyEo7vXOkQ9qf8/lC+yq9nbrpaqPZOelMFCWhbCULJ0T2039V651czrvOrNgpcbTWxhMxwebH9/uJGMXfY9wQSQhdLmKIiqLH20yU0yfFznGo4Mhokye+kf2QNqRjI/in8Uob2vt6ZKa0bt/fPnZjwCaMmeLvNEdXc+9F5nAxn+tI4n9yMY83kt9CjI2r8dLhCu49MfVsprNbjNGQE+CLCTeovUO9LHTSKAoUZYy6JdMe+QvEPeuSaV7iWr3xqbRtlCxRajI8gRZS50vZDdVn0SP+lZoEaGnEQteVj6f1t2YXHfQatT46bpUWSodMai+A32jZjNZ7C5Udoi55ZCnCd6+sKket4YPxagizzdRu7ng/ffMqgx6fUdhh8ltRCP6i9OPAFfsvbKbXSe8747UWR9wxjyGrgpMS7QXY/fMg7DPz6JTbeMFg5SZ0Ew50axzP0NQv2OwaejvawVmdJY9VD0Sn8fjUSOa7Ap925pMcohEOemRKB67UJXbgF1hOfV6K8B4LneNFavFrPy/Iro1JalE9qAueig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199018)(86362001)(33656002)(38070700005)(55016003)(66476007)(110136005)(7696005)(76116006)(8676002)(41300700001)(316002)(66946007)(4326008)(66446008)(52536014)(66556008)(8936002)(5660300002)(64756008)(15650500001)(83380400001)(122000001)(2906002)(186003)(9686003)(6506007)(53546011)(71200400001)(478600001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjV5NXNrTEs0WHNndVRqSW9sdnEyem9YYTJ1S2VFaWxOMDZnUndPRk03d3FV?=
 =?utf-8?B?VVRrSFIxWklZSEFmMkZ3eWYyWTA4eVBrUTc2NkdDNHVmK0pPRGhQd0w2TFVi?=
 =?utf-8?B?ZGMxWlNwYzRvZmpTQkRGOSs1VzZqSjlVZVhmQzF1NjBTcVUvVGxNaTJtdFhH?=
 =?utf-8?B?c3UvYnhhQUdkdDNuUXBGdFRYaUZCaTg1SHB5bmNpYXkvQk05VmMrckFtUDFy?=
 =?utf-8?B?ZGNGQURkYVpwZVhSOWUrYk1nQWVyVzZBaTBsalUycG96bFJtK1hSMEZRcHJ1?=
 =?utf-8?B?OTdmRDZVNnMyY1ZkUEhldVc1K09PZ0ZIVWsvKy9CdXN4RWpINWxpOEhaKzJG?=
 =?utf-8?B?eUpsdVNNdjd3UVBSZUVuNEVpeUNvcVUvUkFZaGJQUW9Sc1dyMFNDYkpzYTNj?=
 =?utf-8?B?MjNrN0FMUkdZS0lqU1A0VCtlSXF6R2pvbFZ5L3JVcThmQW9YWXJGSWNEWVlP?=
 =?utf-8?B?OFZPWkJ5d1NPbzJFYWdqTGJCT1pKTEpxdEV2OEJsY2tMQkFOb0w0a0gva0wy?=
 =?utf-8?B?NTh1bGZJbDZLbUtucE1KaVA1YjhOUzdMdUJBRnBlREY0NnFCcEt2eGVpWWJ0?=
 =?utf-8?B?cWRLbzJSQjkrU1pMdkt6T2p5YU5zNjFObWwzQ25WWFJOZHY3eEQ2aHRudUdZ?=
 =?utf-8?B?MDF1L1VGNFY3cXNIK0plUWRDYndZbDU4RTAvV0RFZXJVd0hVTWMveW1HOXhC?=
 =?utf-8?B?enc1ajQ2ckRSRlFIb1BFMmZudFlaLzVWQTAvL3p6aGUvNG1zZXJMUVV6bFpX?=
 =?utf-8?B?Tzg5c1BwYk91Y0ltZ2xaWWZNRzRSSEg5WmM5bE1PcThJdEp4am95dS9KL01S?=
 =?utf-8?B?UFEwSHd6Tng2Tk1JdDJtYkRISHhodHBLei92Ym9BRzRsTEdiOFhxZlJ1b21J?=
 =?utf-8?B?YzF5QWJuZWNxSmc2RllLUmVjb3M1ek1GVTZUZjhYZFllNzgwa3BjMnZxWlIw?=
 =?utf-8?B?aUpVY2pQM1AxY0RrMGEvRFgxeld6Y2VQQ2tUU2FHdSt3ZTNXaFdKTzgvSExx?=
 =?utf-8?B?SktFV28xd0Q2Snc0ODU3TXplajdmeElDZGlKOUJKMHd5eWpoSS8yUkdtR1Y0?=
 =?utf-8?B?cFpDT2pEemxlVTMyVnNRTGRtUElPWlF5Ui9xZVlzZ0c1bTArOUNpOUgvaGJ0?=
 =?utf-8?B?R2xsN1gra3dCOE9hdnhQSk0wZURiM1NKQmNKdUoxd0ZtRHlRUHhyWEtDUDFk?=
 =?utf-8?B?Q3IrUENmR1VlU1k2T1NjSkNnS05EdFBwaW1wNFVZQm1haFNIc0tsVXNwejkz?=
 =?utf-8?B?L05zNmg4MXpwSWJ1RDFydGU1ZnBjcXY0MEtmeUZPNmg2Wm1ZdFpYL2RIU3Bz?=
 =?utf-8?B?eUZubjd2Yk1GZ2ppOXJtV0g3QUtxRFM3eVZ5b1p5NzhPMUhaT08zZlJtNkhy?=
 =?utf-8?B?SVVYUlBlK3BPT1AyRURiVHJ3YUZGQVlwUTRMTDUySU5HSTlNVzZXOFJOWXNz?=
 =?utf-8?B?dVp3dE1aR1J2UHVHeVZibTlZbnJQN0lpZmVUZnV4ZUVqQ250NHJHWDIzdURJ?=
 =?utf-8?B?bVNXdHArWUZzSEM2bi9KQzdpQkRIRGJsT0RCN3RnSnludFMvVXNkU2d3ek10?=
 =?utf-8?B?WmdLWnM5VllVSGY5L2l3eGkyVFlVRkhIZWw3dTNRNjhwNkFsZW0zeFZ4cGlJ?=
 =?utf-8?B?UjU1cU4xNDZ1bFNGSW0vZkZnN0cxTGNUOU5IMzVZN0svQ1hXdWcxYWF1ZURp?=
 =?utf-8?B?M1NpSFBsNWlNSzFaYkc5MTAwTXlpVmNPa2o3UjY0RjlBbDV5dUN5S1JLUE1Q?=
 =?utf-8?B?S0hvOFlYZXFqRE1CWmNEb0lScFYxT01iTEE3bE5PcllWbTZUNGJqcFoyUTFk?=
 =?utf-8?B?QmlaZFhPTGJNUFRwU1h0bENIWWhEOWVKdEJOU0dtY3hZZGhMVng4azQ2R2ZY?=
 =?utf-8?B?ZmNRSTE0MVBPUE1UOW5MZTkvTE9SZlhWRXdxcjVjNThzNEtyTXVjTlF6ZVo2?=
 =?utf-8?B?bERiMzdnalNNZzBySmt3NDJxRUlxdFF0NjBZWGliYlpXWThGTER5bmNQdU53?=
 =?utf-8?B?KzM1ZzBYS044V0dNWHVzMmVFY1FaTm8vUmcrZHI1ZXVHSmZETnVTUC9IOWVu?=
 =?utf-8?B?M2d4Sm12WUo2QU1Wbm96eUJtRGVyTml6eDF2WUhockR4dFl0UXdRZTU2NCtz?=
 =?utf-8?B?MUh3QklpMmdqWmkyVGZNVnBQSVBzbDNCNzd5MldNTWVEMzdqV3Y4NXRDZ292?=
 =?utf-8?Q?ZdOGiHaePm/5vYGjivU9DOw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595aaf67-c35d-49ee-e7a0-08db1463301c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 23:27:24.3950 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQdgbGknIcCzszp1VSZRqRF9f3DWmWP2i+qYhrCOt1jPK2Q3dPgClLHU330D9fq3EaGGE/DmfceOXiL91Ro5Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5279
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
Cc: Peter Kopec <pekopec@redhat.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF6
YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkg
MjEsIDIwMjMgMDc6MjANCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVs
bG9AYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogUGV0
ZXIgS29wZWMgPHBla29wZWNAcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzNd
IGRybS9hbWQ6IFVzZSBydW50aW1lIHN1c3BlbmQgaW4gbGlldSByZWd1bGFyIHN1c3BlbmQNCj4g
b24gc3VwcG9ydGVkIGRHUFVzDQo+IA0KPiANCj4gDQo+IE9uIDIvMjEvMjAyMyAxOjQ2IEFNLCBN
YXJpbyBMaW1vbmNpZWxsbyB3cm90ZToNCj4gPiBUaGUgUE1GVyBvbiBkR1BVcyB0aGF0IHN1cHBv
cnQgQkFDTyB3aWxsIHRyYW5zaXRpb24gdGhlbSBpbiBhbmQgb3V0DQo+ID4gb2YgQkFDTyB3aGVu
IHZpZGVvL2F1ZGlvIG1vdmUgaW4gb3V0IG9mIEQzL0QwLg0KPiA+DQo+ID4gT24gdGhlIExpbnV4
IHNpZGUgdXNlcnMgY2FuIGNvbmZpZ3VyZSB3aGF0IHNsZWVwIG1vZGUgdG8gdXNlIGluDQo+ID4g
YC9zeXMvcG93ZXIvbWVtX3NsZWVwYCwgYnV0IGlmIHRoZSBob3N0IGhhcmR3YXJlIGRvZXNuJ3Qg
Y3V0IHRoZQ0KPiA+IHBvd2VyIHJhaWxzIGR1cmluZyB0aGlzIHN0YXRlIHRoZW4gY2FsbGluZyBz
dXNwZW5kIGZyb20gTGludXggbWF5DQo+ID4gY2F1c2UgYSBtaXNtYXRjaCBvZiBiZWhhdmlvci4N
Cj4gPg0KPiA+IFRvIGF2b2lkIHRoaXMsIG9ubHkgcnVuIHRoZSBydW50aW1lIHN1c3BlbmQgYW5k
IHJlc3VtZSBjYWxsYmFja3MNCj4gPiB3aGVuIHRoZSBkR1BVIHN1cHBvcnRzIEJBQ08gb3IgQk9D
TyBhbmQgdGhlIHNtYXJ0IGZsYWdzIGRpZG4ndCByZXR1cm4NCj4gPiB0byBza2lwIHRoZXNlIHN0
YWdlcyAoYmVjYXVzZSBhbHJlYWR5IHJ1bnRpbWUgc3VzcGVuZGVkKS4NCj4gPg0KPiA+IENjOiBQ
ZXRlciBLb3BlYyA8cGVrb3BlY0ByZWRoYXQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmlv
IExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgOSArKysrKysrLS0NCj4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5j
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4gaW5kZXgg
YzNkM2EwNDI5NDZkLi5mZGMxY2JmOGFkMTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4gQEAgLTI0MTgsOCArMjQxOCwxMSBAQCBzdGF0aWMg
aW50IGFtZGdwdV9wbW9wc19zdXNwZW5kKHN0cnVjdCBkZXZpY2UNCj4gKmRldikNCj4gPiAgIAkJ
YWRldi0+aW5fczBpeCA9IHRydWU7DQo+ID4gICAJZWxzZSBpZiAoYW1kZ3B1X2FjcGlfaXNfczNf
YWN0aXZlKGFkZXYpKQ0KPiA+ICAgCQlhZGV2LT5pbl9zMyA9IHRydWU7DQo+ID4gLQlpZiAoIWFk
ZXYtPmluX3MwaXggJiYgIWFkZXYtPmluX3MzKQ0KPiA+ICsJaWYgKCFhZGV2LT5pbl9zMGl4ICYm
ICFhZGV2LT5pbl9zMykgew0KPiA+ICsJCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koZGV2KTsN
Cj4gPiArCQlwbV9ydW50aW1lX2F1dG9zdXNwZW5kKGRldik7DQo+IA0KPiBUaGlzIGlzIGFza2lu
ZyB0aGUgZGV2aWNlIHRvIGJlIHN1c3BlbmRlZCAoZnJvbSBhIHN1c3BlbmQgY2FsbCBhbmQgdGhh
dA0KPiBzb3VuZHMgd2VpcmQpLiAgDQoNCkkgaGFkIGNvbnZpbmNlZCBteXNlbGYgdGhhdCBpdCB3
YXMgbmVjZXNzYXJ5IGZyb20gcmVhZGluZyBkb2N1bWVudGF0aW9uLA0KYnV0IHJlLXJlYWRpbmcg
SSBiZWxpZXZlIGl0IHNob3VsZCBub3QgYmUgbmVjZXNzYXJ5IGlmIHNtYXJ0IHN1c3BlbmQgaXMg
dXNlZC4NCg0KSWYgSSBkcm9wIHRoaXMgcGF0Y2ggIHRoZW4gdGhlIFBNRlcgc2hvdWxkIHN0aWxs
IHRyYW5zaXRpb24gaXQgd2hlbiB0aGUgdmlkZW8NCnR1cm5zIG9mZi4NCg0KPiBSdW50aW1lIHBt
IGhhbmRsZXIgd2lsbCBhc3N1bWUgRDNjb2xkIHNjZW5hcmlvIGFuZA0KPiBleHBsaWNpdGx5IHJl
cXVlc3QgQkFDTyBlbnRyeS4gV29uZGVyaW5nIHdoYXQgd291bGQgaGFwcGVuIGlmIHRoZQ0KPiBw
bGF0Zm9ybSBkb2Vzbid0IHB1dCBpdCBpbiBEM2NvbGQgdW5kZXIgczJJZGxlIGZvciBkR1BVcyAo
QkFDTy9CT0NPKS4NCj4gDQoNCkhpZ2hlciBwb3dlciBjb25zdW1wdGlvbiBJIGV4cGVjdC4NCg0K
PiBUaGFua3MsDQo+IExpam8NCj4gDQo+ID4gICAJCXJldHVybiAwOw0KPiA+ICsJfQ0KPiA+ICAg
CXJldHVybiBhbWRncHVfZGV2aWNlX3N1c3BlbmQoZHJtX2RldiwgdHJ1ZSk7DQo+ID4gICB9DQo+
ID4NCj4gPiBAQCAtMjQ0MCw4ICsyNDQzLDEwIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Btb3BzX3Jl
c3VtZShzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYpDQo+ID4gICAJc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYgPSBkcm1fdG9fYWRldihkcm1fZGV2KTsNCj4gPiAgIAlpbnQgcjsNCj4gPg0KPiA+IC0J
aWYgKCFhZGV2LT5pbl9zMGl4ICYmICFhZGV2LT5pbl9zMykNCj4gPiArCWlmICghYWRldi0+aW5f
czBpeCAmJiAhYWRldi0+aW5fczMpIHsNCj4gPiArCQlwbV9ydW50aW1lX3Jlc3VtZShkZXYpOw0K
PiA+ICAgCQlyZXR1cm4gMDsNCj4gPiArCX0NCj4gPg0KPiA+ICAgCS8qIEF2b2lkcyByZWdpc3Rl
cnMgYWNjZXNzIGlmIGRldmljZSBpcyBwaHlzaWNhbGx5IGdvbmUgKi8NCj4gPiAgIAlpZiAoIXBj
aV9kZXZpY2VfaXNfcHJlc2VudChhZGV2LT5wZGV2KSkNCg==
