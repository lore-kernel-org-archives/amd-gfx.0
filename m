Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5E4C77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 08:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 383FB10E1C0;
	Wed, 31 May 2023 08:56:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C33610E1C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 08:56:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyogdQNcL5y5QO40krIOCTpTyMDW06pJWhIYSKz+VSlCFGlHVxxG9C+sXW6wr+47YxrUj6dNJ27sl9LOyNhmiPZ1FqibHd2VyaxqXyH+PoYG+pkVqiQx9RKLiqtOHlrInE8hOZ7IF0XBaoDY4Wcky0Ni2guELQBF4DAwQR24mOd4BqPMyk+v14oFcsxJAnVSvBZ8BuXfKiQLj8sIZaV1qH/bwjzbqPfDxnQPNK8OUMVNG1Vs1iOUa2csAee1q18oQiF3JsNIU94m37loqnNp4cmeHlMRfTqzI95Zs0r9rinN7TpWN0KUDO5qiUnCthQxvvOOdv7NpsDXwZV8pvnk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAIHP8b2piaNru2SH/2BNm6mmCO4MGgD+plAx0AyL8E=;
 b=QFEBv3vl58IOfGOY/LlFEjxDBrzXgtr8oisYN8hPrJDfDPPESsCxOt4tOqV3ETsrCNCoU9/YHcW4aUzM6y9JhV5sDmWI7TiHE9k99xojHjQUk1vKCT6N6Ueynz+wjC1ZkDsEaRpsWp+FTdJ29qyDIKIYw7RruigLhBXbNTGaDMQ3i7IRIWW3KbPJEU5gxkqIbxRaeu7zj1klFi1IrzaLDCrX5zDsK8coEiUjUaHuFwAz3SIPCXFawuZgQQffEic5gprH+R9sc6WTIn1ySuh1zFJj0aPfB2WqCL7mU25wIrmKoojDcBiWOZ1ZY//4b+p5nUrT2yq3nOSeSGVpS/70Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAIHP8b2piaNru2SH/2BNm6mmCO4MGgD+plAx0AyL8E=;
 b=DCUhFHvRfKBnVp0j+HHsXig9R/DjkeriQ6AM9mIgicRW+t9dS/v02/W4eOD2n07bRNXJ/Aywm0eMWTvqNrSQxTlGYwxlozfs5/osPPKSWGyJl0AbYxUBuBW/80G4yGzkI/6CVuy4YunchGuEi7DdtSdciootJPjJK9ANmnolrZE=
Received: from CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19)
 by BL1PR12MB5993.namprd12.prod.outlook.com (2603:10b6:208:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 08:56:51 +0000
Received: from CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::121c:6dbe:6c7b:fe5b]) by CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::121c:6dbe:6c7b:fe5b%7]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 08:56:51 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Min, Frank"
 <Frank.Min@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip force complete fences when ring is
 uninitialized
Thread-Topic: [PATCH] drm/amdgpu: skip force complete fences when ring is
 uninitialized
Thread-Index: AQHZk3sn5BT9wyLUnE+ZiVstzy+GNq90DiMAgAAEh6A=
Date: Wed, 31 May 2023 08:56:50 +0000
Message-ID: <CO6PR12MB5394ED4CE9FB995BD168304494489@CO6PR12MB5394.namprd12.prod.outlook.com>
References: <20230531044812.460358-1-bob.zhou@amd.com>
 <265df874-9732-fca8-f66f-efc28140f43f@amd.com>
In-Reply-To: <265df874-9732-fca8-f66f-efc28140f43f@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=851866d8-18fe-4472-8efb-b515a9af8d06;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-31T08:49:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5394:EE_|BL1PR12MB5993:EE_
x-ms-office365-filtering-correlation-id: afee1249-44b6-4071-251f-08db61b4f95d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wxtS0nqkK0nrolkmONTEZRV6Nqo+jMskJ6XUe4EGWkpP2HiBnJXJcl5qMxeb/KDcnLYW3K09WKqiJaJAcCXwVmGRAQt6U8jAmxT2lnDso/SRbLEXQHkRJ4XigGyQ0grv/WdJLY7SpZcaTlAFgg79ScEl4d8TCIMxC5AJrBLhURPTkxy+MWYxaz4waClRwMEVpfxygiGNAvmfeC33dZWT9WIdXesNEtAtkuK1Ej6WieYNwkvLJ93dg3l455uLFHOSDS9M4M9PCDkGMpGX2uJTnpNSvLHdT5dGprWKrlH3Tn6PgNOX7T5pX3x+5FazEbzpl+WEpiflYeOszs6ifUXR3Hx2u7omFDMHki0FURMlm4EIE7LR0wbT2juoEeIhChR40kpKwzv51kp4VWO6LLtSjpL8cwaO9Hn3RvZpoJi3RC/EmZs3JFAGDGKcw+6mHQoMWjBVIHe5K3pPJIz1eyiJ7YxFmn9Z4mDnSWPnL6ja0QlvewNFGYAyGDl0G7A5bIFMqQBmpAAoCZM2pFgcCHXnGyWKStTHFUxjGUxcJcrhXVarzAbp4jWZ+LaIFma2z/zMnTyv8z1f5e0FJqjhuDbjaSlj/6qJ+CGKhy1cGCNzSQPcBLiMyoZCSWZMgXxl69mR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5394.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(2906002)(186003)(53546011)(9686003)(6506007)(52536014)(5660300002)(478600001)(122000001)(8936002)(8676002)(110136005)(26005)(83380400001)(38100700002)(7696005)(86362001)(41300700001)(38070700005)(33656002)(71200400001)(316002)(76116006)(66946007)(66446008)(66556008)(66476007)(64756008)(6636002)(4326008)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2c1RS9pTDRVSzJWTHJCMmZ3aTBlaFVRRVZwUXlGbkxiV3Q3MjRTTTJGZmtl?=
 =?utf-8?B?RXdLa2VOV2VwV1JwTnRWWnpxUUlLTHlWVUw1NWQrb01uMmRuc0gzeTFxY25O?=
 =?utf-8?B?aGV6RHhwQjdGcGRRU3djdmgwbUNrUTlHNFF2eEFjbUV4VU5BU0NaQ0kxS2M0?=
 =?utf-8?B?eUNDSjliWGFXRk04U0RvcmlUWktVOWtERFJKdDFKOHRhb1dydDVaZTVXSnJO?=
 =?utf-8?B?SkV0REVkTVYzSjJTN3RpTDBhQmRKSVl3bFVOLyt1cGxBRzdHUE9ycGdNenli?=
 =?utf-8?B?NTExKy9IQUxOejh3R3JNc3dhRnlaQVlqV1dISEZNcW0xNW9xeWZLdHFIZzBR?=
 =?utf-8?B?ZzY4ckZPdnA3cktlN0xYbkV0UFZ1bFlISk9iNm5hb0hhMXc4a1M0QkxNVEpZ?=
 =?utf-8?B?Vnpmc3d5aVJiNDM3NysvTGxUSjUrQVFwOEM5aTM2RWgxMUhoaytXSWMyWEh6?=
 =?utf-8?B?amkxZVYvOGI2TzUrZTljR3RPWmpLdUpHdnpPdHJEd1EzR0JCb0hWeWwvNE5t?=
 =?utf-8?B?UlJkdTRxL1dmc2wvRmlFTEFnZ1p5WktiOWcyTGtPeHpYeTFRR3htejFCQmM5?=
 =?utf-8?B?anpnNm1KRWZpMm96VHpVOUlQVDJCcGZNdWwyK0FDRDZ1UFRaT0JQbEphNW5n?=
 =?utf-8?B?N1laS2hBdzlGQ1d2UmwvaWtmVm1ROGZZNDNRdTBpd0FPTFdzeVdOL2pPaWNO?=
 =?utf-8?B?Vk1HNkpxVjZtUEpEbUJxbFE1djNKOE8wbE9naWRkM0ora3UxNThsRlpaL3dI?=
 =?utf-8?B?YW1wQTQreUZxK01YNjkyeDFFdnI4YjlpMVBIQnlBRis4bEZodnZINDBKb2c0?=
 =?utf-8?B?VHAwWjBndXplZVNZSHdHVWIvcGg2SGM3YkZlWTRUQU9ZRS8vdFBLa1RMdE9V?=
 =?utf-8?B?MlZSZGJPbUNua2VjUC9YWk1FemFVb2hwYkFIUkhEaVVoU1VPRWFvL2tSK0hi?=
 =?utf-8?B?dWRRL2ZCaTBnejJLN3hNc0pvMXVCMmNNcElhS3B4Ymx0WXlEc0xiUUFGdjBv?=
 =?utf-8?B?OGV3Tzc2ZnhjVDBxenhlUDZmaStnSU9QUFNRRTlMYkU5d1pxbHBWSmVoWkdq?=
 =?utf-8?B?Rnpva3lxRkZqb1g3TjR2RHpMQW9ZdWFNUTdHdWRxTnJ0bnVldEllanhRSFB0?=
 =?utf-8?B?cUM3RHdIaXI1NGEvd0NpcEd0S1J5dDZtZ01vb0RsL3VPVGZzQWdmTzFWbUJy?=
 =?utf-8?B?WktJdklXbktwdHovb0U0NTQrS291YW0yQmpqeThSNStYWVZWV01lYmdPUFZP?=
 =?utf-8?B?TkxKMVVQY3NqVUNEcE5XWFFHTlI1eFpKV1RkcFZyaEQrZVBNZ0M2amFCbkw1?=
 =?utf-8?B?WG1kZmxOZy80RmNGMjBhRHBiRC80UFJSbnFPeS9LM0NRaS9FY0o4RFl2c2dJ?=
 =?utf-8?B?NnV1MWJIU0JSQTJtbUdHbUZpcDNmQlZoSTBHdmt5VVpsU2xyaG5DRjJvSXNC?=
 =?utf-8?B?cmV6T1llM3JlWWIrQlFXZEpJQmNKSFRNYlNMekFITlFOL2hjeVkyOWRCS3hQ?=
 =?utf-8?B?U1Q3RjNrYm1tY29iSzgvYWMxcThqYUZtOHY0MGZiVmp4a3F5V3QyOEo3NDlr?=
 =?utf-8?B?aExHeis4aElJZHNySDlKUmhGbm9TbDlvV050YTA5bkFUNURtbFNTMWQ2d2dP?=
 =?utf-8?B?UnZsOHp2OGRDUGVxZiswKzgwRWFrYUJ6a2ZGYllFZjhjaVUrS2IxTGJISzVm?=
 =?utf-8?B?dTk2Z0FBME96NG9pY1Z1NDFFcTZYQ1FnM2pSSXM4M1ZCZ2JOd0MxSGtrb004?=
 =?utf-8?B?SHJvSXlISjB6aXQwK2IvN1J3MFpMTStKNHhQYnJqam5YUnV3K29lVmQ3dWd0?=
 =?utf-8?B?MWRqbUN1MStXZThYd0VaaHBzTE53TGpLSUl0Rzhma3NENEtlRXFKemJxMWkx?=
 =?utf-8?B?RVBLemdld3dZZ2VPVDliemRMaWVqM0QzS1VTY21oSkNsd1Nlckd4bCs1V0d5?=
 =?utf-8?B?eTBuSTBRZWFoaGs1TGtuRTBpeGxoNGhwY3R6eGJsNUtNMmlkeldWTDJCaHRY?=
 =?utf-8?B?ZUhSUVp1M0l4b05DR2NOQ25tUTF0d3lwNjVzKzh3NEVTNVQ1UHZIVldkR3l6?=
 =?utf-8?B?S1BuaUZhZ1QvY2UzZ0h4dVJCL3UrODZYZ0ZaWWdOUHZpWTZPeTJxTU5EYjA0?=
 =?utf-8?Q?fOUc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5394.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afee1249-44b6-4071-251f-08db61b4f95d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 08:56:50.8561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JrXzhRB8RUX7udenmC3GX9jjmL2mVuVohaDronGR4IXpAP0/TktFx+OhQMi5AJGZ4+OlqBaaW6cqPJzqHyItag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIENocmlzdGlhbiwNCg0KVGhh
bmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uICBJIHdpbGwgYXBwbHkgaXQgYW5kIHNlbmQgb3V0IHRo
ZSB2MiBwYXRjaCBmb3IgcmV2aWV3Lg0KDQpSZWdhcmRzLA0KQm9iDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KU2VudDogV2VkbmVzZGF5LCBNYXkgMzEsIDIwMjMgNDozMyBQTQ0KVG86IFpob3Us
IEJvYiA8Qm9iLlpob3VAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBN
aW4sIEZyYW5rIDxGcmFuay5NaW5AYW1kLmNvbT4NCkNjOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5D
aGVuQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBza2lwIGZvcmNl
IGNvbXBsZXRlIGZlbmNlcyB3aGVuIHJpbmcgaXMgdW5pbml0aWFsaXplZA0KDQoNCg0KQW0gMzEu
MDUuMjMgdW0gMDY6NDggc2NocmllYiBCb2IgWmhvdToNCj4gdXZkIHJpbmcgaW4gdXZkX3Y3XzBf
c3dfaW5pdCBvbmx5IGluaXRpYWxpemVzIHJpbmcgaW4gYmFyZSBtZXRhbCBjYXNlLA0KPiBzbyB3
aGVuIGV4ZWN1dGluZyBhbWRncHVfdXZkX3Jlc3VtZSB0byByZXN0b3JlIGZlbmNlIHNlcSBpbiBT
UklPViwgYQ0KPiBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2Ugd2lsbCBvY2N1ci4gVGhpcyBwYXRj
aCBjb3JyZWN0IHRoaXMuDQoNCkFoISBJIHdhcyBhbHJlYWR5IHdvbmRlcmluZyBob3cgdGhpcyBi
dWcgcmVwb3J0cyBjYW1lIHRvIGJlLg0KDQpJbiB0aGlzIGNhc2UgcGxlYXNlIGZpeCB0aGUgVVZE
IGNvZGUgdG8gbm90IGNhbGwNCmFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbigp
IGluIHRoZSBmaXJzdCBwbGFjZSBpbnN0ZWFkIG9mIGhhY2tpbmcgYXJvdW5kIHRoYXQgaW4gdGhl
IGZlbmNlIGNvZGUuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gRml4ZXM6IDA0M2Yy
MjcxZTJkMGEgKCJkcm0vYW1kZ3B1OiBtYXJrIGZvcmNlIGNvbXBsZXRlZCBmZW5jZXMgd2l0aA0K
PiAtRUNBTkNFTEVEIikNCj4NCj4gQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNl
LCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDAwDQo+IE9vcHM6IDAwMDAgWyMxXSBQUkVFTVBUIFNN
UCBQVEkNCj4gUklQOiAwMDEwOmFtZGdwdV9mZW5jZV9kcml2ZXJfc2V0X2Vycm9yKzB4M2YvMHhj
MCBbYW1kZ3B1XSBDYWxsIFRyYWNlOg0KPiAgIDxUQVNLPg0KPiAgIGFtZGdwdV9mZW5jZV9kcml2
ZXJfZm9yY2VfY29tcGxldGlvbisweDE4LzB4NTAgW2FtZGdwdV0NCj4gICBhbWRncHVfdXZkX3Jl
c3VtZSsweDFiMi8weDM4MCBbYW1kZ3B1XQ0KPiAgID8gYW1kZ3B1X3JpbmdfaW5pdCsweDczYy8w
eDgyMCBbYW1kZ3B1XQ0KPiAgIHV2ZF92N18wX3N3X2luaXQrMHgzNTgvMHg0NTAgW2FtZGdwdV0N
Cj4gICBhbWRncHVfZGV2aWNlX2luaXQuY29sZCsweDE5OGMvMHgxZmRmIFthbWRncHVdDQo+ICAg
PyBwY2lfYnVzX3JlYWRfY29uZmlnX2J5dGUrMHg0MC8weDgwDQo+ICAgPyBwY2lfcmVhZF9jb25m
aWdfYnl0ZSsweDI3LzB4NTANCj4gICBhbWRncHVfZHJpdmVyX2xvYWRfa21zKzB4MWEvMHgxNjAg
W2FtZGdwdV0NCj4gICBhbWRncHVfcGNpX3Byb2JlKzB4MTg2LzB4M2MwIFthbWRncHVdDQo+DQo+
IFNpZ25lZC1vZmYtYnk6IEJvYiBaaG91IDxib2IuemhvdUBhbWQuY29tPg0KPiAtLS0NCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyB8IDIgKysNCj4gICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9mZW5jZS5jDQo+IGluZGV4IGM2OTRiNDFmNjQ2MS4uZDJjNTQ4NDMwOWE2
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2Uu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KPiBA
QCAtNzIzLDYgKzcyMyw4IEBAIHZvaWQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9zZXRfZXJyb3Ioc3Ry
dWN0IGFtZGdwdV9yaW5nICpyaW5nLCBpbnQgZXJyb3IpDQo+ICAgICovDQo+ICAgdm9pZCBhbWRn
cHVfZmVuY2VfZHJpdmVyX2ZvcmNlX2NvbXBsZXRpb24oc3RydWN0IGFtZGdwdV9yaW5nICpyaW5n
KQ0KPiAgIHsNCj4gKyAgICAgaWYgKHJpbmctPmZlbmNlX2Rydi5pcnFfc3JjKQ0KPiArICAgICAg
ICAgICAgIHJldHVybjsNCj4gICAgICAgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9zZXRfZXJyb3Iocmlu
ZywgLUVDQU5DRUxFRCk7DQo+ICAgICAgIGFtZGdwdV9mZW5jZV93cml0ZShyaW5nLCByaW5nLT5m
ZW5jZV9kcnYuc3luY19zZXEpOw0KPiAgICAgICBhbWRncHVfZmVuY2VfcHJvY2VzcyhyaW5nKTsN
Cg0K
