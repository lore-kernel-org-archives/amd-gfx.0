Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288C8C25B50
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jan 2023 23:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A99B210E5B7;
	Mon, 23 Jan 2023 23:04:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B6E510E5B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 23:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iexj5Ua1Zi/SX4fguzRrGQzzvJFxHh1yQilfdFgpcp8t0uQFWp88wUbIr4y8T4+H9i9rQafhEUoxdCN2RDSwt8f4MwROo1yRHDAwUjfI9NdzLw+DekiqEbKmA1TIGxbr8lWB/ZV6XoahO3BpSpG87Pi3BNTR73J+xU+qA5PCDL6gjoFzGHRuYiUyAyUT54U+tGL1X9EV4FMx7i74HlBQV4H5ZAi9OSegfygkwLXSi2om1MtLEtEehaxgvvlCxAby0Y78yfEJuRfgHkd6DE7XmDX3RXu0Nj8Fv3N3UlgNbNGWycsGvzUDEGD8f8SaoUFRVo7oC063Sp1JDh3wKPbyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnC3YHhr+DZLgVzLVTvU1RP4kgGyUYpm+++rzRFgOBo=;
 b=kkJbV4+NQPVLvO80cdGlhVM6RgNTY1cmKVzQxeQiXS0nH5uWsNTBuAFQ330IfKVeGL1kWzVZc23AVJFJeV+n1/V8BUEKzXSPrA+8FoeYRlVHCAvGJBRY7eGr5viA4vs29VKnGfzoth7pU892SRDA1/rqR+SzQl1+k4tXYuC3No2NryFqNyOdbW0iEuT5CFgsVMfWMo76HrYvisrupa8BwrZR1/dzmLhlPhbaOmPGXSku7lIqNNbpO3rcyjaajbq0+D2c7qf4+b2AJsMNBhiAZWZUumo9udo8h88fcTOIRu4zg2efqNdFF/JhtZcyLXNOf6VU6iobcdhQe9b9dNeqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnC3YHhr+DZLgVzLVTvU1RP4kgGyUYpm+++rzRFgOBo=;
 b=KrEiiF4+DdbOJBIO+6ntdpgw16x9Hf6/Zo/SGTbPWnIkGk5dhWF2QOKarNkPh8KaUZA19oauwymlMgy99Jg5NNq+y15ythKPiNtuxWhbx5Bl8yqbFE7n3d26+IfoSpVNrM5UuoG7+jyVugn9Dc6VyvzGdu0yqCl32+gdp28P9Zk=
Received: from DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) by
 SN7PR12MB8102.namprd12.prod.outlook.com (2603:10b6:806:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 23:04:25 +0000
Received: from DM8PR12MB5414.namprd12.prod.outlook.com
 ([fe80::6b82:c4d3:82e6:1259]) by DM8PR12MB5414.namprd12.prod.outlook.com
 ([fe80::6b82:c4d3:82e6:1259%8]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 23:04:25 +0000
From: "Newton, Jeremy" <Jeremy.Newton@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Fix for UMR on newer C++
Thread-Topic: Fix for UMR on newer C++
Thread-Index: AQHZL35pnc02zerYFUuC5kSnu0clgw==
Date: Mon, 23 Jan 2023 23:04:25 +0000
Message-ID: <DM8PR12MB54149D94A961377F6515A254F6C89@DM8PR12MB5414.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-23T23:04:24.183Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5414:EE_|SN7PR12MB8102:EE_
x-ms-office365-filtering-correlation-id: b4b5b550-93a5-4430-8b77-08dafd962c06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uqSbzWPHDN/vQ9+YFdnx+ei1UihK9+aAp5TrmCjH6cCQVo/2PXi9jLHSYMSf5U9v0DrhYNLIvVqy2ey9Jm0IVIeIT/XBj7pDMKRzSQ8LTsk0sxdZmG1+Pryz2hgSrBVlZqdzjCyZgZvpUVWj3v2LD97Vittw4t7R9+OFbT7xh9PbM5Vj+xbSeFVII+AE84PZumi14hNw6I/7xC/KDsmfnx6xggRZFP2dR/0a3DhHwGbHGfnBAs19uurZuBFzARs2+yOC6q3KL838efc2WSLGErOxCg57uLD+XHGbZETZnGA9Z6xVPEwB6XYccRVQtdOUGJdHLt3Y++ebPj6sc+vbljy8IQu3u/ydg4gDMI8smy0D7J5f1Gxh3CjyOxXGON7QBPb7p7E6ELaEp9Ibj6XOh7u38E4NmtGJtp+9yfC75mivh3GZU7VJ/oBrMRHPXSonKRZa1GY6AcCFG40gIcHNQM/phsts89uIB00f3ndgvrxo61BIFiUJT03x/wzF/VJFKZx6hdbD2CVzxO82hHdyvfLw+m1yVC4IASlBvy80e+dSPXwCYJ9dCion8iy4fpaKfwmcEhMgwU8084dElOhN+7XRikkZCw/Fb9QOp7+dEWc2qCeZOPvvxN1QdgnuPLa3vNcWwVrOLW+PpuPZcNaZTopX2rz3SgUCHEXDzPz3MwSAo1KqwXjJjcrYGIiv3lIqs7HqS1pWy+1x6jtf+RJhBw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199015)(478600001)(558084003)(7696005)(33656002)(2906002)(71200400001)(316002)(83380400001)(38070700005)(38100700002)(122000001)(55016003)(6506007)(26005)(9686003)(86362001)(186003)(99936003)(19627405001)(91956017)(66446008)(66476007)(64756008)(66556008)(8676002)(66946007)(6916009)(4326008)(76116006)(52536014)(8936002)(5660300002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OaUMu/Yuq9lt5x8CE+WdQXnfe7K3FRi8FLVE/2DAAMDlySf8l/Y+MoZonN?=
 =?iso-8859-1?Q?V08NiBb6sOZQ5z/JzHU1/sB4XwSeShBN1qyQGfOBdKZOVORT/0XkEN69mv?=
 =?iso-8859-1?Q?y1+hMIFlYMpfJkDB+44hZAi0+Aohq8U0nyVa/nI/VqT4Ko3uv7N1p4mjLS?=
 =?iso-8859-1?Q?F0JZAIosK5yoDgNuWBhwKJcsxRXx8sgn5bd4OLJc1TWe3mbAv4rzrndzhG?=
 =?iso-8859-1?Q?uyYkSavWCbxE3Djn4w7K6lih7lZ7kBt9nd8cnyKlM8xMKl3K8htbgoSb03?=
 =?iso-8859-1?Q?UNokl5eCE1sVuLvI5Pz5ASvOFC/YJ7VsB+FqUmGPKcouhe4fhHd3aeFOVi?=
 =?iso-8859-1?Q?E/2IphrQ//PRK7m4dE+fvbUNB/dZDGf7e7obb2Idrafm2GqZXHj6l1A97w?=
 =?iso-8859-1?Q?B5joL9K+q5Gv2dCo90kprCsm+5nMweVMQlG/XdWaEqXs0Z9EcW7M4sxXxj?=
 =?iso-8859-1?Q?461EHWoBMqi2P85ZFB44BZ9cXmmjr02PTBP8gE9GsGMxAwGOpMGH3tHOK8?=
 =?iso-8859-1?Q?skADgeWUQ/GpMHiccNKF2IqSisOFn4oNjqeNf7PSijH+XX8dDGYRrt/thw?=
 =?iso-8859-1?Q?3LsOZmHQPblZ9FgapAt5Kx/rvJjrRenCqXjvddVXZjoyXn7itF2I1XgsNI?=
 =?iso-8859-1?Q?M2NmMrCfE+XtpsWN9v0bK9+pl1IUGLAaoGsvuL2LQFD9nLziNxLJErmJLB?=
 =?iso-8859-1?Q?6POm43M+G1IBQkRRPLOEsKZi+orqzmFM4pCptO3wQXMYi+ersPgI0rqv8/?=
 =?iso-8859-1?Q?7cFE3UepVM9IPGm/EaqfijBAyshfbZ60lv6iX9n/AEnoSwo7E5W6m1QSW5?=
 =?iso-8859-1?Q?N0ypKsfVXnvTX5+3/zuxLaj3+6tGmkkM0+VcRdXwxijvSOlYXE3RTrw3Wi?=
 =?iso-8859-1?Q?H5Q+XEn+6I8TxTmpmCw6/5lIFQIJy0EqcT6/zlzFpxODhJaC0szv3ZmGQH?=
 =?iso-8859-1?Q?YHnNYZlonniwLbXgDXqAYF6zYfdvbWWxiiTAMf58jA/O4SET+jABV+F8Fb?=
 =?iso-8859-1?Q?Cxs2GHDBbNhRESB02BPIFMujnT4P7w19dOaG4BkiBDLi09QK5WwNHinNWg?=
 =?iso-8859-1?Q?Rk9a6C9kJU/dT9qeOA/yq/V4+MBNM6PVk5LMChax9PObFgLbzdPRuEk4Yc?=
 =?iso-8859-1?Q?wQ59PKQsHK30nPOGLYRrlvPLmmRBGKFs+VU4EWj+hcxCPD1g9yWSEKb0FL?=
 =?iso-8859-1?Q?3uFUsxd/mIQofuge5VXYmcMjynraGGqPFm4mq9QdYMqC+Jojw6j8R3C59s?=
 =?iso-8859-1?Q?wes0K/zxDPzLlXGtkskder2RoInEP+ulF3b1mfcByKcqj1k7t2+QSKKFe4?=
 =?iso-8859-1?Q?4JwKE9VW0UyCDoHoZzSnCyJ5HUu1SmUCBFthcWH57NFb2907YIBWeNwn/q?=
 =?iso-8859-1?Q?zNu2XwBYfek3d4gDUGJRXkpcm66B2sRUusNB0BuF7H1N6Um0LzufT94F/0?=
 =?iso-8859-1?Q?zOHmMjWuCntwtNveI11HH7XimTLLfAYizrT+diHQ6ggU4KrOsJNhgz1X/W?=
 =?iso-8859-1?Q?k9zryq8o00WtejsI7UB6K6df2eiNLIpZffHhduaC4CztmpCMPtTvKKmtQQ?=
 =?iso-8859-1?Q?GvRBvOVxFIE8RIoAa/e7qhyBvfAfLjgP2nRcxKs68MNmb6V5eOwpjsFAAX?=
 =?iso-8859-1?Q?6pdrT3rr0dEHM=3D?=
Content-Type: multipart/mixed;
 boundary="_004_DM8PR12MB54149D94A961377F6515A254F6C89DM8PR12MB5414namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b5b550-93a5-4430-8b77-08dafd962c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 23:04:25.1738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: obEV3N37N59l25c+vXWO3ClxqkMTuaNJzOMs2vEWhqoThabatyuKDpzJqn84O7/M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8102
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

--_004_DM8PR12MB54149D94A961377F6515A254F6C89DM8PR12MB5414namp_
Content-Type: multipart/alternative;
	boundary="_000_DM8PR12MB54149D94A961377F6515A254F6C89DM8PR12MB5414namp_"

--_000_DM8PR12MB54149D94A961377F6515A254F6C89DM8PR12MB5414namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


I noticed this today; it's required to explicitly include "<string>" in new=
er GCC's, which I think has to do with newer C++ standards.

None the less, see the attached patch.

--_000_DM8PR12MB54149D94A961377F6515A254F6C89DM8PR12MB5414namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof">
<p class=3D"FluidPluginCopy ContentPasted0 elementToProof">I noticed this t=
oday; it's required to explicitly include &quot;&lt;string&gt;&quot; in new=
er GCC's, which I think has to do with newer C++ standards.</p>
<p class=3D"FluidPluginCopy ContentPasted0">None the less, see the attached=
 patch.</p>
</span></div>
</div>
</body>
</html>

--_000_DM8PR12MB54149D94A961377F6515A254F6C89DM8PR12MB5414namp_--

--_004_DM8PR12MB54149D94A961377F6515A254F6C89DM8PR12MB5414namp_
Content-Type: text/x-patch; name="0001-gui-missing-string-include.patch"
Content-Description: 0001-gui-missing-string-include.patch
Content-Disposition: attachment;
	filename="0001-gui-missing-string-include.patch"; size=650;
	creation-date="Mon, 23 Jan 2023 23:03:23 GMT";
	modification-date="Mon, 23 Jan 2023 23:03:55 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjNjg2M2U3Njg3NDA0YzYyODUyMWQyYTk2ZDAwNTVlYzk4MmY2ZGYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKZXJlbXkgTmV3dG9uIDxKZXJlbXkuTmV3dG9uQGFtZC5jb20+
CkRhdGU6IE1vbiwgMjMgSmFuIDIwMjMgMTc6NDQ6NDUgLTA1MDAKU3ViamVjdDogW1BBVENIXSBn
dWk6IG1pc3Npbmcgc3RyaW5nIGluY2x1ZGUKCkZpeGVzIGJ1aWxkIGlzc3VlIG9uIG5ld2VyIEMr
KwoKU2lnbmVkLW9mZi1ieTogSmVyZW15IE5ld3RvbiA8SmVyZW15Lk5ld3RvbkBhbWQuY29tPgot
LS0KIHNyYy9hcHAvZ3VpL2ttc19wYW5lbC5jcHAgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3NyYy9hcHAvZ3VpL2ttc19wYW5lbC5jcHAgYi9zcmMv
YXBwL2d1aS9rbXNfcGFuZWwuY3BwCmluZGV4IDY0MDc2ZjAuLmU5N2M1ZGMgMTAwNjQ0Ci0tLSBh
L3NyYy9hcHAvZ3VpL2ttc19wYW5lbC5jcHAKKysrIGIvc3JjL2FwcC9ndWkva21zX3BhbmVsLmNw
cApAQCAtMjQsNiArMjQsNyBAQAogICovCiAjaW5jbHVkZSAicGFuZWxzLmgiCiAjaW5jbHVkZSA8
bWFwPgorI2luY2x1ZGUgPHN0cmluZz4KIAogY2xhc3MgS21zUGFuZWwgOiBwdWJsaWMgUGFuZWwg
ewogcHVibGljOgotLSAKMi4zOS4wCgo=

--_004_DM8PR12MB54149D94A961377F6515A254F6C89DM8PR12MB5414namp_--
