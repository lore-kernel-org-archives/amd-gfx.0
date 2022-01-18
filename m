Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1098C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 08:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F84410E718;
	Tue, 18 Jan 2022 08:09:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B0710E718
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 08:09:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKoIMWok2z1S8TganogNli/wXyaKZT5eMmbhrse8VRRqy1U/kyfcmLsT5mRGEfF+oTsoh0CpQfSY56s+95Vvg7f36o8XQ0etgO/9gmhJYBUnR6OR/4dCqN52Edqeezm+PlY+ZrdJib7jKypOIyeBRf3zdiHPecVI52/9975LoBACUtTAe6ScnG2RzLdiyYjvy4/aPt7Wzjb1lv6LRycLBpT94tWxFKS/PkDOBqb/wK9kGCGMmMwWFUN36p/nOuvYKWnEZdq+N/7ke/R7n2kOd+q4cFPJtR/OlOYrF8GgJG0MBorBAqBmyQx+/6HopdXOOGGt0+MRmUx94T5xPjFjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+spBzy6rXD7HonLazWqmgs+dGWTWQTGv1Gxf87b40V4=;
 b=YLR7Wnc5TV5NOr05HrKTzIkEHQysf/tyP0HdISmOsUopmxnu1/tlQOZT89UrkryFsfXJl1DTpWvv/mKxxZbkVPL6SV258lVNC2ubOBPtjaiLt+nONG0BoMASw7SXAB60xLS4tf+9NQwNEV4fazVQcMdW5J62ZUdZYPH4Y6LCIwMO6dkvwO0B6hoRuWoEtnw7vFOZ9Sof4It28N0ZLKD+c8etn2NwfYmthzTucBvZL9Fze9nn0kgcnRkcmTnL1UqRzr8hXJCD5Ht8Y/GWqoWpDIO6tz0bTaQcH+/Z6BR/7hfn0TAjl8AiWcNgBQOHvj85MNuJiD+KaMw8eW1ZO3F5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+spBzy6rXD7HonLazWqmgs+dGWTWQTGv1Gxf87b40V4=;
 b=2ED7JX62NgSXlU3PCr9wQg4wDBjOHwG1hfLvE7wjIUYPdtTeFJWuDtnU8xMEpqTkI3i96eaVP8AjIwRfGIFZ5xFEVxPHyFcBwQSrfweMoMrASplSuTPBjjs1XiaM+haYIHdVRP6ms3Mli4RXGcUA0bihUAcAizPHBSzXEzZj1rs=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR1201MB2504.namprd12.prod.outlook.com (2603:10b6:3:e3::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Tue, 18 Jan 2022 08:09:20 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672%4]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 08:09:19 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix build up and tear down of debug vram
 access bounce buffer
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix build up and tear down of debug vram
 access bounce buffer
Thread-Index: AQHYC/wB4n/uUjOCA0eOf90imw9wI6xoYlQAgAAJmIA=
Date: Tue, 18 Jan 2022 08:09:19 +0000
Message-ID: <DM5PR12MB24692B8100BF87268D08FF3CF1589@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220117234307.3820143-1-jonathan.kim@amd.com>
 <88f0e304-c17c-bc50-14ce-37c05d76a3b4@amd.com>
In-Reply-To: <88f0e304-c17c-bc50-14ce-37c05d76a3b4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-18T08:04:32Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c5a5ecd8-cb43-4485-a318-4aa624ed87c7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-18T08:09:17Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3c4c6895-dac3-45be-b1ba-15b222cf063f
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d3eb9c7-c98b-4745-e648-08d9da59d454
x-ms-traffictypediagnostic: DM5PR1201MB2504:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB2504FE692110698E86AEA433F1589@DM5PR1201MB2504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cEwYvKAO23BX0+7THAjhZfhL8eiHYjiVhVNKFmI4dR3aNaa96zpwk71ibRdBPIBos03k72+QYE4cFu/tSrEgiljn2R4ywgy0JD/hoHRdRDbgf4Hr4StKWb73N9yQajFIci2EylLa0vmNdR/EzOFyAmUZ86+fwyRlWOKRbmO5T5snRlwHYQDS1LR5cuYPuvc/KJD9IAjd0eZa3mul9+AA8WpT7HpZkfyZ9AIkNbUgrsuLoOiiYopNQI3XrcL7uBTikjTTtdqVoDL1Y6I5ialIl7z3PabKBUCt7Y+rZDGEWNKTzY+2aq7HeT7HjbX4SM1Kvp0oiJtIcHBKdg31WzmVKhUsRq/4eNKLPxZG3Tma7sszynFoJ0/NjnhLHDBHqELKO2oPYjR4nHoNfhLGmLAO47qJRG00vuiGSarrXaVkopK4V+51jWNLZR5L+iA2OchsyQKe2RNVzv+1UV1o06UwWibAyUmm+uCnlS0VByRg+XZHFBjtdIfaHtfHO47ic7RQP2ZuVZK1sY0S/jiz1rxBdlOmN+UfAZdddZYu3gxd5mIzqb1PIrAoJaz18p4/ZF8APMoYSX72CRq2/orUDtWqJNHqsHXO5IoBofZB5nGjW9vLR4S/tPkQCnZSvLv48JcEBJrbsroWmbLkTPC4WkmWlq93Zrw5Q/tADbZw/nE6y9i1Mo3GYYCDIwt1MUQlO3ALsSdb/PA2diOESXXEpy9tHA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(76116006)(8936002)(2906002)(6506007)(53546011)(38070700005)(8676002)(38100700002)(122000001)(9686003)(55016003)(66446008)(4326008)(64756008)(508600001)(316002)(5660300002)(110136005)(186003)(71200400001)(26005)(86362001)(33656002)(7696005)(66476007)(66556008)(66946007)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTh1NHpXZDZTOWlBVWlRMjV4d2ptQWthVGFyTFIxMnVBaGNQZzdLSjZheDFs?=
 =?utf-8?B?QlR3OFVOTk45eEVaUEZoZ1hjRHhzck0razVCbzNFTDBpdmY1ZUZzcGVoNVNj?=
 =?utf-8?B?Y2RKdFA1OG1BOG5FNjJmRFZwbHoxditIdTUrcyttOWJUWkZpT2wrOWN3aUIv?=
 =?utf-8?B?Ynh4SjZlcFZKR2lVY0RReFlsbmZTbldaL2ZmdWdXaWtGenh5SDhlaHNROWJr?=
 =?utf-8?B?VGozWkdwcERKd1BlbHZiYThMb1Y5djVIaXhVL2d4OFhlak16c0hzVmgxRUFp?=
 =?utf-8?B?WVZ0QjI4amJmaC9qcFZoeG5yRkpzRXRabFZyaGFvYTE2c1N6cG5oNmQ1UmlP?=
 =?utf-8?B?c1Z6Ymp4L0N5WW9lV0xhQXlFQ1JiWk1iZ25CYXM3N1hBS0JKSDFka1JxQUVW?=
 =?utf-8?B?MUFIVFRTcjIvZCtHK2kvbVZya2lpS0tZbmhQdWJoU2NJMHpZU0kvTlgxbnZw?=
 =?utf-8?B?RTRuSCtKYjA4VWhRVURsSllleW9wSmxKYkEwVnRlSDJxdnNHdHdnMVNOVnN4?=
 =?utf-8?B?cDR3V3JoeTZ2VGJSaXU0RGZoZU1LSFJJQUxBSzZYMVh6blV3M2FwSHI3Z0U0?=
 =?utf-8?B?R25OWDZPOUpqdjV5SDdUQzk0em9Ycmd6eWNOQkl0aG9DZkxMT3E1L2ZIMnp5?=
 =?utf-8?B?VjZkOUpFNXMzdzRnOFpBRmptQS85WVdXN2ZYanhtcUh3QUQ3Z3Fjc21jaTlK?=
 =?utf-8?B?T3BmRTBOU2ljUStEcFhINlV5M2VYM3A3dHRMUzI3RnltdWdyU0RqdERnZnAz?=
 =?utf-8?B?RzE3Y1BVMHQvTUJ6NHRYOGIzVHJmL3lEOTNlYjNuL2FQcU1vZ01ZbjVJMHI5?=
 =?utf-8?B?SklrTjhlejNXV0U2NmZQOFpIeDQxMHEwOVl6SDdET3AyZk1wVk5WZEw5S0tM?=
 =?utf-8?B?ZHlEbGZyZ0hpMkY5SjFCMnVnU2VjRFQxc1lucGpvOGZBMG1wODY0cHVVZGtR?=
 =?utf-8?B?eTJrNWtWSGNqTFQ2WVBFSHp1c25zcTRKd3lnNG9tZVc5TlBXb3NOQ283TjRG?=
 =?utf-8?B?MFpVeW1NYWV0LzZFbnl2L0J6OTY3TzRVQnBBU3ZteUI4Q1VzdkdJYS9rRDVy?=
 =?utf-8?B?QUJyclV2cEpkMFd1a3BzWTJPYWRkYW5YQ1gwVzZBb0hmV3U2NjI1NHR6TTJN?=
 =?utf-8?B?Rld3RktIT1NWc25hV1Jmd25JQzlSY0hGdk55dDVFQ282MHRhbFBKcFhiYkZF?=
 =?utf-8?B?eXJUa0I0K1pCRkc1MHgxTTN6RFAybHFjeHIzcFhsZGh3azlzVHVRaTRPaDc2?=
 =?utf-8?B?NHoxWUo4K3FicXZUbElmbUxNRDY0MFJuME5iWDNxTDlXbWxVWUcxWWVtREtr?=
 =?utf-8?B?YmdIRkgxdGl1ZjhPR1ZhbUljYkR6WUhvQlBXclhsSkV3SUxqdVpaT25rdjZ0?=
 =?utf-8?B?MzFWdjQzVG1jU1RxTnN4NzQxd3hxa2lzbCtRVU03c1FZZlBFUk9PQUpJL0t5?=
 =?utf-8?B?enJXc2psdlpEb1lUZUdaQ2xsTUhORmhlNzJsV25NV3N2ZTlWZ21mdVRWbTln?=
 =?utf-8?B?eDJnL05hRVdKQzdhVUpmdGhUakR5N0h4OVNjSXB4NUxHVUd4TlRQamdOTlR2?=
 =?utf-8?B?WW1LclpXb0kwRkJmUjkrRmJvbldkRFEza0t5U3NQNW94WVVZajJjWUgzc0xj?=
 =?utf-8?B?QW1XOE9tTUhuOGR0dDliWXBHdkYyYm9RUmRXVmU4YWZmajNLSm4xcWh0NE9V?=
 =?utf-8?B?TmRDRTBrOXZ0dUxGUjM2L0tVZUw2Nmt0R0pvVGQxc29zakM4YXFVU0paSXdD?=
 =?utf-8?B?UmFkejk1T1krTVlPQzNSM1dwSGN3cjN5d0IrMVBQWmZZbm5nRGUxeDhzOFhp?=
 =?utf-8?B?YndhU2lRSUxuNllqZWRua0Z0RWtXeVVuTlJmVGpRVmNtNFZyY1JiYUFwQUs0?=
 =?utf-8?B?aDRta1p0SlR6dFFjemVuTldmSk5lRTVPNVJXTWsvQWlURkRoWFZmSno1L09u?=
 =?utf-8?B?Mkg1WWhFdkdYT0tMYU5UaklqaFZDL0w2Q0dUbDdKZHhmOUtnOTdrU2k4c2Ft?=
 =?utf-8?B?OWgwQU13TUNjQzllaHYraVFDUDNyaGp0MElGc1lTQUxsMFB6RE56YWdLRkJN?=
 =?utf-8?B?NnI3Tm4zUE1rbElKU0lFSHF6REJ1Zlcrby9VY2JBUVRZdkFhbUxpbUZUVE5s?=
 =?utf-8?B?OFIrL3l3V1pxbkFRbkxnWllxOUJ4ZUw4L0l1dmVPTFZpdWY2eDRDYTUwRHRp?=
 =?utf-8?Q?UBUAbOnqKmY0/6Skzmd7Rss=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3eb9c7-c98b-4745-e648-08d9da59d454
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 08:09:19.7976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gXxDY89Rt3Uuhq04PDOYxWhWsboxlHRzMjECQQepAGBg6UdJkrmTUmYYOKnC4T1VzT+b02LcflcH7r1gpSdkQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2504
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KSGkgQ2hyaXN0aWFuLA0KDQpSZTogV2VsbCB0aGF0IGRvZXNuJ3Qgc2VlbSB0
byBtYWtlIHNlbnNlIHRoZSBHQVJUIGlzIGluaXRpYWxpemVkIGJ5IHRoZSBjb2RlIGFyb3VuZCB0
aGUgYWxsb2NhdGlvbiBzbyB0aGF0IHNob3VsZCB3b3JrIGZpbmUuDQoNCkJlbG93IGlzIHRoZSBj
YWxsdHJhY2UgZHVyaW5nIGRyaXZlciBwcm9iZS4gV2hlbiBiaW5kaW5nIHRoZSBwYWdlKFNETUEg
Ym8pIGludG8gZ2FydCB0YWJsZSwgdGhlcmUgaXMgYSBjaGVjayBieSBnYXJ0LnJlYWR5LCB0aGF0
IHdpbGwgYmUgc2V0IHRvIGJlIHRydWUgbGF0ZXIgb24gaW4gZ21jX3YxMF8wX2h3X2luaXQuIFNv
IGEgY2FsbHRyYWNlIGlzIG9ic2VydmVkLg0KDQpbICAgIDMuMzgxNTEwXSAgYW1kZ3B1X3R0bV9n
YXJ0X2JpbmQrMHg4MC8weGMwIFthbWRncHVdDQpbICAgIDMuMzgxNTgwXSAgYW1kZ3B1X3R0bV9h
bGxvY19nYXJ0KzB4MTU4LzB4MWMwIFthbWRncHVdDQpbICAgIDMuMzgxNjQ3XSAgYW1kZ3B1X2Jv
X2NyZWF0ZV9yZXNlcnZlZCsweDEzNi8weDFlMCBbYW1kZ3B1XQ0KWyAgICAzLjM4MTcxNF0gID8g
YW1kZ3B1X3R0bV9kZWJ1Z2ZzX2luaXQrMHgxMjAvMHgxMjAgW2FtZGdwdV0NClsgICAgMy4zODE3
ODJdICBhbWRncHVfYm9fY3JlYXRlX2tlcm5lbCsweDE3LzB4ODAgW2FtZGdwdV0NClsgICAgMy4z
ODE4NDldICBhbWRncHVfdHRtX2luaXQuY29sZCsweDE3NC8weDE4ZSBbYW1kZ3B1XQ0KWyAgICAz
LjM4MTk1MV0gID8gdnByaW50a19kZWZhdWx0KzB4MWQvMHgyMA0KWyAgICAzLjM4MTk1NV0gID8g
cHJpbnRrKzB4NTgvMHg2Zg0KWyAgICAzLjM4MTk1N10gIGFtZGdwdV9ib19pbml0LmNvbGQrMHg0
Yi8weDUzIFthbWRncHVdDQpbICAgIDMuMzgyMDUyXSAgZ21jX3YxMF8wX3N3X2luaXQrMHgzMDQv
MHg0OTAgW2FtZGdwdV0NCg0KUmVnYXJkcywNCkd1Y2h1bg0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNv
bT4gDQpTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDE4LCAyMDIyIDM6MzAgUE0NClRvOiBLaW0sIEpv
bmF0aGFuIDxKb25hdGhhbi5LaW1AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQpDYzogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgQ2hlbiwg
R3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGRy
bS9hbWRncHU6IGZpeCBidWlsZCB1cCBhbmQgdGVhciBkb3duIG9mIGRlYnVnIHZyYW0gYWNjZXNz
IGJvdW5jZSBidWZmZXINCg0KQW0gMTguMDEuMjIgdW0gMDA6NDMgc2NocmllYiBKb25hdGhhbiBL
aW06DQo+IE1vdmUgdGhlIGRlYnVnIHNkbWEgdnJhbSBib3VuY2UgYnVmZmVyIEdBUlQgbWFwIG9u
IGRldmljZSBpbml0IGFmdGVyIA0KPiB3aGVuIEdBUlQgaXMgcmVhZHkgdG8gYXZvaWQgd2Fybmlu
Z3MgYW5kIG5vbi1hY2Nlc3MgdG8gU0RNQS4NCg0KV2VsbCB0aGF0IGRvZXNuJ3Qgc2VlbSB0byBt
YWtlIHNlbnNlIHRoZSBHQVJUIGlzIGluaXRpYWxpemVkIGJ5IHRoZSBjb2RlIGFyb3VuZCB0aGUg
YWxsb2NhdGlvbiBzbyB0aGF0IHNob3VsZCB3b3JrIGZpbmUuDQoNCkZyZWVpbmcgdGhlIEJPIGlu
ZGVlZCBuZWVkcyB0byBiZSBtb3ZlZCB1cCwgYnV0IHRoYXQgY2FuIHN0aWxsIGJlIGluIHRoZSBz
YW1lIGZ1bmN0aW9uLg0KDQpBbHNvIHBsZWFzZSBkb24ndCBtb3ZlIFRUTSByZWxhdGVkIGNvZGUg
b3V0c2lkZSBvZiB0aGUgVFRNIGNvZGUgaW4gYW1kZ3B1Lg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFu
Lg0KDQo+DQo+IEFsc28gbW92ZSBib3VuY2UgYnVmZmVyIHRlYXIgZG93biBhZnRlciB0aGUgbWVt
b3J5IG1hbmFnZXIgaGFzIGZsdXNoZWQgDQo+IHF1ZXVlZCB3b3JrIGZvciBzYWZldHkuDQo+DQo+
IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIEtpbSA8am9uYXRoYW4ua2ltQGFtZC5jb20+DQo+IC0t
LQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDExICsr
KysrKysrKysrDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jICAg
IHwgIDggLS0tLS0tLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jDQo+IGluZGV4IGRhMzM0OGZhN2IwZS4uMDk5NDYwZDE1MjU4IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IEBAIC0yMzc4LDYg
KzIzNzgsMTMgQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2lwX2luaXQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpDQo+ICAgCWlmIChyKQ0KPiAgIAkJZ290byBpbml0X2ZhaWxlZDsNCj4g
ICANCj4gKwkvKiBHVFQgYm91bmNlIGJ1ZmZlciBmb3IgZGVidWcgdnJhbSBhY2Nlc3Mgb3ZlciBz
ZG1hLiAqLw0KPiArCWlmIChhbWRncHVfYm9fY3JlYXRlX2tlcm5lbChhZGV2LCBQQUdFX1NJWkUs
IFBBR0VfU0laRSwNCj4gKwkJCQlBTURHUFVfR0VNX0RPTUFJTl9HVFQsDQo+ICsJCQkJJmFkZXYt
Pm1tYW4uc2RtYV9hY2Nlc3NfYm8sIE5VTEwsDQo+ICsJCQkJJmFkZXYtPm1tYW4uc2RtYV9hY2Nl
c3NfcHRyKSkNCj4gKwkJRFJNX1dBUk4oIkRlYnVnIFZSQU0gYWNjZXNzIHdpbGwgdXNlIHNsb3dw
YXRoIE1NIGFjY2Vzc1xuIik7DQo+ICsNCj4gICAJLyoNCj4gICAJICogcmV0aXJlZCBwYWdlcyB3
aWxsIGJlIGxvYWRlZCBmcm9tIGVlcHJvbSBhbmQgcmVzZXJ2ZWQgaGVyZSwNCj4gICAJICogaXQg
c2hvdWxkIGJlIGNhbGxlZCBhZnRlciBhbWRncHVfZGV2aWNlX2lwX2h3X2luaXRfcGhhc2UyICBz
aW5jZSANCj4gQEAgLTM4NzIsNiArMzg3OSwxMCBAQCB2b2lkIGFtZGdwdV9kZXZpY2VfZmluaV9o
dyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAJfQ0KPiAgIAlhZGV2LT5zaHV0ZG93
biA9IHRydWU7DQo+ICAgDQo+ICsJLyogcmVtb3ZlIGRlYnVnIHZyYW0gc2RtYSBhY2Nlc3MgYm91
bmNlIGJ1ZmZlci4gKi8NCj4gKwlhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmFkZXYtPm1tYW4uc2Rt
YV9hY2Nlc3NfYm8sIE5VTEwsDQo+ICsJCQkJCSZhZGV2LT5tbWFuLnNkbWFfYWNjZXNzX3B0cik7
DQo+ICsNCj4gICAJLyogbWFrZSBzdXJlIElCIHRlc3QgZmluaXNoZWQgYmVmb3JlIGVudGVyaW5n
IGV4Y2x1c2l2ZSBtb2RlDQo+ICAgCSAqIHRvIGF2b2lkIHByZWVtcHRpb24gb24gSUIgdGVzdA0K
PiAgIAkgKiAqLw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3R0bS5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYw0K
PiBpbmRleCBiNDg5Y2Q4YWJlMzEuLjYxNzhhZTdiYTYyNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYw0KPiBAQCAtMTg1NSwxMiArMTg1NSw2IEBAIGludCBh
bWRncHVfdHRtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgCQlyZXR1cm4g
cjsNCj4gICAJfQ0KPiAgIA0KPiAtCWlmIChhbWRncHVfYm9fY3JlYXRlX2tlcm5lbChhZGV2LCBQ
QUdFX1NJWkUsIFBBR0VfU0laRSwNCj4gLQkJCQlBTURHUFVfR0VNX0RPTUFJTl9HVFQsDQo+IC0J
CQkJJmFkZXYtPm1tYW4uc2RtYV9hY2Nlc3NfYm8sIE5VTEwsDQo+IC0JCQkJYWRldi0+bW1hbi5z
ZG1hX2FjY2Vzc19wdHIpKQ0KPiAtCQlEUk1fV0FSTigiRGVidWcgVlJBTSBhY2Nlc3Mgd2lsbCB1
c2Ugc2xvd3BhdGggTU0gYWNjZXNzXG4iKTsNCj4gLQ0KPiAgIAlyZXR1cm4gMDsNCj4gICB9DQo+
ICAgDQo+IEBAIC0xOTAxLDggKzE4OTUsNiBAQCB2b2lkIGFtZGdwdV90dG1fZmluaShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAJdHRtX3JhbmdlX21hbl9maW5pKCZhZGV2LT5tbWFu
LmJkZXYsIEFNREdQVV9QTF9PQSk7DQo+ICAgCXR0bV9kZXZpY2VfZmluaSgmYWRldi0+bW1hbi5i
ZGV2KTsNCj4gICAJYWRldi0+bW1hbi5pbml0aWFsaXplZCA9IGZhbHNlOw0KPiAtCWFtZGdwdV9i
b19mcmVlX2tlcm5lbCgmYWRldi0+bW1hbi5zZG1hX2FjY2Vzc19ibywgTlVMTCwNCj4gLQkJCQkJ
JmFkZXYtPm1tYW4uc2RtYV9hY2Nlc3NfcHRyKTsNCj4gICAJRFJNX0lORk8oImFtZGdwdTogdHRt
IGZpbmFsaXplZFxuIik7DQo+ICAgfQ0KPiAgIA0K
