Return-Path: <SRS0=7Ry8=JY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7C2C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 20:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE776112F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 20:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE776112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D961E88FFB;
	Tue, 27 Apr 2021 20:21:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62A2A88FFB
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 20:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzVfF/tu+mxPnc0bBCgLmxJUq9RKktREAC0fRmQTctDQR/1lkim9ObvkmUbr8F6vI8EBRkbbtQAgHgD+B66nX5mmAplwigUuH8do91jQaSm0HFwsCmdOo5XRQ38eEU6LTRDNNmfY5UOUidwSt6agGe1zGAmeNPwbioZoXusTBHhk9x8Rs8OMJJR/JwB4W7V8O/H+dNdXozG07IL5o1ArEyo3ekK6/hou20LLek2R0iizZEUYMb3T/ilvj+YmSkOMMvEM5NoZvunNRZAogqz1rpLIqw8FfUzuxS0zxGyUkgVUhRLMfisx/VQy7U5MDUeoa2RHJ/wKtkY5E5kA08HVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NZYAqraZHAVDKBwnufdRdojY68MEpUbgtkW8541lrM=;
 b=BXVPsnU4dqVGGK3XKrrgHHXmdlzHENNKOZm9FRhvH/4BhtddbeaPVFa5esueOqtwqjJmWWFSNE9+ZiiUCbRYWnCAs8wkv+MMj/VswSBKP7oRD/DgD2wI+YRjqlutweTka0fg5W8UY0WcstV+4stH1UJTXp58ZcmMFueoH91c0I9zJHWb/cm9+Xbf76P0Kum1eAUsNUHZr6HEHXBuIAq+5Mar/77F22uuHkdDhq8mbbSondaVrFr0+68xwOFAm+bGKnHjtBciXJBiL6BBqEDKDyeGzdCUzWIZtWDOEg2Q6/jxo06FQT6IW5eDoj2iPKH2zN+Ne8n4XBJSB2fVksZPVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NZYAqraZHAVDKBwnufdRdojY68MEpUbgtkW8541lrM=;
 b=Wa/+KBzVr0zg8AGbetMBxRAWofwUcUgB3uW3bUwGFW/N/JYxalCXCQh37rgONcD479bUK7j0JyRFhQAP6UOIVSaYKNAff4fNfxDBy0Q3ZJdxpEYbOQFFD/fr76HfIuhjZdi5y517+sWb+JBj3uVyI4uoW7C+v+pBc6m0w9F1sAM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2529.namprd12.prod.outlook.com (2603:10b6:207:4e::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Tue, 27 Apr
 2021 20:21:45 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4087.026; Tue, 27 Apr 2021
 20:21:45 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zeng, Oak" <Oak.Zeng@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix no full coverage issue for gprs
 initialization
Thread-Topic: [PATCH] drm/amdgpu: fix no full coverage issue for gprs
 initialization
Thread-Index: AQHXO3L1UmYa1Zd620SCMMpWzE8sm6rIc9aAgAAF5ACAAALigIAAASOAgABEGACAAAiCI4AAAQSAgAADB3M=
Date: Tue, 27 Apr 2021 20:21:45 +0000
Message-ID: <MN2PR12MB4488EB63FD9E79897959201FF7419@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210427143756.8628-1-Dennis.Li@amd.com>
 <BN9PR12MB53682204CA3E3B9AC63FD72FFC419@BN9PR12MB5368.namprd12.prod.outlook.com>
 <b12f3f8b-c92f-ee57-4c07-2554db1f3598@gmail.com>
 <BN9PR12MB5368223AE794B23DAC720011FC419@BN9PR12MB5368.namprd12.prod.outlook.com>
 <ee2a8831-227d-e50b-992c-d10d7056b7c1@amd.com>
 <705C14FD-7880-4653-8C81-058FF2BB9496@amd.com>
 <MN2PR12MB44886BBB9DF0A00A85B58962F7419@MN2PR12MB4488.namprd12.prod.outlook.com>,
 <B347578F-A26F-4801-A451-9A457E113034@amd.com>
In-Reply-To: <B347578F-A26F-4801-A451-9A457E113034@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-27T20:21:44.968Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f825b60-6803-4f36-2a09-08d909ba1439
x-ms-traffictypediagnostic: BL0PR12MB2529:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2529313DA78DE66BBC4A51FEF7419@BL0PR12MB2529.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: loqweFsBhyYxn1ppJqAMpXt1cbmoOT0kcYtX+RpyLhhacj7yGTYrZhc10ixgaNcn5fbdHQpGQN0m7gcf1BhV6e1cFczopcoHmKo0gL3MGnwMORG0Q2qfz33QO0QBwbZV9FnL3keuHsGNxNV/EIq6y/xnWcbpnFHIg9l0KXjfnfZxJhrcquR4XXskpdFpoIXgMSM0BXkf5tYqlP//wGbcAqaGB5qjR/YTSkSe6ToM+IzLqIl4vmAxY1AWruVwwL6r1lgbO56bMCc/yPKGCsW5qy/biMAoqXnauFELXISKf9aJqHLOg3oAICc9ocdkd6b+p0gY4jQyhRVagJ0KIfXcu3n74lFofh9XM3BZcSDMtNiidWe9LW14eTNFYZ8COZhwzeWwBzTa8qJXWMdmHmsQece3TzBAu9UxgBh/+cxvN2NjawQyPb2kvlwuo2Qu6k7ceLlws4L0AGDOQsb4OV8s4UTzLRoCKMbganD698cskjcBPX+l78p6EfRn0l5kCQGPP5Ue4yrjNevz9tymUvbcwgo7osdgHsaCfO5w9C17r0AUD+c5ELzh4mxP7dYQwCHiy2EOAqlZ973KsM9WZGCP+zV9YP/7WYm2szJro4HBrXw0juqc2vWvGvIPqV6XwQmKcm6GNonGb2cg9yta+CzdqiUTCnygg5lr7CJ45jJz/BBmOHzyi0BQpjJMSq5Y3qyMwfFW+V30k/M+WsX8JAKcvk1y+ZMk0LoDP9aZ6UEsOmU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(76116006)(66556008)(64756008)(66446008)(66946007)(33656002)(66476007)(166002)(186003)(86362001)(316002)(52536014)(26005)(6506007)(19627235002)(71200400001)(55016002)(9686003)(66574015)(83380400001)(5660300002)(6636002)(7696005)(45080400002)(2906002)(122000001)(30864003)(19627405001)(478600001)(8936002)(110136005)(921005)(966005)(53546011)(8676002)(38100700002)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?1c/tcLhr9889gqSbCWu9nqkjWUUM6kfBk2wl7Q3cOmGwH9x0mg3F24Bykm?=
 =?iso-8859-1?Q?MkkYOPOrg+Zw+mjgaLdcIQVbmX3f3dy8dO+HCr6BVDGfIDZat2EOBCbRgZ?=
 =?iso-8859-1?Q?UIqR9vBbrKNxvRq+Ux6FY8nuMdsARTfwIdSOR/ktgqgmfl7t2zmP3JfTw1?=
 =?iso-8859-1?Q?+Ka1wC+1UbdybF0YQByJwB8ShHDBJX5pfv/L6q2/FWTDPppigx2oyAmty+?=
 =?iso-8859-1?Q?v/0gakhbFqeUml/aiqVm4KoLH/TUU+WLUZ33SwzZgP95neh9oAki6TJWOg?=
 =?iso-8859-1?Q?u45in5LB4pt58ZJXMZu5z7sMvauk0WsFh+4XpA7VuaXFUGwUKREia88FGa?=
 =?iso-8859-1?Q?/OCCkEu4l4k/I+CyhIBhZiLSzLXGiS69cXQktzpJ3NCDgTWOPxOo621K58?=
 =?iso-8859-1?Q?3p6yWlobD5NkpL/Q6m/wP2AAMrKgjcpGtwO69uIBR/MmibyiEgUYX8xl+0?=
 =?iso-8859-1?Q?wuqOLWtlqsbIDwEN6FkUnfiUzsZp6jx9/NrxKtXiQwSqR/5t2Uq4rtSQk+?=
 =?iso-8859-1?Q?VOwfnNCEAfsigNbeSCNF66zbtuwU40HbVZMmty41RNesqnqQloTtQMsWO3?=
 =?iso-8859-1?Q?O1ElOJyHIC65iywpbgaQcp3t1m/Bze0cM4XDlXj0No9lzCWXoXaviTTi/7?=
 =?iso-8859-1?Q?WxyrLSU0GuPX9E+TxnRKltw/LteD7TOTuX66fnsxj26SHBXYRXfkPMq+Bc?=
 =?iso-8859-1?Q?iaeheYDRsB+wDkr+L2QKxp6sOuaQOvO4RSEYpHSx3jyOhUEqiS/ryyElXj?=
 =?iso-8859-1?Q?5fRFTl9FDpWVRQzvpaFbl/7lt/IrHD+QFi/svV0FARqh1PIlOeJa9/2vkL?=
 =?iso-8859-1?Q?A9YaJpa0rMDK2jbG0+9OoKC9KhxcE8iU8CZEGIvlEHTWNvnSb1LZJu/mwQ?=
 =?iso-8859-1?Q?tDYIk7qw34xdxeqoQiZ5DhV9mqO6ElMbthE83ugr5atvyu2CpY37F2Xnj2?=
 =?iso-8859-1?Q?yHf7dHphMIRrOcwt9685HaIjrwrgs8cer+Bwr65AnYqNDjJmgbt6sijGTJ?=
 =?iso-8859-1?Q?9vLid2Amcy/B/d5nCpn9VOHH/M4vGNvN0rSG45XXZOXw8AwPqO3hLv1xHJ?=
 =?iso-8859-1?Q?tO841MANLAaDXlsVaoPdrPUogQ/MyWtXdjc9Bcf0Q2/yMV4la/rlXdLovi?=
 =?iso-8859-1?Q?tiBiFThpnA/av4ozOgRQDc6kcPjmt/UK8C8Ult+qT2+zc2FXgngta+r6jh?=
 =?iso-8859-1?Q?yP2tuRwcuymBYzd8h4HqXpxh5cKHaMS2udEIvX0g+9Xjfse7WFSuJn2kt1?=
 =?iso-8859-1?Q?+U7efLJsN1ctqG2JSKA82fuhIwOK3BfljPl1sqBKfJbB1h6vaGSGxFukwy?=
 =?iso-8859-1?Q?hqIZ7q5Sp3/lX6JNfMCCL5Q5LqvBTQK4Qo7t/ASwuAXSSvjz6vTJzKKOKU?=
 =?iso-8859-1?Q?b+vilCMIiW?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f825b60-6803-4f36-2a09-08d909ba1439
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 20:21:45.5432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHCL3MuMA7LwL9Xx5jhdcsqxzxOQy5OmU6+xaMcKTtnqnH2Dv5zFLPOgnJg1KSkXQhYFvWwam/R1u+npsYrdsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2529
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
Content-Type: multipart/mixed; boundary="===============0975494813=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0975494813==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488EB63FD9E79897959201FF7419MN2PR12MB4488namp_"

--_000_MN2PR12MB4488EB63FD9E79897959201FF7419MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

I mean, we wrote it in binary since they were so small.  I don't remember h=
ow the newer ones for vega20 and Arcturus we generated.

Alex

________________________________
From: Zeng, Oak <Oak.Zeng@amd.com>
Sent: Tuesday, April 27, 2021 4:08 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Christian K=
=F6nig <ckoenig.leichtzumerken@gmail.com>; Li, Dennis <Dennis.Li@amd.com>; =
amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Kuehling, Fe=
lix <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix no full coverage issue for gprs initia=
lization


Yes in that case, we can check in the hand writing assembly codes.



Regards,

Oak





From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Date: Tuesday, April 27, 2021 at 4:06 PM
To: Oak Zeng <Oak.Zeng@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.=
com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, Christian K=F6nig <ckoenig.=
leichtzumerken@gmail.com>, "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists=
.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix=
.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix no full coverage issue for gprs initia=
lization



[AMD Official Use Only - Internal Distribution Only]



That would probably be helpful.  TBH, I think we hand wrote the original on=
e for CZ so there was no original higher level source code.



Alex



________________________________

From: Zeng, Oak <Oak.Zeng@amd.com>
Sent: Tuesday, April 27, 2021 3:34 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Z=
hang@amd.com>; Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; Li, De=
nnis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.free=
desktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Fel=
ix <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix no full coverage issue for gprs initia=
lization



Hi Dennis,

Should we check in the compute shader source codes? I only saw the shader b=
inaries. This will be helpful if people want to modify those shaders/fix is=
sues. The source code can be in a comment section above the binary.

Regards,
Oak



On 2021-04-27, 11:31 AM, "amd-gfx on behalf of Christian K=F6nig" <amd-gfx-=
bounces@lists.freedesktop.org on behalf of christian.koenig@amd.com> wrote:

    Ok in this case looks good to me.

    Christian.

    Am 27.04.21 um 17:26 schrieb Zhang, Hawking:
    > [AMD Public Use]
    >
    > This need to be done during reset as well.
    >
    > Regards,
    > Hawking
    >
    > -----Original Message-----
    > From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
    > Sent: Tuesday, April 27, 2021 23:17
    > To: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd=
.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher=
@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Chr=
istian.Koenig@amd.com>
    > Subject: Re: [PATCH] drm/amdgpu: fix no full coverage issue for gprs =
initialization
    >
    > This is only done during bootup, isn't it?
    >
    > Wouldn't it be better to use the normal IB pool instead of the direct=
 one? Or do we also need to do this during GPU reset?
    >
    > Regards,
    > Christian.
    >
    > Am 27.04.21 um 16:55 schrieb Zhang, Hawking:
    >> [AMD Public Use]
    >>
    >> Please split the following into another patch when you commit the on=
e.
    >> Other than that, the patch is
    >>
    >> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
    >>
    >> Regards,
    >> Hawking
    >>
    >> @@ -479,8 +710,6 @@ void gfx_v9_4_2_init_golden_registers(struct amd=
gpu_device *adev,
    >>                            die_id);
    >>                   break;
    >>           }
    >> -
    >> -        return;
    >>    }
    >>
    >> -----Original Message-----
    >> From: Dennis Li <Dennis.Li@amd.com>
    >> Sent: Tuesday, April 27, 2021 22:38
    >> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
    >> <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com=
>;
    >> Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian
    >> <Christian.Koenig@amd.com>
    >> Cc: Li, Dennis <Dennis.Li@amd.com>
    >> Subject: [PATCH] drm/amdgpu: fix no full coverage issue for gprs
    >> initialization
    >>
    >> The number of waves is changed to 8, so it is impossible to use old =
solution to cover all sgprs.
    >>
    >> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
    >>
    >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
    >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
    >> index a2fe2dac32c1..2e6789a7dc46 100644
    >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
    >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
    >> @@ -328,7 +328,7 @@ int amdgpu_ib_pool_init(struct amdgpu_device
    >> *adev)
    >>
    >>           for (i =3D 0; i < AMDGPU_IB_POOL_MAX; i++) {
    >>                   if (i =3D=3D AMDGPU_IB_POOL_DIRECT)
    >> -                        size =3D PAGE_SIZE * 2;
    >> +                        size =3D PAGE_SIZE * 6;
    >>                   else
    >>                           size =3D AMDGPU_IB_POOL_SIZE;
    >>
    >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
    >> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
    >> index d17e57dea178..77948c033c45 100644
    >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
    >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
    >> @@ -32,6 +32,11 @@
    >>    #include "amdgpu_ras.h"
    >>    #include "amdgpu_gfx.h"
    >>
    >> +#define SE_ID_MAX 8
    >> +#define CU_ID_MAX 16
    >> +#define SIMD_ID_MAX 4
    >> +#define WAVE_ID_MAX 10
    >> +
    >>    enum gfx_v9_4_2_utc_type {
    >>           VML2_MEM,
    >>           VML2_WALKER_MEM,
    >> @@ -81,100 +86,100 @@ static const struct soc15_reg_golden
    >> golden_settings_gc_9_4_2_alde[] =3D {  };
    >>
    >>    static const u32 vgpr_init_compute_shader_aldebaran[] =3D {
    >> -        0xb8840904, 0xb8851a04, 0xb8861344, 0x9207c006, 0x92088405,=
 0x81070807,
    >> -        0x81070407, 0x8e078207, 0xbe88008f, 0xc0410200, 0x00000007,=
 0xd3d94000,
    >> -        0x18000080, 0xd3d94001, 0x18000080, 0xd3d94002, 0x18000080,=
 0xd3d94003,
    >> -        0x18000080, 0xd3d94004, 0x18000080, 0xd3d94005, 0x18000080,=
 0xd3d94006,
    >> -        0x18000080, 0xd3d94007, 0x18000080, 0xd3d94008, 0x18000080,=
 0xd3d94009,
    >> -        0x18000080, 0xd3d9400a, 0x18000080, 0xd3d9400b, 0x18000080,=
 0xd3d9400c,
    >> -        0x18000080, 0xd3d9400d, 0x18000080, 0xd3d9400e, 0x18000080,=
 0xd3d9400f,
    >> -        0x18000080, 0xd3d94010, 0x18000080, 0xd3d94011, 0x18000080,=
 0xd3d94012,
    >> -        0x18000080, 0xd3d94013, 0x18000080, 0xd3d94014, 0x18000080,=
 0xd3d94015,
    >> -        0x18000080, 0xd3d94016, 0x18000080, 0xd3d94017, 0x18000080,=
 0xd3d94018,
    >> -        0x18000080, 0xd3d94019, 0x18000080, 0xd3d9401a, 0x18000080,=
 0xd3d9401b,
    >> -        0x18000080, 0xd3d9401c, 0x18000080, 0xd3d9401d, 0x18000080,=
 0xd3d9401e,
    >> -        0x18000080, 0xd3d9401f, 0x18000080, 0xd3d94020, 0x18000080,=
 0xd3d94021,
    >> -        0x18000080, 0xd3d94022, 0x18000080, 0xd3d94023, 0x18000080,=
 0xd3d94024,
    >> -        0x18000080, 0xd3d94025, 0x18000080, 0xd3d94026, 0x18000080,=
 0xd3d94027,
    >> -        0x18000080, 0xd3d94028, 0x18000080, 0xd3d94029, 0x18000080,=
 0xd3d9402a,
    >> -        0x18000080, 0xd3d9402b, 0x18000080, 0xd3d9402c, 0x18000080,=
 0xd3d9402d,
    >> -        0x18000080, 0xd3d9402e, 0x18000080, 0xd3d9402f, 0x18000080,=
 0xd3d94030,
    >> -        0x18000080, 0xd3d94031, 0x18000080, 0xd3d94032, 0x18000080,=
 0xd3d94033,
    >> -        0x18000080, 0xd3d94034, 0x18000080, 0xd3d94035, 0x18000080,=
 0xd3d94036,
    >> -        0x18000080, 0xd3d94037, 0x18000080, 0xd3d94038, 0x18000080,=
 0xd3d94039,
    >> -        0x18000080, 0xd3d9403a, 0x18000080, 0xd3d9403b, 0x18000080,=
 0xd3d9403c,
    >> -        0x18000080, 0xd3d9403d, 0x18000080, 0xd3d9403e, 0x18000080,=
 0xd3d9403f,
    >> -        0x18000080, 0xd3d94040, 0x18000080, 0xd3d94041, 0x18000080,=
 0xd3d94042,
    >> -        0x18000080, 0xd3d94043, 0x18000080, 0xd3d94044, 0x18000080,=
 0xd3d94045,
    >> -        0x18000080, 0xd3d94046, 0x18000080, 0xd3d94047, 0x18000080,=
 0xd3d94048,
    >> -        0x18000080, 0xd3d94049, 0x18000080, 0xd3d9404a, 0x18000080,=
 0xd3d9404b,
    >> -        0x18000080, 0xd3d9404c, 0x18000080, 0xd3d9404d, 0x18000080,=
 0xd3d9404e,
    >> -        0x18000080, 0xd3d9404f, 0x18000080, 0xd3d94050, 0x18000080,=
 0xd3d94051,
    >> -        0x18000080, 0xd3d94052, 0x18000080, 0xd3d94053, 0x18000080,=
 0xd3d94054,
    >> -        0x18000080, 0xd3d94055, 0x18000080, 0xd3d94056, 0x18000080,=
 0xd3d94057,
    >> -        0x18000080, 0xd3d94058, 0x18000080, 0xd3d94059, 0x18000080,=
 0xd3d9405a,
    >> -        0x18000080, 0xd3d9405b, 0x18000080, 0xd3d9405c, 0x18000080,=
 0xd3d9405d,
    >> -        0x18000080, 0xd3d9405e, 0x18000080, 0xd3d9405f, 0x18000080,=
 0xd3d94060,
    >> -        0x18000080, 0xd3d94061, 0x18000080, 0xd3d94062, 0x18000080,=
 0xd3d94063,
    >> -        0x18000080, 0xd3d94064, 0x18000080, 0xd3d94065, 0x18000080,=
 0xd3d94066,
    >> -        0x18000080, 0xd3d94067, 0x18000080, 0xd3d94068, 0x18000080,=
 0xd3d94069,
    >> -        0x18000080, 0xd3d9406a, 0x18000080, 0xd3d9406b, 0x18000080,=
 0xd3d9406c,
    >> -        0x18000080, 0xd3d9406d, 0x18000080, 0xd3d9406e, 0x18000080,=
 0xd3d9406f,
    >> -        0x18000080, 0xd3d94070, 0x18000080, 0xd3d94071, 0x18000080,=
 0xd3d94072,
    >> -        0x18000080, 0xd3d94073, 0x18000080, 0xd3d94074, 0x18000080,=
 0xd3d94075,
    >> -        0x18000080, 0xd3d94076, 0x18000080, 0xd3d94077, 0x18000080,=
 0xd3d94078,
    >> -        0x18000080, 0xd3d94079, 0x18000080, 0xd3d9407a, 0x18000080,=
 0xd3d9407b,
    >> -        0x18000080, 0xd3d9407c, 0x18000080, 0xd3d9407d, 0x18000080,=
 0xd3d9407e,
    >> -        0x18000080, 0xd3d9407f, 0x18000080, 0xd3d94080, 0x18000080,=
 0xd3d94081,
    >> -        0x18000080, 0xd3d94082, 0x18000080, 0xd3d94083, 0x18000080,=
 0xd3d94084,
    >> -        0x18000080, 0xd3d94085, 0x18000080, 0xd3d94086, 0x18000080,=
 0xd3d94087,
    >> -        0x18000080, 0xd3d94088, 0x18000080, 0xd3d94089, 0x18000080,=
 0xd3d9408a,
    >> -        0x18000080, 0xd3d9408b, 0x18000080, 0xd3d9408c, 0x18000080,=
 0xd3d9408d,
    >> -        0x18000080, 0xd3d9408e, 0x18000080, 0xd3d9408f, 0x18000080,=
 0xd3d94090,
    >> -        0x18000080, 0xd3d94091, 0x18000080, 0xd3d94092, 0x18000080,=
 0xd3d94093,
    >> -        0x18000080, 0xd3d94094, 0x18000080, 0xd3d94095, 0x18000080,=
 0xd3d94096,
    >> -        0x18000080, 0xd3d94097, 0x18000080, 0xd3d94098, 0x18000080,=
 0xd3d94099,
    >> -        0x18000080, 0xd3d9409a, 0x18000080, 0xd3d9409b, 0x18000080,=
 0xd3d9409c,
    >> -        0x18000080, 0xd3d9409d, 0x18000080, 0xd3d9409e, 0x18000080,=
 0xd3d9409f,
    >> -        0x18000080, 0xd3d940a0, 0x18000080, 0xd3d940a1, 0x18000080,=
 0xd3d940a2,
    >> -        0x18000080, 0xd3d940a3, 0x18000080, 0xd3d940a4, 0x18000080,=
 0xd3d940a5,
    >> -        0x18000080, 0xd3d940a6, 0x18000080, 0xd3d940a7, 0x18000080,=
 0xd3d940a8,
    >> -        0x18000080, 0xd3d940a9, 0x18000080, 0xd3d940aa, 0x18000080,=
 0xd3d940ab,
    >> -        0x18000080, 0xd3d940ac, 0x18000080, 0xd3d940ad, 0x18000080,=
 0xd3d940ae,
    >> -        0x18000080, 0xd3d940af, 0x18000080, 0xd3d940b0, 0x18000080,=
 0xd3d940b1,
    >> -        0x18000080, 0xd3d940b2, 0x18000080, 0xd3d940b3, 0x18000080,=
 0xd3d940b4,
    >> -        0x18000080, 0xd3d940b5, 0x18000080, 0xd3d940b6, 0x18000080,=
 0xd3d940b7,
    >> -        0x18000080, 0xd3d940b8, 0x18000080, 0xd3d940b9, 0x18000080,=
 0xd3d940ba,
    >> -        0x18000080, 0xd3d940bb, 0x18000080, 0xd3d940bc, 0x18000080,=
 0xd3d940bd,
    >> -        0x18000080, 0xd3d940be, 0x18000080, 0xd3d940bf, 0x18000080,=
 0xd3d940c0,
    >> -        0x18000080, 0xd3d940c1, 0x18000080, 0xd3d940c2, 0x18000080,=
 0xd3d940c3,
    >> -        0x18000080, 0xd3d940c4, 0x18000080, 0xd3d940c5, 0x18000080,=
 0xd3d940c6,
    >> -        0x18000080, 0xd3d940c7, 0x18000080, 0xd3d940c8, 0x18000080,=
 0xd3d940c9,
    >> -        0x18000080, 0xd3d940ca, 0x18000080, 0xd3d940cb, 0x18000080,=
 0xd3d940cc,
    >> -        0x18000080, 0xd3d940cd, 0x18000080, 0xd3d940ce, 0x18000080,=
 0xd3d940cf,
    >> -        0x18000080, 0xd3d940d0, 0x18000080, 0xd3d940d1, 0x18000080,=
 0xd3d940d2,
    >> -        0x18000080, 0xd3d940d3, 0x18000080, 0xd3d940d4, 0x18000080,=
 0xd3d940d5,
    >> -        0x18000080, 0xd3d940d6, 0x18000080, 0xd3d940d7, 0x18000080,=
 0xd3d940d8,
    >> -        0x18000080, 0xd3d940d9, 0x18000080, 0xd3d940da, 0x18000080,=
 0xd3d940db,
    >> -        0x18000080, 0xd3d940dc, 0x18000080, 0xd3d940dd, 0x18000080,=
 0xd3d940de,
    >> -        0x18000080, 0xd3d940df, 0x18000080, 0xd3d940e0, 0x18000080,=
 0xd3d940e1,
    >> -        0x18000080, 0xd3d940e2, 0x18000080, 0xd3d940e3, 0x18000080,=
 0xd3d940e4,
    >> -        0x18000080, 0xd3d940e5, 0x18000080, 0xd3d940e6, 0x18000080,=
 0xd3d940e7,
    >> -        0x18000080, 0xd3d940e8, 0x18000080, 0xd3d940e9, 0x18000080,=
 0xd3d940ea,
    >> -        0x18000080, 0xd3d940eb, 0x18000080, 0xd3d940ec, 0x18000080,=
 0xd3d940ed,
    >> -        0x18000080, 0xd3d940ee, 0x18000080, 0xd3d940ef, 0x18000080,=
 0xd3d940f0,
    >> -        0x18000080, 0xd3d940f1, 0x18000080, 0xd3d940f2, 0x18000080,=
 0xd3d940f3,
    >> -        0x18000080, 0xd3d940f4, 0x18000080, 0xd3d940f5, 0x18000080,=
 0xd3d940f6,
    >> -        0x18000080, 0xd3d940f7, 0x18000080, 0xd3d940f8, 0x18000080,=
 0xd3d940f9,
    >> -        0x18000080, 0xd3d940fa, 0x18000080, 0xd3d940fb, 0x18000080,=
 0xd3d940fc,
    >> -        0x18000080, 0xd3d940fd, 0x18000080, 0xd3d940fe, 0x18000080,=
 0xd3d940ff,
    >> -        0x18000080, 0xb07c0000, 0xbe8a00ff, 0x000000f8, 0xbf11080a,=
 0x7e000280,
    >> -        0x7e020280, 0x7e040280, 0x7e060280, 0x7e080280, 0x7e0a0280,=
 0x7e0c0280,
    >> -        0x7e0e0280, 0x808a880a, 0xbe80320a, 0xbf84fff5, 0xbf9c0000,=
 0xd28c0001,
    >> -        0x0001007f, 0xd28d0001, 0x0002027e, 0x10020288, 0xb88b0904,=
 0xb78b4000,
    >> -        0xd1196a01, 0x00001701, 0xbe8a0087, 0xbefc00c1, 0xd89c4000,=
 0x00020201,
    >> -        0xd89cc080, 0x00040401, 0x320202ff, 0x00000800, 0x808a810a,=
 0xbf84fff8,
    >> -        0xbf810000,
    >> +        0xb8840904, 0xb8851a04, 0xb8861344, 0xb8831804, 0x9208ff06,=
 0x00000280,
    >> +        0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308,=
 0x8e078208,
    >> +        0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xd3d94000,=
 0x18000080,
    >> +        0xd3d94001, 0x18000080, 0xd3d94002, 0x18000080, 0xd3d94003,=
 0x18000080,
    >> +        0xd3d94004, 0x18000080, 0xd3d94005, 0x18000080, 0xd3d94006,=
 0x18000080,
    >> +        0xd3d94007, 0x18000080, 0xd3d94008, 0x18000080, 0xd3d94009,=
 0x18000080,
    >> +        0xd3d9400a, 0x18000080, 0xd3d9400b, 0x18000080, 0xd3d9400c,=
 0x18000080,
    >> +        0xd3d9400d, 0x18000080, 0xd3d9400e, 0x18000080, 0xd3d9400f,=
 0x18000080,
    >> +        0xd3d94010, 0x18000080, 0xd3d94011, 0x18000080, 0xd3d94012,=
 0x18000080,
    >> +        0xd3d94013, 0x18000080, 0xd3d94014, 0x18000080, 0xd3d94015,=
 0x18000080,
    >> +        0xd3d94016, 0x18000080, 0xd3d94017, 0x18000080, 0xd3d94018,=
 0x18000080,
    >> +        0xd3d94019, 0x18000080, 0xd3d9401a, 0x18000080, 0xd3d9401b,=
 0x18000080,
    >> +        0xd3d9401c, 0x18000080, 0xd3d9401d, 0x18000080, 0xd3d9401e,=
 0x18000080,
    >> +        0xd3d9401f, 0x18000080, 0xd3d94020, 0x18000080, 0xd3d94021,=
 0x18000080,
    >> +        0xd3d94022, 0x18000080, 0xd3d94023, 0x18000080, 0xd3d94024,=
 0x18000080,
    >> +        0xd3d94025, 0x18000080, 0xd3d94026, 0x18000080, 0xd3d94027,=
 0x18000080,
    >> +        0xd3d94028, 0x18000080, 0xd3d94029, 0x18000080, 0xd3d9402a,=
 0x18000080,
    >> +        0xd3d9402b, 0x18000080, 0xd3d9402c, 0x18000080, 0xd3d9402d,=
 0x18000080,
    >> +        0xd3d9402e, 0x18000080, 0xd3d9402f, 0x18000080, 0xd3d94030,=
 0x18000080,
    >> +        0xd3d94031, 0x18000080, 0xd3d94032, 0x18000080, 0xd3d94033,=
 0x18000080,
    >> +        0xd3d94034, 0x18000080, 0xd3d94035, 0x18000080, 0xd3d94036,=
 0x18000080,
    >> +        0xd3d94037, 0x18000080, 0xd3d94038, 0x18000080, 0xd3d94039,=
 0x18000080,
    >> +        0xd3d9403a, 0x18000080, 0xd3d9403b, 0x18000080, 0xd3d9403c,=
 0x18000080,
    >> +        0xd3d9403d, 0x18000080, 0xd3d9403e, 0x18000080, 0xd3d9403f,=
 0x18000080,
    >> +        0xd3d94040, 0x18000080, 0xd3d94041, 0x18000080, 0xd3d94042,=
 0x18000080,
    >> +        0xd3d94043, 0x18000080, 0xd3d94044, 0x18000080, 0xd3d94045,=
 0x18000080,
    >> +        0xd3d94046, 0x18000080, 0xd3d94047, 0x18000080, 0xd3d94048,=
 0x18000080,
    >> +        0xd3d94049, 0x18000080, 0xd3d9404a, 0x18000080, 0xd3d9404b,=
 0x18000080,
    >> +        0xd3d9404c, 0x18000080, 0xd3d9404d, 0x18000080, 0xd3d9404e,=
 0x18000080,
    >> +        0xd3d9404f, 0x18000080, 0xd3d94050, 0x18000080, 0xd3d94051,=
 0x18000080,
    >> +        0xd3d94052, 0x18000080, 0xd3d94053, 0x18000080, 0xd3d94054,=
 0x18000080,
    >> +        0xd3d94055, 0x18000080, 0xd3d94056, 0x18000080, 0xd3d94057,=
 0x18000080,
    >> +        0xd3d94058, 0x18000080, 0xd3d94059, 0x18000080, 0xd3d9405a,=
 0x18000080,
    >> +        0xd3d9405b, 0x18000080, 0xd3d9405c, 0x18000080, 0xd3d9405d,=
 0x18000080,
    >> +        0xd3d9405e, 0x18000080, 0xd3d9405f, 0x18000080, 0xd3d94060,=
 0x18000080,
    >> +        0xd3d94061, 0x18000080, 0xd3d94062, 0x18000080, 0xd3d94063,=
 0x18000080,
    >> +        0xd3d94064, 0x18000080, 0xd3d94065, 0x18000080, 0xd3d94066,=
 0x18000080,
    >> +        0xd3d94067, 0x18000080, 0xd3d94068, 0x18000080, 0xd3d94069,=
 0x18000080,
    >> +        0xd3d9406a, 0x18000080, 0xd3d9406b, 0x18000080, 0xd3d9406c,=
 0x18000080,
    >> +        0xd3d9406d, 0x18000080, 0xd3d9406e, 0x18000080, 0xd3d9406f,=
 0x18000080,
    >> +        0xd3d94070, 0x18000080, 0xd3d94071, 0x18000080, 0xd3d94072,=
 0x18000080,
    >> +        0xd3d94073, 0x18000080, 0xd3d94074, 0x18000080, 0xd3d94075,=
 0x18000080,
    >> +        0xd3d94076, 0x18000080, 0xd3d94077, 0x18000080, 0xd3d94078,=
 0x18000080,
    >> +        0xd3d94079, 0x18000080, 0xd3d9407a, 0x18000080, 0xd3d9407b,=
 0x18000080,
    >> +        0xd3d9407c, 0x18000080, 0xd3d9407d, 0x18000080, 0xd3d9407e,=
 0x18000080,
    >> +        0xd3d9407f, 0x18000080, 0xd3d94080, 0x18000080, 0xd3d94081,=
 0x18000080,
    >> +        0xd3d94082, 0x18000080, 0xd3d94083, 0x18000080, 0xd3d94084,=
 0x18000080,
    >> +        0xd3d94085, 0x18000080, 0xd3d94086, 0x18000080, 0xd3d94087,=
 0x18000080,
    >> +        0xd3d94088, 0x18000080, 0xd3d94089, 0x18000080, 0xd3d9408a,=
 0x18000080,
    >> +        0xd3d9408b, 0x18000080, 0xd3d9408c, 0x18000080, 0xd3d9408d,=
 0x18000080,
    >> +        0xd3d9408e, 0x18000080, 0xd3d9408f, 0x18000080, 0xd3d94090,=
 0x18000080,
    >> +        0xd3d94091, 0x18000080, 0xd3d94092, 0x18000080, 0xd3d94093,=
 0x18000080,
    >> +        0xd3d94094, 0x18000080, 0xd3d94095, 0x18000080, 0xd3d94096,=
 0x18000080,
    >> +        0xd3d94097, 0x18000080, 0xd3d94098, 0x18000080, 0xd3d94099,=
 0x18000080,
    >> +        0xd3d9409a, 0x18000080, 0xd3d9409b, 0x18000080, 0xd3d9409c,=
 0x18000080,
    >> +        0xd3d9409d, 0x18000080, 0xd3d9409e, 0x18000080, 0xd3d9409f,=
 0x18000080,
    >> +        0xd3d940a0, 0x18000080, 0xd3d940a1, 0x18000080, 0xd3d940a2,=
 0x18000080,
    >> +        0xd3d940a3, 0x18000080, 0xd3d940a4, 0x18000080, 0xd3d940a5,=
 0x18000080,
    >> +        0xd3d940a6, 0x18000080, 0xd3d940a7, 0x18000080, 0xd3d940a8,=
 0x18000080,
    >> +        0xd3d940a9, 0x18000080, 0xd3d940aa, 0x18000080, 0xd3d940ab,=
 0x18000080,
    >> +        0xd3d940ac, 0x18000080, 0xd3d940ad, 0x18000080, 0xd3d940ae,=
 0x18000080,
    >> +        0xd3d940af, 0x18000080, 0xd3d940b0, 0x18000080, 0xd3d940b1,=
 0x18000080,
    >> +        0xd3d940b2, 0x18000080, 0xd3d940b3, 0x18000080, 0xd3d940b4,=
 0x18000080,
    >> +        0xd3d940b5, 0x18000080, 0xd3d940b6, 0x18000080, 0xd3d940b7,=
 0x18000080,
    >> +        0xd3d940b8, 0x18000080, 0xd3d940b9, 0x18000080, 0xd3d940ba,=
 0x18000080,
    >> +        0xd3d940bb, 0x18000080, 0xd3d940bc, 0x18000080, 0xd3d940bd,=
 0x18000080,
    >> +        0xd3d940be, 0x18000080, 0xd3d940bf, 0x18000080, 0xd3d940c0,=
 0x18000080,
    >> +        0xd3d940c1, 0x18000080, 0xd3d940c2, 0x18000080, 0xd3d940c3,=
 0x18000080,
    >> +        0xd3d940c4, 0x18000080, 0xd3d940c5, 0x18000080, 0xd3d940c6,=
 0x18000080,
    >> +        0xd3d940c7, 0x18000080, 0xd3d940c8, 0x18000080, 0xd3d940c9,=
 0x18000080,
    >> +        0xd3d940ca, 0x18000080, 0xd3d940cb, 0x18000080, 0xd3d940cc,=
 0x18000080,
    >> +        0xd3d940cd, 0x18000080, 0xd3d940ce, 0x18000080, 0xd3d940cf,=
 0x18000080,
    >> +        0xd3d940d0, 0x18000080, 0xd3d940d1, 0x18000080, 0xd3d940d2,=
 0x18000080,
    >> +        0xd3d940d3, 0x18000080, 0xd3d940d4, 0x18000080, 0xd3d940d5,=
 0x18000080,
    >> +        0xd3d940d6, 0x18000080, 0xd3d940d7, 0x18000080, 0xd3d940d8,=
 0x18000080,
    >> +        0xd3d940d9, 0x18000080, 0xd3d940da, 0x18000080, 0xd3d940db,=
 0x18000080,
    >> +        0xd3d940dc, 0x18000080, 0xd3d940dd, 0x18000080, 0xd3d940de,=
 0x18000080,
    >> +        0xd3d940df, 0x18000080, 0xd3d940e0, 0x18000080, 0xd3d940e1,=
 0x18000080,
    >> +        0xd3d940e2, 0x18000080, 0xd3d940e3, 0x18000080, 0xd3d940e4,=
 0x18000080,
    >> +        0xd3d940e5, 0x18000080, 0xd3d940e6, 0x18000080, 0xd3d940e7,=
 0x18000080,
    >> +        0xd3d940e8, 0x18000080, 0xd3d940e9, 0x18000080, 0xd3d940ea,=
 0x18000080,
    >> +        0xd3d940eb, 0x18000080, 0xd3d940ec, 0x18000080, 0xd3d940ed,=
 0x18000080,
    >> +        0xd3d940ee, 0x18000080, 0xd3d940ef, 0x18000080, 0xd3d940f0,=
 0x18000080,
    >> +        0xd3d940f1, 0x18000080, 0xd3d940f2, 0x18000080, 0xd3d940f3,=
 0x18000080,
    >> +        0xd3d940f4, 0x18000080, 0xd3d940f5, 0x18000080, 0xd3d940f6,=
 0x18000080,
    >> +        0xd3d940f7, 0x18000080, 0xd3d940f8, 0x18000080, 0xd3d940f9,=
 0x18000080,
    >> +        0xd3d940fa, 0x18000080, 0xd3d940fb, 0x18000080, 0xd3d940fc,=
 0x18000080,
    >> +        0xd3d940fd, 0x18000080, 0xd3d940fe, 0x18000080, 0xd3d940ff,=
 0x18000080,
    >> +        0xb07c0000, 0xbe8a00ff, 0x000000f8, 0xbf11080a, 0x7e000280,=
 0x7e020280,
    >> +        0x7e040280, 0x7e060280, 0x7e080280, 0x7e0a0280, 0x7e0c0280,=
 0x7e0e0280,
    >> +        0x808a880a, 0xbe80320a, 0xbf84fff5, 0xbf9c0000, 0xd28c0001,=
 0x0001007f,
    >> +        0xd28d0001, 0x0002027e, 0x10020288, 0xbe8b0004, 0xb78b4000,=
 0xd1196a01,
    >> +        0x00001701, 0xbe8a0087, 0xbefc00c1, 0xd89c4000, 0x00020201,=
 0xd89cc080,
    >> +        0x00040401, 0x320202ff, 0x00000800, 0x808a810a, 0xbf84fff8,
    >> +0xbf810000,
    >>    };
    >>
    >>    const struct soc15_reg_entry vgpr_init_regs_aldebaran[] =3D { @@ =
-183,7 +188,7 @@ const struct soc15_reg_entry vgpr_init_regs_aldebaran[] =
=3D {
    >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 4 },
    >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
    >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0xbf },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x400004 },=
  /* 64KB LDS */
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x400006 },=
  /* 64KB
    >> +LDS */
    >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x3F }, /*=
  63 - accum-offset =3D 256 */
    >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0=
), 0xffffffff },
    >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1=
), 0xffffffff }, @@ -195,262 +200,488 @@ const struct soc15_reg_entry vgpr_=
init_regs_aldebaran[] =3D {
    >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7=
),
    >> 0xffffffff },  };
    >>
    >> -static const u32 sgpr_init_compute_shader_aldebaran[] =3D {
    >> -        0xb8840904, 0xb8851a04, 0xb8861344, 0x9207c006, 0x92088405,=
 0x81070807,
    >> -        0x81070407, 0x8e078207, 0xbefc0006, 0xbf800000, 0xbf900001,=
 0xbe88008f,
    >> -        0xc0410200, 0x00000007, 0xb07c0000, 0xbe8000ff, 0x0000005f,=
 0xbee50080,
    >> -        0xbe812c65, 0xbe822c65, 0xbe832c65, 0xbe842c65, 0xbe852c65,=
 0xb77c0005,
    >> -        0x80808500, 0xbf84fff8, 0xbe800080, 0xbf810000,
    >> +static const u32 sgpr112_init_compute_shader_aldebaran[] =3D {
    >> +        0xb8840904, 0xb8851a04, 0xb8861344, 0xb8831804, 0x9208ff06,=
 0x00000280,
    >> +        0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308,=
 0x8e078208,
    >> +        0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbf8e003f,=
 0xc0030200,
    >> +        0x00000000, 0xbf8c0000, 0xbf06ff08, 0xdeadbeaf, 0xbf84fff9,=
 0x81028102,
    >> +        0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbe880080,=
 0xbe890080,
    >> +        0xbe8a0080, 0xbe8b0080, 0xbe8c0080, 0xbe8d0080, 0xbe8e0080,=
 0xbe8f0080,
    >> +        0xbe900080, 0xbe910080, 0xbe920080, 0xbe930080, 0xbe940080,=
 0xbe950080,
    >> +        0xbe960080, 0xbe970080, 0xbe980080, 0xbe990080, 0xbe9a0080,=
 0xbe9b0080,
    >> +        0xbe9c0080, 0xbe9d0080, 0xbe9e0080, 0xbe9f0080, 0xbea00080,=
 0xbea10080,
    >> +        0xbea20080, 0xbea30080, 0xbea40080, 0xbea50080, 0xbea60080,=
 0xbea70080,
    >> +        0xbea80080, 0xbea90080, 0xbeaa0080, 0xbeab0080, 0xbeac0080,=
 0xbead0080,
    >> +        0xbeae0080, 0xbeaf0080, 0xbeb00080, 0xbeb10080, 0xbeb20080,=
 0xbeb30080,
    >> +        0xbeb40080, 0xbeb50080, 0xbeb60080, 0xbeb70080, 0xbeb80080,=
 0xbeb90080,
    >> +        0xbeba0080, 0xbebb0080, 0xbebc0080, 0xbebd0080, 0xbebe0080,=
 0xbebf0080,
    >> +        0xbec00080, 0xbec10080, 0xbec20080, 0xbec30080, 0xbec40080,=
 0xbec50080,
    >> +        0xbec60080, 0xbec70080, 0xbec80080, 0xbec90080, 0xbeca0080,=
 0xbecb0080,
    >> +        0xbecc0080, 0xbecd0080, 0xbece0080, 0xbecf0080, 0xbed00080,=
 0xbed10080,
    >> +        0xbed20080, 0xbed30080, 0xbed40080, 0xbed50080, 0xbed60080,=
 0xbed70080,
    >> +        0xbed80080, 0xbed90080, 0xbeda0080, 0xbedb0080, 0xbedc0080,=
 0xbedd0080,
    >> +        0xbede0080, 0xbedf0080, 0xbee00080, 0xbee10080, 0xbee20080,=
 0xbee30080,
    >> +        0xbee40080, 0xbee50080, 0xbf810000
    >>    };
    >>
    >> -static const struct soc15_reg_entry sgpr1_init_regs_aldebaran[] =3D=
 {
    >> +const struct soc15_reg_entry sgpr112_init_regs_aldebaran[] =3D {
    >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 0x00=
00000 },
    >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
    >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 8 },
    >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x240 }, /*=
 (80 GPRS): SGPRS[9:6] VGPRS[5:0] */
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x4 }, /* U=
SER_SGPR[5:1]*/
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x3F }, /* =
 63 - accum-offset =3D 256 */
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0)=
, 0x000000ff },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1)=
, 0x000000ff },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2)=
, 0x000000ff },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3)=
, 0x000000ff },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4)=
, 0x000000ff },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5)=
, 0x000000ff },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6)=
, 0x000000ff },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7)=
, 0x000000ff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x2c0 },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x6 },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x0 },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7)=
,
    >> +0xffffffff }, };
    >> +
    >> +static const u32 sgpr96_init_compute_shader_aldebaran[] =3D {
    >> +        0xb8840904, 0xb8851a04, 0xb8861344, 0xb8831804, 0x9208ff06,=
 0x00000280,
    >> +        0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308,=
 0x8e078208,
    >> +        0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbf8e003f,=
 0xc0030200,
    >> +        0x00000000, 0xbf8c0000, 0xbf06ff08, 0xdeadbeaf, 0xbf84fff9,=
 0x81028102,
    >> +        0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbe880080,=
 0xbe890080,
    >> +        0xbe8a0080, 0xbe8b0080, 0xbe8c0080, 0xbe8d0080, 0xbe8e0080,=
 0xbe8f0080,
    >> +        0xbe900080, 0xbe910080, 0xbe920080, 0xbe930080, 0xbe940080,=
 0xbe950080,
    >> +        0xbe960080, 0xbe970080, 0xbe980080, 0xbe990080, 0xbe9a0080,=
 0xbe9b0080,
    >> +        0xbe9c0080, 0xbe9d0080, 0xbe9e0080, 0xbe9f0080, 0xbea00080,=
 0xbea10080,
    >> +        0xbea20080, 0xbea30080, 0xbea40080, 0xbea50080, 0xbea60080,=
 0xbea70080,
    >> +        0xbea80080, 0xbea90080, 0xbeaa0080, 0xbeab0080, 0xbeac0080,=
 0xbead0080,
    >> +        0xbeae0080, 0xbeaf0080, 0xbeb00080, 0xbeb10080, 0xbeb20080,=
 0xbeb30080,
    >> +        0xbeb40080, 0xbeb50080, 0xbeb60080, 0xbeb70080, 0xbeb80080,=
 0xbeb90080,
    >> +        0xbeba0080, 0xbebb0080, 0xbebc0080, 0xbebd0080, 0xbebe0080,=
 0xbebf0080,
    >> +        0xbec00080, 0xbec10080, 0xbec20080, 0xbec30080, 0xbec40080,=
 0xbec50080,
    >> +        0xbec60080, 0xbec70080, 0xbec80080, 0xbec90080, 0xbeca0080,=
 0xbecb0080,
    >> +        0xbecc0080, 0xbecd0080, 0xbece0080, 0xbecf0080, 0xbed00080,=
 0xbed10080,
    >> +        0xbed20080, 0xbed30080, 0xbed40080, 0xbed50080, 0xbed60080,=
 0xbed70080,
    >> +        0xbed80080, 0xbed90080, 0xbf810000,
    >>    };
    >>
    >> -static const struct soc15_reg_entry sgpr2_init_regs_aldebaran[] =3D=
 {
    >> +const struct soc15_reg_entry sgpr96_init_regs_aldebaran[] =3D {
    >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 0x00=
00000 },
    >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 8 },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 0xc },
    >>           { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x240 }, /*=
 (80 GPRS) */
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x4 }, /* U=
SER_SGPR[5:1]*/
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x3F }, /* =
 63 - accum-offset =3D 256 */
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0)=
, 0x0000ff00 },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1)=
, 0x0000ff00 },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2)=
, 0x0000ff00 },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3)=
, 0x0000ff00 },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4)=
, 0x0000ff00 },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5)=
, 0x0000ff00 },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6)=
, 0x0000ff00 },
    >> -        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7)=
, 0x0000ff00 },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x240 },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x6 },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x0 },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7)=
,
    >> +0xffffffff },
    >>    };
    >>
    >> -static int gfx_v9_4_2_check_gprs_init_coverage(struct amdgpu_device=
 *adev,
    >> -                                               uint32_t *wb)
    >> -{
    >> -        uint32_t se_id, cu_id, simd_id;
    >> -        uint32_t simd_cnt =3D 0;
    >> -        uint32_t se_offset, cu_offset, data;
    >> -
    >> -        for (se_id =3D 0; se_id < adev->gfx.config.max_shader_engin=
es; se_id++) {
    >> -                se_offset =3D se_id * 16 * 4;
    >> -                for (cu_id =3D 0; cu_id < 16; cu_id++) {
    >> -                        cu_offset =3D cu_id * 4;
    >> -                        for (simd_id =3D 0; simd_id < 4; simd_id++)=
 {
    >> -                                data =3D wb[se_offset + cu_offset +=
 simd_id];
    >> -                                if (data =3D=3D 0xF)
    >> -                                        simd_cnt++;
    >> -                        }
    >> -                }
    >> -        }
    >> -
    >> -        if (adev->gfx.cu_info.number * 4 =3D=3D simd_cnt)
    >> -                return 0;
    >> -
    >> -        dev_warn(adev->dev, "SIMD Count: %d, %d\n",
    >> -                 adev->gfx.cu_info.number * 4, simd_cnt);
    >> -
    >> -        for (se_id =3D 0; se_id < adev->gfx.config.max_shader_engin=
es; se_id++) {
    >> -                se_offset =3D se_id * 16 * 4;
    >> -                for (cu_id =3D 0; cu_id < 16; cu_id++) {
    >> -                        cu_offset =3D cu_id * 4;
    >> -                        for (simd_id =3D 0; simd_id < 4; simd_id++)=
 {
    >> -                                data =3D wb[se_offset + cu_offset +=
 simd_id];
    >> -                                if (data !=3D 0xF)
    >> -                                        dev_warn(adev->dev, "SE[%d]=
CU[%d]SIMD[%d]: isn't inited\n",
    >> -                                                se_id, cu_id, simd_=
id);
    >> -                        }
    >> -                }
    >> -        }
    >> +static const u32 sgpr64_init_compute_shader_aldebaran[] =3D {
    >> +        0xb8840904, 0xb8851a04, 0xb8861344, 0xb8831804, 0x9208ff06,=
 0x00000280,
    >> +        0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308,=
 0x8e078208,
    >> +        0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080,=
 0xbe880080,
    >> +        0xbe890080, 0xbe8a0080, 0xbe8b0080, 0xbe8c0080, 0xbe8d0080,=
 0xbe8e0080,
    >> +        0xbe8f0080, 0xbe900080, 0xbe910080, 0xbe920080, 0xbe930080,=
 0xbe940080,
    >> +        0xbe950080, 0xbe960080, 0xbe970080, 0xbe980080, 0xbe990080,=
 0xbe9a0080,
    >> +        0xbe9b0080, 0xbe9c0080, 0xbe9d0080, 0xbe9e0080, 0xbe9f0080,=
 0xbea00080,
    >> +        0xbea10080, 0xbea20080, 0xbea30080, 0xbea40080, 0xbea50080,=
 0xbea60080,
    >> +        0xbea70080, 0xbea80080, 0xbea90080, 0xbeaa0080, 0xbeab0080,=
 0xbeac0080,
    >> +        0xbead0080, 0xbeae0080, 0xbeaf0080, 0xbeb00080, 0xbeb10080,=
 0xbeb20080,
    >> +        0xbeb30080, 0xbeb40080, 0xbeb50080, 0xbeb60080, 0xbeb70080,=
 0xbeb80080,
    >> +        0xbeb90080, 0xbf810000,
    >> +};
    >>
    >> -        return -EFAULT;
    >> -}
    >> +const struct soc15_reg_entry sgpr64_init_regs_aldebaran[] =3D {
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 0x000=
0000 },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 0x10 },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x1c0 },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x6 },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x0 },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6)=
, 0xffffffff },
    >> +        { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7)=
,
    >> +0xffffffff }, };
    >>
    >>    static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
    >> -                                 const uint32_t *shader_ptr, uint32=
_t shader_size,
    >> -                                 const struct soc15_reg_entry *init=
_regs, uint32_t regs_size,
    >> -                                 uint32_t compute_dim_x, u64 wb_gpu=
_addr)
    >> +                                 struct amdgpu_ring *ring,
    >> +                                 struct amdgpu_ib *ib,
    >> +                                 const u32 *shader_ptr, u32 shader_=
size,
    >> +                                 const struct soc15_reg_entry *init=
_regs, u32 regs_size,
    >> +                                 u32 compute_dim_x, u64 wb_gpu_addr=
, u32 pattern,
    >> +                                 struct dma_fence **fence_ptr)
    >>    {
    >> -        struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[0];
    >> -        struct amdgpu_ib ib;
    >> -        struct dma_fence *f =3D NULL;
    >>           int r, i;
    >>           uint32_t total_size, shader_offset;
    >>           u64 gpu_addr;
    >>
    >> -        total_size =3D (regs_size * 3 + 4 + 4 + 5 + 2) * 4;
    >> +        total_size =3D (regs_size * 3 + 4 + 5 + 5) * 4;
    >>           total_size =3D ALIGN(total_size, 256);
    >>           shader_offset =3D total_size;
    >>           total_size +=3D ALIGN(shader_size, 256);
    >>
    >>           /* allocate an indirect buffer to put the commands in */
    >> -        memset(&ib, 0, sizeof(ib));
    >> +        memset(ib, 0, sizeof(*ib));
    >>           r =3D amdgpu_ib_get(adev, NULL, total_size,
    >> -                                        AMDGPU_IB_POOL_DIRECT, &ib)=
;
    >> +                                        AMDGPU_IB_POOL_DIRECT, ib);
    >>           if (r) {
    >> -                DRM_ERROR("amdgpu: failed to get ib (%d).\n", r);
    >> +                dev_err(adev->dev, "failed to get ib (%d).\n", r);
    >>                   return r;
    >>           }
    >>
    >>           /* load the compute shaders */
    >>           for (i =3D 0; i < shader_size/sizeof(u32); i++)
    >> -                ib.ptr[i + (shader_offset / 4)] =3D shader_ptr[i];
    >> +                ib->ptr[i + (shader_offset / 4)] =3D shader_ptr[i];
    >>
    >>           /* init the ib length to 0 */
    >> -        ib.length_dw =3D 0;
    >> +        ib->length_dw =3D 0;
    >>
    >>           /* write the register state for the compute dispatch */
    >>           for (i =3D 0; i < regs_size; i++) {
    >> -                ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_SET_SH_R=
EG, 1);
    >> -                ib.ptr[ib.length_dw++] =3D SOC15_REG_ENTRY_OFFSET(i=
nit_regs[i])
    >> +                ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_SET_SH=
_REG, 1);
    >> +                ib->ptr[ib->length_dw++] =3D SOC15_REG_ENTRY_OFFSET=
(init_regs[i])
    >>                                                                   - =
PACKET3_SET_SH_REG_START;
    >> -                ib.ptr[ib.length_dw++] =3D init_regs[i].reg_value;
    >> +                ib->ptr[ib->length_dw++] =3D init_regs[i].reg_value=
;
    >>           }
    >>
    >>           /* write the shader start address: mmCOMPUTE_PGM_LO, mmCOM=
PUTE_PGM_HI */
    >> -        gpu_addr =3D (ib.gpu_addr + (u64)shader_offset) >> 8;
    >> -        ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2);
    >> -        ib.ptr[ib.length_dw++] =3D SOC15_REG_OFFSET(GC, 0, regCOMPU=
TE_PGM_LO)
    >> +        gpu_addr =3D (ib->gpu_addr + (u64)shader_offset) >> 8;
    >> +        ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2)=
;
    >> +        ib->ptr[ib->length_dw++] =3D SOC15_REG_OFFSET(GC, 0,
    >> +regCOMPUTE_PGM_LO)
    >>                                                           - PACKET3_=
SET_SH_REG_START;
    >> -        ib.ptr[ib.length_dw++] =3D lower_32_bits(gpu_addr);
    >> -        ib.ptr[ib.length_dw++] =3D upper_32_bits(gpu_addr);
    >> +        ib->ptr[ib->length_dw++] =3D lower_32_bits(gpu_addr);
    >> +        ib->ptr[ib->length_dw++] =3D upper_32_bits(gpu_addr);
    >>
    >>           /* write the wb buffer address */
    >> -        ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2);
    >> -        ib.ptr[ib.length_dw++] =3D SOC15_REG_OFFSET(GC, 0, regCOMPU=
TE_USER_DATA_0)
    >> +        ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 3)=
;
    >> +        ib->ptr[ib->length_dw++] =3D SOC15_REG_OFFSET(GC, 0,
    >> +regCOMPUTE_USER_DATA_0)
    >>                                                           - PACKET3_=
SET_SH_REG_START;
    >> -        ib.ptr[ib.length_dw++] =3D lower_32_bits(wb_gpu_addr);
    >> -        ib.ptr[ib.length_dw++] =3D upper_32_bits(wb_gpu_addr);
    >> +        ib->ptr[ib->length_dw++] =3D lower_32_bits(wb_gpu_addr);
    >> +        ib->ptr[ib->length_dw++] =3D upper_32_bits(wb_gpu_addr);
    >> +        ib->ptr[ib->length_dw++] =3D pattern;
    >>
    >>           /* write dispatch packet */
    >> -        ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_DISPATCH_DIRECT,=
 3);
    >> -        ib.ptr[ib.length_dw++] =3D compute_dim_x; /* x */
    >> -        ib.ptr[ib.length_dw++] =3D 1; /* y */
    >> -        ib.ptr[ib.length_dw++] =3D 1; /* z */
    >> -        ib.ptr[ib.length_dw++] =3D
    >> +        ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_DISPATCH_DIREC=
T, 3);
    >> +        ib->ptr[ib->length_dw++] =3D compute_dim_x; /* x */
    >> +        ib->ptr[ib->length_dw++] =3D 1; /* y */
    >> +        ib->ptr[ib->length_dw++] =3D 1; /* z */
    >> +        ib->ptr[ib->length_dw++] =3D
    >>                   REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPU=
TE_SHADER_EN,
    >> 1);
    >>
    >> -        /* write CS partial flush packet */
    >> -        ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_EVENT_WRITE, 0);
    >> -        ib.ptr[ib.length_dw++] =3D EVENT_TYPE(7) | EVENT_INDEX(4);
    >> -
    >>           /* shedule the ib on the ring */
    >> -        r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
    >> +        r =3D amdgpu_ib_schedule(ring, 1, ib, NULL, fence_ptr);
    >>           if (r) {
    >> -                DRM_ERROR("amdgpu: ib submit failed (%d).\n", r);
    >> -                goto fail;
    >> +                dev_err(adev->dev, "ib submit failed (%d).\n", r);
    >> +                amdgpu_ib_free(adev, ib, NULL);
    >>           }
    >> +        return r;
    >> +}
    >>
    >> -        /* wait for the GPU to finish processing the IB */
    >> -        r =3D dma_fence_wait(f, false);
    >> -        if (r) {
    >> -                DRM_ERROR("amdgpu: fence wait failed (%d).\n", r);
    >> -                goto fail;
    >> +static void gfx_v9_4_2_log_wave_assignment(struct amdgpu_device
    >> +*adev, uint32_t *wb_ptr) {
    >> +        uint32_t se, cu, simd, wave;
    >> +        uint32_t offset =3D 0;
    >> +        char *str;
    >> +        int size;
    >> +
    >> +        str =3D kmalloc(256, GFP_KERNEL);
    >> +        if (!str)
    >> +                return;
    >> +
    >> +        dev_dbg(adev->dev, "wave assignment:\n");
    >> +
    >> +        for (se =3D 0; se < adev->gfx.config.max_shader_engines; se=
++) {
    >> +                for (cu =3D 0; cu < CU_ID_MAX; cu++) {
    >> +                        memset(str, 0, 256);
    >> +                        size =3D sprintf(str, "SE[%02d]CU[%02d]: ",=
 se, cu);
    >> +                        for (simd =3D 0; simd < SIMD_ID_MAX; simd++=
) {
    >> +                                size +=3D sprintf(str + size, "[");
    >> +                                for (wave =3D 0; wave < WAVE_ID_MAX=
; wave++) {
    >> +                                        size +=3D sprintf(str + siz=
e, "%x", wb_ptr[offset]);
    >> +                                        offset++;
    >> +                                }
    >> +                                size +=3D sprintf(str + size, "]  "=
);
    >> +                        }
    >> +                        dev_dbg(adev->dev, "%s\n", str);
    >> +                }
    >>           }
    >> -fail:
    >> -        amdgpu_ib_free(adev, &ib, NULL);
    >> -        dma_fence_put(f);
    >>
    >> -        return r;
    >> +        kfree(str);
    >>    }
    >>
    >> -int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev)
    >> +static int gfx_v9_4_2_wait_for_waves_assigned(struct amdgpu_device =
*adev,
    >> +                                              uint32_t *wb_ptr, uin=
t32_t mask,
    >> +                                              uint32_t pattern, uin=
t32_t num_wave, bool wait)
    >>    {
    >> -        struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[0];
    >> -        int r;
    >> -        int compute_dim_x =3D adev->gfx.config.max_shader_engines *
    >> -                            adev->gfx.config.max_cu_per_sh *
    >> -                            adev->gfx.config.max_sh_per_se;
    >> -        int sgpr_work_group_size =3D 5;
    >> -        /* CU_ID: 0~15, SIMD_ID: 0~3 */
    >> -        int wb_size =3D adev->gfx.config.max_shader_engines * 16 * =
4;
    >> -        struct amdgpu_ib ib;
    >> +        uint32_t se, cu, simd, wave;
    >> +        uint32_t loop =3D 0;
    >> +        uint32_t wave_cnt;
    >> +        uint32_t offset;
    >>
    >> -        /* only support when RAS is enabled */
    >> -        if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
    >> -                return 0;
    >> +        do {
    >> +                wave_cnt =3D 0;
    >> +                offset =3D 0;
    >> +
    >> +                for (se =3D 0; se < adev->gfx.config.max_shader_eng=
ines; se++)
    >> +                        for (cu =3D 0; cu < CU_ID_MAX; cu++)
    >> +                                for (simd =3D 0; simd < SIMD_ID_MAX=
; simd++)
    >> +                                        for (wave =3D 0; wave < WAV=
E_ID_MAX; wave++) {
    >> +                                                if (((1 << wave) & =
mask) &&
    >> +                                                    (wb_ptr[offset]=
 =3D=3D pattern))
    >> +                                                        wave_cnt++;
    >> +
    >> +                                                offset++;
    >> +                                        }
    >> +
    >> +                if (wave_cnt =3D=3D num_wave)
    >> +                        return 0;
    >> +
    >> +                mdelay(1);
    >> +        } while (++loop < 2000 && wait);
    >> +
    >> +        dev_err(adev->dev, "actual wave num: %d, expected wave num:=
 %d\n",
    >> +                wave_cnt, num_wave);
    >> +
    >> +        gfx_v9_4_2_log_wave_assignment(adev, wb_ptr);
    >> +
    >> +        return -EBADSLT;
    >> +}
    >> +
    >> +static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev) {
    >> +        int r;
    >> +        int wb_size =3D adev->gfx.config.max_shader_engines *
    >> +                         CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
    >> +        struct amdgpu_ib wb_ib;
    >> +        struct amdgpu_ib disp_ibs[3];
    >> +        struct dma_fence *fences[3];
    >> +        u32 pattern[3] =3D { 0x1, 0x5, 0xa };
    >>
    >>           /* bail if the compute ring is not ready */
    >> -        if (!ring->sched.ready)
    >> +        if (!adev->gfx.compute_ring[0].sched.ready ||
    >> +                 !adev->gfx.compute_ring[1].sched.ready)
    >>                   return 0;
    >>
    >> -        /* allocate an indirect buffer to put the commands in */
    >> -        memset(&ib, 0, sizeof(ib));
    >> -        r =3D amdgpu_ib_get(adev, NULL, wb_size * sizeof(uint32_t),
    >> -                          AMDGPU_IB_POOL_DIRECT, &ib);
    >> +        /* allocate the write-back buffer from IB */
    >> +        memset(&wb_ib, 0, sizeof(wb_ib));
    >> +        r =3D amdgpu_ib_get(adev, NULL, (1 + wb_size) * sizeof(uint=
32_t),
    >> +                          AMDGPU_IB_POOL_DIRECT, &wb_ib);
    >>           if (r) {
    >> -                DRM_ERROR("amdgpu: failed to get ib (%d).\n", r);
    >> +                dev_err(adev->dev, "failed to get ib (%d) for wb\n"=
, r);
    >>                   return r;
    >>           }
    >> +        memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
    >> +
    >> +        r =3D gfx_v9_4_2_run_shader(adev,
    >> +                        &adev->gfx.compute_ring[0],
    >> +                        &disp_ibs[0],
    >> +                        sgpr112_init_compute_shader_aldebaran,
    >> +                        sizeof(sgpr112_init_compute_shader_aldebara=
n),
    >> +                        sgpr112_init_regs_aldebaran,
    >> +                        ARRAY_SIZE(sgpr112_init_regs_aldebaran),
    >> +                        adev->gfx.cu_info.number,
    >> +                        wb_ib.gpu_addr, pattern[0], &fences[0]);
    >> +        if (r) {
    >> +                dev_err(adev->dev, "failed to clear first 224 sgprs=
\n");
    >> +                goto pro_end;
    >> +        }
    >>
    >> -        memset(ib.ptr, 0, wb_size * sizeof(uint32_t));
    >> -        r =3D gfx_v9_4_2_run_shader(adev, vgpr_init_compute_shader_=
aldebaran,
    >> -                                  sizeof(vgpr_init_compute_shader_a=
ldebaran),
    >> -                                  vgpr_init_regs_aldebaran,
    >> -                                  ARRAY_SIZE(vgpr_init_regs_aldebar=
an),
    >> -                                  compute_dim_x * 2, ib.gpu_addr);
    >> +        r =3D gfx_v9_4_2_wait_for_waves_assigned(adev,
    >> +                        &wb_ib.ptr[1], 0b11,
    >> +                        pattern[0],
    >> +                        adev->gfx.cu_info.number * SIMD_ID_MAX * 2,
    >> +                        true);
    >>           if (r) {
    >> -                dev_err(adev->dev, "Init VGPRS: failed to run shade=
r\n");
    >> -                goto failed;
    >> +                dev_err(adev->dev, "wave coverage failed when clear=
 first 224 sgprs\n");
    >> +                wb_ib.ptr[0] =3D 0xdeadbeaf; /* stop waves */
    >> +                goto disp0_failed;
    >>           }
    >>
    >> -        r =3D gfx_v9_4_2_check_gprs_init_coverage(adev, ib.ptr);
    >> +        r =3D gfx_v9_4_2_run_shader(adev,
    >> +                        &adev->gfx.compute_ring[1],
    >> +                        &disp_ibs[1],
    >> +                        sgpr96_init_compute_shader_aldebaran,
    >> +                        sizeof(sgpr96_init_compute_shader_aldebaran=
),
    >> +                        sgpr96_init_regs_aldebaran,
    >> +                        ARRAY_SIZE(sgpr96_init_regs_aldebaran),
    >> +                        adev->gfx.cu_info.number * 2,
    >> +                        wb_ib.gpu_addr, pattern[1], &fences[1]);
    >>           if (r) {
    >> -                dev_err(adev->dev, "Init VGPRS: failed to cover all=
 SIMDs\n");
    >> -                goto failed;
    >> -        } else {
    >> -                dev_info(adev->dev, "Init VGPRS Successfully\n");
    >> +                dev_err(adev->dev, "failed to clear next 576 sgprs\=
n");
    >> +                goto disp0_failed;
    >> +        }
    >> +
    >> +        r =3D gfx_v9_4_2_wait_for_waves_assigned(adev,
    >> +                        &wb_ib.ptr[1], 0b11111100,
    >> +                        pattern[1], adev->gfx.cu_info.number * SIMD=
_ID_MAX * 6,
    >> +                        true);
    >> +        if (r) {
    >> +                dev_err(adev->dev, "wave coverage failed when clear=
 first 576 sgprs\n");
    >> +                wb_ib.ptr[0] =3D 0xdeadbeaf; /* stop waves */
    >> +                goto disp1_failed;
    >>           }
    >>
    >> -        memset(ib.ptr, 0, wb_size * sizeof(uint32_t));
    >> -        r =3D gfx_v9_4_2_run_shader(adev, sgpr_init_compute_shader_=
aldebaran,
    >> -                                  sizeof(sgpr_init_compute_shader_a=
ldebaran),
    >> -                                  sgpr1_init_regs_aldebaran,
    >> -                                  ARRAY_SIZE(sgpr1_init_regs_aldeba=
ran),
    >> -                                  compute_dim_x / 2 * sgpr_work_gro=
up_size,
    >> -                                  ib.gpu_addr);
    >> +        wb_ib.ptr[0] =3D 0xdeadbeaf; /* stop waves */
    >> +
    >> +        /* wait for the GPU to finish processing the IB */
    >> +        r =3D dma_fence_wait(fences[0], false);
    >>           if (r) {
    >> -                dev_err(adev->dev, "Init SGPRS Part1: failed to run=
 shader\n");
    >> -                goto failed;
    >> +                dev_err(adev->dev, "timeout to clear first 224 sgpr=
s\n");
    >> +                goto disp1_failed;
    >>           }
    >>
    >> -        r =3D gfx_v9_4_2_run_shader(adev, sgpr_init_compute_shader_=
aldebaran,
    >> -                                  sizeof(sgpr_init_compute_shader_a=
ldebaran),
    >> -                                  sgpr2_init_regs_aldebaran,
    >> -                                  ARRAY_SIZE(sgpr2_init_regs_aldeba=
ran),
    >> -                                  compute_dim_x / 2 * sgpr_work_gro=
up_size,
    >> -                                  ib.gpu_addr);
    >> +        r =3D dma_fence_wait(fences[1], false);
    >>           if (r) {
    >> -                dev_err(adev->dev, "Init SGPRS Part2: failed to run=
 shader\n");
    >> -                goto failed;
    >> +                dev_err(adev->dev, "timeout to clear first 576 sgpr=
s\n");
    >> +                goto disp1_failed;
    >>           }
    >>
    >> -        r =3D gfx_v9_4_2_check_gprs_init_coverage(adev, ib.ptr);
    >> +        memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
    >> +        r =3D gfx_v9_4_2_run_shader(adev,
    >> +                        &adev->gfx.compute_ring[0],
    >> +                        &disp_ibs[2],
    >> +                        sgpr64_init_compute_shader_aldebaran,
    >> +                        sizeof(sgpr64_init_compute_shader_aldebaran=
),
    >> +                        sgpr64_init_regs_aldebaran,
    >> +                        ARRAY_SIZE(sgpr64_init_regs_aldebaran),
    >> +                        adev->gfx.cu_info.number,
    >> +                        wb_ib.gpu_addr, pattern[2], &fences[2]);
    >> +        if (r) {
    >> +                dev_err(adev->dev, "failed to clear first 256 sgprs=
\n");
    >> +                goto disp1_failed;
    >> +        }
    >> +
    >> +        r =3D dma_fence_wait(fences[2], false);
    >> +        if (r) {
    >> +                dev_err(adev->dev, "timeout to clear first 256 sgpr=
s\n");
    >> +                goto disp2_failed;
    >> +        }
    >> +
    >> +        r =3D gfx_v9_4_2_wait_for_waves_assigned(adev,
    >> +                        &wb_ib.ptr[1], 0b1111,
    >> +                        pattern[2],
    >> +                        adev->gfx.cu_info.number * SIMD_ID_MAX * 4,
    >> +                        false);
    >> +        if (r) {
    >> +                dev_err(adev->dev, "wave coverage failed when clear=
 first 256 sgprs\n");
    >> +                goto disp2_failed;
    >> +        }
    >> +
    >> +disp2_failed:
    >> +        amdgpu_ib_free(adev, &disp_ibs[2], NULL);
    >> +        dma_fence_put(fences[2]);
    >> +disp1_failed:
    >> +        amdgpu_ib_free(adev, &disp_ibs[1], NULL);
    >> +        dma_fence_put(fences[1]);
    >> +disp0_failed:
    >> +        amdgpu_ib_free(adev, &disp_ibs[0], NULL);
    >> +        dma_fence_put(fences[0]);
    >> +pro_end:
    >> +        amdgpu_ib_free(adev, &wb_ib, NULL);
    >> +
    >>           if (r)
    >> -                dev_err(adev->dev,
    >> -                        "Init SGPRS: failed to cover all SIMDs\n");
    >> +                dev_info(adev->dev, "Init SGPRS Failed\n");
    >>           else
    >>                   dev_info(adev->dev, "Init SGPRS Successfully\n");
    >>
    >> -failed:
    >> -        amdgpu_ib_free(adev, &ib, NULL);
    >>           return r;
    >>    }
    >>
    >> +static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev) {
    >> +        int r;
    >> +        /* CU_ID: 0~15, SIMD_ID: 0~3, WAVE_ID: 0 ~ 9 */
    >> +        int wb_size =3D adev->gfx.config.max_shader_engines *
    >> +                         CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
    >> +        struct amdgpu_ib wb_ib;
    >> +        struct amdgpu_ib disp_ib;
    >> +        struct dma_fence *fence;
    >> +        u32 pattern =3D 0xa;
    >> +
    >> +        /* bail if the compute ring is not ready */
    >> +        if (!adev->gfx.compute_ring[0].sched.ready)
    >> +                return 0;
    >> +
    >> +        /* allocate the write-back buffer from IB */
    >> +        memset(&wb_ib, 0, sizeof(wb_ib));
    >> +        r =3D amdgpu_ib_get(adev, NULL, (1 + wb_size) * sizeof(uint=
32_t),
    >> +                          AMDGPU_IB_POOL_DIRECT, &wb_ib);
    >> +        if (r) {
    >> +                dev_err(adev->dev, "failed to get ib (%d) for wb.\n=
", r);
    >> +                return r;
    >> +        }
    >> +        memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
    >> +
    >> +        r =3D gfx_v9_4_2_run_shader(adev,
    >> +                        &adev->gfx.compute_ring[0],
    >> +                        &disp_ib,
    >> +                        vgpr_init_compute_shader_aldebaran,
    >> +                        sizeof(vgpr_init_compute_shader_aldebaran),
    >> +                        vgpr_init_regs_aldebaran,
    >> +                        ARRAY_SIZE(vgpr_init_regs_aldebaran),
    >> +                        adev->gfx.cu_info.number,
    >> +                        wb_ib.gpu_addr, pattern, &fence);
    >> +        if (r) {
    >> +                dev_err(adev->dev, "failed to clear vgprs\n");
    >> +                goto pro_end;
    >> +        }
    >> +
    >> +        /* wait for the GPU to finish processing the IB */
    >> +        r =3D dma_fence_wait(fence, false);
    >> +        if (r) {
    >> +                dev_err(adev->dev, "timeout to clear vgprs\n");
    >> +                goto disp_failed;
    >> +        }
    >> +
    >> +        r =3D gfx_v9_4_2_wait_for_waves_assigned(adev,
    >> +                        &wb_ib.ptr[1], 0b1,
    >> +                        pattern,
    >> +                        adev->gfx.cu_info.number * SIMD_ID_MAX,
    >> +                        false);
    >> +        if (r) {
    >> +                dev_err(adev->dev, "failed to cover all simds when =
clearing vgprs\n");
    >> +                goto disp_failed;
    >> +        }
    >> +
    >> +disp_failed:
    >> +        amdgpu_ib_free(adev, &disp_ib, NULL);
    >> +        dma_fence_put(fence);
    >> +pro_end:
    >> +        amdgpu_ib_free(adev, &wb_ib, NULL);
    >> +
    >> +        if (r)
    >> +                dev_info(adev->dev, "Init VGPRS Failed\n");
    >> +        else
    >> +                dev_info(adev->dev, "Init VGPRS Successfully\n");
    >> +
    >> +        return r;
    >> +}
    >> +
    >> +int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev) {
    >> +        /* only support when RAS is enabled */
    >> +        if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
    >> +                return 0;
    >> +
    >> +        gfx_v9_4_2_do_sgprs_init(adev);
    >> +
    >> +        gfx_v9_4_2_do_vgprs_init(adev);
    >> +
    >> +        return 0;
    >> +}
    >> +
    >>    static void gfx_v9_4_2_query_sq_timeout_status(struct amdgpu_devi=
ce
    >> *adev);  static void gfx_v9_4_2_reset_sq_timeout_status(struct
    >> amdgpu_device *adev);
    >>
    >> @@ -479,8 +710,6 @@ void gfx_v9_4_2_init_golden_registers(struct amd=
gpu_device *adev,
    >>                            die_id);
    >>                   break;
    >>           }
    >> -
    >> -        return;
    >>    }
    >>
    >>    void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev=
,
    >> --
    >> 2.17.1
    >> _______________________________________________
    >> amd-gfx mailing list
    >> amd-gfx@lists.freedesktop.org
    >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
list
    >> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%=
7CHa
    >> wking.Zhang%40amd.com%7C615b0281a59c45e99e1d08d9098f7581%7C3dd8961fe=
48
    >> 84e608e11a82d994e183d%7C0%7C0%7C637551334037259365%7CUnknown%7CTWFpb=
GZ
    >> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0=
%3
    >> D%7C1000&amp;sdata=3D9lyDS%2Bf7Cr6gWK7Jw6o2LEXbmqHuYDYutOPWge2sAkM%3=
D&am
    >> p;reserved=3D0

    _______________________________________________
    amd-gfx mailing list
    amd-gfx@lists.freedesktop.org
    https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Coak.=
zeng%40amd.com%7C34d3cfb6c4ee4969da4e08d909917e2c%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637551342771006509%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w=
LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D8=
lNVazYDVOl3ASEqHC%2BxLoWBX%2FKh36SpxWtBnHqfVsY%3D&amp;reserved=3D0

--_000_MN2PR12MB4488EB63FD9E79897959201FF7419MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I mean, we wrote it in binary since they were so small.&nbsp; I don't remem=
ber how the newer ones for vega20 and Arcturus we generated.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zeng, Oak &lt;Oak.Zen=
g@amd.com&gt;<br>
<b>Sent:</b> Tuesday, April 27, 2021 4:08 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;; Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;; Li=
, Dennis &lt;Dennis.Li@amd.com&gt;; amd-gfx@lists.freedesktop.org
 &lt;amd-gfx@lists.freedesktop.org&gt;; Kuehling, Felix &lt;Felix.Kuehling@=
amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix no full coverage issue for gprs=
 initialization</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
span.x_EmailStyle19
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:72.0pt 72.0pt 72.0pt 72.0pt}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-CA" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:break=
-word">
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal">Yes in that case, we can check in the hand writing=
 assembly codes.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<div>
<p class=3D"x_MsoNormal">Regards,</p>
<p class=3D"x_MsoNormal">Oak&nbsp;</p>
</div>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div style=3D"border:none; border-top:solid #B5C4DF 1.0pt; padding:3.0pt 0c=
m 0cm 0cm">
<p class=3D"x_MsoNormal" style=3D"margin-left:36.0pt"><b><span style=3D"fon=
t-size:12.0pt; color:black">From:
</span></b><span style=3D"font-size:12.0pt; color:black">&quot;Deucher, Ale=
xander&quot; &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Date: </b>Tuesday, April 27, 2021 at 4:06 PM<br>
<b>To: </b>Oak Zeng &lt;Oak.Zeng@amd.com&gt;, &quot;Koenig, Christian&quot;=
 &lt;Christian.Koenig@amd.com&gt;, &quot;Zhang, Hawking&quot; &lt;Hawking.Z=
hang@amd.com&gt;, Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt=
;, &quot;Li, Dennis&quot; &lt;Dennis.Li@amd.com&gt;, &quot;amd-gfx@lists.fr=
eedesktop.org&quot; &lt;amd-gfx@lists.freedesktop.org&gt;,
 &quot;Kuehling, Felix&quot; &lt;Felix.Kuehling@amd.com&gt;<br>
<b>Subject: </b>Re: [PATCH] drm/amdgpu: fix no full coverage issue for gprs=
 initialization</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-left:36.0pt">&nbsp;</p>
</div>
<p style=3D"margin-right:5.0pt; margin-bottom:5.0pt; margin-left:41.0pt"><s=
pan style=3D"font-family:&quot;Arial&quot;,sans-serif; color:#0078D7">[AMD =
Official Use Only - Internal Distribution Only]</span></p>
<p class=3D"x_MsoNormal" style=3D"margin-left:36.0pt">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-left:36.0pt"><span style=3D"font-s=
ize:12.0pt; color:black">That would probably be helpful.&nbsp; TBH, I think=
 we hand wrote the original one for CZ so there was no original higher leve=
l source code.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-left:36.0pt"><span style=3D"font-s=
ize:12.0pt; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-left:36.0pt"><span style=3D"font-s=
ize:12.0pt; color:black">Alex</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-left:36.0pt"><span style=3D"font-s=
ize:12.0pt; color:black">&nbsp;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"margin-left:36.0pt; te=
xt-align:center">
<hr size=3D"0" width=3D"100%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal" style=3D"margin-left:36.0pt"><b><span style=3D"col=
or:black">From:</span></b><span style=3D"color:black"> Zeng, Oak &lt;Oak.Ze=
ng@amd.com&gt;<br>
<b>Sent:</b> Tuesday, April 27, 2021 3:34 PM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Zhang, Hawki=
ng &lt;Hawking.Zhang@amd.com&gt;; Christian K=F6nig &lt;ckoenig.leichtzumer=
ken@gmail.com&gt;; Li, Dennis &lt;Dennis.Li@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander
 &lt;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.=
com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix no full coverage issue for gprs=
 initialization</span>
</p>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-left:36.0pt">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-right:0cm; margin-bottom:12.0pt; m=
argin-left:36.0pt">
Hi Dennis,<br>
<br>
Should we check in the compute shader source codes? I only saw the shader b=
inaries. This will be helpful if people want to modify those shaders/fix is=
sues. The source code can be in a comment section above the binary.<br>
<br>
Regards,<br>
Oak <br>
<br>
&nbsp;<br>
<br>
On 2021-04-27, 11:31 AM, &quot;amd-gfx on behalf of Christian K=F6nig&quot;=
 &lt;amd-gfx-bounces@lists.freedesktop.org on behalf of christian.koenig@am=
d.com&gt; wrote:<br>
<br>
&nbsp;&nbsp;&nbsp; Ok in this case looks good to me.<br>
<br>
&nbsp;&nbsp;&nbsp; Christian.<br>
<br>
&nbsp;&nbsp;&nbsp; Am 27.04.21 um 17:26 schrieb Zhang, Hawking:<br>
&nbsp;&nbsp;&nbsp; &gt; [AMD Public Use]<br>
&nbsp;&nbsp;&nbsp; &gt;<br>
&nbsp;&nbsp;&nbsp; &gt; This need to be done during reset as well.<br>
&nbsp;&nbsp;&nbsp; &gt;<br>
&nbsp;&nbsp;&nbsp; &gt; Regards,<br>
&nbsp;&nbsp;&nbsp; &gt; Hawking<br>
&nbsp;&nbsp;&nbsp; &gt;<br>
&nbsp;&nbsp;&nbsp; &gt; -----Original Message-----<br>
&nbsp;&nbsp;&nbsp; &gt; From: Christian K=F6nig &lt;ckoenig.leichtzumerken@=
gmail.com&gt;<br>
&nbsp;&nbsp;&nbsp; &gt; Sent: Tuesday, April 27, 2021 23:17<br>
&nbsp;&nbsp;&nbsp; &gt; To: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; L=
i, Dennis &lt;Dennis.Li@amd.com&gt;; amd-gfx@lists.freedesktop.org; Deucher=
, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &lt;Felix.Ku=
ehling@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
&nbsp;&nbsp;&nbsp; &gt; Subject: Re: [PATCH] drm/amdgpu: fix no full covera=
ge issue for gprs initialization<br>
&nbsp;&nbsp;&nbsp; &gt;<br>
&nbsp;&nbsp;&nbsp; &gt; This is only done during bootup, isn't it?<br>
&nbsp;&nbsp;&nbsp; &gt;<br>
&nbsp;&nbsp;&nbsp; &gt; Wouldn't it be better to use the normal IB pool ins=
tead of the direct one? Or do we also need to do this during GPU reset?<br>
&nbsp;&nbsp;&nbsp; &gt;<br>
&nbsp;&nbsp;&nbsp; &gt; Regards,<br>
&nbsp;&nbsp;&nbsp; &gt; Christian.<br>
&nbsp;&nbsp;&nbsp; &gt;<br>
&nbsp;&nbsp;&nbsp; &gt; Am 27.04.21 um 16:55 schrieb Zhang, Hawking:<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; [AMD Public Use]<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; Please split the following into another patch w=
hen you commit the one.<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; Other than that, the patch is<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@am=
d.com&gt;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; Regards,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; Hawking<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; @@ -479,8 +710,6 @@ void gfx_v9_4_2_init_golden=
_registers(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; die_id);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -----Original Message-----<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; From: Dennis Li &lt;Dennis.Li@amd.com&gt;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; Sent: Tuesday, April 27, 2021 22:38<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; To: amd-gfx@lists.freedesktop.org; Deucher, Ale=
xander<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; &lt;Alexander.Deucher@amd.com&gt;; Kuehling, Fe=
lix &lt;Felix.Kuehling@amd.com&gt;;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; K=
oenig, Christian<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; &lt;Christian.Koenig@amd.com&gt;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; Cc: Li, Dennis &lt;Dennis.Li@amd.com&gt;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; Subject: [PATCH] drm/amdgpu: fix no full covera=
ge issue for gprs<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; initialization<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; The number of waves is changed to 8, so it is i=
mpossible to use old solution to cover all sgprs.<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; Signed-off-by: Dennis Li &lt;Dennis.Li@amd.com&=
gt;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_=
ib.c<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; index a2fe2dac32c1..2e6789a7dc46 100644<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br=
>
&nbsp;&nbsp;&nbsp; &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br=
>
&nbsp;&nbsp;&nbsp; &gt;&gt; @@ -328,7 +328,7 @@ int amdgpu_ib_pool_init(str=
uct amdgpu_device<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; *adev)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_IB_POOL_MAX; i++) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i =3D=3D A=
MDGPU_IB_POOL_DIRECT)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D PAGE_SIZE * 2;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D PAGE_SIZE * 6;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D AMDGPU_IB_POOL_SIZE;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_=
4_2.c<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; index d17e57dea178..77948c033c45 100644<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c<b=
r>
&nbsp;&nbsp;&nbsp; &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c<b=
r>
&nbsp;&nbsp;&nbsp; &gt;&gt; @@ -32,6 +32,11 @@<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; #include &quot;amdgpu_ras.h&q=
uot;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; #include &quot;amdgpu_gfx.h&q=
uot;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +#define SE_ID_MAX 8<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +#define CU_ID_MAX 16<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +#define SIMD_ID_MAX 4<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +#define WAVE_ID_MAX 10<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; enum gfx_v9_4_2_utc_type {<br=
>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; VML2_MEM,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; VML2_WALKER_MEM,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; @@ -81,100 +86,100 @@ static const struct soc15=
_reg_golden<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; golden_settings_gc_9_4_2_alde[] =3D {&nbsp; };<=
br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; static const u32 vgpr_init_co=
mpute_shader_aldebaran[] =3D {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
8840904, 0xb8851a04, 0xb8861344, 0x9207c006, 0x92088405, 0x81070807,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8=
1070407, 0x8e078207, 0xbe88008f, 0xc0410200, 0x00000007, 0xd3d94000,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94001, 0x18000080, 0xd3d94002, 0x18000080, 0xd3d94003,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94004, 0x18000080, 0xd3d94005, 0x18000080, 0xd3d94006,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94007, 0x18000080, 0xd3d94008, 0x18000080, 0xd3d94009,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9400a, 0x18000080, 0xd3d9400b, 0x18000080, 0xd3d9400c,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9400d, 0x18000080, 0xd3d9400e, 0x18000080, 0xd3d9400f,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94010, 0x18000080, 0xd3d94011, 0x18000080, 0xd3d94012,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94013, 0x18000080, 0xd3d94014, 0x18000080, 0xd3d94015,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94016, 0x18000080, 0xd3d94017, 0x18000080, 0xd3d94018,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94019, 0x18000080, 0xd3d9401a, 0x18000080, 0xd3d9401b,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9401c, 0x18000080, 0xd3d9401d, 0x18000080, 0xd3d9401e,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9401f, 0x18000080, 0xd3d94020, 0x18000080, 0xd3d94021,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94022, 0x18000080, 0xd3d94023, 0x18000080, 0xd3d94024,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94025, 0x18000080, 0xd3d94026, 0x18000080, 0xd3d94027,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94028, 0x18000080, 0xd3d94029, 0x18000080, 0xd3d9402a,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9402b, 0x18000080, 0xd3d9402c, 0x18000080, 0xd3d9402d,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9402e, 0x18000080, 0xd3d9402f, 0x18000080, 0xd3d94030,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94031, 0x18000080, 0xd3d94032, 0x18000080, 0xd3d94033,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94034, 0x18000080, 0xd3d94035, 0x18000080, 0xd3d94036,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94037, 0x18000080, 0xd3d94038, 0x18000080, 0xd3d94039,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9403a, 0x18000080, 0xd3d9403b, 0x18000080, 0xd3d9403c,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9403d, 0x18000080, 0xd3d9403e, 0x18000080, 0xd3d9403f,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94040, 0x18000080, 0xd3d94041, 0x18000080, 0xd3d94042,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94043, 0x18000080, 0xd3d94044, 0x18000080, 0xd3d94045,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94046, 0x18000080, 0xd3d94047, 0x18000080, 0xd3d94048,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94049, 0x18000080, 0xd3d9404a, 0x18000080, 0xd3d9404b,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9404c, 0x18000080, 0xd3d9404d, 0x18000080, 0xd3d9404e,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9404f, 0x18000080, 0xd3d94050, 0x18000080, 0xd3d94051,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94052, 0x18000080, 0xd3d94053, 0x18000080, 0xd3d94054,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94055, 0x18000080, 0xd3d94056, 0x18000080, 0xd3d94057,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94058, 0x18000080, 0xd3d94059, 0x18000080, 0xd3d9405a,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9405b, 0x18000080, 0xd3d9405c, 0x18000080, 0xd3d9405d,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9405e, 0x18000080, 0xd3d9405f, 0x18000080, 0xd3d94060,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94061, 0x18000080, 0xd3d94062, 0x18000080, 0xd3d94063,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94064, 0x18000080, 0xd3d94065, 0x18000080, 0xd3d94066,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94067, 0x18000080, 0xd3d94068, 0x18000080, 0xd3d94069,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9406a, 0x18000080, 0xd3d9406b, 0x18000080, 0xd3d9406c,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9406d, 0x18000080, 0xd3d9406e, 0x18000080, 0xd3d9406f,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94070, 0x18000080, 0xd3d94071, 0x18000080, 0xd3d94072,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94073, 0x18000080, 0xd3d94074, 0x18000080, 0xd3d94075,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94076, 0x18000080, 0xd3d94077, 0x18000080, 0xd3d94078,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94079, 0x18000080, 0xd3d9407a, 0x18000080, 0xd3d9407b,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9407c, 0x18000080, 0xd3d9407d, 0x18000080, 0xd3d9407e,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9407f, 0x18000080, 0xd3d94080, 0x18000080, 0xd3d94081,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94082, 0x18000080, 0xd3d94083, 0x18000080, 0xd3d94084,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94085, 0x18000080, 0xd3d94086, 0x18000080, 0xd3d94087,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94088, 0x18000080, 0xd3d94089, 0x18000080, 0xd3d9408a,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9408b, 0x18000080, 0xd3d9408c, 0x18000080, 0xd3d9408d,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9408e, 0x18000080, 0xd3d9408f, 0x18000080, 0xd3d94090,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94091, 0x18000080, 0xd3d94092, 0x18000080, 0xd3d94093,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94094, 0x18000080, 0xd3d94095, 0x18000080, 0xd3d94096,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d94097, 0x18000080, 0xd3d94098, 0x18000080, 0xd3d94099,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9409a, 0x18000080, 0xd3d9409b, 0x18000080, 0xd3d9409c,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d9409d, 0x18000080, 0xd3d9409e, 0x18000080, 0xd3d9409f,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940a0, 0x18000080, 0xd3d940a1, 0x18000080, 0xd3d940a2,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940a3, 0x18000080, 0xd3d940a4, 0x18000080, 0xd3d940a5,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940a6, 0x18000080, 0xd3d940a7, 0x18000080, 0xd3d940a8,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940a9, 0x18000080, 0xd3d940aa, 0x18000080, 0xd3d940ab,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940ac, 0x18000080, 0xd3d940ad, 0x18000080, 0xd3d940ae,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940af, 0x18000080, 0xd3d940b0, 0x18000080, 0xd3d940b1,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940b2, 0x18000080, 0xd3d940b3, 0x18000080, 0xd3d940b4,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940b5, 0x18000080, 0xd3d940b6, 0x18000080, 0xd3d940b7,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940b8, 0x18000080, 0xd3d940b9, 0x18000080, 0xd3d940ba,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940bb, 0x18000080, 0xd3d940bc, 0x18000080, 0xd3d940bd,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940be, 0x18000080, 0xd3d940bf, 0x18000080, 0xd3d940c0,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940c1, 0x18000080, 0xd3d940c2, 0x18000080, 0xd3d940c3,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940c4, 0x18000080, 0xd3d940c5, 0x18000080, 0xd3d940c6,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940c7, 0x18000080, 0xd3d940c8, 0x18000080, 0xd3d940c9,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940ca, 0x18000080, 0xd3d940cb, 0x18000080, 0xd3d940cc,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940cd, 0x18000080, 0xd3d940ce, 0x18000080, 0xd3d940cf,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940d0, 0x18000080, 0xd3d940d1, 0x18000080, 0xd3d940d2,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940d3, 0x18000080, 0xd3d940d4, 0x18000080, 0xd3d940d5,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940d6, 0x18000080, 0xd3d940d7, 0x18000080, 0xd3d940d8,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940d9, 0x18000080, 0xd3d940da, 0x18000080, 0xd3d940db,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940dc, 0x18000080, 0xd3d940dd, 0x18000080, 0xd3d940de,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940df, 0x18000080, 0xd3d940e0, 0x18000080, 0xd3d940e1,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940e2, 0x18000080, 0xd3d940e3, 0x18000080, 0xd3d940e4,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940e5, 0x18000080, 0xd3d940e6, 0x18000080, 0xd3d940e7,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940e8, 0x18000080, 0xd3d940e9, 0x18000080, 0xd3d940ea,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940eb, 0x18000080, 0xd3d940ec, 0x18000080, 0xd3d940ed,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940ee, 0x18000080, 0xd3d940ef, 0x18000080, 0xd3d940f0,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940f1, 0x18000080, 0xd3d940f2, 0x18000080, 0xd3d940f3,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940f4, 0x18000080, 0xd3d940f5, 0x18000080, 0xd3d940f6,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940f7, 0x18000080, 0xd3d940f8, 0x18000080, 0xd3d940f9,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940fa, 0x18000080, 0xd3d940fb, 0x18000080, 0xd3d940fc,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xd3d940fd, 0x18000080, 0xd3d940fe, 0x18000080, 0xd3d940ff,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
8000080, 0xb07c0000, 0xbe8a00ff, 0x000000f8, 0xbf11080a, 0x7e000280,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7=
e020280, 0x7e040280, 0x7e060280, 0x7e080280, 0x7e0a0280, 0x7e0c0280,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7=
e0e0280, 0x808a880a, 0xbe80320a, 0xbf84fff5, 0xbf9c0000, 0xd28c0001,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0=
001007f, 0xd28d0001, 0x0002027e, 0x10020288, 0xb88b0904, 0xb78b4000,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
1196a01, 0x00001701, 0xbe8a0087, 0xbefc00c1, 0xd89c4000, 0x00020201,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
89cc080, 0x00040401, 0x320202ff, 0x00000800, 0x808a810a, 0xbf84fff8,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
f810000,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
8840904, 0xb8851a04, 0xb8861344, 0xb8831804, 0x9208ff06, 0x00000280,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x9=
209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308, 0x8e078208,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8=
1078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xd3d94000, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94001, 0x18000080, 0xd3d94002, 0x18000080, 0xd3d94003, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94004, 0x18000080, 0xd3d94005, 0x18000080, 0xd3d94006, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94007, 0x18000080, 0xd3d94008, 0x18000080, 0xd3d94009, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9400a, 0x18000080, 0xd3d9400b, 0x18000080, 0xd3d9400c, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9400d, 0x18000080, 0xd3d9400e, 0x18000080, 0xd3d9400f, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94010, 0x18000080, 0xd3d94011, 0x18000080, 0xd3d94012, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94013, 0x18000080, 0xd3d94014, 0x18000080, 0xd3d94015, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94016, 0x18000080, 0xd3d94017, 0x18000080, 0xd3d94018, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94019, 0x18000080, 0xd3d9401a, 0x18000080, 0xd3d9401b, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9401c, 0x18000080, 0xd3d9401d, 0x18000080, 0xd3d9401e, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9401f, 0x18000080, 0xd3d94020, 0x18000080, 0xd3d94021, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94022, 0x18000080, 0xd3d94023, 0x18000080, 0xd3d94024, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94025, 0x18000080, 0xd3d94026, 0x18000080, 0xd3d94027, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94028, 0x18000080, 0xd3d94029, 0x18000080, 0xd3d9402a, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9402b, 0x18000080, 0xd3d9402c, 0x18000080, 0xd3d9402d, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9402e, 0x18000080, 0xd3d9402f, 0x18000080, 0xd3d94030, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94031, 0x18000080, 0xd3d94032, 0x18000080, 0xd3d94033, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94034, 0x18000080, 0xd3d94035, 0x18000080, 0xd3d94036, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94037, 0x18000080, 0xd3d94038, 0x18000080, 0xd3d94039, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9403a, 0x18000080, 0xd3d9403b, 0x18000080, 0xd3d9403c, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9403d, 0x18000080, 0xd3d9403e, 0x18000080, 0xd3d9403f, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94040, 0x18000080, 0xd3d94041, 0x18000080, 0xd3d94042, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94043, 0x18000080, 0xd3d94044, 0x18000080, 0xd3d94045, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94046, 0x18000080, 0xd3d94047, 0x18000080, 0xd3d94048, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94049, 0x18000080, 0xd3d9404a, 0x18000080, 0xd3d9404b, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9404c, 0x18000080, 0xd3d9404d, 0x18000080, 0xd3d9404e, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9404f, 0x18000080, 0xd3d94050, 0x18000080, 0xd3d94051, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94052, 0x18000080, 0xd3d94053, 0x18000080, 0xd3d94054, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94055, 0x18000080, 0xd3d94056, 0x18000080, 0xd3d94057, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94058, 0x18000080, 0xd3d94059, 0x18000080, 0xd3d9405a, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9405b, 0x18000080, 0xd3d9405c, 0x18000080, 0xd3d9405d, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9405e, 0x18000080, 0xd3d9405f, 0x18000080, 0xd3d94060, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94061, 0x18000080, 0xd3d94062, 0x18000080, 0xd3d94063, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94064, 0x18000080, 0xd3d94065, 0x18000080, 0xd3d94066, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94067, 0x18000080, 0xd3d94068, 0x18000080, 0xd3d94069, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9406a, 0x18000080, 0xd3d9406b, 0x18000080, 0xd3d9406c, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9406d, 0x18000080, 0xd3d9406e, 0x18000080, 0xd3d9406f, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94070, 0x18000080, 0xd3d94071, 0x18000080, 0xd3d94072, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94073, 0x18000080, 0xd3d94074, 0x18000080, 0xd3d94075, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94076, 0x18000080, 0xd3d94077, 0x18000080, 0xd3d94078, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94079, 0x18000080, 0xd3d9407a, 0x18000080, 0xd3d9407b, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9407c, 0x18000080, 0xd3d9407d, 0x18000080, 0xd3d9407e, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9407f, 0x18000080, 0xd3d94080, 0x18000080, 0xd3d94081, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94082, 0x18000080, 0xd3d94083, 0x18000080, 0xd3d94084, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94085, 0x18000080, 0xd3d94086, 0x18000080, 0xd3d94087, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94088, 0x18000080, 0xd3d94089, 0x18000080, 0xd3d9408a, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9408b, 0x18000080, 0xd3d9408c, 0x18000080, 0xd3d9408d, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9408e, 0x18000080, 0xd3d9408f, 0x18000080, 0xd3d94090, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94091, 0x18000080, 0xd3d94092, 0x18000080, 0xd3d94093, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94094, 0x18000080, 0xd3d94095, 0x18000080, 0xd3d94096, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d94097, 0x18000080, 0xd3d94098, 0x18000080, 0xd3d94099, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9409a, 0x18000080, 0xd3d9409b, 0x18000080, 0xd3d9409c, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d9409d, 0x18000080, 0xd3d9409e, 0x18000080, 0xd3d9409f, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940a0, 0x18000080, 0xd3d940a1, 0x18000080, 0xd3d940a2, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940a3, 0x18000080, 0xd3d940a4, 0x18000080, 0xd3d940a5, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940a6, 0x18000080, 0xd3d940a7, 0x18000080, 0xd3d940a8, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940a9, 0x18000080, 0xd3d940aa, 0x18000080, 0xd3d940ab, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940ac, 0x18000080, 0xd3d940ad, 0x18000080, 0xd3d940ae, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940af, 0x18000080, 0xd3d940b0, 0x18000080, 0xd3d940b1, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940b2, 0x18000080, 0xd3d940b3, 0x18000080, 0xd3d940b4, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940b5, 0x18000080, 0xd3d940b6, 0x18000080, 0xd3d940b7, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940b8, 0x18000080, 0xd3d940b9, 0x18000080, 0xd3d940ba, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940bb, 0x18000080, 0xd3d940bc, 0x18000080, 0xd3d940bd, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940be, 0x18000080, 0xd3d940bf, 0x18000080, 0xd3d940c0, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940c1, 0x18000080, 0xd3d940c2, 0x18000080, 0xd3d940c3, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940c4, 0x18000080, 0xd3d940c5, 0x18000080, 0xd3d940c6, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940c7, 0x18000080, 0xd3d940c8, 0x18000080, 0xd3d940c9, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940ca, 0x18000080, 0xd3d940cb, 0x18000080, 0xd3d940cc, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940cd, 0x18000080, 0xd3d940ce, 0x18000080, 0xd3d940cf, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940d0, 0x18000080, 0xd3d940d1, 0x18000080, 0xd3d940d2, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940d3, 0x18000080, 0xd3d940d4, 0x18000080, 0xd3d940d5, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940d6, 0x18000080, 0xd3d940d7, 0x18000080, 0xd3d940d8, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940d9, 0x18000080, 0xd3d940da, 0x18000080, 0xd3d940db, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940dc, 0x18000080, 0xd3d940dd, 0x18000080, 0xd3d940de, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940df, 0x18000080, 0xd3d940e0, 0x18000080, 0xd3d940e1, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940e2, 0x18000080, 0xd3d940e3, 0x18000080, 0xd3d940e4, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940e5, 0x18000080, 0xd3d940e6, 0x18000080, 0xd3d940e7, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940e8, 0x18000080, 0xd3d940e9, 0x18000080, 0xd3d940ea, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940eb, 0x18000080, 0xd3d940ec, 0x18000080, 0xd3d940ed, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940ee, 0x18000080, 0xd3d940ef, 0x18000080, 0xd3d940f0, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940f1, 0x18000080, 0xd3d940f2, 0x18000080, 0xd3d940f3, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940f4, 0x18000080, 0xd3d940f5, 0x18000080, 0xd3d940f6, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940f7, 0x18000080, 0xd3d940f8, 0x18000080, 0xd3d940f9, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940fa, 0x18000080, 0xd3d940fb, 0x18000080, 0xd3d940fc, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
3d940fd, 0x18000080, 0xd3d940fe, 0x18000080, 0xd3d940ff, 0x18000080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
07c0000, 0xbe8a00ff, 0x000000f8, 0xbf11080a, 0x7e000280, 0x7e020280,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x7=
e040280, 0x7e060280, 0x7e080280, 0x7e0a0280, 0x7e0c0280, 0x7e0e0280,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8=
08a880a, 0xbe80320a, 0xbf84fff5, 0xbf9c0000, 0xd28c0001, 0x0001007f,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xd=
28d0001, 0x0002027e, 0x10020288, 0xbe8b0004, 0xb78b4000, 0xd1196a01,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0=
0001701, 0xbe8a0087, 0xbefc00c1, 0xd89c4000, 0x00020201, 0xd89cc080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0=
0040401, 0x320202ff, 0x00000800, 0x808a810a, 0xbf84fff8,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +0xbf810000,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; const struct soc15_reg_entry =
vgpr_init_regs_aldebaran[] =3D { @@ -183,7 +188,7 @@ const struct soc15_reg=
_entry vgpr_init_regs_aldebaran[] =3D {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 4 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0xbf },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x400004 },&nbsp; /* 64KB LDS =
*/<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x400006 },&nbsp; /* 64KB<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +LDS */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x3F }, /*&nbs=
p; 63 - accum-offset =3D 256 */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0=
xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0=
xffffffff }, @@ -195,262 +200,488 @@ const struct soc15_reg_entry vgpr_init=
_regs_aldebaran[] =3D {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7),<b=
r>
&nbsp;&nbsp;&nbsp; &gt;&gt; 0xffffffff },&nbsp; };<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -static const u32 sgpr_init_compute_shader_alde=
baran[] =3D {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
8840904, 0xb8851a04, 0xb8861344, 0x9207c006, 0x92088405, 0x81070807,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8=
1070407, 0x8e078207, 0xbefc0006, 0xbf800000, 0xbf900001, 0xbe88008f,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xc=
0410200, 0x00000007, 0xb07c0000, 0xbe8000ff, 0x0000005f, 0xbee50080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
e812c65, 0xbe822c65, 0xbe832c65, 0xbe842c65, 0xbe852c65, 0xb77c0005,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8=
0808500, 0xbf84fff8, 0xbe800080, 0xbf810000,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +static const u32 sgpr112_init_compute_shader_a=
ldebaran[] =3D {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
8840904, 0xb8851a04, 0xb8861344, 0xb8831804, 0x9208ff06, 0x00000280,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x9=
209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308, 0x8e078208,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8=
1078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbf8e003f, 0xc0030200,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0=
0000000, 0xbf8c0000, 0xbf06ff08, 0xdeadbeaf, 0xbf84fff9, 0x81028102,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xc=
0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbe880080, 0xbe890080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
e8a0080, 0xbe8b0080, 0xbe8c0080, 0xbe8d0080, 0xbe8e0080, 0xbe8f0080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
e900080, 0xbe910080, 0xbe920080, 0xbe930080, 0xbe940080, 0xbe950080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
e960080, 0xbe970080, 0xbe980080, 0xbe990080, 0xbe9a0080, 0xbe9b0080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
e9c0080, 0xbe9d0080, 0xbe9e0080, 0xbe9f0080, 0xbea00080, 0xbea10080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ea20080, 0xbea30080, 0xbea40080, 0xbea50080, 0xbea60080, 0xbea70080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ea80080, 0xbea90080, 0xbeaa0080, 0xbeab0080, 0xbeac0080, 0xbead0080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
eae0080, 0xbeaf0080, 0xbeb00080, 0xbeb10080, 0xbeb20080, 0xbeb30080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
eb40080, 0xbeb50080, 0xbeb60080, 0xbeb70080, 0xbeb80080, 0xbeb90080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
eba0080, 0xbebb0080, 0xbebc0080, 0xbebd0080, 0xbebe0080, 0xbebf0080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ec00080, 0xbec10080, 0xbec20080, 0xbec30080, 0xbec40080, 0xbec50080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ec60080, 0xbec70080, 0xbec80080, 0xbec90080, 0xbeca0080, 0xbecb0080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ecc0080, 0xbecd0080, 0xbece0080, 0xbecf0080, 0xbed00080, 0xbed10080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ed20080, 0xbed30080, 0xbed40080, 0xbed50080, 0xbed60080, 0xbed70080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ed80080, 0xbed90080, 0xbeda0080, 0xbedb0080, 0xbedc0080, 0xbedd0080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ede0080, 0xbedf0080, 0xbee00080, 0xbee10080, 0xbee20080, 0xbee30080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ee40080, 0xbee50080, 0xbf810000<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -static const struct soc15_reg_entry sgpr1_init=
_regs_aldebaran[] =3D {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +const struct soc15_reg_entry sgpr112_init_regs=
_aldebaran[] =3D {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 0x000000=
0 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 8 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x240 }, /* (80 GPRS): SGPRS[9=
:6] VGPRS[5:0] */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x4 }, /* USER_SGPR[5:1]*/<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x3F }, /*&nbsp; 63 - accum-of=
fset =3D 256 */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0x000000ff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0x000000ff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0x000000ff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0x000000ff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0x000000ff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0x000000ff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0x000000ff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0x000000ff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x2c0 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x6 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x0 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +0xffffffff }, };<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +static const u32 sgpr96_init_compute_shader_al=
debaran[] =3D {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
8840904, 0xb8851a04, 0xb8861344, 0xb8831804, 0x9208ff06, 0x00000280,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x9=
209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308, 0x8e078208,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8=
1078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbf8e003f, 0xc0030200,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0=
0000000, 0xbf8c0000, 0xbf06ff08, 0xdeadbeaf, 0xbf84fff9, 0x81028102,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xc=
0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbe880080, 0xbe890080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
e8a0080, 0xbe8b0080, 0xbe8c0080, 0xbe8d0080, 0xbe8e0080, 0xbe8f0080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
e900080, 0xbe910080, 0xbe920080, 0xbe930080, 0xbe940080, 0xbe950080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
e960080, 0xbe970080, 0xbe980080, 0xbe990080, 0xbe9a0080, 0xbe9b0080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
e9c0080, 0xbe9d0080, 0xbe9e0080, 0xbe9f0080, 0xbea00080, 0xbea10080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ea20080, 0xbea30080, 0xbea40080, 0xbea50080, 0xbea60080, 0xbea70080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ea80080, 0xbea90080, 0xbeaa0080, 0xbeab0080, 0xbeac0080, 0xbead0080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
eae0080, 0xbeaf0080, 0xbeb00080, 0xbeb10080, 0xbeb20080, 0xbeb30080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
eb40080, 0xbeb50080, 0xbeb60080, 0xbeb70080, 0xbeb80080, 0xbeb90080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
eba0080, 0xbebb0080, 0xbebc0080, 0xbebd0080, 0xbebe0080, 0xbebf0080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ec00080, 0xbec10080, 0xbec20080, 0xbec30080, 0xbec40080, 0xbec50080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ec60080, 0xbec70080, 0xbec80080, 0xbec90080, 0xbeca0080, 0xbecb0080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ecc0080, 0xbecd0080, 0xbece0080, 0xbecf0080, 0xbed00080, 0xbed10080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ed20080, 0xbed30080, 0xbed40080, 0xbed50080, 0xbed60080, 0xbed70080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ed80080, 0xbed90080, 0xbf810000,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -static const struct soc15_reg_entry sgpr2_init=
_regs_aldebaran[] =3D {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +const struct soc15_reg_entry sgpr96_init_regs_=
aldebaran[] =3D {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 0x000000=
0 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 8 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 0xc },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; { SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x240 }, /* (80 GPRS) */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x4 }, /* USER_SGPR[5:1]*/<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x3F }, /*&nbsp; 63 - accum-of=
fset =3D 256 */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0x0000ff00 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0x0000ff00 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0x0000ff00 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0x0000ff00 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0x0000ff00 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0x0000ff00 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0x0000ff00 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0x0000ff00 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x240 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x6 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x0 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -static int gfx_v9_4_2_check_gprs_init_coverage=
(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; uint32_t *wb)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -{<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t se_id, cu_id, simd_id;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t simd_cnt =3D 0;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t se_offset, cu_offset, data;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for=
 (se_id =3D 0; se_id &lt; adev-&gt;gfx.config.max_shader_engines; se_id++) =
{<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se_offset =3D se_id * 16 * 4;<=
br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (cu_id =3D 0; cu_id &lt; 1=
6; cu_id++) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; cu_offset =3D cu_id * 4;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; for (simd_id =3D 0; simd_id &lt; 4; simd_id++) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D =
wb[se_offset + cu_offset + simd_id];<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data =
=3D=3D 0xF)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; simd_cnt++;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&nbsp;&nbsp;&nbsp; &gt;&gt; -<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(adev-&gt;gfx.cu_info.number * 4 =3D=3D simd_cnt)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev=
_warn(adev-&gt;dev, &quot;SIMD Count: %d, %d\n&quot;,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.cu_info.num=
ber * 4, simd_cnt);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for=
 (se_id =3D 0; se_id &lt; adev-&gt;gfx.config.max_shader_engines; se_id++) =
{<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se_offset =3D se_id * 16 * 4;<=
br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (cu_id =3D 0; cu_id &lt; 1=
6; cu_id++) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; cu_offset =3D cu_id * 4;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; for (simd_id =3D 0; simd_id &lt; 4; simd_id++) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D =
wb[se_offset + cu_offset + simd_id];<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data =
!=3D 0xF)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;SE[%d]C=
U[%d]SIMD[%d]: isn't inited\n&quot;,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; se_id, cu_id, simd_id);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&nbsp;&nbsp;&nbsp; &gt;&gt; +static const u32 sgpr64_init_compute_shader_al=
debaran[] =3D {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
8840904, 0xb8851a04, 0xb8861344, 0xb8831804, 0x9208ff06, 0x00000280,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x9=
209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308, 0x8e078208,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8=
1078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbe880080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
e890080, 0xbe8a0080, 0xbe8b0080, 0xbe8c0080, 0xbe8d0080, 0xbe8e0080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
e8f0080, 0xbe900080, 0xbe910080, 0xbe920080, 0xbe930080, 0xbe940080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
e950080, 0xbe960080, 0xbe970080, 0xbe980080, 0xbe990080, 0xbe9a0080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
e9b0080, 0xbe9c0080, 0xbe9d0080, 0xbe9e0080, 0xbe9f0080, 0xbea00080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ea10080, 0xbea20080, 0xbea30080, 0xbea40080, 0xbea50080, 0xbea60080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ea70080, 0xbea80080, 0xbea90080, 0xbeaa0080, 0xbeab0080, 0xbeac0080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
ead0080, 0xbeae0080, 0xbeaf0080, 0xbeb00080, 0xbeb10080, 0xbeb20080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
eb30080, 0xbeb40080, 0xbeb50080, 0xbeb60080, 0xbeb70080, 0xbeb80080,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xb=
eb90080, 0xbf810000,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +};<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn -EFAULT;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -}<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +const struct soc15_reg_entry sgpr64_init_regs_=
aldebaran[] =3D {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 0x0000000 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 0x10 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x1c0 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x6 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x0 },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0xffffffff },<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { S=
OC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +0xffffffff }, };<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; static int gfx_v9_4_2_run_sha=
der(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con=
st uint32_t *shader_ptr, uint32_t shader_size,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con=
st struct soc15_reg_entry *init_regs, uint32_t regs_size,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t compute_dim_x, u64 wb_gpu_addr)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_ib *ib,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con=
st u32 *shader_ptr, u32 shader_size,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con=
st struct soc15_reg_entry *init_regs, u32 regs_size,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32=
 compute_dim_x, u64 wb_gpu_addr, u32 pattern,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct dma_fence **fence_ptr)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_ring *ring =3D &amp;adev-&gt;gfx.compute_ring[0];<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_ib ib;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct dma_fence *f =3D NULL;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; int r, i;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint32_t total_size, shader_offset;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; u64 gpu_addr;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tot=
al_size =3D (regs_size * 3 + 4 + 4 + 5 + 2) * 4;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tot=
al_size =3D (regs_size * 3 + 4 + 5 + 5) * 4;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; total_size =3D ALIGN(total_size, 256);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; shader_offset =3D total_size;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; total_size +=3D ALIGN(shader_size, 256);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* allocate an indirect buffer to put the commands in */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem=
set(&amp;ib, 0, sizeof(ib));<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem=
set(ib, 0, sizeof(*ib));<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; r =3D amdgpu_ib_get(adev, NULL, total_size,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IB_POOL_DIRECT, &amp;ib);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IB_POOL_DIRECT, ib);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;amdgpu: failed=
 to get ib (%d).\n&quot;, r);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;fa=
iled to get ib (%d).\n&quot;, r);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* load the compute shaders */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; for (i =3D 0; i &lt; shader_size/sizeof(u32); i++)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.ptr[i + (shader_offset / 4)=
] =3D shader_ptr[i];<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[i + (shader_offset =
/ 4)] =3D shader_ptr[i];<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* init the ib length to 0 */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.=
length_dw =3D 0;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-=
&gt;length_dw =3D 0;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* write the register state for the compute dispatch */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; for (i =3D 0; i &lt; regs_size; i++) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.ptr[ib.length_dw++] =3D PAC=
KET3(PACKET3_SET_SH_REG, 1);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.ptr[ib.length_dw++] =3D SOC=
15_REG_ENTRY_OFFSET(init_regs[i])<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++]=
 =3D PACKET3(PACKET3_SET_SH_REG, 1);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++]=
 =3D SOC15_REG_ENTRY_OFFSET(init_regs[i])<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - PACKET3_SET_SH_REG_START=
;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.ptr[ib.length_dw++] =3D ini=
t_regs[i].reg_value;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-&gt;ptr[ib-&gt;length_dw++]=
 =3D init_regs[i].reg_value;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE=
_PGM_HI */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu=
_addr =3D (ib.gpu_addr + (u64)shader_offset) &gt;&gt; 8;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.=
ptr[ib.length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.=
ptr[ib.length_dw++] =3D SOC15_REG_OFFSET(GC, 0, regCOMPUTE_PGM_LO)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu=
_addr =3D (ib-&gt;gpu_addr + (u64)shader_offset) &gt;&gt; 8;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-=
&gt;ptr[ib-&gt;length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-=
&gt;ptr[ib-&gt;length_dw++] =3D SOC15_REG_OFFSET(GC, 0,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +regCOMPUTE_PGM_LO)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 - PACKET3_SET_SH_REG_START;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.=
ptr[ib.length_dw++] =3D lower_32_bits(gpu_addr);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.=
ptr[ib.length_dw++] =3D upper_32_bits(gpu_addr);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-=
&gt;ptr[ib-&gt;length_dw++] =3D lower_32_bits(gpu_addr);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-=
&gt;ptr[ib-&gt;length_dw++] =3D upper_32_bits(gpu_addr);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* write the wb buffer address */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.=
ptr[ib.length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.=
ptr[ib.length_dw++] =3D SOC15_REG_OFFSET(GC, 0, regCOMPUTE_USER_DATA_0)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-=
&gt;ptr[ib-&gt;length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 3);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-=
&gt;ptr[ib-&gt;length_dw++] =3D SOC15_REG_OFFSET(GC, 0,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +regCOMPUTE_USER_DATA_0)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 - PACKET3_SET_SH_REG_START;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.=
ptr[ib.length_dw++] =3D lower_32_bits(wb_gpu_addr);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.=
ptr[ib.length_dw++] =3D upper_32_bits(wb_gpu_addr);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-=
&gt;ptr[ib-&gt;length_dw++] =3D lower_32_bits(wb_gpu_addr);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-=
&gt;ptr[ib-&gt;length_dw++] =3D upper_32_bits(wb_gpu_addr);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-=
&gt;ptr[ib-&gt;length_dw++] =3D pattern;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* write dispatch packet */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.=
ptr[ib.length_dw++] =3D PACKET3(PACKET3_DISPATCH_DIRECT, 3);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.=
ptr[ib.length_dw++] =3D compute_dim_x; /* x */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.=
ptr[ib.length_dw++] =3D 1; /* y */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.=
ptr[ib.length_dw++] =3D 1; /* z */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.=
ptr[ib.length_dw++] =3D<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-=
&gt;ptr[ib-&gt;length_dw++] =3D PACKET3(PACKET3_DISPATCH_DIRECT, 3);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-=
&gt;ptr[ib-&gt;length_dw++] =3D compute_dim_x; /* x */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-=
&gt;ptr[ib-&gt;length_dw++] =3D 1; /* y */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-=
&gt;ptr[ib-&gt;length_dw++] =3D 1; /* z */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib-=
&gt;ptr[ib-&gt;length_dw++] =3D<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_FIELD(=
0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; 1);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
write CS partial flush packet */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.=
ptr[ib.length_dw++] =3D PACKET3(PACKET3_EVENT_WRITE, 0);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib.=
ptr[ib.length_dw++] =3D EVENT_TYPE(7) | EVENT_INDEX(4);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* shedule the ib on the ring */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_ib_schedule(ring, 1, &amp;ib, NULL, &amp;f);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_ib_schedule(ring, 1, ib, NULL, fence_ptr);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;amdgpu: ib sub=
mit failed (%d).\n&quot;, r);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;ib=
 submit failed (%d).\n&quot;, r);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ib_free(adev, ib, NULL)=
;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn r;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +}<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
wait for the GPU to finish processing the IB */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D dma_fence_wait(f, false);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(r) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;amdgpu: fence =
wait failed (%d).\n&quot;, r);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +static void gfx_v9_4_2_log_wave_assignment(str=
uct amdgpu_device<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +*adev, uint32_t *wb_ptr) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t se, cu, simd, wave;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t offset =3D 0;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cha=
r *str;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int=
 size;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
 =3D kmalloc(256, GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!str)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev=
_dbg(adev-&gt;dev, &quot;wave assignment:\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for=
 (se =3D 0; se &lt; adev-&gt;gfx.config.max_shader_engines; se++) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (cu =3D 0; cu &lt; CU_ID_M=
AX; cu++) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; memset(str, 0, 256);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; size =3D sprintf(str, &quot;SE[%02d]CU[%02d]: &quot;, se,=
 cu);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; for (simd =3D 0; simd &lt; SIMD_ID_MAX; simd++) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D=
 sprintf(str + size, &quot;[&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (wave=
 =3D 0; wave &lt; WAVE_ID_MAX; wave++) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D sprintf(str + size, &quot;=
%x&quot;, wb_ptr[offset]);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset++;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D=
 sprintf(str + size, &quot;]&nbsp; &quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;%s\n&quot;, str);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -fail:<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_ib_free(adev, &amp;ib, NULL);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma=
_fence_put(f);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn r;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfr=
ee(str);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -int gfx_v9_4_2_do_edc_gpr_workarounds(struct a=
mdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +static int gfx_v9_4_2_wait_for_waves_assigned(=
struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
uint32_t *wb_ptr, uint32_t mask,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
uint32_t pattern, uint32_t num_wave, bool wait)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_ring *ring =3D &amp;adev-&gt;gfx.compute_ring[0];<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int=
 r;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int=
 compute_dim_x =3D adev-&gt;gfx.config.max_shader_engines *<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.max_cu_per_sh=
 *<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.max_sh_per_se=
;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int=
 sgpr_work_group_size =3D 5;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
CU_ID: 0~15, SIMD_ID: 0~3 */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int=
 wb_size =3D adev-&gt;gfx.config.max_shader_engines * 16 * 4;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_ib ib;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t se, cu, simd, wave;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t loop =3D 0;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t wave_cnt;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t offset;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
only support when RAS is enabled */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do =
{<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wave_cnt =3D 0;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D 0;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (se =3D 0; se &lt; adev-&g=
t;gfx.config.max_shader_engines; se++)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; for (cu =3D 0; cu &lt; CU_ID_MAX; cu++)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (simd=
 =3D 0; simd &lt; SIMD_ID_MAX; simd++)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (wave =3D 0; wave &lt; WAVE_ID_M=
AX; wave++) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; if (((1 &lt;&lt; wave) &amp; mask) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (wb_ptr[offset] =3D=3D pattern))<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wave_cnt++;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; offset++;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (wave_cnt =3D=3D num_wave)<=
br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(1);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } w=
hile (++loop &lt; 2000 &amp;&amp; wait);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev=
_err(adev-&gt;dev, &quot;actual wave num: %d, expected wave num: %d\n&quot;=
,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wave_cnt, num_wave);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx=
_v9_4_2_log_wave_assignment(adev, wb_ptr);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn -EBADSLT;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +}<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +static int gfx_v9_4_2_do_sgprs_init(struct amd=
gpu_device *adev) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int=
 r;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int=
 wb_size =3D adev-&gt;gfx.config.max_shader_engines *<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_ib wb_ib;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_ib disp_ibs[3];<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct dma_fence *fences[3];<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32=
 pattern[3] =3D { 0x1, 0x5, 0xa };<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* bail if the compute ring is not ready */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!ring-&gt;sched.ready)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!adev-&gt;gfx.compute_ring[0].sched.ready ||<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;gfx.compute_ri=
ng[1].sched.ready)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
allocate an indirect buffer to put the commands in */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem=
set(&amp;ib, 0, sizeof(ib));<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_ib_get(adev, NULL, wb_size * sizeof(uint32_t),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IB_POOL_DIRECT, &amp;ib);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
allocate the write-back buffer from IB */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem=
set(&amp;wb_ib, 0, sizeof(wb_ib));<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_ib_get(adev, NULL, (1 + wb_size) * sizeof(uint32_t),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IB_POOL_DIRECT, &amp;wb_ib);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;amdgpu: failed=
 to get ib (%d).\n&quot;, r);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;fa=
iled to get ib (%d) for wb\n&quot;, r);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem=
set(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D gfx_v9_4_2_run_shader(adev,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.compute_ring[0],<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &amp;disp_ibs[0],<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; sgpr112_init_compute_shader_aldebaran,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; sizeof(sgpr112_init_compute_shader_aldebaran),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; sgpr112_init_regs_aldebaran,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ARRAY_SIZE(sgpr112_init_regs_aldebaran),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gfx.cu_info.number,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; wb_ib.gpu_addr, pattern[0], &amp;fences[0]);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(r) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;fa=
iled to clear first 224 sgprs\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto pro_end;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem=
set(ib.ptr, 0, wb_size * sizeof(uint32_t));<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D gfx_v9_4_2_run_shader(adev, vgpr_init_compute_shader_aldebaran,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; sizeof(vgpr_init_compute_shader_aldebaran),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; vgpr_init_regs_aldebaran,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; ARRAY_SIZE(vgpr_init_regs_aldebaran),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; compute_dim_x * 2, ib.gpu_addr);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D gfx_v9_4_2_wait_for_waves_assigned(adev,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &amp;wb_ib.ptr[1], 0b11,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pattern[0],<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gfx.cu_info.number * SIMD_ID_MAX * 2,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; true);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;In=
it VGPRS: failed to run shader\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;wa=
ve coverage failed when clear first 224 sgprs\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wb_ib.ptr[0] =3D 0xdeadbeaf; /=
* stop waves */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto disp0_failed;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D gfx_v9_4_2_check_gprs_init_coverage(adev, ib.ptr);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D gfx_v9_4_2_run_shader(adev,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.compute_ring[1],<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &amp;disp_ibs[1],<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; sgpr96_init_compute_shader_aldebaran,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; sizeof(sgpr96_init_compute_shader_aldebaran),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; sgpr96_init_regs_aldebaran,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ARRAY_SIZE(sgpr96_init_regs_aldebaran),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gfx.cu_info.number * 2,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; wb_ib.gpu_addr, pattern[1], &amp;fences[1]);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;In=
it VGPRS: failed to cover all SIMDs\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } e=
lse {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;I=
nit VGPRS Successfully\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;fa=
iled to clear next 576 sgprs\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto disp0_failed;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D gfx_v9_4_2_wait_for_waves_assigned(adev,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &amp;wb_ib.ptr[1], 0b11111100,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pattern[1], adev-&gt;gfx.cu_info.number * SIMD_ID_MAX * 6=
,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; true);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(r) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;wa=
ve coverage failed when clear first 576 sgprs\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wb_ib.ptr[0] =3D 0xdeadbeaf; /=
* stop waves */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto disp1_failed;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem=
set(ib.ptr, 0, wb_size * sizeof(uint32_t));<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D gfx_v9_4_2_run_shader(adev, sgpr_init_compute_shader_aldebaran,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; sizeof(sgpr_init_compute_shader_aldebaran),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; sgpr1_init_regs_aldebaran,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; ARRAY_SIZE(sgpr1_init_regs_aldebaran),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; compute_dim_x / 2 * sgpr_work_group_size,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; ib.gpu_addr);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wb_=
ib.ptr[0] =3D 0xdeadbeaf; /* stop waves */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
wait for the GPU to finish processing the IB */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D dma_fence_wait(fences[0], false);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;In=
it SGPRS Part1: failed to run shader\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;ti=
meout to clear first 224 sgprs\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto disp1_failed;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D gfx_v9_4_2_run_shader(adev, sgpr_init_compute_shader_aldebaran,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; sizeof(sgpr_init_compute_shader_aldebaran),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; sgpr2_init_regs_aldebaran,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; ARRAY_SIZE(sgpr2_init_regs_aldebaran),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; compute_dim_x / 2 * sgpr_work_group_size,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; ib.gpu_addr);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D dma_fence_wait(fences[1], false);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;In=
it SGPRS Part2: failed to run shader\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;ti=
meout to clear first 576 sgprs\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto disp1_failed;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D gfx_v9_4_2_check_gprs_init_coverage(adev, ib.ptr);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem=
set(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D gfx_v9_4_2_run_shader(adev,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.compute_ring[0],<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &amp;disp_ibs[2],<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; sgpr64_init_compute_shader_aldebaran,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; sizeof(sgpr64_init_compute_shader_aldebaran),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; sgpr64_init_regs_aldebaran,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ARRAY_SIZE(sgpr64_init_regs_aldebaran),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gfx.cu_info.number,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; wb_ib.gpu_addr, pattern[2], &amp;fences[2]);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(r) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;fa=
iled to clear first 256 sgprs\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto disp1_failed;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D dma_fence_wait(fences[2], false);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(r) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;ti=
meout to clear first 256 sgprs\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto disp2_failed;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D gfx_v9_4_2_wait_for_waves_assigned(adev,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &amp;wb_ib.ptr[1], 0b1111,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pattern[2],<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gfx.cu_info.number * SIMD_ID_MAX * 4,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; false);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(r) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;wa=
ve coverage failed when clear first 256 sgprs\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto disp2_failed;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +disp2_failed:<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_ib_free(adev, &amp;disp_ibs[2], NULL);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma=
_fence_put(fences[2]);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +disp1_failed:<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_ib_free(adev, &amp;disp_ibs[1], NULL);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma=
_fence_put(fences[1]);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +disp0_failed:<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_ib_free(adev, &amp;disp_ibs[0], NULL);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma=
_fence_put(fences[0]);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +pro_end:<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_ib_free(adev, &amp;wb_ib, NULL);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &quot;Init SGPRS: failed to cover all SIMDs\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;I=
nit SGPRS Failed\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-=
&gt;dev, &quot;Init SGPRS Successfully\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -failed:<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_ib_free(adev, &amp;ib, NULL);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +static int gfx_v9_4_2_do_vgprs_init(struct amd=
gpu_device *adev) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int=
 r;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
CU_ID: 0~15, SIMD_ID: 0~3, WAVE_ID: 0 ~ 9 */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int=
 wb_size =3D adev-&gt;gfx.config.max_shader_engines *<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_ib wb_ib;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct amdgpu_ib disp_ib;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct dma_fence *fence;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32=
 pattern =3D 0xa;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
bail if the compute ring is not ready */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!adev-&gt;gfx.compute_ring[0].sched.ready)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
allocate the write-back buffer from IB */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem=
set(&amp;wb_ib, 0, sizeof(wb_ib));<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_ib_get(adev, NULL, (1 + wb_size) * sizeof(uint32_t),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IB_POOL_DIRECT, &amp;wb_ib);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(r) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;fa=
iled to get ib (%d) for wb.\n&quot;, r);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem=
set(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D gfx_v9_4_2_run_shader(adev,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.compute_ring[0],<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &amp;disp_ib,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; vgpr_init_compute_shader_aldebaran,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; sizeof(vgpr_init_compute_shader_aldebaran),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; vgpr_init_regs_aldebaran,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ARRAY_SIZE(vgpr_init_regs_aldebaran),<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gfx.cu_info.number,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; wb_ib.gpu_addr, pattern, &amp;fence);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(r) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;fa=
iled to clear vgprs\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto pro_end;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
wait for the GPU to finish processing the IB */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D dma_fence_wait(fence, false);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(r) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;ti=
meout to clear vgprs\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto disp_failed;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D gfx_v9_4_2_wait_for_waves_assigned(adev,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &amp;wb_ib.ptr[1], 0b1,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pattern,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;gfx.cu_info.number * SIMD_ID_MAX,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; false);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(r) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;fa=
iled to cover all simds when clearing vgprs\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto disp_failed;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +disp_failed:<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_ib_free(adev, &amp;disp_ib, NULL);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma=
_fence_put(fence);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +pro_end:<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd=
gpu_ib_free(adev, &amp;wb_ib, NULL);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(r)<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;I=
nit VGPRS Failed\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; els=
e<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;I=
nit VGPRS Successfully\n&quot;);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn r;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +}<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +int gfx_v9_4_2_do_edc_gpr_workarounds(struct a=
mdgpu_device *adev) {<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
only support when RAS is enabled */<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx=
_v9_4_2_do_sgprs_init(adev);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx=
_v9_4_2_do_vgprs_init(adev);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn 0;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +}<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; +<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; static void gfx_v9_4_2_query_=
sq_timeout_status(struct amdgpu_device<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; *adev);&nbsp; static void gfx_v9_4_2_reset_sq_t=
imeout_status(struct<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; amdgpu_device *adev);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt; @@ -479,8 +710,6 @@ void gfx_v9_4_2_init_golden=
_registers(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; die_id);<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn;<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp; void gfx_v9_4_2_debug_trap_co=
nfig_init(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; --<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; 2.17.1<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; _______________________________________________=
<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; amd-gfx mailing list<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; amd-gfx@lists.freedesktop.org<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; <a href=3D"https://nam11.safelinks.protection.o=
utlook.com/?url=3Dhttps%3A%2F%2Flist">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist</a=
><br>
&nbsp;&nbsp;&nbsp; &gt;&gt; s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gf=
x&amp;amp;data=3D04%7C01%7CHa<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; wking.Zhang%40amd.com%7C615b0281a59c45e99e1d08d=
9098f7581%7C3dd8961fe48<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; 84e608e11a82d994e183d%7C0%7C0%7C637551334037259=
365%7CUnknown%7CTWFpbGZ<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi=
I6Ik1haWwiLCJXVCI6Mn0%3<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; D%7C1000&amp;amp;sdata=3D9lyDS%2Bf7Cr6gWK7Jw6o2=
LEXbmqHuYDYutOPWge2sAkM%3D&amp;am<br>
&nbsp;&nbsp;&nbsp; &gt;&gt; p;reserved=3D0<br>
<br>
&nbsp;&nbsp;&nbsp; _______________________________________________<br>
&nbsp;&nbsp;&nbsp; amd-gfx mailing list<br>
&nbsp;&nbsp;&nbsp; amd-gfx@lists.freedesktop.org<br>
&nbsp;&nbsp;&nbsp; <a href=3D"https://nam11.safelinks.protection.outlook.co=
m/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx=
&amp;amp;data=3D04%7C01%7Coak.zeng%40amd.com%7C34d3cfb6c4ee4969da4e08d90991=
7e2c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637551342771006509%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;amp;sdata=3D8lNVazYDVOl3ASEqHC%2BxLoWBX%2FKh36SpxWtBnH=
qfVsY%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Coak.=
zeng%40amd.com%7C34d3cfb6c4ee4969da4e08d909917e2c%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637551342771006509%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w=
LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=
=3D8lNVazYDVOl3ASEqHC%2BxLoWBX%2FKh36SpxWtBnHqfVsY%3D&amp;amp;reserved=3D0<=
/a></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB4488EB63FD9E79897959201FF7419MN2PR12MB4488namp_--

--===============0975494813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0975494813==--
