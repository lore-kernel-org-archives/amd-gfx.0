Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15149C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 02:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17436E409;
	Thu, 25 Nov 2021 02:21:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C73906E409
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 02:21:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gh9e9g2HiPjvtcycdya6b1N8M6Ocs8xWVYuacH/j8pz84oSIgYxnSapS81JKxhWph255Z+uDuXGEFF0tQ/jSfb1f78vflMDgYLwpJwFbdZy0DcW3vUm90QhYJk5w9fxenmJpVCii8Ppzig21TcRmdzMNe4tmFD0xk7nIco4fXbCEXHcSUD+dv34mrwLfLvyVNHBUDRgq09/2WXSM4fqICSW63sh1sOwAHjR9k1yUfHMpumEhYY8RoGpy1rGol3QnRCVis0MO3V5WvREOu3sabEg6279N1FJd10BigPWSDCGfpvJAXP/n/SMmdp+kVgfRKhlZ5SxRPgWeljG3DERLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1TSCD51FDljmMC5nfy5uisHFafmafMGatuKnCJTrYU=;
 b=WtBCBChNQcVGQqYJH8jalCt5DetK1YPOIbOrvW8SYFdHm5geADnumzjElXKJCeVhn51dAtBOeNRdXyDCvyEEJwJaNVLYTo8u+4+oh/zq93A8WeGM7Q4W6OcNtwpX4bc1JdQCHftGRVSdnwbzd1BNIDql2UdDCKHnwo7Qx5PidqYXTazsbtAYA56pmkx1BtEuib9NdeO8BsnRsDC6UVDRUjwwL7W9KW4jk8hMloa8wbZuL6FGekHNMaSfrLfgOZdzNqZDB+spvv11QiMcSQASrgHUiyM+YvnoGMMV/xltOI5Xw73jgu1tox+LLh6OAd7QauYm8BqlP6rX3Z6QnN6xIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1TSCD51FDljmMC5nfy5uisHFafmafMGatuKnCJTrYU=;
 b=vKrzvs30FQD4y5+DWNKMDnnwxxwAYDVT2RZrph4sYxqNN3Rf5dfA6R8Sy+rT5dGjkMNKzJccMpD5MG8w6G6UKV1L5+swafEerqlejit1fXJ8hGqOLN6aBrPFCFSqh5NY2c95+MtfCht+1XUbSmIRFYGGGrZ/D68zb7bTj/50LmQ=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.24; Thu, 25 Nov 2021 02:21:54 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 02:21:54 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "Jian, Jane" <Jane.Jian@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip
 init for SIENNA_CICHLID
Thread-Topic: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip
 init for SIENNA_CICHLID
Thread-Index: AQHX4T58sdgLureBqECdY83svDUkSqwSuvGAgADHNyCAAAGgUA==
Date: Thu, 25 Nov 2021 02:21:54 +0000
Message-ID: <DM5PR12MB24699B4793306F3221D6D67EF1629@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211124142036.22491-1-Jane.Jian@amd.com>
 <CADnq5_P1=kz9dDwLtH98sHGgt6=C5Y=U1EoouGJktwFW0pBG7w@mail.gmail.com>
 <DM5PR12MB24691FE17360A4A7A76D6825F1629@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB24691FE17360A4A7A76D6825F1629@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-25T02:18:46Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8e1f208a-1034-4c43-b275-0fdacb379b8c;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-11-25T02:21:51Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 5367f278-b1de-415a-ba8e-bab3d71dddd1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c177a2e4-7d8f-4535-b4c3-08d9afba593d
x-ms-traffictypediagnostic: DM6PR12MB2988:
x-microsoft-antispam-prvs: <DM6PR12MB29888814F90EDCAE994ED440F1629@DM6PR12MB2988.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:425;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JVwmNiCQhoKDu5EZKCJfa5BlSbQUMQ8XF+trdd+Df7PkInNszLFgn28b2zzdbRTzsd1ayNU2TZD4YG8NMy6qVCZfqt93ZeUB9EaGEQK3YqLDxFgsSHJm4+xwI0940BNgwyMCve8RhL9kcKljDQB8ILrcnZtfprkuL2KAMu6jP3hby0KEvPR2ypdW7XYHZtA+8VTzJREJvhLo0VA43MPlbZHUW8s+36dSjtprTrukPxWfEiMBZn0y9u/WiPxhcYZVEQK2oOAuGglKbUcszQ6L6FETv8Mq81g351v93JTxhJ+l1qL5txhU+9NehqRBYmraJDQtyOOaXMoh01nfOu6XmQjWkUgu5RUEL9iU4rZ+btAYTtPWNdxcOBthXO30ddFRIRMgq+gLEYi6I2M/uCOkh2DTlxni3FweUhr2q6VHyaNQ0n1CBGBe35xePsyeEQxmzCCq/0O5Z5S513PLEqE5lbOjABhxbEtJ+dt9oy1lYzi9h6uZKw02ghuz66C+KKmO/Ky0Imy0s4OQl2m5PNXrOYSAVdR5MHaN9Lr8PPrvd8A7dKLZZMxKRKgm1WD7mgr16vLYw/dNa4IbUgZ90LlYb91QW0JrycRrRxtMcXwB7I2Ba4C9qm44y0ThmTT7wM6BjF6wGbJqumQwySklBqmThQeJ7+H73uBS6VmNz75Byg8hlYCkdB8Q49UlaRKTy8jiypA8TxpZi5SwDZ/JjeASlQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(186003)(53546011)(55016003)(26005)(6636002)(2906002)(64756008)(52536014)(5660300002)(316002)(122000001)(7696005)(38100700002)(66556008)(66476007)(2940100002)(9686003)(66446008)(4326008)(66946007)(83380400001)(33656002)(110136005)(54906003)(76116006)(71200400001)(38070700005)(86362001)(508600001)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTBMLzhqNmFjaXg0dFIvaFZpNzdHMXRnOWsvNndVRG1yVWFCcTk5NUQwUjNv?=
 =?utf-8?B?UGJENk56RGZTQnR3VVpyQVhhRDZ6bnUwbWQ4dlZWYzJadDZXeEhYQnlSMkhG?=
 =?utf-8?B?c2p3b1JpSmVteWVzWDdGVThQUzJEd2NEZkhCU2R6R2piNlBjd1R2K3R6OU44?=
 =?utf-8?B?QTNRYWdOa2lYZmVFZDF5TGZKWXEwYkFyay8xZi95b0pEZmFPd3hFTFMzV2FB?=
 =?utf-8?B?Mko5SWovdHhVb1hlMnZRR3lUZitlWEFLN2lWYWtYNE0rcm9HTnFkRDlvOEUz?=
 =?utf-8?B?WDhiUU80bm9MZFFIajVBb1JDUXRzVEhWMFBSdlcxcHRLS3ZkcTJjbzRvUWVz?=
 =?utf-8?B?bE4yV3l5YmxBNU9OTHF3aGtoUi9DOEhWTUFOendxNVRtdmtCSVdPYWVkMStl?=
 =?utf-8?B?UytBdjd3c1pYMnV3SFk4aTIvbXRWdnhaVE9vYzBGVDBXRUl0Q0E4MHArM3ps?=
 =?utf-8?B?dDN5K2RzN0pSaGo2SDVGOHJwRzJMd2R6OWwxTG1SRDhrbDl6RDhlU243OGJY?=
 =?utf-8?B?bmhWeEU5SnN3ZFdsd2xwNlJRTEkvd1lMU2JxRy82c3hyV3VMTk5VY3VuSFVC?=
 =?utf-8?B?M2RQU3ZQSHl3OTZuaWs5ZmJjd0xkdmRSWTlmOC9qSms2aytjanFETGdLRHFt?=
 =?utf-8?B?VkI0Y2hQd1MxSUlUS3EvbnZwYktTeHRYWkh5SUtoWmRqMzVQREx2MWdwTGpK?=
 =?utf-8?B?Tm1VRWUvYzcwNkFWZFk3L3UyQlNtVG04bTFhOHZ6VVFpbk1YaFNTelkzSm9G?=
 =?utf-8?B?V252cW4veTZTRGowMGY5WlhPUk1vUVBHM3pMdjNnNk43ZkFsdGt3Y1VldkpX?=
 =?utf-8?B?eklwT0JqYXpsZ1lMQkdwMmFYTmlGQ3ZEcEFQajJhdUM1bnQzV0Zkc0xtNnps?=
 =?utf-8?B?bG5sQ3o2bTdiZ2g3ZEoyQXUra3pGRk1oOHhQRlhqeXFNZEZFK0xTSVg4eHYr?=
 =?utf-8?B?VzNTdXdnSWphdmZORkVNeEs3bXpvcWVnLy8ySGpDRVk1blNxNWxkb2ljZHpW?=
 =?utf-8?B?N0FBRmtPUCtlRVlxczZST1dGNEhMb3lWclNVRlpiUXJhUnE2ZkhVc2NCN0ph?=
 =?utf-8?B?ZkU3TmlQY3lhaWozUHMrTTU3NExoa1NyUlAzSEtuaEoyY2FjUjg1WUZFbXNC?=
 =?utf-8?B?V0pxMjM3QVloWG40THJ5ZFFUcFYwYTBkdHNOVFZ2UEJkdmw4OWQvTk0vbEZk?=
 =?utf-8?B?TURYSjNraXh2VU05RkFtejJWR3A0ejhrQjJNVUNLOUdtUmtJK3JJRUxPdWMz?=
 =?utf-8?B?b0tRWmRNU2owODFxRWowZGJLKzlTUUFaY1JWZ2QzY002a2Mxd0c3TTRrcnlL?=
 =?utf-8?B?ckxHeUxiOUFqRmlxMDJ4U3NlMVVWZzByR29lRWh1empQblhBNnQybEREemJV?=
 =?utf-8?B?Q2xCemF6blB4MjF6dXhDUC9KbXVPMndqaFQ1aUw2am9lS083WmtOTmZpMVky?=
 =?utf-8?B?ZXovNmN1VGJNbHVOeENxL3RBNkw5T2MvVjRVMkZteG5oUkFGOFN4MmpOUzhV?=
 =?utf-8?B?Rk9maitDcWFUNW5RLzc1SUJHeVpIWmNsK01wcThubGZzNTgwTUg5bk1raTBW?=
 =?utf-8?B?cXY3aFJscGxoNmNBcXNUOVVWYk1hVnVHWGRaUWtIdEJ6OTdOckRLMEcxVmtM?=
 =?utf-8?B?NXJsTWd5aGtXS25TSWNOTWg4bE1pZm5XbWlQYXd1R2FwcVNNdDZpVG1RcExv?=
 =?utf-8?B?S05VMnNML1MzZUJTUXc3emx4TGtaa2d4REFVZ00yZWNpMHJIcWpoMmE0cnNG?=
 =?utf-8?B?bllscFJaNThzd1BmQ01LVzlrUEZXLzRXZW12Z0ZlWlBhcFNjRGp1UDh4N3Mw?=
 =?utf-8?B?V2t1SGN5UitsOGxJMm5rRFFEM1RnbUM1ZzJ6N2RKSkV6VmlwckszUnI0SGk5?=
 =?utf-8?B?YkY4cWFBTmZqSnBkY1VuQldjeXltdU0zUFRSR0lvK01uMVdEL1RxbTNtOStk?=
 =?utf-8?B?WUlYSjFMam9jK2UxRVFlcWRUdU5SZXIyQnl4MUhsakh4emtOeGVvN0MrOUpD?=
 =?utf-8?B?Q0hUak93a3VOT0NPVE5za21nUUxPUGhJOFFrVXN3OFJibGlORkZ1RnJIZTZ2?=
 =?utf-8?B?emR3b21XNXU5R0xGSnZlWndUVDkxM1JIUmRZUXpTWG1pN1FONTdoajl6bWZP?=
 =?utf-8?B?QWRGd3MzUm9hTS80bXhQM3pVd0pDUnBZM3FPaTJOYXRDbk5VdEZ5T0EvbFd1?=
 =?utf-8?Q?jNm3XbgpLVwim51JetWMC9E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c177a2e4-7d8f-4535-b4c3-08d9afba593d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 02:21:54.4390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UQRqIjijeybfili2GyZEJL56oS6GlFzp0jl8gx6fg+yQ1Ji8i3RD5otlS4L2xbr4zo2FtQrFT7Rcj3woFw3SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen,
 JingWen" <JingWen.Chen2@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KQSB0eXBvLg0KDQpJdCdzIGJldHRlciB0byBtb3ZlICdjYXNlIElQX1ZFUlNJ
T04oMywgMCwgMTkyKScgYWZ0ZXIgSVBfVkVSU0lPTigzLCAwLCAyKT8NCg0KY2FzZSBJUF9WRVJT
SU9OKDMsIDEsIDEpOg0KY2FzZSBJUF9WRVJTSU9OKDMsIDAsIDIpOg0KKyBjYXNlIElQX1ZFUlNJ
T04oMywgMCwgMTkyKToNCglhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmdmNuX3Yz
XzBfaXBfYmxvY2spOw0KCWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KCQlhbWRncHVfZGV2
aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmanBlZ192M18wX2lwX2Jsb2NrKTsNCglicmVhazsNCg0K
UmVnYXJkcywNCkd1Y2h1bg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1k
LWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9m
IENoZW4sIEd1Y2h1bg0KU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDI1LCAyMDIxIDEwOjE5IEFN
DQpUbzogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+OyBKaWFuLCBKYW5lIDxK
YW5lLkppYW5AYW1kLmNvbT4NCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBDaGVuLCBKaW5nV2VuIDxKaW5nV2VuLkNoZW4yQGFtZC5jb20+OyBhbWQt
Z2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0KU3ViamVjdDogUkU6IFtQ
QVRDSF0gZHJtL2FtZGdwdS9zcmlvdi92Y246IHNraXAgaXAgcmV2aXNpb24gY2hlY2sgY2FzZSB0
byBpcCBpbml0IGZvciBTSUVOTkFfQ0lDSExJRA0KDQpbUHVibGljXQ0KDQpJdCdzIGJldHRlciB0
byBtb3ZlICdjYXNlIElQX1ZFUlNJT04oMywgMCwgMTkyKScgYWZ0ZXIgSVBfVkVSU0lPTigzLCAw
LCAxOTIpPw0KDQpjYXNlIElQX1ZFUlNJT04oMywgMSwgMSk6DQpjYXNlIElQX1ZFUlNJT04oMywg
MCwgMik6DQorIGNhc2UgSVBfVkVSU0lPTigzLCAwLCAxOTIpOg0KCWFtZGdwdV9kZXZpY2VfaXBf
YmxvY2tfYWRkKGFkZXYsICZ2Y25fdjNfMF9pcF9ibG9jayk7DQoJaWYgKCFhbWRncHVfc3Jpb3Zf
dmYoYWRldikpDQoJCWFtZGdwdV9kZXZpY2VfaXBfYmxvY2tfYWRkKGFkZXYsICZqcGVnX3YzXzBf
aXBfYmxvY2spOw0KCWJyZWFrOw0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4N
ClNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjQsIDIwMjEgMTA6MjMgUE0NClRvOiBKaWFuLCBK
YW5lIDxKYW5lLkppYW5AYW1kLmNvbT4NCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+OyBD
aGVuLCBKaW5nV2VuIDxKaW5nV2VuLkNoZW4yQGFtZC5jb20+OyBhbWQtZ2Z4IGxpc3QgPGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdw
dS9zcmlvdi92Y246IHNraXAgaXAgcmV2aXNpb24gY2hlY2sgY2FzZSB0byBpcCBpbml0IGZvciBT
SUVOTkFfQ0lDSExJRA0KDQpPbiBXZWQsIE5vdiAyNCwgMjAyMSBhdCA5OjIwIEFNIEphbmUgSmlh
biA8SmFuZS5KaWFuQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBbV0hZXQ0KPiBmb3Igc3Jpb3Ygb2Rk
IyB2ZiB3aWxsIG1vZGlmeSB2Y24wIGVuZ2luZSBpcCByZXZpc2lvbihkdWUgdG8gDQo+IG11bHRp
bWVkaWEgYmFuZHdpZHRoIGZlYXR1cmUpLCB3aGljaCB3aWxsIGJlIG1pc21hdGNoZWQgd2l0aCBv
cmlnaW5hbA0KPiB2Y24wIHJldmlzaW9uDQo+DQo+IFtIT1ddDQo+IGFkZCBuZXcgdmVyc2lvbiBj
aGVjayBmb3IgdmNuMCBkaXNhYmxlZCByZXZpc2lvbigzLCAwLCAxOTIpLCB0eXBpY2FsbHkgDQo+
IG1vZGlmaWVkIHVuZGVyIHNyaW92IG1vZGUNCj4NCj4gU2lnbmVkLW9mZi1ieTogSmFuZSBKaWFu
IDxKYW5lLkppYW5AYW1kLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KPiBDaGFuZ2UtSWQ6IEkxYWNlMzJhY2JmM2ExM2MwYmFh
Yzk1ODUwOGRhMTMyNGVjMzg3YTU4DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rpc2NvdmVyeS5jIHwgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdmNuLmMgICAgICAgfCAxICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGlzY292ZXJ5LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlz
Y292ZXJ5LmMNCj4gaW5kZXggNTAzOTk1YzdmZjZjLi4zZjliN2IwYmFiM2MgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4gQEAgLTky
Myw2ICs5MjMsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kaXNjb3Zlcnlfc2V0X21tX2lwX2Jsb2Nr
cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmanBlZ192M18wX2lwX2Js
b2NrKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgICAgICAg
ICBjYXNlIElQX1ZFUlNJT04oMywgMCwgMzMpOg0KPiArICAgICAgICAgICAgICAgY2FzZSBJUF9W
RVJTSU9OKDMsIDAsIDE5Mik6DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV9kZXZp
Y2VfaXBfYmxvY2tfYWRkKGFkZXYsICZ2Y25fdjNfMF9pcF9ibG9jayk7DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgICAgICAgICAgZGVmYXVsdDoNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0KPiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0KPiBpbmRleCA0ZjdjNzA4NDU3ODUu
LjU4NTk2MWMyZjVmMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Zjbi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
Y24uYw0KPiBAQCAtMTM1LDYgKzEzNSw3IEBAIGludCBhbWRncHVfdmNuX3N3X2luaXQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAg
ICBjYXNlIElQX1ZFUlNJT04oMywgMCwgMCk6DQo+ICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDMs
IDAsIDY0KToNCj4gKyAgICAgICBjYXNlIElQX1ZFUlNJT04oMywgMCwgMTkyKToNCj4gICAgICAg
ICAgICAgICAgIGlmIChhZGV2LT5pcF92ZXJzaW9uc1tHQ19IV0lQXVswXSA9PSBJUF9WRVJTSU9O
KDEwLCAzLCAwKSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZndfbmFtZSA9IEZJUk1XQVJF
X1NJRU5OQV9DSUNITElEOw0KPiAgICAgICAgICAgICAgICAgZWxzZQ0KPiAtLQ0KPiAyLjE3LjEN
Cj4NCg==
