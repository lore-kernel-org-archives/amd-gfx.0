Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFE9C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 05:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58F310E6B0;
	Thu, 30 Nov 2023 05:14:39 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1B9A10E6B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 05:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MF99oGbcAx14mq13VRpDmCx6yrteetJNNbRl7TJVtSp8xrL2MrlMavlVIeAPm+eVEM7annzHF+gdQCkXK0qM1Yk9tU/C78FM2TVd+s9eU0l2INwQJKN/QOznJvvKFcxI8hKnouxLKTORbouRfGY4MOaBMwekjpYEQzZ10BjR5bG3ZogPHZ2RvQmYoPnWCL9N13MtWeU+OZVI1b8mKgS0JQPBIwlEip+4h7s/pdVmYyplQNOqG7TGc8yHzQjqaToNXiwHnxvdHl7fK4Qczr+GYJOyktdgnyhGkB4t0Qr9/gFC5YcjpaQRMJUObVGHoLdTffhdP/2yzVBhiLDNLcSbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqpHT6ADOJo84oWZoWOHNSVMZ8W4AQlF1p8nPHdSJw8=;
 b=TyhzWlI1IiKuplmmivqYJitwL4yZ1CPpvP2Eppf3fNkr+TP/MDi5/NP/x9OJLcNx1neJvdTX5kLCux+NERR9GJqgyh+P2yyYOmtgc/AkDV1ZxlFjTOkbfy84+r1/VEDO1tqRzb/oSvTa6Y5fcJm5yn6o5y6GsPbOhixLd0EZ6AHFZmarCtpgZzZYldLW1P2faFAKuiwX/4fguVNX4ORsP3S+zBZUnkibEgaXwDEOcjvyBHOIq6UOhRt0LZH0N9FsIIQuuq+vFxXLFg3fqTsEmLQsw/zrb37wcOfkMHIqlM9Z4twU+e/NxUtosNZ765x+XencmZ8CgdytNBLYIfnvLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqpHT6ADOJo84oWZoWOHNSVMZ8W4AQlF1p8nPHdSJw8=;
 b=ktiTRw1jDsRK6j1mQjYwsUnoK2AhXPvL/JyxWjVR5CnmQ84qynl5Me7jQ6XwwCZjImdxuiMa7GEzn58azQ48BMzXFQkaErQLtS4JsFBATH85ZYDwL6RuMgFjOYLoOtDR1XaPQjIMkerNvknXt0oDzn4o+SX3pdE0lOzryXlvDp4=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MW4PR12MB6708.namprd12.prod.outlook.com (2603:10b6:303:1ed::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 05:14:34 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 05:14:34 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix miss to create mca debugfs node issue
Thread-Topic: [PATCH] drm/amdgpu: fix miss to create mca debugfs node issue
Thread-Index: AQHaI0tpFa95NFJ4oku4AzzQMMr/6bCSURaAgAAAVoA=
Date: Thu, 30 Nov 2023 05:14:34 +0000
Message-ID: <PH7PR12MB5997E358BED98DF184755EA48282A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231130050919.1283614-1-kevinyang.wang@amd.com>
 <48f4d0e7-a15d-4062-a363-43c54fcd9551@amd.com>
In-Reply-To: <48f4d0e7-a15d-4062-a363-43c54fcd9551@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ec314584-51f8-462c-ab17-bd520801f359;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-30T05:13:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MW4PR12MB6708:EE_
x-ms-office365-filtering-correlation-id: ab0a889e-37a6-49c8-74f0-08dbf1633dee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MCOdAoLQbl3mncm4XfJXPbdeGmO+jZq6zpfOwYiqcwBT9KCbxrqJl0GZxFgrA2vdsc0nURJ+6SiqcF3WG4Gsrs08zWRdo3kL3rS3kTOli/7siEGVTUFJ87u1/wxIRTKILMTa7Qdqborf/6v8bF8+IdeJhf+5nGGb9ti7s4eZmGm1OhnfTgRZ0l+Gb46uahyScioGhVn3tI5AVfC7nFooHWA4Ld2Q0d6B+43SNySnZy2heSlfD8OQQiEZjulczMOIS7KuQiedDee9WtBdmq5cp8gWSzMZ2oP5kzFHEf6V6ar5iAGuyP6Yb4KdZ/lPi+nFhGmD8QVCFtE2jaKW7Zsd2lTEd34t8DKy7ted4/8AizzCQG/RJxmYrK1OCt2ilXuxUnbSd+Xi7Oc8h+7XVdUqC3xcU0BKKKFSxzn5xtgH017J5bCrF++dClReTewvjflPM8ASZH6Qa8r1AcRFieDAbh4G/4ghAtvXe7gi7qDGdjKJf+ElI1G6Rv3nIC0Le+42TmdgJL2T4+GHExgPB4BKkcDdd02IvaMT1j2YE4vlNw8b7FjX1dFnlbr9HVx5anzXfcJ5FasWuvMMC0mVjtaEavIybBNLELVFLBswt2A9yTFXCk9c3Uo+rht6eRi/jWYm+eKXNU3ndNhqfwfLrM3l1MsR6P57ymAWubvNnm/ZeOQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(55016003)(122000001)(38100700002)(202311291699003)(83380400001)(5660300002)(110136005)(2906002)(86362001)(4326008)(8676002)(8936002)(52536014)(7696005)(66446008)(66476007)(66556008)(316002)(64756008)(66946007)(478600001)(71200400001)(9686003)(6506007)(41300700001)(33656002)(76116006)(53546011)(26005)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXpwdGtjdyt3ODFKZXRhYzJkc2ZBcVVSZWVmUW13VjUwN014eWUrTlNQcmNp?=
 =?utf-8?B?ZzllemI3NU5SNlZ2U0kvRldQcU5SQ1JIK0FLUldDTmVkVWRCQzlzcVZaTUEy?=
 =?utf-8?B?QTMwZ3o2QnA5V2VDTEsrOVZZc0pPSHZ0U29mZzJ2cjdvaU0zbTdnU2ZmZ3Z1?=
 =?utf-8?B?dUJKMkpXQjR0WUNxZ3RzNW5YRzU5YkkyNnFFak56TitiZys5YTJjVEk1b1J5?=
 =?utf-8?B?U2JiK0FCQm5xaStNeTJZeGRCUDZodGttNlljdVpLeG45YkNhRWhjMXFJN2JR?=
 =?utf-8?B?ckF2ek9lV1BHcXBxanB1aVJWci82dng5cXFiSGV6L2l4UURCd0xjSmt5OUg4?=
 =?utf-8?B?RUJoMldZOWV3RllTOGFUbFVVQ0tQd2JTWEJySzByYWdFMEx5K0NVOVozeUJM?=
 =?utf-8?B?bWFiT2dwTmkzbitYbFk5SjUrNnNVeldXOU04MUJObTBZaHNrN2Zad3NYY2NR?=
 =?utf-8?B?UkxZeXkwbjhBb2lZL05POWg4Nk11N2FvKzZGclZoRUNTRlNLTWQ2SGpoZ1RM?=
 =?utf-8?B?N3lERXZGTVdQNHNINitGTVFrZFBkWjhUT1d3MVFEcjN5cXdWNVRuZC96WWJ6?=
 =?utf-8?B?Q0MrVldWd0ZOVUdTOFFRb1BLM2oySTVxQ3ZyMFFBeDlWTVZNUno1Zks0dXpn?=
 =?utf-8?B?L2tlc1JMaUkvTFBoUWhRdjdCM2FUU3pRNHRma3dnT2lQQXZJS0l6UFFjbElG?=
 =?utf-8?B?ck5BVnIxcXJBSG9LbTh0WEVGcDlvNUxoWmVsOTRaakpJc2hJNDBsU1VjVURX?=
 =?utf-8?B?RTZFMTEvL0lnakZrNjkxYUN6MUp5VkcvTU9KajJFVU5HckFqQnI2K0h3U1Iz?=
 =?utf-8?B?K3ljb1FGVmpnS3FpbkV0MUZveDdKdzZmMkl0UkZHY0lnT0c1MmpiK3dwVUNp?=
 =?utf-8?B?Ris5QVFqbFR3TG5vVlhBUDl4b2hMbHBQT3YySzVuSWNaN2xSTzJuRlB5MGR4?=
 =?utf-8?B?QldhVUQ0VmZzNVl1WExtU081aDUyTVBqb3JwSElvZHE4TUR2RWx0TVJyeHFp?=
 =?utf-8?B?NHFPRU1CSm5oYzd1THczWWFINEtLdGxJTWt0dHYwQ0dHQjg3UDhhck96OHFt?=
 =?utf-8?B?UE8rV3lOUXRrMWZMYmxwbzR4RTk0TmV2L0Ryei9ERVluOUtwYUtWUkd5MTht?=
 =?utf-8?B?QWpJc2QyVmRWZ1FNWnp5NkM4ZVVxUTFoVi9OcG5jNkVWTHFtS0oyTlEyeUJN?=
 =?utf-8?B?aEVRcmFrbGNTd2p4UFNXUGVla2krWUVTZXN4WDBoL1VGanZQdHRkb0JCTzFr?=
 =?utf-8?B?VWFhUEhqVVlSL21LNnh2VW1VWUF6RCt1SU5GdW9XeDBCOXdiSFg4alNxbkhS?=
 =?utf-8?B?Z09Ec2MrZUJZankyNEEyV1hIT2k4VzhjSUphSTRzbUJFTkhOMzdjUEdsdzBV?=
 =?utf-8?B?ak8wRzJPZitjNmwwVU9WQVduVDczd0xKenRpa25COC83V3V1YVNmZmlENElF?=
 =?utf-8?B?QlpDY0xYcC9kK2t4Z2N3VVdwVEd1a1FCVEUycFVZcDNxUzZoT3VVWE05NmFJ?=
 =?utf-8?B?UWppNW1NSGNHclB3VGV1aGV3dExtSmF4RHN2Z1IvaEtiaVBrcHVGd05kYkND?=
 =?utf-8?B?am9xeEtDclNRTkNzaGFwTkRZczZCYkpLWE52UjJwNGNORmRNNVM4U1pEU0JH?=
 =?utf-8?B?cTM3WVhvOXAzR0JNUHJWd2V4OHo4N2F4TVU2Mnp0MTU0MGJPUmJTTUI3Z3Mr?=
 =?utf-8?B?VVFWM2Z2WmY2QzhNdWUwdzhLZWxoUmRtaml3NTdkUXZ4Uk9UWTZ4bUFlSDF5?=
 =?utf-8?B?OXRISXJ4SXpsNUV4K1VmQUt1cENwVlJFRWd4aEcweFVsWUNlRnk1eDFQWGhO?=
 =?utf-8?B?c0ZJSmhQTG80Q2VlanlSbE8xaG1NU2V0bEwxbWhuVVZQVW05bFhWeWs0L1lo?=
 =?utf-8?B?aU11cUNGdG9ERDIrRXpKK3ZLTEJLNTljQUxrUmd6WlZ4c2dkMEJvSzBPclBz?=
 =?utf-8?B?YlZKNEFrM2MrM1V2QkJMcmcxQVZsVkVpTy9WWTNZUFFCOG0vMkRuSDNLUWdO?=
 =?utf-8?B?S2JwK1AxQUJnMWh6VUMwNzJvY1I4WmRSNElVN0RGak1NeGxFaXgzMmsxL2Ru?=
 =?utf-8?B?bllLZlZUTjN4ZFhEYjhKRlM2a3k0cFNBRUhWU1dQWE5YVXlxL3RIOFdENHpG?=
 =?utf-8?Q?ADHU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0a889e-37a6-49c8-74f0-08dbf1633dee
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 05:14:34.5663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: viQ7p3HV3OkR9Gx5NeptlUbubM7ftZnA88ba/gFs5xMkP2jzBHZBgmwhAS5ewaEJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6708
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KU2VudDogVGh1
cnNkYXksIE5vdmVtYmVyIDMwLCAyMDIzIDE6MTMgUE0NClRvOiBXYW5nLCBZYW5nKEtldmluKSA8
S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpD
YzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRncHU6IGZpeCBtaXNzIHRvIGNyZWF0ZSBtY2EgZGVidWdmcyBub2RlIGlz
c3VlDQoNCg0KDQpPbiAxMS8zMC8yMDIzIDEwOjM5IEFNLCBZYW5nIFdhbmcgd3JvdGU6DQo+IFVz
ZSBhbWRncHVfaXBfdmVyc2lvbigpIGhlbHBlciBmdW5jdGlvbiB0byBjaGVjayBpcCB2ZXJzaW9u
Lg0KPg0KPiBUaGUgaXAgdmVyaXNvbiBjb250YWlucyBvdGhlciBpbmZvcm1hdGlvbiwgdXNlIHRo
ZSBoZWxwZXIgZnVuY3Rpb24gdG8NCj4gYXZvaWQgcmVhZGluZyB3cm9uZyB2YWx1ZS4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPg0KDQpNYXkg
cmVmaW5lIHRoZSBzdWJqZWN0IHRvICJGaXggbWlzc2luZyBtY2EgZGVidWdmcyBub2RlIg0KDQog
ICAgICAgIFJldmlld2VkLWJ5OiBMaWpvIExhemFyIDxsaWpvLmxhemFyQGFtZC5jb20+DQpba2V2
aW5dOg0KVGhhbmtzLCB3aWxsIGNoYW5nZSBpdCBiZWZvcmUgc3VibWl0dGluZy4NCg0KQmVzdCBS
ZWdhcmRzLA0KS2V2aW4NCg0KVGhhbmtzLA0KTGlqbw0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tY2EuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tY2EuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9tY2EuYw0KPiBpbmRleCA1NGYyZjM0NjU3OWUuLjIxMGFlYTU5MGE1MiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21jYS5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tY2EuYw0KPiBAQCAtNDg1
LDcgKzQ4NSw3IEBAIERFRklORV9ERUJVR0ZTX0FUVFJJQlVURShtY2FfZGVidWdfbW9kZV9mb3Bz
LCBOVUxMLCBhbWRncHVfbWNhX3NtdV9kZWJ1Z19tb2RlX3NlDQo+ICAgdm9pZCBhbWRncHVfbWNh
X3NtdV9kZWJ1Z2ZzX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBkZW50
cnkgKnJvb3QpDQo+ICAgew0KPiAgICNpZiBkZWZpbmVkKENPTkZJR19ERUJVR19GUykNCj4gLSAg
ICAgaWYgKCFyb290IHx8IGFkZXYtPmlwX3ZlcnNpb25zW01QMV9IV0lQXVswXSAhPSBJUF9WRVJT
SU9OKDEzLCAwLCA2KSkNCj4gKyAgICAgaWYgKCFyb290IHx8IGFtZGdwdV9pcF92ZXJzaW9uKGFk
ZXYsIE1QMV9IV0lQLCAwKSAhPSBJUF9WRVJTSU9OKDEzLA0KPiArMCwgNikpDQo+ICAgICAgICAg
ICAgICAgcmV0dXJuOw0KPg0KPiAgICAgICBkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJtY2FfZGVidWdf
bW9kZSIsIDAyMDAsIHJvb3QsIGFkZXYsDQo+ICZtY2FfZGVidWdfbW9kZV9mb3BzKTsNCg==
