Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBC0C6FD1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 20:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1B2010E3EA;
	Fri, 17 Mar 2023 20:04:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3E010E3EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 20:04:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4vqK5/X5QSNsYr0J/QgzIfDS8aDQIQOFgO6x0VwjfufvDZxNvRp7mSfB8izs6GI70QbYNBuN2BWpqx52WNIGq4xSw2NLRzGO6CKqFMrUnFJfiYEVId8M2DAl9mP8KWwMDQik/1ad8Nj+UYcPu52z2RtNto0hc24l4JxteigJvOb4E18jxMKa2kUYN+11B7dy60g0zmX9xnfDKESljqbockm6neL/1XSFRmLOyvW1t41gjgMj/8TUPCaWe48Uj+YBnb0v2o836lD7wKdWjQrs5gYjoFGxKKl+XbmZ+wxOqCtEYrzPVMO63KtbD+3EG9bV5eSBMdKx7PxO0LZHUkq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JazfZiwknQfqum3ppmeJDFLXX4UxfkVt/XMfgfpTE4o=;
 b=MzMGboGQYgR7XY0OuPr586rjQufeqyK2TBdyNL5hZdchoGjFbv7QyJcbyI7kPlpGN6Ld0I7X4YPBPNcuJsXDOeXCMxSZgYxM6ZddlSOMFaPpm/zof2uCnRWd9P8Nun/oC8G4eD4BWxT5eid6Ocpf/LwINQzCRFqNJ0kTH4Kf/99uvgTq7eZf6GIvgZuGKO6j2QmSCEU7+Pwit3UpfIVeOj1v6NVDxCVtmvTWm2tgLzNkrTrw58+8F61lNbozt8B/EwkBo4esENEpmQhDXhjWnwXq4tNnVdilHWAO5gyBVvoR0DdjDJXUOQ0HkYoYG7l7LPkPotIaSP0TLHuHw+oo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JazfZiwknQfqum3ppmeJDFLXX4UxfkVt/XMfgfpTE4o=;
 b=sFVprJK+VK25uUXnGYQGR9etIrBsipwnw0XSDpwLJYyywwtPSgTAYelPMw2Hu5wecewe0IsSUsE/Srqj+gDa26Ve6eGvn0PNzjJ0e3IRYbahIT7CHXYnYM1LiRG0Wkm7Dm7GmLZb4VocdDw87qOGLF6fLb+R6N62e8sS3KWL7Vo=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.26; Fri, 17 Mar
 2023 20:04:53 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::349e:f448:50a2:a4ad]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::349e:f448:50a2:a4ad%5]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 20:04:53 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "Mahfooz, Hamza"
 <Hamza.Mahfooz@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add print for iommu translation mode
Thread-Topic: [PATCH] drm/amdgpu: add print for iommu translation mode
Thread-Index: AQHZWQl3ZeT22psvKEmGWALdAzvmSq7/Y3MAgAAABwCAAACckA==
Date: Fri, 17 Mar 2023 20:04:52 +0000
Message-ID: <DM6PR12MB30674A9D4B81185DA913A2278ABD9@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20230317194757.1336098-1-Graham.Sider@amd.com>
 <0509601d-8d7c-26e2-26c9-8f4757a92ca2@amd.com>
 <DM5PR12MB1308BF656CB0C75BA0B9CED885BD9@DM5PR12MB1308.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1308BF656CB0C75BA0B9CED885BD9@DM5PR12MB1308.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-17T20:04:51Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7d905304-9143-4c4a-ae49-36ba80b47603;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-17T20:04:51Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 6afa95a6-ecb4-42ca-8286-1fce4f767452
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3067:EE_|IA1PR12MB6459:EE_
x-ms-office365-filtering-correlation-id: 031ba660-f6cb-4de9-a20d-08db2722df2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /xMn8oihKFbkzLX013xQCkqEpN+kgg/tnw9UHBBIb0gigv7e52SfjzT2Zs2eff4iatsBlKNpX4UdACvo00+yRyW8cuUtMXBpwyUpO/LZ28Lxp72JTdH/DzVyYNSo+gw3PBSMiP8sz3dQAFO+XKH7unOZHRmAC9uG8HBIVz7VOCEqU49/6XdRrOpkMf9XZGQOkU3Cm2wdJ1c4gT0QkA7mSxTKZiWJ5YhQqxn5wdrYwvT74cn+J+lklAqYuVDyut5bCKD7qHOEQKgI6VnVzjERkY7SR6tQ21JufHPPsEZ0S+UH6RPTcG2HKdCNjHi0EslHCMiD3SOfXJ3YIrxjS+1QNMAOIMfR5TX4edR2DrP3qaV3KyfPOf51BfDsWZ0fgxg9NZLzjc9aUKh1n4j2dHhE2gSBYdSRS9JJks7wrnaYtfyQu7Wb0gJ0dofoGMCvUawzUSFcnWiyN5QDaEH9xsJvm7vqjfiLFgsU2U/AkVotuQWHc4yjl/akMMy5ucF/ZGVQdo6yKmfXsY/OlG9Y8G3hsMTIG0OvJpvhGYXhCwPPK3WyF7YhNCWfZ2IqiSObBvLfWEkpdwiYlvXD6iOkQ/YFkKId3J1F3W5VljahnJwmMfX34j3XmMX6osRMj4l2gXEWzxdUXmsx4VifT/7E3mjf2zeP6nfw2kjjwjJum3KUrbqajlRUkOwAVx+JRQ/7kVlcB5ke6bylDUThbm5vZibsSg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199018)(53546011)(316002)(55016003)(33656002)(110136005)(5660300002)(4326008)(71200400001)(6506007)(2906002)(38070700005)(9686003)(52536014)(64756008)(38100700002)(83380400001)(66446008)(8676002)(478600001)(86362001)(66556008)(41300700001)(26005)(66946007)(122000001)(8936002)(186003)(7696005)(66476007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czhDaVpmWlJtMDdVSDNvY3FOU21WUUt5OG92akFqVnNXSVJYM0FTSVZiMVBi?=
 =?utf-8?B?Q0Z4T0VGUDlJWTFXNXNPbHdQM2xYTmdvRGNvanE2NE1vVlk3ZWtmODFJcWFx?=
 =?utf-8?B?VjZINkNqVkdtc1JxUHhSViswK3lldlU2Zm12VHFhRnBvWm9USTUzMXk4YUwr?=
 =?utf-8?B?VFJmYlMyTG9YYjdiYUVtMU1Sck9pcWJuYjA3VFRWUFFualVEdmM3Ny9VUzR1?=
 =?utf-8?B?OHFUWE02VStBWVYrTmZwckFtTVhCVVpGQzhxelZMRzVnRHVQSVVVcnFxalVw?=
 =?utf-8?B?cHQ1SGJjaisyOGVYcEllN0huZzhUM3I5ZXVjNUNVTXY1di82ZHc5N1NGMkNF?=
 =?utf-8?B?YTAxRlU1L0M5TW5kMXRnUjBaR0gzQ0dRd3h6MjZhU0l4WWdMNkQzZ0xSRXlS?=
 =?utf-8?B?dkk5Tm9laWZESy81ZTJJVjYrbXhqZFpUM3VrM2JFRlZ1TmhEVnhjWHVlTmlD?=
 =?utf-8?B?Q0VtK3N4aDFtTXNxVHMwa1pFT0JlT1JVSWFJZDBuT0YveXJvd2NOTm5LQ1N4?=
 =?utf-8?B?MG1JWERGVUZQVytZajY3Y3B6YkJ5RnBCNkp3aE9HSlowaVJtVHRwVlc3ZnZ0?=
 =?utf-8?B?VkV2S0hFdytDZkFjK3dLQTN1ODZ2clkzejlUejRmUCtYa29keTlvMFZrK2ZZ?=
 =?utf-8?B?L1Y2c3I1QzRSNkdRa3o0bGRKbFh5OGlGRlhEMmVzYjlBbXZ3TWZlUVJORkRr?=
 =?utf-8?B?S2JBKzdlbXVJZ2tCZE9ndmw0WDdDZlZYNUFYenRmbmxYUWlGWGRHTmVHTStC?=
 =?utf-8?B?YS9ZbHc4OCs3VHoydVNlTFdRK0p4d3RZc1ZVcGpvR2crM3J3SkVzS254SWNM?=
 =?utf-8?B?bTNzWnRwNjNlUGFuc1lRV2g3K2xGL0s0bFkyTFlLNnkvVkRIUk4zeW1kMGY5?=
 =?utf-8?B?VzZUdTF0YWNjczNNMVdVdTBucGdqVEd3Um9sNGxEa3ZsZ0R1aVJ2K1orS3lY?=
 =?utf-8?B?bU9hd0hJZXhCYnFmV1dXakZzeVYvZG9BczFQTTllbUNXRjlhNGJJOXBXUFd4?=
 =?utf-8?B?V295NXkrNzY0czJmYVlKUkZvcVF2V2lHNHQyY1FUQWN5T3o1aExVa3pVKzRS?=
 =?utf-8?B?K2JTb0JpaVppeTNUMUtHdkhxU1lLa0tJQ1JFay83T1dQYisyVzEyOWJVNlBX?=
 =?utf-8?B?RUc0clhZUjA4R0xVb2tBdWk4d0ZGdFB4Z0RDYUVEWTYyVkhIb3o0L0w2bGFz?=
 =?utf-8?B?dEhEeE1PaXJ5NUh1YkJIcFhUN2VQQkZ4Z3lJVmJlNHN2VnpNZ09IUjBXY05S?=
 =?utf-8?B?eVFXTTJZM1diWUxUaUtpSmoxWTNnQjQvS1RmRzBqeFhmUVNyZmllNEtId0lD?=
 =?utf-8?B?RHZvMzVRZUs3dVQ0RHZIYzJPUERKbEVFN0RJajNJcC9JaTl5NGNFOFBta1JI?=
 =?utf-8?B?TklBMnVPZTkwNm9xRFQ2QVVISlptSDQwRXp5cVpnVTU3OGtlcnMxT0RGdnUv?=
 =?utf-8?B?aWh5MmZOWUE5RTB5R20rWk81NW8wc1Y1clQ4RjlCMlBMT0FLODF2ajVXOElF?=
 =?utf-8?B?SEQyQmpvMWk5RGdWTDFHVDI3Wk9oRVpWckJ3Z2tWSG8vdXI1R2huQWg3b250?=
 =?utf-8?B?NFJCQThRQk1md204dy9WTXRSOW9idEFoOTA5Y0ZXZUROMHNHQy84Y1JwdC9y?=
 =?utf-8?B?QVgvQ0ZLd1A5Y2VOWVpGeFplN3dzalF3RDRGdjdKc29ZL0FLaGFCSEJDNHRi?=
 =?utf-8?B?aUZTOFVKdjl6OWNoMWhjVjB1L0xuZHRhaC9kTG5yZURPdXZqTEVXSzhadnI5?=
 =?utf-8?B?elphUkVFaUtucE9FZ0pEakRSSEZCSFZrRFJHK09weXBrOUtlc3NIVjczb3Zk?=
 =?utf-8?B?NitjOHRxN0FVcDNBZUtyVU55c1ZZUkJWMnhxT1BLS2FIc3dGRVZIeHI4RzE3?=
 =?utf-8?B?QUpRUjhnY3BQQThoVXdkU2VrbVFiR1dSWTlJdHR1SWgxcm5MY2xQNmRveFR0?=
 =?utf-8?B?SUQ4cWRONTcxRVhHdjB3dFpXM2wrTnZiT0Nid21NWUlLNU95amxpZDU3OW14?=
 =?utf-8?B?Vll5RXpONzRwSS9zZ29YYkFUTzZqTGtXajZJVC8wV3lHYjdKWWJxb1lKRDdP?=
 =?utf-8?B?WmszMW9pSlRGTEwvVUZYdVB1aWZlbWV6V0kraXdsUnMybkdNNm4xWWpmbWMz?=
 =?utf-8?Q?Jbz8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031ba660-f6cb-4de9-a20d-08db2722df2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 20:04:52.9244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VALJ6skhPP+I76ZUeHQyASWdzWHEE53QbnedZqlZ+ZuEs0ckhWPpsfRDdGIx5H5l2wBTGhtvFDYZneSz/1gCfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJ1c3NlbGwsIEtlbnQgPEtlbnQuUnVzc2VsbEBhbWQuY29t
Pg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDE3LCAyMDIzIDM6NTggUE0NCj4gVG86IE1haGZvb3os
IEhhbXphIDxIYW16YS5NYWhmb296QGFtZC5jb20+OyBTaWRlciwgR3JhaGFtDQo+IDxHcmFoYW0u
U2lkZXJAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBLdWVo
bGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFU
Q0hdIGRybS9hbWRncHU6IGFkZCBwcmludCBmb3IgaW9tbXUgdHJhbnNsYXRpb24gbW9kZQ0KPiAN
Cj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+IA0KPiANCj4gDQo+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5j
ZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4gPiBIYW16YSBNYWhmb296
DQo+ID4gU2VudDogRnJpZGF5LCBNYXJjaCAxNywgMjAyMyAzOjU4IFBNDQo+ID4gVG86IFNpZGVy
LCBHcmFoYW0gPEdyYWhhbS5TaWRlckBhbWQuY29tPjsNCj4gPiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiA+IENjOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5j
b20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogYWRkIHByaW50IGZvciBp
b21tdSB0cmFuc2xhdGlvbiBtb2RlDQo+ID4NCj4gPg0KPiA+IE9uIDMvMTcvMjMgMTU6NDcsIEdy
YWhhbSBTaWRlciB3cm90ZToNCj4gPiA+IEFkZCBsb2cgdG8gZGlzcGxheSB3aGV0aGVyIFJBTSBp
cyBkaXJlY3QgdnMgRE1BIG1hcHBlZC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBHcmFo
YW0gU2lkZXIgPEdyYWhhbS5TaWRlckBhbWQuY29tPg0KPiA+DQo+ID4gSWYgdGhpcyBpbmZvcm1h
dGlvbiBpcyBvbmx5IHVzZWZ1bCBmb3IgZGVidWdnaW5nIHB1cnBvc2VzLCBwbGVhc2UgdXNlDQo+
ID4gZHJtX2RiZygpIGluc3RlYWQgb2YgcHJfaW5mbygpLg0KDQpJdCdzIHVzZWZ1bCBmb3IgbW9y
ZSB0aGFuIGp1c3QgZGVidWcgSSB3b3VsZCBzYXkuIEp1c3QgYSBxdWljayB3YXkgdG8gZ3JlcCB3
aGV0aGVyIElPTU1VIGlzIG9mZi9wdCB2cyBkZXZpY2UgaXNvbGF0aW9uIG1vZGUuDQoNCkdyYWhh
bQ0KDQo+ID4NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMgfCA2ICsrKysrLQ0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gPiBpbmRleCA4YmJhNWU2ODcyYTEu
Ljg3OTdhOTUyMzI0NCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gPiBAQCAtMzUyOCw4ICszNTI4LDEyIEBAIHN0YXRpYyB2
b2lkDQo+ID4gYW1kZ3B1X2RldmljZV9jaGVja19pb21tdV9kaXJlY3RfbWFwKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQ0KPiA+ID4gICAJc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluOw0K
PiA+ID4NCj4gPiA+ICAgCWRvbWFpbiA9IGlvbW11X2dldF9kb21haW5fZm9yX2RldihhZGV2LT5k
ZXYpOw0KPiA+ID4gLQlpZiAoIWRvbWFpbiB8fCBkb21haW4tPnR5cGUgPT0gSU9NTVVfRE9NQUlO
X0lERU5USVRZKQ0KPiA+ID4gKwlpZiAoIWRvbWFpbiB8fCBkb21haW4tPnR5cGUgPT0gSU9NTVVf
RE9NQUlOX0lERU5USVRZKSB7DQo+ID4gPiArCQlwcl9pbmZvKCJSQU0gaXMgZGlyZWN0IG1hcHBl
ZCB0byBHUFUgKG5vdCB0cmFzbGF0ZWQgYnkNCj4gdHJhc2xhdGVkIC0+IHRyYW5zbGF0ZWQNCj4g
DQoNClRoYW5rcywgbXkga2V5Ym9hcmQga2VlcHMgc2tpcHBpbmcgdGhlIG9uIHRoZSAnbicga2V5
IGxhdGVseSA6KCB0aW1lIGZvciBhIGNsZWFuLg0KDQpHcmFoYW0NCg0KPiAgS2VudA0KPiA+IElP
TU1VKVxuIik7DQo+ID4gPiAgIAkJYWRldi0+cmFtX2lzX2RpcmVjdF9tYXBwZWQgPSB0cnVlOw0K
PiA+ID4gKwl9IGVsc2Ugew0KPiA+ID4gKwkJcHJfaW5mbygiUkFNIGlzIERNQSBtYXBwZWQgdG8g
R1BVICh0cmFuc2xhdGVkIGJ5DQo+ID4gSU9NTVUpXG4iKTsNCj4gPiA+ICsJfQ0KPiA+ID4gICB9
DQo+ID4gPg0KPiA+ID4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZSAqYW1kZ3B1X2Rl
dl9hdHRyaWJ1dGVzW10gPSB7DQo+ID4NCj4gPiAtLQ0KPiA+IEhhbXphDQo=
