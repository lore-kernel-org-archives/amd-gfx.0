Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85488CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 07:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F1710E432;
	Thu, 12 Oct 2023 07:43:00 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 344B510E432
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 07:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTD9g6vAPvzh1hK8HsLYIqkVNNhZdrImaxD2NonXmEeildKpsuKvyPlP0SSDlhxiDyzAEb2SeaMf1vql4O6Ycc37rBKtAh8yuS5WRsoKTjfA5wvrQBBLBkkEdz17Lj/XWl8lSsqzzdFuW9SHx71+kTicjKhiIdOT+VVMK3S6KofRFQ8PPwqEja09A2e5wyqRv+ZUtDCn+Vtv1SBjLhbGNgsc2PiSl/YmmU936pLRZXkD8P2cDfpBgR6pBlXU3eXXLOwKAzSaiReIwe2DvwC3eopqu7L9U8TdjvRQMc9F1YVv6hj2Na1FvsnOwXgjdcFtCV+kfV8lJtnsGn0iFndh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Stn6NaUPUNL8Add0KgonfLf/FJiUgAvSgX3ePxZHKlg=;
 b=gvQlimj0BfHVrnBK7Nsq8PZLA+a2WzXvNsEuEVTYpdV40f86TIWo9jicSQJvwER+JGtHD9tQzFXSDJB5MD3kI3ummOEi+T2We02XdMmRYR0lurzlDw1vnq/JFlg7f+Oeof2QbTNwcy6kA64WCLgEetXFC8RJRcjltxnQNEMDERM9eAwlgfe4VVdx2DC437Jn8BlsTLPtJ5fDa2kCnYXFDTvDILT+Sn1Y7XBZooVl9HgSw8TJpE4BllNgU/FxmFb6FzdvVmWr70y+ehltShsJW6Wl+9IQbzkk/Wr/kyxXOCue+t6YtWrZ6mCpIj6j0FwfIUkFMGb4jg8zN1+R+ogcdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Stn6NaUPUNL8Add0KgonfLf/FJiUgAvSgX3ePxZHKlg=;
 b=SrgW+Ql4ayAG/XWDEP+lhrJvzBjQdMdvdbZ4lRti3GY87f9L9DpVNucZqsP6W9bhkWjGXZSTRHIOejsZPewHBhVvvsvCItw5Q82ey8jPV68Z93eI/t6HhoUeCBvr171x7al+K3UXlHdiR3cqIZZdTdWOWem5GGqquIoiFOCmmtw=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 07:42:55 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 07:42:55 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Avoid FRU EEPROM access on APU
Thread-Topic: [PATCH] drm/amdgpu: Avoid FRU EEPROM access on APU
Thread-Index: AQHZ/N6/8e3yAsD3TEyIJgevbmzsFLBFxRAm
Date: Thu, 12 Oct 2023 07:42:55 +0000
Message-ID: <PH7PR12MB59977C0FE211A89CD8A1C83B82D3A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231012073541.114169-1-lijo.lazar@amd.com>
In-Reply-To: <20231012073541.114169-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-12T07:40:42.1909642Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH0PR12MB7469:EE_
x-ms-office365-filtering-correlation-id: eae55b59-2d78-4bbe-9d02-08dbcaf6d8f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AVyWldzKUImlE31IVh8rua8vFgu4wOquTX9S8Fp/bK1acreAawOIPqUSX2UbOT8llmIWd+CheibxQUcy5ib+91JkuC3nugOWwh3ARnjM4D+1K16bD0AVwYdIzSXwmr1QtGaY1bcvroKC3O/ukzTcFGVPC8ITw8T007V5ONX1QdOFek6WgA74UBmjhv3qVn2pou+mYWDwOySBKyxY9qHluhrJyGRVd8OT5w1gtu7B7L2cKROBH/Hmaw6k+nK2oXcs6MlFnQx7QQv5WhjJZPXvgobmPFKhr+rvp5L3ETeVVdYEpBOWiZiaWNHWTC1kt3NNiKJp7kh7+LBppVKpEwGjY83Idezl+KTtyaC2Ddz+BNR7ddOGlR1GSXGbqu0RikE5ZfiA5QKq6QwEEVKsT2Yy16Qr1IyarylKzKAI+w1MzyqTvL/kQR9o4pSMA9kOOwKLTXFuRhWIGBBmLrP3AHatuxN5trC3qgq00ObLDIHPRpBT9CgWRa6xAVr/hWvD6UrQS55on/89DPO96QZavioQxV4Ww1Vt5L9jbFUZAzjO1qjJzlNRDc+10gdIAenpuHS0z90Kf/yOkogw/kGaMsqH3Inxw+p3YFk06AFdfYOceUkxczkVS9XTDXGvompWryNL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(376002)(366004)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(38070700005)(2906002)(52536014)(38100700002)(5660300002)(8936002)(4326008)(8676002)(122000001)(41300700001)(55016003)(33656002)(86362001)(83380400001)(9686003)(478600001)(71200400001)(6506007)(7696005)(110136005)(76116006)(66946007)(66476007)(316002)(66556008)(54906003)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NG9RajlHL0xHWTNmWko0YmRhVDI0QUVMNUMrVmRmdGoxeFZHbnBZYlVjZXg1?=
 =?gb2312?B?alE2N2ZlQnJpVDlPNXRCVWNaR2M5ZHZ4SlFJN2lHU1BNa1YzbzR5aDdyWEZk?=
 =?gb2312?B?Z1VVMWRnVjh6YWNhS2wzQUp3UFZZeUkwS1BJYWpINnVMTzNRcmxMQXF5S0Va?=
 =?gb2312?B?cUJZOXF3TjVNbDlzVEUrVWxGNzVUQnkwT24zM1RobDA1SmcxNzNKUXllcWk5?=
 =?gb2312?B?YysvdlAwdHF4UlBEeWErRlk2VDBMdGozMWVTVFgrbXR1WnhuTDhaSHZiY3o1?=
 =?gb2312?B?U0orTkpjWUQ3UjkvMDA1Z2VNcGcrNGIxTDFsMVpRZ2RRd2xOYVVpeVJRQ05S?=
 =?gb2312?B?dXIvUjN4UHRmdEQxVjVqNHRKcTl1cGY0SFcyaEF2YVFQVEFOWmNlWE54NE0r?=
 =?gb2312?B?bkFQSGVmUWI2Si9sZ3ozMWJwR2xDU2paOXFEa3pZd3ZkMDZrR2h3cVZic0FR?=
 =?gb2312?B?U2xQbURBWmo0Nll2SURRN3dJY1NhU0ZRN29SVXQ2VklVTGM3bHk5cmIvalpV?=
 =?gb2312?B?OG02bVNTakdMdGVYNHNHWWtGOC9nYlZEMlNxWUJFOWd6Q0pyVTZQdWl2ZHN5?=
 =?gb2312?B?eVRsTExqWjcxaGRXbHhoS3ZxWGVPU2NYTlMvdGlhZVNLVXVmMGVFOGNiRlM4?=
 =?gb2312?B?MW9aSzg1YjMva3NVWFNISjZVRXVLaXBRMGlHWFYyQ0w3VVRsWjdJQ0tjTU9w?=
 =?gb2312?B?d3hFaHB6QW16bkhiVDlUUGVteVFibkIvUThDek9iNy9mcHVaQWF6eEJyUlNv?=
 =?gb2312?B?WjNUOVpSWHFacGpyR1QvamhOeXBpUnRmMzhPdnRGUTJrdkROczFDS2hIVFds?=
 =?gb2312?B?SnBGTW1hOWJBRFVKZXZVTEs1NFJxWGhWdmxhVk10V1ZCVjRqcllabVVaSjJp?=
 =?gb2312?B?d0xKa2o0dUE4bk5MQWkvdGp1dm5HQUFyUk12WHVqbE9MeXFldGdyRXowMG1W?=
 =?gb2312?B?Y09vTlcrQUZBaVNZZnZySDU2T1pNRVQ1aUw4ZkVnSFNsZ0pOdUI2aUU1NW4y?=
 =?gb2312?B?cDFBK0w0TFpUWlpobkp3MzZEUGVuSERiMXBKQXI5K3VmbE5EZldJVHJQYVBz?=
 =?gb2312?B?eVNodHhyL2IyWHhJeE9xckQrSnNlWjg0YUoyeXg4WGtCNjE4U1hPVGR6VDg3?=
 =?gb2312?B?Ynp0T3MzamlZNnpTTExOQndmd1RWZktENDgyNkZLTkx6WGZ6bEVWeVZBUjI4?=
 =?gb2312?B?TVE5L3hBVnl3aFk1MkMrMTlCaENOaldQcHpTKzB4UWg3Q2JWQWFvY2lNUWlo?=
 =?gb2312?B?OC9ZZ0tuMSsyYys0UDdwNExQTEJNSitzRGFKSkh6RXFodFE4dXk3L0t6NGZL?=
 =?gb2312?B?Vk9iUFJ2VGtuQzR6NTRhTFQxRmg0VTJsZ2llWmsxcVg1WGVpNFl5SGRjbDFm?=
 =?gb2312?B?SXAwcjB2b1dsS1RLb3FJQjdaWlRFaG50M3NzZFdWeUJIS0NrWTFGak5zamhm?=
 =?gb2312?B?dUhuUkJWNFJ0ckFyeUtDRUpyUmtlKzVmbkdpd0RRU2NMYWpJNmZIU3VYWTNU?=
 =?gb2312?B?QXljQWhYVW1zVWJGSW5NRzJtVC9lTUFzMzZ4ckVFcE9yQTQ1eTYwb0Q4MnNv?=
 =?gb2312?B?aUVPSzd1cGFhdEl5QTA0cTF1LzBNaURIQVRhRHIvbldOaVFlTFJJdmIrOGRv?=
 =?gb2312?B?aVZmcDM2d2lLV2l0akkrYkxHOHFNSVdlRmNEcEM1dElKd3BPK05PSnlQRDg5?=
 =?gb2312?B?MnpPRUoxYVJ3QWhMS1pWRllkSmVoTDVkZUtUYjFUeDhWRmVKQkQ0QmgvdEZ3?=
 =?gb2312?B?b280cDZlUkpOK3RRWG1USkV1WHVSeVVhN2FTdFlEWjdHMVNVaTFsNG96SFZB?=
 =?gb2312?B?ZTNVSW1nanB3Q0RCZU1BVGVGRmRQQi9RKys2a21hVk5GZkxZNHBzZ1Bybm1w?=
 =?gb2312?B?MGcwWXFrYzNYc3gzVG8velprM2t0V2xkNEJ1NFFOT2ppOW43OEQzN1FkZ2Zz?=
 =?gb2312?B?ZnF3czZjMklpV3EydVpaM1BhUkU2SFgwdENhUE5nVmUzVjJxZUMrQ3JRellP?=
 =?gb2312?B?aVJpSUdBbk9QK09CUlpiK0RvTlpZTno2UmpUaGdCWHNVVzdiWHZnTkVGa3pK?=
 =?gb2312?B?ZVpyQ2hmSFJURnVpT3hpTXkwelI2STFieDhkQjV3cHdsblRtamJXL0M4Y09O?=
 =?gb2312?B?WEFQV3VxVDRMbFdwbXQ2TzI5UEhDZDRDcExpZVdYYmhCTGJQdTA4eklocXdB?=
 =?gb2312?Q?sJKNcb3pL2XziQZQTKTB8JtFd4BqI+EGy8wq3OPxiUZE?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB59977C0FE211A89CD8A1C83B82D3APH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae55b59-2d78-4bbe-9d02-08dbcaf6d8f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 07:42:55.3328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqBvblFtCaduiJZqTibWcuRLhYAhinK2W6OuIKeBJBqgi0DPSfOORA/fG/xaOYPr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB59977C0FE211A89CD8A1C83B82D3APH7PR12MB5997namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBZYW5nIFdh
bmcgPGtldmlueWFuZy53YW5nQGFtZC5jb20+DQoNCkJlc3QgUmVnYXJkcw0KS2V2aW4NCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IExhemFyLCBMaWpvIDxMaWpvLkxh
emFyQGFtZC5jb20+DQq3osvNyrG85Dog0MfG2svELCDKrtTCIDEyLCAyMDIzIDE1OjM2DQrK1bz+
yMs6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4NCrOty806IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBXYW5nLCBZYW5n
KEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT4NCtb3zOI6IFtQQVRDSF0gZHJtL2FtZGdw
dTogQXZvaWQgRlJVIEVFUFJPTSBhY2Nlc3Mgb24gQVBVDQoNCkZSVSBFRVBST00gYWNjZXNzIGlz
IG5vdCB2YWxpZCBmb3IgQVBVIGRldmljZXMuDQoNClNpZ25lZC1vZmYtYnk6IExpam8gTGF6YXIg
PGxpam8ubGF6YXJAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9mcnVfZWVwcm9tLmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZnJ1X2VlcHJvbS5jDQppbmRleCBkNjM1ZTYxODA1ZWEuLmEwOGMxNDhiMTNmOSAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMNCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMNCkBAIC00
Miw4ICs0Miw5IEBAIHN0YXRpYyBib29sIGlzX2ZydV9lZXByb21fc3VwcG9ydGVkKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCB1MzIgKmZydV9hZGRyKQ0KDQogICAgICAgICAvKiBUaGUgaTJj
IGFjY2VzcyBpcyBibG9ja2VkIG9uIFZGDQogICAgICAgICAgKiBUT0RPOiBOZWVkIG90aGVyIHdh
eSB0byBnZXQgdGhlIGluZm8NCisgICAgICAgICogQWxzbywgRlJVIG5vdCB2YWxpZCBmb3IgQVBV
IGRldmljZXMuDQogICAgICAgICAgKi8NCi0gICAgICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2
KSkNCisgICAgICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSB8fCAoYWRldi0+ZmxhZ3MgJiBB
TURfSVNfQVBVKSkNCiAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KDQogICAgICAgICAv
KiBUaGUgZGVmYXVsdCBJMkMgRUVQUk9NIGFkZHJlc3Mgb2YgdGhlIEZSVS4NCi0tDQoyLjI1LjEN
Cg0K

--_000_PH7PR12MB59977C0FE211A89CD8A1C83B82D3APH7PR12MB5997namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div></div>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div=
>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Best Regards</div>
<div dir=3D"ltr">Kevin</div>
<div dir=3D"ltr"><span id=3D"ms-outlook-ios-cursor"></span></div>
</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif"><b=
>=B7=A2=BC=FE=C8=CB:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> =D0=C7=C6=DA=CB=C4, =CA=AE=D4=C2 12, 2023 =
15:36<br>
<b>=CA=D5=BC=FE=C8=CB:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;<br>
<b>=B3=AD=CB=CD:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher,=
 Alexander &lt;Alexander.Deucher@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYa=
ng.Wang@amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b> [PATCH] drm/amdgpu: Avoid FRU EEPROM access on APU
<div>&nbsp;</div>
</font></div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">FRU EEPROM access is not valid for APU devices.<br=
>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
index d635e61805ea..a08c148b13f9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
@@ -42,8 +42,9 @@ static bool is_fru_eeprom_supported(struct amdgpu_device =
*adev, u32 *fru_addr)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The i2c access is block=
ed on VF<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: Need other w=
ay to get the info<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Also, FRU not valid for APU d=
evices.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) || (adev-&g=
t;flags &amp; AMD_IS_APU))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The default I2C EEPROM =
address of the FRU.<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB59977C0FE211A89CD8A1C83B82D3APH7PR12MB5997namp_--
