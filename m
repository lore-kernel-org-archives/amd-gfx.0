Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1E8C7618A
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 13:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E6910E03B;
	Mon, 20 Mar 2023 13:36:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E4410E047
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 13:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2M2phOpxyYe8Mv4nR80d0URUVbxVlAGPPcP5Uf50x6gTVffVS5XV3eoqHTcUtfV9vqha9AjNM7Uw5xYDaP736XzWol71zvF77HoxGlIkKfwRbOZ79ZKwlQ/WJAlaL/kH6vDwgfbisdHmbcA9Aw3Te87lq6Cz9NTbCFfK8jMcqbQYq0XqPqtYwj3M4I9yhED3IrKUneLMKSIY5dGJXShcVjSdOMOrXlkRruPBHMETsMKPufMYt6KoLNkr3OWHbdN9ZVGk+gsFnEroho4z/deRxHXBl825e7H8e8aLx//OVg4zvgnrSISmsHF2Bh+QAKr6/RS9KH8sySiaJJjkhxKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLu8ao4XnnHEAWki6awdwvIq2EhdNDbiJF0JDx8E5tE=;
 b=Od3SvwG5Qf/Eb0ajgfB/DHLmaAw38i4rKpAGGZ6SENHxxJqpCgiD9QIJCSiXNDhMmUlEE5PdRGfW1QtsYiFmzXpiBy7hy6Z9id8p20a7ElHT8xCpueelEwgcS3o/bHmE0KUI1d89lGFItRDFK4TW9bxLnF1hU7eL6mHH+8No+Z5CgJlciQXhaU8Yi9+QAUalnLHImYV/TxZgqt9QgoPdExKecyyJpaw+JVJeGjQR84K547jwmPhcc5b8ZvTa3GlxZqmlqDc95tG2PKNbEsy++SXR8fwD0KPpLN0hXjIl/hDYGH/5RWqCEvd50dMpNpeg1TyKL6Bj1rUj06V4Zb48UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLu8ao4XnnHEAWki6awdwvIq2EhdNDbiJF0JDx8E5tE=;
 b=YF/KdZkvtu6ndiGswppUxu/V01lR4sSLIafJh2WeFq2+gAFTlJW7ybEXI2gxeizPfCL2cDu5wOxKwRrYoRSAOEfrvm8EVHz1SyqmpYB0rMeThYkSUrCAs7JAyZJVMH82SLTaNska3iV68qkG9oTEDcPAn1l4uHlWFJiR0rXwrm0=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by SJ0PR12MB5437.namprd12.prod.outlook.com (2603:10b6:a03:302::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 13:36:17 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::4d0e:a57d:65d0:1e63]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::4d0e:a57d:65d0:1e63%4]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 13:36:17 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Russell, Kent"
 <Kent.Russell@amd.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add print for iommu translation mode
Thread-Topic: [PATCH] drm/amdgpu: add print for iommu translation mode
Thread-Index: AQHZWQl3ZeT22psvKEmGWALdAzvmSq7/Y3MAgAAABwCAAACckIAAFUiAgAQ2BVA=
Date: Mon, 20 Mar 2023 13:36:17 +0000
Message-ID: <DM6PR12MB3067B4EED61835871BEEF4398A809@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20230317194757.1336098-1-Graham.Sider@amd.com>
 <0509601d-8d7c-26e2-26c9-8f4757a92ca2@amd.com>
 <DM5PR12MB1308BF656CB0C75BA0B9CED885BD9@DM5PR12MB1308.namprd12.prod.outlook.com>
 <DM6PR12MB30674A9D4B81185DA913A2278ABD9@DM6PR12MB3067.namprd12.prod.outlook.com>
 <b04e5657-9f41-204e-7b83-acbcfc462fe5@amd.com>
In-Reply-To: <b04e5657-9f41-204e-7b83-acbcfc462fe5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-20T13:36:15Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=fa1c8b65-dfb7-49f8-a322-dc8e1e013f56;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-03-20T13:36:15Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: d9914a25-40ef-4e39-b29b-0ccbdbb150ae
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3067:EE_|SJ0PR12MB5437:EE_
x-ms-office365-filtering-correlation-id: 576b8c35-41d6-4a0e-7973-08db29481561
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nu8p4V+LMPFY88jSINI86osBKIW9fMUJuBp6Txx4UX8c/8K7paGORHSw/FDrRjzGBV185zE+OgKLoM1V0ABXt2K892BqErCxORvdWv8BY0/UzWnZlMIQZwg80XBvjHdtINLeKzOwl/v8Hp2skF5HPhAGO7qo0ZFUXqU/JRX8+hXh9ueO2Ha4F0bTza+p0RL5vJ+gimqllcMYUkoRHw8NQYwWW/jf2UHQavMdEIV1qUbHlR8vcBHyAYKGi/KMZ5Ly+WMYZAT7VhLClTQCMcqf42xYuDfRYRzLnu0W9Xf0YpItpF8Vt6vlDLBtCs/fsk1XkmCGOz2k8tdG5ML4D9hPRYGyBdvJ2pEqJAKAxnLG+LZseb6F+BexqorwrF57oNMtFaEOiiaT1JurlhvIrf9+8MPzIKr3z02c84Mec2qv3l1UR1uj4yOyxuSGVyONDWBLyODnh2GyQtZbexkKidQuelaEbTqK40ZAO+CSevJ7r4whsAA6wrCPqKSLVNgS+Z4FhCzI9ZvEd1jxV2rVVuUy2h5TbbWIwobpu/EUkC42Nb0H4csOBN/9T+hN248a0hc6N+H6A0BbAOapqhdpvnCJI/n0koeI5srrwNAh7XNDip30pkgImYoAB6lxOfj3cffjbT4QdGxZwZE1RvK7rvTG/xuzaS1nmf7hOaGpcV/3/WQxMjrQmQ5IvGb/uJCXRJHZovzwYmiceJOOOJbCSzBEGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199018)(7696005)(478600001)(71200400001)(83380400001)(316002)(8676002)(66446008)(66946007)(66556008)(76116006)(66476007)(186003)(9686003)(26005)(6506007)(64756008)(53546011)(110136005)(5660300002)(52536014)(41300700001)(8936002)(122000001)(38100700002)(2906002)(55016003)(86362001)(38070700005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0psYzMybTJPQkJuOTRlWE8rRmhwVnlPamR2OE1NQUxONnRwNGZpa1p5Ym9n?=
 =?utf-8?B?bkJ3Rmt4dmpwQlZNOVEvUUxSSy9renB1OS8wNmNiL0dFU0oyZ0JFdUtWRUVB?=
 =?utf-8?B?Y3ZrNWxWZGFtNmN4MmpVSER0eUplSEliMGJwNms0eVJrY29MdHlVYkwrMUFt?=
 =?utf-8?B?Q1FUbjhHdEJqSVdaV1psUjVFbTRQQ3ZzQzNJdFNFajdWaE5XWE40SzhCNHNz?=
 =?utf-8?B?N3d1Yk9RbnVkQWpVSTFnWTdSUGNPVDN0YzZxWm9rdVBMZVFpWVJsRHZZZkJJ?=
 =?utf-8?B?NktzZ3hGS3Q4dFUxY1J0bFVyeCs5M2VnK2FPV2dvVTNXWVRZUGNkbUlQYk5l?=
 =?utf-8?B?dXNYMXpsaUFFeTNxMW5MeDFQR2RkWkZyYnlFQWdQd0pWdk1WKzJ3WEtiU0ps?=
 =?utf-8?B?WEpsQ3JjQzRnMHJYSkFuVkpEYnQvbmJMMlRraWtBLzdtZzN1NWhWdnB4WURT?=
 =?utf-8?B?NUI3VnBDcGwxMG96cytZankyc3YrZmxibVNzZ0MwdFpVQjFtWTZNSzVxQUpN?=
 =?utf-8?B?RXF5RlNSeUNBcXNPbWhha0xFall4dGdKTG9hYU42T1UzaXBEVFFwK2JSQkUv?=
 =?utf-8?B?YmN3S0F4YUFIMkx2aHR3MExMTmJlOE9uTUFaTTNPZk96TDlJbURrUW8xYStI?=
 =?utf-8?B?VkpiU3c1eERuVGRzQ2pnNHE0T3NpVStUVlgwc25LdkgyeGF6bkg0Y3AyR0xt?=
 =?utf-8?B?U2VkNkJTaDBVbXY0THVyLzByd0U2d2R3M3IwZnNaM3pJNktCUUFHR1Q0OWM4?=
 =?utf-8?B?bnAweldXZE9UNUFIVG1helpYeXNzYWdHdkhsTDVYMDFMR01jckowVlpLTVNZ?=
 =?utf-8?B?eU5TTDlDdnJjMUwySHVNVGxEQytIYUVPenZDUTVrZmEvMThLdnlIK05QRFVm?=
 =?utf-8?B?VVpXTXdWbE9VS25jSEJrQ3lZZ2ErT3lYRjdhcHhHREdNV3doMm10bWxnNEw4?=
 =?utf-8?B?U0l0SnB3cWZsdHE3RmhqbHRORE54aWlZRDRrTy9BRnk0OWQxbjFCbmJud3B0?=
 =?utf-8?B?YXdjUk95L3BGbEJXeEg2T3ZxM1ZwN04velo3NkdCWWVuSW5tUUtmTXgxdkFx?=
 =?utf-8?B?d2grcjg5dzJoS0pTcERpVVJheHNjb3FKMHlVSm4ySTlYNkNFK1dmZk41UW9x?=
 =?utf-8?B?cC9uTmhqQ3VmVjZiYzB0L21sZTFVbDBtS3ErS1UzWXA0NnFhMyt3ajZrOXBh?=
 =?utf-8?B?SHdzaFF6eTlEdGxhTjNBVWx3a3JvS21kMkVTNlRkUTNWMmNac1NFT3g0c0RP?=
 =?utf-8?B?dW1nWUxDZzhhTWZ3MDdteThmSUhIaHhmb1h6RCtsc3JzVmF0bHdBcUg5c1o2?=
 =?utf-8?B?WTd6SktOWEJRWWZwaW1qNGtBK094d3ErWHRSbU1LakVSdXlJcmhCd3N5enRN?=
 =?utf-8?B?SGl0ZDkwUGxYWXJ4cHNLemUrcDR4MU00S2xJWUthYjJuZ1FHMXZYTE5zYnZH?=
 =?utf-8?B?WTExeVJYbHBjSUI2WkNBWjFYakdDR0lLRFJhT2FDajh0b1BKSkJkS0Y2dG5X?=
 =?utf-8?B?MVdqdmQ5RWI5MXlWS0l4YWphY1ZUdjNYaktBemF1aTd0M1RUMHZEVWY4QlIr?=
 =?utf-8?B?TGhVTmtwYjRrZkpjclE0VGpQb2xteFVCQlFpQlBLQUcyY005UlAzVFZGQWxZ?=
 =?utf-8?B?L0VkZ2QyeDUrNlAxeVJLV0ZWMDNKWmRmM1ZLSm1DVjBzZUF1aHhQTU5DZERv?=
 =?utf-8?B?OHBCbFZzUExVYXV3eWdZaEZFSVZCdXllcWlRZHBFS2UzRk9VdkQ1azZVNmtu?=
 =?utf-8?B?aVFmSkdKejlXV0hGNDI1a2hiWVRBbGNySTdOVXVIckdLOWJEWC9hdEhqancy?=
 =?utf-8?B?bkdqbU02cjY5Z2Exa09YWmhwamU0bnpiaWNIWEsyWnd0WHV2SVQ5UEdQWHNE?=
 =?utf-8?B?ZDZoL3hRcnVjaWdPdHFESjBadGRXNnBxWTRrMmpiWlNENlRxbzNaa1BHUmVB?=
 =?utf-8?B?cVdPeWRsUUVLSmd2N0Y1aEMrV2w3VzVQNUZBSGQzMWliRmJ5bDViRDNpYzU5?=
 =?utf-8?B?T0FNanF4ZDNzL25HVGpoQUtSNHFyYTBjUmpmd0dCWVJCa2RlcnFDK244Q3JP?=
 =?utf-8?B?dG5VOXpWUDhHNWJXTS9NcXR5L1pQVDVzTVNqakIxUGUyK1JwcnJiemRyMW5x?=
 =?utf-8?Q?CAAM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576b8c35-41d6-4a0e-7973-08db29481561
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 13:36:17.5682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6w10TN+NUGYq5rZeHRdeNGEhZgdr4YZd7ocKbbDZBm9NTtVTJmbKC/hDM8H2jKY4QXTxZH1oCdqC6/8LYBhZnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5437
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGlu
ZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2gg
MTcsIDIwMjMgNToxNiBQTQ0KPiBUbzogU2lkZXIsIEdyYWhhbSA8R3JhaGFtLlNpZGVyQGFtZC5j
b20+OyBSdXNzZWxsLCBLZW50DQo+IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT47IE1haGZvb3osIEhh
bXphIDxIYW16YS5NYWhmb296QGFtZC5jb20+Ow0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBhZGQgcHJpbnQgZm9yIGlv
bW11IHRyYW5zbGF0aW9uIG1vZGUNCj4gDQo+IE9uIDIwMjMtMDMtMTcgMTY6MDQsIFNpZGVyLCBH
cmFoYW0gd3JvdGU6DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+ID4N
Cj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFJ1
c3NlbGwsIEtlbnQgPEtlbnQuUnVzc2VsbEBhbWQuY29tPg0KPiA+PiBTZW50OiBGcmlkYXksIE1h
cmNoIDE3LCAyMDIzIDM6NTggUE0NCj4gPj4gVG86IE1haGZvb3osIEhhbXphIDxIYW16YS5NYWhm
b296QGFtZC5jb20+OyBTaWRlciwgR3JhaGFtDQo+ID4+IDxHcmFoYW0uU2lkZXJAYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+IENjOiBLdWVobGluZywgRmVsaXgg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+ID4+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9h
bWRncHU6IGFkZCBwcmludCBmb3IgaW9tbXUgdHJhbnNsYXRpb24gbW9kZQ0KPiA+Pg0KPiA+PiBb
QU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gR2VuZXJhbF0NCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4
LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4gPj4+IEhhbXph
IE1haGZvb3oNCj4gPj4+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMTcsIDIwMjMgMzo1OCBQTQ0KPiA+
Pj4gVG86IFNpZGVyLCBHcmFoYW0gPEdyYWhhbS5TaWRlckBhbWQuY29tPjsNCj4gPj4+IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+PiBDYzogS3VlaGxpbmcsIEZlbGl4IDxGZWxp
eC5LdWVobGluZ0BhbWQuY29tPg0KPiA+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdw
dTogYWRkIHByaW50IGZvciBpb21tdSB0cmFuc2xhdGlvbg0KPiA+Pj4gbW9kZQ0KPiA+Pj4NCj4g
Pj4+DQo+ID4+PiBPbiAzLzE3LzIzIDE1OjQ3LCBHcmFoYW0gU2lkZXIgd3JvdGU6DQo+ID4+Pj4g
QWRkIGxvZyB0byBkaXNwbGF5IHdoZXRoZXIgUkFNIGlzIGRpcmVjdCB2cyBETUEgbWFwcGVkLg0K
PiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogR3JhaGFtIFNpZGVyIDxHcmFoYW0uU2lkZXJA
YW1kLmNvbT4NCj4gPj4+IElmIHRoaXMgaW5mb3JtYXRpb24gaXMgb25seSB1c2VmdWwgZm9yIGRl
YnVnZ2luZyBwdXJwb3NlcywgcGxlYXNlDQo+ID4+PiB1c2UNCj4gPj4+IGRybV9kYmcoKSBpbnN0
ZWFkIG9mIHByX2luZm8oKS4NCj4gPiBJdCdzIHVzZWZ1bCBmb3IgbW9yZSB0aGFuIGp1c3QgZGVi
dWcgSSB3b3VsZCBzYXkuIEp1c3QgYSBxdWljayB3YXkgdG8gZ3JlcA0KPiB3aGV0aGVyIElPTU1V
IGlzIG9mZi9wdCB2cyBkZXZpY2UgaXNvbGF0aW9uIG1vZGUuDQo+IA0KPiBJIGFncmVlLiBUaGUg
a2VybmVsIGxvZyBvdGhlcndpc2UgdGVsbHMgeW91IHRoZSBkZWZhdWx0IElPTU1VIGRvbWFpbiwg
YnV0IGl0DQo+IG1heSBub3QgbWF0Y2ggdGhlIGRvbWFpbiBhY3R1YWxseSB1c2VkIGZvciB0aGUg
R1BVLiBXaXRob3V0IHRoaXMgbWVzc2FnZQ0KPiB0aGVyZSBpcyBubyBlYXN5IHdheSB0byB0ZWxs
IGZyb20gYSBrZXJuZWwgbG9nLiBUaGlzIHdpbGwgaGVscCB3aXRoIHRyaWFnaW5nIGlzc3Vlcw0K
PiBmcm9tIGxvZ3MgcHJvdmlkZWQgYnkgZXh0ZXJuYWwgYW5kIGludGVybmFsIHVzZXJzLg0KPiAN
Cj4gDQo+ID4NCj4gPiBHcmFoYW0NCj4gPg0KPiA+Pj4+IC0tLQ0KPiA+Pj4+ICAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDYgKysrKystDQo+ID4+Pj4gICAg
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pj4+DQo+
ID4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYw0KPiA+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMN
Cj4gPj4+PiBpbmRleCA4YmJhNWU2ODcyYTEuLjg3OTdhOTUyMzI0NCAxMDA2NDQNCj4gPj4+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPj4+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPj4+PiBA
QCAtMzUyOCw4ICszNTI4LDEyIEBAIHN0YXRpYyB2b2lkDQo+ID4+PiBhbWRncHVfZGV2aWNlX2No
ZWNrX2lvbW11X2RpcmVjdF9tYXAoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYpDQo+ID4+
Pj4gICAgCXN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbjsNCj4gPj4+Pg0KPiA+Pj4+ICAgIAlk
b21haW4gPSBpb21tdV9nZXRfZG9tYWluX2Zvcl9kZXYoYWRldi0+ZGV2KTsNCj4gPj4+PiAtCWlm
ICghZG9tYWluIHx8IGRvbWFpbi0+dHlwZSA9PSBJT01NVV9ET01BSU5fSURFTlRJVFkpDQo+ID4+
Pj4gKwlpZiAoIWRvbWFpbiB8fCBkb21haW4tPnR5cGUgPT0gSU9NTVVfRE9NQUlOX0lERU5USVRZ
KSB7DQo+ID4+Pj4gKwkJcHJfaW5mbygiUkFNIGlzIGRpcmVjdCBtYXBwZWQgdG8gR1BVIChub3Qg
dHJhc2xhdGVkIGJ5DQo+IA0KPiBVc2UgZGV2X2luZm8uIFRoYXQgd2F5IHlvdSBjYW4gdGVsbCB3
aGljaCBHUFUgdGhlIG1lc3NhZ2UgYXBwbGllcyB0byBpbiBhDQo+IG11bHRpLUdQVSBzeXN0ZW0u
DQo+IA0KDQpHb29kIHBvaW50IC0gd2lsbCBkbyB0aGF0LiBUaGFua3MhDQoNCkdyYWhhbQ0KDQo+
IFJlZ2FyZHMsDQo+ICDCoCBGZWxpeA0KPiANCj4gDQo+ID4+IHRyYXNsYXRlZCAtPiB0cmFuc2xh
dGVkDQo+ID4+DQo+ID4gVGhhbmtzLCBteSBrZXlib2FyZCBrZWVwcyBza2lwcGluZyB0aGUgb24g
dGhlICduJyBrZXkgbGF0ZWx5IDooIHRpbWUgZm9yIGENCj4gY2xlYW4uDQo+ID4NCj4gPiBHcmFo
YW0NCj4gPg0KPiA+PiAgIEtlbnQNCj4gPj4+IElPTU1VKVxuIik7DQo+ID4+Pj4gICAgCQlhZGV2
LT5yYW1faXNfZGlyZWN0X21hcHBlZCA9IHRydWU7DQo+ID4+Pj4gKwl9IGVsc2Ugew0KPiA+Pj4+
ICsJCXByX2luZm8oIlJBTSBpcyBETUEgbWFwcGVkIHRvIEdQVSAodHJhbnNsYXRlZCBieQ0KPiA+
Pj4gSU9NTVUpXG4iKTsNCj4gPj4+PiArCX0NCj4gPj4+PiAgICB9DQo+ID4+Pj4NCj4gPj4+PiAg
ICBzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZSAqYW1kZ3B1X2Rldl9hdHRyaWJ1dGVzW10g
PSB7DQo+ID4+PiAtLQ0KPiA+Pj4gSGFtemENCg==
