Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC92C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 21:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DBDD10EB81;
	Mon, 25 Apr 2022 21:29:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64BDC10EB81
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 21:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZbqs6YjafhTdcJyAbPdZi1oq4JtkVEtOMh01Ola+EpYrVjlBlNbdaFjMjGHHZEqk7N2dA5kN8sMf2ntfyGY+CkH8BelqHtEtopMNnKRDqVHDt5JTqbJZC0IfOuTm5mSEePxXpS2kiaSqSM0ZUyZantPsXEI5kd4NwjZw3Hbhm4FovP3k7wmH0G3O+ggxxoejV2qbOAVpEQzqCeIjKTjUCrDV4mcNehfRnw6wAvR4GlIefEO8W+jTiC//Uyp5msRVimUAVT+EsEq3SsuW1SgkKO74tWJ9c3S/AOHttxA0StTQBefU+L/H3VYsZLef0PxMxac2sI9uaUMNF3KFcmLuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiYrMcETl7OKx3nJbjBbjnS8qY06VOrQG4IbWaHtt9c=;
 b=Ixv5pTL+TaM/X11hlWoUTH6xnjJCm+NgmwVzNEGAoWST+XvXCORCjXJ8Vx6nwZDrOAE+AyHQVluPD+6ZtKSK9/sxl5mX5oNPazvNhHGYlP0SB0Aj8flniHxpwRFqNtt0afuLsVpwUP0zP57s0VQU3zsoZLEjMmQt4UsvPabIthl47q7klFCToIZYGropziLzfx0hB7ihgOI2kpdc4Wxsg2uUr41fb2Kc6H42Du8JTvYn4/Lbbk1ebz6V+gvItTFZs/p2VyIgdcbN6YJaeLm8zn3zHt+R1+ClWV9FWAqZPNjK3oX277GfasvQINOPggtUnGzDlyzWYVm6obWEfQieZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiYrMcETl7OKx3nJbjBbjnS8qY06VOrQG4IbWaHtt9c=;
 b=IZ8i+dfa3vWBDhHA9dyJw7vSHTZkkl51YahDUObJi5XOblvwhWaUfRxR9X0UO+W4k98VyLCWsRUxkVMo7zmu/GAzPSfIbq1LHWP3lYlfbxFbDZ+ZfEn2cXNEJtSAI/UQdDTf819vFCVwhFv22MWaKm1Zxp3tgxow0xY/uolMWqg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 21:29:54 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::98b8:8b06:2069:c838]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::98b8:8b06:2069:c838%7]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 21:29:54 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Demi Marie Obenour <demi@invisiblethingslab.com>, Thorsten Leemhuis
 <regressions@leemhuis.info>, Greg KH <gregkh@linuxfoundation.org>
Subject: RE: [REGRESSION] AMD GPU regression in 5.16.18..5.17.4
Thread-Topic: [REGRESSION] AMD GPU regression in 5.16.18..5.17.4
Thread-Index: AQHYV7oTRHZN/gZjhEin6YJC50vcIqz/uW6AgAFs3zA=
Date: Mon, 25 Apr 2022 21:29:54 +0000
Message-ID: <BL1PR12MB5144A5433CD3495A3B74F30AF7F89@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <YmQi7ajZpZ4W7BJL@itl-email> <YmQkCXZEqp6TKrhJ@itl-email>
 <YmTqYkGEqiz1o2o6@kroah.com>
 <e1950610-ba09-7c42-4a1a-152ad41015b5@leemhuis.info>
 <YmXfqrktdufyYC4r@itl-email>
In-Reply-To: <YmXfqrktdufyYC4r@itl-email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-25T21:24:50Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2521ad25-2303-4904-9a17-7f712b69d602;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-25T21:29:52Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 7d31d3db-ad5d-4e50-9f40-ae6157e1b8a4
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29533aab-9b57-4cad-f3bf-08da2702bd10
x-ms-traffictypediagnostic: BYAPR12MB3285:EE_
x-microsoft-antispam-prvs: <BYAPR12MB328563A80812B5655B4B4497F7F89@BYAPR12MB3285.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ciEul3crv6M36tVPTMpf8wcYGn52ktNVntsZ5AqqENSVZrOVOMYv3z9OkDy0sI1y/Vffe5UT2wNyvRbj9+RRjc+DGayu5HBEt7wE4iUz7jBgmHzLVNMp42GkbKzjg58DDi7mpzftyh1T1VibtQbk9ldeAoK9+p7fQK8It5bM9MGDit+fmrUwc1GQeHHxThtE0wpey5qhgwl76/WAFsFn8P5rhH8nlxZKfntGvrdP/4PpE1Qd6Uq72pdC9uqQgGUQlE+CLVJmnB2Qe73KVM9+Fyh8wv+PMju+OFxHPc7JSZZAEOQgbk/7Horc/lKllPVmHFLy0Fz38ogW2yXkERFUDHo3tcdEE9s0//Dye1NY3QlqOxVWuDPavqyDBkfcx1EoYqjjawE86FquVnyAOMCfX25N7XiQhOcVOask+jCbszmEFA7Bt+q+joqGPsetO9e1Xu7PwKl2uaou5H7mqPLbRkBJAL8TTTZppom55nEgm4tlrkcQx6D22+q9BYiK1p4KU4DyJLlr35mwqVBHt7WIGEccIE09Xw0+GxFx//Kq+baJ8NKhPXh9IP5Jcb2ROYKfkgHWkrpSKnJO9oX+456iOikvWjorEaqjbiDpAk7Et836eSGZFAnfdFsbSJVOjep+YZmsP4hl4Do64FIeyCES7sC/k1/jXOfG144swlHnz0xQl7D/rr74sFTHzf29DP01n60zLQz2HlJLIeGdW+nAShKSN+hJPr1L2uuxIhj4lR4yRUVqrZx0H657MVAXkyDlaTKNBQC9gmpQ+uni86dyERFbsftjenw7kmnmGA5cBikfpYwcALs3PJod8syEvCAdei6X5oDSRAU1K97+QBB9wnv96WzqPHdatge7iG902Sc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(4326008)(8936002)(83380400001)(66946007)(8676002)(316002)(55016003)(966005)(86362001)(122000001)(508600001)(2906002)(110136005)(38070700005)(38100700002)(64756008)(66446008)(66556008)(66476007)(5660300002)(186003)(54906003)(71200400001)(76116006)(53546011)(26005)(6506007)(9686003)(7696005)(33656002)(101420200003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0xFak5mc0RjeWErM0ZGSzJEZXF4WC92UUQ1c1JPNWFVS1d6Y1cxVjU0Tndh?=
 =?utf-8?B?VUx5bUZ2QXRhbXh1Y0xBYkRXZmM0dnl5WERwUzV2NEI3YmkraTdWNGlrVi9q?=
 =?utf-8?B?R2J2TmFWODZrR2FpL3JwVyt3SjAvZHFXMVdiQnVaSFM0L1pUbFdNcVVrcDRE?=
 =?utf-8?B?bDRYL2hnd1FXM3Roc1ZubTJPYUV6WDBmdFB6Z2UrTVdkYnRKTHRmRjZMTERi?=
 =?utf-8?B?N09vWE1xeWFvNlNORVR0aEUvZUFHREVBaXdUelpOUUx4MXd4TkEvQkNGMlpD?=
 =?utf-8?B?Y3VvUURpMXB6NjdOdWtsWnNVaWExZVdhRnRDQVVnWXBQdTlSYTJEeWJSMWMz?=
 =?utf-8?B?TStBZVI1Z1lnVS82ZFVVOUwvWDMxL2VkWDZFUGtodFpwWS9PMmw5NmdEazlX?=
 =?utf-8?B?R1lvS3I4UC8xUjQzUE9HZzNsVGxpcnJscnVHL21YdmhhQ0NMNVVrcERMdk9a?=
 =?utf-8?B?dlF6NDkzNVB2OTZlckNHYysrM3RUM05saGhaeHE3OTNjakdYTGZ1TkJUK29x?=
 =?utf-8?B?UEZwK2tyOVlWcGdYN1kzckdEQ0dLRnFXQUI5ckVtRXd0YXdJZ0VNLzRHTlhr?=
 =?utf-8?B?TCtxQmd5SHNEZlZXQmpPTk91bmtXK0N1TDlLNHpVTHV1ZkkxVUpCUXplMElu?=
 =?utf-8?B?VDIrazhrVHBOY1BETHZaVllHeE9sY01DSUFLeDQ0dU1GNXc4SmJMYmJ5UTJ3?=
 =?utf-8?B?UGl5aUtZSG1IOEF1NENKWHlZTlB3NHcyT3J0Y3d0NTVrRWVCcHZTSjNhMkdZ?=
 =?utf-8?B?Zk5ZS0luQXlLZHhIdm5lcTJGbnVlWFB3dHhOaExzeFZVbzBSckcwU21zL1Z0?=
 =?utf-8?B?WGFBODZXYjJFV0NIUC8xRDJpeDdoOVdmbTZyeVYxRWtxU2JhWi9ZbC9RTWhX?=
 =?utf-8?B?cDltRHlnQU5QbHFjZWpaMUpmSTZ0RnhORitMQ0xyVklkZlk5NVplUUdNaUxs?=
 =?utf-8?B?VXAwZnorNVpTRk1mYkdIeDdGeUpCbE5HMTg0SWFkcnBoWUUrU1hJcVlHVmRJ?=
 =?utf-8?B?ODVlNFlVWFZCSjVXaThPdkNhUmJNb0k3ME0ybkVUaDdvSmpVMnNId3BBalpl?=
 =?utf-8?B?cVlhWXRTQ1F0aTJqNE1wSUNoT3UraG9QbS84eDlENnUwUmN6cHNHamRvbmNp?=
 =?utf-8?B?ZFF0dVNEWE5JUHV4Z2orSVM3WHpBNEptdlNVY2EwdGJnRkpicVRWSGpIL2ZF?=
 =?utf-8?B?dEJUaDVOYmd6WUdLamJra29ZcFd1eUp3NlI0K3ZydHhyUmtsNDErUFh5eXZq?=
 =?utf-8?B?ZmVweVRUdlNncytmWE93d0tsT0FJOGpZZ0FKemlYbTNTYkRaREN0ckhzanlL?=
 =?utf-8?B?M0xQUW9CS0FZY3Vnc3p6R2daajUwUCtuNGRLMHExS3J5SmVFbWlVYUJHTlpH?=
 =?utf-8?B?Qzc5cHViQTVETTBJMW9SSjRGSHVvOHJEOWxPMFBCaEY0U21WOGhQSktrVkVh?=
 =?utf-8?B?azlRb1JIRUd0Q3VHOE51ODU5ZjkzdGtTcm8yZ2pha2tFSWkyaGI5ZU1DZ0ZI?=
 =?utf-8?B?YThTNUZFSWU2bC9aa00xbmRUVDhsRWN5cEVIcUxPa3N0K25ZSmV6KzVVRVEz?=
 =?utf-8?B?Zjg3T1hjTFVkYnlwcFFRR0p2Ti9ucUZiQWRDODYrU3oycDZIU3MyaUlQMmVP?=
 =?utf-8?B?ODVLQ2lXYlkyMzNMVk9TTmZqRXhlR0dVNzdRdnlTQ05ZUGxJOStSYmZrc1d2?=
 =?utf-8?B?WlkwaXYzSDF4SWp3cG9YbHU4Y1JpYjNFVm5qK25Sa3ZEaU9rR3liVysvRGFJ?=
 =?utf-8?B?SjVtZkJ2RFBNbGNqMWVDMitIeW1UUkVyN0FrTDMxZkxkNUFnclVzZVM3MUV0?=
 =?utf-8?B?WUViVlloT0l1WlBhNUZueVJnQzV4Z2FmOXltZHQvazAxV29QNWpZenpDKzBN?=
 =?utf-8?B?QXJ3bGNQNm44NExXQjRaQXhJQnAybWZnMi95TlozV2tkRk1pRUp5Rm1PSWNY?=
 =?utf-8?B?WlBJeEFEV3NrdU9ZU3pYdlJDYThjL0NiTncyTDlFcm90TnNpSzgrelBBd3hO?=
 =?utf-8?B?eWUvQWxPSllObUdqL1NyMFNRaVVjdVl3cTFtcWxrWWdrNHROSHVzQ3YzMEpK?=
 =?utf-8?B?QnhSbEZCcEphWW9JcWV3d0tpTUtTUGtJZ1hBaVU2S1ZOdWJnNFZkYkNHNHkr?=
 =?utf-8?B?aXZ1YkNBbGU0UE1JM2F6UndsZmN4amUxQmVBM21GeXc4dzllOXpBbXg2Zmh0?=
 =?utf-8?B?czNEblNpT05zR2trYmZKYXZwUEFBd1Q2a1hTYUY4cUZkeUhkYTJ3OGE5QUxK?=
 =?utf-8?B?YlE4YkpaTkw3dStEZmxPZlJSOVNHOUt5cmhXR2VKSUR2V2JQU0cwa2tHN1Vv?=
 =?utf-8?B?R09RZytrWkFHbE5BSDBvb0NqYWZ1U2ZXVWpHV29mZTVhRXkrbTlVdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29533aab-9b57-4cad-f3bf-08da2702bd10
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 21:29:54.1456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CQZjMwNLBHsySlSFuk1ioayo792F6amk7BA2M0Z1iX76RI4FKVTSI7CZibTrcLZv3RnqPY+Vd9fR/+GZdF5Wlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3285
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEZW1pIE1h
cmllIE9iZW5vdXIgPGRlbWlAaW52aXNpYmxldGhpbmdzbGFiLmNvbT4NCj4gU2VudDogU3VuZGF5
LCBBcHJpbCAyNCwgMjAyMiA3OjM5IFBNDQo+IFRvOiBUaG9yc3RlbiBMZWVtaHVpcyA8cmVncmVz
c2lvbnNAbGVlbWh1aXMuaW5mbz47IEdyZWcgS0ggDQo+IDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyByZWdyZXNzaW9uc0Bs
aXN0cy5saW51eC5kZXY7IA0KPiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiANCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNv
bT47IFBhbiwgWGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkVH
UkVTU0lPTl0gQU1EIEdQVSByZWdyZXNzaW9uIGluIDUuMTYuMTguLjUuMTcuNA0KPiANCj4gT24g
U3VuLCBBcHIgMjQsIDIwMjIgYXQgMTE6MDI6NDNBTSArMDIwMCwgVGhvcnN0ZW4gTGVlbWh1aXMg
d3JvdGU6DQo+ID4gQ0NpbmcgdGhlIGFtZGdwdSBtYWludGFpbmVycw0KPiA+DQo+ID4gT24gMjQu
MDQuMjIgMDg6MTIsIEdyZWcgS0ggd3JvdGU6DQo+ID4gPiBPbiBTYXQsIEFwciAyMywgMjAyMiBh
dCAxMjowNjozM1BNIC0wNDAwLCBEZW1pIE1hcmllIE9iZW5vdXIgd3JvdGU6DQo+ID4gPj4gVHdv
IFF1YmVzIE9TIHVzZXJzIHJlcG9ydGVkIHRoYXQgdGhlaXIgQU1EIEdQVSBzeXN0ZW1zIGRpZCBu
b3QgDQo+ID4gPj4gd29yayBvbiA1LjE3LjQsIHdoaWxlIDUuMTYuMTggd29ya2VkIGZpbmUuICBE
ZXRhaWxzIGNhbiBiZSBmb3VuZCANCj4gPiA+PiBvbiBodHRwczovL2dpdGh1Yi5jb20vUXViZXNP
Uy9xdWJlcy1pc3N1ZXMvaXNzdWVzLzc0NjIuICBUaGUgDQo+ID4gPj4gaW5pdGlhbCByZXBvcnQg
bGlzdGVkIHRoZSBHUFUgYXMg4oCcQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiANCj4gPiA+
PiBbQU1EL0FUSV0gUmVub2lyIFsxMDAyOjE2MzZ9IChyZXYgZDMpIChwcm9nLWlmIDAwIFtWR0Eg
DQo+ID4gPj4gY29udHJvbGxlcl0p4oCdIGFuZCB0aGUgQ1BVIGFzIOKAnEFNRCBSeXplbiA1IFBS
TyA0NjUwVSB3aXRoIFJhZGVvbiBHcmFwaGljc+KAnS4NCj4gPiA+Pg0KPiA+ID4+ICNyZWd6Ym90
IGludHJvZHVjZWQ6IHY1LjE2LjE4Li52NS4xNy40DQo+ID4gPg0KPiA+ID4gVGhhdCdzIGEgYmln
IHJhbmdlLCBjYW4geW91IHVzZSAnZ2l0IGJpc2VjdCcgdG8gdHJhY2sgaXQgZG93bj8NCj4gPg0K
PiA+IEZXSVcsIGluIGFub3RoZXIgbWFpbCBpbiB0aGlzIHRocmVhZCBhbmQNCj4gPiBodHRwczov
L2dpdGh1Yi5jb20vUXViZXNPUy9xdWJlcy1pc3N1ZXMvaXNzdWVzLzc0NjIjaXNzdWVjb21tZW50
LQ0KPiAxMTA3Ng0KPiA+IDgxMTI2IGl0IHdhcyBjbGFyaWZpZWQgdGhhdCB0aGUgcHJvYmxlbSB3
YXMgaW50cm9kdWNlZCBiZXR3ZWVuIA0KPiA+IDUuMTcuMyBhbmQgNS4xNy40LCB3aGVyZSBhIGZl
dyBhbWRncHUgY2hhbmdlcyB3ZXJlIGFwcGxpZWQuIE1heWJlIA0KPiA+IHRoZXkgYXJlIHRoZSBy
ZWFzb24uDQo+ID4NCj4gPiBBbnl3YXk6IFllcywgYXMgR3JlZ2toIHNhaWQsIGEgYmlzZWN0aW9u
IHJlYWxseSB3b3VsZCBoZWxwLiBCdXQgDQo+ID4gbWF5YmUgdGhlIGFtZGdmeCBkZXZlbG9wZXJz
IG1pZ2h0IGFscmVhZHkgaGF2ZSBhbiBpZGVhIHdoYXQgbWlnaHQgYmUgDQo+ID4gd3JvbmcgaGVy
ZT8gVGhlIFF1YmVzT1MgdGlja2V0IGxpbmtlZCBhYm92ZSBoYXMgc29tZSBtb3JlIGRldGFpbHMu
DQo+IA0KPiBUaGUgcmVwb3J0ZXIgd2FzIGFibGUgdG8gYmlzZWN0IHRoZSByZWdyZXNzaW9uLiAg
SSBhbSBub3Qgc3VycHJpc2VkIA0KPiB0aGF0IHRoaXMgY29tbWl0IGNhdXNlZCBwcm9ibGVtcyBm
b3IgUXViZXMgT1MsIGFzIGRvbTAgaW4gUXViZXMgT1MgaXMgDQo+IHRlY2huaWNhbGx5IGEgZ3Vl
c3Qgb2YgWGVuLg0KPiANCj4gI3JlZ3pib3QgXmludHJvZHVjZWQ6IGI4MThhNWQzNzQ1NDJjY2Vj
NzNkY2ZlNTc4YTA4MTU3NDAyOTgyMGUNCg0KQ2FuIHlvdSBwbGVhc2UgZm9sbG93IHVwIG9uIHRo
ZSBidWcgdGlja2V0Og0KaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9p
c3N1ZXMvMTk4NQ0KSXQgd2lsbCBiZSBlYXNpZXIgdG8gdHJhY2sgZXZlcnl0aGluZyB0aGVyZS4N
Cg0KQWxleA0K
