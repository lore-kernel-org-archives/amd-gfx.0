Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1C0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 10:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7EA010E53F;
	Tue, 12 Apr 2022 10:33:26 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B1310E0AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 10:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ak3F+xmooiZQX/r1c9HwVV0b/wVOVyabZpNakiSV9ovifdPZxC333eU1s8AYjziRm3SrBJXQd5BcopdZOwe5deC/qXdY3TnuRe0fUpE9FnPS53J9fRkmfgpcLHwO2x9ZeAYOABoJ137AhTk5sAXUTXHoPECO89E+kCvX1a8z3JL2cUxHhLYOuDCdN/Ka9cIxq+Ov2nDvXEsoh4lV9qX+XOCqZH0gRWBmP3CVRaCjO55s3x8Cpsbpdz01GZFMsoCZkgrWn1bVt5uM2T9LXlooru2INQawPHUbFn6uRz3c/FVOJXR3lfqXbS6XGyTPnSsLl/vvsEAluIWh89mD4NGQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Qckp7Lnr+QHxqDOLDfLMxqHlAuY+m8JQWbX84OWQrc=;
 b=ldHWdwLxS0mbWJjN//zmV8NUmM0Zre3sVJ49zrJAJPwUpuGRLhy53NcTnN5m7cGviBFH81QhQQ+P2xDIoJ+2WzD/BBMKlV17cQeprIJHh7STU8B1Jf/pVpUS076D59STdGOSasMwUDmiKE9vJ1Qdl6NBv1n2oJd341QqG3xvtU+ZIDcbjSHInzi2hAswTo+QueDuI71S2vSnswvQr7R2xw9rByj+fMKBjDeIv6YAB26KZGUmAil0dWm3ZIJLNi1ZxJCNjx39XtQWGBIFLnerche7EQoDOof/39nYzv6HfrsfbzAfTP730BLzRu4dr2CstnMKeUlzZM0qzsB0DWpxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Qckp7Lnr+QHxqDOLDfLMxqHlAuY+m8JQWbX84OWQrc=;
 b=gWFwucSEtSHL2CO6oXEUnz66SVvRoZ2x8yeRyPLRaLDjC0Js04YryaGaVjSY4JCsSyZ8QgYlXG/FzInRB0nSPon94nTMXyMMmHpiVga9ZIGBYvhReJ1Tni7fjjhxVu0geC3QZLOr1gk8k+sfE+QaB6aSpGIEIBCEPC45e5Fi4QA=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (13.101.97.49) by
 CH2PR12MB5001.namprd12.prod.outlook.com (10.186.136.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Tue, 12 Apr 2022 10:33:21 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::89e5:94d7:69f4:603c]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::89e5:94d7:69f4:603c%8]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 10:33:21 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Ziya,
 Mohammad zafar" <Mohammadzafar.Ziya@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1OiBhZGQgcG9pc29uIGNv?=
 =?utf-8?Q?nsumption_flag_for_RAS_IH?=
Thread-Topic: [PATCH 1/3] drm/amdgpu: add poison consumption flag for RAS IH
Thread-Index: AQHYTZSHO6LZJId0zEGItrUkSYoTFazqs1hggADl9QCAAHyT8A==
Date: Tue, 12 Apr 2022 10:33:21 +0000
Message-ID: <BL1PR12MB5334450A5DAC6DA90EBF7ED19AED9@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20220411110825.18808-1-tao.zhou1@amd.com>
 <BL1PR12MB5334047390308672B445C7559AEA9@BL1PR12MB5334.namprd12.prod.outlook.com>
 <DM5PR12MB17706C490CEA00BBD3DDB973B0ED9@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB17706C490CEA00BBD3DDB973B0ED9@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-12T03:05:55Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=08114bf4-abc2-4172-b902-c897ce91c910;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96c1304d-52f7-4c70-eaae-08da1c6fddd6
x-ms-traffictypediagnostic: CH2PR12MB5001:EE_
x-microsoft-antispam-prvs: <CH2PR12MB500184F9AD53B0D320C4415A9AED9@CH2PR12MB5001.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C24pEfMwygkoYLHlusHRSDoy3a4fOL4Y2EnhaWRbog+63whbCW2q3ROa+PSlMX/Ld3DCCGZWOo99Vgvw5latHpOhjm4V0lCuoJo5P/6K23+l7ygGq469xprcHrG5iV78hG+OwJUu/etHtgTIb3HOQ8YST5VFMVODeqHW4xG7FozAG73BpMJb8lJU/nlomczkB9Ru4lZ0eFi421GXwx9or3Ezrw/FHsmpvb7YnYbWZY1LSq+sWn5RZSfX5igjwSKf1yx3XXRKhPiWeOWzirP7ZhaMufHVFC+bua5mIf07EpEXtwACJ4KnqxlguHD6vGFg+AHWKpas230TN3ggxPVBgjwZU9o1AsXLu6XgkckEQLsy0nYllLlCXHcg2fHhYKcfPOjIP+TD61Wo1noyCXwxtD59Qsh9ZlMV6lWNmlKrOqkyVIkUUfcFbaEMKbZ3I751LrZXmJm0j+EnsyjOWFJlL3fvua0LWl/Rp+iMxKgSgBgUdxwW1Q+rl9SYaTEM9Fvu0OnkdiCbDxAlq/+v/IR7qPZBnOovVTAbdglQdH1Ne9DsKlg8pbQ4FgVLSLyGbEYl76PZocERkx3zMS24TQdn5IFaFcHLRFcp4J3iusoc1hbL58VQ85NBb5XOagQEDBxvQ2cTuxkBk8j5HHEWehmaYuuAaqe/DjpvDvda3qEeHfQjvZusMMDxfU6uHsIiualu6ni7cLv5zt84yHYKvomXIsDhoJN2F+t0TAyqPHzCrU4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(66476007)(66556008)(64756008)(38100700002)(53546011)(52536014)(55016003)(921005)(110136005)(66946007)(186003)(26005)(33656002)(6636002)(83380400001)(66446008)(316002)(122000001)(86362001)(76116006)(8936002)(71200400001)(9686003)(6506007)(2906002)(7696005)(508600001)(224303003)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0dDcVhsTW84OEtoUVNyaTNzZkZOU0o4WjRpeklZNGhlaDh6UFNkT28ydDh5?=
 =?utf-8?B?RXpCV3JNRE5tNXQ1QnltdjBObExXM2NVQXBGWEVlK2tJQnJ2eWsvN0dUSnNx?=
 =?utf-8?B?RTcwTEo5V0ZIc0w2R25SNmtDdjc3eWNmWDZFRTBVa1dtUnpkend3cEJBZFg1?=
 =?utf-8?B?TGUrSFNYVE90cDNhNFhTaEJscmFCVFFTNFVpUDVqYkEyTStRZTdWdHVVdzUr?=
 =?utf-8?B?ZVM1Q2VuUjI5VE9pU1VYb3R0TDhTVUEyTTl3ZXRvOW9udU1LMlduSG95SFRH?=
 =?utf-8?B?bmhidWR6eXZxcFJCUjE5UWRCMUxMTk9WMXNCTktlRno1aDFPSU5la0dJOHFK?=
 =?utf-8?B?aWlIRkVLZXo2VDNkM3RxMFF0L0RhNUYwc0x2b3pPREVtTG5BRmVpd3ZybGxL?=
 =?utf-8?B?Zk9maTZWSXFGRnE5eGY4cUp0UG1YcEEvMzRPNHFtZjFpTHU3ME1mK0pGOFlL?=
 =?utf-8?B?NUpKVkFIelhFck1MbCtVQnJ5UGV6a2tYQ09QZjJTSndRNmlqaVo3V0UvSmdQ?=
 =?utf-8?B?TFZjS3gydXJqdm1RdXc3QjlJTmNBbzVMQXR3TzdHTDFxcWFJT2hYS1Zzd0Rz?=
 =?utf-8?B?U3BxbkNOanphNWpyRWlQdjg1S0RJS1lJMENNdExPTmZQeHlRVEFrK3JLZGhX?=
 =?utf-8?B?SG9DYThxSU1OdDljVFdYWGtlSnpndHFUaU5BaDdlRmdOUUFMSWExRnRtcXBw?=
 =?utf-8?B?KzkzODIxR2d4cXgwaDBCWVY5SHU2OC92TFYzU2tsUzBqbmFobHdOaWdlWDBN?=
 =?utf-8?B?QnRpdFl3TmpVc2VjLzVIMU41cVB3OUxJN3gvdGpSVEtERnFqcDI0WStjSWMx?=
 =?utf-8?B?NmNKMVBEeFRmUWpwcWxRdGIyV1FOUDJpa0NPbGd5Qi91ajl6ajlZemI0T0F3?=
 =?utf-8?B?dXRHQkVMQkdUVEtNd0VQWHpheVRYNFRlVE0vSXIyckN4RVk5andobndNWG85?=
 =?utf-8?B?VmhqREFEYzdONTB0RzUrUW96R2ptaU1GVThTYStBWUNVb2FYYUNVTlQyZEk3?=
 =?utf-8?B?c0JTV3NFVG9XRmlpN3U0VTY5MUFXSEZBTU1GYzErK3ZhR2VHUVZvaUlFQVk1?=
 =?utf-8?B?SlpJVW1RbHM4clY2Y1l2NXBncWlnU2NreEhwMHRUVGdBTG9jVXlSamdYYyti?=
 =?utf-8?B?VnFnYXJOTSs4bU9HV21vbk51UVFKTy9jclNwdjFDL0tCZkdEc0s2Vmo1RnVP?=
 =?utf-8?B?R25NeUw0QStPckVrbHlKaFc1cjNpNkZ6U0t6UVRwemY0Q2EvQy9hUGZUT3Z3?=
 =?utf-8?B?VkRHYXNhdTJ6OWkzSGlqaEx1Y3Y2VThFSDNQK0YwelZ4ZUY5bjkzL1I0dHIx?=
 =?utf-8?B?MndaL1BFa1MyeWQ1Z2cxbVR4aStvUjljMEZpdUJud1JPeEtnZG5xQVc0ZFpi?=
 =?utf-8?B?cElyVzBIOEMycU4yOVdGOHpzcS95NHVRVDFnWnlrQWFCc21zbGdkTERjR1RR?=
 =?utf-8?B?Ung0NDA2QnZaUU1LWm9LTnNMM0MrelFpVjVFdWV4eEYvR2QxWUNyTzdsYWFY?=
 =?utf-8?B?Y3pFNFJNTktBTTBmaHcrOWVUZUF2dnVhb2Nmd0ZWbmk0RXlZaU1MelJ2UHow?=
 =?utf-8?B?WEN1cDdpNEJqb3oyOEJTcmpERExsMnNIZEk1MitxckJRK1FJM09WZkt0YldE?=
 =?utf-8?B?bWd1b0gvaUhSVGpoRDBuTHNPckpTQ2FucXBibDZBM0ZuOXBFV1gxUjdaQ1cr?=
 =?utf-8?B?S1RhUFo1QWtTUk5lQno2aE5qTHVmRlVuOWFNTTRvUEFvN0pHK1BhV1ViY2RI?=
 =?utf-8?B?aTV2emd5SThpb3BYdi9wT1R1NWtNQXVzem9BRm1ncWVqQWJ4ZEg2M2xZZEVr?=
 =?utf-8?B?bjQ3cllQQ0pEK081N1FyOGRsai9QSmtQSUVtUkF5ZmtlczNobXZnNVo4VUJo?=
 =?utf-8?B?SnBoVTk0VHMweG9TS3FyYlJZcEpmcDhLa1JweGpBQXpRRmlDdmdWYm1LWS8v?=
 =?utf-8?B?MVNHYm5selN5NGVEMURZSXR1K3JLRFdIMVdUQXhZdDR0WnBVQlJhQndhR0Zi?=
 =?utf-8?B?d09vSGhqTFBraEJyaUFqT3NneXFEdHZsZmViVWxiL0c2T0cvVkU1VklEcURZ?=
 =?utf-8?B?UExuWDRQUXBWcVhsTXcvTjhZOEovL3o0TTljYnpnQXJpOTZieG1DVVRxWElj?=
 =?utf-8?B?b3Z2TngwbURRN0VyNGYwN3N5TjhSaUJrN3B3VWQ0NzRKMloyUVV3dlliM0Nl?=
 =?utf-8?B?cHY0WVFqc0FVTXQ0a1JqY3N6dFJvTUc4VXdHM2ZmMEc3aUpCNzZibGRLWWtX?=
 =?utf-8?B?RE9ORFczdjB0WWdoWGxuVTZ1ZGRqYk5IWVRmcEhBdjZFQVV3dmFXSjdWdjhR?=
 =?utf-8?B?QXRLS09BeDlFeTZBWlNiZzVPdUQ5UnBObVAySEhTUXV3WHZuRnl6dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c1304d-52f7-4c70-eaae-08da1c6fddd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 10:33:21.2331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KLB0+EmS4O4RhzYtONqkZAhCLL0eHECtHT6fXtvckE1JCQ0AeGHUnes3PG/nLTVeJu1NAKYPWy00Yt7cr2o0pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5001
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

VGhlIHNlcmllcyBpcyBSZXZpZXdlZC1ieTogU3RhbmxleS5ZYW5nIDxTdGFubGV5LllhbmdAYW1k
LmNvbT4NCg0KUmVnYXJkcywNClN0YW5sZXkNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDl
j5Hku7bkuro6IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPg0KPiDlj5HpgIHml7bpl7Q6
IFR1ZXNkYXksIEFwcmlsIDEyLCAyMDIyIDExOjA2IEFNDQo+IOaUtuS7tuS6ujogWWFuZywgU3Rh
bmxleSA8U3RhbmxleS5ZYW5nQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+OyBaaXlhLA0KPiBNb2hhbW1h
ZCB6YWZhciA8TW9oYW1tYWR6YWZhci5aaXlhQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZw0KPiA8
SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgQ2hhaSwgVGhvbWFzIDxZaVBlbmcuQ2hhaUBhbWQuY29t
Pg0KPiDkuLvpopg6IFJFOiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1OiBhZGQgcG9pc29uIGNvbnN1
bXB0aW9uIGZsYWcgZm9yIFJBUyBJSA0KPiANCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCj4g
DQo+IEhpIFN0YW5sZXksDQo+IA0KPiBUaGUgZmxhZyBpcyBzZXQgYnkgUkFTIGJsb2NrIHBvaXNv
biBpcnEgaGFuZGxlciwgc3VjaCBhcyB2Y24vanBlZyBwb2lzb24gaXJxDQo+IGhhbmRsZXIuIEl0
J3Mgbm90IGNvbmZpZ3VyZWQgaW4gUkFTIGluaXQuDQo+IA0KPiBSZWdhcmRzLA0KPiBUYW8NCj4g
DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBZYW5nLCBTdGFubGV5
IDxTdGFubGV5LllhbmdAYW1kLmNvbT4NCj4gPiBTZW50OiBNb25kYXksIEFwcmlsIDExLCAyMDIy
IDEwOjEyIFBNDQo+ID4gVG86IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsgYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7DQo+ID4gTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1k
LmNvbT47IFppeWEsIE1vaGFtbWFkIHphZmFyDQo+ID4gPE1vaGFtbWFkemFmYXIuWml5YUBhbWQu
Y29tPjsgWmhhbmcsIEhhd2tpbmcNCj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47DQo+ID4gQ2hh
aSwgVGhvbWFzIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KPiA+IFN1YmplY3Q6IOWbnuWkjTogW1BB
VENIIDEvM10gZHJtL2FtZGdwdTogYWRkIHBvaXNvbiBjb25zdW1wdGlvbiBmbGFnIGZvcg0KPiA+
IFJBUyBJSA0KPiA+DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCj4gPg0KPiA+IEhpIFRh
bywNCj4gPg0KPiA+IEFjY29yZGluZyB0byB0aGUgc2VyaWVzIHBhdGNoZXMsIEkgaGF2ZSBvbmUg
cXVlc3Rpb24sIGlzIHRoZQ0KPiA+IHJhc19paF9mbGFnIHNldCBhY2NvcmRpbmcgdG8gcG9pc29u
IG1vZGUgY29uZmlndXJhdGlvbiwgaWYgeWVzLCBkcml2ZXINCj4gPiB3aWxsIGhhbmRsZSBwb2lz
b24gb25jZSBnZXQgZWNjX2lycSBpbnRlcnJ1cHQsIGJ1dCBhdCB0aGlzIG1vbWVudA0KPiA+IHRo
ZXJlIG1heSBubyBhcHAgdG8gY29uc3VtZXMgaXQsIHRoaXMgc2VlbXMgY29uZmxpY3QgdGhlIHBv
aXNvbg0KPiBjb25zdW1wdGlvbiBkZWZpbml0aW9uLg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBT
dGFubGV5DQo+ID4gPiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+ID4gPiDlj5Hku7bkuro6IFpo
b3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPg0KPiA+ID4g5Y+R6YCB5pe26Ze0OiBNb25kYXks
IEFwcmlsIDExLCAyMDIyIDc6MDggUE0NCj4gPiA+IOaUtuS7tuS6ujogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc7IExhemFyLCBMaWpvDQo+ID4gPiA8TGlqby5MYXphckBhbWQuY29tPjsg
Wml5YSwgTW9oYW1tYWQgemFmYXINCj4gPiA+IDxNb2hhbW1hZHphZmFyLlppeWFAYW1kLmNvbT47
IFpoYW5nLCBIYXdraW5nDQo+ID4gPiA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgWWFuZywgU3Rh
bmxleSA8U3RhbmxleS5ZYW5nQGFtZC5jb20+Ow0KPiBDaGFpLA0KPiA+ID4gVGhvbWFzIDxZaVBl
bmcuQ2hhaUBhbWQuY29tPg0KPiA+ID4g5oqE6YCBOiBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1k
LmNvbT4NCj4gPiA+IOS4u+mimDogW1BBVENIIDEvM10gZHJtL2FtZGdwdTogYWRkIHBvaXNvbiBj
b25zdW1wdGlvbiBmbGFnIGZvciBSQVMgSUgNCj4gPiA+DQo+ID4gPiBTbyB3ZSBjYW4gZGlzdGlu
Z3Vpc2ggUkFTIHBvaXNvbiBjb25zdW1wdGlvbiBpbnRlcnJ1cHQgZnJvbSBVRQ0KPiBpbnRlcnJ1
cHQuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQu
Y29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jhcy5oIHwgNyArKysrKysrDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmFzLmgNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jh
cy5oDQo+ID4gPiBpbmRleCA2MDZkZjg4NjliODkuLjM4MGY0YzMwMjBjNyAxMDA2NDQNCj4gPiA+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaA0KPiA+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oDQo+ID4gPiBAQCAtMzE0
LDYgKzMxNCwxMSBAQCBlbnVtIGFtZGdwdV9yYXNfcmV0IHsNCj4gPiA+ICAgICAgIEFNREdQVV9S
QVNfUFQsDQo+ID4gPiAgfTsNCj4gPiA+DQo+ID4gPiArZW51bSBhbWRncHVfcmFzX2loX2ZsYWcg
ew0KPiA+ID4gKyAgICAgQU1ER1BVX1JBU19JSF9QT0lTT05fQ09OU1VNUFRJT04gPSAwLA0KPiA+
ID4gKyAgICAgQU1ER1BVX1JBU19JSF9MQVNULA0KPiA+ID4gK307DQo+ID4gPiArDQo+ID4gPiAg
c3RydWN0IHJhc19jb21tb25faWYgew0KPiA+ID4gICAgICAgZW51bSBhbWRncHVfcmFzX2Jsb2Nr
IGJsb2NrOw0KPiA+ID4gICAgICAgZW51bSBhbWRncHVfcmFzX2Vycm9yX3R5cGUgdHlwZTsgQEAg
LTQxOSw2ICs0MjQsOCBAQCBzdHJ1Y3QNCj4gPiA+IHJhc19paF9kYXRhIHsNCj4gPiA+ICAgICAg
IHVuc2lnbmVkIGludCBhbGlnbmVkX2VsZW1lbnRfc2l6ZTsNCj4gPiA+ICAgICAgIHVuc2lnbmVk
IGludCBycHRyOw0KPiA+ID4gICAgICAgdW5zaWduZWQgaW50IHdwdHI7DQo+ID4gPiArICAgICAv
KiBpbnRlcnJ1cHQgdHlwZSBmbGFnICovDQo+ID4gPiArICAgICB1bnNpZ25lZCBpbnQgZmxhZzsN
Cj4gPiA+ICB9Ow0KPiA+ID4NCj4gPiA+ICBzdHJ1Y3QgcmFzX21hbmFnZXIgew0KPiA+ID4gLS0N
Cj4gPiA+IDIuMzUuMQ0KPiA+DQo=
