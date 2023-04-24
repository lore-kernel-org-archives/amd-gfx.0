Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9747C7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 14:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F4B10E515;
	Mon, 24 Apr 2023 14:06:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4486310E515
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 14:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX4Tvt4YJxDSLhQQUPIZACwDJFqY2jFazTgyZffJMvszxzOhd/dIvsvBv9uTwyoRadsoWLph5cy5v0pxKPoF1KrParDYSm0kVrB5ujt8qlmIj2TV/KO83N1bpcdf1UFhT9pwjwBly/UPQ6UkLzaeC1MgRsdcQMFyVDmF1G9AjFbw4CEAkmZwFWz39GYhpnUh+dV9mlSXAuVn9XL2exuUew7rktEu9mc4f2Tl3bcdymBJljIlfmne98uhKVC8KvxRtPpyWeZb26iMoKScUSLV/MzuzLhPAOzx+mdBLxCXoW7o1GdSuhQFBXz93/uNb51d8Clc0C6+2nfj28tZC/Yi5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ry6JOF5SLXBiol7xmenmJFbkJbgfzok5lp4bF3aU7y4=;
 b=OM/IYgNYxbrU4F7URltWDMnQZGn+Bt0HAsHvOChY761LRyGYuGHc6lbL9fCi19MFcGfA5wcy6NVn2imS1uq3xks3NroY5PtoH3dMaU8H5VXCyZWW6d1k4usHbfIHXzEDxinsb3fqvFc5/xXOxhObxYvAuCZcMwmD04AUAmGseUjKdWrwWhs/4X9UjzWjcaJ0SyD8wlofBYbuXapbMS89LIX11Njbo8wC/c4CkifB/jsxDP23OHVc/oUczJrLXknDIPs5MBiBaBauzf/J1aStyyXy/eeO9WizXhnsQt4t76HjGq3YG6vJNFE/11KyGV37wbMT4bblPmYevsafADjGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry6JOF5SLXBiol7xmenmJFbkJbgfzok5lp4bF3aU7y4=;
 b=EcIMAu1v+T/05g2CL61VifcXGogCS0yRGui9vrT7Jsy79h/3vw7QxFQRa/zgz7oK0ZlGaETMFJnlSk6OmKrTnSqUkPZcDkHAiH1l+0DOiSSpo+ie/kh+972uyHrj4J/287UEHlV4YBwxKpPM18RCaTnTMdnG72wd3drop6979Yg=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 14:06:16 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::5cad:78df:6b83:6127]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::5cad:78df:6b83:6127%7]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 14:06:16 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Enable doorbell selfring if resize BAR
 successfully
Thread-Topic: [PATCH] drm/amdgpu: Enable doorbell selfring if resize BAR
 successfully
Thread-Index: AQHZccK2PHIdMCo/skGPhrTuoVhwe686NNYAgAAKOyCAAD2f4A==
Date: Mon, 24 Apr 2023 14:06:16 +0000
Message-ID: <DM4PR12MB52615C85D3EA998E157686AD9D679@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20230418065443.878721-1-shane.xiao@amd.com>
 <9885713a-b424-dddc-f891-ed7d622c5b91@gmail.com>
 <DM4PR12MB5261E710B9A6F7BA6BF52F009D679@DM4PR12MB5261.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5261E710B9A6F7BA6BF52F009D679@DM4PR12MB5261.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-24T14:06:11Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=021fc304-1e6e-4e38-ad60-5a9fc54c9446;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-24T14:06:11Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: a62cb4dc-d7e6-4177-b3a9-1b2fe2e29014
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|SJ0PR12MB6783:EE_
x-ms-office365-filtering-correlation-id: 818fc90d-2bf0-4454-08c7-08db44cd1209
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: omhxvmTvbhYEoQQSfAAGKyhpZoxqcJpmH4KhGfWkLKyT3kLrDn0ZTtn5NwwRllli0fbOtc2yKxVBzdNVDqdkx4/N+JIJfzTpPy+Y4mqiS+5t5LzuX0akvAOMxAzli8gRk2Y/Y4n1j9jbVR+v7jDH+JrjO2daSQNcLqF1g1MdZEuIuhWgmyF13a7xVBc3gZaD/+1Vk+ATYtnEOUogUevkzpJWfJYo36iwaD8OQEeyuZdcHTTlFZoY3klKSrNeRKEPPufqtf9rhNWKFPdJ4YRZ2fEi5JMTvla4z6F7bDkuk26vdt8uJ4DpacxR+1oD17JUVXe17Hd13Td1E9noErp9bbUHBbXUe5qyd9T07dM1pYsllsN6/SJfA5Zjbi+X6eUzG9++a3Oe768eXOf086A5eH+3avfFbckLVEQnIPfSmDo+V+5nOG2a2dAbo71vdGJp/LyFeMOw8IH8nIyzVjCcXArU+PQx8263iWggfa2kv1KVp1y+7dA8Gp66C6gG8P1DNj+NTVIwSr5bwJEF7a8Y55i66GhdZGUBREFyrQa5WAQbg25as9KossO5UFXDJZVA6pReMQTFg1PrNcHq2wilzCWwizfUoNq316eVDMfwFRr1Vdsy+ljKnSbx4nMDMbwL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(9686003)(53546011)(6506007)(26005)(38070700005)(55016003)(83380400001)(2940100002)(186003)(921005)(38100700002)(122000001)(66946007)(478600001)(76116006)(86362001)(64756008)(66556008)(66476007)(66446008)(8936002)(8676002)(6636002)(54906003)(110136005)(52536014)(5660300002)(71200400001)(7696005)(41300700001)(2906002)(4326008)(33656002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFVnWGVLbno0NXNKOEdxVmh4dVo2cTArVWlZWW5EZnNVTlJKRXNzQWZZYUZJ?=
 =?utf-8?B?VFI5V2h6Z21XWkZUd1oxTzNBU1dIdGhYNlZKWlRSY00vNmQ4TUZrT3U2aExx?=
 =?utf-8?B?dEljYmhuNTAzQzZIcVp4OE50QkxGZTVmN1hCeGxLUGYzbWdiem5QWWtpcHAz?=
 =?utf-8?B?RXlucHpjTDlwZGtRdTlwbm9OTlVmelRYOEdhN2JjZEk1OHNNdDJMMVRmcFhD?=
 =?utf-8?B?dUNiMHYybUY2aEdXRnIyYkRKaEVwUnFoc2Fhc2pvSGNZZ2RwdzRRWGcxNDZT?=
 =?utf-8?B?MUNmU0FJZW5ZaTlrbk1RWjRBSnpqR2VZdXB2d3BIQisrOGorY2RsUmtBRWNr?=
 =?utf-8?B?RkxmbzVzNS9sTzdWTTZDUnlhRytQODJxYm4zaHlTaVlnRHlEOFJKL1p4QTBw?=
 =?utf-8?B?cGp2TlUzQTMzcmVrM200eGxlNjZrS2hROGdpUEwrVFhxM3JodFJZOFgvam9z?=
 =?utf-8?B?NWpTa1J4Wnp6VzZiV3ZWNXJCUVJlYXhtZVB6V0ZKRGs4ZVowN1Q0OVMxUDZt?=
 =?utf-8?B?N1dqandCRWFWdHdSVmlNdy9mQnVua2FDSWVFUlB0Z2tRejNva3d0dVFyUk5k?=
 =?utf-8?B?OFVkVmZFVm1yQUJheXZTY2ZTSHhBT3hYcStwdC9ObFl5MS9aQ0U5bDQ3c01J?=
 =?utf-8?B?YzJMdGRjSWZNaEFNTGVRR2dwclgrSGFoemxwd3FXMFg4NzB3czkxM0F3b2Q5?=
 =?utf-8?B?MFk0N1lJc0ttRmV3bVFmVjhWdGt3NnY3WUo5NUxsaTg4T1RyZzBXVmpoOVBW?=
 =?utf-8?B?SGdtZFhYMVovUGF2ZFYyMHdwV0FTMnFJcjVnNTFtNDBWOCthSTJMTmhUUjRy?=
 =?utf-8?B?bUtpM3V0L0tUa21neVd5OVJYYVZQQThGbUR0WWRIREdib09jZU9BYUJ6d2hX?=
 =?utf-8?B?SmhZM3JKNE9Za1VuVTVQMENVUHFoV0dWNmJabTQ4TkxGa2gxdTAwaDRpb2tN?=
 =?utf-8?B?eTZ0d08rYzVVYzR4SnJ5SjFrZWRFNXg1SVA3Y1AxeEQ0Wk9wZ3BHeXNKeklo?=
 =?utf-8?B?T1dndzNCVWNTcG05bWdRVkkzVmRyVmJNZFFlU3JhZDNlcXJhVGxMaFBsNE54?=
 =?utf-8?B?MElGdm1HL08wbEZMMWJhdkVhelIxc3JEQlozTU9FN0NsMk0za25NZUUxcGhN?=
 =?utf-8?B?cWl6a05yOHZYZ0NNeXQ1WlNQVGJWSDV4MzVmdWJHci81S252aCtWVHgwN1NP?=
 =?utf-8?B?elVodisxNXhkZnB5VzlJNTFlR0JPSm9aWW54YklMMlhPTTdmWFJONEV5NmFa?=
 =?utf-8?B?UEEwNmxLL2NuOFNHZ3BCM1pqQjFHM2ZXN3hLTkxZcHNwd2hDKzIzY1NtMnIy?=
 =?utf-8?B?OXNKbkdnRlJ0YXBkOHNGZ0FJcDNtTzg1aVJPUEt6VXBxcXVHT202NCtORmRq?=
 =?utf-8?B?NTg3WGx2WmtRWThaVnQwaFUvRG5QMzhvNGJlTUYrbFBkK2JtRlVQTmppUks5?=
 =?utf-8?B?dTZYMGo4S0QvcDhnUy9BcjRVNCt3TWtPdlNxWjVYWjNRYW5oeFJ6eWZzeWJ3?=
 =?utf-8?B?dlpGSmV4TVhSU25RRHZvMUlwUHR4RmV3TjZ0WG1yRVpsRWRPc0NuNTUxbVRR?=
 =?utf-8?B?dG9aQlhEK1hYTGdMQ3FiYWhlcUp4aVpxV1dXQUdkaXF2cTgyR0Z0eHF1UjJh?=
 =?utf-8?B?UlI5RFJnOTNLY2laNGdZSmpTbnVJT3BqZ1Zwd1QwWUtmR3NOM2F0OWZ6M2Vp?=
 =?utf-8?B?Si8rM3BLU1V1WVhDb20xdndaSXJVc3cxQ1hmNFJJUnpQSkZqSkdldW1HSWFr?=
 =?utf-8?B?dXZ5UU1SbUt4eUtMeXdaNXlSTzdUTFQ1U1RndTZMckdtcFhhMnZrckZCbEJP?=
 =?utf-8?B?VzBia2UzbWhGanJNVVJoTktXNFV4bXFiRWxIbmdGVGlpT1VmOUZZTldva0Vo?=
 =?utf-8?B?M0RaejJWVUcyTE9lYTBmazFiSytTaWhtQ3BaUWVKSnhLQ1NmOC9CcE5GWVpl?=
 =?utf-8?B?VUlyT3lxTFljaVdMUkZjelI0NGpla0VrcTgvVEVHRk9XV3AzZDNtdkdmWjh1?=
 =?utf-8?B?Kzc5bDBTaWNiMnlLa0ozb2tlc3lMT1lkVWl0RGFGenRmL2d3RU1jdGk0V0c1?=
 =?utf-8?B?L0trUXlPMFNiajNaa2RXVHVBa0p3eGlwY09BMjVUR0VJSi9lN0ZYRFdJNlVk?=
 =?utf-8?Q?nk1o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818fc90d-2bf0-4454-08c7-08db44cd1209
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 14:06:16.4333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6849PNh/+WitspXxjBYm1mrUo52QLf2XhldoPdSiNepux7wrqKFTBhz/otgwtd1yvMR1i9s9ajVU9jncj5Qq9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783
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
Cc: "Hou, Xiaomeng \(Matthew\)" <Xiaomeng.Hou@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFhpYW8sIFNoYW5lDQo+IFNlbnQ6IE1vbmRheSwgQXByaWwg
MjQsIDIwMjMgNjozMSBQTQ0KPiBUbzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6
dW1lcmtlbkBnbWFpbC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERl
dWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBI
YXdraW5nDQo+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXggPEZlbGl4
Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IENjOiBIb3UsIFhpYW9tZW5nIChNYXR0aGV3KSA8WGlhb21l
bmcuSG91QGFtZC5jb20+OyBMaXUsIEFhcm9uDQo+IDxBYXJvbi5MaXVAYW1kLmNvbT4NCj4gU3Vi
amVjdDogUkU6IFtQQVRDSF0gZHJtL2FtZGdwdTogRW5hYmxlIGRvb3JiZWxsIHNlbGZyaW5nIGlm
IHJlc2l6ZSBCQVINCj4gc3VjY2Vzc2Z1bGx5DQo+IA0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5
IC0gR2VuZXJhbF0NCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwu
Y29tPg0KPiA+IFNlbnQ6IE1vbmRheSwgQXByaWwgMjQsIDIwMjMgNTowNyBQTQ0KPiA+IFRvOiBY
aWFvLCBTaGFuZSA8c2hhbmUueGlhb0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7DQo+ID4gRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
PjsgWmhhbmcsIEhhd2tpbmcNCj4gPiA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgS3VlaGxpbmcs
IEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiA+IENjOiBIb3UsIFhpYW9tZW5nIChN
YXR0aGV3KSA8WGlhb21lbmcuSG91QGFtZC5jb20+OyBMaXUsIEFhcm9uDQo+ID4gPEFhcm9uLkxp
dUBhbWQuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IEVuYWJsZSBk
b29yYmVsbCBzZWxmcmluZyBpZiByZXNpemUNCj4gPiBCQVIgc3VjY2Vzc2Z1bGx5DQo+ID4NCj4g
PiBBbSAxOC4wNC4yMyB1bSAwODo1NCBzY2hyaWViIFNoYW5lIFhpYW86DQo+ID4gPiBbV2h5XQ0K
PiA+ID4gVGhlIHNlbGZyaW5nIGRvb3JiZWxsIGFwZXJ0dXJlIHdpbGwgY2hhbmdlIHdoZW4gd2Ug
cmVzaXplIEZCIEJBUg0KPiA+ID4gc3VjY2Vzc2Z1bGx5IGR1cmluZyBnbWMgc3cgaW5pdCwgd2Ug
c2hvdWxkIHJlb3JkZXIgdGhlIHNlcXVlbmNlIG9mDQo+ID4gPiBlbmFibGluZyBkb29yYmVsbCBz
ZWxmcmluZyBhcGVydHVyZS4NCj4gPg0KPiA+IFRoYXQncyBhIGdvb2QgY2F0Y2guDQo+ID4NCj4g
PiA+DQo+ID4gPiBbSG93XQ0KPiA+ID4gTW92ZSBlbmFibGVfZG9vcmJlbGxfc2VsZnJpbmdfYXBl
cnR1cmUgZnJvbSAqX2NvbW1vbl9od19pbml0IHRvDQo+ID4gPiAqX2NvbW1vbl9sYXRlX2luaXQu
DQo+ID4NCj4gPiBCdXQgdGhhdCBzb3VuZHMgbGlrZSBhIGJhZCBpZGVhLiBJbnN0ZWFkIHRoZSBm
dWxsIGNhbGwgdG8NCj4gPiBudl9lbmFibGVfZG9vcmJlbGxfYXBlcnR1cmUoKSBzaG91bGQgYmUg
bW92ZWQgYXJvdW5kLg0KPiANCj4gSGkgQ2hyaXN0aWFuLA0KPiANCj4gWWVzLCAgSSBnZXQgeW91
ciBpZGVhLiBCdXQgYXMgZmFyIGFzIEkgY2FuIHVuZGVyc3RhbmQgdGhhdCwgdGhlIGdmeCBodyBp
bml0IHdpbGwgdXNlDQo+IGRvb3JiZWxsLg0KPiBJZiBzbywgd2UgY2Fubm90IGVuYWJsZSBkb29y
YmVsbCBhZnRlciBnZnggaHcgaW5pdC4NCg0KV2UgaGF2ZSBjb21lIHVwIHdpdGggdHdvIHdheXMg
dG8gcmVzb2x2ZSB0aGUgaXNzdWUuDQoNCjEpIFNlcGFyYXRlIGVuYWJsZV9kb29yYmVsbF9hcGVy
dHVyZSBhbmQgZW5hYmxlX2Rvb3JiZWxsX3NlbGZyaW5nX2FwZXJ0dXJlLiBIb3dldmVyLCAgdGhl
IGVuYWJsZV9kb29yYmVsbF9zZWxmcmluZ19hcGVydHVyZQ0Kc2hvdWxkIGJlIG1vdmVkIGluICpf
Y29tbW9uX2lwX2Z1bmNzLT5sYXRlX2luaXQuDQoyKSBUaGUgZnVsbCBjYWxsIGNhbiBiZSBtb3Zl
ZCB0byBnbWMgaHcgaW5pdC4gIEJ1dCBpdCBzZWVtcyBzdHJhbmdlIHRvIG1vdmUgbmJpbyBjb25m
aWd1cmF0aW9uIGludG8gZ21jIGh3IGluaXQuDQoNCklmIG5laXRoZXIgb2YgdGhlIGFib3ZlIG1l
dGhvZHMgaXMgc3VpdGFibGUsIGNvdWxkIHlvdSBwbGVhc2UgZ2l2ZSB1cyBzb21lIGFkdmljZSBv
biB0aGlzIGlzc3VlPw0KDQpCZXN0IFJlZ2FyZHMsDQpTaGFuZQ0KDQo+IA0KPiBCZXN0IFJlZ2Fy
ZHMsDQo+IFNoYW5lDQo+IA0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBDaHJpc3RpYW4uDQo+ID4N
Cj4gPiA+DQo+ID4gPiBUaGlzIGZpeGVzIHRoZSBwb3RlbnRpYWwgaXNzdWUgdGhhdCBHUFUgcmlu
ZyBpdHMgb3duIGRvb3JiZWxsIHdoZW4NCj4gPiA+IHRoaXMgZGV2aWNlIGlzIGluIHRyYW5zbGF0
ZWQgbW9kZSB3aXRoIGlvbW11IGlzIG9uLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFNo
YW5lIFhpYW8gPHNoYW5lLnhpYW9AYW1kLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFhcm9u
IExpdSA8YWFyb24ubGl1QGFtZC5jb20+DQo+ID4gPiBUZXN0ZWQtYnk6IFhpYW9tZW5nIEhvdSA8
WGlhb21lbmcuSG91QGFtZC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvbnYuYyAgICB8IDQgKysrLQ0KPiA+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zb2MxNS5jIHwgNCArKystDQo+ID4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NvYzIxLmMgfCA0ICsrKy0NCj4gPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L252LmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvbnYuYyBpbmRleCA0NzQyMGI0MDM4NzEuLmY0Yzg1NjM0YTRjOA0KPiA+ID4gMTAwNjQ0DQo+
ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jDQo+ID4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jDQo+ID4gPiBAQCAtNTM1LDcgKzUzNSw4IEBA
IHN0YXRpYyB2b2lkIG52X2VuYWJsZV9kb29yYmVsbF9hcGVydHVyZShzdHJ1Y3QNCj4gPiBhbWRn
cHVfZGV2aWNlICphZGV2LA0KPiA+ID4gICAJCQkJCWJvb2wgZW5hYmxlKQ0KPiA+ID4gICB7DQo+
ID4gPiAgIAlhZGV2LT5uYmlvLmZ1bmNzLT5lbmFibGVfZG9vcmJlbGxfYXBlcnR1cmUoYWRldiwg
ZW5hYmxlKTsNCj4gPiA+IC0JYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rvb3JiZWxsX3NlbGZy
aW5nX2FwZXJ0dXJlKGFkZXYsIGVuYWJsZSk7DQo+ID4gPiArCWlmICghZW5hYmxlKQ0KPiA+ID4g
KwkJYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rvb3JiZWxsX3NlbGZyaW5nX2FwZXJ0dXJlKGFk
ZXYsDQo+ID4gZmFsc2UpOw0KPiA+ID4gICB9DQo+ID4gPg0KPiA+ID4gICBjb25zdCBzdHJ1Y3Qg
YW1kZ3B1X2lwX2Jsb2NrX3ZlcnNpb24gbnZfY29tbW9uX2lwX2Jsb2NrID0gQEANCj4gPiA+IC05
OTksNg0KPiA+ID4gKzEwMDAsNyBAQCBzdGF0aWMgaW50IG52X2NvbW1vbl9sYXRlX2luaXQodm9p
ZCAqaGFuZGxlKQ0KPiA+ID4gICAJCX0NCj4gPiA+ICAgCX0NCj4gPiA+DQo+ID4gPiArCWFkZXYt
Pm5iaW8uZnVuY3MtPmVuYWJsZV9kb29yYmVsbF9zZWxmcmluZ19hcGVydHVyZShhZGV2LCB0cnVl
KTsNCj4gPiA+ICAgCXJldHVybiAwOw0KPiA+ID4gICB9DQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4gPiA+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYw0KPiA+ID4gaW5kZXggYmM1ZGQ4MGYxMGMxLi4wMjAy
ZGU3OWEzODkgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
b2MxNS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jDQo+
ID4gPiBAQCAtNjIzLDcgKzYyMyw4IEBAIHN0YXRpYyB2b2lkDQo+ID4gPiBzb2MxNV9lbmFibGVf
ZG9vcmJlbGxfYXBlcnR1cmUoc3RydWN0DQo+ID4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiA+
ICAgCQkJCQkgICBib29sIGVuYWJsZSkNCj4gPiA+ICAgew0KPiA+ID4gICAJYWRldi0+bmJpby5m
dW5jcy0+ZW5hYmxlX2Rvb3JiZWxsX2FwZXJ0dXJlKGFkZXYsIGVuYWJsZSk7DQo+ID4gPiAtCWFk
ZXYtPm5iaW8uZnVuY3MtPmVuYWJsZV9kb29yYmVsbF9zZWxmcmluZ19hcGVydHVyZShhZGV2LCBl
bmFibGUpOw0KPiA+ID4gKwlpZiAoIWVuYWJsZSkNCj4gPiA+ICsJCWFkZXYtPm5iaW8uZnVuY3Mt
PmVuYWJsZV9kb29yYmVsbF9zZWxmcmluZ19hcGVydHVyZShhZGV2LA0KPiA+IGZhbHNlKTsNCj4g
PiA+ICAgfQ0KPiA+ID4NCj4gPiA+ICAgY29uc3Qgc3RydWN0IGFtZGdwdV9pcF9ibG9ja192ZXJz
aW9uIHZlZ2ExMF9jb21tb25faXBfYmxvY2sgPSBAQA0KPiA+ID4gLTExMjUsNiArMTEyNiw3IEBA
IHN0YXRpYyBpbnQgc29jMTVfY29tbW9uX2xhdGVfaW5pdCh2b2lkICpoYW5kbGUpDQo+ID4gPiAg
IAlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KPiA+ID4gICAJCXhncHVfYWlfbWFpbGJveF9n
ZXRfaXJxKGFkZXYpOw0KPiA+ID4NCj4gPiA+ICsJYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rv
b3JiZWxsX3NlbGZyaW5nX2FwZXJ0dXJlKGFkZXYsIHRydWUpOw0KPiA+ID4gICAJcmV0dXJuIDA7
DQo+ID4gPiAgIH0NCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc29jMjEuYw0KPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2My
MS5jDQo+ID4gPiBpbmRleCA1MTRiZmM3MDVkNWEuLmNkNDYxOTA4NWQ2NyAxMDA2NDQNCj4gPiA+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMNCj4gPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMNCj4gPiA+IEBAIC00NTQsNyArNDU0LDgg
QEAgc3RhdGljIHZvaWQNCj4gPiA+IHNvYzIxX2VuYWJsZV9kb29yYmVsbF9hcGVydHVyZShzdHJ1
Y3QNCj4gPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+ID4gICAJCQkJCWJvb2wgZW5hYmxlKQ0K
PiA+ID4gICB7DQo+ID4gPiAgIAlhZGV2LT5uYmlvLmZ1bmNzLT5lbmFibGVfZG9vcmJlbGxfYXBl
cnR1cmUoYWRldiwgZW5hYmxlKTsNCj4gPiA+IC0JYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rv
b3JiZWxsX3NlbGZyaW5nX2FwZXJ0dXJlKGFkZXYsIGVuYWJsZSk7DQo+ID4gPiArCWlmICghZW5h
YmxlKQ0KPiA+ID4gKwkJYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rvb3JiZWxsX3NlbGZyaW5n
X2FwZXJ0dXJlKGFkZXYsDQo+ID4gZmFsc2UpOw0KPiA+ID4gICB9DQo+ID4gPg0KPiA+ID4gICBj
b25zdCBzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrX3ZlcnNpb24gc29jMjFfY29tbW9uX2lwX2Jsb2Nr
ID0gQEANCj4gPiA+IC03NjQsNiArNzY1LDcgQEAgc3RhdGljIGludCBzb2MyMV9jb21tb25fbGF0
ZV9pbml0KHZvaWQgKmhhbmRsZSkNCj4gPiA+ICAgCQkJYW1kZ3B1X2lycV9nZXQoYWRldiwgJmFk
ZXYtDQo+ID4gPm5iaW8ucmFzX2Vycl9ldmVudF9hdGh1Yl9pcnEsIDApOw0KPiA+ID4gICAJfQ0K
PiA+ID4NCj4gPiA+ICsJYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rvb3JiZWxsX3NlbGZyaW5n
X2FwZXJ0dXJlKGFkZXYsIHRydWUpOw0KPiA+ID4gICAJcmV0dXJuIDA7DQo+ID4gPiAgIH0NCj4g
PiA+DQo=
