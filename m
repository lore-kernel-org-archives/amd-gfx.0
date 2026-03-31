Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D5DFF60D5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 07:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D01410E236;
	Tue, 31 Mar 2026 07:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WetBVHXF";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B34A810E236
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 07:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJGcXqrWJd51zg3NQ+4ZncHZkBnhHLpOvoSHy0NfVwlpsfZN8BTDljqZtzmMixL3SjaficEAfNL4qwzz5vB6aK6zeT/8mAeAlq2jrrn/5NTmga+7nElJI1g+OORWB4p4h/dTTSm8vBQAR142LwmM1l2rasM8ARkXEbfKmfIbpaxrUiBM+YidzUYszienjEY6wu7pC9Bg5XmD02Dk8hQWSsWU+PAjlMwN7iu0gl2vyWWDxOS1HV3DHt7KJZfctzzHdzSgfVBmoJdr4wiooBM5xRan23HEc8PUXo6YKmsDYFr4L3SGrD4hCIJqYi/CpVe+GMB4GCTSq6ky/9TyixaqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZXC1YTljGGSZnDqsNBRYiokOeILXw8D953kbD3WLiM=;
 b=JLZb/LUCAV1nm+coXggaW2cser9DOxz3A7lh7kicYbubnMftH9rEn+8M+SAc94ylwYYiSVwaKBFUzxtfH43TLUiVYcc7n/pmOsKJXkoRAFN6iaIJqEv/XBQepy0O24AOvy9iLLKSrbT6HVnr7UI09J5qyWK8aTI4VwsejFozm5B1u0n2CSYh7Drraoh7pBx6vcahBRE5zEEnojX1nkOCbamGjsrqKRM1Zx63xUOwTpIUUN8d+QZZSI8MwE/dWtyu9O4JN82/5dqo0rB55Ek0QfMm0dZ91VAjAz91XhFCzG/jH+WFUwZzxZW9tuFToV1V7ygyMMVDuyPU2dcqduZpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZXC1YTljGGSZnDqsNBRYiokOeILXw8D953kbD3WLiM=;
 b=WetBVHXF1Qb8PyPYE0KcPmtdVTGOKCGJAutobjAS1iHybd8VFTVa7USS1tLpyBhDSWq1Npu3hsW/Lay6BR+CS9FC83JC2knzMPn4s+6ltCCdRwXUe9J+gOffF6Lb77Hbjf1ws/L9rzZJvl7bdcUT9OS6BK44HHko92Cl4Sd00TU=
Received: from CH0PR12MB5106.namprd12.prod.outlook.com (2603:10b6:610:bd::10)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 07:03:41 +0000
Received: from CH0PR12MB5106.namprd12.prod.outlook.com
 ([fe80::d6a5:45a1:c314:cfd1]) by CH0PR12MB5106.namprd12.prod.outlook.com
 ([fe80::d6a5:45a1:c314:cfd1%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 07:03:41 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH 00/14] Refactor reserved region allocation
Thread-Topic: [PATCH 00/14] Refactor reserved region allocation
Thread-Index: AQHcvPXRgComJYIHt0mYSguCKRp5AbXGz4uAgAFvbmA=
Date: Tue, 31 Mar 2026 07:03:41 +0000
Message-ID: <CH0PR12MB5106F0CB8834757491DD3A72FE53A@CH0PR12MB5106.namprd12.prod.outlook.com>
References: <20260326075412.1378411-1-lijo.lazar@amd.com>
 <3233c098-481d-4805-8f50-4ad415f82ffb@amd.com>
In-Reply-To: <3233c098-481d-4805-8f50-4ad415f82ffb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-31T07:03:15.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5106:EE_|DS0PR12MB8788:EE_
x-ms-office365-filtering-correlation-id: 56eee710-aab8-4d06-a656-08de8ef3a405
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 3QA7hi9Zr9gGclDLoPgWDtzXtx722zDQtphaGpCYNxWbO1TqJ7q0OrjmqXXTxUbt8tBiT90RON/JSJgmRg8xEGstdr35Uh2/F0mXrkW7gp9+aiCEln41sitVefaM8H/lilVfW243fz9IGFc2GNNNt6b6kXPV9fopENigjzLd8YK6oJyPA7VmH/fiS+/kPkt4RZq82UuHWkXlhXi/TvStxCOwxY8FsbEtNsPKWXYCSCJHYCN/MThcBHO0uQbFTzvKRHjhnw0coWtRRIXe0cnA4dLsr5uSjoxYJ7/qdgXXSZ9ELhRsY/buuMcMIwMCdkzKML3g8Hrqsvj4Ub+vazhuJa0o2+Z4pDsNN3m8EB2A83OFJpBU1ObgD/TsGjcwXPZmioehO7JxPlQWnnf7k86WrwgG8eLWg1dDP1XrmlwX/YGslahtjfMINuOOa88qu/3ij5KV7Exw53Elkc6+fVsi27n7KcaUzBo2Pc8CD4W8x2mpdNxEyk9E28TKN+WUTJg4aBOXwLgw+iAZQ8NY8XcKXk7W2E8DCoszqAEYIqN0ch2PPXqd8Dq7BrhHPVwzG76q4WuoNZrLfEDjDZBoaje3Fc65Wh0oCeQGaVsXypzi6zXXI0ZtduSyEHYoNjtRDvLONh/UQ6q8SlLJvai/MHfF2vUEpXcejbt3oUvsOOZhT3f2nN/Y8sgciZaixAROKyxFsaluglDS+HN/L7nhwSowPc+7kSdDcnG0h44iOFFCxbbx6Fp6V4pqnADSllog1h6X/jo+Zmk2TXh+8ktKpdZb9qXrU7UNJ0F72ZaSBS78zU4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5106.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2dqS0lHOFFKdkFLaGJIUzNQcWVNRXlWM0pIeHMxQ2NqQyt6SFVQc0pPMEYy?=
 =?utf-8?B?MnVKTlZJUGRaOEI5VUJZN2FocWY4WjhjMm5NU25IUzlhdzBhd0F1ZEhiV21I?=
 =?utf-8?B?M3lOazdHRGtGSitDalRKdjlPeWEvV1A3SGliRTUzVHB3K3RQNlBZaFdrSVlC?=
 =?utf-8?B?UkZ5N2FudEJzaDNubExvMHh4RE8wQlNPWWdnRDBmMllCa1UraE5IUldSYzJV?=
 =?utf-8?B?Vk50aTdnb2daSlVsMm9nTlF5SGwzbGFhTXd5NDZHbjB0b211clNMTXVoUEVJ?=
 =?utf-8?B?VTZpMjkxcXdlaUJTUDViRzg2RC9IQ0kzdVVpdmJSY3lxOGtjQmJlTWNvaGZm?=
 =?utf-8?B?WGFvbiszYUJxdmFxcVZreXdrR3dxdTc3MEl4aDd6RTIycWhXRGJqbHNIS1l4?=
 =?utf-8?B?WVpsOUZuZCtzSzZmemVaVlk4NWxSU2FpdTNXODZMNHRKSHRBWndqNW51c25j?=
 =?utf-8?B?YzFYYWZxakFmZFVoa0g3WDlKVlhtOVhVK1hTQ0xPaUViWHRXK1p3dFpha3hO?=
 =?utf-8?B?clpqbjlyTkc0ODRYMTFySU42T3NseEt3Y21MMU4yc1F6NDhwQ0JHc1NXN1RL?=
 =?utf-8?B?VnJLMzBLWlhGWnp4QzdkeW1mZ3A0dFgwUFo4RlhOMUNtL09pRDlLcFFOaVQ0?=
 =?utf-8?B?Y3ZpSU41bUN3ZzFHZnoyKzY3VGdtOG8xT0ZkQ3l0TEJKcWJJczZhOFlwcTFw?=
 =?utf-8?B?bEhVSnVFSjQvVFVsRDFTOTlRQzRXUTJjWkFFeGNWam1wOCtWNUw5dVpjSjBX?=
 =?utf-8?B?SXo3ZlFTQXQ3bzdOZ3g2S29RK1ovdmlIdnJNdG5odGxrc3E5UTBtbEphWmg2?=
 =?utf-8?B?T3lkaU1VY2czMjlOaVo0V0FDN285NEVnbXdRVUNyQS9RVkszekpybjNBMWk3?=
 =?utf-8?B?OXBjeTBVOU83TlpJdE1LRkRadTErZ1gxaTFMRjZIYkZoRTYzZDlwOTJVTHpG?=
 =?utf-8?B?R08vQk5SZFY0ZnVDdnFYSVBkTUtkR3Y5OHZ6QmZiOUdiRUNxdVkrbUFsb1Zi?=
 =?utf-8?B?Nm9HTjdGU2FlWi82bm81MDd3USsvUDRGaFhCOTNIc2pNTVEyR0F0T3JYUXRl?=
 =?utf-8?B?cHQ2bXdvaTRRMFpzdFBJNnl0VEVKV3h1d3ZvYTZDdXJjNzg1VmJnV01Rd1pH?=
 =?utf-8?B?aWN4TTViNkpOSUhIK2FKS2pqU0RDbmQ3Nm4rUms2dW1IYXhYMUpUeWVOcUEz?=
 =?utf-8?B?Qi85QU9adGgzVWRnbGRzSVVteWVQQ2FtaTUwMC9lbzhiTk1SOC9kaVN3M2Ro?=
 =?utf-8?B?WEdrc1N4VHQrUjYwOUdPQWFteU9WNlUrSmpzbUQ2cWtkN2lYRU1zRHlZQlU3?=
 =?utf-8?B?NW9sUDRPd3JJcThuYnQ5Zjk0SHZYQXg2V2xYZFk2NjNnZTlZRzNpS0drNS9M?=
 =?utf-8?B?T2p3M1ZnbGVORWZFV012TWpON2pSTWNBMVlIR1FEcWxRVmRuV2FrQ3Z3Q1dX?=
 =?utf-8?B?SGU1WFc0NE15WFJ3cEtpMlFyczNWbXQyRGZ4SWJkZHowT3RDaGtqTEdTMjZa?=
 =?utf-8?B?LzdwdElDSkxZYS9xeTNzSFc4Q1V5aU9IbU1PQ1VLK3AxZEhqdk15aEg1VmtP?=
 =?utf-8?B?UUlTMU44N1FTQTJINTlBemhXS3p1dDlNSWg5eUN2K3lrMjY4VEY3aGVEYWxU?=
 =?utf-8?B?dk0rNmFkNTJkank0b0tyUUsyMGZXNDhBWnV3Z25IclpwSU1qUmk4aXFKWTNF?=
 =?utf-8?B?Vm9HVWVBY1FoWG00UFdpL0dueENQWXFKTHJHeVlHUGJPbkR0S2o5OUFRMVI2?=
 =?utf-8?B?dnZDa1hYaTZ6M0E5eU5FSFNKcVRld1lMVVJ3Zks2bi9VSy9rK2VmMnVwV1NY?=
 =?utf-8?B?WDk1Sk9XRzJIZ3VZQmRidmVDMWM5NWpiVjdRalhwNzhvYUNuaEtQOEhza2tj?=
 =?utf-8?B?Q25xTFpJd2JOdXNYd3JDYlVtbERNSU9vRkNjazhrbVYxZ2IyZmp1RStzK092?=
 =?utf-8?B?NmFIZE1oTUV0S1dWaFhyRW9mRiswNjhsM01hTGc2aDQxWXVlRjJKL0d1Y3pD?=
 =?utf-8?B?WHFLQjQ1OFFIc0JSd2M3ZEF2a3JKbndXZ3hsR3BHS1pSZHR1S3BVUmF0U0JC?=
 =?utf-8?B?dXlxU29SWnNsaDBpOFk4aFgvRGVPSHpuWkpFZnM4UXpGQVlJMTRkbWVBYTd1?=
 =?utf-8?B?MjNMVWlmMHRWT3diZ0JhZTFZQ3dpLzkzcFpDalJOZ0gzNkxZSGdTVy9kQksv?=
 =?utf-8?B?Yk5wQVUrMUtCK1RUMndoN1BPKzdDWWlESmxyUDI2RmNTSHRaUWxVcHcwZTB2?=
 =?utf-8?B?R2hhU09JblFCSGxjRmdST0FxL0hyOGIxQk9aY1lFcDdhNytzc0tTcXdZYXNZ?=
 =?utf-8?Q?lwu8z9tGR3ydVAphNw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5106.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56eee710-aab8-4d06-a656-08de8ef3a405
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 07:03:41.2976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMQX1wHbyfEoqrOmzaQ2sCxufkQ58b+CUtP1NsxOHbPvCwUAbdBmoljxCMhlP7HB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
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
Cg0KUGF0Y2ggMS05Og0KDQpSZXZpZXdlZC1ieTogRmVpZmVpIFh1IDxGZWlmZWkuWHVAYW1kLmNv
bT4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpv
LkxhemFyQGFtZC5jb20+DQpTZW50OiBNb25kYXksIE1hcmNoIDMwLCAyMDI2IDU6MDggUE0NClRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+OyBLYW1hbCwgQXNhZCA8QXNhZC5LYW1hbEBhbWQuY29tPjsgWHUsIEZlaWZlaSA8
RmVpZmVpLlh1QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDAwLzE0XSBSZWZhY3RvciBy
ZXNlcnZlZCByZWdpb24gYWxsb2NhdGlvbg0KDQo8cGluZz4NCg0KT24gMjYtTWFyLTI2IDE6MTUg
UE0sIExpam8gTGF6YXIgd3JvdGU6DQo+IEN1cnJlbnRseSwgbXVsdGlwbGUgdmFyaWFibGVzIGFy
ZSBtYWludGFpbmVkIGluIG1lbW9yeSBtYW5hZ2VyIGZvciB2YXJpb3VzIHJlc2VydmVkIHJlZ2lv
bnMgaW4gVlJBTS4NCj4gU3VjaCByZWdpb25zIHNob3VsZCBub3QgYmUgYWxsb2NhdGVkIHRvIG90
aGVyIHB1cnBvc2VzLiBJbnN0ZWFkIG9mDQo+IGRpZmZlcmVudCB2YXJpYWJsZXMsIHRoZSBzZXJp
ZXMgYXNzaWducyB1bmlxdWUgaWRzIHRvIHJlc2VydmVkIHJlZ2lvbnMgYW5kIG1haW50YWlucyBh
biBhcnJheSBvZiB0aGVtIGluc2lkZSBtZW1vcnkgbWFuYWdlci4NCj4NCj4gUGFydC0xOiBUaGUg
Zmlyc3QgOSBwYXRjaGVzIG9mIHRoZSBzZXJpZXMgYXNzaWducyB1bmlxdWUgaWRzIGFuZA0KPiBt
YWludGFpbnMgdGhlbSBhcyBhbiBhcnJheSBvZiByZXNlcnZlZCByZWdpb25zIGluc2lkZSBtZW1v
cnkgbWFuYWdlci4NCj4NCj4gUGFydC0yOiBUaGUgbGFzdCA1IHBhdGNoZXMgb2YgdGhlIHNlcmll
cyBwcmVmaWxscyByZXNlcnZlIHJlZ2lvbiBkYXRhDQo+IHVwZnJvbnQgaW4gYSBjb25zb2xpZGF0
ZWQgZnVuY3Rpb24gYW5kIHRoZW4gcmVzZXJ2ZXMgdGhlbSB0b2dldGhlciBpbg0KPiBhIHNpbXBs
ZSBsb29wLiBJdCBkb2Vzbid0IGZpbGwgaW5mbyBmb3IgYWxsIHJlZ2lvbnM7IHRoZSBkYXRhIGZv
ciBzb21lDQo+IHJlZ2lvbnMgY291bGQgYmUgc3RpbGwgYmUgZmlsbGVkIGluIGEgc2NhdHRlcmVk
IG1hbm5lciBsaWtlIGZyb20gYXRvbQ0KPiBmaXJtd2FyZSB0YWJsZXMgb3IgaG9zdCBkcml2ZXIg
dGFibGVzLiBBbHNvLCB0aGVyZSBjb3VsZCBiZSBzb21lDQo+IHJlZ2lvbnMgbGlrZSBleHRlbmRl
ZCBmaXJtd2FyZSByZWdpb25zIHdoaWNoIGdldHMgZmlsbGVkIGxhdGVyIGR1cmluZyBydW50aW1l
IGFuZCBhbGxvY2F0ZWQgbGF0ZXIuIFRoZXkgZG9uJ3QgZ2V0IGFsbG9jYXRlZCBpbiB0aGUgaW5p
dCBzdGFnZSBhcyB0aGVpciBzaXplIHdpbGwgYmUgMC4NCj4NCj4gdjE6DQo+ICAgICAgIFBhcnQt
MQ0KPiB2MjoNCj4gICAgICAgUGFydC0xICsgUGFydC0yDQo+ICAgICAgIFJlbmFtZSBmdW5jdGlv
bnMvdmFyaWFibGUgKEFsZXgpDQo+DQo+IExpam8gTGF6YXIgKDE0KToNCj4gICAgZHJtL2FtZGdw
dTogQWRkIHJlc2VydmVkIHJlZ2lvbiBpZHMNCj4gICAgZHJtL2FtZGdwdTogQWRkIHN0b2xlbiB2
Z2EgcmVzZXJ2ZS1yZWdpb24NCj4gICAgZHJtL2FtZGdwdTogQWRkIGV4dGVuZGVkIHN0b2xlbiB2
Z2EgcmVzZXJ2ZS1yZWdpb24NCj4gICAgZHJtL2FtZGdwdTogQWRkIHN0b2xlbl9yZXNlcnZlZCBy
ZXNlcnZlLXJlZ2lvbg0KPiAgICBkcm0vYW1kZ3B1OiBBZGQgZndfcmVzZXJ2ZWQgcmVzZXJ2ZS1y
ZWdpb24NCj4gICAgZHJtL2FtZGdwdTogQWRkIGZpcm13YXJlIGV4dGVuZGVkIHJlc2VydmUtcmVn
aW9uDQo+ICAgIGRybS9hbWRncHU6IEFkZCBmdyB2cmFtIHVzYWdlIHJlc2VydmUtcmVnaW9uDQo+
ICAgIGRybS9hbWRncHU6IEFkZCBob3N0IGRyaXZlciByZXNlcnZlZC1yZWdpb24NCj4gICAgZHJt
L2FtZGdwdTogQWRkIG1lbW9yeSB0cmFpbmluZyByZXNlcnZlLXJlZ2lvbg0KPiAgICBkcm0vYW1k
Z3B1OiBHcm91cCBmaWxsaW5nIHJlc2VydmUgcmVnaW9uIGRldGFpbHMNCj4gICAgZHJtL2FtZGdw
dTogQWRkIGZ1bmN0aW9uIHRvIGZpbGwgZncgcmVzZXJ2ZSByZWdpb24NCj4gICAgZHJtL2FtZGdw
dTogQWRkIGZ1bmN0aW9uIHRvIGZpbGwgdHJhaW5pbmcgcmVnaW9uDQo+ICAgIGRybS9hbWRncHU6
IE1vdmUgdmFsaWRhdGlvbiBvZiByZXNlcnZlIHJlZ2lvbiBpbmZvDQo+ICAgIGRybS9hbWRncHU6
IENvbnNvbGlkYXRlIHJlc2VydmUgcmVnaW9uIGFsbG9jYXRpb25zDQo+DQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2F0b21iaW9zLmMgIHwgICA2ICstDQo+ICAgLi4uL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYXRvbWZpcm13YXJlLmMgIHwgIDE4ICstDQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jICAgICAgIHwgIDIzICstDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oICAgICAgIHwgICAyICstDQo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jICAgICAgIHwgIDEzICst
DQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5oICAgICAgIHwgICAx
IC0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgICAgICAgfCAg
IDIgKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgICAgICAg
fCAzNjIgKysrKysrKystLS0tLS0tLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3R0bS5oICAgICAgIHwgIDUzICstLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92aXJ0LmMgICAgICB8ICA1MCArLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjEwXzAuYyAgICAgICAgfCAgIDIgLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dtY192MTFfMC5jICAgICAgICB8ICAgMiAtDQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ21jX3YxMl8wLmMgICAgICAgIHwgICAyIC0NCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjZfMC5jICAgICAgICAgfCAgIDIgLQ0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192N18wLmMgICAgICAgICB8ICAgMiAtDQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y4XzAuYyAgICAgICAgIHwgICAyIC0NCj4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jICAgICAgICAgfCAgIDIgLQ0KPiAgIC4uLi9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8ICAgNCArLQ0KPiAgIC4u
Li9kcm0vYW1kL3Jhcy9yYXNfbWdyL2FtZGdwdV92aXJ0X3Jhc19jbWQuYyB8ICAxNiArLQ0KPiAg
IDE5IGZpbGVzIGNoYW5nZWQsIDI1NiBpbnNlcnRpb25zKCspLCAzMDggZGVsZXRpb25zKC0pDQo+
DQoNCg==
