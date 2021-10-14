Return-Path: <SRS0=AM0C=PC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2567C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 02:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C5161105
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 02:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 54C5161105
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C56B56E89F;
	Thu, 14 Oct 2021 02:29:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01FC56E89F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Oct 2021 02:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJCLPuOrdc+zQApfznmZ0m/h1wMWIWHpyWWA7MwMW+eZQHTanR8q7Rnnmx/b8vaylwoDFTQuknqzLhVx1UbtisOV0YsnlMc4DdM4ExkGnmTDC1i/RDsYiSYrX/v3KBkp758aoCKrD+sMH4EA1nIHNyWchjkVbeACD2JqMMR4/b3T38f7vt1lf/qoNWCwc60gFUHW/o5MtJk1Nlcbw+Inrd1IyIpxkNbAGXMLUYomQnkFuvp7XBwPwSN4Sr3acBYGGJ5FmQScXVfMOw/7jlVwUfx15bR7gzuG7EZERP0ZQ+Bh4NgaW+1gbexnF+mE/hzY54e5+wxV/qhVb8fLSo0T8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5DJWUvW3oVCytJ3O5KBTc5GPiTNx4yb8hzClcli8nQ=;
 b=a1S/omhKhYdKswipzEWVv0Xr9WNntpkKXAWX1UcqbC5WZCCfZLAKAOJugMF7xfvjy/fZaAdsr8dyfg3jGsvgrszGJfMihULQfHLXox3XfzMH8GSXK32Rsd0Fl0NjYw3hf9JJ6FStSVkLu/XreZVj8vT3I5KJHsf+Q7PrcF1ZdnDTqSQN32nhEU0Us4YBxVt3ytFaybZT2t8iftSQ3la7z0XYtlREe7iwWVUEJQEG0siTo5Py3w5u/kURLnuwAiBFvassA4sSsMZAC0R4EaEo/i31O5ovDvE1OnqSzNFXNTIZohqFgGte6ZRfViinBcUO1AlxnFDfAMIYk/kYtzLarA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5DJWUvW3oVCytJ3O5KBTc5GPiTNx4yb8hzClcli8nQ=;
 b=IYFSyu/oAr512piaoo2EtwJ8Ao4YXMxHOs53SVoh1Ua006kQ77JvHKZ+taJ7WIowsTxCSp8CxHMSZbppPvtXxMFR5IjqGzPIgE6seosd8Ixk1hSjKSE2UhhOgwCDvIURx3Samwv5b0Q5W3Bfh/dqtRRRzcgxde9AkMBORJ84+pU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3275.namprd12.prod.outlook.com (2603:10b6:5:185::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.24; Thu, 14 Oct 2021 02:29:03 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 02:29:03 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu/psp: add some missing cases to
 psp_check_pmfw_centralized_cstate_management
Thread-Topic: [PATCH 3/3] drm/amdgpu/psp: add some missing cases to
 psp_check_pmfw_centralized_cstate_management
Thread-Index: AQHXv4FViEmDEdllyU6AVj/lfKxpQqvRuAmggAAHZ4CAAATxIA==
Date: Thu, 14 Oct 2021 02:29:03 +0000
Message-ID: <DM6PR12MB2619DCFBA7615E883BB11A29E4B89@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211012155307.1059170-1-alexander.deucher@amd.com>
 <20211012155307.1059170-3-alexander.deucher@amd.com>
 <DM6PR12MB261955EC5754D6E20C98DF9BE4B89@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_PVm4fFCNHSodNNSct19waF6nnQGBN_keR_2+Zi4SYF+w@mail.gmail.com>
In-Reply-To: <CADnq5_PVm4fFCNHSodNNSct19waF6nnQGBN_keR_2+Zi4SYF+w@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-14T02:29:00Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4e8897c0-209d-4022-b1ee-76a5f9c08157;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca493c94-fada-4dd9-05be-08d98eba636a
x-ms-traffictypediagnostic: DM6PR12MB3275:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3275CD479288E058FEF9A282E4B89@DM6PR12MB3275.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZ0QvPMYORz4HmZmikqHAMffDb4EEemJ4UUejhoW4L9y37XMcRNMGH1zkECCYxq9dHBk9vYpQcEw8bP+BKZBSJtcrF/lTArdNrDX3Y7qMiQSpdWEYvOdau812HHuyBoahuNzU/VWGd4Mwjc+MNxapQU9XqYlR8u4x9AWG7WA//LxqNwISs5L/V49N5xpdGtJd+cVFvl8HjTNcZs84k+Sb9hMkWfwqtmttlnTO2z5PV/7G0Wy8P0kaLlvtAr/OnuOHAUHaGxnTKw2mFayb/CzAQ16HsssaLqA1SegiG0I5iwbXztrhTK25GhNgbj6zit3HRovSCrvJA5MDdjlM5BCjb22BeR+MWcToGtbAupyXB5Ymmg9NxGo17dHxI/LJ827Cs01+5CVHAXDg4O9gVOrLVrc2KhOmMd4WWIjr6zvwkUCUxfwe51iJKbcPrdJw0nW8OjvrWsbrHputM1dn2Ab75pYwT5h843lM5VnNtAMzP4VLpTR+uw9KZCi2Tu/HG+nPPm3hFlLVjkiQC4H3vsQ5z/PDd4Hn5fk9xF0XHqyDPKRUYJUxaq9SDkDBiEWXYN7COane5w84O9MHUqrhF1aObWwUGhRTrZ8n56Hpi//okowISRzMBRhDG4ssTIDBGpZScXHzhqPTEcK7UmtryCxWij4GRJ/0SfK1fz7G+y4aO4FNjOduCWdKQBwV/V5e3iFo+TrlZqKeE8E7mpCHq4gyw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(55016002)(8936002)(54906003)(26005)(6916009)(9686003)(86362001)(83380400001)(76116006)(7696005)(66946007)(33656002)(508600001)(2906002)(186003)(66556008)(316002)(52536014)(64756008)(6506007)(38070700005)(4326008)(66476007)(38100700002)(53546011)(122000001)(71200400001)(5660300002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVhmS1lFVUJyMEpBbVQ2cTNMODloM3pxVGk0SktDK1BqU0pUTkVVM21RNmRP?=
 =?utf-8?B?MFE5WGRWN3EvK0dUVDdWOVFPMGx5MGNDTlhjQUgwNU8wSFRkbEJEckFIQmRH?=
 =?utf-8?B?akVnWThMMmlZMVc4cS9DMWN5WnRreTZzNWJLM2VXSVFONWYyTEEyNmY4Vk4y?=
 =?utf-8?B?dzJkZFEyeGFrVzU3dnhqYk5vNG00YisrdVpBSUFnNnNnUTRBN0J4K1d0NllS?=
 =?utf-8?B?WGhkb3dHU3dGSXhSdHZWeHlwZjgxTVZKK1FZWUJUdGRaRm9vcVlxWXZ5SmtL?=
 =?utf-8?B?OFdtdlhPRnBHNGx0RXk4VVI4c2ZMdjJxZ1ArTTErWmtVbkR1THJzdWY0bU96?=
 =?utf-8?B?TG5zaTFEVHFkcW9wbTFXc3JxNUxHOXFKWFh2M0FLS2dETmxoUW5tQ2ZEOWJk?=
 =?utf-8?B?RzAvNklEUzBTb3hBQTd4d0ZjZFlNdWlKSmN6OG0zK1RodlpTWFdySHRjSGQ4?=
 =?utf-8?B?K3hnZ1MwWVFTR1NVUktSWFZUTHI2WGRvZTRrSFZKSXFVVTdFUTVyQ2NoV0xh?=
 =?utf-8?B?TGJ1dE1LdFY1T3pnSW1xM1hvbXdwTjZPVVlsNDR4dDJlSHBtL2YyREozZ0F0?=
 =?utf-8?B?WEd6aWRLMHRQeEw0cVJUQUYvaTBMTzVLcnVTVzJMbjJmQ1Q0T1gwMEpTTnJI?=
 =?utf-8?B?T3I5VWFFeFVudzh2OC9udWdpQUJGeXdudUdQMGdpVW84Tjh0SkwyaTJnczQr?=
 =?utf-8?B?MDE5ajUvNGR6WUI5RVdPWmZaaWEzdCtRVFltUW1EbStDZEdqakRROUVza0hD?=
 =?utf-8?B?SExoT3pXRm5hSHdGNXRscmRpamJqZU5xRnczYXZIMUNiZTZKdy90TC9rdHQy?=
 =?utf-8?B?UXNaY3BtUmFIQ0Y4R3RkS1RZMFZ1SXZ0T05JWXJXbFAvSElqSE5OckZSQVQ4?=
 =?utf-8?B?UlJnRndPNHo1cWpsbkoyNGgxMkdkbVkxcFp4dFhobVpUalRtajc5Nm1Za2dH?=
 =?utf-8?B?QktOYVBzVFlJQ3ZzR1g4b0RuSFhFTU1pOXVaUFMxRjZ5eTdDbWpGUUJWYTRo?=
 =?utf-8?B?cTRmejJnbHZLWmo1MVJBVy9jbTNsQS9nWVpRSVFRZ0p6bitPbzU2VUVSNEF2?=
 =?utf-8?B?UE9lZjQ2ZlNjMDlqd3lhSm8xRGFsQU5zcnhoT1hZNENLbHRaTGNkaWwrTzJ6?=
 =?utf-8?B?WGtUeEpBOVVQVWZCc1hxa3prMG0wZ3QxSG8wL0ozUXdTcmx4WTB6QzVmanh3?=
 =?utf-8?B?cnVPa3piT1h4dTgxSU83UmhDT3ZoT0xjQ1dNR2JYQWEzUUE1K0NPZ2pYbU5I?=
 =?utf-8?B?K1pkRWlSQnJMd0pZQ2JjUGJNZ0phV1ExM251ZTJrcTZoejFEc1pjL2FDYVVJ?=
 =?utf-8?B?NzdBTEJzZCt1a0xta0R6dGEydWZuWThURkJlQlk0YzQvZmZSdjdCTjVKNzlO?=
 =?utf-8?B?SXBaZnBwSG1sYXpKSFFZbFRRazdwUy8xb1gzY2NYTlMvRVlPS2hCQkhQblBD?=
 =?utf-8?B?d01UUG5jSVdzazFTN0UzTVM0aFIvRHlYTVdNcXE3MGhnTm1pT1BDdWJFa3N3?=
 =?utf-8?B?dXdaaDJlSTNSSU0wLzJrN3A4Q0tTM3oxWFNzNTRFSDMrWWk4cjR2enltc3I3?=
 =?utf-8?B?QWNCQysxbWlqZ00xcU4xcGs0MjZuU09QQ2JlRGc0VTd4Kzl3alV5ckdlZkJl?=
 =?utf-8?B?bDA0eFh3VjR2MlQ1OUR3YlpRVE9BR21oWFNBQUVXVDdjYzk5Qmg3ZFFueGJl?=
 =?utf-8?B?eDBVT1NhT2VNRmI1b0VYanQwTSs1LzQzbWdFV3FlQkpzd3RyWGlGeE13MXRJ?=
 =?utf-8?Q?9PxXFdTMossgWbcnDSexm4uWuhYl1XtXEQEuzse?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca493c94-fada-4dd9-05be-08d98eba636a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 02:29:03.1480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K2PuSseh7YOAe64+HMg3FggqAJYZr6O5u6Aqf8/7VA/yHo7CGaueez1K38N4Cway
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3275
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6
IFRodXJzZGF5LCBPY3RvYmVyIDE0LCAyMDIxIDEwOjAwIEFNDQo+IFRvOiBRdWFuLCBFdmFuIDxF
dmFuLlF1YW5AYW1kLmNvbT4NCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDMvM10gZHJtL2FtZGdwdS9wc3A6IGFkZCBzb21lIG1pc3NpbmcgY2Fz
ZXMgdG8NCj4gcHNwX2NoZWNrX3BtZndfY2VudHJhbGl6ZWRfY3N0YXRlX21hbmFnZW1lbnQNCj4g
DQo+IE9uIFdlZCwgT2N0IDEzLCAyMDIxIGF0IDk6NDEgUE0gUXVhbiwgRXZhbiA8RXZhbi5RdWFu
QGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCj4gPg0K
PiA+IEkgYXNzdW1lIElQX1ZFUlNJT04oMTEsIDAsIDApIGFuZCBJUF9WRVJTSU9OKDExLCAwLCA1
KSBhcmUgZm9yIE5hdmkxMCBhbmQNCj4gTmF2aTE0IHJlc3BlY3RpdmVseS4NCj4gPiBUaGVuIGFj
Y29yZGluZyB0byB0aGUgY29kZSBjb21tZW50IHRoYXQgIg0KPiBwbWZ3X2NlbnRyYWxpemVkX2Nz
dGF0ZV9tYW5hZ2VtZW50IHN1cHBvcnQgaXMgYXZhaWxhYmxlIGZvciBOYXZpMTIgYW5kDQo+IG9u
d2FyZHMgb25seSIsIEkgdGhpbmsgdGhleSBzaG91bGQgYmUgaGFuZGxlZCBieSAiZGVmYXVsdCIg
YnJhbmNoLiBUaGF0DQo+IG1lYW5zIHRoaXMgcGF0Y2ggc2VlbXMgdW5uZWNlc3NhcnkuDQo+ID4N
Cj4gDQo+IFRoZSBvcmlnaW5hbCBjb2RlIHdhcyB0aGlzOg0KPiAgICAgICAgaWYgKChhZGV2LT5h
c2ljX3R5cGUgPj0gQ0hJUF9BUkNUVVJVUykgfHwNCj4gICAgICAgICAgICAoYWRldi0+YXNpY190
eXBlID49IENISVBfTkFWSTEyKSkNCj4gICAgICAgICAgICAgICAgIHBzcC0+cG1md19jZW50cmFs
aXplZF9jc3RhdGVfbWFuYWdlbWVudCA9IHRydWU7IFNvIG5hdmkxMCBhbmQNCj4gMTQgd2VyZSBp
bmNsdWRlZC4gIE5vdCBzdXJlIHdoZXRoZXIgdGhleSBzaG91bGQgaGF2ZSBiZWVuIG9yIG5vdC4N
CltRdWFuLCBFdmFuXSBPSy4gVGhhdCB3aWxsIG1ha2Ugc2Vuc2UuIFNlcmllcyBpcyByZXZpZXdl
ZC1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4NCkRpZyBhIGxpdHRsZSBtb3JlIGFi
b3V0IHRoZSBoaXN0b3J5Lg0KSXQgc2VlbXMgYXQgZmlyc3QgdGhlIGNlbnRyYWxpemVkX2NzdGF0
ZV9tYW5hZ2VtZW50IHdhcyBsaW1pdGVkIHRvIEFSQ1RVUlVTIG9yID49IENISVBfTkFJVjEyLiBU
aGVuIGl0IHdhcyBleHBhbmRlZCB0byBhbGwgQVNJQ3MgPj0gQ0hJUF8gQVJDVFVSVVMuDQpCdXQg
dGhlIGNvZGUgY29tbWVudCB3YXMgbGVmdCBvdXRkYXRlZC4gQ2FuIHlvdSBnZXQgdGhhdCB1cGRh
dGVkIG9uIGNvZGUgc3VibWl0Pw0KQEAgLTY1LDcgKzY1LDYgQEAgc3RhdGljIGludCBwc3Bfc2Vj
dXJlZGlzcGxheV90ZXJtaW5hdGUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApOw0KICAqDQogICog
VGhpcyBuZXcgc2VxdWVuY2UgaXMgcmVxdWlyZWQgZm9yDQogICogICAtIEFyY3R1cnVzIGFuZCBv
bndhcmRzDQotICogICAtIE5hdmkxMiBhbmQgb253YXJkcw0KICAqLw0KDQpCUg0KRXZhbg0KPiAN
Cj4gQWxleA0KPiANCj4gDQo+ID4gUGF0Y2gxIGFuZCAyIGFyZSByZXZpZXdlZC1ieTogRXZhbiBR
dWFuIDxldmFuLnF1YW5AYW1kLmNvbT4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiA+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPiA+ID4gQWxleCBEZXVjaGVyDQo+ID4gPiBTZW50OiBU
dWVzZGF5LCBPY3RvYmVyIDEyLCAyMDIxIDExOjUzIFBNDQo+ID4gPiBUbzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gPiA+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+DQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggMy8zXSBkcm0vYW1kZ3B1
L3BzcDogYWRkIHNvbWUgbWlzc2luZyBjYXNlcyB0bw0KPiA+ID4gcHNwX2NoZWNrX3BtZndfY2Vu
dHJhbGl6ZWRfY3N0YXRlX21hbmFnZW1lbnQNCj4gPiA+DQo+ID4gPiBNaXNzZWQgYSBmZXcgYXNp
Y3MuDQo+ID4gPg0KPiA+ID4gRml4ZXM6IDgyZDA1NzM2YzQ3YjE5ICgiZHJtL2FtZGdwdS9hbWRn
cHVfcHNwOiBjb252ZXJ0IHRvIElQDQo+IHZlcnNpb24NCj4gPiA+IGNoZWNraW5nIikNCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4N
Cj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3Au
YyB8IDIgKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4gPg0K
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3Au
Yw0KPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4gPiA+
IGluZGV4IDZiMzllNmMwMmRkOC4uNTE2MjBmMmZjNDNhIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQo+ID4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4gPiA+IEBAIC03Nyw3ICs3Nyw5IEBA
IHN0YXRpYyB2b2lkDQo+ID4gPiBwc3BfY2hlY2tfcG1md19jZW50cmFsaXplZF9jc3RhdGVfbWFu
YWdlbWVudChzdHJ1Y3QgcHNwX2NvbnRleHQNCj4gKnBzcA0KPiA+ID4gICAgICAgfQ0KPiA+ID4N
Cj4gPiA+ICAgICAgIHN3aXRjaCAoYWRldi0+aXBfdmVyc2lvbnNbTVAwX0hXSVBdWzBdKSB7DQo+
ID4gPiArICAgICBjYXNlIElQX1ZFUlNJT04oMTEsIDAsIDApOg0KPiA+ID4gICAgICAgY2FzZSBJ
UF9WRVJTSU9OKDExLCAwLCA0KToNCj4gPiA+ICsgICAgIGNhc2UgSVBfVkVSU0lPTigxMSwgMCwg
NSk6DQo+ID4gPiAgICAgICBjYXNlIElQX1ZFUlNJT04oMTEsIDAsIDcpOg0KPiA+ID4gICAgICAg
Y2FzZSBJUF9WRVJTSU9OKDExLCAwLCA5KToNCj4gPiA+ICAgICAgIGNhc2UgSVBfVkVSU0lPTigx
MSwgMCwgMTEpOg0KPiA+ID4gLS0NCj4gPiA+IDIuMzEuMQ0K
