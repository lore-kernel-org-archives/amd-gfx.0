Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36C1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 02:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73D4761039
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 02:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 73D4761039
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D5A6ECC3;
	Fri, 15 Oct 2021 02:33:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E3E56ECC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 02:33:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlmA6HMu8AWxhw1pCid4enGbLZL0YskMe2CM+uTRcsfXP2CPI45zq6/vdTsKQUzTLNhHlDg4Om7/ORxdbio3sgd/gtiBXFmm1bLsFk8++fWcNor22cU79Z5hAETNWRh6FhxkMK1YgNl1kb33xGeCtgx52QHc3c943PmElKGW70fqb22EXHkraZBPfKs9hHknA7g35kJjlY8VRrN5d9jukLvJl5SJQ4Si1qttWDf8Pr6YnDhoEs34yUQALi5AmmCS6IDrAsYHHFx45oHCTYsA4PnQ5L3GjB6sUWDfXW8Zto9fnvassW/6mL3CLDtCF6A+VmTXWz6Y5yMD3Ojc0tq7fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1p7yvRtCrbr68W8w6+l6xPq+fBTd78B9D4IsKo3BB4=;
 b=TO7p7Gkc+v2Wap+/vqKuDSf1k9G3mE7cyB6Fpo7e54f4T2dWrm1AwfVS5OyhpCQRKlIOaBpizPDasA7HN846waIcUEdm7p00HIOIXXGyW7XLyxGdEwicsYYLN83E48jYMX/fkiUepFPDihO2HmGFAu2q2j57hNie+0f/Sa9GObXlxslyxUfOzfPOJ1f1p0AiBU03OBaqL3NkEnJI8mo7vjLpXmNN+dLL1RsMBI47CyyXMq4+zkjpdOQYqz7KxhBUfTzX7hSxR+OOVHvfV9foCT32262Ql9E0sdIrSSC0Fs9B1h5EM1ZxzJhMZBPUsSFGOFjcEo+9KZwNj5nwAx50tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1p7yvRtCrbr68W8w6+l6xPq+fBTd78B9D4IsKo3BB4=;
 b=apKM0Wzy9UJBEjD37IPQPTYVqKHo0Z9FpwdhTmCv3fN7DRvLm/xaYU4Q3iuxpEoaigcrkHgv4Bx8zoe9xZEql0H4BAokLOeIjrGVo4hpysE/PIn2VMu+FlhnHrpsOn2BRBJxza5dr67XJ8qITf+Z4BCRXBeqU23h5sTUet3Z6aY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15; Fri, 15 Oct 2021 02:33:44 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 02:33:43 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdkfd: protect hawaii_device_info with
 CONFIG_DRM_AMDGPU_CIK
Thread-Topic: [PATCH 1/5] drm/amdkfd: protect hawaii_device_info with
 CONFIG_DRM_AMDGPU_CIK
Thread-Index: AQHXvrEIsp+3sDhKEkOyr5/FgEhNgavRQKWAgAIb3yA=
Date: Fri, 15 Oct 2021 02:33:43 +0000
Message-ID: <DM6PR12MB26190E5FB9A3520C78577653E4B99@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211011150217.165699-1-alexander.deucher@amd.com>
 <CADnq5_M3PZzbDoiirQ-59BapS0bMPwwTuuyT=ACbTyVd0+6EQw@mail.gmail.com>
In-Reply-To: <CADnq5_M3PZzbDoiirQ-59BapS0bMPwwTuuyT=ACbTyVd0+6EQw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-15T02:33:40Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ef399def-5fdb-4e94-bb97-169d1d48a967;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d2a1a3d-623e-4192-8d30-08d98f843507
x-ms-traffictypediagnostic: DM6PR12MB4436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB44365D5CFEE4DCB12C0E9FC6E4B99@DM6PR12MB4436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:330;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7FMk/0Y/By2j8Rcmd/5IaLX6Pu83lxFf3d2TAPjdohFfo+SUvnblaR8GXl8hTMJWs7c+74GLnthteXq+OPDXWF7SJ5klov5xVMiVJZkzq3z+1+Jx6+D6wmczGK2+e54ZB9hOEuCOoiVr44TUnhr+HJpFfiRz6duHG1gpjqSAY5md92l3HkYD7oZareS1QtSnqgDUY6y59r3fRLaugeIJcSz73nWkvQjk/HUWy4C5SmOPg81MZ65yUj2wRDH8TaIaG9EA9Ox3oa7MIY7czzlckxhWt9F5H5temuq2oCl0l0aiN/ogUyX4SJtHduGy3XQyt19lp3RslWj9LZscWEupVFZsuYsUQPwLMNqfw+Jv3yvrNvip44/QIzyjF8yq3CeHvbX0a8c4rIQCZ8uYwnGIwNnSwVmPBvTU1L2YWLJ2EBZzBn9GKhinzOIpX0v4RCKyitpiZxSInkpMdKKFkZUAJqrStGt2Ez+VCapHtAt0tV5qsjnNA/5vRIcyq8QrYS+x6jbOQdAvMyvANk10Imdrhnv+XISp+pSscJk86nUsqpA2Ubln405k2b9TEcLiQQNHjDjw7gVEucpeovlZfe8+zGf7UVcMcc9Y7WQblMEYmHDmcETO2ux/0iKHsIfrkLxOnwznv39+hEpwT7m79pkW0tk5U99yS13IRvII7HJeL93jNLgxH6YamPtuTxb89FTXZzdgILb2tMQAtYu1jSso3w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(316002)(122000001)(110136005)(38100700002)(2906002)(7696005)(86362001)(66946007)(71200400001)(64756008)(66556008)(8936002)(8676002)(6506007)(6636002)(52536014)(53546011)(76116006)(186003)(66476007)(38070700005)(33656002)(5660300002)(83380400001)(26005)(9686003)(508600001)(4326008)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alJkZ09JMktWc1dzZ1d2dlAzNUhmNXdZZGFWT2g5Si9NMWI5djZ4Y3RyM2tW?=
 =?utf-8?B?YkxjOW85NkNPSUszS3RrRityc29pSW14Z0dCOTRkUFhEQS8veVhjbGFZZW9o?=
 =?utf-8?B?a1p6c2xkbG1ZOVQyYWdBQ2pTRUlSOGZSM0VIVlBSdmRhemNFY0lwKzlWWGo4?=
 =?utf-8?B?cUx3c0xLUGlPLzAySjBTV0JCUytycXk5VmhkUkY0dXo4aWxvRnM3ZFBoWWZZ?=
 =?utf-8?B?QisvL05iN3JrbEJBdHNnOHducXhxZ3M3Y1NPME1oYzVBVTVROGQ5SzF5Q2ZU?=
 =?utf-8?B?czd1Y2dmZnZvWlFKOVhHM3BnRUo2ZlFhSXJmOEVPU2wzZ2VOYmhtVEdLd3Mr?=
 =?utf-8?B?NXFNYmFhUXNFOFJHam9XZmo4TmlrMjB3RW9jZURvZ01TaXN0dXBxak1IQ2w2?=
 =?utf-8?B?aFJEa2xmaTlid2ZZUHM1NjNDTG9GL01UdGZqMVFKWGJ4OVB3UXFvKy85a1Fo?=
 =?utf-8?B?dUJPbE4zWVVkUVdZQlFIa3NxTnRXZUY5RTdKQWYrUFlDdkVoNnFpR0RIUzZ1?=
 =?utf-8?B?NUowbjZwdFhIaW5rTTUvTm9hem96QjZCUGNzWWFoVWcxQk1vcXRlMmd0OENY?=
 =?utf-8?B?aGRwT1QyRkhPME9qL1BMSFdRUENWL3NGQXhoaVpyQ0o1MEtOYklCT21BNWls?=
 =?utf-8?B?dnhlbklSOGN4N0tHcGViOVVZU0dmSFNLcG5SblJ1OTNFZGR4N2NsejR6aVpT?=
 =?utf-8?B?eEQzdlo4NnRrU1Y2SEtDVUIrRUZ0M2NKaWpFYnQzaklxRkd0dEhWejJ5WkpO?=
 =?utf-8?B?SXVCampZaTJYUXRVakdsaUJGRzc4aWExa1FmMTZ4KytLbkttRUhObjVKNjl0?=
 =?utf-8?B?YUhCakxlMmsvZTkzcWdDYnhXWTZkVmk2cjdDV2NOUEpKQ0NEdE5FdXhrcGFp?=
 =?utf-8?B?NFdpSi9FNEk4WHBobXRhVXBnL2JqeGRNY21sVk1qNEFOT1J4VFdyVzFNVCtT?=
 =?utf-8?B?cU83VUgzdDhraHM5UVZPUFp3L01aOVZtaDE4ZUN1bzBlMHlISkMwR0sxVjlk?=
 =?utf-8?B?aVV4Mk1YNFlBZlNqZmNYdS9sZjBjUFRIcDZDdXVnMjAvOXd2cy9Oc0UvUUdR?=
 =?utf-8?B?dkFCd2pmNFl5UGkyV29jK1RDcFc1cTFQZy9PejNVWUFLYi9WUFI4dElvYTVE?=
 =?utf-8?B?L0toenhUM2Z2cUFGM0hWM0ViOGlTSnhjTFZZbVNwWkgyQ2NQdlBNbEtCYnJ6?=
 =?utf-8?B?MUFRbTl1OGJ5ZHRseE53SEx4aTdib0o0dCtMMkpaQzdiSEpoeStBS0EzdjRx?=
 =?utf-8?B?NlBvVDlHVEdjeElGbGswQlBXRUZDL2crclgzMDUzM3BUMitsVmVJc3VYYkJ2?=
 =?utf-8?B?TlcraDlvMFo5UmxFV0tWRURja3BQSVN5aGo2YUhIb3F2alpUR2JKR2NxV2Nr?=
 =?utf-8?B?U2Y5YVFML3V4TjNPNndRVWZ1S2JPYzk1S3VlQ2UrMzd6c2wvekFjYlNIZXBX?=
 =?utf-8?B?dE1md0JYcUY3N3RidDBQS3RteWRWb0t2bDkweVg4Snd6dUdkdE1KQWpvS0JT?=
 =?utf-8?B?WGN6VnVqbC9JV1lvVEVDRWFwenVlV1JWS2dMUWRKbWxybUpPTFE0UnUySk9G?=
 =?utf-8?B?Q29YcUcxZUFyVStnam9yOGxuWmJmUmhXaDJRdVNEdHZlNXcwazJrL1pjTHVP?=
 =?utf-8?B?c2t0TStPYkdvbmUreHBaaDB0YUlQa2NkbDY2UUhOZzhpWmMvb3l3aDlQT1J0?=
 =?utf-8?B?b3FnbndCSVo0cjRmVzh1UVZ6TlJvZWxnV1dzbnR4bTkvaHJldFhjbGxaZHFK?=
 =?utf-8?Q?LNMOk0uOMPIckJIednwHZ3wiDaXE97ZTtuUWGRZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2a1a3d-623e-4192-8d30-08d98f843507
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 02:33:43.6229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D3Isx6P4j7MeT75+nPPa8KigALcjcKTFijY8rcnP4O+G+WBfRarEAuPKPdttBDl4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KUGF0Y2gxICYgMiBhcmUgcmV2aWV3ZWQtYnk6IEV2
YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQpQYXRjaCAzIC0gNSBhcmUgYWNrZWQtYnk6IEV2
YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zz4gT24gQmVoYWxmIE9mIEFsZXgNCj4gRGV1Y2hlcg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2Jl
ciAxNCwgMjAyMSAyOjIxIEFNDQo+IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNV0gZHJtL2FtZGtmZDogcHJvdGVj
dCBoYXdhaWlfZGV2aWNlX2luZm8gd2l0aA0KPiBDT05GSUdfRFJNX0FNREdQVV9DSUsNCj4gDQo+
IFBpbmcgb24gdGhpcyBzZXJpZXMuDQo+IA0KPiBPbiBNb24sIE9jdCAxMSwgMjAyMSBhdCAxMTow
MiBBTSBBbGV4IERldWNoZXINCj4gPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+IHdyb3RlOg0K
PiA+DQo+ID4gaGF3YWlpX2RldmljZV9pbmZvIGlzIG5vdCB1c2VkIHdoZW4gQ09ORklHX0RSTV9B
TURHUFVfQ0lLIGlzIG5vdA0KPiBzZXQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyB8IDIgKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2RldmljZS5jDQo+ID4gaW5kZXggMDY0ZDQyYWNkNTRlLi4zMWUyNTViYTE1ZWQgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jDQo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jDQo+ID4gQEAg
LTExNCw2ICsxMTQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGtmZF9kZXZpY2VfaW5mbw0KPiBy
YXZlbl9kZXZpY2VfaW5mbyA9IHsNCj4gPiAgICAgICAgIC5udW1fc2RtYV9xdWV1ZXNfcGVyX2Vu
Z2luZSA9IDIsICB9Ow0KPiA+DQo+ID4gKyNpZmRlZiBDT05GSUdfRFJNX0FNREdQVV9DSUsNCj4g
PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBrZmRfZGV2aWNlX2luZm8gaGF3YWlpX2RldmljZV9pbmZv
ID0gew0KPiA+ICAgICAgICAgLmFzaWNfZmFtaWx5ID0gQ0hJUF9IQVdBSUksDQo+ID4gICAgICAg
ICAuYXNpY19uYW1lID0gImhhd2FpaSIsDQo+ID4gQEAgLTEzMyw2ICsxMzQsNyBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGtmZF9kZXZpY2VfaW5mbw0KPiBoYXdhaWlfZGV2aWNlX2luZm8gPSB7DQo+
ID4gICAgICAgICAubnVtX3hnbWlfc2RtYV9lbmdpbmVzID0gMCwNCj4gPiAgICAgICAgIC5udW1f
c2RtYV9xdWV1ZXNfcGVyX2VuZ2luZSA9IDIsICB9Ow0KPiA+ICsjZW5kaWYNCj4gPg0KPiA+ICBz
dGF0aWMgY29uc3Qgc3RydWN0IGtmZF9kZXZpY2VfaW5mbyB0b25nYV9kZXZpY2VfaW5mbyA9IHsN
Cj4gPiAgICAgICAgIC5hc2ljX2ZhbWlseSA9IENISVBfVE9OR0EsDQo+ID4gLS0NCj4gPiAyLjMx
LjENCj4gPg0K
