Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EA6C678D5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 15:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8757C10E50F;
	Tue,  7 Mar 2023 15:28:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2107C10E50F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 15:28:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWA7VoUo7JzYy8ffeggfwb52jp8m9D90nAh4RKIDJFbZ+N0XMzElCh7G9OWTss1m1kKEuAdc2gUrhIFq1jzHmIGqsTYbbmhg/vxBP2xSqz81II7N9n2+vGn7U1l1WUOVOVSI0H4idZwrRF7AlNbTULfy9MCLAXexrNkDZ5i8qXLTpwMN9eTD5R6S9oTo4Hcto8JFB2nYWWvkf4dEc4ii+7820ucvH+ZT7I4eRe3ajJKhFvVArucd5tI40RP1VcRoB3L/AC+1yHGAooqS7RdcEEr/bvH0/lUOjEXcrLw8OTHl9csDMZDaOXpPCo1M9sX1NRCNepsWT7TdolMnI7z6tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcvJTv5XiwDkphoso0vh0OF5XLzGPiRW2za0aGaEwcE=;
 b=VLp9szcjd3ZhdRl+PZAMhu7qRYZIMhSjbLu5EuGVcMhXpIUNBmu7E5ltcr+zbvd0IAHRrMONCc0cUUzK/53qhZJ/5vkX/DvGxzdSWsYFNDoI6Nf03NlYUc89bgXnT8UyUz4Qq88tGbpltg/Md8sOZHm/xmFgFhncx63kRW+XDYHZfP8Up4jBrNGeo+xrqMsE6+vRj/gKistSE1moXNWFmv+aZGztBBZE4aAP/c7NsWJ2z6+lpU57z/0a5U22nJpdGZpIpO6/O1veo0Es55AqfXdysI3cVXNcyhtW3TpL0ynE9U/CMBCRICU2oy8iEIAQS6IBSDoPAwuU1XrtBZ3KXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcvJTv5XiwDkphoso0vh0OF5XLzGPiRW2za0aGaEwcE=;
 b=Lv6iKGyg97NOBNwY7+gm26akUUOXHvF72aaovRf43ctHvtO8miw4s0uizFS6ox+RnqXf4KS4xT+Nm4qnN99LqH0NA5rifq6J2VWOG/bEmivL80z1tXXJcAsxuDsJEEIR+lLpJ5FCeSTnOMoNRJPUM73HjgOW3FfjktYxnDD+erk=
Received: from DM6PR12MB4828.namprd12.prod.outlook.com (2603:10b6:5:1f8::26)
 by CY8PR12MB8298.namprd12.prod.outlook.com (2603:10b6:930:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 15:28:28 +0000
Received: from DM6PR12MB4828.namprd12.prod.outlook.com
 ([fe80::e608:9952:5ed1:a1c]) by DM6PR12MB4828.namprd12.prod.outlook.com
 ([fe80::e608:9952:5ed1:a1c%7]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 15:28:27 +0000
From: "Belanger, David" <David.Belanger@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fixed kfd_process cleanup on module exit.
Thread-Topic: [PATCH] drm/amdkfd: Fixed kfd_process cleanup on module exit.
Thread-Index: AQHZUHbHjo+yZ+OqDUu6+IlHo1ONIK7u5TWAgACIlmA=
Date: Tue, 7 Mar 2023 15:28:27 +0000
Message-ID: <DM6PR12MB482867775D93C72A95ED5C3099B79@DM6PR12MB4828.namprd12.prod.outlook.com>
References: <20230306215808.2903387-1-david.belanger@amd.com>
 <92f89f03-dfa8-0f50-309c-69c7c22541d8@amd.com>
In-Reply-To: <92f89f03-dfa8-0f50-309c-69c7c22541d8@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-07T15:28:25Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=86a0f148-304e-4d9f-bc01-14616543c30d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-07T15:28:25Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: c040c0a9-2e86-469a-9225-e25da7c7d86b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4828:EE_|CY8PR12MB8298:EE_
x-ms-office365-filtering-correlation-id: 1bd41cf6-5974-4166-97d1-08db1f20995d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GniwIr2MLwV2zpltYjqJ83BYb3lmBbPyX8wh4WowQdapC0J3xDI9vy6puWZDY2TW5FqxxRXxxKCn1E3AvmQG6XT9J3jFgLDGAGp6Y/PDXG8hlHL1WqusTRGyWRJWmNLlCBDYn0XXg64FYCb7GlNc51YVynK17bGS6y0YQ8tdGnCAj5K76O2pHxjimA03M/YcgA2wWyJsMoMm7c0wzwGqmRa62zVS738nYVSTAoinhfh9y/cJSGBZggNaeOwue7h4twhzqO5BVhcx1UxeTVRyf64szQ3UFiwv33SHyFKw5Ne1+muhRtu9Bfk2DdHigh4Ok3xHK4mncDnKHNxDQr8Nso7GEpvEW6QHB+Yfk4ZSeu2sRuyEQIMJgPY7WzFG/5PeM0iECoHKtiNXEA+OY8k4Y8fATAVTdO78Jl/5uOYs+PgylXlRqkikNSb9hjI74a3QKCU0ZHhgDBHVgPXlIjzyYjFXtxgDZAzGQk+Ill0x8Lzf3TgIAwmS05xVqCgetxSg5KMjblZJ0zFPEwc2Wi41+FvjFL2vppZij/HJvUqIAXJEj3bLG5jGysjCn6YkAetVrzFoTg8qi2N8ccJZrPE3t9b2bWQ6lC35+hYQ3/6cm0kSccZyt3/q2549qK1t040boAXZiMvtzGI4m81tH6Dp3sr8K1JDiEfkN/8IWLicHiE4NmJXJ/MTZvRfvhcCWMk4BazQgI266lPbkbllKjPikQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4828.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199018)(41300700001)(66946007)(6506007)(53546011)(26005)(38070700005)(186003)(83380400001)(9686003)(110136005)(122000001)(38100700002)(316002)(478600001)(66556008)(8676002)(64756008)(66446008)(66476007)(76116006)(86362001)(33656002)(7696005)(71200400001)(2906002)(55016003)(5660300002)(52536014)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWM1TkdSeElRajVMRmpZY2ZrVVBnNElRNlpTTEtseXEzdWhnZ2FTWGgvWU1x?=
 =?utf-8?B?aXBmV0luOWY1d1N6SkRvWFRrcy90SjQ1VUVFTXAwLzhRN3B0elZlbXZnSEZK?=
 =?utf-8?B?cDN0dThmc3cwRVFOMXRLZlc4c01seisxYjdUMHV4cWhjdTVHenQrSzQ2ZE1G?=
 =?utf-8?B?TFV5aDVBeWtxYXNiUjV5N1dSQ3JDRjg1cEgzT1Noa3lwY21DMDBhM0JLdFhY?=
 =?utf-8?B?bGw0aTJvdXpRVkhSSFFNSDB0Q0h6b085YXVUZUdRR09WRGcxMVB1b0QyeHdS?=
 =?utf-8?B?RnJ0Sk02azRuUjh3b2tQWWZLWkJCQ1BJOVl5Q1dvRGt5VXN4a1FhcWtMV0Z0?=
 =?utf-8?B?M0RqdjRnSkZGNjRWNzJ1ZDAyUG85RDcrV1l2THU3KzBXVW4vbWdwd0ZFYnJB?=
 =?utf-8?B?KzQyV2dHa1lXUlhoSFY4UU8zYk5WQk0xdHIwY0dHSThVQ3BvOCtLVXBySmk5?=
 =?utf-8?B?aU45QlNQWWlYaHpZUVFVRnRtOWhDWHh1QWR6UTBWeDlpSjBaZWJjTEJFa2px?=
 =?utf-8?B?RVpKU0duNTN2N0VwUWxxeWJuVTBpZkNrNE04SEM5aW5SbnpTUHNIQXdDNVlR?=
 =?utf-8?B?a0FnVkIvUkZmQ2ZBdlNDTDVXR2lKQXVjT3Bock9nNG1aZXF4RW9FWm5ORnM1?=
 =?utf-8?B?aFZLM3N0R3JHZmx6ZTdKYUxVUVA0U1BhS0V1SlVaR05XdWlGYmIyaElHL2NG?=
 =?utf-8?B?N0JpUnUyOUZjWlZEalFFMDVXZDZqSGgzSlh5TUpvZzZNa241NStLQmhVUDMr?=
 =?utf-8?B?S3MyWjZ2aHc4V2w0bEtuQyt2ejdidjBMOTJkRWdFZXBOb01zVDFtRm9TMmJB?=
 =?utf-8?B?R0VZQ0h6MHlDMmQ2UGxmd3IxdzVxTG92ZTlaeDVsMFBQMkhBemMweWJQSnMv?=
 =?utf-8?B?QnpkOER6SGtLdDhDL3ZWa1NZd2N5T0IrcndUc0dOSHA2Y3ZmcHYvYlljOVhV?=
 =?utf-8?B?d0tpQjJDWTJFbnVGcHNJR1BkM0ZVcjRJd2FDRUtTN1g1L0V6WWdNV0xaZTBi?=
 =?utf-8?B?SXlLcFpJM1NjRHlLSUlMOFF6blBNbHZyRlNEbm1pMWVBZnBMbU9wMjlHVEJI?=
 =?utf-8?B?NkJOK1k3ZCtOQ2ZGNDlEMnRRU0V6UmxJUXl0UThoaXpKcy9QYTVoMW1Td0V5?=
 =?utf-8?B?dmkxbFZ6RU9iSG9Ed285bkhzcVZra3IrYXlPVXZjUFZ0MkVXVUdmay9kaE5h?=
 =?utf-8?B?S29RV0FtOWxvb3A5YloybE5RZ3Azc05ESG1ieENHZWl5SlE5MHliZTJFK1Ro?=
 =?utf-8?B?cEhkM01ZOEhLeERwZFNuOTU5OWxoamtIV3NkVU81aEtVSGpxb1JzcEtueUp5?=
 =?utf-8?B?dFloL1RYL0wrbkIzRWh5OTNNb3hQbTdLQS9kMVVya2YwSFRHR1hoRHNUNGsx?=
 =?utf-8?B?bnZZbkdnT0ExSG14R1c0ZzgwWE9ZRVFDN1NGMDdSQStQL1pZaWMrOUVqUzA2?=
 =?utf-8?B?dnNsVVpva3d4MEN0U0IvVVRmSVdSQStnY3JIZjNNRGZMZmNpcEpsNWpEU09p?=
 =?utf-8?B?M3NjdmhzUC9NaXVVV0NHTzF5SFI5Q01DV3l0MjNvSlhaaFRBeDdNOG9td0Nx?=
 =?utf-8?B?dzZHb1N4WUNIeUtSYnVyZjJjaWtXa1ZsdU1vbWoxVWFTalVDamNROERFYlQ5?=
 =?utf-8?B?QnVkcFBmWEl6eThwalZQTFY4MFl6TUZvQ21mQ1U4YWxPREpwelRoRWxEN2JC?=
 =?utf-8?B?dnIrRmVBdkNzQ0VtSTJwQWdhZzgwclZnbUpEc0dOS3dxMkFJQ25Qa1huQi9y?=
 =?utf-8?B?VVNockQxL09XWDBySGxETEdKQU1ESkRxNXRudlBLZzUzcTRYWTFUOHdWRE8r?=
 =?utf-8?B?UEdCc2xJTW1uL3RZTUJhbkJUTmowMEYzTEJVcjFxanhLdllaYUVWWnl4ckZr?=
 =?utf-8?B?RFM1cWtNeU9tNjBmQjdrMXIzQkE4NjhVcXhhM0txU0p6dTFDRnpKUjJZcS83?=
 =?utf-8?B?ZVJQcmREOWYwUTB1V0FBN3VnQlNic0dEWms5b0s4Ym1kcWQwYzlQYXlOaDZD?=
 =?utf-8?B?bHl0RTdHbnRtQkZINHpKZ1lDeVJpSFZxRjZHNTB4QUphNk9LWUwrbVVWZTRO?=
 =?utf-8?B?MDJpNFhhZ01ic3RCeVNKZGJxbDc5MUFuRjhZTy9sc1k5cTh6MkFoVzRiVDVU?=
 =?utf-8?Q?RScc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4828.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd41cf6-5974-4166-97d1-08db1f20995d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 15:28:27.5206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0dkx4mHLVbXy0OEC2QmmsT09TxsTVaaSD2SL4zTOfeS8VkLEOHhk30mHCtwkBQDKH6U2dkV6eMoI2gT1AfYmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KVGhlIHRlc3QgY2FzZSBpcyBh
IHB5dGhvbiBwcm9ncmFtIHRoYXQgd2lsbCBsb2FkIHRoZSBkcml2ZXIsIGRvIHNvbWUgb3BlcmF0
aW9ucywgdGhlbiB1bmxvYWQgdGhlIGRyaXZlci4NCldoZW4gdGhlIGRyaXZlciBleGlzdHMsIHRo
ZXJlIGlzIHN0aWxsIHRoZSBweXRob24gcHJvY2VzcyBzcGFjZSBhcm91bmQgaG9sZGluZyBvbiB0
aGUgYWRkcmVzcyBzcGFjZS4NCldoZW4gdGhlIHB5dGhvbiBwcm9jZXNzIHNwYWNlIGV4aXRzLCB0
aGUgbW11X25vdGlmaWVyIGdldHMgY2FsbGVkIGJ1dCB0aGUgZHJpdmVyIGhhcyBhbHJlYWR5IGJl
ZW4gdW5sb2FkZWQuDQoNClRoZSBnb2FsIG9mIHRoZSBmaXggaXMgdG8gYWRkcmVzcyBjYXNlIHdo
ZXJlIHRoZXJlIGNvdWxkIGJlIG91dHN0YW5kaW5nIGFkZHJlc3Mgc3BhY2UgLyB3b3JrZXIgdGhy
ZWFkcyBmb3IgcHJvY2Vzcw0KY2xlYW51cCB0aGF0IG5lZWRzIHRvIGJlIGNsZWFyZWQvY29tcGxl
dGVkIGF0IGV4aXQgdGltZS4NCg0KUmVnYXJkcywNCkRhdmlkIEIuDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2Vu
aWdAYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggNywgMjAyMyAyOjA1IEFNDQo+IFRv
OiBCZWxhbmdlciwgRGF2aWQgPERhdmlkLkJlbGFuZ2VyQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDog
Rml4ZWQga2ZkX3Byb2Nlc3MgY2xlYW51cCBvbiBtb2R1bGUNCj4gZXhpdC4NCj4gDQo+IEFtIDA2
LjAzLjIzIHVtIDIyOjU4IHNjaHJpZWIgRGF2aWQgQmVsYW5nZXI6DQo+ID4gSGFuZGxlIGNhc2Ug
d2hlbiBtb2R1bGUgaXMgdW5sb2FkZWQgKGtmZF9leGl0KSBiZWZvcmUgYSBwcm9jZXNzIHNwYWNl
DQo+ID4gKG1tX3N0cnVjdCkgaXMgcmVsZWFzZWQuDQo+IA0KPiBXZWxsIHRoYXQgc2hvdWxkIG5l
dmVyIGV2ZXIgaGFwcGVuIGluIHRoZSBmaXJzdCBwbGFjZS4gSXQgc291bmRzIGxpa2Ugd2UgYXJl
DQo+IG1pc3NpbmcgZ3JhYmJpbmcgbW9kdWxlIHJlZmVyZW5jZXMuDQo+IA0KPiBSZWdhcmRzLA0K
PiBDaHJpc3RpYW4uDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGF2aWQgQmVsYW5nZXIg
PGRhdmlkLmJlbGFuZ2VyQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfbW9kdWxlLmMgIHwgIDQgKysNCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMgfCA1Nw0KPiArKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tb2R1bGUuYw0KPiA+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21vZHVsZS5jDQo+ID4gaW5kZXggMDliOTY2ZGMz
NzY4Li44ZWY0YmQ5ZTRmN2QgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX21vZHVsZS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX21vZHVsZS5jDQo+ID4gQEAgLTI2LDYgKzI2LDkgQEANCj4gPiAgICNpbmNsdWRlICJrZmRf
cHJpdi5oIg0KPiA+ICAgI2luY2x1ZGUgImFtZGdwdV9hbWRrZmQuaCINCj4gPg0KPiA+ICt2b2lk
IGtmZF9jbGVhbnVwX3Byb2Nlc3Nlcyh2b2lkKTsNCj4gPiArDQo+ID4gKw0KPiA+ICAgc3RhdGlj
IGludCBrZmRfaW5pdCh2b2lkKQ0KPiA+ICAgew0KPiA+ICAgCWludCBlcnI7DQo+ID4gQEAgLTc3
LDYgKzgwLDcgQEAgc3RhdGljIGludCBrZmRfaW5pdCh2b2lkKQ0KPiA+DQo+ID4gICBzdGF0aWMg
dm9pZCBrZmRfZXhpdCh2b2lkKQ0KPiA+ICAgew0KPiA+ICsJa2ZkX2NsZWFudXBfcHJvY2Vzc2Vz
KCk7DQo+ID4gICAJa2ZkX2RlYnVnZnNfZmluaSgpOw0KPiA+ICAgCWtmZF9wcm9jZXNzX2Rlc3Ry
b3lfd3EoKTsNCj4gPiAgIAlrZmRfcHJvY2ZzX3NodXRkb3duKCk7DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMNCj4gPiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMNCj4gPiBpbmRleCBlYmFiZTkyZjdlZGIu
LmI1YjI4YTMyNjM5ZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfcHJvY2Vzcy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3Byb2Nlc3MuYw0KPiA+IEBAIC0xMTgxLDYgKzExODEsMTcgQEAgc3RhdGljIHZvaWQga2ZkX3By
b2Nlc3Nfbm90aWZpZXJfcmVsZWFzZShzdHJ1Y3QNCj4gbW11X25vdGlmaWVyICptbiwNCj4gPiAg
IAkJcmV0dXJuOw0KPiA+DQo+ID4gICAJbXV0ZXhfbG9jaygma2ZkX3Byb2Nlc3Nlc19tdXRleCk7
DQo+ID4gKwkvKg0KPiA+ICsJICogRG8gZWFybHkgcmV0dXJuIGlmIHAgaXMgbm90IGluIHRoZSB0
YWJsZS4NCj4gPiArCSAqDQo+ID4gKwkgKiBUaGlzIGNvdWxkIHBvdGVudGlhbGx5IGhhcHBlbiBp
ZiB0aGlzIGZ1bmN0aW9uIGlzIGNhbGxlZCBjb25jdXJyZW50bHkNCj4gPiArCSAqIGJ5IG1tdV9u
b3RpZmllciBhbmQgYnkga2ZkX2NsZWFudXBfcG9jZXNzZXMuDQo+ID4gKwkgKg0KPiA+ICsJICov
DQo+ID4gKwlpZiAoIWhhc2hfaGFzaGVkKCZwLT5rZmRfcHJvY2Vzc2VzKSkgew0KPiA+ICsJCW11
dGV4X3VubG9jaygma2ZkX3Byb2Nlc3Nlc19tdXRleCk7DQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsJ
fQ0KPiA+ICAgCWhhc2hfZGVsX3JjdSgmcC0+a2ZkX3Byb2Nlc3Nlcyk7DQo+ID4gICAJbXV0ZXhf
dW5sb2NrKCZrZmRfcHJvY2Vzc2VzX211dGV4KTsNCj4gPiAgIAlzeW5jaHJvbml6ZV9zcmN1KCZr
ZmRfcHJvY2Vzc2VzX3NyY3UpOw0KPiA+IEBAIC0xMjAwLDYgKzEyMTEsNTIgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBtbXVfbm90aWZpZXJfb3BzDQo+IGtmZF9wcm9jZXNzX21tdV9ub3RpZmllcl9v
cHMgPSB7DQo+ID4gICAJLmZyZWVfbm90aWZpZXIgPSBrZmRfcHJvY2Vzc19mcmVlX25vdGlmaWVy
LA0KPiA+ICAgfTsNCj4gPg0KPiA+ICsNCj4gPiArdm9pZCBrZmRfY2xlYW51cF9wcm9jZXNzZXMo
dm9pZCkNCj4gPiArew0KPiA+ICsJc3RydWN0IGtmZF9wcm9jZXNzICpwOw0KPiA+ICsJdW5zaWdu
ZWQgaW50IHRlbXA7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAqIEl0ZXJhdGUgb3ZlciByZW1h
aW5pbmcgcHJvY2Vzc2VzIGluIHRhYmxlLCBjYWxsaW5nIG5vdGlmaWVyIHJlbGVhc2UNCj4gPiAr
CSAqIHRvIGZyZWUgdXAgbm90aWZpZXIgYW5kIHByb2Nlc3MgcmVzb3VyY2VzLg0KPiA+ICsJICoN
Cj4gPiArCSAqIFRoaXMgY29kZSBoYW5kbGVzIHRoZSBjYXNlIHdoZW4gZHJpdmVyIGlzIHVubG9h
ZGVkIGJlZm9yZSBhbGwNCj4gbW1fc3RydWN0DQo+ID4gKwkgKiBhcmUgcmVsZWFzZWQuDQo+ID4g
KwkgKi8NCj4gPiArCWludCBpZHggPSBzcmN1X3JlYWRfbG9jaygma2ZkX3Byb2Nlc3Nlc19zcmN1
KTsNCj4gPiArDQo+ID4gKwloYXNoX2Zvcl9lYWNoX3JjdShrZmRfcHJvY2Vzc2VzX3RhYmxlLCB0
ZW1wLCBwLCBrZmRfcHJvY2Vzc2VzKSB7DQo+ID4gKwkJaWYgKHApIHsNCj4gPiArCQkJLyoNCj4g
PiArCQkJICogT2J0YWluIGEgcmVmZXJlbmNlIG9uIHAgdG8gYXZvaWQgYSBsYXRlDQo+IG1tdV9u
b3RpZmllciByZWxlYXNlDQo+ID4gKwkJCSAqIGNhbGwgdHJpZ2dlcmluZyBmcmVlaW5nIHRoZSBw
cm9jZXNzLg0KPiA+ICsJCQkgKi8NCj4gPiArDQo+ID4gKwkJCWtyZWZfZ2V0KCZwLT5yZWYpOw0K
PiA+ICsNCj4gPiArCQkJc3JjdV9yZWFkX3VubG9jaygma2ZkX3Byb2Nlc3Nlc19zcmN1LCBpZHgp
Ow0KPiA+ICsNCj4gPiArCQkJa2ZkX3Byb2Nlc3Nfbm90aWZpZXJfcmVsZWFzZSgmcC0+bW11X25v
dGlmaWVyLCBwLQ0KPiA+bW0pOw0KPiA+ICsNCj4gPiArCQkJa2ZkX3VucmVmX3Byb2Nlc3MocCk7
DQo+ID4gKw0KPiA+ICsJCQlpZHggPSBzcmN1X3JlYWRfbG9jaygma2ZkX3Byb2Nlc3Nlc19zcmN1
KTsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKwlzcmN1X3JlYWRfdW5sb2NrKCZrZmRfcHJvY2Vz
c2VzX3NyY3UsIGlkeCk7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAqIE11c3QgYmUgY2FsbGVk
IGFmdGVyIGFsbCBtbXVfbm90aWZpZXJfcHV0IGFyZSBkb25lIGFuZCBiZWZvcmUNCj4gPiArCSAq
IGtmZF9wcm9jZXNzX3dxIGlzIHJlbGVhc2VkLg0KPiA+ICsJICoNCj4gPiArCSAqIEVuc3VyZXMg
dGhhdCBhbGwgb3V0c3RhbmRpbmcgZnJlZV9ub3RpZmllciBnZXRzIGNhbGxlZCwgdHJpZ2dlcmlu
ZyB0aGUNCj4gcmVsZWFzZQ0KPiA+ICsJICogb2YgdGhlIHByb2Nlc3MuDQo+ID4gKwkgKi8NCj4g
PiArCW1tdV9ub3RpZmllcl9zeW5jaHJvbml6ZSgpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICsNCj4g
PiAgIHN0YXRpYyBpbnQga2ZkX3Byb2Nlc3NfaW5pdF9jd3NyX2FwdShzdHJ1Y3Qga2ZkX3Byb2Nl
c3MgKnAsIHN0cnVjdCBmaWxlDQo+ICpmaWxlcCkNCj4gPiAgIHsNCj4gPiAgIAl1bnNpZ25lZCBs
b25nICBvZmZzZXQ7DQo=
