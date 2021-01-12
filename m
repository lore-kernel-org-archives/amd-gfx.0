Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B59C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB75224F9
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB75224F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 370216E196;
	Tue, 12 Jan 2021 09:31:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B9F6E194
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 09:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Czbv1JTvOxu+nOmHl3bgnIJufSm+fMjTO+R1QiabzRfKa/fkI26qsjjphQTlabVnI5CQnVTyx/GDGfOpaNwaHDmAC1mzjvHu2fGSLaUOT3t3Yok2jQyAxN3M3RnlaNfKgM7yUkbo52QTdmIQXow0uCY9mKTYteVEQ71/X/4fHCiAEy6pat8uUQ+TtN3FmwE5sbG3RvampPTCu+tAmbOao3C1TVtB94IQl7M+uTrSPiagwWVktj5bqbK8gQMgbBGdJ1DMuNbwG9p6K2Tuw/6pOoE4BbaRgHocyMwPHJrEfC4JsPmQLRnomjrv3btBhzi3UXKWJ0MJfLKbsIRx2b3pvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C30aBFiZEljLEhsr165YYhpR5k31bvhOIrt0gsCD6Nc=;
 b=HabNDVreMDY7l9oYZez+jsaaKCUC2vKJHpIhiCYIjM4qvToU/J64+cCt6bHsY5kip1qBCMAoOjHeQM+4DXm/9v3iAGKSb5r8JsR91RnFmW+sOhlaBz/ZlAxeMUrR34EJRDR6kcHKz0iYSECsawesg5xM8r6U5tJz25Bxt+ODFx+zzfUNLgP1mInX5uSTyNsp0piCd+HL4l1fDdP8jH+G+rp8pXQALbS1hOCvQvdJqCA6WQFOxXn4hAIcsxWNFQFAmkgE+CM7yR7IaViYGLrtnSsjxh+vOci73grZAMTbG953hF/1xZBaDsKjKpQptKNeqOzfi7wOZWucm8rwm32nSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C30aBFiZEljLEhsr165YYhpR5k31bvhOIrt0gsCD6Nc=;
 b=vJjHtApWHwkQg2DncxOzjlnIc6K94d6Sx+q+SAcpw6Yo7Bp6+qf36c/WEyUjCRyocGGR7tzfWl/HQq+Wa7LOdrosHqfYQjUxeb/1Oiu3CZ9Rhou5Atm5R/IOlpUgulBUiUorPt0mbhaVc/aGLQlt2DUMAjd9J8uX/EOxQGcQ2oA=
Received: from BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 by BN6PR12MB1809.namprd12.prod.outlook.com (2603:10b6:404:106::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Tue, 12 Jan
 2021 09:31:18 +0000
Received: from BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::7cc1:989:4a2a:ab1e]) by BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::7cc1:989:4a2a:ab1e%10]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 09:31:18 +0000
From: "Du, Xiaojian" <Xiaojian.Du@amd.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [bug report] drm/amd/pm: add the parameters of power profiles for
 vangogh
Thread-Topic: [bug report] drm/amd/pm: add the parameters of power profiles
 for vangogh
Thread-Index: AQHW6MLKwx2JJYtg+U2cCMCuCouBgqojtnyA
Date: Tue, 12 Jan 2021 09:31:17 +0000
Message-ID: <BN6PR12MB1124B4A21CE90B1D1F1533DAF1AA0@BN6PR12MB1124.namprd12.prod.outlook.com>
References: <X/1nfini+LArqHmE@mwanda>
In-Reply-To: <X/1nfini+LArqHmE@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=46fcd93c-5a9d-4b6a-85d1-0000b520cdc3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-12T09:19:18Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e1bac62d-a1dd-459c-4b95-08d8b6dcd091
x-ms-traffictypediagnostic: BN6PR12MB1809:
x-microsoft-antispam-prvs: <BN6PR12MB18096ACE6A5DFBBA00A2522FF1AA0@BN6PR12MB1809.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NJoeVKMY2Nd4aSMCNODKCBp1GqYGll09FHpLS+cxR1ZfXl0ex3Y6FTYfCvDwHQoaQwoEK3CiUf7eRExrajk4ub+RXp54Qv2C4cLiqzuUGafn9RxAiKk8WJbh7hw6KpzCAxtyZyRKJOhqYdvgsdSEh/b9rgnku81jGrv3AkAoHq6rYr7f5gkjRYBJm2lVW4tKbVXRqBgbfz56Td42Y30Lp1AHrD3JWVoQet1IdD1MhcqYoX0vIwUUAAGmJxmkgBr6i21z1xTpcvX2mfcs6ptCHnwJ/x3E7/+OIW8wvy0Ds0VGnT90lbDcH7g+vlJSq7RaQZZTU/zRxIHNqf6jwqDWi2yl9EzQEbwtaDLpyMi1RIRDmLoQYnsnep2jqayQ7GdCXOWDTEgXg2uWu6s0tlZMbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(55016002)(8936002)(83380400001)(86362001)(8676002)(6916009)(26005)(66556008)(4326008)(5660300002)(66476007)(53546011)(316002)(7696005)(66446008)(66946007)(64756008)(76116006)(2906002)(186003)(33656002)(9686003)(52536014)(478600001)(71200400001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?gb2312?B?N3g5Yk1KK093TzlxbUl6RGEwQ0c1MVRDS3hDOU5hUVkyRHAybm5NNVQyclk2?=
 =?gb2312?B?L0Juaks1RWFWWGJkcmpxYUNjUnFHcjRYcXpKbW1iVmIwWm5iYXFrdmdONnpH?=
 =?gb2312?B?bS9FTEdZSW0xL3M2Y2N2Zm5aVGQxbXJoNzYrZjlCRlE0OXNZenFyU3QwYVpF?=
 =?gb2312?B?OEI0dWIzZGVQN1JBYVJERlhzY2xaQjh0VnNPb1lhdE9OR01oN2x0RjN4cXV0?=
 =?gb2312?B?RmR1Mm1adGRnWVBUeWIxMXlxSmxUQUpFaHZtbWQ3akFZTmp6QTM0dUJxRVNJ?=
 =?gb2312?B?d2ppKzRDN0E5ajc5bkx2MlFweTZwRytOSWhMemZKcTZIcFJWb0ZmYXRwZlhp?=
 =?gb2312?B?dVo0NUVNRGg1TWFhMS83Z2RwNkRJSU4vRnlxZFA3MEViN1hjV0VZczhoWnAx?=
 =?gb2312?B?RFAvaUxrQlU0Y3hwdHNUZFlRV0liTUprTUtXbEdkNmc1akwwQ0E3NkhVREww?=
 =?gb2312?B?MGg2SUhPMmpBQVVOcEFyNGZVcnJ4Y2JSKzlGUGdFcEQxbU9LTDJqRzdaZFNB?=
 =?gb2312?B?b0VTNUM5ZFg4Y3hPdWU0VWQ5ZWNETjBKaTY2bWp1emg4a2dhZTZ6aE5DaUZV?=
 =?gb2312?B?Q1JHelc5SEQyRklBbEErWlpqOGswa3ZqSjYvYUxOei9ZZDhYMFcxKzhBd3A5?=
 =?gb2312?B?VGNJL2srVE1iblJrQmFWWEJCWjVkRlJNWWdVd1J6THpMNzloL1pVQy8vRjV6?=
 =?gb2312?B?NU1JMldtN3FRMVhqVWxSVFhVWTVVcG5xd0I1T0l2dUtQY0owcHA3UkYzTmRH?=
 =?gb2312?B?MGpsbWp3ZmJSVDM5VmsyZTlvUGwwNm01SUtxZjlndVZoNkI2TWpoUHpQcU5O?=
 =?gb2312?B?ZmxuakxEM05jOTk3d29JOXdMRkkvYllCTkRHeWR5SGV0NWFmc3JBYWVzODJx?=
 =?gb2312?B?aUNRRHJIS0E1RUhuNUdjbjAvQU1ycXFhYmRYTEZEb2s2UWZYdFp2VEQySXZR?=
 =?gb2312?B?SXJmdk9SdkpnUTQya3RnL1NibENaTVdSSHBQZFBCZjU2RW5SYUZLR2pOUFI2?=
 =?gb2312?B?OUZlUEpQbHBETWNxRzliaEJzUFlvQ2NGRHQ3SWdHdWZnd3VHakYrVWoxWTZV?=
 =?gb2312?B?TFdlSXFTTXZncjlCWjlSdWFMUFdYNGhqR2thWENUQ2FKREpFa0h3NzM1STYv?=
 =?gb2312?B?bGszajArNytTZklSd1pGZ092UHpWand1U1JEYVRMWnVYY2hmMVJuNkwrWWhK?=
 =?gb2312?B?d1hBMktGNmVMS1hIRzNCR3M5MENxc1RQOGh4YytLSFE2Q1N2Z0M1OFZKSlVL?=
 =?gb2312?B?S09OekVSeXZCSXRQSVc3MDdBMHl1ME5XbDZoSXh4Qmd1clJoZkJhTjdhRVZ5?=
 =?gb2312?Q?KmnvyGFmTiK5Y=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bac62d-a1dd-459c-4b95-08d8b6dcd091
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 09:31:17.9879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHOe46bCxMWfYEIwfG7gGXW56/m+sWzjDVZBqXYMV8KooVHBgZ7iEbNeZtYrFUXDLhfhZhNCm+gAhUdcPPfI/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1809
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpU
aGFua3MgZm9yIGRldGFpbGVkIGZlZWRiYWNrLg0KDQpGb3IgVmFuZ29naCBBUFUsIG9ubHkgNSBr
aW5kcyBvZiBwb3dlciBwcm9maWxlIG1vZGUgYXJlIHVzZWQsIHRoZXkgYXJlIGV4cG9ydGVkIGZy
b20gc3dTTVUgZmlybXdhcmUgaGVhZGVyLg0KV2UgZHJpdmVyIHdpbGwgbm90IGFkZCBvdGhlciBw
b3dlciBwcm9maWxlIG1vZGUgd2hpY2ggaXMgY3JlYXRlZCBieSBleHRyYSBoYXJkIGNvZGUuDQpC
dXQgc211IGNvbW1vbiBoZWFkZXIgY29udGFpbnMgNiBraW5kcyBvZiBwb3dlciBwcm9maWxlIG1v
ZGUuDQpTbyBpdCBtZWFucyBvbmUga2luZCBvZiBwb3dlciBwcm9maWxlIG1vZGUgd2lsbCBub3Qg
YmUgdXNlZCBmb3IgVmFuZ29naC4NCkkgd2lsbCBkb3VibGUgY29uZmlybSB0aGlzICJ3YXJuaW5n
IiBhbmQgZml4IGl0IHNvb24uDQoNClRoYW5rcywNClhpYW9qaWFuDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5j
b20+DQpTZW50OiAyMDIxxOox1MIxMsjVIDE3OjEwDQpUbzogRHUsIFhpYW9qaWFuIDxYaWFvamlh
bi5EdUBhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0
OiBbYnVnIHJlcG9ydF0gZHJtL2FtZC9wbTogYWRkIHRoZSBwYXJhbWV0ZXJzIG9mIHBvd2VyIHBy
b2ZpbGVzIGZvciB2YW5nb2doDQoNCkhlbGxvIFhpYW9qaWFuIER1LA0KDQpUaGUgcGF0Y2ggMzA3
ZjA0OWJmY2FkOiAiZHJtL2FtZC9wbTogYWRkIHRoZSBwYXJhbWV0ZXJzIG9mIHBvd2VyIHByb2Zp
bGVzIGZvciB2YW5nb2doIiBmcm9tIEphbiA3LCAyMDIxLCBsZWFkcyB0byB0aGUgZm9sbG93aW5n
IHN0YXRpYyBjaGVja2VyIHdhcm5pbmc6DQoNCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4u
L3BtL3N3c211L3NtdTExL3ZhbmdvZ2hfcHB0LmM6ODAxIHZhbmdvZ2hfZ2V0X3Bvd2VyX3Byb2Zp
bGVfbW9kZSgpDQplcnJvcjogYnVmZmVyIG92ZXJmbG93ICdwcm9maWxlX25hbWUnIDUgPD0gNg0K
DQpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9zd3NtdS9zbXUxMS92YW5nb2doX3Bw
dC5jDQogICA3NzMgIHN0YXRpYyBpbnQgdmFuZ29naF9nZXRfcG93ZXJfcHJvZmlsZV9tb2RlKHN0
cnVjdCBzbXVfY29udGV4dCAqc211LA0KICAgNzc0ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY2hhciAqYnVmKQ0KICAgNzc1ICB7DQogICA3NzYgICAgICAgICAg
c3RhdGljIGNvbnN0IGNoYXIgKnByb2ZpbGVfbmFtZVtdID0gew0KICAgNzc3ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkZVTExfU0NSRUVOXzNEIiwNCiAgIDc3OCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJWSURFTyIsDQogICA3Nzkg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiVlIiLA0KICAgNzgwICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkNPTVBVVEUiLA0KICAgNzgx
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkNVU1RPTSJ9Ow0KDQpU
aGlzIGxpc3QgbGVhdmVzIG91dCBERUZBVUxUIGFuZCBQT1dFUlNBVklORyBwcm9maWxlcywgc28g
SSBkb24ndCB0aGluayBpdCdzIGNvcnJlY3QuDQoNCiAgIDc4MiAgICAgICAgICB1aW50MzJfdCBp
LCBzaXplID0gMDsNCiAgIDc4MyAgICAgICAgICBpbnQxNl90IHdvcmtsb2FkX3R5cGUgPSAwOw0K
ICAgNzg0DQogICA3ODUgICAgICAgICAgaWYgKCFidWYpDQogICA3ODYgICAgICAgICAgICAgICAg
ICByZXR1cm4gLUVJTlZBTDsNCiAgIDc4Nw0KICAgNzg4ICAgICAgICAgIGZvciAoaSA9IDA7IGkg
PD0gUFBfU01DX1BPV0VSX1BST0ZJTEVfQ1VTVE9NOyBpKyspIHsNCiAgIDc4OSAgICAgICAgICAg
ICAgICAgIC8qDQogICA3OTAgICAgICAgICAgICAgICAgICAgKiBDb252IFBQX1NNQ19QT1dFUl9Q
Uk9GSUxFKiB0byBXT1JLTE9BRF9QUExJQl8qX0JJVA0KICAgNzkxICAgICAgICAgICAgICAgICAg
ICogTm90IGFsbCBwcm9maWxlIG1vZGVzIGFyZSBzdXBwb3J0ZWQgb24gdmFuZ29naC4NCiAgIDc5
MiAgICAgICAgICAgICAgICAgICAqLw0KICAgNzkzICAgICAgICAgICAgICAgICAgd29ya2xvYWRf
dHlwZSA9IHNtdV9jbW5fdG9fYXNpY19zcGVjaWZpY19pbmRleChzbXUsDQogICA3OTQgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IENNTjJBU0lDX01BUFBJTkdfV09SS0xPQUQsDQogICA3OTUgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGkpOw0KICAgNzk2DQog
ICA3OTcgICAgICAgICAgICAgICAgICBpZiAod29ya2xvYWRfdHlwZSA8IDApDQogICA3OTggICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KICAgNzk5DQogICA4MDAgICAgICAgICAg
ICAgICAgICBzaXplICs9IHNwcmludGYoYnVmICsgc2l6ZSwgIiUyZCAlMTRzJXNcbiIsDQogICA4
MDEgICAgICAgICAgICAgICAgICAgICAgICAgIGksIHByb2ZpbGVfbmFtZVtpXSwgKGkgPT0gc211
LT5wb3dlcl9wcm9maWxlX21vZGUpID8gIioiIDogIiAiKTsNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXl5eXl5eXl5eXl5eXl5eIEFsc28gaXQgbGVhZHMgdG8gYW4gYXJyYXkg
b3ZlcmZsb3cuDQoNCiAgIDgwMiAgICAgICAgICB9DQogICA4MDMNCiAgIDgwNCAgICAgICAgICBy
ZXR1cm4gc2l6ZTsNCiAgIDgwNSAgfQ0KDQpyZWdhcmRzLA0KZGFuIGNhcnBlbnRlcg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
