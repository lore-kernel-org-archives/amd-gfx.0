Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4E2C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 23:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAFCA610A4
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 23:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DAFCA610A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71FCB6E500;
	Thu, 21 Oct 2021 23:33:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F6C6E500
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 23:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNrbDmWy38jIUYy96V6vK0QYPAG/AwMYQCSDh5fphVGS5k/1SLoO2HZ+MbkFdkl9lQDUFxFSGvkcEvY7YFUT30jGNvPdl21X1/TD15sP7pMp0WW7/iE0tzN7/1HZq9f3S7Eosp7+72ZIq4bZ8Tx9uV050XMc7QMoM2sQJdyGp2+RokrvfjzjCk+I0TozsNWDZa4mZ026XPx4juN3bXpQnBiu0W/18C5L1gOQDbpWR5x1y2LXhsC8iiFVwR4wQzhRmsVq7cZbgP0XzrSHEQtWLSFYQuxrxmDbg+p52VQPjBp34l/Ld1XkkIC8oiC8+825g4Lqc0OSyxKVnfHggUum4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4thjGnqFbTW5y8QqEVI5JDyU5NF08OxFlgQloLkA+M=;
 b=cV0EXzrj1xSCy1z4tWI6uTdq4BjmDVWBCDVL0IeNpoXDGQb9Vq5VoXbSK2P+B13gpMA/Qs+xBnzpZdaPyjdNI6Rkj8ZVYyrVEa4G6TzEOeEax8IRBj/r0W3JJVoGekVYhnPPMZv/0u1SuxcHyKoVrJFvj0GxBcdo61YheBgXeS9X7XsGpWwajwg4yBmogJGXDqhfSzRaSR0y6P3DnQOO7K5HurAIw7CkJCTca54zjenj3AGn++Cb0hQoY/017U0ICrtclvXjai3o70Vho6EKFcMFC1bENeOtM0xtGt+28PF89Bc5pzeyq0B8dVktjjc2TnUnzmF4Y+eyy2KEBMputw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4thjGnqFbTW5y8QqEVI5JDyU5NF08OxFlgQloLkA+M=;
 b=XvzvwZWXklHnaleISS+yX1Q+i8Q7U5Fp8/Jxgdd4quhra9AoxYpPwjhE3nNP6CrvwNkY11hIfJBg1g0cOk2O5F4QXlxzkeoCwTA2QylIay3Z4tVfmxZ8f6JhwkE1HAO8thE7ewnNmBvwPwMwH4itUH7j64grjZYbJTiCJmOoSGg=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Thu, 21 Oct 2021 23:33:27 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 23:33:26 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: FW: [PATCH 1/3] drm/amdgpu: fix a potential memory leak in
 amdgpu_device_fini_sw()
Thread-Topic: FW: [PATCH 1/3] drm/amdgpu: fix a potential memory leak in
 amdgpu_device_fini_sw()
Thread-Index: AQHXxkvO0oo45Yb2ZkG4WAfo4m9Q46vdC1YwgACF1ICAAIfeIA==
Date: Thu, 21 Oct 2021 23:33:26 +0000
Message-ID: <DM6PR12MB425073BB737DFB0376CCD145FBBF9@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211021071750.2912140-1-lang.yu@amd.com>
 <DM6PR12MB4250B78B1C9E96581C88310EFBBF9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <6c167e41-dc20-95dc-6f71-839255cc2b25@amd.com>
In-Reply-To: <6c167e41-dc20-95dc-6f71-839255cc2b25@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-21T23:33:23Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6fca938e-35bf-4252-9b58-cf501bf77308;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2a253b3-36cc-489e-5910-08d994eb2e85
x-ms-traffictypediagnostic: DM6PR12MB2812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2812D22543BC7A8487F22DF5FBBF9@DM6PR12MB2812.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uA4/nE2jECs5465fReSr8L68J96Yx6x+N/8sLpfxVYkTSvLPafkWOyC15+rX994iZtESJaQy/N9eYFG63x0CGZv5/KElg9kTra6D8iif6K3bFYw3b7nDAxPrRWusSGs8QOFldQJcLQp+9AsAQ9GhbyzlTj7JbfibkusSJ9MbmGGInfpWLgvijyt124hFi0jsxbG/qiKvcHBwmoQJDYPq+ZbfEdOYWcIvr0qjWoAeDC5aLu6BfJ3VvzzLUeocv6J/9RojFA/mHq2HEBBxGmh/FPT4lDP3bF2kfKcisi0kpFSdOBZJapIwKW+DBo0bArUFQFHxs89WcqI0adyglsFayGiLv/x4BHQc6Ypjo8nxuNNghSJsCXBjU9J5H3SMw5XNcxgPM2xBMrVWNcjgdfdYGzgK0QfOV+TxxyEGLKbpvdbKK3NSBnoXmSE26+pkOI53LmLfWiUY2PSjwXmT4lsO8hDagBYYKhelXHqzyZYYfrjyy+hgshQTANRB1cF0r3ojlCyeKvIFNtzYEQwz42Cr2022L67RcyjKkGH54Z6b1Uzhtk8LGMx2iejjpbTcX3s0NN/UvAgBkXIdxPyd+T0sh7SuDRd1w4UEAU1My4ZXoWOlt32YaAUEH9HpFGr/TonM6j2RgTpRXC0VkmuD/nh3W9/A0di1zDnxVYRdrhO9GX9GKg6gmdswvF7EnXmrPXQ3jD4NXwOvDK4gUnCyxm3+ng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(508600001)(316002)(38100700002)(76116006)(53546011)(6506007)(52536014)(26005)(8676002)(5660300002)(64756008)(7696005)(66446008)(66476007)(33656002)(66946007)(4001150100001)(83380400001)(9686003)(71200400001)(38070700005)(110136005)(55016002)(2906002)(8936002)(66556008)(186003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yng4d3l2WXhnUWJlOUI2eTFwazdQWmVVVndOa0IxamRmVFh1U3B5QjcyVGp3?=
 =?utf-8?B?Vm9WVjJNZWlJRGVwdndJaGxleHJ0UE85YXQrZ0hkWDFkcmcxTC9Dc1JldVpU?=
 =?utf-8?B?V2FNdTZObmd3QWRSMllBQTlnN21FWWxCR2pjSVRpVkNmQmZSMWtTVGg5S0JO?=
 =?utf-8?B?czEvTnJreFVqMTlUTHFCOStkSWQ0d0hWZFRDK1dLeGM4WktyVHI3N21URXd2?=
 =?utf-8?B?QXlScld5aGpqMlo4Vkp2OXpNSUdZZGttTktEdnJtMjViZ28rcmpsSEZzUis2?=
 =?utf-8?B?QUlBZ3NubDA5RWRVL3dpdGFPTy9SdWtZT0VtbEpseGtrNEtrM0lGSVp6WDJa?=
 =?utf-8?B?ZGFsVDhBQWEwRy9QSjFSNy9FNXdVMi9vVWloRkNnb2U5TFd6MVV5NGwvYjBP?=
 =?utf-8?B?d05RU0oxVTB5Z2xWaElUR2xLUkF2cjhYQUpGRGlJZjRuejM4ODJVWjU4Lzk3?=
 =?utf-8?B?L2JURzJERWhFLzRLakJ0aGpXWlkzREE2V3ZoZE5hRmJnTXJqQWtScHVYNEZq?=
 =?utf-8?B?bW56d2J0SkxmalNKbXR0Wk5zNzB6MDFCeGF0Mk45M0VRR2ZzTG9id3lRNFFT?=
 =?utf-8?B?V1ZBUm5mcWk2WnlEWUJFYUg5bVE3UUY0MTVwTGcyK0dSSngwOHU3NmduaXF2?=
 =?utf-8?B?c21lY2ZCRkFMTGFLMjN3YW1DZzViSkthaXpneWhjQW5Sall6dVBJLytYNWRG?=
 =?utf-8?B?WDJiVEl3bXVFUWNTWkxqWG9oUzNDaG0wUWdjcUxtTUQ5aW1xY0srQ0dqZkRQ?=
 =?utf-8?B?SWVZaTRHTjNBaU5aRmdUV2wvNmFXVk5aeHhNMC9DQWZ5WkxQRGJnNUZkTlN4?=
 =?utf-8?B?Zis3SUNuZk1CNnJHTW1OWi9YREdseEdLT2ZxbG1hMFVNM2hQUUkzY3BTVG5t?=
 =?utf-8?B?UElGWHp4c3VlNzVhUnI2b1ZaTTBlRkNocjdhTFVmbjMrUTNFUXBVcjc4Ulpq?=
 =?utf-8?B?WHB3aSs3TVRCL0M4VkNHQ2haYlZWdXFQNFR5NnRLVnVRVU11NFkzeGg4ZDBr?=
 =?utf-8?B?OEoxTXdDd0NPcWI5Q1dXNERXRFV5MGtQeDFyWEdjRnlHRTlhWUIxTjB3MnJu?=
 =?utf-8?B?RXE1b1VtblBxTG4xWWNITk1McjhiRjV1MTdSK1loZXNOdTlJQVowTjI3VlVZ?=
 =?utf-8?B?M2UrZ0p1RURCOGx0ZStlQnZ2MWtVZFV1bjhTaHRycDJSdkViN2NubThvOHlp?=
 =?utf-8?B?RFZQamdNV3hpa1BMYjlJbHAvckhjeXFwWFJUS1Jmam83SE96WmFSVlU2NGVK?=
 =?utf-8?B?K3c3Vkw3cXdyZmVBZi8yT0JYSlZQL0pnUTR4MDVxeTBESU9wbmI3S2dWODlj?=
 =?utf-8?B?ODJNWGV4bnEyMFBSY2VZUkZVNms0UDY5eGRUQUhVcTZxQUowa1R0NjhCckVE?=
 =?utf-8?B?aEhpNzhIS2o1WTBzOWFRdlFHcks5TTJKeXZ2NG9neXRITGxwZ0xpRGZndHEr?=
 =?utf-8?B?ZVZoS1J2Y0liZmFyOVQveEk2UlJ6QlRHZjZxVTRPSnVlQjFJSGFSdjk3YU95?=
 =?utf-8?B?aXh5R2JIbEtJVlpqaGZETzhKWk1xanluYSt2V2JwZlE3VFN0THgwR1FjUFp6?=
 =?utf-8?B?eWZPT2lkbmMrOWdROUhtb1hEZ1F4WnB6d0QzMnZOTDhnU3pORjZZVGxpaHMv?=
 =?utf-8?B?VTdyYzVaT2VyYm9pbmg4Unl0OFJHdlVJZFBjMFF2MnJBSTBiZENTcHQzMGxH?=
 =?utf-8?B?SHRBTWJjUUM3Z2dCQWk4VitDOTVpTEE3Q2FNUlNBNXRpNWpCZE12MGtnTlpI?=
 =?utf-8?Q?pH+64yvGWG6JpuCE4qt3w0caY4s1hgmQfoTfdnR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a253b3-36cc-489e-5910-08d994eb2e85
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 23:33:26.6918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: langyu12@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2812
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPkZyb206IEdyb2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT4N
Cj5TZW50OiBUaHVyc2RheSwgT2N0b2JlciAyMSwgMjAyMSAxMToxOCBQTQ0KPlRvOiBZdSwgTGFu
ZyA8TGFuZy5ZdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj5TdWJq
ZWN0OiBSZTogRlc6IFtQQVRDSCAxLzNdIGRybS9hbWRncHU6IGZpeCBhIHBvdGVudGlhbCBtZW1v
cnkgbGVhayBpbg0KPmFtZGdwdV9kZXZpY2VfZmluaV9zdygpDQo+DQo+T24gMjAyMS0xMC0yMSAz
OjE5IGEubS4sIFl1LCBMYW5nIHdyb3RlOg0KPg0KPj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seV0N
Cj4+DQo+Pg0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IFl1
LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+DQo+Pj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMjEs
IDIwMjEgMzoxOCBQTQ0KPj4+IFRvOiBHcm9kem92c2t5LCBBbmRyZXkgPEFuZHJleS5Hcm9kem92
c2t5QGFtZC5jb20+DQo+Pj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+Pj4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT47IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsgWXUsIExhbmcNCj4+PiA8TGFu
Zy5ZdUBhbWQuY29tPg0KPj4+IFN1YmplY3Q6IFtQQVRDSCAxLzNdIGRybS9hbWRncHU6IGZpeCBh
IHBvdGVudGlhbCBtZW1vcnkgbGVhayBpbg0KPj4+IGFtZGdwdV9kZXZpY2VfZmluaV9zdygpDQo+
Pj4NCj4+PiBhbWRncHVfZmVuY2VfZHJpdmVyX3N3X2ZpbmkoKSBzaG91bGQgYmUgZXhlY3V0ZWQg
YmVmb3JlDQo+Pj4gYW1kZ3B1X2RldmljZV9pcF9maW5pKCksIG90aGVyd2lzZSBmZW5jZSBkcml2
ZXIgcmVzb3VyY2Ugd29uJ3QgYmUNCj4+PiBwcm9wZXJseSBmcmVlZCBhcyBhZGV2LT5yaW5ncyBo
YXZlIGJlZW4gdG9yZSBkb3duLg0KPg0KPg0KPkNhbSB5b3UgY2xhcmlmeSBtb3JlIHdoZXJlIGV4
YWN0bHkgdGhlIG1lbWxlYWsgaGFwcGVucyA/DQo+DQo+QW5kcmV5DQoNClNlZSBhbWRncHVfZmVu
Y2VfZHJpdmVyX3N3X2ZpbmkoKSwgcmluZy0+ZmVuY2VfZHJ2LmZlbmNlcyB3aWxsIG9ubHkgYmUg
ZnJlZWQNCndoZW4gYWRldi0+cmluZ3NbaV0gaXMgbm90IE5VTEwuDQoNCnZvaWQgYW1kZ3B1X2Zl
bmNlX2RyaXZlcl9zd19maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0Kew0KCXVuc2ln
bmVkIGludCBpLCBqOw0KDQoJZm9yIChpID0gMDsgaSA8IEFNREdQVV9NQVhfUklOR1M7IGkrKykg
ew0KCQlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSBhZGV2LT5yaW5nc1tpXTsNCg0KCQlpZiAo
IXJpbmcgfHwgIXJpbmctPmZlbmNlX2Rydi5pbml0aWFsaXplZCkNCgkJCWNvbnRpbnVlOw0KDQoJ
CWlmICghcmluZy0+bm9fc2NoZWR1bGVyKQ0KCQkJZHJtX3NjaGVkX2ZpbmkoJnJpbmctPnNjaGVk
KTsNCg0KCQlmb3IgKGogPSAwOyBqIDw9IHJpbmctPmZlbmNlX2Rydi5udW1fZmVuY2VzX21hc2s7
ICsraikNCgkJCWRtYV9mZW5jZV9wdXQocmluZy0+ZmVuY2VfZHJ2LmZlbmNlc1tqXSk7DQoJCWtm
cmVlKHJpbmctPmZlbmNlX2Rydi5mZW5jZXMpOw0KCQlyaW5nLT5mZW5jZV9kcnYuZmVuY2VzID0g
TlVMTDsNCgkJcmluZy0+ZmVuY2VfZHJ2LmluaXRpYWxpemVkID0gZmFsc2U7DQoJfQ0KfQ0KDQpJ
ZiBhbWRncHVfZGV2aWNlX2lwX2ZpbmkoKSBpcyBleGVjdXRlZCBiZWZvcmUgYW1kZ3B1X2ZlbmNl
X2RyaXZlcl9zd19maW5pKCksIA0KYW1kZ3B1X2RldmljZV9pcF9maW5pKCkgd2lsbCBjYWxsIGdm
eF92WF8wX3N3X2ZpbmkoKSANCnRoZW4gY2FsbCBhbWRncHVfcmluZ19maW5pKCkgYW5kIHNldCBh
ZGV2LT5yaW5nc1tpXSB0byBOVUxMLg0KTm90aGluZyB3aWxsIGJlIGZyZWVkIGluIGFtZGdwdV9m
ZW5jZV9kcml2ZXJfc3dfZmluaSgpLg0KcmluZy0+ZmVuY2VfZHJ2LmZlbmNlcyAgbWVtb3J5IGxl
YWsgaGFwcGVuZWQhDQoNCnZvaWQgYW1kZ3B1X3JpbmdfZmluaShzdHJ1Y3QgYW1kZ3B1X3Jpbmcg
KnJpbmcpDQp7DQoJLi4uLi4uDQoJcmluZy0+YWRldi0+cmluZ3NbcmluZy0+aWR4XSA9IE5VTEw7
DQp9DQoNClJlZ2FyZHMsDQpMYW5nDQoNCj4NCj4NCj4+Pg0KPj4+IEZpeGVzOiA3MmM4Yzk3YjE1
MjIgKCJkcm0vYW1kZ3B1OiBTcGxpdCBhbWRncHVfZGV2aWNlX2ZpbmkgaW50byBlYXJseQ0KPj4+
IGFuZCBsYXRlIikNCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IExhbmcgWXUgPGxhbmcueXVAYW1k
LmNvbT4NCj4+PiAtLS0NCj4+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMgfCAyICstDQo+Pj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jDQo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMNCj4+PiBpbmRleCA0MWNlODYyNDQxNDQuLjU2NTRjNDc5MDc3MyAxMDA2NDQNCj4+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+PiBAQCAt
Mzg0Myw4ICszODQzLDggQEAgdm9pZCBhbWRncHVfZGV2aWNlX2ZpbmlfaHcoc3RydWN0IGFtZGdw
dV9kZXZpY2UNCj4+PiAqYWRldikNCj4+Pg0KPj4+IHZvaWQgYW1kZ3B1X2RldmljZV9maW5pX3N3
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSAgew0KPj4+IC0JYW1kZ3B1X2RldmljZV9pcF9m
aW5pKGFkZXYpOw0KPj4+IAlhbWRncHVfZmVuY2VfZHJpdmVyX3N3X2ZpbmkoYWRldik7DQo+Pj4g
KwlhbWRncHVfZGV2aWNlX2lwX2ZpbmkoYWRldik7DQo+Pj4gCXJlbGVhc2VfZmlybXdhcmUoYWRl
di0+ZmlybXdhcmUuZ3B1X2luZm9fZncpOw0KPj4+IAlhZGV2LT5maXJtd2FyZS5ncHVfaW5mb19m
dyA9IE5VTEw7DQo+Pj4gCWFkZXYtPmFjY2VsX3dvcmtpbmcgPSBmYWxzZTsNCj4+PiAtLQ0KPj4+
IDIuMjUuMQ0K
