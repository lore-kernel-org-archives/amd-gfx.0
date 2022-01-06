Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EA8C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 02:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7166110E566;
	Thu,  6 Jan 2022 02:24:35 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A671310E55F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 02:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwA5GOXIn0Mb3XFsmTf1AaWX1I7A80+M8+fTLw84U8G+REtma4JFIj2ZieuWMiZGUoLVUuDRaaYcTQwK5cOQOZg6ZipUCuyTan6wPuKrJCDYPr42UjC58cTrscRTou1ckooYb4x5Iivwxwz5YBKsbiscpU2CKdHS9C4yzmQ5IGv7rs2c+o/cF8CdbkSgPVRx9fpKh60Xy0IFXjTh4IR7fwydKCMhXav/5vlOmIdi4ufPxcpFBX+VLIKt1tK9RWpDo9A9Yp9ZO2NOyBfnPbQknzN5mPM/1XkJ5VayubtJOPXF0LAak6atj3REbC9dBlsSIY1Zc9KaV7+7crzUa+0+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAGC7RBUlM3OTDoImiRRWgTQ4LRkjOWEZ8wCedtj8FY=;
 b=W1c7e/HMh/uoMTiDqDWTTogQPmAY78CgLcAvTRnJC6KzxQ840wxbj8qXoLDjr0YwX3mTiNjPeR0gjKaNW6IUXTFVoJVCBw7lU1hoMC4h7xbDRvSj1mdSmOlqzwe9KbK1c0b0nvBNs5VWgnLNdiBH7pzibH60NnxV7qIyk9jfbz7DFGsVEwL8tT4SZKiXjs+urDueH+2i65BEIHqYQjPeVL2R8Bbm7qrhX65SQEG6PiKdcvIPxrKjZiOWzazbUIVicjZX16UC8V2kOyDxlAi2a+AOijlGoCpmcJ2sUMadX4ViDaiWkFnhzLNYaDz4HGKPsUBpsFclBWty0ORS60bmrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAGC7RBUlM3OTDoImiRRWgTQ4LRkjOWEZ8wCedtj8FY=;
 b=hs1hOF5orQTrdKj9YcWDbCYGHIdWJUuycZW+sojvr1ikT1hcKmcLM4pnL+Ak/JrwXFPyL5Nms3crqnughka0hqF7ksUoJgYiGTILKbU32Up8h05gFhwZMCjQXCOqVdZ3IgjnmsDQb6FT8YJC15yeDMO+YnPSuat2uPduSzNvfsY=
Received: from CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 6 Jan
 2022 02:24:33 +0000
Received: from CO6PR12MB5458.namprd12.prod.outlook.com
 ([fe80::e5c4:faf6:6c63:3bf8]) by CO6PR12MB5458.namprd12.prod.outlook.com
 ([fe80::e5c4:faf6:6c63:3bf8%5]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 02:24:33 +0000
From: "Shi, Leslie" <Yuliang.Shi@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Unmap MMIO mappings when device is not
 unplugged
Thread-Topic: [PATCH v2] drm/amdgpu: Unmap MMIO mappings when device is not
 unplugged
Thread-Index: AQHYAewZiZGDzlG72UGfF/KDOn24u6xUvlAAgACFNqA=
Date: Thu, 6 Jan 2022 02:24:32 +0000
Message-ID: <CO6PR12MB5458950D4F580F8B6CA08785E04C9@CO6PR12MB5458.namprd12.prod.outlook.com>
References: <20220105042344.988200-1-Yuliang.Shi@amd.com>
 <36b4daf3-c18f-b860-4f82-646731be9fc2@amd.com>
In-Reply-To: <36b4daf3-c18f-b860-4f82-646731be9fc2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-06T02:24:30Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=dfbd52dd-af07-464d-b121-a9a1fe9f50a9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-06T02:24:30Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: c050cab5-3d5b-41f9-8ef8-7b03097deb5b
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e138decd-cead-4b79-b81e-08d9d0bbad2e
x-ms-traffictypediagnostic: CO6PR12MB5395:EE_
x-microsoft-antispam-prvs: <CO6PR12MB5395B437FC1C82E029E03E0AE04C9@CO6PR12MB5395.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KW4CY0148lUw4oZKtG22wRRSmAnXqOXWlCpw4Hrdye4M8mXV8PWv5ZmHghYqqFgWRs+bH7Y7baHwPjlc/1iPbQvNlI86hazG5wDsEPI78jgdKwzP/MCUQyXCEh4DKv+XqRx0EP/o3Xu3GXoZlgWdqVSz9rwE6frVpNgmAJYB9zB/ClL1iuB9QsYoUf5WMcIeYQnbciPXfVGfi9ln6QogJmT8kWOHrOpgxJQ7mjYFeVxK43tWEfI3cTZ7nI+D33h2LWr5I3pxonCCanHREHmdoDSIrsPkuEHPy6fqwBhbFa8Zps/BOFrwuR8zRBWGcz6TEYsY4RTEq/aIi/bS6Jayj/I1V4wFZi0/cZFZ+gsjGtU+8Kif9bfia1Kc6tu6C4C9+qRAygBt3MdbWvwhqIc5OWXGY6eNJL9eSpD5xKyk88r741NmYJBAcxOLDM0eKuuePJtqLKbuuFhvJQH3kUNtuxV0Ow4ZYyT4jaLuaLK419EgMRZRbDJrdWUx7QJbjv6swPNakLeN12J6p1ha7EA/kx9ofmzleLABWvnuqE5AULrKnrB9cpUVH87pgQ+5Ax2HgIv2YtScYFqTBUfQsjx+39kmwD//+/wxXQtWvhSwMEdkfFSjE7a/3N/Wi5PCf8bMPhPVfrpRItMnizU1jFuD+2iSqqyVwSJxZvEXh6KMnFoYv4bH3g4P1IWk8oHCg/31pheDLVPbJdp1nOeVveEhEg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5458.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(38070700005)(26005)(53546011)(110136005)(86362001)(66946007)(8676002)(2906002)(4326008)(76116006)(38100700002)(64756008)(66556008)(5660300002)(66446008)(186003)(122000001)(66476007)(55016003)(7696005)(33656002)(83380400001)(71200400001)(8936002)(508600001)(9686003)(6506007)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUxmd091WHZlR0lYVENObjl0QTBDUS9mbXVkNTlFa2ZJemdmSStTNjZqcHZZ?=
 =?utf-8?B?c3dOZHpkOWNsb0wvYnQ0T09RZ1BvcmdNTU9XWFJURUpnTm9pTkU4ZTZDTnNN?=
 =?utf-8?B?Z2NqV3BGNXYzZjNFSWIwd2FSK2ZQK1FpSnk1K000L1Q5aVp4VHlBTUNEbXB5?=
 =?utf-8?B?aTlPRE5XZXhuSkJDZnRBQkhVUjgwSVJxbEVidE1KcE91MGRzWTJtaTgzZ0FV?=
 =?utf-8?B?VENpaGNNTGRrM2Q2WWxWNHVLT3RIU3ZCcm5aMGZGczBZM0k3eE5JVWpMMzBv?=
 =?utf-8?B?aTY5b2Niak44US9qSFQ0bURmZjBvMi9rRytLZXZFNkc5RXJHUXZ3ajBCUjRG?=
 =?utf-8?B?TkpDVzBFY2JhOXNLMXR0QkRvdVNtU0VpRkxUejhnbVhwZWsxYjhZdE1BS0JZ?=
 =?utf-8?B?S0hJdjlXRmIxMVVjKzJDTUFsK1RQMllKcWl4RXJSQXgwU2F1OTVtcCtnTkR0?=
 =?utf-8?B?SXlmcml1RnFNZTEvc2JxZnFkdjhBM1BSbE1DRzBUeFo5Zk1uRUFRd3JCaElj?=
 =?utf-8?B?d0tyUXJvSW92RkdkK1ptYTE2QkNmY3pZOG9vcW5xcGxxS3NWZU9nZWVidG9z?=
 =?utf-8?B?V0R5TFgvcUZpenltSERxbUhXVHU2Tndod0ZPM1V5cEtiL0lPMGpFb3RNSFhN?=
 =?utf-8?B?Qmw2NzF6TXIzU2pmM3RsTkg1REpmNnlLZ1dySlI5Y1pDVjdmL0lBbmowV2VM?=
 =?utf-8?B?eEwyeGV4bExDRk5ZZks5T0FMRExOL1NaOXRtelZBZ3ArcU9MQ2d4cXRPUW9k?=
 =?utf-8?B?L1h0cWNYMDdkNTk5b2U4dlhnNmhSOE1Pd3p1RlEvNTFwZTZFRzZJVm1UaTNJ?=
 =?utf-8?B?cmpsb1Nnbi9lTUhiWlhzQnZtVGwybkpTdy91WnZTcThSRXZ5MHVZNnp4TGx6?=
 =?utf-8?B?V045OXN1TjRHMDk4VHl2V1cybGthZkk1WWkzOGZNTlF3eTZITVhGSWdCdXhi?=
 =?utf-8?B?U0MzOUNzZ0FTTkN3UlZZTEF4WUFZM3lpUUZMK0k5cW1BcFNHYTgxMFJMaS9z?=
 =?utf-8?B?clBiTkV6c2poRHVYci9QZGRkWEFVWUp6NDArZlNQUEVUZjVWNElIdjBRWTFU?=
 =?utf-8?B?SlNwTjhMZFpFdW5PSXRxSlIzOHhwOGxISk5mRiszVmN1Q01hZXFBNXJwMHBp?=
 =?utf-8?B?d0xudVZzc1NvUko1eE5iZCtUUk9xQzFMYUUrVHp4NzVYTys1enhwYXpKR2hY?=
 =?utf-8?B?ZFpMRkFQVzY3MlcyaG5HcUwvK1MvU1EyTkxrTG01U2k0U3IwRUlZMkJTU2Yx?=
 =?utf-8?B?cHZmWm43UUFwZXVsdSszMHN5L2dXVXFqVExTbW5UZEROaUZNOTVsa0NvaXFQ?=
 =?utf-8?B?ek9QYnFBNUVLMXJReGxlRHpGQUM5d0d4WWNtMjZNNEhWS2l5RjhVenJ4UDMv?=
 =?utf-8?B?K0c5bGR4bkFybjNBeW84ZEtWMlBrM1UxNTdkZTg4YmpVbjN0c0V4REVLM3dv?=
 =?utf-8?B?NVlBVHlad1BzMVNiRlFSakdQN2x3ZmRKMHBmelRPc3cvK1RzK0svK0k4L3R5?=
 =?utf-8?B?bGhzM1R6UEJNOWtVODNSN0FqV09SSFVScjFaYUNwZlFxYWI2emZMUnB2SXh0?=
 =?utf-8?B?bWQ4Sk53UWdCWThFckRySmhzYVFMMzhlUktSUTM2a25xa3hLUFZVVUxueDVl?=
 =?utf-8?B?Q3ZtdVZscFBaNEZEdkp2NmhOVEYxQzlpdDgvRFlwek85dEVMQm0zZmc1ZXBu?=
 =?utf-8?B?WUluM2RRMjV0N3ROSkU3YlQ2VVV6Z0l0dFAxellSa1U4d1I3REZ1WGlzdmlr?=
 =?utf-8?B?TExnaFVGSXZVblgxV0hmZk1OanVKMUVnNmpFOUF0Tms1NUFFajRTck11UlM3?=
 =?utf-8?B?Ky9US3ZWK0ZZVTBOMFNzYlhPVlNNR1pGQjVoREthSGU1M2xVMXRiUVpIMWxX?=
 =?utf-8?B?N2ZwdUs1VzBJUE12OGdTL2ErMUtOakFUc3lnVVhPZTcxTy9sRENISkFSNHpn?=
 =?utf-8?B?NXI3Q2pCZkt1aldBUXlubjJFVG9xWlcvSTlEZUFReEl4aDlmWDFqQ1lWdEZx?=
 =?utf-8?B?WDRqY1pKV1FlcE1mcmEzQStwdUwxUHNKaDVMZ04wRi91eHVCZG83YjEzZ2Ji?=
 =?utf-8?B?dXJWSVBjdC82THJaakFxOTF1VGM3cGtGNFRNNHp3NTJ1ZG0vblJKNDR4c0to?=
 =?utf-8?B?Z2cyQStOSHBDMWk5K0hQbGtpTTNGenlET2tjd1VaUUdrTmRFSEpTQlJkR1U5?=
 =?utf-8?Q?bfTiZjOMg7FkzFVoZn4pPEc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e138decd-cead-4b79-b81e-08d9d0bbad2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 02:24:33.1387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nunG9zTst6p8U98A2hZzo5EZR6b+YLcelL9CO/R7MyuuH3Smv7Sn6hXFQy6nmL5IC9PDXY1rKI9QDJRD/IuIlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgQW5kcmV5LA0KDQpJdCBpcyB0aGUgZm9sbG93
aW5nIHBhdGNoIGNhbGxzIHRvIGFtZGdwdV9kZXZpY2VfdW5tYXBfbW1pbygpIGNvbmRpdGlvbmVk
IG9uIGRldmljZSB1bnBsdWdnZWQuDQoNCjNlZmIxN2FlN2U5MiAiZHJtL2FtZGdwdTogQ2FsbCBh
bWRncHVfZGV2aWNlX3VubWFwX21taW8oKSBpZiBkZXZpY2UgaXMgdW5wbHVnZ2VkIHRvIHByZXZl
bnQgY3Jhc2ggaW4gR1BVIGluaXRpYWxpemF0aW9uIGZhaWx1cmUiDQoNClJlZ2FyZHMsDQpMZXNs
aWUNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEdyb2R6b3Zza3ksIEFuZHJl
eSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT4gDQpTZW50OiBUaHVyc2RheSwgSmFudWFyeSA2
LCAyMDIyIDI6MjIgQU0NClRvOiBTaGksIExlc2xpZSA8WXVsaWFuZy5TaGlAYW1kLmNvbT47IExh
emFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KQ2M6IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4NClN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjJdIGRybS9hbWRncHU6IFVubWFwIE1NSU8gbWFwcGluZ3Mgd2hlbiBkZXZpY2Ug
aXMgbm90IHVucGx1Z2dlZA0KDQoNCk9uIDIwMjItMDEtMDQgMTE6MjMgcC5tLiwgTGVzbGllIFNo
aSB3cm90ZToNCj4gUGF0Y2g6IDNlZmIxN2FlN2U5MiAoImRybS9hbWRncHU6IENhbGwgYW1kZ3B1
X2RldmljZV91bm1hcF9tbWlvKCkgaWYgDQo+IGRldmljZSBpcyB1bnBsdWdnZWQgdG8gcHJldmVu
dCBjcmFzaCBpbiBHUFUgaW5pdGlhbGl6YXRpb24gZmFpbHVyZSIpIA0KPiBtYWtlcyBjYWxsIHRv
DQo+IGFtZGdwdV9kZXZpY2VfdW5tYXBfbW1pbygpIGNvbmRpdGlvbmVkIG9uIGRldmljZSB1bnBs
dWdnZWQuIFRoaXMgcGF0Y2ggDQo+IHVubWFwcyBNTUlPIG1hcHBpbmdzIGV2ZW4gd2hlbiBkZXZp
Y2UgaXMgbm90IHVucGx1Z2dlZC4NCg0KDQpJIGRvbid0IHNlZSB0aGUgJ2NhbGwgdG8gYW1kZ3B1
X2RldmljZV91bm1hcF9tbWlvKCkgY29uZGl0aW9uZWQgb24gZGV2aWNlIHVucGx1Z2dlZCcNCnBh
cnQgaW4gdGhpcyBwYXRjaA0KDQpBbHNvLCBwbGVhc2UgYWRkICd2MjpibGEgYmxhIGJsYScgcGFy
dCBpbiBwYXRjaCBkZXNjcmlwdGlvbiB0ZWxsaW5nIHdoYXQgd2FzIGRvbmUgaW4gdjINCg0KQW5k
cmV5DQoNCj4NCj4gU2lnbmVkLW9mZi1ieTogTGVzbGllIFNoaSA8WXVsaWFuZy5TaGlAYW1kLmNv
bT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
IHwgMTEgKysrKysrKysrKysNCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
b2JqZWN0LmMgfCAxMiArKysrKysrKysrKysNCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdHRtLmMgICAgfCAxMSArKysrKysrKysrKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwg
MzQgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYw0KPiBpbmRleCA0MTJmMzc3ZjgwYjEuLjE2ZGMxNmM4NjBjYyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBAQCAtMzgz
Miw2ICszODMyLDcgQEAgaW50IGFtZGdwdV9kZXZpY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSANCj4gKmFkZXYsDQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgYW1kZ3B1X2RldmljZV91bm1hcF9t
bWlvKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIHsNCj4gKw0KPiAgIAkvKiBDbGVh
ciBhbGwgQ1BVIG1hcHBpbmdzIHBvaW50aW5nIHRvIHRoaXMgZGV2aWNlICovDQo+ICAgCXVubWFw
X21hcHBpbmdfcmFuZ2UoYWRldi0+ZGRldi5hbm9uX2lub2RlLT5pX21hcHBpbmcsIDAsIDAsIDEp
Ow0KPiAgIA0KPiBAQCAtMzkxMiw2ICszOTEzLDggQEAgdm9pZCBhbWRncHVfZGV2aWNlX2Zpbmlf
aHcoc3RydWN0IGFtZGdwdV9kZXZpY2UgDQo+ICphZGV2KQ0KPiAgIA0KPiAgIHZvaWQgYW1kZ3B1
X2RldmljZV9maW5pX3N3KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIHsNCj4gKwlp
bnQgaWR4Ow0KPiArDQo+ICAgCWFtZGdwdV9mZW5jZV9kcml2ZXJfc3dfZmluaShhZGV2KTsNCj4g
ICAJYW1kZ3B1X2RldmljZV9pcF9maW5pKGFkZXYpOw0KPiAgIAlyZWxlYXNlX2Zpcm13YXJlKGFk
ZXYtPmZpcm13YXJlLmdwdV9pbmZvX2Z3KTsNCj4gQEAgLTM5MzYsNiArMzkzOSwxNCBAQCB2b2lk
IGFtZGdwdV9kZXZpY2VfZmluaV9zdyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAJ
aWYgKChhZGV2LT5wZGV2LT5jbGFzcyA+PiA4KSA9PSBQQ0lfQ0xBU1NfRElTUExBWV9WR0EpDQo+
ICAgCQl2Z2FfY2xpZW50X3JlZ2lzdGVyKGFkZXYtPnBkZXYsIE5VTEwsIE5VTEwsIE5VTEwpOw0K
PiAgIA0KPiArCWlmIChkcm1fZGV2X2VudGVyKGFkZXZfdG9fZHJtKGFkZXYpLCAmaWR4KSkgew0K
PiArDQo+ICsJCWlvdW5tYXAoYWRldi0+cm1taW8pOw0KPiArCQlhZGV2LT5ybW1pbyA9IE5VTEw7
DQo+ICsJCWFtZGdwdV9kZXZpY2VfZG9vcmJlbGxfZmluaShhZGV2KTsNCj4gKwkJZHJtX2Rldl9l
eGl0KGlkeCk7DQo+ICsJfQ0KPiArDQo+ICAgCWlmIChJU19FTkFCTEVEKENPTkZJR19QRVJGX0VW
RU5UUykpDQo+ICAgCQlhbWRncHVfcG11X2ZpbmkoYWRldik7DQo+ICAgCWlmIChhZGV2LT5tbWFu
LmRpc2NvdmVyeV9iaW4pDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfb2JqZWN0LmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X29iamVjdC5jDQo+IGluZGV4IDE1NjAwMmRiMjRlMS4uZmY5ZGMzNzdhM2EwIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jDQo+IEBAIC0zMyw2ICsz
Myw3IEBADQo+ICAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gICAjaW5jbHVkZSA8bGludXgv
ZG1hLWJ1Zi5oPg0KPiAgIA0KPiArI2luY2x1ZGUgPGRybS9kcm1fZHJ2Lmg+DQo+ICAgI2luY2x1
ZGUgPGRybS9hbWRncHVfZHJtLmg+DQo+ICAgI2luY2x1ZGUgPGRybS9kcm1fY2FjaGUuaD4NCj4g
ICAjaW5jbHVkZSAiYW1kZ3B1LmgiDQo+IEBAIC0xMDYxLDcgKzEwNjIsMTggQEAgaW50IGFtZGdw
dV9ib19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgICAqLw0KPiAgIHZvaWQg
YW1kZ3B1X2JvX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgew0KPiArCWlu
dCBpZHg7DQo+ICsNCj4gICAJYW1kZ3B1X3R0bV9maW5pKGFkZXYpOw0KPiArDQo+ICsJaWYgKGRy
bV9kZXZfZW50ZXIoYWRldl90b19kcm0oYWRldiksICZpZHgpKSB7DQo+ICsNCj4gKwkJaWYgKCFh
ZGV2LT5nbWMueGdtaS5jb25uZWN0ZWRfdG9fY3B1KSB7DQo+ICsJCQlhcmNoX3BoeXNfd2NfZGVs
KGFkZXYtPmdtYy52cmFtX210cnIpOw0KPiArCQkJYXJjaF9pb19mcmVlX21lbXR5cGVfd2MoYWRl
di0+Z21jLmFwZXJfYmFzZSwgYWRldi0+Z21jLmFwZXJfc2l6ZSk7DQo+ICsJCX0NCj4gKwkJZHJt
X2Rldl9leGl0KGlkeCk7DQo+ICsJfQ0KPiAgIH0NCj4gICANCj4gICAvKioNCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyANCj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMNCj4gaW5kZXggMzY3YWJlZDFkNmU2Li5l
YTg5N2ZlZWRkZDIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90dG0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRt
LmMNCj4gQEAgLTQyLDYgKzQyLDcgQEANCj4gICAjaW5jbHVkZSA8bGludXgvZG1hLWJ1Zi5oPg0K
PiAgICNpbmNsdWRlIDxsaW51eC9zaXplcy5oPg0KPiAgIA0KPiArI2luY2x1ZGUgPGRybS9kcm1f
ZHJ2Lmg+DQo+ICAgI2luY2x1ZGUgPGRybS90dG0vdHRtX2JvX2FwaS5oPg0KPiAgICNpbmNsdWRl
IDxkcm0vdHRtL3R0bV9ib19kcml2ZXIuaD4NCj4gICAjaW5jbHVkZSA8ZHJtL3R0bS90dG1fcGxh
Y2VtZW50Lmg+DQo+IEBAIC0xODAxLDYgKzE4MDIsNyBAQCBpbnQgYW1kZ3B1X3R0bV9pbml0KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgICAqLw0KPiAgIHZvaWQgYW1kZ3B1X3R0bV9m
aW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIHsNCj4gKwlpbnQgaWR4Ow0KPiAg
IAlpZiAoIWFkZXYtPm1tYW4uaW5pdGlhbGl6ZWQpDQo+ICAgCQlyZXR1cm47DQo+ICAgDQo+IEBA
IC0xODE1LDYgKzE4MTcsMTUgQEAgdm9pZCBhbWRncHVfdHRtX2Zpbmkoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpDQo+ICAgCQkJCSAgICAgIE5VTEwsIE5VTEwpOw0KPiAgIAlhbWRncHVfdHRt
X2Z3X3Jlc2VydmVfdnJhbV9maW5pKGFkZXYpOw0KPiAgIA0KPiArCWlmIChkcm1fZGV2X2VudGVy
KGFkZXZfdG9fZHJtKGFkZXYpLCAmaWR4KSkgew0KPiArDQo+ICsJCWlmIChhZGV2LT5tbWFuLmFw
ZXJfYmFzZV9rYWRkcikNCj4gKwkJCWlvdW5tYXAoYWRldi0+bW1hbi5hcGVyX2Jhc2Vfa2FkZHIp
Ow0KPiArCQlhZGV2LT5tbWFuLmFwZXJfYmFzZV9rYWRkciA9IE5VTEw7DQo+ICsNCj4gKwkJZHJt
X2Rldl9leGl0KGlkeCk7DQo+ICsJfQ0KPiArDQo+ICAgCWFtZGdwdV92cmFtX21ncl9maW5pKGFk
ZXYpOw0KPiAgIAlhbWRncHVfZ3R0X21ncl9maW5pKGFkZXYpOw0KPiAgIAlhbWRncHVfcHJlZW1w
dF9tZ3JfZmluaShhZGV2KTsNCg==
