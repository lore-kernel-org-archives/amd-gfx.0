Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C67C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Mar 2022 20:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FB8510EA72;
	Fri, 11 Mar 2022 20:22:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A37E710EA72
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Mar 2022 20:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiFJEQV+pNbQ4hZogWXSjyAN6ie7bTUL6p+kuhFLHTPoPGHbduX+Iyc/z29y+MnyxmYprXMmnHZp6dPliuaL0HUKNMIUh3NnSYMl1jzbKYhHY/2tmXJf+VKgMfSOtvw2CVDAYRfDYnJGGv0jk2cy4U/v0YC6pho3E5P9M28f3r5gTtp06yBaPDp7Zs0ORF/11t6io64g1B4Oas/KMHoDmZYlCPy+8f5oi4ycCxP9VGWk5r9cgXS/eBOM1T0opV/eJPEX/eDb7kp7/e0WBiv2nqHzZdPTIP0/V3WnZNoqhIbzp9Zn9MpyWzR8/4hrEMHuOyoa41tl/iTpk2jhGgSSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXXJSPphAR72D+qhUqA87fY05b63KbePEQRmycU6Rr4=;
 b=FLzCLcHaOPoZeeEnLYOt7jmvsGLGn52P33dKExZ9UQGsPmGVNdBzYvWHW3EyMfm1ls2sEpsmCc/+9DV6ilZBaDlqOcgIhchEewsPnP+49tY1WiHYquly0gW6fuIYaCSWuau2Jn300nLN9Y4OiK4zjgoAOShANskJjpFFGEShZrEhdLhCHTpNtViQ5C1yhvAf2cl/KSEnKJ3MTI6Wcd85FNEV4pwxLtqHdSB7rc9kM+AjxyAXkUpRN5PntRaip9kTfA57okp9Xaa9bK+cY1idxjtblW7dJT5hDsHjvAJJKMXydVOD95jw0+QdFyz4JcBQQY7AAdqH9zpmtYLQgO2sIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXXJSPphAR72D+qhUqA87fY05b63KbePEQRmycU6Rr4=;
 b=fwvLR9Nonpmf3h5/Xz6Q2xgjuWguIK9bKyGAQeX1J2xd+lefSBhCTqk0pU8nmd4o/gQJId7+eGG/gjcZMGbZUIQ011RK82qTxZdL7FijkLzfR/tWWUe/SyXs20YG/NfqhOdeINjcoQh+tYBY+EWiK/KdyRiwvfUvVKO9wN+SR48=
Received: from CY4PR12MB1943.namprd12.prod.outlook.com (2603:10b6:903:11b::7)
 by DM6PR12MB2668.namprd12.prod.outlook.com (2603:10b6:5:4a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.23; Fri, 11 Mar
 2022 20:22:11 +0000
Received: from CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::98c1:8aaf:3e7a:c047]) by CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::98c1:8aaf:3e7a:c047%3]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 20:22:11 +0000
From: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu/pm: Don't show `smartshift_*_power` files for APUs
Thread-Topic: [PATCH] amdgpu/pm: Don't show `smartshift_*_power` files for APUs
Thread-Index: AQHYNAIz8gXcIFS5FkaCK/x4eZebDqy4F0IAgABbuTCAAHqTAIABsYPg
Date: Fri, 11 Mar 2022 20:22:11 +0000
Message-ID: <CY4PR12MB19435F6E7D5364F102C71F629D0C9@CY4PR12MB1943.namprd12.prod.outlook.com>
References: <20220309220548.2541074-1-mario.limonciello@amd.com>
 <237ec5cb-44e3-0f94-c439-9b6742e7740b@amd.com>
 <CY4PR12MB19436AA4A2EDF04562418F309D0B9@CY4PR12MB1943.namprd12.prod.outlook.com>
 <BL1PR12MB515733F013923BFE37DF412DE20B9@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB515733F013923BFE37DF412DE20B9@BL1PR12MB5157.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-10T10:56:31Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7bee2aa0-f89b-457f-99da-f48f89ac040d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-11T20:22:07Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 44cde207-bee0-4e9b-971d-604655689c2f
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4cd84c6-2e48-4e25-bec5-08da039cd2ee
x-ms-traffictypediagnostic: DM6PR12MB2668:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2668C70959A1FF4EF8CADFE09D0C9@DM6PR12MB2668.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tMDo07ySXzwUBes48bUdf2KUZVsW/UNguB+aSD+YcXUrcaiHIApka099VvyGkxXIb3g35sXdlj0WG9VzFohFCf58zrcdK1Cq5Dd+ybbsEXVL/Qz5p+cJnYx5wHhCqJc4kUiV3BUes0/+VC5Kr6001Xk8aDkn7/ZKoeQtzfgaY0ONHBYsh5yno0IYT2E0UIG/zHE+exJb7Mjbdjy+XCE3nBMXngka+lSKhn6llQhjTBz8JSFJ2laf4zir+Kq2Q0G9fAUrimizWXRHJp34r/vVCkIxyX6mPVj2lITIVkqQ6tuhnYFD9aGXqGG8lsp0LiJaf/nsBTocQZIvHdcK6yFwJI96AkOzdEJTayoNZX31PuLaOlPBoLaRxtH9Uji1MX5W3er9zUYpJnmrNoqNzlOOVwnw4Sp4vB9MdgIW3WmURFq2nLYmRJlZcawckebdBu0q7kdpLvrib+XLYLNg6jEpbmdO7LRl5KeyPV9HnEmSo0yeOx1AwvzMK7DmGUS5LJ1O8zJ6/FzwHBVnluAznAHBVvCIWBOEErN8/waBpcRrf8BPN9Iz0iF1OOfRepA713sdq6c02XSl65+T/ZJ/X2Rugt/IO3WGDv1Te16fqqzvPGaX5henudKWlNKSDkdAOPbBtmJzLmp+/u3i86DW+PwTd6WlJiieVarK2YSvUyJrdPW2nV6scYiM8eKW6ttbTNJOA2eVLZ28kzswVgflHCkwkST4Lv8A6tNYyUFBPAooPJ4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1943.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(8936002)(38070700005)(86362001)(55016003)(5660300002)(53546011)(316002)(2906002)(76116006)(66476007)(66556008)(8676002)(66446008)(64756008)(66946007)(83380400001)(122000001)(33656002)(38100700002)(508600001)(110136005)(26005)(186003)(71200400001)(9686003)(7696005)(6506007)(81973001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGNlMWNTWnc1UXlyWkNSWmpZenREVVdIcFJYaHlVM1E3dE9uWDgrQ1ZkV2F5?=
 =?utf-8?B?VnVBQTdodWxkN1Y2VWZEblV1Ry85Tlg4bjg0bzBNRzJKeVJhM0RsbFBmaTBt?=
 =?utf-8?B?eXVkUWhJYWMrd2pXZWxDZUlqSGJ3Ui9MWmxRSVV2eWlMNS9VeHN2Uld1OVdq?=
 =?utf-8?B?NWhrOUNzL2U2d0VidTMwZ3A2NUdYd2pJMjNNY0JrQW1Wemx5aS9aRklJNUc4?=
 =?utf-8?B?MlQzY3lsREEzQSttb1hzYld5am91UHJKMVkxdmc0SktQTkdiWHJLYWxDemUx?=
 =?utf-8?B?TzNQTjRWU0NjMlU5Rm1UOC9NNTZxdU4yTCt3TG1CRXQzYk03UlVnTGxSUWxK?=
 =?utf-8?B?dGhacnFBenBXUjlvSTBhNlZCUTdlYU5jM0pCcU0ydmZXeXNhUDBMUWtlTitu?=
 =?utf-8?B?Rm1kditJRGpTQlViSkxEZ3Zhb1NsUGN4Qkg1STJPMjZZVWxzZ1BvSGFJMDFk?=
 =?utf-8?B?UVlDMlNBSk5qYnlkUmFRRFJTMVdMb01ZN0x6SmdyWXUza29IcEY1OWZrSWpj?=
 =?utf-8?B?TDN4RjZYZlVYSkJmR0hGRkVRVmh3WTZDR3NZSVdrUlpVcW04YUtlblB6Rzl4?=
 =?utf-8?B?WkpkSGZ5S0M2eXV1dUk1L0tKZ0tTZ2lmbStjdzFlek1PNU5tdjQrTC9yTDY3?=
 =?utf-8?B?UjdwcDhKcmFmK0Jsbk1nVVVlQis4NytkYUpIUzNKT3lyY21wV2JDZk5RQndk?=
 =?utf-8?B?WVhjaFpscjltZUhHdmFWSGtJYzdMSEFtb1NWamdRSm5XcmQySjVMdDJ2Tk9n?=
 =?utf-8?B?Z2ZobmsrUjVIZjFzaFRrTEw4WXozSUlTZG1WS3FrUUNrSzh3ZmtSWitTMzBU?=
 =?utf-8?B?enNjQVhGSSs5VDhzR0l1VlFWanNSRUF6dDc3VzVVbEUxSnNwb1MyOHJJWTl5?=
 =?utf-8?B?Ti9aLzJLc290U0tVRmhKOHJlWnE3VlNWcFQ5WkgyLzIzbjk5NUxFbFlrd2lQ?=
 =?utf-8?B?d1gxZms3KzZieUNvMXFvTE9LdFdNd0FocUsrYitybHQxdWlEQ3c4L2lOVW85?=
 =?utf-8?B?blFabmVkZUlPVFNLWndyWWViMWwvRFArUnhyMVNQTXFISmlnUUVEUDFyOEdp?=
 =?utf-8?B?dDhudmNwWGJlQ1F3WFJiUU5nSHBrbmNQeUhoM01ET0hxUXMwcTBDR2hUZ25X?=
 =?utf-8?B?R0t2ZGRNZ3VIUlRDYTRhcmlwVDZvOGtLOHJCRVNEYXhCcXVxRHArYVJKRjU3?=
 =?utf-8?B?L3g2TUpibmhhelFUV2FjVE1IVE1XNVNYT2h2U2ZkUzk4dXNJdWEyOW1neXgz?=
 =?utf-8?B?R1EwWnZkdzUvNit0Mk5IYXBFNnlDZE1ObVdQZEt4eFFtd0RER2YvVDI2NGtI?=
 =?utf-8?B?YmVBWmtxL1VHNGtLTjJyYnVlVk5DWHpYb29pMGl0ZUtpbjNMVDV2MkRpVXl1?=
 =?utf-8?B?L0VNcGU3c0UyeGdTcWU5YnNHRkczWHQ1bVdXQ21JcUNaRlRxYzhYTEpnTXVs?=
 =?utf-8?B?azkyY01HM0FkVEVkTlBYTEw4aFAyalJXMUFldGF6Z05nUm95SXlXcXBYZTlG?=
 =?utf-8?B?MkNsWHQ2VkNhMmVPYzhLeERDSjVDSUEzU00wYllUZkJqUVFXMEJBS0JnbmJ3?=
 =?utf-8?B?b1A0L0VuTjQvelZTVlFxNW1NRmZaakpBRWRNMkhoYnF3S1lLWWhDN2VWT2di?=
 =?utf-8?B?cU9FclRUWDhOM0VzL0NraTFOTjhCTmtzT2tkeDgzUTY1WkpVNGh0N1FMbnNx?=
 =?utf-8?B?enIyOTlIc2lIKzFLQ24weDdJcHQ0TlQ4SmowNXhUclhJOUVNL09wNlEra0la?=
 =?utf-8?B?Q0NYT0ZwY0pOeTFsOWRESG5JQ0hOelFnSG0wc0ZwalFNcE5STi84U296N3Y4?=
 =?utf-8?B?SXlTYi83dFN0TE44ZmVncVlzZ2RZMDl5WWhJRTJZOTZRZTlEbnJxQjFPN0c1?=
 =?utf-8?B?WHpWVTFrakxhcklrWTBOS3pWek1UU201d2gyaW9ab29xS2U3RWxQS2dNeFRm?=
 =?utf-8?B?UWlnWjFXRmI5azNGT1UrbEc1TGZFWldQdEp1bVhRZmcyT3BscWwrNGxnZ1ZG?=
 =?utf-8?B?RVNNTmpuSnAwd1pwODU5dUsyNll3UjU2TnlPYlZIQU8xcmZXUzhCY2VDeVpZ?=
 =?utf-8?B?YmNCTUo4YWkxY29Yb0tEaUxlbGlMMTE4c2EwUkxBcHhIaVg3S05lcFdCenMr?=
 =?utf-8?B?M0FUUG83NWNZNmoyVDUwdlp3VG1FckxPeExOSXB4Z0IxL1Z6ZWM0WEV6eFlX?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cd84c6-2e48-4e25-bec5-08da039cd2ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 20:22:11.3896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C54a9tiO/ghZEojxqAk64migvgNfpYfHbYZrhjzrE4LgnH9X5no+j+iboJc8Ww8aMCMqiEK64zzT0D0yR5Zi5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2668
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgTWFyaW8sDQoNCmFtZGdwdV9kZXZpY2Vfc3Vw
cG9ydHNfc21hcnRfc2hpZnQoKSBpcyB0byBjaGVjayBpZiB0aGUgZGV2aWNlIGlzIGRHUFUgYW5k
IHBsYXRmb3JtIHN1cHBvcnRzIHNtYXJ0c2hpZnQuIA0Kd2hpY2ggd291bGQgZmFpbCBmb3IgaUdQ
VSBhbmQgc28gdGhlIGF0dHJfdXBkYXRlKCkgd2lsbCByZXR1cm4gdW5zdXBwb3J0ZWQsIGR1ZSB0
byB0aGlzIG9uIFNTMS4wIHBsYXRmb3JtIHRoZSBlbnRyaWVzIHdvbid0IGJlIGNyZWF0ZWQuDQoN
ClJlZ2FyZHMsDQpTYXRoaXNoIA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
TGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPiANClNlbnQ6IFRo
dXJzZGF5LCBNYXJjaCAxMCwgMjAyMiAxMTo0NSBQTQ0KVG86IFN1bmRhcmFyYWp1LCBTYXRoaXNo
a3VtYXIgPFNhdGhpc2hrdW1hci5TdW5kYXJhcmFqdUBhbWQuY29tPjsgTGF6YXIsIExpam8gPExp
am8uTGF6YXJAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0
OiBSRTogW1BBVENIXSBhbWRncHUvcG06IERvbid0IHNob3cgYHNtYXJ0c2hpZnRfKl9wb3dlcmAg
ZmlsZXMgZm9yIEFQVXMNCg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSSdtIG5vdCBmYW1p
bGlhciB3aXRoIFNTIDEuMCBpbiB0aGlzIHJlZ2FyZCwgY2FuIHlvdSBleHBsYWluIHdoeSBpdCB3
b3VsZCBmYWlsIHRvIG1ha2UgdGhlIGF0dHJpYnV0ZXM/DQpJIHdvdWxkIHRoaW5rIHRoZSBhdHRy
aWJ1dGVzIHNob3VsZCBzaG93IHVwIGJlY2F1c2Ugb2YgYW1kZ3B1X2RldmljZV9zdXBwb3J0c19z
bWFydF9zaGlmdD8NCk9yIGFyZSB0aGUgY2hlY2tzIGRvbmUgaW4gdGhhdCBmdW5jdGlvbiBub3Qg
c3VmZmljaWVudCBmb3IgU1MgMS4wPw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IFN1bmRhcmFyYWp1LCBTYXRoaXNoa3VtYXIgPFNhdGhpc2hrdW1hci5TdW5kYXJhcmFq
dUBhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMTAsIDIwMjIgMDU6MTkNCj4gVG86
IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8gDQo+
IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gYW1kZ3B1L3BtOiBEb24ndCBzaG93IGBzbWFydHNo
aWZ0XypfcG93ZXJgIGZpbGVzIA0KPiBmb3IgQVBVcw0KPiANCj4gW0FNRCBPZmZpY2lhbCBVc2Ug
T25seV0NCj4gDQo+IFRoaXMgd2lsbCBmYWlsIHRvIGNyZWF0ZSB0aGUgc3lzZnMgYXR0cmlidXRl
cyBmb3IgU1MxLjAuDQo+IA0KPiBSZWdhcmRzLA0KPiBTYXRoaXNoDQo+IA0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgDQo+IExhemFyLCBMaWpvDQo+IFNlbnQ6IFRo
dXJzZGF5LCBNYXJjaCAxMCwgMjAyMiAxMDo1OCBBTQ0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlv
IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgYW1kLSANCj4gZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBhbWRncHUvcG06IERvbid0IHNob3cgYHNt
YXJ0c2hpZnRfKl9wb3dlcmAgZmlsZXMgDQo+IGZvciBBUFVzDQo+IA0KPiANCj4gDQo+IE9uIDMv
MTAvMjAyMiAzOjM1IEFNLCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90ZToNCj4gPiBgc21hcnRzaGlm
dF8qX3Bvd2VyYCBmaWxlcyBhcmUgc2hvd2luZyB1cCBvbiBzb21lIE9FTSBwcm9ncmFtcyBvbiAN
Cj4gPiB0aGUgQVBVIGluc3RlYWQgb2YgdGhlIGRHUFUuDQo+ID4NCj4gPiBBZGp1c3QgdGhlIGxv
Z2ljIHRvIHRoZSBmdW5jdGlvbiBgc3NfcG93ZXJfYXR0cl91cGRhdGVgIHRvIGRldGVjdCANCj4g
PiB3aGV0aGVyIG9yIG5vdCB0aGUgYXR0cmlidXRlcyBzaG91bGQgYmUgZXhwb3J0ZWQuDQo+ID4N
Cj4gPiBUaGUgZXhpc3RpbmcgY2hlY2tzIHRoYXQgYXJlIGRyb3BwZWQgYXJlIGFscmVhZHkgaW5j
bHVkZWQgaW4gDQo+ID4gYGFtZGdwdV9kZXZpY2Vfc3VwcG9ydF9zbWFydF9zaGlmdGAsIHNvIHRo
aXMgY2FuIGJlIHNpbXBsaWZpZWQuDQo+ID4gVGhpcyBjYXVzZXMgYXR0cmlidXRlcyB0byBub3Qg
YmUgc2hvd24gb24gQVBVcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2ll
bGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYyB8IDUgKy0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9wbS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL2FtZGdwdV9wbS5jDQo+ID4gaW5kZXggY2JiYmQ0MDc5MjQ5Li5jY2QwNjQ4YzY3ODkg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4gPiBAQCAtMTg4NCwx
MCArMTg4NCw3IEBAIHN0YXRpYyBpbnQgc3NfcG93ZXJfYXR0cl91cGRhdGUoc3RydWN0DQo+IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ID4gICB7DQo+ID4gICAJ
dWludDMyX3Qgc3NfcG93ZXIsIHNpemU7DQo+ID4NCj4gPiAtCWlmICghYW1kZ3B1X2FjcGlfaXNf
cG93ZXJfc2hpZnRfY29udHJvbF9zdXBwb3J0ZWQoKSkNCj4gPiAtCQkqc3RhdGVzID0gQVRUUl9T
VEFURV9VTlNVUFBPUlRFRDsNCj4gPiAtCWVsc2UgaWYgKChhZGV2LT5mbGFncyAmIEFNRF9JU19Q
WCkgJiYNCj4gPiAtDQo+ICFhbWRncHVfZGV2aWNlX3N1cHBvcnRzX3NtYXJ0X3NoaWZ0KGFkZXZf
dG9fZHJtKGFkZXYpKSkNCj4gPiArCWlmICghYW1kZ3B1X2RldmljZV9zdXBwb3J0c19zbWFydF9z
aGlmdChhZGV2X3RvX2RybShhZGV2KSkpDQo+ID4gICAJCSpzdGF0ZXMgPSBBVFRSX1NUQVRFX1VO
U1VQUE9SVEVEOw0KPiANCj4gU1MgMS4wIGF0dHJpYnV0ZXMgYXJlIHN1cHBvcnRlZCBvbiBBUFUg
ZGV2aWNlcy4gV2lsbCB0aGlzIHdvcmsgb24gdGhvc2U/DQo+IA0KPiBUaGFua3MsDQo+IExpam8N
Cj4gDQo+ID4gICAJZWxzZSBpZiAoYW1kZ3B1X2RwbV9yZWFkX3NlbnNvcihhZGV2LA0KPiBBTURH
UFVfUFBfU0VOU09SX1NTX0FQVV9TSEFSRSwNCj4gPiAgIAkJICh2b2lkICopJnNzX3Bvd2VyLCAm
c2l6ZSkpDQo+ID4NCg==
