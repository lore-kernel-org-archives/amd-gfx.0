Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443E4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 17:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E5261104
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 17:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14E5261104
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E8786E8D1;
	Thu,  9 Sep 2021 17:19:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC2BA6E8D1
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 17:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgtmczNwbCaV30XldIld5joISeAZPS6J4NyHm0XDDUFHsaFp7RdRrsDIGyZbOSxl88y29Hfx5lvTB8HiizRJHBv8hWtB13FBWoeEvT0x31NexFRxJQXn2taQdPxn6OEesdjrwDN7IjMGFpP9gA3OXjJfPluR5zF9wqo+7SEI/0DVbFLvg0Do7pWZssyrQKornB9N4IooqYdAxqeLulo9Ql6PVpGjNoTYnYGUq+S8O2ySPoIXNNoCsQ4tPAW+1puiuJibFQ1JcVSRuAxFALtaN5iuses1sNy2vsJ55xmk43sbzRDvGjKhculuA6ivJPWiHgZ7o82dOhrQ9PAeU6ZKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=MfyFC4o7RF7Ti5prbcTGEgAUtwzQROyyfnyfrMeKX/M=;
 b=Iq90hvwVWpHWuhacLF2GpSdmA4A/WdTYmESM8P8GH942YtYgYFEvi615ljxk/jeVD+/ox75lEO4voUSfHYgBEpXVvvLRIljRr8OJ54thsZAKZqA0ClGhTEI2DDikH9QJMvygvXTAHQ8Ko5/HoQrDx+nHSbFtyMhd5cgDzZwQ93hcL00qvjJt/ULE47CctrQ8dRhEXJEq7WFb07mH7LHzzqBxdFV94ePCMWK/9uA0FJypMpr6I8Z83ZDgqJtslXrtMB7Ag4bH/+cEknv46fweLXzfjCoUI91eNuRGNeKadxLdcaiu/bke6xfI5WYA//fIb6Nsqhgai5rIx608HQlzkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfyFC4o7RF7Ti5prbcTGEgAUtwzQROyyfnyfrMeKX/M=;
 b=zHnhLn67v3sCbdZEJWVT4Ppz0jOFNe5EfBjlSES3CmxyPo4QSOo3HHMD8Xf0Rp8HKSmJy50QDb8299m9FXDfuSJtZ+lU8AkOYdFlwC6k/yk0m5oa2v2CWjGACx/0lpEQAXCRrDLIe3/APb2D5GDHQfWoRovXTRTNPfBTiCFW2Rw=
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Thu, 9 Sep 2021 17:19:28 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::9dd5:3098:565e:d3db]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::9dd5:3098:565e:d3db%9]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 17:19:28 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Get atomicOps info from Host for sriov setup
Thread-Topic: [PATCH] drm/amdgpu: Get atomicOps info from Host for sriov setup
Thread-Index: AQHXpZY/9aCwmQSiL06SQ0MA3YjQeaub68pA
Date: Thu, 9 Sep 2021 17:19:28 +0000
Message-ID: <DM6PR12MB5534B65425AACB923EE05E81F4D59@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20210909155906.16026-1-shaoyun.liu@amd.com>
 <5f2d7782-8530-122e-4082-2b4cad9f4a0e@amd.com>
In-Reply-To: <5f2d7782-8530-122e-4082-2b4cad9f4a0e@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-09T17:19:25Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0001d899-92db-4ec2-bd25-1b589d526a30;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcdfbc36-0baf-49d9-11cd-08d973b5fae6
x-ms-traffictypediagnostic: DM8PR12MB5461:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR12MB5461CBA15683294F9C87F8FAF4D59@DM8PR12MB5461.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ibxDw3UVcRX64OxctrDi/gYm+TblVJCZhxNzD6H0g3qH5WO3Of3ud6BSHdpn+mLreZIU1eqzbU5nRu/ybYDoq1fY8oDTTiPstIajlZwKgxcd8ivI7x25OnaWM59LwvDal2idkA/aXy8XzSKfSFzguCSi8VK5OHAPznL3O3IAxvvX1y+3vrK0aA71M9AIFn6JW1f8zj7gD7/JLy1tQiH+7INvL4XpwlM8QA99RCLCTeTTMoOeZU/EJFUYfrxXUuMTRn3F5t5aK563L1DzlasVgV8bJL2Gt8BTCuB6SCofAlyIvU+A9i01bSYvI7Jufvn85YWqJ1rqATTlq0gKCXTrm0DXC+wGKeeDKXkpZy7DolC5K3zDIhlgMP7wRcd4/uGszoCnFDoDBBNbs+rO2SgPFIg1uAQrOFOQd8jIq1X+Mg1u09zvrdWWrprChv2+FQQpx/UVycZdfOIH6oP3EEEm/9GdA6djjYWdL3CdnsVSQEtZVSUaefD9CBkfvm4I0FnENI4XOa6eblXznHcuOXA50+0azAI/ZE6yaZ3+54g0OOdVwXLJcKAajTmmJEvl6OxalwCaDbgjrPWCb2BPuGdubMuJbcmL3QaZDVNQyDRXDTAI78nnbiEFvWg1C5Omn0e3lh/cdxfYyS523IpZ17SL2S89j8z8oHslbBdHEF9JVeUfn5AQUHjOM4Wg7o9+1M9bQHwpRQyjMkCh/rxzVcgSVw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(9686003)(71200400001)(66476007)(66556008)(66946007)(86362001)(5660300002)(508600001)(76116006)(186003)(83380400001)(38070700005)(8936002)(64756008)(33656002)(2906002)(8676002)(110136005)(6506007)(55016002)(7696005)(38100700002)(52536014)(122000001)(53546011)(316002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1NHSmJBdWVvTEs3RXh2aU02UUxnRUFJRnhGTkVNLzVnNkppa3VaRTJTS2JZ?=
 =?utf-8?B?SU1rVDZaMWJSU1NsSlBTK1d2NENSMlg5R05jdUZlTEpBSU1VK0FvQ1AvNHVW?=
 =?utf-8?B?UjRhM1l0MFFGQk1lVWFFdjlKZXp5TmlVbjJESHo5MkltVGpHRGJQdVovTFNi?=
 =?utf-8?B?Y0lJYW45aGVEd2U4Y0x0aWFhTzk3V1k4WlJvcVdZcHFFQ085SFpnSS8yTzVq?=
 =?utf-8?B?T3FyTngyOGpPUzVSWkl2Yko0L0x4aGpLbDI0M2x6Z3F6TFNjT1dIY1BQbFI1?=
 =?utf-8?B?Zy9vUzR0N3pkcjdwcVVxc1F3bkEzbXpZR1l4Szk4ZVhGdTJCemFjc0FlWFNM?=
 =?utf-8?B?bXpkaHZjNHBqVktvS1lkR09xazJQOTZUNERkZkVkUS9Nakc5MDV1N3IrSGd0?=
 =?utf-8?B?RmFsMEJ6R3BhTXJTNXhrQXhWak5ZdjdZVXk2dzh1VjlYcmcwNHVVZEl4Ulhx?=
 =?utf-8?B?WVAyUG80NHF4OXNqNlRlb3cxY3FnYTJxK1BldCtveDh0REVMK3loU29zdURx?=
 =?utf-8?B?WSswZkJpQTJia1dqK1FyTTMranNyaURNRFZBaUR0dnlWdnJpMXF5UXNreC82?=
 =?utf-8?B?S2FhSHdPeEdpNFFRcjlYMDQ1UEJ5cjB5TWNCUkJMMUpRcXg5Ni9wbG40UzJB?=
 =?utf-8?B?OVZBM0ZkNlRISEVjMkNrS0R3RTBOTUhsWVN0NDkxRWdZMlN3bTBrYkZRYmhh?=
 =?utf-8?B?NkNSOFBGdWY2c2hlS1Rqc2cvdHZ3V0Q2UjRQb2Fmb04wbCtJa3UzajVoZUFy?=
 =?utf-8?B?ZHNuek1VVGFSa3AwajdaU1FsdUNPbHhqSHEvd0Rxc2U5ZjN4Z0JGUFFBYTZs?=
 =?utf-8?B?VEpKMnMveVNsNkFvR1EvR0R6RTB2Zk5BRUVsblNqUUR6eDJaZ0hNS1dBU3R3?=
 =?utf-8?B?NU9XbnJmeFo4R1NGelFlejlsangxUzBxOFhYcGZoK2c1QStPZ1I0c3RCaWJj?=
 =?utf-8?B?enpaTFdmOWIvcmVDcWVqNVkzZVhKZWE2RkZTcGkvY1NlbERQZUpNcTRpOVkr?=
 =?utf-8?B?TWs2em82ZWFtWW44cEhwNVBSUXdJeDlmdGY4cEhVSmV1UmJKTk5JR3FKOWhp?=
 =?utf-8?B?TVcyKzRhdmFEK0pLUTZGekJHSG1jZmhCQ2RsSjRta3RGNWJMTVZLSHJjMUt0?=
 =?utf-8?B?YVIyd1FGc0ZzaVIvMWhBRSt1RTd1M3ZURG9Qd0ZzRzNaYzlZb3VaZHltWUNx?=
 =?utf-8?B?UWZ3aGdFTzR4UHc0bTBiaW92Y2NjRytCbDY4SVh5WU1GMDB2dE5PRGgxMmFC?=
 =?utf-8?B?YVNHenYyNGpod2RwWGtWUnh6UlNLd3BzMTBmc3ZIUlo0T215V05TRXpsU2J4?=
 =?utf-8?B?SDNlK08zZVlNOTVHN0RRMDUrdzBONmNkb3lkdlZhcENxV3Z6MkcxRXczVVpF?=
 =?utf-8?B?UXlGVmsrWTZ4UW9EU3c5ZEhuMDByOHdLTklyOXoxNmZVbklDdlZIWFNiRXV2?=
 =?utf-8?B?WC8vYU1HdEZGaHlKNkVFUDJzcllBanI5VUR6OVQzaXgxZGQyQS82d3UwYk5H?=
 =?utf-8?B?VHlIWWJhVi8zbTRFVWdXNFd6Tm1DK1c0MVZxQU9LWXd0eERROFRYdzExdWpi?=
 =?utf-8?B?Qm1waFRZN3ROQXk5K2ZtSmo4Kzc1YXpBMEs0b3R0eEpDL3RGeEhoZlhNdkM5?=
 =?utf-8?B?ZEZ2MHZnQ3pyWm5RR3BnUjFsUEtCaHpNaS9jVzhLSXB0SVBWaHV5YXp0dG5U?=
 =?utf-8?B?UlZtTFZxeUtHa1J0Njh3d2pZT1FsSlhNbkduTCtPVklnYUFQT0lGU3Z3cGFI?=
 =?utf-8?Q?bcDZEpyCA+aoLcz2VKa5DxyhrXUXB2MaCl6ivXy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdfbc36-0baf-49d9-11cd-08d973b5fae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 17:19:28.3639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+dB/hqMDcE43GSHtQ9PI6hTiOXsJlCxUZHRbkVv5oM8LsrFXv7x5aCJCmjMe7OjlM5PqSEqSV3Gr1cmtSkG7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KVGhhbmtzIGZvciB0aGUgIHJldmlldyAuICBJIGFj
Y2VwdGVkICB5b3VyIGNvbW1lbnRzIGFuZCAgd2lsbCBzZW50IGFub3RoZXIgY2hhbmdlIGxpc3Qg
Zm9yIHJldmlldyBvbmNlIHlvdXIgY2hhbmdlIGlzIGluLiANCg0KUmVnYXJkcw0KU2hhb3l1bi5s
aXUNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS3VlaGxpbmcsIEZlbGl4
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPiANClNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgOSwg
MjAyMSAxMjoxOCBQTQ0KVG86IExpdSwgU2hhb3l1biA8U2hhb3l1bi5MaXVAYW1kLmNvbT47IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1k
Z3B1OiBHZXQgYXRvbWljT3BzIGluZm8gZnJvbSBIb3N0IGZvciBzcmlvdiBzZXR1cA0KDQpBbSAy
MDIxLTA5LTA5IHVtIDExOjU5IGEubS4gc2NocmllYiBzaGFveXVubDoNCj4gVGhlIEF0b21pY09w
IFJlcXVlc3RlciBFbmFibGUgYml0IGlzIHJlc2VydmVkIGluIFZGcyBhbmQgdGhlIFBGIHZhbHVl
IA0KPiBhcHBsaWVzIHRvIGFsbCBhc3NvY2lhdGVkIFZGcy4gc28gZ3Vlc3QgZHJpdmVyIGNhbiBu
b3QgZGlyZWN0bHkgZW5hYmxlIA0KPiB0aGUgYXRvbWljT3BzIGZvciBWRiwgaXQgZGVwZW5kcyBv
biBQRiB0byBlbmFibGUgaXQuIEluIGN1cnJlbnQgDQo+IGRlc2lnbiwgYW1kZ3B1IGRyaXZlciAg
d2lsbCBnZXQgdGhlIGVuYWJsZWQgYXRvbWljT3BzIGJpdHMgdGhyb3VnaCANCj4gcHJpdmF0ZSBw
ZjJ2ZiBkYXRhDQo+DQo+IFNpZ25lZC1vZmYtYnk6IHNoYW95dW5sIDxzaGFveXVuLmxpdUBhbWQu
Y29tPg0KPiBDaGFuZ2UtSWQ6IElmZGJjYjQzOTZkNjRlM2YzY2JmNmJjYmY3YWI5YzdiMmNiMDYx
MDUyDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
ICB8IDIwICsrKysrKysrKysrKysrKysrKy0tICANCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3Zfc3Jpb3Ztc2cuaCB8ICA0ICsrKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkgIG1vZGUgY2hhbmdlIDEwMDY0NCANCj4gPT4gMTAw
NzU1IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiAgbW9kZSBj
aGFuZ2UgMTAwNjQ0ID0+IDEwMDc1NSANCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3Zfc3Jpb3Ztc2cuaA0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYw0KPiBvbGQgbW9kZSAxMDA2NDQNCj4gbmV3IG1vZGUgMTAwNzU1DQo+IGluZGV4
IDY1M2JkOGZkYWEzMy4uYTBkMmI5ZWI4NGZjDQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMNCj4gQEAgLTIxNjcsOCArMjE2Nyw2IEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X2RldmljZV9pcF9lYXJseV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAg
CQlyZXR1cm4gLUVJTlZBTDsNCj4gIAl9DQo+ICANCj4gLQlhbWRncHVfYW1ka2ZkX2RldmljZV9w
cm9iZShhZGV2KTsNCj4gLQ0KPiAgCWFkZXYtPnBtLnBwX2ZlYXR1cmUgPSBhbWRncHVfcHBfZmVh
dHVyZV9tYXNrOw0KPiAgCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikgfHwgc2NoZWRfcG9saWN5
ID09IEtGRF9TQ0hFRF9QT0xJQ1lfTk9fSFdTKQ0KPiAgCQlhZGV2LT5wbS5wcF9mZWF0dXJlICY9
IH5QUF9HRlhPRkZfTUFTSzsgQEAgLTM1NjIsNiArMzU2MCwyNCBAQCBpbnQgDQo+IGFtZGdwdV9k
ZXZpY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gIAlpZiAocikNCj4gIAkJ
cmV0dXJuIHI7DQo+ICANCj4gKwkvKiBlbmFibGUgUENJRSBhdG9taWMgb3BzICovDQo+ICsJaWYg
KGFtZGdwdV9zcmlvdl9iaW9zKGFkZXYpKQ0KPiArCQlhZGV2LT5oYXZlX2F0b21pY3Nfc3VwcG9y
dCA9ICgoKHN0cnVjdCBhbWRfc3Jpb3ZfbXNnX3BmMnZmX2luZm8gKikNCj4gKwkJCWFkZXYtPnZp
cnQuZndfcmVzZXJ2ZS5wX3BmMnZmKS0+cGNpZV9hdG9taWNfb3BzX2VuYWJsZWRfZmxhZ3MgPT0N
Cj4gKwkJCShQQ0lfRVhQX0RFVkNBUDJfQVRPTUlDX0NPTVAzMiB8IFBDSV9FWFBfREVWQ0FQMl9B
VE9NSUNfQ09NUDY0KSkNCj4gKwkJCT8gVFJVRSA6IEZBTFNFOw0KDQpQbGVhc2UgZG9uJ3QgdXNl
IHRoaXMgImNvbmRpdGlvbiA/IFRSVUUgOiBGQUxTRSIgaWRpb20uIEp1c3QgImNvbmRpdGlvbiIN
CmlzIGdvb2QgZW5vdWdoLg0KDQoNCj4gKwllbHNlDQo+ICsJCWFkZXYtPmhhdmVfYXRvbWljc19z
dXBwb3J0ID0NCj4gKwkJCXBjaV9lbmFibGVfYXRvbWljX29wc190b19yb290KGFkZXYtPnBkZXYs
DQo+ICsJCQkJCSAgUENJX0VYUF9ERVZDQVAyX0FUT01JQ19DT01QMzIgfA0KPiArCQkJCQkgIFBD
SV9FWFBfREVWQ0FQMl9BVE9NSUNfQ09NUDY0KQ0KPiArCQkJPyBGQUxTRSA6IFRSVUU7DQoNClNh
bWUgYXMgYWJvdmUsIGJ1dCBpbiB0aGlzIGNhc2UgaXQncyAiIWNvbmRpdGlvbiIuIEFsc28sIEkg
d291bGQgaGF2ZSBleHBlY3RlZCB0aGF0IHlvdSByZW1vdmUgdGhlIG90aGVyIGNhbGwgdG8gcGNp
X2VuYWJsZV9hdG9taWNfb3BzX3RvX3Jvb3QgZnJvbSB0aGlzIGZ1bmN0aW9uLg0KDQoNCj4gKwlp
ZiAoYWRldi0+aGF2ZV9hdG9taWNzX3N1cHBvcnQgPSBmYWxzZSApDQoNClRoaXMgc2hvdWxkIGJl
ICI9PSIsIGJ1dCBldmVuIGJldHRlciB3b3VsZCBiZSAiaWYNCighYWRldi0+aGF2ZV9hdG9taWNz
X3N1cHBvcnQpIC4uLg0KDQpUaGF0IHNhaWQsIHRoZSBtZXNzYWdlIGJlbG93IG1heSBiZSByZWR1
bmRhbnQuIFRoZSBQQ0llIGF0b21pYyBjaGVjayBpbiBrZ2Qya2ZkX2RldmljZV9pbml0IGFscmVh
ZHkgcHJpbnRzIGFuIGVycm9yIG1lc3NhZ2UgaWYgYXRvbWljcyBhcmUgcmVxdWlyZWQgYnkgdGhl
IEdQVSBidXQgbm90IHN1cHBvcnRlZC4gSWYgeW91IHJlYWxseSB3YW50IHRvIHByaW50IGl0IGZv
ciBpbmZvcm1hdGlvbiBvbiBHUFVzIHdoZXJlIGl0J3Mgbm90IHJlcXVpcmVkLCB1c2UgZGV2X2lu
Zm8gc28gdGhlIG1lc3NhZ2UgY2xlYXJseSBzaG93cyB3aGljaCBHUFUgaW4gYSBtdWx0aS1HUFUg
c3lzdGVtIGl0IHJlZmVycyB0by4NCg0KDQo+ICsJCURSTV9JTkZPKCJQQ0lFIGF0b21pYyBvcHMg
aXMgbm90IHN1cHBvcnRlZFxuIik7DQo+ICsNCj4gKwlhbWRncHVfYW1ka2ZkX2RldmljZV9wcm9i
ZShhZGV2KTsNCg0KVGhpcyBzaG91bGQgbm90IGJlIG5lY2Vzc2FyeS4gSSBqdXN0IHNlbnQgYW5v
dGhlciBwYXRjaCBmb3IgcmV2aWV3IHRoYXQgbW92ZXMgdGhlIFBDSWUgYXRvbWljIGNoZWNrIGlu
IEtGRCBpbnRvIGtnZDJrZmRfZGV2aWNlX2luaXQ6DQoiZHJtL2FtZGtmZDogbWFrZSBuZWVkc19w
Y2llX2F0b21pY3MgRlctdmVyc2lvbiBkZXBlbmRlbnQiLiBTbyBhbWRncHVfYW1ka2ZkX2Rldmlj
ZV9wcm9iZSBjYW4gc3RheSB3aGVyZSBpdCBpcywgaWYgeW91IGNhbiB3YWl0IGEgZmV3IGRheXMg
Zm9yIG15IGNoYW5nZSB0byBnbyBpbiBmaXJzdC4NCg0KUmVnYXJkcywNCsKgIEZlbGl4DQoNCg0K
PiArDQo+ICsNCj4gIAkvKiBkb29yYmVsbCBiYXIgbWFwcGluZyBhbmQgZG9vcmJlbGwgaW5kZXgg
aW5pdCovDQo+ICAJYW1kZ3B1X2RldmljZV9kb29yYmVsbF9pbml0KGFkZXYpOw0KPiAgDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRndl9zcmlvdm1zZy5oIA0K
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGd2X3NyaW92bXNnLmgNCj4gb2xkIG1v
ZGUgMTAwNjQ0DQo+IG5ldyBtb2RlIDEwMDc1NQ0KPiBpbmRleCBhNDM0YzcxZmRlOGUuLjk5NTg5
OTE5MTI4OA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRndl9zcmlvdm1z
Zy5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGd2X3NyaW92bXNnLmgN
Cj4gQEAgLTIwNCw4ICsyMDQsMTAgQEAgc3RydWN0IGFtZF9zcmlvdl9tc2dfcGYydmZfaW5mbyB7
DQo+ICAJfSBtbV9id19tYW5hZ2VtZW50W0FNRF9TUklPVl9NU0dfUkVTRVJWRV9WQ05fSU5TVF07
DQo+ICAJLyogVVVJRCBpbmZvICovDQo+ICAJc3RydWN0IGFtZF9zcmlvdl9tc2dfdXVpZF9pbmZv
IHV1aWRfaW5mbzsNCj4gKwkvKiBwY2llIGF0b21pYyBPcHMgaW5mbyAqLw0KPiArCXVpbnQzMl90
IHBjaWVfYXRvbWljX29wc19lbmFibGVkX2ZsYWdzOw0KPiAgCS8qIHJlc2VydmVkICovDQo+IC0J
dWludDMyX3QgcmVzZXJ2ZWRbMjU2IC0gNDddOw0KPiArCXVpbnQzMl90IHJlc2VydmVkWzI1NiAt
IDQ4XTsNCj4gIH07DQo+ICANCj4gIHN0cnVjdCBhbWRfc3Jpb3ZfbXNnX3ZmMnBmX2luZm9faGVh
ZGVyIHs=
