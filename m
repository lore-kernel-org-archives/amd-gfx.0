Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9C4C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 08:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E7E6113D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 08:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4E7E6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20BFB6EB43;
	Tue, 19 Oct 2021 08:02:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3109F6EB43
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 08:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VthmPcfgerTy0QMlDtJXhgo862CF6Uti5tLnOLcKSCuV7+ZkaG20j4sNe0ooxDQCTA+bT2vgTu8XSoK3fQ5vQSCEBAHyc79Wpmehhj/LsIwcY2BT5hz2eBJxKuKSVAkkJTcemDVG2b60zOO5HQEjLDdNgZYJehaXMEEQ8MxiXKxFeLlua1H5bsaCMOZdyaiggHjudl4u7lypjR/ccVrTr5vWTEjeRDK2mlpUwQ+H+OGRaA6UjO8gRXy4VI8DYXgQYl5rSgBzRun6/XR7WBif6bVoWoNEg5kUHpHCyp3rdugLvwzE/rF0PwiuhT3k3y68yrjnw9V5cfxzEf8Lor1wXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jW4xmNCujHG/qRK+wH8z8xXxo/xHkbI9NZyjTp8aRCw=;
 b=hzCAzQjOxaSkvUsqXftLJiA366esQ+mlEOrgQs4u4riwdzxC0Mx8zdUT7+wt5zsmwAlV4AgUV9ljMlorlVnk04TPUIarE51OLS8UYxCpp+dYX6zrdcln5SrMtoFvVNrdg7CHD5uCAW13fcVDKofAR08lFxzua1VD9HzHkOdKYP0Uw+8GXkyptQvuwopvpxKPWDEBDWVFrsE0RTcfZ1h15XiO8CEetaUxAnCsiMPrCQ+hziLrCLLWlTwKCeKFBBu3inuPe2JoUM8tQM5cxpI7HHR2oTBpfmeOFVtbCXf80oM9rMFOEwGr69bCjRKdQhjUMLRyDV43XZkk9ePvipkM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW4xmNCujHG/qRK+wH8z8xXxo/xHkbI9NZyjTp8aRCw=;
 b=dkJ3gLuAWjOiHoJKVj7XNnH41Im+58faB/871GAn52njqD8xtCZgkMJqjT6AvK4IS6ptiodH2MHJ6iPR1E3kjeaJEg096PB/iZibX43/Z+telFh3e2tZghbEMIgLLGielScWyvOwHxjL6h+NI6HCCGH8ugqUU7ppbaxzfZxx3Tc=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 08:02:15 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::7cc0:c568:c7b1:d824]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::7cc0:c568:c7b1:d824%4]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 08:02:15 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
 <ckoenig.leichtzumerken@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggUmV2aWV3IDEvMV0gZHJtL3R0bTogZml4IGRlYnVn?=
 =?utf-8?Q?fs_node_create_failed?=
Thread-Topic: [PATCH Review 1/1] drm/ttm: fix debugfs node create failed
Thread-Index: AQHXv2CA0DfwHWFUpUeIgG9CO8UTmqvPVtyAgAGGdYCAAF9VgIAIwcjw
Date: Tue, 19 Oct 2021 08:02:15 +0000
Message-ID: <BL1PR12MB533412ED7D1DD3BEFC8597179ABD9@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20211012115834.19577-1-Stanley.Yang@amd.com>
 <7cab58fe-c6ba-c5cb-921d-67a86ccda725@amd.com>
 <fb4360bf-57e0-e58e-f858-241b5939425c@gmail.com>
 <3cee661f-7807-b3e2-f281-07f7a64e40c8@amd.com>
In-Reply-To: <3cee661f-7807-b3e2-f281-07f7a64e40c8@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-19T08:02:12Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=47920e6d-4035-47ba-98ee-65effa970d6c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77d9770f-f268-4fee-42c9-08d992d6c3e0
x-ms-traffictypediagnostic: BL1PR12MB5351:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5351396B3544F6211AE68F8F9ABD9@BL1PR12MB5351.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m/sUmFAC/uBJ3RSXKYZsjsOtUT3LL8jr9PsICyqtpoYq/NDKiaQo+XMp52IYUUk/rssjolcHuoZGrjbxF0c1iy91FxRO5RMLhdphVD6ZUu4ckjKGyg4xeiqLsfEJj3zVgiLKEXqXCrbuRBCYYbS//T0lQObRehrCsnSJusItfZGv+sbgK+1zFX30Qy/khvTUbHOzHSnY1/YqtiCJhW4xg1SnGxdy9KlfnCCSNyed9GlHwa5+/ExZQWnqG43/is25ozxIioTGlFSTRgSHyBGcb/gQ2Y1tFB4jB8iHFEsumIjubs8P/QoAZD3YjhwKp3Mb6vptFWXTzCByKASG4VrVcKp+yrdLFZ2E0rhNKWP5i0909SVOttA8bAQ0DubGFjEmtoi/ksjpro4zpP+6CGL9O+xBqNnurPPyg1LCANk6Uj78aZFaD+3jHoDXmDSa2qFbbD6AUesrec3KXAqvn+slVDF17yrF/hb3XGmaxTTAc962cMe1ZcyzCDh/n3XDYJcbWyiBqFpoQbHsYf+GIPXhBlr+DyujnQd9WH1pEtpKQaFSoQGHUuj1imDaUyKLSriymdTipewYfoYrxJ7UTreJS1To7nZtECtOmMv3YI+hflKgtQpZtSeRQnP9eKLZf6BcVBFA/zJH33/bbK2o8sV3bPPPnqIM/P5W/SldVI8dO74wU97Dk6/TQxhfknTP2ns9FWpUjEjEOdvi/SA7ENCsbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(186003)(6506007)(38070700005)(66476007)(38100700002)(122000001)(26005)(76116006)(66556008)(52536014)(2906002)(316002)(64756008)(83380400001)(66946007)(8936002)(224303003)(110136005)(55016002)(33656002)(508600001)(66446008)(71200400001)(9686003)(7696005)(5660300002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clNIY3pTOXpMOVpxMzc5aXI1Q1N5a2dpeEFWSU1LNDhtS3FtYnFRcHFkWlZT?=
 =?utf-8?B?dmlnWWhrY1VKMkFSZVlRRThxemJ0Q3FhVTNLU3gzRnMyWnlsaGRtek5YSVFP?=
 =?utf-8?B?NXFJNEhLaVVLRGhHYk9mYTFVR0NLL3ZkNmdIcGM5K3N1UEcrT0NDb0V1c0lL?=
 =?utf-8?B?TnVXU1pkUDJqR1I1c083a20vZWZiWlZUVEZMeTM4ZGpxZHhUelRrOVhaNlpX?=
 =?utf-8?B?UnBrWVZkeFk2cWNGQ01qR3pLSU5JZUF1aG1FV1pFamhnRWR4OVN0M3FxOWVZ?=
 =?utf-8?B?aVBrWDlsTDZHeUVCbmRLdE9MNjlVV2RvWXJMVXBQRHRkVGZxbGxTeFV1R0JK?=
 =?utf-8?B?MHl3OUJROEpxSzVNVGR6UEhPajhvdjFKYURxdkx1aURMTjRQK3p6eWJ2ODBT?=
 =?utf-8?B?dk96b1Yxcjh5Wm1CRG42Zmw4S1J5Zkt1V1JaeGZyZXNpZ3pkMU4yeitKL0tW?=
 =?utf-8?B?RTg2MFpJVEFCQzRRTmVmVERRTWU3NzZKUm9hYkJtQ3VJWFB1QWVYWGZudjVO?=
 =?utf-8?B?M3hIL1Yzamo1amoyYnVTdkdEQ3hKdHd5YVBxVks0SS8zUW4yY2pIbE1RMGpR?=
 =?utf-8?B?N1Q0cVNYcU9jQ0FRV0Exc3JOYkdXTWxqdmM3UlM4VEdsSElKY2dXRXJJUGsy?=
 =?utf-8?B?WWdCdkVhaEtJNThrbU45Ni93VGtQNjIxQzFuMUgvZDJHOUk4OVpvVmFsc1pR?=
 =?utf-8?B?TFNiWjB4ckhkMUxEbGxKYWMxU2ZTTDNSSi9OYWVVQ2pabEtyMVhnaUV2WmRx?=
 =?utf-8?B?NjArYnpkc1gwUGg4TEUzMHY5N3ZkNU8wencxcjJ0bUlzUkJkVGVOQTVDdytj?=
 =?utf-8?B?ZzhRQVRhcDl5MWFxa0Y2NGJZS1l4dkw1c1dKUkl0eGJQd25PeVJodVFKcm1Y?=
 =?utf-8?B?cDVHNlYwb0ZxSGp4R0JZYU4vQmVrTEswQjUwL1h1MHQvQUpXbmJ1czAxeTRC?=
 =?utf-8?B?S0EySGZtbDFOWjNXa01QSSsxWDAvdWc5N2NZeE83WFRLakR6Q0JnOFZpclE3?=
 =?utf-8?B?VXQwUzhPVkdyWHdsY05YazhkY1N4Y1cyOHNzVXI2MGQ2REg0cURRS1J5L2FR?=
 =?utf-8?B?d2FGeGkyV1ZYdU9CbHpiYTc2M1ZjZVNsK1Z4b0FVMnl0R3QwV0JhenlLcEZT?=
 =?utf-8?B?ZExZbzNpZmRoZ2htMmovRFdGZW11RXY2Z1RxbldOcERmWXpreWNuMytuRkJ2?=
 =?utf-8?B?MHVQbE55M1FZbVdGZjhxWDRJY3hzV3BZZG50YTB3MlYzS2F6ZllVSzJmeGxQ?=
 =?utf-8?B?SHdOQkF6Q1Nrb2pyTnpKb1VQRDhYWkt5eHcyWVFTZDBtVEkvSmxsZkVQMm01?=
 =?utf-8?B?b1NVeS92dlYzejZxNDY5VXdMNEY3a1lxenYzK0pUZmdsLzB1Q1NsOEJRY01t?=
 =?utf-8?B?RkE0RmV2SFZIejQ1Zy9jQlR1cEtReGpzUzNUcXVXbFR1QXVPVUFlZ2lQVUhi?=
 =?utf-8?B?YlJTK25pcnNXQ0hvd2kvOTlXUlNlTXhqT1dWRW5XU1l4b0Rra2t0WHJvNlkv?=
 =?utf-8?B?TE5idVRpaVdiNHlNdTVnREkwVDUwN0JMSG9RZHJUWU9CckkzRENHWHA4SjZ5?=
 =?utf-8?B?TDZnT0Y1WnptWi8yTHRQMmtNZUJDNUdReXpnMGRHUFBlKzRHdTFQT2xZK0tQ?=
 =?utf-8?B?Skg0andRUHlidkd2L3V3ZEIydkEzZHRvZFN3MC9LSUw3NzMyeXIyRXF2VVU1?=
 =?utf-8?B?d0hvejVSeTdXeVZqdDdKTzQ2ZlZIekQveDNyeE9SclZrRURYSjg4VlNJeFZ2?=
 =?utf-8?Q?e0yF+i/Bs58A4iMjL/75+qqidTHHsjCh1E3okM3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d9770f-f268-4fee-42c9-08d992d6c3e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 08:02:15.5441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLh5PQan3R9zVtdpqmfyhNztVf/KpF8XfajFaNi9WolGQ8p1lel/3eNtn5sj1CQzpLK3pCka21DySm+Sr1gikw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g
5Y+R5Lu25Lq6OiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
PiDku6PooaggRGFzLA0KPiBOaXJtb3kNCj4g5Y+R6YCB5pe26Ze0OiBUaHVyc2RheSwgT2N0b2Jl
ciAxNCwgMjAyMSAyOjExIEFNDQo+IOaUtuS7tuS6ujogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5p
Zy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCj4g5Li76aKYOiBSZTogW1BBVENIIFJldmlldyAxLzFdIGRybS90dG06IGZpeCBkZWJ1
Z2ZzIG5vZGUgY3JlYXRlIGZhaWxlZA0KPiANCj4gDQo+IE9uIDEwLzEzLzIwMjEgMjoyOSBQTSwg
Q2hyaXN0aWFuIEvDtm5pZyB3cm90ZToNCj4gPiBBbSAxMi4xMC4yMSB1bSAxNToxMiBzY2hyaWVi
IERhcywgTmlybW95Og0KPiA+Pg0KPiA+PiBPbiAxMC8xMi8yMDIxIDE6NTggUE0sIFN0YW5sZXku
WWFuZyB3cm90ZToNCj4gPj4+IFRlc3Qgc2NlbmFyaW86DQo+ID4+PiDCoMKgwqDCoCBtb2Rwcm9i
ZSBhbWRncHUgLT4gcm1tb2QgYW1kZ3B1IC0+IG1vZHByb2JlIGFtZGdwdSBFcnJvciBsb2c6DQo+
ID4+PiDCoMKgwqDCoCBbwqDCoCA1NC4zOTY4MDddIGRlYnVnZnM6IEZpbGUgJ3BhZ2VfcG9vbCcg
aW4gZGlyZWN0b3J5ICdhbWR0dG0nDQo+ID4+PiBhbHJlYWR5IHByZXNlbnQhDQo+ID4+PiDCoMKg
wqDCoCBbwqDCoCA1NC4zOTY4MzNdIGRlYnVnZnM6IEZpbGUgJ3BhZ2VfcG9vbF9zaHJpbmsnIGlu
IGRpcmVjdG9yeQ0KPiA+Pj4gJ2FtZHR0bScgYWxyZWFkeSBwcmVzZW50IQ0KPiA+Pj4gwqDCoMKg
wqAgW8KgwqAgNTQuMzk2ODQ4XSBkZWJ1Z2ZzOiBGaWxlICdidWZmZXJfb2JqZWN0cycgaW4gZGly
ZWN0b3J5DQo+ID4+PiAnYW1kdHRtJyBhbHJlYWR5IHByZXNlbnQhDQo+ID4+DQo+ID4+DQo+ID4+
IFdlIHNob3VsZCBpbnN0ZWFkIGFkZCBhIGNoZWNrIGlmIHRob3NlIGRlYnVnZnMgZmlsZXMgYWxy
ZWFkeQ0KPiA+PiBleGlzdC9jcmVhdGVkIGluIHR0bSBkZWJ1Z2ZzIGRpciB1c2luZyBkZWJ1Z2Zz
X2xvb2t1cCgpIGJlZm9yZSBjcmVhdGluZy4NCj4gPg0KPiA+IE5vLCBJSVJDIHRoZSBJbnRlbCBn
dXlzIGhhZCBmaXhlZCB0aGF0IGFscmVhZHkgYnkgYWRkaW5nL3JlbW92aW5nIHRoZQ0KPiA+IGRl
YnVnZnMgZmlsZSBvbiBtb2R1bGUgbG9hZC91bmxvYWQuDQo+IA0KPiANCj4gQWRkaW5nL3JlbW92
aW5nIG9uIHR0bSBtb2R1bGUgbG9hZC91bmxvYWQgaXMgbmljZXIuDQpUaGUgcG9pbnQgaXMgdGhh
dCBwYWdlX3Bvb2wsIHBhZ2VfcG9vbF9zaHJpbmsgYW5kIGJ1ZmZlcl9vYmplY3RzIGFyZSBjcmVh
dGVkIGJ5IGFtZGdwdSBkcml2ZXIsIEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gcmVtb3ZlIHRoZW0g
YnkgYW1kZ3B1IG1vZHVsZSBkdWUgdG8gYW1kZ3B1IG1vZHVsZSBjcmVhdGUgdGhlbSwNCm90aGVy
d2lzZSwgdGhlcmUgd2lsbCBiZSBhIHNjZW5lIGNyZWF0ZSB0aGVtIGZhaWxlZCBvbmx5IHJlbG9h
ZCBhbWRncHUgbW9kdWxlLg0KDQpTdGFubGV5DQo+IA0KPiANCj4gTmlybW95DQo+IA0KPiA+DQo+
ID4NCj4gPiBDaHJpc3RpYW4uDQo+ID4NCj4gPj4NCj4gPj4NCj4gPj4gUmVnYXJkcywNCj4gPj4N
Cj4gPj4gTmlybW95DQo+ID4+DQo+ID4+DQo+ID4+DQo+ID4+PiBSZWFzb246DQo+ID4+PiDCoMKg
wqDCoCBwYWdlX3Bvb2wsIHBhZ2VfcG9vbF9zaHJpbmsgYW5kIGJ1ZmZlcl9vYmplY3RzIGNhbiBi
ZSByZW1vdmVkDQo+ID4+PiB3aGVuDQo+ID4+PiDCoMKgwqDCoCBybW1vZCBhbWR0dG0sIGluIHRo
ZSBhYm92ZSB0ZXN0IHNjZW5hcmlvIG9ubHkgcm1tb2QgYW1kZ3B1LCBzbw0KPiA+Pj4gdGhvc2UN
Cj4gPj4+IMKgwqDCoMKgIGRlYnVnZnMgbm9kZSB3aWxsIG5vdCBiZSByZW1vdmVkLCB0aGlzIGNh
dXNlZCBmaWxlIGNyZWF0ZSBmYWlsZWQuDQo+ID4+PiBTb3VsdGlvbjoNCj4gPj4+IMKgwqDCoMKg
IGNyZWF0ZSB0dG1fcGFnZSBkaXJlY3RvcnkgdW5kZXIgdHRtX3Jvb3QgZGlyZWN0b3J5IHdoZW4g
aW5zbW9kDQo+ID4+PiBhbWRncHUsDQo+ID4+PiDCoMKgwqDCoCBwYWdlX3Bvb2wsIHBhZ2VfcG9v
bF9zaHJpbmsgYW5kIGJ1ZmZlcl9vYmplY3RzIGFyZSBzdG9yZWQgaW4NCj4gPj4+IHR0bV9wYWdl
IGRpcmVjdGlyeSwNCj4gPj4+IMKgwqDCoMKgIHJlbW92ZSB0dG1fcGFnZSBkaXJlY3Rvcnkgd2hl
biBkbyBybW1vZCBhbWRncHUsIHRoaXMgY2FuIGZpeA0KPiA+Pj4gYWJvdmUgaXNzdWUuDQo+ID4+
Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogU3RhbmxleS5ZYW5nIDxTdGFubGV5LllhbmdAYW1kLmNv
bT4NCj4gPj4+IC0tLQ0KPiA+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fZGV2aWNlLmMg
fCAxMiArKysrKysrKysrKy0NCj4gPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX21vZHVs
ZS5jIHzCoCAxICsNCj4gPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX21vZHVsZS5oIHzC
oCAxICsNCj4gPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3Bvb2wuY8KgwqAgfMKgIDQg
KystLQ0KPiA+Pj4gwqAgNCBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0
bV9kZXZpY2UuYw0KPiA+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9kZXZpY2UuYw0KPiA+
Pj4gaW5kZXggMWRlMjNlZGJjMTgyLi5hZDE3MDMyOGYwYzggMTAwNjQ0DQo+ID4+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9kZXZpY2UuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fZGV2aWNlLmMNCj4gPj4+IEBAIC01NSw2ICs1NSwxMCBAQCBzdGF0aWMgdm9p
ZCB0dG1fZ2xvYmFsX3JlbGVhc2Uodm9pZCkNCj4gPj4+IMKgIMKgwqDCoMKgwqAgdHRtX3Bvb2xf
bWdyX2ZpbmkoKTsNCj4gPj4+IMKgICsjaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQo+ID4+PiArwqDC
oMKgIGRlYnVnZnNfcmVtb3ZlKHR0bV9kZWJ1Z2ZzX3BhZ2UpOyAjZW5kaWYNCj4gPj4+ICsNCj4g
Pj4+IMKgwqDCoMKgwqAgX19mcmVlX3BhZ2UoZ2xvYi0+ZHVtbXlfcmVhZF9wYWdlKTsNCj4gPj4+
IMKgwqDCoMKgwqAgbWVtc2V0KGdsb2IsIDAsIHNpemVvZigqZ2xvYikpOw0KPiA+Pj4gwqAgb3V0
Og0KPiA+Pj4gQEAgLTg1LDYgKzg5LDEwIEBAIHN0YXRpYyBpbnQgdHRtX2dsb2JhbF9pbml0KHZv
aWQpDQo+ID4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgPj4gUEFHRV9TSElGVDsNCj4gPj4+IMKgwqDC
oMKgwqAgbnVtX2RtYTMyID0gbWluKG51bV9kbWEzMiwgMlVMIDw8ICgzMCAtIFBBR0VfU0hJRlQp
KTsNCj4gPj4+IMKgICsjaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQo+ID4+PiArwqDCoMKgIHR0bV9k
ZWJ1Z2ZzX3BhZ2UgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoInR0bV9wYWdlIiwNCj4gPj4+IHR0bV9k
ZWJ1Z2ZzX3Jvb3QpOw0KPiA+Pj4gKyNlbmRpZg0KPiA+Pj4gKw0KPiA+Pj4gwqDCoMKgwqDCoCB0
dG1fcG9vbF9tZ3JfaW5pdChudW1fcGFnZXMpOw0KPiA+Pj4gwqDCoMKgwqDCoCB0dG1fdHRfbWdy
X2luaXQobnVtX3BhZ2VzLCBudW1fZG1hMzIpOw0KPiA+Pj4gwqAgQEAgLTk4LDggKzEwNiwxMCBA
QCBzdGF0aWMgaW50IHR0bV9nbG9iYWxfaW5pdCh2b2lkKQ0KPiA+Pj4gwqDCoMKgwqDCoCBJTklU
X0xJU1RfSEVBRCgmZ2xvYi0+ZGV2aWNlX2xpc3QpOw0KPiA+Pj4gwqDCoMKgwqDCoCBhdG9taWNf
c2V0KCZnbG9iLT5ib19jb3VudCwgMCk7DQo+ID4+PiDCoCAtwqDCoMKgIGRlYnVnZnNfY3JlYXRl
X2F0b21pY190KCJidWZmZXJfb2JqZWN0cyIsIDA0NDQsDQo+ID4+PiB0dG1fZGVidWdmc19yb290
LA0KPiA+Pj4gKyNpZmRlZiBDT05GSUdfREVCVUdfRlMNCj4gPj4+ICvCoMKgwqAgZGVidWdmc19j
cmVhdGVfYXRvbWljX3QoImJ1ZmZlcl9vYmplY3RzIiwgMDQ0NCwNCj4gPj4+ICt0dG1fZGVidWdm
c19wYWdlLA0KPiA+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmZ2xvYi0+
Ym9fY291bnQpOw0KPiA+Pj4gKyNlbmRpZg0KPiA+Pj4gwqAgb3V0Og0KPiA+Pj4gwqDCoMKgwqDC
oCBtdXRleF91bmxvY2soJnR0bV9nbG9iYWxfbXV0ZXgpOw0KPiA+Pj4gwqDCoMKgwqDCoCByZXR1
cm4gcmV0Ow0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX21vZHVs
ZS5jDQo+ID4+PiBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX21vZHVsZS5jDQo+ID4+PiBpbmRl
eCA4ODk3MGE2YjhlMzIuLjY2NTk1ZTZlNzA4NyAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS90dG0vdHRtX21vZHVsZS5jDQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRt
L3R0bV9tb2R1bGUuYw0KPiA+Pj4gQEAgLTM4LDYgKzM4LDcgQEANCj4gPj4+IMKgICNpbmNsdWRl
ICJ0dG1fbW9kdWxlLmgiDQo+ID4+PiDCoCDCoCBzdHJ1Y3QgZGVudHJ5ICp0dG1fZGVidWdmc19y
b290Ow0KPiA+Pj4gK3N0cnVjdCBkZW50cnkgKnR0bV9kZWJ1Z2ZzX3BhZ2U7DQo+ID4+PiDCoCDC
oCBzdGF0aWMgaW50IF9faW5pdCB0dG1faW5pdCh2b2lkKQ0KPiA+Pj4gwqAgew0KPiA+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX21vZHVsZS5oDQo+ID4+PiBiL2RyaXZl
cnMvZ3B1L2RybS90dG0vdHRtX21vZHVsZS5oDQo+ID4+PiBpbmRleCBkN2NhYzVkNGI4MzUuLjYw
MDdkYzY2ZjQ0ZSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX21v
ZHVsZS5oDQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9tb2R1bGUuaA0KPiA+
Pj4gQEAgLTM2LDUgKzM2LDYgQEANCj4gPj4+IMKgIHN0cnVjdCBkZW50cnk7DQo+ID4+PiDCoCDC
oCBleHRlcm4gc3RydWN0IGRlbnRyeSAqdHRtX2RlYnVnZnNfcm9vdDsNCj4gPj4+ICtleHRlcm4g
c3RydWN0IGRlbnRyeSAqdHRtX2RlYnVnZnNfcGFnZTsNCj4gPj4+IMKgIMKgICNlbmRpZiAvKiBf
VFRNX01PRFVMRV9IXyAqLw0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0v
dHRtX3Bvb2wuYw0KPiA+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wb29sLmMgaW5kZXgg
OGJlN2ZkNzE2MWZkLi5lY2IzM2RhYWQ3YjUNCj4gPj4+IDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL3R0bS90dG1fcG9vbC5jDQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
dHRtL3R0bV9wb29sLmMNCj4gPj4+IEBAIC03MDksOSArNzA5LDkgQEAgaW50IHR0bV9wb29sX21n
cl9pbml0KHVuc2lnbmVkIGxvbmcgbnVtX3BhZ2VzKQ0KPiA+Pj4gwqDCoMKgwqDCoCB9DQo+ID4+
PiDCoCDCoCAjaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQo+ID4+PiAtwqDCoMKgIGRlYnVnZnNfY3Jl
YXRlX2ZpbGUoInBhZ2VfcG9vbCIsIDA0NDQsIHR0bV9kZWJ1Z2ZzX3Jvb3QsIE5VTEwsDQo+ID4+
PiArwqDCoMKgIGRlYnVnZnNfY3JlYXRlX2ZpbGUoInBhZ2VfcG9vbCIsIDA0NDQsIHR0bV9kZWJ1
Z2ZzX3BhZ2UsIE5VTEwsDQo+ID4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICZ0dG1fcG9vbF9kZWJ1Z2ZzX2dsb2JhbHNfZm9wcyk7DQo+ID4+PiAtwqDCoMKgIGRlYnVnZnNf
Y3JlYXRlX2ZpbGUoInBhZ2VfcG9vbF9zaHJpbmsiLCAwNDAwLCB0dG1fZGVidWdmc19yb290LA0K
PiA+Pj4gTlVMTCwNCj4gPj4+ICvCoMKgwqAgZGVidWdmc19jcmVhdGVfZmlsZSgicGFnZV9wb29s
X3NocmluayIsIDA0MDAsIHR0bV9kZWJ1Z2ZzX3BhZ2UsDQo+ID4+PiBOVUxMLA0KPiA+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmdHRtX3Bvb2xfZGVidWdmc19zaHJpbmtf
Zm9wcyk7DQo+ID4+PiDCoCAjZW5kaWYNCj4gPg0K
