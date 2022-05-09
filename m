Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E402C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 15:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2341410E69D;
	Mon,  9 May 2022 15:21:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D0A610E603
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 15:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHLf3DelziqVt5exyL/ruM6niGm8mWZ7CO+8s5YFBXpiuJ2zQltAP9ebCOdH+3Oe184PL8+TJQFyhLxmXBEYeIWwdNIgujSMCNa1c0fvQeiBhdU2946vvXG6pwN2B+WyRiWGfyTt5AZ6gIX9ObGhXfGpDLcIWHBc86aOqA87IyjAVGmgCuKOc7XLbBO0ezGCdSBUIG0OWLtR8vypIKf261Uls8QGtOBYJ5bi5350TO25k9kLF8gvmqonx5UoxZVdD6ilcvBXd7pEqZUyL/AdiP0A7yjzq2d3rxolrDHGKpCXPiTqyrQxjRYayNiR6ICUASbxtMlc/PLuPPj/8lbqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwNv+sQrsHs7xY9fns2K61ghigU9JcsyOwuIlKx3OPI=;
 b=ICZY+AhtGiKB6C0Wl/6ZHyIZb59yHO51tbvJy4ycAlx1Pop5FjAzN3941ltxoNbWJQHKPstRWTWrpg776iIo0TIJMscHl8cSKul7LRHK5TgMcpvLAoryFD9oMYNm37PQQ+51nEkMS3lsZ8hPwLI9nlkp0UqL9U3CHhnkNWrjPFRup5Al32w0tx6g6NHwMosZw+xpCboiTzgauj3akxX4aKfEFxzcPqC1c2DYMCUuU7UgQ/x1mZbGJlxVhaRIRPTDe8aAFyWFvEc+2xhVQzQWj/97QpKbV2JHdwI3ncHe/Ezj+F6qHKLi6GR5wXzg8ajWvc2weszWwvj/R3qY1X5kTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwNv+sQrsHs7xY9fns2K61ghigU9JcsyOwuIlKx3OPI=;
 b=4QPMKVSr6ImzYalCOYf+X2NrivsgdQriyk/1pNrZNI1smMjCCrmiEy1s8do8BBBJGkxnABvQkj6zrvkOa+fEHr5cUeEO9TZhnCbRst4+9I7QYFucDtr0xKnczG4DwvK9wNLKey93HPZdHuAE/54uMSBg95m6Ou9TYjLy+fbzxVo=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by CH2PR12MB3685.namprd12.prod.outlook.com (2603:10b6:610:2d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 15:21:10 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::b959:96f6:3788:a11f]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::b959:96f6:3788:a11f%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 15:21:10 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>
Subject: RE: How are the DC patches tested?
Thread-Topic: How are the DC patches tested?
Thread-Index: AQHYY7EKXKr04T+gn0KGcUyK/oDP8K0WqIng
Date: Mon, 9 May 2022 15:21:10 +0000
Message-ID: <DM6PR12MB3529432C69991BA7278574489CC69@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
 <DM6PR12MB352902B7FE179953EBBD474F9CC69@DM6PR12MB3529.namprd12.prod.outlook.com>
 <f284dad0-9a9e-0edb-54df-db97b58451e9@molgen.mpg.de>
 <067c7558-8b07-139a-9eb5-e4fe9ce0cbf0@amd.com>
 <5b4a80eb-a14b-7402-fe96-83af10a64c8b@molgen.mpg.de>
In-Reply-To: <5b4a80eb-a14b-7402-fe96-83af10a64c8b@molgen.mpg.de>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-09T15:18:48Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5b2f00b0-5647-4a19-bcea-b9031d8238b0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-05-09T15:21:08Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 29f0ed39-704a-45ac-b363-250299e89608
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10e6cb7c-334c-4f49-60ab-08da31cf8c3f
x-ms-traffictypediagnostic: CH2PR12MB3685:EE_
x-microsoft-antispam-prvs: <CH2PR12MB368554C2BC48C9D33B57A48E9CC69@CH2PR12MB3685.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lEtaaB+YrWRI2rgowBAUBEfaHa+oH+vhudTxeNMfuz83tyUDZUdRjmeSuUoImgJ9caWR6McuJFfTavDpwIj32zeOlp2z3KhtNUU7CFrYHJWUWCrreJhvWF4oWOuPaUKuO0Ebvm+j9osP2qktD6cXf/SFr+meOGQ3DXwD4tWrm6HpjmUPhTto4B9vgxlkFXxr2vuwLi51KHkcmJuFZ/s9gVnoRBoJDKjUHsREukdgJBx3RZwvVgjZbJvd1TRvaVLoUeu7179Lx/Ok6OUv58BgC4ckzhXo/O9zJUTxoAbkAqAVccP9g73XQv52WYpeRR8QFRG/jxqaYqCP9x5H1zceEov05IbnyzbJ6rWhBt8i0Cz8zZcFJO7viIhAz0CMyofz5YIrAbA3+ldwPi5Oevj9FKtJX/nM6yy1XJgMKXQoWFENzAczVFWX3eeasqRKGZPLqHYcWlznvr2822PWD2liAsybg67KCpkbiBiMSnbFROB7ovBIsmUFoFjos2Hj4tG5pP02v9W8tAnEw515VDtkjihi00KydsiNVi9JVT86AxOsTtC3tw0sulfoY9F5FgMQcHKubbRxzMYXjheUrH/2pUCRVCL88VVBmrscRjeqSkheH+QeLuvCFFttQgIY9bNwFpQ0pam+C/64S4sodIjSCjYqDvDi3qbZClmZGaFv+hUjG0N5wCmy1+1gI74/AXOOboLAXMvKcf6cONoTnNp3SA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(55016003)(186003)(9686003)(26005)(8936002)(122000001)(8676002)(76116006)(4326008)(66556008)(66946007)(64756008)(66446008)(66476007)(5660300002)(52536014)(33656002)(54906003)(316002)(2906002)(110136005)(6636002)(38100700002)(508600001)(6506007)(7696005)(86362001)(38070700005)(53546011)(71200400001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDZTbHZyV2lvdW91MUtqOUlMaWJpblBreWR2VmxCUk52TVh1TGtsbzFlaWhz?=
 =?utf-8?B?QjFqb1NManhPRDFDeVQyMVltZ3UzVzBmREY1Zi9odG5iM29qSE00VEJKRUh0?=
 =?utf-8?B?YThBdUtuc1A4elVFTURQcFkyaEhKOGg5ZTdObHM1a0l1aURtYmJ0dGxncjYr?=
 =?utf-8?B?K2lpQXhVeDEyeVhHMmZWR1hDSnZ4eHk0bU13NXlTb2g3SnlUM016dlgzVTFC?=
 =?utf-8?B?Z09yUzVJSWU2SExqdElHbEVQakgyK1FWRDhSUi9SM1d6blJQMzZlWjR1WVV5?=
 =?utf-8?B?ZW9UK3NjOEhaWWpyVytVMndieStWNlhPQmt2bldtaTBIR1VJeUZ4SElqUDkr?=
 =?utf-8?B?VkFuYTd1bEd1bE1HZjNQU0hkQmxSbWpVOTAwK2tLUUM5MVEwMHFzMUV2enhX?=
 =?utf-8?B?MTBnVVlLWTk4cVh3MkpNM3AyMm5GbkMyc044ejBiTFdaalhzYmtjWFJodGVx?=
 =?utf-8?B?eUxGNVMxVlJyQ3VVY200alduVkFHaWZ5SmNhSm44NFc0R1ZTei9qRmEraUxO?=
 =?utf-8?B?Y05QMGdhZnBTTHpWS1JzLzhrcW9OQU5vR09Yb1ZqeGdJcVo1ZzNqUXVDNFVp?=
 =?utf-8?B?WS9Wb0dSWXNUdFFLMGhaVXNqVWJ6WllScnV0ekw5RHdydUNDUVlVV0VhdFVH?=
 =?utf-8?B?Q3JNQWhnMC9lM3NlZTV5Z3BObVJpOStXYjN3QnNDNEZRU253T05maFZCUmlE?=
 =?utf-8?B?UHFhN3pEZUVvOGdQeDRlZHQycDY4SUFhK210WmFvL1FpSVNTQzJHN29XakZN?=
 =?utf-8?B?OHhnWmpPMlFPbk1GcXY2aWNEVGpjUmFwRkQwWlViL1VZVUQ3Z294cGhPVFA2?=
 =?utf-8?B?NnltZjNGaHNmUFBOSUVad0hqa3NpK09sMGJwamVLdlBIWXVHSHo4VGxVcVJJ?=
 =?utf-8?B?dDZJc0NsMEI1dEZZSkxwaU45R0QyaEZHQllpdzNZRy9jenJEUVRVNm5GVWhE?=
 =?utf-8?B?QjBqZkdPZHdDKzE5bXlHbExkdys3NnRBbGZFUENHdksvd0hObUhMbUQxMExt?=
 =?utf-8?B?ZDlzdTltTDBaaEZaSzA3TWlLU0lhWm01Y25aTWZnbDREVXljQ3NKS3FEczhK?=
 =?utf-8?B?QjJQSmlPN21WRzZPUkV2RlZmMkZhenRnTVVIMkdEUktGYytOcmJMUng5Mjdr?=
 =?utf-8?B?a2JkVlNmemt3dEd3NE5UQnVZVUJhS3dJMWg3MlptS3U4QktwM3RKckRydmZ0?=
 =?utf-8?B?Tzl5cnNKa21ISklyVHg3Unp3dUt6aWkzRFBXa25NQUd4M2tISjdlRUFzTnBL?=
 =?utf-8?B?dnRQN0pXbklJM0tRUGZETE5YaGZhMHUyNjFBOGdYY1FpWUd0MXl2TitlUTI1?=
 =?utf-8?B?TE1iKzVIbWY5RTk3OS9QVGdJa1pXcVNPdUp0SnRvSGpaTEJtQXJwUVJlTGda?=
 =?utf-8?B?RExZc2hRRTZCQnRIVnJId1gwVnprdDZDV0ZoVEJpSnRTNC9Jbi9UZnFFdDRv?=
 =?utf-8?B?R3ZRUlJiaDJvKzlRSzN1bjhSek5oek41UEpFYk1OVStsbGI4RWJCYVFNUnlx?=
 =?utf-8?B?VytMZTdPaldsdWZjVFFzK0dNMktVMVBBRHFzT3NUSkFYalZPbTM3VnVTWnFw?=
 =?utf-8?B?Uk1pZ0J0QzRFRjFVd2lRUmpoQXk4SVFZbEJtQldXWDdmZG1oejNqUFJuT1Zp?=
 =?utf-8?B?UEdGWWVCSTZwTkQwcDA4cmY2S3lQUURqdi9uT3krT252U2ZVSllZdWh6S0ZF?=
 =?utf-8?B?VWZyRjdqamVRb3JDRjBMMXVpcWJoN1N0ZC9USHRPSlNCOFA1MVF3S1p0blE1?=
 =?utf-8?B?TXBmSURCTVpUTlJCTlE2dnMxdEttdDljT1RUeXp3T3NudmZlRThMUk5QK1ox?=
 =?utf-8?B?RTh5UUQybm1sUTIvbDFXSERxRlovUjNDVHEzTlNvOXJSSnZDNSsyeFdoQmlD?=
 =?utf-8?B?T2hkUCtqSXVKNTgzWTBRb2JaaVdWS2JrWnNMUmM5MmlqSXIvVXpzRHpVbG5z?=
 =?utf-8?B?dFNQZ0FiWGo1NjFhM0ljMmMycllCV1J1dTB0U3dTOHhTa2lRa05zaGlYQ1Jy?=
 =?utf-8?B?KzhwNkRKUkJxZ1NkRkxtcWFVVVNVVUp2YXBCTzdBTlFwTFlldE4xUEkzRjFZ?=
 =?utf-8?B?N1c4WjdpcDVvQ1dQZ1M0Q0pDUUNuaWVrbk1ySU9PV1lGcTRQd1REMFEwOGFE?=
 =?utf-8?B?Q21jdG5uUGFQQmN5T0dYaTljRUZtdDEyclBVMzBQYVQ5SnFYUWJ0MFMvNE9k?=
 =?utf-8?B?UGdodmZJZE9CeUtWVHZaUURCeGhzUzQ0dTZFMTdIMUF6a2N5dDR6QTI1VXIr?=
 =?utf-8?B?akhYU3BML0hhUHh5a2pLaTZ6VEw2MWhrSFgrYU94QXpjOWlOZ2ZnUW1mRmhl?=
 =?utf-8?Q?v9xND2rSZRq5Heac28?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e6cb7c-334c-4f49-60ab-08da31cf8c3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 15:21:10.6832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nkiNlBDYgUAGrRGdxZTo/6+KFmeBdYY4QFquKdfyQlKGWuTnrsliimyWUJYEvdZO3Z06akYaiGecSlUDC0BYbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3685
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha, 
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu, 
 Solomon" <Solomon.Chiu@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KSGkgUGF1bCwNCg0KSSd2ZSBtYWRlIHNvbWUgZWRpdHMgdG8gbXkgY292ZXIg
bGV0dGVyIHRvIGhvcGVmdWxseSBtYWtlIGl0IGNsZWFyZXIgd2l0aCB3aGF0IGlzIGJlaW5nIGRv
bmUuDQoNCg0KDQoNCgkJSGkgYWxsLA0KIA0KCQlUaGlzIHdlZWsgdGhpcyBwYXRjaHNldCB3YXMg
dGVzdGVkIG9uIHRoZSBmb2xsb3dpbmcgc3lzdGVtczoNCiANCgkJSFAgRW52eSAzNjAsIHdpdGgg
Unl6ZW4gNSA0NTAwVQ0KCQlMZW5vdm8gVGhpbmtwYWQgVDE0cyBHZW4yLCB3aXRoIEFNRCBSeXpl
biA1IDU2NTBVIA0KCQlTYXBwaGlyZSBQdWxzZSBSWDU3MDBYVCANCgkJUmVmZXJlbmNlIEFNRCBS
WDY4MDANCgkJRW5naW5lZXJpbmcgYm9hcmQgd2l0aCBSeXplbiA5IDU5MDBIDQoNCgkJVGhlc2Ug
c3lzdGVtcyB3ZXJlIHRlc3RlZCBvbiB0aGUgZm9sbG93aW5nIGRpc3BsYXkgdHlwZXM6IA0KCQll
RFAsICgxMDgwcCA2MGh6IFs0NTAwVSwgNTY1MFUsIDU5MDBIXSkNCgkJVkdBIGFuZCBEVkkgKDE2
ODB4MTA1MCA2MEhaIFtEUCB0byBWR0EvRFZJLCBVU0ItQyB0byBEVkkvVkdBXSkNCgkJRFAvSERN
SS9VU0ItQyAoMTQ0MHAgMTcwaHosIDRrIDYwaHosIDRrIDE0NGh6IFtJbmNsdWRlcyBVU0ItQyB0
byBEUC9IRE1JIGFkYXB0ZXJzXSkNCg0KCQlNU1QgdGVzdGVkIHdpdGggU3RhcnRlY2ggTVNUMTRE
UDEyM0RQIGFuZCAyeCA0ayA2MEh6IGRpc3BsYXlzDQoJCURTQyB0ZXN0ZWQgd2l0aCBDYWJsZSBN
YXR0ZXJzIDEwMTA3NSAoRFAgdG8gM3ggRFApLCBhbmQgMjAxMzc1IChVU0ItQyB0byAzeCBEUCkg
d2l0aCAzeCA0azYwIGRpc3BsYXlzDQogDQoJCVRoZSB0ZXN0aW5nIGlzIGEgbWl4IG9mIGF1dG9t
YXRlZCBhbmQgbWFudWFsIHRlc3RzLiBNYW51YWwgdGVzdGluZyBpbmNsdWRlcyAoYnV0IGlzIG5v
dCBsaW1pdGVkIHRvKToNCgkJQ2hhbmdpbmcgZGlzcGxheSBjb25maWd1cmF0aW9ucyBhbmQgc2V0
dGluZ3MNCgkJQmVuY2htYXJrIHRlc3RpbmcNCgkJRmVhdHVyZSB0ZXN0aW5nIChGcmVlc3luYywg
ZXRjLikNCg0KCQlBdXRvbWF0ZWQgdGVzdGluZyBpbmNsdWRlcyAoYnV0IGlzIG5vdCBsaW1pdGVk
IHRvKToNCgkJU2NyaXB0IHRlc3RpbmcgKHNjcmlwdHMgdG8gYXV0b21hdGUgc29tZSBvZiB0aGUg
bWFudWFsIGNoZWNrcykNCgkJSUdUIHRlc3RpbmcNCg0KCQlUaGUgcGF0Y2hzZXQgY29uc2lzdHMg
b2YgdGhlIG1vc3QgcmVjZW50IGFtZC1zdGFnaW5nLWRybS1uZXh0IGJyYW5jaCB3aXRoIGEgc2Vs
ZWN0aW9uIG9mIHBhdGNoZXMgYWRkZWQgb24gdG9wIG9mIGl0LiBUaGlzIGdvZXMgZm9yIGJvdGgg
VWJ1bnR1IHRlc3RpbmcgYW5kIENocm9tZSAJCU9TIHRlc3RpbmcuDQoNCgkJVGVzdGVkIG9uIFVi
dW50dSAyMi4wNCBhbmQgQ2hyb21lIE9TDQogDQoJCVRlc3RlZC1ieTogRGFuaWVsIFdoZWVsZXIg
PGRhbmllbC53aGVlbGVyQGFtZC5jb20+DQogDQogDQoNCg0KDQpUaGFuayB5b3UsDQoNCkRhbiBX
aGVlbGVyDQpUZWNobm9sb2dpc3TCoHzCoEFNRA0KU1cgRGlzcGxheQ0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoxIENvbW1lcmNlIFZh
bGxleSBEciBFLCBUaG9ybmhpbGwsIE9OIEwzVCA3WDYNCmFtZC5jb23CoMKgDQoNCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5t
cGcuZGU+IA0KU2VudDogTWF5IDksIDIwMjIgMTA6MjggQU0NClRvOiBTaXF1ZWlyYSwgUm9kcmln
byA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPg0KQ2M6IFdoZWVsZXIsIERhbmllbCA8RGFuaWVs
LldoZWVsZXJAYW1kLmNvbT47IFdhbmcsIENoYW8ta2FpIChTdHlsb24pIDxTdHlsb24uV2FuZ0Bh
bWQuY29tPjsgTGksIFN1biBwZW5nIChMZW8pIDxTdW5wZW5nLkxpQGFtZC5jb20+OyBXZW50bGFu
ZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+OyBaaHVvLCBRaW5ncWluZyAoTGlsbGlh
bikgPFFpbmdxaW5nLlpodW9AYW1kLmNvbT47IExpLCBSb21hbiA8Um9tYW4uTGlAYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBDaGl1LCBTb2xvbW9uIDxTb2xvbW9uLkNo
aXVAYW1kLmNvbT47IFBpbGxhaSwgQXVyYWJpbmRvIDxBdXJhYmluZG8uUGlsbGFpQGFtZC5jb20+
OyBMaW4sIFdheW5lIDxXYXluZS5MaW5AYW1kLmNvbT47IExha2hhLCBCaGF3YW5wcmVldCA8Qmhh
d2FucHJlZXQuTGFraGFAYW1kLmNvbT47IEd1dGllcnJleiwgQWd1c3RpbiA8QWd1c3Rpbi5HdXRp
ZXJyZXpAYW1kLmNvbT47IEtvdGFyYWMsIFBhdmxlIDxQYXZsZS5Lb3RhcmFjQGFtZC5jb20+DQpT
dWJqZWN0OiBSZTogSG93IGFyZSB0aGUgREMgcGF0Y2hlcyB0ZXN0ZWQ/DQoNCkRlYXIgUm9kcmln
bywNCg0KDQpUaGFuayB5b3UgZm9yIHRoZSBxdWljayByZXNwb25zZS4NCg0KQW0gMDkuMDUuMjIg
dW0gMTY6MTUgc2NocmllYiBSb2RyaWdvIFNpcXVlaXJhIEpvcmRhbzoNCg0KPiBPbiAyMDIyLTA1
LTA5IDEwOjAwLCBQYXVsIE1lbnplbCB3cm90ZToNCg0KPj4gQW0gMDkuMDUuMjIgdW0gMTU6MTQg
c2NocmllYiBXaGVlbGVyLCBEYW5pZWw6DQo+Pg0KPj4gW+KApl0NCj4+DQo+Pj4gVGhpcyB3ZWVr
IHRoaXMgcGF0Y2hzZXQgd2FzIHRlc3RlZCBvbiB0aGUgZm9sbG93aW5nIHN5c3RlbXM6DQo+Pj4N
Cj4+PiBMZW5vdm8gVGhpbmtwYWQgVDE0cyBHZW4yIHdpdGggQU1EIFJ5emVuIDUgNTY1MFUsIHdp
dGggdGhlIGZvbGxvd2luZyANCj4+PiBkaXNwbGF5IHR5cGVzOiBlRFAgMTA4MHAgNjBoeiwgNGsg
NjBoesKgICh2aWEgVVNCLUMgdG8gRFAvSERNSSksIA0KPj4+IDE0NDBwIDE0NGh6ICh2aWEgVVNC
LUMgdG8gRFAvSERNSSksIDE2ODAqMTA1MCA2MGh6ICh2aWEgVVNCLUMgdG8gRFAgDQo+Pj4gYW5k
IHRoZW4gRFAgdG8gRFZJL1ZHQSkNCj4+Pg0KPj4+IFNhcHBoaXJlIFB1bHNlIFJYNTcwMFhUIHdp
dGggdGhlIGZvbGxvd2luZyBkaXNwbGF5IHR5cGVzOiA0ayA2MGh6IA0KPj4+ICh2aWEgRFAvSERN
SSksIDE0NDBwIDE0NGh6ICh2aWEgRFAvSERNSSksIDE2ODAqMTA1MCA2MGh6ICh2aWEgRFAgdG8N
Cj4+PiBEVkkvVkdBKQ0KPj4+DQo+Pj4gUmVmZXJlbmNlIEFNRCBSWDY4MDAgd2l0aCB0aGUgZm9s
bG93aW5nIGRpc3BsYXkgdHlwZXM6IDRrIDYwaHrCoCAodmlhIA0KPj4+IERQL0hETUkgYW5kIFVT
Qi1DIHRvIERQL0hETUkpLCAxNDQwcCAxNDRoeiAodmlhIFVTQi1DIHRvIERQL0hETUkgYW5kIA0K
Pj4+IFVTQi1DIHRvIERQL0hETUkpLCAxNjgwKjEwNTAgNjBoeiAodmlhIERQIHRvIERWSS9WR0Ep
DQo+Pj4NCj4+PiBJbmNsdWRlZCB0ZXN0aW5nIHVzaW5nIGEgU3RhcnRlY2ggRFAgMS40IE1TVCBo
dWIgYXQgMnggNGsgNjBoeiBhbmQgDQo+Pj4gRFNDIHZpYSBVU0ItQyB0byBEUCBEU0MgSHViIHdp
dGggM3ggNGsgNjBoei4NCj4+Pg0KPj4+IFRlc3RlZCBvbiBVYnVudHUgMjIuMDQgd2l0aCBLZXJu
ZWwgVmVyc2lvbiA1LjE2LCBhbmQgQ2hyb21lT1MNCj4+DQo+PiBJIGFtIGN1cmlvdXMsIHdoYXQg
dGhpcyBtZWFucyBleGFjdGx5PyBZb3UgY2xvbmUgdGhlIFVidW50dSBMaW51eCANCj4+IDUuMTYg
a2VybmVsIHNvdXJjZSwgYW5kIHRoZW4gYXBwbHkgeW91ciBwYXRjaGVzIG9uIHRvcD8gKERvIHRo
ZXkgZXZlbiANCj4+IGFwcGx5PykNCj4gDQo+IEFsbCBvZiB0aGVzZSAicHJvbW90aW9uIiBwYXRj
aGVzIGFyZSB0ZXN0ZWQgYnkgdXNpbmcgDQo+IGFtZC1zdGFnaW5nLWRybS1uZXh0LiBJbiBhIGZl
dyB3b3JkczoNCj4gDQo+IDEuIFdlIGdldCB0aGUgbGF0ZXN0IGNvZGUgZnJvbSBhbWQtc3RhZ2lu
Zy1kcm0tbmV4dDsgMi4gV2UgYXBwbHkgdGhlc2UgDQo+IHdlZWtseSBwcm9tb3Rpb24gcGF0Y2hl
cyBvbiB0b3Agb2YgaXQ7IDMuIFdlIGNvbXBpbGUsIHJ1biB1bml0IHRlc3RzLCANCj4gYW5kIHJ1
biBtYW55IG1hbnVhbCB0ZXN0cyAoRGFuaWVsIGRvZXMgdGhhdCkuDQo+IA0KPiBJZiBldmVyeXRo
aW5nIGlzIGFscmlnaHQgd2l0aCBEYW5pZWwncyB0ZXN0cywgd2UgZmVlbCBjb25maWRlbnQgdG8g
DQo+IG1lcmdlIHRoZXNlIHNlcmllcyBvbiB0b3AgYW1kLXN0YWdpbmctZHJtLW5leHQgKHdlIGFy
ZSBiYXNpY2FsbHkgDQo+IHRyeWluZyB0byBhdm9pZCByZWdyZXNzaW9ucyBoZXJlKS4NCj4gDQo+
IEFueXdheSwgbWF5YmUgd2UgY2FuIHJlcGhyYXNlOg0KPiANCj4gIMKgVGVzdGVkIG9uIFVidW50
dSAyMi4wNCB3aXRoIEtlcm5lbCBWZXJzaW9uIDUuMTYsIGFuZCBDaHJvbWVPUw0KPiANCj4gdG8N
Cj4gDQo+ICDCoFRlc3RlZCBvbiBVYnVudHUgMjIuMDQgYW5kIENocm9tZU9TIHdpdGggYW1kLXN0
YWdpbmctZHJtLW5leHQgKyANCj4gcHJvbW90aW9uIHBhdGNoZXMuDQoNClllcywgdGhhdOKAmWQg
YmUgZ3JlYXQuIE1heWJlIGV2ZW4gcmVmZXJlbmNlIHRoZSBjb21taXQgaGFzaCBmcm9tIHRoZSBj
b21taXQgb24gdG9wIG9mICphbWQtc3RhZ2luZy1kcm0tbmV4dCouDQoNCihOaXQ6IENocm9tZU9T
IOKGkiBDaHJvbWUgT1MpDQoNCj4+IFRoZSBzYW1lIGZvciBDaHJvbWUgT1MuIERvIHlvdSB1c2Ug
Q2hyb21lIE9TIEZsZXggWzFdIHdpdGggdGhlIA0KPj4gc3lzdGVtcyB5b3UgbGlzdGVkPyBJZiBu
b3QsIHdoYXQgR29vZ2xlIENocm9tZWJvb2tzLy1ib3hlcyBkaWQgeW91IHRlc3Qgd2l0aD8NCj4+
IFRoZSBMaW51eCBrZXJuZWwgdmVyc2lvbiBpcyBhbHNvIHRpZWQgZm9yIGEgZGV2aWNlIGFuZCBD
aHJvbWUgT1MgDQo+PiByZWxlYXNlLiBQbGVhc2UgbWVudGlvbiB0aG9zZSB0b28uDQoNCkFzIHdy
aXR0ZW4sIHRoZSB1c2VkIENocm9tZSBPUyB2ZXJzaW9uIChhbmQgZGV2aWNlcykgd291bGQgYmUg
aGVscGZ1bCB0b28uDQoNCj4+IElzIGl0IGRvY3VtZW50ZWQgc29tZXdoZXJlLCB3aGF0IHRlc3Rz
IHlvdSBydW4gZXhhY3RseT8NCj4gDQo+IFdlIHJ1biBJR1QgdGVzdHMsIHNvbWUgc2NyaXB0cyB0
aGF0IHZhbGlkYXRlIHNvbWUgc3BlY2lmaWMgYXJlYXMsIGFuZCANCj4gRGFuaWVsIGhhcyBhbiBl
eHRlbnNpdmUgc2V0IG9mIG1hbnVhbCB0ZXN0cy4NCg0KDQpLaW5kIHJlZ2FyZHMsDQoNClBhdWwN
Cg==
