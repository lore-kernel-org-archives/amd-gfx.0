Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A17C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 13:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD1610E12C;
	Thu, 27 Jan 2022 13:39:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F68310E12C
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 13:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNDqML0IVPED+MCUu7oWk+FSm20FMCadOOcL7q6j0yEtQCY9taceO3+cC8iFuvYSstbIAFbNUbtAYSQoWYMDIbEGpe8XFteCehoo7kXAmKA2P+OtnR/cFzgg/FgyZ2r/ho4ohdtHvQkiy/zkc+DYdL2Ztm1hu4K/A4W27wgioGQaxvfX4NWme5poY3apYgbtsv0uCpE+0SqLsMyNc/8pTrKp+l1hhMcG7jdAoBsDvQOABzIpChX+9Oz5hRwrpYybnpv+X87t/VT29VmCTaKZnqpsuZeFZCrFBKwYjC0FZSxh5xnoMuvQ21W0I0CIrp6A5a+t1Zl1h9gtNVT8LlcUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dtsa/CXv+zAwoqOaRSFWLPikFzRueSdA/l3gloZVLO4=;
 b=J6dgZS6U2IM8BPnoEPhwyFEg3gbGPQV1/kF+F3I/BNhPQiuCJZonHAogyvcZDC0UQQp6yl7j+45fZhExf0stOn0gBkz1etZidjo08ZQ4M8QcHZQ87xhzk2zFC8FghJKzsfythzy1W4LU3rU3swXcVnaG1uh8s+zh3/sOzCePv7cvbzZ+yABFWCojiJ1SEhuAKd1OenwzoM6BOGDstBpwhm/bAOpEnOlVKF4gRmwNLE28EdN7TRcZkjcw2eKO38qVXxtMKJaCbOzkrSnql732canqk+WHSiILo+q7MH8t2VByqD6BEvadttcYEq3UjxoL1q+GaiOPPNGXERqDSIkLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dtsa/CXv+zAwoqOaRSFWLPikFzRueSdA/l3gloZVLO4=;
 b=sDLH6dVywzWcj2ntNsETik2e7c2imO3ZTN2S7ay+rkMMiHfL4VIabVC5G1AouJ82c84BQv7qhQXE8Vihkoq93VfJxZv2d/yExg9ZmTJpjL5RWmiMCxdF8u4stj9DK/TSm2WEpV5TZpy19zw44ZHT5VpW5Ri6NoGGO1lIEaMHrX4=
Received: from DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) by
 BL0PR12MB2403.namprd12.prod.outlook.com (2603:10b6:207:40::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.17; Thu, 27 Jan 2022 13:39:47 +0000
Received: from DM8PR12MB5414.namprd12.prod.outlook.com
 ([fe80::f012:bd92:416b:a423]) by DM8PR12MB5414.namprd12.prod.outlook.com
 ([fe80::f012:bd92:416b:a423%8]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 13:39:47 +0000
From: "Newton, Jeremy" <Jeremy.Newton@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: FIx for UMR arm build
Thread-Topic: FIx for UMR arm build
Thread-Index: AQHYEtkhGgvqGfCQbkqox484qGU4i6x24ORb
Date: Thu, 27 Jan 2022 13:39:47 +0000
Message-ID: <DM8PR12MB5414E5088A8AFE9240C57654F6219@DM8PR12MB5414.namprd12.prod.outlook.com>
References: <DM8PR12MB54148E41D5C03634DDAC738FF6209@DM8PR12MB5414.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB54148E41D5C03634DDAC738FF6209@DM8PR12MB5414.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-27T13:39:46.948Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8fba840-842d-44bc-9c03-08d9e19a7c53
x-ms-traffictypediagnostic: BL0PR12MB2403:EE_
x-microsoft-antispam-prvs: <BL0PR12MB2403FB81D61628F830647DFAF6219@BL0PR12MB2403.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: chmSu37BZsNRVLCKxDJDS52/KdAhE/GqPEuA0Bkb+r2hBQLS04wvJaOGI8gddRFHDRCCDXE+APntCxFuGXm1uFzVpvHAXdEfX7UB7pfls8zyBP7w66cJFipAF/bT6eG5OeUgdkhsrYDXAHYoxohZXT1y89pws4POsM2Og09w2n5jfGp+aBjem9qNw5SLH7qi/yFOUpRVkLNKuqauRIjRdZZkKxFPaEGtvLlSGl14u4bUtaY7qvb6lIokEBXHfIPKztcdN8KTZd/8dLaJ3RCy7HYe3bgekeh1DfmfbKF1GCEKeaMlrNtODYIHCo30ieI3d7ObYQVd1P2gXOmSLagC7eQBmM++uXzxdvA+hDPRkEnk5kJlmfUefatIHi05Hbp62BJfUVPXBLRkFSRNCfOeMH0TPIPL4Zt3ozFUYsNX4tGBbISKxjxbkjBOHfmP0X6x99qg92v55YmiRBwSaw8ZvQQPK5Ptza2vb/hpu30CH82eX4RZ65YEGwA3ekAP1NgUmIm6AoXZ673Nl92tz9SV8X5gl/C68fdq7WswqBclvBXohcpOO6Un1ApB//6UpLgrovbYvC+nFAp8gJC1XOCSjY6drb00gmgu6NCI5WtAmHa4oQLhtTAIPLO6Ak86E6DRsxrTafpC3j8cCZdU4H2jEmyEmxrwQaM+bbhIg8RwZueKiR/rzMG0dl2dFTJbd6LYipnj4NOglRo+vg9fBkEXhQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(66476007)(4326008)(26005)(64756008)(8936002)(8676002)(66446008)(186003)(38070700005)(6916009)(122000001)(66556008)(86362001)(38100700002)(99936003)(33656002)(9686003)(91956017)(52536014)(66946007)(76116006)(2906002)(55016003)(4744005)(19627405001)(71200400001)(508600001)(5660300002)(53546011)(6506007)(7696005)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cS9nUnZ5WnM3U1Q3QTF6bXRLeEp2Vy9FcndZSDRKaCtVVkxKU3FsQnMyOCtP?=
 =?utf-8?B?TUUwVGhGVlJYeVQwb1hFUk5aRnl3eWpRNjlQeFBxeFRVT0lyYlZOamN6VG12?=
 =?utf-8?B?azN0OFZ0NmxnMXdER01wN1V6VnM4QURhSHNsdm43SENIQkhlZXVlNEFPdnVP?=
 =?utf-8?B?RVRaT1pTeEZaMXA2OXhTb0ovR2MrVGtmUTl5TVY5TmxzRXhYdEIwMU03VG1l?=
 =?utf-8?B?a3N1dXdPR0lFamZ5b3FKdnRFNDE1NlZvZ3U0TDRyTVBMOWhTTnRvTUx3dlU0?=
 =?utf-8?B?dUNEdTNsR3FZRkl0K0RvdlhENHc0cUw0dFU4WjJ4SXhORUNXamp6Y3JiNm80?=
 =?utf-8?B?U1pVdFJGVnNDdnZWNUdjczV4elI4ZmRUekQwMkVNVFEvUU8rVmFGdE13OTBs?=
 =?utf-8?B?VFk0NmoxOWNtb2d4ZmdPTlBPUC9jUFE1LzcvOXY2UGZFVmVoWUlmMXN4Mzg2?=
 =?utf-8?B?d0JZYXdZUHpaVXdnWmE2elBqYUJpRUhxb1R6bngyZi9kbUQxN1VWOXNPSWpn?=
 =?utf-8?B?MUYwSWl0REpudTE5alZiV3JSUm1YUHBjc3o0dXBnbTVldllVMDI3eU01Ti9I?=
 =?utf-8?B?M3QyMXRzNGhqSzM4aEVSVWtDWUU2UWVzR0kvRWhvTUtET2VxaGJwWUM0YlRI?=
 =?utf-8?B?WnpuZU9vOTNiOS9vY0drbkRGZTVLNGlNZ0lhUEcwbFVFbk1oR2s0ZmkyYStD?=
 =?utf-8?B?QkVkYzhrQWNXb01QZTVSNm5YRjRxWU14YW1malI3YURxaVg4UlpLbGZqV2Iz?=
 =?utf-8?B?eElSU2hGd3hsZDlMNEtTbmFQdWN4ZWVzRStsUmNDcURTRzQ5RnFJQURMb08y?=
 =?utf-8?B?ajUxQWpZVzJSd25WMkpoRy9JWWNZSG5yMVVMcDBxOGlGclE1WURVUlZwK1Jk?=
 =?utf-8?B?OUN0UkVTYUZ0cldISVFrT2pjbFdjSVc5LzlaYnhGTkdaTWR6Z0prd1drZHgr?=
 =?utf-8?B?ZXdHYnFsZnl5eVRvKzI4UFh6QURuRWxodGdaN3h1dTBpRWFSYVdaeUZ1bnpx?=
 =?utf-8?B?NkRwSzAxMmpFWG5WQ2tPUWJxeWRpRG9uRkZuWTFIcGxjUTJpQWxGYnI5bEtD?=
 =?utf-8?B?eDE1bk9aZHNmUVdYSkcrSDRtell1MWYva0pIM3pOVG9VQzBjaG1mbXBHc2lN?=
 =?utf-8?B?WGxadEdteHdvMERCbFJDKzJZK2NQejRNdGJ4ZjhFYmg1aEpUZzRuRy9BTExI?=
 =?utf-8?B?V1NKYkkwWjNkYXkrLzhTTXVpKzk4YWcyM25ZSktMZHh1Ty9meWRsWXRncDZz?=
 =?utf-8?B?MzI4cmQ0eGcvQnRZaENJOFNMU0lmQzRvNGNmUjRMR1NEOVJLMFkrVjJ4Zy9M?=
 =?utf-8?B?cXZMRWF6MGZYR0N6cWtwOTBRMG1COHNwZkJEa3Z3K1ZLVk4yQnJIaTBsR2R6?=
 =?utf-8?B?TFc5MVJ1SnlPcEN3UVA0ZUNyQ2FpazdMYW94ejdFQ2dDM01IaGFINVRUY3VH?=
 =?utf-8?B?TjRJT2YzcTAyZFhHTG9mSWNtK1dQQU1VaWxJNFNoMlhMZjR5T2k2Y1E0RHRO?=
 =?utf-8?B?TDFlSEZuVC95Um92ZGVVanZnZTk0bGFKY09ZaEZVdE9ZQkt3anJ3eU1qMGFR?=
 =?utf-8?B?T0FhOFZ3RVAraEVpcSt2Q0prQ2t3bDlId0k5Q09UMUlINFJMWUo4Zkt1WGJu?=
 =?utf-8?B?T0oxdnRQUUdtV01zUUJPZEtvRURhTVh2aUVVMTQzWG5xSkxsNG9QVGtrOXBM?=
 =?utf-8?B?RnRaeG83dFlmNFo5eTZZMjJlcnVycTVDblhITEVNR0dzUEx4VXR0SXdNVnha?=
 =?utf-8?B?eHlVUitqaGpaMVpXVmM1T2V5Wk1CVytFTEJwMmRXUGF4TGNYOEc2VmVrVDFv?=
 =?utf-8?B?MG9WMTE3cTZtQkxLZlpEMVY1RU1XUWdidG5scUdJVWJBZGJwSEJWNC95ZDBM?=
 =?utf-8?B?ZmpLNElDWnpwRUxhTm03UFNJS2VxbC9YRjNpVW5PeXY5WmJhVGc0UmJEUyts?=
 =?utf-8?B?WmJucmZEODBiR2FHZ2JjR1l2MHd4enlMSVFVa0NvcGc1YlpuQXhlRkNxYUZl?=
 =?utf-8?B?SmZBY212bXNGdXd2SW9GSCtwNTV2WDZ6QjV0ajltczBLRlZ1VDR4c28vQStp?=
 =?utf-8?B?SHNCOURUNUVaNlgrdDJ4SkNuVzEyZ2RqckN3QT09?=
Content-Type: multipart/mixed;
 boundary="_004_DM8PR12MB5414E5088A8AFE9240C57654F6219DM8PR12MB5414namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fba840-842d-44bc-9c03-08d9e19a7c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 13:39:47.3266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUB7ahBuyk5j0JlxVRTqF33gRD7B/zCVUZ9t7TwxMnFC8/jKRmOJaF2gETc3J7Ys
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2403
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_004_DM8PR12MB5414E5088A8AFE9240C57654F6219DM8PR12MB5414namp_
Content-Type: multipart/alternative;
	boundary="_000_DM8PR12MB5414E5088A8AFE9240C57654F6219DM8PR12MB5414namp_"

--_000_DM8PR12MB5414E5088A8AFE9240C57654F6219DM8PR12MB5414namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KU29ycnkgSSB0aGluayBJIGZvcmdvdCB0byBhdHRh
Y2ggdGhlIHBhdGNoIPCfmYINCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpGcm9t
OiBOZXd0b24sIEplcmVteQ0KU2VudDogSmFudWFyeSAyNywgMjAyMiA4OjM5IEFNDQpUbzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Pg0KQ2M6IFN0RGVuaXMsIFRvbSA8VG9tLlN0RGVuaXNAYW1kLmNvbT4NClN1YmplY3Q6IEZJeCBm
b3IgVU1SIGFybSBidWlsZA0KDQpJIGtub3cgd2Ugb25seSB0ZWNobmljYWxseSBvbmx5IGNhcmUg
YWJvdXQgeDg2LCBidXQgdGhpcyBqdXN0IGZpeGVzIGEgc3ludGF4IGlzc3VlIGlmIHlvdSBidWls
ZCBvbiBhcm0uDQo=

--_000_DM8PR12MB5414E5088A8AFE9240C57654F6219DM8PR12MB5414namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxwIHN0eWxlPSJmb250LWZhbWlseTpBcmlh
bDtmb250LXNpemU6MTBwdDtjb2xvcjojMDAwMEZGO21hcmdpbjo1cHQ7IiBhbGlnbj0iTGVmdCI+
DQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5XTxicj4NCjwvcD4NCjxicj4NCjxkaXY+DQo8ZGl2IHN0
eWxlPSJmb250LWZhbWlseTogQ2FsaWJyaSwgQXJpYWwsIEhlbHZldGljYSwgc2Fucy1zZXJpZjsg
Zm9udC1zaXplOiAxMnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQpTb3JyeSBJIHRoaW5rIEkg
Zm9yZ290IHRvIGF0dGFjaCB0aGUgcGF0Y2ggPHNwYW4gY29udGVudGVkaXRhYmxlPSJmYWxzZSIg
aWQ9IvCfmYIiPg0K8J+Zgjwvc3Bhbj48L2Rpdj4NCjxkaXYgaWQ9ImFwcGVuZG9uc2VuZCI+PC9k
aXY+DQo8aHIgc3R5bGU9ImRpc3BsYXk6aW5saW5lLWJsb2NrO3dpZHRoOjk4JSIgdGFiaW5kZXg9
Ii0xIj4NCjxkaXYgaWQ9ImRpdlJwbHlGd2RNc2ciIGRpcj0ibHRyIj48Zm9udCBmYWNlPSJDYWxp
YnJpLCBzYW5zLXNlcmlmIiBzdHlsZT0iZm9udC1zaXplOjExcHQiIGNvbG9yPSIjMDAwMDAwIj48
Yj5Gcm9tOjwvYj4gTmV3dG9uLCBKZXJlbXk8YnI+DQo8Yj5TZW50OjwvYj4gSmFudWFyeSAyNywg
MjAyMiA4OjM5IEFNPGJyPg0KPGI+VG86PC9iPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZyAmbHQ7YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcmZ3Q7PGJyPg0KPGI+Q2M6PC9iPiBT
dERlbmlzLCBUb20gJmx0O1RvbS5TdERlbmlzQGFtZC5jb20mZ3Q7PGJyPg0KPGI+U3ViamVjdDo8
L2I+IEZJeCBmb3IgVU1SIGFybSBidWlsZDwvZm9udD4NCjxkaXY+Jm5ic3A7PC9kaXY+DQo8L2Rp
dj4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9ImRpc3BsYXk6bm9uZSI+DQo8IS0tDQpw
DQoJe21hcmdpbi10b3A6MDsNCgltYXJnaW4tYm90dG9tOjB9DQotLT4NCjwvc3R5bGU+DQo8ZGl2
IGRpcj0ibHRyIj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OkNhbGlicmksQXJpYWwsSGVsdmV0
aWNhLHNhbnMtc2VyaWY7IGZvbnQtc2l6ZToxMnB0OyBjb2xvcjpyZ2IoMCwwLDApIj4NCkkga25v
dyB3ZSBvbmx5IHRlY2huaWNhbGx5IG9ubHkgY2FyZSBhYm91dCB4ODYsIGJ1dCB0aGlzIGp1c3Qg
Zml4ZXMgYSBzeW50YXggaXNzdWUgaWYgeW91IGJ1aWxkIG9uIGFybS48L2Rpdj4NCjwvZGl2Pg0K
PC9kaXY+DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_DM8PR12MB5414E5088A8AFE9240C57654F6219DM8PR12MB5414namp_--

--_004_DM8PR12MB5414E5088A8AFE9240C57654F6219DM8PR12MB5414namp_
Content-Type: text/x-patch; name="0001-umr-gui-fix-ARM-build.patch"
Content-Description: 0001-umr-gui-fix-ARM-build.patch
Content-Disposition: attachment; filename="0001-umr-gui-fix-ARM-build.patch";
	size=1166; creation-date="Thu, 27 Jan 2022 13:39:30 GMT";
	modification-date="Thu, 27 Jan 2022 13:39:47 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkMjBjNmQ0MWVkNDc1NTNkZGJiNmNmOTBhMzE2NDlkYTRkNDBiZDcyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKZXJlbXkgTmV3dG9uIDxKZXJlbXkuTmV3dG9uQGFtZC5jb20+
CkRhdGU6IFdlZCwgMTIgSmFuIDIwMjIgMTA6NDM6MDcgLTA1MDAKU3ViamVjdDogW1BBVENIXSB1
bXIvZ3VpOiBmaXggQVJNIGJ1aWxkCgpTaW1wbGUgc3ludGF4IGVycm9yIGluIG9uZSBvZiB0aGUg
YXJtIGNhc2VzIGZvciBpbWd1aQoKU2lnbmVkLW9mZi1ieTogSmVyZW15IE5ld3RvbiA8SmVyZW15
Lk5ld3RvbkBhbWQuY29tPgotLS0KIHNyYy9hcHAvZ3VpL2ltZ3VpL2ltZ3VpX2ludGVybmFsLmgg
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9zcmMvYXBwL2d1aS9pbWd1aS9pbWd1aV9pbnRlcm5hbC5oIGIvc3JjL2FwcC9n
dWkvaW1ndWkvaW1ndWlfaW50ZXJuYWwuaAppbmRleCAzMTgwY2M1Li5iZjAwZTkxIDEwMDY0NAot
LS0gYS9zcmMvYXBwL2d1aS9pbWd1aS9pbWd1aV9pbnRlcm5hbC5oCisrKyBiL3NyYy9hcHAvZ3Vp
L2ltZ3VpL2ltZ3VpX2ludGVybmFsLmgKQEAgLTI2NCw3ICsyNjQsNyBAQCBuYW1lc3BhY2UgSW1T
dGIKICNkZWZpbmUgSU1fREVCVUdfQlJFQUsoKSAgICBfX2FzbV9fIHZvbGF0aWxlKCJpbnQgJDB4
MDMiKQogI2VsaWYgZGVmaW5lZChfX0dOVUNfXykgJiYgZGVmaW5lZChfX3RodW1iX18pCiAjZGVm
aW5lIElNX0RFQlVHX0JSRUFLKCkgICAgX19hc21fXyB2b2xhdGlsZSgiLmluc3QgMHhkZTAxIikK
LSNlbGlmIGRlZmluZWQoX19HTlVDX18pIGRlZmluZWQoX19hcm1fXykgJiYgIWRlZmluZWQoX190
aHVtYl9fKQorI2VsaWYgZGVmaW5lZChfX0dOVUNfXykgJiYgZGVmaW5lZChfX2FybV9fKSAmJiAh
ZGVmaW5lZChfX3RodW1iX18pCiAjZGVmaW5lIElNX0RFQlVHX0JSRUFLKCkgICAgX19hc21fXyB2
b2xhdGlsZSgiLmluc3QgMHhlN2YwMDFmMCIpOwogI2Vsc2UKICNkZWZpbmUgSU1fREVCVUdfQlJF
QUsoKSAgICBJTV9BU1NFUlQoMCkgICAgLy8gSXQgaXMgZXhwZWN0ZWQgdGhhdCB5b3UgZGVmaW5l
IElNX0RFQlVHX0JSRUFLKCkgaW50byBzb21ldGhpbmcgdGhhdCB3aWxsIGJyZWFrIG5pY2VseSBp
biBhIGRlYnVnZ2VyIQotLSAKMi4zMy4xCgo=

--_004_DM8PR12MB5414E5088A8AFE9240C57654F6219DM8PR12MB5414namp_--
