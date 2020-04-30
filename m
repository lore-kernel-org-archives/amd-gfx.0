Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BEEC8300A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 12:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D5E20775
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 12:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0/7qxFQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D5E20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B9236E8B2;
	Thu, 30 Apr 2020 12:31:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 995616E8B2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 12:31:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLouYKczIPyzBXBf2LFb10RBV2iin/27//PeMbuv7oVbeLM/KJOV8DHB1EJn5JNj2gP+GMZEEOaFKs+mkiCwCS9FyCYytPiNeIwbTHDCO7bjiEuntP98ZnyYSMVkQ8rbVZq/j76zoqFt28muAf/l/nQca98jvrLK3DOtkTqxFCx6PDnlm59a/luSsHD91HnoT/uppJ7GAt5cMUcQkPL5Q/1nfh+4N80GwH6kh/MXkajtlM5+banfF/MJQ4/c6El8GbZ3AjDlcOoMvS60eLwt1m0si9m2nS7o2DWFnvakpHAySAT6gNlHTJUTcGhcqDrL5z5g/kF87VGTQaaaldvzjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqeWB20DwyIiD6onB54FUDzyOcr0J9lgoh1Fp5xD050=;
 b=G5UWV48CeijOMnvzp0S4mcnyl6ZF8/t+sb3oaxgnaKBqDWVAKwt/OezNNOCjQc2q+ZGKsIUd4jAkTbDfl60F/+6n6ZPRYenJa5YtfpFgXL3PohPTubkETwV9ugPXZr2YU+m8Nagh7PXtJk5SwFHGGdBwNASiqju4wyDAzkQ6GcVCeuml8kf0E1DECrJwF3LhCI5iOhWFHkNNlp8SUSk6GE32rQsjoVNtuZ12usTw0MaMPRCzW29yvRPf49MVGDUEaKCduoenuT3HoOlU757d2b0uS1uEUMkNLJhFhVhojALgOk/SqSaqbkl8w/TuTqMJJVIbQHrhhyB5bR8WHwWoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqeWB20DwyIiD6onB54FUDzyOcr0J9lgoh1Fp5xD050=;
 b=0/7qxFQXuVdOru1ZpOMR72et4KRjCkRR+TcYT91Gddmf5W+xGtlWeQeYxRTqh3PwWYSl6j+NiVzilFuLv5Cs9Nsa/Vfx6kdx4A6J3UifSP0GkHjYf1VgclkS1KawJQ/t5Oj3BZhssrt8IpbbaMsb0mv2VXkFCTP6VkSOyFs6Hds=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3577.namprd12.prod.outlook.com (2603:10b6:5:3a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 12:31:00 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 12:31:00 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/4] KFD upstreaming
Thread-Topic: [PATCH 0/4] KFD upstreaming
Thread-Index: AQHWHoKkgjbpYbA2BEipbtx6A9WwVaiRmQEg
Date: Thu, 30 Apr 2020 12:31:00 +0000
Message-ID: <DM6PR12MB3721C196591A6CE969E78CDE85AA0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200430000047.31083-1-Felix.Kuehling@amd.com>
In-Reply-To: <20200430000047.31083-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-30T12:30:59Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f8b7de2c-7a42-4304-b618-00001ef2f509;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-30T12:30:59Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4ca864bc-0b8b-4cc9-b159-0000d6508cee
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1ca0:aecb:d812:3a5e:6edb:851f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a8dffc0-f04f-4760-a192-08d7ed02571c
x-ms-traffictypediagnostic: DM6PR12MB3577:|DM6PR12MB3577:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB35778601B7A1D18F1FA0182C85AA0@DM6PR12MB3577.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 0389EDA07F
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(8676002)(55016002)(7696005)(8936002)(52536014)(86362001)(71200400001)(66476007)(66556008)(110136005)(2906002)(478600001)(33656002)(66446008)(64756008)(76116006)(316002)(966005)(186003)(6506007)(9686003)(53546011)(66946007)(45080400002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ggGsnmljxux/bJYANqQmGWk5dnE7EO4nuNEj98PFaoBWoNKxSKqC77CXVx+ez8iI+HivZFfFru+BI/DgMv9Pg/703wc7sl2hyeGBiBbwSigOtWazP/oXpLbvORSN8AvFlvbe0hi3s6Tz+hzsmzhb2eSq6hrTjjyaYMbCwUxN1P+MaDJ5n6eXQdGyS8xn4qvzgo9TUK89iTPQ+Ua1fobrWPmgknFimeLoUNdm6sChwc6dU1FVE15vhlMGczN2xRrSfKk2ika/TzwBEU1bzZ4Le7z+YLb3WaHVKZny6nCrBevSW88CiNnmyvvnhDK4ZK57h+UWS/x2IHrtx85OuOkBGM3BVkhRrDrHvt3boGBU9ehT02cSG0JAewSAIf6mPdN1gybhnEvhWEEnSin+pQO4xkZJwy1+/8VpG4CJWeQDcbgcwFBW0pgBZo7FqRt125FdQZvPnbF0/9CEkwoSoSo4nrf2PiwLTG5l31iFrbU5FUy6dCQ4a5t2QswynD1uRhqUGM8XPH+URFzykl2lxbGJXA==
x-ms-exchange-antispam-messagedata: cVqBzyyNQ/hDyMylL+bMkpsowHpW95v4WvtGscGUksngePYfnZnVSRE9SQe1DhRdymEgyF6yXgHR0ePxO4pQyo0BX0X1PXKO8PX8HE3NpS40UfNSCh7CO0eXNpFLrtOgOSoKhLnUtQuzg9Xl2X6TeeE+6b6l+ZGPc4oNZNW6keZb2qCX8uio+tRD9UTWrc74EPIrxBr8UdBDD+vq/1OGOwpYFyjY4Zov3FKegw/RpaWBaium/cIzmjWPKv2SxMXgWZPVINPC1VrueSOZZWR6Nek5SIH6Ilhv6b4ueDSArri0y1nEabcohIj5o2iYhFASktYsLUCEoKWeLMkTuHe1WphMqtBBj5EexPdzM1Ba+8/+tN4EzzXq+nbi5trEDiQA3E3xDvnv4d0gQjEVDHNZCG1dNBoOc75emDJnUWhl2hsM5inzUWvnUhLwdUfvRMdUJDn6CzDYdLQ+yjmSD8Nxp2Pdqlh+Q8fyLMyuMqPvBZW+JfG3aBjcLqX0vGxOuQY4pddn/FLAl+DLu3qSWmLb+tzkSAH09P6chgnX9jZOtvIEFLqJb5VUfh5EAIb76JfauuuNFKa/xNOdzzK/t3H9C+kRInvVYdkZAqFpdtBBibPNaYZxPWdVI8NvrcIb5zdcV9nKI9wbcCmMUHjAEYar0DWLJUD2vf6m9gkNhYVqGZ/n1ZIB6VHX2DXqAPGe9dv0izV3jsnnT6wq50eSd/tnARjrMBG042yTNCiSVtB9Id+LZiUX1qf8iEckFt5ZTcFFCfuTdEfXkFtccvjAX/vMg0r5fs5snsSM3cO6msg91Ssiw32we6gnol/mAZ/F883ah792EZ8R9/rKTj7ElFzTnmwsu21pfffIHbshADzFuFFJJ/wtI4Xx4jbCXxftfwSH
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8dffc0-f04f-4760-a192-08d7ed02571c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 12:31:00.2196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDi04eWB4CpOQ6FVGOhDzYLwTxo/cNfn7kITC3+9G6isHLOckcHuizZAQT6z+lTNEipyRjTLaa+TTnxSvCwH5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3577
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

You can add Reviewed-By Kent Russell <kent.russell> for patches 3 and 4 and use them for 1/2 if needed (since they were already reviewed/acked by you or Alex).

 Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix
> Kuehling
> Sent: Wednesday, April 29, 2020 8:01 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: [PATCH 0/4] KFD upstreaming
> 
> A few small patches found during DKMS branch rebasing that were missing
> from amd-staging-drm-next for no good reason.
> 
> Felix Kuehling (2):
>   drm/amdkfd: Fix comment formatting
>   drm/amdgpu: Add missing parameter description in comments
> 
> Oak Zeng (1):
>   drm/amdgpu: Changed CU reservation golden settings
> 
> Ori Messinger (1):
>   drm/amdkfd: Report domain with topology
> 
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c     | 1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c     | 1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c  | 4 ++--
> drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
> drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 +
>  include/uapi/linux/kfd_ioctl.h            | 2 +-
>  7 files changed, 11 insertions(+), 5 deletions(-)
> 
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
> eedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7C04b4185d714a4375
> 46bc08d7ec99a178%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
> 637238017505884390&amp;sdata=eFMYK%2FzJBYAzQz7BOAqmMR1QOhRMe
> nh0KXIEhYsv0bI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
