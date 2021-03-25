Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C950C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 19:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C6D619C9
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 19:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C6D619C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FA566E096;
	Thu, 25 Mar 2021 19:38:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E76F6E096
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 19:38:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ol4us05dJrkAeNX/i+i+p8v/G5RNese5fGFPGFXabM1yx0KGKiEVLdVSpPHrrvRFc7MFVpGu8iZtc0c1jrCmE+Ts/MLNzcdoPfRMfoOaXJKWNGdfdOB3Blig4QtrhrJ7eIvnbDAdq3fvA21zutPgq+8z6ICOE3vShem3q+csCnh4DoobCxnS4bgd4IFUmPhniGJGzN++iYN//oB7WwRfsM8bltHTA66RZO/SbvMI2+b2f28geP112MlSvT2fJeLT1pPgGvTMJ6QadE0759JEZe109k8rIK+ZMiqfMFmrd8gn6JMhqCIzU1Wi6K5txaMH1P+/gwYjTBCdeqaC4w2k6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/q2ZqUdoCoa4JuXVxVBk63G4TaO8TSSArpT359nzjMY=;
 b=nDJqOVRYM+CBpag7wxWulw8In76YAAEOQBnjo94JPAfZpBEhwMNkBXypFg4w5yG5jIiNSKyQDEjl936JnuHK/cW+3LEAqWhVh5sRL/YSNQP3b1DP7JzEGV8eNMoT2NWz9Vti6MMpqYBp5Cj1pC2JDpWc+x//gonmdyZE6rSWn6tnj9OW7/q6Bx7bWyo22qH6Jo2COfHzCZ+EzSWbYhozcHQUODMT5vx4ObZKUO8ZhvhWCpCLMIYmB3/zs7CCd3TslGiNx+Z0Rf3qvVt+rpcFe6FfbctnHPDvUtXWflDsyUfcnXTxq/qOT6yiZo3oHRq92Y39wUkR0cVpLivaXOmfJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/q2ZqUdoCoa4JuXVxVBk63G4TaO8TSSArpT359nzjMY=;
 b=KpIU7Zz6ZLtgbc4IiHafBwvMsTM2ZgoOG+w8cpLuegiv1wzArRl099mBYRH3Wpn+q+mf+ZxCRi/oq+vRTJLoy8khwVy916sU+nM9iWEFo2oZW96evb3pVrJnjxbcK0qIPPdOqrW/0GfRPQNv9KOp4cL9rlbomfpiG9We7sjin9o=
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.23; Thu, 25 Mar 2021 19:38:49 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.3977.026; Thu, 25 Mar 2021
 19:38:48 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Introduce new SETUP_TMR interface
Thread-Topic: [PATCH 2/2] drm/amdgpu: Introduce new SETUP_TMR interface
Thread-Index: AQHXF4YfqrtedAgVh0mkPqVrRWPevqqP1hWAgAHYwoCAAzwAgA==
Date: Thu, 25 Mar 2021 19:38:48 +0000
Message-ID: <B367551A-85C5-4360-B73B-A6D07EAEBB1D@amd.com>
References: <1615584275-16432-1-git-send-email-Oak.Zeng@amd.com>
 <1615584275-16432-2-git-send-email-Oak.Zeng@amd.com>
 <0FD452A0-140A-40CF-A6F6-93F775FBADB2@amd.com>
 <MN2PR12MB45497ABEA192A9158688153A97649@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB45497ABEA192A9158688153A97649@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-23T14:15:12Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=501ea5c7-53ad-45fd-a083-ddfe7c9b256d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
user-agent: Microsoft-MacOutlook/16.46.21021202
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52c0807c-4bed-4c7a-a8cf-08d8efc59cb8
x-ms-traffictypediagnostic: DM6PR12MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4236A4F0F173553848C8AC9A80629@DM6PR12MB4236.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rSs2ivKmhMa6x0Yi1p3hnityWWNvvb1G8RwBFc5NZaXrBd0QXrmDQk13XkYKyZ00hVD5D2W5Np/H55zh5x4p5PJBmXfDWqnks//ciHcfiGc2j1qr6+lV5ykKaLiaNxs5eUC1IP5ttfJF6ny9UCp0Pwt44CSy+x0TgBOIaptC/ZV0WJ1Uj/G5FXGNAZ++KFxE3+DpzQwh1CBZLZ4jFoJAvTRp+/l5swb6dOUrElFATlrU3i2+2xmYGXZMCJpxpMXF+NFw3qbelHUQ45bedzd2A/p3HpKFC/AQlxw/JGoK1Rlak4ic0rI0RjTGcJxS5lPckgejd/yD+IiOeYNZM49Cae2j8gc6Spyyl+1kkXUw8XYhI+o04owTdBhNMlShqKnrya/S9SyQCyg8AYzZTK0acPtu2zihk3DDJLScqslCcMYWuC6AJHqaKtsPmzWy0NS5WZYvNTd38wYB0AOIwZQjCGk2AThr7F/U+ckYxkwvWTibeAQXZMoMmpkD/HmirrQXYLv7A4aWmnKWDGzMGquTsykwbzPga3O2wQ+D3kmAGYH6y4c3Hhp8FuTswGstYc9d9lcjjVwb+Dw4lA+BYxpkgk5cGmOiw0D6bNPkc02gZM8OZYcO+33c0pB/S5fTt14CUWXZfQp8xfXmeysXpLuxnlAPZRSl/Tmwt8lFDPfF73z8vbDsqPzabeMwQNdHjrAoX9aSPH7T+EeYTQML/Fp1sJsg7L4xSWHs5za08GDLkzk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(86362001)(33656002)(2616005)(110136005)(6486002)(38100700001)(54906003)(478600001)(83380400001)(2906002)(64756008)(66946007)(71200400001)(6512007)(4326008)(8676002)(66556008)(966005)(66446008)(5660300002)(91956017)(53546011)(316002)(26005)(76116006)(36756003)(66476007)(186003)(8936002)(45080400002)(6506007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?dVYrOWVNRjI3S2tUQUlVOHV2TjVEK0ZjU0YxY2VIRTBwelFqZHpXTnF2UHhY?=
 =?utf-8?B?NWlPaHZ5RlJsZ2FQV3pkWnNkV2NLeTlCMnhsWmd4ZVBENys5V1NNOGk4dEVa?=
 =?utf-8?B?aGZEWEFxL2kxT0RkSlVYWStJbzIxeW1EVWZrQVRMNVFMai80bTR4ZXJPa1pi?=
 =?utf-8?B?cm1NMCtGcEZRWXRlUElnc0xHS1ZrNDJIb2ZlOW5maWFab0RCY0JUNkYrOGRB?=
 =?utf-8?B?RTNtY2VZOUFKYmluaWRTbHl5UnNYNEdoTXNUTFM1TklRaWkxaDJtSzBMeWpo?=
 =?utf-8?B?ZDNYRE0ycjBxdXVTYWI3L0VndElITUJkVlp6Yy9PZU95ODJDZzErczZrNG8y?=
 =?utf-8?B?cWNYdDdYWE4zdFJGQkxMVjYxRlBSOEN6cjAwWlBFWTc4ZTZVckxTT0lKOCtO?=
 =?utf-8?B?azhmVFdycVhuNzVvdHk4TXJURHdlK2loMlhLQThPalFpcUh0SWxINVJVbzZv?=
 =?utf-8?B?eXlKNkRva1B4U3ptejFHN0NaMVlxblY2ZXJybkpmVW9leDdYTHVQZ3g5djNG?=
 =?utf-8?B?R25CTEY1Rm85djYxYjQrOGRHQnRMVjFJcUNJOGt3Y0xlakJXS3NZdVFqTmRn?=
 =?utf-8?B?VXY3RjZFckZEdmNZVGdSN0o0ZEtTMEkwTlZmNTFqZVBJbmdiRHF3QjRTOHYr?=
 =?utf-8?B?SDJXKzdJL05wMU9KNlV5RFNNUm1uYk9waUU1cEtpOXQzSURvVkxzRVh4elMy?=
 =?utf-8?B?OUtJYk9YbUE1UHZ3RnBxMnNrK1RTM1JsZ0Z1L3Y4VjBuTTU5Q2drUW1kYjYx?=
 =?utf-8?B?amJmUXV1djEveFcvZEdvc1dMR01aS0tMSUlTNDlXWXJVWVVaSkdrVUVhcTVM?=
 =?utf-8?B?RVNjOFdrVkg1eEl1aEtGY3UxeEsxNUw0cUlCakZEY1pjUjVqZ2wxdVVVVEJX?=
 =?utf-8?B?SlFrMXNHR1hlTkJicnBBWEEvSklKbDFQemwzMy9uNUdPa3BYVjdQYnZTRVNv?=
 =?utf-8?B?Q0c4RmFIUmYvVE52RTVQTlBuR2RwUXBEMnRUQzFhb1A2ZG1zVE1ndXh1bkow?=
 =?utf-8?B?K1VBdUNyZUo2Wndpb0lOd0NyNHZYb0krbEYreVhYVWtUL1B0bGZoY2JJVmVL?=
 =?utf-8?B?ZUxpdTNOV09kaDFkdkZibTFLSmlnQUc1K201OTFGeVBMUXdkQ05yK0lMM1dM?=
 =?utf-8?B?clZRWnpNb3MrOG5iaHpOREU4dXlONTNYOTFwV2ZLK2p3WFhyaXVJSlZXZjM2?=
 =?utf-8?B?SEp4Z1M2V0lXeTIyV1RzSG80OHNlb2hxQjhUQU9HcEVEdzQ0ZysvSGIzdHRN?=
 =?utf-8?B?OXo0NXZtTGg5YUMrZjc5aURnSTZQODErclQvY2JtM09VcmVKS1F2ajhnZVA0?=
 =?utf-8?B?cEphR0xhWlYxam8vemRYdjIwRjBtaWFZQ2lwUE8vekxKQmJENS9RMVk3bzNv?=
 =?utf-8?B?cThxTVZ6akNNbW9TRlc0VzRYR3czWi9GN0IwYVI5L2NrQWRhdXcyVWVYZklP?=
 =?utf-8?B?TjlzVS9aTHRaUHc0Zlh6Q2svb2ZBaHprTTdjYWxqbm5BaGlXdkxicExQbTV3?=
 =?utf-8?B?WS9mRmIxQzdNNndOcTZQSld4V0RrU09DQUNUMHhvQ2k2TnpwSDFISWYxMFJB?=
 =?utf-8?B?MVk5SHJPQnUvUjVpTVk4cXdFSnZYYmFoanhiQVp3YURwanRIZFhleWFRM1JF?=
 =?utf-8?B?NG9GVmxnRC9XYXM0S0NyeFVHZUpEdVJoR1VKR0VYOEdvOG5TYWRyTXZGeFE2?=
 =?utf-8?B?Y2QxMWZEV085dktnVVAyeTZvR3pUOWcydUl3SFJPWXlvSkIrcUJ0cGRocXVo?=
 =?utf-8?B?dDNxS2xFQUp5aEEvSmhZZnYwL3puaWl1WEliWXg3WXBLVEgya3AxSmYzTThJ?=
 =?utf-8?B?VThkcVhQay8vL1N5dmEydz09?=
Content-ID: <25F1C3A1DA470546B4CAEFEE02BD791E@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c0807c-4bed-4c7a-a8cf-08d8efc59cb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 19:38:48.8759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: loveDdNDe/KKZ2ifa6LsLz83mp9RWOrkKuhepDTTE2f02JG6aZDy2p5CMoGu21Nn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmsgeW91IExpam8uDQoNCkkgYWRkZWQgdHdvIG1hY3JvIHRvIGNhbGN1bGF0ZSBhIGJvJ3Mg
cGh5c2ljYWwgYWRkcmVzcy4gSSBhbHNvIHVzZWQgdGhvc2UgbWFjcm9zIHRvIHNpbXBsaWZpZWQg
ZHJpdmVyIGEgbGl0dGxlIGJpdC4gUGxlYXNlIGhlbHAgcmV2aWV3DQoNClJlZ2FyZHMsDQpPYWsg
DQoNCiANCg0K77u/T24gMjAyMS0wMy0yMywgMTA6MTUgQU0sICJMYXphciwgTGlqbyIgPExpam8u
TGF6YXJAYW1kLmNvbT4gd3JvdGU6DQoNCiAgICBbQU1EIFB1YmxpYyBVc2VdDQoNCg0KICAgIC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQogICAgRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3Vu
Y2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIFplbmcsIE9haw0KICAgIFNl
bnQ6IE1vbmRheSwgTWFyY2ggMjIsIDIwMjEgNzozMyBQTQ0KICAgIFRvOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KICAgIENjOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5n
QGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KICAgIFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiBJbnRyb2R1Y2UgbmV3IFNFVFVQX1RN
UiBpbnRlcmZhY2UNCg0KICAgIFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRlcm5hbCBEaXN0
cmlidXRpb24gT25seV0NCg0KICAgIFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRlcm5hbCBE
aXN0cmlidXRpb24gT25seV0NCg0KICAgIEhlbGxvIGFsbCwNCg0KICAgIENhbiBzb21lb25lIGhl
bHAgdG8gcmV2aWV3IGJlbG93IHBhdGNoZXM/IFdlIHZlcmlmaWVkIHdpdGggZmlybXdhcmUgdGVh
bSBhbmQgd2FudCB0byBjaGVjay1pbiB0b2dldGhlciB3aXRoIHBzcCBmaXJtd2FyZQ0KDQogICAg
UmVnYXJkcywNCiAgICBPYWsNCg0KDQoNCiAgICBPbiAyMDIxLTAzLTEyLCA0OjI0IFBNLCAiWmVu
ZywgT2FrIiA8T2FrLlplbmdAYW1kLmNvbT4gd3JvdGU6DQoNCiAgICAgICAgVGhpcyBuZXcgaW50
ZXJmYWNlIHBhc3NlcyBib3RoIHZpcnR1YWwgYW5kIHBoeXNpY2FsIGFkZHJlc3MNCiAgICAgICAg
dG8gUFNQLiBJdCBpcyBiYWNrd29yZCBjb21wYXRpYmxlIHdpdGggb2xkIGludGVyZmFjZS4NCg0K
ICAgICAgICBTaWduZWQtb2ZmLWJ5OiBPYWsgWmVuZyA8T2FrLlplbmdAYW1kLmNvbT4NCiAgICAg
ICAgLS0tDQogICAgICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMg
fCAxMyArKysrKysrKysrLS0tDQogICAgICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9w
c3BfZ2Z4X2lmLmggfCAxMSArKysrKysrKysrLQ0KICAgICAgICAgMiBmaWxlcyBjaGFuZ2VkLCAy
MCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQogICAgICAgIGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCiAgICAgICAgaW5kZXggY2QzZWRhOS4uOTllMWEzZSAx
MDA2NDQNCiAgICAgICAgLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Bz
cC5jDQogICAgICAgICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3Au
Yw0KICAgICAgICBAQCAtMzI4LDggKzMyOCwxMyBAQCBwc3BfY21kX3N1Ym1pdF9idWYoc3RydWN0
IHBzcF9jb250ZXh0ICpwc3AsDQoNCiAgICAgICAgIHN0YXRpYyB2b2lkIHBzcF9wcmVwX3Rtcl9j
bWRfYnVmKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwLA0KICAgICAgICAgIHN0cnVjdCBwc3BfZ2Z4
X2NtZF9yZXNwICpjbWQsDQogICAgICAgIC0gdWludDY0X3QgdG1yX21jLCB1aW50MzJfdCBzaXpl
KQ0KICAgICAgICArIHVpbnQ2NF90IHRtcl9tYywgc3RydWN0IGFtZGdwdV9ibyAqdG1yX2JvKQ0K
ICAgICAgICAgew0KICAgICAgICArc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBwc3AtPmFk
ZXY7DQogICAgICAgICt1aW50MzJfdCBzaXplID0gYW1kZ3B1X2JvX3NpemUodG1yX2JvKTsNCiAg
ICAgICAgK3VpbnQ2NF90IHRtcl9wYSA9IGFtZGdwdV9ib19ncHVfb2Zmc2V0KHRtcl9ibykgKw0K
ICAgICAgICArYWRldi0+dm1fbWFuYWdlci52cmFtX2Jhc2Vfb2Zmc2V0IC0gYWRldi0+Z21jLnZy
YW1fc3RhcnQ7DQogICAgICAgICsNCg0KICAgIDw+IFRoaXMgbG9va3MgbGlrZSBhIGNhbmRpZGF0
ZSBmb3IgYSBzbWFsbCBpbmxpbmUgZnVuY3Rpb24gaW4gZ21jLiBQU1AgZG9lc24ndCBuZWVkIHRv
IGtub3cgYWJvdXQgdGhlIGNhbGN1bGF0aW9uLg0KDQogICAgVGhhbmtzLA0KICAgIExpam8NCg0K
ICAgICAgICAgaWYgKGFtZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYpKQ0KICAgICAgICAgY21kLT5j
bWRfaWQgPSBHRlhfQ01EX0lEX1NFVFVQX1ZNUjsNCiAgICAgICAgIGVsc2UNCiAgICAgICAgQEAg
LTMzNyw2ICszNDIsOSBAQCBzdGF0aWMgdm9pZCBwc3BfcHJlcF90bXJfY21kX2J1ZihzdHJ1Y3Qg
cHNwX2NvbnRleHQgKnBzcCwNCiAgICAgICAgIGNtZC0+Y21kLmNtZF9zZXR1cF90bXIuYnVmX3Bo
eV9hZGRyX2xvID0gbG93ZXJfMzJfYml0cyh0bXJfbWMpOw0KICAgICAgICAgY21kLT5jbWQuY21k
X3NldHVwX3Rtci5idWZfcGh5X2FkZHJfaGkgPSB1cHBlcl8zMl9iaXRzKHRtcl9tYyk7DQogICAg
ICAgICBjbWQtPmNtZC5jbWRfc2V0dXBfdG1yLmJ1Zl9zaXplID0gc2l6ZTsNCiAgICAgICAgK2Nt
ZC0+Y21kLmNtZF9zZXR1cF90bXIuYml0ZmllbGQudmlydF9waHlfYWRkciA9IDE7DQogICAgICAg
ICtjbWQtPmNtZC5jbWRfc2V0dXBfdG1yLnN5c3RlbV9waHlfYWRkcl9sbyA9IGxvd2VyXzMyX2Jp
dHModG1yX3BhKTsNCiAgICAgICAgK2NtZC0+Y21kLmNtZF9zZXR1cF90bXIuc3lzdGVtX3BoeV9h
ZGRyX2hpID0gdXBwZXJfMzJfYml0cyh0bXJfcGEpOw0KICAgICAgICAgfQ0KDQogICAgICAgICBz
dGF0aWMgdm9pZCBwc3BfcHJlcF9sb2FkX3RvY19jbWRfYnVmKHN0cnVjdCBwc3BfZ2Z4X2NtZF9y
ZXNwICpjbWQsDQogICAgICAgIEBAIC00NTYsOCArNDY0LDcgQEAgc3RhdGljIGludCBwc3BfdG1y
X2xvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApDQogICAgICAgICBpZiAoIWNtZCkNCiAgICAg
ICAgIHJldHVybiAtRU5PTUVNOw0KDQogICAgICAgIC1wc3BfcHJlcF90bXJfY21kX2J1Zihwc3As
IGNtZCwgcHNwLT50bXJfbWNfYWRkciwNCiAgICAgICAgLSAgICAgYW1kZ3B1X2JvX3NpemUocHNw
LT50bXJfYm8pKTsNCiAgICAgICAgK3BzcF9wcmVwX3Rtcl9jbWRfYnVmKHBzcCwgY21kLCBwc3At
PnRtcl9tY19hZGRyLCBwc3AtPnRtcl9ibyk7DQogICAgICAgICBEUk1fSU5GTygicmVzZXJ2ZSAw
eCVseCBmcm9tIDB4JWxseCBmb3IgUFNQIFRNUlxuIiwNCiAgICAgICAgICBhbWRncHVfYm9fc2l6
ZShwc3AtPnRtcl9ibyksIHBzcC0+dG1yX21jX2FkZHIpOw0KDQogICAgICAgIGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfZ2Z4X2lmLmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9wc3BfZ2Z4X2lmLmgNCiAgICAgICAgaW5kZXggYTQxYjA1NC4uNjA0YTFj
MSAxMDA2NDQNCiAgICAgICAgLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX2dm
eF9pZi5oDQogICAgICAgICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF9nZnhf
aWYuaA0KICAgICAgICBAQCAtMTcwLDEwICsxNzAsMTkgQEAgc3RydWN0IHBzcF9nZnhfY21kX3Nl
dHVwX3Rtcg0KICAgICAgICAgICAgIHVpbnQzMl90ICAgICAgICBidWZfcGh5X2FkZHJfbG87ICAg
ICAgIC8qIGJpdHMgWzMxOjBdIG9mIEdQVSBWaXJ0dWFsIGFkZHJlc3Mgb2YgVE1SIGJ1ZmZlciAo
bXVzdCBiZSA0IEtCIGFsaWduZWQpICovDQogICAgICAgICAgICAgdWludDMyX3QgICAgICAgIGJ1
Zl9waHlfYWRkcl9oaTsgICAgICAgLyogYml0cyBbNjM6MzJdIG9mIEdQVSBWaXJ0dWFsIGFkZHJl
c3Mgb2YgVE1SIGJ1ZmZlciAqLw0KICAgICAgICAgICAgIHVpbnQzMl90ICAgICAgICBidWZfc2l6
ZTsgICAgICAgICAgICAgIC8qIGJ1ZmZlciBzaXplIGluIGJ5dGVzIChtdXN0IGJlIG11bHRpcGxl
IG9mIDQgS0IpICovDQogICAgICAgICsgICAgdW5pb24gew0KICAgICAgICArc3RydWN0IHsNCiAg
ICAgICAgK3VpbnQzMl90c3Jpb3ZfZW5hYmxlZDoxOyAvKiB3aGV0aGVyIHRoZSBkZXZpY2UgcnVu
cyB1bmRlciBTUi1JT1YqLw0KICAgICAgICArdWludDMyX3R2aXJ0X3BoeV9hZGRyOjE7IC8qIGRy
aXZlciBwYXNzZXMgYm90aCB2aXJ0dWFsIGFuZCBwaHlzaWNhbCBhZGRyZXNzIHRvIFBTUCovDQog
ICAgICAgICt1aW50MzJfdHJlc2VydmVkOjMwOw0KICAgICAgICArfSBiaXRmaWVsZDsNCiAgICAg
ICAgK3VpbnQzMl90ICAgICAgICB0bXJfZmxhZ3M7DQogICAgICAgICsgICAgfTsNCiAgICAgICAg
KyAgICB1aW50MzJfdCAgICAgICAgc3lzdGVtX3BoeV9hZGRyX2xvOyAgICAgICAgLyogYml0cyBb
MzE6MF0gb2Ygc3lzdGVtIHBoeXNpY2FsIGFkZHJlc3Mgb2YgVE1SIGJ1ZmZlciAobXVzdCBiZSA0
IEtCIGFsaWduZWQpICovDQogICAgICAgICsgICAgdWludDMyX3QgICAgICAgIHN5c3RlbV9waHlf
YWRkcl9oaTsgICAgICAgIC8qIGJpdHMgWzYzOjMyXSBvZiBzeXN0ZW0gcGh5c2ljYWwgYWRkcmVz
cyBvZiBUTVIgYnVmZmVyICovDQoNCiAgICAgICAgIH07DQoNCiAgICAgICAgLQ0KICAgICAgICAg
LyogRlcgdHlwZXMgZm9yIEdGWF9DTURfSURfTE9BRF9JUF9GVyBjb21tYW5kLiBMaW1pdCAzMS4g
Ki8NCiAgICAgICAgIGVudW0gcHNwX2dmeF9md190eXBlIHsNCiAgICAgICAgIEdGWF9GV19UWVBF
X05PTkUgICAgICAgID0gMCwgICAgLyogKi8NCiAgICAgICAgLS0NCiAgICAgICAgMi43LjQNCg0K
DQogICAgX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCiAg
ICBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KICAgIGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQogICAgaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJs
PWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZv
JTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDbGlqby5sYXphciU0MGFtZC5jb20lN0MwYTNj
ODA0ODVmODA0MzAwNzc2NjA4ZDhlZDNiM2RkMSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5
NGUxODNkJTdDMCU3QzAlN0M2Mzc1MjAxODU5OTA1MDg5NTclN0NVbmtub3duJTdDVFdGcGJHWnNi
M2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxD
SlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9MllwOW9DZlhUYnMxUEF0cDkwSnAyODdQZTFr
NzJLVldrN1lDOXFyR042ayUzRCZhbXA7cmVzZXJ2ZWQ9MA0KDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
