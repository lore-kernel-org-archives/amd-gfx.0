Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4843C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 09:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78CA3610E5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 09:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 78CA3610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 394246EB67;
	Tue, 19 Oct 2021 09:15:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99B156EB67
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 09:15:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlZx9t5ct1POMl4y9f+di+Gy1u7zJijpkOHEzSfxxzqW5DDI8hPO6v1kSWHkRC92ND2m2ShQd+BtVoVq4NgYIgiCSa7FWM2lU8chg0Cj6n7UyB04tEEmjIjbu7Lbe+ITPZgt1NxGDKH6PJaI7unUMlePpOQMBtDkOufx+qi9D9y05jiCg+fF2gqhQtcHtLhkTMfwOjYitRAIj+eTwkxWuXHbDdjoofAo+7jUU/LKWt5u2lU4uGnidphitgjdTciTxBrr7O1n8+B7qpFCkTgWSzEeXHW/QfkIYbH8vsrKL8q/oDs9z2AdKlzNz+SYN4hTBqkbIKs8tcjz373RmtWOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO6Gu402UCPcUn6ASFe1vibAbEUDVTBJ3r5aqHL2TQ8=;
 b=SW0HVku81aZfsiVLacq2W8Hn/uxhEtLp2Uzk8qBoZzLohiLFI7zI/49RM+o/jRHK3Bu9Ol3rdL8aInFZ4AB6XA245ngaX580pFUd/G5gRHFXbvUuxbt9N4+/obkXUkHarc3DnDurLFBvMduIh7I/aIeh0sPdosKsZxAmvnFouwwpMrEzyHCJ0idxYyetqQwsxDktaJ3PTDqXfcF9lYDkxE3LXahtBHAFmrMcu0J+WHE6xl4vX8oN/Irfv4kGCqMQS6zJvJghWNh3FtZ22W4nFM1n/yw5mY5ja8GXD+7Lmi4B/KXyYQ0oy5GKEL9B0ZaJjfEYyb6vuaF19DxrIhpKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO6Gu402UCPcUn6ASFe1vibAbEUDVTBJ3r5aqHL2TQ8=;
 b=baWJBsdoFuVMFOTcqidNvMYdNL+fQ4G965kdc3dbLWVB+WSKZmvrs0hmlq2Uf+z7F0IE7v9Ayu3jdvXJXKDUcB59SShIsI72DLKu5ufWm5zTi520cpxkXYl2FHhaTblLsKW5F61WwVkoPHTPRqrwtphfAZV7WM4Btyfd9eaFm6s=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 09:15:53 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::7cc0:c568:c7b1:d824]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::7cc0:c568:c7b1:d824%4]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 09:15:53 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Das, Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCBSZXZpZXcgMS8xXSBkcm0vdHRtOiBm?=
 =?utf-8?Q?ix_debugfs_node_create_failed?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggUmV2aWV3IDEvMV0gZHJtL3R0bTogZml4IGRlYnVn?=
 =?utf-8?Q?fs_node_create_failed?=
Thread-Index: AQHXv2CA0DfwHWFUpUeIgG9CO8UTmqvPVtyAgAGGdYCAAF9VgIAIwcjwgAAOLwCAAAZSEA==
Date: Tue, 19 Oct 2021 09:15:53 +0000
Message-ID: <BL1PR12MB53347B80533A0EA5D24670A39ABD9@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20211012115834.19577-1-Stanley.Yang@amd.com>
 <7cab58fe-c6ba-c5cb-921d-67a86ccda725@amd.com>
 <fb4360bf-57e0-e58e-f858-241b5939425c@gmail.com>
 <3cee661f-7807-b3e2-f281-07f7a64e40c8@amd.com>
 <BL1PR12MB533412ED7D1DD3BEFC8597179ABD9@BL1PR12MB5334.namprd12.prod.outlook.com>
 <776ce8d2-b61e-d4f2-d6b4-0b6e0e754188@gmail.com>
In-Reply-To: <776ce8d2-b61e-d4f2-d6b4-0b6e0e754188@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-19T09:15:48Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=524470d5-4eec-493b-9419-dbfc954b0f36;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dda4ebe1-c2ae-4917-257a-08d992e10ce9
x-ms-traffictypediagnostic: BL1PR12MB5128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB512863193CEBE7993190F8399ABD9@BL1PR12MB5128.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sY7gn7dpI+WzQdTCwf0k8G+KIGNrQlVpY3lRx2awB4TvCGtfg6wNdpbhwMj3eHVXkF2K1ZcjmDJF6QTcWhS6CBi4K5remkFVC63ew9f/gatqSGBzSww4fmp6Td9Kn3zSC7CpiImNAmnju+rxNnihIsXkUCh7101QXsZievMBQ15MKLiUL2hRkx5F+gnFD8yj1saWbI3VyGLxqvvhkb1PlWFS7YXfMtNaj+JHB8MsG1d7OOVSO/7tt8MR2pNJYrPwFthKWen+U0vIP6gU8U4Co2YzXgb1mNMbPyi/WLQ1PQSIJ5zMuAPzKspl//v9/55Bxtm1P9l/2Dj9/43Fjxk9uX6UY1BBT/V3mByeeMmuQH3a5K94JIB5OVwKlRPuXmFjQT48TFsXyxcUCEDXJ4Wl0cbHPSMELkda5FA2Ay7vImUnaiI4bJZoJ6VUjdVAxHcAXGJpEOmk5WrlYfMNDW4OzL1VpqfM/3D0A/ee32diz3FoKBE8W8waRaGyMDsUeDkPf7dtKPnrL7vmiuVSjcAY5aZbWW+mUEVxyjCLr0hEges/Slb17uHK67WvIJIifOE4sCqfoHHC6aLktDuas0OOdbp6Lrm6j/orAYcTfnBBedlmt6JWBLEVnbDQM4Xj60Fx9A9n1o/gZ0SByU7pxHRqvnZ44XDR3gDxAHyIqf8yxjJM9Zx8Zm4/jMvBYROS6p8gTDQS/HLsI7aJaGPbuIx7xg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(76116006)(38100700002)(55016002)(110136005)(64756008)(66446008)(8936002)(71200400001)(6506007)(53546011)(86362001)(26005)(83380400001)(66946007)(66476007)(33656002)(9686003)(52536014)(186003)(2906002)(38070700005)(66556008)(508600001)(5660300002)(7696005)(316002)(224303003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2g5SkptcVl2dG5iclNkUVdyWjZ5SUZrd0NMbHZiUEdrN2czcXBkbnRkTWpT?=
 =?utf-8?B?ZXpQQU9RbzVRVVc5dEpHZ1V3Y1F1b3o3dEhSUEpmcnlrZ1pobzVHd2tTb0hm?=
 =?utf-8?B?alRpZG9UaUFYMFZHV0IyMmNicWlRYnFZQWMwYWFnTHhEN3g4Qnc3Q2lkVFVn?=
 =?utf-8?B?VUF0eUxyc1RIeDVxUWhkbitOMjFmUmxWRkZkQUd1cGVmUkJCQ3luL3JPMm5O?=
 =?utf-8?B?K2x6MGNPRTFMcWt6ZUxWM0htclZKNksvUUNYUmRqdlRaOEV0TEtzQnBpRDRw?=
 =?utf-8?B?VFU4RytMN0pEalByYkwvV04wRkFMczFBMmFBS0NHeWtlVUtHeExkM2VPdUYy?=
 =?utf-8?B?czY2c1lQcFFBTkE2QTNIUmpWa0dSbmNTNFVBWHpJb0w3dENqRTBlTFFjNm8v?=
 =?utf-8?B?Q0tmUGVSRkI4b1J5WFRvMnlGWm1DK0tCMzRqRnRUT2EyU1Mrc2NXR25rRjUx?=
 =?utf-8?B?RkZBbVQ2eUQ5QVZMRTNqajFUREJkQ2RrL0lzTENXVkVXVGZjS21vdVE5SmNv?=
 =?utf-8?B?RVNISUlQRWFoOTk0SHBlRFhTRGpOYjFrTHJ2blBhT2U0M2xBd05udjVpUEgr?=
 =?utf-8?B?V2c3RW4renFzYzAxUzNlUk42SEd1Qnl1eXJKMjFOR1VqaFNTZ293VnFrZ0NF?=
 =?utf-8?B?a3VxOFhnQXNwZFArdU1NdkREczAwVUVrY2QwTzNzelluMDFYWkxXUTYrQlNF?=
 =?utf-8?B?QlIyODBhS1laVnh2ZVRxeno2VDNQN0RQaE80Wm5mbG9mVlVYZm14Njl5QWR1?=
 =?utf-8?B?ak1lUE5wVTgrbG1sZkZqSkQrSFRGWUpHYktCL0xJR0RxQ3l4V1RQNEM0d0lN?=
 =?utf-8?B?TVRncDFrY2VjRFdiWUVRSnB6RlJjWDFDeGNpV3NKUGppWUxxVWVwTE5LeGVJ?=
 =?utf-8?B?UjlzS0Q5dmJYWHI2d2MzeXdObTdpMUZpMFV0aUNJbE1lZjk1SFlNMC8zS1ZY?=
 =?utf-8?B?TlRFLzhBYmhZK096QXFFREhsREFnMENXc2JackR1OGxpZ2hWUFdWNDlkNGFm?=
 =?utf-8?B?VmhmQzNlQlJudlpiRDhxWW53SEtQMXVnNEtIOUZKSkZFS2J6ZTlIaVBSOVIz?=
 =?utf-8?B?NE1uUmxQclBPbWZMdnF4STdEWVRkU1ZvcGpyNGgzSjVsOElzTjRTZ2ovUE9P?=
 =?utf-8?B?N0xwS2hkSEk1VkVDdktkMlk4ZDd1c0hUM21KTDVLQlp0NThrc05xZXdPK2gv?=
 =?utf-8?B?bzgvVmZxaXJ6T3RWdVo4aDZMeG04cjNPc1NvZFNoRjVlWlVhQWhKZE1sT3Jx?=
 =?utf-8?B?Ynd4SmhRODlVYXY5TzNtRS9lUnlyOWV2dVN6QUlkOGJqVEFOalVsejJZWDhn?=
 =?utf-8?B?aXV0VmZ6dHpNdTRUZ3BqSUFWQTFSK0hWNTU5RVhQWVZiTFE5cGttVGFjU3Jp?=
 =?utf-8?B?RStMR05aT3pZNGwraGROQUVxQ3FLUVZXNG1sOUJLMXdvQnVJUGJlMEZsanhN?=
 =?utf-8?B?RG12cUd5eC9iUXZNQUxSeVRaUDdHQk1UbmJkNER3c0JzRXQxa3J3amNBakF0?=
 =?utf-8?B?Nm9IUTIvbVYySkFTdEYzb3VpY0lKVVk5eVAybjdDUDlRVTU2Q25LOFp3aEtD?=
 =?utf-8?B?SkUxTk5RdnJHYW96Z0NTdW1MUFVDRThBNk4wd0lJRUkrYzdkTHVqRE51OCtI?=
 =?utf-8?B?TVozdEpYcW1qTk5YQWJ4OFVZcU02SmdjWUFBT1J6NTJkV2xsWjYvaGFJTnFN?=
 =?utf-8?B?bmFzK2tvZnFZdVRxVngvRjVNdjNITFNvVFlDOHVVK0JoVFNRL3NocUR3eEFt?=
 =?utf-8?Q?mmaVsAhyl4JAPnffuFHn3rgDq1nLWFqTl9DITFc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda4ebe1-c2ae-4917-257a-08d992e10ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 09:15:53.0354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uws6sIwuurMxo14SshOJntGduZp0sv/KjFd5YckYAxwn+38wGzKYocAg1Q1llbAjaXn7zXOE3RmovAPQREAdfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K
PiDlj5Hku7bkuro6IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21h
aWwuY29tPg0KPiDlj5HpgIHml7bpl7Q6IFR1ZXNkYXksIE9jdG9iZXIgMTksIDIwMjEgNDo0NiBQ
TQ0KPiDmlLbku7bkuro6IFlhbmcsIFN0YW5sZXkgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPjsgRGFz
LCBOaXJtb3kNCj4gPE5pcm1veS5EYXNAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+IOS4u+mimDogUmU6IOWbnuWkjTogW1BBVENIIFJldmlldyAxLzFdIGRybS90dG06
IGZpeCBkZWJ1Z2ZzIG5vZGUgY3JlYXRlIGZhaWxlZA0KPiANCj4gQW0gMTkuMTAuMjEgdW0gMTA6
MDIgc2NocmllYiBZYW5nLCBTdGFubGV5Og0KPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHldDQo+
ID4NCj4gPg0KPiA+PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+ID4+IOWPkeS7tuS6ujogYW1k
LWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4g5Luj6KGoIERhcywN
Cj4gTmlybW95DQo+ID4+IOWPkemAgeaXtumXtDogVGh1cnNkYXksIE9jdG9iZXIgMTQsIDIwMjEg
MjoxMSBBTQ0KPiA+PiDmlLbku7bkuro6IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0
enVtZXJrZW5AZ21haWwuY29tPjsgYW1kLQ0KPiA+PiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+ID4+IOS4u+mimDogUmU6IFtQQVRDSCBSZXZpZXcgMS8xXSBkcm0vdHRtOiBmaXggZGVidWdm
cyBub2RlIGNyZWF0ZSBmYWlsZWQNCj4gPj4NCj4gPj4NCj4gPj4gT24gMTAvMTMvMjAyMSAyOjI5
IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPiA+Pj4gQW0gMTIuMTAuMjEgdW0gMTU6MTIg
c2NocmllYiBEYXMsIE5pcm1veToNCj4gPj4+PiBPbiAxMC8xMi8yMDIxIDE6NTggUE0sIFN0YW5s
ZXkuWWFuZyB3cm90ZToNCj4gPj4+Pj4gVGVzdCBzY2VuYXJpbzoNCj4gPj4+Pj4gIMKgwqDCoMKg
IG1vZHByb2JlIGFtZGdwdSAtPiBybW1vZCBhbWRncHUgLT4gbW9kcHJvYmUgYW1kZ3B1IEVycm9y
DQo+IGxvZzoNCj4gPj4+Pj4gIMKgwqDCoMKgIFvCoMKgIDU0LjM5NjgwN10gZGVidWdmczogRmls
ZSAncGFnZV9wb29sJyBpbiBkaXJlY3RvcnkgJ2FtZHR0bScNCj4gPj4+Pj4gYWxyZWFkeSBwcmVz
ZW50IQ0KPiA+Pj4+PiAgwqDCoMKgwqAgW8KgwqAgNTQuMzk2ODMzXSBkZWJ1Z2ZzOiBGaWxlICdw
YWdlX3Bvb2xfc2hyaW5rJyBpbiBkaXJlY3RvcnkNCj4gPj4+Pj4gJ2FtZHR0bScgYWxyZWFkeSBw
cmVzZW50IQ0KPiA+Pj4+PiAgwqDCoMKgwqAgW8KgwqAgNTQuMzk2ODQ4XSBkZWJ1Z2ZzOiBGaWxl
ICdidWZmZXJfb2JqZWN0cycgaW4gZGlyZWN0b3J5DQo+ID4+Pj4+ICdhbWR0dG0nIGFscmVhZHkg
cHJlc2VudCENCj4gPj4+Pg0KPiA+Pj4+IFdlIHNob3VsZCBpbnN0ZWFkIGFkZCBhIGNoZWNrIGlm
IHRob3NlIGRlYnVnZnMgZmlsZXMgYWxyZWFkeQ0KPiA+Pj4+IGV4aXN0L2NyZWF0ZWQgaW4gdHRt
IGRlYnVnZnMgZGlyIHVzaW5nIGRlYnVnZnNfbG9va3VwKCkgYmVmb3JlIGNyZWF0aW5nLg0KPiA+
Pj4gTm8sIElJUkMgdGhlIEludGVsIGd1eXMgaGFkIGZpeGVkIHRoYXQgYWxyZWFkeSBieSBhZGRp
bmcvcmVtb3ZpbmcNCj4gPj4+IHRoZSBkZWJ1Z2ZzIGZpbGUgb24gbW9kdWxlIGxvYWQvdW5sb2Fk
Lg0KPiA+Pg0KPiA+PiBBZGRpbmcvcmVtb3Zpbmcgb24gdHRtIG1vZHVsZSBsb2FkL3VubG9hZCBp
cyBuaWNlci4NCj4gPiBUaGUgcG9pbnQgaXMgdGhhdCBwYWdlX3Bvb2wsIHBhZ2VfcG9vbF9zaHJp
bmsgYW5kIGJ1ZmZlcl9vYmplY3RzIGFyZQ0KPiA+IGNyZWF0ZWQgYnkgYW1kZ3B1IGRyaXZlciwN
Cj4gDQo+IFllYWgsIGJ1dCB0aGUgZGVidWdmcyBmaWxlcyBhcmUgbm90IGNyZWF0ZWQgYnkgdGhl
IGRyaXZlci4gVGhvc2UgYXJlIGdsb2JhbCB0bw0KPiBUVE0gYW5kIGNhbiB0cml2aWFsbHkgYmUg
Y3JlYXRlZCBkdXJpbmcgbW9kdWxlIGxvYWQvdW5sb2FkLg0KW1lhbmcsIFN0YW5sZXldIFRoYW5r
cyBDaHJpc3RpYW4sIEkgZG91YmxlIGNoZWNrIHR0bSByZWxhdGVkIGNvZGUgdGhlIHR0bSBsb2Fk
IHdpbGwgY3JlYXRlIHRob3NlIGRlYnVnZnMgZmlsZS4NCg0KU3RhbmxleQ0KPiANCj4gQ2hyaXN0
aWFuLg0KPiANCj4gPiAgIEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gcmVtb3ZlIHRoZW0gYnkgYW1k
Z3B1IG1vZHVsZSBkdWUgdG8gYW1kZ3B1DQo+ID4gbW9kdWxlIGNyZWF0ZSB0aGVtLCBvdGhlcndp
c2UsIHRoZXJlIHdpbGwgYmUgYSBzY2VuZSBjcmVhdGUgdGhlbSBmYWlsZWQNCj4gb25seSByZWxv
YWQgYW1kZ3B1IG1vZHVsZS4NCj4gPg0KPiA+IFN0YW5sZXkNCj4gPj4NCj4gPj4gTmlybW95DQo+
ID4+DQo+ID4+Pg0KPiA+Pj4gQ2hyaXN0aWFuLg0KPiA+Pj4NCj4gPj4+Pg0KPiA+Pj4+IFJlZ2Fy
ZHMsDQo+ID4+Pj4NCj4gPj4+PiBOaXJtb3kNCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4NCj4gPj4+
Pj4gUmVhc29uOg0KPiA+Pj4+PiAgwqDCoMKgwqAgcGFnZV9wb29sLCBwYWdlX3Bvb2xfc2hyaW5r
IGFuZCBidWZmZXJfb2JqZWN0cyBjYW4gYmUNCj4gPj4+Pj4gcmVtb3ZlZCB3aGVuDQo+ID4+Pj4+
ICDCoMKgwqDCoCBybW1vZCBhbWR0dG0sIGluIHRoZSBhYm92ZSB0ZXN0IHNjZW5hcmlvIG9ubHkg
cm1tb2QgYW1kZ3B1LA0KPiA+Pj4+PiBzbyB0aG9zZQ0KPiA+Pj4+PiAgwqDCoMKgwqAgZGVidWdm
cyBub2RlIHdpbGwgbm90IGJlIHJlbW92ZWQsIHRoaXMgY2F1c2VkIGZpbGUgY3JlYXRlIGZhaWxl
ZC4NCj4gPj4+Pj4gU291bHRpb246DQo+ID4+Pj4+ICDCoMKgwqDCoCBjcmVhdGUgdHRtX3BhZ2Ug
ZGlyZWN0b3J5IHVuZGVyIHR0bV9yb290IGRpcmVjdG9yeSB3aGVuDQo+ID4+Pj4+IGluc21vZCBh
bWRncHUsDQo+ID4+Pj4+ICDCoMKgwqDCoCBwYWdlX3Bvb2wsIHBhZ2VfcG9vbF9zaHJpbmsgYW5k
IGJ1ZmZlcl9vYmplY3RzIGFyZSBzdG9yZWQgaW4NCj4gPj4+Pj4gdHRtX3BhZ2UgZGlyZWN0aXJ5
LA0KPiA+Pj4+PiAgwqDCoMKgwqAgcmVtb3ZlIHR0bV9wYWdlIGRpcmVjdG9yeSB3aGVuIGRvIHJt
bW9kIGFtZGdwdSwgdGhpcyBjYW4gZml4DQo+ID4+Pj4+IGFib3ZlIGlzc3VlLg0KPiA+Pj4+Pg0K
PiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTdGFubGV5LllhbmcgPFN0YW5sZXkuWWFuZ0BhbWQuY29t
Pg0KPiA+Pj4+PiAtLS0NCj4gPj4+Pj4gIMKgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2Rldmlj
ZS5jIHwgMTIgKysrKysrKysrKystDQo+ID4+Pj4+ICDCoCBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0
bV9tb2R1bGUuYyB8wqAgMSArDQo+ID4+Pj4+ICDCoCBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9t
b2R1bGUuaCB8wqAgMSArDQo+ID4+Pj4+ICDCoCBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wb29s
LmPCoMKgIHzCoCA0ICsrLS0NCj4gPj4+Pj4gIMKgIDQgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPj4+Pj4NCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS90dG0vdHRtX2RldmljZS5jDQo+ID4+Pj4+IGIvZHJpdmVycy9ncHUvZHJt
L3R0bS90dG1fZGV2aWNlLmMNCj4gPj4+Pj4gaW5kZXggMWRlMjNlZGJjMTgyLi5hZDE3MDMyOGYw
YzggMTAwNjQ0DQo+ID4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2RldmljZS5j
DQo+ID4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2RldmljZS5jDQo+ID4+Pj4+
IEBAIC01NSw2ICs1NSwxMCBAQCBzdGF0aWMgdm9pZCB0dG1fZ2xvYmFsX3JlbGVhc2Uodm9pZCkN
Cj4gPj4+Pj4gIMKgIMKgwqDCoMKgwqAgdHRtX3Bvb2xfbWdyX2ZpbmkoKTsNCj4gPj4+Pj4gIMKg
ICsjaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQo+ID4+Pj4+ICvCoMKgwqAgZGVidWdmc19yZW1vdmUo
dHRtX2RlYnVnZnNfcGFnZSk7ICNlbmRpZg0KPiA+Pj4+PiArDQo+ID4+Pj4+ICDCoMKgwqDCoMKg
IF9fZnJlZV9wYWdlKGdsb2ItPmR1bW15X3JlYWRfcGFnZSk7DQo+ID4+Pj4+ICDCoMKgwqDCoMKg
IG1lbXNldChnbG9iLCAwLCBzaXplb2YoKmdsb2IpKTsNCj4gPj4+Pj4gIMKgIG91dDoNCj4gPj4+
Pj4gQEAgLTg1LDYgKzg5LDEwIEBAIHN0YXRpYyBpbnQgdHRtX2dsb2JhbF9pbml0KHZvaWQpDQo+
ID4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgPj4gUEFHRV9TSElGVDsNCj4gPj4+Pj4gIMKgwqDC
oMKgwqAgbnVtX2RtYTMyID0gbWluKG51bV9kbWEzMiwgMlVMIDw8ICgzMCAtIFBBR0VfU0hJRlQp
KTsNCj4gPj4+Pj4gIMKgICsjaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQo+ID4+Pj4+ICvCoMKgwqAg
dHRtX2RlYnVnZnNfcGFnZSA9IGRlYnVnZnNfY3JlYXRlX2RpcigidHRtX3BhZ2UiLA0KPiA+Pj4+
PiB0dG1fZGVidWdmc19yb290KTsNCj4gPj4+Pj4gKyNlbmRpZg0KPiA+Pj4+PiArDQo+ID4+Pj4+
ICDCoMKgwqDCoMKgIHR0bV9wb29sX21ncl9pbml0KG51bV9wYWdlcyk7DQo+ID4+Pj4+ICDCoMKg
wqDCoMKgIHR0bV90dF9tZ3JfaW5pdChudW1fcGFnZXMsIG51bV9kbWEzMik7DQo+ID4+Pj4+ICDC
oCBAQCAtOTgsOCArMTA2LDEwIEBAIHN0YXRpYyBpbnQgdHRtX2dsb2JhbF9pbml0KHZvaWQpDQo+
ID4+Pj4+ICDCoMKgwqDCoMKgIElOSVRfTElTVF9IRUFEKCZnbG9iLT5kZXZpY2VfbGlzdCk7DQo+
ID4+Pj4+ICDCoMKgwqDCoMKgIGF0b21pY19zZXQoJmdsb2ItPmJvX2NvdW50LCAwKTsNCj4gPj4+
Pj4gIMKgIC3CoMKgwqAgZGVidWdmc19jcmVhdGVfYXRvbWljX3QoImJ1ZmZlcl9vYmplY3RzIiwg
MDQ0NCwNCj4gPj4+Pj4gdHRtX2RlYnVnZnNfcm9vdCwNCj4gPj4+Pj4gKyNpZmRlZiBDT05GSUdf
REVCVUdfRlMNCj4gPj4+Pj4gK8KgwqDCoCBkZWJ1Z2ZzX2NyZWF0ZV9hdG9taWNfdCgiYnVmZmVy
X29iamVjdHMiLCAwNDQ0LA0KPiA+Pj4+PiArdHRtX2RlYnVnZnNfcGFnZSwNCj4gPj4+Pj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmdsb2ItPmJvX2NvdW50KTsNCj4gPj4+
Pj4gKyNlbmRpZg0KPiA+Pj4+PiAgwqAgb3V0Og0KPiA+Pj4+PiAgwqDCoMKgwqDCoCBtdXRleF91
bmxvY2soJnR0bV9nbG9iYWxfbXV0ZXgpOw0KPiA+Pj4+PiAgwqDCoMKgwqDCoCByZXR1cm4gcmV0
Ow0KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fbW9kdWxlLmMN
Cj4gPj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9tb2R1bGUuYw0KPiA+Pj4+PiBpbmRl
eCA4ODk3MGE2YjhlMzIuLjY2NTk1ZTZlNzA4NyAxMDA2NDQNCj4gPj4+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL3R0bS90dG1fbW9kdWxlLmMNCj4gPj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L3R0bS90dG1fbW9kdWxlLmMNCj4gPj4+Pj4gQEAgLTM4LDYgKzM4LDcgQEANCj4gPj4+Pj4gIMKg
ICNpbmNsdWRlICJ0dG1fbW9kdWxlLmgiDQo+ID4+Pj4+ICDCoCDCoCBzdHJ1Y3QgZGVudHJ5ICp0
dG1fZGVidWdmc19yb290Ow0KPiA+Pj4+PiArc3RydWN0IGRlbnRyeSAqdHRtX2RlYnVnZnNfcGFn
ZTsNCj4gPj4+Pj4gIMKgIMKgIHN0YXRpYyBpbnQgX19pbml0IHR0bV9pbml0KHZvaWQpDQo+ID4+
Pj4+ICDCoCB7DQo+ID4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9t
b2R1bGUuaA0KPiA+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX21vZHVsZS5oDQo+ID4+
Pj4+IGluZGV4IGQ3Y2FjNWQ0YjgzNS4uNjAwN2RjNjZmNDRlIDEwMDY0NA0KPiA+Pj4+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9tb2R1bGUuaA0KPiA+Pj4+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vdHRtL3R0bV9tb2R1bGUuaA0KPiA+Pj4+PiBAQCAtMzYsNSArMzYsNiBAQA0KPiA+
Pj4+PiAgwqAgc3RydWN0IGRlbnRyeTsNCj4gPj4+Pj4gIMKgIMKgIGV4dGVybiBzdHJ1Y3QgZGVu
dHJ5ICp0dG1fZGVidWdmc19yb290Ow0KPiA+Pj4+PiArZXh0ZXJuIHN0cnVjdCBkZW50cnkgKnR0
bV9kZWJ1Z2ZzX3BhZ2U7DQo+ID4+Pj4+ICDCoCDCoCAjZW5kaWYgLyogX1RUTV9NT0RVTEVfSF8g
Ki8NCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3Bvb2wuYw0K
PiA+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3Bvb2wuYyBpbmRleA0KPiA4YmU3ZmQ3
MTYxZmQuLmVjYjMzZGFhZDdiNQ0KPiA+Pj4+PiAxMDA2NDQNCj4gPj4+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL3R0bS90dG1fcG9vbC5jDQo+ID4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX3Bvb2wuYw0KPiA+Pj4+PiBAQCAtNzA5LDkgKzcwOSw5IEBAIGludCB0dG1fcG9vbF9t
Z3JfaW5pdCh1bnNpZ25lZCBsb25nDQo+IG51bV9wYWdlcykNCj4gPj4+Pj4gIMKgwqDCoMKgwqAg
fQ0KPiA+Pj4+PiAgwqAgwqAgI2lmZGVmIENPTkZJR19ERUJVR19GUw0KPiA+Pj4+PiAtwqDCoMKg
IGRlYnVnZnNfY3JlYXRlX2ZpbGUoInBhZ2VfcG9vbCIsIDA0NDQsIHR0bV9kZWJ1Z2ZzX3Jvb3Qs
DQo+ID4+Pj4+IE5VTEwsDQo+ID4+Pj4+ICvCoMKgwqAgZGVidWdmc19jcmVhdGVfZmlsZSgicGFn
ZV9wb29sIiwgMDQ0NCwgdHRtX2RlYnVnZnNfcGFnZSwNCj4gPj4+Pj4gK05VTEwsDQo+ID4+Pj4+
ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZ0dG1fcG9vbF9kZWJ1Z2ZzX2ds
b2JhbHNfZm9wcyk7DQo+ID4+Pj4+IC3CoMKgwqAgZGVidWdmc19jcmVhdGVfZmlsZSgicGFnZV9w
b29sX3NocmluayIsIDA0MDAsDQo+ID4+Pj4+IHR0bV9kZWJ1Z2ZzX3Jvb3QsIE5VTEwsDQo+ID4+
Pj4+ICvCoMKgwqAgZGVidWdmc19jcmVhdGVfZmlsZSgicGFnZV9wb29sX3NocmluayIsIDA0MDAs
DQo+ID4+Pj4+ICt0dG1fZGVidWdmc19wYWdlLA0KPiA+Pj4+PiBOVUxMLA0KPiA+Pj4+PiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmdHRtX3Bvb2xfZGVidWdmc19zaHJpbmtf
Zm9wcyk7DQo+ID4+Pj4+ICDCoCAjZW5kaWYNCg==
