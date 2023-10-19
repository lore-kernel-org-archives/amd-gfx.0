Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7D8CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 06:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FFB510E484;
	Thu, 19 Oct 2023 06:03:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD9110E484
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 06:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+cteQ19HLqRB+zMYHd3OclxKmqPPs93EAQnmIarZNiwI/3MExGedvhhXUfZxRKDMn+IutmJ6ArBBTufI+XSEeTzv1GbniCnO0VoV7m4uRY9q+eJ61vgvpcBTQ8uxByqXOg/7XbQwCatau7FDKKoj5AQ+9qWrOfraOYNOp9wtfNMKHYJSMoLw0L603aXHfudxkS0zQuUto+UxtGw7Vyxsrubf0Ce8AtdTYxtqP7Br465yFgZDdovI3xl+q4DC39Ifb4PNOyyClpfTWl0t8kfIJl7jHTKqP/BIQvp5VTXayDFctZbmzGg3aQbMYBjhvmnM/gVRGW+wue9+kgfwIVqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZkU5zyFBXdoLcYpUemN+8lCJcpQR8zhG0n2Ie96G1c=;
 b=Pr0FYVjtPwMPMsaXHPTF4z7AKujw11bT0KKLQwsDNv8nMMSlihXfeH74GC9CFe3R4bz02GoABOLx/YK8ho2ufEc6saArZGTjCyNs7pz32itmLs8SYdzmHgoYp1HijMSYXMuLJk+PeFdkCmnW7Nn0W5zN/fUXjf2lcQcSq5g98oox0g/9ub0em5QI6oUK0n63MRxwJhLy9eaNVcnZ0XjwtVttJPR3FRYtDoRl1SXv1wPeNUPbffemdDuHq5utxHDAABN453r/aD8E7ca6316OlaeJ4LXfdytJp/TawAgOmY2458yNHcxcVM7zHBezrrgCkFAYNRDlJSllggVjTtTydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZkU5zyFBXdoLcYpUemN+8lCJcpQR8zhG0n2Ie96G1c=;
 b=HdSvfftlgowl3CNt3r+YUG00gkGWIxi4e2sZnNj6Kee4G7Giei3j2A7p2yC3RBFAaOUnzTbbuz1JstkHj2eVVmsVdxvDES35jaHpCii+OeqolfEnlU39L7M89DgVs5Gp9Z2vmZrszpESukBg1OcWhxRZMYBLu6RHaOhnQWMq6gc=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 06:03:13 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd%5]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 06:03:12 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhu,
 Jiadong" <Jiadong.Zhu@amd.com>
Subject: Re: [PATCH] drm/amd/pm: drop unneeded dpm features disablement for
 SMU 14.0.0
Thread-Topic: [PATCH] drm/amd/pm: drop unneeded dpm features disablement for
 SMU 14.0.0
Thread-Index: AQHaAj3UWGwzB9hJqkiempXOrgnA3bBQnyHG
Date: Thu, 19 Oct 2023 06:03:12 +0000
Message-ID: <CY5PR12MB6369DBFBEC74F2124BC9573EC1D4A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231019033845.3184809-1-jiadong.zhu@amd.com>
In-Reply-To: <20231019033845.3184809-1-jiadong.zhu@amd.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-19T06:02:13.6889338Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|BL1PR12MB5125:EE_
x-ms-office365-filtering-correlation-id: dd68ed2c-eeaf-462f-43e7-08dbd069140c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MzqnOMnBu9ckDqXHH5cT1z+1XIAk10TV0UtzBmVwwDz2TYGF8DNmuCLKhNIciq2eofwKfb6tb9ALtBuiTz9xg7wXdK5hu0ZfZKgosoSZVnlrOTQVfDzC43HEUkroeFNLnxBvBVtFBoXiqgTqlCKmzBoQEXszmBe4a+LW4pJDyyGsy4s2hvaUpenU8hfU0AlUjFQbr5csdERCp9CZLqOwXMb2XHb3aE/1LZT6gsgoR+CJvrTYK9sbS+Bvb0rbhB9jGCEt7gO3QYkyMrrcBuoesbKaNpUpzZSEI2ij9PSU5aarGswtsEPyrvwUa5wWg2jLunawQHkId83npeeL8nYS0c0qBCy5ZQQo4VJTprd81W1BOVHDm/kO0sRLOuj0ETcHwlXdRzfMSfNW+ilJLJE5ms2NmMEerlndWHIo5aCCwGuZaCba+K4JJap1G0DrSyRya0H5L9YoUNDZLXjvgBee0Kag1RTjtkn4SQh4e0/a9ipMGk8A2iH03r7qwwIBZucOAovMUnFW+dTzsVdCWfzEwy96Xg3weSDuB/Tgy6KVEEkkQuFU++bDSt7NMshORQN2S/a5kix804KTWGsGhasvGbGyfhekpKFU70sh/1zzfcGJJEwWyoaFkzhsT1S6aaO9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(55016003)(38100700002)(52536014)(71200400001)(110136005)(5660300002)(76116006)(66946007)(83380400001)(4326008)(86362001)(8936002)(41300700001)(8676002)(66446008)(9686003)(66556008)(6506007)(64756008)(316002)(6636002)(2906002)(66476007)(7696005)(38070700005)(478600001)(122000001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NldCS1MzUGxXQW1xNU12VytpVTlHUXFPS1VVNC9Wd0YvQ3JmRmlQQ3FSVUp2?=
 =?gb2312?B?eW5aYjJxT2Z1Y01kRVI3cU9KWlhDYzY4TE1lU0JmeGRhSWlQcHJOb0tHRXhC?=
 =?gb2312?B?c204OGtjMWZKbkV4ZWJ5TWkzbUJSaGE5UklUTU9ENmdKYU5hcGJxOElKZTRI?=
 =?gb2312?B?MEFGVHNmbmhJNG9SMjJwTk9Ec05UOCtqemR1cUZuVklCdDVjK2o3L2RWK3d2?=
 =?gb2312?B?d1RpWE0xdGFpZmpOOVlLZjhUcktsYkRzYUFOVlRrR1hra1k3QmFEb2VRMGcx?=
 =?gb2312?B?U1lCYkFpdDMybXVSUE1tZFRveVl5aWhoZHN3YzVLL2theVBkY0tQeThWcEpF?=
 =?gb2312?B?eUkrNzc0S3BYamhYU3Jkbi9nNGZEMWpMb3htNFVhclFwRW45MDJ4ZGtEQ2t3?=
 =?gb2312?B?RjZlaDJQRDhRZElSYXRCaFo3dWVRRFV3K3Y1b0pyczhhcVFBVGs1K0xGcG8x?=
 =?gb2312?B?VVpRaDd1MDQvck4va2JoenlYUSsxNXkrNTk4WXNVSmRuVjlNSjhBc2dzTlA4?=
 =?gb2312?B?VGVZbmluZ09waERLYTA4dUQ3WVZkVnpnU21Zc3EwUjk3R0hNbEZ5eEEyUXNw?=
 =?gb2312?B?eVQ1VXRNY1dLQkwveWtaTlRYMDhlQk0yT3M1Sm9NYmgyTjY0d3Z4elI4VVpV?=
 =?gb2312?B?YjYyci8zQ0hFb3d2SldzZ2pCVC9MdXhtMVJtYmJvVjNUQUFIVUZZTE4yb3Zu?=
 =?gb2312?B?U3FuY3NCbHBSdW03U2sxMHhFc1lkUzlBWTFPN2VrZmd2WTE5dUIwUVVpNEhG?=
 =?gb2312?B?Q0t0NmNmVm4yMzFCMHV5eG9HQlhFcVpwdHJKM0VhMnNRamVUTUFWSGZCbW5L?=
 =?gb2312?B?cTJaSlF6RVRERGdHWUxYb2pGem9yRW9qRnhDYUFvS3dRN05sTk5GSGtmcW9X?=
 =?gb2312?B?anhERmNodkVweVZ0WFk0NHBXaVUwTTQyeERZeUluRzZFWU1ySXVqcjdOdmxR?=
 =?gb2312?B?a2Q0V0RLRWRnZzVmbGVuVHZBdVQ4eXVtaXZmcXNQelg3bFNnNUIxWldsQjVK?=
 =?gb2312?B?K0xycVVnb050Vjk1czZvcHpTMVdlVlZJRTRZNWtleEx4RHRlZHdBbXBQbTBB?=
 =?gb2312?B?K3phdHdDUWxZenpxYW5YU1hjVkVZbnU2WVhhR2ZPMFVTeDVmYmFSV213SE14?=
 =?gb2312?B?cUM2bFMxTStwVVhlVnY3Sm5BS3VEVUkvTW84VUI0Q0JxUHNodGg0UGdIUXZD?=
 =?gb2312?B?Mk1nYmo1ZXFVYVpqRUJacWNtNDRUZmRldWpvTUl6S1o5c3pNdEFzNm8waGU3?=
 =?gb2312?B?dGRaQ3NXdXlGZnI4dmtock8wUng0aHdzaUJxL3pHYzNvZjVjVi9zV24vb2hx?=
 =?gb2312?B?Wndkek5zL2hzREIyaVVtRThTTWdKZFZaTDZlNGM1VDRTcVUrcXJPd3RmYlhW?=
 =?gb2312?B?YUJJYit1cHRmbEh5ZGp3cUE1MXE2TVNvZUNFZzV3NDg4a3l5QTlncWJXc0dF?=
 =?gb2312?B?VHBYbW5PbkxpdTlPWkYzQ0tjU3RTajBMQUJDRmxaMXJnUy9uYWVnTzlzazdO?=
 =?gb2312?B?Q1p0WnBRVlhmWnN4dHZxZnkzT3RjakZpZUlaVFpsSmxoTy85M1ZjaStPT1Jn?=
 =?gb2312?B?M0hoYlJaQWd0aHVrdE5neEtaTkN3L0dCbTFGbCtrTkN1dzcyVklKQ1pVYitq?=
 =?gb2312?B?UGRNWURYdmdoc2lHd1FvcU52M0gzUEdobWdkSnFQNnladkJOTUsvSXRFT0sz?=
 =?gb2312?B?cWtMQ05JUlVEaDV5N2dXc2w4Vm94cnlNK2tucHJQdjFkRGdBazRFME9kalVv?=
 =?gb2312?B?a2NnT1l3VCt3OTZIOUZHNTBPbUNxRjZrTThTcjRwT2FDVTdUeWowano4K3Iy?=
 =?gb2312?B?alhpRjAwZXVTWUZzVU9wL2hPdk5udWtwbDU1K1RXUW9PMytVYlRTblVGQy9u?=
 =?gb2312?B?aUVNWndHMUVPRi9ORVJ1MDBDTDc1MHZyZUVvRU1PMjJESE84d0JtTVpnSk1z?=
 =?gb2312?B?bnd4MTRKQnUxT3J6SXM3UjZSYzkwS2w0bGxoU0JsYTRXakJ0R3F4SDV2blRm?=
 =?gb2312?B?NTNqVFlMSkxLMHhkeDNUMVhFZjUyUnh3VHM5VUtXSVFuUzlzL1FCU1BVdVBW?=
 =?gb2312?B?TG5SSjVTdExVVE85Y3p4Nysra1dEbzNlZ2JueUJuNFE5d2dpQ1ZGL29NUis4?=
 =?gb2312?B?cHIyMzMrdGNKS1pHQ281UmltY2hQdURzVTR3TmlNRXJsLzRSUzVlem1ML3J4?=
 =?gb2312?Q?x/zRURkTN1/VwnVEri4qE+R4EkypAxD9sTCBnH6+jNhu?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB6369DBFBEC74F2124BC9573EC1D4ACY5PR12MB6369namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd68ed2c-eeaf-462f-43e7-08dbd069140c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 06:03:12.9426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bMuPpsMOD47xdkssYCPnWUKCEG4Dn5bNkPOhIuSql5er1CvCDyBnnm/7AOeKFdCF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
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
Cc: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CY5PR12MB6369DBFBEC74F2124BC9573EC1D4ACY5PR12MB6369namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoaXMgcGF0Y2ggaXM6DQpSZXZp
ZXdlZC1ieTogWWlmYW4gWmhhbmcgPHlpZmFuMS56aGFuZ0BhbWQuY29tPg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCreivP7IyzogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZz4gtPqx7SBqaWFkb25nLnpodUBhbWQuY29tIDxqaWFkb25nLnpo
dUBhbWQuY29tPg0Kt6LLzcqxvOQ6IFRodXJzZGF5LCBPY3RvYmVyIDE5LCAyMDIzIDExOjM4OjQ1
IEFNDQrK1bz+yMs6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4NCrOty806IFpodSwgSmlhZG9uZyA8SmlhZG9uZy5aaHVAYW1kLmNv
bT4NCtb3zOI6IFtQQVRDSF0gZHJtL2FtZC9wbTogZHJvcCB1bm5lZWRlZCBkcG0gZmVhdHVyZXMg
ZGlzYWJsZW1lbnQgZm9yIFNNVSAxNC4wLjANCg0KRnJvbTogSmlhZG9uZyBaaHUgPEppYWRvbmcu
Wmh1QGFtZC5jb20+DQoNClBNRlcgd2lsbCBoYW5kbGUgdGhlIGZlYXR1cmVzIGRpc2FibGVtZW50
IHByb3Blcmx5IGZvciBncHUgcmVzZXQgY2FzZSwNCmRyaXZlciBpbnZvbHZlbWVudCBtYXkgY2F1
c2Ugc29tZSB1bmV4cGVjdGVkIGlzc3Vlcy4NCg0KU2lnbmVkLW9mZi1ieTogSmlhZG9uZyBaaHUg
PEppYWRvbmcuWmh1QGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L2FtZGdwdV9zbXUuYyB8IDMgKystDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9hbWRncHVfc211LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUu
Yw0KaW5kZXggN2MzMzU2ZDZkYTVlLi5hY2U3MWFiYmJjZjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCkBAIC0xNjc3LDEzICsxNjc3LDE0IEBAIHN0YXRp
YyBpbnQgc211X2Rpc2FibGVfZHBtcyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkNCiAgICAgICAg
IH0NCg0KICAgICAgICAgLyoNCi0gICAgICAgICogRm9yIFNNVSAxMy4wLjQvMTEsIFBNRlcgd2ls
bCBoYW5kbGUgdGhlIGZlYXR1cmVzIGRpc2FibGVtZW50IHByb3Blcmx5DQorICAgICAgICAqIEZv
ciBTTVUgMTMuMC40LzExIGFuZCAxNC4wLjAsIFBNRlcgd2lsbCBoYW5kbGUgdGhlIGZlYXR1cmVz
IGRpc2FibGVtZW50IHByb3Blcmx5DQogICAgICAgICAgKiBmb3IgZ3B1IHJlc2V0IGFuZCBTMGkz
IGNhc2VzLiBEcml2ZXIgaW52b2x2ZW1lbnQgaXMgdW5uZWNlc3NhcnkuDQogICAgICAgICAgKi8N
CiAgICAgICAgIGlmIChhbWRncHVfaW5fcmVzZXQoYWRldikgfHwgYWRldi0+aW5fczBpeCkgew0K
ICAgICAgICAgICAgICAgICBzd2l0Y2ggKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIE1QMV9IV0lQ
LCAwKSkgew0KICAgICAgICAgICAgICAgICBjYXNlIElQX1ZFUlNJT04oMTMsIDAsIDQpOg0KICAg
ICAgICAgICAgICAgICBjYXNlIElQX1ZFUlNJT04oMTMsIDAsIDExKToNCisgICAgICAgICAgICAg
ICBjYXNlIElQX1ZFUlNJT04oMTQsIDAsIDApOg0KICAgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiAwOw0KICAgICAgICAgICAgICAgICBkZWZhdWx0Og0KICAgICAgICAgICAgICAgICAgICAg
ICAgIGJyZWFrOw0KLS0NCjIuMjUuMQ0KDQo=

--_000_CY5PR12MB6369DBFBEC74F2124BC9573EC1D4ACY5PR12MB6369namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"ltr"><span style=3D"text-decoration: none; font-size: 14.666667=
px; display: inline !important; color: rgb(33, 33, 33);">This patch is:</sp=
an><br style=3D"text-decoration: none; font-size: 14.666667px; color: rgb(3=
3, 33, 33);">
<span style=3D"text-decoration: none; font-size: 14.666667px; display: inli=
ne !important; color: rgb(33, 33, 33);">Reviewed-by: Yifan Zhang &lt;</span=
><span dir=3D"ltr" style=3D"text-decoration: none; font-size: 14.666667px; =
color: rgb(0, 120, 212);">yifan1.zhang@amd.com</span><span style=3D"text-de=
coration: none; font-size: 14.666667px; display: inline !important; color: =
rgb(33, 33, 33);">&gt;</span><br style=3D"text-decoration: none; font-size:=
 14.666667px; color: rgb(33, 33, 33);">
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> amd-gfx=
 &lt;amd-gfx-bounces@lists.freedesktop.org&gt; =B4=FA=B1=ED jiadong.zhu@amd=
.com &lt;jiadong.zhu@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> Thursday, October 19, 2023 11:38:45 AM<br>
<b>=CA=D5=BC=FE=C8=CB:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;<br>
<b>=B3=AD=CB=CD:</b> Zhu, Jiadong &lt;Jiadong.Zhu@amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b> [PATCH] drm/amd/pm: drop unneeded dpm features disable=
ment for SMU 14.0.0</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Jiadong Zhu &lt;Jiadong.Zhu@amd.com&gt;<br>
<br>
PMFW will handle the features disablement properly for gpu reset case,<br>
driver involvement may cause some unexpected issues.<br>
<br>
Signed-off-by: Jiadong Zhu &lt;Jiadong.Zhu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index 7c3356d6da5e..ace71abbbcf6 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1677,13 +1677,14 @@ static int smu_disable_dpms(struct smu_context *smu=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For SMU 13.0.4/11, PMFW will =
handle the features disablement properly<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For SMU 13.0.4/11 and 14.0.0,=
 PMFW will handle the features disablement properly<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for gpu reset and =
S0i3 cases. Driver involvement is unnecessary.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev) =
|| adev-&gt;in_s0ix) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 11):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(14, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY5PR12MB6369DBFBEC74F2124BC9573EC1D4ACY5PR12MB6369namp_--
