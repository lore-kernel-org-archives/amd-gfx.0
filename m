Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E80C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 21:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CC7650A6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 21:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CC7650A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C0C6EC5B;
	Fri,  5 Mar 2021 21:34:46 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750043.outbound.protection.outlook.com [40.107.75.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5905D6EC5B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 21:34:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXSiRvHN1znTPrC9vAxD5acLKkPpRdcaLo2venkn5TmlxdRR2FWZ+1P5OFPnvBtP67I3Z3IZKdHTWkDG/ZCt3g37+9eezrWM2o6hIrMajSdsO1k9PRTfe+cncHs+dhDM1zshPkH0lLtgW6e6tJ2sBQjP9PWLfQCWVKtzxFwiIXSSftMdmokPlPe2lknVWKNrMHgxf/z0oWDWbMdmPgDbMlEVMwbxU1Q2pC4romOkRMWHcX8j9uY87Pa2MKRtiNiD3O8Ot+RoZpVTCzCJGj8ayvyyZ9Su64E56qaeJoXgQHxhmKa7mAtTAzDthQZ4zQqX2UA1Ruo2PyICoHOniXr/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIc+7h/WXri52efP9UqPlVbD92LkuZOczhBwoqf8wdE=;
 b=KGxBoqSeMRYx0fY6hpZyoARvjTaRSBjj2IsPuPCRd9hi4OkgdGrmnfPvaV+x1I1qbHEpD95vN6vs64IIxCsG5kUv5UjIz78QhRpk/Cm6dkUw1IFbUYJz6UDK9rEFIiL0N/ez1ZRyOGbRLatHoxDcMNymvLIqPHZ8X3tGjI3Dn+Nzu9d8x7mCwkvv9TINETgZ6Wod/0tf6kyvRRhDY5SBYLbdO+fJgNPjxds8vAJjYg7TK24u0ss5bM6afTOK0E4NTkuO9RMPkbl1ihjSm5E+q6MaNSE9jt4Cl3AD7W5vzYS1cWWLMUjmCrsoqhUcHIt68+bnpFU+55J8m1zltJ2/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIc+7h/WXri52efP9UqPlVbD92LkuZOczhBwoqf8wdE=;
 b=oixU7sYytFPJupJcgLBMJOBcTcc8mp1tC3MmyDXbgy0d3IMlpuBBYMtN4FlKJ23QGRtOXb+as+gS11Q7MZWJ7z4XL8NKkMBPCft0S01jQ8k91PwxjAXi0s68p50r70dBIF1EPgN025x63b2ULd6DtocRbtvrKy0TEEU21elMXTQ=
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM5PR1201MB0026.namprd12.prod.outlook.com (2603:10b6:4:52::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.28; Fri, 5 Mar 2021 21:34:42 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::b193:3bb1:c6d8:aeec]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::b193:3bb1:c6d8:aeec%3]) with mapi id 15.20.3890.028; Fri, 5 Mar 2021
 21:34:42 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add ih waiter on process until checkpoint
Thread-Topic: [PATCH] drm/amdgpu: add ih waiter on process until checkpoint
Thread-Index: AQHXEfu+q7HAnxnL4EaBJVn3EImWUap11S0AgAANbTA=
Date: Fri, 5 Mar 2021 21:34:42 +0000
Message-ID: <DM5PR12MB4680973A86A7DFD76EACC55785969@DM5PR12MB4680.namprd12.prod.outlook.com>
References: <20210305201121.55036-1-jonathan.kim@amd.com>
 <c740e996-2c45-c512-aff1-722c90b0e450@gmail.com>
In-Reply-To: <c740e996-2c45-c512-aff1-722c90b0e450@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2bdeb929-8aef-4d39-ad61-612a75227f19;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-05T21:05:35Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:7a2:ec00:702c:c2e1:c65:eca2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d469f6e-85cd-4221-5215-08d8e01e7cf4
x-ms-traffictypediagnostic: DM5PR1201MB0026:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB002634723E6BD33F32D99AB385969@DM5PR1201MB0026.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IiOs52HHaPIl0bcj3yIWs4fstEPqUvUyigdZlvzVUmUqp/vDytcFbjTOgvyQTxiXtsDjK8RTyYjfX/5bqIy0FOBoCqzQXh8d2oAyd3Pi54CfK7RNnsFUXLluuj/uEsWN8drtudyB3lV6godlBvRy7m4tAu5wEDluyPfrkg1zom1VQ4VV04GhgyaNTJnxX5xYdt/vEVuAXitZfk1I9rZc7ULg+agquZe3UDntCLalI+6qprtTtkUEs6H10hABj4Mf+hvUKbJ/s/24efiAnT8aUa7kDi7EqeMra7PAZVhJ1BbQvBZA7BJyEE7HU72KPc71X5jhUNYFuzzUiA6iV+hFXLnm0vVhwqNWmXHop53ljGgCFHs+ibr5zy7FKdCA6vDjeKN5oK9uKu2JXDcXBU5NvMqG70+2RS5QmOTsL9z/7jk0dtHz8mENb4pbEZVR+wpB6WDJOFrY2lk8uXfN7b0i0efEVQ2uAdKr8rSNwShyZVvTmkEQwSDr1qKg9DJ26thfD1U4f9mjIwgq29kO98rUzA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(2906002)(71200400001)(52536014)(83380400001)(110136005)(54906003)(7696005)(186003)(55016002)(66446008)(9686003)(5660300002)(86362001)(66556008)(66476007)(8936002)(316002)(64756008)(478600001)(76116006)(53546011)(66574015)(8676002)(33656002)(6506007)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?SDZxT29KMlFSQ3FLUGgreWZvY0R6MnRvWnhUU2NyZGJRbnMvVUxzTXRGVU9v?=
 =?utf-8?B?VlhOOEJuT0ZIbE5IQlNxYVZ0dGdma21SbHNGSXhKd1NXZ3FBUkI2ZDVVNWV0?=
 =?utf-8?B?RmdQRm1iTkFZT21YVjBOZUhQaWp1eTlxVmxBZ3ZuWjRNVDR0UlFPOVlJN1dW?=
 =?utf-8?B?Wi93TEtxN3NvOUJRcFlZYXVHN1hqeVMxdlBEcVEzR05jYjVJRzVrdlg4cnpH?=
 =?utf-8?B?Q2N2c3orNHJlMHBaeUxKSms4MDYyZW9ucnBRMU5kaXZTcWFMQzl2bEVhRWlV?=
 =?utf-8?B?MEJzM0tkWkFQbTY1WVoycUcrREZRcUZ3M0hXeWwyTG5XUFc5aFpIZlZHRFBq?=
 =?utf-8?B?MDhvdXZnODE4YldkdXROaXhjV2hydkhmb2lDNFZlT1YwNkJRZGhBTmh5c0ov?=
 =?utf-8?B?NHl3NnF6dUlpTy9LcWNsOXNTVC9QQVNCZ3dwNDR5Y2syN3lzYlVVMGlJWko0?=
 =?utf-8?B?WVhOa01UOWZGeE5YMUExUndQUHpyc2s4TUlkcWk3SnBUM3BXZExoUkJlMVhv?=
 =?utf-8?B?QUdSbXZpMTZHcWQ5ZmpvVjIwQUJrMlNpSldSQ3FFeXZ4cjhGMXBYUnhxV2hp?=
 =?utf-8?B?dFV2TzJtY0d0RlJGOW8waUdDTnZ1Z1kzQlZkVFcyOHYrNVN0Y1RyUUI0LzNm?=
 =?utf-8?B?eENXQnlLa2cwOGppOXJHaVVwOTBvUXlMRVlmYkdWRDFVbFFFWWJXK0NTb0gw?=
 =?utf-8?B?YmhhQjlRYzEyVnhPMkJRODl3eEE5cVNidnNpS0l4WlMwaGdnM3QrdFh3OStM?=
 =?utf-8?B?LysyNmFIY0lLdDgxeER1Q2RXZUJzdEpwcDBHZ0t3V0R6RHlQckRmSFdmeXRr?=
 =?utf-8?B?anlsek9NYlZZU05kOEhTdlFubUZpNTY5bzNKVEhJMEx4bFBubjZWalhzZU45?=
 =?utf-8?B?aXk5eEVncHdwT2dubFV0Z05WQllwUHFzZDBST25rb3NWMGFpeEZEMmt1Vi9N?=
 =?utf-8?B?OExxMStpZ3VHNmw4WnRoSCtQOC9wcGxmZms4Qm0wU00ybkhUSTl2V0hvQ3Jv?=
 =?utf-8?B?RWFVODk2d2p1NmZma1NRSHl6RDlwbEx4bjFSUFJPYllYb2VqcTZ6NDVwRkxl?=
 =?utf-8?B?b2EwWkpNcFJIVVprUFg0OWl4OGpvTkMzbzF4bHpUODlZbkxtUWlUS1NPNFAy?=
 =?utf-8?B?RmVCbVV3cmx1dWpTbzIwanZQV1J4TkhJSStsU2dWdVBibGdKWVlxUXdITitY?=
 =?utf-8?B?bkR3czgyYlRSaG1mTXJMSG54cWMvT3EvMjA3c1haNFBxcmMrdlRTQWpJZ0po?=
 =?utf-8?B?TlVzejZyZ3JzeFJJSW9yckd1aHBxR3NSRzdxSWFOODdwSTNWc0cvWkRTcTVO?=
 =?utf-8?B?d2R2NnVLZkx5eUJXejhnZ3NYSDExUmpRcE0rc09qTlliR3pkNzN4MWJPLzRP?=
 =?utf-8?B?ZWtOd0RycnNwODE1QVo0c2VJMnJNeXFVVHpPVXZkM0hhNXNKYU8veHlKUjh6?=
 =?utf-8?B?OW1IZmtYN0VGYlpDN3Exa2toYlplQmJoWkhtT0hWRG5OcjdIZWozQW0vM2F3?=
 =?utf-8?B?djJlczBUd3gzZXh0VGpoTVlGU05sb1FwSEl1ZS9rMmZPMTc4UzY1UUM4K3A5?=
 =?utf-8?B?NVdiK0JsTUVqVFQ4ejl4OHdXQmdrd1pXdG96alFiS2NDdkQwS01lbDNncmhE?=
 =?utf-8?B?NjNjSndmL3BYa1JEQm1zMnAwbklaRy9LbjBvYS9vNzF5VjZOQXdTV0FUd0o3?=
 =?utf-8?B?VXlHRGIyZjNyQ2JyZFF2ZnhaM3NUUmJWcXp0RU90MytlV0c0WGFVczVoRDhr?=
 =?utf-8?B?cEpjcGs2YnJMaU8vaDFZMFNNVUdUOHBBQ2owSlgwWGpQVTJ5MHNKaHpVeVY4?=
 =?utf-8?B?UUJ1djU3b01DYUx5S1JwbFdYcHBEMzlyQlNHVjRXREFxdExvNVF0aTZlQ0Mv?=
 =?utf-8?Q?3yKeRQDW0RCFu?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d469f6e-85cd-4221-5215-08d8e01e7cf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 21:34:42.1683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9q58ZomFmWlD4cQ30htZH75zYdMT6GHucRdg7SVPEAik61PAM0JegVfTMnpwOudI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0026
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNr
b2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDUs
IDIwMjEgMzoxOCBQTQ0KPiBUbzogS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+
OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IFlhbmcsIFBoaWxpcCA8
UGhpbGlwLllhbmdAYW1kLmNvbT47IEt1ZWhsaW5nLCBGZWxpeA0KPiA8RmVsaXguS3VlaGxpbmdA
YW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGFkZCBpaCB3YWl0ZXIgb24gcHJvY2Vz
cyB1bnRpbCBjaGVja3BvaW50DQo+DQo+IFtDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbF0NCj4NCj4g
QW0gMDUuMDMuMjEgdW0gMjE6MTEgc2NocmllYiBKb25hdGhhbiBLaW06DQo+ID4gQWRkIElIIGZ1
bmN0aW9uIHRvIGFsbG93IGNhbGxlciB0byB3YWl0IHVudGlsIHJpbmcgZW50cmllcyBhcmUNCj4g
PiBwcm9jZXNzZWQgdW50aWwgdGhlIGNoZWNrcG9pbnQgd3JpdGUgcG9pbnRlci4NCj4gPg0KPiA+
IFRoaXMgd2lsbCBiZSBwcmltYXJpbHkgdXNlZCBieSBITU0gdG8gZHJhaW4gcGVuZGluZyBwYWdl
IGZhdWx0DQo+ID4gaW50ZXJydXB0cyBiZWZvcmUgbWVtb3J5IHVubWFwIHRvIHByZXZlbnQgSE1N
IGZyb20gaGFuZGxpbmcgc3RhbGUNCj4gaW50ZXJydXB0cy4NCj4gPg0KPiA+IHYyOiBVcGRhdGUg
dGl0bGUgYW5kIGRlc2NyaXB0aW9uIHRvIGNsYXJpZnkgdXNlLg0KPiA+IEFkZCBycHRyL3dwdHIg
d3JhcCBjb3VudGVyIGNoZWNrcyB0byBndWFyYW50ZWUgcmluZyBlbnRyaWVzIGFyZQ0KPiA+IHBy
b2Nlc3NlZCB1bnRpbCB0aGUgY2hlY2twb2ludC4NCj4NCj4gRmlyc3Qgb2YgYWxsIGFzIEkgc2Fp
ZCBwbGVhc2UgdXNlIGEgd2FpdF9ldmVudCwgYnVzeSB3YWl0aW5nIGlzIGEgY2xlYXIgTkFLLg0K
DQpXaG8gd291bGQgZG8gdGhlIHdha2UgdGhvdWdoPyAgQXJlIHlvdSBzdWdnZXN0aW5nIHdha2Ug
YmUgZG9uZSBpbiBhbWRncHVfaWhfcHJvY2Vzcz8gIE9yIGlzIHdhaXRpbmcgaGFwcGVuaW5nIGJ5
IHRoZSBjYWxsZXIgYW5kIHRoaXMgc2hvdWxkIGdvIHNvbWV3aGVyZSBoaWdoZXIgKGxpa2UgYW1k
Z3B1X2FtZGtmZCBmb3IgZXhhbXBsZSk/DQoNCj4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpv
bmF0aGFuIEtpbSA8am9uYXRoYW4ua2ltQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguYyB8IDY4DQo+ICsrKysrKysrKysrKysrKysr
KysrKysrKystDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguaCB8
ICAyICsNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgNjkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9paC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguYw0K
PiA+IGluZGV4IGRjODUyYWY0ZjNiNy4uOTU0NTE4YjRmYjc5IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5jDQo+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmMNCj4gPiBAQCAtMjIsNyArMjIsNyBAQA0KPiA+
ICAgICovDQo+ID4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGluZy5oPg0KPiA+IC0N
Cj4gPiArI2luY2x1ZGUgPGxpbnV4L3Byb2Nlc3Nvci5oPg0KPiA+ICAgI2luY2x1ZGUgImFtZGdw
dS5oIg0KPiA+ICAgI2luY2x1ZGUgImFtZGdwdV9paC5oIg0KPiA+DQo+ID4gQEAgLTE2MCw2ICsx
NjAsNzIgQEAgdm9pZCBhbWRncHVfaWhfcmluZ193cml0ZShzdHJ1Y3QNCj4gYW1kZ3B1X2loX3Jp
bmcgKmloLCBjb25zdCB1aW50MzJfdCAqaXYsDQo+ID4gICAgICAgfQ0KPiA+ICAgfQ0KPiA+DQo+
ID4gKy8qKg0KPiA+ICsgKiBhbWRncHVfaWhfd2FpdF9vbl9jaGVja3BvaW50X3Byb2Nlc3MgLSB3
YWl0IHRvIHByb2Nlc3MgSVZzIHVwIHRvDQo+ID4gK2NoZWNrcG9pbnQNCj4gPiArICoNCj4gPiAr
ICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcg0KPiA+ICsgKiBAaWg6IGloIHJpbmcgdG8g
cHJvY2Vzcw0KPiA+ICsgKg0KPiA+ICsgKiBVc2VkIHRvIGVuc3VyZSByaW5nIGhhcyBwcm9jZXNz
ZWQgSVZzIHVwIHRvIHRoZSBjaGVja3BvaW50IHdyaXRlDQo+IHBvaW50ZXIuDQo+ID4gKyAqLw0K
PiA+ICtpbnQgYW1kZ3B1X2loX3dhaXRfb25fY2hlY2twb2ludF9wcm9jZXNzKHN0cnVjdCBhbWRn
cHVfZGV2aWNlDQo+ICphZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IGFtZGdwdV9paF9yaW5nICppaCkgew0KPiA+ICsgICAgIHU2NCBycHRyX2No
ZWNrLCB3cHRyX2NoZWNrLCBycHRyX3dyYXAgPSAwLCB3cHRyX3dyYXAgPSAwOw0KPiA+ICsgICAg
IHUzMiBwcmV2X3JwdHIsIHByZXZfd3B0cjsNCj4gPiArDQo+ID4gKyAgICAgaWYgKCFpaC0+ZW5h
YmxlZCB8fCBhZGV2LT5zaHV0ZG93bikNCj4gPiArICAgICAgICAgICAgIHJldHVybiAtRU5PREVW
Ow0KPiA+ICsNCj4gPiArICAgICBwcmV2X3dwdHIgPSBhbWRncHVfaWhfZ2V0X3dwdHIoYWRldiwg
aWgpOw0KPiA+ICsgICAgIC8qIE9yZGVyIHdwdHIgd2l0aCBycHRyLiAqLw0KPiA+ICsgICAgIHJt
YigpOw0KPiA+ICsgICAgIHByZXZfcnB0ciA9IFJFQURfT05DRShpaC0+cnB0cik7DQo+ID4gKyAg
ICAgcnB0cl9jaGVjayA9IHByZXZfcnB0ciB8IChycHRyX3dyYXAgPDwgMzIpOw0KPiA+ICsgICAg
IHdwdHJfY2hlY2sgPSBwcmV2X3dwdHIgfCAod3B0cl93cmFwIDw8IDMyKTsNCj4NCj4gSHVpIHdo
YXQ/IFRoYXQgY2hlY2sgZG9lc24ndCBldmVuIG1ha2UgcmVtb3RlbHkgc2Vuc2UgdG8gbWUuDQoN
CkNhbiB5b3UgY2xhcmlmeSB3aGF0IHlvdSBtZWFudCBieSBjcmVhdGluZyBhIG5ldyA2NCBiaXQg
Y29tcGFyZT8NClNuaXAgZnJvbSB5b3VyIGxhc3QgcmVzcG9uc2U6DQoNCiJUaGlzIHdheSB5b3Ug
ZG8gc29tZXRoaW5nIGxpa2UgdGhpczoNCjEuIGdldCB0aGUgd3JhcCBhcm91bmQgY291bnRlci4N
CjIuIGdldCB3cHRyDQozLiBnZXQgcnB0cg0KNC4gY29tcGFyZSB0aGUgd3JhcCBhcm91bmQgY291
bnRlciB3aXRoIHRoZSBvbGQgb25lLCBpZiBpdCBoYXMgY2hhbmdlZCBzdGFydCBvdmVyIHdpdGgg
IzENCjUuIFVzZSB3cmFwIGFyb3VuZCBjb3VudGVyIGFuZCBycHRyL3dwdHIgdG8gY29tZSB1cCB3
aXRoIDY0Yml0IHZhbHVlcy4NCjYuIENvbXBhcmUgd3B0ciB3aXRoIHJwdHIvd3JhcCBhcm91bmQg
Y291bnRlciB1bnRpbCB3ZSBhcmUgc3VyZSB0aGUgSUhzIGFyZSBwcm9jZXNzZWQuIg0KDQpGcm9t
IGEgZGlzY3Vzc2lvbiB3aXRoIEZlbGl4LCBJIGludGVycHJldGVkIHRoaXMgYXMgYSB3YXkgdG8g
Z3VhcmFudGVlIHJwdHIvd3RwciBvcmRlcmluZyBzbyB0aGF0IHJwdHIgbW9ub3RvbmljYWxseSBm
b2xsb3dzIHdwdHIgcGVyIGNoZWNrLg0KSSdtIGFzc3VtaW5nIHJwdHIvd3B0cnMgYXJlIDMyIGJp
dHMgd2lkZSBieSB0aGUgdXNlIG9mIHB0cl9tYXNrIG9uIHJlYWQvd3JpdGUgZnVuY3Rpb25zIHNv
IGEgcmVzcGVjdGl2ZSBtYXNrIG9mIHJwdHIvd3B0ciB3cmFwIGNvdW50IHRvIHRoZSB0b3AgMzIg
Yml0cyB3b3VsZCBtYXJrIGhvdyBmYXIgYXBhcnQgdGhlIHJwdHIgYW5kIHdwdHIgYXJlIHBlciBj
aGVjay4NCg0KVGhhbmtzLA0KDQpKb24NCg0KPg0KPiBDaHJpc3RpYW4uDQo+DQo+ID4gKw0KPiA+
ICsgICAgIHNwaW5fYmVnaW4oKTsNCj4gPiArICAgICB3aGlsZSAodHJ1ZSkgew0KPiA+ICsgICAg
ICAgICAgICAgYm9vbCBycHRyX3dyYXBwZWQgPSBmYWxzZSwgd3B0cl93cmFwcGVkID0gZmFsc2U7
DQo+ID4gKyAgICAgICAgICAgICB1MzIgcnB0ciwgd3B0cjsNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAgICBzcGluX2NwdV9yZWxheCgpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIC8qIFVwZGF0
ZSB3cHRyIGNoZWNrcG9pbnQvd3JhcCBjb3VudCBjb21wYXJlLiAqLw0KPiA+ICsgICAgICAgICAg
ICAgd3B0ciA9IGFtZGdwdV9paF9nZXRfd3B0cihhZGV2LCBpaCk7DQo+ID4gKyAgICAgICAgICAg
ICBpZiAod3B0ciA8IHByZXZfd3B0cikgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB3cHRy
X3dyYXArKzsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgd3B0cl9jaGVjayA9IHdwdHIgfCAo
d3B0cl93cmFwIDw8IDMyKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgd3B0cl93cmFwcGVk
ID0gdHJ1ZTsNCj4gPiArICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgIHByZXZfd3B0
ciA9IHdwdHI7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgLyogT3JkZXIgd3B0ciB3aXRoIHJw
dHIuICovDQo+ID4gKyAgICAgICAgICAgICBybWIoKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAg
ICAvKiBVcGRhdGUgcnB0ci93cmFwIGNvdW50IGNvbXBhcmUuICovDQo+ID4gKyAgICAgICAgICAg
ICBycHRyID0gUkVBRF9PTkNFKGloLT5ycHRyKTsNCj4gPiArICAgICAgICAgICAgIGlmIChycHRy
IDwgcHJldl9ycHRyKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJwdHJfd3JhcCsrOw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICBycHRyX3dyYXBwZWQgPSB0cnVlOw0KPiA+ICsgICAg
ICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICAgcnB0cl9jaGVjayA9IHJwdHIgfCAocnB0cl93
cmFwIDw8IDMyKTsNCj4gPiArICAgICAgICAgICAgIHByZXZfcnB0ciA9IHJwdHI7DQo+ID4gKw0K
PiA+ICsgICAgICAgICAgICAgLyogV3JhcHBpbmcgb2NjdXJyZWQgc28gcmVzdGFydC4gKi8NCj4g
PiArICAgICAgICAgICAgIGlmIChycHRyX3dyYXBwZWQgfHwgd3B0cl93cmFwcGVkKQ0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAv
KiBFeGl0IG9uIHJlYWNoaW5nIG9yIHBhc3NpbmcgY2hlY2twb2ludC4gKi8NCj4gPiArICAgICAg
ICAgICAgIGlmIChycHRyX2NoZWNrID49IHdwdHJfY2hlY2sgJiYNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHJwdHIgPj0gKHdwdHJfY2hlY2sgJiBpaC0+cHRyX21h
c2spKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICB9DQo+ID4g
KyAgICAgc3Bpbl9lbmQoKTsNCj4gPiArDQo+ID4gKyAgICAgcmV0dXJuIDA7DQo+ID4gK30NCj4g
PiArDQo+ID4gICAvKioNCj4gPiAgICAqIGFtZGdwdV9paF9wcm9jZXNzIC0gaW50ZXJydXB0IGhh
bmRsZXINCj4gPiAgICAqDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9paC5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
aWguaA0KPiA+IGluZGV4IDZlZDRhODVmYzdjMy4uNjgxN2YwYTgxMmQyIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oDQo+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmgNCj4gPiBAQCAtODcsNiArODcsOCBA
QCBpbnQgYW1kZ3B1X2loX3JpbmdfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4g
c3RydWN0IGFtZGdwdV9paF9yaW5nICppaCwNCj4gPiAgIHZvaWQgYW1kZ3B1X2loX3JpbmdfZmlu
aShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0DQo+IGFtZGdwdV9paF9yaW5nICpp
aCk7DQo+ID4gICB2b2lkIGFtZGdwdV9paF9yaW5nX3dyaXRlKHN0cnVjdCBhbWRncHVfaWhfcmlu
ZyAqaWgsIGNvbnN0IHVpbnQzMl90ICppdiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB1
bnNpZ25lZCBpbnQgbnVtX2R3KTsNCj4gPiAraW50IGFtZGdwdV9paF93YWl0X29uX2NoZWNrcG9p
bnRfcHJvY2VzcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldiwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfaWhfcmluZyAqaWgpOw0K
PiA+ICAgaW50IGFtZGdwdV9paF9wcm9jZXNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBz
dHJ1Y3QNCj4gYW1kZ3B1X2loX3JpbmcgKmloKTsNCj4gPiAgIHZvaWQgYW1kZ3B1X2loX2RlY29k
ZV9pdl9oZWxwZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9paF9yaW5nICppaCwNCg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
