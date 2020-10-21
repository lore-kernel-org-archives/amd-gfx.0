Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1325AC4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 07:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FCF6221FC
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 07:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z7POI3fw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCF6221FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3D756E977;
	Wed, 21 Oct 2020 07:23:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C19E6E977
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 07:23:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZroSdHh2iVap4zGEk7he0QLY9JdzXqHXo4E6E231R0IQwZapGPJNAuh6Smbctv0ziRuTVeuoxuWvmV99QGgIcsHnz4G6dqt5AR3FZOuL4lbBMyDUT0SeJwspcoOYk6lGudxnq5fdzoYhacNc1cfuxcEy1wR2Nnhxc34t8AXlu6Vb6/CXRRYML6crST6pBGV6fyh6n23da3MKGaAoeFK5l/qkRi8mSBOuygkS6rAHN71e5XsGDRV5Ov5hGriIRePavtRWSnTIZthm4lFXYU8k3yIGgVkGsQt23FAwsB9dVGmV0bcfRSkBhch9oTwUBaICk0iSdhIpz8NqzmTPKQ6Xow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0RLwfBCbJoDg6p2WmA6gW1LMhkvOyHFZURZfyRlyfU=;
 b=XM0QU5rqZukgY6RbhnzW7tPnbYXkRHmF3nnicfHnEy8aPGXwIr+7FWoGcNVEHrTEfuu2dt86PXNS8ohcD4y/REfiIXnhVgLhuDHmU/ftMPfF5IlMoi3IlicdRQ/hBZ2DShNSABxbPS+RtkK+xAMHXNm/Pn6on0d3XiPJfAnQp7Ss8QXS7KZ82fsBPL91rHe/zFbB2dKfNvdz8MhTtu+golSeFBy/PXAJ/g9Y7+ooaQPNscLu5vpoCe0lY/rjk0CtRu8PBGyV0tFRxXS4azDTf0I3g5yNiauUPeVbcBbhH+DLTh43Td04n9U3Q3MWFPagv7P0aTVAvelfaohWx7PlPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0RLwfBCbJoDg6p2WmA6gW1LMhkvOyHFZURZfyRlyfU=;
 b=Z7POI3fwhgx0RwzLiQevjSpzJ52y0LFEPfRmlpbIgDmf/hgfRu4n//CJw3MgZkigLfZHXdmGqEpeFzwWi90bP6Ah1ZTj09iX+0WcdQlvqtN2XpOKWXDb/M6S/u5wWRiizI7z0KJICJxrJcBanGNe1vC/DuJQuhMG1pLvmlqZy3A=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Wed, 21 Oct 2020 07:23:46 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 07:23:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: disable sienna chichlid UMC RAS"
Thread-Topic: [PATCH] Revert "drm/amdgpu: disable sienna chichlid UMC RAS"
Thread-Index: Adanemidh5YoVxbJQ6i2phnmijiWagAALQKU
Date: Wed, 21 Oct 2020 07:23:45 +0000
Message-ID: <03574FDF-4102-41CA-A5A3-581356046555@amd.com>
References: <MN2PR12MB4032EB2E7B5CF37DA5D4A4D0FB1C0@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4032EB2E7B5CF37DA5D4A4D0FB1C0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2409:891e:8f80:5c76:8817:f935:1c0f:8686]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55753ec2-fc26-4465-9419-08d875923f41
x-ms-traffictypediagnostic: DM6PR12MB4957:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4957CDF5F593BBCF2A8CE191FC1C0@DM6PR12MB4957.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gHwyh9LJGnMa4VLlDu4R+d485Rf9DcWwHyDB7B8cTQ4hXhzughzzvMJxtzOT4VYUIDqxZafumVflzPHlkHb2+p3tW3md7NYXD7IZzi4Dfgk4mW1tzokLRTOou6/X4k6S5PIy47ENKOyQiPSF9Y6W/3wAXHgKu9rcSJKlnrHuxjwSc8/eSWidaxUcOIQpCC5RiwqSEAAG6wuQbJi1i9jF0wT0Gb3SX4R6ueluSeD3dsZKj/kkp3y/ZfRgFXxcyWQ7r9yV/4z56BRSgIv/FaHERDVUbanBDRrHKzmMrjgISJqMjvQwqByzUcrPMIUfbMzC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(8936002)(186003)(91956017)(6862004)(66556008)(66946007)(66476007)(64756008)(2616005)(66446008)(76116006)(37006003)(8676002)(6486002)(4326008)(86362001)(316002)(6636002)(558084003)(2906002)(71200400001)(36756003)(53546011)(6506007)(6512007)(478600001)(5660300002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: PpftOeB2A23FrSRqBUBmHMKfgoUf2eP6HWav/6GRsW/zUYBgN/gdGC6twUwKso0Bdg6j2O11hIDS32jEAQsNPNyY/Jl+h4TC/oPuV2y0TvIPRH2j+X6oDzVBj+Jb4D7pKeIk7Bmh9kuHwj0p/TinV5pfjBJVBoNUZFwClIKpE2iOM+grpf5TcSs7iXI/s1zbNjQmBZkptRdUnbCoHMmNxc6+/dz85j2E9oqNb51IaK6KM6q8d4NxmuuVhFZrdLCDj3NGhb7hj95jnFqvDqfcblTBuq/zD8qwSjoKFKYgEhocQFzFRtnXK4/51k5IxT4ytE88UFUqTkDKQftB7LTWu/AFd3ZB4yhg2fs+TpIl4axewrTg+l6X1s1UXgOk/S1W9KuzM+WFQJviGT6tEtnIZdgCOONUPgXHn5PeRDyOKo15Vmly7XNoXzpDrWIizBFmrANxqS+33+4mYjJowEDB+JTkR8GZjKGo3JGYVy+dPsD3ZWhUdK/3f+R76DnaRsmPJSBvnNnsDbe5vOP0IldNvq33p4reXCoNe2eXLAoMcbc/i3crm6CInXM/K5UCffvvrpCDp/NslMED0L10cp7cYJbGiicNC0J8e717SJzTnUERwIq2bJSF8d0QHEUYlWIc7SmpRFf5jQKQEDWk321o+QTSNc038xoxe/KLoZoJlNBZ2dQvEggB/VaUaSaegWpBdKuGG4Ln5sR9iufpNRm87A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55753ec2-fc26-4465-9419-08d875923f41
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 07:23:45.8697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2WUcg+nQ4EdP3M4bHvYbtljbPVvbLHo1/OIBdqY81CjJs/pMAoMcNgWdt6SbkXThBnGmJAjtzWx20P7WT+4JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============2011105091=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2011105091==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_03574FDF410241CAA5A3581356046555amdcom_"

--_000_03574FDF410241CAA5A3581356046555amdcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

UmV2aWV3ZWQtYnk6SGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KDQpSZWdh
cmRzLA0KSGF3a2luZw0KDQpTZW50IGZyb20gbXkgaVBob25lDQoNCk9uIE9jdCAyMSwgMjAyMCwg
YXQgMTU6MTksIENsZW1lbnRzLCBKb2huIDxKb2huLkNsZW1lbnRzQGFtZC5jb20+IHdyb3RlOg0K
DQrvu78NCg0KW0FNRCBQdWJsaWMgVXNlXQ0KDQpSZXZlcnQgY2hhbmdlIHRvIGRpc2FibGUgVU1D
IFJBUyBmb3Igc2llbm5hIGNoaWNobGlkDQoNClRoYW5rIHlvdSwNCkpvaG4gQ2xlbWVudHMNCg==

--_000_03574FDF410241CAA5A3581356046555amdcom_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5IGRpcj0iYXV0byI+DQpS
ZXZpZXdlZC1ieTpIYXdraW5nIFpoYW5nICZsdDtIYXdraW5nLlpoYW5nQGFtZC5jb20mZ3Q7DQo8
ZGl2Pjxicj4NCjwvZGl2Pg0KPGRpdj5SZWdhcmRzLDwvZGl2Pg0KPGRpdj5IYXdraW5nJm5ic3A7
PGJyPg0KPGJyPg0KPGRpdiBkaXI9Imx0ciI+U2VudCBmcm9tIG15IGlQaG9uZTwvZGl2Pg0KPGRp
diBkaXI9Imx0ciI+PGJyPg0KPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+T24gT2N0IDIxLCAyMDIw
LCBhdCAxNToxOSwgQ2xlbWVudHMsIEpvaG4gJmx0O0pvaG4uQ2xlbWVudHNAYW1kLmNvbSZndDsg
d3JvdGU6PGJyPg0KPGJyPg0KPC9ibG9ja3F1b3RlPg0KPC9kaXY+DQo8YmxvY2txdW90ZSB0eXBl
PSJjaXRlIj4NCjxkaXYgZGlyPSJsdHIiPu+7vw0KPG1ldGEgbmFtZT0iR2VuZXJhdG9yIiBjb250
ZW50PSJNaWNyb3NvZnQgV29yZCAxNSAoZmlsdGVyZWQgbWVkaXVtKSI+DQogPHN0eWxlPjwhLS0N
Ci8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6IkNhbWJy
aWEgTWF0aCI7DQoJcGFub3NlLTE6MiA0IDUgMyA1IDQgNiAzIDIgNDt9DQpAZm9udC1mYWNlDQoJ
e2ZvbnQtZmFtaWx5OkRlbmdYaWFuOw0KCXBhbm9zZS0xOjIgMSA2IDAgMyAxIDEgMSAxIDE7fQ0K
QGZvbnQtZmFjZQ0KCXtmb250LWZhbWlseTpDYWxpYnJpOw0KCXBhbm9zZS0xOjIgMTUgNSAyIDIg
MiA0IDMgMiA0O30NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6IlxARGVuZ1hpYW4iOw0KCXBh
bm9zZS0xOjIgMSA2IDAgMyAxIDEgMSAxIDE7fQ0KLyogU3R5bGUgRGVmaW5pdGlvbnMgKi8NCnAu
TXNvTm9ybWFsLCBsaS5Nc29Ob3JtYWwsIGRpdi5Nc29Ob3JtYWwNCgl7bWFyZ2luOjBpbjsNCglm
b250LXNpemU6MTEuMHB0Ow0KCWZvbnQtZmFtaWx5OiJDYWxpYnJpIixzYW5zLXNlcmlmO30NCnNw
YW4uRW1haWxTdHlsZTE3DQoJe21zby1zdHlsZS10eXBlOnBlcnNvbmFsLWNvbXBvc2U7DQoJZm9u
dC1mYW1pbHk6IkNhbGlicmkiLHNhbnMtc2VyaWY7DQoJY29sb3I6d2luZG93dGV4dDt9DQouTXNv
Q2hwRGVmYXVsdA0KCXttc28tc3R5bGUtdHlwZTpleHBvcnQtb25seTsNCglmb250LWZhbWlseToi
Q2FsaWJyaSIsc2Fucy1zZXJpZjt9DQpAcGFnZSBXb3JkU2VjdGlvbjENCgl7c2l6ZTo4LjVpbiAx
MS4waW47DQoJbWFyZ2luOjEuMGluIDEuMGluIDEuMGluIDEuMGluO30NCmRpdi5Xb3JkU2VjdGlv
bjENCgl7cGFnZTpXb3JkU2VjdGlvbjE7fQ0KLS0+PC9zdHlsZT4NCjwhLS1baWYgZ3RlIG1zbyA5
XT48eG1sPg0KPG86c2hhcGVkZWZhdWx0cyB2OmV4dD0iZWRpdCIgc3BpZG1heD0iMTAyNiIgLz4N
CjwveG1sPjwhW2VuZGlmXS0tPjwhLS1baWYgZ3RlIG1zbyA5XT48eG1sPg0KPG86c2hhcGVsYXlv
dXQgdjpleHQ9ImVkaXQiPg0KPG86aWRtYXAgdjpleHQ9ImVkaXQiIGRhdGE9IjEiIC8+DQo8L286
c2hhcGVsYXlvdXQ+PC94bWw+PCFbZW5kaWZdLS0+DQo8cCBjbGFzcz0ibXNpcGhlYWRlcjI1MTkw
MmU1IiBhbGlnbj0iTGVmdCIgc3R5bGU9Im1hcmdpbjowIj48c3BhbiBzdHlsZT0iZm9udC1zaXpl
OjEwLjBwdDtmb250LWZhbWlseTpBcmlhbDtjb2xvcjojMzE3MTAwIj5bQU1EIFB1YmxpYyBVc2Vd
PC9zcGFuPjwvcD4NCjxicj4NCjxkaXYgY2xhc3M9IldvcmRTZWN0aW9uMSI+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj5SZXZlcnQgY2hhbmdlIHRvIGRpc2FibGUgVU1DIFJBUyBmb3Igc2llbm5hIGNo
aWNobGlkPG86cD48L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwv
bzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRoYW5rIHlvdSw8bzpwPjwvbzpwPjwvcD4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPkpvaG4gQ2xlbWVudHM8bzpwPjwvbzpwPjwvcD4NCjwvZGl2
Pg0KPC9kaXY+DQo8L2Jsb2NrcXVvdGU+DQo8L2Rpdj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_03574FDF410241CAA5A3581356046555amdcom_--

--===============2011105091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2011105091==--
