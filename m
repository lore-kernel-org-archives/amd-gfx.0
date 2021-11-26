Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623ACC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 13:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C036F6EB7E;
	Fri, 26 Nov 2021 13:07:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9075E6EB7E
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 13:07:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORyLS5ogY6Ximv4WscptweVzy25At9BWfcpKmhnbej8Ge2sNjI6YI6nOJcM0NShAtMtJKtxZViijktTNE0YS395VEYKNo79iYuvxIM/i5JIN4W3g0gf0oOsPMpYuMNSFu77JweyeQKbQRHt33CwFxiRL8+lQjuWhAO07jUnutwlbVddWhYMvsi2J3KTQJ8YClS767+tA5a9khE7eqwniTNrqRLgs6kJkdopRM36Q86tru/j6FHOFxjUaD1LBq8cGxBoAlmzLofvGnTYLJ3UkDVUPKq4YVTSZa7FRxvIXkC2WC+FFBNP/VVhsoLOwvgcooMpvYvrx9JcJFildN3gelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suNLRWnfWTKeJLHalbBxyeMboQx9T07Q5DLgj3/lpUw=;
 b=dcC4Jtm9mHnAORyjofhrYizf8mBRdg2TXQmi16x7YchgEmjEEDK7W4xnYqlM2grtqSIzOqn4lanqsGXAWUptvoswtzk25baT/NfSsaBaBhj2HkONLhIxZuRl8MXooVhqXoQ/StLsnqbfWUBGODEFiCR3pNaHN23+fVI/1sFZwj484tTYHjcu72kv1mFHCFrzNwyjbyzakBij9FfAyc7vQPxBIrXwEsJS5dd2LgDpqI+d3sjjkTaU9fF9RLk2ma7AppbHDiek6ULueF3Cqbm1wz46RRsuPYBCQIPdCUKMOVHrK1cfpO6m34OK55DuhSVTTNeWY/yyREw0ibHkZK2ASw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suNLRWnfWTKeJLHalbBxyeMboQx9T07Q5DLgj3/lpUw=;
 b=kA0eiB4Y+aUk+7JV7Uh7+FiUZnl1U3ZHJiG7ex62Ep77y73SsMtwqjgEJ5BwHhSH9lN/i4LmBXQps2xSZS4HzxIrtdlW8eQ0JRhD3EyVqWNa1MQ4lFJ0KFTM8E051buUVb7RWkE7hm1XYQ1iECgEnc3Jzy4xtWabJ53x1+LVeyg=
Received: from DM4PR12MB5342.namprd12.prod.outlook.com (2603:10b6:5:39f::5) by
 DM4PR12MB5375.namprd12.prod.outlook.com (2603:10b6:5:39a::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22; Fri, 26 Nov 2021 13:07:45 +0000
Received: from DM4PR12MB5342.namprd12.prod.outlook.com
 ([fe80::e013:3ea8:78a9:fe6e]) by DM4PR12MB5342.namprd12.prod.outlook.com
 ([fe80::e013:3ea8:78a9:fe6e%5]) with mapi id 15.20.4713.027; Fri, 26 Nov 2021
 13:07:45 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>, 
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggUmV2aWV3IDEvMV0gZHJtL2FtZGdwdTogZml4IGRp?=
 =?utf-8?Q?sable_ras_feature_failed_when_unload_drvier?=
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: fix disable ras feature failed
 when unload drvier
Thread-Index: AQHX4qrH879W1b1KHUyBatZqER11jqwVxOGAgAAB/cA=
Date: Fri, 26 Nov 2021 13:07:45 +0000
Message-ID: <DM4PR12MB5342E076533F063F000BF8999A639@DM4PR12MB5342.namprd12.prod.outlook.com>
References: <20211126094826.13732-1-Stanley.Yang@amd.com>
 <BN9PR12MB52574BFE341A838E1FDB319CFC639@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52574BFE341A838E1FDB319CFC639@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-26T12:57:01Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fe7f4a64-fa8e-45eb-b3be-1ee62c5d2764;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-11-26T13:07:40Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: d12e2bb0-ccdc-4aba-81c6-328b79d5400a
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76b88050-e1a2-4544-ad21-08d9b0ddbcf0
x-ms-traffictypediagnostic: DM4PR12MB5375:
x-microsoft-antispam-prvs: <DM4PR12MB5375B7A1191E4FD01CD6AD509A639@DM4PR12MB5375.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ILlNnYQF66gI6X1uFzUZQH5fhLRdcipiq/gzqZoouKvEeiQuwq9F1+ebD3a/TGyX6zlKluAQLYB6dZrpzYBqix8iSTAk7EVyo513XdxlZ6riY4pxejavbuPF1VYBKN2TtHGc51Hc8jqpfJv/dslglAFaghJ9eOSKGNMzAX23KNxbTcUe44cww5lZq5xFqLzwHoV04LnngKcx1kp/E7X+qaXgK6sC7ohXO9LFZ1LQ3ULw4aXOlxr6RYUUX0S3To8gZU5Te4mC6FDCdFAjED85V/Wp2WbSOTN8An4iJDk/rakcJGXbnEjusZ8mJe0M225k1IEYS7WnzdyovHv1EMcAGd3THGBDVFtQNKUHKksP3g7tRncdwkxelEi0tzwgH1cG6WQKAETw0Uqn578uJ9izFyYt+/XMrePT3eGwTyLujvE31A/NPjq7ssx7aYuG9ZdcDY7pxZudvjMkw3F93P32G4NLrQCJEaE6Z6OJbHFRdnuEjQf2pVfikOnx7NJoiVvZLGEqhUB8p1iBPg8+gLRbx7z3JAemmhgYLAJ0zfWCxEMPYoj3wOSWVtQQCYOBRAvaxxRPp2STm3h5giR00Jj+Y/5f/YF+8JmSwgwv96ucit+cUX6b8w1AyP092y3datWwzlxdM34RVkhHG5raMunhqbb3joBHx6s2xvo9zOfR/a3ZwMb86mi09mQj5yQTZwFE7KeNru9wm4RVkbtB9CHnChAu11JBBqupfXSV/+qphoM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(38070700005)(224303003)(9686003)(508600001)(53546011)(52536014)(122000001)(64756008)(66556008)(55016003)(7696005)(921005)(110136005)(66946007)(76116006)(8936002)(66446008)(86362001)(2906002)(316002)(71200400001)(38100700002)(33656002)(26005)(83380400001)(6506007)(66476007)(6636002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1JVbFFYTFk5U0x0MXhFNkNjOFhEbDE2dmZtMVkwNmhaVS9SUlJlcnQ2NFVV?=
 =?utf-8?B?eWlSNXhDVHlmc09LbG9GT0MrMmVZM01nUGNyVHd0Y3ZQK24vT1dCbVRrVjRY?=
 =?utf-8?B?aHF4aXpyUldnNDQ1dnBzS2xKM0JhTmpPVWV5TU9MWS9rUHAxbzdwWE5NelVM?=
 =?utf-8?B?VUZHN3FBWkEwYUFCNUxITU9kZE00Z1Y5ZUlUeXpnNFord3E5emE0T2U2cTcr?=
 =?utf-8?B?MGdsbUhLYUZtZGNid3AzbnEycjRYaUVmYnpjVDl3bFc4SGEveTFtc21MVklr?=
 =?utf-8?B?YzFscEJ0ejcrTm9SdGQ5NDdTaUJoZHFLK3pSRFRna3BaMVZDeTZZU3EveUww?=
 =?utf-8?B?cnkyM2o1eEpyL0V3S2xyQmxZWDFkSVVHdjNHMVgvVkZFRG1PdjNkMjVaU3hh?=
 =?utf-8?B?eXpSOEQrSFoyREY0U2J6MTlDWUVUU2RIWG5tUU8xc1FzeG1DVnE3SVJYRG1F?=
 =?utf-8?B?b0pxWklhemQ0eHRBeFk3ay9qU1RSK2R1TDl2YU9kVExVNHFKbzA4SXF2YjNM?=
 =?utf-8?B?cXcxODc3cTdBWmdDYzUwY20rcWtvRnNCSzVGNVc2aXdVcU95Yjh6YVZRZTBy?=
 =?utf-8?B?Z3lEL3pmMmxDd0FJK05MWGdhb1l2UC94VW5LMFdmS3pObVJtZFB1YUxuZDlt?=
 =?utf-8?B?QXYyZjBqSGIxR0pOY3gvRHlXL3pMdGlLa0RnZGpmMWhhUW9MVlo5NUl4d2dt?=
 =?utf-8?B?QXhreU9ORnA1ZU1VcVVBV0huMy9RblB2K0dPb04xZzU1L0Z1akVqTE5KVkZ4?=
 =?utf-8?B?VmJnV013OWJGMXlqMkphUitOWjRWNXFNVndRMDJyOElVRG0zQlN6RkIzL291?=
 =?utf-8?B?NVF4c0FDSGN5bkVDQlk1aDdUR05PMG1KODRNaFNBd0ZmZWxDNExIQkU5dU5S?=
 =?utf-8?B?aFcrVlU2YTB5V01BbEhaR2FDd1k3TGUrMmhISDZ4U3UxaEhuVStSZmpYQlJa?=
 =?utf-8?B?dnc0ZFhhemZLbDZuVDNTbGpJNklUNHp5b1dPMlBYL0VtZkF5Nlc1emYxb1VD?=
 =?utf-8?B?OEpCTnZZeUo1Y1hld2dCeWx6T2VWendlMkwzL2Q1YytOMHB5STNMVTA2QU1v?=
 =?utf-8?B?enZSdG95eDlTWGRIVXlxWUN3WHJmV084UEQ0RzN0amR6b3VqV3BwdmNvc0gv?=
 =?utf-8?B?TXB4VCtTdU1zUEhZTVJ3VlhIckt2RGRFcjJDUkhkQzJOUGJkem5HbHVPK0c5?=
 =?utf-8?B?THExa1pqNkNzQXhDWHcrMjhrSEpIQkpGVGJiVDZqT01PY2VFMVdBZmYwaUdU?=
 =?utf-8?B?Y0h5WmtBWXBIVWtSNy9QNFl5NStqSkY2VW9CcmhTV0ZBcm9sWG53ZUc4SnR6?=
 =?utf-8?B?dXlGL1JwckViVnpTNmViUFlmU1V2TUlkeFNyYUNMbmJJb2Q3ZHZ5b0tYR1BJ?=
 =?utf-8?B?MitLN2o0TXk3dDdTUmYyZzJlYlJVWE9tMUtHSlZySE5vZU96czhqeDBFbFBT?=
 =?utf-8?B?V3dMVlBYWHJNR1l5NHJGN3h3Rjl3eTBMSnVUcHJZS1JCeGFjTEdCU2ZYa3Q1?=
 =?utf-8?B?NFdLdW9ZNzRBS0VVNE1HUjNUR1FCR0lUZzVFYVJYUWw5VlhMdkxuVEYzNVRL?=
 =?utf-8?B?WWlKQWtpaTFJU1cxSG5WanZmelVsNDJlbGUySVlFYXNSa2cyclozMDA4Z3Iv?=
 =?utf-8?B?eXJJTi8wLytwTi9vTmNjL1dsUE91M29Zc0hYWDZkODJ6TFBwWFBPc09HcjI4?=
 =?utf-8?B?R3BKMVNkRlpSR1FaczJpNmlwR2N5aDRwc3kwSjRwbE9QVVdrbklIZW4zUWd1?=
 =?utf-8?B?VWZIV21xUGtvSzVlQkE2ME9zS0czZmRqV00yZHZEd3JjbWZKRjFzS2oySndm?=
 =?utf-8?B?anU2VXVPcXlyaThVdVBjSmhoN3YrUGV1cXZpYlpBRDhmNFczazVBV1ZOc1hL?=
 =?utf-8?B?Z3dPblJVOER5dTNkRUFFVmxTd0VpOHZGWU9vdytLdUNZSDlrMjJBVmlNdEla?=
 =?utf-8?B?aVV3eHZPb3QycURVMG1jeUVRV0gvaEJTNU5uSnlXRTVjZDZ0UHlaVVlEeWF4?=
 =?utf-8?B?Wjk4R0E2LzJPNW0zWk9CRkZIYnozck55SUs3ME9ZZytHWkY3RVQvcWhaWUkw?=
 =?utf-8?B?MUtPbHl1NVVhTThLYjJXcWJvai9ZQ1QwQzhHaytDSzJNeTR3cmhqeDRFbUlG?=
 =?utf-8?B?dEo2dWU3eHYzZ0RRZWdXeTJOS3dZcVVoRnVQYVM1bFl5ajdFdW4wL1RJR3My?=
 =?utf-8?Q?FMF2SjgPxolnylKw/Dho6/o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b88050-e1a2-4544-ad21-08d9b0ddbcf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 13:07:45.0729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ff4P/9OwtTVL1E8u7440/Uk9I0thiE0aWDHPbCwEqhWcFG2aSEsZKpaTcFSGC40exgVV1tH9M2ZEDhhnnd4cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5375
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSXQncyBub3QgbmVjZXNzYXJ5LCBiZWNhdXNlIGJl
Zm9yZSBodyBmaW5pLCBhbGwgcmFzIGZlYXR1cmVzIGhhdmUgYmVlbiBkaXNhYmxlZCBhbmQgY29u
LT5mZWF0dXJlcyBpcyBzZXQgdG8gemVyby4NCg0KUmVnYXJkcywNClN0YW5sZXkNCj4gLS0tLS3p
gq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpo
YW5nQGFtZC5jb20+DQo+IOWPkemAgeaXtumXtDogRnJpZGF5LCBOb3ZlbWJlciAyNiwgMjAyMSA4
OjU3IFBNDQo+IOaUtuS7tuS6ujogWWFuZywgU3RhbmxleSA8U3RhbmxleS5ZYW5nQGFtZC5jb20+
OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IENsZW1lbnRzLCBKb2huIDxKb2hu
LkNsZW1lbnRzQGFtZC5jb20+Ow0KPiBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IExp
LCBDYW5kaWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+Ow0KPiBDaGFpLCBUaG9tYXMgPFlpUGVuZy5D
aGFpQGFtZC5jb20+DQo+IOaKhOmAgTogWWFuZywgU3RhbmxleSA8U3RhbmxleS5ZYW5nQGFtZC5j
b20+DQo+IOS4u+mimDogUkU6IFtQQVRDSCBSZXZpZXcgMS8xXSBkcm0vYW1kZ3B1OiBmaXggZGlz
YWJsZSByYXMgZmVhdHVyZSBmYWlsZWQNCj4gd2hlbiB1bmxvYWQgZHJ2aWVyDQo+IA0KPiBbQU1E
IE9mZmljaWFsIFVzZSBPbmx5XQ0KPiANCj4gR29vZCBjYXRjaC4gV2Ugc3RpbGwgbmVlZCB0byBy
ZWxlYXNlIHJhcyBvYmplY3QgaW4gdGhlIGVuZC4gQW55IHJlYXNvbiB0aGUNCj4gc2VxdWVuY2Ug
d2FzIHJlbW92ZWQ/DQo+IA0KPiBAQCAtMjU2NCw5ICsyNTYzLDYgQEAgaW50IGFtZGdwdV9yYXNf
ZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gDQo+ICAJV0FSTihjb24tPmZlYXR1
cmVzLCAiRmVhdHVyZSBtYXNrIGlzIG5vdCBjbGVhcmVkIik7DQo+IA0KPiAtCWlmIChjb24tPmZl
YXR1cmVzKQ0KPiAtCQlhbWRncHVfcmFzX2Rpc2FibGVfYWxsX2ZlYXR1cmVzKGFkZXYsIDEpOw0K
PiAtDQo+IAljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmNvbi0+cmFzX2NvdW50ZV9kZWxheV93
b3JrKTsNCj4gDQo+IFJlZ2FyZHMsDQo+IEhhd2tpbmcNCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IFN0YW5sZXkuWWFuZyA8U3RhbmxleS5ZYW5nQGFtZC5jb20+DQo+
IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMjYsIDIwMjEgMTc6NDgNCj4gVG86IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywgSGF3a2luZw0KPiA8SGF3a2luZy5aaGFuZ0BhbWQu
Y29tPjsgQ2xlbWVudHMsIEpvaG4gPEpvaG4uQ2xlbWVudHNAYW1kLmNvbT47DQo+IFpob3UxLCBU
YW8gPFRhby5aaG91MUBhbWQuY29tPjsgTGksIENhbmRpY2UgPENhbmRpY2UuTGlAYW1kLmNvbT47
DQo+IENoYWksIFRob21hcyA8WWlQZW5nLkNoYWlAYW1kLmNvbT4NCj4gQ2M6IFlhbmcsIFN0YW5s
ZXkgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggUmV2aWV3IDEvMV0g
ZHJtL2FtZGdwdTogZml4IGRpc2FibGUgcmFzIGZlYXR1cmUgZmFpbGVkDQo+IHdoZW4gdW5sb2Fk
IGRydmllcg0KPiANCj4gRnVuY3Rpb24gYW1kZ3B1X2RldmljZV9maW5pX2h3IGlzIGNhbGxlZCBi
ZWZvcmUgYW1kZ3B1X2RldmljZV9maW5pX3N3LA0KPiBzbyByYXMgdGEgd2lsbCB1bmxvYWQgYmVm
b3JlIHNlbmQgcmFzIGRpc2FibGUgY29tbWFuZCwgcmFzIGRzaWFibGUgb3BlcmF0aW9uDQo+IG11
c3QgYmVmb3JlIGh3IGZpbmkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTdGFubGV5LllhbmcgPFN0
YW5sZXkuWWFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYyB8IDUgKysrLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yYXMuYyAgICB8IDQgLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jDQo+IGluZGV4IDczZWM0NjE0MGQ2OC4uZDVlNjQyZTkwMDEwIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IEBA
IC0yODM4LDggKzI4MzgsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfaXBfZmluaShzdHJ1
Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gIAlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYp
ICYmIGFkZXYtPnZpcnQucmFzX2luaXRfZG9uZSkNCj4gIAkJYW1kZ3B1X3ZpcnRfcmVsZWFzZV9y
YXNfZXJyX2hhbmRsZXJfZGF0YShhZGV2KTsNCj4gDQo+IC0JYW1kZ3B1X3Jhc19wcmVfZmluaShh
ZGV2KTsNCj4gLQ0KPiAgCWlmIChhZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMgPiAx
KQ0KPiAgCQlhbWRncHVfeGdtaV9yZW1vdmVfZGV2aWNlKGFkZXYpOw0KPiANCj4gQEAgLTM5NTks
NiArMzk1Nyw5IEBAIHZvaWQgYW1kZ3B1X2RldmljZV9maW5pX2h3KHN0cnVjdA0KPiBhbWRncHVf
ZGV2aWNlICphZGV2KQ0KPiANCj4gIAlhbWRncHVfZmJkZXZfZmluaShhZGV2KTsNCj4gDQo+ICsJ
LyogZGlzYWJsZSByYXMgZmVhdHVyZSBtdXN0IGJlZm9yZSBodyBmaW5pICovDQo+ICsJYW1kZ3B1
X3Jhc19wcmVfZmluaShhZGV2KTsNCj4gKw0KPiAgCWFtZGdwdV9kZXZpY2VfaXBfZmluaV9lYXJs
eShhZGV2KTsNCj4gDQo+ICAJYW1kZ3B1X2lycV9maW5pX2h3KGFkZXYpOw0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+IGluZGV4IDM5ZGZkNGQ1OTg4MS4uNjUx
MDJkMmEwYTk4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmFzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5j
DQo+IEBAIC0yNDg0LDcgKzI0ODQsNiBAQCB2b2lkIGFtZGdwdV9yYXNfbGF0ZV9maW5pKHN0cnVj
dCBhbWRncHVfZGV2aWNlDQo+ICphZGV2LA0KPiAgCWFtZGdwdV9yYXNfc3lzZnNfcmVtb3ZlKGFk
ZXYsIHJhc19ibG9jayk7DQo+ICAJaWYgKGloX2luZm8tPmNiKQ0KPiAgCQlhbWRncHVfcmFzX2lu
dGVycnVwdF9yZW1vdmVfaGFuZGxlcihhZGV2LCBpaF9pbmZvKTsNCj4gLQlhbWRncHVfcmFzX2Zl
YXR1cmVfZW5hYmxlKGFkZXYsIHJhc19ibG9jaywgMCk7DQo+ICB9DQo+IA0KPiAgLyogZG8gc29t
ZSBpbml0IHdvcmsgYWZ0ZXIgSVAgbGF0ZSBpbml0IGFzIGRlcGVuZGVuY2UuDQo+IEBAIC0yNTY0
LDkgKzI1NjMsNiBAQCBpbnQgYW1kZ3B1X3Jhc19maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQ0KPiANCj4gIAlXQVJOKGNvbi0+ZmVhdHVyZXMsICJGZWF0dXJlIG1hc2sgaXMgbm90IGNs
ZWFyZWQiKTsNCj4gDQo+IC0JaWYgKGNvbi0+ZmVhdHVyZXMpDQo+IC0JCWFtZGdwdV9yYXNfZGlz
YWJsZV9hbGxfZmVhdHVyZXMoYWRldiwgMSk7DQo+IC0NCj4gIAljYW5jZWxfZGVsYXllZF93b3Jr
X3N5bmMoJmNvbi0+cmFzX2NvdW50ZV9kZWxheV93b3JrKTsNCj4gDQo+ICAJYW1kZ3B1X3Jhc19z
ZXRfY29udGV4dChhZGV2LCBOVUxMKTsNCj4gLS0NCj4gMi4xNy4xDQo=
